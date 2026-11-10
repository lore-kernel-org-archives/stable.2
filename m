Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335320;
	b=BgTD2DRvia4qleiu7lOjyrzGkB03ba2/0dkaOAVcuwvLF+6FPpygohhA65SU2nm3JkhG
	 H+ABRskiNZQ4pjk7gd3dTjlZSXmPcqQi/brZB5ceIuXCHY5V1kqRXqSlf8Dvc2kA/tKha
	 J2olgbdKooA1T+gDcOMhK1Z3NKZABfBvbCmF0Jici7fbxliAty584L4bOty6BvaBMCmk6
	 lglMi9tTvtOR6kG/cD1oBARWfbA82svb0imQ+lqDoWqh4ph06850yM5uFAjLrwE7Q6QVu
	 VwrwohseJnaUlc7+6tsNVtENVOz57HRzjg6Hk+jRINqoRmQ3QKv5GtDRJmfjfD97mYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335320;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GWgOga+sYhlFvGvQ27yJj1KJejdv2pQzGHVbu4++vOQ=;
	b=txDqka/kzzyy+z5H6i58aQX0Sm0HeGYJ4aGER1vOcTDXK39Yl+tANpKg9T66LT4vhiMI
	 bl8K0dWLFPhwixNibuzEJRuJjVH4ExebYZH/GLrS+u6nUL5dzEnd9t+LyICMyLRwNilEh
	 tyqa7hpuGAUEKUtmeEMsvvkO9fRa14CS7WAbh0yDBE9qxLS7ysy5pSIsmhq72gNr3U1Ha
	 FFLUnYjlw1iK+qj2Al1U5hRrEIOlg3cTL1O+/PgawAzVZsREXegEfNaZjNFdJ0W12VVN+
	 yf0y4UcPdwIPPsQJ3YvtUmV1MXKaxovXAil4KzK6e0YxmT3OeBdUejZZCXQCX082Nsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=T7OnDrtt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3DD606A327;
	Tue, 10 Nov 2026 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=T7OnDrtt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F85F1F008A1;
	Tue, 10 Nov 2026 18:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794335319;
	bh=GWgOga+sYhlFvGvQ27yJj1KJejdv2pQzGHVbu4++vOQ=;
	h=From:To:Cc:Subject:Date;
	b=T7OnDrttUtb5PV++TUYuA8/rXZIBimB7O6r62EZ3JIyTiAn1AB9tXnhAGpnWTL10f
	 S9FBcnHEcFupcdWd4rNkQjoAbeyGLCQr4cx35D3lnCr709IV9SagQfUjWlmX4xsZmG
	 PN+zrbOOeKkPcPZ7BeiaiN5wckH9dwxg98ZNuWDc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.63
Date: Tue, 10 Nov 2026 13:28:35 -0500
Message-ID: <2026111036-racoon-landing-be00@gregkh>
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

I'm announcing the release of the 6.18.63 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml                |   16 
 Documentation/networking/ip-sysctl.rst                                         |    5 
 Documentation/userspace-api/check_exec.rst                                     |    4 
 Documentation/virt/hyperv/vmbus.rst                                            |   17 
 Makefile                                                                       |    2 
 arch/alpha/include/asm/mmu_context.h                                           |   35 -
 arch/alpha/include/asm/sfp-machine.h                                           |    4 
 arch/alpha/include/asm/switch_to.h                                             |    1 
 arch/alpha/include/asm/tlbflush.h                                              |    3 
 arch/alpha/kernel/smp.c                                                        |   67 +
 arch/alpha/mm/fault.c                                                          |   23 
 arch/alpha/mm/tlbflush.c                                                       |   18 
 arch/arm/include/asm/linkage.h                                                 |   29 
 arch/arm/include/asm/smp.h                                                     |    2 
 arch/arm/kernel/cacheinfo.c                                                    |   49 -
 arch/arm/kernel/head-nommu.S                                                   |    1 
 arch/arm/kernel/head.S                                                         |    1 
 arch/arm/kernel/smp.c                                                          |   15 
 arch/arm/kernel/topology.c                                                     |   13 
 arch/arm/mach-imx/pm-imx6.c                                                    |   26 
 arch/arm/mach-imx/suspend-imx6.S                                               |    6 
 arch/arm/mm/alignment.c                                                        |   51 +
 arch/arm64/boot/dts/freescale/imx8mm-verdin-ivy.dtsi                           |    4 
 arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi                        |    2 
 arch/arm64/boot/dts/freescale/imx8mp-verdin-ivy.dtsi                           |    4 
 arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi                         |    7 
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi                                      |    1 
 arch/arm64/boot/dts/qcom/ipq9574.dtsi                                          |    2 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi                   |    6 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts                             |    6 
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts                                       |    2 
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi                                |    2 
 arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts                               |    2 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                                     |    6 
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts                                 |    6 
 arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi                                 |    2 
 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi                               |    2 
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                                        |    5 
 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi                             |    2 
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi                                 |    2 
 arch/arm64/include/asm/kvm_arm.h                                               |    2 
 arch/arm64/include/asm/kvm_host.h                                              |    7 
 arch/arm64/include/asm/pgtable.h                                               |    3 
 arch/arm64/kernel/efi.c                                                        |    8 
 arch/arm64/kvm/arm.c                                                           |   49 -
 arch/arm64/kvm/hyp/exception.c                                                 |    5 
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h                                     |   28 
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h                                         |    2 
 arch/arm64/kvm/hyp/nvhe/pkvm.c                                                 |   37 +
 arch/arm64/kvm/hyp/nvhe/sys_regs.c                                             |    3 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                             |   33 
 arch/arm64/mm/contpte.c                                                        |    4 
 arch/loongarch/include/asm/barrier.h                                           |    3 
 arch/loongarch/include/asm/hw_breakpoint.h                                     |    4 
 arch/loongarch/include/asm/loongarch.h                                         |    4 
 arch/loongarch/include/asm/numa.h                                              |    2 
 arch/loongarch/kernel/cpu-probe.c                                              |    2 
 arch/loongarch/kernel/hw_breakpoint.c                                          |   27 
 arch/loongarch/kernel/irq.c                                                    |    3 
 arch/loongarch/kernel/traps.c                                                  |   13 
 arch/loongarch/pci/pci.c                                                       |    3 
 arch/microblaze/include/asm/entry.h                                            |   13 
 arch/microblaze/include/asm/processor.h                                        |    2 
 arch/microblaze/kernel/entry.S                                                 |  348 +++++-----
 arch/microblaze/kernel/hw_exception_handler.S                                  |    5 
 arch/microblaze/kernel/process.c                                               |    5 
 arch/microblaze/kernel/signal.c                                                |   26 
 arch/mips/mm/mmap.c                                                            |    6 
 arch/mips/mm/tlb-r4k.c                                                         |   21 
 arch/powerpc/platforms/pseries/plpks.c                                         |   27 
 arch/powerpc/platforms/pseries/plpks_sed_ops.c                                 |   12 
 arch/riscv/include/asm/pgtable.h                                               |    9 
 arch/riscv/kvm/vcpu_sbi_replace.c                                              |   12 
 arch/x86/include/asm/cpufeatures.h                                             |    1 
 arch/x86/include/asm/vmx.h                                                     |    8 
 arch/x86/kernel/cpu/amd.c                                                      |    9 
 arch/x86/kernel/cpu/bugs.c                                                     |    2 
 arch/x86/kernel/cpu/common.c                                                   |    5 
 arch/x86/kernel/cpu/scattered.c                                                |    1 
 arch/x86/kvm/cpuid.c                                                           |    1 
 arch/x86/kvm/reverse_cpuid.h                                                   |    2 
 arch/x86/kvm/vmx/vmx.c                                                         |    4 
 arch/x86/mm/pat/set_memory.c                                                   |   15 
 block/blk-iocost.c                                                             |    2 
 block/blk-mq.c                                                                 |    2 
 crypto/algif_skcipher.c                                                        |    8 
 crypto/ecc.c                                                                   |   33 
 crypto/testmgr.c                                                               |   11 
 crypto/testmgr.h                                                               |  327 +++++++++
 drivers/accessibility/speakup/selection.c                                      |    6 
 drivers/acpi/pfr_update.c                                                      |    2 
 drivers/ata/ahci_st.c                                                          |   78 +-
 drivers/ata/libahci.c                                                          |   28 
 drivers/ata/libahci_platform.c                                                 |    4 
 drivers/ata/libata-core.c                                                      |   75 +-
 drivers/ata/libata-scsi.c                                                      |    5 
 drivers/ata/libata-sff.c                                                       |    5 
 drivers/ata/sata_fsl.c                                                         |    6 
 drivers/ata/sata_qstor.c                                                       |    8 
 drivers/block/amiflop.c                                                        |   71 +-
 drivers/block/aoe/aoenet.c                                                     |   14 
 drivers/block/floppy.c                                                         |    8 
 drivers/block/loop.c                                                           |    6 
 drivers/block/ublk_drv.c                                                       |   27 
 drivers/block/xen-blkfront.c                                                   |    4 
 drivers/bluetooth/btusb.c                                                      |    2 
 drivers/char/hw_random/amd-rng.c                                               |    2 
 drivers/char/hw_random/ba431-rng.c                                             |    2 
 drivers/char/hw_random/core.c                                                  |    1 
 drivers/char/tpm/tpm-dev-common.c                                              |    3 
 drivers/char/tpm/tpm_nsc.c                                                     |    8 
 drivers/clk/imx/clk.c                                                          |   15 
 drivers/clk/mstar/clk-msc313-mpll.c                                            |    2 
 drivers/clk/mvebu/ap-cpu-clk.c                                                 |    4 
 drivers/clk/qcom/gcc-ipq5018.c                                                 |   10 
 drivers/clk/qcom/gcc-ipq5332.c                                                 |    1 
 drivers/clk/qcom/ipq-cmn-pll.c                                                 |    3 
 drivers/clk/starfive/clk-starfive-jh7110-isp.c                                 |    2 
 drivers/clocksource/timer-digicolor.c                                          |    2 
 drivers/clocksource/timer-fttmr010.c                                           |    2 
 drivers/cpufreq/Kconfig                                                        |    1 
 drivers/cpufreq/airoha-cpufreq.c                                               |    2 
 drivers/cpufreq/amd-pstate.c                                                   |    6 
 drivers/cpufreq/cpufreq_conservative.c                                         |    8 
 drivers/cpufreq/cpufreq_governor.c                                             |   29 
 drivers/cpufreq/cpufreq_governor.h                                             |    2 
 drivers/cpufreq/cpufreq_stats.c                                                |    4 
 drivers/cpufreq/intel_pstate.c                                                 |    2 
 drivers/cpufreq/loongson3_cpufreq.c                                            |   73 +-
 drivers/crypto/amlogic/amlogic-gxl-core.c                                      |    7 
 drivers/crypto/atmel-aes.c                                                     |    2 
 drivers/crypto/atmel-tdes.c                                                    |    6 
 drivers/crypto/caam/caampkc.c                                                  |    6 
 drivers/crypto/ccp/dbc.c                                                       |    4 
 drivers/crypto/hisilicon/hpre/hpre_crypto.c                                    |   20 
 drivers/crypto/intel/qat/qat_common/adf_dev_mgr.c                              |   10 
 drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c                          |    5 
 drivers/crypto/intel/qat/qat_common/adf_gen6_ras.c                             |   20 
 drivers/crypto/intel/qat/qat_common/adf_gen6_ras.h                             |   24 
 drivers/crypto/intel/qat/qat_common/adf_vf_isr.c                               |    2 
 drivers/crypto/nx/nx-842.c                                                     |    2 
 drivers/crypto/omap-des.c                                                      |    2 
 drivers/crypto/xilinx/zynqmp-sha.c                                             |    2 
 drivers/cxl/acpi.c                                                             |   20 
 drivers/cxl/core/pci.c                                                         |   50 -
 drivers/cxl/core/port.c                                                        |    3 
 drivers/dax/super.c                                                            |    2 
 drivers/dma/altera-msgdma.c                                                    |   10 
 drivers/edac/i10nm_base.c                                                      |    1 
 drivers/firewire/ohci-serdes-test.c                                            |    4 
 drivers/firewire/ohci.h                                                        |    2 
 drivers/firmware/efi/libstub/Makefile                                          |    2 
 drivers/firmware/efi/libstub/efi-stub.c                                        |    8 
 drivers/fpga/fpga-mgr.c                                                        |    2 
 drivers/gpio/gpio-davinci.c                                                    |    6 
 drivers/gpio/gpio-pca953x.c                                                    |   14 
 drivers/gpio/gpiolib-cdev.c                                                    |    5 
 drivers/gpio/gpiolib.c                                                         |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                                            |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                                     |   19 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                               |  105 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                         |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                     |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                        |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c                                        |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                                     |   33 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                        |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                                         |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c                                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c                                    |    5 
 drivers/gpu/drm/amd/amdgpu/cik.c                                               |   10 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                                          |   18 
 drivers/gpu/drm/amd/amdgpu/si.c                                                |   10 
 drivers/gpu/drm/amd/amdgpu/vi.c                                                |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                       |   48 -
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c                                          |   35 -
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c                                      |   23 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                                          |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                                       |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c                                         |   23 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                           |   21 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                              |   11 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c                      |    2 
 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c                           |    2 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c |    2 
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c                        |    3 
 drivers/gpu/drm/amd/include/kgd_pp_interface.h                                 |    2 
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                                            |   85 ++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h                                        |    1 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                               |   33 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                                      |   87 ++
 drivers/gpu/drm/arm/malidp_crtc.c                                              |    1 
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c                             |   13 
 drivers/gpu/drm/drm_panic.c                                                    |    5 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                             |    2 
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c                                         |   32 
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                                            |   16 
 drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h                              |    1 
 drivers/gpu/drm/nouveau/nouveau_abi16.c                                        |    4 
 drivers/gpu/drm/nouveau/nouveau_connector.c                                    |    1 
 drivers/gpu/drm/nouveau/nouveau_dp.c                                           |    4 
 drivers/gpu/drm/nouveau/nouveau_fence.c                                        |    2 
 drivers/gpu/drm/nouveau/nouveau_svm.c                                          |   13 
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c                              |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild                                 |    1 
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c                                |   35 +
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c                                      |    2 
 drivers/gpu/drm/ttm/ttm_bo_util.c                                              |   11 
 drivers/hte/hte-tegra194-test.c                                                |    2 
 drivers/hte/hte-tegra194.c                                                     |   10 
 drivers/hwmon/acpi_power_meter.c                                               |   10 
 drivers/hwmon/coretemp.c                                                       |   31 
 drivers/hwmon/corsair-cpro.c                                                   |    9 
 drivers/hwmon/gigabyte_waterforce.c                                            |    5 
 drivers/hwmon/lm95245.c                                                        |    6 
 drivers/hwmon/sht3x.c                                                          |    5 
 drivers/hwmon/sht4x.c                                                          |   22 
 drivers/i2c/busses/i2c-designware-master.c                                     |    8 
 drivers/i2c/busses/i2c-mt7621.c                                                |    9 
 drivers/i2c/i2c-core-acpi.c                                                    |    6 
 drivers/i3c/master.c                                                           |    7 
 drivers/i3c/master/adi-i3c-master.c                                            |    4 
 drivers/i3c/master/mipi-i3c-hci/dma.c                                          |    2 
 drivers/iio/accel/adis16201.c                                                  |   10 
 drivers/iio/accel/adxl313_spi.c                                                |    2 
 drivers/iio/accel/adxl380_spi.c                                                |    2 
 drivers/iio/accel/kxcjk-1013.c                                                 |    1 
 drivers/iio/accel/mma9551.c                                                    |    1 
 drivers/iio/accel/mma9553.c                                                    |    1 
 drivers/iio/adc/ad7606_spi.c                                                   |    6 
 drivers/iio/adc/at91-sama5d2_adc.c                                             |    1 
 drivers/iio/adc/max11205.c                                                     |    2 
 drivers/iio/adc/mcp3911.c                                                      |    2 
 drivers/iio/adc/stm32-adc.c                                                    |    4 
 drivers/iio/adc/ti-adc128s052.c                                                |    8 
 drivers/iio/adc/ti-ads1100.c                                                   |  107 ++-
 drivers/iio/dac/ad5755.c                                                       |    3 
 drivers/iio/frequency/adf4377.c                                                |    3 
 drivers/iio/imu/adis16400.c                                                    |    3 
 drivers/iio/imu/inv_icm42600/inv_icm42600.h                                    |    1 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c                              |   17 
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c                             |    2 
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c                               |    9 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c                               |    8 
 drivers/iio/light/apds9306.c                                                   |    2 
 drivers/iio/potentiometer/x9250.c                                              |    7 
 drivers/iio/pressure/bmp280-spi.c                                              |    2 
 drivers/infiniband/hw/hfi1/chip.c                                              |    4 
 drivers/infiniband/hw/hfi1/fault.c                                             |    1 
 drivers/input/input.c                                                          |    4 
 drivers/input/joystick/xpad.c                                                  |    1 
 drivers/input/keyboard/matrix_keypad.c                                         |    3 
 drivers/iommu/amd/init.c                                                       |   23 
 drivers/iommu/dma-iommu.c                                                      |   20 
 drivers/iommu/intel/iommu.h                                                    |   17 
 drivers/iommu/iommufd/io_pagetable.c                                           |    3 
 drivers/irqchip/irq-atmel-aic.c                                                |    2 
 drivers/irqchip/irq-atmel-aic5.c                                               |    2 
 drivers/irqchip/irq-gic-v3-its.c                                               |    2 
 drivers/irqchip/irq-imx-intmux.c                                               |   15 
 drivers/irqchip/irq-mchp-eic.c                                                 |    4 
 drivers/irqchip/irq-msi-lib.c                                                  |    1 
 drivers/irqchip/irq-riscv-imsic-platform.c                                     |    2 
 drivers/leds/flash/leds-ktd2692.c                                              |   10 
 drivers/mailbox/bcm74110-mailbox.c                                             |   13 
 drivers/mailbox/mailbox-altera.c                                               |    2 
 drivers/mailbox/mtk-cmdq-mailbox.c                                             |    7 
 drivers/mailbox/qcom-ipcc.c                                                    |    6 
 drivers/md/dm-bufio.c                                                          |   45 +
 drivers/md/dm-snap-persistent.c                                                |    7 
 drivers/md/dm-vdo/indexer/chapter-index.c                                      |   15 
 drivers/md/dm-vdo/indexer/delta-index.c                                        |   17 
 drivers/md/dm-vdo/indexer/volume.c                                             |    6 
 drivers/md/dm-writecache.c                                                     |   54 +
 drivers/md/dm.c                                                                |    2 
 drivers/md/md.c                                                                |   17 
 drivers/md/raid5-cache.c                                                       |   34 
 drivers/md/raid5.c                                                             |    8 
 drivers/md/raid5.h                                                             |    1 
 drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c              |    4 
 drivers/media/common/saa7146/saa7146_core.c                                    |    3 
 drivers/media/dvb-frontends/stv0900_core.c                                     |    2 
 drivers/media/dvb-frontends/stv090x.c                                          |    2 
 drivers/media/i2c/adv7180.c                                                    |    2 
 drivers/media/i2c/adv7604.c                                                    |    3 
 drivers/media/i2c/alvium-csi2.c                                                |    1 
 drivers/media/i2c/ov2735.c                                                     |    1 
 drivers/media/i2c/ov8856.c                                                     |   32 
 drivers/media/i2c/tc358743.c                                                   |    3 
 drivers/media/pci/cx18/cx18-driver.c                                           |    9 
 drivers/media/pci/tw68/tw68-core.c                                             |    2 
 drivers/media/pci/tw686x/tw686x-core.c                                         |   10 
 drivers/media/platform/amphion/vpu_core.c                                      |   19 
 drivers/media/platform/amphion/vpu_drv.c                                       |    1 
 drivers/media/platform/atmel/atmel-isi.c                                       |    7 
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c                       |    8 
 drivers/media/platform/chips-media/wave5/wave5-vpu.c                           |    7 
 drivers/media/platform/chips-media/wave5/wave5-vpuapi.c                        |   15 
 drivers/media/platform/imagination/e5010-jpeg-enc.c                            |    4 
 drivers/media/platform/m2m-deinterlace.c                                       |    2 
 drivers/media/platform/marvell/Kconfig                                         |    1 
 drivers/media/platform/marvell/mmp-driver.c                                    |    5 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c                           |   17 
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c                           |   14 
 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c            |    2 
 drivers/media/platform/mediatek/vpu/mtk_vpu.c                                  |    2 
 drivers/media/platform/microchip/microchip-isc-base.c                          |   56 +
 drivers/media/platform/microchip/microchip-isc-clk.c                           |    7 
 drivers/media/platform/microchip/microchip-isc.h                               |    1 
 drivers/media/platform/microchip/microchip-sama5d2-isc.c                       |   11 
 drivers/media/platform/microchip/microchip-sama7g5-isc.c                       |   11 
 drivers/media/platform/nuvoton/npcm-video.c                                    |    9 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                                 |   21 
 drivers/media/platform/qcom/camss/camss-vfe-17x.c                              |   46 -
 drivers/media/platform/qcom/camss/camss-vfe.c                                  |   14 
 drivers/media/platform/qcom/camss/camss.c                                      |   25 
 drivers/media/platform/qcom/iris/iris_vidc.c                                   |    6 
 drivers/media/platform/qcom/venus/core.c                                       |   66 +
 drivers/media/platform/qcom/venus/core.h                                       |    6 
 drivers/media/platform/samsung/exynos4-is/fimc-lite.c                          |    3 
 drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c                          |    7 
 drivers/media/platform/st/stm32/stm32-csi.c                                    |    5 
 drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c                           |   80 +-
 drivers/media/platform/ti/davinci/vpif_capture.c                               |    5 
 drivers/media/platform/ti/davinci/vpif_display.c                               |    3 
 drivers/media/platform/verisilicon/hantro_drv.c                                |    9 
 drivers/media/platform/verisilicon/hantro_g1_mpeg2_dec.c                       |    5 
 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c                |   68 +
 drivers/media/rc/ene_ir.c                                                      |    4 
 drivers/media/rc/ir-hix5hd2.c                                                  |    5 
 drivers/media/rc/ir_toy.c                                                      |    2 
 drivers/media/rc/meson-ir-tx.c                                                 |   20 
 drivers/media/rc/redrat3.c                                                     |   17 
 drivers/media/rc/serial_ir.c                                                   |    2 
 drivers/media/rc/streamzap.c                                                   |    1 
 drivers/media/rc/sunxi-cir.c                                                   |    2 
 drivers/media/test-drivers/vicodec/codec-fwht.h                                |    2 
 drivers/media/test-drivers/vicodec/vicodec-core.c                              |   16 
 drivers/media/test-drivers/vidtv/vidtv_bridge.c                                |    4 
 drivers/media/test-drivers/vidtv/vidtv_demod.c                                 |    9 
 drivers/media/test-drivers/vim2m.c                                             |   29 
 drivers/media/test-drivers/vivid/vivid-core.c                                  |    1 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c                               |   13 
 drivers/media/usb/au0828/au0828-core.c                                         |    4 
 drivers/media/usb/au0828/au0828-dvb.c                                          |   19 
 drivers/media/usb/cx231xx/cx231xx-audio.c                                      |   15 
 drivers/media/usb/cx231xx/cx231xx-cards.c                                      |    2 
 drivers/media/usb/cx231xx/cx231xx.h                                            |    2 
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c                                        |   14 
 drivers/media/usb/em28xx/em28xx-core.c                                         |    3 
 drivers/media/usb/go7007/go7007-usb.c                                          |    8 
 drivers/media/usb/pvrusb2/pvrusb2-sysfs.c                                      |    1 
 drivers/media/usb/uvc/uvc_ctrl.c                                               |    2 
 drivers/media/v4l2-core/v4l2-common.c                                          |    2 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                                      |   12 
 drivers/memory/brcmstb_dpfe.c                                                  |   24 
 drivers/memory/renesas-rpc-if.c                                                |    1 
 drivers/memory/stm32_omm.c                                                     |    2 
 drivers/mfd/Kconfig                                                            |    2 
 drivers/mfd/da903x.c                                                           |   34 
 drivers/mfd/tps65217.c                                                         |   69 +
 drivers/mfd/wcd934x.c                                                          |    8 
 drivers/misc/mei/vsc-tp.c                                                      |    2 
 drivers/mtd/chips/cfi_cmdset_0002.c                                            |   15 
 drivers/mtd/maps/amd76xrom.c                                                   |    2 
 drivers/mtd/maps/l440gx.c                                                      |    2 
 drivers/mtd/maps/pci.c                                                         |    2 
 drivers/mtd/mtdcore.c                                                          |    2 
 drivers/mtd/mtdsuper.c                                                         |    4 
 drivers/mtd/nand/raw/atmel/nand-controller.c                                   |    6 
 drivers/mtd/nand/raw/nuvoton-ma35d1-nand-controller.c                          |    1 
 drivers/mtd/nand/raw/qcom_nandc.c                                              |    8 
 drivers/mtd/nand/raw/sunxi_nand.c                                              |    3 
 drivers/mtd/parsers/qcomsmempart.c                                             |    4 
 drivers/mtd/spi-nor/core.c                                                     |    9 
 drivers/mtd/spi-nor/sfdp.c                                                     |    8 
 drivers/net/bonding/bond_main.c                                                |    2 
 drivers/net/ethernet/google/gve/gve_flow_rule.c                                |    1 
 drivers/net/ethernet/hisilicon/hisi_femac.c                                    |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                                  |   40 -
 drivers/net/macvlan.c                                                          |    3 
 drivers/net/netdevsim/bpf.c                                                    |   11 
 drivers/net/ppp/ppp_generic.c                                                  |    1 
 drivers/net/usb/pegasus.c                                                      |   12 
 drivers/net/usb/r8152.c                                                        |   10 
 drivers/net/veth.c                                                             |    5 
 drivers/net/virtio_net.c                                                       |   25 
 drivers/net/wireless/ath/ath11k/dp.c                                           |    2 
 drivers/net/wireless/ath/ath12k/wmi.c                                          |   17 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c                   |    2 
 drivers/net/wireless/mediatek/mt76/eeprom.c                                    |   17 
 drivers/net/wireless/mediatek/mt76/mt7615/init.c                               |   17 
 drivers/net/wireless/mediatek/mt76/mt7615/main.c                               |    6 
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c                           |    1 
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                               |   19 
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c                           |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c                                |   11 
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c                                |   12 
 drivers/net/wireless/mediatek/mt76/tx.c                                        |    2 
 drivers/net/wireless/mediatek/mt76/usb.c                                       |   31 
 drivers/net/wireless/realtek/rtw88/mac80211.c                                  |    2 
 drivers/net/wireless/realtek/rtw89/fw.c                                        |   32 
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c                              |    4 
 drivers/net/wireless/realtek/rtw89/wow.c                                       |    6 
 drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c                                  |    5 
 drivers/net/xen-netback/netback.c                                              |    9 
 drivers/net/xen-netback/xenbus.c                                               |    8 
 drivers/nvme/host/auth.c                                                       |   15 
 drivers/nvme/host/core.c                                                       |   15 
 drivers/nvme/host/rdma.c                                                       |    1 
 drivers/nvme/host/sysfs.c                                                      |   14 
 drivers/nvme/host/tcp.c                                                        |   24 
 drivers/nvme/target/admin-cmd.c                                                |    2 
 drivers/nvme/target/auth.c                                                     |    2 
 drivers/nvme/target/configfs.c                                                 |    2 
 drivers/nvme/target/fabrics-cmd-auth.c                                         |   42 -
 drivers/nvme/target/fabrics-cmd.c                                              |    4 
 drivers/nvme/target/fc.c                                                       |   10 
 drivers/nvme/target/io-cmd-bdev.c                                              |    5 
 drivers/nvme/target/io-cmd-file.c                                              |    4 
 drivers/nvme/target/nvmet.h                                                    |    2 
 drivers/nvme/target/pci-epf.c                                                  |   30 
 drivers/nvme/target/pr.c                                                       |    2 
 drivers/nvme/target/rdma.c                                                     |    2 
 drivers/nvme/target/zns.c                                                      |   10 
 drivers/parisc/eisa_enumerator.c                                               |   15 
 drivers/pci/controller/dwc/pcie-qcom-ep.c                                      |    2 
 drivers/pci/controller/pcie-rockchip-ep.c                                      |   13 
 drivers/pci/controller/pcie-rockchip-host.c                                    |   20 
 drivers/pci/controller/pcie-rockchip.c                                         |   14 
 drivers/pci/controller/pcie-rockchip.h                                         |    3 
 drivers/pci/controller/pcie-xilinx-dma-pl.c                                    |   10 
 drivers/pci/doe.c                                                              |    5 
 drivers/pci/hotplug/pciehp_core.c                                              |    2 
 drivers/pci/pci-label.c                                                        |    2 
 drivers/pci/pci.c                                                              |   33 
 drivers/pci/pcie/aer.c                                                         |    7 
 drivers/pci/probe.c                                                            |    5 
 drivers/pci/quirks.c                                                           |   26 
 drivers/pci/xen-pcifront.c                                                     |   11 
 drivers/peci/controller/peci-aspeed.c                                          |    6 
 drivers/peci/controller/peci-npcm.c                                            |    6 
 drivers/perf/xgene_pmu.c                                                       |    4 
 drivers/pinctrl/stm32/pinctrl-stm32.c                                          |    6 
 drivers/platform/x86/amd/hfi/hfi.c                                             |   20 
 drivers/platform/x86/amd/pmc/pmc.c                                             |   20 
 drivers/platform/x86/amd/pmf/spc.c                                             |    8 
 drivers/platform/x86/amd/pmf/sps.c                                             |   10 
 drivers/platform/x86/asus-wmi.c                                                |   42 -
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c                                   |   82 --
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c                      |   16 
 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c                         |    5 
 drivers/platform/x86/hp/hp-wmi.c                                               |    7 
 drivers/platform/x86/intel/int3472/discrete.c                                  |   25 
 drivers/platform/x86/intel/pmt/class.c                                         |    9 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c                 |    2 
 drivers/platform/x86/intel/vsec.c                                              |    2 
 drivers/platform/x86/oxpec.c                                                   |   68 +
 drivers/platform/x86/siemens/simatic-ipc.c                                     |   21 
 drivers/platform/x86/tuxedo/nb04/wmi_ab.c                                      |    8 
 drivers/power/supply/ab8500_fg.c                                               |   67 -
 drivers/power/supply/bq27xxx_battery.c                                         |   12 
 drivers/power/supply/cros_charge-control.c                                     |   29 
 drivers/power/supply/generic-adc-battery.c                                     |    2 
 drivers/power/supply/power_supply_core.c                                       |   84 +-
 drivers/power/supply/qcom_battmgr.c                                            |   26 
 drivers/power/supply/qcom_smbx.c                                               |  109 ++-
 drivers/pps/generators/pps_gen.c                                               |   40 +
 drivers/pwm/pwm-tiehrpwm.c                                                     |    3 
 drivers/regulator/core.c                                                       |    4 
 drivers/regulator/rt6190-regulator.c                                           |   18 
 drivers/remoteproc/remoteproc_elf_loader.c                                     |   23 
 drivers/rtc/rtc-cmos.c                                                         |    6 
 drivers/rtc/rtc-pcf8563.c                                                      |    2 
 drivers/scsi/libiscsi_tcp.c                                                    |    3 
 drivers/sh/intc/core.c                                                         |   11 
 drivers/sh/maple/maple.c                                                       |    4 
 drivers/slimbus/messaging.c                                                    |    2 
 drivers/soc/fsl/dpio/dpio-driver.c                                             |    9 
 drivers/soc/fsl/qe/tsa.c                                                       |   16 
 drivers/soc/qcom/qcom-geni-se.c                                                |   45 -
 drivers/soc/samsung/exynos-pmu.c                                               |   61 +
 drivers/spi/spi-amd.c                                                          |   15 
 drivers/spi/spi-bcm-qspi.c                                                     |    3 
 drivers/spi/spi-bcm2835.c                                                      |    4 
 drivers/spi/spi-cadence-xspi.c                                                 |   16 
 drivers/spi/spi-ch341.c                                                        |    6 
 drivers/spi/spi-jcore.c                                                        |    2 
 drivers/spi/spi-ljca.c                                                         |    8 
 drivers/spi/spi-npcm-fiu.c                                                     |    8 
 drivers/spi/spi-qpic-snand.c                                                   |    3 
 drivers/spi/spi-stm32.c                                                        |    3 
 drivers/spi/spi-zynq-qspi.c                                                    |   13 
 drivers/staging/greybus/uart.c                                                 |   30 
 drivers/staging/media/av7110/sp8870.c                                          |    5 
 drivers/staging/media/imx/imx-media-csc-scaler.c                               |    1 
 drivers/staging/media/meson/vdec/vdec.c                                        |    2 
 drivers/staging/rtl8723bs/core/rtw_recv.c                                      |  103 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c                                       |    7 
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.c               |   10 
 drivers/thermal/intel/intel_powerclamp.c                                       |    3 
 drivers/tty/serial/8250/8250_exar.c                                            |   36 -
 drivers/tty/serial/8250/8250_lpss.c                                            |    7 
 drivers/tty/serial/8250/8250_omap.c                                            |    3 
 drivers/tty/serial/amba-pl011.c                                                |   37 -
 drivers/tty/serial/pmac_zilog.c                                                |    4 
 drivers/ufs/core/ufs_bsg.c                                                     |   10 
 drivers/ufs/core/ufshcd.c                                                      |   21 
 drivers/usb/class/cdc-acm.c                                                    |    6 
 drivers/usb/core/quirks.c                                                      |    3 
 drivers/usb/fotg210/fotg210-udc.c                                              |   17 
 drivers/usb/gadget/legacy/inode.c                                              |    4 
 drivers/usb/host/xhci-ring.c                                                   |    9 
 drivers/usb/host/xhci.c                                                        |   11 
 drivers/usb/serial/option.c                                                    |    5 
 drivers/usb/serial/sierra.c                                                    |    3 
 drivers/usb/serial/usb_wwan.c                                                  |    3 
 drivers/usb/typec/ucsi/ucsi_ccg.c                                              |   37 -
 drivers/vfio/pci/mlx5/cmd.c                                                    |    2 
 drivers/video/fbdev/atmel_lcdfb.c                                              |   13 
 drivers/video/fbdev/core/bitblit.c                                             |    7 
 drivers/video/fbdev/kyro/fbdev.c                                               |    4 
 drivers/video/fbdev/sh_mobile_lcdcfb.c                                         |    6 
 drivers/video/fbdev/smscufx.c                                                  |    9 
 drivers/video/fbdev/ssd1307fb.c                                                |    6 
 drivers/video/fbdev/udlfb.c                                                    |    9 
 drivers/video/fbdev/xen-fbfront.c                                              |    7 
 drivers/xen/gntdev.c                                                           |    7 
 drivers/xen/privcmd.c                                                          |   47 -
 drivers/xen/xen-pciback/pci_stub.c                                             |    7 
 fs/affs/bitmap.c                                                               |    2 
 fs/aio.c                                                                       |   18 
 fs/backing-file.c                                                              |   39 +
 fs/btrfs/inode.c                                                               |    3 
 fs/btrfs/super.c                                                               |    3 
 fs/btrfs/volumes.c                                                             |    6 
 fs/ceph/addr.c                                                                 |   15 
 fs/ceph/caps.c                                                                 |    6 
 fs/ceph/crypto.c                                                               |    3 
 fs/ceph/mds_client.c                                                           |   28 
 fs/ceph/mdsmap.c                                                               |   12 
 fs/ceph/snap.c                                                                 |    7 
 fs/ceph/xattr.c                                                                |   10 
 fs/crypto/keysetup.c                                                           |    8 
 fs/dax.c                                                                       |   14 
 fs/dcache.c                                                                    |   16 
 fs/dlm/lowcomms.c                                                              |    6 
 fs/erofs/decompressor.c                                                        |    2 
 fs/exportfs/expfs.c                                                            |    6 
 fs/ext4/balloc.c                                                               |    2 
 fs/ext4/ext4.h                                                                 |    3 
 fs/ext4/extents.c                                                              |   26 
 fs/ext4/indirect.c                                                             |   17 
 fs/ext4/inode.c                                                                |   13 
 fs/ext4/ioctl.c                                                                |    3 
 fs/ext4/namei.c                                                                |   11 
 fs/ext4/super.c                                                                |   29 
 fs/f2fs/compress.c                                                             |   10 
 fs/f2fs/data.c                                                                 |   11 
 fs/f2fs/file.c                                                                 |   49 -
 fs/f2fs/segment.c                                                              |    3 
 fs/f2fs/super.c                                                                |   48 +
 fs/fat/fat.h                                                                   |    2 
 fs/fat/fatent.c                                                                |   21 
 fs/fat/file.c                                                                  |    3 
 fs/fat/misc.c                                                                  |    6 
 fs/fs-writeback.c                                                              |    7 
 fs/fs_pin.c                                                                    |    9 
 fs/fuse/file.c                                                                 |   15 
 fs/fuse/virtio_fs.c                                                            |   21 
 fs/gfs2/lops.c                                                                 |    4 
 fs/iomap/fiemap.c                                                              |    8 
 fs/isofs/inode.c                                                               |    2 
 fs/isofs/isofs.h                                                               |    2 
 fs/isofs/rock.c                                                                |   11 
 fs/jbd2/journal.c                                                              |    2 
 fs/namespace.c                                                                 |    7 
 fs/nilfs2/dir.c                                                                |   34 
 fs/nilfs2/inode.c                                                              |    8 
 fs/nilfs2/ioctl.c                                                              |    2 
 fs/nilfs2/mdt.c                                                                |    6 
 fs/nilfs2/page.c                                                               |   50 -
 fs/nilfs2/page.h                                                               |    4 
 fs/nilfs2/recovery.c                                                           |    2 
 fs/nilfs2/segment.c                                                            |   12 
 fs/nilfs2/sysfs.c                                                              |    5 
 fs/nilfs2/the_nilfs.c                                                          |   34 
 fs/notify/fanotify/fanotify.c                                                  |    7 
 fs/notify/fanotify/fanotify.h                                                  |   21 
 fs/ntfs3/fslog.c                                                               |   29 
 fs/ntfs3/index.c                                                               |   13 
 fs/ocfs2/cluster/heartbeat.c                                                   |   26 
 fs/ocfs2/cluster/nodemanager.c                                                 |    7 
 fs/ocfs2/dir.c                                                                 |   76 +-
 fs/ocfs2/dlmglue.c                                                             |    4 
 fs/ocfs2/file.c                                                                |   18 
 fs/ocfs2/inode.c                                                               |   37 -
 fs/ocfs2/journal.c                                                             |    3 
 fs/ocfs2/journal.h                                                             |    1 
 fs/ocfs2/super.c                                                               |   16 
 fs/ocfs2/xattr.c                                                               |  142 +++-
 fs/proc/generic.c                                                              |    5 
 fs/read_write.c                                                                |    8 
 fs/signalfd.c                                                                  |   28 
 fs/splice.c                                                                    |   12 
 fs/stat.c                                                                      |    6 
 fs/udf/super.c                                                                 |    5 
 fs/verity/open.c                                                               |   38 -
 include/linux/fault-inject.h                                                   |   10 
 include/linux/fs.h                                                             |    4 
 include/linux/libata.h                                                         |    1 
 include/linux/pci.h                                                            |    2 
 include/linux/pps_gen_kernel.h                                                 |    2 
 include/linux/rtc.h                                                            |    2 
 include/math-emu/op-common.h                                                   |   23 
 include/math-emu/soft-fp.h                                                     |    8 
 include/media/v4l2-ctrls.h                                                     |    6 
 include/net/addrconf.h                                                         |    3 
 include/net/inet_connection_sock.h                                             |    8 
 include/net/ip.h                                                               |   25 
 include/net/ip6_route.h                                                        |   37 -
 include/net/mptcp.h                                                            |    9 
 include/net/tcp.h                                                              |    7 
 include/trace/events/huge_memory.h                                             |    6 
 init/main.c                                                                    |    6 
 init/version.c                                                                 |    3 
 ipc/mqueue.c                                                                   |    7 
 ipc/msgutil.c                                                                  |    3 
 ipc/shm.c                                                                      |   23 
 kernel/bpf/queue_stack_maps.c                                                  |    3 
 kernel/cgroup/cgroup.c                                                         |    2 
 kernel/cpu_pm.c                                                                |    9 
 kernel/debug/gdbstub.c                                                         |   55 +
 kernel/fork.c                                                                  |    3 
 kernel/irq/internals.h                                                         |    1 
 kernel/irq/kexec.c                                                             |    2 
 kernel/irq/manage.c                                                            |   43 -
 kernel/panic.c                                                                 |    3 
 kernel/resource.c                                                              |    2 
 kernel/sched/cpufreq_schedutil.c                                               |   14 
 kernel/sched/fair.c                                                            |    7 
 kernel/seccomp.c                                                               |    7 
 kernel/sys.c                                                                   |    3 
 kernel/time/itimer.c                                                           |    2 
 kernel/time/namespace.c                                                        |    2 
 kernel/time/posix-cpu-timers.c                                                 |    4 
 kernel/time/timekeeping.c                                                      |    3 
 kernel/trace/ring_buffer.c                                                     |    2 
 kernel/ucount.c                                                                |   21 
 kernel/user_namespace.c                                                        |    5 
 lib/842/842_decompress.c                                                       |    7 
 lib/alloc_tag.c                                                                |    2 
 lib/buildid.c                                                                  |    4 
 lib/decompress_bunzip2.c                                                       |    6 
 lib/fault-inject.c                                                             |    7 
 lib/iov_iter.c                                                                 |    4 
 lib/kobject_uevent.c                                                           |    2 
 lib/plist.c                                                                    |    7 
 lib/stackdepot.c                                                               |    2 
 mm/damon/core.c                                                                |    8 
 mm/damon/paddr.c                                                               |    8 
 mm/damon/sysfs-schemes.c                                                       |    6 
 mm/damon/sysfs.c                                                               |   11 
 mm/damon/vaddr.c                                                               |    5 
 mm/execmem.c                                                                   |    4 
 mm/hugetlb.c                                                                   |   66 +
 mm/hugetlb_cgroup.c                                                            |   33 
 mm/khugepaged.c                                                                |    7 
 mm/ksm.c                                                                       |    5 
 mm/madvise.c                                                                   |   12 
 mm/memcontrol.c                                                                |   28 
 mm/memory.c                                                                    |   24 
 mm/mempolicy.c                                                                 |   14 
 mm/mlock.c                                                                     |    2 
 mm/mremap.c                                                                    |   33 
 mm/nommu.c                                                                     |    6 
 mm/page_alloc.c                                                                |   18 
 mm/page_isolation.c                                                            |   40 -
 mm/page_table_check.c                                                          |    4 
 mm/percpu.c                                                                    |    5 
 mm/shmem.c                                                                     |   11 
 mm/swap_state.c                                                                |   16 
 mm/truncate.c                                                                  |   33 
 mm/userfaultfd.c                                                               |    6 
 mm/vmscan.c                                                                    |   10 
 mm/zswap.c                                                                     |    5 
 net/bluetooth/6lowpan.c                                                        |    1 
 net/bluetooth/hci_debugfs.c                                                    |    9 
 net/bluetooth/l2cap_core.c                                                     |   41 -
 net/bluetooth/l2cap_sock.c                                                     |    4 
 net/ceph/mon_client.c                                                          |    3 
 net/ceph/osd_client.c                                                          |   13 
 net/ceph/osdmap.c                                                              |   16 
 net/core/dev.c                                                                 |    8 
 net/core/gro.c                                                                 |    4 
 net/core/skbuff.c                                                              |   13 
 net/ipv4/inet_connection_sock.c                                                |   19 
 net/ipv4/inet_hashtables.c                                                     |    5 
 net/ipv4/ipmr.c                                                                |    1 
 net/ipv4/netfilter/nf_reject_ipv4.c                                            |    5 
 net/ipv4/route.c                                                               |    4 
 net/ipv4/syncookies.c                                                          |    2 
 net/ipv4/sysctl_net_ipv4.c                                                     |    2 
 net/ipv4/tcp_cong.c                                                            |    4 
 net/ipv4/tcp_input.c                                                           |    6 
 net/ipv4/tcp_minisocks.c                                                       |   39 -
 net/ipv4/tcp_output.c                                                          |    7 
 net/ipv4/tcp_timer.c                                                           |    3 
 net/ipv6/addrconf.c                                                            |   46 -
 net/ipv6/inet6_hashtables.c                                                    |    4 
 net/ipv6/netfilter/nf_reject_ipv6.c                                            |    5 
 net/ipv6/reassembly.c                                                          |    1 
 net/ipv6/route.c                                                               |    2 
 net/mptcp/protocol.c                                                           |    9 
 net/mptcp/protocol.h                                                           |    6 
 net/mptcp/subflow.c                                                            |   35 -
 net/netfilter/nf_conntrack_netlink.c                                           |    8 
 net/packet/af_packet.c                                                         |   12 
 net/rds/ib_cm.c                                                                |    6 
 net/rds/ib_recv.c                                                              |   13 
 net/sctp/socket.c                                                              |   26 
 net/smc/smc_tx.c                                                               |    7 
 net/sunrpc/xprtrdma/rpc_rdma.c                                                 |   27 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                                       |    3 
 net/sunrpc/xprtrdma/verbs.c                                                    |    9 
 net/tipc/group.c                                                               |   19 
 net/tipc/socket.c                                                              |   12 
 net/unix/sysctl_net_unix.c                                                     |    4 
 net/xdp/xsk_buff_pool.c                                                        |    2 
 rust/Makefile                                                                  |    5 
 rust/bindgen_parameters                                                        |    5 
 rust/bindings/lib.rs                                                           |    1 
 rust/kernel/bitmap.rs                                                          |    2 
 rust/kernel/dma.rs                                                             |   21 
 rust/kernel/irq/request.rs                                                     |   22 
 rust/kernel/time/hrtimer.rs                                                    |    6 
 scripts/Makefile.autofdo                                                       |    2 
 security/apparmor/af_unix.c                                                    |   20 
 security/apparmor/file.c                                                       |   61 -
 security/apparmor/include/label.h                                              |    6 
 security/apparmor/label.c                                                      |    1 
 security/apparmor/match.c                                                      |    3 
 security/apparmor/policy.c                                                     |   16 
 security/apparmor/policy_unpack.c                                              |    9 
 sound/core/compress_offload.c                                                  |   32 
 sound/core/init.c                                                              |   12 
 sound/core/seq/oss/seq_oss_device.h                                            |    1 
 sound/core/seq/oss/seq_oss_event.c                                             |    3 
 sound/core/seq/oss/seq_oss_init.c                                              |    2 
 sound/core/ump_convert.c                                                       |    2 
 sound/drivers/aloop.c                                                          |   31 
 sound/drivers/mpu401/mpu401_uart.c                                             |    8 
 sound/drivers/mtpav.c                                                          |    2 
 sound/hda/codecs/hdmi/eld.c                                                    |    6 
 sound/hda/codecs/hdmi/hdmi.c                                                   |    3 
 sound/hda/codecs/realtek/alc269.c                                              |    3 
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c                                 |    5 
 sound/hda/codecs/via.c                                                         |    1 
 sound/hda/common/codec.c                                                       |    6 
 sound/hda/common/sysfs.c                                                       |    4 
 sound/mips/sgio2audio.c                                                        |   13 
 sound/oss/dmasound/dmasound_q40.c                                              |   65 -
 sound/pci/cs46xx/dsp_spos.c                                                    |    2 
 sound/soc/codecs/arizona-jack.c                                                |    1 
 sound/soc/codecs/hdac_hda.c                                                    |   16 
 sound/soc/codecs/lpass-wsa-macro.c                                             |   42 -
 sound/soc/codecs/pcm6240.c                                                     |    2 
 sound/soc/codecs/rt5682s.c                                                     |    4 
 sound/soc/codecs/rt712-sdca-dmic.c                                             |    4 
 sound/soc/codecs/tlv320aic32x4-clk.c                                           |    8 
 sound/soc/codecs/wcd9335.c                                                     |   25 
 sound/soc/codecs/wm8994.c                                                      |    3 
 sound/soc/codecs/wsa883x.c                                                     |   13 
 sound/soc/codecs/wsa884x.c                                                     |   11 
 sound/soc/fsl/fsl_xcvr.c                                                       |   26 
 sound/soc/intel/atom/sst/sst_acpi.c                                            |   14 
 sound/soc/qcom/qdsp6/q6afe.c                                                   |   10 
 sound/soc/qcom/qdsp6/q6apm.c                                                   |    1 
 sound/soc/sdw_utils/soc_sdw_rt711.c                                            |    1 
 sound/soc/ti/davinci-mcasp.c                                                   |    1 
 sound/synth/emux/emux.c                                                        |   10 
 sound/synth/emux/soundfont.c                                                   |    9 
 sound/usb/line6/capture.c                                                      |   25 
 sound/usb/line6/capture.h                                                      |    2 
 sound/usb/line6/playback.c                                                     |   31 
 sound/usb/pcm.c                                                                |   20 
 sound/usb/quirks.c                                                             |    2 
 tools/perf/arch/loongarch/util/header.c                                        |    2 
 tools/perf/util/machine.c                                                      |    2 
 tools/perf/util/powerpc-vpadtl.c                                               |    2 
 tools/testing/selftests/core/unshare_test.c                                    |   19 
 tools/testing/selftests/seccomp/seccomp_bpf.c                                  |  179 +++++
 virt/kvm/guest_memfd.c                                                         |   12 
 793 files changed, 7657 insertions(+), 2886 deletions(-)

Aamir Ahmed (4):
      clk: mvebu: ap-cpu-clk: Assign .num before accessing .hws
      clk: qcom: ipq-cmn-pll: Assign .num before accessing .hws
      lib: decompress_bunzip2: fix integer overflow in run-length decoding
      gve: fix out-of-bounds read in gve_get_flow_rule_entry()

Aaron Erhardt (1):
      platform/x86/tuxedo: Fix keyboard LED map ordering

Abdifatah Suruur (1):
      xen/gntdev: prevent private mappings from becoming writable

Abdun Nihaal (1):
      wifi: ath11k: Fix possible memory leak in ath11k_dp_srng_setup()

Adam Harshbarger (1):
      lib/plist: fix plist_requeue() corrupting order in the last bucket

Adrian Ambrozewicz (2):
      gpiolib: cdev: don't set GPIOD_FLAG_IS_OUT
      gpiolib: don't report -ENOMEM for a requested line without a label

Adrian Hunter (2):
      i3c: master: Fix out-of-bounds read in DMA bounce buffer setup
      i3c: mipi-i3c-hci: Bounce short reads irrespective of the IOMMU

Ahsan Atta (2):
      crypto: qat - initialise state_lock on every path in adf_devmgr_add_dev()
      crypto: qat - fix use of destroyed vf2pf_lock on VF restart

Alain Volmat (1):
      media: stm32: csi: correct remote pad retrieval

Aldo Ariel Panzardo (2):
      nilfs2: fix checkpoint root lifetime on sysfs errors
      crypto: nx - validate 'ignore' before subtracting in decompress

Alex Kazinsky (1):
      ASoC: tlv320aic32x4: Prevent division by zero in divider callbacks

Alex Markuze (1):
      ceph: fix uninitialized err in ceph_netfs_issue_read()

Alexander Kochetkov (1):
      Revert "Input: matrix_keypad - force switch rows to input mode"

Alexander Shiyan (1):
      media: synopsys: hdmirx: use request_any_context_irq() for 5V detection IRQ

Alexander Sverdlin (1):
      pwm: tiehrpwm: Clear period on disable to allow reconfiguration

Alexey Klimov (1):
      soc: samsung: exynos-pmu: fix error paths in cpuhotplug/idle states setup

Ali Resool Tuama (1):
      USB: quirks: add USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE for GameSir G7 SE

Amir Goldstein (2):
      fs: make sure to call fsnotify_inoderemove() only once when inode is dead
      fs: don't fail __d_obtain_alias() for unlinked inodes

Anastasios Papagiannis (1):
      mm/nommu: reject wrapping ranges in access_remote_vm()

Andi Shyti (1):
      media: cx231xx: Fix cleanup path on failure

Andrea Parri (6):
      iomap: don't lose a fiemap iteration error when emitting the last extent
      nvmet: zns: don't leak stale memory in zone management receive
      iommufd: Reject a zero-length dirty bitmap request
      nvmet-fc: only send read data for successful commands
      nvmet: pci-epf: report transport errors in command completions
      nvmet: pci-epf: require SGLs to match the command data length

Andrea Pesaresi (1):
      arm64: dts: mediatek: mt7986: correct timer frequency

Andrew Pam (1):
      power: supply: cros_charge-control: restore EC state on resume

Andrey Albershteyn (1):
      fsverity: hoist statx reporting of fs-verity flag

Antheas Kapenekakis (1):
      platform/x86: oxpec: Fix Apex charge limit control

Anup Vishwakarma (1):
      mailbox: qcom-ipcc: Guard against NULL con_priv in send_data()

Ard Biesheuvel (3):
      arm64/efi: Clear PTE_WRITE when applying EFI_MEMORY_RO
      efi/libstub: arm64: Don't use the platform register x18
      efi/libstub: Don't replace an existing LINUX_EFI_MEMRESERVE table

Armin Wolf (1):
      hwmon: (acpi_power_meter) Fix 18.45 TW bug

Arpith Alexander (1):
      spi: ljca: Don't require data in write replies

Avi Weiss (4):
      drm/amd/display: Initialize missing TD-LUT programming inputs
      irqchip/riscv-imsic: Report successful hardware retrigger
      irqchip/irq-msi-lib: Free wired MSI descriptors
      init/bootconfig: pass init arguments in documented order

Baek Kyu, Kim (3):
      hwmon: (sht4x) Reject incomplete heater command transfers
      hwmon: (sht3x) Return the consumed count for heater writes
      gpiolib: Free chip resources when allocating the label fails

Balakrishnan Sambath (6):
      media: microchip-isc: fix awb_mutex and lock lifecycle
      media: microchip-isc: synchronize the IRQ before disabling clocks on stop
      media: microchip-isc: disable histogram and flush AWB work on teardown
      media: microchip-isc: do not touch WB registers when not streaming
      media: microchip-isc: fix PM runtime leak in AWB work handler
      media: microchip-isc: don't sleep in the clk .is_enabled callback

Baokun Li (1):
      fscrypt: Fix missing barrier in fscrypt_find_mode_key()

Baolin Liu (1):
      isofs: fix Rock Ridge CE extent validation on multisession media

Bartu Alev (1):
      platform/x86: asus-wmi: fix TUF keyboard power state shutdown naming

Borislav Petkov (AMD) (1):
      x86/bugs: Mitigate TSA on AMD Zen5

Bradley Morgan (2):
      PM: CPU: Restore synchronize_rcu() to cpu_pm_unregister_notifier()
      panic: flatten nmi_panic control flow

Brandon Williams (1):
      power: supply: qcom_battmgr: Notify charger supplies of online changes

Breno Leitao (2):
      dcache: report a Tasks-RCU quiescent state in dentry_kill()
      mm/shmem: report RCU-tasks quiescent states while undoing a range

Bryam Vargas (1):
      net/smc: queue the copied chunk when smc_tx_sendmsg() faults

Bui Viet Dung (2):
      Bluetooth: 6lowpan: Pin module for 6lowpan_control debugfs file
      Bluetooth: hci_debugfs: Pin module for debugfs file operations

Caleb Kan (1):
      stackdepot: stop preallocating after the final pool

Cao Guanghui (2):
      md/raid5: track disks array size to fix extra_page leak on error paths
      md/raid5: fix NULL pointer dereference in raid5_free_percpu

Casey Connolly (1):
      drm/panel: ebbg-ft8719: Set prepare_prev_first

Cen Zhang (3):
      ocfs2/cluster: initialize heartbeat regions before publishing them
      ocfs2: snapshot the dentry name while tracing file release
      ocfs2/cluster: remove zero-address nodes from IP tree on teardown

Cen Zhang (Microsoft) (2):
      posix-cpu-timers: Fix pid refcount leak in do_cpu_nanosleep() signal path
      userfaultfd: fix UFFDIO_MOVE livelock on large folio with extra references

Chao Yu (2):
      f2fs: compress: fix to handle race between truncate and writeback
      f2fs: fix to update superblock crc in sanity_check_area_boundary()

Cheick Traore (1):
      iio: adc: stm32: fix minimum sampling time values

Chengfeng Ye (2):
      mm/ksm: mark migration stores with WRITE_ONCE()
      fuse: fix copy_file_range reply handling race

Chia-Yu Chang (1):
      tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion

Chris Mason (2):
      aio: fix NULL deref when a fault races ring truncation
      iov_iter: fix NULL deref in iov_iter_alignment()

Christian Brauner (5):
      statmount: don't copy the reserved empty string past the buffer
      listmount: don't wrap around with a U64_MAX cursor
      userns: don't drop the exec securebits
      proc: don't let an entry below /proc/<pid>/net be a mountpoint
      backing-file: enforce append-only and immutable backing inodes

Christian Marangi (1):
      i2c: mt7621: fix copying uninitialized kernel stack with reduced page_len

Chuck Lever (2):
      svcrdma: Grant credits from the clamped sc_max_requests
      exportfs: Release the get_name() directory file synchronously

Cong Nguyen (1):
      staging: media: imx: csc-scaler: fix ipu_image_convert_run leak on queue error

DAI RENJIE (1):
      resource: fix lost wakeup when waiting for a muxed region

Daeho Jeong (2):
      f2fs: convert inline quota files when turning quota on
      f2fs: disallow mmap write and data-modifying fallocate on atomic files

Daehyeon Ko (8):
      aio: prevent eventfd/epoll recursion on poll
      ipc/mqueue: release notification resources during inode eviction
      crypto: algif_skcipher - rewind rounded output bytes
      ipv6: remove ifaddr from hash during ifdown list cleanup
      ipv6: serialize address publication with device teardown
      ipv6: initialize temporary ifaddr before publication
      ipv6: do not restart DAD for a dead ifaddr
      splice: avoid stale f_pos writeback on error

Daejun Park (3):
      jbd2: don't advance j_fc_off before the buffer is recorded
      ext4: don't report delalloc data as a hole on indirect-mapped inodes
      nvmet: fix preempt of another registrant by the reservation holder

Damon Ding (1):
      drm/bridge: analogix_dp: Restore mandatory samsung DP DT properties

Daniel Phillips (1):
      amdkfd: Fix memory availability double accounting of kfd pinned objects

Daniel Schwierzeck (1):
      cpufreq: airoha: fix probe failure with correct error check

Danish Khateeb (2):
      pps: generators: don't use the driver's info after unregister
      pps: generators: stop the generator on unregister

David Carlier (1):
      ring-buffer: Take cpus_read_lock() when changing the subbuf order

David Cemin (1):
      ASoC: sdw_utils: clear stale RT711 device reference on exit

David E. Box (1):
      platform/x86/intel/vsec: Fix inverted walk_header() test in get_features()

David Heidelberg (5):
      mfd: Fix MAX77705 dependency on regmap
      mfd: wcd934x: set DMA mask on parent to silence "DMA mask not set"
      mfd: wcd934x: Fix NULL pointer dereference on IRQ probe deferral
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Extend the xbl_mem region
      arm64: dts: qcom: sdm845-xiaomi-polaris: Extend the xbl_mem region

David Hildenbrand (Arm) (2):
      mm/mremap: fix calling fixup_hugetlb_reservations() on the wrong VMA
      mm: disallow ioremap'ing ordinary RAM in generic_access_phys()

David Yang (1):
      net: hisilicon: hisi_femac: Stop the receiver before releasing the RX ring

Denis Arefev (1):
      ALSA: cs46xx: fix unit mismatch in DSP code area bounds check

Denis Benato (2):
      platform/x86: asus-wmi: fix unclear usage of bd->props.power
      platform/x86: asus-wmi: fix screenpad power state detection

Denis Efremov (Oracle) (2):
      floppy: don't store a stack buffer in timeout_message
      floppy: return the drive state flags from the 32-bit FDGETDRVSTAT

Devin Wittmayer (1):
      wifi: mt76: mt7925: cancel mlo_pm_work on the USB stop path

Diego Fernando Mancera Gomez (1):
      memory: stm32_omm: fix child clock leak on set_amcr() error path

Dmitry Torokhov (1):
      Input: always accept EV_SYN in input_event()

Dominik Maier (1):
      loop: check for read-write open mode on LOOP_SET_STATUS in lo_compat_ioctl()

Donggeun Yoo (2):
      PCI/DOE: Fix double free of a duplicate feature's sysfs name
      mm/damon/core: charge only the part of a region the filter left

Drobyshev Vladimir (1):
      USB: cdc-acm: add VeriFone VX820 device ID

Eason Lai (2):
      wifi: mt76: mt792x: fix UAF in SDIO TX path when out of memory
      wifi: mt76: fix memory leak in USB TX path

Edvard Conrad (1):
      fs: let backing files inherit FMODE_NONOTIFY from the user file

Elena Sakhnovitch (1):
      drm/amdgpu/gmc9: add extra type-2 TLB flush for gfx942/gfx950

Eric Biggers (1):
      fsverity: Be more careful with return value of ->get_verity_descriptor()

Eric Dumazet (2):
      dlm: fix send buffer backpressure handling
      ixgbe: reserve TX timestamp after skb preparation

Eric Kim (1):
      sched/fair: Reset NUMA fault locality after scan period update

Fabricio Akio (1):
      power: supply: qcom_smbx: set the charge enable after software control

Fan Wu (8):
      media: imx-jpeg: finish the job on device_run() error paths
      media: cx231xx-audio: drain wq_trigger before audio fini
      media: nuvoton: npcm-video: quiesce VCD IRQ before teardown
      power: supply: bq27xxx: Ensure poll work is cancelled on remove
      media: vivid: cancel svid ctrl work on release
      i3c: master: adi: free the IRQ before unregistering the master
      media: mediatek: vpu: free IRQ before destroying watchdog workqueue
      virtio_fs: read the vring size under virtio_fs_mutex in ->get_tree

Fang Xieyan (3):
      kgdb: Fix buffer overflow in the 'm' packet handler
      kgdb: Fix buffer overflow in the 'M' and 'X' packet handlers
      kgdb: Fix buffer overflow in the qRcmd packet handler

Felix Hoffmann (1):
      libceph: reject mismatched CRUSH weight-set sizes

Florian Fainelli (1):
      mailbox: bcm74110: Cap rx_svc_init_list growth to prevent PMC-induced OOM

Francesco Dolcini (5):
      arm64: dts: ti: k3-am62-verdin: Set MMC clock pins as OUTPUT
      arm64: dts: freescale: imx8mm-verdin-ivy: fix DIGI_1/DIGI_2 gpio-line-names
      arm64: dts: freescale: imx8mp-verdin-ivy: fix DIGI_1/DIGI_2 gpio-line-names
      arm64: dts: freescale: imx8mp-toradex-smarc: fix SMARC_SLEEP# gpio-line-names typo
      arm64: dts: freescale: imx8mp-verdin-yavia: fix external GPIOs

Francesco Orlando (1):
      Input: xpad - add GameSir Nova Lite support

Fuad Tabba (3):
      KVM: arm64: Validate the host vCPU's VM before reading it under pKVM
      irqchip/gic-v3-its: Don't clamp nvecs to zero when id_bits is 32
      KVM: arm64: Set HCR_EL2.BSU to Inner Shareable for guests

Gabor Juhos (2):
      clk: qcom: gcc-ipq5018: mark 'gpll0_main' clock as critical
      mtd: rawnand: qcom: fix read location register usage in config_nand_cw_read()

George Christidis (1):
      ALSA: hda/realtek: Fix headset mic on ASUS Zenbook 14 UX3402VA

Georgia Garcia (2):
      apparmor: don't revalidate inherited files under files->file_lock
      apparmor: remove fs entries created by a failed policy load

Geraldo Nascimento (3):
      PCI: rockchip-ep: Do not attempt 5.0 GT/s retraining
      PCI: rockchip-host: Do not attempt 5.0 GT/s retraining
      PCI: rockchip: Drive at 2.5 GT/s, error other speeds

Gergo Koteles (1):
      ALSA: hda/tas2781: Skip invalid TAS2563 UEFI calibration data

Ginger Li (1):
      media: exynos4-is: Fix a race between s_stream(0) and the interrupt handler

Greg Kroah-Hartman (4):
      media: adv7604: avoid negative array index in log_status when cp_read fails
      media: stv090x: bound DiSEqC reply length to msg[] size
      media: stv0900: bound DiSEqC reply length to msg[] size
      Linux 6.18.63

Gregory Price (4):
      mm/mempolicy: take a cpuset cookie for the interleave node count
      mm/madvise: reclaim isolated folios if PTE restart fails
      mm/madvise: use folio_trylock() in the cold/pageout PMD split
      rtc: cmos: Disable ACPI RTC event before handling it

Gregory Price (Meta) (2):
      mm/vmscan: reclaim every zone in per-node proactive reclaim
      mm/mempolicy: apply bind policies against the scoped allocation zone

Guanglei Zhu (2):
      ceph: fix out-of-bounds read in ceph_netfs_issue_op_inline()
      apparmor: check accept index + 1 is in bounds

Guangshuo Li (18):
      media: i2c: alvium-csi2: balance runtime PM usage count on remove
      media: i2c: ov2735: fix power cleanup on remove
      iio: accel: kxcjk-1013: Disable autosuspend on remove
      iio: accel: mma9551: disable autosuspend on remove
      iio: accel: mma9553: disable autosuspend on remove
      iio: adc: at91-sama5d2: disable autosuspend on remove
      crypto: omap-des - fix crypto engine cleanup
      media: atmel-isi: release unregistered video device on remove
      ASoC: Intel: atom: Fix platform device leak on probe failure
      mtd: rawnand: nuvoton: fix clock cleanup on probe failure
      media: tw686x: fix V4L2 device lifetime on probe failure
      media: rtl28xxu: fix SDR platform device leak
      media: chips-media: wave5: Check decoder qbuf runtime resume
      media: mediatek: vcodec: destroy core workqueue on remove
      media: mediatek: vpu: release reserved memory on remove
      platform/x86: simatic-ipc: fix platform device leak on registration failure
      irqchip/imx-intmux: Fix runtime PM teardown on remove
      PCI: qcom-ep: Deinitialize endpoint on remove

Guixin Liu (4):
      cxl/pci: Program the Port GPF timeouts before caching the DVSEC
      nvmet-fc: Tear down the association when the admin queue allocation fails
      nvmet: Finish the blk plug when integrity allocation fails
      nvmet: Free the old negotiation state when restarting authentication

Guixiong Wei (1):
      platform/x86/intel-uncore-freq: Continue restoring limits on resume

Gyokhan Kochmarla (1):
      erofs: use on-disk blkszbits for lz4 max pcluster bound

Hans de Goede (1):
      media: qcom: camss: Add "gcc_axi_hf" to 8775p VFE lite clock lists

Hao Ge (1):
      mm/alloc_tag: account for reserved tag ids in the kernel tag check

Harry Wentland (1):
      drm/amd/display: Force GAMCOR for subsampled surfaces with PQ/Gamma22/HLG

Harry Yoo (Meta) (1):
      mm/percpu: account full object size for percpu memory allocations

Hemanth Selam (1):
      ext4: skip extra isize expansion while unmounting

Hengyu Liang (1):
      btrfs: return -ENOTTY for unknown ioctls on the control device

Henrik Enquist (2):
      ALSA: aloop: Don't constrain playback params in notify mode
      ALSA: aloop: Update the PCM Slave controls for a matching playback

Henry Martin (2):
      drm/amdkfd: fix doorbell allocation race creating duplicate allocations
      tipc: fix broadcast sender hang on last acker departure

Hitesh Patel (3):
      media: qcom: camss: vfe-17x: Fix write master buffer done being dropped
      media: qcom: camss: vfe-17x: Fix write master selection for RDI lines
      media: qcom: camss: vfe: Fix VFE reset while another line is streaming

Hongfu Li (3):
      mm/hugetlb_cgroup: move per-node usage on cross node migration
      mm/hugetlb_cgroup: move per-node usage on cgroup reparenting
      mm/hugetlb: account migration target folio in per-node NR_HUGETLB vmstat

Honglei Huang (1):
      drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages

Hongling Zeng (1):
      ntfs3: fix mapping pairs bounds check for alignment

Hongyan Xu (1):
      mfd: da903x: Cancel IRQ work during teardown

Hsiu-Hsien Lee (1):
      ext4: fix fast commit replay failing on a read-only mount

Huacai Chen (7):
      cpufreq: loongson3: Make this driver depend on MACH_LOONGSON64
      cpufreq: loongson3: Adjust the width of id and val in smc_message
      cpufreq: loongson3: Replace per-package mutex with per-node
      cpufreq: loongson3: Use global physical CPU ID in get/target callbacks
      cpufreq: loongson3: Replace IOCSR read/write with MMIO ones
      LoongArch: Call cpu_final_simd() with pure_initcall()
      LoongArch: Use pa_to_nid()/nid_to_addrbase() rather than hard-code

Hui Peng (2):
      ata: libata-scsi: abort multi-sector pass-through commands when multi_count is 0
      seccomp: restore knotif->state when SECCOMP_ADDFD_FLAG_SEND is interrupted

Hui Su (1):
      cpufreq: schedutil: Serialize sugov_start() against rate limit updates

Hungyu Lin (4):
      compat: avoid double rounding in times()
      timers/itimer: Keep a nonzero value at CPU timer expiry
      time/namespace: Fix overflow when converting absolute deadlines
      fs: skip copy_file_range write limits when there is no data

HyeongJun An (3):
      remoteproc: elf_loader: Bound the section header table
      mtd: spi-nor: sfdp: check the length of the xSPI Profile 1.0 table
      mtd: spi-nor: sfdp: check the length of the SCCR map

Hyeontae Lee (2):
      fs/ntfs3: bound CreateAttribute asize against record_size in do_action
      fs/ntfs3: bound DeleteAttribute asize against rec->used in do_action

Hyunwoo Kim (1):
      inet: reject unhashed sockets during established lookups

Ibrahim Hashimov (1):
      fs/ntfs3: fix integer overflow in find_log_rec() causing OOB read

Ido Schimmel (1):
      ipmr: fully initialize the synthetic IP header in ipmr_get_route()

Igor Velkov (2):
      rtc: pcf8563: pass the driver data to the alarm interrupt handler
      genirq/kexec: Do not take the bus lock of an interrupt chip on the crash path

Imre Kaloz (2):
      PCI: Disable MSI for ULi M1575 EHCI controller
      PCI: Avoid D3 on PLX PEX 8532/8533/8548 downstream ports

Jack Boykin (1):
      platform/x86/amd/pmf: Fix power_supply refcount leak in amd_pmf_get_battery_prop()

Jake Labelle (1):
      nilfs2: validate directory position after llseek in readdir

Jakub Szczudlo (1):
      iio: adc: ti-ads1100: Fix incorrect reading when datarate changed in single mode

Jamal Hadi Salim (1):
      netdevsim: reject cls_bpf programs bound to another device

James Hilliard (1):
      mtd: rawnand: sunxi: reject ECC maximization on small pages

Jan Kara (1):
      udf: Make sure there's enough space for LVID implementation use field

Jean Delu (1):
      parisc: eisa_enumerator: Fix out-of-bounds reads of the EEPROM buffer

Jean-Baptiste Maneyrol (2):
      iio: imu: inv_icm42600: fix odr change not caught in certain cases
      iio: imu: inv_icm42600: force accel odr change when switching power mode

Jeffin Philip (1):
      media: vidtv: fix uaf in vidtv_bridge_on_new_pkts_avail

Jesse Zhang (6):
      drm/ttm: return an error when kmapping a BO without pages
      drm/amdgpu: reject ANONONLY userptrs that span multiple VMAs
      drm/amdkfd: don't drop an SVM CWSR reference that was never taken
      drm/amdgpu: reject CS chunks too large for kvmalloc()
      drm/amdkfd: split vram_pages of SVM ranges prefetched without a GPU mapping
      drm/amdkfd: evict the queues only once for CRIU PROCESS_INFO

Jiacheng Xu (1):
      kobject: fix out-of-bounds access in kobject_action_type()

Jiale Yao (16):
      iio: dac: ad5755: validate SPI match data
      iio: frequency: adf4377: reject devices without match data
      iio: imu: adis16400: validate SPI match data
      iio: potentiometer: x9250: reject devices without match data
      iio: pressure: bmp280: validate SPI match data
      iio: adc: ad7606: reject devices without match data
      iio: adc: max11205: reject devices without match data
      iio: adc: mcp3911: reject devices without match data
      iio: adc: ti-adc128s052: validate SPI match data
      iio: accel: adxl313: reject devices without match data
      iio: accel: adxl380: reject devices without match data
      cxl/acpi: Check ACPI companion before use
      wifi: mt76: mt7615: cancel reset work during unregister
      wifi: ath12k: validate MAC/PHY capability count before saving
      hwmon: (gigabyte_waterforce) reject short input reports
      drm/amdkfd: validate SRAT subtables before parsing

Jiaming Zhang (1):
      nilfs2: force clear dirty state when restoring from the shadow map

Jianyun Gao (3):
      dax: Return errors from dax_core_init()
      dax: fix dax_range_compare_iter() to use correct size and address offset
      dax: fix wrong error code returned from dax_dedupe_file_range_compare()

Jiawen Liu (1):
      media: amphion: fix runtime PM imbalance on probe failure

Jiayuan Chen (2):
      mm/swap: fix swap_cache_get_folio() returning a folio that left the swap cache
      bonding: fix out-of-bounds read of arp_ip_target

Jinjie Ruan (1):
      ext4: fix out-of-bounds read in ext4_get_group_info()

Jinmeng Zhou (1):
      mm/hugetlb: fix subpool minimum reservation rollback

Jiri Slaby (SUSE) (3):
      serial: 8250_exar: store the GPIO platform device in struct exar8250
      serial: 8250_lpss: do not touch uninitialized line in ehl_serial_exit()
      serial: 8250_omap: set priv->line before enabling the IRQ

Jiucheng Xu (1):
      f2fs: force out-place update for all writes on compressed file

Joanne Chang (1):
      f2fs: allow pinning empty compressed files

Joanne Koong (2):
      fuse: don't drop destination page cache on a zero byte copy reply
      fuse: don't launder folios of a bad inode

Joe Damato (1):
      mm: memcontrol: raise MEMCG_MAX for charges that fail without reclaiming

Johan Alvarado (1):
      spi: spi-qpic-snand: publish the ECC context to snandc->qspi

Johan Hovold (4):
      staging: greybus: uart: fix racy TIOCMIWAIT implementation
      USB: cdc-acm: fix urb leak on disconnect
      USB: serial: usb_wwan: fix urb leak on disconnect
      USB: serial: sierra: fix urb leak on write completion

John Fisher (1):
      drm/amdgpu: wait for pending page table updates before switching a VM to CPU updates

John Johansen (3):
      apparmor: fix refcount leak in aa_get_newest_profile()
      apparmor: fix uninitialized variable warning in aa_inherit_files
      apparmor: on failed load ensure profile files are removed before parent

Josef Bacik (4):
      aoe: pull in the headers each received packet type reads
      net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()
      mm/hugetlb: don't clear the resv_map of a VMA whose lock is held
      mount: refuse setns() with a shared fs_struct again

Joseph Qi (10):
      ocfs2: exit recovery thread on mount error path
      ocfs2: free replay slots in ocfs2_recovery_exit()
      ocfs2: restrict OCFS2_INVALID_SLOT suballoc slot to system inodes
      ocfs2: skip uninitialized lockres in ocfs2_mark_lockres_freeing()
      ocfs2: reserve metadata for a new xattr block and its value tree
      ocfs2: reserve value tree metadata when moving an xattr into the inode
      ocfs2: deal with legacy signed dir index name hash values
      ocfs2: use the stored hash when checking xattr bucket collision
      ocfs2: deal with legacy signed xattr name hash values
      ocfs2: read the xattr entry hash before defragmenting the bucket

Juan Perdomo (1):
      media: cx231xx: preserve I2C transfer length

Judith Mendez (11):
      arm64: dts: ti: k3-am62a: Fix MMC0_CLK register address
      arm64: dts: ti: k3-am62a7-sk: Set eMMC clock pin as OUTPUT
      arm64: dts: ti: k3-am62a7-sk: Set SD clock pin as OUTPUT
      arm64: dts: ti: k3-am62a-phycore-som: Set eMMC clock pin as OUTPUT
      arm64: dts: ti: k3-am62-lp-sk: Set eMMC clock pins as OUTPUT
      arm64: dts: ti: k3-am62-pocketbeagle2: Set SD clock pin as OUTPUT
      arm64: dts: ti: k3-am625-beagleplay: Set MMC clock pins as OUTPUT
      arm64: dts: ti: k3-am62x-sk-common: Set SD clock pin as OUTPUT
      arm64: dts: ti: k3-am625-sk-common: Set eMMC clock pin as OUTPUT
      arm64: dts: ti: k3-am62-phycore-som: Set eMMC clock pin as OUTPUT
      arm64: dts: ti: k3-am62x-phyboard-lyra: Set SD clock pin as OUTPUT

Julian Braha (1):
      media: marvell-cam: fix unmet dependency for VIDEO_MMP_CAMERA

Julian Sun (2):
      writeback: reset dirtied_when when switching wbs
      writeback: clear old wb dirty state after inode switches

Junjie Cao (1):
      ASoC: rt712-sdca-dmic: fix drvdata type in the gain controls

Junrui Luo (4):
      media: vicodec: fix out-of-bounds write on under-rounded coded dimensions
      media: vicodec: make encoder CAPTURE dimensions read-only
      media: vicodec: zero-initialize stateful decoder heap buffers
      media: vicodec: fix NULL deref on oversized frame

Justin Chen (2):
      memory: brcmstb_dpfe: Fix out-of-bounds access due to DCPU offset
      memory: brcmstb_dpfe: Bounds check DCPU-supplied MSG_ARG_COUNT

Jérémy Jean (5):
      nvmet-auth: serialize access to DH-HMAC-CHAP state to fix UAF
      crypto: ecc - Handle exceptional points in Shamir multiplication
      nvmet: free the bvec on file namespace range errors
      ceph: fix 32-bit overflow in readdir reply count check
      libceph: fix out-of-bounds reads from repeated CRUSH bucket entries

Kaho Jiang (1):
      media: em28xx: fix double free in em28xx_alloc_urbs

Kaixuan Li (1):
      f2fs: check every cur_*_segno[] entry on readonly images

Kamil Sawicki (1):
      net: limit priority VLAN untag depth

Karl Mehltretter (21):
      microblaze: Fix MB_MANAGER build with older binutils
      fs_pin: publish pins with RCU list helpers
      ACPI: pfr_update: zero-initialize capability query result
      crypto: atmel-tdes - zero-initialize device state
      crypto: atmel-aes - fix AADLENR for standalone GHASH
      lib/842: reject output overflows from index and short data
      lib/842: require a complete history block for repeat templates
      crypto: atmel-tdes - sync output bounce buffer before DMA
      fpga: Fix of_fpga_mgr_get() reference in fpga_mgr_lock() docs
      crypto: qat - zero the VF migration state buffer on save
      KVM: arm64: vgic-v3: Undo assignment on iodev registration failure
      KVM: arm64: vgic-v3: Roll back assignments from the new region
      fork: honor task_struct's declared alignment
      sh: intc: Sort the prio and sense lists after filling them
      ARM: 9488/1: smp: set current pointer in assembly before jumping into C
      ARM: 9491/1: alignment: restore uaccess state on emulation fault
      ARM: 9520/1: cacheinfo: avoid out-of-bounds write in populate_cache_leaves()
      ARM: 9521/1: cacheinfo: count external caches in early_cache_level()
      ARM: 9522/1: cacheinfo: guard the CLIDR read in populate_cache_leaves()
      ARM: 9523/1: topology: allocate the cacheinfo early on the boot CPU
      irqchip/atmel-aic[5]: Disable interrupts in the irq_pm_shutdown() callbacks

Kathiravan Thirumoorthy (3):
      arm64: dts: qcom: ipq9574: Wire up USB3 PHY PIPE clock to GCC
      clk: qcom: ipq5018: add 24MHz rate for USB UTMI clock
      clk: qcom: ipq5332: add 24MHz rate for USB UTMI clock

Kazuki Hanai (1):
      tmpfs: fix unicode_map leaks in casefold option handling

Kees Cook (1):
      ipc, msg: Account msg_msg allocations with GFP_KERNEL_ACCOUNT again

Keita Morisaki (1):
      drm/amd/display: Fix swap in median3() for DSC rate control

Keng-Yu Lin (1):
      PCI/PM: Restore BARs after powering up during enumeration

Kevin Wang (1):
      drm/amd/pm: reapply umd profile state after recovery

Khasar Munkh-Erdene (1):
      staging: rtl8723bs: fix spacing around operators in rtw_recv.c

Kim Phillips (1):
      x86/bugs: Fix CONFIG_MITIGATION_RETPOLINE=n mitigation reporting

Kir Kolyshkin (1):
      cgroup: fix cgroup.kill for exited thread group leader

Koichiro Den (4):
      xen/privcmd: Only claim ioreqs matching an ioeventfd
      cxl/port: Convert PCIe link latency to nanoseconds
      cxl: Account for link width in latency calculation
      cxl/acpi: Convert QTG _DSM latencies to picoseconds

Konstantin Khorenko (1):
      selftests/core: fix unshare_test with large fs.nr_open

Krzysztof Karas (1):
      iommu/dma: Catch scatterlist length overflows

Krzysztof Kozlowski (3):
      drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure
      drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
      drm/msm/hdmi_bridge: Correct poweroff/audio cleanup order in post_disable

Krzysztof Wilczyński (1):
      PCI/sysfs: Pass the device name length in UTF-16 code units

Kunhai Dai (1):
      blk-iocost: abort weight transfer on invalid donation weights

Kuniyuki Iwashima (1):
      tcp: Remove timeout arg from reqsk_timeout().

Kyle Zeng (4):
      affs: validate blocks before freeing them
      netfilter: nf_reject: initialize IPCB at inet ingress
      net/packet: check TX_RING fragments before memory accounting
      tcp: fix reordering addition overflow in MTU probing

Lad Prabhakar (1):
      memory: renesas-rpc-if: Mark XSPI_CDD1BUF0 as volatile

Laxman Acharya Padhya (1):
      wifi: rtw89: cap firmware section_num before parsing

Li RongQing (1):
      apparmor: avoid potential double free when remapping DFA tables

Linkai Gong (1):
      media: i2c: tc358743: add missing color-space strings

Linlin Yang (1):
      wifi: mt76: mt7996: fix PCI device reference leak in mt7996_pci_init_hif2()

Linmao Li (3):
      media: chips-media: wave5: Handle polling IRQ thread failure
      media: chips-media: wave5: Balance runtime PM on encoder close errors
      r8152: Use BMSR to detect the link state

Linus Walleij (2):
      power: supply: ab8500_fg: Accept status from supplied power
      power: supply: ab8500_fg: Report sub-percent charge changes

Liu Chao (2):
      usb: fotg210: validate endpoint index in ep0 handlers
      net: wwan: iosm: validate msg_head before indexing msg_ring

Longlong Xia (2):
      mm/zswap: publish the initial pool with list_add_rcu()
      mm/zswap: enable zswap_ever_enabled in zswap_pool_create()

Lorenzo Stoakes (ARM) (7):
      fbdev: ssd1307fb: check for fb_deferred_io_init() error
      fbdev: xen-fbfront: check for fb_deferred_io_init() error
      fbdev: udlfb: check for fb_deferred_io_init() error
      fbdev: smscufx: check for fb_deferred_io_init() error
      fbdev: sh_mobile_lcdc: check for fb_deferred_io_init() error
      mm/mremap: populate calculated fields in vrm state correctly
      mm/mremap: correctly uncharge accountable VMAs in error path

Lu Baolu (1):
      iommu/vt-d: Avoid out-of-range shift in qi_desc_dev_iotlb_pasid()

Lucas Costa (1):
      spi: bcm2835: fix device_node reference leak in bcm2835_spi_setup()

Lucas Sinn (1):
      media: synopsys: hdmirx: fetch colordepth before calculating pixelclock

Luigi Lauro (2):
      drm/amdgpu: require _PR3 for BOCO
      drm/amd/display: take a runtime PM reference only when a CRTC turns on

Luis Gerardo Lopez Hernandez (1):
      ALSA: hda/realtek: Fix internal speakers on Acer Aspire AL16-31P

Luxiao Xu (1):
      mm/memory: constrain generic_access_phys() to page boundary

Ma Ke (4):
      ASoC: wcd9335: Fix device reference leak in wcd9335_slim_status()
      pinctrl: stm32: Fix fwnode reference leak in stm32_gpiolib_register_bank()
      platform/x86/amd/pmc: Fix RTC reference leak in amd_pmc_verify_czn_rtc()
      i2c: acpi: Fix adapter reference leak in i2c_acpi_new_device_by_fwnode()

Maciej Kucharek (3):
      drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0
      drm/amdgpu: reset CIK ASIC on Apple boards with VRAM at 0
      drm/amdgpu: reset VI ASIC on Apple boards with VRAM at 0

Maciej W. Rozycki (1):
      PCI: Skip Target Speed quirk on clamped ports with no link

Magnus Lindholm (10):
      alpha: load the MMU context when switch_mm() switches the current task
      alpha: run check_mmu_context() from finish_arch_post_lock_switch()
      alpha: only use a targeted tbi() when the target mm is really current
      alpha: invalidate the local context in flush_tlb_page()
      alpha: fix the local TLB invalidate in flush_tlb_page()
      alpha: fix the local TLB invalidate in the UP flush_tlb_page()
      alpha: invalidate the local context in flush_tlb_mm()
      alpha: invalidate the local context in flush_icache_user_page()
      alpha: do not clear remote MMU contexts in migrate_flush_tlb_page()
      alpha: do not skip TLB shootdown IPIs for kthread-borrowed mms

Marc Zyngier (3):
      KVM: arm64: Move OUTSIDE_GUEST_MODE publication past context being saved
      KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded
      KVM: arm64: Turn vcpu->arch.pause into a counter

Marco Crivellari (1):
      nvmet: replace use of system_wq with system_percpu_wq

Marek Czernohous (4):
      drm/nouveau/pci: use config-space MSI rearm on MCP79/MCP7A (NVAC)
      drm/nouveau: disable the fence uevent work instead of just cancelling it
      drm/nouveau: cancel the DP IRQ work before freeing the connector
      drm/nouveau: don't dereference outp before checking it in nouveau_dp_irq

Mario Limonciello (4):
      platform/x86/amd/pmf: Validate the APTS state index
      platform/x86/amd: Stop counting intermediate cycles with metrics table
      platform/x86/amd: hfi: Fix out-of-bounds reads when parsing ranking data
      drm/amd/display: don't WARN when removing an unallocated MST payload

Mark Anthony Agarro (2):
      wifi: mt76: mt76x02: validate TX-status rate index before mac80211 handoff
      wifi: mt76: mt7615: do not tear down BSS/STA state for monitor vifs

Martin Belanger (2):
      nvme: make the DH-HMAC-CHAP secret attributes readable by root only
      nvme-tcp: start error recovery when read_sock fails

Martin Wilck (1):
      md/raid5: validate payload size before calculating payload_len

Mathias Nyman (1):
      xhci: Prevent invalid vdev dereference during sideband unregister

Matt Fleming (2):
      iommu/amd: Program device table when kdump reuse fails
      iommu/amd: Don't allocate kdump device table from DMA32

Matt Turner (3):
      lib/decompress_bunzip2: fix off-by-one in run-length bounds check
      alpha: handle VM_FAULT_HWPOISON in do_page_fault()
      alpha: determine tininess after rounding in the FP emulation

Matthew Sakai (2):
      dm vdo indexer: prevent delta list overflow on load
      dm vdo indexer: validate record page numbers better

Matthias Goergens (1):
      fanotify: report names longer than NAME_MAX

Maurizio Casciano (1):
      power: supply: core: Honor supplied-from with CONFIG_OF=y

Max Kellermann (1):
      ceph: avoid pending truncate during nonblocking cap acquire

Maxim Skokov (1):
      media: vivid: round the height down to the vertical subsampling factor

Maxime Bélair (1):
      apparmor: fix NULL ctx->peer derefs in unix socket ctx updates

Michael Freidkin (1):
      media: meson: vdec: size capture planes from the aligned canvas

Michael J. Ruhl (1):
      platform/x86/intel/pmt: Block mmap when callback is present

Michael Kelley (1):
      Documentation: hyperv: Update documentation for sending VMBus packets

Michael Liang (1):
      fault-inject: fix dentry leak

Michael Wyraz (1):
      USB: serial: option: add support for ASR 1286:4e3c modem

Michail Tatas (1):
      media: verisilicon: rockchip: Fix leaks in init

Michal Pecio (1):
      usb: xhci: Fix bounce buffer overflow

Miguel Ojeda (1):
      rust: bitmap: fix intra-doc link

Mike Rapoport (Microsoft) (2):
      x86/mm/pat: Use pr_warn() for early W^X warnings
      mm/execmem: free ROX cache chunks only when they span an entire vm area

Mikulas Patocka (9):
      dm: fix a bug in dm_accept_partial_bio
      dm-writecache: report I/O error if flush failed
      dm-writecache: fix a quirk in statistics
      dm-writecache: fix a crash if we attempt to use non-dax device
      dm-writecache: fix uncommitted_blocks underflow
      dm-writecache: fix REQ_FUA processing
      dm-snapshot: fix crash if dm_io_client_create fails
      dm-bufio: fix non-working memory limit
      dm-bufio: fix a race leading to an unsigned integer underflow

Ming Lei (2):
      ublk: reset the FETCH round in release also without a disk
      ublk: reset the FETCH round under ub->mutex

Miquel Raynal (2):
      mtd: spi-nor: Unprepare legacy controllers upon RWW wait interruption
      dt-bindings: clock: ma35d1: Document the missing crystal inputs

Mohamad Raizudeen (1):
      crypto: amlogic - Fix IRQ handler return value and fallthrough logic

Muhammad Bilal (8):
      platform/x86: hp-bioscfg: fix slab-out-of-bounds write in hp_convert_hexstr_to_str()
      platform/x86: hp-bioscfg: fix 16-byte heap overflow for empty auth token
      platform/x86: hp-wmi: fix heap OOB read and memory corruption in hp_wmi_perform_query()
      platform/x86: hp-bioscfg: fix OOB reads in hp_get_string_from_buffer()
      platform/x86: hp-bioscfg: fix non-ASCII truncation in hp_get_string_from_buffer()
      platform/x86: hp-bioscfg: return -E2BIG from validate_password_input()
      platform/x86: hp-bioscfg: allow clearing current_password
      platform/x86: hp-bioscfg: NUL-terminate the SPM auth token

Myeonghun Pak (15):
      media: stm32: csi: unregister async notifier on cleanup
      leds: ktd2692: Pass context to regulator cleanup
      media: marvell: manage the MMP camera clock provider
      media: go7007: unregister the I2C adapter on USB probe failure
      media: cx18: Disable PCI device on probe failure
      media: tw68: balance PCI enable on cleanup
      ASoC: fsl_xcvr: free IRQ before canceling reset work
      mtd: maps: pci: balance PCI enable on cleanup
      media: amphion: drain message work before releasing core state
      media: amphion: prevent unbind while video instances are open
      ASoC: codecs: rt5682s: disable jack detection work on shutdown
      wifi: mt76: mt7615: restore DBDC state after ext PHY failure
      soc: fsl: dpio: Fix cleanup on IRQ registration failure
      soc: fsl: dpio: Free the IRQ before releasing the I/O object
      fbdev: kyro: Release WC setup on registration failure

Nanzhe Zhao (2):
      f2fs: remove mappedtodisk flag usage in mmap write path
      f2fs: read i_size once in f2fs_vm_page_mkwrite

Nas Chung (1):
      media: v4l2-common: Fix P010 format info

Nathan Chancellor (2):
      wifi: brcmsmac: Adjust txpwrindex value in nphy_ipa_rxcal_gaintbl_2GHz
      kbuild: AutoFDO: Update split machine function argument for upstream rename

Navon John Lukose (1):
      i2c: designware: queue only one read command for block reads

Nguyen Ngoc Thang (1):
      net/rds: ib: don't enable IRQs in rds_ib_conn_free()

Nickolai Zeldovich (4):
      lib/buildid: reject file offsets that do not fit in pgoff_t
      ucount: take the rlimit reference before checking the limit
      mm/mlock: use a long for the page count in mlock_fixup()
      mm/truncate: fix the zeroing end of pagecache_isize_extended()

Nicolai Buchwitz (2):
      serial: amba-pl011: honour delay_rts_before_send for every write
      serial: amba-pl011: keep transmitter enabled when disabling RS485

Niklas Cassel (4):
      ata: ahci_st: Do not ignore errors when getting the reset controls
      ata: ahci_st: Assert the power down reset in the probe() error path
      ata: libahci: Free the IRQs when activating a multi-IRQ host fails
      ata: libata: Do not leave ata_host_stop() registered when activation fails

Nikolaj Klitlund Børty (1):
      Bluetooth: btusb: Add device ID for Realtek RTL8761BUE (StarTech AV53C1)

Nirmoy Das (1):
      blk-mq: clear stale inactive flag on hctx reuse

OGAWA Hirofumi (1):
      fat: fix fat_ent_write() for reverting the value

Oleg Nesterov (1):
      signalfd: don't dequeue the forced fatal signals

Olivier Kaloudoff (2):
      ALSA: usb-audio: Add mic resolution quirk for Logitech Webcam C200
      drm/amdkfd: stop restore retries on device unplug

Orgad Shaneh (3):
      mtd: cfi_cmdset_0002: cap the write-buffer chunk at 256 bytes on an x8 device
      MIPS: mm: align hugetlb mappings in arch_get_unmapped_area()
      MIPS: mm: do not write a huge TLB entry when the probe misses

Paolo Abeni (1):
      mptcp: fix subflow bitfield misuse

Paul Moses (1):
      xsk: restore UMEM flags after failed pool assignment

Pedro Falcato (1):
      mm/madvise: atomically clear the young bit on THP MADV_COLD

Pei Xiao (3):
      tpm: tpm_nsc: fix NULL pointer dereference on init failure
      tpm: tpm_nsc: stop using the cleanup callback as dev.release
      tpm: fix zero-length read discarding the pending response

Pengpeng Hou (2):
      media: cec: extron: clear response tail before dispatch
      media: mediatek: jpeg: retry HW selection after successful wait

Peter Ujfalusi (9):
      ALSA: hda/hdmi: clamp num_cvts against cvt_nids[] in hdmi_read_pin_conn
      ALSA: hda/hdmi: clamp sad_count in ELD proc write handler
      ALSA: compress: fix buffer leak on failed SET_PARAMS
      ALSA: compress: reject buffer geometry change on gapless next_track
      ALSA: compress: add missing OPEN-state gate to SET_METADATA
      ALSA: compress: reject restarting an ACTIVE task via origin_seqno
      ALSA: hda: Reject codec reset on ASoC (ext_ops) buses
      ASoC: hdac_hda: Balance the runtime PM disable in codec remove
      ASoC: hdac_hda: Keep runtime PM state in sync across codec remove/probe

Pin-Hao Chen (1):
      spi: stm32: fix double free of SRAM buffer on MDMA fallback

Piotr Kubik (1):
      netfilter: ctnetlink: fix inverted IPv6 address match in dump filter

Piyush Patle (1):
      media: vidtv: fix frontend reference leak on unbind

Priyank Rathod (1):
      PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overflow

Pufan Jin (1):
      spi: zynq-qspi: fix address buffer corruption and support 4-byte address

Punnay Sharma (2):
      staging: media: av7110: fix corrupted BER reporting in sp8870
      staging: media: av7110: fix sp8870 initialization failure state

Qi Xi (2):
      mm/page_isolation: fix UBSAN shift-out-of-bounds warning
      mm/page_isolation: guard compound_order() against racing

Quanye Yang (1):
      mptcp: reset msk state on early connect failure

Radiy Zhambakiev (3):
      mfd: tps65217: Fix NULL pointer dereference on IRQ init failure
      mfd: tps65217: Check return value when masking interrupt sources
      mfd: tps65217: Use devres for IRQ domain and wake teardown

Ramin Moussavi (3):
      microblaze: reserve the ABI argument-home area in the signal frame
      microblaze: don't clobber r3/r4 restored by rt_sigreturn
      microblaze: restore the ABI argument home area below pt_regs (PTO)

Raphael Zimmer (2):
      libceph: Fix unsafe decode in ceph_redirect_decode()
      libceph: Fix multiple unsafe decodes in ceph_oloc_decode()

Ratnaker Gautam (1):
      scsi: libiscsi_tcp: Prevent R2T range check overflow

Reinhard Speyerer (1):
      USB: serial: option: add Rolling Wireless RN947R

Ricardo Neri (1):
      hwmon: (coretemp) Refresh the temperature on the first read

Richard Weinberger (1):
      mtd: Call get_wunit() on the master partition

Ridham Khurana (1):
      hwmon: (lm95245) Fix negative temperature conversion

Rik van Riel (1):
      mm/page_alloc: count guard pages as free again when their buddy merges

Robin Snyders (5):
      power: supply: qcom_smbx: include base when petting watchdog
      power: supply: qcom_smbx: test battery health status bits
      power: supply: qcom_smbx: fix float voltage selector
      power: supply: qcom_smbx: validate battery float voltage
      power: supply: qcom_smbx: notify battery overvoltage recovery

Rohinthan P (1):
      media: v4l2-ctrls: do nothing if controls[0] == NULL in cluster functions

Ross Lagerwall (1):
      xen-blkfront: Fix IO race during unplug

Ruide Cao (1):
      mptcp: hold MP_JOIN msk ref when cloning reqsk

Runyu Xiao (19):
      hte: tegra194: Initialize slice locks before registering chip
      media: saa7146: Initialize interrupt lock before requesting IRQ
      dmaengine: altera-msgdma: initialize state before requesting IRQ
      hte: tegra194-test: shut down timer before GPIO release
      crypto: ccp - Initialize DBC ioctl mutex before registering device
      PCI: pciehp: Make 'pciehp_poll_mode' parameter read-only
      media: adv7180: Initialize mutex before ancillary clients
      peci: aspeed: Initialize state before requesting IRQ
      peci: npcm: Initialize state before requesting IRQ
      ALSA: mpu401: shut down timer before freeing MPU
      ALSA: sgio2audio: Only free successfully requested IRQs
      m68k: dmasound: Keep the Q40 IRQ handler registered
      ASoC: pcm6240: do not free an unrequested IRQ
      IB/hfi1: Shutdown self-rearming timers before freeing
      block: amiflop: synchronize flush timer before track flush
      media: sti: delta: use unaligned accessors for MJPEG SOF fields
      perf: xgene: initialize lock before requesting IRQ
      mailbox: altera: shut down RX polling timer on channel teardown
      sh: maple: Use the matching IRQ cookie when invoking free_irq()

Ruoyu Wang (1):
      media: au0828: Free URBs when starting DVB streaming fails

Ryusuke Konishi (3):
      nilfs2: fix deadlock between nilfs_evict_inode() and find_inode()
      nilfs2: clear dirty flag on bdev buffers on log write failure
      nilfs2: ignore non-fatal signals during synchronous log write wait

SJ Park (6):
      mm/damon/paddr: respect folio end for DAMOS_STAT
      mm/damon/paddr: respect folio end for DAMOS actions except STAT
      mm/damon/vaddr: respect folio end for DAMOS_STAT
      mm/damon/core: handle extreme memory state in damon_get_node_mem_bp()
      mm/damon/sysfs: set next refresh jiffies per sysfs context
      mm/damon/sysfs-schemes: read sysfs_filter->addr_range only once

Sahaj Chaudhari (2):
      gpio: davinci: Clear interrupt status in every bank on suspend
      gpio: pca953x: Handle direction register read errors in IRQ paths

Sakari Ailus (1):
      platform/x86: int3472: Fix uninitialised variable warning

Sam Price (1):
      microblaze: preserve the MSR carry flags across signals

Sami Tolvanen (3):
      rust: irq: declare cfi_encoding for irqreturn
      rust: hrtimer: declare cfi_encoding for hrtimer_restart
      rust: dma: declare cfi_encoding for dma_data_direction

Samuel Thibault (1):
      speakup: Fix NULL pointer dereference on VT switch + selection

Sanan Hasanov (1):
      hwmon: (corsair-cpro) Make wait_input_report_lock IRQ safe

Sasha Levin (1):
      cgroup: don't kill migrated processes through their exiting threads

Sean Christopherson (2):
      KVM: VMX: Formally define KVM's "0xdead" exit reason used for failed VM-Enter
      KVM: guest_memfd: Gracefully handle xarray errors when binding a memslot

Sean Young (12):
      media: streamzap: Add missing rc_unregister_device()
      media: redrat3: Ensure we don't read beyond the end of the packet
      media: redrat3: Ensure all urbs are suspended
      media: sunxi-cir: Ensure no more interrupts can occur before free
      media: meson-ir-tx: Ensure clock is disabled on unbind
      media: meson-ir-tx: Ensure rc_free_device() is called on unbind
      media: meson-ir-tx: Ensure probe error is propagated
      media: ir-hix5hd2: Ensure rdev is setup before interrupts are enabled
      media: ene_ir: Ensure teardown is done in the correct order
      media: serial_ir: Fix race condition where timer can be re-armed
      media: ir_toy: Validate the maximum tx carrier
      media: meson-ir-tx: Prevent divide by zero in meson_irtx_prepare_pulse()

Seiji Nishikawa (1):
      nvme-tcp: fix io_work priority inversion when send_mutex is held

Seongjae Jeong (1):
      f2fs: fix submit accounting for IPU writeback

Seongjun Hong (1):
      vfio/mlx5: Fix boundary check in set_report_output()

Sergey Senozhatsky (1):
      ext4: fix ABBA deadlock in ext4_rmdir()

Serin Yeh (2):
      media: i2c: ov8856 : remove ACPI node bypass mechanism
      media: i2c: ov8856: fix debug message to report actual CSI-2 lane count

Seung Min Shin (1):
      sctp: hold transport reference across connect wait

Seungjin Bae (1):
      usb: typec: ucsi: ccg: Validate altmode index in GET_CURRENT_CAM response

Shao Mingyin (1):
      nvmet-auth: fix error handling on CHALLENGE failure

Shehryar Ahmad (1):
      iio: accel: adis16201: fix channel order for buffer mode

Shengming Hu (1):
      cpufreq: conservative: Restrict deferred downscaling to low load

Shengzhuo Wei (2):
      media: go7007: bound EZ-USB I2C transfers to the usb_buf size
      power: supply: bq27xxx: synchronize work cancellation on suspend

Shubham Antil (1):
      RDS/IB: validate receive fragment completions

Siddharth Chintamaneni (1):
      mm: multi-gen LRU: fix NULL lruvec->pgdat deref with memcg disabled on cmdline

Sinan Turunc (1):
      ALSA: usb-audio: Bound packet copies by the PCM buffer size

Siwei Zhang (3):
      Bluetooth: L2CAP: Reject mode changes on connected channels
      Bluetooth: L2CAP: Reject invalid TxWindow in configuration requests
      Bluetooth: L2CAP: Use default TxWindow for zero socket option

Sorah Fukumori (1):
      net: gro: don't chain linear parts larger than gso_size into frag_list

Srinivas Kandagatla (3):
      ASoC: codecs: lpass-wsa-macro: use v2.5 Compander1 addresses on v2.5+
      ASoC: codecs: wsa884x: Accept temperatures across the full trim range
      ASoC: codecs: wsa883x: Accept temperatures across the full trim range

Srish Srinivasan (5):
      pseries/plpks: fix error handling in plpks_read_var()
      pseries/plpks: validate input to plpks_signed_update_var()
      pseries/plpks: clear sensitive PLPKS buffers
      pseries/plpks: clear signed update authentication buffer
      pseries/plpks: clear SED key data after use

Stanley Jhu (5):
      scsi: ufs: bsg: Complete the job on error
      scsi: ufs: bsg: Clear the reply buffer before use
      scsi: ufs: core: Clear stale UIC result byte before peer DME retries
      scsi: ufs: core: Remove an always-false WARN_ONCE()
      scsi: ufs: core: Remove completed-without-interrupt path in ufshcd_abort()

Stian Halseth (1):
      PCI: Set supported_speeds in set_pcie_port_type()

Suman Kumar Chakraborty (1):
      crypto: qat - fix error source for QAT GEN6 transmit interface faults

Sung Byeongchan (1):
      nvmet: require authentication before property set

Takashi Iwai (5):
      ALSA: core: Check shutdown flag at D0 power-state, too
      ALSA: ump: Correct return size of fill_rpn()
      ALSA: seq: oss: Skip events until fully initialized
      ALSA: emux: Stop voices before freeing zones in all cases
      ALSA: line6: Handle period elapsed calls outside the locks

Takashi Sakamoto (1):
      firewire: core: fix source bus ID detection for AT context in big-endian systems

Tal Zussman (1):
      gfs2: fix the escaped block copy in gfs2_before_commit()

Tharit Tangkijwanichakul (2):
      media: hantro: Harden MPEG-2 control access against NULL
      media: hantro: disable runtime PM before hardware teardown

Thomas Weißschuh (Schneider Electric) (1):
      timekeeping: Update offsets on sequence counter retry in ktime_get_update_offsets_now()

Thomas Zimmermann (2):
      drm/panic: Do not use un-escaped URL as format string
      drm/panic: Test address from kmap op for NULL

Thorsten Blum (8):
      thermal: intel: powerclamp: Reject invalid window_size values
      thermal: intel: int340x: Fix temperature selection around 0 C
      crypto: zynqmp-sha - fix NULL pointer dereference in init_tfm
      hwrng: amd - report partial reads in non-blocking mode
      hwrng: ba431 - fix reported byte count
      hwrng: core - reject unknown RNG names
      media: imagination: Fix value clamping in calculate_qp_tables
      init: fix early boot crash with bare hostname parameter

Tianchu Chen (2):
      staging: rtl8723bs: fix protected RX frame validation in decrypt path
      staging: rtl8723bs: fix RX buffer OOB write from device-reported length

Tiezhu Yang (7):
      perf loongarch: Fix discarded const qualifier in _get_field()
      LoongArch: Remove arch-specific __smp_mb__{before,after}_atomic()
      LoongArch: Remove redundant call in update_bp_registers()
      LoongArch: Fix bitmask corruption in update_bp_registers()
      LoongArch: Fix architectural naming typo for CSR_FWPS_SKIP
      LoongArch: Only send SIGTRAP signal if necessary in do_watch()
      LoongArch: Fix perf hardware breakpoint failure via installation

Tim Douglas (2):
      serial: pmac_zilog: push received data to the port that received it
      power: supply: generic-adc-battery: fix status with no supplier

Tim Menninger (1):
      xprtrdma: prevent disconnect feedback during endpoint teardown

Tingjie Zhong (1):
      fbdev: bitblit: Fix glyph clipping when fbcon pans

Tom Verdonck (1):
      hwmon: (sht4x) Fix jiffies wraparound in heater-ready check

Tristan Madani (3):
      wifi: rtw89: fix IE length passed to cfg80211_find_ie() in WoW AKM
      cpufreq: intel_pstate: cancel HWP notify work in driver cleanup
      ppp: fix stale pointer access after pskb_may_pull in ppp_ccp_peek

Tsz Shan Chan (1):
      iio: light: apds9306: fix default sampling frequency definition

Tu Dinh (2):
      xen-netback: Fix XenBus connection failure cleanup
      xen-netback: Zero out sring pointers on unmap

Val Packett (1):
      ASoC: qcom: qdsp6: q6afe: fix clk vote response type mismatch

Vasileios Almpanis (1):
      block: drop the cached plug time when blk_add_rq_to_plug() flushes

Vasiliy Kovalev (1):
      ALSA: hda/via: Apply runtime PM workaround for ASUS X55A

Venky Shankar (1):
      ceph: don't fail write_begin with -EAGAIN after flushing old snapc

Vernon Yang (2):
      mm: khugepaged: fix swap entry value to folio_pfn()
      mm: vmscan: don't count per-node proactive reclaim as memory pressure

Viken Dadhaniya (4):
      soc: qcom: geni-se: Fix endian conversion for serial_protocol comparison
      soc: qcom: geni-se: Widen fw_size to u32 to prevent wrap-around
      soc: qcom: geni-se: Fix fw_end computed before round-up; propagate size to caller
      soc: qcom: geni-se: Fix write to read-only firmware buffer

Vincent Donnefort (1):
      KVM: arm64: Fix MMFR0 TGRAN advertisement for pVMs

Vishnu Reddy (3):
      media: venus: Fix iova allocation from restrict region
      media: iris: Fix bus_info prefix in VIDIOC_QUERYCAP
      media: iris: Fix frame interval enumeration for non-divisor framerates

Vladyslav Tymoshchuk (1):
      ASoC: qcom: q6apm: reset the hw pointer with the fragment queue

Wang Haoran (1):
      fbdev: atmel_lcdfb: fix list_first_entry() on possibly empty modelist in probe

Wang Yan (2):
      perf powerpc-vpadtl: Fix off-by-one in auxtrace_info minimum size check
      ALSA: mtpav: restore negation dropped in guard() conversion

Wayne Chang (1):
      usb: typec: ucsi_ccg: Add retry mechanism in ccg_read

Wei Jie Law (2):
      media: uvcvideo: Fix NULL deref on events for uninitialized controls
      net: usb: pegasus: check rx pkt_len against the received length

Wei Yang (1):
      mm/madvise: add cond_resched() in THP branch of madvise_cold_or_pageout_pte_range()

Weibin Liu (8):
      spi: ljca: validate the response length before copying the data
      spi: cadence-xspi: fix stack buffer overflow in the Marvell b0 path
      spi: jcore: fix divide-by-zero when speed_hz is zero
      spi: npcm-fiu: limit UMA data_size to the 16-byte staging buffer
      spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op
      spi: amd: fix len==0 underflow and FIFO overflow
      spi: amd: validate FIFO usage before executing message
      spi: ch341: handle transfers without a TX or RX buffer

Weigang He (1):
      mtd: parsers: qcom: fix offset/size overflow on large partitions

Weili Qian (4):
      crypto: hisilicon/hpre - fix pointer dereference before length check
      crypto: hisilicon/hpre - return -EOVERFLOW for small ECDH output buffer
      crypto: hisilicon/hpre - fix ECDH destination DMA mapping
      crypto: hisilicon/hpre - fix GFP flags for dma_alloc_coherent

Weilin Tong (1):
      ipc/shm: fix RSS accounting for hugetlb shared memory

Weiming Shi (2):
      virtio_net: atomically disable rx mode work
      nvmet-rdma: reject short connection requests

Wenjie Qi (1):
      f2fs: flush SIT journal during filesystem resize

Wentao Guan (2):
      cpufreq/amd-pstate: Skip auto_sel write when it already matches the mode
      mei: vsc: Fix packet CRC computed over pointer size

Wentao Liang (38):
      ASoC: wm8994: Fix runtime PM imbalance in wm8994_component_probe()
      ASoC: arizona-jack: Fix runtime PM imbalance in arizona_start_hpdet_acc_id()
      regulator: core: Fix c_rdev reference leak in regulator_resolve_coupling()
      regulator: core: Fix rdev reference leak in regulator_resolve_supply()
      ASoC: codecs: wm8994: Fix runtime PM leak in wm8994_mic_detect()
      regulator: rt6190: Fix runtime PM imbalance in rt6190_out_enable()
      ASoC: ti: davinci-mcasp: Fix runtime PM imbalance in __davinci_mcasp_set_clkdiv()
      drm/mali-dp: Fix runtime PM leak in malidp_crtc_atomic_enable()
      EDAC/i10nm: Fix mdev reference leak in i10nm_get_ddr_munits()
      media: au0828: Fix media device leak in au0828_usb_probe()
      media: vpif_capture: Fix i2c adapter reference leak in vpif_probe()
      media: vpif_display: Fix i2c adapter reference leak in vpif_probe()
      regulator: core: Fix coupled regulators reference leak on removal
      mtd: rawnand: atmel: Fix MCK clock leak in atmel_nand_controller_init()
      mtd: amd76xrom: Fix PCI device reference leak in amd76xrom_init_one()
      mtd: maps: l440gx: Fix double put of the ISA bridge in init_l440gx()
      mtd: maps: l440gx: Fix double put of the PM device in init_l440gx()
      mtd: mtdsuper: Fix MTD device reference leak in mtd_get_sb()
      ASoC: codecs: wcd9335: Fix SLIM interface device leak in wcd9335_slim_status()
      clk: starfive: jh7110-isp: fix refcount leak in jh7110_ispcrg_probe()
      drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()
      media: pvrusb2: Fix USB parent device leak in class_dev_create()
      media: platform: mtk-mdp3: Fix device reference leak in mdp_comp_init()
      media: mtk-jpeg: Fix runtime PM leak in mtk_jpegdec_worker()
      media: mtk-jpeg: Fix runtime PM leak in mtk_jpegenc_worker()
      wifi: mt76: Fix of_node reference leak in mt76_get_rate_power_limits()
      clocksource/drivers/fttmr010: Fix clk reference leak in error paths
      clocksource/drivers/digicolor: Fix clk reference leak on request_irq failure
      clk: imx: Fix clock reference leak in imx_get_clk_hw_by_name()
      clk: imx: Fix clock reference leak in imx_obtain_fixed_clock_hw()
      soc: fsl: cpm1: tsa: Fix clock leak in tsa_of_parse_tdms()
      xen-pciback: Fix pcistub_device ref leak in pcistub_get_gsi_from_sbdf()
      mailbox: mtk-cmdq: Fix runtime PM leak in cmdq_mbox_flush()
      btrfs: zoned: fix block group reference leak in btrfs_repair_one_zone()
      PCI: xilinx-xdma: Fix device node reference leak in xilinx_pl_dma_pcie_init_irq_domain()
      irqchip/mchp-eic: Fix clock reference leak in mchp_eic_probe()
      ceph: Fix xattr buffer leak in __send_cap()
      ceph: Fix mds session leak in __open_export_target_session()

William Palacek (1):
      drm/amdkfd: wait for a GPU reset before freeing a BO

Xia Yan (1):
      macvlan: fix passthru promiscuity accounting while down

Xiang Mei (3):
      ceph: reject mdsmaps that claim more than CEPH_MAX_MDS ranks
      ceph: require the dentry lease record to cover struct ceph_mds_reply_lease
      ceph: fix integer overflow in the snap trace bounds check

Xiaofeng Yuan (1):
      RISC-V: KVM: Fix IPI delivery for out-of-order vcpu_id

Ximing Zhang (1):
      hwmon: (coretemp) Fix handling of isolated SMT siblings

Xiubo Li (1):
      libceph: only set read_from_replica on read requests

Xu Rao (1):
      media: m2m-deinterlace: fix default capture field

Yehyeong Lee (4):
      xen/pcifront: check that an AER callback exists before calling it
      nvme-rdma: don't complete a request after a bogus remote invalidation
      nvme-auth: fail when the controller does not authenticate itself
      nvme: bound FDP config log reads to the received buffer

Yi Cong (1):
      wifi: rtw89: 8851b: fix swapped DPK channel/bandwidth backup fields

Yingjie Wang (2):
      net: unix: reject negative max_dgram_qlen values
      tcp: limit tcp_tso_rtt_log to a valid shift count

Yo'av Moshe (1):
      ARM: imx: Fix suspend/resume crash with Clang CFI

Yogesh Gaur (2):
      md: don't hand out the array before md_alloc() has added mddev->kobj
      libceph: reject an initial monmap with no monitors

Yongjian Mu (1):
      xprtrdma: trim head iovec when the payload arrives via a Write chunk

Yongjian Wang (1):
      Revert "net: advertise TCP MSS from the configured MTU, not the learned PMTU"

Younho Choi (1):
      media: vim2m: keep transaction buffer count stable while streaming

Yousef Alhouseen (1):
      ntfs3: bound index head insertions by buffer capacity

Yu Zhang (1):
      nvmet: take subsys->lock while force-reconnecting in nvmet_subsys_attr_qid_max_store()

YuBiao Wang (1):
      drm/amdgpu: recompute the dw estimate after allocating a new VM update job

Yuan Chen (1):
      bpf: Fix queue/stack map u32 index overflow

Yuanfu Xie (1):
      ceph: clamp MDS reply result code to the errno range

Yuanhe Shu (1):
      mm/page_alloc: do not boost watermarks in kdump capture kernels

Yuchao Zhang (1):
      md: validate bblog_size when loading v1.x badblocks metadata

Yunhui Cui (1):
      riscv: mm: exclude invalid THP PMDs from page table check

Zhan Xusheng (1):
      f2fs: fix defragment writeback range truncation on 32-bit

Zhang Yi (1):
      mm/truncate: look up the end-edge straddler by index

Zhao Gongyi (1):
      arm64/mm: restrict transparent contpte mappings to valid PTEs

ZhaoJinming (1):
      crypto: caam - fix double-free in caam_rsa_set_priv_key_form()

Zhen Han (1):
      drm/amdkfd: correct vram_available calculation

Zhenhao Wan (2):
      drm/nouveau: reject zero-size notifier object allocation
      drm/nouveau/svm: drain fault handler before freeing svmm

Zhiling Zou (2):
      mm/page_table_check: skip zero pages
      tcp: check congestion control restriction first

Zhongqiu Han (1):
      cpufreq: stats: Fix potential out-of-bounds access in deferred reset

Zi Yan (1):
      USB: gadgetfs: do not WARN about excessively large memory allocations

Zixuan Chai (1):
      ipv6: defrag: orphan skb before queuing

Zongmin Zhou (1):
      slimbus: messaging: fix leaked PM vote on tid allocation failure

guzebing (2):
      ext4: only update tune mount options when requested
      ext4: reject delalloc to nodelalloc before applying remount options

hanzhijian (1):
      clk: mstar: msc313-mpll: fix off-by-one in clock array allocation

lvyating (1):
      perf machine: Fix NULL deref in thread__resolve_callchain_sample()

sonotri (1):
      ublk: pin module while release work is pending

sung byeongchan (4):
      ceph: validate fscrypt auth blob length
      ceph: bound name skips in ceph_mdsmap_decode() by the message end
      ceph: validate MDS reply fragtree split array length
      ceph: validate encoded xattr name lengths

yanxia (1):
      veth: fix stale peer max_mtu on XDP program replacement

イムティヤズ (1):
      wifi: rtw88: fix out-of-bounds CAM write when key table is full

