<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function get-Event4776Details
{
    [CmdletBinding()]
    [OutputType([psobject])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   Position=0)]
        [AllowNull()]
        [System.Diagnostics.EventLogEntry[]]$Event
    )

    Begin
    {
        $EventMessageHeader = "The computer attempted to validate the credentials for an account."
        $EventMessageAuthenticationPackage = "Authentication Package:\s+(?<AuthenticationPackage>[\w_]+)"
        $EventMessageLogonAccount = "Logon Account:\s+(?<LogonAccount>[\w_\-\\\$\.@]+)"
        $EventMessageSourceWorkstation = "Source Workstation:\s+(?<SourceWorkstation>[\w\d_\-\\]+)"
        $EventMessageErrorCode = "\s+Error Code:\s+(?<ErrorCode>\dx[\w\d]+)"

        $EventMessageRegex = "$EventMessageHeader\s*$EventMessageAuthenticationPackage\s*$EventMessageLogonAccount\s*$EventMessageSourceWorkstation\s*$EventMessageErrorCode"
    }
    Process
    {
        foreach ($Entry in $Event)
        {
 <#           
            write-host -fore yellow "$($Entry.Index)"

            if ($Entry.message -match $EventMessageHeader)
            {
                write-host -fore green -back black 'EventMessageHeader'
                $matches
            }
            else
            {
                write-host -fore red -back black 'EventMessageHeader'
            }

            if ($Entry.message -match $EventMessageAuthenticationPackage)
            {
                write-host -fore green -back black 'EventMessageAuthenticationPackage'
                $matches
            }
            else
            {
                write-host -fore red -back black 'EventMessageAuthenticationPackage'
            }


            if ($Entry.message -match $EventMessageLogonAccount)
            {
                write-host -fore green -back black 'EventMessageLogonAccount'
                $matches
            }
            else
            {
                write-host -fore red -back black 'EventMessageLogonAccount'
            }


            if ($Entry.message -match $EventMessageSourceWorkstation)
            {
                write-host -fore green -back black 'EventMessageSourceWorkstation'
                $matches
            }
            else
            {
                write-host -fore red -back black 'EventMessageSourceWorkstation'
            }


            if ($Entry.message -match $EventMessageErrorCode)
            {
                write-host -fore green -back black 'EventMessageErrorCode'
                $matches
            }
            else
            {
                write-host -fore red -back black 'EventMessageErrorCode'
            }
#>
            $matches = $null
            $Entry.message -match $EventMessageRegex | Out-Null
            

            $result = new-object psobject -Property @{
                TimeGenerated               = $Entry.TimeGenerated
                AuthenticationPackage       = $matches.AuthenticationPackage
                LogonAccount                = $matches.LogonAccount
                SourceWorkstation           = $matches.SourceWorkstation
                ErrorCode                   = $matches.ErrorCode
            }


            write-output $result
        }
    }
    End
    {
    }
}

$Events | Get-Random | get-Event4776Details
