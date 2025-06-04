# Cdy's tools

这是摸鱼时 `diy` 的一些小工具

## 目录
- [Cdy's tools](#cdys-tools)
  - [目录](#目录)
  - [工具列表](#工具列表)
    - [ezvllm](#ezvllm)
    - [ezproxy](#ezproxy)
  - [安装](#安装)
  - [系统要求](#系统要求)
  - [许可](#许可)

## 工具列表

| 工具名称 | 描述 | 文档 | 依赖 |
|---------|------|------|------|
| [ezvllm](#ezvllm) | `vLLM` 服务管理工具 | [使用指南](USAGE.md#ezvllm---vllm-服务管理工具) | `Conda`, `vLLM` |
| [ezproxy](#ezproxy) | 代理设置管理工具 | [使用指南](USAGE.md#ezproxy---代理设置管理工具) | `SSH` (可选) |

### ezvllm

一个简单易用的 `vLLM` 服务管理工具，帮助你快速部署和管理大型语言模型。

**主要功能:**
- 快速启动和管理 `vLLM` 服务
- 交互式聊天界面
- 灵活的配置管理
- 服务状态检查

**详细使用说明:** [查看完整使用指南](USAGE.md#ezvllm---vllm-服务管理工具)

**QuickStart:**
```bash
# 启动服务
ezvllm serve -m "Qwen/Qwen3-4B" -p 8009

# 与模型聊天
ezvllm chat -s "你是一个有用的助手"

# 检查服务状态
ezvllm check -p 8009 -t

# 管理配置
ezvllm config show
ezvllm config set MODEL_NAME="Qwen/Qwen3-4B"
ezvllm config param
```

### ezproxy

一个便捷的代理设置管理工具，帮助你快速配置和管理终端的网络代理设置。

**主要功能:**
- 自动检测 SSH 客户端 IP 作为代理地址
- 灵活的端口配置和管理
- 支持 HTTP/HTTPS/SOCKS5 代理设置
- 配置文件持久化存储
- 一键取消代理设置

**使用场景:**
- 通过 SSH 连接到远程服务器时自动配置代理
- 快速切换不同的代理配置
- 临时启用网络代理进行特定操作

**详细使用说明:** [查看完整使用指南](USAGE.md#ezproxy---代理设置管理工具)
**QuickStart:**
```bash
# 使用默认端口设置代理（自动检测SSH客户端IP）
source ezproxy

# 指定IP和端口设置代理
source ezproxy -i 192.168.1.100 -p 8080

# 设置默认端口（保存到配置文件）
source ezproxy -d 1080

# 取消代理设置
source ezproxy -r

# 查看版本信息
source ezproxy -v

# 查看帮助信息
source ezproxy -h
```

**注意事项:**
- 必须使用 `source` 命令执行此脚本
- 代理设置仅在当前终端会话中有效
- 配置文件保存在 `~/.config/ezproxy/config`


## 安装

使用以下命令快速安装所有工具:

```bash
git clone https://github.com/iCdy/shell.git
cd shell
./init.sh
```

安装脚本会:
1. 创建 `~/bin` 目录（如果不存在）
2. 将工具脚本复制到该目录
3. 添加 `~/bin` 到你的 PATH 环境变量（自动检测 bash 和 zsh）
4. 设置正确的执行权限

安装完成后，请运行 `source ~/.bashrc` 或 `source ~/.zshrc` 使环境变量生效。

## 系统要求

- `Linux` 或 `macOS` 系统
- `Bash` 或 `Zsh shell`
- 对于 `ezvllm`: 需要安装 `Conda` 和 `vLLM`

## 许可

本项目采用 [MIT License](LICENSE) 许可证。

```
MIT License

Copyright (c) 2025 Cdy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...
```

完整许可证请查看 [LICENSE](LICENSE) 文件。

