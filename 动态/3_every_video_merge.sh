#!/bin/bash

# 设置输入视频目录和输出视频文件
input_dir="temp"
final_output="result/3_every_video_merge.mp4"

# 创建临时文件列表
temp_file="video_list.txt"
> "$temp_file"  # 清空文件内容（如果文件已存在）

# 获取视频文件列表（按名称排序）
video_files=("$input_dir"/*.mp4)
IFS=$'\n' video_files=($(sort <<<"${video_files[*]}"))
unset IFS

# 将视频文件路径写入临时文件
for video in "${video_files[@]}"; do
    echo "file '$video'" >> "$temp_file"
done

# 使用ffmpeg合并视频
ffmpeg -f concat -safe 0 -i "$temp_file" -c copy "$final_output"

# 清理临时文件
rm -f "$temp_file"
rm -f "$input_dir"/*

echo "所有视频已合并到 $final_output"