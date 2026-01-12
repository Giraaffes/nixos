{ pkgs, ... }:
{
    home.packages = [
        pkgs.nur.repos.shadowrz.klassy-qt6
    ];

    programs.plasma.enable = true;

    programs.plasma.workspace = {
        colorScheme = "KlassyLight";
        theme = "breeze-dark";
        windowDecorations.library = "org.kde.klassy";
        windowDecorations.theme = "Klassy";
        cursor.theme = "Breeze_Light";
    };

    programs.plasma.configFile."klassy/klassyrc" = {
        "Windeco" = {
            "ButtonIconStyle" = "StyleFluent";
        };
    };
}
