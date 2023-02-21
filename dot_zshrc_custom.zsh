export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERM="xterm-256color"

# Disable autocomplete on scp, as it is always slow
zstyle ':completion:*' remote-access no

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
  export EDITOR='code'
fi

export PATH="$HOME/.local/bin:$PATH"
export PAGER="bat"

source $HOME/.local/share/iterm2/iterm2_shell_integration.zsh

alias zshc="$EDITOR $HOME/.zshrc_custom.zsh"
alias zshs="$EDITOR $HOME/.secrets.sh"

function tm () {
    edit_tmux_lines 10
}

function tmb () {
    edit_tmux_lines 50
}

function tmbb () {
    edit_tmux_lines 100
}

function edit_tmux_lines () {
    if [[ "$#" -ne 1 ]]; then
        echo "[ERROR] Invalid arguments, please pass the number of lines to tail."
        return 1
    fi

    local tail_lines="$1"

    local tmux_buffer_path="/tmp/tmux-buffer-micro.txt"
    if ! tmux capture-pane -p > "$tmux_buffer_path"; then
        echo "[ERROR] Could not save pane to: $tmux_buffer_path"
        return 1
    fi

    local head_lines="$(($tail_lines - 1))"
    sed '/^$/d' "$tmux_buffer_path" | \
       tail -n "$tail_lines" | head -n "$head_lines" | \
       micro
}

alias dev-tmux-restart='tmux kill-server; dev-tmux'

# SSH into a machine without the host key check (avoid "someone is doing something nasty" error)
alias sshi="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
# Copy my public key to clipboard to share it quickly
alias pk="cat $HOME/.ssh/id_ed25519.pub | tr -d '\n' | clipcopy"
# Open my SSH config
alias sshc="$EDITOR $HOME/.ssh/config"
# Open my known-hosts file
alias sshkh="$EDITOR $HOME/.ssh/known_hosts"
# Open my authorized_keys file
alias sshak="$EDITOR $HOME/.ssh/authorized_keys"
# List authorized_keys names / comments
alias sshakl="cat ~/.ssh/authorized_keys | grep -Eo ' \S+\$' | grep -Eo '\S+'"

# This script was automatically generated by the broot program
# More information can be found in https://github.com/Canop/broot
# This function starts broot and executes the command
# it produces, if any.
# It's needed because some shell commands, like `cd`,
# have no useful effect if executed in a subshell.
function br {
    f=$(mktemp)
    (
        set +e
        broot --outcmd "$f" "$@"
        code=$?
        if [ "$code" != 0 ]; then
            rm -f "$f"
            exit "$code"
        fi
    )
    code=$?
    if [ "$code" != 0 ]; then
        return "$code"
    fi
    d=$(<"$f")
    rm -f "$f"
    eval "$d"
}

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

eval "$(direnv hook zsh)"

# copy/move ask for permission
alias cp='cp -i'
alias mv='mv -i'

if [[ "$OSTYPE" == "darwin"* ]]; then
    alias sed="gsed"
    alias date="gdate"
fi

# Modern tools replace old ones
alias cat="bat --paging never --plain"
alias catp="bat"
alias find="fd"
alias man="tldr"

alias rg="rg --sort-files"

# show file previews for fzf using bat
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

# If we need to unalias entries from common-aliases from Oh-My-ZSH
#for COMMAND in l ll la; do unalias \$COMMAND; done
alias ls='exa' # ls
alias l='exa -lbFa --git --icons' # list, size, type, git
alias ll='exa -lbGFa --git --icons' # long list
alias llm='exa -lbGda --git --icons --sort=modified' # long list, modified date sort
alias la='exa -lbhHigUmuSa --time-style=long-iso --git --icons --color-scale' # all list
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --icons --color-scale' # all + extended list
alias lt="exa --tree --icons -a -I '.git|__pycache__|.mypy_cache|.ipynb_checkpoints'" # tree view

alias lg=lazygit

alias vsc="code ."
alias vscn="code --new-window"
alias vscr="code --reuse-window"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval $(thefuck --alias)
# To fix 'git push' with a new branch
export THEFUCK_PRIORITY="git_hook_bypass=1100"

alias dwl='cd $HOME/Downloads'

