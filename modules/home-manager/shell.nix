{ pkgs, ... }:

{
  home.packages = [
    pkgs.zsh-autosuggestions
    pkgs.zsh-syntax-highlighting
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "avit";
      plugins = [ "git" "z" ];
    };

    initContent = ''
      export BREW_PREFIX=/opt/homebrew
      export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH"
      
      # nvm
      source "$(brew --prefix nvm)/nvm.sh"

      # direnv
      eval "$(direnv hook zsh)"
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}