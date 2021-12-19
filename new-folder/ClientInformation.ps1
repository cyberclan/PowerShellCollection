$nl = [System.Environment]::NewLine
$hostname = hostname
$IPv4 = (Get-Wmiobject Win32_NetworkAdapterConfiguration -Filter "IPEnabled=true").IpAddress[0]
$IPv6 = (Get-Wmiobject Win32_NetworkAdapterConfiguration -Filter "IPEnabled=true").IpAddress[1]
$DefaultIPGateway = (Get-Wmiobject Win32_NetworkAdapterConfiguration -Filter "IPEnabled=true").DefaultIPGateway
$DNSDomain = (Get-Wmiobject Win32_NetworkAdapterConfiguration -Filter "IPEnabled=true").DNSDomain
$SerialNumber = (Get-WmiObject -Class Win32_BIOS).SerialNumber
$Manufacturer = (Get-WmiObject -Class Win32_BIOS).Manufacturer

$osName = ((Get-CimInstance Win32_OperatingSystem).Name).Split("|")[0]
$osVersion = (Get-CimInstance Win32_OperatingSystem).Version
$buildNumber = (Get-CimInstance Win32_OperatingSystem).BuildNumber


#Clear-Host
#Get-WmiObject Win32_Computersystem | Format-List Name, Description, TotalPhysicalMemory, NumberOfLogicalProcessors 
#(Get-WMIObject Win32_OperatingSystem).Description

$String = "Computer-Informationen" + $nl +
          "Computername: " + $hostname + $nl + 
          "Domain-Name: " + $env:USERDOMAIN + $nl +
          $nl + "Profil-Informationen" + $nl +
          "Username: " + $env:USERNAME + $nl +  
          "Profile-Path: " + $env:USERPROFILE + $nl +
          $nl + "Netzwerk-Informationen" + $nl +
          "IPv4-Address: " + $IPv4 + $nl +
          "IPv6-Address: " + $IPv6 + $nl +
          "Default-Gateway: " + $DefaultIPGateway + $nl +
          "DNS-Domain: " + $DNSDomain + $nl +
          $nl + "Hersteller-Informationen" + $nl +
          "SerialNumber: " + $SerialNumber + $nl +
          "Manufacturer: " + $Manufacturer + $nl +
          $nl + "Betriebssystem-Informationen" + $nl +
          "OS Name: " + $osName + $nl +
          "OS Version: " + $osVersion + $nl +
          "Build Number: " + $buildNumber

$statusbar = "Information"
#Write-Host $String
[System.Reflection.Assembly]::LoadWithPartialName(“System.Windows.Forms”) > null
[Windows.Forms.MessageBox]::Show($string, $statusbar, [Windows.Forms.MessageBoxButtons]::OK, [Windows.Forms.MessageBoxIcon]::Information) > null

