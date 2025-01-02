self: {
    pkgs,
    config,
    lib,
    ...
}:
let

    cfg = config.programs.youtube-music;

in {
    options.programs.youtube-music = {
        enable = lib.mkEnableOption "youtube-music";
        settings = {
            tray = lib.mkEnableOption "tray";
            autoUpdates = lib.mkEnableOption "autoUpdates";
            disableHardwareAcceleration = lib.mkEnableOption "disableHardwareAcceleration";
        };
        themes = lib.mkOption {
            description = "";
            type = with lib.types; listOf lines;
            default = [];
        };
        plugins = lib.mkOption {
            description = "";
            type = with lib.types; attrsOf inferred;
            default = {};
        };
        extraConfig = lib.mkOption {
            description = "";
            type = with lib.types; attrsOf inferred;
            default = {};
        };
        package = lib.mkPackageOption pkgs "youtube-music" { };
    };

    config = lib.mkIf cfg.enable {
        home.packages = lib.concatLists [
            (lib.optional (cfg.package != null) cfg.package)
        ];
        home.file = {
            target = ".config/Youtube Music/config.json";
            text = builtins.toJSON (
                {
                    options = cfg.settings // {
                        themes = cfg.themes;
                    };
                    plugins = cfg.plugins;
                } // cfg.extraConfig
            );
        };
    };
}
