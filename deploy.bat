@echo off
echo  %name%_%n%
start cmd /c "mkdocs build"
nul ping 127.1 /10
start cmd /c "mkdocs build --clean"
nul ping 127.1 /10
start cmd /c "git add ."
nul ping 127.1 /10
start cmd /c "git push"
nul ping 127.1 /10
start cmd /c "git commit -m "%name%_%n%""
nul ping 127.1 /10
start cmd /c "mkdocs gh-deploy"