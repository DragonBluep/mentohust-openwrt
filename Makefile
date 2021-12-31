#
# Copyright (C) 2021 Shiji Yang (yangshiji66@qq.com)
# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mentohust
PKG_VERSION:=0.3.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/HustLion/mentohust.git
PKG_SOURCE_DATE:=2016-08-06
PKG_SOURCE_VERSION:=2f9ef2d6df5d95c0faa2e542f1cb77114824e697
PKG_MIRROR_HASH:=8acebf27f619b3492d24edb9f393911146a7848a3ba34adb2809c4feda35fecb

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

PKG_MAINTAINER:=Shiji Yang <yangshiji66@qq.com>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk

define Package/mentohust
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Ruijie certification Client
  PKG_BUILD_DEPENDS:=gettext-full/host libpcap
  MAINTAINER:=HustLion
  URL:=$(PKG_SOURCE_URL)
endef

define Package/mentohust/description
MentoHUST is a program that supports Ruijie certification under Windows,
Linux, and Mac OS.
endef

CONFIGURE_ARGS += \
	--disable-encodepass \
	--disable-notify \
	--with-pcap=stlib

define Build/Configure
	$(CP) $(STAGING_DIR)/usr/lib/libpcap.a $(PKG_BUILD_DIR)/src/
	$(SED) 's/dhclient/udhcpc -i/g' $(PKG_BUILD_DIR)/src/myconfig.c
	( cd $(PKG_BUILD_DIR); ./autogen.sh )
	$(call Build/Configure/Default)
endef

define Package/mentohust/conffiles
/etc/mentohust.conf
endef

define Package/mentohust/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/mentohust $(1)/usr/sbin/

	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/mentohust.conf $(1)/etc/

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/mentohust.init $(1)/etc/init.d/mentohust
endef

$(eval $(call BuildPackage,mentohust))
