{ pkgs ? import <nixpkgs> {}}:

with pkgs;
with pkgs.haskellPackages;

let
  ghcid = mkDerivation {
    pname = "ghcid";
    version = "0.7.1";
    license = stdenv.lib.licenses.bsd3;

    src = fetchFromGitHub {
      owner = "ndmitchell";
      repo = "ghcid";
      rev = "v0.7.1";
      sha256 = "0f733bg2mdpvm8l95vwgxqb7pwmcnjr41531785nw5s7mk9mk9dl";
    };

    buildDepends = [
      ansi-terminal cmdargs extra fsnotify tasty tasty-hunit terminal-size
    ];
  };

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
