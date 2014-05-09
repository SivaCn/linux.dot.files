
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

PS1='\n┏━\[\e[7m\]┅◉  \[\e[1;37m\] <Machine> ◉━\[\e[0m\]━━\[\e[7m\]┅◉ ip \[\e[1;37m\] $(ip) ◉━\[\e[0m\]━━\[\e[7m\]┅◉ Git \[\e[1;37m\] $(parse_git_branch) ◉ \[\e[0m\] \n┣┅◉  \[\033[1;31m\] `pwd` \[\e[0m\] \n┗\[\e[7m\]┅◉ User \[\e[1;37m\] \u ◉━\[\e[0m\]━► '


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

#===============================================================
#
# ALIASES AND FUNCTIONS
#
# Arguably, some functions defined here are quite big
# (ie 'lowercase') but my workstation has 512Meg of RAM, so .....
# If you want to make this file smaller, these functions can
# be converted into scripts.
#
# Many functions were taken (almost) straight from the bash-2.04
# examples.
#
#===============================================================

#-------------------
# Personnal Aliases
#-------------------

# tmux settings, to keep vim color modes
alias tmux="TERM=screen-256color-bce tmux"

alias con='cat contacts | grep '

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# -> Prevents accidentally clobbering files.

alias l='ls --group-directories-first'
alias h='cd ~'
alias untar='tar -xvzf'
alias jiva='cd ~/Jiva/sentinel_instanceUsingMsgQ'
alias jivap='cd ~/Jiva/sentinel_instanceUsingMsgQ/Products'
alias jivaz='cd ~/Jiva/sentinel_instanceUsingMsgQ/Products/ZeSentinel'

alias j='jobs -l'
alias r='rlogin'
alias which='type -all'
alias ..='cd ..'
alias path='echo -e ${PATH//:/\\n}'
alias print='/usr/bin/lp -o nobanner -d $LPDEST'   # Assumes LPDEST is defined
alias pjet='enscript -h -G -fCourier9 -d $LPDEST'  # Pretty-print using enscript
alias background='xv -root -quit -max -rmode 5' # put a picture in the background
alias vi='vim'
alias du='du -h'
alias df='df -kh'

# The 'ls' family (this assumes you use the GNU ls)
alias ls='ls -hF --color'  # add colors for filetype recognition
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size
alias la='ls -Al'          # show hidden files
alias lr='ls -lR'          # recursice ls
alias lt='ls -ltr'         # sort by date
alias lm='ls -al |more'    # pipe through 'more'
alias tree='tree -Cs'      # nice alternative to 'ls'


# tailoring 'less'
alias more='less'
export PAGER=less
export LESSCHARSET='latin1'
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-' # Use this if lesspipe.sh exists
export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

# spelling typos - highly personnal :-)
alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'


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
