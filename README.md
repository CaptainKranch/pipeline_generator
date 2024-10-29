# Usage as a flake

[![FlakeHub](https://img.shields.io/endpoint?url=https://flakehub.com/f/CaptainKranch/pipeline_generator/badge)](https://flakehub.com/flake/CaptainKranch/pipeline_generator)

Add pipeline_generator to your `flake.nix`:

```nix
{
  inputs.pipeline_generator.url = "https://flakehub.com/f/CaptainKranch/pipeline_generator/*.tar.gz";

  outputs = { self, pipeline_generator }: {
    # Use in your outputs
  };
}

```
