Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8CA4457A6;
	Fri, 11 Sep 2026 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126154; cv=none; b=D4ErxRhmCBFIjrk1XZcE39pNJ7PC9yzvtWvTn4ojDx5G7tni31EhkU+H4PYrsvMLBHfBVtHbJJzjp/ZFB4KqeG2PrgAQ5zPOT4F0s0kTzY07bvhTKmiunq6tCjOiASbwBXziIjFBnNGGF/JKyZxA3vr3nthR1EU7G6WzZ8lYfDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126154; c=relaxed/simple;
	bh=oWM5007ssQGu8OoJnsfGJVTNuV2Eau4XTXIJ8EVcnH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u7OiTsWPirlBwGdyh6+rf8SbapK1OHO513/Gc50hxQWEztld1ZJJxcNTLUG6s4Q+GW+9aHAWTTMTBuy3EHBHYK5TY3Sh7AeMC2JPnQJ6NGEV9qPeSDBH/xbRbbNoRv86dr/LBCGyYRrALHiEWBqMnjU39yx52uyusshmKSB62WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WVNsMEqT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WVNsMEqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1EB1F000FF;
	Fri, 11 Sep 2026 11:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789126132;
	bh=jmyQYR2O/xnJ3muQ+yVCslFYIWsy9Z98C31gE2t1ZeI=;
	h=From:To:Cc:Subject:Date;
	b=WVNsMEqTkK5V8M3qybCvQmlf9+9Hh6O58brJkGHK0d5CYXFLxZOqqELrDJ4cmoQLK
	 fXgv5DisgR0eKQvMdumbEl0PhJgUH7VYn+zI3C4ygFNZhvDYfvXY/BLf60Ar19Z1rb
	 bliBkDE0bfRt0KD/7bsive0U2Cong139MieA7m9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.2.5
Date: Fri, 11 Sep 2026 13:28:21 +0200
Message-ID: <2026091122-audience-emotion-e092@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.2.5 kernel.

All users of the 7.2 kernel series must upgrade.

The updated 7.2.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.2.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-kernel-mm-damon                                    |    8 
 Documentation/admin-guide/cgroup-v1/memory.rst                                     |   49 --
 Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml                          |    4 
 Documentation/trace/hisi-ptt.rst                                                   |   28 -
 Documentation/userspace-api/media/v4l/ext-ctrls-colorimetry.rst                    |   12 
 Makefile                                                                           |    2 
 arch/arm64/include/asm/cpu.h                                                       |    1 
 arch/arm64/include/asm/cpufeature.h                                                |    7 
 arch/arm64/include/asm/kvm_host.h                                                  |    3 
 arch/arm64/include/asm/kvm_nested.h                                                |   20 
 arch/arm64/kernel/cpu_errata.c                                                     |    2 
 arch/arm64/kernel/cpufeature.c                                                     |   33 +
 arch/arm64/kernel/cpuinfo.c                                                        |    2 
 arch/arm64/kvm/at.c                                                                |    2 
 arch/arm64/kvm/hyp/vhe/switch.c                                                    |    3 
 arch/arm64/kvm/nested.c                                                            |  139 ++++--
 arch/arm64/kvm/sys_regs.c                                                          |   11 
 arch/arm64/kvm/vgic/vgic-init.c                                                    |    1 
 arch/arm64/kvm/vgic/vgic-its.c                                                     |    8 
 arch/arm64/kvm/vgic/vgic-v3-nested.c                                               |    2 
 arch/arm64/kvm/vgic/vgic-v3.c                                                      |   12 
 arch/arm64/mm/fault.c                                                              |   12 
 arch/loongarch/Kconfig                                                             |    2 
 arch/loongarch/include/asm/kvm_dmsintc.h                                           |    1 
 arch/loongarch/include/asm/kvm_eiointc.h                                           |    1 
 arch/loongarch/include/asm/kvm_host.h                                              |    1 
 arch/loongarch/include/asm/kvm_ipi.h                                               |    1 
 arch/loongarch/include/asm/kvm_pch_pic.h                                           |    1 
 arch/loongarch/include/asm/pgtable.h                                               |    9 
 arch/loongarch/kernel/acpi.c                                                       |    3 
 arch/loongarch/kernel/kprobes.c                                                    |    3 
 arch/loongarch/kernel/rethook_trampoline.S                                         |    2 
 arch/loongarch/kvm/exit.c                                                          |    1 
 arch/loongarch/kvm/intc/dmsintc.c                                                  |    8 
 arch/loongarch/kvm/intc/eiointc.c                                                  |    5 
 arch/loongarch/kvm/intc/ipi.c                                                      |    5 
 arch/loongarch/kvm/intc/pch_pic.c                                                  |    8 
 arch/loongarch/kvm/main.c                                                          |   39 +
 arch/loongarch/kvm/mmu.c                                                           |   10 
 arch/loongarch/kvm/vcpu.c                                                          |    8 
 arch/loongarch/kvm/vm.c                                                            |    1 
 arch/loongarch/mm/init.c                                                           |   17 
 arch/loongarch/net/bpf_jit.c                                                       |   40 -
 arch/parisc/kernel/head.S                                                          |    1 
 arch/powerpc/include/asm/papr-watchdog.h                                           |   64 +++
 arch/powerpc/include/asm/reg.h                                                     |   12 
 arch/powerpc/kexec/file_load_64.c                                                  |    2 
 arch/powerpc/kexec/ranges.c                                                        |   12 
 arch/powerpc/kvm/book3s_hv.c                                                       |   15 
 arch/powerpc/kvm/powerpc.c                                                         |    6 
 arch/powerpc/mm/book3s64/radix_pgtable.c                                           |    7 
 arch/powerpc/platforms/pseries/setup.c                                             |   28 +
 arch/riscv/net/bpf_jit_comp64.c                                                    |   10 
 arch/s390/include/asm/nmi.h                                                        |    3 
 arch/s390/kernel/nmi.c                                                             |    5 
 arch/s390/kvm/guestdbg.c                                                           |    9 
 arch/s390/kvm/interrupt.c                                                          |   26 -
 arch/s390/kvm/kvm-s390.c                                                           |   22 -
 arch/x86/events/intel/core.c                                                       |   10 
 arch/x86/events/intel/lbr.c                                                        |   12 
 arch/x86/events/perf_event.h                                                       |    2 
 arch/x86/include/asm/kvm-x86-ops.h                                                 |    4 
 arch/x86/include/asm/kvm_host.h                                                    |    6 
 arch/x86/kvm/hyperv.c                                                              |   25 -
 arch/x86/kvm/mmu/mmu.c                                                             |  107 +++--
 arch/x86/kvm/mmu/tdp_iter.h                                                        |    7 
 arch/x86/kvm/mmu/tdp_mmu.c                                                         |   20 
 arch/x86/kvm/svm/sev.c                                                             |   80 +++
 arch/x86/kvm/svm/svm.c                                                             |    6 
 arch/x86/kvm/svm/svm.h                                                             |    2 
 arch/x86/kvm/vmx/nested.c                                                          |   75 ++-
 arch/x86/kvm/x86.c                                                                 |   17 
 arch/x86/kvm/x86.h                                                                 |    2 
 block/genhd.c                                                                      |    7 
 drivers/accel/amdxdna/amdxdna_gem.c                                                |    3 
 drivers/accel/ethosu/ethosu_drv.c                                                  |    2 
 drivers/accel/ethosu/ethosu_job.c                                                  |   10 
 drivers/acpi/battery.c                                                             |  155 +++++--
 drivers/ata/ahci.c                                                                 |   49 ++
 drivers/block/ublk_drv.c                                                           |    6 
 drivers/block/zram/zram_drv.c                                                      |   27 -
 drivers/block/zram/zram_drv.h                                                      |   16 
 drivers/clk/mediatek/Kconfig                                                       |    1 
 drivers/clk/meson/gxbb.c                                                           |    2 
 drivers/clk/microchip/clk-mpfs.c                                                   |    2 
 drivers/clk/qcom/gcc-mdm9607.c                                                     |  182 --------
 drivers/clk/qcom/gcc-msm8916.c                                                     |    5 
 drivers/clk/qcom/gcc-msm8939.c                                                     |    5 
 drivers/clk/rockchip/clk-rk3588.c                                                  |    2 
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c                                         |    4 
 drivers/cpuidle/cpuidle-psci.c                                                     |   42 --
 drivers/cpuidle/dt_idle_genpd.c                                                    |    3 
 drivers/dma-buf/dma-buf.c                                                          |   20 
 drivers/dma-buf/dma-heap.c                                                         |   80 +--
 drivers/dma/dw-edma/dw-edma-core.c                                                 |   24 -
 drivers/dma/dw-edma/dw-hdma-v0-core.c                                              |    2 
 drivers/dma/fsl-edma-trace.h                                                       |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                                   |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c                                   |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                         |   59 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                            |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                                            |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c                                            |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                                             |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c                                       |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c                                           |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                             |    8 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                                             |    8 
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                                              |    8 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                                              |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                              |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                           |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                              |   23 +
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c                                           |   56 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                             |   12 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                                  |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c                            |   13 
 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h |    4 
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c                    |    1 
 drivers/gpu/drm/amd/display/dc/link/link_factory.c                                 |    2 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c                    |    5 
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c                                          |    3 
 drivers/gpu/drm/drm_atomic_uapi.c                                                  |    2 
 drivers/gpu/drm/drm_drv.c                                                          |   34 +
 drivers/gpu/drm/drm_pagemap.c                                                      |  128 +++++-
 drivers/gpu/drm/gud/gud_connector.c                                                |   12 
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c                                     |   52 --
 drivers/gpu/drm/i915/display/intel_cursor.c                                        |   15 
 drivers/gpu/drm/i915/display/skl_universal_plane.c                                 |   15 
 drivers/gpu/drm/i915/i915_pci.c                                                    |    3 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                                 |   12 
 drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h                                 |    1 
 drivers/gpu/drm/nouveau/nouveau_chan.c                                             |    9 
 drivers/gpu/drm/nouveau/nouveau_dmem.c                                             |   18 
 drivers/gpu/drm/nouveau/nouveau_sgdma.c                                            |    4 
 drivers/gpu/drm/nouveau/nouveau_uvmm.c                                             |    6 
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c                                  |   10 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild                                    |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c                                   |   13 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c                                   |  191 +++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c                                   |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h                                    |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h                                     |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h                                    |   17 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c                                   |   86 ++++
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c                             |  129 ++----
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/disp.c                             |   64 +++
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c                              |    9 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/disp.h                        |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h                                    |    5 
 drivers/gpu/drm/panel/panel-edp.c                                                  |   19 
 drivers/gpu/drm/panthor/panthor_fw.c                                               |   22 -
 drivers/gpu/drm/solomon/ssd130x.c                                                  |    9 
 drivers/gpu/drm/sun4i/sun4i_backend.c                                              |    2 
 drivers/gpu/drm/sysfb/ofdrm.c                                                      |    8 
 drivers/gpu/drm/sysfb/simpledrm.c                                                  |   74 ++-
 drivers/gpu/drm/ttm/ttm_pool.c                                                     |   15 
 drivers/gpu/drm/xe/xe_vram.c                                                       |   26 +
 drivers/hid/bpf/hid_bpf_struct_ops.c                                               |   17 
 drivers/hid/hid-rmi.c                                                              |   46 ++
 drivers/hid/hid-sony.c                                                             |   87 +---
 drivers/hid/wacom_wac.c                                                            |   13 
 drivers/i2c/busses/i2c-designware-platdrv.c                                        |    2 
 drivers/i2c/busses/i2c-qcom-cci.c                                                  |   11 
 drivers/i2c/busses/i2c-qcom-geni.c                                                 |    4 
 drivers/i2c/i2c-core-base.c                                                        |    6 
 drivers/i2c/i2c-mux.c                                                              |    1 
 drivers/i2c/muxes/i2c-demux-pinctrl.c                                              |    1 
 drivers/iio/adc/Kconfig                                                            |    2 
 drivers/iio/adc/ad4080.c                                                           |    5 
 drivers/iio/adc/adi-axi-adc.c                                                      |   30 +
 drivers/iio/adc/pac1921.c                                                          |    2 
 drivers/iio/adc/ti-ads7138.c                                                       |   42 +-
 drivers/iio/chemical/atlas-sensor.c                                                |   19 
 drivers/iio/chemical/sgp30.c                                                       |    3 
 drivers/iio/dac/Kconfig                                                            |    1 
 drivers/iio/dac/ad3552r-hs.c                                                       |    2 
 drivers/iio/dac/ad5446-i2c.c                                                       |    2 
 drivers/iio/dac/m62332.c                                                           |   17 
 drivers/iio/gyro/mpu3050-core.c                                                    |    2 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c                                     |    5 
 drivers/iio/industrialio-buffer.c                                                  |   38 -
 drivers/iio/light/apds9306.c                                                       |    8 
 drivers/iio/light/cm32181.c                                                        |    2 
 drivers/iio/light/gp2ap002.c                                                       |   10 
 drivers/iio/light/ltrf216a.c                                                       |    3 
 drivers/iio/light/opt4001.c                                                        |   37 -
 drivers/iio/light/opt4060.c                                                        |    5 
 drivers/iio/pressure/dps310.c                                                      |    3 
 drivers/iio/pressure/mpl115.c                                                      |   11 
 drivers/iio/proximity/srf04.c                                                      |    1 
 drivers/iio/temperature/hid-sensor-temperature.c                                   |    3 
 drivers/irqchip/irq-mbigen.c                                                       |   20 
 drivers/irqchip/irq-stm32mp-exti.c                                                 |    4 
 drivers/md/dm.c                                                                    |   14 
 drivers/media/cec/core/cec-adap.c                                                  |   10 
 drivers/media/cec/core/cec-core.c                                                  |    2 
 drivers/media/cec/platform/meson/ao-cec-g12a.c                                     |    1 
 drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c                  |    3 
 drivers/media/dvb-frontends/rtl2832_sdr.c                                          |   21 -
 drivers/media/i2c/alvium-csi2.c                                                    |    2 
 drivers/media/i2c/imx355.c                                                         |    3 
 drivers/media/i2c/imx415.c                                                         |    4 
 drivers/media/i2c/ov02a10.c                                                        |   12 
 drivers/media/i2c/ov7740.c                                                         |    4 
 drivers/media/i2c/ov9282.c                                                         |    3 
 drivers/media/i2c/vd55g1.c                                                         |   32 +
 drivers/media/i2c/video-i2c.c                                                      |    8 
 drivers/media/pci/cobalt/cobalt-alsa-main.c                                        |    1 
 drivers/media/pci/cx23885/cimax2.c                                                 |    1 
 drivers/media/pci/intel/ipu-bridge.c                                               |    8 
 drivers/media/pci/intel/ipu6/ipu6-isys.c                                           |    1 
 drivers/media/pci/saa7164/saa7164-core.c                                           |    8 
 drivers/media/pci/zoran/zoran_card.c                                               |    2 
 drivers/media/platform/amphion/venc.c                                              |    2 
 drivers/media/platform/arm/mali-c55/mali-c55-core.c                                |    2 
 drivers/media/platform/arm/mali-c55/mali-c55-params.c                              |    1 
 drivers/media/platform/arm/mali-c55/mali-c55-registers.h                           |    2 
 drivers/media/platform/arm/mali-c55/mali-c55-resizer.c                             |    2 
 drivers/media/platform/broadcom/bcm2835-unicam.c                                   |    3 
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c                           |   64 ++-
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c                           |    6 
 drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h                         |    2 
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c                               |    6 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c                            |    6 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c                               |    2 
 drivers/media/platform/qcom/iris/iris_ctrls.c                                      |    2 
 drivers/media/platform/qcom/iris/iris_hfi_gen1.c                                   |   16 
 drivers/media/platform/qcom/iris/iris_platform_common.h                            |    1 
 drivers/media/platform/qcom/iris/iris_state.c                                      |    2 
 drivers/media/platform/qcom/iris/iris_vidc.c                                       |   11 
 drivers/media/platform/qcom/iris/iris_vpu_common.c                                 |    2 
 drivers/media/platform/qcom/venus/hfi_parser.c                                     |    9 
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c                             |    5 
 drivers/media/platform/rockchip/rga/rga3-hw.c                                      |   12 
 drivers/media/platform/rockchip/rkvdec/rkvdec-hevc-common.c                        |    3 
 drivers/media/platform/rockchip/rkvdec/rkvdec.c                                    |    8 
 drivers/media/platform/ti/vpe/vip.c                                                |   37 +
 drivers/media/rc/sunxi-cir.c                                                       |    9 
 drivers/media/test-drivers/vimc/vimc-capture.c                                     |    4 
 drivers/media/tuners/tda18250.c                                                    |    4 
 drivers/media/usb/airspy/airspy.c                                                  |   17 
 drivers/media/usb/cx231xx/cx231xx-video.c                                          |    4 
 drivers/media/usb/em28xx/em28xx-cards.c                                            |    3 
 drivers/media/usb/em28xx/em28xx-core.c                                             |    2 
 drivers/media/usb/go7007/snd-go7007.c                                              |   10 
 drivers/media/usb/s2255/s2255drv.c                                                 |   11 
 drivers/media/usb/usbtv/usbtv-audio.c                                              |   11 
 drivers/media/v4l2-core/v4l2-async.c                                               |    1 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                                          |   68 ++-
 drivers/media/v4l2-core/v4l2-fwnode.c                                              |    2 
 drivers/misc/fastrpc.c                                                             |   16 
 drivers/mtd/mtdoops.c                                                              |    3 
 drivers/mtd/nand/ecc-realtek.c                                                     |    1 
 drivers/mtd/nand/raw/nand_onfi.c                                                   |   27 +
 drivers/mtd/nand/raw/pl35x-nand-controller.c                                       |    5 
 drivers/mtd/nand/raw/sunxi_nand.c                                                  |  119 ++++-
 drivers/mtd/parsers/afs.c                                                          |    7 
 drivers/nvdimm/btt.c                                                               |    8 
 drivers/nvme/host/core.c                                                           |   24 +
 drivers/nvme/host/fabrics.c                                                        |    2 
 drivers/nvme/host/fc.c                                                             |   26 -
 drivers/nvme/host/tcp.c                                                            |    7 
 drivers/nvme/target/auth.c                                                         |    6 
 drivers/nvme/target/core.c                                                         |    2 
 drivers/nvme/target/nvmet.h                                                        |    2 
 drivers/nvme/target/tcp.c                                                          |   10 
 drivers/parisc/eisa.c                                                              |    5 
 drivers/pci/hotplug/pnv_php.c                                                      |    2 
 drivers/pci/hotplug/rpaphp_slot.c                                                  |    2 
 drivers/pci/pci.c                                                                  |    5 
 drivers/pci/slot.c                                                                 |   50 +-
 drivers/pmdomain/mediatek/Kconfig                                                  |    5 
 drivers/pmdomain/qcom/rpmhpd.c                                                     |    4 
 drivers/power/supply/ab8500_fg.c                                                   |   32 +
 drivers/remoteproc/qcom_q6v5_pas.c                                                 |   13 
 drivers/rtc/rtc-rzn1.c                                                             |   30 +
 drivers/s390/crypto/vfio_ap_ops.c                                                  |  203 ++++++----
 drivers/scsi/megaraid/megaraid_sas_base.c                                          |   13 
 drivers/scsi/pm8001/pm8001_init.c                                                  |    4 
 drivers/scsi/qla2xxx/qla_attr.c                                                    |    6 
 drivers/scsi/qla2xxx/qla_bsg.c                                                     |   46 +-
 drivers/scsi/qla2xxx/qla_dbg.c                                                     |    2 
 drivers/scsi/qla2xxx/qla_dfs.c                                                     |    4 
 drivers/scsi/qla2xxx/qla_edif.c                                                    |    3 
 drivers/scsi/qla2xxx/qla_gs.c                                                      |    4 
 drivers/scsi/qla2xxx/qla_init.c                                                    |   61 ++-
 drivers/scsi/qla2xxx/qla_inline.h                                                  |   13 
 drivers/scsi/qla2xxx/qla_isr.c                                                     |   39 +
 drivers/scsi/qla2xxx/qla_mbx.c                                                     |   28 -
 drivers/scsi/qla2xxx/qla_nvme.c                                                    |   31 +
 drivers/scsi/qla2xxx/qla_os.c                                                      |   14 
 drivers/scsi/scsi_bsg.c                                                            |   47 +-
 drivers/soc/fsl/qe/qe_ports_ic.c                                                   |    7 
 drivers/soc/qcom/qcom-geni-se.c                                                    |   24 -
 drivers/spi/spi-bcm63xx-hsspi.c                                                    |    8 
 drivers/spi/spi-bcm63xx.c                                                          |    6 
 drivers/spi/spi-bcmbca-hsspi.c                                                     |    8 
 drivers/spi/spi.c                                                                  |   34 -
 drivers/staging/media/meson/vdec/vdec.c                                            |    4 
 drivers/staging/media/sunxi/cedrus/cedrus.c                                        |    4 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c                                     |    7 
 drivers/staging/rtl8723bs/core/rtw_mlme.c                                          |    3 
 drivers/target/iscsi/iscsi_target_login.c                                          |    2 
 drivers/thermal/imx_thermal.c                                                      |    9 
 drivers/thermal/qoriq_thermal.c                                                    |   13 
 drivers/usb/cdns3/cdnsp-gadget.c                                                   |  111 +++++
 drivers/usb/cdns3/cdnsp-gadget.h                                                   |    1 
 drivers/usb/cdns3/cdnsp-mem.c                                                      |   98 +---
 drivers/usb/dwc3/dwc3-google.c                                                     |    1 
 drivers/usb/dwc3/ep0.c                                                             |    2 
 drivers/usb/dwc3/gadget.c                                                          |   21 -
 drivers/usb/gadget/function/f_fs.c                                                 |   31 +
 drivers/usb/gadget/function/f_mass_storage.c                                       |    5 
 drivers/usb/gadget/function/f_midi.c                                               |    2 
 drivers/usb/gadget/function/f_midi2.c                                              |   17 
 drivers/usb/gadget/functions.c                                                     |    2 
 drivers/usb/gadget/legacy/inode.c                                                  |    3 
 drivers/usb/host/xhci-ring.c                                                       |   32 +
 drivers/usb/image/mdc800.c                                                         |    4 
 drivers/usb/storage/ene_ub6250.c                                                   |    2 
 drivers/usb/storage/realtek_cr.c                                                   |    9 
 drivers/usb/typec/hd3ss3220.c                                                      |    9 
 drivers/usb/typec/mux.c                                                            |   21 -
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c                                |    2 
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c                                 |    5 
 drivers/usb/typec/tcpm/tcpm.c                                                      |   28 +
 drivers/usb/typec/tipd/core.c                                                      |   17 
 drivers/usb/typec/tipd/tps6598x.h                                                  |    4 
 drivers/usb/typec/ucsi/displayport.c                                               |    2 
 drivers/watchdog/pseries-wdt.c                                                     |   53 --
 fs/ceph/crypto.c                                                                   |   50 +-
 fs/ceph/mds_client.c                                                               |   12 
 fs/ceph/mds_client.h                                                               |    1 
 fs/f2fs/data.c                                                                     |    8 
 fs/f2fs/debug.c                                                                    |    4 
 fs/f2fs/dir.c                                                                      |    7 
 fs/f2fs/f2fs.h                                                                     |   29 +
 fs/f2fs/file.c                                                                     |  170 ++++++--
 fs/f2fs/gc.c                                                                       |   38 -
 fs/f2fs/gc.h                                                                       |   27 -
 fs/f2fs/inline.c                                                                   |    2 
 fs/f2fs/iostat.c                                                                   |    6 
 fs/f2fs/namei.c                                                                    |   17 
 fs/f2fs/node.c                                                                     |   10 
 fs/f2fs/recovery.c                                                                 |   41 +-
 fs/f2fs/segment.c                                                                  |   18 
 fs/f2fs/super.c                                                                    |    4 
 fs/f2fs/sysfs.c                                                                    |   30 -
 fs/f2fs/xattr.c                                                                    |    2 
 fs/nfsd/nfs4proc.c                                                                 |    5 
 fs/nfsd/nfs4state.c                                                                |  118 ++++-
 fs/nfsd/nfsctl.c                                                                   |    6 
 fs/ntfs3/frecord.c                                                                 |   20 
 fs/smb/server/oplock.c                                                             |   79 ++-
 fs/smb/server/smb2pdu.c                                                            |    7 
 include/linux/dma-buf.h                                                            |    1 
 include/linux/ftrace.h                                                             |    5 
 include/linux/kprobes.h                                                            |    1 
 include/linux/kvm_host.h                                                           |    1 
 include/linux/pci.h                                                                |    8 
 include/linux/sched/rt.h                                                           |    2 
 include/linux/sched/user.h                                                         |    3 
 include/linux/soc/qcom/geni-se.h                                                   |    4 
 include/trace/events/f2fs.h                                                        |   20 
 kernel/bpf/percpu_freelist.c                                                       |   35 +
 kernel/bpf/percpu_freelist.h                                                       |    1 
 kernel/bpf/stackmap.c                                                              |  173 +++++---
 kernel/dma/direct.c                                                                |   18 
 kernel/events/core.c                                                               |   20 
 kernel/futex/pi.c                                                                  |   16 
 kernel/futex/requeue.c                                                             |   12 
 kernel/kprobes.c                                                                   |   14 
 kernel/locking/rtmutex_api.c                                                       |    2 
 kernel/sched/core.c                                                                |   16 
 kernel/trace/ftrace.c                                                              |   70 ++-
 kernel/trace/ring_buffer.c                                                         |   11 
 kernel/trace/trace.c                                                               |   67 +++
 kernel/trace/trace.h                                                               |    5 
 kernel/trace/trace_btf.c                                                           |   12 
 kernel/trace/trace_events.c                                                        |   28 +
 kernel/trace/trace_functions.c                                                     |    2 
 kernel/trace/trace_stack.c                                                         |    2 
 lib/once.c                                                                         |    2 
 mm/damon/core.c                                                                    |   27 -
 mm/damon/ops-common.c                                                              |    5 
 mm/damon/paddr.c                                                                   |   20 
 mm/damon/sysfs-schemes.c                                                           |   18 
 mm/damon/sysfs.c                                                                   |   29 +
 mm/damon/tests/core-kunit.h                                                        |   33 +
 mm/damon/tests/vaddr-kunit.h                                                       |    5 
 mm/damon/vaddr.c                                                                   |   34 -
 mm/huge_memory.c                                                                   |    2 
 mm/hugetlb.c                                                                       |   20 
 mm/hugetlb_cgroup.c                                                                |    7 
 mm/hugetlb_cma.c                                                                   |   21 -
 mm/khugepaged.c                                                                    |    6 
 mm/madvise.c                                                                       |    8 
 mm/memcontrol-v1.c                                                                 |   43 +-
 mm/memcontrol.c                                                                    |  113 ++++-
 mm/mempolicy.c                                                                     |    2 
 mm/migrate_device.c                                                                |   18 
 mm/page_alloc.c                                                                    |    6 
 mm/secretmem.c                                                                     |  116 +++++
 mm/userfaultfd.c                                                                   |    4 
 net/batman-adv/bridge_loop_avoidance.c                                             |   15 
 net/batman-adv/distributed-arp-table.c                                             |    8 
 net/batman-adv/main.c                                                              |    4 
 net/batman-adv/mesh-interface.c                                                    |    7 
 net/batman-adv/multicast_forw.c                                                    |    7 
 net/core/skbuff.c                                                                  |    5 
 net/sunrpc/xprtrdma/ib_client.c                                                    |   24 -
 rust/kernel/drm/ioctl.rs                                                           |    6 
 samples/damon/mtier.c                                                              |   14 
 samples/damon/prcl.c                                                               |   11 
 samples/damon/wsse.c                                                               |   11 
 security/integrity/ima/ima_appraise.c                                              |    2 
 sound/core/pcm_native.c                                                            |    2 
 sound/core/rawmidi.c                                                               |    2 
 sound/parisc/harmony.c                                                             |    6 
 sound/soc/codecs/adau1761.c                                                        |   34 -
 sound/soc/codecs/cs35l33.c                                                         |   14 
 sound/soc/codecs/cs35l34.c                                                         |   14 
 sound/soc/codecs/cx2072x.c                                                         |  122 +++---
 sound/soc/codecs/hdac_hda.c                                                        |    4 
 sound/soc/codecs/max9860.c                                                         |    2 
 sound/soc/codecs/ml26124.c                                                         |    4 
 sound/soc/codecs/pcm512x.c                                                         |   40 -
 sound/soc/codecs/pm4125-sdw.c                                                      |    2 
 sound/soc/codecs/rt1017-sdca-sdw.h                                                 |   10 
 sound/soc/codecs/rt1316-sdw.c                                                      |    2 
 sound/soc/codecs/rt1318-sdw.c                                                      |    2 
 sound/soc/codecs/rt1318.c                                                          |    4 
 sound/soc/codecs/rt274.c                                                           |    8 
 sound/soc/codecs/rt286.c                                                           |   12 
 sound/soc/codecs/rt298.c                                                           |   12 
 sound/soc/codecs/rt700-sdw.h                                                       |   11 
 sound/soc/codecs/rt711-sdca-sdw.h                                                  |    6 
 sound/soc/codecs/rt711-sdw.h                                                       |   10 
 sound/soc/codecs/rt712-sdca-dmic.h                                                 |    6 
 sound/soc/codecs/rt712-sdca-sdw.h                                                  |   11 
 sound/soc/codecs/rt715-sdca-sdw.h                                                  |   12 
 sound/soc/codecs/rt715-sdw.h                                                       |   32 -
 sound/soc/codecs/rt721-sdca-sdw.h                                                  |   28 -
 sound/soc/codecs/sgtl5000.c                                                        |    2 
 sound/soc/codecs/sti-sas.c                                                         |    2 
 sound/soc/codecs/tas2552.c                                                         |   14 
 sound/soc/codecs/tas2764.c                                                         |    2 
 sound/soc/codecs/tas2780.c                                                         |    2 
 sound/soc/codecs/tas2783-sdw.c                                                     |  171 ++++----
 sound/soc/fsl/fsl_easrc.c                                                          |    8 
 sound/soc/fsl/mpc5200_psc_i2s.c                                                    |    1 
 sound/soc/intel/atom/sst/sst_pci.c                                                 |    4 
 sound/soc/loongson/loongson_card.c                                                 |    6 
 sound/soc/samsung/aries_wm8994.c                                                   |    1 
 sound/usb/midi.c                                                                   |    2 
 tools/perf/Makefile.config                                                         |    2 
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c                              |  155 ++++---
 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c                            |   47 +-
 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h                            |   12 
 tools/testing/selftests/mm/memfd_secret.c                                          |   30 -
 virt/kvm/guest_memfd.c                                                             |    4 
 462 files changed, 5650 insertions(+), 2710 deletions(-)

Abdifatah Suruur (1):
      ksmbd: fix use-after-free in oplock break notification

Abel Vesa (1):
      Revert "pmdomain: qcom: rpmhpd: Add missing MXC and MMCX power domains for Eliza"

Ahmad Byagowi (1):
      i2c: mux: Fix channel node leak on adapter add failure

Akari Tsuyukusa (1):
      clk: mediatek: mt8196: Select REGMAP_MMIO for vlpckgen

Aleksandr Nogikh (1):
      usb: gadget: midi2: Fix null-pointer dereference in f_midi2_free_ep_reqs

Alex Deucher (1):
      drm/amdgpu/gfx8: only apply compute quantums to KCQs

Amit Barzilai (2):
      drm/ssd130x: fix column and row end address in partial updates for ssd132x
      drm/ssd130x: fix column and row end address in partial updates in ssd133x

Amit Machhiwal (1):
      KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode

Amit Sunil Dhamne (1):
      usb: typec: tcpm: constrain TCPM_SOURCING_VBUS event handling

Andy Shevchenko (1):
      usb: f_mass_storage: Bump local buffer size in fsg_common_create_luns()

Aneesh Kumar K.V (Arm) (1):
      dma-direct: return struct page from dma_direct_alloc_from_pool()

Anthony Krowiak (9):
      s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
      s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap_mdev_cfg_remove
      s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
      s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL
      s390/vfio-ap: Fix hot-unplug skipped when last AP adapter or domain removed
      s390/vfio-ap: Fix missing lock required to access list of ap_matrix_mdev objects
      s390/vfio-ap: Fix NULL deref in status_show() during queue probe
      s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap
      s390/vfio-ap: Fix required lock not held during update of ap_matrix_mdev object

Antoniu Miclaus (2):
      iio: adc: ad4080: configure backend data size
      iio: adc: adi-axi-adc: add data size support for AD408X backend

Arash Golgol (1):
      media: vimc: fix pixel format lookup in enum_framesizes

Arthur Gautier (1):
      xhci: fix lost bounce buffers on TDs spanning several ring segments

Austin Zheng (1):
      drm/amd/display: Remove const Qualifier From Non-Pointer Fields

Babanpreet Singh (1):
      iio: dac: ad3552r-hs: fix scnprintf() buffer bound in data source show

Baineng Shou (2):
      dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds
      misc: fastrpc: don't publish fd before copy_to_user() succeeds

Baolin Wang (1):
      mm: fix incorrect vm_flags usage when checking allowable orders for tmpfs

Benjamin Mugnier (2):
      media: i2c: vd55g1: Fix manual digital gain on color variant
      media: i2c: vd55g1: Fix media bus code initialization

Bibo Mao (3):
      LoongArch: KVM: Set vcpu->cpu before IN_GUEST_MODE is set
      LoongArch: KVM: Fix uninitialized stack variable issue with dmsintc
      LoongArch: Fix acpi_package_ids[] array overflow

Binbin Zhou (1):
      ASoC: loongson: Fix error handling in ACPI property parsing

Biren Pandya (4):
      media: cec: disable delayed work before freeing an interrupted transmit
      media: i2c: ov02a10: fix endpoint parsing use-after-free
      media: i2c: ov7740: fix use-after-destroy in remove
      media: v4l2-fwnode: Fix fwnode leak in v4l2_fwnode_parse_link

Bob Zhou (1):
      drm/amdgpu: avoid force-completing uninitialized UVD rings

Bradley Morgan (1):
      ima: Check for ERR_PTR from dentry_path() in validate_hash_algo()

Brendan Jackman (1):
      mm/page_alloc: don't spin_trylock() in NMI on UP

Bryam Vargas (2):
      nvdimm/btt: reject an arena whose nfree is below the lane count
      media: cx231xx: reject geometry changes while the VBI queue is busy

Bryan Lim (1):
      userfaultfd: reset err to be 0 when move_pages_ptes succeeded

Bryan O'Donoghue (1):
      media: iris: Enumerate cap->bus_info to differentiate between encoder and decoder

Can Peng (7):
      thermal/drivers/imx: Disable clock on runtime resume failure
      thermal/drivers/qoriq: Disable clock on resume failure
      spi: bcm63xx-hsspi: disable clocks on resume failure
      spi: bcm63xx: disable clock on resume failure
      spi: bcmbca-hsspi: disable clocks on resume failure
      iio: dac: ad5446: fix OF module device table
      iio: pressure: mpl115: Fix runtime PM cleanup

Carlos López (1):
      KVM: x86: hyper-v: Clamp stimer deadline to avoid livelock

Chaithanya Lagisetty (3):
      LoongArch: KVM: Add unregister helpers for the KVM interrupt devices
      LoongArch: KVM: Fix resource leak in kvm_loongarch_env_init() error path
      LoongArch: KVM: Free init resources if kvm_init() fails

Chang Wu (1):
      usb: typec: hd3ss3220: track VBUS enable state per consumer

Chao Shi (1):
      nvme: skip the zoned limits update if the zone info query failed

Chao Yu (10):
      f2fs: fix to avoid move_range and defragment on device_alias file
      f2fs: fix to avoid potential section-unaligned pinfile
      f2fs: embed f2fs_gc_kthread in f2fs_sb_info
      f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()
      f2fs: fix to return -EFSCORRUPTED in f2fs_get_node_info() correctly
      f2fs: fix to off-by-one issue in f2fs_zero_post_eof_page()
      f2fs: fix to clear dirty flag on folio in error path
      f2fs: fix to reclaim space in f2fs_allocate_pinning_section()
      f2fs: fix to pass folio->index to f2fs_sanity_check_node_footer()
      f2fs: fix to zero post-EOF data when extending file size

Chen Changcheng (1):
      f2fs: fix valid block count leak on data block allocation failure

Chen Pei (1):
      bpf, riscv: Make arena support depend on ZACAS

Christian Borntraeger (11):
      KVM: s390: Fix length check __import_wp_info()
      KVM: s390: Fix memory leak in guest debug handling
      KVM: s390: Fix old_data leak in guest debug error path
      KVM: s390: Free guest debug data on vcpu destroy
      KVM: s390: Take srcu when importing watchpoint data
      KVM: s390: Zero initialize data structures for inject_pfault_token
      KVM: s390: Zero initialize irq in reinject_machine_check
      KVM: s390: Fix memory corruption by not reinjecting CK machine checks
      KVM: s390: keyop: use mmu_lock to read gmap->asce
      KVM: s390: pv: Fix rc/rrc offset for PVM_DUMP
      KVM: s390: Restore sigset on error path

Christian Hewitt (1):
      media: meson: vdec: fix NULL pointer deref in vdec_try_fmt_common

Christian Marangi (1):
      pmdomain: airoha: fix unselectable AIROHA_CPU_PM_DOMAIN kconfig

Chuck Lever (7):
      NFSD: Annotate caller preconditions for the state-table walkers
      NFSD: Guard admin state-revocation walks with NFSD_NET_UP
      NFSD: Prevent client use-after-free during export state revocation
      NFSD: Consolidate the revocation-path client unpin
      NFSD: Prevent client use-after-free during close_lru reaping
      NFSD: Prevent client use-after-free during blocked-lock reaping
      rpcrdma: arm rn_done before publishing the notification

Cong Nguyen (4):
      iio: adc: pac1921: fix wrong channel used in trigger handler read
      iio: gyro: mpu3050: fix sign of raw angular velocity readings
      iio: srf04: fix pm_runtime handling on probe error path
      media: intel/ipu6: fix async notifier cleanup leak on parse error

Daeho Jeong (1):
      f2fs: fix to migrate all curseg types during free_segment_range

Damien Le Moal (1):
      block: flag zoned disks with GENHD_FL_NO_PART

Danilo Krummrich (2):
      rust: drm: ioctl: fix unbounded lifetimes in ioctl handler arguments
      drm: fix race between partial drm_dev_register() failure and ioctl

Dapeng Mi (2):
      perf/x86/intel: Fix kernel address leakages in LBR stack
      perf/x86/intel: Remove anythread_deprecated bit from perf_capabilities

Dave Stevenson (1):
      media: imx355: Avoid calling imx355_power_off twice in error path

David (Ming Qiang) Wu (1):
      drm/amdgpu/vcn: fix integer overflow in dec_msg buffer count check

David Carlier (5):
      zram: fix slot lock bit position on big-endian 64-bit
      media: mali-c55: fix dropped last AEC histogram zone weight
      media: mali-c55: Fix clock leak on reset deassert failure
      media: mali-c55: Fix AEXP IHIST disable bit shift
      media: mali-c55: Fix scaler factor overflow for large crop sizes

Dawei Feng (1):
      media: cedrus: fix memory leak in cedrus_init_ctrls()

Deepanshu Kartikey (2):
      drm/i915: Guard against NULL driver_data in i915_pci_probe()
      drm/gud: NUL-terminate TV mode names read from the device

Diego Fernando Mancera Gomez (1):
      media: em28xx: defer audio-only extension registration

Dikshita Agarwal (1):
      media: qcom: iris: fix state-change debug log printing stale value

Doruk Tan Ozturk (1):
      HID: sony: clean up device list on probe failure

Elson Serrao (1):
      usb: dwc3: clear forceRM when issuing EndTransfer

Eric Dumazet (2):
      mm/mempolicy: fix sleeping allocation in alloc_pages_bulk_weighted_interleave()
      Revert "once: don't use a work queue to reset sleepable static key"

Erick Henrique (1):
      iio: dac: m62332: Fix regulator reference count imbalance

Eugen Hristev (1):
      media: bcm2835-unicam: Fix pipeline wrong validation for unpacked formats

Faith Ekstrand (1):
      drm/nouveau: Use write-combined maps for coherent

Fan Wu (7):
      usb: typec: qcom-pmic-typec: disable cc_debounce_dwork on stop
      usb: typec: qcom-pmic-typec: drain cc_debounce_dwork if port_start() fails
      usb: typec: qcom-pmic: cancel reset_work on stop
      iio: chemical: atlas-sensor: use iio_trigger_poll_nested() to fix remove UAF
      media: cx23885: cancel NetUP CI work before teardown
      media: ti: vpe: quiesce overflow recovery before freeing streams
      power: supply: ab8500_fg: fix use-after-free on remove

Farhan Ali (2):
      PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value
      PCI: Allow per function PCI slots to fix slot reset on s390

Francesco Lavra (1):
      iio: imu: st_lsm6dsx: Update enable mask when using sensor fusion

Fuad Tabba (3):
      arm64: Don't read GMID_EL1 when MTE is disabled
      KVM: arm64: vgic: Reset in_kernel on private IRQ allocation failure
      KVM: arm64: vgic-its: Don't dereference a NULL collection on ITT save

Gabriel Prostitis (1):
      USB: gadget: ffs: fix mm lifetime handling

Giorgi Tchankvetadze (1):
      iio: light: cm32181: return zero after writing calibscale

Greg Kroah-Hartman (1):
      Linux 7.2.5

Griffin Kroah-Hartman (1):
      usb: image: mdc800: change kmalloc() to kzalloc()

Guanghui Yang (1):
      f2fs: fix dentry folio leak in find_in_level

Guangshuo Li (4):
      i2c: qcom-cci: fix autosuspend cleanup
      media: platform: mtk-mdp3: Fix SCP device refcounting
      media: saa7164: fix cleanup on resource allocation failure
      drm/amdgpu: fix autosuspend cleanup during removal

GuoHan Zhao (2):
      accel/ethosu: check MMIO mapping errors in probe
      accel/ethosu: fix job completion fence cleanup

Guoniu Zhou (4):
      media: dt-bindings: nxp,imx8-isi: Drop fsl,blk-ctrl requirement for i.MX8ULP
      media: nxp: imx8-isi: Fix stream ID validation bypass in crossbar routing
      media: nxp: imx8-isi: Correct color map between V4L2 and ISI
      media: nxp: imx8-isi: Use BIT_ULL() for 64-bit stream masks

HE WEI（ギカク） (1):
      fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()

Haiyong Sun (1):
      perf build: Add clang and rust target flags for LoongArch

Hajo Noerenberg (1):
      ata: ahci: work around lost interrupts on Marvell 88SE61xx

Han Gao (1):
      LoongArch: Add DIRECT_MAP_PHYSMEM_END definition

Hans Verkuil (1):
      media: cec: extron-da-hd-4k-plus: add sanity check

Hao-Qun Huang (1):
      f2fs: reject overlapping move range after len expansion

Haoxiang Li (3):
      ASoC: fsl: mpc5200-i2s: Free DMA resources on probe failure
      ASoC: hdac_hda: Fix hlink refcount leak on component registration failure
      AsoC: intel: sst: fix PCI device reference leak on probe failure

Hari Mishal (1):
      drm/amd/display: fix division by zero in get_estimated_bw()

Harry Wentland (2):
      drm/amd/display: avoid divide-by-zero in __is_lut_linear()
      drm/amd/display: validate plane degamma LUT size for private color prop

Heiko Stuebner (1):
      clk: rockchip: rk3588: Don't change PLL rates when setting dclk_vop2_src

Helge Deller (1):
      parisc: Fix alignment of asm statements in head.S

Hongbo Yao (1):
      i2c: designware: Enable interrupt mask workaround for HJMC3001

Honghui Jiang (1):
      spi: Fix DMA mapping ownership on partial map failure

Hui Su (2):
      bpf: Fix infinite loop in pcpu_freelist push with one possible CPU
      mm/migrate_device: avoid out-of-bounds writes for compound folios

Hungyu Lin (1):
      media: qcom: iris: use disable_irq() during power-off

HyeongJun An (3):
      ALSA: usb-audio: fix OOB write in snd_usbmidi_us122l_output()
      ALSA: rawmidi: Return the error from snd_rawmidi_input_params()
      media: s2255: bound JPEG frame size before copying into the buffer

Ibrahim Hashimov (1):
      HID: wacom: validate report length in wacom_intuos_pro2_bt_irq

Ilya Krutskih (1):
      media: tda18250: fix possible integer overflow

Ivy Lopez (1):
      usb: gadget: f_midi2: fix use-after-free in string attribute show path

Jackson Lee (7):
      media: chips-media: wave5: Guard bit depth check with initial_info_obtained
      media: chips-media: wave5: Set inst->std during default format initialization
      media: chips-media: wave5: avoid skipping device_run while VPU has work
      media: chips-media: wave5: Add timeout while stop_streaming
      media: chips-media: wave5: Defer job_finish() only when a DEC_PIC was queued
      media: chips-media: wave5: Fix pipeline stall when queuing fails
      media: chips-media: wave5: Resume device before setting EOS flag

James Hilliard (3):
      mtd: rawnand: sunxi: group controller delay tables
      mtd: rawnand: sunxi: describe tADL and tWHR delays
      mtd: rawnand: sunxi: fix H6/H616 controller timings

Jameson Thies (1):
      usb: typec: ucsi: displayport: Fix OOB altmode array index

Jeffin Philip (3):
      usb: gadget: f_mass_storage: fix null pointer dereference in fsg_common_set_num_buffers()
      usb: gadget: f_midi: initialize work in f_midi_alloc()
      usb: gadget: fix null pointer dereference in usb_put_function_instance()

Jesse Zhang (2):
      drm/amdgpu: force complete the KIQ ring fences on reset
      drm/amdgpu: force complete the MES ring fences on reset

Jiangong.Han (1):
      media: em28xx: fix use-after-free of dev_next->devlist on disconnect

Jinjie Ruan (2):
      powerpc/kexec_file: Fix null-ptr-def in extra size calculation
      powerpc/kexec_file: Prevent kexec range truncation

Jiri Olsa (5):
      bpf: Factor stackid_init function from __bpf_get_stackid
      bpf: Factor stackid_fastpath function from __bpf_get_stackid
      bpf: Factor stackid_new_bucket from __bpf_get_stackid
      bpf: Use stack id functions instead of __bpf_get_stackid
      bpf: Disable preemption in bpf_get_stackid

Joanne Chang (1):
      f2fs: dirty directory inodes on mtime/ctime update

Johan Hovold (3):
      media: platform: mtk-mdp3: fix NULL deref on failed SCP lookup
      drm/bridge: dw-hdmi: fix i2c adapter leak on probe failure
      drm/panel-edp: fix i2c adapter leak on probe failure

Jonas Karlman (1):
      media: cec: core: Fix kmemleak due to missed rc_free_device() call

Joshua Crofts (3):
      iio: adc: max14001: add missing 'select REGMAP' to Kconfig
      iio: adc: max34408: add missing 'select REGMAP_I2C' to Kconfig
      iio: dac: mcp47feb02: add missing 'select REGMAP_I2C' to Kconfig

José María Martín (1):
      media: ipu-bridge: check all DMI entries when overriding sensor rotation

Ju Nan (1):
      irqchip/stm32mp-exti: Fix the unit of the hwspinlock timeout

Jérémy Jean (1):
      LoongArch: Avoid preempt count underflow without probe

Kajetan Puchalski (1):
      KVM: arm64: vgic: Fix detection of MI on no pending LR

Kanala Ramalingeswara Reddy (1):
      drm/amdgpu: Skip accessing psp rum time db for APUs

Kanishka De Silva (1):
      ublk: clear VM_MAYWRITE on read-only ublk char device mmap

Karl Mehltretter (1):
      arm64: mm: Fix the lockless page-table walk in show_pte()

Kathiravan Thirumoorthy (1):
      i2c: qcom-geni: update frequency table to fix timing parameters

Kavan Smith (1):
      drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value

Kazuki Hanai (1):
      nvmet-auth: Synchronize timeout work during SQ teardown

Khushit Shah (1):
      arm64: errata: pass REVIDR when matching target implementation CPUs

Koichiro Den (4):
      dmaengine: dw-edma: Fix HDMA channel status register access
      dmaengine: dw-edma: Complete descriptors before pausing
      dmaengine: dw-edma: Initialize IRQ data before requesting IRQs
      dmaengine: dw-edma: Mark emulated IRQ as level-triggered

Lad Prabhakar (4):
      rtc: rzn1: Handle EPROBE_DEFER for optional pps interrupt
      rtc: rzn1: Fix weekday underflow when alarm crosses month boundary
      rtc: rzn1: Handle unset alarm weekday in rzn1_rtc_read_alarm
      rtc: rzn1: Disable alarm interrupt before reprogramming alarm registers

Lars-Peter Clausen (3):
      iio: buffer: Fix potential use-after-free in anonymous buffer release
      iio: buffer: Make IIO DMA fence release RCU-safe
      iio: buffer: Tie IIO dma fence lock lifetime to the fence

Laxman Acharya Padhya (1):
      iio: light: gp2ap002: Disable regulators on resume failure

Lei Huang (1):
      media: s2255: check firmware size before reading trailing marker

Linkai Gong (3):
      cpuidle: dt_idle_genpd: kfree() the original name allocation
      i2c: mux: demux-pinctrl: fix OF node leak on kstrdup failure
      drm/amd/display: fix dc_lock leak on GPU reset error paths

Linmao Li (1):
      iio: chemical: sgp30: Handle IAQ thread creation failure

Linus Torvalds (1):
      drm/xe: Don't hand out the flat CCS storage as usable VRAM

Liu Qi (1):
      usb-storage: ene_ub6250: fix race between scan work and probe

Longlong Xia (1):
      mm/hugetlb: keep max_huge_pages when dissolving surplus folios

Lorenzo Stoakes (ARM) (1):
      mm/secretmem: properly account locked pages

Lovekesh Solanki (1):
      USB: gadget: fix NULL pointer dereference in gadget_dev_ioctl()

Lyude Paul (1):
      drm/nouveau/disp/r535: Add scanline position support + head state support

Marc Zyngier (8):
      KVM: arm64: Consider SCTLR_EL2.M when mapping the L1 VNCR page
      KVM: arm64: Handle negative S1 walk levels in VNCR TLB size evaluation
      KVM: arm64: Correctly handle end of VA space TLBI invalidation
      KVM: arm64: Handle VNCR TLB invalidation race with vcpu_put() VNCR unmapping
      KVM: arm64: Make VNCR invalidation participate in MMU invalidation retry
      KVM: arm64: Remove VM-wide VNCR mapping counter
      KVM: arm64: Sign-extend VA for range-based TLBI invalidation
      KVM: arm64: Correctly cap TLBI Range to the architural limit

Marek Czernohous (1):
      drm/nouveau: unsubscribe the channel-kill event before the fence context

Marek Vasut (2):
      usb: typec: mux: avoid duplicated mux switches
      usb: typec: mux: Fix typec_switch_match()

Mario Limonciello (1):
      drm/amdkfd: fix scope of mqd_mgr dereference in pqm_debugfs_mqds

Martin Blumenstingl (1):
      clk: meson: align gxbb_32k_clk_sel number of parents with actual count

Martin Hecht (1):
      media: i2c: alvium: Fix: Correct name of register in alvium_set_ctrl_auto_exposure

Martin Kaiser (1):
      dmaengine: fsl-edma: tracing: no ptr dereference during log output

Masami Hiramatsu (Google) (2):
      tracing/probes: Fix anon_stack check for unnamed bitfields in btf_find_struct_member
      kprobes: Protect kprobe_blacklist with RCU

Matthew Auld (1):
      drm/xe/vram: report FLAT_CCS base misalignment

Matthew Brost (2):
      drm/ttm: Drop tt->restore after successful restore
      drm/pagemap: Fix folio allocation fallback and use-after-put

Max Kellermann (1):
      ceph: lock mutex in ceph_mds_check_access()

Michael Bommarito (3):
      media: rkvdec: hevc: tighten EXT SPS RPS control dimensions
      media: rkvdec: hevc: guard INTER_REF_PIC_SET_PRED index underflow
      media: v4l2-ctrls: validate HEVC EXT SPS RPS counts

Mikulas Patocka (2):
      dm: fix race when loading and unloading a table
      dm: fix resume-vs-remove race

Ming Qian (2):
      media: amphion: Remove obsolete frame_count check in venc_start_session
      media: v4l2-ctrls: Allow unknown HDR10 white point and luminance

Miquel Raynal (DAVE) (1):
      mtd: rawnand: pl353: Make sure we use the monolithic helpers for raw accesses

Mohamed Ahmed (8):
      drm/nouveau/gsp: use per-version DP_CONFIG_STREAM params on r570 firmware
      drm/nouveau/disp: move GSP head-timing ISR and vblank helpers to tu102.c
      drm/nouveau/disp: move the GSP HDMI GCP AVMute write to engine/disp
      drm/nouveau/disp: route GSP-RM display MMIO through nvkm_disp_func hooks
      drm/nouveau/disp: fix HDMI vendor infoframes on GB20x
      drm/nouveau/disp: fix HDMI GCP AVMute register offsets on GB20x
      drm/nouveau/disp: fix head state readback on GB20x
      drm/nouveau/gsp: fix vblank interrupts on GB20x

Mohammed EL Kadiri (2):
      media: venus: fix payload size returned by parse_caps() and parse_alloc_mode()
      media: venus: fix payload size calculation in parse_raw_formats()

Moksh Panicker (2):
      iio: chemical: atlas-sensor: fix PM reference leak in buffer postenable
      iio: light: apds9306: fix PM reference leak in apds9306_read_data()

Muchun Song (1):
      powerpc/mm: fix wrong addr_pfn tracking in compound vmemmap population

Muhammad Bilal (3):
      staging: rtl8723bs: fix OOB read / stack overflow in rtw_get_wps_attr()
      staging: rtl8723bs: fix OOB read in rtw_action_frame_parse()
      staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()

Mukesh Ojha (1):
      remoteproc: qcom: pas: Guard dtb metadata release with dtb_pas_id check

Myeonghun Pak (2):
      usb: storage: realtek_cr: fix use-after-free on disconnect
      media: rc: sunxi-cir: Unregister rc device on probe failure

Namjae Jeon (1):
      ksmbd: zero pipe read compound padding

Narasimharao Vadlamudi (3):
      media: i2c: imx415: Release runtime PM reference on VBLANK error
      media: i2c: imx415: Return test pattern write errors
      media: rkvdec: Propagate platform_get_irq() errors

Narek Jilavyan (1):
      mm/hugetlb_cgroup: call page_counter_set_max() outside VM_BUG_ON()

Nathan Chancellor (1):
      LoongArch: Do not select HAVE_RUST when KASAN is enabled

Neill Kapron (1):
      usb: gadget: f_fs: Fix Use-After-Free in AIO error path

Nemesa Garg (1):
      drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane disable

Nikhil Gautam (4):
      iio: light: opt4001: Fix power down clearing bits of the wrong register
      iio: light: opt4001: Fix incompatible pointer type passed to div_u64_rem()
      iio: light: opt4001: Reject integration times with a non-zero seconds part
      iio: light: opt4001: Fix reversed GENMASK() arguments in fault count mask

Niklas Cassel (1):
      nvme-fc: fix double free of fabrics options when nvme_add_ctrl() fails

Nilesh Javali (30):
      scsi: qla2xxx: Zero SFP DMA buffer in FRU/I2C bsg handlers
      scsi: qla2xxx: Bound i2c->length in I2C bsg handlers
      scsi: qla2xxx: edif: Fix NULL pointer deref in RX SA delete check
      scsi: qla2xxx: Fix Name Server logout detection on FWI2 adapters
      scsi: qla2xxx: Fix BSG job leak on validate flash image error path
      scsi: qla2xxx: Hold vport reference in qla24xx_report_id_acquisition()
      scsi: qla2xxx: Initialize NVMe abort_work once at submission
      scsi: qla2xxx: Check entry_status in qla24xx_modify_vp_config()
      scsi: qla2xxx: Zero dport diagnostics buffer to avoid info leak
      scsi: qla2xxx: Bound image count in qla2x00_update_fru_versions()
      scsi: qla2xxx: Hold qpair lock when sending NVMe LS reject
      scsi: qla2xxx: Clamp MSI-X derived queue counts to avoid truncation
      scsi: qla2xxx: Serialize flash version read in reset handler
      scsi: qla2xxx: Fix cs84xx use-after-free on host teardown
      scsi: qla2xxx: Fix FCE trace use-after-free during firmware dump
      scsi: qla2xxx: Zero mailbox struct in qla2x00_get_firmware_state()
      scsi: qla2xxx: Fix FCE trace enable parsing in debugfs
      scsi: qla2xxx: Don't query firmware state while chip is down
      scsi: qla2xxx: Reject non-SCSI SRB on status IOCB fast path
      scsi: qla2xxx: Fix response queue over-consumption in __qla_consume_iocb()
      scsi: qla2xxx: Quiesce response IRQ before freeing request queue
      scsi: qla2xxx: Avoid double completion in async IOCB timeout
      scsi: qla2xxx: Bound rsp_info_len to avoid OOB sense-data read
      scsi: qla2xxx: Avoid req_q_map double-read in qla2x00_error_entry()
      scsi: qla2xxx: Fix NVMe abort reference leak on repeated abort
      scsi: qla2xxx: Drop vport reference under lock in report ID acquisition
      scsi: qla2xxx: Hold vport_slock for host map update in report ID acquisition
      scsi: qla2xxx: Use coherent DMA buffer for D_Port diagnostics
      scsi: qla2xxx: Zero-init bsg stack buffers to avoid info leak
      scsi: qla2xxx: Skip NVMe LS reject IOCB when FW not started

Norbert Szetei (1):
      net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()

Osama Abdelkader (2):
      drm/panthor: harden firmware build-info bounds checks
      drm/panthor: fix firmware control interface bounds checks

Pan Chuang (1):
      power: supply: ab8500_fg: Remove redundant dev_err()/dev_err_probe()

Paul Geurts (1):
      iio: ti-ads7138: Disable STATS_EN bit while reading conversion results

Paul Louvel (1):
      soc: fsl: qe: Add chained_irq_{enter,exit}() calls in cascade handler

Pavel Löbl (1):
      clk: clocking-wizard: fix integer overflow in rate calculation

Pawel Laszczak (1):
      usb: cdnsp: fix wakeup from S3 after controller context loss

Pedro Kopper (1):
      clk: microchip: mpfs: fix regmap_update_bits() mask/val order

Pei Xiao (1):
      parisc: eisa: Fix infinite loop when parsing invalid IRQ value

Pengpeng Hou (3):
      mtd: afs: validate v2 image info bounds
      mtd: nand: realtek-ecc: add missing MODULE_DEVICE_TABLE()
      mtd: rawnand: validate ONFI extended parameter page sections

Peter Ujfalusi (31):
      ASoC: adau1761: sort the register default table
      ASoC: cx2072x: sort the register default table
      ASoC: fsl_easrc: sort the register default table
      ASoC: max9860: sort the register default table
      ASoC: ml26124: sort the register default table
      ASoC: pcm512x: sort the register default table
      ASoC: pm4125-sdw: sort the register default table
      ASoC: rt1017-sdca-sdw: sort the register default table
      ASoC: rt1316-sdw: sort the register default table
      ASoC: rt1318-sdw: sort the register default table
      ASoC: rt1318: sort the register default table
      ASoC: rt274: sort the register default table
      ASoC: rt286: sort the register default table
      ASoC: rt298: sort the register default table
      ASoC: rt700: drop duplicate reg_default entry
      ASoC: rt700: sort the register default table
      ASoC: rt711-sdca: sort the register default tables
      ASoC: rt711: sort the register default table
      ASoC: rt712-sdca-dmic: sort the register default table
      ASoC: rt712-sdca-sdw: sort the register default table
      ASoC: rt715-sdca: drop duplicate reg_default entries
      ASoC: rt715-sdca: sort the register default tables
      ASoC: rt715: sort the register default table
      ASoC: rt721-sdca-sdw: sort the register default table
      ASoC: sgtl5000: sort the register default table
      ASoC: sti-sas: sort the register default table
      ASoC: tas2552: sort the register default table
      ASoC: tas2764: sort the register default table
      ASoC: tas2780: sort the register default table
      ASoC: tas2783-sdw: drop duplicate reg_default entry
      ASoC: tas2783-sdw: sort the register default table

Phil Rosenthal (1):
      KVM: x86/mmu: Consume the locked rmap value in the lockless rmap walk

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: delay ttm buffer func enablement on xgmi

Priya Hosur (1):
      drm/amdkfd: Add TLB flush after MES queue eviction/suspension

Qihang (1):
      KVM: arm64: vgic-v3: take an LPI reference in vgic_v3_save_pending_tables

Radhey Shyam Pandey (1):
      usb: dwc3: google: Initialise probe properties with DWC3_DEFAULT_PROPERTIES

Rahul Chandelkar (1):
      scsi: bsg: Fix TOCTOU in io_uring passthrough command setup

Richard Leitner (1):
      media: i2c: ov9282: restore flash duration calculation

Roman Li (1):
      drm/amd/display: Set gpuvm min page size to 4K on dcn35/36

Rong Zhang (2):
      ACPI: battery: Use kstrtoul() over sscanf("%lu\n")
      ACPI: battery: Protect all properties with a separated mutex

Rosalie Wanders (1):
      HID: sony: use guard() and scoped_guard()

Runyu Xiao (4):
      scsi: pm8001: Use rollback index when freeing MSI-X vectors
      ALSA: harmony: initialize locks before requesting IRQ
      ASoC: cs35l33: drain threaded IRQ before runtime suspend
      ASoC: cs35l34: drain threaded IRQ before runtime suspend

Ruoyu Wang (3):
      media: cec: Serialize exclusive follower delivery
      media: cobalt: Avoid freeing ALSA private data twice
      media: zoran: Avoid freeing a registered video_device twice

Rupesh Majhi (1):
      iio: pressure: dps310: fix NULL pointer dereference on ACPI probe

SJ Park (28):
      mm/damon/sysfs: read addr_unit only once in damon_sysfs_apply_inputs()
      mm/damon/sysfs: read ops_id only once in damon_sysfs_apply_inputs()
      mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
      mm/damon/vaddr-kunit: check region count in three_regions test
      samples/damon/mtier: handle damon_start() failure
      samples/damon/mtier: handle damon_stop() failure
      samples/damon/prcl: handle damon_start() failure
      samples/damon/prcl: stop and free damon ctx when damon_call() fails
      samples/damon/wsse: handle damon_start() failure
      samples/damon/wsse: stop and free damon ctx when damon_call() fails
      mm/damon/sysfs-schemes: kobject_del() scheme action destination dirs
      mm/damon/sysfs-schemes: kobject_del() scheme dirs
      mm/damon/sysfs-schemes: kobject_del() scheme filter dirs
      mm/damon/sysfs-schemes: kobject_del() scheme quota goal dirs
      mm/damon/sysfs-schemes: kobject_del() scheme region dirs
      mm/damon/sysfs: kobject_del() region and target (error) dirs
      mm/damon/sysfs: kobject_del() target (normal), context and kdamond dirs
      mm/damon/core-kunit: check region count before testing in split_at()
      mm/damon/core-kunit: handle region split failure in filter_out()
      mm/damon/core-kunit: skip wrong dest walk in commit_dests_for()
      mm/damon/core-kunit: skip wrong quota goal walk in commit_quota_goals()
      mm/damon/core-kunit: skip wrong region walk in commit_target_regions()
      mm/damon/core: handle region split failure in apply_min_nr_regions()
      mm/damon/core: initialize damos->last_applied
      mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
      mm/damon/ops-common: use nr_accesses moving sum for quota score
      mm/damon/paddr: drop last same folio access check reuse optimization
      mm/damon/vaddr: drop last same folio access check optimization

Sam Edwards (1):
      ceph: properly decrypt filenames in vmalloc() buffers

Sanjay Chitroda (1):
      iio: temperature: hid-sensor-temperature: switch to non-devm iio_device_register()

Sean Christopherson (9):
      KVM: x86/mmu: Fold kvm_mmu_zap_memslot() into kvm_arch_flush_shadow_memslot()
      KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into "front" and "back" halves
      KVM: x86/mmu: Use split "zap all fast" helpers when invalidating memslot
      KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is zapped
      KVM: nVMX: Decouple INVVPID operand checks from flushing of vpid02
      KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is cleared on VM-Exit
      KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit in TDP MMU
      KVM: x86: Serialize writes to disabled_quirks using kvm->lock
      KVM: x86: Ensure runtime reads of disabled_quirks are resolved once

Sebastian Andrzej Siewior (2):
      zram: move lockmap to be per-zram instead per table
      futex: Provide rt_mutex_.*_schedule() equivalents for futex scheduling

Shakeel Butt (3):
      memcg: keep folio's objcg same as its node
      memcg: bypass the reclaim and oom killer for dying tasks once oom_reaper is done
      memcg: make the v1 soft limit knob inert

Shen Yongchao (1):
      HID: bpf: serialize device reference release in struct_ops destroy path

Shivam Kumar (2):
      nvmet-tcp: fix out-of-bounds write when receiving an over-long PDU
      nvmet-tcp: reject unsolicited H2CData PDUs

Shixiong Ou (2):
      drm/sysfb: ofdrm: Fix integer overflow in fb_size calculation
      drm/sysfb: ofdrm: Fix is_avivo() constant comparison bug

Shuangpeng Bai (2):
      media: usbtv: keep device alive while ALSA card exists
      media: go7007: defer the ALSA v4l2 put until card release

Sizhe Liu (1):
      perf hisi-ptt: Fix PTT trace TLP header parsing

Song Hu (1):
      Docs/ABI/damon: fix typo in intervals_goal sysfs path

Sourabh Jain (3):
      powerpc/pseries: Handle and log pseries-wdt registration failures
      powerpc/pseries: Move H_WATCHDOG definitions to a common header
      powerpc/crash: stop watchdogs before booting kdump kernel

Sourav Panda (1):
      mm/hugetlb_cma: fix null nodemask dereference in hugetlb_cma_alloc_frozen_folio

Stephan Gerhold (8):
      clk: qcom: gcc-mdm9607: Increase delay for USB PHY reset
      clk: qcom: gcc-msm8916: Fix enable_reg for gcc_blsp1_sleep_clk
      clk: qcom: gcc-msm8939: Fix enable_reg for gcc_blsp1_sleep_clk
      clk: qcom: gcc-mdm9607: Drop incorrect apss_tcu_clk_src
      clk: qcom: gcc-mdm9607: Drop incorrect system_noc_bfdcd_clk_src
      clk: qcom: gcc-mdm9607: Fix enable_reg for gcc_blsp1_sleep_clk
      clk: qcom: gcc-mdm9607: Fix halt_reg for gcc_apss_axi_clk
      clk: qcom: gcc-mdm9607: Drop incorrect BIMC PLL and related clocks

Steven Rostedt (4):
      tracing: Have show_event_filters/triggers files take trace array ref
      tracing: Take trace_array reference when opening options file
      ftrace: Take trace_array reference before accessing its ftrace_ops
      ftrace: Synchronize the initialization of ftrace_ops

Sujal Tuladhar (1):
      scsi: target: iscsi: Reserve a terminator byte for the login payload

Sunday Clement (1):
      drm/amdkfd: Reject zero-sized AQL queue allocations after size halving

Sunil Khatri (5):
      drm/amdgpu: fix byte/dword unit mismatch in coredump IB dump
      drm/amdgpu: fix Idle BOs list in VM debugfs status info
      drm/amdgpu: update the fw version for gfx11 userqueues
      drm/amdgpu: update the fw version for gfx12 userqueues
      drm/amdgpu: use AMDGPU_GPU_PAGE_SHIFT instead of PAGE_SHIFT

Sven Eckelmann (6):
      batman-adv: fix TX priority extraction for BATADV_FORW_MCAST
      batman-adv: mcast: ensure unshared skb for multicast packets
      batman-adv: mcast: linearize skbuff for packet generation
      batman-adv: dat: avoid unaligned fault in IP extraction
      batman-adv: bla: fix freeing of claims on meshif deletion
      batman-adv: bla: prevent CRC corruptions after claim flush

Sven Peter (1):
      usb: typec: tipd: Fix Thunderbolt altmode VDOs for cd321x

Sven Püschel (1):
      media: rockchip: rga: don't change RGB quantization

Taimuraz Kaitmazov (1):
      accel/amdxdna: return early from a zero-length flush

Takashi Iwai (1):
      ALSA: pcm: Fix race between non-atomic ops and trigger-start

Tao Cui (1):
      LoongArch: KVM: Fix TOCTOU race on pv_features

Tao Yu (1):
      drm/gud: validate TV mode names before creating enum property

Thadeu Lima de Souza Cascardo (1):
      drm: Fix drm_crtc_commit leak if signaled when PAGE_FLIP_EVENT is used

Thomas Hellström (1):
      drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()

Thomas Lamprecht (1):
      scsi: megaraid_sas: Limit NVMe request size to the PRP chain frame

Thomas Zimmermann (5):
      drm/hibmc: Fix list of formats on the primary plane
      drm/hibmc: Use drm_atomic_helper_check_plane_state()
      drm/sysfb: simpledrm: Improve framebuffer-size validation
      drm/sysfb: simpledrm: Improve panel-size validation
      drm/sysfb: simpledrm: Improve stride validation

Tiezhu Yang (5):
      LoongArch: BPF: Optimize redundant TCC loads in epilogue
      LoongArch: BPF: Refactor jump offset calculation in tail call
      LoongArch: Expand module virtual address space to 2GB
      LoongArch: BPF: Move arena register slot below TCC context
      LoongArch: BPF: Fix off-by-one error for insn_is_cast_user()

Timur Kristóf (1):
      drm/amd/display: Fix HPD consideration for VGA/LVDS connectors on DCE

Tommaso Merciai (1):
      media: rzg2l-cru: Align bytesperline to hardware DMA stride requirement

Tristan Madani (1):
      nvme: add missing SRCU grace period in error path

Uday Khare (1):
      media: video-i2c: fix kthread error pointer left in kthread_vid_cap on failure

Ulf Hansson (1):
      cpuidle: psci: Fix support for probe deferral by dropping the faux device

Usama Arif (1):
      mm/huge_memory: transfer the pmd dirty bit to the folio on zap

Valery Borovsky (3):
      media: airspy: use vb2_video_unregister_device() on disconnect to fix NULL deref
      media: rtl2832_sdr: use vb2_video_unregister_device() on remove to fix DMA leak
      media: rtl2832_sdr: release URBs and stream buffers on start_streaming() failure

Vasileios Almpanis (1):
      i2c: core: fix debugfs UAF on adapter removal

Vidhu Sarwal (3):
      iio: light: ltrf216a: fix runtime PM reference leak in error path
      iio: light: opt4060: Reject integration times with a non-zero seconds part
      iio: light: opt4060: Fix incorrect register name in threshold read error message

Viken Dadhaniya (1):
      soc: qcom: geni-se: Use HW PROG_RAM_DEPTH to validate firmware size

Viktor Malik (2):
      perf trace: Factor out BPF loop body
      perf trace: Refactor augmented_raw_syscalls using bpf_for

Vincent Donnefort (1):
      ring-buffer: Allow splice reads on static buffers

Vladimir Marioukhine (1):
      drm/amdkfd: guard against NULL restore_mqd in CRIU queue restore

Wangao Wang (1):
      media: qcom: iris: fix missing hfi_id in gen1 GOP_SIZE cap

Wei Jie Law (1):
      HID: rmi: fix OOB access with undersized RMI reports

WenTao Liang (1):
      ASoC: samsung: aries_audio_probe: double of_node_put due to direct assignment without of_node_get

Wenjie Qi (7):
      f2fs: return symlink writeback errors
      f2fs: only redirty pinned folios in redirty_blocks
      f2fs: validate MOVE_RANGE destination size
      f2fs: return writeback error from collapse range
      f2fs: limit recovery filename logging to stored length
      f2fs: avoid NULL checkpoint thread access in sysfs
      f2fs: protect critical_task_priority updates with s_umount

Wentao Guan (1):
      LoongArch: Do not save/restore percpu base register in rethook trampoline

Wentao Liang (1):
      drm/sun4i: fix refcount leak in sun4i_backend_init_sat()

Wupeng Ma (1):
      mm/hugetlb: fix missing migratable flag on same-node hugetlb migration

Xiang Liu (1):
      drm/amdgpu: clamp the isolation index for rings outside a partition

Xiaogang Chen (2):
      drm/amdkfd: Fix error path at svm_migrate_copy_to_ram
      drm/amdkfd: Fix the case that vm range is hole at svm_migrate_copy_to_vram

Xu Rao (3):
      nvme-fabrics: fix DHCHAP secret leak on parse failure
      mtd: mtdoops: free page bitmap when the backing MTD is removed
      media: v4l2-async: avoid deleting unlinked ASC entry on link error

Yang Wang (2):
      drm/amdgpu: check thunderbolt before switcheroo registration
      drm/amdgpu: Disable runtime PM for externally attached dGPUs

Yang Xiuwei (1):
      scsi: bsg: Cap io_uring sense copy to max_response_len

Yao Kai (1):
      futex: Prevent rcuwait use-after-free during requeue PI

Yehyeong Lee (1):
      nvme-tcp: check the data direction of a C2HData PDU

Yi Ding (1):
      media: cec: meson: ao-cec-g12a: name the CEC core regmap to avoid debugfs clash

Yilin Zhang (1):
      perf: Fix use-after-free when perf mmap() revival races with the last munmap()

Yosry Ahmed (4):
      KVM: nVMX: Always flush vpid02 on first use
      KVM: nVMX: Service local TLB flushes on failed nested VM-Enter
      KVM: nVM: Ensure INVVPID is emulated on the correct physical CPU
      KVM: x86: Move enabling EFER.SVME and EFER.LMSLE to generic EFER setup

Zeng Chi (3):
      LoongArch: KVM: Fix PC double advance in kernel MMIO read fast path
      LoongArch: KVM: Preserve memslot arch flags on KVM_MR_FLAGS_ONLY
      LoongArch: KVM: Validate MSI data before routing it to EIOINTC

Zhan Xusheng (3):
      f2fs: use the mount idmap for the owner check in f2fs_xattr_advise_set()
      f2fs: don't drop the top folio order in the f2fs_iostat tracepoint
      f2fs: fix i_size when pinned fallocate partially fails

Zhaoyang Huang (1):
      f2fs: fix folio_nr_pages() race after put in large folio invalidate

Zhenhao Wan (5):
      drm/nouveau/dmem: fix callocated underflow on large folio split
      drm/nouveau/dmem: fix mismatched DMA unmap size for large folios
      drm/nouveau/uvmm: fix NULL deref unwinding an OP_MAP_SPARSE op
      drm/nouveau/uvmm: fix premature region free on failed OP_UNMAP_SPARSE
      drm/nouveau/uvmm: clear the dirty flag when unwinding an OP_UNMAP_SPARSE

Zhiling Zou (1):
      batman-adv: fix stale receive device on merged fragments

caina (1):
      Revert "irqchip/mbigen: Fix mbigen node address layout"

wangdicheng (1):
      ASoC: fsl_easrc: Use div64_u64 for 64-by-64 division

