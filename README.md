# SecretSauce
These are some of the free basic tools that I use day to day. I've also included some of my startup scripts, profiles, and aliases.

## 1: [GitExtensions](https://gitextensions.github.io/)
Still the best Git Gui I've ever worked with. 
        
## 2: [Visual Studio Code](http://code.visualstudio.com)
It took a long time, but it's finally replaced Sublime.

## 3: [Cmder](http://cmder.net/)

I just started using Cmdr over ConEmu. Same team I think. I usually just run it out of my downloads folder.

## 4: My Git Aliases

Run this in a bash/terminal:
```
# Better Git Log : https://coderwall.com/p/euwpig/a-better-git-log
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

#Show me the changes
git config --global alias.changes "diff HEAD^"

#Reset Everything!
git config --global alias.fu "!git reset --hard && git clean -fdx ."

#Status
git config --global alias.st "status"
```

## 4: My Powershell Startup Script

If you're using Cmder, and you don't want to replace your actual Powershell profile, do this:

```
cp .\user-profile.ps1 "$($ENV:HOMEPATH)\Downloads\cmder\config\"
```

## Step 7: Get your bashrc set up
todo...