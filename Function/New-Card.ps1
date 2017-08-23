#!/usr/bin/env powershell
function New-Card
{
	[CmdletBinding()]
	[OutputType([Hashtable],[String])]
	Param
	(
		[Parameter()]	[PSCustomObject[]]	$Section,
		[Parameter()]	[String]			$Summary,
		[Parameter()]	[String]			$ThemeColor,
		[Parameter()]	[Bool]				$HideOriginalBody,
		[Parameter()]	[String]			$Title,
		[Parameter()]	[PSCustomObject[]]	$PotentialAction,
		[Parameter()]	[Switch]			$ToJSON
	)

	Process
	{
		$card	=	[ordered]@{}

		$card.'@type'		=	'MessageCard'
		$card.'@context'	=	'http://schema.org/extensions'

		foreach	($Section in $Section)					{ $card.section			+=	$Section }
		foreach	($PotentialAction in $PotentialAction)	{ $card.potentialAction	+=	$PotentialAction }

		if	($hideOriginalBody)	{ $card.hideOriginalBody	=	$true }
		if	($Title)			{ $card.Title				=	$Title }
		if	($Summary)			{ $card.Summary				=	$Summary }
		if	($ThemeColor)		{ $card.themeColor			=	$ThemeColor }

		if	($ToJSON)	{ $card	= $card	| ConvertTo-Json -Compress -Depth 10 }

		$card
	}
}