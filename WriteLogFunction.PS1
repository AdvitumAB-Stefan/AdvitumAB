<#   
    .NOTES
    ===========================================================================
     Created on:    2015-10-05 
     Created by:    Arash Nabi
     Email:     arash@nabi.nu 
    ===========================================================================
    .DESCRIPTION
        Write-Log function creates a log file in the $PSScrtipRoot. It's usefull
                to call it in your script and output some message or verbose output. 
    ==========================================================================
    .EX
        Write-Log -Message "Email report send"
#>
function Write-Log
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        [Parameter(Mandatory = $true,
                   ValueFromPipelineByPropertyName = $False,
                   HelpMessage = "Please enter Message for the log",
                   Position = 0,
                   ValueFromPipeline = $True)]
        [ValidateNotNullorEmpty()]
        $Message
         
         
    )
    try
    {
        $LogFolder = "$PSScriptRoot\log"
        $d = get-date
        $M = $d.Month.ToString()
        $Y = $d.Year.ToString()
        $LogFile = "$LogFolder\$("Script" + "-" + $Y + "-" + $M + ".log")"
        if (!(Test-Path -Path $LogFile))
        {
            $Dir = New-Item -Path $LogFolder -ItemType Directory -Force
            $Log = New-Item -Path "$Dir\$("Script" + "-" + $Y + "-" + $M + ".log")" -ItemTyp File -Force
             
        }
        $DateTime = (get-date -Format "yyyy-MM-dd HH:mm:ss")
        if ($PSBoundParameters['Message'])
        {
            "[$DateTime] " + $Message | out-file $LogFile -ErrorAction SilentlyContinue -append
        }
         
    }
    catch [System.Net.WebException], [System.Exception]
    {
        $errorMessage = $_.Exception.Message
        Write-Warning -Message $errorMessage
    }
    finally
    {
    }
}
