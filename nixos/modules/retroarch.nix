{pkgs, ...}: let
  retroarchWithCores = pkgs.retroarch.withCores (cores:
    with cores; [
      swanstation
      snes9x
      pcsx2
      play
      dolphin
    ]);
in {
  environment.systemPackages = [
    retroarchWithCores
  ];
}
