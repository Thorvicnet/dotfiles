#!/bin/bash

echo """
888                               888    
888                               888    
888                               888    
888888 888  888 88888b.  .d8888b  888888 
888    888  888 888 *88b 88K      888    
888    888  888 888  888 *Y8888b. 888    
Y88b.  Y88b 888 888 d88P      X88 Y88b.  
 *Y888  *Y88888 88888P*   88888P*  *Y888 
            888 888                      
       Y8b d88P 888                      
        *Y88P*  888                      
"""

nix-shell -p typst tinymist typstfmt --command zsh
