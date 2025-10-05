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
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}