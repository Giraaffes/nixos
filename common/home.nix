{ pkgs, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-qt5-1.1.10"
  ];

  home-manager.users.marcus = {
    imports = [ ./plasma.nix ];

    programs.bash.enable = true;
    programs.git.enable = true;
    programs.git.settings.user = {
      name = "Marcus Færk Henriksen";
      email = "marcusfaerk@gmail.com";
    };
    programs.git.ignores = [
      "/.local/**"
      "local.*"
      "/seafile-ignore.txt"
    ];
    programs.gh.enable = true;

    home.packages = with pkgs; [
      firefox slack # Default applications
      vscode nodejs pnpm dbeaver-bin postgresql # Dev environment
      prisma-engines_7 openssl # For Prisma
      gimp2 jq # Others

      ventoy-full-qt # For Nix .iso installer
    ];

    home.sessionVariables = {
      PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines_7}/bin/schema-engine";
      PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines_7}/bin/query-engine";
      PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines_7}/lib/libquery_engine.node";
      PRISMA_FMT_BINARY = "${pkgs.prisma-engines_7}/bin/prisma-fmt";
      LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [ pkgs.openssl ]}";
    };

    xdg.desktopEntries.code-url-handler = {
      name = "Visual Studio Code - URL Handler";
      comment = "Code Editing. Redefined.";
      exec = "code --open-url %U";
      mimeType = [ "x-scheme-handler/vscode" ];
      noDisplay = true;
      icon = "vscode";
    };

    home.stateVersion = "25.11";
  };
}
