# ZSH
zstyle :compinstall filename '$HOME/.zshrc'

## History
HISTFILE="$HOME/.history"
HISTSIZE=100000000
SAVEHIST=100000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

# Misc
unsetopt autocd
unsetopt beep
unsetopt nomatch
bindkey -v       # Vim mode
stty stop undef  # Disable ctrl+s freezing term

## Autocomplete
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit
compinit

# LF stay in directory
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# Binds
bindkey -s '^r' ' lfcd\n'
bindkey -s '^f' ' cd "$(dirname "$(fzf)")"\n'
bindkey -s '^t' ' $TERMINAL & disown\n'

# Aesthetics
## Requires lscolors-git
source /usr/share/LS_COLORS/dircolors.sh

## Prompt
PS1='%F{black}%1~%f %(!.%F{red}.%F{blue})$%f '
fetch

# Sources
[ -f ~/.aliasrc ] && source ~/.aliasrc

## Syntax highlighting 
## (https://archlinux.org/packages/community/any/zsh-syntax-highlighting)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
