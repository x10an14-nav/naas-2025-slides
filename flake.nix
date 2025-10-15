{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };
  outputs =
    inputs:
    let
      inherit (inputs.nixpkgs) lib;
      # Small tool to iterate over each systems
      eachSystem =
        f: lib.genAttrs [ "x86_64-linux" ] (system: f (import inputs.nixpkgs { inherit system; }));
      treefmtEval = eachSystem (pkgs: inputs.treefmt-nix.lib.evalModule pkgs { });
    in
    {
      devShells = eachSystem (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            marp-cli
            kdePackages.okular
            pdfpc
          ];
        };
      });
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
    };
}
