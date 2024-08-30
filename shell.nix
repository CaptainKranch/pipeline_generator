{ pkgs ? import <nixpkgs> { overlays = [ (import ./python-overlay.nix) ]; } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.python312
    pkgs.python312Packages.pandas
  ];

  # Polars is not available in nixpkgs as of the last update; you may need to install it via pip
  shellHook = ''
    exec ${pkgs.nushell}/bin/nu
  '';
}
