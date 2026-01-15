{ pkgs, ... }:
{
    programs.plasma.configFile."klassy/klassyrc" = {
        "Windeco" = {
            "ButtonIconStyle" = "StyleFluent";
        };
    };
}
