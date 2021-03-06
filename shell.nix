{
  pkgs ? import (fetchGit {
    url = https://github.com/NixOS/nixpkgs-channels;
    ref = "nixos-20.03";
  }) {},
  ruby ? pkgs.ruby_2_7,
  bundler ? pkgs.bundler.override { inherit ruby; }
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    git
    ruby
    bundler
  ];

  shellHook = ''
    mkdir -p .local-data/gems
    export GEM_HOME=$PWD/.local-data/gems
    export GEM_PATH=$GEM_HOME
    export PATH="$GEM_PATH/bin:$PATH"
  '';
}
