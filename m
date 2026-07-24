Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF543F8DD;
	Fri, 24 Jul 2026 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905601; cv=none; b=AfyTc+bnFIFOJgXatBIhKgGM63q1usglH8VQfK87g2P3KRLHOj9PO3LH1LfdVHORw9H4dUmPCYsfCI6u7HPVMEVtZb6jH+0h9aaL1RdufqF11fXnZeYV5KOKmniyfjglLNkHyJB1tAQeR50ugDAsNCszUVwZ3PBqRjPvU0FsMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905601; c=relaxed/simple;
	bh=k0gC7+8O0pTo92lWYAKkiYcwlBLX3uoeM0sy+OiNsC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gCIs66TeR5JvvoHUB8RR0DS8lA0RMFKLGREO4ubv1fIde0QPkPAyZGV+b/67C7GAjvJ1Y/klQZ5WtRBa1V06OLVTLsnGzYqShZ8BEprmZKeO7vnNg7twNRCIcZIUhHuCjKAion/fGXolk6um428IZdkTuLHeEqk24GEQ/iaOFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wsuDDweW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wsuDDweW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EC91F00ADE;
	Fri, 24 Jul 2026 15:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784905582;
	bh=xaYYefUioz6TKFcCtn725ZuFdO5IWSegQH40Q/BR2kM=;
	h=From:To:Cc:Subject:Date;
	b=wsuDDweWOJJ5EtoCpukvDWUdNxriXAmkV2LGWqWC+YSjo5u+vWpZ52fm77150f6Qr
	 jEtmHj99f4DwpXBiSEHVUYqr8iI9vz98tj7zOn5/HHjL9MIRdaV9iV6Cz996wfPBy7
	 +IjZnq9Ak145Qqo7ugI904fvVswjD/WP9nLzshcE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.40
Date: Fri, 24 Jul 2026 17:05:56 +0200
Message-ID: <2026072457-cufflink-drew-878f@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.40 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-bus-i3c                                       |   11 
 Documentation/admin-guide/pm/cpufreq.rst                                      |    6 
 Documentation/arch/arm64/cpu-hotplug.rst                                      |   28 
 Documentation/devicetree/bindings/clock/qcom,x1e80100-camcc.yaml              |    1 
 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml            |   23 
 Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml |   10 
 Documentation/devicetree/bindings/net/renesas,ether.yaml                      |    3 
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml         |   13 
 Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux-aon.yaml     |    4 
 Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux.yaml         |    4 
 Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml             |   43 
 Documentation/devicetree/bindings/timer/sifive,clint.yaml                     |   16 
 Documentation/devicetree/bindings/vendor-prefixes.yaml                        |    2 
 Documentation/driver-api/nvdimm/btt.rst                                       |    5 
 Documentation/driver-api/pci/pci.rst                                          |    3 
 Documentation/filesystems/proc.rst                                            |   14 
 Documentation/netlink/specs/handshake.yaml                                    |    1 
 Documentation/netlink/specs/rt-link.yaml                                      |    6 
 Documentation/networking/bonding.rst                                          |   23 
 Documentation/trace/eprobetrace.rst                                           |    4 
 Documentation/trace/rv/monitor_sched.rst                                      |    7 
 Makefile                                                                      |    2 
 arch/alpha/kernel/pci-sysfs.c                                                 |   13 
 arch/arm/boot/dts/nvidia/tegra124-nyan.dtsi                                   |    5 
 arch/arm/boot/dts/nvidia/tegra124-venice2.dts                                 |    5 
 arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi                                 |    4 
 arch/arm/boot/dts/rockchip/rk3288-veyron.dtsi                                 |    5 
 arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts                                 |  128 ++
 arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts                                 |  144 ++
 arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi                                |  146 --
 arch/arm/boot/dts/ti/omap/am335x-sl50.dts                                     |    4 
 arch/arm/configs/axm55xx_defconfig                                            |    1 
 arch/arm/configs/dove_defconfig                                               |    1 
 arch/arm/configs/ep93xx_defconfig                                             |    1 
 arch/arm/configs/mmp2_defconfig                                               |    1 
 arch/arm/configs/multi_v7_defconfig                                           |    4 
 arch/arm/configs/mv78xx0_defconfig                                            |    1 
 arch/arm/configs/sunxi_defconfig                                              |    1 
 arch/arm/mach-imx/cpu-imx31.c                                                 |    9 
 arch/arm/mach-imx/mm-imx3.c                                                   |    2 
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi                                |    3 
 arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts                        |    2 
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts                                 |    2 
 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts                           |   10 
 arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi                       |    7 
 arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts                     |   14 
 arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.dtsi                       |    7 
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts                   |    3 
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts                                 |    1 
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts                                 |    4 
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi                              |    4 
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts                             |    2 
 arch/arm64/boot/dts/freescale/imx95.dtsi                                      |   10 
 arch/arm64/boot/dts/freescale/s32g3.dtsi                                      |    2 
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi                              |    2 
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts                                |    5 
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts                                 |    5 
 arch/arm64/boot/dts/nvidia/tegra234.dtsi                                      |    8 
 arch/arm64/boot/dts/qcom/ipq5424.dtsi                                         |    4 
 arch/arm64/boot/dts/qcom/lemans.dtsi                                          |   18 
 arch/arm64/boot/dts/qcom/qcs8300.dtsi                                         |    6 
 arch/arm64/boot/dts/qcom/sc7180.dtsi                                          |    6 
 arch/arm64/boot/dts/qcom/sc7280.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                                         |    2 
 arch/arm64/boot/dts/qcom/sdm630.dtsi                                          |    9 
 arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso              |    5 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                                          |    6 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                                          |    6 
 arch/arm64/boot/dts/qcom/sm8750.dtsi                                          |    6 
 arch/arm64/boot/dts/rockchip/px30-cobra.dtsi                                  |    2 
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi                               |    2 
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi                                  |    5 
 arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts                                |    2 
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts                            |    6 
 arch/arm64/boot/dts/st/stm32mp251.dtsi                                        |    8 
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                                       |    2 
 arch/arm64/include/asm/kvm_hyp.h                                              |    1 
 arch/arm64/include/asm/kvm_nested.h                                           |   10 
 arch/arm64/kernel/acpi.c                                                      |    2 
 arch/arm64/kernel/entry-fpsimd.S                                              |    8 
 arch/arm64/kernel/hw_breakpoint.c                                             |    9 
 arch/arm64/kernel/smp.c                                                       |   28 
 arch/arm64/kvm/arm.c                                                          |    2 
 arch/arm64/kvm/at.c                                                           |   35 
 arch/arm64/kvm/emulate-nested.c                                               |    1 
 arch/arm64/kvm/hyp/include/hyp/switch.h                                       |   11 
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                                            |    9 
 arch/arm64/kvm/hyp/pgtable.c                                                  |    3 
 arch/arm64/kvm/nested.c                                                       |  220 +--
 arch/arm64/kvm/vgic/vgic-its.c                                                |    2 
 arch/arm64/kvm/vgic/vgic.c                                                    |   20 
 arch/arm64/mm/mmu.c                                                           |   11 
 arch/arm64/tools/sysreg                                                       |    2 
 arch/loongarch/include/asm/kexec.h                                            |    3 
 arch/loongarch/include/asm/pgtable.h                                          |    4 
 arch/loongarch/kvm/exit.c                                                     |    1 
 arch/loongarch/kvm/irqfd.c                                                    |    3 
 arch/loongarch/kvm/vcpu.c                                                     |   11 
 arch/loongarch/mm/pageattr.c                                                  |    2 
 arch/loongarch/net/bpf_jit.c                                                  |   28 
 arch/mips/dec/int-handler.S                                                   |    2 
 arch/mips/dec/platform.c                                                      |    6 
 arch/mips/dec/prom/init.c                                                     |    6 
 arch/mips/dec/setup.c                                                         |    6 
 arch/mips/fw/lib/call_o32.S                                                   |    2 
 arch/mips/include/asm/dec/prom.h                                              |   15 
 arch/mips/kernel/mips-mt-fpaff.c                                              |   28 
 arch/mips/mm/init.c                                                           |   17 
 arch/mips/n64/init.c                                                          |    2 
 arch/mips/ralink/mt7621.c                                                     |    2 
 arch/mips/sgi-ip22/ip22-gio.c                                                 |    7 
 arch/openrisc/include/asm/cacheflush.h                                        |    4 
 arch/openrisc/kernel/jump_label.c                                             |    2 
 arch/openrisc/kernel/patching.c                                               |    3 
 arch/openrisc/kernel/smp.c                                                    |   21 
 arch/openrisc/mm/cache.c                                                      |   16 
 arch/openrisc/mm/init.c                                                       |    2 
 arch/powerpc/kernel/dt_cpu_ftrs.c                                             |    9 
 arch/powerpc/kexec/core_64.c                                                  |    4 
 arch/powerpc/perf/core-fsl-emb.c                                              |    3 
 arch/powerpc/platforms/8xx/cpm1.c                                             |   26 
 arch/powerpc/platforms/cell/spufs/file.c                                      |    6 
 arch/powerpc/platforms/powernv/setup.c                                        |    3 
 arch/powerpc/platforms/pseries/Kconfig                                        |    1 
 arch/powerpc/platforms/pseries/papr_platform_attributes.c                     |    8 
 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi                                   |  236 +--
 arch/riscv/boot/dts/sophgo/sg2044-cpus.dtsi                                   |  236 +--
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts                               |    2 
 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts                             |    2 
 arch/riscv/include/asm/cpu_ops.h                                              |    2 
 arch/riscv/kernel/asm-offsets.c                                               |    4 
 arch/riscv/kernel/cacheinfo.c                                                 |    2 
 arch/riscv/kernel/cpu-hotplug.c                                               |    4 
 arch/riscv/kernel/cpu_ops_sbi.c                                               |   11 
 arch/riscv/kernel/entry.S                                                     |    8 
 arch/riscv/kernel/machine_kexec.c                                             |    3 
 arch/riscv/kernel/probes/rethook_trampoline.S                                 |    3 
 arch/riscv/kernel/stacktrace.c                                                |    2 
 arch/riscv/kernel/vdso/Makefile                                               |    6 
 arch/s390/kernel/diag/diag310.c                                               |    7 
 arch/s390/kernel/perf_cpum_cf.c                                               |    3 
 arch/s390/kernel/process.c                                                    |    2 
 arch/s390/kvm/pci.c                                                           |   12 
 arch/s390/mm/mmap.c                                                           |    2 
 arch/sparc/kernel/led.c                                                       |    2 
 arch/x86/Kconfig.cpu                                                          |    8 
 arch/x86/boot/compressed/acpi.c                                               |    7 
 arch/x86/boot/early_serial_console.c                                          |   11 
 arch/x86/events/amd/brs.c                                                     |   10 
 arch/x86/events/amd/core.c                                                    |   18 
 arch/x86/events/amd/lbr.c                                                     |    3 
 arch/x86/events/amd/uncore.c                                                  |    6 
 arch/x86/events/intel/uncore_discovery.c                                      |    4 
 arch/x86/kernel/cpu/cpu.h                                                     |    1 
 arch/x86/kernel/uprobes.c                                                     |   26 
 arch/x86/kvm/irq.c                                                            |    4 
 arch/x86/kvm/lapic.c                                                          |    8 
 arch/x86/kvm/svm/sev.c                                                        |    6 
 arch/x86/kvm/vmx/nested.c                                                     |    2 
 arch/x86/kvm/vmx/tdx.c                                                        |   12 
 arch/x86/platform/olpc/olpc-xo15-sci.c                                        |    1 
 arch/x86/video/video-common.c                                                 |   23 
 block/blk.h                                                                   |   13 
 block/genhd.c                                                                 |    4 
 block/ioctl.c                                                                 |    2 
 crypto/algif_skcipher.c                                                       |   75 -
 crypto/asymmetric_keys/verify_pefile.c                                        |    2 
 crypto/ecrdsa.c                                                               |    2 
 crypto/rng.c                                                                  |   11 
 drivers/accel/amdxdna/aie2_ctx.c                                              |    4 
 drivers/accel/amdxdna/amdxdna_gem.c                                           |    3 
 drivers/accel/amdxdna/amdxdna_ubuf.c                                          |   12 
 drivers/accel/ivpu/ivpu_fw_log.c                                              |    4 
 drivers/accel/ivpu/ivpu_job.c                                                 |   10 
 drivers/acpi/ac.c                                                             |    6 
 drivers/acpi/acpi_ipmi.c                                                      |    4 
 drivers/acpi/acpi_pad.c                                                       |    6 
 drivers/acpi/acpi_tad.c                                                       |    6 
 drivers/acpi/bus.c                                                            |   70 +
 drivers/acpi/nfit/core.c                                                      |   89 +
 drivers/acpi/pfr_telemetry.c                                                  |    6 
 drivers/acpi/pfr_update.c                                                     |    6 
 drivers/acpi/processor_idle.c                                                 |    4 
 drivers/acpi/resource.c                                                       |    6 
 drivers/acpi/riscv/cpuidle.c                                                  |    2 
 drivers/acpi/riscv/rimt.c                                                     |    7 
 drivers/acpi/thermal.c                                                        |    2 
 drivers/amba/bus.c                                                            |   37 
 drivers/android/binder.c                                                      |   18 
 drivers/ata/libata-core.c                                                     |   23 
 drivers/ata/libata-scsi.c                                                     |    7 
 drivers/ata/pata_pxa.c                                                        |    1 
 drivers/ata/sata_gemini.c                                                     |    2 
 drivers/base/core.c                                                           |   83 +
 drivers/base/dd.c                                                             |    7 
 drivers/base/firmware_loader/main.c                                           |   71 +
 drivers/base/power/main.c                                                     |    6 
 drivers/base/property.c                                                       |    4 
 drivers/block/drbd/drbd_receiver.c                                            |    5 
 drivers/bluetooth/bpa10x.c                                                    |    8 
 drivers/bluetooth/btmtk.c                                                     |    4 
 drivers/bluetooth/btrtl.c                                                     |    5 
 drivers/bluetooth/hci_qca.c                                                   |    2 
 drivers/bluetooth/hci_vhci.c                                                  |   10 
 drivers/bus/imx-weim.c                                                        |    6 
 drivers/bus/mhi/ep/main.c                                                     |    9 
 drivers/bus/mhi/host/pci_generic.c                                            |   20 
 drivers/bus/sunxi-rsb.c                                                       |    3 
 drivers/cdx/cdx.c                                                             |   40 
 drivers/char/ipmi/ipmi_msghandler.c                                           |   10 
 drivers/char/tlclk.c                                                          |    4 
 drivers/char/tpm/eventlog/tpm1.c                                              |    4 
 drivers/char/tpm/tpm-dev.c                                                    |    2 
 drivers/char/tpm/tpm2-cmd.c                                                   |    6 
 drivers/char/tpm/tpm2-sessions.c                                              |   45 
 drivers/char/tpm/tpm_tis_core.c                                               |   35 
 drivers/char/tpm/tpmrm-dev.c                                                  |    2 
 drivers/char/virtio_console.c                                                 |   52 
 drivers/clk/at91/pmc.c                                                        |    2 
 drivers/clk/at91/sam9x7.c                                                     |   18 
 drivers/clk/clk-scmi.c                                                        |    4 
 drivers/clk/clk-scpi.c                                                        |    2 
 drivers/clk/qcom/a53-pll.c                                                    |    2 
 drivers/clk/qcom/camcc-x1e80100.c                                             |   64 +
 drivers/clk/qcom/ipq-cmn-pll.c                                                |   11 
 drivers/clk/renesas/rzg2l-cpg.c                                               |    6 
 drivers/clocksource/timer-sun5i.c                                             |    3 
 drivers/cpufreq/cpufreq_conservative.c                                        |   12 
 drivers/cpufreq/intel_pstate.c                                                |    6 
 drivers/crypto/Kconfig                                                        |    1 
 drivers/crypto/allwinner/Kconfig                                              |    8 
 drivers/crypto/allwinner/sun4i-ss/Makefile                                    |    1 
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c                             |   36 
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c                             |   69 -
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h                                  |   20 
 drivers/crypto/atmel-sha204a.c                                                |   16 
 drivers/crypto/cavium/cpt/cptvf_reqmanager.c                                  |    4 
 drivers/crypto/ccp/psp-dev.c                                                  |    8 
 drivers/crypto/ccp/sev-dev.c                                                  |   10 
 drivers/crypto/hisilicon/qm.c                                                 |    4 
 drivers/crypto/inside-secure/eip93/eip93-main.c                               |    2 
 drivers/crypto/inside-secure/eip93/eip93-regs.h                               |    2 
 drivers/crypto/intel/qat/qat_common/adf_accel_devices.h                       |    2 
 drivers/crypto/intel/qat/qat_common/adf_aer.c                                 |    7 
 drivers/crypto/intel/qat/qat_common/adf_common_drv.h                          |    3 
 drivers/crypto/intel/qat/qat_common/adf_heartbeat_inject.c                    |    6 
 drivers/crypto/intel/qat/qat_common/adf_hw_arbiter.c                          |   25 
 drivers/crypto/intel/qat/qat_common/adf_isr.c                                 |   39 
 drivers/crypto/intel/qat/qat_common/adf_sriov.c                               |   20 
 drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c                            |    4 
 drivers/crypto/tegra/tegra-se-aes.c                                           |   33 
 drivers/crypto/xilinx/xilinx-trng.c                                           |   75 -
 drivers/cxl/core/features.c                                                   |    2 
 drivers/dax/kmem.c                                                            |    6 
 drivers/dibs/dibs_loopback.c                                                  |    5 
 drivers/dma-buf/dma-fence-unwrap.c                                            |    3 
 drivers/dma/dma-axi-dmac.c                                                    |   68 -
 drivers/dma/dmaengine.c                                                       |    3 
 drivers/dma/dw-edma/dw-edma-core.h                                            |    2 
 drivers/dma/dw-edma/dw-edma-v0-core.c                                         |    6 
 drivers/dma/imx-sdma.c                                                        |    4 
 drivers/dma/qcom/gpi.c                                                        |    1 
 drivers/dma/tegra186-gpc-dma.c                                                |    7 
 drivers/dpll/dpll_core.c                                                      |  140 +-
 drivers/edac/igen6_edac.c                                                     |    6 
 drivers/edac/skx_common.c                                                     |    3 
 drivers/firmware/arm_ffa/driver.c                                             |   27 
 drivers/firmware/arm_scmi/power.c                                             |    6 
 drivers/firmware/arm_scmi/sensors.c                                           |    2 
 drivers/firmware/smccc/soc_id.c                                               |    2 
 drivers/fpga/dfl.c                                                            |    2 
 drivers/fpga/microchip-spi.c                                                  |    3 
 drivers/gpio/gpio-davinci.c                                                   |    4 
 drivers/gpio/gpio-dwapb.c                                                     |  112 +
 drivers/gpio/gpio-f7188x.c                                                    |    6 
 drivers/gpio/gpio-htc-egpio.c                                                 |    6 
 drivers/gpio/gpio-mlxbf3.c                                                    |    3 
 drivers/gpio/gpio-mt7621.c                                                    |  283 +++-
 drivers/gpio/gpio-mvebu.c                                                     |    6 
 drivers/gpio/gpio-palmas.c                                                    |   19 
 drivers/gpio/gpio-tegra.c                                                     |   18 
 drivers/gpio/gpio-timberdale.c                                                |    2 
 drivers/gpio/gpiolib-acpi-core.c                                              |   19 
 drivers/gpio/gpiolib.c                                                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                              |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                    |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                                       |   25 
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c                                       |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c                                       |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                      |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                         |   20 
 drivers/gpu/drm/amd/amdkfd/kfd_events.c                                       |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                          |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                             |   10 
 drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c                 |    2 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                                            |    6 
 drivers/gpu/drm/drm_edid.c                                                    |    8 
 drivers/gpu/drm/drm_gpusvm.c                                                  |    5 
 drivers/gpu/drm/drm_gpuvm.c                                                   |    9 
 drivers/gpu/drm/drm_syncobj.c                                                 |   10 
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h                                  |    1 
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h                                    |    1 
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c                                  |    2 
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c                                |   80 -
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c                                |   35 
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c                               |   14 
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h                               |    1 
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c                              |   75 -
 drivers/gpu/drm/i915/display/intel_atomic.c                                   |    6 
 drivers/gpu/drm/i915/gt/intel_region_lmem.c                                   |    2 
 drivers/gpu/drm/msm/dp/dp_display.c                                           |    4 
 drivers/gpu/drm/msm/dp/dp_reg.h                                               |    4 
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowramin.c                        |    3 
 drivers/gpu/drm/panel/Kconfig                                                 |    9 
 drivers/gpu/drm/panthor/panthor_sched.c                                       |   25 
 drivers/gpu/drm/radeon/radeon_gem.c                                           |   13 
 drivers/gpu/drm/radeon/radeon_ring.c                                          |    4 
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c                                |   12 
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c                                     |    7 
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c                                   |    2 
 drivers/gpu/drm/tegra/dc.c                                                    |    4 
 drivers/gpu/drm/tegra/gem.c                                                   |   22 
 drivers/gpu/drm/tegra/gr2d.c                                                  |   19 
 drivers/gpu/drm/tegra/gr3d.c                                                  |   19 
 drivers/gpu/drm/tegra/submit.c                                                |    3 
 drivers/gpu/drm/tidss/tidss_kms.c                                             |    2 
 drivers/gpu/drm/v3d/v3d_submit.c                                              |    2 
 drivers/gpu/drm/xe/Makefile                                                   |    4 
 drivers/gpu/drm/xe/tests/xe_pci.c                                             |    1 
 drivers/gpu/drm/xe/xe_debugfs.c                                               |    2 
 drivers/gpu/drm/xe/xe_guc_relay.c                                             |   13 
 drivers/gpu/drm/xe/xe_hw_engine.c                                             |    4 
 drivers/gpu/drm/xe/xe_hwmon.c                                                 |    2 
 drivers/gpu/drm/xe/xe_pt.c                                                    |   60 -
 drivers/gpu/drm/xe/xe_svm.h                                                   |   15 
 drivers/gpu/drm/xe/xe_vram.c                                                  |    2 
 drivers/gpu/drm/xe/xe_vsec.c                                                  |    7 
 drivers/gpu/drm/xe/xe_vsec.h                                                  |    4 
 drivers/gpu/host1x/bus.c                                                      |   62 +
 drivers/gpu/host1x/job.c                                                      |   10 
 drivers/hid/bpf/hid_bpf_dispatch.c                                            |    5 
 drivers/hid/hid-core.c                                                        |    7 
 drivers/hid/hid-logitech-hidpp.c                                              |    1 
 drivers/hid/hid-picolcd_core.c                                                |    3 
 drivers/hid/hid-playstation.c                                                 |   12 
 drivers/hid/hid-wiimote-modules.c                                             |   58 
 drivers/hv/mshv_synic.c                                                       |    5 
 drivers/hv/vmbus_drv.c                                                        |   43 
 drivers/hwmon/Kconfig                                                         |    3 
 drivers/hwmon/aspeed-g6-pwm-tach.c                                            |    5 
 drivers/hwmon/asus_atk0110.c                                                  |    3 
 drivers/hwmon/it87.c                                                          |    3 
 drivers/hwmon/occ/common.c                                                    |   34 
 drivers/hwmon/occ/common.h                                                    |    1 
 drivers/hwmon/pmbus/adm1275.c                                                 |    2 
 drivers/hwmon/pmbus/pmbus_core.c                                              |   13 
 drivers/hwmon/w83627hf.c                                                      |    4 
 drivers/hwmon/w83793.c                                                        |    1 
 drivers/hwspinlock/qcom_hwspinlock.c                                          |    5 
 drivers/hwtracing/coresight/coresight-core.c                                  |   23 
 drivers/hwtracing/coresight/coresight-cti-platform.c                          |    1 
 drivers/hwtracing/coresight/coresight-etm-perf.c                              |    5 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                            |   62 -
 drivers/hwtracing/coresight/coresight-etm4x.h                                 |    2 
 drivers/hwtracing/coresight/coresight-priv.h                                  |    2 
 drivers/hwtracing/coresight/coresight-sysfs.c                                 |    8 
 drivers/i2c/busses/i2c-imx.c                                                  |   36 
 drivers/i2c/busses/i2c-k1.c                                                   |    2 
 drivers/i2c/busses/i2c-mlxbf.c                                                |    4 
 drivers/i2c/busses/i2c-mt65xx.c                                               |    2 
 drivers/i2c/i2c-core-of.c                                                     |    5 
 drivers/i3c/device.c                                                          |   46 
 drivers/i3c/internals.h                                                       |    4 
 drivers/i3c/master.c                                                          |  306 ++++-
 drivers/i3c/master/dw-i3c-master.c                                            |   15 
 drivers/i3c/master/dw-i3c-master.h                                            |    2 
 drivers/i3c/master/i3c-master-cdns.c                                          |   14 
 drivers/i3c/master/mipi-i3c-hci/core.c                                        |   39 
 drivers/i3c/master/mipi-i3c-hci/dma.c                                         |    6 
 drivers/i3c/master/mipi-i3c-hci/ext_caps.c                                    |   55 
 drivers/i3c/master/mipi-i3c-hci/pio.c                                         |   20 
 drivers/i3c/master/svc-i3c-master.c                                           |   30 
 drivers/iio/accel/mma8452.c                                                   |    2 
 drivers/iio/adc/xilinx-ams.c                                                  |    5 
 drivers/iio/light/si1133.c                                                    |   14 
 drivers/iio/light/tcs3472.c                                                   |   38 
 drivers/iio/magnetometer/ak8975.c                                             |   14 
 drivers/iio/orientation/hid-sensor-rotation.c                                 |   40 
 drivers/infiniband/core/cm.c                                                  |   13 
 drivers/infiniband/core/counters.c                                            |    2 
 drivers/infiniband/hw/bnxt_re/Makefile                                        |    2 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                      |  312 -----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h                                      |    4 
 drivers/infiniband/hw/bnxt_re/main.c                                          |    2 
 drivers/infiniband/hw/bnxt_re/uapi.c                                          |  364 ++++++
 drivers/infiniband/hw/hfi1/init.c                                             |   13 
 drivers/infiniband/hw/hns/hns_roce_cq.c                                       |    6 
 drivers/infiniband/hw/hns/hns_roce_debugfs.c                                  |   19 
 drivers/infiniband/hw/hns/hns_roce_hem.c                                      |    8 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                    |   18 
 drivers/infiniband/hw/hns/hns_roce_main.c                                     |    2 
 drivers/infiniband/hw/hns/hns_roce_mr.c                                       |    6 
 drivers/infiniband/hw/hns/hns_roce_srq.c                                      |    2 
 drivers/infiniband/hw/irdma/verbs.c                                           |   19 
 drivers/infiniband/hw/irdma/verbs.h                                           |    1 
 drivers/infiniband/hw/mana/main.c                                             |    3 
 drivers/infiniband/hw/mlx4/mlx4_ib.h                                          |    1 
 drivers/infiniband/hw/mlx4/mr.c                                               |    9 
 drivers/infiniband/hw/mlx4/sysfs.c                                            |   45 
 drivers/infiniband/hw/mlx5/devx.c                                             |   30 
 drivers/infiniband/hw/mlx5/main.c                                             |   17 
 drivers/infiniband/hw/mlx5/mlx5_ib.h                                          |    9 
 drivers/infiniband/hw/mlx5/mr.c                                               |   29 
 drivers/infiniband/hw/mlx5/odp.c                                              |   12 
 drivers/infiniband/hw/mlx5/qp.c                                               |   13 
 drivers/infiniband/hw/mlx5/restrack.c                                         |    3 
 drivers/infiniband/hw/mlx5/umr.c                                              |   93 -
 drivers/infiniband/hw/mlx5/umr.h                                              |    9 
 drivers/infiniband/sw/rxe/rxe_mmap.c                                          |   19 
 drivers/infiniband/sw/rxe/rxe_resp.c                                          |   33 
 drivers/infiniband/sw/siw/siw_cm.c                                            |   30 
 drivers/infiniband/ulp/srpt/ib_srpt.c                                         |    5 
 drivers/input/misc/ims-pcu.c                                                  |  129 +-
 drivers/iommu/amd/amd_iommu.h                                                 |    3 
 drivers/iommu/amd/amd_iommu_types.h                                           |   32 
 drivers/iommu/amd/init.c                                                      |  130 +-
 drivers/iommu/amd/iommu.c                                                     |    2 
 drivers/iommu/amd/ppr.c                                                       |    8 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                                    |    2 
 drivers/iommu/intel/iommu.c                                                   |    6 
 drivers/iommu/intel/pasid.c                                                   |    4 
 drivers/iommu/iommufd/driver.c                                                |   13 
 drivers/iommu/iommufd/eventq.c                                                |   10 
 drivers/irqchip/irq-crossbar.c                                                |   10 
 drivers/irqchip/irq-gic-v3-its.c                                              |    6 
 drivers/irqchip/irq-riscv-imsic-early.c                                       |   15 
 drivers/irqchip/irq-ts4800.c                                                  |   10 
 drivers/leds/uleds.c                                                          |    3 
 drivers/mailbox/imx-mailbox.c                                                 |    3 
 drivers/mailbox/mailbox-mpfs.c                                                |    2 
 drivers/mailbox/mtk-adsp-mailbox.c                                            |    9 
 drivers/md/dm-bufio.c                                                         |    4 
 drivers/md/dm-era-target.c                                                    |   10 
 drivers/md/dm-integrity.c                                                     |   12 
 drivers/md/dm-ioctl.c                                                         |    4 
 drivers/md/dm-log.c                                                           |    3 
 drivers/md/dm-pcache/dm_pcache.c                                              |    8 
 drivers/md/dm-stats.c                                                         |   10 
 drivers/md/dm-thin-metadata.c                                                 |   67 -
 drivers/md/dm-verity-loadpin.c                                                |    2 
 drivers/md/dm-verity-target.c                                                 |   16 
 drivers/md/dm-verity.h                                                        |    2 
 drivers/md/md-bitmap.c                                                        |   13 
 drivers/md/md-bitmap.h                                                        |    2 
 drivers/md/md-llbitmap.c                                                      |   13 
 drivers/md/md.c                                                               |   38 
 drivers/md/md.h                                                               |   10 
 drivers/md/raid0.c                                                            |    4 
 drivers/md/raid1.c                                                            |   28 
 drivers/md/raid10.c                                                           |    5 
 drivers/md/raid5.c                                                            |   61 -
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c                           |   18 
 drivers/media/platform/qcom/camss/camss-vfe.c                                 |    2 
 drivers/media/platform/qcom/iris/iris_platform_sm8250.c                       |    2 
 drivers/media/platform/qcom/iris/iris_probe.c                                 |    7 
 drivers/media/platform/qcom/venus/core.c                                      |    7 
 drivers/media/platform/qcom/venus/core.h                                      |    1 
 drivers/media/platform/qcom/venus/helpers.c                                   |    4 
 drivers/media/platform/qcom/venus/hfi_parser.c                                |    6 
 drivers/media/platform/qcom/venus/hfi_platform.c                              |   24 
 drivers/media/platform/qcom/venus/hfi_platform.h                              |    2 
 drivers/media/platform/qcom/venus/hfi_platform_v4.c                           |   20 
 drivers/media/platform/qcom/venus/hfi_platform_v6.c                           |   16 
 drivers/media/platform/qcom/venus/pm_helpers.c                                |    8 
 drivers/media/platform/rockchip/rga/rga-hw.c                                  |    2 
 drivers/media/platform/rockchip/rga/rga-hw.h                                  |    2 
 drivers/media/usb/uvc/uvc_status.c                                            |   28 
 drivers/media/usb/uvc/uvc_video.c                                             |  179 +--
 drivers/media/v4l2-core/v4l2-common.c                                         |    1 
 drivers/memory/tegra/mc.c                                                     |   14 
 drivers/memstick/core/ms_block.c                                              |    4 
 drivers/mfd/cs42l43.c                                                         |    2 
 drivers/mfd/rsmu_i2c.c                                                        |    6 
 drivers/mfd/rsmu_spi.c                                                        |    5 
 drivers/mfd/sm501.c                                                           |    4 
 drivers/mfd/tps6586x.c                                                        |    2 
 drivers/mmc/core/block.c                                                      |    3 
 drivers/mmc/host/sdhci-esdhc-imx.c                                            |   91 -
 drivers/mmc/host/sdhci-of-dwcmshc.c                                           |   14 
 drivers/mmc/host/vub300.c                                                     |   26 
 drivers/mtd/devices/mchp23k256.c                                              |    2 
 drivers/mtd/devices/slram.c                                                   |   22 
 drivers/mtd/maps/vmu-flash.c                                                  |    1 
 drivers/mtd/nand/onenand/onenand_samsung.c                                    |    7 
 drivers/mtd/nand/raw/fsl_ifc_nand.c                                           |    9 
 drivers/mtd/nand/raw/lpc32xx_mlc.c                                            |   12 
 drivers/mtd/nand/raw/lpc32xx_slc.c                                            |   12 
 drivers/mtd/nand/raw/nand_base.c                                              |   24 
 drivers/mtd/nand/raw/pl35x-nand-controller.c                                  |    2 
 drivers/mtd/spi-nor/Kconfig                                                   |    1 
 drivers/mtd/spi-nor/debugfs.c                                                 |    1 
 drivers/mtd/spi-nor/spansion.c                                                |    4 
 drivers/mtd/spi-nor/swp.c                                                     |   11 
 drivers/net/amt.c                                                             |    6 
 drivers/net/bonding/bond_3ad.c                                                |   27 
 drivers/net/bonding/bond_main.c                                               |    1 
 drivers/net/bonding/bond_netlink.c                                            |   16 
 drivers/net/bonding/bond_options.c                                            |   27 
 drivers/net/can/usb/esd_usb.c                                                 |    5 
 drivers/net/dsa/qca/qca8k-leds.c                                              |    3 
 drivers/net/dsa/realtek/rtl8366rb-leds.c                                      |    8 
 drivers/net/dsa/sja1105/sja1105_ptp.c                                         |    2 
 drivers/net/ethernet/airoha/airoha_eth.c                                      |    6 
 drivers/net/ethernet/airoha/airoha_ppe.c                                      |    3 
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c                              |    2 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                                  |   23 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c                               |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                     |   77 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                                     |   19 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                             |   21 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                                |   23 
 drivers/net/ethernet/cadence/macb_main.c                                      |   29 
 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c                       |   18 
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c                                    |    8 
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h                      |    2 
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c                   |    8 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c                           |   10 
 drivers/net/ethernet/freescale/enetc/enetc.c                                  |    7 
 drivers/net/ethernet/freescale/fman/fman.c                                    |    4 
 drivers/net/ethernet/freescale/gianfar.c                                      |   16 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c                                  |   28 
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c                            |   31 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                       |  108 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h                       |    1 
 drivers/net/ethernet/ibm/emac/core.c                                          |   13 
 drivers/net/ethernet/intel/i40e/i40e_debug.h                                  |    2 
 drivers/net/ethernet/intel/ice/ice_common.c                                   |    1 
 drivers/net/ethernet/intel/ice/ice_dpll.c                                     |   20 
 drivers/net/ethernet/intel/ice/ice_eswitch.c                                  |    4 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                                  |   12 
 drivers/net/ethernet/intel/ice/ice_main.c                                     |   16 
 drivers/net/ethernet/intel/ice/ice_vf_lib.c                                   |    2 
 drivers/net/ethernet/intel/idpf/virtchnl2.h                                   |   12 
 drivers/net/ethernet/intel/igc/igc_main.c                                     |    2 
 drivers/net/ethernet/marvell/mvneta.c                                         |    3 
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c                               |    6 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c                       |    3 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c                       |   27 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                           |   15 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                           |   40 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c                     |   10 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                          |   83 -
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c                          |   22 
 drivers/net/ethernet/marvell/prestera/prestera_main.c                         |    2 
 drivers/net/ethernet/mediatek/mtk_ppe.c                                       |    4 
 drivers/net/ethernet/mediatek/mtk_wed_debugfs.c                               |    6 
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c                                   |    8 
 drivers/net/ethernet/mellanox/mlx5/core/en.h                                  |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c                    |   37 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c                     |   47 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                             |   14 
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c                            |    9 
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c                         |    3 
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c                           |    7 
 drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c                         |    8 
 drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.h                         |    6 
 drivers/net/ethernet/mellanox/mlx5/core/lib/port_tun.c                        |    3 
 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c                              |    1 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                                |   12 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c                    |    1 
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c                                |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c                         |    1 
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c                                    |    9 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c                                  |   11 
 drivers/net/ethernet/microchip/lan743x_main.c                                 |    2 
 drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.c                    |    5 
 drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c                      |    4 
 drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c                      |    5 
 drivers/net/ethernet/microchip/vcap/vcap_api.c                                |   72 -
 drivers/net/ethernet/microchip/vcap/vcap_api.h                                |    3 
 drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c                        |    8 
 drivers/net/ethernet/microchip/vcap/vcap_api_debugfs_kunit.c                  |    3 
 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c                          |    3 
 drivers/net/ethernet/microchip/vcap/vcap_api_private.h                        |    3 
 drivers/net/ethernet/microsoft/mana/gdma_main.c                               |    2 
 drivers/net/ethernet/microsoft/mana/mana_en.c                                 |    3 
 drivers/net/ethernet/oa_tc6.c                                                 |   11 
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c                           |   11 
 drivers/net/ethernet/qlogic/qede/qede_fp.c                                    |    9 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c                          |    5 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h                               |    1 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c                          |   72 -
 drivers/net/ethernet/sun/sungem.c                                             |   13 
 drivers/net/ethernet/sunplus/spl2sw_phy.c                                     |    6 
 drivers/net/ethernet/ti/icssg/icssg_common.c                                  |   49 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                                   |    1 
 drivers/net/ethernet/wangxun/libwx/wx_type.h                                  |    1 
 drivers/net/ieee802154/ca8210.c                                               |    9 
 drivers/net/macsec.c                                                          |    9 
 drivers/net/mdio/Kconfig                                                      |    3 
 drivers/net/ovpn/tcp.c                                                        |    2 
 drivers/net/pfcp.c                                                            |    1 
 drivers/net/phy/realtek/realtek_main.c                                        |    3 
 drivers/net/phy/sfp.c                                                         |    1 
 drivers/net/pse-pd/pse_core.c                                                 |    6 
 drivers/net/thunderbolt/main.c                                                |    8 
 drivers/net/usb/gl620a.c                                                      |    6 
 drivers/net/usb/lan78xx.c                                                     |   55 
 drivers/net/usb/net1080.c                                                     |    2 
 drivers/net/veth.c                                                            |    2 
 drivers/net/virtio_net.c                                                      |   27 
 drivers/net/vxlan/vxlan_core.c                                                |    8 
 drivers/net/wan/ixp4xx_hss.c                                                  |    4 
 drivers/net/wireless/ath/ath12k/dp_mon.c                                      |    6 
 drivers/net/wireless/ath/ath12k/mac.c                                         |   12 
 drivers/net/wireless/ath/ath9k/xmit.c                                         |    5 
 drivers/net/wireless/ath/wcn36xx/smd.c                                        |   13 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c                   |    6 
 drivers/net/wireless/marvell/libertas_tf/main.c                               |    2 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c                               |    2 
 drivers/net/wireless/marvell/mwifiex/join.c                                   |    1 
 drivers/net/wireless/mediatek/mt76/channel.c                                  |    2 
 drivers/net/wireless/mediatek/mt76/mac80211.c                                 |    4 
 drivers/net/wireless/mediatek/mt76/mt7615/init.c                              |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                               |   10 
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c                               |    5 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                               |   20 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                              |    4 
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c                               |    4 
 drivers/net/wireless/mediatek/mt76/mt7925/testmode.c                          |    5 
 drivers/net/wireless/mediatek/mt76/mt792x_core.c                              |    4 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                               |   35 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                              |    9 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                               |    5 
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                            |    3 
 drivers/net/wireless/mediatek/mt76/tx.c                                       |    2 
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c                                |   12 
 drivers/net/wireless/realtek/rtw88/pci.c                                      |   13 
 drivers/net/wireless/realtek/rtw89/core.h                                     |    3 
 drivers/net/wireless/realtek/rtw89/fw.c                                       |    2 
 drivers/net/wireless/realtek/rtw89/pci.c                                      |    8 
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c                                    |   40 
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c                                        |    3 
 drivers/net/wwan/t7xx/t7xx_port_wwan.c                                        |    2 
 drivers/ntb/hw/epf/ntb_hw_epf.c                                               |   81 -
 drivers/nvdimm/btt.c                                                          |   14 
 drivers/nvdimm/nd.h                                                           |   11 
 drivers/nvdimm/region_devs.c                                                  |   66 -
 drivers/nvme/host/apple.c                                                     |   12 
 drivers/nvme/host/core.c                                                      |    4 
 drivers/nvme/host/pci.c                                                       |   13 
 drivers/nvme/target/core.c                                                    |    2 
 drivers/nvme/target/fabrics-cmd-auth.c                                        |   26 
 drivers/nvme/target/rdma.c                                                    |   18 
 drivers/nvme/target/tcp.c                                                     |   16 
 drivers/of/cpu.c                                                              |    2 
 drivers/of/dynamic.c                                                          |    1 
 drivers/of/of_reserved_mem.c                                                  |   28 
 drivers/of/overlay.c                                                          |   15 
 drivers/of/platform.c                                                         |    5 
 drivers/opp/core.c                                                            |    5 
 drivers/pci/Makefile                                                          |    2 
 drivers/pci/controller/dwc/pci-imx6.c                                         |   35 
 drivers/pci/controller/dwc/pci-meson.c                                        |   13 
 drivers/pci/controller/dwc/pcie-designware-debugfs.c                          |   10 
 drivers/pci/controller/dwc/pcie-qcom.c                                        |    1 
 drivers/pci/controller/pci-loongson.c                                         |   31 
 drivers/pci/controller/pcie-iproc-bcma.c                                      |    2 
 drivers/pci/controller/pcie-iproc-platform.c                                  |    2 
 drivers/pci/controller/pcie-iproc.c                                           |    1 
 drivers/pci/controller/pcie-iproc.h                                           |    2 
 drivers/pci/controller/pcie-mediatek.c                                        |   21 
 drivers/pci/controller/pcie-rcar-host.c                                       |    1 
 drivers/pci/endpoint/functions/pci-epf-ntb.c                                  |   21 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                                 |    9 
 drivers/pci/iov.c                                                             |   15 
 drivers/pci/msi/msi.c                                                         |    4 
 drivers/pci/pci-sysfs.c                                                       |   17 
 drivers/pci/pci.c                                                             |  148 --
 drivers/pci/pci.h                                                             |   10 
 drivers/pci/rebar.c                                                           |  237 +++
 drivers/pci/rom.c                                                             |  149 ++
 drivers/pci/setup-bus.c                                                       |  136 +-
 drivers/pci/setup-res.c                                                       |   78 -
 drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c                               |   24 
 drivers/phy/phy-can-transceiver.c                                             |    3 
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c                                      |    6 
 drivers/pinctrl/mediatek/mtk-eint.c                                           |    6 
 drivers/pinctrl/mediatek/pinctrl-airoha.c                                     |  577 +++++----
 drivers/pinctrl/mediatek/pinctrl-mt8167.c                                     |    2 
 drivers/pinctrl/mediatek/pinctrl-mt8516.c                                     |    2 
 drivers/pinctrl/meson/pinctrl-amlogic-a4.c                                    |   15 
 drivers/pinctrl/meson/pinctrl-meson.c                                         |    2 
 drivers/pinctrl/nuvoton/pinctrl-ma35.c                                        |    3 
 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c                                      |  470 ++++---
 drivers/pinctrl/qcom/tlmm-test.c                                              |   19 
 drivers/pinctrl/spacemit/pinctrl-k1.c                                         |    2 
 drivers/pinctrl/sunxi/pinctrl-sun55i-a523-r.c                                 |    1 
 drivers/pinctrl/sunxi/pinctrl-sun55i-a523.c                                   |    1 
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                                         |    2 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                                     |   39 
 drivers/platform/x86/amd/pmc/pmc.c                                            |   83 +
 drivers/platform/x86/amd/pmc/pmc.h                                            |    2 
 drivers/platform/x86/dell/dell-laptop.c                                       |    5 
 drivers/platform/x86/intel/pmc/arl.c                                          |   12 
 drivers/platform/x86/intel/pmc/core.c                                         |  145 +-
 drivers/platform/x86/intel/pmc/core.h                                         |   10 
 drivers/platform/x86/intel/pmc/lnl.c                                          |    2 
 drivers/platform/x86/intel/pmc/mtl.c                                          |    9 
 drivers/platform/x86/intel/pmc/ptl.c                                          |    3 
 drivers/platform/x86/intel/pmc/ssram_telemetry.c                              |    2 
 drivers/platform/x86/intel/pmt/class.c                                        |    8 
 drivers/platform/x86/intel/pmt/class.h                                        |    5 
 drivers/platform/x86/intel/pmt/discovery.c                                    |    4 
 drivers/platform/x86/intel/pmt/telemetry.c                                    |   13 
 drivers/platform/x86/intel/pmt/telemetry.h                                    |   12 
 drivers/platform/x86/intel/sdsi.c                                             |    5 
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c                   |    2 
 drivers/platform/x86/intel/vsec.c                                             |   84 -
 drivers/platform/x86/intel/vsec_tpmi.c                                        |    8 
 drivers/platform/x86/xo15-ebook.c                                             |    7 
 drivers/pmdomain/imx/imx8m-blk-ctrl.c                                         |   46 
 drivers/power/sequencing/core.c                                               |    9 
 drivers/power/supply/bq257xx_charger.c                                        |    7 
 drivers/power/supply/charger-manager.c                                        |    6 
 drivers/power/supply/cpcap-battery.c                                          |   11 
 drivers/power/supply/max17042_battery.c                                       |    3 
 drivers/power/supply/power_supply_core.c                                      |   11 
 drivers/pwm/pwm-imx27.c                                                       |    8 
 drivers/pwm/pwm-rzg2l-gpt.c                                                   |    8 
 drivers/rapidio/devices/tsi721.c                                              |    3 
 drivers/regulator/core.c                                                      |    4 
 drivers/regulator/ltc3676.c                                                   |   10 
 drivers/remoteproc/qcom_common.c                                              |   14 
 drivers/reset/reset-sunxi.c                                                   |    4 
 drivers/rpmsg/qcom_glink_native.c                                             |    2 
 drivers/rpmsg/rpmsg_core.c                                                    |   43 
 drivers/rpmsg/virtio_rpmsg_bus.c                                              |    1 
 drivers/rtc/rtc-abx80x.c                                                      |    3 
 drivers/rtc/rtc-cmos.c                                                        |    6 
 drivers/rtc/rtc-ds1307.c                                                      |   30 
 drivers/rtc/rtc-isl1208.c                                                     |   15 
 drivers/rtc/rtc-mpfs.c                                                        |    2 
 drivers/rtc/rtc-msc313.c                                                      |    4 
 drivers/rtc/rtc-renesas-rtca3.c                                               |    2 
 drivers/s390/char/monwriter.c                                                 |    3 
 drivers/s390/crypto/pkey_api.c                                                |    8 
 drivers/s390/crypto/pkey_pckmo.c                                              |    4 
 drivers/scsi/elx/efct/efct_hw.c                                               |    2 
 drivers/scsi/elx/efct/efct_unsol.c                                            |    1 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                        |   12 
 drivers/scsi/hpsa.c                                                           |    4 
 drivers/scsi/lpfc/lpfc_init.c                                                 |    3 
 drivers/scsi/pm8001/pm8001_ctl.c                                              |    5 
 drivers/scsi/scsi_scan.c                                                      |    2 
 drivers/scsi/scsi_transport_sas.c                                             |  101 -
 drivers/scsi/sg.c                                                             |    7 
 drivers/scsi/smartpqi/smartpqi_init.c                                         |    2 
 drivers/soc/fsl/qe/qe.c                                                       |    3 
 drivers/soc/mediatek/mt8167-mmsys.h                                           |   11 
 drivers/soc/ti/k3-ringacc.c                                                   |    4 
 drivers/soc/xilinx/zynqmp_power.c                                             |    4 
 drivers/soundwire/generic_bandwidth_allocation.c                              |   47 
 drivers/soundwire/intel_ace2x.c                                               |    1 
 drivers/soundwire/stream.c                                                    |    7 
 drivers/spi/spi-atmel.c                                                       |  133 +-
 drivers/spi/spi-dw.h                                                          |    1 
 drivers/spi/spi-ep93xx.c                                                      |    1 
 drivers/spi/spi-hisi-kunpeng.c                                                |    6 
 drivers/spi/spi-meson-spifc.c                                                 |    1 
 drivers/spi/spi-rpc-if.c                                                      |    6 
 drivers/spi/spi-sh-msiof.c                                                    |   10 
 drivers/spi/spi-uniphier.c                                                    |    4 
 drivers/spi/spi-xilinx.c                                                      |   11 
 drivers/spi/spi.c                                                             |    5 
 drivers/staging/gpib/common/gpib_os.c                                         |    4 
 drivers/staging/media/atomisp/i2c/atomisp-gc2235.c                            |   29 
 drivers/staging/media/atomisp/pci/atomisp_cmd.c                               |    6 
 drivers/staging/media/atomisp/pci/sh_css.c                                    |    8 
 drivers/staging/media/sunxi/cedrus/cedrus.c                                   |    4 
 drivers/staging/most/video/video.c                                            |    7 
 drivers/staging/nvec/nvec.c                                                   |    4 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c                                |   93 -
 drivers/staging/rtl8723bs/core/rtw_security.c                                 |    2 
 drivers/target/iscsi/iscsi_target_auth.c                                      |    6 
 drivers/target/loopback/tcm_loop.c                                            |   64 -
 drivers/target/target_core_fabric_lib.c                                       |   89 +
 drivers/target/target_core_internal.h                                         |    3 
 drivers/target/target_core_pr.c                                               |   12 
 drivers/thermal/intel/therm_throt.c                                           |    7 
 drivers/thermal/testing/command.c                                             |   48 
 drivers/thermal/testing/thermal_testing.h                                     |    8 
 drivers/thermal/testing/zone.c                                                |    7 
 drivers/thermal/thermal_hwmon.c                                               |    5 
 drivers/thunderbolt/debugfs.c                                                 |    8 
 drivers/tty/serial/8250/8250_omap.c                                           |    3 
 drivers/tty/serial/max310x.c                                                  |   12 
 drivers/tty/serial/msm_serial.c                                               |    3 
 drivers/ufs/core/ufs_trace.h                                                  |   36 
 drivers/ufs/core/ufshcd.c                                                     |    2 
 drivers/usb/atm/ueagle-atm.c                                                  |   94 -
 drivers/usb/dwc3/core.c                                                       |   20 
 drivers/usb/dwc3/core.h                                                       |    4 
 drivers/usb/dwc3/ulpi.c                                                       |   25 
 drivers/usb/gadget/function/f_fs.c                                            |   89 -
 drivers/usb/host/max3421-hcd.c                                                |    8 
 drivers/vdpa/octeon_ep/octep_vdpa_main.c                                      |   20 
 drivers/vdpa/vdpa_user/vduse_dev.c                                            |   64 -
 drivers/vfio/pci/mlx5/cmd.h                                                   |   15 
 drivers/vfio/pci/qat/main.c                                                   |   16 
 drivers/vhost/net.c                                                           |   15 
 drivers/vhost/vdpa.c                                                          |   29 
 drivers/vhost/vhost.c                                                         |   11 
 drivers/video/fbdev/aty/radeon_base.c                                         |    1 
 drivers/video/fbdev/broadsheetfb.c                                            |    8 
 drivers/video/fbdev/carminefb.c                                               |    1 
 drivers/video/fbdev/core/fbcon.c                                              |   10 
 drivers/video/fbdev/efifb.c                                                   |    1 
 drivers/video/fbdev/hecubafb.c                                                |    6 
 drivers/video/fbdev/i740fb.c                                                  |    1 
 drivers/video/fbdev/metronomefb.c                                             |    8 
 drivers/video/fbdev/nvidia/nvidia.c                                           |    1 
 drivers/video/fbdev/s3fb.c                                                    |    1 
 drivers/video/fbdev/sm501fb.c                                                 |   16 
 drivers/video/fbdev/sm712.h                                                   |    2 
 drivers/video/fbdev/tdfxfb.c                                                  |    1 
 drivers/video/fbdev/tridentfb.c                                               |    1 
 drivers/video/fbdev/uvesafb.c                                                 |    4 
 drivers/video/fbdev/vesafb.c                                                  |    1 
 drivers/virtio/virtio_rtc_driver.c                                            |   28 
 drivers/watchdog/sama5d4_wdt.c                                                |   48 
 drivers/watchdog/sp5100_tco.c                                                 |    3 
 drivers/watchdog/sprd_wdt.c                                                   |    5 
 drivers/watchdog/watchdog_core.c                                              |    3 
 drivers/xen/gntdev.c                                                          |    8 
 drivers/xen/xen-scsiback.c                                                    |   30 
 fs/9p/vfs_inode.c                                                             |   28 
 fs/9p/vfs_inode_dotl.c                                                        |    4 
 fs/afs/callback.c                                                             |    7 
 fs/afs/cell.c                                                                 |   27 
 fs/afs/cm_security.c                                                          |    3 
 fs/afs/cmservice.c                                                            |    7 
 fs/afs/dir.c                                                                  |   40 
 fs/afs/dynroot.c                                                              |    2 
 fs/afs/fs_operation.c                                                         |    2 
 fs/afs/inode.c                                                                |    2 
 fs/afs/internal.h                                                             |    1 
 fs/afs/rxrpc.c                                                                |   16 
 fs/afs/super.c                                                                |    5 
 fs/afs/vl_list.c                                                              |   10 
 fs/afs/volume.c                                                               |    2 
 fs/bpf_fs_kfuncs.c                                                            |   10 
 fs/btrfs/compression.c                                                        |   20 
 fs/btrfs/direct-io.c                                                          |   69 +
 fs/btrfs/extent-tree.c                                                        |    5 
 fs/btrfs/extent_io.c                                                          |   72 -
 fs/btrfs/inode.c                                                              |   14 
 fs/btrfs/ordered-data.c                                                       |   41 
 fs/btrfs/ordered-data.h                                                       |    8 
 fs/btrfs/reflink.c                                                            |  101 -
 fs/btrfs/super.c                                                              |    4 
 fs/btrfs/zoned.c                                                              |   64 -
 fs/configfs/dir.c                                                             |   57 
 fs/dlm/midcomms.c                                                             |    4 
 fs/efs/file.c                                                                 |   21 
 fs/eventpoll.c                                                                |  593 +++++++---
 fs/exfat/dir.c                                                                |   49 
 fs/exfat/exfat_fs.h                                                           |    5 
 fs/exfat/namei.c                                                              |   89 +
 fs/ext2/file.c                                                                |    9 
 fs/ext4/ext4.h                                                                |   20 
 fs/ext4/fast_commit.c                                                         |   50 
 fs/ext4/inode.c                                                               |    3 
 fs/ext4/ioctl.c                                                               |   12 
 fs/ext4/namei.c                                                               |    2 
 fs/fhandle.c                                                                  |    2 
 fs/fs-writeback.c                                                             |    5 
 fs/fuse/control.c                                                             |    7 
 fs/hfs/bfind.c                                                                |    2 
 fs/hfs/bnode.c                                                                |   54 
 fs/hfs/brec.c                                                                 |    2 
 fs/hfs/btree.c                                                                |    2 
 fs/hfs/btree.h                                                                |   71 -
 fs/hfs/hfs_fs.h                                                               |   88 -
 fs/hfs/inode.c                                                                |    3 
 fs/hfsplus/bfind.c                                                            |    2 
 fs/hfsplus/bnode.c                                                            |   60 -
 fs/hfsplus/brec.c                                                             |    2 
 fs/hfsplus/btree.c                                                            |    2 
 fs/hfsplus/hfsplus_fs.h                                                       |   40 
 fs/iomap/ioend.c                                                              |    8 
 fs/jbd2/journal.c                                                             |    2 
 fs/kernfs/dir.c                                                               |   11 
 fs/libfs.c                                                                    |   13 
 fs/lockd/svcsubs.c                                                            |    4 
 fs/minix/minix.h                                                              |    2 
 fs/namei.c                                                                    |    4 
 fs/netfs/write_issue.c                                                        |   18 
 fs/nfs/callback_proc.c                                                        |    9 
 fs/nfs/delegation.c                                                           |    9 
 fs/nfs/filelayout/filelayout.c                                                |    2 
 fs/nfs/flexfilelayout/flexfilelayout.c                                        |   29 
 fs/nfs/flexfilelayout/flexfilelayout.h                                        |   16 
 fs/nfs/fs_context.c                                                           |    8 
 fs/nfs/internal.h                                                             |   12 
 fs/nfs/nfs4proc.c                                                             |   22 
 fs/nfs/pnfs.c                                                                 |    4 
 fs/nfs/pnfs_nfs.c                                                             |    2 
 fs/nfs/read.c                                                                 |   25 
 fs/nfs/write.c                                                                |   14 
 fs/nfsd/nfs4state.c                                                           |   16 
 fs/nilfs2/namei.c                                                             |    2 
 fs/nilfs2/super.c                                                             |    2 
 fs/ntfs3/fslog.c                                                              |  149 ++
 fs/ntfs3/index.c                                                              |   45 
 fs/ntfs3/lznt.c                                                               |    2 
 fs/ntfs3/namei.c                                                              |    2 
 fs/ntfs3/ntfs_fs.h                                                            |    3 
 fs/ntfs3/run.c                                                                |    9 
 fs/ocfs2/alloc.c                                                              |    2 
 fs/ocfs2/aops.c                                                               |   13 
 fs/ocfs2/buffer_head_io.c                                                     |    7 
 fs/ocfs2/dlm/dlmdebug.c                                                       |   16 
 fs/ocfs2/dlmglue.c                                                            |   17 
 fs/ocfs2/inode.c                                                              |  182 +++
 fs/ocfs2/journal.c                                                            |   13 
 fs/ocfs2/journal.h                                                            |    3 
 fs/ocfs2/move_extents.c                                                       |    4 
 fs/ocfs2/ocfs2.h                                                              |    2 
 fs/ocfs2/quota_local.c                                                        |    2 
 fs/ocfs2/stack_user.c                                                         |   10 
 fs/ocfs2/super.c                                                              |    2 
 fs/ocfs2/sysfile.c                                                            |    9 
 fs/orangefs/dir.c                                                             |    7 
 fs/overlayfs/inode.c                                                          |    4 
 fs/proc/array.c                                                               |   15 
 fs/proc/base.c                                                                |  182 +--
 fs/proc/fd.c                                                                  |   33 
 fs/proc/generic.c                                                             |    9 
 fs/proc/internal.h                                                            |    6 
 fs/proc/namespaces.c                                                          |   16 
 fs/proc/page.c                                                                |    2 
 fs/proc/proc_net.c                                                            |    2 
 fs/proc/task_mmu.c                                                            |   61 -
 fs/resctrl/rdtgroup.c                                                         |   15 
 fs/smb/client/Makefile                                                        |    5 
 fs/smb/client/cifssmb.c                                                       |    5 
 fs/smb/client/cifstransport.c                                                 |  565 ---------
 fs/smb/client/connect.c                                                       |    3 
 fs/smb/client/file.c                                                          |    1 
 fs/smb/client/inode.c                                                         |   30 
 fs/smb/client/ioctl.c                                                         |   12 
 fs/smb/client/misc.c                                                          |    8 
 fs/smb/client/smb1transport.c                                                 |  565 +++++++++
 fs/smb/client/smb2ops.c                                                       |   38 
 fs/smb/server/Kconfig                                                         |    6 
 fs/smb/server/auth.c                                                          |  396 +-----
 fs/smb/server/auth.h                                                          |   10 
 fs/smb/server/connection.c                                                    |  101 +
 fs/smb/server/connection.h                                                    |    6 
 fs/smb/server/crypto_ctx.c                                                    |   24 
 fs/smb/server/crypto_ctx.h                                                    |   15 
 fs/smb/server/misc.c                                                          |   33 
 fs/smb/server/misc.h                                                          |    1 
 fs/smb/server/oplock.c                                                        |   13 
 fs/smb/server/server.c                                                        |   16 
 fs/smb/server/smb2pdu.c                                                       |   78 -
 fs/smb/server/smb_common.h                                                    |    2 
 fs/smb/server/smbacl.c                                                        |    7 
 fs/smb/server/vfs.c                                                           |   58 
 fs/smb/server/vfs_cache.c                                                     |  114 +
 fs/smb/server/vfs_cache.h                                                     |    1 
 fs/super.c                                                                    |   11 
 fs/sysfs/file.c                                                               |    4 
 fs/udf/super.c                                                                |    2 
 fs/xfs/libxfs/xfs_group.h                                                     |    9 
 fs/xfs/libxfs/xfs_rtgroup.h                                                   |    8 
 fs/xfs/xfs_iomap.c                                                            |    2 
 fs/xfs/xfs_rtalloc.c                                                          |    8 
 fs/xfs/xfs_zone_gc.c                                                          |   13 
 fs/xfs/xfs_zone_space_resv.c                                                  |    8 
 include/acpi/acpi_bus.h                                                       |    2 
 include/asm-generic/bitops/lock.h                                             |   22 
 include/dt-bindings/clock/qcom,x1e80100-camcc.h                               |    3 
 include/dt-bindings/power/fsl,imx93-power.h                                   |    1 
 include/linux/amba/bus.h                                                      |    5 
 include/linux/arm-smccc.h                                                     |    5 
 include/linux/bpf-cgroup.h                                                    |    5 
 include/linux/bpf.h                                                           |    4 
 include/linux/bpf_local_storage.h                                             |    3 
 include/linux/bpf_lsm.h                                                       |   10 
 include/linux/cdx/cdx_bus.h                                                   |    4 
 include/linux/device.h                                                        |    5 
 include/linux/dpll.h                                                          |    2 
 include/linux/firmware.h                                                      |   10 
 include/linux/fs.h                                                            |    3 
 include/linux/fwnode.h                                                        |    1 
 include/linux/host1x.h                                                        |    7 
 include/linux/hyperv.h                                                        |    5 
 include/linux/i3c/master.h                                                    |   25 
 include/linux/ieee80211-eht.h                                                 |   12 
 include/linux/inetdevice.h                                                    |    5 
 include/linux/intel_vsec.h                                                    |   30 
 include/linux/iommu.h                                                         |    1 
 include/linux/netdevice.h                                                     |    4 
 include/linux/nfs_page.h                                                      |    1 
 include/linux/nfs_xdr.h                                                       |    1 
 include/linux/pci.h                                                           |    3 
 include/linux/platform_data/mipi-i3c-hci.h                                    |   15 
 include/linux/rpmsg.h                                                         |    4 
 include/linux/seqlock.h                                                       |  110 +
 include/linux/sunrpc/clnt.h                                                   |    1 
 include/linux/sunrpc/xprt.h                                                   |    2 
 include/linux/uaccess.h                                                       |    2 
 include/linux/vmalloc.h                                                       |    4 
 include/net/addrconf.h                                                        |   10 
 include/net/bluetooth/hci.h                                                   |    5 
 include/net/bluetooth/l2cap.h                                                 |   10 
 include/net/bond_options.h                                                    |    1 
 include/net/bonding.h                                                         |    1 
 include/net/fib_rules.h                                                       |    5 
 include/net/gue.h                                                             |    2 
 include/net/inet_common.h                                                     |    3 
 include/net/ip.h                                                              |    2 
 include/net/ip_fib.h                                                          |    7 
 include/net/ip_vs.h                                                           |    3 
 include/net/ipv6.h                                                            |    6 
 include/net/netfilter/nf_conntrack_extend.h                                   |   12 
 include/net/netfilter/nf_flow_table.h                                         |    6 
 include/net/netfilter/nf_queue.h                                              |    1 
 include/net/netfilter/nft_meta.h                                              |    2 
 include/net/ping.h                                                            |    5 
 include/net/sctp/sctp.h                                                       |    3 
 include/net/sock.h                                                            |    2 
 include/net/tc_act/tc_pedit.h                                                 |   18 
 include/net/tcp.h                                                             |   11 
 include/net/xfrm.h                                                            |   15 
 include/rdma/ib_umem.h                                                        |    4 
 include/rdma/rdma_vt.h                                                        |   20 
 include/uapi/linux/bpf.h                                                      |    2 
 include/uapi/linux/if_link.h                                                  |    1 
 init/initramfs_test.c                                                         |   17 
 kernel/bpf/bpf_inode_storage.c                                                |    9 
 kernel/bpf/bpf_lru_list.c                                                     |  165 +-
 kernel/bpf/bpf_lru_list.h                                                     |   25 
 kernel/bpf/bpf_lsm.c                                                          |   23 
 kernel/bpf/cgroup.c                                                           |  168 +-
 kernel/bpf/core.c                                                             |    2 
 kernel/bpf/devmap.c                                                           |   12 
 kernel/bpf/hashtab.c                                                          |   21 
 kernel/bpf/helpers.c                                                          |   29 
 kernel/bpf/inode.c                                                            |   13 
 kernel/bpf/lpm_trie.c                                                         |    8 
 kernel/bpf/map_in_map.c                                                       |    5 
 kernel/bpf/map_iter.c                                                         |    4 
 kernel/bpf/syscall.c                                                          |   23 
 kernel/bpf/verifier.c                                                         |  186 +--
 kernel/cgroup/cpuset.c                                                        |    7 
 kernel/cpu.c                                                                  |   20 
 kernel/fork.c                                                                 |    9 
 kernel/kcov.c                                                                 |    4 
 kernel/locking/spinlock_rt.c                                                  |   27 
 kernel/sched/core.c                                                           |    1 
 kernel/sched/cpufreq_schedutil.c                                              |    1 
 kernel/sched/debug.c                                                          |    3 
 kernel/sched/fair.c                                                           |   23 
 kernel/taskstats.c                                                            |   62 -
 kernel/time/alarmtimer.c                                                      |    2 
 kernel/time/posix-cpu-timers.c                                                |    2 
 kernel/time/tick-sched.c                                                      |   11 
 kernel/time/time.c                                                            |    2 
 kernel/trace/bpf_trace.c                                                      |   11 
 kernel/trace/fprobe.c                                                         |   10 
 kernel/trace/ring_buffer.c                                                    |    3 
 kernel/trace/trace.c                                                          |    2 
 kernel/trace/trace_eprobe.c                                                   |    2 
 kernel/trace/trace_events_hist.c                                              |   41 
 kernel/trace/trace_events_user.c                                              |   39 
 kernel/trace/trace_osnoise.c                                                  |    4 
 kernel/trace/trace_probe.c                                                    |  174 ++
 kernel/trace/trace_probe.h                                                    |    7 
 kernel/workqueue.c                                                            |    2 
 lib/alloc_tag.c                                                               |    9 
 lib/locking-selftest.c                                                        |    7 
 lib/test_meminit.c                                                            |    2 
 lib/tests/kunit_iov_iter.c                                                    |   12 
 lib/vsprintf.c                                                                |   36 
 mm/compaction.c                                                               |    7 
 mm/damon/core.c                                                               |   53 
 mm/damon/sysfs-schemes.c                                                      |   17 
 mm/hugetlb.c                                                                  |    7 
 mm/memory_hotplug.c                                                           |    2 
 mm/mm_init.c                                                                  |   47 
 mm/numa_emulation.c                                                           |   17 
 net/9p/client.c                                                               |    2 
 net/9p/trans_rdma.c                                                           |   19 
 net/atm/common.c                                                              |    2 
 net/batman-adv/distributed-arp-table.c                                        |   30 
 net/batman-adv/fragmentation.c                                                |    8 
 net/batman-adv/gateway_client.c                                               |    3 
 net/batman-adv/main.c                                                         |   13 
 net/batman-adv/mesh-interface.c                                               |   17 
 net/batman-adv/mesh-interface.h                                               |    2 
 net/batman-adv/multicast_forw.c                                               |    7 
 net/batman-adv/routing.c                                                      |    3 
 net/batman-adv/translation-table.c                                            |    5 
 net/bluetooth/6lowpan.c                                                       |   58 
 net/bluetooth/eir.c                                                           |    8 
 net/bluetooth/hci_codec.c                                                     |    2 
 net/bluetooth/hci_core.c                                                      |    2 
 net/bluetooth/hci_event.c                                                     |    7 
 net/bluetooth/l2cap_core.c                                                    |   94 +
 net/bluetooth/l2cap_sock.c                                                    |  103 -
 net/bluetooth/mgmt.c                                                          |    2 
 net/bluetooth/msft.c                                                          |    2 
 net/bluetooth/sco.c                                                           |   75 -
 net/bluetooth/smp.c                                                           |   27 
 net/bridge/br_cfm.c                                                           |    6 
 net/bridge/br_cfm_netlink.c                                                   |    4 
 net/bridge/br_if.c                                                            |    3 
 net/bridge/br_stp.c                                                           |    3 
 net/bridge/netfilter/nft_meta_bridge.c                                        |   23 
 net/can/bcm.c                                                                 |  127 +-
 net/can/isotp.c                                                               |  298 +++--
 net/core/dev.c                                                                |    3 
 net/core/fib_rules.c                                                          |    6 
 net/core/filter.c                                                             |   28 
 net/core/flow_dissector.c                                                     |   12 
 net/core/lwt_bpf.c                                                            |   12 
 net/core/netdev-genl.c                                                        |    4 
 net/core/sock.c                                                               |    7 
 net/devlink/rate.c                                                            |   25 
 net/handshake/genl.c                                                          |    2 
 net/ieee802154/core.c                                                         |   51 
 net/ieee802154/header_ops.c                                                   |    9 
 net/ieee802154/ieee802154.h                                                   |   17 
 net/ieee802154/netlink.c                                                      |   36 
 net/ieee802154/socket.c                                                       |    6 
 net/ife/ife.c                                                                 |    2 
 net/ipv4/af_inet.c                                                            |   17 
 net/ipv4/igmp.c                                                               |   63 -
 net/ipv4/inet_connection_sock.c                                               |    7 
 net/ipv4/ip_sockglue.c                                                        |    4 
 net/ipv4/ip_vti.c                                                             |    3 
 net/ipv4/ipip.c                                                               |    3 
 net/ipv4/netfilter/nf_reject_ipv4.c                                           |    2 
 net/ipv4/ping.c                                                               |    9 
 net/ipv4/raw.c                                                                |    6 
 net/ipv4/tcp.c                                                                |    5 
 net/ipv4/tcp_bpf.c                                                            |   17 
 net/ipv4/tcp_ipv4.c                                                           |    4 
 net/ipv4/tcp_output.c                                                         |    8 
 net/ipv4/udp.c                                                                |    9 
 net/ipv4/udp_bpf.c                                                            |   25 
 net/ipv4/udp_impl.h                                                           |    3 
 net/ipv4/udp_tunnel_nic.c                                                     |    2 
 net/ipv6/addrconf.c                                                           |   55 
 net/ipv6/af_inet6.c                                                           |   11 
 net/ipv6/datagram.c                                                           |    9 
 net/ipv6/ioam6_iptunnel.c                                                     |    8 
 net/ipv6/ip6_fib.c                                                            |   17 
 net/ipv6/ip6_gre.c                                                            |    6 
 net/ipv6/ip6_tunnel.c                                                         |    3 
 net/ipv6/ip6_vti.c                                                            |    3 
 net/ipv6/mcast.c                                                              |   40 
 net/ipv6/ndisc.c                                                              |    8 
 net/ipv6/netfilter.c                                                          |    4 
 net/ipv6/netfilter/ip6t_ah.c                                                  |    5 
 net/ipv6/netfilter/ip6t_hbh.c                                                 |    1 
 net/ipv6/netfilter/ip6t_rt.c                                                  |    3 
 net/ipv6/netfilter/nf_conntrack_reasm.c                                       |    3 
 net/ipv6/ping.c                                                               |    3 
 net/ipv6/raw.c                                                                |    8 
 net/ipv6/route.c                                                              |    9 
 net/ipv6/seg6.c                                                               |    3 
 net/ipv6/sit.c                                                                |    3 
 net/ipv6/udp.c                                                                |   10 
 net/ipv6/udp_impl.h                                                           |    3 
 net/kcm/kcmsock.c                                                             |    8 
 net/l2tp/l2tp_ip.c                                                            |    4 
 net/l2tp/l2tp_ip6.c                                                           |    6 
 net/llc/af_llc.c                                                              |    1 
 net/llc/llc_conn.c                                                            |    1 
 net/mac80211/main.c                                                           |    3 
 net/mac80211/tx.c                                                             |   17 
 net/mac802154/iface.c                                                         |    2 
 net/mac802154/scan.c                                                          |    1 
 net/mptcp/protocol.c                                                          |    4 
 net/netfilter/Makefile                                                        |    1 
 net/netfilter/ipset/ip_set_core.c                                             |    4 
 net/netfilter/ipset/ip_set_hash_gen.h                                         |   69 -
 net/netfilter/ipvs/ip_vs_app.c                                                |   10 
 net/netfilter/ipvs/ip_vs_conn.c                                               |    4 
 net/netfilter/ipvs/ip_vs_core.c                                               |   36 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                                         |   18 
 net/netfilter/ipvs/ip_vs_proto_tcp.c                                          |   11 
 net/netfilter/ipvs/ip_vs_proto_udp.c                                          |    3 
 net/netfilter/ipvs/ip_vs_xmit.c                                               |    6 
 net/netfilter/nf_conncount.c                                                  |   23 
 net/netfilter/nf_conntrack_core.c                                             |   83 -
 net/netfilter/nf_conntrack_ecache.c                                           |    2 
 net/netfilter/nf_conntrack_extend.c                                           |   32 
 net/netfilter/nf_conntrack_irc.c                                              |    6 
 net/netfilter/nf_conntrack_seqadj.c                                           |    2 
 net/netfilter/nf_flow_table_path.c                                            |  276 ++++
 net/netfilter/nf_nat_core.c                                                   |   10 
 net/netfilter/nf_nat_sip.c                                                    |   11 
 net/netfilter/nf_queue.c                                                      |   14 
 net/netfilter/nf_synproxy_core.c                                              |   40 
 net/netfilter/nf_tables_api.c                                                 |    3 
 net/netfilter/nfnetlink_cthelper.c                                            |   24 
 net/netfilter/nfnetlink_osf.c                                                 |    6 
 net/netfilter/nfnetlink_queue.c                                               |    3 
 net/netfilter/nft_compat.c                                                    |   24 
 net/netfilter/nft_flow_offload.c                                              |  259 ----
 net/netfilter/nft_lookup.c                                                    |   10 
 net/netfilter/nft_meta.c                                                      |    5 
 net/netfilter/nft_payload.c                                                   |   16 
 net/netfilter/nft_set_pipapo.c                                                |   34 
 net/netfilter/nft_set_pipapo.h                                                |    8 
 net/netfilter/nft_set_rbtree.c                                                |    8 
 net/netfilter/nft_synproxy.c                                                  |    9 
 net/netfilter/xt_cluster.c                                                    |    2 
 net/netfilter/xt_connmark.c                                                   |   14 
 net/netfilter/xt_nat.c                                                        |    9 
 net/netfilter/xt_rateest.c                                                    |    2 
 net/netfilter/xt_u32.c                                                        |   12 
 net/openvswitch/conntrack.c                                                   |    2 
 net/openvswitch/flow_netlink.c                                                |  201 ++-
 net/phonet/datagram.c                                                         |    4 
 net/phonet/pep.c                                                              |    2 
 net/psample/psample.c                                                         |    6 
 net/qrtr/af_qrtr.c                                                            |    2 
 net/rxrpc/ar-internal.h                                                       |    6 
 net/rxrpc/call_accept.c                                                       |   25 
 net/rxrpc/call_event.c                                                        |    5 
 net/rxrpc/call_object.c                                                       |    2 
 net/rxrpc/conn_client.c                                                       |    2 
 net/rxrpc/conn_event.c                                                        |    9 
 net/rxrpc/input.c                                                             |   39 
 net/rxrpc/oob.c                                                               |   12 
 net/rxrpc/recvmsg.c                                                           |   23 
 net/rxrpc/rxgk.c                                                              |    3 
 net/rxrpc/sendmsg.c                                                           |    3 
 net/sched/act_api.c                                                           |   13 
 net/sched/act_bpf.c                                                           |    2 
 net/sched/act_ct.c                                                            |   13 
 net/sched/act_pedit.c                                                         |   13 
 net/sched/cls_api.c                                                           |   25 
 net/sched/cls_bpf.c                                                           |   10 
 net/sched/cls_flow.c                                                          |   12 
 net/sched/sch_cake.c                                                          |    5 
 net/sched/sch_codel.c                                                         |   48 
 net/sched/sch_drr.c                                                           |    8 
 net/sched/sch_dualpi2.c                                                       |   48 
 net/sched/sch_fq_codel.c                                                      |   41 
 net/sched/sch_generic.c                                                       |   41 
 net/sched/sch_hfsc.c                                                          |   24 
 net/sched/sch_hhf.c                                                           |   27 
 net/sched/sch_htb.c                                                           |   14 
 net/sched/sch_multiq.c                                                        |    2 
 net/sched/sch_taprio.c                                                        |    2 
 net/sched/sch_teql.c                                                          |  128 +-
 net/sctp/diag.c                                                               |   67 -
 net/sctp/protocol.c                                                           |    3 
 net/sctp/sm_make_chunk.c                                                      |   15 
 net/sctp/sm_statefuns.c                                                       |   59 
 net/sctp/socket.c                                                             |   50 
 net/smc/smc_cdc.c                                                             |   15 
 net/sunrpc/clnt.c                                                             |   19 
 net/sunrpc/svc.c                                                              |   10 
 net/sunrpc/svcsock.c                                                          |   10 
 net/sunrpc/sysfs.c                                                            |    4 
 net/sunrpc/xdr.c                                                              |   14 
 net/sunrpc/xprt.c                                                             |   16 
 net/sunrpc/xprtrdma/backchannel.c                                             |    5 
 net/sunrpc/xprtrdma/frwr_ops.c                                                |    2 
 net/sunrpc/xprtrdma/rpc_rdma.c                                                |  171 ++
 net/sunrpc/xprtrdma/transport.c                                               |   85 +
 net/sunrpc/xprtrdma/verbs.c                                                   |  126 +-
 net/sunrpc/xprtrdma/xprt_rdma.h                                               |    4 
 net/sunrpc/xprtsock.c                                                         |   16 
 net/tipc/bearer.c                                                             |    1 
 net/tipc/core.c                                                               |    5 
 net/tipc/discover.c                                                           |   14 
 net/tipc/name_distr.c                                                         |   13 
 net/tipc/netlink.c                                                            |   12 
 net/tipc/socket.c                                                             |    9 
 net/tls/tls.h                                                                 |    2 
 net/tls/tls_sw.c                                                              |   14 
 net/unix/af_unix.c                                                            |   39 
 net/unix/unix_bpf.c                                                           |    2 
 net/vmw_vsock/af_vsock.c                                                      |    4 
 net/vmw_vsock/vsock_bpf.c                                                     |    2 
 net/wireless/nl80211.c                                                        |    2 
 net/wireless/scan.c                                                           |    5 
 net/xfrm/espintcp.c                                                           |   36 
 net/xfrm/xfrm_interface_core.c                                                |    3 
 net/xfrm/xfrm_nat_keepalive.c                                                 |   15 
 net/xfrm/xfrm_policy.c                                                        |   27 
 net/xfrm/xfrm_state.c                                                         |   26 
 net/xfrm/xfrm_user.c                                                          |   20 
 rust/kernel/alloc/kvec.rs                                                     |    4 
 samples/damon/mtier.c                                                         |    2 
 samples/trace_events/trace-events-sample.c                                    |    4 
 scripts/kconfig/conf.c                                                        |    6 
 security/apparmor/af_unix.c                                                   |   71 -
 security/apparmor/apparmorfs.c                                                |  113 +
 security/apparmor/domain.c                                                    |   58 
 security/apparmor/file.c                                                      |   12 
 security/apparmor/include/apparmorfs.h                                        |   12 
 security/apparmor/label.c                                                     |    2 
 security/apparmor/net.c                                                       |    1 
 security/apparmor/policy.c                                                    |   20 
 security/apparmor/policy_unpack.c                                             |    6 
 security/apparmor/procattr.c                                                  |    2 
 security/bpf/hooks.c                                                          |    3 
 security/integrity/evm/evm_secfs.c                                            |   16 
 security/keys/keyring.c                                                       |    2 
 security/landlock/fs.c                                                        |   14 
 security/landlock/fs.h                                                        |   10 
 security/landlock/net.c                                                       |   11 
 security/landlock/task.c                                                      |   11 
 security/selinux/hooks.c                                                      |   80 -
 sound/core/init.c                                                             |   11 
 sound/core/seq/oss/seq_oss_event.c                                            |    6 
 sound/core/seq/oss/seq_oss_event.h                                            |    3 
 sound/core/seq/oss/seq_oss_ioctl.c                                            |    5 
 sound/core/seq/oss/seq_oss_midi.c                                             |    6 
 sound/core/seq/oss/seq_oss_midi.h                                             |    2 
 sound/core/seq/oss/seq_oss_readq.c                                            |   77 -
 sound/core/seq/oss/seq_oss_rw.c                                               |    5 
 sound/core/seq/seq_clientmgr.c                                                |   33 
 sound/core/seq/seq_fifo.c                                                     |   52 
 sound/core/seq/seq_memory.c                                                   |    2 
 sound/core/seq/seq_midi.c                                                     |   55 
 sound/drivers/aloop.c                                                         |    1 
 sound/hda/codecs/conexant.c                                                   |    3 
 sound/hda/codecs/realtek/alc269.c                                             |    2 
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c                                |    3 
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c                                |    3 
 sound/hda/controllers/Kconfig                                                 |    2 
 sound/hda/core/regmap.c                                                       |    4 
 sound/soc/amd/acp/acp-sdw-legacy-mach.c                                       |    7 
 sound/soc/amd/acp/acp-sdw-sof-mach.c                                          |    7 
 sound/soc/codecs/adau1372.c                                                   |    5 
 sound/soc/codecs/aw88261.c                                                    |   12 
 sound/soc/codecs/cs35l56-shared.c                                             |    1 
 sound/soc/codecs/cs35l56.c                                                    |   14 
 sound/soc/codecs/hdac_hdmi.c                                                  |    4 
 sound/soc/codecs/lpass-va-macro.c                                             |    8 
 sound/soc/codecs/sma1307.c                                                    |   35 
 sound/soc/codecs/tlv320aic3x.c                                                |   25 
 sound/soc/fsl/fsl_asrc_dma.c                                                  |   20 
 sound/soc/fsl/fsl_audmix.c                                                    |    6 
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c                                    |   23 
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c                                    |   21 
 sound/soc/qcom/qdsp6/q6apm.c                                                  |    8 
 sound/soc/renesas/rcar/rsnd.h                                                 |    2 
 sound/soc/sof/intel/Kconfig                                                   |    4 
 sound/soc/sof/ipc3-control.c                                                  |   79 +
 sound/soc/sof/ipc4-control.c                                                  |   11 
 sound/soc/sof/topology.c                                                      |    5 
 sound/soc/tegra/tegra210_ahub.c                                               |    4 
 sound/usb/fcp.c                                                               |    2 
 sound/usb/midi2.c                                                             |    5 
 sound/usb/mixer_scarlett2.c                                                   |  201 +++
 sound/usb/qcom/mixer_usb_offload.c                                            |    2 
 sound/usb/qcom/qc_audio_offload.c                                             |   30 
 sound/xen/xen_snd_front_alsa.c                                                |   17 
 sound/xen/xen_snd_front_evtchnl.c                                             |   28 
 sound/xen/xen_snd_front_evtchnl.h                                             |    6 
 tools/bpf/bpftool/cgroup.c                                                    |   14 
 tools/bpf/bpftool/gen.c                                                       |    2 
 tools/bpf/bpftool/net.c                                                       |    4 
 tools/include/linux/args.h                                                    |    4 
 tools/include/nolibc/getopt.h                                                 |    2 
 tools/include/uapi/linux/bpf.h                                                |    2 
 tools/include/uapi/linux/if_link.h                                            |    2 
 tools/lib/api/fs/fs.c                                                         |   19 
 tools/lib/bpf/gen_loader.c                                                    |   81 -
 tools/lib/bpf/libbpf.c                                                        |    9 
 tools/lib/bpf/strset.c                                                        |   62 -
 tools/lib/bpf/usdt.c                                                          |   16 
 tools/lib/symbol/kallsyms.c                                                   |    5 
 tools/perf/Documentation/perf-inject.txt                                      |    5 
 tools/perf/Makefile.config                                                    |    1 
 tools/perf/arch/arm64/util/header.c                                           |    1 
 tools/perf/arch/common.c                                                      |    4 
 tools/perf/arch/powerpc/util/auxtrace.c                                       |    6 
 tools/perf/arch/x86/tests/amd-ibs-period.c                                    |    2 
 tools/perf/arch/x86/tests/bp-modify.c                                         |   30 
 tools/perf/bench/inject-buildid.c                                             |    2 
 tools/perf/bench/uprobe.c                                                     |    2 
 tools/perf/builtin-annotate.c                                                 |    3 
 tools/perf/builtin-buildid-cache.c                                            |   12 
 tools/perf/builtin-buildid-list.c                                             |    4 
 tools/perf/builtin-c2c.c                                                      |   24 
 tools/perf/builtin-daemon.c                                                   |    8 
 tools/perf/builtin-diff.c                                                     |   15 
 tools/perf/builtin-inject.c                                                   |  157 ++
 tools/perf/builtin-list.c                                                     |    4 
 tools/perf/builtin-probe.c                                                    |    3 
 tools/perf/builtin-record.c                                                   |   25 
 tools/perf/builtin-report.c                                                   |    3 
 tools/perf/builtin-sched.c                                                    |  122 +-
 tools/perf/builtin-stat.c                                                     |   59 
 tools/perf/builtin-trace.c                                                    |   28 
 tools/perf/jvmti/libjvmti.c                                                   |    2 
 tools/perf/perf.c                                                             |   18 
 tools/perf/tests/code-reading.c                                               |    7 
 tools/perf/tests/pe-file-parsing.c                                            |    4 
 tools/perf/tests/pmu-events.c                                                 |   24 
 tools/perf/tests/sdt.c                                                        |    2 
 tools/perf/ui/browser.c                                                       |    3 
 tools/perf/ui/browsers/annotate.c                                             |    5 
 tools/perf/util/bpf-event.c                                                   |   66 -
 tools/perf/util/bpf-event.h                                                   |    4 
 tools/perf/util/bpf-utils.c                                                   |   20 
 tools/perf/util/bpf_lock_contention.c                                         |    2 
 tools/perf/util/build-id.c                                                    |    4 
 tools/perf/util/cap.c                                                         |    3 
 tools/perf/util/cpumap.c                                                      |   49 
 tools/perf/util/cs-etm-base.c                                                 |    4 
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c                               |   21 
 tools/perf/util/cs-etm.c                                                      |  283 +++-
 tools/perf/util/cs-etm.h                                                      |    8 
 tools/perf/util/data.c                                                        |   29 
 tools/perf/util/debuginfo.c                                                   |   11 
 tools/perf/util/demangle-java.c                                               |    2 
 tools/perf/util/disasm.c                                                      |    7 
 tools/perf/util/dso.c                                                         |   65 -
 tools/perf/util/dsos.c                                                        |    4 
 tools/perf/util/env.h                                                         |   14 
 tools/perf/util/event.c                                                       |   15 
 tools/perf/util/evlist.c                                                      |   34 
 tools/perf/util/evsel.c                                                       |   17 
 tools/perf/util/header.c                                                      |   57 
 tools/perf/util/hist.c                                                        |    7 
 tools/perf/util/hwmon_pmu.c                                                   |   26 
 tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c                      |   11 
 tools/perf/util/jitdump.c                                                     |    5 
 tools/perf/util/libbfd.c                                                      |   11 
 tools/perf/util/libbfd.h                                                      |    5 
 tools/perf/util/lzma.c                                                        |    6 
 tools/perf/util/machine.c                                                     |   10 
 tools/perf/util/metricgroup.c                                                 |    5 
 tools/perf/util/mmap.c                                                        |   18 
 tools/perf/util/pmu.c                                                         |   10 
 tools/perf/util/print-events.c                                                |   15 
 tools/perf/util/session.c                                                     |   11 
 tools/perf/util/strlist.c                                                     |   37 
 tools/perf/util/strlist.h                                                     |    2 
 tools/perf/util/svghelper.c                                                   |   10 
 tools/perf/util/symbol-elf.c                                                  |   91 +
 tools/perf/util/symbol-minimal.c                                              |   29 
 tools/perf/util/symbol.c                                                      |    7 
 tools/perf/util/symbol.h                                                      |    2 
 tools/perf/util/synthetic-events.c                                            |    2 
 tools/perf/util/thread.c                                                      |    5 
 tools/perf/util/thread_map.c                                                  |   18 
 tools/perf/util/time-utils.c                                                  |    4 
 tools/perf/util/tp_pmu.c                                                      |    2 
 tools/perf/util/trace-event-info.c                                            |    2 
 tools/perf/util/units.c                                                       |    2 
 tools/power/x86/intel-speed-select/isst-daemon.c                              |    9 
 tools/testing/cxl/test/cxl.c                                                  |   10 
 tools/testing/cxl/test/mem.c                                                  |    6 
 tools/testing/kunit/kunit_parser.py                                           |   12 
 tools/testing/selftests/Makefile                                              |    2 
 tools/testing/selftests/bpf/bpf_util.h                                        |   45 
 tools/testing/selftests/bpf/cgroup_helpers.c                                  |    2 
 tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c                        |   69 +
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c                       |    2 
 tools/testing/selftests/bpf/prog_tests/verifier_log.c                         |    1 
 tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c                        |    2 
 tools/testing/selftests/bpf/progs/cpumask_success.c                           |    2 
 tools/testing/selftests/bpf/progs/test_tunnel_kern.c                          |   13 
 tools/testing/selftests/bpf/progs/verifier_bounds.c                           |   14 
 tools/testing/selftests/bpf/progs/verifier_linked_scalars.c                   |  556 +++++++++
 tools/testing/selftests/bpf/progs/xdp_flowtable.c                             |    7 
 tools/testing/selftests/bpf/vmtest.sh                                         |    2 
 tools/testing/selftests/drivers/net/hw/tso.py                                 |   16 
 tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc               |    2 
 tools/testing/selftests/hid/Makefile                                          |    2 
 tools/testing/selftests/hid/hid_bpf.c                                         |   36 
 tools/testing/selftests/hid/progs/hid.c                                       |   15 
 tools/testing/selftests/landlock/scoped_signal_test.c                         |  237 +++
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh                         |    3 
 tools/testing/selftests/mm/compaction_test.c                                  |    3 
 tools/testing/selftests/mm/hmm-tests.c                                        |   63 -
 tools/testing/selftests/mm/hugepage-mremap.c                                  |   32 
 tools/testing/selftests/mm/hugetlb_reparenting_test.sh                        |   60 -
 tools/testing/selftests/mm/pkey-arm64.h                                       |    3 
 tools/testing/selftests/mm/split_huge_page_test.c                             |   27 
 tools/testing/selftests/mm/uffd-stress.c                                      |    5 
 tools/testing/selftests/net/broadcast_ether_dst.sh                            |    2 
 tools/testing/selftests/net/lib.sh                                            |   25 
 tools/testing/selftests/net/tcp_mmap.c                                        |    4 
 tools/testing/selftests/net/tls.c                                             |    8 
 tools/testing/selftests/net/vlan_bridge_binding.sh                            |    2 
 tools/testing/selftests/rseq/Makefile                                         |    6 
 tools/tracing/rtla/src/actions.c                                              |    8 
 tools/tracing/rtla/src/actions.h                                              |    5 
 tools/virtio/vringh_test.c                                                    |    5 
 virt/kvm/kvm_main.c                                                           |   16 
 1507 files changed, 20087 insertions(+), 10797 deletions(-)

Aaron Ma (2):
      ASoC: amd: acp-sdw-legacy: Bound DAI link iteration
      ASoC: amd: acp-sdw-sof: Bound DAI link iteration

Aaron Tomlin (2):
      libbpf: Report error when a negative kprobe offset is specified
      mips: sched: Fix CPUMASK_OFFSTACK memory corruption

Abd-Alrhman Masalkhi (3):
      raid1: fix nr_pending leak in REQ_ATOMIC bad-block error path
      md/raid1: honor REQ_NOWAIT when waiting for behind writes
      md/raid1: free r1_bio when REQ_NOWAIT is set and read would block on retry

Abdun Nihaal (17):
      fbdev: metronomefb: fix potential memory leak in metronomefb_probe()
      fbdev: broadsheetfb: fix potential memory leak in broadsheetfb_probe()
      fbdev: hecubafb: fix potential memory leak in hecubafb_probe()
      fbdev: efifb: fix memory leak in efifb_probe()
      fbdev: radeon: fix potential memory leak in radeonfb_pci_register()
      fbdev: i740fb: fix potential memory leak in i740fb_probe()
      fbdev: s3fb: fix potential memory leak in s3_pci_probe()
      fbdev: uvesafb: fix potential memory leak in uvesafb_probe()
      fbdev: tdfxfb: fix potential memory leak in tdfxfb_probe()
      fbdev: carminefb: fix potential memory leak in alloc_carmine_fb()
      fbdev: vesafb: fix memory leak in vesafb_probe()
      fbdev: nvidia: fix potential memory leak in nvidiafb_probe()
      fbdev: tridentfb: fix potential memory leak in trident_pci_probe()
      nvdimm/btt: Free arenas on btt_init() error paths
      nvdimm/btt: Free arena sub-allocations on discover_arenas() error path
      scsi: lpfc: Fix memory leak in lpfc_sli4_driver_resource_setup()
      bnx2x: fix potential memory leak in bnx2x_alloc_mem_bp()

Abhishek Ojha (1):
      regulator: ltc3676: Fix incorrect IRQSTAT bit offsets

Aboorva Devarajan (4):
      powerpc/perf: fix preempt count underflow in fsl_emb_pmu_del
      powerpc/powernv: fix preempt count leak in pnv_kexec_wait_secondaries_down
      powerpc/kexec: fix double get_cpu() imbalance in kexec_prepare_cpus
      selftests/mm: fix exclusive_cow test fork() handling

Adam Crosser (1):
      gpib: fix double decrement of descriptor_busy in command_ioctl()

Aditya Garg (2):
      net: mana: initialize gdma queue id to INVALID_QUEUE_ID
      net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check

Aditya Prakash Srivastava (1):
      ext4: fix kernel BUG in ext4_write_inline_data_end

Adrian Hunter (14):
      i3c: mipi-i3c-hci: Quieten initialization messages
      i3c: mipi-i3c-hci: Allow for Multi-Bus Instances
      i3c: mipi-i3c-hci: Switch PIO data allocation to devm_kzalloc()
      i3c: mipi-i3c-hci: Preserve RUN bit when aborting DMA ring
      i3c: master: Make hot-join workqueue freezable to block hot-join during suspend
      i3c: master: Replace WARN_ON() with dev_err() in i3c_dev_free_ibi_locked()
      i3c: master: Introduce optional Runtime PM support
      i3c: master: Add i3c_master_do_daa_ext() for post-hibernation address recovery
      i3c: master: Consolidate Hot-Join DAA work in the core
      i3c: master: Ensure Hot-Join operations are stopped on shutdown
      i3c: master: Defer new-device registration out of DAA caller context
      i3c: master: Prevent reuse of dynamic address on device add failure
      i3c: master: Update dev_nack_retry_count under maintenance lock
      i3c: master: Add missing runtime PM get in dev_nack_retry_count_store()

Adrian Ng Ho Yin (1):
      i3c: add sysfs entry and attribute for Device NACK Retry count

Ahsan Atta (1):
      crypto: qat - fix restarting state leak on allocation failure

Akhil R (1):
      dt-bindings: dma: nvidia,tegra186-gpc-dma: Make reset optional

Al Viro (8):
      configfs_lookup(): don't leave ->s_dentry dangling on failure
      configfs: fix lockless traversals of ->s_children
      udf: fix nls leak on udf_fill_super() failure
      new helper: simple_remove_by_name()
      functionfs: don't abuse ffs_data_closed() on fs shutdown
      functionfs: don't bother with ffs->ref in ffs_data_{opened,closed}()
      functionfs: switch to simple_remove_by_name()
      functionfs: use spinlock for FFS_DEACTIVATED/FFS_CLOSING transitions

Aldo Conte (1):
      iio: tcs3472: power down chip on probe failure

Aleksander Jan Bajkowski (2):
      crypto: eip93 - fix reset ring register definition
      crypto: inside-secure/eip93 - Add check for devm_request_threaded_irq

Aleksandr Nogikh (2):
      ocfs2: fix circular locking dependency in ocfs2_dio_end_io_write
      ieee802154: fix kernel-infoleak in dgram_recvmsg()

Aleksandrova Alyona (1):
      net: dsa: sja1105: round up PTP perout pin duration

Alex Deucher (1):
      drm/amdkfd: always resume_all after suspend_all

Alex Williamson (1):
      vfio/mlx5: Fix racy bitfields and tighten struct layout

Alexander Aring (1):
      dlm: fix add msg handle in send_queue ordered

Alexander Chesnokov (1):
      RDMA/hns: Fix arithmetic overflow in calc_hem_config()

Alexander Potapenko (1):
      lib/test_meminit: use && for bools

Alexander Stein (1):
      arm64: dts: tqma8mpql-mba8mpxl: configure sai clock in audio codec as well

Alexandru Hossu (2):
      staging: nvec: fix use-after-free in nvec_rx_completed()
      staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()

Alexey Charkov (1):
      power: supply: bq257xx: Fix VSYSMIN clamping logic

Ali Ahmet MEMIS (1):
      tools/power/x86/intel-speed-select: Harden daemon pidfile open

Alice Ryhl (1):
      drm/gpuvm: take refcount on DRM device

Alison Schofield (1):
      nvdimm/btt: Handle preemption in BTT lane acquisition

Amery Hung (1):
      bpf: Fix effective prog array index with BPF_F_PREORDER

Amir Goldstein (1):
      ovl: fix comment about locking order

Amit Machhiwal (1):
      powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11 and later processors

Anas Khan (1):
      drm/xe: remove duplicate <kunit/test-bug.h> include

Andre Przywara (3):
      firmware: smccc: Fix Arm SMCCC SOC_ID name call
      pinctrl: sunxi: a523: Remove unneeded IRQ remuxing flag
      arm64: dts: allwinner: a523: Add missing GPIO interrupt

Andrea Righi (2):
      sched/deadline: Reject debugfs dl_server writes for offline CPUs
      net: lan743x: Initialize eth_syslock spinlock before use

Andreas Kemnade (1):
      gpios: palmas: add .get_direction() op

Andrew Morton (1):
      security/apparmor/apparmorfs.c: conditionally compile get_loaddata_common_ref()

Andrii Nakryiko (1):
      bpf: Consistently use bpf_rcu_lock_held() everywhere

Andy Shevchenko (2):
      phy: phy-can-transceiver: Check driver match and driver data against NULL
      ACPI: resource: Amend kernel-doc style

Ankit Garg (1):
      gve: fix header buffer corruption with header-split and HW-GRO

Anshuman Khandual (1):
      arm64/mm: Optimize TLB flush in unmap_hotplug_[pmd|pud]_range()

Antoni Pokusinski (1):
      rtc: abx80x: fix the RTC_VL_CLR clearing all status flags

Antony Antony (1):
      xfrm: fix NAT-related field inheritance in SA migration

Ao Sun (1):
      mmc: block: fix RPMB device unregister ordering

Armin Wolf (1):
      leds: uleds: Fix potential buffer overread

Arnaldo Carvalho de Melo (84):
      perf strlist: Don't write to const memory
      perf strlist: Remove dont_dupstr logic, used only once
      perf time-utils: Constify variables storing the result of strchr() on const tables
      perf jitdump: Constify variables storing the result of strchr() on const tables
      perf list: Remove unused 'sep' variable
      perf bpf-event: Constify variables storing the result of strchr() on const tables
      perf session: Don't write to memory pointed to a const pointer
      perf demangle-java: Constify variables storing the result of strchr() on const tables
      perf trace-event: Constify variables storing the result of strchr() on const tables
      perf metricgroup: Constify variables storing the result of strchr() on const tables
      perf tools: Use const for variables receiving str{str,r?chr}() returns
      perf hwmon_pmu: Constify the variables returning bsearch() on const tables
      perf units: Constify variables storing the result of strchr() on const tables
      perf tp_pmu: Address const-correctness errors in recent glibcs
      perf list: Signal changing const memory is ok
      perf list: Don't write to const memory
      perf diff: Constify strchr() return variables
      perf trace: Don't change const char strings
      perf trace: Deal with compiler const checks
      perf header: Sanity check HEADER_EVENT_DESC attr.size before swap
      perf tools: Guard test_bit from out-of-bounds sample CPU
      perf sched: Fix thread reference leak in latency_switch_event
      perf tools: Add bounds check to cpu__get_node()
      perf sched: Cap max_cpu at MAX_CPUS in timehist sample processing
      perf sched: Fix register_pid() overflow, strcpy, and BUG_ON
      perf mmap: Guard cpu__get_node() return in aio_bind()
      perf stat: Bounds-check CPU index in topology aggregation callbacks
      perf c2c: Bounds-check CPU and node IDs before bitmap and array access
      perf c2c: Bounds-check CPU IDs in setup_nodes() topology loop
      perf sched: Clean up idle_threads entry on init failure
      perf sched: Use thread__put() in free_idle_threads()
      perf sched: Replace BUG_ON and add NULL checks in replay event helpers
      perf mmap: Fix NULL deref in aio cleanup on alloc failure
      perf stat: Introduce perf_env__get_cpu_topology() to guard NULL env->cpu
      perf c2c: Fix use-after-free in he__get_c2c_hists() error path
      perf timechart: Fix cpu2y() OOB read on untrusted CPU index
      perf tools: Fix int16_t truncation of max_cpu_num in set_max_cpu_num()
      perf tools: Fix get_max_num() size_t underflow on empty sysfs file
      perf tools: Use scnprintf() in cpu_map__snprint() to prevent overflow
      perf tools: Use perf_env__get_cpu_topology() in machine__resolve()
      perf sched: Bounds-check prio before test_bit() in timehist
      perf sched: Fix idle-hist callchain display using wrong rb_first variant
      perf bpf: Use scnprintf() in snprintf_hex() and synthesize_bpf_prog_name()
      perf hists: Fix snprintf() in hists__scnprintf_title() UID filter path
      perf pmu: Fix pmu_id() heap underwrite on empty identifier file
      perf pmu: Fix perf_pmu__parse_scale/unit() OOB access on empty sysfs file
      tools lib api: Fix missing null termination in filename__read_int/ull()
      perf symbols: Fix signed overflow in sysfs__read_build_id() size check
      perf symbols: Bounds-check .gnu_debuglink section data
      perf intel-pt: Fix snprintf size tracking bug in insn decoder
      perf tools: Fix thread__set_comm_from_proc() on empty comm file
      perf hwmon: Fix off-by-one null termination on sysfs reads
      perf hwmon: Use scnprintf() in hwmon_pmu__for_each_event()
      perf hwmon: Fix parse_hwmon_filename() strlcpy buffer overflow
      perf symbols: Bounds-check descsz in sysfs__read_build_id() GNU fallback
      perf hwmon: Guard label read against empty or failed reads
      perf tools: Use snprintf() in dso__read_running_kernel_build_id()
      tools lib api: Fix filename__write_int() writing uninitialized stack data
      tools lib api: Fix mount_overload() snprintf truncation and toupper range
      perf bpf: Add NULL check for btf__type_by_id() in synthesize_bpf_prog_name()
      perf bpf: Fix map data leak in bpf_metadata_create() on alloc failure
      perf bpf: Fix metadata leak in perf_env__add_bpf_info() on duplicate insert
      perf symbols: Add bounds checks to elf_read_build_id() note iteration
      perf symbols: Add bounds checks to read_build_id() note iteration in minimal build
      perf symbols: Fix bswap copy-paste error for 32-bit ELF p_filesz
      perf symbols: Validate p_filesz before use in filename__read_build_id()
      perf symbols: Break infinite loop on zero-filled notes in sysfs__read_build_id()
      perf tools: Add O_CLOEXEC to open() calls in DSO and ELF code
      perf tools: Fix uninitialized pathname on uncompressed fallback in filename__decompress()
      perf dso: Fix heap overflow in dso__get_filename() on decompressed path
      perf dso: Set error code when open() fails on uncompressed fallback path
      perf tools: Use snprintf() for root_dir path construction
      perf hwmon: Fix fd check to accept fd 0 in hwmon_pmu__describe_items()
      perf sched: Replace (void*)1 sentinel with proper runtime allocation
      perf bpf: Validate func_info_rec_size and sub_id in synthesize_bpf_prog_name()
      perf bpf: Reject oversized BPF metadata events that truncate header.size
      perf bpf: Bounds-check array offsets in bpil_offs_to_addr()
      perf cs-etm: Reject CPU IDs that would overflow signed comparison
      perf machine: Use snprintf() for guestmount path construction
      perf cs-etm: Validate num_cpu before metadata allocation
      perf cs-etm: Require full global header in auxtrace_info size check
      perf cs-etm: Bounds-check CPU in cs_etm__get_queue()
      perf bpf: Validate array presence before casting BPF prog info pointers
      perf dso: Set standard errno on decompression failure

Arnd Bergmann (2):
      RDMA/hfi1: Open-code rvt_set_ibdev_name()
      ASoC: SOF: Intel: hda-sdw-bpt: select SND_SOF_SOF_HDA_SDW_BPT properly

Arseniy Krasnov (1):
      mtd: rawnand: fix condition in 'nand_select_target()'

Ashish Mhetre (1):
      memory: tegra: Wire up system sleep PM ops

Asim Viladi Oglu Manizada (1):
      net: openvswitch: reject oversized nested action attrs

Athira Rajeev (1):
      powerpc tools perf: Initialize error code in auxtrace_record_init function

Atish Patra (1):
      KVM: SEV: Do not allow intra-host migration/mirroring of SNP VMs

Aurelien Jarno (1):
      riscv: dts: spacemit: set console baud rate on Milk-V Jupiter

Aviel Zohar (1):
      wifi: mt76: mt7925: validate skb length in testmode query

Avinash Duduskar (1):
      bpf: zero-initialize the fib lookup flow struct

Baineng Shou (1):
      dma-fence: Make dma_fence_dedup_array() robust against 0-count input

Balakrishnan Sambath (1):
      watchdog: sama5d4_wdt: Fix WDDIS detection on SAM9X60 and SAMA7G5

Baokun Li (1):
      writeback: drop now-unnecessary rcu_barrier() in cgroup_writeback_umount()

Baoli Zhang (1):
      tpm: restore timeout for key creation commands

Baoli.Zhang (1):
      soundwire: fix bug in sdw_add_element_group_count found by syzkaller

Baolin Liu (1):
      Documentation: proc: fix section numbering in table of contents

Bard Liao (2):
      soundwire: don't program SDW_SCP_BUSCLOCK_SCALE on a unattached Peripheral
      soundwire: intel_ace2x: release bpt_stream when close it

Bart Van Assche (1):
      ata: libata: Fix ata_exec_internal()

Bartosz Golaszewski (3):
      powerpc/8xx: implement get_direction() in cpm1
      power: sequencing: fix ABBA deadlock in pwrseq_device_unregister()
      mfd: tps6586x: Fix OF node refcount

Bastien Curutchet (1):
      mtd: rawnand: pl353: fix probe resource allocation

Ben Dooks (2):
      tracing: Make tracepoint_printk static as not exported
      usb: dwc3: fix dwc3_readl() and dwc3_writel() calls in dwc3_ulpi_setup()

Benjamin Coddington (1):
      NFS: Charge unstable writes by request size, not folio size

Benjamin Marzinski (1):
      dm-log: fix a bitset_size overflow on 32bit machines

Benoît Sevens (1):
      HID: playstation: validate num_touch_reports in DualShock 4 reports

Bernard Metzler (1):
      RDMA/siw: Fix endpoint/socket association handling

Bhargav Joshi (2):
      irqchip/crossbar: Fix parent domain resource leak
      irqchip/crossbar: Use correct index in crossbar_domain_free()

Bibek Kumar Patro (1):
      iommu/arm-smmu-qcom: Fix fastrpc compatible string in ACTLR client match table

Bibo Mao (2):
      LoongArch: KVM: Check irq validity in kvm_vcpu_ioctl_interrupt()
      LoongArch: KVM: Fix FPU register width with user access API

Biju Das (2):
      pwm: rzg2l-gpt: Add missing newlines to dev_err_probe() messages
      pwm: rzg2l-gpt: Fix period_ticks type from u32 to u64

Bjoern A. Zeeb (1):
      wifi: mt76: fix argument to ieee80211_is_first_frag()

Boris Brezillon (4):
      drm/panthor: Fix potential invalid pointer deref in group_process_tiler_oom()
      drm/panthor: Don't overrule pending immediate ticks in sched_resume_tick()
      drm/panthor: Fix a leak when a group is evicted before the tiler OOM is serviced
      drm/panthor: Interrupt group start/resumption if group_bind_locked() fails

Bradley Morgan (3):
      bpf: Disable xfrm_decode_session hook attachment
      cpu: hotplug: Preserve per instance callback errors
      cpu: hotplug: Bound hotplug states sysfs output

Breno Leitao (3):
      workqueue: drop spurious '*' from print_worker_info() fn declaration
      arm64/hw_breakpoint: reject unaligned watchpoints that would truncate BAS
      9p: skip nlink update in cacheless mode to fix WARN_ON

Brett Creeley (1):
      ionic: Fix check in ionic_get_link_ext_stats

Brian Norris (4):
      ARM: dts: rockchip: Add #{address,size}-cells to Chromium-based /firmware
      arm64: dts: rockchip: Add #{address,size}-cells to Chromium-based /firmware
      ARM: tegra: Add #{address,size}-cells to Chromium-based /firmware
      arm64: tegra: Add #{address,size}-cells to Chromium-based /firmware

Bryam Vargas (8):
      landlock: Fix LANDLOCK_SCOPE_SIGNAL bypass on the SIGIO path
      selftests/landlock: Test SCOPE_SIGNAL on the SIGIO/fowner pgid path
      nvmet-rdma: handle inline data with a nonzero offset
      scsi: target: Bound PR-OUT TransportID parsing to the received buffer
      scsi: target: core: Fix iSCSI ISID use-after-free in REGISTER AND MOVE
      net/sched: sch_multiq: Replace direct dequeue call with peek and qdisc_dequeue_peeked
      net/sched: sch_taprio: Replace direct dequeue call with peek and qdisc_dequeue_peeked
      orangefs: keep the readdir entry size 64-bit in fill_from_part()

Cao Guanghui (1):
      dm era: fix NULL pointer dereference in metadata_open()

Cao Ruichuang (1):
      selftests/ftrace: Drop invalid top-level local in test_ownership

Carlos Bilbao (1):
      PCI/ASPM: Don't reconfigure ASPM entering low-power state

Carlos Llamas (1):
      libbpf: Fix UAF in strset__add_str()

Cen Zhang (6):
      btrfs: annotate lockless read of defrag_bytes in should_nocow()
      ALSA: seq: oss: Serialize readq reset state with q->lock
      ALSA: seq: avoid stale FIFO cells during resize
      ALSA: usb-audio: Kill MIDI 2.0 URBs before freeing endpoints
      Bluetooth: 6lowpan: hold L2CAP conn across debugfs control
      Bluetooth: MGMT: Fix adv monitor add failure cleanup

Chanwoo Lee (1):
      scsi: ufs: Fix wrong value printed in unexpected UPIU response case

Charles Keepax (3):
      pinctrl: cs42l43: Fix leaked pm reference on error path
      pinctrl: cs42l43: Fix polarity on debounce
      mfd: cs42l43: Sanity check firmware size

Chen Cheng (3):
      md/raid10: reset read_slot when reusing r10bio for discard
      md/raid5: use stripe state snapshot in break_stripe_batch_list()
      md/raid5: avoid R5_Overlap races while breaking stripe batches

Chen Ni (1):
      clocksource/drivers/sun5i: Handle error returns from devm_reset_control_get_optional_exclusive()

Chen-Yu Tsai (4):
      dt-bindings: media: sun4i-a10-video-engine: Add interconnect properties
      pinctrl: mediatek: eint: Drop base from mtk_eint_chip_write_mask()
      arm64: dts: mediatek: mt8192-asurada: Move PCIe DMA bounce buffer to host
      regulator: dt-bindings: mt6359: Drop regulator-name pattern restrictions

ChenXiaoSong (1):
      smb/server: do not require delete access for non-replacing links

Chin-Yen Lee (1):
      wifi: rtw88: fix wrong pci_get_drvdata type in AER handlers

Chris Brandt (1):
      drm: renesas: rz-du: mipi_dsi: Fix return path on error

Chris Mason (5):
      xprtrdma: Fix ep kref imbalance on ADDR_CHANGE
      xprtrdma: Initialize re_id before removal registration
      xprtrdma: Fix bcall rep leak and unbounded peek
      sunrpc: pin svc_xprt across the asynchronous TLS handshake callback
      binder: cache secctx size before release zeroes it

Christian Brauner (8):
      eventpoll: rename ep_remove_safe() back to ep_remove()
      eventpoll: expand top-of-file overview / locking doc
      eventpoll: rename attach_epitem() to ep_attach_file()
      eventpoll: split ep_insert() into alloc + register stages
      eventpoll: extract ep_deliver_event() from ep_send_events()
      eventpoll: wrap EP_UNACTIVE_PTR in typed sentinel helpers
      eventpoll: rename epi->next and txlist for clarity
      fs: refuse O_TMPFILE creation with an unmapped fsuid or fsgid

Christian Marangi (1):
      pinctrl: airoha: generalize pins/group/function/confs handling

Christoph Hellwig (5):
      proc: rename proc_setattr to proc_nochmod_setattr
      xfs: initialize iomap->flags earlier in xfs_bmbt_to_iomap
      xfs: add a xfs_groups_to_rfsbs helper
      xfs: only log freed extents for the current RTG in zoned growfs
      xfs: use bio_reuse in the zone GC code

Christos Longros (1):
      wifi: rtw89: fix wrong pci_get_drvdata type in AER handlers

Chuck Lever (21):
      NFSD: Fix delegation reference leak in nfsd4_revoke_states
      NFSD: Handle layout stid in nfsd4_drop_revoked_stid()
      handshake: Require admin permission for DONE command
      xprtrdma: Avoid 250 ms delay on backlog wakeup
      xprtrdma: Close lost-wakeup race in xprt_rdma_alloc_slot
      xprtrdma: Post receive buffers after RPC completion
      xprtrdma: Use sendctx DMA state for Send signaling
      xprtrdma: Decouple req recycling from RPC completion
      xprtrdma: Check frwr_wp_create() during connect
      xprtrdma: Document and assert reply-handler invariants
      xprtrdma: Resize reply buffers before reposting receives
      xprtrdma: Sanitize the reply credit grant after parsing
      xprtrdma: Repost Receive buffers for malformed replies
      xprtrdma: Return sendctx slot after Send preparation failure
      net/tls: Consume empty data records in tls_sw_read_sock()
      SUNRPC: release lower rpc_clnt if killed waiting for XPRT_LOCKED
      SUNRPC: pin upper rpc_clnt across the TLS connect_worker
      sunrpc: wait for in-flight TLS handshake callback when cancel loses race
      lockd: Plug nlm_file leak when nlm_do_fopen() fails
      lockd: Plug nlm_file refcount leak on cached nlm_do_fopen() failure
      SUNRPC: Bound-check xdr_buf_to_bvec() stores before writing

Chukun Pan (1):
      pinctrl: airoha: fix pinctrl function mismatch issue

Clark Wang (1):
      nfs: keep PG_UPTODATE clear after read errors in page groups

Connor Williamson (1):
      block: remove redundant GD_NEED_PART_SCAN in add_disk_final()

Conor Dooley (3):
      dts: spacemit: set console baud rate on bpif3
      mailbox: mpfs: fix check for syscon presence in mpfs_mbox_inbox_isr()
      rtc: mpfs: fix counter upload completion condition

Conor Kotwasinski (1):
      kernfs: fix suspicious RCU usage in kernfs_put()

Corey Leavitt (1):
      net: pse-pd: scope pse_control regulator handle to kref lifetime

Cosmin Ratiu (2):
      devlink: Fix parent ref leak in devl_rate_node_create()
      devlink: Fix parent ref leak on tc-bw failure

Cristian Ciocaltea (2):
      drm/rockchip: dw_dp: Switch to drmm_kzalloc()
      drm/rockchip: dw_dp: Fix null-ptr-deref in dw_dp_remove()

Cristian Marussi (1):
      clk: scmi: Fix clock rate rounding

Crystal Wood (1):
      tracing/osnoise: Call synchronize_rcu() when unregistering

Cássio Gabriel (12):
      ALSA: xen-front: Reset event channel state on stream clear
      ALSA: xen-front: Connect event channel after stream prepare
      ALSA: usb-audio: qcom: Initialize offload control return value
      ASoC: sma1307: Fix uevent string leaks in fault worker
      ALSA: usb-audio: qcom: Guard sideband endpoint removal
      ASoC: SOF: topology: validate vendor array size before parsing
      ASoC: mediatek: mt8192: Check runtime resume during probe
      ASoC: mediatek: mt8192: Release reserved memory on cleanup
      ASoC: mediatek: mt8183: Check runtime resume during probe
      ASoC: mediatek: mt8183: Release reserved memory on cleanup
      firmware_loader: Add cancel helper for async requests
      ALSA: hda/tas2781: Cancel async firmware request at unbind

DaeMyung Kang (1):
      ksmbd: centralize ksmbd_conn final release to plug transport leak

Daehyeon Ko (1):
      macsec: don't read an unset MAC header in macsec_encrypt()

Dai Ngo (1):
      NFSv4/pnfs: defer return_range callbacks until after inode unlock

Damian Muszynski (1):
      crypto: qat - fix heartbeat error injection

Damien Laine (1):
      ALSA: hda/realtek: Fix speakers on Legion Pro 7 16ARX8H with codec SSID 17aa:38a7

Dan Carpenter (4):
      rapidio/tsi721: prevent a bad dereference in tsi721_db_dpc()
      scsi: pm8001: Fix error code in non_fatal_log_show()
      PCI: dwc: Fix signedness bug in fault injection test code
      afs: Fix error code in afs_extract_vl_addrs()

Dan Williams (1):
      cxl/fwctl: Fix __fortify_panic

Daniel Borkmann (11):
      selftests/bpf: Add a test cases for sync_linked_regs regarding zext propagation
      bpf: Clear delta when clearing reg id for non-{add,sub} ops
      selftests/bpf: Add tests for delta tracking when src_reg == dst_reg
      selftests/bpf: Add tests for stale delta leaking through id reassignment
      libbpf: Skip hash computation when loader generation failed
      libbpf: Skip endianness swap when loader generation failed
      bpf: Reject exclusive maps as inner maps in map-in-map
      libbpf: Skip initial_value override on signed loaders
      libbpf: Skip max_entries override on signed loaders
      bpf: Reject exclusive maps for bpf_map_elem iterators
      bpf: Tighten cgroup storage cookie checks for prog arrays

Daniel Gibson (5):
      platform/x86/amd/pmc: Check for intermediate wakeup in function
      platform/x86/amd/pmc: Delay suspend for some Lenovo Laptops
      platform/x86/amd/pmc: Add delay_suspend module parameter
      platform/x86/amd/pmc: Don't log during intermediate wakeups
      platform/x86/amd/pmc: Avoid logging "(null)" for DMI values

Daniel Palmer (1):
      tools/nolibc: getopt: Fix potential out of bounds access

Danila Chernetsov (1):
      ext2: fix ignored return value of generic_write_sync()

Danilo Krummrich (7):
      driver core: use READ_ONCE() for dev->driver in dev_has_sync_state()
      driver core: Fix missing jiffies conversion in deferred_probe_extend_timeout()
      driver core: Guard deferred probe timeout extension with delayed_work_pending()
      amba: use generic driver_override infrastructure
      cdx: use generic driver_override infrastructure
      Drivers: hv: vmbus: use generic driver_override infrastructure
      rpmsg: use generic driver_override infrastructure

Dave Jiang (4):
      cxl/test: Fix integer overflow in mock LSA bounds checks
      cxl/test: Zero out LSA backing memory to avoid leaking to user
      cxl/test: Unregister cxl_acpi in cxl_test_init() error path
      cxl/test: Add check after kzalloc() memory in alloc_mock_res()

Dave Penkler (1):
      gpib: Fix inappropriate ioctl error return

David Carlier (1):
      netfilter: nfnl_cthelper: apply per-class values when updating policies

David Disseldorp (1):
      scsi: target: Fix hexadecimal CHAP_I handling

David E. Box (4):
      platform/x86/intel/vsec: Decouple add/link helpers from PCI
      platform/x86/intel/vsec: Switch exported helpers from pci_dev to device
      platform/x86/intel/vsec: Return real error codes from registration path
      platform/x86/intel/vsec: Restore BAR fallback for header walk

David Gow (1):
      kunit:tool: Don't write to stdout when it should be disabled

David Heidelberg (1):
      drm/panel: Clean up S6E3HA2 config dependencies and fill help text

David Howells (30):
      rxrpc: Fix UAF in rxgk_issue_challenge()
      rxrpc: Fix socket notification race
      rxrpc: Fix leak of released call in recvmsg(MSG_PEEK)
      rxrpc: Fix potential infinite loop in rxrpc_recvmsg()
      rxrpc: Fix rxrpc_rotate_tx_rotate() to check there's something to rotate
      rxrpc: Fix oob challenge leak in cleanup after notification failure
      rxrpc: Fix the reception of a reply packet before data transmission
      rxrpc: Fix leak of connection from OOB challenge
      rxrpc: Fix double unlock in rxrpc_recvmsg()
      afs: Fix netns teardown to cancel the preallocation charger
      afs: Fix further netns teardown to cancel the preallocation charger
      afs: Fix uncancelled rxrpc OOB message handler
      afs: Fix double netfs initialisation in afs_root_iget()
      afs: Fix bulk lookup malfunction due to change in dir_emit() API
      afs: Fix misplaced inc of net->cells_outstanding
      afs: Fix reinitialisation of the inode, in particular ->lock_work
      afs: Fix callback service message parsers to pass through -EAGAIN
      afs: Fix missing NULL pointer check in afs_break_some_callbacks()
      afs: Fix vllist leak
      afs: Fix lack of locking around modifications of net->cells_dyn_ino
      afs: Fix premature cell exposure through /afs
      afs: Fix the volume AFS_VOLUME_RM_TREE is set on
      afs: Fix unchecked-length string display in debug statement
      netfs: Fix netfs_create_write_req() to handle async cache object creation
      netfs: Fix writethrough to use collection offload
      netfs: Fix writeback error handling
      netfs: Fix folio state after ENOMEM whilst under writeback iteration
      cifs: Fix missing credit release on failure in cifs_issue_read()
      cifs: SMB1 split: Rename cifstransport.c
      cifs: SMB1 split: Add some #includes

David Jander (7):
      ARM: dts: stm32: stm32mp15x-mecio1-io: Fix ADC sampling times
      ARM: dts: stm32: stm32mp15x-mecio1-io: Move divergent mecio1 ADC channels to board files
      ARM: dts: stm32: stm32mp15x-mecio1-io: Enable internal ADC reference
      ARM: dts: stm32: stm32mp15x-mecio1-io: Fix GPIO names typo
      ARM: dts: stm32: stm32mp15x-mecio1-io: Move gpio-line-names to board files
      ARM: dts: stm32: stm32mp15x-mecio1-io: Fix expander gpio line typo
      ARM: dts: stm32: stm32mp15x-mecio1-io: Move expander gpio-line-names to board files

David Laight (1):
      fbdev: sm501fb: Fix buffer errors in OF binding code

David Lee (1):
      fhandle: reject detached mounts in capable_wrt_mount()

David Windsor (1):
      x86/uprobes: Keep shadow stack in sync for emulated CALLs

David Yang (1):
      net: dsa: realtek: fix memory leak in rtl8366rb_setup_led()

Davide Ornaghi (1):
      ksmbd: fix path resolution in ksmbd_vfs_kern_path_create

Davidlohr Bueso (1):
      dax/kmem: account for partial discontiguous resource upon removal

Dawei Feng (4):
      net: ena: clean up XDP TX queues when regular TX setup fails
      net/mlx5: HWS, fix matcher leak on resize target setup failure
      octeontx2-pf: fix SQB pointer leak on init failure
      wifi: mac80211: fix memory leak in ieee80211_register_hw()

Dawid Osuchowski (1):
      ice: fix FDIR CTRL VSI resource leak in ice_reset_all_vfs()

Deepanshu Kartikey (2):
      bpf: fix UAF by restoring RCU-delayed inode freeing in bpffs
      mm/hugetlb: fix hugetlb cgroup rsvd charge/uncharge mismatch

Di Shen (1):
      OPP: Fix race between OPP addition and lookup

Diederik de Haas (1):
      arm64: dts: rockchip: Fix gmac0 reset pin for NanoPi R5S

Dmitry Antipov (1):
      ocfs2: fix buffer head management in ocfs2_read_blocks()

Dmitry Baryshkov (3):
      media: iris: scale MMCX power domain on SM8250
      media: venus: scale MMCX power domain on SM8250
      Revert "media: venus: hfi_platform: Correct supported codecs for sc7280"

Dmitry Safonov (1):
      tcp: Decrement tcp_md5_needed static branch

Dmitry Torokhov (11):
      Input: ims-pcu - fix use-after-free and double-free in disconnect
      Input: ims-pcu - only expose sysfs attributes on control interface
      Input: ims-pcu - release data interface on disconnect
      Input: ims-pcu - validate control endpoint type
      Input: ims-pcu - add response length checks
      Input: ims-pcu - fix DMA mapping violation in line setup
      Input: ims-pcu - fix firmware leak in async update
      Input: ims-pcu - fix out-of-bounds read in ims_pcu_irq() debug logging
      Input: ims-pcu - fix potential infinite loop in CDC union descriptor parsing
      Input: ims-pcu - fix race condition in reset_device sysfs callback
      Input: ims-pcu - fix type confusion in CDC union descriptor parsing

Dmitry Vyukov (1):
      firmware_loader: Fix recursive lock in device_cache_fw_images()

Doruk Tan Ozturk (1):
      net/mlx5e: macsec: fix use-after-free of metadata_dst on RX SC delete

Dragos Tatulea (1):
      net/mlx5: Check max_macs devlink param value against max capability

Dust Li (1):
      dibs: loopback: validate offset and size in move_data()

Dylan Eskew (1):
      wifi: mt76: mt7996: limit work in set_bitrate_mask

Eckhart Mohr (1):
      ALSA: hda/realtek: Add quirk for TongFang X6xx45xU

Enrico Pozzobon (1):
      net: usb: lan78xx: disable VLAN filter in promiscuous mode

Eric Biggers (5):
      crypto: sun4i-ss - Remove insecure and unused rng_alg
      crypto: xilinx-trng - Remove crypto_rng interface
      ksmbd: Use SHA-512 library for SMB3.1.1 preauth hash
      ksmbd: Use HMAC-SHA256 library for message signing and key generation
      ksmbd: Use HMAC-MD5 library for NTLMv2

Eric Dumazet (18):
      net/sched: sch_hfsc: annotate data-races in hfsc_dump_class_stats()
      net/sched: sch_htb: do not change sch->flags in htb_dump()
      net/sched: sch_htb: annotate data-races (I)
      net/sched: sch_drr: annotate data-races around cl->deficit
      ipv6: guard against possible NULL deref in __in6_dev_stats_get()
      net: watchdog: fix refcount tracking races
      net: remove addr_len argument of recvmsg() handlers
      tipc: fix UAF in tipc_l2_send_msg()
      tcp: ipv6: clamp default adverting MSS to avoid GSO_BY_FRAGS (0xFFFF)
      xfrm: annotate data-races around xfrm_policy_count[] and xfrm_policy_default[]
      xfrm: validate selector family and prefixlen during match
      net: do not acquire dev->tx_global_lock in netdev_watchdog_up()
      veth: fix NAPI leak in XDP enable error path
      net: udp_tunnel: prevent double queueing in udp_tunnel_nic_device_sync
      amt: fix size calculation in amt_get_size()
      ipv4: igmp: Fix potential UAF in igmp_gq_start_timer()
      ipv6: mcast: Fix potential UAF in MLD delayed work
      ipv4: igmp: Fix potential memory leaks in igmp_mod_timer() and igmp_stop_timer()

Fan Wu (1):
      can: esd_usb: kill anchored URBs before freeing netdevs

Farhad Alemi (1):
      cgroup/cpuset: rebind mm mempolicy to effective_mems, not mems_allowed

Felix Fietkau (1):
      wifi: mt76: mt7996: add missing max_remain_on_channel_duration

Felix Gu (8):
      watchdog: sprd_wdt: Remove redundant sprd_wdt_disable() on register failure
      pinctrl: sunxi: fix regulator leak in sunxi_pmx_request() error path
      drm/tegra: dc: Fix device node reference leak in tegra_dc_has_output()
      spi: atmel: fix DMA channel and bounce buffer leaks
      spi: ep93xx: fix double-free of zeropage on DMA setup failure
      crypto: marvell/octeontx - fix DMA cleanup using wrong loop index
      crypto: cavium/cpt - fix DMA cleanup using wrong loop index
      phy: freescale: phy-fsl-imx8qm-lvds-phy: Fix missing pm_runtime_disable() on probe error path

Feng Liu (3):
      net/mlx5e: Fix HV VHCA stats zero-sized buffer allocation
      net/mlx5e: Fix HV VHCA stats agent registration race
      net/mlx5e: Fix publication race for priv->channel_stats[]

Feng Wu (1):
      netfilter: xt_rateest: fix u64 truncation in xt_rateest_mt()

Fernando Fernandez Mancera (12):
      netfilter: nfnetlink_osf: fix mss parsing on big-endian architectures
      netfilter: synproxy: drop packets if timestamp adjustment fails
      netfilter: synproxy: adjust duplicate timestamp options
      netfilter: synproxy: fix unaligned memory access in timestamp adjustment
      netfilter: synproxy: protect nf_ct_seqadj_init() with conntrack lock
      netfilter: nf_conncount: prevent connlimit drops for early confirmed ct
      ipv6: fix error handling in disable_ipv6 sysctl
      ipv6: fix error handling in ignore_routes_with_linkdown sysctl
      ipv6: fix error handling in forwarding sysctl
      ipv6: fix error handling in disable_policy sysctl
      ipv6: fix state corruption during proxy_ndp sysctl restart
      ipv6: fix missing notification for ignore_routes_with_linkdown

Filip Hejsek (1):
      virtio_console: read size from config space during device init

Filipe Manana (2):
      btrfs: fix invalid pointer dereference in __btrfs_run_delayed_refs()
      btrfs: fix deadlock cloning inline extent when using flushoncommit

Florian Fuchs (1):
      mtd: maps: vmu-flash: fix NULL pointer dereference in initialization

Florian Schmaus (1):
      selftests: Fix Makefile target for nsfs

Florian Westphal (10):
      netfilter: nf_conncount: callers must hold rcu read lock
      netfilter: nft_payload: reject offsets exceeding 65535 bytes
      netfilter: nft_meta_bridge: add validate callback for get operations
      netfilter: nft_flow_offload: zero device address for non-ether case
      netfilter: nf_reject: skip iphdr options when looking for icmp header
      netfilter: nft_meta_bridge: fix NFT_META_BRI_IIFPVID stack leak
      netfilter: nft_compat: ebtables emulation must reject non-bridge targets
      netfilter: nft_set_pipapo: don't leak bad clone into future transaction
      netfilter: nf_nat_sip: reload possible stale data pointer
      ipvs: reload ip header after head reallocation

Francois Dugast (1):
      drm/xe/pt: Fix NULL pointer dereference in xe_pt_zap_ptes_entry()

Frank Li (2):
      dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK
      media: nxp: imx8-isi: use devm_pm_runtime_enable() to simplify code

Franz Schnyder (1):
      PCI: imx6: Fix reference clock source selection for i.MX95

Frederic Weisbecker (1):
      tick/sched: Fix TOCTOU in nohz idle time fetch

Fredric Cover (1):
      smb: client: use kvzalloc() for megabyte buffer in simple fallocate

Fredrik M Olsson (1):
      rtc: ds1307: Fix off-by-one issue with wday for rx8130

Frieder Schrempf (2):
      arm64: dts: imx8mp-kontron: Reduce EERAM SPI clock frequency
      arm64: dts: imx8mp-kontron: Fix GPIO for display power switch

Fuad Tabba (1):
      KVM: arm64: nv: Write ESR_EL2 for injected nested SError exceptions

Gabriele Monaco (1):
      Documentation/rv: Replace stale website link

Gautam Menghani (1):
      powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be used with KVM

Geert Uytterhoeven (1):
      firmware: arm_scmi: Fix OOB in scmi_power_name_get()

Geetha sowjanya (2):
      octeontx2-af: mcs: Fix unsupported secy stats read
      octeontx2-pf: mcs: Fix mcs resources free on PF shutdown

Geliang Tang (2):
      nvmet-tcp: fix page fragment cache leak in error path
      nvmet-tcp: check return value of nvmet_tcp_set_queue_sock

Genjian Zhang (1):
      dm thin metadata: fix superblock refcount leak on snapshot shadow failure

Geoffrey D. Bennett (2):
      ALSA: scarlett2: Allow selecting config_set by firmware version
      ALSA: scarlett2: Update offsets for 2i2 Gen 4 firmware 2417

George Moussalem (1):
      net: dsa: qca8k: fix led devicename when using external mdio bus

Georgia Garcia (3):
      apparmor: fix NULL pointer dereference in unpack_pdb
      apparmor: remove or add symlinks to rawdata according to export_binary
      apparmor: don't audit files pointing to aa_null.dentry

Georgiy Osokin (1):
      HID: picolcd: prevent NULL pointer dereference in picolcd_send_and_wait()

Gerald Schaefer (2):
      s390/monwriter: Reject buffer reuse with different data length
      s390/mm: Fix type mismatch in get_align_mask().

Gil Portnoy (3):
      ksmbd: fix use-after-free of conn->preauth_info in concurrent SMB2 NEGOTIATE
      ksmbd: fix use-after-free of fp->owner.name in durable handle owner check
      ksmbd: fix durable reconnect double-bind race in ksmbd_reopen_durable_fd

Giovanni Cabiddu (2):
      vfio/qat: fix f_pos race in qat_vf_resume_write()
      crypto: qat - fix VF2PF work teardown race in adf_disable_sriov()

Gleb Markov (1):
      cxgb4: Fix decode strings dump for T6 adapters

Greg Kroah-Hartman (2):
      sysfs: clamp show() return value in sysfs_kf_read()
      Linux 6.18.40

Gregory Bell (2):
      selftests/bpf: Use local type for flow_offload_tuple_rhash in xdp_flowtable
      selftests/bpf: Use local type for bpf_fou_encap in test_tunnel_kern

Grzegorz Nitka (5):
      dpll: fix stale iteration in dpll_pin_on_pin_unregister()
      dpll: send delete notification before unregister in on-pin rollback
      dpll: emit per-dpll delete notifications in dpll_pin_on_pin_unregister()
      dpll: guard sync-pair removal on full pin unregister
      dpll: balance create/delete notifications in __dpll_pin_(un)register

Guangshuo Li (9):
      IB/mlx4: Fix refcount leak in add_port() error path
      ASoC: adau1372: Clear PLL_EN on failed PLL lock without reset GPIO
      ksmbd: fix use-after-free in same_client_has_lease()
      staging: most: video: avoid double free on video register failure
      drm/i915: clear CRTC color blob pointers after dropping refs
      cifs: validate DFS referral string offsets
      smb: client: fix overflow in passthrough ioctl bounds check
      gpu: host1x: Fix device reference leak in host1x_device_parse_dt() error path
      mfd: sm501: Fix reference leak on failed device registration

Guanyou.Chen (1):
      sched: restore timer_slack_ns when resetting RT policy on fork

Guenter Roeck (2):
      hwmon: (pmbus) Fix passing events to regulator core
      hwmon: (aspeed-g6-pwm-tach) Guard fan RPM calculation against divide-by-zero

Gui-Dong Han (1):
      KEYS: Use acquire when reading state in keyring search

Guilherme Ivo Bozi (1):
      iio: adc: xilinx-ams: fix out-of-bounds channel lookup in event handling

Guixin Liu (2):
      PCI: Introduce named defines for PCI ROM
      PCI: Check ROM header and data structure addr before accessing

Guoniu Zhou (1):
      dt-bindings: power: imx93: Add MIPI PHY power domain

Han Gao (1):
      pinctrl: spacemit: fix NULL check in spacemit_pin_set_config

HanQuan (1):
      ALSA: seq: Fix kernel heap address leak in bounce_error_event()

Hao Ge (1):
      alloc_tag: fix use-after-free in /proc/allocinfo after module unload

Haofeng Li (3):
      ksmbd: reject undersized DACLs before parsing ACEs
      wifi: cfg80211: validate EHT MLE before MLD ID read
      ksmbd: validate NTLMv2 response before updating session key

Haoxiang Li (12):
      rtc: cmos: unregister HPET IRQ handler on probe failure
      KVM: s390: pci: Fix GISC refcount leak on AIF enable failure
      platform/x86: dell-laptop: fix missing cleanups in init error path
      net: sparx5: unregister blocking notifier on init failure
      scsi: hpsa: Fix DMA mapping leak on IOACCEL2 reset path
      scsi: elx: efct: Fix I/O leak on unsupported additional CDB
      net: wwan: t7xx: destroy DMA pool on CLDMA late init failure
      net: ixp4xx_hss: fix duplicate HDLC netdev allocation
      octeontx2-af: Free BPID bitmap on setup failure
      net: liquidio: fix BAR resource leak on PF number failure
      fsl/fman: Free init resources on KeyGen failure in fman_init()
      irqchip/irq-riscv-imsic-early: Fix fwnode leak on state setup failure

Haoze Xie (1):
      netfilter: nf_queue: pin bridge device while NFQUEUE holds fake dst

Harman Kalra (1):
      octeontx2-af: fix VF bringup affecting PF promiscuous state

Harshal Dev (8):
      arm64: dts: qcom: lemans: Add power-domain and iface clk for ice node
      arm64: dts: qcom: monaco: Add power-domain and iface clk for ice node
      arm64: dts: qcom: sc7180: Add power-domain and iface clk for ice node
      arm64: dts: qcom: kodiak: Add power-domain and iface clk for ice node
      arm64: dts: qcom: sm8450: Add power-domain and iface clk for ice node
      arm64: dts: qcom: sm8550: Add power-domain and iface clk for ice node
      arm64: dts: qcom: sm8650: Add power-domain and iface clk for ice node
      arm64: dts: qcom: sm8750: Add power-domain and iface clk for ice node

Heiko Carstens (2):
      s390/process: Fix kernel thread function pointer type
      s390/diag: Add missing array_index_nospec() call to memtop_get_page_count()

Herbert Xu (4):
      crypto: tegra - Fix dma_free_coherent size error
      crypto: tegra - Return ENOMEM when input buffer allocation fails for ccm
      crypto: rng - Free default RNG on module exit
      xfrm: Fix xfrm state cache insertion race

Holger Dengler (3):
      s390/pkey: Check length in PKEY_VERIFYPROTK ioctl
      s390/pkey: Check length in pkey_pckmo handler implementation
      pkey: Move keytype check from pkey api to handler

Hongchen Zhang (1):
      LoongArch: Fix missing dirty page tracking in {pte,pmd}_wrprotect()

Hongling Zeng (6):
      nilfs2: Fix return in nilfs_mkdir
      ext4: fix ERR_PTR(0) in ext4_mkdir()
      9p: avoid returning ERR_PTR(0) from mkdir operations
      sunrpc: Fix error handling in rpc_sysfs_xprt_switch_add_xprt_store()
      apparmor: Fix return in ns_mkdir_op
      sunrpc: fix uninitialized xprt_create_args structure

Hongyan Xia (1):
      sched/fair: Fix cpu_util runnable_avg arithmetic

Hsiu Che Yu (2):
      rust: alloc: fix `Vec::extend_with` SAFETY comment
      rust: alloc: fix assert in `Vec::reserve` doc test

Hugo Villeneuve (1):
      ARM: dts: imx6ul-var-som: fix warning for non-existent dc-supply property

Hui Wang (3):
      riscv: cpu_ops: Change return value type of cpu_is_stopped() to bool
      ring-buffer: Fix event length with forced 8-byte alignment
      selftests/rseq: Fix a building error for riscv arch

Hui Zhu (1):
      vmalloc: fix NULL pointer dereference in is_vm_area_hugepages()

Huiwen He (2):
      smb/client: always return a value for FS_IOC_GETFLAGS
      smb/client: preserve errors from smb2_set_sparse()

HyeongJun An (5):
      ALSA: seq: Fix partial userptr event expansion
      ASoC: codecs: hdac_hdmi: Validate written enum value
      ASoC: fsl: fsl_audmix: Validate written enum values
      ASoC: tegra: tegra210_ahub: Validate written enum value
      hwmon: (asus_atk0110) Check package count before accessing element

Hyunwoo Kim (3):
      KVM: arm64: Bound used_lrs when flushing the pKVM hyp vCPU
      rxrpc: Don't move a peeked OOB message onto the pending queue
      KVM: arm64: vgic: Check the interrupt is still ours before migrating it

Ian Bridges (3):
      fbcon: fix NULL pointer dereference for a console without vc_data
      ocfs2: fix NULL h_transaction deref in ocfs2_assure_trans_credits
      ocfs2: fix UBSAN array-index-out-of-bounds in ocfs2_sum_rightmost_rec

Ian Rogers (5):
      perf tools: Switch printf("...%s", strerror(errno)) to printf("...%m")
      perf debuginfo: Fix libdw API contract violations
      perf sched: Add missing mmap2 handler in timehist
      perf symbol: Fix ENOENT case for filename__read_build_id
      perf inject: With --convert-callchain ignore the dummy event for dwarf stacks

Ibrahim Hashimov (1):
      ksmbd: fix integer overflow in set_file_allocation_info()

Icenowy Zheng (1):
      dmaengine: qcom: gpi: set DMA_PRIVATE capability

Ido Schimmel (2):
      selftests: vlan_bridge_binding: Fix flaky operational state check
      bridge: stp: Fix a potential use-after-free when deleting a bridge

Ihor Solodrai (1):
      selftests/bpf: Add simple strscpy() implementation

Ilpo Järvinen (9):
      PCI/IOV: Adjust ->barsz[] when changing BAR size
      PCI: Change pci_dev variable from 'bridge' to 'dev'
      PCI: Try BAR resize even when no window was released
      PCI: Free saved list without holding pci_bus_sem
      PCI: Fix restoring BARs on BAR resize rollback path
      PCI: Add kerneldoc for pci_resize_resource()
      PCI: Move Resizable BAR code to rebar.c
      PCI: Fix BAR resize rollback path overwriting ret
      PCI: Fix Resizable BAR restore order

Ingo Rohloff (1):
      usb: dwc3: Support USB3340x ULPI PHY high-speed negotiation.

Inochi Amaoto (2):
      riscv: dts: sophgo: sg2044: use hex for CPU unit address
      riscv: dts: sophgo: sg2042: use hex for CPU unit address

Ioana Ciornei (2):
      dpaa2-switch: fix VLAN upper check not rejecting bridge join
      dpaa2-switch: do not accept VLAN uppers while bridged

Ion Agorria (1):
      drm/tegra: gr2d/gr3d: Contain PM in the gr*d_probe/gr*d_remove

Ionut Nechita (1):
      scsi: sas: Skip opt_sectors when DMA reports no real optimization hint

Ivan Abramov (3):
      ieee802154: Restore initial state on failed device_rename() in cfg802154_switch_netns()
      ieee802154: Avoid calling WARN_ON() on -ENOMEM in cfg802154_switch_netns()
      ieee802154: Remove WARN_ON() in cfg802154_pernet_exit()

Ivan Vecera (2):
      dpll: Support dynamic pin index allocation
      dpll: Enhance and consolidate reference counting logic

J. Neuschäfer (1):
      HID: wiimote: Fix table layout and whitespace errors

Jacob Moroni (3):
      RDMA/irdma: Fix out-of-bounds write in irdma_copy_user_pgaddrs
      RDMA/irdma: Fix OOB read during CQ MR registration
      RDMA/irdma: Initialize iwmr->access during MR registration

Jaewon Yang (1):
      tpm: Make the TPM character devices non-seekable

Jagadeesh Kona (2):
      dt-bindings: clock: qcom: Add X1P42100 camera clock controller
      clk: qcom: camcc-x1e80100: Add support for camera QDSS debug clocks

Jakub Kicinski (7):
      net: psample: fix info leak in PSAMPLE_ATTR_DATA
      eth: bnxt: gather and report HW-GRO stats
      eth: bnxt: rename ring_err_stats -> ring_drv_stats
      eth: bnxt: improve the timing of stats
      eth: fbnic: fix ordering of heartbeat vs ownership
      eth: fbnic: don't cache shinfo across skb realloc
      selftests: drv-net: tso: don't touch dangerous feature bits

Jamal Hadi Salim (5):
      net/sched: cls_flow: Dont expose folded kernel pointers
      net/sched: cls_api: Handle TC_ACT_CONSUMED in tcf_qevent_handle
      net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF
      net/sched: act_pedit: fix TOCTOU heap OOB write in tc offload
      net/sched: sch_teql: move rcu_read_lock()/spin_lock() from _bh variants

James Clark (4):
      coresight: ete: Always save state on power down
      perf annotate: Fix crashes on empty annotate windows
      perf cs-etm: Queue context packets for frontend
      perf tools: Don't read build-ids from non-regular files

James Kim (1):
      char: tlclk: fix use-after-free in tlclk_cleanup()

James Raphael Tiovalen (1):
      macsec: fix promiscuity refcount leak in macsec_dev_open()

Jamie Nguyen (3):
      firmware: arm_ffa: Honor partition info descriptor size
      fs/ntfs3: fix mount failure on 64K page-size kernels
      fs/ntfs3: resize log->one_page_buf when adopting on-disk page size

Jan Klos (1):
      net: phy: realtek: Clear MDIO_AN_10GBT_CTRL_ADV10G bit

Jann Horn (3):
      bpf,fork: wipe ->bpf_storage before bailouts that access it
      proc: protect ptrace_may_access() with exec_update_lock (FD links)
      proc: protect ptrace_may_access() with exec_update_lock (part 1)

Jarkko Sakkinen (1):
      tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()

Jason Gunthorpe (7):
      IB/cm: Fix av cm device leak on an error path in cm_init_av_by_path()
      IB/mlx5: Don't take the rereg_mr fallback without a new translation
      IB/mlx5: Properly support implicit ODP rereg_mr
      IB/mlx5: Remove unused mkc bits in mlx5r_umr_update_mr_page_shift()
      IB/mlx5: Pull the pdn out of the depths of the umr machinery
      IB/mlx5: Don't mangle the mr->pd inside the rereg callback
      IB/mlx4: Fill in the access_flags if IB_MR_REREG_ACCESS is not specified

Javier Tia (1):
      wifi: mt76: mt7925: fix stale pointer comparisons in change_vif_links

Jeff Layton (1):
      vfs: add FS_USERNS_DELEGATABLE flag and set it for NFS

Jeffrey Altman (1):
      rxrpc: rxrpc_verify_data ensure rx_dec_buffer alloc

Jens Emil Schulz Østergaard (1):
      net: microchip: vcap: fix races on the shared Super VCAP block

Jens Remus (1):
      perf s390: Fix TEXTREL in Python extension by compiling as PIC

Jessica Zhang (2):
      drm/msm/dp: fix HPD state status bit shift value
      drm/msm/dp: Fix the ISR_* enum values

Jhonraushan (1):
      accel/ivpu: Reject firmware log with size smaller than header

Jia He (2):
      init/initramfs_test: wait_for_initramfs() before running
      arm64/sysreg: Fix BWE field encoding in ID_AA64DFR2_EL1

Jia Jia (1):
      virtio: rtc: tear down old virtqueues before restore

Jia Wang (1):
      gpio: dwapb: Defer clock gating until noirq

Jiacheng Yu (1):
      fbcon: Use correct type for vc_resize() return value

Jiajia Liu (1):
      Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING

Jiakai Xu (1):
      PM: sleep: Use complete() in device_pm_sleep_init()

Jiaming Zhang (1):
      ALSA: FCP: Fix NULL pointer dereference in interface lookup

Jian Zhang (1):
      cifs: remove all cifs files before kill super

Jiawen Wu (1):
      net: libwx: fix VMDQ mask for 1-queue mode

Jiayuan Chen (2):
      net/sched: cls_bpf: prevent unbounded recursion in offload rollback
      ipv6: ioam: fix type confusion of dst_entry

Jie Gan (2):
      coresight: fix missing error code when trace ID is invalid
      coresight: Fix source not disabled on idr_alloc_u32 failure

Jihed Chaibi (1):
      ARM: dts: am335x-sl50: Fix audio bitclock and frame master endpoint

Jinjiang Tu (1):
      fs/proc: fix KPF_KSM reported for all anonymous pages

Jinjie Ruan (2):
      arm64: smp: Fix hot-unplug tearing by forcing unregistration
      cpu/hotplug: Fix NULL kobject warning in cpuhp_smt_enable()

Jiri Olsa (3):
      selftests/bpf: Fix typo in verify_umulti_link_info
      uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
      bpf: Add missing access_ok call to copy_user_syms

Jiri Pirko (1):
      RDMA/umem: Add ib_umem_is_contiguous() stub for !CONFIG_INFINIBAND_USER_MEM

Jisheng Zhang (3):
      spi: dw: fix wrong BAUDR setting after resume
      gpio: dwapb: Use modern PM macros
      binder: Use LIST_HEAD() to initialize on stack list head

Joey Lu (1):
      pinctrl: nuvoton: ma35d1: fix MFP register offset and pin table

Johan Hovold (4):
      MIPS: ip22-gio: fix gio device memory leak
      MIPS: ip22-gio: fix kfree() of static object
      MIPS: ip22-gio: fix device reference leak in probe
      power: supply: max17042: fix OF node reference imbalance

Johannes Thumshirn (2):
      btrfs: zoned: don't account data relocation space-info in statfs free space
      btrfs: zoned: always set max_active_zones for zoned devices

John Johansen (5):
      apparmor: fix shadowing of plabel that prevents cache from being updated
      apparmor: fix race in unix socket mediation when peer_path is used
      apparmor: fix refcount leak when updating the sk_ctx
      apparmor: fix rawdata_f_data implicit flex array
      apparmor: fix label can not be immediately before a declaration

John Madieu (2):
      ASoC: rsnd: Fix RSND_SOC_MASK width to single nibble
      rtc: isl1208: Balance enable_irq_wake() with disable_irq_wake() on cleanup

Jon Hunter (1):
      arm64: tegra: Fix Tegra234 MGBE PTP clock

Jonathan Cavitt (1):
      drm/gpuvm: Do not prepare NULL objects

Jordan Walters (1):
      Bluetooth: hci_core: Fix UAF in hci_unregister_dev()

Jorge Marques (1):
      i3c: master: Move rstdaa error suppression

Jose A. Perez de Azpillaga (1):
      staging: media: atomisp: fix loop shadowing in ia_css_stream_destroy()

Joseph Qi (2):
      ocfs2: fix race between ocfs2_control_install_private() and ocfs2_control_release()
      ocfs2: add journal NULL check in ocfs2_checkpoint_inode()

Joshua Crofts (6):
      iio: light: si1133: reset counter to prevent race condition
      iio: light: si1133: prevent race condition on timeout
      iio: magnetometer: ak8975: fix potential kernel stack memory leak
      hwmon: (ltc2992) add missing 'select REGMAP_I2C' to Kconfig
      hwmon: (max6697) add missing 'select REGMAP_I2C' to Kconfig
      hwmon: (max1619) add missing 'select REGMAP' to Kconfig

Josua Mayer (1):
      arm64: dts: lx2162a-clearfog: use rev2 SoC dtsi

Jozsef Kadlecsik (5):
      netfilter: ipset: Fix data race between add and dump in all hash types
      netfilter: ipset: annotate "pos" for concurrent readers/writers
      netfilter: ipset: Don't use test_bit() in lockless RCU readers in hash types
      netfilter: ipset: fix order of kfree_rcu() and rcu_assign_pointer()
      netfilter: ipset: make sure gc is properly stopped

Judith Mendez (1):
      arm64: dts: ti: k3-am62a7-sk: Add bootph-all tag to vqmmc

Julian Anastasov (2):
      ipvs: ensure inner headers in ICMP errors are in headroom
      ipvs: fix more places with wrong ipv6 transport offsets

Junrui Luo (3):
      mshv: add bounds check on vp_index in mshv_intercept_isr()
      jbd2: fix integer underflow in jbd2_journal_initialize_fast_commit()
      powerpc/spufs: fix out-of-bounds access in spufs_mem_mmap_access()

Junxian Huang (1):
      RDMA/hns: Initialize seqfile before creating file

Junxiao Chang (1):
      x86/cpu: Remove obsolete aperfmperf_get_khz() declaration

KP Singh (1):
      libbpf: Reject non-exclusive metadata maps in the signed loader

Kaitao Cheng (1):
      bpf: Clear rb node linkage when freeing bpf_rb_root

Kalesh AP (1):
      RDMA/bnxt_re: Move the UAPI methods to a dedicated file

Karl Mehltretter (3):
      lockdep/selftests: Restore migrate_disable() state on PREEMPT_RT
      lockdep/selftests: Restore sched_rt_mutex state on PREEMPT_RT
      kcov: use WRITE_ONCE() for selftest mode stores

Karol Wachowski (1):
      accel/ivpu: fix HWS command queue leak on registration failure

Kartik Rajput (1):
      dmaengine: tegra: Fix burst size calculation

Karuna Ramkumar (1):
      ata: libata-scsi: limit simulated SCSI command copy to response length

Kevin Brodsky (1):
      selftests/mm: Fix resv_sz when parsing arm64 signal frame

KhaiWenTan (1):
      igc: skip RX timestamp header for frame preemption verification

Kiryl Shutsemau (Meta) (2):
      fs/proc/task_mmu: fix hugetlb self-deadlock in pagemap_scan_pte_hole()
      fs/proc/task_mmu: use huge_page_size() in pagemap_scan_hugetlb_entry()

Koichiro Den (3):
      NTB: epf: Make db_valid_mask cover only real doorbell bits
      NTB: epf: Report 0-based doorbell vector via ntb_db_event()
      NTB: epf: Fix doorbell bitmask and IRQ vector handling

Konrad Dybcio (1):
      dt-bindings: phy: sc8280xp-qmp-pcie: Disallow bifurcation register on Purwa

Konstantin Komarov (4):
      fs/ntfs3: add bounds check to run_get_highest_vcn()
      fs/ntfs3: bound DeleteIndexEntryAllocation memmove length
      fs/ntfs3: bound attr_off in UpdateResidentValue against data_off
      fs/ntfs3: validate lcns_follow in log_replay conversion

Krzysztof Kozlowski (8):
      arm64: dts: qcom: ipq5424: Fix USB simple_bus_reg warnings
      arm64: dts: qcom: sc8180x: Fix phy simple_bus_reg warning
      arm64: dts: qcom: sdm845-mezzanine: Fix camss ports unit_address_vs_reg warning
      dt-bindings: pinctrl: nvidia,tegra234: Add missing required block
      ARM: multi_v7_defconfig: Correct QCOM_RPMH and QCOM_RPMHPD
      ARM: configs: Drop duplicated CONFIG_EXT4_FS
      arm64: dts: s32g3: Fix SWT8 watchdog address
      arm64: dts: imx8ulp-evk: Correct Type-C int GPIO flags

Krzysztof Wilczyński (3):
      alpha/PCI: Add security_locked_down() check to pci_mmap_resource()
      alpha/PCI: Fix __pci_mmap_fits() overflow for zero-length BARs
      proc: only bump parent nlink when registering directories

Kuldeep Singh (2):
      arm64: dts: qcom: kodiak: Fix ICE reg size
      arm64: dts: qcom: sm8450: Fix ICE reg size

Kunihiko Hayashi (1):
      spi: uniphier: Fix completion initialization order before devm_request_irq()

Kuniyuki Iwashima (6):
      tcp: Add preempt_{disable,enable}_nested() in reqsk_queue_hash_req().
      af_unix: Drop all SCM attributes for SOCKMAP.
      vxlan: Fix potential null-ptr-deref in vxlan_gro_prepare_receive().
      net: fib_rules: Don't dump dying fib_rule in fib_rules_dump().
      sockmap: Fix use-after-free in udp_bpf_recvmsg()
      ipv4: fib: Don't ignore error route in local/main tables.

Kwan Lai Chee Hou (1):
      wifi: ath12k: fix incorrect HT/VHT/HE/EHT MCS reporting in monitor mode

Kyle Hendry (1):
      MIPS: mm: Add check for highmem before removing memory block

Kyle Zeng (2):
      ALSA: seq: Clear variable event pointer on read
      ocfs2: avoid moving extents to occupied clusters

Lad Prabhakar (3):
      clk: renesas: rzg2l: Rename iterator in for_each_mod_clock() to avoid shadowing
      PCI: rcar-host: Remove unused LIST_HEAD(res)
      rtc: renesas-rtca3: Fix PIE clear polling condition in alarm setup error path

Lars Pöschel (1):
      spi: xilinx: use FIFO occupancy register to determine buffer size

Laxman Acharya Padhya (1):
      Bluetooth: btrtl: validate firmware patch bounds

Lee Jones (2):
      HID: core: Fix OOB read in hid_get_report for numbered reports
      can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

Leo Yan (5):
      selftests/bpf: Initialize operation name before use
      coresight: etm4x: Remove the state_needs_restore flag
      coresight: etm4x: Correct TRCVMIDCCTLR1 save and restore
      perf pmu: Skip test on Arm64 when #slots is zero
      perf: Remove redundant kernel.h include

Leon Hwang (4):
      bpf: Check tail zero of bpf_map_info
      bpf: Check tail zero of bpf_prog_info
      bpf: Update transport_header when encapsulating UDP tunnel in lwt
      bpf: Fix bpf_get/setsockopt to tos for ipv4-mapped ipv6 socket

Leon Romanovsky (1):
      RDMA/mlx5: Release the HW‑provided UAR index rather than the SW one

Li Chen (1):
      ext4: fix fast commit wait/wake bit mapping on 64-bit

Li Daming (1):
      rxrpc: serialize kernel accept preallocation with socket teardown

Li RongQing (5):
      PCI: mediatek: Fix operator precedence in PCIE_FTS_NUM_L0 macro
      ACPI: processor_idle: Mark LPI enter functions as __cpuidle
      afs: Remove erroneous seq |= 1 in volume lookup loop
      net/mlx5: Fix L3 tunnel entropy refcount leak
      fbdev: sm712: Fix operator precedence in big_swap macro

Li Xiasong (1):
      tipc: restrict socket queue dumps in enqueue tracepoints

Lianfa Weng (2):
      RDMA/hns: Fix warning in poll cq direct mode
      RDMA/hns: Fix log flood after cmd_mbox failure

Lifeng Zheng (1):
      cpufreq: conservative: Simplify frequency limit handling

Lin He (4):
      drm/hisilicon/hibmc: add updating link cap in DP detect()
      drm/hisilicon/hibmc: fix no showing when no connectors connected
      drm/hisilicon/hibmc: move display contrl config to hibmc_probe()
      drm/hisilicon/hibmc: use clock to look up the PLL value

Linmao Li (1):
      ipv6: addrconf: bail out of dad_failure when state is no longer POSTDAD

Liviu Dudau (1):
      drm/syncobj: Fix memory leak in drm_syncobj_find_fence()

Lizhi Hou (2):
      accel/amdxdna: Use unsigned long for nr_pages in amdxdna_hmm_register()
      accel/amdxdna: Fix potential amdxdna_umap lifetime race

Longjun Tang (1):
      virtio_net: disable cb when NAPI is busy-polled

Lorenzo Bianconi (3):
      wifi: mt76: mt7996: Fix possible token leak in mt7996_tx_prepare_skb()
      wifi: mt76: mt7996: Fix possible NULL pointer dereference in mt7996_mac_write_txwi_80211()
      wifi: mt76: mt7996: fix reading zeroed info->control.flags after mt76_tx_status_skb_add()

Lothar Rubusch (1):
      crypto: atmel-sha204a - fix blocking and non-blocking rng logic

Louis Kotze (1):
      wifi: cfg80211: fix grammar in MLO group key error message

Louis Scalbert (5):
      tools: missed broadcast_neigh if_link uapi header
      netlink: specs: rt-link: missed broadcast-neigh
      bonding: 3ad: add lacp_strict configuration knob
      bonding: 3ad: fix carrier when no usable slaves
      bonding: 3ad: fix mux port state on oper down

Luca Leonardo Scorcia (3):
      soc: mediatek: mtk-mmsys: Restore MT8167 routing masks lost during merge
      pinctrl: mediatek: mt8516: Fix Schmitt trigger register offset of pins 34-39
      pinctrl: mediatek: mt8167: Fix Schmitt trigger register offset of pins 34-39

Luca Weiss (1):
      ASoC: codecs: lpass-va-macro: Fix LPASS Codec Version for SC7280

Lucas Tsai (1):
      power: supply: core: fix supplied_from allocations

Lukasz Czapnik (1):
      ice: fix AQ error code comparison in ice_set_pauseparam()

Lukasz Raczylo (1):
      net: macb: add TX stall timeout callback to recover from lost TSTART write

Luke Wang (8):
      mmc: sdhci-esdhc-imx: restore pinctrl before restoring ios timing on resume
      mmc: sdhci-esdhc-imx: remove unnecessary mmc_card_wake_sdio_irq check for tuning save/restore
      mmc: sdhci-esdhc-imx: restore DLL override for DDR modes on resume
      mmc: sdhci-esdhc-imx: fix esdhc_change_pinstate() to allow default state restore
      mmc: sdhci-esdhc-imx: disable irq during suspend to fix unhandled interrupt
      mmc: sdhci-esdhc-imx: use pm_runtime_resume_and_get() in suspend
      mmc: sdhci-esdhc-imx: make non-fatal errors non-blocking in suspend
      mmc: sdhci-esdhc-imx: fix resume error handling

Luo Jie (1):
      clk: qcom: cmnpll: Account for reference clock divider

Luxiao Xu (1):
      sunrpc: harden rq_procinfo lifecycle to prevent double-free

Ma Ke (1):
      power: supply: cpcap-battery: Fix missing nvmem_device_put() causing reference leak

Maciej W. Rozycki (4):
      MIPS: Fix big-endian stack argument fetching in o32 wrapper
      MIPS: DEC: Remove do_IRQ() call indirection
      MIPS: DEC: Ensure RTC platform device deregistration upon failure
      MIPS: DEC: Ensure 32-bit stack location for o32 prom_printf()

Maciek Borzecki (1):
      apparmor: fix uninitialised pointer passed to audit_log_untrustedstring()

Maher Sanalla (1):
      RDMA/mlx5: Fix undefined shift of user RQ WQE size

Manivannan Sadhasivam (5):
      PCI: mediatek: Use actual physical address instead of virt_to_phys()
      PCI: endpoint: pci-epf-vntb: Add check to detect 'db_count' value of 0
      PCI: endpoint: pci-epf-ntb: Add check to detect 'db_count' value of 0
      bus: mhi: host: pci_generic: Fix the physical function check
      bus: mhi: ep: Protect mhi_ep_handle_syserr() in the error path

Maoyi Xie (13):
      net: thunderbolt: Fix frags[] overflow by bounding frame_count
      xfrm: xfrm_interface: require CAP_NET_ADMIN in the device netns for changelink
      netdev-genl: report NAPI thread PID in the caller's pid namespace
      wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()
      net: sit: require CAP_NET_ADMIN in the device netns for changelink
      net: ip6_vti: require CAP_NET_ADMIN in the device netns for changelink
      net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
      net: ipip: require CAP_NET_ADMIN in the device netns for changelink
      net: ip6_gre: require CAP_NET_ADMIN in the device netns for changelink
      net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
      net: wwan: iosm: bound device offsets in the MUX downlink decoder
      wifi: brcmfmac: cyw: fix heap overflow on a short auth frame
      memstick: ms_block: reject a card that reports too many blocks

Marc Zyngier (4):
      KVM: arm64: vgic: Handle race between interrupt affinity change and LPI disabling
      KVM: Move kvm_io_bus_get_dev() locking responsibilities to callers
      KVM: arm64: Fix propagation of TLBI level in kvm_pgtable_stage2_relax_perms()
      KVM: arm64: Deduplicate ASID retrieval code

Marcin Szycik (1):
      ice: call netif_keep_dst() once when entering switchdev mode

Marco Crivellari (1):
      i3c: master: add WQ_PERCPU to alloc_workqueue users

Marco Nenciarini (1):
      PCI: Skip Resizable BAR restore on read error

Marek Vasut (2):
      dt-bindings: vendor-prefixes: Add Displaytech Ltd.
      arm64: dts: st: Fix SAI addresses on stm32mp251

Mario Limonciello (3):
      gpiolib: acpi: Only trigger ActiveBoth interrupts on boot
      drm/amdkfd: fix list_del corruption in kfd_criu_resume_svm
      x86/video: Only fall back to vga_default_device() without screen info

Mark Harmstone (1):
      btrfs: don't force DIO writes to be serialized

Mark Rutland (1):
      arm64: fpsimd: Fix type mismatch in sve_{save,load}_state()

Mark Tomlinson (1):
      PCI: iproc: Restore .map_irq() for the platform bus driver

Martin Kaiser (3):
      tracing: probes: fix typo in a log message
      tracing: eprobe: read the complete FILTER_PTR_STRING pointer
      riscv: probes: save original sp in rethook trampoline

Martin Wilck (2):
      scsi: Revert "scsi: Fix sas_user_scan() to handle wildcard and multi-channel scans"
      scsi: smartpqi: Use shost_to_hba() in pqi_scan_finished()

Masami Hiramatsu (Google) (5):
      lib/vsprintf: Fix to check field_width and precision
      tracing/probes: Remove WARN_ON_ONCE from parse_btf_arg
      tracing/events: Fix to check the simple_tsk_fn creation
      tracing/probes: Make the $ prefix mandatory for comm access
      tracing/probes: Fix double addition of offset for @+FOFFSET

Mateusz Nowicki (1):
      nvme-pci: fix out-of-bounds access in nvme_setup_descriptor_pools

Mathias Krause (1):
      netfilter: nf_nat: avoid invalid nat_net pointer use on failed nf_nat_init()

Matt Bobrowski (3):
      selftests/bpf: Fix off-by-one in bpf_cpumask_populate related selftest
      bpf: fix crash in bpf_[set|remove]_dentry_xattr for negative dentries
      bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF LSM is uninitialized

Matt Fleming (1):
      ipmi: Fix user refcount underflow in event delivery

Matthew Brost (1):
      drm/gpusvm: Reject VMAs with VM_IO or VM_PFNMAP when creating SVM ranges

Matthew Bystrin (1):
      mfd: rsmu: Fix page register setup

Matthew Rosato (1):
      KVM: s390: pci: Fix handling of AIF enable without AISB

Matthew Schwartz (1):
      drm/amd/display: Fix mem_type change detection for async flips

Matthew Wilcox (Oracle) (1):
      Revert "btrfs: fix the file offset calculation inside btrfs_decompress_buf2page()"

Matthias Feser (1):
      serial: 8250_omap: clear rx_running on zero-length DMA completes

Matthieu Buffet (1):
      landlock: Fix unmarked concurrent access to socket family

Matti Vaittinen (1):
      hwmon: adm1275: Prevent reading uninitialized stack

Matvey Kovalev (2):
      afs: fix NULL pointer dereference in afs_get_tree()
      qede: fix out-of-bounds check for cqe->len_list[]

Mauricio Faria de Oliveira (3):
      usb: atm: ueagle-atm: use dev_dbg() for 'device found' message
      usb: atm: ueagle-atm: remove function entry/exit debug messages
      usb: atm: ueagle-atm: wait for pre-firmware load in .disconnect()

Max Zhen (1):
      accel/amdxdna: Fix leak when pinning ubuf pages

Maxime Bélair (1):
      apparmor: fix potential UAF in aa_replace_profiles

Maxwell Doose (1):
      fs: efs: remove unneeded debug prints

Maíra Canal (1):
      drm/v3d: Reject invalid indirect BO handle in indirect CSD setup

Michael Bommarito (28):
      iommu/vt-d: Clear Present bit before tearing down scalable-mode context entry
      libbpf: Harden parse_vma_segs() path parsing
      tipc: require net admin for TIPCv2 netlink mutators
      tipc: prevent snt_unacked underflow on CONN_ACK
      tipc: reject inverted service ranges from peer bindings
      ALSA: usb-audio: qcom: reject stream disable with no active interface
      ALSA: usb-audio: qcom: clear opened when stream enable fails
      net/sched: act_ct: fix nf_connlabels leak on two error paths
      minix: avoid overflow in bitmap block count calculation
      net: qrtr: fix 32-bit integer overflow in qrtr_endpoint_post()
      fs/ntfs3: bound copy_lcns dp->page_lcns[] index in analysis pass
      fs/ntfs3: add depth limit to indx_find_buffer to prevent stack overflow
      fs/ntfs3: bound NTFS_DE view.data_off in UpdateRecordData{Root,Allocation}
      ntfs3: cap RESTART_TABLE free-chain walker at rt->used
      ntfs3: bound to_move in indx_insert_into_root before hdr_insert_head
      ntfs3: validate split-point offset in indx_insert_into_buffer
      ocfs2: reject dinodes with non-canonical i_mode type
      ocfs2: reject dinodes whose i_rdev disagrees with the file type
      ocfs2: reject non-inline dinodes with i_size and zero i_clusters
      tpm: tpm2-sessions: wait for async KPP completion in tpm_buf_append_salt
      tcp: defer md5sig_info kfree past RCU grace period in tcp_connect
      nvmet-auth: reject short AUTH_RECEIVE buffers
      scsi: xen: scsiback: Free the command tag on the TMR submit-failure path
      scsi: xen: scsiback: Free unsubmitted command instead of double-putting it
      tracing/user_events: Fix use-after-free in user_event_mm_dup()
      ieee802154: admin-gate legacy LLSEC dump operations
      ieee802154: allow legacy LLSEC ADD/DEL ops to pass strict validation
      drbd: reject data replies with an out-of-range payload size

Michael Petlan (1):
      perf build-id: Fix off-by-one bug when printing kernel/module build-id

Michael S. Tsirkin (1):
      vhost: fix vhost_get_avail_idx for a non empty ring

Michal Wajdeczko (1):
      drm/xe/pf: Don't attempt to process FAST_REQ or EVENT relays

Mihai Sain (1):
      clk: at91: sam9x7: Fix gmac_gclk clock definition

Mike Christie (1):
      scsi: target: Remove tcm_loop target reset handling

Mike Snitzer (2):
      NFSv4/flexfiles: honor FF_FLAGS_NO_IO_THRU_MDS on fatal DS connect errors
      NFSv4/flexfiles: honor FF_FLAGS_NO_IO_THRU_MDS in pg_get_mirror_count_write

Mike Waychison (1):
      block: fix race in blk_time_get_ns() returning 0

Mikhail Kshevetskiy (2):
      pinctrl: airoha: an7581: add missed gpio32 pin group
      pinctrl: airoha: an7581: fix misprint in gpio19 pinconf

Mikko Perttunen (3):
      gpu: host1x: Allow entries in BO caches to be freed
      gpu: host1x: Fix iommu_map_sgtable() return value check
      drm/tegra: Fix iommu_map_sgtable() return value check

Mikulas Patocka (12):
      dm-bufio: fix wrong count calculation in dm_bufio_issue_discard
      dm-ioctl: fix a possible overflow in list_version_get_info
      dm-stats: fix dm_jiffies_to_msec64
      dm-stats: fix merge accounting
      dm_early_create: fix freeing used table on dm_resume failure
      dm-integrity: fix leaking uninitialized kernel memory
      dm-integrity: fix a bug if the bio is out of limits
      dm-integrity: don't increment hash_offset twice
      dm-verity: avoid double increment of &use_bh_wq_enabled
      dm-verity: fix a possible NULL pointer dereference
      dm-verity: increase sprintf buffer size
      dm-verity: make error counter atomic

Ming-Hung Tsai (1):
      dm thin metadata: fix metadata snapshot consistency on commit failure

Miquel Raynal (4):
      mtd: spi-nor: debugfs: Fix the flags list
      mtd: spi-nor: Drop duplicate Kconfig dependency
      mtd: spi-nor: swp: Improve locking user experience
      mtd: rawnand: Pause continuous reads at block boundaries

Mohamed Khalfella (1):
      i40e: Fix i40e_debug() to use struct i40e_hw argument

Morduan Zang (1):
      iomap: guard io_size EOF trim against concurrent truncate underflow

Muchun Song (3):
      mm/mm_init: fix pageblock migratetype for ZONE_DEVICE compound pages
      mm/memory_hotplug: fix incorrect altmap passing in error path
      mm/mm_init: fix uninitialized struct pages for ZONE_DEVICE

Muhammad Bilal (1):
      netfilter: nf_conntrack_irc: fix parse_dcc() off-by-one OOB read

Muhammet Kaan KILINÇ (1):
      crypto: algif_skcipher - force synchronous processing

Myeonghun Pak (2):
      wifi: mt76: mt7925: clean up DMA on probe failure
      ata: sata_gemini: unwind clocks on IDE pinctrl errors

Mykyta Yatsenko (3):
      bpf: Fix NMI/tracepoint re-entry deadlock on lru locks
      bpf: Consistently use reg_state() for register access in the verifier
      bpf: Introduce struct bpf_map_desc in verifier

Nam Cao (1):
      eventpoll: Fix epoll_wait() report false negative

Namhyung Kim (1):
      perf inject: Add --convert-callchain option

Namjae Jeon (2):
      ksmbd: use opener credentials for FSCTL mutations
      ksmbd: track the connection owning a byte-range lock

Nan Li (1):
      afs: handle CB.InitCallBackState3 requests without a server record

Nas Chung (1):
      media: v4l2-common: Add YUV24 format info

Nathan Chancellor (1):
      driver core: Use system_percpu_wq instead of system_wq

Neill Kapron (1):
      usb: gadget: f_fs: Tie read_buffer lifetime to ffs_epfile

Nick Chan (1):
      nvme-apple: Prevent shared tags across queues on Apple A11

Nick Hu (1):
      dt-bindings: timer: Remove sifive,fine-ctr-bits property

Nickolay Goppen (1):
      arm64: dts: qcom: sdm630: describe adsp_mem region properly

Nicolai Buchwitz (1):
      net: usb: lan78xx: restore VLAN and hash filters after link up

Nicolin Chen (3):
      iommu: Avoid copying the user array twice in the full-array copy helper
      iommufd: Propagate allocation failure in iommufd_veventq_deliver_fetch()
      iommufd: Move vevent memory allocation outside spinlock

Nikita Zhandarovich (1):
      hwmon: (it87) Clamp negative values to zero in set_fan()

Nikolay Kulikov (1):
      staging: rtl8723bs: fix spaces around binary operators

Nilay Shroff (1):
      nvme-multipath: fix flex array size in struct nvme_ns_head

Nirmoy Das (2):
      selftests: tls: size splice_short pipe by page size
      selftests: net: make busywait timeout clock portable

Nuno Sá (3):
      dmaengine: Fix possible use after free
      dmaengine: dma-axi-dmac: Properly free struct axi_dmac_desc
      dmaengine: dma-axi-dmac: use DMA pool to manange DMA descriptor

Nuoqi Gui (3):
      bpf: Fix stack slot index in nospec checks
      seg6: validate SRH length before reading fixed fields
      bpf: Keep dynamic inner array lookups nullable

Oleg Nesterov (1):
      seqlock: Change do_task_stat() to use scoped_seqlock_read()

Oliver Hartkopp (6):
      ALSA: hda: fix Kconfig dependency of HD Audio PCI
      can: isotp: use unconditional synchronize_rcu() in isotp_release()
      can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
      can: isotp: serialize TX state transitions under so->rx_lock
      can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure
      can: bcm: add missing rcu list annotations and operations

Oliver Upton (6):
      KVM: arm64: nv: Drop bogus WARN for write to ZCR_EL2
      KVM: arm64: nv: Respect read-only PFN when mapping L1 VNCR
      KVM: arm64: nv: Inject SEA if kvm_translate_vncr() can't resolve PFN
      KVM: arm64: nv: Inject SEA if guest VNCR isn't normal memory
      KVM: arm64: Ensure level is always initialized when relaxing perms
      KVM: arm64: nv: Re-translate VNCR before injecting abort

Ondrej Mosnacek (1):
      selinux: fix incorrect execmem checks on overlayfs

Ovidiu Panait (1):
      net: bcmgenet: Use weighted round-robin TX DMA arbitration

Pablo Neira Ayuso (5):
      netfilter: nfnetlink_cthelper: use {READ,WRITE}_ONCE for accessing helper flags
      netfilter: conntrack: revert ct extension genid infrastructure
      netfilter: conntrack: call nf_ct_gre_keymap_destroy() if master helper is pptp
      netfilter: flowtable: move path discovery infrastructure to its own file
      netfilter: nft_set_rbtree: get command skips end element with open interval

Paolo Abeni (1):
      virtio_net: do not allow tunnel csum offload for non GSO packets

Patrisious Haddad (2):
      RDMA/mlx5: Remove DCT restrack tracking
      RDMA/mlx5: Remove raw RSS QP restrack tracking

Paul Chaignon (1):
      selftests/bpf: Fix test for refinement of single-value tnum

Paul Greenwalt (1):
      ice: fix ice_init_link() error return preventing probe

Paul Louvel (1):
      gpio-f7188x: Add support for NCT6126D version B

Pauli Virtanen (4):
      Bluetooth: ISO: exclude RFU bits from ISO_SDU_Length
      Bluetooth: SCO: fix sleeping under spinlock in sco_conn_ready
      Bluetooth: SCO: hold sk properly in sco_conn_ready
      Bluetooth: 6lowpan: fix cyclic locking warning on netdev unregister

Pei Xiao (1):
      i2c: spacemit: fix spurious IRQ handling returning IRQ_HANDLED

Peng Fan (5):
      arm64: dts: imx8x-colibri: Correct SODIMM PAD settings
      Revert "arm64: dts: imx8mm-kontron: Add support for reading SD_VSEL signal"
      Revert "arm64: dts: imx8mp-kontron: Add support for reading SD_VSEL signal"
      pmdomain: imx: Fix i.MX8MP power notifier
      pmdomain: imx: Fix i.MX8MP VC8000E power up sequence

Pengfei Zhang (1):
      ipv6: fib6: fix NULL deref in fib6_walk_continue() on multi-batch dump

Pengjie Zhang (2):
      cpufreq: Documentation: fix sampling_down_factor range
      cpufreq: Documentation: fix conservative governor freq_step description

Pengpeng Hou (14):
      evm: terminate and bound the evm_xattrs read buffer
      tracing: Bound synthetic-field strings with seq_buf
      sparc: led: avoid trimming a newline from empty writes
      gpio: mlxbf3: fail probe if gpiochip registration fails
      spi: sh-msiof: abort transfers when reset times out
      gpio: mvebu: fail probe if gpiochip registration fails
      gpio: htc-egpio: use managed gpiochip registration
      hwmon: (w83627hf) remove VID sysfs files on error and remove
      hwmon: (w83793) remove vrm sysfs file on probe failure
      mtd: onenand: samsung: report DMA completion timeouts
      mtd: mchp23k256: use SPI match data for chip caps
      mtd: rawnand: fsl_ifc: return errors for failed page reads
      mtd: rawnand: lpc32xx_mlc: fail DMA transfers on timeout
      mtd: rawnand: lpc32xx_slc: fail DMA transfer on completion timeout

Peter Ujfalusi (5):
      ASoC: SOF: ipc4-control: Fix TOCTOU in sof_ipc4_bytes_put
      ASoC: SOF: ipc3-control: Use overflow checks in control_update size calc
      ASoC: SOF: ipc3-control: Fix TOCTOU in bytes_put and bytes_get
      ASoC: SOF: ipc3-control: Fix heap overflow in bytes_ext put/get
      ASoC: SOF: ipc3-control: Validate size in snd_sof_update_control

Peter Zijlstra (1):
      seqlock: Introduce scoped_seqlock_read()

Petr Wozniak (1):
      net: phy: sfp: free mii_bus in sfp_i2c_mdiobus_destroy

Philippe Schenker (1):
      net: ethernet: ti: icssg: guard PA stat lookups

Phillip Varney (1):
      clk: qcom: a53: Corrected frequency multiplier for 1152MHz

Pranjal Shrivastava (1):
      iommu/vt-d: Fix RB-tree corruption in probe error path

Prasanna Kumar T S M (1):
      soc: xilinx: Shutdown and free rx mailbox channel

Prathamesh Deshpande (3):
      IB/mlx5: Fix transport-domain rollback and initialize lb mutex earlier
      RDMA/mlx5: Fix UMR XLT cleanup on ODP populate failure
      RDMA/mlx5: Fix devx subscribe-event unwind NULL dereference

Przemyslaw Korba (1):
      idpf: add padding to PTP virtchnl structures

Puranjay Mohan (2):
      selftests: bpf: Add test for multiple syncs from linked register
      selftests/bpf: Add tests for improved linked register tracking

Qiang Ma (3):
      spi: hisi-kunpeng: Use dev_err_probe() for host registration failure
      LoongArch: KVM: Check the return values for put_user()
      LoongArch: KVM: Return full old CSR value from kvm_emu_xchg_csr()

Qianyu Luo (1):
      xfrm: nat_keepalive: avoid double free on send error

Qihang (1):
      gue: validate REMCSUM private option length

Qihang Tang (2):
      vduse: hold vduse_lock across IDR lookup in open path
      vhost/vdpa: validate virtqueue index in mmap and fault paths

Qing Ming (1):
      vhost/net: complete zerocopy ubufs only once

Qingshuang Fu (2):
      gpio: davinci: fix IRQ domain leak on devm_kzalloc failure
      irqchip/ts4800: Fix missing chained handler cleanup on remove

Qiuxu Zhuo (1):
      EDAC/igen6: Fix call trace due to missing release()

Qu Wenruo (5):
      btrfs: concentrate the error handling of submit_one_sector()
      btrfs: replace for_each_set_bit() with for_each_set_bitmap()
      btrfs: remove folio parameter from ordered io related functions
      btrfs: fix false IO failure after falling back to buffered write
      btrfs: fix incorrect buffered IO fallback for append direct writes

Quang Nguyen (1):
      spi: rpc-if: Use correct device for hardware reinitialization on resume

Quentin Schulz (2):
      arm64: dts: rockchip: fix Ethernet PHY not found on PX30 Cobra
      arm64: dts: rockchip: fix Ethernet PHY not found on PX30 Ringneck

Rafael Beims (2):
      wifi: mwifiex: fix roaming to different channel in host_mlme mode
      wifi: mwifiex: fix permanently busy scans after multiple roam iterations

Rafael J. Wysocki (10):
      thermal: hwmon: Fix critical temperature attribute removal
      x86/platform/olpc: xo15: Drop wakeup source on driver removal
      platform/x86: xo15-ebook: Fix wakeup source and GPE handling
      thermal: testing: zone: Flush work items during cleanup
      cpufreq: intel_pstate: Set non-turbo capacity to HWP_GUARANTEED_PERF()
      ACPI: NFIT: core: Fix acpi_nfit_init() error cleanup
      ACPI: driver: Check ACPI_COMPANION() against NULL during probe
      ACPI: bus: Introduce devm_acpi_install_notify_handler()
      ACPI: NFIT: core: Use devm_acpi_install_notify_handler()
      ACPI: NFIT: core: Fix possible deadlock and missing notifications

Rajat Gupta (1):
      wifi: mt76: use kfree_rcu for offchannel link in mt76_put_vif_phy_link

Randy Dunlap (4):
      bitops: use common function parameter names
      x86/cpu: Keep the PROCESSOR_SELECT menu together
      platform/x86/intel/vsec: correct kernel-doc comments
      seqlock: fix scoped_seqlock_read kernel-doc

Ratheesh Kannoth (2):
      octeontx2-af: npc: Fix size of entry2cntr_map
      octeontx2-pf: Fix leak of SQ timestamp buffer on teardown

Ravi Bangoria (1):
      perf test amd ibs: Fix incorrect kernel version check

Reinette Chatre (1):
      fs/resctrl: Fix double-add of pseudo-locked region's RMID to free list

Renjiang Han (3):
      media: qcom: venus: drop extra padding in NV12 raw size calculation
      media: qcom: venus: relax encoder frame/blur dimension steps on v4
      media: qcom: venus: relax encoder frame/blur step size on v6

Ricardo Neri (1):
      thermal: intel: Fix dangling resources on thermal_throttle_online() failure

Ricardo Ribalda (7):
      media: uvcvideo: Use hw timestaming if the clock buffer is full
      media: uvcvideo: Avoid partial metadata buffers
      media: uvcvideo: Fix buffer sequence in frame gaps
      media: uvcvideo: Fix dev_sof filtering in hw timestamp
      media: uvcvideo: Do not add clock samples with small sof delta
      media: uvcvideo: Relax the constrains for interpolating the hw clock
      media: uvcvideo: Fix sequence number when no EOF

Richard Fitzgerald (3):
      ASoC: cs35l56: Fix missing calls to wm_adsp2_remove()
      ASoC: cs35l56: Don't leave parent IRQ disabled if system_suspend fails
      ASoC: cs35l56: Fix possible uninitialized value in cs35l56_spi_system_reset()

Richard Zhu (2):
      arm64: dts: imx95: Correct PCIe outbound address space configuration
      PCI: imx6: Configure REF_USE_PAD before PHY reset for i.MX95

Ritesh Kumar (1):
      arm64: dts: qcom: lemans: Add eDP ref clock for eDP PHYs

Rob Herring (Arm) (1):
      dt-bindings: net: renesas,ether: Drop example "ethernet-phy-ieee802.3-c22" fallback

Robertus Diawan Chris (1):
      mac802154: Prevent overwrite return code in mac802154_perform_association()

Rochan Avlur (1):
      exfat: preserve benign secondary entries during rename and move

Roger Pau Monne (1):
      nvme-pci: DMA unmap the correct regions in nvme_free_sgls

Roman Kvasnytskyi (1):
      selftests/bpf: Reject unsupported -k option in vmtest.sh

Roman Vivchar (1):
      i2c: mediatek: fix WRRD for SoCs without auto_restart option

Ronaldo Nunez (1):
      pwm: imx27: Fix variable truncation in .apply()

Ronan Dalton (1):
      rtc: ds1307: handle oscillator stop flag for ds1337/ds1339/ds3231

Rong Zhang (1):
      PCI: loongson: Do not ignore downstream devices on external bridges

Rongguang Wei (1):
      s390/zcrypt: Remove the empty file

Rosen Penev (8):
      mips: ralink: mt7621: add missing __iomem
      mips: n64: add __iomem for writel call
      HID: logitech-hidpp: remove excess kernel-doc member in hidpp_scroll_counter
      net: emac: Fix NULL pointer dereference in emac_probe
      net: gianfar: dispose irq mappings on probe failure and device removal
      gpio: dwapb: reduce allocation to single kzalloc
      net: mdio: select REGMAP_MMIO instead of depending on it
      gpio: mvebu: free generic chips on unbind

Ross Porter (1):
      selftests: net: fix file owner for broadcast_ether_dst test

Rui Qi (2):
      riscv: stacktrace: Remove bogus -0x4 offset in non-FP walk_stackframe
      perf: Fix off-by-one stack buffer overflow in kallsyms__parse()

Runyu Xiao (8):
      kcm: use WRITE_ONCE() when changing lower socket callbacks
      netfilter: nft_synproxy: stop bypassing the priv->info snapshot
      octeontx2-pf: clear stale mailbox IRQ state before request_irq()
      octeontx2-vf: clear stale mailbox IRQ state before request_irq()
      gpio: tegra: do not call pinctrl for GPIO direction
      hwmon: (occ) unregister sysfs devices outside occ lock
      wifi: rt2x00: avoid full teardown before work setup in probe
      mmc: vub300: defer reset until cmd_mutex is unlocked

Ruoyu Wang (7):
      spi: meson-spifc: fix runtime PM leak on remove
      net: wwan: t7xx: check skb_clone in control TX
      apparmor: check label build before no_new_privs test
      net: marvell: prestera: initialize err in prestera_port_sfp_bind
      gpiolib: initialize return value in gpiochip_set_multiple()
      net: sungem: fix probe error cleanup
      mtd: slram: remove failed entries from the device list

Ryan Lee (1):
      apparmor: grab ns lock and refresh when looking up changehat child profiles

Ryder Lee (5):
      wifi: mt76: mt7915: fix potential tx_retries underflow
      wifi: mt76: mt7921: fix potential tx_retries underflow
      wifi: mt76: mt7925: fix potential tx_retries underflow
      wifi: mt76: mt7996: fix potential tx_retries underflow
      PCI: mediatek: Fix possible truncation in mtk_pcie_parse_port()

Sabrina Dubroca (1):
      espintcp: use sk_msg_free_partial to fix partial send

Sagi Grimberg (2):
      nvmet-tcp: Fix potential UAF when ddgst mismatch
      pNFS/filelayout: fix cheking if a layout is striped

Samuel Holland (3):
      media: cedrus: Fix failure to clean up hardware on probe failure
      bus: sunxi-rsb: Always check register address validity
      riscv: Fix 32-bit call_on_irq_stack() frame pointer ABI

Samuel Moelius (9):
      thermal: testing: reject missing command arguments
      Bluetooth: hci: validate codec capability element length
      Bluetooth: vhci: validate devcoredump state before side effects
      net: pfcp: allocate per-cpu tstats for PFCP netdevs
      net/sched: dualpi2: clear stale classification on filter miss
      net/sched: hhf: clear heavy-hitter state on reset
      net/sched: cake: reject overhead values that underflow length
      dm era: fix out-of-bounds memory access for non-zero start sector
      dm-pcache: reject option groups without values

Sandipan Das (5):
      perf/x86/amd/core: Always use the NMI latency mitigation
      perf/x86/amd/uncore: Use Node ID to identify DF and UMC domains
      perf/x86/amd/core: Avoid enabling BRS from the SVM reload path
      perf/x86/amd/brs: Fix kernel address leakage
      perf/x86/amd/lbr: Fix kernel address leakage

Sang-Heon Jeon (1):
      mm/fake-numa: fix under-allocation detection in uniform split

Sanjay Chitroda (1):
      iio: accel: mma8452: handle I2C read error(s) in mma8452_read()

Sanman Pradhan (1):
      xfrm: use compat translator only for u64 alignment mismatch

Sara Venkatesh (1):
      RDMA/srpt: fix integer overflow in immediate data length check

Saravana Kannan (2):
      Revert "treewide: Fix probing of devices in DT overlays"
      of: dynamic: Fix overlayed devices not probing because of fw_devlink

Sayali Patil (11):
      selftests/mm: restore default nr_hugepages value via exit trap in charge_reserved_hugetlb.sh
      selftests/mm: restore default nr_hugepages value via exit trap in hugetlb_reparenting_test.sh
      selftests/mm: fix hugetlb pathname construction in hugetlb_reparenting_test.sh
      selftests/mm: fix cgroup task placement and drop memory.current checks in hugetlb_reparenting_test.sh
      selftests/mm: size tmpfs according to PMD page size in split_huge_page_test
      selftests/mm: free dynamically allocated PMD-sized buffers in split_huge_page_test
      selftest/mm: register existing mapping with userfaultfd in hugetlb-mremap
      selftests/mm: ensure destination is hugetlb-backed in hugetlb-mremap
      selftests/mm: skip uffd-stress test when nr_pages_per_cpu is zero
      selftests/mm: clarify alternate unmapping in compaction_test
      selftests/mm: allow PUD-level entries in compound testcase of hmm tests

Sean Anderson (1):
      media: uvcvideo: Fix deadlock if uvc_status_stop is called from async_ctrl.work

Sean Christopherson (5):
      iommu/amd: Fix a stale comment about which legacy mode is user visible
      crypto: ccp - Treat zero-length cert chain as query for blob lengths
      KVM: x86: Ignore pending PV EOI if the vCPU has since disabled PV EOIs
      KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails due to invalid guest state
      KVM: TDX: Account all non-transient page allocations for per-TD structures

Sean Wang (2):
      wifi: mt76: mt7925: keep TX BA state in the primary WCID
      wifi: mt76: mt792x: skip MLD header rewrite for 802.3 encap TX

Sebastian Alba Vives (2):
      fpga: dfl: add bounds check in dfh_get_param_size()
      fpga: microchip-spi: fix zero header_size OOB read in mpf_ops_parse_header()

Sebastian Andrzej Siewior (1):
      mailbox: imx: Forward the timeout/ error in imx_mu_generic_tx()

Sechang Lim (5):
      bpf: Fix NULL pointer dereference in bpf_task_from_vpid()
      tcp: clear sock_ops cb flags before force-closing a child socket
      bpf, sockmap: fix integer overflow in bpf_msg_pop_data() bounds check
      tracing/fprobe: Fix NULL pointer dereference in fprobe_fgraph_entry()
      net/sched: act_bpf: use rcu_dereference_bh() to read the filter

Selvamani Rajagopal (1):
      net: ethernet: oa_tc6: Remove FCS size in RX frame

Selvin Xavier (5):
      RDMA/bnxt_re: Free SRQ toggle page after firmware teardown
      RDMA/bnxt_re: Avoid displaying the kernel pointer
      RDMA/bnxt_re: Fail DBR related page allocation UAPIs if the feature is disabled
      RDMA/bnxt_re: Initialize dpi variable to zero
      RDMA/bnxt_re: Avoid repeated requests to allocate WC pages

Sen Wang (1):
      ASoC: tlv320aic3x: restrict CLKDIV bypass Q values in dual-rate mode

SeongJae Park (5):
      mm/damon/core: make charge_addr_from aware of end-address exclusivity
      mm/damon/sysfs-schemes: fix dir put orders in access_pattern_add_dirs()
      mm/damon/sysfs-schemes: put stats for scheme_add_dirs() internal error
      mm/damon/core: always put unsuccessfully committed target pids
      mm/damon/core: trace esz at first setup

Sergey Senozhatsky (1):
      mailbox: mtk-adsp: fix UAF during device teardown

Sergey Shtylyov (2):
      of: cpu: add check in __of_find_n_match_cpu_property()
      mmc: sdhci-of-dwcmshc: check bus clock enable result in the probe() method

Sergio Paracuellos (4):
      gpio: mt7621: fix interrupt banks mapping on gpio chips
      gpio: mt7621: more robust management of IRQ domain teardown
      gpio: mt7621: be sure IRQ domain is created before exposing GPIO chips
      gpio: mt7621: avoid corruption of shared interrupt trigger state

Seungjin Bae (2):
      usb: host: max3421: Fix shift-out-of-bounds in max3421_hub_control()
      usb: host: max3421: Reject hub port requests for non-existent ports

Shawn Guo (1):
      PCI: qcom: Disable ASPM L0s for SA8775P

Shay Drory (1):
      net/mlx5: LAG, MPESW, Fix missing complete() on devcom error

Shengjiu Wang (2):
      dmaengine: imx-sdma: Refine spba bus searching in probe
      ASoC: fsl_asrc_dma: fix eDMA maxburst misalignment with channel count

Sherry Sun (3):
      arm64: dts: imx8dxl-evk: Remove unnecessary PCIe EP properties
      arm64: dts: imx8qxp-mek: Remove unnecessary PCIe EP vpcie-supply
      arm64: dts: imx95-19x19-evk: Fix PCIe EP vpcie-supply

Shigeru Yoshida (1):
      qede: fix off-by-one in BD ring consumption on build_skb failure

Shin-Yi Lin (1):
      wifi: rtw89: Correct data type for scan index to avoid infinite loop

Shiraz Saleem (1):
      RDMA/mana_ib: Use ib_get_eth_speed for reporting port speed

Shitalkumar Gandhi (3):
      net: ethernet: sunplus: spl2sw: fix phy_node refcount leak in remove
      ieee802154: ca8210: fix cas_ctl leak on spi_async failure
      ieee802154: ca8210: fix pointer truncation in kfifo on 64-bit

Shivam Kumar (1):
      nvmet-tcp: check INIT_FAILED before nvmet_req_uninit in digest error path

Shuaisong Yang (4):
      net: hns3: unify copper port ksettings configuration path
      net: hns3: refactor MAC autoneg and speed configuration
      net: hns3: fix permanent link down deadlock after reset
      net: hns3: differentiate autoneg default values between copper and fiber

Shuangpeng Bai (2):
      nilfs2: fix backing_dev_info reference leak
      llc: fix SAP refcount leak in llc_ui_autobind()

Shuicheng Lin (3):
      drm/xe/userptr: Hold notifier_lock for write on inject test path
      drm/xe/hw_engine: Fix double-free of managed BO in error path
      drm/xe/userptr: Stub notifier_lock helpers when DRM_GPUSVM=n

Shuvam Pandey (3):
      PCI: meson: Propagate devm_add_action_or_reset() failure
      PCI: meson: Add missing remove callback
      PCI: dwc: Avoid dwc_pcie_rasdes_debugfs_deinit() NULL dereference when no RAS DES capability

Shyam Prasad N (1):
      cifs: invalidate cfid on unlink/rename/rmdir

Siddharth Nayyar (1):
      bpftool: Fix typo in struct_ops map FD generation for light skeleton

Siddharth Vadapalli (1):
      soc: ti: k3-ringacc: Fix access mode for k3_ringacc_ring_pop_tail_io/proxy

Siwei Zhang (1):
      Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()

Sneh Mankad (1):
      pinctrl: qcom: Fix resolving register base address from device node

Srinivas Kandagatla (2):
      ASoC: codecs: lpass-va-macro: add SM6115 compatible
      ASoC: qcom: q6apm: fix NULL pointer dereference in graph_callback

Srinivas Pandruvada (1):
      platform/x86: ISST: Restore SST-PP control to all domains

Srinivasan Shanmugam (2):
      drm/amdkfd: Validate CRIU-restored IDs before idr_alloc
      drm/amd/display: Add missing kdoc for ALLM parameters

Srujana Challa (2):
      vdpa/octeon_ep: Fix PF->VF mailbox data address calculation
      vdpa/octeon_ep: fix IRQ-to-ring mapping in interrupt handler

Stafford Horne (3):
      openrisc: mm: Fix section mismatch between map_page and __set_fixmap
      openrisc: Add full instruction cache invalidate functions
      openrisc: Fix jump_label smp syncing

Stanley Chu (1):
      i3c: master: svc: Fix missed IBI after false SLVSTART on NPCM845

Stefan Metzmacher (1):
      uaccess: fix ignored_trailing logic in copy_struct_to_user()

Stepan Ionichev (3):
      clk: scpi: Unregister child clock providers on remove
      device property: fix fwnode reference leak in fwnode_graph_get_endpoint_by_id()
      rtc: msc313: fix NULL deref in shared IRQ handler at probe

Stephan Gerhold (1):
      serial: msm: Disable DMA for kernel console UART

Stephen Smalley (1):
      selinux: check connect-related permissions on TCP Fast Open

Steven Rostedt (2):
      tracing/eprobes: Allow use of BTF names to dereference pointers
      ufs: core: tracing: Do not dereference pointers in TP_printk()

Stig Hornang (1):
      Bluetooth: L2CAP: fix tx ident leak for commands without a response

Subbaraya Sundeep (2):
      octeontx2-pf: Clear stats of all resources when freeing resources
      octeontx2-af: Validate NIX maximum LFs correctly

Sudeep Holla (1):
      firmware: arm_scmi: Read sensor config as 32-bit value

Suman Ghosh (1):
      octeontx2-pf: check DMAC extraction support before filtering

Sumanth Korikkar (1):
      s390/perf_cpum_cf: Add missing array_index_nospec() to __hw_perf_event_init()

Sumit Kumar (1):
      bus: mhi: ep: Fix potential deadlock in mhi_ep_reset_worker()

Sun Jian (1):
      bpf: Run generic devmap egress prog on private skb

Sungwoo Kim (1):
      Bluetooth: sco: Fix a race condition in sco_sock_timeout()

Sven Eckelmann (15):
      batman-adv: gw: acquire ethernet header only after skb realloc
      batman-adv: retrieve ethhdr after potential skb realloc on RX
      batman-adv: access unicast_ttvn skb->data only after skb realloc
      batman-adv: dat: acquire ARP hw source only after skb realloc
      batman-adv: bla: reacquire gw address after skb realloc
      batman-adv: dat: ensure accessible eth_hdr proto field
      batman-adv: ensure minimal ethernet header on TX
      batman-adv: dat: fix tie-break for candidate selection
      batman-adv: tt: avoid request storms during pending request
      batman-adv: fix VLAN priority offset
      batman-adv: frag: free unfragmentable packet
      batman-adv: clean untagged VLAN on netdev registration failure
      batman-adv: frag: fix primary_if leak on failed linearization
      batman-adv: mcast: avoid OOB read of num_dests header
      batman-adv: tt: prevent TVLV OOB check overflow

Sven Püschel (1):
      media: rockchip: rga: fix too small buffer size

Svyatoslav Ryhel (1):
      drm/tegra: gr2d/gr3d: Initialize address register map before HOST1X client is registered

TJ Adams (2):
      ata: libata-core: Skip HPA resize for locked drives
      ata: libata-core: Allow capacity transition to zero for locked drives

Takahiro Kuwano (1):
      mtd: spi-nor: spansion: use die erase for multi-die devices only

Takashi Iwai (3):
      ALSA: seq: oss: Fix UAF at handling events with embedded SysEx data
      ALSA: aloop: Drop superfluous break
      ALSA: core: Fix unintuitive behavior of snd_power_ref_and_wait()

Tamaki Yanagawa (1):
      netfilter: nft_lookup: fix catchall element handling with inverted lookups

Tao Cui (1):
      RDMA/counter: Fix incorrect port index in rdma_counter_init() error cleanup

Tao Liu (1):
      riscv: Prevent NULL pointer dereference in machine_kexec_prepare()

Tapio Reijonen (1):
      serial: max310x: implement gpio_chip::get_direction()

Tetsuo Handa (1):
      ocfs2: kill osb->system_file_mutex lock

Thadeu Lima de Souza Cascardo (1):
      drm/amdgpu: initialize irq.lock spinlock earlier

Thomas Gleixner (1):
      locking/rt: Fix the incorrect RCU protection in rt_spin_unlock()

Thomas Hellström (1):
      drm/xe: Fix wa_oob codegen recipe for external module builds

Thomas Huth (2):
      selftests/landlock: Skip scoped_signal subtest with MSG_OOB if not available
      selftests/landlock: Fix screwed up pointers in the scoped_signal_test

Thomas Richter (1):
      perf callchain: Handle multiple address spaces

Thomas Weißschuh (2):
      lib: kunit_iov_iter: repeatedly call alloc_pages_bulk()
      riscv: vdso: Do not use LTO for the vDSO

Thomas Zimmermann (1):
      drm/rockchip: Test for imported buffers with drm_gem_is_imported()

Thorsten Blum (6):
      crypto: ecrdsa - fix unknown OID check in ecrdsa_param_curve
      x86/boot: Validate console=uart8250 baud rate to fix early boot hang
      x86/boot: Reject too long acpi_rsdp= values
      tpm: fix event_size output in tpm1_binary_bios_measurements_show
      powerpc/pseries: fix memory leak on krealloc failure in papr_init
      crypto: atmel-sha204a - fail on hwrng registration error in probe path

Théo Lebrun (1):
      net: macb: drop in-flight Tx SKBs on close

Tiezhu Yang (2):
      LoongArch: BPF: Fix outdated tail call comments
      LoongArch: BPF: Fix off-by-one error in tail call

Timur Tabi (2):
      drm/nouveau/bios: specify correct display fuse register for Ampere and Ada
      regulator: core: regulator_lock_two() should test for EDEADLK not EDEADLOCK

Tomas Glozar (1):
      rtla/actions: Restore continue flag in actions_perform()

Tomi Valkeinen (1):
      drm/tidss: Drop extra drm_mode_config_reset() call

Tony Luck (1):
      fs/resctrl: Free mon_data structures on rdt_get_tree() failure

Tristan Madani (13):
      wifi: rtw88: fix OOB read from firmware RX descriptor exceeding DMA buffer
      wifi: rtw89: add bounds check on firmware mac_id in link lookup
      wifi: ath9k: fix OOB access from firmware tx status queue ID
      RDMA/rxe: Fix TOCTOU heap overflow in get_srq_wqe
      RDMA/rxe: Copy WQE to local buffer in non-SRQ receive path
      wifi: wcn36xx: fix heap overflow from oversized firmware HAL response
      wifi: wcn36xx: fix OOB read from firmware count in PRINT_REG_INFO indication
      wifi: wcn36xx: fix OOB read from short trigger BA firmware response
      selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
      ntfs3: fix out-of-bounds read in decompress_lznt
      ocfs2: use kzalloc for quota recovery bitmap allocation
      bpf: Reset register bounds before narrowing retval range in check_mem_access()
      hfs/hfsplus: fix u32 overflow in check_and_correct_requested_length

Tycho Andersen (AMD) (2):
      crypto: ccp - Reverse the cleanup order in psp_dev_destroy()
      crypto: ccp - Fix snp_filter_reserved_mem_regions() off-by-one

Tyler Baker (1):
      usb: gadget: f_fs: initialize reset_work at allocation time

Val Packett (1):
      ASoC: codecs: aw88261: fix incorrect masks for boost regs

Vasant Hegde (3):
      iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19
      iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19
      iommu/amd: Fix premature break in init_iommu_one()

Vasiliy Kovalev (1):
      net/9p: fix infinite loop in p9_client_rpc on fatal signal

Viacheslav Bocharov (1):
      pinctrl: meson: restore non-sleeping GPIO access

Viacheslav Dubeyko (1):
      hfs/hfsplus: prevent getting negative values of offset/length

Victor Nogueira (5):
      net/sched: sch_hfsc: Don't make class passive twice
      net/sched: sch_fq_codel: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
      net/sched: sch_codel: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
      net/sched: sch_dualpi2: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
      net/sched: sch_dualpi2: Add missing module alias

Vincent Jardin (2):
      i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)
      i2c: imx: fix locked bus on SMBus block-read of 0 (IRQ)

Vlad Poenaru (1):
      bpf: Allow LPM map access from sleepable BPF programs

Vladimir Zapolskiy (1):
      gpio: timberdale: Return -ENOMEM on dynamic memory allocation in probe

Wander Lairson Costa (1):
      rtla: Introduce for_each_action() helper

Wandun Chen (1):
      of: reserved_mem: avoid post-init UAF when alloc_reserved_mem_array() fails

Wang Jun (1):
      soc: fsl: qe: panic on ioremap() failure in qe_reset()

Wang Yan (2):
      selftests/net: fix EVP_MD_CTX leak in tcp_mmap
      time: Fix off-by-one in compat settimeofday() usec validation

Wasim Nazir (1):
      remoteproc: qcom: Fix leak when custom dump_segments addition fails

Wayen Yan (3):
      net: airoha: fix foe_check_time allocation size
      net: ethernet: mtk_ppe: Fix rhashtable leak in mtk_ppe_init error paths
      net: airoha: Fix skb->priority underflow in airoha_dev_select_queue()

Wayen.Yan (3):
      net: airoha: Fix register index for Tx-fwd counter configuration
      net: airoha: Fix debugfs new-tuple display for IPv4 ROUTE entries
      net: airoha: Fix always-true condition in PPE1 queue reservation loop

Wei Fang (1):
      net: enetc: check the number of BDs needed for xdp_frame

Wei Zhang (1):
      wifi: ath12k: fix NULL deref in change_sta_links for unready link

Weili Qian (1):
      crypto: hisilicon/qm - disable error report before flr

Weiming Shi (8):
      crypto: asymmetric_keys - fix OOB read in pefile_digest_pe_contents
      Bluetooth: eir: Fix stack OOB write when prepending the Flags AD
      bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()
      tipc: fix use-after-free of the discoverer in tipc_disc_rcv()
      ipv6: ndisc: fix NULL deref in accept_untracked_na()
      Bluetooth: bpa10x: avoid OOB read of revision string in bpa10x_setup()
      KVM: arm64: nv: Fix SPSR_EL2 restore in kvm_hyp_handle_mops()
      sctp: validate STALE_COOKIE cause length before reading staleness

Weixin Guo (1):
      arm64: dts: rockchip: fix rk809 interrupt pin on rk3566-roc-pc

Wen Gong (1):
      wifi: ath12k: enable IEEE80211_VHT_EXT_NSS_BW_CAPABLE when NSS ratio is reported

WenTao Liang (2):
      power: supply: charger-manager: fix refcount leak in is_full_charged()
      scsi: elx: efct: Fix refcount leak in efct_hw_io_abort()

Wenmeng Liu (1):
      media: qcom: camss: vfe: fix PIX subdev naming on VFE lite

Wentao Guan (1):
      net: ethernet: mtk_wed: debugfs: correct index in wed_amsdu_show()

Wentao Liang (7):
      mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()
      mlxsw: fix refcount leak in mlxsw_sp_vrs_lpm_tree_replace()
      xen/gntdev: fix error handling in ioctl
      nvmet: fix refcount leak in nvmet_sq_create()
      accel/amdxdna: Fix use-after-free in amdxdna_gem_dmabuf_mmap()
      ipmi: fix refcount leak in i_ipmi_request()
      ata: pata_pxa: Fix DMA channel leak on probe error

Werner Kasselman (2):
      drm/amdgpu: fix integer overflow in amdgpu_gem_align_pitch()
      drm/radeon: fix integer overflow in radeon_align_pitch()

William Hansen-Baird (1):
      staging: rtl8723bs: core: move constants to right side in comparison

Wolfram Sang (1):
      hwspinlock: qcom: avoid uninitialized struct members

Woojin Ji (1):
      bpftool: Use libbpf error code for flow dissector query

Wyatt Feng (5):
      rxrpc: Fix ACKALL packet handling
      netfilter: xt_u32: reject invalid shift counts
      netfilter: xt_connmark: reject invalid shift parameters
      netfilter: xt_cluster: reject template conntracks in hash match
      netfilter: xt_nat: reject unsupported target families

Xi Pardee (3):
      platform/x86:intel/pmc: Add support for multiple DMU GUIDs
      platform/x86:intel/pmc: Rename PMC index variable to pmc_idx
      platform/x86:intel/pmc: Relocate lpm_req_guid to pmc_reg_map

Xiang Mei (10):
      bridge: cfm: reject invalid CCM interval at configuration time
      virtio-net: fix len check in receive_big()
      drm/edid: fix OOB read in drm_parse_tiled_block()
      ipv6: Fix null-ptr-deref in fib6_nh_mtu_change().
      net, bpf: check master for NULL in xdp_master_redirect()
      usbnet: gl620a: fix out-of-bounds read in genelink_rx_fixup()
      net: usb: net1080: validate packet_len before pad-byte access in rx_fixup
      net: qualcomm: rmnet: validate MAP frame length before ingress parsing
      net/smc: fix UAF in smc_cdc_rx_handler() by pinning the socket
      netfilter: nf_conntrack_reasm: guard mac_header adjustment after IPv6 defrag

Xiang Mei (Microsoft) (1):
      netfilter: bridge: fix stale prevhdr pointer in br_ip6_fragment()

Xianwei Zhao (1):
      pinctrl: meson: amlogic-a4: fix gpio output glitch

Xiaolei Wang (1):
      media: nxp: imx8-isi: Fix use-after-free on remove

Xin Long (4):
      sctp: validate embedded address parameter length
      sctp: hold socket lock when dumping endpoints in sctp_diag
      sctp: add INIT verification after cookie unpacking
      sctp: fix addr_wq_timer race in sctp_free_addr_wq()

Xingjing Deng (1):
      kconfig: fix potential NULL pointer dereference in conf_askvalue

Xu Kuohai (1):
      bpf: Fix setting retval to -EPERM for cgroup hooks not returning errno

Xu Rao (5):
      ALSA: hda: Fix cached processing coefficient verbs
      thunderbolt: debugfs: Fix margining error counter buffer leak
      ALSA: usb-audio: qcom: Free sideband sg_table objects
      ACPI: IPMI: Fix inverted interface check in ipmi_bmc_gone()
      scsi: sg: Report request-table problems when any status is set

Xuanqiang Luo (2):
      i2c: mlxbf: Fix use-after-free in mlxbf_i2c_init_resource()
      llc: fix SAP refcount leak when creating incoming sockets

Xuewen Wang (1):
      LoongArch: Fix nr passing in set_direct_map_valid_noflush()

Yadan Fan (1):
      MIPS: mm: Fix out-of-bounds write in maar_res_walk()

Yanfei Xu (1):
      LoongArch: KVM: Validate irqchip index in irqfd routing

Yang Erkun (1):
      nfs: use nfsi->rwsem to protect traversal of the file lock list

Yang Wang (1):
      drm/amd/pm: remove trailing semicolon from AMDGPU_PM_POLICY_ATTR macro

Yichong Chen (1):
      bpftool: Fix vmlinux BTF leak in cgroup commands

Yicong Yang (1):
      ACPI: RIMT: Only defer the IOMMU configuration in init stage

Yihang Li (1):
      scsi: hisi_sas: Add slave_destroy interface for v3 hw

Yingchao Deng (1):
      coresight: cti: Fix DT filter signals silently ignored

Yingjie Gao (1):
      watchdog: sp5100_tco: Use EFCH MMIO for newer Hygon FCH

Yitang Yang (1):
      block: fix IORING_URING_CMD_REISSUE flags check in blkdev_uring_cmd

Yiyang Chen (4):
      HID: bpf: Fix hid_bpf_get_data() range check
      selftests/hid: Load only requested struct_ops maps
      selftests/hid: Cover hid_bpf_get_data() size overflow
      taskstats: retain dead thread stats in TGID queries

Yizhou Zhao (8):
      net/9p: fix race condition on rdma->state in trans_rdma.c
      ipvs: pass parsed transport offset to state handlers
      ipvs: use parsed transport offset in TCP state lookup
      ipvs: fix PMTU for GUE/GRE tunnel ICMP errors
      netfilter: nf_conncount: fix zone comparison in tuple dedup
      netfilter: ecache: fix inverted time_after() check
      ipvs: use parsed transport offset in SCTP state lookup
      ipvs: reset full ip_vs_seq structs in ip_vs_conn_new

Yong Wang (1):
      net: ife: require ETH_HLEN to be pullable in ife_decode()

Yonghong Song (1):
      selftests/bpf: Fix bpf_iter/task_vma test

Yousef Alhouseen (2):
      sctp: fix SCTP_RESET_STREAMS stream list length limit
      mac802154: remove interfaces with RCU list deletion

Yu Kuai (3):
      md: merge mddev has_superblock into mddev_flags
      md: merge mddev faillast_dev into mddev_flags
      md: merge mddev serialize_policy into mddev_flags

Yuanhe Shu (1):
      Revert "PCI/MSI: Unmap MSI-X region on error"

Yuho Choi (8):
      drm/radeon: fix memory leak in radeon_ring_restore() on lock failure
      media: atomisp: gc2235: fix UAF and memory leak
      ARM: imx3: Fix CCM node reference leak
      ARM: imx31: Fix IIM mapping leak in revision check
      ACPI: IPMI: Fix message kref handling on dead device
      watchdog: unregister PM notifier on watchdog unregister
      clk: at91: keep securam node alive while mapping it
      irqchip/gic-v3-its: Fix OF node reference leak

Yun Zhou (2):
      flow_dissector: check device type before reading ETH_ADDRS
      net: mvneta: re-enable percpu interrupt on resume

Yunxiang Li (2):
      drm/amdgpu: set sub_block_index for mca ras sub-blocks
      drm/amdkfd: Avoid double-unpin of DOORBELL/MMIO BOs on free

Yuyang Huang (4):
      bpf: fix BPF_PROG_QUERY OOB write and cgroup backward compat
      selftests/bpf: add verification for BPF_PROG_QUERY attr size boundaries
      ipv4: igmp: annotate data-races around im->users
      ipv4: igmp: annotate data-races around timer-related fields

Zenghui Yu (1):
      samples/damon/mtier: fail early if address range parameters are invalid

Zhan Xusheng (3):
      alarmtimer: Remove stale return description from alarm_handle_timer()
      fs/ntfs3: fix syncing wrong inode on DIRSYNC cross-directory rename
      posix-cpu-timers: Use u64 multiplication in update_rlimit_cpu()

Zhang Cen (4):
      ALSA: seq: midi: Serialize output teardown with event_input
      ocfs2: rebase copied fsdlm LVB pointers in locking_state
      ocfs2: reject FITRIM ranges shorter than a cluster
      ocfs2/dlm: require a ref for locking_state debugfs open

Zhang Heng (1):
      ALSA: hda: conexant: Remove mic bias threshold override

Zhang Lixu (1):
      iio: hid-sensor-rotation: Fix stale or zero output when reading raw values

Zhang Tianci (2):
      vduse: Requeue failed read to send_list head
      vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter

Zhang Yi (1):
      ext4: fix LOGFLUSH shutdown ordering to allow ordered-mode data writeback

Zhang Yuwei (1):
      driver core: Use mod_delayed_work to prevent lost deferred probe work

Zhao Dongdong (2):
      Bluetooth: btmtk: fix URB leak in alloc_mtk_intr_urb error path
      reset: sunxi: fix memory region leak on ioremap failure

Zhao Li (1):
      wifi: ieee80211: validate MLE common info length

ZhaoJinming (2):
      ice: dpll: set pointers to NULL after kfree in ice_dpll_deinit_info
      ice: dpll: fix memory leak in ice_dpll_init_info error paths

ZhengYuan Huang (1):
      ocfs2: don't BUG_ON an invalid journal dinode

Zhengchuan Liang (1):
      net: atm: reject out-of-range traffic classes in QoS validation

Zhi-Jun You (1):
      net: ethernet: mtk_wed: fix loading WO firmware for MT7986

Zhiling Zou (1):
      wifi: mac80211: free ack status frame on TX header build failure

Zhiping Zhang (1):
      net/mlx5: free mlx5_st_idx_data on final dealloc

Zhixing Chen (1):
      netfilter: ip6tables: mark malformed IPv6 extension headers for hotdrop

Zhongqiu Han (1):
      cpufreq: schedutil: Fix uncleared need_freq_update on the .adjust_perf() path

Zhu Yanjun (1):
      RDMA/rxe: Fix a use-after-free problem in rxe_mmap

Zi Yan (1):
      mm/compaction: handle free_pages_prepare() properly in compaction_free()

Zide Chen (1):
      perf/x86/intel/uncore: Fix discovery unit lookup for multi-die systems

Zihan Xi (1):
      net/sched: act_ct: preserve tc_skb_cb across defragmentation

Zijun Hu (1):
      Bluetooth: hci_qca: fix NULL pointer dereference in qca_dmp_hdr() for non-serdev device

Zilin Guan (2):
      media: atomisp: Fix memory leak in atomisp_fixed_pattern_table()
      afs: use kvfree() to free memory allocated by kvcalloc()

Zishun Yi (1):
      riscv: cacheinfo: Fix node reference leak in populate_cache_leaves

Zygmunt Krynicki (4):
      apparmor: aa_label_alloc use aa_label_free on alloc failure
      apparmor: fail policy unpack on accept2 allocation failure
      apparmor: aa_getprocattr free procattr leak on format failure
      apparmor: put secmark label after secid lookup

leixiang (1):
      KVM: x86: Nullify irqfd->producer if updating IRTE for bypass fails

liuxixin (1):
      nvme: fix FDP fdpcidx bounds check

longlong yan (1):
      tools/virtio: check mmap return value in vringh_test

zhoumin (1):
      EDAC/{skx_common,skx}: Fix UBSAN shift-out-of-bounds in skx_get_dimm_info

谢致邦 (XIE Zhibang) (1):
      LoongArch: Move struct kimage forward declaration before use

