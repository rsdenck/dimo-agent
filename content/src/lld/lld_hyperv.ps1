# LLD for Hyper-V
param(
    [Parameter(Mandatory=$true)]
    [string]$Type
)

if (!(Get-Module -ListAvailable Hyper-V)) {
    Write-Output '{"data":[]}'
    exit
}

switch ($Type) {
    "hosts" {
        $hosts = Get-VMHost
        $lld = @{ data = $hosts | ForEach-Object { @{"{#HYPERV.HOST}" = $_.Name} } }
    }
    "datastores" {
        $vhdPaths = Get-VM | Get-VMHardDiskDrive | Select-Object -ExpandProperty Path
        $volumes = $vhdPaths | ForEach-Object { Split-Path $_ -Parent } | Select-Object -Unique
        $lld = @{ data = $volumes | ForEach-Object { @{"{#HYPERV.DATASTORE}" = $_} } }
    }
    "vms" {
        $vms = Get-VM
        $lld = @{ data = $vms | ForEach-Object { @{"{#HYPERV.VM.NAME}" = $_.Name; "{#HYPERV.VM.ID}" = $_.Id.ToString()} } }
    }
}

Write-Output ($lld | ConvertTo-Json -Compress)
