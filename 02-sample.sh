#!/bin/bash

# Escape sequesnce characters

echo "Hello World"

# Escape sequesnce characters will be considered by echo command only if we enable it by using the -e option

# \n : new line
# \t : tab space
# -e is to enable the escape sequence character
echo -e "Line1\nLine2\nLine3"
echo -e "Line1 \t Line2 \t Line3"
