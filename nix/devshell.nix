# Copyright 2022-2024 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.devshell.flakeModule
  ];
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devshells = {
      # the main developer environment
      default = {
        devshell = {
          name = "Ghaf caml crush devshell";
          meta.description = "Ghaf caml crush development environment";
          packages =
            [
              pkgs.nix-tree
              pkgs.reuse
              config.treefmt.build.wrapper
              pkgs.cachix
            ]
            ++ lib.attrValues config.treefmt.build.programs; # make all the trefmt packages available
        };
        commands = [
          {
            help = "Format";
            name = "format-repo";
            command = "treefmt";
            category = "checker";
          }
          {
            help = "Check license";
            name = "check-license";
            command = "reuse lint";
            category = "linters";
          }
        ];
      };
    };
  };
}
