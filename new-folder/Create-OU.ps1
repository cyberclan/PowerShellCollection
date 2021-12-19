New-ADOrganizationalUnit -Description:"Dieser OU ist das Erste Objekt Objekt und dient zur Testzwecken." `
                         -Name:"Test-OU" `
                         -Path:"DC=d-trust,DC=de" `
                         -ProtectedFromAccidentalDeletion:$true `
                         -Server:"WinServ2022DC01.d-trust.de"

Set-ADObject -Identity:"OU=Test-OU,DC=d-trust,DC=de" -ProtectedFromAccidentalDeletion:$true -Server:"WinServ2022DC01.d-trust.de"
# zweite OU
New-ADOrganizationalUnit -Description:"Dies ist ein zweiter Test" `
                         -Name:"Test-SubOU-2" `
                         -Path: "OU=Test-OU,DC=d-trust,DC=de" `
                         -Server:"WinServ2022DC01.d-trust.de"

Set-ADObject -Identity:"OU=Test-OU,DC=d-trust,DC=de" -ProtectedFromAccidentalDeletion:$true -Server:"WinServ2022DC01.d-trust.de" 

# dritte OU
New-ADOrganizationalUnit -City:"Berlin" -Description:"Dies dient zur Testzwecken" -ManagedBy:"CN=Administrator,CN=Users,DC=d-trust,DC=de" `
                         -Name:"Test-OU-3" -OtherAttributes:@{"c"="DE";"co"="Germany";"countryCode"="276"} `
                         -Path:"OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" -PostalCode:"13351" `
                         -ProtectedFromAccidentalDeletion:$true -Server:"WinServ2022DC01.d-trust.de" -State:"Berlin" -Street:"Müller Straße 45"

Set-ADObject -Identity:"OU=Test-OU-3,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" `
             -ProtectedFromAccidentalDeletion:$true `
             -Server:"WinServ2022DC01.d-trust.de"
# ergänzen von Eigenschaften      
Set-ADOrganizationalUnit -Identity:"OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" `
                         -ManagedBy:"CN=Abdullah Siddik. Akten,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" -Server:"WinServ2022DC01.d-trust.de"

Set-ADOrganizationalUnit -Identity:"OU=Test-OU-3,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" -ManagedBy:$null -Server:"WinServ2022DC01.d-trust.de" 

#Examples:
#---------- Example 1: Get all of the OUs in a domain ----------
Get-ADOrganizationalUnit -Filter 'Name -like "*"' | Format-Table Name, DistinguishedName

#-------- Example 2: Get an OU by its distinguished name --------
Get-ADOrganizationalUnit -Identity 'OU=Test-OU-3,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de' | Format-Table `
Name,Country,PostalCode,City,StreetAddress,State

#------------------- Example 3: Get child OUs -------------------
Get-ADOrganizationalUnit -LDAPFilter '(name=*)' -SearchBase 'OU=Test-OU-3,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de' -SearchScope OneLevel | `
Format-Table Name,Country,PostalCode,City,StreetAddress,State

#DistinguishedName, LinkedGroupPolicyObjects {}, ManagedBy, ObjectClass, ObjectGUID
#Base, OneLevel, Subtree

Get-ADOrganizationalUnit -LDAPFilter '(name=*)' -SearchBase 'OU=Test-OU,DC=d-trust,DC=de' -SearchScope Subtree | `
Format-Table Name,Country,PostalCode,City,StreetAddress,State, DistinguishedName

# Move
Set-ADObject -Identity:"OU=Test-OU-3,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" -ProtectedFromAccidentalDeletion:$false `
             -Server:"WinServ2022DC01.d-trust.de"

Move-ADObject -Identity:"OU=Test-OU-3,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" -Server:"WinServ2022DC01.d-trust.de" `
              -TargetPath:"OU=Test-SubOU-2,OU=Test-OU,DC=d-trust,DC=de"

# after moving please update path: OU=Test-OU-3,OU=Test-SubOU-2,OU=Test-OU,DC=d-trust,DC=de

Set-ADObject -Identity:"OU=Test-OU-3,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" -ProtectedFromAccidentalDeletion:$true `
             -Server:"WinServ2022DC01.d-trust.de"

# Standard-Creating is only NameOfOU, ProtectFlag and TargetPath

# Delete
# empty content
Set-ADObject -Identity:"OU=Test-OU-7,OU=Test-OU-5,OU=Test-OU-3,OU=Test-SubOU-2,OU=Test-OU,DC=d-trust,DC=de" `
             -ProtectedFromAccidentalDeletion:$false -Server:"WinServ2022DC01.d-trust.de"

Remove-ADObject -Confirm:$false -Identity:"OU=Test-OU-7,OU=Test-OU-5,OU=Test-OU-3,OU=Test-SubOU-2,OU=Test-OU,DC=d-trust,DC=de" `
                -Server:"WinServ2022DC01.d-trust.de"

# with containing contents like Test-OU-6 in Test-OU-5 ( Subtree Deletion )
# 1. confirm subtee deletion and 2. the protection of accidental deletion is off
Set-ADObject -Identity:"OU=Test-OU-5,OU=Test-OU-3,OU=Test-SubOU-2,OU=Test-OU,DC=d-trust,DC=de" -ProtectedFromAccidentalDeletion:$false `
             -Server:"WinServ2022DC01.d-trust.de"

Remove-ADObject -Confirm:$false `
                -Identity:"OU=Test-OU-5,OU=Test-OU-3,OU=Test-SubOU-2,OU=Test-OU,DC=d-trust,DC=de" `
                -Recursive:$true -Server:"WinServ2022DC01.d-trust.de"

# Command
Get-Command *ADOrg*

CommandType     Name                                               Version    Source                                                                   
-----------     ----                                               -------    ------                                                                   
Cmdlet          Get-ADOrganizationalUnit                           1.0.1.0    ActiveDirectory                                                          
Cmdlet          New-ADOrganizationalUnit                           1.0.1.0    ActiveDirectory                                                          
Cmdlet          Remove-ADOrganizationalUnit                        1.0.1.0    ActiveDirectory                                                          
Cmdlet          Set-ADOrganizationalUnit                           1.0.1.0    ActiveDirectory

# Documentation
NAME
    Get-ADOrganizationalUnit
    
SYNOPSIS
    Gets one or more Active Directory organizational units.
    
    
SYNTAX
    Get-ADOrganizationalUnit [-AuthType {Negotiate | Basic}] [-Credential <PSCredential>] -Filter <String> [-Properties <String[]>] [-ResultPageSize 
    <Int32>] [-ResultSetSize <Int32>] [-SearchBase <String>] [-SearchScope {Base | OneLevel | Subtree}] [-Server <String>] [<CommonParameters>]
    
    Get-ADOrganizationalUnit [-Identity] <ADOrganizationalUnit> [-AuthType {Negotiate | Basic}] [-Credential <PSCredential>] [-Partition <String>] 
    [-Properties <String[]>] [-Server <String>] [<CommonParameters>]
    
    Get-ADOrganizationalUnit [-AuthType {Negotiate | Basic}] [-Credential <PSCredential>] -LDAPFilter <String> [-Properties <String[]>] 
    [-ResultPageSize <Int32>] [-ResultSetSize <Int32>] [-SearchBase <String>] [-SearchScope {Base | OneLevel | Subtree}] [-Server <String>] 
    [<CommonParameters>]
    
    
DESCRIPTION
    The Get-ADOrganizationalUnit cmdlet gets an organizational unit (OU) object or performs a search to get multiple OUs.
    
    The Identity parameter specifies the Active Directory OU to get. You can identify an OU by its distinguished name or GUID. You can also set the 
    parameter to an OU object variable, such as `$<localOrganizationalunitObject>` or pass an OU object through the pipeline to the Identity parameter.
    
    To search for and retrieve more than one OU, use the Filter or LDAPFilter parameters. The Filter parameter uses the PowerShell Expression Language 
    to write query strings for Active Directory. PowerShell Expression Language syntax provides rich type conversion support for value types received 
    by the Filter parameter. For more information about the Filter parameter syntax, type `Get-Help about_ActiveDirectory_Filter`. If you have 
    existing Lightweight Directory Access Protocol (LDAP) query strings, you can use the LDAPFilter parameter.
    
    This cmdlet gets a default set of OU object properties. To get additional properties, use the Properties parameter. For more information about the 
    how to determine the properties for computer objects, see the Properties parameter description.
    

RELATED LINKS
    Online Version: https://docs.microsoft.com/powershell/module/activedirectory/get-adorganizationalunit?view=windowsserver2022-ps&wt.mc_id=ps-gethelp
    New-ADOrganizationalUnit 
    Remove-ADOrganizationalUnit 
    Set-ADOrganizationalUnit 

REMARKS
    To see the examples, type: "get-help Get-ADOrganizationalUnit -examples".
    For more information, type: "get-help Get-ADOrganizationalUnit -detailed".
    For technical information, type: "get-help Get-ADOrganizationalUnit -full".
    For online help, type: "get-help Get-ADOrganizationalUnit -online"

#################################################################################################################
# get WhenCreated and WhenChanged Information
Get-ADOrganizationalUnit -LDAPFilter '(name=*)' -SearchBase 'OU=Test-OU,DC=d-trust,DC=de' -SearchScope Subtree | `
Format-Table Name,Country,PostalCode,City,StreetAddress,State, DistinguishedName 

# Rename an OU
# Apply a Group Policy to an OU

New-GPLink -Name "Block Software" -Target "OU=Districts,OU=IT,dc=enterprise,dc=com" -LinkEnabled Yes -Enforced Yes

Move-ADObject -Identity "CN=John Brown,CN=Users,DC=enterprise,DC=com" -TargetPath "OU=Districts,OU=IT,DC=Enterprise,DC=Com"
Move-ADObject -Identity "CN=R07GF,OU=CEO,DC=enterprise,DC=com" -TargetPath "CN=Computers,DC=Enterprise,DC=Com"

# Specify target OU. This is where users will be moved.
$TargetOU =  "OU=Districts,OU=IT,DC=enterprise,DC=com"
# Specify CSV path. Import CSV file and assign it to a variable. 
$Imported_csv = Import-Csv -Path "C:\temp\MoveList.csv" 

$Imported_csv | ForEach-Object {
     # Retrieve DN of user.
     $UserDN  = (Get-ADUser -Identity $_.Name).distinguishedName
     # Move user to target OU.
     Move-ADObject  -Identity $UserDN  -TargetPath $TargetOU
   
 }

 # Specify path to the text file with the computer account names.
$computers = Get-Content C:\Temp\Computers.txt

# Specify the path to the OU where computers will be moved.
$TargetOU   =  "OU=Districts,OU=IT,DC=enterprise,DC=com" 
ForEach( $computer in $computers){
    Get-ADComputer $computer |
    Move-ADObject -TargetPath $TargetOU

}

PS C:\Users\Administrator> Get-Command *GP*

CommandType     Name                                               Version    Source                                                                   
-----------     ----                                               -------    ------                                                                   
Alias           Get-GPPermissions                                  1.0.0.0    GroupPolicy                                                              
Alias           gp -> Get-ItemProperty                                                                                                                 
Alias           gps -> Get-Process                                                                                                                     
Alias           gpv -> Get-ItemPropertyValue                                                                                                           
Alias           Set-GPPermissions                                  1.0.0.0    GroupPolicy                                                              
Function        Get-LogProperties                                  1.0.0.0    PSDiagnostics                                                            
Function        Open-NetGPO                                        2.0.0.0    NetSecurity                                                              
Function        Save-NetGPO                                        2.0.0.0    NetSecurity                                                              
Function        Set-LogProperties                                  1.0.0.0    PSDiagnostics                                                            
Cmdlet          Backup-GPO                                         1.0.0.0    GroupPolicy                                                              
Cmdlet          Block-GPInheritance                                1.0.0.0    GroupPolicy                                                              
Cmdlet          Copy-GPO                                           1.0.0.0    GroupPolicy                                                              
Cmdlet          Get-GPInheritance                                  1.0.0.0    GroupPolicy                                                              
Cmdlet          Get-GPO                                            1.0.0.0    GroupPolicy                                                              
Cmdlet          Get-GPOReport                                      1.0.0.0    GroupPolicy                                                              
Cmdlet          Get-GPPermission                                   1.0.0.0    GroupPolicy                                                              
Cmdlet          Get-GPPrefRegistryValue                            1.0.0.0    GroupPolicy                                                              
Cmdlet          Get-GPRegistryValue                                1.0.0.0    GroupPolicy                                                              
Cmdlet          Get-GPResultantSetOfPolicy                         1.0.0.0    GroupPolicy                                                              
Cmdlet          Get-GPStarterGPO                                   1.0.0.0    GroupPolicy                                                              
Cmdlet          Get-TroubleshootingPack                            1.0.0.0    TroubleshootingPack                                                      
Cmdlet          Import-GPO                                         1.0.0.0    GroupPolicy                                                              
Cmdlet          Invoke-GPUpdate                                    1.0.0.0    GroupPolicy                                                              
Cmdlet          Invoke-TroubleshootingPack                         1.0.0.0    TroubleshootingPack                                                      
Cmdlet          New-GPLink                                         1.0.0.0    GroupPolicy                                                              
Cmdlet          New-GPO                                            1.0.0.0    GroupPolicy                                                              
Cmdlet          New-GPStarterGPO                                   1.0.0.0    GroupPolicy                                                              
Cmdlet          Remove-GPLink                                      1.0.0.0    GroupPolicy                                                              
Cmdlet          Remove-GPO                                         1.0.0.0    GroupPolicy                                                              
Cmdlet          Remove-GPPrefRegistryValue                         1.0.0.0    GroupPolicy                                                              
Cmdlet          Remove-GPRegistryValue                             1.0.0.0    GroupPolicy                                                              
Cmdlet          Rename-GPO                                         1.0.0.0    GroupPolicy                                                              
Cmdlet          Restore-GPO                                        1.0.0.0    GroupPolicy                                                              
Cmdlet          Set-GPInheritance                                  1.0.0.0    GroupPolicy                                                              
Cmdlet          Set-GPLink                                         1.0.0.0    GroupPolicy                                                              
Cmdlet          Set-GPPermission                                   1.0.0.0    GroupPolicy                                                              
Cmdlet          Set-GPPrefRegistryValue                            1.0.0.0    GroupPolicy                                                              
Cmdlet          Set-GPRegistryValue                                1.0.0.0    GroupPolicy                                                              
Application     chgport.exe                                        10.0.20... C:\Windows\system32\chgport.exe                                          
Application     dcgpofix.exe                                       10.0.20... C:\Windows\system32\dcgpofix.exe                                         
Application     gpedit.msc                                         0.0.0.0    C:\Windows\system32\gpedit.msc                                           
Application     gpfixup.exe                                        10.0.20... C:\Windows\system32\gpfixup.exe                                          
Application     gpmc.msc                                           0.0.0.0    C:\Windows\system32\gpmc.msc                                             
Application     gpme.msc                                           0.0.0.0    C:\Windows\system32\gpme.msc                                             
Application     gpresult.exe                                       10.0.20... C:\Windows\system32\gpresult.exe                                         
Application     gpscript.exe                                       10.0.20... C:\Windows\system32\gpscript.exe                                         
Application     gptedit.msc                                        0.0.0.0    C:\Windows\system32\gptedit.msc                                          
Application     gpupdate.exe                                       10.0.20... C:\Windows\system32\gpupdate.exe                                         
Application     MBR2GPT.EXE                                        0.0.0.0    C:\Windows\system32\MBR2GPT.EXE                                          

PS C:\Users\Administrator> Get-Command *GPO*

CommandType     Name                                               Version    Source                                                                   
-----------     ----                                               -------    ------                                                                   
Function        Open-NetGPO                                        2.0.0.0    NetSecurity                                                              
Function        Save-NetGPO                                        2.0.0.0    NetSecurity                                                              
Cmdlet          Backup-GPO                                         1.0.0.0    GroupPolicy                                                              
Cmdlet          Copy-GPO                                           1.0.0.0    GroupPolicy                                                              
Cmdlet          Get-GPO                                            1.0.0.0    GroupPolicy                                                              
Cmdlet          Get-GPOReport                                      1.0.0.0    GroupPolicy                                                              
Cmdlet          Get-GPStarterGPO                                   1.0.0.0    GroupPolicy                                                              
Cmdlet          Import-GPO                                         1.0.0.0    GroupPolicy                                                              
Cmdlet          New-GPO                                            1.0.0.0    GroupPolicy                                                              
Cmdlet          New-GPStarterGPO                                   1.0.0.0    GroupPolicy                                                              
Cmdlet          Remove-GPO                                         1.0.0.0    GroupPolicy                                                              
Cmdlet          Rename-GPO                                         1.0.0.0    GroupPolicy                                                              
Cmdlet          Restore-GPO                                        1.0.0.0    GroupPolicy                                                              
Application     chgport.exe                                        10.0.20... C:\Windows\system32\chgport.exe                                          
Application     dcgpofix.exe                                       10.0.20... C:\Windows\system32\dcgpofix.exe                                         

