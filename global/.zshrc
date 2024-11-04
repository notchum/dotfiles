# Update PATH for user scripts
if [ -d "$HOME/bin" ] ; then
  export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# oh-my-zsh theme
ZSH_THEME="spaceship"

# oh-my-zsh plugins
plugins=(
  copyfile
  extract
  git
  python
  rust
  fzf
  z
  zsh-syntax-highlighting
  zsh-autosuggestions
)
export FZF_BASE=/usr/bin/fzf
source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export SUDO_PROMPT="[] Enter Password: "
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export VISUAL=nvim
export EDITOR=$VISUAL
export PAGER=bat
export TERMCMD=kitty
export BROWSER=firefox

# pfetch configuration
export PF_INFO="ascii title os kernel shell pkgs uptime memory"

# Shortened command aliases
alias ..='cd ..'
alias v='vim'
alias nv='nvim'

# Improved command aliases
alias rm='rm -rIv'
alias cp='cp -rv'
alias mv='mv -v'
alias mkdir='mkdir -pv'
alias free='free -mt'
alias ps='ps auxf'
alias grep='grep --color=auto'
alias dust='dust -r'
alias delta='delta -sn'

# Remapped aliases
alias eza='eza --icons --group-directories-first --git --color=auto'
alias la='eza -a'
alias ll='eza -lah'
alias ls='eza'
alias ezatree='eza --icons --tree --level=2'

# Useful aliases
alias hmmm='paru -Sy &> /dev/null && paru -Qu'
alias remove-orphans='orphans=$(pacman -Qdtq); [ -z "$orphans" ] && echo "There are no orphaned packages" || sudo pacman -Rsc $orphans'
alias error='journalctl -b -p err'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'
alias histg='history | grep'
alias myip='curl ipv4.icanhazip.com'
alias ipv4="ip addr show | grep 'inet ' | grep -v '127.0.0.1' | cut -d' ' -f6 | cut -d/ -f1"
alias ipv6="ip addr show | grep 'inet6 ' | cut -d ' ' -f6 | sed -n '2p'"
alias show='rifle'
alias bw-lock='bw lock && unset BW_SESSION'
alias bw-unlock='export BW_SESSION=$( bw unlock --raw )'

# Startup commands
clear
neofetch

# Open lazygit with Ctrl+g
lazygit_func () {
  eval 'lazygit'
}
zle -N lazygit_func
bindkey '^g' lazygit_func

# Prevent ranger from nesting
ranger() {
  if [ -z "$RANGER_LEVEL" ]; then
    /usr/bin/ranger "$@"
  else
    exit
  fi
}

# Turn off all beeps
unsetopt BEEP
# Turn off autocomplete beeps
# unsetopt LIST_BEEP
