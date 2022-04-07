# Automation for my homelab


## Packer Templates for VMware vSphere

### Build VMware vSphere Template

```powershell
.\build.ps1 -Packer -OSFamily <string> -Build <string> -OSVersion <string> [-PackerAdditionalArgs <string>] [<CommonParameters>]
```

### Arguments

| OSFamily | Build | OSVersion |
|----------|-------|-----------|
| windows-server | standard-core, standard-gui, datacenter-core, datacenter-gui | 2022 |
| linux-server | ubuntu | 20.04 |

### Example
```powershell
.\build.ps1 -Packer -OSFamily linux-server -Build ubuntu -OSVersion 20.04
```
