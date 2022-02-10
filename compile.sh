#!/bin/sh -e
#
# Copyright (C) 2021 Xingwang Liao
# Copyright (C) 2021 MoetaYuko
#

if [ -z "$SIGN_PRIV_KEY" ]; then
	echo "Signing key not defined!"
	exit 1
fi

dir="$(cd "$(dirname "$0")" ; pwd)"

cache_dir=${CACHE_DIR:-"~/cache"}

sdk_target_url_path=${SDK_TARGET_URL_PATH:-"x86/64"}
sdk_version=${SDK_VERSION:-"snapshots"}
sdk_url_path="https://downloads.openwrt.org/${sdk_version}/targets/${sdk_target_url_path}"

sdk_home=${SDK_HOME:-"~/sdk"}

sdk_home_dir="$(eval echo "$sdk_home")"

test -d "$sdk_home_dir" || mkdir -p "$sdk_home_dir"

sdk_dir="$(eval echo "$cache_dir/sdk")"
dl_dir="$(eval echo "$cache_dir/dl")"
feeds_dir="$(eval echo "$cache_dir/feeds")"

test -d "$sdk_dir" || mkdir -p "$sdk_dir"
test -d "$dl_dir" || mkdir -p "$dl_dir"
test -d "$feeds_dir" || mkdir -p "$feeds_dir"

cd "$sdk_dir"

if ! ( wget -q -O - "$sdk_url_path/sha256sums" | \
	grep -- "-sdk-" > sha256sums.small 2>/dev/null ) ; then
	echo "Can not find sdk file in sha256sums."
	exit 1
fi

sdk_file="$(cut -d' ' -f2 < sha256sums.small | sed 's/*//g')"

if ! sha256sum -c ./sha256sums.small >/dev/null 2>&1 ; then
	wget -q -O "$sdk_file" "$sdk_url_path/$sdk_file"

	if ! sha256sum -c ./sha256sums.small >/dev/null 2>&1 ; then
		echo "SDK can not be verified!"
		exit 1
	fi
fi

cd "$dir"

file "$sdk_dir/$sdk_file"
tar -Jxf "$sdk_dir/$sdk_file" -C "$sdk_home_dir" --strip=1

cd "$sdk_home_dir"

( test -d "dl" && rm -rf "dl" ) || true
( test -d "feeds" && rm -rf "feeds" ) || true

ln -sf "$dl_dir" "dl"
ln -sf "$feeds_dir" "feeds"

cp -f feeds.conf.default feeds.conf

sed -i '
s#git.openwrt.org/openwrt/openwrt#github.com/openwrt/openwrt#
s#git.openwrt.org/feed/packages#github.com/openwrt/packages#
s#git.openwrt.org/project/luci#github.com/openwrt/luci#
s#git.openwrt.org/feed/telephony#github.com/openwrt/telephony#
' feeds.conf
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >> feeds.conf

./scripts/feeds update -a

if [ ! -d "package/openwrt-upx" ] ; then
	git clone -b master --depth 1 \
		https://github.com/kuoruan/openwrt-upx.git package/openwrt-upx
fi

./scripts/feeds install -a -p passwall

make defconfig

# Remove upx from cross-compile targets
sed -i 's/\(CONFIG_PACKAGE_upx=\)m/\1n/' .config

# Remove bpftool as cross-compile fix for bpftool-bootstrap is not included in v5.10,
# which is used by 21.02.x.
# Ref: https://github.com/torvalds/linux/commit/8859b0da5aac28e4e9651c8971e7af344f8ffec1
sed -i 's/\(CONFIG_PACKAGE_bpftool-\(full\|minimal\)=\)m/\1n/' .config

# Must build before the rest components
make -j$(nproc) package/upx/host/compile

echo "$SIGN_PRIV_KEY" > key-build
make -j$(nproc) V=s

sdk_abi=${SDK_ABI:-"snapshots/packages"}
dist_dir=${dir}/dist/${sdk_abi}
test -d $dist_dir || mkdir -p $dist_dir

cd bin/packages
cp -r --parents */passwall $dist_dir
find $dir/dist -type f -exec ls -lh {} \;
