#!/usr/bin/bash

home=$( pwd )

cd ./figures

# subset files
f=$( ls *.png | shuf -n 12 )

# copy to tmp folder
dir="/home/blair/Desktop/tmp"
trash $dir
mkdir $dir
cp $f $dir

# run montage
cd  $dir

montage  *.png[400x400] -tile 4x  -shadow -bordercolor White  +polaroid -background LightSteelBlue1 -geometry 400x300-20-20   tweet_montage.png

mv tweet_montage.png $home


