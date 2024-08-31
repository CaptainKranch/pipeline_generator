let
  pkgs = import <nixpkgs> {};

  python = pkgs.python3.override {
    self = python;
    packageOverrides = pyfinal: pyprev: {
#      toolz = pyfinal.callPackage ./toolz.nix { };
#      prefect = pyfinal.callPackage ./pkgs/prefect/prefect.nix { };
    };
  };

in pkgs.mkShell {
  packages = [
    (python.withPackages (python-pkgs: [
      # select Python packages here
      python-pkgs.pandas
      python-pkgs.requests
#      python-pkgs.toolz
      python-pkgs.polars
      python-pkgs.duckdb
#      python-pkgs.prefect
    ]))
  ];
}
