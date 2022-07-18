#!/usr/bin/env bash

set -o errexit
set -o xtrace

cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")"	

brew bundle --cleanup

ln -sf "$PWD/zprofile" "$HOME/.zprofile"
ln -sf "$PWD/zshrc" "$HOME/.zshrc"
ln -sf "$PWD/gitconfig" "$HOME/.gitconfig"

: Done
