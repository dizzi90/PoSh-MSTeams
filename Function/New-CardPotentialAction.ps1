#!/usr/bin/env powershell
function New-CardPotentialAction
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory)]	[String]		$Type,
		[Parameter(Mandatory)]	[String]		$Name,
		[Parameter()]			[psobject[]]	$Action,
		[Parameter()]			[psobject[]]	$ActionInput
	)
	process
	{
		$potentialAction		=	@{}

		$potentialAction.type	=	$Type
		$potentialAction.name	=	$Name

		foreach	($item in $ActionInput)	{ $potentialAction.input	+= $item }
		foreach	($item in $Action)		{ $potentialAction.action	+= $item }

		$potentialAction
	}
}