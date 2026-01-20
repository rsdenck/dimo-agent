$ErrorActionPreference = 'Continue'
$serviceName = 'Dimo'
$installDir = 'C:\Dimo'

# 1. Parar e Remover Serviço
Write-Host "Removendo serviço $serviceName..."
Stop-Service -Name $serviceName -Force -ErrorAction SilentlyContinue
& sc.exe delete $serviceName

# 2. Remover Regra de Firewall
Write-Host "Removendo regra de firewall..."
Remove-NetFirewallRule -Name "Dimo_Agent_10050" -ErrorAction SilentlyContinue

# 3. Remover Arquivos (Opcional - Chocolatey costuma manter dados de logs/conf a menos que forçado)
# Por segurança em desinstalação enterprise, removemos binários mas podemos manter logs/conf se desejado.
# Aqui removeremos tudo conforme solicitado para uma desinstalação limpa.
if (Test-Path $installDir) {
    Write-Host "Removendo diretório $installDir..."
    Remove-Item -Path $installDir -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host "Dimo Agent desinstalado com sucesso."
