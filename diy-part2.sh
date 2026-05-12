#!/bin/bash
#
# ImmortalWrt X86 Enterprise
# DIY Part 2
#

echo "========================="
echo "开始执行企业版定制..."
echo "========================="

# 修改默认 IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 修改主机名
sed -i 's/ImmortalWrt/企业级路由器/g' package/base-files/files/bin/config_generate

# 修改默认主题为 Argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 创建默认配置目录
mkdir -p files/etc/uci-defaults

# 设置默认登录信息
cat > files/etc/uci-defaults/99-default-settings <<'EOF'
#!/bin/sh

# 设置默认主题
uci set luci.main.mediaurlbase='/luci-static/argon'

# 设置默认语言
uci set luci.main.lang='zh_cn'

# 设置默认主机名
uci set system.@system[0].hostname='企业级路由器'

# 提交配置
uci commit luci
uci commit system

exit 0
EOF

chmod +x files/etc/uci-defaults/99-default-settings

# 修改 Argon 页脚
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
            ｜ 企业级路由器 IMM20260511
        </span>
    </div>
</footer>
EOF

fi

echo "========================="
echo "企业版定制完成"
echo "========================="
