#!/usr/bin/env powershell
function New-CardAction
{

	[CmdletBinding(DefaultParameterSetName = 'OpenUri')] 
	param
	(
		# Which type of action is defined by the parameters used.
		[Parameter(Mandatory)]	[string]	$Name,

		[Parameter(ParameterSetName='OpenUri',Mandatory)]		[string]		$DefaultUri,
			[Parameter(ParameterSetName='OpenUri')]				[string]		$iOsUri,
			[Parameter(ParameterSetName='OpenUri')]				[string]		$AndroidUri,
			[Parameter(ParameterSetName='OpenUri')]				[string]		$WindowsUri,

		[Parameter(ParameterSetName='HttpPost',Mandatory)]		[string]		$Target,
		[Parameter(ParameterSetName='HttpPost',Mandatory)]		[string]		$Body,
			[Parameter(ParameterSetName='HttpPost')]			[string]		$Headers,
			[Parameter(ParameterSetName='HttpPost')]			[string]		$BodyContentType,

		[Parameter(ParameterSetName='ActionCard',Mandatory)]	[PSObject[]]	$Action,
			[Parameter(ParameterSetName='ActionCard')]			[PSObject[]]	$ActionInput
	)
	process
	{
		$action	=	@{ Name = $Name }

		switch ($PsCmdlet.ParameterSetName)
		{
			'OpenUri'
			{
				$target	= @{ os = 'default' ; uri = $DefaultUri }
				if ($iOsUri)		{ $target	+= @{ os = 'iOS'		; uri = $iOsUri		} }
				if ($AndroidUri)	{ $target	+= @{ os = 'android'	; uri = $AndroidUri	} }
				if ($WindowsUri)	{ $target	+= @{ os = 'windows'	; uri = $DefaultUri	} }
				$action.targets = $target
			}
			'HttpPost'
			{
				$action.target	= $target
				$action.body	= $Body
				if ($BodyContentType)	{ $action.bodyContentType	=	$BodyContentType }
				foreach ($item in $headers)			{ $action.headers	+= $item }
			}
			'ActionCard'
			{
				foreach ($item in $action)			{ $action.action	+= $item }
				foreach ($item in $ActionInput)		{ $action.input		+= $item }
			}
		}

		$action
	}
}