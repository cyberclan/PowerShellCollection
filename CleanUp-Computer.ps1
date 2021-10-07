Function OptimizeVolume
{
    param (
        [String]$Volumename
    )

    $oldTime = Get-Date
    Write-Host "Scan des Laufwerks $Volumename wurde gestartet." -ForegroundColor Green
    Optimize-Volume -DriveLetter $Volumename -Analyze -Defrag -Verbose
    $newTime = Get-Date
    $TimeDiff = $newTime - $oldTime
    Write-Host "Scan des Laufwerks $Volumename wurde beendet." -ForegroundColor Green
    $TimeResult = "Der Prozess dauerte $TimeDiff an Zeit."
    Write-Host $TimeResult -ForegroundColor Green
}

Function ExecutionController
{
    switch (Read-Host "Wählen Sie einen Menüpunkt aus"){
        1 {
            OptimizeVolume -Volumename C
            ShowMenu
            break;
          }
        2 {
            StartElevatedConsole
            ShowMenu
            break;
        }
        3 {
            $ScriptName = $MyInvocation.ScriptName
            Write-Host "Programm $ScriptName wird beendet!" -ForegroundColor Green
                exit 0;
          }
        4 {
            Get-SubMenuForADUserManagement
            ShowMenu
            break;
        }
        default {
            Write-Host "Ungültige Eingabe für das Haupt-Menü!" -ForegroundColor Red
            ShowMenu
        }
    }
}

Function ShowMenu {
    
    $MenuName = "Haupt-Menü"
    $MenuStruktur = Get-NewLine
    $MenuStruktur += $MenuName + $(Get-NewLine)
    $MenuStruktur += "1 = Defragmentierung von Laufwerk C $(Get-NewLine)"
    $MenuStruktur += "2 = Powershell als Administrator starten ( neues Fenster ) $(Get-NewLine)"
    $MenuStruktur += "3 = Programm Beenden $(Get-NewLine)"
    $MenuStruktur += "4 = Active Directory Benutzer Verwaltung $(Get-NewLine)"
    $MenuStruktur += Get-NewLine

    Write-Host $MenuStruktur
    ExecutionController
}

Function CheckElevation
{

    if ( `
        ([Security.Principal.WindowsPrincipal] `
          [Security.Principal.WindowsIdentity]::GetCurrent() `
        ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) `
    )
    {
        # Ausführen der Aufgaben als Administrator
        ShowMenu
    
    }else {
        # Sonst Meldung an den Auszuführenden!
        Write-Host "Bitte das Script als Administrator ausführen!" -ForegroundColor Red
    }
}

Function StartProgram
{
    CheckElevation
}

Function StartElevatedConsole
{
    $StartInfo = New-Object System.Diagnostics.ProcessStartInfo
    $StartInfo.FileName = "$PSHOME\powershell.exe"
    $StartInfo.Arguments = "-NoExit -Command `$Host.UI.RawUI.WindowTitle=`'Fenster: Administrator Berechtigung`'"
    $StartInfo.Verb = "runAs"
    [System.Diagnostics.Process]::Start($StartInfo)
}

Function Get-SubMenuForADUserManagement
{
    $MenuName = "Active Directory Benutzer Verwaltung-Menü"
    $SubMenuForADUserManagement = Get-NewLine
    $SubMenuForADUserManagement += $MenuName + $(Get-NewLine)
    $SubMenuForADUserManagement += "1 = Active Directory Benutzer neu anlegen $(Get-NewLine)"
    $SubMenuForADUserManagement += "2 = Active Directory Benutzer anzeigen $(Get-NewLine)"
    $SubMenuForADUserManagement += "3 = Active Directory Benutzer bearbeiten $(Get-NewLine)"
    $SubMenuForADUserManagement += "4 = Active Directory Benutzer entfernen / deaktivieren $(Get-NewLine)"
    $SubMenuForADUserManagement += "5 = Zurück zum Haupt-Menü $(Get-NewLine)"
    $SubMenuForADUserManagement += Get-NewLine

    Write-Host $SubMenuForADUserManagement
    SubMenuForADUserManagementExecutionController
}

Function SubMenuForADUserManagementExecutionController
{
    switch (Read-Host "Wählen Sie einen Menüpunkt aus"){
        1 {
            #Create-ADUser
            SubMenuForADUserManagement
            break;
          }
        2 {
            #Show-ADUser
            SubMenuForADUserManagement
            break;
        }
        3 {
            #DisableOrDelete-ADUser
            SubMenuForADUserManagement
            break;
          }
        4 {
            #Edit-ADUser
            SubMenuForADUserManagement
            break;
        }
        5 {
            Write-Host "Sieh kehren zum Hauptmenü zurück" -ForegroundColor Green
            ShowMenu
            break;
        }
        default {
            Write-Host "Ungültige Eingabe für das Menü AD-Verwaltung!" -ForegroundColor Red
            SubMenuForADUserManagement
        }
    }
}

Function Get-NewLine
{
    return $newLine = [System.Environment]::NewLine
}

StartProgram

