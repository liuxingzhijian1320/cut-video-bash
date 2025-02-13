#!/bin/bash

# 设置动态参数
mp4="result/3_imgs_video_looped.mp4" # 视频文件
mp3="audio.mp3" # 音频文件

# 合并视频和音频，视频编码保持不变，音频编码为AAC
ffmpeg -i "$mp4" -i "$mp3" -c:v copy -c:a aac "result/4_video_and_audio.mp4"
