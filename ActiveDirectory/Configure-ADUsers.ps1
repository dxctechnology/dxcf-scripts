<#
.Synopsis
    Creates Active Directory Users, and optionally adds them to Groups.
.Description
    Configure-Users reads a CSV file containing Active Directory Users to create a set of users
    within the Users container in Active Directory. This command can create groups within the AWS
    Directory Service (which stores them in an OU), by specifying a Switch.
    Users can optionally be added to additional groups.
.Parameter DomainName
    Specifies the domain for the user account.
.Parameter UserName
    Specifies a user account that has permission to add users to the domain.
    The default is 'Admin'.
.Parameter PasswordSecretId
    Specifies the Id of a SecretsManager Secret containing the Password for the user account.
.Parameter Password
    Specifies the password for the user account.
    Avoid using this method if possible - it's more secure to have SecretsManager create and store the password.
.Parameter EncryptionKeySecretId
    Specifies the Id of a SecretsManager Secret containing the encryption key used to encrypt user passwords in the CSV file.
.Parameter EncryptionKey
    Specifies the encryption key used to encrypt user passwords in the CSV file.
    Avoid using this method if possible - it's more secure to have SecretsManager store the encryption key.
.Parameter UsersPath
    Specifies the path to the Users input CSV file.
    The default value is '.\Users.csv'.
.Parameter DirectoryService
    Indicates use of the AWS DirectoryService.
    This creates Users in the correct OU.
.Example
    Configure-Users -DomainName m1.dxc-ap.com `
                    -PasswordSecretId Production-DirectoryService-AdminPassword `
                    -EncryptionKeySecretId Production-DirectoryService-EncryptionKey
    Creates Users using the default ./Users.csv file using a password stored in SecretsManager.
.Example
    Configure-Users -DomainName m1.dxc-ap.com `
                    -UserName Admin -Password <Password> -EncryptionKey <Key> `
                    -UsersPath 'C:\cfn\temp\CustomUsers.csv'
    Creates Users using a custom CSV file using an explicitly passed password.
.Example
    Configure-Users -DomainName m1.dxc-ap.com `
                    -PasswordSecretId Production-DirectoryService-AdminPassword `
                    -EncryptionKeySecretId Production-DirectoryService-EncryptionKey `
                    -UsersPath 'C:\cfn\temp\CustomUsers.csv' `
                    -DirectoryService
    Creates Users using a custom CSV file in the OU required by the AWS DirectoryService using a password stored in SecretsManager.
.Notes
       Author: Michael Crawford
    Copyright: 2019 by DXC.technology
             : Permission to use is granted but attribution is appreciated

    This command assumes it will be run on a computer joined to the domain.
#>
[CmdletBinding()]
Param (
    [Parameter(Mandatory=$true)]
    [string]$DomainName,

    [Parameter(Mandatory=$false)]
    [string]$UserName = "Admin",

    [Parameter(Mandatory=$false)]
    [string]$PasswordSecretId = "",

    [Parameter(Mandatory=$false)]
    [string]$Password = "",

    [Parameter(Mandatory=$false)]
    [string]$EncryptionKeySecretId = "",

    [Parameter(Mandatory=$false)]
    [string]$EncryptionKey = "",

    [Parameter(Mandatory=$false)]
    [string]$UsersPath = ".\Users.csv",

    [switch]$DirectoryService
)

Try {
    $ErrorActionPreference = "Stop"

    If ($PasswordSecretId) {
      $Password = Get-SECSecretValue -SecretId $PasswordSecretId | Select -ExpandProperty SecretString
    }

    If (-Not $Password) {
      Throw "Password not found"
    }

    $SecurePassword = ConvertTo-SecureString -String "$Password" -AsPlainText -Force
    $Credential = New-Object System.Management.Automation.PSCredential("$UserName@$DomainName", $SecurePassword)

    If ($EncryptionKeySecretId) {
      $EncryptionKey = Get-SECSecretValue -SecretId $EncryptionKeySecretId | Select -ExpandProperty SecretString
    }

    If (-Not $EncryptionKey) {
      Throw "Encryption Key not found"
    }

    # Note: Versions of this script prior to the addition of logic to use SecretsManager used the Password
    #       as the EncryptionKey, so only one known value would have to be passed.
    #       With SecretsManager, we are having that service generate a random string for the Admin user,
    #       so to preserve the ability to pre-encrypt user passwords we had to split up this dual function,
    #       and pass an EncryptionKey which can be known in advance, so we can decrypt the user password
    #       values consistently.
    $Encoder = [System.Text.Encoding]::UTF8
    $Key = $Encoder.GetBytes($EncryptionKey.PadRight(24))

    $DistinguishedName = (Get-ADDomain -Current LocalComputer -Credential $Credential).DistinguishedName
    $DNSRoot = (Get-ADDomain -Current LocalComputer -Credential $Credential).DNSRoot
    $NetBIOSName = (Get-ADDomain -Current LocalComputer -Credential $Credential).NetBIOSName

    $Users = @()
    If (Test-Path $UsersPath) {
        $Users = Import-CSV $UsersPath
    }
    Else {
        Throw  "-UsersPath $UsersPath is invalid."
    }

    if ($DirectoryService) {
        Write-Verbose "Configuring DirectoryService"
        $Path = "OU=Users,OU=$NetBIOSName,$DistinguishedName"
    }
    Else {
        Write-Verbose "Configuring ActiveDirectory"
        $Path = "CN=Users,$DistinguishedName"
    }

    Write-Host
    Write-CloudFormationHost "Adding Users to $Path"

    ForEach ($User In $Users) {
        Try {
            If (Get-ADUser -Filter "SamAccountName -eq '$($User.SamAccountName)'" -Credential $Credential) {
                Write-Verbose "User $($User.Name) exists"
            }
            Else {
                Write-Verbose "User $($User.Name) does not exist"
                $SecurePassword = ConvertTo-SecureString -String "$($User.EncryptedPassword)" -Key $Key
                New-ADUser -Name "$($User.Name)" `
                           -Path $Path `
                           -SamAccountName "$($User.SamAccountName)" `
                           -UserPrincipalName "$($User.SamAccountName)@$DNSRoot" `
                           -GivenName "$($User.GivenName)" `
                           -Surname "$($User.Surname)" `
                           -AccountPassword $SecurePassword `
                           -ChangePasswordAtLogon $([System.Convert]::ToBoolean($User.ChangePasswordAtLogon)) `
                           -CannotChangePassword $([System.Convert]::ToBoolean($User.CannotChangePassword)) `
                           -PasswordNeverExpires $([System.Convert]::ToBoolean($User.PasswordNeverExpires)) `
                           -Enabled $([System.Convert]::ToBoolean($User.Enabled))`
                           -Description "$($User.Description)" `
                           -Credential $Credential
                Write-CloudFormationHost "User $($User.Name) created"
            }
        }
        Catch {
            Write-CloudFormationWarning "User $($User.Name) could not be created, Error: $($_.Exception.Message)"
        }

        if ($($User.Groups)) {
            $UserGroups = ($User.Groups).split(',')
            ForEach ($UserGroup in $UserGroups) {
                Try {
                    Add-ADGroupMember -Identity "$UserGroup" `
                                      -Members "$($User.SamAccountName)" `
                                      -Credential $Credential
                    Write-CloudFormationHost "User $($User.Name) added to Group $UserGroup"
                }
                Catch {
                    Write-CloudFormationWarning "User $($User.Name) could not be added to Group $UserGroup, Error: $($_.Exception.Message)"
                }
            }
        }
    }
}
Catch {
    $_ | Send-CloudFormationFailure
}

Start-Sleep 1
