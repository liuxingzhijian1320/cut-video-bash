#!/bin/bash

# 参数设置
INPUT_DIR="imgs"            # 输入图片文件夹
OUTPUT_DIR="videos"         # 输出视频文件夹
DURATION=5                  # 每个视频时长（秒）
WIDTH=1024                  # 视频宽度
HEIGHT=768                 # 视频高度
FPS=25                      # 帧率

# 创建输出目录
mkdir -p "$OUTPUT_DIR"

# 获取图片列表
IMAGES=("$INPUT_DIR"/*.jpg "$INPUT_DIR"/*.png)

# 遍历图片并生成视频
for (( i=0; i<${#IMAGES[@]}; i++ )); do
  IMAGE="${IMAGES[$i]}"
  BASENAME=$(basename "$IMAGE")
  OUTPUT_VIDEO="$OUTPUT_DIR/${BASENAME%.*}.mp4"

  # 计算总帧数
  TOTAL_FRAMES=$(( FPS * DURATION ))

  # 根据奇偶数选择不同的运动效果
  if (( i % 2 == 0 )); then
    # 奇数图片：从上到下运动
    FILTER="
      scale=iw*2:ih*2,
      zoompan=
        z='min(zoom+0.001,1.2)':
        x='iw/2-(iw/zoom/2)':
        y='min(ih-(ih/zoom), on*0.1)':
        d=$TOTAL_FRAMES:
        s=${WIDTH}x${HEIGHT}
    "
  else
    # 偶数图片：从下到上运动
    FILTER="
      scale=iw*2:ih*2,
      zoompan=
        z='min(zoom+0.001,1.2)':
        x='iw/2-(iw/zoom/2)':
        y='max(0, ih-(ih/zoom)-on*0.1)':
        d=$TOTAL_FRAMES:
        s=${WIDTH}x${HEIGHT}
    "
  fi

  # 使用FFmpeg生成视频
  ffmpeg -y -loop 1 -i "$IMAGE" \
    -vf "$FILTER" \
    -c:v libx264 \
    -t $DURATION \
    -r $FPS \
    -pix_fmt yuv420p \
    "$OUTPUT_VIDEO"

  echo "生成视频: $OUTPUT_VIDEO"
done

echo "所有视频生成完成！输出目录: $OUTPUT_DIR"