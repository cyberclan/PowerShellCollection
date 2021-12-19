New-ADUser -DisplayName:"Abdullah Siddik. Akten" -GivenName:"Abdullah" -Initials:"Siddik" -Name:"Abdullah Siddik. Akten" `
           -Path:"OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" -SamAccountName:"a.akten" -Server:"WinServ2022DC01.d-trust.de" `
           -Surname:"Akten" -Type:"user" -UserPrincipalName:"a.akten@d-trust.de"

# Set-ADAccountPassword -Identity:"CN=Abdullah Siddik. Akten,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" `#                        -NewPassword:"System.Security.SecureString" -Reset:$true -Server:"WinServ2022DC01.d-trust.de"

Enable-ADAccount -Identity:"CN=Abdullah Siddik. Akten,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" -Server:"WinServ2022DC01.d-trust.de"

Set-ADAccountControl -AccountNotDelegated:$false -AllowReversiblePasswordEncryption:$false -CannotChangePassword:$false `
                     -DoesNotRequirePreAuth:$false -Identity:"CN=Abdullah Siddik. Akten,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" `
                     -PasswordNeverExpires:$false -Server:"WinServ2022DC01.d-trust.de" -UseDESKeyOnly:$false

Set-ADUser -ChangePasswordAtLogon:$true -Identity:"CN=Abdullah Siddik. Akten,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" `
           -Server:"WinServ2022DC01.d-trust.de" -SmartcardLogonRequired:$false

# 1. Anpassung
Set-ADUser -City:"Berlin" -Country:"DE" -DisplayName:"Abdullah Siddik Akten" -Fax:"+49 30 123456-70" `
           -Identity:"CN=Abdullah Siddik. Akten,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" -Office:"54-E-2L" -PostalCode:"13351" `
           -Server:"WinServ2022DC01.d-trust.de" -State:"Berlin" -StreetAddress:"Wind Straße 45"

Set-ADObject -Identity:"CN=Abdullah Siddik. Akten,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" -ProtectedFromAccidentalDeletion:$true `
             -Server:"WinServ2022DC01.d-trust.de"

Set-ADUser -Clear:otherFacsimileTelephoneNumber,otherIpPhone,otherMobile,otherPager,otherTelephone `
           -Identity:"CN=Abdullah Siddik. Akten,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" `
           -Replace:@{"otherHomePhone"="+49 30 123456-80"} -Server:"WinServ2022DC01.d-trust.de"

Set-ADUser -Clear:otherFacsimileTelephoneNumber,otherHomePhone,otherIpPhone,otherMobile,otherPager,otherTelephone `
           -Identity:"CN=Abdullah Siddik. Akten,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" `
           -Server:"WinServ2022DC01.d-trust.de"

Set-ADUser -HomePhone:"+49 30 123456-90" -Identity:"CN=Abdullah Siddik. Akten,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" `
           -OfficePhone:"+49 30 123456-60" -Server:"WinServ2022DC01.d-trust.de"

Set-ADUser -HomePhone:$null -Identity:"CN=Abdullah Siddik. Akten,OU=Test-SubOU,OU=Test-OU,DC=d-trust,DC=de" -Server:"WinServ2022DC01.d-trust.de"
