#!/bin/bash

rm -rf "result"/*
rm -rf "temp"/*

# 执行第一个脚本：重命名图片名称
echo "执行脚本: 1_rename.sh"
sh 1_rename.sh
# 等待3秒
sleep 3

# 执行第二个脚本：通过图片生成视频
echo "执行脚本: 2_every_img_video.sh"
sh 2_every_img_video.sh
# 等待3秒
sleep 3

# 执行第三个脚本：合并每个视频
echo "执行脚本: 3_every_video_merge.sh"
sh 3_every_video_merge.sh
# 等待3秒
sleep 3

# 执行第三个脚本：确定视频总长度多少， 则修改脚本的 target_duration 参数 （一定要修改）
echo "执行脚本: 4_imgs_video_looped.sh"
sh 4_imgs_video_looped.sh
# 等待3秒
sleep 3

# 执行第四个脚本：合成视频和音频
echo "执行脚本: 5_video_and_audio.sh"
sh 5_video_and_audio.sh

echo "所有脚本执行完毕！"
