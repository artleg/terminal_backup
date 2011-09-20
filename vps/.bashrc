PS1='\[\033[0;35m\]\u@\h\[\033[0;33m\] \w\[\033[00m\]: '
# Распаковка любого архива (http://muhas.ru/?p=55)
unpack() {
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
	*)           echo "Cannot unpack '$1'..." ;;
esac
else
echo "'$1' is not a valid file"
fi
}

# ... и упаковка (http://muhas.ru/?p=55)
pack() {
if [ $1 ] ; then
case $1 in
	tbz)   	tar cjvf $2.tar.bz2 $2      ;;
	tgz)   	tar czvf $2.tar.gz  $2   	;;
	tar)  	tar cpvf $2.tar  $2       ;;
	bz2)	bzip $2 ;;
	gz)		gzip -c -9 -n $2 > $2.gz ;;
	zip)   	zip -r $2.zip $2   ;;
	7z)    	7z a $2.7z $2    ;;
	*)     	echo "'$1' Cannot be packed via pack()" ;;
esac
else
echo "'$1' is not a valid file"
fi
}
#________
#Переименование файлов: «name имяфайла» и появится диалог для переименования.
name() {
    name=$1
    vared -c -p 'rename to: ' name
    command mv $1 $name
}
alias debi="sudo dpkg -i"
alias dinst="dpkg --get-selections"
alias radd="sudo add-apt-repository"
alias srhpid="ps ax | grep"
alias uu="sudo apt-get update && sudo apt-get upgrade"
alias inst="sudo apt-get install"
alias srh="apt-cache search"
alias rem="sudo apt-get purge"
alias arem="sudo apt-get autoremove"
alias rsync="rsync -r --progress"
alias ls="ls --color=auto --group-directories-first"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias free="free -m"
alias df="df -h"