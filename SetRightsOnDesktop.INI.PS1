set-executionpolicy remotesigned
$usernames = get-childitem H:\Data\Private\*  
foreach ($name in $usernames ){icacls $name\desktop.ini /deny "Administrators:(R)"}