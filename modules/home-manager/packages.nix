{ pkgs, ... }: 

{
  home.packages = with pkgs; [ 
    coreutils-full gnugrep findutils watch bash zsh
    git git-lfs
    tokei direnv jq ranger ncdu tmate pandoc entr fd ripgrep
    ffmpeg imagemagick rsync rclone asciinema pwgen kakoune
    rustup tmux nix-tree tree awscli 

    pass passExtensions.pass-otp
  ];
}