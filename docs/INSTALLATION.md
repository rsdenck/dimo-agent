# Guia de Instalação

> **IMPORTANTE**: Todos os comandos abaixo DEVEM ser executados em um terminal (PowerShell ou CMD) como **Administrador**.

O Dimo Agent foi projetado para ser instalado com zero interação do usuário.

## 1. Instalação via Repositório (Recomendado)

Se o pacote estiver publicado em um servidor NuGet ou no Chocolatey Community:

```powershell
choco install dimo-agent -y
```

## 2. Instalação Local (Offline)

Se você tem o arquivo `.nupkg` localmente:

```powershell
choco install dimo-agent --source="." -y
```

## 3. O que acontece durante a instalação?

O script `chocolateyInstall.ps1` realiza automaticamente:
1. Criação do diretório `C:\Dimo`.
2. Instalação dos binários corretos (x86 ou x64).
3. Configuração do serviço Windows chamado **Dimo**.
4. Registro do serviço para **Início Automático**.
5. Configuração do **Firewall do Windows** (abre porta 10050 TCP).
6. Inicia o serviço e valida se está rodando.

## 4. Desinstalação

Para remover completamente o agente:

```powershell
choco uninstall dimo-agent -y
```
