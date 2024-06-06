# SPDX-FileCopyrightText: 2023 Technology Innovation Institute (TII)
#
# SPDX-License-Identifier: Apache-2.0
# Build a test cross-compiled container for aarch64-linux
{self, ...}: {
  flake = {lib, ...}: {
    nixosConfigurations = {
      crossed = lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          {
            nixpkgs.hostPlatform.system = "aarch64-linux";
            nixpkgs.buildPlatform.system = "x86_64-linux";
            nixpkgs.overlays = [
              (final: _prev: {
                caml-crush = final.callPackage ../pkgs/caml-crush/prebuilts.nix {};
              })
            ];
          }
          ({pkgs, ...}: {
            environment.systemPackages = with pkgs; [
              # List problematic packages here
              caml-crush
            ];
            boot.isContainer = true; # Don't build kernel and other slow things
          })
        ];
      };
    };
  };
  perSystem = {system, ...}: {
    packages = {
      caml-crush-prebuilts-crossed = self.nixosConfigurations.crossed.config.system.build.toplevel;
    };
  };
}
