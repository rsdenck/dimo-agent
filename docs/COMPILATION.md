# Guia de Compilação (Build)

Este guia explica como compilar o pacote Chocolatey do Dimo Agent a partir do código-fonte.

## Pré-requisitos
- Windows 10/11 ou Server 2016+
- [Chocolatey CLI](https://chocolatey.org/install) instalado.
- Acesso à internet para baixar os binários base.

## Processo de Build Automático

No diretório raiz do projeto, execute o script de build:

```powershell
./build.ps1
```

O script realizará as seguintes ações:
1. Limpar diretórios de build antigos.
2. Baixar os binários oficiais do Zabbix Agent (LTS).
3. Organizar os binários na estrutura de pastas `win32` e `win64`.
4. Executar o `choco pack` para gerar o arquivo `.nupkg`.

## Processo Manual

Se preferir não usar o script:
1. Navegue até a pasta `dimo-agent/`.
2. Certifique-se de que os binários estão em `content/bin/win32` e `win64`.
3. Execute:
   ```powershell
   choco pack
   ```

O arquivo gerado será algo como `dimo-agent.1.0.0.nupkg`.
