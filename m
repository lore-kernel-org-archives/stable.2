Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912705;
	b=G0F+3ALfDw80kcMfo4mHF6cy2TM3WL5HS1C78mcYEIZ5YOpdCS9ZSOfcg5ymKp5d7X6M
	 KOkNEsZnRX5iTiQyy0CD7/vMVBEy2pIZ2sWvBrCoPqM4GUK8Pez2JcAR7etMuUfWC1E/w
	 ylyw9kvc/SKAw99kCov5R75SaGtdTQc0ARTzrrvpPkBOOjJt8miT+zW+zXe8TaSBP9um7
	 PQWaClHGqWJESokXTYVRoAPoVtjMMtioSsJPt5RqpgTfa63VqEGEER3rsSvCb0KPD4w/u
	 nPRXqyzNFs91xqjUPGtCS1ZNs4tmY7Mto4zsWfdODxRtqnnp7dLEndOcTzM0jVgFNzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912705;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=72qpv0TrTNNP9+psdvjdWWB3FBPYN7sxGfj8oTGLGQI=;
	b=rNAyf6NctZwqvIKmDr8k5ufIJ1vxQ6M6ipLlBsybVHyeAsGBPe7EYCSsmTT/FKddRYdQ
	 kDvPbXUIGlhqNVYb32GOuMzgQSrYTf1enQAUDeKg3b89iCB3YMjzvtFiBq7rTM0cZbLkS
	 c2dUN8B2l06lr9zqMF/LfleTtxswUPERGnU0rv7jl9itIqvnfmyIB1Mo0SSp1bXOym+KB
	 n92Rg671DnqJZ0U3tGEU3TvMCFf+QSwCvXlNWbtafwQJq/X8LdhxztMim8vSuVz6Ju8nd
	 isr+yW7cSWg3LpNDpaOEhOkTTPKGnMw4/Xx+KvYxXhp3vf4o9hLl5oN2G6vbHy/z0YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RWKHA4co;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1F660A261D;
	Tue, 17 Nov 2026 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RWKHA4co
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA2C1F000C4;
	Tue, 17 Nov 2026 10:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794912705;
	bh=72qpv0TrTNNP9+psdvjdWWB3FBPYN7sxGfj8oTGLGQI=;
	h=From:To:Cc:Subject:Date;
	b=RWKHA4co5mLFL6E1fY4UA6gTtlbxrG67f/vm+hFL7NlAwFxOiyH+DJM6Z8HV53Xib
	 PDH93JKp76PQB8NnNL/PKWrWc6nfu+mbi/oUSwOUKH6FVz10UJ+IPWrgCgBWSdiRx2
	 U4geR9SCpvcsp/mHg9lz8yYyiZ0IUn8Lz7JdmdJY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.3.5
Date: Tue, 17 Nov 2026 11:45:29 +0100
Message-ID: <2026111729-brim-nest-fa62@gregkh>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.3.5 kernel.

All users of the 7.3 kernel series must upgrade.

The updated 7.3.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.3.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-fs-f2fs                              |    2 
 Documentation/admin-guide/pm/intel_idle.rst                          |   12 
 Documentation/arch/arm64/silicon-errata.rst                          |    3 
 Documentation/filesystems/overlayfs.rst                              |    3 
 Documentation/filesystems/resctrl.rst                                |   87 +-
 Documentation/hwmon/asus_rog_ryujin.rst                              |    6 
 Documentation/mm/vmemmap_dedup.rst                                   |   15 
 Makefile                                                             |    2 
 arch/arm64/include/asm/sdei.h                                        |    3 
 arch/arm64/include/asm/suspend.h                                     |    2 
 arch/arm64/kernel/entry-common.c                                     |   40 +
 arch/arm64/kernel/machine_kexec_file.c                               |    2 
 arch/arm64/kernel/sdei.c                                             |   59 +
 arch/arm64/kernel/topology.c                                         |   12 
 arch/arm64/kvm/mmu.c                                                 |  129 +--
 arch/arm64/kvm/pkvm.c                                                |    3 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                   |   10 
 arch/arm64/mm/mmap.c                                                 |    4 
 arch/arm64/mm/proc.S                                                 |    8 
 arch/mips/mm/cex-gen.S                                               |   16 
 arch/mips/pci/ops-mace.c                                             |   26 
 arch/mips/pci/pci-ip32.c                                             |    9 
 arch/mips/sgi-ip32/ip32-irq.c                                        |   45 -
 arch/openrisc/kernel/or32_ksyms.c                                    |    1 
 arch/x86/boot/startup/sme.c                                          |    2 
 arch/x86/entry/syscall_32.c                                          |    4 
 arch/x86/entry/syscall_64.c                                          |   26 
 arch/x86/include/asm/checksum_32.h                                   |    2 
 arch/x86/include/asm/vmware.h                                        |   24 
 arch/x86/kernel/acpi/cppc.c                                          |   15 
 arch/x86/kernel/cpu/bugs.c                                           |   12 
 arch/x86/kernel/cpu/resctrl/internal.h                               |    4 
 arch/x86/kernel/cpu/resctrl/monitor.c                                |    4 
 arch/x86/kernel/nmi.c                                                |    8 
 arch/x86/kernel/x86_init.c                                           |    2 
 arch/x86/kvm/mmu/mmu.c                                               |   10 
 arch/x86/kvm/mmu/paging_tmpl.h                                       |   11 
 arch/x86/kvm/vmx/nested.c                                            |    1 
 arch/x86/kvm/x86.c                                                   |   31 
 arch/x86/mm/tlb.c                                                    |   16 
 block/bio.c                                                          |    3 
 block/blk-iocost.c                                                   |    3 
 block/blk-mq.c                                                       |   13 
 block/elevator.c                                                     |   30 
 block/ioctl.c                                                        |    4 
 drivers/acpi/battery.c                                               |   12 
 drivers/acpi/cppc_acpi.c                                             |   61 +
 drivers/acpi/utils.c                                                 |   41 +
 drivers/ata/libata-pmp.c                                             |   14 
 drivers/ata/libata-scsi.c                                            |   25 
 drivers/block/ublk_drv.c                                             |    1 
 drivers/block/virtio_blk.c                                           |    2 
 drivers/bluetooth/btqca.c                                            |    3 
 drivers/char/hw_random/virtio-rng.c                                  |    7 
 drivers/clk/nuvoton/clk-ma35d1.c                                     |    7 
 drivers/cpufreq/amd-pstate.c                                         |   25 
 drivers/cpufreq/cppc_cpufreq.c                                       |   26 
 drivers/cxl/core/features.c                                          |    2 
 drivers/dma-buf/dma-buf-mapping.c                                    |    2 
 drivers/dma/qcom/bam_dma.c                                           |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                             |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                           |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                     |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                               |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                           |   41 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                        |   44 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c                          |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                              |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                              |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c                             |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c                            |   19 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                               |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c                          |    1 
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c                               |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c                                |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c                                |    5 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c                                 |   13 
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                               |    4 
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c                               |    4 
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c                               |   41 +
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c               |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c           |   27 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c       |    3 
 drivers/gpu/drm/amd/display/dc/core/dc.c                             |    6 
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c                |   31 
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h                   |    3 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c   |    6 
 drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c               |    7 
 drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h               |   18 
 drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h               |   22 
 drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h             |   18 
 drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h               |   11 
 drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h               |   11 
 drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h             |   12 
 drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h               |    2 
 drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h               |    2 
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c       |   15 
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h       |    6 
 drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h     |    6 
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c              |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                 |   20 
 drivers/gpu/drm/bridge/nwl-dsi.c                                     |   17 
 drivers/gpu/drm/display/drm_dp_helper.c                              |    3 
 drivers/gpu/drm/drm_crtc.c                                           |   18 
 drivers/gpu/drm/drm_panic.c                                          |    7 
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c                             |   40 -
 drivers/gpu/drm/etnaviv/etnaviv_drv.c                                |    6 
 drivers/gpu/drm/i915/display/intel_ddi.c                             |    2 
 drivers/gpu/drm/i915/display/intel_display_device.c                  |    5 
 drivers/gpu/drm/i915/display/intel_dp.c                              |    4 
 drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c                |   22 
 drivers/gpu/drm/i915/display/intel_plane.c                           |   11 
 drivers/gpu/drm/i915/display/intel_psr.c                             |   96 +-
 drivers/gpu/drm/i915/display/intel_psr_regs.h                        |    4 
 drivers/gpu/drm/i915/display/intel_quirks.c                          |   24 
 drivers/gpu/drm/i915/display/intel_quirks.h                          |    1 
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c                       |    2 
 drivers/gpu/drm/loongson/lsdc_gem.c                                  |   12 
 drivers/gpu/drm/loongson/lsdc_plane.c                                |    2 
 drivers/gpu/drm/loongson/lsdc_ttm.c                                  |   14 
 drivers/gpu/drm/loongson/lsdc_ttm.h                                  |    2 
 drivers/gpu/drm/nouveau/nvkm/core/subdev.c                           |    1 
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c                  |   20 
 drivers/gpu/drm/scheduler/sched_entity.c                             |   29 
 drivers/gpu/drm/v3d/v3d_gem.c                                        |    5 
 drivers/gpu/drm/v3d/v3d_sched.c                                      |    2 
 drivers/gpu/drm/vc4/vc4_gem.c                                        |   14 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                       |   10 
 drivers/gpu/drm/vc4/vc4_hdmi_phy.c                                   |    5 
 drivers/hwmon/aquacomputer_d5next.c                                  |   58 +
 drivers/hwmon/asus_rog_ryujin.c                                      |   54 +
 drivers/hwmon/asus_wmi_sensors.c                                     |   13 
 drivers/hwmon/chipcap2.c                                             |  192 +++--
 drivers/hwmon/coretemp.c                                             |   13 
 drivers/hwmon/corsair-cpro.c                                         |    3 
 drivers/hwmon/gpd-fan.c                                              |    1 
 drivers/hwmon/gpio-fan.c                                             |    7 
 drivers/hwmon/hp-wmi-sensors.c                                       |   29 
 drivers/hwmon/lm75.c                                                 |    9 
 drivers/hwmon/lm87.c                                                 |    7 
 drivers/hwmon/nct6683.c                                              |    4 
 drivers/hwmon/peci/dimmtemp.c                                        |   21 
 drivers/hwmon/pmbus/pmbus_core.c                                     |   51 -
 drivers/hwmon/pmbus/q54sj108a2.c                                     |    2 
 drivers/hwmon/sht15.c                                                |   22 
 drivers/hwmon/sht4x.c                                                |    4 
 drivers/hwmon/tmp108.c                                               |   26 
 drivers/idle/intel_idle.c                                            |   11 
 drivers/iommu/amd/init.c                                             |   41 +
 drivers/iommu/amd/iommu.c                                            |   17 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c                      |    7 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                          |   89 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h                          |    5 
 drivers/iommu/iommufd/io_pagetable.c                                 |    2 
 drivers/iommu/iommufd/iova_bitmap.c                                  |   19 
 drivers/iommu/virtio-iommu.c                                         |    6 
 drivers/media/pci/intel/ipu6/ipu6-fw-isys.c                          |   88 +-
 drivers/media/pci/intel/ipu6/ipu6-isys-video.c                       |    4 
 drivers/media/pci/intel/ipu6/ipu6-isys.c                             |    6 
 drivers/media/pci/intel/ipu6/ipu6-isys.h                             |    5 
 drivers/media/platform/microchip/microchip-isc-base.c                |   20 
 drivers/media/platform/microchip/microchip-isc-regs.h                |   16 
 drivers/media/platform/microchip/microchip-isc.h                     |    4 
 drivers/media/platform/microchip/microchip-sama5d2-isc.c             |   20 
 drivers/media/platform/microchip/microchip-sama7g5-isc.c             |   20 
 drivers/media/usb/uvc/uvc_driver.c                                   |   20 
 drivers/mtd/spi-nor/macronix.c                                       |    2 
 drivers/net/can/dev/netlink.c                                        |    4 
 drivers/net/can/dev/skb.c                                            |   10 
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c                           |    7 
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c                      |   33 
 drivers/net/ethernet/jme.c                                           |   37 -
 drivers/net/ethernet/jme.h                                           |    1 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                             |    4 
 drivers/net/veth.c                                                   |    5 
 drivers/net/vxlan/vxlan_core.c                                       |   14 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c          |    7 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c            |    2 
 drivers/net/wireless/realtek/rtw88/mac80211.c                        |    2 
 drivers/net/wireless/realtek/rtw88/reg.h                             |    2 
 drivers/net/wireless/realtek/rtw88/tx.c                              |    9 
 drivers/net/wireless/realtek/rtw88/tx.h                              |    3 
 drivers/net/wireless/realtek/rtw88/usb.c                             |   68 +
 drivers/net/wireless/realtek/rtw88/usb.h                             |    5 
 drivers/net/wireless/rsi/rsi_91x_core.c                              |    2 
 drivers/nvme/common/keyring.c                                        |    1 
 drivers/nvme/host/core.c                                             |   21 
 drivers/nvme/host/multipath.c                                        |    2 
 drivers/nvme/host/pci.c                                              |    2 
 drivers/nvme/host/pr.c                                               |    8 
 drivers/nvme/host/rdma.c                                             |    7 
 drivers/nvme/host/tcp.c                                              |  213 ++++--
 drivers/nvme/target/admin-cmd.c                                      |   16 
 drivers/nvme/target/configfs.c                                       |    4 
 drivers/nvme/target/core.c                                           |    8 
 drivers/nvme/target/nvmet.h                                          |    8 
 drivers/pci/controller/cadence/pcie-cadence-plat.c                   |   33 
 drivers/pci/controller/cadence/pcie-cadence.c                        |   16 
 drivers/pci/controller/cadence/pcie-cadence.h                        |    2 
 drivers/pci/controller/dwc/pcie-designware.c                         |    2 
 drivers/pci/controller/dwc/pcie-designware.h                         |    1 
 drivers/platform/chrome/cros_ec_ishtp.c                              |    2 
 drivers/platform/chrome/cros_usbpd_notify.c                          |   41 -
 drivers/ptp/ptp_sysfs.c                                              |    6 
 drivers/scsi/aic7xxx/aic79xx_core.c                                  |    4 
 drivers/scsi/aic7xxx/aic79xx_osm.h                                   |   26 
 drivers/scsi/aic7xxx/aic7xxx_core.c                                  |    8 
 drivers/scsi/aic7xxx/aic7xxx_pci.c                                   |   20 
 drivers/scsi/scsi_bsg.c                                              |    8 
 drivers/target/target_core_device.c                                  |   18 
 drivers/target/target_core_fabric_lib.c                              |   10 
 drivers/target/target_core_tpg.c                                     |   10 
 drivers/target/target_core_user.c                                    |    5 
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c              |    3 
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c         |    6 
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.c     |    2 
 drivers/vdpa/solidrun/snet_ctrl.c                                    |    3 
 drivers/vdpa/vdpa_user/iova_domain.c                                 |   11 
 drivers/vhost/scsi.c                                                 |    7 
 drivers/vhost/vdpa.c                                                 |    8 
 drivers/vhost/vhost.c                                                |    3 
 drivers/vhost/vringh.c                                               |   27 
 drivers/vhost/vsock.c                                                |   34 
 fs/9p/v9fs.c                                                         |   18 
 fs/9p/vfs_inode.c                                                    |    8 
 fs/btrfs/ioctl.c                                                     |   24 
 fs/btrfs/sysfs.c                                                     |    1 
 fs/ceph/addr.c                                                       |    6 
 fs/erofs/fileio.c                                                    |   18 
 fs/ext2/file.c                                                       |    3 
 fs/ext2/inode.c                                                      |   13 
 fs/f2fs/checkpoint.c                                                 |   13 
 fs/f2fs/data.c                                                       |   28 
 fs/f2fs/f2fs.h                                                       |   10 
 fs/f2fs/gc.c                                                         |   11 
 fs/f2fs/node.c                                                       |   75 +-
 fs/f2fs/segment.c                                                    |    3 
 fs/f2fs/super.c                                                      |   24 
 fs/f2fs/sysfs.c                                                      |    2 
 fs/fat/inode.c                                                       |    2 
 fs/nfsd/nfs2acl.c                                                    |   64 +
 fs/nfsd/nfs3proc.c                                                   |   58 +
 fs/nfsd/nfs3xdr.c                                                    |    2 
 fs/nfsd/nfs4proc.c                                                   |   60 +
 fs/nfsd/nfs4recover.c                                                |   49 +
 fs/nfsd/nfs4state.c                                                  |   24 
 fs/nfsd/nfs4xdr.c                                                    |    2 
 fs/nfsd/nfsctl.c                                                     |   56 +
 fs/nfsd/nfsproc.c                                                    |    2 
 fs/nfsd/state.h                                                      |    2 
 fs/nfsd/vfs.c                                                        |  108 ---
 fs/nfsd/vfs.h                                                        |   21 
 fs/nfsd/xdr3.h                                                       |    2 
 fs/notify/inotify/inotify_fsnotify.c                                 |    2 
 fs/ntfs/ea.c                                                         |    5 
 fs/ntfs3/xattr.c                                                     |   25 
 fs/ocfs2/cluster/tcp.c                                               |    5 
 fs/ocfs2/dcache.h                                                    |    5 
 fs/ocfs2/dlm/dlmmaster.c                                             |   70 +
 fs/ocfs2/dlmglue.c                                                   |   34 
 fs/ocfs2/filecheck.c                                                 |    2 
 fs/ocfs2/journal.c                                                   |   15 
 fs/ocfs2/journal.h                                                   |    1 
 fs/ocfs2/move_extents.c                                              |   70 +
 fs/ocfs2/super.c                                                     |    3 
 fs/ocfs2/xattr.c                                                     |  120 +++
 fs/open.c                                                            |    1 
 fs/overlayfs/dir.c                                                   |   46 -
 fs/overlayfs/export.c                                                |    4 
 fs/overlayfs/inode.c                                                 |    8 
 fs/overlayfs/namei.c                                                 |   13 
 fs/overlayfs/overlayfs.h                                             |   21 
 fs/overlayfs/readdir.c                                               |    6 
 fs/overlayfs/super.c                                                 |   12 
 fs/overlayfs/util.c                                                  |   13 
 fs/proc/task_mmu.c                                                   |    2 
 fs/smb/server/mgmt/user_session.c                                    |    4 
 fs/smb/server/smb2pdu.c                                              |   65 +
 fs/smb/server/smbacl.c                                               |   43 +
 fs/smb/server/vfs.c                                                  |    4 
 fs/smb/server/vfs.h                                                  |    2 
 fs/smb/server/vfs_cache.c                                            |   58 +
 fs/udf/balloc.c                                                      |   11 
 fs/udf/super.c                                                       |   80 ++
 fs/udf/truncate.c                                                    |    7 
 fs/xfs/libxfs/xfs_attr_leaf.c                                        |    9 
 fs/xfs/libxfs/xfs_bmap.c                                             |   14 
 fs/xfs/libxfs/xfs_bmap.h                                             |   10 
 fs/xfs/libxfs/xfs_btree.c                                            |    4 
 fs/xfs/scrub/attr.c                                                  |  102 ++
 fs/xfs/scrub/attr_repair.c                                           |   16 
 fs/xfs/scrub/dir.c                                                   |  110 ++-
 fs/xfs/scrub/dir_repair.c                                            |  100 ++
 fs/xfs/scrub/quota_repair.c                                          |   33 
 fs/xfs/xfs_discard.c                                                 |   26 
 fs/xfs/xfs_file.c                                                    |    2 
 fs/xfs/xfs_healthmon.c                                               |    2 
 fs/xfs/xfs_ioctl32.c                                                 |    4 
 fs/xfs/xfs_ioend.c                                                   |    2 
 fs/xfs/xfs_iomap.c                                                   |   28 
 fs/xfs/xfs_iomap.h                                                   |    3 
 fs/xfs/xfs_pnfs.c                                                    |   52 +
 include/acpi/acpi_bus.h                                              |    7 
 include/acpi/cppc_acpi.h                                             |    6 
 include/asm-generic/tlb.h                                            |    3 
 include/crypto/mldsa.h                                               |    6 
 include/dt-bindings/clock/nuvoton,ma35d1-clk.h                       |    3 
 include/linux/assoc_array_priv.h                                     |    2 
 include/linux/blkdev.h                                               |    4 
 include/linux/can/can-ml.h                                           |    3 
 include/linux/can/dev.h                                              |    2 
 include/linux/can/skb.h                                              |    4 
 include/linux/damon.h                                                |   10 
 include/linux/huge_mm.h                                              |    5 
 include/linux/hugetlb.h                                              |   15 
 include/linux/ksm.h                                                  |    6 
 include/linux/memfd.h                                                |    9 
 include/linux/mmu_notifier.h                                         |    3 
 include/linux/mmzone.h                                               |    2 
 include/linux/nfs4.h                                                 |    6 
 include/linux/shmem_fs.h                                             |   15 
 include/linux/srcu.h                                                 |   36 +
 include/linux/sunrpc/clnt.h                                          |    3 
 include/linux/sunrpc/svc.h                                           |    7 
 include/linux/userfaultfd_k.h                                        |    2 
 include/net/espintcp.h                                               |    5 
 include/net/inet_frag.h                                              |    9 
 include/net/netns/can.h                                              |    2 
 include/net/sctp/sm.h                                                |    1 
 include/sound/cs35l56.h                                              |    4 
 include/sound/hwdep.h                                                |    1 
 include/uapi/linux/iommufd.h                                         |    6 
 io_uring/cancel.c                                                    |   26 
 io_uring/poll.c                                                      |   62 +
 io_uring/rsrc.c                                                      |   21 
 io_uring/sqpoll.c                                                    |   26 
 kernel/events/core.c                                                 |    9 
 kernel/fork.c                                                        |   20 
 kernel/panic.c                                                       |    2 
 kernel/sched/fair.c                                                  |    4 
 lib/assoc_array.c                                                    |  355 ++++++----
 lib/base64.c                                                         |    3 
 lib/crypto/Kconfig                                                   |    6 
 lib/crypto/mldsa.c                                                   |   15 
 lib/crypto/tests/mldsa_kunit.c                                       |    9 
 mm/cma.c                                                             |   14 
 mm/damon/core.c                                                      |   32 
 mm/damon/sysfs-schemes.c                                             |    8 
 mm/filemap.c                                                         |   84 +-
 mm/gup.c                                                             |   68 +
 mm/huge_memory.c                                                     |  146 +++-
 mm/hugetlb.c                                                         |   92 +-
 mm/hugetlb_vmemmap.c                                                 |    8 
 mm/internal.h                                                        |   38 -
 mm/khugepaged.c                                                      |   75 +-
 mm/ksm.c                                                             |   66 +
 mm/madvise.c                                                         |    9 
 mm/memcontrol.c                                                      |    5 
 mm/memfd.c                                                           |    2 
 mm/memory-tiers.c                                                    |   29 
 mm/memory.c                                                          |  129 ++-
 mm/mempolicy.c                                                       |    4 
 mm/migrate.c                                                         |    5 
 mm/mm_init.c                                                         |    2 
 mm/mmap.c                                                            |    8 
 mm/mmu_notifier.c                                                    |   24 
 mm/mremap.c                                                          |  103 +-
 mm/nommu.c                                                           |    2 
 mm/page-writeback.c                                                  |    8 
 mm/page_alloc.c                                                      |   30 
 mm/page_alloc.h                                                      |   14 
 mm/rmap.c                                                            |   23 
 mm/shmem.c                                                           |  141 ++-
 mm/shmem_quota.c                                                     |   28 
 mm/swapfile.c                                                        |    7 
 mm/truncate.c                                                        |   13 
 mm/userfaultfd.c                                                     |   57 -
 mm/util.c                                                            |   13 
 mm/vma.c                                                             |   54 +
 mm/vma_init.c                                                        |    3 
 mm/vmscan.c                                                          |   29 
 net/9p/trans_usbg.c                                                  |   89 +-
 net/9p/trans_virtio.c                                                |    5 
 net/9p/trans_xen.c                                                   |   10 
 net/batman-adv/bat_iv_ogm.c                                          |    5 
 net/batman-adv/distributed-arp-table.c                               |    1 
 net/batman-adv/main.c                                                |   12 
 net/batman-adv/multicast_forw.c                                      |    5 
 net/batman-adv/tp_meter.c                                            |    2 
 net/batman-adv/translation-table.c                                   |  133 ++-
 net/batman-adv/types.h                                               |    8 
 net/bluetooth/hci_sync.c                                             |   25 
 net/bluetooth/l2cap_core.c                                           |   47 +
 net/can/af_can.c                                                     |   54 -
 net/can/bcm.c                                                        |   50 -
 net/can/gw.c                                                         |    7 
 net/can/isotp.c                                                      |  230 ++++--
 net/can/proc.c                                                       |   69 +
 net/can/raw.c                                                        |  274 ++++---
 net/core/dev.c                                                       |    4 
 net/core/filter.c                                                    |   23 
 net/core/sock.c                                                      |    6 
 net/ipv4/cipso_ipv4.c                                                |    9 
 net/ipv4/inet_connection_sock.c                                      |    6 
 net/ipv4/inet_fragment.c                                             |    5 
 net/ipv4/inet_hashtables.c                                           |    2 
 net/ipv4/inet_timewait_sock.c                                        |    4 
 net/ipv4/syncookies.c                                                |    2 
 net/ipv4/tcp_fastopen.c                                              |    2 
 net/ipv4/xfrm4_output.c                                              |    7 
 net/ipv6/addrconf.c                                                  |    3 
 net/ipv6/datagram.c                                                  |    4 
 net/ipv6/inet6_hashtables.c                                          |    2 
 net/ipv6/raw.c                                                       |    3 
 net/l2tp/l2tp_core.c                                                 |   13 
 net/mac80211/tdls.c                                                  |    3 
 net/mac80211/tx.c                                                    |    2 
 net/mptcp/pm_kernel.c                                                |    1 
 net/mptcp/subflow.c                                                  |   11 
 net/qrtr/af_qrtr.c                                                   |   53 +
 net/sched/sch_generic.c                                              |   41 +
 net/sched/sch_qfq.c                                                  |    3 
 net/sched/sch_taprio.c                                               |    5 
 net/sctp/sm_make_chunk.c                                             |   14 
 net/sctp/socket.c                                                    |   57 +
 net/smc/smc_rx.c                                                     |   39 +
 net/sunrpc/rpcb_clnt.c                                               |   22 
 net/sunrpc/svc.c                                                     |   42 +
 net/wireless/reg.c                                                   |    3 
 net/xfrm/espintcp.c                                                  |   43 -
 net/xfrm/xfrm_interface_core.c                                       |    8 
 net/xfrm/xfrm_policy.c                                               |   11 
 rust/kernel/cpufreq.rs                                               |    4 
 sound/core/hwdep.c                                                   |    2 
 sound/core/ump_convert.c                                             |    2 
 sound/hda/codecs/realtek/alc269.c                                    |   45 +
 sound/hda/codecs/side-codecs/tas2781_hda.c                           |   27 
 sound/pci/cs46xx/dsp_spos.c                                          |    2 
 sound/pci/cs46xx/dsp_spos_scb_lib.c                                  |    3 
 sound/soc/amd/yc/acp6x-mach.c                                        |    7 
 sound/soc/codecs/cs35l56-sdw.c                                       |   27 
 sound/soc/codecs/cs35l56-shared.c                                    |   38 +
 sound/soc/codecs/cs35l56.c                                           |   17 
 sound/soc/codecs/cs35l56.h                                           |    1 
 sound/soc/codecs/hdac_hda.c                                          |   25 
 sound/soc/codecs/tas2770.c                                           |   14 
 sound/soc/qcom/qdsp6/q6apm.c                                         |    6 
 sound/soc/qcom/qdsp6/q6prm.c                                         |    3 
 sound/soc/sof/intel/hda-codec.c                                      |   23 
 sound/soc/sof/intel/hda-sdw-bpt.c                                    |    6 
 sound/usb/bcd2000/bcd2000.c                                          |   20 
 sound/usb/caiaq/input.c                                              |    2 
 sound/usb/line6/capture.c                                            |   29 
 sound/usb/midi.c                                                     |   64 +
 sound/usb/qcom/qc_audio_offload.c                                    |    7 
 sound/usb/usx2y/us122l.c                                             |   27 
 sound/usb/usx2y/usX2Yhwdep.c                                         |    5 
 sound/usb/usx2y/usb_stream.c                                         |    9 
 sound/usb/usx2y/usbusx2yaudio.c                                      |   43 +
 tools/perf/tests/tool_pmu.c                                          |   79 ++
 tools/perf/util/evsel.c                                              |   30 
 tools/perf/util/hwmon_pmu.c                                          |    2 
 tools/perf/util/tool_pmu.c                                           |    2 
 tools/testing/selftests/filesystems/fscontext_ns/fscontext_ns_test.c |    2 
 tools/testing/selftests/net/fib_nexthops.sh                          |   40 -
 466 files changed, 7065 insertions(+), 2708 deletions(-)

Akshay Jindal (1):
      iommu/amd: Skip non-IVMD entries when parsing IVRS memory definitions

Alex Hung (1):
      drm/amd/display: Avoid closing unowned DDC pins

Alex Kazinsky (2):
      wifi: rsi: Skip TX aggregation setup for non-QoS frames
      ALSA: cs46xx: Handle SCB creation failures before dereferencing

Alexandr (1):
      ALSA: hda/realtek: Enable mute and mic-mute LEDs on HP ENVY 17-cr0xxx

Alexei Solcanu (1):
      hwmon: (gpd-fan) Reset both fans to automatic on duo boards

Alexei Starovoitov (1):
      net: reject a negative TCP header offset in qdisc_pkt_len_segs_init()

Ali Ahmet Memiş (3):
      ACPI: utils: Add exclusive AML evaluation helpers
      ACPI: battery: Evaluate battery methods exclusively
      thermal: intel: int340x: Evaluate _TMP exclusively

Amir Goldstein (2):
      ovl: inherit FMODE_NONOTIFY when opening directory realfiles
      selftests/fscontext_ns: expect EINVAL for overlay descendant userns create

Andrea Parri (1):
      iommufd/iova_bitmap: Ensure that iova_bitmap_set() handles the full IOVA

Andrew Luebke (1):
      scsi: aic79xx: Fix NULL pointer dereference in device reset

Andrew Morton (2):
      block: restore the iterator when rejecting a misaligned bio
      openrisc: export __mulsi3 for modules

André Draszik (2):
      drm/drm_crtc: ensure dma_fence_ops remain valid during device unbind
      drm/drm_crtc: fix race with dma_fence_signal() in ::get_driver_name()

Andy Shevchenko (1):
      intel_idle: Use 2-argument strscpy()

Antti Laakso (1):
      media: ipu6: Rename pointer to firmware context

Arnaldo Carvalho de Melo (1):
      perf evsel: Close the fds opened so far when disabling missing features

Arnd Bergmann (1):
      mm/vmscan: avoid false-positive -Wuninitialized warning, again

Ashok Raj (1):
      cxl/features: Ensure that count is set before access to ent[] __counted_by()

Babu Moger (2):
      x86/resctrl: Correct ABMC counter ID field width
      x86,fs/resctrl: Keep mbm_assign_mode in default mode at boot

Baek Kyu, Kim (2):
      hwmon: (corsair-cpro) Cache fan target only after a successful command
      hwmon: (gpio-fan) Update the speed cache before dropping the PM reference

Balakrishnan Sambath (4):
      media: microchip-isc: store the unshifted PFE_CFG0 BPS value
      media: microchip-isc: fix WB offset and gain register field masking
      media: microchip-isc: fix ISC_PFG_CFG0_BPS macro name typo
      media: microchip-isc: fix SBGGR10 Bayer pattern

Baolin Wang (1):
      mm: memory: fix truncation removing mapped folios

Bartosz Golaszewski (1):
      dmaengine: qcom: bam_dma: free interrupt before the clock in error path

Bas Nieuwenhuizen (1):
      drm/amdgpu: Check cs flags.

Binbin Deng (1):
      xfs: set healthmon mount cookie before publishing it

Breno Leitao (2):
      x86/bugs: Select the BHI mitigation based on the attack vector properly
      x86/nmi: Ignore negative NMI handler durations

Bryam Vargas (1):
      net/smc: don't spin in smc_rx_recvmsg() while a pipe holds spliced data

Ce Sun (1):
      drm/amdgpu: skip RAS error count reset in debug mode

Cen Zhang (7):
      ocfs2: validate move extents against a stable EOF
      ocfs2: keep locking_state within the cluster connection lifetime
      ocfs2/dlm: serialize migration MLE cleanup on failure
      ocfs2: stop recovery before shutting down local allocators
      ocfs2/cluster: unlink socket containers before releasing resources
      ocfs2: wait for filecheck kobject release after a failed add
      ocfs2: cache the mount context for dentry lock callbacks

Chao Yu (6):
      f2fs: fix to avoid folio->mapping dereference in is_{meta, node}_folio()
      f2fs: fix to check continuousness in f2fs_sync_meta_pages() correctly
      f2fs: zone: fix to avoid bio split on sequential zone
      f2fs: fix to avoid potential reference count leak in do_garbage_collect()
      f2fs: fix to invalidate curseg if change_curseg() fails
      f2fs: fix to use bio_in_atomic() in f2fs_write_end_io()

Cheng Ming Lin (1):
      mtd: spi-nor: macronix: Restore fallback parameters for MX25L12805D

Chengfeng Ye (3):
      xfrm: retry inexact policy lookup after node reinsertion
      net/9p/usbg: clear stale request context after abort
      batman-adv: Close OGM aggregation before transmission

Chris Down (1):
      mm: make swapoff interruptible when unusing mms/shmem

Chris Mason (21):
      io_uring/cancel: drop sqd->lock while SQPOLL waits
      mm/mempolicy: charge shared policy nodes
      mm/shmem: stop retrying folios that cannot be split
      mm/shmem: preserve data in clean folios when splitting fails
      mm/huge_memory: fix truncate racing with PMD zapping
      mm/huge_memory: fix zapping migration entries for device-private THPs
      mm/khugepaged: preserve dirty bits when collapsing PTE-mapped THPs
      mm/gup: fix clearing folios in memfd_pin_folios()
      mm/gup: fix out-of-bounds write for nr_pages == 0 in GUP-fast
      mm/mmu_notifier: set ->mm only after mmgrab()
      mm/memory: reject remote COW faults on PFN mappings
      mm: fix unkillable fault loop on MAP_DROPPABLE memory
      mm: fix deadlock of mremap() against UFFDIO_MOVE
      mm/ksm: check large swap-cache folios before mapping them
      mm/vma: call ->may_split() before a partial merge
      ovl: fail the mount if the casefold flag has changed
      ovl: do not let chattr change the casefold flag
      ovl: fix whiteout creation in casefolded directories
      ovl: look up the index by the decoded origin
      x86/mm: Fix global ASID handed out to two processes
      mm/shmem: honour F_SEAL_EXEC when an ACL is set

Chris Simpson (1):
      ALSA: hda/realtek: Enable bass speakers on Alienware m17 R3

Christian Aurich Zanettini Martins (1):
      nvme-rdma: fix NULL queue->ctrl dereference on reconnect

Christian Gmeiner (2):
      drm/etnaviv: Fix NULL dereference on unbind without PPU flop reset
      drm/etnaviv: Flush the tile status cache through both the PE and BLT

Christian Loehle (3):
      ACPI: CPPC: Validate FFH register fields before hardware access
      ACPI: CPPC: Accept requests to retain immutable autonomous selection
      cpufreq: CPPC: Select the frequency-invariance callback per CPU

Christoph Hellwig (1):
      xfs: fix recovery of partial attr removals

Chuck Lever (7):
      NFSD: Replace nfsd_write()'s "stable" argument with "iocb_flags"
      NFSD: Move version-specific ACCESS maps into per-version code
      NFSD: map fh_verify() status codes for NFS_ACLv2 replies
      NFSD: Send a meaningful CB_RECALL_ANY keep count
      NFSD: Move the cld upcall message out of the caller's stack frame
      NFSD: Complete a cld upcall when the daemon closes the pipe
      NFSD: Complete a cld upcall when copying its reply fails

ChunYuZhiQiang (1):
      can: dev: can_fill_info(): don't wake up controller if interface is down

Cong Zhang (1):
      virtio_blk: use synchronous quiesce in virtblk_freeze_priv()

Cunhao Lu (2):
      can: skb: make echo skb freeing safe in any IRQ context
      can: dev: can_put_echo_skb(): free skb on invalid echo index

Daeho Jeong (3):
      f2fs: return -EIO for a lost inode block after cp_error
      f2fs: release a removed xattr node in roll-forward recovery
      f2fs: expose resizable_tail feature via sysfs

Daehyeon Ko (2):
      vhost/vsock: size receive SKBs from declared payload
      sched/fair: Clear throttle state when leaving the fair class

Daejun Park (9):
      xfs: don't skip free extents in later batches of a whole-AG FITRIM
      xfs: don't skip free extents of the longest length in a whole-AG FITRIM
      nvme: unregister when pr_register() is given a zero new key
      xfs: mark the inode preallocated for pNFS write layouts past EOF
      xfs: add a flag to convert unwritten extents without allocating blocks
      xfs: refuse a pNFS LAYOUTCOMMIT of a range without blocks
      xfs: clamp a pNFS LAYOUTCOMMIT extent before computing its end
      xfs: cap the block count of xfs_iomap_write_direct() at one extent
      xfs: clamp the pNFS layout range to the maximum file size

Danish Khateeb (1):
      perf/core: Don't send SIGTRAP after exec removed the event

Dariusz Marcinkiewicz (1):
      drm/amdgpu: check amdgpu_vm_ready() in dma-buf move notify

Darrick J. Wong (6):
      xfs: break out xattr entry checks into separate functions
      xfs: check for buffer overruns when examining local/remote xattr entries
      xfs: refactor directory data block walking loops in scrub
      xfs: improve dirent bounds checking in scrub and repair
      xfs: reinitialize dquot block if non-first dquot can't load
      xfs: forcibly reset quota timers when upgrading to bigtime during repair

David Carlier (1):
      media: ipu6: Fix firmware config leak on stream start

David Hildenbrand (Arm) (28):
      mm/shmem: discard whole new large folios on fallocate rollback
      mm/shmem: rescan after nonuniform folio splitting
      mm/shmem: fix truncate hang in large swap entry
      mm/shmem: preserve allocation errors when swapping in large entries
      mm/shmem: fix truncate loop after boundary swapin failure
      mm/shmem: fix accounting of swapin-error markers
      mm/shmem: fix truncation of files containing only swapin-error markers
      fork: take mmap_lock before copying mm_struct
      mm/shmem: make shmem_file() check the file's inode
      mm/truncate: look again if a folio left the mapping
      mm/filemap: finish fault cleanup before dropping the fault lock
      mm/rmap: handle device-exclusive entries in folio_referenced_one()
      mm/huge_memory: fix list corruption when deferred_split_scan() races with deferred_split_folio()
      mm/huge_memory: properly handle refcounted PUD mappings on fork
      mm: fix address wraparound when scanning large folio PTEs
      mm/vma: write lock source VMA before duplicating it in __split_vma()
      mm/gup: recheck the PUD under PTL in follow_pud_mask()
      mm/gup: check for overflow when converting nr_pages to bytes in GUP-fast
      mm/userfaultfd: write-lock the VMA before waking waiters when unregistering
      mm/mremap: use pudp_huge_get_and_clear() when moving huge PUDs
      mm/mremap: recheck PUDs under the page table lock
      mm/madvise: fix data loss from MADV_FREE on a KSM page
      mm/ksm: reset the unstable trees of all nodes
      mm/ksm: fix use of a freed anon_vma at swap-in
      mm/huge_memory: split huge PUDs when adjusting VMA boundaries
      mm/vma: don't leak the charge for stack growth
      mm/memory-tiers: unregister empty tiers outside memory_tier_lock
      mm/userfaultfd: only allocate anon_vma in CoW mappings

David Lee (1):
      sctp: hold shkey across socket migration

Devin Wittmayer (1):
      drm/panic: Fix kmsg screen hang on a long log line

Dom Cobley (1):
      drm/vc4: hdmi: power down the BCM2712 PHY when the output is disabled

Erhan Bilgili (2):
      drm/amdgpu: Fix duplicate dependency fence releases
      drm/amdgpu: Report MES ring wait timeouts.

Eric Biggers (4):
      lib/crypto: mips: Disable Octeon SHA code on little-endian kernels
      lib/crypto: mldsa: Check pk_len before doing pointer arithmetic
      lib/crypto: mldsa: Explicitly check that 'alg' is a valid value
      lib/crypto: mldsa: Add __must_check to mldsa_verify()

Eric Dumazet (1):
      inet: frags: limit the truesize of a reassembly queue

Esben Haabendal (2):
      drm/bridge: nwl-dsi: Cleanup endpoint mux control selection
      drm/bridge: nwl-dsi: Limit LCDIF specific sync override

Evanshenf (3):
      drm/loongson: Fix framebuffer selection in async cursor updates
      drm/loongson: Fix double free on BO initialization failure
      drm/loongson: Handle buffer mapping failures when clearing a BO

Ewan D. Milne (1):
      nvmet: don't return memory contents beyond valid data when reading ANA log page

Fang Xieyan (3):
      vringh: bound top-level re-entry into indirect tables
      vringh: reject empty / undersized indirect descriptor tables
      vhost: fix used ring index wrap in vhost_add_used_n_in_order

Federico Musto (1):
      net: atl1c: drop oversized RX frames instead of panicking

Finn Zeruhn (1):
      drm/dp: keep MOT set between messages when no_zero_sized is set

Fourie Zhang (1):
      xfrm4: use a full socket for local errors

Franck Baur (1):
      net: jme: keep RX MAC clock enabled for WoL

Fuad Tabba (1):
      KVM: arm64: Use kvm_s2_fault_vma_info in gmem_abort()

Gael Blivet (1):
      ksmbd: look up stream size by exact xattr name

Gianluca Balboni (1):
      ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx

Greg Kroah-Hartman (1):
      Linux 7.3.5

Gregory Price (Meta) (1):
      mm/page_alloc: let the highest memory node recover from hopeless state

Guanglei Zhu (1):
      ceph: clamp the inline data length in ceph_fill_inline_data()

Guenter Roeck (16):
      hwmon: (aquacomputer_d5next) Check maxcollection when probing AQUAERO devices
      hwmon: (asus_wmi_sensors) Avoid global struct mutation
      hwmon: (hp-wmi-sensors) Avoid global struct mutation
      hwmon: (hp-wmi-sensors) Fix unbounded loops in scale_numeric_sensor()
      hwmon: (lm87) Fix drvdata type confusion in vrm_show() and vrm_store()
      hwmon: (nct6683) Fix incorrect struct cast in show_pwm() and store_pwm()
      hwmon: (peci/dimmtemp) Fix devres leak and UAF on concurrent unbind
      hwmon: (pmbus/q54sj108a2) Add missing NULL pointer check
      hwmon: (pmbus) Check return value from pmbus_thermal_add_sensor()
      hwmon: (pmbus) Release devres allocated memory after devm_thermal_of_zone_register error
      hwmon: (pmbus) Fix return value check from thermal zone registration
      hwmon: (lm75) Fix setting polarity mask for chips with 16-bit config register
      hwmon: (tmp108) Fix initial conversion delay and wait until ready
      hwmon: (coretemp) Check for NULL platform device in hotplug callbacks
      hwmon: (coretemp) Set nr_cores only after core_data allocation succeeds
      hwmon: (sht4x) Convert update_interval to jiffies in pending data check

Guixin Liu (1):
      nvme-tcp: Validate the queue state under the queue lock in the address attribute

Hemanth Selam (1):
      platform/chrome: Fix typos in comments

Hengyu Liang (4):
      btrfs: fix chattr failing on nodatasum files that have the compress flag
      fs/proc/task_mmu: return -ENOTTY for unknown pagemap ioctls
      l2tp: only return sessions of the given tunnel in l2tp_session_get()
      erofs: fix metadata reads at the end of file-backed images

Hugo Sales (1):
      drm/amdgpu: Clamp the ATIF backlight curve to its 99 points

Hui Su (1):
      perf evsel: Restrict incremental open error unwind

Hungyu Lin (6):
      ext2: preserve completed DIO bytes when buffered fallback fails
      mm/page-writeback: avoid 32-bit overflow in dirty threshold shares
      mm/migrate: untag addresses when querying page nodes
      inotify: do not coalesce rename events
      block: Return the soft block size for compat BLKBSZGET
      ext2: preserve IOMAP_F_DIRTY for extending direct writes

HyeongJun An (1):
      ALSA: ump: Fix dropped data bytes at UMP System message conversion

Hyungjung Joo (1):
      net/9p/usbg: clear stale client pointer on close

Hyunwoo Kim (1):
      net: restore refcount ordering for lockless socket access

Ian Bridges (6):
      ksmbd: require DELETE access for delete-on-close opens
      ksmbd: enforce the read-only share flag when creating a stream
      ksmbd: revert fsids on durable reconnect and replay failure
      ksmbd: do not read past the DACL in the access denied debug message
      ksmbd: grant a POSIX ACL group entry only to the group's members
      ksmbd: let the owner read and change the DACL when no ACE names it

Ido Schimmel (1):
      vxlan: Stop rejecting dynamic FDB entries with a nexthop ID

Ilia Mirkin (1):
      drm/nouveau/devinit/gf100-: try to avoid double-running vbios scripts

Imre Kaloz (4):
      scsi: aic7xxx: Use default settings on the SGI O2 onboard controllers
      MIPS: mm: Fix the cache error vector jump for XKPHYS kernels
      MIPS: sgi-ip32: Mask MACE PCI interrupts in CRIME only
      MIPS: sgi-ip32: Leave MACE PCI control alone in config accesses

Jack Blessed Kimani (1):
      ksmbd: fix NULL pointer dereference in session_user_name() and session_account_type()

Jamal Hadi Salim (2):
      bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
      net/sched: clamp skb->queue_mapping before indexing the tx queue

James Calligeros (1):
      ASoC: tas2770: Fix error detection in tas2770_set_dai_tdm_idle

James Clark (1):
      net: ethernet: ti: am65-cpsw-nuss: Enable timestamping of unicast PTP packets

James Fairweather (1):
      platform/chrome: cros_usbpd_notify: Only use drvdata when parent is GOOG0004

Janne Grunau (1):
      wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload

Jared Wuerzburger (1):
      ALSA: hda/realtek: Fix internal mic on Minisforum V3 and V3 SE

Jarkko Sakkinen (1):
      nvme-keyring: Add a missing key_put() call to nvme_tls_key_lookup()

Jason Gunthorpe (1):
      iommu/arm-smmu-v3: Handle ARM erratum for CONT under invalidation with SVA

Jason Perlow (1):
      wifi: brcmfmac: map msgbuf RX packet IDs bidirectional

Javier Carrasco (11):
      hwmon: chipcap2: fix command error diagnostics
      hwmon: chipcap2: fix off-by-one in command mode retry loop
      hwmon: chipcap2: fix be16 handling
      hwmon: chipcap2: defer probe when IRQs are unavailable
      hwmon: chipcap2: fix IRQ teardown ordering
      hwmon: chipcap2: disable device after hwmon teardown
      hwmon: chipcap2: enable IRQ processing when regulator is already enabled
      hwmon: chipcap2: balance regulator state
      hwmon: chipcap2: do not discard pending alarms on disable
      hwmon: chipcap2: serialize access to the alarm indicators
      hwmon: chipcap2: synchronize ready IRQ state

Jeff Layton (4):
      NFSD: report listener creation failures through extack
      SUNRPC: report local rpcbind calls that get no answer
      NFSD: stop registering with rpcbind after a failure in listener_set
      nfsd: shorten extack string returned with dodgy listener

Jens Axboe (3):
      io_uring/sqpoll: don't attach to a thread that is canceling
      io_uring/poll: don't poll a writer for a read side hangup
      io_uring/poll: don't poll a writer for urgent data

Jesse Zhang (11):
      drm/amdgpu: sign extend the addresses GEM_OP(GET_MAPPING_INFO) returns
      drm/amdgpu: parse CS IBs at the BO offset their VA mapping starts at
      drm/amdgpu: keep the CS user fence BO in GTT
      drm/amdkfd: use the queue's process info for the WPTR BO eviction fence
      drm/amdgpu/userq: validate the moved individual BOs on restore
      drm/amdgpu/gfx12: disallow GFXOFF while updating the SPM VMID
      drm/amdgpu: drop the dma-buf reference when a KFD import fails
      drm/amdgpu: unlock the VM and BO when attaching a KFD BO fails
      drm/amdgpu: rewrite all PTEs of the BOs after a VM reset
      drm/amdgpu: don't walk the CS chunks when allocating them failed
      drm/amdgpu: don't drop the gang dependency fence twice

Jiale Yao (1):
      hwmon: (aquacomputer_d5next) reject short status reports

Jianyun Gao (1):
      xfs: fix temporary cursor leak in btree shift corruption paths

Jinjie Ruan (1):
      arm64: kexec_file: Fix elf_headers memory leak in retry loop

Jinwang Li (1):
      Bluetooth: L2CAP: Ignore connection responses with wrong ident

Johannes Weiner (2):
      mm: page_alloc: do not give all non-blocking requests reserve access
      mm: page_alloc: remove ALLOC_NON_BLOCK from ALLOC_RESERVES

Joonhoe Kim (1):
      net: qrtr: announce local services again once our HELLO is sent

Jose Maria Casanova Crespo (1):
      drm/v3d: Initialize timedout_batches when running a CSD job

Josef Bacik (14):
      tmpfs: keep the quota soft limits of an unused id
      tmpfs: preserve explicitly disabled quota limits
      mm/mglru: don't use stack pointers when walking PUD and PMD tables
      mm/memfd: make f_pos accesses atomic
      mm/filemap: read mapping->a_ops->free_folio under i_lock
      mm/filemap: don't lose a folio lock wakeup to a signal
      blk-mq: end the request if getting a keyslot fails
      mm/khugepaged: always recheck the pmd in try_collapse_pte_mapped_thp()
      mm/khugepaged: fix PMD table lock leak in try_collapse_pte_mapped_thp()
      mm/userfaultfd: wake all waiters on unregister
      mm/mmu_gather: fix flushing ranges with 4 GiB or larger
      mm/mmu_notifier: finish non-blocking interval invalidation on error
      mm/mremap: fix moving PUD leaves
      mm: fix unmap_mapping_range() beyond 4 GiB on 32-bit

Joseph Qi (5):
      ocfs2: find the xattr entry again after defragmenting a bucket
      ocfs2: find the xattr entry again after converting a block to a bucket
      ocfs2: do not read the entry array of an empty xattr bucket
      ocfs2: do not index before the entry array when dividing an empty bucket
      ocfs2: do not read the entry array of an empty xattr block

Jouni Högander (5):
      drm/i915/psr: Clear selective fetch area when duplicating plane state
      drm/i915/display: Add enabled pipe planes into state for selective fetch
      drm/i915/psr: Disable linked plane sel fetch as well
      drm/i915/psr: Fix SFF and CFF CTL register bit definitions
      drm/i915/psr: Don't clip plane state destination rectangle

Jun Yang (1):
      sctp: re-point retained control chunks on association migration

Kairui Song (1):
      mm/mglru: use explicit tier range in read_ctrl_pos()

Kaixuan Li (2):
      can: isotp: check the frame type, not just the length
      f2fs: bound the SIT/NAT bitmaps by the checkpoint pack

Kent Russell (1):
      drm/amdgpu: Ensure that harvest information gets set

Kevin Mitchell (1):
      iommu/amd: remove obsolete domain pointer warning on release

Kevin Wang (1):
      drm/amd/pm: populate unique ID for smu 13.0.7

Kiryl Shutsemau (Meta) (3):
      mm/hugetlb_vmemmap: map the shared tail page writable
      arm64: sdei: Run the event handler on the kernel vectors
      arm64: sdei: Preserve the interrupted context's exception registers

Krystian Kaniewski (1):
      blk-mq: fix out-of-bounds read in blk_mq_free_rqs

Kyle Zeng (4):
      batman-adv: mcast: validate tracker padding before forwarding
      mm/khugepaged: flush deferred unmaps before dropping a failed folio
      net/sched: sch_qfq: prevent aggregate self-replacement
      mptcp: pm: kernel: use RCU to free endpoint listeners

Kylie C (1):
      drm/amd/display: Don't select zero V_TOTAL_MIN/MAX on seamless boot

Lance Yang (2):
      mm/ksm: fix userfaultfd protection during merge and unmerge
      khugepaged: fix readahead lock inversion in collapse_file()

Laveesh Bansal (1):
      block: only serialize elevator switches of the same queue

Lee Jones (1):
      ASoC: SOF: Intel: hda-sdw-bpt: Stop active DMA before closing BPT streams

Li Zhe (2):
      mm/hugetlb: fix mremap move length truncation
      mm/hugetlb: fix mremap deadlock when PMD sharing is possible

Linmao Li (1):
      PCI: cadence: Store the core controller in platform drvdata

Linus Torvalds (9):
      assoc_array: don't lose objects when a shortcut is split on a word boundary
      assoc_array: don't lose objects when a root shortcut is split at level 4
      assoc_array: move in-place insertion into a function of its own
      assoc_array: fill the segment cache in one place
      assoc_array: move node splitting into a function of its own
      assoc_array: move shortcut creation into a function of its own
      assoc_array: choose between splitting a node and a shortcut without gotos
      assoc_array: don't chain a new shortcut onto an existing one
      assoc_array: keep gc's cleanup out of the live tree on allocation failure

Liu Changjie (1):
      can: peak_usb: pcan_usb_fd_decode_buf(): accept short uCAN end-of-list records

Lorenzo Stoakes (ARM) (1):
      mm/vma: update VMA iterator state on error in new VMA merge

Lu Yao (1):
      drm/i915/gem: Reset err for each fence entry

Lucas Tanure (2):
      drm/vc4: hdmi: always cancel the scrambling work synchronously
      drm/vc4: hdmi: enable scrambling before the TMDS clock starts

Marc Zyngier (1):
      KVM: arm64: vgic: Stop the target vcpu when disabling LPIs

Marco Ziliani (1):
      ata: libata-pmp: disable the SEMB port on Marvell 88SM9705

Martin Belanger (1):
      nvme-tcp: skip TLS control records while waiting for the ICResp

Masafumi Suzuki (1):
      sctp: account for chunk padding in sctp_init_cause()

Matheus Alves de Almeida (1):
      fat: hold truncate_lock in fat_write_failed()

Matthew Schwartz (1):
      drm/amd/display: Keep the nominal vtotal while VRR is inactive

Matthias Goergens (4):
      udf: don't let the extent type hide an exhausted free-space table extent
      udf: check the unallocated space table when it is loaded
      udf: fix preallocation discarding before an empty allocation extent
      udf: don't use eloc after the end of the unallocated space table

Maíra Canal (3):
      drm/vc4: Publish the output fence outside of job_lock
      drm/vc4: Drop the BO reservations outside of job_lock
      drm/v3d: Widen cache_clean_lock over the whole L2TCACTL sequence

Mehmet Fide (4):
      wifi: rtw88: usb: route bmc frames via the high queue only for DTIM delivery
      wifi: rtw88: usb: bound what the driver feeds the after-DTIM queue
      wifi: rtw88: usb: only let the frames a dozing station needs use the after-DTIM queue
      wifi: rtw88: widen the ATIM window while an AP interface is up

Melissa Wen (1):
      drm/amd/display: Signal PQ EOTF in FreeSync infopacket for DP HDR

Michael Bommarito (1):
      9p/trans_virtio: reject mount tags longer than NAME_MAX at probe

Michael Grzeschik (6):
      net/9p/usbg: also disable endpoints on p9_usbg_close
      net/9p/usbg: set client to Disconnected on usb9pfs_disable
      net/9p/usbg: always reset completion when disconnecting
      net/9p/usbg: call disable_usb9pfs() from usb9pfs_disable()
      net/9p/usbg: fix out_req buffer leak in disable_usb9pfs
      net/9p/usbg: remove bogus context initialization in alloc_requests

Michael McAllister (1):
      Bluetooth: qca: Fix the WCN3950 NVM baud rate offset

Miguel Ojeda (1):
      rust: cpufreq: fix `undocumented_unsafe_blocks` in `PolicyCpu::from_cpu()`

Mike Rapoport (Microsoft) (2):
      mm/cma: accept memory of multi-range CMA areas
      mm/cma: accept memory of CMA areas reserved at a fixed address

Mikhail Gavrilov (1):
      drm/amd/display: set allow_freesync before validating a new stream

Milan Milicevic (2):
      drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts for navi10_ih
      drm/amdgpu: publish IH enabled before PSP programs IH_RB_CNTL

Miquel Raynal (4):
      clk: nuvoton: ma35d1: Keep the clock count in the driver
      dt-bindings: clock: ma35d1: Drop CLK_MAX_IDX define
      dt-bindings: clock: ma35d1: Add missing WDT/WWDT parent clocks
      clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks

Misha Nasledov (1):
      drm/amd/display: Drop clock requirements on DCN32 when no displays are active

Mitul Golani (1):
      drm/i915/display: Allow port sync on PTL

Mohamed Yassine Jebabli (1):
      ALSA: hda/tas2781: Only accept CRC-less V1 data if all entries are valid

Mohit Sharma (1):
      ASoC: qcom: q6apm: Guard callbacks until probe data is ready

Myeonghun Pak (1):
      hwmon: (sht15) Stop deferred work before releasing its resources

Naman Jain (1):
      x86/init: Initialize wall clock in get_rtc_noop()

Nathan Chancellor (1):
      lib/base64: silence clang-24 -Wconstant-conversion with diag pragmas

Nicholas Hobson (1):
      ALSA: usb-audio: keep MIDI input running for Roland TD-11

Nickolai Zeldovich (1):
      panic: zero the dynamically allocated taint buffer

Oliver Hartkopp (5):
      can: replace ARPHRD_CAN type checks with can_get_ml_priv()
      can: isotp: check the return values of can_rx_register() in isotp_bind()
      can: protect the receive lists with a per-device lock
      can: raw, isotp: copy socket options outside of lock_sock()
      can: proc: skip stats calculation after reset in can_stat_update()

Peter Ujfalusi (2):
      ASoC: hdac_hda: Allocate the private data at codec driver bind
      ASoC: hdac_hda: Restore the codec device type on unbind

Ping-Ke Shih (1):
      wifi: rtw88: TX report with long timeout for non-PCIE devices

Prike Liang (3):
      drm/amdgpu/userq: wait for GPU reset before mapping or unmapping queues
      drm/amdgpu: finish GPU recovery callbacks before restarting schedulers
      drm/amdgpu: stop the schedulers before preparing the GPU reset

Qihang (2):
      xfrm: interface: validate the IP header on xmit
      cipso: fix optlen corruption in cipso_v4_delopt()

Qiliang Yuan (2):
      srcu: Add list_splice_init_srcu()
      nvme: wait for SRCU readers before splicing the namespace list

Rafael J. Wysocki (1):
      intel_idle: Adjust state names and descriptions for _LPI states

Ray Zhang (1):
      net: count last skb of each sk_backlog pass in __release_sock()

Reid Downing (1):
      xfs: fix wrong compat fields in xfs_ioctl32_bstat_copyin()

Ricardo Ribalda (2):
      media: uvcvideo: Add autosuspend quirk for AVerMedia Live Gamer HD 2
      media: uvcvideo: Force UVC version for Avermedia GC515

Richard Fitzgerald (1):
      ASoC: cs35l56: Wait for firmware timer expiry before system suspend

Rik van Riel (1):
      mm/cma: don't release CMA pages still in use

Ritesh Harjani (IBM) (1):
      mm/huge_memory: set the mmu_gather page size in zap_huge_pud()

Roman Demidov (1):
      drm/amd/display: Fix NULL deref in dcn401_update_clocks_update_dtb_dto

Roman Li (1):
      drm/amd/display: Reset DET of HUBPs without a plane before outstanding updates

Rosen Penev (2):
      x86/csum: Relax the len and proto constraints in 32-bit csum_ipv6_magic()
      drm/nouveau/nvkm: clear use.enabled when subdev init fails

Runyu Xiao (2):
      can: proc: reset pkg_stats atomics individually
      ALSA: usb-audio: Protect Roland control activation

SJ Park (5):
      mm/damon/core: remove unreachable damos charge_{target,addr}_from
      mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
      mm/damon/sysfs-schemes: hold damon_sysfs_lock in target_metric_store()
      mm/damon/core: move static variable last_nr_regions to damon_ctx
      mm/damon/core: move static variable rotation to damon_ctx

Sabrina Dubroca (1):
      xfrm: espintcp: reorder operations within espintcp_init_sk

Saim Masood (1):
      ALSA: hda/realtek: Fix speakers on ASUS ExpertBook PM3606CHA

Salvatore Dipietro (1):
      mm/page_alloc: avoid direct reclaim and compaction for costly __GFP_NORETRY allocations

Samarth Narang (1):
      mm/ksm: keep soft-dirty when merging a page

Samiullah Khawaja (1):
      mm/gup: check folio->mapping under folio lock in memfd_pin_folios()

Sasha Levin (1):
      nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for KIOXIA XG10d

Sean Christopherson (5):
      KVM: x86/mmu: Conditionally resched when retrying gPTE walk on A/D update failure
      KVM: x86: Conditionally resched when restarting REP string emulation
      KVM: nVMX: Process each host MSR entry at most once when unwinding failed VM-Entry
      KVM: x86/mmu: Cap number of parent PTEs per SP at 1000 (the arbitrary rmap limit)
      KVM: x86: Unconditionally reset MMU context when emulating INIT

Shakeel Butt (1):
      io_uring/sqpoll: do the return-to-userspace work in the SQPOLL thread

Shang En Sim (2):
      io_uring/cancel: count all requests that a CANCEL_ALL cancels
      io_uring/poll: cancel all matching requests in one pass

Shao Mingyin (2):
      scsi: target: tcmu: Fix divide-by-zero in data_pages_per_blk store
      nvmet: bound the traddr and trsvcid configfs writes

Shuai Liu (1):
      io_uring/sqpoll: don't set IO_SQ_THREAD_SHOULD_STOP on thread exit

Shubham Antil (1):
      vhost-scsi: zero misaligned I/O bounce pages

Sinan Turunc (3):
      ALSA: line6: Reject capture buffers smaller than two packets
      ALSA: usx2y: Require a buffer of two URBs
      ALSA: usx2y: Guard the playback copy

Siwei Zhang (2):
      Bluetooth: L2CAP: Reject signalling responses in invalid states
      Bluetooth: L2CAP: Only accept connection responses to outstanding requests

Stefano Garzarella (1):
      9p: fix privport option setting wrong RDMA field

Sumit Kumar (1):
      PCI: dwc: Set DMA_BYPASS bit in outbound IATU CTRL2 register

Suravee Suthikulpanit (1):
      iommu/amd: Force device table to maximum size

Sven Eckelmann (10):
      batman-adv: tpmeter: fix u32 truncation of reported bytes
      batman-adv: dat: initialize orig_node of unfilled candidate slots
      batman-adv: fix skb leak when hard_iface is being released
      batman-adv: stop originator purge worker before freeing TT
      batman-adv: tt: ignore ROAM flag of received ADD changes
      batman-adv: tt: don't drop local events queued during TVLV update
      batman-adv: tt: only transmit local ROAM flag together with DEL
      batman-adv: tt: clear ROAM flag when re-adding a pending local client
      batman-adv: tt: send ROAM_ADV on each roamed back client
      batman-adv: tt: only update flags for TT events

T.J. Mercier (1):
      mm: memcontrol: fix NULL pointer deref and UAF from high_work_func() on dying memcg

Tal Zussman (1):
      vhost-vdpa: fix pinned page leak in vhost_vdpa_pa_map() error path

Thomas Gleixner (1):
      x86/entry: Fix ptrace regression

Thorsten Blum (2):
      hwrng: virtio - prevent use-after-free after a failed restore
      x86/boot: Fix off-by-one error in sme_clear_pgd()

Toke Høiland-Jørgensen (1):
      wifi: mac80211: reinstate IEEE80211_TX_CTL_AMPDU flag in ieee80211_tx_prep_agg()

Tvrtko Ursulin (2):
      drm/sched: Fix out of bounds entity priority check
      drm/sched: Adjust run-queue when changing priority at runtime

Valentin Kindschi (2):
      Bluetooth: hci_sync: re-enable legacy advertising on resume
      Bluetooth: hci_sync: pause advertising for the scan address update

Vas Zayarskiy (1):
      hwmon: (aquacomputer_d5next) Avoid truncating scaled sensor readings

Vidya Srinivas (2):
      drm/i915/display: Single scaler per pipe on WCL
      drm/i915/display: Disable pipe joiner on WCL

Vincent Donnefort (2):
      KVM: arm64: Pass kvm_s2_fault_desc to fault_supports_stage2_huge_mapping()
      KVM: arm64: Use kvm_s2_fault_vma_info in pkvm_mem_abort()

Vincent Mailhol (1):
      can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices

Vishnu Santhosh (1):
      dmaengine: qcom: bam_dma: Defer IRQ trigger type to device tree

Vladimir Oltean (1):
      PCI: cadence: Preserve all error codes in cdns_plat_pcie_probe()

Wayne Lin (1):
      drm/amd/display: add missing CRC engine 1 registers

Wei Wang (1):
      arm64: suspend: Save and restore TPIDR2_EL0 across CPU suspend

Weigang He (1):
      wifi: mac80211: reload TDLS header pointer after skb_linearize()

Weiming Shi (1):
      smb/server: prevent file publication after tree disconnect

Wentao Liang (1):
      ALSA: caiaq: free the EP4 URB when input setup fails

Werner Sembach (1):
      drm/i915/display: Add quirk to force backlight type on some TUXEDO devices

Xia Yan (2):
      veth: keep carrier off when resizing channels with a down peer
      ipv6: fix device binding after failed datagram connect

Yafang Shao (1):
      mm/migrate: snapshot the source nid before the misplaced migration

Yehyeong Lee (1):
      9p/xen: validate the response size from the backend

Yifei Gao (1):
      9p/xen: fix refcount leak in p9_xen_response() on wrong tag

Yili Zhang (1):
      dma-buf: Fix IOVA offset when linking phys vecs to sgt

Yilin Zhang (1):
      mptcp: do not use Fast Open on MP_JOIN subflows

Yingjie Wang (4):
      scsi: bsg: Report synchronous data copyback failures
      scsi: bsg: Report io_uring data copyback failures
      ipv6: reject wrapped temporary address preferred lifetimes
      nvmet: reject keep-alive timeouts that would overflow

Yitang Yang (1):
      ublk: add missing DEL_DEV_ASYNC to unprivileged permission check

Yizhou Zhao (2):
      net/9p/usbg: fix prefix matching in device lookup
      net/9p/usbg: Fix use-after-free in disable_usb9pfs()

Yu Zhang (2):
      scsi: target: Fix demo-mode dynamic ACL dev-entry UAF vs LUN teardown
      ptp: fix use-after-free in extts_fifo_show() reading tsevqs unlocked

YuanZhe Liu (6):
      ALSA: us122l: Add missing NULL check in usb_stream_hwdep_mmap()
      ALSA: us122l: Fix NULL dereference at hwdep open and release
      ALSA: usx2y: Initialize idle URBs before submitting streams
      ALSA: hwdep: Serialize DSP load requests
      ALSA: bcd2000: Fix use-after-free of MIDI URBs on file close
      ALSA: usx2y: Refuse a retried DSP load after a failure

Yuanfu Xie (1):
      9p: don't decrement a server-owned zero nlink

Yuanhe Shu (1):
      scsi: target: Verify the iSCSI ISID is null-terminated

Yuansheng Yang (1):
      io_uring/rsrc: hold uring_lock across index-alloc put_user

Yuejie Shi (1):
      fs/ntfs3: validate the EA value length in ntfs_read_ea()

Yuho Choi (2):
      iommu/virtio: Reset device before deleting virtqueues on probe failure
      vdpa/snet: Don't discard the DPU error in snet_send_ctrl_msg()

Yuqiang Sun (2):
      nvme: Do not drop the cdev reference twice when cdev_device_add() fails
      ALSA: usb-audio: qcom: Check the return value of qmi_handle_init()

Zac Lanzon (1):
      hwmon: (asus_rog_ryujin) Fix pump control source on the Ryujin III

Zack Rusin (1):
      x86/vmware: Fix i386 high-bandwidth hypercall arguments

Zenghui Yu (Huawei) (1):
      mm/page_alloc: mark pages freed by __free_pages_core() as not tagged

Zhan Xusheng (1):
      ntfs: don't allow compression on volumes with clusters larger than 4K

Zhao Gongyi (2):
      arm64: mm: validate /dev/mem mmap ranges without overflow
      ata: libata-scsi: reject data-in commands with a data-out buffer

Zhao Zhang (1):
      9p: fix caches_show() out-of-bounds write

Zhe Liu (1):
      blk-iocost: account flush sequence latency only once

Zhou Qiuyue (1):
      ipv6: raw: fix use-after-free in rawv6_send_hdrinc()

Zijing Yin (1):
      wifi: cfg80211: fix out-of-bounds read in valid_rule()

chenglong.ma (1):
      vduse: fix VA/PA confusion in the coherent page fault path

guolingxing (2):
      btrfs: sysfs: restore NOFS context on early return in btrfs_sysfs_add_block_group_type()
      btrfs: prevent deleting the wrong subvolume by ID

renpanpan (1):
      drm/amdgpu: Only enable HDMI audio if display supports it

vladimir.oltean@nxp.com (1):
      PCI: cadence: Remove device links to PHY

