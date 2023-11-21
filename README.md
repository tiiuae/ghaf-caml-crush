<!--
SPDX-FileCopyrightText: 2023 Technology Innovation Institute (TII)

SPDX-License-Identifier: Apache-2.0
-->

# ghaf-caml-crush
Caml Crush package and NixOS-module for ghaf framework

## Flake outputs

* `caml-crush` -- native compiled binary
* `caml-crush-tarballs` -- produce tarballs for upload to [prebuilt](prebuilt/) directory
* `caml-crush-prebuilts` -- produce package from prebuilts mentioned above (to bypass ocaml cross-compilation issues)
* `caml-crush-prebuilt-crossed` -- test output with cross-compiled `aarch64-linux` container with caml-crush-prebuilts. (for testing purposes)

## License
This project is licensed under the Apache-2.0 license - see the
[Apache-2.0.txt](LICENSES/Apache-2.0.txt) file for details.
