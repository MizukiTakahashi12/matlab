#!/bin/bash


#name='temp'
#img_dir='figs_png_S3btm_25h_ave_flow'

name='flow'
img_dir='figs_png_S3btm_without_v0.4c_btm_25h_ave_flow'

tag='SZ3_with'


rm -f imglist.txt
for img in $(ls "${img_dir}/${name}"*.png | sort); do
  echo "file '$img'" >> imglist.txt
done

mkdir -p anim


ffmpeg -r:v 20 -f concat -safe 0 -i imglist.txt -codec:v libx264 -pix_fmt yuv420p -crf 22 \
  -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -an anim/${tag}_${name}.mp4

rm -f imglist.txt
