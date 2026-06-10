{
  flake.modules.generic.profile =
    {
      lib,
      pkgs,
      ...
    }:
    {
      options.profile = lib.mkOption {
        readOnly = true;
        type = lib.types.submodule {
          options = {
            email = lib.mkOption { type = lib.types.str; };
            fullName = lib.mkOption { type = lib.types.str; };
            gitKey = lib.mkOption { type = lib.types.str; };
            avatar = lib.mkOption { type = lib.types.path; };
            wallpaper = lib.mkOption { type = lib.types.path; };

            appearance = lib.mkOption {
              type = lib.types.submodule {
                options = {
                  catppuccin = lib.mkOption {
                    type = lib.types.submodule {
                      options = {
                        flavor = lib.mkOption { type = lib.types.str; };
                        accent = lib.mkOption { type = lib.types.str; };
                      };
                    };
                  };

                  iconTheme = lib.mkOption {
                    type = lib.types.submodule {
                      options = {
                        name = lib.mkOption { type = lib.types.str; };
                        package = lib.mkOption { type = lib.types.package; };
                      };
                    };
                  };

                  cursorTheme = lib.mkOption {
                    type = lib.types.submodule {
                      options = {
                        name = lib.mkOption { type = lib.types.str; };
                        package = lib.mkOption { type = lib.types.package; };
                        size = lib.mkOption { type = lib.types.int; };
                      };
                    };
                  };

                  fonts = lib.mkOption {
                    type = lib.types.submodule {
                      options = {
                        ui = lib.mkOption {
                          type = lib.types.submodule {
                            options = {
                              family = lib.mkOption { type = lib.types.str; };
                              size = lib.mkOption { type = lib.types.int; };
                              package = lib.mkOption { type = lib.types.package; };
                            };
                          };
                        };

                        monospace = lib.mkOption {
                          type = lib.types.submodule {
                            options = {
                              family = lib.mkOption { type = lib.types.str; };
                              package = lib.mkOption { type = lib.types.package; };
                              size = lib.mkOption { type = lib.types.int; };
                            };
                          };
                        };

                        terminal = lib.mkOption {
                          type = lib.types.submodule {
                            options = {
                              family = lib.mkOption { type = lib.types.str; };
                              package = lib.mkOption { type = lib.types.package; };
                              size = lib.mkOption {
                                type = lib.types.submodule {
                                  options = {
                                    linux = lib.mkOption { type = lib.types.int; };
                                    darwin = lib.mkOption { type = lib.types.int; };
                                  };
                                };
                              };
                            };
                          };
                        };
                      };
                    };
                  };
                };
              };
            };

            locale = lib.mkOption {
              type = lib.types.submodule {
                options = {
                  timezone = lib.mkOption { type = lib.types.str; };
                  default = lib.mkOption { type = lib.types.str; };
                  extra = lib.mkOption { type = lib.types.attrsOf lib.types.str; };
                };
              };
            };
          };
        };
      };

      config.profile = {
        email = "trikl@online.de";
        fullName = "Th. Rikl";
        # to sign git commits --> programs.git.signing.key
        gitKey = "sOgflPjIb0fndlY3cblNWLDd5jmwy/39y9TJgJ0AlKM"; # "C5810093";
        # output of: ssh-keygen -lf ...tom1_achse...
        avatar = ./avatar;
        wallpaper = ./wallpaper.jpg;

        # "catppuccin" is a theming framework like "stylix"
        # they contain colorthemes for many apps, desktop-utilities etc.
        appearance = {
          catppuccin = {
            # Type one of: "latte", "frappe", "macchiato", "mocha"
            flavor = "mocha";

            # Type accent one of:
            #  "blue", "flamingo", "green", "lavender", "maroon", "mauve", "peach", "pink",
            #  "red", "rosewater", "sapphire", "sky", "teal", "yellow"
            accent = "lavender";
          };

          iconTheme = {
            name = "Colloid-Catppuccin-Dark";
            package = pkgs.colloid-icon-theme.override {
              schemeVariants = [ "catppuccin" ];
            };
          };

          cursorTheme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme;
            size = 24;
          };

          fonts = {
            ui = {
              family = "Inter";
              size = 11;
              package = pkgs.inter;
            };

            monospace = {
              family = "JetBrainsMono Nerd Font Mono";
              package = pkgs.nerd-fonts.jetbrains-mono;
              size = 11;
            };

            terminal = {
              family = "MesloLGS Nerd Font";
              package = pkgs.nerd-fonts.meslo-lg;
              size = {
                linux = 12;
                darwin = 15;
              };
            };
          };
        };

        locale = {
          timezone = "Europe/Berlin";
          default = "de_DE.UTF-8";
          extra = {
            LC_ADDRESS = "de_DE.UTF-8";
            LC_IDENTIFICATION = "de_DE.UTF-8";
            LC_MEASUREMENT = "de_DE.UTF-8";
            LC_MONETARY = "de_DE.UTF-8";
            LC_NAME = "de_DE.UTF-8";
            LC_NUMERIC = "de_DE.UTF-8";
            LC_PAPER = "de_DE.UTF-8";
            LC_TELEPHONE = "de_DE.UTF-8";
            LC_TIME = "de_DE.UTF-8";
          };
        };
      };
    };
}
