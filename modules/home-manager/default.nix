{ pkgs, ... }:

{
  imports = [ 
    ./packages.nix 
    ./shell.nix
  ];
}