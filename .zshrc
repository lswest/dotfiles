autoload colors; colors
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

##RPROMPT="%{$fg[red]%}[%{$fg[cyan]%}%* on %D%{$fg[red]%}]%{$reset_color%}" # Prompt for right side of screen

# prompt (if running screen, show window #)
if [ x$WINDOW != x ]; then
    # [5:lswest@lswest-laptop:~] 
    export PS1="%{$reset_color%}%{$bg[yellow]%}%{$fg[white]%}$WINDOW:%n%{$fg[yellow]%}%{$bg[magenta]%}⮀%{$fg[magenta]%}%{$bg[white]%}⮀%{$fg[red]%} %m%{$bg[green]%}%{$fg[white]%}⮀%{$bg[green]%}%{$fg[white]%} %c%{$reset_color%}%{$fg[green]%}⮀%{$reset_color%} "
#    export PS1="%{$reset_color%}[%{$fg[green]%}$WINDOW%n%{$fg[cyan]%}@%{$fg[green]%}%m%{$reset_color%}:%{$fg[yellow]%} %c%{$reset_color%}]%# "
#    export PS1="%{$reset_color%}┌─[%{$fg[cyan]%}$WINDOW%{$reset_color%}:%{$fg[green]%}%n%{$fg[cyan]%}@%{$fg[green]%}%m%{$reset_color%}:%{$fg[yellow]%}%~%{$reset_color%}]%{$fg[yellow]%}-%{$fg[red]%}[%{$fg[cyan]%}%*%{$fg[red]%}]%{$reset_color%}%{$reset_color%}"$'\n'"%{$reset_color%}└─>%{$reset_color%} "
else
    # [lswest@lswest-laptop:~] 
    export PS1="%{$reset_color%}%{$bg[yellow]%}%{$fg[white]%}%n%{$fg[yellow]%}%{$bg[magenta]%}⮀%{$fg[magenta]%}%{$bg[white]%}⮀%{$fg[red]%} %m%{$bg[green]%}%{$fg[white]%}⮀%{$bg[green]%}%{$fg[white]%} %c%{$reset_color%}%{$fg[green]%}⮀%{$reset_color%} "
#    export PS1="%{$reset_color%}┌─[%{$fg[green]%}%n%{$fg[cyan]%}@%{$fg[green]%}%m%{$reset_color%}:%{$fg[yellow]%}%~%{$reset_color%}]%{$fg[yellow]%}-%{$fg[red]%}[%{$fg[cyan]%}%*%{$fg[red]%}]%{$reset_color%}%{$reset_color%}"$'\n'"%{$reset_color%}└─>%{$reset_color%} "
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
alias ls="ls -lah --classify --color=always"
alias jwine="LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8 wine"
alias lsr="ls -lahR --classify --color=always"
LS_COLORS='*.textile=38;5;106:ln=target:*.hs=38;5;159:*.ini=38;5;122:*.part=38;5;240:*.pid=38;5;160:*.pod=38;5;106:*.vim=1:*.git=38;5;197:*.urlview=38;5;85:*.dump=38;5;119:*.conf=1:*.md=38;5;184:*.markdown=38;5;184:*.h=38;5;81:*.rb=38;5;192:*.c=38;5;110:*.diff=34;38:*.yml=38;5;208:*.PL=38;5;160:*.csv=38;5;78:tw=33;1;38;5;208:*.chm=38;5;144:*.bin=38;5;249:*.sms=38;5;33:*.pdf=38;5;203:*.cbz=38;5;140:*.cbr=38;5;140:*.nes=38;5;160:*.mpg=38;5;38:*.ts=38;5;39:*.sfv=38;5;197:*.m3u=38;5;172:*.txt=38;5;192:*.log=38;5;190:*.bash=38;5;173:*.swp=38;5;241:*.swo=38;5;236:*.theme=38;5;109:*.zsh=38;5;173:*.nfo=38;5;220:mi=38;5;124:or=38;5;160:ex=33;1;38;5;148:ln=target:pi=38;5;126:ow=33;1;38;5;208:di=38;5;30:*.pm=33;1;38;5;197:*.pl=38;5;214:*.sh=38;5;113:*.patch=31:*.tar=38;5;118:*.tar.gz=38;5;119:*.zip=38;5;11:*.rar=38;5;160:*.tgz=38;5;11:*.7z=38;5;11:*.mp3=38;5;191:*.flac=33;1;38;5;166:*.mkv=33;1;38;5;115:*.avi=38;5;114:*.wmv=38;5;113:*.jpg=38;5;66:*.JPG=38;5;66:*.jpeg=38;5;67:*.png=38;5;68:*.pacnew=38;5;33:*.xz=38;5;118:*.iso=38;5;124:*.css=38;5;91:*.php=38;5;93:*.gitignore=38;5;240:*.tmp=38;5;244:*.py=38;5;41:*.rmvb=38;5;112:*.arj=38;5;11:*.a=38;5;59:*.a00=38;5;11:*.A64=38;5;82:*.pc=38;5;100:*.a52=38;5;112:*.gel=38;5;83:*.ggl=38;5;83:*.directory=38;5;83:*.a78=38;5;112:*.atr=38;5;213:*.j64=38;5;102:st=1;38;5;208:*.st=38;5;208:*.dat=38;5;165:*.db=38;5;60:*.xml=38;5;23:*.cdi=38;5;124:*.nrg=38;5;124:*.32x=38;5;137:*.gg=38;5;138:*.cue=38;5;112:*.adf=38;5;35:*.nds=38;5;193:*.gb=38;5;203:*.gbc=38;5;204:*.gba=38;5;205:*.sav=38;5;220:*.r00=38;5;233:*.r01=38;5;234:*.r02=38;5;235:*.r03=38;5;236:*.r04=38;5;237:*.r05=38;5;238:*.r06=38;5;239:*.r07=38;5;240:*.r08=38;5;241:*.r09=38;5;242:*.r10=38;5;243:*.r11=38;5;244:*.r12=38;5;245:*.r13=38;5;246:*.r14=38;5;247:*.r15=38;5;248:*.r16=38;5;249:*.r17=38;5;250:*.r18=38;5;251:*.r19=38;5;252:*.r20=38;5;253:*.r21=38;5;254:*.r22=38;5;255:*.r47=38;5;255:*.r47=38;5;233:*.r46=38;5;234:*.r45=38;5;235:*.r44=38;5;236:*.r43=38;5;237:*.r42=38;5;238:*.r41=38;5;239:*.r40=38;5;240:*.r39=38;5;241:*.r38=38;5;242:*.r37=38;5;243:*.r36=38;5;244:*.r35=38;5;245:*.r34=38;5;246:*.r33=38;5;247:*.r32=38;5;248:*.r31=38;5;249:*.r30=38;5;250:*.r29=38;5;251:*.r28=38;5;252:*.r27=38;5;253:*.r26=38;5;254:*.r25=38;5;255:*.json=38;5;199:*.SKIP=38;5;244:*.1p=38;5;160:*.3p=38;5;160'
export LS_COLORS
#if [ -f ~/.dircolors ]; then
#    eval `dircolors -b ~/.dircolors`
#fi
alias rsync="rsync -h --progress"
alias exit="exit"
alias university="ssh westerml@rayhalle.informatik.tu-muenchen.de"
alias merge_pdf="gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=finish.pdf"
alias wow="WINEDEBUG=-all wine ~/.wine/drive_c/Program\ Files/World\ of\ Warcraft/Wow.exe"
alias wowL="WINEDEBUG=-all wine ~/.wine/drive_c/Program\ Files/World\ of\ Warcraft/Launcher.exe"
alias steam="WINEDEBUG=-all wine ~/.wine/drive_c/Program\ Files/Steam/Steam.exe"
alias css="cd ~/.wine/drive_c/Program\ Files/Steam && WINEDEBUG=-all wine steam -applaunch 240"

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
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/Debian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
#################################################

export LC_CTYPE="en_US.utf8"
#export QT_PLUGIN_PATH="$QT_PLUGIN_PATH:/opt/lib32/usr/lib/qt/plugins"

alias trayer="trayer --edge top  --expand true --widthtype request --height 28 --SetDockType true --transparent true --alpha 255 --align right"
#alias sbb="sudo bauerbill"
#alias bb="bauerbill"
alias linode="ssh lucas.westermann@linode2.kiwilight.com"
alias sockLin="ssh -D 8080 lucas.westermann@linode2.kiwilight.com"
alias tmux="tmux -2"

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
# Print terminal colors
colors() {
sh /home/lswest/Dropbox/Scripts/bash/colors
}
# Convert Flash video to MP3
flvmp3() {
      ffmpeg -i $1 -ar 44100 -aq 1 -ac 2 $2
}
export EDITOR="vim"
export BROWSER="google-chrome"
#Google from CLI
# go to google for anything
google() {
  local term="$*"

  [ -z "$term" ] && term="$(xclip -o)"

  local URL="http://www.google.com/search?q=${term// /+}"

  $BROWSER "$URL" &>/dev/null &
}
xkcd() {
wget `lynx --dump "http://xkcd.com"|grep png`
display `lynx --dump "http://xkcd.com"|grep png|cut --delimiter="/" -f 5`
}


export OOO_FORCE_DESKTOP=gnome
export DE=gnome
#set up the mail environment variable
MAIL=/var/spool/mail/lswest && export MAIL
#if [ "$PS1" ] ; then
#        mkdir -m 0700 -p /mnt/cgroups/cpu/me/$$
#        echo 1 > /mnt/cgroups/cpu/me/$$/notify_on_release
#        echo $$ > /mnt/cgroups/cpu/me/$$/tasks
#fi

#uim-fep
#clear
