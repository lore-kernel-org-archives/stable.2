Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E243F8BE;
	Mon, 14 Sep 2026 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387081; cv=none; b=Dmr6ON67twAWzXXlYy7wSyKiHCl53zda7fAcwL0M3VZAWBZ0ffzuShA+AYvfyTsnQiKXTyjPF89UlcmIYuk2nPBY25j31G93Ikp/z9dmJD1Z9OGxdy76293/rvIKJ6S9BMyvHtyblAoIxnv7CYRBF8fkOBZrU/OYKXDfFnCztyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387081; c=relaxed/simple;
	bh=4xA4RD1BzQ6CaTg5F51rmjP+77QL90vAm0wzK9dmeOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jaFMVb84e3Ed8wizDIAkfRc8KGBAV7HuCZZ2bl+rGCmdHhGhO46G6fEqyMurDidokWz4xS84hoGbz99a2N7AonG3IYeZsbq8OqqGOZa55pFRC4ESNym26jxUeubQPrOpXEb87hjOx9CWnyVPRtcQXrtG7/+DGK+CJJhsiIUdYT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tEpfubz/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tEpfubz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F6E1F00898;
	Mon, 14 Sep 2026 11:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789387076;
	bh=9G51dUv6QsXFNlvXqTSrsrocETRPCU3HpTG4pwX4SbU=;
	h=From:To:Cc:Subject:Date;
	b=tEpfubz/dDxgaqNlSfsAQfYapPRRRborLzj2UDamvaeY/Oeu43URYT0cpWt1BKJrX
	 k4S9ORLjpw+oC+exCBYr2f7PxpjYzyev/5/fyn1rVf8sYHMMXQSvZhjSKv7fa2IyCt
	 2WmqNHwb9FHZgdTvjSMNGWB3qbCuYMO67O0exI3M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.270
Date: Mon, 14 Sep 2026 13:57:44 +0200
Message-ID: <2026091445-earthling-reply-6aa1@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.270 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/configfs-usb-gadget-uac1_legacy |    3 
 Documentation/usb/gadget-testing.rst                      |    3 
 Makefile                                                  |    2 
 arch/alpha/kernel/pci-sysfs.c                             |    6 
 arch/alpha/kernel/sys_marvel.c                            |   25 
 arch/arm/boot/dts/armada-388-helios4.dts                  |   13 
 arch/arm/boot/dts/sun4i-a10.dtsi                          |    2 
 arch/arm/mach-imx/src.c                                   |    1 
 arch/arm/mach-lpc32xx/common.c                            |    5 
 arch/arm/mach-lpc32xx/common.h                            |    2 
 arch/arm/mach-lpc32xx/phy3250.c                           |    2 
 arch/arm/mach-lpc32xx/pm.c                                |    5 
 arch/arm/mm/fault.c                                       |   16 
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi   |    4 
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts    |    3 
 arch/arm64/boot/dts/rockchip/Makefile                     |    1 
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi   |    6 
 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts  |   41 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi              |    1 
 arch/arm64/kernel/hibernate.c                             |   16 
 arch/csky/kernel/entry.S                                  |    6 
 arch/m68k/kernel/traps.c                                  |    4 
 arch/mips/kernel/ptrace.c                                 |    6 
 arch/openrisc/kernel/entry.S                              |   43 +
 arch/parisc/kernel/head.S                                 |    1 
 arch/powerpc/configs/85xx-hw.config                       |    1 
 arch/powerpc/kernel/smp.c                                 |    3 
 arch/powerpc/platforms/powermac/low_i2c.c                 |    2 
 arch/s390/kvm/guestdbg.c                                  |    7 
 arch/s390/kvm/interrupt.c                                 |    2 
 arch/s390/kvm/kvm-s390.c                                  |    7 
 arch/x86/events/intel/lbr.c                               |   12 
 arch/x86/events/intel/uncore.c                            |    2 
 arch/x86/include/asm/insn-eval.h                          |   36 +
 arch/x86/include/asm/pkeys.h                              |    3 
 arch/x86/kvm/emulate.c                                    |   26 
 arch/x86/kvm/hyperv.c                                     |   25 
 block/blk-iocost.c                                        |    2 
 block/blk-stat.c                                          |    2 
 block/kyber-iosched.c                                     |    2 
 crypto/ecdh.c                                             |   84 ++
 crypto/ecdh_helper.c                                      |    4 
 crypto/testmgr.c                                          |   10 
 crypto/testmgr.h                                          |   42 -
 drivers/accessibility/speakup/keyhelp.c                   |   17 
 drivers/accessibility/speakup/kobjects.c                  |    6 
 drivers/acpi/bus.c                                        |    4 
 drivers/acpi/pci_root.c                                   |    3 
 drivers/acpi/processor_core.c                             |   31 -
 drivers/acpi/processor_idle.c                             |   34 -
 drivers/acpi/utils.c                                      |   42 +
 drivers/ata/ahci.c                                        |   49 +
 drivers/ata/libata-scsi.c                                 |   28 
 drivers/base/firmware_loader/fallback.c                   |   38 -
 drivers/base/firmware_loader/firmware.h                   |   10 
 drivers/base/platform.c                                   |  424 +++++++-------
 drivers/base/soc.c                                        |   21 
 drivers/base/swnode.c                                     |    2 
 drivers/bluetooth/btmtksdio.c                             |   13 
 drivers/bluetooth/btusb.c                                 |   15 
 drivers/bluetooth/hci_bcm.c                               |    1 
 drivers/bluetooth/hci_intel.c                             |    1 
 drivers/bluetooth/hci_ldisc.c                             |    2 
 drivers/bluetooth/hci_serdev.c                            |    2 
 drivers/bus/ti-sysc.c                                     |   12 
 drivers/char/hw_random/ks-sa-rng.c                        |   22 
 drivers/char/ipmi/ipmb_dev_int.c                          |    5 
 drivers/char/ipmi/ipmi_msghandler.c                       |    1 
 drivers/char/ppdev.c                                      |   10 
 drivers/char/tpm/st33zp24/st33zp24.c                      |    8 
 drivers/char/tpm/tpm_i2c_nuvoton.c                        |    6 
 drivers/char/xilinx_hwicap/xilinx_hwicap.c                |    5 
 drivers/clk/clk-moxart.c                                  |   14 
 drivers/clk/clk-palmas.c                                  |   14 
 drivers/clk/hisilicon/reset.c                             |    2 
 drivers/clk/imx/clk-scu.c                                 |    7 
 drivers/clk/meson/gxbb.c                                  |    2 
 drivers/clk/qcom/common.c                                 |    4 
 drivers/clk/qcom/gcc-msm8916.c                            |    5 
 drivers/clk/qcom/gcc-msm8939.c                            |    5 
 drivers/clk/qcom/gdsc.c                                   |  108 +++
 drivers/clk/qcom/gdsc.h                                   |    2 
 drivers/clk/tegra/clk-tegra124-emc.c                      |    1 
 drivers/clk/x86/clk-pmc-atom.c                            |    3 
 drivers/clocksource/clps711x-timer.c                      |    2 
 drivers/clocksource/timer-armada-370-xp.c                 |   18 
 drivers/clocksource/timer-sun4i.c                         |    2 
 drivers/cpufreq/imx6q-cpufreq.c                           |    6 
 drivers/cpufreq/intel_pstate.c                            |    9 
 drivers/cpufreq/spear-cpufreq.c                           |    4 
 drivers/crypto/atmel-ecc.c                                |   73 --
 drivers/crypto/atmel-sha204a.c                            |    6 
 drivers/crypto/sa2ul.c                                    |   19 
 drivers/dma/dw-edma/dw-edma-core.c                        |   34 -
 drivers/dma/hisi_dma.c                                    |    2 
 drivers/dma/mediatek/mtk-uart-apdma.c                     |    2 
 drivers/dma/qcom/bam_dma.c                                |    1 
 drivers/dma/xilinx/xilinx_dma.c                           |   12 
 drivers/firmware/google/coreboot_table.c                  |   35 -
 drivers/firmware/google/coreboot_table.h                  |    1 
 drivers/firmware/stratix10-svc.c                          |   21 
 drivers/fpga/altera-cvp.c                                 |   10 
 drivers/fpga/stratix10-soc.c                              |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                    |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                     |   74 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c   |    6 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c       |   24 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c     |   35 +
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c       |    2 
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c                 |    3 
 drivers/gpu/drm/bridge/tc358767.c                         |    2 
 drivers/gpu/drm/drm_atomic_uapi.c                         |    2 
 drivers/gpu/drm/drm_drv.c                                 |   34 -
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c            |    6 
 drivers/gpu/drm/lima/lima_device.c                        |   12 
 drivers/gpu/drm/msm/dsi/dsi_host.c                        |    2 
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c             |   10 
 drivers/gpu/drm/sun4i/sun4i_backend.c                     |    2 
 drivers/gpu/drm/sun4i/sun4i_crtc.c                        |    2 
 drivers/gpu/drm/sun4i/sun4i_tcon.c                        |   20 
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c                     |    2 
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c                    |    2 
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c                   |   18 
 drivers/gpu/drm/tve200/tve200_drv.c                       |    1 
 drivers/gpu/drm/vmwgfx/ttm_object.c                       |    7 
 drivers/gpu/host1x/debug.c                                |    4 
 drivers/gpu/host1x/hw/channel_hw.c                        |    5 
 drivers/hid/hid-core.c                                    |  127 ++--
 drivers/hid/hid-lg4ff.c                                   |    8 
 drivers/hid/hid-mcp2221.c                                 |    7 
 drivers/hid/hid-picolcd_debugfs.c                         |    9 
 drivers/hid/hid-rmi.c                                     |   46 +
 drivers/hid/hid-roccat-kone.c                             |    8 
 drivers/hid/hid-roccat.c                                  |   13 
 drivers/hid/hid-sensor-custom.c                           |    9 
 drivers/hid/hid-sensor-hub.c                              |   42 -
 drivers/hid/i2c-hid/i2c-hid-core.c                        |   16 
 drivers/hid/wacom_wac.c                                   |   13 
 drivers/hsi/controllers/omap_ssi_core.c                   |    6 
 drivers/hwmon/emc1403.c                                   |    6 
 drivers/hwmon/max6621.c                                   |    8 
 drivers/hwspinlock/hwspinlock_core.c                      |    2 
 drivers/i2c/i2c-mux.c                                     |    1 
 drivers/i2c/muxes/i2c-demux-pinctrl.c                     |    1 
 drivers/i3c/master.c                                      |   11 
 drivers/i3c/master/dw-i3c-master.c                        |   10 
 drivers/iio/accel/dmard09.c                               |    7 
 drivers/iio/chemical/sgp30.c                              |    3 
 drivers/iio/dac/m62332.c                                  |   17 
 drivers/iio/gyro/mpu3050-core.c                           |    2 
 drivers/iio/light/cm32181.c                               |    2 
 drivers/iio/light/gp2ap002.c                              |   24 
 drivers/iio/light/isl29028.c                              |    2 
 drivers/iio/light/tsl2583.c                               |    2 
 drivers/iio/light/tsl2772.c                               |    2 
 drivers/iio/orientation/hid-sensor-rotation.c             |   20 
 drivers/iio/proximity/srf04.c                             |    1 
 drivers/iio/temperature/hid-sensor-temperature.c          |    3 
 drivers/infiniband/core/cma.c                             |    6 
 drivers/infiniband/core/device.c                          |   25 
 drivers/infiniband/core/restrack.c                        |    4 
 drivers/infiniband/core/ucma.c                            |    7 
 drivers/infiniband/hw/cxgb4/device.c                      |    8 
 drivers/infiniband/hw/cxgb4/mem.c                         |    4 
 drivers/infiniband/hw/efa/efa_verbs.c                     |   13 
 drivers/infiniband/hw/hfi1/chip.c                         |    4 
 drivers/infiniband/hw/hfi1/hfi.h                          |    2 
 drivers/infiniband/hw/hfi1/init.c                         |   43 -
 drivers/infiniband/hw/hfi1/user_sdma.c                    |   13 
 drivers/infiniband/hw/mlx5/cong.c                         |    8 
 drivers/infiniband/hw/mlx5/qp.c                           |   25 
 drivers/infiniband/sw/rxe/rxe_resp.c                      |   13 
 drivers/infiniband/sw/siw/siw_cm.c                        |   32 -
 drivers/infiniband/ulp/ipoib/ipoib_main.c                 |    2 
 drivers/infiniband/ulp/isert/ib_isert.c                   |   85 ++
 drivers/infiniband/ulp/isert/ib_isert.h                   |    1 
 drivers/infiniband/ulp/srp/ib_srp.c                       |   45 -
 drivers/infiniband/ulp/srpt/ib_srpt.c                     |   20 
 drivers/input/tablet/aiptek.c                             |   13 
 drivers/interconnect/core.c                               |    7 
 drivers/iommu/amd/init.c                                  |   42 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c               |    5 
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                   |   14 
 drivers/iommu/dma-iommu.c                                 |   13 
 drivers/iommu/intel/iommu.c                               |   16 
 drivers/iommu/msm_iommu.c                                 |    2 
 drivers/irqchip/irq-gic-v3-its.c                          |   15 
 drivers/irqchip/irq-mbigen.c                              |   20 
 drivers/leds/leds-pca9532.c                               |   18 
 drivers/mailbox/rockchip-mailbox.c                        |   17 
 drivers/md/dm-era-target.c                                |    5 
 drivers/md/dm-log-userspace-base.c                        |    1 
 drivers/md/dm-stats.c                                     |    6 
 drivers/md/dm-switch.c                                    |    2 
 drivers/md/dm.c                                           |    2 
 drivers/md/md.c                                           |    7 
 drivers/md/persistent-data/dm-array.c                     |   16 
 drivers/md/raid5-ppl.c                                    |    4 
 drivers/media/cec/core/cec-adap.c                         |    8 
 drivers/media/cec/core/cec-pin.c                          |    8 
 drivers/media/cec/platform/meson/ao-cec-g12a.c            |    1 
 drivers/media/cec/platform/stm32/stm32-cec.c              |    3 
 drivers/media/dvb-frontends/rtl2832_sdr.c                 |   21 
 drivers/media/i2c/ov7740.c                                |    4 
 drivers/media/i2c/video-i2c.c                             |    8 
 drivers/media/pci/cobalt/cobalt-alsa-main.c               |    1 
 drivers/media/pci/cx23885/cimax2.c                        |    1 
 drivers/media/platform/qcom/venus/hfi_parser.c            |    9 
 drivers/media/test-drivers/vicodec/vicodec-core.c         |    4 
 drivers/media/test-drivers/vimc/vimc-capture.c            |    4 
 drivers/media/tuners/tda18250.c                           |    4 
 drivers/media/usb/airspy/airspy.c                         |   17 
 drivers/media/usb/cx231xx/cx231xx-video.c                 |    4 
 drivers/media/usb/em28xx/em28xx-cards.c                   |    3 
 drivers/media/usb/em28xx/em28xx-core.c                    |    2 
 drivers/media/usb/go7007/snd-go7007.c                     |   10 
 drivers/media/usb/s2255/s2255drv.c                        |   11 
 drivers/media/usb/usbtv/usbtv-audio.c                     |   11 
 drivers/media/v4l2-core/v4l2-dev.c                        |   14 
 drivers/media/v4l2-core/v4l2-fwnode.c                     |    2 
 drivers/mfd/iqs62x.c                                      |    2 
 drivers/mfd/rave-sp.c                                     |   64 +-
 drivers/misc/ad525x_dpot-i2c.c                            |    4 
 drivers/misc/ad525x_dpot-spi.c                            |    4 
 drivers/misc/ad525x_dpot.c                                |  181 +++--
 drivers/misc/ad525x_dpot.h                                |    5 
 drivers/misc/cardreader/rtsx_pcr.c                        |    2 
 drivers/misc/cardreader/rtsx_usb.c                        |   23 
 drivers/misc/vmw_vmci/vmci_event.c                        |    4 
 drivers/mmc/host/via-sdmmc.c                              |    8 
 drivers/mtd/mtdoops.c                                     |    3 
 drivers/mtd/mtdpart.c                                     |    3 
 drivers/mtd/mtdswap.c                                     |    1 
 drivers/mtd/nand/raw/nand_onfi.c                          |   27 
 drivers/mtd/parsers/afs.c                                 |    7 
 drivers/mtd/ubi/attach.c                                  |    4 
 drivers/mtd/ubi/build.c                                   |   63 +-
 drivers/mtd/ubi/cdev.c                                    |    5 
 drivers/mtd/ubi/eba.c                                     |    5 
 drivers/mtd/ubi/fastmap-wl.c                              |   53 +
 drivers/mtd/ubi/fastmap.c                                 |   76 --
 drivers/mtd/ubi/io.c                                      |   13 
 drivers/mtd/ubi/ubi.h                                     |   19 
 drivers/mtd/ubi/wl.c                                      |   38 -
 drivers/mtd/ubi/wl.h                                      |    6 
 drivers/net/bonding/bond_netlink.c                        |    2 
 drivers/net/ethernet/allwinner/sun4i-emac.c               |    4 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c          |    3 
 drivers/net/ethernet/freescale/fec_main.c                 |    6 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   |   12 
 drivers/net/ethernet/nvidia/forcedeth.c                   |    6 
 drivers/net/ethernet/qlogic/qede/qede.h                   |    8 
 drivers/net/ethernet/qlogic/qede/qede_fp.c                |    1 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c      |    1 
 drivers/net/ethernet/realtek/8139cp.c                     |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c      |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c         |    2 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c       |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c    |   35 -
 drivers/net/gtp.c                                         |    2 
 drivers/net/ipvlan/ipvlan_l3s.c                           |    1 
 drivers/net/ntb_netdev.c                                  |   38 -
 drivers/net/ppp/pppox.c                                   |   17 
 drivers/net/slip/slip.c                                   |   11 
 drivers/net/thunderbolt.c                                 |    6 
 drivers/net/tun.c                                         |   21 
 drivers/net/usb/qmi_wwan.c                                |    1 
 drivers/net/wireless/ath/ath10k/snoc.c                    |    9 
 drivers/net/wireless/ath/ath11k/debug.c                   |   12 
 drivers/net/wireless/ath/ath11k/debug.h                   |    3 
 drivers/net/wireless/ath/ath11k/dp_rx.c                   |   30 
 drivers/net/wireless/ath/ath11k/trace.c                   |    1 
 drivers/net/wireless/ath/ath11k/trace.h                   |  172 +++++
 drivers/net/wireless/ath/ath11k/wmi.c                     |   15 
 drivers/net/wireless/ath/ath6kl/cfg80211.c                |    5 
 drivers/net/wireless/ath/ath6kl/wmi.c                     |   17 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   |    3 
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c          |   12 
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c          |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c           |    8 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h           |    6 
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c        |    2 
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c        |    2 
 drivers/net/wireless/realtek/rtlwifi/pci.c                |    6 
 drivers/net/wireless/realtek/rtw88/tx.c                   |    1 
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c              |    8 
 drivers/nfc/pn533/pn533.c                                 |   21 
 drivers/ntb/ntb_transport.c                               |   38 -
 drivers/nvdimm/btt.c                                      |    8 
 drivers/nvdimm/label.c                                    |   17 
 drivers/nvme/host/core.c                                  |    2 
 drivers/nvme/host/fc.c                                    |    8 
 drivers/nvme/host/tcp.c                                   |   11 
 drivers/nvme/target/rdma.c                                |   13 
 drivers/nvme/target/tcp.c                                 |   10 
 drivers/of/base.c                                         |    2 
 drivers/of/property.c                                     |   10 
 drivers/parisc/eisa.c                                     |    5 
 drivers/pci/controller/dwc/pci-meson.c                    |    2 
 drivers/pci/controller/pci-hyperv.c                       |    1 
 drivers/pci/pci-sysfs.c                                   |   45 +
 drivers/pci/proc.c                                        |    8 
 drivers/pci/quirks.c                                      |    2 
 drivers/perf/arm_spe_pmu.c                                |    2 
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c             |   26 
 drivers/pinctrl/bcm/pinctrl-bcm2835.c                     |    1 
 drivers/pinctrl/pinctrl-rockchip.c                        |   10 
 drivers/platform/chrome/cros_ec_sensorhub_ring.c          |   28 
 drivers/power/supply/bd99954-charger.h                    |   23 
 drivers/power/supply/bq27xxx_battery.c                    |    6 
 drivers/power/supply/cros_usbpd-charger.c                 |   17 
 drivers/power/supply/isp1704_charger.c                    |    1 
 drivers/power/supply/lp8727_charger.c                     |    4 
 drivers/power/supply/max17040_battery.c                   |    2 
 drivers/power/supply/sbs-battery.c                        |  160 +++--
 drivers/power/supply/sc2731_charger.c                     |    8 
 drivers/pps/pps.c                                         |   10 
 drivers/rapidio/devices/rio_mport_cdev.c                  |   10 
 drivers/rapidio/rio-scan.c                                |    1 
 drivers/regulator/as3722-regulator.c                      |    1 
 drivers/regulator/core.c                                  |    6 
 drivers/regulator/max8998.c                               |    1 
 drivers/regulator/qcom-rpmh-regulator.c                   |    6 
 drivers/remoteproc/mtk_scp.c                              |    9 
 drivers/remoteproc/qcom_common.c                          |    4 
 drivers/remoteproc/remoteproc_core.c                      |  351 +++++++++--
 drivers/remoteproc/remoteproc_elf_loader.c                |   12 
 drivers/remoteproc/remoteproc_sysfs.c                     |   35 -
 drivers/remoteproc/remoteproc_virtio.c                    |    6 
 drivers/rpmsg/qcom_glink_native.c                         |   34 -
 drivers/rpmsg/qcom_glink_smem.c                           |    7 
 drivers/rtc/rtc-pcf8563.c                                 |    4 
 drivers/s390/block/dasd.c                                 |    6 
 drivers/s390/block/dasd_eckd.c                            |   40 +
 drivers/s390/block/dasd_erp.c                             |    3 
 drivers/scsi/mpt3sas/mpt3sas_base.c                       |    2 
 drivers/scsi/pm8001/pm8001_init.c                         |    4 
 drivers/scsi/qla2xxx/qla_attr.c                           |    7 
 drivers/scsi/qla2xxx/qla_bsg.c                            |   39 -
 drivers/scsi/qla2xxx/qla_def.h                            |    2 
 drivers/scsi/qla2xxx/qla_dfs.c                            |    4 
 drivers/scsi/qla2xxx/qla_gs.c                             |    4 
 drivers/scsi/qla2xxx/qla_init.c                           |   47 +
 drivers/scsi/qla2xxx/qla_inline.h                         |   13 
 drivers/scsi/qla2xxx/qla_isr.c                            |   20 
 drivers/scsi/qla2xxx/qla_mbx.c                            |   26 
 drivers/scsi/qla2xxx/qla_nx2.c                            |    2 
 drivers/scsi/qla2xxx/qla_os.c                             |   14 
 drivers/scsi/qla2xxx/qla_target.c                         |   24 
 drivers/scsi/qla2xxx/qla_target.h                         |    1 
 drivers/scsi/qla2xxx/tcm_qla2xxx.c                        |   61 +-
 drivers/scsi/scsi_lib.c                                   |    2 
 drivers/soc/bcm/bcm2835-power.c                           |    7 
 drivers/soc/samsung/exynos-pmu.c                          |    4 
 drivers/soundwire/qcom.c                                  |   31 -
 drivers/spi/spi-img-spfi.c                                |    5 
 drivers/spi/spi-sprd-adi.c                                |    6 
 drivers/staging/fbtft/fbtft-sysfs.c                       |    2 
 drivers/staging/greybus/audio_gb.c                        |   13 
 drivers/staging/greybus/audio_manager_sysfs.c             |    2 
 drivers/staging/greybus/hid.c                             |    2 
 drivers/staging/media/meson/vdec/vdec.c                   |    4 
 drivers/staging/media/sunxi/cedrus/cedrus.c               |    4 
 drivers/staging/octeon/ethernet-mem.c                     |   31 -
 drivers/staging/octeon/ethernet-mem.h                     |    5 
 drivers/staging/octeon/ethernet-rx.c                      |    2 
 drivers/staging/octeon/ethernet-tx.c                      |    2 
 drivers/staging/octeon/ethernet.c                         |    6 
 drivers/staging/rtl8723bs/core/rtw_cmd.c                  |    8 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c            |    3 
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c              |    4 
 drivers/staging/sm750fb/sm750.c                           |    4 
 drivers/target/iscsi/iscsi_target.c                       |   16 
 drivers/target/iscsi/iscsi_target_login.c                 |    2 
 drivers/target/target_core_transport.c                    |  243 ++++----
 drivers/target/target_core_xcopy.c                        |    8 
 drivers/thermal/imx_thermal.c                             |    9 
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c   |    9 
 drivers/thermal/qoriq_thermal.c                           |   13 
 drivers/tty/hvc/Kconfig                                   |    2 
 drivers/tty/serial/amba-pl011.c                           |   10 
 drivers/tty/tty_io.c                                      |    4 
 drivers/uio/uio.c                                         |    5 
 drivers/usb/atm/usbatm.c                                  |    4 
 drivers/usb/gadget/configfs.c                             |    4 
 drivers/usb/gadget/function/f_fs.c                        |   14 
 drivers/usb/gadget/function/f_mass_storage.c              |    2 
 drivers/usb/gadget/function/f_tcm.c                       |   43 -
 drivers/usb/gadget/function/f_uac1_legacy.c               |   56 -
 drivers/usb/gadget/function/f_uvc.c                       |    7 
 drivers/usb/gadget/function/u_audio.c                     |   24 
 drivers/usb/gadget/function/u_uac1_legacy.h               |    3 
 drivers/usb/gadget/functions.c                            |    2 
 drivers/usb/gadget/legacy/inode.c                         |    3 
 drivers/usb/gadget/udc/r8a66597-udc.c                     |    1 
 drivers/usb/gadget/udc/snps_udc_plat.c                    |    5 
 drivers/usb/host/xhci-ring.c                              |   32 -
 drivers/usb/image/mdc800.c                                |    4 
 drivers/usb/phy/phy-fsl-usb.c                             |   52 -
 drivers/usb/phy/phy-fsl-usb.h                             |    6 
 drivers/usb/renesas_usbhs/common.c                        |    6 
 drivers/usb/serial/keyspan_pda.c                          |    2 
 drivers/usb/storage/ene_ub6250.c                          |    2 
 drivers/usb/typec/ucsi/displayport.c                      |    2 
 drivers/vdpa/mlx5/core/mr.c                               |    2 
 drivers/vfio/pci/vfio_pci_config.c                        |    1 
 drivers/video/fbdev/kyro/fbdev.c                          |   24 
 drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c  |    4 
 drivers/video/fbdev/pvr2fb.c                              |    4 
 drivers/video/fbdev/uvesafb.c                             |    2 
 drivers/virtio/virtio_balloon.c                           |    6 
 drivers/w1/masters/ds2482.c                               |    4 
 drivers/w1/slaves/w1_ds28e17.c                            |    8 
 drivers/xen/xenbus/xenbus_xs.c                            |   16 
 fs/ceph/caps.c                                            |   11 
 fs/ceph/xattr.c                                           |    1 
 fs/cifs/cifs_debug.c                                      |    2 
 fs/ecryptfs/crypto.c                                      |    2 
 fs/ecryptfs/ecryptfs_kernel.h                             |    3 
 fs/ecryptfs/keystore.c                                    |   45 +
 fs/ecryptfs/messaging.c                                   |   11 
 fs/ecryptfs/miscdev.c                                     |    5 
 fs/ecryptfs/super.c                                       |    7 
 fs/ext4/file.c                                            |    7 
 fs/ext4/inode.c                                           |   10 
 fs/f2fs/file.c                                            |    9 
 fs/f2fs/namei.c                                           |   11 
 fs/fat/misc.c                                             |    4 
 fs/fat/nfs.c                                              |    4 
 fs/hfsplus/catalog.c                                      |   25 
 fs/hfsplus/hfsplus_fs.h                                   |    6 
 fs/hugetlbfs/inode.c                                      |    3 
 fs/isofs/compress.c                                       |    1 
 fs/lockd/svcsubs.c                                        |   55 +
 fs/nfs/client.c                                           |   21 
 fs/nfs/file.c                                             |    2 
 fs/nfs/filelayout/filelayoutdev.c                         |    3 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                 |    3 
 fs/nfs/inode.c                                            |  101 +--
 fs/nfs/internal.h                                         |    1 
 fs/nfs/netns.h                                            |    6 
 fs/nfs/nfs4client.c                                       |    1 
 fs/nfs/nfs4proc.c                                         |    6 
 fs/nfs/pnfs.c                                             |   61 --
 fs/nfs/pnfs.h                                             |    3 
 fs/nfs/pnfs_nfs.c                                         |   39 -
 fs/nfsd/flexfilelayoutxdr.c                               |   20 
 fs/nfsd/nfs2acl.c                                         |   31 -
 fs/nfsd/nfs4proc.c                                        |   39 -
 fs/nfsd/nfs4state.c                                       |  202 +++++-
 fs/nfsd/nfs4xdr.c                                         |   17 
 fs/nfsd/nfscache.c                                        |    2 
 fs/nfsd/nfsfh.c                                           |    4 
 fs/nfsd/nfsproc.c                                         |    7 
 fs/nfsd/nfssvc.c                                          |    4 
 fs/nfsd/nfsxdr.c                                          |   32 -
 fs/nilfs2/bmap.c                                          |    2 
 fs/nilfs2/bmap.h                                          |    2 
 fs/nilfs2/btree.c                                         |   39 +
 fs/nilfs2/direct.c                                        |    4 
 fs/nilfs2/segment.c                                       |    4 
 fs/nilfs2/the_nilfs.c                                     |    6 
 fs/notify/fanotify/fanotify_user.c                        |   17 
 fs/notify/inotify/inotify_user.c                          |   15 
 fs/ocfs2/acl.c                                            |  135 ++--
 fs/ocfs2/acl.h                                            |   19 
 fs/ocfs2/cluster/heartbeat.c                              |  199 +++++-
 fs/ocfs2/cluster/heartbeat.h                              |    7 
 fs/ocfs2/cluster/netdebug.c                               |    2 
 fs/ocfs2/cluster/nodemanager.c                            |   10 
 fs/ocfs2/cluster/nodemanager.h                            |    1 
 fs/ocfs2/cluster/tcp.c                                    |   89 ++
 fs/ocfs2/cluster/tcp.h                                    |    1 
 fs/ocfs2/dir.c                                            |    2 
 fs/ocfs2/dlm/dlmdomain.c                                  |    2 
 fs/ocfs2/dlm/dlmmaster.c                                  |    6 
 fs/ocfs2/dlm/dlmrecovery.c                                |    9 
 fs/ocfs2/namei.c                                          |   17 
 fs/ocfs2/refcounttree.c                                   |   47 +
 fs/ocfs2/stack_o2cb.c                                     |    6 
 fs/ocfs2/xattr.c                                          |   91 +--
 fs/ocfs2/xattr.h                                          |    9 
 fs/orangefs/devorangefs-req.c                             |    1 
 fs/orangefs/orangefs-debugfs.c                            |    1 
 fs/squashfs/cache.c                                       |    2 
 fs/ubifs/auth.c                                           |    2 
 fs/udf/inode.c                                            |    2 
 fs/udf/partition.c                                        |    2 
 fs/udf/super.c                                            |   23 
 fs/udf/symlink.c                                          |    2 
 include/acpi/acpi_bus.h                                   |   21 
 include/crypto/ecdh.h                                     |    2 
 include/linux/bitfield.h                                  |   95 ++-
 include/linux/bpf.h                                       |    1 
 include/linux/hid.h                                       |    1 
 include/linux/highmem.h                                   |   89 ++
 include/linux/irqdomain.h                                 |   23 
 include/linux/list.h                                      |   15 
 include/linux/nfs_fs.h                                    |    1 
 include/linux/nfs_xdr.h                                   |    3 
 include/linux/of.h                                        |    2 
 include/linux/of_graph.h                                  |    4 
 include/linux/platform_device.h                           |   11 
 include/linux/remoteproc.h                                |  297 ---------
 include/linux/rsc_table.h                                 |  364 ++++++++++++
 include/linux/rtsx_usb.h                                  |    3 
 include/linux/soundwire/sdw.h                             |    2 
 include/media/rc-map.h                                    |    2 
 include/net/bluetooth/l2cap.h                             |   11 
 include/net/inet_connection_sock.h                        |   11 
 include/net/ip_tunnels.h                                  |   11 
 include/net/mac80211.h                                    |   18 
 include/net/netfilter/nf_queue.h                          |    1 
 include/net/netfilter/nf_tables.h                         |    4 
 include/net/pkt_sched.h                                   |    1 
 include/net/sch_generic.h                                 |    1 
 include/net/sctp/structs.h                                |    2 
 include/net/tcp.h                                         |   13 
 include/net/xfrm.h                                        |    1 
 include/target/target_core_base.h                         |    1 
 include/target/target_core_fabric.h                       |   10 
 include/uapi/linux/time_types.h                           |    2 
 include/uapi/mtd/ubi-user.h                               |    8 
 kernel/auditfilter.c                                      |    6 
 kernel/bpf/cgroup.c                                       |    2 
 kernel/bpf/core.c                                         |    4 
 kernel/bpf/net_namespace.c                                |   17 
 kernel/bpf/ringbuf.c                                      |    2 
 kernel/bpf/verifier.c                                     |   26 
 kernel/entry/common.c                                     |    3 
 kernel/irq/irqdomain.c                                    |   41 +
 kernel/locking/lockdep.c                                  |    2 
 kernel/power/wakelock.c                                   |    2 
 kernel/sched/cpufreq_schedutil.c                          |   59 +
 kernel/sched/fair.c                                       |   53 -
 kernel/signal.c                                           |    4 
 kernel/sys.c                                              |    2 
 kernel/time/clocksource.c                                 |    8 
 kernel/time/itimer.c                                      |    2 
 kernel/time/timekeeping.c                                 |    6 
 kernel/time/timer.c                                       |    1 
 kernel/trace/trace_events.c                               |    2 
 kernel/trace/trace_mmiotrace.c                            |   24 
 lib/iov_iter.c                                            |    8 
 lib/string.c                                              |    3 
 lib/test_hmm.c                                            |    2 
 lib/ucs2_string.c                                         |    2 
 mm/Kconfig                                                |    3 
 mm/highmem.c                                              |  151 ++++
 mm/memcontrol.c                                           |    6 
 mm/vmscan.c                                               |    2 
 net/batman-adv/bridge_loop_avoidance.c                    |   78 +-
 net/batman-adv/distributed-arp-table.c                    |    8 
 net/batman-adv/main.c                                     |    4 
 net/bluetooth/6lowpan.c                                   |   25 
 net/bluetooth/ecdh_helper.c                               |    2 
 net/bluetooth/hci_event.c                                 |    7 
 net/bluetooth/l2cap_core.c                                |   58 +
 net/bluetooth/l2cap_sock.c                                |  114 +++
 net/bluetooth/msft.c                                      |    5 
 net/bluetooth/rfcomm/core.c                               |   12 
 net/bluetooth/selftest.c                                  |    2 
 net/bluetooth/smp.c                                       |    6 
 net/bridge/br_mrp_netlink.c                               |    4 
 net/bridge/br_netlink_tunnel.c                            |    3 
 net/bridge/br_vlan.c                                      |    4 
 net/ceph/osdmap.c                                         |    2 
 net/core/filter.c                                         |    6 
 net/core/lwt_bpf.c                                        |   15 
 net/core/skbuff.c                                         |   11 
 net/core/xdp.c                                            |    4 
 net/dccp/dccp.h                                           |    4 
 net/dccp/ipv4.c                                           |    4 
 net/dccp/ipv6.c                                           |    7 
 net/dccp/minisocks.c                                      |    2 
 net/hsr/hsr_device.c                                      |   14 
 net/hsr/hsr_framereg.c                                    |   63 --
 net/hsr/hsr_main.h                                        |    8 
 net/ipv4/esp4.c                                           |   49 -
 net/ipv4/inet_connection_sock.c                           |    9 
 net/ipv4/ip_tunnel.c                                      |    2 
 net/ipv4/syncookies.c                                     |    2 
 net/ipv4/tcp_fastopen.c                                   |    2 
 net/ipv4/tcp_ipv4.c                                       |    8 
 net/ipv4/tcp_minisocks.c                                  |    2 
 net/ipv4/tcp_output.c                                     |    2 
 net/ipv6/esp6.c                                           |   49 -
 net/ipv6/ip6_gre.c                                        |   34 -
 net/ipv6/ip6_tunnel.c                                     |   22 
 net/ipv6/route.c                                          |    2 
 net/ipv6/seg6_local.c                                     |    9 
 net/ipv6/sit.c                                            |    2 
 net/ipv6/tcp_ipv6.c                                       |   98 +--
 net/ipv6/xfrm6_input.c                                    |    2 
 net/iucv/af_iucv.c                                        |    2 
 net/kcm/kcmsock.c                                         |    3 
 net/key/af_key.c                                          |   52 +
 net/mpls/af_mpls.c                                        |    2 
 net/mptcp/pm_netlink.c                                    |   30 
 net/mptcp/subflow.c                                       |    6 
 net/mptcp/syncookies.c                                    |    1 
 net/netfilter/Kconfig                                     |    2 
 net/netfilter/ipvs/ip_vs_ftp.c                            |   10 
 net/netfilter/nf_nat_sip.c                                |    5 
 net/netfilter/nf_queue.c                                  |   16 
 net/netfilter/nf_tables_api.c                             |   48 -
 net/netfilter/nfnetlink_queue.c                           |    3 
 net/netfilter/xt_cgroup.c                                 |   21 
 net/netfilter/xt_hl.c                                     |   27 
 net/nfc/digital_core.c                                    |    2 
 net/nfc/llcp_core.c                                       |   29 
 net/nfc/llcp_sock.c                                       |   14 
 net/nfc/nci/data.c                                        |   10 
 net/openvswitch/conntrack.c                               |  130 ++--
 net/openvswitch/conntrack.h                               |    6 
 net/openvswitch/datapath.c                                |   58 +
 net/openvswitch/datapath.h                                |   26 
 net/openvswitch/vport.h                                   |    8 
 net/phonet/pep.c                                          |    2 
 net/rds/cong.c                                            |    4 
 net/sched/sch_api.c                                       |    7 
 net/sched/sch_codel.c                                     |    2 
 net/sched/sch_fq.c                                        |   28 
 net/sched/sch_fq_codel.c                                  |    6 
 net/sched/sch_fq_pie.c                                    |    3 
 net/sched/sch_generic.c                                   |    9 
 net/sched/sch_hhf.c                                       |    4 
 net/sched/sch_sfq.c                                       |    3 
 net/sched/sch_teql.c                                      |    1 
 net/sctp/inqueue.c                                        |    7 
 net/sctp/sm_sideeffect.c                                  |    4 
 net/sctp/stream.c                                         |   48 +
 net/smc/af_smc.c                                          |    2 
 net/smc/smc_llc.c                                         |    1 
 net/sunrpc/auth_gss/auth_gss.c                            |    6 
 net/sunrpc/auth_gss/gss_krb5_wrap.c                       |   13 
 net/sunrpc/auth_gss/gss_rpc_upcall.c                      |    6 
 net/sunrpc/auth_gss/gss_rpc_upcall.h                      |    1 
 net/sunrpc/auth_gss/svcauth_gss.c                         |    3 
 net/sunrpc/cache.c                                        |    7 
 net/sunrpc/rpcb_clnt.c                                    |    4 
 net/sunrpc/sunrpc_syms.c                                  |    1 
 net/sunrpc/svc.c                                          |   29 
 net/sunrpc/xdr.c                                          |    2 
 net/vmw_vsock/af_vsock.c                                  |    6 
 net/vmw_vsock/virtio_transport.c                          |    2 
 net/xfrm/xfrm_state.c                                     |    3 
 scripts/tags.sh                                           |    2 
 security/apparmor/lib.c                                   |   20 
 security/selinux/include/security.h                       |    4 
 security/selinux/selinuxfs.c                              |    7 
 security/selinux/ss/services.c                            |   45 -
 security/smack/smack.h                                    |    7 
 security/smack/smack_lsm.c                                |   95 ++-
 security/smack/smackfs.c                                  |  218 ++-----
 sound/core/pcm_native.c                                   |    2 
 sound/drivers/aloop.c                                     |   99 +--
 sound/drivers/mpu401/mpu401.c                             |    6 
 sound/drivers/mts64.c                                     |    6 
 sound/drivers/portman2x4.c                                |    6 
 sound/drivers/serial-u16550.c                             |    6 
 sound/pci/asihpi/hpi6000.c                                |    5 
 sound/pci/hda/hda_proc.c                                  |    2 
 sound/pci/via82xx_modem.c                                 |   26 
 sound/soc/codecs/cs35l33.c                                |   14 
 sound/soc/codecs/cs35l34.c                                |   14 
 sound/soc/fsl/fsl-asoc-card.c                             |    4 
 sound/soc/fsl/mpc5200_psc_i2s.c                           |    1 
 sound/soc/intel/atom/sst/sst_pci.c                        |    4 
 sound/soc/meson/meson-card-utils.c                        |   17 
 sound/soc/pxa/pxa-ssp.c                                   |    7 
 sound/soc/samsung/aries_wm8994.c                          |    1 
 sound/soc/soc-dapm.c                                      |    2 
 sound/soc/xilinx/xlnx_formatter_pcm.c                     |   14 
 sound/usb/6fire/comm.c                                    |    9 
 sound/usb/bcd2000/bcd2000.c                               |   11 
 sound/usb/midi.c                                          |    2 
 tools/bpf/bpftool/map.c                                   |    4 
 tools/include/linux/compiler.h                            |    2 
 tools/perf/builtin-sched.c                                |   40 -
 tools/perf/builtin-stat.c                                 |   15 
 tools/perf/ui/browsers/hists.c                            |    6 
 tools/perf/util/auxtrace.c                                |   15 
 tools/perf/util/cs-etm.c                                  |   81 ++
 tools/perf/util/dso.c                                     |   19 
 tools/perf/util/intel-bts.c                               |    2 
 tools/perf/util/intel-pt.c                                |    2 
 tools/perf/util/machine.c                                 |   34 -
 tools/perf/util/synthetic-events.c                        |    6 
 tools/perf/util/thread-stack.c                            |    2 
 tools/perf/util/trace-event-read.c                        |   33 -
 tools/testing/selftests/arm64/mte/check_ksm_options.c     |   29 
 tools/testing/selftests/bpf/test_sockmap.c                |    3 
 tools/testing/selftests/rseq/rseq-x86-thread-pointer.h    |    4 
 tools/testing/selftests/timers/leap-a-day.c               |   19 
 tools/testing/selftests/zram/zram_lib.sh                  |    2 
 696 files changed, 7987 insertions(+), 3978 deletions(-)

Abdun Nihaal (4):
      wifi: brcmfmac: Fix memory leak in brcmf_sdio_read_control()
      wifi: rtw88: Fix potential memory leak in rtw_txq_push_skb()
      wifi: rtlwifi: pci: fix error path in rtl_pci_probe()
      misc: vmc_vmci: Fix potential memory leak in vmci_event_subscribe()

Abdurrahman Hussain (1):
      of: fix out-of-bounds read in of_alias_scan() stem parser

Ada Couprie Diaz (1):
      arm64: hibernate: mask DAIF before restoring hibernated kernel

Adrian Hunter (2):
      i3c: master: Fix info leak and UAF in device unregister path
      i3c: master: Fix device_register() error path

Ahmad Byagowi (1):
      i2c: mux: Fix channel node leak on adapter add failure

Ahmet Sezgin Duran (1):
      staging: sm750fb: gate dualview dataflow using g_dualview

Ai Chao (1):
      HID: i2c-hid: Fix "(null)" output when reading report descriptor fails

Alban Bedel (1):
      software node: Fix software_node_get_reference_args() with index -1

Aleksandr Khromov (1):
      slip: fix use-after-free in sl_sync()

Aleksandr Nogikh (1):
      udf: Mark LVID buffer as uptodate before marking it dirty

Alex Elder (1):
      remoteproc: use freezable workqueue for crash notifications

Alexander A. Klimov (2):
      clk: moxart: remove unused variables, fix refcount leak
      staging: greybus: audio: correct sscanf() return value check

Alexandra Winter (1):
      net/iucv: filter frames in afiucv_hs_rcv() by ingress device

Ali Ahmet Memis (2):
      openrisc: fix arbitrary kernel memory access via or1k_atomic syscall
      Bluetooth: MSFT: validate evt_prefix_len against the response length

Allison Henderson (1):
      net/rds: use wq_has_sleeper() in rds_cong_map_updated()

Andre Przywara (1):
      ARM: dts: allwinner: a10: Fix PMU interrupt

Andrei Matei (1):
      bpf: Guard stack limits against 32bit overflow

Andy Shevchenko (2):
      usb: f_mass_storage: Bump local buffer size in fsg_common_create_luns()
      ACPI: utils: Document for_each_acpi_dev_match() macro

Aneesh Kumar K.V (Arm) (1):
      iommu/dma: Check atomic pool allocation result directly

Anson Huang (2):
      clk: imx: scu: Add A53 frequency scaling support
      clk: imx: scu: Add A72 frequency scaling support

Arash Golgol (1):
      media: vimc: fix pixel format lookup in enum_framesizes

Arnaldo Carvalho de Melo (14):
      perf sched: Fix register_pid() overflow, strcpy, and BUG_ON
      perf machine: Guard against NULL strlist in machines__findnew()
      perf machine: Use snprintf() for guestmount path construction
      perf machine: Check snprintf truncation in machines__findnew()
      perf machine: Don't abort guest map creation on first inaccessible dir
      perf machine: Reset errno before strtol in guest kernel map creation
      perf machine: Free scandir entries in guest kernel map creation
      perf machine: Check snprintf truncation for guest kallsyms path
      perf thread-stack: Fix heap buffer overflow on branch stack wrap copy
      perf auxtrace: Fix queue grow overflow and old array leak
      perf intel-pt: Fix off-by-one in auxtrace_info minimum size check
      perf intel-bts: Fix off-by-one in auxtrace_info minimum size check
      perf dso: Guard close() against invalid fd in dso__decompress_kmodule_path()
      perf dso: Guard against cache underflow on short reads in dso_cache__memcpy()

Arnaud Bonnet (2):
      nfs: replace atomic bitops sequence with clear_and_wake_up_bit helper
      nfs: refactor pNFS functions using clear_and_wake_up_bit

Arthur Gautier (1):
      xhci: fix lost bounce buffers on TDs spanning several ring segments

Arun Kumar Neelakantam (1):
      rpmsg: glink: Remove the rpmsg dev in close_ack

Asad Kamal (2):
      drm/amdgpu/pm/powerplay: bounds-check voltage index in SMU7 lookup
      drm/amdgpu/pm/powerplay: bounds-check voltage index in Vega10 lookup

Asim Viladi Oglu Manizada (1):
      net: tun: bound receive headroom

Austin Kim (1):
      smack: mark 'smack_enabled' global variable as __initdata

Ayush Mukkanwar (2):
      staging: octeon: add missing tasklet_kill in cvm_oct_tx_shutdown
      staging: octeon: ethernet-mem: replace pr_warn with dev_warn in free functions

Babanpreet Singh (3):
      power: supply: sbs-battery: Use a per-device serial number buffer
      w1: ds2482: Fix signedness bug in ds2482_w1_triplet()
      spi: sprd-adi: Fix probe succeeding without registering the controller

Baochen Qiang (1):
      wifi: ath11k: cap out-of-range rx MCS instead of leaving bogus rate

Baokun Li (1):
      ext4: drain in-flight DIO before buffered write fallback

Bartosz Golaszewski (1):
      powerpc/powermac: fix OF node refcount

Baul Lee (2):
      ALSA: 6fire: bound the MIDI event length from the device
      ALSA: bcd2000: clear the URB pointers on disconnect

Bijan Tabatabai (1):
      x86/pkeys: Fix pkey_alloc() return value when pkeys are not supported

Biju Das (1):
      usb: renesas_usbhs: Fix power-off ordering on unbind

Biren Pandya (2):
      media: i2c: ov7740: fix use-after-destroy in remove
      media: v4l2-fwnode: Fix fwnode leak in v4l2_fwnode_parse_link

Bjorn Andersson (2):
      remoteproc: Prevent crash handling to race with rproc_del()
      clk: qcom: gdsc: Bump parent usage count when GDSC is found enabled

Bob Pearson (2):
      RDMA/rxe: Fix over copying in get_srq_wqe
      RDMA/rxe: Use the correct size of wqe when processing SRQ

Bradley Morgan (3):
      signal: avoid shared siginfo namespace rewrites
      lib/string: fix memchr_inv() for large ranges
      prctl: fix PR_SET_MM_AUXV losing the forced AT_NULL terminator

Breno Leitao (4):
      mm/vmscan: report RCU-tasks quiescent states in shrink_lruvec()
      phonet: pep: do not write beyond optlen in getsockopt
      nfc: llcp: avoid userspace overflow on invalid optlen
      nfc: llcp: read llcp_sock->local under the socket lock in getsockopt

Brian Masney (1):
      clk: imx: scu: drop redundant init.ops variable assignment

Bryam Vargas (11):
      dm array: reject an array block whose value size is not the caller's
      libnvdimm/labels: Prevent integer overflow in __nd_label_validate()
      ocfs2: bound namelen in dlm_migrate_request_handler
      ocfs2: validate lengths in dlm_mig_lockres_handler
      power: supply: cros_usbpd-charger: bound the EC-reported port count
      platform/chrome: sensorhub: Bound the EC-reported sensor number
      selinux: reject an unclaimed class value in security_get_classes()
      nvdimm/btt: reject an arena whose nfree is below the lane count
      media: cx231xx: reject geometry changes while the VBI queue is busy
      greybus: audio: bound the topology section sizes against the fetched size
      libnvdimm/labels: Bound the on-media label size before the shift

Bryan O'Donoghue (2):
      clk: qcom: gdsc: Release pm subdomains in reverse add order
      clk: qcom: gdsc: Capture pm_genpd_add_subdomain result code

Calvin Owens (1):
      pps: don't try to wait for negative timeouts in PPS_FETCH

Can Peng (3):
      thermal/drivers/imx: Disable clock on runtime resume failure
      thermal/drivers/qoriq: Disable clock on resume failure
      drm/tve200: add OF module alias for autoloading

Carlos López (1):
      KVM: x86: hyper-v: Clamp stimer deadline to avoid livelock

Casey Schaufler (1):
      Smack: fix W=1 build warnings

Cen Zhang (1):
      ocfs2: synchronize heartbeat callbacks with o2net teardown

Cen Zhang (Microsoft) (1):
      gtp: add synchronize_net() in gtp_newlink() error path to prevent use-after-free

Chandrakanth Patil (1):
      scsi: mpt3sas: Avoid freeing unallocated PCIe SGL buffers

Chen Pei (1):
      ACPI: PCI: Clear driver_data on all paths that free the acpi_pci_root

Chen-Yu Tsai (1):
      arm64: dts: rockchip: Add gru-scarlet-dumo board

Cheng-Han Wu (1):
      selftests/zram: fix kernel_gte() for POSIX sh

Chengfeng Ye (2):
      Bluetooth: RFCOMM: serialize security confirmation handling
      vsock/virtio: flush works in dependency order

Chris Lu (1):
      Bluetooth: btmtksdio: Take exclusive ownership of the SKB before TX

Chris Mason (6):
      nfsd: fix cpntf publish race in nfs4_init_cp_state
      SUNRPC: xdr_buf_trim: clamp buf->len to avoid underflow
      SUNRPC: Guard svcauth_gss_release() dispatch on rq_auth_stat
      SUNRPC: harden gss_krb5_unwrap_v2 against short tokens
      SUNRPC: harden gss_unwrap_resp_priv length checks
      sunrpc: init gssp_lock before publishing proc entry

Christian Borntraeger (5):
      KVM: s390: Fix memory leak in guest debug handling
      KVM: s390: Fix old_data leak in guest debug error path
      KVM: s390: Free guest debug data on vcpu destroy
      KVM: s390: Zero initialize irq in reinject_machine_check
      KVM: s390: Restore sigset on error path

Christian Göttsche (1):
      selinux: avoid implicit conversions in services code

Christian Hewitt (1):
      media: meson: vdec: fix NULL pointer deref in vdec_try_fmt_common

Christoph Zwerschke (2):
      Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU
      Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU

Christophe JAILLET (2):
      accessibility: speakup: Fix incorrect string length computation in report_char_chartab_status()
      ubi: fastmap: Use the bitmap API to allocate bitmaps

Chuck Lever (6):
      NFSD: Encode only the status in NFS-ACL v2 GETACL error replies
      NFSD: Fix off-by-one in DRC bucket pruning limit
      nfsd: Reset write verifier when async COPY writeback fails
      nfsd: sample writeback error cursor before async COPY loop
      NFSD: Prevent lock owner use-after-free during client teardown
      SUNRPC: Reject krb5 v2 wrap tokens with oversized ec field

Chunkai Deng (1):
      rpmsg: glink: smem: order FIFO read after availability check

Coly Li (1):
      md: do overflow check for sb->bblog_shift in super_1_load()

Cong Nguyen (4):
      hwmon: (max6621) fix negative temperature offset and crit readings
      hwmon: (max6621) fix temperature clamp range
      iio: gyro: mpu3050: fix sign of raw angular velocity readings
      iio: srf04: fix pm_runtime handling on probe error path

Cosmo Chou (2):
      leds: pca9532: Fix inverted GPIO output polarity
      leds: pca9532: Fix phantom device registration on missing hardware

D. Wythe (1):
      net/smc: fix potential panic dues to unprotected smc_llc_srv_add_link()

Daisuke Matsuda (1):
      fpga: altera-cvp: Avoid out-of-bounds read in trailing byte write

Dan Carpenter (5):
      RDMA/rxe: Missing unlock on error in get_srq_wqe()
      staging: fbtft: Use sysfs_emit_at() to print to sysfs file
      cpufreq: spear: Fix an IS_ERR() vs NULL bug in spear1340_set_cpu_rate()
      scsi: qla2xxx: Fix an loop timeout test
      HID: fix an error code in hid_check_device_match()

Daniel Borkmann (2):
      bpf: Enforce expected_attach_type for tailcall compatibility
      bpf: Fix vmlinux BTF prep race in bpf_get_btf_vmlinux

Daniel McCarthy (1):
      pinctrl: bcm2835: Don't remove an unregistered GPIO chip

Daniel Scally (1):
      media: ACPI / bus: Add acpi_dev_get_next_match_dev() and helper macro

Danila Chernetsov (2):
      RDMA/hfi1: Propagate sdma_txinit_ahg() errors
      fbdev: kyro: Validate overlay viewport coordinates

Danilo Krummrich (1):
      drm: fix race between partial drm_dev_register() failure and ioctl

Dapeng Mi (1):
      perf/x86/intel: Fix kernel address leakages in LBR stack

David Lee (3):
      udf: reject VAT indexes equal to the entry count
      UDF symlink pathComponent header OOB read
      nilfs2: prevent out-of-bounds read in super root block parsing

David Woodhouse (1):
      timekeeping: Account for monotonicity adjustment in ntp_error

Dawei Feng (2):
      media: cedrus: fix memory leak in cedrus_init_ctrls()
      staging: rtl8723bs: fix mismatched free of HalData in rtw_sdio_if1_init()

Deepanshu Kartikey (1):
      usb: atm: usbatm: fix invalid ci_range initialization

Delphine CC Chiu (1):
      hwmon: (emc1403) Add support for EMC1442

Desnes Nunes (1):
      iommu/vt-d: Fix UCTP context table slot when copying root entries

Devin Wittmayer (1):
      wifi: mt76: mt76x02: do not WARN on invalid rx descriptor length

Diego Fernando Mancera Gomez (1):
      media: em28xx: defer audio-only extension registration

Dmitry Antipov (2):
      ocfs2: always run deallocs on copy-on-write completion
      smack: simplify write handlers of sysfs entries

Dmitry Baryshkov (2):
      clk: qcom: gdsc: enable optional power domain support
      driver core: platform: don't oops in platform_shutdown() on unbound devices

Dmitry Torokhov (2):
      HID: split apart hid_device_probe to make logic more apparent
      HID: ensure timely release of driver-allocated resources

Doruk Tan Ozturk (2):
      wifi: ath6kl: clamp assoc request/response lengths before subtracting IE offsets
      nfc: llcp: bound SNL TLV parsing to the skb and add length checks

Edward Adam Davis (1):
      bluetooth/l2cap: sync sock recv cb and release

Eric Dumazet (4):
      tcp: fix potential race in tcp_v6_syn_recv_sock()
      net_sched: sch_fq: struct sched_data reorg
      net_sched: sch_fq: change how @inactive is tracked
      net_sched: export pfifo_fast prio2band[]

Erick Henrique (1):
      iio: dac: m62332: Fix regulator reference count imbalance

Evgenii Burenchev (2):
      ALSA: via82xx: Remove unreachable branch in snd_via686_pcm_pointer()
      ALSA: hpi: Check transport errors during HPI6000 adapter initialization

Ewan D. Milne (1):
      nvme: nvme-fc: Fix nvme_fc_create_hw_io_queues() queue deletion in error path

Fabio Estevam (2):
      wifi: mwifiex: Detach sync cmd buffer on interrupted wait
      arm64: dts: rockchip: Fix Gru WLAN sideband interrupt

Fabio Porcedda (1):
      net: usb: qmi_wwan: add Telit Cinterion FE990D50 composition

Fan Wu (5):
      RDMA/cxgb4: Cancel reg_work before freeing device on remove
      power: supply: lp8727: fix use-after-free in lp8727_release_irq()
      mmc: via-sdmmc: stop card-detect handling on probe failure
      media: cx23885: cancel NetUP CI work before teardown
      RDMA/cxgb4: Free debugfs on registration failure

Fan Ye (1):
      net: thunderbolt: Count delivered packets in rx_packets and rx_bytes

Fedor Pchelkin (1):
      Revert "USB: serial: keyspan_pda: fix information leak"

Felix Fietkau (2):
      wifi: mt76: mt7915: avoid nss underflow in mt7915_mcu_get_sta_nss
      wifi: mt76: mt7915: use little-endian for bss_info_ra wire fields

Felix Gu (1):
      spi: img-spfi: don't disable runtime PM on DMA deferred probe

Felix Yan (1):
      clocksource/drivers/timer-sun4i: Advertise a real minimum delta

Feng Yang (1):
      selftests/bpf: Fix memory leak in msg_alloc_iov

Florian Fuchs (1):
      fbdev: pvr2fb: correct user pointer annotation and sentinel initializer

Florian Westphal (1):
      netfilter: nf_nat_sip: rewind offset when NAT shrinks the packet

Frank Sorenson (1):
      cifs: fix clearing stats for fastest execution of each smb2 command

Fu Hao (1):
      iommu/amd: Add support for Hygon family 18h model 4h IOAPIC

Geert Uytterhoeven (2):
      bitfield: Add less-checking __FIELD_{GET,PREP}()
      bitfield: Add non-constant field_{prep,get}() helpers

Giorgi Tchankvetadze (1):
      iio: light: cm32181: return zero after writing calibscale

Gleb Markov (1):
      misc: rtsx: add missing write register handling

Gongwei Li (1):
      Bluetooth: hci_uart: Fix false success return in hci_uart_setup()

Gou Hao (1):
      powerpc/smp: add NULL guard for cause_ipi in smp_muxed_ipi_message_pass

Greg Kroah-Hartman (2):
      driver core: soc: remove layering violation for the soc_bus
      Linux 5.10.270

Griffin Kroah-Hartman (1):
      usb: image: mdc800: change kmalloc() to kzalloc()

Guangshuo Li (6):
      Bluetooth: hci_bcm: fix usage_count leak when autosuspend_delay is negative
      Bluetooth: hci_intel: fix usage_count leak when autosuspend_delay is negative
      clk: tegra: tegra124-emc: put EMC node on register failure
      rapidio: clear mport->net when rio_add_net() fails
      dmaengine: qcom-bam-dma: fix autosuspend cleanup during removal
      clocksource/drivers/clps711x: Do not unmap clocksource MMIO

Gui-Dong Han (1):
      media: cec-pin: Fix event FIFO ordering

Guixin Liu (1):
      nvme-fc: unmap cmd_iu DMA on rsp_iu mapping failure in init_request

Guopeng Zhang (1):
      mm: memcg: stop reclaim when a limit update is superseded

Guoqing Jiang (1):
      RDMA/siw: Introduce siw_free_cm_id

Hajo Noerenberg (1):
      ata: ahci: work around lost interrupts on Marvell 88SE61xx

HanQuan (1):
      ecryptfs: reject oversized encrypted_key_size in parse_tag_3_packet

Hanlin Song (1):
      csky: Fix a4/a5 restoration in syscall trace path

Hans Verkuil (1):
      Revert "media: v4l2-dev: fix error handling in __video_register_device()"

Hans de Goede (1):
      HID: i2c-hid: Switch i2c_hid_parse() to goto style error handling

Hao-Qun Huang (2):
      staging: greybus: hid: fix SET_REPORT return value
      f2fs: reject overlapping move range after len expansion

Haotian Zhang (1):
      dm-switch: use WRITE_ONCE() in switch_region_table_write()

Haowen Tu (1):
      PM: sleep: Fix off-by-one in wakelocks number limit check

Haoxiang Li (4):
      HID: sensor: custom: Fix field sysfs group cleanup on failure
      ASoC: fsl: mpc5200-i2s: Free DMA resources on probe failure
      AsoC: intel: sst: fix PCI device reference leak on probe failure
      iommu/qcom: Remove sysfs device on probe failure path

Haoze Xie (1):
      netfilter: nf_queue: pin bridge device while NFQUEUE holds fake dst

Harry Wentland (1):
      drm/amd/display: avoid divide-by-zero in __is_lut_linear()

Harshit Varu (1):
      mptcp: fix uninitialized local_id in syncookie MP_JOIN reconstruction

Helge Deller (1):
      parisc: Fix alignment of asm statements in head.S

Henrik Grimler (4):
      drm/lima: call drm_mm_init() with a valid allocation range
      power: supply: bq27xxx: bq27520g4: fix REG_TTES address
      power: supply: bq27xxx: bq28z610: fix invalid AverageEnergy address
      power: supply: bq27xxx: bq27z561: fix invalid AverageEnergy address

Herman van Hazendonk (3):
      clk: qcom: gdsc: propagate gdsc_check_status() errors from gdsc_poll_status
      clk: qcom: gdsc: propagate gdsc_enable() failure for ALWAYS_ON domains
      clk: qcom: gdsc: tear down per-domain genpds in gdsc_unregister()

Herve Codina (2):
      irqdomain: Introduce irq_domain_instantiate()
      irqdomain: Handle additional domain flags in irq_domain_instantiate()

Hisam Mehboob (1):
      selftests/rseq: Replace glibc-specific __GNUC_PREREQ with portable check

Hongyan Xu (3):
      usb: gadget: r8a66597: avoid double free of ep0_req in probe error path
      power: supply: isp1704_charger: cancel work on remove
      power: supply: sc2731_charger: cancel work on remove

Hui Su (2):
      tracing: Fix crash passing ERR_PTR to kthread_stop()
      cpufreq: schedutil: Fix rate limit overflow

Hui Tang (4):
      crypto: ecdh - extend 'cra_driver_name' with curve name
      crypto: ecdh - fix 'ecdh_init'
      crypto: ecdh - fix ecdh-nist-p192's entry in testmgr
      crypto: testmgr - fix initialization of 'secret_size'

HyeongJun An (3):
      ALSA: usb-audio: fix OOB write in snd_usbmidi_us122l_output()
      media: s2255: bound JPEG frame size before copying into the buffer
      ASoC: dapm: Fix off-by-one check on the second enum channel

Hyunwoo Kim (3):
      sctp: stop processing a packet once its association is deleted
      sctp: drop a chunk if its transport was removed
      Bluetooth: RFCOMM: Validate MTU in rfcomm_apply_pn() to prevent infinite loop

Ian Rogers (4):
      perf ui hists: Fix uninitialized stack memory free on pstack allocation failure
      perf stat: Fix evsel_list leak in cmd_stat
      perf synthetic-events: Fix uninitialized pthread_join
      perf synthetic-events: Fix divide by zero in perf_event__synthesize_threads

Ibrahim Hashimov (4):
      ubifs: fix out-of-bounds read in signature length check
      HID: picolcd: clamp eeprom debugfs read to bytes actually received
      ocfs2: validate rl_used against rl_count in refcount block validator
      HID: wacom: validate report length in wacom_intuos_pro2_bt_irq

Ikjoon Jang (1):
      power: supply: sbs-battery: cache constant string properties

Ilya Krutskih (2):
      dm raid1: reserve space for NUL-terminator in build_constructor_string()
      media: tda18250: fix possible integer overflow

Ilya Maximets (2):
      net: openvswitch: fix flow mask use-after-free on flow deletion
      net: openvswitch: fix kernel-doc warnings in internal headers

Ira Weiny (1):
      iov_iter: lift memzero_page() to highmem.h

Israel Téllez García (1):
      bpf: Fix pending_pos walk on 32-bit ring position wrap

Ivaylo Dimitrov (1):
      hsi: omap_ssi_core: fix missing DMA mask setup for SSI controller device

Ivy Lopez (1):
      staging: rtl8723bs: use kfree_sensitive() for key material

Jakub Kicinski (1):
      i3c: dw: avoid shift-out-of-bounds when DAA assigns no devices

Jamal Hadi Salim (6):
      net/sched: fq_codel: clamp default quantum and mtu
      net/sched: sch_codel: clamp default mtu to avoid disabling CoDel
      net/sched: fq_pie: clamp default quantum to avoid signed overflow
      net/sched: hhf: clamp quantum before hhf_change() to avoid overflow
      net/sched: sfq: clamp quantum to avoid signed overflow soft lockup
      net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup

James Kim (1):
      rapidio: mport_cdev: fix use-after-free in dma_req_free()

Jameson Thies (2):
      power: supply: cros_usbpd: Limit port counts to EC_USB_PD_MAX_PORTS
      usb: typec: ucsi: displayport: Fix OOB altmode array index

Jeff Johnson (4):
      wifi: ath6kl: avoid buffer overreads in WMI event handlers
      wifi: ath11k: Correctly copy the hint BSSID in WMI scan request
      wifi: ath11k: Avoid buffer overread in ath11k_wmi_tlv_op_rx()
      wifi: ath11k: fix leak in ath11k_service_ready_ext_event()

Jeff Layton (15):
      nfsd: return NFS4ERR_NOTSUPP for unsupported netloc4 types
      nfsd: validate symlink target length in NFSv4 CREATE
      nfsd: add fh_want_write() for early-verified SETATTR in nfsd_proc_setattr()
      nfsd: add filehandle match check to nfsd4_delegreturn()
      nfsd: block non-SAVEFH ops after FOREIGN PUTFH to prevent NULL deref
      nfsd: check client ownership when cancelling a copy-notify stateid
      nfsd: fix version mismatch loops in nfsd_acl_init_request()
      nfsd: fix XDR length calculation in nfsd4_ff_encode_layoutget
      nfsd: fix XDR padding calculation in ff_encode_getdeviceinfo
      nfsd: initialize copy-notify stateid before publishing it
      nfsd: reject reclaim LOCK after RECLAIM_COMPLETE
      nfsd: revoke copy-notify stateids before dropping their reference
      sunrpc: route to a populated pool in svc_pool_for_cpu()
      SUNRPC: always drain cache_cleaner before destroying a cache_detail
      nfs: move the nfs4_data_server_cache into struct nfs_net

Jeffin Philip (2):
      usb: gadget: uvc: fix dangling pointers in uvc_function_bind() and uvc_function_unbind()
      usb: gadget: fix null pointer dereference in usb_put_function_instance()

Jernej Skrabec (6):
      drm/sun4i: vi scaler: Fix coefficient selection
      drm/sun4i: tcon: Drop TCON TOP device reference
      drm/sun4i: crtc: Propagate layer initialization error
      drm/sun4i: tcon: Drop remote endpoint reference
      drm/sun4i: dw-hdmi: Drop TCON TOP port reference
      drm/sun4i: hdmi-phy: Fix H6 8-bit MPLL config at 594 MHz

Jialu Xu (1):
      scripts/tags.sh: improve compiled sources generation

Jian Shen (1):
      net: hns3: don't auto enable misc vector

Jiancheng Huang (1):
      HID: lg4ff: validate report length before fixed offsets

Jiangong.Han (1):
      media: em28xx: fix use-after-free of dev_next->devlist on disconnect

Jiangshan Yi (3):
      HID: mcp2221: validate report size in mcp2221_raw_event()
      bnx2x: fix double free in bnx2x_init_firmware() error path
      selftests: timers: leap-a-day: Fix -w option and update usage comment

Jianing Li (1):
      power: supply: max17040: synchronize work cancellation on suspend

Jiapeng Chong (1):
      net: ip6_gre: Remove the unused function ip6gre_tnl_addr_conflict()

Jiayuan Chen (2):
      bpf: Fix same-register dst/src OOB read and pointer leak in sock_ops
      tcp: fix corruption of urgent data on multi-segment retransmit

Jilin Yuan (1):
      ubi: Fix repeated words in comments

Jingyi Wang (1):
      remoteproc: core: Attach rproc asynchronously in rproc_add() path via schedule_work()

Jinjie Ruan (1):
      entry: Fix seccomp bypass after ptrace with TSYNC

Joas Antonio dos Santos (1):
      ipvs: fix integer overflow in ftp helper port/address parsing

Johan Hovold (3):
      USB: phy: fsl-usb: fix missing static keywords
      remoteproc: scp: Fix device reference leak on failed lookup
      drm/bridge: dw-hdmi: fix i2c adapter leak on probe failure

John Johansen (1):
      apparmor: policy_int make sure list heads are initialized before fail path

Jonathan Cameron (1):
      of: Add cleanup.h based auto release via __free(device_node) markings

Jordan R Abrahams-Whitehead (1):
      include/linux/list.h: mark list_add and __list_add as __always_inline

Joseph Qi (4):
      ocfs2: cluster: don't sleep while holding o2hb_live_lock in o2hb_region_pin()
      ocfs2: cluster: avoid lock order inversion in o2hb_region_pin() from drop_item
      ocfs2: cluster: fix o2hb_dependent_users leak on pin failure
      ocfs2: use bitmap API in fill_node_map

Joshua Crofts (1):
      nilfs2: fix infinite loop in nilfs_clean_segments()

Joy H.J. Lee (1):
      tools/compiler: match glibc 2.42 definition of __attribute_const__

Joy Zou (1):
      regulator: core: use system_freezable_wq for init complete work

Jun Yang (2):
      sctp: distinguish sequence zero from wildcard in reconf lookup
      sctp: fix stream->outcnt underflow on duplicate RECONF responses

Junrui Luo (3):
      media: vicodec: fix out-of-bounds write in FWHT encoder
      NFSv4.2: fix LAYOUTSTATS send buffer exhaustion
      NFSv4/pnfs: key the data server cache on the NFS version

Junseo Lim (3):
      lwt_bpf: Restore reserved headroom after xmit program
      bpf: Reject negative optlen in cgroup getsockopt hook
      net: kcm: Hold RCU read lock while running BPF parser

Jérémy Jean (3):
      timers/itimer: Zero-init old itimerval before copy to userspace
      libceph: reject buckets with mismatched CRUSH ids
      audit: avoid dropping live tree ref on fsnotify rule autoremove

Kalesh AP (1):
      RDMA/restrack: Fix typos in the comments

Kamal Wadhwa (1):
      regulator: qcom-rpmh: Fix PMIC5 BOB bypass mode handling

Karl Mehltretter (8):
      tty: hvc: restrict HVC_DCC to ARMv6+ and ARM64
      ARM: lpc32xx: only run SoC init on LPC32xx hardware
      serial: amba-pl011: unprepare console clock on unregister
      tty: clear cdev pointer after cdev_add() failure
      cpufreq: imx6q: fix devres accumulation across driver rebind
      cpufreq: imx6q: fix out-of-bounds write when probed more than once
      m68k: Fix backtraces for non-running tasks
      8139cp: fix Rx and Tx not being disabled in cp_suspend

Kees Cook (1):
      firmware: coreboot: Check size of table entry and use flex-array

Kemeng Shi (2):
      irqchip/gic-v3-its: Fix memleak in its_probe_one()
      irqchip/gic-v3-its: Prevent leak in its_vpe_irq_domain_alloc()

Kevin Tian (1):
      iommu/vt-d: Fix no_iommu to disable platform opt-in

Kiryl Shutsemau (Meta) (1):
      x86/insn-eval: Move assign_register() out of KVM as insn_assign_reg()

Koichiro Den (10):
      NTB: ntb_transport: Recycle TX entries before client callbacks
      NTB: ntb_transport: Fail TX enqueue when the QP link is down
      NTB: ntb_transport: Reject oversized TX buffers
      net: ntb_netdev: Avoid double-accounting netif_rx() drops
      net: ntb_netdev: Count packets dropped on RX refill failure
      net: ntb_netdev: Fix TX busy and drop handling
      dmaengine: dw-edma: Complete descriptors before pausing
      dmaengine: dw-edma: Serialize abort state updates
      dmaengine: dw-edma: Serialize channel state checks
      dmaengine: dw-edma: Clear stale requests on termination

Konrad Dybcio (1):
      drm/msm/dsi: Drop dev_pm_opp_set_rate(0)

Konstantin Andreev (3):
      smack: fix incorrect task context in smack_msg_queue_msgrcv
      smack: deduplicate smackfs/{direct,mapped} file_operations
      smack: restrict smackfs/{direct,mapped} values to 0-255

Krystian Kaniewski (1):
      ocfs2: fix circular locking dependency in ocfs2_init_acl()

Krzysztof Wilczyński (5):
      alpha/PCI: Fix I/O port accessor argument order in pci_legacy_write()
      PCI/sysfs: Avoid spurious runtime PM wakeup on config space accesses
      PCI/proc: Avoid spurious runtime PM wakeup on config space accesses
      PCI/proc: Use file_ns_capable() when checking config space read access
      PCI/sysfs: Add static PCI resource attribute macros

Kuan-Wei Chiu (1):
      interconnect: Fix use after free in icc_get() and of_icc_get_by_index()

Kuninori Morimoto (2):
      of: property: add missing kerneldoc for of_graph_get_endpoint_count()
      of: property: use unsigned int return on of_graph_get_endpoint_count()

Kyle Zeng (1):
      hfsplus: validate thread record before delete key rebuild

Laxman Acharya Padhya (3):
      iio: light: gp2ap002: Disable regulators on resume failure
      drm/panel: samsung-s6d16d0: Power off on prepare failure
      firmware: coreboot: Validate table bounds

Lee Jones (1):
      crypto: atmel-ecc - Struct headers need to start with keyword 'struct'

Lei Huang (1):
      media: s2255: check firmware size before reading trailing marker

Leo Yan (3):
      perf cs-etm: Flush thread stacks after decoder reset
      perf cs-etm: Avoid truncating AUX buffer sizes to int
      perf: arm_spe: Make wakeup range check overflow safe

Leon Romanovsky (11):
      RDMA/core: Wait for RCU callbacks before unloading ib_core
      RDMA/ipoib: Drain RCU callbacks during module teardown
      RDMA/hfi1: Preserve unit 0 on allocation failure
      RDMA/hfi1: Remove redundant PCI device ID validation
      RDMA/hfi1: Create workqueues before device initialization
      RDMA/hfi1: Stop flushing the global IB workqueue
      RDMA/hfi1: Initialize debugfs after probe completes
      RDMA/srpt: Pass the mapped task attribute to target_init_cmd()
      RDMA/mlx5: Fix stack out-of-bounds read in cc_params debugfs
      RDMA/mlx5: Send cong param changes to the resolved port mdev
      RDMA/cxgb4: free STAG index when TPT entry write fails

Li RongQing (1):
      vdpa/mlx5: fix wrong list iterated in add_direct_chain error path

LiangCheng Wang (1):
      ASoC: fsl-asoc-card: defer probe when the CPU DAI device is not ready

Linghui Wu (1):
      wifi: ath10k: snoc: use memcpy_fromio() for MSA ramdump

Linkai Gong (1):
      i2c: mux: demux-pinctrl: fix OF node leak on kstrdup failure

Linmao Li (5):
      iio: chemical: sgp30: Handle IAQ thread creation failure
      ppdev: prevent overflow when setting port timeout
      ASoC: meson: Keep link pointers valid on realloc failure
      nfc: digital: Do not dump a NULL response in command completion
      mailbox: rockchip: disable pclk on probe failure and unbind

Liu Qi (1):
      usb-storage: ene_ub6250: fix race between scan work and probe

Loic Poulain (1):
      phy: qcom: snps-femto-v2: Fix possible NULL-deref on early runtime suspend

Lothar Rubusch (1):
      crypto: atmel-sha204a - fix heap info leak on I2C transfer failure

Lovekesh Solanki (1):
      USB: gadget: fix NULL pointer dereference in gadget_dev_ioctl()

Lukasz Majewski (1):
      net: hsr: Use full string description when opening HSR network device

Mahanta Jambigi (1):
      net/smc: free pending qentry in smc_llc_flow_stop() before memset

Maher Sanalla (1):
      RDMA/mlx5: Fix integer overflow of user QP buffer size

Mahesh Rao (1):
      firmware: stratix10-svc: Add mutex in stratix10 memory management

Malaya Kumar Rout (1):
      selftests/bpf: Fix memory leak in msg_alloc_iov error path

Manish Rangankar (1):
      scsi: qla2xxx: Remove redundant VPD flash read in sysfs read path

Maoyi Xie (2):
      w1: ds28e17: reject an oversize length on an I2C block read
      drm/bridge: tc358767: clamp the reported AUX read size to the request

Marek Czernohous (2):
      forcedeth: fix off-by-one when saving/restoring non-PCI config space
      forcedeth: stop the tx_timeout register dump past the requested window

Marino Dzalto (1):
      netfilter: xt_HL: add pr_fmt and checkentry validation

Martin Blumenstingl (1):
      clk: meson: align gxbb_32k_clk_sel number of parents with actual count

Martin Kaiser (1):
      hwrng: ks-sa - access private data via struct hwrng

Masami Hiramatsu (Google) (1):
      tracing/mmiotrace: Add NULL check for mmio_trace_array in logging functions

Mathieu Poirier (5):
      remoteproc: Remove useless check in rproc_del()
      remoteproc: Add new RPROC_ATTACHED state
      remoteproc: Add new detach() remoteproc operation
      remoteproc: Introduce function __rproc_detach()
      remoteproc: Introduce function rproc_detach()

Matt Turner (2):
      alpha: marvel: Fix irq_set_status_flags to use correct IRQ number
      alpha: marvel: Fix lock ordering in init_io7_irqs()

Matthieu Baerts (NGI0) (2):
      mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
      mptcp: pm: ADD_ADDR rtx: free sk if last

Matti Vaittinen (1):
      power: supply: bd99954: Drop bad register fields

Maxime Chevallier (5):
      net: stmmac: selftests: Check multiple MMC counters
      net: stmmac: dwmac1000: Account for the primary MAC address for UC filtering
      net: stmmac: dwmac4: Account for the primary MAC address for UC filtering
      net: stmmac: dwxgmac: Account for the primary MAC address for UC filtering
      net: stmmac: selftests: Account for the UC filter list for filtering tests

Maxime Ripard (1):
      drm/bridge: cdns-mhdp8546: Return an error pointer on allocation failure

Meng Yu (1):
      crypto: ecdh - move curve_id of ECDH from the key to algorithm name

Mert Seftali (1):
      iio: accel: dmard09: Implement IIO_CHAN_INFO_SCALE

Miaoqian Lin (1):
      iommu/arm-smmu: Add missing pm_runtime_disable() in qcom_iommu_device_probe

Michael Bommarito (5):
      NFSD: restart ssc_expire_umount walk after dropping nfsd_ssc_lock
      ceph: bound xattr value length in __build_xattrs()
      lockd: pin next file across nlm_inspect_file lock-drop
      HID: roccat: bound device-supplied profile index
      usb: gadget: configfs: fix out-of-bounds read of qw_sign

Michael S. Tsirkin (1):
      virtio_balloon: disable indirect descriptors

Michael Walle (1):
      powerpc/configs: enable CONFIG_RAS to fix EDAC support

Michal Koutný (1):
      netfilter: xt_cgroup: Make it independent from net_cls

Mike Christie (6):
      scsi: qla2xxx: Drop TARGET_SCF_LOOKUP_LUN_FROM_TAG
      scsi: target: Remove TARGET_SCF_LOOKUP_LUN_FROM_TAG
      scsi: qla2xxx: Move sess cmd list/lock to driver
      scsi: target: core: Rename transport_init_se_cmd()
      scsi: target: core: Break up target_submit_cmd_map_sgls()
      scsi: target: srpt: Convert to new submission API

Mike Snitzer (1):
      NFSD: remove flawed WARN_ON_ONCE from nfsd_mode_check

Mikko Perttunen (2):
      gpu: host1x: Fix offset calculation in trace_write_gather
      gpu: host1x: Avoid stack over-read in debug output helpers

Mikulas Patocka (2):
      dm-stats: fix a crash if allocation of per-cpu data fails
      dm: fix resume-vs-remove race

Min zhang (1):
      clk: hisilicon: reset: Use devm_kzalloc to initialize hisi_reset_controller

Mohamad Raizudeen (1):
      PCI: Fix 32-bit config write in Intel PCH Root Port MPC ACS quirk

Mohammed EL Kadiri (2):
      media: venus: fix payload size returned by parse_caps() and parse_alloc_mode()
      media: venus: fix payload size calculation in parse_raw_formats()

Muhammad Bilal (1):
      staging: rtl8723bs: fix OOB read in rtw_action_frame_parse()

Muhammad Usama Anjum (1):
      selftests/arm64: Treat KSM merge_across_nodes as optional

Mukesh Ojha (6):
      iommu/qcom: Fix inverted fault report check in qcom_iommu_fault()
      remoteproc: Use unbounded workqueue for recovery work
      remoteproc: Move resource table data structure to its own header
      remoteproc: use rsc_table_for_each_entry() in rproc_handle_resources()
      remoteproc: fix OOB read via signed offset in rsc_table_for_each_entry()
      firmware_loader: do not queue completed sysfs fallback requests

Myeonghun Pak (5):
      usb: gadget: snps_udc_plat: clean up PHY on probe deferral
      fbdev: uvesafb: unregister connector callback on init failure
      tpm: tpm_i2c_nuvoton: disable IRQ on wait timeout
      char: xilinx_hwicap: unregister class on init errors
      clk: palmas: Manage external-control prepare with devm

Naman Jain (1):
      PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip

Namhyung Kim (1):
      perf stat: Clear screen only if output file is a tty

Naveen Kumar Chaudhary (1):
      locking/lockdep: Fix NULL pointer dereference in __lock_set_class()

Neill Kapron (1):
      usb: gadget: f_fs: Prevent deadlock during ep0 read loop

Nguyen Dinh Phi (1):
      vsock: use sock_error() to consume sk_err after a failed connect

Nikhil Gautam (2):
      iio: light: gp2ap002: Fix unbalanced runtime PM on repeated event writes
      iio: light: gp2ap002: re-enable irq if runtime suspend fails

Niklas Cassel (1):
      ata: libata-scsi: fix DSM TRIM for sector sizes larger than 2048 bytes

Nikolay Aleksandrov (1):
      net: bridge: vlan: fix inverted default vlan notification

Nilesh Javali (19):
      scsi: qla2xxx: Zero SFP DMA buffer in FRU/I2C bsg handlers
      scsi: qla2xxx: Bound i2c->length in I2C bsg handlers
      scsi: qla2xxx: Fix Name Server logout detection on FWI2 adapters
      scsi: qla2xxx: Hold vport reference in qla24xx_report_id_acquisition()
      scsi: qla2xxx: Check entry_status in qla24xx_modify_vp_config()
      scsi: qla2xxx: Bound image count in qla2x00_update_fru_versions()
      scsi: qla2xxx: Clamp MSI-X derived queue counts to avoid truncation
      scsi: qla2xxx: Serialize flash version read in reset handler
      scsi: qla2xxx: Fix cs84xx use-after-free on host teardown
      scsi: qla2xxx: Fix FCE trace use-after-free during firmware dump
      scsi: qla2xxx: Zero mailbox struct in qla2x00_get_firmware_state()
      scsi: qla2xxx: Fix FCE trace enable parsing in debugfs
      scsi: qla2xxx: Don't query firmware state while chip is down
      scsi: qla2xxx: Avoid double completion in async IOCB timeout
      scsi: qla2xxx: Bound rsp_info_len to avoid OOB sense-data read
      scsi: qla2xxx: Avoid req_q_map double-read in qla2x00_error_entry()
      scsi: qla2xxx: Drop vport reference under lock in report ID acquisition
      scsi: qla2xxx: Use coherent DMA buffer for D_Port diagnostics
      scsi: qla2xxx: Zero-init bsg stack buffers to avoid info leak

Norbert Szetei (4):
      RDMA/ucma: Lock the handler in ucma_set_ib_path()
      openvswitch: only skb_tx_error() a packet we are about to drop
      net: skbuff: don't touch shared zerocopy state in skb_tx_error()
      net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()

Ondrej Jirman (1):
      arm64: dts: allwinner: sun50i-a64-pinephone: Fix mpu6050 mount matrix

Pablo Neira Ayuso (3):
      netfilter: nf_tables: make nft_object rhltable per table
      netfilter: nf_tables: move hardware offload step after building the chain blob
      netfilter: x_tables: replace pr_{info,err}() by pr_info_ratelimited()

Pauli Virtanen (1):
      Bluetooth: 6lowpan: fix cyclic locking warning on netdev unregister

Pavel Zhigulin (1):
      speakup: keyhelp: guard letter_offsets possible out-of-range indexing

Pei Xiao (1):
      parisc: eisa: Fix infinite loop when parsing invalid IRQ value

Pengpeng Hou (11):
      eCryptfs: bound the packet-length peek to the user buffer
      mtd: afs: validate v2 image info bounds
      mtd: rawnand: validate ONFI extended parameter page sections
      Input: aiptek - validate raw macro indices before updating state
      crypto: sa2ul - stop probe if context pool creation fails
      pmdomain: bcm: bcm2835: handle genpd provider registration errors
      misc: ad525x_dpot: use driver core groups for sysfs files
      ACPI: processor: validate MADT IOAPIC entry bounds
      thermal: intel: int3400: clean up ODVP on probe failures
      mfd: rave-sp: validate received frame payload lengths
      mfd: iqs62x: Reject zero-length firmware records

Petr Vaganov (1):
      scsi: core: Fill in DMA padding bytes in scsi_alloc_sgtables()

Philipp Borgers (1):
      mac80211: add ieee80211_is_tx_data helper function

Philipp Weber (1):
      HID: core: quiesce input in hid_hw_stop() to prevent use-after-free

Phillip Lougher (1):
      Squashfs: check block offset is not negative

Pranjal Shrivastava (1):
      iommu/arm-smmu-v3: Convert to use atomic poll timeout

Pu Lehui (1):
      bpf: Fix potential UAF in bpf_netns_link_update_prog

Qing Ming (1):
      mpls: reload header after pskb_may_pull()

Qingfang Deng (1):
      pppox: drain queued packets on channel handoff

Rafael J. Wysocki (4):
      cpufreq: intel_pstate: Simplify intel_cpufreq_update_pstate()
      cpufreq: schedutil: Add util to struct sg_cpu
      ACPI: processor: idle: Expand _LPI package sanity checks
      thermal: int340x_thermal: Consolidate priv->data_vault checks

Rafael Mendonca (1):
      scsi: qla2xxx: Fix memory leak in __qlt_24xx_handle_abts()

Ran Hongyun (1):
      UBI: fix two issues in the ubi.mtd MODULE_PARM_DESC

Ricardo Neri (1):
      sched/fair: Check CPU capacity before comparing group types during load balance

Rob Herring (1):
      arm64: dts: rockchip: Fix PCI node addresses on rk3399-gru

Robbie Ko (1):
      nfsd: reject out-of-range useconds in NFSv2 SETATTR/CREATE

Ronald Claveau (1):
      PCI: meson: Fix GPIO state while requesting PERST#

Rosen Penev (4):
      ARM: dts: helios4: add vcc-supply to EEPROM
      ARM: dts: helios4: add vcc-supply to GPIO expander
      ARM: dts: helios4: add SATA regulator supplies
      ASoC: xilinx: formatter_pcm: fix stream_data leak on open error

Runyu Xiao (4):
      fbdev: omapfb: panel-dsi-cm: initialize lock before registering display
      scsi: pm8001: Use rollback index when freeing MSI-X vectors
      ASoC: cs35l33: drain threaded IRQ before runtime suspend
      ASoC: cs35l34: drain threaded IRQ before runtime suspend

Ruoyu Wang (9):
      net: openvswitch: fix nf_connlabels leak in ovs_ct_init
      media: cec: Serialize exclusive follower delivery
      media: cobalt: Avoid freeing ALSA private data twice
      mtd: mtdswap: Avoid freeing registered blktrans device twice
      NFSv4: remove callback IDR entry on client allocation failure
      bonding: initialize err for empty target lists
      net: bridge: Reject descending VLAN tunnel ranges
      tpm: st33zp24: Return zero on status read failure
      tpm: st33zp24: Validate locality read result

Russ Weight (1):
      firmware_loader: Check fw_state_is_done in loading_store

Ryusuke Konishi (1):
      nilfs2: fix slab-out-of-bounds in nilfs_direct_propagate after truncation

Sabrina Dubroca (1):
      espintcp: remove encap socket caching to avoid reference leak

Sajal Gupta (1):
      md/raid5-ppl: fix use-after-free in ppl_do_flush()

Sang-Heon Jeon (2):
      iio: light: isl29028: return zero in write_raw() on success
      iio: light: tsl2583: return zero in write_raw() on success

Sanjay Chitroda (2):
      iio: temperature: hid-sensor-temperature: switch to non-devm iio_device_register()
      iio: orientation: hid-sensor-rotation: Avoid race between callback setup and device exposure

Sean Rhodes (1):
      misc: rtsx_usb: avoid USB I/O in runtime autosuspend

Sean Young (2):
      media: keymaps: Remove obsolete RC_MAP_RC5_TV keymap define
      media: keymaps: Remove obsolete RC_MAP_HAUPPAUGE_NEW keymap define

Sebastian Andrzej Siewior (2):
      scsi: target: core: Replace in_interrupt() usage in target_submit_cmd_map_sgls()
      hsr: Use a single struct for self_node.

Sebastian Urban (1):
      Bluetooth: compute LE flow credits based on recvbuf space

Sechang Lim (1):
      tcp: clear sock_ops cb flags before force-closing a child socket

Seiji Nishikawa (1):
      ipmi: si: Fix NULL pointer dereference after failed registration

Sergei Litvin (1):
      scripts/tags.sh: Prevent binary files appearing in cscope.files

Serhat Kumral (1):
      RDMA/ucma: Allow path records to exactly fit the output buffer

Shin'ichiro Kawasaki (1):
      nvmet-rdma: factor out response resource cleanup

Shivam Kumar (2):
      nvmet-tcp: fix out-of-bounds write when receiving an over-long PDU
      nvmet-tcp: reject unsolicited H2CData PDUs

Shuangpeng Bai (3):
      media: usbtv: keep device alive while ALSA card exists
      media: go7007: defer the ALSA v4l2 put until card release
      RDMA/siw: Fix use-after-free in siw_accept()

Simon Glass (1):
      pinctrl: rockchip: Reset the pin count when recalculating SoC data

Slawomir Stepien (1):
      wifi: zd1211rw: reject secondary interfaces to prevent conflicts

Sonali Pradhan (1):
      usb: gadget: u_audio: Fix use-after-free on sound card disconnect

Srinivas Kandagatla (5):
      soundwire: add static port mapping support
      soundwire: qcom: update port map allocation bit mask
      soundwire: qcom: add static port map support
      soundwire: qcom: Fix port exhaustion check in stream_alloc_ports
      rpmsg: glink: remove duplicate code for rpmsg device remove

Stanislav Kinsburskii (1):
      lib/test_hmm: fail dmirror_fault() when the mirrored mm is gone

Stanislaw Gruszka (1):
      wifi: rtl818x: initialize eeprom_93cx6 struct to zero

Stefan Haberland (3):
      s390/dasd: Do not complete a failed ESE read as successful
      s390/dasd: Guard sysfs discipline callbacks against unallocated private data
      s390/dasd: Propagate partial completion length across ERP recovery

Stephan Gerhold (2):
      clk: qcom: gcc-msm8916: Fix enable_reg for gcc_blsp1_sleep_clk
      clk: qcom: gcc-msm8939: Fix enable_reg for gcc_blsp1_sleep_clk

Steven Rostedt (1):
      tracing/mmiotrace: Remove reference to unused per CPU data pointer

Sujal Tuladhar (1):
      scsi: target: iscsi: Reserve a terminator byte for the login payload

Suman Anna (2):
      remoteproc: Add a rproc_set_firmware() API
      remoteproc: Fix various kernel-doc warnings

Sunil Khatri (1):
      drm/amdgpu: use AMDGPU_GPU_PAGE_SHIFT instead of PAGE_SHIFT

Suraj Gupta (1):
      dmaengine: xilinx_dma: Fix channel idle state management in AXIDMA and MCDMA interrupt handlers

Sven Eckelmann (4):
      batman-adv: dat: avoid unaligned fault in IP extraction
      batman-adv: bla: fix freeing of claims on meshif deletion
      batman-adv: bla: prevent CRC corruptions after claim flush
      batman-adv: bla: avoid CRC corruption due to parallel claim add

Takashi Iwai (6):
      ALSA: aloop: Fix racy access at PCM trigger
      ALSA: mpu401: Check card index validity at probe
      ALSA: mts64: Check card index validity at probe
      ALSA: portman2x4: Check card index validity at probe
      ALSA: serial-u16550: Check card index validity at probe
      ALSA: pcm: Fix race between non-atomic ops and trigger-start

TanZheng (1):
      RDMA/srpt: Fix srpt_alloc_rw_ctxs() unwind counters

Tang Bin (1):
      crypto: sa2ul - Use the defined variable to clean code

Tanushree Shah (2):
      perf trace-event: Fix buffer overflow in read_string()
      perf trace-event: Fix integer truncation in do_read() and skip()

Tao Cui (3):
      block/blk-stat: drain per-cpu callback stats over possible CPUs
      block/blk-iocost: collect per-cpu latency stats over possible CPUs
      block/kyber-iosched: flush per-cpu latency buckets over possible CPUs

Tetsuo Handa (1):
      RDMA/core: Avoid flush_workqueue(system_unbound_wq) usage

Thadeu Lima de Souza Cascardo (1):
      drm: Fix drm_crtc_commit leak if signaled when PAGE_FLIP_EVENT is used

Thomas Bogendoerfer (1):
      MIPS: ptrace: Fix syscall skipping via PTRACE_SYSCALL

Thomas Gleixner (3):
      timer: Keep debugobjects state consistent in migrate_timer_list()
      highmem: Provide generic variant of kmap_atomic*
      mm/highmem: Take kmap_high_get() properly into account

Thomas Weißschuh (1):
      y2038: uapi: Use 64-bit __kernel_old_timespec::tv_nsec on x32

Thomas Zimmermann (1):
      drm/hibmc: Fix list of formats on the primary plane

Thorsten Blum (4):
      crypto: atmel-ecc - replace min_t with min
      crypto: atmel-ecc - clean up and improve ECDH comments
      crypto: atmel-ecc - reject hardware ECDH without a public key
      apparmor: Replace sprintf/strcpy with scnprintf/strscpy in aa_policy_init

Tien Sung Ang (1):
      fpga: stratix10-soc: Fix SVC mailbox handling during reconfiguration

Timur Kristóf (3):
      drm/amdgpu/gfx6: Fixup emit_cntxcntl()
      drm/amdgpu/gfx6: Fixup emitting SWITCH_BUFFER packets
      drm/amdgpu/gfx6: Use PFP on the compute queues too

Titouan Ameline de Cadeville (1):
      firmware: google: Add bounds checks in coreboot_table_populate()

Tomáš Macholda (1):
      arm64: dts: turris-mox: fix usb3 phys

Tristan Madani (1):
      RDMA/rxe: Fix TOCTOU heap overflow in get_srq_wqe

Trond Myklebust (2):
      NFS: Always clear an invalid mapping when attempting a buffered write
      NFSv4/pnfs: Clean up layout get on open

Tzung-Bi Shih (2):
      platform/chrome: sensorhub: Fix dropped timestamp events and log spam
      platform/chrome: sensorhub: Fix memory overread in ring handler

Uday Khare (2):
      media: video-i2c: fix kthread error pointer left in kthread_vid_cap on failure
      remoteproc: qcom: Fix glink->node reference leak in qcom_add_glink_subdev

Uwe Kleine-König (7):
      driver core: platform: reorder functions
      driver core: platform: change logic implementing platform_driver_probe
      driver core: platform: use bus_type functions
      driver core: platform: Emit a warning if a remove callback returned non-zero
      platform: Provide a remove callback that returns no value
      misc: ad525x_dpot: Make ad_dpot_remove() return void
      power: supply: sc2731_charger: Convert to platform remove callback returning void

Vaibhav Nagare (1):
      qede: Fix NULL pointer dereference in TPA fragment processing

Valentin Kindschi (1):
      Bluetooth: hci_event: clear HCI_LE_ADV only on a created connection

Valentin Schneider (1):
      sched/fair: Introduce a CPU capacity comparison helper

Valery Borovsky (3):
      media: airspy: use vb2_video_unregister_device() on disconnect to fix NULL deref
      media: rtl2832_sdr: use vb2_video_unregister_device() on remove to fix DMA leak
      media: rtl2832_sdr: release URBs and stream buffers on start_streaming() failure

Venkateswara Naralasetty (1):
      ath11k: add trace log support

Victor Nogueira (1):
      net/sched: sch_teql: restore skb->dev on the slave failure path

Vincent Mailhol (1):
      lib/ucs2_string.c: fix out-of-bounds read in ucs2_strnlen()

Vishnu Santhosh (1):
      rpmsg: glink: fix deadlock in endpoint destroy during driver detach

Vladimir Murzin (1):
      arm64: hibernate: Restore DAIF state on error

Vladimir Zapolskiy (4):
      dmaengine: mediatek: mtk-uart-apdma: Return -ENOMEM on memory allocation failure
      dmaengine: hisilicon: Return -ENOMEM on dynamic memory allocation in probe
      iommu/msm: Return -ENOMEM on memory allocation failure in probe
      clk: qcom: Return expected ENOMEM error on dynamic allocation failure

Wang Liang (1):
      net: fix NULL pointer dereference in l3mdev_l3_rcv

Wei Jie Law (1):
      HID: rmi: fix OOB access with undersized RMI reports

Wei Wang (2):
      iommu/amd: Prevent SB IOAPIC from overriding IVRS validation errors
      iommu/amd: Fix false positive in SB IOAPIC IVRS validation

Weigang He (3):
      media: cec: stm32: prevent out-of-bounds write on RX overflow
      soc: samsung: exynos-pmu: fix of_node refcount leak in exynos_get_pmu_regmap()
      ARM: imx: fix device_node refcount leak in imx_src_init()

Weiming Shi (3):
      sctp: fix NULL deref on untransmitted RECONF completion
      xdp: fix zero-copy frame layout
      SUNRPC: check rpc_sockaddr2uaddr() return value in rpcb_register_inet4/6

WenTao Liang (3):
      regulator: as3722_get_regulator_dt_data: fix premature of_node_put leaving dangling of_node pointer
      regulator: max8998_pmic_dt_parse_pdata: of_node_put on reg_np after ownership transferred to rdata
      ASoC: samsung: aries_audio_probe: double of_node_put due to direct assignment without of_node_get

Wenjie Qi (1):
      f2fs: return symlink writeback errors

Wentao Liang (1):
      drm/sun4i: fix refcount leak in sun4i_backend_init_sat()

Wolfram Sang (2):
      hwspinlock: propagate errno when registering single lock
      ACPI: move from strlcpy() with unused retval to strscpy()

Xiang Mei (4):
      bridge: mrp: reject zero test interval to avoid OOM panic
      xfrm6: fix out-of-bounds write in xfrm6_input_addr() when secpath is full
      vfio/pci: clear vdev->msi_perm after freeing it on init failure
      net: qualcomm: rmnet: restore skb->dev on deaggregated frames

Xie Yuanbin (1):
      ARM: 9485/1: mm: acquire mmap write lock around show_pte() for user faults

Xingrui Li (1):
      HID: sensor-hub: Fix out-of-bounds write in sensor_hub_get_feature

Xiubo Li (1):
      ceph: fix UAF in __kick_flushing_caps() on cf entry freed during unlock

Xu Rao (3):
      HID: roccat: free buffered reports when destroying device
      mtd: mtdoops: free page bitmap when the backing MTD is removed
      ALSA: hda: Fix connection list comparison in proc output

Xu Yang (1):
      usb: gadget: f_uac1_legacy: remove broken string configfs attributes

Yang Li (1):
      ubi: Simplify bool conversion

Yehyeong Lee (8):
      nvme: zero the discard fallback page
      nvme-tcp: do not accept C2HData based on blk_rq_payload_bytes() alone
      nvme-tcp: check the data direction of a C2HData PDU
      IB/isert: reject PDUs declaring more data than was received
      IB/isert: reject login PDUs declaring more data than was received
      RDMA/srp: fix heap information leak on a truncated SRP_CRED_REQ
      IB/isert: delay the final Login Response until the session is registered
      IB/isert: post the full-feature receive buffers after session registration

Yemu Lu (1):
      fat: restore original value when fat_ent_write failed

Yi Ding (2):
      media: cec: meson: ao-cec-g12a: name the CEC core regmap to avoid debugfs clash
      rtc: pcf8563: fix clock provider leak on unbind

Yichong Chen (10):
      ecryptfs: fix tag 11 packet exact-fit size check
      ecryptfs: hold msg ctx list lock when cleaning daemon queue
      ecryptfs: pass packet set buffer size to parser
      ecryptfs: reject too-small tag 70 packets
      ecryptfs: release message context on send failure
      ecryptfs: show filename encryption options
      isofs: release zisofs block pointer buffer head
      fanotify: report full event length for FIONREAD
      fat: release buffer head after rebuilding parent
      hugetlbfs: release subpool on fill_super failure

Yifei Gao (1):
      orangefs: fix double-free of trailer_buf on readdir copy failure

Yinhao Hu (1):
      nfc: pn533: hold a reference to the request skb during send_frame

Yonatan Nachum (1):
      RDMA/efa: Fix PBL chunk length computation

Youngjae Kwon (1):
      fsnotify: Fix stale object mask after concurrent mark updates

Yousef Alhouseen (2):
      ipmi: ipmb: validate write message length
      HID: synchronize input before cleaning up a failed probe

Yuan Chen (1):
      bpftool: Fix double close in map dump

Yuanshen Cao (1):
      iio: light: tsl2772: fix ALS calibscale readback

Yuho Choi (8):
      bus: ti-sysc: Fix /chosen node reference leak
      clocksource: Unregister subsystem on device registration failure
      hwrng: ks-sa - Fix runtime PM cleanup on registration failure
      uio: Fix stale info pointer in failed registration path
      driver core: soc: Unregister bus on early device registration failure
      ubi: Fix rollback for explicit UBI device numbers
      xenbus: Unregister reboot notifier on init failure
      clocksource/drivers/armada: Unwind timer clock on init failure

Yun Zhou (2):
      usb: gadget: f_tcm: fix deadlock in usbg_make_tpg()
      ext4: skip extra isize expansion during mount to prevent deadlock

Yuqi Xu (1):
      openvswitch: Fix CT limit teardown use-after-free

Yuvraj Singh Chauhan (1):
      staging: octeon: fix free_irq dev_id mismatch in cvm_oct_rx_shutdown

Yuyang Huang (1):
      ipv6: use RCU iterator to dump route exceptions

Zack Rusin (1):
      drm/vmwgfx: drop dma_buf reference on foreign-fd prime import

Zhan Xusheng (3):
      ocfs2: fix readdir position truncation on 32-bit kernels
      udf: Fix i_lenExtents truncation on 32-bit kernels
      f2fs: fix i_size when pinned fallocate partially fails

Zhang Chen (1):
      Bluetooth: L2CAP: Fix send LE flow credits in ACL link

ZhaoLong Wang (1):
      ubi: fastmap: Add fastmap control support for module parameter

Zhengchuan Liang (1):
      net: af_key: zero aligned sockaddr tail in PF_KEY exports

Zhenghang Xiao (1):
      nfc: nci: fix double completion race in nci_data_exchange_complete

Zhihao Cheng (10):
      ubi: fastmap: Fix missed ec updating after erasing old fastmap data block
      ubi: fastmap: erase_block: Get erase counter from wl_entry rather than flash
      ubi: fastmap: Allocate memory with GFP_NOFS in ubi_update_fastmap
      ubi: Replace erase_block() with sync_erase()
      UBI: Preserve torture flag when rescheduling failed erasures
      UBI: fastmap: Pass to_be_tortured when reusing old fastmap PEBs
      ubi: fastmap: Add fastmap control support for 'UBI_IOCATT' ioctl
      ubi: fastmap: Wait until there are enough free PEBs before filling pools
      ubi: fastmap: Fix lapsed wear leveling for first 64 PEBs
      ubi: fastmap: Add module parameter to control reserving filling pool PEBs

Zhiling Zou (6):
      ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
      ip6_gre: fix hardware header length for NBMA tunnels
      orangefs: skip leading spaces before parsing client debug masks
      net: cap advertised IP tunnel headroom
      seg6: reset IP6CB after IPv6 decapsulation
      batman-adv: fix stale receive device on merged fragments

Zhongqiu Han (1):
      cpufreq: schedutil: Fix self-contradictory comment in sugov_iowait_apply()

Zhu Yanjun (1):
      RDMA/cma: Fix WARNING in res_to_rt

Zide Chen (1):
      perf/x86/intel/uncore: Keep PCI PMUs working when MMIO/MSR setup fails

Zijun Hu (1):
      Bluetooth: btusb: Fix BD_ADDR byte order in btusb_set_bdaddr_wcn6855()

bui duc phuc (3):
      ASoC: pxa: Use devm_clk_get_optional() for extclk clock
      net: ethernet: sun4i-emac: Fix IRQ error handling
      net: fec: only stop PTP if it was initialized

caina (1):
      Revert "irqchip/mbigen: Fix mbigen node address layout"

liyouhong (1):
      dm-era: fix shadowed superblock leak on take-snap failure

longlong yan (1):
      clk/x86: pmc_atom: add kasprintf return value check

zhouminqiang (1):
      mtd: part: reject MTDPART_OFS_RETAIN in mtd_add_partition()

