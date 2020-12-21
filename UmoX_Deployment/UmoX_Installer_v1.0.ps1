$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$AdminState = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
If ($AdminState -eq $False) {
  $ButtonType = [System.Windows.MessageBoxButton]::OK
  $MessageIcon = [System.Windows.MessageBoxImage]::Warning
  $MessageBoxTitle = "Administrative Rights Warning"
  $MessageBoxBody = "The GUI is not being run as Admin. Click 'OK' to close"
  $Result = [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$messageicon)
  Write-Host "Not running as Admin, closing" -Fore Red
  EXIT
}

$CurrentPath = Split-Path $script:MyInvocation.MyCommand.Path
$pathToJson = "$currentPath\install.TEMPLATE.json"
$pathToUmoIcon = "$currentPath\Images\Enovation.png"
$pathToRedTabIcon = "$currentPath\Images\Red_Tab_Dot.png"
$pathToOrangeTabIcon = "$currentPath\Images\Orange_Tab_Dot.png"
$pathToGreenTabIcon = "$currentPath\Images\Green_Tab_Dot.png"

#-------------------------------------------------------------#
#----Initial Declarations-------------------------------------#
#-------------------------------------------------------------#

Add-Type -AssemblyName PresentationCore, PresentationFramework

$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" Width="700" Height="500" ResizeMode="NoResize" WindowStartupLocation="CenterScreen" Title="UmoX Installer v1.0">
  <Grid>
    <TabControl Margin="0,0,0,0">
      <TabItem>
        <TabItem.Header>
          <StackPanel Orientation="Horizontal">
            <Image Name="dot1" Height="10" Width="10" Source="$pathToRedTabIcon" />
            <TextBlock Text="Main Settings" Margin="2,0,0,0" VerticalAlignment="Center" />
          </StackPanel>
        </TabItem.Header>
        <Grid Background="#FFFFFF">
          <Button Content="Help" HorizontalAlignment="Right" VerticalAlignment="Top" Width="50" Margin="10,10,0,0" Name="Help1" Height="20"/>
          <Image HorizontalAlignment="Right" Height="100" VerticalAlignment="Top" Width="100" Margin="10,40,0,0" Name="Enovation_Logo1" Source="$pathToUmoIcon"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="JSON Config Path:" Margin="10,30,0,0" FontWeight="Bold"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="350" TextWrapping="NoWrap" Margin="10,50,0,0" Name="JsonPathTextBox" Text="$pathToJson" ToolTip="Change the path of the install JSON config, if you have an alternative file you wish to use, otherwise leave as default"/>
          <Button Content="Validate Path" HorizontalAlignment="Left" VerticalAlignment="Top" Width="100" Margin="370,50,0,0" Name="JsonPathValidateButton" Height="20"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="SQL Master Password:" Margin="10,80,0,0" FontWeight="Bold"/>
          <PasswordBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="200" Margin="10,100,0,0" Name="sqlPassword" ToolTip="Enter the password for the SQL SA account"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Firebird Password:" Margin="10,130,0,0" FontWeight="Bold"/>
          <PasswordBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="200" Margin="10,150,0,0" Name="firebirdPassword" ToolTip="Enter the password for the Firebird SYSDBA account"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Installation Drive:" Margin="10,180,0,0" FontWeight="Bold"/>
          <ComboBox HorizontalAlignment="Left" VerticalAlignment="Top" Width="52" Margin="10,200,0,0" AllowDrop="False" Height="20" MaxDropDownHeight="100" Text="" Name="InstallationDriveSelection" IsTextSearchEnabled="True" ToolTip="Select the drive letter being used for the Operating System. Default is C:\\">
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>A:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>B:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>C:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>D:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>E:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>F:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>G:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>H:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>I:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>J:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>K:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>L:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>M:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>N:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>O:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>P:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>Q:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>R:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>S:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>T:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>U:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>V:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>W:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>X:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>Y:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>Z:\</TextBlock> </StackPanel> </ComboBoxItem>
          </ComboBox>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Data Drive:" Margin="10,230,0,0" FontWeight="Bold"/>
          <ComboBox HorizontalAlignment="Left" VerticalAlignment="Top" Width="52" Margin="10,250,0,0" AllowDrop="False" Height="20" MaxDropDownHeight="100" Text="" Name="DataDriveSelection" IsTextSearchEnabled="True" ToolTip="Select the drive letter being used for Data">
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>A:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>B:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>C:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>D:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>E:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>F:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>G:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>H:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>I:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>J:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>K:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>L:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>M:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>N:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>O:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>P:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>Q:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>R:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>S:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>T:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>U:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>V:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>W:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>X:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>Y:\</TextBlock> </StackPanel> </ComboBoxItem>
            <ComboBoxItem> <StackPanel Orientation="Horizontal"> <TextBlock>Z:\</TextBlock> </StackPanel> </ComboBoxItem>
          </ComboBox>
          <Rectangle HorizontalAlignment="Left" VerticalAlignment="Top" Fill="#FFF4F4F5" Stroke="Black" Height="100" Width="540" Margin="5,290,0,0"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Additional Options:" Margin="10,290,0,0" FontWeight="Bold"/>
          <CheckBox HorizontalAlignment="Left" VerticalAlignment="Top" Content="Multi-Tenant?" Margin="10,320,0,0" Name="MultiTenantCheckBox" ToolTip="Tick this box if you need to deploy in 'Multi-Tenant' mode"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Post-Fix Value" Margin="130,310,0,0" Name="PostFixTextLabel" Visibility="Hidden"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="200" TextWrapping="NoWrap" Margin="130,330,0,0" Name="PostFixTextBox" Text="" ToolTip="Enter the name of the customer as the Post-Fix value. No spaces!" Visibility="Hidden"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Customer Specific Password" Margin="340,310,0,0" Name="CustomerPasswordLabel" Visibility="Hidden"/>
          <PasswordBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="200" Margin="340,330,0,0" Name="CustomerPassword" ToolTip="Enter a unique password for the Post-Fix customer" Visibility="Hidden"/>
          <CheckBox HorizontalAlignment="Left" VerticalAlignment="Top" Content="MFA?" Margin="10,360,0,0" Name="MFACheckBox" ToolTip="Tick this box if you need to protect your deployment with MFA"/>
          <CheckBox HorizontalAlignment="Left" VerticalAlignment="Top" Content="RAPI?" Margin="80,360,0,0" Name="RAPICheckBox" ToolTip="Tick this box if you need to install the RAPI"/>
          <CheckBox HorizontalAlignment="Left" VerticalAlignment="Top" Content="POMAS?" Margin="150,360,0,0" Name="POMASCheckBox" ToolTip="Tick this box if you need to install POMAS"/>
          <CheckBox HorizontalAlignment="Left" VerticalAlignment="Top" Content="Force-Mode Install?" Margin="240,360,0,0" Name="ForceCheckBox" ToolTip="Tick this option if you wish to include the Force parameter"/>
          <CheckBox HorizontalAlignment="Left" VerticalAlignment="Top" Content="NoBackup-Mode Install?" Margin="390,360,0,0" Name="NoBackupCheckBox" ToolTip="Tick this option if you wish to include the NoBackup parameter"/>
          <Button Content="Apply" HorizontalAlignment="Right" VerticalAlignment="Bottom" Width="80" Margin="0,0,10,10" Name="Apply1" Height="30" FontWeight="Bold"/>
          <TextBlock  HorizontalAlignment="Right" VerticalAlignment="Bottom" Width="80" TextWrapping="Wrap" Text="" Foreground="#FF0000" Margin="0,0,10,40" Name="Apply1Text"/>
        </Grid>
      </TabItem>

      <TabItem>
        <TabItem.Header>
          <StackPanel Orientation="Horizontal">
            <Image Name="dot2" Height="10" Width="10" Source="$pathToRedTabIcon" />
            <TextBlock Text="Ports+URLs" Margin="2,0,0,0" VerticalAlignment="Center" />
          </StackPanel>
        </TabItem.Header>
        <Grid Background="#FFFFFF">
          <Button Content="Help" HorizontalAlignment="Right" VerticalAlignment="Top" Width="50" Margin="10,10,0,0" Name="Help2" Height="20"/>
          <Image HorizontalAlignment="Right" Height="100" VerticalAlignment="Top" Width="100" Margin="10,40,0,0" Name="Enovation_Logo2" Source="$pathToUmoIcon"/>
          <Rectangle HorizontalAlignment="Left" VerticalAlignment="Top" Fill="#FFF4F4F5" Stroke="Black" Height="140" Width="267.5" Margin="5,25,0,0"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="UMO Control Settings:" Margin="10,30,0,0" FontWeight="Bold"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="IP Address of Active (Primary) UMO Control:" Margin="10,60,0,0"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="100" TextWrapping="NoWrap" Margin="10,80,0,0" Name="UmoControlIP" ToolTip="Enter the IPv4 Address of the primary and active UMO Control instance"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Operator Port:" Margin="10,110,0,0"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="40" TextWrapping="NoWrap" Margin="10,130,0,0" Name="OperatorPort" Text="" ToolTip="Enter the port used in the Services file for 'umooperators'. Default is 8012"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Service Port:" Margin="100,110,0,0"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="40" TextWrapping="NoWrap" Margin="100,130,0,0" Name="ServicePort" Text="" ToolTip="Enter the port used in the Services file for 'umoservices'. Default is 8013"/>
          <Rectangle HorizontalAlignment="Left" VerticalAlignment="Top" Fill="#FFF4F4F5" Stroke="Black" Height="140" Width="267.5" Margin="277.5,25,0,0"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="UmoX Database Settings:" Margin="282.5,30,0,0" FontWeight="Bold"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="FQDN of UmoX Database Server:" Margin="282.5,60,0,0"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="240" TextWrapping="NoWrap" Margin="282.5,80,0,0" Name="DatabaseFQDN" ToolTip="Enter the Fully Qualified Domain Name of the UmoX Database Server"/>
          <Rectangle HorizontalAlignment="Left" VerticalAlignment="Top" Fill="#FFF4F4F5" Stroke="Black" Height="140" Width="267.5" Margin="5,170,0,0"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Internal Website Settings:" Margin="10,175,0,0" FontWeight="Bold"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="FQDN of UmoX Internal Server:" Margin="10,205,0,0"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="240" TextWrapping="NoWrap" Margin="10,225,0,0" Name="InternalFQDN" ToolTip="Enter the Fully Qualified Domain Name of the Internal UmoX Server"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Port for Internal Website:" Margin="10,255,0,0"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="40" TextWrapping="NoWrap" Margin="10,275,0,0" Name="InternalPort" Text="" ToolTip="Enter the port to be used within IIS binding for the Internal Website. Default is 444"/>
          <Rectangle HorizontalAlignment="Left" VerticalAlignment="Top" Fill="#FFF4F4F5" Stroke="Black" Height="140" Width="267.5" Margin="277.5,170,0,0"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="External Website Settings:" Margin="282.5,175,0,0" FontWeight="Bold"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="FQDN of UmoX External Server:" Margin="282.5,205,0,0"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="240" TextWrapping="NoWrap" Margin="282.5,225,0,0" Name="ExternalFQDN" ToolTip="Enter the Fully Qualified Domain Name of the External UmoX Server"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Port for External Website:" Margin="282.5,255,0,0"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="40" TextWrapping="NoWrap" Margin="282.5,275,0,0" Name="ExternalPort" Text="" ToolTip="Enter the port to be used within IIS binding for the External Website. Default is 443"/>
          <Rectangle HorizontalAlignment="Left" VerticalAlignment="Top" Fill="#FFF4F4F5" Stroke="Black" Height="110" Width="267.5" Margin="5,315,0,0" Name="RAPIGrid" Visibility="Hidden"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Reporting API Settings:" Margin="10,320,0,0" FontWeight="Bold" Name="RAPISettingsLabel" Visibility="Hidden"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Port:" Margin="10,350,0,0" Name="RAPIPortLabel" Visibility="Hidden"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="40" TextWrapping="NoWrap" Margin="10,370,0,0" Name="RAPIPort" Text="" ToolTip="Enter the port to be used for the RAPI website. Default is 4443" Visibility="Hidden"/>
          <Rectangle HorizontalAlignment="Left" VerticalAlignment="Top" Fill="#FFF4F4F5" Stroke="Black" Height="110" Width="267.5" Margin="277.5,315,0,0" Name="POMASGrid" Visibility="Hidden"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="POMAS Settings:" Margin="282.5,320,0,0" FontWeight="Bold" Name="POMASSettingsLabel" Visibility="Hidden"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Port:" Margin="282.5,350,0,0" Name="POMASPortLabel" Visibility="Hidden"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="40" TextWrapping="NoWrap" Margin="282.5,370,0,0" Name="POMASPort" Text="" ToolTip="Enter the port to be used for the POMAS website. Default is 4444" Visibility="Hidden"/>
          <Button Content="Apply" HorizontalAlignment="Right" VerticalAlignment="Bottom" Width="80" Margin="0,0,10,10" Name="Apply2" Height="30" FontWeight="Bold"/>
          <TextBlock  HorizontalAlignment="Right" VerticalAlignment="Bottom" Width="80" TextWrapping="Wrap" Text="" Foreground="#FF0000" Margin="0,0,10,40" Name="Apply2Text"/>
        </Grid>
      </TabItem>

      <TabItem>
        <TabItem.Header>
          <StackPanel Orientation="Horizontal">
            <Image Name="dot3" Height="10" Width="10" Source="$pathToRedTabIcon" />
            <TextBlock Text="Application Settings" Margin="2,0,0,0" VerticalAlignment="Center" />
          </StackPanel>
        </TabItem.Header>
        <Grid Background="#FFFFFF">
          <Button Content="Help" HorizontalAlignment="Right" VerticalAlignment="Top" Width="50" Margin="10,10,0,0" Name="Help3" Height="20"/>
          <Image HorizontalAlignment="Right" Height="100" VerticalAlignment="Top" Width="100" Margin="10,40,0,0" Name="Enovation_Logo3" Source="$pathToUmoIcon"/>
          <Rectangle HorizontalAlignment="Left" VerticalAlignment="Top" Fill="#FFF4F4F5" Stroke="Black" Height="220" Width="540" Margin="5,25,0,0"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Database Settings:" Margin="10,30,0,0" FontWeight="Bold"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Name of SQL Instance:" Margin="10,60,0,0"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="250" TextWrapping="NoWrap" Margin="10,80,0,0" Name="SQLInstance" Text="" ToolTip="Enter the name of the SQL Instance. This must be in [NETBIOS]\\[Instance Name] format"/>
          <Button Content="Scan for SQL Instance" HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="140" Margin="270,80,0,0" Name="ScanForSQLInstance"/>
          <CheckBox HorizontalAlignment="Left" VerticalAlignment="Top" Content="SQL Mirror Mode?" Margin="10,110,0,0" Name="SQLMirrorModeCheckBox" ToolTip="Tick this box if you need to deploy UMO Databases in Mirror Mode"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="IPv4 address of Active UC Database:" Margin="10,140,0,0"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="100" TextWrapping="NoWrap" Margin="10,160,0,0" Name="UcDbIpv4" ToolTip="Enter the IPv4 Address of the server containing the database to which the live and active Umo Control is pointing"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Active UC Database Alias:" Margin="10,190,0,0"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="100" TextWrapping="NoWrap" Margin="10,210,0,0" Name="UcDbAlias" ToolTip="Enter the Alias name of the database to which the Live and Active Umo Control is pointing"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Bridge's REPL DB IP:" Margin="250,140,0,0"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="100" TextWrapping="NoWrap" Margin="250,160,0,0" Name="BridgeReplDbIp" ToolTip="Enter the IPv4 Address of the server containing the REPL.FDB for the Bridge database"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Bridge's REPL DB Alias:" Margin="250,190,0,0"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="100" TextWrapping="NoWrap" Margin="250,210,0,0" Name="BridgeReplAlias" ToolTip="Enter the Alias of the REPL.FDB for the Bridge database"/>
          <Rectangle HorizontalAlignment="Left" VerticalAlignment="Top" Fill="#FFF4F4F5" Stroke="Black" Height="175" Width="540" Margin="5,250,0,0" Name="POMASRectangle" Visibility="Hidden"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="POMAS Replication:" Margin="10,255,0,0" Name="POMASTitle" FontWeight="Bold" Visibility="Hidden"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="POMAS Replication Username:" Margin="10,285,0,0" Name="POMASUsernameLabel" Visibility="Hidden"/>
          <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="200" TextWrapping="NoWrap" Margin="10,305,0,0" Name="POMASUsername"  Visibility="Hidden" ToolTip="Enter the Username to be used for POMAS replication. Default is UmoServerAdmin"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="POMAS Replication Password:" Margin="10,335,0,0" Name="POMASPasswordLabel" Visibility="Hidden"/>
          <PasswordBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="200" Margin="10,355,0,0" Name="POMASPassword" Visibility="Hidden" ToolTip="Enter the Password to be used for POMAS replication. If not deploying in multi-tenant mode, this should match the Installation Password"/>
          <Button Content="Apply" HorizontalAlignment="Right" VerticalAlignment="Bottom" Width="80" Margin="0,0,10,10" Name="Apply3" Height="30" FontWeight="Bold"/>
          <TextBlock  HorizontalAlignment="Right" VerticalAlignment="Bottom" Width="80" TextWrapping="Wrap" Text="" Foreground="#FF0000" Margin="0,0,10,40" Name="Apply3Text"/>
        </Grid>
      </TabItem>

      <TabItem>
        <TabItem.Header>
          <StackPanel Orientation="Horizontal">
            <Image Name="dot4" Height="10" Width="10" Source="$pathToRedTabIcon" />
            <TextBlock Text="Email" Margin="2,0,0,0" VerticalAlignment="Center" />
          </StackPanel>
        </TabItem.Header>
        <Grid Background="#FFFFFF">
        <Button Content="Help" HorizontalAlignment="Right" VerticalAlignment="Top" Width="50" Margin="10,10,0,0" Name="Help4" Height="20"/>
        <Image HorizontalAlignment="Right" Height="100" VerticalAlignment="Top" Width="100" Margin="10,40,0,0" Name="Enovation_Logo4" Source="$pathToUmoIcon"/>
        <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Outgoing Email Server:" Margin="10,30,0,0" FontWeight="Bold"/>
        <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="350" TextWrapping="NoWrap" Margin="10,50,0,0" Name="EmailServer" ToolTip="Enter the name of the Outgoing Email Server"/>
        <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Outgoing Email Server Port:" Margin="10,80,0,0" FontWeight="Bold"/>
        <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="40" TextWrapping="NoWrap" Margin="10,100,0,0" Name="EmailServerPort" ToolTip="Enter the port for the Outgoing Email Server"/>
        <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Outgoing Email Username:" Margin="10,130,0,0" FontWeight="Bold"/>
        <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="350" TextWrapping="NoWrap" Margin="10,150,0,0" Name="EmailUsername" ToolTip="Enter the Username of the sending Email Account"/>
        <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Outgoing Email Password:" Margin="10,180,0,0" FontWeight="Bold"/>
        <PasswordBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="200" Margin="10,200,0,0" Name="EmailPassword" ToolTip="Enter the Password of the sending Email Account"/>
        <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Outgoing Email Address:" Margin="10,230,0,0" FontWeight="Bold"/>
        <TextBox HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="350" TextWrapping="NoWrap" Margin="10,250,0,0" Name="EmailAddress" ToolTip="Enter the Address of the sending Email Account"/>
        <Button Content="Apply" HorizontalAlignment="Right" VerticalAlignment="Bottom" Width="80" Margin="0,0,10,10" Name="Apply4" Height="30" FontWeight="Bold"/>
        <TextBlock  HorizontalAlignment="Right" VerticalAlignment="Bottom" Width="80" TextWrapping="Wrap" Text="" Foreground="#FF0000" Margin="0,0,10,40" Name="Apply4Text"/>
        </Grid>
      </TabItem>

      <TabItem>
        <TabItem.Header>
          <StackPanel Orientation="Horizontal">
            <Image Name="dot5" Height="10" Width="10" Source="$pathToRedTabIcon" />
            <TextBlock Text="MFA" Margin="2,0,0,0" VerticalAlignment="Center" />
          </StackPanel>
        </TabItem.Header>
        <Grid Background="#FFFFFF">
          <Button Content="Help" HorizontalAlignment="Right" VerticalAlignment="Top" Width="50" Margin="10,10,0,0" Name="Help5" Height="20"/>
          <Image HorizontalAlignment="Right" Height="100" VerticalAlignment="Top" Width="100" Margin="10,40,0,0" Name="Enovation_Logo5" Source="$pathToUmoIcon"/>

          <Rectangle HorizontalAlignment="Left" VerticalAlignment="Top" Fill="#FFF4F4F5" Stroke="Black" Height="350" Width="267.5" Margin="5,25,0,0"/>
          <CheckBox HorizontalAlignment="Left" VerticalAlignment="Top" Content="" Name="DUOCheckBox" Margin="250,30,0,0"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="DUO MFA Settings:" Margin="10,30,0,0" FontWeight="Bold"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Integration Key:" Margin="10,60,0,0"/>
          <TextBox IsEnabled="False" HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="257.5" TextWrapping="NoWrap" Margin="10,80,0,0" Name="IntegrationKey" ToolTip=""/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Secret Key:" Margin="10,110,0,0"/>
          <TextBox IsEnabled="False" HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="257.5" TextWrapping="NoWrap" Margin="10,130,0,0" Name="SecretKey" ToolTip=""/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="API Hostname:" Margin="10,160,0,0"/>
          <TextBox IsEnabled="False" HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="257.5" TextWrapping="NoWrap" Margin="10,180,0,0" Name="APIHostName" ToolTip=""/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Application Key:" Margin="10,210,0,0"/>
          <TextBox IsEnabled="False" HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="257.5" TextWrapping="NoWrap" Margin="10,230,0,0" Name="ApplicationKey" ToolTip=""/>
          <Button IsEnabled="False" Content="Generate" HorizontalAlignment="Left" VerticalAlignment="Top" Width="70" Margin="10,255,0,0" Name="GenerateAKey" Height="25" FontWeight="Bold"/>
          <Button IsEnabled="False" Content="DUO Guide" HorizontalAlignment="Left" VerticalAlignment="Top" Width="257.5" Margin="10,345,0,0" Name="DUOGuide" Height="25"/>          
          

          <Rectangle HorizontalAlignment="Left" VerticalAlignment="Top" Fill="#FFF4F4F5" Stroke="Black" Height="350" Width="267.5" Margin="277.5,25,0,0"/>
          <CheckBox HorizontalAlignment="Left" VerticalAlignment="Top" Content="" Name="PassageIDCheckBox" Margin="525,30,0,0"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="PassageID Settings:" Margin="282.5,30,0,0" FontWeight="Bold"/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Token URI:" Margin="282.5,60,0,0"/>
          <TextBox IsEnabled="False" HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="257.5" TextWrapping="NoWrap" Margin="282.5,80,0,0" Name="PassageIDTokenUri" ToolTip=""/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Authorisation URI:" Margin="282.5,110,0,0"/>
          <TextBox IsEnabled="False" HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="257.5" TextWrapping="NoWrap" Margin="282.5,130,0,0" Name="PassageIDAuthUri" ToolTip=""/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Validation Redirect URI:" Margin="282.5,160,0,0"/>
          <TextBox IsEnabled="False" HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="257.5" TextWrapping="NoWrap" Margin="282.5,180,0,0" Name="PassageIDValidationRedirectUri" ToolTip=""/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Client Secret:" Margin="282.5,210,0,0"/>
          <TextBox IsEnabled="False" HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="257.5" TextWrapping="NoWrap" Margin="282.5,230,0,0" Name="ClientSecret" ToolTip=""/>
          <TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="Allowed Client ID:" Margin="282.5,260,0,0"/>
          <TextBox IsEnabled="False" HorizontalAlignment="Left" VerticalAlignment="Top" Height="20" Width="257.5" TextWrapping="NoWrap" Margin="282.5,280,0,0" Name="AllowedClientId" ToolTip=""/>
          <Button IsEnabled="False" Content="DUO Guide" HorizontalAlignment="Left" VerticalAlignment="Top" Width="257.5" Margin="282.5,345,0,0" Name="PassageIDGuide" Height="25"/>
          
          <Button Content="Apply" HorizontalAlignment="Right" VerticalAlignment="Bottom" Width="80" Margin="0,0,10,10" Name="Apply5" Height="30" FontWeight="Bold"/>
          <TextBlock  HorizontalAlignment="Right" VerticalAlignment="Bottom" Width="80" TextWrapping="Wrap" Text="" Foreground="#FF0000" Margin="0,0,10,40" Name="Apply5Text"/>
        </Grid>
      </TabItem>

      <TabItem>
        <TabItem.Header>
          <StackPanel Orientation="Horizontal">
            <Image Name="dot6" Height="10" Width="10" Source="$pathToRedTabIcon" />
            <TextBlock Text="Install/Upgrade" Margin="2,0,0,0" VerticalAlignment="Center" />
          </StackPanel>
        </TabItem.Header>
        <Grid Background="#FFFFFF">
          <Button Content="Help" HorizontalAlignment="Right" VerticalAlignment="Top" Width="50" Margin="10,10,0,0" Name="Help6" Height="20"/>
          <Image HorizontalAlignment="Right" Height="100" VerticalAlignment="Top" Width="100" Margin="10,40,0,0" Name="Enovation_Logo6" Source="$pathToUmoIcon"/>
          <Button Content="Install/Upgrade UmoX" HorizontalAlignment="Center" VerticalAlignment="Center" Width="250" Height="50" Margin="0,0,0,0" Name="Install" FontSize="20" FontWeight="Bold"/>
          <Button Content="Apply" HorizontalAlignment="Right" VerticalAlignment="Bottom" Width="80" Margin="0,0,10,10" Name="Apply6" Height="30" FontWeight="Bold"/>
          <TextBlock  HorizontalAlignment="Right" VerticalAlignment="Bottom" Width="80" TextWrapping="Wrap" Text="" Foreground="#FF0000" Margin="0,0,10,40" Name="Apply6Text"/>
        </Grid>
      </TabItem>
    </TabControl>
  </Grid>
</Window>

"@

#-------------------------------------------------------------#
#----Control Event Handlers-----------------------------------#
#-------------------------------------------------------------#
#Region - Generic Functions
Function Help () {
    $ConfluenceURL = "https://www.bbc.co.uk/news"
    Start-Process $ConfluenceURL
    Write-Host "Opening Help URL $ConfluenceURL" -Fore Yellow
}
#EndRegion
#Region - Tab1 Functions
Function ValidateJsonPath () {
  Write-Host "Checking whether the Json file is present in the path provided" -Fore Yellow
  $pathToJson = $JsonPathTextBox.Text
  If (Test-Path $pathToJson -PathType Leaf) {
    $JsonPathTextBox.Foreground="#0B9200"
    Write-Host "Json Path Validated" -Fore Green
    } Else {
      $ButtonType = [System.Windows.MessageBoxButton]::OK
      $MessageIcon = [System.Windows.MessageBoxImage]::Warning
      $MessageBoxTitle = "Json Warning"
      $MessageBoxBody = "No Json File was detected at the path provided"
      $Result = [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$messageicon)
      If ($Result -eq "OK") {
      $JsonPathTextBox.Foreground="#FF0000"
      Write-Host "Json Path Invalid" -Fore Red
    }
  }
}
Function jsonChanged () {
  $dot1.Source = $pathToOrangeTabIcon
}
Function sqlPwChanged () {
  $dot1.Source = $pathToOrangeTabIcon
}
Function fbPwChanged () {
  $dot1.Source = $pathToOrangeTabIcon
}
Function installDriveChanged () {
  $dot1.Source = $pathToOrangeTabIcon
}
Function dataDriveChanged () {
  $dot1.Source = $pathToOrangeTabIcon
}
Function MultiTenantChecked () {
  $PostFixTextLabel.Visibility="Visible"
  $PostFixTextBox.Visibility="Visible"
  $CustomerPasswordLabel.Visibility="Visible"
  $CustomerPassword.Visibility="Visible"
  $dot1.Source = $pathToOrangeTabIcon
}
Function MultiTenantUnChecked () {
  $PostFixTextLabel.Visibility="Hidden"
  $PostFixTextBox.Visibility="Hidden"
  $CustomerPasswordLabel.Visibility="Hidden"
  $CustomerPassword.Visibility="Hidden"
  $dot1.Source = $pathToOrangeTabIcon
}
Function postFixChanged () {
  $dot1.Source = $pathToOrangeTabIcon
}
Function customerPwChanged () {
  $dot1.Source = $pathToOrangeTabIcon
}
Function MFAChecked () {
  $dot1.Source = $pathToOrangeTabIcon

}
Function MFAUnChecked () {
  $dot1.Source = $pathToOrangeTabIcon
}
Function RAPIChecked () {
  $RAPIGrid.Visibility="Visible"
  $RAPISettingsLabel.Visibility="Visible"
  $RAPIPortLabel.Visibility="Visible"
  $RAPIPort.Visibility="Visible"
  $dot1.Source = $pathToOrangeTabIcon
}
Function RAPIUnChecked () {
  $RAPIGrid.Visibility="Hidden"
  $RAPISettingsLabel.Visibility="Hidden"
  $RAPIPortLabel.Visibility="Hidden"
  $RAPIPort.Visibility="Hidden"
  $dot1.Source = $pathToOrangeTabIcon
}
Function POMASChecked () {
  $POMASGrid.Visibility="Visible"
  $POMASSettingsLabel.Visibility="Visible"
  $POMASPortLabel.Visibility="Visible"
  $POMASPort.Visibility="Visible"
  $dot1.Source = $pathToOrangeTabIcon
  $POMASRectangle.Visibility="Visible"
  $POMASTitle.Visibility="Visible"
  $POMASUsernameLabel.Visibility="Visible"
  $POMASUsername.Visibility="Visible"
  $POMASPasswordLabel.Visibility="Visible"
  $POMASPassword.Visibility="Visible"
}
Function POMASUnChecked () {
  $POMASGrid.Visibility="Hidden"
  $POMASSettingsLabel.Visibility="Hidden"
  $POMASPortLabel.Visibility="Hidden"
  $POMASPort.Visibility="Hidden"
  $dot1.Source = $pathToOrangeTabIcon
  $POMASRectangle.Visibility="Hidden"
  $POMASTitle.Visibility="Hidden"
  $POMASUsernameLabel.Visibility="Hidden"
  $POMASUsername.Visibility="Hidden"
  $POMASPasswordLabel.Visibility="Hidden"
  $POMASPassword.Visibility="Hidden"
}
Function ForceCheckBoxChecked () {
  $dot1.Source = $pathToOrangeTabIcon
} 
Function ForceCheckBoxUnChecked () {
  $dot1.Source = $pathToOrangeTabIcon
}
Function NoBackupCheckBoxChecked () {
  $dot1.Source = $pathToOrangeTabIcon
}
Function NoBackupCheckBoxUnChecked () {
  $dot1.Source = $pathToOrangeTabIcon
}
Function ApplyTab1 () {
    Write-Host "Applying settings from the 'Main Settings' Tab" -Fore Yellow  
    # Validate the JSON Path before trying to pass data to JSON
    $pathToJson = $JsonPathTextBox.Text
    If ($null -eq $pathToJson) {
      $dot1.Source = $pathToRedTabIcon
      $Apply1Text.Text = "No value for Json Path"
    } Else {
        Write-Host "Importing JSON" -Fore Yellow
        $json = Get-Content $pathToJson | ConvertFrom-Json
    }
    # Set variables
    $sqlMasterPassword = $sqlPassword.Password
    $firebirdMasterPassword = $firebirdPassword.Password
    $installationDrive = $InstallationDriveSelection.SelectedIndex
    $dataDrive = $DataDriveSelection.SelectedIndex
    $multiTenantSelection = $MultiTenantCheckBox.IsChecked
    $PostFix = $PostFixTextBox.Text
    $IndividualCustomerPassword = $CustomerPassword.Password
    # Check all the fields required are populated
    If ($sqlMasterPassword -eq "") {
      $dot1.Source = $pathToRedTabIcon
      $Apply1Text.Text = "No value for SQL Master Password"
    } ElseIf ($firebirdMasterPassword -eq "") {
      $dot1.Source = $pathToRedTabIcon
      $Apply1Text.Text = "No value for Firebird Master Password"
    } ElseIf ($installationDrive -eq "-1") {
      $dot1.Source = $pathToRedTabIcon
      $Apply1Text.Text = "No value for Installation Drive"
    } ElseIf ($dataDrive -eq "-1") {
      $dot1.Source = $pathToRedTabIcon
      $Apply1Text.Text = "No value for Data Drive"
    } ElseIf (($multiTenantSelection -eq $True) -and (($PostFixTextBox.Text -eq "") -or ($CustomerPassword.Password -eq ""))) {
      $dot1.Source = $pathToRedTabIcon
      $Apply1Text.Text = "Values not provided for multi-tenancy"
    } Else {
      # Pass SQL Master Password to JSON
      Write-Host "Writing value for SQL Instance Password to JSON" -Fore Yellow
      $json.databases.sqlInstancePassword = "$sqlMasterPassword"
      # Pass Firebird Master Password to JSON
      Write-Host "Writing value for Firebird Password to JSON" -Fore Yellow
      $json._2gPassword = "$firebirdMasterPassword"
      # Pass installation drive to JSON
      If ($installationDrive -eq "0") {$installDrive = "A:\"}
      ElseIf ($installationDrive -eq "1") {$installDrive = "B:\"}
      ElseIf ($installationDrive -eq "2") {$installDrive = "C:\"}
      ElseIf ($installationDrive -eq "3") {$installDrive = "D:\"}
      ElseIf ($installationDrive -eq "4") {$installDrive = "E:\"}
      ElseIf ($installationDrive -eq "5") {$installDrive = "F:\"}
      ElseIf ($installationDrive -eq "6") {$installDrive = "G:\"}
      ElseIf ($installationDrive -eq "7") {$installDrive = "H:\"}
      ElseIf ($installationDrive -eq "8") {$installDrive = "I:\"}
      ElseIf ($installationDrive -eq "9") {$installDrive = "J:\"}
      ElseIf ($installationDrive -eq "10") {$installDrive = "K:\"}
      ElseIf ($installationDrive -eq "11") {$installDrive = "L:\"}
      ElseIf ($installationDrive -eq "12") {$installDrive = "M:\"}
      ElseIf ($installationDrive -eq "13") {$installDrive = "N:\"}
      ElseIf ($installationDrive -eq "14") {$installDrive = "O:\"}
      ElseIf ($installationDrive -eq "15") {$installDrive = "P:\"}
      ElseIf ($installationDrive -eq "16") {$installDrive = "Q:\"}
      ElseIf ($installationDrive -eq "17") {$installDrive = "R:\"}
      ElseIf ($installationDrive -eq "18") {$installDrive = "S:\"}
      ElseIf ($installationDrive -eq "19") {$installDrive = "T:\"}
      ElseIf ($installationDrive -eq "20") {$installDrive = "U:\"}
      ElseIf ($installationDrive -eq "21") {$installDrive = "V:\"}
      ElseIf ($installationDrive -eq "22") {$installDrive = "W:\"}
      ElseIf ($installationDrive -eq "23") {$installDrive = "X:\"}
      ElseIf ($installationDrive -eq "24") {$installDrive = "Y:\"}
      ElseIf ($installationDrive -eq "25") {$installDrive = "Z:\"}
      Write-Host "Writing value for installation drive to JSON" -Fore Yellow
      $json.installDrive = "$installDrive"
      # Pass data drive to JSON
      If ($dataDrive -eq "0") {$dDrive = "A:\"}
      ElseIf ($dataDrive -eq "1") {$dDrive = "B:\"}
      ElseIf ($dataDrive -eq "2") {$dDrive = "C:\"}
      ElseIf ($dataDrive -eq "3") {$dDrive = "D:\"}
      ElseIf ($dataDrive -eq "4") {$dDrive = "E:\"}
      ElseIf ($dataDrive -eq "5") {$dDrive = "F:\"}
      ElseIf ($dataDrive -eq "6") {$dDrive = "G:\"}
      ElseIf ($dataDrive -eq "7") {$dDrive = "H:\"}
      ElseIf ($dataDrive -eq "8") {$dDrive = "I:\"}
      ElseIf ($dataDrive -eq "9") {$dDrive = "J:\"}
      ElseIf ($dataDrive -eq "10") {$dDrive = "K:\"}
      ElseIf ($dataDrive -eq "11") {$dDrive = "L:\"}
      ElseIf ($dataDrive -eq "12") {$dDrive = "M:\"}
      ElseIf ($dataDrive -eq "13") {$dDrive = "N:\"}
      ElseIf ($dataDrive -eq "14") {$dDrive = "O:\"}
      ElseIf ($dataDrive -eq "15") {$dDrive = "P:\"}
      ElseIf ($dataDrive -eq "16") {$dDrive = "Q:\"}
      ElseIf ($dataDrive -eq "17") {$dDrive = "R:\"}
      ElseIf ($dataDrive -eq "18") {$dDrive = "S:\"}
      ElseIf ($dataDrive -eq "19") {$dDrive = "T:\"}
      ElseIf ($dataDrive -eq "20") {$dDrive = "U:\"}
      ElseIf ($dataDrive -eq "21") {$dDrive = "V:\"}
      ElseIf ($dataDrive -eq "22") {$dDrive = "W:\"}
      ElseIf ($dataDrive -eq "23") {$dDrive = "X:\"}
      ElseIf ($dataDrive -eq "24") {$dDrive = "Y:\"}
      ElseIf ($dataDrive -eq "25") {$dDrive = "Z:\"}
      Write-Host "Writing value for data drive to JSON" -Fore Yellow
      $json.dataDrive = "$dDrive"
      # Pass Multi-Tenant selection to json
      Write-Host "Writing PostFix value to JSON" -Fore Yellow
      $json.postfix = $PostFix
      $json.installationPassword = $IndividualCustomerPassword
      # Finalise and feedback
      $json | ConvertTo-Json | Set-Content $pathToJson
      $Apply1Text.Text = ""
      $dot1.Source = $pathToGreenTabIcon
      Write-Host "All values written to JSON for tab 1" -Fore Green
    }
  }
#EndRegion
#Region - Tab2 Functions
Function ucIpChanged () {
  $dot2.Source = $pathToOrangeTabIcon
}
Function ucOpPortChanged () {
  $dot2.Source = $pathToOrangeTabIcon
}
Function ucServicesPortChanged () {
  $dot2.Source = $pathToOrangeTabIcon
}
Function internalWebsiteFqdnChanged () {
  $dot2.Source = $pathToOrangeTabIcon
}
Function internalWebsitePortChanged () {
  $dot2.Source = $pathToOrangeTabIcon
}
Function externalWebsiteFqdnChanged () {
  $dot2.Source = $pathToOrangeTabIcon
}
Function databaseFQDNChanged () {
  $dot2.Source = $pathToOrangeTabIcon
}
Function externalWebsitePortChanged () {
  $dot2.Source = $pathToOrangeTabIcon
}
Function rapiPortChanged () {
  $dot2.Source = $pathToOrangeTabIcon
}
Function pomasPortChanged () {
  $dot2.Source = $pathToOrangeTabIcon
}
Function ApplyTab2 () {
  Write-Host "Applying settings from the 'Ports+URLs' Tab" -Fore Yellow
  # Validate the JSON Path before trying to pass data to the JSON
  $pathToJson = $JsonPathTextBox.Text
  If ($null -eq $pathToJson) {
    $dot2.Source = $pathToRedTabIcon
    $Apply2Text.Text = "No value for Json Path"
  } Else {
    Write-Host "Importing JSON" -Fore Yellow
    $json = Get-Content $pathToJson | ConvertFrom-Json
  }
  # Set Variables
  $UcIP = $UmoControlIP.Text
  $OPort = $OperatorPort.Text
  $SPort = $ServicePort.Text
  $IFQDN = $InternalFQDN.Text
  $IPort = $InternalPort.Text
  $EFQDN = $ExternalFQDN.Text
  $DFQDN = $DatabaseFQDN.Text
  $EPort = $ExternalPort.Text
  $RPort = $RAPIPort.Text
  $PPort = $POMASPort.Text
  $RapiStatus = $RAPICheckBox.IsChecked
  $PomasStatus = $POMASCheckBox.IsChecked
  # Check all the fields required are populated
  If ($UcIP -eq "") {
    $dot2.Source = $pathToRedTabIcon
    $Apply2Text.Text = "No value for Umo Control IP"
  } ElseIf ($OPort -eq "") {
    $dot2.Source = $pathToRedTabIcon
    $Apply2Text.Text = "No value for Operator Port"
  } ElseIf ($SPort -eq "") {
    $dot2.Source = $pathToRedTabIcon
    $Apply2Text.Text = "No value for Services Port"
  } ElseIf ($DFQDN -eq "") {
    $dot2.Source = $pathToRedTabIcon
    $Apply2Text.Text = "No value for Database FQDN"
  } ElseIf ($IFQDN -eq "") {
    $dot2.Source = $pathToRedTabIcon
    $Apply2Text.Text = "No value for Internal Server FQDN"
  } ElseIf ($IPort -eq "") {
    $dot2.Source = $pathToRedTabIcon
    $Apply2Text.Text = "No value for Internal Server Port"
  } ElseIf ($EFQDN -eq "") {
    $dot2.Source = $pathToRedTabIcon
    $Apply2Text.Text = "No value for External Server FQDN"
  } ElseIf ($EPort -eq "") {
    $dot2.Source = $pathToRedTabIcon
    $Apply2Text.Text = "No value for External Server Port"
  } ElseIf (($RapiStatus -eq "$True") -and ($RPort -eq "")) {
    $dot2.Source = $pathToRedTabIcon
    $Apply2Text.Text = "No value for RAPI Port"
  } ElseIf (($PomasStatus -eq "$True") -and ($PPort -eq "")) {
    $dot2.Source = $pathToRedTabIcon
    $Apply2Text.Text = "No value for POMAS Port"
  } Else {
    # Pass UC IP to Json
    Write-Host "Writing value for Umo Control IP to Json" -Fore Yellow
    $json.umoControl.umoIpAddress = "$UcIP"
    # Pass Operator Port to Json
    Write-Host "Writing value for Operator Port to Json" -Fore Yellow
    $json.umoControl.operatorPort = "$OPort"
    # Pass Services Port to Json
    Write-Host "Writing value for Services Port to Json" -Fore Yellow
    $json.umoControl.servicePort = "$SPort"
    # Pass Internal FQDN to Json
    Write-Host "Writing value for Internal Server FQDN to Json" -Fore Yellow
    $json.internalWebsite.hostname = "$IFQDN"
    # Pass Internal Port to Json
    Write-Host "Writing value for Internal Server Port to Json" -Fore Yellow
    $json.internalWebsite.securePort = "$IPort"
    # Pass External FQDN to Json
    Write-Host "Writing value for External Server FQDN to Json" -Fore Yellow
    $json.externalWebsite.hostname = "$EFQDN"
    # Pass External Port to Json
    Write-Host "Writing value for External Server Port to Json" -Fore Yellow
    $json.externalWebsite.securePort = "$EPort"
    # Pass RAPI Port to Json
    Write-Host "Writing value for RAPI Port to Json" -Fore Yellow
    $json.rapi.port = "$RPort"
    # Pass POMAS Port to Json
    Write-Host "Writing value for POMAS Port to Json" -Fore Yellow
    $json.pomas.port = "$PPort"
    # Finalise and feedback
    $json | ConvertTo-Json | Set-Content $pathToJson
    $Apply2Text.Text = ""
    $dot2.Source = $pathToGreenTabIcon
    Write-Host "All values written to JSON for tab 2" -Fore Green
  }
}
#EndRegion
#Region - Tab3 Functions
Function ScanForSQL () {
  Write-Host "Checking whether an SQL Instance is present on the local Server" -Fore Yellow
  $SQLRegistryPath = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server"
  $SQLRegistryInstancePropertyName = "InstalledInstances"
  If (Test-Path $SQLRegistryPath) {
    Write-Host "SQL Instance detected on local Server" -Fore Green
    $LocalSQLInstanceName = (Get-Item -LiteralPath $SQLRegistryPath).GetValue($SQLRegistryInstancePropertyName)
    $SQLPath = "$ENV:COMPUTERNAME"+"\\"+"$LocalSQLInstanceName"
    $SQLInstance.Text = "$SQLPath"
    $SQLInstance.Foreground="#0B9200"
    } Else {
      $ButtonType = [System.Windows.MessageBoxButton]::OK
      $MessageIcon = [System.Windows.MessageBoxImage]::Warning
      $MessageBoxTitle = "SQL Warning"
      $MessageBoxBody = "No SQL Instance was detected on the Internal Server"
      $Result = [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$messageicon)
      If ($Result -eq "OK") {
      Write-Host "SQL Not found. Please enter manualy or resolve installation" -Fore Red
      $SQLInstance.Foreground="#FF0000"
    }
  }
}
Function SQLInstanceChanged () {
  $dot3.Source = $pathToOrangeTabIcon
}
Function SQLMirrorModeChecked () {
  $dot3.Source = $pathToOrangeTabIcon
}
Function SQLMirrorModeUnChecked () {
  $dot3.Source = $pathToOrangeTabIcon
}
Function UcDbIpV4Changed () {
  $dot3.Source = $pathToOrangeTabIcon
}
Function UcDbAliasChanged () {
  $dot3.Source = $pathToOrangeTabIcon
}
Function BridgeReplDbIpChanged () {
  $dot3.Source = $pathToOrangeTabIcon
}
Function BridgeReplAliasChanged () {
  $dot3.Source = $pathToOrangeTabIcon
}
Function POMASUsernameChanged () {
  $dot3.Source = $pathToOrangeTabIcon
}
Function POMASPasswordChanged () {
  $dot3.Source = $pathToOrangeTabIcon
}
Function ApplyTab3 () {
  Write-Host "Applying settings from the 'Application Settings' Tab" -Fore Yellow
  # Validate the JSON Path before trying to pass data to the JSON
  $pathToJson = $JsonPathTextBox.Text
  If ($null -eq $pathToJson) {
    $dot3.Source = $pathToRedTabIcon
    $Apply3Text.Text = "No value for Json Path"
  } Else {
    Write-Host "Importing JSON" -Fore Yellow
    $json = Get-Content $pathToJson | ConvertFrom-Json
  }
  # Set Variables
  $sqlInstanceName = $SQLInstance.Text
  $sqlMirrorModeSelection = $SQLMirrorModeCheckBox.IsChecked
  $UcDbIpV4Address = $UcDbIpv4.Text
  $UcDbAliasName = $UcDbAlias.Text
  $BridgeReplIpV4Address = $BridgeReplDbIp.Text
  $BridgeReplAliasName = $BridgeReplAlias.Text
  $PUsername = $POMASUsername.Text
  $PPassword = $POMASPassword.Password
  # Check all the fields required are populated
  If ($sqlInstanceName -eq "") {
    $dot3.Source = $pathToRedTabIcon
    $Apply3Text.Text = "No value for SQL Instance"
  } ElseIf ($UcDbIpV4Address -eq "") {
    $dot3.Source = $pathToRedTabIcon
    $Apply3Text.Text = "No value for UC's DB IP Address"
  } ElseIf ($UcDbAliasName -eq "") {
    $dot3.Source = $pathToRedTabIcon
    $Apply3Text.Text = "No value for UC's DB Alias"
  } ElseIf ($BridgeReplIpV4Address -eq "") {
    $dot3.Source = $pathToRedTabIcon
    $Apply3Text.Text = "No value Bridge DB's REPL DB IP"
  } ElseIf ($BridgeReplAliasName -eq "") {
    $dot3.Source = $pathToRedTabIcon
    $Apply3Text.Text = "No value for Bridge DB's REPL DB Alias"
  } ElseIf (($PUsername -eq "") -and ($POMASCheckBox.IsChecked -eq $true)){
    $dot3.Source = $pathToRedTabIcon
    $Apply3Text.Text = "No value for POMAS Replication Username"
  } ElseIf (($PPassword -eq "") -and ($POMASCheckBox.IsChecked -eq $true)) {
    $dot3.Source = $pathToRedTabIcon
    $Apply3Text.Text = "No value for POMAS Replication Password"
  } Else {
    # Pass SQL Instance name to Json
    Write-Host "Writing value for SQL Instance Name to Json" -Fore Yellow
    $json.databases.sqlInstance = "$sqlInstanceName"
    # Pass SQL Mirror Mode selection to Json
    Write-Host "Writing value for SQL Mirror Mode to Json" -Fore Yellow
    If ($sqlMirrorModeSelection -eq "False") {
      $json.databases.sqlMirrorMode = $False
    } Else {$json.databases.sqlMirrorMode = $True}
    #$json.databases.sqlMirrorMode = "$sqlMirrorModeSelection"
    # Pass UMO Control's Database IP Address to Json
    Write-Host "Writing value for Umo Control's Database IP to Json" -Fore Yellow
    $json.databases._2g.server = "$UcDbIpV4Address"
    # Pass UMO Control's Database Alias to Json
    Write-Host "Writing value for Umo Control's Database Alias to Json" -Fore Yellow
    $json.databases._2g.database = "$UcDbAliasName"
    # Pass Bridge DB's REPL DB IP to Json
    Write-Host "Writing value for Replication Database IP to Json" -Fore Yellow
    $json.databases._2gReplication.server = $BridgeReplIpV4Address
    # Pass Bridge DB's REPL DB Alias to Json
    Write-Host "Writing value for Replication Database Alias to Json" -Fore Yellow
    $json.databases._2gReplication.database = $BridgeReplAliasName
    # Write POMAS Username to Json
    Write-Host "Writing value for POMAS Replication Username to Json" -Fore Yellow
    $json.pomas.ReplicationBridge.authUsername = $PUsername
    # Write POMAS Password to Json
    Write-Host "Writing value for POMAS Replication Password to Json" -Fore Yellow
    $json.pomas.ReplicationBridge.authPassword = $PPassword
    # Finalise and feedback
    $json | ConvertTo-Json | Set-Content $pathToJson
    $Apply3Text.Text = ""
    $dot3.Source = $pathToGreenTabIcon
    Write-Host "All values written to JSON for tab 3" -Fore Green
  }
}
#EndRegion
#Region - Tab4 Functions
Function EmailServerChanged () {
  $dot4.Source = $pathToOrangeTabIcon
}
Function EmailServerPortChanged () {
  $dot4.Source = $pathToOrangeTabIcon
}
Function EmailUsernameChanged () {
  $dot4.Source = $pathToOrangeTabIcon
}
Function EmailPasswordChanged () {
  $dot4.Source = $pathToOrangeTabIcon
}
Function EmailAddressChanged () {
  $dot4.Source = $pathToOrangeTabIcon
}
Function ApplyTab4 () {
  Write-Host "Applying settings from the 'Email' Tab" -Fore Yellow
  # Validate the JSON Path before trying to pass data to the JSON
  $pathToJson = $JsonPathTextBox.Text
  If ($null -eq $pathToJson) {
    $dot4.Source = $pathToRedTabIcon
    $Apply4Text.Text = "No value for Json Path"
  } Else {
    Write-Host "Importing JSON" -Fore Yellow
    $json = Get-Content $pathToJson | ConvertFrom-Json
  }
  # Set Variables
  $EServer = $EmailServer.Text
  $EServerPort = $EmailServerPort.Text
  $EUsername = $EmailUsername.Text
  $EPassword = $EmailPassword.Password
  $EAddress = $EmailAddress.Text
  # Check all the fields required are populated
  If ($EServer -eq "") {
    $dot4.Source = $pathToRedTabIcon
    $Apply4Text.Text = "No value for Email Server"
  } ElseIf ($EServerPort -eq "") {
    $dot4.Source = $pathToRedTabIcon
    $Apply4Text.Text = "No value for Email Server Port"
  } ElseIf ($EUsername -eq "") {
    $dot4.Source = $pathToRedTabIcon
    $Apply4Text.Text = "No value for Email Username"
  } ElseIf ($EPassword -eq "") {
    $dot4.Source = $pathToRedTabIcon
    $Apply4Text.Text = "No value for Email Password"
  } ElseIf ($EAddress -eq "") {
    $dot4.Source = $pathToRedTabIcon
    $Apply4Text.Text = "No value for Email Address"
  } Else {
    # Pass Email Server to Json
    Write-Host "Writing value for Outgoing Email Server to Json" -Fore Yellow
    $json.outgoingEmailServer.server = "$EServer"
    # Pass Email Server Port to Json
    Write-Host "Writing value for Outgoing Email Server Port to Json" -Fore Yellow
    $json.outgoingEmailServer.port = "$EServerPort"
    # Pass Email Username to Json
    Write-Host "Writing value for Outgoing Email Account Username to Json" -Fore Yellow
    $json.outgoingEmailServer.username = "$EUsername"
    # Pass Email Password to Json
    Write-Host "Writing value for Outoing Email Account Password to Json" -Fore Yellow
    $json.outgoingEmailServer.password = "$EPassword"
    # Pass Email Address to Json
    Write-Host "Writing value for Outgoing Email Address to Json" -Fore Yellow
    $json.outgoingEmailServer.emailAddress = "$EAddress"
    # Finalise and feedback
    $json | ConvertTo-Json | Set-Content $pathToJson
    $Apply4Text.Text = ""
    $dot4.Source = $pathToGreenTabIcon
    Write-Host "All values written to JSON for tab 4" -Fore Green
  }
}
#EndRegion
#Region - Tab5 Functions
Function DUOCheckBoxSelected () {
  $dot5.Source = $pathToOrangeTabIcon
  $PassageIDCheckBox.IsChecked=$False
  $PassageIDTokenUri.IsEnabled=$False
  $PassageIDAuthUri.IsEnabled=$False
  $PassageIDValidationRedirectUri.IsEnabled=$False
  $ClientSecret.IsEnabled=$False
  $AllowedClientId.IsEnabled=$False
  $IntegrationKey.IsEnabled=$True
  $SecretKey.IsEnabled=$True
  $APIHostName.IsEnabled=$True
  $ApplicationKey.IsEnabled=$True
  $GenerateAKey.IsEnabled=$True
  $DUOGuide.IsEnabled=$True
}
Function DUOCheckBoxDeSelected (){
  $dot5.Source = $pathToOrangeTabIcon
  $IntegrationKey.IsEnabled=$False
  $SecretKey.IsEnabled=$False
  $APIHostName.IsEnabled=$False
  $ApplicationKey.IsEnabled=$False
  $GenerateAKey.IsEnabled=$False
  $DUOGuide.IsEnabled=$False
}
Function PassageIDCheckBoxSelected () {
  $dot5.Source = $pathToOrangeTabIcon
  $DUOCheckBox.IsChecked=$False
  $PassageIDTokenUri.IsEnabled=$True
  $PassageIDAuthUri.IsEnabled=$True
  $PassageIDValidationRedirectUri.IsEnabled=$True
  $ClientSecret.IsEnabled=$True
  $AllowedClientId.IsEnabled=$True
  $IntegrationKey.IsEnabled=$False
  $SecretKey.IsEnabled=$False
  $APIHostName.IsEnabled=$False
  $ApplicationKey.IsEnabled=$False
  $PassageIDGuide.IsEnabled=$True
}
Function PassageIDCheckBoxDeSelected () {
  $dot5.Source = $pathToOrangeTabIcon
  $PassageIDTokenUri.IsEnabled=$False
  $PassageIDAuthUri.IsEnabled=$False
  $PassageIDValidationRedirectUri.IsEnabled=$False
  $ClientSecret.IsEnabled=$False
  $AllowedClientId.IsEnabled=$False
  $PassageIDGuide.IsEnabled=$False
}
Function GenerateApplicationKeyDUO () {
  $GUIID = [guid]::NewGuid()
  $GUIID = $GUIID.ToString()
  $GUIID = $GUIID.replace("-", "")
  $ApplicationKey.Text = $GUIID 
}
Function IntegrationKeyChanged () {
  $dot5.Source = $pathToOrangeTabIcon
}
Function SecretKeyChanged () {
  $dot5.Source = $pathToOrangeTabIcon
}
Function APIHostNameChanged () {
  $dot5.Source = $pathToOrangeTabIcon
}
Function ApplicationKeyChanged () {
  $dot5.Source = $pathToOrangeTabIcon
}
Function PassageIDTokenUriChanged () {
  $dot5.Source = $pathToOrangeTabIcon
}
Function PassageIDAuthUriChanged () {
  $dot5.Source = $pathToOrangeTabIcon
}
Function PassageIDValidationRedirectUriChanged () {
  $dot5.Source = $pathToOrangeTabIcon
}
Function ClientSecretChanged () {
  $dot5.Source = $pathToOrangeTabIcon
}
Function AllowedClientIdChanged () {
  $dot5.Source = $pathToOrangeTabIcon
}
Function ApplyTab5 () {
  Write-Host "Applying settings from the 'MFA' Tab" -Fore Yellow
  # Validate the JSON Path before trying to pass data to the JSON
  $pathToJson = $JsonPathTextBox.Text
  If ($null -eq $pathToJson) {
    $dot4.Source = $pathToRedTabIcon
    $Apply4Text.Text = "No value for Json Path"
  } Else {
    Write-Host "Importing JSON" -Fore Yellow
    $json = Get-Content $pathToJson | ConvertFrom-Json
  }
  # Set Variables
  $IKey = $IntegrationKey.Text
  $SKey = $SecretKey.Text
  $DuoApi = $APIHostName.Text
  $DuoAppKey = $ApplicationKey.Text
  $PITokenUri = $PassageIDTokenUri.Text
  $PIAuthUri = $PassageIDAuthUri.Text
  $PIValidationRedirectUri = $PassageIDValidationRedirectUri.Text
  $PIClientSecret = $ClientSecret.Text
  $PIClientID = $AllowedClientId.Text
  # Check all the fields required are populated
  If (($DUOCheckBox.IsChecked -eq $true) -and ($IKey -eq "")) {
    $dot5.Source = $pathToRedTabIcon
    $Apply5Text.Text = "No value for DUO Integration Key"
  } ElseIf (($DUOCheckBox.IsChecked -eq $true) -and ($SKey -eq "")) {
    $dot5.Source = $pathToRedTabIcon
    $Apply5Text.Text = "No value for DUO Secret Key"
  } ElseIf (($DUOCheckBox.IsChecked -eq $true) -and ($DuoApi -eq "")) {
    $dot5.Source = $pathToRedTabIcon
    $Apply5Text.Text = "No value for DUO API Host Name"
  } ElseIf (($DUOCheckBox.IsChecked -eq $true) -and ($DuoAppKey -eq "")) {
    $dot5.Source = $pathToRedTabIcon
    $Apply5Text.Text = "No value for DUO Application Key"
  } ElseIf (($PassageIDCheckBox.IsChecked -eq $true) -and ($PITokenUri -eq "")) {
    $dot5.Source = $pathToRedTabIcon
    $Apply5Text.Text = "No value for PassageID Token URI"
  } ElseIf (($PassageIDCheckBox.IsChecked -eq $true) -and ($PIAuthUri -eq "")) {
    $dot5.Source = $pathToRedTabIcon
    $Apply5Text.Text = "No value for PassageID Auth URI"
  } ElseIf (($PassageIDCheckBox.IsChecked -eq $true) -and ($PIValidationRedirectUri -eq "")) {
    $dot5.Source = $pathToRedTabIcon
    $Apply5Text.Text = "No value for PassageID Validation Redirect URI"
  } ElseIf (($PassageIDCheckBox.IsChecked -eq $true) -and ($PIClientSecret -eq "")) {
    $dot5.Source = $pathToRedTabIcon
    $Apply5Text.Text = "No value for PassageID Client Secret"
  } ElseIf (($PassageIDCheckBox.IsChecked -eq $true) -and ($PIClientID -eq "")) {
    $dot5.Source = $pathToRedTabIcon
    $Apply5Text.Text = "No value for PassageID Allowed Client ID"
  } Else {
    # Pass DUO Integration Key to Json
    Write-Host "Writing value for DUO Integration Key to Json" -Fore Yellow
    $json.appSettings.IKey = $IKey
    # Pass DUO Secret Key to Json
    Write-Host "Writing value for DUO Secret Key to Json" -Fore Yellow
    $json.appSettings.SKey = $SKey
    # Pass DUO API Host Name to Json
    Write-Host "Writing value for DUO API Host Name to Json" -Fore Yellow
    $json.appSettings.duoApiHostUrl = $DuoApi
    # Pass DUO Application Key to Json
    Write-Host "Writing value for DUO Application Key to Json" -Fore Yellow
    $json.appSettings.AKey = $DuoAppKey
    # Pass PassageID Token URI to Json
    Write-Host "Writing value for PassageID Token URI to Json" -Fore Yellow
    $json.appSettings.PassageIDTokenUri = $PITokenUri
    # Pass PassageID Auth URI to Json
    Write-Host "Writing value for PassageID Auth URI to Json" -Fore Yellow
    $json.appSettings.PassageIDAuthUri = $PIAuthUri
    # Pass PassageID Validation Redirect URI to Json
    Write-Host "Writing value for PassageID Validation Redirect UR to Json" -Fore Yellow
    $json.appSettings.PassageIDValidationRedirectUri = $PIValidationRedirectUri
    # Pass PassageID Client Secret to Json
    Write-Host "Writing value for PassageID Client Secret to Json" -Fore Yellow
    $json.appSettings.ClientSecret = $PIClientSecret
    # Pass PassageID Allowed Client ID to Json
    Write-Host "Writing value for PassageID Allowed Client ID to Json" -Fore Yellow
    $json.appSettings.AllowedClientId = $PIClientID
    # Finalise and feedback
    $json | ConvertTo-Json | Set-Content $pathToJson
    $Apply5Text.Text = ""
    $dot5.Source = $pathToGreenTabIcon
    Write-Host "All values written to JSON for tab 5" -Fore Green
  }
}
#EndRegion
#Region - Tab6 Functions
Function InstallUmoX () {
  Write-Host "Installing/Upgrading UmoX" -Fore Yellow
  # Validate the JSON Path before trying to pass data to the JSON
  $pathToJson = $JsonPathTextBox.Text
  If ($null -eq $pathToJson) {
    $dot4.Source = $pathToRedTabIcon
    $Apply4Text.Text = "No value for Json Path"
  } Else {
    Write-Host "Importing JSON" -Fore Yellow
    Get-Content $pathToJson | ConvertFrom-Json
  }
  # Query Scope
  # Deployment Scopes where neither Force or NoBackup are selected
  $LocalMachine = [System.Net.Dns]::GetHostByName($env:computerName)
  If (($LocalMachine.HostName -eq "$IFQDN") -and ($LocalMachine.HostName -eq "$EFQDN") -and ($LocalMachine.HostName -eq "$DFQDN")) {
    .\install.ps1 -verbose -configFile $pathToJson -installFull
  } ElseIf (($LocalMachine.HostName -eq "$IFQDN") -and ($LocalMachine.HostName -eq "$EFQDN") -and ($LocalMachine.HostName -ne "$DFQDN")) {
    .\install.ps1 -verbose -configFile $pathToJson -installInternal -installExternal
  } ElseIf (($LocalMachine.HostName -eq "$IFQDN") -and ($LocalMachine.HostName -ne "$EFQDN") -and ($LocalMachine.HostName -ne "$DFQDN")) {
    .\install.ps1 -verbose -configFile $pathToJson -installInternal
  } ElseIf (($LocalMachine.HostName -ne "$IFQDN") -and ($LocalMachine.HostName -eq "$EFQDN") -and ($LocalMachine.HostName -ne "$DFQDN")) {
    .\install.ps1 -verbose -configFile $pathToJson -installExternal
  } ElseIf (($LocalMachine.HostName -ne "$IFQDN") -and ($LocalMachine.HostName -ne "$EFQDN") -and ($LocalMachine.HostName -eq "$DFQDN")) {
    .\install.ps1 -verbose -configFile $pathToJson -installDatabase
  }
  # Deployment Scopes where Force is selected
  ElseIf (($LocalMachine.HostName -eq "$IFQDN") -and ($LocalMachine.HostName -eq "$EFQDN") -and ($LocalMachine.HostName -eq "$DFQDN") -and ($ForceCheckBox.IsChecked -eq $True)) {
    .\install.ps1 -verbose -configFile $pathToJson -installFull -Force
  } ElseIf (($LocalMachine.HostName -eq "$IFQDN") -and ($LocalMachine.HostName -eq "$EFQDN") -and ($LocalMachine.HostName -ne "$DFQDN") -and ($ForceCheckBox.IsChecked -eq $True)) {
    .\install.ps1 -verbose -configFile $pathToJson -installInternal -installExternal -Force
  } ElseIf (($LocalMachine.HostName -eq "$IFQDN") -and ($LocalMachine.HostName -ne "$EFQDN") -and ($LocalMachine.HostName -ne "$DFQDN") -and ($ForceCheckBox.IsChecked -eq $True)) {
    .\install.ps1 -verbose -configFile $pathToJson -installInternal -Force
  } ElseIf (($LocalMachine.HostName -ne "$IFQDN") -and ($LocalMachine.HostName -eq "$EFQDN") -and ($LocalMachine.HostName -ne "$DFQDN") -and ($ForceCheckBox.IsChecked -eq $True)) {
    .\install.ps1 -verbose -configFile $pathToJson -installExternal -Force
  } ElseIf (($LocalMachine.HostName -ne "$IFQDN") -and ($LocalMachine.HostName -ne "$EFQDN") -and ($LocalMachine.HostName -eq "$DFQDN") -and ($ForceCheckBox.IsChecked -eq $True)) {
    .\install.ps1 -verbose -configFile $pathToJson -installDatabase -Force
  }
  # Deployment Scopes where NoBackup is selected
  ElseIf (($LocalMachine.HostName -eq "$IFQDN") -and ($LocalMachine.HostName -eq "$EFQDN") -and ($LocalMachine.HostName -eq "$DFQDN") -and ($NoBackupCheckBox.IsChecked -eq $True)) {
    .\install.ps1 -verbose -configFile $pathToJson -installFull -NoBackup
  } ElseIf (($LocalMachine.HostName -eq "$IFQDN") -and ($LocalMachine.HostName -eq "$EFQDN") -and ($LocalMachine.HostName -ne "$DFQDN") -and ($NoBackupCheckBox.IsChecked -eq $True)) {
    .\install.ps1 -verbose -configFile $pathToJson -installInternal -installExternal -NoBackup
  } ElseIf (($LocalMachine.HostName -eq "$IFQDN") -and ($LocalMachine.HostName -ne "$EFQDN") -and ($LocalMachine.HostName -ne "$DFQDN") -and ($NoBackupCheckBox.IsChecked -eq $True)) {
    .\install.ps1 -verbose -configFile $pathToJson -installInternal -NoBackup
  } ElseIf (($LocalMachine.HostName -ne "$IFQDN") -and ($LocalMachine.HostName -eq "$EFQDN") -and ($LocalMachine.HostName -ne "$DFQDN") -and ($NoBackupCheckBox.IsChecked -eq $True)) {
    .\install.ps1 -verbose -configFile $pathToJson -installExternal -NoBackup
  } ElseIf (($LocalMachine.HostName -ne "$IFQDN") -and ($LocalMachine.HostName -ne "$EFQDN") -and ($LocalMachine.HostName -eq "$DFQDN") -and ($NoBackupCheckBox.IsChecked -eq $True)) {
    .\install.ps1 -verbose -configFile $pathToJson -installDatabase -NoBackup
  }
  # Deployment Scopes where both Force and NoBackup are selected
  ElseIf (($LocalMachine.HostName -eq "$IFQDN") -and ($LocalMachine.HostName -eq "$EFQDN") -and ($LocalMachine.HostName -eq "$DFQDN") -and ($ForceCheckBox.IsChecked -eq $True) -and ($NoBackupCheckBox.IsChecked -eq $True)) {
    .\install.ps1 -verbose -configFile $pathToJson -installFull -Force -NoBackup
  } ElseIf (($LocalMachine.HostName -eq "$IFQDN") -and ($LocalMachine.HostName -eq "$EFQDN") -and ($LocalMachine.HostName -ne "$DFQDN") -and ($ForceCheckBox.IsChecked -eq $True) -and ($NoBackupCheckBox.IsChecked -eq $True)) {
    .\install.ps1 -verbose -configFile $pathToJson -installInternal -installExternal -Force -NoBackup
  } ElseIf (($LocalMachine.HostName -eq "$IFQDN") -and ($LocalMachine.HostName -ne "$EFQDN") -and ($LocalMachine.HostName -ne "$DFQDN") -and ($ForceCheckBox.IsChecked -eq $True) -and ($NoBackupCheckBox.IsChecked -eq $True)) {
    .\install.ps1 -verbose -configFile $pathToJson -installInternal -Force -NoBackup
  } ElseIf (($LocalMachine.HostName -ne "$IFQDN") -and ($LocalMachine.HostName -eq "$EFQDN") -and ($LocalMachine.HostName -ne "$DFQDN") -and ($ForceCheckBox.IsChecked -eq $True) -and ($NoBackupCheckBox.IsChecked -eq $True)) {
    .\install.ps1 -verbose -configFile $pathToJson -installExternal -Force -NoBackup
  } ElseIf (($LocalMachine.HostName -ne "$IFQDN") -and ($LocalMachine.HostName -ne "$EFQDN") -and ($LocalMachine.HostName -eq "$DFQDN") -and ($ForceCheckBox.IsChecked -eq $True) -and ($NoBackupCheckBox.IsChecked -eq $True)) {
    .\install.ps1 -verbose -configFile $pathToJson -installDatabase -Force -NoBackup
  }
} 
#>
#EndRegion
#endregion

#-------------------------------------------------------------#
#----Script Execution-----------------------------------------#
#-------------------------------------------------------------#

$Window = [Windows.Markup.XamlReader]::Parse($Xaml)

[xml]$xml = $Xaml

$xml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name $_.Name -Value $Window.FindName($_.Name) }

#Help Buttons per Tab
$Help1.Add_Click({Help $this $_})
$Help2.Add_Click({Help $this $_})
$Help3.Add_Click({Help $this $_})
$Help4.Add_Click({Help $this $_})
$Help5.Add_Click({Help $this $_})
$Help6.Add_Click({Help $this $_})
#Apply Buttons per Tab
$Apply1.Add_Click({ApplyTab1 $this $_})
$Apply2.Add_Click({ApplyTab2 $this $_})
$Apply3.Add_Click({ApplyTab3 $this $_})
$Apply4.Add_Click({ApplyTab4 $this $_})
$Apply5.Add_Click({ApplyTab5 $this $_})
$Apply6.Add_Click({ApplyTab6 $this $_})
#Tab1 Execution
$JsonPathValidateButton.Add_Click({ValidateJsonPath $this $_})
$JsonPathTextBox.Add_TextChanged({jsonChanged $this $_})
$sqlPassword.Add_PasswordChanged({sqlPwChanged $this $_})
$firebirdPassword.Add_PasswordChanged({fbPwChanged $this $_})
$InstallationDriveSelection.Add_SelectionChanged({installDriveChanged $this $_})
$DataDriveSelection.Add_SelectionChanged({dataDriveChanged $this $_})
$MultiTenantCheckBox.Add_Checked({MultiTenantChecked $this $_})
$MultiTenantCheckBox.Add_Unchecked({MultiTenantUnChecked $this $_})
$PostFixTextBox.Add_TextChanged({postFixChanged $this $_})
$CustomerPassword.Add_PasswordChanged({customerPwChanged $this $_})
$MFACheckBox.Add_Checked({MFAChecked $this $_})
$MFACheckBox.Add_Unchecked({MFAUnChecked $this $_})
$RAPICheckBox.Add_Checked({RAPIChecked $this $_})
$RAPICheckBox.Add_Unchecked({RAPIUnChecked $this $_})
$POMASCheckBox.Add_Checked({POMASChecked $this $_})
$POMASCheckBox.Add_Unchecked({POMASUnChecked $this $_})
$ForceCheckBox.Add_Checked({ForceCheckBoxChecked $this $_})
$ForceCheckBox.Add_Unchecked({ForceCheckBoxUnChecked $this $_})
$NoBackupCheckBox.Add_Checked({NoBackupCheckBoxChecked $this $_})
$NoBackupCheckBox.Add_Unchecked({NoBackupCheckBoxUnChecked $this $_})
#Tab2 Execution
$UmoControlIP.Add_TextChanged({ucIpChanged $this $_})
$OperatorPort.Add_TextChanged({ucOpPortChanged $this $_})
$ServicePort.Add_TextChanged({ucServicesPortChanged $this $_})
$DatabaseFQDN.Add_TextChanged({databaseFQDNChanged $this $_})
$InternalFQDN.Add_TextChanged({internalWebsiteFqdnChanged $this $_})
$InternalPort.Add_TextChanged({internalWebsitePortChanged $this $_})
$ExternalFQDN.Add_TextChanged({externalWebsiteFqdnChanged $this $_})
$ExternalPort.Add_TextChanged({externalWebsitePortChanged $this $_})
$RAPIPort.Add_TextChanged({rapiPortChanged $this $_})
$POMASPort.Add_TextChanged({pomasPortChanged $this $_})
#Tab3 Execution
$ScanForSQLInstance.Add_Click({ScanForSQL $this $_})
$SQLInstance.Add_TextChanged({SQLInstanceChanged $this $_})
$SQLMirrorModeCheckBox.Add_Checked({SQLMirrorModeChecked $this $_})
$SQLMirrorModeCheckBox.Add_Unchecked({SQLMirrorModeUnChecked $this $_})
$UcDbIpv4.Add_TextChanged({UcDbIpV4Changed $this $_})
$UcDbAlias.Add_TextChanged({UcDbAliasChanged $this $_})
$POMASUsername.Add_TextChanged({POMASUsernameChanged $this $_})
$POMASPassword.Add_PasswordChanged({POMASPasswordChanged $this $_})
#Tab4 Execution
$EmailServer.Add_TextChanged({EmailServerChanged $this $_})
$EmailServerPort.Add_TextChanged({EmailServerPortChanged $this $_})
$EmailUsername.Add_TextChanged({EmailUsernameChanged $this $_})
$EmailPassword.Add_PasswordChanged({EmailPasswordChanged $this $_})
$EmailAddress.Add_TextChanged({EmailAddressChanged $this $_})
#Tab5 Execution
$DUOCheckBox.Add_Checked({DUOCheckBoxSelected $this $_})
$DUOCheckBox.Add_Unchecked({DUOCheckBoxDeSelected $this $_})
$PassageIDCheckBox.Add_Checked({PassageIDCheckBoxSelected $this $_})
$PassageIDCheckBox.Add_Unchecked({PassageIDCheckBoxDeSelected $this $_})
$GenerateAKey.Add_Click({GenerateApplicationKeyDUO $this $_})
$IntegrationKey.Add_TextChanged({IntegrationKeyChanged $this $_})
$SecretKey.Add_TextChanged({SecretKeyChanged $this $_})
$APIHostName.Add_TextChanged({APIHostNameChanged $this $_})
$ApplicationKey.Add_TextChanged({ApplicationKeyChanged $this $_})
$PassageIDTokenUri.Add_TextChanged({PassageIDTokenUriChanged $this $_})
$PassageIDAuthUri.Add_TextChanged({PassageIDAuthUriChanged $this $_})
$PassageIDValidationRedirectUri.Add_TextChanged({PassageIDValidationRedirectUriChanged $this $_})
$ClientSecret.Add_TextChanged({ClientSecretChanged $this $_})
$AllowedClientId.Add_TextChanged({AllowedClientIdChanged $this $_})
#Tab6 Execution
$Install.Add_Click({InstallUmoX $this $_})

$Window.ShowDialog()