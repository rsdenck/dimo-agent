# LLD for Windows Services
$services = Get-Service | Select-Object Name, DisplayName, Status, StartType
$lld = @{
    data = $services | ForEach-Object {
        @{
            "{#SERVICE.NAME}" = $_.Name
            "{#SERVICE.DISPLAYNAME}" = $_.DisplayName
            "{#SERVICE.STARTTYPE}" = $_.StartType.ToString()
        }
    }
}
Write-Output ($lld | ConvertTo-Json -Compress)
