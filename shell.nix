{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell rec {
  buildInputs = [
    pkgs.poetry
    pkgs.zlib
    pkgs.gcc  # Often required for building Python packages with native extensions
  ];

  shellHook = ''
    # Setup the library path for dynamic linking
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath buildInputs}:$LD_LIBRARY_PATH"
    export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib.outPath}/lib:$LD_LIBRARY_PATH"

    # Check if the virtual environment exists, if not, use poetry to create it and install dependencies
    if [ ! -d ".venv" ]; then
      echo "Creating virtual environment and installing dependencies..."
      poetry init -n
      poetry add polars
    fi

    # Activate the poetry managed virtual environment
    . .venv/bin/activate

    # Optionally, you can run initial project-specific commands here
    # echo "Running initial project setup scripts..."

    # Start Nu shell
    exec ${pkgs.nushell}/bin/nu
  '';
}
