#!/bin/bash

# 设置计数器初始值
counter=1

# 遍历imgs目录下的所有.jpg文件
for img in imgs/*.jpg; do
  # 检查文件是否存在（处理没有匹配文件的情况）
  if [ -e "$img" ]; then
    # 使用printf生成三位数的编号
    new_name=$(printf "imgs/%03d.jpg" $counter)
    
    # 重命名文件
    mv "$img" "$new_name"
    
    # 增加计数器
    counter=$((counter + 1))
  fi
done

echo "图片重命名完成。"
