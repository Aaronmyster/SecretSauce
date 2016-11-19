# SecretSauce
This is pretty much how you I get my windows machines up and running for some basic development.
Feel free to make some suggestions.


## Step 1: Install GitExtensions
        
## Step 2: Install ConEmu

## Step 3: Install Visual Studio Code

## Step 4: Install Sublime Text
Because you still need it every onece in a while...

## Step 5: Install your powershell startup script
Just has a few of my favorite things.
I got the file path [here](https://blogs.technet.microsoft.com/heyscriptingguy/2012/05/21/understanding-the-six-powershell-profiles/).

First set the execution policy as admin:

`Set-ExecutionPolicy -ExecutionPolicy Unrestricted`

Then add in your startup script:
```
New-Item -ItemType File -Force -Path $Profile
cp .\Microsoft.PowerShell_profile.ps1 $profile
```

## Step 6: Get your git aliases on point
todo...

## Step 7: Get your bashrc set up
todo...