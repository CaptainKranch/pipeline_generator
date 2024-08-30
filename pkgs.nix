self: super:

{
  python312Packages = super.python39Packages // {
    polars = super.python312Packages.buildPythonPackage rec {
      pname = "polars";
      version = "1.6.0";  # Specify the version you need

      src = super.fetchPypi {
        inherit pname version;
        sha256 = "1xyzabc...";  # You need to replace this with the correct hash
      };

      propagatedBuildInputs = with super.python39Packages; [ numpy ];
    };
  };
}
