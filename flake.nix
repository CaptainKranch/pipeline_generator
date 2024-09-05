{
  description = "A Nix-flake-based Python development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        python = pkgs.python312;
        pythonPackages = pkgs.python312Packages;

        # Define the local library
        #myLocalLib = pkgs.callPackage ./src/clients {};
      in
      {
        devShells.default = pkgs.mkShell {
          #packages = with pkgs; [ python, myLocalLib ] ++
          packages = with pkgs; [ python ruff google-cloud-sdk ] ++ (with pythonPackages; [
            pandas 
            requests 
            polars
            duckdb
            virtualenv
            openpyxl
            google-cloud-storage
            google-cloud-bigquery
            google-cloud-secret-manager
            azure-storage-blob
          ]);
          shellHook = ''
            export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc.lib python ]}:$LD_LIBRARY_PATH"
            export PYTHONUNBUFFERED=1
            export PIP_NO_PYTHON_VERSION_WARNING=1
            export PIP_DISABLE_PIP_VERSION_CHECK=1

            if [ ! -d ".venv" ]; then
              echo "Creating a virtual environment..."
              ${pythonPackages.virtualenv}/bin/virtualenv .venv
            fi

            echo "Activating virtual environment..."
            source .venv/bin/activate

            if ! pip list | grep -q prefect; then
              echo "Installing prefect..."
              pip install prefect 2>&1 | cat  # Redirect output to handle broken pipe
            else
              echo "Prefect is already installed."
            fi
            exec ${pkgs.nushell}/bin/nu
          '';
        };
      }
    );
}
