Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7B4443AB1;
	Mon, 14 Sep 2026 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387093; cv=none; b=eRwxWcX4Tx4YLQu2JryQKo5dJCBlDaZmYUXH4fC/37+lCoBU3qvAJrRNPv9yumkkY3WM2z5pNNCJols/9eOX4qIYcAAV7qwOWCdnS51Fsz5qtdeo5MKHBj2DBXjoyyr87DDqPHED9pHAydger2BsucMzYdKhetB5+LtCbHauy1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387093; c=relaxed/simple;
	bh=EmvMDZBB0Jy5CPo0O/cZNiwnLLYGfxMgT8tTirqRtEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OBP7h13p/ujZl0rrPywrdMUUNpVwyxiV0kBxLNUfdwZEsxap0Y9Jng2t5vPmFnnq595CNGMYsJGnZ5xlBMgYMNtBgGjE4UzFdu7iTGHJfAdEpfpCdeDUEj9RnGx5jK+im5rAXL+azs05bzAlG9CfkptLbXhhVP8nIqqorjYMDAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h5YBGY5W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h5YBGY5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BDA1F00893;
	Mon, 14 Sep 2026 11:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789387086;
	bh=Ne6ghU98EnGU1eP1Ud7/m9y7j3riPx1tghaCurjUvrE=;
	h=From:To:Cc:Subject:Date;
	b=h5YBGY5Wxj3sApYUtTdsIZHCyCyXDdZ83TWNw1YvbcH37Hq2OC/Eyrco+7Tgy3Duf
	 lFHAeT/PgL0dv/Qk7TKAIV1b56mUMGOfV+Jupp71LYPrcTu0q0tyq9MkiZpjLlBr99
	 mO0xUaXV/9KFlkPKbyDVdfwO79mzAb3vvUF/pYXQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.221
Date: Mon, 14 Sep 2026 13:57:51 +0200
Message-ID: <2026091451-erasure-unzip-fcdd@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.221 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/configfs-usb-gadget-uac1_legacy       |    3 
 Documentation/usb/gadget-testing.rst                            |    3 
 Documentation/userspace-api/media/v4l/ext-ctrls-colorimetry.rst |   12 
 Makefile                                                        |    2 
 arch/alpha/include/uapi/asm/fpu.h                               |    8 
 arch/alpha/kernel/pci-sysfs.c                                   |    6 
 arch/alpha/kernel/sys_marvel.c                                  |   25 
 arch/alpha/kernel/traps.c                                       |    6 
 arch/alpha/math-emu/math.c                                      |   88 ++
 arch/arm/boot/dts/armada-388-helios4.dts                        |   13 
 arch/arm/boot/dts/sun4i-a10.dtsi                                |    2 
 arch/arm/mach-imx/src.c                                         |    3 
 arch/arm/mach-lpc32xx/common.c                                  |    5 
 arch/arm/mach-lpc32xx/common.h                                  |    2 
 arch/arm/mach-lpc32xx/phy3250.c                                 |    2 
 arch/arm/mach-lpc32xx/pm.c                                      |    5 
 arch/arm/mm/fault.c                                             |   16 
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi         |    4 
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts                  |    4 
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts          |    3 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                            |   51 -
 arch/arm64/boot/dts/rockchip/Makefile                           |    1 
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi         |    6 
 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts        |   41 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi                    |    1 
 arch/arm64/kernel/hibernate.c                                   |   16 
 arch/csky/kernel/entry.S                                        |    6 
 arch/m68k/kernel/traps.c                                        |    4 
 arch/mips/kernel/ptrace.c                                       |    6 
 arch/openrisc/kernel/entry.S                                    |   43 +
 arch/parisc/kernel/head.S                                       |    1 
 arch/powerpc/configs/85xx-hw.config                             |    1 
 arch/powerpc/kernel/smp.c                                       |    3 
 arch/powerpc/platforms/powermac/low_i2c.c                       |    2 
 arch/s390/kernel/debug.c                                        |   10 
 arch/s390/kvm/guestdbg.c                                        |    9 
 arch/s390/kvm/interrupt.c                                       |    2 
 arch/s390/kvm/kvm-s390.c                                        |    7 
 arch/x86/events/intel/lbr.c                                     |   12 
 arch/x86/events/intel/uncore.c                                  |    2 
 arch/x86/include/asm/insn-eval.h                                |   36 
 arch/x86/include/asm/pkeys.h                                    |    3 
 arch/x86/kvm/emulate.c                                          |   26 
 arch/x86/kvm/hyperv.c                                           |   25 
 arch/x86/kvm/vmx/nested.c                                       |   18 
 arch/x86/mm/ident_map.c                                         |   23 
 block/blk-iocost.c                                              |    2 
 block/blk-stat.c                                                |    2 
 block/genhd.c                                                   |    7 
 block/kyber-iosched.c                                           |    2 
 drivers/accessibility/speakup/keyhelp.c                         |   17 
 drivers/accessibility/speakup/kobjects.c                        |    6 
 drivers/acpi/bus.c                                              |    4 
 drivers/acpi/pci_root.c                                         |    3 
 drivers/acpi/processor_core.c                                   |   31 
 drivers/acpi/processor_idle.c                                   |   34 
 drivers/acpi/utils.c                                            |    6 
 drivers/ata/ahci.c                                              |   49 +
 drivers/ata/libata-scsi.c                                       |   28 
 drivers/auxdisplay/charlcd.c                                    |   21 
 drivers/base/arch_numa.c                                        |   12 
 drivers/base/firmware_loader/fallback.c                         |   38 -
 drivers/base/firmware_loader/firmware.h                         |   10 
 drivers/base/soc.c                                              |   21 
 drivers/base/swnode.c                                           |    2 
 drivers/bluetooth/btmtksdio.c                                   |   13 
 drivers/bluetooth/btusb.c                                       |   15 
 drivers/bluetooth/hci_bcm.c                                     |    1 
 drivers/bluetooth/hci_h5.c                                      |    4 
 drivers/bluetooth/hci_intel.c                                   |    1 
 drivers/bluetooth/hci_ldisc.c                                   |    2 
 drivers/bluetooth/hci_serdev.c                                  |    2 
 drivers/bluetooth/virtio_bt.c                                   |    8 
 drivers/bus/mhi/host/main.c                                     |    6 
 drivers/bus/ti-sysc.c                                           |   12 
 drivers/char/hw_random/ks-sa-rng.c                              |   22 
 drivers/char/ipmi/ipmb_dev_int.c                                |    5 
 drivers/char/ipmi/ipmi_msghandler.c                             |    1 
 drivers/char/ppdev.c                                            |   10 
 drivers/char/tpm/st33zp24/st33zp24.c                            |    8 
 drivers/char/tpm/tpm_i2c_nuvoton.c                              |    6 
 drivers/char/xilinx_hwicap/xilinx_hwicap.c                      |    5 
 drivers/clk/clk-moxart.c                                        |   14 
 drivers/clk/clk-palmas.c                                        |   14 
 drivers/clk/hisilicon/reset.c                                   |    2 
 drivers/clk/imx/clk-scu.c                                       |    1 
 drivers/clk/meson/gxbb.c                                        |    2 
 drivers/clk/qcom/common.c                                       |    4 
 drivers/clk/qcom/dispcc-sm8250.c                                |    1 
 drivers/clk/qcom/gcc-mdm9607.c                                  |  182 -----
 drivers/clk/qcom/gcc-msm8916.c                                  |    5 
 drivers/clk/qcom/gcc-msm8939.c                                  |    5 
 drivers/clk/qcom/gdsc.c                                         |  108 ++
 drivers/clk/qcom/gdsc.h                                         |    2 
 drivers/clk/qcom/videocc-sm8250.c                               |    4 
 drivers/clk/tegra/clk-tegra124-emc.c                            |    1 
 drivers/clk/x86/clk-pmc-atom.c                                  |    3 
 drivers/clocksource/clps711x-timer.c                            |    2 
 drivers/clocksource/timer-armada-370-xp.c                       |   18 
 drivers/clocksource/timer-sun4i.c                               |    2 
 drivers/cpufreq/imx6q-cpufreq.c                                 |    6 
 drivers/cpufreq/intel_pstate.c                                  |   19 
 drivers/cpufreq/spear-cpufreq.c                                 |    4 
 drivers/crypto/atmel-ecc.c                                      |   45 -
 drivers/crypto/atmel-sha204a.c                                  |    6 
 drivers/crypto/gemini/sl3516-ce-cipher.c                        |    8 
 drivers/crypto/hisilicon/sec2/sec_crypto.c                      |   12 
 drivers/crypto/keembay/keembay-ocs-aes-core.c                   |    5 
 drivers/crypto/qat/qat_common/qat_algs.c                        |    1 
 drivers/crypto/sa2ul.c                                          |   19 
 drivers/dma/dw-edma/dw-edma-core.c                              |   37 -
 drivers/dma/hisi_dma.c                                          |    2 
 drivers/dma/mediatek/mtk-uart-apdma.c                           |    2 
 drivers/dma/qcom/bam_dma.c                                      |    1 
 drivers/dma/xilinx/xilinx_dma.c                                 |   12 
 drivers/firmware/google/coreboot_table.c                        |   26 
 drivers/firmware/stratix10-svc.c                                |   21 
 drivers/fpga/altera-cvp.c                                       |   10 
 drivers/fpga/stratix10-soc.c                                    |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                           |   74 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c         |    6 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c             |   24 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c           |   35 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c             |    2 
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c                       |    3 
 drivers/gpu/drm/bridge/tc358767.c                               |    2 
 drivers/gpu/drm/drm_atomic_uapi.c                               |    2 
 drivers/gpu/drm/drm_drv.c                                       |   34 
 drivers/gpu/drm/gud/gud_connector.c                             |   12 
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c                  |    6 
 drivers/gpu/drm/lima/lima_device.c                              |   12 
 drivers/gpu/drm/msm/dsi/dsi_host.c                              |   14 
 drivers/gpu/drm/nouveau/nouveau_sgdma.c                         |    4 
 drivers/gpu/drm/omapdrm/dss/dsi.c                               |    7 
 drivers/gpu/drm/omapdrm/dss/dsi.h                               |    2 
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c                   |   10 
 drivers/gpu/drm/sun4i/sun4i_backend.c                           |    2 
 drivers/gpu/drm/sun4i/sun4i_crtc.c                              |    2 
 drivers/gpu/drm/sun4i/sun4i_tcon.c                              |   20 
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c                           |    2 
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c                          |    2 
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c                         |   18 
 drivers/gpu/drm/tve200/tve200_drv.c                             |    1 
 drivers/gpu/drm/vmwgfx/ttm_object.c                             |    7 
 drivers/gpu/host1x/debug.c                                      |    4 
 drivers/gpu/host1x/hw/channel_hw.c                              |    5 
 drivers/hid/hid-core.c                                          |  127 ++-
 drivers/hid/hid-lg4ff.c                                         |    8 
 drivers/hid/hid-mcp2221.c                                       |    7 
 drivers/hid/hid-picolcd_debugfs.c                               |    9 
 drivers/hid/hid-rmi.c                                           |   46 +
 drivers/hid/hid-roccat-kone.c                                   |    8 
 drivers/hid/hid-roccat.c                                        |   13 
 drivers/hid/hid-sensor-custom.c                                 |    9 
 drivers/hid/hid-sensor-hub.c                                    |   42 -
 drivers/hid/i2c-hid/i2c-hid-core.c                              |   16 
 drivers/hid/wacom_wac.c                                         |   13 
 drivers/hsi/controllers/omap_ssi_core.c                         |    6 
 drivers/hwmon/emc1403.c                                         |    6 
 drivers/hwmon/max6621.c                                         |    8 
 drivers/hwspinlock/hwspinlock_core.c                            |    2 
 drivers/hwtracing/coresight/coresight-etm4x-cfg.c               |    2 
 drivers/hwtracing/coresight/coresight-etm4x-core.c              |   87 --
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c             |    6 
 drivers/hwtracing/coresight/coresight-etm4x.h                   |   38 -
 drivers/i2c/i2c-core-base.c                                     |    6 
 drivers/i2c/i2c-mux.c                                           |    1 
 drivers/i2c/muxes/i2c-demux-pinctrl.c                           |    1 
 drivers/i3c/master.c                                            |   11 
 drivers/i3c/master/dw-i3c-master.c                              |   10 
 drivers/i3c/master/mipi-i3c-hci/core.c                          |   30 
 drivers/i3c/master/mipi-i3c-hci/dma.c                           |    4 
 drivers/i3c/master/mipi-i3c-hci/ext_caps.c                      |   55 -
 drivers/i3c/master/mipi-i3c-hci/pio.c                           |   54 -
 drivers/i3c/master/svc-i3c-master.c                             |   10 
 drivers/iio/accel/dmard09.c                                     |    7 
 drivers/iio/chemical/atlas-sensor.c                             |    6 
 drivers/iio/chemical/sgp30.c                                    |    3 
 drivers/iio/dac/m62332.c                                        |   17 
 drivers/iio/gyro/mpu3050-core.c                                 |    2 
 drivers/iio/light/cm32181.c                                     |    2 
 drivers/iio/light/gp2ap002.c                                    |   24 
 drivers/iio/light/isl29028.c                                    |    2 
 drivers/iio/light/tsl2583.c                                     |    2 
 drivers/iio/light/tsl2772.c                                     |    2 
 drivers/iio/orientation/hid-sensor-rotation.c                   |   20 
 drivers/iio/proximity/srf04.c                                   |    1 
 drivers/iio/temperature/hid-sensor-temperature.c                |    3 
 drivers/infiniband/core/cma.c                                   |    6 
 drivers/infiniband/core/cq.c                                    |   14 
 drivers/infiniband/core/device.c                                |   27 
 drivers/infiniband/core/nldev.c                                 |  117 +--
 drivers/infiniband/core/restrack.c                              |    4 
 drivers/infiniband/core/ucma.c                                  |    7 
 drivers/infiniband/hw/cxgb4/device.c                            |    8 
 drivers/infiniband/hw/cxgb4/mem.c                               |    4 
 drivers/infiniband/hw/efa/efa_verbs.c                           |   13 
 drivers/infiniband/hw/hfi1/chip.c                               |    4 
 drivers/infiniband/hw/hfi1/hfi.h                                |    2 
 drivers/infiniband/hw/hfi1/init.c                               |   44 -
 drivers/infiniband/hw/hfi1/user_sdma.c                          |   13 
 drivers/infiniband/hw/mlx4/cm.c                                 |   29 
 drivers/infiniband/hw/mlx4/main.c                               |   18 
 drivers/infiniband/hw/mlx4/mlx4_ib.h                            |    6 
 drivers/infiniband/hw/mlx4/qp.c                                 |  121 ++-
 drivers/infiniband/hw/mlx5/cong.c                               |    8 
 drivers/infiniband/hw/mlx5/main.c                               |    9 
 drivers/infiniband/hw/mlx5/qp.c                                 |  144 ++-
 drivers/infiniband/hw/mlx5/qp.h                                 |    2 
 drivers/infiniband/hw/mlx5/qpc.c                                |    3 
 drivers/infiniband/sw/rxe/rxe_resp.c                            |    6 
 drivers/infiniband/sw/siw/siw_cm.c                              |   32 
 drivers/infiniband/ulp/ipoib/ipoib_main.c                       |    2 
 drivers/infiniband/ulp/isert/ib_isert.c                         |   85 +-
 drivers/infiniband/ulp/isert/ib_isert.h                         |    1 
 drivers/infiniband/ulp/srp/ib_srp.c                             |   45 -
 drivers/infiniband/ulp/srpt/ib_srpt.c                           |    9 
 drivers/input/tablet/aiptek.c                                   |   33 
 drivers/interconnect/core.c                                     |    7 
 drivers/iommu/amd/init.c                                        |   42 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                     |    5 
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                         |   14 
 drivers/iommu/dma-iommu.c                                       |   13 
 drivers/iommu/intel/iommu.c                                     |   16 
 drivers/iommu/msm_iommu.c                                       |    2 
 drivers/iommu/mtk_iommu_v1.c                                    |    2 
 drivers/irqchip/irq-gic-v3-its.c                                |   15 
 drivers/irqchip/irq-mbigen.c                                    |   20 
 drivers/leds/leds-pca9532.c                                     |   18 
 drivers/mailbox/rockchip-mailbox.c                              |   17 
 drivers/md/dm-era-target.c                                      |    5 
 drivers/md/dm-log-userspace-base.c                              |    1 
 drivers/md/dm-stats.c                                           |    6 
 drivers/md/dm-switch.c                                          |    2 
 drivers/md/dm.c                                                 |    2 
 drivers/md/md.c                                                 |    7 
 drivers/md/persistent-data/dm-array.c                           |   16 
 drivers/md/raid5-ppl.c                                          |    4 
 drivers/media/cec/core/cec-adap.c                               |    8 
 drivers/media/cec/core/cec-pin.c                                |    8 
 drivers/media/cec/platform/meson/ao-cec-g12a.c                  |    1 
 drivers/media/cec/platform/stm32/stm32-cec.c                    |    3 
 drivers/media/dvb-frontends/rtl2832_sdr.c                       |   21 
 drivers/media/i2c/ov02a10.c                                     |   12 
 drivers/media/i2c/ov7740.c                                      |    4 
 drivers/media/i2c/video-i2c.c                                   |    8 
 drivers/media/pci/cobalt/cobalt-alsa-main.c                     |    1 
 drivers/media/pci/cx23885/cimax2.c                              |    1 
 drivers/media/platform/qcom/venus/hfi_parser.c                  |    9 
 drivers/media/rc/sunxi-cir.c                                    |    9 
 drivers/media/test-drivers/vicodec/vicodec-core.c               |    4 
 drivers/media/test-drivers/vimc/vimc-capture.c                  |    4 
 drivers/media/tuners/tda18250.c                                 |    4 
 drivers/media/usb/airspy/airspy.c                               |   17 
 drivers/media/usb/cx231xx/cx231xx-video.c                       |    4 
 drivers/media/usb/em28xx/em28xx-cards.c                         |    3 
 drivers/media/usb/em28xx/em28xx-core.c                          |    2 
 drivers/media/usb/go7007/snd-go7007.c                           |   10 
 drivers/media/usb/s2255/s2255drv.c                              |   11 
 drivers/media/usb/usbtv/usbtv-audio.c                           |   11 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                       |   49 -
 drivers/media/v4l2-core/v4l2-dev.c                              |   14 
 drivers/media/v4l2-core/v4l2-fwnode.c                           |    2 
 drivers/mfd/iqs62x.c                                            |    2 
 drivers/mfd/rave-sp.c                                           |   64 +
 drivers/misc/ad525x_dpot-i2c.c                                  |    4 
 drivers/misc/ad525x_dpot-spi.c                                  |    4 
 drivers/misc/ad525x_dpot.c                                      |  181 ++--
 drivers/misc/ad525x_dpot.h                                      |    5 
 drivers/misc/bcm-vk/bcm_vk_msg.c                                |    6 
 drivers/misc/cardreader/rtsx_pcr.c                              |    2 
 drivers/misc/cardreader/rtsx_usb.c                              |   23 
 drivers/misc/vmw_vmci/vmci_event.c                              |    4 
 drivers/mmc/host/via-sdmmc.c                                    |    8 
 drivers/mtd/mtdoops.c                                           |    3 
 drivers/mtd/mtdpart.c                                           |    3 
 drivers/mtd/mtdswap.c                                           |    1 
 drivers/mtd/nand/raw/nand_onfi.c                                |   27 
 drivers/mtd/parsers/afs.c                                       |    7 
 drivers/mtd/ubi/attach.c                                        |    4 
 drivers/mtd/ubi/build.c                                         |   63 +
 drivers/mtd/ubi/cdev.c                                          |    5 
 drivers/mtd/ubi/eba.c                                           |    5 
 drivers/mtd/ubi/fastmap-wl.c                                    |   53 +
 drivers/mtd/ubi/fastmap.c                                       |   76 --
 drivers/mtd/ubi/io.c                                            |   13 
 drivers/mtd/ubi/ubi.h                                           |   19 
 drivers/mtd/ubi/wl.c                                            |   38 -
 drivers/mtd/ubi/wl.h                                            |    6 
 drivers/net/bonding/bond_netlink.c                              |    2 
 drivers/net/ethernet/allwinner/sun4i-emac.c                     |    4 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c                |    3 
 drivers/net/ethernet/freescale/fec_main.c                       |    6 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c         |   12 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c          |    3 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c             |   11 
 drivers/net/ethernet/mellanox/mlx4/qp.c                         |   14 
 drivers/net/ethernet/nvidia/forcedeth.c                         |    6 
 drivers/net/ethernet/qlogic/qede/qede.h                         |    8 
 drivers/net/ethernet/qlogic/qede/qede_fp.c                      |    1 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c            |    1 
 drivers/net/ethernet/realtek/8139cp.c                           |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c            |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c               |    2 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c             |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c          |   41 -
 drivers/net/gtp.c                                               |    2 
 drivers/net/ipa/ipa_main.c                                      |   29 
 drivers/net/ipvlan/ipvlan_l3s.c                                 |    1 
 drivers/net/ntb_netdev.c                                        |   38 -
 drivers/net/ppp/pppox.c                                         |   17 
 drivers/net/slip/slip.c                                         |   11 
 drivers/net/thunderbolt.c                                       |    6 
 drivers/net/tun.c                                               |   21 
 drivers/net/usb/qmi_wwan.c                                      |    1 
 drivers/net/wireless/ath/ath10k/snoc.c                          |    9 
 drivers/net/wireless/ath/ath11k/debug.c                         |   12 
 drivers/net/wireless/ath/ath11k/debug.h                         |    3 
 drivers/net/wireless/ath/ath11k/dp_rx.c                         |   30 
 drivers/net/wireless/ath/ath11k/trace.c                         |    1 
 drivers/net/wireless/ath/ath11k/trace.h                         |  172 ++++
 drivers/net/wireless/ath/ath11k/wmi.c                           |   15 
 drivers/net/wireless/ath/ath6kl/cfg80211.c                      |    5 
 drivers/net/wireless/ath/ath6kl/wmi.c                           |   17 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c         |    3 
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c                |   12 
 drivers/net/wireless/mediatek/mt76/mt7615/main.c                |    5 
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                 |    8 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                 |    6 
 drivers/net/wireless/mediatek/mt76/sdio.c                       |   11 
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c              |    2 
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c              |    2 
 drivers/net/wireless/realtek/rtlwifi/pci.c                      |    6 
 drivers/net/wireless/realtek/rtw88/tx.c                         |    1 
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c                    |    8 
 drivers/nfc/pn533/pn533.c                                       |   21 
 drivers/ntb/ntb_transport.c                                     |   38 -
 drivers/nvdimm/btt.c                                            |    8 
 drivers/nvdimm/label.c                                          |   17 
 drivers/nvme/host/core.c                                        |    2 
 drivers/nvme/host/fc.c                                          |    8 
 drivers/nvme/host/tcp.c                                         |   45 +
 drivers/nvme/target/rdma.c                                      |  121 ++-
 drivers/nvme/target/tcp.c                                       |   10 
 drivers/nvme/target/zns.c                                       |    2 
 drivers/of/base.c                                               |    2 
 drivers/of/property.c                                           |   10 
 drivers/parisc/eisa.c                                           |    5 
 drivers/pci/controller/dwc/pci-meson.c                          |    2 
 drivers/pci/controller/pci-hyperv.c                             |    1 
 drivers/pci/pci-sysfs.c                                         |   45 +
 drivers/pci/proc.c                                              |    8 
 drivers/pci/quirks.c                                            |    2 
 drivers/perf/arm_spe_pmu.c                                      |    2 
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c                   |   26 
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c                |    2 
 drivers/pinctrl/bcm/pinctrl-bcm2835.c                           |    1 
 drivers/pinctrl/pinctrl-rockchip.c                              |   10 
 drivers/platform/chrome/cros_ec_sensorhub_ring.c                |   28 
 drivers/platform/mellanox/mlxbf-pmc.c                           |   10 
 drivers/platform/surface/surface_acpi_notify.c                  |    6 
 drivers/platform/x86/dell/dell-wmi-base.c                       |   17 
 drivers/platform/x86/dell/dell-wmi-privacy.c                    |    4 
 drivers/platform/x86/dell/dell-wmi-sysman/biosattr-interface.c  |    1 
 drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h     |    2 
 drivers/power/supply/bd99954-charger.h                          |   23 
 drivers/power/supply/bq24257_charger.c                          |   16 
 drivers/power/supply/bq256xx_charger.c                          |   29 
 drivers/power/supply/bq27xxx_battery.c                          |    6 
 drivers/power/supply/cros_usbpd-charger.c                       |   17 
 drivers/power/supply/isp1704_charger.c                          |    1 
 drivers/power/supply/lp8727_charger.c                           |    4 
 drivers/power/supply/max17040_battery.c                         |    2 
 drivers/power/supply/sbs-battery.c                              |    7 
 drivers/power/supply/sc2731_charger.c                           |    8 
 drivers/power/supply/twl4030_charger.c                          |   12 
 drivers/power/supply/ucs1002_power.c                            |    6 
 drivers/pps/clients/pps-gpio.c                                  |   62 -
 drivers/pps/pps.c                                               |   10 
 drivers/rapidio/devices/rio_mport_cdev.c                        |   10 
 drivers/rapidio/rio-scan.c                                      |    1 
 drivers/regulator/as3722-regulator.c                            |    1 
 drivers/regulator/core.c                                        |    6 
 drivers/regulator/max8998.c                                     |    1 
 drivers/regulator/qcom-rpmh-regulator.c                         |    6 
 drivers/remoteproc/mtk_scp.c                                    |    9 
 drivers/remoteproc/qcom_common.c                                |    4 
 drivers/remoteproc/remoteproc_core.c                            |  154 ++--
 drivers/remoteproc/remoteproc_sysfs.c                           |    1 
 drivers/rpmsg/qcom_glink_native.c                               |   34 
 drivers/rpmsg/qcom_glink_smem.c                                 |    7 
 drivers/rtc/rtc-pcf8563.c                                       |    4 
 drivers/s390/block/dasd.c                                       |    6 
 drivers/s390/block/dasd_eckd.c                                  |   40 +
 drivers/s390/block/dasd_erp.c                                   |    3 
 drivers/scsi/hosts.c                                            |   23 
 drivers/scsi/mpt3sas/mpt3sas_base.c                             |    2 
 drivers/scsi/pm8001/pm8001_init.c                               |    4 
 drivers/scsi/qla2xxx/qla_attr.c                                 |    7 
 drivers/scsi/qla2xxx/qla_bsg.c                                  |   39 -
 drivers/scsi/qla2xxx/qla_dbg.c                                  |    2 
 drivers/scsi/qla2xxx/qla_dfs.c                                  |    4 
 drivers/scsi/qla2xxx/qla_edif.c                                 |    3 
 drivers/scsi/qla2xxx/qla_gs.c                                   |    4 
 drivers/scsi/qla2xxx/qla_init.c                                 |   44 +
 drivers/scsi/qla2xxx/qla_inline.h                               |   13 
 drivers/scsi/qla2xxx/qla_isr.c                                  |   39 -
 drivers/scsi/qla2xxx/qla_mbx.c                                  |   26 
 drivers/scsi/qla2xxx/qla_nx2.c                                  |    2 
 drivers/scsi/qla2xxx/qla_os.c                                   |   14 
 drivers/scsi/scsi_lib.c                                         |    2 
 drivers/scsi/scsi_priv.h                                        |    4 
 drivers/scsi/scsi_sysfs.c                                       |   81 +-
 drivers/scsi/sd.c                                               |    4 
 drivers/scsi/smartpqi/smartpqi.h                                |   25 
 drivers/scsi/smartpqi/smartpqi_init.c                           |  123 ++-
 drivers/scsi/smartpqi/smartpqi_sis.c                            |   11 
 drivers/scsi/smartpqi/smartpqi_sis.h                            |    4 
 drivers/soc/bcm/bcm2835-power.c                                 |    7 
 drivers/soc/fsl/qe/qe_ic.c                                      |    3 
 drivers/soc/samsung/exynos-pmu.c                                |    4 
 drivers/soundwire/qcom.c                                        |    2 
 drivers/spi/spi-img-spfi.c                                      |    5 
 drivers/spi/spi-sprd-adi.c                                      |    6 
 drivers/staging/fbtft/fbtft-sysfs.c                             |    2 
 drivers/staging/greybus/audio_gb.c                              |   13 
 drivers/staging/greybus/audio_manager_sysfs.c                   |    2 
 drivers/staging/greybus/hid.c                                   |    2 
 drivers/staging/media/meson/vdec/vdec.c                         |    4 
 drivers/staging/media/sunxi/cedrus/cedrus.c                     |    4 
 drivers/staging/media/tegra-video/vi.c                          |    9 
 drivers/staging/octeon/ethernet-mem.c                           |   43 -
 drivers/staging/octeon/ethernet-mem.h                           |    8 
 drivers/staging/octeon/ethernet-rx.c                            |   53 -
 drivers/staging/octeon/ethernet-rx.h                            |   11 
 drivers/staging/octeon/ethernet-tx.c                            |    2 
 drivers/staging/octeon/ethernet.c                               |   43 -
 drivers/staging/octeon/octeon-ethernet.h                        |   14 
 drivers/staging/qlge/qlge_main.c                                |    4 
 drivers/staging/rtl8723bs/core/rtw_cmd.c                        |    8 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c                  |    7 
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c                    |    4 
 drivers/staging/sm750fb/sm750.c                                 |    4 
 drivers/target/iscsi/iscsi_target_login.c                       |    2 
 drivers/thermal/imx_thermal.c                                   |    9 
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c         |    9 
 drivers/thermal/qoriq_thermal.c                                 |   13 
 drivers/tty/hvc/Kconfig                                         |    2 
 drivers/tty/serial/amba-pl011.c                                 |   10 
 drivers/tty/tty_io.c                                            |    4 
 drivers/uio/uio.c                                               |    5 
 drivers/usb/atm/usbatm.c                                        |    4 
 drivers/usb/dwc2/gadget.c                                       |   11 
 drivers/usb/gadget/configfs.c                                   |    4 
 drivers/usb/gadget/function/f_fs.c                              |   14 
 drivers/usb/gadget/function/f_mass_storage.c                    |    2 
 drivers/usb/gadget/function/f_tcm.c                             |   23 
 drivers/usb/gadget/function/f_uac1_legacy.c                     |   56 -
 drivers/usb/gadget/function/f_uvc.c                             |    7 
 drivers/usb/gadget/function/u_audio.c                           |   24 
 drivers/usb/gadget/function/u_uac1_legacy.h                     |    3 
 drivers/usb/gadget/functions.c                                  |    2 
 drivers/usb/gadget/legacy/inode.c                               |    3 
 drivers/usb/gadget/udc/r8a66597-udc.c                           |    1 
 drivers/usb/gadget/udc/snps_udc_plat.c                          |    5 
 drivers/usb/host/xhci-ring.c                                    |   32 
 drivers/usb/image/mdc800.c                                      |    4 
 drivers/usb/mtu3/mtu3_core.c                                    |   11 
 drivers/usb/phy/phy-fsl-usb.c                                   |   52 -
 drivers/usb/phy/phy-fsl-usb.h                                   |    6 
 drivers/usb/renesas_usbhs/common.c                              |    6 
 drivers/usb/storage/ene_ub6250.c                                |    2 
 drivers/usb/typec/ucsi/displayport.c                            |    2 
 drivers/vdpa/mlx5/core/mr.c                                     |    2 
 drivers/vfio/pci/vfio_pci_config.c                              |    1 
 drivers/video/fbdev/kyro/fbdev.c                                |   24 
 drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c        |    4 
 drivers/video/fbdev/pvr2fb.c                                    |    4 
 drivers/video/fbdev/uvesafb.c                                   |    2 
 drivers/virtio/virtio_balloon.c                                 |    6 
 drivers/w1/masters/ds2482.c                                     |    4 
 drivers/w1/slaves/w1_ds28e17.c                                  |    8 
 drivers/xen/xenbus/xenbus_xs.c                                  |   16 
 fs/ceph/caps.c                                                  |   11 
 fs/ceph/mdsmap.c                                                |   11 
 fs/ceph/xattr.c                                                 |    1 
 fs/cifs/cifs_debug.c                                            |    2 
 fs/ecryptfs/crypto.c                                            |    2 
 fs/ecryptfs/ecryptfs_kernel.h                                   |    3 
 fs/ecryptfs/keystore.c                                          |   45 +
 fs/ecryptfs/messaging.c                                         |   11 
 fs/ecryptfs/miscdev.c                                           |    5 
 fs/ecryptfs/super.c                                             |    7 
 fs/ext4/file.c                                                  |    7 
 fs/ext4/inline.c                                                |   11 
 fs/ext4/inode.c                                                 |   10 
 fs/ext4/namei.c                                                 |    2 
 fs/ext4/orphan.c                                                |   10 
 fs/f2fs/file.c                                                  |   14 
 fs/f2fs/namei.c                                                 |   11 
 fs/fat/misc.c                                                   |    4 
 fs/fat/nfs.c                                                    |    4 
 fs/fuse/cuse.c                                                  |    5 
 fs/hfsplus/catalog.c                                            |   25 
 fs/hfsplus/hfsplus_fs.h                                         |    6 
 fs/hugetlbfs/inode.c                                            |    3 
 fs/isofs/compress.c                                             |   25 
 fs/ksmbd/smb2pdu.c                                              |   14 
 fs/ksmbd/smbacl.c                                               |   17 
 fs/lockd/svcsubs.c                                              |   55 -
 fs/nfs/client.c                                                 |   21 
 fs/nfs/filelayout/filelayoutdev.c                               |    3 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                       |    3 
 fs/nfs/inode.c                                                  |    4 
 fs/nfs/internal.h                                               |    1 
 fs/nfs/netns.h                                                  |    6 
 fs/nfs/nfs4client.c                                             |    1 
 fs/nfs/pnfs.c                                                   |   36 
 fs/nfs/pnfs.h                                                   |    3 
 fs/nfs/pnfs_nfs.c                                               |   39 -
 fs/nfsd/flexfilelayoutxdr.c                                     |   20 
 fs/nfsd/nfs2acl.c                                               |   31 
 fs/nfsd/nfs4proc.c                                              |   39 -
 fs/nfsd/nfs4state.c                                             |  202 ++++-
 fs/nfsd/nfs4xdr.c                                               |   17 
 fs/nfsd/nfscache.c                                              |    2 
 fs/nfsd/nfsfh.c                                                 |    4 
 fs/nfsd/nfsproc.c                                               |    7 
 fs/nfsd/nfssvc.c                                                |    4 
 fs/nfsd/nfsxdr.c                                                |   32 
 fs/nilfs2/bmap.c                                                |    2 
 fs/nilfs2/bmap.h                                                |    2 
 fs/nilfs2/btree.c                                               |   39 -
 fs/nilfs2/direct.c                                              |    4 
 fs/nilfs2/segment.c                                             |    4 
 fs/nilfs2/the_nilfs.c                                           |    6 
 fs/notify/fanotify/fanotify_user.c                              |   17 
 fs/notify/inotify/inotify_user.c                                |   15 
 fs/ntfs3/frecord.c                                              |    9 
 fs/ntfs3/fslog.c                                                |   47 +
 fs/ntfs3/fsntfs.c                                               |    8 
 fs/ntfs3/xattr.c                                                |   21 
 fs/ocfs2/acl.c                                                  |  135 ++-
 fs/ocfs2/acl.h                                                  |   19 
 fs/ocfs2/cluster/heartbeat.c                                    |  199 ++++-
 fs/ocfs2/cluster/heartbeat.h                                    |    7 
 fs/ocfs2/cluster/netdebug.c                                     |    2 
 fs/ocfs2/cluster/nodemanager.c                                  |   10 
 fs/ocfs2/cluster/nodemanager.h                                  |    1 
 fs/ocfs2/cluster/tcp.c                                          |   89 +-
 fs/ocfs2/cluster/tcp.h                                          |    1 
 fs/ocfs2/dir.c                                                  |    2 
 fs/ocfs2/dlm/dlmdomain.c                                        |    2 
 fs/ocfs2/dlm/dlmmaster.c                                        |    6 
 fs/ocfs2/dlm/dlmrecovery.c                                      |    9 
 fs/ocfs2/namei.c                                                |   17 
 fs/ocfs2/refcounttree.c                                         |   47 -
 fs/ocfs2/stack_o2cb.c                                           |    6 
 fs/ocfs2/xattr.c                                                |   91 +-
 fs/ocfs2/xattr.h                                                |    9 
 fs/orangefs/devorangefs-req.c                                   |    1 
 fs/orangefs/orangefs-debugfs.c                                  |    1 
 fs/squashfs/cache.c                                             |    2 
 fs/ubifs/auth.c                                                 |    2 
 fs/udf/inode.c                                                  |    2 
 fs/udf/partition.c                                              |    2 
 fs/udf/super.c                                                  |   23 
 fs/udf/symlink.c                                                |    2 
 include/linux/bitfield.h                                        |   95 ++
 include/linux/bpf.h                                             |    1 
 include/linux/efi.h                                             |    4 
 include/linux/hid.h                                             |    1 
 include/linux/irq.h                                             |   25 
 include/linux/irqdomain.h                                       |   23 
 include/linux/list.h                                            |   15 
 include/linux/mlx4/qp.h                                         |    1 
 include/linux/netdevice.h                                       |   50 -
 include/linux/nfs_xdr.h                                         |    2 
 include/linux/of_graph.h                                        |    4 
 include/linux/remoteproc.h                                      |  284 -------
 include/linux/rsc_table.h                                       |  364 ++++++++++
 include/linux/rtsx_usb.h                                        |    3 
 include/linux/sunrpc/svc_rdma_pcl.h                             |    2 
 include/linux/virtio_net.h                                      |    4 
 include/media/rc-map.h                                          |    2 
 include/net/inet_connection_sock.h                              |   12 
 include/net/ip_tunnels.h                                        |   11 
 include/net/pkt_cls.h                                           |    6 
 include/net/pkt_sched.h                                         |    1 
 include/net/sch_generic.h                                       |    1 
 include/net/sctp/structs.h                                      |    2 
 include/net/tcp.h                                               |   13 
 include/net/xfrm.h                                              |    1 
 include/rdma/ib_verbs.h                                         |   11 
 include/scsi/scsi_device.h                                      |    7 
 include/scsi/scsi_host.h                                        |   12 
 include/uapi/linux/time_types.h                                 |    2 
 include/uapi/mtd/ubi-user.h                                     |    8 
 kernel/auditfilter.c                                            |    6 
 kernel/bpf/cgroup.c                                             |    2 
 kernel/bpf/core.c                                               |    5 
 kernel/bpf/net_namespace.c                                      |   17 
 kernel/bpf/ringbuf.c                                            |    2 
 kernel/bpf/verifier.c                                           |   26 
 kernel/entry/common.c                                           |    3 
 kernel/irq/generic-chip.c                                       |   91 +-
 kernel/irq/irqdomain.c                                          |   57 +
 kernel/locking/lockdep.c                                        |    2 
 kernel/power/wakelock.c                                         |    2 
 kernel/sched/cpufreq_schedutil.c                                |   17 
 kernel/sched/fair.c                                             |   22 
 kernel/signal.c                                                 |    4 
 kernel/sys.c                                                    |    2 
 kernel/taskstats.c                                              |    3 
 kernel/time/clocksource.c                                       |    8 
 kernel/time/itimer.c                                            |    2 
 kernel/time/timekeeping.c                                       |    6 
 kernel/time/timer.c                                             |    1 
 kernel/trace/trace.c                                            |   28 
 kernel/trace/trace.h                                            |    4 
 kernel/trace/trace_events.c                                     |  134 +++
 kernel/trace/trace_mmiotrace.c                                  |   24 
 lib/string.c                                                    |    3 
 lib/test_hmm.c                                                  |    2 
 lib/ucs2_string.c                                               |    2 
 mm/damon/core-test.h                                            |    8 
 mm/damon/vaddr-test.h                                           |    5 
 mm/damon/vaddr.c                                                |   33 
 mm/memcontrol.c                                                 |    6 
 mm/vmscan.c                                                     |    2 
 net/ax25/ax25_dev.c                                             |    2 
 net/batman-adv/bridge_loop_avoidance.c                          |   78 +-
 net/batman-adv/distributed-arp-table.c                          |   66 +
 net/batman-adv/main.c                                           |    4 
 net/batman-adv/types.h                                          |    2 
 net/bluetooth/hci_event.c                                       |    7 
 net/bluetooth/l2cap_core.c                                      |    4 
 net/bluetooth/msft.c                                            |    5 
 net/bluetooth/rfcomm/core.c                                     |   12 
 net/bridge/br_mrp_netlink.c                                     |    4 
 net/bridge/br_netlink_tunnel.c                                  |    3 
 net/bridge/br_vlan.c                                            |    4 
 net/ceph/messenger_v2.c                                         |    5 
 net/ceph/osdmap.c                                               |    2 
 net/core/dev.c                                                  |    6 
 net/core/filter.c                                               |    6 
 net/core/lwt_bpf.c                                              |   15 
 net/core/skbuff.c                                               |   11 
 net/core/xdp.c                                                  |    4 
 net/dccp/dccp.h                                                 |    4 
 net/dccp/ipv4.c                                                 |    4 
 net/dccp/ipv6.c                                                 |    7 
 net/dccp/minisocks.c                                            |    2 
 net/hsr/hsr_device.c                                            |   14 
 net/hsr/hsr_framereg.c                                          |   63 -
 net/hsr/hsr_main.h                                              |    8 
 net/ipv4/esp4.c                                                 |   49 -
 net/ipv4/inet_connection_sock.c                                 |    9 
 net/ipv4/ip_tunnel.c                                            |    2 
 net/ipv4/syncookies.c                                           |    2 
 net/ipv4/tcp_fastopen.c                                         |    2 
 net/ipv4/tcp_ipv4.c                                             |    8 
 net/ipv4/tcp_minisocks.c                                        |    2 
 net/ipv4/tcp_output.c                                           |    2 
 net/ipv6/esp6.c                                                 |   49 -
 net/ipv6/ip6_gre.c                                              |   34 
 net/ipv6/ip6_tunnel.c                                           |   22 
 net/ipv6/route.c                                                |    2 
 net/ipv6/seg6_local.c                                           |    9 
 net/ipv6/sit.c                                                  |    2 
 net/ipv6/tcp_ipv6.c                                             |   98 +-
 net/ipv6/xfrm6_input.c                                          |    2 
 net/iucv/af_iucv.c                                              |    2 
 net/kcm/kcmsock.c                                               |    3 
 net/key/af_key.c                                                |   52 -
 net/mac80211/s1g.c                                              |    2 
 net/mac80211/tx.c                                               |    3 
 net/mpls/af_mpls.c                                              |    2 
 net/mptcp/subflow.c                                             |    6 
 net/mptcp/syncookies.c                                          |    1 
 net/netfilter/Kconfig                                           |    2 
 net/netfilter/ipvs/ip_vs_ftp.c                                  |   10 
 net/netfilter/nf_nat_sip.c                                      |    5 
 net/netfilter/nf_tables_api.c                                   |   14 
 net/netfilter/xt_cgroup.c                                       |   21 
 net/netfilter/xt_hl.c                                           |   27 
 net/nfc/digital_core.c                                          |    2 
 net/nfc/llcp_core.c                                             |   29 
 net/nfc/llcp_sock.c                                             |   14 
 net/nfc/nci/data.c                                              |   10 
 net/nfc/nci/rsp.c                                               |   41 +
 net/openvswitch/conntrack.c                                     |  130 ++-
 net/openvswitch/conntrack.h                                     |    6 
 net/openvswitch/datapath.c                                      |   58 -
 net/openvswitch/datapath.h                                      |   26 
 net/openvswitch/vport.h                                         |    8 
 net/phonet/pep.c                                                |    2 
 net/rds/cong.c                                                  |    4 
 net/sched/act_skbmod.c                                          |   12 
 net/sched/cls_api.c                                             |   30 
 net/sched/cls_flower.c                                          |    8 
 net/sched/cls_matchall.c                                        |    8 
 net/sched/sch_api.c                                             |    7 
 net/sched/sch_codel.c                                           |    2 
 net/sched/sch_fq.c                                              |   28 
 net/sched/sch_fq_codel.c                                        |    6 
 net/sched/sch_fq_pie.c                                          |    3 
 net/sched/sch_generic.c                                         |    9 
 net/sched/sch_hhf.c                                             |    4 
 net/sched/sch_htb.c                                             |    7 
 net/sched/sch_sfq.c                                             |    3 
 net/sched/sch_teql.c                                            |    1 
 net/sctp/inqueue.c                                              |    7 
 net/sctp/sm_sideeffect.c                                        |    4 
 net/sctp/stream.c                                               |   48 -
 net/smc/af_smc.c                                                |    6 
 net/smc/smc_core.c                                              |   14 
 net/smc/smc_llc.c                                               |    1 
 net/sunrpc/auth_gss/auth_gss.c                                  |    6 
 net/sunrpc/auth_gss/gss_krb5_wrap.c                             |   13 
 net/sunrpc/auth_gss/gss_rpc_upcall.c                            |    6 
 net/sunrpc/auth_gss/gss_rpc_upcall.h                            |    1 
 net/sunrpc/auth_gss/svcauth_gss.c                               |    3 
 net/sunrpc/cache.c                                              |    7 
 net/sunrpc/rpcb_clnt.c                                          |    4 
 net/sunrpc/sunrpc_syms.c                                        |    1 
 net/sunrpc/svc.c                                                |   29 
 net/sunrpc/xdr.c                                                |    2 
 net/sunrpc/xprtrdma/svc_rdma_rw.c                               |    9 
 net/vmw_vsock/af_vsock.c                                        |    6 
 net/vmw_vsock/virtio_transport.c                                |    2 
 net/xfrm/xfrm_state.c                                           |    3 
 scripts/tags.sh                                                 |    2 
 security/apparmor/lib.c                                         |   20 
 security/integrity/ima/ima_appraise.c                           |    2 
 security/selinux/include/security.h                             |    4 
 security/selinux/selinuxfs.c                                    |    7 
 security/selinux/ss/services.c                                  |   45 -
 security/smack/smack.h                                          |    5 
 security/smack/smack_lsm.c                                      |   95 +-
 security/smack/smackfs.c                                        |  218 +----
 sound/core/control.c                                            |   27 
 sound/core/control_compat.c                                     |   69 -
 sound/core/init.c                                               |    4 
 sound/core/pcm_native.c                                         |    2 
 sound/core/seq/seq_clientmgr.c                                  |    1 
 sound/drivers/aloop.c                                           |  105 +-
 sound/drivers/mpu401/mpu401.c                                   |    6 
 sound/drivers/mts64.c                                           |    6 
 sound/drivers/portman2x4.c                                      |    6 
 sound/drivers/serial-u16550.c                                   |    6 
 sound/drivers/virmidi.c                                         |    6 
 sound/parisc/harmony.c                                          |    6 
 sound/pci/asihpi/hpi6000.c                                      |    5 
 sound/pci/hda/hda_proc.c                                        |    2 
 sound/pci/pcxhr/pcxhr.c                                         |   14 
 sound/pci/via82xx_modem.c                                       |   26 
 sound/soc/codecs/cs35l33.c                                      |   14 
 sound/soc/codecs/cs35l34.c                                      |   14 
 sound/soc/codecs/rt700-sdw.c                                    |    6 
 sound/soc/fsl/fsl-asoc-card.c                                   |    4 
 sound/soc/fsl/mpc5200_psc_i2s.c                                 |    1 
 sound/soc/intel/atom/sst/sst_pci.c                              |    4 
 sound/soc/meson/meson-card-utils.c                              |   17 
 sound/soc/pxa/pxa-ssp.c                                         |    7 
 sound/soc/samsung/aries_wm8994.c                                |    1 
 sound/soc/soc-dapm.c                                            |    2 
 sound/soc/xilinx/xlnx_formatter_pcm.c                           |   14 
 sound/usb/6fire/comm.c                                          |    9 
 sound/usb/bcd2000/bcd2000.c                                     |   11 
 sound/usb/midi.c                                                |    2 
 tools/bpf/bpftool/btf.c                                         |   11 
 tools/bpf/bpftool/gen.c                                         |   12 
 tools/bpf/bpftool/iter.c                                        |    7 
 tools/bpf/bpftool/map.c                                         |   51 -
 tools/bpf/bpftool/map_perf_ring.c                               |    9 
 tools/bpf/bpftool/struct_ops.c                                  |   14 
 tools/include/linux/compiler.h                                  |    2 
 tools/perf/builtin-sched.c                                      |   40 -
 tools/perf/builtin-stat.c                                       |   15 
 tools/perf/tests/shell/stat_bpf_counters.sh                     |  101 ++
 tools/perf/ui/browsers/hists.c                                  |    6 
 tools/perf/util/auxtrace.c                                      |   15 
 tools/perf/util/cs-etm.c                                        |   81 +-
 tools/perf/util/dso.c                                           |   19 
 tools/perf/util/intel-bts.c                                     |    2 
 tools/perf/util/intel-pt.c                                      |    2 
 tools/perf/util/machine.c                                       |   34 
 tools/perf/util/synthetic-events.c                              |    6 
 tools/perf/util/thread-stack.c                                  |    2 
 tools/perf/util/trace-event-read.c                              |   33 
 tools/testing/selftests/arm64/mte/check_buffer_fill.c           |    2 
 tools/testing/selftests/arm64/mte/check_child_memory.c          |    2 
 tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c       |    1 
 tools/testing/selftests/arm64/mte/check_hugetlb_options.c       |  298 ++++++++
 tools/testing/selftests/arm64/mte/check_ksm_options.c           |   31 
 tools/testing/selftests/arm64/mte/check_mmap_options.c          |    2 
 tools/testing/selftests/arm64/mte/check_tags_inclusion.c        |    2 
 tools/testing/selftests/arm64/mte/check_user_mem.c              |    2 
 tools/testing/selftests/bpf/README.rst                          |   32 
 tools/testing/selftests/bpf/test_sockmap.c                      |    3 
 tools/testing/selftests/bpf/vmtest.sh                           |  111 ++-
 tools/testing/selftests/rseq/rseq-x86-thread-pointer.h          |    4 
 tools/testing/selftests/timers/leap-a-day.c                     |   19 
 tools/testing/selftests/zram/zram_lib.sh                        |    2 
 807 files changed, 9045 insertions(+), 4483 deletions(-)

Abdun Nihaal (4):
      wifi: brcmfmac: Fix memory leak in brcmf_sdio_read_control()
      wifi: rtw88: Fix potential memory leak in rtw_txq_push_skb()
      wifi: rtlwifi: pci: fix error path in rtl_pci_probe()
      misc: vmc_vmci: Fix potential memory leak in vmci_event_subscribe()

Abdurrahman Hussain (1):
      of: fix out-of-bounds read in of_alias_scan() stem parser

Abel Vesa (1):
      clk: qcom: Drop mmcx gdsc supply for dispcc and videocc

Ada Couprie Diaz (1):
      arm64: hibernate: mask DAIF before restoring hibernated kernel

Adrian Hunter (5):
      i3c: master: Fix info leak and UAF in device unregister path
      i3c: master: Fix device_register() error path
      i3c: mipi-i3c-hci: Quieten initialization messages
      i3c: mipi-i3c-hci: Switch PIO data allocation to devm_kzalloc()
      i3c: mipi-i3c-hci: Refactor PIO register initialization

Aharon Landau (1):
      RDMA/nldev: Split nldev_stat_set_mode_doit out of nldev_stat_set_doit

Ahmad Byagowi (1):
      i2c: mux: Fix channel node leak on adapter add failure

Ahmet Sezgin Duran (1):
      staging: sm750fb: gate dualview dataflow using g_dualview

Ai Chao (1):
      HID: i2c-hid: Fix "(null)" output when reading report descriptor fails

Akari Tsuyukusa (1):
      iommu/mediatek-v1: Fix off-by-one in MT2701_LARB_NR_MAX

Alban Bedel (1):
      software node: Fix software_node_get_reference_args() with index -1

Aleksandr Khromov (1):
      slip: fix use-after-free in sl_sync()

Aleksandr Nogikh (3):
      udf: Mark LVID buffer as uptodate before marking it dirty
      ALSA: core: Fix use-after-free in snd_card_do_free()
      libceph: validate banner payload length

Alex Elder (1):
      net: ipa: report when the driver has been removed

Alexander A. Klimov (2):
      clk: moxart: remove unused variables, fix refcount leak
      staging: greybus: audio: correct sscanf() return value check

Alexandra Winter (1):
      net/iucv: filter frames in afiucv_hs_rcv() by ingress device

Ali Ahmet Memis (2):
      openrisc: fix arbitrary kernel memory access via or1k_atomic syscall
      Bluetooth: MSFT: validate evt_prefix_len against the response length

Alice Mikityanska (1):
      virtio-net: Ensure that TCP packets don't overflow gso_segs

Allison Henderson (1):
      net/rds: use wq_has_sleeper() in rds_cong_map_updated()

Andre Przywara (1):
      ARM: dts: allwinner: a10: Fix PMU interrupt

Andreas Kemnade (1):
      drm/omap: dsi: Do not copy isr table

Andrei Matei (1):
      bpf: Guard stack limits against 32bit overflow

Andrii Nakryiko (1):
      bpftool: Update btf_dump__new() and perf_buffer__new_raw() calls

Andy Shevchenko (1):
      usb: f_mass_storage: Bump local buffer size in fsg_common_create_luns()

Aneesh Kumar K.V (Arm) (1):
      iommu/dma: Check atomic pool allocation result directly

Arash Golgol (1):
      media: vimc: fix pixel format lookup in enum_framesizes

Armin Wolf (2):
      platform/x86: dell-privacy: Fix race condition
      platform/x86: dell-wmi-base: Fix resource leak on module load failure

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

Athira Rajeev (1):
      perf tests stat_bpf_counters: Fix usage of '==' to address shellcheck warning

Ayush Mukkanwar (4):
      staging: octeon: add missing tasklet_kill in cvm_oct_tx_shutdown
      staging: octeon: ethernet-mem: replace pr_warn with dev_warn in free functions
      staging: octeon: replace pr_warn with dev_warn in fill and rx paths
      staging: octeon: add missing napi_disable in cvm_oct_rx_shutdown

Babanpreet Singh (3):
      power: supply: sbs-battery: Use a per-device serial number buffer
      w1: ds2482: Fix signedness bug in ds2482_w1_triplet()
      spi: sprd-adi: Fix probe succeeding without registering the controller

Baochen Qiang (1):
      wifi: ath11k: cap out-of-range rx MCS instead of leaving bogus rate

Baokun Li (2):
      ext4: drain in-flight DIO before buffered write fallback
      cuse: wait for pending RCU callbacks on module exit

Baowen Zheng (1):
      flow_offload: rename offload functions with offload instead of flow

Bart Van Assche (3):
      scsi: core: Register sysfs attributes earlier
      scsi: smartpqi: Switch to attribute groups
      scsi: smartpqi: Stop using the SCSI pointer

Bartosz Golaszewski (1):
      powerpc/powermac: fix OF node refcount

Bastien Curutchet (1):
      pps: clients: gpio: Bypass edge's direction check when not needed

Baul Lee (2):
      ALSA: 6fire: bound the MIDI event length from the device
      ALSA: bcd2000: clear the URB pointers on disconnect

Bijan Tabatabai (1):
      x86/pkeys: Fix pkey_alloc() return value when pkeys are not supported

Biju Das (1):
      usb: renesas_usbhs: Fix power-off ordering on unbind

Biren Pandya (3):
      media: i2c: ov02a10: fix endpoint parsing use-after-free
      media: i2c: ov7740: fix use-after-destroy in remove
      media: v4l2-fwnode: Fix fwnode leak in v4l2_fwnode_parse_link

Bjoern Doebel (1):
      RDMA/rxe: Fix TOCTOU heap overflow in get_srq_wqe

Bjorn Andersson (2):
      remoteproc: Prevent crash handling to race with rproc_del()
      clk: qcom: gdsc: Bump parent usage count when GDSC is found enabled

Bradley Morgan (5):
      signal: avoid shared siginfo namespace rewrites
      taskstats: fix cpumask parsing cutting off the last character
      ima: Check for ERR_PTR from dentry_path() in validate_hash_algo()
      lib/string: fix memchr_inv() for large ranges
      prctl: fix PR_SET_MM_AUXV losing the forced AT_NULL terminator

Breno Leitao (5):
      mm/vmscan: report RCU-tasks quiescent states in shrink_lruvec()
      efi: fix stale reference to efi_recover_from_page_fault()
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

Bryan O'Donoghue (3):
      clk: qcom: gdsc: Release pm subdomains in reverse add order
      clk: qcom: gdsc: Capture pm_genpd_add_subdomain result code
      arm64: dts: qcom: sm8250: Add camcc DT node

Calvin Owens (2):
      pps: don't try to wait for negative timeouts in PPS_FETCH
      pps-gpio: remove dead capture_clear code

Can Peng (4):
      thermal/drivers/imx: Disable clock on runtime resume failure
      thermal/drivers/qoriq: Disable clock on resume failure
      drm/tve200: add OF module alias for autoloading
      crypto: keembay - publish OF module alias for OCS AES/SM4

Carlos López (1):
      KVM: x86: hyper-v: Clamp stimer deadline to avoid livelock

Casey Schaufler (1):
      Smack: fix W=1 build warnings

Catalin Marinas (2):
      kselftest/arm64: mte: Skip the hugetlb tests if MTE not supported on such mappings
      kselftest/arm64: mte: Use the correct naming for tag check modes in check_hugetlb_options.c

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

Chris Mason (8):
      nfsd: fix cpntf publish race in nfs4_init_cp_state
      SUNRPC: xdr_buf_trim: clamp buf->len to avoid underflow
      SUNRPC: Guard svcauth_gss_release() dispatch on rq_auth_stat
      SUNRPC: harden gss_krb5_unwrap_v2 against short tokens
      SUNRPC: harden gss_unwrap_resp_priv length checks
      sunrpc: init gssp_lock before publishing proc entry
      svcrdma: Fix offset arithmetic in read_chunk_range
      svcrdma: Fix pcl_for_each_segment for empty chunks

Christian Borntraeger (6):
      KVM: s390: Fix length check __import_wp_info()
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

Daisuke Matsuda (1):
      fpga: altera-cvp: Avoid out-of-bounds read in trailing byte write

Damien Le Moal (1):
      block: flag zoned disks with GENHD_FL_NO_PART

Dan Carpenter (4):
      staging: fbtft: Use sysfs_emit_at() to print to sysfs file
      cpufreq: spear: Fix an IS_ERR() vs NULL bug in spear1340_set_cpu_rate()
      scsi: qla2xxx: Fix an loop timeout test
      HID: fix an error code in hid_check_device_match()

Daniel Borkmann (2):
      bpf: Enforce expected_attach_type for tailcall compatibility
      bpf: Fix vmlinux BTF prep race in bpf_get_btf_vmlinux

Daniel McCarthy (1):
      pinctrl: bcm2835: Don't remove an unregistered GPIO chip

Daniel Xu (1):
      selftests/bpf: Fix vmtest.sh getopts optstring

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

David Strahan (1):
      scsi: smartpqi: Fix AIO retry marker cleared by SCSI core between dispatches.

David Woodhouse (1):
      timekeeping: Account for monotonicity adjustment in ntp_error

Dawei Feng (2):
      media: cedrus: fix memory leak in cedrus_init_ctrls()
      staging: rtl8723bs: fix mismatched free of HalData in rtw_sdio_if1_init()

Deepanshu Kartikey (2):
      drm/gud: NUL-terminate TV mode names read from the device
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
      arm64: dts: qcom: sm8250: remove mmcx regulator

Dmitry Torokhov (3):
      Input: aiptek - switch to using dev_groups for driver-specific attributes
      HID: split apart hid_device_probe to make logic more apparent
      HID: ensure timely release of driver-allocated resources

Doruk Tan Ozturk (2):
      wifi: ath6kl: clamp assoc request/response lengths before subtracting IE offsets
      nfc: llcp: bound SNL TLV parsing to the skb and add length checks

Duoming Zhou (1):
      ax25: fix use-after-free bugs caused by ax25_ds_del_timer

Eason Lai (1):
      wifi: mt76: mt792x: Fix memory leak in SDIO TX path

Eric Dumazet (5):
      tcp: fix potential race in tcp_v6_syn_recv_sock()
      net/sched: act_skbmod: fix length calculations and avoid invalid header warnings
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

Fabio M. De Francesco (1):
      fs/isofs: replace kmap() with kmap_local_page()

Fabio Porcedda (1):
      net: usb: qmi_wwan: add Telit Cinterion FE990D50 composition

Faith Ekstrand (1):
      drm/nouveau: Use write-combined maps for coherent

Fan Wu (8):
      RDMA/cxgb4: Cancel reg_work before freeing device on remove
      power: supply: bq24257: fix use-after-free on remove
      power: supply: bq256xx: drain usb_work before freeing the charger
      power: supply: lp8727: fix use-after-free in lp8727_release_irq()
      power: supply: ucs1002: fix use-after-free on remove
      mmc: via-sdmmc: stop card-detect handling on probe failure
      media: cx23885: cancel NetUP CI work before teardown
      RDMA/cxgb4: Free debugfs on registration failure

Fan Ye (1):
      net: thunderbolt: Count delivered packets in rx_packets and rx_bytes

Fei Shao (1):
      usb: mtu3: allow system suspend during active gadget connection

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

Francesco Lavra (1):
      usb: dwc2: gadget: Exit partial power down state when changing USB pull-up

Frank Sorenson (1):
      cifs: fix clearing stats for fastest execution of each smb2 command

Fu Hao (1):
      iommu/amd: Add support for Hygon family 18h model 4h IOAPIC

Geert Uytterhoeven (2):
      bitfield: Add less-checking __FIELD_{GET,PREP}()
      bitfield: Add non-constant field_{prep,get}() helpers

Gerald Loacker (1):
      phy: rockchip: phy-rockchip-inno-csidphy: fix rk1808 hsfreq table

Giorgi Tchankvetadze (1):
      iio: light: cm32181: return zero after writing calibscale

Giovanni Cabiddu (1):
      crypto: qat - clear AES key schedule from stack

Gleb Markov (1):
      misc: rtsx: add missing write register handling

Gongwei Li (1):
      Bluetooth: hci_uart: Fix false success return in hci_uart_setup()

Gou Hao (1):
      powerpc/smp: add NULL guard for cause_ipi in smp_muxed_ipi_message_pass

Greg Kroah-Hartman (2):
      driver core: soc: remove layering violation for the soc_bus
      Linux 5.15.221

Griffin Kroah-Hartman (1):
      usb: image: mdc800: change kmalloc() to kzalloc()

Guanghui Yang (1):
      ext4: fix buffer_head leak in ext4_init_orphan_info

Guangshuo Li (7):
      Bluetooth: hci_bcm: fix usage_count leak when autosuspend_delay is negative
      Bluetooth: hci_h5: fix usage_count leak when autosuspend_delay is negative
      Bluetooth: hci_intel: fix usage_count leak when autosuspend_delay is negative
      clk: tegra: tegra124-emc: put EMC node on register failure
      rapidio: clear mport->net when rio_add_net() fails
      dmaengine: qcom-bam-dma: fix autosuspend cleanup during removal
      clocksource/drivers/clps711x: Do not unmap clocksource MMIO

Gui-Dong Han (2):
      media: cec-pin: Fix event FIFO ordering
      misc: bcm-vk: Use acquire/release for msgq_inited

Guixin Liu (3):
      nvmet-rdma: use sbitmap to replace rsp free list
      nvme-fc: unmap cmd_iu DMA on rsp_iu mapping failure in init_request
      nvmet: fix NULL pointer dereference in nvmet_execute_identify_ns_zns()

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

Hannes Reinecke (1):
      nvmet-rdma: avoid circular locking dependency on install_queue()

Hans Verkuil (1):
      Revert "media: v4l2-dev: fix error handling in __video_register_device()"

Hans de Goede (1):
      HID: i2c-hid: Switch i2c_hid_parse() to goto style error handling

Hao-Qun Huang (3):
      staging: greybus: hid: fix SET_REPORT return value
      staging: media: tegra-video: vi: fix probe failure on skipped last port
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

Harry Wentland (1):
      drm/amd/display: avoid divide-by-zero in __is_lut_linear()

Harshit Varu (1):
      mptcp: fix uninitialized local_id in syncookie MP_JOIN reconstruction

Helge Deller (1):
      parisc: Fix alignment of asm statements in head.S

Hengqi Chen (1):
      bpftool: Use libbpf_get_error() to check error

Henrik Grimler (4):
      drm/lima: call drm_mm_init() with a valid allocation range
      power: supply: bq27xxx: bq27520g4: fix REG_TTES address
      power: supply: bq27xxx: bq28z610: fix invalid AverageEnergy address
      power: supply: bq27xxx: bq27z561: fix invalid AverageEnergy address

Herman van Hazendonk (3):
      clk: qcom: gdsc: propagate gdsc_check_status() errors from gdsc_poll_status
      clk: qcom: gdsc: propagate gdsc_enable() failure for ALWAYS_ON domains
      clk: qcom: gdsc: tear down per-domain genpds in gdsc_unregister()

Herve Codina (4):
      irqdomain: Introduce irq_domain_free()
      irqdomain: Introduce irq_domain_instantiate()
      irqdomain: Handle additional domain flags in irq_domain_instantiate()
      genirq/generic_chip: Introduce irq_domain_{alloc,remove}_generic_chips()

Hidayath Khan (1):
      net/smc: fix socket refcount leak in smc_switch_conns()

Hisam Mehboob (1):
      selftests/rseq: Replace glibc-specific __GNUC_PREREQ with portable check

Hongyan Xu (4):
      auxdisplay: charlcd: cancel backlight work on registration failure
      usb: gadget: r8a66597: avoid double free of ep0_req in probe error path
      power: supply: isp1704_charger: cancel work on remove
      power: supply: sc2731_charger: cancel work on remove

Hui Su (2):
      tracing: Fix crash passing ERR_PTR to kthread_stop()
      cpufreq: schedutil: Fix rate limit overflow

HyeongJun An (6):
      platform/x86: dell-wmi-sysman: Don't hex dump attribute security buffer
      ALSA: usb-audio: fix OOB write in snd_usbmidi_us122l_output()
      media: s2255: bound JPEG frame size before copying into the buffer
      Bluetooth: virtio_bt: avoid OOB read of build info string
      platform/x86: dell-wmi-sysman: Fix instance ID bounds
      ASoC: dapm: Fix off-by-one check on the second enum channel

Hyunwoo Kim (3):
      sctp: stop processing a packet once its association is deleted
      sctp: drop a chunk if its transport was removed
      Bluetooth: RFCOMM: Validate MTU in rfcomm_apply_pn() to prevent infinite loop

Ian Rogers (6):
      perf test bpf-counters: Add test for BPF event modifier
      perf tests: Fix flakiness in BPF counters test on hybrid systems
      perf ui hists: Fix uninitialized stack memory free on pstack allocation failure
      perf stat: Fix evsel_list leak in cmd_stat
      perf synthetic-events: Fix uninitialized pthread_join
      perf synthetic-events: Fix divide by zero in perf_event__synthesize_threads

Ibrahim Hashimov (4):
      ubifs: fix out-of-bounds read in signature length check
      HID: picolcd: clamp eeprom debugfs read to bytes actually received
      ocfs2: validate rl_used against rl_count in refcount block validator
      HID: wacom: validate report length in wacom_intuos_pro2_bt_irq

Ilya Krutskih (2):
      dm raid1: reserve space for NUL-terminator in build_constructor_string()
      media: tda18250: fix possible integer overflow

Ilya Leoshkevich (1):
      selfetests/bpf: Adapt vmtest.sh to s390 libbpf CI changes

Ilya Maximets (2):
      net: openvswitch: fix flow mask use-after-free on flow deletion
      net: openvswitch: fix kernel-doc warnings in internal headers

Israel Téllez García (1):
      bpf: Fix pending_pos walk on 32-bit ring position wrap

Ivaylo Dimitrov (1):
      hsi: omap_ssi_core: fix missing DMA mask setup for SSI controller device

Ivy Lopez (1):
      staging: rtl8723bs: use kfree_sensitive() for key material

Jakub Kicinski (3):
      netdev: reshuffle netif_napi_add() APIs to allow dropping weight
      staging: switch to netif_napi_add_weight()
      i3c: dw: avoid shift-out-of-bounds when DAA assigns no devices

Jamal Hadi Salim (7):
      net/sched: fq_codel: clamp default quantum and mtu
      net/sched: sch_codel: clamp default mtu to avoid disabling CoDel
      net/sched: fq_pie: clamp default quantum to avoid signed overflow
      net/sched: hhf: clamp quantum before hhf_change() to avoid overflow
      net/sched: sfq: clamp quantum to avoid signed overflow soft lockup
      net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup
      net/sched: sch_htb: limit htb_classify inner-class filter hops

James Clark (5):
      coresight: etm4x: Cleanup TRCIDR2 register accesses
      coresight: etm4x: Cleanup TRCIDR3 register accesses
      coresight: etm4x: Cleanup TRCIDR4 register accesses
      coresight: etm4x: Cleanup TRCIDR5 register accesses
      coresight: Change syncfreq to be a u8

James Kim (1):
      rapidio: mport_cdev: fix use-after-free in dma_req_free()

Jameson Thies (2):
      power: supply: cros_usbpd: Limit port counts to EC_USB_PD_MAX_PORTS
      usb: typec: ucsi: displayport: Fix OOB altmode array index

Jan Kara (1):
      ext4: fix spurious message about orphan cleanup on RO fs

Jann Horn (1):
      smack: fix cred UAF in smack_file_send_sigiotask()

Jarkko Nikula (2):
      i3c: mipi-i3c-hci: Fix DAT/DCT entry sizes
      i3c: mipi-i3c-hci: Fix number of DAT/DCT entries for HCI versions < 1.1

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

Jian-Ming Liao (1):
      i3c: mipi-i3c-hci: Fix missing STAT_IBI_STATUS_THLD in PIO mode

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

Jie Wang (1):
      net: hns3: fix kernel crash when 1588 is sent on HIP08 devices

Jilin Yuan (1):
      ubi: Fix repeated words in comments

Jingyi Wang (1):
      remoteproc: core: Attach rproc asynchronously in rproc_add() path via schedule_work()

Jinjie Ruan (1):
      entry: Fix seccomp bypass after ptrace with TSYNC

Jiri Olsa (1):
      bpftool: Fix pretty print dump for maps without BTF loaded

Joas Antonio dos Santos (1):
      ipvs: fix integer overflow in ftp helper port/address parsing

Johan Hovold (3):
      USB: phy: fsl-usb: fix missing static keywords
      remoteproc: scp: Fix device reference leak on failed lookup
      drm/bridge: dw-hdmi: fix i2c adapter leak on probe failure

John Johansen (1):
      apparmor: policy_int make sure list heads are initialized before fail path

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

Jun Yan (1):
      arm64: dts: amlogic: meson-axg-s400: enable mipi_pcie_analog_dphy for PCIe

Jun Yang (2):
      sctp: distinguish sequence zero from wildcard in reconf lookup
      sctp: fix stream->outcnt underflow on duplicate RECONF responses

Junrui Luo (4):
      media: vicodec: fix out-of-bounds write in FWHT encoder
      NFSv4.1: fix layout segment leak on the pnfs_layout_process() forget path
      NFSv4.2: fix LAYOUTSTATS send buffer exhaustion
      NFSv4/pnfs: key the data server cache on the NFS version

Junseo Lim (3):
      lwt_bpf: Restore reserved headroom after xmit program
      bpf: Reject negative optlen in cgroup getsockopt hook
      net: kcm: Hold RCU read lock while running BPF parser

Jérémy Jean (4):
      timers/itimer: Zero-init old itimerval before copy to userspace
      libceph: reject buckets with mismatched CRUSH ids
      ceph: reject export_targets ranks >= CEPH_MAX_MDS in mdsmap decode
      audit: avoid dropping live tree ref on fsnotify rule autoremove

KP Singh (1):
      bpf/docs: Update list of architectures supported.

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

Kavan Smith (1):
      drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value

Kemeng Shi (2):
      irqchip/gic-v3-its: Fix memleak in its_probe_one()
      irqchip/gic-v3-its: Prevent leak in its_vpe_irq_domain_alloc()

Kevin Tian (1):
      iommu/vt-d: Fix no_iommu to disable platform opt-in

Kiryl Shutsemau (Meta) (1):
      x86/insn-eval: Move assign_register() out of KVM as insn_assign_reg()

Koichiro Den (11):
      NTB: ntb_transport: Recycle TX entries before client callbacks
      NTB: ntb_transport: Fail TX enqueue when the QP link is down
      NTB: ntb_transport: Reject oversized TX buffers
      net: ntb_netdev: Avoid double-accounting netif_rx() drops
      net: ntb_netdev: Count packets dropped on RX refill failure
      net: ntb_netdev: Fix TX busy and drop handling
      dmaengine: dw-edma: Complete descriptors before pausing
      dmaengine: dw-edma: Initialize IRQ data before requesting IRQs
      dmaengine: dw-edma: Serialize abort state updates
      dmaengine: dw-edma: Serialize channel state checks
      dmaengine: dw-edma: Clear stale requests on termination

Konrad Dybcio (1):
      drm/msm/dsi: Drop dev_pm_opp_set_rate(0)

Konstantin Andreev (3):
      smack: fix incorrect task context in smack_msg_queue_msgrcv
      smack: deduplicate smackfs/{direct,mapped} file_operations
      smack: restrict smackfs/{direct,mapped} values to 0-255

Konstantin Komarov (2):
      fs/ntfs3: bound page_lcns[] index by the log record
      fs/ntfs3: fix out-of-bounds read in read_log_rec_buf()

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

Lei Huang (1):
      media: s2255: check firmware size before reading trailing marker

Leo Yan (3):
      perf cs-etm: Flush thread stacks after decoder reset
      perf cs-etm: Avoid truncating AUX buffer sizes to int
      perf: arm_spe: Make wakeup range check overflow safe

Leon Romanovsky (14):
      RDMA/core: Wait for RCU callbacks before unloading ib_core
      RDMA/mlx5: Drain RCU callbacks during module teardown
      RDMA/ipoib: Drain RCU callbacks during module teardown
      RDMA/hfi1: Preserve unit 0 on allocation failure
      RDMA/hfi1: Free RX data on late probe failure
      RDMA/hfi1: Remove redundant PCI device ID validation
      RDMA/hfi1: Create workqueues before device initialization
      RDMA/hfi1: Stop flushing the global IB workqueue
      RDMA/hfi1: Initialize debugfs after probe completes
      RDMA/srpt: Pass the mapped task attribute to target_init_cmd()
      RDMA/mlx5: Fix stack out-of-bounds read in cc_params debugfs
      RDMA/mlx5: Send cong param changes to the resolved port mdev
      RDMA/cxgb4: free STAG index when TPT entry write fails
      RDMA/nldev: Check stat attribute before accessing it

Li RongQing (1):
      vdpa/mlx5: fix wrong list iterated in add_direct_chain error path

LiangCheng Wang (1):
      ASoC: fsl-asoc-card: defer probe when the CPU DAI device is not ready

Linghui Wu (1):
      wifi: ath10k: snoc: use memcpy_fromio() for MSA ramdump

Linkai Gong (2):
      i2c: mux: demux-pinctrl: fix OF node leak on kstrdup failure
      soc: fsl: qe: check platform_driver_register() in qe_ic_of_init()

Linmao Li (8):
      iio: chemical: sgp30: Handle IAQ thread creation failure
      platform/mellanox: mlxbf-pmc: Check ACPI_COMPANION() against NULL
      platform/surface: acpi-notify: Check ACPI companion before use
      ppdev: prevent overflow when setting port timeout
      ASoC: meson: Keep link pointers valid on realloc failure
      crypto: keembay - Initialize completion before requesting IRQ
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

Manivannan Sadhasivam (1):
      bus: mhi: host: Flush the posted write after writing to MHI_SOC_RESET_REQ_OFFSET

Maoyi Xie (4):
      power: supply: twl4030_charger: cancel workers via devm
      i3c: master: svc: bound IBI payload to the requested max_payload_len
      w1: ds28e17: reject an oversize length on an I2C block read
      drm/bridge: tc358767: clamp the reported AUX read size to the request

Marek Czernohous (2):
      forcedeth: fix off-by-one when saving/restoring non-PCI config space
      forcedeth: stop the tx_timeout register dump past the requested window

Marino Dzalto (1):
      netfilter: xt_HL: add pr_fmt and checkentry validation

Mark Zhang (2):
      RDMA/mlx: Calling qp event handler in workqueue context
      RDMA/core: Add driver APIs pre_destroy_cq() and post_destroy_cq()

Martin Blumenstingl (1):
      clk: meson: align gxbb_32k_clk_sel number of parents with actual count

Martin Kaiser (1):
      hwrng: ks-sa - access private data via struct hwrng

Masami Hiramatsu (Google) (2):
      tracing/mmiotrace: Add NULL check for mmio_trace_array in logging functions
      tracing: Remove "__attribute__()" from the type field of event format

Matt Turner (4):
      alpha: fix ieee_swcr_to_fpcr setting FPCR_DNOD unconditionally
      alpha: don't leak hardware-fabricated FP exception bits to user space
      alpha: marvel: Fix irq_set_status_flags to use correct IRQ number
      alpha: marvel: Fix lock ordering in init_io7_irqs()

Matti Vaittinen (1):
      power: supply: bd99954: Drop bad register fields

Maxime Chevallier (6):
      net: stmmac: selftests: Pass the IP proto mask in the TC selftest
      net: stmmac: selftests: Check multiple MMC counters
      net: stmmac: dwmac1000: Account for the primary MAC address for UC filtering
      net: stmmac: dwmac4: Account for the primary MAC address for UC filtering
      net: stmmac: dwxgmac: Account for the primary MAC address for UC filtering
      net: stmmac: selftests: Account for the UC filter list for filtering tests

Maxime Ripard (1):
      drm/bridge: cdns-mhdp8546: Return an error pointer on allocation failure

Mert Seftali (1):
      iio: accel: dmard09: Implement IIO_CHAN_INFO_SCALE

Miaoqian Lin (1):
      iommu/arm-smmu: Add missing pm_runtime_disable() in qcom_iommu_device_probe

Michael Bommarito (6):
      NFSD: restart ssc_expire_umount walk after dropping nfsd_ssc_lock
      ceph: bound num_export_targets array for mds info v2/v3
      ceph: bound xattr value length in __build_xattrs()
      lockd: pin next file across nlm_inspect_file lock-drop
      HID: roccat: bound device-supplied profile index
      usb: gadget: configfs: fix out-of-bounds read of qw_sign

Michael Byczkowski (1):
      pps: pps-gpio: split IRQ handler into hardirq timestamper + threaded handler

Michael S. Tsirkin (1):
      virtio_balloon: disable indirect descriptors

Michael Walle (1):
      powerpc/configs: enable CONFIG_RAS to fix EDAC support

Michal Koutný (1):
      netfilter: xt_cgroup: Make it independent from net_cls

Mike McGowen (1):
      scsi: smartpqi: Fix BUILD_BUG_ON() statements

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

Ming Qian (1):
      media: v4l2-ctrls: Allow unknown HDR10 white point and luminance

Mohamad Raizudeen (1):
      PCI: Fix 32-bit config write in Intel PCH Root Port MPC ACS quirk

Mohammed EL Kadiri (2):
      media: venus: fix payload size returned by parse_caps() and parse_alloc_mode()
      media: venus: fix payload size calculation in parse_raw_formats()

Moksh Panicker (1):
      iio: chemical: atlas-sensor: fix PM reference leak in buffer postenable

Muhammad Bilal (2):
      staging: rtl8723bs: fix OOB read / stack overflow in rtw_get_wps_attr()
      staging: rtl8723bs: fix OOB read in rtw_action_frame_parse()

Muhammad Usama Anjum (2):
      selftests/arm64: Print missing MTE TAP headers
      selftests/arm64: Treat KSM merge_across_nodes as optional

Mukesh Ojha (6):
      iommu/qcom: Fix inverted fault report check in qcom_iommu_fault()
      remoteproc: Use unbounded workqueue for recovery work
      remoteproc: Move resource table data structure to its own header
      remoteproc: use rsc_table_for_each_entry() in rproc_handle_resources()
      remoteproc: fix OOB read via signed offset in rsc_table_for_each_entry()
      firmware_loader: do not queue completed sysfs fallback requests

Murthy Bhat (1):
      scsi: smartpqi: Capture controller reason codes

Myeonghun Pak (6):
      usb: gadget: snps_udc_plat: clean up PHY on probe deferral
      fbdev: uvesafb: unregister connector callback on init failure
      tpm: tpm_i2c_nuvoton: disable IRQ on wait timeout
      media: rc: sunxi-cir: Unregister rc device on probe failure
      char: xilinx_hwicap: unregister class on init errors
      clk: palmas: Manage external-control prepare with devm

Naman Jain (1):
      PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip

Namhyung Kim (2):
      perf test: Fix perf stat --bpf-counters on hybrid machines
      perf stat: Clear screen only if output file is a tty

Nathan Chancellor (1):
      arch_numa: avoid false positive fortify warning in setup_node_to_cpumask_map()

Naveen Kumar Chaudhary (1):
      locking/lockdep: Fix NULL pointer dereference in __lock_set_class()

Naveen Mamindlapalli (1):
      octeontx2-af: Fix TL3/TL2 link config ENA clearing

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

Nilesh Javali (22):
      scsi: qla2xxx: Zero SFP DMA buffer in FRU/I2C bsg handlers
      scsi: qla2xxx: Bound i2c->length in I2C bsg handlers
      scsi: qla2xxx: edif: Fix NULL pointer deref in RX SA delete check
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
      scsi: qla2xxx: Reject non-SCSI SRB on status IOCB fast path
      scsi: qla2xxx: Fix response queue over-consumption in __qla_consume_iocb()
      scsi: qla2xxx: Avoid double completion in async IOCB timeout
      scsi: qla2xxx: Bound rsp_info_len to avoid OOB sense-data read
      scsi: qla2xxx: Avoid req_q_map double-read in qla2x00_error_entry()
      scsi: qla2xxx: Drop vport reference under lock in report ID acquisition
      scsi: qla2xxx: Use coherent DMA buffer for D_Port diagnostics
      scsi: qla2xxx: Zero-init bsg stack buffers to avoid info leak

Norbert Szetei (5):
      RDMA/ucma: Lock the handler in ucma_set_ib_path()
      openvswitch: only skb_tx_error() a packet we are about to drop
      net: skbuff: don't touch shared zerocopy state in skb_tx_error()
      net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
      ksmbd: fix overflow in dacloffset bounds check

Ondrej Jirman (1):
      arm64: dts: allwinner: sun50i-a64-pinephone: Fix mpu6050 mount matrix

Pablo Neira Ayuso (2):
      netfilter: nf_tables: move hardware offload step after building the chain blob
      netfilter: x_tables: replace pr_{info,err}() by pr_info_ratelimited()

Patrisious Haddad (1):
      RDMA/core: Fix potential use after free in ib_free_cq()

Pavel Zhigulin (1):
      speakup: keyhelp: guard letter_offsets possible out-of-range indexing

Pei Xiao (1):
      parisc: eisa: Fix infinite loop when parsing invalid IRQ value

Pengpeng Hou (11):
      eCryptfs: bound the packet-length peek to the user buffer
      Input: aiptek - validate raw macro indices before updating state
      mtd: afs: validate v2 image info bounds
      mtd: rawnand: validate ONFI extended parameter page sections
      crypto: sa2ul - stop probe if context pool creation fails
      pmdomain: bcm: bcm2835: handle genpd provider registration errors
      misc: ad525x_dpot: use driver core groups for sysfs files
      ACPI: processor: validate MADT IOAPIC entry bounds
      thermal: intel: int3400: clean up ODVP on probe failures
      mfd: rave-sp: validate received frame payload lengths
      mfd: iqs62x: Reject zero-length firmware records

Peter Oberparleiter (1):
      s390/debug: Fix deadlock during unregister

Petr Vaganov (1):
      scsi: core: Fill in DMA padding bytes in scsi_alloc_sgtables()

Philipp Weber (1):
      HID: core: quiesce input in hid_hw_stop() to prevent use-after-free

Phillip Lougher (1):
      Squashfs: check block offset is not negative

Pranjal Shrivastava (1):
      iommu/arm-smmu-v3: Convert to use atomic poll timeout

Pu Lehui (4):
      bpf: Fix potential UAF in bpf_netns_link_update_prog
      selftests/bpf: Limit URLS parsing logic to actual scope in vmtest
      selftests/bpf: Support local rootfs image for vmtest
      selftests/bpf: Add description for running vmtest on RV64

Qing Ming (1):
      mpls: reload header after pskb_may_pull()

Qingfang Deng (1):
      pppox: drain queued packets on channel handoff

Rafael J. Wysocki (3):
      cpufreq: intel_pstate: Fix setting minimum P-state at init time
      ACPI: processor: idle: Expand _LPI package sanity checks
      thermal: int340x_thermal: Consolidate priv->data_vault checks

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

Runyu Xiao (8):
      fbdev: omapfb: panel-dsi-cm: initialize lock before registering display
      ALSA: pcxhr: initialize mutexes before requesting threaded IRQ
      wifi: mt76: mt7615: avoid waiting for mac work under the mt76 mutex
      scsi: pm8001: Use rollback index when freeing MSI-X vectors
      ALSA: harmony: initialize locks before requesting IRQ
      ASoC: cs35l33: drain threaded IRQ before runtime suspend
      ASoC: cs35l34: drain threaded IRQ before runtime suspend
      ASoC: rt700-sdw: always drain jack work on remove

Ruoyu Wang (10):
      net: openvswitch: fix nf_connlabels leak in ovs_ct_init
      media: cec: Serialize exclusive follower delivery
      media: cobalt: Avoid freeing ALSA private data twice
      mtd: mtdswap: Avoid freeing registered blktrans device twice
      NFSv4: remove callback IDR entry on client allocation failure
      bonding: initialize err for empty target lists
      net: bridge: Reject descending VLAN tunnel ranges
      net: ipa: balance runtime PM reference on remove error
      tpm: st33zp24: Return zero on status read failure
      tpm: st33zp24: Validate locality read result

Russ Weight (1):
      firmware_loader: Check fw_state_is_done in loading_store

Ryusuke Konishi (1):
      nilfs2: fix slab-out-of-bounds in nilfs_direct_propagate after truncation

SJ Park (4):
      mm/damon/core-kunit: check region count before testing in split_at()
      mm/damon/vaddr: drop last same folio access check optimization
      mm/damon/vaddr-kunit: check region count in three_regions test
      mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()

Sabrina Dubroca (1):
      espintcp: remove encap socket caching to avoid reference leak

Sajal Gupta (1):
      md/raid5-ppl: fix use-after-free in ppl_do_flush()

Samuel Page (1):
      fs/ntfs3: fix info-leak on partial LZNT decompress in ni_read_frame()

Sang-Heon Jeon (2):
      iio: light: isl29028: return zero in write_raw() on success
      iio: light: tsl2583: return zero in write_raw() on success

Sanjay Chitroda (2):
      iio: temperature: hid-sensor-temperature: switch to non-devm iio_device_register()
      iio: orientation: hid-sensor-rotation: Avoid race between callback setup and device exposure

Sean Rhodes (1):
      misc: rtsx_usb: avoid USB I/O in runtime autosuspend

Sean Shen (1):
      ksmbd: fix FSCTL permission bypass by adding a permission check for FSCTL_SET_SPARSE

Sean Young (2):
      media: keymaps: Remove obsolete RC_MAP_RC5_TV keymap define
      media: keymaps: Remove obsolete RC_MAP_HAUPPAUGE_NEW keymap define

Sebastian Andrzej Siewior (1):
      hsr: Use a single struct for self_node.

Sechang Lim (1):
      tcp: clear sock_ops cb flags before force-closing a child socket

Seiji Nishikawa (1):
      ipmi: si: Fix NULL pointer dereference after failed registration

Sergei Litvin (1):
      scripts/tags.sh: Prevent binary files appearing in cscope.files

Serhat Kumral (1):
      RDMA/ucma: Allow path records to exactly fit the output buffer

Shin'ichiro Kawasaki (2):
      nvmet-rdma: factor out response resource cleanup
      nvmet-rdma: fix response resource leak on queue teardown

Shivam Kumar (2):
      nvmet-tcp: fix out-of-bounds write when receiving an over-long PDU
      nvmet-tcp: reject unsolicited H2CData PDUs

Shuangpeng Bai (3):
      media: usbtv: keep device alive while ALSA card exists
      media: go7007: defer the ALSA v4l2 put until card release
      RDMA/siw: Fix use-after-free in siw_accept()

Sibi Sankar (1):
      arm64: dts: qcom: sm8250: Use QMP property to control load state

Simon Glass (1):
      pinctrl: rockchip: Reset the pin count when recalculating SoC data

Slawomir Stepien (1):
      wifi: zd1211rw: reject secondary interfaces to prevent conflicts

Sonali Pradhan (1):
      usb: gadget: u_audio: Fix use-after-free on sound card disconnect

Srinivas Kandagatla (2):
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

Stephan Gerhold (8):
      clk: qcom: gcc-mdm9607: Increase delay for USB PHY reset
      clk: qcom: gcc-msm8916: Fix enable_reg for gcc_blsp1_sleep_clk
      clk: qcom: gcc-msm8939: Fix enable_reg for gcc_blsp1_sleep_clk
      clk: qcom: gcc-mdm9607: Drop incorrect apss_tcu_clk_src
      clk: qcom: gcc-mdm9607: Drop incorrect system_noc_bfdcd_clk_src
      clk: qcom: gcc-mdm9607: Fix enable_reg for gcc_blsp1_sleep_clk
      clk: qcom: gcc-mdm9607: Fix halt_reg for gcc_apss_axi_clk
      clk: qcom: gcc-mdm9607: Drop incorrect BIMC PLL and related clocks

Steve Wahl (1):
      x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

Steven Rostedt (2):
      tracing/mmiotrace: Remove reference to unused per CPU data pointer
      tracing: Have trace_event_update_all() only handle module that is loading

Sujal Tuladhar (1):
      scsi: target: iscsi: Reserve a terminator byte for the login payload

Sunil Khatri (1):
      drm/amdgpu: use AMDGPU_GPU_PAGE_SHIFT instead of PAGE_SHIFT

Suraj Gupta (1):
      dmaengine: xilinx_dma: Fix channel idle state management in AXIDMA and MCDMA interrupt handlers

Sven Eckelmann (5):
      batman-adv: dat: avoid unaligned fault in IP extraction
      batman-adv: bla: fix freeing of claims on meshif deletion
      batman-adv: bla: prevent CRC corruptions after claim flush
      batman-adv: dat: atomically update mac addresses
      batman-adv: bla: avoid CRC corruption due to parallel claim add

Takashi Iwai (10):
      ALSA: aloop: Fix racy access at PCM trigger
      ALSA: aloop: Check card index validity at probe
      ALSA: mpu401: Check card index validity at probe
      ALSA: mts64: Check card index validity at probe
      ALSA: portman2x4: Check card index validity at probe
      ALSA: serial-u16550: Check card index validity at probe
      ALSA: virmidi: Check card index validity at probe
      ALSA: pcm: Fix race between non-atomic ops and trigger-start
      ALSA: control: Use automatic cleanup of kfree()
      ALSA: control: Fix unannotated kfree() cleanup

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

Tao Yu (1):
      drm/gud: validate TV mode names before creating enum property

Tengda Wu (1):
      perf test: Use sqrtloop workload to test bperf event

Tetsuo Handa (2):
      RDMA/core: Avoid flush_workqueue(system_unbound_wq) usage
      RDMA/mlx4: Avoid flush_scheduled_work() usage

Thadeu Lima de Souza Cascardo (1):
      drm: Fix drm_crtc_commit leak if signaled when PAGE_FLIP_EVENT is used

Thomas Bogendoerfer (1):
      MIPS: ptrace: Fix syscall skipping via PTRACE_SYSCALL

Thomas Gleixner (1):
      timer: Keep debugobjects state consistent in migrate_timer_list()

Thomas Richter (1):
      perf test: raise limit to 20 percent for perf_stat_--bpf-counters_test

Thomas Weißschuh (1):
      y2038: uapi: Use 64-bit __kernel_old_timespec::tv_nsec on x32

Thomas Zimmermann (1):
      drm/hibmc: Fix list of formats on the primary plane

Thorsten Blum (5):
      crypto: atmel-ecc - replace min_t with min
      crypto: atmel-ecc - clean up and improve ECDH comments
      crypto: atmel-ecc - reject hardware ECDH without a public key
      crypto: sl3516 - drop invalid sg_dma_len checks before DMA mapping
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

Tzung-Bi Shih (3):
      platform/chrome: sensorhub: Fix dropped timestamp events and log spam
      ALSA: seq: Fix port lock leak in deliver_to_subscribers()
      platform/chrome: sensorhub: Fix memory overread in ring handler

Uday Khare (2):
      media: video-i2c: fix kthread error pointer left in kthread_vid_cap on failure
      remoteproc: qcom: Fix glink->node reference leak in qcom_add_glink_subdev

Uwe Kleine-König (3):
      misc: ad525x_dpot: Make ad_dpot_remove() return void
      power: supply: sc2731_charger: Convert to platform remove callback returning void
      net: ipa: Convert to platform remove callback returning void

Vaibhav Nagare (1):
      qede: Fix NULL pointer dereference in TPA fragment processing

Valentin Kindschi (1):
      Bluetooth: hci_event: clear HCI_LE_ADV only on a created connection

Valery Borovsky (3):
      media: airspy: use vb2_video_unregister_device() on disconnect to fix NULL deref
      media: rtl2832_sdr: use vb2_video_unregister_device() on remove to fix DMA leak
      media: rtl2832_sdr: release URBs and stream buffers on start_streaming() failure

Vasileios Almpanis (1):
      i2c: core: fix debugfs UAF on adapter removal

Venkateswara Naralasetty (1):
      ath11k: add trace log support

Veronika Molnarova (1):
      perf test stat_bpf_counter.sh: Stabilize the test results

Victor Nogueira (2):
      net/sched: cls_api: fix teardown of an adopted proto on insert-race loss
      net/sched: sch_teql: restore skb->dev on the slave failure path

Vincent Mailhol (1):
      lib/ucs2_string.c: fix out-of-bounds read in ucs2_strnlen()

Vineet Gupta (1):
      selftests/bpf: vmtest.sh: Preserve command quoting when running in the VM

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

Weigang He (4):
      media: cec: stm32: prevent out-of-bounds write on RX overflow
      soc: samsung: exynos-pmu: fix of_node refcount leak in exynos_get_pmu_regmap()
      ARM: imx: fix device_node refcount leak in imx_src_init()
      ARM: imx: fix device_node refcount leaks in imx7_src_init()

Weiming Shi (5):
      sctp: fix NULL deref on untransmitted RECONF completion
      xdp: fix zero-copy frame layout
      fs/ntfs3: reject restart table growth beyond U16_MAX entries
      SUNRPC: check rpc_sockaddr2uaddr() return value in rpcb_register_inet4/6
      fs/ntfs3: validate ef->size covers the record's name and value

Weiming Wu (1):
      fs/ntfs3: fix out-of-bounds read of INDEX_ROOT in reparse/objid init

WenTao Liang (3):
      regulator: as3722_get_regulator_dt_data: fix premature of_node_put leaving dangling of_node pointer
      regulator: max8998_pmic_dt_parse_pdata: of_node_put on reg_np after ownership transferred to rdata
      ASoC: samsung: aries_audio_probe: double of_node_put due to direct assignment without of_node_get

Wenjie Qi (2):
      f2fs: return symlink writeback errors
      f2fs: return writeback error from collapse range

Wentao Liang (2):
      drm/sun4i: fix refcount leak in sun4i_backend_init_sat()
      nvme: target: rdma: fix ndev refcount leak on queue connect

Wolfram Sang (2):
      hwspinlock: propagate errno when registering single lock
      ACPI: move from strlcpy() with unused retval to strscpy()

Xiang Mei (8):
      fs/ntfs3: validate dirty page table on log replay
      bridge: mrp: reject zero test interval to avoid OOM panic
      xfrm6: fix out-of-bounds write in xfrm6_input_addr() when secpath is full
      isofs: fix out-of-bounds page array access on empty zisofs block
      vfio/pci: clear vdev->msi_perm after freeing it on init failure
      ext4: fix out-of-bounds read in ext4_read_inline_dir()
      ext4: check dir entry fits before reading the hash trailer in ext4_search_dir()
      net: qualcomm: rmnet: restore skb->dev on deaggregated frames

Xie Yuanbin (1):
      ARM: 9485/1: mm: acquire mmap write lock around show_pte() for user faults

Xingrui Li (1):
      HID: sensor-hub: Fix out-of-bounds write in sensor_hub_get_feature

Xiubo Li (1):
      ceph: fix UAF in __kick_flushing_caps() on cf entry freed during unlock

Xixin Liu (1):
      nvmet-rdma: fix queue leak when connect backlog is exceeded

Xu Rao (3):
      HID: roccat: free buffered reports when destroying device
      mtd: mtdoops: free page bitmap when the backing MTD is removed
      ALSA: hda: Fix connection list comparison in proc output

Xu Yang (1):
      usb: gadget: f_uac1_legacy: remove broken string configfs attributes

Yang Li (1):
      ubi: Simplify bool conversion

Yang Shi (1):
      selftests: arm64: add hugetlb mte tests

Yang Xiuwei (1):
      scsi: sd: Fix sd_done() sense handling condition

Yehyeong Lee (9):
      nvme: zero the discard fallback page
      nvme-tcp: do not accept C2HData based on blk_rq_payload_bytes() alone
      nvme-tcp: reject a read that transferred too few bytes
      nvme-tcp: check the data direction of a C2HData PDU
      IB/isert: reject PDUs declaring more data than was received
      IB/isert: reject login PDUs declaring more data than was received
      RDMA/srp: fix heap information leak on a truncated SRP_CRED_REQ
      IB/isert: delay the final Login Response until the session is registered
      IB/isert: post the full-feature receive buffers after session registration

Yemu Lu (1):
      fat: restore original value when fat_ent_write failed

Yeoreum Yun (2):
      coresight: etm4x: fix wrong check of etm4x_sspcicrn_present()
      coresight: etm4x: fix underflow for usage of (nrseqstate - 1)

Yi Ding (2):
      media: cec: meson: ao-cec-g12a: name the CEC core regmap to avoid debugfs clash
      rtc: pcf8563: fix clock provider leak on unbind

Yichong Chen (11):
      ecryptfs: fix tag 11 packet exact-fit size check
      ecryptfs: hold msg ctx list lock when cleaning daemon queue
      ecryptfs: pass packet set buffer size to parser
      ecryptfs: reject too-small tag 70 packets
      ecryptfs: release message context on send failure
      ecryptfs: show filename encryption options
      tools/bpf/bpftool: Reset vmlinux BTF after map commands
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

Yosry Ahmed (2):
      KVM: nVMX: Always flush vpid02 on first use
      KVM: nVMX: Service local TLB flushes on failed nested VM-Enter

Youngjae Kwon (1):
      fsnotify: Fix stale object mask after concurrent mark updates

Yousef Alhouseen (2):
      ipmi: ipmb: validate write message length
      HID: synchronize input before cleaning up a failed probe

Yuan Chen (1):
      bpftool: Fix double close in map dump

Yuanshen Cao (1):
      iio: light: tsl2772: fix ALS calibscale readback

Yucong Sun (1):
      selfetests/bpf: Update vmtest.sh defaults

Yuho Choi (8):
      bus: ti-sysc: Fix /chosen node reference leak
      clocksource: Unregister subsystem on device registration failure
      hwrng: ks-sa - Fix runtime PM cleanup on registration failure
      uio: Fix stale info pointer in failed registration path
      driver core: soc: Unregister bus on early device registration failure
      ubi: Fix rollback for explicit UBI device numbers
      xenbus: Unregister reboot notifier on init failure
      clocksource/drivers/armada: Unwind timer clock on init failure

Yun Zhou (3):
      usb: gadget: f_tcm: fix deadlock in usbg_make_tpg()
      ext4: skip extra isize expansion during mount to prevent deadlock
      nfc: nci: fix use of uninitialized memory in CORE_INIT_RSP parsing

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

ZhangGuoDong (1):
      smb/server: preserve error status in smb2_handle_negotiate()

Zhao Li (2):
      wifi: mac80211: send TWT teardown to peer after setup TX failure
      wifi: mac80211: skip unused probe response countdown offsets

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

Zhushuai Yin (1):
      crypto: hisilicon/sec2 - fix CCM algorithm long packet failure

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

