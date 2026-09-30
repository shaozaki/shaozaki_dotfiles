# ENVIRONMENT VARIABLES
export EDITOR='nvim'
export VISUAL='nvim'

# HISTORY AND KEYBINDINGS
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
HISTDUP=erase
setopt appendhistory sharehistory
setopt hist_ignore_space hist_ignore_dups hist_ignore_all_dups hist_save_no_dups

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# ALIASES & COMPLETION STYLING
alias ls='ls --color'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# ZINIT CORE
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager...%f"
    command mkdir -p "$(dirname $ZINIT_HOME)" && command chmod g-rwX "$(dirname $ZINIT_HOME)"
    command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi
source "$ZINIT_HOME/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# ZINIT ANNEXES
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# PLUGINS
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# COMPINIT (Dimuat sekali setelah plugin selesai)
autoload -Uz compinit
compinit

# FZF AND FZF-TAB
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
source <(fzf --zsh)
zinit light aloxaf/fzf-tab
zstyle ':completion:*:*:cd:*:*' fzf-preview 'ls -1 -a --color=always $realpath'
zstyle ':completion:*:*:*:*:*' fzf-preview 'bat -n --color=always $realpath'

# ZOXIDE
eval "$(zoxide init zsh)"
zstyle ':completion:*:*:z:*' fzf-preview 'ls -1 -a --color=always $realpath'

# OH-MY-ZSH SNIPPETS
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::pacman
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit cdreplay -q

# PROMPT THEME
eval "$(oh-my-posh init zsh --config ~/.config/omp/theme.json)"
