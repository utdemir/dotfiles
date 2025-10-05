{ pkgs, ... }: 

{
  home.packages = with pkgs; [ 
    coreutils-full gnugrep findutils bash zsh
    git git-lfs
    tokei direnv jq ranger ncdu tmate pandoc entr fd ripgrep
    ffmpeg imagemagick rsync rclone asciinema pwgen kakoune
    rustup tmux nix-tree
  ];
}