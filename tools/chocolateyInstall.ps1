$ErrorActionPreference = 'Stop'
$packageName = 'dimo-agent'
$toolsDir = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
$installDir = 'C:\Dimo'

# 1. Estrutura de Diretórios
$dirs = @(
    "$installDir\bin",
    "$installDir\conf\dimo_agentd.d",
    "$installDir\src\lld",
    "$installDir\src\metrics",
    "$installDir\src\maintenance",
    "$installDir\logs",
    "$installDir\cache"
)

foreach ($dir in $dirs) {
    if (!(Test-Path $dir)) {
        New-Item -Path $dir -ItemType Directory -Force
    }
}

# 2. Detecção de Arquitetura e Cópia de Binários
$arch = [Environment]::Is64BitOperatingSystem ? "win64" : "win32"
# Assumindo que os binários estão em content/bin/{win32|win64} no pacote
$packageContent = Join-Path (Split-Path $toolsDir) 'content'

Copy-Item -Path "$packageContent\src\*" -Destination "$installDir\src" -Recurse -Force
Copy-Item -Path "$packageContent\conf\dimo_agentd.conf" -Destination "$installDir\conf" -Force
Copy-Item -Path "$packageContent\conf\dimo_agentd.d\*" -Destination "$installDir\conf\dimo_agentd.d" -Force

# Binários - Renomeando na cópia
$binSource = "$packageContent\bin\$arch"
if (Test-Path $binSource) {
    Copy-Item -Path "$binSource\zabbix_agentd.exe" -Destination "$installDir\bin\dimo_agentd.exe" -Force
    Copy-Item -Path "$binSource\zabbix_sender.exe" -Destination "$installDir\bin\dimo_sender.exe" -Force
    Copy-Item -Path "$binSource\zabbix_get.exe" -Destination "$installDir\bin\dimo_get.exe" -Force
}

# 3. Configuração do Serviço Windows
$serviceName = 'Dimo'
$displayName = 'Dimo Monitoring Agent'
$binPath = "$installDir\bin\dimo_agentd.exe --config $installDir\conf\dimo_agentd.conf"

$existingService = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
if ($existingService) {
    Stop-Service -Name $serviceName -Force -ErrorAction SilentlyContinue
    & sc.exe delete $serviceName
}

& sc.exe create $serviceName binPath= $binPath DisplayName= "$displayName" start= auto
& sc.exe description $serviceName "Agente de monitoramento corporativo Dimo Tech."

# 4. Configuração do Firewall
Write-Host "Configurando Firewall do Windows para porta 10050..."
if (Get-NetFirewallRule -Name "Dimo_Agent_10050" -ErrorAction SilentlyContinue) {
    Remove-NetFirewallRule -Name "Dimo_Agent_10050"
}
New-NetFirewallRule -DisplayName "Dimo Monitoring Agent (TCP-In)" `
    -Name "Dimo_Agent_10050" `
    -Direction Inbound `
    -Action Allow `
    -Protocol TCP `
    -LocalPort 10050 `
    -Enabled True

# 5. Iniciar Serviço
Start-Service -Name $serviceName

# 6. Validação
$status = Get-Service -Name $serviceName
if ($status.Status -ne 'Running') {
    throw "Falha ao iniciar o serviço Dimo Monitoring Agent."
}

Write-Host "Dimo Agent instalado com sucesso em $installDir"
