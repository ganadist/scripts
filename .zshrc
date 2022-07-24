# vim: ts=2 sw=2 sts=2 et ai
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="jnrowe"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

plugins=(adb command-not-found sudo vi-mode z zsh_reload)
plugins=($plugins autojump history-substring-search dotenv)
plugins=($plugins gem ruby pip python)
plugins=($plugins repo svn)
plugins=($plugins docker docker-compose)
case $(uname -s) in
  Linux)
    plugins=($plugins archlinux systemd)
    ;;
  Darwin)
    plugins=($plugins osx brew xcode)
    ;;
esac
[ -z $SSH_AUTH_SOCK ] && plugins=($plugins ssh-agent)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
setopt nullglob
unsetopt chaselinks
unsetopt share_history
unsetopt correct_all

#zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'

if [ -d ~/.zsh.d ]; then
  for zshrc_snipplet in ~/.zsh.d/S[0-9][0-9]*[^~] ; do
	#echo "loading $zshrc_snipplet"
	source $zshrc_snipplet
  done
fi

# colors for ls, etc.  Prefer ~/.dir_colors #64489
[ -f ~/.dir_colors ] && eval `dircolors -b ~/.dir_colors`
[ -f /etc/DIR_COLORS ] && eval `dircolors -b /etc/DIR_COLORS`
[ -f $HOME/.profile ] && source $HOME/.profile

# save path
PATH_BASE=$PATH
HISTSIZE=5000
SAVEHIST=5000


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/ganadist/.sdkman"
[[ -s "/home/ganadist/.sdkman/bin/sdkman-init.sh" ]] && source "/home/ganadist/.sdkman/bin/sdkman-init.sh"
