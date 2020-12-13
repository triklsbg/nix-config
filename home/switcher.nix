{ config, pkgs, ...}:

let
  xrandr = "${pkgs.xorg.xrandr}/bin/xrandr";
in
  pkgs.writeShellScriptBin "hms" ''
    monitors=$(${xrandr} --listmonitors)

    if [[ $monitors == *"HDMI-1"* ]]; then
      echo "Switching to default HM config for HDMI-1"
      home-manager -f ${config.xdg.configHome}/nixpkgs/display/hdmi.nix switch
    elif [[ $monitors == *"HDMI-A-0"* ]]; then
      echo "Switching to HM config for HDMI-A-0"
      home-manager -f ${config.xdg.configHome}/nixpkgs/display/edp.nix switch
    elif [[ $monitors == *"eDP"* ]]; then
      echo "Switching to HM config for eDP or eDP-1 (laptop display)"
      home-manager -f ${config.xdg.configHome}/nixpkgs/display/edp.nix switch
    else
      echo "Could not detect monitor: $monitors"
      exit 1
    fi
  ''