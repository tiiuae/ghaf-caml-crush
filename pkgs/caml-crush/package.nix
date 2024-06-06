# SPDX-FileCopyrightText: 2023 Technology Innovation Institute (TII)
#
# SPDX-License-Identifier: Apache-2.0
{
  stdenv,
  lib,
  fetchFromGitHub,
  ocamlPackages,
  coccinelle,
  autoreconfHook,
  libtirpc,
  rpcsvc-proto,
  libnames ? ["pkcs11"],
  clientSocket ? "tcp,192.168.200.100:5657", # FIXME: should be null, and defined in a module, fix when cross-compilation would be fixed
  ocamlClient ? false,
  ...
}: let
  inherit
    (ocamlPackages)
    ocaml
    findlib
    camlidl
    camlp4
    config-file
    ;
  ocamlnet = ocamlPackages.ocamlnet.overrideAttrs (_old: {
    # Fix broken ocamlrpcgen
    dontStrip = true;
  });
in
  stdenv.mkDerivation rec {
    pname = "caml-crush";
    version = "1.0.12";
    src = fetchFromGitHub {
      owner = "caml-pkcs11";
      repo = "caml-crush";
      rev = "refs/tags/v${version}";
      sha256 = "sha256-oRpdUVkm1P5wGTm7tBsnpDmkv2NoeQxTglrQNd+wiyc=";
    };
    preConfigure = ''
      cp Makefile.Unix.in Makefile.in
    '';
    configureFlags =
      ["--with-libnames=${lib.concatStringsSep "," libnames}" "--with-idlgen" "--with-rpcgen"]
      ++ lib.optional ocamlClient "--with-ocamlclient"
      ++ lib.optional (clientSocket != null) "--with-client-socket=${clientSocket}";

    nativeBuildInputs = [autoreconfHook camlidl coccinelle ocaml findlib ocamlnet camlp4] ++ lib.optional (!ocamlClient) rpcsvc-proto;

    propagatedBuildInputs = [ocamlnet config-file] ++ lib.optional (!ocamlClient) libtirpc;

    # FIXME: should be conditional on !ocamlClient
    env.NIX_CFLAGS_COMPILE = toString ["-I${libtirpc.dev}/include/tirpc"];
  }
