function New-CardActivity
{
	[CmdletBinding()]
	[OutputType('[PSCustomObject]')]
	param (
		[Parameter()] [String] $Image	,
		[Parameter()] [String] $Title	,
		[Parameter()] [String] $Subtitle,
		[Parameter()] [String] $Text	,
		[Parameter()] [Switch] $ToJSON	
	)
	process
	{
		$activity = @{}
		if ($Image)		{ $activity.activityImage		= $Image	}
		if ($Title)		{ $activity.activityTitle		= $Title	}
		if ($Subtitle)	{ $activity.activitySubtitle	= $Subtitle	}
		if ($Text)		{ $activity.activityText		= $Text		}

		if ($ToJSON) { $activity | ConvertTo-Json -Compress } 
		else { $activity }
	}
}