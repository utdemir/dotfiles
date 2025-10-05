
{ hostname, username, ... }:

{
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  system.primaryUser = username;
  nix.settings.trusted-users = [ username ];

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.${username} = { pkgs, ... }: {
    imports = [ ./home-manager ];

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "25.05";
  };
}
