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
		[Parameter()]	[PSCustomObject[]]	$PotentialAction
		[Parameter()]	[String]			$Title,
		[Parameter()]	[Switch]			$StartGroup,
		[Parameter()]	[PSCustomObject]	$HeroImage,
		[Parameter()]	[String]			$Text,
	)
	process
	{
		$section = @{}

		foreach ($item in $Activity)		{ $section.Activity			+= $item }
		foreach ($item in $Fact)			{ $section.Fact 			+= $item }
		foreach ($item in $Image)			{ $section.Image			+= $item }
		foreach ($item in $PotentialAction)	{ $section.PotentialAction	+= $item }
		if ($Title)			{	$section.title		= $Title		}
		if ($StartGroup)	{	$section.startGroup	= $StartGroup	}
		if ($HeroImage)		{	$section.heroImage	= $HeroImage	}
		if ($Text)			{	$section.text		= $Text			}

		$section
	}
}