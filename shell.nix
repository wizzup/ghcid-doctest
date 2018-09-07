{ pkgs ? import <nixpkgs> {}}:

with pkgs;
with pkgs.haskellPackages;

let
  drv = mkDerivation {
    pname = "haskell-project";
    version = "0.0.1";
    src = ./.;
    license = stdenv.lib.licenses.bsd3;

    extraLibraries = [
      cabal-install
      doctest
      ghcid
    ];

    shellHook = ''
      export PS1="\[\033[1;32m\][λ= \W]\n$ \[\033[0m\]"
    '';
  };

in
  if pkgs.lib.inNixShell then drv.env else drv
