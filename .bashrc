## Sourcing External Configs
source ~/.aliases
source ~/.exports
source ~/.functions

shopt -s extglob 2>/dev/null
set -o noclobber

export HISTCONTROL=ignoredups
unset HISTFILE

[ "$UID" ] || UID=`id -u`
usercolor='01;33'
dircolor='01;34'
case "$TERM" in
  *-256color)
  usercolor='38;5;184'
  dircolor='38;5;27'
  ;;
  *-88color|rxvt-unicode)
  usercolor='38;5;56'
  dircolor='38;5;23'
  ;;
esac
[ $UID = '0' ] && usercolor="01;37"

if [ -x /usr/bin/tty -o -x /usr/local/bin/tty ]; then
  ttybracket=" [`tty|sed -e s,^/dev/,,`]"
  ttyat="`tty|sed -e s,^/dev/,,`@"
fi

PS1='\n┏━\[\e[7m\]┅◉ \[\e[1;37m\] <Machine> ◉━\[\e[0m\]━━\[\e[7m\]┅◉ @ \[\e[1;37m\] $(ip) ◉━\[\e[0m\]━━\[\e[7m\]┅◉ ϡ \[\e[1;37m\] $(parse_git_branch) \[\e[7m\] ◉━\[\e[0m\]━━\[\e[7m\]┅◉ ≣ \[\e[1;37m\] $(gittotalstash) ➤ $(gitstashtop) ◉ \[\e[1;37m\]\[\e[0m\] \n┣┅◉  \[\033[1;31m\] `pwd` \[\e[0m\] \n┗\[\e[7m\]┅◉ 웃 \[\e[1;37m\] \u ◉━\[\e[0m\]━► '

case "$TERM" in
  screen*|xterm*|rxvt*|Eterm*|kterm*|dtterm*|ansi*|cygwin*)
    PS1='\[\e]1;'$ttyat'\h\007\e]2;\u@\h:\w'$ttybracket'\007\]'"${PS1//01;3/00;9}"
  ;;
  linux*|vt220*) ;;
  *)
  PS1='\u@\h:\w\$ '
  ;;
esac

case $TERM in
  screen*)
    PS1="$PS1"'\[\ek'"$ttyat`[ "$STY" -o "$TMUX" ] || echo '\h'`"'\e\\\]'
    ;;
esac

[ ! -f /etc/bash_completion ] || . /etc/bash_completion

unset hostcolor usercolor dircolor ttybracket ttyat

#------------------------------------
# GIT auto completion
#------------------------------------
source /etc/bash_completion.d/git


# ------------------ Custom Functions ------------------- #
function ip() # get IP adresses
{
    #### IP=$(/sbin/ifconfig | awk '/inet / { print $2 } ' | sed -e s/addr://)
    #### ## MY_ISP=$(/sbin/ifconfig | awk '/P-t-P/ { print $3 } ' | sed -e s/P-t-P://)
    #### MY_ISP=$(/sbin/ifconfig | grep "inet " | awk -F':' '{print $2}' | awk -F' ' '{print $1}')| grep -v 127.0.0.1
    #### #echo $IP # | awk -F' ' '{print $1" | "$2}'| sort | grep -v 127.0.0.1
    #### echo $IP
    #### ## echo "ISP Address: " $MY_ISP
    IP=$(/sbin/ifconfig | awk -F "[: ]+" '/inet addr:/ { if ($4 != "127.0.0.1") print $4 }')
    var=$(printf "%-15s" $IP)
    #echo "$var"
    echo $IP
}

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]]
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

function gittotalstash(){
  echo `git stash list | wc -l`
}

function gitstashtop(){
  ## echo `git stash list | awk -F' ' 'NR==1 {print $5}' | tr ':' ' '`
  echo `git stash list | awk -F':' 'NR==1 {print $NF}' | cut -c-20`'...'
}
