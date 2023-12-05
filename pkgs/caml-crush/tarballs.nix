# SPDX-FileCopyrightText: 2023 Technology Innovation Institute (TII)
#
# SPDX-License-Identifier: Apache-2.0
{
  runCommandNoCC,
  packages,
}:
runCommandNoCC "caml-crush-tarballs" {} ''
  mkdir $out
  (cd ${packages.x86_64-linux.caml-crush} && tar czvf $out/caml-crush-x86_64-linux.tar.gz .)
  (cd ${packages.aarch64-linux.caml-crush} && tar czvf $out/caml-crush-aarch64-linux.tar.gz .)
''
