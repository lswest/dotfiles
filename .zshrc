autoload colors; colors
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

##RPROMPT="%{$fg[red]%}[%{$fg[cyan]%}%* on %D%{$fg[red]%}]%{$reset_color%}" # Prompt for right side of screen

# prompt (if running screen, show window #)
if [ x$WINDOW != x ]; then
    # [5:lswest@lswest-laptop:~]% 
    export PS1="%{$fg[white]%}┌─[%{$fg[cyan]%}$WINDOW%{$fg[white]%}:%{$fg[green]%}%n%{$fg[cyan]%}@%{$fg[green]%}%m%{$fg[white]%}:%{$fg[yellow]%}%~%{$fg[white]%}]%{$fg[yellow]%}-%{$fg[red]%}[%{$fg[cyan]%}%*%{$fg[red]%}]%{$reset_color%}%{$reset_color%}"$'\n'"%{$fg[white]%}└─>%{$reset_color%} "
else
    # [lswest@lswest-laptop:~]% 
    export PS1="%{$fg[white]%}┌─[%{$fg[green]%}%n%{$fg[cyan]%}@%{$fg[green]%}%m%{$fg[white]%}:%{$fg[yellow]%}%~%{$fg[white]%}]%{$fg[yellow]%}-%{$fg[red]%}[%{$fg[cyan]%}%*%{$fg[red]%}]%{$reset_color%}%{$reset_color%}"$'\n'"%{$fg[white]%}└─>%{$reset_color%} "
fi
export RPRMOPT="%{$reset_color%}"

# format titles for screen and rxvt
function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}
 
  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")
 
  case $TERM in
  screen*)
    print -Pn "\ek$a:$3\e\\" # screen title (in ^A")
    ;;
  xterm*|rxvt*)
    ##print -Pn "\e]0;$USER@$HOSTNAME: $PWD\007"
    ##print -Pn "\e]2;$2 | $a:$3\a" # plain xterm title
    precmd() { print -Pn "\e]0;%m:%~\a" }
    preexec () { print -Pn "\e]0;$1\a" }
    ;;
  esac
}

# precmd is called just before the prompt is printed
function precmd() {
  title "zsh" "$USER@%m" "%55<...<%~"
}
 
# preexec is called just before any command line is executed
function preexec() {
  title "$1" "$USER@%m" "%35<...<%~"
}

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/lswest/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#alias
alias ls="ls -la --classify --color=always"

##Set some keybindings
###############################################
typeset -g -A key
bindkey '^?' backward-delete-char
bindkey '^[[7~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[8~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char 
bindkey '^[[2~' overwrite-mode
#################################################

export LC_CTYPE="en_US.utf8"

alias trayer="trayer --edge top  --expand true --widthtype request --height 28 --SetDockType true --transparent true --alpha 255 --align right"

##custom functions
m4a(){
        if [[ "$1" != "" && "$#" == 2 ]]; then
    #check if files exist 
    if [ -e "$1" ]; then
        #convert audio
        ffmpeg -i "$1" "$2"
    else
        echo "File "$1" doesn't exist!"
    fi
    if [ ! -d "$HOME/Music/m4a" ]; then
            mkdir $HOME/Music/m4a
    fi
    #move the .m4a file to the m4a folder if the files exist in the current directory
    if [ -e "$2" ]; then
        mv "$1" $HOME/Music/m4a/"`echo "$2"|sed 's/mp3/m4a/'`"
        echo "m4a file was moved to the ~/Music folder"
        mv "$2" $HOME/Music/
        echo "Moved the mp3 to the ~/Music folder"
    else
        echo "File "$2" doesn't exist!"
    fi
else
    echo "Invalid arguments (or too few/many), please run this script with \"m4a <input> <output>\""
fi
}
# Convert Flash video to MP3
flvmp3() {
      ffmpeg -i $1 -ar 44100 -ab 192k -ac 2 $2
}

export BROWSER="firefox"
#Google from CLI
# go to google for anything
google() {
  local term="$*"

  [ -z "$term" ] && term="$(xclip -o)"

  local URL="http://www.google.com/search?q=${term// /+}"

  $BROWSER "$URL" &>/dev/null &
}


export OOO_FORCE_DESKTOP=gnome
export DE=gnome
#set up the mail environment variable
MAIL=/var/spool/mail/lswest && export MAIL
