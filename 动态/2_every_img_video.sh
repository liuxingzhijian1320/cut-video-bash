#!/bin/bash

# 设置输入图片目录和输出视频目录
input_dir="imgs"
output_dir="temp"
concat_file="${output_dir}/concat.txt"


# 创建输出目录（如果不存在）
mkdir -p "$output_dir"

# 获取 imgs 目录中的 .jpg 图片文件数量
img_count=$(ls -1 "$input_dir"/*.jpg 2>/dev/null | wc -l)

# 如果没有图片文件，则退出脚本
if [ "$img_count" -eq 0 ]; then
    echo "没有找到任何 .jpg 图片文件。"
    exit 1
fi

# 遍历 imgs 目录中的所有 .jpg 图片文件
for img_file in "$input_dir"/*.jpg; do
    # 获取图片的文件名（不带扩展名和路径）
    filename=$(basename "$img_file" .jpg)
    
    # 生成对应的视频文件名
    video_file="${output_dir}/${filename}.mp4"
    
    # 使用 ffmpeg 为图片生成一个短视频
    ffmpeg -loop 1 -i "$img_file" -vf "zoompan=z='1.5':x='if(lte(on,1),(iw-iw/zoom)/2,x-0)':y='if(lte(on,1),(ih-ih/zoom),y-2)':d=150" -c:v libx264 -pix_fmt yuv420p -y -b:v 9800k -r 25 -t 6 -s 1024x768 "$video_file"
   
    # 打印成功信息  
    echo "已生成视频文件: $video_file"

    # 将视频文件路径追加到 concat 文件中
    echo "file '$video_file'" >> "$concat_file"
done

echo "所有图片已处理完毕。"

