Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE41503BE1;
	Mon,  7 Sep 2026 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796526; cv=none; b=q9tZ3En0zBo2IPFb5cu4ZBciSQuKe4e4mMy/PLIyK5/qztTh1yp73YuWb804YJXIqWMbkDQI2sunK6fbK00tUi2ywh7oM+Vr4xUCd/nyxOVxEUZt52MSEwL3tMVXcrr2fdiiXnOuZw5Fb9lDwcMyYbbZYRgr14REqSlSTqmjo/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796526; c=relaxed/simple;
	bh=fYA/XElxo9rNUAZwtnhADWMB/Rh4qrI37kihOb9v0nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TXs3pVHanpiJy3GaL4X8PT+2CcM1+AOjPw45gy0Pp5B1E10AYEUTAgxjD9mjUSKbT4mHzG3HHatjYa0n6bbqkxaseCd1CDnRdFT5dIVDD6+7aT+76+HC/w9XTsMidoW+csFkSmElcdcdTWHsms5fz05FV1ogR8g00QEog+4Pk1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IUO3anUg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IUO3anUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C303C1F00A3D;
	Mon,  7 Sep 2026 15:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788796521;
	bh=Qydb+ZPfByuK9Wc5uEjiTi1KO0fRdnXpqnhsRoz1o88=;
	h=From:To:Cc:Subject:Date;
	b=IUO3anUgV8LIp14ocgDK/CNbb9Aqko80FQt4BLNm4oVFXf4f6T2GYJzclQ2dmcoU3
	 7hOjn/Ok3Eg4YHhI/vE/zfE5nmQ3EhFnYV3Wv3LY5tcSsoBRqpjKy9EdMxl4RnlIjh
	 ORz6lpFfpQo442CJwVNDrV9NMnd4Z6ZHufoTDLaY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.50
Date: Mon,  7 Sep 2026 17:52:55 +0200
Message-ID: <2026090756-constrain-unselfish-7f3f@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.50 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-bus-nvdimm                     |    3 
 Documentation/admin-guide/blockdev/zoned_loop.rst              |    9 
 Makefile                                                       |    2 
 arch/alpha/include/uapi/asm/fpu.h                              |    8 
 arch/alpha/kernel/pci-sysfs.c                                  |    6 
 arch/alpha/kernel/sys_marvel.c                                 |   25 -
 arch/alpha/kernel/traps.c                                      |    6 
 arch/alpha/math-emu/math.c                                     |   88 +++
 arch/arm/Kconfig                                               |    2 
 arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts                |    2 
 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi                    |    2 
 arch/arm64/boot/dts/rockchip/px30-cobra.dtsi                   |    2 
 arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi                  |    2 
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi                |    2 
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts          |   18 
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts            |   12 
 arch/arm64/boot/dts/rockchip/rk3588s-roc-pc.dts                |   23 
 arch/arm64/kernel/compat_alignment.c                           |    4 
 arch/arm64/kernel/proton-pack.c                                |    9 
 arch/openrisc/kernel/entry.S                                   |   43 +
 arch/powerpc/kernel/pci-common.c                               |    9 
 arch/powerpc/platforms/powermac/low_i2c.c                      |    2 
 arch/powerpc/platforms/pseries/iommu.c                         |   23 
 arch/riscv/include/asm/acpi.h                                  |   19 
 arch/riscv/kernel/unaligned_access_speed.c                     |   19 
 arch/s390/kernel/perf_cpum_cf.c                                |  215 +++++---
 arch/x86/coco/tdx/tdx.c                                        |   10 
 arch/x86/events/intel/uncore.c                                 |    1 
 arch/x86/events/intel/uncore_snbep.c                           |   13 
 arch/x86/include/asm/barrier.h                                 |    2 
 arch/x86/include/asm/insn-eval.h                               |   36 +
 arch/x86/kvm/emulate.c                                         |   26 -
 arch/x86/net/bpf_jit_comp.c                                    |    2 
 block/genhd.c                                                  |    1 
 drivers/accel/rocket/rocket_job.c                              |   32 -
 drivers/acpi/apei/erst.c                                       |    2 
 drivers/acpi/apei/ghes.c                                       |   52 +-
 drivers/acpi/pfr_update.c                                      |   45 -
 drivers/ata/libata-scsi.c                                      |   28 -
 drivers/auxdisplay/charlcd.c                                   |   21 
 drivers/base/arch_numa.c                                       |   12 
 drivers/base/power/main.c                                      |    1 
 drivers/base/property.c                                        |   19 
 drivers/block/zloop.c                                          |    3 
 drivers/block/zram/backend_deflate.c                           |   10 
 drivers/bluetooth/btrtl.c                                      |   13 
 drivers/bluetooth/btusb.c                                      |   14 
 drivers/bluetooth/hci_bcm.c                                    |    1 
 drivers/bluetooth/hci_bcm4377.c                                |    1 
 drivers/bluetooth/hci_h5.c                                     |    4 
 drivers/bluetooth/hci_intel.c                                  |    1 
 drivers/bluetooth/hci_ldisc.c                                  |    2 
 drivers/bluetooth/hci_serdev.c                                 |    2 
 drivers/cdx/cdx.c                                              |    7 
 drivers/char/hw_random/stm32-rng.c                             |   10 
 drivers/char/ipmi/ipmb_dev_int.c                               |    5 
 drivers/char/ipmi/ipmi_msghandler.c                            |    4 
 drivers/char/tpm/tpm_i2c_nuvoton.c                             |    6 
 drivers/clocksource/timer-nxp-pit.c                            |    4 
 drivers/clocksource/timer-sun4i.c                              |    2 
 drivers/crypto/allwinner/Kconfig                               |   16 
 drivers/crypto/allwinner/sun8i-ce/Makefile                     |    1 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c              |   57 --
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c              |  159 ------
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h                   |   29 -
 drivers/crypto/allwinner/sun8i-ss/Makefile                     |    1 
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c              |   39 -
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c              |  177 -------
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h                   |   23 
 drivers/cxl/core/features.c                                    |    8 
 drivers/cxl/core/pmem.c                                        |   10 
 drivers/cxl/core/ras.c                                         |    1 
 drivers/cxl/cxl.h                                              |    3 
 drivers/cxl/pci.c                                              |    1 
 drivers/cxl/pmem.c                                             |    2 
 drivers/fpga/altera-cvp.c                                      |   10 
 drivers/fpga/stratix10-soc.c                                   |   21 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |  112 +++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c      |   24 
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                   |   10 
 drivers/gpu/drm/amd/display/dc/dc_types.h                      |    1 
 drivers/gpu/drm/nouveau/nouveau_gem.c                          |   11 
 drivers/hid/hid-apple.c                                        |   18 
 drivers/hid/hid-corsair-void.c                                 |   17 
 drivers/hid/hid-mcp2221.c                                      |    9 
 drivers/hid/hid-picolcd_debugfs.c                              |    9 
 drivers/hid/hid-roccat.c                                       |   13 
 drivers/hid/hid-sensor-custom.c                                |    9 
 drivers/hid/hid-sensor-hub.c                                   |   42 +
 drivers/hid/hid-sony.c                                         |    4 
 drivers/hid/hid-universal-pidff.c                              |    4 
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c        |    1 
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c        |   10 
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h        |    1 
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c        |    2 
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c   |   19 
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h   |    2 
 drivers/hsi/controllers/omap_ssi_core.c                        |    6 
 drivers/hwmon/max6621.c                                        |    8 
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c            |   15 
 drivers/hwtracing/ptt/hisi_ptt.c                               |   20 
 drivers/i2c/busses/i2c-mxs.c                                   |    5 
 drivers/i3c/master.c                                           |    9 
 drivers/i3c/master/adi-i3c-master.c                            |   15 
 drivers/i3c/master/renesas-i3c.c                               |   70 ++
 drivers/i3c/master/svc-i3c-master.c                            |   10 
 drivers/infiniband/core/ucma.c                                 |   14 
 drivers/infiniband/core/uverbs_std_types_mr.c                  |    6 
 drivers/infiniband/hw/cxgb4/device.c                           |    6 
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c                    |    2 
 drivers/interconnect/core.c                                    |    7 
 drivers/iommu/amd/ppr.c                                        |    3 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                    |   56 +-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c                 |    8 
 drivers/iommu/intel/dmar.c                                     |   15 
 drivers/iommu/intel/iommu.c                                    |    8 
 drivers/iommu/intel/iommu.h                                    |    2 
 drivers/iommu/iommu-sva.c                                      |    2 
 drivers/iommu/iommu.c                                          |    2 
 drivers/iommu/iommufd/device.c                                 |    4 
 drivers/iommu/iommufd/ioas.c                                   |    2 
 drivers/iommu/iommufd/selftest.c                               |   31 +
 drivers/iommu/msm_iommu.c                                      |   10 
 drivers/mailbox/qcom-ipcc.c                                    |   17 
 drivers/md/dm-bufio.c                                          |   10 
 drivers/md/dm-era-target.c                                     |    5 
 drivers/md/dm-integrity.c                                      |   32 -
 drivers/md/dm-io.c                                             |   96 +--
 drivers/md/dm-kcopyd.c                                         |   10 
 drivers/md/dm-log-userspace-base.c                             |    1 
 drivers/md/dm-log.c                                            |    4 
 drivers/md/dm-pcache/cache.c                                   |   18 
 drivers/md/dm-pcache/cache.h                                   |   21 
 drivers/md/dm-pcache/cache_dev.c                               |   22 
 drivers/md/dm-pcache/cache_gc.c                                |   10 
 drivers/md/dm-pcache/cache_key.c                               |   32 -
 drivers/md/dm-pcache/cache_segment.c                           |   12 
 drivers/md/dm-pcache/cache_writeback.c                         |   10 
 drivers/md/dm-pcache/dm_pcache.c                               |    4 
 drivers/md/dm-raid1.c                                          |   26 -
 drivers/md/dm-snap-persistent.c                                |    4 
 drivers/md/dm-stats.c                                          |    6 
 drivers/md/dm-switch.c                                         |    2 
 drivers/md/dm-verity-target.c                                  |    2 
 drivers/md/dm-writecache.c                                     |   14 
 drivers/md/md.c                                                |    7 
 drivers/md/persistent-data/dm-array.c                          |   53 +-
 drivers/md/raid10.c                                            |    2 
 drivers/media/cec/platform/stm32/stm32-cec.c                   |    3 
 drivers/media/test-drivers/vicodec/vicodec-core.c              |    4 
 drivers/media/v4l2-core/v4l2-dev.c                             |   14 
 drivers/mfd/cgbc-core.c                                        |    4 
 drivers/mfd/sm501.c                                            |    2 
 drivers/misc/nsm.c                                             |    2 
 drivers/mmc/host/via-sdmmc.c                                   |   12 
 drivers/net/dsa/realtek/rtl83xx.c                              |    4 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c               |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                      |    7 
 drivers/net/ethernet/ibm/emac/mal.c                            |   13 
 drivers/net/ethernet/nvidia/forcedeth.c                        |    4 
 drivers/net/ethernet/qlogic/qede/qede.h                        |    8 
 drivers/net/ethernet/qlogic/qede/qede_fp.c                     |    1 
 drivers/net/ethernet/renesas/ravb.h                            |    3 
 drivers/net/ethernet/renesas/ravb_main.c                       |    9 
 drivers/net/ethernet/renesas/ravb_ptp.c                        |   44 +
 drivers/net/ipa/ipa_modem.c                                    |   18 
 drivers/net/ntb_netdev.c                                       |   38 -
 drivers/net/ovpn/main.c                                        |   19 
 drivers/net/ovpn/ovpnpriv.h                                    |    4 
 drivers/net/ovpn/peer.c                                        |    8 
 drivers/net/ovpn/tcp.c                                         |    9 
 drivers/net/phy/phylink.c                                      |    2 
 drivers/net/slip/slip.c                                        |   11 
 drivers/net/thunderbolt/main.c                                 |   12 
 drivers/net/tun.c                                              |   21 
 drivers/net/usb/qmi_wwan.c                                     |    1 
 drivers/net/wireless/ath/ath11k/mac.c                          |   28 -
 drivers/net/wireless/ath/ath6kl/cfg80211.c                     |    5 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c        |    3 
 drivers/net/wireless/intel/iwlwifi/dvm/main.c                  |    4 
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c               |   12 
 drivers/net/wireless/mediatek/mt76/mt7615/main.c               |    5 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c           |   16 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                |   15 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                |    1 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c               |   12 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                |    4 
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c                |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c                |    1 
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c             |    6 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                |   26 +
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c             |    2 
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c             |    2 
 drivers/net/wireless/realtek/rtl8xxxu/core.c                   |   19 
 drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c            |   12 
 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c           |    3 
 drivers/net/wireless/realtek/rtw88/pci.c                       |    4 
 drivers/net/wireless/realtek/rtw88/tx.c                        |    1 
 drivers/ntb/ntb_transport.c                                    |   38 -
 drivers/nvdimm/label.c                                         |    2 
 drivers/nvme/host/core.c                                       |    2 
 drivers/nvme/host/fc.c                                         |    2 
 drivers/nvme/host/pci.c                                        |    1 
 drivers/nvme/host/tcp.c                                        |   45 +
 drivers/of/base.c                                              |    2 
 drivers/pci/controller/dwc/pci-meson.c                         |    2 
 drivers/pci/controller/pci-hyperv.c                            |    1 
 drivers/pci/controller/plda/pcie-plda-host.c                   |   52 +-
 drivers/pci/msi/msi.c                                          |   10 
 drivers/pci/pci-sysfs.c                                        |   42 +
 drivers/pci/pcie/aer.c                                         |   29 -
 drivers/pci/proc.c                                             |   16 
 drivers/pci/quirks.c                                           |    9 
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c                     |   21 
 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c              |    2 
 drivers/platform/chrome/cros_ec_sensorhub_ring.c               |   19 
 drivers/platform/x86/amd/pmc/mp1_stb.c                         |   43 +
 drivers/platform/x86/amd/pmc/pmc.c                             |    6 
 drivers/platform/x86/dell/dell-wmi-sysman/biosattr-interface.c |    1 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c                   |   18 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h                   |    8 
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c           |   15 
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c            |    6 
 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c     |   14 
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c      |   14 
 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c         |    4 
 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c         |    6 
 drivers/platform/x86/intel/ishtp_eclite.c                      |    5 
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c    |   77 ++-
 drivers/platform/x86/lenovo/think-lmi.c                        |   19 
 drivers/platform/x86/lenovo/wmi-helpers.c                      |    4 
 drivers/platform/x86/lenovo/ymc.c                              |    8 
 drivers/power/supply/bq24257_charger.c                         |   16 
 drivers/power/supply/bq256xx_charger.c                         |   29 -
 drivers/power/supply/bq25890_charger.c                         |   12 
 drivers/power/supply/charger-manager.c                         |   54 +-
 drivers/power/supply/cros_usbpd-charger.c                      |   17 
 drivers/power/supply/lp8727_charger.c                          |    4 
 drivers/power/supply/lp8788-charger.c                          |    2 
 drivers/power/supply/max17040_battery.c                        |   32 -
 drivers/power/supply/qcom_battmgr.c                            |    9 
 drivers/power/supply/rt9455_charger.c                          |   21 
 drivers/power/supply/twl4030_charger.c                         |   12 
 drivers/power/supply/ucs1002_power.c                           |    6 
 drivers/ptp/ptp_vmclock.c                                      |    6 
 drivers/rapidio/devices/rio_mport_cdev.c                       |   10 
 drivers/regulator/as3722-regulator.c                           |    1 
 drivers/regulator/max8998.c                                    |    1 
 drivers/regulator/qcom-refgen-regulator.c                      |    4 
 drivers/remoteproc/mtk_scp.c                                   |    9 
 drivers/rpmsg/qcom_glink_smem.c                                |    7 
 drivers/s390/block/dasd.c                                      |    6 
 drivers/s390/block/dasd_eckd.c                                 |   40 +
 drivers/s390/block/dasd_erp.c                                  |    3 
 drivers/scsi/scsi_lib.c                                        |    2 
 drivers/staging/greybus/hid.c                                  |    2 
 drivers/staging/media/ipu7/ipu7-isys.c                         |    1 
 drivers/staging/media/tegra-video/vi.c                         |    9 
 drivers/staging/media/tegra-video/vip.c                        |   10 
 drivers/tty/serial/imx.c                                       |   20 
 drivers/usb/dwc2/gadget.c                                      |   11 
 drivers/usb/dwc3/gadget.c                                      |    1 
 drivers/usb/gadget/function/f_fs.c                             |   14 
 drivers/usb/gadget/function/f_midi2.c                          |    2 
 drivers/usb/gadget/function/f_tcm.c                            |   23 
 drivers/usb/gadget/function/f_uvc.c                            |    7 
 drivers/usb/gadget/function/u_audio.c                          |   24 
 drivers/usb/gadget/function/uvc_video.c                        |    2 
 drivers/usb/gadget/udc/at91_udc.c                              |   20 
 drivers/usb/gadget/udc/snps_udc_plat.c                         |    5 
 drivers/usb/phy/phy-fsl-usb.c                                  |   52 +-
 drivers/usb/phy/phy-fsl-usb.h                                  |    6 
 drivers/usb/typec/altmodes/thunderbolt.c                       |    2 
 drivers/usb/typec/tcpm/tcpci.c                                 |   12 
 drivers/usb/typec/ucsi/ucsi.c                                  |    3 
 drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c       |    4 
 drivers/video/fbdev/pvr2fb.c                                   |    4 
 drivers/video/fbdev/ssd1307fb.c                                |   72 ++
 drivers/video/fbdev/uvesafb.c                                  |    2 
 drivers/video/sticore.c                                        |   22 
 drivers/w1/slaves/w1_ds28e17.c                                 |    8 
 fs/backing-file.c                                              |    2 
 fs/btrfs/direct-io.c                                           |   19 
 fs/btrfs/ioctl.c                                               |   23 
 fs/btrfs/relocation.c                                          |   31 +
 fs/buffer.c                                                    |    3 
 fs/ceph/addr.c                                                 |   11 
 fs/ceph/caps.c                                                 |   11 
 fs/ceph/dir.c                                                  |   10 
 fs/ceph/export.c                                               |   26 -
 fs/ceph/mds_client.c                                           |    8 
 fs/ceph/mdsmap.c                                               |   11 
 fs/ceph/xattr.c                                                |    1 
 fs/ecryptfs/crypto.c                                           |    2 
 fs/ecryptfs/ecryptfs_kernel.h                                  |    3 
 fs/ecryptfs/keystore.c                                         |   45 +
 fs/ecryptfs/messaging.c                                        |   11 
 fs/ecryptfs/miscdev.c                                          |    5 
 fs/ecryptfs/super.c                                            |    7 
 fs/efivarfs/super.c                                            |   30 -
 fs/fat/misc.c                                                  |    4 
 fs/fuse/dev.c                                                  |    3 
 fs/jbd2/checkpoint.c                                           |   28 -
 fs/lockd/clntproc.c                                            |    3 
 fs/lockd/svcsubs.c                                             |   55 +-
 fs/netfs/read_retry.c                                          |    6 
 fs/netfs/write_retry.c                                         |    6 
 fs/nfs/nfs4client.c                                            |   17 
 fs/nfs/pnfs.c                                                  |    3 
 fs/nfs_common/nfslocalio.c                                     |   16 
 fs/nfsd/filecache.c                                            |   22 
 fs/nfsd/flexfilelayoutxdr.c                                    |   20 
 fs/nfsd/localio.c                                              |    8 
 fs/nfsd/nfs2acl.c                                              |   52 +-
 fs/nfsd/nfs3acl.c                                              |   17 
 fs/nfsd/nfs3proc.c                                             |   40 +
 fs/nfsd/nfs4callback.c                                         |  113 +++-
 fs/nfsd/nfs4layouts.c                                          |   12 
 fs/nfsd/nfs4proc.c                                             |   60 +-
 fs/nfsd/nfs4state.c                                            |  249 +++++++---
 fs/nfsd/nfs4xdr.c                                              |   26 +
 fs/nfsd/nfscache.c                                             |    6 
 fs/nfsd/nfsctl.c                                               |  129 ++++-
 fs/nfsd/nfsfh.c                                                |   12 
 fs/nfsd/nfsproc.c                                              |    7 
 fs/nfsd/nfssvc.c                                               |    4 
 fs/nfsd/nfsxdr.c                                               |   32 -
 fs/nfsd/state.h                                                |    3 
 fs/nfsd/trace.h                                                |   18 
 fs/nfsd/vfs.c                                                  |   34 -
 fs/nilfs2/bmap.c                                               |    2 
 fs/nilfs2/bmap.h                                               |    2 
 fs/nilfs2/btree.c                                              |   39 +
 fs/nilfs2/direct.c                                             |    4 
 fs/notify/fanotify/fanotify.c                                  |    3 
 fs/notify/fanotify/fanotify.h                                  |    6 
 fs/notify/fanotify/fanotify_user.c                             |    5 
 fs/nsfs.c                                                      |    2 
 fs/ntfs3/frecord.c                                             |    9 
 fs/ntfs3/fslog.c                                               |   34 +
 fs/ocfs2/cluster/heartbeat.c                                   |  148 ++++-
 fs/ocfs2/cluster/nodemanager.c                                 |    6 
 fs/ocfs2/cluster/nodemanager.h                                 |    1 
 fs/ocfs2/dir.c                                                 |    2 
 fs/ocfs2/dlm/dlmmaster.c                                       |    6 
 fs/ocfs2/dlm/dlmrecovery.c                                     |    9 
 fs/ocfs2/refcounttree.c                                        |   47 +
 fs/ocfs2/xattr.c                                               |    5 
 fs/orangefs/devorangefs-req.c                                  |    1 
 fs/orangefs/orangefs-debugfs.c                                 |    1 
 fs/proc/task_mmu.c                                             |   15 
 fs/smb/client/cifsfs.c                                         |   15 
 fs/smb/client/dfs_cache.c                                      |   33 +
 fs/smb/client/file.c                                           |    1 
 fs/smb/client/inode.c                                          |    1 
 fs/smb/client/smb1ops.c                                        |    2 
 fs/smb/client/smb2file.c                                       |    5 
 fs/tracefs/event_inode.c                                       |    7 
 fs/ubifs/auth.c                                                |    2 
 fs/udf/inode.c                                                 |    2 
 fs/udf/partition.c                                             |    2 
 include/linux/compaction.h                                     |    3 
 include/linux/dm-io.h                                          |    6 
 include/linux/hugetlb.h                                        |    2 
 include/linux/list.h                                           |   15 
 include/linux/mm_types.h                                       |    2 
 include/linux/netdevice.h                                      |    3 
 include/linux/sunrpc/svc_rdma_pcl.h                            |    2 
 include/linux/swapops.h                                        |   12 
 include/linux/usb/tcpci.h                                      |    1 
 include/net/ip_tunnels.h                                       |   41 +
 include/net/sctp/structs.h                                     |    2 
 include/uapi/linux/landlock.h                                  |    1 
 io_uring/query.c                                               |    3 
 kernel/auditfilter.c                                           |    6 
 kernel/bpf/bloom_filter.c                                      |   19 
 kernel/bpf/stackmap.c                                          |    3 
 kernel/bpf/verifier.c                                          |   27 -
 kernel/module/kallsyms.c                                       |   24 
 kernel/module/main.c                                           |   14 
 kernel/params.c                                                |   14 
 kernel/pid.c                                                   |   31 -
 kernel/reboot.c                                                |   29 +
 kernel/sched/cpufreq_schedutil.c                               |   15 
 kernel/signal.c                                                |    4 
 kernel/taskstats.c                                             |    3 
 kernel/time/itimer.c                                           |    2 
 kernel/time/timekeeping.c                                      |    8 
 kernel/time/timer.c                                            |    1 
 kernel/trace/ring_buffer.c                                     |  173 ++++--
 kernel/trace/trace.c                                           |    6 
 kernel/trace/trace_events.c                                    |    2 
 kernel/trace/trace_events_hist.c                               |    4 
 kernel/trace/trace_events_user.c                               |    3 
 lib/ucs2_string.c                                              |    2 
 lib/xarray.c                                                   |    3 
 mm/compaction.c                                                |   98 ++-
 mm/gup.c                                                       |   10 
 mm/huge_memory.c                                               |    4 
 mm/hugetlb.c                                                   |    8 
 mm/internal.h                                                  |   10 
 mm/kasan/quarantine.c                                          |    7 
 mm/kmemleak.c                                                  |   51 +-
 mm/memcontrol-v1.c                                             |    6 
 mm/memcontrol.c                                                |   13 
 mm/memory.c                                                    |   49 +
 mm/mempolicy.c                                                 |   21 
 mm/migrate.c                                                   |    2 
 mm/mm_init.c                                                   |    9 
 mm/page_alloc.c                                                |   76 ++-
 mm/page_table_check.c                                          |   12 
 mm/pagewalk.c                                                  |    6 
 mm/rmap.c                                                      |   20 
 mm/swapfile.c                                                  |    6 
 mm/vmscan.c                                                    |   21 
 mm/zsmalloc.c                                                  |   11 
 mm/zswap.c                                                     |   13 
 net/bluetooth/eir.c                                            |    3 
 net/bluetooth/hci_conn.c                                       |    3 
 net/bluetooth/hci_core.c                                       |    2 
 net/bluetooth/hci_event.c                                      |    7 
 net/bluetooth/hci_sync.c                                       |    2 
 net/bluetooth/iso.c                                            |    8 
 net/bluetooth/rfcomm/core.c                                    |    8 
 net/ceph/osd_client.c                                          |   30 +
 net/ceph/osdmap.c                                              |    2 
 net/core/skbuff.c                                              |    5 
 net/core/xdp.c                                                 |    4 
 net/ipv4/ip_tunnel.c                                           |    2 
 net/ipv4/ipip.c                                                |    2 
 net/ipv4/ipmr.c                                                |    3 
 net/ipv6/exthdrs.c                                             |   26 -
 net/ipv6/ip6_gre.c                                             |   14 
 net/ipv6/ip6_input.c                                           |    1 
 net/ipv6/ip6_tunnel.c                                          |   22 
 net/ipv6/route.c                                               |    2 
 net/ipv6/seg6_local.c                                          |    9 
 net/ipv6/sit.c                                                 |    2 
 net/iucv/af_iucv.c                                             |    2 
 net/l2tp/l2tp_netlink.c                                        |   16 
 net/mpls/af_mpls.c                                             |    2 
 net/mptcp/syncookies.c                                         |    1 
 net/openvswitch/conntrack.c                                    |    8 
 net/openvswitch/datapath.c                                     |   48 -
 net/sched/sch_generic.c                                        |    2 
 net/sctp/inqueue.c                                             |    7 
 net/sctp/sm_sideeffect.c                                       |    4 
 net/sctp/stream.c                                              |   48 +
 net/smc/af_smc.c                                               |    3 
 net/smc/smc.h                                                  |    6 
 net/smc/smc_core.c                                             |   27 -
 net/smc/smc_llc.c                                              |  122 +++-
 net/smc/smc_rx.c                                               |   11 
 net/smc/smc_tx.h                                               |    6 
 net/smc/smc_wr.c                                               |    6 
 net/sunrpc/auth_gss/auth_gss.c                                 |    6 
 net/sunrpc/auth_gss/gss_krb5_wrap.c                            |   13 
 net/sunrpc/auth_gss/gss_rpc_upcall.c                           |    6 
 net/sunrpc/auth_gss/gss_rpc_upcall.h                           |    1 
 net/sunrpc/auth_gss/gss_rpc_xdr.c                              |    6 
 net/sunrpc/auth_gss/svcauth_gss.c                              |    8 
 net/sunrpc/cache.c                                             |    7 
 net/sunrpc/clnt.c                                              |   22 
 net/sunrpc/sunrpc_syms.c                                       |    1 
 net/sunrpc/svc.c                                               |   93 +++
 net/sunrpc/xdr.c                                               |    2 
 net/sunrpc/xprtrdma/ib_client.c                                |   24 
 net/sunrpc/xprtrdma/svc_rdma_pcl.c                             |    2 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                        |    9 
 net/sunrpc/xprtrdma/svc_rdma_rw.c                              |   47 +
 net/sunrpc/xprtrdma/svc_rdma_sendto.c                          |   47 +
 net/sunrpc/xprtrdma/svc_rdma_transport.c                       |   44 +
 net/sunrpc/xprtsock.c                                          |   12 
 net/vmw_vsock/virtio_transport.c                               |    2 
 rust/kernel/bug.rs                                             |    6 
 rust/kernel/list.rs                                            |    2 
 rust/kernel/time.rs                                            |   17 
 scripts/rust_is_available.sh                                   |   14 
 scripts/rust_is_available_bindgen_libclang_22.h                |    5 
 scripts/rust_is_available_test.py                              |   30 +
 security/apparmor/include/cred.h                               |    6 
 security/apparmor/include/label.h                              |    6 
 security/apparmor/include/task.h                               |   15 
 security/apparmor/task.c                                       |   27 +
 security/keys/trusted-keys/trusted_tpm1.c                      |    2 
 security/landlock/errata/abi-1.h                               |   23 
 security/landlock/fs.c                                         |   41 +
 security/smack/smack_lsm.c                                     |    2 
 sound/core/ump_convert.c                                       |    1 
 sound/drivers/aloop.c                                          |    6 
 sound/drivers/mpu401/mpu401.c                                  |    6 
 sound/drivers/mts64.c                                          |    6 
 sound/drivers/portman2x4.c                                     |    6 
 sound/drivers/serial-u16550.c                                  |    6 
 sound/drivers/virmidi.c                                        |    6 
 sound/hda/codecs/realtek/alc269.c                              |    7 
 sound/hda/core/ext/stream.c                                    |    4 
 sound/pci/pcxhr/pcxhr.c                                        |   14 
 sound/soc/amd/yc/acp6x-mach.c                                  |    7 
 sound/usb/6fire/comm.c                                         |    9 
 sound/usb/bcd2000/bcd2000.c                                    |   11 
 tools/include/linux/compiler.h                                 |    2 
 tools/testing/selftests/mm/run_vmtests.sh                      |    2 
 503 files changed, 5434 insertions(+), 2529 deletions(-)

Abdifatah Suruur (1):
      ptp: vmclock: prevent read-only mappings from becoming writable

Abdun Nihaal (4):
      mfd: sm501: Fix potential memory leaks during remove
      wifi: brcmfmac: Fix memory leak in brcmf_sdio_read_control()
      wifi: rtlwifi: rtl8192du: Fix possible memory leak in rtl92du_init_sw_vars()
      wifi: rtw88: Fix potential memory leak in rtw_txq_push_skb()

Abdurrahman Hussain (1):
      of: fix out-of-bounds read in of_alias_scan() stem parser

Adrian Hunter (1):
      i3c: master: Fix info leak and UAF in device unregister path

Ahmad Fatoum (1):
      net: dsa: realtek: use gpiod_set_value_cansleep for reset GPIO

Aleksandr Khromov (1):
      slip: fix use-after-free in sl_sync()

Alexander Graf (1):
      mm/mm_init: deferred_grow_zone(): fix out-of-range first_deferred_pfn

Alexandra Winter (1):
      net/iucv: filter frames in afiucv_hs_rcv() by ingress device

Ali Ahmet Memis (1):
      openrisc: fix arbitrary kernel memory access via or1k_atomic syscall

Ali Tariq (2):
      PCI: plda: Fix use-after-free of event IRQs during teardown
      PCI: plda: Fix IRQ domain leaks in the error paths of plda_init_interrupts()

Alison Schofield (1):
      cxl/pmem: Format the nvdimm serial number as unsigned decimal

Ameer Hamza (1):
      SUNRPC: Restore NUMA_NO_NODE for svc thread allocations in global mode

Andre Eikmeyer (1):
      HID: apple: preserve keyboard backlight across T2 resume

Andrea Mayer (1):
      ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_srh_rcv()

Anirudh Prasad (1):
      ACPI: pfr_update: fix stack buffer overflow in query_capability()

Anton Danilov (1):
      ipip: fix skb leak in collect_md mode when metadata_dst allocation fails

Anup Vishwakarma (1):
      mailbox: qcom-ipcc: fix duplicate channel allocation across holes

Ard Biesheuvel (1):
      efivarfs: Rate limit statfs() handler

Asim Viladi Oglu Manizada (1):
      net: tun: bound receive headroom

Baokun Li (1):
      fs: fix user path of nested backing files

Bartosz Golaszewski (1):
      powerpc/powermac: fix OF node refcount

Baul Lee (3):
      HID: universal-pidff: stop the device when force-feedback init fails
      ALSA: 6fire: bound the MIDI event length from the device
      ALSA: bcd2000: clear the URB pointers on disconnect

Bradley Morgan (2):
      signal: avoid shared siginfo namespace rewrites
      taskstats: fix cpumask parsing cutting off the last character

Breno Leitao (5):
      mm, swap: ratelimit bad swap entry reports
      mm/kmemleak: avoid soft lockup when scanning task stacks
      mm/migrate: report RCU-tasks quiescent states in migrate_pages_batch()
      mm/vmscan: report RCU-tasks quiescent states in shrink_lruvec()
      net: fix spurious TX timeout after dev_activate()

Brett Creeley (1):
      RDMA/ionic: Cap eq_count to the eth driver's interrupt vector budget

Bryam Vargas (18):
      misc: nsm: bound the device-reported response length
      dm array: validate array block headers on read
      dm array: reject an array block whose value size is not the caller's
      libnvdimm/labels: Prevent integer overflow in __nd_label_validate()
      ocfs2: bound namelen in dlm_migrate_request_handler
      ocfs2: validate lengths in dlm_mig_lockres_handler
      power: supply: cros_usbpd-charger: bound the EC-reported port count
      platform/chrome: sensorhub: Bound the EC-reported sensor number
      net/smc: do not dereference an unset send buffer on the SMC-D teardown path
      net/smc: unregister the connection before draining the rx tasklet
      dm-pcache: validate geometry fields from on-disk cache_info
      dm-pcache: validate kset key_num and intra-segment bounds
      dm-pcache: validate on-media seg_num against the cache device size
      dm-pcache: bound the persisted tail-position offset
      dm-pcache: clamp the tail kset read to the segment data region
      dm-pcache: detect a cycle in the last-kset chain during replay
      dm-pcache: only hand out initialized cache segments
      wifi: mt76: mt7915: bound the device EEPROM address before the EFUSE copy

Can Peng (1):
      hwrng: stm32 - Fix runtime PM cleanup on registration failure

Chengfeng Ye (4):
      KEYS: trusted: Fix TPM teardown ordering
      fanotify: fix use-after-free of file range info
      Bluetooth: RFCOMM: serialize security confirmation handling
      vsock/virtio: flush works in dependency order

Chris Mason (19):
      NFS/localio: fix ref leak on nfs_uuid_add_file failure
      nfsd: guard nfsd_serv deref in nfsd_file_net_dispose
      nfsd: release path refs on follow_down() error
      nfsd: size fh_verify server sockaddr slot by xpt_locallen
      nfsd: fix cpntf publish race in nfs4_init_cp_state
      nfsd: gate nfs3 setacl by argp->mask
      nfsd: hold rcu across localio cmpxchg retry
      SUNRPC: xdr_buf_trim: clamp buf->len to avoid underflow
      SUNRPC: Zero rpc_gss_wire_cred at svcauth_gss_decode_credbody() entry
      SUNRPC: svcauth_gss: enforce krb5 token minimum length
      SUNRPC: Guard svcauth_gss_release() dispatch on rq_auth_stat
      SUNRPC: harden gss_krb5_unwrap_v2 against short tokens
      SUNRPC: harden gss_unwrap_resp_priv length checks
      sunrpc: init gssp_lock before publishing proc entry
      SUNRPC: reject duplicate CREDS_VALUE options
      svcrdma: Fix offset arithmetic in read_chunk_range
      svcrdma: Fix pcl_for_each_segment for empty chunks
      svcrdma: Fix unmatched rn_unregister on failed accept
      svcrdma: Reject Write/Reply chunks with segcount 0

Christian Brauner (1):
      nsfs: tighten permission checks for handle opening

Christian Marangi (1):
      net: phylink: correctly validate returned PCS in phylink_inband_caps

Christoph Zwerschke (2):
      Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU
      Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU

Christopher Tolang (1):
      ASoC: amd: yc: Add DMI entry for MSI Thin A15 B7UC

Chuck Lever (13):
      NFSD: check truncate permission under inode lock
      NFSD: Encode only the status in NFS-ACL v2 GETACL error replies
      NFSD: Fix off-by-one in DRC bucket pruning limit
      nfsd: Reset write verifier when async COPY writeback fails
      nfsd: sample writeback error cursor before async COPY loop
      nfsd: gate nfs2 setacl by argp->mask
      NFSD: Prevent lock owner use-after-free during client teardown
      NFSD: Prevent client use-after-free during NFSv4.0 revoked-state cleanup
      SUNRPC: Check svc pool percpu counter allocation
      SUNRPC: Reject krb5 v2 wrap tokens with oversized ec field
      svcrdma: Reject connection when transport allocation fails
      svcrdma: Reject inline replies that overflow the pull-up buffer
      svcrdma: Validate Read chunk positions before reconstruction

Chunkai Deng (1):
      rpmsg: glink: smem: order FIFO read after availability check

Claudiu Beznea (3):
      i3c: renesas: Check that the transfer is valid before accessing it
      i3c: renesas: Clean DATBAS register on detach
      i3c: renesas: Reconfigure the DATBAS register on re-attach

Coly Li (1):
      md: do overflow check for sb->bblog_shift in super_1_load()

Cong Nguyen (3):
      media: staging/ipu7: fix async notifier UAF on probe error path
      hwmon: (max6621) fix negative temperature offset and crit readings
      hwmon: (max6621) fix temperature clamp range

Corey Minyard (1):
      ipmi:msghandler: Cancel work cleanly on an error

Daisuke Matsuda (1):
      fpga: altera-cvp: Avoid out-of-bounds read in trailing byte write

Daniel Borkmann (2):
      bpf: Fix incorrect pruning due to atomic fetch precision tracking
      bpf: Disable preemption in __bpf_get_stack

Dave Airlie (1):
      nouveau/gem: reserve the bo in the info ioctl around the vma lookup

David Hildenbrand (Arm) (1):
      mm/gup: fix always draining LRU caches in collect_longterm_unpinnable_folios()

David Howells (1):
      netfs: Fix missing locking around retry adding new subreqs

David Lee (1):
      udf: reject VAT indexes equal to the entry count

Dawei Feng (2):
      wifi: iwlwifi: dvm: fix memory leak in iwl_op_mode_dvm_start()
      wifi: rtw88: pci: fix resource leak on failed NAPI setup

Deepanshu Kartikey (2):
      tracing: Fix use-after-free in trace_pipe read on sub-buffer order change
      eventfs: Initialize ei->children and ei->list in init_ei()

Denis Batishchev (1):
      ALSA: hda/realtek: Enable micmute LED on HP EliteBook 6 G1a p/n: AD3Q9ET#UUG

Dev Jain (1):
      mm/rmap: use huge_ptep_get() in try_to_unmap_one()

Devin Wittmayer (1):
      wifi: mt76: mt7925: cancel mlo_pm_work on stop

Dmitry Antipov (1):
      ocfs2: always run deallocs on copy-on-write completion

Doruk Tan Ozturk (2):
      HID: sony: fix UAF of ghl_poke_timer / ghl_urb at driver unbind
      wifi: ath6kl: clamp assoc request/response lengths before subtracting IE offsets

Eckhart Mohr (1):
      ALSA: hda/realtek: Add quirk for TongFang XxAF5xxx

Eric Biggers (2):
      crypto: sun8i-ce - Remove crypto_rng interface
      crypto: sun8i-ss - Remove crypto_rng interface

Eric Dumazet (1):
      ip_tunnel: adapt iptunnel_xmit_stats() to NETDEV_PCPU_STAT_DSTATS

Ethan Nelson-Moore (1):
      ARM: 9477/1: Disable broken eBPF JIT on the Risc PC

Ewan D. Milne (1):
      nvme: nvme-fc: Fix nvme_fc_create_hw_io_queues() queue deletion in error path

FUJITA Tomonori (2):
      rust: time: fix as_micros_ceil() rounding near i64::MAX
      rust: bug: skip arch-specific asm in `testlib` builds

Fabio Estevam (3):
      arm64: dts: rockchip: Fix rk3399-roc-pc-plus analog audio
      arm64: dts: rockchip: Fix rk3588s-roc-pc audio description
      wifi: mwifiex: Detach sync cmd buffer on interrupted wait

Fabio Porcedda (1):
      net: usb: qmi_wwan: add Telit Cinterion FE990D50 composition

Fan Wu (14):
      usb: gadget: at91_udc: drain polled-VBUS timer/work before udc is freed
      usb: typec: thunderbolt: Disable work before freeing tbt on remove
      RDMA/cxgb4: Cancel reg_work before freeing device on remove
      power: supply: bq24257: fix use-after-free on remove
      power: supply: bq256xx: drain usb_work before freeing the charger
      power: supply: charger-manager: register regulators before exposing sysfs
      power: supply: lp8727: fix use-after-free in lp8727_release_irq()
      power: supply: lp8788-charger: fix use-after-free on remove
      power: supply: qcom_battmgr: fix use-after-free
      power: supply: rt9455: quiesce delayed work before teardown
      power: supply: ucs1002: fix use-after-free on remove
      mmc: via-sdmmc: cancel card-detect work on remove
      mmc: via-sdmmc: stop card-detect handling on probe failure
      wifi: rtl8xxxu: fix use-after-free from rx_urb_wq on stop

Fan Ye (2):
      net: thunderbolt: Release the Rx HopID that was handed out on mismatch
      net: thunderbolt: Mark the connection down when bringing it up fails

Fangzhi Zuo (1):
      drm/amd/display: Prune per-tile Timing from Apple Studio Display Primary Tile

Farhan Ali (1):
      PCI/MSI: Enable memory decoding before restoring MSI-X messages

Felix Fietkau (1):
      wifi: mt76: mt7996: fix TX DMA mapping leak for AddBA req frames

Felix Gu (1):
      phy: fsl-imx8mq-usb: fix typec switch leak on probe error path

Felix Yan (1):
      clocksource/drivers/timer-sun4i: Advertise a real minimum delta

Florian Fuchs (1):
      fbdev: pvr2fb: correct user pointer annotation and sentinel initializer

Francesco Lavra (1):
      usb: dwc2: gadget: Exit partial power down state when changing USB pull-up

Frank Sorenson (5):
      cifs: clear tcon after cifsFileInfo_put() in cifs_file_set_size()
      cifs: fix loff_t underflow in cifs_remap_file_range() when len == 0
      cifs: use cifs_invalidate_cache() in cifs_do_truncate() for O_TRUNC
      smb: client: fix ALIGN() overflow in symlink_data() error context loop
      smb: client: fix copy-paste error in WSL EA length accounting for $LXDEV

Fredric Cover (2):
      smb: client: clear ce->tgthint in free_tgts()
      smb: client: harden DFS cache against invalid target hints

Gaurav Batra (1):
      powerpc/pseries/iommu: switch to Default DMA window during kdump

Gongwei Li (1):
      Bluetooth: hci_uart: Fix false success return in hci_uart_setup()

Greg Kroah-Hartman (1):
      Linux 6.18.50

Guanghui Yang (1):
      btrfs: drop recovered reloc root refs on recovery failure

Guangshuo Li (5):
      HID: intel-thc-hid: intel-quicki2c: fix autosuspend cleanup during teardown
      HID: intel-thc-hid: intel-quickspi: fix autosuspend cleanup during teardown
      Bluetooth: hci_bcm: fix usage_count leak when autosuspend_delay is negative
      Bluetooth: hci_h5: fix usage_count leak when autosuspend_delay is negative
      Bluetooth: hci_intel: fix usage_count leak when autosuspend_delay is negative

Guillaume Morin (1):
      hugetlb: only adjust reservation during unmapping if mapcount is 0

Guopeng Zhang (4):
      mm: memcg-v1: fix wrong linux-mm list address in deprecation warnings
      mm: memcg-v1: fix memsw and TCP failcnt accounting
      mm: memcg: stop reclaim when a limit update is superseded
      mm: memcontrol: update state_local when flushing NMI stats

Günther Noack (1):
      landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout creation

HanQuan (1):
      ecryptfs: reject oversized encrypted_key_size in parse_tag_3_packet

Hang Nan (1):
      Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready

Hans Verkuil (1):
      Revert "media: v4l2-dev: fix error handling in __video_register_device()"

Hao Jia (1):
      mm/zswap: fix global shrinker when memory cgroup is disabled

Hao-Qun Huang (3):
      staging: greybus: hid: fix SET_REPORT return value
      staging: media: tegra-video: fix of_node_put() on VIP parse errors
      staging: media: tegra-video: vi: fix probe failure on skipped last port

Haotian Zhang (1):
      dm-switch: use WRITE_ONCE() in switch_region_table_write()

Haoxiang Li (1):
      HID: sensor: custom: Fix field sysfs group cleanup on failure

Harshit Varu (1):
      mptcp: fix uninitialized local_id in syncookie MP_JOIN reconstruction

Helge Deller (1):
      sticon/parisc: Detect default STI graphics card for console output

Hidayath Khan (3):
      net/smc: fix socket refcount leak in smc_switch_conns()
      net/smc: fix use-after-free in smc_rx_pipe_buf_release()
      net/smc: stop killed, freed and out_of_sync sharing a byte

Hongyan Xu (1):
      auxdisplay: charlcd: cancel backlight work on registration failure

Huang Wei (1):
      usb: typec: ucsi: use UCSI_TIMEOUT_MS for sync command completion

Hui Su (5):
      tracing: Fix crash passing ERR_PTR to kthread_stop()
      tracing: Fix use-after-free with same-name named triggers
      fbdev: ssd1307fb: defer I2C transfers from damage callbacks
      cpufreq: schedutil: Fix rate limit overflow
      kasan: fix cache shrink race with CPU hotplug

HyeongJun An (8):
      HID: intel-thc-hid: intel-quickspi: validate report size before copy
      HID: intel-thc-hid: intel-quickspi: bound GET_REPORT response to the caller buffer
      Bluetooth: eir: Fix OOB read in eir_get_service_data()
      ALSA: ump: Fix corrupted data bytes at MIDI 1.0 SysEx to UMP conversion
      power: supply: qcom_battmgr: terminate the strings from firmware
      platform/x86: dell-wmi-sysman: Don't hex dump attribute security buffer
      platform/x86: ISST: Validate level in perf mask ioctls
      platform/x86: ISST: Validate socket ID in clos_assoc ioctl

Hyunwoo Kim (4):
      apparmor: fix out-of-bounds write when null terminating a label vec
      mm/pagewalk: fix stale walk->action escaping walk_pmd_range()
      sctp: stop processing a packet once its association is deleted
      sctp: drop a chunk if its transport was removed

Ibrahim Abdelkader (1):
      Bluetooth: hci_sync: Clear HCI_CMD_PENDING when dropping the last request

Ibrahim Hashimov (3):
      ubifs: fix out-of-bounds read in signature length check
      HID: picolcd: clamp eeprom debugfs read to bytes actually received
      ocfs2: validate rl_used against rl_count in refcount block validator

Ilya Krutskih (1):
      dm raid1: reserve space for NUL-terminator in build_constructor_string()

Ilya Maximets (1):
      net: openvswitch: fix flow mask use-after-free on flow deletion

Injae Ryou (1):
      selftests/mm: fix on-fault-limit false failure under sudo-rs

Ivaylo Dimitrov (1):
      hsi: omap_ssi_core: fix missing DMA mask setup for SSI controller device

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: fix emmc reset polarity on px30-cobra

James Kim (1):
      rapidio: mport_cdev: fix use-after-free in dma_req_free()

Jameson Thies (1):
      power: supply: cros_usbpd: Limit port counts to EC_USB_PD_MAX_PORTS

Jann Horn (2):
      apparmor: fix cred UAF caused by begin_current_label_crit_section()
      smack: fix cred UAF in smack_file_send_sigiotask()

Jason Gunthorpe (1):
      RDMA/uverbs: Add UVERBS_ATTR_UHW to UVERBS_METHOD_REG_MR

Jason Yang (1):
      phy: rockchip-samsung-dcphy: fix out-of-range max_register

Jeff Layton (35):
      nfsd: RCU-protect cl_cb_session to fix use-after-free on session teardown
      nfsd: return NFS4ERR_NOTSUPP for unsupported netloc4 types
      nfsd: validate nseconds in TIME_DELEG decode paths
      nfsd: validate sockaddr length per family in listener_set
      nfsd: validate symlink target length in NFSv4 CREATE
      nfsd: add fh_want_write() for early-verified SETATTR in nfsd_proc_setattr()
      nfsd: add filehandle match check to nfsd4_delegreturn()
      nfsd: add missing read barrier to rpc_status_get dumpit seqcount retry
      nfsd: block non-SAVEFH ops after FOREIGN PUTFH to prevent NULL deref
      nfsd: check client ownership when cancelling a copy-notify stateid
      nfsd: clear CALLBACK_RUNNING on failed delegation recall queue
      nfsd: clear opcnt on compound arg release to prevent OOB read
      nfsd: defer setting NFSD4_CALLBACK_RUNNING in deleg_reaper
      nfsd: defer vfree of compound ops to fix rpc_status UAF
      nfsd: don't free session slots that are still in use
      nfsd: drop the stateid, not the stateowner, on seqid_op replay retry
      nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on racing delegation revoke
      nfsd: fix dentry ref leak on V4ROOT export filehandle lookup
      nfsd: fix FL_SLEEP being set unconditionally for all LOCK types
      nfsd: fix netlink dumpit error handling for rpc_status_get
      nfsd: fix nfsd_file leak on inter-server COPY setup failure
      nfsd: fix refcount leak in nfsd_file_lru_add on insertion failure
      nfsd: fix reply size estimate for GET_DIR_DELEGATION
      nfsd: fix stale s2s_cp_stateids IDR entry for async COPY
      nfsd: fix version mismatch loops in nfsd_acl_init_request()
      nfsd: fix XDR length calculation in nfsd4_ff_encode_layoutget
      nfsd: fix XDR padding calculation in ff_encode_getdeviceinfo
      nfsd: initialize copy-notify stateid before publishing it
      nfsd: initialize DRC hash table before registering shrinker
      nfsd: move nfsd_debugfs_init() after nfsd4_init_slabs() in init_nfsd()
      nfsd: reject reclaim LOCK after RECLAIM_COMPLETE
      nfsd: revoke copy-notify stateids before dropping their reference
      sunrpc: route to a populated pool in svc_pool_for_cpu()
      SUNRPC: always drain cache_cleaner before destroying a cache_detail
      sunrpc: defer rq_argp and rq_resp free until after RCU grace period

Jeffin Philip (2):
      usb: gadget: uvc: Fix null pointer dereference in uvcg_video_init()
      usb: gadget: uvc: fix dangling pointers in uvc_function_bind() and uvc_function_unbind()

Jerry Zuo (1):
      drm/amd/display: hide Apple Studio Display secondary tile

Jia Zhu (1):
      buffer: avoid tail commit walk for uptodate folios

Jiacheng Yu (1):
      params: fix charp corruption on allocation failure

Jiangshan Yi (3):
      HID: mcp2221: stop device IO before hid_hw_stop
      HID: mcp2221: validate report size in mcp2221_raw_event()
      bnx2x: fix double free in bnx2x_init_firmware() error path

Jianing Li (3):
      power: supply: max17040: propagate register read errors
      power: supply: max17040: drop incorrect I2C functionality check
      power: supply: max17040: synchronize work cancellation on suspend

Jianyun Gao (2):
      dm-pcache: fix implicit u8 truncation of gc_percent in message handler
      dm-pcache: fix use-after-free and invalid seg operations in kset_replay()

Joe Damato (1):
      bnxt_en: Write doorbell when linearizing skb fails

Johan Hovold (2):
      USB: phy: fsl-usb: fix missing static keywords
      remoteproc: scp: Fix device reference leak on failed lookup

Johannes Weiner (4):
      mm: compaction: support non-movable compaction for pageblock requests
      mm: mempolicy: fix automatic numa balancing for shmem
      mm: page_alloc: __GFP_FS lockdep annotation for direct compaction
      mm: page_alloc: fix non-movable reclaim storm in defrag_mode

Jordan R Abrahams-Whitehead (1):
      include/linux/list.h: mark list_add and __list_add as __always_inline

Jorijn van der Graaf (1):
      net: ipa: fix stalled modem TX queue after runtime resume

Joseph Qi (3):
      ocfs2: cluster: don't sleep while holding o2hb_live_lock in o2hb_region_pin()
      ocfs2: cluster: avoid lock order inversion in o2hb_region_pin() from drop_item
      ocfs2: cluster: fix o2hb_dependent_users leak on pin failure

Joshua Crofts (1):
      usb: gadget: midi2: remove default configfs groups on teardown

Joy H.J. Lee (1):
      tools/compiler: match glibc 2.42 definition of __attribute_const__

Julian Haarmann (1):
      platform/x86: lenovo/ymc: Only match lower byte in WMI lid switch query response

Jun Yang (2):
      sctp: distinguish sequence zero from wildcard in reconf lookup
      sctp: fix stream->outcnt underflow on duplicate RECONF responses

Junjie Cao (1):
      Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to 0bda:a728

Junrui Luo (2):
      media: vicodec: fix out-of-bounds write in FWHT encoder
      NFSv4.1: fix layout segment leak on the pnfs_layout_process() forget path

Jérémy Jean (7):
      timers/itimer: Zero-init old itimerval before copy to userspace
      tracing/user_events: Clear copied tracing state before fork duplication
      libceph: reject buckets with mismatched CRUSH ids
      ceph: reject export_targets ranks >= CEPH_MAX_MDS in mdsmap decode
      audit: avoid dropping live tree ref on fsnotify rule autoremove
      bpf: Harden bloom filter sizing and indexing on 32-bit kernels
      SUNRPC: wait for in-flight client TLS handshake callback

Karl Mehltretter (3):
      serial: imx: serialize imx_uart_ports[] lifetime
      arm64: compat: Fix decrementing LDM/STM alignment emulation
      arm64: proton-pack: Restore the nospectre_bhb command-line option

Kathiravan Thirumoorthy (1):
      regulator: qcom-refgen: correct the regulator type to CURRENT

Keith Busch (1):
      dm-io: clone the source bio instead of copying its biovec

Kevin Tian (2):
      iommu/vt-d: Fix no_iommu to disable platform opt-in
      iommu/vt-d: Force requesting ACS when tboot is enabled

Kiryl Shutsemau (Meta) (3):
      x86/insn-eval: Move assign_register() out of KVM as insn_assign_reg()
      x86/tdx: Fix off-by-one in port I/O handling
      x86/tdx: Fix zero-extension for 32-bit port I/O

Koichiro Den (6):
      NTB: ntb_transport: Recycle TX entries before client callbacks
      NTB: ntb_transport: Fail TX enqueue when the QP link is down
      NTB: ntb_transport: Reject oversized TX buffers
      net: ntb_netdev: Fix TX busy and drop handling
      net: ntb_netdev: Avoid double-accounting netif_rx() drops
      net: ntb_netdev: Count packets dropped on RX refill failure

Konstantin Komarov (1):
      fs/ntfs3: bound page_lcns[] index by the log record

Krzysztof Kozlowski (1):
      arm64: dts: qcom: sm6115-pro1x: Correct touchscreen GPIO flags

Krzysztof Wilczyński (7):
      PCI/sysfs: Fix out-of-bounds read in pci_write_legacy_io()
      alpha/PCI: Fix I/O port accessor argument order in pci_legacy_write()
      PCI/sysfs: Fix read byte order in pci_read_legacy_io()
      PCI/sysfs: Avoid spurious runtime PM wakeup on config space accesses
      PCI/proc: Avoid spurious runtime PM wakeup on config space accesses
      PCI/proc: Use file_ns_capable() when checking config space read access
      PCI/proc: Warn on writes to kernel-exclusive config space regions

Kuan-Wei Chiu (2):
      coresight: etm3x: Fix cntr_val_show() to match cntr_val_store() behavior
      interconnect: Fix use after free in icc_get() and of_icc_get_by_index()

Laxman Acharya Padhya (2):
      io_uring/query: cap user size passed to copy_struct_to_user
      wifi: mt76: mt7996: validate default EEPROM firmware size

Longlong Xia (1):
      zsmalloc: account for handle size in class lookup

Lorenzo Stoakes (1):
      mm: avoid unnecessary use of is_swap_pmd()

Lorenzo Stoakes (ARM) (1):
      Bluetooth: hci_bcm4377: Ignore reserved PHY in ext adv reports on BCM4378

Lukas Wunner (2):
      PCI/AER: Emit TLP Log only for unmasked errors
      PCI/AER: Fix mapping of errors to agent & layer

Luxiao Xu (1):
      sunrpc: fix use-after-free in __rpc_clnt_handle_event and __rpc_clnt_remove_pipedir

Ma Ke (2):
      power: supply: bq25890: Fix power_supply reference leak
      platform/x86: ishtp_eclite: Fix ACPI device reference leak in probe error path

Maoyi Xie (3):
      power: supply: twl4030_charger: cancel workers via devm
      i3c: master: svc: bound IBI payload to the requested max_payload_len
      w1: ds28e17: reject an oversize length on an I2C block read

Marek Czernohous (1):
      forcedeth: fix off-by-one when saving/restoring non-PCI config space

Mario Limonciello (3):
      platform/x86/amd/pmc: Restore msg_port on amd_stb_s2d_init() error paths
      platform/x86/amd/pmc: Propagate SMU errors and validate S2D address
      platform/x86/amd/pmc: Fix LPS0 and debugfs leaks when STB init fails

Matt Turner (4):
      alpha: fix ieee_swcr_to_fpcr setting FPCR_DNOD unconditionally
      alpha: don't leak hardware-fabricated FP exception bits to user space
      alpha: marvel: Fix irq_set_status_flags to use correct IRQ number
      alpha: marvel: Fix lock ordering in init_io7_irqs()

Matthew Brown (1):
      ceph: fix leaked inode reference on writeback abort at umount

Max Kellermann (3):
      ceph: do not repeat ceph_trim_dentries() if no progress possible
      jbd2: bound shrinker scans by examined checkpoint buffers
      jbd2: check need_resched() when skipping busy checkpoint buffers

Max Lee (1):
      PCI/ASPM: Avoid L0s for Realtek RTS525A

Michael Bommarito (7):
      NFSD: restart ssc_expire_umount walk after dropping nfsd_ssc_lock
      libceph: validate OSD extent maps before cursor advance
      ceph: bound copied dentry name length in NFS export get_name
      ceph: bound MDSCapAuth path and fs_name decode in handle_session()
      ceph: bound num_export_targets array for mds info v2/v3
      ceph: bound xattr value length in __build_xattrs()
      lockd: pin next file across nlm_inspect_file lock-drop

Michael Scott (1):
      arm64: dts: qcom: x1-dell-thena: mark l12b and l15b always-on

Miguel Ojeda (1):
      rust: rust_is_available: warn for `bindgen` < 0.72.1 && libclang >= 22

Mike Snitzer (1):
      NFSD: remove flawed WARN_ON_ONCE from nfsd_mode_check

Mikulas Patocka (2):
      dm-io: report non-retryable errors separatedly
      dm-stats: fix a crash if allocation of per-cpu data fails

Mohamad Raizudeen (1):
      PCI: Fix 32-bit config write in Intel PCH Root Port MPC ACS quirk

Muhammad Bilal (11):
      accel/rocket: fix NULL dereference and integer overflow in rocket_job_push()
      platform/x86: hp-bioscfg: accept reduced ACPI packages from older HP BIOS
      platform/x86: hp-bioscfg: advance elem past consumed array elements
      platform/x86: hp-bioscfg: bound ordered-list parsing by the package count
      platform/x86: hp-bioscfg: fix heap OOB read in sk_store() and kek_store()
      platform/x86: hp-bioscfg: fix heap OOB read on empty password write
      platform/x86: hp-bioscfg: fix new_password_store() overwriting current_password
      platform/x86: hp-bioscfg: fix off-by-one write in hp_get_string_from_buffer()
      platform/x86: hp-bioscfg: fix ORD_LIST_ELEMENTS never being parsed
      platform/x86: hp-bioscfg: pass validated element count to package parsers
      platform/x86: hp-bioscfg: warn on element type mismatch instead of failing

Myeonghun Pak (4):
      usb: gadget: snps_udc_plat: clean up PHY on probe deferral
      fbdev: uvesafb: unregister connector callback on init failure
      nvme-pci: disable controller on admin queue IRQ setup failure
      tpm: tpm_i2c_nuvoton: disable IRQ on wait timeout

Nam Cao (1):
      riscv: unaligned: stop using kthread for check_vector_unaligned_access()

Naman Jain (1):
      PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip

Nate Prodromou (1):
      NFS: fix delegation_hash_table leak when nfs4_server_common_setup() fails

Nathan Chancellor (1):
      arch_numa: avoid false positive fortify warning in setup_node_to_cpumask_map()

Neill Kapron (1):
      usb: gadget: f_fs: Prevent deadlock during ep0 read loop

Nicolin Chen (1):
      iommu/tegra241-cmdqv: Reject a vSID wider than the SID_MATCH field

Niklas Cassel (1):
      ata: libata-scsi: fix DSM TRIM for sector sizes larger than 2048 bytes

Nikol Kuklev (1):
      nfsd: fix null dereference in nfsd4_setattr for deleg timestamp attrs

Nikolai Grlica (1):
      rust: kernel: list: fix incorrect pop_back example comment

Nirmoy Das (1):
      ACPI: APEI: Fix ERST timeout unit conversion

Norbert Szetei (4):
      RDMA/ucma: Lock the handler in ucma_set_ib_path()
      RDMA/ucma: Lock the handler in ucma_write_cm_event()
      openvswitch: only skb_tx_error() a packet we are about to drop
      net: skbuff: don't touch shared zerocopy state in skb_tx_error()

Oleg Nesterov (1):
      sysctl: move the "cad_pid" entry from pid_table[] to kern_reboot_table[]

Oren Klopfer (1):
      Revert "arm64: dts: rockchip: Further describe the WiFi for the Pinephone Pro"

Pei Xiao (1):
      usb: dwc3: gadget: Fix use-after-free in dwc3_gadget_free_endpoints due to race condition

Peixin Xie (1):
      riscv: acpi: Handle LPI architectural context loss flags

Peiyang He (2):
      iommu: Fix dev_iommu memory leak when device_add fails in iommu_mock_device_add
      iommufd: Fix UAF in selftest IOPF reporting

Pengpeng Hou (1):
      eCryptfs: bound the packet-length peek to the user buffer

Petr Vaganov (1):
      scsi: core: Fill in DMA padding bytes in scsi_alloc_sgtables()

Prasanna Kumar T S M (1):
      cdx: Fix double free when sysfs file creation fails

Qing Ming (1):
      mpls: reload header after pskb_may_pull()

Qu Wenruo (1):
      btrfs: do not overwrite NODATASUM flag when removing NODATACOW flag

Quentin Schulz (2):
      arm64: dts: rockchip: fix eMMC reset polarity on PP-1516
      arm64: dts: rockchip: fix eMMC reset polarity on PX30 Ringneck

Ralf Lici (1):
      ovpn: run deferred work on a module-owned workqueue

Ridong Chen (1):
      mm: vmscan: fix node reclaim ignoring swappiness parameter

Robbie Ko (2):
      nfsd: reject out-of-range nseconds in NFSv3 SETATTR and create ops
      nfsd: reject out-of-range useconds in NFSv2 SETATTR/CREATE

Rochan Avlur (1):
      fuse: wait for FR_FINISHED on abort_on_kill to prevent use-after-free

Roman Li (1):
      drm/amd/display: Skip PHY SSC reduction on some 8K panels

Ronald Claveau (1):
      PCI: meson: Fix GPIO state while requesting PERST#

Rong Zhang (1):
      platform/x86: lenovo-wmi-helpers: Fix memory leak in lwmi_dev_evaluate_int()

Runyu Xiao (6):
      fbdev: omapfb: panel-dsi-cm: initialize lock before registering display
      net: ibm: emac: mal: fix NAPI locking
      ALSA: pcxhr: initialize mutexes before requesting threaded IRQ
      i3c: master: adi: initialize the lock before enabling interrupts
      wifi: rtlwifi: rtl8192du: check QoS TID before indexing tids
      wifi: mt76: mt7615: avoid waiting for mac work under the mt76 mutex

Ruoyu Wang (2):
      i2c: mxs: fix DMA channel leak on probe error
      net: openvswitch: fix nf_connlabels leak in ovs_ct_init

Ryusuke Konishi (1):
      nilfs2: fix slab-out-of-bounds in nilfs_direct_propagate after truncation

Samuel Page (1):
      fs/ntfs3: fix info-leak on partial LZNT decompress in ni_read_frame()

Sanman Pradhan (1):
      hwtracing: hisi_ptt: Propagate DMA reset timeout in trace_start()

Seiji Nishikawa (1):
      ipmi: si: Fix NULL pointer dereference after failed registration

Sergey Senozhatsky (1):
      zram: validate deflate params

Shameer Kolothum (1):
      iommu/arm-smmu-v3: Manage teardown with devm

Shibo Zhu (1):
      PM: sleep: Unblock runtime PM when device prepare fails

Shuai Xue (4):
      iommu/amd: Put PCI device after handling PPR faults
      iommu/sva: Set handle->dev before the SVA handle is visible
      iommufd: Avoid locking internal accesses during unmap
      iommufd: Release current IOAS on xa_store() failure

Shuangpeng Bai (2):
      btrfs: fix extent map leak in NOCOW direct I/O write
      lockd: fix NULL dereference on lockowner allocation failure

Shuvam Pandey (1):
      accel/rocket: initialize job domain before cleanup paths

Sonali Pradhan (1):
      usb: gadget: u_audio: Fix use-after-free on sound card disconnect

Srinivas Pandruvada (7):
      platform/x86: ISST: Add a NULL check for sst_inst[]
      platform/x86: ISST: Just allow 2 bits for SST feature enable
      platform/x86: ISST: Use PP level enable mask
      platform/x86: ISST: Validate logical CPU id and clos id
      platform/x86: ISST: Validate parameter for core power state
      platform/x86: ISST: Validate parameter for frequency and priority
      platform/x86: ISST: Return error during profile addition

Srinivasan Shanmugam (1):
      drm/amd/display: Avoid NULL dereference in dc_dmub_srv error paths

Stanislaw Gruszka (2):
      module/kallsyms: fix nextval for data symbol lookup
      wifi: rtl818x: initialize eeprom_93cx6 struct to zero

Stefan Haberland (3):
      s390/dasd: Do not complete a failed ESE read as successful
      s390/dasd: Guard sysfs discipline callbacks against unallocated private data
      s390/dasd: Propagate partial completion length across ERP recovery

Stuart Hayhurst (1):
      HID: corsair-void: Check size of status and firmware events before reading them

Takashi Iwai (6):
      ALSA: aloop: Check card index validity at probe
      ALSA: mpu401: Check card index validity at probe
      ALSA: mts64: Check card index validity at probe
      ALSA: portman2x4: Check card index validity at probe
      ALSA: serial-u16550: Check card index validity at probe
      ALSA: virmidi: Check card index validity at probe

TanZheng (1):
      ACPI: APEI: GHES: fix ARM section length accounting after header

Terry Bowman (1):
      acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks

Thiébaud Weksteen (1):
      module: validate string table section types

Thomas Gleixner (1):
      timer: Keep debugobjects state consistent in migrate_timer_list()

Thomas Richard (1):
      mfd: cgbc: Fix teardown ordering in cgbc_remove()

Thomas Richter (1):
      s390/cpum_cf: Handle CPU hotplug via prepare/dead callbacks

Thomas Weißschuh (Schneider Electric) (1):
      timekeeping: Check the return value of tk_get_aux_ts64 in __do_adjtimex()

Thorsten Blum (3):
      platform/x86: think-lmi: Fix certificate thumbprint sysfs output
      platform/x86: think-lmi: Free system certificate signatures
      platform/x86: think-lmi: Fix current password length check

Tien Sung Ang (1):
      fpga: stratix10-soc: Fix SVC mailbox handling during reconfiguration

Tim Harvey (1):
      PCI: Add ACS quirk for Pericom PI7C9X2G608 switches [12d8:2608]

Tim Menninger (1):
      pNFS: Fix EBUSY check in pnfs_layout_need_return

Timur Kristóf (1):
      drm/amd/display: Refactor amdgpu_dm_connector_detect (v2)

Tzung-Bi Shih (1):
      platform/chrome: sensorhub: Fix dropped timestamp events and log spam

Vaibhav Nagare (1):
      qede: Fix NULL pointer dereference in TPA fragment processing

Valentin Kindschi (2):
      Bluetooth: hci_conn: re-enable advertising only for peripheral role
      Bluetooth: hci_event: clear HCI_LE_ADV only on a created connection

Vincent Donnefort (5):
      tracing: Fix logged instance name on creation failure
      ring-buffer: Fix subbuf resize race with ring_buffer_alloc_read_page()
      ring-buffer: Free cpu_buffer::free_page with subbuf_order
      ring-buffer: Hold cpu_buffer::lock when resizing a subbuf
      ring-buffer: Fix subbuf resize race with ring buffer readers

Vincent Mailhol (1):
      lib/ucs2_string.c: fix out-of-bounds read in ucs2_strnlen()

Vineet Gupta (1):
      bpf, x86: Fix per-CPU address resolution into an extended register

Vlastimil Babka (SUSE) (1):
      mm: page_alloc: move capture_control to the page allocator

Weigang He (1):
      media: cec: stm32: prevent out-of-bounds write on RX overflow

Weimin Xiong (1):
      iommu/msm: Unwind probe state on registration failure

Weiming Shi (2):
      sctp: fix NULL deref on untransmitted RECONF completion
      xdp: fix zero-copy frame layout

WenTao Liang (3):
      clocksource/drivers/nxp-pit: Fix IRQ leak on cpuhp_setup_state error path
      regulator: as3722_get_regulator_dt_data: fix premature of_node_put leaving dangling of_node pointer
      regulator: max8998_pmic_dt_parse_pdata: of_node_put on reg_np after ownership transferred to rdata

Wentao Guan (1):
      wifi: mt76: mt7925: cancel pending mlo_pm_work

Xiang Mei (1):
      fs/ntfs3: validate dirty page table on log replay

Xin Chen (1):
      Bluetooth: hci_core: use skb_get() instead of skb_clone() for req_skb

Xingrui Li (1):
      HID: sensor-hub: Fix out-of-bounds write in sensor_hub_get_feature

Xiubo Li (1):
      ceph: fix UAF in __kick_flushing_caps() on cf entry freed during unlock

Xu Rao (3):
      HID: roccat: free buffered reports when destroying device
      ALSA: hda/ext: preserve PPLCCTL bits when clearing reset
      zloop: truncate finished zones to zone capacity

Xu Yang (2):
      device property: fix infinite loop in fwnode_for_each_child_node()
      usb: typec: tcpci: pass correct rx_type to tcpm_pd_receive()

Xuanqiang Luo (2):
      net: ravb: avoid dereferencing an invalid PTP clock
      net: ravb: serialize PTP clock teardown

Yao Zi (1):
      x86/locking: Use sfence for wmb() if SSE is available

Yehyeong Lee (7):
      nvme: zero the discard fallback page
      nvme-tcp: do not accept C2HData based on blk_rq_payload_bytes() alone
      nvme-tcp: fix host memory disclosure on R2T for a read command
      nvme-tcp: reject a read that transferred too few bytes
      net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages
      net/smc: fix use-after-free of the LLC qentry in smc_llc_srv_add_link()
      net/smc: carry oversized SMC-Rv2 LLC messages in the queue entry

Yemu Lu (1):
      fat: restore original value when fat_ent_write failed

Yichong Chen (6):
      ecryptfs: fix tag 11 packet exact-fit size check
      ecryptfs: hold msg ctx list lock when cleaning daemon queue
      ecryptfs: pass packet set buffer size to parser
      ecryptfs: reject too-small tag 70 packets
      ecryptfs: release message context on send failure
      ecryptfs: show filename encryption options

Yifei Gao (2):
      orangefs: fix double-free of trailer_buf on readdir copy failure
      ipmi: Fix use-after-free of cmd_rcvr in _ipmi_destroy_user()

Yousef Alhouseen (1):
      ipmi: ipmb: validate write message length

Yuho Choi (1):
      ipmi: Remove all sysfs files on registration failure

Yun Zhou (1):
      usb: gadget: f_tcm: fix deadlock in usbg_make_tpg()

Yunye Zhao (1):
      md/raid10: fix still_degraded being inverted in raid10_sync_request()

Yuyang Huang (1):
      ipv6: use RCU iterator to dump route exceptions

Zhan Xusheng (2):
      ocfs2: fix readdir position truncation on 32-bit kernels
      udf: Fix i_lenExtents truncation on 32-bit kernels

Zhang Heng (1):
      ALSA: hda/realtek: Fix Lenovo Yoga Slim 7 14AKP10 quirk ordering

ZhaoJinming (1):
      accel/rocket: Fix error path handling in rocket_job_run()

Zhenghang Xiao (1):
      nfsd: set SC_STATUS_FREED in nfsd4_drop_revoked_stid for delegations

Zhenhao Wan (1):
      cxl/features: bound fwctl command payload to the input buffer

Zhiling Zou (6):
      ip: orphan prefetched skbs before multicast forwarding
      ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
      ip6_gre: fix hardware header length for NBMA tunnels
      orangefs: skip leading spaces before parsing client debug masks
      net: cap advertised IP tunnel headroom
      seg6: reset IP6CB after IPv6 decapsulation

Zi Yan (1):
      xarray: honor XA_FLAGS_ACCOUNT in xas_split_alloc()

Zide Chen (1):
      perf/x86/intel/uncore: Fix die ID init and look up bugs

Zihan Xi (1):
      net: l2tp: do not propagate multicast notification errors

Zilin Guan (2):
      wifi: mt76: Fix memory leak after mt76_connac_mcu_alloc_sta_req()
      wifi: ath11k: fix memory leaks in beacon template setup

liyouhong (1):
      dm-era: fix shadowed superblock leak on take-snap failure

胡连勤 (1):
      block: set QUEUE_FLAG_DYING unconditionally in blk_mark_disk_dead()

