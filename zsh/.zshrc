# Path to your oh-my-zsh installation.
#export EDITOR='vim'
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git autojump)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=$PATH:$HOME/bin
export GNUTERM=qt
# export MANPATH="/usr/local/man:$MANPATH"
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
export EDITOR='vim'
## private
[ -f ~/.profile_private ] && . ~/.profile_private

# key bindings
#bindkey "\e[1~" beginning-of-line
#bindkey "\e[4~" end-of-line
# CTRL+q
stty start undef
stty stop undef
bindkey \^U backward-kill-line



# Compilation flags
export ARCHFLAGS="-arch x86_64"
export LDFLAGS="-L/usr/local/opt/icu4c/lib"
export CPPFLAGS="-I/usr/local/opt/icu4c/include"
# export ARCHFLAGS="-Wno-error=unused-command-line-argument-hard-error-in-future"

alias -s js=vi
alias vi='mvim'
alias cp='cp -i'
alias svnst='svn st'

# git
alias ga.='git add .'

# grep
mcd(){mkdir -p $@; cd $1}
alias rgrep='grep -R -F'
rgrep.(){grep -R -F $@ .}

# gbk
function iconvgbk(){
	if test $# -gt 0; then
		test -f $1 && iconv -f gbk -t utf-8  $1 > ~/tmp.txt && mv ~/tmp.txt $1 && echo "Succ!";
	fi
}

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
