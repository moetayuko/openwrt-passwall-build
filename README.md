# openwrt-passwall-build

Binary distribution of [xiaorouji/openwrt-passwall](https://github.com/xiaorouji/openwrt-passwall) built with official OpenWRT SDK.

[![Build and Release](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/build-release.yml/badge.svg)](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/build-release.yml)
[![Scan openwrt-passwall Version](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/version-scan.yml/badge.svg)](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/version-scan.yml)

## Install via OPKG

1. Add new opkg key:

```sh
wget https://free.nchc.org.tw/osdn/storage/g/o/op/openwrt-passwall-build/passwall.pub
opkg-key add passwall.pub
```

2. Add opkg repository:

```sh
read release arch << EOF
$(. /etc/openwrt_release ; echo ${DISTRIB_RELEASE%.*} $DISTRIB_ARCH)
EOF
for feed in passwall_luci passwall_packages passwall2; do
  echo "src/gz $feed https://free.nchc.org.tw/osdn/storage/g/o/op/openwrt-passwall-build/releases/packages-$release/$arch/$feed" >> /etc/opkg/customfeeds.conf
done
```
OR
```sh
read arch << EOF
$(. /etc/openwrt_release ; echo $DISTRIB_ARCH)
EOF
for feed in passwall_luci passwall_packages passwall2; do
  echo "src/gz $feed https://free.nchc.org.tw/osdn/storage/g/o/op/openwrt-passwall-build/snapshots/packages/$arch/$feed" >> /etc/opkg/customfeeds.conf
done
```
in case you use a snapshot build.

> NCHC's mirror might not be up-to-date, download from `https://osdn.net/projects/openwrt-passwall-build/storage/` whenever necessary.

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
