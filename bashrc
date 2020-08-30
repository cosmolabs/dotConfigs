# to display system infor when launching the terminal
clear && hfetch

alias ssn="sudo shutdown now"
alias sr="sudo reboot"

#hardware info --short
alias hw="hwinfo --short"

#ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1         ;;
           *.tar.gz)    tar xvzf $1         ;;
           *.bz2)       bunzip2 $1          ;;
           *.rar)       unrar x $1          ;;
           *.gz)        gunzip $1           ;;
           *.tar)       tar xvf $1          ;;
           *.tbz2)      tar xvjf $1         ;;
           *.tgz)       tar xvzf $1         ;;
           *.zip)       unzip $1            ;;
           *.Z)         uncompress $1       ;;
           *.7z)        7z x $1             ;;
           *.zst)       tar -I zstd -xvf $1 ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

 SELECT(){
  if [ "$?" -eq 0 ]
    then
    echo ""
  else 
    echo -e "[X]" ; echo -e "\n "
fi
}

COLOR_BLACK="\[$(tput setaf 0)\]"
COLOR_RED="\[$(tput setaf 1)\]"
COLOR_GREEN="\[$(tput setaf 2)\]"
COLOR_YELLOW="\[$(tput setaf 3)\]"
COLOR_BLUE="\[$(tput setaf 4)\]"
COLOR_PURPLE="\[$(tput setaf 5)\]"
COLOR_CYAN="\[$(tput setaf 6)\]"
COLOR_WHITE="\[$(tput setaf 7)\]"
COLOR_BLUE="\[$(tput setaf 8)\]"
COLOR_RESET="\[$(tput sgr0)\]"
COLOR_BOLD="\[$(tput bold)\]"


#PS1="${COLOR_RED}\$(SELECT)${COLOR_RESET}\\h ${COLOR_YELLOW}${COLOR_BOLD}::${COLOR_RESET} ${COLOR_GREEN}\\w ${COLOR_PURPLE}\$(precmd) ${COLOR_B}${COLOR_BOLD}>>${COLOR_RESET} "
PS1="${COLOR_RED}\$(SELECT)${COLOR_GREEN}\\w ${COLOR_PURPLE}\$(precmd)${COLOR_RESET}
${COLOR_GREEN}${COLOR_BOLD}:-:-${COLOR_RESET} "