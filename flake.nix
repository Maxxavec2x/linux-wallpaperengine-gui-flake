# flake to use linux-wallpaperengine-gui
# see https://nixos.org/manual/nixpkgs/stable/#sec-pkgs-appimageTools
{
  description = "linux-wallpaperengine-gui, packaged from the upstream prebuilt AppImage";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        pname = "linux-wallpaperengine-gui";
        version = "0.5.2";

        src = pkgs.fetchurl {
          url = "https://github.com/AzPepoze/linux-wallpaperengine-gui/releases/download/v${version}/linux-wallpaperengine-gui.AppImage";
          sha256 = "sha256-UKURQDPH07WB/QlyFNOI6SEjPCP63Hg9a35pu48UPSM=";
        };

        package = pkgs.appimageTools.wrapType2 {
          inherit pname version src;

          extraPkgs =
            pkgs': with pkgs'; [
              at-spi2-atk
              at-spi2-core
              cairo
              cups
              dbus
              expat
              gtk3
              libdrm
              libglvnd
              libnotify
              libxkbcommon
              mesa
              nss
              nspr
              pango
              alsa-lib
              udev
              libX11
              libXcomposite
              libXdamage
              libXext
              libXfixes
              libXrandr
              libxcb
              libXtst
              libayatana-appindicator
            ];

          meta = with pkgs.lib; {
            description = "GUI for Almamu/linux-wallpaperengine (Go backend + Electron frontend)";
            homepage = "https://github.com/AzPepoze/linux-wallpaperengine-gui";
            license = licenses.gpl3Only;
            platforms = [ "x86_64-linux" ];
            mainProgram = pname;
          };
        };
      in
      {
        packages.default = package;
        packages.${pname} = package;

        apps.default = {
          type = "app";
          program = "${package}/bin/${pname}";
        };
      }
    );
}
