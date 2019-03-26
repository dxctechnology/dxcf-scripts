# Temp to test why Encrypted passwords aren't working

$AutomationTextKey = 'Insane2ShareM3'

$Encoder = [System.Text.Encoding]::UTF8
$AutomationKey = $Encoder.GetBytes($AutomationTextKey.PadRight(24))

#####################
$User = 'HLSDomainAdmin'
$Password = '86SvKb4EVdFBTYkDH3B8'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'HLSSystemAdmin'
$Password = '6OqvWJLlvIxZQXB4k503'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'HLSNetworkAdmin'
$Password = 'l36UtmvJbmuH2ZSBE4wK'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'HLSDatabaseAdmin'
$Password = 'DqZmMkq73WZyzfEgmI49'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'HLSOperator'
$Password = 'X60oYUNnG8taSP3D1Wec'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'HLSDeveloper'
$Password = 'LS62DriD01bR4QjIeo5A'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'HLSPowerUser'
$Password = '2ARE1AYAZuTOuCxpQcmE'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'HLSUser'
$Password = 'fYrgvqSU3jgfhy2j1Hox'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'HLSReviewer'
$Password = '5W0WzzkZNeXnqaNDRmXL'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"
