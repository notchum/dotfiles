# Update PATH for user scripts
if [ -d "$HOME/bin" ] ; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# Oh-my-zsh installation path
ZSH=/usr/share/oh-my-zsh/

# Update cache directory
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

# Powerlevel10k theme path
P10k_THEME=${P10k_THEME:-/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme}
[[ -r $P10k_THEME ]] && source $P10k_THEME

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Oh-my-zsh plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
plugins=(
  # adds 'ctrl+o' to copy current command line text to clipboard
  copybuffer

  # copyfile <filename>: copies the contents of 'filename'
  copyfile

  # copypath: copies the absolute path of the current directory
  # copypath <file_or_directory>: copies the absolute path of the given file
  copypath

  # defines `cpv` function that uses `rsync`
  cp

  # extract <filename>: extracts the archive of the file you pass to it
  extract

  # enables fzf (installed separately)
  fzf

  # adds a ton of git aliases https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
  git

  # kssh: runs a kitten ssh session
  # kssh-slow: slower form of 'kssh' that always works
  # kitty-theme: change the theme of kitty term
  kitty

  # py: runs 'python3'
  # pyclean [dirs]: cleans byte-code and cache files
  # mkv: make a new virtual environment
  # automatically activates the venv when entering a python project directory
  python

  # adds completion for 'rustc', 'rustup', and 'cargo'
  rust
)

# Plugin configurations
export PYTHON_VENV_NAME=.venv
export PYTHON_AUTO_VRUN=true

# Source Oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export SUDO_PROMPT="[] Enter Password: "
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CONFIG_DIR="${XDG_CONFIG_DIR:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-$XDG_DATA_HOME:/usr/local/share:/usr/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DESKTOP_DIR="${XDG_DESKTOP_DIR:-$HOME/Desktop}"
export XDG_DOWNLOAD_DIR="${XDG_DOWNLOAD_DIR:-$HOME/Downloads}"
export XDG_TEMPLATES_DIR="${XDG_TEMPLATES_DIR:-$HOME/Templates}"
export XDG_PUBLICSHARE_DIR="${XDG_PUBLICSHARE_DIR:-$HOME/Public}"
export XDG_DOCUMENTS_DIR="${XDG_DOCUMENTS_DIR:-$HOME/Documents}"
export XDG_MUSIC_DIR="${XDG_MUSIC_DIR:-$HOME/Music}"
export XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}"
export XDG_VIDEOS_DIR="${XDG_VIDEOS_DIR:-$HOME/Videos}"
export VISUAL=nvim
export EDITOR=$VISUAL
export PAGER=bat
export TERMCMD=kitty
export BROWSER=firefox

# pfetch configuration
export PF_INFO="ascii title os kernel shell pkgs uptime memory"

# Shortened command aliases
alias v='vim'
alias nv='nvim'

# Directory navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Improved command aliases
alias rm='rm -rIv'
alias cp='cp -rv'
alias mv='mv -v'
alias mkdir='mkdir -pv'
alias free='free -mt'
alias ps='ps auxf'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv}'
alias dust='dust -r'
alias delta='delta -sn'

# Helpful aliases
alias ls='eza -1 --icons=auto'
alias ll='eza -lah --icons=auto --sort=name --group-directories-first --git'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree --level=2'
alias lS='eza -l -ssize'
alias lT='eza -l -snewest'
alias rsync-copy='rsync -avz --progress -h'
alias rsync-move='rsync -avz --progress -h --remove-source-files'
alias rsync-update='rsync -avzu --progress -h'
alias rsync-synchronize='rsync -avzu --delete --progress -h'
alias hmmm='paru -Sy &> /dev/null && paru -Qu'
alias remove-orphans='paru -Qdtq | paru -Rnu -'
alias error='journalctl -b -p err'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'
alias histg='history | grep'
alias myip='curl ipv4.icanhazip.com'
alias ipv4="ip addr show | grep 'inet ' | grep -v '127.0.0.1' | cut -d' ' -f6 | cut -d/ -f1"
alias ipv6="ip addr show | grep 'inet6 ' | cut -d ' ' -f6 | sed -n '2p'"
alias bw-lock='bw lock && unset BW_SESSION'
alias bw-unlock='export BW_SESSION=$( bw unlock --raw )'

# Open yazi with 'y' and change CWD on exit
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

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

# Display Pokemon on startup
pokemon-colorscripts --no-title -r 1,2,3,6
