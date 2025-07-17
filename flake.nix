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
    # Flatpak integration
    nix-flatpak.url = "github:gmodena/nix-flatpak";
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
  outputs = { self, nixpkgs, home-manager, system-manager, catppuccin, nixgl, stylix, nix-system-graphics, chaotic, nur, nix-flatpak, ... }@ inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          nixgl.overlay
          nur.overlays.default
        ];
      };
    in {
      # Home Manager configuration
      homeConfigurations."nooremf" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          catppuccin.homeModules.catppuccin
          stylix.homeModules.stylix
          chaotic.homeManagerModules.default
          nix-flatpak.homeManagerModules.nix-flatpak
        ];
        # Pass nixgl to home.nix
        extraSpecialArgs = { inherit nixgl nur; };
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
    };
}
