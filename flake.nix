{
  description = "Example flake with a devShell";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = { self, nixpkgs}:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        name ="Odin";
        nativeBuildInputs = with pkgs; [
          git
          which
          clang_20
          llvmPackages_20.llvm
          llvmPackages_20.bintools
        ];
        packages = with pkgs; [
          libGL
          xorg.libX11
          SDL2
          SDL
          SDL2_mixer
          glfw
        ];
        shellHook = ''
          echo "You're in a devshell"
        '';
      };
    };
}
