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
function get-Event4648Details
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
        $EventMessageSubjectRegEx            = "Subject:\r\n\tSecurity ID:\s+(?<Subject_SecurityID>[S\-0-9a-f]+)\r\n\tAccount Name:\s+(?<Subject_AccountName>[\-0-9a-z\$]+)\r\n\tAccount Domain:\s+(?<Subject_AccountDomain>[\-0-9a-z]+)\r\n\tLogon ID:\s+(?<Subject_LogonID>[x\-0-9a-f]+)\r\n\tLogon GUID:\s+(?<Subject_LogonGUID>{[0-9a-f\-]+})"
        $EventMessageAccountCredentialsRegEx = "Account Whose Credentials Were Used:\r\n\tAccount Name:\s+(?<Credentials_AccountName>[\w\.\$-]+)\r\n\tAccount Domain:\s+(?<Credentials_AccountDomain>[\w ]+)\r\n\tLogon GUID:\s+(?<Credentials_LogonGUID>{[-0-9a-f]+})"
        $EventMessageTargetServerRegex       = "Target Server:\r\n\tTarget Server Name:\s+(?<TargetServer_Name>[-\.\w\d]+)\r\n\tAdditional Information:\s+(?<TargetServer_AdditionalInformation>[\w\d-\.\\:]+)"
        $EventMessageProcessInformationRegex = "Process Information:\r\n\tProcess ID:\s+(?<ProcessInfo_processId>0x[0-9a-f]+)\r\n\tProcess Name:\s+(?<ProcessInfo_ProcessName>[\w-\.\\:]+)"
        $EventMessageNetworkInformationRegex = "Network Information:\r\n\tNetwork Address:\s+(?<NetworkInfo_NetworkAddress>[\-a-f:0-9\.]+)\r\n\tPort:\s+(?<NetworkInfo_NetworkPort>[\-0-9]+)"
        $EventMessageRegex = "A logon was attempted using explicit credentials.\s*$EventMessageSubjectRegEx\s*$EventMessageAccountCredentialsRegEx\s*$EventMessageTargetServerRegex\s*$EventMessageProcessInformationRegex\s*$EventMessageNetworkInformationRegex"
    }
    Process
    {
        foreach ($Entry in $Event)
        {
<#            
            write-host -fore yellow "$($Entry.Index)"

            if ($Entry.message -match $EventMessageSubjectRegEx)
            {
                write-host -fore green -back black 'EventMessageSubjectRegEx'
                $matches
            }
            else
            {
                write-host -fore red -back black 'EventMessageSubjectRegEx'
            }

            if ($Entry.message -match $EventMessageAccountCredentialsRegEx)
            {
                write-host -fore green -back black 'EventMessageAccountCredentialsRegEx'
                $matches
            }
            else
            {
                write-host -fore red -back black 'EventMessageAccountCredentialsRegEx'
            }


            if ($Entry.message -match $EventMessageTargetServerRegex)
            {
                write-host -fore green -back black 'EventMessageTargetServerRegex'
                $matches
            }
            else
            {
                write-host -fore red -back black 'EventMessageTargetServerRegex'
            }


            if ($Entry.message -match $EventMessageProcessInformationRegex)
            {
                write-host -fore green -back black 'EventMessageProcessInformationRegex'
                $matches
            }
            else
            {
                write-host -fore red -back black 'EventMessageProcessInformationRegex'
            }


            if ($Entry.message -match $EventMessageNetworkInformationRegex)
            {
                write-host -fore green -back black 'EventMessageNetworkInformationRegex'
                $matches
            }
            else
            {
                write-host -fore red -back black 'EventMessageNetworkInformationRegex'
            }


            if ($Entry.message -match $EventMessageRegex)
            {
                write-host -fore green -back black 'EventMessageRegex'
                $matches
            }
            else
            {
                write-host -fore red -back black 'EventMessageRegex'
            }
            #>

            $matches = $null
            $Entry.message -match $EventMessageRegex | Out-Null

            $result = new-object psobject -Property @{
                TimeGenerated               = $Entry.TimeGenerated
                Subject_SecurityID          = $matches.Subject_SecurityID
                Subject_AccountName         = $matches.Subject_AccountName
                Subject_AccountDomain       = $matches.Subject_AccountDomain
                Subject_LogonID             = $matches.Subject_LogonID
                Subject_LogonGUID           = $matches.Subject_LogonGUID
                Credentials_AccountName     = $matches.Credentials_AccountName
                Credentials_AccountDomain   = $matches.Credentials_AccountDomain
                Credentials_LogonGUID       = $matches.Credentials_LogonGUID
                TargetServer_Name           = $matches.TargetServer_Name
                TargetServer_AdditionalInformation = $matches.TargetServer_AdditionalInformation
                ProcessInfo_processId       = $matches.ProcessInfo_processId
                ProcessInfo_ProcessName     = $matches.ProcessInfo_ProcessName
                NetworkInfo_NetworkAddress  = $matches.NetworkInfo_NetworkAddress
                NetworkInfo_NetworkPort      = $matches.NetworkInfo_NetworkPort
            }
            write-output $result
        }
    }
    End
    {
    }
}

