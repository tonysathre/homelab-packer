# Packer Templates for VMware vSphere

## Build Template

```powershell
.\build.ps1 -OSFamily <string> -Build <string> -OSVersion <string> [-AdditionalArgs <string>] [<CommonParameters>]
```

### Arguments

| OSFamily | Build | OSVersion |
|----------|-------|-----------|
| windows-server | standard-core, standard-gui, datacenter-core, datacenter-gui | 2022 |
| linux-server | ubuntu | 20.04 |

### Examples
```powershell
.\build.ps1 -Packer -OSFamily linux-server -Build ubuntu -OSVersion 20.04
.\build.ps1 -Packer -OSFamily windows-server -Build standard-core -OSVersion 2022 -AdditionalArgs '-on-error=ask'
```
