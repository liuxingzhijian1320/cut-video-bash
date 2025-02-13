#!/bin/bash

# 视频长度 56分23秒 == 3383秒

# 输入视频文件
input_video="result/2_imgs_video.mp4"

# 目标视频长度（秒）
target_duration=3383

# 获取输入视频的长度（秒）
video_duration=$(ffmpeg -i "$input_video" 2>&1 | grep "Duration" | awk '{print $2}' | tr -d , | awk -F: '{print $1*3600 + $2*60 + $3}')

# 计算需要循环的次数
loops=$(( (target_duration + video_duration - 1) / video_duration ))

# 使用ffmpeg循环视频
ffmpeg -stream_loop $loops -i "$input_video" -c copy -t $target_duration result/3_imgs_video_looped.mp4
