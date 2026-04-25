# overlays/kitty-master.nix
{ kitty-src }:
(final: prev: {
kitty = prev.kitty.overrideAttrs (old: {
  src = kitty-src;
  version = "0-unstable";
  goModules =
    (prev.buildGo126Module {
      pname = "kitty-go-modules";
      version = "0-unstable";
      src = kitty-src;
      vendorHash = "sha256-Df/9ALU6Az/F5xGZx7BSPKYLwqELv3NDWuZETHCJGlc=";
    }).goModules;
  preBuild = (old.preBuild or "") + ''
    export GOTOOLCHAIN=local
  '';
  doCheck = false;
doInstallCheck = false;
});})

