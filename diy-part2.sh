#!/bin/bash


# 删除原有软件包
rm -rf feeds/luci/applications/luci-app-dockerman
rm -rf feeds/luci/applications/luci-app-filebrowser
rm -rf feeds/luci/applications/luci-app-ddns
rm -rf feeds/packages/net/ddns-scripts
rm -rf feeds/packages/net/zerotier
# rm -rf feeds/luci/applications/luci-app-acme
# rm -rf feeds/packages/net/acme
# rm -rf feeds/packages/net/acme-acmesh
# rm -rf feeds/packages/net/acme-common
# rm -rf feeds/packages/net/speedtest-go
# rm -rf feeds/packages/net/socat
# rm -rf feeds/luci/applications/luci-i18n-filebrowser-zh-cn


# 加载主题
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git package/deng/luci-theme-argon
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config package/deng/luci-app-argon-config
git clone --depth 1 https://github.com/derisamedia/luci-theme-alpha package/deng/luci-theme-alpha
git clone --depth 1 https://github.com/derisamedia/luci-app-alpha-config package/deng/luci-app-alpha-config


# 加载软件包
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/openwrt-passwall-packages
git clone --depth 1 https://github.com/kenzok78/luci-app-adguardhome package/deng/luci-app-adguardhome
git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go package/deng/luci-app-ddns-go
git clone --depth 1 https://github.com/tty228/luci-app-wechatpush.git package/deng/luci-app-wechatpush
git clone --depth 1 https://github.com/lisaac/luci-app-dockerman package/deng/luci-app-dockerman
# git clone --depth 1 https://github.com/sirpdboy/luci-app-lucky.git package/deng/luci-app-lucky
git clone --depth 1 https://github.com/gdy666/luci-app-lucky.git package/deng/lucky
git clone --depth 1 https://github.com/xiaozhuai/luci-app-filebrowser package/luci-app-filebrowser
git clone --depth 1 https://github.com/danchexiaoyang/luci-app-kodexplorer package/luci-app-kodexplorer && chmod -R 755 package/luci-app-kodexplorer
git clone --depth 1 https://github.com/vernesong/OpenClash.git package/OpenClash
git clone --depth 1 https://github.com/pymumu/openwrt-smartdns package/smartdns
git clone --depth 1 https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns
git clone --depth 1 https://github.com/sirpdboy/luci-app-cupsd.git package/deng/luci-app-cupsd
git clone --depth 1 https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
git clone --depth 1 https://github.com/immortalwrt-collections/luci-app-diskman.git package/deng/luci-app-diskman

git clone --depth 1 https://github.com/coolsnowwolf/packages deng-tmp1 && mv deng-tmp1/net/zerotier package/deng/zerotier
sed -i 's#../../#$(TOPDIR)/feeds/packages/#g' package/deng/zerotier/Makefile
# 第三方
mkdir -p package/deng/zerotier/files/etc/config
wget -O package/deng/zerotier/files/etc/config/zerotier https://raw.githubusercontent.com/y12800/OpenWrt-Actions/main/app/zerotier && chmod 644 package/deng/zerotier/files/etc/config/zerotier
# 官方版
# mkdir -p feeds/packages/net/zerotier/files/etc/config
# wget -O feeds/packages/net/zerotier/files/etc/config/zerotier https://raw.githubusercontent.com/y12800/OpenWrt-Actions/main/app/zerotier && chmod 644 feeds/packages/net/zerotier/files/etc/config/zerotier

git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/luci deng-tmp2 && mv deng-tmp2/applications/luci-app-ddns package/deng/luci-app-ddns
sed -i 's#../../#$(TOPDIR)/feeds/luci/#g' package/deng/luci-app-ddns/Makefile
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/packages deng-tmp3 && mv deng-tmp3/net/ddns-scripts package/deng/ddns-scripts && mv deng-tmp3/net/ddns-scripts_aliyun package/deng/ddns-scripts_aliyun && mv deng-tmp3/net/ddns-scripts_dnspod package/deng/ddns-scripts_dnspod
sed -i 's#../../#$(TOPDIR)/feeds/packages/#g' package/deng/ddns-scripts/Makefile
sed -i 's#../../#$(TOPDIR)/feeds/packages/#g' package/deng/ddns-scripts_aliyun/Makefile
sed -i 's#../../#$(TOPDIR)/feeds/packages/#g' package/deng/ddns-scripts_dnspod/Makefile

git clone --depth 1 https://github.com/immortalwrt/luci deng-tmp7 && mv deng-tmp7/applications/luci-app-vlmcsd package/deng/luci-app-vlmcsd && mv deng-tmp7/applications/luci-app-socat package/deng/luci-app-socat
sed -i 's#../../#$(TOPDIR)/feeds/luci/#g' package/deng/luci-app-vlmcsd/Makefile
sed -i 's#../../#$(TOPDIR)/feeds/luci/#g' package/deng/luci-app-socat/Makefile

git clone --depth 1 https://github.com/immortalwrt/packages deng-tmp8 && mv deng-tmp8/net/vlmcsd package/deng/vlmcsd && mv deng-tmp8/net/socat package/deng/socat
sed -i 's#../../#$(TOPDIR)/feeds/packages/#g' package/deng/vlmcsd/Makefile
sed -i 's#../../#$(TOPDIR)/feeds/packages/#g' package/deng/socat/Makefile


# 修改默认值
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

sed -i 's/CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"/CONFIG_FAT_DEFAULT_IOCHARSET="utf8"/g' target/linux/generic/config-6.6

sed -i '$a\net.netfilter.nf_conntrack_max=965535' package/base-files/files/etc/sysctl.conf

sed -i '$a\admin:x:0:0:root:/root:/bin/ash' package/base-files/files/etc/passwd
sed -i '$a\admin:$5$KGP.38nocVHkeNPa$9gNnoYzKRS2oeHzUn4UFZZ5wGAqmDNPZ04sPBASRpP/:0:0:99999:7:::' package/base-files/files/etc/shadow

sed -i '$a\config login\n\toption username '\''admin'\''\n\toption password '\''$p$admin'\''\n\tlist read '\''*'\''\n\tlist write '\''*'\''' package/system/rpcd/files/rpcd.config

sed -i '/\[::\]:80/a\\tlist listen_http\t0.0.0.0:88\n\tlist listen_http\t[::]:88' package/network/services/uhttpd/files/uhttpd.config
sed -i 's/option rfc1918_filter 1/option rfc1918_filter 0/' package/network/services/uhttpd/files/uhttpd.config
sed -i '/list listen_https[[:space:]]/s/443/4443/' package/network/services/uhttpd/files/uhttpd.config


# sed -i "/exit 0/i uci set firewall.@defaults[0].input='ACCEPT' && uci set firewall.@defaults[0].forward='ACCEPT' && uci set firewall.@zone[1].input='ACCEPT' && uci set firewall.@zone[1].forward='ACCEPT' && uci commit firewall && /etc/init.d/firewall restart" package/base-files/files/etc/rc.local
# sed -i "/# Put your custom commands here that should be executed once/a uci set firewall.@defaults[0].input='ACCEPT' && uci set firewall.@defaults[0].forward='ACCEPT' && uci set firewall.@zone[1].input='ACCEPT' && uci set firewall.@zone[1].forward='ACCEPT' && uci commit firewall && /etc/init.d/firewall restart" package/base-files/files/etc/rc.local
sed -i "1i uci set firewall.@defaults[0].input='ACCEPT' && uci set firewall.@defaults[0].forward='ACCEPT' && uci set firewall.@zone[1].input='ACCEPT' && uci set firewall.@zone[1].forward='ACCEPT' && uci commit firewall && /etc/init.d/firewall restart" package/base-files/files/etc/rc.local
sed -i '2i /etc/init.d/ddns start' package/base-files/files/etc/rc.local

sed -i 's/EXTRA_CFLAGS:=.*/& -Wno-error=misleading-indentation/' package/OpenAppFilter/oaf/Makefile


# sed -i 's/luci-theme-openwrt-2020/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile
# sed -i "/exit 0/i\sed -i \"/defaults/{n;s/.*/option input 'ACCEPT'/;n;s/.*/option output 'ACCEPT'/;n;s/.*/option forward 'ACCEPT'/};/zone/{n;/wan/!b;n;s/.*/option input 'ACCEPT'/;n;s/.*/option output 'ACCEPT'/;n;s/.*/option forward 'ACCEPT'/}\" /etc/config/firewall && /etc/init.d/firewall restart" package/base-files/files/etc/rc.local



