#!/bin/bash
#
# ImmortalWrt X86 Enterprise Stable Build (Clean Mode)
# DIY Part 1
#

echo "==== Clean feeds (safe mode) ===="

# 更安全的去冲突方式（避免 sed 无效）
cp feeds.conf.default feeds.conf.bak

grep -v "helloworld" feeds.conf.bak > feeds.conf.default
grep -v "passwall" feeds.conf.default > feeds.conf.tmp && mv feeds.conf.tmp feeds.conf.default
grep -v "passwall2" feeds.conf.default > feeds.conf.tmp && mv feeds.conf.tmp feeds.conf.default

echo "==== Add base UI packages ===="

# Argon 主题（企业UI基础）
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

# Argon 控制面板
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

echo "==== DIY part1 done ===="
