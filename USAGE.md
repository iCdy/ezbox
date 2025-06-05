# 工具使用指南

本文档提供了所有工具的详细使用说明。

## 目录

- [工具使用指南](#工具使用指南)
  - [目录](#目录)
- [ezvllm - vLLM 服务管理工具](#ezvllm---vllm-服务管理工具)
  - [ezvllm 目录](#ezvllm-目录)
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
- [ezproxy - 代理设置管理工具](#ezproxy---代理设置管理工具)
  - [ezproxy 目录](#ezproxy-目录)
  - [安装](#安装-1)
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
    - [场景 5：Jupyter Notebook 代理配置](#场景-5jupyter-notebook-代理配置)
  - [疑难解答](#疑难解答-1)

---

# ezvllm - vLLM 服务管理工具

`ezvllm` 是一个简化 vLLM 服务管理的命令行工具，支持快速启动模型服务、交互式聊天、服务状态检查和灵活的配置管理。

## ezvllm 目录

- [工具使用指南](#工具使用指南)
  - [目录](#目录)
- [ezvllm - vLLM 服务管理工具](#ezvllm---vllm-服务管理工具)
  - [ezvllm 目录](#ezvllm-目录)
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
- [ezproxy - 代理设置管理工具](#ezproxy---代理设置管理工具)
  - [ezproxy 目录](#ezproxy-目录)
  - [安装](#安装-1)
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
    - [场景 5：Jupyter Notebook 代理配置](#场景-5jupyter-notebook-代理配置)
  - [疑难解答](#疑难解答-1)

## 安装

使用安装脚本进行安装：

```bash
# 克隆仓库
git clone https://github.com/iCdy/shell.git
cd shell

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

---

# ezproxy - 代理设置管理工具

`ezproxy` 是一个轻量级的代理设置管理工具，专为通过 SSH 连接时快速配置网络代理而设计。它能自动检测 SSH 客户端 IP，支持灵活的端口配置，并提供配置持久化功能。

## ezproxy 目录

- [工具使用指南](#工具使用指南)
  - [目录](#目录)
- [ezvllm - vLLM 服务管理工具](#ezvllm---vllm-服务管理工具)
  - [ezvllm 目录](#ezvllm-目录)
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
- [ezproxy - 代理设置管理工具](#ezproxy---代理设置管理工具)
  - [ezproxy 目录](#ezproxy-目录)
  - [安装](#安装-1)
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
    - [场景 5：Jupyter Notebook 代理配置](#场景-5jupyter-notebook-代理配置)
  - [疑难解答](#疑难解答-1)

## 安装

使用安装脚本进行安装：

```bash
# 克隆仓库
git clone https://github.com/iCdy/shell.git
cd shell

# 运行安装脚本
./init.sh

# 使配置生效
source ~/.zshrc  # 或 source ~/.bashrc
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
- `-p PORT` - 指定代理服务器的端口号

```bash
# 指定特定的代理服务器
source ezproxy -i 192.168.1.100 -p 8080

# 只指定端口，IP 自动检测
source ezproxy -p 1080

# 只指定IP，使用默认端口
source ezproxy -i 10.0.0.1
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

- `-r` - 取消当前会话的代理设置
- `-g` - 设置 Git 代理（仅影响 Git 操作）
- `-j` - 显示 Jupyter Notebook 代理设置代码
- `-v` - 显示版本信息
- `-h` - 显示帮助信息

```bash
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
# 启用代理
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

### 场景 5：Jupyter Notebook 代理配置

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