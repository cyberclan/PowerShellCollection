<#
    Date: 18.10.2021
    Coder: Abdullah Akten
    Script-Name: Administrative-Tools.ps1
#>

<#
    Controllers 
#>
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
            Get-SubMenuForADUserManagement
            ShowMenu
            break;
        }
        "q" {
            QuitProgram
        }
        default {
            Write-Host "Ungültige Eingabe für das Haupt-Menü!" -ForegroundColor Red
            ShowMenu
        }
    }
}

Function SubMenuForADUserManagementExecutionController
{
    switch (Read-Host "Wählen Sie einen Menüpunkt aus"){
        1 {
            #Create-ADUser
            Get-SubMenuForADUserManagementAdd
            break;
          }
        2 {
            #Show-ADUser
            Get-SubMenuForADUserManagementShow
            break;
        }
        3 {
            #Edit-ADUser
            SubMenuForADUserManagement
            break;
          }
        4 {
            #DeleteOrDisable-ADUser
            SubMenuForADUserManagement
            break;
        }
        "b" {
            Write-Host "Sie kehren zum Hauptmenü zurück" -ForegroundColor Green
            ShowMenu
            break;
        }
        "q" {
            QuitProgram
        }
        default {
            Write-Host "Ungültige Eingabe für das Menü AD-Verwaltung!" -ForegroundColor Red
            SubMenuForADUserManagement
        }
    }
}

Function SubMenuForADUserManagementAddExecutionController
{
    switch (Read-Host "Wählen Sie einen Menüpunkt aus"){
        1 {
            #Create-SingleADUser
            Get-SubMenuForADUserManagementAdd
            break;
          }
        2 {
            #Create-SingleADUserFromCopy
            Get-SubMenuForADUserManagementAdd
            break;
        }
        3 {
            #Create-MultipleADUserFromCSV
            Get-SubMenuForADUserManagementAdd
            break;
          }
        "b" {
            Write-Host "Sie kehren zum Active Directory Benutzer Verwaltung-Menü zurück" -ForegroundColor Green
            Get-SubMenuForADUserManagement
            break;
        }
        "q" {
            QuitProgram
        }
        default {
            Write-Host "Ungültige Eingabe für das Menü AD-Verwaltung - Anlegen von Benutzer!" -ForegroundColor Red
            SubMenuForADUserManagementAddExecutionController
        }
    }
}

Function SubMenuForADUserManagementShowExecutionController
{
    switch (Read-Host "Wählen Sie einen Menüpunkt aus"){
        5 {
            #Create-ADUser
            Get-SubMenuForADUserManagementShow
            break;
          }
        6 {
            #Show-ADUser
            Get-SubMenuForADUserManagementShow
            break;
        }
        7 {
            #DisableOrDelete-ADUser
            Get-SubMenuForADUserManagementShow
            break;
          }
        "b" {
            Write-Host "Sie kehren zum Active Directory Benutzer Verwaltung-Menü zurück" -ForegroundColor Green
            Get-SubMenuForADUserManagement
            break;
        }
        "q" {
            QuitProgram
        }
        default {
            Write-Host "Ungültige Eingabe für das Menü AD-Verwaltung - Anlegen von Benutzer!" -ForegroundColor Red
            SubMenuForADUserManagementShowExecutionController
        }
    }
}

<#
    Menu Structure
#>
Function ShowMenu
{
    
    $MenuName = "Haupt-Menü"
    $MenuStruktur = Get-NewLine
    $MenuStruktur += $MenuName + $(Get-NewLine)
    $MenuStruktur += "1 = Defragmentierung von Laufwerk C $(Get-NewLine)"
    $MenuStruktur += "2 = Powershell als Administrator starten ( neues Fenster ) $(Get-NewLine)"
    $MenuStruktur += "3 = Active Directory Benutzer Verwaltung $(Get-NewLine)"
    $MenuStruktur += "q = Programm Beenden $(Get-NewLine)"
    $MenuStruktur += Get-NewLine

    Write-Host $MenuStruktur
    ExecutionController
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
    $SubMenuForADUserManagement += "b = Zurück zum Haupt-Menü $(Get-NewLine)"
    $SubMenuForADUserManagement += "q = Programm Beenden $(Get-NewLine)"
    $SubMenuForADUserManagement += Get-NewLine

    Write-Host $SubMenuForADUserManagement
    SubMenuForADUserManagementExecutionController
}

Function Get-SubMenuForADUserManagementAdd
{
    $MenuName = "Active Directory Benutzer neu anlegen Menü"
    $SubMenuForADUserManagementAdd = Get-NewLine
    $SubMenuForADUserManagementAdd += $MenuName + $(Get-NewLine)
    $SubMenuForADUserManagementAdd += "1 = Einen einzelnen Active Directory Benutzer erstellen $(Get-NewLine)"
    $SubMenuForADUserManagementAdd += "2 = Einen einzelnen Active Directory Benutzer mit Referenz erstellen - ( Benutzer Kopieren ) $(Get-NewLine)"
    $SubMenuForADUserManagementAdd += "3 = Mehrere Benutzer mit Hilfe von einer CSV Datei erstellen $(Get-NewLine)"
    $SubMenuForADUserManagementAdd += "b = Zurück zum Active Directory Benutzer Verwaltung-Menü $(Get-NewLine)"
    $SubMenuForADUserManagementAdd += "q = Programm Beenden $(Get-NewLine)"
    $SubMenuForADUserManagementAdd += Get-NewLine

    Write-Host $SubMenuForADUserManagementAdd
    SubMenuForADUserManagementAddExecutionController
}

Function Get-SubMenuForADUserManagementShow
{
    $MenuName = "Active Directory Benutzer anzeigen Menü"
    $SubMenuForADUserManagementShow = Get-NewLine
    $SubMenuForADUserManagementShow += $MenuName + $(Get-NewLine)
    $SubMenuForADUserManagementShow += "5 = Einen einzelnen Active Directory Benutzer erstellen $(Get-NewLine)"
    $SubMenuForADUserManagementShow += "6 = Einen einzelnen Active Directory Benutzer mit Referenz erstellen - ( Benutzer Kopieren ) $(Get-NewLine)"
    $SubMenuForADUserManagementShow += "7 = Mehrere Benutzer mit Hilfe von einer CSV Datei erstellen $(Get-NewLine)"
    $SubMenuForADUserManagementShow += "b = Zurück zum Active Directory Benutzer Verwaltung-Menü $(Get-NewLine)"
    $SubMenuForADUserManagementShow += "q = Programm Beenden $(Get-NewLine)"
    $SubMenuForADUserManagementShow += Get-NewLine

    Write-Host $SubMenuForADUserManagementShow
    SubMenuForADUserManagementShowExecutionController
}

Function CheckApplicationStartMethodMenu
{
    $MenuName = "Applikation Start Methode Menü"
    $CheckApplicationStartMethodMenu = Get-NewLine
    $CheckApplicationStartMethodMenu += $MenuName + $(Get-NewLine)
    $CheckApplicationStartMethodMenu += "c = Applikation in der Console (Core) ausführen $(Get-NewLine)"
    $CheckApplicationStartMethodMenu += "g = Applikation in der GUI starten $(Get-NewLine)"
    $CheckApplicationStartMethodMenu += "q = Programm Beenden $(Get-NewLine)"
    $CheckApplicationStartMethodMenu += Get-NewLine

    Write-Host $CheckApplicationStartMethodMenu
    CheckApplicationStartMethodController
}

<#
    Function Library
#>
Function Get-NewLine
{
    return $newLine = [System.Environment]::NewLine
}

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

Function CheckElevation
{
    if ( `
        ([Security.Principal.WindowsPrincipal] `
          [Security.Principal.WindowsIdentity]::GetCurrent() `
        ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) `
    )
    {
        # Execute with Administrator Priviledge
        #ShowMenu
        CheckApplicationStartMethodMenu
    
    }else {
        # Show Message if does not executed with administrative priviledge!
        Write-Host "Bitte das Script als Administrator ausführen!" -ForegroundColor Red
    }
}

Function CheckApplicationStartMethodController
{
    switch (Read-Host "Wählen Sie aus wie Sie die Applikation Starten wollen"){
        "c" {
            StartApplicationAsCore
            CheckApplicationStartMethodMenu
            break;
          }
        "g" {
            StartApplicationAsGUI
            CheckApplicationStartMethodMenu
            break;
        }
        "q" {
            QuitProgram
        }
        default {
            Write-Host "Ungültige Eingabe für das Starten der Applikation!" -ForegroundColor Red
            CheckApplicationStartMethodController
        }
    }
}

Function StartApplicationAsCore
{
    ShowMenu
}

Function StartApplicationAsGUI
{
    #ShowGUI
    . ./ClientInformation.ps1
}

Function StartElevatedConsole
{
    $StartInfo = New-Object System.Diagnostics.ProcessStartInfo
    $StartInfo.FileName = "$PSHOME\powershell.exe"
    $StartInfo.Arguments = "-NoExit -Command `$Host.UI.RawUI.WindowTitle=`'Fenster: Administrator Berechtigung`'"
    $StartInfo.Verb = "runAs"
    [System.Diagnostics.Process]::Start($StartInfo)
}

Function QuitProgram
{
    $ScriptName = $MyInvocation.ScriptName
    Write-Host "Programm $ScriptName wird beendet!" -ForegroundColor Green
    exit 0;
}

<#
    Start Program
#>
Function StartProgram
{
    CheckElevation
}

StartProgram
