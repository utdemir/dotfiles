{ pkgs, ... }: 

{
  home.packages = with pkgs; [ 
    tokei direnv jq ranger ncdu tmate pandoc entr fd ripgrep
    ffmpeg imagemagick rsync rclone
  ];
}