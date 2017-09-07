#!/usr/bin/env powershell
function New-CardSection
{
	[CmdletBinding()]
	[OutputType('[PSCustomObject]')]
	param
	(
		[Parameter()]	[PSCustomObject[]]	$Activity,
		[Parameter()]	[PSCustomObject[]]	$Fact,
		[Parameter()]	[PSCustomObject[]]	$Image,
		[Parameter()]	[String]			$Title,
		[Parameter()]	[Switch]			$StartGroup,
		[Parameter()]	[PSCustomObject]	$HeroImage,
		[Parameter()]	[String]			$Text,
		[Parameter()]	[PSCustomObject[]]	$PotentialAction
	)
	process
	{
		$section = @{}

		foreach ($item in $Activity)		{ $section					+= $item }
		foreach ($item in $Fact)			{ $section.facts 			+= $item }
		foreach ($item in $Image)			{ $section.image			+= $item }
		foreach ($item in $PotentialAction)	{ $section.potentialAction	+= $item }

		if ($Title)			{	$section.title		= $Title		}
		if ($StartGroup)	{	$section.startGroup	= $StartGroup	}
		if ($HeroImage)		{	$section.heroImage	= $HeroImage	}
		if ($Text)			{	$section.text		= $Text			}

		$section
	}
}