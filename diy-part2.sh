#!/bin/bash
#
# OpenWrt X86 Enterprise Stable DIY Part 2
#

echo "========================="
echo "开始执行企业版定制..."
echo "========================="

# =========================
# 1. 默认 IP 修改
# =========================
CONFIG_FILE="package/base-files/files/bin/config_generate"
[ -f "$CONFIG_FILE" ] && sed -i 's/192.168.1.1/192.168.10.1/g' "$CONFIG_FILE"

# =========================
# 2. 默认主机名修改
# =========================
[ -f "$CONFIG_FILE" ] && sed -i -e 's/OpenWrt/企业级路由器/g' -e 's/ImmortalWrt/企业级路由器/g' "$CONFIG_FILE"

# =========================
# 3. 默认 Argon 主题
# =========================
LUCIFILE="feeds/luci/collections/luci/Makefile"
[ -f "$LUCIFILE" ] && sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' "$LUCIFILE"

# =========================
# 4. 创建默认配置目录
# =========================
mkdir -p files/etc/uci-defaults

# =========================
# 5. 默认系统配置
# =========================
cat > files/etc/uci-defaults/99-default-settings <<'EOF'
#!/bin/sh

# 主机名
uci set system.@system[0].hostname='企业级路由器'

# 默认语言
uci set luci.main.lang='zh_cn'

# 默认主题
uci set luci.main.mediaurlbase='/luci-static/argon'

# 提交配置
uci commit system
uci commit luci

exit 0
EOF
chmod 755 files/etc/uci-defaults/99-default-settings

# =========================
# 6. 浏览器标题优化
# =========================
LOGIN_JSON="feeds/luci/modules/luci-base/root/usr/share/luci/menu.d/luci-base.json"
[ -f "$LOGIN_JSON" ] && sed -i 's/OpenWrt/企业级路由器/g' "$LOGIN_JSON"

# =========================
# 7. Argon 页脚企业信息
# =========================
ARGO_FOOTER="feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer.htm"
if [ -f "$ARGO_FOOTER" ]; then
cat > "$ARGO_FOOTER" <<'EOF'
<%
local ver = require "luci.version"
%>

<footer class="mobile-hide">
    <div class="footer">
        <a href="http://www.kocod.cn" target="_blank">
            东莞市杰迪电子科技
        </a>
        <span>
            ｜ 企业级路由器 IMM20260512
        </span>
    </div>
</footer>
EOF
fi

echo "========================="
echo "企业版定制完成"
echo "========================="
