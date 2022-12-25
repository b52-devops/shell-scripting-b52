#!/bin/bash

# Escape sequesnce characters

echo "Hello World"

# Escape sequesnce characters will be considered by echo command only if we enable it by using the -e option

# \n : new line
# \t : tab space
# -e is to enable the escape sequence character
echo -e "Line1\nLine2"
echo Line2
echo Line3
