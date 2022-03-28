param (
    [Parameter(Mandatory)]
    [ArgumentCompletions('windows-server')]
    [string]$OSFamily,

    [Parameter(Mandatory)]
    [ArgumentCompletions('standard-core', 'standard-gui', 'datacenter-core', 'datacenter-gui')]
    [string]$Build,

    [Parameter(Mandatory)]
    [ArgumentCompletions('2022')]
    [string]$OSVersion,

    [Parameter()]
    [switch]$Force = $false
)

switch ($Build) {
    'standard-core'   { $ImageIndex = 1 }
    'standard-gui'    { $ImageIndex = 2 }
    'datacenter-core' { $ImageIndex = 3 }
    'datacenter-gui'  { $ImageIndex = 4 }
}

packer validate `
    -only="vsphere-iso.$OSFamily-$OSVersion-$Build" `
    -var "image_type=$Build" `
    -var "os_version=$OSVersion" `
    -var "image_index=$ImageIndex" `
    "$PSScriptRoot\packer\windows\server\$OSVersion\"

if ($LASTEXITCODE -eq 0) {
    packer build `
        -only="vsphere-iso.$OSFamily-$OSVersion-$Build" `
        -color=true `
        -timestamp-ui `
        -var "image_type=$Build" `
        -var "os_version=$OSVersion" `
        -var "image_index=$ImageIndex" `
        "$PSScriptRoot\packer\windows\server\$OSVersion\"
}