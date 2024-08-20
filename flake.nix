# SPDX-FileCopyrightText: 2023 Technology Innovation Institute (TII)
#
# SPDX-License-Identifier: Apache-2.0
{
  description = "Caml Crush package and NixOS-module for ghaf framework";

  inputs = {
    # Nixpkgs
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:tiiuae/nixpkgs/nixos-unstable-xdg-ffado-2"; #"flake:mylocalnixpkgs"; #
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    flake-root.url = "github:srid/flake-root";
    devour-flake = {
      url = "github:srid/devour-flake";
      flake = false;
    };
    # Format all the things
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake
    {
      inherit inputs;
    } 
    
    {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      imports = [
        ./modules
        ./nix
        ./pkgs
      ];
    };
}
