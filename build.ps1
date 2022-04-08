#Requires -Version 7
using namespace System.Management.Automation

param (
    [Parameter(Mandatory)]
    [ValidateSet('windows-server', 'linux-server')]
    [string]$OSFamily,

    [Parameter(Mandatory)]
    [ArgumentCompleter({
            param ( $commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters )
            $WindowsOptions = @('standard-core', 'standard-gui', 'datacenter-core', 'datacenter-gui')
            $LinuxOptions   = @('ubuntu')
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

    [Parameter(Mandatory)]
    [ArgumentCompleter({
            param ( $commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters )
            $WindowsOptions = @('2022')
            $LinuxOptions   = @('20.04')
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

    [Parameter()]
    [string]$PackerAdditionalArgs
)

function Build-Windows {
    switch ($Build) {
        'standard-core'   { $ImageIndex = 1 }
        'standard-gui'    { $ImageIndex = 2 }
        'datacenter-core' { $ImageIndex = 3 }
        'datacenter-gui'  { $ImageIndex = 4 }
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
        packer build $PackerAdditionalArgs -force `
            -timestamp-ui `
            -only="vsphere-iso.$OSFamily-$OSVersion-$Build" `
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

if ($PSBoundParameters.Values.Contains('windows-server')) {
    Build-Windows
} else {
    Build-Linux
}
