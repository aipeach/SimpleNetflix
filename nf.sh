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

test_ipv4() {
echo -e "Netflix："
    result=`curl --connect-timeout 10 -4sSL "https://www.netflix.com/" 2>&1`
    if [ "$result" == "Not Available" ];then
        echo -e "${Font_Red}很遗憾 Netflix不服务此地区${Font_Suffix}"
        return
    fi
    
    if [[ "$result" == "curl"* ]];then
        echo -e "${Font_Red}错误 无法连接到Netflix官网${Font_Suffix}"
        return
    fi
    
    result=`curl -4sL "https://www.netflix.com/title/80018499" 2>&1`
    if [[ "$result" == *"page-404"* ]] || [[ "$result" == *"NSEZ-403"* ]];then
        echo -e "${Font_Red}很遗憾 你的IP不能看Netflix${Font_Suffix}"
        return
    fi
    
    result1=`curl -4sL "https://www.netflix.com/title/70143836" 2>&1`
    result2=`curl -4sL "https://www.netflix.com/title/80027042" 2>&1`
    result3=`curl -4sL "https://www.netflix.com/title/70140425" 2>&1`
    result4=`curl -4sL "https://www.netflix.com/title/70283261" 2>&1`
    result5=`curl -4sL "https://www.netflix.com/title/70143860" 2>&1`
    result6=`curl -4sL "https://www.netflix.com/title/70202589" 2>&1`
    
    if [[ "$result1" == *"page-404"* ]] && [[ "$result2" == *"page-404"* ]] && [[ "$result3" == *"page-404"* ]] && [[ "$result4" == *"page-404"* ]] && [[ "$result5" == *"page-404"* ]] && [[ "$result6" == *"page-404"* ]];then
        echo -e "${Font_Yellow}你的IP可以打开Netflix 但是仅解锁自制剧${Font_Suffix}"
        return
    fi
    #奈飞IPV4区域测试
    region=`tr [:lower:] [:upper:] <<< $(curl -4is "https://www.netflix.com/title/80018499" 2>&1 | sed -n '8p' | awk '{print $2}' | cut -d '/' -f4 | cut -d '-' -f1)` 

    if [[ "$region" == *"INDEX"* ]];then
       region="US"
    fi

    echo -e "${Font_Green}恭喜 你的IP可以打开Netflix 并解锁全部流媒体 区域: ${region}${Font_Suffix}"
    return
}

test_ipv6() {
echo -e "Netflix："
    result=`curl --connect-timeout 10 -6sSL "https://www.netflix.com/" 2>&1`
    if [ "$result" == "Not Available" ];then
        echo -e "${Font_Red}很遗憾 Netflix不服务此地区${Font_Suffix}"
        return
    fi
    
    if [[ "$result" == "curl"* ]];then
        echo -e "${Font_Red}错误 无法连接到Netflix官网${Font_Suffix}"
        return
    fi
    
    result=`curl -6sL "https://www.netflix.com/title/80018499" 2>&1`
    if [[ "$result" == *"page-404"* ]] || [[ "$result" == *"NSEZ-403"* ]];then
        echo -e "${Font_Red}很遗憾 你的IP不能看Netflix${Font_Suffix}"
        return
    fi
    
    result1=`curl -6sL "https://www.netflix.com/title/70143836" 2>&1`
    result2=`curl -6sL "https://www.netflix.com/title/80027042" 2>&1`
    result3=`curl -6sL "https://www.netflix.com/title/70140425" 2>&1`
    result4=`curl -6sL "https://www.netflix.com/title/70283261" 2>&1`
    result5=`curl -6sL "https://www.netflix.com/title/70143860" 2>&1`
    result6=`curl -6sL "https://www.netflix.com/title/70202589" 2>&1`
    
    if [[ "$result1" == *"page-404"* ]] && [[ "$result2" == *"page-404"* ]] && [[ "$result3" == *"page-404"* ]] && [[ "$result4" == *"page-404"* ]] && [[ "$result5" == *"page-404"* ]] && [[ "$result6" == *"page-404"* ]];then
        echo -e "${Font_Yellow}你的IP可以打开Netflix 但是仅解锁自制剧${Font_Suffix}"
        return
    fi
    #奈飞IPV6区域测试
    region=`tr [:lower:] [:upper:] <<< $(curl -6is "https://www.netflix.com/title/80018499" 2>&1 | sed -n '8p' | awk '{print $2}' | cut -d '/' -f4 | cut -d '-' -f1)`
    if [[ "$region" == *"INDEX"* ]];then
       region="US"
    fi
    
    echo -e "${Font_Green}恭喜 你的IP可以打开Netflix 并解锁全部流媒体 区域: ${region}${Font_Suffix}"
    return
}

test_warp_ipv4() {
echo -e "${Font_Blue}WARP_Netflix：${Font_Suffix}"
    result=`curl -x socks5://127.0.0.1:40000 --connect-timeout 10 -4sSL "https://www.netflix.com/" 2>&1`
    if [ "$result" == "Not Available" ];then
        echo -e "${Font_Red}很遗憾 Netflix不服务此地区${Font_Suffix}"
        return
    fi
    
    if [[ "$result" == "curl"* ]];then
        echo -e "${Font_Red}错误 无法连接到Netflix官网${Font_Suffix}"
        return
    fi
    
    result=`curl -x socks5://127.0.0.1:40000 -4sL "https://www.netflix.com/title/80018499" 2>&1`
    if [[ "$result" == *"page-404"* ]] || [[ "$result" == *"NSEZ-403"* ]];then
        echo -e "${Font_Red}很遗憾 WARP_IP不能看Netflix${Font_Suffix}"
        return
    fi
    
    result1=`curl -x socks5://127.0.0.1:40000 -4sL "https://www.netflix.com/title/70143836" 2>&1`
    result2=`curl -x socks5://127.0.0.1:40000 -4sL "https://www.netflix.com/title/80027042" 2>&1`
    result3=`curl -x socks5://127.0.0.1:40000 -4sL "https://www.netflix.com/title/70140425" 2>&1`
    result4=`curl -x socks5://127.0.0.1:40000 -4sL "https://www.netflix.com/title/70283261" 2>&1`
    result5=`curl -x socks5://127.0.0.1:40000 -4sL "https://www.netflix.com/title/70143860" 2>&1`
    result6=`curl -x socks5://127.0.0.1:40000 -4sL "https://www.netflix.com/title/70202589" 2>&1`
    
    if [[ "$result1" == *"page-404"* ]] && [[ "$result2" == *"page-404"* ]] && [[ "$result3" == *"page-404"* ]] && [[ "$result4" == *"page-404"* ]] && [[ "$result5" == *"page-404"* ]] && [[ "$result6" == *"page-404"* ]];then
        echo -e "${Font_Yellow}WARP_IP可以打开Netflix 但是仅解锁自制剧${Font_Suffix}"
        return
    fi
    #奈飞IPV4区域测试
    region=`tr [:lower:] [:upper:] <<< $(curl -x socks5://127.0.0.1:40000 -4is "https://www.netflix.com/title/80018499" 2>&1 | sed -n '8p' | awk '{print $2}' | cut -d '/' -f4 | cut -d '-' -f1)` 

    if [[ "$region" == *"INDEX"* ]];then
       region="US"
    fi

    echo -e "${Font_Green}恭喜 WARP_IP可以打开Netflix 并解锁全部流媒体 区域: ${region}${Font_Suffix}"
    return
}

test_warp_ipv6() {
echo -e "${Font_Blue}WARP_Netflix：${Font_Suffix}"
    result=`curl -x socks5://127.0.0.1:40000 --connect-timeout 10 -6sSL "https://www.netflix.com/" 2>&1`
    if [ "$result" == "Not Available" ];then
        echo -e "${Font_Red}很遗憾 Netflix不服务此地区${Font_Suffix}"
        return
    fi
    
    if [[ "$result" == "curl"* ]];then
        echo -e "${Font_Red}错误 无法连接到Netflix官网${Font_Suffix}"
        return
    fi
    
    result=`curl -x socks5://127.0.0.1:40000 -6sL "https://www.netflix.com/title/80018499" 2>&1`
    if [[ "$result" == *"page-404"* ]] || [[ "$result" == *"NSEZ-403"* ]];then
        echo -e "${Font_Red}很遗憾 WARP_IP不能看Netflix${Font_Suffix}"
        return
    fi
    
    result1=`curl -x socks5://127.0.0.1:40000 -6sL "https://www.netflix.com/title/70143836" 2>&1`
    result2=`curl -x socks5://127.0.0.1:40000 -6sL "https://www.netflix.com/title/80027042" 2>&1`
    result3=`curl -x socks5://127.0.0.1:40000 -6sL "https://www.netflix.com/title/70140425" 2>&1`
    result4=`curl -x socks5://127.0.0.1:40000 -6sL "https://www.netflix.com/title/70283261" 2>&1`
    result5=`curl -x socks5://127.0.0.1:40000 -6sL "https://www.netflix.com/title/70143860" 2>&1`
    result6=`curl -x socks5://127.0.0.1:40000 -6sL "https://www.netflix.com/title/70202589" 2>&1`
    
    if [[ "$result1" == *"page-404"* ]] && [[ "$result2" == *"page-404"* ]] && [[ "$result3" == *"page-404"* ]] && [[ "$result4" == *"page-404"* ]] && [[ "$result5" == *"page-404"* ]] && [[ "$result6" == *"page-404"* ]];then
        echo -e "${Font_Yellow}WARP_IP可以打开Netflix 但是仅解锁自制剧${Font_Suffix}"
        return
    fi
    #奈飞IPV6区域测试
    region=`tr [:lower:] [:upper:] <<< $(curl -x socks5://127.0.0.1:40000 -6is "https://www.netflix.com/title/80018499" 2>&1 | sed -n '8p' | awk '{print $2}' | cut -d '/' -f4 | cut -d '-' -f1)`
    if [[ "$region" == *"INDEX"* ]];then
       region="US"
    fi
    
    echo -e "${Font_Green}恭喜 WARP_IP可以打开Netflix 并解锁全部流媒体 区域: ${region}${Font_Suffix}"
    return
}

yt_ipv4(){
echo -e "YouTube："
   #油管IPV4区域测试
   area=$(curl --connect-timeout 10 -4s https://www.youtube.com/red | sed 's/,/\n/g' | grep countryCode | cut -d '"' -f4)
if [ ! -n "$area" ]; then
    echo -e "${Font_Yellow}你的油管角标不显示 可能不支持Premium${Font_Suffix}"
else
    echo -e "${Font_Green}你的油管角标: ${area}${Font_Suffix}"
fi
}
yt_ipv6(){
echo -e "YouTube："
   #油管IPV6区域测试
   area=$(curl --connect-timeout 10 -6s https://www.youtube.com/red | sed 's/,/\n/g' | grep countryCode | cut -d '"' -f4)
if [ ! -n "$area" ]; then
    echo -e "${Font_Yellow}你的油管角标不显示 可能不支持Premium${Font_Suffix}"   
else
    echo -e "${Font_Green}你的油管角标: ${area}${Font_Suffix}"
fi
}

yt_warp_ipv4(){
echo -e "${Font_Blue}WARP_YouTube：${Font_Suffix}"
   #油管IPV4区域测试
   area=$(curl -x socks5://127.0.0.1:40000 --connect-timeout 10 -4s https://www.youtube.com/red | sed 's/,/\n/g' | grep countryCode | cut -d '"' -f4)
if [ ! -n "$area" ]; then
    echo -e "${Font_Yellow}WARP_IP的油管角标不显示 可能不支持Premium${Font_Suffix}"
else
    echo -e "${Font_Green}WARP_IP的油管角标: ${area}${Font_Suffix}"
fi
}
yt_warp_ipv6(){
echo -e "${Font_Blue}WARP_YouTube：${Font_Suffix}"
   #油管IPV6区域测试
   area=$(curl -x socks5://127.0.0.1:40000 --connect-timeout 10 -6s https://www.youtube.com/red | sed 's/,/\n/g' | grep countryCode | cut -d '"' -f4)
if [ ! -n "$area" ]; then
    echo -e "${Font_Yellow}WARP_IP的油管角标不显示 可能不支持Premium${Font_Suffix}"   
else
    echo -e "${Font_Green}WARP_IP的油管角标: ${area}${Font_Suffix}"
fi
}

clear
echo -e "${Font_SkyBlue} 流媒体测试脚本 ${Font_Suffix}"
echo -e "${Font_SkyBlue} GitHub：https://github.com/missuo/SimpleNetflix ${Font_Suffix}"
echo "-------------------------------------"
echo " ** 正在测试 IPv4 解锁情况";
check4=`ping 1.1.1.1 -c 1 2>&1`;
if [[ "$check4" != *"received"* ]] && [[ "$check4" != *"transmitted"* ]];then
    echo -e "\033[31m当前主机不支持IPv4,跳过...\033[0m";
else
    test_ipv4
    yt_ipv4
fi
curl -x socks5://127.0.0.1:40000 ip.p3terx.com -4sL -o /dev/nul 2>&1
if [ $? -eq 0 ]; then
    test_warp_ipv4
    yt_warp_ipv4
fi
echo "====================================="
echo " ** 正在测试 IPv6 解锁情况";

check6=`ping6 240c::6666 -c 1 2>&1`;
if [[ "$check6" != *"received"* ]] && [[ "$check6" != *"transmitted"* ]];then
    echo -e "\033[31m当前主机不支持IPv6,跳过...\033[0m";    
    echo "-------------------------------------"
else
    test_ipv6
    yt_ipv6
fi
curl -x socks5://127.0.0.1:40000 ip.p3terx.com -6sL -o /dev/null 2>&1
if [ $? -eq 0 ]; then
    test_warp_ipv6
    yt_warp_ipv6
fi
echo "-------------------------------------"
