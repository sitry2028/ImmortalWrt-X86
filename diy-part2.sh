#!/bin/bash
#
# ImmortalWrt X86 Enterprise Stable DIY Part 2
#

echo "========================="
echo "开始执行企业版定制..."
echo "========================="

# =========================
# 1. 默认 IP（稳定）
# =========================
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# =========================
# 2. 主机名（兼容所有版本）
# =========================
sed -i 's/OpenWrt/企业级路由器/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/企业级路由器/g' package/base-files/files/bin/config_generate

# =========================
# 3. 默认主题 Argon
# =========================
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# =========================
# 4. UCI 默认初始化（安全版）
# =========================
mkdir -p files/etc/uci-defaults

cat > files/etc/uci-defaults/99-default-settings <<'EOF'
#!/bin/sh

uci set system.@system[0].hostname='企业级路由器' 2>/dev/null
uci commit system 2>/dev/null

exit 0
EOF

chmod +x files/etc/uci-defaults/99-default-settings

# =========================
# 5. Argon 页脚（安全 patch）
# =========================
ARGO_FOOTER="feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer.htm"

if [ -f "$ARGO_FOOTER" ]; then
    sed -i 's|Powered by LuCI|东莞市杰迪电子科技 | 企业级路由器 IMM20260511|g' "$ARGO_FOOTER"
fi

echo "========================="
echo "企业版定制完成"
echo "========================="
