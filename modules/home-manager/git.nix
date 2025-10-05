{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git-lfs
    gitAndTools.hub
    gitAndTools.gh
  ];

  programs.git = {
    enable = true;
    userName = "Utku Demir";
    userEmail = "me@utdemir.com";
    aliases = {
      co = "checkout";
      st = "status -sb";
      wip = "commit -am 'wip'";
      recent = "log --oneline -n 10 --graph --decorate --all";
    };
    delta = {
      enable = true;
    };
    ignores = [
      ".envrc"
      ".vscode"
    ];
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      "pull" = {
        ff = "only";
      };
      "commit" = {
        verbose = "true";
      };
      "filter \"lfs\"" = {
        process = "git-lfs filter-process";
        required = true;
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
      };
      url = {
        "ssh://git@github.com/" = { insteadOf = https://github.com/; };
      };
      hub = {
        protocol = "git";
      };
      advice = {
        detachedHead = false;
      };
    };
    # signing = {
    #   signByDefault = true;
    #   key = config.dotfiles.params.gpgKey;
    #   gpgPath = "gpg";
    # };
  };
}