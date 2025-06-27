# 工具使用指南

本文档提供了所有工具的详细使用说明。

## 通用安装说明

### 快速安装所有工具

```bash
# 克隆仓库
git clone https://github.com/iCdy/shell.git
cd shell

# 安装所有工具
./init.sh .

# 使配置生效（根据您的系统选择）
source ~/.zshrc      # zsh 用户
source ~/.bashrc     # Linux bash 用户  
source ~/.bash_profile  # macOS bash 用户
```

### 选择性安装

```bash
# 安装单个工具
./init.sh ezvllm

# 安装多个指定工具
./init.sh ezvllm ezproxy

# 更新已安装工具
./init.sh --update

# 查看帮助信息
./init.sh --help
```

### 跨平台支持

安装脚本会自动检测操作系统并配置相应的环境文件：
- **Linux**: 配置 `~/.bashrc` 和 `~/.zshrc`
- **macOS**: 配置 `~/.bash_profile` 和 `~/.zshrc`

## 目录

- [工具使用指南](#工具使用指南)
  - [通用安装说明](#通用安装说明)
    - [快速安装所有工具](#快速安装所有工具)
    - [选择性安装](#选择性安装)
    - [跨平台支持](#跨平台支持)
  - [目录](#目录)
- [ezvllm - vLLM 服务管理工具](#ezvllm---vllm-服务管理工具)
  - [安装](#安装)
    - [方式一：安装所有工具](#方式一安装所有工具)
    - [方式二：仅安装 ezvllm](#方式二仅安装-ezvllm)
    - [方式三：更新已安装工具](#方式三更新已安装工具)
  - [基本用法](#基本用法)
  - [命令详解](#命令详解)
    - [serve - 启动服务](#serve---启动服务)
      - [GPU自动选择功能详解](#gpu自动选择功能详解)
    - [chat - 与模型对话](#chat---与模型对话)
    - [check - 检查服务状态](#check---检查服务状态)
    - [config - 管理配置](#config---管理配置)
  - [配置文件](#配置文件)
  - [实用示例](#实用示例)
  - [疑难解答](#疑难解答)
- [ezproxy - 代理设置管理工具](#ezproxy---代理设置管理工具)
  - [安装](#安装-1)
    - [方式一：安装所有工具](#方式一安装所有工具-1)
    - [方式二：仅安装 ezproxy](#方式二仅安装-ezproxy)
    - [方式三：更新已安装工具](#方式三更新已安装工具-1)
  - [基本用法](#基本用法-1)
  - [命令详解](#命令详解-1)
    - [基本代理设置](#基本代理设置)
    - [指定 IP 和端口](#指定-ip-和端口)
    - [配置管理](#配置管理)
    - [代理控制](#代理控制)
  - [配置文件](#配置文件-1)
  - [实用示例](#实用示例-1)
    - [场景 1：SSH 远程开发](#场景-1ssh-远程开发)
    - [场景 2：办公网络代理配置](#场景-2办公网络代理配置)
    - [场景 3：临时代理任务](#场景-3临时代理任务)
    - [场景 4：Git 专用代理](#场景-4git-专用代理)
    - [场景 5：VSCode 编辑器代理配置](#场景-5vscode-编辑器代理配置)
    - [场景 6：本地代理服务](#场景-6本地代理服务)
    - [场景 7：代理状态检查](#场景-7代理状态检查)
    - [场景 8：Jupyter Notebook 代理配置](#场景-8jupyter-notebook-代理配置)
  - [疑难解答](#疑难解答-1)
- [ezxref - 智能文献引用转换工具](#ezxref---智能文献引用转换工具)
  - [安装](#安装-2)
    - [方式一：安装所有工具](#方式一安装所有工具-2)
    - [方式二：仅安装 ezxref](#方式二仅安装-ezxref)
    - [方式三：更新已安装工具](#方式三更新已安装工具-2)
  - [基本用法](#基本用法-2)
  - [功能特性](#功能特性)
  - [支持的引用格式](#支持的引用格式)
    - [连续引用格式识别](#连续引用格式识别)
  - [命令详解](#命令详解-2)
    - [基本转换命令](#基本转换命令)
    - [命令选项](#命令选项)
  - [实用示例](#实用示例-2)
    - [示例 1：基本转换](#示例-1基本转换)
    - [示例 2：指定输出文件](#示例-2指定输出文件)
    - [示例 3：查看详细转换信息](#示例-3查看详细转换信息)
    - [示例 4：批量处理](#示例-4批量处理)
    - [示例 5：带详细信息的批量处理](#示例-5带详细信息的批量处理)
  - [注意事项](#注意事项)
    - [使用前准备](#使用前准备)
    - [文档要求](#文档要求)
    - [转换后操作](#转换后操作)
    - [性能注意事项](#性能注意事项)
  - [疑难解答](#疑难解答-2)
    - [常见问题](#常见问题)
    - [错误排查](#错误排查)
    - [高级用法](#高级用法)

---

# ezvllm - vLLM 服务管理工具

`ezvllm` 是一个简化 vLLM 服务管理的命令行工具，支持快速启动模型服务、交互式聊天、服务状态检查和灵活的配置管理。新增超时自动退出功能，可在指定时间内无请求时自动关闭服务，有效节省计算资源。**最新版本新增智能GPU自动选择功能**，能够自动检测所有GPU状态并选择最优可用GPU。

## 安装

### 方式一：安装所有工具

```bash
# 克隆仓库
git clone https://github.com/iCdy/shell.git
cd shell

# 安装所有工具
./init.sh .

# 使配置生效（根据您的系统选择）
source ~/.zshrc      # zsh 用户
source ~/.bashrc     # Linux bash 用户  
source ~/.bash_profile  # macOS bash 用户
```

### 方式二：仅安装 ezvllm

```bash
# 克隆仓库
git clone https://github.com/iCdy/shell.git
cd shell

# 仅安装 ezvllm
./init.sh ezvllm

# 使配置生效
source ~/.zshrc  # 或根据您的系统选择相应配置文件
```

### 方式三：更新已安装工具

```bash
cd shell
./init.sh --update
```

## 基本用法

```bash
# 查看版本
ezvllm -v

# 显示帮助信息
ezvllm -h

# 启动服务（默认命令）
ezvllm serve [选项]

# 与模型聊天
ezvllm chat [选项]

# 检查服务状态
ezvllm check [选项]

# 管理配置
ezvllm config [子命令]
```

## 命令详解

### serve - 启动服务

`serve` 命令用于启动 vLLM 服务，是 `ezvllm` 的默认命令。

```bash
ezvllm serve [选项]
```

**选项：**

- `-e, --env-name NAME` - 指定 conda 环境名称，默认为 "vllm"
- `-g, --gpu-id ID` - 指定要使用的 GPU ID，默认为 "0"。**使用 'a' 或 'auto' 可自动选择最优可用GPU**
- `-m, --model-name NAME` - 指定模型名称，默认为 "Qwen/Qwen3-4B"
- `-k, --api-key KEY` - 指定 API 密钥，默认为 "1205"
- `-p, --port PORT` - 指定服务端口，默认为 "8009"
- `-l, --max-model-len LEN` - 指定最大模型长度，默认不限制
- `-u, --gpu-util UTIL` - 指定 GPU 利用率，默认为 "0.9"
- `-t, --timeout MINUTES` - 设置超时时间（分钟），超时后自动退出服务，默认60分钟。设置为0时不限时。
- `-d, --disable-function` - 禁用函数调用功能
- `-v, --vllm-args "ARGS"` - 传递额外参数给 vllm serve 命令

**示例：**

```bash
# 使用默认配置启动服务
ezvllm serve

# 自动选择最优GPU启动服务
ezvllm serve -g a
# 或
ezvllm serve --gpu-id auto

# 指定模型和端口
ezvllm serve -m "meta-llama/Llama-2-7b-chat-hf" -p 8008

# 自动选择GPU并指定模型
ezvllm serve -g a -m "Qwen/Qwen3-7B" -p 8888

# 使用 1 号 GPU 并限制 GPU 利用率
ezvllm serve -g 1 -u 0.8

# 限制最大模型长度
ezvllm serve -l 2048

# 设置30分钟超时，无请求时自动退出
ezvllm serve -t 30

# 自动选择GPU并设置超时
ezvllm serve -g a -t 45

# 传递额外参数给 vllm
ezvllm serve -v "--tensor-parallel-size 2 --quantization awq"
```

#### GPU自动选择功能详解

ezvllm 提供智能GPU自动选择功能，可以自动检测所有GPU的状态并选择最优可用GPU。

**使用方法：**
```bash
# 使用 -g a 或 --gpu-id a 启用自动选择
ezvllm serve -g a
ezvllm serve --gpu-id auto
```

**选择策略：**
- 自动检测所有可用GPU的状态
- 优先选择GPU利用率、显存利用率和显存使用率均小于5%的GPU
- 如果多个GPU都符合条件，选择ID较小的GPU
- 如果没有找到完全空闲的GPU，会提示用户手动指定或等待

**状态检测内容：**
- GPU计算利用率
- GPU显存利用率  
- 显存使用情况（已用/总容量）

**使用场景：**
- 多GPU服务器环境，自动避开正在使用的GPU
- 提高资源利用效率，避免GPU冲突
- 适用于共享GPU环境下的模型部署

**示例输出：**
```
正在检测可用GPU...
检测到 4 张GPU
GPU 0: 计算利用率=0%, 显存利用率=0%, 显存使用=156MB/24564MB (1%)
GPU 1: 计算利用率=85%, 显存利用率=90%, 显存使用=22000MB/24564MB (90%)
GPU 2: 计算利用率=2%, 显存利用率=1%, 显存使用=200MB/24564MB (1%)
GPU 3: 计算利用率=0%, 显存利用率=0%, 显存使用=156MB/24564MB (1%)
自动选择GPU: 0 (利用率: 0%)
```

### chat - 与模型对话

`chat` 命令提供交互式对话界面，可以与正在运行的模型进行对话。

```bash
ezvllm chat [选项]
```

**选项：**

- `-m, --model-name NAME` - 指定模型名称，默认为配置文件中的值
- `-p, --port PORT` - 指定服务端口，默认为配置文件中的值
- `-k, --api-key KEY` - 指定 API 密钥，默认为配置文件中的值
- `-s, --system TEXT` - 设置系统提示信息
- `-t, --temperature VAL` - 设置温度参数，默认为 "0.7"

**示例：**

```bash
# 使用默认设置与模型聊天
ezvllm chat

# 指定系统提示
ezvllm chat -s "你是一个专业的程序员助手，精通 Python 和 JavaScript"

# 设置较低的温度获得更确定性的回答
ezvllm chat -t 0.3

# 连接到特定端口的服务
ezvllm chat -p 8080
```

### check - 检查服务状态

`check` 命令用于检查 vLLM 服务的运行状态。

```bash
ezvllm check [选项]
```

**选项：**

- `-p, --port PORT` - 指定服务端口，默认为配置文件中的值
- `-k, --api-key KEY` - 指定 API 密钥，默认为配置文件中的值
- `-t, --test` - 测试 API 连接
- `-m, --model-name NAME` - 指定模型名称，默认为配置文件中的值
- `-i, --info` - 输出详细信息

**示例：**

```bash
# 检查默认端口上的服务
ezvllm check

# 检查特定端口上的服务
ezvllm check -p 8010

# 测试 API 连接
ezvllm check -t

# 查看详细信息
ezvllm check -i
```

### config - 管理配置

`config` 命令用于管理 ezvllm 的配置文件。

```bash
ezvllm config [子命令]
```

**子命令：**

- `show` - 显示当前配置
- `edit` - 编辑配置文件（使用默认编辑器）
- `set KEY=VALUE` - 设置配置项
- `unset KEY` - 移除配置项
- `param` - 显示所有可用的配置参数

**示例：**

```bash
# 显示当前配置
ezvllm config show

# 编辑配置文件
ezvllm config edit

# 设置默认模型
ezvllm config set MODEL_NAME="meta-llama/Llama-2-13b-chat-hf"

# 设置 API 密钥
ezvllm config set API_KEY="your-api-key"

# 移除配置项
ezvllm config unset SYSTEM_PROMPT

# 查看可用参数
ezvllm config param
```

## 配置文件

ezvllm 使用位于 `$HOME/.config/ezvllm/config` 的配置文件存储默认设置。配置文件采用简单的 `KEY=VALUE` 格式。

可配置的参数包括：

- `ENV_NAME` - Python 虚拟环境名称
- `GPU_ID` - 使用的 GPU ID（可设置为 "a" 或 "auto" 启用自动选择）
- `MODEL_NAME` - 模型名称
- `API_KEY` - API 密钥
- `PORT` - 服务端口
- `MAX_MODEL_LEN` - 最大模型长度
- `GPU_UTIL` - GPU 利用率
- `TIMEOUT_MINUTES` - 超时时间（分钟），默认为60分钟。设置为0为不限时。
- `DISABLE_FUNCTION_CALL` - 是否禁用函数调用
- `SYSTEM_PROMPT` - 默认系统提示词
- `TEMPERATURE` - 生成温度

## 实用示例

**快速启动一个本地模型并聊天：**

```bash
# 启动服务（自动选择最优GPU）
ezvllm serve -g a -m "/path/to/local/model"

# 在新终端中启动聊天
ezvllm chat -s "你是一个友好的助手"
```

**GPU自动选择使用示例：**

```bash
# 基本自动选择GPU
ezvllm serve -g a

# 自动选择GPU并指定模型
ezvllm serve -g auto -m "Qwen/Qwen3-7B"

# 自动选择GPU，设置端口和超时
ezvllm serve -g a -p 8888 -t 60

# 自动选择GPU并结合其他参数
ezvllm serve -g a -m "meta-llama/Llama-2-7b-chat-hf" -u 0.8 -t 30
```

**设置默认配置并使用：**

```bash
# 设置默认模型和端口
ezvllm config set MODEL_NAME="Qwen/Qwen3-7B"
ezvllm config set PORT="8888"

# 使用默认设置启动（自动选择GPU）
ezvllm serve -g a
```

**运行多个模型实例：**

```bash
# 在不同端口启动不同模型（自动选择不同GPU）
ezvllm serve -g a -m "Qwen/Qwen3-4B" -p 8001
ezvllm serve -g a -m "meta-llama/Llama-2-7b-chat-hf" -p 8002

# 与特定实例聊天
ezvllm chat -p 8002
```

**使用超时自动退出功能：**

```bash
# 启动服务，30分钟无请求后自动退出
ezvllm serve -t 30

# 自动选择GPU并设置超时
ezvllm serve -g a -t 30

# 启动指定模型，60分钟无请求后自动退出
ezvllm serve -m "Qwen/Qwen3-7B" -p 8888 -t 60

# 结合GPU自动选择、其他参数和超时功能
ezvllm serve -g a -m "meta-llama/Llama-2-7b-chat-hf" -u 0.8 -t 45
```

**超时功能使用场景：**

```bash
# 开发测试：短时间测试模型，避免忘记关闭
ezvllm serve -g a -m "test-model" -t 15

# 临时演示：演示结束后自动清理资源
ezvllm serve -g a -m "demo-model" -p 8080 -t 120

# 批处理任务：处理完成后自动退出
ezvllm serve -g a -m "batch-model" -t 180
```

## 疑难解答

**服务无法启动：**

- 检查 conda 环境是否正确安装了 vLLM
- 验证 GPU 是否可用
- 确认模型路径是否正确

**GPU自动选择相关问题：**

- 如果自动选择失败，请确认 `nvidia-smi` 命令可用
- 当所有GPU都在使用时，系统会提示手动指定GPU或等待
- 可以使用 `nvidia-smi` 命令手动查看GPU状态
- 在没有GPU的环境中，自动选择会回退到默认GPU 0

**API 连接失败：**

- 确认服务正在运行: `ezvllm check`
- 检查端口是否正确
- 检查 API 密钥是否匹配

**模型加载过慢：**

- 考虑减小 `MAX_MODEL_LEN` 值
- 调整 `GPU_UTIL` 参数
- 使用量化版本的模型
- 使用 `-g a` 自动选择负载较低的GPU

---

# ezproxy - 代理设置管理工具

`ezproxy` 是一个轻量级的代理设置管理工具，专为通过 SSH 连接时快速配置网络代理而设计。它能自动检测 SSH 客户端 IP，支持灵活的端口配置，并提供配置持久化功能。

## 安装

### 方式一：安装所有工具

```bash
# 克隆仓库
git clone https://github.com/iCdy/shell.git
cd shell

# 安装所有工具
./init.sh .

# 使配置生效（根据您的系统选择）
source ~/.zshrc      # zsh 用户
source ~/.bashrc     # Linux bash 用户  
source ~/.bash_profile  # macOS bash 用户
```

### 方式二：仅安装 ezproxy

```bash
# 克隆仓库
git clone https://github.com/iCdy/shell.git
cd shell

# 仅安装 ezproxy
./init.sh ezproxy

# 使配置生效
source ~/.zshrc  # 或根据您的系统选择相应配置文件
```

### 方式三：更新已安装工具

```bash
cd shell
./init.sh --update
```

## 基本用法

⚠️ **重要：** `ezproxy` 必须使用 `source` 命令执行，不能直接运行！

```bash
# 查看帮助信息
source ezproxy -h

# 查看版本
source ezproxy -v

# 使用默认配置设置代理（自动检测SSH客户端IP）
source ezproxy

# 指定IP和端口设置代理
source ezproxy -i IP地址 -p 端口号

# 设置默认端口
source ezproxy -d 端口号

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
```

## 命令详解

### 基本代理设置

最简单的使用方式是直接运行 `source ezproxy`，工具会自动：
1. 从 SSH_CLIENT 环境变量中检测客户端 IP
2. 使用配置文件中保存的默认端口（初始为 1080）
3. 设置 HTTP、HTTPS 和 SOCKS5 代理

```bash
# 自动代理设置
source ezproxy
```

### 指定 IP 和端口

**选项：**

- `-i IP` - 指定代理服务器的 IP 地址
- `-l` - 使用本地回环地址（127.0.0.1）作为代理IP
- `-p PORT` - 指定代理服务器的端口号

```bash
# 指定特定的代理服务器
source ezproxy -i 192.168.1.100 -p 8080

# 只指定端口，IP 自动检测
source ezproxy -p 1080

# 只指定IP，使用默认端口
source ezproxy -i 10.0.0.1

# 使用本地回环地址（127.0.0.1）设置代理
source ezproxy -l -p 8080

# 使用本地回环地址和默认端口
source ezproxy -l
```

### 配置管理

**选项：**

- `-d PORT` - 设置默认端口号并保存到配置文件

```bash
# 设置默认端口为 1080
source ezproxy -d 1080

# 设置默认端口为 8080
source ezproxy -d 8080
```

### 代理控制

**选项：**

- `-c` - 检查并输出当前代理设置
- `-e` - 设置 VSCode 编辑器代理配置
- `-r` - 取消当前会话的代理设置
- `-g` - 设置 Git 代理（仅影响 Git 操作）
- `-j` - 显示 Jupyter Notebook 代理设置代码
- `-v` - 显示版本信息
- `-h` - 显示帮助信息

```bash
# 检查当前代理设置
source ezproxy -c

# 设置 VSCode 代理
source ezproxy -e

# 取消代理设置
source ezproxy -r

# 设置 Git 代理（仅影响 Git 操作）
source ezproxy -g

# 显示 Jupyter Notebook 代理设置代码
source ezproxy -j

# 查看版本
source ezproxy -v

# 查看帮助
source ezproxy -h
```

## 配置文件

ezproxy 使用位于 `$HOME/.config/ezproxy/config` 的配置文件存储默认设置。配置文件采用简单的 shell 变量格式。

```bash
# ezproxy 配置文件
PROXY_PORT="1080"
```

配置文件会在首次运行时自动创建，并在使用 `-d` 选项时更新。

## 实用示例

### 场景 1：SSH 远程开发

当你通过 SSH 连接到远程服务器但无法访问互联网，需要使用本地的代理访问互联网时：

```bash
# 在远程服务器上设置代理（自动检测你的本地IP）
source ezproxy

# 测试代理是否工作
curl -I https://www.baidu.com

# 如果本地代理端口不是默认的1080，指定端口
source ezproxy -p 7890
```

### 场景 2：办公网络代理配置

在办公环境中快速切换代理配置：

```bash
# 设置公司代理服务器
source ezproxy -i proxy.company.com -p 8080

# 保存常用端口为默认值
source ezproxy -d 8080

# 之后只需指定IP即可
source ezproxy -i proxy.company.com
```

### 场景 3：临时代理任务

为特定任务临时启用代理：

```bash
# 启用代理（自动检测SSH客户端IP）
source ezproxy -p 1080

# 使用本地回环地址设置代理（适用于本地代理服务）
source ezproxy -l -p 1080

# 指定特定IP设置代理
source ezproxy -i 127.0.0.1 -p 1080

# 执行需要代理的任务
curl https://api.example.com/data
wget https://files.example.com/file.zip

# 任务完成后取消代理
source ezproxy -r
```

### 场景 4：Git 专用代理

当你只需要为 Git 操作设置代理，而不影响其他命令行工具时：

```bash
# 设置 Git 专用代理
source ezproxy -g

# Git 操作将通过代理进行
git clone https://github.com/user/repo.git
git push origin main

# 检查 Git 代理设置
git config --global --get http.proxy
git config --global --get https.proxy

# 取消 Git 代理设置
source ezproxy -g -r
```

### 场景 5：VSCode 编辑器代理配置

当你需要为 VSCode 编辑器设置代理以访问扩展市场或同步设置时：

```bash
# 设置 VSCode 代理
source ezproxy -e

# 这将自动更新 VSCode 的 settings.json 文件
# 重启 VSCode 后代理配置即可生效

# 取消 VSCode 代理设置
source ezproxy -e -r

# 检查当前 VSCode 代理配置是否生效
# 可在 VSCode 中按 Ctrl+Shift+P，输入 "Preferences: Open Settings (JSON)"
# 查看 settings.json 中的 http.proxy 和 https.proxy 设置
```

### 场景 6：本地代理服务

当你在本地运行代理软件（如 Clash、v2ray、shadowsocks 等）时，使用本地回环地址：

```bash
# 使用本地代理服务（端口1080）
source ezproxy -l -p 1080

# 使用本地代理服务（端口7890，常见的Clash端口）
source ezproxy -l -p 7890

# 使用本地代理服务（端口8080）
source ezproxy -l -p 8080

# 测试本地代理是否工作
curl -I https://www.google.com

# 如果代理工作正常，会显示网页响应头
# 如果失败，请检查：
# 1. 本地代理软件是否正在运行
# 2. 端口号是否正确
# 3. 代理软件是否允许局域网连接
```

**本地代理的优势：**
- 不依赖SSH连接状态
- 延迟较低，速度较快
- 更稳定可靠

### 场景 7：代理状态检查

快速检查当前系统的代理设置状态：

```bash
# 检查当前所有代理环境变量
source ezproxy -c

# 这会显示类似以下的输出：
# http_proxy=http://192.168.1.100:1080
# https_proxy=http://192.168.1.100:1080
# all_proxy=socks5://192.168.1.100:1080
```

### 场景 8：Jupyter Notebook 代理配置

在 Jupyter Notebook 中需要通过代理访问网络资源时：

```bash
# 显示 Jupyter 代理设置代码
source ezproxy -j
```

这会输出以下代码，你需要在 Jupyter Notebook 的代码单元中运行：

```python
import os
os.environ['http_proxy'] = 'http://192.168.1.100:1080'
os.environ['https_proxy'] = 'http://192.168.1.100:1080'
os.environ['all_proxy'] = 'socks5://192.168.1.100:1080'
```


## 疑难解答

**代理设置失败：**

- 确保使用 `source` 命令而非直接执行
- 检查是否在 SSH 会话中（自动IP检测需要SSH_CLIENT环境变量）
- 验证指定的 IP 和端口是否正确

**自动 IP 检测失败：**

```bash
# 手动检查 SSH_CLIENT 变量
echo $SSH_CLIENT

# 如果为空，手动指定IP
source ezproxy -i 你的客户端IP -p 端口号
```

**代理不生效：**

```bash
# 检查环境变量是否设置正确
echo $http_proxy
echo $https_proxy
echo $all_proxy

# 测试连接
curl -I --connect-timeout 10 https://www.baidu.com
```

**配置文件问题：**

```bash
# 查看配置文件
cat ~/.config/ezproxy/config

# 手动重置配置文件
rm ~/.config/ezproxy/config
source ezproxy -d 1080
```

**取消代理后仍然使用代理：**

```bash
# 确认环境变量已清除
unset http_proxy https_proxy all_proxy

# 或者重新登录终端会话
```

**VSCode 代理设置问题：**

```bash
# 检查 VSCode settings.json 文件是否存在
ls -la ~/.vscode-server/data/Machine/settings.json

# 检查是否安装了 jq 工具（用于处理 JSON）
which jq

# 如果没有 jq，可以手动编辑 settings.json
# 添加或删除以下内容：
# "http.proxy": "http://IP:PORT",
# "https.proxy": "http://IP:PORT",
```

**代理状态检查：**

```bash
# 使用 -c 参数检查所有代理设置
source ezproxy -c

# 手动检查特定环境变量
echo $http_proxy
echo $https_proxy
echo $all_proxy

# 检查 Git 代理设置
git config --global --get http.proxy
git config --global --get https.proxy
```

**免责声明:**
本工具 ezproxy 仅用于设置系统环境中的代理变量（如 http_proxy、https_proxy 等），不提供任何代理服务，也不包含任何绕过网络审查、翻墙或访问被屏蔽网站的功能。用户应在合法合规的网络环境下使用本工具，遵守所在国家和地区的法律法规。
若将本工具用于违法用途，责任由使用者本人承担。

**用途说明:**
本工具 `ezproxy` 仅用于在受控网络环境下快速配置系统代理变量（如 http_proxy、https_proxy、all_proxy），适用于以下典型场景：

1. 通过 SSH 登录远程开发主机时，根据 SSH 客户端 IP 自动设置本地代理；
2. 在公司或学校允许的网络代理基础设施下，快速切换代理配置；
3. 临时为某些联网任务（如 Python 包下载、远程接口调用）启用代理访问；
4. 管理代理配置文件，避免重复输入代理参数。

本工具**不包含任何代理协议实现**，**不提供任何访问互联网或翻墙功能**。其作用等价于通过命令行设置代理环境变量，例如：

    export http_proxy=http://IP:PORT
    export https_proxy=http://IP:PORT

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

---

# ezxref - 智能文献引用转换工具

`ezxref` 是一个专门用于处理Word文档中文献引用的智能转换工具。它能够自动识别和转换多种连续引用格式，将纯文本引用转换为交叉引用，大大提高学术论文的格式规范性和可维护性。

## 安装

### 方式一：安装所有工具

```bash
# 克隆仓库
git clone https://github.com/iCdy/shell.git
cd shell

# 安装所有工具
./init.sh .

# 使配置生效（根据您的系统选择）
source ~/.zshrc      # zsh 用户
source ~/.bashrc     # Linux bash 用户  
source ~/.bash_profile  # macOS bash 用户
```

### 方式二：仅安装 ezxref

```bash
# 克隆仓库
git clone https://github.com/iCdy/shell.git
cd shell

# 仅安装 ezxref
./init.sh ezxref

# 使配置生效
source ~/.zshrc  # 或根据您的系统选择相应配置文件
```

### 方式三：更新已安装工具

```bash
cd shell
./init.sh --update
```

## 基本用法

```bash
# 查看版本
ezxref -v

# 显示帮助信息
ezxref -h

# 转换文档引用（默认输出文件名：原文件名_xref.docx）
ezxref 论文.docx

# 指定输出文件名
ezxref 论文.docx 论文_转换后.docx

# 显示详细转换过程信息
ezxref -i 论文.docx
```

## 功能特性

- **智能识别**: 自动识别文档中的连续引用格式
- **格式转换**: 将连续引用拆分为单独的交叉引用
- **书签创建**: 自动为参考文献创建书签并建立链接
- **结构保持**: 保持原文档的格式和结构完整性
- **详细输出**: 提供转换过程的详细信息反馈
- **安全处理**: 不修改原文件，生成新的转换文件

## 支持的引用格式

### 连续引用格式识别

工具能够智能识别并转换以下多种连续引用格式：

**逗号分隔格式:**
```
[1,2]        → [1][2]
[3,5,7]      → [3][5][7]
```

**范围格式:**
```
[3-7]        → [3][4][5][6][7]
[1-3]        → [1][2][3]
```

**中文标点格式:**
```
[1、2]       → [1][2]
[4，2]       → [4][2]
```

**长破折号格式:**
```
[8–10]       → [8][9][10]  (短破折号)
[5—8]        → [5][6][7][8] (长破折号)
```

**混合格式:**
```
[1-3,5]      → [1][2][3][5]
[2，4–6、8]  → [2][4][5][6][8]
[1,3-5,7]    → [1][3][4][5][7]
```

## 命令详解

### 基本转换命令

```bash
ezxref <输入文件.docx> [输出文件.docx]
```

**参数说明:**
- `输入文件.docx`: 要处理的Word文档路径（必需）
- `输出文件.docx`: 输出文件路径（可选，默认为原文件名添加"_xref"后缀）

### 命令选项

**显示帮助:**
```bash
ezxref -h
ezxref --help
```

**显示版本:**
```bash
ezxref -v
ezxref --version
```

**详细信息输出:**
```bash
ezxref -i 论文.docx
ezxref --information 论文.docx
```

使用 `-i` 或 `--information` 选项可以显示转换过程的详细信息，包括：
- 检测到的连续引用格式
- 转换过程中的操作详情
- 创建的书签信息
- 转换统计结果

## 实用示例

### 示例 1：基本转换

```bash
# 转换学术论文中的引用
ezxref 我的论文.docx

# 输出：我的论文_xref.docx
```

### 示例 2：指定输出文件

```bash
# 指定输出文件名
ezxref 原稿.docx 修改稿.docx
```

### 示例 3：查看详细转换信息

```bash
# 显示详细的转换过程
ezxref -i 论文.docx

# 输出示例：
# 检测连续引用格式...
# 发现 3 个连续引用
# 转换连续引用: [1,2] -> [1][2]
# 转换连续引用: [5-8] -> [5][6][7][8]
# 成功转换 2 个连续引用为单独引用
# 发现引用编号: [1, 2, 3, 5, 6, 7, 8, 9]
# 为引用 [1] 创建书签: _Ref_Auto_1
# 转换统计: 共发现 8 个不同的引用编号，成功转换 12 处
```

### 示例 4：批量处理

```bash
# 在包含多个docx文件的目录中批量处理
for file in *.docx; do
    ezxref "$file"
done
```

### 示例 5：带详细信息的批量处理

```bash
# 批量处理并显示每个文件的详细信息
for file in *.docx; do
    echo "处理文件: $file"
    ezxref -i "$file"
    echo "---"
done
```

## 注意事项

### 使用前准备

1. **备份原文档**: 虽然工具不会修改原文件，但建议先备份重要文档
2. **检查文档格式**: 确保文档中包含"参考文献"标题部分
3. **引用格式确认**: 确认文档中的引用使用方括号格式，如 `[1]`、`[1,2]` 等

### 文档要求

1. **参考文献部分**: 文档必须包含"参考文献"标题
2. **编号列表**: 参考文献应使用Word的自动编号功能
3. **引用格式**: 正文中的引用应使用方括号格式

### 转换后操作

1. **更新字段**: 转换完成后，打开生成的文档并按 `F9` 更新所有字段
2. **检查格式**: 确认交叉引用显示正确
3. **样式调整**: 如需要，可调整交叉引用的样式（如上标等）

### 性能注意事项

- 大文档（超过100页）处理时间可能较长
- 建议在处理大文档时使用 `-i` 选项查看进度
- 如果参考文献数量很多（超过100个），处理时间会相应增加

## 疑难解答

### 常见问题

**问题：转换后交叉引用显示为 "错误!未找到引用源"**

解决方案：
```bash
# 转换完成后，在Word中按F9更新字段
# 或者在Word中：选择全部内容 → 右键 → 更新域
```

**问题：文档中没有检测到引用**

可能原因和解决方案：
1. 确认引用格式使用方括号：`[1]` 而不是 `(1)` 或其他格式
2. 检查是否存在"参考文献"标题
3. 使用 `-i` 选项查看详细检测信息

**问题：部分引用没有转换**

```bash
# 使用详细信息模式查看具体原因
ezxref -i 文档.docx

# 常见原因：
# 1. 引用已经是交叉引用格式
# 2. 引用在参考文献部分（工具会自动跳过）
# 3. 没有找到对应的参考文献条目
```

**问题：连续引用格式识别不准确**

```bash
# 检查支持的格式列表
ezxref -h

# 确认使用的是支持的分隔符：
# 逗号: [1,2]
# 中文逗号: [1，2]
# 顿号: [1、2]
# 短横线: [1-3]
# 长破折号: [1—3] 或 [1–3]
```

### 错误排查

**输入文件错误:**
```bash
# 错误: 文件 'xxx.docx' 不存在
# 解决: 检查文件路径是否正确

# 错误: 文件 'xxx.doc' 不是docx格式
# 解决: 将.doc文件另存为.docx格式
```

**权限错误:**
```bash
# 如果遇到权限问题，检查文件权限
ls -la 目标文件.docx

# 确保有读取权限，输出目录有写入权限
```

**Python环境问题:**
```bash
# 确认Python3已安装
python3 --version

# 确认ezxref可执行
which ezxref
```

### 高级用法

**自定义处理流程:**
```bash
# 1. 先检查文档结构
ezxref -i 论文.docx | grep "参考文献"

# 2. 如果需要，先手动整理参考文献格式

# 3. 执行转换
ezxref 论文.docx

# 4. 在Word中检查结果并更新字段
```

**与其他工具配合:**
```bash
# 与文档格式化工具配合使用
ezxref 原稿.docx 中间稿.docx
# 然后使用其他工具进一步处理中间稿.docx
```