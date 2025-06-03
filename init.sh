#! /bin/bash

# 配置环境

mkdir -p ${HOME}/bin
if [ $? -ne 0 ]; then
  echo "错误: 无法创建目录 ${HOME}/bin，请检查权限"
  exit 1
fi

# 检查 .bashrc 文件中是否已添加环境变量
if ! grep -q "export PATH=\$HOME/bin:\$PATH" "$HOME/.bashrc"; then
  # 添加环境变量到 .bashrc
  echo "export PATH=\$HOME/bin:\$PATH" >> $HOME/.bashrc
  echo "已添加环境变量到 .bashrc"
else
  echo ".bashrc 中已存在环境变量设置，跳过"
fi

# 检查 .zshrc 文件是否存在
if [ -f "$HOME/.zshrc" ]; then
  # 检查 .zshrc 文件中是否已添加环境变量
  if ! grep -q "export PATH=\$HOME/bin:\$PATH" "$HOME/.zshrc"; then
    # 添加环境变量到 .zshrc
    echo "export PATH=\$HOME/bin:\$PATH" >> $HOME/.zshrc
    echo "已添加环境变量到 .zshrc"
  else
    echo ".zshrc 中已存在环境变量设置，跳过"
  fi
else
  echo "警告: ${HOME}/.zshrc 文件不存在，跳过 zsh 环境变量设置"
fi

# 将指定脚本复制到 bin 目录
cp  ./ezvllm $HOME/bin
cp  ./ezproxy $HOME/bin

# 赋予脚本执行权限
chmod +x $HOME/bin/ezvllm
chmod +x $HOME/bin/ezproxy

# 输出提示信息
echo "ezvllm 已安装到 $HOME/bin 目录。"
echo "ezproxy 已安装到 $HOME/bin 目录。"
# 提示用户重新加载配置
echo "请运行 'source ~/.bashrc' 或 'source ~/.zshrc' 以使更改生效。"
# 提示用户使用 ezvllm 命令
echo "您可以使用 'ezvllm' 命令来运行 ezvllm。"


