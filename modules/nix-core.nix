{
  pkgs,
  lib,
  ...
}:
{

  ids.gids.nixbld = 30000;

  nix = {
    enable = true;

    package = pkgs.nix;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      builders-use-substitutes = true;

      # Disable auto-optimise-store because of this issue:
      #   https://github.com/NixOS/nix/issues/7273
      # "error: cannot link '/nix/store/.tmp-link-xxxxx-xxxxx' to '/nix/store/.links/xxxx': File exists"
      auto-optimise-store = false;
    };

    gc = {
      automatic = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 7d";
    };
  };

  # Linux builder VM configuration
  nix.linux-builder = {
     # If you're trying to switch to nix-rosetta-builder
     # for the first time but need a linux machine - you can
     # temporarily enable this to break the chicken-egg problem
     # as this configuration comes from Hydra cache.
    enable = false;
    systems = [ "aarch64-linux" ];
    ephemeral = true;
  };

  nix-rosetta-builder = {
    enable = true;
    onDemand = true;
  };
}
