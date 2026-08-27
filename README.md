A flake that package https://github.com/AzPepoze/linux-wallpaperengine-gui

To test it, run `nix run github:Maxxavec2x/linux-wallpaperengine-gui-flake`  
If you want to include it in your nixos configuration, add:
```nix
inputs.linux-wallpaperengine-gui.url = "github:Maxxavec2x/linux-wallpaperengine-gui-flake";

environment.systemPackages = [ inputs.linux-wallpaperengine-gui.packages.${pkgs.system}.default ];
```
