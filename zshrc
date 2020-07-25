# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
export GOPATH="/home/david/go"

# Bind keys for history
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# History options
setopt appendhistory
setopt share_history

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# Files --> ranger alias
function files() {
    if [ -n "$1" ]
    then
        ranger "$1"
    else
	ranger ~
    fi
}

alias mail="neomutt"

export EDITOR=nvim
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/david/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/david/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/david/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/david/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /home/david/sources/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/david/sources/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/david/sources/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
