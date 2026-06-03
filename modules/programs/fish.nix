{
  flake.modules.nixos.fish =
    { config, pkgs, ... }:
    {
      programs.fish.enable = true;
      # users.users.${config.primaryUser}.shell = pkgs.fish;
    };

  flake.modules.darwin.fish = {
    programs.fish.enable = true;
  };

  flake.modules.homeManager.fish =
    {
      lib,
      pkgs,
      ...
    }:
    {
      programs.fish = {
        enable = true;
        shellAliases = {
          ff = "fastfetch";

          # git
          gaa = "git add --all";
          gcam = "git commit --all --message";
          gcl = "git clone";
          gco = "git checkout";
          ggl = "git pull";
          ggp = "git push";
          gst = "git status";

          lg = "lazygit";


          ls = "eza --icons always"; # default view
          ll = "eza -bhl --icons --group-directories-first"; # long list
          la = "eza -abhl --icons --group-directories-first"; # all list
          lt = "eza --tree --level=2 --icons"; # tree
        }
        // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
          open = "xdg-open";   # TODO study
        };
        # initContent = ''
        #   # bindings
        #   bindkey -e
        #   bindkey '^H' backward-delete-word
        #   bindkey '^[[1;5C' forward-word
        #   bindkey '^[[1;5D' backward-word

        #   # open commands in $EDITOR with C-v
        #   autoload -z edit-command-line
        #   zle -N edit-command-line
        #   bindkey "^v" edit-command-line

        #   ${lib.optionalString pkgs.stdenv.hostPlatform.isDarwin ''
        #     # Enable ALT-C fzf keybinding on Mac
        #     bindkey 'ć' fzf-cd-widget
        #   ''}
        # '';
      };
    };
}
