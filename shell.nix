# shell.nix
let
  pkgs = import <nixpkgs> {};

  python = pkgs.python3.override {
    self = python;
    packageOverrides = pyfinal: pyprev: {
      toolz = pyfinal.callPackage ./toolz.nix { };
      polars = pyfinal.callPackage ./polars.nix { };
      prefect = pyfinal.callPackage ./prefect.nix { };
    };
  };

in pkgs.mkShell {
  packages = [
    (python.withPackages (python-pkgs: [
      # select Python packages here
      python-pkgs.pandas
      python-pkgs.requests
      python-pkgs.toolz
#      python-pkgs.prefect
      python-pkgs.polars
    ]))
  ];
}
