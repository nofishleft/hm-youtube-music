{
    description = "";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    outputs = {
        self, ...
    }:
    {
        homeManagerModules.default =  self.homeManagerModules.youtube-music;
        homeManagerModules.youtube-music =  import ./hm-module.nix self;
    };
}
