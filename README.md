# openwrt-passwall-build

Binary distribution of [xiaorouji/openwrt-passwall](https://github.com/xiaorouji/openwrt-passwall) built with official OpenWRT SDK.

[![Build and Release](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/build-release.yml/badge.svg)](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/build-release.yml)
[![Scan openwrt-passwall Version](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/version-scan.yml/badge.svg)](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/version-scan.yml)

## Install via OPKG

1. Add new opkg key:

```sh
wget -O passwall.pub https://master.dl.sourceforge.net/project/openwrt-passwall-build/passwall.pub
opkg-key add passwall.pub
```

2. Add opkg repository:

```sh
read release arch << EOF
$(. /etc/openwrt_release ; echo ${DISTRIB_RELEASE%.*} $DISTRIB_ARCH)
EOF
for feed in passwall_luci passwall_packages passwall2; do
  echo "src/gz $feed https://master.dl.sourceforge.net/project/openwrt-passwall-build/releases/packages-$release/$arch/$feed" >> /etc/opkg/customfeeds.conf
done
```
OR
```sh
read arch << EOF
$(. /etc/openwrt_release ; echo $DISTRIB_ARCH)
EOF
for feed in passwall_luci passwall_packages passwall2; do
  echo "src/gz $feed https://master.dl.sourceforge.net/project/openwrt-passwall-build/snapshots/packages/$arch/$feed" >> /etc/opkg/customfeeds.conf
done
```
in case you use a snapshot build.

3. Install package:

```sh
opkg update
opkg install luci-app-passwall
```

## Manual Install

- Download prebuilt ipk file from [SourceForge](https://sourceforge.net/projects/openwrt-passwall-build/files/).

- Upload file to your router, install it with ssh command.

```sh
opkg install luci-app-passwall*.ipk
```

## Archived Builds

Builds for the following releases are archived and no longer updated due to toolchain compatibility.

<details><summary>OpenWrt 21.02</summary>

* luci: https://github.com/xiaorouji/openwrt-passwall/commit/e2443e4f8adb235547193ad12f1dd22f9965e5fe
* packages: https://github.com/xiaorouji/openwrt-passwall/commit/9812ea8cde0f1a64731d306769cace2e9011b187
* passwall2: https://github.com/xiaorouji/openwrt-passwall2/commit/6969493ec406f2332466f8905ba8903c3178e131
</details>

## Acknowledgement

This project is heavily inspired by [kuoruan/openwrt-v2ray](https://github.com/kuoruan/openwrt-v2ray).
