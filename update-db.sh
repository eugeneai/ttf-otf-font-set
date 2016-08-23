#!/bin/bash

export OSFONTDIR="/usr/local/share/fonts;/usr/share/fonts;$HOME/.fonts"

mtxrun --script fonts --reload

mkluatexfontdb --force --verbose=-1 -vvv
