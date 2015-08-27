
function nugetpack([string]$version, [string]$path){
    
    if(!$path){s
      $path = Convert-Path .
    }

    #$currentPath = $PSScriptRootif
    #Write-Host $path
    $nuspecFound=Get-ChildItem $path *.csproj

    If ($nuspecFound.Count -eq 1){
       # $nuspec = Get-ChildItem *.nuspec -Name
        $nuspecFound | Select-Object -first 1 | foreach{ $nuspec = $_.Fullname}
        if(!$version){
            #Get basename of nuspecget-co
            $nuspecFound | Select-Object -first 1 | foreach{ $nuspecBase = $_.BaseName}
            #Get max old version (only looks at last 3 digist)
            $version = Get-ChildItem c:\nuget -Filter *$nuspecBase*.nupkg | foreach{  $_.BaseName.Substring($_.BaseName.Length-3) } | foreach{ [convert]::ToInt32($_, 10)} | measure -Maximum | select -expand Maximum
            #Get last build
            $nupkgBase = Get-ChildItem c:\nuget -Filter $nuspecBase*$version.nupkg | Select-Object -first 1 | foreach{ $_.BaseName}
            #Get last version numer
            $oldVerion = $nupkgBase.Replace($nuspecBase, "").Substring(1)
            #get new full number
            $newVersionNumber = $oldVerion.SubString(0,($oldVerion -as [string]).Length - ($version -as [string]).Length)+([convert]::ToInt32($version, 10)+1)
            $version = $newVersionNumber
            
        }
        
        Invoke-Expression "nuget pack $nuspec -version $version -OutputDirectory c:\nuget\  -build  -Prop Configuration=Release -verbosity normal"
    }
    Else{
        Write-Host "Nuspec not found or more than 1 file"
    }
    #cd $currentPath
}
