# SPDX-FileCopyrightText: 2023 Technology Innovation Institute (TII)
#
# SPDX-License-Identifier: Apache-2.0
#
# Packages to be exported from the flake
{self, ...}: {
  perSystem = {pkgs, ...}: {
    packages = {
      caml-crush = pkgs.callPackage ./caml-crush {};
      caml-crush-prebuilts = pkgs.callPackage ./caml-crush/prebuilts.nix {};
      caml-crush-tarballs = pkgs.callPackage ./caml-crush/tarballs.nix {inherit (self) packages;};
    };
  };
}
