 场景： 一张静态图 - 运动起来 -- 合成单个视频 -- 多张单个视频合成完整视频, 适用于 小说类的视频剪辑
 
 > 脚本已经写好， 请勿乱修改

 ## 文件名称解释：

 1. imgs： 静态图片文件夹， 将你的照片丢到imgs文件夹下， 目前是 jpg 格式， 如果需要png 请修改 `2_every_img_video.sh`的jpg为png
 2. result： 输出结果
 3. temp： 临时存放文件夹
 4. audio.MP3 是音频文件 （剪映提取出来）

## 环境
  需要安装 

  ```bash
  
  brew install ffmpeg

  brew install openai-whisper`

  ```
 
 ## 动态视频

 one-key-run.sh 一键执行所有脚本

 ## 静态视频 （测试用）


## 排期计划
1. 单个图片运动合成视频 [√]
2. 多个视频合成完整视频 [√]
3. 音视频合成 [√]
4. 音频字幕提取 [√] 或者 使用 https://zenvideo.qq.com/
5. 视频嵌入字幕  使用剪映