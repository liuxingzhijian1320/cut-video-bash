#!/bin/bash

# 参数设置
INPUT_IMAGE=001.jpg           # 输入图片路径
OUTPUT_VIDEO=output.mp4  # 输出视频名称（默认output.mp4）
DURATION=5         # 视频时长（秒，默认5）
WIDTH=1920                 # 视频宽度
HEIGHT=1080                # 视频高度
FPS=25                     # 帧率

# 计算总帧数
TOTAL_FRAMES=$(( FPS * DURATION ))

# 使用FFmpeg生成动画
ffmpeg -y -loop 1 -i "$INPUT_IMAGE" \
  -vf "
    scale=iw*2:ih*2,  
    zoompan=
      z='min(zoom+0.001,1.2)': 
      x='if(lte(mod(on,60),30), x-2, x+2)': 
      y='if(lte(mod(on,45),22), y-1, y+1)': 
      d=$TOTAL_FRAMES:  
      s=${WIDTH}x${HEIGHT}  
    " \
  -c:v libx264 \
  -t $DURATION \
  -r $FPS \
  -pix_fmt yuv420p \
  "$OUTPUT_VIDEO"