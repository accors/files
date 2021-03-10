#!/bin/bash
## 1.拉源码
git clone -b mbedtls-armv8 https://github.com/1715173329/lede
## 2.改feed，添加config
cd lede
rm feeds.conf.default
wget https://raw.githubusercontent.com/accors/arm_openwrt/main/feeds.conf.default
wget -O .config https://raw.githubusercontent.com/accors/files/main/coretex-a53-r21.2.1-20210305-huge-flowoffload.config
make defconfig
## 3.更新feed和安装feed，下载软件包
./scripts/feeds update -a && ./scripts/feeds install -a
make -j8 download V=s
## 4.开始编译固件
make -j1 V=s