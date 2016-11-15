#
# Some Handy Powershell Scripts
# If you put it in %UserProfile%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1, it will get run on startup
# Todo: find url with actual info
#

Set-Alias ge 'C:\Program Files (x86)\GitExtensions\GitExtensions.exe'
Set-Alias kdiff3 'C:\Program Files (x86)\KDiff3\kdiff3.exe'
Set-Alias code "C:\Program Files (x86)\Microsoft VS Code\Code.exe"

Add-Type -AssemblyName System.IO.Compression.FileSystem

function Unzip ($zipFile, $outpath)
{
    Write-Host ("Writing " + $zipFile + "to " + $outpath)
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

function Unpackage ($nupkgFileName)
{
    $nupkgFile = Get-Item $nupkgFileName
    $zipFileName = $nupkgFile.BaseName + ".zip"
    
    cp $nupkgFile $zipFileName

    $zipFile = Get-Item $zipFileName
    $pwd = pwd

    Unzip $zipFile ($pwd.Path + "\" + $zipFile.BaseName)

    rm $zipFile
}


function UnOrig ()
{
    get-childitem . -include *.orig -recurse | foreach ($_) {remove-item $_.fullname}
}