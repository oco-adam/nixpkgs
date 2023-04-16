{ lib, pkgs, ... }:

{
  # Bat, a substitute for cat.
  # https://github.com/sharkdp/bat
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.bat.enable
  programs.bat.enable = true;
  programs.bat.config = {
    style = "plain";
  };

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  # SSH
  # https://nix-community.github.io/home-manager/options.html#opt-programs.ssh.enable
  # Some options also set in `../darwin/homebrew.nix`.
  programs.ssh.enable = true;
  programs.ssh.controlPath = "~/.ssh/%C"; # ensures the path is unique but also fixed length

  # Zoxide, a faster way to navigate the filesystem
  # https://github.com/ajeetdsouza/zoxide
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zoxide.enable
  programs.zoxide.enable = true;

  home.packages = lib.attrValues ({
    # Some basics
    inherit (pkgs)
      abduco # lightweight session management
      bandwhich # display current network utilization by process
      bottom # fancy version of `top` with ASCII graphs
      browsh # in terminal browser
      coreutils
      curl
      du-dust # fancy version of `du`
      exa # fancy version of `ls`
      fd # fancy version of `find`
      htop # fancy version of `top`
      hyperfine # benchmarking tool
      inetutils # e.g. for telnet
      mosh # wrapper for `ssh` that better and not dropping connections
      ngrok # expose local servers to the internet
      parallel # runs commands in parallel
      rclone
      ripgrep # better version of `grep`
      tealdeer # rust implementation of `tldr`
      thefuck
      unrar # extract RAR archives
      upterm # secure terminal sharing
      wget
      xz # extract XZ archives
    ;

    # elixir
    elixir = pkgs.beam.packages.erlangR25.elixir_1_14;
    elixir-ls = pkgs.beam.packages.erlang.elixir_ls;
    paket = pkgs.dotnetPackages.Paket;

    # Dev stuff
    inherit (pkgs)
      azure-cli
      cloc # source code line counter
      cargo # rust packages manager (used for lunarvim)
      gnumake
      google-cloud-sdk
      helix # Interesting Kakoune-based modal editor
      # idris2
      ihp-new # start new IHP (Intergrated Haskell Platform) projects
      jq
      nodejs
      s3cmd
      stack
      typescript
      yarn
    ;
    inherit (pkgs.haskellPackages)
      cabal-install
      hoogle
      hpack
      implicit-hie
    ;
    agda = pkgs.agda.withPackages (ps: [ ps.standard-library ]);
    python = pkgs.python38.withPackages(ps: with ps; [ pip ]);

    # Useful nix related tools
    inherit (pkgs)
      cachix # adding/managing alternative binary caches hosted by Cachix
      comma # run software from without installing it
      devenv # tool for managing development environments
      # niv # easy dependency management for nix projects
      nix-output-monitor # get additional information while building packages
      nix-tree # interactively browse dependency graphs of Nix derivations
      nix-update # swiss-knife for updating nix packages
      nixpkgs-review # review pull-requests on nixpkgs
      node2nix # generate Nix expressions to build NPM packages
      statix # lints and suggestions for the Nix programming language
    ;

  } // lib.optionalAttrs pkgs.stdenv.isDarwin {
    inherit (pkgs)
      cocoapods
      m-cli # useful macOS CLI commands
      prefmanager # tool for working with macOS defaults
    ;
  });
}
