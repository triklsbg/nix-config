{ inputs, config, ... }:
let
  inherit (config.flake.modules) nixos;
in
{
  configurations.nixos.helios.module = {
    imports = [
      inputs.hardware.nixosModules.common-cpu-amd-pstate
#      inputs.hardware.nixosModules.common-pc-ssd
      inputs.hardware.nixosModules.common-gpu-amd
      ./_hardware_p7.nix
      nixos.base
      nixos.hyprland
       # nixos.gaming
    ];

    primaryUser = "tom1";
    system.stateVersion = "26.05";
  };
}
