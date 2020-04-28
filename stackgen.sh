#!/bin/bash

LayerHeight=0.3
ExtrusionWidth=0.4
TagCount=72
Stacks=(2 3 4 6 8)
Folder="renders"





for (( i=0; i<${#Stacks[*]}; i++ ))
do
filename="$Folder/N3DPS-v7-${Stacks[i]}-Stack-$LayerHeight-Layer-$ExtrusionWidth-Width-$TagCount-Supports.stl"
echo -n "$filename"
printf "\n"
printf "Generating\n"
echo openscad-nightly -o $filename -D 'LAYER_HEIGHT='$LayerHeight -D 'LAYER_WIDTH='$ExtrusionWidth -D 'TAG_COUNT='$TagCount -D 'STACK='${Stacks[i]} generator.scad
     openscad-nightly -o $filename -D 'LAYER_HEIGHT='$LayerHeight -D 'LAYER_WIDTH='$ExtrusionWidth -D 'TAG_COUNT='$TagCount -D 'STACK='${Stacks[i]} generator.scad
printf "File Done\n"
done
printf "Completed\n"

