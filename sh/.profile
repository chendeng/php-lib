[ -f ~/.profile_private ] && source ~/.profile_private

#export
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
#export PS1='\e[33;1m\e[31;0.5m\W\e[0m\$ '
#export PS1='\e[33;1m\e[31;1m\W\e[0m\$ '
export PS1='\[\e[1;31m\][\u@\W]\[\e[0m\]\$\n> '
export EDITOR="vim"
export CLICOLOR="xterm-color"


#android sdk
#export PATH="/Users/hilojack/Downloads/android-sdk/platforms/":$PATH
export PATH=$PATH:'/usr/local/sbin'
export ANDROID_HOME=/usr/local/opt/android-sdk

#git
#sh ~/.git.bash

#complete
#tree /usr/local/etc/bash_completion.d
#adb-completion.bash git-completion.bash git-prompt.sh

# alias
alias vi='mvim'
alias cp='cp -i'
alias svnst='svn st'
alias l='ls -lah'
export EDITOR=vim

# git
alias ga.='git add .'
function gcap(){
	git commit -am $1;
	git push;
}

# grep
mcd(){ mkdir -p $@; cd $1}
alias rgrep='grep -R -F'
rgrep.(){ grep -R -F $@ .}

# gbk
function iconvgbk(){
	if test $# -gt 0; then
		test -f $1 && iconv -f gbk -t utf-8  $1 > ~/tmp.txt && mv ~/tmp.txt $1 && echo "Successfully convert $file!";
	fi
}

