start_singbox() {
    check_singbox
    if [[ $? -eq 1 ]]; then
        yellow "正在启动 ${server_name} 服务\n"
        
        if command -v systemctl &>/dev/null; then
            systemctl daemon-reload
            systemctl start "${server_name}"
            if [ $? -eq 0 ]; then
                green "${server_name} 服务已成功启动\n"
            else
                red "${server_name} 服务启动失败\n"
            fi
        elif command -v rc-service &>/dev/null; then
            rc-service "${server_name}" start
            if [ $? -eq 0 ]; then
                green "${server_name} 服务已成功启动\n"
            else
                red "${server_name} 服务启动失败\n"
            fi
        else
            red "不支持的初始化系统!\n"
            exit 1
        fi
    elif [[ $? -eq 0 ]]; then
        yellow "sing-box 正在运行\n"
        sleep 1
    else
        yellow "sing-box 尚未安装!\n"
        sleep 1
    fi
}
