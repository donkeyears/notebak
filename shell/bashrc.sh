alias zl="z -l"
alias h="history 20"
#alias tptmp=" >tmp/tmp.log 2>&1 "
#alias vitmp=" vi tmp/tmp.log "
alias grep=" grep --color=auto "

alias gst="git status "
alias ga="git add "
alias gau="git add -u "
alias gcm="git commit -m "
alias grst="git reset --hard "
alias glg="git log -10 --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit  "
alias glgfull="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit  "
alias gl="git log --graph --oneline --decorate "

alias gbr="git branch "
alias gck="git checkout "
alias gckb="git checkout -b "

alias gpl="git pull "
alias gps="git push "
alias gmg="git merge "

alias gcl="git clone "




# use expect to login a server 
#!/usr/bin/expect 
set host [lindex $argv 0]
set user [lindex $argv 1]
set password [lindex $argv 2]
set timeout -1

spawn ssh $user@$host
expect {
    "Connection refused" exit
    "Name or service not known" exit
    "yes/no" {send "yes\r" ; exp_continue}
    "*assword:" {send "$password\r" }  
}
# the last one don't have exp_continue
expect "$*" 
send "sudo su\r"
# some warning sentente has symbol #. this will cause run into a cycle
expect "#"   
send "cd /mydir/ \r"
expect "#"   
send "alias grep=\"grep --color=auto\" \r"
expect "#"   
send "alias grepi=\"grep --color=auto -i \" \r"
expect "#"   
send "alias greprn=\"grep --color=auto -rn \" \r"

interact