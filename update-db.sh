#!/bin/bash

export OSFONTDIR="$HOME/.fonts;/usr/local/share/fonts;/usr/share/fonts"

mtxrun --script fonts --reload

mkluatexfontdb --force --verbose=-1 -vvv

mtxrun --script fonts --list --all --pattern=* > list-installed.txt
