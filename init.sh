#!/bin/bash

# 获取脚本所在目录的绝对路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

# 可用的脚本列表
AVAILABLE_SCRIPTS=("ezcmd" "ezname" "ezproxy" "ezvllm" "ezxref")

# 显示帮助信息
show_help() {
    echo "用法: init [选项] [脚本名...]"
    echo ""
    echo "选项:"
    echo "  .             安装所有可用脚本"
    echo "  --update      仅更新已安装的脚本"
    echo "  -h, --help    显示此帮助信息"
    echo ""
    echo "可用脚本: ${AVAILABLE_SCRIPTS[*]}"
    echo ""
    echo "示例:"
    echo "  init .                # 安装所有脚本"
    echo "  init ezvllm           # 安装单个脚本"
    echo "  init ezvllm ezproxy   # 安装多个脚本"
    echo "  init --update         # 更新已安装脚本"
}

# 配置环境
setup_environment() {
    mkdir -p "${HOME}/bin"
    if [ $? -ne 0 ]; then
        echo "错误: 无法创建目录 ${HOME}/bin，请检查权限"
        exit 1
    fi

    # 配置 .bashrc
    if ! grep -q "export PATH=\$HOME/bin:\$PATH" "$HOME/.bashrc" 2>/dev/null; then
        echo "export PATH=\$HOME/bin:\$PATH" >> "$HOME/.bashrc"
        echo "已添加环境变量到 .bashrc"
    fi

    # 配置 .zshrc (如果存在)
    if [ -f "$HOME/.zshrc" ]; then
        if ! grep -q "export PATH=\$HOME/bin:\$PATH" "$HOME/.zshrc"; then
            echo "export PATH=\$HOME/bin:\$PATH" >> "$HOME/.zshrc"
            echo "已添加环境变量到 .zshrc"
        fi
    fi
}

# 安装单个脚本
install_script() {
    local script="$1"
    local source_path="${SCRIPT_DIR}/${script}"
    local target_path="${HOME}/bin/${script}"
    
    if [ ! -f "$source_path" ]; then
        echo "错误: 脚本 $script 不存在于 $SCRIPT_DIR"
        return 1
    fi
    
    cp "$source_path" "$target_path"
    if [ $? -eq 0 ]; then
        chmod +x "$target_path"
        echo "$script 已安装到 $HOME/bin"
        return 0
    else
        echo "安装 $script 失败"
        return 1
    fi
}

# 检查脚本是否已安装
is_script_installed() {
    local script="$1"
    [ -f "${HOME}/bin/${script}" ]
}

# 获取已安装的脚本列表
get_installed_scripts() {
    local installed=()
    for script in "${AVAILABLE_SCRIPTS[@]}"; do
        if is_script_installed "$script"; then
            installed+=("$script")
        fi
    done
    echo "${installed[@]}"
}

# 安装指定的脚本
install_scripts() {
    local scripts=("$@")
    local success_count=0
    local total_count=${#scripts[@]}
    
    echo "开始安装脚本..."
    
    for script in "${scripts[@]}"; do
        # 检查脚本是否在可用列表中
        if [[ " ${AVAILABLE_SCRIPTS[@]} " =~ " ${script} " ]]; then
            if install_script "$script"; then
                ((success_count++))
            fi
        else
            echo "警告: $script 不在可用脚本列表中，跳过"
        fi
    done
    
    echo ""
    echo "安装完成: $success_count/$total_count 个脚本成功安装"
    
    if [ $success_count -gt 0 ]; then
        echo "请运行 'source ~/.bashrc' 或 'source ~/.zshrc' 以使更改生效"
        echo "或者重新打开终端"
    fi
}

# 更新已安装的脚本
update_scripts() {
    local installed_scripts=($(get_installed_scripts))
    
    if [ ${#installed_scripts[@]} -eq 0 ]; then
        echo "没有找到已安装的脚本"
        return 0
    fi
    
    echo "找到已安装的脚本: ${installed_scripts[*]}"
    install_scripts "${installed_scripts[@]}"
}

# 主函数
main() {
    # 没有参数时显示帮助
    if [ $# -eq 0 ]; then
        show_help
        exit 0
    fi
    
    # 首先设置环境
    setup_environment
    
    case "$1" in
        -h|--help)
            show_help
            ;;
        --update)
            update_scripts
            ;;
        .)
            echo "安装所有可用脚本..."
            install_scripts "${AVAILABLE_SCRIPTS[@]}"
            ;;
        *)
            # 安装指定的脚本
            install_scripts "$@"
            ;;
    esac
}

# 运行主函数
main "$@"


