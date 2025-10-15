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
      repoRoot = ./.;
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
      apps = eachSystem (pkgs: rec {
        default = pdf;
        html = {
          type = "app";
          program = "xdg-open ${inputs.self.packages.${pkgs.system}.html}";
        };
        pdf = {
          type = "app";
          program = "${lib.getExe pkgs.pdfpc} ${inputs.self.packages.${pkgs.system}.pdf}";
        };
      });
      packages = eachSystem (pkgs: rec {
        default = pdf;
        html =
          pkgs.runCommand "buildHTML"
            {
              buildInputs = with pkgs; [
                marp-cli
                firefox
              ];
            }
            # Bash
            ''marp --output $out ${repoRoot}/slides.md'';
        pdf =
          pkgs.runCommand "buildPDF"
            {
              buildInputs = with pkgs; [
                marp-cli
                firefox
              ];
            }
            (
              lib.concatStringsSep " " [
                "marp"
                "--debug=all"
                "--pdf-notes"
                "--pdf-outlines"
                "${repoRoot}/slides.md"
              ]
            );
      });
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
    };
}
