#!/usr/bin/env powershell
function Send-TeamsCard
{
<#
	.SYNOPSIS
		Sends an actioncard to a MS Teams channel
	.DESCRIPTION
		Sends an actioncard to a MS Teams channel. Please note that you may have to enable developer preview.
	.EXAMPLE
		PS C:\> <example usage>
		Explanation of what the example does
	.INPUTS
		ActionCard as hashtable.
	.OUTPUTS
		$true or $false
		Refers to whether or not the post was successful.
	.NOTES
		This cmdlet does not create cards, it only sends a card you have already created. See New-Card for card creation.
#>
	[CmdletBinding()]
	[OutputType('Bool')]
	param(
		[Parameter()]
		[ValidateScript({ $_ -match '^https://outlook.office.com/webhook*' })]
		[string]
		$Webhook,

		[Parameter()] [PSCustomObject] $Card
	)

	$parameter = @{
		Headers	= @{ accept = 'application/json' }
		Body 	= $Card | ConvertTo-Json -Compress -Depth 10
		Method 	= 'POST'
		URI 	= $Webhook
	}
	try
	{
		$apiResponse = Invoke-RestMethod @parameter
		if ($apiResponse -eq 1) { $true }
		else
		{
			$false
			"Got response: $apiResponse" | Write-Error
		}
	}
	catch [WebException]
	{
		Throw "API did not accept request."
	}
	catch
	{ 
		throw "Could not post to Teams. $($Error[0])"
	}

}
