Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9680B420483;
	Sat,  3 Oct 2026 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791024887; cv=none; b=heT5cD2JxOAbCuJgkBUqeZ/7Xqxmg2bLuCAfvHEmNdJnjdYpzFxl09yb2D3hiBLj/aM89SSl5Iyx7WVHmDA18Qe3HASpSkA9JSgIVgZqnwht6WLU8e77JlnIXoQ287QUmFdrVvVzRcaL+X9CAnnemCZ6c96pjvqZneXafz+W9Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791024887; c=relaxed/simple;
	bh=DqvcqWo2At+mV0m2GW/uXmAj3yolJWUDeNemorzG9xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F8vrLVef6cI4wgyJFQd74DhXOiABonchcP9Abj9FkaTHxaOjYrg7yy674xwsHCmHT2MarpHJO8YimjJjWEmycinVXzw5U2yf3XcXPj7UwFG1wviNll+2XOlyzvg6FPjqS5TTstraOstvdKlXsO6YZ3zSrsOi8cg01QP7GLNSWdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v2wDpQz6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v2wDpQz6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718341F0089F;
	Sat,  3 Oct 2026 10:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791024865;
	bh=ZrSyGWqzTRsinyQ6zXrTiiM/EOuwY+QsYIzcg59mEv0=;
	h=From:To:Cc:Subject:Date;
	b=v2wDpQz66MYf8hiXLGqd4h9d2Vy84zTvBQaJjrP8KYDWTs+hX1XmmN1ajyW78AY99
	 e+9kf+8Llq9Z5AZlzii6AMlj+8DF2Q9rpkaYg3lZ+FhwfGRRn+LTWkBfKXupIvNw+i
	 C+UpERaT6jDevU71rSwsNAFVUrBUNiKZ6pe5x78k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.158
Date: Sat,  3 Oct 2026 12:54:17 +0200
Message-ID: <2026100317-public-avenue-abfd@gregkh>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.158 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-platform-trackpoint               |    2 
 Documentation/arch/s390/pci.rst                                           |  152 
 Documentation/hwmon/emc1403.rst                                           |    8 
 Documentation/networking/ip-sysctl.rst                                    |    2 
 Documentation/sound/designs/midi-2.0.rst                                  |   11 
 Makefile                                                                  |    2 
 arch/alpha/include/uapi/asm/fpu.h                                         |    8 
 arch/alpha/kernel/traps.c                                                 |    6 
 arch/alpha/math-emu/math.c                                                |   88 
 arch/arm/mach-socfpga/Kconfig                                             |    2 
 arch/arm/mach-ux500/cpu-db8500.c                                          |    6 
 arch/arm/mm/cache-feroceon-l2.c                                           |    2 
 arch/arm/mm/cache-tauros2.c                                               |    2 
 arch/arm/mm/fault.c                                                       |   12 
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                                     |   16 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                                      |   64 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                      |    8 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                                      |   12 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                                      |    8 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                                      |    8 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                                      |    8 
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi                                 |    1 
 arch/arm64/include/asm/daifflags.h                                        |   10 
 arch/arm64/include/asm/fixmap.h                                           |    6 
 arch/arm64/include/asm/io.h                                               |    3 
 arch/arm64/include/asm/kprobes.h                                          |    6 
 arch/arm64/include/asm/percpu.h                                           |   16 
 arch/arm64/kernel/hibernate-asm.S                                         |    2 
 arch/arm64/kernel/probes/kprobes.c                                        |   23 
 arch/arm64/kvm/hypercalls.c                                               |    3 
 arch/arm64/kvm/vgic/vgic-its.c                                            |   96 
 arch/arm64/kvm/vgic/vgic.h                                                |   23 
 arch/mips/cavium-octeon/octeon-platform.c                                 |    4 
 arch/mips/kernel/cps-vec.S                                                |    6 
 arch/mips/net/bpf_jit_comp32.c                                            |    2 
 arch/mips/net/bpf_jit_comp64.c                                            |    3 
 arch/powerpc/kernel/eeh_driver.c                                          |    2 
 arch/powerpc/kernel/iommu.c                                               |    2 
 arch/powerpc/kexec/file_load_64.c                                         |    2 
 arch/powerpc/kvm/book3s_hv.c                                              |    4 
 arch/powerpc/kvm/book3s_hv_nested.c                                       |    2 
 arch/powerpc/kvm/book3s_hv_uvmem.c                                        |    5 
 arch/powerpc/platforms/ps3/repository.c                                   |    5 
 arch/powerpc/platforms/pseries/kexec.c                                    |   13 
 arch/riscv/kvm/vcpu_sbi_hsm.c                                             |    4 
 arch/riscv/kvm/vcpu_timer.c                                               |    5 
 arch/s390/boot/physmem_info.c                                             |    2 
 arch/s390/crypto/aes_s390.c                                               |   16 
 arch/s390/include/asm/checksum.h                                          |   29 
 arch/s390/include/asm/debug.h                                             |    8 
 arch/s390/include/asm/os_info.h                                           |   19 
 arch/s390/kernel/debug.c                                                  |   15 
 arch/s390/kernel/ipl.c                                                    |   19 
 arch/s390/kernel/os_info.c                                                |   21 
 arch/sparc/Kconfig                                                        |    1 
 arch/sparc/kernel/uprobes.c                                               |    1 
 arch/x86/crypto/aria-aesni-avx2-asm_64.S                                  |    6 
 arch/x86/crypto/aria-gfni-avx512-asm_64.S                                 |    3 
 arch/x86/events/amd/ibs.c                                                 |    3 
 arch/x86/events/intel/core.c                                              |   76 
 arch/x86/events/intel/ds.c                                                |  210 -
 arch/x86/include/asm/perf_event.h                                         |   16 
 arch/x86/include/asm/pgtable.h                                            |    2 
 arch/x86/pci/fixup.c                                                      |   99 
 block/blk-cgroup.c                                                        |   13 
 crypto/Makefile                                                           |    5 
 drivers/accel/qaic/qaic_control.c                                         |   46 
 drivers/acpi/acpica/dsmethod.c                                            |   43 
 drivers/acpi/acpica/evhandler.c                                           |   11 
 drivers/acpi/acpica/exconfig.c                                            |   26 
 drivers/acpi/acpica/exoparg3.c                                            |    2 
 drivers/acpi/acpica/nsnames.c                                             |    6 
 drivers/acpi/acpica/nsprepkg.c                                            |    7 
 drivers/acpi/acpica/nsxfname.c                                            |    4 
 drivers/acpi/acpica/psargs.c                                              |  134 
 drivers/acpi/acpica/psloop.c                                              |   30 
 drivers/acpi/acpica/psparse.c                                             |   14 
 drivers/acpi/acpica/utcopy.c                                              |   10 
 drivers/acpi/acpica/utresrc.c                                             |   30 
 drivers/acpi/pci_root.c                                                   |    4 
 drivers/ata/ahci.c                                                        |   22 
 drivers/ata/libahci.c                                                     |   15 
 drivers/ata/libata-pmp.c                                                  |    7 
 drivers/ata/libata-scsi.c                                                 |   10 
 drivers/base/core.c                                                       |  200 +
 drivers/block/sunvdc.c                                                    |   26 
 drivers/bluetooth/btintel.c                                               |   68 
 drivers/bluetooth/btintel.h                                               |   47 
 drivers/bluetooth/btmtk.c                                                 |    7 
 drivers/bluetooth/btmtksdio.c                                             |    4 
 drivers/bluetooth/btrtl.c                                                 |    5 
 drivers/bluetooth/btusb.c                                                 |   41 
 drivers/bluetooth/hci_mrvl.c                                              |    3 
 drivers/bus/fsl-mc/fsl-mc-bus.c                                           |   46 
 drivers/char/ipmi/ipmi_si_platform.c                                      |    5 
 drivers/char/nvram.c                                                      |   16 
 drivers/char/virtio_console.c                                             |   21 
 drivers/clk/clk-scpi.c                                                    |    2 
 drivers/clk/keystone/sci-clk.c                                            |    8 
 drivers/clk/renesas/renesas-cpg-mssr.c                                    |    3 
 drivers/clk/samsung/clk-exynos850.c                                       |    5 
 drivers/clk/socfpga/clk-agilex.c                                          |    2 
 drivers/clk/ux500/clk-prcmu.c                                             |   20 
 drivers/clk/ux500/u8500_of_clk.c                                          |    2 
 drivers/clocksource/timer-orion.c                                         |    2 
 drivers/cpufreq/cpufreq.c                                                 |    6 
 drivers/cpuidle/cpuidle-ux500.c                                           |    6 
 drivers/crypto/allwinner/Kconfig                                          |   16 
 drivers/crypto/allwinner/sun8i-ce/Makefile                                |    1 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c                         |   55 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c                         |  159 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h                              |   29 
 drivers/crypto/allwinner/sun8i-ss/Makefile                                |    1 
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c                         |   39 
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c                         |  177 -
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h                              |   23 
 drivers/crypto/atmel-ecc.c                                                |   11 
 drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c                               |   25 
 drivers/crypto/omap-des.c                                                 |   26 
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c                       |   91 
 drivers/crypto/virtio/virtio_crypto_skcipher_algs.c                       |   13 
 drivers/cxl/core/pmem.c                                                   |   21 
 drivers/cxl/core/region.c                                                 |    2 
 drivers/cxl/cxl.h                                                         |    4 
 drivers/cxl/mem.c                                                         |   18 
 drivers/dma/dmaengine.c                                                   |   10 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                            |   11 
 drivers/dma/mmp_pdma.c                                                    |    2 
 drivers/dma/sprd-dma.c                                                    |    3 
 drivers/dma/sun6i-dma.c                                                   |    9 
 drivers/dma/ti/k3-udma-glue.c                                             |    5 
 drivers/dma/xilinx/xilinx_dma.c                                           |   26 
 drivers/edac/edac_device_sysfs.c                                          |   11 
 drivers/edac/igen6_edac.c                                                 |   27 
 drivers/firmware/arm_scmi/base.c                                          |   15 
 drivers/firmware/arm_scmi/sensors.c                                       |   10 
 drivers/firmware/arm_scpi.c                                               |    4 
 drivers/firmware/stratix10-svc.c                                          |    4 
 drivers/gpio/gpio-arizona.c                                               |    8 
 drivers/gpio/gpio-dwapb.c                                                 |   17 
 drivers/gpio/gpio-pisosr.c                                                |    4 
 drivers/gpio/gpio-tps65219.c                                              |    2 
 drivers/gpio/gpio-zynq.c                                                  |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                                |   23 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                               |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                   |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c                                   |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                                   |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                                  |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                                    |    1 
 drivers/gpu/drm/amd/amdgpu/atom.c                                         |    9 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c                                    |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                  |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c                                    |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                     |   17 
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c                                 |    8 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c                           |   11 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                         |   17 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c                     |    7 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c                 |   20 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                  |   24 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                         |    3 
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                              |    7 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c                       |    3 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c          |    4 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                                |   31 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                          |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c                      |    4 
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c                           |    6 
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c                           |   14 
 drivers/gpu/drm/arm/malidp_drv.c                                          |   22 
 drivers/gpu/drm/ast/ast_mode.c                                            |    4 
 drivers/gpu/drm/bridge/samsung-dsim.c                                     |    2 
 drivers/gpu/drm/bridge/tc358768.c                                         |    2 
 drivers/gpu/drm/drm_atomic_uapi.c                                         |   13 
 drivers/gpu/drm/drm_exec.c                                                |   13 
 drivers/gpu/drm/drm_gem.c                                                 |   10 
 drivers/gpu/drm/drm_probe_helper.c                                        |   27 
 drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c                                |   21 
 drivers/gpu/drm/gud/gud_drv.c                                             |    1 
 drivers/gpu/drm/gud/gud_pipe.c                                            |    4 
 drivers/gpu/drm/i915/gem/i915_gem_object.c                                |    2 
 drivers/gpu/drm/i915/i915_query.c                                         |    4 
 drivers/gpu/drm/logicvc/Kconfig                                           |    1 
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c                                   |    3 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                                   |    2 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                        |   36 
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                                       |    8 
 drivers/gpu/drm/nouveau/nouveau_bo.c                                      |    3 
 drivers/gpu/drm/nouveau/nouveau_drm.c                                     |    5 
 drivers/gpu/drm/nouveau/nouveau_gem.c                                     |    2 
 drivers/gpu/drm/nouveau/nvif/vmm.c                                        |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c                         |    1 
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c                            |   23 
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c                          |    2 
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c                          |    2 
 drivers/gpu/drm/panel/panel-simple.c                                      |   28 
 drivers/gpu/drm/tiny/cirrus.c                                             |    7 
 drivers/gpu/drm/vc4/vc4_kms.c                                             |    2 
 drivers/gpu/drm/virtio/virtgpu_display.c                                  |    2 
 drivers/gpu/drm/virtio/virtgpu_gem.c                                      |    2 
 drivers/gpu/drm/virtio/virtgpu_ioctl.c                                    |    6 
 drivers/gpu/drm/virtio/virtgpu_submit.c                                   |   11 
 drivers/gpu/drm/virtio/virtgpu_vram.c                                     |   17 
 drivers/gpu/host1x/bus.c                                                  |    4 
 drivers/hid/amd-sfh-hid/amd_sfh_common.h                                  |    4 
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c                                    |   10 
 drivers/hid/hid-alps.c                                                    |    6 
 drivers/hid/hid-ids.h                                                     |    3 
 drivers/hid/hid-logitech-hidpp.c                                          |   25 
 drivers/hid/hid-quirks.c                                                  |    3 
 drivers/hid/wacom_sys.c                                                   |    5 
 drivers/hv/connection.c                                                   |   47 
 drivers/hv/hyperv_vmbus.h                                                 |    2 
 drivers/hwmon/adt7462.c                                                   |    8 
 drivers/hwmon/applesmc.c                                                  |    7 
 drivers/hwmon/aspeed-pwm-tacho.c                                          |    4 
 drivers/hwmon/corsair-psu.c                                               |   23 
 drivers/hwmon/emc1403.c                                                   |   73 
 drivers/hwmon/gpio-fan.c                                                  |   13 
 drivers/hwmon/hp-wmi-sensors.c                                            |    2 
 drivers/hwmon/pmbus/lm25066.c                                             |   54 
 drivers/hwmon/pmbus/pmbus.h                                               |    3 
 drivers/hwmon/pmbus/pmbus_core.c                                          |    4 
 drivers/hwmon/pmbus/tps53679.c                                            |   11 
 drivers/hwmon/w83791d.c                                                   |    1 
 drivers/hwmon/w83793.c                                                    |    4 
 drivers/hwtracing/coresight/coresight-platform.c                          |   12 
 drivers/i2c/busses/i2c-at91-core.c                                        |    3 
 drivers/i2c/busses/i2c-at91-master.c                                      |   12 
 drivers/i2c/busses/i2c-at91.h                                             |    1 
 drivers/i2c/busses/i2c-imx.c                                              |    3 
 drivers/i2c/i2c-atr.c                                                     |    1 
 drivers/i2c/i2c-core-smbus.c                                              |   12 
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c                                  |    4 
 drivers/i3c/master/mipi-i3c-hci/cmd_v2.c                                  |    4 
 drivers/iio/accel/mma8452.c                                               |   19 
 drivers/iio/adc/qcom-spmi-iadc.c                                          |   18 
 drivers/iio/light/stk3310.c                                               |   76 
 drivers/infiniband/core/iwpm_util.c                                       |    9 
 drivers/infiniband/core/mad.c                                             |    3 
 drivers/infiniband/core/ucma.c                                            |    7 
 drivers/infiniband/core/umem.c                                            |   18 
 drivers/infiniband/core/verbs.c                                           |   12 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                                 |   11 
 drivers/infiniband/hw/efa/efa_com.c                                       |    7 
 drivers/infiniband/hw/efa/efa_com.h                                       |    1 
 drivers/infiniband/hw/efa/efa_main.c                                      |   33 
 drivers/infiniband/hw/hfi1/file_ops.c                                     |   23 
 drivers/infiniband/hw/irdma/utils.c                                       |    2 
 drivers/infiniband/hw/irdma/verbs.c                                       |    2 
 drivers/infiniband/hw/mlx4/sysfs.c                                        |    4 
 drivers/infiniband/hw/mlx5/cq.c                                           |    3 
 drivers/infiniband/hw/mlx5/main.c                                         |   11 
 drivers/infiniband/sw/rxe/rxe_mcast.c                                     |   50 
 drivers/infiniband/sw/rxe/rxe_mr.c                                        |    3 
 drivers/infiniband/sw/rxe/rxe_verbs.c                                     |   13 
 drivers/infiniband/sw/siw/siw_cm.c                                        |   75 
 drivers/infiniband/sw/siw/siw_qp_rx.c                                     |    2 
 drivers/infiniband/ulp/ipoib/ipoib.h                                      |    7 
 drivers/infiniband/ulp/ipoib/ipoib_ib.c                                   |   12 
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c                            |   16 
 drivers/infiniband/ulp/iser/iser_initiator.c                              |   16 
 drivers/infiniband/ulp/isert/ib_isert.c                                   |   22 
 drivers/infiniband/ulp/isert/ib_isert.h                                   |    2 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                                    |    8 
 drivers/infiniband/ulp/rtrs/rtrs-clt.h                                    |    2 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                                    |   12 
 drivers/input/evdev.c                                                     |    2 
 drivers/input/input-compat.c                                              |    2 
 drivers/input/joystick/xpad.c                                             |   10 
 drivers/input/keyboard/adp5588-keys.c                                     |   12 
 drivers/input/keyboard/atkbd.c                                            |    8 
 drivers/input/misc/soc_button_array.c                                     |   16 
 drivers/input/mouse/synaptics.c                                           |    8 
 drivers/input/rmi4/rmi_driver.c                                           |   13 
 drivers/input/rmi4/rmi_smbus.c                                            |   10 
 drivers/input/serio/i8042-acpipnpio.h                                     |    7 
 drivers/input/touchscreen/cyttsp5.c                                       |    1 
 drivers/iommu/rockchip-iommu.c                                            |    8 
 drivers/irqchip/irq-gic-v3-its.c                                          |    1 
 drivers/leds/leds-pca9532.c                                               |    8 
 drivers/leds/uleds.c                                                      |   11 
 drivers/mailbox/mailbox.c                                                 |    6 
 drivers/md/raid5.c                                                        |   35 
 drivers/media/i2c/video-i2c.c                                             |    7 
 drivers/media/pci/dm1105/dm1105.c                                         |    7 
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c |    5 
 drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c                   |    6 
 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c           |   57 
 drivers/media/rc/imon.c                                                   |    4 
 drivers/media/rc/mceusb.c                                                 |    2 
 drivers/media/usb/as102/as102_usb_drv.c                                   |   73 
 drivers/media/usb/em28xx/em28xx-video.c                                   |    4 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                                 |   32 
 drivers/media/v4l2-core/v4l2-h264.c                                       |    3 
 drivers/memstick/core/ms_block.c                                          |    2 
 drivers/mfd/ab8500-core.c                                                 |    2 
 drivers/mfd/db8500-prcmu.c                                                |    6 
 drivers/mfd/rsmu_i2c.c                                                    |    2 
 drivers/mfd/rsmu_spi.c                                                    |    2 
 drivers/mfd/tps65219.c                                                    |   14 
 drivers/mmc/core/bus.c                                                    |    2 
 drivers/mmc/core/host.c                                                   |    1 
 drivers/mmc/core/queue.c                                                  |    8 
 drivers/mmc/core/sdio_uart.c                                              |    3 
 drivers/mmc/host/davinci_mmc.c                                            |   16 
 drivers/mmc/host/mmc_hsq.c                                                |    8 
 drivers/mmc/host/mmc_spi.c                                                |    1 
 drivers/mmc/host/mxcmmc.c                                                 |    4 
 drivers/mmc/host/renesas_sdhi_internal_dmac.c                             |    2 
 drivers/mmc/host/rtsx_pci_sdmmc.c                                         |    5 
 drivers/mmc/host/sdhci-of-aspeed.c                                        |    5 
 drivers/mmc/host/sdhci_am654.c                                            |    4 
 drivers/mmc/host/sh_mmcif.c                                               |    3 
 drivers/net/bonding/bond_alb.c                                            |   32 
 drivers/net/bonding/bond_main.c                                           |    6 
 drivers/net/dsa/bcm_sf2_cfp.c                                             |    2 
 drivers/net/dsa/mt7530-mdio.c                                             |   20 
 drivers/net/dsa/mv88e6xxx/chip.c                                          |   23 
 drivers/net/dsa/qca/qca8k-8xxx.c                                          |   22 
 drivers/net/dsa/qca/qca8k.h                                               |    1 
 drivers/net/dsa/realtek/rtl8365mb.c                                       |   14 
 drivers/net/dsa/sja1105/sja1105_flower.c                                  |    4 
 drivers/net/ethernet/allwinner/sun4i-emac.c                               |    2 
 drivers/net/ethernet/amd/au1000_eth.c                                     |    3 
 drivers/net/ethernet/amd/pds_core/fw.c                                    |   10 
 drivers/net/ethernet/amd/pds_core/main.c                                  |    8 
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c                                  |    3 
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c                           |    3 
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c                           |    3 
 drivers/net/ethernet/atheros/atlx/atl1.c                                  |    3 
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c                          |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                 |   19 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                            |   63 
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                            |    5 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c                        |   20 
 drivers/net/ethernet/broadcom/tg3.c                                       |   15 
 drivers/net/ethernet/cadence/macb.h                                       |    2 
 drivers/net/ethernet/cadence/macb_main.c                                  |   39 
 drivers/net/ethernet/cadence/macb_ptp.c                                   |    9 
 drivers/net/ethernet/cavium/thunder/nicvf_main.c                          |    8 
 drivers/net/ethernet/cortina/gemini.c                                     |   79 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c                       |   69 
 drivers/net/ethernet/freescale/fman/fman.c                                |    1 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c                         |    3 
 drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c                         |    4 
 drivers/net/ethernet/ibm/emac/core.c                                      |    3 
 drivers/net/ethernet/ibm/emac/mal.c                                       |    6 
 drivers/net/ethernet/intel/e1000e/ethtool.c                               |   19 
 drivers/net/ethernet/intel/ice/ice_common.c                               |    9 
 drivers/net/ethernet/intel/ice/ice_sched.c                                |    4 
 drivers/net/ethernet/intel/ice/ice_txrx.c                                 |   20 
 drivers/net/ethernet/intel/ice/ice_type.h                                 |    2 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                           |    3 
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c                           |   10 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c                   |   10 
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c                          |   60 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                               |   22 
 drivers/net/ethernet/mediatek/mtk_eth_soc.h                               |    2 
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig                           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c                         |   15 
 drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c                   |   45 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c                    |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c                        |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c                 |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c                        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                         |    1 
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c                      |   15 
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h                      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                         |    8 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads_termtbl.c        |    7 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                            |    2 
 drivers/net/ethernet/micrel/ks8842.c                                      |    4 
 drivers/net/ethernet/micrel/ks8851_common.c                               |   10 
 drivers/net/ethernet/micrel/ks8851_spi.c                                  |    4 
 drivers/net/ethernet/micrel/ksz884x.c                                     |    4 
 drivers/net/ethernet/microchip/lan743x_main.c                             |    2 
 drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c                       |    5 
 drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c                  |   18 
 drivers/net/ethernet/microsoft/mana/mana_en.c                             |    6 
 drivers/net/ethernet/netronome/nfp/crypto/ipsec.c                         |    3 
 drivers/net/ethernet/socionext/netsec.c                                   |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c                            |    5 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c                        |    4 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h                            |    4 
 drivers/net/ethernet/stmicro/stmmac/hwif.h                                |    2 
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c                           |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                         |    9 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c                          |    1 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c                    |  106 
 drivers/net/ethernet/ti/cpsw.c                                            |   41 
 drivers/net/ethernet/ti/cpsw_new.c                                        |   39 
 drivers/net/ethernet/ti/cpsw_priv.h                                       |    1 
 drivers/net/ethernet/ti/netcp_core.c                                      |    2 
 drivers/net/fddi/skfp/skfddi.c                                            |    3 
 drivers/net/gtp.c                                                         |   18 
 drivers/net/ieee802154/mac802154_hwsim.c                                  |   10 
 drivers/net/phy/motorcomm.c                                               |   41 
 drivers/net/ppp/ppp_async.c                                               |   89 
 drivers/net/ppp/ppp_synctty.c                                             |   14 
 drivers/net/usb/catc.c                                                    |   15 
 drivers/net/usb/cdc_mbim.c                                                |    5 
 drivers/net/usb/cx82310_eth.c                                             |    1 
 drivers/net/usb/hso.c                                                     |    2 
 drivers/net/usb/lan78xx.c                                                 |    9 
 drivers/net/usb/pegasus.c                                                 |   54 
 drivers/net/usb/pegasus.h                                                 |    3 
 drivers/net/usb/qmi_wwan.c                                                |    2 
 drivers/net/usb/sr9700.c                                                  |    3 
 drivers/net/veth.c                                                        |    2 
 drivers/net/vrf.c                                                         |    2 
 drivers/net/vxlan/vxlan_core.c                                            |   17 
 drivers/net/vxlan/vxlan_mdb.c                                             |    8 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                   |   50 
 drivers/net/wireless/ath/ath12k/qmi.c                                     |   59 
 drivers/net/wireless/ath/ath12k/qmi.h                                     |    2 
 drivers/net/wireless/ath/ath9k/hif_usb.c                                  |   12 
 drivers/net/wireless/ath/ath9k/hif_usb.h                                  |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c                   |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c            |    4 
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c                            |   10 
 drivers/net/wireless/intel/iwlegacy/common.c                              |    2 
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c                              |    5 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                              |   13 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                               |   19 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                         |    6 
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c                               |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                             |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                               |   11 
 drivers/net/wireless/intersil/p54/eeprom.c                                |   22 
 drivers/net/wireless/marvell/libertas/tx.c                                |    7 
 drivers/net/wireless/marvell/libertas_tf/main.c                           |    2 
 drivers/net/wireless/marvell/mwifiex/fw.h                                 |   18 
 drivers/net/wireless/marvell/mwifiex/join.c                               |    8 
 drivers/net/wireless/marvell/mwifiex/pcie.c                               |    2 
 drivers/net/wireless/marvell/mwifiex/scan.c                               |   54 
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c                            |    2 
 drivers/net/wireless/marvell/mwifiex/util.c                               |   10 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                           |   33 
 drivers/net/wireless/mediatek/mt76/pci.c                                  |    8 
 drivers/net/wireless/microchip/wilc1000/cfg80211.c                        |   14 
 drivers/net/wireless/microchip/wilc1000/wlan.c                            |    9 
 drivers/net/wireless/ralink/rt2x00/rt2400pci.c                            |    2 
 drivers/net/wireless/ralink/rt2x00/rt2500pci.c                            |    2 
 drivers/net/wireless/ralink/rt2x00/rt2800pci.c                            |    2 
 drivers/net/wireless/ralink/rt2x00/rt61pci.c                              |    2 
 drivers/net/wireless/realtek/rtw88/fw.c                                   |   11 
 drivers/net/wireless/realtek/rtw88/tx.c                                   |    2 
 drivers/net/wireless/realtek/rtw89/core.c                                 |    4 
 drivers/net/wireless/realtek/rtw89/pci.c                                  |   16 
 drivers/net/wireless/rsi/rsi_91x_hal.c                                    |    8 
 drivers/net/wireless/rsi/rsi_91x_mgmt.c                                   |    8 
 drivers/net/wireless/ti/wlcore/main.c                                     |    4 
 drivers/net/wireless/virtual/mac80211_hwsim.c                             |   45 
 drivers/net/wireless/virtual/virt_wifi.c                                  |    4 
 drivers/net/wwan/mhi_wwan_mbim.c                                          |   28 
 drivers/net/wwan/t7xx/t7xx_netdev.c                                       |    4 
 drivers/net/wwan/t7xx/t7xx_pci.c                                          |    3 
 drivers/nfc/microread/microread.c                                         |    6 
 drivers/nfc/nfcmrvl/fw_dnld.c                                             |   11 
 drivers/nfc/pn533/pn533.c                                                 |   14 
 drivers/nfc/pn533/pn533.h                                                 |    4 
 drivers/nfc/pn533/usb.c                                                   |    4 
 drivers/nfc/pn544/pn544.c                                                 |    7 
 drivers/nfc/port100.c                                                     |    7 
 drivers/nfc/st21nfca/core.c                                               |   12 
 drivers/nfc/st21nfca/i2c.c                                                |   29 
 drivers/nfc/virtual_ncidev.c                                              |    3 
 drivers/nvme/host/apple.c                                                 |  182 -
 drivers/nvme/host/core.c                                                  |    6 
 drivers/nvme/host/fabrics.c                                               |    6 
 drivers/nvme/host/fc.c                                                    |    7 
 drivers/nvme/host/rdma.c                                                  |   18 
 drivers/of/dynamic.c                                                      |   20 
 drivers/of/overlay.c                                                      |   15 
 drivers/opp/of.c                                                          |    2 
 drivers/pci/controller/dwc/pcie-intel-gw.c                                |   19 
 drivers/pci/controller/pcie-altera.c                                      |    2 
 drivers/pci/controller/pcie-iproc.c                                       |    2 
 drivers/pci/controller/pcie-mediatek.c                                    |    2 
 drivers/pci/controller/pcie-rockchip-host.c                               |    2 
 drivers/pci/of_property.c                                                 |   11 
 drivers/pci/pci-driver.c                                                  |   10 
 drivers/pci/pci-sysfs.c                                                   |   11 
 drivers/pci/pci.c                                                         |   24 
 drivers/pci/proc.c                                                        |   79 
 drivers/pci/quirks.c                                                      |    3 
 drivers/pci/switch/switchtec.c                                            |   16 
 drivers/perf/arm-cmn.c                                                    |   10 
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c                                |    4 
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h                                |    3 
 drivers/pinctrl/meson/pinctrl-meson-s4.c                                  |    2 
 drivers/pinctrl/pinctrl-single.c                                          |    3 
 drivers/pinctrl/renesas/pinctrl-rzv2m.c                                   |    4 
 drivers/platform/x86/dell/dell-laptop.c                                   |    9 
 drivers/platform/x86/intel/hid.c                                          |    7 
 drivers/ptp/ptp_ocp.c                                                     |    1 
 drivers/regulator/core.c                                                  |  163 
 drivers/regulator/da9121-regulator.c                                      |   18 
 drivers/regulator/db8500-prcmu.c                                          |   12 
 drivers/remoteproc/qcom_q6v5_adsp.c                                       |    8 
 drivers/rtc/rtc-aspeed.c                                                  |    1 
 drivers/rtc/rtc-bq32k.c                                                   |    9 
 drivers/s390/char/zcore.c                                                 |    8 
 drivers/s390/cio/chp.c                                                    |    3 
 drivers/s390/cio/cio.c                                                    |   11 
 drivers/s390/cio/device.c                                                 |    9 
 drivers/s390/cio/device_fsm.c                                             |    3 
 drivers/s390/cio/device_ops.c                                             |   23 
 drivers/s390/cio/vfio_ccw_fsm.c                                           |    2 
 drivers/s390/net/ism_drv.c                                                |    4 
 drivers/s390/net/qeth_l2.h                                                |    3 
 drivers/s390/net/qeth_l2_main.c                                           |   26 
 drivers/s390/net/qeth_l2_sys.c                                            |    7 
 drivers/scsi/bfa/bfa_fcs_lport.c                                          |    2 
 drivers/scsi/libiscsi_tcp.c                                               |    3 
 drivers/scsi/megaraid/megaraid_sas_base.c                                 |    4 
 drivers/scsi/mpi3mr/mpi3mr_transport.c                                    |    8 
 drivers/scsi/mpt3sas/mpt3sas_base.c                                       |    5 
 drivers/scsi/pm8001/pm8001_ctl.c                                          |    8 
 drivers/scsi/pm8001/pm80xx_hwi.c                                          |    7 
 drivers/scsi/qla2xxx/qla_os.c                                             |    2 
 drivers/scsi/scsi.c                                                       |   24 
 drivers/scsi/scsi_error.c                                                 |    2 
 drivers/soc/ti/pm33xx.c                                                   |    2 
 drivers/soundwire/bus.c                                                   |    4 
 drivers/soundwire/cadence_master.c                                        |    7 
 drivers/soundwire/dmi-quirks.c                                            |   35 
 drivers/soundwire/intel.c                                                 |   31 
 drivers/soundwire/intel_ace2x.c                                           |   39 
 drivers/soundwire/slave.c                                                 |    4 
 drivers/spi/spi-dw-dma.c                                                  |    3 
 drivers/spi/spi-dw.h                                                      |    1 
 drivers/spi/spi-qcom-qspi.c                                               |   44 
 drivers/spi/spi-xilinx.c                                                  |    6 
 drivers/spi/spi-zynqmp-gqspi.c                                            |   52 
 drivers/spi/spi.c                                                         |    9 
 drivers/staging/fbtft/fbtft-core.c                                        |    9 
 drivers/target/iscsi/iscsi_target.c                                       |    4 
 drivers/tee/optee/call.c                                                  |    3 
 drivers/thermal/db8500_thermal.c                                          |   10 
 drivers/thermal/qcom/tsens.c                                              |  111 
 drivers/thermal/qcom/tsens.h                                              |    1 
 drivers/thermal/tegra/soctherm.c                                          |    6 
 drivers/thunderbolt/icm.c                                                 |   10 
 drivers/thunderbolt/switch.c                                              |    6 
 drivers/thunderbolt/tb.c                                                  |    9 
 drivers/thunderbolt/tb_regs.h                                             |    1 
 drivers/thunderbolt/usb4.c                                                |   11 
 drivers/thunderbolt/xdomain.c                                             |   41 
 drivers/tty/serial/8250/8250_port.c                                       |    7 
 drivers/usb/atm/xusbatm.c                                                 |    6 
 drivers/usb/class/cdc-acm.c                                               |    6 
 drivers/usb/class/usbtmc.c                                                |    2 
 drivers/usb/core/hcd.c                                                    |   14 
 drivers/usb/gadget/udc/aspeed_udc.c                                       |    7 
 drivers/usb/gadget/udc/core.c                                             |    7 
 drivers/usb/gadget/udc/goku_udc.c                                         |    3 
 drivers/usb/host/Kconfig                                                  |    2 
 drivers/usb/host/xhci-debugfs.c                                           |   16 
 drivers/usb/host/xhci-hub.c                                               |  117 
 drivers/usb/host/xhci-mem.c                                               |   40 
 drivers/usb/host/xhci-pci.c                                               |    8 
 drivers/usb/host/xhci-ring.c                                              |   14 
 drivers/usb/host/xhci-tegra.c                                             |   12 
 drivers/usb/host/xhci-trace.h                                             |    5 
 drivers/usb/host/xhci.c                                                   |   79 
 drivers/usb/host/xhci.h                                                   |   44 
 drivers/usb/serial/spcp8x5.c                                              |    6 
 drivers/usb/usbip/vhci_sysfs.c                                            |   52 
 drivers/vdpa/ifcvf/ifcvf_main.c                                           |   14 
 drivers/vdpa/solidrun/snet_main.c                                         |    6 
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c                                      |    3 
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c                                      |    7 
 drivers/vhost/scsi.c                                                      |    3 
 drivers/vhost/vdpa.c                                                      |  106 
 drivers/video/fbdev/pm2fb.c                                               |    1 
 drivers/video/fbdev/vfb.c                                                 |   11 
 drivers/virtio/virtio_input.c                                             |    9 
 drivers/virtio/virtio_pci_common.c                                        |    4 
 drivers/virtio/virtio_vdpa.c                                              |    2 
 drivers/watchdog/da9063_wdt.c                                             |    4 
 drivers/watchdog/db8500_wdt.c                                             |   22 
 drivers/watchdog/digicolor_wdt.c                                          |   13 
 drivers/watchdog/msc313e_wdt.c                                            |   88 
 drivers/watchdog/rtd119x_wdt.c                                            |    7 
 drivers/watchdog/sp5100_tco.c                                             |    6 
 drivers/watchdog/starfive-wdt.c                                           |    2 
 drivers/watchdog/sunxi_wdt.c                                              |   45 
 drivers/watchdog/watchdog_hrtimer_pretimeout.c                            |    1 
 drivers/xen/gntalloc.c                                                    |   13 
 drivers/xen/xen-front-pgdir-shbuf.c                                       |   12 
 fs/9p/vfs_dir.c                                                           |   14 
 fs/affs/affs.h                                                            |    5 
 fs/affs/super.c                                                           |    6 
 fs/autofs/inode.c                                                         |    4 
 fs/befs/linuxvfs.c                                                        |    3 
 fs/bfs/inode.c                                                            |    3 
 fs/btrfs/block-group.c                                                    |    3 
 fs/btrfs/btrfs_inode.h                                                    |    2 
 fs/btrfs/file.c                                                           |   12 
 fs/btrfs/free-space-cache.c                                               |   13 
 fs/btrfs/inode.c                                                          |   42 
 fs/btrfs/ioctl.c                                                          |   13 
 fs/btrfs/raid-stripe-tree.c                                               |   19 
 fs/btrfs/raid-stripe-tree.h                                               |    1 
 fs/btrfs/reflink.c                                                        |    3 
 fs/btrfs/relocation.c                                                     |   47 
 fs/btrfs/send.c                                                           |    2 
 fs/btrfs/transaction.c                                                    |   13 
 fs/btrfs/tree-checker.c                                                   |   43 
 fs/btrfs/tree-log.c                                                       |   12 
 fs/btrfs/verity.c                                                         |    4 
 fs/btrfs/volumes.c                                                        |   10 
 fs/btrfs/xattr.c                                                          |    4 
 fs/btrfs/zoned.c                                                          |    2 
 fs/cachefiles/namei.c                                                     |    1 
 fs/configfs/dir.c                                                         |   12 
 fs/erofs/fscache.c                                                        |    2 
 fs/exec.c                                                                 |   51 
 fs/f2fs/inline.c                                                          |    7 
 fs/freevxfs/vxfs_bmap.c                                                   |    3 
 fs/fs-writeback.c                                                         |   25 
 fs/fuse/file.c                                                            |    3 
 fs/gfs2/bmap.c                                                            |   19 
 fs/gfs2/bmap.h                                                            |    1 
 fs/gfs2/file.c                                                            |   10 
 fs/hfs/catalog.c                                                          |    9 
 fs/hfs/dir.c                                                              |   28 
 fs/hfs/hfs.h                                                              |    3 
 fs/hfs/hfs_fs.h                                                           |    2 
 fs/hfs/inode.c                                                            |    4 
 fs/hfsplus/catalog.c                                                      |   11 
 fs/hfsplus/dir.c                                                          |   28 
 fs/hfsplus/hfsplus_fs.h                                                   |    5 
 fs/hfsplus/inode.c                                                        |   40 
 fs/hfsplus/super.c                                                        |    2 
 fs/hpfs/super.c                                                           |    3 
 fs/isofs/inode.c                                                          |    3 
 fs/jfs/super.c                                                            |    3 
 fs/minix/inode.c                                                          |    3 
 fs/nfs/nfs42proc.c                                                        |   15 
 fs/ntfs3/dir.c                                                            |    4 
 fs/ntfs3/fslog.c                                                          |   26 
 fs/ntfs3/index.c                                                          |   41 
 fs/ntfs3/super.c                                                          |    8 
 fs/ntfs3/xattr.c                                                          |    4 
 fs/ocfs2/namei.c                                                          |    9 
 fs/ocfs2/xattr.c                                                          |   13 
 fs/ocfs2/xattr.h                                                          |    8 
 fs/omfs/inode.c                                                           |    6 
 fs/qnx4/inode.c                                                           |    3 
 fs/smb/client/cifsacl.c                                                   |   30 
 fs/smb/client/connect.c                                                   |   36 
 fs/smb/client/file.c                                                      |    5 
 fs/smb/client/misc.c                                                      |   36 
 fs/smb/client/readdir.c                                                   |    9 
 fs/smb/client/reparse.c                                                   |    5 
 fs/smb/client/smb2inode.c                                                 |   11 
 fs/smb/client/smb2ops.c                                                   |   75 
 fs/smb/client/smb2pdu.c                                                   |   64 
 fs/smb/client/transport.c                                                 |   11 
 fs/smb/server/mgmt/share_config.c                                         |   38 
 fs/smb/server/mgmt/user_session.c                                         |   25 
 fs/smb/server/misc.c                                                      |   14 
 fs/smb/server/oplock.c                                                    |  221 +
 fs/smb/server/oplock.h                                                    |    2 
 fs/smb/server/server.c                                                    |    6 
 fs/smb/server/smb2misc.c                                                  |    9 
 fs/smb/server/smb2pdu.c                                                   |  362 +-
 fs/smb/server/smb2pdu.h                                                   |    1 
 fs/smb/server/smbacl.c                                                    |   25 
 fs/smb/server/transport_ipc.c                                             |   21 
 fs/smb/server/vfs.c                                                       |   46 
 fs/smb/server/vfs_cache.c                                                 |   28 
 fs/smb/server/vfs_cache.h                                                 |    8 
 fs/squashfs/xz_wrapper.c                                                  |    6 
 fs/ufs/cylinder.c                                                         |   10 
 fs/ufs/dir.c                                                              |  122 
 fs/ufs/ialloc.c                                                           |    2 
 fs/ufs/inode.c                                                            |   42 
 fs/ufs/super.c                                                            |   17 
 fs/xfs/scrub/agheader_repair.c                                            |   39 
 fs/xfs/scrub/ialloc.c                                                     |    4 
 fs/xfs/scrub/scrub.c                                                      |    3 
 fs/xfs/scrub/stats.c                                                      |   60 
 fs/xfs/scrub/stats.h                                                      |    4 
 fs/xfs/xfs_icache.c                                                       |    2 
 include/drm/drm_probe_helper.h                                            |    2 
 include/keys/request_key_auth-type.h                                      |    2 
 include/linux/bitfield.h                                                  |    2 
 include/linux/bpf.h                                                       |    2 
 include/linux/dev_printk.h                                                |    1 
 include/linux/firmware/intel/stratix10-smc.h                              |   18 
 include/linux/fwnode.h                                                    |    1 
 include/linux/ipv6.h                                                      |   35 
 include/linux/kcsan-checks.h                                              |    6 
 include/linux/mailbox_controller.h                                        |    2 
 include/linux/mfd/db8500-prcmu.h                                          |  252 +
 include/linux/mfd/dbx500-prcmu.h                                          |  575 ---
 include/linux/netdevice.h                                                 |   28 
 include/linux/perf_event.h                                                |    5 
 include/linux/rculist.h                                                   |   29 
 include/linux/rtnetlink.h                                                 |    7 
 include/linux/skbuff.h                                                    |    5 
 include/linux/switchtec.h                                                 |    1 
 include/linux/thunderbolt.h                                               |    2 
 include/linux/vdpa.h                                                      |   41 
 include/linux/workqueue.h                                                 |   41 
 include/media/v4l2-hevc.h                                                 |   41 
 include/net/cfg80211.h                                                    |    2 
 include/net/cfg802154.h                                                   |    1 
 include/net/gue.h                                                         |   19 
 include/net/if_inet6.h                                                    |    2 
 include/net/inet_sock.h                                                   |    1 
 include/net/ip.h                                                          |    3 
 include/net/ip6_route.h                                                   |    2 
 include/net/ip_fib.h                                                      |    5 
 include/net/ipv6.h                                                        |    4 
 include/net/mac80211.h                                                    |    9 
 include/net/netfilter/nf_conntrack.h                                      |    5 
 include/net/netfilter/nf_tables.h                                         |    3 
 include/net/netns/nftables.h                                              |    1 
 include/net/netns/xfrm.h                                                  |    2 
 include/net/nfc/hci.h                                                     |    2 
 include/net/nfc/nfc.h                                                     |    3 
 include/net/sch_generic.h                                                 |    2 
 include/net/sock.h                                                        |    2 
 include/rdma/ib_umem.h                                                    |    4 
 include/sound/hda_codec.h                                                 |   30 
 include/sound/rawmidi.h                                                   |    2 
 include/trace/events/icmp.h                                               |   13 
 include/uapi/linux/vhost_types.h                                          |    7 
 include/uapi/linux/virtio_crypto.h                                        |    1 
 include/uapi/sound/asound.h                                               |    6 
 kernel/bpf/bpf_iter.c                                                     |    2 
 kernel/bpf/btf.c                                                          |   22 
 kernel/bpf/cgroup.c                                                       |    1 
 kernel/bpf/disasm.c                                                       |    5 
 kernel/bpf/hashtab.c                                                      |   24 
 kernel/bpf/helpers.c                                                      |   58 
 kernel/bpf/offload.c                                                      |    2 
 kernel/bpf/syscall.c                                                      |    5 
 kernel/bpf/verifier.c                                                     |   15 
 kernel/dma/coherent.c                                                     |   13 
 kernel/events/ring_buffer.c                                               |    9 
 kernel/locking/lockdep.c                                                  |   50 
 kernel/rcu/tasks.h                                                        |    3 
 kernel/sched/fair.c                                                       |   11 
 kernel/time/clockevents.c                                                 |   33 
 kernel/time/tick-broadcast.c                                              |   36 
 kernel/time/tick-internal.h                                               |    2 
 kernel/trace/Makefile                                                     |    5 
 kernel/trace/bpf_trace.c                                                  |   11 
 kernel/trace/ring_buffer.c                                                |   13 
 kernel/trace/trace_event_perf.c                                           |   12 
 kernel/trace/trace_events_hist.c                                          |   53 
 kernel/trace/trace_events_user.c                                          |   26 
 kernel/trace/trace_probe.c                                                |   48 
 kernel/trace/trace_probe.h                                                |    2 
 kernel/workqueue.c                                                        |    7 
 mm/backing-dev.c                                                          |    5 
 mm/damon/core.c                                                           |   13 
 mm/huge_memory.c                                                          |   10 
 mm/memblock.c                                                             |   18 
 mm/mlock.c                                                                |    2 
 net/8021q/vlan.c                                                          |   23 
 net/8021q/vlan.h                                                          |    2 
 net/8021q/vlan_dev.c                                                      |   61 
 net/9p/client.c                                                           |    2 
 net/appletalk/aarp.c                                                      |    5 
 net/atm/pppoatm.c                                                         |   42 
 net/bluetooth/bnep/core.c                                                 |   17 
 net/bluetooth/bnep/netdev.c                                               |    8 
 net/bluetooth/eir.c                                                       |   10 
 net/bluetooth/hci_codec.c                                                 |   36 
 net/bluetooth/hci_conn.c                                                  |   14 
 net/bluetooth/hci_core.c                                                  |    4 
 net/bluetooth/hci_sock.c                                                  |   20 
 net/bluetooth/hci_sync.c                                                  |    2 
 net/bluetooth/iso.c                                                       |   32 
 net/bluetooth/l2cap_core.c                                                |   28 
 net/bluetooth/mgmt.c                                                      |   27 
 net/bluetooth/msft.c                                                      |    2 
 net/bluetooth/rfcomm/core.c                                               |    6 
 net/bluetooth/rfcomm/sock.c                                               |   19 
 net/bluetooth/smp.c                                                       |   17 
 net/bridge/br_arp_nd_proxy.c                                              |   16 
 net/bridge/br_device.c                                                    |    2 
 net/bridge/br_fdb.c                                                       |    7 
 net/bridge/br_input.c                                                     |    2 
 net/bridge/br_mst.c                                                       |   20 
 net/bridge/br_multicast.c                                                 |   11 
 net/bridge/br_stp_bpdu.c                                                  |    5 
 net/core/dev.c                                                            |   68 
 net/core/drop_monitor.c                                                   |   22 
 net/core/filter.c                                                         |   67 
 net/core/skbuff.c                                                         |   16 
 net/core/skmsg.c                                                          |    4 
 net/core/sock.c                                                           |   13 
 net/core/sock_map.c                                                       |    1 
 net/dccp/ipv6.c                                                           |    2 
 net/hsr/hsr_forward.c                                                     |    2 
 net/hsr/hsr_netlink.c                                                     |    9 
 net/ieee802154/6lowpan/core.c                                             |    2 
 net/ipv4/arp.c                                                            |    1 
 net/ipv4/esp4.c                                                           |    6 
 net/ipv4/fib_rules.c                                                      |    4 
 net/ipv4/fib_trie.c                                                       |    4 
 net/ipv4/fou_core.c                                                       |    6 
 net/ipv4/icmp.c                                                           |   17 
 net/ipv4/inet_connection_sock.c                                           |    3 
 net/ipv4/inet_fragment.c                                                  |    6 
 net/ipv4/ip_gre.c                                                         |   12 
 net/ipv4/ip_tunnel_core.c                                                 |    6 
 net/ipv4/nexthop.c                                                        |    2 
 net/ipv4/sysctl_net_ipv4.c                                                |    4 
 net/ipv4/tcp_input.c                                                      |    3 
 net/ipv4/tcp_output.c                                                     |    3 
 net/ipv4/udp.c                                                            |    4 
 net/ipv6/addrconf.c                                                       |   13 
 net/ipv6/af_inet6.c                                                       |    2 
 net/ipv6/esp6.c                                                           |    6 
 net/ipv6/exthdrs.c                                                        |    4 
 net/ipv6/exthdrs_core.c                                                   |    3 
 net/ipv6/ip6_fib.c                                                        |    4 
 net/ipv6/ip6_gre.c                                                        |    8 
 net/ipv6/ip6_output.c                                                     |   23 
 net/ipv6/ipv6_sockglue.c                                                  |   90 
 net/ipv6/mcast.c                                                          |  273 -
 net/ipv6/ndisc.c                                                          |    4 
 net/ipv6/netfilter/ip6_tables.c                                           |    5 
 net/ipv6/netfilter/ip6t_rpfilter.c                                        |    2 
 net/ipv6/netfilter/ip6t_rt.c                                              |   11 
 net/ipv6/route.c                                                          |   22 
 net/ipv6/seg6.c                                                           |    4 
 net/ipv6/seg6_local.c                                                     |    3 
 net/ipv6/tcp_ipv6.c                                                       |    6 
 net/ipv6/xfrm6_output.c                                                   |   10 
 net/llc/llc_c_ac.c                                                        |    2 
 net/llc/llc_s_ac.c                                                        |    4 
 net/llc/llc_sap.c                                                         |    8 
 net/mac80211/cfg.c                                                        |   14 
 net/mac80211/debugfs.c                                                    |    2 
 net/mac80211/debugfs_netdev.c                                             |    9 
 net/mac80211/ieee80211_i.h                                                |    7 
 net/mac80211/iface.c                                                      |   31 
 net/mac80211/main.c                                                       |    4 
 net/mac80211/mesh.c                                                       |    1 
 net/mac80211/mlme.c                                                       |    6 
 net/mac80211/pm.c                                                         |    8 
 net/mac80211/status.c                                                     |    4 
 net/mac80211/tdls.c                                                       |   19 
 net/mac80211/tx.c                                                         |   46 
 net/mac802154/ieee802154_i.h                                              |    8 
 net/mac802154/iface.c                                                     |    6 
 net/mac802154/main.c                                                      |    1 
 net/mac802154/rx.c                                                        |  120 
 net/mac802154/scan.c                                                      |   10 
 net/mptcp/options.c                                                       |    3 
 net/mptcp/protocol.c                                                      |   15 
 net/mptcp/protocol.h                                                      |    3 
 net/mptcp/subflow.c                                                       |   12 
 net/mptcp/syncookies.c                                                    |    5 
 net/netfilter/ipset/ip_set_hash_gen.h                                     |   13 
 net/netfilter/ipvs/ip_vs_core.c                                           |    6 
 net/netfilter/ipvs/ip_vs_sync.c                                           |   30 
 net/netfilter/nf_conntrack_expect.c                                       |    3 
 net/netfilter/nf_conntrack_netlink.c                                      |   16 
 net/netfilter/nf_conntrack_proto_tcp.c                                    |   10 
 net/netfilter/nf_conntrack_sip.c                                          |    2 
 net/netfilter/nf_flow_table_core.c                                        |   12 
 net/netfilter/nf_flow_table_offload.c                                     |    7 
 net/netfilter/nf_log_syslog.c                                             |    6 
 net/netfilter/nf_tables_api.c                                             |  151 
 net/netfilter/nfnetlink_log.c                                             |   28 
 net/netfilter/nfnetlink_queue.c                                           |   77 
 net/netfilter/nft_chain_filter.c                                          |   48 
 net/netfilter/nft_nat.c                                                   |    2 
 net/netfilter/nft_set_pipapo_avx2.c                                       |    1 
 net/netfilter/nft_set_rbtree.c                                            |    2 
 net/netfilter/nft_synproxy.c                                              |    3 
 net/netlabel/netlabel_unlabeled.c                                         |    2 
 net/netlink/genetlink.c                                                   |    8 
 net/nfc/core.c                                                            |   15 
 net/nfc/digital_dep.c                                                     |    8 
 net/nfc/llcp.h                                                            |    1 
 net/nfc/llcp_commands.c                                                   |    2 
 net/nfc/llcp_core.c                                                       |  175 -
 net/nfc/llcp_sock.c                                                       |   65 
 net/nfc/nci/core.c                                                        |   10 
 net/nfc/netlink.c                                                         |    7 
 net/nfc/nfc.h                                                             |    3 
 net/openvswitch/conntrack.c                                               |   14 
 net/openvswitch/flow.c                                                    |    4 
 net/openvswitch/flow_table.c                                              |    4 
 net/packet/af_packet.c                                                    |  108 
 net/packet/internal.h                                                     |    2 
 net/phonet/pn_dev.c                                                       |   30 
 net/qrtr/af_qrtr.c                                                        |    4 
 net/rds/af_rds.c                                                          |   63 
 net/rds/connection.c                                                      |  102 
 net/rds/ib_cm.c                                                           |   27 
 net/rds/ib_frmr.c                                                         |   11 
 net/rds/ib_recv.c                                                         |    9 
 net/rds/message.c                                                         |    4 
 net/rds/send.c                                                            |   16 
 net/rds/tcp.c                                                             |  164 
 net/rds/tcp_listen.c                                                      |    6 
 net/sched/act_api.c                                                       |  136 
 net/sched/act_csum.c                                                      |    8 
 net/sched/act_ct.c                                                        |    5 
 net/sched/act_gate.c                                                      |   30 
 net/sched/cls_api.c                                                       |    2 
 net/sched/cls_route.c                                                     |  101 
 net/sched/cls_u32.c                                                       |   44 
 net/sched/sch_api.c                                                       |    2 
 net/sched/sch_drr.c                                                       |   13 
 net/sched/sch_ets.c                                                       |   12 
 net/sched/sch_fq_pie.c                                                    |   62 
 net/sched/sch_generic.c                                                   |   20 
 net/sched/sch_hfsc.c                                                      |   22 
 net/sched/sch_hhf.c                                                       |   15 
 net/sched/sch_pie.c                                                       |    2 
 net/sched/sch_sfq.c                                                       |    7 
 net/sched/sch_teql.c                                                      |    7 
 net/sctp/associola.c                                                      |   15 
 net/sctp/input.c                                                          |    7 
 net/sctp/ipv6.c                                                           |   10 
 net/sctp/protocol.c                                                       |   10 
 net/sctp/sm_make_chunk.c                                                  |   14 
 net/sctp/sm_sideeffect.c                                                  |   48 
 net/sctp/sm_statefuns.c                                                   |    7 
 net/smc/smc_core.c                                                        |    2 
 net/smc/smc_ib.c                                                          |   10 
 net/sunrpc/xprtrdma/verbs.c                                               |   21 
 net/tipc/group.c                                                          |    4 
 net/tipc/monitor.c                                                        |    3 
 net/tipc/name_table.c                                                     |   30 
 net/tipc/socket.c                                                         |    4 
 net/tls/tls_main.c                                                        |   11 
 net/tls/tls_sw.c                                                          |   18 
 net/unix/af_unix.c                                                        |   42 
 net/unix/garbage.c                                                        |    1 
 net/vmw_vsock/hyperv_transport.c                                          |    2 
 net/vmw_vsock/vmci_transport.c                                            |    2 
 net/wireless/mlme.c                                                       |  101 
 net/wireless/nl80211.c                                                    |    8 
 net/wireless/scan.c                                                       |   12 
 net/wireless/util.c                                                       |   26 
 net/wireless/wext-sme.c                                                   |    9 
 net/xdp/xskmap.c                                                          |    2 
 net/xfrm/espintcp.c                                                       |    6 
 net/xfrm/xfrm_input.c                                                     |   11 
 net/xfrm/xfrm_state.c                                                     |    5 
 net/xfrm/xfrm_user.c                                                      |   37 
 scripts/mod/modpost.c                                                     |   11 
 scripts/sorttable.c                                                       |    2 
 security/apparmor/lsm.c                                                   |    4 
 security/apparmor/policy.c                                                |   13 
 security/apparmor/policy_unpack.c                                         |    2 
 security/integrity/digsig_asymmetric.c                                    |    4 
 security/integrity/ima/ima_appraise.c                                     |    5 
 security/keys/gc.c                                                        |    4 
 security/keys/request_key_auth.c                                          |   12 
 security/keys/trusted-keys/trusted_tpm2.c                                 |   12 
 security/selinux/avc.c                                                    |    5 
 security/selinux/hooks.c                                                  |  150 
 security/selinux/include/objsec.h                                         |   10 
 sound/core/pcm_native.c                                                   |   35 
 sound/core/pcm_timer.c                                                    |    7 
 sound/core/rawmidi.c                                                      |    4 
 sound/core/seq/oss/seq_oss_rw.c                                           |    3 
 sound/core/ump.c                                                          |   94 
 sound/hda/ext/hdac_ext_controller.c                                       |    6 
 sound/hda/hdac_bus.c                                                      |    8 
 sound/hda/hdac_component.c                                                |    6 
 sound/hda/hdac_device.c                                                   |   28 
 sound/hda/hdac_regmap.c                                                   |   35 
 sound/isa/es18xx.c                                                        |    4 
 sound/pci/ctxfi/cthw20k2.c                                                |    1 
 sound/pci/hda/hda_codec.c                                                 |  119 
 sound/pci/hda/hda_controller.c                                            |   26 
 sound/pci/hda/hda_proc.c                                                  |    4 
 sound/pci/hda/hda_sysfs.c                                                 |   77 
 sound/pci/hda/patch_conexant.c                                            |   12 
 sound/pci/hda/patch_realtek.c                                             |   44 
 sound/soc/amd/renoir/acp3x-pdm-dma.c                                      |    2 
 sound/soc/amd/yc/acp6x-mach.c                                             |   21 
 sound/soc/amd/yc/acp6x-pdm-dma.c                                          |    2 
 sound/soc/bcm/bcm63xx-i2s-whistler.c                                      |    1 
 sound/soc/codecs/ab8500-codec.c                                           |  537 +--
 sound/soc/codecs/hdmi-codec.c                                             |    6 
 sound/soc/codecs/mt6351.c                                                 |    1 
 sound/soc/codecs/pcm3168a.c                                               |   20 
 sound/soc/codecs/rk3328_codec.c                                           |   54 
 sound/soc/codecs/rt5645.c                                                 |    4 
 sound/soc/codecs/rt712-sdca-dmic.c                                        |   14 
 sound/soc/intel/atom/sst/sst_pci.c                                        |    1 
 sound/soc/intel/avs/core.c                                                |   11 
 sound/soc/intel/catpt/ipc.c                                               |    8 
 sound/soc/intel/catpt/loader.c                                            |    3 
 sound/soc/intel/catpt/registers.h                                         |   12 
 sound/soc/meson/aiu-acodec-ctrl.c                                         |    3 
 sound/soc/meson/aiu-codec-ctrl.c                                          |    3 
 sound/soc/qcom/qdsp6/q6apm.c                                              |   10 
 sound/soc/rockchip/rockchip_pdm.c                                         |   16 
 sound/soc/rockchip/rockchip_spdif.c                                       |    1 
 sound/soc/soc-topology.c                                                  |   37 
 sound/soc/sprd/sprd-pcm-compress.c                                        |   15 
 sound/soc/sti/uniperif_reader.c                                           |    4 
 sound/soc/ti/omap3pandora.c                                               |    5 
 sound/soc/ux500/ux500_msp_dai.c                                           |  132 
 sound/soc/ux500/ux500_msp_dai.h                                           |   11 
 sound/soc/ux500/ux500_msp_i2s.c                                           |  264 +
 sound/soc/ux500/ux500_msp_i2s.h                                           |   16 
 sound/usb/6fire/chip.c                                                    |   40 
 sound/usb/6fire/comm.c                                                    |   42 
 sound/usb/6fire/comm.h                                                    |    2 
 sound/usb/6fire/midi.c                                                    |   64 
 sound/usb/6fire/midi.h                                                    |    2 
 sound/usb/6fire/pcm.c                                                     |  221 -
 sound/usb/6fire/pcm.h                                                     |    5 
 sound/usb/bcd2000/bcd2000.c                                               |   33 
 sound/usb/caiaq/audio.c                                                   |   10 
 sound/usb/caiaq/device.c                                                  |   53 
 sound/usb/caiaq/device.h                                                  |    4 
 sound/usb/caiaq/input.c                                                   |    6 
 sound/usb/caiaq/midi.c                                                    |    6 
 sound/usb/mixer.c                                                         |   17 
 sound/usb/mixer_maps.c                                                    |   25 
 sound/usb/quirks-table.h                                                  |   22 
 sound/usb/quirks.c                                                        |    4 
 sound/usb/usx2y/us122l.c                                                  |    9 
 sound/usb/usx2y/usbusx2y.c                                                |   45 
 sound/usb/usx2y/usbusx2y.h                                                |    4 
 sound/virtio/virtio_card.c                                                |    4 
 tools/build/feature/test-bpf.c                                            |    2 
 tools/include/nolibc/crt.h                                                |    2 
 tools/lib/bpf/bpf.c                                                       |    2 
 tools/lib/bpf/gen_loader.c                                                |    2 
 tools/lib/bpf/libbpf.c                                                    |    7 
 tools/lib/bpf/relo_core.c                                                 |   58 
 tools/perf/tests/shell/stat_bpf_counters.sh                               |   30 
 tools/perf/util/evsel.c                                                   |    4 
 tools/testing/selftests/alsa/mixer-test.c                                 |    4 
 tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c                 |    2 
 tools/testing/selftests/bpf/config                                        |    1 
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c                           |    7 
 tools/testing/selftests/bpf/progs/test_bpf_nf.c                           |  112 
 tools/testing/selftests/cgroup/cgroup_util.c                              |   82 
 tools/testing/selftests/cgroup/cgroup_util.h                              |    8 
 tools/testing/selftests/cgroup/test_kmem.c                                |    2 
 tools/testing/selftests/cgroup/test_memcontrol.c                          |   78 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc    |    2 
 tools/testing/selftests/landlock/fs_test.c                                | 1746 +++++++++-
 tools/testing/selftests/mm/cow.c                                          |  338 -
 tools/testing/selftests/nci/nci_dev.c                                     |   45 
 tools/testing/selftests/net/fib_nexthops.sh                               |   28 
 tools/testing/selftests/net/mptcp/mptcp_connect.c                         |    4 
 tools/testing/selftests/net/pmtu.sh                                       |    2 
 tools/testing/selftests/net/test_vxlan_mdb.sh                             |    6 
 tools/testing/selftests/powerpc/tm/tm.h                                   |    8 
 tools/thermal/tmon/tui.c                                                  |    2 
 1066 files changed, 14489 insertions(+), 7407 deletions(-)

Aamir Ahmed (4):
      net: hinic: fix mailbox segment buffer overflow
      Bluetooth: eir: validate service data length before reading UUID
      net: usb: catc: bound the RX packet length in catc_rx_done()
      nfc: llcp: drop truncated I/RR/RNR PDUs in nfc_llcp_recv_hdlc()

Abdifatah Suruur (1):
      ksmbd: fix use-after-free in oplock break notification

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

Ai Chao (1):
      ALSA: usb-audio: Add quirk flags for SC13A

Akashdeep Kaur (1):
      mfd: tps65219: Make poweroff handler conditional on system-power-controller

Al Viro (1):
      configfs_depend_prep(): pass configfs_dirent instead of dentry

Alan Borzeszkowski (2):
      thunderbolt: Don't create multiple DMA tunnels on firmware connection manager
      thunderbolt: Improve multi-display DisplayPort tunnel allocation

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

Aleksandr Nogikh (1):
      Bluetooth: hci_core: Fix race condition during device registration

Aleksei Sviridkin (1):
      net: dsa: mt7530: fix NULL dereference on unbind of MT7531 and MT7621

Alessandro Baldi (1):
      media: imon: Add iMON VFD HID OEM v1.2 key mappings

Alessandro Schino (1):
      ntfs3: fix out-of-bounds read in ntfs_dir_emit() and hdr_find_e()

Alex Bereza (2):
      dmaengine: xilinx_dma: Fix hardware buffer descriptor reuse order
      dmaengine: xilinx_dma: Fix hardware buffer descriptor chain after cyclic DMA

Alex Hung (3):
      drm/amd/display: Ensure array index tg_inst won't be -1
      drm/amd/display: Check null pointers before using them
      drm/amd/display: Validate function returns

Alexander Chesnokov (1):
      dmaengine: ti: k3-udma-glue: fix NULL dereference in k3_udma_glue_release_rx_chn()

Alexander Gordeev (1):
      s390/os_info: Introduce value entries

Alexandra Winter (1):
      s390/ism: folio_put() after error

Alexandre Courbot (1):
      scripts: modpost: detect and report truncated buf_printf() output

Alexei Turtanov (1):
      Input: atkbd - skip deactivate for Xiaomi Redmi Book Pro 16 2026

Alexey Klimov (1):
      clk: samsung: exynos850: mark APM I3C clocks as critical

Ali Ahmet Memis (4):
      ufs: do not treat unreadable directory blocks as empty
      ufs: create the root dentry after loading cylinder metadata
      ufs: validate cylinder group metadata before caching it
      wifi: wilc1000: fix out-of-bounds read in P2P public action frames

Alice Mikityanska (3):
      net/sched: act_csum: don't mangle UDP tunnel GSO packets
      net: ipv6: Fix UDP length overflow with PMTU discover and big MTU
      net: ipv6: Clamp to IP6_MAX_MTU in ip6_dst_mtu_maybe_forward

Allen Pais (1):
      workqueue: Introduce from_work() helper for cleaner callback declarations

Allen Pan (1):
      drm/amd/display: Add a dc_state NULL check in dc_state_release

Allison Henderson (6):
      net/rds: Don't sleep inside rds_ib_conn_path_shutdown
      net/rds: use wq_has_sleeper() in release_in_xmit()
      net/rds: use clear_bit_unlock() in release_refill()
      net/rds: clear cp_flags bits individually in rds_conn_path_reset()
      net/rds: acquire RDS_IN_XMIT in rds_tcp_reset_callbacks()
      net/rds: don't let rds_conn_shutdown() consume a concurrent drop

Alvin Šipraga (1):
      Input: adp5588-keys - cache GPIO state before registering the gpiochip

Alysa Liu (1):
      drm/amdkfd: fix UAF race in destroy_queue_cpsch

Amit Cohen (1):
      net: Do not return value from init_dummy_netdev()

Amit Machhiwal (2):
      KVM: PPC: Book3S HV: fix use-after-free in kvmhv_emulate_tlbie_all_lpid()
      KVM: PPC: Book3S HV: fix secure device page leak on uv_page_in() failure

Andrea Mayer (1):
      seg6: set IPSKB_L3SLAVE from IP6SKB_L3SLAVE on IPIP decapsulation

Andrea Righi (1):
      sched/fair: Reject misfit pulls onto busy SMT siblings on asym-capacity

Andreas Gruenbacher (1):
      gfs2: page poisoning fix

Andrei Faleichyk (1):
      ALSA: hda/realtek: Add quirk for ASUS VivoBook X509DAP

Andrew Stellman (1):
      virtio-pci: return IRQ_HANDLED after non-zero ISR

Andy Shevchenko (1):
      smb: client: transport: Fix debug printing in __release_mid()

Angel J (1):
      PCI: of_property: Omit bus properties without a subordinate bus

AngeloGioacchino Del Regno (2):
      phy: mediatek: phy-mtk-hdmi-mt8195: Fix PLL calc divisor overflow
      phy: mediatek: phy-mtk-hdmi-mt8195: Fix TMDS clk bit ratio setting

Aohan Mei (3):
      smb: client: reject userspace cifs.idmap descriptions
      rds: ib: use rds_conn_drop() on protocol version mismatch
      sctp: discard the rest of the packet on a stale-cookie error

Arash Golgol (2):
      media: video-i2c: use vb2_video_unregister_device on driver removal
      media: video-i2c: fix buffer queue ordering

Arnd Bergmann (2):
      scsi: bfa: Reduce kernel stack usage in bfa_fcs_lport_fdmi_build_portattr_block()
      eth: mlx5: fix macsec dependency

Asad Kamal (1):
      drm/amd/pm: bound pp_dpm_set_pp_table() memcpy

Aurelien DESBRIERES (1):
      RDMA/rtrs-srv: Fix integer underflow in process_read and process_write

Avi Weiss (1):
      btrfs: send: fix lost error return value in will_overwrite_ref()

Baineng Shou (1):
      dmaengine: mmp_pdma: fix wrong sg length in mmp_pdma_prep_slave_sg()

Baochen Qiang (2):
      wifi: ath12k: fix kernel crash during resume
      wifi: ath12k: check M3 buffer size as well whey trying to reuse it

Bard Liao (2):
      soundwire: only handle alert events when the peripheral is attached
      soundwire: cadence_master: wait and cancel cdns->work before clock stop

Bart Van Assche (1):
      scsi: megaraid_sas: Protect megasas_get_ctrl_info() in megasas_resume()

Baul Lee (1):
      vxlan: mdb: Fix use-after-free in vxlan_mdb_remote_src_del()

Ben Reed (1):
      PCI: switchtec: Add Gen6 Device IDs

Benoît Sevens (1):
      HID: logitech-hidpp: fix race condition when accessing stale stack pointer

Bernardo Soares (2):
      net/mlx5: Bridge, don't fail switchdev events of sibling eswitch ports
      net/mlx5: Bridge, don't fail unlink of untracked/unsupported peer ports

Bitterblue Smith (2):
      wifi: rtw88: TX QOS Null data the same way as Null data
      wifi: rtw88: Fix the random "error beacon valid" messages for USB

Bjoern Doebel (3):
      smb: client: avoid leaking refcount in cifs_queue_oplock_break()
      smb: client: avoid leaking refcount when cifs_sb_tlink() fails
      smb: client: fix heap overflow in DACL owner/group rewrite

Bjorn Helgaas (1):
      PCI: Wait for device readiness after D3hot -> D0uninitialized transition

Boris Brezillon (1):
      drm/gem: Consider GEM object reclaimable if shrinking fails

Brad Cowie (1):
      selftests/bpf: Update tests for new ct zone opts for nf_conntrack kfuncs

Bradley Morgan (1):
      arm64: hibernate: pass HVC_SET_VECTORS args to the resume hvc

Breno Leitao (5):
      net: core: Fix documentation
      net: create a dummy net_device allocator
      net: mediatek: mtk_eth_sock: allocate dummy net_device dynamically
      usb: xhci: bail out of setup if the controller is inaccessible
      net: mediatek: Fix potential NULL pointer dereference in dummy net_device handling

Bryam Vargas (1):
      crypto: virtio - bound the akcipher result length

Carolina Jubran (3):
      net/mlx5e: Fix ETS zero BW reporting when one TC holds 100%
      net/mlx5e: Fix use-after-free race in sample_restore_put()
      IB/IPoIB: Avoid restoring OPER_UP after multicast flush

Cen Zhang (Microsoft) (1):
      tipc: fix integer overflow in tipc_recvmsg() and tipc_recvstream()

Cezary Rojewski (3):
      ASoC: Intel: catpt: Complete coredump handling
      ASoC: codecs: pcm3168a: Drop CONFIG_PM-conditional preproc directive
      ASoC: Intel: avs: Clean up the bus when fetching ML caps fails

Chaithanya Lagisetty (1):
      selftests: nci: Fix uninitialized family ID on missing attribute

Changbin Du (1):
      perf/x86/intel/ds: Remove redundant assignments to sample.period

Charles Keepax (1):
      soundwire: dmi-quirks: Disable ghost Realtek devices

Chen Bowen (1):
      ALSA: hda/realtek: Fix speakers on MECHREVO WUJIE Series

Chen Changcheng (1):
      HID: alps: fix use-after-free on input2 registration failure

Chen Cheng (1):
      md/raid5: let stripe batch bm_seq comparison wrap-safe

Chen Pei (1):
      ACPI: PCI: Clear _DEP dependencies after PCI root bridge attach

Chen-Yu Tsai (1):
      dma-coherent: Warn if OF reserved memory is beyond current coherent DMA mask

Chengfeng Ye (3):
      netfilter: nf_log: unregister loggers before per-net teardown
      Bluetooth: hci_sync: Serialize local codec list cleanup
      xfrm: serialize state GC with device state flush

Chenguang Zhao (2):
      RDMA/mlx5: Use QP port when decoding responder CQEs
      netlabel: fix IPv6 unlabeled address add error handling

Chris Gellermann (2):
      selftests/nci: Fix out-of-bounds store on thread join
      nfc: virtual_ncidev: Add missing ioctl compat handler

Chris Lu (1):
      Bluetooth: btmtk: fix wrong status for short WMT FUNC_CTRL events

Chris Sommers (1):
      Input: i8042 - add quirk for Acer Aspire Go 15 AG15-42P

Christian Göttsche (1):
      selinux: always fill AVC decision in avc_has_perm_noaudit()

Christian König (1):
      drm/i915: fix incorrect RCU teardown order

Christian Lugnberg (2):
      dmaengine: sun6i: fix non-atomic read of DMA position registers
      dmaengine: sun6i: fix undefined behaviour in sun6i_dma_tx_status

Christian Marangi (1):
      usb: host: add ARCH_AIROHA in XHCI MTK dependency

Christiano Amora (1):
      Bluetooth: SMP: reject Security Request over BR/EDR

Christoph Hellwig (10):
      befs: handle set_blocksize failures
      ntfs3: handle set_blocksize failures
      affs: handle set_blocksize failures
      bfs: handle set_blocksize failures
      minix: handle set_blocksize failures
      qnx4: handle set_blocksize failures
      jfs: handle set_blocksize failures
      hpfs: handle set_blocksize failures
      omfs: handle set_blocksize failures
      isofs: handle set_blocksize failures

Christophe JAILLET (1):
      tracing/histograms: Simplify last_cmd_set()

Chuck Lever (2):
      xprtrdma: Add request-pool slack for delayed recycling
      tls: Flush backlog before waiting for a new record

Chunguang Xu (1):
      nvme-fabrics: use reserved tag for reg read/write command

Claudiu Beznea (1):
      pinctrl: renesas: rzv2m: Use -ENOTSUPP instead of -EOPNOTSUPP

Coia Prant (1):
      net: ethernet: stmmac: dwmac-rk: fix bulk clock leak when the PHY clock fails

Colin Ian King (1):
      OPP: of: Fix potential multiplication overflow when calculating freq

Cong Nguyen (3):
      hwmon: (gpio-fan) take fan_data->lock in gpio_fan_shutdown()
      hwmon: (applesmc) fix key backlight workqueue leak on register failure
      nfc: llcp: fix sdreq TLV list leak on parse/alloc/send failure

Corentin Labbe (1):
      wifi: ralink: RT2X00: init EEPROM properly

Cris (1):
      Bluetooth: btusb: Add support for TP-Link TL-UB250

Cyrill Gorcunov (1):
      RDMA/irdma: Fix typo in SQ completions generation

Cássio Gabriel (5):
      ALSA: usb-audio: Propagate write errors in generic mixer put callbacks
      ALSA: usx2y: Drain pending US-428 pipe-4 output commands
      ASoC: codecs: rk3328: Use managed GPIO and clock helpers
      ALSA: seq: oss: Reject reads that cannot fit the next event
      ASoC: topology: Check PCM and DAI name strings before use

Dai Ngo (1):
      NFS: fix eof updates after NFSv4.2 fallocate/zero-range

Dairui Zhang (1):
      af_packet: fix integer overflow in prb_calc_retire_blk_tmo()

Dan Carpenter (4):
      drm/virtio: Fix a NULL vs ERR_PTR() bug in virtio_gpu_user_framebuffer_create()
      btrfs: directly return 0 on no error code in btrfs_insert_raid_extent()
      drm/nouveau/clk: fix list cursor use after loop in nvkm_clk_ustate_update
      drm/mediatek: Fix potential NULL dereference in mtk_crtc_destroy()

Daniel Borkmann (2):
      libbpf: Also reset {insn,data}_cur on realloc failure
      bpf: Fix bpf_skb_change_tail wrt csum partial skbs

Daniel C. Ribeiro (1):
      ALSA: usb-audio: Add FIXED_RATE quirk for JBL Quantum650 Wireless

Daniel Lezcano (1):
      thermal/drivers/tegra/soctherma: Switch to devm cooling device registration

Danielle Ratson (1):
      bridge: Do not suppress ARP probes and DAD NS unconditionally

Dapeng Mi (2):
      perf/x86/intel/ds: Factor out PEBS group processing code to functions
      perf/x86/intel: Correct pt_regs->flags update for PEBS path

Dario Binacchi (1):
      drm/panel: simple: Add AM-1280800W8TZQW-T00H

Darrick J. Wong (6):
      xfs: snapshot scrub stats when rendering them
      xfs: snapshot old AGFL before rewriting it
      xfs: signal inode btree xref error if get_rec returns an error
      xfs: count escaped corruption errors in scrub stats
      xfs: bail out on bitmap errors in xrep_agfl_fill
      xfs: fix blockgc group quota scanning when usrquota isn't enforced

Dave Carey (1):
      USB: cdc-acm: start bulk-IN polling when ALWAYS_POLL_CTRL is set

Dave Chen (1):
      btrfs: only account delalloc bytes for regular file inodes in btrfs_getattr()

David Arcari (1):
      watchdog: fix hrtimer start when pretimeout is zero

David Carlier (1):
      ieee802154: hwsim: serialize pib updates to fix double-free

David Dai (1):
      bonding: crypto offload enabled, non-offload slave failover, rekey failed

David Francis (2):
      drm/amdkfd: Check bounds for allocate_sdma_queue restore_sdma_id
      drm/amdkfd: Check bounds on allocate_doorbell

David Howells (1):
      cachefiles: Fix double fput

David Yang (1):
      net: dsa: sja1105: flower: reject cross-chip redirect

Dawei Feng (1):
      bpf: NUL-terminate replaced sysctl value

Deepanshu Kartikey (2):
      wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()
      nfc: pn533: fix OOB read in pn533_acr122_is_rx_frame_valid()

Denis Arefev (1):
      ALSA: hda: Fix missing pointer check in hda_component_manager_init function

Dian-Syuan Yang (1):
      wifi: rtw89: pci: enable LTR based on pcie control register

Diogo Ivo (Schneider Electric) (1):
      mmc: sdhci_am654: Reset command and data lines on failed tuning

Dmitriy Chumachenko (1):
      drm/amdgpu: check ras and obj before dereference

Dmitriy Okunev (1):
      net: mvpp2: prevent buffer overflow in page_pool allocation

Dmitry Baryshkov (2):
      drm/panel: jadard-jd9365da-h3: set prepare_prev_first
      drm/msm/dsi: round the byte clock rate after reparenting to the PHY PLL

Dmitry Torokhov (2):
      Input: rmi_smbus - fix out-of-bounds read in rmi_smb_write_block()
      Input: synaptics-rmi4 - fix GPF in suspend and resume when unbound

Dominik Kaszewski (1):
      drm/amd/display: Fix DPMS using partially updated pipe context

Dong Chenchen (1):
      ipv4: icmp: reject RTN_UNREACHABLE input routes in icmp_route_lookup

Donggeun Yoo (7):
      tracing: Fix memory corruption from the histogram stacktrace modifier
      tracing: Free histogram the var ref when its initialization fails
      tracing: Free histogram var refs regardless of how often they are referenced
      tracing: Free histogram the field rejected for a bad modifier
      tracing: Let histogram values keep the percent and graph modifiers
      tracing: Keep the entry count when the histogram stats allocation fails
      dma-coherent: report a failed reserved memory assignment

Dongliang Qin (1):
      rds: ib: Clear the sg list when mapping an MR fails

Doruk Tan Ozturk (2):
      wifi: mwifiex: bound the pairwise-cipher OUI walk to the IE length
      nfc: port100: reject frames whose declared length exceeds the received data

Doug Berger (2):
      net: bcmgenet: move bcmgenet_power_up into resume_noirq
      net: bcmgenet: allow return of power up status

Dragan Simic (1):
      driver core: Add device probe log helper dev_warn_probe()

Eduard Zingerman (1):
      bpf: reject BPF_PSEUDO_FUNC reference to the main program

Edward Adam Davis (1):
      ALSA: caiaq: Decoupling ep1_in_urb in caiaq dev

Eelco Chaudron (1):
      openvswitch: fix wrong flag value in get_ipv6_ext_hdrs()

Emil Tsalapatis (2):
      bpf: Fix bounds check for skb-backed dynptrs
      bpf: Fix bpf_sock context code generation

Emmanuel Grumbach (8):
      wifi: iwlwifi: mvm: validate sta_id in BA window status notif
      wifi: iwlwifi: mvm: fix an off-by-1 boundary check
      wifi: iwlwifi: mvm: fix sched scan IE sizing
      wifi: iwlwifi: mvm: fix a possible underflow
      wifi: iwlwifi: mvm: add a check on the tid coming from the firmware
      wifi: iwlwifi: mvm: fix out-of-bounds tid_data access in BA notif
      wifi: iwlwifi: bound aligned TLV advance in FW parser
      wifi: iwlwifi: acpi: validate WGDS table revision index

Eric Biggers (5):
      crypto: x86/aria - add missing vzeroupper in AVX2 code
      crypto: x86/aria - add missing vzeroupper in AVX-512 code
      crypto: sun8i-ss - Remove crypto_rng interface
      crypto: sun8i-ce - Remove crypto_rng interface
      netfilter: nft_set_pipapo_avx2: add missing vzeroupper

Eric Dumazet (31):
      net: bridge: remove stale rcu_barrier() in br_multicast_dev_del()
      net/sched: sch_drr: make cl->quantum lockless
      drop_monitor: perform u64_stats updates under IRQ-disabled section
      drop_monitor: fix size calculations for 64-bit attributes
      net: icmp: avoid invalid transport header access in icmp_send tracepoint
      ip6_gre: check tunnel info before xmit in ip6gre_tunnel_xmit
      ipv6: sr: restore network header before routing and forwarding
      bonding: alb: fix uninitialized transport header access in alb_determine_nd()
      locking/lockdep: Invalidate stale class_cache entries for zapped classes
      bonding: do not clear curr_active_slave prematurely when releasing all slaves
      bonding: use skb_cow_head() in bond_do_alb_xmit() and rlb_arp_xmit()
      net_sched: sch_fq_pie: implement lockless fq_pie_dump()
      ipv6: lockless IPV6_UNICAST_HOPS implementation
      ipv6: lockless IPV6_MULTICAST_LOOP implementation
      ipv6: lockless IPV6_MULTICAST_HOPS implementation
      ipv6: lockless IPV6_MTU implementation
      xfrm: add missing rcu_read_lock(), skb_dst_force() and dev_hold() for xfrm_trans_reinject()
      net: convert dev->reg_state to u8
      tcp: do not let tcp_rmem be set below 4096
      pppoatm: ensure a writable skb header and linear data
      drop_monitor: synchronize tracepoint unregistration on error path
      drop_monitor: fix out-of-bounds write in reset_per_cpu_data()
      net: lock the socket in sock_gettstamp()
      ipv6: mcast: use copy-on-write RCU updates in ip6_mc_source()
      ipv6: mcast: fix RCU list diversion in ip6_mc_del1_src()
      llc: fix skb UAF and leaks on llc_mac_hdr_init() failure
      bridge: check llc_mac_hdr_init() return value in br_send_bpdu()
      net/sched: sch_teql: fix shadowed err in __teql_resolve()
      vlan: ensure sufficient headroom in vlan_dev_hard_header()
      tipc: reject invalid and unexpected GRP_ACK_MSG to prevent bc_ackers underflow
      vlan: fix skb_under_panic and races when toggling HW VLAN offload

Erich Sartison (1):
      Input: xpad - add support for Victrix Pro BFG Controller

Ethan Nelson-Moore (1):
      ASoC: ti: omap3pandora: update board check to use DT compatible

Eva Kurchatova (1):
      selftests: cgroup: give the O_TMPFILE open in get_temp_fd() a mode

Evgenii Burenchev (1):
      vdpa/ifcvf: handle dev_set_name() failure in ifcvf_vdpa_dev_add()

Fan Wu (4):
      hwmon: (gpio-fan) Fix use-after-free in alarm work
      mmc: core: Cancel SDIO IRQ work before freeing host
      mmc: hsq: Fix use-after-free in retry work
      mmc: mxcmmc: cancel data work and watchdog on remove

Farhad Alemi (1):
      freevxfs: don't BUG() on unknown typed-extent type

Fedor Pchelkin (1):
      apparmor: free the allocated pdb objects

Felix Gu (1):
      mmc: sdio_uart: fix xmit_fifo leak when the port table is full

Fernando Fernandez Mancera (1):
      ipv6: addrconf: fix temp address generation after prefix deprecation

Filipe Manana (6):
      btrfs: fix use-after-free on reloc root after error in insert_dirty_subvol()
      btrfs: fix reloc root cleanup in merge_reloc_roots()
      btrfs: tree-checker: print dev extent offset in error message
      btrfs: simplify error check condition at btrfs_dirty_inode()
      btrfs: remove redundant root argument from btrfs_update_inode()
      btrfs: abort transaction on failure to update inode for hole punching and reflinking

Florian Eckert (2):
      PCI: intel-gw: Enable clock before PHY init
      tools/thermal/tmon: Fix compilation warning for wrong format

Florian Fainelli (5):
      net: bcmgenet: fix 64-bit RTNL stats reading in ethtool on 32-bit systems
      net: bcmgenet: initialize u64 stats seq counter for all queues
      net: bcmgenet: do not skip WoL power up on GENET V1
      net: bcmgenet: validate Ethernet address in bcmgenet_set_mac_addr
      net: bcmgenet: mask DMA_TIMEOUT_MASK when reading DMA_RING0_TIMEOUT

Florian Maillard (1):
      mmc: rtsx_pci_sdmmc: ignore broken write-protect on ThinkPad X260

Florian Westphal (6):
      netfilter: nf_conntrack_expect: zero at allocation time
      netfilter: nfnetlink_log: wait for rcu grace period before freeing pernet state
      netfilter: nfnetlink_log: cope with concurrent instance destruction
      netfilter: ip6_tables: set F_PROTO when proto value is nonzero
      netfilter: nfnetlink_queue: hold nfnl mutex in event notifier
      netfilter: nf_tables: place base_seq in struct net

Fourie Zhang (2):
      net: mpls: clear inner_protocol when the last label is popped
      netfilter: nf_tables: don't queue packet path object notifications

Francesco Magazzu (1):
      drm/nouveau/clk: don't clobber reclock status when restoring volt/fan

Frank Sorenson (6):
      smb: client: reject short Next offsets in parse_server_interfaces()
      smb: client: fix next_buffer UAF and NextCommand bounds in compound PDUs
      smb: client: fix potential OOB read in smb3_enum_snapshots()
      smb: client: fix server->total_read for compound encrypted PDUs
      smb: client: fix missing lower-bound check on DFS referral string offsets
      smb: client: fix missing iov bounds check in parse_posix_sids()

Fredric Cover (1):
      smb: client: fix races in cifsd thread creation

Fuad Tabba (1):
      KVM: arm64: vgic-its: Skip unreachable devices instead of failing the save

Furst Blumier (1):
      ALSA: hda/realtek: Add quirk for HP 255 15.6 inch G9 Notebook PC

Gajdos Tamás (3):
      net: atl1: fix soft lockup on out-of-range cmb_tpd_next_to_clean read
      net: atl1c: fix soft lockup on out-of-range tpd_cons read
      net: atl1e: fix soft lockup on out-of-range hw_next_to_clean read

Galen Hassen (1):
      ALSA: hda/conexant: Add pin config quirk for Lenovo IdeaPad Slim 5 16AKP10

Gang Yan (2):
      selftests: mptcp: fix an UAF in mptcp_connect.c
      RDMA/rxe: Fix integer overflow in mr_check_range() leading to OOB access

Gaosheng Cui (1):
      apparmor: Fix memory leak in unpack_profile()

Gary Guo (6):
      usb: xusbatm: don't rely on id table pointer arithmetic
      wifi: ath9k_htc: don't store usb_device_id
      usb: usbtmc: don't store usb_device_id
      usb: serial: spcp8x5: don't store usb_device_id
      media: as102: do not rely on id table address comparison
      net: usb: pegasus: don't rely on id table pointer arithmetic

Geert Uytterhoeven (1):
      clk: renesas: cpg-mssr: Add number of clock cells check

Geliang Tang (1):
      bpf, sockmap: Fix self-redirect copied_seq double-counting

Genevieve Chan (1):
      firmware: stratix10-svc: fix FCS SMC call kernel-doc

George Moussalem (1):
      net: dsa: qca8k: Add support for force mode for fixed link topology

Georgi Valkov (1):
      wifi: mwifiex: replace one-element arrays with flexible array members

Gerd Rausch (1):
      net/rds: tcp: don't force RDS_CONN_RESETTING over a concurrent shutdown

Gil Fine (2):
      thunderbolt: Increase timeout for Configuration Ready bit
      thunderbolt: Verify Router Ready bit is set after router enumeration

Gil Portnoy (1):
      ksmbd: remove stale channels from all sessions on teardown

Ginger Li (1):
      tipc: Fix a data race on mon->peer_cnt in mon_timeout()

Gleb Sonichev (1):
      platform/x86: dell-laptop: add Inspiron N5110 to touchpad LED quirk table

Goldwyn Rodrigues (1):
      ima: return error early if file xattr cannot be changed

Gongwei Li (1):
      Bluetooth: hci_mrvl: Fix wrong return value check of wait_on_bit_timeout()

Greg Kroah-Hartman (1):
      Linux 6.6.158

Greg Marsden (1):
      net/rds: fix tcp stream corruption with large pages

Guanghui Yang (2):
      btrfs: detach failed sprout device from transaction update list
      btrfs: restore active device pointers after failed sprout

Guanglei Zhu (3):
      net: wwan: t7xx: validate the netif index in t7xx_ccmni_recv_skb()
      net: wwan: mhi_wwan_mbim: guard against a cyclic NDP chain
      net: wwan: mhi_wwan_mbim: check skb_copy_bits() return value

Guangshuo Li (8):
      net: cpsw_new: unregister devlink on port registration failure
      i2c: imx: disable autosuspend on remove
      hwmon: (w83791d) remove fan/pwm 4-5 sysfs group on remove
      hwmon: (w83793) release probe data through kref
      drm/msm/adreno: fix autosuspend cleanup during teardown
      drm/msm/hdmi_phy: fix runtime PM cleanup on probe failure
      drm/nouveau: fix autosuspend cleanup during teardown
      drm/amdgpu/atom: Check kcalloc() for WS buffer in amdgpu_atom_execute_table_locked()

Guenter Roeck (1):
      hwmon: (corsair-psu) Fix linear11 calculation

Guoqing Jiang (3):
      RDMA/siw: Introduce siw_cep_set_free_and_put
      RDMA/siw: Cleanup siw_accept
      RDMA/siw: Clear association under lock if siw_qp_modify fails in siw_accept

Gustavo Kenji Mendonça Kaneko (2):
      drm/arm/malidp: use clk_bulk API in runtime PM resume and suspend
      drm/arm/komeda: fix error handling for clk_prepare_enable() and callers

Günther Noack (1):
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

Haoxiang Li (4):
      media: em28xx-video: fix missing res_free() on init_usb_xfer failure
      net: thunderx: fix PTP device ref leak in nicvf_probe()
      net: microchip: sparx5: clean up PSFP resources on flower setup failure
      fbdev: pm2fb: unwind WC setup on probe failure

Harald Freudenberger (1):
      s390/crypto: Fix missing scrub of temp buffers with AES ctr and gcm algorithm

Hardik Garg (1):
      Drivers: hv: vmbus: add VTL2 redirect connection ID

Harry Wentland (1):
      dm/amdgpu: fix malformed link_settings debugfs output

Heiko Carstens (3):
      s390/zcore: Removed unused variables
      s390/checksum: call instrument_read() instead of kasan_check_read()
      s390/checksum: provide and use cksm() inline assembly

Helge Deller (1):
      apparmor: Fix 8-byte alignment for initial dfa blob streams

Henry Martin (3):
      sctp: fix soft lockup from unpadded ASCONF-ACK parameter iteration
      tracing/probes: Fix use-after-free on field name/type of events with multiple probes
      tracing/user_events: Don't destroy fields when event removal fails

Hirokazu Honda (1):
      tee: optee: Allow MT_NORMAL_TAGGED shared memory

Hohyun Sim (1):
      net: fddi: skfp: fix NULL deref when setting the MAC address while down

Hongfu Li (1):
      selftests/cgroup: Fix cg_run_in_subcgroups ignoring arg parameter

Hrvoje Nuic (1):
      Bluetooth: btusb: Add Mercusys MA530 for Realtek RTL8761BUV

Hui Peng (6):
      Bluetooth: bnep: fix out-of-bounds reads on short RX/TX frames and control fallthrough
      Bluetooth: RFCOMM: Reject short EA=0 frames in rfcomm_recv_frame()
      autofs: fix sbi->pipe file reference leak in autofs_kill_sb()
      fou: reject omitted FOU_ATTR_IPPROTO on FOU_ENCAP_DIRECT
      ipv6: sr: enforce exact attribute length for SEG6_ATTR_DST
      Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO

Hui Su (1):
      staging: fbtft: make dirty_lock IRQ-safe

Huiwen He (3):
      smb/client: reduce fallocate zero buffer allocation
      smb/client: flush dirty data before punching a hole
      smb/client: mark file sparse before emulating insert range

HyeongJun An (4):
      ASoC: meson: aiu: Validate written enum values
      selftests/alsa: Fix the step check for INTEGER controls
      ALSA: hda: Report a change when only the channel status bytes move
      ASoC: hdmi-codec: Report a change when the channel status moves

Hyunwoo Kim (1):
      exec: Cleanup POSIX timers right after de_thread()

Håkon Bugge (1):
      net/rds: acquire the fastpath locks in rds_conn_shutdown()

Ian Rogers (1):
      perf evsel: Add per-thread warning for EOPNOTSUPP open failues

Ibrahim Hashimov (2):
      wifi: mac80211_hwsim: reject undersized HWSIM_ATTR_TX_INFO
      mac802154: fix use-after-free of sdata via queued RX frames

Ido Schimmel (6):
      bridge: Add missing READ_ONCE() annotations around FDB destination port
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

Ivan Delalande (1):
      tg3: use random MAC address when tg3_get_device_address fails

Ivy Lopez (1):
      scsi: mpt3sas: Avoid out-of-bounds cpumask_of_node() call in _base_assign_reply_queues()

Iván Ezequiel Rodriguez (2):
      Input: evdev - zero absinfo before partial copy in EVIOCSABS
      Input: zero ff_effect before compat copy in input_ff_effect_from_user

Jacob Keller (1):
      ice: add missing xa_destroy for sched_node_ids

Jacob Moroni (1):
      RDMA/irdma: Enforce local fence for IB_WR_REG_MR

Jad Keskes (1):
      EDAC/device_sysfs: Use kstrtouint() for poll_msec to prevent truncation

Jakub Kicinski (7):
      tls: reject the combination of TLS and sockmap
      net: dsa: bcm_sf2: bound the CFP rule dump by the caller's buffer size
      net: dsa: mv88e6xxx: bound the policy rule dump by the caller's buffer size
      genetlink: report the real command id for dump-only ops in policy dumps
      veth: manage XDP program pointers during channel resize
      net: tls: fix silent data drop under pipe back-pressure
      vlan: defer real device state propagation to netdev_work

Jamal Hadi Salim (11):
      net/sched: cls_u32: fix duplicate handle when node ID pool is exhausted
      net: cap tx_queue_len at S16_MAX to prevent oversized ring allocations
      net/sched: fq_pie: clamp quantum in change path
      net/sched: sfq: clamp quantum in change path
      net/sched: hhf: clamp quantum in change and init paths
      net/sched: pie: clamp psched_mtu in pie_drop_early
      net/sched: drr: clamp quantum in change class
      net/sched: ets: clamp quantum in parse and fallback paths
      net/sched: hhf: cap hh_flows_limit at change time
      net/sched: cls_u32: fix manual hash table handle IDR aliasing
      net/sched: sch_hfsc: bound the classify inner-filter walk with a drift budget

James Clark (2):
      net: macb: fix ordering around PTP timestamp read
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

Jay Vadayath (1):
      smb: client: bound dirent name against end of SMB response in cifs_filldir

Jean-Louis Colaco (1):
      ALSA: usb-audio: Add quirk for YAMAHA CDS3000

Jeff Layton (1):
      ufs: convert to new timestamp accessors

Jeffin Philip (1):
      RDMA/core: fix refcount bug in iwpm_get_nlmsg_request()

Jens Axboe (1):
      sunvdc: fix -EIO issue due to lack of retries

Jeremy Klarenbeek (1):
      drm/amd/pm/si: Fix updating clock limits from power states

Jeremy Nyberg (1):
      Input: xpad - fix PDP Marvel Xbox 360 controller

Jetha Chan (1):
      ASoC: amd: yc: Add Alienware m15 R7 AMD to DMIC quirk table

Jia Jia (3):
      vhost-scsi: flush backend after device ioctls
      virtio_console: do not free control-out buffers on remove
      vhost/vdpa: reject VRING_NUM larger than device max

Jiacheng Xu (1):
      workqueue: reject watchdog thresholds that overflow jiffies

Jiajia Liu (1):
      wifi: mt76: transform aspm_conf for pci_disable_link_state

Jiale Yao (1):
      Bluetooth: RFCOMM: validate skb length in rfcomm_recv_frame

Jiangshan Yi (3):
      ASoC: codecs: rt712-sdca-dmic: fix uninitialized stream_config->type
      wifi: brcmsmac: fix UAF in brcms_free_timer()
      wifi: libertas_tf: fix UAF in lbtf_free_adapter()

Jiayuan Chen (8):
      rds: annotate data-race around rs_seen_congestion
      bpf: Fix NULL-ptr-deref when showing a void BTF type
      bpf: Fix NULL-ptr-deref in btf_var_show()
      selftests/bpf: Fix flaky bpf_nf test when random NAT port is 0
      bpf: Fix divide-by-zero in btf_struct_walk()
      bpf: Fix out-of-bounds read of sk_protocol in bpf_sock_destroy()
      tcp: Skip cond_resched() in inet_csk_listen_stop() under BPF context
      bpf: Fix out-of-bounds read of rtt_min in sock_ops

Jie Gan (1):
      coresight: platform: defer connection counter increment until alloc succeeds

Jinjie Ruan (1):
      spi: zynqmp-gqspi: Use devm_spi_alloc_host()

Jiri Kosina (1):
      HID: hidpp: fix potential UAF in hidpp_connect_event()

Jiri Olsa (1):
      bpf: Guard __get_user acesss with access_ok for uprobe_multi data

Jisheng Zhang (1):
      spi: dw: fix wrong RX_SAMPLE_DLY setting after resume

Joas Antonio dos Santos (1):
      netfilter: nf_conntrack_sip: fix OOB read in sip_skip_whitespace()

Joe Damato (3):
      bnxt_en: Only restore LRO if the device supports TPA
      bnxt_en: Handle buffer allocation failure in bnxt_rx_ring_reset()
      bnxt_en: Propagate RX ring init failures in bnxt_init_nic()

Johan Almbladh (2):
      bpf: Fix immediate JMP JEQ/JNE on MIPS32
      bpf: Fix BSWAP 32 and 16 on MIPS64

Johan Hovold (1):
      net: hso: fix TIOCMIWAIT race

Johannes Berg (18):
      wifi: nl80211: reject beacons with bad HE operation
      wifi: mac80211: always allow transmitting null-data on TXQs
      wifi: cfg80211: check IP header size in cfg80211_classify8021d()
      wifi: cfg80211: only group hidden BSSes with beacon entries
      wifi: cfg80211: don't filter by BSS type when removing stale entries
      wifi: mac80211: don't offload TC setup on AP_VLAN interfaces
      wifi: mac80211: suppress chanctx warning for debugfs reset
      wifi: mac80211: unlist vifs when their netdev is unregistered
      wifi: mac80211_hwsim: don't hand frames to mac80211 while stopping
      wifi: mac80211: reset the AP_VLAN tailroom counter on ifdown
      wifi: mac80211: require a peer station for TDLS setup confirm
      wifi: mac80211: don't allow link changes when iface is down
      wifi: mac80211: don't RCU-dereference the mesh CSA settings we just set
      wifi: mac80211: don't access the TSF of a down interface
      wifi: mac80211: add HE 6 GHz capability in the scan elems len
      wifi: mac80211: mesh: release the channel if start fails
      wifi: mac80211: rework ack_frame_id handling a bit
      wifi: mac80211: set up the TX info early to fix failure paths

Joonwon Kang (1):
      mailbox: Make mbox_send_message() return error code when tx fails

Jose Fernandez (Anthropic) (1):
      bpf: Avoid soft lockup in __htab_map_lookup_and_delete_batch()

Jose Ignacio Tornos Martinez (2):
      net: wwan: t7xx: Add delay between MD and SAP suspend
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

Junrui Luo (4):
      drm/virtio: fix object leak when drm_gem_handle_create() fails
      drm/virtio: fix object leak in virtio_gpu_resource_create_ioctl()
      drm/virtio: fix object leaks in virtio_gpu_resource_create_blob_ioctl()
      drm/virtio: release the GEM object on virtio_gpu_vram_create() errors

Justin Chen (2):
      net: bcmasp: clear txcb->last before writing each descriptor
      net: bcmasp: fix tx_spb_ring_full() checking same slot cnt times

Jérémy Jean (3):
      RDMA/siw: Bound fragmented header copies by the remaining length
      netfilter: flowtable: publish HW_DEAD after worker is done
      net: gue: reject invalid REMCSUM offsets

Kamal Wadhwa (1):
      regulator: core: clamp voltage constraints before applying apply_uV

Kan Liang (1):
      perf/x86/intel/ds: Clarify adaptive PEBS processing

KangNing Liao (1):
      btrfs: protect sb_write_pointer() with invalidate lock

Karl Mehltretter (15):
      tracing: Disable KCOV instrumentation for trace_irqsoff.o
      virtio_input: stop callbacks before unregistering input device
      drm/logicvc: Drop the select of the nonexistent CONFIG_DRM_KMS_DMA_HELPER
      smb: client: pin DFS superblock in iterator callback
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

Kazuki Hanai (1):
      ALSA: us122l: Prevent write upgrades for read mappings

Kees Cook (1):
      arm: Handle KCOV __init vs inline mismatches

Kevin Hao (2):
      net: cpsw_new: Execute ndo_set_rx_mode callback in a work queue
      net: cpsw: Execute ndo_set_rx_mode callback in a work queue

Kiran K (3):
      Bluetooth: btintel: Print firmware SHA1
      Bluetooth: btintel: Export few static functions
      Bluetooth: btintel: Fix compiler warning for multi_v7_defconfig config

Koichiro Den (1):
      arm64: dts: renesas: r8a779f0: Set UFS lane count

Kory Maincent (1):
      hwmon: (adt7462) Add of_match_table to support devicetree

Krystian Kaniewski (1):
      RDMA/core: Reject unregistering netdevs in ib_get_eth_speed

Krzysztof Wilczyński (2):
      PCI/proc: Fix race between pci_proc_init() and pci_bus_add_device()
      PCI/sysfs: Use kstrtobool() to parse the ROM attribute input

Kumar Kartikeya Dwivedi (5):
      bpf: Mark bpf_btf_find_by_name_kind() as sleepable
      bpf: Reject non-scalar bpf_loop iteration counts
      bpf: Restrict CO-RE poisoning to relocatable instructions
      libbpf: Reject truncated ldimm64 CO-RE relocations
      bpf: Defer work in bpf_timer_cancel_and_free

Kumar Meiyappan (2):
      scsi: pm8001: Reject firmware update in fatal error state
      scsi: pm8001: Reject non-fatal dump when controller is crashed

Kuniyuki Iwashima (11):
      ipv4: fib: Don't dump dying fib_info in fib_leaf_notify().
      af_unix: Unlink scc_entry in unix_del_edge().
      af_packet: Don't cast tpacket_hdr.tp_len to int in tpacket_parse_header().
      net/sched: cls_api: Don't replay RTM_GETCHAIN in tc_ctl_chain().
      tcp: Don't call skb_clone_and_charge_r() for close()d listener in tcp_v6_do_rcv().
      ipv6: mcast: Use in6_dev_get() in ipv6_dev_mc_dec().
      ipv6: mcast: Don't hold RTNL for IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.
      ipv6: mcast: Don't hold RTNL for IPV6_DROP_MEMBERSHIP and MCAST_LEAVE_GROUP.
      ipv6: mcast: Don't hold RTNL for MCAST_ socket options.
      ip6_gre: Call ip6erspan_tunnel_unlink_md() in ip6erspan_changelink().
      af_unix: Drop all SCM attributes for SOCKMAP.

Kyle Zeng (4):
      ipvs: fix reversed sequence option serialization
      ipvs: reject invalid states in connection template sync records
      xfrm: fix compat ALLOCSPI request use-after-free
      net/packet: defer vmalloc TX_RING free until skbs finish

Lad Prabhakar (2):
      mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC
      mmc: renesas_sdhi: Add OF entry for RZ/G2E SoC

Lama Kayal (1):
      net/mlx5: E-Switch, prevent mc_list repopulation during vport disable

Laxman Acharya Padhya (4):
      wifi: mt76: mt7921: validate CLC firmware records
      wifi: mt76: mt7921: skip unknown CLC firmware records
      Bluetooth: btintel: validate version TLV value lengths
      Bluetooth: hci_codec: validate vendor codec count length

Lee Jones (2):
      Bluetooth: mgmt: Dequeue pending mesh_send_sync entries on cancel
      nfc: llcp: Fix race condition in accept_queue lifecycle

Lei Zhu (1):
      selftests: nci: Correct pthread_create return value check

Leo Yan (1):
      perf/core: Skip empty AUX records with only format flags

Leon Romanovsky (2):
      RDMA/efa: Keep admin queues alive while IRQ is registered
      RDMA/efa: Keep EQ resources alive while IRQ is registered

Leonardo Bras (1):
      arm64/daifflags: Make local_daif_*() helpers __always_inline

Li Jun (1):
      watchdog: da9063: fix suspend/resume handling of HW_RUNNING watchdog

Li Ming (1):
      cxl/mem: Fix no cxl_nvd during pmem region auto-assembling

Li Qiang (1):
      cifs: validate idmap key payload length

Li RongQing (2):
      RDMA/mlx5: Fix state and counter desync on loopback enable failure
      RDMA/mad: Fix receive buffer leak when PKey enforcement fails

Li Youhong (2):
      net: sun4i-emac: fix missing of_node_put() for phy_node
      drm/bridge: samsung-dsim: fix TE GPIO lifetime for host attach

Liang Hao (1):
      gpio: dwapb: Mask interrupts at hardware initialization

Lijo Lazar (1):
      drm/amd/pm: Check SMUv13.0.6/12 metrics integrity

Lin Xianglin (1):
      ASoC: amd: yc: Add DMI quirk for HyperX OMEN Gaming Laptop 16-ap1xxx

Linfeng Sun (2):
      vdpa_sim_blk: reject out-of-range sector starts
      vdpa_sim_net: check TX pull result before RX copy

Linkai Gong (2):
      i2c: atr: fix dangling adapter pointer on add failure
      Input: cyttsp5 - clamp the HID report size before memcpy

Linus Walleij (18):
      ASoC: ab8500: Reset the audio block before configuring it
      ASoC: ab8500: Repair the DAPM capture graph
      ASoC: ab8500: Correct digital interface format setup
      ASoC: ab8500: Validate and program TDM slots correctly
      ASoC: ux500: Fix MSP stream lifecycle handling
      ASoC: ux500: Propagate MSP setup errors
      ASoC: ux500: Correct MSP frame and bit clock setup
      ASoC: ux500: Validate MSP DAI configuration
      mfd: db8500-prcmu: Fold dbx500 header into db8500
      ASoC: ux500: Request the MSP MMIO resource
      ASoC: ux500: Program the MSP FIFO watermarks
      net: ethernet: cortina: Fix budget accounting
      net: ethernet: cortina: Finish RX updates before NAPI completion
      net: ethernet: cortina: Count dropped frames as NAPI work
      net: ethernet: cortina: No mapping is a dropped rx
      net: ethernet: cortina: Count RX drops once per frame
      net: ethernet: cortina: Count RX descriptors for freeq refill
      net: ethernet: cortina: Ack RX overrun interrupt correctly

Lorenzo Bianconi (3):
      net: stmmac: reconfigure RX packet parser table in stmmac_hw_setup() after reset
      net: stmmac: initialize ptp_lock at probe time
      net: ethernet: mtk_eth_soc: unregister net_devices in case of probe failure

Luiz Augusto von Dentz (2):
      Bluetooth: btusb: Fix UAF of btusb_data by rx_work
      Bluetooth: ISO: Fix parent socket leak in iso_conn_ready()

Luka Gejak (1):
      net: hsr: require valid EOT supervision TLV

Lukas Wunner (5):
      PCI: Stop setting cached power state to 'unknown' on unbind
      crypto: ecc - Unbreak the build on arm with CONFIG_KASAN_STACK=y
      crypto: virtio - Drop sign/verify operations
      crypto: virtio - Drop superfluous [as]kcipher_ctx pointer
      crypto: virtio - Drop superfluous [as]kcipher_req pointer

Luxiao Xu (2):
      netfilter: ip6t_rt: fix zero-address non-strict match out-of-bounds read
      nfc: fix use-after-free in nfc_get_local_general_bytes

Madhavender Singh (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Laptop 14s-dr1xxx

Maher Azzouzi (1):
      esp: downgrade zerocopy managed frags before mutating skb frags

Mallesh Koujalagi (1):
      workqueue: Update documentation as per system_percpu_wq naming

Maoyi Xie (4):
      usb: gadget: aspeed_udc: avoid past-the-end iterator in dequeue
      rds: filter RDS_INFO_* getsockopt by caller's netns
      hsr: broadcast netlink notifications in the device's net namespace
      keys: translate request_key_auth pid for the reading procfs instance

Marc Zyngier (1):
      KVM: arm64: vgic-its: Add stronger type-checking to the ITS entry sizes

Marcel Kłos (1):
      ALSA: hda/realtek: Add quirk for HP EliteBook 830 G8 (8AB8) to enable mute LEDs

Marco Crivellari (1):
      workqueue: replace use of system_wq with system_percpu_wq

Marco Elver (1):
      kcsan: Silence -Wmaybe-uninitialized when calling __kcsan_check_access()

Marco Felsch (1):
      serial: 8250: fix possible ISR soft lockup

Marek Behún (3):
      net: dsa: mv88e6xxx: fix number of g1 interrupts for 6320 family
      net: dsa: mv88e6xxx: define .pot_clear() for 6321
      net: dsa: mv88e6xxx: enable .rmu_disable() for 6320 family

Marek Vasut (1):
      net: ks8851: Fix receiver error in 100BASE-TX mode following software power-down

Mariano Baragiola (1):
      wifi: virt_wifi: free skb when disconnected

Mario Limonciello (1):
      x86/PCI: Disable enhanced atomics on AMD NBIO 7.7 and 7.11

Mark Amirkan (4):
      net: lan743x: fix RX checksum use-after-free
      net/packet: clear RX owner on VNET header error
      net/packet: avoid truncating TPACKET_V3 private size
      mptcp: return sk_wait_data() errors from recvmsg()

Mark Rutland (2):
      arm64: percpu: Fix this_cpu_write() casting
      arm64: percpu: Fix this_cpu_and() mask generation

Markus Elfring (1):
      crypto: virtio - Less function calls in __virtio_crypto_akcipher_do_req() after error detection

Markus Lindner (1):
      ALSA: usb-audio: Add dB map quirk for Razer Barracuda X 2.4

Mathias Nyman (1):
      xhci: Prevent queuing new commands if xhci is inaccessible

Matthew Bystrin (1):
      mfd: rsmu: Add 8a34002 support

Matthew Wilcox (Oracle) (2):
      ufs: Convert ufs_get_page() to use a folio
      ufs: Convert ufs_get_page() to ufs_get_folio()

Matthias Goergens (1):
      ata: libata-scsi: bound the ATA passthru sense descriptor writes

Matthieu Baerts (NGI0) (3):
      mptcp: options: handle MPC data + csum reqd + no csum
      mptcp: subflow: no need to copy thmac during ulp_clone
      mptcp: syncookies: remember the request backup flag

Maurizio Lombardi (2):
      nvme-core: align fabrics_q teardown with admin_q in nvme_free_ctrl
      scsi: target: iscsi: Fix hang for aborted WRITE_PENDING commands

Maxime Chevallier (4):
      net: stmmac: selftests: Support running selftests on DSA conduits
      net: stmmac: selftests: Check the dev->features for S-TAG offload testing
      net: stmmac: selftests: Capture all packets for vlan checks
      net: stmmac: dwmac4: Use the correct bufzise when the len is exactly 8K

Meijing Zhao (1):
      mm: memblock: show all region flags in debugfs

Miao Li (1):
      iio: light: stk3310: Deal with the ps interrupt issue in PM

Miaoqing Pan (1):
      wifi: ath11k: fix invalid data access in ath11k_dp_rx_h_undecap_nwifi

Michael Bommarito (8):
      media: hevc: add bounded tile-count helpers
      media: verisilicon: hantro: bound G2 HEVC tile loop to the buffer capacity
      media: mediatek: vcodec: bound AV1 tile-start copy to the array capacity
      media: verisilicon: rockchip: guard VPU981 AV1 divisor and tile buffer
      media: verisilicon: rockchip: reject AV1 frames exceeding the tile capacity
      media: v4l2-ctrls: validate HEVC tile counts
      media: v4l2-ctrls: validate AV1 tile counts
      RDMA/rxe: insert mcg into mcg_tree only after rxe_mcast_add() succeeds

Michael Walle (1):
      clk: keystone: don't cache clock rate

Michal Swiatkowski (1):
      ice: pass the return value of skb_checksum_help()

Mickaël Salaün (2):
      selftests/landlock: Add disconnected leafs and branch test suites
      selftests/landlock: Add layout1.refer_mount_root

Mieczyslaw Nalewaj (1):
      net: dsa: realtek: rtl8365mb: add support for RTL8367SB

Mika Westerberg (4):
      thunderbolt: Release request if tb_cfg_request() fails in __tb_xdomain_response()
      thunderbolt: Keep XDomain reference during the lifetime of a service
      thunderbolt: Keep the domain reference while processing hotplug
      thunderbolt: Set tb->root_switch to NULL when domain is stopped

Mikhail Zaslonko (2):
      s390/debug: Do not register views for failed static debug areas
      s390/debug: Fix NULL pointer dereference in debug_info_copy()

Milan P. Gandhi (2):
      scsi: mpi3mr: Fix NULL pointer dereference in mpi3mr_sas_port_add()
      scsi: mpi3mr: Fix target device refcount leak in mpi3mr_sas_port_add()

Ming Wang (1):
      net: usb: cdc_mbim: add MeiG Smart SRM821 to ZLP whitelist

Minhong He (1):
      phonet: check register_netdevice_notifier() error in phonet_device_init()

Mohamed Khalfella (1):
      nvme-fc: Do not cancel requests in io target before it is initialized

Moritz Baron (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14IRH8

Mostafa Saleh (2):
      irqchip/gic-v4: Don't advertise VLPIs if no ITS is probed
      remoteproc: qcom_q6v5_adsp: Fix iommu_unmap() usage

Muhammad Bilal (1):
      hwmon: (hp-wmi-sensors) Fix use-after-free in fungible_show()

Myeonghun Pak (4):
      mmc: sdhci-of-aspeed: Remove children before releasing SDC resources
      tg3: clean up PHYLIB resources on probe failure
      pinctrl: single: free the IRQ on domain creation failure
      RISC-V: KVM: Synchronize hrtimer callback during teardown

Nagamani PV (1):
      s390/qeth: allow bridgeport queries despite OS_MISMATCH

Naman Gulati (1):
      netfilter: ctnetlink: fix suspicious RCU usage in expect_iter_name

Namjae Jeon (22):
      ksmbd: fix lease break and ack state handling
      ksmbd: validate SMB2 lease create contexts
      ksmbd: align SMB2 oplock break ack handling
      ksmbd: use connection ClientGUID for lease lookup
      ksmbd: treat unnamed DATA stream as base file
      ksmbd: apply create security descriptor first
      ksmbd: deny renaming directory with open children
      ksmbd: start file id allocation at 1
      ksmbd: break RH leases before delete-on-close
      ksmbd: treat read-control opens as stat opens only for leases
      ksmbd: fix credit charge calculation for SMB2 QUERY_INFO
      ksmbd: find bound sessions during reauthentication
      ksmbd: mark invalid session responses as signed
      ksmbd: validate SID namespace before mapping IDs
      ksmbd: preserve VFS inherited POSIX ACL mask
      ksmbd: use memcmp() to compare ClientGUIDs
      ksmbd: rate limit unmapped SID errors
      ksmbd: prevent out-of-bounds reads in share config responses
      ksmbd: return buffer overflow for partial filesystem info
      ksmbd: fix partial file information responses
      ksmbd: keep compound responses on query info errors
      ksmbd: fix partial normalized name responses

Nathan Chancellor (1):
      scripts/sorttable: Mark long_size as __maybe_unused

Nazim Amirul (1):
      net: stmmac: xgmac2: disable RBUE in default RX interrupt mask

Nguyen Ngoc Thang (2):
      ALSA: pcm: set timer->private_data before registering the PCM timer
      net/sched: act_ct: don't WARN on benign flow_offload_alloc() failure

Nicolai Buchwitz (1):
      net: macb: destroy the phylink instance on the probe error path

Nicolas Thibert (1):
      Bluetooth: btusb: fix NXP IW610 composite device handling

Nikhil P. Rao (1):
      pds_core: fix cmd_regs access racing BAR unmap on reset

Niklas Cassel (1):
      ata: libahci: clear PxCLBU and PxFBU for AHCI_HFLAG_32BIT_ONLY

Niklas Neronin (6):
      usb: xhci: add tracing for PORTSC register writes
      usb: xhci: add helper to read PORTSC register
      usb: xhci: add USB Port Register Set struct
      usb: xhci: implement USB Port Register Set struct
      usb: xhci: use cached HCSPARAMS1 value
      usb: xhci: simplify handling of Structural Parameters 1 values

Niklas Schnelle (1):
      docs: s390/pci: Improve and update PCI documentation

Nikolay Aleksandrov (2):
      net: bridge: mcast: properly convert mglist to rcu
      net: bridge: mst: move switchdev call outside rcu

Nikolay Metchev (1):
      platform/x86: intel-hid: Add HP ProBook x360 440 G1 to button_array_table

Nils Helmig (1):
      Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV

Norbert Szetei (4):
      net: openvswitch: fix use-after-free of the flow table mask array
      RDMA/rxe: validate access flags before swapping the MR's PD
      net: xps: reject an out of range traffic class
      ipv6: do not let ipv6_find_hdr() return an offset past the packet end

Nuno Sá (1):
      hwmon: (pmbus/core) increase number of phases and add new mask

Nuoqi Gui (1):
      bpf: Mask pseudo pointer values in verifier logs

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

Panagiotis Petrakopoulos (1):
      wifi: rtw88: Add NULL check for chip->edcca_th in rtw_fw_adaptivity_result()

Paolo Abeni (3):
      mptcp: fix bad accounting in __mptcp_subflow_push_pending()
      mptcp: avoid unneeded actions on subflow reset
      mptcp: close race between scheduler and state change

Parth Pancholi (1):
      drm/bridge: tc358768: Set pre_enable_prev_first for reverse order

Patrick Lu (Anthropic) (1):
      writeback: bound cleanup_offline_cgwb() rescans by rotating scanned inodes

Pauli Virtanen (3):
      Bluetooth: ISO: fix malformed ISO_END/CONT handling
      Bluetooth: L2CAP: fix chan mode for LE_CONN_REQ + EXT_FLOWCTL pchan
      Bluetooth: L2CAP: clear FLAG_DEFER_SETUP only for same PID/PSM

Paulo Alcantara (6):
      smb: client: fix one-byte OOB read in smb2_parse_native_symlink()
      smb: client: fix file type corruption in cifs_reparse_point_to_fattr()
      smb: client: fix file type corruption in wsl_to_fattr()
      smb: client: cancel reconnect work in clean_demultiplex_info()
      smb: client: fix rlist race and missing initialization
      smb: client: fix smbd_connection leak on cifs_get_tcp_session() error

Pavankumar Kondeti (1):
      workqueue: Fix NULL current_pwq deref in flush dependency check

Pedro Tammela (4):
      rtnl: add helper to send if skb is not null
      net/sched: act_api: don't open code max()
      net/sched: act_api: conditional notification of events
      net/sched: cls_route: make netlink errors meaningful

Peiyang He (4):
      drm/nouveau: fix double-free in nvif_vmm_dtor
      drm/nouveau: don't bump pin count on failed re-pin in nouveau_bo_pin_locked()
      drm/virtio: fix memory leak of fence event on execbuffer failure
      drm/virtio: fix NULL pointer dereference on fence allocation failure

Peng Hao (1):
      wifi: mwifiex: fix IRQ leak using wrong index in MSI-X error path

Pengpeng Hou (16):
      soundwire: validate DT compatible before parsing it
      drivers/of: validate status properties in reconfig state changes
      regulator: da9121: Use subvariant ids in the I2C table
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

Perry Yuan (1):
      drm/amdgpu: flush pending RCU callbacks on module unload

Peter Ujfalusi (1):
      soundwire: intel: Move suspend tracking from trigger to pm suspend

Phil Sutter (2):
      netfilter: nf_tables: Tolerate chains with no remaining hooks
      netfilter: nf_tables: Simplify chain netdev notifier

Pierre Barre (2):
      9p: invalidate readdir buffer on seek
      9p: use kvzalloc for readdir buffer

Ping-Ke Shih (1):
      wifi: rtw89: phy: check length before parsing PHY status IE

Pooja Katiyar (1):
      thunderbolt: Don't access path config space on Lane 1 adapters in tb_switch_reset_host()

Potin Lai (1):
      hwmon: (pmbus/lm25066) Fix PMBus coefficients for LM5064/5066/5066i

Praveen Talari (1):
      spi: core: Abort active target transfer on controller suspend

Priyansh Jain (1):
      thermal/drivers/qcom/tsens: Atomic temperature read with hardware-guided retries

Pu Hu (1):
      arm64: kprobes: Allow reentering kprobes while single-stepping

Qiang Liu (3):
      ksmbd: fix sd_ndr.data memory leak in ksmbd_vfs_set_sd_xattr
      ksmbd: fix n.data memory leak in ksmbd_vfs_set_dos_attrib_xattr
      ksmbd: Fix acl.sd_buf memory leak and invalid sd_size error handling

Qing Ming (1):
      gtp: serialize PDP context updates

Qingfang Deng (2):
      ppp: ppp_async: simplify tty disc_data access
      ppp_synctty: ensure a writeable skb header

Qingyu Zhang (1):
      ALSA: ump: do not touch legacy_rmidi before it exists

Qiuxu Zhuo (3):
      EDAC/igen6: Fix interleave boundary condition
      EDAC/igen6: Fix channel selection hash
      EDAC/igen6: Fix channel address decode for non-hash mode

Qu Wenruo (2):
      btrfs: fix the possible bioc_list memory leak during error
      btrfs: do not force reloc root creation during qgroup_account_snapshot()

Quanye Yang (2):
      RDMA/rtrs-clt: Fix CQ pool leak when connect is interrupted
      RDMA/ucma: Serialize join and leave on copy_to_user failure

Raf Dickson (1):
      vsock: use sk_acceptq_is_full() helper in all transports

Ralf Lici (1):
      net/mlx5e: advertise MACsec offload only when supported

Ran Hongyun (1):
      squashfs: Add dictionary size range check to prevent shift-out-of-bounds

Raphaël Larocque (1):
      Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)

Ratheesh Kannoth (2):
      octeontx2-pf: reset HTB scheduler topology before freeing queues
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

Rong Zhang (1):
      Bluetooth: btrtl: Don't leak return code when parsing firmware format v2

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

Russell King (Oracle) (1):
      ARM: ensure interrupts are enabled in __do_user_fault()

SJ Park (1):
      mm/damon/core: avoid infinite kdamond_merge_regions() internal loop

Sabrina Dubroca (1):
      xfrm: avoid RCU warnings around the per-netns netlink socket

Sahil Chandna (1):
      net: mana: Reserve extra CQ slot for the fence completion CQE

Sajal Gupta (1):
      drm/gud: fix out-of-bounds write in gud_plane_atomic_check()

Samuel Moelius (2):
      Bluetooth: L2CAP: validate connectionless PSM length
      f2fs: validate inline dentry name lengths before conversion

Sang-Hoon Choi (1):
      nfp: hold IPsec RX state under the XArray lock

Sanghyun Park (1):
      vxlan: use one headroom snapshot for neighbour replies

Sanjay Chitroda (1):
      iio: accel: mma8452: switch to non-devm request_threaded_irq()

Sanman Pradhan (2):
      hwmon: (pmbus/tps53679) Fix TPS53676 phase page decoding
      hwmon: (pmbus/tps53679) Select page 0 for single-page TPS53676

Saravana Kannan (1):
      of: dynamic: Fix overlayed devices not probing because of fw_devlink

Sasha Levin (21):
      Revert "Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU"
      Revert "Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU"
      Revert "arm64: dts: qcom: sm8550: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sm8450: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sm8350: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sm8250: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sm8150: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sdm845: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sc8180x: Fix the PCIe iommu-map entries"
      Revert "nvme-apple: Reset q->sq_tail during queue init"
      Revert "nvme-apple: Prevent shared tags across queues on Apple A11"
      Revert "nvme-apple: Drop the PRP null check chicken bit"
      Revert "nvme: apple: Add Apple A11 support"
      Revert "selftests/mm: skip COW tmpfile cases when fallocate() is unsupported"
      Revert "selftests/mm: report unique test names for each cow test"
      Revert "perf tests: Fix flakiness in BPF counters test on hybrid systems"
      Revert "hwmon: (emc1403) Drop hysteresis for low limit temperature"
      Revert "hwmon: (emc1403) Rely on subsystem locking"
      Revert "alpha: don't leak hardware-fabricated FP exception bits to user space"
      Revert "alpha: fix ieee_swcr_to_fpcr setting FPCR_DNOD unconditionally"
      ASoC: ux500: Parenthesize MSP_{RX,TX}_CLKPOL_BIT() arguments

Scott Mitchell (1):
      netfilter: nfnetlink_queue: nfqnl_instance GFP_ATOMIC -> GFP_KERNEL_ACCOUNT allocation

Sean Anderson (1):
      pinctrl: meson: Fix typo in s4 group name

Sean Christopherson (5):
      cgroup: selftests: Move memcontrol specific helpers out of common cgroup_util.c
      perf/x86/intel: Ensure KVM guest PEBS path doesn't set unwanted PERF_GLOBAL_CTRL bits
      perf/x86/intel: Don't write PEBS_ENABLED on host<=>guest xfers if CPU has PEBS isolation, to fix stuck PEBS_ENABLED
      perf/x86/intel: Don't pointlessly context switch DS_AREA (and PEBS config) if PEBS is unused
      perf/x86/intel: Make @data a mandatory param for intel_guest_get_msrs()

Sebastian Andrzej Siewior (1):
      ring-buffer: Acquire the lock with irqsave in rb_wake_up_waiters()

Selvin Xavier (1):
      RDMA/bnxt_re: Proper rollback if the ioremap fails

Seungwon Bae (1):
      vxlan: reject dynamic fdb entries that reference a nexthop id

Shahar Shitrit (1):
      net/mlx5e: Fix setting RS FEC after remapping

Shakeel Butt (1):
      mm/mlock: use the IRQ-safe accessor for NR_MLOCK in __munlock_folio()

Shawn Lin (1):
      mmc: core: Add validation for host-provided max_segs

Shay Drory (1):
      net/mlx5: E-Switch, align disable sequence with switchdev-to-legacy transition

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

Shiwu Zhang (1):
      drm/amdgpu: fix buffer overflow during vBIOS update

Shmulik Cohen (2):
      wifi: libipw: reject too-short beacon and probe responses
      wifi: libipw: reject too-short association responses

Shouping Wang (1):
      perf/arm-cmn: Fix wp_dev_sel2 setting for multi-DTM configurations

Shuangpeng Bai (2):
      btrfs: fix transaction use-after-free in raid stripe insertion
      IB/mlx4: Fix use-after-free on pkey sysfs registration failure

Shuhei Takeshita (2):
      IB/hfi1: Resolve the credit-return buffer through the send context's node
      IB/hfi1: Fix the PIO_CRED credit-return mmap

Si-Wei Liu (6):
      vdpa: introduce dedicated descriptor group for virtqueue
      vhost-vdpa: introduce descriptor group backend feature
      vdpa: introduce .reset_map operation callback
      vhost-vdpa: introduce IOTLB_PERSIST backend feature bit
      vdpa: introduce .compat_reset operation callback
      vhost-vdpa: clean iotlb map during reset for older userspace

Sidraya Jayagond (1):
      net/smc: fix UAF on lgr list traversal in smcr_port_err()

Siew Chin Lim (1):
      firmware: stratix10-svc: change get provision data to async SMC call

Simon Xue (1):
      iommu/rockchip: disable fetch dte time limit

Slavin Liu (1):
      ALSA: hda: trace PCM open only after assigning a stream

Slawomir Stepien (2):
      drm/cirrus-qemu: Validate BAR0 size during probe
      HID: amd_sfh: Validate PCI BAR size before mapping

Sophie D (1):
      drm/gud: Add RCade Display Adapter VID/PID pair

Srinivas Kandagatla (1):
      ASoC: qcom: q6apm: return error code to consumers on failures

Stanislaw Gruszka (1):
      wifi: iwlegacy: fix broadcast stations deallocation

Stefan Berger (1):
      integrity: Check for NULL returned by asymmetric_key_public_key

Stepan Ionichev (3):
      mmc: davinci: avoid NULL deref of host->data in IRQ handler
      usb: gadget: goku_udc: avoid NULL deref of dev->driver in INT_USBRESET log
      iio: adc: qcom-spmi-iadc: balance enable_irq_wake() on driver unbind

Stian Halseth (1):
      sunvdc: unmap LDC cookies when the descriptor send fails

Sudeep Holla (2):
      firmware: arm_scmi: Validate SENSOR_UPDATE payload size
      firmware: arm_scmi: Validate BASE_ERROR_EVENT payload size

Sunday Clement (1):
      drm/amdkfd: Fix OOB memory exposure in get_wave_state()

Sunil Khatri (1):
      drm/drm_exec: fix up contended obj when num_objects is 0

Sven Schnelle (1):
      selftests/ftrace: Fix unique symbol check in kprobe_non_uniq_symbol.tc

Takashi Iwai (14):
      ALSA: hda/realtek: Add quirk for HP Pavilion x360
      ALSA: hda/core: Use guard() for mutex locks
      ALSA: rawmidi: Expose the tied device number in info ioctl
      ALSA: rawmidi: Show substream activity in info ioctl
      ALSA: ump: Copy FB name string more safely
      ALSA: ump: Copy safe string name to rawmidi
      ALSA: ump: Update rawmidi name per EP name update
      ALSA: caiaq: Fix potential double-free at error path
      ALSA: hda: Introduce auto cleanup macros for PM
      ALSA: hda/common: Use cleanup macros for PM controls
      ALSA: hda/common: Use guard() for mutex locks
      ALSA: bcd2000: Fix race between rawmidi and disconnect
      ALSA: 6fire: Clean ups with guard()
      ALSA: usb: 6fire: Avoid embedded URBs

Tan Chi (1):
      RISC-V: KVM: Fix HSM hart status error propagation

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

Thomas Gleixner (1):
      tick/broadcast: Plug clockevents replacement race

Thomas Huth (1):
      kselftest/arm64: Fix size of thread_data values for pthread_join()

Thomas Weißschuh (1):
      tools/nolibc: avoid call to wcslen() in _start_c() inserted by clang

Thomas Zimmermann (2):
      drm/cirrus: Use video aperture helpers
      drm/ast: Automatically clean up poll helper

Thorsten Blum (6):
      crypto: omap - add omap_des_unregister_algs helper
      crypto: atmel-ecc - add support for atecc608b
      powerpc/kexec_file: Use inclusive range checks in add_usable_mem()
      powerpc/ps3: Fix repository.c build failure
      drm/i915: Fix memory leak in query_perf_config_list()
      crypto: atmel-ecc - avoid stale fallback key after set_secret failure

Théo Lebrun (1):
      net: macb: rename bp->sgmii_phy field to bp->phy

Tianchu Chen (3):
      ASoC: sprd: validate compress buffer sizes against fixed allocations
      wifi: rsi: fix heap OOB write on key removal
      wifi: wilc1000: fix RX buffer OOB-write in wilc_wlan_handle_isr_ext()

Tiezhu Yang (1):
      libbpf: Add __NR_bpf definition for LoongArch

Timur Kristóf (2):
      drm/amdgpu: Use system unbound workqueue for soft IH ring
      drm/amd/pm/si: Don't schedule thermal work when queue isn't initialized

Timur Tabi (1):
      drm/nouveau/gsp: add SEC2 to GA100 chip table

Tingmao Wang (1):
      selftests/landlock: Add tests for access through disconnected paths

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

Tzung-Bi Shih (12):
      watchdog: msc313e: Fix NULL pointer dereference in PM callbacks
      watchdog: msc313e: Avoid division by zero
      watchdog: msc313e: Fix clock leak and spurious timer in settimeout()
      watchdog: msc313e: Enable clock before accessing hardware registers
      watchdog: msc313e: Fix spurious reset on suspend
      watchdog: msc313e: Fix undefined behavior
      watchdog: msc313e: Sync timeout value if WDT was running at boot
      Bluetooth: btmtksdio: Fix PM runtime reference leak in shutdown
      watchdog: digicolor: Avoid division by zero
      watchdog: msc313e: Fix premature reset during timeout update
      watchdog: msc313e: Propagate error code in resume()
      watchdog: rtd119x: Avoid division by zero

Uwe Kleine-König (2):
      driver core: Better advertise dev_err_probe()
      driver core: Make dev_err_probe() silent for -ENOMEM

Uwe Küchler (1):
      ALSA: usb-audio: Add quirk for Novation Mininova

Vadim Fedorenko (2):
      spi: xilinx: let transfers timeout in case of no IRQ
      ptp: ocp: add shutdown callback

Vaibhav Jain (1):
      powerpc/pseries: Ensure vpa,slb_shadow & dtl are unregistered during crash

Vasily Gorbik (3):
      s390/ipl: Fix NULL deref in kdump without re-IPL parm block
      s390/ipl: Fix NULL deref in dump_reipl without re-IPL parm block
      s390/boot: Fix physical memory search range

Venkat Rao Bagalkote (1):
      char/nvram: Remove redundant nvram_mutex

Vernon Yang (1):
      x86/mm: Fix user-space data loss with MADV_FREE and THP

Viacheslav Dubeyko (3):
      hfsplus: fix issue of direct writes beyond end-of-file
      hfsplus: rework hfsplus_readdir() logic
      hfs: rework hfsplus_readdir() logic

Victor Nogueira (7):
      net/sched: act_api: budget all shared attributes in notify skbs
      net/sched: act_api: size the RTM_GETACTION reply from the actions
      net/sched: act_api: fix skb sizing and action leak on reoffload delete
      net/sched: cls_route: free emptied bucket on filter move
      net/sched: cls_route: Reject handle aliasing
      net/sched: cls_route: Fix in-place replace
      net/sched: act_gate: budget the per-entry list in get_fill_size

Viken Dadhaniya (1):
      spi: spi-qcom-qspi: Fix incomplete error handling in runtime PM

Viktor Menshin (1):
      ALSA: hda/realtek: Add quirk for Lenovo Xiaoxin 14 GT

Vineeth Karumanchi (1):
      net: macb: fix NULL pointer dereference on unbind with fixed-link

Vineeth Vijayan (4):
      s390/cio: Fix cio_update_schib() to not cache invalid schib
      s390/cio: Check pmcw.dnv before pmcw.ena in I/O entry points
      s390/cio: Guard PMCW field accesses with dnv check
      s390/cio: Fix NULL pointer dereference in ccw_device_get_util_str()

Vishnu Razdan (1):
      hwmon: (pmbus) Clear generic status alarms with CLEAR_FAULTS

Viswajith Murali (1):
      octeontx2-af: mcs: Clear stale X2P calibration state before calibration

Vlatko Kosturjak (1):
      ppp_async: drop the errored frame instead of resetting its headroom

Wang YuWei (1):
      spi: dw-dma: Wait for controller idle before completing Tx

Wei Jie LAW (1):
      HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()

Weiming Shi (11):
      ACPICA: Fix NULL pointer dereference in acpi_ns_custom_package()
      btrfs: tree-checker: validate INODE_REF's namelen
      net/sched: defer qdisc freeing after failed creation
      fbdev: vfb: defer cleanup until the last reference
      i2c: smbus: reject oversized block transfers in the common path
      net: appletalk: fix NULL pointer dereference in aarp_send_ddp()
      bpf: Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL
      bpf: Skip unsettled links in link iterator
      bpf: Reject dev-bound-only programs on other devices
      net/sched: reject IDR error pointers when deleting actions
      netfilter: ip6t_rpfilter: reject routes without inet6_dev

Wentao Liang (15):
      net: qrtr: fix node refcount leak on ctrl packet alloc failure
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
      net/mlx5: Fix rev_entry reference leak in mlx5_tc_ct_shared_counter_get()
      net: hisilicon: hns_dsaf_mac: fix mdio device leak in hns_mac_register_phy()
      net: usb: lan78xx: Fix URB reference leak in lan78xx_submit_deferred_urbs()

Wenwu Hou (1):
      erofs: fix large folio race in erofs_fscache_req_complete

Wyatt Feng (1):
      net: xfrm: reject unrepresentable espintcp transport headers

Xiang Mei (1):
      ALSA: 6fire: fix OOB write from device-reported iso length

Xiaogang Chen (2):
      drm/amdkfd: Let driver decide buffer size at AMDKFD_IOC_GET_DMABUF_INFO ioctl
      drm/amdkfd: check find_first_zero_bit before __set_bit on kfd->doorbell_bitmap

Xie Yuanbin (1):
      ARM: 9484/1: enable interrupts when unhandled user faults are triggered

Xin Long (3):
      sctp: fix err_chunk memory leaks in INIT handling
      sctp: fix a TOCTOU race in SCTP_CMD_TIMER_START
      sctp: hold asoc or transport before mod_timer() in timer handlers

Xiong Weimin (3):
      virtio_input: reset device if input_register_device() fails
      vdpa: ifcvf: Put device on unsupported feature error
      vdpa: solidrun: Free IRQs after request failure

Xixin Liu (3):
      nvme-rdma: fix -EIO cleanup order in queue_rq
      firmware: arm_scpi: reject DVFS OPP count above MAX_DVFS_OPPS
      clk: scpi: bound-check DVFS index in scpi_dvfs_recalc_rate

Xu Rao (3):
      ata: libata-pmp: add JMicron JMS562 quirk
      ALSA: hda: restore MFG widget enumeration after core split
      mmc: spi: reset bytes_xfered before retrying CRC failures

Xu Yang (1):
      usb: gadget: udc: skip pullup() if already connected

Xuanqiang Luo (3):
      raw: annotate disconnect-side IPv4 match writers
      fou: Fix use-after-free in fou_create()
      ip_gre: Reject enabling collect metadata through changelink

Yabin Cui (1):
      perf/core: Check sample_type in perf_sample_save_callchain

Yael Chemla (1):
      net/mlx5: E-Switch: fix use-after-free in mlx5_eswitch_termtbl_put

Yang Li (1):
      netfilter: nft_set_rbtree: Remove unused variable nft_net

Yehyeong Lee (4):
      net: drop_monitor: fix info leak in NET_DM_ATTR_PAYLOAD
      IB/iser: reject a remote invalidation of an unregistered direction
      IB/isert: wait for deferred control PDU completions before releasing the connection
      scsi: libiscsi_tcp: Check the data direction of a Data-In PDU

Yicong Hui (1):
      net/micrel: Fix typos in micrel driver code comments

Yifei Gao (1):
      memstick: ms_block: destroy io_queue workqueue on removal

Yige Jiang (1):
      net: netsec: fix device_node reference leak on phy_np

Yilin Zhang (3):
      ALSA: pcm: Serialize PCM mmap with buffer reallocation to fix page UAF
      inet: frags: invalidate queues before flushing them
      tcp: fix use-after-free of retransmit_skb_hint in tcp_send_synack()

Yiqi Sun (1):
      sctp: avoid livelock while updating retransmit path

Yonghong Song (1):
      bpf: Fail verification for sign-extension of packet data/data_end/data_meta

Yongqiang Sun (1):
      drm/amdkfd: Unwind debug trap enable on copy_to_user failure

Yousef Alhouseen (3):
      leds: uleds: Return -EFAULT on copy_to_user() failure
      xen/front-pgdir-shbuf: free grant reference head on errors
      xen/gntalloc: validate grant count before allocation

Youssef Samir (1):
      accel/qaic: Address potential out-of-bounds read in resp_worker()

Yu Kuai (2):
      md/raid5: account discard IO
      blk-cgroup: protect iterating blkgs with blkcg->lock in blkcg_print_stat()

Yu Peng (1):
      arm64: fixmap: Allow 256K early_ioremap() at any offset

Yu Zhang (1):
      vhost-vdpa: don't install the eventfd_ctx_fdget() error in config_ctx

Yuho Choi (2):
      sctp: Unwind address notifier registration on failure
      ALSA: virtio: reset device before deleting virtqueues

Yury Norov (1):
      bitfield: wire __bf_shf to __builtin_ctzll

Zeng Heng (1):
      arm64: io: Reject non-user protection in ioremap_prot()

Zhang Cen (1):
      btrfs: tree-checker: validate names in ROOT_REF and ROOT_BACKREF

Zhang Heng (2):
      ALSA: hda/realtek: Add HDA_CODEC_QUIRK for Samsung 750XBE/730XBE
      ASoC: amd: yc: Add DMI quirk for HP Victus Laptop 16-e1xxx

Zhang Tianci (1):
      fuse: set ff->flock only on success

Zhao Gongyi (1):
      bpf, sockmap: Reject max_entries > INT_MAX in sock_map_alloc

Zhao Li (4):
      wifi: mac80211: validate deauth frame length before reason access
      wifi: cfg80211: validate assoc response length before status and IE access
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

Zi Yan (1):
      mm/huge_memory: use folio's memcg inside __folio_split()

Zihan Xi (5):
      ipv6: fix fib6 walker UAF on seq stop
      ipv4: fib: bound automatic table ID allocation
      wifi: virt_wifi: don't transfer operstate before register
      smb: client: fix create context out-of-bounds reads
      smb: client: validate POSIX create context length

Zijie Huang (1):
      net: arp: terminate device name before lookup

Zijun Hu (1):
      mfd: db8500-prcmu: Remove needless return in three void APIs

Zixuan Chai (1):
      llc: reserve device headroom for allocated frames

Zizhi Wo (1):
      scsi: core: Do not block on tag allocation in scsi_eh_lock_door()

Zqiang (1):
      rcu-tasks: Fix possible boot-time tests failed for the call_rcu_tasks()

bui duc phuc (4):
      ASoC: rockchip: rockchip_pdm: Handle runtime PM resume failures in set_fmt
      ASoC: rockchip: rockchip_pdm: Reorder clock enable sequence
      ASoC: rockchip: spdif: Restore regcache cache-only mode on sync failure
      net: ethernet: ti: netcp: fix pm_runtime usage counter leak on error

chunzhi.lin (1):
      net: phy: motorcomm: use device properties for firmware tuning

guoqi0226 (1):
      spi: Add NULL check for spi_get_device_id() in spi_get_device_match_data()

hpp.iscas (3):
      ASoC: bcm: bcm63xx: Publish the OF module aliases
      ASoC: Intel: SST: Publish the PCI module aliases
      ASoC: mt6351: Publish the OF module alias

ikaros (13):
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
      ACPICA: Enhance OEM ID and Table ID validation in acpi_ex_load_table_op()
      ACPICA: Enhance buffer validation in acpi_ut_walk_aml_resources()
      ACPICA: add boundary checks in two places

leixiang (1):
      KVM: PPC: Book3S HV: Set irqfd->producer only on success

liyouhong (1):
      ata: ahci: fail probe if BAR too small for claimed ports

shayderrr (1):
      host1x: bus: Fix missing ops null check in error teardown

wangdicheng (2):
      ASoC: amd: renoir: fix disable_pdm_interrupts() to clear mask bits
      ASoC: amd: yc: fix memory leak in acp6x_pdm_dma_close()

Ömer Mete Kaya (3):
      nfc: llcp: fix -ENOMEM on connect with zero-length service name
      nfc: llcp: fix WKS SAP hijacking via prefix match in nfc_llcp_wks_sap()
      nfc: llcp: fix slab-out-of-bounds reads when logging service names

