{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-rosetta-builder = {
      url = "github:cpick/nix-rosetta-builder";
    };
  };

  outputs = inputs @ {
    ...
  }: let
    username = "utdemir";
    system = "aarch64-darwin";
    hostname = "mosscap";

    specialArgs =
      inputs
      // {
        inherit username hostname;
      };
  in {
    darwinConfigurations."${hostname}" = inputs.darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix

        ./modules/host-users.nix

        inputs.nix-rosetta-builder.darwinModules.default
        "${inputs.home-manager}/nix-darwin"
      ];
    };
    # nix code formatter
    formatter.${system} = inputs.nixpkgs.legacyPackages.${system}.alejandra;
  };
}