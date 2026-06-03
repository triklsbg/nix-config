{ config, ... }:
let
  inherit (config.flake.modules)
    generic
    nixos
    darwin
    homeManager
    ;
  commonImports = [
    generic.profile
    generic.primaryUser
    generic.primaryUserHome
    generic.nixSettings
  ];
in
{
  flake.modules.nixos.base = {
    imports = commonImports ++ [
      nixos.audio
      nixos.bluetooth
      nixos.boot
      # nixos.containers  # trikl not needed
      nixos.locale
      nixos.networking
      nixos.services
      nixos.users
      nixos.zsh
      nixos.fish  # similiar to nixos.zsh trikl
    ];
    home-manager.sharedModules = [ homeManager.base ];
  };

  flake.modules.darwin.base = {
    imports = commonImports ++ [
      darwin.fonts
      darwin.keyboard
      darwin.sudo
      darwin.systemPreferences
      darwin.users
    ];
    home-manager.sharedModules = [ homeManager.base ];
  };

  flake.modules.homeManager.base = {
    imports = [
      generic.profile
      homeManager.alacritty
      homeManager.atuin      # network wide shell history, sql-lite based
      homeManager.bat
      homeManager.btop
      homeManager.catppuccin
      homeManager.claudeCode
      homeManager.fastfetch
      homeManager.fonts
      homeManager.fzf
      homeManager.git
      homeManager.go
      homeManager.gpg
      # homeManager.granted   # way to access AWS
      # homeManager.k8s         # kybernetes super power
      # homeManager.mcp
      homeManager.neovim
      homeManager.opencode      # AI coding agent
      homeManager.packages
      homeManager.scripts       # dir with bash/python... scripts
      homeManager.starship
      homeManager.tmux
      homeManager.zsh
    ];
  };
}
