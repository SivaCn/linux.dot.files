## Sourcing External Configs
source ~/.functions
source ~/.aliases

shopt -s extglob 2>/dev/null
set -o noclobber

export VISUAL=vim
# Not to store any history
# export HISTFILE=/dev/null
# To ignore history duplicates
# export HISTCONTROL=ignoredups
export HISTCONTROL=ignorespace
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

#PROMPT_COMMAND='DIR=`pwd|sed -e "s!$HOME!~!"`; if [ ${#DIR} -gt 28 ]; then CurDir=${DIR:0:9}...${DIR:${#DIR}-22}; else CurDir=$DIR; fi'
PROMPT_COMMAND='DIR=`pwd|sed -e "s!$HOME!~!"`; if [ ${#DIR} -gt 28 ]; then CurDir=...${DIR:${#DIR}-20}; else CurDir=$DIR; fi'

# PS1='\n┏━\[\e[7m\]┅◉ \[\e[1;37m\] <Machine> ◉━\[\e[0m\]━━\[\e[7m\]┅◉ @ \[\e[1;37m\] $(ip) ◉━\[\e[0m\]━━\[\e[7m\]┅◉ λ \[\e[1;37m\] $(parse_git_branch) \[\e[7m\] ◉━\[\e[0m\]━━\[\e[7m\]┅◉ ≣ \[\e[1;37m\] $(gittotalstash) ➤ $(gitstashtop) ◉ \[\e[1;37m\]\[\e[0m\] \n┣┅◉  \[\033[1;34m\] `pwd` \[\e[0m\] \n┗\[\e[7m\]┅◉ 웃 \[\e[1;37m\] \u ◉━\[\e[0m\]━> '
# PS1='\n┏━━┅◉  IP ➤ \[\e[1;37m\]$(ip)\[\e[0m\] ◉━━━┅◉  Git Branch ➤ \[\e[1;37m\]$(parse_git_branch)\[\e[0m\] ◉━━━┅◉  Stash ➤ \[\e[1;37m\]$(gittotalstash) (\[\e[0m\]$(gitstashtop)...\[\e[1;37m\])\[\e[0m\] \n┣┅◉  Current Dir ➤ \[\e[1;37m\]$(pwd)\[\e[0m\] \n┗━┅◉  User ➤\[\e[1;37m\] \u \[\e[0m\]◉━━┅◉ '
# PS1='\n┏━━┅◉  IP ➤ \[\e[1;37m\]\[\e[0m\] ◉━━━┅◉  Git Branch ➤ \[\e[1;37m\]$(parse_git_branch)\[\e[0m\] ◉━━━┅◉  Stash ➤ \[\e[1;37m\]$(gittotalstash) (\[\e[0m\]$(gitstashtop)...\[\e[1;37m\])\[\e[0m\] \n┣┅◉  Current Dir ➤ \[\e[1;37m\]$(pwd)\[\e[0m\] \n┗━┅◉  User ➤\[\e[1;37m\] \u \[\e[0m\]◉━━┅◉> '
# PS1='\n┏━TIME┅⟦ \[\e[1;37m\]\@\[\e[0m\] ⟧ ◉━━IP┅⟦ \[\e[1;37m\]$(ip)\[\e[0m\] ⟧ ◉━━BRANCH┅⟦ \[\e[1;37m\]$(parse_git_branch)\[\e[0m\] ⟧ ◉━━STASH┅⟦ \[\e[1;37m\]$(gittotalstash)\[\e[0m\] ⟧ \n┣━PWD┅⟦ \[\e[1;37m\]\w\[\e[0m\] ⟧ \n┗━USER┅⟦ \[\e[1;37m\]\u\[\e[0m\] ⟧ ◉━━┅⟦ '
# PS1='\n\[\e[1;37m\]_dict\[\e[0m\] = \[\e[1;37m\]{\[\e[0m\]\"USER\": \[\e[1;37m\]\u\[\e[0m\], \"IP\": \[\e[1;37m\]$(ip)\[\e[0m\], \"TIME\": \[\e[1;37m\]\@\[\e[0m\], \"GIT_BRANCH\": \[\e[1;37m\]$(parse_git_branch)\[\e[0m\], \"STASH\": \[\e[1;37m\]$(gittotalstash)\[\e[0m\], \n         \"PWD\": \[\e[1;37m\]$(pwd)\[\e[0m\]\n         \[\e[1;37m\]}\[\e[0m\] '
# PS1="\n\[\e[35;1m\]{\[\e[35;0m\]IP: \[\e[37;1m\]\$(ip)\[\e[35;1m\]}---⪼  {\[\e[35;0m\]Git Branch: \[\e[37;1m\]\$(git-branch-name)\$(git-dirty)\$(git-unpushed)\[\e[35;1m\], \[\e[35;0m\]Stashes: \[\e[37;1m\]\$(gittotalstash)\[\e[35;1m\]} \n{\[\e[35;0m\]PWD: \[\e[37;1m\]\w\[\e[35;1m\]}\n-⪼  \[\e[0m\]"
# PS1="\n\[\e[35;1m\]{\[\e[35;0m\]IP: \[\e[37;1m\]\$(ip)\[\e[35;1m\]}--->  {\[\e[35;0m\]Git Branch: \[\e[37;1m\]\$(git-branch-name)\$(git-dirty)\$(git-unpushed)\[\e[35;1m\], \[\e[35;0m\]Stashes: \[\e[37;1m\]\$(gittotalstash)\[\e[35;1m\]} \n{\[\e[35;0m\]PWD: \[\e[37;1m\]\w\[\e[35;1m\]}\n-->  \[\e[0m\]"
# PS1="\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]'; else echo '\[\033[1;33m\]$(git-branch-name)\[\033[0;37m\]: \[\033[1;33m\]$(gittotalstash)\[\033[0;37m\]'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\n\[\033[0;37m\]\342\224\224\342\224\200\342\224\200\342\225\274| \[\033[0m\]"
# PS1="\n\[\e[32;1m\]┌─(\[\e[37;1m\]\u\[\e[32;1m\])──(\[\e[31;1m\]\$(ipaddr1)\[\e[32;1m\])──(\[\e[37;1m\]\$(git-branch-name)\[\e[32;1m\] <-- \[\e[31;1m\]\$(branch-tracks)\[\e[32;1m\])──(\[\e[37;1m\]\$(gittotalstash)\[\e[32;1m\])──(\[\e[31;1m\]\@\[\e[32;1m\])  \n├──(\[\e[37;0m\]\w\[\e[32;1m\])──(\[\e[31;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\]\[\e[32;1m\])\n\[\e[32;1m\]└──⪼  \[\e[0m\]"

# PS1="\n\[\033[1;34m\]\342\226\210\342\226\210 \u @ \$(custom_pwd) \n `if [ $? = 0 ]; then echo "\[\033[1;31m\]\342\226\210\342\226\210 \[\033[0;39m\]"; else echo "\[\033[01;31m\]✘"; fi`"
# PS1='\n`if [ $? = 0 ]; then echo "\[\e[0;37m\]┏━┅◉\[\e[0m\] \[\e[1;34m\]\u\[\e[0m\] \[\e[0;37m\]◉━┅◉\[\e[0m\] \[\e[0;34m\]$(custom_pwd)\[\e[0m\] \[\e[0;37m\]◉━┅◉ \[\e[0m\] \[\e[1;34m\]$(git-branch-name)\[\e[0m\] \[\e[0;34m\]$(branch-tracks)\[\e[0m\] \n\[\033[0;37m\]┗━┅┅◉ \[\e[1;34m\]\@\[\e[0m\] \[\033[0;37m\]⪼  \[\e[0m\]"; else echo "\[\033[0;31m\]┏━┅◉\[\e[0m\] \[\e[1;34m\]\u\[\e[0m\] \[\033[0;31m\]◉━┅◉\[\e[0m\] \[\e[0;34m\]$(custom_pwd)\[\e[0m\] \[\033[0;31m\]◉━┅◉ \[\e[0m\] \[\e[1;34m\]$(git-branch-name)\[\e[0m\] \[\e[0;34m\]$(branch-tracks)\[\e[0m\] \n\[\033[0;31m\]┗━┅┅◉ \[\e[1;34m\]\@\[\e[0m\] \[\033[0;31m\]⪼  \[\e[0m\]"; fi`'

# PS1='\n`if [ $? = 0 ]; then echo "\[\033[1;34m\]\342\226\210\[\e[0m\] ━━(\[\e[32;1m\]\u\[\e[0m\])━━(\[\e[1;34m\]${CurDir}\[\e[0m\])━━ \[\033[1;31m\]>\[\e[0m\] \[\e[32;1m\]$(git-branch-name)\[\e[0m\] (\[\e[1;34m\]$(branch-tracks)\[\e[0m\])\n\[\033[1;34m\]\342\226\210\[\e[1;34m\] ━━(\$(ipaddr1)\[\e[0m\])━━> "; else echo "\[\033[0;31m\]\342\226\210\[\e[0m\]━━(\[\e[32;1m\]\u\[\e[0m\]) ━━(\[\e[1;34m\]${CurDir}\[\e[0m\]) ━━\[\e[32;1m\]$(git-branch-name)\[\e[0m\]) ━━(\[\e[1;34m\]$(branch-tracks)\[\e[0m\])\n\[\033[0;31m\]\342\226\210━━ (\[\e[1;34m\]\$(ipaddr1)\[\e[0m\])━━> "; fi`'

# PS1='\n`if [ $? = 0 ]; then echo "Success"; else echo "Failed"; fi`'

PS1='\n`if [ $? = 0 ]; then echo "\n\[\033[1;34m\]┏━━┅(\[\e[0m\] \[\033[1;37m\]\u\[\e[0m\] \[\033[1;34m\])━━┅(\[\e[0m\] \[\033[1;37m\]${CurDir}\[\e[0m\] \[\033[1;34m\])━━┅( Git:\[\e[0m\] \[\033[1;37m\]$(git-branch-name)\[\e[0m\] \[\033[1;34m\])\[\e[0m\]\n\[\033[1;34m\]┗━┅(\[\e[0m\] \[\033[1;37m\]$(ipaddr1)\[\e[0m\] \[\033[1;34m\])━┅>\[\e[0m\] "; else echo "\n\[\033[1;31m\]┏━━┅(\[\e[0m\] \[\033[1;37m\]\u\[\e[0m\] \[\033[1;31m\])━━┅(\[\e[0m\] \[\033[1;37m\]${CurDir}\[\e[0m\] \[\033[1;31m\])━━┅( Git:\[\e[0m\] \[\033[1;37m\]$(git-branch-name)\[\e[0m\] \[\033[1;31m\])\[\e[0m\]\n\[\033[1;31m\]┗━┅(\[\e[0m\] \[\033[1;37m\]$(ipaddr1)\[\e[0m\] \[\033[1;31m\])━┅(Command Failed)━┅>\[\e[0m\] "; fi`'

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
source ~/.scripts/git_auto_complete.bash
