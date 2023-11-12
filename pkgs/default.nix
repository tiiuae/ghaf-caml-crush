# SPDX-FileCopyrightText: 2023 Technology Innovation Institute (TII)
#
# SPDX-License-Identifier: Apache-2.0
#
# Packages to be exported from the flake
{
  perSystem = {pkgs, ...}: {
    packages = {
      caml-crush = pkgs.callPackage ./caml-crush {};
    };
  };
}
