# openwrt-passwall-build

Binary distribution of [Openwrt-Passwall/openwrt-passwall](https://github.com/Openwrt-Passwall/openwrt-passwall) built with official OpenWRT SDK.

[![Build and Release](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/build-release.yml/badge.svg)](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/build-release.yml)
[![Scan openwrt-passwall Version](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/version-scan.yml/badge.svg)](https://github.com/dianlujitao/openwrt-passwall-build/actions/workflows/version-scan.yml)

## Install via APK (OpenWrt 25.12+ and snapshots)

1. Add new apk key:

    ```sh
    wget -O /etc/apk/keys/openwrt-passwall-build.pem \
      https://master.dl.sourceforge.net/project/openwrt-passwall-build/apk.pub
    ```

2. Add apk repository:

    ```sh
    read release arch << EOF
    $(. /etc/openwrt_release ; echo ${DISTRIB_RELEASE%.*} $DISTRIB_ARCH)
    EOF
    for feed in passwall_luci passwall_packages passwall2; do
      echo "https://master.dl.sourceforge.net/project/openwrt-passwall-build/releases/packages-$release/$arch/$feed/packages.adb" >> /etc/apk/repositories.d/customfeeds.list
    done
    ```

    OR

    ```sh
    read arch << EOF
    $(. /etc/openwrt_release ; echo $DISTRIB_ARCH)
    EOF
    for feed in passwall_luci passwall_packages passwall2; do
      echo "https://master.dl.sourceforge.net/project/openwrt-passwall-build/snapshots/packages/$arch/$feed/packages.adb" >> /etc/apk/repositories.d/customfeeds.list
    done
    ```

    in case you use a snapshot build.

3. Install package:

    ```sh
    apk update
    apk add luci-app-passwall
    ```

## Install via OPKG (OpenWrt 24.10 and older)

1. Add new opkg key:

    ```sh
    wget -O ipk.pub https://master.dl.sourceforge.net/project/openwrt-passwall-build/ipk.pub
    opkg-key add ipk.pub
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

3. Install package:

    ```sh
    opkg update
    opkg install luci-app-passwall
    ```

## Manual Install

- Download prebuilt package from [SourceForge](https://sourceforge.net/projects/openwrt-passwall-build/files/).

- Upload file to your router, then install it with the matching package manager.

  ```sh
  apk add ./luci-app-passwall*.apk
  ```

  OR

  ```sh
  opkg install luci-app-passwall*.ipk
  ```

## Acknowledgement

This project is heavily inspired by [kuoruan/openwrt-v2ray](https://github.com/kuoruan/openwrt-v2ray).
