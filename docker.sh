#!/usr/bin/env bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}  Docker 一键安装${NC}"
echo -e "${BLUE}========================================${NC}"
if command -v docker &>/dev/null; then
    echo -e "${GREEN}[跳过] Docker 已安装: $(docker --version)${NC}"
else
    echo -e "${YELLOW}[安装] Docker${NC}"
    curl -fsSL https://get.docker.com | sh
    echo -e "${GREEN}[成功]${NC}"
fi
if ! command -v docker-compose &>/dev/null; then
    echo -e "${YELLOW}[安装] Docker Compose${NC}"
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    echo -e "${GREEN}[成功] Docker Compose: $(docker-compose --version)${NC}"
fi
echo -e "${BLUE}========================================${NC}"
