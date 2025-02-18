#!/bin/bash

# 设置输入文件
audio_file="audio.wav"

# 步骤 1: 使用 whisper 提取音频文字并生成字幕文件
echo "正在提取音频文字..."
whisper "$audio_file" --model base --output_format srt --output_dir . --language Chinese

# 获取生成的字幕文件名（与音频文件同名）
subtitle_file="${audio_file%.*}.srt"

# 检查字幕文件是否生成
if [[ ! -f "$subtitle_file" ]]; then
    echo "错误：字幕文件未生成！"
    exit 1
fi

echo "字幕文件已生成: $subtitle_file"
