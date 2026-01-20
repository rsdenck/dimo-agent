# LLD for RDS Logged Users
$sessions = query user 2>$null
if ($null -eq $sessions) {
    Write-Output '{"data":[]}'
    exit
}

$users = $sessions | Select-Object -Skip 1 | ForEach-Object {
    $line = $_.Trim() -split "\s+"
    if ($line.Count -ge 1) {
        @{
            "{#RDS.USERNAME}" = $line[0]
        }
    }
}

$lld = @{
    data = $users
}
Write-Output ($lld | ConvertTo-Json -Compress)
