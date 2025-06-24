# Cdy's tools

这是摸鱼时 `diy` 的一些小工具。如果好用请给个Star谢谢

如果这些工具对你有所帮助，欢迎 Star 支持，感谢关注！

## 目录
- [Cdy's tools](#cdys-tools)
  - [目录](#目录)
  - [工具列表](#工具列表)
    - [ezvllm](#ezvllm)
    - [ezxref](#ezxref)
    - [ezproxy](#ezproxy)
  - [安装](#安装)
    - [快速安装](#快速安装)
    - [选择性安装](#选择性安装)
    - [跨平台支持](#跨平台支持)
    - [安装过程](#安装过程)
  - [系统要求](#系统要求)
    - [操作系统](#操作系统)
    - [环境配置](#环境配置)
    - [特定工具依赖](#特定工具依赖)
    - [权限要求](#权限要求)
  - [许可](#许可)

## 工具列表

| 工具名称 | 描述 | 文档 | 依赖 |
|---------|------|------|------|
| [ezvllm](#ezvllm) | `vLLM` 服务管理工具 | [使用指南](USAGE.md#ezvllm---vllm-服务管理工具) | `Conda`, `vLLM` |
| [ezproxy](#ezproxy) | 代理设置管理工具 | [使用指南](USAGE.md#ezproxy---代理设置管理工具) | `SSH`,`jq` |
| [ezxref](#ezxref) | 智能文献引用转换工具 | [使用指南](USAGE.md#ezxref---智能文献引用转换工具) | `Python3` |

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

### ezxref

一个智能的Word文档文献引用转换工具，能够自动将纯文本引用转换为交叉引用格式。

**主要功能:**
- 智能识别多种连续引用格式（如 [1,2]、[3-7]、[1、2] 等）
- 自动转换为单独的交叉引用格式
- 支持自动创建参考文献书签
- 保持文档格式和结构完整性
- 支持详细的转换信息输出

**支持的引用格式:**
- 逗号分隔：`[1,2]` → `[1][2]`
- 范围格式：`[3-7]` → `[3][4][5][6][7]`
- 中文标点：`[1、2]`、`[4，2]` → `[1][2]`、`[4][2]`
- 混合格式：`[1-3,5]` → `[1][2][3][5]`
- 复杂格式：`[2，4–6、8]` → `[2][4][5][6][8]`

**详细使用说明:** [查看完整使用指南](USAGE.md#ezxref---智能文献引用转换工具)

**QuickStart:**
```bash
# 转换Word文档中的引用
ezxref 论文.docx

# 指定输出文件名
ezxref 论文.docx 论文_转换后.docx

# 显示详细转换信息
ezxref -i 论文.docx

# 查看帮助信息
ezxref -h

# 查看版本信息
ezxref -v
```

### ezproxy

一个便捷的代理设置管理工具，帮助你快速配置和管理终端的网络代理设置。

**主要功能:**
- 自动检测 SSH 客户端 IP 作为代理地址
- 灵活的端口配置和管理
- 支持 HTTP/HTTPS/SOCKS5 代理设置
- 支持 Git 和 Jupyter Notebook 专用代理配置
- 支持 VSCode 编辑器代理配置
- 配置文件持久化存储
- 一键取消代理设置
- 快速检查当前代理状态

**使用场景:**
- 通过 SSH 连接到远程服务器时自动配置代理
- 快速切换不同的代理配置
- 为 Git 操作单独配置代理
- 在 Jupyter Notebook 中设置代理环境
- 为 VSCode 编辑器配置网络代理
- 临时启用网络代理进行特定操作
- 快速检查当前系统代理状态

**详细使用说明:** [查看完整使用指南](USAGE.md#ezproxy---代理设置管理工具)

**QuickStart:**
```bash
# 使用默认端口设置代理（自动检测SSH客户端IP）
source ezproxy

# 指定IP和端口设置代理
source ezproxy -i 192.168.1.100 -p 8080

# 使用本地回环地址设置代理
source ezproxy -l -p 8080

# 设置默认端口（保存到配置文件）
source ezproxy -d 1080

# 检查当前代理设置
source ezproxy -c

# 设置 VSCode 代理
source ezproxy -e

# 设置 Git 代理
source ezproxy -g

# 设置 Jupyter Notebook 代理（显示设置代码）
source ezproxy -j

# 取消代理设置
source ezproxy -r

# 取消 Git 代理
source ezproxy -g -r

# 取消 VSCode 代理
source ezproxy -e -r

# 查看版本信息
source ezproxy -v

# 查看帮助信息
source ezproxy -h
```

**注意事项:**
- 必须使用 `source` 命令执行此脚本
- 代理设置仅在当前终端会话中有效
- 配置文件保存在 `~/.config/ezproxy/config`

**免责声明:**
本工具 ezproxy 仅用于设置系统环境中的代理变量（如 http_proxy、https_proxy 等），不提供任何代理服务，也不包含任何绕过网络审查、翻墙或访问被屏蔽网站的功能。用户应在合法合规的网络环境下使用本工具，遵守所在国家和地区的法律法规。若将本工具用于违法用途，责任由使用者本人承担。

**用途说明:**
本工具仅用于在受控网络环境下快速配置系统代理变量，适用于以下典型场景：
- 通过 SSH 登录远程开发主机时，根据 SSH 客户端 IP 自动设置本地代理
- 在公司或学校允许的网络代理基础设施下，快速切换代理配置  
- 临时为某些联网任务（如 Python 包下载、远程接口调用）启用代理访问
- 管理代理配置文件，避免重复输入代理参数

本工具**不包含任何代理协议实现**，**不提供任何访问互联网或翻墙功能**。

**重要提醒:**
- 本工具仅用于合法的网络配置管理，请勿将其用于访问被限制的网站或服务
- 使用本工具时，请确保你所连接的代理服务器是合法、合规的
- 在中国大陆地区使用时，请严格遵守《网络安全法》、《数据安全法》等相关法律法规
- 如有疑问，请咨询相关法律专业人士

**适用场景限制:**
本工具适用于以下合规场景：
- 企业内网开发环境的代理配置
- 学术研究机构的网络配置管理
- 其他符合当地法律法规的网络配置需求


## 安装

### 快速安装

使用以下命令快速安装所有工具:

```bash
git clone https://github.com/iCdy/shell.git
cd shell
./init.sh .
```

### 选择性安装

安装脚本现在支持灵活的安装选项：

```bash
# 安装所有脚本
./init.sh .

# 安装单个脚本
./init.sh ezvllm

# 安装多个指定脚本
./init.sh ezvllm ezproxy

# 更新已安装的脚本
./init.sh --update

# 查看帮助信息
./init.sh --help
```

### 跨平台支持

安装脚本会自动检测操作系统并配置相应的环境文件：
- **Linux**: 配置 `~/.bashrc` 和 `~/.zshrc`
- **macOS**: 配置 `~/.bash_profile` 和 `~/.zshrc`

### 安装过程

安装脚本会自动完成以下操作：
1. 检测操作系统类型
2. 创建 `~/bin` 目录（如果不存在）
3. 将选定的工具脚本复制到该目录
4. 根据系统类型配置适当的环境文件
5. 设置正确的执行权限

安装完成后，根据您的系统类型运行相应命令使环境变量生效：

```bash
# Linux 系统
source ~/.bashrc
# 或
source ~/.zshrc

# macOS 系统
source ~/.bash_profile
# 或
source ~/.zshrc
```

## 系统要求

### 操作系统
- **Linux** 或 **macOS** 系统
- **Bash** 或 **Zsh** shell

### 环境配置
- 安装脚本会自动检测系统类型并配置相应的环境文件：
  - **Linux**: `~/.bashrc` 和 `~/.zshrc`
  - **macOS**: `~/.bash_profile` 和 `~/.zshrc`

### 特定工具依赖
- **ezvllm**: 需要安装 `Conda` 和 `vLLM`
- **ezproxy**: 需要 `SSH` 和 `jq` 工具
- **ezxref**: 需要安装 `Python3`

### 权限要求
- 对 `~/bin` 目录的写权限
- 对 shell 配置文件（如 `~/.bashrc`、`~/.zshrc` 等）的写权限

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

