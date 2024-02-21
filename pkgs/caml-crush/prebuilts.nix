# SPDX-FileCopyrightText: 2023 Technology Innovation Institute (TII)
#
# SPDX-License-Identifier: Apache-2.0
{
  stdenv,
  autoPatchelfHook,
  libtirpc,
  ... # skip parameters FIXME: assert them via IFD
}: let
  prebuilts = {
    x86_64-linux = ../../prebuilt/caml-crush-x86_64-linux.tar.gz;
    aarch64-linux = ../../prebuilt/caml-crush-aarch64-linux.tar.gz;
  };
in
  stdenv.mkDerivation {
    name = "caml-crush-prebuilt";
    phases = [ "installPhase" "fixupPhase" ];
    configureFlags = [];
    nativeBuildInputs = [autoPatchelfHook];
    buildInputs = [libtirpc];
    installPhase = ''
      mkdir $out
      (cd $out && tar xvf ${prebuilts.${stdenv.hostPlatform.system}})
    '';
  }
