# LLD for Critical Active Directory Services
$criticalServices = @("ADWS", "DFS", "DFSR", "DNS", "IsmServ", "Kdc", "LanmanWorkstation", "Netlogon", "SamSs", "TrkWks", "W32Time")
$services = Get-Service | Where-Object { $criticalServices -contains $_.Name }

$lld = @{
    data = $services | ForEach-Object {
        @{
            "{#AD.SERVICE.NAME}" = $_.Name
            "{#AD.SERVICE.DISPLAYNAME}" = $_.DisplayName
        }
    }
}
Write-Output ($lld | ConvertTo-Json -Compress)
