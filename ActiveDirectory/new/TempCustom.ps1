# Temp to test why Encrypted passwords aren't working

$AutomationTextKey = 'Insane2ShareM3'

$Encoder = [System.Text.Encoding]::UTF8
$AutomationKey = $Encoder.GetBytes($AutomationTextKey.PadRight(24))

#####################
$User = 'OpenVPN'
$Password = 'PleaseLockTheGate7777'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'MCrawford'
$Password = 'StoneFountain1742'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'PStAmand'
$Password = 'PatioSlumber2929'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'IJoelPitcher'
$Password = 'ChampionDistress4848'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'YKumar'
$Password = 'BermudaCarhop9021'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'DMcCue'
$Password = 'ThievingMarkup7755'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'MHelenius'
$Password = 'CauldronMouthful3131'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'BSlook'
$Password = 'TyphoonLenient1379'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'DLondon'
$Password = 'WildfirePrank2468'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'MPagnis'
$Password = 'ManilaSailing2299'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'VMatukumalli'
$Password = 'PatriotAcrobat9021'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'SRamalingam'
$Password = 'QuashSeveral1263'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'LCui'
$Password = 'ArtfulCucumber8733'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'MGolawski'
$Password = 'ProphetOptimal4554'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'RRoslon'
$Password = 'EulogyUproot3219'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'KRyzner'
$Password = 'PhobiaPerfectly8398'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'MTaranek'
$Password = 'CharitySteam1155'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"

#####################
$User = 'ASchick'
$Password = 'TiresomeJoystick3232'
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

$AutomationEncryptedPassword = ConvertFrom-SecureString $SecurePassword -Key $AutomationKey
$AutomationEncryptedPassword | Out-File "$([Environment]::GetFolderPath('Desktop'))\$($User)-AutomationEncryptedPassword.txt"
