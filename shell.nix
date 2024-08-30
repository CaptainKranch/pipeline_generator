{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.python312
    pkgs.python312Packages.pandas
  ];

  # Polars is not available in nixpkgs as of the last update; you may need to install it via pip
  shellHook = ''
    echo "Creating a Python virtual environment"
    PYTHONUSERBASE=$(pwd)/.venv pyvenv cfg
    export PYTHONPATH=$(pwd)/.venv/lib/python3.12/site-packages:$PYTHONPATH
    export PATH=$(pwd)/.venv/bin:$PATH

    echo "Installing Polars via pip"
    python pip install --upgrade pip
    python -m pip install polars prefect

    echo "Activating nushell"
    exec ${pkgs.nushell}/bin/nu
  '';
}
