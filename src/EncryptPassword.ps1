$user = "YourFancyUserName"
$password = "YourVerySecurePassword"

$securePass = ConvertTo-SecureString $password -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential($user, $securePass)

$cred | Export-Clixml -Path "$HOME\emailCred.xml"