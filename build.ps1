# Dimo Agent Build Script
# Este script prepara a estrutura e gera o pacote .nupkg

$buildDir = "dist"
if (Test-Path $buildDir) { Remove-Item $buildDir -Recurse -Force }
New-Item -Path $buildDir -ItemType Directory

# 1. Validar binários
$win64Bin = "dimo-agent\content\bin\win64\zabbix_agentd.exe"
$win32Bin = "dimo-agent\content\bin\win32\zabbix_agentd.exe"

if (!(Test-Path $win64Bin) -or !(Test-Path $win32Bin)) {
    Write-Warning "Binários do Zabbix Agent não encontrados em dimo-agent\content\bin\{win32|win64}\"
    Write-Host "Por favor, baixe os binários oficiais do Zabbix e coloque-os nas pastas mencionadas antes de rodar o build."
    exit
}

# 2. Gerar Pacote Chocolatey
Set-Location "dimo-agent"
choco pack
Move-Item "*.nupkg" "..\\$buildDir"
Set-Location ".."

Write-Host "Build concluído! O pacote está em: $buildDir" -ForegroundColor Green
