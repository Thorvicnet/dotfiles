#!/bin/bash
echo """
 .d88888b.                                  888 
d88P* *Y88b                                 888 
888     888                                 888 
888     888  .d8888b  8888b.  88888b.d88b.  888 
888     888 d88P*        *88b 888 *888 *88b 888 
888     888 888      .d888888 888  888  888 888 
Y88b. .d88P Y88b.    888  888 888  888  888 888 
 *Y88888P*   *Y8888P *Y888888 888  888  888 888 

       _______\\__
    .-(_. _ ._  _/
     '-' \__. /
          /  /
         /  /    .--.  .--.
        (  (    / '' \/ '' \\   '
         \\  \\_.'            \\   )
         ||               _  './
          |\\   \\     ___.'\\  /
            '-./   .'    \\ |/
               \\| /       )|\\
                |/       // \\\\
                |\\    __//   \\\\__
               //\\\\  /__/     \\__|
           .--_/  \\_--.
          /__/      \\__\\
"""
nix-shell -p ocamlPackages.re ocamlPackages.ocaml-lsp ocamlPackages.ocamlformat ocaml ocamlPackages.findlib ocamlPackages.utop --command zsh

