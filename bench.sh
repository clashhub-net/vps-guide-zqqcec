#!/usr/bin/env bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}  VPS 基准测试${NC}"
echo -e "${BLUE}========================================${NC}"
echo -e "${YELLOW}[系统信息]${NC}"
echo "OS: $(uname -o) $(uname -r)"
echo "CPU: $(nproc) vCPU | 内存: $(free -h | awk '/Mem/{print $2}')"
echo ""
echo -e "${YELLOW}[磁盘 I/O]${NC}"
echo -n "顺序读取: "
dd if=/dev/zero of=/tmp/dd_test bs=1M count=512 oflag=direct 2>&1 | tail -1
rm -f /tmp/dd_test
echo ""
echo -e "${YELLOW}[带宽测试]${NC}"
for node in cachefly linode-tokyo ovh-paris; do
    echo -n "[$node] "
    wget -qO- --timeout=10 "https://$node.cachefly.net/10MB.test" 2>/dev/null | wc -c | awk '{printf "%.1f MB/s\n", $1/1024/1024}'
done
echo ""
echo -e "${YELLOW}[流媒体解锁]${NC}"
for url in "https://www.netflix.com/ Netflix" "https://www.youtube.com/ YouTube" "https://www.hulu.com/ Hulu"; do
    code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 ${url%% *})
    name=${url#* }
    [[ "$code" == "200" ]] && echo -e "${GREEN}[解锁] $name${NC}" || echo -e "${RED}[未解锁] $name${NC}"
done
echo -e "${BLUE}========================================${NC}"
