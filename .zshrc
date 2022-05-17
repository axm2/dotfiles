# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/axm/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export ALSA_CARD=PCH
export WPA_CLI_INTERFACE=wlp4s0
export JAVA_HOME=/usr/lib/jvm/openjdk11
export COLORTERM=truecolor

alias ls='ls --color=auto'
export PS1="%~ %# "
alias rm='rm -I --preserve-root'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias df='df -H'
alias setclip='xclip -selection c'
alias getclip='xclip -selection o'
alias scr = f() {
                 scrot -s -l mode=edge -e 'curl -F "file=@ $f" https://x0.at/'
               }

if test -z "${XDG_RUNTIME_DIR}"; then
	export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
	if ! test -d "${XDG_RUNTIME_DIR}"; then
		mkdir "${XDG_RUNTIME_DIR}"
		chmod 0700 "${XDG_RUNTIME_DIR}"
	fi
fi


source /home/axm/.config/broot/launcher/bash/br
