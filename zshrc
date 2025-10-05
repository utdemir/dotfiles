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

export SOWORK_LOCAL_ENV_NAME=utku

# Add local ~/bin
PATH="$HOME/bin:$PATH"

# Use gnu utilities
PATH="$BREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
PATH="$BREW_PREFIX/opt/grep/libexec/gnubin:$PATH"
PATH="$BREW_PREFIX/opt/zip/bin:$PATH"

# Use completions from brew
FPATH="$BREW_PREFIX/share/zsh/site-functions:$FPATH"

# shortcuts
bindkey "^L" forward-word
bindkey "^H" backward-word

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

# yarn
PATH="$HOME/.yarn/bin/:$PATH"

# rustup
source $HOME/.cargo/env

# nix
. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'

# java
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# ghcup
export PATH="$HOME/.ghcup/bin:$PATH"

# llvm
export PATH="/opt/homebrew/opt/llvm@13/bin:$PATH"

# opam
[[ ! -r /Users/utdemir/.opam/opam-init/init.zsh ]] || source /Users/utdemir/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# j
export PATH="/Applications/j9.4/bin:$PATH"

# factor
export PATH="/Applications/factor:$PATH"

ghcs() {
	FUNCNAME="$funcstack[1]"
	TARGET="shell"
	local GH_DEBUG="$GH_DEBUG"

	read -r -d '' __USAGE <<-EOF
	Wrapper around \`gh copilot suggest\` to suggest a command based on a natural language description of the desired output effort.
	Supports executing suggested commands if applicable.

	USAGE
	  $FUNCNAME [flags] <prompt>

	FLAGS
	  -d, --debug              Enable debugging
	  -h, --help               Display help usage
	  -t, --target target      Target for suggestion; must be shell, gh, git
	                           default: "$TARGET"

	EXAMPLES

	- Guided experience
	  $ $FUNCNAME

	- Git use cases
	  $ $FUNCNAME -t git "Undo the most recent local commits"
	  $ $FUNCNAME -t git "Clean up local branches"
	  $ $FUNCNAME -t git "Setup LFS for images"

	- Working with the GitHub CLI in the terminal
	  $ $FUNCNAME -t gh "Create pull request"
	  $ $FUNCNAME -t gh "List pull requests waiting for my review"
	  $ $FUNCNAME -t gh "Summarize work I have done in issues and pull requests for promotion"

	- General use cases
	  $ $FUNCNAME "Kill processes holding onto deleted files"
	  $ $FUNCNAME "Test whether there are SSL/TLS issues with github.com"
	  $ $FUNCNAME "Convert SVG to PNG and resize"
	  $ $FUNCNAME "Convert MOV to animated PNG"
	EOF

	local OPT OPTARG OPTIND
	while getopts "dht:-:" OPT; do
		if [ "$OPT" = "-" ]; then     # long option: reformulate OPT and OPTARG
			OPT="${OPTARG%%=*}"       # extract long option name
			OPTARG="${OPTARG#"$OPT"}" # extract long option argument (may be empty)
			OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
		fi

		case "$OPT" in
			debug | d)
				GH_DEBUG=api
				;;

			help | h)
				echo "$__USAGE"
				return 0
				;;

			target | t)
				TARGET="$OPTARG"
				;;
		esac
	done

	# shift so that $@, $1, etc. refer to the non-option arguments
	shift "$((OPTIND-1))"

	TMPFILE="$(mktemp -t gh-copilotXXX)"
	trap 'rm -f "$TMPFILE"' EXIT
	if GH_DEBUG="$GH_DEBUG" gh copilot suggest -t "$TARGET" "$@" --shell-out "$TMPFILE"; then
		if [ -s "$TMPFILE" ]; then
			FIXED_CMD="$(cat $TMPFILE)"
			print -s "$FIXED_CMD"
			echo
			eval "$FIXED_CMD"
		fi
	else
		return 1
	fi
}

ghce() {
	FUNCNAME="$funcstack[1]"
	local GH_DEBUG="$GH_DEBUG"

	read -r -d '' __USAGE <<-EOF
	Wrapper around \`gh copilot explain\` to explain a given input command in natural language.

	USAGE
	  $FUNCNAME [flags] <command>

	FLAGS
	  -d, --debug   Enable debugging
	  -h, --help    Display help usage

	EXAMPLES

	# View disk usage, sorted by size
	$ $FUNCNAME 'du -sh | sort -h'

	# View git repository history as text graphical representation
	$ $FUNCNAME 'git log --oneline --graph --decorate --all'

	# Remove binary objects larger than 50 megabytes from git history
	$ $FUNCNAME 'bfg --strip-blobs-bigger-than 50M'
	EOF

	local OPT OPTARG OPTIND
	while getopts "dh-:" OPT; do
		if [ "$OPT" = "-" ]; then     # long option: reformulate OPT and OPTARG
			OPT="${OPTARG%%=*}"       # extract long option name
			OPTARG="${OPTARG#"$OPT"}" # extract long option argument (may be empty)
			OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
		fi

		case "$OPT" in
			debug | d)
				GH_DEBUG=api
				;;

			help | h)
				echo "$__USAGE"
				return 0
				;;
		esac
	done

	# shift so that $@, $1, etc. refer to the non-option arguments
	shift "$((OPTIND-1))"

	GH_DEBUG="$GH_DEBUG" gh copilot explain "$@"
}

export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/utdemir/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
