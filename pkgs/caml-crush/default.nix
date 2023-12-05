# SPDX-FileCopyrightText: 2023 Technology Innovation Institute (TII)
#
# SPDX-License-Identifier: Apache-2.0
args @ {
  stdenv,
  callPackage,
  ...
}:
if stdenv.buildPlatform != stdenv.hostPlatform
then callPackage ./prebuilts.nix args
else callPackage ./package.nix args
