#!/bin/bash
#
# ImmortalWrt / OpenWrt X86
# Industrial Stable DIY Part 1
#

echo "======================================="
echo " Industrial Stable DIY Part1 Start "
echo "======================================="

# =========================
# 清理高风险 feeds
# =========================

echo "Cleaning risky feeds..."

sed -i '/helloworld/d' feeds.conf.default
sed -i '/passwall/d' feeds.conf.default
sed -i '/passwall2/d' feeds.conf.default
sed -i '/small/d' feeds.conf.default
sed -i '/nas/d' feeds.conf.default

# =========================
# 删除可能冲突的 Argon
# =========================

echo "Removing old argon packages..."

rm -rf package/luci-theme-argon
rm -rf package/luci-app-argon-config

rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config

# =========================
# 重新拉取 Argon（稳定版）
# =========================

echo "Cloning Argon theme..."

git clone --depth=1 \
https://github.com/jerrykuku/luci-theme-argon.git \
package/luci-theme-argon

git clone --depth=1 \
https://github.com/jerrykuku/luci-app-argon-config.git \
package/luci-app-argon-config

# =========================
# 企业编译信息
# =========================

echo "Build date: $(date)" > build_info.txt

echo "======================================="
echo " DIY Part1 Done "
echo "======================================="
