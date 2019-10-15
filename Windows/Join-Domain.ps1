<#
.Synopsis
    Joins an Instance to the specified Domain.
.Description
    Join-Domain joins an instance to the specified Domain, using supplied Credentials.
.Parameter DomainName
    Specifies the domain to which the computers are added.
.Parameter UserName
    Specifies a user account that has permission to join the computers to a new domain.
    The default is 'Admin'.
.Parameter PasswordSecretId
    Specifies the Id of a SecretsManager Secret containing the Password for the user account.
.Parameter Password
    Specifies the password for the user account.
    Avoid using this method if possible - it's more secure to have SecretsManager create and store the password.
.Example
    Configure-Groups -DomainName m1.dxc-ap.com `
                     -UserName Admin -PasswordSecretId Production-DirectoryService-AdminPassword
    Creates Groups using the default ./Groups.csv file using a password stored in SecretsManager.
.Example
    Configure-Groups -DomainName m1.dxc-ap.com `
                     -UserName Admin -Password <Password>
    Creates Groups using the default ./Groups.csv file using an explicitly passed password.
.Notes
       Author: Michael Crawford
    Copyright: 2019 by DXC.technology
             : Permission to use is granted but attribution is appreciated
#>
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [string]$DomainName,

    [Parameter(Mandatory=$false)]
    [string]$UserName = "Admin",

    [Parameter(Mandatory=$false)]
    [string]$PasswordSecretId = "",

    [Parameter(Mandatory=$false)]
    [string]$Password = ""
)

Write-Host
Write-CloudFormationHost "Joining Computer to Domain $DomainName"

Try {
    $ErrorActionPreference = "Stop"

    If ($PasswordSecretId) {
      $Password = Get-SECSecretValue -SecretId $PasswordSecretId | Select -ExpandProperty SecretString
    }

    If (-Not $Password) {
      Throw "Password not found"
    }

    $SecurePassword = ConvertTo-SecureString "$Password" -AsPlainText -Force
    $Credential = New-Object System.Management.Automation.PSCredential("$UserName@$DomainName", $SecurePassword)

    Add-Computer -DomainName $DomainName -Credential $Credential -ErrorAction Stop
    Write-CloudFormationHost "Computer $env:ComputerName joined to Domain $DomainName, restarting..."

    Restart-Computer
}
Catch {
    $_ | Send-CloudFormationFailure
}

Start-Sleep 1
