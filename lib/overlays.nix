{ inputs, system }:

with inputs;

let
  cowsayOverlay = f: p: {
    inherit (inputs.cowsay.packages.${system}) cowsay;
  };

  fishOverlay = f: p: {
    inherit fish-bobthefish-theme fish-keytool-completions;
  };

  metalsOverlay = f: p: {
    metals = p.callPackage ../home/programs/neovim-ide/metals.nix { };
    metals-updater = p.callPackage ../home/programs/neovim-ide/update-metals.nix { };
  };

  libOverlay = f: p: rec {
    libx = import ./. { inherit (p) lib; };
    lib = p.lib.extend (_: _: {
      inherit (libx) removeNewline secretManager;
    });
  };

  sxmOverlay =
    if (builtins.hasAttr "sxm-flake" inputs)
    then sxm-flake.overlays.default
    else (f: p: { });
in
[
  cowsayOverlay
  fishOverlay
  libOverlay
  metalsOverlay
  nurpkgs.overlay
  neovim-flake.overlays.${system}.default
  statix.overlays.default
  sxmOverlay
  (import ../home/overlays/bat-lvl)
  (import ../home/overlays/bazecor)
  (import ../home/overlays/juno-theme)
  (import ../home/overlays/ranger)
]
