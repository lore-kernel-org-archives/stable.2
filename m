Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BCA41B8D6;
	Sat,  3 Oct 2026 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791024559; cv=none; b=DUgr9sAP9L0ibC+nFLdeXE/Cr4rY6kc60j1jxSKVa7x8IuXbHkJfVSPi17wDjrU/qn4bBGyTP8jz7umoGlxKHlccfky7IjDW69DlHCRYseC4wLt5741aRmha6BaEWo7dJaURiOkH4WCioSXSRpMu5yoDUYrJECOaS+Z/BmJtf1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791024559; c=relaxed/simple;
	bh=ry06eVHN8+sLxJh1IuZQQskURZqDmvnFZhkzv608PKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FTwxX9XwhptyrPdus/BeUHSpPXtd9XXfd7X+LBNTbHA8Aa65t2BbTAy5GoIRrM3ZDgxjZHouejZVyFaMtNIsjcUesGjAQUmYXz7dp5GFft/ZbXO1VF8IxnnAqRZ/FfPWKyf/PK7/hlEAkmh3pviabdfKCY9B282df8gekfx3wi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eB5t7Nn9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eB5t7Nn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168FC1F0089C;
	Sat,  3 Oct 2026 10:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791024555;
	bh=pfcaTWX1rr+kZA/PjspYX+J1+TcDQOqxBG1wr+nWSBI=;
	h=From:To:Cc:Subject:Date;
	b=eB5t7Nn9Eqe9IZ8Gk9Zxp98C505gHLegR5rrxzw/VcLfbw4UtamuUxgPmg13AN+ia
	 OAQcpW0/tV75hkppw9QuJvFcwwwEaUpWaeOv40Bp05Ro0asEo6074XjIdBMCiyzKKa
	 kNvBCoCvR1bCnFUaKJkELXEAmNwFQ8y10xmPDvMg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.222
Date: Sat,  3 Oct 2026 12:49:06 +0200
Message-ID: <2026100307-liability-pranker-6a12@gregkh>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.222 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-platform-trackpoint            |    2 
 Documentation/driver-api/serial/tty.rst                                |    2 
 Documentation/networking/ip-sysctl.rst                                 |    2 
 Documentation/s390/pci.rst                                             |  152 +-
 Documentation/s390/vfio-ccw.rst                                        |    2 
 Documentation/virt/kvm/mmu.rst                                         |    8 
 Makefile                                                               |    2 
 arch/alpha/include/uapi/asm/fpu.h                                      |    8 
 arch/alpha/kernel/traps.c                                              |    6 
 arch/alpha/math-emu/math.c                                             |   88 -
 arch/arm/mach-socfpga/Kconfig                                          |    2 
 arch/arm/mm/alignment.c                                                |    4 
 arch/arm/mm/fault.c                                                    |   82 +
 arch/arm64/include/asm/daifflags.h                                     |   10 
 arch/arm64/include/asm/fixmap.h                                        |    6 
 arch/arm64/include/asm/kprobes.h                                       |    6 
 arch/arm64/include/asm/percpu.h                                        |   16 
 arch/arm64/kernel/probes/kprobes.c                                     |   23 
 arch/mips/cavium-octeon/octeon-platform.c                              |    4 
 arch/mips/kernel/cps-vec.S                                             |    6 
 arch/powerpc/kernel/eeh_driver.c                                       |    2 
 arch/powerpc/kernel/iommu.c                                            |    2 
 arch/powerpc/kexec/file_load_64.c                                      |    2 
 arch/powerpc/kvm/book3s_hv.c                                           |    4 
 arch/powerpc/kvm/book3s_hv_uvmem.c                                     |    5 
 arch/powerpc/platforms/pseries/kexec.c                                 |   13 
 arch/s390/crypto/aes_s390.c                                            |   16 
 arch/s390/include/asm/debug.h                                          |    8 
 arch/s390/kernel/debug.c                                               |   15 
 arch/sparc/Kconfig                                                     |    1 
 arch/sparc/kernel/uprobes.c                                            |    1 
 arch/x86/include/asm/kvm_host.h                                        |   32 
 arch/x86/kvm/mmu/mmu.c                                                 |  187 ++-
 arch/x86/kvm/mmu/mmutrace.h                                            |    2 
 arch/x86/kvm/mmu/paging_tmpl.h                                         |   32 
 arch/x86/kvm/mmu/spte.h                                                |    5 
 arch/x86/kvm/mmu/tdp_mmu.c                                             |    2 
 arch/x86/mm/tlb.c                                                      |   16 
 arch/x86/pci/fixup.c                                                   |   99 +
 block/blk-cgroup.c                                                     |    4 
 crypto/Makefile                                                        |    5 
 drivers/acpi/acpica/dsmethod.c                                         |   43 
 drivers/acpi/acpica/evhandler.c                                        |   11 
 drivers/acpi/acpica/exoparg3.c                                         |    2 
 drivers/acpi/acpica/nsnames.c                                          |    6 
 drivers/acpi/acpica/nsprepkg.c                                         |    7 
 drivers/acpi/acpica/nsxfname.c                                         |    4 
 drivers/acpi/acpica/psargs.c                                           |  134 ++
 drivers/acpi/acpica/psloop.c                                           |   30 
 drivers/acpi/acpica/psparse.c                                          |   14 
 drivers/acpi/acpica/utcopy.c                                           |   10 
 drivers/acpi/acpica/utresrc.c                                          |   30 
 drivers/acpi/pci_root.c                                                |    4 
 drivers/ata/ahci.c                                                     |   22 
 drivers/ata/libahci.c                                                  |   15 
 drivers/ata/libata-pmp.c                                               |    7 
 drivers/block/sunvdc.c                                                 |   26 
 drivers/bluetooth/btmtksdio.c                                          |    4 
 drivers/bluetooth/btusb.c                                              |   23 
 drivers/bluetooth/hci_mrvl.c                                           |    3 
 drivers/bus/fsl-mc/fsl-mc-bus.c                                        |   46 
 drivers/char/ipmi/ipmi_si_platform.c                                   |    5 
 drivers/char/nvram.c                                                   |   16 
 drivers/char/virtio_console.c                                          |   22 
 drivers/clk/at91/pmc.h                                                 |    2 
 drivers/clk/clk-scpi.c                                                 |    2 
 drivers/clk/keystone/sci-clk.c                                         |    8 
 drivers/clk/renesas/renesas-cpg-mssr.c                                 |    3 
 drivers/clk/socfpga/clk-agilex.c                                       |    2 
 drivers/cpufreq/cpufreq.c                                              |    6 
 drivers/crypto/allwinner/Kconfig                                       |   16 
 drivers/crypto/allwinner/sun8i-ce/Makefile                             |    1 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c                      |   54 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c                      |  162 --
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h                           |   29 
 drivers/crypto/allwinner/sun8i-ss/Makefile                             |    1 
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c                      |   39 
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c                      |  172 ---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h                           |   23 
 drivers/crypto/atmel-ecc.c                                             |    3 
 drivers/crypto/ixp4xx_crypto.c                                         |   25 
 drivers/dma/dmaengine.c                                                |   10 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                         |   11 
 drivers/dma/mmp_pdma.c                                                 |    2 
 drivers/dma/sprd-dma.c                                                 |    3 
 drivers/dma/sun6i-dma.c                                                |    9 
 drivers/dma/ti/k3-udma-glue.c                                          |    5 
 drivers/dma/xilinx/xilinx_dma.c                                        |   26 
 drivers/edac/edac_device_sysfs.c                                       |   11 
 drivers/edac/igen6_edac.c                                              |   27 
 drivers/firmware/arm_scmi/base.c                                       |   15 
 drivers/firmware/arm_scmi/sensors.c                                    |   10 
 drivers/firmware/arm_scpi.c                                            |    4 
 drivers/gpio/gpio-arizona.c                                            |    8 
 drivers/gpio/gpio-dwapb.c                                              |   17 
 drivers/gpio/gpio-pisosr.c                                             |    4 
 drivers/gpio/gpio-zynq.c                                               |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                 |    3 
 drivers/gpu/drm/amd/amdgpu/atom.c                                      |    9 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                      |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c                  |    7 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c              |   20 
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c                              |   31 
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c                        |    6 
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c                        |   14 
 drivers/gpu/drm/arm/malidp_drv.c                                       |   22 
 drivers/gpu/drm/drm_atomic_uapi.c                                      |   13 
 drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c                             |   21 
 drivers/gpu/drm/gud/gud_drv.c                                          |    1 
 drivers/gpu/drm/gud/gud_pipe.c                                         |    4 
 drivers/gpu/drm/i915/i915_query.c                                      |    4 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                                |    2 
 drivers/gpu/drm/msm/dsi/dsi.h                                          |    1 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                     |   38 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c                                  |    4 
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                                    |    8 
 drivers/gpu/drm/nouveau/nouveau_bo.c                                   |    3 
 drivers/gpu/drm/nouveau/nouveau_drm.c                                  |    5 
 drivers/gpu/drm/nouveau/nouveau_gem.c                                  |    2 
 drivers/gpu/drm/nouveau/nvif/vmm.c                                     |    1 
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c                         |   23 
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c                       |    2 
 drivers/gpu/drm/panel/panel-simple.c                                   |   28 
 drivers/gpu/drm/virtio/virtgpu_display.c                               |    2 
 drivers/gpu/drm/virtio/virtgpu_gem.c                                   |    2 
 drivers/gpu/drm/virtio/virtgpu_ioctl.c                                 |    6 
 drivers/gpu/drm/virtio/virtgpu_vram.c                                  |   17 
 drivers/gpu/host1x/bus.c                                               |    4 
 drivers/hid/amd-sfh-hid/amd_sfh_common.h                               |   63 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c                                 |   10 
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h                                 |   42 
 drivers/hid/hid-alps.c                                                 |    6 
 drivers/hid/hid-hyperv.c                                               |   58 -
 drivers/hid/hid-ids.h                                                  |    3 
 drivers/hid/hid-logitech-hidpp.c                                       |   10 
 drivers/hid/hid-quirks.c                                               |    3 
 drivers/hid/wacom_sys.c                                                |    5 
 drivers/hwmon/adt7462.c                                                |    8 
 drivers/hwmon/applesmc.c                                               |    7 
 drivers/hwmon/aspeed-pwm-tacho.c                                       |    4 
 drivers/hwmon/gpio-fan.c                                               |   13 
 drivers/hwmon/pmbus/lm25066.c                                          |   54 
 drivers/hwmon/pmbus/pmbus.h                                            |    3 
 drivers/hwmon/pmbus/pmbus_core.c                                       |    4 
 drivers/hwmon/pmbus/tps53679.c                                         |   11 
 drivers/hwmon/w83791d.c                                                |    1 
 drivers/hwmon/w83793.c                                                 |    4 
 drivers/i2c/busses/i2c-at91-core.c                                     |    3 
 drivers/i2c/busses/i2c-at91-master.c                                   |   12 
 drivers/i2c/busses/i2c-at91.h                                          |    1 
 drivers/i2c/busses/i2c-imx.c                                           |    2 
 drivers/i2c/i2c-core-smbus.c                                           |   12 
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c                               |    4 
 drivers/i3c/master/mipi-i3c-hci/cmd_v2.c                               |    4 
 drivers/iio/accel/mma8452.c                                            |   19 
 drivers/iio/adc/qcom-spmi-iadc.c                                       |   18 
 drivers/infiniband/core/iwpm_util.c                                    |    9 
 drivers/infiniband/core/mad.c                                          |    3 
 drivers/infiniband/core/ucma.c                                         |    7 
 drivers/infiniband/core/umem.c                                         |   18 
 drivers/infiniband/hw/irdma/verbs.c                                    |    2 
 drivers/infiniband/hw/mlx4/sysfs.c                                     |    4 
 drivers/infiniband/hw/mlx5/cq.c                                        |    3 
 drivers/infiniband/hw/mlx5/main.c                                      |   11 
 drivers/infiniband/sw/siw/siw_cm.c                                     |   75 -
 drivers/infiniband/sw/siw/siw_qp_rx.c                                  |    2 
 drivers/infiniband/ulp/ipoib/ipoib.h                                   |    7 
 drivers/infiniband/ulp/ipoib/ipoib_ib.c                                |   12 
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c                         |   16 
 drivers/infiniband/ulp/iser/iscsi_iser.c                               |   72 -
 drivers/infiniband/ulp/iser/iscsi_iser.h                               |    8 
 drivers/infiniband/ulp/iser/iser_initiator.c                           |   49 
 drivers/infiniband/ulp/iser/iser_memory.c                              |   87 -
 drivers/infiniband/ulp/iser/iser_verbs.c                               |   56 -
 drivers/infiniband/ulp/isert/ib_isert.c                                |   86 -
 drivers/infiniband/ulp/isert/ib_isert.h                                |    4 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                                 |    8 
 drivers/infiniband/ulp/rtrs/rtrs-clt.h                                 |    2 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                                 |   12 
 drivers/input/evdev.c                                                  |    2 
 drivers/input/input-compat.c                                           |    2 
 drivers/input/joystick/xpad.c                                          |   10 
 drivers/input/keyboard/atkbd.c                                         |    8 
 drivers/input/misc/soc_button_array.c                                  |   16 
 drivers/input/mouse/synaptics.c                                        |    8 
 drivers/input/rmi4/rmi_driver.c                                        |   13 
 drivers/input/rmi4/rmi_smbus.c                                         |   10 
 drivers/input/serio/i8042-acpipnpio.h                                  |    7 
 drivers/input/serio/serport.c                                          |    3 
 drivers/input/touchscreen/eeti_ts.c                                    |    1 
 drivers/iommu/rockchip-iommu.c                                         |    8 
 drivers/irqchip/irq-gic-v3-its.c                                       |    1 
 drivers/leds/leds-pca9532.c                                            |    8 
 drivers/leds/uleds.c                                                   |   11 
 drivers/mailbox/mailbox.c                                              |    6 
 drivers/md/raid5.c                                                     |   35 
 drivers/media/i2c/video-i2c.c                                          |    5 
 drivers/media/pci/dm1105/dm1105.c                                      |    7 
 drivers/media/rc/imon.c                                                |    4 
 drivers/media/rc/mceusb.c                                              |    2 
 drivers/media/usb/em28xx/em28xx-video.c                                |    4 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                              |   12 
 drivers/media/v4l2-core/v4l2-h264.c                                    |    3 
 drivers/mfd/rsmu_i2c.c                                                 |    2 
 drivers/mfd/rsmu_spi.c                                                 |    2 
 drivers/mmc/core/bus.c                                                 |    2 
 drivers/mmc/core/queue.c                                               |    8 
 drivers/mmc/core/sdio_uart.c                                           |    3 
 drivers/mmc/host/davinci_mmc.c                                         |   16 
 drivers/mmc/host/mmc_spi.c                                             |    1 
 drivers/mmc/host/mxcmmc.c                                              |    4 
 drivers/mmc/host/renesas_sdhi_internal_dmac.c                          |    2 
 drivers/mmc/host/rtsx_pci_sdmmc.c                                      |    5 
 drivers/mmc/host/sdhci-of-aspeed.c                                     |    5 
 drivers/mmc/host/sdhci_am654.c                                         |    4 
 drivers/mmc/host/sh_mmcif.c                                            |    3 
 drivers/net/bonding/bond_alb.c                                         |   19 
 drivers/net/bonding/bond_main.c                                        |    4 
 drivers/net/can/slcan.c                                                |    3 
 drivers/net/dsa/bcm_sf2_cfp.c                                          |    2 
 drivers/net/dsa/mv88e6xxx/chip.c                                       |   23 
 drivers/net/dsa/sja1105/sja1105_flower.c                               |    4 
 drivers/net/ethernet/allwinner/sun4i-emac.c                            |    2 
 drivers/net/ethernet/amd/au1000_eth.c                                  |    3 
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c                               |    3 
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c                        |    3 
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c                        |    3 
 drivers/net/ethernet/atheros/atlx/atl1.c                               |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                              |   16 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                         |    3 
 drivers/net/ethernet/broadcom/tg3.c                                    |    4 
 drivers/net/ethernet/cortina/gemini.c                                  |   79 -
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c                    |   69 -
 drivers/net/ethernet/freescale/fman/fman.c                             |    1 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c                      |    3 
 drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c                      |    4 
 drivers/net/ethernet/ibm/emac/core.c                                   |    3 
 drivers/net/ethernet/ibm/emac/mal.c                                    |    6 
 drivers/net/ethernet/intel/e1000e/ethtool.c                            |   19 
 drivers/net/ethernet/intel/ice/ice_txrx.c                              |   20 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                        |    3 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c                |   10 
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c                      |   15 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c                 |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c                     |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c                     |    2 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                      |    8 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads_termtbl.c     |    7 
 drivers/net/ethernet/socionext/netsec.c                                |    2 
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c                       |   10 
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c                      |    4 
 drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c                     |    4 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c                     |   12 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h                         |    4 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c                   |    6 
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c                         |   11 
 drivers/net/ethernet/stmicro/stmmac/hwif.h                             |   32 
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c                        |    8 
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c                        |   14 
 drivers/net/ethernet/stmicro/stmmac/stmmac.h                           |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c                  |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                      |    9 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c                       |   21 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c                 |  114 +-
 drivers/net/ethernet/ti/cpsw_new.c                                     |    4 
 drivers/net/ethernet/ti/netcp_core.c                                   |    2 
 drivers/net/fddi/skfp/skfddi.c                                         |    3 
 drivers/net/macvlan.c                                                  |    4 
 drivers/net/ppp/ppp_async.c                                            |   90 -
 drivers/net/ppp/ppp_synctty.c                                          |   17 
 drivers/net/slip/slip.c                                                |    3 
 drivers/net/usb/catc.c                                                 |   15 
 drivers/net/usb/cdc_mbim.c                                             |    5 
 drivers/net/usb/cx82310_eth.c                                          |    1 
 drivers/net/usb/hso.c                                                  |    2 
 drivers/net/usb/lan78xx.c                                              |    7 
 drivers/net/usb/qmi_wwan.c                                             |    2 
 drivers/net/usb/sr9700.c                                               |    3 
 drivers/net/veth.c                                                     |    2 
 drivers/net/vrf.c                                                      |    2 
 drivers/net/vxlan/vxlan_core.c                                         |   11 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c                |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c         |    4 
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c                         |   10 
 drivers/net/wireless/intel/iwlegacy/common.c                           |    2 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                           |   13 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                      |    6 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                          |    4 
 drivers/net/wireless/intersil/p54/eeprom.c                             |   22 
 drivers/net/wireless/mac80211_hwsim.c                                  |    6 
 drivers/net/wireless/marvell/libertas/tx.c                             |    7 
 drivers/net/wireless/marvell/libertas_tf/main.c                        |    2 
 drivers/net/wireless/marvell/mwifiex/fw.h                              |   18 
 drivers/net/wireless/marvell/mwifiex/join.c                            |    8 
 drivers/net/wireless/marvell/mwifiex/pcie.c                            |    2 
 drivers/net/wireless/marvell/mwifiex/scan.c                            |   54 
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c                         |    2 
 drivers/net/wireless/marvell/mwifiex/util.c                            |   10 
 drivers/net/wireless/mediatek/mt76/pci.c                               |    8 
 drivers/net/wireless/microchip/wilc1000/cfg80211.c                     |   14 
 drivers/net/wireless/microchip/wilc1000/wlan.c                         |    9 
 drivers/net/wireless/ralink/rt2x00/rt2400pci.c                         |    2 
 drivers/net/wireless/ralink/rt2x00/rt2500pci.c                         |    2 
 drivers/net/wireless/ralink/rt2x00/rt2800pci.c                         |    2 
 drivers/net/wireless/ralink/rt2x00/rt61pci.c                           |    2 
 drivers/net/wireless/rsi/rsi_91x_hal.c                                 |    8 
 drivers/net/wireless/rsi/rsi_91x_mgmt.c                                |    8 
 drivers/net/wireless/ti/wlcore/main.c                                  |    4 
 drivers/net/wireless/virt_wifi.c                                       |    4 
 drivers/net/wwan/mhi_wwan_mbim.c                                       |   28 
 drivers/nfc/microread/microread.c                                      |    6 
 drivers/nfc/nfcmrvl/fw_dnld.c                                          |   11 
 drivers/nfc/pn533/pn533.c                                              |   14 
 drivers/nfc/pn533/pn533.h                                              |    4 
 drivers/nfc/pn533/usb.c                                                |    4 
 drivers/nfc/pn544/pn544.c                                              |    7 
 drivers/nfc/port100.c                                                  |    7 
 drivers/nfc/st21nfca/core.c                                            |   12 
 drivers/nfc/st21nfca/i2c.c                                             |   33 
 drivers/nfc/virtual_ncidev.c                                           |    3 
 drivers/nvme/host/rdma.c                                               |   18 
 drivers/opp/of.c                                                       |    2 
 drivers/pci/controller/pcie-altera.c                                   |    2 
 drivers/pci/controller/pcie-iproc.c                                    |    2 
 drivers/pci/controller/pcie-mediatek.c                                 |    2 
 drivers/pci/controller/pcie-rockchip-host.c                            |    2 
 drivers/pci/pci-driver.c                                               |   10 
 drivers/pci/pci-sysfs.c                                                |   11 
 drivers/pci/quirks.c                                                   |    3 
 drivers/pinctrl/pinctrl-single.c                                       |    3 
 drivers/platform/x86/dell/dell-laptop.c                                |    9 
 drivers/platform/x86/intel/hid.c                                       |    7 
 drivers/ptp/ptp_ocp.c                                                  |    1 
 drivers/regulator/core.c                                               |  163 +-
 drivers/rtc/rtc-aspeed.c                                               |    1 
 drivers/rtc/rtc-bq32k.c                                                |    9 
 drivers/s390/char/zcore.c                                              |    8 
 drivers/s390/cio/cio.c                                                 |   11 
 drivers/s390/cio/device.c                                              |    2 
 drivers/s390/cio/device_ops.c                                          |   14 
 drivers/s390/net/qeth_l2.h                                             |    3 
 drivers/s390/net/qeth_l2_main.c                                        |   26 
 drivers/s390/net/qeth_l2_sys.c                                         |    7 
 drivers/scsi/bfa/bfa_fcs_lport.c                                       |    2 
 drivers/scsi/hosts.c                                                   |   23 
 drivers/scsi/libiscsi_tcp.c                                            |    3 
 drivers/scsi/mpt3sas/mpt3sas_base.c                                    |   24 
 drivers/scsi/pm8001/pm8001_ctl.c                                       |    8 
 drivers/scsi/pm8001/pm80xx_hwi.c                                       |    7 
 drivers/scsi/scsi_priv.h                                               |    4 
 drivers/scsi/scsi_sysfs.c                                              |   81 -
 drivers/scsi/smartpqi/smartpqi.h                                       |   25 
 drivers/scsi/smartpqi/smartpqi_init.c                                  |  123 --
 drivers/scsi/smartpqi/smartpqi_sis.c                                   |   11 
 drivers/scsi/smartpqi/smartpqi_sis.h                                   |    4 
 drivers/soundwire/bus.c                                                |    4 
 drivers/soundwire/cadence_master.c                                     |    7 
 drivers/soundwire/slave.c                                              |    4 
 drivers/spi/spi-zynqmp-gqspi.c                                         |   52 
 drivers/spi/spi.c                                                      |    6 
 drivers/staging/fbtft/fbtft-core.c                                     |    9 
 drivers/target/iscsi/cxgbit/cxgbit.h                                   |    8 
 drivers/target/iscsi/cxgbit/cxgbit_ddp.c                               |    4 
 drivers/target/iscsi/cxgbit/cxgbit_target.c                            |   34 
 drivers/target/iscsi/iscsi_target.c                                    |  165 +-
 drivers/target/iscsi/iscsi_target.h                                    |   14 
 drivers/target/iscsi/iscsi_target_configfs.c                           |   14 
 drivers/target/iscsi/iscsi_target_datain_values.c                      |   18 
 drivers/target/iscsi/iscsi_target_datain_values.h                      |   12 
 drivers/target/iscsi/iscsi_target_device.c                             |    2 
 drivers/target/iscsi/iscsi_target_device.h                             |    4 
 drivers/target/iscsi/iscsi_target_erl0.c                               |   30 
 drivers/target/iscsi/iscsi_target_erl0.h                               |    8 
 drivers/target/iscsi/iscsi_target_erl1.c                               |   42 
 drivers/target/iscsi/iscsi_target_erl1.h                               |   20 
 drivers/target/iscsi/iscsi_target_erl2.c                               |   20 
 drivers/target/iscsi/iscsi_target_erl2.h                               |    8 
 drivers/target/iscsi/iscsi_target_nego.c                               |    2 
 drivers/target/iscsi/iscsi_target_seq_pdu_list.c                       |   34 
 drivers/target/iscsi/iscsi_target_seq_pdu_list.h                       |   10 
 drivers/target/iscsi/iscsi_target_tmr.c                                |   38 
 drivers/target/iscsi/iscsi_target_tmr.h                                |    8 
 drivers/target/iscsi/iscsi_target_util.c                               |   66 -
 drivers/target/iscsi/iscsi_target_util.h                               |   48 
 drivers/tee/optee/call.c                                               |    3 
 drivers/thermal/tegra/soctherm.c                                       |    6 
 drivers/thunderbolt/tb.c                                               |    6 
 drivers/thunderbolt/xdomain.c                                          |   13 
 drivers/tty/serial/8250/8250_port.c                                    |    7 
 drivers/usb/core/hcd.c                                                 |   14 
 drivers/usb/gadget/udc/goku_udc.c                                      |    3 
 drivers/usb/host/Kconfig                                               |    2 
 drivers/usb/host/xhci-ring.c                                           |    6 
 drivers/usb/host/xhci.c                                                |    4 
 drivers/usb/usbip/vhci_sysfs.c                                         |   52 
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c                                   |   53 
 drivers/vhost/scsi.c                                                   |    3 
 drivers/vhost/vdpa.c                                                   |   12 
 drivers/video/fbdev/pm2fb.c                                            |    1 
 drivers/video/fbdev/vfb.c                                              |   11 
 drivers/virtio/virtio_pci_common.c                                     |    4 
 drivers/watchdog/digicolor_wdt.c                                       |   13 
 drivers/watchdog/msc313e_wdt.c                                         |   35 
 drivers/watchdog/sp5100_tco.c                                          |    6 
 drivers/watchdog/sunxi_wdt.c                                           |   45 
 drivers/watchdog/watchdog_hrtimer_pretimeout.c                         |    1 
 drivers/xen/gntalloc.c                                                 |   13 
 drivers/xen/xen-front-pgdir-shbuf.c                                    |   12 
 fs/9p/vfs_dir.c                                                        |   12 
 fs/affs/affs.h                                                         |    5 
 fs/affs/super.c                                                        |    6 
 fs/autofs/inode.c                                                      |    4 
 fs/befs/linuxvfs.c                                                     |    3 
 fs/bfs/inode.c                                                         |    3 
 fs/btrfs/inode.c                                                       |    3 
 fs/btrfs/relocation.c                                                  |   47 
 fs/btrfs/transaction.c                                                 |   13 
 fs/btrfs/tree-checker.c                                                |    8 
 fs/btrfs/volumes.c                                                     |   79 +
 fs/btrfs/zoned.c                                                       |    2 
 fs/cifs/cifsacl.c                                                      |    3 
 fs/cifs/transport.c                                                    |   11 
 fs/configfs/dir.c                                                      |   12 
 fs/erofs/zdata.c                                                       |   13 
 fs/eventpoll.c                                                         |  152 +-
 fs/exec.c                                                              |   22 
 fs/f2fs/inline.c                                                       |    7 
 fs/freevxfs/vxfs_bmap.c                                                |    3 
 fs/fuse/file.c                                                         |    3 
 fs/hfs/catalog.c                                                       |    9 
 fs/hfs/dir.c                                                           |   28 
 fs/hfs/hfs.h                                                           |    3 
 fs/hfs/hfs_fs.h                                                        |    2 
 fs/hfs/inode.c                                                         |    4 
 fs/hfsplus/catalog.c                                                   |   11 
 fs/hfsplus/dir.c                                                       |   28 
 fs/hfsplus/hfsplus_fs.h                                                |    5 
 fs/hfsplus/inode.c                                                     |   40 
 fs/hfsplus/super.c                                                     |    2 
 fs/hpfs/super.c                                                        |    3 
 fs/iomap/buffered-io.c                                                 |    2 
 fs/isofs/inode.c                                                       |    3 
 fs/jfs/super.c                                                         |    3 
 fs/ksmbd/mgmt/share_config.c                                           |   38 
 fs/ksmbd/misc.c                                                        |   14 
 fs/ksmbd/oplock.c                                                      |   16 
 fs/ksmbd/oplock.h                                                      |    2 
 fs/ksmbd/server.c                                                      |    6 
 fs/ksmbd/smb2misc.c                                                    |    9 
 fs/ksmbd/smb2pdu.c                                                     |   35 
 fs/ksmbd/smbacl.c                                                      |   25 
 fs/ksmbd/transport_ipc.c                                               |   24 
 fs/ksmbd/vfs.c                                                         |   14 
 fs/minix/inode.c                                                       |    3 
 fs/ntfs3/dir.c                                                         |    4 
 fs/ntfs3/fslog.c                                                       |   26 
 fs/ntfs3/index.c                                                       |   41 
 fs/ntfs3/xattr.c                                                       |    4 
 fs/ocfs2/namei.c                                                       |    9 
 fs/ocfs2/xattr.c                                                       |   13 
 fs/ocfs2/xattr.h                                                       |    8 
 fs/omfs/inode.c                                                        |    6 
 fs/qnx4/inode.c                                                        |    3 
 fs/squashfs/xz_wrapper.c                                               |    6 
 fs/ufs/cylinder.c                                                      |   10 
 fs/ufs/super.c                                                         |   17 
 fs/xfs/xfs_icache.c                                                    |    2 
 include/keys/request_key_auth-type.h                                   |    2 
 include/linux/bitfield.h                                               |    2 
 include/linux/file.h                                                   |    2 
 include/linux/kcsan-checks.h                                           |    6 
 include/linux/lockdep.h                                                |   16 
 include/linux/lockdep_types.h                                          |    8 
 include/linux/lsm_hook_defs.h                                          |    2 
 include/linux/lsm_hooks.h                                              |    1 
 include/linux/mailbox_controller.h                                     |    2 
 include/linux/platform_data/asoc-ux500-msp.h                           |   20 
 include/linux/rculist.h                                                |   29 
 include/linux/tty_ldisc.h                                              |    2 
 include/media/v4l2-hevc.h                                              |   41 
 include/net/cfg80211.h                                                 |    2 
 include/net/gue.h                                                      |   19 
 include/net/ip6_route.h                                                |    2 
 include/net/netfilter/nf_conntrack.h                                   |    5 
 include/net/netfilter/nf_flow_table.h                                  |    1 
 include/net/netns/xfrm.h                                               |    2 
 include/net/nfc/hci.h                                                  |    2 
 include/net/nfc/nfc.h                                                  |    3 
 include/rdma/ib_umem.h                                                 |    4 
 include/scsi/scsi_device.h                                             |    7 
 include/scsi/scsi_host.h                                               |   12 
 include/target/iscsi/iscsi_target_core.h                               |   34 
 include/target/iscsi/iscsi_transport.h                                 |   92 -
 include/uapi/linux/landlock.h                                          |    1 
 kernel/bpf/btf.c                                                       |   29 
 kernel/bpf/cgroup.c                                                    |    1 
 kernel/bpf/hashtab.c                                                   |   24 
 kernel/bpf/verifier.c                                                  |    9 
 kernel/dma/coherent.c                                                  |   13 
 kernel/events/ring_buffer.c                                            |    9 
 kernel/locking/lockdep.c                                               |  230 +++-
 kernel/trace/trace_event_perf.c                                        |   12 
 kernel/trace/trace_events_hist.c                                       |    2 
 kernel/trace/trace_probe.c                                             |   48 
 kernel/trace/trace_probe.h                                             |    2 
 kernel/workqueue.c                                                     |    2 
 mm/backing-dev.c                                                       |    5 
 mm/damon/core.c                                                        |   13 
 net/8021q/vlan_dev.c                                                   |    5 
 net/appletalk/aarp.c                                                   |    5 
 net/atm/pppoatm.c                                                      |   42 
 net/bluetooth/bnep/core.c                                              |   17 
 net/bluetooth/bnep/netdev.c                                            |    8 
 net/bluetooth/hci_sock.c                                               |   20 
 net/bluetooth/l2cap_core.c                                             |   31 
 net/bluetooth/l2cap_sock.c                                             |   10 
 net/bluetooth/rfcomm/core.c                                            |    6 
 net/bluetooth/rfcomm/sock.c                                            |   19 
 net/bluetooth/smp.c                                                    |   17 
 net/bridge/br_arp_nd_proxy.c                                           |   16 
 net/bridge/br_multicast.c                                              |    2 
 net/bridge/br_stp_bpdu.c                                               |    5 
 net/core/dev.c                                                         |    4 
 net/core/drop_monitor.c                                                |    4 
 net/core/filter.c                                                      |   33 
 net/core/skbuff.c                                                      |   16 
 net/core/sock.c                                                        |    9 
 net/core/sock_map.c                                                    |    1 
 net/hsr/hsr_netlink.c                                                  |    9 
 net/ieee802154/6lowpan/core.c                                          |    2 
 net/ipv4/arp.c                                                         |    1 
 net/ipv4/fib_rules.c                                                   |    4 
 net/ipv4/fou_core.c                                                    |    6 
 net/ipv4/ip_gre.c                                                      |   12 
 net/ipv4/ip_tunnel_core.c                                              |    6 
 net/ipv4/nexthop.c                                                     |    2 
 net/ipv4/sysctl_net_ipv4.c                                             |    4 
 net/ipv4/tcp_input.c                                                   |    3 
 net/ipv4/tcp_output.c                                                  |    3 
 net/ipv6/addrconf.c                                                    |   10 
 net/ipv6/exthdrs.c                                                     |    4 
 net/ipv6/exthdrs_core.c                                                |    3 
 net/ipv6/ip6_fib.c                                                     |    4 
 net/ipv6/ip6_gre.c                                                     |    2 
 net/ipv6/mcast.c                                                       |   32 
 net/ipv6/netfilter/ip6_tables.c                                        |    5 
 net/ipv6/netfilter/ip6t_rpfilter.c                                     |    2 
 net/ipv6/netfilter/ip6t_rt.c                                           |   11 
 net/ipv6/route.c                                                       |   22 
 net/ipv6/seg6.c                                                        |    4 
 net/ipv6/seg6_local.c                                                  |    3 
 net/ipv6/tcp_ipv6.c                                                    |    3 
 net/ipv6/xfrm6_output.c                                                |   10 
 net/llc/llc_c_ac.c                                                     |    2 
 net/llc/llc_s_ac.c                                                     |    4 
 net/llc/llc_sap.c                                                      |    8 
 net/mac80211/cfg.c                                                     |    5 
 net/mac80211/debugfs.c                                                 |    2 
 net/mac80211/debugfs_netdev.c                                          |    6 
 net/mac80211/ieee80211_i.h                                             |    2 
 net/mac80211/iface.c                                                   |    2 
 net/mac80211/mesh.c                                                    |    1 
 net/mac80211/mlme.c                                                    |    6 
 net/mac80211/pm.c                                                      |    8 
 net/mac80211/tx.c                                                      |    2 
 net/mac80211/util.c                                                    |    6 
 net/mptcp/options.c                                                    |    3 
 net/mptcp/protocol.c                                                   |   10 
 net/mptcp/protocol.h                                                   |    3 
 net/mptcp/subflow.c                                                    |   11 
 net/mptcp/syncookies.c                                                 |    5 
 net/netfilter/ipset/ip_set_hash_gen.h                                  |   13 
 net/netfilter/ipvs/ip_vs_core.c                                        |    6 
 net/netfilter/ipvs/ip_vs_sync.c                                        |   20 
 net/netfilter/nf_conntrack_expect.c                                    |    3 
 net/netfilter/nf_conntrack_netlink.c                                   |   13 
 net/netfilter/nf_conntrack_proto_tcp.c                                 |   10 
 net/netfilter/nf_conntrack_sip.c                                       |    2 
 net/netfilter/nf_flow_table_core.c                                     |   12 
 net/netfilter/nf_flow_table_offload.c                                  |   19 
 net/netfilter/nf_log_syslog.c                                          |    6 
 net/netfilter/nf_tables_api.c                                          |    4 
 net/netfilter/nfnetlink_log.c                                          |   28 
 net/netfilter/nfnetlink_queue.c                                        |   77 -
 net/netfilter/nft_nat.c                                                |    2 
 net/netfilter/nft_set_pipapo_avx2.c                                    |    1 
 net/netfilter/nft_synproxy.c                                           |    3 
 net/netlabel/netlabel_unlabeled.c                                      |    2 
 net/nfc/core.c                                                         |   15 
 net/nfc/digital_dep.c                                                  |    8 
 net/nfc/llcp.h                                                         |    1 
 net/nfc/llcp_commands.c                                                |    2 
 net/nfc/llcp_core.c                                                    |  175 ++-
 net/nfc/llcp_sock.c                                                    |   65 -
 net/nfc/nci/core.c                                                     |   10 
 net/nfc/netlink.c                                                      |    7 
 net/nfc/nfc.h                                                          |    3 
 net/openvswitch/conntrack.c                                            |   14 
 net/openvswitch/flow_table.c                                           |    4 
 net/packet/af_packet.c                                                 |   11 
 net/packet/internal.h                                                  |    2 
 net/phonet/pn_dev.c                                                    |   30 
 net/qrtr/af_qrtr.c                                                     |    4 
 net/rds/af_rds.c                                                       |   63 -
 net/rds/connection.c                                                   |  102 +
 net/rds/ib_cm.c                                                        |   27 
 net/rds/ib_frmr.c                                                      |   11 
 net/rds/ib_recv.c                                                      |    9 
 net/rds/message.c                                                      |    6 
 net/rds/send.c                                                         |   16 
 net/rds/tcp.c                                                          |  164 ++
 net/rds/tcp_listen.c                                                   |    6 
 net/sched/act_api.c                                                    |   22 
 net/sched/act_csum.c                                                   |    8 
 net/sched/act_ct.c                                                     |    5 
 net/sched/cls_api.c                                                    |    2 
 net/sched/cls_route.c                                                  |   45 
 net/sched/sch_drr.c                                                    |   13 
 net/sched/sch_ets.c                                                    |   12 
 net/sched/sch_fq_pie.c                                                 |   62 -
 net/sched/sch_hfsc.c                                                   |   22 
 net/sched/sch_hhf.c                                                    |   15 
 net/sched/sch_pie.c                                                    |    2 
 net/sched/sch_sfq.c                                                    |    7 
 net/sched/sch_teql.c                                                   |    7 
 net/sctp/associola.c                                                   |   15 
 net/sctp/input.c                                                       |    7 
 net/sctp/ipv6.c                                                        |   10 
 net/sctp/protocol.c                                                    |   10 
 net/sctp/sm_make_chunk.c                                               |   14 
 net/sctp/sm_sideeffect.c                                               |   48 
 net/sctp/sm_statefuns.c                                                |    2 
 net/smc/smc_clc.c                                                      |    8 
 net/smc/smc_clc.h                                                      |    9 
 net/smc/smc_core.c                                                     |    2 
 net/smc/smc_ib.c                                                       |   59 +
 net/sunrpc/xprtrdma/verbs.c                                            |   21 
 net/tipc/group.c                                                       |    4 
 net/tipc/monitor.c                                                     |    3 
 net/tipc/name_table.c                                                  |   30 
 net/tls/tls_sw.c                                                       |    6 
 net/vmw_vsock/hyperv_transport.c                                       |    2 
 net/vmw_vsock/vmci_transport.c                                         |    2 
 net/wireless/mlme.c                                                    |   45 
 net/wireless/nl80211.c                                                 |    2 
 net/wireless/scan.c                                                    |   12 
 net/wireless/util.c                                                    |   26 
 net/wireless/wext-sme.c                                                |    9 
 net/xdp/xskmap.c                                                       |    2 
 net/xfrm/espintcp.c                                                    |    6 
 net/xfrm/xfrm_input.c                                                  |   11 
 net/xfrm/xfrm_user.c                                                   |  228 ++--
 scripts/mod/modpost.c                                                  |   11 
 security/apparmor/lsm.c                                                |    7 
 security/integrity/digsig_asymmetric.c                                 |    4 
 security/integrity/ima/ima_appraise.c                                  |    5 
 security/keys/gc.c                                                     |    4 
 security/keys/request_key_auth.c                                       |   12 
 security/keys/trusted-keys/trusted_tpm2.c                              |   12 
 security/landlock/errata/abi-1.h                                       |   24 
 security/landlock/fs.c                                                 |   40 
 security/security.c                                                    |    4 
 security/selinux/avc.c                                                 |    5 
 security/tomoyo/tomoyo.c                                               |    4 
 sound/core/pcm_native.c                                                |   35 
 sound/core/pcm_timer.c                                                 |    7 
 sound/core/seq/oss/seq_oss_rw.c                                        |    3 
 sound/isa/es18xx.c                                                     |    4 
 sound/pci/ctxfi/cthw20k2.c                                             |    1 
 sound/pci/hda/hda_controller.c                                         |    2 
 sound/pci/hda/patch_conexant.c                                         |   12 
 sound/pci/hda/patch_realtek.c                                          |    2 
 sound/soc/amd/renoir/acp3x-pdm-dma.c                                   |    2 
 sound/soc/bcm/bcm63xx-i2s-whistler.c                                   |    1 
 sound/soc/codecs/ab8500-codec.c                                        |  555 ++++------
 sound/soc/codecs/cx20442.c                                             |    3 
 sound/soc/codecs/hdmi-codec.c                                          |    6 
 sound/soc/codecs/mt6351.c                                              |    1 
 sound/soc/codecs/pcm3168a.c                                            |   20 
 sound/soc/codecs/rk3328_codec.c                                        |   54 
 sound/soc/codecs/rt5645.c                                              |    4 
 sound/soc/intel/atom/sst/sst_pci.c                                     |    1 
 sound/soc/intel/catpt/ipc.c                                            |    8 
 sound/soc/intel/catpt/loader.c                                         |    3 
 sound/soc/intel/catpt/registers.h                                      |   12 
 sound/soc/rockchip/rockchip_pdm.c                                      |   16 
 sound/soc/rockchip/rockchip_spdif.c                                    |    1 
 sound/soc/sprd/sprd-pcm-compress.c                                     |   15 
 sound/soc/sti/uniperif_reader.c                                        |    4 
 sound/soc/ti/ams-delta.c                                               |    3 
 sound/soc/ti/omap3pandora.c                                            |    5 
 sound/soc/ux500/mop500.c                                               |    8 
 sound/soc/ux500/ux500_msp_dai.c                                        |  167 +--
 sound/soc/ux500/ux500_msp_dai.h                                        |   11 
 sound/soc/ux500/ux500_msp_i2s.c                                        |  330 +++--
 sound/soc/ux500/ux500_msp_i2s.h                                        |   30 
 sound/soc/ux500/ux500_pcm.c                                            |   83 -
 sound/usb/caiaq/audio.c                                                |   10 
 sound/usb/caiaq/device.c                                               |   53 
 sound/usb/caiaq/device.h                                               |    4 
 sound/usb/caiaq/input.c                                                |    6 
 sound/usb/caiaq/midi.c                                                 |    6 
 sound/usb/mixer.c                                                      |   17 
 sound/usb/mixer_maps.c                                                 |   10 
 sound/usb/quirks-table.h                                               |   22 
 sound/usb/quirks.c                                                     |    2 
 sound/usb/usx2y/us122l.c                                               |    9 
 sound/usb/usx2y/usbusx2y.c                                             |   45 
 sound/usb/usx2y/usbusx2y.h                                             |    4 
 tools/bpf/bpftool/map.c                                                |    6 
 tools/lib/bpf/gen_loader.c                                             |    2 
 tools/lib/bpf/relo_core.c                                              |   60 -
 tools/perf/tests/shell/stat_bpf_counters.sh                            |   30 
 tools/perf/util/cs-etm.c                                               |   81 -
 tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c              |    2 
 tools/testing/selftests/cgroup/test_kmem.c                             |    2 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc |    2 
 tools/testing/selftests/landlock/fs_test.c                             |  154 ++
 tools/testing/selftests/nci/nci_dev.c                                  |   45 
 tools/testing/selftests/net/fib_nexthops.sh                            |   28 
 tools/testing/selftests/net/pmtu.sh                                    |    2 
 tools/testing/selftests/powerpc/tm/tm.h                                |    8 
 tools/thermal/tmon/tui.c                                               |    2 
 723 files changed, 7673 insertions(+), 4768 deletions(-)

Aamir Ahmed (3):
      net: hinic: fix mailbox segment buffer overflow
      net: usb: catc: bound the RX packet length in catc_rx_done()
      nfc: llcp: drop truncated I/RR/RNR PDUs in nfc_llcp_recv_hdlc()

Adrian Hunter (1):
      i3c: mipi-i3c-hci: Tolerate i3c_master_add_i3c_dev_locked() failures in DAA

Adrian Ng Ho Yin (1):
      clk: socfpga: agilex: implement l3_main_free_clk

Adrian Wowk (1):
      usbip: vhci_hcd: fix NULL deref in status_show_vhci

Adriana Stancu (1):
      rtc: bq32000: add delay between RTC reads

Agalakov Daniil (1):
      e1000e: limit endianness conversion to boundary words

Al Viro (1):
      configfs_depend_prep(): pass configfs_dirent instead of dentry

Aldo Ariel Panzardo (4):
      nfc: llcp: Fix list corruption / refcount desync in nfc_llcp_recv_dm()
      Bluetooth: hci_sock: validate event length before filtering
      Bluetooth: hci_sock: reject out-of-range OCF values
      Bluetooth: L2CAP: validate frame length before control and FCS access

Alessandro Baldi (1):
      media: imon: Add iMON VFD HID OEM v1.2 key mappings

Alessandro Schino (1):
      ntfs3: fix out-of-bounds read in ntfs_dir_emit() and hdr_find_e()

Alex Bereza (2):
      dmaengine: xilinx_dma: Fix hardware buffer descriptor reuse order
      dmaengine: xilinx_dma: Fix hardware buffer descriptor chain after cyclic DMA

Alexander Chesnokov (1):
      dmaengine: ti: k3-udma-glue: fix NULL dereference in k3_udma_glue_release_rx_chn()

Alexandre Courbot (1):
      scripts: modpost: detect and report truncated buf_printf() output

Alexei Turtanov (1):
      Input: atkbd - skip deactivate for Xiaomi Redmi Book Pro 16 2026

Ali Ahmet Memis (3):
      ufs: create the root dentry after loading cylinder metadata
      ufs: validate cylinder group metadata before caching it
      wifi: wilc1000: fix out-of-bounds read in P2P public action frames

Alice Mikityanska (2):
      net/sched: act_csum: don't mangle UDP tunnel GSO packets
      net: ipv6: Clamp to IP6_MAX_MTU in ip6_dst_mtu_maybe_forward

Allison Henderson (6):
      net/rds: Don't sleep inside rds_ib_conn_path_shutdown
      net/rds: use wq_has_sleeper() in release_in_xmit()
      net/rds: use clear_bit_unlock() in release_refill()
      net/rds: clear cp_flags bits individually in rds_conn_path_reset()
      net/rds: acquire RDS_IN_XMIT in rds_tcp_reset_callbacks()
      net/rds: don't let rds_conn_shutdown() consume a concurrent drop

Amit Machhiwal (1):
      KVM: PPC: Book3S HV: fix secure device page leak on uv_page_in() failure

Anand Jain (1):
      btrfs: consolidate device_list_mutex in prepare_sprout to its parent

Andrea Mayer (1):
      seg6: set IPSKB_L3SLAVE from IP6SKB_L3SLAVE on IPIP decapsulation

Andrei Faleichyk (1):
      ALSA: hda/realtek: Add quirk for ASUS VivoBook X509DAP

Andrew Halaney (1):
      net: stmmac: Remove some unnecessary void pointers

Andrew Stellman (1):
      virtio-pci: return IRQ_HANDLED after non-zero ISR

Andy Shevchenko (1):
      smb: client: transport: Fix debug printing in __release_mid()

Aohan Mei (2):
      rds: ib: use rds_conn_drop() on protocol version mismatch
      sctp: discard the rest of the packet on a stale-cookie error

Arash Golgol (1):
      media: video-i2c: fix buffer queue ordering

Arnd Bergmann (3):
      scsi: bfa: Reduce kernel stack usage in bfa_fcs_lport_fdmi_build_portattr_block()
      ASoC: ux500: remove platform_data support
      ASoC: ux500: remove stedma40 references

Aurelien DESBRIERES (1):
      RDMA/rtrs-srv: Fix integer underflow in process_read and process_write

Baineng Shou (1):
      dmaengine: mmp_pdma: fix wrong sg length in mmp_pdma_prep_slave_sg()

Bard Liao (2):
      soundwire: only handle alert events when the peripheral is attached
      soundwire: cadence_master: wait and cancel cdns->work before clock stop

Basavaraj Natikar (1):
      HID: amd_sfh: Move common macros and structures

Benoît Sevens (1):
      HID: logitech-hidpp: fix race condition when accessing stale stack pointer

Boqun Feng (2):
      locking/lockdep: Introduce lock_sync()
      locking/lockdep: Improve the deadlock scenario print for sync and read lock

Carolina Jubran (3):
      net/mlx5e: Fix ETS zero BW reporting when one TC holds 100%
      net/mlx5e: Fix use-after-free race in sample_restore_put()
      IB/IPoIB: Avoid restoring OPER_UP after multicast flush

Cezary Rojewski (2):
      ASoC: Intel: catpt: Complete coredump handling
      ASoC: codecs: pcm3168a: Drop CONFIG_PM-conditional preproc directive

Chaithanya Lagisetty (1):
      selftests: nci: Fix uninitialized family ID on missing attribute

Chen Changcheng (1):
      HID: alps: fix use-after-free on input2 registration failure

Chen Cheng (1):
      md/raid5: let stripe batch bm_seq comparison wrap-safe

Chen Pei (1):
      ACPI: PCI: Clear _DEP dependencies after PCI root bridge attach

Chen-Yu Tsai (1):
      dma-coherent: Warn if OF reserved memory is beyond current coherent DMA mask

Chengfeng Ye (1):
      netfilter: nf_log: unregister loggers before per-net teardown

Chenguang Zhao (2):
      RDMA/mlx5: Use QP port when decoding responder CQEs
      netlabel: fix IPv6 unlabeled address add error handling

Chris Gellermann (2):
      selftests/nci: Fix out-of-bounds store on thread join
      nfc: virtual_ncidev: Add missing ioctl compat handler

Chris Sommers (1):
      Input: i8042 - add quirk for Acer Aspire Go 15 AG15-42P

Christian Brauner (8):
      file: add fput() cleanup helper
      eventpoll: use hlist_is_singular_node() in __ep_remove()
      eventpoll: split __ep_remove()
      eventpoll: kill __ep_remove()
      eventpoll: drop vestigial __ prefix from ep_remove_{file,epi}()
      eventpoll: rename ep_remove_safe() back to ep_remove()
      eventpoll: move epi_fget() up
      eventpoll: fix ep_remove struct eventpoll / struct file UAF

Christian Göttsche (1):
      selinux: always fill AVC decision in avc_has_perm_noaudit()

Christian Lugnberg (2):
      dmaengine: sun6i: fix non-atomic read of DMA position registers
      dmaengine: sun6i: fix undefined behaviour in sun6i_dma_tx_status

Christian Marangi (1):
      usb: host: add ARCH_AIROHA in XHCI MTK dependency

Christiano Amora (1):
      Bluetooth: SMP: reject Security Request over BR/EDR

Christoph Hellwig (9):
      befs: handle set_blocksize failures
      affs: handle set_blocksize failures
      bfs: handle set_blocksize failures
      minix: handle set_blocksize failures
      qnx4: handle set_blocksize failures
      jfs: handle set_blocksize failures
      hpfs: handle set_blocksize failures
      omfs: handle set_blocksize failures
      isofs: handle set_blocksize failures

Chuck Lever (1):
      xprtrdma: Add request-pool slack for delayed recycling

Colin Ian King (2):
      OPP: of: Fix potential multiplication overflow when calculating freq
      nfc: st21nfca: remove redundant assignment to variable i

Cong Nguyen (3):
      hwmon: (gpio-fan) take fan_data->lock in gpio_fan_shutdown()
      hwmon: (applesmc) fix key backlight workqueue leak on register failure
      nfc: llcp: fix sdreq TLV list leak on parse/alloc/send failure

Corentin Labbe (1):
      wifi: ralink: RT2X00: init EEPROM properly

Cássio Gabriel (4):
      ALSA: usb-audio: Propagate write errors in generic mixer put callbacks
      ALSA: usx2y: Drain pending US-428 pipe-4 output commands
      ASoC: codecs: rk3328: Use managed GPIO and clock helpers
      ALSA: seq: oss: Reject reads that cannot fit the next event

Dairui Zhang (1):
      af_packet: fix integer overflow in prb_calc_retire_blk_tmo()

Dan Carpenter (2):
      drm/virtio: Fix a NULL vs ERR_PTR() bug in virtio_gpu_user_framebuffer_create()
      drm/nouveau/clk: fix list cursor use after loop in nvkm_clk_ustate_update

Daniel Borkmann (2):
      libbpf: Also reset {insn,data}_cur on realloc failure
      bpf: Fix bpf_skb_change_tail wrt csum partial skbs

Daniel C. Ribeiro (1):
      ALSA: usb-audio: Add FIXED_RATE quirk for JBL Quantum650 Wireless

Daniel Lezcano (1):
      thermal/drivers/tegra/soctherma: Switch to devm cooling device registration

Danielle Ratson (1):
      bridge: Do not suppress ARP probes and DAD NS unconditionally

Dario Binacchi (1):
      drm/panel: simple: Add AM-1280800W8TZQW-T00H

Darrick J. Wong (2):
      iomap: iomap: fix memory corruption when recording errors during writeback
      xfs: fix blockgc group quota scanning when usrquota isn't enforced

Dave Chen (1):
      btrfs: only account delalloc bytes for regular file inodes in btrfs_getattr()

David Arcari (1):
      watchdog: fix hrtimer start when pretimeout is zero

David Matlack (4):
      KVM: x86/mmu: Use a bool for direct
      KVM: x86/mmu: Stop passing "direct" to mmu_alloc_root()
      KVM: x86/mmu: Derive shadow MMU page role from parent
      KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes

David Yang (1):
      net: dsa: sja1105: flower: reject cross-chip redirect

Dawei Feng (1):
      bpf: NUL-terminate replaced sysctl value

Deepanshu Kartikey (2):
      wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()
      nfc: pn533: fix OOB read in pn533_acr122_is_rx_frame_valid()

Diogo Ivo (Schneider Electric) (1):
      mmc: sdhci_am654: Reset command and data lines on failed tuning

Dmitriy Okunev (1):
      net: mvpp2: prevent buffer overflow in page_pool allocation

Dmitry Baryshkov (2):
      drm/msm/dsi: correct byte intf clock rate for 14nm DSI PHY
      drm/msm/dsi: round the byte clock rate after reparenting to the PHY PLL

Dmitry Bogdanov (1):
      scsi: target: iscsi: Handle abort for WRITE_PENDING cmds

Dmitry Torokhov (2):
      Input: rmi_smbus - fix out-of-bounds read in rmi_smb_write_block()
      Input: synaptics-rmi4 - fix GPF in suspend and resume when unbound

Donggeun Yoo (2):
      tracing: Free histogram the var ref when its initialization fails
      dma-coherent: report a failed reserved memory assignment

Dongliang Qin (1):
      rds: ib: Clear the sg list when mapping an MR fails

Doruk Tan Ozturk (2):
      wifi: mwifiex: bound the pairwise-cipher OUI walk to the IE length
      nfc: port100: reject frames whose declared length exceeds the received data

Eduard Zingerman (1):
      bpf: reject BPF_PSEUDO_FUNC reference to the main program

Edward Adam Davis (2):
      ALSA: caiaq: Decoupling ep1_in_urb in caiaq dev
      bluetooth/l2cap: sync sock recv cb and release

Emil Tsalapatis (1):
      bpf: Fix bpf_sock context code generation

Emmanuel Grumbach (3):
      wifi: iwlwifi: mvm: fix an off-by-1 boundary check
      wifi: iwlwifi: mvm: fix sched scan IE sizing
      wifi: iwlwifi: bound aligned TLV advance in FW parser

Eric Biggers (3):
      crypto: sun8i-ce - Remove crypto_rng interface
      crypto: sun8i-ss - Remove crypto_rng interface
      netfilter: nft_set_pipapo_avx2: add missing vzeroupper

Eric Dumazet (20):
      net: bridge: remove stale rcu_barrier() in br_multicast_dev_del()
      net/sched: sch_drr: make cl->quantum lockless
      ipv6: sr: restore network header before routing and forwarding
      locking/lockdep: Invalidate stale class_cache entries for zapped classes
      bonding: do not clear curr_active_slave prematurely when releasing all slaves
      bonding: use skb_cow_head() in bond_do_alb_xmit() and rlb_arp_xmit()
      net_sched: sch_fq_pie: implement lockless fq_pie_dump()
      macvlan: inherit needed_headroom and needed_tailroom from lowerdev
      ipv6: mcast: extend RCU protection in igmp6_send()
      xfrm: add missing rcu_read_lock(), skb_dst_force() and dev_hold() for xfrm_trans_reinject()
      tcp: do not let tcp_rmem be set below 4096
      pppoatm: ensure a writable skb header and linear data
      drop_monitor: synchronize tracepoint unregistration on error path
      drop_monitor: fix out-of-bounds write in reset_per_cpu_data()
      net: lock the socket in sock_gettstamp()
      llc: fix skb UAF and leaks on llc_mac_hdr_init() failure
      bridge: check llc_mac_hdr_init() return value in br_send_bpdu()
      net/sched: sch_teql: fix shadowed err in __teql_resolve()
      vlan: ensure sufficient headroom in vlan_dev_hard_header()
      tipc: reject invalid and unexpected GRP_ACK_MSG to prevent bc_ackers underflow

Erich Sartison (1):
      Input: xpad - add support for Victrix Pro BFG Controller

Ethan Nelson-Moore (1):
      ASoC: ti: omap3pandora: update board check to use DT compatible

Fan Wu (2):
      hwmon: (gpio-fan) Fix use-after-free in alarm work
      mmc: mxcmmc: cancel data work and watchdog on remove

Farhad Alemi (1):
      freevxfs: don't BUG() on unknown typed-extent type

Felix Gu (1):
      mmc: sdio_uart: fix xmit_fifo leak when the port table is full

Feng Zhou (1):
      bpf: support access variable length array of integer type

Fernando Fernandez Mancera (1):
      ipv6: addrconf: fix temp address generation after prefix deprecation

Filipe Manana (3):
      btrfs: fix use-after-free on reloc root after error in insert_dirty_subvol()
      btrfs: fix reloc root cleanup in merge_reloc_roots()
      btrfs: tree-checker: print dev extent offset in error message

Florian Eckert (1):
      tools/thermal/tmon: Fix compilation warning for wrong format

Florian Fainelli (1):
      net: bcmgenet: validate Ethernet address in bcmgenet_set_mac_addr

Florian Maillard (1):
      mmc: rtsx_pci_sdmmc: ignore broken write-protect on ThinkPad X260

Florian Westphal (5):
      netfilter: nf_conntrack_expect: zero at allocation time
      netfilter: nfnetlink_log: wait for rcu grace period before freeing pernet state
      netfilter: nfnetlink_log: cope with concurrent instance destruction
      netfilter: ip6_tables: set F_PROTO when proto value is nonzero
      netfilter: nfnetlink_queue: hold nfnl mutex in event notifier

Fourie Zhang (1):
      net: mpls: clear inner_protocol when the last label is popped

Francesco Magazzu (1):
      drm/nouveau/clk: don't clobber reclock status when restoring volt/fan

Gajdos Tamás (3):
      net: atl1: fix soft lockup on out-of-range cmb_tpd_next_to_clean read
      net: atl1c: fix soft lockup on out-of-range tpd_cons read
      net: atl1e: fix soft lockup on out-of-range hw_next_to_clean read

Galen Hassen (1):
      ALSA: hda/conexant: Add pin config quirk for Lenovo IdeaPad Slim 5 16AKP10

Geert Uytterhoeven (2):
      clk: renesas: cpg-mssr: Add number of clock cells check
      clk: at91: pmc: #undef field_{get,prep}() before definition

Georgi Valkov (1):
      wifi: mwifiex: replace one-element arrays with flexible array members

Gerd Rausch (1):
      net/rds: tcp: don't force RDS_CONN_RESETTING over a concurrent shutdown

Ginger Li (1):
      tipc: Fix a data race on mon->peer_cnt in mon_timeout()

Gleb Sonichev (1):
      platform/x86: dell-laptop: add Inspiron N5110 to touchpad LED quirk table

Goldwyn Rodrigues (1):
      ima: return error early if file xattr cannot be changed

Gongwei Li (1):
      Bluetooth: hci_mrvl: Fix wrong return value check of wait_on_bit_timeout()

Greg Kroah-Hartman (1):
      Linux 5.15.222

Greg Marsden (1):
      net/rds: fix tcp stream corruption with large pages

Guangguan Wang (1):
      net/smc: check v2_ext_offset/eid_cnt/ism_gid_cnt when receiving proposal msg

Guanghui Yang (2):
      btrfs: detach failed sprout device from transaction update list
      btrfs: restore active device pointers after failed sprout

Guanglei Zhu (2):
      net: wwan: mhi_wwan_mbim: guard against a cyclic NDP chain
      net: wwan: mhi_wwan_mbim: check skb_copy_bits() return value

Guangshuo Li (7):
      net: cpsw_new: unregister devlink on port registration failure
      hwmon: (w83791d) remove fan/pwm 4-5 sysfs group on remove
      hwmon: (w83793) release probe data through kref
      drm/msm/adreno: fix autosuspend cleanup during teardown
      drm/msm/hdmi_phy: fix runtime PM cleanup on probe failure
      drm/nouveau: fix autosuspend cleanup during teardown
      drm/amdgpu/atom: Check kcalloc() for WS buffer in amdgpu_atom_execute_table_locked()

Guoqing Jiang (3):
      RDMA/siw: Introduce siw_cep_set_free_and_put
      RDMA/siw: Cleanup siw_accept
      RDMA/siw: Clear association under lock if siw_qp_modify fails in siw_accept

Gustavo Kenji Mendonça Kaneko (2):
      drm/arm/malidp: use clk_bulk API in runtime PM resume and suspend
      drm/arm/komeda: fix error handling for clk_prepare_enable() and callers

Günther Noack (2):
      landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout creation
      selftests/landlock: Add tests for whiteout object creation

Hans Zhang (4):
      PCI: iproc: Protect root bus removal with rescan lock
      PCI: altera: Protect root bus removal with rescan lock
      PCI: rockchip: Protect root bus removal with rescan lock
      PCI: mediatek: Protect root bus removal with rescan lock

Hans de Goede (2):
      Input: soc_button_array - fix MS Surface Pro 11 probe failure
      Input: soc_button_array - check btns_desc->package.count

Haotian Zhang (1):
      media: v4l2-h264: Fix memcmp() size in B1 reference list comparison

Haoxiang Li (2):
      media: em28xx-video: fix missing res_free() on init_usb_xfer failure
      fbdev: pm2fb: unwind WC setup on probe failure

Harald Freudenberger (1):
      s390/crypto: Fix missing scrub of temp buffers with AES ctr and gcm algorithm

Harry Wentland (1):
      dm/amdgpu: fix malformed link_settings debugfs output

Heiko Carstens (1):
      s390/zcore: Removed unused variables

Henry Martin (2):
      sctp: fix soft lockup from unpadded ASCONF-ACK parameter iteration
      tracing/probes: Fix use-after-free on field name/type of events with multiple probes

Hirokazu Honda (1):
      tee: optee: Allow MT_NORMAL_TAGGED shared memory

Hohyun Sim (1):
      net: fddi: skfp: fix NULL deref when setting the MAC address while down

Hongfu Li (1):
      selftests/cgroup: Fix cg_run_in_subcgroups ignoring arg parameter

Hui Peng (6):
      Bluetooth: bnep: fix out-of-bounds reads on short RX/TX frames and control fallthrough
      Bluetooth: RFCOMM: Reject short EA=0 frames in rfcomm_recv_frame()
      autofs: fix sbi->pipe file reference leak in autofs_kill_sb()
      fou: reject omitted FOU_ATTR_IPPROTO on FOU_ENCAP_DIRECT
      ipv6: sr: enforce exact attribute length for SEG6_ATTR_DST
      Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO

Hui Su (1):
      staging: fbtft: make dirty_lock IRQ-safe

HyeongJun An (1):
      ASoC: hdmi-codec: Report a change when the channel status moves

Håkon Bugge (1):
      net/rds: acquire the fastpath locks in rds_conn_shutdown()

Ibrahim Hashimov (1):
      wifi: mac80211_hwsim: reject undersized HWSIM_ATTR_TX_INFO

Ido Schimmel (5):
      nexthop: Initialize extack in remove_nh_grp_entry()
      tunnels: Drop stale dst when building an ICMP error for PMTUD
      ipv6: Select best matching nexthop object in fib6_table_lookup()
      ipv6: Honor oif when choosing nexthop for locally generated traffic
      vrf: Stop corrupting skb->csum when capturing CHECKSUM_COMPLETE packets

Ilya Maximets (2):
      netfilter: report NLM_F_DUMP_FILTERED when all is filtered out
      net: openvswitch: conntrack: avoid modifying shared unconfirmed ct entry

Inbal Schussheim (1):
      tcp: exclude old ACKs from tcp fast path

Ioana Ciornei (4):
      bus: fsl-mc: wait for the MC firmware to complete its boot
      dpaa2-switch: rework FDB management on the bridge leave path
      dpaa2-switch: fix the error path in dpaa2_switch_rx()
      dpaa2-switch: fix handling of NAPI on the remove path

Itai Handler (1):
      spi: spi-zynqmp-gqspi: stop the controller on shutdown

Ivy Lopez (1):
      scsi: mpt3sas: Avoid out-of-bounds cpumask_of_node() call in _base_assign_reply_queues()

Iván Ezequiel Rodriguez (2):
      Input: evdev - zero absinfo before partial copy in EVIOCSABS
      Input: zero ff_effect before compat copy in input_ff_effect_from_user

Jacob Moroni (1):
      RDMA/irdma: Enforce local fence for IB_WR_REG_MR

Jad Keskes (1):
      EDAC/device_sysfs: Use kstrtouint() for poll_msec to prevent truncation

Jakub Kicinski (4):
      net: dsa: bcm_sf2: bound the CFP rule dump by the caller's buffer size
      net: dsa: mv88e6xxx: bound the policy rule dump by the caller's buffer size
      veth: manage XDP program pointers during channel resize
      net: tls: fix silent data drop under pipe back-pressure

Jamal Hadi Salim (9):
      net: cap tx_queue_len at S16_MAX to prevent oversized ring allocations
      net/sched: fq_pie: clamp quantum in change path
      net/sched: sfq: clamp quantum in change path
      net/sched: hhf: clamp quantum in change and init paths
      net/sched: pie: clamp psched_mtu in pie_drop_early
      net/sched: drr: clamp quantum in change class
      net/sched: ets: clamp quantum in parse and fallback paths
      net/sched: hhf: cap hh_flows_limit at change time
      net/sched: sch_hfsc: bound the classify inner-filter walk with a drift budget

James Clark (1):
      perf test: Change all remaining #!/bin/sh to #!/bin/bash

James Hilliard (1):
      watchdog: sunxi_wdt: preserve boot-enabled watchdog

James Nugraha (1):
      net: amd-xgbe: discard rx packets with bad FCS

Jan Volckaert (1):
      net: usb: qmi_wwan: add MeiG SRM813Q

Jann Horn (1):
      exec: do_close_on_exec() before taking exec_update_lock

Jarkko Sakkinen (1):
      KEYS: trusted: Fix tpm2_load_cmd() boundary check

Jason Gunthorpe (1):
      RDMA/umem: Be careful about boundary conditions in ib_umem_find_best_pgsz()

Jason Winter (1):
      net: usb: cx82310_eth: drop URB after 0xffff reboot sentinel to prevent partial_data heap overflow

Jean-Louis Colaco (1):
      ALSA: usb-audio: Add quirk for YAMAHA CDS3000

Jeffin Philip (1):
      RDMA/core: fix refcount bug in iwpm_get_nlmsg_request()

Jens Axboe (1):
      sunvdc: fix -EIO issue due to lack of retries

Jeremy Klarenbeek (1):
      drm/amd/pm/si: Fix updating clock limits from power states

Jeremy Nyberg (1):
      Input: xpad - fix PDP Marvel Xbox 360 controller

Jia Jia (2):
      vhost-scsi: flush backend after device ioctls
      virtio_console: do not free control-out buffers on remove

Jiajia Liu (1):
      wifi: mt76: transform aspm_conf for pci_disable_link_state

Jiale Yao (1):
      Bluetooth: RFCOMM: validate skb length in rfcomm_recv_frame

Jiangshan Yi (2):
      wifi: brcmsmac: fix UAF in brcms_free_timer()
      wifi: libertas_tf: fix UAF in lbtf_free_adapter()

Jiayuan Chen (5):
      rds: annotate data-race around rs_seen_congestion
      bpf: Fix NULL-ptr-deref when showing a void BTF type
      bpf: Fix NULL-ptr-deref in btf_var_show()
      bpf: Fix divide-by-zero in btf_struct_walk()
      bpf: Fix out-of-bounds read of rtt_min in sock_ops

Jinjie Ruan (1):
      spi: zynqmp-gqspi: Use devm_spi_alloc_host()

Jiri Slaby (1):
      tty: make tty_ldisc_ops::hangup return void

Joas Antonio dos Santos (1):
      netfilter: nf_conntrack_sip: fix OOB read in sip_skip_whitespace()

Joe Damato (2):
      bnxt_en: Handle buffer allocation failure in bnxt_rx_ring_reset()
      bnxt_en: Propagate RX ring init failures in bnxt_init_nic()

Johan Hovold (1):
      net: hso: fix TIOCMIWAIT race

Johannes Berg (8):
      wifi: mac80211: always allow transmitting null-data on TXQs
      wifi: cfg80211: check IP header size in cfg80211_classify8021d()
      wifi: cfg80211: only group hidden BSSes with beacon entries
      wifi: cfg80211: don't filter by BSS type when removing stale entries
      wifi: mac80211: suppress chanctx warning for debugfs reset
      wifi: mac80211: reset the AP_VLAN tailroom counter on ifdown
      wifi: mac80211: don't RCU-dereference the mesh CSA settings we just set
      wifi: mac80211: don't access the TSF of a down interface

Joonwon Kang (1):
      mailbox: Make mbox_send_message() return error code when tx fails

Jose Fernandez (Anthropic) (1):
      bpf: Avoid soft lockup in __htab_map_lookup_and_delete_batch()

Jose Ignacio Tornos Martinez (1):
      PCI: Avoid SBR for Qualcomm WCN6855/WCN7850 WiFi, SDX62/SDX65 modems

Josef Bacik (1):
      writeback: report a Tasks-RCU quiescent state per cgwb drain pass

Joseph Qi (1):
      ocfs2: make ocfs2_calc_xattr_init() return void

Jozsef Kadlecsik (1):
      netfilter: ipset: mark the rcu locked areas properly

Juan Perdomo (1):
      Bluetooth: RFCOMM: avoid socket lock inversion in listener cleanup

Julian Anastasov (1):
      ipvs: revalidate ihl before icmp_send

Junjie Cao (1):
      HID: quirks: add ALWAYS_POLL quirk for SDINNOVATION gaming keyboard

Junli Liu (1):
      erofs: fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC

Junrui Luo (4):
      drm/virtio: fix object leak when drm_gem_handle_create() fails
      drm/virtio: fix object leak in virtio_gpu_resource_create_ioctl()
      drm/virtio: fix object leaks in virtio_gpu_resource_create_blob_ioctl()
      drm/virtio: release the GEM object on virtio_gpu_vram_create() errors

Jérémy Jean (3):
      RDMA/siw: Bound fragmented header copies by the remaining length
      netfilter: flowtable: publish HW_DEAD after worker is done
      net: gue: reject invalid REMCSUM offsets

Kamal Wadhwa (1):
      regulator: core: clamp voltage constraints before applying apply_uV

KangNing Liao (1):
      btrfs: protect sb_write_pointer() with invalidate lock

Karl Mehltretter (5):
      keys: fix lost wakeup when reaping a dead key type
      Input: trackpoint - fix the inertia attribute name in the ABI document
      wifi: brcmfmac: fix lost 802.1x TX completion wakeup
      s390/pci/docs: Fix sriov_numvfs attribute name
      netfilter: nft_synproxy: use the family-aware checksum helper

Karsten Graul (1):
      net/smc: stop links when their GID is removed

Kazuki Hanai (1):
      ALSA: us122l: Prevent write upgrades for read mappings

Kent Overstreet (1):
      lockdep: Add lock_set_cmp_fn() annotation

Kory Maincent (1):
      hwmon: (adt7462) Add of_match_table to support devicetree

Krzysztof Wilczyński (1):
      PCI/sysfs: Use kstrtobool() to parse the ROM attribute input

Kumar Kartikeya Dwivedi (1):
      bpf: Restrict CO-RE poisoning to relocatable instructions

Kumar Meiyappan (2):
      scsi: pm8001: Reject firmware update in fatal error state
      scsi: pm8001: Reject non-fatal dump when controller is crashed

Kuniyuki Iwashima (4):
      af_packet: Don't cast tpacket_hdr.tp_len to int in tpacket_parse_header().
      net/sched: cls_api: Don't replay RTM_GETCHAIN in tc_ctl_chain().
      tcp: Don't call skb_clone_and_charge_r() for close()d listener in tcp_v6_do_rcv().
      ip6_gre: Call ip6erspan_tunnel_unlink_md() in ip6erspan_changelink().

Kyle Zeng (3):
      ipvs: fix reversed sequence option serialization
      ipvs: reject invalid states in connection template sync records
      xfrm: fix compat ALLOCSPI request use-after-free

Lad Prabhakar (2):
      mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC
      mmc: renesas_sdhi: Add OF entry for RZ/G2E SoC

Lai Jiangshan (3):
      KVM: X86: Remove useless code to set role.gpte_is_8_bytes when role.direct
      KVM: X86: Calculate quadrant when !role.gpte_is_8_bytes
      KVM: X86: Rename gpte_is_8_bytes to has_4_byte_gpte and invert the direction

Lama Kayal (1):
      net/mlx5: E-Switch, prevent mc_list repopulation during vport disable

Lee Jones (1):
      nfc: llcp: Fix race condition in accept_queue lifecycle

Lei Zhu (1):
      selftests: nci: Correct pthread_create return value check

Leo Yan (1):
      perf/core: Skip empty AUX records with only format flags

Leonardo Bras (1):
      arm64/daifflags: Make local_daif_*() helpers __always_inline

Li Qiang (1):
      cifs: validate idmap key payload length

Li RongQing (2):
      RDMA/mlx5: Fix state and counter desync on loopback enable failure
      RDMA/mad: Fix receive buffer leak when PKey enforcement fails

Li Youhong (1):
      net: sun4i-emac: fix missing of_node_put() for phy_node

Liang Hao (1):
      gpio: dwapb: Mask interrupts at hardware initialization

Linfeng Sun (1):
      vdpa_sim_blk: reject out-of-range sector starts

Linus Torvalds (1):
      eventpoll: don't decrement ep refcount while still holding the ep mutex

Linus Walleij (18):
      ASoC: ab8500: Reset the audio block before configuring it
      ASoC: ab8500: Repair the DAPM capture graph
      ASoC: ab8500: Correct digital interface format setup
      ASoC: ab8500: Validate and program TDM slots correctly
      ASoC: ux500: Fix MSP stream lifecycle handling
      ASoC: ux500: Propagate MSP setup errors
      ASoC: ux500: Correct MSP frame and bit clock setup
      ASoC: ux500: Validate MSP DAI configuration
      ASoC: ux500: Request the MSP MMIO resource
      ASoC: ux500: Program the MSP FIFO watermarks
      net: ethernet: cortina: Fix budget accounting
      net: ethernet: cortina: Finish RX updates before NAPI completion
      net: ethernet: cortina: Count dropped frames as NAPI work
      net: ethernet: cortina: No mapping is a dropped rx
      net: ethernet: cortina: Count RX drops once per frame
      net: ethernet: cortina: Count RX descriptors for freeq refill
      net/rds: Pass a pointer to virt_to_page()
      net: ethernet: cortina: Ack RX overrun interrupt correctly

Lorenzo Bianconi (2):
      net: stmmac: reconfigure RX packet parser table in stmmac_hw_setup() after reset
      net: stmmac: initialize ptp_lock at probe time

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix deadlock

Lukas Wunner (2):
      PCI: Stop setting cached power state to 'unknown' on unbind
      crypto: ecc - Unbreak the build on arm with CONFIG_KASAN_STACK=y

Luxiao Xu (2):
      netfilter: ip6t_rt: fix zero-address non-strict match out-of-bounds read
      nfc: fix use-after-free in nfc_get_local_general_bytes

Madhavender Singh (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Laptop 14s-dr1xxx

Maoyi Xie (3):
      rds: filter RDS_INFO_* getsockopt by caller's netns
      hsr: broadcast netlink notifications in the device's net namespace
      keys: translate request_key_auth pid for the reading procfs instance

Marco Elver (1):
      kcsan: Silence -Wmaybe-uninitialized when calling __kcsan_check_access()

Marco Felsch (1):
      serial: 8250: fix possible ISR soft lockup

Marek Behún (3):
      net: dsa: mv88e6xxx: fix number of g1 interrupts for 6320 family
      net: dsa: mv88e6xxx: define .pot_clear() for 6321
      net: dsa: mv88e6xxx: enable .rmu_disable() for 6320 family

Mariano Baragiola (1):
      wifi: virt_wifi: free skb when disconnected

Mario Limonciello (1):
      x86/PCI: Disable enhanced atomics on AMD NBIO 7.7 and 7.11

Mark Amirkan (2):
      net/packet: clear RX owner on VNET header error
      net/packet: avoid truncating TPACKET_V3 private size

Mark Brown (1):
      ASoC: ab8500: Update to modern clocking terminology

Mark Rutland (2):
      arm64: percpu: Fix this_cpu_write() casting
      arm64: percpu: Fix this_cpu_and() mask generation

Mathias Nyman (1):
      xhci: Prevent queuing new commands if xhci is inaccessible

Matthew Bystrin (1):
      mfd: rsmu: Add 8a34002 support

Matthieu Baerts (NGI0) (2):
      mptcp: options: handle MPC data + csum reqd + no csum
      mptcp: syncookies: remember the request backup flag

Maurizio Lombardi (1):
      scsi: target: iscsi: Fix hang for aborted WRITE_PENDING commands

Max Gurtovoy (4):
      IB/iser: Align coding style across driver
      IB/iser: Remove iser_reg_data_sg helper function
      IB/iser: Use iser_fr_desc as registration context
      scsi: target: iscsi: Rename iscsi_cmd to iscsit_cmd

Maxime Chevallier (4):
      net: stmmac: selftests: Support running selftests on DSA conduits
      net: stmmac: selftests: Check the dev->features for S-TAG offload testing
      net: stmmac: selftests: Capture all packets for vlan checks
      net: stmmac: dwmac4: Use the correct bufzise when the len is exactly 8K

Michael Bommarito (2):
      media: hevc: add bounded tile-count helpers
      media: v4l2-ctrls: validate HEVC tile counts

Michael Walle (1):
      clk: keystone: don't cache clock rate

Michal Swiatkowski (1):
      ice: pass the return value of skb_checksum_help()

Mika Westerberg (3):
      thunderbolt: Release request if tb_cfg_request() fails in __tb_xdomain_response()
      thunderbolt: Keep the domain reference while processing hotplug
      thunderbolt: Set tb->root_switch to NULL when domain is stopped

Mikhail Zaslonko (2):
      s390/debug: Do not register views for failed static debug areas
      s390/debug: Fix NULL pointer dereference in debug_info_copy()

Ming Wang (1):
      net: usb: cdc_mbim: add MeiG Smart SRM821 to ZLP whitelist

Minhong He (1):
      phonet: check register_netdevice_notifier() error in phonet_device_init()

Miri Korenblit (1):
      wifi: mac80211: don't call ieee80211_handle_reconfig_failure when not needed

Mostafa Saleh (1):
      irqchip/gic-v4: Don't advertise VLPIs if no ITS is probed

Myeonghun Pak (3):
      mmc: sdhci-of-aspeed: Remove children before releasing SDC resources
      tg3: clean up PHYLIB resources on probe failure
      pinctrl: single: free the IRQ on domain creation failure

Nagamani PV (1):
      s390/qeth: allow bridgeport queries despite OS_MISMATCH

Namjae Jeon (10):
      ksmbd: use connection ClientGUID for lease lookup
      ksmbd: treat unnamed DATA stream as base file
      ksmbd: apply create security descriptor first
      ksmbd: break RH leases before delete-on-close
      ksmbd: fix credit charge calculation for SMB2 QUERY_INFO
      ksmbd: find bound sessions during reauthentication
      ksmbd: mark invalid session responses as signed
      ksmbd: validate SID namespace before mapping IDs
      ksmbd: rate limit unmapped SID errors
      ksmbd: prevent out-of-bounds reads in share config responses

Nazim Amirul (1):
      net: stmmac: xgmac2: disable RBUE in default RX interrupt mask

Nguyen Ngoc Thang (2):
      ALSA: pcm: set timer->private_data before registering the PCM timer
      net/sched: act_ct: don't WARN on benign flow_offload_alloc() failure

Nicolas Thibert (1):
      Bluetooth: btusb: fix NXP IW610 composite device handling

Niklas Cassel (1):
      ata: libahci: clear PxCLBU and PxFBU for AHCI_HFLAG_32BIT_ONLY

Niklas Schnelle (1):
      docs: s390/pci: Improve and update PCI documentation

Nikolay Metchev (1):
      platform/x86: intel-hid: Add HP ProBook x360 440 G1 to button_array_table

Nitesh Narayan Lal (1):
      scsi: mpt3sas: Use irq_set_affinity_and_hint()

Norbert Szetei (3):
      net: openvswitch: fix use-after-free of the flow table mask array
      net: xps: reject an out of range traffic class
      ipv6: do not let ipv6_find_hdr() return an offset past the packet end

Nuno Sá (1):
      hwmon: (pmbus/core) increase number of phases and add new mask

Oliver Neukum (1):
      usb: core: hcd: fix possible deadlock in rh control transfers

Orgad Shaneh (1):
      MIPS: Octeon: apply USB FDT fixups also when USB is modular

Osama Abdelkader (1):
      mmc: davinci: fix mmc_add_host order in probe

Oscar Priego Verdugo (1):
      HID: elecom: fix bus type for M-XGL20DLBK

Pablo Neira Ayuso (3):
      netfilter: flowtable: hold reference on ct until flow is released
      rculist: add list_splice_rcu() for private lists
      netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase

Paolo Abeni (2):
      mptcp: avoid unneeded actions on subflow reset
      mptcp: close race between scheduler and state change

Paolo Bonzini (3):
      KVM: MMU: update comment on the number of page role combinations
      KVM: x86/mmu: pull call to drop_large_spte() into __link_shadow_page()
      KVM: x86: Fix shadow paging use-after-free due to unexpected role

Pauli Virtanen (2):
      Bluetooth: L2CAP: fix chan mode for LE_CONN_REQ + EXT_FLOWCTL pchan
      Bluetooth: L2CAP: clear FLAG_DEFER_SETUP only for same PID/PSM

Pavankumar Kondeti (1):
      workqueue: Fix NULL current_pwq deref in flush dependency check

Peiyang He (2):
      drm/nouveau: fix double-free in nvif_vmm_dtor
      drm/nouveau: don't bump pin count on failed re-pin in nouveau_bo_pin_locked()

Peng Hao (1):
      wifi: mwifiex: fix IRQ leak using wrong index in MSI-X error path

Pengpeng Hou (14):
      soundwire: validate DT compatible before parsing it
      ALSA: usb-audio: caiaq: validate EP1 reply lengths
      wifi: rsi: avoid reading TKIP MIC keys for non-TKIP ciphers
      wifi: libertas: reject short monitor TX frames
      wifi: libipw: fix key index receive bound checks
      wifi: rsi: validate beacon length before fixed buffer copy
      drm/gma500: return errors from Oaktrail HDMI I2C reads
      hwmon: (aspeed-pwm-tacho) Propagate reset deassert errors
      ARM: socfpga: select the PL310 erratum 753970 workaround
      wifi: mwifiex: validate scan response extents
      net: usb: sr9700: include receive overhead in the length check
      nfc: nfcmrvl: validate helper command length before pull
      nfc: st21nfca: validate received frame size
      nfc: st21nfca: validate ISO15693 inventory length

Pierre Barre (1):
      9p: invalidate readdir buffer on seek

Potin Lai (1):
      hwmon: (pmbus/lm25066) Fix PMBus coefficients for LM5064/5066/5066i

Pu Hu (1):
      arm64: kprobes: Allow reentering kprobes while single-stepping

Qiang Liu (3):
      ksmbd: fix sd_ndr.data memory leak in ksmbd_vfs_set_sd_xattr
      ksmbd: fix n.data memory leak in ksmbd_vfs_set_dos_attrib_xattr
      ksmbd: Fix acl.sd_buf memory leak and invalid sd_size error handling

Qingfang Deng (2):
      ppp: ppp_async: simplify tty disc_data access
      ppp_synctty: ensure a writeable skb header

Qiuxu Zhuo (3):
      EDAC/igen6: Fix interleave boundary condition
      EDAC/igen6: Fix channel selection hash
      EDAC/igen6: Fix channel address decode for non-hash mode

Qu Wenruo (1):
      btrfs: do not force reloc root creation during qgroup_account_snapshot()

Quanye Yang (2):
      RDMA/rtrs-clt: Fix CQ pool leak when connect is interrupted
      RDMA/ucma: Serialize join and leave on copy_to_user failure

Raf Dickson (1):
      vsock: use sk_acceptq_is_full() helper in all transports

Ran Hongyun (1):
      squashfs: Add dictionary size range check to prevent shift-out-of-bounds

Randy Dunlap (1):
      Documentation: s390: correct spelling

Raphaël Larocque (1):
      Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)

Ratheesh Kannoth (1):
      octeontx2-af: fix PF/CGX debugfs PCI bus lookup

Rengarajan S (2):
      lan78xx: Enable 125 MHz CLK configuration for LAN7801 if NO EEPROM is detected
      lan78xx: Enable Auto Speed and Auto Duplex configuration for LAN7801 if NO EEPROM is detected

Riccardo Boninsegna (1):
      media: rc: mceusb: Add support for 04eb:e033

Ridham Khurana (1):
      gpio: zynq: fix runtime PM leak on request error path

Rik van Riel (2):
      perf/ftrace: Fix WARNING in __unregister_ftrace_function
      wifi: mac80211: avoid WARN in set_bitrate_mask when sdata not in driver

Rob Herring (Arm) (1):
      gpio: pisosr: Read "ngpios" as u32

Robert Abrahamse (1):
      ALSA: usb-audio: Add quirk for Corsair Virtuoso (later revision)

Roberts Kursitis (1):
      Input: xpad - add support for Azeron devices

Roman Prucha (1):
      ALSA: ctxfi: Fix CA20K2 S/PDIF passthrough

Rosen Penev (7):
      mips: cps: Assemble jr.hb with an R2 ISA level
      net: ibm: emac: Reserve VLAN header in MJS limit
      ipmi: si: Use platform_get_irq_optional() to retrieve interrupt
      netfilter: nf_conntrack: use get_unaligned_be32() in tcp_sack()
      net: ibm: emac: mal: fix potential system hang in mal_remove()
      sparc64: uprobes: add missing break
      sparc: Disable compat support with LLD

Rudi Heitbaum (1):
      ASoC: rt5645: Perform the initial jack detect at probe

Runyu Xiao (5):
      net: au1000: move free_irq out of the close-time spinlocked section
      ASoC: sti: initialize IRQ lock before requesting IRQ
      cpufreq: initialize policy rwsem before sysfs publication
      mmc: sh_mmcif: initialize IRQ-thread mutex before requesting interrupt
      wifi: wlcore: release runtime PM ref on regdomain config failure

Ruoyu Wang (3):
      crypto: ixp4xx - fix buffer chain unwind on allocation failure
      ALSA: es18xx: check control allocation before private data setup
      dmaengine: sprd: Fix runtime PM reference leak in probe

Russell King (Oracle) (3):
      ARM: fix hash_name() fault
      ARM: fix branch predictor hardening
      ARM: ensure interrupts are enabled in __do_user_fault()

SJ Park (1):
      mm/damon/core: avoid infinite kdamond_merge_regions() internal loop

Sabrina Dubroca (5):
      xfrm: propagate extack to all netlink doit handlers
      xfrm: add extack to verify_sec_ctx_len
      xfrm: add extack support to verify_newsa_info
      xfrm: add extack to verify_one_alg, verify_auth_trunc, verify_aead
      xfrm: avoid RCU warnings around the per-netns netlink socket

Sajal Gupta (1):
      drm/gud: fix out-of-bounds write in gud_plane_atomic_check()

Samuel Moelius (2):
      Bluetooth: L2CAP: validate connectionless PSM length
      f2fs: validate inline dentry name lengths before conversion

Sandeep Dhavale (1):
      erofs: Fix detection of atomic context

Sanjay Chitroda (1):
      iio: accel: mma8452: switch to non-devm request_threaded_irq()

Sanman Pradhan (2):
      hwmon: (pmbus/tps53679) Fix TPS53676 phase page decoding
      hwmon: (pmbus/tps53679) Select page 0 for single-page TPS53676

Sasha Levin (14):
      Revert "Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU"
      Revert "Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU"
      Revert "scsi: smartpqi: Fix AIO retry marker cleared by SCSI core between dispatches."
      Revert "scsi: smartpqi: Stop using the SCSI pointer"
      Revert "scsi: smartpqi: Fix BUILD_BUG_ON() statements"
      Revert "scsi: smartpqi: Switch to attribute groups"
      Revert "scsi: core: Register sysfs attributes earlier"
      Revert "scsi: smartpqi: Capture controller reason codes"
      Revert "perf tests: Fix flakiness in BPF counters test on hybrid systems"
      Revert "alpha: don't leak hardware-fabricated FP exception bits to user space"
      Revert "alpha: fix ieee_swcr_to_fpcr setting FPCR_DNOD unconditionally"
      Revert "perf cs-etm: Avoid truncating AUX buffer sizes to int"
      Revert "perf cs-etm: Flush thread stacks after decoder reset"
      ASoC: ux500: Parenthesize MSP_{RX,TX}_CLKPOL_BIT() arguments

Scott Mitchell (1):
      netfilter: nfnetlink_queue: nfqnl_instance GFP_ATOMIC -> GFP_KERNEL_ACCOUNT allocation

Sean Christopherson (2):
      KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
      KVM: x86/mmu: WARN and clear role.invalid when creating a child shadow page

Seungwon Bae (1):
      vxlan: reject dynamic fdb entries that reference a nexthop id

Shahar Shitrit (1):
      net/mlx5e: Fix setting RS FEC after remapping

Shawn Lin (1):
      mmc: core: Add validation for host-provided max_segs

Shengzhuo Wei (4):
      i2c: at91: release DMA channels on remove and probe error
      i2c: imx: release DMA channels on probe error
      wifi: p54: validate curve data length in the calibration curve converters
      wifi: p54: require a full exp_if record in PDR_INTERFACE_LIST

Shihuang Liu (1):
      net: skbuff: fix pull-bound underflow in skb_checksum_setup_ipv6()

Shivank Garg (3):
      dmaengine: Fix device kref underflow in dma_chan_put()
      dmaengine: fix use-after-free in dma_chan_put() and dma_release_channel()
      dmaengine: wait for RCU readers before releasing dma_device

Shivaprasad G Bhat (2):
      powerpc/eeh: Fix recursive locking on devices without EEH sensitive driver
      powerpc/iommu: Fix the overflow validation in iommu_tce_check_ioba

Shmulik Cohen (2):
      wifi: libipw: reject too-short beacon and probe responses
      wifi: libipw: reject too-short association responses

Shuangpeng Bai (1):
      IB/mlx4: Fix use-after-free on pkey sysfs registration failure

Sidraya Jayagond (1):
      net/smc: fix UAF on lgr list traversal in smcr_port_err()

Simon Xue (1):
      iommu/rockchip: disable fetch dte time limit

Slavin Liu (1):
      ALSA: hda: trace PCM open only after assigning a stream

Slawomir Stepien (1):
      HID: amd_sfh: Validate PCI BAR size before mapping

Sophie D (1):
      drm/gud: Add RCade Display Adapter VID/PID pair

Stanislaw Gruszka (1):
      wifi: iwlegacy: fix broadcast stations deallocation

Stefan Berger (1):
      integrity: Check for NULL returned by asymmetric_key_public_key

Stefano Garzarella (2):
      vdpa_sim_blk: use dev_dbg() to print errors
      vdpa_sim_blk: make vdpasim_blk_check_range usable by other requests

Stepan Ionichev (3):
      mmc: davinci: avoid NULL deref of host->data in IRQ handler
      usb: gadget: goku_udc: avoid NULL deref of dev->driver in INT_USBRESET log
      iio: adc: qcom-spmi-iadc: balance enable_irq_wake() on driver unbind

Stephen Dolan (1):
      x86/mm: Fix check/use ordering in switch_mm_irqs_off()

Stian Halseth (1):
      sunvdc: unmap LDC cookies when the descriptor send fails

Sudeep Holla (2):
      firmware: arm_scmi: Validate SENSOR_UPDATE payload size
      firmware: arm_scmi: Validate BASE_ERROR_EVENT payload size

Suraj Jitindar Singh (1):
      bpftool: remove duplicate free_btf_vmlinux() definition

Sven Schnelle (1):
      selftests/ftrace: Fix unique symbol check in kprobe_non_uniq_symbol.tc

Takashi Iwai (1):
      ALSA: caiaq: Fix potential double-free at error path

Tao Cui (1):
      blk-cgroup: fix leaks and online flag on radix_tree_insert failure

Thadeu Lima de Souza Cascardo (1):
      drm: Fix drm_pending_vblank_event leak in error path for out_fence_ptr

Theodor Arsenij Larionov Trichkine (1):
      netfilter: nft_nat: fully initialise new_addr in netmap setup

Thibault Ferrante (1):
      selftests/powerpc/tm: Fix tcheck() reading uninitialised CR value

Thiyagarajan Pandiyan (1):
      wifi: nl80211: Increase ie_len size to prevent truncated IEs in new peer notifications

Thomas Huth (1):
      kselftest/arm64: Fix size of thread_data values for pthread_join()

Thorsten Blum (3):
      crypto: atmel-ecc - add support for atecc608b
      powerpc/kexec_file: Use inclusive range checks in add_usable_mem()
      drm/i915: Fix memory leak in query_perf_config_list()

Tianchu Chen (3):
      ASoC: sprd: validate compress buffer sizes against fixed allocations
      wifi: rsi: fix heap OOB write on key removal
      wifi: wilc1000: fix RX buffer OOB-write in wilc_wlan_handle_isr_ext()

Timur Kristóf (1):
      drm/amd/pm/si: Don't schedule thermal work when queue isn't initialized

Tobias Deiminger (1):
      leds: pca9532: Don't stop blinking for non-zero brightness

Tom Chung (1):
      drm/amd/display: Fix CRC open failure during active rendering

Tommy Huang (1):
      rtc: aspeed: add AST2700 compatible

Tristan Madani (1):
      ALSA: usbusx2y: fix in04_last array size mismatch with in04_buf

Tung Nguyen (1):
      tipc: fix NULL deref in tipc_named_node_up() on empty publication list

Tze Yee Ng (1):
      dmaengine: dw-axi-dmac: fix PM for system sleep and channel alloc

Tzung-Bi Shih (6):
      watchdog: msc313e: Fix NULL pointer dereference in PM callbacks
      watchdog: msc313e: Avoid division by zero
      watchdog: msc313e: Fix clock leak and spurious timer in settimeout()
      Bluetooth: btmtksdio: Fix PM runtime reference leak in shutdown
      watchdog: digicolor: Avoid division by zero
      watchdog: msc313e: Fix premature reset during timeout update

Uwe Küchler (1):
      ALSA: usb-audio: Add quirk for Novation Mininova

Vadim Fedorenko (1):
      ptp: ocp: add shutdown callback

Vaibhav Jain (1):
      powerpc/pseries: Ensure vpa,slb_shadow & dtl are unregistered during crash

Venkat Rao Bagalkote (1):
      char/nvram: Remove redundant nvram_mutex

Viacheslav Dubeyko (3):
      hfsplus: fix issue of direct writes beyond end-of-file
      hfsplus: rework hfsplus_readdir() logic
      hfs: rework hfsplus_readdir() logic

Victor Nogueira (3):
      net/sched: act_api: budget all shared attributes in notify skbs
      net/sched: act_api: size the RTM_GETACTION reply from the actions
      net/sched: cls_route: free emptied bucket on filter move

Vineeth Vijayan (4):
      s390/cio: Purge based on the cdev's online status
      s390/cio: Fix cio_update_schib() to not cache invalid schib
      s390/cio: Check pmcw.dnv before pmcw.ena in I/O entry points
      s390/cio: Fix NULL pointer dereference in ccw_device_get_util_str()

Vishnu Razdan (1):
      hwmon: (pmbus) Clear generic status alarms with CLEAR_FAULTS

Vitaly Kuznetsov (1):
      HID: hyperv: streamline driver probe to avoid devres issues

Vlad Buslov (1):
      netfilter: flowtable: allow unidirectional rules

Vlatko Kosturjak (1):
      ppp_async: drop the errored frame instead of resetting its headroom

Wei Jie LAW (1):
      HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()

Weiming Shi (8):
      ACPICA: Fix NULL pointer dereference in acpi_ns_custom_package()
      btrfs: tree-checker: validate INODE_REF's namelen
      fbdev: vfb: defer cleanup until the last reference
      i2c: smbus: reject oversized block transfers in the common path
      net: appletalk: fix NULL pointer dereference in aarp_send_ddp()
      bpf: Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL
      net/sched: reject IDR error pointers when deleting actions
      netfilter: ip6t_rpfilter: reject routes without inet6_dev

WenTao Liang (1):
      drm/amd/display: set new_stream to NULL after release

Wentao Liang (8):
      net: qrtr: fix node refcount leak on ctrl packet alloc failure
      watchdog: sp5100_tco: Fix pci_dev reference leak in sp5100_tco_init()
      fsl/fman: Fix clk reference leak in read_dts_node()
      gpio: arizona: Fix runtime PM leak in arizona_gpio_direction_out()
      drm/nouveau: Fix bridge reference leak in nv1a_ram_new()
      drm/nouveau: Fix gem reference leak in validate_init()
      net/mlx5: Fix rev_entry reference leak in mlx5_tc_ct_shared_counter_get()
      net: hisilicon: hns_dsaf_mac: fix mdio device leak in hns_mac_register_phy()

Wyatt Feng (1):
      net: xfrm: reject unrepresentable espintcp transport headers

Xianting Tian (1):
      virtio-console: call scheduler when we free unused buffs

Xie Yuanbin (1):
      ARM: 9484/1: enable interrupts when unhandled user faults are triggered

Xin Long (2):
      sctp: fix a TOCTOU race in SCTP_CMD_TIMER_START
      sctp: hold asoc or transport before mod_timer() in timer handlers

Xixin Liu (3):
      nvme-rdma: fix -EIO cleanup order in queue_rq
      firmware: arm_scpi: reject DVFS OPP count above MAX_DVFS_OPPS
      clk: scpi: bound-check DVFS index in scpi_dvfs_recalc_rate

Xu Rao (2):
      ata: libata-pmp: add JMicron JMS562 quirk
      mmc: spi: reset bytes_xfered before retrying CRC failures

Xuanqiang Luo (2):
      fou: Fix use-after-free in fou_create()
      ip_gre: Reject enabling collect metadata through changelink

Yael Chemla (1):
      net/mlx5: E-Switch: fix use-after-free in mlx5_eswitch_termtbl_put

Yannick Vignon (1):
      net: stmmac: optimize locking around PTP clock reads

Yehyeong Lee (3):
      IB/iser: reject a remote invalidation of an unregistered direction
      IB/isert: wait for deferred control PDU completions before releasing the connection
      scsi: libiscsi_tcp: Check the data direction of a Data-In PDU

Yige Jiang (1):
      net: netsec: fix device_node reference leak on phy_np

Yilin Zhang (2):
      ALSA: pcm: Serialize PCM mmap with buffer reallocation to fix page UAF
      tcp: fix use-after-free of retransmit_skb_hint in tcp_send_synack()

Yiqi Sun (1):
      sctp: avoid livelock while updating retransmit path

Yonghong Song (1):
      libbpf: Fix an error in 64bit relocation value computation

Yousef Alhouseen (3):
      leds: uleds: Return -EFAULT on copy_to_user() failure
      xen/front-pgdir-shbuf: free grant reference head on errors
      xen/gntalloc: validate grant count before allocation

Yu Kuai (1):
      md/raid5: account discard IO

Yu Peng (1):
      arm64: fixmap: Allow 256K early_ioremap() at any offset

Yu Zhang (1):
      vhost-vdpa: don't install the eventfd_ctx_fdget() error in config_ctx

Yuho Choi (1):
      sctp: Unwind address notifier registration on failure

Yury Norov (1):
      bitfield: wire __bf_shf to __builtin_ctzll

Zhang Tianci (1):
      fuse: set ff->flock only on success

Zhao Gongyi (1):
      bpf, sockmap: Reject max_entries > INT_MAX in sock_map_alloc

Zhao Li (3):
      wifi: mac80211: validate deauth frame length before reason access
      wifi: cfg80211: validate rx/tx MLME callback frame lengths before access
      wifi: mwifiex: validate action frame fixed fields

Zhaoyang Yu (1):
      media: dm1105: fix missing error check for dma_alloc_coherent

ZhengYuan Huang (3):
      fs/ntfs3: preserve non-DOS attribute bits in system.dos_attrib
      fs/ntfs3: validate index entry key bounds
      btrfs: balance: fix potential bg lookup failure in btrfs_may_alloc_data_chunk()

Zhiling Zou (4):
      ieee802154: 6lowpan: fix NULL dereference in lowpan_newlink
      openvswitch: avoid reallocating confirmed conntrack labels
      ipv6: xfrm: use full sockets in local error paths
      xsk: Use a 32-bit compare in xsk_map_gen_lookup

Zhongqiu Han (1):
      cpufreq: zero-initialize policy cpumask before sysfs publication

Zhu Ling (1):
      mmc: core: Fix OF node reference leak on card add failure

Zihan Xi (3):
      ipv6: fix fib6 walker UAF on seq stop
      ipv4: fib: bound automatic table ID allocation
      wifi: virt_wifi: don't transfer operstate before register

Zijie Huang (1):
      net: arp: terminate device name before lookup

Zixuan Chai (1):
      llc: reserve device headroom for allocated frames

bui duc phuc (4):
      ASoC: rockchip: rockchip_pdm: Handle runtime PM resume failures in set_fmt
      ASoC: rockchip: rockchip_pdm: Reorder clock enable sequence
      ASoC: rockchip: spdif: Restore regcache cache-only mode on sync failure
      net: ethernet: ti: netcp: fix pm_runtime usage counter leak on error

guoqi0226 (1):
      spi: Add NULL check for spi_get_device_id() in spi_get_device_match_data()

hackyzh002 (1):
      drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1

hpp.iscas (4):
      ASoC: bcm: bcm63xx: Publish the OF module aliases
      ASoC: Intel: SST: Publish the PCI module aliases
      ASoC: mt6351: Publish the OF module alias
      Input: eeti_ts - publish the OF module alias

ikaros (12):
      ACPICA: Fix condition check in acpi_ps_parse_loop()
      ACPICA: Fix use-after-free in acpi_ds_terminate_control_method()
      ACPICA: add boundary checks in acpi_ps_get_next_field()
      ACPICA: validate byte_count in acpi_ps_get_next_package_length()
      ACPICA: Prevent adding invalid references
      ACPICA: Fix integer overflow in acpi_ex_opcode_3A_1T_1R() (mid_op)
      ACPICA: Improve argument parsing in acpi_ps_get_next_simple_arg()
      ACPICA: validate handler object type in two places
      ACPICA: Add package limit checks in parser functions
      ACPICA: Add validation for node in acpi_ns_build_normalized_path()
      ACPICA: Enhance buffer validation in acpi_ut_walk_aml_resources()
      ACPICA: add boundary checks in two places

leixiang (1):
      KVM: PPC: Book3S HV: Set irqfd->producer only on success

liyouhong (1):
      ata: ahci: fail probe if BAR too small for claimed ports

shayderrr (1):
      host1x: bus: Fix missing ops null check in error teardown

wangdicheng (1):
      ASoC: amd: renoir: fix disable_pdm_interrupts() to clear mask bits

Ömer Mete Kaya (3):
      nfc: llcp: fix -ENOMEM on connect with zero-length service name
      nfc: llcp: fix WKS SAP hijacking via prefix match in nfc_llcp_wks_sap()
      nfc: llcp: fix slab-out-of-bounds reads when logging service names

