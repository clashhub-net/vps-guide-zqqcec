#!/usr/bin/env bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}  mihomo (Clash Meta) 一键安装${NC}"
echo -e "${BLUE}========================================${NC}"
VER="v1.18.0"; ARCH="$(uname -m)"
if [ "${ARCH}" = "x86_64" ]; then MACH="linux-amd64-intel"; else MACH="linux-arm64"; fi
echo -e "${YELLOW}[下载] mihomo ${VER}${NC}"
curl -sL "https://github.com/MetaCubeX/mihomo/releases/download/${VER}/mihomo-${MACH}-${VER}.gz" -o /tmp/mihomo.gz
gunzip -f /tmp/mihomo.gz -c > /usr/local/bin/mihomo && chmod +x /usr/local/bin/mihomo
mkdir -p /etc/mihomo
cat > /etc/mihomo/config.yaml <<'CONF'
mixed-port: 7890
allow-lan: false
mode: rule
log-level: info
external-controller: 0.0.0.0:9090
CONF
cat > /etc/systemd/system/mihomo.service <<'EOF'
[Unit]Description=mihomo After=network-online.target
[Service]Type=simple ExecStart=/usr/local/bin/mihomo -d /etc/mihomo Restart=on-failure RestartSec=5
[Install]WantedBy=multi-user.target
EOF
systemctl daemon-reload && systemctl enable --now mihomo
echo -e "${GREEN}[成功] mihomo 已启动${NC}"
echo -e "${BLUE}========================================${NC}"
echo "  管理面板: http://<IP>:9090/ui"
