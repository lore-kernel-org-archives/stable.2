Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E848283CAF;
	Mon,  1 Jun 2026 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329987; cv=none; b=esU6QdO23r2QDOJhd0tbKp7NK/F8EU2g7TjKsJzleB656PmezI4UadEfHmillRFtkqB+NJ5085uM9BhEe2gXHcEtkCvBLWKY+/f/8rfMvxcwBYkZyfhOX7DlD/+zLdnCnKXza32OFt/V2VgqItHMHEoHgIXjH8+jmvHIO/aRKWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329987; c=relaxed/simple;
	bh=jy9uIey4lPFrJq9sNdxnyUMOzLycdOvpWzNb0sfX3mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iecB3kEf6ckAM8NaCxi9KGfBzCps/ndmWMyHfUCYNrWuDbTa/QdMmx32AtMyEnkeTAVYfWO85DpctvsPOEociBwEDpt+rMQF9qs3u0ksihMaR9KtJyEbyu09Xw/38A1Bh1GU1ZcSKP2SN5qAqyCrrzWqfU/byDxwFYxQTPMU1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ckRGulp+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ckRGulp+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABCD1F00893;
	Mon,  1 Jun 2026 16:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780329984;
	bh=JFXwnYmB7vzaQL4mEz0crvpbiXzmRscf1DJ8/DPXQkY=;
	h=From:To:Cc:Subject:Date;
	b=ckRGulp+5nP17O73i3RN9uAkH7c2GX/Cidwnu4+GmHeA4OyeVBsH+i7Y/2yJd4gFQ
	 OWsFTqIAhr26NGaypGg+B0iQdf+kisxLkq9CIXtOzQMne3VfPaIwrxx+eLUvGp71Ai
	 CIzQsgqFNghBBs2FnBCsQRC1wOmIT0X08/q6LOZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.258
Date: Mon,  1 Jun 2026 18:05:26 +0200
Message-ID: <2026060127-improper-both-c91d@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.258 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/vm/hugetlbfs_reserv.rst                       |    2 
 Makefile                                                    |    2 
 arch/arm/boot/dts/mt7623.dtsi                               |    2 
 arch/arm/mach-integrator/integrator_cp.c                    |   13 
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts        |    3 
 arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts         |    6 
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi           |   16 
 arch/arm64/boot/dts/freescale/imx8mq.dtsi                   |    2 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts        |   72 ++
 arch/mips/include/asm/cpu-features.h                        |    1 
 arch/mips/include/asm/cpu-info.h                            |    2 
 arch/mips/include/asm/mipsregs.h                            |    2 
 arch/mips/kernel/cpu-probe.c                                |   13 
 arch/mips/kernel/cpu-r3k-probe.c                            |    2 
 arch/mips/mm/tlb-r4k.c                                      |  281 +++++++--
 arch/parisc/kernel/syscalls/syscall.tbl                     |    2 
 arch/powerpc/kexec/file_load_64.c                           |    2 
 arch/powerpc/net/bpf_jit_comp64.c                           |   20 
 arch/powerpc/platforms/44x/warp.c                           |    2 
 arch/riscv/include/asm/pgtable.h                            |    2 
 arch/s390/kernel/debug.c                                    |    8 
 arch/um/drivers/cow_user.c                                  |    8 
 arch/x86/include/asm/segment.h                              |    8 
 arch/x86/kernel/uprobes.c                                   |   24 
 arch/x86/kvm/svm/nested.c                                   |    5 
 arch/x86/kvm/svm/sev.c                                      |   11 
 arch/x86/kvm/x86.c                                          |   14 
 block/blk-cgroup.c                                          |    4 
 block/blk-mq.c                                              |    6 
 block/blk.h                                                 |    3 
 block/elevator.c                                            |    4 
 crypto/af_alg.c                                             |    2 
 crypto/authencesn.c                                         |    5 
 crypto/pcrypt.c                                             |    7 
 drivers/acpi/video_detect.c                                 |    8 
 drivers/ata/ahci.c                                          |   14 
 drivers/base/core.c                                         |   26 
 drivers/base/dd.c                                           |   12 
 drivers/base/devres.c                                       |    2 
 drivers/block/drbd/drbd_nl.c                                |    8 
 drivers/bluetooth/hci_ldisc.c                               |   51 +
 drivers/cdrom/cdrom.c                                       |   73 +-
 drivers/char/ipmi/ipmi_si_intf.c                            |   70 +-
 drivers/char/ipmi/ipmi_ssif.c                               |   74 +-
 drivers/char/tpm/tpm_tis_core.c                             |    4 
 drivers/clk/clk-qoriq.c                                     |   17 
 drivers/clk/clk-xgene.c                                     |    2 
 drivers/clk/imx/clk-imx6q.c                                 |   12 
 drivers/clk/imx/clk-imx8mq.c                                |    4 
 drivers/clk/qcom/dispcc-sc7180.c                            |    8 
 drivers/clk/qcom/dispcc-sm8250.c                            |    6 
 drivers/cpuidle/cpuidle-powernv.c                           |    5 
 drivers/cpuidle/cpuidle-pseries.c                           |    5 
 drivers/crypto/atmel-aes.c                                  |    2 
 drivers/crypto/atmel-ecc.c                                  |    1 
 drivers/crypto/atmel-tdes.c                                 |    8 
 drivers/crypto/ccp/ccp-crypto-aes.c                         |    7 
 drivers/crypto/ccp/sev-dev.c                                |   19 
 drivers/crypto/ccree/cc_hash.c                              |    1 
 drivers/crypto/hisilicon/sec/sec_algs.c                     |    2 
 drivers/crypto/sa2ul.c                                      |    4 
 drivers/dma/mxs-dma.c                                       |    1 
 drivers/firmware/efi/capsule-loader.c                       |    2 
 drivers/firmware/google/framebuffer-coreboot.c              |    2 
 drivers/gpio/gpiolib-cdev.c                                 |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                     |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                       |   66 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                       |    3 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                      |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |    9 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c   |   72 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c           |   62 ++
 drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c    |    9 
 drivers/gpu/drm/amd/display/dc/calcs/Makefile               |    3 
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c       |    4 
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile               |    4 
 drivers/gpu/drm/amd/display/dc/dsc/Makefile                 |    3 
 drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c              |   15 
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c         |   28 
 drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c     |    6 
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c    |   16 
 drivers/gpu/drm/drm_gem_framebuffer_helper.c                |    4 
 drivers/gpu/drm/gma500/oaktrail_hdmi.c                      |    1 
 drivers/gpu/drm/i915/display/intel_dp.c                     |    9 
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c            |   26 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c                 |    2 
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c                       |   14 
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                           |    4 
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                           |    2 
 drivers/gpu/drm/panel/panel-simple.c                        |    2 
 drivers/gpu/drm/panfrost/panfrost_drv.c                     |    2 
 drivers/gpu/drm/radeon/ci_dpm.c                             |    9 
 drivers/gpu/drm/sun4i/sun4i_backend.c                       |    3 
 drivers/gpu/drm/vc4/vc4_bo.c                                |    3 
 drivers/gpu/drm/vc4/vc4_gem.c                               |   19 
 drivers/hid/hid-alps.c                                      |    3 
 drivers/hid/hid-asus.c                                      |   28 
 drivers/hid/hid-core.c                                      |    3 
 drivers/hid/hid-ids.h                                       |    3 
 drivers/hid/hid-quirks.c                                    |    3 
 drivers/hid/hid-roccat.c                                    |    2 
 drivers/hid/usbhid/hid-core.c                               |    2 
 drivers/hwmon/pmbus/adm1266.c                               |   32 -
 drivers/i2c/busses/i2c-s3c2410.c                            |    7 
 drivers/i3c/master.c                                        |    7 
 drivers/iio/adc/ad7768-1.c                                  |    9 
 drivers/infiniband/core/addr.c                              |    3 
 drivers/infiniband/core/iwpm_msg.c                          |    6 
 drivers/infiniband/core/mad.c                               |    5 
 drivers/infiniband/hw/mlx4/srq.c                            |    4 
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c                 |    4 
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c             |    2 
 drivers/infiniband/sw/rxe/rxe_recv.c                        |   14 
 drivers/infiniband/sw/siw/siw_qp_rx.c                       |   15 
 drivers/iommu/intel/iommu.c                                 |    3 
 drivers/irqchip/irq-ath79-cpu.c                             |    7 
 drivers/irqchip/irq-pic32-evic.c                            |    2 
 drivers/mailbox/mailbox-test.c                              |   39 -
 drivers/mailbox/mailbox.c                                   |    9 
 drivers/md/bcache/super.c                                   |    8 
 drivers/md/dm-cache-metadata.c                              |   24 
 drivers/md/dm-cache-metadata.h                              |    5 
 drivers/md/dm-cache-policy-smq.c                            |    4 
 drivers/md/dm-cache-target.c                                |  111 +++
 drivers/md/dm-ioctl.c                                       |    6 
 drivers/md/dm-log.c                                         |    6 
 drivers/md/dm-raid1.c                                       |    6 
 drivers/md/dm-verity-fec.c                                  |    8 
 drivers/md/raid10.c                                         |    2 
 drivers/md/raid5-cache.c                                    |   48 +
 drivers/md/raid5.c                                          |    8 
 drivers/media/dvb-frontends/dib8000.c                       |    4 
 drivers/media/i2c/imx219.c                                  |    3 
 drivers/media/rc/streamzap.c                                |   12 
 drivers/media/rc/xbox_remote.c                              |    9 
 drivers/media/test-drivers/vidtv/vidtv_bridge.c             |    4 
 drivers/media/test-drivers/vidtv/vidtv_channel.c            |    4 
 drivers/media/test-drivers/vidtv/vidtv_mux.c                |    4 
 drivers/media/test-drivers/vidtv/vidtv_ts.c                 |   48 -
 drivers/media/test-drivers/vidtv/vidtv_ts.h                 |    4 
 drivers/media/usb/as102/as102_usb_drv.c                     |    2 
 drivers/media/usb/em28xx/em28xx-video.c                     |   14 
 drivers/media/usb/hackrf/hackrf.c                           |    7 
 drivers/media/usb/uvc/uvc_driver.c                          |    2 
 drivers/media/usb/uvc/uvc_queue.c                           |    3 
 drivers/media/usb/uvc/uvcvideo.h                            |    7 
 drivers/memory/tegra/tegra124-emc.c                         |    2 
 drivers/memory/tegra/tegra30-emc.c                          |    6 
 drivers/mfd/mc13xxx-core.c                                  |    2 
 drivers/misc/ibmasm/ibmasmfs.c                              |    7 
 drivers/misc/ibmasm/lowlevel.c                              |   12 
 drivers/misc/ibmasm/remote.c                                |    5 
 drivers/mmc/core/block.c                                    |   12 
 drivers/mmc/core/queue.h                                    |    3 
 drivers/mtd/devices/docg3.c                                 |    3 
 drivers/mtd/maps/physmap-gemini.c                           |    2 
 drivers/mtd/nand/raw/sunxi_nand.c                           |    6 
 drivers/net/bareudp.c                                       |   24 
 drivers/net/can/spi/mcp251x.c                               |   29 
 drivers/net/dsa/sja1105/sja1105_static_config.c             |    6 
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c        |    2 
 drivers/net/ethernet/atheros/ag71xx.c                       |    3 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c              |   15 
 drivers/net/ethernet/cirrus/cs89x0.c                        |    2 
 drivers/net/ethernet/cortina/gemini.c                       |   21 
 drivers/net/ethernet/ibm/ibmveth.c                          |   22 
 drivers/net/ethernet/ibm/ibmveth.h                          |    1 
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c            |    8 
 drivers/net/ethernet/intel/e1000e/netdev.c                  |    1 
 drivers/net/ethernet/intel/i40e/i40e_main.c                 |    1 
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c                |    4 
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c           |    1 
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c     |   17 
 drivers/net/hamradio/6pack.c                                |   39 -
 drivers/net/netdevsim/dev.c                                 |    2 
 drivers/net/phy/dp83869.c                                   |   13 
 drivers/net/ppp/ppp_generic.c                               |    5 
 drivers/net/ppp/pppoe.c                                     |    8 
 drivers/net/slip/slhc.c                                     |   49 +
 drivers/net/tap.c                                           |   23 
 drivers/net/usb/cdc-phonet.c                                |    7 
 drivers/net/usb/lan78xx.c                                   |   29 
 drivers/net/usb/rtl8150.c                                   |   12 
 drivers/net/vrf.c                                           |   15 
 drivers/net/wan/lapbether.c                                 |   23 
 drivers/net/wireless/ath/ath11k/hal.c                       |   14 
 drivers/net/wireless/ath/ath5k/base.c                       |    3 
 drivers/net/wireless/ath/ath9k/channel.c                    |    6 
 drivers/net/wireless/broadcom/b43/xmit.c                    |    3 
 drivers/net/wireless/broadcom/b43legacy/xmit.c              |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c   |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c     |   31 -
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.h     |    5 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c     |    5 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c     |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c     |   12 
 drivers/net/wireless/broadcom/brcm80211/include/soc.h       |    2 
 drivers/net/wireless/mac80211_hwsim.c                       |    1 
 drivers/net/wireless/marvell/mwifiex/11n_aggr.c             |    1 
 drivers/net/wireless/realtek/rtlwifi/pci.c                  |    1 
 drivers/net/wireless/rsi/rsi_common.h                       |    5 
 drivers/net/wireless/ti/wl1251/tx.c                         |    8 
 drivers/nfc/trf7970a.c                                      |    3 
 drivers/nvme/target/core.c                                  |    2 
 drivers/parisc/lasi.c                                       |   12 
 drivers/pci/controller/dwc/pcie-tegra194.c                  |   10 
 drivers/pci/controller/pci-hyperv.c                         |    8 
 drivers/pci/pci.c                                           |   48 -
 drivers/pci/pcie/aer.c                                      |    2 
 drivers/pcmcia/rsrc_nonstatic.c                             |    6 
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c                  |    5 
 drivers/pinctrl/nomadik/pinctrl-abx500.c                    |    2 
 drivers/pinctrl/pinctrl-pic32.c                             |   20 
 drivers/platform/x86/dell_rbu.c                             |    6 
 drivers/platform/x86/intel-hid.c                            |    6 
 drivers/platform/x86/surfacepro3_button.c                   |    1 
 drivers/power/supply/max17042_battery.c                     |    2 
 drivers/regulator/act8945a-regulator.c                      |    3 
 drivers/regulator/max77650-regulator.c                      |    2 
 drivers/rtc/class.c                                         |    5 
 drivers/rtc/interface.c                                     |   12 
 drivers/rtc/rtc-abx80x.c                                    |    2 
 drivers/s390/cio/css.c                                      |    2 
 drivers/scsi/isci/host.c                                    |    3 
 drivers/scsi/qla2xxx/qla_init.c                             |   20 
 drivers/scsi/sg.c                                           |   29 
 drivers/scsi/sr.c                                           |   25 
 drivers/scsi/sr.h                                           |    1 
 drivers/soc/qcom/ocmem.c                                    |    7 
 drivers/soc/qcom/qcom_aoss.c                                |    2 
 drivers/soc/ti/omap_prm.c                                   |    1 
 drivers/spi/spi-fsl-qspi.c                                  |    3 
 drivers/spi/spi-imx.c                                       |    1 
 drivers/spi/spi-mpc52xx.c                                   |    3 
 drivers/spi/spi-mtk-nor.c                                   |    4 
 drivers/spi/spi-orion.c                                     |    6 
 drivers/spi/spi-sprd.c                                      |    3 
 drivers/spi/spi-ti-qspi.c                                   |    1 
 drivers/spi/spi-topcliff-pch.c                              |    6 
 drivers/spi/spi-zynqmp-gqspi.c                              |    4 
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c           |    4 
 drivers/staging/rtl8723bs/core/rtw_security.c               |    2 
 drivers/staging/sm750fb/sm750.c                             |    3 
 drivers/target/target_core_configfs.c                       |    2 
 drivers/target/target_core_sbc.c                            |    3 
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c     |    9 
 drivers/thermal/spear_thermal.c                             |    2 
 drivers/thermal/sprd_thermal.c                              |    4 
 drivers/tty/hvc/hvc_iucv.c                                  |   11 
 drivers/usb/class/usblp.c                                   |    3 
 drivers/usb/common/ulpi.c                                   |    5 
 drivers/usb/gadget/function/f_ncm.c                         |    4 
 drivers/usb/gadget/function/f_phonet.c                      |    9 
 drivers/usb/gadget/udc/omap_udc.c                           |    4 
 drivers/usb/gadget/udc/renesas_usb3.c                       |    7 
 drivers/usb/host/xhci.c                                     |    1 
 drivers/usb/serial/option.c                                 |    6 
 drivers/usb/storage/unusual_devs.h                          |    7 
 drivers/usb/usbip/usbip_common.c                            |   12 
 drivers/vhost/net.c                                         |    4 
 drivers/video/backlight/sky81452-backlight.c                |    3 
 drivers/video/fbdev/matrox/g450_pll.c                       |    2 
 drivers/video/fbdev/offb.c                                  |    7 
 drivers/video/fbdev/tdfxfb.c                                |    3 
 drivers/video/fbdev/udlfb.c                                 |   34 +
 fs/adfs/super.c                                             |    3 
 fs/btrfs/extent_io.c                                        |    4 
 fs/btrfs/extent_io.h                                        |   12 
 fs/btrfs/inode.c                                            |   30 -
 fs/ceph/xattr.c                                             |    1 
 fs/cifs/cifs_spnego.c                                       |   16 
 fs/cifs/connect.c                                           |   17 
 fs/ext2/inode.c                                             |   14 
 fs/ext4/xattr.c                                             |    4 
 fs/fuse/control.c                                           |    4 
 fs/fuse/readdir.c                                           |    4 
 fs/gfs2/dir.c                                               |    6 
 fs/gfs2/glops.c                                             |    4 
 fs/isofs/export.c                                           |    2 
 fs/isofs/rock.c                                             |    9 
 fs/nfs/blocklayout/blocklayout.c                            |    4 
 fs/nilfs2/dat.c                                             |    3 
 fs/nilfs2/ioctl.c                                           |    6 
 fs/notify/fsnotify.c                                        |    2 
 fs/notify/inotify/inotify_user.c                            |    1 
 fs/notify/mark.c                                            |   18 
 fs/ocfs2/alloc.c                                            |    2 
 fs/ocfs2/aops.c                                             |   75 +-
 fs/ocfs2/cluster/nodemanager.c                              |    2 
 fs/ocfs2/dir.c                                              |    4 
 fs/ocfs2/dlm/dlmdomain.c                                    |   10 
 fs/ocfs2/file.c                                             |    4 
 fs/ocfs2/inode.c                                            |   33 +
 fs/ocfs2/ioctl.c                                            |   18 
 fs/ocfs2/localalloc.c                                       |    6 
 fs/ocfs2/mmap.c                                             |    7 
 fs/ocfs2/namei.c                                            |    2 
 fs/ocfs2/ocfs2.h                                            |    4 
 fs/ocfs2/ocfs2_trace.h                                      |   10 
 fs/ocfs2/quota_global.c                                     |    2 
 fs/ocfs2/resize.c                                           |   22 
 fs/ocfs2/xattr.c                                            |    6 
 fs/omfs/inode.c                                             |    6 
 fs/pstore/ram_core.c                                        |    4 
 fs/quota/dquot.c                                            |   38 +
 fs/sysfs/group.c                                            |    2 
 fs/udf/misc.c                                               |    8 
 fs/userfaultfd.c                                            |    2 
 include/dt-bindings/clock/qcom,dispcc-sc7180.h              |    7 
 include/linux/acpi.h                                        |    6 
 include/linux/cdrom.h                                       |    1 
 include/linux/dev_printk.h                                  |   10 
 include/linux/device.h                                      |   48 +
 include/linux/dmi.h                                         |    5 
 include/linux/fsnotify_backend.h                            |    1 
 include/linux/kvm_host.h                                    |    3 
 include/linux/padata.h                                      |    4 
 include/linux/ppp_defs.h                                    |   30 +
 include/linux/printk.h                                      |    5 
 include/linux/quotaops.h                                    |    9 
 include/linux/rtc.h                                         |    2 
 include/linux/spinlock_up.h                                 |   20 
 include/linux/string.h                                      |   12 
 include/linux/tpm_eventlog.h                                |    9 
 include/linux/uprobes.h                                     |    1 
 include/linux/usb.h                                         |    3 
 include/net/flow_dissector.h                                |   22 
 include/net/ipv6.h                                          |    6 
 include/net/mac80211.h                                      |    4 
 include/net/pie.h                                           |    2 
 include/net/red.h                                           |    1 
 include/net/route.h                                         |    6 
 include/net/udp_tunnel.h                                    |   15 
 include/sound/compress_driver.h                             |    2 
 include/trace/events/btrfs.h                                |    9 
 include/trace/events/ib_mad.h                               |   13 
 include/trace/events/rxrpc.h                                |    8 
 include/uapi/linux/rtc.h                                    |    5 
 include/video/udlfb.h                                       |    1 
 io_uring/io-wq.c                                            |    3 
 io_uring/io_uring.c                                         |   35 -
 kernel/audit.c                                              |    4 
 kernel/auditsc.c                                            |    2 
 kernel/bpf/local_storage.c                                  |    2 
 kernel/cgroup/rdma.c                                        |    2 
 kernel/events/uprobes.c                                     |   10 
 kernel/padata.c                                             |  136 +---
 kernel/taskstats.c                                          |    1 
 kernel/time/alarmtimer.c                                    |    2 
 kernel/trace/ring_buffer.c                                  |    8 
 kernel/trace/trace_branch.c                                 |    8 
 kernel/trace/trace_events_hist.c                            |   12 
 kernel/trace/trace_probe.c                                  |    2 
 kernel/trace/tracing_map.c                                  |   17 
 lib/kunit/Kconfig                                           |    5 
 lib/ts_kmp.c                                                |   18 
 mm/backing-dev.c                                            |    5 
 mm/kasan/init.c                                             |    8 
 net/batman-adv/bat_iv_ogm.c                                 |   85 ++
 net/batman-adv/bridge_loop_avoidance.c                      |   92 ++-
 net/batman-adv/distributed-arp-table.c                      |    3 
 net/batman-adv/fragmentation.c                              |   58 +
 net/batman-adv/gateway_client.c                             |    4 
 net/batman-adv/originator.c                                 |    4 
 net/batman-adv/tp_meter.c                                   |   32 -
 net/batman-adv/types.h                                      |    6 
 net/bluetooth/bnep/core.c                                   |    2 
 net/bluetooth/hci_event.c                                   |    3 
 net/bluetooth/l2cap_core.c                                  |    8 
 net/bluetooth/l2cap_sock.c                                  |    9 
 net/bpf/test_run.c                                          |   20 
 net/caif/cfsrvl.c                                           |   14 
 net/can/raw.c                                               |   11 
 net/ceph/crush/crush.c                                      |    6 
 net/ceph/osdmap.c                                           |   14 
 net/core/filter.c                                           |    2 
 net/core/flow_dissector.c                                   |   69 ++
 net/core/rtnetlink.c                                        |    1 
 net/ethtool/bitset.c                                        |    8 
 net/ipv4/netfilter/arp_tables.c                             |   18 
 net/ipv4/netfilter/arpt_mangle.c                            |    8 
 net/ipv4/nexthop.c                                          |   36 +
 net/ipv4/raw.c                                              |    2 
 net/ipv4/route.c                                            |   48 -
 net/ipv4/tcp.c                                              |    3 
 net/ipv4/tcp_bpf.c                                          |    3 
 net/ipv4/udp_tunnel_core.c                                  |   48 +
 net/ipv6/exthdrs.c                                          |   13 
 net/ipv6/icmp.c                                             |   10 
 net/ipv6/ip6_gre.c                                          |    5 
 net/ipv6/ip6_output.c                                       |   68 --
 net/ipv6/ip6_udp_tunnel.c                                   |   69 ++
 net/ipv6/netfilter/ip6t_eui64.c                             |    3 
 net/ipv6/netfilter/ip6t_hbh.c                               |    4 
 net/ipv6/seg6_hmac.c                                        |    2 
 net/ipv6/xfrm6_protocol.c                                   |    4 
 net/l2tp/l2tp_core.c                                        |    5 
 net/mac80211/tx.c                                           |    4 
 net/netfilter/ipset/ip_set_hash_ipmark.c                    |    6 
 net/netfilter/ipset/ip_set_hash_ipport.c                    |    5 
 net/netfilter/ipset/ip_set_hash_ipportip.c                  |    5 
 net/netfilter/ipset/ip_set_hash_ipportnet.c                 |    5 
 net/netfilter/ipvs/ip_vs_xmit.c                             |   19 
 net/netfilter/nf_conntrack_netlink.c                        |    2 
 net/netfilter/nf_conntrack_proto_sctp.c                     |   13 
 net/netfilter/nf_conntrack_sip.c                            |  152 +++--
 net/netfilter/nf_nat_amanda.c                               |    2 
 net/netfilter/nf_nat_sip.c                                  |   34 -
 net/netfilter/nfnetlink_log.c                               |    8 
 net/netfilter/nfnetlink_osf.c                               |   45 -
 net/netfilter/nft_bitwise.c                                 |    3 
 net/netfilter/nft_ct.c                                      |    2 
 net/netfilter/nft_fwd_netdev.c                              |   10 
 net/netfilter/nft_osf.c                                     |    6 
 net/netfilter/nft_set_pipapo.c                              |   21 
 net/netfilter/nft_set_pipapo_avx2.c                         |   20 
 net/netfilter/xt_mac.c                                      |   34 -
 net/netfilter/xt_multiport.c                                |   34 +
 net/netfilter/xt_owner.c                                    |   37 -
 net/netfilter/xt_physdev.c                                  |   29 
 net/netfilter/xt_policy.c                                   |    2 
 net/netfilter/xt_realm.c                                    |    2 
 net/nfc/digital_technology.c                                |    6 
 net/nfc/llcp_core.c                                         |    2 
 net/openvswitch/datapath.c                                  |   35 +
 net/openvswitch/vport.c                                     |    3 
 net/phonet/pep.c                                            |   19 
 net/qrtr/ns.c                                               |   11 
 net/rds/af_rds.c                                            |   10 
 net/rds/connection.c                                        |   14 
 net/rds/ib.c                                                |   24 
 net/rds/ib.h                                                |    1 
 net/rds/ib_rdma.c                                           |    2 
 net/rds/message.c                                           |   21 
 net/rds/rdma.c                                              |    4 
 net/rxrpc/call_object.c                                     |   22 
 net/rxrpc/conn_event.c                                      |   17 
 net/rxrpc/key.c                                             |    7 
 net/rxrpc/proc.c                                            |   26 
 net/rxrpc/recvmsg.c                                         |   22 
 net/rxrpc/rxkad.c                                           |    7 
 net/rxrpc/sendmsg.c                                         |    2 
 net/sched/act_csum.c                                        |    6 
 net/sched/act_ct.c                                          |   23 
 net/sched/sch_cake.c                                        |   15 
 net/sched/sch_choke.c                                       |   28 
 net/sched/sch_fq_codel.c                                    |    3 
 net/sched/sch_fq_pie.c                                      |   19 
 net/sched/sch_gred.c                                        |    3 
 net/sched/sch_hhf.c                                         |   19 
 net/sched/sch_netem.c                                       |   57 +
 net/sched/sch_pie.c                                         |   52 -
 net/sched/sch_red.c                                         |   34 -
 net/sched/sch_sfb.c                                         |   54 +
 net/sched/sch_taprio.c                                      |  357 ++++++------
 net/sctp/sm_statefuns.c                                     |    6 
 net/sctp/socket.c                                           |   11 
 net/smc/smc_clc.c                                           |    4 
 net/strparser/strparser.c                                   |    8 
 net/tipc/msg.c                                              |   14 
 net/tls/tls_sw.c                                            |   26 
 net/unix/diag.c                                             |   21 
 net/vmw_vsock/af_vsock.c                                    |    6 
 net/vmw_vsock/hyperv_transport.c                            |    4 
 net/vmw_vsock/virtio_transport_common.c                     |    3 
 net/vmw_vsock/vmci_transport.c                              |    2 
 net/wireless/core.c                                         |    4 
 net/wireless/scan.c                                         |    3 
 net/xdp/xdp_umem.c                                          |    3 
 net/xfrm/xfrm_user.c                                        |    4 
 scripts/checkpatch.pl                                       |   10 
 scripts/dtc/dtc-lexer.l                                     |    3 
 security/integrity/ima/ima_crypto.c                         |    2 
 sound/aoa/soundbus/i2sbus/core.c                            |    9 
 sound/core/compress_offload.c                               |   75 --
 sound/core/control.c                                        |    4 
 sound/core/seq/oss/seq_oss_rw.c                             |    6 
 sound/core/sound.c                                          |    7 
 sound/firewire/fireworks/fireworks_command.c                |    5 
 sound/firewire/tascam/tascam-hwdep.c                        |    1 
 sound/pci/asihpi/hpicmn.c                                   |    6 
 sound/pci/asihpi/hpimsgx.c                                  |    6 
 sound/pci/ctxfi/ctatc.c                                     |    3 
 sound/pci/ctxfi/ctvmem.h                                    |    2 
 sound/pci/hda/patch_realtek.c                               |    5 
 sound/soc/codecs/ab8500-codec.c                             |    6 
 sound/soc/fsl/fsl_easrc.c                                   |  125 ++--
 sound/soc/soc-core.c                                        |    1 
 sound/soc/sti/uniperif_player.c                             |    9 
 sound/soc/stm/stm32_sai_sub.c                               |    3 
 sound/usb/6fire/chip.c                                      |   17 
 sound/usb/6fire/control.c                                   |   10 
 sound/usb/caiaq/control.c                                   |   52 +
 sound/usb/caiaq/device.c                                    |   39 -
 sound/usb/caiaq/input.c                                     |    2 
 sound/usb/format.c                                          |    2 
 sound/usb/midi.c                                            |   12 
 sound/usb/misc/ua101.c                                      |   12 
 sound/usb/mixer.c                                           |   14 
 sound/usb/mixer_quirks.c                                    |   12 
 sound/usb/stream.c                                          |    4 
 tools/perf/util/branch.h                                    |    3 
 tools/perf/util/expr.c                                      |    3 
 tools/perf/util/util.h                                      |    1 
 tools/testing/ktest/ktest.pl                                |   35 -
 tools/testing/selftests/cgroup/test_memcontrol.c            |   11 
 tools/testing/selftests/lib.mk                              |    1 
 tools/testing/selftests/mqueue/setting                      |    1 
 tools/testing/selftests/mqueue/settings                     |    1 
 510 files changed, 4722 insertions(+), 2113 deletions(-)

Aaro Koskinen (1):
      USB: omap_udc: DMA: Don't enable burst 4 mode

Abd-Alrhman Masalkhi (1):
      media: vidtv: fix pass-by-value structs causing MSAN warnings

Abdun Nihaal (1):
      mfd: mc13xxx-core: Fix memory leak in mc13xxx_add_subdevice_pdata()

Abdurrahman Hussain (10):
      hwmon: (pmbus/adm1266) widen blackbox-info buffer to I2C_SMBUS_BLOCK_MAX
      hwmon: (pmbus/adm1266) seed timestamp from the real-time clock
      hwmon: (pmbus/adm1266) reject implausible blackbox record_count
      hwmon: (pmbus/adm1266) include PEC byte in pmbus_block_xfer read buffer
      hwmon: (pmbus/adm1266) bounce blackbox records through a protocol-sized buffer
      hwmon: (pmbus/adm1266) cap PDIO scan in get_multiple at ADM1266_PDIO_NR
      hwmon: (pmbus/adm1266) don't clobber GPIO bits before PDIO read in get_multiple
      hwmon: (pmbus/adm1266) register the gpio_chip after pmbus_do_probe()
      hwmon: (pmbus/adm1266) register the nvmem device after pmbus_do_probe()
      hwmon: (pmbus/adm1266) reject short block-read responses in the GPIO accessors

Abhishek Kumar (1):
      media: em28xx: fix use-after-free in em28xx_v4l2_open()

Agalakov Daniil (1):
      e1000: check return value of e1000_read_eeprom

Akhil P Oommen (1):
      drm/msm/a6xx: Use barriers while updating HFI Q headers

Alex Deucher (3):
      drm/radeon: add missing revision check for CI
      drm/amdgpu/pm: add missing revision check for CI
      drm/amdgpu/pm: align Hawaii mclk workaround with radeon

Alex Hung (1):
      drm/amd/display: Add null checker before passing variables

Alexander Konyukhov (1):
      drm/komeda: fix integer overflow in AFBC framebuffer size check

Alexander Koskovich (1):
      drm/msm/dsi: rename MSM8998 DSI version from V2_2_0 to V2_0_0

Alexandre Belloni (3):
      rtc: introduce features bitfield
      rtc: allow rtc_read_alarm without read_alarm callback
      alarmtimer: Check RTC features instead of ops

Alexey Kodanev (1):
      nfp: fix swapped arguments in nfp_encode_basic_qdr() calls

Alice Mikityanska (1):
      l2tp: Drop large packets with UDP encap

Allison Henderson (1):
      net/rds: reset op_nents when zerocopy page pin fails

Alok Tiwari (1):
      soc: qcom: aoss: compare against normalized cooling state

Anderson Nascimento (1):
      rxrpc: Fix missing validation of ticket length in non-XDR key preparsing

Andreas Haarmann-Thiemann (1):
      net: ethernet: cortina: Drop half-assembled SKB

Andrew Price (1):
      gfs2: Validate i_depth for exhash directories

André Draszik (1):
      power: supply: max17042: avoid overflow when determining health

Andy Shevchenko (5):
      ACPI: property: Constify stubs for CONFIG_ACPI=n case
      fbdev: matroxfb: Mark variable with __maybe_unused to avoid W=1 build break
      driver core: Move dev_err_probe() to where it belogs
      nfs/blocklayout: Fix compilation error (`make W=1`) in bl_write_pagelist()
      gpiolib: cdev: use !mem_is_zero() instead of memchr_inv(s, 0, n)

Anthony Pighin (Nokia) (1):
      rtc: abx80x: Disable alarm feature if no interrupt attached

Ao Zhou (1):
      net: rds: fix MR cleanup on copy error

Arend van Spriel (1):
      brcmfmac: support chipsets with different core enumeration space

Arjan van de Ven (1):
      drm/amdgpu: fix zero-size GDS range init on RDNA4

Arnaldo Carvalho de Melo (1):
      perf util: Kill die() prototype, dead for a long time

Arnd Bergmann (3):
      ALSA: asihpi: avoid write overflow check warning
      tpm: avoid -Wunused-but-set-variable
      clk: qoriq: avoid format string warning

Arthur Husband (1):
      ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585

Arun Easi (1):
      scsi: qla2xxx: Fix crash when I/O abort times out

Ashutosh Desai (1):
      drm/gem: Fix inconsistent plane dimension calculation in drm_gem_fb_init_with_funcs()

Asim Viladi Oglu Manizada (1):
      smb: client: reject userspace cifs.spnego descriptions

Bae Yeonju (1):
      fs/adfs: validate nzones in adfs_validate_bblk()

Bart Van Assche (4):
      scsi: ufs: core: Improve SCSI abort handling
      drbd: Balance RCU calls in drbd_adm_dump_devices()
      locking: Fix rwlock support in <linux/spinlock_up.h>
      ice: fix locking in ice_dcb_rebuild()

Bartosz Golaszewski (1):
      gpio: cdev: check if uAPI v2 config attributes are correctly zeroed

Ben Hutchings (1):
      Revert "s390/cio: Fix device lifecycle handling in css_alloc_subchannel()"

Ben Morris (1):
      sctp: revalidate list cursor after sctp_sendmsg_to_asoc() in SCTP_SENDALL

Beniamino Galvani (4):
      ipv4: rename and move ip_route_output_tunnel()
      ipv4: remove "proto" argument from udp_tunnel_dst_lookup()
      ipv4: add new arguments to udp_tunnel_dst_lookup()
      ipv6: rename and move ip6_dst_lookup_tunnel()

Benoît Sevens (1):
      HID: roccat: fix use-after-free in roccat_report_event

Berk Cem Goksel (2):
      ALSA: 6fire: fix use-after-free on disconnect
      ALSA: caiaq: take a reference on the USB device in create_card()

Bin Liu (1):
      mmc: block: use single block write in retry

Boris Sukholitko (2):
      dissector: do not set invalid PPP protocol
      flow_dissector: Add number of vlan tags dissector

Breno Leitao (2):
      mm: blk-cgroup: fix use-after-free in cgwb_release_workfn()
      tracing: branch: Fix inverted check on stat tracer registration

Brian Masney (1):
      irqchip/irq-pic32-evic: Address warning related to wrong printf() formatter

Cezar Bulinaru (1):
      net: tap: NULL pointer derefence in dev_parse_header_protocol when skb->dev is null

Chaitanya Kulkarni (1):
      nvmet: avoid recursive nvmet-wq flush in nvmet_ctrl_free

Chaitanya Kumar Borah (1):
      drm/i915/dp: Fix VSC dynamic range signaling for RGB formats

Chen Ni (3):
      media: i2c: imx219: Check return value of devm_gpiod_get_optional() in imx219_probe()
      mtd: physmap_of_gemini: Fix disabled pinctrl state check
      backlight: sky81452-backlight: Check return value of devm_gpiod_get_optional() in sky81452_bl_parse_dt()

Chen Zhao (1):
      IB/core: Fix zero dmac race in neighbor resolution

Chenguang Zhao (1):
      ethtool: fix ethnl_bitmap32_not_zero() bit interval semantics

Chia-Ming Chang (2):
      md/raid5: fix soft lockup in retry_aligned_read()
      inotify: fix watch count leak when fsnotify_add_inode_mark_locked() fails

Christian A. Ehrhardt (1):
      ASoC: codecs: ab8500: Fix casting of private data

Cole Leavitt (1):
      pstore/ram: fix resource leak when ioremap() fails

Corey Minyard (7):
      ipmi: Add limits to event and receive message requests
      ipmi: Check event message buffer response for bad data
      ipmi:si: Return state to normal if message allocation fails
      ipmi:ssif: Fix a shutdown race
      ipmi:ssif: Clean up kthread on errors
      ipmi:ssif: Remove unnecessary indention
      ipmi:ssif: NULL thread on error

Cryolitia PukNgae (1):
      ALSA: usb-audio: apply quirk for MOONDROP JU Jiu

Cássio Gabriel (12):
      ALSA: usb-audio: stop parsing UAC2 rates at MAX_NR_RATES
      ALSA: usb-audio: Avoid false E-MU sample-rate notifications
      ALSA: usb-audio: Fix Audio Advantage Micro II SPDIF switch
      ALSA: aoa: i2sbus: fix OF node lifetime handling
      ALSA: seq_oss: return full count for successful SEQ_FULLSIZE writes
      ALSA: caiaq: Fix control_put() result and cache rollback
      ALSA: 6fire: Fix input volume change detection
      ALSA: usb-audio: Fix UAC3 cluster descriptor size check
      ALSA: firewire-tascam: Do not drop unread control events
      ALSA: core: Validate compress device numbers without dynamic minors
      ALSA: usb-audio: Bound MIDI endpoint descriptor scans
      ALSA: ua101: Reject too-short USB descriptors

César Montoya (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion 15-eg0xxx

Daan De Meyer (1):
      cdrom, scsi: sr: propagate read-only status to block layer via set_disk_ro()

Daniel Borkmann (1):
      bpf: Fix precedence bug in convert_bpf_ld_abs alignment check

Daniel Brát (1):
      usb: storage: Expand range of matched versions for VL817 quirks entry

Daniel Hodges (1):
      ima: check return value of crypto_shash_final() in boot aggregate

Danilo Krummrich (1):
      devres: fix missing node debug info in devm_krealloc()

Darrick J. Wong (1):
      fuse: quiet down complaints in fuse_conn_limit_write

David Carlier (1):
      tracing: Avoid NULL return from hist_field_name() on truncation

David Gow (3):
      drivers: base: Free devm resources when unregistering a device
      kunit: config: Enable KUNIT_DEBUGFS by default
      kunit: config: KUNIT_DEBUGFS should depend on DEBUG_FS

David Heidelberg (1):
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Mark l1a regulator as powered during boot

David Howells (3):
      rxrpc: Fix call removal to use RCU safe deletion
      rxrpc: Fix recvmsg() unconditional requeue
      rxrpc: Fix anonymous key handling

Deepanshu Kartikey (4):
      nilfs2: fix NULL i_assoc_inode dereference in nilfs_mdt_save_to_shadow_map
      ocfs2: validate inline data i_size during inode read
      ALSA: caiaq: fix usb_dev refcount leak on probe failure
      nilfs2: reject zero bd_oblocknr in nilfs_ioctl_mark_blocks_dirty()

Denis Benato (2):
      HID: asus: make asus_resume adhere to linux kernel coding standards
      HID: asus: do not abort probe when not necessary

Denis M. Karpov (1):
      userfaultfd: allow registration of ranges below mmap_min_addr

Dmitry Antipov (1):
      ocfs2: add inline inode consistency check to ocfs2_validate_inode_block()

Dmitry Baryshkov (1):
      soc: qcom: ocmem: return -EPROBE_DEFER is ocmem is not available

Douglas Anderson (2):
      driver core: Don't let a device probe until it's ready
      driver core: Add kernel-doc for DEV_FLAG_COUNT enum value

Dudu Lu (3):
      vsock/virtio: fix accept queue count leak on transport mismatch
      Bluetooth: l2cap: Add missing chan lock in l2cap_ecred_reconf_rsp
      net/sched: sch_cake: fix NAT destination port not being updated in cake_update_flowkeys

Duoming Zhou (1):
      wifi: rtlwifi: pci: fix possible use-after-free caused by unfinished irq_prepare_bcn_tasklet

Enze Li (1):
      scsi: sr: Add memory allocation failure handling for get_capabilities()

Eric Biggers (2):
      dm-verity-fec: correctly reject too-small FEC devices
      dm-verity-fec: correctly reject too-small hash devices

Eric Dumazet (12):
      net: lapbether: handle NETDEV_PRE_TYPE_CHANGE
      tcp: annotate data-races around (tp->write_seq - tp->snd_nxt)
      ipv6: fix possible UAF in icmpv6_rcv()
      net_sched: sch_hhf: annotate data-races in hhf_dump_stats()
      net/sched: sch_pie: annotate data-races in pie_dump_stats()
      net/sched: sch_fq_codel: remove data-races from fq_codel_dump_stats()
      net/sched: sch_red: annotate data-races in red_dump_stats()
      net/sched: sch_sfb: annotate data-races in sfb_dump_stats()
      net/sched: sch_choke: annotate data-races in choke_dump_stats()
      net/sched: sch_fq_pie: annotate data-races in fq_pie_dump_stats()
      net/sched: sch_cake: annotate data-races in cake_dump_stats() (V)
      net/sched: sch_pie: annotate more data-races in pie_dump_stats()

Ethan Nelson-Moore (1):
      net: ethernet: cs89x0: remove stale CONFIG_MACH_MX31ADS reference

Ethan Tidmore (3):
      wifi: brcmfmac: Fix error pointer dereference
      drm/sun4i: Fix resource leaks
      pinctrl: pinctrl-pic32: Fix resource leak

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990A MBIM composition
      USB: serial: option: add Telit Cinterion LE910Cx compositions

Fedor Pchelkin (1):
      platform/x86: dell_rbu: avoid uninit value usage in packet_size_write()

Felix Fietkau (1):
      wifi: mac80211: always free skb on ieee80211_tx_prepare_skb() failure

Felix Gu (5):
      usb: ulpi: fix memory leak on ulpi_register() error paths
      spi: fsl-qspi: Use reinit_completion() for repeated operations
      pmdomain: ti: omap_prm: Fix a reference leak on device node
      clk: imx: imx6q: Fix device node reference leak in pll6_bypassed()
      clk: imx: imx6q: Fix device node reference leak in of_assigned_ldb_sels()

Fernando Fernandez Mancera (2):
      netfilter: nfnetlink_osf: fix out-of-bounds read on option matching
      netfilter: nfnetlink_osf: fix potential NULL dereference in ttl check

Filipe Manana (1):
      btrfs: tracepoints: fix sleep while in atomic context in btrfs_sync_file()

Florian Westphal (7):
      netfilter: nft_set_pipapo_avx2: don't return non-matching entry on expiry
      netfilter: conntrack: add missing netlink policy validations
      netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR
      netfilter: nft_fwd_netdev: check ttl/hl before forwarding
      RDMA/core: Prefer NLA_NUL_STRING
      netfilter: conntrack: remove sprintf usage
      netfilter: nf_conntrack_sip: don't use simple_strtoul

Frank Li (1):
      dmaengine: mxs-dma: Fix missing return value from of_dma_controller_register()

Gabor Juhos (1):
      phy: marvell: mvebu-a3700-utmi: fix incorrect USB2_PHY_CTRL register access

Geert Uytterhoeven (2):
      clk: xgene: Fix mapping leak in xgene_pllclk_init()
      lib/hexdump: print_hex_dump_bytes() calls print_hex_dump_debug()

Gerd Bayer (1):
      PCI: Enable AtomicOps only if Root Port supports them

Goldwyn Rodrigues (1):
      btrfs: tracepoints: get correct superblock from dentry in event btrfs_sync_file()

Gopi Krishna Menon (1):
      thermal/drivers/spear: Fix error condition for reading st,thermal-flags

Greg Jumper (1):
      net/rds: Restrict use of RDS/IB to the initial network namespace

Greg Kroah-Hartman (19):
      xfrm_user: fix info leak in build_mapping()
      i2c: s3c24xx: check the size of the SMBUS message before using it
      HID: alps: fix NULL pointer dereference in alps_raw_event()
      HID: core: clamp report_size in s32ton() to avoid undefined shift
      net: usb: cdc-phonet: fix skb frags[] overflow in rx_complete()
      NFC: digital: Bounds check NFC-A cascade depth in SDD response handler
      ALSA: fireworks: bound device-supplied status before string array lookup
      fbdev: tdfxfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
      usb: gadget: f_ncm: validate minimum block_len in ncm_unwrap_ntb()
      usb: gadget: f_phonet: fix skb frags[] overflow in pn_rx_complete()
      usb: gadget: renesas_usb3: validate endpoint index in standard request handlers
      fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
      ipv6: rpl: reserve mac_len headroom when recompressed SRH grows
      scsi: target: configfs: Bound snprintf() return in tg_pt_gp_members_show()
      usb: usblp: fix heap leak in IEEE 1284 device ID via short response
      usb: usblp: fix uninitialized heap leak via LPGETSTATUS ioctl
      driver core: device.h: remove extern from function prototypes
      sysfs: don't remove existing directory on update failure
      Linux 5.10.258

Guenter Roeck (1):
      ARM: integrator: Fix early initialization

Guido Günther (1):
      arm64: dts: imx8mq-librem5: Don't mark buck3 as always on

Guocai He (1):
      Revert "wifi: cfg80211: stop NAN and P2P in cfg80211_leave"

Gyeyoung Baek (1):
      drm/panfrost: Fix wait_bo ioctl leaking positive return from dma_resv_wait_timeout()

Hamza Mahfooz (1):
      hv_sock: fix ARM64 support

Haoxiang Li (1):
      crypto: ccree - fix a memory leak in cc_mac_digest()

Haoze Xie (1):
      batman-adv: hold claim backbone gateways by reference

Hari Bathini (1):
      powerpc64/bpf: do not increment tailcall count when prog is NULL

Harin Lee (2):
      ALSA: ctxfi: Limit PTP to a single page
      ALSA: ctxfi: Add fallback to default RSR for S/PDIF

Harry Wentland (1):
      drm/amd/display: Fix integer overflow in bios_get_image()

Harshit Mogalapalli (1):
      net: sched: sch_netem: Refactor code in 4-state loss generator

Heiko Schocher (1):
      net: phy: dp83869: fix setting CLK_O_SEL field.

Helge Deller (1):
      parisc: _llseek syscall is only available for 32-bit userspace

Heming Zhao (1):
      ocfs2: split transactions in dio completion to avoid credit exhaustion

Herbert Xu (4):
      padata: Fix pd UAF once and for all
      padata: Remove comment for reorder_work
      crypto: pcrypt - Fix handling of MAY_BACKLOG requests
      crypto: af_alg - Cap AEAD AD length to 0x80000000

Hongling Zeng (1):
      parisc: Fix IRQ leak in LASI driver

HyungJung Joo (1):
      fs/omfs: reject s_sys_blocksize smaller than OMFS_DIR_START

Håkon Bugge (1):
      net/rds: Optimize rds_ib_laddr_check

Ian Rogers (1):
      perf branch: Avoid incrementing NULL

Ido Schimmel (2):
      nexthop: Emit a notification when a nexthop group is modified
      vrf: Fix a potential NPD when removing a port from a VRF

Jacqueline Wong (1):
      tpm: tpm_tis: add error logging for data transfer

Jakub Kicinski (2):
      net: tls: fix off-by-one in sg_chain entry count for wrapped sk_msg ring
      net: tls: prevent chain-after-chain in plain text SG

Jamal Hadi Salim (2):
      net/sched: sch_red: Replace direct dequeue call with peek and qdisc_dequeue_peeked
      net/sched: act_ct: Only release RCU read lock after ct_ft

James Kim (1):
      mtd: docg3: fix use-after-free in docg3_release()

Jamie Iles (1):
      i3c: fix uninitialized variable use in i2c setup

Jan Kara (1):
      quota: Fix race of dquot_scan_active() with quota deactivation

Jane Chu (1):
      Documentation: fix a hugetlbfs reservation statement

Jani Nikula (1):
      string: add mem_is_zero() helper to check if memory area is all zeros

Jann Horn (1):
      Bluetooth: bnep: Fix UAF read of dev->name

Jason Gunthorpe (3):
      RDMA/mlx4: Fix resource leak on error in mlx4_ib_create_srq()
      RDMA/ocrdma: Don't NULL deref uctx on errors in ocrdma_copy_pd_uresp()
      RDMA/vmw_pvrdma: Fix double free on pvrdma_alloc_ucontext() error path

Jens Axboe (2):
      io_uring/poll: fix EPOLL_URING_WAKE sometimes not being honored
      io_uring/poll: fix backport of io_poll_add() changes

Jeongjun Park (3):
      media: as102: fix to not free memory after the device is registered in as102_usb_probe()
      media: hackrf: fix to not free memory after the device is registered in hackrf_probe()
      wifi: rsi: fix kthread lifetime race between self-exit and external-stop

Jiayuan Chen (1):
      nexthop: fix IPv6 route referencing IPv4 nexthop

Jiexun Wang (4):
      af_unix: read UNIX_DIAG_VFS data under unix_state_lock
      batman-adv: reject new tp_meter sessions during teardown
      batman-adv: stop caching unowned originator pointers in BAT IV
      netfilter: xt_policy: fix strict mode inbound policy matching

Jiri Slaby (SUSE) (2):
      wifi: ath5k: do not access array OOB
      6pack: propagage new tty types

Johan Hovold (11):
      spi: zynqmp-gqspi: fix controller deregistration
      spi: topcliff-pch: fix use-after-free on unbind
      regulator: max77650: fix OF node reference imbalance
      regulator: act8945a: fix OF node reference imbalance
      spi: mtk-nor: fix controller deregistration
      spi: imx: fix runtime pm leak on probe deferral
      spi: orion: fix clock imbalance on registration failure
      spi: mpc52xx: fix use-after-free on unbind
      drm/gma500/oaktrail_hdmi: fix i2c adapter leak on setup
      spi: sprd: fix error pointer deref after DMA setup failure
      spi: ti-qspi: fix use-after-free after DMA setup failure

John B. Moore (2):
      drm/amdgpu/gfx9: drop unnecessary 64-bit fence flag check in KIQ
      drm/amdgpu/sdma4: replace BUG_ON with WARN_ON in fence emission

John Walker (1):
      wifi: cfg80211: advance loop vars in cfg80211_merge_profile()

Jonathan Rissanen (1):
      Bluetooth: hci_ldisc: Clear HCI_UART_PROTO_INIT on error

Jonathan Santos (1):
      iio: adc: ad7768-1: fix one-shot mode data acquisition

Joonwon Kang (1):
      mailbox: Prevent out-of-bounds access in of_mbox_index_xlate()

Joseph Qi (2):
      ocfs2: fix out-of-bounds write in ocfs2_write_end_inline
      ocfs2: fix possible deadlock between unlink and dio_end_io_write

Joseph Salisbury (1):
      ASoC: fsl_easrc: fix comment typo

Josh Law (1):
      lib/ts_kmp: fix integer overflow in pattern length calculation

Jun Yan (1):
      arm64: dts: meson-gxl-p230: fix ethernet PHY interrupt number

Junrui Luo (8):
      staging: sm750fb: fix division by zero in ps_to_hz()
      md/raid5: validate payload size before accessing journal metadata
      dm mirror: fix integer overflow in create_dirty_log()
      md/raid10: fix divide-by-zero in setup_geo() with zero far_copies
      dm log: fix out-of-bounds write due to region_count overflow
      ocfs2/dlm: validate qr_numregions in dlm_match_regions()
      ocfs2/dlm: fix off-by-one in dlm_match_regions() region comparison
      scsi: target: core: Fix integer overflow in UNMAP bounds check

Junxi Qian (1):
      nfc: llcp: add missing return after LLCP_CLOSED checks

Justin Chen (1):
      net: bcmgenet: fix off-by-one in bcmgenet_put_txcb

Kai Ma (1):
      netfilter: reject zero shift in nft_bitwise

Kai Zen (1):
      net: rtnetlink: zero ifla_vf_broadcast to avoid stack infoleak in rtnl_fill_vfinfo

Kees Cook (1):
      selftests: lib.mk: Also install "config" and "settings"

Keith Busch (1):
      blk-mq: use quiesced elevator switch when reinitializing queues

Kohei Enju (2):
      i40e: don't advertise IFF_SUPP_NOFCS
      vhost_net: fix sleeping with preempt-disabled in vhost_net_busy_poll()

Konrad Dybcio (2):
      dt-bindings: clock: qcom,dispcc-sc7180: Define MDSS resets
      clk: qcom: dispcc-sc7180: Add missing MDSS resets

Kuninori Morimoto (1):
      ASoC: soc-core: call missing INIT_LIST_HEAD() for card_aux_list

Kurt Kanzenbach (1):
      taprio: Handle short intervals and large packets

Kyle Farnung (1):
      wifi: ath11k: clear shared SRNG pointer state on restart

Lee Jones (1):
      tipc: fix double-free in tipc_buf_append()

Lee, Chun-Yi (1):
      thermal/int340x_thermal: handle data_vault when the value is ZERO_SIZE_PTR

Lei Huang (1):
      ALSA: hda/realtek: fix code style (ERROR: else should follow close brace '}')

Leo Yan (1):
      perf expr: Return -EINVAL for syntax error in expr__find_ids()

Leonid Ravich (1):
      IB/mad: Don't call to function that might sleep while in atomic context

Li Xiasong (1):
      netfilter: nft_ct: fix missing expect put in obj eval

Lin YuChen (1):
      staging: rtl8723bs: initialize le_tmp64 in rtw_BIP_verify()

Linus Walleij (2):
      net: ethernet: cortina: Make RX SKB per-port
      net: ethernet: cortina: Carry over frag counter

Liu Jian (1):
      bpf, sockmap: Fix an infinite loop error when len is 0 in tcp_bpf_recvmsg_parser()

Long Li (1):
      PCI: hv: Set default NUMA node to 0 for devices without affinity info

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix printing wrong information if SDU length exceeds MTU

Lukas Bulwahn (1):
      HID: quirks: really enable the intended work around for appledisplay

Lukas Wunner (1):
      PCI/AER: Stop ruling out unbound devices as error source

Luke D. Jones (1):
      ALSA: hda/realtek: Whitespace fix

Luxiao Xu (3):
      rxrpc: fix reference count leak in rxrpc_server_keyring()
      net: strparser: fix skb_head leak in strp_abort_strp()
      batman-adv: fix tp_meter counter underflow during shutdown

Lyes Bourennani (1):
      batman-adv: fix integer overflow on buff_pos

Ma Ke (1):
      powerpc/warp: Fix error handling in pika_dtm_thread

Maciej Fijalkowski (1):
      xsk: tighten UMEM headroom validation to account for tailroom and min frame

Maciej W. Rozycki (3):
      MIPS: Always record SEGBITS in cpu_data.vmbits
      MIPS: mm: Suppress TLB uniquification on EHINV hardware
      MIPS: mm: Rewrite TLB uniquification for the hidden bit feature

Manivannan Sadhasivam (1):
      net: qrtr: ns: Fix use-after-free in driver remove()

Maoyi Xie (1):
      ip6_gre: Use cached t->net in ip6erspan_changelink().

Marcelo Ricardo Leitner (1):
      net/sched: act_ct: fix ref leak when switching zones

Mario Limonciello (AMD) (1):
      firmware: dmi: Correct an indexing error in dmi.h

Mark Harmstone (1):
      btrfs: fix double-decrement of bytes_may_use in submit_one_async_extent()

Martin Kepplinger (2):
      arm64: dts: imx8mq-librem5-r3: workaround i2c1 issue with 1GHz cpu voltage
      arm64: dts: imx8mq-librem5: set regulators boot-on

Masami Hiramatsu (Google) (1):
      tracing: Do not call map->ops->elt_free() if elt_alloc() fails

Mashiro Chen (1):
      net: hamradio: 6pack: fix uninit-value in sixpack_receive_buf

Matt Vollrath (1):
      e1000e: Unroll PTP in probe error handling

Maíra Canal (3):
      drm/vc4: Fix memory leak of BO array in hang state
      drm/vc4: Fix a memory leak in hang state error path
      drm/vc4: Protect madv read in vc4_gem_object_mmap() with madv_lock

Michael Bommarito (11):
      um: drivers: call kernel_strrchr() explicitly in cow_user.c
      udf: reject descriptors with oversized CRC length
      isofs: validate Rock Ridge CE continuation extent against volume size
      isofs: validate block number from NFS file handle in isofs_export_iget
      RDMA/rxe: Reject unknown opcodes before ICRC processing
      sctp: fix OOB write to userspace in sctp_getsockopt_peer_auth_chunks
      net/rds: zero per-item info buffer before handing it to visitors
      ipv4: raw: reject IP_HDRINCL packets with ihl < 5
      ixgbevf: fix use-after-free in VEPA multicast source pruning
      scsi: isci: Fix use-after-free in device removal path
      RDMA/siw: Reject MPA FPDU length underflow before signed receive math

Michal Pecio (1):
      usb: xhci: Make usb_host_endpoint.hcpriv survive endpoint_disable()

Mikko Perttunen (2):
      memory: tegra124-emc: Fix dll_change check
      memory: tegra30-emc: Fix dll_change check

Miklos Szeredi (1):
      fanotify: fix false positive on permission events

Mikulas Patocka (2):
      dm: don't report warning when doing deferred remove
      dm: fix a buffer overflow in ioctl processing

Ming-Hung Tsai (7):
      dm cache: fix null-deref with concurrent writes in passthrough mode
      dm cache: fix write path cache coherency in passthrough mode
      dm cache policy smq: fix missing locks in invalidating cache blocks
      dm cache: fix concurrent write failure in passthrough mode
      dm cache: support shrinking the origin device
      dm cache: fix dirty mapping checking in passthrough mode switching
      dm cache metadata: fix memory leak on metadata abort retry

Mingming Cao (1):
      ibmveth: Disable GSO for packets with small MSS

Mingyu Wang (1):
      Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths

Mingzhe Zou (2):
      bcache: fix cached_dev.sb_bio use-after-free and crash
      bcache: fix uninitialized closure object

Minh Nguyen (1):
      vsock/vmci: fix UAF when peer resets connection during handshake

Minhong He (1):
      ipv6: add NULL checks for idev in SRv6 paths

Morduan Zang (1):
      net: usb: rtl8150: free skb on usb_submit_urb() failure in xmit

Nan Li (2):
      net/rds: handle zerocopy send cleanup before the message is queued
      netfilter: ipset: stop hash:* range iteration at end

Nathan Chancellor (2):
      drm/amd/display: Do not add '-mhard-float' to calcs, dsc, and dcn30 FP files for clang
      scripts/dtc: Remove unused dts_version in dtc-lexer.l

Nathan Rebello (1):
      usbip: validate number_of_packets in usbip_pack_ret_submit()

Naval Alcalá (1):
      iommu/vt-d: Disable DMAR for Intel Q35 IGFX

Nicholas Carlini (1):
      io-wq: check that the predecessor is hashed in io_wq_remove_pending()

Nicolai Buchwitz (1):
      net: bcmgenet: keep RBUF EEE/PM disabled

Nikola Z. Ivanov (1):
      netdevsim: zero initialize struct iphdr in dummy sk_buff

Norbert Szetei (1):
      vsock: fix buffer size clamping order

Nuno Sa (1):
      dev_printk: add new dev_err_probe() helpers

Oleg Nesterov (1):
      x86/uprobes: Fix XOL allocation failure for 32-bit tasks

Oleksij Rempel (1):
      net: usb: lan78xx: Fix double free issue with interrupt buffer allocation

Oliver Neukum (3):
      media: rc: xbox_remote: heed DMA restrictions
      media: rc: streamzap: Error handling in probe
      HID: usbhid: fix deadlock in hid_post_reset()

Osama Abdelkader (1):
      drm/bridge: megachips: remove bridge when irq request fails

Pablo Neira Ayuso (3):
      netfilter: nft_osf: restrict it to ipv4
      netfilter: xtables: restrict several matches to inet family
      netfilter: arp_tables: fix IEEE1394 ARP payload parsing

Paul Geurts (1):
      NFC: trf7970a: Ignore antenna noise when checking for RF field

Paul Moses (1):
      crypto: ccp - copy IV using skcipher ivsize

Pauli Virtanen (1):
      Bluetooth: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFER

Peng Li (2):
      net: lapbether: remove trailing whitespaces
      net: lapbether: replace comparison to NULL with "lapbeth_get_x25_dev"

Pengpeng Hou (6):
      wifi: wl1251: validate packet IDs before indexing tx_frames
      wifi: brcmfmac: validate bsscfg indices in IF events
      tracing/probe: reject non-closed empty immediate strings
      rxrpc: proc: size address buffers for %pISpc output
      tracing: Rebuild full_name on each hist_field_name() call
      s390/debug: Reject zero-length input before trimming a newline

Qingfang Deng (2):
      pppoe: drop PFC frames
      flow_dissector: do not dissect PPPoE PFC frames

Qingqing Yang (1):
      flow_dissector: Do not count vlan tags inside tunnel payload

Qu Wenruo (1):
      btrfs: merge PAGE_CLEAR_DIRTY and PAGE_SET_WRITEBACK to PAGE_START_WRITEBACK

Quinn Tran (1):
      scsi: qla2xxx: Fix warning message due to adisc being flushed

Rafael J. Wysocki (2):
      platform/surface: surfacepro3_button: Drop wakeup source on remove
      platform/x86: intel-hid: Check ACPI_HANDLE() against NULL

Rafał Miłecki (1):
      ARM: dts: mediatek: mt7623: fix efuse fallback compatible

Rajat Gupta (1):
      fbdev: udlfb: add vm_ops to dlfb_ops_mmap to prevent use-after-free

Randy Dunlap (1):
      tty: hvc_iucv: fix off-by-one in number of supported devices

Raphael Zimmer (4):
      libceph: Fix potential out-of-bounds access in osdmap_decode()
      libceph: Fix potential null-ptr-deref in decode_choose_args()
      libceph: Fix potential out-of-bounds access in crush_decode()
      libceph: handle rbtree insertion error in decode_choose_args()

Ren Wei (1):
      netfilter: xt_multiport: validate range encoding in checkentry

René Rebe (1):
      PCMCIA: Fix garbled log messages for KERN_CONT

Ricardo B. Marlière (3):
      ktest: Avoid undef warning when WARNINGS_FILE is unset
      ktest: Honor empty per-test option overrides
      ktest: Run POST_KTEST hooks on failure and cancellation

Ricardo Ribalda (2):
      media: uvcvideo: Allow extra entities
      media: uvcvideo: Enable VB2_DMABUF for metadata stream

Richard Genoud (1):
      mtd: rawnand: sunxi: fix sunxi_nfc_hw_ecc_read_extra_oob

Ritesh Harjani (IBM) (1):
      mm/kasan: fix double free for kasan pXds

Rob Clark (1):
      drm/msm/a6xx: Fix HLSQ register dumping

Rong Zhang (1):
      Revert "ALSA: usb: Increase volume range that triggers a warning"

Rosen Penev (2):
      irqchip/ath79-cpu: Remove unused function
      net: ag71xx: check error for platform_get_irq

Ruide Cao (2):
      net: sched: act_csum: validate nested VLAN headers
      batman-adv: fix fragment reassembly length accounting

Ruijie Li (3):
      net/smc: avoid early lgr access in smc_clc_wait_msg
      xfrm: provide message size for XFRM_MSG_MAPPING
      batman-adv: clear current gateway during teardown

Ruslan Valiyev (2):
      media: vidtv: fix NULL pointer dereference in vidtv_channel_pmt_match_sections
      media: vidtv: fix nfeeds state corruption on start_streaming failure

Sakari Ailus (1):
      staging: media: atomisp: Disallow all private IOCTLs

Samuel Page (2):
      can: raw: fix ro->uniq use-after-free in raw_rcv()
      fuse: reject oversized dirents in page cache

Sander Vanheule (2):
      ASoC: sti: Return errors from regmap_field_alloc()
      ASoC: sti: use managed regmap_field allocations

Sasha Levin (4):
      checkpatch: add support for Assisted-by tag
      Revert "scsi: ufs: core: Improve SCSI abort handling"
      Revert "riscv: Sparse-Memory/vmemmap out-of-bounds fix"
      Revert "x86/vdso: Fix output operand size of RDPID"

Sean Christopherson (5):
      KVM: SEV: Drop WARN on large size for KVM_MEMORY_ENCRYPT_REG_REGION
      KVM: x86: Use scratch field in MMIO fragment to hold small write values
      crypto: ccp: Don't attempt to copy CSR to userspace if PSP command failed
      crypto: ccp: Don't attempt to copy PDH cert to userspace if PSP command failed
      crypto: ccp: Don't attempt to copy ID to userspace if PSP command failed

Sebastian Brzezinka (1):
      drm/i915/gt: fix refcount underflow in intel_engine_park_heartbeat

Sebastian Krzyszkowiak (6):
      arm64: dts: imx8mq: Set the correct gpu_ahb clock frequency
      arm64: dts: imx8mq-librem5: Set the DVS voltages lower
      arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage to 0.81V
      Revert "arm64: dts: imx8mq-librem5: Set the DVS voltages lower"
      arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage up to 0.85V
      clk: imx8mq: Correct the CSI PHY sels

Sebastian Reichel (1):
      drm/panel: simple: Correct G190EAN01 prepare timing

Sergey Shtylyov (1):
      media: dib8000: avoid division by 0 in dib8000_set_dds()

Sergio Correia (2):
      audit: fix incorrect inheritable capability in CAPSET records
      audit: enforce AUDIT_LOCKED for AUDIT_TRIM and AUDIT_MAKE_EQUIV

SeungJu Cheon (1):
      sound: ua101: fix division by zero at probe

Shengjiu Wang (3):
      ASoC: fsl_easrc: Check the variable range in fsl_easrc_iec958_put_bits()
      ASoC: fsl_easrc: Fix value type in fsl_easrc_iec958_get_bits()
      ASoC: fsl_easrc: Change the type for iec958 channel status controls

Shivam Kalra (1):
      ACPI: video: force native backlight on HP OMEN 16 (8A44)

Shrikanth Hegde (1):
      cpuidle: powerpc: avoid double clear when breaking snooze

Shuai Xue (1):
      PCI/AER: Clear only error bits in PCIe Device Status

Simon Liebold (1):
      selftests/mqueue: Fix incorrectly named file

Siwei Zhang (3):
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_new_connection_cb()
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_state_change_cb()
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()

Sohei Koyama (1):
      ext4: fix missing brelse() in ext4_xattr_inode_dec_ref_all()

Sourabh Jain (1):
      powerpc/crash: fix backup region offset update to elfcorehdr

Stefan Wiehler (1):
      mips: mm: Allocate tlb_vpn array atomically

Stephen Hemminger (3):
      net/sched: netem: fix probability gaps in 4-state loss model
      net/sched: netem: fix queue limit check to include reordered packets
      net/sched: netem: validate slot configuration

Steven Rostedt (1):
      ring-buffer: Fix reporting of missed events in iterator

Sumit Semwal (1):
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Add DSI and panel bits

Sun Jian (1):
      bpf: reject short IPv4/IPv6 inputs in bpf_prog_test_run_skb

Sven Eckelmann (10):
      batman-adv: bla: prevent use-after-free when deleting claims
      batman-adv: bla: only purge non-released claims
      batman-adv: bla: put backbone reference on failed claim hash insert
      batman-adv: mcast: fix use-after-free in orig_node RCU release
      batman-adv: dat: handle forward allocation error
      batman-adv: frag: disallow unicast fragment in fragment
      batman-adv: bla: fix report_work leak on backbone_gw purge
      batman-adv: tp_meter: avoid use of uninit sender vars
      batman-adv: tt: fix negative last_changeset_len
      batman-adv: tt: fix negative tt_buff_len

T Pratham (1):
      crypto: sa2ul - Fix AEAD fallback algorithm names

Taegu Ha (1):
      ppp: require CAP_NET_ADMIN in target netns for unattached ioctls

Takashi Iwai (6):
      ALSA: caiaq: Handle probe errors properly
      ALSA: caiaq: Fix potentially leftover ep1_in_urb at error path
      ALSA: caiaq: Don't abort when no input device is available
      ALSA: usb-audio: Avoid potential endless loop in convert_chmap_v3()
      ALSA: compress: Drop unused functions
      ALSA: asihpi: Fix potential OOB array access at reading cache

Tejas Bharambe (1):
      ocfs2: fix use-after-free in ocfs2_fault() when VM_FAULT_RETRY

Thomas Bogendoerfer (1):
      MIPS: mm: kmalloc tlb_vpn array to avoid stack overflow

Thomas Fourier (1):
      crypto: hisilicon - Fix dma_unmap_single() direction

Thomas Huth (1):
      efi/capsule-loader: fix incorrect sizeof in phys array reallocation

Thomas Zimmermann (1):
      firmware: google: framebuffer: Do not mark framebuffer as busy

Thorsten Blum (5):
      crypto: atmel-aes - Fix 3-page memory leak in atmel_aes_buff_cleanup
      crypto: atmel-ecc - Release client on allocation failure
      crypto: atmel-tdes - fix DMA sync direction
      thermal/drivers/sprd: Fix temperature clamping in sprd_thm_temp_to_rawdata
      thermal/drivers/sprd: Fix raw temperature clamping in sprd_thm_rawdata_to_temp

Timur Kristóf (8):
      drm/amd/pm/ci: Use highest MCLK on CI when MCLK DPM is disabled
      drm/amd/pm/ci: Disable MCLK DPM on problematic CI ASICs
      drm/amd/pm/ci: Fix powertune defaults for Hawaii 0x67B0
      drm/amd/pm/ci: Clear EnabledForActivity field for memory levels
      drm/amd/pm/ci: Fill DW8 fields from SMC
      drm/amdgpu/gfx6: Support harvested SI chips with disabled TCCs (v2)
      drm/amd/display: Allow DCE link encoder without AUX registers
      drm/amd/display: Read EDID from VBIOS embedded panel info

Tomasz Merta (1):
      ASoC: stm32_sai: fix incorrect BCLK polarity for DSP_A/B, LEFT_J

Tristan Madani (2):
      wifi: b43legacy: enforce bounds check on firmware key index in RX path
      wifi: b43: enforce bounds check on firmware key index in b43_rx()

Tyllis Xu (3):
      misc: ibmasm: fix OOB MMIO read in ibmasm_handle_mouse_interrupt()
      ibmasm: fix OOB reads in command_file_write due to missing size checks
      ibmasm: fix heap over-read in ibmasm_send_i2o_message()

Val Packett (2):
      clk: qcom: dispcc-sm8250: Use shared ops on the mdss vsync clk
      clk: qcom: dispcc-sm8250: Enable parents for pixel clocks

Vasiliy Kovalev (1):
      ext2: reject inodes with zero i_nlink and valid mode in ext2_iget()

Vasily Gorbik (1):
      s390/debug: Reject zero-length input in debug_input_flush_fn()

Viacheslav Dubeyko (1):
      ceph: fix a buffer leak in __ceph_setxattr()

Vidya Sagar (2):
      PCI: tegra194: Use devm_gpiod_get_optional() to parse "nvidia,refclk-select"
      PCI: tegra194: Disable direct speed change for Endpoint mode

Vinicius Costa Gomes (1):
      net/sched: taprio: fix use-after-free in advance_sched() on schedule switch

Vladimir Oltean (6):
      net/sched: taprio: stop going through private ops for dequeue and peek
      net/sched: taprio: replace safety precautions with comments
      net/sched: taprio: continue with other TXQs if one dequeue() failed
      net/sched: taprio: refactor one skb dequeue from TXQ to separate function
      net/sched: taprio: rename close_time to end_time
      net: dsa: sja1105: fix kasan out-of-bounds warning in sja1105_table_delete_entry()

Waiman Long (2):
      blk-cgroup: Reinit blkg_iostat_set after clearing in blkcg_reset_stats()
      selftest: memcg: skip memcg_sock test if address family not supported

Wang Jie (1):
      rxrpc: only handle RESPONSE during service challenge

Weiming Shi (5):
      bpf: fix end-of-list detection in cgroup_storage_get_next_key()
      openvswitch: cap upcall PID array size and pre-size vport replies
      slip: reject VJ receive packets on instances with no rstate array
      slip: bound decode() reads against the compressed packet length
      bareudp: fix NULL pointer dereference in bareudp_fill_metadata_dst()

Wenyuan Li (1):
      can: mcp251x: add error handling for power enable in open and resume

Wojciech Drewek (1):
      flow_dissector: Add PPPoE dissectors

Wolfram Sang (5):
      mailbox: mailbox-test: free channels on probe error
      mailbox: add sanity check for channel array
      mailbox: mailbox-test: don't free the reused channel
      mailbox: mailbox-test: initialize struct earlier
      mailbox: mailbox-test: make data_ready a per-instance variable

Xiang Mei (2):
      netfilter: nfnetlink_log: initialize nfgenmsg in NLMSG_DONE terminator
      netfilter: nfnetlink_osf: fix divide-by-zero in OSF_WSS_MODULO

Xie He (1):
      net: lapbether: Close the LAPB device before its underlying Ethernet device closes

Xin Long (2):
      netfilter: skip recording stale or retransmitted INIT
      sctp: discard stale INIT after handshake completion

Yang Erkun (1):
      scsi: sg: Resolve soft lockup issue when opening /dev/sgX

Yannick Vignon (2):
      net: taprio offload: enforce qdisc to netdev queue mapping
      net/sched: taprio: Fix init procedure

Yasuaki Torimaru (1):
      xfrm: clear trailing padding in build_polexpire()

Yilin Zhu (1):
      ipv6: xfrm6: release dst on error in xfrm6_rcv_encap()

Yingnan Zhang (1):
      ipvs: fix MTU check for GSO packets in tunnel mode

Yiyang Chen (1):
      taskstats: set version in TGID exit notifications

Yongzhi Liu (1):
      drm/amd/display: Fix memory leak

Yosry Ahmed (3):
      KVM: nSVM: Sync interrupt shadow to cached vmcb12 after VMRUN of L2
      KVM: nSVM: Ensure AVIC is inhibited when restoring a vCPU to guest mode
      KVM: nSVM: Clear GIF on nested #VMEXIT(INVALID)

Yu-Chun Lin (1):
      pinctrl: abx500: Fix type of 'argument' variable

Yucheng Lu (1):
      crypto: authencesn - reject short ahash digests during instance creation

Yuho Choi (1):
      fbdev: offb: fix PCI device reference leak on probe failure

Yuqi Xu (1):
      rxrpc: reject undecryptable rxkad response tickets

Zhan Jun (1):
      net: usb: rtl8150: fix use-after-free in rtl8150_start_xmit()

Zhang Xiaoxu (1):
      cifs: Fix connections leak when tlink setup failed

ZhengYuan Huang (4):
      ocfs2: handle invalid dinode in ocfs2_group_extend
      ocfs2: fix listxattr handling when the buffer is full
      ocfs2: validate bg_bits during freefrag scan
      ocfs2: validate group add input before caching

Zhengchao Shao (2):
      net: sched: gred/red: remove unused variables in struct red_stats
      net: sched: choke: remove unused variables in struct choke_sched_data

Zhengchuan Liang (3):
      netfilter: ip6t_eui64: reject invalid MAC header for all packets
      net: caif: clear client service pointer on teardown
      netfilter: ip6t_hbh: reject oversized option lists

Zijing Yin (1):
      phonet/pep: disable BH around forwarded sk_receive_skb()

Zilin Guan (1):
      wifi: mwifiex: Fix memory leak in mwifiex_11n_aggregate_pkt()

Ziqing Chen (1):
      ALSA: control: Validate buf_len before strnlen() in snd_ctl_elem_init_enum_names()

Zoran Ilievski (1):
      net: atlantic: preserve PCI wake-from-D3 on shutdown when WOL enabled

cuitao (1):
      cgroup/rdma: fix integer overflow in rdmacg_try_charge()

hkbinbin (1):
      RDMA/rxe: Validate pad and ICRC before payload_size() in rxe_rcv

hongnanli (1):
      fs/ocfs2: fix comments mentioning i_mutex

leo vriska (1):
      HID: quirks: add HID_QUIRK_ALWAYS_POLL for 8BitDo Pro 3

наб (1):
      tty: hvc: remove HVC_IUCV_MAGIC

