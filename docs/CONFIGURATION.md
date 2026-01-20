# Configuração e Métricas Customizadas

O Dimo Agent vem pré-configurado para monitoramento avançado de infraestrutura Windows.

## Arquivos de Configuração

- **Principal**: `C:\Dimo\conf\dimo_agentd.conf`
- **Inclusões**: `C:\Dimo\conf\dimo_agentd.d\*.conf`

## Métricas Disponíveis

As métricas são baseadas em scripts PowerShell localizados em `C:\Dimo\src\`.

### Active Directory
- `dimo.lld.ad.services`: Descoberta de serviços DNS, DFS, Kerberos, etc.

### Hyper-V
- `dimo.lld.hyperv[vms]`: Descoberta de máquinas virtuais.
- `dimo.hyperv.vm.metrics[VMNAME, cpu]`: Uso de CPU.
- `dimo.hyperv.vm.metrics[VMNAME, memory]`: Memória em MB.

### Remote Desktop Services (RDS)
- `dimo.lld.rds.users`: Lista usuários conectados.
- `dimo.rds.metrics[sessions_active]`: Contador de sessões ativas.
- `dimo.rds.metrics[cals_total]`: Licenças RDS instaladas.

## Como adicionar novas métricas?

1. Crie um script `.ps1` em `C:\Dimo\src\metrics\`.
2. Adicione uma linha no arquivo `C:\Dimo\conf\dimo_agentd.d\user_parameters.conf`:
   ```conf
   UserParameter=minha.metrica,powershell.exe -File C:\Dimo\src\metrics\meu_script.ps1
   ```
3. Reinicie o serviço Dimo:
   ```powershell
   Restart-Service Dimo
   ```
