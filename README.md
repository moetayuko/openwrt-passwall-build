# openwrt-passwall-build

Binary distribution of [xiaorouji/openwrt-passwall](https://github.com/xiaorouji/openwrt-passwall) built with official OpenWRT SDK.

[![Build and Release](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/build-release.yml/badge.svg)](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/build-release.yml)
[![Scan openwrt-passwall Version](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/version-scan.yml/badge.svg)](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/version-scan.yml)
![GitHub repo size](https://img.shields.io/github/repo-size/dianlujitao/openwrt-passwall-build)

## Install via OPKG

1. Add new opkg key:

```sh
wget https://dianlujitao.github.io/openwrt-passwall-build/passwall.pub
opkg-key add passwall.pub
```

2. Add opkg repository:

```sh
echo "src/gz passwall https://dianlujitao.github.io/openwrt-passwall-build/releases/$(. /etc/openwrt_release ; echo $DISTRIB_RELEASE)/packages/$(. /etc/openwrt_release ; echo $DISTRIB_ARCH)/passwall" \
  >> /etc/opkg/customfeeds.conf
```

> Replace `https://dianlujitao.github.io/openwrt-passwall-build` with:
> * `https://cdn.jsdelivr.net/gh/dianlujitao/openwrt-passwall-build@gh-pages`
> * `https://ghproxy.com/https://raw.githubusercontent.com/dianlujitao/openwrt-passwall-build/gh-pages`
>
> to speed up in China. Be aware that they might not be up-to-date.

3. Install package:

```sh
opkg update
opkg install luci-app-passwall
```

## Manual Install

- Download pre build ipk file from [gh-pages branch](https://github.com/dianlujitao/openwrt-passwall-build/tree/gh-pages).

- Upload file to your router, install it with ssh command.

```sh
opkg install luci-app-passwall*.ipk
```

## Acknowledgement

This project is heavily inspired by [kuoruan/openwrt-v2ray](https://github.com/kuoruan/openwrt-v2ray).
