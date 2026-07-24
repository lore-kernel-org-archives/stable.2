Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06A0441607;
	Fri, 24 Jul 2026 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905619; cv=none; b=NmcTiPUOhcA9/5bgDHSkkZ5wvHDFLfmrXnAplb7uDi0gVb6M3WdhM2uznXJoFPVegwgPlW0YGgv4nbBQvmAF1IqkFdWaThKhVYoIaRKjZNRcx+2DEGtJxZ3KhkAn9NjTLu1O/JGfuAVPye38LWyProQ4K7+5wZUv1Wys/NniX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905619; c=relaxed/simple;
	bh=KTLAZl57JF7uF35Skxt53mY4G3MZv5lfj/epEONfrAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LlFF1p4IA6LDqpz3NF4kpyPHdOI+tgHdJvIb5W+INhALOwGmCnkcpTxzBlo/STajo8k3mVCGzRT+PmSfsDgDd1Nue/GPHZBeJDO9SQqugCXJD1h5BZ0ciSFZJcmYmBi1hLkhV2lmDLRATeynk8oHRZuRD0n2vhNeE4iQnBeGY4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BZiu4uZT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BZiu4uZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5AD1F00A3F;
	Fri, 24 Jul 2026 15:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784905592;
	bh=P6tADinWDygu9OLnVvJL7XTfBDUTOckkO9Ydzq6/K+g=;
	h=From:To:Cc:Subject:Date;
	b=BZiu4uZTKNutcn64BcLll2oNeJcFKludSSyOiBHXn7ks/FcopLDuYuz//5h+NaAD2
	 t3yMM6yDOuDfj1D1AR1x8PvXW/Pyr+uI5Xl8mlpdrckXGyIj04/fpTARP7pIav3sZL
	 q3tm+1KsIwnrWyT/Qiw2vLYW9t/cxNLlzabTxt70=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.1.5
Date: Fri, 24 Jul 2026 17:06:02 +0200
Message-ID: <2026072403-stopper-outmost-be15@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.1.5 kernel.

All users of the 7.1 kernel series must upgrade.

The updated 7.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes                |   13 
 Documentation/admin-guide/pm/cpufreq.rst                                      |    6 
 Documentation/arch/arm64/cpu-hotplug.rst                                      |   28 
 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml               |   17 
 Documentation/devicetree/bindings/clock/qcom,x1e80100-camcc.yaml              |    1 
 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml            |   23 
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml                   |    5 
 Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml |   10 
 Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml          |    7 
 Documentation/devicetree/bindings/net/renesas,ether.yaml                      |    3 
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml         |   13 
 Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux-aon.yaml     |    4 
 Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux.yaml         |    4 
 Documentation/devicetree/bindings/pinctrl/realtek,rtd1625-pinctrl.yaml        |    2 
 Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml             |   43 
 Documentation/devicetree/bindings/timer/sifive,clint.yaml                     |   16 
 Documentation/devicetree/bindings/vendor-prefixes.yaml                        |    4 
 Documentation/driver-api/nvdimm/btt.rst                                       |    5 
 Documentation/driver-api/uio-howto.rst                                        |    4 
 Documentation/filesystems/proc.rst                                            |   14 
 Documentation/mm/memfd_preservation.rst                                       |    2 
 Documentation/netlink/specs/handshake.yaml                                    |    1 
 Documentation/netlink/specs/rt-link.yaml                                      |    6 
 Documentation/networking/bonding.rst                                          |   23 
 Documentation/process/changes.rst                                             |    7 
 Documentation/process/threat-model.rst                                        |    2 
 Documentation/trace/eprobetrace.rst                                           |    4 
 Documentation/trace/rv/monitor_sched.rst                                      |    7 
 Makefile                                                                      |    2 
 arch/alpha/kernel/pci-sysfs.c                                                 |   13 
 arch/arc/include/asm/uaccess.h                                                |    3 
 arch/arm/boot/compressed/Makefile                                             |    2 
 arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts                                |    2 
 arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts                             |    2 
 arch/arm/boot/dts/nvidia/tegra124-nyan.dtsi                                   |    5 
 arch/arm/boot/dts/nvidia/tegra124-venice2.dts                                 |    5 
 arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi                                 |    4 
 arch/arm/boot/dts/rockchip/rk3288-veyron.dtsi                                 |    5 
 arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts                                 |  128 +
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
 arch/arm/include/asm/uaccess.h                                                |    3 
 arch/arm/mach-imx/Kconfig                                                     |   21 
 arch/arm/mach-imx/cpu-imx31.c                                                 |    9 
 arch/arm/mach-imx/mm-imx3.c                                                   |    2 
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi                                |    3 
 arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a-mbls1028a.dtsi           |    4 
 arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts                        |    2 
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts                                 |    2 
 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts                           |   10 
 arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi                       |    7 
 arch/arm64/boot/dts/freescale/imx8mn-vhip4-evalboard-v1.dts                   |    2 
 arch/arm64/boot/dts/freescale/imx8mn-vhip4-evalboard-v2.dts                   |    2 
 arch/arm64/boot/dts/freescale/imx8mp-ab2.dts                                  |    2 
 arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts                     |   14 
 arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.dtsi                       |    7 
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts                   |    3 
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts                                 |    1 
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts                                 |    4 
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi                              |    4 
 arch/arm64/boot/dts/freescale/imx94.dtsi                                      |    2 
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts                             |    2 
 arch/arm64/boot/dts/freescale/imx95-verdin-ivy.dtsi                           |    1 
 arch/arm64/boot/dts/freescale/imx95.dtsi                                      |   10 
 arch/arm64/boot/dts/freescale/s32g3.dtsi                                      |    2 
 arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts            |    2 
 arch/arm64/boot/dts/mediatek/Makefile                                         |    8 
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-cn13.dtso            |   20 
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-cn14.dtso            |   20 
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro.dtsi                 |    2 
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi                              |    2 
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts                                |    5 
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts                                 |    5 
 arch/arm64/boot/dts/nvidia/tegra234.dtsi                                      |    8 
 arch/arm64/boot/dts/nvidia/tegra264.dtsi                                      |   88 -
 arch/arm64/boot/dts/qcom/eliza-mtp.dts                                        |    4 
 arch/arm64/boot/dts/qcom/eliza.dtsi                                           |    6 
 arch/arm64/boot/dts/qcom/glymur-crd.dts                                       |    4 
 arch/arm64/boot/dts/qcom/glymur.dtsi                                          |   12 
 arch/arm64/boot/dts/qcom/hamoa.dtsi                                           |   77 -
 arch/arm64/boot/dts/qcom/ipq5424.dtsi                                         |    4 
 arch/arm64/boot/dts/qcom/kaanapali.dtsi                                       |    6 
 arch/arm64/boot/dts/qcom/kodiak.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/lemans.dtsi                                          |  710 +++++-----
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts                              |    5 
 arch/arm64/boot/dts/qcom/milos.dtsi                                           |    2 
 arch/arm64/boot/dts/qcom/monaco.dtsi                                          |    6 
 arch/arm64/boot/dts/qcom/pmh0104-glymur.dtsi                                  |    2 
 arch/arm64/boot/dts/qcom/sc7180.dtsi                                          |    6 
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                                         |    2 
 arch/arm64/boot/dts/qcom/sdm630.dtsi                                          |   25 
 arch/arm64/boot/dts/qcom/sdm660.dtsi                                          |   36 
 arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso              |    5 
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi                           |    2 
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts                             |    2 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi                  |    2 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                                          |    6 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                                          |    6 
 arch/arm64/boot/dts/qcom/sm8750.dtsi                                          |    8 
 arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts                             |   76 +
 arch/arm64/boot/dts/renesas/r8a78000.dtsi                                     |   36 
 arch/arm64/boot/dts/rockchip/px30-cobra.dtsi                                  |    2 
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi                               |    2 
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi                                  |    5 
 arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts                                |    2 
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts                            |    6 
 arch/arm64/boot/dts/rockchip/rk3576.dtsi                                      |    6 
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi                                 |   12 
 arch/arm64/boot/dts/st/stm32mp251.dtsi                                        |    8 
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                                       |    2 
 arch/arm64/include/asm/kvm_nested.h                                           |    8 
 arch/arm64/include/asm/tlbbatch.h                                             |   10 
 arch/arm64/include/asm/tlbflush.h                                             |   49 
 arch/arm64/include/asm/uaccess.h                                              |    3 
 arch/arm64/kernel/acpi.c                                                      |    2 
 arch/arm64/kernel/entry-fpsimd.S                                              |    8 
 arch/arm64/kernel/fpsimd.c                                                    |   10 
 arch/arm64/kernel/hw_breakpoint.c                                             |    9 
 arch/arm64/kernel/process.c                                                   |   35 
 arch/arm64/kernel/smp.c                                                       |   28 
 arch/arm64/kernel/static_call.c                                               |    1 
 arch/arm64/kvm/at.c                                                           |    8 
 arch/arm64/kvm/emulate-nested.c                                               |    1 
 arch/arm64/kvm/hyp/include/hyp/switch.h                                       |   11 
 arch/arm64/kvm/hyp/pgtable.c                                                  |    3 
 arch/arm64/kvm/nested.c                                                       |  164 +-
 arch/arm64/kvm/pkvm.c                                                         |    2 
 arch/arm64/kvm/vgic/vgic-its.c                                                |    2 
 arch/arm64/kvm/vgic/vgic.c                                                    |   20 
 arch/arm64/mm/mmu.c                                                           |   11 
 arch/arm64/tools/sysreg                                                       |    2 
 arch/hexagon/include/asm/uaccess.h                                            |    3 
 arch/loongarch/include/asm/kexec.h                                            |    3 
 arch/loongarch/include/asm/pgtable.h                                          |    4 
 arch/loongarch/include/asm/uaccess.h                                          |    3 
 arch/loongarch/kvm/exit.c                                                     |    1 
 arch/loongarch/kvm/irqfd.c                                                    |    3 
 arch/loongarch/kvm/vcpu.c                                                     |   11 
 arch/loongarch/mm/pageattr.c                                                  |    2 
 arch/loongarch/net/bpf_jit.c                                                  |   28 
 arch/m68k/coldfire/m5441x.c                                                   |   18 
 arch/m68k/include/asm/uaccess.h                                               |    3 
 arch/microblaze/include/asm/uaccess.h                                         |    3 
 arch/mips/dec/int-handler.S                                                   |    2 
 arch/mips/dec/platform.c                                                      |    6 
 arch/mips/dec/prom/init.c                                                     |    6 
 arch/mips/dec/setup.c                                                         |    6 
 arch/mips/fw/lib/call_o32.S                                                   |    2 
 arch/mips/include/asm/dec/prom.h                                              |   15 
 arch/mips/include/asm/uaccess.h                                               |    3 
 arch/mips/kernel/mips-mt-fpaff.c                                              |   28 
 arch/mips/mm/init.c                                                           |   17 
 arch/mips/n64/init.c                                                          |    2 
 arch/mips/ralink/mt7621.c                                                     |    2 
 arch/mips/sgi-ip22/ip22-gio.c                                                 |    7 
 arch/nios2/include/asm/uaccess.h                                              |    3 
 arch/openrisc/include/asm/cacheflush.h                                        |    4 
 arch/openrisc/include/asm/uaccess.h                                           |    3 
 arch/openrisc/kernel/jump_label.c                                             |    2 
 arch/openrisc/kernel/patching.c                                               |    3 
 arch/openrisc/kernel/smp.c                                                    |   21 
 arch/openrisc/mm/cache.c                                                      |   16 
 arch/openrisc/mm/init.c                                                       |    2 
 arch/parisc/include/asm/uaccess.h                                             |    3 
 arch/powerpc/include/asm/uaccess.h                                            |    2 
 arch/powerpc/kernel/dt_cpu_ftrs.c                                             |    9 
 arch/powerpc/kexec/core_64.c                                                  |    4 
 arch/powerpc/perf/core-fsl-emb.c                                              |    3 
 arch/powerpc/platforms/8xx/cpm1.c                                             |   26 
 arch/powerpc/platforms/cell/spufs/file.c                                      |    6 
 arch/powerpc/platforms/powernv/setup.c                                        |    3 
 arch/powerpc/platforms/pseries/Kconfig                                        |    1 
 arch/powerpc/platforms/pseries/papr_platform_attributes.c                     |    8 
 arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts                           |   25 
 arch/riscv/boot/dts/microchip/mpfs.dtsi                                       |    6 
 arch/riscv/boot/dts/microchip/pic64gx-curiosity-kit.dts                       |   47 
 arch/riscv/boot/dts/microchip/pic64gx.dtsi                                    |   38 
 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi                                   |  236 +--
 arch/riscv/boot/dts/sophgo/sg2044-cpus.dtsi                                   |  236 +--
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts                               |    2 
 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts                             |    4 
 arch/riscv/boot/dts/spacemit/k1.dtsi                                          |    2 
 arch/riscv/boot/dts/spacemit/k3.dtsi                                          |    3 
 arch/riscv/include/asm/cpu_ops.h                                              |    2 
 arch/riscv/include/asm/vdso.h                                                 |   10 
 arch/riscv/kernel/alternative.c                                               |   14 
 arch/riscv/kernel/asm-offsets.c                                               |    4 
 arch/riscv/kernel/cacheinfo.c                                                 |    2 
 arch/riscv/kernel/cpu-hotplug.c                                               |    4 
 arch/riscv/kernel/cpu_ops_sbi.c                                               |   11 
 arch/riscv/kernel/entry.S                                                     |    8 
 arch/riscv/kernel/machine_kexec.c                                             |    3 
 arch/riscv/kernel/probes/rethook_trampoline.S                                 |    3 
 arch/riscv/kernel/stacktrace.c                                                |    2 
 arch/riscv/kernel/vdso/Makefile                                               |    6 
 arch/riscv/kernel/vdso/rt_sigreturn.S                                         |   10 
 arch/s390/include/asm/pgtable.h                                               |    4 
 arch/s390/include/asm/uaccess.h                                               |    3 
 arch/s390/kernel/diag/diag310.c                                               |    7 
 arch/s390/kernel/perf_cpum_cf.c                                               |    3 
 arch/s390/kernel/process.c                                                    |    2 
 arch/s390/kvm/dat.c                                                           |    2 
 arch/s390/kvm/gaccess.c                                                       |   73 -
 arch/s390/kvm/gmap.c                                                          |    7 
 arch/s390/kvm/gmap.h                                                          |   14 
 arch/s390/kvm/kvm-s390.c                                                      |    2 
 arch/s390/kvm/pci.c                                                           |   12 
 arch/s390/mm/gmap_helpers.c                                                   |    9 
 arch/s390/mm/mmap.c                                                           |    2 
 arch/sh/include/asm/uaccess.h                                                 |    3 
 arch/sparc/include/asm/page_32.h                                              |    2 
 arch/sparc/include/asm/uaccess_32.h                                           |    3 
 arch/sparc/include/asm/uaccess_64.h                                           |    3 
 arch/sparc/kernel/led.c                                                       |    2 
 arch/um/include/asm/uaccess.h                                                 |    3 
 arch/x86/Kconfig.cpu                                                          |    8 
 arch/x86/boot/compressed/acpi.c                                               |    7 
 arch/x86/boot/early_serial_console.c                                          |   11 
 arch/x86/events/amd/brs.c                                                     |   10 
 arch/x86/events/amd/core.c                                                    |   18 
 arch/x86/events/amd/lbr.c                                                     |    3 
 arch/x86/events/amd/uncore.c                                                  |    6 
 arch/x86/events/intel/uncore_discovery.c                                      |    4 
 arch/x86/events/intel/uncore_snbep.c                                          |    6 
 arch/x86/include/asm/bug.h                                                    |    2 
 arch/x86/kernel/cpu/cpu.h                                                     |    1 
 arch/x86/kernel/uprobes.c                                                     |   26 
 arch/x86/kvm/irq.c                                                            |    4 
 arch/x86/kvm/lapic.c                                                          |    8 
 arch/x86/kvm/svm/sev.c                                                        |    6 
 arch/x86/kvm/vmx/nested.c                                                     |   68 
 arch/x86/kvm/vmx/tdx.c                                                        |    6 
 arch/x86/platform/olpc/olpc-xo15-sci.c                                        |    1 
 arch/x86/video/video-common.c                                                 |   23 
 arch/x86/virt/svm/sev.c                                                       |    2 
 arch/xtensa/include/asm/uaccess.h                                             |    3 
 block/blk.h                                                                   |   13 
 block/genhd.c                                                                 |    4 
 block/ioctl.c                                                                 |    2 
 crypto/Kconfig                                                                |    4 
 crypto/af_alg.c                                                               |    2 
 crypto/algif_skcipher.c                                                       |   75 -
 crypto/asymmetric_keys/verify_pefile.c                                        |    2 
 crypto/ecrdsa.c                                                               |    2 
 crypto/rng.c                                                                  |   11 
 drivers/accel/amdxdna/Makefile                                                |    1 
 drivers/accel/amdxdna/aie.c                                                   |   89 +
 drivers/accel/amdxdna/aie.h                                                   |   31 
 drivers/accel/amdxdna/aie2_ctx.c                                              |   26 
 drivers/accel/amdxdna/aie2_error.c                                            |   17 
 drivers/accel/amdxdna/aie2_message.c                                          |  164 --
 drivers/accel/amdxdna/aie2_msg_priv.h                                         |    2 
 drivers/accel/amdxdna/aie2_pci.c                                              |  166 --
 drivers/accel/amdxdna/aie2_pci.h                                              |   26 
 drivers/accel/amdxdna/aie2_pm.c                                               |    6 
 drivers/accel/amdxdna/aie2_smu.c                                              |   22 
 drivers/accel/amdxdna/amdxdna_ctx.c                                           |   40 
 drivers/accel/amdxdna/amdxdna_gem.c                                           |   37 
 drivers/accel/amdxdna/amdxdna_gem.h                                           |    1 
 drivers/accel/amdxdna/amdxdna_iommu.c                                         |   56 
 drivers/accel/amdxdna/amdxdna_mailbox.c                                       |   10 
 drivers/accel/amdxdna/amdxdna_pci_drv.h                                       |    8 
 drivers/accel/amdxdna/amdxdna_ubuf.c                                          |   12 
 drivers/accel/amdxdna/npu1_regs.c                                             |    4 
 drivers/accel/amdxdna/npu4_regs.c                                             |    4 
 drivers/accel/amdxdna/npu5_regs.c                                             |    2 
 drivers/accel/amdxdna/npu6_regs.c                                             |    2 
 drivers/accel/ivpu/ivpu_fw_log.c                                              |    4 
 drivers/accel/ivpu/ivpu_job.c                                                 |   10 
 drivers/acpi/acpi_ipmi.c                                                      |    4 
 drivers/acpi/acpi_pad.c                                                       |    6 
 drivers/acpi/acpi_tad.c                                                       |    2 
 drivers/acpi/acpica/acutils.h                                                 |    2 
 drivers/acpi/acpica/utnonansi.c                                               |    7 
 drivers/acpi/button.c                                                         |   26 
 drivers/acpi/processor_idle.c                                                 |   13 
 drivers/acpi/resource.c                                                       |    6 
 drivers/acpi/riscv/cpuidle.c                                                  |    2 
 drivers/acpi/riscv/rimt.c                                                     |    7 
 drivers/amba/bus.c                                                            |   37 
 drivers/android/binder.c                                                      |   18 
 drivers/ata/libata-core.c                                                     |   44 
 drivers/ata/libata-scsi.c                                                     |    9 
 drivers/ata/libata.h                                                          |    9 
 drivers/ata/pata_pxa.c                                                        |    1 
 drivers/ata/sata_gemini.c                                                     |    2 
 drivers/base/core.c                                                           |   83 +
 drivers/base/dd.c                                                             |    7 
 drivers/base/firmware_loader/main.c                                           |   71 -
 drivers/base/power/main.c                                                     |    6 
 drivers/base/property.c                                                       |    4 
 drivers/base/regmap/regcache.c                                                |    2 
 drivers/base/regmap/regmap-i2c.c                                              |    2 
 drivers/block/drbd/drbd_receiver.c                                            |    5 
 drivers/bluetooth/Kconfig                                                     |    2 
 drivers/bluetooth/bpa10x.c                                                    |    8 
 drivers/bluetooth/btintel.c                                                   |   10 
 drivers/bluetooth/btintel.h                                                   |    9 
 drivers/bluetooth/btintel_pcie.c                                              |  531 ++++++-
 drivers/bluetooth/btintel_pcie.h                                              |   26 
 drivers/bluetooth/btmtk.c                                                     |    4 
 drivers/bluetooth/btrtl.c                                                     |    5 
 drivers/bluetooth/hci_qca.c                                                   |   11 
 drivers/bluetooth/hci_vhci.c                                                  |   10 
 drivers/bus/imx-weim.c                                                        |    6 
 drivers/bus/mhi/ep/main.c                                                     |   11 
 drivers/bus/mhi/host/pci_generic.c                                            |   20 
 drivers/bus/sunxi-rsb.c                                                       |    3 
 drivers/cdx/cdx.c                                                             |   40 
 drivers/char/hpet.c                                                           |    6 
 drivers/char/ipmi/ipmi_msghandler.c                                           |   10 
 drivers/char/sonypi.c                                                         |    6 
 drivers/char/tlclk.c                                                          |    4 
 drivers/char/tpm/eventlog/tpm1.c                                              |    4 
 drivers/char/tpm/tpm-dev.c                                                    |    2 
 drivers/char/tpm/tpm2-cmd.c                                                   |    6 
 drivers/char/tpm/tpm2-sessions.c                                              |   45 
 drivers/char/tpm/tpm_crb.c                                                    |    6 
 drivers/char/tpm/tpm_tis_core.c                                               |   35 
 drivers/char/tpm/tpmrm-dev.c                                                  |    2 
 drivers/char/virtio_console.c                                                 |   52 
 drivers/clk/at91/pmc.c                                                        |    2 
 drivers/clk/at91/sam9x7.c                                                     |   18 
 drivers/clk/clk-scmi.c                                                        |    4 
 drivers/clk/clk-scpi.c                                                        |    2 
 drivers/clk/microchip/clk-mpfs-ccc.c                                          |   15 
 drivers/clk/qcom/a53-pll.c                                                    |    2 
 drivers/clk/qcom/camcc-x1e80100.c                                             |   64 
 drivers/clk/qcom/ipq-cmn-pll.c                                                |   11 
 drivers/clk/renesas/rzg2l-cpg.c                                               |    6 
 drivers/clk/samsung/Kconfig                                                   |    2 
 drivers/clk/spacemit/ccu-k3.c                                                 |   20 
 drivers/clocksource/Kconfig                                                   |   31 
 drivers/clocksource/timer-sun5i.c                                             |    3 
 drivers/cpufreq/cpufreq_conservative.c                                        |   12 
 drivers/cpufreq/cpufreq_governor.c                                            |   42 
 drivers/cpufreq/intel_pstate.c                                                |    6 
 drivers/cpuidle/driver.c                                                      |    8 
 drivers/crypto/Kconfig                                                        |    1 
 drivers/crypto/allwinner/Kconfig                                              |    8 
 drivers/crypto/allwinner/sun4i-ss/Makefile                                    |    1 
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c                             |   36 
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-prng.c                             |   69 
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h                                  |   20 
 drivers/crypto/atmel-sha204a.c                                                |    8 
 drivers/crypto/cavium/cpt/cptvf_reqmanager.c                                  |    4 
 drivers/crypto/ccp/psp-dev.c                                                  |    8 
 drivers/crypto/ccp/sev-dev-tsm.c                                              |   23 
 drivers/crypto/ccp/sev-dev.c                                                  |   26 
 drivers/crypto/hisilicon/qm.c                                                 |    4 
 drivers/crypto/inside-secure/eip93/eip93-main.c                               |    2 
 drivers/crypto/inside-secure/eip93/eip93-regs.h                               |    2 
 drivers/crypto/inside-secure/safexcel.c                                       |    2 
 drivers/crypto/intel/qat/qat_common/adf_common_drv.h                          |    1 
 drivers/crypto/intel/qat/qat_common/adf_heartbeat_inject.c                    |    6 
 drivers/crypto/intel/qat/qat_common/adf_hw_arbiter.c                          |   25 
 drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c                            |    4 
 drivers/crypto/tegra/tegra-se-aes.c                                           |   33 
 drivers/crypto/xilinx/xilinx-trng.c                                           |   85 -
 drivers/cxl/core/core.h                                                       |    2 
 drivers/cxl/core/features.c                                                   |    2 
 drivers/cxl/core/memdev.c                                                     |    4 
 drivers/cxl/core/pci.c                                                        |   26 
 drivers/cxl/core/port.c                                                       |    7 
 drivers/cxl/core/ras.c                                                        |   27 
 drivers/cxl/core/region.c                                                     |  125 +
 drivers/cxl/core/trace.h                                                      |   24 
 drivers/cxl/cxl.h                                                             |   22 
 drivers/dax/kmem.c                                                            |    6 
 drivers/dibs/dibs_loopback.c                                                  |    5 
 drivers/dma-buf/dma-fence-unwrap.c                                            |    3 
 drivers/dma-buf/dma-fence.c                                                   |    9 
 drivers/dma/dma-axi-dmac.c                                                    |   68 
 drivers/dma/dmaengine.c                                                       |    3 
 drivers/dma/dw-edma/dw-edma-core.h                                            |    2 
 drivers/dma/dw-edma/dw-edma-pcie.c                                            |    3 
 drivers/dma/dw-edma/dw-edma-v0-core.c                                         |    6 
 drivers/dma/imx-sdma.c                                                        |    4 
 drivers/dma/qcom/gpi.c                                                        |    1 
 drivers/dma/sh/rz-dmac.c                                                      |   92 -
 drivers/dma/tegra186-gpc-dma.c                                                |    7 
 drivers/dpll/dpll_core.c                                                      |   20 
 drivers/edac/igen6_edac.c                                                     |  379 ++++-
 drivers/edac/skx_common.c                                                     |    3 
 drivers/firmware/arm_ffa/driver.c                                             |   27 
 drivers/firmware/arm_scmi/power.c                                             |    6 
 drivers/firmware/arm_scmi/sensors.c                                           |    2 
 drivers/firmware/samsung/exynos-acpm.c                                        |   23 
 drivers/firmware/smccc/soc_id.c                                               |    2 
 drivers/firmware/xilinx/zynqmp.c                                              |   28 
 drivers/fpga/dfl.c                                                            |    2 
 drivers/fpga/microchip-spi.c                                                  |    3 
 drivers/gpib/common/gpib_os.c                                                 |    4 
 drivers/gpio/gpio-davinci.c                                                   |    4 
 drivers/gpio/gpio-dwapb.c                                                     |   79 -
 drivers/gpio/gpio-f7188x.c                                                    |    6 
 drivers/gpio/gpio-htc-egpio.c                                                 |    6 
 drivers/gpio/gpio-mlxbf3.c                                                    |    3 
 drivers/gpio/gpio-mt7621.c                                                    |  283 +++
 drivers/gpio/gpio-mvebu.c                                                     |    6 
 drivers/gpio/gpio-palmas.c                                                    |   19 
 drivers/gpio/gpio-shared-proxy.c                                              |  136 -
 drivers/gpio/gpio-tegra.c                                                     |   18 
 drivers/gpio/gpio-timberdale.c                                                |    2 
 drivers/gpio/gpiolib-acpi-core.c                                              |   19 
 drivers/gpio/gpiolib-shared.c                                                 |    9 
 drivers/gpio/gpiolib-shared.h                                                 |   31 
 drivers/gpio/gpiolib.c                                                        |    2 
 drivers/gpu/buddy.c                                                           |   63 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                              |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c                              |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                    |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                                       |   25 
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c                                       |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c                                       |    3 
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c                                        |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                      |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                         |   20 
 drivers/gpu/drm/amd/amdkfd/kfd_events.c                                       |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c                            |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                                      |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                          |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                             |   10 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c                     |   13 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                      |   81 -
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c                               |    2 
 drivers/gpu/drm/amd/display/dc/dc.h                                           |   58 
 drivers/gpu/drm/amd/display/dc/dc_types.h                                     |   24 
 drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c                      |  201 --
 drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h                      |   23 
 drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c                        |   78 -
 drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h                        |   10 
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c                     |  389 +++--
 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c                       |  499 ++++++-
 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h                       |    9 
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h                                  |   35 
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h                                   |   79 -
 drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c                        |  177 +-
 drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h                        |   25 
 drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c                          |  388 +++++
 drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h                          |   49 
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c                |    1 
 drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c                 |    2 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                                            |   26 
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c                            |    4 
 drivers/gpu/drm/drm_edid.c                                                    |    8 
 drivers/gpu/drm/drm_fb_helper.c                                               |   92 +
 drivers/gpu/drm/drm_gpusvm.c                                                  |    5 
 drivers/gpu/drm/drm_gpuvm.c                                                   |    9 
 drivers/gpu/drm/drm_ioctl.c                                                   |   14 
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
 drivers/gpu/drm/i915/display/intel_lt_phy.c                                   |    6 
 drivers/gpu/drm/imagination/pvr_drv.c                                         |    6 
 drivers/gpu/drm/imagination/pvr_fw_trace.c                                    |    2 
 drivers/gpu/drm/imagination/pvr_vm.c                                          |    6 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                         |    7 
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c                                         |   15 
 drivers/gpu/drm/msm/dp/dp_display.c                                           |    4 
 drivers/gpu/drm/msm/dp/dp_reg.h                                               |    4 
 drivers/gpu/drm/msm/msm_mdss.c                                                |  115 -
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowramin.c                        |    3 
 drivers/gpu/drm/panel/Kconfig                                                 |   13 
 drivers/gpu/drm/panthor/panthor_device.c                                      |    9 
 drivers/gpu/drm/panthor/panthor_device.h                                      |  100 -
 drivers/gpu/drm/panthor/panthor_drv.c                                         |    8 
 drivers/gpu/drm/panthor/panthor_fw.c                                          |   29 
 drivers/gpu/drm/panthor/panthor_fw_regs.h                                     |   32 
 drivers/gpu/drm/panthor/panthor_gpu.c                                         |   50 
 drivers/gpu/drm/panthor/panthor_gpu_regs.h                                    |  123 +
 drivers/gpu/drm/panthor/panthor_heap.c                                        |    2 
 drivers/gpu/drm/panthor/panthor_hw.c                                          |   50 
 drivers/gpu/drm/panthor/panthor_hw.h                                          |    2 
 drivers/gpu/drm/panthor/panthor_mmu.c                                         |   37 
 drivers/gpu/drm/panthor/panthor_mmu_regs.h                                    |   73 +
 drivers/gpu/drm/panthor/panthor_pwr.c                                         |   73 -
 drivers/gpu/drm/panthor/panthor_pwr_regs.h                                    |   83 +
 drivers/gpu/drm/panthor/panthor_regs.h                                        |  291 ----
 drivers/gpu/drm/panthor/panthor_sched.c                                       |  111 -
 drivers/gpu/drm/radeon/radeon_gem.c                                           |   13 
 drivers/gpu/drm/radeon/radeon_ring.c                                          |    4 
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c                                |   12 
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c                                     |    7 
 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c                                 |    3 
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c                                   |    2 
 drivers/gpu/drm/tegra/dc.c                                                    |    4 
 drivers/gpu/drm/tegra/fbdev.c                                                 |    1 
 drivers/gpu/drm/tegra/gem.c                                                   |   22 
 drivers/gpu/drm/tegra/gr2d.c                                                  |   19 
 drivers/gpu/drm/tegra/gr3d.c                                                  |   19 
 drivers/gpu/drm/tegra/submit.c                                                |    3 
 drivers/gpu/drm/tidss/tidss_kms.c                                             |    2 
 drivers/gpu/drm/v3d/v3d_submit.c                                              |    2 
 drivers/gpu/drm/verisilicon/vs_primary_plane.c                                |   10 
 drivers/gpu/drm/xe/Makefile                                                   |    4 
 drivers/gpu/drm/xe/tests/xe_pci.c                                             |    1 
 drivers/gpu/drm/xe/xe_drm_client.c                                            |   12 
 drivers/gpu/drm/xe/xe_guc_relay.c                                             |   13 
 drivers/gpu/drm/xe/xe_hw_engine.c                                             |    4 
 drivers/gpu/drm/xe/xe_pt.c                                                    |   72 -
 drivers/gpu/drm/xe/xe_svm.h                                                   |   15 
 drivers/gpu/drm/xe/xe_userptr.c                                               |    2 
 drivers/gpu/drm/xe/xe_vm_madvise.c                                            |    2 
 drivers/gpu/host1x/bus.c                                                      |   62 
 drivers/gpu/host1x/job.c                                                      |   10 
 drivers/gpu/host1x/mipi.c                                                     |    6 
 drivers/hid/bpf/hid_bpf_dispatch.c                                            |    5 
 drivers/hid/hid-core.c                                                        |    7 
 drivers/hid/hid-logitech-hidpp.c                                              |    1 
 drivers/hid/hid-picolcd_core.c                                                |    3 
 drivers/hid/hid-wiimote-modules.c                                             |   58 
 drivers/hv/mshv_synic.c                                                       |    5 
 drivers/hv/vmbus_drv.c                                                        |   43 
 drivers/hwmon/Kconfig                                                         |    3 
 drivers/hwmon/aspeed-g6-pwm-tach.c                                            |    5 
 drivers/hwmon/asus_atk0110.c                                                  |    3 
 drivers/hwmon/gpd-fan.c                                                       |  224 +--
 drivers/hwmon/it87.c                                                          |    3 
 drivers/hwmon/occ/common.c                                                    |   34 
 drivers/hwmon/occ/common.h                                                    |    1 
 drivers/hwmon/pmbus/adm1275.c                                                 |    2 
 drivers/hwmon/pmbus/pmbus_core.c                                              |   37 
 drivers/hwmon/w83627hf.c                                                      |    4 
 drivers/hwmon/w83793.c                                                        |    1 
 drivers/hwspinlock/qcom_hwspinlock.c                                          |    5 
 drivers/hwtracing/coresight/coresight-core.c                                  |   34 
 drivers/hwtracing/coresight/coresight-cti-platform.c                          |    1 
 drivers/hwtracing/coresight/coresight-etm-perf.c                              |    5 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                            |   52 
 drivers/hwtracing/coresight/coresight-platform.c                              |   12 
 drivers/hwtracing/coresight/coresight-priv.h                                  |    2 
 drivers/hwtracing/coresight/coresight-sysfs.c                                 |    8 
 drivers/hwtracing/coresight/coresight-tmc-etr.c                               |    4 
 drivers/i2c/busses/i2c-imx.c                                                  |   36 
 drivers/i2c/busses/i2c-k1.c                                                   |    2 
 drivers/i2c/busses/i2c-mlxbf.c                                                |    4 
 drivers/i2c/busses/i2c-mt65xx.c                                               |    2 
 drivers/i2c/i2c-core-of.c                                                     |    5 
 drivers/i3c/master.c                                                          |  143 +-
 drivers/i3c/master/dw-i3c-master.c                                            |   15 
 drivers/i3c/master/dw-i3c-master.h                                            |    2 
 drivers/i3c/master/i3c-master-cdns.c                                          |   14 
 drivers/i3c/master/mipi-i3c-hci/core.c                                        |   48 
 drivers/i3c/master/mipi-i3c-hci/dma.c                                         |    9 
 drivers/i3c/master/mipi-i3c-hci/hci.h                                         |    1 
 drivers/i3c/master/mipi-i3c-hci/ibi.h                                         |   13 
 drivers/i3c/master/mipi-i3c-hci/pio.c                                         |    7 
 drivers/i3c/master/svc-i3c-master.c                                           |   30 
 drivers/iio/accel/mma8452.c                                                   |    2 
 drivers/iio/adc/xilinx-ams.c                                                  |    5 
 drivers/iio/dac/mcp47feb02.c                                                  |   37 
 drivers/iio/light/acpi-als.c                                                  |    6 
 drivers/iio/light/si1133.c                                                    |   14 
 drivers/iio/light/tcs3472.c                                                   |   38 
 drivers/iio/magnetometer/ak8975.c                                             |   14 
 drivers/iio/orientation/hid-sensor-rotation.c                                 |   40 
 drivers/infiniband/core/cm.c                                                  |   13 
 drivers/infiniband/core/counters.c                                            |    2 
 drivers/infiniband/core/frmr_pools.c                                          |  104 +
 drivers/infiniband/core/nldev.c                                               |   15 
 drivers/infiniband/core/restrack.c                                            |   49 
 drivers/infiniband/core/restrack.h                                            |    1 
 drivers/infiniband/core/uverbs_cmd.c                                          |   10 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                      |  217 ++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h                                      |    5 
 drivers/infiniband/hw/bnxt_re/main.c                                          |    2 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                                     |   11 
 drivers/infiniband/hw/bnxt_re/qplib_sp.h                                      |    1 
 drivers/infiniband/hw/bnxt_re/uapi.c                                          |   83 +
 drivers/infiniband/hw/hfi1/init.c                                             |   13 
 drivers/infiniband/hw/hns/hns_roce_cq.c                                       |    6 
 drivers/infiniband/hw/hns/hns_roce_debugfs.c                                  |   19 
 drivers/infiniband/hw/hns/hns_roce_hem.c                                      |    8 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                    |   20 
 drivers/infiniband/hw/hns/hns_roce_main.c                                     |    2 
 drivers/infiniband/hw/hns/hns_roce_mr.c                                       |    6 
 drivers/infiniband/hw/hns/hns_roce_srq.c                                      |    2 
 drivers/infiniband/hw/irdma/hw.c                                              |    7 
 drivers/infiniband/hw/irdma/main.h                                            |    3 
 drivers/infiniband/hw/irdma/utils.c                                           |   12 
 drivers/infiniband/hw/irdma/verbs.c                                           |   19 
 drivers/infiniband/hw/irdma/verbs.h                                           |    1 
 drivers/infiniband/hw/mana/main.c                                             |    3 
 drivers/infiniband/hw/mlx4/mlx4_ib.h                                          |    1 
 drivers/infiniband/hw/mlx4/mr.c                                               |    9 
 drivers/infiniband/hw/mlx4/sysfs.c                                            |   45 
 drivers/infiniband/hw/mlx5/devx.c                                             |   30 
 drivers/infiniband/hw/mlx5/main.c                                             |   17 
 drivers/infiniband/hw/mlx5/mlx5_ib.h                                          |    9 
 drivers/infiniband/hw/mlx5/mr.c                                               |   60 
 drivers/infiniband/hw/mlx5/odp.c                                              |   12 
 drivers/infiniband/hw/mlx5/qp.c                                               |   13 
 drivers/infiniband/hw/mlx5/restrack.c                                         |    3 
 drivers/infiniband/hw/mlx5/umr.c                                              |   93 -
 drivers/infiniband/hw/mlx5/umr.h                                              |    9 
 drivers/infiniband/sw/rxe/rxe_mmap.c                                          |   19 
 drivers/infiniband/sw/rxe/rxe_net.c                                           |    6 
 drivers/infiniband/sw/rxe/rxe_ns.c                                            |    4 
 drivers/infiniband/sw/rxe/rxe_resp.c                                          |   33 
 drivers/infiniband/sw/siw/siw_cm.c                                            |   30 
 drivers/infiniband/ulp/srpt/ib_srpt.c                                         |    5 
 drivers/input/misc/ims-pcu.c                                                  |  131 +
 drivers/iommu/amd/amd_iommu_types.h                                           |   11 
 drivers/iommu/amd/init.c                                                      |    7 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                                    |    2 
 drivers/iommu/dma-iommu.c                                                     |    2 
 drivers/iommu/intel/iommu.c                                                   |    6 
 drivers/iommu/intel/pasid.c                                                   |    4 
 drivers/iommu/iommufd/pages.c                                                 |   10 
 drivers/irqchip/exynos-combiner.c                                             |    4 
 drivers/irqchip/irq-crossbar.c                                                |   10 
 drivers/irqchip/irq-gic-v3-its.c                                              |    6 
 drivers/irqchip/irq-riscv-imsic-early.c                                       |   15 
 drivers/irqchip/irq-ts4800.c                                                  |   10 
 drivers/leds/uleds.c                                                          |    3 
 drivers/mailbox/imx-mailbox.c                                                 |    3 
 drivers/mailbox/mailbox-mpfs.c                                                |    2 
 drivers/mailbox/mailbox.c                                                     |   26 
 drivers/mailbox/mtk-adsp-mailbox.c                                            |    9 
 drivers/md/dm-bufio.c                                                         |    4 
 drivers/md/dm-era-target.c                                                    |   10 
 drivers/md/dm-integrity.c                                                     |   12 
 drivers/md/dm-ioctl.c                                                         |    4 
 drivers/md/dm-log.c                                                           |    3 
 drivers/md/dm-pcache/dm_pcache.c                                              |    8 
 drivers/md/dm-stats.c                                                         |   10 
 drivers/md/dm-thin-metadata.c                                                 |   67 
 drivers/md/dm-verity-fec.c                                                    |    4 
 drivers/md/dm-verity-fec.h                                                    |    2 
 drivers/md/dm-verity-loadpin.c                                                |    2 
 drivers/md/dm-verity-target.c                                                 |   16 
 drivers/md/dm-verity.h                                                        |    2 
 drivers/md/dm.c                                                               |   24 
 drivers/md/md-bitmap.c                                                        |    9 
 drivers/md/md-bitmap.h                                                        |    2 
 drivers/md/md-llbitmap.c                                                      |   13 
 drivers/md/md.c                                                               |   27 
 drivers/md/md.h                                                               |    5 
 drivers/md/raid1.c                                                            |   54 
 drivers/md/raid10.c                                                           |   57 
 drivers/md/raid5.c                                                            |   55 
 drivers/media/platform/qcom/camss/camss-vfe.c                                 |    2 
 drivers/media/platform/qcom/iris/iris_platform_gen1.c                         |    2 
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
 drivers/media/platform/synopsys/dw-mipi-csi2rx.c                              |   15 
 drivers/media/usb/uvc/uvc_status.c                                            |   28 
 drivers/media/usb/uvc/uvc_video.c                                             |  179 +-
 drivers/media/v4l2-core/v4l2-common.c                                         |    1 
 drivers/memory/tegra/mc.c                                                     |   14 
 drivers/memory/tegra/tegra186-emc.c                                           |    4 
 drivers/memstick/core/ms_block.c                                              |    4 
 drivers/mfd/cs42l43.c                                                         |    2 
 drivers/mfd/rsmu_i2c.c                                                        |    6 
 drivers/mfd/rsmu_spi.c                                                        |    5 
 drivers/mfd/sm501.c                                                           |    4 
 drivers/mfd/tps6586x.c                                                        |    2 
 drivers/mmc/core/block.c                                                      |    3 
 drivers/mmc/core/mmc_test.c                                                   |   18 
 drivers/mmc/host/sdhci-esdhc-imx.c                                            |   91 -
 drivers/mmc/host/sdhci-of-dwcmshc.c                                           |   14 
 drivers/mmc/host/vub300.c                                                     |   36 
 drivers/mtd/devices/mchp23k256.c                                              |    2 
 drivers/mtd/devices/slram.c                                                   |   22 
 drivers/mtd/maps/vmu-flash.c                                                  |    7 
 drivers/mtd/mtd_virt_concat.c                                                 |    4 
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
 drivers/net/amt.c                                                             |   10 
 drivers/net/bareudp.c                                                         |    4 
 drivers/net/bonding/bond_3ad.c                                                |   27 
 drivers/net/bonding/bond_main.c                                               |    1 
 drivers/net/bonding/bond_netlink.c                                            |   16 
 drivers/net/bonding/bond_options.c                                            |   27 
 drivers/net/can/usb/esd_usb.c                                                 |    5 
 drivers/net/dsa/mxl862xx/mxl862xx-host.c                                      |   18 
 drivers/net/dsa/qca/qca8k-leds.c                                              |    3 
 drivers/net/dsa/realtek/rtl8366rb-leds.c                                      |    8 
 drivers/net/dsa/sja1105/sja1105_ptp.c                                         |    2 
 drivers/net/ethernet/airoha/airoha_eth.c                                      |    6 
 drivers/net/ethernet/airoha/airoha_ppe.c                                      |    9 
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c                              |    2 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                                  |   23 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c                               |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                     |   58 
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                                     |    6 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                             |    1 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                                |   23 
 drivers/net/ethernet/cadence/macb_main.c                                      |   29 
 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c                       |   18 
 drivers/net/ethernet/cavium/liquidio/lio_main.c                               |   27 
 drivers/net/ethernet/cavium/liquidio/octeon_device.h                          |    3 
 drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c                         |   33 
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c                                    |    8 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c                           |   10 
 drivers/net/ethernet/freescale/enetc/enetc.c                                  |    7 
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c                              |    3 
 drivers/net/ethernet/freescale/fman/fman.c                                    |    4 
 drivers/net/ethernet/freescale/gianfar.c                                      |   16 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c                                  |   28 
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c                            |   31 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                       |  108 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h                       |    1 
 drivers/net/ethernet/ibm/emac/core.c                                          |   13 
 drivers/net/ethernet/intel/e1000e/ich8lan.c                                   |    3 
 drivers/net/ethernet/intel/e1000e/netdev.c                                    |   15 
 drivers/net/ethernet/intel/i40e/i40e_debug.h                                  |    2 
 drivers/net/ethernet/intel/ice/ice_common.c                                   |    1 
 drivers/net/ethernet/intel/ice/ice_dpll.c                                     |   20 
 drivers/net/ethernet/intel/ice/ice_eswitch.c                                  |    4 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                                  |   12 
 drivers/net/ethernet/intel/ice/ice_main.c                                     |   16 
 drivers/net/ethernet/intel/ice/ice_vf_lib.c                                   |    2 
 drivers/net/ethernet/intel/idpf/virtchnl2.h                                   |   12 
 drivers/net/ethernet/intel/igc/igc_main.c                                     |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                                 |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h                                 |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c                                 |    2 
 drivers/net/ethernet/marvell/mvneta.c                                         |    3 
 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c                         |    9 
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h                              |   31 
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c                               |    6 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c                         |    9 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c                       |   59 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c                       |   27 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                           |   15 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                           |   40 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c                        |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c                     |   10 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                          |   83 -
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c                          |   22 
 drivers/net/ethernet/marvell/prestera/prestera_main.c                         |    2 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                                   |   10 
 drivers/net/ethernet/mediatek/mtk_ppe.c                                       |    4 
 drivers/net/ethernet/mediatek/mtk_wed_debugfs.c                               |    6 
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c                                   |    8 
 drivers/net/ethernet/mellanox/mlx5/core/Makefile                              |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en.h                                  |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c                    |   37 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c                     |   47 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                             |   14 
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c                            |    9 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                               |    3 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                             |   17 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c                    |   24 
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c                         |    3 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                             |  505 ++++---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h                             |  102 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c                           |   41 
 drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c                      |  235 +++
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c                          |    8 
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h                          |    1 
 drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c                         |    8 
 drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.h                         |    6 
 drivers/net/ethernet/mellanox/mlx5/core/lib/port_tun.c                        |    3 
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c                              |   10 
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h                              |   10 
 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c                              |    1 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                                |   12 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c                    |    1 
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c                                |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c                         |    1 
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c                                    |    9 
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c                                |    7 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c                                   |    4 
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c                                   |    2 
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
 drivers/net/ethernet/microsoft/mana/mana_bpf.c                                |    3 
 drivers/net/ethernet/microsoft/mana/mana_en.c                                 |   80 -
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c                                |   26 
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h                                |    5 
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c                             |   82 -
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h                             |   14 
 drivers/net/ethernet/oa_tc6.c                                                 |   11 
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c                           |   11 
 drivers/net/ethernet/qlogic/qede/qede_fp.c                                    |    9 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c                          |    5 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h                               |    1 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c                          |   72 -
 drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c                          |   13 
 drivers/net/ethernet/sun/sungem.c                                             |   13 
 drivers/net/ethernet/sunplus/spl2sw_phy.c                                     |    6 
 drivers/net/ethernet/ti/icssg/icssg_common.c                                  |  120 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                                   |    1 
 drivers/net/ethernet/wangxun/libwx/wx_type.h                                  |    1 
 drivers/net/geneve.c                                                          |   24 
 drivers/net/gtp.c                                                             |   10 
 drivers/net/ieee802154/ca8210.c                                               |    9 
 drivers/net/ipa/ipa_smp2p.c                                                   |   30 
 drivers/net/macsec.c                                                          |    9 
 drivers/net/mdio/Kconfig                                                      |    3 
 drivers/net/netconsole.c                                                      |   12 
 drivers/net/ovpn/udp.c                                                        |    2 
 drivers/net/pfcp.c                                                            |    5 
 drivers/net/phy/realtek/realtek_main.c                                        |    3 
 drivers/net/phy/sfp.c                                                         |    1 
 drivers/net/pse-pd/pse_core.c                                                 |    6 
 drivers/net/thunderbolt/main.c                                                |    8 
 drivers/net/usb/gl620a.c                                                      |    6 
 drivers/net/usb/lan78xx.c                                                     |   55 
 drivers/net/usb/net1080.c                                                     |    2 
 drivers/net/veth.c                                                            |    2 
 drivers/net/virtio_net.c                                                      |   27 
 drivers/net/vxlan/vxlan_core.c                                                |   14 
 drivers/net/wan/ixp4xx_hss.c                                                  |    4 
 drivers/net/wireguard/socket.c                                                |    8 
 drivers/net/wireless/ath/ath11k/mhi.c                                         |    4 
 drivers/net/wireless/ath/ath11k/pci.c                                         |    8 
 drivers/net/wireless/ath/ath12k/ahb.c                                         |   25 
 drivers/net/wireless/ath/ath12k/dp.c                                          |   10 
 drivers/net/wireless/ath/ath12k/dp_mon.c                                      |    6 
 drivers/net/wireless/ath/ath12k/mac.c                                         |   21 
 drivers/net/wireless/ath/ath12k/pci.c                                         |    2 
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c                                 |    4 
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
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c                               |   15 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                               |   20 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                              |    4 
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c                               |    4 
 drivers/net/wireless/mediatek/mt76/mt7925/testmode.c                          |    5 
 drivers/net/wireless/mediatek/mt76/mt792x_core.c                              |    4 
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c                               |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                               |   35 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                              |    9 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                               |    5 
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                            |    3 
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c                               |    2 
 drivers/net/wireless/mediatek/mt76/tx.c                                       |    2 
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c                                |   12 
 drivers/net/wireless/realtek/rtw88/pci.c                                      |   13 
 drivers/net/wireless/realtek/rtw89/core.h                                     |    3 
 drivers/net/wireless/realtek/rtw89/fw.c                                       |    2 
 drivers/net/wireless/realtek/rtw89/pci.c                                      |    8 
 drivers/net/wireless/ti/wlcore/main.c                                         |   23 
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c                                    |   40 
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c                                        |    3 
 drivers/net/wwan/t7xx/t7xx_port_wwan.c                                        |    2 
 drivers/ntb/hw/epf/ntb_hw_epf.c                                               |   81 -
 drivers/ntb/ntb_transport.c                                                   |   10 
 drivers/nvdimm/btt.c                                                          |   14 
 drivers/nvdimm/nd.h                                                           |   11 
 drivers/nvdimm/region_devs.c                                                  |   66 
 drivers/nvme/host/apple.c                                                     |   12 
 drivers/nvme/host/core.c                                                      |    4 
 drivers/nvme/host/pci.c                                                       |    9 
 drivers/nvme/target/core.c                                                    |    2 
 drivers/nvme/target/fabrics-cmd-auth.c                                        |   26 
 drivers/nvme/target/rdma.c                                                    |   18 
 drivers/nvme/target/tcp.c                                                     |   11 
 drivers/of/cpu.c                                                              |    2 
 drivers/of/dynamic.c                                                          |    1 
 drivers/of/of_reserved_mem.c                                                  |   28 
 drivers/of/overlay.c                                                          |   15 
 drivers/of/platform.c                                                         |    5 
 drivers/opp/core.c                                                            |    5 
 drivers/pci/controller/dwc/pci-meson.c                                        |   13 
 drivers/pci/controller/dwc/pcie-designware-debugfs.c                          |   10 
 drivers/pci/controller/dwc/pcie-designware.c                                  |   16 
 drivers/pci/controller/dwc/pcie-designware.h                                  |    1 
 drivers/pci/controller/dwc/pcie-intel-gw.c                                    |   46 
 drivers/pci/controller/dwc/pcie-qcom.c                                        |   43 
 drivers/pci/controller/pci-loongson.c                                         |   31 
 drivers/pci/controller/pcie-iproc-bcma.c                                      |    2 
 drivers/pci/controller/pcie-iproc-platform.c                                  |    2 
 drivers/pci/controller/pcie-iproc.c                                           |    1 
 drivers/pci/controller/pcie-iproc.h                                           |    2 
 drivers/pci/controller/pcie-mediatek-gen3.c                                   |    4 
 drivers/pci/controller/pcie-mediatek.c                                        |   19 
 drivers/pci/controller/pcie-rcar-host.c                                       |    1 
 drivers/pci/endpoint/functions/pci-epf-ntb.c                                  |   21 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                                 |  130 +
 drivers/pci/msi/msi.c                                                         |    4 
 drivers/pci/pci.c                                                             |    3 
 drivers/pci/pwrctrl/core.c                                                    |   26 
 drivers/pci/rom.c                                                             |  149 +-
 drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c                               |   26 
 drivers/phy/phy-can-transceiver.c                                             |    3 
 drivers/pinctrl/Kconfig                                                       |    1 
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c                                      |    6 
 drivers/pinctrl/mediatek/mtk-eint.c                                           |    6 
 drivers/pinctrl/mediatek/pinctrl-airoha.c                                     |  122 +
 drivers/pinctrl/mediatek/pinctrl-mt8167.c                                     |    2 
 drivers/pinctrl/mediatek/pinctrl-mt8516.c                                     |    2 
 drivers/pinctrl/meson/pinctrl-amlogic-a4.c                                    |   15 
 drivers/pinctrl/meson/pinctrl-meson.c                                         |    2 
 drivers/pinctrl/nuvoton/pinctrl-ma35.c                                        |    3 
 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c                                      |  470 +++---
 drivers/pinctrl/pinconf-generic.c                                             |    5 
 drivers/pinctrl/qcom/tlmm-test.c                                              |   19 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                                       |    8 
 drivers/pinctrl/spacemit/pinctrl-k1.c                                         |    2 
 drivers/pinctrl/sunxi/pinctrl-sun55i-a523-r.c                                 |    1 
 drivers/pinctrl/sunxi/pinctrl-sun55i-a523.c                                   |    1 
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                                         |    2 
 drivers/platform/chrome/chromeos_privacy_screen.c                             |    3 
 drivers/platform/chrome/chromeos_tbmc.c                                       |    6 
 drivers/platform/chrome/wilco_ec/event.c                                      |    8 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                                     |   39 
 drivers/platform/x86/amd/pmc/pmc.c                                            |   83 +
 drivers/platform/x86/amd/pmc/pmc.h                                            |    2 
 drivers/platform/x86/bitland-mifs-wmi.c                                       |    8 
 drivers/platform/x86/classmate-laptop.c                                       |   12 
 drivers/platform/x86/dell/dell-laptop.c                                       |    5 
 drivers/platform/x86/hp/hp-wmi.c                                              |    8 
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c                   |    2 
 drivers/platform/x86/intel/vsec.c                                             |   17 
 drivers/platform/x86/intel/vsec_tpmi.c                                        |   25 
 drivers/platform/x86/xo15-ebook.c                                             |    7 
 drivers/pmdomain/imx/imx8m-blk-ctrl.c                                         |   46 
 drivers/pmdomain/imx/imx93-blk-ctrl.c                                         |   60 
 drivers/pmdomain/mediatek/mtk-pm-domains.c                                    |   40 
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
 drivers/remoteproc/qcom_q6v5_wcss.c                                           |   23 
 drivers/remoteproc/xlnx_r5_remoteproc.c                                       |   46 
 drivers/reset/reset-imx7.c                                                    |    6 
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
 drivers/soc/fsl/qe/qe_ports_ic.c                                              |   21 
 drivers/soc/mediatek/mt8167-mmsys.h                                           |   11 
 drivers/soc/ti/k3-ringacc.c                                                   |    4 
 drivers/soc/xilinx/zynqmp_power.c                                             |   47 
 drivers/soundwire/generic_bandwidth_allocation.c                              |   47 
 drivers/soundwire/intel_ace2x.c                                               |    1 
 drivers/soundwire/stream.c                                                    |    7 
 drivers/spi/spi-atcspi200.c                                                   |   13 
 drivers/spi/spi-atmel.c                                                       |  133 -
 drivers/spi/spi-dw.h                                                          |    1 
 drivers/spi/spi-ep93xx.c                                                      |    1 
 drivers/spi/spi-hisi-kunpeng.c                                                |    6 
 drivers/spi/spi-imx.c                                                         |   19 
 drivers/spi/spi-meson-spifc.c                                                 |    1 
 drivers/spi/spi-rpc-if.c                                                      |    6 
 drivers/spi/spi-rzv2h-rspi.c                                                  |    4 
 drivers/spi/spi-sh-msiof.c                                                    |   10 
 drivers/spi/spi-uniphier.c                                                    |    4 
 drivers/spi/spi-xilinx.c                                                      |   11 
 drivers/spi/spi.c                                                             |    5 
 drivers/staging/media/atomisp/i2c/atomisp-gc2235.c                            |   29 
 drivers/staging/media/atomisp/pci/atomisp_cmd.c                               |    6 
 drivers/staging/media/atomisp/pci/sh_css.c                                    |    8 
 drivers/staging/media/sunxi/cedrus/cedrus.c                                   |    4 
 drivers/staging/most/video/video.c                                            |    7 
 drivers/staging/nvec/nvec.c                                                   |    4 
 drivers/staging/rtl8723bs/core/rtw_security.c                                 |    2 
 drivers/target/iscsi/iscsi_target_auth.c                                      |    6 
 drivers/target/loopback/tcm_loop.c                                            |   64 
 drivers/target/target_core_fabric_lib.c                                       |   89 -
 drivers/target/target_core_internal.h                                         |    3 
 drivers/target/target_core_pr.c                                               |   12 
 drivers/thermal/intel/therm_throt.c                                           |    7 
 drivers/thermal/testing/command.c                                             |   48 
 drivers/thermal/testing/thermal_testing.h                                     |    8 
 drivers/thermal/testing/zone.c                                                |    7 
 drivers/thermal/thermal_hwmon.c                                               |  156 --
 drivers/thunderbolt/debugfs.c                                                 |    8 
 drivers/tty/serial/8250/8250_omap.c                                           |    3 
 drivers/tty/serial/max310x.c                                                  |   12 
 drivers/tty/serial/msm_serial.c                                               |    3 
 drivers/ufs/core/ufs_trace.h                                                  |   36 
 drivers/ufs/core/ufshcd.c                                                     |   36 
 drivers/usb/atm/ueagle-atm.c                                                  |   94 -
 drivers/usb/host/max3421-hcd.c                                                |    8 
 drivers/vdpa/octeon_ep/octep_vdpa_main.c                                      |   20 
 drivers/vdpa/vdpa_user/iova_domain.c                                          |    2 
 drivers/vdpa/vdpa_user/vduse_dev.c                                            |  189 ++
 drivers/vfio/pci/qat/main.c                                                   |   16 
 drivers/vfio/pci/xe/main.c                                                    |    2 
 drivers/vhost/net.c                                                           |   15 
 drivers/vhost/vdpa.c                                                          |   29 
 drivers/vhost/vhost.c                                                         |   11 
 drivers/video/backlight/ktd2801-backlight.c                                   |    1 
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
 drivers/xen/pvcalls-front.c                                                   |   88 +
 drivers/xen/xen-scsiback.c                                                    |   30 
 fs/9p/vfs_inode.c                                                             |   28 
 fs/9p/vfs_inode_dotl.c                                                        |    4 
 fs/afs/callback.c                                                             |   17 
 fs/afs/cell.c                                                                 |   27 
 fs/afs/cm_security.c                                                          |    3 
 fs/afs/cmservice.c                                                            |    7 
 fs/afs/dir.c                                                                  |   40 
 fs/afs/dynroot.c                                                              |    2 
 fs/afs/fs_operation.c                                                         |    2 
 fs/afs/inode.c                                                                |   15 
 fs/afs/internal.h                                                             |    3 
 fs/afs/rxrpc.c                                                                |   16 
 fs/afs/super.c                                                                |    5 
 fs/afs/vl_list.c                                                              |   10 
 fs/afs/volume.c                                                               |    2 
 fs/bpf_fs_kfuncs.c                                                            |   10 
 fs/btrfs/compression.c                                                        |   18 
 fs/btrfs/delalloc-space.c                                                     |    2 
 fs/btrfs/disk-io.c                                                            |    2 
 fs/btrfs/extent-tree.c                                                        |    5 
 fs/btrfs/inode.c                                                              |    2 
 fs/btrfs/lzo.c                                                                |   11 
 fs/btrfs/reflink.c                                                            |  101 -
 fs/btrfs/space-info.c                                                         |    2 
 fs/btrfs/space-info.h                                                         |   11 
 fs/btrfs/super.c                                                              |    4 
 fs/btrfs/zoned.c                                                              |   64 
 fs/cachefiles/namei.c                                                         |    3 
 fs/configfs/dir.c                                                             |   57 
 fs/crypto/fscrypt_private.h                                                   |   32 
 fs/crypto/keyring.c                                                           |  216 +--
 fs/dlm/midcomms.c                                                             |    4 
 fs/efs/file.c                                                                 |   21 
 fs/erofs/inode.c                                                              |    5 
 fs/erofs/super.c                                                              |    4 
 fs/eventpoll.c                                                                |  579 +++++---
 fs/exfat/balloc.c                                                             |    2 
 fs/exfat/dir.c                                                                |   48 
 fs/exfat/exfat_fs.h                                                           |  131 +
 fs/exfat/fatent.c                                                             |    4 
 fs/exfat/file.c                                                               |    8 
 fs/exfat/inode.c                                                              |   26 
 fs/exfat/namei.c                                                              |   26 
 fs/exfat/super.c                                                              |    5 
 fs/ext2/file.c                                                                |    9 
 fs/ext4/ext4.h                                                                |   20 
 fs/ext4/fast_commit.c                                                         |   50 
 fs/ext4/inode.c                                                               |    3 
 fs/ext4/ioctl.c                                                               |   15 
 fs/ext4/namei.c                                                               |    2 
 fs/f2fs/data.c                                                                |   29 
 fs/f2fs/f2fs.h                                                                |    1 
 fs/f2fs/segment.c                                                             |    8 
 fs/f2fs/xattr.c                                                               |    6 
 fs/fhandle.c                                                                  |    2 
 fs/fs-writeback.c                                                             |    5 
 fs/hfs/inode.c                                                                |    2 
 fs/hfsplus/btree.c                                                            |    2 
 fs/hfsplus/xattr.c                                                            |    1 
 fs/iomap/bio.c                                                                |   13 
 fs/iomap/buffered-io.c                                                        |    2 
 fs/iomap/direct-io.c                                                          |    7 
 fs/iomap/ioend.c                                                              |    8 
 fs/jbd2/journal.c                                                             |    2 
 fs/kernfs/dir.c                                                               |   33 
 fs/kernfs/file.c                                                              |   13 
 fs/kernfs/inode.c                                                             |   36 
 fs/kernfs/kernfs-internal.h                                                   |   24 
 fs/kernfs/mount.c                                                             |    2 
 fs/lockd/lockd.h                                                              |    8 
 fs/lockd/svc4proc.c                                                           |   19 
 fs/lockd/svcproc.c                                                            |    2 
 fs/lockd/svcsubs.c                                                            |    7 
 fs/minix/minix.h                                                              |    2 
 fs/namei.c                                                                    |    4 
 fs/netfs/read_retry.c                                                         |    7 
 fs/netfs/write_issue.c                                                        |   18 
 fs/netfs/write_retry.c                                                        |    7 
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
 fs/ntfs/aops.c                                                                |   23 
 fs/ntfs/attrib.c                                                              |  345 +++-
 fs/ntfs/attrib.h                                                              |    4 
 fs/ntfs/attrlist.c                                                            |   20 
 fs/ntfs/dir.c                                                                 |   79 -
 fs/ntfs/ea.c                                                                  |   16 
 fs/ntfs/index.c                                                               |  293 ++--
 fs/ntfs/index.h                                                               |   12 
 fs/ntfs/inode.c                                                               |   38 
 fs/ntfs/logfile.c                                                             |    2 
 fs/ntfs/mft.c                                                                 |  137 -
 fs/ntfs/namei.c                                                               |   67 
 fs/ntfs/runlist.c                                                             |   12 
 fs/ntfs/super.c                                                               |   53 
 fs/ntfs3/attrib.c                                                             |   10 
 fs/ntfs3/frecord.c                                                            |   17 
 fs/ntfs3/fslog.c                                                              |  149 +-
 fs/ntfs3/index.c                                                              |   45 
 fs/ntfs3/inode.c                                                              |    9 
 fs/ntfs3/lznt.c                                                               |    2 
 fs/ntfs3/namei.c                                                              |    2 
 fs/ntfs3/ntfs_fs.h                                                            |    3 
 fs/ntfs3/run.c                                                                |   14 
 fs/ocfs2/alloc.c                                                              |    2 
 fs/ocfs2/aops.c                                                               |   13 
 fs/ocfs2/buffer_head_io.c                                                     |    7 
 fs/ocfs2/dlm/dlmdebug.c                                                       |   16 
 fs/ocfs2/dlmglue.c                                                            |   17 
 fs/ocfs2/inode.c                                                              |  206 ++
 fs/ocfs2/journal.c                                                            |   13 
 fs/ocfs2/journal.h                                                            |    3 
 fs/ocfs2/move_extents.c                                                       |    4 
 fs/ocfs2/ocfs2.h                                                              |    2 
 fs/ocfs2/quota_local.c                                                        |    2 
 fs/ocfs2/refcounttree.c                                                       |    9 
 fs/ocfs2/stack_user.c                                                         |   10 
 fs/ocfs2/super.c                                                              |    2 
 fs/ocfs2/sysfile.c                                                            |    9 
 fs/orangefs/dir.c                                                             |    7 
 fs/overlayfs/copy_up.c                                                        |   12 
 fs/overlayfs/inode.c                                                          |    4 
 fs/pidfs.c                                                                    |   45 
 fs/proc/generic.c                                                             |    9 
 fs/proc/page.c                                                                |    2 
 fs/proc/task_mmu.c                                                            |   74 -
 fs/resctrl/rdtgroup.c                                                         |   33 
 fs/smb/client/cifs_fs_sb.h                                                    |    1 
 fs/smb/client/cifsfs.c                                                        |   12 
 fs/smb/client/connect.c                                                       |    4 
 fs/smb/client/file.c                                                          |    6 
 fs/smb/client/fs_context.c                                                    |  102 -
 fs/smb/client/inode.c                                                         |   30 
 fs/smb/client/ioctl.c                                                         |   12 
 fs/smb/client/misc.c                                                          |    8 
 fs/smb/client/reparse.c                                                       |   17 
 fs/smb/client/smb1pdu.h                                                       |    5 
 fs/smb/client/smb2ops.c                                                       |   38 
 fs/smb/client/smb2pdu.h                                                       |    4 
 fs/smb/common/fscc.h                                                          |   18 
 fs/smb/server/auth.c                                                          |   47 
 fs/smb/server/auth.h                                                          |    7 
 fs/smb/server/mgmt/user_session.c                                             |    4 
 fs/smb/server/mgmt/user_session.h                                             |    1 
 fs/smb/server/misc.c                                                          |   33 
 fs/smb/server/misc.h                                                          |    1 
 fs/smb/server/oplock.c                                                        |    6 
 fs/smb/server/smb2pdu.c                                                       |  171 +-
 fs/smb/server/smb2pdu.h                                                       |    3 
 fs/smb/server/smbacl.c                                                        |    7 
 fs/smb/server/vfs.c                                                           |   53 
 fs/smb/server/vfs_cache.c                                                     |   29 
 fs/super.c                                                                    |   11 
 fs/sysfs/file.c                                                               |    4 
 fs/udf/super.c                                                                |    2 
 fs/xattr.c                                                                    |  261 +--
 fs/xfs/xfs_aops.c                                                             |    3 
 fs/xfs/xfs_rtalloc.c                                                          |    8 
 fs/xfs/xfs_zone_alloc.c                                                       |   11 
 fs/xfs/xfs_zone_alloc.h                                                       |    1 
 fs/xfs/xfs_zone_gc.c                                                          |    4 
 include/acpi/platform/aclinuxex.h                                             |    1 
 include/asm-generic/bitops/lock.h                                             |   22 
 include/asm-generic/uaccess.h                                                 |    3 
 include/dt-bindings/clock/qcom,x1e80100-camcc.h                               |    3 
 include/dt-bindings/power/fsl,imx93-power.h                                   |    1 
 include/linux/amba/bus.h                                                      |    5 
 include/linux/arm-smccc.h                                                     |    5 
 include/linux/bpf-cgroup.h                                                    |    5 
 include/linux/bpf.h                                                           |    2 
 include/linux/bpf_lsm.h                                                       |    6 
 include/linux/cdx/cdx_bus.h                                                   |    4 
 include/linux/device.h                                                        |    5 
 include/linux/edac.h                                                          |    3 
 include/linux/filelock.h                                                      |    2 
 include/linux/firmware.h                                                      |   10 
 include/linux/firmware/samsung/exynos-acpm-protocol.h                         |   10 
 include/linux/firmware/xlnx-zynqmp.h                                          |   21 
 include/linux/fs.h                                                            |    1 
 include/linux/fwnode.h                                                        |    3 
 include/linux/hfs_common.h                                                    |    1 
 include/linux/host1x.h                                                        |    7 
 include/linux/hyperv.h                                                        |    5 
 include/linux/i3c/master.h                                                    |   14 
 include/linux/ieee80211-eht.h                                                 |   12 
 include/linux/ieee80211-s1g.h                                                 |    2 
 include/linux/inetdevice.h                                                    |    5 
 include/linux/iomap.h                                                         |    2 
 include/linux/iommu.h                                                         |    1 
 include/linux/kernfs.h                                                        |   11 
 include/linux/liveupdate.h                                                    |    9 
 include/linux/mfd/rohm-bd72720.h                                              |    1 
 include/linux/netdevice.h                                                     |    4 
 include/linux/nfs_page.h                                                      |    1 
 include/linux/nfs_xdr.h                                                       |    1 
 include/linux/rhashtable-types.h                                              |   22 
 include/linux/rpmsg.h                                                         |    4 
 include/linux/shmem_fs.h                                                      |    3 
 include/linux/sockptr.h                                                       |    2 
 include/linux/sunrpc/clnt.h                                                   |    1 
 include/linux/uaccess.h                                                       |   27 
 include/linux/virtio.h                                                        |    2 
 include/linux/vmalloc.h                                                       |    4 
 include/linux/xattr.h                                                         |   35 
 include/net/addrconf.h                                                        |   10 
 include/net/bluetooth/hci.h                                                   |    5 
 include/net/bluetooth/l2cap.h                                                 |   10 
 include/net/bond_options.h                                                    |    1 
 include/net/bonding.h                                                         |    1 
 include/net/dst_metadata.h                                                    |    7 
 include/net/fib_rules.h                                                       |    5 
 include/net/gue.h                                                             |    2 
 include/net/ip_fib.h                                                          |   12 
 include/net/ip_vs.h                                                           |    3 
 include/net/mana/mana.h                                                       |    8 
 include/net/netfilter/ipv4/nf_conntrack_ipv4.h                                |    4 
 include/net/netfilter/nf_conntrack_expect.h                                   |   17 
 include/net/netfilter/nf_conntrack_extend.h                                   |   12 
 include/net/netfilter/nf_conntrack_helper.h                                   |   18 
 include/net/netfilter/nf_conntrack_timeout.h                                  |   27 
 include/net/netfilter/nf_dup_netdev.h                                         |   34 
 include/net/netfilter/nf_flow_table.h                                         |    5 
 include/net/netfilter/nf_queue.h                                              |    1 
 include/net/netfilter/nft_meta.h                                              |    2 
 include/net/sch_generic.h                                                     |   32 
 include/net/sctp/sctp.h                                                       |    3 
 include/net/tc_act/tc_pedit.h                                                 |   18 
 include/net/tcp.h                                                             |    9 
 include/net/udp_tunnel.h                                                      |    4 
 include/net/xfrm.h                                                            |   15 
 include/rdma/frmr_pools.h                                                     |    3 
 include/rdma/ib_umem.h                                                        |    4 
 include/rdma/ib_verbs.h                                                       |    5 
 include/rdma/rdma_vt.h                                                        |   20 
 include/soc/spacemit/k3-syscon.h                                              |    4 
 include/sound/soc-dapm.h                                                      |    1 
 include/trace/events/dma_fence.h                                              |   40 
 include/uapi/linux/bpf.h                                                      |    2 
 include/uapi/linux/if_link.h                                                  |    1 
 include/uapi/linux/iommufd.h                                                  |   12 
 include/uapi/linux/netfilter/nf_conntrack_common.h                            |    1 
 include/uapi/rdma/bnxt_re-abi.h                                               |    7 
 include/ufs/ufshcd.h                                                          |    3 
 init/initramfs_test.c                                                         |   17 
 io_uring/bpf-ops.c                                                            |    2 
 kernel/bpf/arena.c                                                            |   61 
 kernel/bpf/arraymap.c                                                         |    8 
 kernel/bpf/bpf_lru_list.c                                                     |  165 +-
 kernel/bpf/bpf_lru_list.h                                                     |   25 
 kernel/bpf/bpf_lsm.c                                                          |   23 
 kernel/bpf/cgroup.c                                                           |  168 +-
 kernel/bpf/core.c                                                             |    2 
 kernel/bpf/devmap.c                                                           |   12 
 kernel/bpf/disasm.c                                                           |    5 
 kernel/bpf/hashtab.c                                                          |   32 
 kernel/bpf/helpers.c                                                          |   17 
 kernel/bpf/inode.c                                                            |   13 
 kernel/bpf/map_in_map.c                                                       |    5 
 kernel/bpf/map_iter.c                                                         |    4 
 kernel/bpf/states.c                                                           |   13 
 kernel/bpf/syscall.c                                                          |   35 
 kernel/bpf/verifier.c                                                         |   56 
 kernel/cgroup/cpuset.c                                                        |    7 
 kernel/cpu.c                                                                  |   20 
 kernel/exit.c                                                                 |    7 
 kernel/fork.c                                                                 |    9 
 kernel/kcov.c                                                                 |    4 
 kernel/kexec_core.c                                                           |    8 
 kernel/liveupdate/kexec_handover.c                                            |   32 
 kernel/liveupdate/luo_file.c                                                  |    5 
 kernel/liveupdate/luo_flb.c                                                   |   52 
 kernel/liveupdate/luo_session.c                                               |   99 +
 kernel/locking/spinlock_rt.c                                                  |   27 
 kernel/power/qos.c                                                            |   11 
 kernel/sched/core.c                                                           |    1 
 kernel/sched/cpufreq_schedutil.c                                              |    1 
 kernel/sched/debug.c                                                          |    3 
 kernel/sched/fair.c                                                           |  211 +-
 kernel/signal.c                                                               |   10 
 kernel/taskstats.c                                                            |   62 
 kernel/time/alarmtimer.c                                                      |    8 
 kernel/time/posix-cpu-timers.c                                                |  187 +-
 kernel/time/posix-timers.c                                                    |    6 
 kernel/time/posix-timers.h                                                    |    4 
 kernel/time/tick-sched.c                                                      |   11 
 kernel/time/time.c                                                            |    2 
 kernel/time/timer_migration.h                                                 |   18 
 kernel/trace/bpf_trace.c                                                      |   22 
 kernel/trace/fprobe.c                                                         |   10 
 kernel/trace/ring_buffer.c                                                    |    8 
 kernel/trace/trace.c                                                          |    2 
 kernel/trace/trace_eprobe.c                                                   |    2 
 kernel/trace/trace_events_hist.c                                              |   41 
 kernel/trace/trace_events_user.c                                              |   39 
 kernel/trace/trace_osnoise.c                                                  |    4 
 kernel/trace/trace_probe.c                                                    |  174 ++
 kernel/trace/trace_probe.h                                                    |    7 
 kernel/trace/trace_remote.c                                                   |   18 
 kernel/workqueue.c                                                            |    2 
 lib/Kconfig.debug                                                             |    5 
 lib/alloc_tag.c                                                               |    9 
 lib/base64.c                                                                  |    3 
 lib/crypto/Kconfig                                                            |    3 
 lib/fonts/font_acorn_8x8.c                                                    |    5 
 lib/locking-selftest.c                                                        |    7 
 lib/rhashtable.c                                                              |   17 
 lib/test_hmm.c                                                                |    6 
 lib/test_meminit.c                                                            |    2 
 lib/tests/kunit_iov_iter.c                                                    |   12 
 lib/tests/liveupdate.c                                                        |    3 
 lib/usercopy.c                                                                |    4 
 lib/vsprintf.c                                                                |   36 
 mm/compaction.c                                                               |    7 
 mm/damon/core.c                                                               |   59 
 mm/damon/sysfs-schemes.c                                                      |   17 
 mm/huge_memory.c                                                              |    3 
 mm/hugetlb.c                                                                  |    7 
 mm/memory_hotplug.c                                                           |    2 
 mm/mm_init.c                                                                  |   47 
 mm/numa_emulation.c                                                           |   17 
 mm/shmem.c                                                                    |   50 
 mm/slub.c                                                                     |    7 
 mm/sparse-vmemmap.c                                                           |   20 
 net/9p/client.c                                                               |    2 
 net/9p/trans_rdma.c                                                           |   19 
 net/9p/trans_virtio.c                                                         |    5 
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
 net/bluetooth/6lowpan.c                                                       |   85 -
 net/bluetooth/eir.c                                                           |    8 
 net/bluetooth/hci_codec.c                                                     |    2 
 net/bluetooth/hci_core.c                                                      |    2 
 net/bluetooth/hci_event.c                                                     |    7 
 net/bluetooth/iso.c                                                           |   31 
 net/bluetooth/l2cap_core.c                                                    |   94 +
 net/bluetooth/l2cap_sock.c                                                    |  103 -
 net/bluetooth/mgmt.c                                                          |    2 
 net/bluetooth/msft.c                                                          |    2 
 net/bluetooth/sco.c                                                           |   15 
 net/bluetooth/smp.c                                                           |   27 
 net/bpf/test_run.c                                                            |    8 
 net/bridge/br_cfm.c                                                           |    6 
 net/bridge/br_cfm_netlink.c                                                   |    4 
 net/bridge/br_if.c                                                            |    3 
 net/bridge/br_stp.c                                                           |    3 
 net/bridge/netfilter/nft_meta_bridge.c                                        |   23 
 net/can/bcm.c                                                                 |  646 ++++++---
 net/can/isotp.c                                                               |  298 +++-
 net/core/dev.c                                                                |    9 
 net/core/fib_rules.c                                                          |    6 
 net/core/filter.c                                                             |   28 
 net/core/flow_dissector.c                                                     |   12 
 net/core/lwt_bpf.c                                                            |   12 
 net/core/lwtunnel.c                                                           |    6 
 net/core/netdev-genl.c                                                        |    4 
 net/core/netdev_rx_queue.c                                                    |    8 
 net/devlink/rate.c                                                            |   25 
 net/ethtool/netlink.h                                                         |   28 
 net/ethtool/rss.c                                                             |   14 
 net/handshake/genl.c                                                          |    2 
 net/ieee802154/core.c                                                         |   51 
 net/ieee802154/header_ops.c                                                   |    9 
 net/ieee802154/ieee802154.h                                                   |   17 
 net/ieee802154/netlink.c                                                      |   36 
 net/ife/ife.c                                                                 |    2 
 net/ipv4/fib_trie.c                                                           |    4 
 net/ipv4/fou_core.c                                                           |    9 
 net/ipv4/igmp.c                                                               |   63 
 net/ipv4/inet_connection_sock.c                                               |    1 
 net/ipv4/ip_vti.c                                                             |    3 
 net/ipv4/ipip.c                                                               |    3 
 net/ipv4/netfilter/nf_nat_h323.c                                              |   12 
 net/ipv4/netfilter/nf_nat_pptp.c                                              |   14 
 net/ipv4/netfilter/nf_nat_snmp_basic_main.c                                   |   27 
 net/ipv4/netfilter/nf_reject_ipv4.c                                           |    2 
 net/ipv4/tcp_bbr.c                                                            |    2 
 net/ipv4/tcp_ipv4.c                                                           |    4 
 net/ipv4/tcp_output.c                                                         |    8 
 net/ipv4/udp_bpf.c                                                            |    9 
 net/ipv4/udp_tunnel_core.c                                                    |   10 
 net/ipv4/udp_tunnel_nic.c                                                     |    2 
 net/ipv4/xfrm4_input.c                                                        |    2 
 net/ipv6/addrconf.c                                                           |   55 
 net/ipv6/ioam6_iptunnel.c                                                     |    8 
 net/ipv6/ip6_fib.c                                                            |   17 
 net/ipv6/ip6_gre.c                                                            |    6 
 net/ipv6/ip6_tunnel.c                                                         |   10 
 net/ipv6/ip6_vti.c                                                            |    3 
 net/ipv6/mcast.c                                                              |   40 
 net/ipv6/ndisc.c                                                              |    8 
 net/ipv6/netfilter.c                                                          |    4 
 net/ipv6/netfilter/ip6t_ah.c                                                  |    5 
 net/ipv6/netfilter/ip6t_hbh.c                                                 |    1 
 net/ipv6/netfilter/ip6t_rt.c                                                  |    3 
 net/ipv6/netfilter/nf_conntrack_reasm.c                                       |    3 
 net/ipv6/route.c                                                              |    9 
 net/ipv6/seg6.c                                                               |    3 
 net/ipv6/sit.c                                                                |    3 
 net/ipv6/xfrm6_input.c                                                        |    2 
 net/kcm/kcmsock.c                                                             |    8 
 net/l2tp/l2tp_core.c                                                          |    2 
 net/llc/af_llc.c                                                              |    1 
 net/llc/llc_conn.c                                                            |    1 
 net/mac80211/main.c                                                           |    3 
 net/mac80211/rx.c                                                             |   34 
 net/mac80211/tx.c                                                             |   17 
 net/mac80211/util.c                                                           |    3 
 net/mac802154/iface.c                                                         |    2 
 net/mac802154/scan.c                                                          |    1 
 net/netfilter/ipset/ip_set_bitmap_gen.h                                       |    4 
 net/netfilter/ipset/ip_set_bitmap_ip.c                                        |    2 
 net/netfilter/ipset/ip_set_bitmap_ipmac.c                                     |    2 
 net/netfilter/ipset/ip_set_bitmap_port.c                                      |    2 
 net/netfilter/ipset/ip_set_core.c                                             |    4 
 net/netfilter/ipset/ip_set_hash_gen.h                                         |   12 
 net/netfilter/ipvs/ip_vs_app.c                                                |   10 
 net/netfilter/ipvs/ip_vs_conn.c                                               |    4 
 net/netfilter/ipvs/ip_vs_core.c                                               |   36 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                                         |   18 
 net/netfilter/ipvs/ip_vs_proto_tcp.c                                          |   11 
 net/netfilter/ipvs/ip_vs_proto_udp.c                                          |    3 
 net/netfilter/ipvs/ip_vs_xmit.c                                               |    6 
 net/netfilter/nf_conncount.c                                                  |   23 
 net/netfilter/nf_conntrack_amanda.c                                           |   39 
 net/netfilter/nf_conntrack_bpf.c                                              |   35 
 net/netfilter/nf_conntrack_broadcast.c                                        |    4 
 net/netfilter/nf_conntrack_core.c                                             |  122 -
 net/netfilter/nf_conntrack_ecache.c                                           |    2 
 net/netfilter/nf_conntrack_expect.c                                           |  184 +-
 net/netfilter/nf_conntrack_extend.c                                           |   32 
 net/netfilter/nf_conntrack_ftp.c                                              |   11 
 net/netfilter/nf_conntrack_h323_main.c                                        |  129 -
 net/netfilter/nf_conntrack_helper.c                                           |   94 +
 net/netfilter/nf_conntrack_irc.c                                              |   11 
 net/netfilter/nf_conntrack_netbios_ns.c                                       |   20 
 net/netfilter/nf_conntrack_netlink.c                                          |   32 
 net/netfilter/nf_conntrack_pptp.c                                             |   92 -
 net/netfilter/nf_conntrack_proto_gre.c                                        |   70 
 net/netfilter/nf_conntrack_sane.c                                             |    8 
 net/netfilter/nf_conntrack_seqadj.c                                           |   19 
 net/netfilter/nf_conntrack_sip.c                                              |   66 
 net/netfilter/nf_conntrack_snmp.c                                             |   21 
 net/netfilter/nf_conntrack_tftp.c                                             |    5 
 net/netfilter/nf_conntrack_timeout.c                                          |   27 
 net/netfilter/nf_dup_netdev.c                                                 |   15 
 net/netfilter/nf_flow_table_core.c                                            |   12 
 net/netfilter/nf_flow_table_ip.c                                              |  107 -
 net/netfilter/nf_flow_table_path.c                                            |    7 
 net/netfilter/nf_nat_core.c                                                   |   10 
 net/netfilter/nf_nat_sip.c                                                    |   23 
 net/netfilter/nf_queue.c                                                      |   14 
 net/netfilter/nf_synproxy_core.c                                              |   40 
 net/netfilter/nf_tables_api.c                                                 |    3 
 net/netfilter/nfnetlink_cthelper.c                                            |   81 -
 net/netfilter/nfnetlink_cttimeout.c                                           |  112 -
 net/netfilter/nfnetlink_osf.c                                                 |    6 
 net/netfilter/nfnetlink_queue.c                                               |    3 
 net/netfilter/nft_compat.c                                                    |   24 
 net/netfilter/nft_ct.c                                                        |   29 
 net/netfilter/nft_fib.c                                                       |    9 
 net/netfilter/nft_fib_netdev.c                                                |   29 
 net/netfilter/nft_fwd_netdev.c                                                |   17 
 net/netfilter/nft_lookup.c                                                    |   10 
 net/netfilter/nft_meta.c                                                      |    5 
 net/netfilter/nft_payload.c                                                   |   16 
 net/netfilter/nft_set_pipapo.c                                                |   34 
 net/netfilter/nft_set_pipapo.h                                                |    8 
 net/netfilter/nft_set_rbtree.c                                                |    8 
 net/netfilter/nft_synproxy.c                                                  |    9 
 net/netfilter/xt_CT.c                                                         |    2 
 net/netfilter/xt_cluster.c                                                    |    2 
 net/netfilter/xt_connmark.c                                                   |   14 
 net/netfilter/xt_nat.c                                                        |    9 
 net/netfilter/xt_physdev.c                                                    |    5 
 net/netfilter/xt_rateest.c                                                    |    2 
 net/netfilter/xt_u32.c                                                        |   12 
 net/openvswitch/conntrack.c                                                   |    2 
 net/openvswitch/flow_netlink.c                                                |  201 ++
 net/psample/psample.c                                                         |    6 
 net/qrtr/af_qrtr.c                                                            |    2 
 net/rxrpc/ar-internal.h                                                       |    6 
 net/rxrpc/call_accept.c                                                       |   25 
 net/rxrpc/call_event.c                                                        |    5 
 net/rxrpc/call_object.c                                                       |    2 
 net/rxrpc/conn_client.c                                                       |    2 
 net/rxrpc/conn_event.c                                                        |    9 
 net/rxrpc/input.c                                                             |   39 
 net/rxrpc/local_object.c                                                      |    2 
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
 net/sched/sch_api.c                                                           |    2 
 net/sched/sch_cake.c                                                          |   13 
 net/sched/sch_cbs.c                                                           |    4 
 net/sched/sch_choke.c                                                         |    8 
 net/sched/sch_codel.c                                                         |   48 
 net/sched/sch_drr.c                                                           |   12 
 net/sched/sch_dualpi2.c                                                       |  122 +
 net/sched/sch_etf.c                                                           |    8 
 net/sched/sch_ets.c                                                           |    4 
 net/sched/sch_fq.c                                                            |    6 
 net/sched/sch_fq_codel.c                                                      |   48 
 net/sched/sch_fq_pie.c                                                        |    4 
 net/sched/sch_generic.c                                                       |   51 
 net/sched/sch_hfsc.c                                                          |   28 
 net/sched/sch_hhf.c                                                           |   34 
 net/sched/sch_htb.c                                                           |   18 
 net/sched/sch_mq.c                                                            |    5 
 net/sched/sch_mqprio.c                                                        |   18 
 net/sched/sch_multiq.c                                                        |    6 
 net/sched/sch_netem.c                                                         |   10 
 net/sched/sch_prio.c                                                          |    4 
 net/sched/sch_qfq.c                                                           |    6 
 net/sched/sch_red.c                                                           |    4 
 net/sched/sch_sfb.c                                                           |    4 
 net/sched/sch_sfq.c                                                           |    9 
 net/sched/sch_skbprio.c                                                       |    4 
 net/sched/sch_taprio.c                                                        |    6 
 net/sched/sch_tbf.c                                                           |    6 
 net/sched/sch_teql.c                                                          |  130 +
 net/sctp/diag.c                                                               |   67 
 net/sctp/protocol.c                                                           |   13 
 net/sctp/sm_make_chunk.c                                                      |   15 
 net/sctp/sm_statefuns.c                                                       |   64 
 net/sctp/socket.c                                                             |   38 
 net/smc/smc_cdc.c                                                             |   15 
 net/socket.c                                                                  |   30 
 net/sunrpc/clnt.c                                                             |   19 
 net/sunrpc/svc.c                                                              |   10 
 net/sunrpc/svcsock.c                                                          |   10 
 net/sunrpc/sysfs.c                                                            |    4 
 net/sunrpc/xdr.c                                                              |   14 
 net/sunrpc/xprtrdma/backchannel.c                                             |    5 
 net/sunrpc/xprtrdma/frwr_ops.c                                                |    2 
 net/sunrpc/xprtrdma/rpc_rdma.c                                                |  157 +-
 net/sunrpc/xprtrdma/transport.c                                               |   68 
 net/sunrpc/xprtrdma/verbs.c                                                   |  126 +
 net/sunrpc/xprtrdma/xprt_rdma.h                                               |    4 
 net/sunrpc/xprtsock.c                                                         |   16 
 net/tipc/bearer.c                                                             |    1 
 net/tipc/core.c                                                               |    9 
 net/tipc/discover.c                                                           |   14 
 net/tipc/name_distr.c                                                         |   13 
 net/tipc/netlink.c                                                            |   12 
 net/tipc/socket.c                                                             |    9 
 net/tipc/udp_media.c                                                          |   51 
 net/tls/tls_sw.c                                                              |   11 
 net/wireless/nl80211.c                                                        |    2 
 net/wireless/pmsr.c                                                           |    4 
 net/wireless/scan.c                                                           |    5 
 net/xfrm/espintcp.c                                                           |   34 
 net/xfrm/xfrm_input.c                                                         |   29 
 net/xfrm/xfrm_interface_core.c                                                |    3 
 net/xfrm/xfrm_nat_keepalive.c                                                 |   15 
 net/xfrm/xfrm_policy.c                                                        |   27 
 net/xfrm/xfrm_state.c                                                         |   26 
 net/xfrm/xfrm_user.c                                                          |   20 
 rust/Makefile                                                                 |    2 
 rust/helpers/uaccess.c                                                        |    2 
 rust/kernel/alloc/kvec.rs                                                     |    4 
 rust/kernel/devres.rs                                                         |    6 
 samples/damon/mtier.c                                                         |    3 
 samples/trace_events/trace-events-sample.c                                    |    4 
 scripts/kconfig/conf.c                                                        |    6 
 scripts/livepatch/klp-build                                                   |   41 
 security/apparmor/af_unix.c                                                   |   71 -
 security/apparmor/apparmorfs.c                                                |  113 +
 security/apparmor/domain.c                                                    |   58 
 security/apparmor/file.c                                                      |   12 
 security/apparmor/include/apparmorfs.h                                        |   12 
 security/apparmor/label.c                                                     |    2 
 security/apparmor/lsm.c                                                       |    2 
 security/apparmor/net.c                                                       |    1 
 security/apparmor/policy.c                                                    |   20 
 security/apparmor/policy_unpack.c                                             |    6 
 security/apparmor/procattr.c                                                  |    2 
 security/apparmor/task.c                                                      |    2 
 security/integrity/evm/evm_secfs.c                                            |   16 
 security/integrity/ima/ima_appraise.c                                         |    5 
 security/integrity/ima/ima_policy.c                                           |    3 
 security/keys/keyring.c                                                       |    2 
 security/landlock/fs.c                                                        |   14 
 security/landlock/fs.h                                                        |   10 
 security/landlock/net.c                                                       |   11 
 security/landlock/task.c                                                      |   11 
 security/selinux/hooks.c                                                      |   80 -
 sound/core/init.c                                                             |   11 
 sound/core/pcm_compat.c                                                       |    4 
 sound/core/pcm_native.c                                                       |    7 
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
 sound/hda/codecs/realtek/alc269.c                                             |   12 
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c                                |    3 
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c                                |    3 
 sound/hda/controllers/Kconfig                                                 |    2 
 sound/hda/core/regmap.c                                                       |    4 
 sound/soc/amd/acp/acp-sdw-legacy-mach.c                                       |    7 
 sound/soc/amd/acp/acp-sdw-sof-mach.c                                          |    7 
 sound/soc/codecs/adau1372.c                                                   |    5 
 sound/soc/codecs/aw88261.c                                                    |   12 
 sound/soc/codecs/cs35l56-shared.c                                             |    4 
 sound/soc/codecs/cs35l56.c                                                    |   27 
 sound/soc/codecs/cs530x.c                                                     |   29 
 sound/soc/codecs/cs530x.h                                                     |    6 
 sound/soc/codecs/hdac_hdmi.c                                                  |    4 
 sound/soc/codecs/lpass-va-macro.c                                             |    7 
 sound/soc/codecs/rt5575-spi.c                                                 |    2 
 sound/soc/codecs/sma1307.c                                                    |   35 
 sound/soc/codecs/tlv320aic3x.c                                                |   25 
 sound/soc/codecs/wm_adsp.c                                                    |    7 
 sound/soc/fsl/fsl_asrc_dma.c                                                  |   20 
 sound/soc/fsl/fsl_audmix.c                                                    |    6 
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c                                    |   23 
 sound/soc/mediatek/mt8189/mt8189-afe-pcm.c                                    |   38 
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c                                    |   21 
 sound/soc/meson/aiu-acodec-ctrl.c                                             |    3 
 sound/soc/meson/aiu-codec-ctrl.c                                              |    3 
 sound/soc/qcom/qdsp6/q6apm.c                                                  |    8 
 sound/soc/renesas/rcar/rsnd.h                                                 |    2 
 sound/soc/sdca/sdca_asoc.c                                                    |    3 
 sound/soc/sdw_utils/soc_sdw_utils.c                                           |    1 
 sound/soc/soc-dapm.c                                                          |   49 
 sound/soc/soc-topology.c                                                      |   37 
 sound/soc/sof/intel/Kconfig                                                   |    6 
 sound/soc/sof/ipc3-control.c                                                  |   79 -
 sound/soc/sof/ipc4-control.c                                                  |   34 
 sound/soc/sof/topology.c                                                      |    7 
 sound/soc/tegra/tegra210_ahub.c                                               |    4 
 sound/usb/fcp.c                                                               |    2 
 sound/usb/midi2.c                                                             |    5 
 sound/usb/mixer_scarlett2.c                                                   |  201 ++
 sound/usb/qcom/mixer_usb_offload.c                                            |    2 
 sound/usb/qcom/qc_audio_offload.c                                             |   30 
 sound/xen/xen_snd_front_alsa.c                                                |   17 
 sound/xen/xen_snd_front_evtchnl.c                                             |   28 
 sound/xen/xen_snd_front_evtchnl.h                                             |    6 
 tools/bpf/bpftool/cgroup.c                                                    |   14 
 tools/bpf/bpftool/gen.c                                                       |    2 
 tools/bpf/bpftool/net.c                                                       |    4 
 tools/include/nolibc/getopt.h                                                 |    2 
 tools/include/nolibc/stackprotector.h                                         |    3 
 tools/include/uapi/linux/bpf.h                                                |    2 
 tools/include/uapi/linux/if_link.h                                            |    2 
 tools/lib/api/fs/fs.c                                                         |   19 
 tools/lib/bpf/btf.c                                                           |    4 
 tools/lib/bpf/gen_loader.c                                                    |   81 -
 tools/lib/bpf/libbpf.c                                                        |    9 
 tools/lib/bpf/strset.c                                                        |   62 
 tools/lib/bpf/usdt.c                                                          |   16 
 tools/lib/symbol/kallsyms.c                                                   |    5 
 tools/net/ynl/Makefile                                                        |    2 
 tools/net/ynl/generated/Makefile                                              |    2 
 tools/net/ynl/lib/Makefile                                                    |    2 
 tools/objtool/elf.c                                                           |   75 -
 tools/objtool/include/objtool/elf.h                                           |   32 
 tools/objtool/klp-diff.c                                                      |  133 +
 tools/perf/Makefile.config                                                    |    1 
 tools/perf/arch/common.c                                                      |    4 
 tools/perf/arch/powerpc/util/auxtrace.c                                       |    6 
 tools/perf/arch/x86/tests/amd-ibs-period.c                                    |    2 
 tools/perf/bench/inject-buildid.c                                             |    9 
 tools/perf/builtin-annotate.c                                                 |    3 
 tools/perf/builtin-buildid-list.c                                             |    4 
 tools/perf/builtin-c2c.c                                                      |   28 
 tools/perf/builtin-diff.c                                                     |    3 
 tools/perf/builtin-inject.c                                                   |  172 ++
 tools/perf/builtin-record.c                                                   |    2 
 tools/perf/builtin-report.c                                                   |    7 
 tools/perf/builtin-sched.c                                                    |  177 +-
 tools/perf/builtin-script.c                                                   |    6 
 tools/perf/builtin-stat.c                                                     |   50 
 tools/perf/pmu-events/amd_metrics.py                                          |    2 
 tools/perf/pmu-events/metric.py                                               |    1 
 tools/perf/tests/code-reading.c                                               |    7 
 tools/perf/tests/dlfilter-test.c                                              |    8 
 tools/perf/tests/pmu-events.c                                                 |   24 
 tools/perf/tests/sample-parsing.c                                             |    5 
 tools/perf/ui/browser.c                                                       |    3 
 tools/perf/ui/browsers/annotate.c                                             |    5 
 tools/perf/util/Build                                                         |    1 
 tools/perf/util/annotate-data.c                                               |   27 
 tools/perf/util/arm-spe.c                                                     |   28 
 tools/perf/util/auxtrace.c                                                    |    3 
 tools/perf/util/bpf-event.c                                                   |   52 
 tools/perf/util/bpf-event.h                                                   |    4 
 tools/perf/util/bpf-utils.c                                                   |   16 
 tools/perf/util/build-id.c                                                    |    7 
 tools/perf/util/callchain.c                                                   |   15 
 tools/perf/util/callchain.h                                                   |    1 
 tools/perf/util/config.c                                                      |    4 
 tools/perf/util/cpumap.c                                                      |   49 
 tools/perf/util/cs-etm-base.c                                                 |    4 
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c                               |   21 
 tools/perf/util/cs-etm.c                                                      |  310 ++--
 tools/perf/util/cs-etm.h                                                      |    8 
 tools/perf/util/data-convert-json.c                                           |    1 
 tools/perf/util/debuginfo.c                                                   |    9 
 tools/perf/util/disasm.c                                                      |    7 
 tools/perf/util/dso.c                                                         |   48 
 tools/perf/util/dwarf-aux.c                                                   |   39 
 tools/perf/util/dwarf-aux.h                                                   |    5 
 tools/perf/util/env.h                                                         |   14 
 tools/perf/util/event.c                                                       |   15 
 tools/perf/util/header.c                                                      |   91 +
 tools/perf/util/hist.c                                                        |    9 
 tools/perf/util/hist.h                                                        |    1 
 tools/perf/util/hwmon_pmu.c                                                   |   36 
 tools/perf/util/intel-bts.c                                                   |    3 
 tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c                      |   11 
 tools/perf/util/intel-pt.c                                                    |   35 
 tools/perf/util/libdw.c                                                       |   49 
 tools/perf/util/machine.c                                                     |   42 
 tools/perf/util/maps.c                                                        |  148 +-
 tools/perf/util/maps.h                                                        |    3 
 tools/perf/util/mmap.c                                                        |   20 
 tools/perf/util/pmu.c                                                         |   10 
 tools/perf/util/probe-finder.c                                                |  102 -
 tools/perf/util/sample.h                                                      |    2 
 tools/perf/util/session.c                                                     |    5 
 tools/perf/util/srcline.c                                                     |    9 
 tools/perf/util/srcline.h                                                     |    1 
 tools/perf/util/svghelper.c                                                   |   10 
 tools/perf/util/symbol-elf.c                                                  |  121 +
 tools/perf/util/symbol-minimal.c                                              |   16 
 tools/perf/util/symbol.c                                                      |   19 
 tools/perf/util/symbol_conf.h                                                 |   10 
 tools/perf/util/synthetic-events.c                                            |   25 
 tools/perf/util/synthetic-events.h                                            |    6 
 tools/perf/util/thread.c                                                      |    5 
 tools/perf/util/tool.c                                                        |    6 
 tools/perf/util/unwind-libdw.c                                                |   20 
 tools/perf/util/unwind-libunwind-local.c                                      |   27 
 tools/perf/util/unwind-libunwind.c                                            |    2 
 tools/perf/util/unwind.c                                                      |  104 +
 tools/perf/util/unwind.h                                                      |   61 
 tools/power/x86/intel-speed-select/isst-daemon.c                              |    9 
 tools/testing/cxl/test/cxl.c                                                  |   10 
 tools/testing/cxl/test/cxl_translate.c                                        |    2 
 tools/testing/cxl/test/mem.c                                                  |   45 
 tools/testing/kunit/kunit_parser.py                                           |   12 
 tools/testing/selftests/Makefile                                              |    2 
 tools/testing/selftests/bpf/README.rst                                        |    2 
 tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c                        |   69 
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c                               |    6 
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c                       |    2 
 tools/testing/selftests/bpf/prog_tests/htab_update.c                          |    4 
 tools/testing/selftests/bpf/prog_tests/linked_list.c                          |   33 
 tools/testing/selftests/bpf/prog_tests/map_kptr.c                             |   10 
 tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_bad_access.c    |   57 
 tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c   |   43 
 tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c                      |    8 
 tools/testing/selftests/bpf/prog_tests/verifier.c                             |    2 
 tools/testing/selftests/bpf/prog_tests/verifier_log.c                         |    1 
 tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c                        |    2 
 tools/testing/selftests/bpf/progs/cpumask_success.c                           |    2 
 tools/testing/selftests/bpf/progs/file_reader.c                               |    2 
 tools/testing/selftests/bpf/progs/htab_update.c                               |    4 
 tools/testing/selftests/bpf/progs/linked_list.c                               |   71 +
 tools/testing/selftests/bpf/progs/refcounted_kptr.c                           |   20 
 tools/testing/selftests/bpf/progs/test_bpf_nf.c                               |   26 
 tools/testing/selftests/bpf/progs/test_tunnel_kern.c                          |   13 
 tools/testing/selftests/bpf/progs/verifier_bounds.c                           |   14 
 tools/testing/selftests/bpf/progs/verifier_ptr_to_buf.c                       |   27 
 tools/testing/selftests/bpf/progs/verifier_raw_tp_writable.c                  |   16 
 tools/testing/selftests/bpf/progs/xdp_flowtable.c                             |    7 
 tools/testing/selftests/bpf/vmtest.sh                                         |    2 
 tools/testing/selftests/drivers/net/hw/tso.py                                 |   16 
 tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc               |    2 
 tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc             |   14 
 tools/testing/selftests/gpio/.gitignore                                       |    1 
 tools/testing/selftests/hid/Makefile                                          |    2 
 tools/testing/selftests/hid/hid_bpf.c                                         |   36 
 tools/testing/selftests/hid/progs/hid.c                                       |   15 
 tools/testing/selftests/landlock/scoped_signal_test.c                         |  237 +++
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh                         |   45 
 tools/testing/selftests/mm/compaction_test.c                                  |    3 
 tools/testing/selftests/mm/hmm-tests.c                                        |  125 +
 tools/testing/selftests/mm/hugepage-mremap.c                                  |   32 
 tools/testing/selftests/mm/hugetlb_reparenting_test.sh                        |   60 
 tools/testing/selftests/mm/pkey-arm64.h                                       |    3 
 tools/testing/selftests/mm/run_vmtests.sh                                     |   66 
 tools/testing/selftests/mm/split_huge_page_test.c                             |   27 
 tools/testing/selftests/mm/uffd-stress.c                                      |    5 
 tools/testing/selftests/net/broadcast_ether_dst.sh                            |    2 
 tools/testing/selftests/net/lib.sh                                            |   25 
 tools/testing/selftests/net/netfilter/nft_flowtable.sh                        |    8 
 tools/testing/selftests/net/tcp_mmap.c                                        |    4 
 tools/testing/selftests/net/tls.c                                             |    8 
 tools/testing/selftests/net/vlan_bridge_binding.sh                            |    2 
 tools/testing/selftests/rseq/Makefile                                         |    6 
 tools/testing/selftests/vfio/Makefile                                         |    7 
 tools/testing/selftests/vfio/lib/libvfio.mk                                   |    6 
 tools/tracing/rtla/src/actions.c                                              |    2 
 tools/tracing/rtla/src/common.c                                               |   19 
 tools/tracing/rtla/src/common.h                                               |    1 
 tools/tracing/rtla/src/timerlat.c                                             |    2 
 tools/tracing/rtla/src/timerlat_hist.c                                        |    4 
 tools/tracing/rtla/src/timerlat_top.c                                         |    3 
 tools/virtio/vringh_test.c                                                    |    5 
 virt/kvm/kvm_main.c                                                           |   16 
 1924 files changed, 28042 insertions(+), 14440 deletions(-)

Aaradhana Sahu (1):
      wifi: ath12k: Fix invalid IRQ requests during AHB probe

Aaron Ma (2):
      ASoC: amd: acp-sdw-legacy: Bound DAI link iteration
      ASoC: amd: acp-sdw-sof: Bound DAI link iteration

Aaron Tomlin (2):
      libbpf: Report error when a negative kprobe offset is specified
      mips: sched: Fix CPUMASK_OFFSTACK memory corruption

Abd-Alrhman Masalkhi (9):
      md/raid1,raid10: fix deadlock in read error recovery path
      md/raid1,raid10: fix error-path detection with md_cloned_bio()
      md/raid1,raid10: fix bio accounting for split md cloned bios
      raid1: fix nr_pending leak in REQ_ATOMIC bad-block error path
      md/raid1: fix writes_pending and barrier reference leaks on write failures
      md/raid10: fix writes_pending leak on write request failures
      md/raid10: fix writes_pending and barrier reference leaks on discard failures
      md/raid1: honor REQ_NOWAIT when waiting for behind writes
      md/raid1: free r1_bio when REQ_NOWAIT is set and read would block on retry

Abdun Nihaal (18):
      crypto: safexcel - Fix potential memory leak in safexcel_pci_probe()
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

Abdurrahman Hussain (1):
      hwmon: (pmbus/core) honor vrm_version in pmbus_data2reg_vid()

Abel Vesa (4):
      arm64: dts: qcom: glymur-crd: Drop forced host mode for USB SS0 and SS1
      arm64: dts: qcom: glymur: Mark USB SS1 and SS2 as role-switch capable
      arm64: dts: qcom: eliza-mtp: Fix the debug UART index
      arm64: dts: qcom: hamoa: Fix OPP tables for all DisplayPort controllers

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

Adrian Hunter (11):
      i3c: mipi-i3c-hci: Fix suspend behavior when bus disable falls back to software reset
      i3c: mipi-i3c-hci: Preserve RUN bit when aborting DMA ring
      i3c: master: Make hot-join workqueue freezable to block hot-join during suspend
      i3c: master: Serialize i3c_set_hotjoin() with the maintenance lock
      i3c: master: Consolidate Hot-Join DAA work in the core
      i3c: master: Ensure Hot-Join operations are stopped on shutdown
      i3c: master: Defer new-device registration out of DAA caller context
      i3c: mipi-i3c-hci: Fix race in i3c_hci_addr_to_dev()
      i3c: master: Prevent reuse of dynamic address on device add failure
      i3c: master: Update dev_nack_retry_count under maintenance lock
      i3c: master: Add missing runtime PM get in dev_nack_retry_count_store()

Ahmad Fatoum (1):
      ASoC: cs530x: Fix expected MCLK rates for CS5302/4/8

Akhil P Oommen (2):
      drm/msm/a8xx: Make a8xx_recover IFPC safe
      drm/msm/a8xx: Fix RSCC offset

Akhil R (1):
      dt-bindings: dma: nvidia,tegra186-gpc-dma: Make reset optional

Al Viro (3):
      configfs_lookup(): don't leave ->s_dentry dangling on failure
      configfs: fix lockless traversals of ->s_children
      udf: fix nls leak on udf_fill_super() failure

Aldo Conte (1):
      iio: tcs3472: power down chip on probe failure

Aleksander Jan Bajkowski (2):
      crypto: eip93 - fix reset ring register definition
      crypto: inside-secure/eip93 - Add check for devm_request_threaded_irq

Aleksandr Loktionov (1):
      ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()

Aleksandr Nogikh (2):
      ocfs2: fix circular locking dependency in ocfs2_dio_end_io_write
      ieee802154: fix kernel-infoleak in dgram_recvmsg()

Aleksandrova Alyona (1):
      net: dsa: sja1105: round up PTP perout pin duration

Alex Deucher (1):
      drm/amdkfd: always resume_all after suspend_all

Alex Mastro (1):
      iommufd: Clarify IOAS_MAP_FILE dma-buf support

Alex Sierra (1):
      drm/amdkfd: fix redundant MQD iterations in GFX v12.1

Alexander Aring (1):
      dlm: fix add msg handle in send_queue ordered

Alexander Chesnokov (1):
      RDMA/hns: Fix arithmetic overflow in calc_hem_config()

Alexander Koskovich (1):
      arm64: dts: qcom: milos: Reduce rmtfs_mem size to 2.5MiB

Alexander Potapenko (1):
      lib/test_meminit: use && for bools

Alexander Stein (1):
      arm64: dts: tqma8mpql-mba8mpxl: configure sai clock in audio codec as well

Alexandru Gagniuc (1):
      remoteproc: qcom_q6v5_wcss: drop redundant wcss_q6_bcr_reset

Alexandru Hossu (1):
      staging: nvec: fix use-after-free in nvec_rx_completed()

Alexei Starovoitov (1):
      bpf: Take mmap_lock in zap_pages()

Alexey Charkov (1):
      power: supply: bq257xx: Fix VSYSMIN clamping logic

Alexey Kardashevskiy (1):
      crypto: ccp/tsm - Enable the root port after the endpoint

Ali Ahmet MEMIS (1):
      tools/power/x86/intel-speed-select: Harden daemon pidfile open

Alice Guo (1):
      arm64: dts: imx94: fix DDR PMU interrupt number

Alice Mikityanska (1):
      geneve: Fix off-by-one comparing with GRO_LEGACY_MAX_SIZE

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

Andreas Kemnade (2):
      wifi: wlcore: enable the right set of ciphers
      gpios: palmas: add .get_direction() op

Andrew Morton (1):
      security/apparmor/apparmorfs.c: conditionally compile get_loaddata_common_ref()

André Draszik (1):
      dma-fence: use correct callback in dma_fence_timeline_name()

Andy Shevchenko (2):
      phy: phy-can-transceiver: Check driver match and driver data against NULL
      ACPI: resource: Amend kernel-doc style

Angelo Dureghello (1):
      m68k: mcf5441x: fix clocks numbering

AngeloGioacchino Del Regno (1):
      pmdomain: mediatek: Fix possible nullptr KP in HWV cleanup/on-check

Ankit Garg (1):
      gve: fix header buffer corruption with header-split and HW-GRO

Ankit Soni (1):
      iommufd: Take dma_resv lock before dma_buf_unpin() in release path

Anshuman Khandual (1):
      arm64/mm: Optimize TLB flush in unmap_hotplug_[pmd|pud]_range()

Antoine Tenart (1):
      libbpf: Fix deduplication of typedef with base definitions

Antoni Pokusinski (1):
      rtc: abx80x: fix the RTC_VL_CLR clearing all status flags

Antony Antony (1):
      xfrm: fix NAT-related field inheritance in SA migration

Ao Sun (1):
      mmc: block: fix RPMB device unregister ordering

Ariana Lazar (1):
      iio: dac: mcp47feb02: Fix passing uninitialized vref1_uV for no Vref1 case

Armin Wolf (1):
      leds: uleds: Fix potential buffer overread

Arnaldo Carvalho de Melo (81):
      perf header: Sanity check HEADER_EVENT_DESC attr.size before swap
      perf header: Validate bitmap size before allocating in do_read_bitmap()
      perf tools: Guard test_bit from out-of-bounds sample CPU
      perf sched: Fix thread reference leak in latency_switch_event
      perf sample: Add file_offset field to struct perf_sample
      perf sched: Replace BUG_ON on invalid CPU with graceful skip
      perf sched: Fix NULL dereference in latency_runtime_event
      perf sched: Fix comp_cpus heap overflow with cross-machine recordings
      perf tools: Guard remaining test_bit calls from OOB sample CPU
      perf tools: Add bounds check to cpu__get_node()
      perf sched: Fix thread reference leaks in timehist_get_thread()
      perf sched: Cap max_cpu at MAX_CPUS in timehist sample processing
      perf sched: Fix register_pid() overflow, strcpy, and BUG_ON
      perf mmap: Guard cpu__get_node() return in aio_bind()
      perf stat: Bounds-check CPU index in topology aggregation callbacks
      perf c2c: Bounds-check CPU and node IDs before bitmap and array access
      perf c2c: Bounds-check CPU IDs in setup_nodes() topology loop
      perf sched: Clean up idle_threads entry on init failure
      perf sched: Use is_idle_sample() for idle thread runtime cast guard
      perf sched: Fix thread reference leak in idle hist processing
      perf sched: Use thread__put() in free_idle_threads()
      perf sched: Replace BUG_ON and add NULL checks in replay event helpers
      perf mmap: Fix NULL deref in aio cleanup on alloc failure
      perf stat: Introduce perf_env__get_cpu_topology() to guard NULL env->cpu
      perf c2c: Fix use-after-free in he__get_c2c_hists() error path
      perf timechart: Fix cpu2y() OOB read on untrusted CPU index
      perf tools: Fix int16_t truncation of max_cpu_num in set_max_cpu_num()
      perf sched: Free callchain nodes in idle thread cleanup
      perf tools: Fix get_max_num() size_t underflow on empty sysfs file
      perf tools: Use scnprintf() in cpu_map__snprint() to prevent overflow
      perf tools: Use perf_env__get_cpu_topology() in machine__resolve()
      perf tools: NULL bitmap pointers after bitmap_free()
      perf sched: Bounds-check prio before test_bit() in timehist
      perf sched: Fix idle-hist callchain display using wrong rb_first variant
      perf tools: Add O_CLOEXEC to open() calls in DSO and ELF code
      perf bpf: Use scnprintf() in snprintf_hex() and synthesize_bpf_prog_name()
      perf hists: Fix snprintf() in hists__scnprintf_title() UID filter path
      perf tools: Use scnprintf() in build_id__snprintf() and hwmon read_events()
      perf pmu: Fix pmu_id() heap underwrite on empty identifier file
      perf pmu: Fix perf_pmu__parse_scale/unit() OOB access on empty sysfs file
      tools lib api: Fix missing null termination in filename__read_int/ull()
      perf symbols: Fix signed overflow in sysfs__read_build_id() size check
      perf symbols: Bounds-check .gnu_debuglink section data
      perf tools: Use mkostemp() for O_CLOEXEC on temporary files
      perf intel-pt: Fix snprintf size tracking bug in insn decoder
      perf tools: Fix thread__set_comm_from_proc() on empty comm file
      perf hwmon: Fix off-by-one null termination on sysfs reads
      perf hwmon: Use scnprintf() in hwmon_pmu__for_each_event()
      perf hwmon: Fix parse_hwmon_filename() strlcpy buffer overflow
      perf symbols: Bounds-check descsz in sysfs__read_build_id() GNU fallback
      perf tools: Fix uninitialized pathname on uncompressed fallback in filename__decompress()
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
      perf dso: Fix heap overflow in dso__get_filename() on decompressed path
      perf dso: Set error code when open() fails on uncompressed fallback path
      perf tools: Use snprintf() for root_dir path construction
      perf hwmon: Fix fd check to accept fd 0 in hwmon_pmu__describe_items()
      perf sched: Replace (void*)1 sentinel with proper runtime allocation
      perf bpf: Validate func_info_rec_size and sub_id in synthesize_bpf_prog_name()
      perf bpf: Reject oversized BPF metadata events that truncate header.size
      perf bpf: Bounds-check array offsets in bpil_offs_to_addr()
      perf c2c: Free format list entries when releasing c2c hist entries
      perf cs-etm: Reject CPU IDs that would overflow signed comparison
      perf machine: Use snprintf() for guestmount path construction
      perf cs-etm: Validate num_cpu before metadata allocation
      perf cs-etm: Require full global header in auxtrace_info size check
      perf cs-etm: Bounds-check CPU in cs_etm__get_queue()
      perf c2c: Free format list entries when c2c_hists__init() fails
      perf c2c: Fix hist entry and format list leaks in c2c_he_free()
      perf bpf: Validate array presence before casting BPF prog info pointers
      perf dso: Set standard errno on decompression failure

Arnd Bergmann (7):
      firmware: samsung: acpm: remove compile-testing stubs
      RDMA/hfi1: Open-code rvt_set_ibdev_name()
      vduse: fix compat handling for VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
      ASoC: SOF: Intel: select SND_SOC_SDW_UTILS=y from SND_SOC_SOF_HDA_GENERIC=y
      ASoC: SOF: Intel: hda-sdw-bpt: select SND_SOF_SOF_HDA_SDW_BPT properly
      ntfs3: avoid another -Wmaybe-uninitialized warning
      arm64: static_call: include asm/insns.h

Arseniy Krasnov (1):
      mtd: rawnand: fix condition in 'nand_select_target()'

Arunpravin Paneer Selvam (1):
      gpu/buddy: bail out of try_harder when alignment cannot be honoured

Ashish Mhetre (1):
      memory: tegra: Wire up system sleep PM ops

Asim Viladi Oglu Manizada (1):
      net: openvswitch: reject oversized nested action attrs

Athira Rajeev (1):
      powerpc tools perf: Initialize error code in auxtrace_record_init function

Atish Patra (1):
      KVM: SEV: Do not allow intra-host migration/mirroring of SNP VMs

Aurelien Jarno (3):
      riscv: dts: spacemit: set console baud rate on Milk-V Jupiter
      riscv: dts: spacemit: fix uboot partition offset on Milk-V Jupiter
      arch/riscv: vdso: remove CFI landing pad from rt_sigreturn

Aviel Zohar (1):
      wifi: mt76: mt7925: validate skb length in testmode query

Avinash Duduskar (1):
      bpf: zero-initialize the fib lookup flow struct

Baineng Shou (1):
      dma-fence: Make dma_fence_dedup_array() robust against 0-count input

Balakrishnan Sambath (1):
      watchdog: sama5d4_wdt: Fix WDDIS detection on SAM9X60 and SAMA7G5

Baochen Qiang (1):
      wifi: ath12k: fix EAPOL TX failure caused by stale tcl_metadata bits

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

Bartosz Golaszewski (6):
      powerpc/8xx: implement get_direction() in cpm1
      PCI/pwrctrl: Lock device when calling device_is_bound()
      power: sequencing: fix ABBA deadlock in pwrseq_device_unregister()
      gpio: shared: make the voting mechanism adaptable
      mfd: tps6586x: Fix OF node refcount
      device property: initialize the remaining fields of fwnode_handle in fwnode_init()

Baruch Siach (1):
      docs: threat-model: add missing closing parenthesis

Bastien Curutchet (1):
      mtd: rawnand: pl353: fix probe resource allocation

Ben Dooks (2):
      tracing: Make tracepoint_printk static as not exported
      drm/imagination: make pvr_fw_trace_init_mask_ops static

Benjamin Coddington (1):
      NFS: Charge unstable writes by request size, not folio size

Benjamin Marzinski (1):
      dm-log: fix a bitset_size overflow on 32bit machines

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

Binbin Wu (1):
      KVM: TDX: Reject concurrent change to CPUID entry count

Biswapriyo Nath (1):
      dt-bindings: clock: qcom,sm6125-dispcc: reference qcom,gcc.yaml

Bjoern A. Zeeb (1):
      wifi: mt76: fix argument to ieee80211_is_first_frag()

Boris Brezillon (8):
      drm/panthor: Always use the IRQ-safe variant when acquiring the fence lock
      drm/panthor: Keep the reset work disabled until everything is initialized
      drm/panthor: Fix potential invalid pointer deref in group_process_tiler_oom()
      drm/panthor: Fix theoretical IOMEM access in suspended state
      drm/panthor: Don't overrule pending immediate ticks in sched_resume_tick()
      drm/panthor: Fix panthor_pwr_unplug()
      drm/panthor: Fix a leak when a group is evicted before the tiler OOM is serviced
      drm/panthor: Interrupt group start/resumption if group_bind_locked() fails

Bradley Morgan (4):
      bpf: Disable xfrm_decode_session hook attachment
      KVM: arm64: account pKVM reclaim against the VM mm
      cpu: hotplug: Preserve per instance callback errors
      cpu: hotplug: Bound hotplug states sysfs output

Brajesh Gupta (1):
      drm/imagination: Fix returned size for DRM_IOCTL_PVR_DEV_QUERY

Breno Leitao (5):
      workqueue: forbid TEST_WORKQUEUE from being built-in
      workqueue: drop spurious '*' from print_worker_info() fn declaration
      netconsole: don't drop the last byte of a full-sized message
      arm64/hw_breakpoint: reject unaligned watchpoints that would truncate BAS
      9p: skip nlink update in cacheless mode to fix WARN_ON

Brett Creeley (1):
      ionic: Fix check in ionic_get_link_ext_stats

Brian Norris (4):
      ARM: dts: rockchip: Add #{address,size}-cells to Chromium-based /firmware
      arm64: dts: rockchip: Add #{address,size}-cells to Chromium-based /firmware
      ARM: tegra: Add #{address,size}-cells to Chromium-based /firmware
      arm64: tegra: Add #{address,size}-cells to Chromium-based /firmware

Bryam Vargas (15):
      wifi: mac80211: bound S1G TIM PVB walk to the TIM element
      ntfs: validate resident attribute lists and harden the validator
      ntfs: bound the look-ahead attribute-list entry in ntfs_external_attr_find()
      ntfs: bound the attribute-list entry in ntfs_read_inode_mount()
      ntfs: fix u16 truncation of restart-area length check
      landlock: Fix LANDLOCK_SCOPE_SIGNAL bypass on the SIGIO path
      selftests/landlock: Test SCOPE_SIGNAL on the SIGIO/fowner pgid path
      nvmet-rdma: handle inline data with a nonzero offset
      scsi: target: Bound PR-OUT TransportID parsing to the received buffer
      scsi: target: core: Fix iSCSI ISID use-after-free in REGISTER AND MOVE
      net/sched: sch_multiq: Replace direct dequeue call with peek and qdisc_dequeue_peeked
      net/sched: sch_taprio: Replace direct dequeue call with peek and qdisc_dequeue_peeked
      orangefs: keep the readdir entry size 64-bit in fill_from_part()
      ata: libata-core: Add NOLPM quirk for PNY CS900 1TB SSD
      ata: libata-core: Reject an invalid concurrent positioning ranges count

Cao Guanghui (1):
      dm era: fix NULL pointer dereference in metadata_open()

Cao Ruichuang (1):
      selftests/ftrace: Drop invalid top-level local in test_ownership

Carlos Bilbao (1):
      PCI/ASPM: Don't reconfigure ASPM entering low-power state

Carlos Llamas (1):
      libbpf: Fix UAF in strset__add_str()

Carlos Song (1):
      spi: imx: replace dmaengine_terminate_all() with dmaengine_terminate_sync()

Catalin Marinas (1):
      arm64: Avoid eager DVMSync reclaim batches with C1-Pro SME erratum

Cen Zhang (9):
      btrfs: annotate lockless read of defrag_bytes in should_nocow()
      ALSA: seq: oss: Serialize readq reset state with q->lock
      ALSA: seq: avoid stale FIFO cells during resize
      ALSA: usb-audio: Kill MIDI 2.0 URBs before freeing endpoints
      ntfs: avoid stale runlist element dereference in MFT writeback
      ntfs: avoid stale runlist element dereference in fallocate
      Bluetooth: 6lowpan: avoid untracked enable work
      Bluetooth: 6lowpan: hold L2CAP conn across debugfs control
      Bluetooth: MGMT: Fix adv monitor add failure cleanup

Chancel Liu (1):
      ASoC: dapm: Fix widget lookup with prefixed names across DAPM contexts

Chandrashekar Devegowda (1):
      Bluetooth: btintel_pcie: Support Product level reset

Chanwoo Lee (1):
      scsi: ufs: Fix wrong value printed in unexpected UPIU response case

Chao Yu (1):
      f2fs: fix potential deadlock in gc_merge path of f2fs_balance_fs()

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

Chen-Yu Tsai (6):
      dt-bindings: media: sun4i-a10-video-engine: Add interconnect properties
      pinctrl: mediatek: eint: Drop base from mtk_eint_chip_write_mask()
      arm64: dts: mediatek: mt8192-asurada: Move PCIe DMA bounce buffer to host
      regulator: dt-bindings: mt6359: Drop regulator-name pattern restrictions
      PCI: mediatek-gen3: Do full device power down on removal
      PCI: mediatek-gen3: Fix incorrectly skipped pwrctrl error message

ChenXiaoSong (1):
      smb: move compression definitions into common/fscc.h

Chia-Lin Kao (AceLan) (1):
      ASoC: sdw_utils: fix missing component_name for cs42l43 part_id 0x2A3B

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

Christian Borntraeger (1):
      KVM: s390: Initialize KVM_S390_GET_CMMA_BITS memory

Christian Brauner (10):
      rhashtable: give each instance its own lockdep class
      eventpoll: rename attach_epitem() to ep_attach_file()
      eventpoll: split ep_insert() into alloc + register stages
      eventpoll: extract ep_deliver_event() from ep_send_events()
      eventpoll: wrap EP_UNACTIVE_PTR in typed sentinel helpers
      kernfs: link kn to its parent before the LSM init hook
      filelock: fix break_lease() stub signature for CONFIG_FILE_LOCKING=n
      eventpoll: expand top-of-file overview / locking doc
      eventpoll: rename epi->next and txlist for clarity
      fs: refuse O_TMPFILE creation with an unmapped fsuid or fsgid

Christian Fontanez (1):
      virtio: add missing kernel-doc for map and vmap members

Christian Marangi (1):
      net: ethernet: mtk_eth_soc: fix supported_interface set after phylink_create

Christoph Hellwig (4):
      iomap: pass the correct len to fserror_report_io in __iomap_write_begin
      xfs: factor out a xfs_zone_mark_free helper
      xfs: add newly added RTGs to the free pool in growfs
      iomap: consolidate bio submission

Christos Longros (1):
      wifi: rtw89: fix wrong pci_get_drvdata type in AER handlers

Chuck Lever (23):
      NFSD: Fix delegation reference leak in nfsd4_revoke_states
      NFSD: Handle layout stid in nfsd4_drop_revoked_stid()
      lockd: Stop warning on nlm__int__drop_reply in !V4 cast_status
      lockd: Translate nlm__int__deadlock in __nlm4svc_proc_lock_msg()
      lockd: Do not monitor when looking up the LOCK_MSG callback host
      lockd: Avoid hashing uninitialized bytes in nlm4svc_lookup_file()
      handshake: Require admin permission for DONE command
      xprtrdma: Use sendctx DMA state for Send signaling
      xprtrdma: Decouple req recycling from RPC completion
      lockd: Correct kernel-doc status descriptions for NLMv4 GRANTED
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

Cihan Karadag (1):
      selftests: gpio: add gpio-cdev-uaf to .gitignore

Clark Wang (1):
      nfs: keep PG_UPTODATE clear after read errors in page groups

Claudio Imbrenda (6):
      s390/mm: Fix handling of _PAGE_UNUSED pte bit
      KVM: s390: vsie: Fix allocation of struct vsie_rmap
      KVM: s390: vsie: Add missing radix_tree_preload() in _gaccess_shadow_fault()
      KVM: s390: Silence potential warnings in _gmap_crstep_xchg_atomic()
      KVM: s390: vsie: Use mmu cache to allocate rmap
      KVM: s390: Fix unlikely race in try_get_locked_pte()

Claudiu Beznea (3):
      pinctrl: renesas: rzg2l: Use -ENOTSUPP instead of -EOPNOTSUPP
      dmaengine: sh: rz-dmac: Fix incorrect NULL check for list_first_entry()
      dmaengine: sh: rz-dmac: Move interrupt request after everything is set up

Connor Williamson (1):
      block: remove redundant GD_NEED_PART_SCAN in add_disk_final()

Conor Dooley (8):
      dts: spacemit: set console baud rate on bpif3
      riscv: dts: microchip: gpio controllers on mpfs need 2 interrupt cells
      riscv: dts: microchip: remove gpio hogs from beaglev-fire
      riscv: dts: microchip: update pic64gx gpio interrupts to better match the SoC
      riscv: dts: microchip: fix pic64gx gpio interrupt-cells
      mailbox: mpfs: fix check for syscon presence in mpfs_mbox_inbox_isr()
      clk: microchip: mpfs-ccc: fix peripheral driver registration failures after oob fix
      rtc: mpfs: fix counter upload completion condition

Conor Kotwasinski (1):
      kernfs: fix suspicious RCU usage in kernfs_put()

Corey Leavitt (1):
      net: pse-pd: scope pse_control regulator handle to kref lifetime

Cosmin Ratiu (2):
      devlink: Fix parent ref leak in devl_rate_node_create()
      devlink: Fix parent ref leak on tc-bw failure

Costa Shulyupin (1):
      tools/rtla: Fix --dump-tasks usage in timerlat

Cristian Ciocaltea (5):
      drm/rockchip: inno-hdmi: Switch to drmm_kzalloc()
      drm/rockchip: dw_dp: Switch to drmm_kzalloc()
      drm/rockchip: dw_dp: Fix null-ptr-deref in dw_dp_remove()
      arm64: dts: rockchip: Fix vdec register blocks order on RK3576
      arm64: dts: rockchip: Update vdec register blocks order on RK3588

Cristian Marussi (1):
      clk: scmi: Fix clock rate rounding

Crystal Wood (2):
      rtla: Stop the record trace on interrupt
      tracing/osnoise: Call synchronize_rcu() when unregistering

Cássio Gabriel (15):
      ASoC: mediatek: mt8189: Fix probe resource cleanup
      ALSA: xen-front: Reset event channel state on stream clear
      ALSA: xen-front: Connect event channel after stream prepare
      ALSA: usb-audio: qcom: Initialize offload control return value
      ALSA: pcm: Fix unlocked runtime state reads in xfer ioctls
      ASoC: sma1307: Fix uevent string leaks in fault worker
      ASoC: topology: Check PCM and DAI name strings before use
      ALSA: usb-audio: qcom: Guard sideband endpoint removal
      ASoC: SOF: topology: validate vendor array size before parsing
      ASoC: mediatek: mt8192: Check runtime resume during probe
      ASoC: mediatek: mt8192: Release reserved memory on cleanup
      ASoC: mediatek: mt8183: Check runtime resume during probe
      ASoC: mediatek: mt8183: Release reserved memory on cleanup
      firmware_loader: Add cancel helper for async requests
      ALSA: hda/tas2781: Cancel async firmware request at unbind

DaeMyung Kang (12):
      ntfs: free link name from ntfs_name_cache
      ntfs: grow index root value before reparent header update
      ntfs: validate attribute values on lookup
      ntfs: free volume-wide resources on fill_super failure
      ntfs: update index root allocated size before shrink
      ntfs: reinit search context before volume information lookup
      ntfs: only alias volume $UpCase to default on exact match
      ntfs: avoid heap allocation for free-cluster readahead state
      ntfs: do not replace volume name after lookup errors
      ntfs: validate resident volume name values on lookup
      ntfs: validate resident index root values on lookup
      ntfs: reject non-resident records for resident-only attributes

Daehyeon Ko (1):
      macsec: don't read an unset MAC header in macsec_encrypt()

Dai Ngo (1):
      NFSv4/pnfs: defer return_range callbacks until after inode unlock

Damian Muszynski (1):
      crypto: qat - fix heartbeat error injection

Damien Laine (1):
      ALSA: hda/realtek: Fix speakers on Legion Pro 7 16ARX8H with codec SSID 17aa:38a7

Damon Ding (1):
      drm/bridge: analogix_dp: Fix PE/VS value shift mismatch during link training

Dan Carpenter (4):
      rapidio/tsi721: prevent a bad dereference in tsi721_db_dpc()
      scsi: pm8001: Fix error code in non_fatal_log_show()
      PCI: dwc: Fix signedness bug in fault injection test code
      afs: Fix error code in afs_extract_vl_addrs()

Dan Williams (5):
      cxl/fwctl: Fix __fortify_panic
      cxl/test: Fix __fortify_panic
      cxl/region: Block region delete during region creation
      cxl/region: Resolve region deletion races
      cxl/memdev: Pin parents for entire memdev lifetime

Daniel Borkmann (8):
      libbpf: Skip hash computation when loader generation failed
      libbpf: Skip endianness swap when loader generation failed
      bpf: Reject exclusive maps as inner maps in map-in-map
      libbpf: Skip initial_value override on signed loaders
      libbpf: Skip max_entries override on signed loaders
      bpf: Reject exclusive maps for bpf_map_elem iterators
      bpf: Tighten cgroup storage cookie checks for prog arrays
      net: Stop leased rxq before uninstalling its memory provider

Daniel Gibson (5):
      platform/x86/amd/pmc: Check for intermediate wakeup in function
      platform/x86/amd/pmc: Delay suspend for some Lenovo Laptops
      platform/x86/amd/pmc: Add delay_suspend module parameter
      platform/x86/amd/pmc: Don't log during intermediate wakeups
      platform/x86/amd/pmc: Avoid logging "(null)" for DMI values

Daniel Golle (2):
      net: dsa: mxl862xx: avoid unaligned 16-bit access in api_wrap
      net: dsa: mxl862xx: fix use-after-free of DSA ports in crc_err_work

Daniel Palmer (2):
      tools/nolibc: getopt: Fix potential out of bounds access
      tools/nolibc: stackprotector: Avoid stalling program startup if crng is not init yet

Daniel Zahka (1):
      eth: fbnic: take netif_addr_lock_bh() around rx mode address programming

Danila Chernetsov (1):
      ext2: fix ignored return value of generic_write_sync()

Danilo Krummrich (8):
      driver core: use READ_ONCE() for dev->driver in dev_has_sync_state()
      driver core: Fix missing jiffies conversion in deferred_probe_extend_timeout()
      driver core: Guard deferred probe timeout extension with delayed_work_pending()
      rust: devres: add 'static bound to Devres<T>
      amba: use generic driver_override infrastructure
      cdx: use generic driver_override infrastructure
      Drivers: hv: vmbus: use generic driver_override infrastructure
      rpmsg: use generic driver_override infrastructure

Dave Jiang (7):
      cxl/pci: Fix the incorrect check of pci_read_config_word() return
      cxl/pci: Convert PCIBIOS errors to errno on DVSEC config accesses
      cxl/test: Verify cmd->size_in before accessing payload
      cxl/test: Fix integer overflow in mock LSA bounds checks
      cxl/test: Zero out LSA backing memory to avoid leaking to user
      cxl/test: Unregister cxl_acpi in cxl_test_init() error path
      cxl/test: Add check after kzalloc() memory in alloc_mock_res()

Dave Penkler (1):
      gpib: Fix inappropriate ioctl error return

David Carlier (2):
      netfilter: flowtable: avoid num_encaps underflow on bridge VLAN untag
      netfilter: nfnl_cthelper: apply per-class values when updating policies

David Disseldorp (1):
      scsi: target: Fix hexadecimal CHAP_I handling

David E. Box (1):
      platform/x86/intel/vsec: Restore BAR fallback for header walk

David Gow (1):
      kunit:tool: Don't write to stdout when it should be disabled

David Heidelberg (4):
      arm64: dts: qcom: sdm845-oneplus: Drop address from framebuffer node
      arm64: dts: qcom: sdm845-shift-axolotl: Correct touchscreen sleep state
      drm/panel: Clean up S6E3FC2X01 config dependencies
      drm/panel: Clean up S6E3HA2 config dependencies and fill help text

David Howells (34):
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
      afs: Remove setting of AS_RELEASE_ALWAYS for symlinks and mountpoints
      afs: Fix directory inode initialisation order
      afs: Fix bulk lookup malfunction due to change in dir_emit() API
      afs: Fix misplaced inc of net->cells_outstanding
      afs: Fix reinitialisation of the inode, in particular ->lock_work
      afs: Fix callback service message parsers to pass through -EAGAIN
      afs: Fix missing NULL pointer check in afs_break_some_callbacks()
      afs: Use scoped_seqlock_read() rather than manually doing seqlock stuff
      afs: Fix leak of ungot volume
      afs: Fix vllist leak
      afs: Fix lack of locking around modifications of net->cells_dyn_ino
      afs: Fix premature cell exposure through /afs
      afs: Fix the volume AFS_VOLUME_RM_TREE is set on
      afs: Fix unchecked-length string display in debug statement
      netfs: Fix netfs_create_write_req() to handle async cache object creation
      cachefiles: Fix file burial to take lock when unsetting S_KERNEL_FILE
      netfs: Fix writethrough to use collection offload
      netfs: Fix writeback error handling
      netfs: Fix folio state after ENOMEM whilst under writeback iteration
      cifs: Fix missing credit release on failure in cifs_issue_read()
      netfs: Fix barriering when walking subrequest list

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

David Matlack (4):
      vfio: selftests: Allow builds when ARCH=x86
      liveupdate: Use refcount_t for FLB reference counts
      liveupdate: Reference count incoming FLB data
      vfio: selftests: Ensure libvfio output dirs are always created

David Windsor (2):
      bpf: Reject sleepable BPF_LSM_CGROUP programs at load time
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

Dev Jain (1):
      fs/proc/task_mmu: do not warn on seeing non-migration pmd entry

Dexuan Cui (2):
      net: mana: Validate the packet length reported by the NIC
      net: mana: Sync page pool RX frags for CPU

Di Shen (1):
      OPP: Fix race between OPP addition and lookup

Diederik de Haas (1):
      arm64: dts: rockchip: Fix gmac0 reset pin for NanoPi R5S

Dillon Varone (1):
      drm/amd/display: Fix Color Manager (3DLUT, Shaper, Blend)

Dima Ruinskiy (1):
      e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake

Dmitry Antipov (1):
      ocfs2: fix buffer head management in ocfs2_read_blocks()

Dmitry Baryshkov (4):
      media: iris: scale MMCX power domain on SM8250
      media: venus: scale MMCX power domain on SM8250
      drm/msm/mdss: correct UBWC programming sequences
      Revert "media: venus: hfi_platform: Correct supported codecs for sc7280"

Dmitry Safonov (1):
      tcp: Decrement tcp_md5_needed static branch

Dmitry Torokhov (12):
      Input: ims-pcu - fix use-after-free and double-free in disconnect
      Input: ims-pcu - only expose sysfs attributes on control interface
      Input: ims-pcu - release data interface on disconnect
      Input: ims-pcu - validate control endpoint type
      Input: ims-pcu - add response length checks
      Input: ims-pcu - fix DMA mapping violation in line setup
      Input: ims-pcu - fix firmware leak in async update
      Input: ims-pcu - fix logic error in packet reset
      Input: ims-pcu - fix out-of-bounds read in ims_pcu_irq() debug logging
      Input: ims-pcu - fix potential infinite loop in CDC union descriptor parsing
      Input: ims-pcu - fix race condition in reset_device sysfs callback
      Input: ims-pcu - fix type confusion in CDC union descriptor parsing

Dmitry Vyukov (1):
      firmware_loader: Fix recursive lock in device_cache_fw_images()

Doehyun Baek (1):
      Docs/driver-api/uio-howto: document mmap_prepare callback

Dong Chenchen (1):
      xfrm: Fix dev use-after-free in xfrm async resumption

Dong Yibo (1):
      net: rnpgbe: fix mailbox endianness and remove pointer casts

Doruk Tan Ozturk (3):
      accel/amdxdna: reject command submission on devices without a submit op
      accel/amdxdna: reject user command submission without a command BO
      net/mlx5e: macsec: fix use-after-free of metadata_dst on RX SC delete

Dragos Tatulea (1):
      net/mlx5: Check max_macs devlink param value against max capability

Duje Mihanović (2):
      arm64: dts: marvell: samsung-coreprimevelte: Increase touchscreen voltage
      backlight: ktd2801: Enable BL_CORE_SUSPENDRESUME

Dust Li (1):
      dibs: loopback: validate offset and size in move_data()

Dylan Eskew (1):
      wifi: mt76: mt7996: limit work in set_bitrate_mask

Eckhart Mohr (1):
      ALSA: hda/realtek: Add quirk for TongFang X6xx45xU

Eduardo Vasconcelos (1):
      apparmor: Fix inverted comparison in cache_hold_inc()

Edward Adam Davis (3):
      hfsplus: Remove the duplicate attr inode dirty marking action
      hfsplus: Add a sanity check for btree node size
      fs/ntfs3: prevent potential lcn remains uninitialized

Enric Balletbo i Serra (1):
      clocksource: move NXP timer selection to drivers/clocksource

Enrico Pozzobon (1):
      net: usb: lan78xx: disable VLAN filter in promiscuous mode

Eric Biggers (4):
      crypto: sun4i-ss - Remove insecure and unused rng_alg
      fscrypt: Replace mk_users keyring with simple list
      crypto: aes - Fix conditions for selecting MAC dependencies
      crypto: xilinx-trng - Remove crypto_rng interface

Eric Dumazet (22):
      net/sched: sch_hfsc: annotate data-races in hfsc_dump_class_stats()
      net/sched: add qdisc_qlen_inc() and qdisc_qlen_dec()
      net/sched: sch_dualpi2: annotate data-races in dualpi2_dump_stats()
      net/sched: sch_htb: do not change sch->flags in htb_dump()
      net/sched: sch_htb: annotate data-races (I)
      net/sched: sch_drr: annotate data-races around cl->deficit
      ipv6: guard against possible NULL deref in __in6_dev_stats_get()
      net: watchdog: fix refcount tracking races
      tipc: fix UAF in tipc_l2_send_msg()
      tcp: ipv6: clamp default adverting MSS to avoid GSO_BY_FRAGS (0xFFFF)
      net: serialize netif_running() check in enqueue_to_backlog()
      xfrm: annotate data-races around xfrm_policy_count[] and xfrm_policy_default[]
      xfrm: validate selector family and prefixlen during match
      net: do not acquire dev->tx_global_lock in netdev_watchdog_up()
      veth: fix NAPI leak in XDP enable error path
      net: udp_tunnel: prevent double queueing in udp_tunnel_nic_device_sync
      tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
      tipc: avoid busy looping in tipc_exit_net()
      amt: fix size calculation in amt_get_size()
      ipv4: igmp: Fix potential UAF in igmp_gq_start_timer()
      ipv6: mcast: Fix potential UAF in MLD delayed work
      ipv4: igmp: Fix potential memory leaks in igmp_mod_timer() and igmp_stop_timer()

Erni Sri Satya Vennela (1):
      net: mana: Fall back to standard MTU when PF reports adapter_mtu of 0

Ethan Nelson-Moore (1):
      powerpc/uaccess: correct check for CONFIG_PPC_E500 in mask_user_address()

Fan Wu (1):
      can: esd_usb: kill anchored URBs before freeing netdevs

Farhad Alemi (1):
      cgroup/cpuset: rebind mm mempolicy to effective_mems, not mems_allowed

Felix Fietkau (1):
      wifi: mt76: mt7996: add missing max_remain_on_channel_duration

Felix Gu (15):
      soc: fsl: qe_ports_ic: Add missing cleanup on device removal
      accel/amdxdna: Fix memory leak in amdxdna_iommu_alloc()
      spi: atcspi200: fix use-after-free when driver unbind
      pinctrl: pinconf-generic: fix properties bitmap leak in parse_fw_cfg()
      watchdog: sprd_wdt: Remove redundant sprd_wdt_disable() on register failure
      pinctrl: sunxi: fix regulator leak in sunxi_pmx_request() error path
      gpu: host1x: mipi: Fix device_node reference leak in tegra_mipi_request()
      drm/tegra: dc: Fix device node reference leak in tegra_dc_has_output()
      spi: atmel: fix DMA channel and bounce buffer leaks
      spi: ep93xx: fix double-free of zeropage on DMA setup failure
      crypto: marvell/octeontx - fix DMA cleanup using wrong loop index
      crypto: cavium/cpt - fix DMA cleanup using wrong loop index
      phy: freescale: phy-fsl-imx8qm-lvds-phy: Use synchronous PM runtime put in reset
      phy: freescale: phy-fsl-imx8qm-lvds-phy: Fix missing pm_runtime_disable() on probe error path
      spi: rzv2h-rspi: Fix DMA transfer error handling for signal interruption

Feng Liu (3):
      net/mlx5e: Fix HV VHCA stats zero-sized buffer allocation
      net/mlx5e: Fix HV VHCA stats agent registration race
      net/mlx5e: Fix publication race for priv->channel_stats[]

Feng Wu (1):
      netfilter: xt_rateest: fix u64 truncation in xt_rateest_mt()

Fengnan Chang (2):
      dm: limit target bio polling to one shot
      iomap: release pages on atomic dio size mismatch

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

Florian Eckert (3):
      PCI: intel-gw: Move interrupt enable to own function
      PCI: intel-gw: Enable clock before PHY init
      PCI: intel-gw: Add .start_link() callback

Florian Fuchs (2):
      mtd: maps: vmu-flash: fix fault in unaligned fixup
      mtd: maps: vmu-flash: fix NULL pointer dereference in initialization

Florian Schmaus (1):
      selftests: Fix Makefile target for nsfs

Florian Westphal (12):
      netfilter: nf_conncount: callers must hold rcu read lock
      netfilter: nft_payload: reject offsets exceeding 65535 bytes
      netfilter: nft_meta_bridge: add validate callback for get operations
      netfilter: nft_flow_offload: zero device address for non-ether case
      netfilter: nf_reject: skip iphdr options when looking for icmp header
      netfilter: nft_meta_bridge: fix NFT_META_BRI_IIFPVID stack leak
      netfilter: nft_compat: ebtables emulation must reject non-bridge targets
      netfilter: nft_ct: expectation timeouts are passed in milliseconds
      netfilter: nft_set_pipapo: don't leak bad clone into future transaction
      netfilter: nf_nat_sip: reload possible stale data pointer
      netfilter: xt_physdev: masks are not c-strings
      ipvs: reload ip header after head reallocation

Francesco Dolcini (1):
      arm64: dts: freescale: imx95-verdin-ivy: fix RS485 RTS polarity

Francesco Lavra (1):
      regcache: Do not overwrite error code when finalizing cache after error

Francois Dugast (1):
      drm/xe/pt: Fix NULL pointer dereference in xe_pt_zap_ptes_entry()

Frank Li (1):
      dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK

Frank Wunderlich (1):
      arm64: dts: mediatek: mt7988a-bpi-r4pro: rework pcie gpio-hog handling

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

Gal Pressman (1):
      ethtool: rss: Fix hfunc and input_xfrm parsing on big endian

Gao Xiang (1):
      erofs: call erofs_exit_ishare() before rcu_barrier()

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
      ksmbd: fix stack buffer overflow in multichannel session-key copy

Giovanni Cabiddu (1):
      vfio/qat: fix f_pos race in qat_vf_resume_write()

Gleb Markov (1):
      cxgb4: Fix decode strings dump for T6 adapters

Gopikrishna Garmidi (1):
      arm64: dts: qcom: glymur: Fix wrong interrupt number for i2c19

Greg Kroah-Hartman (3):
      sysfs: clamp show() return value in sysfs_kf_read()
      Revert "gpib: cb7210: Fix region leak when request_irq fails"
      Linux 7.1.5

Greg Thelen (1):
      tools: ynl: build archives with $(AR)

Gregory Bell (2):
      selftests/bpf: Use local type for flow_offload_tuple_rhash in xdp_flowtable
      selftests/bpf: Use local type for bpf_fou_encap in test_tunnel_kern

Grzegorz Nitka (5):
      dpll: fix stale iteration in dpll_pin_on_pin_unregister()
      dpll: send delete notification before unregister in on-pin rollback
      dpll: emit per-dpll delete notifications in dpll_pin_on_pin_unregister()
      dpll: guard sync-pair removal on full pin unregister
      dpll: balance create/delete notifications in __dpll_pin_(un)register

Guangshuo Li (11):
      IB/mlx4: Fix refcount leak in add_port() error path
      ASoC: adau1372: Clear PLL_EN on failed PLL lock without reset GPIO
      ksmbd: fix use-after-free in same_client_has_lease()
      staging: most: video: avoid double free on video register failure
      drm/i915: clear CRTC color blob pointers after dropping refs
      cifs: validate DFS referral string offsets
      drm/xe: free madvise VMA array on L2 flush failure
      smb: client: fix overflow in passthrough ioctl bounds check
      gpu: host1x: Fix device reference leak in host1x_device_parse_dt() error path
      mfd: sm501: Fix reference leak on failed device registration
      mmc: vub300: fix use-after-free on probe failure

Guanyou.Chen (1):
      sched: restore timer_slack_ns when resetting RT policy on fork

Guenter Roeck (2):
      hwmon: (pmbus) Fix passing events to regulator core
      hwmon: (aspeed-g6-pwm-tach) Guard fan RPM calculation against divide-by-zero

Gui-Dong Han (2):
      KEYS: Use acquire when reading state in keyring search
      9p: Add missing read barrier in virtio zero-copy path

Guilherme Ivo Bozi (1):
      iio: adc: xilinx-ams: fix out-of-bounds channel lookup in event handling

Guixin Liu (2):
      PCI: Introduce named defines for PCI ROM
      PCI: Check ROM header and data structure addr before accessing

GuoHan Zhao (1):
      vfio/xe: avoid duplicate reset in xe_vfio_pci_reset_done

Guoniu Zhou (3):
      dt-bindings: power: imx93: Add MIPI PHY power domain
      media: synopsys: Fix IPI using hardcoded datatype
      pmdomain: imx93-blk-ctrl: Extract PHY as shared domain for DSI/CSI

Han Gao (1):
      pinctrl: spacemit: fix NULL check in spacemit_pin_set_config

HanQuan (1):
      ALSA: seq: Fix kernel heap address leak in bounce_error_event()

Hao Ge (2):
      lib/test_hmm: fix memory leak in dmirror_migrate_to_system()
      alloc_tag: fix use-after-free in /proc/allocinfo after module unload

Haofeng Li (2):
      ksmbd: reject undersized DACLs before parsing ACEs
      wifi: cfg80211: validate EHT MLE before MLD ID read

Haoxiang Li (13):
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
      net: ipa: fix SMEM state handle leaks in SMP2P init
      irqchip/irq-riscv-imsic-early: Fix fwnode leak on state setup failure

Haoze Xie (1):
      netfilter: nf_queue: pin bridge device while NFQUEUE holds fake dst

Harman Kalra (1):
      octeontx2-af: fix VF bringup affecting PF promiscuous state

Harshal Dev (9):
      arm64: dts: qcom: kaanapali: Add power-domain and iface clk for ice node
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

Helen Koike (1):
      fs/ntfs3: call _ntfs_bad_inode() when failing to rename

Helge Deller (1):
      fbdev/arm: Export acorndata_8x8 font symbol for bootloader

Henrique Carvalho (1):
      smb: client: fix conflicting option validation for new mount API

Herbert Xu (5):
      crypto: af_alg - Cap AEAD AD length to 0x80000000
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

Hongjie Fang (1):
      scsi: ufs: core: Handle PM commands timeout before SCSI EH

Hongling Zeng (9):
      nilfs2: Fix return in nilfs_mkdir
      wifi: mt76: mt7921: fix resource leak in probe error path
      ext4: fix ERR_PTR(0) in ext4_mkdir()
      9p: avoid returning ERR_PTR(0) from mkdir operations
      gpib: cb7210: Fix region leak when request_irq fails
      sunrpc: Fix error handling in rpc_sysfs_xprt_switch_add_xprt_store()
      apparmor: Fix return in ns_mkdir_op
      cachefiles: Fix double unlock in nomem_d_alloc error path
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

HyeongJun An (7):
      ALSA: seq: Fix partial userptr event expansion
      ASoC: codecs: hdac_hdmi: Validate written enum value
      ASoC: meson: aiu: Validate written enum values
      ASoC: fsl: fsl_audmix: Validate written enum values
      ASoC: tegra: tegra210_ahub: Validate written enum value
      ASoC: SDCA: Validate written enum value in ge_put_enum_double()
      hwmon: (asus_atk0110) Check package count before accessing element

Hyunchul Lee (8):
      ntfs: fix incorrect size of symbolic link
      ntfs: add bounds check before accessing EA entries
      ntfs: not change 0-byte $DATA attribute to non-resident
      ntfs: validate index block header more strictly
      ntfs: centalize $INDEX_ROOT header validation
      ntfs: skip extent mft records in writeback to prevent deadlock
      ntfs: validate index entries on reading
      ntfs: avoid self-deadlock during inode eviction

Hyunwoo Kim (2):
      rxrpc: Don't move a peeked OOB message onto the pending queue
      KVM: arm64: vgic: Check the interrupt is still ours before migrating it

Ian Bridges (4):
      fbcon: fix NULL pointer dereference for a console without vc_data
      ocfs2: fix out-of-bounds write in ocfs2_remove_refcount_extent
      ocfs2: fix NULL h_transaction deref in ocfs2_assure_trans_credits
      ocfs2: fix UBSAN array-index-out-of-bounds in ocfs2_sum_rightmost_rec

Ian Rogers (14):
      perf dwarf-aux: Fix libdw segmentation fault in cu_walk_functions_at
      perf dwarf-aux: Fix libdw API contract violations
      perf srcline: Introduce inline_node__clear_frames()
      perf libdw: Fix libdw API contract violations and memory leaks
      perf probe-finder: Fix libdw API contract violations
      perf annotate-data: Fix libdw API contract violations
      perf debuginfo: Fix libdw API contract violations
      perf sched: Add missing mmap2 handler in timehist
      perf tool: Fix missing schedstat delegates and dont_split_sample_group in delegate_tool
      perf pmu-events AMD: Switch l2_itlb_misses to bp_l1_tlb_miss_l2_tlb_miss.all
      perf unwind: Refactor get_entries to allow dynamic libdw/libunwind selection
      perf event: Fix size of synthesized sample with branch stacks
      perf inject: Fix itrace branch stack synthesis
      perf maps: Add maps__mutate_mapping

Ibrahim Hashimov (1):
      ksmbd: fix integer overflow in set_file_allocation_info()

Icenowy Zheng (2):
      drm: verisilicon: call atomic helper's plane state check even if no CRTC
      dmaengine: qcom: gpi: set DMA_PRIVATE capability

Ido Schimmel (2):
      selftests: vlan_bridge_binding: Fix flaky operational state check
      bridge: stp: Fix a potential use-after-free when deleting a bridge

Ilya Maximets (1):
      net: dst_metadata: fix false-positive memcpy overflow in tun_dst_unclone

Ingo Blechschmidt (1):
      dm: avoid leaking the caller's thread keyring via the table device file

Inochi Amaoto (5):
      riscv: dts: sophgo: sg2044: use hex for CPU unit address
      riscv: dts: sophgo: sg2042: use hex for CPU unit address
      dt-bindings: dma: snps,dw-axi-dmac: Add fallback compatible for CV1800B
      net: stmmac: dwmac-spacemit: Fix wrong phy interface definition
      net: stmmac: dwmac-spacemit: Fix wrong irq definition

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

J. Neuschäfer (1):
      HID: wiimote: Fix table layout and whitespace errors

Jackie Dong (1):
      ALSA: hda/realtek:ALC269 fixup for Yoga Pro 7 15ASH11 mic mute LED

Jacob Moroni (4):
      RDMA/irdma: Fix out-of-bounds write in irdma_copy_user_pgaddrs
      RDMA/irdma: Fix OOB read during CQ MR registration
      RDMA/irdma: Initialize iwmr->access during MR registration
      RDMA/irdma: Replace waitqueue and flag with completion

Jaewon Yang (1):
      tpm: Make the TPM character devices non-seekable

Jagadeesh Kona (2):
      dt-bindings: clock: qcom: Add X1P42100 camera clock controller
      clk: qcom: camcc-x1e80100: Add support for camera QDSS debug clocks

Jakub Kicinski (5):
      net: psample: fix info leak in PSAMPLE_ATTR_DATA
      eth: bnxt: improve the timing of stats
      eth: fbnic: fix ordering of heartbeat vs ownership
      eth: fbnic: don't cache shinfo across skb realloc
      selftests: drv-net: tso: don't touch dangerous feature bits

Jakub Sitnicki (1):
      net: lwtunnel: Drop skb metadata before LWT encapsulation

Jamal Hadi Salim (5):
      net/sched: cls_flow: Dont expose folded kernel pointers
      net/sched: cls_api: Handle TC_ACT_CONSUMED in tcf_qevent_handle
      net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF
      net/sched: act_pedit: fix TOCTOU heap OOB write in tc offload
      net/sched: sch_teql: move rcu_read_lock()/spin_lock() from _bh variants

James Clark (3):
      coresight: ete: Always save state on power down
      perf annotate: Fix crashes on empty annotate windows
      perf cs-etm: Queue context packets for frontend

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

Jann Horn (1):
      bpf,fork: wipe ->bpf_storage before bailouts that access it

Jarkko Sakkinen (1):
      tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()

Jason Gunthorpe (10):
      vfio: selftests: Fix out-of-tree build with make O=
      IB/cm: Fix av cm device leak on an error path in cm_init_av_by_path()
      IB/mlx5: Don't take the rereg_mr fallback without a new translation
      IB/mlx5: Properly support implicit ODP rereg_mr
      RDMA/nldev: Fix locking when accessing mr->pd
      IB/mlx5: Remove unused mkc bits in mlx5r_umr_update_mr_page_shift()
      IB/mlx5: Pull the pdn out of the depths of the umr machinery
      IB/mlx5: Don't mangle the mr->pd inside the rereg callback
      iommufd: Destroy the pages content after detaching from dmabuf
      IB/mlx4: Fill in the access_flags if IB_MR_REREG_ACCESS is not specified

Jason Wang (1):
      VDUSE: avoid leaking information to userspace

Javier Fernandez Pastrana (1):
      spi: imx: reconfigure for PIO when DMA cannot be started

Javier Tia (1):
      wifi: mt76: mt7925: fix stale pointer comparisons in change_vif_links

Jeff Layton (2):
      mm: preserve PG_dropbehind flag during folio split
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

Jie Gan (3):
      coresight: fix missing error code when trace ID is invalid
      coresight: Fix source not disabled on idr_alloc_u32 failure
      coresight: platform: defer connection counter increment until alloc succeeds

Jihed Chaibi (1):
      ARM: dts: am335x-sl50: Fix audio bitclock and frame master endpoint

Jinjiang Tu (1):
      fs/proc: fix KPF_KSM reported for all anonymous pages

Jinjie Ruan (2):
      arm64: smp: Fix hot-unplug tearing by forcing unregistration
      cpu/hotplug: Fix NULL kobject warning in cpuhp_smt_enable()

Jinseok Kim (1):
      arm: dts: bcm2711: Fix typo in gpio-line-names

Jiri Olsa (4):
      bpf: Guard __get_user acesss with access_ok for uprobe_multi data
      selftests/bpf: Fix typo in verify_umulti_link_info
      uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
      bpf: Add missing access_ok call to copy_user_syms

Jiri Pirko (1):
      RDMA/umem: Add ib_umem_is_contiguous() stub for !CONFIG_INFINIBAND_USER_MEM

Jisheng Zhang (2):
      spi: dw: fix wrong BAUDR setting after resume
      binder: Use LIST_HEAD() to initialize on stack list head

Joe Damato (1):
      bnxt: fix head underflow on XDP head-grow

Joe Lawrence (2):
      objtool/klp: Fix is_uncorrelated_static_local() for Clang
      objtool/klp: Fix create_fake_symbols() skipping entsize-based sections

Joel Selvaraj (1):
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Correct IPA FW path

Joey Lu (1):
      pinctrl: nuvoton: ma35d1: fix MFP register offset and pin table

Johan Hovold (4):
      MIPS: ip22-gio: fix gio device memory leak
      MIPS: ip22-gio: fix kfree() of static object
      MIPS: ip22-gio: fix device reference leak in probe
      power: supply: max17042: fix OF node reference imbalance

Johannes Thumshirn (3):
      btrfs: zoned: don't account data relocation space-info in statfs free space
      btrfs: zoned: fix deadlock waiting for ticket during data relocation
      btrfs: zoned: always set max_active_zones for zoned devices

John Johansen (6):
      apparmor: fix shadowing of plabel that prevents cache from being updated
      apparmor: fix race in unix socket mediation when peer_path is used
      apparmor: fix refcount leak when updating the sk_ctx
      apparmor: fix rawdata_f_data implicit flex array
      apparmor: remove unnecessary goto and associated label
      apparmor: fix label can not be immediately before a declaration

John Madieu (2):
      ASoC: rsnd: Fix RSND_SOC_MASK width to single nibble
      rtc: isl1208: Balance enable_irq_wake() with disable_irq_wake() on cleanup

Jon Hunter (2):
      arm64: tegra: Fix Tegra234 MGBE PTP clock
      arm64: tegra: Fix address of Tegra264 main GPIO controller

Jonathan Cavitt (1):
      drm/gpuvm: Do not prepare NULL objects

Jordan Walters (1):
      Bluetooth: hci_core: Fix UAF in hci_unregister_dev()

Jose A. Perez de Azpillaga (1):
      staging: media: atomisp: fix loop shadowing in ia_css_stream_destroy()

Joseph Qi (2):
      ocfs2: fix race between ocfs2_control_install_private() and ocfs2_control_release()
      ocfs2: add journal NULL check in ocfs2_checkpoint_inode()

Josh Law (1):
      lib/base64: validate before writing in decode tail path

Josh Poimboeuf (10):
      objtool/klp: Fix .data..once static local non-correlation
      objtool/klp: Fix handling of zero-length .altinstr_replacement sections
      objtool/klp: Fix cloning of zero-length section symbols
      objtool/klp: Fix extraction of text annotations for alternatives
      objtool/klp: Fix relocation conversion failures for R_X86_64_NONE
      objtool: Replace iterator callback with for_each_sym_by_mangled_name()
      objtool: Fix reloc hash collision in find_reloc_by_dest_range()
      klp-build: Fix hang on out-of-date .config
      klp-build: Fix checksum comparison for changed offsets
      klp-build: Fix patch cleanup on interrupt

Joshua Crofts (6):
      iio: light: si1133: reset counter to prevent race condition
      iio: light: si1133: prevent race condition on timeout
      iio: magnetometer: ak8975: fix potential kernel stack memory leak
      hwmon: (ltc2992) add missing 'select REGMAP_I2C' to Kconfig
      hwmon: (max6697) add missing 'select REGMAP_I2C' to Kconfig
      hwmon: (max1619) add missing 'select REGMAP' to Kconfig

Josua Mayer (1):
      arm64: dts: lx2162a-clearfog: use rev2 SoC dtsi

Jozsef Kadlecsik (4):
      netfilter: ipset: Don't use test_bit() in lockless RCU readers in hash types
      netfilter: ipset: Don't use test_bit() in lockless RCU readers in bitmap types
      netfilter: ipset: fix order of kfree_rcu() and rcu_assign_pointer()
      netfilter: ipset: make sure gc is properly stopped

Judith Mendez (1):
      arm64: dts: ti: k3-am62a7-sk: Add bootph-all tag to vqmmc

Julian Anastasov (2):
      ipvs: ensure inner headers in ICMP errors are in headroom
      ipvs: fix more places with wrong ipv6 transport offsets

Junrui Luo (4):
      mshv: add bounds check on vp_index in mshv_intercept_isr()
      jbd2: fix integer underflow in jbd2_journal_initialize_fast_commit()
      octeontx2-af: cn10k: restrict VF LMTLINE sharing to its own PF
      powerpc/spufs: fix out-of-bounds access in spufs_mem_mmap_access()

Junxian Huang (2):
      RDMA/hns: Initialize seqfile before creating file
      RDMA/hns: Fix memory leak of bonding resources

Junxiao Chang (1):
      x86/cpu: Remove obsolete aperfmperf_get_khz() declaration

Justin Suess (1):
      bpf: Cancel special fields on map value recycle

KP Singh (1):
      libbpf: Reject non-exclusive metadata maps in the signed loader

KaFai Wan (1):
      bpf: Fix insn_aux_data leak on verifier err_free_env path

Kaitao Cheng (1):
      bpf: Clear rb node linkage when freeing bpf_rb_root

Kamal Wadhwa (1):
      arm64: dts: qcom: fix temp-alarm probe failure for PMH0104 on Glymur

Kamlesh Kumar (1):
      ima: Fix sigv3 signature handling for EVM_IMA_XATTR_DIGSIG

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

Karunika Choo (3):
      drm/panthor: Pass an iomem pointer to GPU register access helpers
      drm/panthor: Split register definitions by components
      drm/panthor: Store IRQ register base iomem pointer in panthor_irq

Keshav Verma (1):
      f2fs: fix listxattr handling of corrupted xattr entries

Kevin Brodsky (1):
      selftests/mm: Fix resv_sz when parsing arm64 signal frame

KhaiWenTan (1):
      igc: skip RX timestamp header for frame preemption verification

Kiran K (2):
      Bluetooth: btintel_pcie: Add support for smart trigger dump
      Bluetooth: btintel_pcie: Refactor FLR to use device_reprobe()

Kiryl Shutsemau (Meta) (4):
      mm/huge_memory: preserve pmd_swp_uffd_wp on device-private PMD downgrade
      fs/proc/task_mmu: fix make_uffd_wp_huge_pte() prot-update race
      fs/proc/task_mmu: fix hugetlb self-deadlock in pagemap_scan_pte_hole()
      fs/proc/task_mmu: use huge_page_size() in pagemap_scan_hugetlb_entry()

Koichiro Den (8):
      PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
      PCI: endpoint: pci-epf-vntb: Defer pci_epc_raise_irq() out of atomic context
      PCI: endpoint: pci-epf-vntb: Report 0-based doorbell vector via ntb_db_event()
      PCI: endpoint: pci-epf-vntb: Exclude reserved slots from db_valid_mask
      NTB: epf: Make db_valid_mask cover only real doorbell bits
      NTB: epf: Report 0-based doorbell vector via ntb_db_event()
      NTB: epf: Fix doorbell bitmask and IRQ vector handling
      dmaengine: dw-edma-pcie: Reject devices without driver data

Konrad Dybcio (2):
      dt-bindings: net: bluetooth: qualcomm: Fix WCN6855 regulator names
      dt-bindings: phy: sc8280xp-qmp-pcie: Disallow bifurcation register on Purwa

Konstantin Komarov (4):
      fs/ntfs3: add bounds check to run_get_highest_vcn()
      fs/ntfs3: bound DeleteIndexEntryAllocation memmove length
      fs/ntfs3: bound attr_off in UpdateResidentValue against data_off
      fs/ntfs3: validate lcns_follow in log_replay conversion

Krishna Chomal (2):
      platform/x86: hp-wmi: Add support for Omen 16-ap0xxx (8D26)
      platform/x86: hp-wmi: Add support for Omen 16-ap0xxx (8E35)

Krzysztof Kozlowski (14):
      arm64: dts: qcom: glymur: Fix USB simple_bus_reg warning
      arm64: dts: qcom: glymur: Fix cache and SRAM simple_bus_reg warnings
      arm64: dts: qcom: ipq5424: Fix USB simple_bus_reg warnings
      arm64: dts: qcom: sc8180x: Fix phy simple_bus_reg warning
      arm64: dts: qcom: sdm845-mezzanine: Fix camss ports unit_address_vs_reg warning
      dt-bindings: pinctrl: nvidia,tegra234: Add missing required block
      arm64: dts: imx8mn-vhip4-evalboard-v1: Correct interrupt flags
      arm64: dts: imx8mn-vhip4-evalboard-v2: Correct interrupt flags
      arm64: dts: imx8mp-ab2: Correct interrupt flags
      ARM: multi_v7_defconfig: Correct QCOM_RPMH and QCOM_RPMHPD
      arm64: dts: qcom: sm8750: Fix DSI1 phy reference clock rate
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

Kuniyuki Iwashima (8):
      vxlan: Fix potential null-ptr-deref in vxlan_gro_prepare_receive().
      ipv4: fib: Don't dump dying fib_info in fib_leaf_notify().
      net: fib_rules: Don't dump dying fib_rule in fib_rules_dump().
      sockmap: Fix use-after-free in udp_bpf_recvmsg()
      ipv4: fib: Don't ignore error route in local/main tables.
      udp_tunnel: Pass struct sock to udp_tunnel_sock_release().
      udp_tunnel: Pass struct sock to setup_udp_tunnel_sock().
      tipc: Store struct sock in struct udp_bearer.

Kwan Lai Chee Hou (1):
      wifi: ath12k: fix incorrect HT/VHT/HE/EHT MCS reporting in monitor mode

Kyle Hendry (1):
      MIPS: mm: Add check for highmem before removing memory block

Kyle Zeng (2):
      ALSA: seq: Clear variable event pointer on read
      ocfs2: avoid moving extents to occupied clusters

Lad Prabhakar (4):
      clk: renesas: rzg2l: Rename iterator in for_each_mod_clock() to avoid shadowing
      PCI: rcar-host: Remove unused LIST_HEAD(res)
      rtc: renesas-rtca3: Fix PIE clear polling condition in alarm setup error path
      mmc: mmc_test: Fix __counted_by handling after kzalloc_flex() conversion

Lars Pöschel (1):
      spi: xilinx: use FIFO occupancy register to determine buffer size

Larysa Zaremba (1):
      ixgbe: do not configure xps for XDP queues

Laxman Acharya Padhya (1):
      Bluetooth: btrtl: validate firmware patch bounds

Lee Jones (2):
      HID: core: Fix OOB read in hid_get_report for numbered reports
      can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

Leo Yan (5):
      selftests/bpf: Initialize operation name before use
      coresight: tmc: Fix overflow when calculating is bigger than 2GiB
      coresight: etm4x: Correct TRCVMIDCCTLR1 save and restore
      perf pmu: Skip test on Arm64 when #slots is zero
      coresight: Handle helper enable failure properly

Leon Hwang (4):
      bpf: Check tail zero of bpf_map_info
      bpf: Check tail zero of bpf_prog_info
      bpf: Update transport_header when encapsulating UDP tunnel in lwt
      bpf: Fix bpf_get/setsockopt to tos for ipv4-mapped ipv6 socket

Leon Romanovsky (3):
      ntb: Store original DMA address for future release
      ntb: Use consistent DMA attributes when freeing DMA mappings
      RDMA/mlx5: Release the HW‑provided UAR index rather than the SW one

Li Chen (1):
      ext4: fix fast commit wait/wake bit mapping on 64-bit

Li Daming (1):
      rxrpc: serialize kernel accept preallocation with socket teardown

Li Ming (2):
      cxl/region: Fix out-of-bounds access in cxl_cancel_auto_attach()
      cxl/region: Fill first free targets[] slot during auto-discovery

Li RongQing (6):
      iommu/dma-iommu: Fix wrong scatterlist length assignment in P2PDMA path
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

Linus Walleij (1):
      dt-bindings: vendor-prefixes: Add Verbatim Corporation

Liviu Dudau (1):
      drm/syncobj: Fix memory leak in drm_syncobj_find_fence()

Lizhi Hou (11):
      accel/amdxdna: Create shared functions for AIE2 and AIE4
      accel/amdxdna: Adjust size for copy_to_user()
      accel/amdxdna: Fix iommu_map_sgtable() return value handling
      accel/amdxdna: Fix order of canceled mailbox messages
      accel/amdxdna: Fix clflush buffer size
      accel/amdxdna: Return errors for failed debug BO commands
      accel/amdxdna: Fix iommu domain lifetime race during device removal
      accel/amdxdna: Prevent PM resume deadlock in hwctx_sync_debug_bo()
      accel/amdxdna: Use unsigned long for nr_pages in amdxdna_hmm_register()
      accel/amdxdna: Fix VMA access race
      accel/amdxdna: Fix potential amdxdna_umap lifetime race

Longjun Tang (1):
      virtio_net: disable cb when NAPI is busy-polled

Lorenzo Bianconi (7):
      wifi: mt76: mt7996: Fix NULL pointer dereference in mt7996_init_tx_queues()
      wifi: mt76: mt7996: Fix possible token leak in mt7996_tx_prepare_skb()
      wifi: mt76: mt7996: Fix possible NULL pointer dereference in mt7996_mac_write_txwi_80211()
      wifi: mt76: mt7996: fix reading zeroed info->control.flags after mt76_tx_status_skb_add()
      wifi: mt76: mt7996: remove redundant pdev->bus check in probe
      netfilter: flowtable: fix and simplify IP6IP6 tunnel handling
      netfilter: flowtable: Validate iph->ihl in nf_flow_ip4_tunnel_proto()

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

Maksym Pikhotskyi (1):
      staging: rtl8723bs: fix stainfo check in rtw_aes_decrypt

Manikanta Maddireddy (1):
      PCI: dwc: Apply ECRC workaround for DesignWare cores prior to 5.10a

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

Marc Zyngier (3):
      KVM: arm64: vgic: Handle race between interrupt affinity change and LPI disabling
      KVM: Move kvm_io_bus_get_dev() locking responsibilities to callers
      KVM: arm64: Fix propagation of TLBI level in kvm_pgtable_stage2_relax_perms()

Marcin Szycik (1):
      ice: call netif_keep_dst() once when entering switchdev mode

Marco Crivellari (1):
      ntfs: Add WQ_PERCPU to alloc_workqueue users

Marek Szyprowski (1):
      irqchip/exynos-combiner: Remove useless spinlock

Marek Vasut (5):
      dt-bindings: vendor-prefixes: Add Displaytech Ltd.
      arm64: dts: st: Fix SAI addresses on stm32mp251
      arm64: dts: renesas: r8a78000: Fix GIC-720AE View 1 Redistributor description
      arm64: dts: renesas: ironhide: Describe all reserved memory
      arm64: dts: renesas: ironhide: Describe inline ECC carveouts

Marijn Suijten (1):
      drm/panel: Clean up SOFEF00 config dependencies

Mario Limonciello (3):
      gpiolib: acpi: Only trigger ActiveBoth interrupts on boot
      drm/amdkfd: fix list_del corruption in kfd_criu_resume_svm
      x86/video: Only fall back to vga_default_device() without screen info

Mark Bloch (3):
      net/mlx5: Lag: refactor representor reload handling
      net/mlx5: E-Switch, add representor lifecycle lock
      net/mlx5: Lag, avoid LAG and representor lock cycles

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

Matt Bobrowski (2):
      selftests/bpf: Fix off-by-one in bpf_cpumask_populate related selftest
      bpf: fix crash in bpf_[set|remove]_dentry_xattr for negative dentries

Matt Fleming (1):
      ipmi: Fix user refcount underflow in event delivery

Matthew Auld (2):
      drm/xe: fix NPD in bo_meminfo()
      drm/xe/pt: prevent invalid cursor access for purged BOs

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

Matti Vaittinen (2):
      mfd: bd72720: Drop BUCK11 ID
      hwmon: adm1275: Prevent reading uninitialized stack

Matvey Kovalev (2):
      afs: fix NULL pointer dereference in afs_get_tree()
      qede: fix out-of-bounds check for cqe->len_list[]

Mauricio Faria de Oliveira (3):
      usb: atm: ueagle-atm: use dev_dbg() for 'device found' message
      usb: atm: ueagle-atm: remove function entry/exit debug messages
      usb: atm: ueagle-atm: wait for pre-firmware load in .disconnect()

Max Zhen (4):
      accel/amdxdna: Fix leak when pinning ubuf pages
      accel/amdxdna: Handle DETACH_DEBUG_BO through config_debug_bo path
      accel/amdxdna: Fix fatal_error_info layout in firmware interface
      accel/amdxdna: Guard management mailbox channel cleanup against NULL pointer

Maxime Bélair (1):
      apparmor: fix potential UAF in aa_replace_profiles

Maxwell Doose (1):
      fs: efs: remove unneeded debug prints

Maíra Canal (1):
      drm/v3d: Reject invalid indirect BO handle in indirect CSD setup

Meghana Malladi (4):
      net: ti: icssg-prueth: Fix AF_XDP fill ring alloc and wakeup condition
      net: ti: icssg: Use undirected TX tag for native XDP in HSR offload mode
      net: ti: icssg: Use undirected TX tag for XDP zero copy in HSR offload mode
      net: ti: icssg: Fix XSK zero copy TX during application wakeup

Miaoqing Pan (1):
      wifi: ath12k: fix memory leak in ath12k_wifi7_dp_rx_h_verify_tkip_mic()

Michael Bommarito (29):
      iommu/vt-d: Clear Present bit before tearing down scalable-mode context entry
      libbpf: Harden parse_vma_segs() path parsing
      tipc: require net admin for TIPCv2 netlink mutators
      tipc: prevent snt_unacked underflow on CONN_ACK
      tipc: reject inverted service ranges from peer bindings
      ALSA: usb-audio: qcom: reject stream disable with no active interface
      ALSA: usb-audio: qcom: clear opened when stream enable fails
      net/sched: act_ct: fix nf_connlabels leak on two error paths
      xen/pvcalls: bound backend response req_id before indexing rsp[]
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

Michael Guralnik (9):
      RDMA/mlx5: Fix mkey creation error flow rollback
      RDMA/mlx5: Fix TPH extraction in FRMR pool key
      RDMA/core: Fix skipped usage for driver built FRMR key
      RDMA/core: Fix FRMR aging push to queue error flow
      RDMA/core: Fix FRMR set pinned push error path
      RDMA/core: Avoid NULL dereference on FRMR bad usage
      RDMA/core: Fix FRMR handle leak on push failure
      RDMA/core: Add ib_frmr_pool_drop for unrecoverable handles
      RDMA/mlx5: Drop FRMR pool handle on UMR revoke failure

Michael Petlan (1):
      perf build-id: Fix off-by-one bug when printing kernel/module build-id

Michael S. Tsirkin (1):
      vhost: fix vhost_get_avail_idx for a non empty ring

Michal Wajdeczko (1):
      drm/xe/pf: Don't attempt to process FAST_REQ or EVENT relays

Miguel Ojeda (1):
      rust: kbuild: show the right `quiet_cmd_rustc_procmacrolibrary`

Mihai Brodschi (1):
      ntfs3: Allocate iomap inline_data using alloc_page

Mihai Sain (1):
      clk: at91: sam9x7: Fix gmac_gclk clock definition

Mike Christie (1):
      scsi: target: Remove tcm_loop target reset handling

Mike Rapoport (Microsoft) (1):
      selftests/mm: run_vmtests.sh: free memory if available memory is low

Mike Snitzer (2):
      NFSv4/flexfiles: honor FF_FLAGS_NO_IO_THRU_MDS on fatal DS connect errors
      NFSv4/flexfiles: honor FF_FLAGS_NO_IO_THRU_MDS in pg_get_mirror_count_write

Mike Waychison (1):
      block: fix race in blk_time_get_ns() returning 0

Mikhail Kshevetskiy (11):
      pinctrl: airoha: an7581: add missed gpio32 pin group
      pinctrl: airoha: an7583: add missed gpio32 pin group
      pinctrl: airoha: an7581: fix misprint in gpio19 pinconf
      pinctrl: airoha: an7583: fix misprint in gpio19 pinconf
      pinctrl: airoha: an7581: fix incorrect led mapping in phy4_led1 pin function
      pinctrl: airoha: an7583: fix incorrect led mapping in phy4_led1 pin function
      pinctrl: airoha: fix pwm pin function for an7581 and an7583
      pinctrl: airoha: an7583: fix gpio21 pin group
      pinctrl: airoha: an7583: add missed gpio22 pin group
      pinctrl: airoha: an7583: fix phy1_led1 pin function
      pinctrl: airoha: an7583: remove undefined groups from pcm_spi pin function

Mikko Perttunen (3):
      gpu: host1x: Allow entries in BO caches to be freed
      gpu: host1x: Fix iommu_map_sgtable() return value check
      drm/tegra: Fix iommu_map_sgtable() return value check

Miklos Szeredi (4):
      kernfs: fix xattr race condition with multiple superblocks
      tmpfs: simplify constructing "security.foo" xattr names
      simple_xattr: change interface to pass struct simple_xattrs **
      simpe_xattr: use per-sb cache

Mikulas Patocka (13):
      dm-bufio: fix wrong count calculation in dm_bufio_issue_discard
      dm-ioctl: fix a possible overflow in list_version_get_info
      dm-stats: fix dm_jiffies_to_msec64
      dm-stats: fix merge accounting
      dm_early_create: fix freeing used table on dm_resume failure
      dm-integrity: fix leaking uninitialized kernel memory
      dm-integrity: fix a bug if the bio is out of limits
      dm-integrity: don't increment hash_offset twice
      dm-verity: fix buffer overflow in FEC calculation
      dm-verity: avoid double increment of &use_bh_wq_enabled
      dm-verity: fix a possible NULL pointer dereference
      dm-verity: increase sprintf buffer size
      dm-verity: make error counter atomic

Ming-Hung Tsai (1):
      dm thin metadata: fix metadata snapshot consistency on commit failure

Mingyou Chen (1):
      platform/x86: bitland-mifs-wmi: Fix NULL pointer dereference during suspend/resume

Miquel Raynal (4):
      mtd: spi-nor: debugfs: Fix the flags list
      mtd: spi-nor: Drop duplicate Kconfig dependency
      mtd: spi-nor: swp: Improve locking user experience
      mtd: rawnand: Pause continuous reads at block boundaries

Mohamed Khalfella (1):
      i40e: Fix i40e_debug() to use struct i40e_hw argument

Morduan Zang (1):
      iomap: guard io_size EOF trim against concurrent truncate underflow

Muchun Song (4):
      mm/sparse-vmemmap: fix vmemmap accounting underflow
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
      selftests/bpf: Fix flaky file_reader test
      bpf: Verifier support for sleepable tracepoint programs
      bpf: Fix NMI/tracepoint re-entry deadlock on lru locks

Nam Cao (1):
      eventpoll: Fix epoll_wait() report false negative

Namjae Jeon (9):
      ksmbd: fix multichannel binding and enforce channel limit
      ntfs: sanitize MFT references returned from ntfs_lookup_inode_by_name()
      ntfs: make system files immutable to prevent corruption
      ntfs: fix WARN_ON for resident attribute in ntfs_map_runlist_nolock()
      ksmbd: use opener credentials for FSCTL mutations
      exfat: replace unsafe macros with static inline functions
      exfat: add balloc parameter to exfat_map_cluster() for iomap support
      exfat: add data_start_bytes and exfat_cluster_to_phys_bytes() helper
      exfat: fix implicit declaration of brelse()

Nan Li (1):
      afs: handle CB.InitCallBackState3 requests without a server record

Nas Chung (1):
      media: v4l2-common: Add YUV24 format info

Nathan Chancellor (2):
      driver core: Use system_percpu_wq instead of system_wq
      btrfs: Drop WQ_PERCPU from ordered_flags in btrfs_init_workqueues()

Neal Cardwell (1):
      tcp_bbr: fix SPDX-License-Identifier to be GPL-2.0 OR BSD-3-Clause

Nick Chan (1):
      nvme-apple: Prevent shared tags across queues on Apple A11

Nick Hu (1):
      dt-bindings: timer: Remove sifive,fine-ctr-bits property

Nickolay Goppen (3):
      arm64: dts: qcom: sdm660: set cdsp compute-cbs' regs properly
      arm64: dts: qcom: sdm630: set adsp compute-cbs' regs properly
      arm64: dts: qcom: sdm630: describe adsp_mem region properly

Nicolai Buchwitz (1):
      net: usb: lan78xx: restore VLAN and hash filters after link up

Nicolin Chen (1):
      iommu: Avoid copying the user array twice in the full-array copy helper

Nikita Zhandarovich (1):
      hwmon: (it87) Clamp negative values to zero in set_fan()

Nilay Shroff (1):
      nvme-multipath: fix flex array size in struct nvme_ns_head

Nirmoy Das (2):
      selftests: tls: size splice_short pipe by page size
      selftests: net: make busywait timeout clock portable

Nishanth Sampath Kumar (1):
      regmap-i2c: fix sparse warning in regmap_smbus_word_write_reg16

Nora Schiffer (1):
      arm64: dts: freescale: fsl-ls1028a-tqmls1028a-mbls1028a: switch mmc aliases

Nuno Sá (3):
      dmaengine: Fix possible use after free
      dmaengine: dma-axi-dmac: Properly free struct axi_dmac_desc
      dmaengine: dma-axi-dmac: use DMA pool to manange DMA descriptor

Nuoqi Gui (4):
      bpf: Fix stack slot index in nospec checks
      bpf: Preserve pointer spill metadata during half-slot cleanup
      bpf: Mask pseudo pointer values in verifier logs
      seg6: validate SRH length before reading fixed fields

Oder Chiou (1):
      ASoC: rt5575: Use __le32 for SPI burst write address

Oliver Hartkopp (14):
      ALSA: hda: fix Kconfig dependency of HD Audio PCI
      can: isotp: use unconditional synchronize_rcu() in isotp_release()
      can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
      can: isotp: serialize TX state transitions under so->rx_lock
      can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure
      can: bcm: add locking when updating filter and timer values
      can: bcm: add missing rcu list annotations and operations
      can: bcm: extend bcm_tx_lock usage for data and timer updates
      can: bcm: fix CAN frame rx/tx statistics
      can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
      can: bcm: fix stale rx/tx ops after device removal
      can: bcm: track a single source interface for ANYDEV timeout/throttle ops
      can: bcm: validate frame length in bcm_rx_setup() for RTR replies
      can: bcm: add missing device refcount for CAN filter removal

Oliver Upton (6):
      KVM: arm64: Ensure level is always initialized when relaxing perms
      KVM: arm64: nv: Drop bogus WARN for write to ZCR_EL2
      KVM: arm64: nv: Respect read-only PFN when mapping L1 VNCR
      KVM: arm64: nv: Inject SEA if kvm_translate_vncr() can't resolve PFN
      KVM: arm64: nv: Re-translate VNCR before injecting abort
      KVM: arm64: nv: Inject SEA if guest VNCR isn't normal memory

Ondrej Mosnacek (1):
      selinux: fix incorrect execmem checks on overlayfs

Ovidiu Panait (1):
      net: bcmgenet: Use weighted round-robin TX DMA arbitration

Pablo Neira Ayuso (19):
      netfilter: nfnetlink_cthelper: use {READ,WRITE}_ONCE for accessing helper flags
      netfilter: cttimeout: detach dataplane timeout policy and repurpose refcount
      netfilter: conntrack: revert ct extension genid infrastructure
      netfilter: conntrack: call nf_ct_gre_keymap_destroy() if master helper is pptp
      netfilter: nf_dup_netdev: add nf_dev_xmit_recursion*() helpers and use them
      netfilter: nf_conntrack_helper: dynamically allocate struct nf_conntrack_helper
      netfilter: nf_conntrack_pptp: move GRE specific cleanup to GRE tracker
      netfilter: conntrack: check NULL when retrieving ct extension
      netfilter: nf_conntrack_expect: use conntrack GC to reap expectations
      netfilter: nf_conntrack_expect: store master_tuple in expectation
      netfilter: nf_conntrack_expect: run expectation eviction with no helper
      netfilter: nf_conntrack_helper: cap maximum number of expectation at helper registration
      netfilter: nft_set_rbtree: get command skips end element with open interval
      netfilter: nf_conntrack_sip: validate skb_dst() before accessing it
      netfilter: flowtable: use dst in this direction when pushing IPIP header
      netfilter: flowtable: support IPIP tunnel with direct xmit
      netfilter: flowtable: use correct direction to set up tunnel route
      netfilter: nfnetlink_cthelper: cap to maximum number of expectation per master
      netfilter: nfnetlink_cthelper: cap to maximum number of expectation per master on updates

Paolo Abeni (1):
      virtio_net: do not allow tunnel csum offload for non GSO packets

Pasha Tatashin (4):
      liveupdate: skip serialization for context-preserving kexec
      liveupdate: fix TOCTOU race in luo_session_retrieve()
      liveupdate: block session mutations during reboot
      liveupdate: fix u-a-f in luo_file_unpreserve_files() and luo_file_finish()

Patrisious Haddad (2):
      RDMA/mlx5: Remove DCT restrack tracking
      RDMA/mlx5: Remove raw RSS QP restrack tracking

Paul Chaignon (2):
      selftests/bpf: Override EXTRA_LDFLAGS for static builds
      selftests/bpf: Fix test for refinement of single-value tnum

Paul Greenwalt (1):
      ice: fix ice_init_link() error return preventing probe

Paul Louvel (1):
      gpio-f7188x: Add support for NCT6126D version B

Pauli Virtanen (3):
      Bluetooth: ISO: fix malformed ISO_END/CONT handling
      Bluetooth: ISO: exclude RFU bits from ISO_SDU_Length
      Bluetooth: 6lowpan: fix cyclic locking warning on netdev unregister

Peddolla Harshavardhan Reddy (1):
      wifi: cfg80211: restrict LMR feedback check to TB and non-TB ranging

Pei Xiao (4):
      hwmon: (gpd-fan): drop global driver data and use per-device allocation
      hwmon: (gpd-fan): Initialize EC before registering hwmon device
      hwmon: (gpd-fan): fix race condition between device removal and sysfs access
      i2c: spacemit: fix spurious IRQ handling returning IRQ_HANDLED

Peiyang He (3):
      ntfs: fix mrec_lock ABBA deadlock in rename
      ntfs: fail attrlist updates when the superblock is inactive
      ntfs: fix hole runlist memory leak in insert range error path

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

Peter Ujfalusi (6):
      ASoC: SOF: ipc4-control: Fix TOCTOU in sof_ipc4_bytes_put
      ASoC: SOF: ipc4-control: Validate notification payload size
      ASoC: SOF: ipc3-control: Use overflow checks in control_update size calc
      ASoC: SOF: ipc3-control: Fix TOCTOU in bytes_put and bytes_get
      ASoC: SOF: ipc3-control: Fix heap overflow in bytes_ext put/get
      ASoC: SOF: ipc3-control: Validate size in snd_sof_update_control

Petr Wozniak (1):
      net: phy: sfp: free mii_bus in sfp_i2c_mdiobus_destroy

Philipp Stanner (1):
      dma-buf: dma-fence: Fix potential NULL pointer dereference

Philippe Schenker (1):
      net: ethernet: ti: icssg: guard PA stat lookups

Phillip Varney (1):
      clk: qcom: a53: Corrected frequency multiplier for 1152MHz

Pranjal Shrivastava (1):
      iommu/vt-d: Fix RB-tree corruption in probe error path

Prasanna Kumar T S M (2):
      soc: xilinx: Fix race condition in event registration
      soc: xilinx: Shutdown and free rx mailbox channel

Prathamesh Deshpande (3):
      IB/mlx5: Fix transport-domain rollback and initialize lb mutex earlier
      RDMA/mlx5: Fix UMR XLT cleanup on ODP populate failure
      RDMA/mlx5: Fix devx subscribe-event unwind NULL dereference

Pratyush Yadav (Google) (3):
      docs: memfd_preservation: fix rendering of ABI documentation
      kho: make sure scratch size is always aligned by CMA_MIN_ALIGNMENT_BYTES
      liveupdate: validate session type before performing operation

Przemyslaw Korba (1):
      idpf: add padding to PTP virtchnl structures

Qiang Ma (3):
      spi: hisi-kunpeng: Use dev_err_probe() for host registration failure
      LoongArch: KVM: Check the return values for put_user()
      LoongArch: KVM: Return full old CSR value from kvm_emu_xchg_csr()

Qiang Yu (2):
      PCI: qcom: Set max OPP before DBI access during resume
      drm/amdgpu: initialize iter.start in amdgpu_devcoredump_format

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

Qiuxu Zhuo (2):
      EDAC/igen6: Fix call trace due to missing release()
      EDAC/igen6: Fix memory topology parsing for Panther Lake-H SoCs

Quang Nguyen (1):
      spi: rpc-if: Use correct device for hardware reinitialization on resume

Quentin Schulz (2):
      arm64: dts: rockchip: fix Ethernet PHY not found on PX30 Cobra
      arm64: dts: rockchip: fix Ethernet PHY not found on PX30 Ringneck

Rafael Beims (2):
      wifi: mwifiex: fix roaming to different channel in host_mlme mode
      wifi: mwifiex: fix permanently busy scans after multiple roam iterations

Rafael J. Wysocki (19):
      platform/chrome: chromeos_privacy_screen: Check ACPI_COMPANION()
      platform/chrome: chromeos_tbmc: Check ACPI_COMPANION()
      platform/chrome: wilco_ec: event: Check ACPI_COMPANION()
      thermal: hwmon: Fix critical temperature attribute removal
      thermal: hwmon: Register a hwmon device for each thermal zone
      ACPI: PAD: Fix teardown ordering in acpi_pad_remove()
      ACPI: button: Fix lid_device value leak past driver removal
      x86/platform/olpc: xo15: Drop wakeup source on driver removal
      platform/x86: xo15-ebook: Fix wakeup source and GPE handling
      iio: light: acpi-als: Check ACPI_COMPANION() against NULL
      platform/x86: classmate-laptop: Address memory leaks on driver removal
      hpet: Check ACPI_COMPANION() against NULL at probe time
      sonypi: Check ACPI_COMPANION() against NULL at probe time
      tpm_crb: Check ACPI_COMPANION() against NULL during probe
      cpuidle: Allow exit latency to exceed target residency
      thermal: testing: zone: Flush work items during cleanup
      ACPICA: Unbreak tools build after switching over to strscpy_pad()
      cpufreq: intel_pstate: Set non-turbo capacity to HWP_GUARANTEED_PERF()
      ACPICA: Define acpi_ut_safe_strncpy() as strscpy_pad() alias

Rajat Gupta (1):
      wifi: mt76: use kfree_rcu for offchannel link in mt76_put_vif_phy_link

Randy Dunlap (3):
      bitops: use common function parameter names
      x86/cpu: Keep the PROCESSOR_SELECT menu together
      Documentation: ABI: sysfs-class-reboot-mode-reboot_modes: fix doc warnings

Ratheesh Kannoth (6):
      octeontx2-af: npc: Fix size of entry2cntr_map
      octeontx2-af: fix NPC mailbox codes in mbox.h
      octeontx2-pf: Fix leak of SQ timestamp buffer on teardown
      octeontx2-af: npc: Log successful MCAM drop-on-non-hit install at debug level
      octeontx2-af: npc: cn20k: fix NPC defrag
      octeontx2-af: fix CGX debugfs RVU AF PCI reference leaks

Ravi Bangoria (1):
      perf test amd ibs: Fix incorrect kernel version check

Ravindra (1):
      Bluetooth: btintel_pcie: Separate coredump work from RX work

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

Richard Fitzgerald (6):
      ASoC: cs35l56: Fix missing calls to wm_adsp2_remove()
      ASoC: cs35l56: Prevent double-free of debugfs
      ASoC: cs35l56: Cleanup if component_probe fails
      ASoC: cs35l56: Don't leave parent IRQ disabled if system_suspend fails
      ASoC: cs35l56: Fix possible uninitialized value in cs35l56_spi_system_reset()
      ASoC: cs35l56: Fix wrong error test on simple_write_to_buffer()

Richard Zhu (1):
      arm64: dts: imx95: Correct PCIe outbound address space configuration

Ripan Deuri (1):
      wifi: ath12k: fix error unwind on arch_init() failure in PCI probe

Ritesh Kumar (1):
      arm64: dts: qcom: lemans: Add eDP ref clock for eDP PHYs

Rob Herring (Arm) (1):
      dt-bindings: net: renesas,ether: Drop example "ethernet-phy-ieee802.3-c22" fallback

Robby Cai (1):
      reset: imx7: Correct polarity of MIPI CSI resets on i.MX8MQ

Robert Mader (1):
      drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE

Robertus Diawan Chris (1):
      mac802154: Prevent overwrite return code in mac802154_perform_association()

Roman Kvasnytskyi (1):
      selftests/bpf: Reject unsupported -k option in vmtest.sh

Roman Li (1):
      drm/amd/display: Skip PHY SSC reduction on some 8K panels

Roman Vivchar (1):
      i2c: mediatek: fix WRRD for SoCs without auto_restart option

Ron de Bruijn (1):
      ntfs: fix off-by-one in mapping pairs decoding bounds checks

Ronaldo Nunez (1):
      pwm: imx27: Fix variable truncation in .apply()

Ronan Dalton (1):
      rtc: ds1307: handle oscillator stop flag for ds1337/ds1339/ds3231

Rong Zhang (1):
      PCI: loongson: Do not ignore downstream devices on external bridges

Rongguang Wei (1):
      s390/zcrypt: Remove the empty file

Rosen Penev (7):
      mips: ralink: mt7621: add missing __iomem
      mips: n64: add __iomem for writel call
      HID: logitech-hidpp: remove excess kernel-doc member in hidpp_scroll_counter
      net: emac: Fix NULL pointer dereference in emac_probe
      net: gianfar: dispose irq mappings on probe failure and device removal
      net: mdio: select REGMAP_MMIO instead of depending on it
      gpio: mvebu: free generic chips on unbind

Ross Porter (1):
      selftests: net: fix file owner for broadcast_ether_dst test

Rui Qi (2):
      riscv: stacktrace: Remove bogus -0x4 offset in non-FP walk_stackframe
      perf: Fix off-by-one stack buffer overflow in kallsyms__parse()

Ruipeng Qi (1):
      f2fs: fix potential deadlock in f2fs_balance_fs()

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

Ryder Lee (4):
      wifi: mt76: mt7915: fix potential tx_retries underflow
      wifi: mt76: mt7921: fix potential tx_retries underflow
      wifi: mt76: mt7925: fix potential tx_retries underflow
      wifi: mt76: mt7996: fix potential tx_retries underflow

Sabrina Dubroca (1):
      espintcp: use sk_msg_free_partial to fix partial send

Sagi Grimberg (1):
      pNFS/filelayout: fix cheking if a layout is striped

Sai Teja Aluvala (1):
      Bluetooth: btintel_pcie: Load IOSF debug regs by controller variant

Samuel Holland (3):
      media: cedrus: Fix failure to clean up hardware on probe failure
      bus: sunxi-rsb: Always check register address validity
      riscv: Fix 32-bit call_on_irq_stack() frame pointer ABI

Samuel Moelius (10):
      thermal: testing: reject missing command arguments
      Bluetooth: hci: validate codec capability element length
      Bluetooth: vhci: validate devcoredump state before side effects
      net: pfcp: allocate per-cpu tstats for PFCP netdevs
      net/sched: dualpi2: clear stale classification on filter miss
      net/sched: hhf: clear heavy-hitter state on reset
      net/sched: cake: reject overhead values that underflow length
      ntfs: detect mapping-pairs LCN accumulator overflow
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

Sayali Patil (14):
      selftests/mm: restore default nr_hugepages value via exit trap in charge_reserved_hugetlb.sh
      selftests/mm: fix hugetlb pathname construction in charge_reserved_hugetlb.sh
      selftests/mm: restore default nr_hugepages value via exit trap in hugetlb_reparenting_test.sh
      selftests/mm: fix hugetlb pathname construction in hugetlb_reparenting_test.sh
      selftests/mm: fix cgroup task placement and drop memory.current checks in hugetlb_reparenting_test.sh
      selftests/mm: size tmpfs according to PMD page size in split_huge_page_test
      selftests/mm: free dynamically allocated PMD-sized buffers in split_huge_page_test
      selftest/mm: register existing mapping with userfaultfd in hugetlb-mremap
      selftests/mm: ensure destination is hugetlb-backed in hugetlb-mremap
      selftests/mm: skip uffd-stress test when nr_pages_per_cpu is zero
      selftests/mm: move hwpoison setup into run_test() and silence modprobe output for memory-failure category
      selftests/mm: clarify alternate unmapping in compaction_test
      selftests/mm: allow PUD-level entries in compound testcase of hmm tests
      selftests/mm: remove hardcoded THP sizing assumptions in hmm tests

Sean Anderson (1):
      media: uvcvideo: Fix deadlock if uvc_status_stop is called from async_ctrl.work

Sean Christopherson (6):
      x86/bug: Add printf() validation to HAVE_ARCH_BUG_FORMAT_ARGS WARNs
      iommu/amd: Fix a stale comment about which legacy mode is user visible
      crypto: ccp - Treat zero-length cert chain as query for blob lengths
      KVM: nVMX: Move vTPR vs. TPR Threshold consistency check into "normal" checks
      KVM: x86: Ignore pending PV EOI if the vCPU has since disabled PV EOIs
      KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails due to invalid guest state

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

Selvin Xavier (9):
      RDMA/bnxt_re: Initialize dpi variable to zero
      RDMA/bnxt_re: Free SRQ toggle page after firmware teardown
      RDMA/bnxt_re: Free CQ toggle page after firmware teardown
      RDMA/bnxt_re: Avoid displaying the kernel pointer
      RDMA/bnxt_re: Add a max slot check for SQ
      RDMA/bnxt_re: Proper rollback if the ioremap fails
      RDMA/bnxt_re: Avoid repeated requests to allocate WC pages
      RDMA/bnxt_re: Fail DBR related page allocation UAPIs if the feature is disabled
      RDMA/bnxt_re: Reject GET_TOGGLE_MEM when toggle page was not allocated

Sen Wang (1):
      ASoC: tlv320aic3x: restrict CLKDIV bypass Q values in dual-rate mode

SeongJae Park (5):
      mm/damon/core: make charge_addr_from aware of end-address exclusivity
      mm/damon/core: always put unsuccessfully committed target pids
      mm/damon/sysfs-schemes: fix dir put orders in access_pattern_add_dirs()
      mm/damon/sysfs-schemes: put stats for scheme_add_dirs() internal error
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

Shawn Guo (2):
      arm64: dts: qcom: lemans: Move PCIe devices into soc node
      PCI: qcom: Disable ASPM L0s for SA8775P

Shay Drory (7):
      net/mlx5: LAG, factor out shared FDB code into dedicated file
      net/mlx5: LAG, replace peer count check with direct peer lookup
      net/mlx5: LAG, prepare for SD device integration
      net/mlx5: LAG, extend shared FDB API with group_id filter
      net/mlx5: LAG, Fix off-by-one in single-FDB error rollback
      net/mlx5: LAG, MPESW, Fix missing complete() on devcom error
      net/mlx5e: TC, skip peer flow cleanup when LAG seq is unavailable

Shengjiu Wang (2):
      dmaengine: imx-sdma: Refine spba bus searching in probe
      ASoC: fsl_asrc_dma: fix eDMA maxburst misalignment with channel count

Shengming Hu (1):
      mm/slub: preserve original size in _kmalloc_nolock_noprof retry path

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

Shuaisong Yang (4):
      net: hns3: unify copper port ksettings configuration path
      net: hns3: refactor MAC autoneg and speed configuration
      net: hns3: fix permanent link down deadlock after reset
      net: hns3: differentiate autoneg default values between copper and fiber

Shuangpeng Bai (2):
      nilfs2: fix backing_dev_info reference leak
      llc: fix SAP refcount leak in llc_ui_autobind()

Shuicheng Lin (4):
      drm/xe/userptr: Hold notifier_lock for write on inject test path
      drm/xe/userptr: Drop bogus static from finish in force_invalidate
      drm/xe/hw_engine: Fix double-free of managed BO in error path
      drm/xe/userptr: Stub notifier_lock helpers when DRM_GPUSVM=n

Shuvam Pandey (4):
      PCI: meson: Propagate devm_add_action_or_reset() failure
      PCI: meson: Add missing remove callback
      PCI: dwc: Avoid dwc_pcie_rasdes_debugfs_deinit() NULL dereference when no RAS DES capability
      accel/amdxdna: Use caller client for debug BO sync

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

Souvik Banerjee (1):
      ovl: use linked upper dentry in copy-up tmpfile

Sriharsha Basavapatna (5):
      RDMA/bnxt_re: Refactor bnxt_re_init_user_qp()
      RDMA/bnxt_re: Update msn table size for app allocated QPs
      RDMA/bnxt_re: Enhance dbr usecnt logic in doorbell uapis
      RDMA/bnxt_re: Support doorbells for app allocated QPs
      RDMA/bnxt_re: Enable app allocated QPs

Srinivas Kandagatla (1):
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

Stefan Metzmacher (2):
      uaccess: fix ignored_trailing logic in copy_struct_to_user()
      sockptr: fix usize check in copy_struct_from_sockptr() for user pointers

Stepan Ionichev (4):
      clk: scpi: Unregister child clock providers on remove
      crypto: ccp/sev-dev-tsm - bail out early when pdev->bus is NULL
      device property: fix fwnode reference leak in fwnode_graph_get_endpoint_by_id()
      rtc: msc313: fix NULL deref in shared IRQ handler at probe

Stephan Gerhold (1):
      serial: msm: Disable DMA for kernel console UART

Stephen Smalley (1):
      selinux: check connect-related permissions on TCP Fast Open

Steve French (1):
      smb: client: preserve leading slash for POSIX absolute symlink targets

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

Sumit Gupta (1):
      memory: tegra186-emc: stop borrowing MC aggregate hook for EMC

Sumit Kumar (2):
      bus: mhi: ep: Fix potential deadlock in mhi_ep_reset_worker()
      bus: mhi: ep: Add missing state_lock protection for mhi_state access

Sun Jian (4):
      bpf: Run generic devmap egress prog on private skb
      bpf: Fix partial copy of non-linear test_run output
      selftests/bpf: Cover negative buffer pointer offsets
      bpf: Reject negative const offsets for buffer pointers

Sungwoo Kim (1):
      Bluetooth: sco: Fix a race condition in sco_sock_timeout()

Suraj Kandpal (1):
      drm/i915/ltphy: Fix SSC Enablement bit in PORT_CLOCK_CTL

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

Tanmay Shah (1):
      remoteproc: xlnx: Check remote core state

Tanushree Shah (1):
      perf data convert json: Fix addr_location leak on time-filtered samples

Tao Cui (1):
      RDMA/counter: Fix incorrect port index in rdma_counter_init() error cleanup

Tao Liu (1):
      riscv: Prevent NULL pointer dereference in machine_kexec_prepare()

Tapio Reijonen (1):
      serial: max310x: implement gpio_chip::get_direction()

Terry Bowman (1):
      cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability size

Tetsuo Handa (1):
      ocfs2: kill osb->system_file_mutex lock

Thadeu Lima de Souza Cascardo (1):
      drm/amdgpu: initialize irq.lock spinlock earlier

Theodor Arsenij Larionov-Trichkine (1):
      netfilter: nft_fib: reject fib expression on the netdev egress hook

Thiébaud Weksteen (1):
      bpf: Fix BPF_PROG_ASSOC_STRUCT_OPS last field check

Thomas Gleixner (3):
      locking/rt: Fix the incorrect RCU protection in rt_spin_unlock()
      posix-timers: Expand timer_[re]arm() callbacks with a boolean return value
      posix-cpu-timers: Prevent UAF caused by non-leader exec() race

Thomas Hellström (1):
      drm/xe: Fix wa_oob codegen recipe for external module builds

Thomas Huth (2):
      selftests/landlock: Skip scoped_signal subtest with MSG_OOB if not available
      selftests/landlock: Fix screwed up pointers in the scoped_signal_test

Thomas Richter (1):
      perf callchain: Handle multiple address spaces

Thomas Weißschuh (7):
      lib: kunit_iov_iter: repeatedly call alloc_pages_bulk()
      riscv: alternative: Use IS_ENABLED() over ifdeffery for apply_vdso_alternatives()
      riscv: alternative: Pass vDSO start as parameter to apply_vdso_alternatives()
      riscv: alternative: Also patch the CFI vDSO
      sparc: Avoid -Wunused-but-set-parameter in clear_user_page()
      riscv: vdso: Always declare vdso_start symbols
      riscv: vdso: Do not use LTO for the vDSO

Thomas Zimmermann (3):
      drm/rockchip: Test for imported buffers with drm_gem_is_imported()
      drm/tegra: fbdev: Do not assign to struct drm_fb_helper.info
      drm/fb-helper: Only consider active CRTCs for vblank sync

Thorsten Blum (5):
      crypto: ecrdsa - fix unknown OID check in ecrdsa_param_curve
      x86/boot: Validate console=uart8250 baud rate to fix early boot hang
      x86/boot: Reject too long acpi_rsdp= values
      tpm: fix event_size output in tpm1_binary_bios_measurements_show
      powerpc/pseries: fix memory leak on krealloc failure in papr_init

Théo Lebrun (1):
      net: macb: drop in-flight Tx SKBs on close

Tianchen Ding (1):
      selftests/ftrace: Fix trace_marker_raw test on 64K page kernels

Tiezhu Yang (2):
      LoongArch: BPF: Fix outdated tail call comments
      LoongArch: BPF: Fix off-by-one error in tail call

Timur Tabi (3):
      drm/nouveau/bios: specify correct display fuse register for Ampere and Ada
      pinctrl: PINCTRL_STMFX should depend on CONFIG_OF
      regulator: core: regulator_lock_two() should test for EDEADLK not EDEADLOCK

Tomas Glozar (1):
      rtla/actions: Restore continue flag in actions_perform()

Tomi Valkeinen (1):
      drm/tidss: Drop extra drm_mode_config_reset() call

Tony Luck (2):
      fs/resctrl: Fix use-after-free during unmount
      fs/resctrl: Free mon_data structures on rdt_get_tree() failure

Tony W Wang-oc (1):
      ACPI: processor: Add cpuidle driver check in acpi_processor_register_idle_driver()

Tristan Madani (12):
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

Tudor Ambarus (1):
      firmware: samsung: acpm: Add devm_acpm_get_by_phandle helper

Tvrtko Ursulin (1):
      dma-fence: Fix potential tracepoint null pointer dereferences

Tycho Andersen (AMD) (5):
      crypto: ccp - Reverse the cleanup order in psp_dev_destroy()
      crypto: ccp - Fix snp_filter_reserved_mem_regions() off-by-one
      crypto: ccp - Check for page allocation failure correctly in TIO
      crypto: ccp - Initialize data during __sev_snp_init_locked()
      x86/virt/sev: Revert "Drop WBINVD before setting MSR_AMD64_SYSCFG_SNP_EN"

Val Packett (1):
      ASoC: codecs: aw88261: fix incorrect masks for boost regs

Vasant Hegde (1):
      iommu/amd: Fix premature break in init_iommu_one()

Vasiliy Kovalev (1):
      net/9p: fix infinite loop in p9_client_rpc on fatal signal

Viacheslav Bocharov (2):
      gpio: shared-proxy: always serialize with a sleeping mutex
      pinctrl: meson: restore non-sleeping GPIO access

Viacheslav Dubeyko (1):
      hfs: fix incorrect inode ID assignment in hfs_new_inode()

Victor Nogueira (5):
      net/sched: sch_hfsc: Don't make class passive twice
      net/sched: sch_fq_codel: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
      net/sched: sch_codel: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
      net/sched: sch_dualpi2: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
      net/sched: sch_dualpi2: Add missing module alias

Vincent Donnefort (3):
      tracing/remotes: Fix leak in trace_remote_alloc_buffer() error path
      tracing/remotes: Fix struct_len in trace_remote_alloc_buffer()
      ring-buffer: Allow sparse CPU masks in ring_buffer_desc()

Vincent Guittot (1):
      sched/fair: Update util_est after updating util_avg during dequeue

Vincent Jardin (2):
      i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)
      i2c: imx: fix locked bus on SMBus block-read of 0 (IRQ)

Vitaly Prosyak (2):
      drm/amdgpu: fix KASAN slab-out-of-bounds in amdgpu_coredump ring dump
      drm/amd/pm: Add empty string validation to sysfs store functions

Vladimir Zapolskiy (1):
      gpio: timberdale: Return -ENOMEM on dynamic memory allocation in probe

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

Wayen.Yan (4):
      net: airoha: Fix error handling in airoha_ppe_flush_sram_entries()
      net: airoha: Fix register index for Tx-fwd counter configuration
      net: airoha: Fix debugfs new-tuple display for IPv4 ROUTE entries
      net: airoha: Fix always-true condition in PPE1 queue reservation loop

Wei Fang (2):
      net: enetc: fix potential divide-by-zero when num_vsi is zero
      net: enetc: check the number of BDs needed for xdp_frame

Wei Zhang (3):
      wifi: ath11k: cancel SSR work items during PCI shutdown
      wifi: ath12k: fix inconsistent arvif state in vdev_create error paths
      wifi: ath12k: fix NULL deref in change_sta_links for unready link

Weili Qian (1):
      crypto: hisilicon/qm - disable error report before flr

Weiming Shi (9):
      crypto: asymmetric_keys - fix OOB read in pefile_digest_pe_contents
      btrfs: lzo: reject compressed segment that overflows the compressed input
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

Wolfram Sang (2):
      hwspinlock: qcom: avoid uninitialized struct members
      mailbox: don't free the channel if the startup callback failed

Woojin Ji (1):
      bpftool: Use libbpf error code for flow dissector query

Woraphat Khiaodaeng (1):
      io_uring/bpf-ops: reject re-registration of an already-bound ops

Wyatt Feng (5):
      rxrpc: Fix ACKALL packet handling
      netfilter: xt_u32: reject invalid shift counts
      netfilter: xt_connmark: reject invalid shift parameters
      netfilter: xt_cluster: reject template conntracks in hash match
      netfilter: xt_nat: reject unsupported target families

Xiang Mei (12):
      bridge: cfm: reject invalid CCM interval at configuration time
      virtio-net: fix len check in receive_big()
      drm/edid: fix OOB read in drm_parse_tiled_block()
      ipv6: Fix null-ptr-deref in fib6_nh_mtu_change().
      net, bpf: check master for NULL in xdp_master_redirect()
      geneve: gate GRO hint in geneve_gro_complete() on gs->gro_hint
      geneve: validate inner network offset in geneve_gro_complete()
      usbnet: gl620a: fix out-of-bounds read in genelink_rx_fixup()
      net: usb: net1080: validate packet_len before pad-byte access in rx_fixup
      net: qualcomm: rmnet: validate MAP frame length before ingress parsing
      net/smc: fix UAF in smc_cdc_rx_handler() by pinning the socket
      netfilter: nf_conntrack_reasm: guard mac_header adjustment after IPv6 defrag

Xiang Mei (Microsoft) (1):
      netfilter: bridge: fix stale prevhdr pointer in br_ip6_fragment()

Xianwei Zhao (1):
      pinctrl: meson: amlogic-a4: fix gpio output glitch

Xin Long (5):
      sctp: validate embedded address parameter length
      sctp: hold socket lock when dumping endpoints in sctp_diag
      sctp: fix err_chunk memory leaks in INIT handling
      sctp: add INIT verification after cookie unpacking
      sctp: fix addr_wq_timer race in sctp_free_addr_wq()

Xingjing Deng (1):
      kconfig: fix potential NULL pointer dereference in conf_askvalue

Xu Kuohai (1):
      bpf: Fix setting retval to -EPERM for cgroup hooks not returning errno

Xu Rao (7):
      ALSA: hda: Fix cached processing coefficient verbs
      thunderbolt: debugfs: Fix margining error counter buffer leak
      ALSA: usb-audio: qcom: Free sideband sg_table objects
      ACPI: IPMI: Fix inverted interface check in ipmi_bmc_gone()
      scsi: sg: Report request-table problems when any status is set
      ACPI: TAD: Check AC wake capability before enabling wakeup
      mtd: virt-concat: free duplicate generated name

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

Yang Wang (2):
      drm/amd/pm: remove trailing semicolon from AMDGPU_PM_POLICY_ATTR macro
      drm/amdgpu: fix error return code in mes_v12_1_map_test_bo

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

Yixun Lan (4):
      dts: riscv: spacemit: correct 32k clock frequency
      dts: riscv: spacemit: k3: Fix I/O power settings
      clk: spacemit: k3: Switch to pll2_d6 as parent for PCIe clock
      clk: spacemit: k3: Fix PCIe clock register offset

Yiyang Chen (6):
      bpf: Guard conntrack opts error writes
      selftests/bpf: Cover small conntrack opts error writes
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

Yu-Chun Lin (1):
      dt-bindings: pinctrl: realtek,rtd1625: Fix input voltage property name

Yuanhe Shu (1):
      Revert "PCI/MSI: Unmap MSI-X region on error"

Yuho Choi (10):
      drm/radeon: fix memory leak in radeon_ring_restore() on lock failure
      media: atomisp: gc2235: fix UAF and memory leak
      ARM: imx3: Fix CCM node reference leak
      ARM: imx31: Fix IIM mapping leak in revision check
      ACPI: IPMI: Fix message kref handling on dead device
      watchdog: unregister PM notifier on watchdog unregister
      PM: QoS: Fix misc device registration unwind
      clk: at91: keep securam node alive while mapping it
      irqchip/gic-v3-its: Fix OF node reference leak
      net/liquidio: drop cached VF pci_dev LUT

Yun Zhou (3):
      ext4: validate donor file superblock early in EXT4_IOC_MOVE_EXT
      flow_dissector: check device type before reading ETH_ADDRS
      net: mvneta: re-enable percpu interrupt on resume

Yunxiang Li (2):
      drm/amdgpu: set sub_block_index for mca ras sub-blocks
      drm/amdkfd: Avoid double-unpin of DOORBELL/MMIO BOs on free

Yury Norov (3):
      rust: uaccess: use INLINE_COPY_TO_USER to guard copy_to_user()
      uaccess: unify inline vs outline copy_{from,to}_user() selection
      uaccess: minimize INLINE_COPY_USER-related ifdefery

Yuyang Huang (4):
      bpf: fix BPF_PROG_QUERY OOB write and cgroup backward compat
      selftests/bpf: add verification for BPF_PROG_QUERY attr size boundaries
      ipv4: igmp: annotate data-races around im->users
      ipv4: igmp: annotate data-races around timer-related fields

Zenghui Yu (1):
      samples/damon/mtier: fail early if address range parameters are invalid

Zhan Xusheng (7):
      alarmtimer: Remove stale return description from alarm_handle_timer()
      timers/migration: Update stale @online doc to @available
      docs: changes.rst: restore pahole 1.26 minimum (regressed by sort)
      fs/ntfs3: fix wrong LCN in run_remove_range() when splitting a run
      erofs: handle 48-bit blocks_hi for compressed inodes
      fs/ntfs3: fix syncing wrong inode on DIRSYNC cross-directory rename
      posix-cpu-timers: Use u64 multiplication in update_rlimit_cpu()

Zhang Cen (5):
      ALSA: seq: midi: Serialize output teardown with event_input
      ocfs2: rebase copied fsdlm LVB pointers in locking_state
      ocfs2: validate fast symlink target during inode read
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

Zhao Dongdong (3):
      Bluetooth: btmtk: fix URB leak in alloc_mtk_intr_urb error path
      ASoC: SOF: topology: fix memory leak in snd_sof_load_topology
      reset: sunxi: fix memory region leak on ioremap failure

Zhao Li (2):
      wifi: ieee80211: validate MLE common info length
      wifi: mac80211: validate extension-frame layout before RX

ZhaoJinming (3):
      ice: dpll: set pointers to NULL after kfree in ice_dpll_deinit_info
      ice: dpll: fix memory leak in ice_dpll_init_info error paths
      platform/x86/intel/tpmi: use cleanup helpers in mem_write()

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

Zhongqiu Han (3):
      cpufreq: governor: Fix data races on per-CPU idle/nice baselines
      cpufreq: governor: Fix stale prev_cpu_nice spike when enabling ignore_nice_load
      cpufreq: schedutil: Fix uncleared need_freq_update on the .adjust_perf() path

Zhu Lingshan (1):
      amdkfd: properly free secondary context id

Zhu Yanjun (1):
      RDMA/rxe: Fix a use-after-free problem in rxe_mmap

Zi Yan (1):
      mm/compaction: handle free_pages_prepare() properly in compaction_free()

Zide Chen (2):
      perf/x86/intel/uncore: Fix discovery unit lookup for multi-die systems
      perf/x86/intel/uncore: Fix PCI device refcount leak in UPI discovery

Zihan Xi (1):
      net/sched: act_ct: preserve tc_skb_cb across defragmentation

Zijun Hu (2):
      Bluetooth: hci_qca: fix NULL pointer dereference in qca_setup() for non-serdev device
      Bluetooth: hci_qca: fix NULL pointer dereference in qca_dmp_hdr() for non-serdev device

Zilin Guan (2):
      media: atomisp: Fix memory leak in atomisp_fixed_pattern_table()
      afs: use kvfree() to free memory allocated by kvcalloc()

Zishun Yi (1):
      riscv: cacheinfo: Fix node reference leak in populate_cache_leaves

Zizhi Wo (1):
      smb: client: fix busy dentry warning on unmount after DIO

Zygmunt Krynicki (5):
      apparmor: aa_label_alloc use aa_label_free on alloc failure
      apparmor: fail policy unpack on accept2 allocation failure
      apparmor: release exe file resources on path failure
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

