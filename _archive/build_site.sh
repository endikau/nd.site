#!/bin/bash

quarto render
cd hugo
hugo --cleanDestinationDir --destination "../public_serve" --minify
