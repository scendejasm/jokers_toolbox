function New-AdvancedFunction {
    <#
    .SYNOPSIS
    
    .EXAMPLE
        PS> New-AdvancedFunction -Param1 MYPARAM 

        This examplet does something to this and that. 
    .PARAMETER Param1
        This param does this thing.
    .PARAMETER
    .PARAMETER
    .PARAMETER
    #>
    [CmdletBinding()]
    param (
        [string]$Param1 
    )
    process {
        try {
            if (!$True) {
                throw 'AN ERROR OCCURRED'
            }
            Write-Host "statement was not true: NO ERROR"
        } catch {
            Write-Error "$($_.Exception.Message) - Line Number: $($_.InvocationInfo.ScriptLineNumber)"
        }
    }
}