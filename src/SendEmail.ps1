param(
    [string]$email, 
    [string]$body,
    [string]$subject
)

$credPath= "$HOME\emailCred.xml"

if( -not (Test-Path $credPath)){
    Write-Host "Credential file not found at $credPath, Please run 'EncryptPassword.ps1'"
    exit 1
}

$cred = Import-Clixml -Path $credPath

function Send-ToEmail([string]$email, [string]$body, [string]$subject, [pscredential]$cred){
    $message = New-Object Net.Mail.MailMessage
    $message.From = $cred.Username
    $message.To.Add($email)
    $message.Subject = $subject
    $message.Body = $body

    $smtp = New-Object Net.Mail.SmtpClinet("smtp.gmail.com", 587)
    # or if you are using a outlook account it should be 'smtp.office365.com' 

    $smtp.EnableSSL = $true
    $smtp.Credential = New-Object System.Net.NetworkCredential(
        $cred.Username,
        $cred.GetNetworkCredential().Password
    )

    try{
        $smtp.send($message)
        Write-Host "=== Mail Sent ==="
    } catch {
        Write-Error "Failed to send Email, exited with error: $_"
    }
}

if($email -and $body -and $subject){
    Send-ToEmail -email $email -body $body -subject $subject -cred $cred
} else {
    Write-Host "Missing arguments. Please provide email, subject, body"
}