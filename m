Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36322376A0D;
	Fri, 25 Sep 2026 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347568; cv=none; b=fuOKCPLVy7N3VVsqX3YeMp9raptF1IZy1rbHgxmoIZe/ZgGOsGWRSpuo16eycX3vJNrhaH9ouDWdTLB2rFKvNLROxyjmlv9gzwJ+a3PAgwt/23C8um3EuqzjEZOa3FqE4Iv32FiI8OCCog5fopS8GXpNO2T5Z6k0dP2sWsLyZUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347568; c=relaxed/simple;
	bh=44M77p5VoLB6rf+UUDORwTU/4lWM7IefKk9p7FWwQ1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AcPyEeDb+IXoYgtUWcO97m75qswIVtcQH7YuX2bDfUQBxwfXdT6lNDe72ZCGk3IzVVgPZLEjvVRGpOijeO1Et5UBAuzUFwjPLlNo8SshWPlPzYTtlzLs0JWstMVLhvOp0bikjNa3OnXTcSNZWRKC/8QyyAdYj6pl1Sf84nqKSH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nodMDpl6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nodMDpl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C938F1F000FF;
	Fri, 25 Sep 2026 14:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790347563;
	bh=veAv15Qb+4RmRxVdO5yRt8NiTRb0UblWXiG8OtXs6bQ=;
	h=From:To:Cc:Subject:Date;
	b=nodMDpl64nY0b77WNxwZ9WuPkbSXU9oXlD9tFoUGVBnzmhc+Te2HuRpAKjQwN4Wcr
	 8R4QJc24tfZz4k+yGP794mQ0SDYrSQ4QY9sbLoQCei/e1pyLBM6ceVei8TPTgNfLds
	 Wcrr2Z2fXX+ZXw6tvoM2+mw0FU7UrXqskscwSVxk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.54
Date: Fri, 25 Sep 2026 16:45:55 +0200
Message-ID: <2026092556-opulently-lantern-c4b0@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.54 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-platform-trackpoint    |    2 
 Documentation/hwmon/cgbc-hwmon.rst                             |   42 
 Documentation/netlink/specs/rt-neigh.yaml                      |    3 
 Documentation/networking/ip-sysctl.rst                         |    4 
 Makefile                                                       |    2 
 arch/arm/mach-socfpga/Kconfig                                  |    2 
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi                      |    1 
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi                     |   10 
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi                     |   10 
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi                     |   10 
 arch/arm64/include/asm/percpu.h                                |   20 
 arch/arm64/kernel/hibernate-asm.S                              |    2 
 arch/arm64/kernel/hibernate.c                                  |    4 
 arch/mips/cavium-octeon/octeon-platform.c                      |    4 
 arch/powerpc/kernel/iommu.c                                    |    2 
 arch/powerpc/kvm/book3s_hv_nested.c                            |    2 
 arch/powerpc/kvm/book3s_hv_uvmem.c                             |    5 
 arch/x86/Kconfig.cpu                                           |   11 
 arch/x86/Makefile                                              |    5 
 arch/x86/entry/entry_fred.c                                    |   11 
 arch/x86/include/asm/text-patching.h                           |    4 
 arch/x86/kernel/alternative.c                                  |   53 
 arch/x86/kernel/cpu/microcode/intel.c                          |   26 
 arch/x86/kernel/kprobes/core.c                                 |    5 
 drivers/acpi/processor_driver.c                                |    2 
 drivers/ata/libahci.c                                          |   15 
 drivers/ata/libahci_platform.c                                 |    2 
 drivers/block/sunvdc.c                                         |    9 
 drivers/bluetooth/btintel_pcie.c                               |    8 
 drivers/bluetooth/btmtk.c                                      |    7 
 drivers/bluetooth/btmtksdio.c                                  |    4 
 drivers/bluetooth/btqca.c                                      |   37 
 drivers/bluetooth/btusb.c                                      |   17 
 drivers/bluetooth/hci_qca.c                                    |   80 
 drivers/clk/clk-scpi.c                                         |    2 
 drivers/dma/dmaengine.c                                        |   10 
 drivers/dma/mmp_pdma.c                                         |    2 
 drivers/dma/sprd-dma.c                                         |    3 
 drivers/dma/sun6i-dma.c                                        |    9 
 drivers/dma/ti/k3-udma-glue.c                                  |    5 
 drivers/dma/xilinx/xilinx_dma.c                                |   26 
 drivers/firmware/arm_scpi.c                                    |    4 
 drivers/gpio/gpio-virtuser.c                                   |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                     |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c                    |   48 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c                         |    2 
 drivers/gpu/drm/drm_atomic_uapi.c                              |   13 
 drivers/gpu/drm/gud/gud_pipe.c                                 |    7 
 drivers/gpu/drm/msm/adreno/adreno_device.c                     |    2 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                        |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c                     |    1 
 drivers/gpu/drm/msm/dp/dp_display.c                            |   21 
 drivers/gpu/drm/msm/dsi/dsi_host.c                             |   36 
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                            |    8 
 drivers/gpu/drm/msm/msm_drv.c                                  |    2 
 drivers/gpu/drm/msm/msm_gem.h                                  |    3 
 drivers/gpu/drm/msm/msm_gem_vma.c                              |    2 
 drivers/gpu/drm/msm/msm_ringbuffer.c                           |    2 
 drivers/gpu/drm/msm/msm_ringbuffer.h                           |    1 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c         |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c          |    8 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c         |    8 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c          |    3 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h     |    8 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h                |    2 
 drivers/gpu/drm/vc4/vc4_kms.c                                  |    2 
 drivers/gpu/drm/xe/xe_mmio_gem.c                               |   33 
 drivers/gpu/drm/xe/xe_mmio_gem.h                               |    2 
 drivers/gpu/drm/xe/xe_shrinker.c                               |   62 
 drivers/hid/hid-asus.c                                         |   34 
 drivers/hid/hid-logitech-hidpp.c                               |   24 
 drivers/hwmon/cgbc-hwmon.c                                     |  129 
 drivers/hwmon/gpio-fan.c                                       |    4 
 drivers/hwmon/hp-wmi-sensors.c                                 |   32 
 drivers/hwmon/pmbus/pmbus.h                                    |    3 
 drivers/hwmon/pmbus/tps53679.c                                 |   11 
 drivers/hwmon/pwm-fan.c                                        |   13 
 drivers/hwmon/w83791d.c                                        |    1 
 drivers/hwmon/w83793.c                                         |    4 
 drivers/i2c/busses/i2c-at91-core.c                             |    3 
 drivers/i2c/busses/i2c-at91-master.c                           |   12 
 drivers/i2c/busses/i2c-at91.h                                  |    1 
 drivers/i2c/busses/i2c-imx.c                                   |    3 
 drivers/i2c/busses/i2c-qcom-cci.c                              |   20 
 drivers/i2c/i2c-atr.c                                          |    1 
 drivers/infiniband/core/iwpm_util.c                            |    9 
 drivers/infiniband/core/mad.c                                  |    3 
 drivers/infiniband/core/ucma.c                                 |    7 
 drivers/infiniband/core/verbs.c                                |   12 
 drivers/infiniband/hw/bnxt_re/main.c                           |   10 
 drivers/infiniband/hw/efa/efa_com.c                            |    7 
 drivers/infiniband/hw/efa/efa_com.h                            |    1 
 drivers/infiniband/hw/efa/efa_main.c                           |   33 
 drivers/infiniband/hw/hfi1/file_ops.c                          |   23 
 drivers/infiniband/hw/irdma/verbs.c                            |    2 
 drivers/infiniband/hw/mlx4/sysfs.c                             |    4 
 drivers/infiniband/hw/mlx5/main.c                              |    7 
 drivers/infiniband/sw/rxe/rxe_mcast.c                          |   50 
 drivers/infiniband/sw/rxe/rxe_mr.c                             |    3 
 drivers/infiniband/sw/rxe/rxe_odp.c                            |   16 
 drivers/infiniband/sw/rxe/rxe_verbs.c                          |   13 
 drivers/infiniband/sw/siw/siw_cm.c                             |    7 
 drivers/infiniband/sw/siw/siw_qp_rx.c                          |    2 
 drivers/infiniband/ulp/ipoib/ipoib.h                           |    7 
 drivers/infiniband/ulp/ipoib/ipoib_ib.c                        |   12 
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c                 |   16 
 drivers/infiniband/ulp/iser/iser_initiator.c                   |   16 
 drivers/infiniband/ulp/isert/ib_isert.c                        |   22 
 drivers/infiniband/ulp/isert/ib_isert.h                        |    2 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                         |    8 
 drivers/infiniband/ulp/rtrs/rtrs-clt.h                         |    2 
 drivers/input/evdev.c                                          |    2 
 drivers/input/input-compat.c                                   |    2 
 drivers/input/joystick/xpad.c                                  |   10 
 drivers/input/keyboard/adp5588-keys.c                          |   12 
 drivers/input/keyboard/atkbd.c                                 |    8 
 drivers/input/misc/soc_button_array.c                          |   16 
 drivers/input/mouse/synaptics.c                                |    8 
 drivers/input/rmi4/rmi_driver.c                                |   13 
 drivers/input/rmi4/rmi_smbus.c                                 |   10 
 drivers/input/serio/hp_sdc.c                                   |    2 
 drivers/input/serio/i8042-acpipnpio.h                          |    7 
 drivers/input/touchscreen/cyttsp5.c                            |    1 
 drivers/input/touchscreen/eeti_ts.c                            |    1 
 drivers/media/i2c/video-i2c.c                                  |    5 
 drivers/memstick/core/ms_block.c                               |    2 
 drivers/misc/ntsync.c                                          |    6 
 drivers/mmc/core/bus.c                                         |    2 
 drivers/mmc/core/host.c                                        |    1 
 drivers/mmc/core/sdio_uart.c                                   |    3 
 drivers/mmc/host/mmc_hsq.c                                     |    8 
 drivers/mmc/host/mmc_spi.c                                     |    1 
 drivers/mmc/host/mmci.c                                        |    3 
 drivers/mmc/host/mxcmmc.c                                      |    4 
 drivers/mmc/host/rtsx_pci_sdmmc.c                              |    5 
 drivers/mmc/host/sdhci-of-aspeed.c                             |    5 
 drivers/mmc/host/sdhci_am654.c                                 |   43 
 drivers/mmc/host/sh_mmcif.c                                    |    3 
 drivers/net/ethernet/broadcom/Kconfig                          |    1 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                 |  239 -
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                 |    5 
 drivers/net/ethernet/cadence/macb_ptp.c                        |    9 
 drivers/net/ethernet/cortina/gemini.c                          |    2 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                |    3 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c                   |   42 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h                   |    9 
 drivers/net/ethernet/microchip/lan743x_main.c                  |    2 
 drivers/net/ethernet/socionext/netsec.c                        |    2 
 drivers/net/ethernet/stmicro/stmmac/hwif.h                     |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c           |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                |   19 
 drivers/net/fddi/skfp/skfddi.c                                 |    3 
 drivers/net/phy/mediatek/mtk-phy-lib.c                         |   27 
 drivers/net/wireless/ath/ath11k/mac.c                          |   25 
 drivers/net/wireless/ath/wcn36xx/dxe.c                         |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c        |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c    |    5 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c |    4 
 drivers/net/wireless/intel/ipw2x00/Kconfig                     |    1 
 drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c        |  130 
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c                 |    6 
 drivers/net/wireless/intel/iwlegacy/common.c                   |    2 
 drivers/net/wireless/intersil/p54/eeprom.c                     |   22 
 drivers/net/wireless/marvell/libertas_tf/main.c                |    2 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c                |   12 
 drivers/net/wireless/marvell/mwifiex/pcie.c                    |    2 
 drivers/net/wireless/marvell/mwifiex/scan.c                    |   54 
 drivers/net/wireless/marvell/mwifiex/util.c                    |   10 
 drivers/net/wireless/microchip/wilc1000/cfg80211.c             |   14 
 drivers/net/wireless/microchip/wilc1000/wlan.c                 |    9 
 drivers/net/wireless/realtek/rtw88/tx.c                        |    2 
 drivers/net/wireless/rsi/rsi_91x_mgmt.c                        |    2 
 drivers/net/wireless/ti/wlcore/main.c                          |    4 
 drivers/net/wireless/virtual/mac80211_hwsim.c                  |   39 
 drivers/net/wireless/virtual/virt_wifi.c                       |    4 
 drivers/net/wwan/mhi_wwan_mbim.c                               |   28 
 drivers/net/wwan/t7xx/t7xx_netdev.c                            |    4 
 drivers/perf/arm-cmn.c                                         |   10 
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c                     |    4 
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h                     |    3 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                       |  310 +
 drivers/power/sequencing/Kconfig                               |    3 
 drivers/power/sequencing/core.c                                |   11 
 drivers/scsi/fnic/fdls_disc.c                                  |  730 +--
 drivers/scsi/fnic/fip.c                                        |  119 
 drivers/scsi/fnic/fip.h                                        |    2 
 drivers/scsi/fnic/fnic.h                                       |   79 
 drivers/scsi/fnic/fnic_fcs.c                                   |  166 
 drivers/scsi/fnic/fnic_fdls.h                                  |    2 
 drivers/scsi/fnic/fnic_isr.c                                   |   41 
 drivers/scsi/fnic/fnic_main.c                                  |   89 
 drivers/scsi/fnic/fnic_scsi.c                                  |  264 -
 drivers/scsi/qla2xxx/qla_os.c                                  |    2 
 drivers/scsi/scsi.c                                            |   24 
 drivers/soc/samsung/exynos-pmu.c                               |    7 
 drivers/soundwire/cadence_master.c                             |    7 
 drivers/spi/spi-fsl-qspi.c                                     |    5 
 drivers/spi/spi-qpic-snand.c                                   |    4 
 drivers/spi/spi-virtio.c                                       |    2 
 drivers/spi/spi-zynqmp-gqspi.c                                 |   34 
 drivers/watchdog/da9062_wdt.c                                  |    4 
 drivers/watchdog/da9063_wdt.c                                  |    4 
 drivers/watchdog/digicolor_wdt.c                               |   13 
 drivers/watchdog/msc313e_wdt.c                                 |   16 
 drivers/watchdog/rtd119x_wdt.c                                 |    7 
 drivers/watchdog/rzv2h_wdt.c                                   |    7 
 drivers/watchdog/sp5100_tco.c                                  |    6 
 drivers/watchdog/starfive-wdt.c                                |    2 
 fs/9p/vfs_addr.c                                               |   29 
 fs/btrfs/dev-replace.c                                         |    1 
 fs/btrfs/disk-io.c                                             |    4 
 fs/btrfs/file.c                                                |    4 
 fs/btrfs/free-space-tree.c                                     |   14 
 fs/btrfs/inode.c                                               |    3 
 fs/btrfs/tree-checker.c                                        |    2 
 fs/btrfs/uuid-tree.c                                           |  120 
 fs/btrfs/verity.c                                              |   47 
 fs/btrfs/volumes.c                                             |  153 
 fs/btrfs/xattr.c                                               |   36 
 fs/dax.c                                                       |    9 
 fs/exec.c                                                      |   29 
 fs/smb/client/cifs_fs_sb.h                                     |    1 
 fs/smb/client/cifsfs.c                                         |   12 
 fs/smb/client/cifssmb.c                                        |    2 
 fs/smb/client/connect.c                                        |   10 
 fs/smb/client/file.c                                           |   28 
 fs/smb/client/misc.c                                           |   12 
 fs/smb/client/reparse.c                                        |    4 
 fs/smb/client/reparse.h                                        |    7 
 fs/smb/client/sess.c                                           |  106 
 fs/smb/client/smb2inode.c                                      |   11 
 fs/smb/client/smb2ops.c                                        |   51 
 fs/smb/client/smb2pdu.c                                        |   13 
 fs/smb/client/trace.h                                          |    1 
 fs/smb/server/server.c                                         |    2 
 fs/smb/server/smb2pdu.c                                        |   89 
 fs/smb/server/smb2pdu.h                                        |    1 
 fs/smb/server/smb_common.c                                     |   20 
 fs/xfs/libxfs/xfs_bmap.c                                       |    2 
 fs/xfs/libxfs/xfs_da_btree.c                                   |    2 
 fs/xfs/libxfs/xfs_da_btree.h                                   |    2 
 fs/xfs/libxfs/xfs_rmap.h                                       |    2 
 fs/xfs/scrub/attr_repair.c                                     |    4 
 fs/xfs/scrub/bmap.c                                            |    6 
 fs/xfs/scrub/common.c                                          |    6 
 fs/xfs/scrub/common.h                                          |    4 
 fs/xfs/scrub/dir_repair.c                                      |    4 
 fs/xfs/scrub/dirtree.c                                         |    4 
 fs/xfs/scrub/inode.c                                           |    6 
 fs/xfs/scrub/nlinks.c                                          |    2 
 fs/xfs/scrub/reap.c                                            |    3 
 fs/xfs/scrub/rtbitmap.c                                        |    4 
 fs/xfs/scrub/rtsummary.c                                       |    4 
 fs/xfs/scrub/tempfile.c                                        |   29 
 fs/xfs/xfs_inode.h                                             |    3 
 include/keys/request_key_auth-type.h                           |    2 
 include/linux/ieee80211.h                                      |    5 
 include/linux/mm.h                                             |    4 
 include/net/bluetooth/coredump.h                               |    2 
 include/net/mac80211.h                                         |    5 
 include/net/netns/xfrm.h                                       |    2 
 include/net/sock.h                                             |    2 
 include/sound/soc.h                                            |    3 
 include/sound/soc_sdw_utils.h                                  |   42 
 kernel/dma/coherent.c                                          |    3 
 kernel/dma/swiotlb.c                                           |    4 
 kernel/exit.c                                                  |   12 
 kernel/fork.c                                                  |    4 
 kernel/sched/core.c                                            |    6 
 kernel/signal.c                                                |  117 
 kernel/time/namespace.c                                        |    2 
 kernel/time/posix-cpu-timers.c                                 |   40 
 mm/filemap.c                                                   |    2 
 mm/huge_memory.c                                               |   86 
 mm/memblock.c                                                  |   18 
 mm/memcontrol.c                                                |    2 
 mm/mlock.c                                                     |    2 
 mm/mremap.c                                                    |    9 
 mm/swapfile.c                                                  |    2 
 mm/vma.c                                                       |    6 
 net/atm/pppoatm.c                                              |   42 
 net/bluetooth/coredump.c                                       |   65 
 net/bluetooth/eir.c                                            |   10 
 net/bluetooth/hci_codec.c                                      |   36 
 net/bluetooth/hci_core.c                                       |   18 
 net/bluetooth/hci_sync.c                                       |    2 
 net/bluetooth/iso.c                                            |   53 
 net/bluetooth/rfcomm/sock.c                                    |   13 
 net/bridge/br_mst.c                                            |   20 
 net/core/drop_monitor.c                                        |   12 
 net/core/neighbour.c                                           |   56 
 net/core/skbuff.c                                              |   32 
 net/core/sock.c                                                |   16 
 net/ipv4/esp4.c                                                |    6 
 net/ipv4/icmp.c                                                |   17 
 net/ipv4/ip_tunnel_core.c                                      |   16 
 net/ipv4/sysctl_net_ipv4.c                                     |    4 
 net/ipv4/tcp_input.c                                           |    3 
 net/ipv4/tcp_ulp.c                                             |    4 
 net/ipv4/xfrm4_input.c                                         |    2 
 net/ipv6/esp6.c                                                |    6 
 net/ipv6/route.c                                               |   22 
 net/ipv6/seg6_local.c                                          |    3 
 net/ipv6/tcp_ipv6.c                                            |    3 
 net/ipv6/xfrm6_input.c                                         |    2 
 net/ipv6/xfrm6_output.c                                        |   10 
 net/mac80211/Makefile                                          |    1 
 net/mac80211/cfg.c                                             |   63 
 net/mac80211/debugfs.c                                         |    2 
 net/mac80211/debugfs_netdev.c                                  |    9 
 net/mac80211/ieee80211_i.h                                     |    5 
 net/mac80211/iface.c                                           |   79 
 net/mac80211/main.c                                            |    4 
 net/mac80211/mesh.c                                            |   34 
 net/mac80211/michael.c                                         |   83 
 net/mac80211/michael.h                                         |   22 
 net/mac80211/offchannel.c                                      |    7 
 net/mac80211/pm.c                                              |    8 
 net/mac80211/scan.c                                            |    2 
 net/mac80211/tdls.c                                            |   19 
 net/mac80211/tx.c                                              |  107 
 net/mac80211/util.c                                            |    3 
 net/mac80211/wpa.c                                             |    1 
 net/netfilter/nf_flow_table_core.c                             |   12 
 net/netfilter/nf_nat_core.c                                    |   46 
 net/netfilter/nf_tables_api.c                                  |   22 
 net/netfilter/nft_nat.c                                        |    2 
 net/openvswitch/conntrack.c                                    |    2 
 net/packet/af_packet.c                                         |    4 
 net/packet/internal.h                                          |    2 
 net/psp/psp_sock.c                                             |    4 
 net/rds/ib_cm.c                                                |    2 
 net/sched/act_api.c                                            |   11 
 net/sched/sch_hhf.c                                            |    9 
 net/unix/garbage.c                                             |   17 
 net/wireless/Makefile                                          |    2 
 net/wireless/core.c                                            |  126 
 net/wireless/core.h                                            |   10 
 net/wireless/michael-mic.c                                     |   86 
 net/wireless/rdev-ops.h                                        |    3 
 net/wireless/scan.c                                            |   43 
 net/wireless/util.c                                            |   35 
 net/xfrm/espintcp.c                                            |    6 
 net/xfrm/xfrm_input.c                                          |   65 
 net/xfrm/xfrm_iptfs.c                                          |   12 
 net/xfrm/xfrm_state.c                                          |    9 
 net/xfrm/xfrm_user.c                                           |   37 
 rust/kernel/net/phy.rs                                         |   38 
 scripts/generate_rust_target.rs                                |    5 
 security/keys/encrypted-keys/encrypted.c                       |   20 
 security/keys/gc.c                                             |    4 
 security/keys/request_key_auth.c                               |   12 
 security/keys/trusted-keys/trusted_tpm2.c                      |   12 
 security/landlock/net.c                                        |   14 
 security/selinux/avc.c                                         |    5 
 security/selinux/hooks.c                                       |  150 
 security/selinux/include/objsec.h                              |   10 
 sound/core/init.c                                              |    3 
 sound/core/pcm_timer.c                                         |    7 
 sound/hda/common/controller.c                                  |    2 
 sound/soc/amd/acp/acp-sdw-legacy-mach.c                        |   33 
 sound/soc/amd/acp/acp-sdw-sof-mach.c                           |   31 
 sound/soc/codecs/hdmi-codec.c                                  |    6 
 sound/soc/codecs/rt712-sdca-dmic.c                             |   14 
 sound/soc/intel/boards/sof_sdw.c                               |   21 
 sound/soc/sdw_utils/soc_sdw_bridge_cs35l56.c                   |    4 
 sound/soc/sdw_utils/soc_sdw_utils.c                            |   59 
 sound/soc/soc-pcm.c                                            |   18 
 sound/soc/ux500/ux500_msp_i2s.h                                |    4 
 sound/usb/6fire/comm.c                                         |   42 
 sound/usb/6fire/comm.h                                         |    2 
 sound/usb/6fire/midi.c                                         |   43 
 sound/usb/6fire/midi.h                                         |    2 
 sound/usb/6fire/pcm.c                                          |  138 
 sound/usb/6fire/pcm.h                                          |    5 
 sound/usb/bcd2000/bcd2000.c                                    |   33 
 sound/usb/card.h                                               |    3 
 sound/usb/endpoint.c                                           |   16 
 sound/virtio/virtio_card.c                                     |    4 
 tools/perf/util/hist.h                                         |    8 
 tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c      |    2 
 tools/testing/selftests/landlock/audit.h                       |  121 
 tools/testing/selftests/landlock/audit_test.c                  |    4 
 tools/testing/selftests/landlock/fs_test.c                     | 1874 +++++++++-
 tools/testing/selftests/landlock/net_test.c                    |  169 
 385 files changed, 7026 insertions(+), 2963 deletions(-)

Aamir Ahmed (1):
      Bluetooth: eir: validate service data length before reading UUID

Ahmed Naseef (1):
      net: phy: mediatek: do not report link and per-speed LED rules together

Alberto Carboneri (1):
      scsi: core: Validate MODE SENSE lengths in scsi_cdl_enable()

Alex Bereza (2):
      dmaengine: xilinx_dma: Fix hardware buffer descriptor reuse order
      dmaengine: xilinx_dma: Fix hardware buffer descriptor chain after cyclic DMA

Alexander Chesnokov (1):
      dmaengine: ti: k3-udma-glue: fix NULL dereference in k3_udma_glue_release_rx_chn()

Alexei Turtanov (1):
      Input: atkbd - skip deactivate for Xiaomi Redmi Book Pro 16 2026

Alexey Klimov (1):
      soc: samsung: exynos-pmu: fix use-after-free of interrupt generator node

Ali Ahmet Memis (1):
      wifi: wilc1000: fix out-of-bounds read in P2P public action frames

Alvin Šipraga (1):
      Input: adp5588-keys - cache GPIO state before registering the gpiochip

Amit Machhiwal (2):
      KVM: PPC: Book3S HV: fix use-after-free in kvmhv_emulate_tlbie_all_lpid()
      KVM: PPC: Book3S HV: fix secure device page leak on uv_page_in() failure

Andrea Mayer (1):
      seg6: set IPSKB_L3SLAVE from IP6SKB_L3SLAVE on IPIP decapsulation

AngeloGioacchino Del Regno (2):
      phy: mediatek: phy-mtk-hdmi-mt8195: Fix PLL calc divisor overflow
      phy: mediatek: phy-mtk-hdmi-mt8195: Fix TMDS clk bit ratio setting

Antheas Kapenekakis (1):
      HID: asus: fortify keyboard handshake

Aohan Mei (1):
      rds: ib: use rds_conn_drop() on protocol version mismatch

April Cardenas (1):
      smb/client: send lease break ACKs thru correct session for multiuser mounts

Arash Golgol (1):
      media: video-i2c: fix buffer queue ordering

Arun Easi (1):
      scsi: fnic: Fix missed link-up when critical IRQ targets offline CPU

Baineng Shou (1):
      dmaengine: mmp_pdma: fix wrong sg length in mmp_pdma_prep_slave_sg()

Bard Liao (2):
      soundwire: cadence_master: wait and cancel cdns->work before clock stop
      ASoC: sdw_utils: subtract the endpoint that is not present

Bartosz Golaszewski (3):
      power: sequencing: don't call .post_enable() if pwrseq_unit_enable() failed
      power: sequencing: fix NULL-pointer dereference in pwrseq_unit_new()
      power: sequencing: fix NULL-pointer dereference in pwrseq_device_register()

Benjamin Berg (1):
      wifi: mac80211: track MU-MIMO configuration on disabled interfaces

Benoît Sevens (1):
      HID: logitech-hidpp: fix race condition when accessing stale stack pointer

Biju Das (1):
      power: sequencing: Fix build issue with COMPILE_TEST

Bitterblue Smith (1):
      wifi: rtw88: TX QOS Null data the same way as Null data

Bogdan Nicolae (1):
      wifi: brcmfmac: cyw: pass PMKID to firmware if present

Bradley Morgan (1):
      arm64: hibernate: pass HVC_SET_VECTORS args to the resume hvc

Breno Leitao (1):
      arm64: hibernate: clone only the linear map that exists at runtime

Carolina Jubran (1):
      IB/IPoIB: Avoid restoring OPER_UP after multicast flush

Cen Zhang (1):
      KEYS: encrypted: fix integer overflow of datablob_len

Chandrashekar Devegowda (1):
      Bluetooth: btintel_pcie: validate TX skb length in send_sync

Chang S. Bae (2):
      x86/build/64: Prevent native builds from generating EGPR use
      x86/microcode/intel: Reject problematic loading on Granite Rapids systems

Charles Keepax (2):
      ASoC: sdw_utils: Add codec_conf for every DAI
      ASoC: intel: sof_sdw: Add ability to have auxiliary devices

Chengfeng Ye (2):
      Bluetooth: hci_sync: Serialize local codec list cleanup
      xfrm: serialize state GC with device state flush

Chengjun Yao (1):
      drm/amdgpu: fix rmmio iounmap skipped on device removal

Chris Lu (1):
      Bluetooth: btmtk: fix wrong status for short WMT FUNC_CTRL events

Chris Sommers (1):
      Input: i8042 - add quirk for Acer Aspire Go 15 AG15-42P

Christian Göttsche (1):
      selinux: always fill AVC decision in avc_has_perm_noaudit()

Christian Lugnberg (2):
      dmaengine: sun6i: fix non-atomic read of DMA position registers
      dmaengine: sun6i: fix undefined behaviour in sun6i_dma_tx_status

Christoph Hellwig (3):
      xfs: add a xfs_rmap_inode_owner helper
      xfs: convert xchk_inode_xref_set_corrupt to xchk_ip_xref_set_corrupt
      xfs: remove the i_ino field in struct xfs_inode

Chunfeng Song (1):
      rust: net: phy: fix off-by-one bit positions in device status accessors

Claudiu Beznea (1):
      phy: renesas: rcar-gen3-usb2: Avoid long delay in atomic context

Cong Nguyen (1):
      hwmon: (gpio-fan) return IRQ_HANDLED from the shared alarm IRQ handler

Daehyeon Ko (1):
      wifi: libipw: reject TKIP frames without a full MIC

Daniel Linjama (1):
      btrfs: handle lack of space when cleaning up verity items

Daniel Zahka (1):
      net: psp: avoid conflicts with skb->decrypted and sk_validate_xmit_skb()

Darrick J. Wong (1):
      xfs: fix under-reservation of blocks when repairing sf directories

David Howells (1):
      9p: Fix v9fs_issue_write() to update i_size and remote_i_size

Devin Wittmayer (1):
      wifi: mac80211: refuse to make a monitor active when it has no queue

Diogo Ivo (Schneider Electric) (4):
      mmc: sdhci_am654: Move tuning_loop to local variable
      mmc: sdhci_am654: Reset command and data lines on failed tuning
      mmc: sdhci_am654: Clear ITAPDLY on tuning failure
      mmc: sdhci_am654: Fallback to DT-provided itap delay on DDR50 tuning failure

Dmitriy Chumachenko (1):
      drm/amdgpu: check ras and obj before dereference

Dmitriy Okunev (1):
      net: mvpp2: prevent buffer overflow in page_pool allocation

Dmitry Antipov (1):
      wifi: mac80211: fix list iteration in ieee80211_add_virtual_monitor()

Dmitry Baryshkov (2):
      drm/msm/dsi: round the byte clock rate after reparenting to the PHY PLL
      Bluetooth: qca: enable pwrseq support for WCN39xx devices

Dmitry Torokhov (2):
      Input: rmi_smbus - fix out-of-bounds read in rmi_smb_write_block()
      Input: synaptics-rmi4 - fix GPF in suspend and resume when unbound

Dong Chenchen (2):
      ipv4: icmp: reject RTN_UNREACHABLE input routes in icmp_route_lookup
      xfrm: Fix dev use-after-free in xfrm async resumption

Donggeun Yoo (2):
      dma-coherent: report a failed reserved memory assignment
      swiotlb: use the adjusted address for the highmem page lookup

Doruk Tan Ozturk (1):
      wifi: mwifiex: bound the pairwise-cipher OUI walk to the IE length

Eric Biggers (3):
      wifi: ipw2x00: Rename michael_mic() to libipw_michael_mic()
      wifi: mac80211, cfg80211: Export michael_mic() and move it to cfg80211
      wifi: ipw2x00: Use michael_mic() from cfg80211

Eric Dumazet (8):
      xfrm: add missing rcu_read_lock(), skb_dst_force() and dev_hold() for xfrm_trans_reinject()
      tcp: do not let tcp_rmem be set below 4096
      pppoatm: ensure a writable skb header and linear data
      drop_monitor: synchronize tracepoint unregistration on error path
      drop_monitor: use timer_shutdown_sync() to prevent timer rearming during teardown
      drop_monitor: fix out-of-bounds write in reset_per_cpu_data()
      net: lock the socket in sock_gettstamp()
      net: skbuff: do not leave stale header offsets after pskb_carve()

Erich Sartison (1):
      Input: xpad - add support for Victrix Pro BFG Controller

Fan Wu (6):
      mmc: core: Cancel SDIO IRQ work before freeing host
      mmc: hsq: Fix use-after-free in retry work
      mmc: mmci: Fix use-after-free in busy-timeout work
      mmc: mxcmmc: cancel data work and watchdog on remove
      wifi: wcn36xx: Fix potential use-after-free in TX ack timer teardown
      smb: client: fix cifsFileInfo reference leak in deferred close

Felix Gu (1):
      mmc: sdio_uart: fix xmit_fifo leak when the port table is full

Fernando Fernandez Mancera (1):
      netfilter: nf_tables: fix device name and prefix match in hook lookup

Filipe Manana (3):
      btrfs: tree-checker: print dev extent offset in error message
      btrfs: abort transaction on failure to update inode for hole punching and reflinking
      btrfs: check if there is space for chunk item when validating sys chunk array

Florian Maillard (1):
      mmc: rtsx_pci_sdmmc: ignore broken write-protect on ThinkPad X260

Frank Sorenson (8):
      smb: client: reject short Next offsets in parse_server_interfaces()
      smb: client: fix next_buffer UAF and NextCommand bounds in compound PDUs
      smb: client: fix OOB struct field reads in move_smb2_ea_to_cifs()
      smb: client: fix potential OOB read in smb3_enum_snapshots()
      smb: client: fix server->total_read for compound encrypted PDUs
      smb: client: fix missing lower-bound check on DFS referral string offsets
      smb: client: fix missing iov bounds check in parse_posix_sids()
      smb: client: fix reparse buffer bounds in cifs_query_reparse_point()

Frieder Schrempf (1):
      spi: fsl-qspi: Reprogram the clock rate when the operation frequency changes

Gabor Juhos (1):
      spi: spi-qpic-snand: avoid writing QPIC_EBI2_ECC_BUF_CFG register

Gang Yan (1):
      RDMA/rxe: Fix integer overflow in mr_check_range() leading to OOB access

Greg Kroah-Hartman (1):
      Linux 6.18.54

Gris Ge (1):
      net: ip_tunnel: initialize `options_len` before referencing options

Guanghui Yang (1):
      btrfs: clear free space tree creation state on rebuild failure

Guanglei Zhu (3):
      net: wwan: t7xx: validate the netif index in t7xx_ccmni_recv_skb()
      net: wwan: mhi_wwan_mbim: guard against a cyclic NDP chain
      net: wwan: mhi_wwan_mbim: check skb_copy_bits() return value

Guangshuo Li (5):
      i2c: imx: disable autosuspend on remove
      hwmon: (w83791d) remove fan/pwm 4-5 sysfs group on remove
      hwmon: (w83793) release probe data through kref
      drm/msm/adreno: fix autosuspend cleanup during teardown
      drm/msm/hdmi_phy: fix runtime PM cleanup on probe failure

Guoqing Jiang (1):
      RDMA/siw: Clear association under lock if siw_qp_modify fails in siw_accept

Günther Noack (3):
      selftests/landlock: Use an actual chardev for MAKE_CHAR audit test
      selftests/landlock: Add tests for whiteout object creation
      selftests/landlock: Add audit test for whiteout object creation

Hans de Goede (2):
      Input: soc_button_array - fix MS Surface Pro 11 probe failure
      Input: soc_button_array - check btns_desc->package.count

Hao-Qun Huang (1):
      spi: virtio: Use the per-transfer bits per word

Henry Martin (1):
      xfrm: iptfs: fix runt reassembly panic from short inner tot_len

Hohyun Sim (1):
      net: fddi: skfp: fix NULL deref when setting the MAC address while down

Hongling Zeng (1):
      btrfs: take commit root semaphore when iterating in mark_block_group_to_copy()

HyeongJun An (1):
      ASoC: hdmi-codec: Report a change when the channel status moves

Hyunwoo Kim (1):
      exec: Cleanup POSIX timers right after de_thread()

Ibrahim Abdelkader (1):
      Bluetooth: hci_qca: Do not write to the serial port after it is closed

Ido Schimmel (2):
      ipv6: Select best matching nexthop object in fib6_table_lookup()
      ipv6: Honor oif when choosing nexthop for locally generated traffic

Ilia Levi (2):
      drm/xe/mmio_gem: forbid VMA split
      drm/xe/mmio_gem: use write-back mapping for dummy page

Inbal Schussheim (1):
      tcp: exclude old ACKs from tcp fast path

Itai Handler (1):
      spi: spi-zynqmp-gqspi: stop the controller on shutdown

Iván Ezequiel Rodriguez (3):
      Input: evdev - zero absinfo before partial copy in EVIOCSABS
      Input: zero ff_effect before compat copy in input_ff_effect_from_user
      ntsync: reject wait ioctls with zero owner

Jacob Moroni (1):
      RDMA/irdma: Enforce local fence for IB_WR_REG_MR

Jakub Kicinski (1):
      eth: fbnic: ring the doorbell if a burst ends in a drop

Jamal Hadi Salim (1):
      net/sched: hhf: cap hh_flows_limit at change time

James Clark (1):
      net: macb: fix ordering around PTP timestamp read

James Seo (1):
      hwmon: (hp-wmi-sensors) Improve raw WMI string handling

Jarkko Sakkinen (1):
      KEYS: trusted: Fix tpm2_load_cmd() boundary check

Jeffin Philip (1):
      RDMA/core: fix refcount bug in iwpm_get_nlmsg_request()

Jens Axboe (1):
      sunvdc: fix -EIO issue due to lack of retries

Jeremy Nyberg (1):
      Input: xpad - fix PDP Marvel Xbox 360 controller

Jesse Casco (1):
      drm/msm/dp: skip PUSH_IDLE when the link was never enabled

Jianbo Liu (1):
      xfrm: Refactor xfrm_input lock to reduce contention with RSS

Jiangshan Yi (3):
      ASoC: codecs: rt712-sdca-dmic: fix uninitialized stream_config->type
      wifi: brcmsmac: fix UAF in brcms_free_timer()
      wifi: libertas_tf: fix UAF in lbtf_free_adapter()

Jinke Han (1):
      x86/kprobes: Fix crash when probing CS CALL instructions

Johannes Berg (26):
      wifi: cfg80211: don't get the radio mask for netdev-less wdevs
      wifi: cfg80211: check IP header size in cfg80211_classify8021d()
      wifi: cfg80211: don't free driver-owned scan requests
      wifi: cfg80211: only group hidden BSSes with beacon entries
      wifi: cfg80211: don't filter by BSS type when removing stale entries
      wifi: mac80211: don't start a ROC while scanning
      wifi: mac80211: don't warn when an IBSS has no channel to scan
      wifi: mac80211: don't offload TC setup on AP_VLAN interfaces
      wifi: mac80211: suppress chanctx warning for debugfs reset
      wifi: mac80211: abort chanswitch when leaving a mesh
      wifi: mac80211: reset state when starting AP fails
      wifi: cfg80211: restore netns_immutable on failures
      wifi: cfg80211: undo netns switch if renaming the wiphy fails
      wifi: mac80211: unlist vifs when their netdev is unregistered
      wifi: cfg80211: get the wiphy out of a dying network namespace
      wifi: mac80211_hwsim: don't hand frames to mac80211 while stopping
      wifi: mac80211: don't allow injecting frames wider than the chanctx
      wifi: mac80211: reset the AP_VLAN tailroom counter on ifdown
      wifi: mac80211: require a peer station for TDLS setup confirm
      wifi: mac80211: don't allow link changes when iface is down
      wifi: mac80211: don't RCU-dereference the mesh CSA settings we just set
      wifi: mac80211: don't access the TSF of a down interface
      wifi: mac80211: add HE 6 GHz capability in the scan elems len
      wifi: mac80211: mesh: reset the CSA state when leaving
      wifi: mac80211: mesh: release the channel if start fails
      wifi: mac80211: set up the TX info early to fix failure paths

Jonghyuk Kim(MalHyuk) (1):
      drm/msm: RCU-free the scheduler-containing ring and VM objects

Joseph Qi (1):
      smb: client: fix use-after-free of iface in cifs_try_adding_channels()

Josh Poimboeuf (1):
      x86/alternative: Refactor INT3 call emulation selftest

Juan Perdomo (1):
      Bluetooth: RFCOMM: avoid socket lock inversion in listener cleanup

Jérémy Jean (1):
      RDMA/siw: Bound fragmented header copies by the remaining length

Karan Tilak Kumar (4):
      scsi: fnic: Rename fnic_scsi_fcpio_reset()
      scsi: fnic: Bump up version number
      scsi: fnic: Make debug logging protocol independent
      scsi: fnic: Bump up version number again

Karl Mehltretter (9):
      scsi: qla2xxx: Fix the ql2xfc2target parameter description
      drm/msm: Fix the separate_gpu_kms parameter description
      drm/msm/adreno: Fix the skip_gpu parameter description
      keys: fix lost wakeup when reaping a dead key type
      Input: trackpoint - fix the inertia attribute name in the ABI document
      drm/vc4: Use managed KMS polling to fix UAF on unbind
      wifi: brcmfmac: fix lost 802.1x TX completion wakeup
      selinux: preserve user SID across nested backing files
      selinux: recheck intermediate backing files on mprotect()

Koichiro Den (1):
      arm64: dts: renesas: r8a779f0: Set UFS lane count

Krystian Kaniewski (1):
      RDMA/core: Reject unregistering netdevs in ib_get_eth_speed

Kuninori Morimoto (2):
      ASoC: sdw_utils: tidyup .count_sidecar
      ASoC: sdw_utils: tidyup asoc_sdw_parse_sdw_endpoints()

Kuniyuki Iwashima (6):
      neighbour: Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.
      neighbour: Convert RTM_GETNEIGHTBL to RCU.
      neighbour: Add missing RCU annotation for neightbl_dump_info().
      neighbour: Skip default parms when resumed in neightbl_dump_info().
      tcp: Don't call skb_clone_and_charge_r() for close()d listener in tcp_v6_do_rcv().
      af_unix: Unify scc_index when finalising SCC in __unix_walk_scc().

Kyle Zeng (1):
      xfrm: fix compat ALLOCSPI request use-after-free

Lachlan Hodges (1):
      wifi: mac80211: include TIM bitmap control for buffered S1G mcast traffic

Laxman Acharya Padhya (1):
      Bluetooth: hci_codec: validate vendor codec count length

Leon Romanovsky (2):
      RDMA/efa: Keep admin queues alive while IRQ is registered
      RDMA/efa: Keep EQ resources alive while IRQ is registered

Li Jun (2):
      watchdog: da9062: fix suspend/resume handling of HW_RUNNING watchdog
      watchdog: da9063: fix suspend/resume handling of HW_RUNNING watchdog

Li RongQing (1):
      RDMA/mad: Fix receive buffer leak when PKey enforcement fails

Linkai Gong (3):
      RDMA/bnxt_re: check create_singlethread_workqueue() in DCB setup
      i2c: atr: fix dangling adapter pointer on add failure
      Input: cyttsp5 - clamp the HID report size before memcpy

Linmao Li (1):
      wifi: mwifiex: prevent authentication frame length truncation

Linus Walleij (1):
      net: ethernet: cortina: Ack RX overrun interrupt correctly

Liu Zhenlong (1):
      i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()

Lorenzo Bianconi (2):
      net: stmmac: do not overwrite phc_index when no PTP clock is registered
      net: stmmac: propagate FPE preemption-class mapping errors

Lorenzo Stoakes (ARM) (3):
      mm/mremap: account mm->locked_vm correctly for MREMAP_DONTUNMAP
      mm/huge_memory: bypass THP tuneables for huge pfnmap mappings
      mm/vma: correctly unaccount on mmap_prepare() failure

Luiz Augusto von Dentz (2):
      Bluetooth: ISO: Fix parent socket leak in iso_conn_ready()
      Bluetooth: ISO: set BT_LISTEN before requesting a BIG sync

Lyude Paul (4):
      Revert "nouveau/gsp: fix suspend/resume regression on r570 firmware"
      drm/nouveau/gsp: Increase delay for magic sleep in r535_gsp_fini()
      drm/nouveau/gsp/r570: Set GcOff = 0 in fbsr
      drm/nouveau/gsp/r570: Enable S/R Display workaround in GSP

Maher Azzouzi (1):
      esp: downgrade zerocopy managed frags before mutating skb frags

Maoyi Xie (3):
      keys: translate request_key_auth pid for the reading procfs instance
      time/namespace: Export init_time_ns and do_timens_ktime_to_host()
      ntsync: Honour caller's time namespace for absolute MONOTONIC timeouts

Mariano Baragiola (1):
      wifi: virt_wifi: free skb when disconnected

Mark Amirkan (3):
      net: lan743x: fix RX checksum use-after-free
      net/packet: clear RX owner on VNET header error
      net/packet: avoid truncating TPACKET_V3 private size

Mark Rutland (3):
      arm64: percpu: Fix this_cpu_write() casting
      arm64: percpu: Fix this_cpu_and() mask generation
      arm64: percpu: Fix LSE operations on {8,16}-bit types

Matthew Schwartz (1):
      x86/fred: Reconstruct the #GP context for rejected INT instructions

Matthieu Buffet (3):
      landlock: Fix TCP Fast Open connection bypass
      selftests/landlock: Add test for TCP fast open
      selftests/landlock: Add missing connect(minimal AF_UNSPEC) test

Maximilian Heyne (1):
      selftests/landlock: Explicitly disable audit in teardowns

Meijing Zhao (1):
      mm: memblock: show all region flags in debugfs

Mengshi Wu (1):
      Bluetooth: hci_qca: Refactor HFP hardware offload capability handling

Michael Bommarito (1):
      RDMA/rxe: insert mcg into mcg_tree only after rxe_mcast_add() succeeds

Mickaël Salaün (3):
      selftests/landlock: Fix socket file descriptor leaks in audit helpers
      selftests/landlock: Increase default audit socket timeout
      selftests/landlock: Add disconnected leafs and branch test suites

Mike Lothian (1):
      drm/amdgpu: hold a runtime PM reference for P2P dma-buf attachments

Muhammad Bilal (1):
      hwmon: (hp-wmi-sensors) Fix use-after-free in fungible_show()

Myeonghun Pak (1):
      mmc: sdhci-of-aspeed: Remove children before releasing SDC resources

Namjae Jeon (5):
      ksmbd: return buffer overflow for partial filesystem info
      ksmbd: fix partial file information responses
      ksmbd: keep compound responses on query info errors
      ksmbd: fix partial normalized name responses
      Revert "ksmbd: Fix to handle removal of rfc1002 header from smb_hdr"

Nguyen Ngoc Thang (1):
      ALSA: pcm: set timer->private_data before registering the PCM timer

Nhat Pham (1):
      mm, swap: fix SWAP_USAGE_OFFLIST_BIT collision with real usage count

Nicolai Buchwitz (2):
      net: bcmgenet: convert RX path to page_pool
      net: bcmgenet: restore the hardware filters on open

Nicolas Escande (1):
      wifi: ath11k: cleanup arsta in ath11k_mac_peer_cleanup_all()

Nicolas Thibert (1):
      Bluetooth: btusb: fix NXP IW610 composite device handling

Niklas Cassel (1):
      ata: libahci: clear PxCLBU and PxFBU for AHCI_HFLAG_32BIT_ONLY

Nikolay Aleksandrov (1):
      net: bridge: mst: move switchdev call outside rcu

Norbert Szetei (1):
      RDMA/rxe: validate access flags before swapping the MR's PD

Nuno Sá (1):
      hwmon: (pmbus/core) increase number of phases and add new mask

Or Har-Toov (1):
      RDMA/mlx5: Remove warn on missing representor in query_port_speed

Orgad Shaneh (1):
      MIPS: Octeon: apply USB FDT fixups also when USB is modular

Ovidiu Panait (3):
      arm64: dts: renesas: r9a09g057: Switch GBETH TX queue scheduling to WRR
      arm64: dts: renesas: r9a09g056: Switch GBETH TX queue scheduling to WRR
      arm64: dts: renesas: r9a09g047: Switch GBETH TX queue scheduling to WRR

Pablo Neira Ayuso (2):
      netfilter: nf_nat: unregister and release hooks on error
      netfilter: flowtable: hold reference on ct until flow is released

Paulo Alcantara (4):
      smb: client: cancel reconnect work in clean_demultiplex_info()
      smb: client: fix rlist race and missing initialization
      smb: client: fix smbd_connection leak on cifs_get_tcp_session() error
      smb: client: fix unaligned access in WSL reparse point parser

Peng Hao (1):
      wifi: mwifiex: fix IRQ leak using wrong index in MSI-X error path

Pengpeng Hou (2):
      ARM: socfpga: select the PL310 erratum 753970 workaround
      wifi: mwifiex: validate scan response extents

Peter Zijlstra (1):
      futex: Also allocate private hash on vfork()

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: lock bo before calling amdgpu_vm_bo_update_shared

Quanye Yang (2):
      RDMA/rtrs-clt: Fix CQ pool leak when connect is interrupted
      RDMA/ucma: Serialize join and leave on copy_to_user failure

Rafael J. Wysocki (1):
      ACPI: processor: Update cpuidle driver check in __acpi_processor_start()

Raphaël Larocque (1):
      Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)

Richard Fitzgerald (3):
      ASoC: Rename snd_soc_dai_link_ch_map.ch_mask to cpu_ch_mask
      ASoC: Add codec_ch_mask to snd_soc_dai_link_ch_map
      ASoC: soc-pcm: Apply snd_soc_dai_link_ch_map.codec_ch_mask to codec params

Rik van Riel (1):
      wifi: mac80211: avoid WARN in set_bitrate_mask when sdata not in driver

Roberts Kursitis (1):
      Input: xpad - add support for Azeron devices

Roshan Kumar (1):
      xfrm: iptfs: fix stack OOB read in iptfs_skb_reset_frag_walk()

Runyu Xiao (4):
      gpio: virtuser: skip free_irq when no IRQ is installed
      mmc: sh_mmcif: initialize IRQ-thread mutex before requesting interrupt
      Input: hp_sdc - shut down kicker timer on module exit
      wifi: wlcore: release runtime PM ref on regdomain config failure

Ruoyu Wang (1):
      dmaengine: sprd: Fix runtime PM reference leak in probe

Sabrina Dubroca (1):
      xfrm: avoid RCU warnings around the per-netns netlink socket

Sai Teja Aluvala (1):
      Bluetooth: btintel_pcie: fix off-by-one bounds check in RX submit

Saim Shujah (1):
      drm/msm/dpu: clear pending peripheral flush state

Sajal Gupta (1):
      drm/gud: fix out-of-bounds write in gud_plane_atomic_check()

Sanman Pradhan (2):
      hwmon: (pmbus/tps53679) Fix TPS53676 phase page decoding
      hwmon: (pmbus/tps53679) Select page 0 for single-page TPS53676

Sasha Levin (2):
      Revert "perf annotate: Fix build with NO_SLANG=1"
      ASoC: ux500: Parenthesize MSP_{RX,TX}_CLKPOL_BIT() arguments

Seunguk Shin (1):
      fs/dax: check zero or empty entry before converting xarray entry

Shakeel Butt (2):
      memcg: avoid charging the root memcg from obj_cgroup_charge_pages()
      mm/mlock: use the IRQ-safe accessor for NR_MLOCK in __munlock_folio()

Shengzhuo Wei (4):
      i2c: at91: release DMA channels on remove and probe error
      i2c: imx: release DMA channels on probe error
      wifi: p54: validate curve data length in the calibration curve converters
      wifi: p54: require a full exp_if record in PDR_INTERFACE_LIST

Shivank Garg (3):
      dmaengine: Fix device kref underflow in dma_chan_put()
      dmaengine: fix use-after-free in dma_chan_put() and dma_release_channel()
      dmaengine: wait for RCU readers before releasing dma_device

Shivaprasad G Bhat (1):
      powerpc/iommu: Fix the overflow validation in iommu_tce_check_ioba

Shmulik Cohen (2):
      wifi: libipw: reject too-short beacon and probe responses
      wifi: libipw: reject too-short association responses

Shouping Wang (1):
      perf/arm-cmn: Fix wp_dev_sel2 setting for multi-DTM configurations

Shuangpeng Bai (1):
      IB/mlx4: Fix use-after-free on pkey sysfs registration failure

Shuhei Takeshita (2):
      IB/hfi1: Resolve the credit-return buffer through the send context's node
      IB/hfi1: Fix the PIO_CRED credit-return mmap

Shuicheng Lin (2):
      drm/xe/mmio_gem: Revoke drm_vma_node on xe_mmio_gem destroy
      drm/xe/shrinker: Return the freed page count through a parameter

Siwei Zhang (1):
      xfrm: use hlist_del_init_rcu for state_cache and state_cache_input

Slavin Liu (1):
      ALSA: hda: trace PCM open only after assigning a stream

Sophie D (1):
      drm/gud: Ignore damage clips in full update mode

Stanislaw Gruszka (1):
      wifi: iwlegacy: fix broadcast stations deallocation

Sun YangKai (1):
      btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions

Takashi Iwai (4):
      ALSA: bcd2000: Fix race between rawmidi and disconnect
      ALSA: usb: 6fire: Avoid embedded URBs
      ALSA: core: Fix potential UAF after asynchronous card release
      ALSA: usb-audio: Optimize the copy of packet sizes for implicit fb handling

Thadeu Lima de Souza Cascardo (1):
      drm: Fix drm_pending_vblank_event leak in error path for out_fence_ptr

ThangNN99 (1):
      Bluetooth: hci_core: Fix queuing tx_work after workqueue is drained

Theodor Arsenij Larionov Trichkine (1):
      netfilter: nft_nat: fully initialise new_addr in netmap setup

Thomas Gleixner (3):
      posix-cpu-timers: Prevent freeing a timer which is queued on the expiry list
      signal: Move MMCID exit out of sighand lock
      signal: Prevent exec() race

Thomas Huth (1):
      kselftest/arm64: Fix size of thread_data values for pthread_join()

Thomas Richard (congatec GmbH) (2):
      hwmon: (cgbc-hwmon) Fix current sensors ID lookup
      hwmon: (cgbc-hwmon) Add missing sensors

Tianchu Chen (2):
      wifi: rsi: fix heap OOB write on key removal
      wifi: wilc1000: fix RX buffer OOB-write in wilc_wlan_handle_isr_ext()

Tingmao Wang (1):
      selftests/landlock: Add tests for access through disconnected paths

Tzung-Bi Shih (6):
      Bluetooth: btmtksdio: Fix PM runtime reference leak in shutdown
      watchdog: digicolor: Avoid division by zero
      watchdog: msc313e: Fix premature reset during timeout update
      watchdog: msc313e: Propagate error code in resume()
      watchdog: rtd119x: Avoid division by zero
      watchdog: rzv2h: Avoid division by zero

Vijendar Mukunda (3):
      ASoC: amd: acp: bounds-check SoundWire link ID in machine drivers
      ASoC: amd: acp: refactor codec config count in SOF SoundWire machine driver
      ASoC: amd: acp: fix ffs() operator precedence for SoundWire link ID

Vivek Sahu (1):
      Bluetooth: qca: Refactor code on the basis of chipset names

Weiming Shi (2):
      RDMA/rxe: Restore HMM_PFN_WRITE check in ODP write paths
      Bluetooth: coredump: Quiesce dump work on unregister

Wenjie Qi (1):
      mm: filemap: retain mapped dropbehind folios

Wentao Liang (4):
      ata: libahci_platform: Fix device reference leak in ahci_platform_get_resources()
      cifs: Fix server use-after-free in cifs_chan_skip_or_disable()
      watchdog: sp5100_tco: Fix pci_dev reference leak in sp5100_tco_init()
      watchdog: starfive-wdt: Fix runtime PM leak in starfive_wdt_pm_start()

William Bright (1):
      drm/msm/dp: fix link bandwidth check when wide bus is enabled

Wyatt Feng (1):
      net: xfrm: reject unrepresentable espintcp transport headers

Xiang Mei (2):
      ALSA: 6fire: fix OOB write from device-reported iso length
      ALSA: usb-audio: Clamp implicit feedback packet count to URB capacity

Xixin Liu (2):
      firmware: arm_scpi: reject DVFS OPP count above MAX_DVFS_OPPS
      clk: scpi: bound-check DVFS index in scpi_dvfs_recalc_rate

Xu Rao (1):
      mmc: spi: reset bytes_xfered before retrying CRC failures

Xuanqiang Luo (1):
      net/sched: act_api: release tail references on DELACTION failure

Yehyeong Lee (2):
      IB/iser: reject a remote invalidation of an unregistered direction
      IB/isert: wait for deferred control PDU completions before releasing the connection

Yibo Tan (1):
      hwmon: (pwm-fan) Stop RPM timer before freeing tach data

Yifei Gao (1):
      memstick: ms_block: destroy io_queue workqueue on removal

Yige Jiang (1):
      net: netsec: fix device_node reference leak on phy_np

Yuho Choi (1):
      ALSA: virtio: reset device before deleting virtqueues

Zhao Li (1):
      wifi: mwifiex: validate action frame fixed fields

Zhiling Zou (3):
      openvswitch: avoid reallocating confirmed conntrack labels
      ipv6: xfrm: use full sockets in local error paths
      xfrm: save input state data before secpath resets

Zhu Ling (1):
      mmc: core: Fix OF node reference leak on card add failure

Zihan Xi (1):
      wifi: virt_wifi: don't transfer operstate before register

Zijun Hu (1):
      Bluetooth: hci_qca: fix NULL pointer dereference in qca_setup() for non-serdev device

Zizhi Wo (1):
      smb: client: fix busy dentry warning on unmount after DIO

hpp.iscas (1):
      Input: eeti_ts - publish the OF module alias

