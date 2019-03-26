<#
.Synopsis
    Creates Active Directory Domain Aliases
.Description
    Configure-ADDomainAliases reads a CSV file containing Active Directory Domain Aliases and HostNames
    to create a set of DNS CName records within the DNS zone associated with the Domain Controller where this script is run.
.Parameter UserName
    Specifies a user account that has permission to add aliases to the domain.
    The default is 'Admin'.
.Parameter Password
    Specifies the password for the user account.
.Parameter DomainName
    Specifies the domain for the user account.
.Parameter DomainAliasesPath
    Specifies the path to the Domain Aliases input CSV file.
    The default value is '.\Aliases.csv'.
.Parameter DirectoryService
    Indicates use of the AWS DirectoryService.
.Example
    Configure-ADDomainAliases -UserName Admin -Password <Password> -DomainName <Domain>
    Creates Domain Aliases using the default ./DomainAliases.csv file.
.Example
    Configure-ADDomainAliases -UserName Admin -Password <Password> -DomainName <Domain> -DomainAliasesPath 'C:\cfn\temp\CustomDomainAliases.csv'
    Creates Domain Aliases using a custom CSV file.
.Notes
       Author: Michael Crawford
    Copyright: 2018 by DXC.technology
             : Permission to use is granted but attribution is appreciated
#>
[CmdletBinding()]
Param (
    [Parameter(Mandatory=$false)]
    [string]$UserName = "Admin",

    [Parameter(Mandatory=$true)]
    [string]$Password,

    [Parameter(Mandatory=$true)]
    [string]$DomainName,

    [Parameter(Mandatory=$false)]
    [string]$DomainAliasesPath = ".\DomainAliases.csv",

    [switch]$DirectoryService
)

Try {
    $SecurePassword = ConvertTo-SecureString -String "$Password" -AsPlainText -Force
    $Credential = New-Object System.Management.Automation.PSCredential("$UserName@$DomainName", $SecurePassword)

    $DistinguishedName = (Get-ADDomain -Current LocalComputer -Credential $Credential).DistinguishedName
    $DNSRoot = (Get-ADDomain -Current LocalComputer -Credential $Credential).DNSRoot
    $NetBIOSName = (Get-ADDomain -Current LocalComputer -Credential $Credential).NetBIOSName
    $DomainController = (Get-ADDomainController -Credential $Credential).HostName

    $Aliases = @()
    If (Test-Path $DomainAliasesPath) {
       $Aliases = Import-CSV $DomainAliasesPath
    }
    Else {
       Throw  "-DomainAliasesPath $DomainAliasesPath is invalid."
    }

    Write-Host
    Write-CloudFormationHost "Adding Domain Aliases"

    ForEach ($Alias In $Aliases) {
        Try {
            If (Get-DnsServerResourceRecord -RRType "CName" -Name $($Alias.Alias) -ZoneName $DNSRoot -ErrorAction "SilentlyContinue") {
                Write-Verbose "Alias $($Alias.Alias) exists"
            }
            Else {
                Write-Verbose "Alias $($Alias.Alias) does not exist"
                If ($($Alias.HostName -match '.+?\\$')) {
                    $HostNameAlias = $($Alias.HostName).$($DNSRoot)
                }

                Add-DnsServerResourceRecordCName -Name $($Alias.Alias) `
                                                 -HostNameAlias "$($Alias.HostName).$($DNSRoot)" `
                                                 -ZoneName $DNSRoot
                Write-CloudFormationHost "Alias $($Alias.Alias) -> $($Alias.HostName).$($DNSRoot) created"
            }
        }
        Catch {
            Write-CloudFormationWarning "Alias $($Alias.Alias) could not be created, Error: $($_.Exception.Message)"
        }
    }
}
Catch {
    $_ | Send-CloudFormationFailure
}

Start-Sleep 1
