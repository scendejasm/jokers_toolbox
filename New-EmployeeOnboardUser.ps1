param($FirstName,$MiddleInitial,$LastName,$Location = 'OU=Employees', $Title)

$DefaultPassword = 'P@ssw0rd'
$DomainDn = (Get-ADDomain).DistinguishedName
$DefaultGroup = "TESTUsers"

 ### Figure out what the username should be
$Username = "$($Firstname.Substring(0,1))$Lastname"
$EaPreBefore = $ErrorActionPreference
$ErrorActionPreference = 'SilentlyContinue'
try {
    if (Get-ADUser $Username) {
        $Username = "$($FirstName.SubString(0,1))$MiddleInitial$LastName"
        if (Get-ADUser $Username) {
            Write-Warning "No acceptable username schema could be created"
            return 
        }   
}
} catch {
    Write-Host "This is the catch block"
}
## Create the user account 
$ErrorActionPreference = $EaPreBefore
$NewUserParams = @{
    'UserPrincipalName' = $Username
    'Name' = $Username
    'GivenName' = $FirstName
    'SurName' = $LastName
    'Title' = $Title
    'SamAccountName' = $Username
    'AccountPassword' = (ConvertTo-SecureString $DefaultPassword -AsPlainText -Force)
    'Enabled' = $true
    'Initials' = $MiddleInitial
    'Path' = "$Location,$DomainDn"
    'ChangePasswordAtLogon' = $true
}

New-ADUser @NewUserParams

# Add the user account to the company standard group 
Add-ADGroupMember -Identity $DefaultGroup -Members $Username
