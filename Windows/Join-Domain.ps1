<#
.Synopsis
    Joins an Instance to the specified Domain.
.Description
    Join-Domain joins an instance to the specified Domain, using supplied Credentials.
.Parameter UserName
    Specifies a user account that has permission to join the computers to a new domain.
    The default is 'Admin'.
.Parameter Password
    Specifies the password for the user account.
.Parameter DomainName
    Specifies the domain to which the computers are added.
.Example
    Configure-Groups -UserName Admin -Password <Password>
    Creates Groups using the default ./Groups.csv file.
.Notes
       Author: Michael Crawford
    Copyright: 2018 by DXC.technology
             : Permission to use is granted but attribution is appreciated
#>
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [string]$UserName = 'Admin',

    [Parameter(Mandatory=$true)]
    [string]$Password,

    [Parameter(Mandatory=$true)]
    [string]$DomainName
)

Write-Host
Write-CloudFormationHost "Joining Computer to Domain $DomainName"

Try {
    $SecurePassword = ConvertTo-SecureString "$Password" -AsPlainText -Force
    $Credential = New-Object System.Management.Automation.PSCredential("$UserName@$DomainName", $SecurePassword)

    Add-Computer -DomainName $DomainName -Credential $Credential -Restart -ErrorAction Stop
    Write-CloudFormationHost "Computer $env:ComputerName joined to Domain $DomainName"
}
Catch {
    $_ | Send-CloudFormationFailure
}

Start-Sleep 1
