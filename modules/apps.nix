{ pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
  ];
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    taps = [
      "homebrew/services"
      "homebrew/cask-fonts"
    ];

    brews = [
      "awscli"
      "tfenv"
      "zplug"
      "starship"
      "kubernetes-cli"
      "pass"
      "pass-otp"
      "zoxide"
      "nvm"
      "up"
      "helm"
      "watch"
      "gh"
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
