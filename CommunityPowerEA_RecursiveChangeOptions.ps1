#Change Option for all *.set files in current Path
#v1.0

function Set-OrAddIniValue {
	Param(
		[string]$FilePath,
		[hashtable]$keyValueList
	)

	$content = Get-Content -Path "$FilePath"
	$keyValueList.GetEnumerator() | ForEach-Object {
		if ($content -match "^$($_.Key)\s*=") {
			$content = $content -replace "$($_.Key)\s*=(.*)", "$($_.Key)=$($_.Value)"
		}
		else {
			$content += "$($_.Key)=$($_.Value)"
		}
	}

	$content | Set-Content -Path "$FilePath"

}

$currentPath=Get-Location
#Recursive Sub-Directory
Get-ChildItem -Path "$currentPath\*.set" -recurse | Foreach-Object {
Get-ChildItem -Path "$currentPath\*.set" | Foreach-Object {	
	#Do something with $_.FullName
	$filePath = $_.FullName
	Write-Output $filePath
	Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
		TakeProfit_Width = "2"
		TakeProfit_Style = "3"
	}

}
