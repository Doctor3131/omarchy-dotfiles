# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load omarchy-zsh configuration
if [[ -d /usr/share/omarchy-zsh/conf.d ]]; then
  for config in /usr/share/omarchy-zsh/conf.d/*.zsh; do
    [[ -f "$config" ]] && source "$config"
  done
fi

# Load omarchy-zsh functions and aliases
if [[ -d /usr/share/omarchy-zsh/functions ]]; then
  for func in /usr/share/omarchy-zsh/functions/*.zsh; do
    [[ -f "$func" ]] && source "$func"
  done
fi


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH=$HOME/.local/bin:$PATH
export PATH="$PATH:/home/sirifari/Downloads/balena/bin"
# export PATH=$HOME/Dowonloads/Postman:$PATH
# change alacritty opacity
# alias transparant="sed -i 's/opacity = .*/opacity = 0.8/' ~/.config/alacritty/alacritty.toml"

# case-insansitive match
eval "$(zoxide init zsh)"
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# ===========================
# zsh setup
# ===========================
setopt CORRECT

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# ===========================
# Compilation and Execution
# ===========================
# Alias for section header (for 'show' command visibility)
alias t1='===============Compilation and execution================='
alias com1='gcc main.c'
alias com2='python compiler.py'
alias cr1='gcc main.c && ./a.out'
alias cr2='python compiler.py && ./app.out'
alias cr3='manim -pql main.py'
alias run1='./a.out'
alias run2='./app.out'
alias run3='manim -pql'
alias endt1='' # Alias for section footer (for 'show' command visibility)


# ===========================
# File Deletion
# ===========================
# Alias for section header
alias t2='=====================Delete file========================='
# Removes .o, .exe, and .class files recursively in the current directory
alias rmo='find . -type f \( -name "*.o" -o -name "*.exe" -o -name "*.class" \) -exec rm -f {} +'
alias endt2='' # Alias for section footer


# ===========================
# List Commands
# ===========================
# Alias for section header
alias t4='====================List commands========================'
# macOS ls doesn't support --color=auto by default, but Zsh often has an alias for this already
# alias ls='ls --color=auto'
# alias ll='ls -alF'
# alias la='ls -A'
# alias l='ls -CF'

# alias ls='eza --icons --sort=type --group-directories-first'
alias la='eza -A --icons --sort=type --group-directories-first'
alias ls='eza -lh --git --icons --sort=type --group-directories-first'
alias ll='eza -lah --git --icons --sort=type --group-directories-first'
alias lt='eza --tree --icons --sort=type --group-directories-first'
alias lti='eza -lT --ignore-glob=".git|node_modules" --icons --sort=type --group-directories-first'
alias lt2='eza --tree --level=2 --icons --sort=type --group-directories-first'
# cd then ls
function cdl() { 
    cd "$1" && ls
}

# cd then ls then ls
function lsd() {
    cd "$1" && ls && cd - > /dev/null
}
alias endt4='' # Alias for section footer


# ===========================
# Grep with Color
# ===========================
# Alias for section header
alias t5='===================Grep with color======================='
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias endt5='' # Alias for section footer


# ===========================
# Display All Aliases
# ===========================
# Alias for section header
alias t6='=================Display all aliases====================='
alias aliases='alias | sort'
# MODIFIED: This 'show' alias will now look for any line starting with 'alias ' OR 't[0-9]=' OR 'endt[0-9]='
alias show="grep -E '^(alias|alias t[0-8]=|alias endt[0-8]=)' ~/.zshrc"
alias endt6='' # Alias for section footer


# ===========================
# Git
# ===========================
# Alias for section header
alias t7='=========================git============================='
alias gst='git status'
alias gs='git switch'
alias ga='git add .'
alias gl='git pull'
alias gp='git push'
alias gd='git diff | mate' # Assuming 'mate' is an alias or command for your text editor
alias gau='git add --update'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcamj='git commit -a -m "just a daily commit"'
alias gcv='git commit -v'
alias gcva='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcot='git checkout -t'
alias gcotb='git checkout --track -b'
alias glog='git log'
alias glogp='git log --pretty=format:"%h %s" --graph'
alias endt7='' # Alias for section footer


# ===========================
# Download with yt-dlp
# ===========================
# Alias for section header
alias t8='=====================yt-dlp=============================='
# Downloads audio as mp3. You might want to specify an output directory.
alias ytd='yt-dlp -x --audio-format mp3'
alias endt8='' # Alias for section footer

# download from google with gdown 
alias t10='=====================gdown=============================='
alias gdownh='https://drive.google.com/uc?id='
alias endt10='' # Alias for section footer

# tmux keybindings 
alias t11='=====================fzf================================'
alias 'search command history'='C+r'
alias 'search files and dir'='C+t'
alias 'change dir using fzf'='Alt_c'
alias endt11='' # Alias for section footer

# tmux keybindings 
alias t12='=====================tmux==============================='
alias create='tmux new -s create'
alias get='tmux attach -t create'
alias als='use "ts " for easier'
alias endt12='' # Alias for section footer

# bash keybindings
alias t13='=====================bash==============================='
alias ssn='hyprctl dispatch exec "[class:main-screensaver;fullscreen;monitor 0]" "alacritty --class main-screensaver -e bash ~/.local/share/omarchy/bin/omarchy-cmd-screensaver-current"'
alias endt13='' # Alias for section footer

# monitors keybindings
alias t14='=====================monitors==============================='
alias monitors='nwg-displays'
alias endt14='' # Alias for section footer

# toggle transparancy keybindings
alias t15='=====================toggletransparency==============================='
alias toggletransparency='if grep -q "opacity = 0.8" ~/.config/alacritty/alacritty.toml; then sed -i "s/opacity = .*/opacity = 1.0/" ~/.config/alacritty/alacritty.toml; else sed -i "s/opacity = .*/opacity = 0.8/" ~/.config/alacritty/alacritty.toml; fi'
alias toggle='if grep -q "opacity = 0.8" ~/.config/alacritty/alacritty.toml; then sed -i "s/opacity = .*/opacity = 1.0/" ~/.config/alacritty/alacritty.toml; else sed -i "s/opacity = .*/opacity = 0.8/" ~/.config/alacritty/alacritty.toml; fi'
alias endt15='' # Alias for section footer

# tmux attach or create session
ts() {
  tmux attach-session -t "$1" || tmux new-session -s "$1"
}

# Spicetify
export PATH=$PATH:~/.spicetify
eval $(thefuck --alias)

# Add your own customizations below
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZLE_RPROMPT_INDENT=0

export EZA_COLORS="gi=2;37"

# opencode
export PATH=/home/sirifari/.opencode/bin:$PATH
export EDITOR=nvim

# composer
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/sirifari/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/sirifari/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/sirifari/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/sirifari/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

eval "$(tv init zsh)"
