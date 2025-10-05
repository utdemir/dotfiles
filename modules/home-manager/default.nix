{ pkgs, ... }:

{
  imports = [ 
    ./packages.nix 
    ./shell.nix
    ./git.nix
  ];
}