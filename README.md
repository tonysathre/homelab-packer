# Automation for my homelab


## Packer Templates for VMware vSphere

### Build VMware vSphere Template

```powershell
build.ps1 [-OSFamily] <string> [-Build] <string> [-OSVersion] <string> [-Force]
```

### Arguments

| OSFamily | Build | OSVersion |
|----------|-------|-----------|
| windows-server | standard-core, standard-gui, datacenter-core, datacenter-gui | 2022 |

### Example
```bash
build.ps1 windows-server datacenter-core 2022
```