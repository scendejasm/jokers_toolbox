param ([string]$Computername, [hashtable]$Attributes)

## Attempt to find the Computername
try {
    $Computer = Get-ADComputer -Identity $Computername
    if (!$Computer) {
        ## If the Computername isn't found throw an error and exit
        Write-Error "The Computername '$Computername' does not exist"
        return
}
} catch {
    Write-Host "Catch Block Again"
}

## The $Attributes parameter will contain only the parameters for the Set-AdComputer cmdlet
$Computer | Set-ADComputer @Attributes 