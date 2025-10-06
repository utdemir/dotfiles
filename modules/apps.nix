{ pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
  ];
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    taps = [
      "homebrew/cask-fonts"
    ];

    brews = [
      "tfenv"
      "starship"
      "kubernetes-cli"
      "nvm"
    ];

    casks = [
      "google-chrome"
      "slack"
      "flycut"
      "visual-studio-code"
      "iterm2"
      "element"
      "rectangle"
      "zoom"
      "ngrok"
      "docker-desktop"
      "font-fira-code-nerd-font"
    ];
  };
}
