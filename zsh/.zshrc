# файл истории команд 
HISTFILE=~/.zhistory

# Подключаем файл с алиасами 
. /home/artleg/Dropbox/backup/terminal/.alias

# peжuм нaвuгaцuu в cтuлe emacs 
bindkey -e

# редактор по дефолту 
export EDITOR=emacs

# режим редактирования команды, вызывает для этого то что в $EDITOR 
autoload -U edit-command-line

# Число команд, сохраняемых в HISTFILE 
SAVEHIST=5000

# Дополнение файла истории 
setopt  APPEND_HISTORY

# Игнорировать все повторения команд 
setopt  HIST_IGNORE_ALL_DUPS

# Игнорировать лишние пробелы 
setopt  HIST_IGNORE_SPACE

# последние комманды в начале файла и не хранить дубликаты 
setopt histexpiredupsfirst histfindnodups

#  продвинутое автодополнение
autoload -U compinit
compinit

# Выбор варианта автодоплонения в виде меню.
zmodload zsh/complist
zstyle ':completion:*' menu yes select

setopt  APPEND_HISTORY      # Дополнение файла истрии
setopt  HIST_IGNORE_SPACE   # Игнopupo лишние пpoбeлы
setopt  HIST_REDUCE_BLANKS  # Удалять из файл истории пустые строки
setopt NUMERIC_GLOB_SORT    # Файлы с цифрами сортировать числовым методом, а не лексическим
setopt completealiases      # автодополнение алифсов
setopt auto_list            # list choice on ambiguous command
#setopt auto_menu            # show menu for completion


# Разноцветные пункты меню в зависимости от типа объекта. 
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# По умолчанию автодополнение для kill и killall не показывает процессы без controlling tty (для всех пользователей кроме root). Устраняем этот недостаток и дополнительно добавляем «красоты»:

zstyle ':completion:*:processes' command 'ps -xuf'
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:processes-names' command 'ps xho command'

# Автопереход по каталогам.
setopt autocd

# Строка приглашения
PROMPT=$'%{\e[0;32m%}%T%{\e[0;36m%}%{\e[0;32m%}:%{\e[0;39m%}%~%{\e[0;36m%}>%{\e[0m%} '
RPROMPT=$'%{\e[0;36m%}%{\e[0;36m%}%n%{\e[0;32m%}|%{\e[0;39m%}%m%{\e[0;36m%}%{\e[0m%} '

# менюшку нам для астокомплита 
zstyle ':completion:*' menu yes select

# Позволяем разворачивать сокращенный ввод, к примеру cd /u/sh в /usr/share 
autoload -U compinit && compinit

# Не считать Control+C за выход из оболочки 
setopt  IGNORE_EOF

# автоматическое удаление одинакового из этого массива 
typeset -U path cdpath fpath manpath

# загружаем список цветов 
autoload colors && colors

# Вызов редактора для редактирования строки ввода (хоткей в стиле emacs) 
# bindkey -M vicmd v edit-command-line для командного режима vi 
zle -N  edit-command-line
bindkey -M emacs "^X^E" edit-command-line

#разукрашиваем ls и автодополнение 
export LS_COLORS='no=00;37:fi=00;37:di=01;36:ln=04;36:pi=33:so=01;35:do=01;35:bd=33;01:cd=33;01:or=31;01:su=37:sg=30:tw=30:ow=34:st=37:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31:*.btm=01;31:*.sh=01;31:*.run=01;31:*.tar=33:*.tgz=33:*.arj=33:*.taz=33:*.lzh=33:*.zip=33:*.z=33:*.Z=33:*.gz=33:*.bz2=33:*.deb=33:*.rpm=33:*.jar=33:*.rar=33:*.jpg=32:*.jpeg=32:*.gif=32:*.bmp=32:*.pbm=32:*.pgm=32:*.ppm=32:*.tga=32:*.xbm=32:*.xpm=32:*.tif=32:*.tiff=32:*.png=32:*.mov=34:*.mpg=34:*.mpeg=34:*.avi=34:*.fli=34:*.flv=34:*.3gp=34:*.mp4=34:*.divx=34:*.gl=32:*.dl=32:*.xcf=32:*.xwd=32:*.flac=35:*.mp3=35:*.mpc=35:*.ogg=35:*.wav=35:*.m3u=35:';
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## Установка нормального поведения клавиш Delete, Home, End и т.д.:
case $TERM in
        linux)
bindkey "^[[2~" yank
bindkey "^[[3~" delete-char
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[e" expand-cmd-path ## C-e for expanding path of typed command
bindkey "^[[A" up-line-or-search ## up arrow for back-history-search
bindkey "^[[B" down-line-or-search ## down arrow for fwd-history-search
bindkey " " magic-space ## do history expansion on space
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
;;
*xterm*|rxvt|(dt|k|E)term)
bindkey "^[[2~" yank
bindkey "^[[3~" delete-char
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey "^[e" expand-cmd-path ## C-e for expanding path of typed command
bindkey "^[[A" up-line-or-search ## up arrow for back-history-search
bindkey "^[[B" down-line-or-search ## down arrow for fwd-history-search
bindkey " " magic-space ## do history expansion on space
;;
esac

#_______________________________________________________
# Функции.

# быстрое переименование 
name() {
    name=$1
    vared -c -p 'rename to: ' name
    command mv $1 $name
}

# распаковка архива 
unpack () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1        ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xf $1        ;;
            *.tbz2)      tar xjf $1      ;;
            *.tgz)       tar xzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "я не в курсе как распаковать '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# упаковка в архив 
pack () {
    if [ $1 ] ; then
        case $1 in
            tbz)   	tar cjvf $2.tar.bz2 $2      ;;
            tgz)   	tar czvf $2.tar.gz  $2   	;;
            tar)  	tar cpvf $2.tar  $2       ;;
			bz2)	bzip $2 ;;
            gz)		gzip -c -9 -n $2 > $2.gz ;;
			zip)   	zip -r $2.zip $2   ;;
            7z)    	7z a $2.7z $2    ;;
            *)     	echo "'$1' cannot be packed via pk()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

#оформим подсветку в grep 
export GREP_COLOR="1;33"

#добавляет в PATH катаалоок в домашней директории.
if [ -d ~/bin ] ; then
  PATH=~/bin:"${PATH}"
fi
