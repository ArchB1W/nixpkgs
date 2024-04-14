{ lib, rustPlatform }:
let
  fs = lib.fileset;
in
rustPlatform.buildRustPackage {
  pname = "v1";
  version = "0.1.0";

  src = fs.toSource {
    root = ./.;
    fileset = fs.unions [
      ./Cargo.toml
      ./Cargo.lock
      ./src
    ];
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  doInstallCheck = true;

  installCheckPhase = ''
    $out/bin/v1
  '';
}
