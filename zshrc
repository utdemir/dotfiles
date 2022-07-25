BREW_PREFIX="$(brew --prefix)"

################
# Dependencies #
################

export ZPLUG_HOME="$BREW_PREFIX/opt/zplug"
source "$ZPLUG_HOME"/init.zsh

zplug "modules/completion", from:prezto
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "popstas/zsh-command-time", at:803d26e

ZSH_UP_UNSAFE_FULL_THROTTLE=true
zplug "utdemir/zsh-up"

if ! zplug check; then zplug install; fi
zplug load

#################
# Configuration #
#################

# Use gnu utilities
PATH="$BREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
PATH="$BREW_PREFIX/opt/grep/libexec/gnubin:$PATH"

# Use completions from brew
FPATH="$BREW_PREFIX/share/zsh/site-functions:$FPATH"

# Import some apps
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

# Aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
function hr() {
    printf "%10s" '' | tr ' ' '\n'
    for _ in $(seq 1 3); do
    printf "%$(tput cols)s" '' | tr ' ' '='
    done
    printf "%10s" '' | tr ' ' '\n'
}

# Iterm2 integration
source "$HOME/.iterm2_shell_integration.zsh"

# nvm
# From nvm's homebrew post-install notice
[ -d "~/nvm" ] || mkdir -p ~/.nvm
export NVM_DIR="$HOME/.nvm"
source "$BREW_PREFIX/opt/nvm/nvm.sh"  # This loads nvm
source "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# rustup
source $HOME/.cargo/env

# nix
. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
