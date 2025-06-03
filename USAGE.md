# ezvllm 使用指南

`ezvllm` 是一个简化 vLLM 服务管理的命令行工具，支持快速启动模型服务、交互式聊天、服务状态检查和灵活的配置管理。

## 目录

- [ezvllm 使用指南](#ezvllm-使用指南)
  - [目录](#目录)
  - [安装](#安装)
  - [基本用法](#基本用法)
  - [命令详解](#命令详解)
    - [serve - 启动服务](#serve---启动服务)
    - [chat - 与模型对话](#chat---与模型对话)
    - [check - 检查服务状态](#check---检查服务状态)
    - [config - 管理配置](#config---管理配置)
  - [配置文件](#配置文件)
  - [实用示例](#实用示例)
  - [疑难解答](#疑难解答)

## 安装

使用安装脚本进行安装：

```bash
# 克隆仓库
git clone https://github.com/yourusername/cdy-tools.git
cd cdy-tools

# 运行安装脚本
./init.sh

# 使配置生效
source ~/.zshrc  # 或 source ~/.bashrc
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
- `-g, --gpu-id ID` - 指定要使用的 GPU ID，默认为 "0"
- `-m, --model-name NAME` - 指定模型名称，默认为 "Qwen/Qwen3-4B"
- `-k, --api-key KEY` - 指定 API 密钥，默认为 "1205"
- `-p, --port PORT` - 指定服务端口，默认为 "8009"
- `-l, --max-model-len LEN` - 指定最大模型长度，默认不限制
- `-u, --gpu-util UTIL` - 指定 GPU 利用率，默认为 "0.9"
- `-d, --disable-function` - 禁用函数调用功能
- `-v, --vllm-args "ARGS"` - 传递额外参数给 vllm serve 命令

**示例：**

```bash
# 使用默认配置启动服务
ezvllm serve

# 指定模型和端口
ezvllm serve -m "meta-llama/Llama-2-7b-chat-hf" -p 8008

# 使用 1 号 GPU 并限制 GPU 利用率
ezvllm serve -g 1 -u 0.8

# 限制最大模型长度
ezvllm serve -l 2048

# 传递额外参数给 vllm
ezvllm serve -v "--tensor-parallel-size 2 --quantization awq"
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
- `GPU_ID` - 使用的 GPU ID
- `MODEL_NAME` - 模型名称
- `API_KEY` - API 密钥
- `PORT` - 服务端口
- `MAX_MODEL_LEN` - 最大模型长度
- `GPU_UTIL` - GPU 利用率
- `DISABLE_FUNCTION_CALL` - 是否禁用函数调用
- `SYSTEM_PROMPT` - 默认系统提示词
- `TEMPERATURE` - 生成温度

## 实用示例

**快速启动一个本地模型并聊天：**

```bash
# 启动服务
ezvllm serve -m "/path/to/local/model"

# 在新终端中启动聊天
ezvllm chat -s "你是一个友好的助手"
```

**设置默认配置并使用：**

```bash
# 设置默认模型和端口
ezvllm config set MODEL_NAME="Qwen/Qwen3-7B"
ezvllm config set PORT="8888"

# 使用默认设置启动
ezvllm serve
```

**运行多个模型实例：**

```bash
# 在不同端口启动不同模型
ezvllm serve -m "Qwen/Qwen3-4B" -p 8001 -g 0
ezvllm serve -m "meta-llama/Llama-2-7b-chat-hf" -p 8002 -g 1

# 与特定实例聊天
ezvllm chat -p 8002
```

## 疑难解答

**服务无法启动：**

- 检查 conda 环境是否正确安装了 vLLM
- 验证 GPU 是否可用
- 确认模型路径是否正确

**API 连接失败：**

- 确认服务正在运行: `ezvllm check`
- 检查端口是否正确
- 检查 API 密钥是否匹配

**模型加载过慢：**

- 考虑减小 `MAX_MODEL_LEN` 值
- 调整 `GPU_UTIL` 参数
- 使用量化版本的模型
