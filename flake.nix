{
  description = "A Nix-flake-based Python development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [ python312 ] ++
          (with pkgs.python312Packages; [ 
            pandas 
            requests 
            polars
            duckdb
          ]);
          shellHook = ''
            export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc.lib pkgs.python312 ]}:$LD_LIBRARY_PATH"
            # Optionally start nushell, uncomment the next line if needed:
            exec ${pkgs.nushell}/bin/nu
          '';
        };
      }
    );
}
