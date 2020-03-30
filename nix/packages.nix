let
  pkgs = import <nixpkgs> {};
  fixed = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/19.09.tar.gz") {};
in
(
  with fixed; [
    cachix # nix caching
    git # source version control
    kdiff3 # git diff
    nodejs # required by coc.nvim (autocompletion plugin)
    openjdk8 # Java development kit
    python3 # for vim plugins
    sbt # Scala build tool
  ]
) ++ (
  with pkgs; [
    bat # a better `cat`
    brave # web browser
    bloop # Scala build server
    exa # a better `ls`
    fd # "find" for files
    fzf # fuzzy find tool
    glow # markdown viewer
    htop # interactive processes viewer
    metals # Scala LSP server
    neovim # best text editor ever
    ngrok # secure tunnels to localhost
    niv # nix package manager
    nix # nix commands
    ripgrep # fast grep
    spotify # music source
    tmux # terminal multiplexer and sessions
    tree # display files in a tree view
  ]
) ++ (
  with pkgs.gitAndTools; [
    diff-so-fancy # git diff with colors
    tig # diff and commit view
  ]
) ++ (
  with pkgs.haskellPackages; [
    brittany # code formatter
    cabal2nix # convert cabal projects to nix
    cabal-install # package manager
    ghc # compiler
    hoogle # documentation
  ]
) ++ (
  with pkgs.python3Packages; [
    pynvim # for vim plugins that require python
  ]
) ++ (
  with pkgs.nodePackages; [
    node2nix # to convert node packages
  ]
)