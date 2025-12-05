#!/bin/bash
# convert -density 256x256 -background transparent favicon.svg -define icon:auto-resize -colors 256 favicon.ico
convert -density 256x256 -background transparent favicon.svg -define icon:auto-resize=64,48,32,16 -colors 256 favicon.ico