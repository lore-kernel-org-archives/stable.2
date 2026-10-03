Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D69D41B8D6;
	Sat,  3 Oct 2026 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791024848; cv=none; b=GkMbk1uiV+Qp2m2Vco+3mimOPua6Vauo92mgHwoluRvTOAQefryZs491Fu+t/juABV6urMFPCEBvKw15N88OvKo9AkKmK/8IOlDDaglE18ZF7IBICP2N3zlm+D5J1JMHVVLsXNkTOEv85+N6niuN39c1ZuGNBeV2GiEu4uqS0Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791024848; c=relaxed/simple;
	bh=w/pIn/k+4B+jbqAodnY2JNcsnyJuZPGJXxtHaoh4V24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k+xRp3l/TEQmGQdHDdNSyJUan6/lOLggIenxY82sdKSRFz8yu1KWCmqM2x+jTyWsrTG713BjLVOsvbL9yFQQh4EnBbbj7rAZPQY/tjjQDKlUFua2gr6ukrEvVT1dEZ3tCXptsRSBld2OgE2kPjFJr3axmZ+/kMopLyLaCntoeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MtBparv1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MtBparv1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD811F0089D;
	Sat,  3 Oct 2026 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791024832;
	bh=otfYBAxDC9mCTFzsHY3Ruh/2/tAdFQGCeCmxu+7yyjU=;
	h=From:To:Cc:Subject:Date;
	b=MtBparv1PN9dGnNEf8z77eB9KA9yUhm2hy2MpmG/idqQ0+eYvfBR1E/kyP8mZvW97
	 ETwLtBeamXMU0DoQ/xy41u9rOYhaNSJUHEjNa9blNY8y5d5j5d3Mg6IhLmurOHqhZ3
	 4/xLV0yxeITbtgw2GBGlX7ZqXpZPmD3YF+D4Zx1U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.112
Date: Sat,  3 Oct 2026 12:53:47 +0200
Message-ID: <2026100348-presuming-alfalfa-c507@gregkh>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.112 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-platform-trackpoint            |    2 
 Documentation/ABI/testing/sysfs-fs-erofs                               |    2 
 Documentation/arch/arm64/booting.rst                                   |    1 
 Documentation/arch/s390/pci.rst                                        |  152 
 Documentation/hwmon/emc1403.rst                                        |    8 
 Documentation/networking/ip-sysctl.rst                                 |    2 
 Documentation/networking/net_cachelines/inet_connection_sock.rst       |    1 
 Documentation/networking/net_cachelines/inet_sock.rst                  |    1 
 Documentation/trace/eprobetrace.rst                                    |  269 +
 Documentation/trace/index.rst                                          |    1 
 Makefile                                                               |    2 
 arch/arm/mach-socfpga/Kconfig                                          |    2 
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi                              |    1 
 arch/arm64/include/asm/el2_setup.h                                     |    8 
 arch/arm64/include/asm/io.h                                            |    3 
 arch/arm64/include/asm/percpu.h                                        |   33 
 arch/arm64/kernel/hibernate-asm.S                                      |    2 
 arch/arm64/kernel/hibernate.c                                          |    4 
 arch/arm64/kvm/emulate-nested.c                                        |    2 
 arch/arm64/kvm/hypercalls.c                                            |    3 
 arch/arm64/kvm/mmu.c                                                   |   15 
 arch/arm64/kvm/vgic/vgic-its.c                                         |  108 
 arch/arm64/kvm/vgic/vgic.h                                             |   23 
 arch/arm64/net/bpf_jit_comp.c                                          |    2 
 arch/mips/cavium-octeon/octeon-platform.c                              |    4 
 arch/mips/net/bpf_jit_comp32.c                                         |    2 
 arch/mips/net/bpf_jit_comp64.c                                         |    3 
 arch/powerpc/kernel/iommu.c                                            |    2 
 arch/powerpc/kvm/book3s_hv_nested.c                                    |    2 
 arch/powerpc/kvm/book3s_hv_uvmem.c                                     |    5 
 arch/riscv/kvm/aia_imsic.c                                             |   11 
 arch/riscv/kvm/vcpu_pmu.c                                              |   33 
 arch/riscv/kvm/vcpu_sbi_hsm.c                                          |    4 
 arch/riscv/kvm/vcpu_timer.c                                            |    5 
 arch/s390/boot/ipl_parm.c                                              |   26 
 arch/s390/boot/string.c                                                |   12 
 arch/s390/include/asm/debug.h                                          |    8 
 arch/s390/kernel/debug.c                                               |   15 
 arch/s390/kvm/interrupt.c                                              |   70 
 arch/s390/kvm/kvm-s390.c                                               |    4 
 arch/x86/entry/entry_fred.c                                            |   11 
 arch/x86/events/intel/core.c                                           |   89 
 arch/x86/events/intel/ds.c                                             |   36 
 arch/x86/events/intel/pt.c                                             |    2 
 arch/x86/events/perf_event.h                                           |    2 
 arch/x86/include/asm/kvm_host.h                                        |    4 
 arch/x86/kernel/cpu/mce/core.c                                         |   27 
 arch/x86/kernel/cpu/microcode/intel.c                                  |   26 
 arch/x86/kvm/Makefile                                                  |    2 
 arch/x86/kvm/mmu/mmu.c                                                 |   60 
 arch/x86/kvm/pmu.c                                                     |    8 
 arch/x86/kvm/regs.c                                                    |  872 +++
 arch/x86/kvm/vmx/pmu_intel.c                                           |    3 
 arch/x86/kvm/x86.c                                                     |  900 ---
 arch/x86/kvm/x86.h                                                     |   28 
 arch/x86/pci/fixup.c                                                   |   99 
 drivers/ata/libahci.c                                                  |   15 
 drivers/ata/libahci_platform.c                                         |    2 
 drivers/ata/libata-scsi.c                                              |   10 
 drivers/base/core.c                                                    |  129 
 drivers/block/sunvdc.c                                                 |    9 
 drivers/bluetooth/btintel_pcie.c                                       |   18 
 drivers/bluetooth/btmtk.c                                              |    7 
 drivers/bluetooth/btmtksdio.c                                          |    4 
 drivers/bluetooth/btusb.c                                              |   17 
 drivers/char/hw_random/atmel-rng.c                                     |    2 
 drivers/char/hw_random/cctrng.c                                        |    2 
 drivers/char/hw_random/exynos-trng.c                                   |    2 
 drivers/char/hw_random/ingenic-rng.c                                   |    2 
 drivers/char/hw_random/ks-sa-rng.c                                     |    2 
 drivers/char/hw_random/mxc-rnga.c                                      |    2 
 drivers/char/hw_random/n2-drv.c                                        |    2 
 drivers/char/hw_random/npcm-rng.c                                      |    2 
 drivers/char/hw_random/omap-rng.c                                      |    2 
 drivers/char/hw_random/stm32-rng.c                                     |   11 
 drivers/char/hw_random/timeriomem-rng.c                                |    2 
 drivers/char/hw_random/xgene-rng.c                                     |    2 
 drivers/clk/clk-scpi.c                                                 |    2 
 drivers/clk/qcom/gcc-qcm2290.c                                         |    6 
 drivers/clk/qcom/gcc-sm6115.c                                          |    6 
 drivers/dma-buf/dma-heap.c                                             |   80 
 drivers/dma/dmaengine.c                                                |   40 
 drivers/dma/mmp_pdma.c                                                 |    2 
 drivers/dma/sprd-dma.c                                                 |    3 
 drivers/dma/sun6i-dma.c                                                |    9 
 drivers/dma/ti/k3-udma-glue.c                                          |    5 
 drivers/dma/xilinx/xilinx_dma.c                                        |   26 
 drivers/dpll/dpll_netlink.c                                            |    3 
 drivers/edac/altera_edac.c                                             |  115 
 drivers/edac/altera_edac.h                                             |    1 
 drivers/firmware/arm_scpi.c                                            |    4 
 drivers/firmware/qcom/qcom_scm.c                                       |   44 
 drivers/firmware/sysfb_simplefb.c                                      |   31 
 drivers/gpio/gpio-arizona.c                                            |    8 
 drivers/gpio/gpio-tps65219.c                                           |    2 
 drivers/gpio/gpio-virtuser.c                                           |    3 
 drivers/gpio/gpio-zynq.c                                               |   10 
 drivers/gpio/gpiolib-cdev.c                                            |   30 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                               |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                             |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                       |   20 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                 |   18 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                            |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                             |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c                            |   36 
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c                              |   25 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c                                |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h                               |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c                               |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h                               |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c                           |  459 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c                                |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                                 |    1 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c                                 |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                      |    4 
 drivers/gpu/drm/amd/display/dc/dml/Makefile                            |    6 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c          |    1 
 drivers/gpu/drm/armada/armada_fbdev.c                                  |    4 
 drivers/gpu/drm/bridge/samsung-dsim.c                                  |    2 
 drivers/gpu/drm/bridge/tc358768.c                                      |   15 
 drivers/gpu/drm/drm_atomic_uapi.c                                      |   13 
 drivers/gpu/drm/drm_client.c                                           |    4 
 drivers/gpu/drm/drm_fb_helper.c                                        |   24 
 drivers/gpu/drm/drm_fbdev_client.c                                     |   14 
 drivers/gpu/drm/drm_fbdev_dma.c                                        |    4 
 drivers/gpu/drm/drm_fbdev_shmem.c                                      |    4 
 drivers/gpu/drm/drm_fbdev_ttm.c                                        |    4 
 drivers/gpu/drm/drm_file.c                                             |   12 
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c                              |    4 
 drivers/gpu/drm/gma500/fbdev.c                                         |    4 
 drivers/gpu/drm/gud/gud_pipe.c                                         |    4 
 drivers/gpu/drm/i915/display/intel_connector.c                         |    4 
 drivers/gpu/drm/i915/display/intel_cursor.c                            |    7 
 drivers/gpu/drm/i915/display/intel_ddi.c                               |    4 
 drivers/gpu/drm/i915/display/intel_display_debugfs.c                   |    8 
 drivers/gpu/drm/i915/display/intel_display_types.h                     |   20 
 drivers/gpu/drm/i915/display/intel_dp.c                                |   36 
 drivers/gpu/drm/i915/display/intel_dp_hdcp.c                           |    6 
 drivers/gpu/drm/i915/display/intel_dp_link_training.c                  |    4 
 drivers/gpu/drm/i915/display/intel_dp_mst.c                            |  155 
 drivers/gpu/drm/i915/display/intel_fbdev.c                             |    8 
 drivers/gpu/drm/i915/display/intel_hdcp.c                              |    8 
 drivers/gpu/drm/i915/display/intel_psr.c                               |   39 
 drivers/gpu/drm/i915/display/skl_universal_plane.c                     |    9 
 drivers/gpu/drm/i915/gem/i915_gem_object.c                             |    2 
 drivers/gpu/drm/imagination/pvr_free_list.c                            |   15 
 drivers/gpu/drm/imagination/pvr_mmu.c                                  |   19 
 drivers/gpu/drm/imagination/pvr_mmu.h                                  |    2 
 drivers/gpu/drm/imagination/pvr_vm.c                                   |    4 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                                |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c                             |    1 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                     |   36 
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                                    |    8 
 drivers/gpu/drm/msm/msm_fbdev.c                                        |    4 
 drivers/gpu/drm/nouveau/nouveau_bo.c                                   |    3 
 drivers/gpu/drm/nouveau/nouveau_connector.c                            |    5 
 drivers/gpu/drm/nouveau/nouveau_drm.c                                  |    5 
 drivers/gpu/drm/nouveau/nouveau_gem.c                                  |    2 
 drivers/gpu/drm/nouveau/nouveau_sched.c                                |    2 
 drivers/gpu/drm/nouveau/nouveau_sched.h                                |    1 
 drivers/gpu/drm/nouveau/nouveau_uvmm.c                                 |   13 
 drivers/gpu/drm/nouveau/nvif/vmm.c                                     |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c                       |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h                        |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c                        |    8 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c                       |    3 
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c                         |   23 
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c                       |    2 
 drivers/gpu/drm/omapdrm/omap_fbdev.c                                   |    4 
 drivers/gpu/drm/radeon/radeon_fbdev.c                                  |    4 
 drivers/gpu/drm/tegra/fbdev.c                                          |    4 
 drivers/gpu/drm/tiny/ofdrm.c                                           |    8 
 drivers/gpu/drm/tiny/simpledrm.c                                       |   61 
 drivers/gpu/drm/vc4/vc4_kms.c                                          |    2 
 drivers/gpu/drm/virtio/virtgpu_gem.c                                   |    2 
 drivers/gpu/drm/virtio/virtgpu_ioctl.c                                 |    6 
 drivers/gpu/drm/virtio/virtgpu_submit.c                                |   11 
 drivers/gpu/drm/virtio/virtgpu_vram.c                                  |   17 
 drivers/gpu/drm/xe/instructions/xe_gpu_commands.h                      |    1 
 drivers/gpu/drm/xe/xe_bo.h                                             |   19 
 drivers/gpu/drm/xe/xe_ring_ops.c                                       |   16 
 drivers/gpu/drm/xe/xe_vm.c                                             |   29 
 drivers/hid/amd-sfh-hid/amd_sfh_common.h                               |    4 
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c                                 |   10 
 drivers/hid/bpf/hid_bpf_dispatch.c                                     |   12 
 drivers/hid/hid-alps.c                                                 |   31 
 drivers/hid/hid-asus.c                                                 |   34 
 drivers/hid/hid-ids.h                                                  |    3 
 drivers/hid/hid-logitech-hidpp.c                                       |   24 
 drivers/hid/hid-quirks.c                                               |    3 
 drivers/hid/wacom_sys.c                                                |    5 
 drivers/hwmon/emc1403.c                                                |   73 
 drivers/hwmon/hp-wmi-sensors.c                                         |    2 
 drivers/hwmon/pmbus/pmbus.h                                            |    3 
 drivers/hwmon/pmbus/tps53679.c                                         |   11 
 drivers/hwmon/pwm-fan.c                                                |   13 
 drivers/hwmon/w83791d.c                                                |    1 
 drivers/hwmon/w83793.c                                                 |    4 
 drivers/i2c/busses/i2c-at91-core.c                                     |    3 
 drivers/i2c/busses/i2c-at91-master.c                                   |   12 
 drivers/i2c/busses/i2c-at91.h                                          |    1 
 drivers/i2c/busses/i2c-imx.c                                           |    3 
 drivers/i2c/busses/i2c-mxs.c                                           |    5 
 drivers/i2c/busses/i2c-qcom-cci.c                                      |   37 
 drivers/i2c/busses/i2c-qcom-geni.c                                     |   33 
 drivers/i2c/i2c-atr.c                                                  |    1 
 drivers/i3c/master.c                                                   |   20 
 drivers/infiniband/core/iwpm_util.c                                    |    9 
 drivers/infiniband/core/mad.c                                          |    3 
 drivers/infiniband/core/ucma.c                                         |    7 
 drivers/infiniband/core/verbs.c                                        |   12 
 drivers/infiniband/hw/efa/efa_com.c                                    |    7 
 drivers/infiniband/hw/efa/efa_com.h                                    |    1 
 drivers/infiniband/hw/efa/efa_main.c                                   |   33 
 drivers/infiniband/hw/hfi1/file_ops.c                                  |   23 
 drivers/infiniband/hw/irdma/verbs.c                                    |    2 
 drivers/infiniband/hw/mlx4/sysfs.c                                     |    4 
 drivers/infiniband/sw/rxe/rxe_mcast.c                                  |   50 
 drivers/infiniband/sw/rxe/rxe_mr.c                                     |    3 
 drivers/infiniband/sw/rxe/rxe_verbs.c                                  |   13 
 drivers/infiniband/sw/siw/siw_cm.c                                     |    7 
 drivers/infiniband/sw/siw/siw_qp_rx.c                                  |    2 
 drivers/infiniband/ulp/ipoib/ipoib.h                                   |    7 
 drivers/infiniband/ulp/ipoib/ipoib_ib.c                                |   12 
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c                         |   16 
 drivers/infiniband/ulp/iser/iser_initiator.c                           |   16 
 drivers/infiniband/ulp/isert/ib_isert.c                                |   22 
 drivers/infiniband/ulp/isert/ib_isert.h                                |    2 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                                 |    8 
 drivers/infiniband/ulp/rtrs/rtrs-clt.h                                 |    2 
 drivers/input/evdev.c                                                  |    2 
 drivers/input/input-compat.c                                           |    2 
 drivers/input/joystick/xpad.c                                          |   10 
 drivers/input/keyboard/adp5588-keys.c                                  |   12 
 drivers/input/keyboard/atkbd.c                                         |    8 
 drivers/input/misc/soc_button_array.c                                  |   16 
 drivers/input/mouse/synaptics.c                                        |    8 
 drivers/input/rmi4/rmi_driver.c                                        |   13 
 drivers/input/rmi4/rmi_smbus.c                                         |   10 
 drivers/input/serio/hp_sdc.c                                           |    2 
 drivers/input/serio/i8042-acpipnpio.h                                  |    7 
 drivers/input/touchscreen/cyttsp5.c                                    |    1 
 drivers/iommu/iommufd/device.c                                         |   70 
 drivers/iommu/iommufd/hw_pagetable.c                                   |   13 
 drivers/iommu/iommufd/iommufd_private.h                                |    8 
 drivers/iommu/iommufd/selftest.c                                       |   20 
 drivers/iommu/msm_iommu.c                                              |   55 
 drivers/media/i2c/imx355.c                                             |   62 
 drivers/media/i2c/video-i2c.c                                          |    5 
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c               |   12 
 drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h             |    1 
 drivers/memstick/core/ms_block.c                                       |    2 
 drivers/mmc/core/bus.c                                                 |    2 
 drivers/mmc/core/host.c                                                |    1 
 drivers/mmc/core/sdio_uart.c                                           |    3 
 drivers/mmc/host/mmc_hsq.c                                             |    8 
 drivers/mmc/host/mmc_spi.c                                             |    1 
 drivers/mmc/host/mmci.c                                                |    3 
 drivers/mmc/host/mxcmmc.c                                              |    4 
 drivers/mmc/host/rtsx_pci_sdmmc.c                                      |    5 
 drivers/mmc/host/sdhci-of-aspeed.c                                     |    5 
 drivers/mmc/host/sdhci_am654.c                                         |   43 
 drivers/mmc/host/sh_mmcif.c                                            |    3 
 drivers/mmc/host/via-sdmmc.c                                           |    4 
 drivers/mtd/nand/raw/pl35x-nand-controller.c                           |   10 
 drivers/net/bonding/bond_main.c                                        |    2 
 drivers/net/dsa/mt7530-mdio.c                                          |   20 
 drivers/net/ethernet/amazon/ena/ena_com.c                              |   25 
 drivers/net/ethernet/amazon/ena/ena_com.h                              |   14 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                           |    1 
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c                        |    3 
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c                        |    3 
 drivers/net/ethernet/atheros/atlx/atl1.c                               |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                              |   82 
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                              |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                          |    6 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h                          |    2 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                         |   63 
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                         |    5 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c                     |   20 
 drivers/net/ethernet/broadcom/tg3.c                                    |   15 
 drivers/net/ethernet/brocade/bna/bnad.c                                |   16 
 drivers/net/ethernet/cadence/macb_main.c                               |   13 
 drivers/net/ethernet/cadence/macb_ptp.c                                |   20 
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c            |    4 
 drivers/net/ethernet/cortina/gemini.c                                  |    2 
 drivers/net/ethernet/freescale/fman/fman.c                             |    1 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c                      |    3 
 drivers/net/ethernet/intel/idpf/idpf.h                                 |   24 
 drivers/net/ethernet/intel/idpf/idpf_dev.c                             |   10 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                             |   35 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                            |  301 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.h                            |   14 
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c                          |   10 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                        |   20 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h                        |    3 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                        |    3 
 drivers/net/ethernet/marvell/octeontx2/af/common.h                     |   45 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                            |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c                |   45 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c                     |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c              |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                      |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                        |   39 
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c                   |   15 
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h                   |    2 
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c                   |    5 
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h                            |    1 
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c                             |    9 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c                           |    2 
 drivers/net/ethernet/microchip/lan743x_main.c                          |    2 
 drivers/net/ethernet/netronome/nfp/crypto/ipsec.c                      |    3 
 drivers/net/ethernet/socionext/netsec.c                                |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c                         |    5 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c                     |    4 
 drivers/net/ethernet/stmicro/stmmac/hwif.h                             |    4 
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c                        |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c                   |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c                 |  106 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                        |   19 
 drivers/net/ethernet/ti/cpsw.c                                         |   41 
 drivers/net/ethernet/ti/cpsw_new.c                                     |   35 
 drivers/net/ethernet/ti/cpsw_priv.h                                    |    1 
 drivers/net/ethernet/ti/netcp_core.c                                   |    2 
 drivers/net/fddi/skfp/skfddi.c                                         |    3 
 drivers/net/pcs/pcs-xpcs.c                                             |    4 
 drivers/net/phy/mediatek/mtk-ge-soc.c                                  |   23 
 drivers/net/usb/catc.c                                                 |   15 
 drivers/net/usb/cdc_mbim.c                                             |    5 
 drivers/net/usb/lan78xx.c                                              |    2 
 drivers/net/usb/sr9700.c                                               |    3 
 drivers/net/veth.c                                                     |    2 
 drivers/net/virtio_net.c                                               |    9 
 drivers/net/vrf.c                                                      |    2 
 drivers/net/vxlan/vxlan_core.c                                         |    6 
 drivers/net/wireless/ath/ath11k/mac.c                                  |   25 
 drivers/net/wireless/ath/wcn36xx/dxe.c                                 |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c                |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c         |    4 
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c                         |    6 
 drivers/net/wireless/intel/iwlegacy/common.c                           |    2 
 drivers/net/wireless/intersil/p54/eeprom.c                             |   22 
 drivers/net/wireless/marvell/libertas_tf/main.c                        |    2 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c                        |   12 
 drivers/net/wireless/marvell/mwifiex/pcie.c                            |    2 
 drivers/net/wireless/marvell/mwifiex/scan.c                            |   54 
 drivers/net/wireless/marvell/mwifiex/util.c                            |   10 
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c                    |    5 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                     |   33 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h                     |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                       |    7 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                        |   15 
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                     |    3 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                        |    8 
 drivers/net/wireless/microchip/wilc1000/cfg80211.c                     |   14 
 drivers/net/wireless/microchip/wilc1000/wlan.c                         |    9 
 drivers/net/wireless/realtek/rtw88/fw.c                                |    8 
 drivers/net/wireless/realtek/rtw88/tx.c                                |    2 
 drivers/net/wireless/realtek/rtw89/core.h                              |    3 
 drivers/net/wireless/realtek/rtw89/mac.c                               |   13 
 drivers/net/wireless/realtek/rtw89/mac80211.c                          |    3 
 drivers/net/wireless/realtek/rtw89/pci.c                               |   13 
 drivers/net/wireless/realtek/rtw89/pci.h                               |    1 
 drivers/net/wireless/realtek/rtw89/phy.c                               |    3 
 drivers/net/wireless/realtek/rtw89/rtw8851be.c                         |    1 
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c                         |    1 
 drivers/net/wireless/realtek/rtw89/rtw8852be.c                         |    1 
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c                        |    1 
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c                         |    1 
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c                         |    1 
 drivers/net/wireless/rsi/rsi_91x_mgmt.c                                |    2 
 drivers/net/wireless/ti/wlcore/main.c                                  |    4 
 drivers/net/wireless/virtual/mac80211_hwsim.c                          |   39 
 drivers/net/wireless/virtual/virt_wifi.c                               |    4 
 drivers/net/wwan/mhi_wwan_mbim.c                                       |   28 
 drivers/net/wwan/t7xx/t7xx_netdev.c                                    |    4 
 drivers/nfc/microread/microread.c                                      |    6 
 drivers/nfc/nfcmrvl/fw_dnld.c                                          |   11 
 drivers/nfc/pn533/pn533.c                                              |   14 
 drivers/nfc/pn533/pn533.h                                              |    4 
 drivers/nfc/pn533/usb.c                                                |    4 
 drivers/nfc/pn544/pn544.c                                              |    7 
 drivers/nfc/port100.c                                                  |    7 
 drivers/nfc/st21nfca/core.c                                            |   12 
 drivers/nfc/st21nfca/i2c.c                                             |   29 
 drivers/nfc/virtual_ncidev.c                                           |    3 
 drivers/nvdimm/nd_virtio.c                                             |  125 
 drivers/nvdimm/pmem.c                                                  |   15 
 drivers/nvdimm/region_devs.c                                           |    5 
 drivers/nvdimm/virtio_pmem.c                                           |   14 
 drivers/nvdimm/virtio_pmem.h                                           |    6 
 drivers/nvme/host/core.c                                               |   83 
 drivers/nvme/host/nvme.h                                               |    2 
 drivers/pci/controller/plda/pcie-starfive.c                            |   36 
 drivers/pci/hotplug/pnv_php.c                                          |    2 
 drivers/pci/hotplug/rpaphp_slot.c                                      |    2 
 drivers/pci/of_property.c                                              |   11 
 drivers/pci/pci.c                                                      |    5 
 drivers/pci/rebar.c                                                    |   19 
 drivers/pci/setup-bus.c                                                |   56 
 drivers/pci/slot.c                                                     |   67 
 drivers/perf/arm-cmn.c                                                 |   10 
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c                             |    4 
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h                             |    3 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                               |  302 +
 drivers/pinctrl/meson/pinctrl-meson-s4.c                               |    2 
 drivers/pinctrl/pinctrl-single.c                                       |    3 
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                                  |   76 
 drivers/pinctrl/sunxi/pinctrl-sunxi.h                                  |    7 
 drivers/platform/x86/amd/pmc/Makefile                                  |    2 
 drivers/platform/x86/amd/pmc/mp1_stb.c                                 |  316 +
 drivers/platform/x86/amd/pmc/pmc.c                                     |  314 -
 drivers/platform/x86/amd/pmc/pmc.h                                     |   18 
 drivers/platform/x86/intel/int1092/intel_sar.c                         |   39 
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c            |   14 
 drivers/platform/x86/think-lmi.c                                       |   45 
 drivers/platform/x86/think-lmi.h                                       |    2 
 drivers/power/sequencing/core.c                                        |   11 
 drivers/power/supply/ab8500_fg.c                                       |   32 
 drivers/power/supply/qcom_battmgr.c                                    |    8 
 drivers/remoteproc/qcom_q6v5_adsp.c                                    |    8 
 drivers/remoteproc/qcom_q6v5_pas.c                                     |   93 
 drivers/rtc/rtc-rzn1.c                                                 |   16 
 drivers/s390/cio/chp.c                                                 |    3 
 drivers/s390/cio/cio.c                                                 |   11 
 drivers/s390/cio/cio.h                                                 |    5 
 drivers/s390/cio/cmf.c                                                 |    2 
 drivers/s390/cio/device.c                                              |    9 
 drivers/s390/cio/device_fsm.c                                          |    3 
 drivers/s390/cio/device_ops.c                                          |   23 
 drivers/s390/cio/vfio_ccw_fsm.c                                        |    2 
 drivers/s390/crypto/vfio_ap_ops.c                                      |   44 
 drivers/scsi/fnic/fnic.h                                               |    2 
 drivers/scsi/fnic/fnic_isr.c                                           |   13 
 drivers/scsi/fnic/fnic_main.c                                          |   33 
 drivers/scsi/libiscsi_tcp.c                                            |    3 
 drivers/scsi/megaraid/megaraid_sas_base.c                              |    4 
 drivers/scsi/qla2xxx/qla_bsg.c                                         |   47 
 drivers/scsi/qla2xxx/qla_def.h                                         |    2 
 drivers/scsi/qla2xxx/qla_fw.h                                          |    4 
 drivers/scsi/qla2xxx/qla_init.c                                        |   14 
 drivers/scsi/qla2xxx/qla_iocb.c                                        |   23 
 drivers/scsi/qla2xxx/qla_isr.c                                         |   33 
 drivers/scsi/qla2xxx/qla_mbx.c                                         |    6 
 drivers/scsi/qla2xxx/qla_mid.c                                         |   49 
 drivers/scsi/qla2xxx/qla_nvme.c                                        |   10 
 drivers/scsi/qla2xxx/qla_os.c                                          |   17 
 drivers/scsi/scsi.c                                                    |   24 
 drivers/scsi/sd_zbc.c                                                  |    8 
 drivers/soc/qcom/mdt_loader.c                                          |    4 
 drivers/soundwire/cadence_master.c                                     |    7 
 drivers/spi/spi-zynqmp-gqspi.c                                         |   34 
 drivers/staging/media/rkvdec/rkvdec.c                                  |    4 
 drivers/staging/rtl8723bs/core/rtw_mlme.c                              |    5 
 drivers/staging/sm750fb/sm750.c                                        |    2 
 drivers/staging/sm750fb/sm750.h                                        |    2 
 drivers/staging/sm750fb/sm750_accel.c                                  |    6 
 drivers/staging/sm750fb/sm750_accel.h                                  |    4 
 drivers/thermal/gov_step_wise.c                                        |   10 
 drivers/usb/cdns3/cdns3-gadget.c                                       |    4 
 drivers/usb/cdns3/cdnsp-gadget.c                                       |  112 
 drivers/usb/cdns3/cdnsp-gadget.h                                       |    1 
 drivers/usb/cdns3/cdnsp-mem.c                                          |   98 
 drivers/usb/cdns3/core.h                                               |    2 
 drivers/usb/dwc3/core.h                                                |    3 
 drivers/usb/dwc3/ep0.c                                                 |    2 
 drivers/usb/dwc3/gadget.c                                              |  129 
 drivers/usb/gadget/function/f_mass_storage.c                           |    3 
 drivers/usb/host/xhci-pci.c                                            |    8 
 drivers/usb/storage/realtek_cr.c                                       |    9 
 drivers/usb/typec/tcpm/tcpm.c                                          |   39 
 drivers/video/screen_info_generic.c                                    |   36 
 drivers/virtio/virtio_mmio.c                                           |   66 
 drivers/watchdog/da9063_wdt.c                                          |    4 
 drivers/watchdog/digicolor_wdt.c                                       |   13 
 drivers/watchdog/msc313e_wdt.c                                         |   16 
 drivers/watchdog/rtd119x_wdt.c                                         |    7 
 drivers/watchdog/sp5100_tco.c                                          |    6 
 drivers/watchdog/starfive-wdt.c                                        |    2 
 fs/9p/vfs_addr.c                                                       |   12 
 fs/autofs/inode.c                                                      |    4 
 fs/btrfs/dev-replace.c                                                 |    1 
 fs/btrfs/file.c                                                        |    4 
 fs/btrfs/tree-checker.c                                                |    2 
 fs/configfs/dir.c                                                      |   13 
 fs/configfs/symlink.c                                                  |   51 
 fs/erofs/fscache.c                                                     |    2 
 fs/erofs/sysfs.c                                                       |    2 
 fs/exec.c                                                              |   29 
 fs/f2fs/debug.c                                                        |    4 
 fs/f2fs/dir.c                                                          |    7 
 fs/f2fs/f2fs.h                                                         |   29 
 fs/f2fs/file.c                                                         |   47 
 fs/f2fs/gc.c                                                           |   51 
 fs/f2fs/gc.h                                                           |   25 
 fs/f2fs/inline.c                                                       |    2 
 fs/f2fs/namei.c                                                        |    6 
 fs/f2fs/node.c                                                         |   22 
 fs/f2fs/recovery.c                                                     |   41 
 fs/f2fs/segment.c                                                      |    9 
 fs/f2fs/super.c                                                        |    4 
 fs/f2fs/sysfs.c                                                        |   18 
 fs/fs-writeback.c                                                      |   25 
 fs/kernfs/mount.c                                                      |    4 
 fs/lockd/svcsubs.c                                                     |    2 
 fs/ntfs3/inode.c                                                       |    7 
 fs/ocfs2/namei.c                                                       |    9 
 fs/ocfs2/xattr.c                                                       |   13 
 fs/ocfs2/xattr.h                                                       |    8 
 fs/pidfs.c                                                             |   43 
 fs/smb/client/cached_dir.c                                             |   32 
 fs/smb/client/cifs_fs_sb.h                                             |    1 
 fs/smb/client/cifsacl.c                                                |   69 
 fs/smb/client/cifsfs.c                                                 |   12 
 fs/smb/client/cifsglob.h                                               |   12 
 fs/smb/client/cifsproto.h                                              |    8 
 fs/smb/client/cifssmb.c                                                |    2 
 fs/smb/client/connect.c                                                |   10 
 fs/smb/client/file.c                                                   |   11 
 fs/smb/client/misc.c                                                   |   12 
 fs/smb/client/reparse.c                                                |    4 
 fs/smb/client/reparse.h                                                |    7 
 fs/smb/client/sess.c                                                   |  108 
 fs/smb/client/smb2inode.c                                              |   11 
 fs/smb/client/smb2ops.c                                                |   78 
 fs/smb/client/smb2pdu.c                                                |   64 
 fs/smb/client/transport.c                                              |    4 
 fs/smb/server/smb2pdu.c                                                |   89 
 fs/smb/server/smb2pdu.h                                                |    1 
 fs/squashfs/xz_wrapper.c                                               |    6 
 fs/super.c                                                             |   43 
 fs/udf/inode.c                                                         |  129 
 fs/xfs/libxfs/xfs_da_btree.c                                           |    2 
 fs/xfs/libxfs/xfs_da_btree.h                                           |    2 
 fs/xfs/scrub/attr_repair.c                                             |    4 
 fs/xfs/scrub/dir_repair.c                                              |   23 
 fs/xfs/scrub/health.c                                                  |    6 
 fs/xfs/scrub/inode.c                                                   |    2 
 fs/xfs/scrub/inode_repair.c                                            |    2 
 fs/xfs/scrub/orphanage.c                                               |    6 
 fs/xfs/scrub/reap.c                                                    |    2 
 fs/xfs/scrub/refcount.c                                                |    8 
 fs/xfs/scrub/scrub.h                                                   |    2 
 fs/xfs/scrub/stats.c                                                   |    1 
 fs/xfs/scrub/tempfile.c                                                |   29 
 fs/xfs/xfs_exchrange.c                                                 |   13 
 fs/xfs/xfs_icache.c                                                    |    2 
 fs/xfs/xfs_inode.h                                                     |    3 
 include/drm/drm_client.h                                               |   10 
 include/drm/drm_fb_helper.h                                            |   11 
 include/drm/drm_file.h                                                 |    1 
 include/keys/request_key_auth-type.h                                   |    2 
 include/linux/bpf_mem_alloc.h                                          |    6 
 include/linux/compiler-context-analysis.h                              |   32 
 include/linux/compiler_types.h                                         |   18 
 include/linux/dev_printk.h                                             |    1 
 include/linux/dmaengine.h                                              |    7 
 include/linux/firmware/qcom/qcom_scm.h                                 |   20 
 include/linux/ftrace.h                                                 |    5 
 include/linux/if_vlan.h                                                |    3 
 include/linux/ipv6.h                                                   |   38 
 include/linux/libnvdimm.h                                              |    9 
 include/linux/lockd/lockd.h                                            |    2 
 include/linux/pci.h                                                    |   14 
 include/linux/perf_event.h                                             |    1 
 include/linux/rculist.h                                                |   29 
 include/linux/sched.h                                                  |   16 
 include/linux/sched/rt.h                                               |    2 
 include/linux/sched/signal.h                                           |    5 
 include/linux/screen_info.h                                            |    2 
 include/linux/skbuff.h                                                 |   24 
 include/linux/soc/qcom/mdt_loader.h                                    |    6 
 include/linux/virtio.h                                                 |    2 
 include/net/bluetooth/coredump.h                                       |    2 
 include/net/cfg80211.h                                                 |   25 
 include/net/gue.h                                                      |   19 
 include/net/if_inet6.h                                                 |    2 
 include/net/inet_connection_sock.h                                     |   11 
 include/net/inet_sock.h                                                |    1 
 include/net/ip6_route.h                                                |    8 
 include/net/mac80211.h                                                 |    5 
 include/net/netfilter/nf_conntrack.h                                   |    5 
 include/net/netfilter/nf_conntrack_timeout.h                           |   27 
 include/net/netfilter/nf_tables.h                                      |    2 
 include/net/netmem.h                                                   |   78 
 include/net/netns/xfrm.h                                               |    2 
 include/net/nfc/hci.h                                                  |    2 
 include/net/nfc/nfc.h                                                  |    3 
 include/net/page_pool/helpers.h                                        |   35 
 include/net/page_pool/types.h                                          |    5 
 include/net/rose.h                                                     |   12 
 include/net/sock.h                                                     |    8 
 include/net/tcp.h                                                      |    4 
 include/sound/soc.h                                                    |    3 
 include/uapi/linux/landlock.h                                          |   37 
 include/uapi/linux/nl80211.h                                           |    5 
 init/main.c                                                            |   27 
 io_uring/net.c                                                         |   41 
 io_uring/rw.c                                                          |   32 
 io_uring/waitid.c                                                      |   44 
 kernel/bpf/arraymap.c                                                  |    6 
 kernel/bpf/btf.c                                                       |  136 
 kernel/bpf/crypto.c                                                    |    5 
 kernel/bpf/hashtab.c                                                   |  228 
 kernel/bpf/memalloc.c                                                  |  106 
 kernel/bpf/offload.c                                                   |    2 
 kernel/bpf/syscall.c                                                   |    5 
 kernel/cgroup/pids.c                                                   |    5 
 kernel/dma/coherent.c                                                  |   13 
 kernel/dma/swiotlb.c                                                   |    4 
 kernel/events/core.c                                                   |   15 
 kernel/events/ring_buffer.c                                            |   29 
 kernel/futex/pi.c                                                      |   10 
 kernel/locking/rtmutex_api.c                                           |    2 
 kernel/reboot.c                                                        |   55 
 kernel/sched/core.c                                                    |   77 
 kernel/sched/sched.h                                                   |    9 
 kernel/signal.c                                                        |   24 
 kernel/sysctl.c                                                        |   31 
 kernel/trace/ftrace.c                                                  |   57 
 kernel/trace/ring_buffer.c                                             |  135 
 kernel/trace/trace.c                                                   |  155 
 kernel/trace/trace.h                                                   |  131 
 kernel/trace/trace_btf.c                                               |   31 
 kernel/trace/trace_btf.h                                               |    3 
 kernel/trace/trace_eprobe.c                                            |   19 
 kernel/trace/trace_events_hist.c                                       |  167 
 kernel/trace/trace_events_trigger.c                                    |  344 -
 kernel/trace/trace_functions.c                                         |    2 
 kernel/trace/trace_probe.c                                             |    5 
 kernel/trace/trace_stack.c                                             |    2 
 kernel/workqueue.c                                                     |    2 
 mm/backing-dev.c                                                       |    5 
 mm/damon/vaddr.c                                                       |    1 
 mm/huge_memory.c                                                       |   10 
 mm/hugetlb.c                                                           |   55 
 mm/khugepaged.c                                                        |    6 
 mm/madvise.c                                                           |    8 
 mm/memblock.c                                                          |   18 
 mm/mlock.c                                                             |    2 
 mm/mremap.c                                                            |   12 
 mm/rmap.c                                                              |   23 
 mm/vma.c                                                               |    8 
 net/8021q/vlan_dev.c                                                   |    5 
 net/atm/pppoatm.c                                                      |   42 
 net/bluetooth/bnep/core.c                                              |   17 
 net/bluetooth/bnep/netdev.c                                            |    8 
 net/bluetooth/coredump.c                                               |   65 
 net/bluetooth/eir.c                                                    |   10 
 net/bluetooth/hci_codec.c                                              |   36 
 net/bluetooth/hci_conn.c                                               |   14 
 net/bluetooth/hci_core.c                                               |   26 
 net/bluetooth/hci_sock.c                                               |   20 
 net/bluetooth/hci_sync.c                                               |    2 
 net/bluetooth/iso.c                                                    |   53 
 net/bluetooth/l2cap_core.c                                             |   10 
 net/bluetooth/mgmt.c                                                   |   27 
 net/bluetooth/rfcomm/core.c                                            |    3 
 net/bluetooth/rfcomm/sock.c                                            |   19 
 net/bluetooth/smp.c                                                    |   17 
 net/bridge/br_cfm.c                                                    |   11 
 net/bridge/br_device.c                                                 |    1 
 net/bridge/br_input.c                                                  |   35 
 net/bridge/br_mdb.c                                                    |    2 
 net/bridge/br_mrp.c                                                    |   13 
 net/bridge/br_mst.c                                                    |   20 
 net/bridge/br_private.h                                                |   26 
 net/bridge/br_stp_bpdu.c                                               |    5 
 net/core/dev.c                                                         |    2 
 net/core/devmem.c                                                      |    1 
 net/core/drop_monitor.c                                                |    4 
 net/core/filter.c                                                      |   46 
 net/core/page_pool.c                                                   |    9 
 net/core/skbuff.c                                                      |   41 
 net/core/skmsg.c                                                       |    4 
 net/core/sock.c                                                        |   25 
 net/core/sock_map.c                                                    |    1 
 net/dccp/ipv6.c                                                        |    4 
 net/dccp/timer.c                                                       |    4 
 net/ipv4/arp.c                                                         |    1 
 net/ipv4/esp4.c                                                        |    6 
 net/ipv4/fou_core.c                                                    |    4 
 net/ipv4/icmp.c                                                        |   17 
 net/ipv4/inet_connection_sock.c                                        |   13 
 net/ipv4/inet_diag.c                                                   |    4 
 net/ipv4/ip_gre.c                                                      |   12 
 net/ipv4/ipconfig.c                                                    |   92 
 net/ipv4/ipmr.c                                                        |    3 
 net/ipv4/ipmr_base.c                                                   |    2 
 net/ipv4/sysctl_net_ipv4.c                                             |    4 
 net/ipv4/tcp_input.c                                                   |    3 
 net/ipv4/tcp_ipv4.c                                                    |    4 
 net/ipv4/tcp_output.c                                                  |    3 
 net/ipv4/tcp_timer.c                                                   |    5 
 net/ipv4/xfrm4_input.c                                                 |    2 
 net/ipv6/addrconf.c                                                    |    3 
 net/ipv6/af_inet6.c                                                    |    2 
 net/ipv6/esp6.c                                                        |    6 
 net/ipv6/exthdrs_core.c                                                |    3 
 net/ipv6/inet6_connection_sock.c                                       |    2 
 net/ipv6/ip6_flowlabel.c                                               |   67 
 net/ipv6/ip6_gre.c                                                     |    2 
 net/ipv6/ip6_output.c                                                  |    3 
 net/ipv6/ip6mr.c                                                       |    2 
 net/ipv6/ipv6_sockglue.c                                               |    9 
 net/ipv6/mcast.c                                                       |  253 
 net/ipv6/netfilter/ip6t_rpfilter.c                                     |    2 
 net/ipv6/netfilter/ip6t_rt.c                                           |   11 
 net/ipv6/route.c                                                       |   33 
 net/ipv6/seg6.c                                                        |    4 
 net/ipv6/seg6_local.c                                                  |    3 
 net/ipv6/tcp_ipv6.c                                                    |   21 
 net/ipv6/xfrm6_input.c                                                 |    2 
 net/ipv6/xfrm6_output.c                                                |   10 
 net/llc/llc_c_ac.c                                                     |    2 
 net/llc/llc_s_ac.c                                                     |    4 
 net/llc/llc_sap.c                                                      |    8 
 net/mac80211/cfg.c                                                     |   55 
 net/mac80211/debugfs.c                                                 |    2 
 net/mac80211/debugfs_netdev.c                                          |    9 
 net/mac80211/ieee80211_i.h                                             |    5 
 net/mac80211/iface.c                                                   |   76 
 net/mac80211/main.c                                                    |    4 
 net/mac80211/mesh.c                                                    |   34 
 net/mac80211/offchannel.c                                              |    7 
 net/mac80211/pm.c                                                      |    8 
 net/mac80211/scan.c                                                    |   24 
 net/mac80211/tdls.c                                                    |   19 
 net/mac80211/tx.c                                                      |   66 
 net/mac80211/util.c                                                    |    3 
 net/mctp/route.c                                                       |    2 
 net/mptcp/Makefile                                                     |    2 
 net/mptcp/ctrl.c                                                       |    4 
 net/mptcp/mib.c                                                        |    5 
 net/mptcp/mib.h                                                        |    5 
 net/mptcp/options.c                                                    |    6 
 net/mptcp/pm_kernel.c                                                  | 2610 ++++++++++
 net/mptcp/pm_netlink.c                                                 | 2603 ---------
 net/mptcp/pm_userspace.c                                               |   32 
 net/mptcp/protocol.c                                                   |   85 
 net/mptcp/protocol.h                                                   |   36 
 net/mptcp/subflow.c                                                    |   10 
 net/netfilter/ipvs/ip_vs_core.c                                        |    6 
 net/netfilter/nf_conntrack_core.c                                      |    6 
 net/netfilter/nf_conntrack_netlink.c                                   |    3 
 net/netfilter/nf_conntrack_timeout.c                                   |   27 
 net/netfilter/nf_flow_table_core.c                                     |   12 
 net/netfilter/nf_flow_table_offload.c                                  |    7 
 net/netfilter/nf_tables_api.c                                          |   59 
 net/netfilter/nfnetlink_cttimeout.c                                    |  114 
 net/netfilter/nfnetlink_queue.c                                        |    8 
 net/netfilter/nft_chain_filter.c                                       |   48 
 net/netfilter/nft_ct.c                                                 |    7 
 net/netfilter/nft_nat.c                                                |    2 
 net/netfilter/nft_synproxy.c                                           |    3 
 net/netfilter/xt_CT.c                                                  |    2 
 net/netlink/genetlink.c                                                |   29 
 net/nfc/core.c                                                         |   15 
 net/nfc/digital_dep.c                                                  |    8 
 net/nfc/llcp.h                                                         |    1 
 net/nfc/llcp_commands.c                                                |    2 
 net/nfc/llcp_core.c                                                    |  175 
 net/nfc/llcp_sock.c                                                    |   65 
 net/nfc/nci/core.c                                                     |   10 
 net/nfc/netlink.c                                                      |    7 
 net/nfc/nfc.h                                                          |    3 
 net/openvswitch/conntrack.c                                            |   39 
 net/packet/af_packet.c                                                 |  108 
 net/packet/internal.h                                                  |    2 
 net/rds/ib_cm.c                                                        |    2 
 net/rds/ib_frmr.c                                                      |   11 
 net/rose/af_rose.c                                                     |   25 
 net/rose/rose_in.c                                                     |    6 
 net/rose/rose_loopback.c                                               |   61 
 net/rose/rose_timer.c                                                  |    5 
 net/sched/act_api.c                                                    |   13 
 net/sched/act_ct.c                                                     |   41 
 net/sched/act_gate.c                                                   |   30 
 net/sched/cls_u32.c                                                    |   12 
 net/sched/sch_hfsc.c                                                   |   22 
 net/sched/sch_hhf.c                                                    |    9 
 net/sched/sch_teql.c                                                   |    7 
 net/sctp/associola.c                                                   |   15 
 net/sctp/input.c                                                       |    7 
 net/sctp/ipv6.c                                                        |    8 
 net/sctp/sm_sideeffect.c                                               |   37 
 net/sctp/sm_statefuns.c                                                |    2 
 net/smc/smc.h                                                          |    6 
 net/smc/smc_clc.h                                                      |    2 
 net/smc/smc_core.c                                                     |    4 
 net/smc/smc_core.h                                                     |    4 
 net/smc/smc_ib.c                                                       |   10 
 net/tipc/group.c                                                       |    4 
 net/tipc/monitor.c                                                     |    3 
 net/tls/tls_sw.c                                                       |    6 
 net/wireless/chan.c                                                    |  365 -
 net/wireless/core.c                                                    |    2 
 net/wireless/lib80211_crypt_tkip.c                                     |   13 
 net/wireless/nl80211.c                                                 |   60 
 net/wireless/scan.c                                                    |   22 
 net/wireless/util.c                                                    |   68 
 net/xdp/xskmap.c                                                       |    2 
 net/xfrm/espintcp.c                                                    |    6 
 net/xfrm/xfrm_input.c                                                  |   63 
 net/xfrm/xfrm_state.c                                                  |    9 
 net/xfrm/xfrm_user.c                                                   |   37 
 security/ipe/eval.c                                                    |   12 
 security/ipe/eval.h                                                    |    2 
 security/ipe/fs.c                                                      |    4 
 security/ipe/hooks.c                                                   |   22 
 security/ipe/policy_fs.c                                               |    4 
 security/keys/encrypted-keys/encrypted.c                               |   20 
 security/keys/gc.c                                                     |    4 
 security/keys/request_key_auth.c                                       |   12 
 security/keys/trusted-keys/trusted_tpm2.c                              |   12 
 security/landlock/fs.c                                                 |   18 
 security/landlock/net.c                                                |   14 
 security/selinux/avc.c                                                 |    5 
 security/selinux/hooks.c                                               |  150 
 security/selinux/include/objsec.h                                      |   10 
 sound/core/init.c                                                      |    3 
 sound/core/pcm_timer.c                                                 |    7 
 sound/hda/ext/hdac_ext_stream.c                                        |    4 
 sound/pci/hda/hda_controller.c                                         |    2 
 sound/pci/hda/patch_realtek.c                                          |    9 
 sound/soc/codecs/aw88261.c                                             |   30 
 sound/soc/codecs/aw88261.h                                             |    6 
 sound/soc/codecs/hdmi-codec.c                                          |    6 
 sound/soc/codecs/rt712-sdca-dmic.c                                     |   14 
 sound/soc/sdw_utils/soc_sdw_utils.c                                    |    2 
 sound/soc/soc-pcm.c                                                    |   18 
 sound/soc/tegra/tegra210_mixer.c                                       |   10 
 sound/soc/ux500/ux500_msp_i2s.h                                        |    4 
 sound/usb/6fire/chip.c                                                 |   40 
 sound/usb/6fire/comm.c                                                 |   42 
 sound/usb/6fire/comm.h                                                 |    2 
 sound/usb/6fire/midi.c                                                 |   64 
 sound/usb/6fire/midi.h                                                 |    2 
 sound/usb/6fire/pcm.c                                                  |  221 
 sound/usb/6fire/pcm.h                                                  |    5 
 sound/usb/bcd2000/bcd2000.c                                            |   33 
 sound/usb/card.h                                                       |    3 
 sound/usb/endpoint.c                                                   |   16 
 sound/virtio/virtio_card.c                                             |    4 
 tools/bootconfig/main.c                                                |   32 
 tools/lib/bpf/libbpf.c                                                 |    7 
 tools/lib/bpf/relo_core.c                                              |   58 
 tools/perf/tests/shell/stat_bpf_counters.sh                            |    2 
 tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c              |    2 
 tools/testing/selftests/bpf/prog_tests/linked_list.c                   |    4 
 tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c                      |    4 
 tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c                      |    4 
 tools/testing/selftests/cgroup/cgroup_util.c                           |   82 
 tools/testing/selftests/cgroup/cgroup_util.h                           |    8 
 tools/testing/selftests/cgroup/test_memcontrol.c                       |   78 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc |    2 
 tools/testing/selftests/landlock/fs_test.c                             | 1679 ++++++
 tools/testing/selftests/landlock/net_test.c                            |  169 
 tools/testing/selftests/nci/nci_dev.c                                  |   45 
 virt/kvm/kvm_main.c                                                    |   30 
 863 files changed, 16495 insertions(+), 9924 deletions(-)

Aamir Ahmed (3):
      Bluetooth: eir: validate service data length before reading UUID
      net: usb: catc: bound the RX packet length in catc_rx_done()
      nfc: llcp: drop truncated I/RR/RNR PDUs in nfc_llcp_recv_hdlc()

Abdun Nihaal (1):
      platform/x86: int1092: Fix potential memory leak in sar_probe()

Adrian Hunter (2):
      i3c: master: Do not treat master device as a duplicate target
      i3c: master: Fix use-after-free of master->this

Ahmed Naseef (1):
      net: phy: mediatek: do not report link and per-speed LED rules together

Al Viro (1):
      configfs:get_target() - release path as soon as we grab configfs_item reference

Alan Adamson (1):
      nvme: all namespaces in a subsystem must adhere to a common atomic write size

Alberto Carboneri (1):
      scsi: core: Validate MODE SENSE lengths in scsi_cdl_enable()

Aldo Ariel Panzardo (7):
      nfc: llcp: Fix list corruption / refcount desync in nfc_llcp_recv_dm()
      Bluetooth: hci_conn: fix CIS hold ownership on reuse
      Bluetooth: hci_sock: validate event length before filtering
      Bluetooth: hci_sock: reject out-of-range OCF values
      Bluetooth: ISO: balance the parent hold in hci_bind_bis()
      Bluetooth: L2CAP: validate frame length before control and FCS access
      Bluetooth: mgmt: fix race in read_unconf_index_list()

Aleksei Sviridkin (1):
      net: dsa: mt7530: fix NULL dereference on unbind of MT7531 and MT7621

Alex Bereza (2):
      dmaengine: xilinx_dma: Fix hardware buffer descriptor reuse order
      dmaengine: xilinx_dma: Fix hardware buffer descriptor chain after cyclic DMA

Alex Deucher (2):
      drm/amdgpu: add a helper to calculate ring distance
      drm/amdgpu: plumb timedout fence through to force completion

Alexander Chesnokov (1):
      dmaengine: ti: k3-udma-glue: fix NULL dereference in k3_udma_glue_release_rx_chn()

Alexander Duyck (1):
      eth: fbnic: Set AW_FLUSH_MODE alongside AW_FLUSH when flushing the mailbox

Alexander Lobakin (1):
      netmem: add a couple of page helper wrappers

Alexei Turtanov (1):
      Input: atkbd - skip deactivate for Xiaomi Redmi Book Pro 16 2026

Ali Ahmet Memis (1):
      wifi: wilc1000: fix out-of-bounds read in P2P public action frames

Ali Tariq (1):
      PCI: starfive: Fix resource leaks on error paths in host_init()

Alvin Šipraga (1):
      Input: adp5588-keys - cache GPIO state before registering the gpiochip

Amit Machhiwal (2):
      KVM: PPC: Book3S HV: fix use-after-free in kvmhv_emulate_tlbie_all_lpid()
      KVM: PPC: Book3S HV: fix secure device page leak on uv_page_in() failure

Amit Sunil Dhamne (1):
      usb: typec: tcpm: constrain TCPM_SOURCING_VBUS event handling

Andrea Mayer (1):
      seg6: set IPSKB_L3SLAVE from IP6SKB_L3SLAVE on IPIP decapsulation

Andrea Scian (1):
      mtd: rawnand: pl353: Add message about ECC mode

Andrew Martin (1):
      drm/amdgpu: Failed to check various return code

Andy Shevchenko (1):
      idpf: Fix kernel-doc descriptions to avoid warnings

Angel J (1):
      PCI: of_property: Omit bus properties without a subordinate bus

AngeloGioacchino Del Regno (2):
      phy: mediatek: phy-mtk-hdmi-mt8195: Fix PLL calc divisor overflow
      phy: mediatek: phy-mtk-hdmi-mt8195: Fix TMDS clk bit ratio setting

Antheas Kapenekakis (1):
      HID: asus: fortify keyboard handshake

Anthony Krowiak (2):
      s390/vfio-ap: fix KVM GISC and page leak when queue removed from host config
      s390/vfio-ap: Fix missing lock required to access list of ap_matrix_mdev objects

Aohan Mei (3):
      rds: ib: use rds_conn_drop() on protocol version mismatch
      sctp: discard the rest of the packet on a stale-cookie error
      netfilter: nf_tables: skip expired catchall elements on insert and delete

April Cardenas (1):
      smb/client: send lease break ACKs thru correct session for multiuser mounts

Arash Golgol (1):
      media: video-i2c: fix buffer queue ordering

Arun Easi (1):
      scsi: fnic: Fix missed link-up when critical IRQ targets offline CPU

Baineng Shou (2):
      dmaengine: mmp_pdma: fix wrong sg length in mmp_pdma_prep_slave_sg()
      dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds

Baolin Wang (1):
      mm: fix incorrect vm_flags usage when checking allowable orders for tmpfs

Bard Liao (1):
      soundwire: cadence_master: wait and cancel cdns->work before clock stop

Bart Van Assche (1):
      scsi: megaraid_sas: Protect megasas_get_ctrl_info() in megasas_resume()

Bartosz Golaszewski (4):
      power: sequencing: don't call .post_enable() if pwrseq_unit_enable() failed
      power: sequencing: fix NULL-pointer dereference in pwrseq_unit_new()
      power: sequencing: fix NULL-pointer dereference in pwrseq_device_register()
      gpio: cdev: fix kernel stack leak to user-space in error path

Bastien Nocera (1):
      HID: hid-alps: Use pm_ptr instead of #ifdef CONFIG_PM

Ben Hutchings (1):
      bootconfig: Fix negative seeks on 32-bit with LFS enabled

Bence Csókás (1):
      dmaengine: Add devm_dma_request_chan()

Benjamin Berg (1):
      wifi: mac80211: track MU-MIMO configuration on disabled interfaces

Benjamin Tissoires (1):
      HID: bpf: fix __hid_bpf_hw_check_params report length

Benoît Sevens (1):
      HID: logitech-hidpp: fix race condition when accessing stale stack pointer

Bernard Pidoux (10):
      rose: fix dev_put() leak in rose_loopback_timer()
      rose: hold loopback neighbour reference across timer callback
      rose: fix race between loopback timer and module removal
      rose: clear neighbour pointer after rose_neigh_put() in state machines
      rose: guard rose_neigh_put() against NULL in timer expiry
      rose: fix netdev double-hold in rose_rx_call_request()
      rose: fix notifier unregistered too early in rose_exit()
      rose: fix netdev double-hold in rose_make_new()
      rose: drop CALL_REQUEST in loopback timer when device is not running
      rose: cancel neighbour timers in rose_neigh_put() before freeing

Bernardo Soares (2):
      net/mlx5: Bridge, don't fail switchdev events of sibling eswitch ports
      net/mlx5: Bridge, don't fail unlink of untracked/unsupported peer ports

Bharath SM (1):
      smb: mark the new channel addition log as informational log with cifs_info

Bitterblue Smith (3):
      wifi: rtw88: TX QOS Null data the same way as Null data
      wifi: rtw88: Fix the random "error beacon valid" messages for USB
      wifi: rtw89: Hide some errors when the device is unplugged

Bjoern Doebel (1):
      smb: client: fail DACL rewrite when the new DACL exceeds 64K

Björn Töpel (1):
      eth: fbnic: Handle maximum standalone channels

Bob Zhou (1):
      drm/amdgpu: avoid force-completing uninitialized UVD rings

Bradley Morgan (1):
      arm64: hibernate: pass HVC_SET_VECTORS args to the resume hvc

Brajesh Gupta (2):
      drm/imagination: Propagate map failures correctly from pvr_mmu_map_sgl()
      drm/imagination: Fix page count for page table for map() interface

Breno Leitao (1):
      arm64: hibernate: clone only the linear map that exists at runtime

Bryam Vargas (2):
      wifi: mt76: mt7915: bound the device EEPROM address before the EFUSE copy
      wifi: mt76: mt7996: bound the device EEPROM address before the EFUSE copy

Bryan O'Donoghue (1):
      i2c: qcom-cci: Stop complaining about DT set clock rate

Can Peng (1):
      hwrng: stm32 - Fix runtime PM cleanup on registration failure

Carolina Jubran (1):
      IB/IPoIB: Avoid restoring OPER_UP after multicast flush

Catalin Marinas (1):
      arm64: Use load LSE atomics for the non-return per-CPU atomic operations

Cen Zhang (1):
      KEYS: encrypted: fix integer overflow of datablob_len

Cen Zhang (Microsoft) (1):
      reboot: fix cad_pid use-after-free race

Chaithanya Lagisetty (1):
      selftests: nci: Fix uninitialized family ID on missing attribute

Chang S. Bae (1):
      x86/microcode/intel: Reject problematic loading on Granite Rapids systems

Chao Shi (1):
      nvme: skip the zoned limits update if the zone info query failed

Chao Yu (3):
      f2fs: fix to avoid potential section-unaligned pinfile
      f2fs: embed f2fs_gc_kthread in f2fs_sb_info
      f2fs: fix to clear dirty flag on folio in error path

Chen Changcheng (2):
      HID: alps: fix use-after-free on input2 registration failure
      HID: alps: unregister DualPoint Stick input device on remove

Chen Linxuan (1):
      pidfd: hold exec_update_lock around namespace ioctl

Chen-Yu Tsai (1):
      dma-coherent: Warn if OF reserved memory is beyond current coherent DMA mask

Chengfeng Ye (3):
      Bluetooth: hci_sync: Serialize local codec list cleanup
      xfrm: serialize state GC with device state flush
      netfilter: cttimeout: prevent UAF during module unload

Chengjun Yao (1):
      drm/amdgpu: fix rmmio iounmap skipped on device removal

Chris Gellermann (2):
      selftests/nci: Fix out-of-bounds store on thread join
      nfc: virtual_ncidev: Add missing ioctl compat handler

Chris Lu (1):
      Bluetooth: btmtk: fix wrong status for short WMT FUNC_CTRL events

Chris Sommers (1):
      Input: i8042 - add quirk for Acer Aspire Go 15 AG15-42P

Christian Borntraeger (1):
      KVM: s390: Zero initialize data structures for inject_pfault_token

Christian Brauner (2):
      fs/ntfs3: use d_instantiate_new() in ntfs_create_inode() and murder syzbot's "WARNING in do_new_mount" saga
      super: make iterate_supers_type() deletion-safe

Christian Göttsche (1):
      selinux: always fill AVC decision in avc_has_perm_noaudit()

Christian König (2):
      drm/i915: fix incorrect RCU teardown order
      drm/amdgpu: use GFP_NOWAIT for memory allocations

Christian Lugnberg (2):
      dmaengine: sun6i: fix non-atomic read of DMA position registers
      dmaengine: sun6i: fix undefined behaviour in sun6i_dma_tx_status

Christiano Amora (1):
      Bluetooth: SMP: reject Security Request over BR/EDR

Christoph Hellwig (4):
      nvme: refactor the atomic write unit detection
      nvme: fix atomic write size validation
      xfs: remove the i_ino field in struct xfs_inode
      nvme: revert the cross-controller atomic write size validation

Christophe JAILLET (1):
      tracing: Constify struct event_trigger_ops

Claudio Imbrenda (1):
      KVM: s390: Fix IRQ injection with SIGP Stop and Store Status

Claudiu Beznea (1):
      phy: renesas: rcar-gen3-usb2: Avoid long delay in atomic context

Coia Prant (2):
      net: pcs: xpcs: fix clock reference leak on xpcs_init_clks failure
      net: ethernet: stmmac: dwmac-rk: fix bulk clock leak when the PHY clock fails

Cong Nguyen (1):
      nfc: llcp: fix sdreq TLV list leak on parse/alloc/send failure

Daeho Jeong (1):
      f2fs: accurately adjust free_sections during free_segment_range

Daehyeon Ko (1):
      wifi: libipw: reject TKIP frames without a full MIC

Dairui Zhang (1):
      af_packet: fix integer overflow in prb_calc_retire_blk_tmo()

Dan Carpenter (1):
      drm/nouveau/clk: fix list cursor use after loop in nvkm_clk_ustate_update

Daniel Borkmann (1):
      bpf: Fix bpf_skb_change_tail wrt csum partial skbs

Dapeng Mi (5):
      perf/x86/intel: Remove anythread_deprecated bit from perf_capabilities
      perf/x86/intel: Update event constraints and cache_extra_regsfor LNL
      perf/x86/intel: Remove incorrect LionCove PEBS data-source constraints
      perf/x86/intel: Update event constraints and cache_extra_regsfor ADL
      perf/x86/intel: Fix GRT PEBS load/store direction for latency events, to fix sample classification

Darrick J. Wong (14):
      xfs: don't stash removename operations with unknown ftype
      xfs: don't assert when XFS_SCRUB_TYPE_HEALTHY scans return corruption
      xfs: fix attr fork block count checks in xrep_inode_blockcounts
      xfs: release orphanage dir inode if chown fails
      xfs: use correct jiffies comparison function in xchk_maybe_relax
      xfs: check padding field in xfs_ioc_commit_range
      xfs: don't call xfs_exchange_range_finish for a dry run
      xfs: check di_forkoff correctly in scrub
      xfs: fix blockgc group quota scanning when usrquota isn't enforced
      xfs: report healthy filesystem events in scrub stats
      xfs: fix short ifork reaping computation in xreap_bmapi_binval
      xfs: strengthen the "is cow staging" helpers in scrub
      xfs: fix under-reservation of blocks when repairing sf directories
      xfs: fix backwards mergeability logic in refcount scrubber

Dave Stevenson (1):
      media: imx355: Avoid calling imx355_power_off twice in error path

David Ballesteros (1):
      KVM: Ensure memory attributes xarray nodes are accounted to the caller's memcg

David Dai (1):
      bonding: crypto offload enabled, non-offload slave failover, rekey failed

David Howells (2):
      cifs: Fix specification of function pointers
      9p: Fix v9fs_issue_write() to update i_size and remote_i_size

Deepanshu Kartikey (1):
      nfc: pn533: fix OOB read in pn533_acr122_is_rx_frame_valid()

Devin Wittmayer (1):
      wifi: mac80211: refuse to make a monitor active when it has no queue

Dinh Nguyen (1):
      EDAC/altera: Use parent device for devres in altr_portb_setup()

Diogo Ivo (Schneider Electric) (4):
      mmc: sdhci_am654: Move tuning_loop to local variable
      mmc: sdhci_am654: Reset command and data lines on failed tuning
      mmc: sdhci_am654: Clear ITAPDLY on tuning failure
      mmc: sdhci_am654: Fallback to DT-provided itap delay on DDR50 tuning failure

Dmitriy Chumachenko (1):
      drm/amdgpu: check ras and obj before dereference

Dmitriy Okunev (1):
      net: mvpp2: prevent buffer overflow in page_pool allocation

Dmitry Baryshkov (1):
      drm/msm/dsi: round the byte clock rate after reparenting to the PHY PLL

Dmitry Torokhov (2):
      Input: rmi_smbus - fix out-of-bounds read in rmi_smb_write_block()
      Input: synaptics-rmi4 - fix GPF in suspend and resume when unbound

Dong Chenchen (2):
      ipv4: icmp: reject RTN_UNREACHABLE input routes in icmp_route_lookup
      xfrm: Fix dev use-after-free in xfrm async resumption

Donggeun Yoo (7):
      dma-coherent: report a failed reserved memory assignment
      bpf, arm64: set up the frame pointer for the exception callback
      tracing: Fix memory corruption from a "STACKTRACE" histogram key
      tracing: Set the trace clock before registering the histogram trigger
      tracing: Take the reference before publishing the named histogram trigger
      tracing: Undo the registration when enabling the histogram trigger fails
      swiotlb: use the adjusted address for the highmem page lookup

Dongliang Qin (1):
      rds: ib: Clear the sg list when mapping an MR fails

Doruk Tan Ozturk (2):
      wifi: mwifiex: bound the pairwise-cipher OUI walk to the IE length
      nfc: port100: reject frames whose declared length exceeds the received data

Doug Berger (2):
      net: bcmgenet: move bcmgenet_power_up into resume_noirq
      net: bcmgenet: allow return of power up status

Dr. David Alan Gilbert (1):
      net: ena: Remove autopolling mode

Dragan Simic (1):
      driver core: Add device probe log helper dev_warn_probe()

Dragos Tatulea (1):
      net/mlx5e: SHAMPO, Always calculate page size

Elson Serrao (1):
      usb: dwc3: clear forceRM when issuing EndTransfer

Emil Tsalapatis (2):
      bpf: Fix bounds check for skb-backed dynptrs
      bpf: Fix bpf_sock context code generation

Eric Dumazet (16):
      ipv6: mcast: use copy-on-write RCU updates in ip6_mc_source()
      xfrm: add missing rcu_read_lock(), skb_dst_force() and dev_hold() for xfrm_trans_reinject()
      tcp: do not let tcp_rmem be set below 4096
      pppoatm: ensure a writable skb header and linear data
      drop_monitor: synchronize tracepoint unregistration on error path
      drop_monitor: fix out-of-bounds write in reset_per_cpu_data()
      net: lock the socket in sock_gettstamp()
      net: skbuff: do not leave stale header offsets after pskb_carve()
      llc: fix skb UAF and leaks on llc_mac_hdr_init() failure
      bridge: check llc_mac_hdr_init() return value in br_send_bpdu()
      net/sched: sch_teql: fix shadowed err in __teql_resolve()
      vlan: ensure sufficient headroom in vlan_dev_hard_header()
      tipc: reject invalid and unexpected GRP_ACK_MSG to prevent bc_ackers underflow
      ipv6: make ipv6_pinfo.saddr_cache a boolean
      ipv6: reorganise struct ipv6_pinfo
      tcp: introduce icsk->icsk_keepalive_timer

Erich Sartison (1):
      Input: xpad - add support for Victrix Pro BFG Controller

Eva Kurchatova (1):
      selftests: cgroup: give the O_TMPFILE open in get_temp_fd() a mode

Fan Wu (10):
      mmc: core: Cancel SDIO IRQ work before freeing host
      mmc: hsq: Fix use-after-free in retry work
      mmc: mmci: Fix use-after-free in busy-timeout work
      mmc: mxcmmc: cancel data work and watchdog on remove
      ipe: protect the dm-verity root hash with RCU
      power: supply: ab8500_fg: fix use-after-free on remove
      mmc: via-sdmmc: cancel card-detect work on remove
      power: supply: qcom_battmgr: fix use-after-free
      wifi: wcn36xx: Fix potential use-after-free in TX ack timer teardown
      ipe: fix use-after-free when auditing a newly loaded policy

Farhan Ali (2):
      PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value
      PCI: Allow per function PCI slots to fix slot reset on s390

Felix Fietkau (2):
      wifi: cfg80211: add option for vif allowed radios
      wifi: mac80211: use vif radio mask to limit ibss scan frequencies

Felix Gu (1):
      mmc: sdio_uart: fix xmit_fifo leak when the port table is full

Filipe Manana (2):
      btrfs: tree-checker: print dev extent offset in error message
      btrfs: abort transaction on failure to update inode for hole punching and reflinking

Florian Fainelli (5):
      net: bcmgenet: fix 64-bit RTNL stats reading in ethtool on 32-bit systems
      net: bcmgenet: initialize u64 stats seq counter for all queues
      net: bcmgenet: do not skip WoL power up on GENET V1
      net: bcmgenet: validate Ethernet address in bcmgenet_set_mac_addr
      net: bcmgenet: mask DMA_TIMEOUT_MASK when reading DMA_RING0_TIMEOUT

Florian Maillard (1):
      mmc: rtsx_pci_sdmmc: ignore broken write-protect on ThinkPad X260

Florian Westphal (1):
      netfilter: nfnetlink_queue: hold nfnl mutex in event notifier

Fourie Zhang (1):
      net: bridge: mdb: restart port group walk after deletion

Francesco Magazzu (1):
      drm/nouveau/clk: don't clobber reclock status when restoring volt/fan

Frank Sorenson (8):
      smb: client: reject short Next offsets in parse_server_interfaces()
      smb: client: fix next_buffer UAF and NextCommand bounds in compound PDUs
      smb: client: fix potential OOB read in smb3_enum_snapshots()
      smb: client: fix server->total_read for compound encrypted PDUs
      smb: client: fix missing lower-bound check on DFS referral string offsets
      smb: client: fix missing iov bounds check in parse_posix_sids()
      smb: client: fix OOB struct field reads in move_smb2_ea_to_cifs()
      smb: client: fix reparse buffer bounds in cifs_query_reparse_point()

Fuad Tabba (3):
      KVM: arm64: vgic-its: Free the caches when GITS_BASER changes
      KVM: arm64: vgic-its: Skip unreachable devices instead of failing the save
      arm64/boot: Disable trapping of PMZR_EL0 writes to EL2

Gabriel Krisman Bertazi (1):
      io_uring/net: don't overconsume buffers when using MSG_TRUNC

Gajdos Tamás (3):
      net: atl1: fix soft lockup on out-of-range cmb_tpd_next_to_clean read
      net: atl1c: fix soft lockup on out-of-range tpd_cons read
      net: atl1e: fix soft lockup on out-of-range hw_next_to_clean read

Gang Yan (1):
      RDMA/rxe: Fix integer overflow in mr_check_range() leading to OOB access

Geliang Tang (4):
      bpf, sockmap: Fix self-redirect copied_seq double-counting
      mptcp: pm: drop match in userspace_pm_append_new_local_addr
      sock: add sock_kmemdup helper
      mptcp: use sock_kmemdup for address entry

Ginger Li (1):
      tipc: Fix a data race on mon->peer_cnt in mon_timeout()

Giuseppe Ranieri (1):
      drm/nouveau/disp: don't reject HDMI config on cards without SCDC

Glenn Judd (1):
      net/mlx5e: do not HW-GRO coalesce small frames

Greg Kroah-Hartman (1):
      Linux 6.12.112

Guanghui Yang (1):
      f2fs: fix dentry folio leak in find_in_level

Guanglei Zhu (3):
      net: wwan: t7xx: validate the netif index in t7xx_ccmni_recv_skb()
      net: wwan: mhi_wwan_mbim: guard against a cyclic NDP chain
      net: wwan: mhi_wwan_mbim: check skb_copy_bits() return value

Guangshuo Li (7):
      i2c: imx: disable autosuspend on remove
      hwmon: (w83791d) remove fan/pwm 4-5 sysfs group on remove
      hwmon: (w83793) release probe data through kref
      drm/msm/adreno: fix autosuspend cleanup during teardown
      drm/msm/hdmi_phy: fix runtime PM cleanup on probe failure
      drm/nouveau: fix autosuspend cleanup during teardown
      net: ena: fix MMIO read buffer leak on probe failure

Guopeng Zhang (1):
      cgroup/pids: Restore pids.events notifications in local mode

Guoqing Jiang (1):
      RDMA/siw: Clear association under lock if siw_qp_modify fails in siw_accept

Günther Noack (2):
      selftests/landlock: Add tests for whiteout object creation
      landlock: Clarify documentation for the IOCTL access right

Hal Feng (1):
      PCI: starfive: Use regulator APIs to control the 3v3 power supply of PCIe slots

Hans de Goede (2):
      Input: soc_button_array - fix MS Surface Pro 11 probe failure
      Input: soc_button_array - check btns_desc->package.count

Hidayath Khan (1):
      net/smc: stop killed, freed and out_of_sync sharing a byte

Hohyun Sim (1):
      net: fddi: skfp: fix NULL deref when setting the MAC address while down

Hongling Zeng (1):
      btrfs: take commit root semaphore when iterating in mark_block_group_to_copy()

Hou Tao (3):
      bpf: Remove migrate_{disable|enable} in ->map_for_each_callback
      bpf: Bail out early in __htab_map_lookup_and_delete_elem()
      bpf: Factor out htab_elem_value helper()

Hui Peng (7):
      Bluetooth: bnep: fix out-of-bounds reads on short RX/TX frames and control fallthrough
      Bluetooth: RFCOMM: Reject short EA=0 frames in rfcomm_recv_frame()
      autofs: fix sbi->pipe file reference leak in autofs_kill_sb()
      fou: reject omitted FOU_ATTR_IPPROTO on FOU_ENCAP_DIRECT
      ipv6: sr: enforce exact attribute length for SEG6_ATTR_DST
      mctp: route: iterate socket tag list in mctp_lookup_prealloc_tag()
      Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO

Hui Su (1):
      io_uring/waitid: avoid siginfo copy during ring teardown

HyeongJun An (1):
      ASoC: hdmi-codec: Report a change when the channel status moves

Hyunwoo Kim (1):
      exec: Cleanup POSIX timers right after de_thread()

Ido Schimmel (3):
      ipv6: Select best matching nexthop object in fib6_table_lookup()
      ipv6: Honor oif when choosing nexthop for locally generated traffic
      vrf: Stop corrupting skb->csum when capturing CHECKSUM_COMPLETE packets

Ilpo Järvinen (1):
      PCI: Fix Resizable BAR restore order

Ilya Maximets (5):
      net: openvswitch: conntrack: avoid modifying shared unconfirmed ct entry
      net: openvswitch: conntrack: remove 'add_helper' dead code
      net: openvswitch: conntrack: fix helper UAF due to extensions realloc
      net/sched: act_ct: fix helper UAF due to extensions realloc
      net/sched: act_ct: avoid modifying shared unconfirmed ct entry

Ilya Titov (1):
      pinctrl: sunxi: keep a shadow copy of the data register output latches

Imran Shaik (1):
      clk: qcom: Fix test_ctl_hi field for DEFAULT_EVO PLLs

Imre Deak (1):
      drm/i915/dp_mst: Fix configuring FEC for a disconnected stream

Inbal Schussheim (1):
      tcp: exclude old ACKs from tcp fast path

Itai Handler (1):
      spi: spi-zynqmp-gqspi: stop the controller on shutdown

Ivan Delalande (1):
      tg3: use random MAC address when tg3_get_device_address fails

Ivan Lipski (1):
      drm/amd/display: Bump frame warning limit for clang builds of dml

Ivan Vecera (1):
      dpll: use exact lookup for reference sync pin id

Iván Ezequiel Rodriguez (2):
      Input: evdev - zero absinfo before partial copy in EVIOCSABS
      Input: zero ff_effect before compat copy in input_ff_effect_from_user

Jackson Lee (1):
      media: chips-media: wave5: Add timeout while stop_streaming

Jacob Moroni (1):
      RDMA/irdma: Enforce local fence for IB_WR_REG_MR

Jaewook You (1):
      mm/hugetlb: preserve mremap address delta when skipping page tables

Jakub Kicinski (3):
      genetlink: report the real command id for dump-only ops in policy dumps
      veth: manage XDP program pointers during channel resize
      net: tls: fix silent data drop under pipe back-pressure

Jamal Hadi Salim (3):
      net/sched: hhf: cap hh_flows_limit at change time
      net/sched: cls_u32: fix manual hash table handle IDR aliasing
      net/sched: sch_hfsc: bound the classify inner-filter walk with a drift budget

James Clark (2):
      net: macb: fix ordering around PTP timestamp read
      perf test: Change all remaining #!/bin/sh to #!/bin/bash

Jan Kara (2):
      udf: Move udf_map_block() up
      udf: Fix data loss when converting inline inodes to out of line

Jani Nikula (1):
      drm/i915/mst: add mst sub-struct to struct intel_dp

Jarkko Sakkinen (1):
      KEYS: trusted: Fix tpm2_load_cmd() boundary check

Jeffin Philip (2):
      RDMA/core: fix refcount bug in iwpm_get_nlmsg_request()
      usb: gadget: f_mass_storage: fix null pointer dereference in fsg_common_set_num_buffers()

Jens Axboe (3):
      sunvdc: fix -EIO issue due to lack of retries
      io_uring/waitid: have io_waitid_complete() remove wait queue entry
      io_uring/rw: end write accounting from ->ki_complete

Jeremy Nyberg (1):
      Input: xpad - fix PDP Marvel Xbox 360 controller

Jiakai Xu (1):
      RISC-V: KVM: Fix null pointer dereference in kvm_riscv_aia_imsic_rw_attr()

Jianbo Liu (1):
      xfrm: Refactor xfrm_input lock to reduce contention with RSS

Jiangshan Yi (3):
      ASoC: codecs: rt712-sdca-dmic: fix uninitialized stream_config->type
      wifi: brcmsmac: fix UAF in brcms_free_timer()
      wifi: libertas_tf: fix UAF in lbtf_free_adapter()

Jiapeng Chong (1):
      i2c: qcom-cci: Remove the unused variable cci_clk_rate

Jiayuan Chen (5):
      bpf: Fix divide-by-zero in btf_struct_walk()
      bpf: Fix out-of-bounds read of sk_protocol in bpf_sock_destroy()
      tcp: Skip cond_resched() in inet_csk_listen_stop() under BPF context
      bpf: Fix out-of-bounds read of rtt_min in sock_ops
      bpf: Reject key-less BTF for hash maps

Jim Mattson (1):
      KVM: x86/pmu: Move Intel PMU global MSRs to intel_is_valid_msr()

Jingbo Xu (1):
      erofs: add sysfs feature entry for xattr prefixes

Jinjiang Tu (2):
      mm/rmap: fix missing barrier between anon_vma init and vma->anon_vma publish
      mm/hugetlb: fix surplus pages in dissolve_free_huge_page()

Joanne Chang (1):
      f2fs: dirty directory inodes on mtime/ctime update

Joe Damato (2):
      bnxt_en: Propagate TPA buffer allocation failures in bnxt_queue_mem_alloc()
      bnxt_en: Don't free the live ring's TPA state on queue restart failure

Johan Almbladh (2):
      bpf: Fix immediate JMP JEQ/JNE on MIPS32
      bpf: Fix BSWAP 32 and 16 on MIPS64

Johannes Berg (23):
      wifi: cfg80211: don't get the radio mask for netdev-less wdevs
      wifi: cfg80211: check IP header size in cfg80211_classify8021d()
      wifi: cfg80211: only group hidden BSSes with beacon entries
      wifi: cfg80211: don't filter by BSS type when removing stale entries
      wifi: mac80211: don't start a ROC while scanning
      wifi: mac80211: don't warn when an IBSS has no channel to scan
      wifi: mac80211: don't offload TC setup on AP_VLAN interfaces
      wifi: mac80211: suppress chanctx warning for debugfs reset
      wifi: mac80211: abort chanswitch when leaving a mesh
      wifi: mac80211: reset state when starting AP fails
      wifi: mac80211: unlist vifs when their netdev is unregistered
      wifi: mac80211_hwsim: don't hand frames to mac80211 while stopping
      wifi: cfg80211: expose cfg80211_chandef_get_width()
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

John Stultz (1):
      sched: Rework prev_balance() to avoid stale prev references

Jon Hunter (1):
      ASoC: tegra: Fix the MIXER enable default value

Jonghyuk Kim(MalHyuk) (1):
      drm/nouveau: RCU-free the scheduler-containing nouveau_sched

Jorijn van der Graaf (1):
      ASoC: codecs: aw88261: only check PLL and clock state at power-up

Jose Fernandez (Anthropic) (1):
      bpf: Avoid soft lockup in __htab_map_lookup_and_delete_batch()

Josef Bacik (1):
      writeback: report a Tasks-RCU quiescent state per cgwb drain pass

Joseph Qi (2):
      ocfs2: make ocfs2_calc_xattr_init() return void
      smb: client: fix use-after-free of iface in cifs_try_adding_channels()

Jouni Högander (1):
      drm/i915/psr: Add new SU area calculation helper to apply workarounds

Juan Perdomo (1):
      Bluetooth: RFCOMM: avoid socket lock inversion in listener cleanup

Julian Anastasov (1):
      ipvs: revalidate ihl before icmp_send

Junjie Cao (1):
      HID: quirks: add ALWAYS_POLL quirk for SDINNOVATION gaming keyboard

Junrui Luo (4):
      drm/virtio: fix object leak when drm_gem_handle_create() fails
      drm/virtio: fix object leak in virtio_gpu_resource_create_ioctl()
      drm/virtio: fix object leaks in virtio_gpu_resource_create_blob_ioctl()
      drm/virtio: release the GEM object on virtio_gpu_vram_create() errors

Jérémy Jean (3):
      RDMA/siw: Bound fragmented header copies by the remaining length
      netfilter: flowtable: publish HW_DEAD after worker is done
      net: gue: reject invalid REMCSUM offsets

Kalpan Jani (1):
      mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0

Karl Mehltretter (11):
      scsi: qla2xxx: Fix the ql2xfc2target parameter description
      keys: fix lost wakeup when reaping a dead key type
      Input: trackpoint - fix the inertia attribute name in the ABI document
      drm/vc4: Use managed KMS polling to fix UAF on unbind
      wifi: brcmfmac: fix lost 802.1x TX completion wakeup
      selinux: preserve user SID across nested backing files
      selinux: recheck intermediate backing files on mprotect()
      KVM: arm64: Return -EINVAL for an empty SMCCC filter range at base 0
      s390/pci/docs: Fix sriov_numvfs attribute name
      netfilter: nft_synproxy: use the family-aware checksum helper
      gpio: tps65219: Fix GPIO input value reads

Kavita Kavita (1):
      wifi: cfg80211: skip regulatory for punctured subchannels

Kevin Hao (4):
      net: cpsw_new: Execute ndo_set_rx_mode callback in a work queue
      net: cpsw: Execute ndo_set_rx_mode callback in a work queue
      net: macb: Replace open-coded implementation with napi_schedule()
      net: macb: Use netif_napi_add_tx() instead of netif_napi_add() for TX NAPI

Koichiro Den (1):
      arm64: dts: renesas: r8a779f0: Set UFS lane count

Krystian Kaniewski (1):
      RDMA/core: Reject unregistering netdevs in ib_get_eth_speed

Kumar Kartikeya Dwivedi (4):
      bpf: Register dtor for freeing special fields
      bpf: Restrict CO-RE poisoning to relocatable instructions
      libbpf: Reject truncated ldimm64 CO-RE relocations
      bpf: Bound ownership depth through local kptrs and graph roots

Kuniyuki Iwashima (8):
      ipv6: mcast: Use in6_dev_get() in ipv6_dev_mc_dec().
      ipv6: mcast: Don't hold RTNL for IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.
      ipv6: mcast: Don't hold RTNL for IPV6_DROP_MEMBERSHIP and MCAST_LEAVE_GROUP.
      ipv6: mcast: Don't hold RTNL for MCAST_ socket options.
      tcp: Don't call skb_clone_and_charge_r() for close()d listener in tcp_v6_do_rcv().
      ip6_gre: Call ip6erspan_tunnel_unlink_md() in ip6erspan_changelink().
      ipv6: Fix dst leak for uncached routes.
      ipv6: Move ipv6_fl_list from ipv6_pinfo to inet_sock.

Kyle Zeng (1):
      xfrm: fix compat ALLOCSPI request use-after-free

Lad Prabhakar (1):
      rtc: rzn1: Handle unset alarm weekday in rzn1_rtc_read_alarm

Laurent Pinchart (1):
      media: i2c: imx355: Replace client->dev usage

Laxman Acharya Padhya (1):
      Bluetooth: hci_codec: validate vendor codec count length

Lee Jones (2):
      Bluetooth: mgmt: Dequeue pending mesh_send_sync entries on cancel
      nfc: llcp: Fix race condition in accept_queue lifecycle

Lei Zhu (1):
      selftests: nci: Correct pthread_create return value check

Leon Romanovsky (2):
      RDMA/efa: Keep admin queues alive while IRQ is registered
      RDMA/efa: Keep EQ resources alive while IRQ is registered

Leonardo Costa (1):
      drm/bridge: tc358768: Enforce input bus flags via atomic_check

Li Chen (6):
      nvdimm: preserve flush callback -ENOMEM
      nvdimm: pmem: keep PREFLUSH before data writes
      nvdimm: virtio_pmem: stop allocating child flush bio
      nvdimm: virtio_pmem: always wake -ENOSPC waiters
      nvdimm: virtio_pmem: use READ_ONCE()/WRITE_ONCE() for wait flags
      nvdimm: virtio_pmem: refcount requests for token lifetime

Li Jun (1):
      watchdog: da9063: fix suspend/resume handling of HW_RUNNING watchdog

Li RongQing (1):
      RDMA/mad: Fix receive buffer leak when PKey enforcement fails

Li Youhong (1):
      drm/bridge: samsung-dsim: fix TE GPIO lifetime for host attach

Linkai Gong (2):
      i2c: atr: fix dangling adapter pointer on add failure
      Input: cyttsp5 - clamp the HID report size before memcpy

Linmao Li (1):
      wifi: mwifiex: prevent authentication frame length truncation

Linus Walleij (1):
      net: ethernet: cortina: Ack RX overrun interrupt correctly

Liu Zhenlong (1):
      i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()

Liz Fong-Jones (1):
      PCI: Fix BAR resize for devices on a root bus

Longlong Xia (2):
      mm/hugetlb: do not dissolve gigantic pages without runtime support
      mm/hugetlb: keep max_huge_pages when dissolving surplus folios

Lorenzo Bianconi (3):
      net: stmmac: do not overwrite phc_index when no PTP clock is registered
      net: stmmac: propagate FPE preemption-class mapping errors
      net: ethernet: mtk_eth_soc: unregister net_devices in case of probe failure

Lorenzo Stoakes (1):
      mm/rmap: allocate anon_vma_chain objects unlocked when possible

Lorenzo Stoakes (ARM) (2):
      KVM: arm64: Fix spurious warning for benign stage 2 teardown race
      mm/mremap: reset unfaulted VMA page offset for MREMAP_DONTUNMAP

Luiz Augusto von Dentz (3):
      Bluetooth: hci_core: Print number of packets in conn->data_q
      Bluetooth: ISO: Fix parent socket leak in iso_conn_ready()
      Bluetooth: ISO: set BT_LISTEN before requesting a BIG sync

Luxiao Xu (2):
      netfilter: ip6t_rt: fix zero-address non-strict match out-of-bounds read
      nfc: fix use-after-free in nfc_get_local_general_bytes

Lyude Paul (1):
      drm/nouveau/disp/r535: Add scanline position support + head state support

Maher Azzouzi (1):
      esp: downgrade zerocopy managed frags before mutating skb frags

Manaf Meethalavalappu Pallikunhi (1):
      thermal: gov_step_wise: Fix stale mitigation vote with non-zero lower bounds

Maoyi Xie (1):
      keys: translate request_key_auth pid for the reading procfs instance

Marc Zyngier (1):
      KVM: arm64: vgic-its: Add stronger type-checking to the ITS entry sizes

Marco Elver (1):
      compiler_types: Move lock checking attributes to compiler-context-analysis.h

Mariano Baragiola (1):
      wifi: virt_wifi: free skb when disconnected

Mario Limonciello (4):
      x86/PCI: Disable enhanced atomics on AMD NBIO 7.7 and 7.11
      platform/x86/amd/pmc: Restore msg_port on amd_stb_s2d_init() error paths
      platform/x86/amd/pmc: Propagate SMU errors and validate S2D address
      platform/x86/amd/pmc: Fix LPS0 and debugfs leaks when STB init fails

Mark Amirkan (4):
      net: lan743x: fix RX checksum use-after-free
      net/packet: clear RX owner on VNET header error
      net/packet: avoid truncating TPACKET_V3 private size
      mptcp: return sk_wait_data() errors from recvmsg()

Mark Brown (1):
      KVM: arm64: Fix FGT mapping for HFGITR_EL2.nGCSEPP

Mark Pearson (1):
      platform/x86: think-lmi: improve check if BIOS account security enabled

Mark Rutland (3):
      arm64: percpu: Fix this_cpu_write() casting
      arm64: percpu: Fix this_cpu_and() mask generation
      arm64: percpu: Fix LSE operations on {8,16}-bit types

Masami Hiramatsu (Google) (6):
      x86/mce: Fix hardware debug register corruption on task migration
      tracing/probes: Fix anon_stack check for unnamed bitfields in btf_find_struct_member
      tracing/probes: Fix BTF kflag check for anonymous struct member access
      tools/bootconfig: Cleanup bootconfig footer size calculations
      tools/bootconfig: Fix integer overflow and truncation in size checks
      bootconfig: Fix integer overflow in initrd size check

Mathias Nyman (1):
      xhci: Cleanup Candence controller PCI device and vendor ID usage

Matthew Auld (1):
      drm/xe/vm: nuke PTs only after unlinking contested VMAs

Matthew Schwartz (1):
      x86/fred: Reconstruct the #GP context for rejected INT instructions

Matthew Wilcox (Oracle) (1):
      f2fs: Convert clear_node_page_dirty() to clear_node_folio_dirty()

Matthias Goergens (1):
      ata: libata-scsi: bound the ATA passthru sense descriptor writes

Matthieu Baerts (NGI0) (3):
      mptcp: pm: reset retrans_time when ADD_ADDR entry is reused
      mptcp: pm: use for_each_subflow helper
      mptcp: pm: rename add_entry structure to add_addr

Matthieu Buffet (3):
      landlock: Fix TCP Fast Open connection bypass
      selftests/landlock: Add test for TCP fast open
      selftests/landlock: Add missing connect(minimal AF_UNSPEC) test

Maxime Chevallier (4):
      net: stmmac: selftests: Support running selftests on DSA conduits
      net: stmmac: selftests: Check the dev->features for S-TAG offload testing
      net: stmmac: selftests: Capture all packets for vlan checks
      net: stmmac: dwmac4: Use the correct bufzise when the len is exactly 8K

Meijing Zhao (1):
      mm: memblock: show all region flags in debugfs

Michael Bommarito (1):
      RDMA/rxe: insert mcg into mcg_tree only after rxe_mcast_add() succeeds

Michael Chan (1):
      bnxt_en: Do not set EOP on RX AGG BDs on 5760X chips

Mickaël Salaün (1):
      selftests/landlock: Add disconnected leafs and branch test suites

Mike Lothian (1):
      drm/amdgpu: hold a runtime PM reference for P2P dma-buf attachments

Mikhail Zaslonko (2):
      s390/debug: Do not register views for failed static debug areas
      s390/debug: Fix NULL pointer dereference in debug_info_copy()

Mina Almasry (2):
      net: page_pool: rename page_pool_alloc_netmem to *_netmems
      page_pool: disable sync for cpu for dmabuf memory provider

Ming Wang (1):
      net: usb: cdc_mbim: add MeiG Smart SRM821 to ZLP whitelist

Miquel Raynal (DAVE) (2):
      mtd: rawnand: pl353: Make sure we use the monolithic helpers for raw accesses
      mtd: rawnand: pl353: Fix debug prints

Mostafa Saleh (1):
      remoteproc: qcom_q6v5_adsp: Fix iommu_unmap() usage

Muhammad Bilal (3):
      hwmon: (hp-wmi-sensors) Fix use-after-free in fungible_show()
      staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()
      staging: sm750fb: fix mono image source stride mismatch in lynxfb_ops_imageblit()

Mukesh Ojha (3):
      firmware: qcom_scm: Rename peripheral as pas_id
      remoteproc: pas: Replace metadata context with PAS context structure
      remoteproc: qcom: pas: Guard dtb metadata release with dtb_pas_id check

Myeonghun Pak (7):
      mmc: sdhci-of-aspeed: Remove children before releasing SDC resources
      tg3: clean up PHYLIB resources on probe failure
      pinctrl: single: free the IRQ on domain creation failure
      RISC-V: KVM: Synchronize hrtimer callback during teardown
      usb: storage: realtek_cr: fix use-after-free on disconnect
      idpf: disable DIM work before freeing q_vectors
      bna: prevent IOC timer rearm during teardown

Naman Gulati (1):
      netfilter: ctnetlink: fix suspicious RCU usage in expect_iter_name

Namjae Jeon (4):
      ksmbd: return buffer overflow for partial filesystem info
      ksmbd: fix partial file information responses
      ksmbd: keep compound responses on query info errors
      ksmbd: fix partial normalized name responses

Narasimharao Vadlamudi (1):
      media: rkvdec: Propagate platform_get_irq() errors

Nemesa Garg (1):
      drm/i915/psr: Clear stale sel fetch enable bits on sel fetch disable

Nguyen Ngoc Thang (2):
      ALSA: pcm: set timer->private_data before registering the PCM timer
      net/sched: act_ct: don't WARN on benign flow_offload_alloc() failure

Nicolas Escande (1):
      wifi: ath11k: cleanup arsta in ath11k_mac_peer_cleanup_all()

Nicolas Thibert (1):
      Bluetooth: btusb: fix NXP IW610 composite device handling

Niklas Cassel (1):
      ata: libahci: clear PxCLBU and PxFBU for AHCI_HFLAG_32BIT_ONLY

Niklas Schnelle (1):
      docs: s390/pci: Improve and update PCI documentation

Nikolay Aleksandrov (1):
      net: bridge: mst: move switchdev call outside rcu

Nilesh Javali (14):
      scsi: qla2xxx: Zero dport diagnostics buffer to avoid info leak
      scsi: qla2xxx: Fix queue teardown NULL dma_free and bitmap locking
      scsi: qla2xxx: Fix use-after-free of qpair work on queue teardown
      scsi: qla2xxx: Null out freed pointers in qla2x00_mem_alloc() error path
      scsi: qla2xxx: Bound VP index against VP_CTRL IOCB bitmap size
      scsi: qla2xxx: Use ring-slot helpers in __qla2x00_alloc_iocbs
      scsi: qla2xxx: Use memset_io() to clear QLAFX00 request ring slot
      scsi: qla2xxx: Fix 64G link speed reporting in get_data_rate
      scsi: qla2xxx: Skip vport under deletion in report ID acquisition
      scsi: qla2xxx: Fix soft lockup polling continuation IOCB signature
      scsi: qla2xxx: Clamp max_npiv_vports to VP_CTRL bitmap capacity
      scsi: qla2xxx: Unlink NVMe unsol ctx before freeing on LS reject error
      scsi: qla2xxx: Serialize NVMe unsol ctx list with a per-fcport lock
      scsi: qla2xxx: Validate BSG request_len before reading vendor_cmd[]

Norbert Szetei (4):
      RDMA/rxe: validate access flags before swapping the MR's PD
      net: xps: reject an out of range traffic class
      ipv6: do not let ipv6_find_hdr() return an offset past the packet end
      landlock: Fix use-after-free of the source's parent directory

Nuno Sá (1):
      hwmon: (pmbus/core) increase number of phases and add new mask

Oleg Nesterov (1):
      sysctl: move the "cad_pid" entry from pid_table[] to kern_reboot_table[]

Orgad Shaneh (1):
      MIPS: Octeon: apply USB FDT fixups also when USB is modular

Oscar Ou (1):
      lockd: fix swapped arguments in nlmsvc_match_ip()

Oscar Priego Verdugo (1):
      HID: elecom: fix bus type for M-XGL20DLBK

Pablo Neira Ayuso (4):
      netfilter: flowtable: hold reference on ct until flow is released
      rculist: add list_splice_rcu() for private lists
      netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase
      netfilter: cttimeout: detach dataplane timeout policy and repurpose refcount

Pan Chuang (1):
      power: supply: ab8500_fg: Remove redundant dev_err()/dev_err_probe()

Paolo Abeni (1):
      mptcp: do not reschedule the RTX timer for fallback sockets

Patrick Lu (Anthropic) (1):
      writeback: bound cleanup_offline_cgwb() rescans by rotating scanned inodes

Paulo Alcantara (4):
      smb: client: cancel reconnect work in clean_demultiplex_info()
      smb: client: fix rlist race and missing initialization
      smb: client: fix smbd_connection leak on cifs_get_tcp_session() error
      smb: client: fix unaligned access in WSL reparse point parser

Pavan Kumar Linga (1):
      idpf: introduce idpf_q_vec_rsrc struct and move vector resources to it

Pavankumar Kondeti (1):
      workqueue: Fix NULL current_pwq deref in flush dependency check

Pavel Begunkov (1):
      eth: bnxt: store rx buffer size per queue

Pawel Laszczak (1):
      usb: cdnsp: fix wakeup from S3 after controller context loss

Pei Xiao (1):
      usb: dwc3: gadget: Fix use-after-free in dwc3_gadget_free_endpoints due to race condition

Peiyang He (6):
      drm/nouveau/uvmm: fix UAF in nouveau_uvmm_sm when BO is in TTM_PL_SYSTEM
      drm/nouveau: fix double-free in nvif_vmm_dtor
      drm/nouveau: don't bump pin count on failed re-pin in nouveau_bo_pin_locked()
      drm/virtio: fix memory leak of fence event on execbuffer failure
      drm/virtio: fix NULL pointer dereference on fence allocation failure
      iommufd: Fix UAF in selftest IOPF reporting

Peng Hao (1):
      wifi: mwifiex: fix IRQ leak using wrong index in MSI-X error path

Pengpeng Hou (7):
      ARM: socfpga: select the PL310 erratum 753970 workaround
      wifi: mwifiex: validate scan response extents
      net: usb: sr9700: include receive overhead in the length check
      nfc: nfcmrvl: validate helper command length before pull
      nfc: st21nfca: validate received frame size
      nfc: st21nfca: validate ISO15693 inventory length
      drm/imagination: clamp freelist reconstruction requests

Peter Oberparleiter (1):
      s390/cmf: Fix virtual vs physical address confusion

Peter Ujfalusi (1):
      ASoC: tegra210_mixer: sort the register default table

Phil Sutter (2):
      netfilter: nf_tables: Tolerate chains with no remaining hooks
      netfilter: nf_tables: Simplify chain netdev notifier

Pu Lehui (1):
      bpf: Fix UAF due to concurrent consumption of ttrace lists in alloc_bulk

Puranjay Mohan (2):
      perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
      perf/core: Run sched_task() for PMUs with only CPU-wide events

Qing Luo (1):
      mptcp: pm: userspace: fix address ID overflow

Quanye Yang (2):
      RDMA/rtrs-clt: Fix CQ pool leak when connect is interrupted
      RDMA/ucma: Serialize join and leave on copy_to_user failure

Rafael J. Wysocki (1):
      platform/x86: intel_sar: Check ACPI_HANDLE() against NULL

Ralf Lici (1):
      net/mlx5e: advertise MACsec offload only when supported

Ralph Boehme (2):
      smb: client: refactor ACL setting control flow in id_mode_to_cifs_acl()
      smb/client: fix security flag calculation when setting security descriptors

Ran Hongyun (1):
      squashfs: Add dictionary size range check to prevent shift-out-of-bounds

Raphaël Larocque (1):
      Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)

Ratheesh Kannoth (1):
      octeontx2-af: Fix memory scaling limitation in SR-IOV mode

Ravindra (1):
      Bluetooth: btintel_pcie: validate device-supplied DMA indices

Richard Fitzgerald (3):
      ASoC: Rename snd_soc_dai_link_ch_map.ch_mask to cpu_ch_mask
      ASoC: Add codec_ch_mask to snd_soc_dai_link_ch_map
      ASoC: soc-pcm: Apply snd_soc_dai_link_ch_map.codec_ch_mask to codec params

Ridham Khurana (1):
      gpio: zynq: fix runtime PM leak on request error path

Rik van Riel (1):
      wifi: mac80211: avoid WARN in set_bitrate_mask when sdata not in driver

Roberts Kursitis (1):
      Input: xpad - add support for Azeron devices

Roman Li (1):
      drm/amd/display: Set gpuvm min page size to 4K on dcn35/36

Rounak Das (1):
      EDAC/altera: Use ECC manager compatible to select A10/S10 IRQ layout

Runyu Xiao (5):
      gpio: virtuser: skip free_irq when no IRQ is installed
      mmc: sh_mmcif: initialize IRQ-thread mutex before requesting interrupt
      wifi: wlcore: release runtime PM ref on regdomain config failure
      net: macb: initialize PTP state before registering clock
      Input: hp_sdc - shut down kicker timer on module exit

Ruoyu Wang (2):
      dmaengine: sprd: Fix runtime PM reference leak in probe
      i2c: mxs: fix DMA channel leak on probe error

SJ Park (1):
      mm/damon/vaddr: avoid hw-driven pte updates during damon_hugetlb_mkold()

Sabrina Dubroca (1):
      xfrm: avoid RCU warnings around the per-netns netlink socket

Sai Teja Aluvala (1):
      Bluetooth: btintel_pcie: fix off-by-one bounds check in RX submit

Saim Shujah (1):
      drm/msm/dpu: clear pending peripheral flush state

Sajal Gupta (1):
      drm/gud: fix out-of-bounds write in gud_plane_atomic_check()

Saleemkhan Jamadar (1):
      drm/amdgpu/umsch: remove vpe test from umsch

Sang-Hoon Choi (1):
      nfp: hold IPsec RX state under the XArray lock

Sanghyun Park (1):
      vxlan: use one headroom snapshot for neighbour replies

Sanman Pradhan (2):
      hwmon: (pmbus/tps53679) Fix TPS53676 phase page decoding
      hwmon: (pmbus/tps53679) Select page 0 for single-page TPS53676

Sasha Levin (3):
      Revert "hwmon: (emc1403) Drop hysteresis for low limit temperature"
      Revert "hwmon: (emc1403) Rely on subsystem locking"
      ASoC: ux500: Parenthesize MSP_{RX,TX}_CLKPOL_BIT() arguments

Sean Anderson (1):
      pinctrl: meson: Fix typo in s4 group name

Sean Christopherson (10):
      cgroup: selftests: Move memcontrol specific helpers out of common cgroup_util.c
      perf/x86/intel: Ensure KVM guest PEBS path doesn't set unwanted PERF_GLOBAL_CTRL bits
      perf/x86/intel: Don't write PEBS_ENABLED on host<=>guest xfers if CPU has PEBS isolation, to fix stuck PEBS_ENABLED
      perf/x86/intel: Don't pointlessly context switch DS_AREA (and PEBS config) if PEBS is unused
      perf/x86/intel: Make @data a mandatory param for intel_guest_get_msrs()
      KVM: x86/mmu: Dynamically allocate shadow MMU's hashed page list
      KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into "front" and "back" halves
      KVM: x86: Extract REGS and SREGS runtime sync code to helpers
      KVM: x86: Rename __{g,s}et_sregs2() => kvm_vcpu_ioctl_x86_{g,s}et_sregs2()
      KVM: x86: Move the bulk of register specific code from x86.c to regs.c

Sean Rhodes (2):
      ALSA: hda/realtek: Limit Star Labs internal mic boost
      ALSA: hda/realtek: Add StarFighter HDA SSID

Sebastian Andrzej Siewior (1):
      futex: Provide rt_mutex_.*_schedule() equivalents for futex scheduling

SeungJu Cheon (3):
      RISC-V: KVM: Preserve firmware counter value across stop/start
      RISC-V: KVM: Report snapshot write failure to the guest
      RISC-V: KVM: Fix perf-backed counter accounting across stop and read

Shakeel Butt (1):
      mm/mlock: use the IRQ-safe accessor for NR_MLOCK in __munlock_folio()

Shay Drory (1):
      net/mlx5: devcom, Base component size on linked devices

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

Shivaprasad G Bhat (1):
      powerpc/iommu: Fix the overflow validation in iommu_tce_check_ioba

Shixiong Ou (2):
      drm/sysfb: ofdrm: Fix integer overflow in fb_size calculation
      drm/sysfb: ofdrm: Fix is_avivo() constant comparison bug

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

Shyam Sundar S K (3):
      platform/x86/amd/pmc: Move STB block into amd_pmc_s2d_init()
      platform/x86/amd/pmc: Move STB functionality to a new file for better code organization
      platform/x86/amd/pmc: Define enum for S2D/PMC msg_port and add helper function

Sidraya Jayagond (1):
      net/smc: fix UAF on lgr list traversal in smcr_port_err()

Simon Horman (1):
      net/smc: Address spelling errors

Siwei Zhang (1):
      xfrm: use hlist_del_init_rcu for state_cache and state_cache_input

Slavin Liu (1):
      ALSA: hda: trace PCM open only after assigning a stream

Slawomir Stepien (1):
      HID: amd_sfh: Validate PCI BAR size before mapping

Srinivas Pandruvada (2):
      platform/x86: ISST: Check for admin capability for write commands
      platform/x86: ISST: Validate max level for set feature

Srinivasan Shanmugam (1):
      drm/amdgpu: Fix missing unwind in amdgpu_ib_schedule() error path

Stanislaw Gruszka (1):
      wifi: iwlegacy: fix broadcast stations deallocation

StanleyYP Wang (1):
      wifi: mt76: mt7915: set correct background radar capability

Steven Rostedt (10):
      ring-buffer: Add helper functions for allocations
      Documentation: tracing: Add documentation about eprobes
      tracing: Clean up use of trace_create_maxlat_file()
      tracing: Take trace_array reference when opening options file
      ftrace: Take trace_array reference before accessing its ftrace_ops
      ring-buffer: Show persistent buffer dropped events in trace_pipe file
      tracing: Remove get_trigger_ops() and add count_func() from trigger ops
      tracing: Merge struct event_trigger_ops into struct event_command
      tracing: Take trace_array reference when opening a tracer options file
      tracing: Move d_max_latency out of CONFIG_FSNOTIFY protection

Sven Schnelle (1):
      selftests/ftrace: Fix unique symbol check in kprobe_non_uniq_symbol.tc

Szymon Acedański (1):
      drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV

Takashi Iwai (5):
      ALSA: bcd2000: Fix race between rawmidi and disconnect
      ALSA: 6fire: Clean ups with guard()
      ALSA: usb: 6fire: Avoid embedded URBs
      ALSA: core: Fix potential UAF after asynchronous card release
      ALSA: usb-audio: Optimize the copy of packet sizes for implicit fb handling

Tan Chi (1):
      RISC-V: KVM: Fix HSM hart status error propagation

Tejun Heo (1):
      sched/core: Make core-sched flips wait for in-flight selections

Thadeu Lima de Souza Cascardo (1):
      drm: Fix drm_pending_vblank_event leak in error path for out_fence_ptr

ThangNN99 (1):
      Bluetooth: hci_core: Fix queuing tx_work after workqueue is drained

Theodor Arsenij Larionov Trichkine (1):
      netfilter: nft_nat: fully initialise new_addr in netmap setup

Thinh Nguyen (1):
      usb: dwc3: gadget: Reinitiate stream for all host NoStream behavior

Thomas Hellström (1):
      drm/xe: Flush LSC untyped L1 dataport cache after rcs/ccs batches

Thomas Huth (1):
      kselftest/arm64: Fix size of thread_data values for pthread_join()

Thomas Zimmermann (5):
      drm/sysfb: simpledrm: Improve panel-size validation
      drm/sysfb: simpledrm: Improve stride validation
      firmware: sysfb: Move bpp-depth calculation into screen_info helper
      drm/sysfb: simpledrm: Improve framebuffer-size validation
      drm/client: Pass force parameter to client restore

Thorsten Blum (3):
      platform/x86: think-lmi: Fix current password length check
      platform/x86: think-lmi: Fix certificate thumbprint sysfs output
      net: ipconfig: Remove outdated comment and indent code block

Théo Lebrun (2):
      usb: cdns3: rename hibernated argument of role->resume() to lost_power
      net: macb: unify device pointer naming convention

Tianchu Chen (2):
      wifi: rsi: fix heap OOB write on key removal
      wifi: wilc1000: fix RX buffer OOB-write in wilc_wlan_handle_isr_ext()

Tingmao Wang (1):
      selftests/landlock: Add tests for access through disconnected paths

Tristan Madani (1):
      nvme: add missing SRCU grace period in error path

Tzung-Bi Shih (5):
      Bluetooth: btmtksdio: Fix PM runtime reference leak in shutdown
      watchdog: digicolor: Avoid division by zero
      watchdog: msc313e: Fix premature reset during timeout update
      watchdog: msc313e: Propagate error code in resume()
      watchdog: rtd119x: Avoid division by zero

Usama Arif (1):
      mm/hugetlb: create hstate_is_gigantic_no_runtime helper

Uwe Kleine-König (1):
      hwrng: drivers - Switch back to struct platform_driver::remove()

Val Packett (1):
      ASoC: codecs: aw88261: reduce log spam

Vasileios Almpanis (2):
      configfs: pin the symlink target's dirent instead of chasing ->ci_dentry
      configfs: unhash the dentry before dropping the item in rmdir

Vasily Gorbik (2):
      s390/boot: Add sized_strscpy() to enable strscpy() usage
      s390/boot: Avoid IPL parameter append past command line

Victor Nogueira (1):
      net/sched: act_gate: budget the per-entry list in get_fill_size

Viken Dadhaniya (1):
      i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL

Vincent Donnefort (3):
      ring-buffer: Fix subbuf resize race with ring_buffer_alloc_read_page()
      ring-buffer: Make cpu_buffer::free_page a buffer_data_read_page
      ring-buffer: Allow splice reads on static buffers

Vineeth Vijayan (4):
      s390/cio: Fix cio_update_schib() to not cache invalid schib
      s390/cio: Check pmcw.dnv before pmcw.ena in I/O entry points
      s390/cio: Guard PMCW field accesses with dnv check
      s390/cio: Fix NULL pointer dereference in ccw_device_get_util_str()

Viresh Kumar (1):
      virtio-mmio: Remove virtqueue list from mmio device

Vivek BalachandharTN (1):
      staging: rtl8723bs: fix spacing around operators

Wei Jie LAW (1):
      HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()

Weimin Xiong (1):
      iommu/msm: Unwind probe state on registration failure

Weiming Shi (6):
      Bluetooth: coredump: Quiesce dump work on unregister
      bpf: Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL
      bpf: Skip unsettled links in link iterator
      bpf: Reject dev-bound-only programs on other devices
      net/sched: reject IDR error pointers when deleting actions
      netfilter: ip6t_rpfilter: reject routes without inet6_dev

Wenjie Qi (2):
      f2fs: validate MOVE_RANGE destination size
      f2fs: limit recovery filename logging to stored length

Wentao Liang (17):
      ata: libahci_platform: Fix device reference leak in ahci_platform_get_resources()
      cifs: Fix server use-after-free in cifs_chan_skip_or_disable()
      watchdog: sp5100_tco: Fix pci_dev reference leak in sp5100_tco_init()
      watchdog: starfive-wdt: Fix runtime PM leak in starfive_wdt_pm_start()
      fsl/fman: Fix clk reference leak in read_dts_node()
      gpio: arizona: Fix runtime PM leak in arizona_gpio_direction_out()
      drm/amd/display: Fix dc stream excess put in dm_update_crtc_state()
      drm/amdgpu: Fix last_update fence leak in amdgpu_vm_init()
      drm/amdgpu: Fix runtime PM leak in amdgpu_debugfs_test_ib_show()
      drm/amdgpu: Fix vmid_wait fence leak in amdgpu_ring_init()
      drm/nouveau: Fix bridge reference leak in nv1a_ram_new()
      drm/nouveau: Fix gem reference leak in validate_init()
      drm/nouveau: Fix runtime PM leak in nouveau_connector_detect()
      net/mlx5: Fix rev_entry reference leak in mlx5_tc_ct_shared_counter_get()
      net: hisilicon: hns_dsaf_mac: fix mdio device leak in hns_mac_register_phy()
      net: usb: lan78xx: Fix URB reference leak in lan78xx_submit_deferred_urbs()
      drm/amdgpu: Fix acpi device leak in amdgpu_acpi_enumerate_xcc()

Wenwu Hou (1):
      erofs: fix large folio race in erofs_fscache_req_complete

Will Chen (1):
      bnxt: fix memory leak in bnxt_queue_mem_alloc error cases

Willem de Bruijn (3):
      virtio_net: copy zerocopy frags in start_xmit without NAPI
      tcp: prevent collapsing skbs across boundary in rtx queue
      packet: use ubuf_info completion for TX_RING packets

Wyatt Feng (1):
      net: xfrm: reject unrepresentable espintcp transport headers

Xiang Mei (3):
      ALSA: 6fire: fix OOB write from device-reported iso length
      ALSA: usb-audio: Clamp implicit feedback packet count to URB capacity
      vlan: require the MAC header to be present in __vlan_insert_inner_tag()

Xie Bo (1):
      RISC-V: KVM: Serialize IMSIC attributes with vCPU migration

Xin Long (1):
      sctp: hold asoc or transport before mod_timer() in timer handlers

XingWang Xiang (1):
      genetlink: pin family module during policy dump

Xiong Weimin (1):
      virtio_mmio: disable IRQ wake before free_irq

Xixin Liu (2):
      firmware: arm_scpi: reject DVFS OPP count above MAX_DVFS_OPPS
      clk: scpi: bound-check DVFS index in scpi_dvfs_recalc_rate

Xu Rao (2):
      mmc: spi: reset bytes_xfered before retrying CRC failures
      ALSA: hda/ext: preserve PPLCCTL bits when clearing reset

Xu Yang (1):
      usb: typec: tcpm: fix debug accessory mode detection for sink ports

Xuanqiang Luo (2):
      net/sched: act_api: release tail references on DELACTION failure
      ip_gre: Reject enabling collect metadata through changelink

Yabin Cui (1):
      perf/aux: Allocate non-contiguous AUX pages by default

Yehyeong Lee (3):
      IB/iser: reject a remote invalidation of an unregistered direction
      IB/isert: wait for deferred control PDU completions before releasing the connection
      scsi: libiscsi_tcp: Check the data direction of a Data-In PDU

Yi Liu (1):
      iommufd: Pass @pasid through the device attach/replace path

Yibo Tan (1):
      hwmon: (pwm-fan) Stop RPM timer before freeing tach data

Yifei Gao (1):
      memstick: ms_block: destroy io_queue workqueue on removal

Yige Jiang (1):
      net: netsec: fix device_node reference leak on phy_np

Yilin Zhang (1):
      tcp: fix use-after-free of retransmit_skb_hint in tcp_send_synack()

Yiqi Sun (1):
      sctp: avoid livelock while updating retransmit path

Yosry Ahmed (2):
      KVM: x86: Check EFER validity on KVM_SET_SREGS*
      KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported

Yuhang.chen (1):
      wifi: rtw89: pci: add .shutdown callback to stop rfkill polling on reboot

Yuho Choi (1):
      ALSA: virtio: reset device before deleting virtqueues

Yunxiang Li (1):
      drm: add drm_memory_stats_is_zero

Yuqi Xu (2):
      bpf: Check params size before reading reserved fields
      net: ipconfig: bound DHCP option construction

ZHOU Jiaxiang (1):
      scsi: sd_zbc: Reject disks with too many zones

Zeng Chi (1):
      KVM: Don't treat reserved xarray entries as having memory attributes

Zeng Heng (1):
      arm64: io: Reject non-user protection in ioremap_prot()

Zhang Heng (1):
      iommu/msm: Use helper function devm_clk_get_prepared()

Zhao Gongyi (1):
      bpf, sockmap: Reject max_entries > INT_MAX in sock_map_alloc

Zhao Li (1):
      wifi: mwifiex: validate action frame fixed fields

Zhiling Zou (6):
      openvswitch: avoid reallocating confirmed conntrack labels
      ipv6: xfrm: use full sockets in local error paths
      xfrm: save input state data before secpath resets
      xsk: Use a 32-bit compare in xsk_map_gen_lookup
      net: bridge: use option bits for CFM/MRP frame handlers
      ipv6: flowlabel: cap duplicate leases per socket

Zhu Ling (1):
      mmc: core: Fix OF node reference leak on card add failure

Zi Yan (1):
      mm/huge_memory: use folio's memcg inside __folio_split()

Zihan Xi (5):
      wifi: virt_wifi: don't transfer operstate before register
      smb: client: fix create context out-of-bounds reads
      smb: client: clean up failed cached directory opens
      smb: client: validate POSIX create context length
      ipmr: account multicast table and route memory

Zijie Huang (1):
      net: arp: terminate device name before lookup

Zixuan Chai (1):
      llc: reserve device headroom for allocated frames

Zizhi Wo (1):
      smb: client: fix busy dentry warning on unmount after DIO

Zong-Zhe Yang (1):
      wifi: rtw89: cleanup unused rtwdev::roc_work

bui duc phuc (1):
      net: ethernet: ti: netcp: fix pm_runtime usage counter leak on error

shechenglong (1):
      drm/client: fix restore of partially initialized client

wangzijie (2):
      f2fs: convert F2FS_I_SB to sbi in f2fs_setattr()
      f2fs: don't allow unaligned truncation to smaller/equal size on pinned file

Ömer Mete Kaya (3):
      nfc: llcp: fix -ENOMEM on connect with zero-length service name
      nfc: llcp: fix WKS SAP hijacking via prefix match in nfc_llcp_wks_sap()
      nfc: llcp: fix slab-out-of-bounds reads when logging service names

