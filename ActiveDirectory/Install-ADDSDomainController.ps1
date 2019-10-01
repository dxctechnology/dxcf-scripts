<#
.Synopsis
    Installs a Domain Controller in an existing Active Directory Domain
.Description
    Install-ADDSDomainController installs an Active Directory Domain Controller to an existing Domain.
    This exists as a separate script mainly so we can obtain Secrets via SecretsManager, as that is
    not currently possible directly within cfn-init logic.
.Parameter DomainName
    Specifies the domain to which the controller is added
.Parameter UserName
    Specifies a user account that has permission to add domain controllers to an existing domain.
    The default is 'Admin'.
.Parameter PasswordSecretId
    Specifies the Id of a SecretsManager Secret containing the Password for the user account.
.Parameter Password
    Specifies the password for the user account.
    Avoid using this method if possible - it's more secure to have SecretsManager create and store the password.
.Parameter SafeModePasswordSecretId
    Specifies the Id of a SecretsManager Secret containing the Safe Mode Administrator Password.
.Parameter SafeModePassword
    Specifies the Safe Mode Administrator Password.
    Avoid using this method if possible - it's more secure to have SecretsManager create and store the password.
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
    [string]$Password = "",

    [Parameter(Mandatory=$false)]
    [string]$SafeModePasswordSecretId = "",

    [Parameter(Mandatory=$false)]
    [string]$SafeModePassword = ""
)

Write-Host
Write-CloudFormationHost "Adding Domain Controller to Domain $DomainName"

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

    If ($SafeModePasswordSecretId) {
      $SafeModePassword = Get-SECSecretValue -SecretId $SafeModePasswordSecretId | Select -ExpandProperty SecretString
    }

    If (-Not $SafeModePassword) {
      Throw "SafeModePassword not found"
    }

    $SecureSafeModePassword = ConvertTo-SecureString "$SafeModePassword" -AsPlainText -Force

    Install-ADDSDomainController -InstallDns -Confirm:$false -Force `
                                 -DomainName $DomainName -Credential $Credential `
                                 -SafeModeAdministratorPassword $SecureSafeModePassword
    Write-CloudFormationHost "Domain Controller $env:ComputerName added to Domain $DomainName"
}
Catch {
    $_ | Send-CloudFormationFailure
}

Start-Sleep 1
