{
  description = "Example flake with a devShell";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = { self, nixpkgs}:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.x86_64-linux.default = pkgs.mkShell rec {
        name ="Odin";
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath packages;
        nativeBuildInputs = with pkgs; [
          git
          which
          clang_20
          llvmPackages_20.llvm
          llvmPackages_20.bintools
          pkg-config
        ];
        packages = with pkgs; [
          libGL
          xorg.libX11
          xorg.libX11.dev
          SDL2
          SDL
          SDL2_mixer
          glfw
          xorg.libXinerama
          xorg.libXi
          xorg.libXft
        ];
        shellHook = ''
          echo "You're in a devshell"
        '';
      };
    };
}
