#!/bin/bash

echo "========================="
echo "Industrial OpenWrt Tweaks"
echo "========================="

# =========================
# 1. IP 修改（安全写法）
# =========================
BASEFILE="package/base-files/files/bin/config_generate"
[ -f "$BASEFILE" ] && sed -i 's/192.168.1.1/192.168.10.1/g' "$BASEFILE"

# =========================
# 2. 主机名
# =========================
[ -f "$BASEFILE" ] && sed -i 's/OpenWrt/企业级路由器/g' "$BASEFILE"
[ -f "$BASEFILE" ] && sed -i 's/ImmortalWrt/企业级路由器/g' "$BASEFILE"

# =========================
# 3. Argon fallback patch（更稳定）
# =========================
MAKEFILE="feeds/luci/collections/luci/Makefile"
if [ -f "$MAKEFILE" ]; then
    sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' "$MAKEFILE" || true
fi

# =========================
# 4. UCI 默认设置（修复版）
# =========================
mkdir -p files/etc/uci-defaults

cat > files/etc/uci-defaults/99-default-settings <<'EOF'
#!/bin/sh

uci set system.@system[0].hostname='企业级路由器'
uci commit system

exit 0
EOF

chmod +x files/etc/uci-defaults/99-default-settings

# =========================
# 5. LuCI 标题（安全修改）
# =========================
JSON="feeds/luci/modules/luci-base/root/usr/share/luci/menu.d/luci-base.json"
[ -f "$JSON" ] && sed -i 's/OpenWrt/企业级路由器/g' "$JSON" || true

# =========================
# 6. Argon footer（不覆盖源码，只提示风格）
# =========================
echo "Argon footer kept upstream safe mode"

echo "========================="
echo "Done"
echo "========================="
