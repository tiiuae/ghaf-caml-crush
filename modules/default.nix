# SPDX-FileCopyrightText: 2023 Technology Innovation Institute (TII)
#
# SPDX-License-Identifier: Apache-2.0
#
# nixosModules to be exported from the flake
{
  flake.nixosModules = {
    caml-crush = import ./services/caml-crush;
  };
}
