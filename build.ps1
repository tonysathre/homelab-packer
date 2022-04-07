#Requires -Version 7
using namespace System.Management.Automation

param (
    [Parameter(Mandatory, ParameterSetName = 'DomainControllers')]
    [switch]$DomainControllers,

    [Parameter(Mandatory, ParameterSetName = 'TerraformRefresh')]
    [switch]$TerraformRefresh,

    [Parameter(Mandatory, ParameterSetName = 'Packer')]
    [switch]$Packer,

    [Parameter(Mandatory, ParameterSetName = 'Packer')]
    [ValidateSet('windows-server', 'linux-server')]
    [string]$OSFamily,

    [Parameter(Mandatory, ParameterSetName = 'Packer')]
    [ArgumentCompleter({
            param ( $commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters )
            $WindowsOptions = @('standard-core', 'standard-gui', 'datacenter-core', 'datacenter-gui')
            $LinuxOptions = @('ubuntu')
            switch ($fakeBoundParameters.Values) {
                'windows-server' {
                    $WindowsOptions.Where({ $_ -like "$wordToComplete*" }) | ForEach-Object {
                        [CompletionResult]::new($_, $_, 'ParameterValue', $_)
                    }
                }

                'linux-server' {
                    $LinuxOptions.Where({ $_ -like "$wordToComplete*" }) | ForEach-Object {
                        [CompletionResult]::new($_, $_, 'ParameterValue', $_)
                    }
                }
            }
        })]
    [string]$Build,

    [Parameter(Mandatory, ParameterSetName = 'Packer')]
    [ArgumentCompleter({
            param ( $commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters )
            $WindowsOptions = @('2022')
            $LinuxOptions = @('20.04')
            switch ($fakeBoundParameters.Values) {
                'windows-server' {
                    $WindowsOptions.Where({ $_ -like "$wordToComplete*" }) | ForEach-Object {
                        [CompletionResult]::new($_, $_, 'ParameterValue', $_)
                    }
                }

                'linux-server' {
                    $LinuxOptions.Where({ $_ -like "$wordToComplete*" }) | ForEach-Object {
                        [CompletionResult]::new($_, $_, 'ParameterValue', $_)
                    }
                }
            }
        })]
    [string]$OSVersion,

    [Parameter(ParameterSetName = 'Packer')]
    [string]$PackerAdditionalArgs
)

function Build-Windows {
    switch ($Build) {
        'standard-core' { $ImageIndex = 1 }
        'standard-gui' { $ImageIndex = 2 }
        'datacenter-core' { $ImageIndex = 3 }
        'datacenter-gui' { $ImageIndex = 4 }
    }

    $PackerRoot = "$PSScriptRoot/packer/windows/server/$OSVersion/"

    packer init $PackerRoot

    packer validate `
        -only="vsphere-iso.$OSFamily-$OSVersion-$Build" `
        -var "image_type=$Build" `
        -var "os_version=$OSVersion" `
        -var "image_index=$ImageIndex" `
        $PackerRoot

    if ($LASTEXITCODE -eq 0) {
        packer build -force `
            -timestamp-ui `
            -only=vsphere-iso.$OSFamily-$OSVersion-$Build `
            -var "image_type=$Build" `
            -var "os_version=$OSVersion" `
            -var "image_index=$ImageIndex" `
            $PackerRoot
    }
}

function Build-Linux {
    $PackerRoot = "$PSScriptRoot/packer/linux/$Build/$OSVersion/"

    packer init $PackerRoot
    packer validate $PackerRoot

    if ($LASTEXITCODE -eq 0) {
        packer build $PackerAdditionalArgs -force -timestamp-ui $PackerRoot
    }
}

function Build-DomainControllers {
    $TerraformRoot = (Join-Path -Path $PSScriptRoot -ChildPath 'terraform' -AdditionalChildPath 'windows\domain-controllers')
    if ($TerraformRefresh) {
        terraform -chdir="$TerraformRoot" apply -refresh-only
        return
    }

    terraform -chdir="$TerraformRoot" init
    terraform -chdir="$TerraformRoot" apply -auto-approve
}

if ($DomainControllers) {
    Build-DomainControllers
}

if ($Packer) {
    if ($PSBoundParameters.Values.Contains('windows-server')) {
        Build-Windows
    }
    else {
        Build-Linux
    }
}