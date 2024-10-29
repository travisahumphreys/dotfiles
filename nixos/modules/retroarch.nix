{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (retroarch.override {
      cores = with libretro; [
        swanstation
        snes9x
        pcsx2
        dolphin
      ];
    })
  ];
}
