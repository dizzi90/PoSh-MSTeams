#!/usr/bin/env powershell
function Send-TeamsMessage
{
<#
	.SYNOPSIS
		This is a module whose which sends a message to a Microsoft Teams channel using a webhook integration.
	.DESCRIPTION
		Sends a HTTP Post with a JSON payload which contains the message from the body parameter. Basic markdown is accepted.
	.INPUTS
		Does not allow piped inputs yet.
	.OUTPUTS
		Returns $True on successful post.
	.PARAMETER Webhook
		String. Defines which channel we are sending messages to.
		Go to Team
		- Channel
		- ...
		- Connectors
		- Incoming webhook
		- Click the copy button
	.PARAMETER Body
		String. The message text to send to teams. 
		Accepts MarkDown, including urls and inline images. See examples for more.

	.EXAMPLE

		PS > Send-TeamsMessage `
			-Webhook "https://outlook.office.com/webhook/$guid0/IncomingWebhook/$guid1/$guid2" `
			-Body "This is a demo" `
			-Title "Demo for users"
		
	.NOTES
	.COMPONENT
		Powershell > 3.0
		ConvertTo-Json
		Invoke-RestMethod
	.LINK
	https://github.com/dizzi90/PoSh-MSTeams
#>
	[CmdletBinding()]
	[OutputType([Bool])]
	param(

		# Webhook
		[Parameter(
			Mandatory,
			HelpMessage='Incoming Webhook link from MS Teams channel'
		)]
		[ValidateScript(
			{ $_ -match '^https://outlook.office.com/webhook*' }
		)]
		[String]
		$Webhook,

		# Body
		[Parameter(
			Mandatory,
			HelpMessage='Body text to be sent to MS Teams'
		)]
		[String]
		$Body,

		[Parameter()]	[ValidatePattern('^[a-fA-F0-9]{6}$')]	[String] $Colour,
		[Parameter()]	[String] $Title
	)

	$data	=	@{ text = $Body }
	if ($Colour)	{ $data.themeColor	= $Colour	}
	if ($Title)		{ $data.Title		= $Title	}

	$parameter = @{
		Headers	= @{ Accept	= 'application/json' }
		Body	= $data | ConvertTo-Json -Compress
		Method	= 'POST'
		URI		= $Webhook
	}

	try
	{
		$apiResponse = Invoke-RestMethod @parameter
		if ($apiResponse -eq 1)	{ $true }
		else
		{
			$false
			"Got response: $apiResponse" | Write-Error
		}
	}
	catch
	{
		throw "Could not post to Teams. $Error"
	}

}

# SIG # Begin signature block
# MIID+QYJKoZIhvcNAQcCoIID6jCCA+YCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUHhjHAHq+FTjA1b+5X5eK9J+B
# VW2gggIPMIICCzCCAXSgAwIBAgIQFQ2VAEdTEbNI8o+S4iOiejANBgkqhkiG9w0B
# AQUFADAgMR4wHAYDVQQDDBVNYWdudXMgTWV5ZXIgSHVzdHZlaXQwHhcNMTcwNzIw
# MTkwNjAyWhcNMjEwNzMxMDAwMDAwWjAgMR4wHAYDVQQDDBVNYWdudXMgTWV5ZXIg
# SHVzdHZlaXQwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAKpWcQW/2BwLGK26
# bmvCQ7ogi6gXGXInm5P7DtH3m8n/1/+/BVC3klfg6BGBCVEJZ9bdIhIzpgYYEocO
# 5HU66pFib+A7me6FHxNjcRnuOBPUf3Iv59oj86vWHBuNWLhLSfwXHv+OuBm8J8je
# 7rohPH3x94R36MSuYVE0ukFQBz+zAgMBAAGjRjBEMBMGA1UdJQQMMAoGCCsGAQUF
# BwMDMB0GA1UdDgQWBBRhJXGgWcrFtfcK0c8ibBEnLkFxDzAOBgNVHQ8BAf8EBAMC
# B4AwDQYJKoZIhvcNAQEFBQADgYEAfB+oY4euoCJ7z6r4biIQ3EWLQMplXurv/Da7
# 9EDoWeRAmrUuh4VTwf4EVlN8M85UJUyzbOFtZVOQrXvs60TrI3/LN0fcnF++Ljf8
# wO7EuI9mk4ULYEbDfodSlK5SULcnzohNsLsV18kr3J6PpJjsOP9dncGAmbc00+3N
# I9DIK4AxggFUMIIBUAIBATA0MCAxHjAcBgNVBAMMFU1hZ251cyBNZXllciBIdXN0
# dmVpdAIQFQ2VAEdTEbNI8o+S4iOiejAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIB
# DDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEE
# AYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUqrV0N13BuM2O
# oO6wr/9C0mvKJzIwDQYJKoZIhvcNAQEBBQAEgYAFGY8qPGL+KWBKbK/FCCFTEeBZ
# LfB7Gxqz8WcWoSJ/X08NSKOBo4R0DKEL6xQMs2cQwBMTP4GLE3hU4yZ0oC8yM8Zm
# XpofUV0+XM+YM+1aSE2scTlovd6nPeWzic/FAMzLmDJjJH5Bvs6IUAlmTDsbGDi9
# 8ktfaYsNfOUF98VPww==
# SIG # End signature block
