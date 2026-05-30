#!/usr/bin/env bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}  BBR 加速一键安装${NC}"
echo -e "${BLUE}========================================${NC}"
if [[ $(cat /proc/sys/net/ipv4/tcp_congestion_control) == "bbr" ]]; then
    echo -e "${GREEN}[OK] BBR 已开启${NC}"
else
    echo -e "${YELLOW}[安装] BBR...${NC}"
    echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
    echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
    sysctl -p > /dev/null 2>&1
    sysctl net.ipv4.tcp_congestion_control | grep -q bbr         && echo -e "${GREEN}[成功] BBR 已启用${NC}"         || echo -e "${RED}[失败]${NC}"
fi
echo -e "${BLUE}========================================${NC}"
echo -e "${YELLOW}建议重启 VPS 使配置生效: reboot${NC}"
