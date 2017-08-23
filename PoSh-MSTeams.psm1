$function = Get-ChildItem -Path "$PSScriptRoot\Function"
foreach ($function in $function)
{
	. $function.PSPath
	Export-ModuleMember -Function $function.Name
}
