<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
    <settings pass="windowsPE">
        <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-International-Core-WinPE" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
        <!-- https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-international-core-winpe -->
            <SetupUILanguage>
                <UILanguage>en-US</UILanguage>
            </SetupUILanguage>
            <InputLocale>en-US</InputLocale>
            <SystemLocale>en-US</SystemLocale>
            <UILanguage>en-US</UILanguage>
            <UILanguageFallback>en-US</UILanguageFallback>
            <UserLocale>en-US</UserLocale>
        </component>
        <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-PnpCustomizationsWinPE" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
         <DriverPaths>
            <PathAndCredentials wcm:action="add" wcm:keyValue="1">
               <Path>E:\Program Files\VMware\VMware Tools\Drivers\pvscsi\Win8\amd64</Path>
            </PathAndCredentials>
         </DriverPaths>
      </component>
        <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
        <!-- https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-setup -->
         <DiskConfiguration>
            <Disk wcm:action="add">
               <DiskID>0</DiskID>
               <WillWipeDisk>true</WillWipeDisk>
               <CreatePartitions>
                  <!-- Windows RE Tools partition -->
                  <CreatePartition wcm:action="add">
                     <Order>1</Order>
                     <Type>Primary</Type>
                     <Size>300</Size>
                  </CreatePartition>
                  <!-- System partition (ESP) -->
                  <CreatePartition wcm:action="add">
                     <Order>2</Order>
                     <Type>EFI</Type>
                     <Size>100</Size>
                  </CreatePartition>
                  <!-- Microsoft reserved partition (MSR) -->
                  <CreatePartition wcm:action="add">
                     <Order>3</Order>
                     <Type>MSR</Type>
                     <Size>128</Size>
                  </CreatePartition>
                  <!-- Windows partition -->
                  <CreatePartition wcm:action="add">
                     <Order>4</Order>
                     <Type>Primary</Type>
                     <Extend>true</Extend>
                  </CreatePartition>
               </CreatePartitions>
               <ModifyPartitions>
                  <!-- Windows RE Tools partition -->
                  <ModifyPartition wcm:action="add">
                     <Order>1</Order>
                     <PartitionID>1</PartitionID>
                     <Label>WINRE</Label>
                     <Format>NTFS</Format>
                     <TypeID>DE94BBA4-06D1-4D40-A16A-BFD50179D6AC</TypeID>
                  </ModifyPartition>
                  <!-- System partition (ESP) -->
                  <ModifyPartition wcm:action="add">
                     <Order>2</Order>
                     <PartitionID>2</PartitionID>
                     <Label>System</Label>
                     <Format>FAT32</Format>
                  </ModifyPartition>
                  <!-- MSR partition does not need to be modified -->
                  <ModifyPartition wcm:action="add">
                     <Order>3</Order>
                     <PartitionID>3</PartitionID>
                  </ModifyPartition>
                  <!-- Windows partition -->
                  <ModifyPartition wcm:action="add">
                     <Order>4</Order>
                     <PartitionID>4</PartitionID>
                     <Label>OS</Label>
                     <Letter>C</Letter>
                     <Format>NTFS</Format>
                  </ModifyPartition>
               </ModifyPartitions>
            </Disk>
         </DiskConfiguration>
            <ImageInstall>
                <OSImage>
                    <InstallFrom>
                    <!-- https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-setup-imageinstall-dataimage-installfrom-metadata-key -->
                    <!-- Get-WindowsImage -ImagePath D:\sources\install.wim -->
                        <MetaData wcm:action="add">
                            <Key>/IMAGE/INDEX </Key>
                            <Value>${image_index}</Value>
                        </MetaData>
                    </InstallFrom>
                    <InstallTo>
                        <DiskID>0</DiskID>
                        <PartitionID>4</PartitionID>
                    </InstallTo>
                </OSImage>
            </ImageInstall>
            <UserData>
                <!-- Product Key from http://technet.microsoft.com/en-us/library/jj612867.aspx -->
                <ProductKey>
                    <!-- Do not uncomment the Key element if you are using trial ISOs -->
                    <!-- You must uncomment the Key element (and optionally insert your own key) if you are using retail or volume license ISOs -->
                    <Key>${product_key}</Key>
                    <WillShowUI>OnError</WillShowUI>
                </ProductKey>
                <AcceptEula>true</AcceptEula>
                <FullName>${local_admin_username}</FullName>
            </UserData>
        </component>
    </settings>
    <settings pass="specialize">
        <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-International-Core" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
        <!-- https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-international-core -->
            <InputLocale>en-US</InputLocale>
            <SystemLocale>en-US</SystemLocale>
            <UILanguage>en-US</UILanguage>
            <UILanguageFallback>en-US</UILanguageFallback>
            <UserLocale>en-US</UserLocale>
        </component>
        <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
        <!-- https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-shell-setup -->
<!--             <ComputerName></ComputerName> -->
            <TimeZone>Central Standard Time</TimeZone>
        </component>
        <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-ServerManager-SvrMgrNc" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
        <!-- https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-servermanager-svrmgrnc -->
            <DoNotOpenServerManagerAtLogon>true</DoNotOpenServerManagerAtLogon>
        </component>
        <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-IE-ESC" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
        <!-- https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-ie-esc -->
            <IEHardenAdmin>false</IEHardenAdmin>
            <IEHardenUser>true</IEHardenUser>
        </component>
        <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-OutOfBoxExperience" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
        <!-- https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-outofboxexperience -->
            <DoNotOpenInitialConfigurationTasksAtLogon>true</DoNotOpenInitialConfigurationTasksAtLogon>
        </component>
        <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-Security-SPP-UX" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
        <!-- https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-security-spp-ux -->
            <SkipAutoActivation>true</SkipAutoActivation>
        </component>
    </settings>
    <settings pass="oobeSystem">
        <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
        <!-- https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-shell-setup -->
            <AutoLogon>
                <Password>
                    <Value>${local_admin_password}</Value>
                    <PlainText>true</PlainText>
                </Password>
                <Enabled>true</Enabled>
                <Username>${local_admin_username}</Username>
            </AutoLogon>
            <FirstLogonCommands>
            <SynchronousCommand wcm:action="add">
                <CommandLine>%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force"</CommandLine>
                <Description>Set Execution Policy 64-Bit</Description>
                <Order>1</Order>
                <RequiresUserInput>true</RequiresUserInput>
            </SynchronousCommand>
            <SynchronousCommand wcm:action="add">
                <CommandLine>%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force"</CommandLine>
                <Description>Set Execution Policy 32-Bit</Description>
                <Order>2</Order>
                <RequiresUserInput>true</RequiresUserInput>
            </SynchronousCommand>
            <SynchronousCommand wcm:action="add">
                <CommandLine>%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -File A:\windows-vmtools.ps1</CommandLine>
                <Order>3</Order>
                <Description>Install VMware Tools</Description>
            </SynchronousCommand>
            <SynchronousCommand wcm:action="add">
                <CommandLine>%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -File A:\windows-init.ps1</CommandLine>
                <Order>4</Order>
                <Description>Initial Configuration</Description>
            </SynchronousCommand>
            </FirstLogonCommands>
            <OOBE>
                <HideEULAPage>true</HideEULAPage>
                <HideLocalAccountScreen>true</HideLocalAccountScreen>
                <HideOEMRegistrationScreen>true</HideOEMRegistrationScreen>
                <HideOnlineAccountScreens>true</HideOnlineAccountScreens>
                <HideWirelessSetupInOOBE>true</HideWirelessSetupInOOBE>
                <NetworkLocation>Home</NetworkLocation>
                <ProtectYourPC>1</ProtectYourPC>
            </OOBE>
            <UserAccounts>
                <AdministratorPassword>
                    <Value>${local_admin_password}</Value>
                    <PlainText>true</PlainText>
                </AdministratorPassword>
            </UserAccounts>
            <RegisteredOwner/>
        </component>
    </settings>
    <settings pass="offlineServicing">
        <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-LUA-Settings" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
        <!-- https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-lua-settings -->
            <EnableLUA>false</EnableLUA>
        </component>
    </settings>
    <cpi:offlineImage xmlns:cpi="urn:schemas-microsoft-com:cpi" cpi:source=""/>
</unattend>