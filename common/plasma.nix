{ pkgs, ... }:
{
  imports = [
    ./klassy.nix
  ];

  home.packages = [
    pkgs.nur.repos.shadowrz.klassy-qt6
  ];

  programs.plasma.enable = true;
  programs.plasma.overrideConfig = true;

  programs.plasma.workspace = {
    colorScheme = "KlassyLight";
    theme = "breeze-dark";
    windowDecorations.library = "org.kde.klassy";
    windowDecorations.theme = "Klassy";
    cursor.theme = "Breeze_Light";
  };

  # Disables top left corner action
  programs.plasma.configFile."kwinrc" = {
    "Effect-overview" = {
      "BorderActivate" = "9";
    };
  };

  programs.plasma.panels = [
    {
      location = "bottom";
      floating = false;

      widgets = [
        {
          name = "org.kde.plasma.kickoff";
          config = {
            General = {
              icon = "plasma-symbolic";
              highlightNewlyInstalledApps = false;
              primaryActions = 3;
              showActionButtonCaptions = false;
              systemFavorites = "lock-screen\\,logout\\,switch-user\\,suspend\\,reboot\\,shutdown";
            };
          };
        }
        {
          iconTasks = {
            launchers = [
              "applications:systemsettings.desktop"
              "applications:org.kde.plasma-systemmonitor.desktop"
              "applications:org.kde.dolphin.desktop"
              "applications:org.kde.konsole.desktop"
              "applications:firefox.desktop"
              "applications:code-url-handler.desktop"
            ];
          };
        }
        "org.kde.plasma.marginsseparator"
        {
          systemTray = {
            items = {
              # Extra apparently just means all that are enabled
              extra = [
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
                "org.kde.plasma.notifications"
                "org.kde.plasma.battery"
                "org.kde.plasma.clipboard"
                "org.kde.plasma.brightness"
                "org.kde.plasma.devicenotifier"
                "org.kde.kscreen"
                # Shown when relevant:
                "org.kde.plasma.cameraindicator"
              ];
              shown = [
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
                "org.kde.plasma.notifications"
                "org.kde.plasma.battery"
              ];
              hidden = [
                "org.kde.plasma.clipboard"
                "org.kde.plasma.brightness"
                "org.kde.plasma.devicenotifier"
                "org.kde.kscreen"
              ];
            };
          };
        }
        {
          digitalClock = {
            date = {
              enable = true;
              format = "shortDate";
            };
            time.format = "24h";
          };
        }
        "org.kde.plasma.minimizeall"
      ];
    }
  ];
}
