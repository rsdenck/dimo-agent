# RDS Metrics (Sessions and CALs)
param(
    [Parameter(Mandatory=$true)]
    [string]$Metric
)

switch ($Metric) {
    "sessions_active" {
        $count = (query user 2>$null | Select-Object -Skip 1 | Where-Object { $_ -match "Ativo|Active" }).Count
        Write-Output ($count -eq $null ? 0 : $count)
    }
    "sessions_disconnected" {
        $count = (query user 2>$null | Select-Object -Skip 1 | Where-Object { $_ -match "Desc|Disc" }).Count
        Write-Output ($count -eq $null ? 0 : $count)
    }
    "cals_total" {
        # Exemplo simplificado, requer privilégios e módulo de licenciamento RDS se quiser precisão total
        try {
            $cals = Get-WmiObject -Class Win32_TSLicenseKeyPack -Namespace "Root\CIMV2" -ErrorAction SilentlyContinue
            $total = ($cals | Measure-Object -Property TotalLicenses -Sum).Sum
            Write-Output ($total -eq $null ? 0 : $total)
        } catch {
            Write-Output 0
        }
    }
    "cals_available" {
        try {
            $cals = Get-WmiObject -Class Win32_TSLicenseKeyPack -Namespace "Root\CIMV2" -ErrorAction SilentlyContinue
            $avail = ($cals | Measure-Object -Property IssuedLicenses -Sum).Sum
            Write-Output ($avail -eq $null ? 0 : $avail)
        } catch {
            Write-Output 0
        }
    }
    default {
        Write-Output 0
    }
}
