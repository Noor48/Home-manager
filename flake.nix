{
  description = "Combined Home Manager and System Manager configuration for nooremf";
  inputs = {
    # Core inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # System Manager
    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Additional inputs
    catppuccin.url = "github:catppuccin/nix";
    nixgl.url = "github:nix-community/nixGL";
    stylix.url = "github:nix-community/stylix";
    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nur.url = "github:nix-community/NUR";
  };
  outputs = { self, nixpkgs, home-manager, system-manager, catppuccin, nixgl, stylix, nix-system-graphics, chaotic, nur, ... }@ inputs:
    let
      system = "x86_64-linux";

      # Custom overlay for GitHub packages with nixgl support
      githubPackagesOverlay = final: prev: {
        # Zen Browser from your derivation
        zen-browser-bin = prev.callPackage ./zen-browser.nix {};

        # Zen Browser with nixgl wrapper
        zen-browser = prev.writeShellScriptBin "zen-browser" ''
          exec ${prev.nixgl.nixGLIntel}/bin/nixGLIntel ${final.zen-browser-bin}/bin/zen-browser "$@"
        '';
      };

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          nixgl.overlay
          nur.overlays.default
          githubPackagesOverlay
        ];
      };
    in {
      # Expose custom packages for use in other configurations
      packages.${system} = {
        zen-browser = pkgs.zen-browser;
        zen-browser-bin = pkgs.zen-browser-bin;
      };

      # Home Manager configuration
      homeConfigurations."nooremf" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          catppuccin.homeModules.catppuccin
          stylix.homeModules.stylix
          chaotic.homeManagerModules.default
        ];
        # Pass additional arguments to home.nix
        extraSpecialArgs = {
          inherit nixgl nur;
          # Make zen-browser available in home.nix
          githubPackages = {
            zen-browser = pkgs.zen-browser;
          };
        };
      };

      # System Manager configuration
      systemConfigs.default = system-manager.lib.makeSystemConfig {
        modules = [
          nix-system-graphics.systemModules.default
          ({
            config = {
              nixpkgs.hostPlatform = system;
              system-manager.allowAnyDistro = true;
              system-graphics.enable = true;
            };
          })
        ];
      };

      # Development shell with helper tools
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nix-prefetch-url
        ];
        shellHook = ''
          echo "Zen Browser Development Shell"
          echo "Available packages:"
          echo "  zen-browser     - Zen Browser with nixGL wrapper"
          echo "  zen-browser-bin - Raw Zen Browser binary"
        '';
      };
    };
}
