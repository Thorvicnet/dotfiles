#!/bin/bash

echo """
888           88888888888      Y88b   d88P 
888               888           Y88b d88P  
888               888            Y88o88P   
888       8888b.  888   .d88b.    Y888P    
888          \"88b 888  d8P  Y8b   d888b    
888      .d888888 888  88888888  d88888b   
888      888  888 888  Y8b.     d88P Y88b  
88888888 \"Y888888 888   \"Y8888 d88P   Y88b 

"""

echo "     :\`.            .--._"
echo "      \`\`.-        /  ',-\"\"\"\"'"
echo "        \`.\`~-._.'_./\"/"
echo "          \`~-._ .\` \`~;"
echo "               ;.    /"
echo "              /     /"
echo "         ,_.-';_,.'\`"
echo "          \`\"-;\`/"
echo "            ,'\`"

nix-shell -p texliveMedium tectonic texlab --command zsh
