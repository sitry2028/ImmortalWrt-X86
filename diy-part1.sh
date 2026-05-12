#!/bin/bash
#
# ImmortalWrt X86 Enterprise
# DIY Part 1
#

# 删除可能冲突的软件源
sed -i '/helloworld/d' feeds.conf.default
sed -i '/passwall/d' feeds.conf.default
sed -i '/passwall2/d' feeds.conf.default

# 添加 Argon 主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

# 添加 Argon 配置
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
