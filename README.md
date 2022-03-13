# openwrt-passwall-build

Binary distribution of [xiaorouji/openwrt-passwall](https://github.com/xiaorouji/openwrt-passwall) built with official OpenWRT SDK.

[![Build and Release](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/build-release.yml/badge.svg)](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/build-release.yml)
[![Scan openwrt-passwall Version](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/version-scan.yml/badge.svg)](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/version-scan.yml)

## Install via OPKG

1. Add new opkg key:

```sh
wget https://mirrors.tuna.tsinghua.edu.cn/osdn/storage/g/o/op/openwrt-passwall-build/passwall.pub
opkg-key add passwall.pub
```

2. Add opkg repository:

```sh
read release arch <<< $(. /etc/openwrt_release ; echo $DISTRIB_RELEASE $DISTRIB_ARCH)
cat << EOF >> /etc/opkg/customfeeds.conf
src/gz passwall_luci https://mirrors.tuna.tsinghua.edu.cn/osdn/storage/g/o/op/openwrt-passwall-build/releases/$release/packages/$arch/passwall_luci
src/gz passwall_packages https://mirrors.tuna.tsinghua.edu.cn/osdn/storage/g/o/op/openwrt-passwall-build/releases/$release/packages/$arch/passwall_packages
EOF
```

> TUNA's mirror might not be up-to-date, download from `https://osdn.net/projects/openwrt-passwall-build/storage/` whenever necessary.

3. Install package:

```sh
opkg update
opkg install luci-app-passwall
```

## Manual Install

- Download prebuilt ipk file from [OSDN](https://osdn.net/projects/openwrt-passwall-build/storage/).

- Upload file to your router, install it with ssh command.

```sh
opkg install luci-app-passwall*.ipk
```

## Acknowledgement

This project is heavily inspired by [kuoruan/openwrt-v2ray](https://github.com/kuoruan/openwrt-v2ray).
