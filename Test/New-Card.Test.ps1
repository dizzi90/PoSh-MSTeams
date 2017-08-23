Describe "New-Card"
{
	It "Creates a PSCustomObject"
	{
		$parameter = @{} # TODO: Add valid parameters
		$Card = New-Card @parameter
		$Card | Get-TypeName | Should be "System.Automation.PSCustomObject"
	}

}