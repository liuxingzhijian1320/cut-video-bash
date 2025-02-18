#!/bin/bash

audio_file="audio.wav"
output_file="output.srt"
model="base"

# 调用 Whisper 进行音频转录并生成 SRT 字幕文件，指定语言为繁体中文
whisper "$audio_file" --model "$model" --language zh --output_format srt --output_dir .

# 临时文件用于处理字幕
temp_file="temp.srt"
mv "${audio_file%.*}.srt" "$temp_file"

# 将字幕文件转换为繁体中文
opencc -i "$temp_file" -o "$temp_file.tc" -c s2twp.json

# 按标点符号断句处理字幕
awk '
BEGIN {
    FS = "-->"
    RS = "\n\n"
    OFS = "-->"
    ORS = "\n\n"
}
{
    index = $1
    time = $2
    text = $3
    gsub(/[。！？]/, "&\n", text)
    split(text, sentences, "\n")
    for (i in sentences) {
        if (sentences[i] != "") {
            print index++ OFS time "\n" sentences[i]
        }
    }
}' "$temp_file.tc" > "$output_file"

rm "$temp_file" "$temp_file.tc"
echo "字幕文件已保存到 $output_file"