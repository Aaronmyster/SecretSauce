#
# Some Handy Powershell Scripts
#

#Modular Font: http://patorjk.com/software/taag/#p=display&f=Modular&t=Type%20Something%20
Write-Host " _______  _______  ______    _______  __    _  _______  __   __  _______  ___      ___     "
Write-Host "|   _   ||   _   ||    _ |  |       ||  |  | ||       ||  | |  ||       ||   |    |   |    "
Write-Host "|  |_|  ||  |_|  ||   | ||  |   _   ||   |_| ||  _____||  |_|  ||    ___||   |    |   |    "
Write-Host "|       ||       ||   |_||_ |  | |  ||       || |_____ |       ||   |___ |   |    |   |    "
Write-Host "|       ||       ||    __  ||  |_|  ||  _    ||_____  ||       ||    ___||   |___ |   |___ "
Write-Host "|   _   ||   _   ||   |  | ||       || | |   | _____| ||   _   ||   |___ |       ||       |"
Write-Host "|__| |__||__| |__||___|  |_||_______||_|  |__||_______||__| |__||_______||_______||_______|"

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
    Write-Host ("Zipping "+ $Source + " to " + $destination)
    [System.IO.Compression.ZipFile]::CreateFromDirectory($Source,$destination)
}

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

function ohshitgit()
{
    param(
        [Parameter(Mandatory=$true)]
        [string]$branchname      
    ) 
    git branch $branchname
    git reset HEAD~ --hard
    git checkout $branchname
}

function StartupScript(){
    code C:\Users\aroach\Downloads\cmder\config\user-profile.ps1
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
    Write-Host (Get-Date -format "yyyy.MM.dd.HH.mm.ss") -ForegroundColor DarkBlue
}

# Replace the cmder prompt entirely with this.
# [ScriptBlock]$CmderPrompt = {}

[ScriptBlock]$PostPrompt = {
    
}

## <Continue to add your own>

##############
# TODOIST STUFF
#############

add-type -AssemblyName "System.Web"

$filters = @{
    workOverdueToday="(overdue | 1 days) & p:Work";
    quickWork = "@2min & p:Work";
    unscheduledWork = "p:Work & no date";
    work = "p:Work"
}

function todo ($filter){
    if (-not $filter){$filter = $filters.workOverdueToday}
    $encodedFilter = [System.Web.HttpUtility]::UrlEncode($filter)
    
    #(Invoke-RestMethod "https://beta.todoist.com/API/v8/tasks?token=$token&filter=$encodedFilter") | Sort-Object priority, order -descending | Select @{Name="THINGS TO DO";Expression={$_.content}}
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    (Invoke-RestMethod "http://beta.todoist.com/API/v8/tasks?token=$token&filter=$encodedFilter") `
        | Sort-Object {$_.due.datetime}, @{Expression={$_.priority};Descending=$true}, order `
        | Select-Object @{Name="THINGS TO DO";Expression={$_.content}}, @{Name="WHEN";Expression={([System.TimeZoneInfo]::ConvertTime([datetime]$_.due.datetime, [System.TimeZoneInfo]::FindSystemTimeZoneById("Central Standard Time"))).ToShortTimeString()}}
}

function todoRaw($filter){
    $encodedFilter = [System.Web.HttpUtility]::UrlEncode($filter)
    Invoke-RestMethod "https://beta.todoist.com/API/v8/tasks?token=$token&filter=$encodedFilter"
}

function todoist () {
    start "http://www.todoist.com"
}

Todo $filters.workOverdueToday