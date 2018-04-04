{ pkgs ? (import <nixpkgs> {})}:
let gems = pkgs.bundlerEnv {
      name = "static-website-gems";
      ruby = pkgs.ruby;
      gemfile = ./Gemfile;
      lockfile = ./Gemfile.lock;
      gemset = ./gemset.nix;
    };
in
pkgs.stdenv.mkDerivation {
  name = "www.philandstuff.com";
  buildInputs = [gems];
}
