{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
      inputs.hyprland.homeManagerModules.default
  ];
  wayland.windowManager.hyprland = let
      mod = "SUPER"; in
    {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = null;
    settings = {
      monitor = [", highres, auto, 1.0"];
      exec-once = [
        "clipse -listen"
        "systemctl --user start hyprpolkitagent.service"
        "kitty +kitten panel ~/bar.sh"
      ];
      env = [
      "XCURSOR_SIZE,32"               
      "HYPRCURSOR_SIZE,32"          
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"    
      "XDG_SESSION_DESKTOP,Hyprland"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = 2;
        "col.active_border" = "rgba(C6C5D0aa) rgba(90909Aaa) 45deg";
        "col.inactive_border" = "rgba(595959aa)"; 
        # col = [
        #   "active_border = rgba(C6C5D0aa) rgba(90909Aaa) 45deg"
        #   "inactive_border = rgba(595959aa)"
        # ];

        resize_on_border = false;

        allow_tearing = false;

        layout = "dwindle";
      };

      decoration = {
        rounding = 5;

        active_opacity = 1.0;
        inactive_opacity = 0.8;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      
      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
         "windows, 1, 7, myBezier"                       
         "windowsOut, 1, 7, default, popin 80%"
         "border, 1, 10, default"
         "borderangle, 1, 8, default"
         "fade, 1, 7, default"
         "workspaces, 1, 6, default"
         "specialWorkspaceIn, 1, 6, myBezier, slide top" 
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = false;
          clickfinger_behavior = true;
        }; 
      };
      
      device = [
        {
        name = "tpps/2-elan-trackpoint";
        accel_profile = "flat";
        sensitivity = -0.2;
        }
      ];

      gesture = [
        "3, horizontal, workspace"
        "3, down, special, magic"
      ];

      bind = let
        # mod = "SUPER";
        terminal = "kitty";
        fileManager = "kitty --class yazi -e yazi";
        menu = "rofi -show drun";
        clipboard = "kitty --class clipse -e clipse";
        snipRegion = "hyprshot -m region --clipboard-only --freeze";
        snipScreen = "hyprshot -m output --clipboard-only";
        lock = "loginctl lock-session";

        workspaceBinds = builtins.concatLists (map (n: let
          key = if n == 10 then "0" else toString n;
        in [
          "${mod}, ${key}, workspace, ${toString n}"
          "${mod} SHIFT, ${key}, movetoworkspace, ${toString n}"
        ]) (lib.range 1 10));

        modBinds = [
        "Q, exec, ${terminal}"
        "C, killactive,"
        "M, exit,"
        "E, exec, ${fileManager}"
        "V, exec, ${clipboard}"
        "F, togglefloating,"
        "R, exec, ${menu}"
        "P, pseudo,"
        "J, togglesplit,"
        "L, exec, ${lock}"
        "S, togglespecialworkspace, magic"

        "left, movefocus, l"
        "right, movefocus, r"
        "up, movefocus, u"
        "down, movefocus, d"
        ];
      in [
        "SHIFT, Print, exec, ${snipRegion}"
        ", Print, exec, ${snipScreen}"

        "${mod} SHIFT, S, movetoworkspace, special:magic"
        " , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ]
        ++ map (b: "${mod}, ${b}") modBinds
        ++ workspaceBinds;

      bindm = [
        "${mod}, mouse:272, movewindow"
        "${mod}, mouse:273, resizewindow"
      ];

      binde = [
        " , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        " , XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
        " , XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        " , XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      ];

      windowrule = [
        
        "match:class ^(*), suppress_event maximize"
        
        {
          name = "firefox-pip";
          "match:title" = "^(Picture-in-Picture|Firefox)$";
          float = "on";
          pin = "on";
        }
        {
          name = "clipse";
          "match:class" = "^(clipse)$";
          float = "on";
          center = "on";
          size = "622 652";
        }
        {
          name = "yazi";
          "match:class" = "^(yazi)$";
          float = "on";
          center = "on";
          size = "800 600";
        }
      ];
    };

    # extraConfig = ''
    #   ${builtins.readFile ../hypr/hyprland.conf}
    # '';
    # extraConfig = ''   
    #   windowrule = match:class ^(*), suppress_event maximize # You'll probably like this.
    #
    #   windowrule {
    #       name = firefox-pip
    #       match:title = ^(Picture-in-Picture|Firefox)$
    #       float = on
    #       pin = on
    #   }
    #
    #   windowrule {
    #       name = clipse
    #       match:class = ^(clipse)$
    #       float = on
    #       center = on
    #       size = 622 652
    #   }
    #
    #   windowrule {
    #       name = yazi
    #       match:class = ^(yazi)$
    #       float = on
    #       center = on
    #       size = 800 600
    #   }
    # '';
  };
}
