Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C465158A8;
	Thu, 15 Oct 2026 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060676; cv=none; b=bMmqIcE0D1qrcfuoU2wR3unCMx+sqg4UCawPXD3Q3n1RdWr+u1J3DAZQrx+C4gyC4QRS8dgzkDkMmqG52D+4TaZKz0enEhlEEbMh3iCjn299ShvEvCft6crsINH/J0WqKg3aDgMxOc1nUMtx/YbimZc5MtNtJci5Um7r5Qtm/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060676; c=relaxed/simple;
	bh=vCVRdBV4txeJyBe/iUYM+DtsQr3GndRiDBNBpMPS4qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PGdGsoxYYM4fcORhMU+5uHf3LQgmvLdT9Sz9t1CORfDyb551UI/hSFLpb6zJFGtTiX0obuEDjyk4wG4RXKOzV7V4C5mqbuNnU1cJwF4ubZFcz1O5s42d15Lg9kUCS0tMMM/x33rlL8/af7f4yhshaWfJ6IXpOuXvkyzOR+1jmLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Doy9+XwY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Doy9+XwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4411F000C5;
	Thu, 15 Oct 2026 10:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792060670;
	bh=754Rmk1VQsoFVgsazSMn3LDrtUKGIzVFUTW8om3SAck=;
	h=From:To:Cc:Subject:Date;
	b=Doy9+XwYKO3h4FRVXlVyT6U0ge0wOHqDzByXi8PpFOBG2VgUSKcbWC95RA53iuVaz
	 peqfaO8zdtw/2CvuRZ1bwV2xOb5q1yLIeVydLwCCBwnPRDtQ0iVu2KRD/m2aVXPrF7
	 5izvyff/nthXnPd7xZORQmX9u2symf6x7qETLEFY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.57
Date: Thu, 15 Oct 2026 12:37:48 +0200
Message-ID: <2026101549-starting-cahoots-2f45@gregkh>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.57 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/driver-api/driver-model/devres.rst                               |    4 
 Documentation/netlink/netlink-raw.yaml                                         |   11 
 Documentation/netlink/specs/conntrack.yaml                                     |    2 
 Documentation/netlink/specs/nftables.yaml                                      |    2 
 Documentation/networking/af_xdp.rst                                            |   54 
 Documentation/networking/strparser.rst                                         |    2 
 Makefile                                                                       |    2 
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi                                 |   19 
 arch/arm64/include/asm/el2_setup.h                                             |    5 
 arch/arm64/include/asm/kvm_host.h                                              |    2 
 arch/arm64/kernel/Makefile                                                     |    3 
 arch/arm64/kernel/ptrace.c                                                     |   50 
 arch/arm64/kvm/hyp/include/hyp/switch.h                                        |   16 
 arch/arm64/kvm/nested.c                                                        |    4 
 arch/arm64/kvm/sys_regs.c                                                      |   11 
 arch/arm64/kvm/vgic/vgic-its.c                                                 |   24 
 arch/arm64/kvm/vgic/vgic.c                                                     |   18 
 arch/loongarch/include/asm/kvm_host.h                                          |    8 
 arch/loongarch/include/asm/loongarch.h                                         |    2 
 arch/loongarch/kvm/intc/pch_pic.c                                              |    3 
 arch/loongarch/kvm/vm.c                                                        |   36 
 arch/loongarch/net/bpf_jit.c                                                   |    8 
 arch/powerpc/include/asm/book3s/64/pgtable.h                                   |   15 
 arch/powerpc/include/asm/xive.h                                                |    4 
 arch/powerpc/kernel/iommu.c                                                    |    5 
 arch/powerpc/mm/book3s64/pgtable.c                                             |   13 
 arch/powerpc/platforms/powernv/smp.c                                           |    8 
 arch/powerpc/platforms/pseries/papr-hvpipe.c                                   |   59 -
 arch/powerpc/platforms/pseries/smp.c                                           |    8 
 arch/powerpc/sysdev/xive/common.c                                              |   10 
 arch/riscv/Kconfig.errata                                                      |    1 
 arch/riscv/include/asm/futex.h                                                 |    2 
 arch/riscv/include/asm/scs.h                                                   |   17 
 arch/riscv/include/asm/vector.h                                                |    8 
 arch/riscv/include/uapi/asm/vendor/mips.h                                      |    4 
 arch/riscv/kernel/entry.S                                                      |    2 
 arch/riscv/kvm/vcpu_pmu.c                                                      |   28 
 arch/riscv/mm/extable.c                                                        |    4 
 arch/x86/include/asm/cpufeatures.h                                             |    4 
 arch/x86/include/asm/kvm-x86-ops.h                                             |    4 
 arch/x86/include/asm/kvm_host.h                                                |    6 
 arch/x86/include/asm/tlb.h                                                     |    6 
 arch/x86/kernel/cpu/amd.c                                                      |    4 
 arch/x86/kernel/uprobes.c                                                      |  292 +++-
 arch/x86/kvm/mmu/mmu.c                                                         |    5 
 arch/x86/kvm/svm/nested.c                                                      |   10 
 arch/x86/kvm/svm/sev.c                                                         |   80 +
 arch/x86/kvm/svm/svm.c                                                         |   13 
 arch/x86/kvm/svm/svm.h                                                         |    8 
 arch/x86/kvm/x86.c                                                             |    6 
 block/bfq-cgroup.c                                                             |    9 
 block/blk-cgroup.h                                                             |    2 
 block/blk-iocost.c                                                             |   21 
 block/blk-iolatency.c                                                          |   19 
 block/blk-throttle.c                                                           |   13 
 crypto/af_alg.c                                                                |    2 
 crypto/drbg.c                                                                  |   11 
 drivers/accel/amdxdna/Makefile                                                 |    1 
 drivers/accel/amdxdna/aie2_ctx.c                                               |   76 -
 drivers/accel/amdxdna/aie2_message.c                                           |   93 -
 drivers/accel/amdxdna/aie2_pci.c                                               |   88 -
 drivers/accel/amdxdna/aie2_pci.h                                               |    8 
 drivers/accel/amdxdna/aie2_pm.c                                                |   17 
 drivers/accel/amdxdna/aie2_smu.c                                               |   12 
 drivers/accel/amdxdna/amdxdna_ctx.c                                            |   94 +
 drivers/accel/amdxdna/amdxdna_ctx.h                                            |    3 
 drivers/accel/amdxdna/amdxdna_gem.c                                            |   97 +
 drivers/accel/amdxdna/amdxdna_gem.h                                            |    1 
 drivers/accel/amdxdna/amdxdna_mailbox.c                                        |   13 
 drivers/accel/amdxdna/amdxdna_pci_drv.c                                        |   56 
 drivers/accel/amdxdna/amdxdna_pci_drv.h                                        |    1 
 drivers/accel/amdxdna/amdxdna_pm.c                                             |   76 +
 drivers/accel/amdxdna/amdxdna_pm.h                                             |   18 
 drivers/accel/amdxdna/npu1_regs.c                                              |    1 
 drivers/accel/amdxdna/npu2_regs.c                                              |    1 
 drivers/accel/amdxdna/npu4_regs.c                                              |    1 
 drivers/accel/amdxdna/npu5_regs.c                                              |    1 
 drivers/accel/amdxdna/npu6_regs.c                                              |    1 
 drivers/acpi/bus.c                                                             |   54 
 drivers/acpi/button.c                                                          |  132 +-
 drivers/acpi/scan.c                                                            |   19 
 drivers/android/binder/node.rs                                                 |   20 
 drivers/android/binder/node/wrapper.rs                                         |   34 
 drivers/ata/libata-core.c                                                      |    7 
 drivers/ata/libata-scsi.c                                                      |   10 
 drivers/block/drbd/drbd_receiver.c                                             |    4 
 drivers/block/ublk_drv.c                                                       |  103 -
 drivers/block/zloop.c                                                          |   31 
 drivers/block/zram/zram_drv.c                                                  |    7 
 drivers/bluetooth/btintel_pcie.c                                               |   17 
 drivers/clocksource/samsung_pwm_timer.c                                        |   22 
 drivers/cxl/core/features.c                                                    |    3 
 drivers/cxl/core/mbox.c                                                        |    1 
 drivers/cxl/core/port.c                                                        |    2 
 drivers/cxl/core/region.c                                                      |   12 
 drivers/cxl/cxl.h                                                              |    4 
 drivers/dma/idxd/init.c                                                        |   36 
 drivers/dma/xilinx/xilinx_dma.c                                                |   14 
 drivers/dpll/dpll_core.c                                                       |   12 
 drivers/dpll/dpll_netlink.c                                                    |   68 +
 drivers/edac/amd64_edac.c                                                      |    4 
 drivers/firmware/arm_scmi/bus.c                                                |   93 -
 drivers/firmware/arm_scmi/driver.c                                             |    4 
 drivers/firmware/xilinx/zynqmp.c                                               |   68 -
 drivers/gpio/gpio-exar.c                                                       |    2 
 drivers/gpio/gpio-mpsse.c                                                      |   24 
 drivers/gpio/gpio-pca953x.c                                                    |   20 
 drivers/gpio/gpio-xilinx.c                                                     |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                                     |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                                    |   77 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                     |   25 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                                        |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c                                        |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                                        |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                        |   25 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c                                      |   13 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                                         |   13 
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c                                     |   91 -
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c                                          |   17 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                          |   32 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                                          |    7 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                              |    7 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h                              |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c                          |   25 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c                         |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c                         |   10 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h                         |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c                          |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c                        |   30 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c                       |    7 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                       |   35 
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c                          |   24 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c                        |   15 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c |   31 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c                        |   52 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h                        |    4 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c                         |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c                      |   18 
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h                      |    4 
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c                       |    4 
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h                             |   10 
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c                 |    8 
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c                                        |    5 
 drivers/gpu/drm/display/drm_dp_helper.c                                        |    4 
 drivers/gpu/drm/drm_fb_helper.c                                                |    6 
 drivers/gpu/drm/gud/gud_pipe.c                                                 |    1 
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c                                 |    2 
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c                           |   19 
 drivers/gpu/drm/i915/gt/intel_rps.c                                            |    3 
 drivers/gpu/drm/imagination/pvr_mmu.c                                          |   25 
 drivers/gpu/drm/imagination/pvr_vm.c                                           |    8 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                          |    5 
 drivers/gpu/drm/panthor/panthor_mmu.c                                          |    9 
 drivers/gpu/drm/panthor/panthor_sched.c                                        |   37 
 drivers/gpu/drm/ttm/ttm_bo.c                                                   |   16 
 drivers/gpu/drm/ttm/ttm_bo_util.c                                              |   11 
 drivers/gpu/drm/ttm/ttm_resource.c                                             |   13 
 drivers/gpu/drm/vc4/vc4_bo.c                                                   |    1 
 drivers/gpu/drm/vc4/vc4_drv.c                                                  |    5 
 drivers/gpu/drm/vc4/vc4_drv.h                                                  |    2 
 drivers/gpu/drm/vc4/vc4_gem.c                                                  |    8 
 drivers/gpu/drm/vc4/vc4_irq.c                                                  |    6 
 drivers/gpu/drm/vc4/vc4_v3d.c                                                  |   52 
 drivers/gpu/drm/vc4/vc4_validate.c                                             |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c                                   |   26 
 drivers/gpu/drm/xe/display/xe_fb_pin.c                                         |    6 
 drivers/gpu/drm/xe/xe_bo.c                                                     |  139 +-
 drivers/gpu/drm/xe/xe_bo.h                                                     |    2 
 drivers/gpu/drm/xe/xe_device.c                                                 |    2 
 drivers/gpu/drm/xe/xe_device_types.h                                           |    2 
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h                                   |    5 
 drivers/gpu/drm/xe/xe_guc_submit.c                                             |   74 -
 drivers/gpu/drm/xe/xe_guc_types.h                                              |    2 
 drivers/gpu/drm/xe/xe_migrate.c                                                |   17 
 drivers/gpu/drm/xe/xe_migrate.h                                                |    3 
 drivers/gpu/drm/xe/xe_mmio.c                                                   |    5 
 drivers/gpu/drm/xe/xe_module.c                                                 |   49 
 drivers/gpu/drm/xe/xe_module.h                                                 |    5 
 drivers/gpu/drm/xe/xe_pci.c                                                    |    6 
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.c                                           |   14 
 drivers/hid/hid-logitech-hidpp.c                                               |   23 
 drivers/hid/hid-steam.c                                                        |  246 +---
 drivers/hv/Makefile                                                            |    2 
 drivers/hv/mshv_regions.c                                                      |  177 +++
 drivers/hv/mshv_root.h                                                         |   10 
 drivers/hv/mshv_root_main.c                                                    |  225 ---
 drivers/hwtracing/coresight/coresight-etm4x-core.c                             |   51 
 drivers/i3c/master/mipi-i3c-hci/core.c                                         |   37 
 drivers/i3c/master/mipi-i3c-hci/dma.c                                          |   12 
 drivers/i3c/master/mipi-i3c-hci/hci.h                                          |    1 
 drivers/i3c/master/mipi-i3c-hci/ibi.h                                          |   13 
 drivers/i3c/master/mipi-i3c-hci/pio.c                                          |    7 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                       |    9 
 drivers/infiniband/hw/bnxt_re/qplib_sp.h                                       |    1 
 drivers/infiniband/hw/cxgb4/mem.c                                              |   46 
 drivers/infiniband/hw/erdma/erdma_cm.c                                         |    4 
 drivers/infiniband/sw/rdmavt/vt.c                                              |    4 
 drivers/infiniband/sw/siw/siw_cm.c                                             |    6 
 drivers/input/joystick/xpad.c                                                  |    4 
 drivers/input/misc/ati_remote2.c                                               |   12 
 drivers/iommu/amd/iommu.c                                                      |   11 
 drivers/iommu/apple-dart.c                                                     |    9 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c                            |    5 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                                    |   31 
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c                                 |   54 
 drivers/iommu/arm/arm-smmu/arm-smmu.c                                          |    9 
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                                        |   11 
 drivers/iommu/dma-iommu.c                                                      |    2 
 drivers/iommu/exynos-iommu.c                                                   |   11 
 drivers/iommu/fsl_pamu_domain.c                                                |   12 
 drivers/iommu/intel/iommu.c                                                    |   23 
 drivers/iommu/intel/nested.c                                                   |    2 
 drivers/iommu/iommu.c                                                          |   25 
 drivers/iommu/iommufd/selftest.c                                               |    2 
 drivers/iommu/ipmmu-vmsa.c                                                     |   10 
 drivers/iommu/msm_iommu.c                                                      |   11 
 drivers/iommu/mtk_iommu.c                                                      |    8 
 drivers/iommu/mtk_iommu_v1.c                                                   |    7 
 drivers/iommu/omap-iommu.c                                                     |   12 
 drivers/iommu/riscv/iommu.c                                                    |  109 +
 drivers/iommu/rockchip-iommu.c                                                 |   20 
 drivers/iommu/s390-iommu.c                                                     |   13 
 drivers/iommu/sprd-iommu.c                                                     |    3 
 drivers/iommu/sun50i-iommu.c                                                   |    8 
 drivers/iommu/tegra-smmu.c                                                     |   10 
 drivers/iommu/virtio-iommu.c                                                   |    6 
 drivers/irqchip/irq-gic-v5-irs.c                                               |   14 
 drivers/isdn/mISDN/l1oip_core.c                                                |    2 
 drivers/isdn/mISDN/socket.c                                                    |    4 
 drivers/md/dm-crypt.c                                                          |    7 
 drivers/md/dm-integrity.c                                                      |    4 
 drivers/md/dm-ioctl.c                                                          |   14 
 drivers/md/dm-pcache/cache.c                                                   |    4 
 drivers/md/dm-pcache/cache.h                                                   |   14 
 drivers/md/dm-pcache/cache_gc.c                                                |   16 
 drivers/md/dm-pcache/cache_key.c                                               |   11 
 drivers/md/dm-pcache/cache_writeback.c                                         |   20 
 drivers/md/dm-snap.c                                                           |   14 
 drivers/md/md-bitmap.c                                                         |    9 
 drivers/md/md-bitmap.h                                                         |    2 
 drivers/md/md-linear.c                                                         |    1 
 drivers/md/md-llbitmap.c                                                       |   10 
 drivers/md/md.c                                                                |   39 
 drivers/md/md.h                                                                |    5 
 drivers/md/raid0.c                                                             |    1 
 drivers/md/raid1-10.c                                                          |    8 
 drivers/md/raid1.c                                                             |  116 -
 drivers/md/raid10.c                                                            |  143 --
 drivers/md/raid5.c                                                             |   12 
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c                       |   19 
 drivers/media/platform/qcom/iris/iris_ctrls.c                                  |    2 
 drivers/media/platform/qcom/iris/iris_platform_common.h                        |    4 
 drivers/media/platform/qcom/iris/iris_platform_gen2.c                          |    4 
 drivers/media/platform/qcom/iris/iris_platform_qcs8300.h                       |    4 
 drivers/media/platform/qcom/iris/iris_platform_sm8250.c                        |    4 
 drivers/media/platform/qcom/iris/iris_vdec.c                                   |    6 
 drivers/media/platform/qcom/iris/iris_vdec.h                                   |    1 
 drivers/media/platform/qcom/iris/iris_venc.c                                   |    6 
 drivers/media/platform/qcom/iris/iris_venc.h                                   |    1 
 drivers/media/platform/qcom/iris/iris_vidc.c                                   |    6 
 drivers/media/platform/verisilicon/hantro.h                                    |    2 
 drivers/media/platform/verisilicon/hantro_drv.c                                |   42 
 drivers/media/platform/verisilicon/imx8m_vpu_hw.c                              |    8 
 drivers/media/v4l2-core/v4l2-mem2mem.c                                         |   23 
 drivers/memstick/core/memstick.c                                               |    8 
 drivers/memstick/host/rtsx_usb_ms.c                                            |   31 
 drivers/mmc/host/cavium-octeon.c                                               |    5 
 drivers/mmc/host/cavium-thunderx.c                                             |    5 
 drivers/mmc/host/mtk-sd.c                                                      |    1 
 drivers/mmc/host/sdhci-sprd.c                                                  |    4 
 drivers/net/amt.c                                                              |   48 
 drivers/net/can/dev/skb.c                                                      |    2 
 drivers/net/can/usb/f81604.c                                                   |    2 
 drivers/net/dsa/microchip/ksz_common.h                                         |    2 
 drivers/net/dsa/mt7530.c                                                       |   75 +
 drivers/net/dsa/mt7530.h                                                       |    8 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                      |  338 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                                      |   23 
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c                              |    8 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                              |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c                                  |  350 +++--
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c                             |   11 
 drivers/net/ethernet/cavium/liquidio/lio_main.c                                |   27 
 drivers/net/ethernet/cavium/liquidio/octeon_device.h                           |    3 
 drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c                          |   33 
 drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c                 |    4 
 drivers/net/ethernet/google/gve/gve_main.c                                     |    8 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c                                   |   13 
 drivers/net/ethernet/ibm/ibmveth.c                                             |   22 
 drivers/net/ethernet/intel/ice/devlink/port.c                                  |    2 
 drivers/net/ethernet/intel/ice/ice.h                                           |    4 
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c                                   |    2 
 drivers/net/ethernet/intel/ice/ice_eswitch.c                                   |    2 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                                   |    1 
 drivers/net/ethernet/intel/ice/ice_lib.c                                       |    4 
 drivers/net/ethernet/intel/ice/ice_txrx.c                                      |   33 
 drivers/net/ethernet/intel/ice/ice_txrx.h                                      |   61 -
 drivers/net/ethernet/intel/idpf/idpf_dev.c                                     |    2 
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c                                  |    2 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                                |   12 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h                                |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                                  |    3 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                                |   12 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h                                |    1 
 drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h                          |    1 
 drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c                    |   21 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                                |   39 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                                |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c                            |   79 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                            |   22 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                            |   29 
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c                            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                                |   13 
 drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c                        |   20 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                              |    2 
 drivers/net/ethernet/mellanox/mlx5/core/vport.c                                |   24 
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h                                 |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c                             |   10 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c                          |    9 
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c                             |   28 
 drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c                     |    1 
 drivers/net/ethernet/microsoft/mana/gdma_main.c                                |   19 
 drivers/net/ethernet/microsoft/mana/mana_en.c                                  |    7 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                              |   67 -
 drivers/net/ethernet/ti/icssg/icssg_common.c                                   |   86 -
 drivers/net/ethernet/ti/icssg/icssg_prueth.c                                   |  184 ++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h                                   |   17 
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c                               |    4 
 drivers/net/ovpn/crypto.c                                                      |   10 
 drivers/net/ovpn/crypto.h                                                      |    4 
 drivers/net/ovpn/crypto_aead.c                                                 |   19 
 drivers/net/ovpn/crypto_aead.h                                                 |    1 
 drivers/net/pfcp.c                                                             |    7 
 drivers/net/ppp/pptp.c                                                         |    4 
 drivers/net/team/team_core.c                                                   |   16 
 drivers/net/team/team_mode_broadcast.c                                         |    2 
 drivers/net/usb/ax88179_178a.c                                                 |    6 
 drivers/net/veth.c                                                             |    1 
 drivers/net/virtio_net.c                                                       |   14 
 drivers/net/vxlan/vxlan_core.c                                                 |   20 
 drivers/net/wan/hdlc_ppp.c                                                     |    4 
 drivers/net/wireguard/noise.c                                                  |    7 
 drivers/net/wireguard/queueing.h                                               |    2 
 drivers/net/wireless/ath/ath12k/core.c                                         |   33 
 drivers/net/wireless/ath/ath12k/core.h                                         |    3 
 drivers/net/wireless/ath/ath12k/dp_rx.c                                        |    4 
 drivers/net/wireless/ath/ath12k/hif.h                                          |    9 
 drivers/net/wireless/ath/ath12k/mac.c                                          |    7 
 drivers/net/wireless/ath/ath12k/pci.c                                          |    8 
 drivers/net/wireless/ath/ath12k/wmi.c                                          |   16 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c                        |   27 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c                         |    4 
 drivers/net/wireless/marvell/libertas/tx.c                                     |    7 
 drivers/net/wireless/mediatek/mt76/channel.c                                   |   92 -
 drivers/net/wireless/mediatek/mt76/mt76.h                                      |   10 
 drivers/net/wireless/mediatek/mt76/mt7603/init.c                               |    1 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h                           |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                               |    8 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                               |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                               |    3 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                                |    3 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                               |   48 
 drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c                           |  128 +-
 drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h                           |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                               |    4 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                                |    3 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                               |    1 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                                |    3 
 drivers/net/wireless/mediatek/mt76/tx.c                                        |  101 +
 drivers/net/xen-netfront.c                                                     |    4 
 drivers/ntb/ntb_transport.c                                                    |   18 
 drivers/nvme/host/pci.c                                                        |   28 
 drivers/nvme/host/tcp.c                                                        |    2 
 drivers/nvme/target/admin-cmd.c                                                |   12 
 drivers/nvme/target/core.c                                                     |   51 
 drivers/nvme/target/fabrics-cmd.c                                              |    2 
 drivers/nvme/target/nvmet.h                                                    |    6 
 drivers/nvme/target/pci-epf.c                                                  |    2 
 drivers/nvme/target/pr.c                                                       |    4 
 drivers/nvme/target/tcp.c                                                      |    2 
 drivers/pci/endpoint/functions/pci-epf-mhi.c                                   |    2 
 drivers/pci/endpoint/functions/pci-epf-ntb.c                                   |    9 
 drivers/pci/endpoint/functions/pci-epf-test.c                                  |    2 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                                  |    9 
 drivers/pci/hotplug/pnv_php.c                                                  |    2 
 drivers/pci/hotplug/shpchp_core.c                                              |    3 
 drivers/pci/pci-driver.c                                                       |  194 +--
 drivers/pci/pci-sysfs.c                                                        |   15 
 drivers/pci/pci.h                                                              |   41 
 drivers/pci/search.c                                                           |    8 
 drivers/pinctrl/mediatek/pinctrl-moore.c                                       |    6 
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c                                  |   14 
 drivers/pinctrl/mediatek/pinctrl-paris.c                                       |    2 
 drivers/pinctrl/pinctrl-zynqmp.c                                               |    7 
 drivers/platform/x86/asus-wmi.c                                                |    6 
 drivers/platform/x86/dell/dell-wmi-base.c                                      |    2 
 drivers/pmdomain/imx/imx8m-blk-ctrl.c                                          |   15 
 drivers/pmdomain/rockchip/pm-domains.c                                         |   20 
 drivers/power/supply/max77705_charger.c                                        |   30 
 drivers/ptp/ptp_ocp.c                                                          |   38 
 drivers/pwm/pwm-samsung.c                                                      |   22 
 drivers/regulator/ltc3676.c                                                    |   15 
 drivers/regulator/of_regulator.c                                               |   26 
 drivers/regulator/tps6594-regulator.c                                          |    6 
 drivers/remoteproc/qcom_wcnss.c                                                |   23 
 drivers/s390/crypto/zcrypt_api.c                                               |   38 
 drivers/s390/crypto/zcrypt_msgtype6.c                                          |  433 +++++--
 drivers/s390/crypto/zcrypt_msgtype6.h                                          |   51 
 drivers/scsi/qedi/qedi_main.c                                                  |    3 
 drivers/scsi/qla2xxx/qla_iocb.c                                                |    2 
 drivers/scsi/scsi_error.c                                                      |    6 
 drivers/scsi/sd.c                                                              |  141 +-
 drivers/soc/aspeed/aspeed-lpc-snoop.c                                          |   29 
 drivers/soc/tegra/pmc.c                                                        |  104 +
 drivers/soc/xilinx/xlnx_event_manager.c                                        |    8 
 drivers/soc/xilinx/zynqmp_power.c                                              |   53 
 drivers/spi/spi-sg2044-nor.c                                                   |   56 
 drivers/staging/greybus/raw.c                                                  |   67 -
 drivers/target/iscsi/iscsi_target_login.c                                      |    2 
 drivers/tee/optee/ffa_abi.c                                                    |   41 
 drivers/tee/optee/optee_msg.h                                                  |   50 
 drivers/tee/optee/optee_private.h                                              |  120 +-
 drivers/tee/optee/smc_abi.c                                                    |   17 
 drivers/tee/tee_shm.c                                                          |    4 
 drivers/thermal/thermal_hwmon.c                                                |   87 -
 drivers/tty/serial/serial_core.c                                               |   33 
 drivers/tty/tty_io.c                                                           |    2 
 drivers/ufs/core/ufshcd-priv.h                                                 |   14 
 drivers/ufs/core/ufshcd.c                                                      |   36 
 drivers/usb/gadget/function/f_uac1.c                                           |   13 
 drivers/usb/gadget/function/f_uac2.c                                           |   13 
 drivers/vdpa/mlx5/core/mlx5_vdpa.h                                             |    2 
 drivers/vdpa/mlx5/core/mr.c                                                    |    5 
 drivers/vdpa/mlx5/core/resources.c                                             |   11 
 drivers/vdpa/vdpa_sim/vdpa_sim.c                                               |   14 
 drivers/vdpa/vdpa_user/iova_domain.c                                           |   11 
 drivers/vdpa/vdpa_user/vduse_dev.c                                             |    4 
 drivers/vhost/iotlb.c                                                          |   47 
 drivers/vhost/net.c                                                            |    2 
 drivers/vhost/vdpa.c                                                           |    9 
 drivers/vhost/vhost.c                                                          |   65 +
 drivers/vhost/vhost.h                                                          |    1 
 drivers/vhost/vsock.c                                                          |    2 
 drivers/video/fbdev/core/fb_chrdev.c                                           |    6 
 drivers/video/fbdev/core/fbcon.c                                               |    2 
 drivers/video/fbdev/core/fbmem.c                                               |   13 
 drivers/video/fbdev/core/fbsysfs.c                                             |    4 
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c                                 |   11 
 drivers/video/fbdev/ps3fb.c                                                    |    5 
 drivers/video/fbdev/sh_mobile_lcdcfb.c                                         |    5 
 drivers/virtio/virtio_ring.c                                                   |   19 
 drivers/xen/pvcalls-back.c                                                     |    2 
 drivers/xen/pvcalls-front.c                                                    |   88 +
 fs/afs/Makefile                                                                |    1 
 fs/afs/dir.c                                                                   |   68 -
 fs/afs/fsclient.c                                                              |    4 
 fs/afs/inode.c                                                                 |   96 -
 fs/afs/internal.h                                                              |   34 
 fs/afs/rxrpc.c                                                                 |    6 
 fs/afs/symlink.c                                                               |  278 ++++
 fs/afs/validation.c                                                            |   14 
 fs/afs/yfsclient.c                                                             |    4 
 fs/btrfs/acl.c                                                                 |   29 
 fs/btrfs/bio.c                                                                 |    8 
 fs/btrfs/block-group.c                                                         |    2 
 fs/btrfs/block-rsv.c                                                           |   19 
 fs/btrfs/delayed-inode.c                                                       |   15 
 fs/btrfs/disk-io.c                                                             |   82 +
 fs/btrfs/extent-tree.c                                                         |   52 
 fs/btrfs/extent-tree.h                                                         |    3 
 fs/btrfs/extent_io.c                                                           |  162 ++
 fs/btrfs/extent_io.h                                                           |    6 
 fs/btrfs/fs.h                                                                  |   27 
 fs/btrfs/inode.c                                                               |    7 
 fs/btrfs/ioctl.c                                                               |   50 
 fs/btrfs/lzo.c                                                                 |   14 
 fs/btrfs/qgroup.c                                                              |    3 
 fs/btrfs/raid-stripe-tree.c                                                    |   14 
 fs/btrfs/reflink.c                                                             |    7 
 fs/btrfs/relocation.c                                                          |   34 
 fs/btrfs/scrub.c                                                               |    4 
 fs/btrfs/send.c                                                                |   50 
 fs/btrfs/super.c                                                               |    3 
 fs/btrfs/tests/extent-io-tests.c                                               |    3 
 fs/btrfs/tests/extent-map-tests.c                                              |    6 
 fs/btrfs/tree-log.c                                                            |   43 
 fs/btrfs/volumes.c                                                             |   28 
 fs/btrfs/xattr.c                                                               |   15 
 fs/btrfs/zoned.c                                                               |    3 
 fs/cachefiles/namei.c                                                          |    7 
 fs/ceph/addr.c                                                                 |    2 
 fs/ceph/mds_client.c                                                           |    6 
 fs/dcache.c                                                                    |    4 
 fs/dlm/lowcomms.c                                                              |    6 
 fs/erofs/xattr.c                                                               |    6 
 fs/ext2/inode.c                                                                |    3 
 fs/ext2/xattr.c                                                                |    4 
 fs/ext4/ext4.h                                                                 |    3 
 fs/ext4/inode.c                                                                |   35 
 fs/ext4/ioctl.c                                                                |   11 
 fs/ext4/move_extent.c                                                          |  102 +
 fs/ext4/xattr.c                                                                |    2 
 fs/f2fs/data.c                                                                 |   27 
 fs/f2fs/f2fs.h                                                                 |    2 
 fs/f2fs/gc.c                                                                   |   36 
 fs/f2fs/node.c                                                                 |    2 
 fs/f2fs/segment.c                                                              |    4 
 fs/fcntl.c                                                                     |    3 
 fs/fsopen.c                                                                    |    3 
 fs/fuse/dev_uring.c                                                            |   30 
 fs/fuse/inode.c                                                                |    4 
 fs/gfs2/aops.c                                                                 |    2 
 fs/gfs2/file.c                                                                 |    2 
 fs/gfs2/glock.c                                                                |   10 
 fs/gfs2/glock.h                                                                |    2 
 fs/gfs2/glops.c                                                                |   13 
 fs/gfs2/incore.h                                                               |    2 
 fs/gfs2/lock_dlm.c                                                             |   22 
 fs/gfs2/log.c                                                                  |   43 
 fs/gfs2/lops.c                                                                 |    2 
 fs/gfs2/meta_io.c                                                              |    6 
 fs/gfs2/ops_fstype.c                                                           |    8 
 fs/gfs2/quota.c                                                                |   66 -
 fs/gfs2/recovery.c                                                             |    2 
 fs/gfs2/super.c                                                                |   14 
 fs/gfs2/sys.c                                                                  |   34 
 fs/gfs2/trans.c                                                                |    2 
 fs/gfs2/util.c                                                                 |   74 -
 fs/gfs2/util.h                                                                 |   43 
 fs/hfs/dir.c                                                                   |   15 
 fs/hfs/hfs_fs.h                                                                |    1 
 fs/hfs/inode.c                                                                 |   30 
 fs/hfs/mdb.c                                                                   |   31 
 fs/hfs/super.c                                                                 |    3 
 fs/inode.c                                                                     |   23 
 fs/iomap/direct-io.c                                                           |    1 
 fs/lockd/svc.c                                                                 |    4 
 fs/lockd/svc4proc.c                                                            |    4 
 fs/lockd/svcproc.c                                                             |    4 
 fs/lockd/svcsubs.c                                                             |   52 
 fs/mount.h                                                                     |    6 
 fs/namei.c                                                                     |   29 
 fs/namespace.c                                                                 |  232 ++-
 fs/netfs/buffered_read.c                                                       |    9 
 fs/netfs/internal.h                                                            |    1 
 fs/netfs/main.c                                                                |    7 
 fs/netfs/misc.c                                                                |    3 
 fs/netfs/objects.c                                                             |   30 
 fs/netfs/read_collect.c                                                        |   35 
 fs/netfs/read_pgpriv2.c                                                        |    2 
 fs/netfs/rolling_buffer.c                                                      |   22 
 fs/netfs/write_collect.c                                                       |    6 
 fs/netfs/write_issue.c                                                         |   13 
 fs/nfs/callback_xdr.c                                                          |    6 
 fs/nfs/delegation.c                                                            |   18 
 fs/nfsd/lockd.c                                                                |    6 
 fs/nfsd/netns.h                                                                |   20 
 fs/nfsd/nfs4proc.c                                                             |    2 
 fs/nfsd/nfs4recover.c                                                          |   12 
 fs/nfsd/nfs4state.c                                                            |   60 -
 fs/nfsd/nfsctl.c                                                               |    4 
 fs/nfsd/nfssvc.c                                                               |   45 
 fs/ntfs3/dir.c                                                                 |    3 
 fs/ntfs3/file.c                                                                |    6 
 fs/ntfs3/frecord.c                                                             |    7 
 fs/ntfs3/inode.c                                                               |   19 
 fs/ntfs3/namei.c                                                               |    6 
 fs/ntfs3/ntfs_fs.h                                                             |    6 
 fs/ntfs3/super.c                                                               |   31 
 fs/ocfs2/cluster/heartbeat.c                                                   |  139 +-
 fs/ocfs2/cluster/tcp.c                                                         |  107 +
 fs/ocfs2/cluster/tcp.h                                                         |    1 
 fs/ocfs2/inode.c                                                               |   23 
 fs/pnode.c                                                                     |  108 +
 fs/resctrl/monitor.c                                                           |   60 -
 fs/resctrl/rdtgroup.c                                                          |   48 
 fs/smb/client/cifsacl.c                                                        |   28 
 fs/smb/client/cifsfs.c                                                         |    1 
 fs/smb/client/cifsglob.h                                                       |    1 
 fs/smb/client/connect.c                                                        |    2 
 fs/smb/client/file.c                                                           |   65 +
 fs/smb/client/inode.c                                                          |   24 
 fs/smb/client/misc.c                                                           |   35 
 fs/smb/client/readdir.c                                                        |   17 
 fs/smb/server/connection.c                                                     |   37 
 fs/smb/server/connection.h                                                     |    6 
 fs/smb/server/mgmt/tree_connect.c                                              |   33 
 fs/smb/server/mgmt/user_config.c                                               |   11 
 fs/smb/server/mgmt/user_session.c                                              |   10 
 fs/smb/server/mgmt/user_session.h                                              |    2 
 fs/smb/server/oplock.c                                                         |   81 +
 fs/smb/server/oplock.h                                                         |    1 
 fs/smb/server/smb2pdu.c                                                        |  106 +
 fs/smb/server/smbacl.c                                                         |   86 -
 fs/smb/server/smbacl.h                                                         |    2 
 fs/smb/server/transport_tcp.c                                                  |    4 
 fs/smb/server/vfs.c                                                            |    2 
 fs/smb/server/vfs_cache.c                                                      |    8 
 fs/tracefs/event_inode.c                                                       |   24 
 fs/tracefs/internal.h                                                          |    4 
 fs/udf/super.c                                                                 |    4 
 fs/xfs/libxfs/xfs_exchmaps.c                                                   |  103 -
 fs/xfs/libxfs/xfs_log_format.h                                                 |    4 
 fs/xfs/xfs_bmap_util.c                                                         |   15 
 fs/xfs/xfs_exchrange.c                                                         |   51 
 include/acpi/acpi_bus.h                                                        |    6 
 include/clocksource/samsung_pwm.h                                              |    2 
 include/cxl/mailbox.h                                                          |    2 
 include/drm/ttm/ttm_resource.h                                                 |    2 
 include/kvm/arm_vgic.h                                                         |    3 
 include/linux/bnxt/ulp.h                                                       |   25 
 include/linux/bpf.h                                                            |    5 
 include/linux/bpf_verifier.h                                                   |    2 
 include/linux/can/skb.h                                                        |    2 
 include/linux/compiler_types.h                                                 |    8 
 include/linux/fb.h                                                             |    2 
 include/linux/firmware/xlnx-zynqmp.h                                           |   18 
 include/linux/ieee80211-s1g.h                                                  |  575 +++++++++
 include/linux/ieee80211.h                                                      |  585 ----------
 include/linux/iommu.h                                                          |    3 
 include/linux/irq_work.h                                                       |    9 
 include/linux/irq_work_types.h                                                 |   14 
 include/linux/kvm_host.h                                                       |    1 
 include/linux/list.h                                                           |   37 
 include/linux/lockd/bind.h                                                     |   12 
 include/linux/mempool.h                                                        |    7 
 include/linux/mount.h                                                          |    2 
 include/linux/net.h                                                            |    4 
 include/linux/netfilter/x_tables.h                                             |    1 
 include/linux/netfs.h                                                          |    1 
 include/linux/ntb.h                                                            |   24 
 include/linux/nvme.h                                                           |    4 
 include/linux/pci.h                                                            |    1 
 include/linux/ring_buffer.h                                                    |    5 
 include/linux/rolling_buffer.h                                                 |    6 
 include/linux/sched/ext.h                                                      |    1 
 include/linux/skbuff.h                                                         |    2 
 include/linux/socket.h                                                         |   17 
 include/linux/srcutiny.h                                                       |    4 
 include/linux/static_call_types.h                                              |    4 
 include/linux/sunrpc/svc_rdma.h                                                |   14 
 include/linux/workqueue.h                                                      |   24 
 include/media/v4l2-mem2mem.h                                                   |   21 
 include/net/amt.h                                                              |    4 
 include/net/bluetooth/hci_core.h                                               |    2 
 include/net/cfg80211.h                                                         |    3 
 include/net/inet_common.h                                                      |    2 
 include/net/ip.h                                                               |    7 
 include/net/ip_vs.h                                                            |    2 
 include/net/ipv6.h                                                             |    2 
 include/net/mac80211.h                                                         |   14 
 include/net/netfilter/nf_dup_netdev.h                                          |   37 
 include/net/netfilter/nf_tables.h                                              |   15 
 include/net/pkt_cls.h                                                          |   14 
 include/net/sock.h                                                             |    2 
 include/net/strparser.h                                                        |   10 
 include/net/xsk_buff_pool.h                                                    |    9 
 include/scsi/scsi_host.h                                                       |    7 
 include/ufs/ufshcd.h                                                           |    4 
 kernel/bpf/bpf_struct_ops.c                                                    |   12 
 kernel/bpf/btf.c                                                               |   17 
 kernel/bpf/stackmap.c                                                          |  120 +-
 kernel/bpf/syscall.c                                                           |    2 
 kernel/bpf/trampoline.c                                                        |    7 
 kernel/bpf/verifier.c                                                          |  213 ++-
 kernel/cgroup/cpuset.c                                                         |   29 
 kernel/dma/swiotlb.c                                                           |    6 
 kernel/kexec_handover.c                                                        |    2 
 kernel/printk/nbcon.c                                                          |    2 
 kernel/printk/printk.c                                                         |    2 
 kernel/rcu/srcutiny.c                                                          |   19 
 kernel/sched/ext.c                                                             |   15 
 kernel/sched/ext_internal.h                                                    |    5 
 kernel/sched/sched.h                                                           |    1 
 kernel/trace/blktrace.c                                                        |    4 
 kernel/trace/ring_buffer.c                                                     |  260 ++--
 kernel/trace/ring_buffer_benchmark.c                                           |    6 
 kernel/trace/trace.c                                                           |  154 +-
 kernel/trace/trace.h                                                           |    1 
 kernel/workqueue.c                                                             |   47 
 mm/pgtable-generic.c                                                           |   20 
 net/9p/trans_fd.c                                                              |    2 
 net/appletalk/ddp.c                                                            |    2 
 net/atm/pvc.c                                                                  |    4 
 net/atm/svc.c                                                                  |    2 
 net/ax25/af_ax25.c                                                             |    2 
 net/bluetooth/6lowpan.c                                                        |   27 
 net/bluetooth/hci_conn.c                                                       |   17 
 net/bluetooth/hci_core.c                                                       |    4 
 net/bluetooth/hci_event.c                                                      |  108 -
 net/bluetooth/hci_sock.c                                                       |    4 
 net/bluetooth/hci_sync.c                                                       |  103 +
 net/bluetooth/iso.c                                                            |   56 
 net/bluetooth/l2cap_sock.c                                                     |   59 -
 net/bluetooth/mgmt.c                                                           |    2 
 net/bluetooth/rfcomm/core.c                                                    |    4 
 net/bluetooth/rfcomm/sock.c                                                    |    7 
 net/bluetooth/rfcomm/tty.c                                                     |    2 
 net/bluetooth/sco.c                                                            |   89 +
 net/bridge/br_arp_nd_proxy.c                                                   |   24 
 net/bridge/br_multicast.c                                                      |   23 
 net/bridge/netfilter/nf_conntrack_bridge.c                                     |   10 
 net/can/af_can.c                                                               |    6 
 net/can/bcm.c                                                                  |    2 
 net/can/isotp.c                                                                |   13 
 net/can/j1939/socket.c                                                         |    3 
 net/can/j1939/transport.c                                                      |    2 
 net/can/raw.c                                                                  |    9 
 net/ceph/auth_x.c                                                              |    5 
 net/core/bpf_sk_storage.c                                                      |   14 
 net/core/dev.c                                                                 |   59 -
 net/core/filter.c                                                              |    4 
 net/core/flow_dissector.c                                                      |   11 
 net/core/skbuff.c                                                              |    6 
 net/core/sock.c                                                                |    5 
 net/devlink/core.c                                                             |   10 
 net/hsr/hsr_framereg.c                                                         |    6 
 net/ieee802154/socket.c                                                        |    4 
 net/ipv4/af_inet.c                                                             |    4 
 net/ipv4/cipso_ipv4.c                                                          |    8 
 net/ipv4/esp4.c                                                                |    7 
 net/ipv4/fib_semantics.c                                                       |    3 
 net/ipv4/fib_trie.c                                                            |    2 
 net/ipv4/ip_output.c                                                           |   10 
 net/ipv4/netfilter/arp_tables.c                                                |   35 
 net/ipv4/netfilter/ip_tables.c                                                 |   41 
 net/ipv4/nexthop.c                                                             |   22 
 net/ipv4/route.c                                                               |    5 
 net/ipv4/tcp.c                                                                 |    2 
 net/ipv4/udp_tunnel_core.c                                                     |    2 
 net/ipv6/af_inet6.c                                                            |    4 
 net/ipv6/esp6.c                                                                |    7 
 net/ipv6/ip6_udp_tunnel.c                                                      |    2 
 net/ipv6/ip6mr.c                                                               |    3 
 net/ipv6/mcast.c                                                               |   31 
 net/ipv6/netfilter/ip6_tables.c                                                |   38 
 net/ipv6/route.c                                                               |    4 
 net/iucv/af_iucv.c                                                             |    2 
 net/l2tp/l2tp_core.c                                                           |    4 
 net/llc/af_llc.c                                                               |    2 
 net/mac80211/debugfs.c                                                         |   13 
 net/mac80211/ieee80211_i.h                                                     |    2 
 net/mac80211/main.c                                                            |    1 
 net/mac80211/rx.c                                                              |   50 
 net/mac80211/sta_info.c                                                        |   17 
 net/mac80211/sta_info.h                                                        |    3 
 net/mac80211/status.c                                                          |    5 
 net/mac80211/tx.c                                                              |   70 -
 net/mac80211/util.c                                                            |    3 
 net/mctp/af_mctp.c                                                             |    2 
 net/mctp/test/route-test.c                                                     |    2 
 net/mctp/test/utils.c                                                          |    2 
 net/mptcp/protocol.c                                                           |    6 
 net/mptcp/subflow.c                                                            |    2 
 net/netfilter/ipvs/ip_vs_core.c                                                |   11 
 net/netfilter/ipvs/ip_vs_sync.c                                                |    4 
 net/netfilter/ipvs/ip_vs_xmit.c                                                |    3 
 net/netfilter/nf_conntrack_bpf.c                                               |  113 +
 net/netfilter/nf_dup_netdev.c                                                  |   31 
 net/netfilter/nf_flow_table_path.c                                             |    3 
 net/netfilter/nf_tables_api.c                                                  |  320 +++--
 net/netfilter/nfnetlink_queue.c                                                |    7 
 net/netfilter/nft_dynset.c                                                     |   25 
 net/netfilter/nft_fwd_netdev.c                                                 |   27 
 net/netfilter/x_tables.c                                                       |   77 +
 net/netfilter/xt_CHECKSUM.c                                                    |    6 
 net/netlink/af_netlink.c                                                       |    2 
 net/netrom/af_netrom.c                                                         |    2 
 net/nfc/llcp_sock.c                                                            |    4 
 net/openvswitch/actions.c                                                      |    7 
 net/openvswitch/datapath.c                                                     |    8 
 net/packet/af_packet.c                                                         |   14 
 net/phonet/socket.c                                                            |   18 
 net/qrtr/af_qrtr.c                                                             |    2 
 net/qrtr/ns.c                                                                  |    2 
 net/rds/bind.c                                                                 |    2 
 net/rds/rds.h                                                                  |    2 
 net/rds/tcp_connect.c                                                          |    2 
 net/rds/tcp_listen.c                                                           |    2 
 net/rose/af_rose.c                                                             |    2 
 net/rxrpc/af_rxrpc.c                                                           |    2 
 net/rxrpc/rxperf.c                                                             |    2 
 net/sched/cls_api.c                                                            |    6 
 net/sched/cls_basic.c                                                          |    6 
 net/sched/cls_bpf.c                                                            |    6 
 net/sched/cls_cgroup.c                                                         |    2 
 net/sched/cls_flow.c                                                           |    2 
 net/sched/cls_flower.c                                                         |    4 
 net/sched/cls_fw.c                                                             |    4 
 net/sched/cls_matchall.c                                                       |    4 
 net/sched/cls_route.c                                                          |   10 
 net/sched/cls_u32.c                                                            |   18 
 net/sched/em_text.c                                                            |    3 
 net/sched/sch_cake.c                                                           |    2 
 net/sched/sch_drr.c                                                            |    2 
 net/sched/sch_dualpi2.c                                                        |    2 
 net/sched/sch_ets.c                                                            |    2 
 net/sched/sch_fq_codel.c                                                       |    2 
 net/sched/sch_fq_pie.c                                                         |    2 
 net/sched/sch_hfsc.c                                                           |    2 
 net/sched/sch_htb.c                                                            |    2 
 net/sched/sch_multiq.c                                                         |    2 
 net/sched/sch_netem.c                                                          |    7 
 net/sched/sch_prio.c                                                           |    2 
 net/sched/sch_qfq.c                                                            |    2 
 net/sched/sch_sfb.c                                                            |    2 
 net/sched/sch_sfq.c                                                            |    2 
 net/sctp/socket.c                                                              |    6 
 net/smc/af_smc.c                                                               |  100 -
 net/smc/smc.h                                                                  |    2 
 net/socket.c                                                                   |    6 
 net/strparser/strparser.c                                                      |    6 
 net/sunrpc/Kconfig                                                             |    1 
 net/sunrpc/auth_gss/gss_krb5_crypto.c                                          |  232 +++
 net/sunrpc/auth_gss/gss_krb5_internal.h                                        |   20 
 net/sunrpc/auth_gss/gss_krb5_mech.c                                            |   96 +
 net/sunrpc/auth_gss/gss_krb5_seal.c                                            |   45 
 net/sunrpc/auth_gss/gss_krb5_unseal.c                                          |   39 
 net/sunrpc/clnt.c                                                              |    4 
 net/sunrpc/svcsock.c                                                           |    2 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                                        |    4 
 net/sunrpc/xprtrdma/svc_rdma_rw.c                                              |  100 +
 net/sunrpc/xprtrdma/svc_rdma_sendto.c                                          |   16 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                                       |   32 
 net/sunrpc/xprtsock.c                                                          |    4 
 net/tipc/core.c                                                                |    4 
 net/tipc/node.c                                                                |   10 
 net/tipc/socket.c                                                              |    4 
 net/tipc/topsrv.c                                                              |   80 +
 net/tipc/udp_media.c                                                           |   75 -
 net/unix/af_unix.c                                                             |    4 
 net/vmw_vsock/af_vsock.c                                                       |    6 
 net/vmw_vsock/virtio_transport_common.c                                        |    4 
 net/wireless/core.c                                                            |    7 
 net/wireless/core.h                                                            |    2 
 net/wireless/nl80211.c                                                         |   19 
 net/wireless/sme.c                                                             |    6 
 net/x25/af_x25.c                                                               |    2 
 net/xdp/xsk.c                                                                  |  199 ++-
 net/xdp/xsk_buff_pool.c                                                        |   13 
 net/xdp/xsk_queue.h                                                            |   65 -
 net/xfrm/xfrm_output.c                                                         |   16 
 security/keys/key.c                                                            |    6 
 security/keys/persistent.c                                                     |   55 
 security/selinux/avc.c                                                         |    5 
 security/selinux/hooks.c                                                       |    9 
 sound/hda/codecs/side-codecs/tas2781_hda.c                                     |   18 
 sound/pci/ctxfi/ctatc.c                                                        |   63 -
 sound/pci/ctxfi/ctatc.h                                                        |    4 
 sound/pci/ctxfi/ctdaio.c                                                       |  101 +
 sound/pci/ctxfi/ctdaio.h                                                       |    2 
 sound/pci/ctxfi/cthardware.h                                                   |    2 
 sound/pci/ctxfi/cthw20k1.c                                                     |    2 
 sound/pci/ctxfi/cthw20k2.c                                                     |    2 
 sound/soc/amd/acp/acp-mach-common.c                                            |   18 
 sound/soc/amd/yc/acp6x-mach.c                                                  |    7 
 sound/soc/codecs/adau1372.c                                                    |   18 
 sound/soc/qcom/qdsp6/q6asm.c                                                   |    5 
 sound/soc/samsung/i2s.c                                                        |    8 
 tools/include/linux/static_call_types.h                                        |    4 
 tools/testing/selftests/bpf/progs/verifier_subprog_precision.c                 |   12 
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c                           |    2 
 virt/kvm/guest_memfd.c                                                         |   12 
 virt/kvm/kvm_mm.h                                                              |    7 
 864 files changed, 13295 insertions(+), 7221 deletions(-)

Aaron Ma (1):
      wifi: mt76: mt7925: restore the legacy BSS after MLO teardown

Abd-Alrhman Masalkhi (7):
      md/raid10: fix writes_pending leak on write request failures
      md/raid1: fix writes_pending and barrier reference leaks on write failures
      md: replace wait loop with wait_event() in md_handle_request()
      md/raid1,raid10: fix deadlock in read error recovery path
      md/raid1,raid10: fix bio accounting for split md cloned bios
      md/raid1,raid10: fix error-path detection with md_cloned_bio()
      md: remove REQ_NOWAIT support from raid1/10/456

Abhishek Ojha (1):
      regulator: ltc3676: don't read the write-only HRST and CLIRQ registers

Aditya Prakash Srivastava (1):
      ext4: fix ABBA deadlock in ext4_xattr_inode_cache_find()

Adrian Betschart (1):
      drm/amd/display: Don't replace a sink mode that shares the native totals

Adrian Hunter (1):
      i3c: mipi-i3c-hci: Fix race in i3c_hci_addr_to_dev()

Adrián Larumbe (1):
      drm/panthor: Add vm_bind region with kbo range overlap check

Alan Previn (1):
      drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep maximums

Aldo Ariel Panzardo (1):
      Bluetooth: SCO: serialise sco_conn lifetime against sco_recv_scodata()

Alex Bereza (1):
      dmaengine: xilinx_dma: Fix CPU stall in xilinx_dma_poll_timeout

Alex Deucher (2):
      drm/amdgpu: make Mac FB workaround generic
      drm/amd/display: check if dml21_add_phantom_plane() is successful

Alexander Graf (1):
      virtio_ring: fix stale descriptor flags after a failed packed add

Alexander Lobakin (1):
      ice: reshuffle and group Rx and Tx queue fields by cachelines

Alexey Charkov (1):
      regulator: of: fill in supply names in of_regulator_bulk_get_all()

Alexey Velichayshiy (1):
      ksmbd: remove redundant DACL check in smb_check_perm_dacl

Alice Ryhl (1):
      rust_binder: reschedule node refcount update on thread exit

Alvin Šipraga (2):
      ASoC: adau1372: allow sleepy powerdown GPIOs
      ASoC: adau1372: fix invalid default state of output ASRC and DAC muxes

Andreas Gruenbacher (5):
      gfs2: Clean up quotad timeout handling
      gfs2: Add clean argument to lm_unmount hook
      gfs2: Asynchronous withdraw
      gfs2: Get rid of delayed withdraws
      gfs2: Rename gfs2_{withdrawing_or_ => }withdrawn

Andy Shevchenko (1):
      ptp: ocp: Make ptp_ocp_unregister_ext() NULL-aware

Anton Protopopov (1):
      virtio_net: Fix resize of the RX ring

Arjan van de Ven (1):
      wifi: mt76: mt7921/mt7925: fix NULL dereference in CSA beacon

Armin Wolf (1):
      platform/x86: dell-wmi-base: Fix handling of ultra performance key

Arunpravin Paneer Selvam (1):
      drm/amdgpu: skip the VMID 0 flush for VRAM

Arvind Yadav (2):
      drm/xe/guc: Hold device ref until queue teardown completes
      drm/xe/guc: Keep scheduler timeline name alive

Aurelien Jarno (1):
      riscv: vector: Fix output operands in context save

Bart Van Assche (1):
      scsi: sd: Move the sd_config_discard() function definition

Bean Huo (1):
      scsi: ufs: core: Convert string descriptor format macros to enum

Ben Cressey (2):
      dm-crypt: reject the lmk IV mode with AEAD ciphers
      dm-integrity: fix buffer overflow in inline mode with large tag size

Bernd Schubert (1):
      fuse: Fix the condition to enable over-io-uring

Bibo Mao (1):
      LoongArch: KVM: Get VM PMU capability from HW GCFG register

Bihaan Sen (1):
      Input: xpad - add support for 8BitDo Pro 2 Wired Controller for Xbox

Boris Brezillon (1):
      drm/panthor: Always use the IRQ-safe variant when acquiring the fence lock

Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Fix AMD TLBI Erratum #1718

Breno Leitao (1):
      workqueue: fix devm_alloc_workqueue() va_list misuse

Bryam Vargas (3):
      ata: libata-core: Add NOLPM quirk for PNY CS900 1TB SSD
      wifi: mac80211: bound S1G TIM PVB walk to the TIM element
      dm-pcache: validate seg_id fields from persistent memory

Bryan Fraschetti (1):
      ice: Restore Ordered MMIO Writes for Tx Doorbells

Carlos López (1):
      KVM: arm64: vgic: Fix race between LPI release and re-registration

Cen Zhang (3):
      wifi: cfg80211: use wiphy work for socket owner autodisconnect
      Bluetooth: 6lowpan: avoid untracked enable work
      ocfs2: o2hb: quiesce negotiate handlers and timeout work

Cen Zhang (Microsoft) (1):
      net/sched: cls_u32: validate offshift to prevent shift-out-of-bounds

Chaitanya Kulkarni (1):
      blktrace: fix __this_cpu_read/write in preemptible context

Chao Yu (2):
      f2fs: fix to shrink gc_lock coverage in f2fs_gc_range()
      f2fs: fix to reset all pinned status during fggc

Chen Ni (1):
      ASoC: amd: acp-mach-common: Add missing error check for clock acquisition

Chengfeng Ye (7):
      tipc: hold a reference to nodes found by link name
      net/smc: protect clcsock lifetime in smc_getname
      Bluetooth: hci_sock: Serialize dead-device detachment
      Bluetooth: hci_sync: Fix command skb lifetime during scan setup
      Bluetooth: ISO: Reject concurrent BIS listener setup
      Bluetooth: ISO: Serialize concurrent connect calls
      bpf: Fix netns reference imbalance in conntrack kfuncs

Chris Mason (1):
      nfsd: convert nfsd_net boolean flags to unsigned long flags word

Christian Brauner (24):
      mount: keep a copied mount unbindable
      fs: don't silently unmount busy mounts
      namespace: reset the old parent's ->overmount in mnt_change_mountpoint()
      namespace: don't inherit MNT_UMOUNT in clone_mnt()
      namespace: don't copy an unmounted mount tree
      fs: refuse fspick() on internal superblocks
      namespace: check the target before walking it in do_mount_setattr()
      namespace: queue a mount only once for mount notifications
      namespace: check a submount for references right before unmounting it
      namespace: check a recursive bind mount for mount namespace loops
      namespace: look at the topmost mount for a mount namespace file
      namespace: remove the fsnotify marks of a mount namespace in process context
      namespace: check the mounts before reading their parents in pivot_root()
      dcache: don't put a mountpoint on a dentry that's being removed
      namespace: don't let a pseudo dentry become the root of a mount
      namespace: unhash a dentry before detaching the mounts on it
      namei: don't reveal overmounted entries in refwalk
      fcntl: refuse F_SET_RW_HINT on an immutable inode
      namespace: refuse an automount below a mount that is in no namespace
      namespace: never expire a locked mount
      namespace: handle mount locking for automounts correctly
      papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()
      mount: refuse MOVE_MOUNT_SET_GROUP on an unbindable mount
      fs: don't let a migrating task hide its reference from do_umount()

Christian Göttsche (1):
      selinux: fix data race on AVC latest_notif

Christian König (1):
      drm/amdgpu: fix amdgpu_hmm_range_get_pages

Chuck Lever (13):
      svcrdma: Add Write chunk WRs to the RPC's Send WR chain
      svcrdma: wake sq waiters when the transport closes
      svcrdma: Clear sc_cm_id when ADDR_CHANGE replacement fails
      SUNRPC: Add crypto/krb5 enctype lookup to krb5_ctx
      SUNRPC: Add errno-to-GSS status conversion helper
      SUNRPC: Prepare crypto/krb5 encryption and checksum handles
      SUNRPC: Switch wrap token encryption to crypto/krb5
      SUNRPC: Switch wrap token decryption to crypto/krb5
      SUNRPC: Switch MIC token generation to crypto/krb5
      SUNRPC: Switch MIC token verification to crypto/krb5
      SUNRPC: Reject short RFC 4121 MIC tokens in gss_krb5_verify_mic_v2
      NFS: Return a delegation the client fails to record
      SUNRPC: Add Kconfig dependency on CRYPTO_KRB5

Cristian Papa (1):
      wifi: mt76: mt7603: initialize global station WCID

Cédric Bellegarde (1):
      ASoC: qcom: q6asm: drop DSP responses for closed data streams

D. Wythe (1):
      Revert "net/smc: Introduce TCP ULP support"

Daehyeon Ko (8):
      ipv4: stop PMTU walk when nexthop group shrinks
      ipv4: stop exception dump when nexthop group shrinks
      ipv4: stop route notification sizing when nexthop group shrinks
      ipv4: do not warn on route notification size race
      ipv6: do not warn on route notification size race
      cipso: adjust cached option offsets when removing CIPSO
      vsock/virtio: account only unread bytes in read_skb()
      tcp: reject net_iov in zerocopy receive mapping hints

Damien Riégel (1):
      greybus: raw: fix use-after-free on cdev close

Dan Williams (1):
      cxl/region: Block region delete during region creation

Daniel Golle (1):
      net: dsa: mt7530: fix .get_stats64 sleeping in atomic context

Daniel Machon (1):
      net: sparx5: free the matchall entry on destroy

Darrick J. Wong (1):
      xfs: fix exchange-range-to-eof file size exchange

Dave Jiang (1):
      cxl/features: Serialize multi-part Get/Set Feature transfers

David Bauer (1):
      wifi: mt76: don't return TXQ when exceeding max non-AQL packets

David Carlier (2):
      net: ti: icssg-prueth: fix use-after-free of CPPI descriptor in RX path
      netfilter: flowtable: avoid num_encaps underflow on bridge VLAN untag

David Howells (5):
      afs: Fix the locking used by afs_get_link()
      netfs: Fix missing barriers when accessing stream->subrequests locklessly
      netfs: Fix zeropoint update where i_size > remote_i_size
      netfs: Fix folio_queue ENOMEM in writeback by adding a mempool
      netfs, afs: Fix symlink reading

David Lee (1):
      btrfs: lzo: reject inline extents without valid headers

David Sterba (1):
      btrfs: split btrfs_fs_closing() and change return type to bool

David Windsor (1):
      bpf: Reject sleepable BPF_LSM_CGROUP programs at load time

Deepanshu Kartikey (1):
      gfs2: fix memory leaks in gfs2_fill_super error path

Denis V. Lunev (1):
      openvswitch: fix soft lockup in the netlink flow dump

Devin Wittmayer (2):
      wifi: mt76: mt7925: don't put the band auto marker in TGID
      wifi: mt76: mt792x: pick the SAR table layout from the table itself

Dipayaan Roy (2):
      net: mana: check xdp_rxq registration before unreg in mana_destroy_rxq()
      net: mana: Skip WQ object destruction for uninitialized RXQ

Dmitry Baryshkov (1):
      media: iris: turn platform caps into constants

Donald Hunter (1):
      ynl: fix schema check errors

Dongjiang Zhu (1):
      btrfs: skip global block reserve accounting for rescue mounts

Doruk Tan Ozturk (1):
      accel/amdxdna: reject user command submission without a command BO

Eason Lai (1):
      wifi: mt76: mt792x: fix use-after-free in mt76_rx_poll_complete

Eduard Zingerman (7):
      bpf: mark a NULL call argument precise
      bpf: Don't infer non-NULL from a pointer with an unbounded offset
      bpf: don't rewrite bpf_fastcall patterns entered by a jump
      bpf: zero extend the result of an arena 32-bit cmpxchg
      bpf: backtracking shouldn't clear outer frame R1-R5 for callbacks
      bpf: backtrack_insn(): Handle ld_{abs,ind} subprog exit edge
      bpf: check_cond_jmp_op(): properly infer if register is null

Emil Tantilov (1):
      idpf: fix max_vport related crash on allocation error during init

Eric Biggers (1):
      crypto: drbg - Fix ineffective sanity check

Eric Dumazet (11):
      bnxt_en: fix DMA mapping length for padded small packets
      tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
      net: optimize enqueue_to_backlog() for the fast path
      net: fully inline backlog_unlock_irq_restore()
      net: serialize netif_running() check in enqueue_to_backlog()
      tipc: avoid busy looping in tipc_exit_net()
      ip6mr: do not clone dst in ip6mr_cache_report()
      ipv6: mcast: use rcu_assign_pointer() for __rcu list updates
      flow_dissector: avoid u16 truncation of skb->len when computing thoff
      flow_dissector: avoid u16 truncation of hlen in bpf_flow_dissect()
      net: fix backlog_unlock_irq_restore() vs CONFIG_PREEMPT_RT

Eva Crystal (1):
      accel/amdxdna: Bound the sync_bo flush range to the BO size

Evgenii Burenchev (2):
      drm/amd/display: Fix dangling pointer in CRTC reset function
      drm/amd/display: Fix dangling pointer in plane reset function

Fan Wu (2):
      gpio: mpsse: fix race when arming the IRQ poll worker
      drm/vc4: drain the hangcheck timer and works on V3D unbind

Fangyu Yu (1):
      iommu/riscv: Serialize command queue publishing

Felix Fietkau (8):
      wifi: mt76: mt7996: clear stale link state on full reset
      wifi: mt76: cancel reset and rc work on device unregister
      wifi: mac80211: add AQL support for multicast packets
      wifi: mac80211: add ieee80211_txq_aql_pending()
      wifi: mt76: add PS buffering support for HW-managed TIM drivers
      wifi: mt76: account non-AQL frames per peer rather than per link
      wifi: mt76: route nullfunc frames to PSD/ALTX queue
      wifi: mt76: use ALTX queue for packets to disassociated stations

Felix Gu (1):
      drm/msm/adreno: Fix a reference leak in a6xx_gpu_init()

Fengnan Chang (1):
      iomap: release pages on atomic dio size mismatch

Fernando Fernandez Mancera (1):
      net: openvswitch: validate transport header presence in set_ipv6_addr

Filipe Manana (4):
      btrfs: remove 'reserved' argument from btrfs_pin_extent()
      btrfs: don't BUG() on unexpected delayed ref type in run_one_delayed_ref()
      btrfs: fix xattr replace when multiple xattrs are packed in the same item
      btrfs: fix lost error return value in btrfs_listxattr()

Florian Westphal (2):
      netfilter: x_tables: allow initial table replace without emitting audit log message
      netfilter: x_tables: allocate hook ops while under mutex

Frank Sorenson (4):
      cifs: prevent readdir from changing file size due to stale directory metadata
      cifs: fix cifsFileInfo leak on kmalloc failure in deferred close drain paths
      cifs: call pagecache_isize_extended() in cifs_setsize() when extending
      cifs: consolidate time_last_write stamp into _cifsFileInfo_put()

Fredrik Nyberg (1):
      net: usb: ax88179_178a: fix rx frame length for non-last packets

Fuad Tabba (1):
      arm64/boot: Don't set PMUv3p9 FGT2 bits without PMUv3

Fushuai Wang (1):
      bpf: Use rcu_read_lock_dont_migrate in bpf_sk_storage.c

Gary Guo (3):
      PCI: Make pci_match_one_device() match on ID instead of device
      PCI: Fix dyn_id add TOCTOU
      PCI: Fix UAF when probe runs concurrent to dyn ID removal

George Zhang (1):
      drm/amd/display: Fix divide-by-zero in calculate_mcache_setting on zero viewport

Georgiy Osokin (1):
      tee: shm: reject zero-sized allocations in tee_dyn_shm_alloc_helper()

Gou Hao (2):
      powerpc/xive: add error return value to xive_smp_probe()
      powerpc/xive: propagate IPI init errors to prevent use-after-free

Greg Kroah-Hartman (1):
      Linux 6.18.57

Guangshuo Li (3):
      mmc: cavium-octeon: destroy slot platform devices on remove
      mmc: cavium-thunderx: destroy slot platform devices on remove
      mmc: sdhci-sprd: disable runtime PM on remove

Guidong Han (1):
      RISC-V: KVM: Fix PMU event info array size overflow

Guixin Liu (2):
      nvmet: fix return status of RMI log page on allocation failure
      nvmet: return Invalid Field for invalid NSIDs feature 82h

Gyeyoung Baek (2):
      drm/imagination: Size page table preallocation by device address
      drm/imagination: Fix reference and vm_bo handling in remap()

Haishuang Yan (2):
      devlink: fix devlink_rel reference leak when notify work is pending
      pfcp: make sure the SEID is linear before reading it

Han Gao (2):
      spi: sg2044-nor: Return transfer errors
      spi: sg2044-nor: Honor SPI clock limits

Hao Ge (1):
      netfs: Fix missing alloc tagging of direct mempool allocations

Haojie Li (1):
      drm/amdkfd: fix dma_buf reference leak in get_dmabuf_info

Haotian Zhang (2):
      Input: ati_remote2 - fix type confusion in device attribute handlers
      PCI: endpoint: Add missing NULL check for alloc_workqueue()

Haoxiang Li (1):
      HID: logitech-hidpp: Fix FF device cleanup on init failure

Harald Freudenberger (7):
      s390/zcrypt: Move inline function rng_type6cprb_msgx from header to code
      s390/zcrypt: Rework domain processing within zcrypt device driver
      s390/zcrypt: Close speculative mem read possibility
      s390/zcrypt: Improve CCA CPRB length and overflow checks
      s390/zcrypt: Improve EP11 CPRB length and overflow checks
      s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing
      s390/zcrypt: Pad trailing CCA or EP11 message with zeros

Harin Lee (4):
      ALSA: ctxfi: Fix memory leakage when clearing DAO input mappers
      ALSA: ctxfi: Add hw parameter to daio_mgr_dao_init()
      ALSA: ctxfi: Use explicit output flag for DAIO resources
      ALSA: ctxfi: Refactor resource alloc for sparse mappings

Hariprasad Kelam (1):
      octeontx2-af: Block VFs from clobbering special CGX PKIND state

Harish Kasiviswanathan (1):
      drm/amdgpu: Fix kernel panic during driver load failure

Harry Wentland (1):
      drm/amd/display: Resize MST HDCP per-connector arrays to 32

Helen Koike (1):
      fs/ntfs3: call _ntfs_bad_inode() when failing to rename

Hengyu Liang (1):
      ata: libata-scsi: do not lose CHECK CONDITION for failed ATAPI commands

Hongjie Fang (1):
      scsi: core: pair EH runtime PM get and put

Honglei Huang (1):
      drm/amd/display: use kvzalloc to allocate struct dc

Hongling Zeng (3):
      fbdev: omap2: fix inconsistent lock returns in omapfb_mmap
      fbdev: omap2: fix use-after-free in omapfb_mmap
      cachefiles: Fix error return when vfs_mkdir() fails

Hristo Venev (1):
      ceph: put folios not suitable for writeback

Hui Peng (1):
      sctp: copy zeroed stats to user in sctp_getsockopt_pr_streamstatus() when !streamoute

Iaroslav Voitovych (1):
      Bluetooth: MGMT: Fix status of pending commands flushed on power off

Ido Schimmel (1):
      ipv6: Fix redirect exception creation for UDP/RAW sockets

Ilan Dudnik (1):
      ksmbd: defer publishing granted locks to prevent UAF/double-free race

Ilia Gavrilov (1):
      vsock: Fix memory leak in vmci_transport_recv_dgram_cb()

Jackson Lee (1):
      media: chips-media: wave5: Resume device before setting EOS flag

Jakub Kicinski (3):
      eth: bnxt: decrease indent in bnxt_request_irq()
      eth: bnxt: avoid deadlock when canceling IRQ affinity notifier
      net: make dev_xdp_sb_prog_count() see programs attached through a link

Jamal Hadi Salim (5):
      net: Introduce skb tc depth field to track packet loops
      net/sched: fix packet loop on netem when duplicate is on
      net/sched: Handle TC_ACT_REDIRECT from qdisc filter chains
      net/sched: account classifier filter allocations to memcg
      net/sched: em_text: reject unterminated algo before autoload

Jan Kara (1):
      ext2: Fix lost inode updates for IS_SYNC inodes

Jason A. Donenfeld (1):
      wireguard: noise: reject response consumption after intermediate initiation

Jason Huang (1):
      wifi: brcmfmac: fix P2P action frame handling without device vif

Jay Buddhabhatti (2):
      drivers: firmware: xilinx: Add unique family code for all platforms
      drivers: firmware: xilinx: Switch to new family code in zynqmp_pm_get_family_info()

Jeff Johnson (1):
      wifi: ath12k: fix overreads in ath12k_wmi_process_csa_switch_count_event()

Jeff Layton (2):
      nfsd: restore rq_status_counter to even on all nfsd_dispatch() exit paths
      lockd, nfsd: RCU-protect nlmsvc_ops dispatch

Jerome Tollet (2):
      net/mlx5e: Prevent stale XSK buffer release on refill retry
      net/mlx5e: Prevent stale XSK buffer release on MPWQE refill retry

Jesse Zhang (4):
      drm/amdgpu/userq: only accept doorbell BOs as queue doorbell
      drm/amdgpu/userq: return the memdup_user() error for the user MQD
      drm/amdgpu: force complete the MES ring fences on reset
      drm/amdgpu: force complete the KIQ ring fences on reset

Ji-Ze Hong (Peter Hong) (1):
      usb: f81604: fix struct f81604_int_data size mismatch

Jia Jia (2):
      vhost: invalidate vring access on IOTLB transitions
      vduse: validate virtqueue alignment

Jia Zhu (1):
      erofs: fix metabuf leak in inode xattr initialization

Jiangshan Yi (1):
      xfs: remove duplicate INO1_WRITTEN check

Jiri Olsa (5):
      bpf: Factor callchain_store function from __bpf_get_stack
      bpf: Factor callchain_finalize function from __bpf_get_stack
      bpf: Remove trace_in argument from __bpf_get_stack
      bpf: Clear buf on error in __bpf_get_task_stack
      uprobes/x86: Move optimized uprobe from nop5 to nop10

Joel Fernandes (1):
      srcu: Use irq_work to start GP in tiny SRCU

Johannes Berg (3):
      Revert "wifi: libertas: reject short monitor TX frames"
      wifi: cfg80211: enforce HE/EHT cap/oper consistency
      wifi: ieee80211: split S1G definitions out

Johannes Thumshirn (1):
      btrfs: zoned: flush active metadata block group at btree_writepages() start

Joonas Lahtinen (1):
      drm/i915/gt: Fix NULL deref on sched_engine alloc failure

Jori Koolstra (1):
      hfs: Replace BUG_ON with error handling for CNID count checks

Josef Bacik (2):
      xen/netfront: don't leak the skb when xennet_fill_frags() fails
      net: skbuff: don't leave stale bytes in skb_copy_and_csum_bits()

Joshua Washington (3):
      gve: fix napi_disable deadlock when attempting to disable XSK pools
      gve: fix XSK buffer leak when rings are stopped
      gve: fix XSK buffer leak on error descriptor

Julian Anastasov (1):
      ipvs: revalidate ihl to prevent out-of-bounds access

Junjie Cao (1):
      wifi: mt76: mt792x: treat 0xff ACPI SAR entries as no limit

Justin Chen (1):
      net: bcmgenet: if UMAC was suspended in SW_RESET, restore it to SW_RESET

Justin Yeh (1):
      pinctrl: mediatek: use devm_gpiochip_add_data() for GPIO chip

Jérémy Jean (1):
      NFSv4.1: zero referring call lists before decoding

Karl Bonde Torp (1):
      nvme: fix swapped ZRASF zone state values for full and read only

Karl Mehltretter (6):
      arm64: irq: exclude the softirq stack switch from KCOV
      keys: finalize persistent keyring timeout after link attempt
      riscv: fix load_unaligned_zeropad() fixup for RV32
      tty: skip cdev_del() when no cdev is registered
      serial: core: clear freed pointers on uart_register_driver() failure
      serial: core: do fallible allocations before the console can be registered

Karthikeyan KS (1):
      soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read

Kees Cook (1):
      net: Convert proto_ops bind() callbacks to use sockaddr_unsized

Keita Morisaki (1):
      ice: fix race condition in TX timestamp ring cleanup

Keith Busch (2):
      nvme-pci: fix dma mapping leak on data setup error
      nvme-pci: fix dma_vecs leak on p2p memory

Kohei Enju (1):
      ice: fix potential NULL pointer deref in error path of ice_set_ringparam()

Koichiro Den (2):
      NTB: core: Add .get_dma_dev() callback to ntb_dev_ops
      NTB: ntb_transport: Use ntb_get_dma_dev() for DMA buffers

Konstantin Komarov (1):
      fs/ntfs3: Reformat code and update terminology

Kriish Sharma (1):
      hdlc_ppp: fix potential null pointer in ppp_cp_event logging

Krzysztof Furman (1):
      Input: xpad - add support for Corsair Novablade Pro

Krzysztof Karas (2):
      drm/i915/gem: Prevent overstepping exec array boundary
      drm/i915/gt: Unmask interrupts only when ACTIVE is true

Krzysztof Kozlowski (3):
      workqueue: devres: Add device-managed allocate workqueue
      power: supply: max77705: Drop duplicated IRQ error message
      power: supply: max77705: Free allocated workqueue and fix removal order

Krzysztof Wilczyński (1):
      PCI/sysfs: Add lockdown checks to legacy I/O and memory handlers

Kuba Piecuch (1):
      sched_ext: Generate qseq from a per-task counter

Kumar Kartikeya Dwivedi (3):
      bpf: Preserve inner map identity in callback frames
      bpf: Mark NULL kptr stores precise
      bpf: Mark syscall helpers as sleepable

Larysa Zaremba (1):
      ixgbe: do not configure xps for XDP queues

Leo Li (1):
      drm/amd/display: Fix direct scanout alpha on some DRM_FORMATs

Leon Hwang (1):
      bpf: Fix WARNING in bpf_tracing_link_release

Leon Romanovsky (3):
      ntb: Store original DMA address for future release
      RDMA/cxgb4: Fix dereg_skb leak and double free in write_tpt_entry()
      RDMA/rvt: Return NULL after port allocation failure

Li Qiang (1):
      scsi: ufs: core: Validate string descriptors

Li RongQing (2):
      iommu/dma-iommu: Fix wrong scatterlist length assignment in P2PDMA path
      net/mlx5e: Order ICOSQ cc update after CQ doorbell

Linfeng Sun  (1):
      vhost_iotlb: bound map allocation in add_range

Lizhi Hou (11):
      accel/amdxdna: Enhance runtime power management
      accel/amdxdna: Add hardware specific attributes
      accel/amdxdna: Fix potential NULL pointer dereference in context cleanup
      accel/amdxdna: Fix NULL pointer dereference of mgmt_chann
      accel/amdxdna: Fill invalid payload for failed command
      accel/amdxdna: Fix VMA access race
      accel/amxdna: Fix page-insertion errors in amdxdna_insert_pages()
      accel/amdxdna: Fix locally exploitable BUG_ON in amdxdna_insert_pages()
      accel/amdxdna: Resume power for creating and destroying hardware context
      accel/amdxdna: Fix race condition when checking rpm_on
      accel/amdxdna: Fix crash when destroying a suspended hardware context

Long Li (1):
      net: mana: Cap MSI-X vectors to the device MSI-X table size

Longlong Xia (1):
      zram: fix out-of-bounds access in writeback_store()

Lorenzo Bianconi (1):
      net: stmmac: fix dma mapping leak in stmmac_tso_xmit()

Lu Baolu (1):
      iommu/vt-d: Fix iopf_refcount leak on RID domain replacement

Lu Huang (1):
      wifi: mt76: mt7996: fix uninitialized buf read in mt7996_variant_fem_init()

Luiz Augusto von Dentz (1):
      Bluetooth: hci_conn: Fix using conn->le_{tx,rx}_phy as supported PHYs

Lukas Gerlach (1):
      KVM: riscv: Fix Spectre-v1 in PMU counter access

Lukas Wunner (1):
      bnxt_en: Drop pci_save_state() after pci_restore_state()

Luxiao Xu (1):
      bpf: Check sk_state before sk_protocol in bpf_tcp_*_syncookie

Ma Xinmeng (1):
      dm-snap: reject the transient exception store for snapshot-merge

Maciej Fijalkowski (2):
      xsk: provide sufficient space in pool->tx_descs
      xsk: reclaim invalid Tx descriptors in ZC batch path

Mahantesh Salimath (1):
      tee: optee: ffa: support shared memory offsets on large-page kernels

Maher Azzouzi (1):
      esp: do not unref managed frag pages in esp_ssg_unref()

Marco Crivellari (1):
      PCI: Add WQ_PERCPU to alloc_workqueue() users

Marco Scardovi (1):
      platform/x86: asus-wmi: fix resource leaks on probe failure

Marek Szyprowski (3):
      swiotlb: fix default_swiotlb_limit() for non-growable default pool
      clocksource/drivers/samsung_pwm: Switch to raw_spinlock_t type
      ASoC: samsung: i2s: enable op_clk in probe to balance runtime PM

Mark Brown (1):
      KVM: arm64: Correctly cap ZCR_EL2 provided by a guest hypervisor

Mark Tomlinson (1):
      gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock

Masami Hiramatsu (Google) (1):
      ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer

Mateusz Guzik (1):
      fs: move mntput_no_expire() slowpath into a dedicated routine

Matt Bobrowski (1):
      bpf: Fix UAF in sock clone early bailouts

Matthew Wilcox (Oracle) (1):
      fs: Free any excess xarray nodes in clear_inode()

Maurizio Lombardi (1):
      nvmet: fix max_qid race between configfs and controller allocation

Max Zhen (1):
      accel/amdxdna: Refactor GEM BO handling and add helper APIs for address retrieval

Maxim Skokov (1):
      Bluetooth: RFCOMM: free the skb when the DLC has no owner

Maíra Canal (2):
      drm/vc4: Free the BO cache size list on teardown
      drm/vc4: Fix binner slot allocation failing on an idle GPU

Meghana Malladi (2):
      net: ti: icssg-prueth: Add functions to create and destroy Rx/Tx queues
      net: ti: icssg-prueth: Make emac_run_xdp function independent of page

Miaoqing Pan (1):
      wifi: ath12k: fix memory leak in ath12k_wifi7_dp_rx_h_verify_tkip_mic()

Michael Bommarito (3):
      net: hsr: defer node table free until after RCU readers
      xen/pvcalls: bound backend response req_id before indexing rsp[]
      idpf: bound interrupt-vector register fill to the allocated array

Michael Chan (3):
      bnxt_en: Add bnxt_clear_bars() helper
      bnxt_en: Fix driver init in kdump kernel
      bnxt_en: Delay for 5 seconds after AER DPC for all chips

Michael Garland (1):
      ASoC: amd: yc: Add DMI quirk for Acer Aspire Go 15 (AG15-21P)

Michael S. Tsirkin (1):
      ipv4: validate checksum_start before completing checksum

Michal Schmidt (1):
      ice: fix double-free of tx_buf skb

Michele Dionisio (1):
      wifi: brcmfmac: fix P2P device removal race in brcmf_detach()

Mikhail Gavrilov (3):
      mm: don't schedule deferred kernel page table freeing while booting
      drm/amdgpu: copy debugfs register data outside the GRBM/SRBM locks
      drm/amd/display: Wrap DCN32 phantom-plane allocation in DC_RUN_WITH_PREEMPTION_ENABLED

Mikhail Lobanov (1):
      f2fs: read COW data with the original inode during atomic write

Mikulas Patocka (1):
      dm: fix reading free memory in do_resume

Ming Qian (3):
      pmdomain: imx8m-blk-ctrl: Serialize power on/off across sibling domains
      media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC
      media: verisilicon: Fix kernel panic due to __initconst misuse

Mingming Cao (2):
      ibmveth: h_free logical LAN on open-fail after register
      ibmveth: fix TX LTB and filter unwind on open-fail

Miquel Sabaté Solà (1):
      btrfs: apply the AUTO_K(V)FREE macros throughout the code

Mohamed Yassine Jebabli (1):
      ALSA: hda/tas2781: Accept V1 calibration data without CRC

Morduan Zang (1):
      net: phonet: do not BUG_ON() in pn_socket_autobind() on failed bind

Mostafa Saleh (1):
      optee: ffa: Add NULL check in optee_ffa_lend_protmem

Myeonghun Pak (1):
      drm/aspeed: Balance the display clock enable on teardown

Naman Jain (1):
      static_call: allow using STATIC_CALL_TRAMP_STR() from assembly

Namjae Jeon (7):
      ksmbd: prevent path traversal bypass by restricting caseless retry
      ksmbd: scope session state changes to bound connections
      ksmbd: detach blocked lock requests before freeing
      ksmbd: safely discard unregistered deferred locks
      ksmbd: serialize oplock close with pending break ownership
      ksmbd: fix maximum allowed access checks
      ksmbd: convert tree_conns_lock to rw_semaphore

NeilBrown (1):
      nfsd: use workqueue enable/disable APIs for v4_end_grace sync

Nguyen Ngoc Thang (2):
      memstick: rtsx_usb_ms: complete requests after eject instead of dropping them
      drm/fb-helper: defer setup when fbdev_probe() fails, not just on -EAGAIN

Nicholas Dudar (3):
      LoongArch: BPF: Zero-extend signed ALU32 div/mod results
      bpf: Reject rdonly/rdwr_buf_size kfunc arguments that exceed u32 max
      bpf: Reject writes through untrusted BTF pointers

Nicholas Kazlauskas (2):
      drm/amd/display: Rename FAMS2 global control lock to DMUB HW control lock
      drm/amd/display: Adjust PHY FSM transition to TX_EN-to-PLL_ON for TMDS on DCN35

Nicolas Cavallari (1):
      wifi: mt76: mt7915: disable rx napi when removing device

Nicolas Dufresne (1):
      media: v4l2-mem2mem: Add a kref to the v4l2_m2m_dev structure

Nicolin Chen (2):
      iommu: Pass in old domain to attach_dev callback functions
      iommu/tegra241-cmdqv: Don't fall back to a freed smmu after devm_krealloc()

Niklas Cassel (1):
      ata: libata-core: Disable LPM on Silicon Motion MD619{H,G}XCLDE3TC

Nikolay Aleksandrov (2):
      vxlan: fix reading neigh ha
      net: bridge: arp/nd proxy: fix reading neigh ha

Ning Ding (3):
      bpf: Compare iterator types during state pruning
      bpf: Invalidate RCU pointers after final spin unlock
      bpf: Keep refcount_acquire nullable for borrowed RCU kptrs

Nitin Gote (1):
      drm/xe: don't WARN on kernel job timeout when device already wedged

Norbert Szetei (1):
      xfs: stop exchanging reflink flags when exchanging mappings

Oleg Keri (1):
      drm/dp: don't mark the AUX backlight enabled when enabling failed

Oleh Konko (1):
      Bluetooth: hci_event: move wake reason storage into validated event handlers

Oliver Hartkopp (1):
      can: fix unique skb identifier regression under RPS

Omar Ramadan (1):
      amt: send the relay's General Query directly from the receive path

Or Har-Toov (1):
      Revert "net/mlx5: E-Switch, preserve max tx speed on vport state modification"

Osama Abdelkader (1):
      drm/panthor: validate userspace queue count against initialized firmware slot count

Pablo Neira Ayuso (4):
      netfilter: nf_tables: add hook transactions for device deletions
      netfilter: nft_fwd_netdev: add device and headroom validate with neigh forwarding
      netfilter: nf_dup_netdev: add nf_dev_xmit_recursion*() helpers and use them
      netfilter: nf_tables: skip double clone set expressions on element insert

Palla Raghunath (2):
      dm ioctl: don't let data_start run past the buffer
      Bluetooth: RFCOMM: Fix NULL tty_dev dereference in rfcomm_dev_shutdown

Pauli Virtanen (5):
      Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if exists
      Bluetooth: hci_sync: hold conn in hci_connect_pa_sync() callback
      Bluetooth: hci_sync: hold conn in hci_connect_big_sync() callback
      Bluetooth: hci_sync: hold conn in hci_connect_acl/le_sync() callbacks
      Bluetooth: L2CAP: access chan->conn safely in get/setsockopt

Paulo Alcantara (3):
      netfs: zero the tail of a short DIO/unbuffered read
      smb: client: avoid using uninitialized SIDs in cifs_posix_to_fattr()
      smb: client: honor forceuid/forcegid when mapping SIDs to uid/gid

Pavan Chebbi (2):
      fwctl/bnxt_en: Refactor aux bus functions to be more generic
      bnxt_en: Re-write the BARs following any type of PCIe errors

Pavankumar Kondeti (1):
      workqueue: Fix NULL current_pwq deref in chained work check

Petr Machata (1):
      mlxsw: spectrum_flower: Fix port range register leak in tmplt_create()

Petr Oros (1):
      dpll: fix NULL deref in dpll_device_ops() during teardown race

Prasanna Kumar T S M (1):
      soc: xilinx: Fix race condition in event registration

Prathamesh Shete (1):
      soc/tegra: pmc: Fix unsafe generic_handle_irq() call

Pratyush Yadav (Google) (1):
      kho: fix size calculation in kho_preserved_memory_reserve()

Puranjay Mohan (1):
      bpf: net: netfilter: drop dead NULL checks

Qing Ming (1):
      usb: gadget: uac: validate rate list length before storing

Qu Wenruo (4):
      btrfs: do not ASSERT() when the fs flips RO inside btrfs_repair_io_failure()
      btrfs: only invalidate btree inode pages after all ebs are released
      btrfs: warn about extent buffer that can not be released
      btrfs: make sure EXTENT_BUFFER_READING is cleared under refs_lock

Quchaosheng (1):
      net/packet: guard the ll header push in packet_rcv_spkt()

Quentin Freimanis (1):
      net: sparx5: start the TOD counters on non-PTP lan969x variants

Radek Podgorny (1):
      Bluetooth: do not leak an hci_conn when a second LE connect is rejected

Rafael J. Wysocki (8):
      ACPI: button: Adjust event notification routines
      ACPI: button: Convert the driver to a platform one
      ACPI: button: Tweak acpi_button_remove()
      ACPI: button: Fix ACPI GPE handler leak during removal
      thermal: hwmon: Remove hwmon class device along with its parent
      ACPI: bus: Introduce acpi_bus_get_primary_device()
      ACPI: scan: Do not mark button ACPI devices as wakeup-capable
      ACPI: scan: Use acpi_setup_gpe_for_wake() for buttons

Raj Ojha (1):
      memstick: core: wait for request completion before freeing card

Ralf Lici (1):
      ovpn: defer key slot crypto freeing to workqueue

Ralph Boehme (1):
      smb/client: fix chown/chgrp with SMB3 POSIX Extensions

Ramses de Norre (1):
      wireguard: queueing: preserve tstamp_type when encapsulating packet

Raphael Zimmer (1):
      libceph: Fix potential out-of-bounds access in __ceph_x_decrypt()

Ravindra (1):
      Bluetooth: btintel_pcie: fix TX descriptor bounds check

Ray Wu (1):
      drm/amd/display: disable replay when crc source is enabled

Reinette Chatre (1):
      fs/resctrl: Fix UAF from worker threads when domains are removed

Remy D. Farley (1):
      doc/netlink: netlink-raw: Add max check

Ridham Khurana (2):
      gpio: xilinx: fix runtime PM leak on request error path
      regulator: tps6594-regulator: Fix n_linear_ranges for TPS65224 BUCK2-4

Ritesh Harjani (IBM) (2):
      pseries/papr-hvpipe: Fix race with interrupt handler
      powerpc/64s: Fix unmap race with PMD migration entries

Rodrigo Zaiden (1):
      tee: optee: fix kernel-doc warnings

Runyu Xiao (2):
      scsi: qedi: Initialize callback state before registration
      Bluetooth: btintel_pcie: use managed IRQ teardown

Ruoyu Wang (1):
      bnxt_en: Handle partially initialized auxiliary devices

Sabrina Dubroca (1):
      strparser: make sure __strp_recv isn't running before tearing down the parser

Sai Krishna (1):
      octeontx2-af: fix cn20k mailbox lifetime on repeated rvu_mbox_init()

Sai Teja Aluvala (1):
      Bluetooth: btintel_pcie: Add shared HW reset for clean start

Sajal Gupta (1):
      drm/gud: don't keep a connector without a CRTC as connector_state

Saleel Kudchadker (1):
      drm/amdkfd: align SDMA doorbell base for shader doorbell writes

Sang-Hoon Choi (3):
      gpio: exar: initialize the ID before registering its cleanup
      cxgb4/ch_ktls: disable softirqs around tid_list erases
      nvmet: use the local P2P device on metadata allocation failure

Sarika Sharma (1):
      wifi: mac80211: fix missing RX bitrate update for mesh forwarding path

Sascha Bischoff (1):
      irqchip/gic-v5: Clear per-CPU IRS data on teardown

Satyanarayana K V P (1):
      drm/xe/vf: Add drm_dev guards when detaching CCS read/write buffers

Sean Christopherson (2):
      KVM: guest_memfd: Treat memslot binding offset+size as unsigned values
      KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is zapped

Sebastien Royen (1):
      net: dsa: microchip: fix KSZ8765 fiber detection

Selvin Xavier (2):
      RDMA/bnxt_re: Add a max slot check for SQ
      RDMA/bnxt_re: Free CQ toggle page after firmware teardown

Seohyeon Maeng (1):
      udf: fix partition descriptor append bookkeeping

Shao-Fu Chen (1):
      optee: register TEE devices only once fully initialized

Shawn Lin (3):
      pmdomain: rockchip: don't ignore clock lookup errors on attach
      pmdomain: rockchip: fix clock leak on domain probe failure
      pmdomain: rockchip: propagate subdomain add errors

Shay Drory (1):
      net/mlx5: LAG, Fix off-by-one in single-FDB error rollback

Shayne Chen (1):
      wifi: mt76: fix handling channel context with different bands in mt76_switch_vif_chanctx()

Shin'ichiro Kawasaki (1):
      zloop: zero out only the unread tail of short reads

Srinivas Kandagatla (1):
      ASoC: qcom: q6asm: handle the responses after closing

Srinivasan Shanmugam (1):
      drm/amd/display: Fix dc_link NULL handling in HPD init

Stanislav Kinsburskii (4):
      mshv: Refactor and rename memory region handling functions
      mshv: Centralize guest memory region destruction
      mshv: Move region management to mshv_regions.c
      mshv: Fix error handling in mshv_region_pin

Stephen Smalley (1):
      selinux: preserve NATIVE_LABELS on already-initialized sb in set_mnt_opts

Steven Rostedt (3):
      eventfs: Use children field for rcu head and add memory barriers
      tracing: Take trace_array reference when opening a tracer options file
      ring-buffer: Add checking nr_subbufs to persistent ring buffer validation

Sudeep Holla (3):
      firmware: arm_scmi: Clear SystemPower flag on create failure
      firmware: arm_scmi: Fix OF node reference handling
      firmware: arm_scmi: Fix SCMI device destroy lifetimes

Sun YangKai (1):
      btrfs: check if root is readonly when setting posix acl

Sunil Khatri (1):
      drm/amdgpu/userq: fix access to stale wptr mapping

Takashi Iwai (1):
      ALSA: ctxfi: Check the error for index mapping

Tao Gong (1):
      wifi: mt76: mt7996: fix struct mt7996_mcu_wed_rro_ba_delete_event layout

Tejun Heo (1):
      workqueue: Annotate alloc_workqueue_va() with __printf(1, 0)

Tetsuo Handa (1):
      printk: Don't WARN on kthread_run failure.

Thomas Gleixner (1):
      irqwork: Move data struct to a types header

Thomas Hellström (4):
      drm/xe: Fix shrinker accounting double-subtraction on nested external pins
      drm/xe: Fix stale pinned_link entry when fb-pin performs the final unpin
      drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on swapout failure
      drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup failure

Thomas Zimmermann (1):
      fbdev: Wrap user-invoked calls to fb_set_var() in helper

Tianyi Gao (1):
      veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after GRO is toggled while down

Tristan Madani (1):
      ice: fix metadata_dst refcount handling on representor teardown

Troy Mitchell (1):
      riscv: vector: Fix data pointer constraints in context save/restore

Uday Shankar (1):
      ublk: reset per-IO canceled flag on each fetch

Usama Arif (2):
      blk-iocost: clear delay state when freeing policy data
      blk-iolatency: clear delay state when freeing policy data

Utkarsh Singh (1):
      gfs2/sysfs: Replace sprintf/snprintf with sysfs_emit

Vadim Fedorenko (3):
      ti: icssg: convert to ndo_hwtstamp API
      ptp: ocp: fix resource freeing order
      ptp: ocp: fix PCIe delay estimation calculation

Val Packett (1):
      remoteproc: qcom_wcnss: Fix handling the lack of PD regulators in v3

Vicki Pfau (4):
      HID: steam: Fully unregister controller when hidraw is opened
      HID: steam: Rearrange teardown sequence
      HID: steam: Refactor registration
      HID: steam: Clean up locking

Victor Nogueira (1):
      net/sched: cls_route: reject change with no routing attribute

Vincent Donnefort (1):
      tracing: Fix subbuf resize races with trace_pipe_raw readers

Vincent Jardin (3):
      arm64: dts: lx2160a: fix incorrect pinmux
      arm64: dts: lx2160a: fix IIC1 pinmux submask rejected by pinctrl-single
      arm64: dts: lx2160a: fix the iic5 spi3 pinmux offset and value

Vishal Badole (1):
      EDAC/amd64: Mask UMC chip select to the four implemented selects

Vishnu Reddy (1):
      media: iris: fix use-after-free of fmt_src during MBPF check

Vitaly Prosyak (1):
      drm/amdgpu: serialize vblank counter reads against GPU reset

Vladimir Riabchun (1):
      scsi: qla2xxx: Completely fix fcport double free

Waiman Long (2):
      cgroup/cpuset: Handle cpu hotplug race in guarantee_active_cpus()
      cgroup/cpuset: Call is_in_v2_mode() after acquiring cpuset_mutex in cpuset_handle_hotplug()

Wei Zhang (1):
      wifi: ath12k: fix inconsistent arvif state in vdev_create error paths

Weiming Shi (5):
      net: team: stop reusing skb after queue override
      net: team: free skb when broadcast has no txable port
      tipc: serialize udp bearer replicast list updates
      netfilter: nft_fwd_netdev: use recursion counter in neigh egress path
      btrfs: lzo: reject compressed segment that overflows the compressed input

Wentao Liang (2):
      btrfs: scrub: fix local_root reference leak in scrub_print_warning_inode()
      drm/vc4: Fix firmware reference leak in vc4_drm_bind()

Will Deacon (1):
      arm64: ptrace: Keep 'orig_x0' in-sync with x0 on syscall entry

William Palacek (1):
      drm/amdkfd: Add bounds check for CRAT subtype length

Xiang Mei (Microsoft) (2):
      nexthop: avoid unlocked f6i_list walk in nh_rt_cache_flush
      nexthop: take nh->lock for f6i_list walks in replace check and notify

Xiubo Li (1):
      ceph: fix UAF in check_new_map() on session freed during unlock

Xuanqiang Luo (1):
      ice: fix use-after-free in dynamic port cleanup

Yang Xiuwei (5):
      scsi: sd: Fix special_vec mempool leak when scsi_alloc_sgtables() fails
      ublk: validate auto buf reg before taking uring_cmd
      btrfs: always return -EIOCBQUEUED after btrfs_uring_read_extent_endio
      btrfs: free iov when btrfs_uring_read_extent() fails
      btrfs: unlock inode and extent in caller when io_uring read extent fails

Yeoreum Yun (1):
      coresight: etm4x: missing cscfg_csdev_disable_active_config() in perf enable

Yibo Tan (1):
      mmc: mtk-sd: Cancel request timeout work on remove

Yingying Tang (1):
      Revert "wifi: ath12k: add panic handler"

Yiyang Chen (3):
      bpf: Guard conntrack opts error writes
      bpf: Check pointer type for all atomic RMW paths
      bpf: Reject MEM_ALLOC BTF accesses past object bounds

Yonghong Song (1):
      bpf: Reject >8 byte return values on return-reading trampoline paths

Yongpeng Yang (1):
      f2fs: fix data loss caused by incorrect use of nat_entry flag

Yongqiang Sun (1):
      drm/amdkfd: Fix infinite loop parsing CRAT with zero subtype length

Yosry Ahmed (1):
      KVM: nSVM: Triple fault if restore host CR3 fails on nested #VMEXIT

Yu Kuai (1):
      blk-cgroup: delay freeing policy data after rcu grace period

Yufan Chen (1):
      ocfs2/heartbeat: fix slot mapping rollback leaks on error paths

Yuho Choi (2):
      net/liquidio: drop cached VF pci_dev LUT
      dmaengine: idxd: fix double free of wq, engine, and group structs

Yun Zhou (1):
      ext4: validate donor file superblock early in EXT4_IOC_MOVE_EXT

Yunseong Kim (1):
      ksmbd: fix slab-out-of-bounds read in ksmbd_alloc_user()

Yuqi Xu (1):
      tipc: destroy topsrv workqueues before closing connections

Yuyang Huang (1):
      ipv6: mcast: annotate data-races around mca_users

Zack Rusin (1):
      drm/vmwgfx: validate pitch coming from userspace

Ze Tan (1):
      smb/server: fix tree connection leak in smb2_tree_connect()

Zeng Chi (1):
      LoongArch: KVM: Validate MSI data before routing it to EIOINTC

Zhang Cen (1):
      ocfs2: validate fast symlink target during inode read

Zhang Yi (1):
      ext4: add mext_check_validity() to do basic check

Zhao Li (3):
      wifi: mac80211: capture fast-RX rate before mesh reuses skb->cb
      wifi: mac80211: validate extension-frame layout before RX
      wifi: nl80211: clean up color-change beacon data on errors

Zixuan Chai (1):
      net: bridge: avoid recursive multicast port cleanup

Ziyi Guo (2):
      riscv: entry: gate shadow call stack reload on sstatus.SPP, not tp
      riscv: futex: untag the user pointer before the atomic access

Zongmin Zhou (2):
      riscv: errata: select RISCV_ALTERNATIVE_EARLY for THEAD GHOSTWRITE
      riscv: hwprobe: use _BITULL() rather than BIT() in MIPS vendor uapi header

성병찬 (1):
      KEYS: Fix add_key() race with keyring restriction

