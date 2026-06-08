{
  flake.modules.homeManager.packages =
    {
      lib,
      pkgs,
      ...
    }:
    {
      home.packages =
        with pkgs;
        [
          # awscli2   # tool to manage AWS services
          # brave
          google-chrome
          ncdu
          dfc
          evil-helix
          # dig  # domain name server?
          eza
          fd     # fast find alternative
          jq     # json processor
          nh     # nix helper
          nodejs
          # openconnect   # vpn client for cisco anyconnect
          # opentofu      # drop in replacement for terraform???
          # pipenv        # python devel workflow
          # podman-compose  # docker compose with podman backend
          # podman-tui      #
          python3
          ripgrep
          # telegram-desktop
        ]
        ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
          # anki-bin
          # colima  # container runtimes
          hidden-bar
          # mos  # smoth scrolling on macOS
          # podman
          raycast
        ]
        ++ lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) [
          # anki   # repetition of flashcards, Lernprogramm
          #
          gcc
          gnumake
          killall
          tesseract  # OCR engine
          unzip
          wl-clipboard
          emacs-pgtk
        ];
    };
}
