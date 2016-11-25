#Kör detta för att få ut alla användare med nuvarande inställnignar till csv-fil c:\temp\users.csv
Get-ADUser -Filter * -Properties emailaddress -SearchBase 'OU=Konton,DC=energi-miljo,DC=se' |Where-Object {$_.emailaddress -like "*@kalmarenergi.se"} | select samaccountname,name,emailaddress,userprincipalname > c:\temp\users.csv

#Nedanstående ändrar UPN till emailadressen på kontona
$users=Get-ADUser -Filter * -Properties emailaddress -SearchBase 'OU=Konton,DC=energi-miljo,DC=se' |Where-Object {$_.emailaddress -like "*@kalmarenergi.se"} | select samaccountname,name,emailaddress,userprincipalname
foreach($user in $users){set-aduser $user.samaccountname -UserPrincipalName $user.emailaddress}