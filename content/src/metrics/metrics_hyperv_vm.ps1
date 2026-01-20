# Hyper-V VM Metrics
param(
    [Parameter(Mandatory=$true)]
    [string]$VMName,
    [Parameter(Mandatory=$true)]
    [string]$Metric
)

if (!(Get-Module -ListAvailable Hyper-V)) {
    Write-Output 0
    exit
}

$vm = Get-VM -Name $VMName -ErrorAction SilentlyContinue
if (!$vm) {
    Write-Output 0
    exit
}

switch ($Metric) {
    "cpu" {
        $perf = Get-Counter "\Hyper-V Hypervisor Virtual Processor($VMName:Hv VP 0)\% Total Run Time" -ErrorAction SilentlyContinue
        Write-Output ($perf ? [math]::Round($perf.CounterSamples[0].CookedValue, 2) : 0)
    }
    "memory" {
        Write-Output [math]::Round($vm.MemoryAssigned / 1MB, 2)
    }
    "uptime" {
        Write-Output [math]::Round($vm.Uptime.TotalSeconds, 0)
    }
    "status" {
        Write-Output $vm.State.value__
    }
    default {
        Write-Output 0
    }
}
