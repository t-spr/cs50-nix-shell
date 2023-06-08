with import <nixpkgs> { };

let
  pythonPackages = python310Packages;
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
in pkgs.mkShell rec {
  name = "impurePythonEnv";
  venvDir = "./.venv";
  buildInputs = [
    unstable.libcs50
    pythonPackages.python
    # This executes some shell code to initialize a venv in $venvDir before
    # dropping into the shell
    pythonPackages.venvShellHook
  ];
    
  postVenvCreation = ''
    unset SOURCE_DATE_EPOCH
    pip install --upgrade pip
    pip install check50
  '';
  

  postShellHook = ''
    # allow pip to install wheels
    unset SOURCE_DATE_EPOCH/
  '';
}
