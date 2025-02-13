#!/bin/bash

# 设置动态参数
frame_interval=3  # 每3秒一帧

# 获取imgs目录下的图片数量
img_count=$(ls imgs/*.jpg 2>/dev/null | wc -l)
echo "imgs共有： ${img_count} 张图片"

# 计算视频的总持续时间（图片数量 * 3s）
video_duration=$((img_count * frame_interval))
echo "视频时长共： ${video_duration} 秒"

ffmpeg -framerate 1/${frame_interval} -i imgs/%03d.jpg -c:v libx264 -pix_fmt yuv420p -t ${video_duration} result/2_imgs_video.mp4
