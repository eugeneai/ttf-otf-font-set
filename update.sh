#!/bin/bash

tmparch="/tmp/${USER}_tmp"

while read -r line
do
    a=($line)
    ext=${a[0]}
    dir=${a[1]}
    url=${a[2]}
    mkdir -p $dir
    tmp="$tmparch.$ext"
    wget $url -O $tmp
    7z e -y -o$dir -r $tmp *.otf *.ttf README* readme* LICEN* licen*
    rm -f $tmp
done < font.list

sfpath="http://downloads.sourceforge.net/corefonts"

mkdir -p CoreFonts
font_names="andale arial arialb comic courie georgi impact times trebuc verdan webdin"
for font in $font_names
do
    echo $font
    ext="32.exe"
    f="$font$ext"
    url="$sfpath/${f}"
    tmp="$tmparch$font$ext"
    wget $url -O $tmp
    7z e -y -oCoreFonts -r $tmp *.otf *.ttf *.TTF *.OTF README* readme* LICEN* licen*
    rm -f $tmp
done
pushd CoreFonts
for f in `find -depth`; do mv -f ${f} ${f,,} ; done
popd

pkgver=1.7.27
wget "http://source.winehq.org/source/fonts/tahoma.ttf?!v=wine-$pkgver&_raw=1" -O CoreFonts/tahoma.ttf
wget "http://source.winehq.org/source/fonts/tahomabd.ttf?!v=wine-$pkgver&_raw=1" -O CoreFonts/tahomabd.ttf
wget "http://download.microsoft.com/download/E/6/7/E675FFFC-2A6D-4AB0-B3EB-27C9F8C8F696/PowerPointViewer.exe" -O /tmp/ppt-vew.exe
mkdir -p VistaFonts
pushd /tmp
7z x -y ppt-view.exe ppviewer.cab
popd
7z e -y -oVistaFonts /tmp/ppviewer1.cab *.ttc *.TTC *.ttf *.TTF *.OTF *.otf
pushd VistaFonts/
for f in `find -depth`; do mv -f ${f} ${f,,} ; done
FONTFORGE_LANGUAGE=ff fontforge -c 'Open("cambria.ttc"); Generate("cambria.ttf")'
FONTFORGE_LANGUAGE=ff fontforge -c 'Open("meiryo.ttc"); Generate("meiryo.ttf")'
FONTFORGE_LANGUAGE=ff fontforge -c 'Open("meiryob.ttc"); Generate("meiryob.ttf")'
popd
rm -f /tmp/ppt-vew.exe
rm -f /tmp/ppviewer*.cab

./update-db.sh
