#
# Some Handy Powershell Scripts
#

#Modular Font: http://patorjk.com/software/taag/#p=display&f=Modular&t=Type%20Something%20
Write-Host " _______  _______  ______    _______  __    _  _______    _______  __   __  _______  ___      ___     "
Write-Host "|   _   ||   _   ||    _ |  |       ||  |  | ||       |  |       ||  | |  ||       ||   |    |   |    "
Write-Host "|  |_|  ||  |_|  ||   | ||  |   _   ||   |_| ||  _____|  |  _____||  |_|  ||    ___||   |    |   |    "
Write-Host "|       ||       ||   |_||_ |  | |  ||       || |_____   | |_____ |       ||   |___ |   |    |   |    "
Write-Host "|       ||       ||    __  ||  |_|  ||  _    ||_____  |  |_____  ||       ||    ___||   |___ |   |___ "
Write-Host "|   _   ||   _   ||   |  | ||       || | |   | _____| |   _____| ||   _   ||   |___ |       ||       |"
Write-Host "|__| |__||__| |__||___|  |_||_______||_|  |__||_______|  |_______||__| |__||_______||_______||_______|"

Set-Alias ge 'C:\Program Files (x86)\GitExtensions\GitExtensions.exe'
Set-Alias kdiff3 'C:\Program Files (x86)\KDiff3\kdiff3.exe'
Set-Alias code "C:\Program Files (x86)\Microsoft VS Code\Code.exe"

#Favorite Folders
$f = @{
    "repos" = "~\Source\Repos";
    "cases" = "~\Documents\Cases\";
}

function vsts(){
    start (git config --get remote.origin.url)
}

Add-Type -AssemblyName System.IO.Compression.FileSystem

function Zip($Source, $destination){
    if (-Not $destination){
        $destination = "$source.zip"
    }
    Write-Host ("Zipping "+ $Source + " to " + $destination)
    [System.IO.Compression.ZipFile]::CreateFromDirectory($Source,$destination)
}

function Unzip ($zipFile, $outpath)
{
    if (-Not $outpath){
        $outpath = $zipFile.Substring(0,$zipFile.Length - 4)
    }
    Write-Host ("Writing " + $zipFile + " to " + $outpath)
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

## Prompt Customization
<#
.SYNTAX
    <PrePrompt><CMDER DEFAULT>
    λ <PostPrompt> <repl input>
.EXAMPLE
    <PrePrompt>N:\Documents\src\cmder [master]
    λ <PostPrompt> |
#>

[ScriptBlock]$PrePrompt = {
    
}

# Replace the cmder prompt entirely with this.
# [ScriptBlock]$CmderPrompt = {}

[ScriptBlock]$PostPrompt = {
    Write-Host (Get-Date -format "yyyy.MM.dd.HH.mm.ss") -ForegroundColor DarkBlue
}

## <Continue to add your own>

