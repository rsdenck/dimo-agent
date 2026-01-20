# Documentação Técnica - Dimo Agent

## Visão Geral
O **Dimo Agent** é uma solução de monitoramento para Windows baseada no Zabbix Agent, customizada para a identidade visual e requisitos da Dimo Tech.

## Estrutura de Instalação
- **Diretório Base:** `C:\Dimo\`
- **Binários:** `C:\Dimo\bin\dimo_agentd.exe`
- **Configuração:** `C:\Dimo\conf\dimo_agentd.conf`
- **Scripts Customizados:** `C:\Dimo\src\`

## Pré-requisitos
- Windows 7 SP1+ / Windows Server 2008 R2+
- PowerShell 5.1+
- Chocolatey instalado

## Instalação
Para instalar o agente em um único comando:
```powershell
choco install dimo-agent -y
```

## Métricas Customizadas (UserParameters)
O agente vem pré-configurado com as seguintes chaves de monitoramento:

### 1. Serviços Windows
- `dimo.lld.services`: Descoberta automática de todos os serviços.
- `dimo.lld.ad.services`: Descoberta de serviços críticos do Active Directory.

### 2. Remote Desktop Services (RDS)
- `dimo.lld.rds.users`: Lista usuários logados.
- `dimo.rds.metrics[sessions_active]`: Sessões ativas.
- `dimo.rds.metrics[sessions_disconnected]`: Sessões desconectadas.
- `dimo.rds.metrics[cals_total]`: Total de licenças RDS.
- `dimo.rds.metrics[cals_available]`: Licenças RDS disponíveis.

### 3. Hyper-V
- `dimo.lld.hyperv[hosts]`: Descoberta de hosts.
- `dimo.lld.hyperv[datastores]`: Descoberta de storages.
- `dimo.lld.hyperv[vms]`: Descoberta de máquinas virtuais.
- `dimo.hyperv.vm.metrics[<VMName>,cpu]`: Uso de CPU da VM.
- `dimo.hyperv.vm.metrics[<VMName>,memory]`: Memória assinada (MB).
- `dimo.hyperv.vm.metrics[<VMName>,uptime]`: Uptime em segundos.
- `dimo.hyperv.vm.metrics[<VMName>,status]`: Estado da VM (2=Running, etc).

## Configuração de Rede
- **Porta:** 10050 (TCP Inbound)
- **Servidores Permitidos:** `zproxy.dimo.tech`

## Desinstalação
```powershell
choco uninstall dimo-agent -y
```
