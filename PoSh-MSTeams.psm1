$function = Get-ChildItem -Path $PSScriptRoot\Function
foreach ($function in $function)
{
	. $function.FullName
	Export-ModuleMember -Function $function.BaseName
}
