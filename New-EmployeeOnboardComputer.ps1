param($Computername, $Location = 'OU=Company Computers')

try {
    if (Get-ADComputer $Computername) {
        Write-Error "The computername '$Computername' already exists"
        return
    }
} catch {

}

$DomainDn = (Get-ADDomain).DistinguishedName
$DefaultOuPath = "$Location,$DomainDn"

New-ADComputer -Name $Computername -Path $DefaultOuPath