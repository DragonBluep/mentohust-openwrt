# mentohust-openwrt
MentoHUST with LuCI Interface for OpenWrt

## 简介
本项目非原创，克隆自：  
[KyleRicardo/MentoHUST-OpenWrt-ipk](https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk.git)  
[BoringCat/luci-app-mentohust](https://github.com/BoringCat/luci-app-mentohust.git)  
本项目结合了以上两个优秀的项目，方便同时下载编译可以运行在OpenWrt平台上的MentoHUST锐捷认证插件以及配套的的luCI配置界面。

## 编译
1.下载[OpenWrt SDK](https://downloads.openwrt.org/)  
依次选择版本，处理器平台，获取SDK（命名形如openwrt-sdk-xxx.tar.xz）  
常见平台命名：  
ramips: MT7620, MT7621, MT76x8, RT288x, RT305x, RT3883等联发科平台  
ath79: AR724x, AR913x, AR93xx, QCA95xx等高通平台  
   
2.解压SDK  
解压提取SDK到用户目录下（路径不能有空格和中文）  
  
3.配置编译环境  
在SDK目录下执行  
```bash
make prereq
```
根据输出的提示安装缺少的工具  
参考[Build system setup](https://openwrt.org/docs/guide-developer/build-system/install-buildsystem)  
如果想偷懒直接找到链接中Linux distributions一栏中对应的操作系统，执行对应指令安装所有工具。
  
4.下载源码并编译  
```bash
./scripts/feeds update
./scripts/feeds install luci luci-compat libpcap
git clone https://github.com/DragonBluep/mentohust-openwrt.git package/mentohust-openwrt
make menuconfig
# 选择Advanced configuration options (for developers)
# 按N取消选定Automatic removal of build directories
# Save后一直Exit退出
make package/luci-app-mentohust/compile
# 编译完成后生成的插件在bin/packages下
```
  
5.安装插件  
在bin/packages的子目录中找到libpcap, mentohust, luci-app-mentohust, luci-compat这四个ipk文件，使用WinSCP上传至OpenWrt的/tmp目录中，然后执行
```bash
opkg install /tmp/*.ipk
```
如果出现询问使用哪快网卡，直接按ctrl + C退出即可。
