{
  description = ''Nim bindings for libshout'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."nshout-master".dir   = "master";
  inputs."nshout-master".owner = "nim-nix-pkgs";
  inputs."nshout-master".ref   = "master";
  inputs."nshout-master".repo  = "nshout";
  inputs."nshout-master".type  = "github";
  inputs."nshout-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nshout-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}