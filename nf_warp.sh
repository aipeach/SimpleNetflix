#!/bin/bash
Font_Black="\033[30m"
Font_Red="\033[31m"
Font_Green="\033[32m"
Font_Yellow="\033[33m"
Font_Blue="\033[34m"
Font_Purple="\033[35m"
Font_SkyBlue="\033[36m"
Font_White="\033[37m"
Font_Suffix="\033[0m"

warp_port="${1:-40000}"

test_warp_ipv4() {
echo -e "${Font_Blue}WARP_Netflix：${Font_Suffix}"
    result=`curl -x socks5://127.0.0.1:${warp_port} --connect-timeout 10 -4sSL "https://www.netflix.com/" 2>&1`
    if [ "$result" == "Not Available" ];then
        echo -e "${Font_Red}很遗憾 Netflix不服务此地区${Font_Suffix}"
        return
    fi
    
    if [[ "$result" == "curl"* ]];then
        echo -e "${Font_Red}错误 无法连接到Netflix官网${Font_Suffix}"
        return
    fi
    
    result=`curl -x socks5://127.0.0.1:${warp_port} -4sL "https://www.netflix.com/title/80018499" 2>&1`
    if [[ "$result" == *"page-404"* ]] || [[ "$result" == *"NSEZ-403"* ]];then
        echo -e "${Font_Red}很遗憾 WARP_IP不能看Netflix${Font_Suffix}"
        return
    fi
    
    result1=`curl -x socks5://127.0.0.1:${warp_port} -4sL "https://www.netflix.com/title/70143836" 2>&1`
    result2=`curl -x socks5://127.0.0.1:${warp_port} -4sL "https://www.netflix.com/title/80027042" 2>&1`
    result3=`curl -x socks5://127.0.0.1:${warp_port} -4sL "https://www.netflix.com/title/70140425" 2>&1`
    result4=`curl -x socks5://127.0.0.1:${warp_port} -4sL "https://www.netflix.com/title/70283261" 2>&1`
    result5=`curl -x socks5://127.0.0.1:${warp_port} -4sL "https://www.netflix.com/title/70143860" 2>&1`
    result6=`curl -x socks5://127.0.0.1:${warp_port} -4sL "https://www.netflix.com/title/70202589" 2>&1`
    
    if [[ "$result1" == *"page-404"* ]] && [[ "$result2" == *"page-404"* ]] && [[ "$result3" == *"page-404"* ]] && [[ "$result4" == *"page-404"* ]] && [[ "$result5" == *"page-404"* ]] && [[ "$result6" == *"page-404"* ]];then
        echo -e "${Font_Yellow}WARP_IP可以打开Netflix 但是仅解锁自制剧${Font_Suffix}"
        return
    fi
    #奈飞IPV4区域测试
    region=`tr [:lower:] [:upper:] <<< $(curl -x socks5://127.0.0.1:${warp_port} -4is "https://www.netflix.com/title/80018499" 2>&1 | sed -n '8p' | awk '{print $2}' | cut -d '/' -f4 | cut -d '-' -f1)` 

    if [[ "$region" == *"INDEX"* ]];then
       region="US"
    fi

    echo -e "${Font_Green}恭喜 WARP_IP可以打开Netflix 并解锁全部流媒体 区域: ${region}${Font_Suffix}"
    return
}

if systemctl is-active warp-svc ;then
    curl -x "socks5://127.0.0.1:${warp_port}" ip.p3terx.com -4sL -o /dev/nul 2>&1
    if [ $? -eq 0 ]; then
        test_warp_ipv4
    else
        echo -e "${Font_Red}已安装WARP Linux 客户端,但未打开S5端口${Font_Suffix}"
    fi
    
    else
        echo -e "${Font_Red}未安装WARP Linux 客户端${Font_Suffix}"
fi
