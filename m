Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0855A375ADF;
	Sun,  9 Aug 2026 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786300584; cv=none; b=hBsaNol4JsyCd54gKiV6wyMFtWkqMmY6uR4uVU3Eao4p6uD+57E7mjhxQFWP09XrVKaS+QQyFC9JvPETT2x6Q9Sg7argwMrlZ6ZDhiReyqHp63k1KyUc6S1DVqoki2uBe5e/ZAvO/c1TFxvioyPNDzo7ACVphS0IH4+NhBBXQog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786300584; c=relaxed/simple;
	bh=xv9BsUMSx47+U9a9liS6c0jhUaYJb6/JNMQ9JyhO088=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rbw/0KbLZCtZay0OGyKBIUBYZKmWo2X2tDhdbaUcSd/pUotpJWJsUAMnoA1Z4f6Hb83/GKv0m2+tMcZO6MGyGqsmDKr/XzEs0q1kN32rwjmA2elUc50x3KWkwaAkrxWEfbLeszTyBu51lMGoXxZbAqHnv9WVPA2eOPf/A9mE148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eBAEpVqg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eBAEpVqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8711F00A3A;
	Sun,  9 Aug 2026 18:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786300581;
	bh=u7lcxS2QpYlhBrS62QvOjnWmnvRxT5bSfEtkuwa5Uys=;
	h=From:To:Cc:Subject:Date;
	b=eBAEpVqg2K9KGL5TFn0UNJdckdKGgpcch7T3OlCJy9pT0a/MddyoxthKmNPkg7nzF
	 9d26h+2bmzXf7AehBNYwsiica5l76KohFqR302EFsVi4ySOXtmp6jydm/HUeytSByT
	 4ZwPEoJx6y37vEPYJvJmAHw1qEJwFhG8pb7YZOqg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.103
Date: Sun,  9 Aug 2026 20:34:44 +0200
Message-ID: <2026080944-sediment-diocese-e9c3@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.103 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/dev-tools/kmemleak.rst                          |    1 
 Documentation/hwmon/ina2xx.rst                                |   67 
 Makefile                                                      |    2 
 arch/powerpc/boot/simpleboot.c                                |    2 
 arch/powerpc/boot/treeboot-akebono.c                          |    2 
 arch/powerpc/boot/treeboot-currituck.c                        |    2 
 arch/powerpc/platforms/ps3/mm.c                               |    1 
 arch/riscv/mm/init.c                                          |    4 
 arch/s390/kvm/pci.c                                           |   28 
 arch/s390/pci/pci_mmio.c                                      |    1 
 arch/um/drivers/chan_user.c                                   |    2 
 arch/um/drivers/ubd_kern.c                                    |    1 
 arch/um/drivers/vector_kern.c                                 |    3 
 arch/um/include/shared/os.h                                   |    2 
 arch/um/os-Linux/process.c                                    |    6 
 arch/um/os-Linux/sigio.c                                      |    1 
 arch/um/os-Linux/signal.c                                     |    3 
 arch/um/os-Linux/skas/process.c                               |    3 
 arch/x86/kvm/svm/avic.c                                       |    8 
 drivers/accel/qaic/qaic_control.c                             |    2 
 drivers/ata/ahci.h                                            |   17 
 drivers/ata/ahci_brcm.c                                       |    3 
 drivers/ata/ahci_ceva.c                                       |   24 
 drivers/ata/libahci.c                                         |    1 
 drivers/ata/libahci_platform.c                                |   38 
 drivers/ata/libata-eh.c                                       |    8 
 drivers/ata/libata-sata.c                                     |    2 
 drivers/ata/sata_mv.c                                         |    2 
 drivers/block/ublk_drv.c                                      |    9 
 drivers/bluetooth/btintel.c                                   |    3 
 drivers/bluetooth/btmtk.c                                     |   50 
 drivers/bluetooth/btusb.c                                     |   30 
 drivers/cpufreq/powernow-k8.c                                 |    1 
 drivers/dma/idxd/cdev.c                                       |    4 
 drivers/dma/sun6i-dma.c                                       |   11 
 drivers/gpio/gpio-pca953x.c                                   |   15 
 drivers/gpio/gpio-pch.c                                       |   28 
 drivers/gpio/gpio-sloppy-logic-analyzer.c                     |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                    |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                        |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c                       |   71 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                       |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                       |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                       |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c                   |   30 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                       |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h                       |   22 
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c                      |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                    |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                       |   40 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h                       |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c                       |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                       |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c                       |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                        |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c                    |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c                     |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c                   |   12 
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c                         |    6 
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c                         |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                      |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_events.c                       |   23 
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c                      |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c        |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c                        |    2 
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c         |   20 
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c       |   16 
 drivers/gpu/drm/armada/armada_fbdev.c                         |   12 
 drivers/gpu/drm/display/drm_dp_helper.c                       |   12 
 drivers/gpu/drm/drm_exec.c                                    |    6 
 drivers/gpu/drm/drm_fb_helper.c                               |   41 
 drivers/gpu/drm/drm_fbdev_dma.c                               |   12 
 drivers/gpu/drm/drm_fbdev_shmem.c                             |   12 
 drivers/gpu/drm/drm_fbdev_ttm.c                               |   12 
 drivers/gpu/drm/drm_gpuvm.c                                   |    3 
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c                  |    2 
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c                     |    9 
 drivers/gpu/drm/gma500/fbdev.c                                |   13 
 drivers/gpu/drm/i915/display/intel_fbdev.c                    |    9 
 drivers/gpu/drm/i915/display/intel_hdcp.c                     |  699 +++++-----
 drivers/gpu/drm/i915/display/intel_hdcp_gsc.c                 |    9 
 drivers/gpu/drm/i915/display/intel_hdcp_gsc.h                 |    5 
 drivers/gpu/drm/i915/display/intel_hdcp_gsc_message.h         |    3 
 drivers/gpu/drm/i915/display/intel_vrr.c                      |   10 
 drivers/gpu/drm/imagination/pvr_job.c                         |    2 
 drivers/gpu/drm/imagination/pvr_queue.c                       |    5 
 drivers/gpu/drm/imagination/pvr_queue.h                       |    2 
 drivers/gpu/drm/lima/lima_gem.c                               |    2 
 drivers/gpu/drm/lima/lima_sched.c                             |    6 
 drivers/gpu/drm/lima/lima_sched.h                             |    3 
 drivers/gpu/drm/mediatek/mtk_crtc.c                           |    6 
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c               |    7 
 drivers/gpu/drm/msm/msm_fbdev.c                               |    9 
 drivers/gpu/drm/msm/msm_gem_submit.c                          |    8 
 drivers/gpu/drm/nouveau/nouveau_sched.c                       |    3 
 drivers/gpu/drm/omapdrm/omap_fbdev.c                          |    9 
 drivers/gpu/drm/panfrost/panfrost_drv.c                       |    2 
 drivers/gpu/drm/panthor/panthor_drv.c                         |    3 
 drivers/gpu/drm/panthor/panthor_fw.c                          |   47 
 drivers/gpu/drm/panthor/panthor_mmu.c                         |    2 
 drivers/gpu/drm/panthor/panthor_sched.c                       |    5 
 drivers/gpu/drm/panthor/panthor_sched.h                       |    3 
 drivers/gpu/drm/radeon/radeon_fbdev.c                         |   13 
 drivers/gpu/drm/scheduler/sched_fence.c                       |    4 
 drivers/gpu/drm/scheduler/sched_main.c                        |    7 
 drivers/gpu/drm/tegra/fbdev.c                                 |   18 
 drivers/gpu/drm/v3d/v3d_submit.c                              |    2 
 drivers/gpu/drm/vc4/vc4_irq.c                                 |    2 
 drivers/gpu/drm/vc4/vc4_validate.c                            |   29 
 drivers/gpu/drm/vmwgfx/ttm_object.c                           |    7 
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c                          |   39 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                       |   20 
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c                      |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c                        |   13 
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c                          |   17 
 drivers/gpu/drm/xe/Makefile                                   |    1 
 drivers/gpu/drm/xe/display/xe_hdcp_gsc.c                      |    7 
 drivers/gpu/drm/xe/xe_bo.c                                    |   33 
 drivers/gpu/drm/xe/xe_bo.h                                    |   10 
 drivers/gpu/drm/xe/xe_bo_types.h                              |    2 
 drivers/gpu/drm/xe/xe_dma_buf.c                               |    6 
 drivers/gpu/drm/xe/xe_exec.c                                  |   22 
 drivers/gpu/drm/xe/xe_gt.c                                    |    4 
 drivers/gpu/drm/xe/xe_gt_debugfs.c                            |    4 
 drivers/gpu/drm/xe/xe_gt_printk.h                             |   31 
 drivers/gpu/drm/xe/xe_hw_engine.c                             |    3 
 drivers/gpu/drm/xe/xe_hw_engine_types.h                       |    8 
 drivers/gpu/drm/xe/xe_oa.c                                    |    7 
 drivers/gpu/drm/xe/xe_oa_types.h                              |    3 
 drivers/gpu/drm/xe/xe_pagefault.c                             |   65 
 drivers/gpu/drm/xe/xe_pagefault.h                             |   19 
 drivers/gpu/drm/xe/xe_pagefault_types.h                       |  136 +
 drivers/gpu/drm/xe/xe_pt.c                                    |    3 
 drivers/gpu/drm/xe/xe_reg_sr.c                                |   53 
 drivers/gpu/drm/xe/xe_reg_whitelist.c                         |  147 +-
 drivers/gpu/drm/xe/xe_reg_whitelist.h                         |    4 
 drivers/gpu/drm/xe/xe_sched_job.c                             |    3 
 drivers/gpu/drm/xe/xe_vm.c                                    |    3 
 drivers/hid/hid-logitech-dj.c                                 |   28 
 drivers/hv/vmbus_drv.c                                        |   13 
 drivers/hwmon/Kconfig                                         |    5 
 drivers/hwmon/adt7470.c                                       |  129 +
 drivers/hwmon/ina2xx.c                                        |  251 +++
 drivers/hwmon/lm90.c                                          |    4 
 drivers/hwmon/ltc4282.c                                       |    4 
 drivers/hwmon/nct6775-core.c                                  |   20 
 drivers/hwmon/npcm750-pwm-fan.c                               |   11 
 drivers/hwmon/nzxt-smart2.c                                   |    2 
 drivers/hwmon/pmbus/pmbus_core.c                              |    7 
 drivers/hwmon/sht3x.c                                         |    9 
 drivers/i2c/busses/i2c-amd-mp2-plat.c                         |    4 
 drivers/i2c/busses/i2c-bcm-iproc.c                            |   11 
 drivers/i2c/busses/i2c-imx.c                                  |    9 
 drivers/i2c/busses/i2c-jz4780.c                               |    5 
 drivers/iommu/iova.c                                          |    6 
 drivers/media/i2c/imx219.c                                    |   31 
 drivers/media/platform/chips-media/wave5/wave5-hw.c           |    3 
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c      |    5 
 drivers/media/platform/chips-media/wave5/wave5-vpuapi.h       |    1 
 drivers/net/can/c_can/c_can_main.c                            |    8 
 drivers/net/can/ctucanfd/ctucanfd_base.c                      |   14 
 drivers/net/can/ctucanfd/ctucanfd_pci.c                       |    3 
 drivers/net/can/dev/skb.c                                     |    2 
 drivers/net/can/softing/softing_fw.c                          |   46 
 drivers/net/can/usb/ems_usb.c                                 |   43 
 drivers/net/can/usb/etas_es58x/es58x_core.c                   |    1 
 drivers/net/can/usb/gs_usb.c                                  |    4 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c             |    1 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c              |   13 
 drivers/net/can/usb/peak_usb/pcan_usb_core.c                  |    1 
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c                    |   40 
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c                   |   20 
 drivers/net/dsa/mt7530-mdio.c                                 |   11 
 drivers/net/dsa/mt7530.c                                      |   58 
 drivers/net/ethernet/airoha/airoha_eth.c                      |    2 
 drivers/net/ethernet/intel/e1000/e1000_main.c                 |    2 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                  |   10 
 drivers/net/ethernet/intel/ice/ice_main.c                     |   10 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                    |    2 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                   |    5 
 drivers/net/ethernet/intel/idpf/idpf_txrx.h                   |    2 
 drivers/net/ethernet/intel/igbvf/netdev.c                     |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c          |    2 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                   |   58 
 drivers/net/ethernet/mediatek/mtk_eth_soc.h                   |    7 
 drivers/net/ethernet/nvidia/forcedeth.c                       |    4 
 drivers/net/ethernet/qlogic/qede/qede_main.c                  |   44 
 drivers/net/ethernet/realtek/rtase/rtase_main.c               |    3 
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c               |   14 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                   |    2 
 drivers/net/netconsole.c                                      |    3 
 drivers/net/phy/phylink.c                                     |   29 
 drivers/net/veth.c                                            |    4 
 drivers/net/vxlan/vxlan_core.c                                |   15 
 drivers/net/wireless/ath/ath6kl/txrx.c                        |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c     |   16 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h        |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c       |    4 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c       |   46 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c       |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c       |   14 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h       |    1 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c        |    3 
 drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h |    2 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c          |    2 
 drivers/of/of_reserved_mem.c                                  |   87 +
 drivers/phy/xilinx/phy-zynqmp.c                               |  130 +
 drivers/pinctrl/Kconfig                                       |    2 
 drivers/pinctrl/devicetree.c                                  |    4 
 drivers/pinctrl/pinctrl-amd.c                                 |    3 
 drivers/pinctrl/qcom/pinctrl-msm.c                            |    8 
 drivers/pinctrl/qcom/pinctrl-sc8280xp.c                       |   21 
 drivers/power/supply/bq25890_charger.c                        |    2 
 drivers/power/supply/max17040_battery.c                       |    6 
 drivers/s390/block/dasd_eckd.c                                |   11 
 drivers/s390/block/dasd_ioctl.c                               |    2 
 drivers/s390/crypto/zcrypt_api.c                              |    2 
 drivers/s390/crypto/zcrypt_ccamisc.c                          |    6 
 drivers/s390/net/qeth_core_main.c                             |    3 
 drivers/s390/scsi/zfcp_aux.c                                  |    1 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                        |   10 
 drivers/scsi/libiscsi.c                                       |    2 
 drivers/scsi/libiscsi_tcp.c                                   |    8 
 drivers/scsi/libsas/sas_init.c                                |   37 
 drivers/scsi/scsi_debug.c                                     |    8 
 drivers/spi/spi-cadence.c                                     |  129 +
 drivers/spi/spi-qcom-qspi.c                                   |    3 
 drivers/target/target_core_iblock.c                           |    6 
 drivers/target/target_core_transport.c                        |   12 
 drivers/thunderbolt/xdomain.c                                 |   40 
 drivers/ufs/core/ufshcd.c                                     |    6 
 drivers/usb/gadget/function/f_tcm.c                           |  192 ++
 drivers/usb/gadget/function/tcm.h                             |   13 
 drivers/usb/typec/ucsi/ucsi.c                                 |   90 -
 drivers/usb/typec/ucsi/ucsi.h                                 |    1 
 fs/binfmt_misc.c                                              |    8 
 fs/btrfs/super.c                                              |    8 
 fs/btrfs/zoned.c                                              |    6 
 fs/erofs/Kconfig                                              |   14 
 fs/erofs/decompressor_lzma.c                                  |    3 
 fs/proc/task_mmu.c                                            |   33 
 fs/smb/client/cifssmb.c                                       |   12 
 fs/smb/server/vfs_cache.c                                     |    6 
 include/drm/drm_exec.h                                        |   20 
 include/drm/drm_fb_helper.h                                   |   12 
 include/drm/gpu_scheduler.h                                   |   12 
 include/linux/alloc_tag.h                                     |    3 
 include/linux/can/core.h                                      |    1 
 include/linux/can/skb.h                                       |    2 
 include/linux/dma/qcom_bam_dma.h                              |   21 
 include/linux/kmemleak.h                                      |    4 
 include/linux/libata.h                                        |    2 
 include/linux/mmc/sdio_ids.h                                  |    2 
 include/linux/netfilter/nf_conntrack_sip.h                    |    2 
 include/linux/slab.h                                          |    8 
 include/linux/thunderbolt.h                                   |    3 
 include/linux/trace_events.h                                  |    4 
 include/net/ip_vs.h                                           |   45 
 include/net/neighbour.h                                       |    8 
 include/net/netfilter/nf_conntrack_expect.h                   |    5 
 include/net/netfilter/nf_tables.h                             |    4 
 include/scsi/libsas.h                                         |    1 
 include/trace/events/rxrpc.h                                  |   14 
 include/uapi/linux/rkisp1-config.h                            |    6 
 kernel/audit.c                                                |   11 
 kernel/auditfilter.c                                          |    6 
 kernel/bpf/verifier.c                                         |    1 
 kernel/sched/cpufreq_schedutil.c                              |   11 
 kernel/sched/deadline.c                                       |    3 
 kernel/trace/trace.c                                          |   44 
 kernel/trace/trace.h                                          |    4 
 kernel/trace/trace_branch.c                                   |    4 
 kernel/trace/trace_events.c                                   |    6 
 kernel/trace/trace_events_filter.c                            |    3 
 kernel/trace/trace_functions_graph.c                          |    8 
 kernel/trace/trace_hwlat.c                                    |    4 
 kernel/trace/trace_mmiotrace.c                                |   33 
 kernel/trace/trace_osnoise.c                                  |   12 
 kernel/trace/trace_probe.c                                    |    6 
 kernel/trace/trace_sched_wakeup.c                             |    8 
 lib/alloc_tag.c                                               |    9 
 lib/assoc_array.c                                             |    3 
 lib/rhashtable.c                                              |    1 
 lib/test_fortify/Makefile                                     |    1 
 lib/win_minmax.c                                              |    1 
 mm/huge_memory.c                                              |   16 
 mm/hugetlb.c                                                  |   12 
 mm/kmemleak.c                                                 |   44 
 mm/memcontrol-v1.h                                            |    6 
 mm/migrate_device.c                                           |    5 
 mm/mm_init.c                                                  |   15 
 mm/page_reporting.c                                           |    6 
 mm/percpu-km.c                                                |    2 
 mm/slab.h                                                     |   28 
 mm/slab_common.c                                              |   13 
 mm/slub.c                                                     |   34 
 net/bluetooth/hci_conn.c                                      |   14 
 net/bluetooth/hci_sync.c                                      |  137 +
 net/bluetooth/hidp/core.c                                     |   30 
 net/bluetooth/iso.c                                           |  113 +
 net/bluetooth/l2cap_core.c                                    |    5 
 net/bluetooth/mgmt.c                                          |   84 -
 net/bridge/br_mrp.c                                           |    2 
 net/bridge/br_multicast.c                                     |    1 
 net/bridge/br_netfilter_hooks.c                               |    6 
 net/can/af_can.c                                              |   14 
 net/can/bcm.c                                                 |    2 
 net/can/isotp.c                                               |  333 +++-
 net/can/j1939/bus.c                                           |    2 
 net/can/j1939/j1939-priv.h                                    |    3 
 net/can/j1939/main.c                                          |    8 
 net/can/j1939/socket.c                                        |    1 
 net/can/j1939/transport.c                                     |    6 
 net/can/raw.c                                                 |    7 
 net/core/lwt_bpf.c                                            |    4 
 net/core/skbuff.c                                             |   18 
 net/ipv4/route.c                                              |    2 
 net/ipv4/udp_tunnel_nic.c                                     |   32 
 net/ipv6/fib6_rules.c                                         |    1 
 net/ipv6/ip6_output.c                                         |    2 
 net/ipv6/ndisc.c                                              |    2 
 net/mac80211/s1g.c                                            |    4 
 net/mpls/af_mpls.c                                            |    1 
 net/mptcp/pm.c                                                |    9 
 net/mptcp/pm_netlink.c                                        |   29 
 net/mptcp/pm_userspace.c                                      |   89 -
 net/mptcp/protocol.h                                          |    6 
 net/netfilter/ipset/ip_set_hash_gen.h                         |    2 
 net/netfilter/ipvs/ip_vs_app.c                                |    4 
 net/netfilter/ipvs/ip_vs_conn.c                               |    3 
 net/netfilter/ipvs/ip_vs_core.c                               |  180 +-
 net/netfilter/ipvs/ip_vs_proto_sctp.c                         |   19 
 net/netfilter/ipvs/ip_vs_proto_tcp.c                          |   48 
 net/netfilter/ipvs/ip_vs_proto_udp.c                          |   54 
 net/netfilter/ipvs/ip_vs_xmit.c                               |   42 
 net/netfilter/nf_conntrack_broadcast.c                        |    1 
 net/netfilter/nf_conntrack_core.c                             |    7 
 net/netfilter/nf_conntrack_expect.c                           |    1 
 net/netfilter/nf_conntrack_h323_main.c                        |   12 
 net/netfilter/nf_conntrack_helper.c                           |    5 
 net/netfilter/nf_conntrack_netlink.c                          |   18 
 net/netfilter/nf_conntrack_sip.c                              |    4 
 net/netfilter/nf_nat_sip.c                                    |    2 
 net/netfilter/nf_tables_api.c                                 |   34 
 net/netfilter/nft_payload.c                                   |   12 
 net/netfilter/xt_hashlimit.c                                  |   16 
 net/openvswitch/actions.c                                     |   12 
 net/openvswitch/meter.c                                       |   33 
 net/rds/ib.c                                                  |    4 
 net/rds/ib_cm.c                                               |    4 
 net/rds/tcp.c                                                 |   14 
 net/rxrpc/ar-internal.h                                       |   38 
 net/rxrpc/call_accept.c                                       |    1 
 net/rxrpc/call_event.c                                        |   19 
 net/rxrpc/call_object.c                                       |    2 
 net/rxrpc/input.c                                             |   12 
 net/rxrpc/output.c                                            |   14 
 net/rxrpc/peer_object.c                                       |   20 
 net/rxrpc/proc.c                                              |    6 
 net/rxrpc/rtt.c                                               |  103 -
 net/rxrpc/sendmsg.c                                           |    2 
 net/sctp/associola.c                                          |    3 
 net/sctp/sm_make_chunk.c                                      |   17 
 net/smc/smc_core.c                                            |    2 
 net/tipc/socket.c                                             |    2 
 security/keys/keyring.c                                       |   14 
 security/keys/trusted-keys/trusted_dcp.c                      |   15 
 sound/core/pcm_native.c                                       |    7 
 sound/core/seq/seq_timer.c                                    |    9 
 sound/core/timer.c                                            |    2 
 sound/core/ump.c                                              |    1 
 sound/pci/hda/patch_hdmi.c                                    |   48 
 sound/pci/lx6464es/lx6464es.c                                 |    5 
 sound/pci/lx6464es/lx_core.c                                  |    5 
 sound/soc/codecs/max98090.c                                   |    5 
 sound/soc/codecs/max98095.c                                   |    5 
 sound/soc/codecs/tas2562.c                                    |   30 
 sound/usb/6fire/chip.c                                        |    4 
 sound/usb/endpoint.c                                          |   14 
 sound/usb/midi.c                                              |    2 
 sound/usb/midi2.c                                             |    4 
 sound/usb/mixer_quirks.c                                      |    2 
 tools/testing/kunit/kunit_kernel.py                           |   39 
 tools/testing/kunit/kunit_tool_test.py                        |   42 
 tools/testing/selftests/clone3/clone3_set_tid.c               |    2 
 tools/testing/selftests/mm/mlock-random-test.c                |    2 
 387 files changed, 4747 insertions(+), 2364 deletions(-)

Aaron Ma (1):
      ice: wait for reset completion in ice_resume()

Abdun Nihaal (3):
      gpio: sloppy-logic-analyzer: Fix memory leak in gpio_la_poll_probe()
      cpufreq: powernow-k8: Fix possible memory leak in powernowk8_cpu_init()
      can: kvaser_usb: kvaser_usb_hydra_get_busparams(): fix memory leak in kvaser_usb_hydra_get_busparams()

Alexander Kaplan (1):
      drm/dp: Read the PCON max FRL bandwidth only for HDMI DFPs

Andrei Kuchynski (2):
      usb: typec: ucsi: Fix race condition and ordering in port unregistration
      usb: typec: ucsi: Correct teardown ordering in ucsi_init() error path

Asad Kamal (1):
      drm/amdgpu/gfx: fix cleaner shader IB buffer overflow

Ashutosh Dixit (10):
      drm/xe/rtp: Refactor OAG MMIO trigger register whitelisting
      drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists
      drm/xe/rtp: Maintain OA whitelists separately
      drm/xe/rtp: Keep track of non-OA nonpriv slots
      drm/xe/rtp: Generalize whitelist_apply_to_hwe
      drm/xe/rtp: Save OA nonpriv registers to register save/restore lists
      drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs
      drm/xe/rtp: (De-)whitelist OA registers for all hwe's for a gt
      drm/xe/oa: (De-)whitelist OA registers on OA stream open/release
      drm/xe/rtp: Ensure locking/ref counting for OA whitelists

Asim Viladi Oglu Manizada (1):
      sctp: prevent peer transport count overflow

Aswin Karuvally (1):
      s390/qeth: Check CAP_NET_ADMIN for private ioctls

Avi Weiss (4):
      can: ctucanfd: use self-test mode for PRESUME_ACK
      can: ctucanfd: unmap BAR0 using base address
      can: ctucanfd: handle bus error interrupts
      can: ctucanfd: mark error-active controller status valid

Bart Van Assche (1):
      drm/fb-helper: Fix a locking bug in an error path

Baul Lee (4):
      ALSA: ump: fix double free of out_cvts on rawmidi error
      ALSA: usb-audio: fix use-after-free in ump_to_endpoint()
      ALSA: usb-audio: fix stack info leak in RME Digiface status
      ALSA: usb-audio: fix OOB write in snd_usbmidi_akai_output()

Benjamin Berg (2):
      um: Set parent death signal for winch thread/process
      um: Set parent death signal for userspace process

Benjamin Block (1):
      scsi: zfcp: Fix memory leak during adapter release by destroying gid_pn_req

Benjamin Boortz (2):
      pinctrl: microchip-sgpio: add missing select REGMAP_MMIO
      pinctrl: bm1880: add missing select GENERIC_PINCONF

Benjamin Tissoires (1):
      HID: logitech-dj: fix wrong detection of bad DJ_SHORT output report

Breno Leitao (2):
      mm: memcg: initialize *locked in memcg1_oom_prepare() stub
      mm/kmemleak: fix checksum computation for per-cpu objects

Candice Li (1):
      drm/amdgpu: restore UMD profile pstate after runtime resume

Catalin Marinas (1):
      kmemleak: iommu/iova: fix transient kmemleak false positive

Cen Zhang (1):
      usb: gadget: f_tcm: synchronize delayed set_alt with teardown

Cen Zhang (Microsoft) (1):
      rhashtable: clear stale iter->p on table restart

Charles Vosburgh (1):
      sctp: validate Adaptation Indication parameter length

Chengfeng Ye (1):
      Bluetooth: hci_sync: Fix advertising data UAFs

Chenguang Zhao (4):
      forcedeth: fix UAF of txrx_stats in nv_remove
      net: ethernet: mtk_eth_soc: pass eth to mtk_handle_irq_rx in poll_controller
      net: sxgbe: free TX rings on RX allocation failure
      net: sxgbe: check descriptor ring allocation failures

Chris Gellermann (2):
      selftests/mm: fix potential wild pointer access of getline due to missing init
      selftests/clone3: fix wild pointer access of getline due to missing init

Christian Brauner (2):
      binfmt_misc: reject a flag character as the field delimiter
      binfmt_misc: don't let an 'F' entry pin its own instance

Christian Marangi (1):
      net: phylink: put link_gpio if phylink_create fails

Damien Le Moal (2):
      ahci: Introduce ahci_ignore_port() helper
      ata: libahci_platform: Do not set mask_port_map when not needed

Daniel Golle (2):
      net: dsa: mt7530: check bus->read() errors in the MDIO regmap backend
      net: dsa: mt7530: error out on failed reads in MT7531 PHY polling

Daniel Hodges (1):
      wifi: ath6kl: fix use-after-free in aggr_reset_state()

David Corvaglia (1):
      net: bridge: mrp: fix Option TLV length in MRP_Test frames

David Francis (1):
      drm/amdkfd: Handle invalid event type in CRIU event restore

David Gow (1):
      kunit: tool: Terminate kernel under test on SIGINT

David Howells (5):
      rxrpc: Generate rtt_min
      rxrpc: Adjust the rxrpc_rtt_rx tracepoint
      rxrpc: Fix the calculation and use of RTO
      rxrpc: Manage RTT per-call rather than per-peer
      rxrpc: Fix irq-disabled in local_bh_enable()

David Lee (1):
      netfilter: ipset: do not update comments from kernel-side hash adds

Dawei Feng (3):
      smb: client: fix buffer leaks in SMB1 read and write
      e1000: fix memory leak in e1000_probe()
      ice: fix memory leak in ice_lbtest_prepare_rings()

Denis V. Lunev (1):
      qede: sync udp_tunnel ports outside qede_lock in the recovery path

Eric Dumazet (6):
      net: do not send ICMP/NDISC Redirects when peer allocation fails
      net: udp_tunnel: fix memory leak in udp_tunnel_nic_unregister()
      vxlan: re-fetch eth header after route_shortcircuit()
      vxlan: unclone skb head before modifying eth header in route_shortcircuit()
      vxlan: use neigh_ha_snapshot() in route_shortcircuit()
      vxlan: use pskb_network_may_pull() in route_shortcircuit()

Fabrice Derepas (1):
      KEYS: trusted: dcp: fix key_len validation and calc_blob_len() return type

Fan Wu (1):
      wifi: brcmfmac: drain bus_reset work on device removal

Farhan Ali (3):
      KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
      KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
      KVM: s390: pci: Validate AIBV and AISB before pinning guest pages

Frank Wunderlich (2):
      net: ethernet: mtk_eth_soc: support named IRQs
      net: ethernet: mtk_eth_soc: add consts for irq index

Gabriele Monaco (1):
      sched/deadline: Use revised wakeup rule only for running dl_server

Gang Ba (1):
      drm/amdkfd: Fix missing authorization check in KFD_IOC_DBG_TRAP_DISABLE

Geliang Tang (4):
      mptcp: pm: avoid code duplication to lookup endp
      mptcp: add mptcp_userspace_pm_lookup_addr helper
      mptcp: pm: use addr entry for get_local_id
      mptcp: pm: userspace: fix use-after-free in get_local_id

Gokul Sivakumar (1):
      wifi: brcmfmac: fix 43752 SDIO FWVID incorrectly labelled as Cypress (CYW)

Greg Kroah-Hartman (3):
      Bluetooth: btusb: Fix short read errors in btusb_qca_send_vendor_req()
      Bluetooth: btmtk: Fix short read errors in btmtk_usb_uhw_reg_read()
      Linux 6.12.103

Gregory Price (1):
      mm/vmstat: fold stranded per-cpu node stats when a node comes online

Guangshuo Li (2):
      scsi: ufs: core: Cancel RTC work in active-active suspend
      can: etas_es58x: es58x_read_bulk_callback(): fix RX buffer leak on URB resubmit failure

Guenter Roeck (10):
      hwmon: (nct6775-core) Fix number of temperature registers for NCT6116
      hwmon: (ina2xx) Add support for has_alerts configuration flag
      hwmon: (ina2xx) Add support for INA260
      hwmon: (ina2xx) Fix various overflow issues
      hwmon: (ltc4282) Fix reading the minimum alarm voltage
      hwmon: (sht3x) Fix unaligned accesses
      hwmon: (lm90) Only report alarms if driver is ready
      hwmon: (nzxt-smart2) DMA-align output buffer
      hwmon: (nct6775-core) Prevent access to unsupported weight registers
      hwmon: (pmbus) Fix return value from pmbus_update_byte_data()

H. Nikolaus Schaller (1):
      i2c: jz4780: Cache host clock rate at probe to prevent CCF prepare_lock deadlock

Haidar Lee (2):
      ASoC: tas2562: fix DVC coefficient write order
      ASoC: tas2562: fix broken entries in the volume lookup table

Harald Freudenberger (1):
      s390/zcrypt: Fix wrong domain value verification with EP11 CPRBs

Harkirat Gill (1):
      drm/amdgpu: cap GTT size to physical RAM on APUs

Harry Yoo (Oracle) (2):
      lib/alloc_tag: introduce mem_alloc_profiling_permanently_disabled()
      mm/slab: prevent unbounded recursion in free path with new kmalloc type

Holger Dengler (2):
      s390/zcrypt: Validate length for CCA AES cipher key requests
      s390/zcrypt: Validate length for CCA ECC private key requests

Hongling Zeng (1):
      dmaengine: sun6i-dma: Fix reclaim descriptors while terminating DMA

Hongyan Xu (1):
      hwmon: (npcm750-pwm-fan): stop fan timer on device detach

HyeongJun An (3):
      scsi: libiscsi: Fix stale-data leak into the SCSI sense buffer
      scsi: libiscsi_tcp: Bound SCSI Response data segment to the connection buffer
      HID: logitech-dj: Fix maxfield check in DJ short report validation

Ian Ray (2):
      hwmon: (ina2xx) Make it easier to add more devices
      hwmon: (ina2xx) Add support for INA234

Ibrahim Hashimov (1):
      scsi: scsi_debug: Fix REPORT ZONES alloc_len underflow OOB write

Ilia Gavrilov (1):
      rds: Fix inet6_addr_lst NULL dereference when IPv6 is disabled

Ilya Maximets (3):
      net: openvswitch: fix potential UAF on meter attach failure
      net: openvswitch: fix skb leak on flow key update failure during recirculation
      net: openvswitch: fix skb leak on flow key update failure during ct

Jackson Lee (1):
      media: chips-media: wave5: Support CBP profile

Jai Luthra (1):
      media: i2c: imx219: Rename VTS to FRM_LENGTH

Jakub Kicinski (1):
      netconsole: avoid OOB reads, msg is not nul-terminated

James Gao (1):
      can: peak_usb: add bounds check for USB channel index

Jan Höppner (1):
      s390/dasd: Fix potential NULL pointer dereference

Jani Nikula (3):
      drm/i915/vrr: require valid min/max vfreq for VRR
      drm/i915/hdcp: require monotonically increasing seq_num_v
      drm/i915/hdcp: check streams[] bounds before overflow

Jiale Yao (1):
      Bluetooth: L2CAP: fix UAF in l2cap_le_connect_rsp

Jianing Li (1):
      power: supply: max17040: handle missing status supplier

Jiawen Wu (1):
      net: libwx: fix FDIR ATR queue mismatch for software VLAN packets

Jiri Slaby (SUSE) (1):
      drm/amd/display: use proper context for logging

Johannes Thumshirn (1):
      btrfs: zoned: fix deadlock between metadata writeback and transaction commit

Jonas Gorski (1):
      i2c: iproc: reset bus after timeout if START_BUSY is stuck

Jonas Rebmann (1):
      hwmon: (ina2xx) Shift INA234 shunt and current registers

Jose Maria Casanova Crespo (1):
      drm/vc4: Supply the overflow slot size in BPOS, not the whole bin BO size

Joshua Hay (1):
      idpf: adjust TxQ ring count minimum

Josua Mayer (1):
      ata: libahci_platform: support non-consecutive port numbers

Julian Anastasov (3):
      ipvs: fix the checksum validations
      ipvs: fix places with wrong packet offsets
      ipvs: do not mangle ICMP replies for non-first fragments

Jun Guo (2):
      spi: spi-cadence: supports transmission with bits_per_word of 16 and 32
      spi: spi-cadence: enable SPI_CONTROLLER_MUST_TX

Junjie Cao (1):
      gpio: pch: use raw_spinlock_t for the register lock

Kai Vehmanen (1):
      ALSA: hda: codecs: hdmi: disable keep-alive before audio format change

Karl Mehltretter (2):
      riscv: mm: Fix out-of-bounds page-table walk during memory hot-remove
      pinctrl: devicetree: don't free uninitialized dev_name on error path

Kefeng Wang (1):
      mm: migrate_device: fix pte_pfn/pte_dirty called on non-present PTE

Kiryl Shutsemau (Meta) (4):
      fs/proc/task_mmu: fix PAGEMAP_SCAN written state for PMD holes
      mm/hugetlb: fix swap entry corruption when clearing uffd-wp at fork()
      fs/proc/task_mmu: fix PAGEMAP_SCAN written state for unpopulated ptes
      mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios

Konrad Dybcio (1):
      pinctrl: qcom: sc8280xp: Add missing wakeup entries for GPIO143/151

Lee Jones (2):
      HID: logitech-dj: Standardise hid_report_enum variable nomenclature
      HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT related user initiated OOB write

Leon Romanovsky (1):
      scsi: target: Clear cmd_cnt when initial counter enrollment fails

LiangCheng Wang (1):
      wifi: brcmfmac: set F2 blocksize to 256 for BCM43752

Liem (2):
      i2c: imx: Fix slave registration race and error handling
      i2c: imx: Cancel hrtimer before clearing slave pointer

Link Lin (1):
      mm/page_reporting: use system_freezable_wq to fix UAF during suspend

Lorenzo Bianconi (1):
      netfilter: br_netfilter: Reallocate headroom if necessary in neigh_hh_bridge()

Lucas De Marchi (1):
      drm/xe: Apply whitelist to engine save-restore

Lucas Martins Alves (1):
      can: c_can: c_can_chip_config(): keep controller in init mode until bittiming is configured

Luiz Angelo Daros de Luca (8):
      hwmon: (adt7470) Fix fans stuck in manual mode on I2C errors
      hwmon: (adt7470) Fix cache updated before hardware write on I2C error
      hwmon: (adt7470) Fix busy-loop and I2C flooding in update thread
      hwmon: (adt7470) Fix temperature alarm logic in hwmon_temp_read()
      hwmon: (adt7470) Fix swapped PWM3 and PWM4 auto mode masks
      hwmon: (adt7470) Use cached PWM frequency value
      hwmon: (adt7470) Fix divide-by-zero TOCTOU crash in fan speed read
      hwmon: (adt7470) Fix PWM auto temp state array and bounds check

Luxiao Xu (1):
      audit: fix potential use-after-free in audit_del_rule()

Maoyi Xie (1):
      can: peak_usb: peak_usb_start(): fix double free of transfer buffer on URB submit error

Marc Kleine-Budde (1):
      can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on skb allocation failure

Mario Limonciello (1):
      pinctrl-amd: Don't clear S4 wake bits at probe

Masami Hiramatsu (Google) (4):
      tracing/mmiotrace: Reset dropped_count in mmio_reset_data()
      tracing/mmiotrace: Add NULL check for mmio_trace_array in logging functions
      tracing: Check return value of __register_event() in trace_module_add_events()
      tracing/filters: Fix false positive match in regex_match_full()

Matt Fleming (1):
      veth: convert frag_list skbs before running XDP

Matt Vollrath (2):
      ata: libata-eh: Increase STANDBY IMMEDIATE timeout
      igbvf: Fix leak in TX DMA error cleanup

Matthew Brost (2):
      drm/xe: Wait on external BO kernel fences in exec IOCTL
      drm/xe: Stub out new pagefault layer

Maíra Canal (1):
      drm/vc4: Zero the tile state data array before each BIN job

Md Sadre Alam (1):
      dmaengine: qcom: bam_dma: Fix command element mask field for BAM v1.6.0+

Michael Bommarito (6):
      thunderbolt: Prevent XDomain delayed work use-after-free on disconnect
      keys: fix out-of-bounds read in keyring_get_key_chunk()
      keys: make keyring key-chunk byte order agree with keyring_diff_objects()
      assoc_array: trim the final shortcut word using the current chunk end
      erofs: cap LZMA stream pool size
      um: vector: fix use-after-free in vector_mmsg_rx()

Michal Wajdeczko (1):
      drm/xe: Introduce xe_gt_dbg_printer()

Mike Looijmans (1):
      phy-zynqmp: Postpone getting clock rate until actually needed

Ming Lei (1):
      ublk: reset kernel-owned dev_info fields in ublk_ctrl_add_dev()

Minhong He (1):
      can: isotp: check register_netdevice_notifier() error in module init

Muhammad Bilal (1):
      accel/qaic: use sizeof(*trans_hdr) for transaction length check

Myeonghun Pak (2):
      i2c: amd-mp2: Unregister callback on adapter add failure
      drm/mediatek: ovl_adaptor: balance component registrations

Namjae Jeon (2):
      ksmbd: return success for deferred final close
      ksmbd: fix use-after-free in __close_file_table_ids()

Nathan Chancellor (1):
      fortify: Disable -Wstringop-overread in tests

Nava kishore Manne (3):
      phy: zynqmp: fix L0_TM_DISABLE_SCRAMBLE_ENCODER mask
      phy: zynqmp: use read-modify-write for SERDES scrambler bypass
      phy: zynqmp: keep SERDES scrambler and 8b/10b enabled for USB

Niklas Cassel (2):
      ata: libata-sata: fix ata_scsi_lpm_supported() iteration
      ata: ahci: Make ahci_ignore_port() handle empty mask_port_map

Niklas Schnelle (1):
      s390/pci: Fix s390_pci_mmio_write syscall error return without MIO

Niklas Söderlund (1):
      media: uapi: rkisp: Correct name version enum

Nitin Gote (1):
      drm/xe: Hold a dma-buf reference for imported BOs

Norbert Szetei (3):
      ALSA: pcm: wake linked drain waiters on unlink
      ALSA: seq: Fix division by zero in initialize_timer()
      ALSA: timer: Clear SNDRV_TIMER_IFLG_DEAD once the close completes

Oleksij Rempel (1):
      can: j1939: transport: j1939_session_fresh_new(): initialize receive buffer

Oliver Hartkopp (2):
      can: use skb hash instead of private variable in headroom
      can: isotp: fix timer drain order, wakeup handling and tx_gen ordering

Oreoluwa Babatunde (1):
      of: reserved_mem: Add code to dynamically allocate reserved_mem array

Osama Abdelkader (2):
      drm/panthor: reject firmware sections with oversized data
      drm/panthor: validate firmware interface structure sizes

Pablo Neira Ayuso (3):
      netfilter: nf_conntrack_expect: restore helper propagation via expectation
      netfilter: nf_tables: make nft_object rhltable per table
      netfilter: xt_hashlimit: validate hashtable supports XT_HASHLIMIT_RATE_MATCH

Pauli Virtanen (9):
      Bluetooth: ISO: clear iso_data always when detaching conn from hcon
      Bluetooth: ISO: fix timeout vs sync_timeout typo in check_bcast_qos
      Bluetooth: ISO: validate sockaddr_iso first in iso_sock_rebind_bis()
      Bluetooth: ISO: fix leaking sk after socket release
      Bluetooth: ISO: avoid deadlocks in iso_sock_timeout
      Bluetooth: hci_sync: make hci_cmd_sync_run_once return -EEXIST if exists
      Bluetooth: hci_conn: hold conn reference in abort_conn_sync()
      Bluetooth: hci_sync: fix hci_conn_del() use in hci_le_create_conn_sync
      Bluetooth: ISO: fix CONNECTED -> CLOSED transition on shutdown/release

Pengpeng Hou (5):
      can: ems_usb: validate CPC message lengths
      can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd(): validate received command extents
      can: softing: fw_parse(): validate firmware record spans
      can: peak_usb: validate uCAN receive record lengths
      can: ctucanfd: add missing MODULE_DEVICE_TABLE()

Pierre-Eric Pelloux-Prayer (2):
      drm/sched: Store the drm client_id in drm_sched_fence
      drm/amdgpu: give each kernel job a unique id

Qu Wenruo (1):
      btrfs: fix leaking BTRFS_FS_STATE_REMOUNTING flag

Radhey Shyam Pandey (3):
      ata: ahci_ceva: fix error paths in ceva_ahci_platform_enable_resources()
      phy: zynqmp: fix clock error handling in xpsgtr_phy_init()
      phy: zynqmp: fix runtime PM leak on probe allocation failure

Raushan Patel (1):
      tracing/probes: Reject $arg0 in meta argument expansion

Ray Wu (1):
      drm/amd/display: Increase HDMI AV mute wait from 2 to 3 frames

Rosen Penev (1):
      ata: sata_mv: accept 1 or 2 resources in platform probe

Ruoyu Wang (1):
      drm/mediatek: Check CRTC state before freeing

Sakari Ailus (1):
      media: imx219: Fix maximum frame length in lines

Sang-Heon Jeon (1):
      of: reserved_mem: prevent OOB when too many dynamic regions are defined

Sangho Lee (2):
      Bluetooth: HIDP: reject frames without a transaction header
      Bluetooth: HIDP: validate numbered report payloads

Sean Christopherson (1):
      KVM: SVM: Update x2APIC MSR intercepts if AVIC is inhibited while L2 is active

Sebastian Andrzej Siewior (1):
      Drivers: hv: vmbus: Replace lockdep_hardirq_threaded() with lockdep annotation

Sergey Senozhatsky (1):
      usb: typec: ucsi: split connector lock classes

Shuvam Pandey (1):
      kunit: tool: skip stty when stdin is not a tty

Sneh Mankad (1):
      pinctrl: qcom: Unconditionally mark gpio as wakeup enable

Sonali Pradhan (2):
      ALSA: usb-audio: Fix DMA buffer out-of-bounds write when fill_max is set
      ALSA: usb-audio: Clamp frame size in implicit-feedback mode

Srikanth Boyapally (1):
      spi: spi-cadence: Move TX FIFO full busy-wait into FIFO

Stefan Haberland (1):
      s390/dasd: Fix undersized format-check buffer

Steven Rostedt (1):
      tracing/mmiotrace: Remove reference to unused per CPU data pointer

Suman Ghosh (1):
      octeontx2-pf: Set correct sequence for carrier off and tx queue stop

Suraj Kandpal (2):
      drm/i915/hdcp: Move to using intel_display in intel_hdcp
      drm/i915/hdcp: Skip inactive MST connectors when building stream list

Takashi Iwai (1):
      ALSA: 6fire: Fix UAF at error handling during probe

TanZheng (1):
      scsi: target: iblock: Fix wrong PR ops NULL check for PREEMPT/RELEASE

Tetsuo Handa (1):
      can: j1939: use netdevice_tracker for j1939_{priv,session,ecu} tracking

Thomas Hellström (2):
      drm/exec: Remove the index parameter from drm_exec_for_each_locked_obj[_reverse]
      drm/xe: Rename ___xe_bo_create_locked()

Thomas Zimmermann (3):
      drm/fb-helper: Allocate and release fb_info in single place
      drm/tegra: fbdev: Remove offset into framebuffer memory
      drm/tegra: fbdev: Do not assign to struct drm_fb_helper.info

Thorsten Blum (4):
      powerpc/boot: Fix simpleboot CPU node lookup check
      powerpc/boot: Fix treeboot-currituck CPU node lookup check
      powerpc/boot: Fix treeboot-akebono CPU node lookup check
      powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()

Timur Kristóf (1):
      drm/amdgpu: Respect placement requirements in amdgpu_gtt_mgr functions

Tiwei Bie (5):
      um: Add os_set_pdeathsig helper function
      um: Use os_set_pdeathsig helper in winch thread/process
      um: Set parent-death signal for ubd io thread/process
      um: Set parent-death signal for write_sigio thread/process
      um: Preserve errno within signal handler

Tristan Madani (1):
      bpf: Reset register bounds before narrowing retval range in check_mem_access()

Tvrtko Ursulin (1):
      drm/amdgpu: Fix context pstate override handling

Uday Khare (2):
      ASoC: max98095: fix missing IS_ERR() before PTR_ERR() on mclk lookup
      ASoC: max98090: fix missing IS_ERR() before PTR_ERR() on mclk lookup

Vijaya Krishna Nivarthi (1):
      spi: qcom-qspi: Correct max DMA length to avoid 64K boundary failure

Ville Syrjälä (1):
      drm/i915/vrr: Check HAS_VRR() first in intel_vrr_is_capable()

Vincent Jardin (1):
      hwmon: (pmbus/core) notify on the hwmon device, not the i2c client

Vladimir Marioukhine (1):
      drm/amdkfd: fix QID bit leak in pqm_create_queue()

Wandun Chen (1):
      of: reserved_mem: avoid post-init UAF when alloc_reserved_mem_array() fails

Wayen.Yan (1):
      net: airoha: Fix register index for Tx-fwd counter configuration

Wenliang Yan (1):
      hwmon: (ina226) Add support for SY24655

William Palacek (2):
      drm/amdkfd: fix uint32_t overflow in EOP ring buffer size alignment
      drm/amdkfd: hold event_mutex while checkpointing CRIU events

Xiang Mei (2):
      netfilter: nf_conntrack_sip: widen NAT rewrite delta to s32 in sip_help_tcp()
      rds: tcp: hold the RCU lock across ipv6_chk_addr() in rds_tcp_laddr_check()

Xiang Mei (Microsoft) (1):
      netfilter: nft_payload: fix mask build for partial field offload

Xiangfeng Cai (1):
      mm/hugetlb: fix list corruption in allocate_file_region_entries()

Xingui Yang (1):
      scsi: libsas: Fix HA resume deadlock and hisi_sas disk-wake race

Xu Rao (2):
      ALSA: lx6464es: fix period byte count for 16-bit streams
      power: supply: bq25890: fix the -10 C NTC lookup entry

Xuanqiang Luo (2):
      bpf: lwt: Fix dst reference leak on reroute failure
      net/smc: fix socket use-after-free during link group termination

Yehyeong Lee (1):
      net: mpls: initialize rtm_tos in mpls_getroute()

Yuho Choi (2):
      dmaengine: idxd: fix fdev setup failure cleanup in idxd_cdev_open()
      idpf: Fix mailbox IRQ name leak on request failure

Yun Lu (1):
      rtase: fix double free of multi-frag skb on DMA map failure

Yuxiang Yang (1):
      sctp: reject stale cookies with mismatched verification tags

Zack Rusin (8):
      drm/vmwgfx: fix guest_memory_dirty bitfield clobbered as size
      drm/vmwgfx: reject DX_BIND_QUERY without a DX context
      drm/vmwgfx: drop dma_buf reference on foreign-fd prime import
      drm/vmwgfx: validate DRAW_PRIMITIVES header size before division
      drm/vmwgfx: bound DMA command body size against suffix pointer
      drm/vmwgfx: avoid destroy_workqueue(NULL) on vkms init failure
      drm/vmwgfx: use check_add_overflow for shader size+offset bound
      drm/vmwgfx: validate external BO copy bounds for both stride paths

Zhan Xusheng (1):
      audit: fix potential integer overflow in audit_log_n_string()

Zhao Li (2):
      wifi: mac80211: validate individual TWT params before driver setup
      wifi: mwifiex: use the subframe length when parsing A-MSDU TDLS frames

Zheng Yejian (1):
      tracing: Remove TRACE_EVENT_FL_FILTERED logic

Zhiling Zou (3):
      ipvs: do not propagate one-packet flag to synced conns
      net: bridge: stop fast-leave after deleting a port group
      net: ipv6: clear suppressed fib6 rule result

Zhongqiu Han (1):
      cpufreq: schedutil: Publish util hooks only after all sg_cpu are initialized

Zi Yan (1):
      mm/percpu-km: fix bitmap overflow and accounting in pcpu_create_chunk()

Zihan Xi (3):
      Bluetooth: mgmt: fix pending command UAF in EIR updates
      Bluetooth: mgmt: fix UAF in pair command cancellation
      tipc: avoid use-after-free in poll trace queue dumps

Zijun Hu (1):
      Bluetooth: btintel: Validate length before parsing diagnostics TLV

Zongyao Bai (1):
      drm/xe/pt: Reset current_op in xe_pt_update_ops_init()

bui duc phuc (1):
      gpio: pca953x: fix cache_only and IRQ state on restore_context() failure

