{ config, ... }:
let
  inherit (config.flake.modules) nixos homeManager;
in
{
  flake.modules.nixos.hyprland =
    { config, ... }:
    {
      imports = [ nixos.compositorCommon ];

      home-manager.sharedModules = [
        homeManager.compositorCommon
        homeManager.hyprland
      ];

      programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
      };

      # Hyprland's quirk under uwsm. Without it, the cursor in XWayland applications is inconsistent.
      # https://wiki.hypr.land/Configuring/Environment-variables/
      environment.sessionVariables = {
        XCURSOR_SIZE = config.profile.appearance.cursorTheme.size;
        XCURSOR_THEME = config.profile.appearance.cursorTheme.name;
      };
    };

    flake.modules.homeManager.hyprland =
      { lib, ... }:
      {
        wayland.windowManager.hyprland = {
          enable = true;
          package = null;
          portalPackage = null;
          configType = "lua";    # generates a .lua file
          # or "hyprlang" ... generates a .conf. Maybe deprecate in >0.55 versions
          systemd.enable = false;

          settings.config = {
            input = {
              kb_layout = "gb,de";   # "pl,ru"; # trikl;
              # kb_options = "grp:win_space_toggle";  # toggle kb_layout ... next language
              kb_options = "caps:super";   # make caps an additional SUPER
              # kb_options = "caps:hyper"; # make caps an additional HYPER
              # the "WIN" is generally interpreted as s or super in emacs
              repeat_delay = 250;
              repeat_rate = 40;

              follow_mouse = 1;
              mouse_refocus = false;

              touchpad.natural_scroll = true;

              sensitivity = 0;
              accel_profile = "flat";
            };

            cursor.no_warps = true;

            general = {
              border_size = 1;
              col = {
                active_border.colors = [ (lib.generators.mkLuaInline "colors.accent") ];
                inactive_border.colors = [ (lib.generators.mkLuaInline "colors.surface0") ];
              };
              gaps_in = 3;
              gaps_out = 6;
              layout = "master";
            };

            decoration = {
              rounding = 8;
              blur = {
                enabled = false;
                size = 3;
                passes = 1;
              };
              shadow = {
                enabled = false;
                range = 4;
                render_power = 3;
              };
            };

            render.direct_scanout = 1;

            animations.enabled = false;

            dwindle.preserve_split = true;

            master = {
              orientation = "left";
              mfact = 0.50;
            };

            misc = {
              force_default_wallpaper = 0;
              disable_hyprland_logo = true;
              disable_splash_rendering = true;
              vrr = 2;
            };
          };

          # extraConfig = builtins.readFile config/hyprland.lua;  # from discourse.nixos.org
          extraConfig = lib.strings.fileContents ./_hyprland.lua;

        };

        xdg = {
          desktopEntries = {
            quit-all-applications = {
              name = "Quit All Applications";
              exec = ''hyprctl eval "for _, w in ipairs(hl.get_windows()) do hl.dispatch(hl.dsp.window.close({ window = w })) end"'';
              icon = "system-log-out";
            };

            uuctl = {
              name = "uuctl";
              noDisplay = true;
            };
          };

          configFile = {
            "hypr/xdph.conf".text = ''
              screencopy {
              allow_token_by_default = true
              max_fps = 60
              }
            '';
          };
        };
      };
}
