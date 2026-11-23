Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420819;
	b=mWo8QC+8p7lYn9E9P4IuhC55zBX/xqak08XVdwGCQgaP/qBCoMf54D+izgxun7S+IkYB
	 7GHZ8raBrNNOnXVNOgLugrHE+dAV/YOs+SscO1aMvwzdU3FXawsYyv2rJljj2lvuA0sm8
	 2hPAGuuPhPLgINEI6nHZHkvrY+1Iy2pgBRyEiakifTX1YsPxQQCRgAy1lM/jYtUTZiH1T
	 Ind4KKLrZtaxxDbTPVqOftJyVjvrMulkP5lhMHK7i7LA3kTLsplE54mtlKYozYHnZxS6z
	 aVlaiDZUYqvaK3RVZ8LoS2Tpj+QaO9vSI7qdfbabtQMrlxNOj0pt6Lkb378rdwAQBvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420819;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=C98oD2XZdEFGQjq4lUlzaPp84bNidXYpJGCjXpPCQdo=;
	b=ncTaWobkuczzT06PCQuywl/V5LYt18SIMcN+ub+WQ+oja/8Ut79KvdqJ7r9YIvIMlb4U
	 l6JsQOoyG7jtiVI3aX/f+o7EEd/2QqzWeaQcVMZFjYIvnUMSlBU9eps2U5pDw0/JGypWl
	 Y2N5Dc5xxb/FKMk916DLBLKwKsp0SPeUJrxa3K74va5MQZSywCt0XbCa3Yk/xGJuUJpjz
	 93AzVKDNXUWTfKJiQXVBeU7gKdlaq3Xzj2BFWMynrYSXO+1UQ6b4RxPCoMoCnISBVmHbb
	 ykLJsP/mZ5BWvIwzsQJpoDqmfftFaFiFZ0Kip5W/r7tKmTdAeYak4/NPCb86myPZNGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=n1A0zfOP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D760A3820;
	Mon, 23 Nov 2026 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=n1A0zfOP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455481F0156E;
	Mon, 23 Nov 2026 08:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795420818;
	bh=C98oD2XZdEFGQjq4lUlzaPp84bNidXYpJGCjXpPCQdo=;
	h=From:To:Cc:Subject:Date;
	b=n1A0zfOP0t16hq7WxlxDvnJMFyJO4r/fv6UYb/MxNBhvjfJJuhM53uH9Ig9MNtykX
	 Y39SuoHa1lMkOB7b/q0LEriekWIiqlUYapN5AEdf4lckgCvHZ9J/zFLooNm6ibm7Ae
	 /1ugg3wB1Tinp0fUsl/OM3qRP8pLzRbe79ZGtNsw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.163
Date: Mon, 23 Nov 2026 08:59:48 +0100
Message-ID: <2026112349-declared-recipient-3f72@gregkh>
X-Mailer: git-send-email 2.56.1
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

I'm announcing the release of the 6.6.163 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 .gitignore                                                                    |    1 
 Documentation/ABI/testing/sysfs-bus-pci                                       |   14 
 Documentation/ABI/testing/sysfs-class-power-mp2629                            |    2 
 Documentation/admin-guide/LSM/LoadPin.rst                                     |   10 
 Documentation/admin-guide/cgroup-v2.rst                                       |   10 
 Documentation/admin-guide/kernel-parameters.txt                               |    5 
 Documentation/block/blk-mq.rst                                                |    2 
 Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml              |    2 
 Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml                |    2 
 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml               |   16 
 Documentation/devicetree/bindings/display/msm/dsi-phy-common.yaml             |    2 
 Documentation/devicetree/bindings/display/msm/hdmi.yaml                       |    4 
 Documentation/devicetree/bindings/dma/stericsson,dma40.yaml                   |   14 
 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml                |    3 
 Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml |   21 
 Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml |   76 
 Documentation/devicetree/bindings/vendor-prefixes.yaml                        |   40 
 Documentation/filesystems/fsverity.rst                                        |    3 
 Documentation/filesystems/overlayfs.rst                                       |    3 
 Documentation/networking/ip-sysctl.rst                                        |    5 
 Documentation/networking/rxrpc.rst                                            |   13 
 Documentation/trace/histogram.rst                                             |    3 
 Documentation/virt/hyperv/vmbus.rst                                           |   17 
 Documentation/virt/kvm/x86/msr.rst                                            |    1 
 MAINTAINERS                                                                   |    4 
 Makefile                                                                      |    2 
 arch/alpha/Kconfig                                                            |    1 
 arch/alpha/include/asm/mmu_context.h                                          |   36 
 arch/alpha/include/asm/sfp-machine.h                                          |    4 
 arch/alpha/include/asm/switch_to.h                                            |    1 
 arch/alpha/include/asm/tlbflush.h                                             |    3 
 arch/alpha/kernel/rtc.c                                                       |   37 
 arch/alpha/kernel/smp.c                                                       |   67 
 arch/alpha/mm/fault.c                                                         |   52 
 arch/alpha/mm/tlbflush.c                                                      |   18 
 arch/arc/Makefile                                                             |    9 
 arch/arc/lib/Makefile                                                         |    8 
 arch/arm/boot/dts/gemini/gemini.dtsi                                          |    2 
 arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi                        |    2 
 arch/arm/boot/dts/marvell/armada-388-helios4.dts                              |   23 
 arch/arm/boot/dts/marvell/armada-395-gp.dts                                   |    1 
 arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi                                     |   40 
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi                                      |   30 
 arch/arm/boot/dts/st/ste-ab8505.dtsi                                          |   17 
 arch/arm/boot/dts/st/stm32mp157c-lxa-mc1.dts                                  |    2 
 arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi                                 |    2 
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi                               |    2 
 arch/arm/include/asm/domain.h                                                 |   17 
 arch/arm/include/asm/memory.h                                                 |    4 
 arch/arm/include/asm/pgtable-2level-hwdef.h                                   |    1 
 arch/arm/include/asm/pgtable-2level.h                                         |    7 
 arch/arm/include/asm/smp.h                                                    |    2 
 arch/arm/include/asm/sparsemem.h                                              |    4 
 arch/arm/kernel/efi.c                                                         |   13 
 arch/arm/kernel/head-nommu.S                                                  |    1 
 arch/arm/kernel/head.S                                                        |    1 
 arch/arm/kernel/smp.c                                                         |   15 
 arch/arm/mach-mvebu/Kconfig                                                   |    4 
 arch/arm/mach-versatile/platsmp-vexpress.c                                    |    4 
 arch/arm/mach-versatile/v2m.c                                                 |    4 
 arch/arm/mm/Kconfig                                                           |    7 
 arch/arm/mm/alignment.c                                                       |   61 
 arch/arm/mm/dma-mapping.c                                                     |    5 
 arch/arm/mm/ioremap.c                                                         |   53 
 arch/arm/mm/mmu.c                                                             |   76 
 arch/arm64/Kconfig.platforms                                                  |    1 
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi                                  |    4 
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi                             |    9 
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts                          |    4 
 arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi                        |    7 
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts                                 |    4 
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi                                     |    1 
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                                      |    2 
 arch/arm64/boot/dts/qcom/ipq9574.dtsi                                         |    2 
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi                                    |    8 
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi                                |   13 
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi                         |    2 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi                  |    6 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts                            |    6 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                          |    2 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                                      |    2 
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts                               |   32 
 arch/arm64/boot/dts/rockchip/rk3566-base.dtsi                                 |   39 
 arch/arm64/boot/dts/rockchip/rk3566.dtsi                                      |  116 
 arch/arm64/boot/dts/rockchip/rk3568.dtsi                                      |  117 
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi                                 | 1840 
 arch/arm64/boot/dts/rockchip/rk356x.dtsi                                      | 1881 
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi                               |    2 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                                    |  102 
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts                                |    6 
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                                       |    2 
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi                                |    4 
 arch/arm64/crypto/poly1305-armv8.pl                                           |    2 
 arch/arm64/include/asm/kvm_host.h                                             |    7 
 arch/arm64/include/asm/percpu.h                                               |   17 
 arch/arm64/include/asm/sdei.h                                                 |    3 
 arch/arm64/include/asm/suspend.h                                              |    2 
 arch/arm64/kernel/efi.c                                                       |    8 
 arch/arm64/kernel/entry-common.c                                              |   40 
 arch/arm64/kernel/machine_kexec.c                                             |    2 
 arch/arm64/kernel/machine_kexec_file.c                                        |    2 
 arch/arm64/kernel/pi/Makefile                                                 |    1 
 arch/arm64/kernel/sdei.c                                                      |   61 
 arch/arm64/kernel/topology.c                                                  |   13 
 arch/arm64/kvm/arch_timer.c                                                   |   16 
 arch/arm64/kvm/arm.c                                                          |   48 
 arch/arm64/kvm/hyp/exception.c                                                |    5 
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h                                    |   28 
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h                                |    3 
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h                                        |    2 
 arch/arm64/kvm/hyp/nvhe/pkvm.c                                                |   43 
 arch/arm64/kvm/hyp/nvhe/setup.c                                               |   10 
 arch/arm64/kvm/hyp/nvhe/sys_regs.c                                            |    9 
 arch/arm64/kvm/hyp/vhe/switch.c                                               |    3 
 arch/arm64/kvm/vgic/vgic-its.c                                                |   37 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                            |   43 
 arch/arm64/mm/mmap.c                                                          |    4 
 arch/arm64/mm/mmu.c                                                           |   14 
 arch/arm64/mm/proc.S                                                          |   16 
 arch/loongarch/include/asm/hw_breakpoint.h                                    |    8 
 arch/loongarch/include/asm/loongarch.h                                        |    7 
 arch/loongarch/include/asm/numa.h                                             |    2 
 arch/loongarch/include/asm/processor.h                                        |    1 
 arch/loongarch/include/asm/switch_to.h                                        |    2 
 arch/loongarch/kernel/hw_breakpoint.c                                         |   66 
 arch/loongarch/kernel/irq.c                                                   |    3 
 arch/loongarch/kernel/traps.c                                                 |   13 
 arch/loongarch/pci/pci.c                                                      |    3 
 arch/m68k/68000/entry.S                                                       |   24 
 arch/m68k/apollo/dn_ints.c                                                    |    6 
 arch/m68k/coldfire/entry.S                                                    |    3 
 arch/microblaze/Makefile                                                      |    6 
 arch/microblaze/include/asm/entry.h                                           |   13 
 arch/microblaze/include/asm/processor.h                                       |    2 
 arch/microblaze/include/asm/uaccess.h                                         |    3 
 arch/microblaze/kernel/cpu/cpuinfo.c                                          |    1 
 arch/microblaze/kernel/entry.S                                                |  348 
 arch/microblaze/kernel/hw_exception_handler.S                                 |    5 
 arch/microblaze/kernel/process.c                                              |    5 
 arch/microblaze/kernel/ptrace.c                                               |    3 
 arch/microblaze/kernel/signal.c                                               |   26 
 arch/mips/Makefile                                                            |   22 
 arch/mips/cavium-octeon/dma-octeon.c                                          |    2 
 arch/mips/crypto/Kconfig                                                      |    6 
 arch/mips/mm/cex-gen.S                                                        |   16 
 arch/mips/mm/tlb-r4k.c                                                        |   21 
 arch/mips/pci/ops-mace.c                                                      |   26 
 arch/mips/pci/pci-ip32.c                                                      |    9 
 arch/mips/sgi-ip32/ip32-irq.c                                                 |   45 
 arch/nios2/kernel/nios2_ksyms.c                                               |    1 
 arch/openrisc/kernel/or32_ksyms.c                                             |    1 
 arch/powerpc/kernel/trace/ftrace_entry.S                                      |    6 
 arch/powerpc/kvm/book3s_hv.c                                                  |   76 
 arch/powerpc/kvm/book3s_paired_singles.c                                      |    7 
 arch/powerpc/net/bpf_jit.h                                                    |    7 
 arch/powerpc/net/bpf_jit_comp.c                                               |   34 
 arch/powerpc/perf/hv-24x7.c                                                   |   10 
 arch/powerpc/perf/imc-pmu.c                                                   |   23 
 arch/powerpc/platforms/pseries/iommu.c                                        |   68 
 arch/powerpc/platforms/pseries/plpks.c                                        |   27 
 arch/riscv/include/asm/insn.h                                                 |    2 
 arch/riscv/include/asm/pgtable.h                                              |    9 
 arch/riscv/kernel/traps.c                                                     |    3 
 arch/riscv/kvm/mmu.c                                                          |    2 
 arch/riscv/kvm/vcpu_exit.c                                                    |    2 
 arch/riscv/kvm/vcpu_sbi_replace.c                                             |   12 
 arch/riscv/net/bpf_jit_comp32.c                                               |   47 
 arch/s390/crypto/aes_s390.c                                                   |   69 
 arch/s390/kernel/perf_cpum_cf.c                                               |    3 
 arch/s390/kernel/process.c                                                    |   12 
 arch/s390/kernel/signal.c                                                     |    6 
 arch/s390/kernel/uprobes.c                                                    |    2 
 arch/s390/lib/probes.c                                                        |    2 
 arch/s390/pci/pci_irq.c                                                       |   26 
 arch/sh/Kconfig                                                               |    2 
 arch/sh/boards/board-sh7785lcr.c                                              |    2 
 arch/sh/configs/migor_defconfig                                               |    2 
 arch/sh/configs/sdk7786_defconfig                                             |    2 
 arch/sh/configs/shx3_defconfig                                                |    2 
 arch/sh/include/asm/cmpxchg.h                                                 |    3 
 arch/sh/include/asm/uaccess_32.h                                              |    8 
 arch/x86/events/core.c                                                        |   19 
 arch/x86/events/intel/lbr.c                                                   |    2 
 arch/x86/events/intel/uncore.c                                                |    5 
 arch/x86/include/asm/barrier.h                                                |    2 
 arch/x86/include/asm/cpufeatures.h                                            |    7 
 arch/x86/include/asm/kvm-x86-ops.h                                            |    1 
 arch/x86/include/asm/kvm_host.h                                               |   23 
 arch/x86/include/asm/svm.h                                                    |    4 
 arch/x86/include/asm/xor_avx.h                                                |    4 
 arch/x86/include/uapi/asm/kvm_para.h                                          |    1 
 arch/x86/kernel/acpi/cppc.c                                                   |   15 
 arch/x86/kernel/cpu/amd.c                                                     |   15 
 arch/x86/kernel/cpu/common.c                                                  |    4 
 arch/x86/kernel/cpu/mce/core.c                                                |   23 
 arch/x86/kernel/cpu/microcode/amd.c                                           |   12 
 arch/x86/kernel/cpu/microcode/intel.c                                         |   27 
 arch/x86/kernel/cpu/scattered.c                                               |    1 
 arch/x86/kernel/crash.c                                                       |    6 
 arch/x86/kernel/kvm.c                                                         |   43 
 arch/x86/kernel/nmi.c                                                         |    8 
 arch/x86/kernel/process.c                                                     |    1 
 arch/x86/kernel/x86_init.c                                                    |    2 
 arch/x86/kvm/Kconfig                                                          |   14 
 arch/x86/kvm/Makefile                                                         |   20 
 arch/x86/kvm/cpuid.c                                                          |   11 
 arch/x86/kvm/hyperv.c                                                         |    2 
 arch/x86/kvm/hyperv.h                                                         |   61 
 arch/x86/kvm/irq.c                                                            |    2 
 arch/x86/kvm/irq_comm.c                                                       |    9 
 arch/x86/kvm/mmu/mmu.c                                                        |   13 
 arch/x86/kvm/mmu/paging_tmpl.h                                                |   24 
 arch/x86/kvm/reverse_cpuid.h                                                  |    2 
 arch/x86/kvm/svm/hyperv.h                                                     |    9 
 arch/x86/kvm/svm/nested.c                                                     |   34 
 arch/x86/kvm/svm/sev.c                                                        |    6 
 arch/x86/kvm/svm/svm.c                                                        |   37 
 arch/x86/kvm/svm/svm.h                                                        |    4 
 arch/x86/kvm/vmx/hyperv.c                                                     |  308 
 arch/x86/kvm/vmx/hyperv.h                                                     |  189 
 arch/x86/kvm/vmx/hyperv_evmcs.c                                               |  315 
 arch/x86/kvm/vmx/hyperv_evmcs.h                                               |  166 
 arch/x86/kvm/vmx/nested.c                                                     |  148 
 arch/x86/kvm/vmx/nested.h                                                     |    1 
 arch/x86/kvm/vmx/vmx.c                                                        |    8 
 arch/x86/kvm/vmx/vmx.h                                                        |   10 
 arch/x86/kvm/vmx/vmx_onhyperv.h                                               |    3 
 arch/x86/kvm/x86.c                                                            |  189 
 arch/x86/kvm/xen.c                                                            |   10 
 arch/x86/mm/mem_encrypt_identity.c                                            |    2 
 arch/x86/platform/pvh/enlighten.c                                             |    2 
 arch/x86/power/hibernate.c                                                    |   51 
 block/bdev.c                                                                  |   22 
 block/bfq-iosched.c                                                           |    4 
 block/blk-cgroup.c                                                            |   19 
 block/blk-cgroup.h                                                            |    6 
 block/blk-crypto-fallback.c                                                   |    6 
 block/blk-flush.c                                                             |    8 
 block/blk-iocost.c                                                            |   11 
 block/blk-iolatency.c                                                         |    3 
 block/blk-map.c                                                               |    1 
 block/blk-merge.c                                                             |    8 
 block/blk-mq.c                                                                |   47 
 block/blk-rq-qos.c                                                            |   18 
 block/blk-throttle.c                                                          |    3 
 block/blk-timeout.c                                                           |    3 
 block/blk.h                                                                   |   22 
 block/bsg.c                                                                   |    5 
 block/fops.c                                                                  |   12 
 block/ioctl.c                                                                 |    4 
 block/partitions/mac.c                                                        |    4 
 crypto/algif_skcipher.c                                                       |    9 
 crypto/asymmetric_keys/verify_pefile.c                                        |    5 
 crypto/ecc.c                                                                  |   33 
 crypto/tcrypt.c                                                               |  182 
 crypto/testmgr.c                                                              |   10 
 crypto/testmgr.h                                                              |  339 
 drivers/accel/qaic/qaic_data.c                                                |    8 
 drivers/accessibility/speakup/selection.c                                     |    6 
 drivers/acpi/acpi_extlog.c                                                    |    9 
 drivers/acpi/acpi_fpdt.c                                                      |   53 
 drivers/acpi/acpi_pcc.c                                                       |   29 
 drivers/acpi/acpi_video.c                                                     |   12 
 drivers/acpi/acpica/dsfield.c                                                 |    3 
 drivers/acpi/acpica/exfield.c                                                 |   11 
 drivers/acpi/acpica/nsxfname.c                                                |    1 
 drivers/acpi/apei/ghes.c                                                      |   16 
 drivers/acpi/button.c                                                         |   23 
 drivers/acpi/cppc_acpi.c                                                      |   80 
 drivers/acpi/device_pm.c                                                      |   77 
 drivers/acpi/glue.c                                                           |   10 
 drivers/acpi/numa/hmat.c                                                      |    2 
 drivers/acpi/pci_link.c                                                       |    1 
 drivers/acpi/pci_root.c                                                       |   22 
 drivers/acpi/pfr_update.c                                                     |    2 
 drivers/acpi/scan.c                                                           |   40 
 drivers/acpi/tables.c                                                         |    3 
 drivers/ata/Kconfig                                                           |    7 
 drivers/ata/Makefile                                                          |    1 
 drivers/ata/ahci_st.c                                                         |   78 
 drivers/ata/ata_generic.c                                                     |    6 
 drivers/ata/libahci.c                                                         |   45 
 drivers/ata/libahci_platform.c                                                |   25 
 drivers/ata/libata-core.c                                                     |   89 
 drivers/ata/libata-pmp.c                                                      |   14 
 drivers/ata/libata-scsi.c                                                     |   32 
 drivers/ata/libata-sff.c                                                      |   15 
 drivers/ata/pata_cs5520.c                                                     |    2 
 drivers/ata/pata_parport/pata_parport.c                                       |    9 
 drivers/ata/sata_dwc_460ex.c                                                  |    5 
 drivers/ata/sata_fsl.c                                                        |   24 
 drivers/ata/sata_inic162x.c                                                   |  902 
 drivers/ata/sata_qstor.c                                                      |    8 
 drivers/base/attribute_container.c                                            |    7 
 drivers/base/base.h                                                           |    1 
 drivers/base/bus.c                                                            |   35 
 drivers/base/core.c                                                           |   13 
 drivers/base/dd.c                                                             |   92 
 drivers/base/node.c                                                           |   17 
 drivers/base/power/wakeirq.c                                                  |   26 
 drivers/base/regmap/regcache-maple.c                                          |    2 
 drivers/block/amiflop.c                                                       |   69 
 drivers/block/aoe/aoenet.c                                                    |   14 
 drivers/block/drbd/drbd_main.c                                                |    1 
 drivers/block/drbd/drbd_receiver.c                                            |    2 
 drivers/block/floppy.c                                                        |   18 
 drivers/block/loop.c                                                          |    6 
 drivers/block/rnbd/rnbd-srv-sysfs.c                                           |   28 
 drivers/block/rnbd/rnbd-srv.c                                                 |   36 
 drivers/block/swim.c                                                          |  177 
 drivers/block/swim3.c                                                         |    8 
 drivers/block/swim_asm.S                                                      |  136 
 drivers/block/virtio_blk.c                                                    |    2 
 drivers/block/xen-blkback/blkback.c                                           |    7 
 drivers/block/xen-blkfront.c                                                  |   16 
 drivers/bluetooth/btintel.c                                                   |    6 
 drivers/bluetooth/btmtk.c                                                     |   12 
 drivers/bluetooth/btrsi.c                                                     |    3 
 drivers/bluetooth/btusb.c                                                     |   23 
 drivers/bluetooth/hci_bcsp.c                                                  |    5 
 drivers/bluetooth/hci_nokia.c                                                 |   20 
 drivers/bluetooth/hci_vhci.c                                                  |    4 
 drivers/bluetooth/virtio_bt.c                                                 |    4 
 drivers/bus/arm-cci.c                                                         |    6 
 drivers/char/hw_random/amd-rng.c                                              |    2 
 drivers/char/hw_random/ba431-rng.c                                            |    2 
 drivers/char/hw_random/cctrng.c                                               |    7 
 drivers/char/hw_random/core.c                                                 |    1 
 drivers/char/hw_random/intel-rng.c                                            |    5 
 drivers/char/hw_random/jh7110-trng.c                                          |   39 
 drivers/char/hw_random/virtio-rng.c                                           |   13 
 drivers/char/ipmi/ipmi_msghandler.c                                           |    1 
 drivers/char/scx200_gpio.c                                                    |    8 
 drivers/char/tpm/tpm-dev-common.c                                             |    3 
 drivers/char/tpm/tpm2-cmd.c                                                   |    3 
 drivers/char/tpm/tpm_nsc.c                                                    |    8 
 drivers/char/tpm/tpm_tis_spi.h                                                |    8 
 drivers/char/virtio_console.c                                                 |   13 
 drivers/clk/bcm/clk-raspberrypi.c                                             |    2 
 drivers/clk/clk-cdce925.c                                                     |    9 
 drivers/clk/clk-lmk04832.c                                                    |    3 
 drivers/clk/clk-lochnagar.c                                                   |    9 
 drivers/clk/clk-milbeaut.c                                                    |   10 
 drivers/clk/clk-renesas-pcie.c                                                |    5 
 drivers/clk/clk-s2mps11.c                                                     |   12 
 drivers/clk/clk-si521xx.c                                                     |    2 
 drivers/clk/clk-si5351.c                                                      |   20 
 drivers/clk/clk.c                                                             |   51 
 drivers/clk/clk.h                                                             |    5 
 drivers/clk/clkdev.c                                                          |    4 
 drivers/clk/davinci/da8xx-cfgchip.c                                           |    8 
 drivers/clk/davinci/pll.c                                                     |   10 
 drivers/clk/davinci/psc.c                                                     |   10 
 drivers/clk/imx/clk-composite-93.c                                            |   11 
 drivers/clk/imx/clk-imx8qxp-lpcg.c                                            |    1 
 drivers/clk/imx/clk-imx8qxp.c                                                 |    1 
 drivers/clk/imx/clk.c                                                         |   15 
 drivers/clk/mediatek/reset.c                                                  |   61 
 drivers/clk/mediatek/reset.h                                                  |   16 
 drivers/clk/mstar/clk-msc313-mpll.c                                           |    2 
 drivers/clk/mvebu/ap-cpu-clk.c                                                |    4 
 drivers/clk/nuvoton/clk-ma35d1.c                                              |    7 
 drivers/clk/qcom/clk-rcg2.c                                                   |   35 
 drivers/clk/qcom/dispcc-sm8450.c                                              |    2 
 drivers/clk/qcom/gcc-ipq5018.c                                                |   10 
 drivers/clk/qcom/gcc-ipq5332.c                                                |    1 
 drivers/clk/qcom/gcc-msm8960.c                                                |   13 
 drivers/clk/qcom/gcc-msm8974.c                                                |   10 
 drivers/clk/qcom/kpss-xcc.c                                                   |    9 
 drivers/clk/qcom/krait-cc.c                                                   |   14 
 drivers/clk/qcom/mmcc-msm8960.c                                               |   19 
 drivers/clk/qcom/mmcc-msm8996.c                                               |    4 
 drivers/clk/qcom/mmcc-sdm660.c                                                |   10 
 drivers/clk/rockchip/clk-rk3399.c                                             |    9 
 drivers/clk/samsung/clk-exynos-clkout.c                                       |    5 
 drivers/clk/starfive/clk-starfive-jh7110-isp.c                                |    2 
 drivers/clk/starfive/clk-starfive-jh7110-sys.c                                |    3 
 drivers/clk/sunxi-ng/ccu_common.c                                             |   12 
 drivers/clk/tegra/clk-pll.c                                                   |    1 
 drivers/clk/ti/adpll.c                                                        |   15 
 drivers/clk/versatile/clk-icst.c                                              |    4 
 drivers/clk/zynq/clkc.c                                                       |    8 
 drivers/clocksource/clksrc-dbx500-prcmu.c                                     |    2 
 drivers/clocksource/timer-digicolor.c                                         |    2 
 drivers/clocksource/timer-fttmr010.c                                          |    2 
 drivers/clocksource/timer-mediatek.c                                          |    4 
 drivers/comedi/drivers/addi_apci_3xxx.c                                       |    2 
 drivers/comedi/drivers/aio_iiro_16.c                                          |    3 
 drivers/comedi/drivers/comedi_parport.c                                       |    3 
 drivers/comedi/drivers/das6402.c                                              |   10 
 drivers/comedi/drivers/dmm32at.c                                              |    3 
 drivers/comedi/drivers/dt2811.c                                               |    9 
 drivers/comedi/drivers/dt2814.c                                               |    3 
 drivers/comedi/drivers/ni_at_a2150.c                                          |   13 
 drivers/comedi/drivers/ni_atmio16d.c                                          |    7 
 drivers/comedi/drivers/pcl711.c                                               |    3 
 drivers/comedi/drivers/pcl816.c                                               |    3 
 drivers/comedi/drivers/pcl818.c                                               |    3 
 drivers/comedi/drivers/pcmmio.c                                               |    6 
 drivers/comedi/drivers/pcmuio.c                                               |   10 
 drivers/comedi/drivers/quatech_daqp_cs.c                                      |    4 
 drivers/cpufreq/amd-pstate-ut.c                                               |   16 
 drivers/cpufreq/amd-pstate.c                                                  |  301 
 drivers/cpufreq/amd-pstate.h                                                  |  114 
 drivers/cpufreq/cpufreq_conservative.c                                        |    8 
 drivers/cpufreq/cpufreq_governor.c                                            |   29 
 drivers/cpufreq/cpufreq_governor.h                                            |    2 
 drivers/cpufreq/cpufreq_stats.c                                               |    4 
 drivers/cpufreq/qcom-cpufreq-hw.c                                             |    3 
 drivers/cpufreq/sparc-us2e-cpufreq.c                                          |   11 
 drivers/cpufreq/sti-cpufreq.c                                                 |    4 
 drivers/cpufreq/tegra194-cpufreq.c                                            |    2 
 drivers/cpuidle/governors/menu.c                                              |    8 
 drivers/cpuidle/governors/teo.c                                               |   11 
 drivers/crypto/amlogic/amlogic-gxl-cipher.c                                   |   25 
 drivers/crypto/amlogic/amlogic-gxl-core.c                                     |    7 
 drivers/crypto/atmel-aes.c                                                    |    4 
 drivers/crypto/atmel-sha.c                                                    |   17 
 drivers/crypto/atmel-tdes.c                                                   |    6 
 drivers/crypto/caam/caampkc.c                                                 |    6 
 drivers/crypto/ccp/ccp-dev-v3.c                                               |    4 
 drivers/crypto/ccp/ccp-dev-v5.c                                               |    4 
 drivers/crypto/ccp/dbc.c                                                      |    4 
 drivers/crypto/hisilicon/hpre/hpre_crypto.c                                   |   22 
 drivers/crypto/intel/keembay/keembay-ocs-aes-core.c                           |    3 
 drivers/crypto/intel/keembay/keembay-ocs-ecc.c                                |    1 
 drivers/crypto/intel/keembay/ocs-aes.c                                        |    3 
 drivers/crypto/intel/qat/qat_common/adf_dev_mgr.c                             |    2 
 drivers/crypto/intel/qat/qat_common/adf_init.c                                |   24 
 drivers/crypto/intel/qat/qat_common/qat_algs.c                                |   15 
 drivers/crypto/intel/qat/qat_common/qat_asym_algs.c                           |   34 
 drivers/crypto/nx/nx-842.c                                                    |    2 
 drivers/crypto/omap-sham.c                                                    |    1 
 drivers/crypto/sa2ul.c                                                        |    3 
 drivers/crypto/talitos.c                                                      |   93 
 drivers/crypto/talitos.h                                                      |    5 
 drivers/cxl/acpi.c                                                            |   10 
 drivers/cxl/core/hdm.c                                                        |   24 
 drivers/cxl/core/port.c                                                       |    2 
 drivers/cxl/cxl.h                                                             |    2 
 drivers/cxl/pci.c                                                             |   11 
 drivers/dax/super.c                                                           |    2 
 drivers/dma/altera-msgdma.c                                                   |   10 
 drivers/dma/at_hdmac.c                                                        |   28 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                                |   39 
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h                                         |    5 
 drivers/dma/fsl_raid.c                                                        |   32 
 drivers/dma/img-mdc-dma.c                                                     |    2 
 drivers/dma/ioat/init.c                                                       |   18 
 drivers/dma/mediatek/mtk-hsdma.c                                              |   26 
 drivers/dma/mv_xor.c                                                          |    1 
 drivers/dma/pl330.c                                                           |   19 
 drivers/dma/plx_dma.c                                                         |   10 
 drivers/dma/qcom/bam_dma.c                                                    |   12 
 drivers/dma/sprd-dma.c                                                        |   45 
 drivers/dma/ste_dma40.c                                                       |  392 
 drivers/dma/ste_dma40_ll.h                                                    |    2 
 drivers/dma/sun6i-dma.c                                                       |   31 
 drivers/dma/xilinx/xilinx_dma.c                                               |   37 
 drivers/dma/xilinx/zynqmp_dma.c                                               |   56 
 drivers/edac/altera_edac.c                                                    |  115 
 drivers/edac/altera_edac.h                                                    |    1 
 drivers/edac/edac_mc.c                                                        |    6 
 drivers/edac/i10nm_base.c                                                     |    2 
 drivers/firmware/arm_scmi/common.h                                            |   22 
 drivers/firmware/arm_scmi/driver.c                                            |   38 
 drivers/firmware/arm_scmi/protocols.h                                         |    9 
 drivers/firmware/arm_scmi/raw_mode.c                                          |   29 
 drivers/firmware/cirrus/cs_dsp.c                                              |    2 
 drivers/firmware/efi/cper.c                                                   |   51 
 drivers/firmware/efi/libstub/Makefile                                         |    2 
 drivers/firmware/efi/libstub/efi-stub.c                                       |    8 
 drivers/firmware/efi/libstub/efistub.h                                        |    4 
 drivers/firmware/efi/libstub/fdt.c                                            |    6 
 drivers/firmware/efi/libstub/riscv-stub.c                                     |    7 
 drivers/firmware/imx/imx-dsp.c                                                |    6 
 drivers/firmware/imx/imx-scu.c                                                |   25 
 drivers/fpga/fpga-mgr.c                                                       |    2 
 drivers/gpio/gpio-crystalcove.c                                               |    1 
 drivers/gpio/gpio-davinci.c                                                   |    6 
 drivers/gpio/gpio-mvebu.c                                                     |   33 
 drivers/gpio/gpio-pca953x.c                                                   |   28 
 drivers/gpio/gpio-pca9570.c                                                   |    2 
 drivers/gpio/gpio-sifive.c                                                    |    1 
 drivers/gpio/gpiolib-cdev.c                                                   |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                                      |   68 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                                    |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c                            |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                              |   37 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c                              |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c                                      |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                        |   55 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                                   |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                    |   62 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                       |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                                       |   19 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                                       |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                                       |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c                                    |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                                       |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c                                      |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                       |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c                                   |    6 
 drivers/gpu/drm/amd/amdgpu/cik.c                                              |   10 
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c                                        |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c                                         |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c                                         |    5 
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c                                          |   13 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c                                        |    4 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c                                        |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c                                        |    4 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c                                        |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c                                      |    6 
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c                                        |   41 
 drivers/gpu/drm/amd/amdgpu/si.c                                               |   10 
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                                         |    6 
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c                                         |    6 
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                                         |    6 
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c                                         |    6 
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c                                         |    6 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c                                       |    4 
 drivers/gpu/drm/amd/amdgpu/vi.c                                               |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                      |   36 
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c                                         |   35 
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c                                     |   23 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c                              |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c                              |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c                               |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c                               |    7 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                                         |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                                      |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                          |   16 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                             |   31 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c                     |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c                   |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h                       |   26 
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c                         |    7 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c                             |    7 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c                         |   15 
 drivers/gpu/drm/amd/display/dc/dml/Makefile                                   |    4 
 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c                          |    2 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c            |    6 
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c                       |    3 
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c                       |    6 
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_6_0_0_offset.h                   |15799 ++
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_6_0_0_sh_mask.h                  |58556 ++++++++++
 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_6_0_0_offset.h                 |   47 
 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_6_0_0_sh_mask.h                |   55 
 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_5_0_1_offset.h               |   17 
 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_5_0_1_sh_mask.h              |   17 
 drivers/gpu/drm/amd/include/kgd_pp_interface.h                                |    1 
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                                           |   23 
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h                                       |    2 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                              |   21 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c                           |   31 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h                         |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c                |  675 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c                      |  446 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c                           |   34 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c                         |   46 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h                       |   24 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c               |  623 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c               |    7 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c               |    7 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                                     |   19 
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h                                 |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                          |   22 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                          |   41 
 drivers/gpu/drm/arm/display/include/malidp_product.h                          |   10 
 drivers/gpu/drm/arm/malidp_crtc.c                                             |    1 
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c                            |   13 
 drivers/gpu/drm/bridge/nwl-dsi.c                                              |   17 
 drivers/gpu/drm/bridge/tc358768.c                                             |   11 
 drivers/gpu/drm/drm_crtc.c                                                    |   15 
 drivers/gpu/drm/drm_of.c                                                      |    8 
 drivers/gpu/drm/drm_panel.c                                                   |   25 
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c                                      |   40 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                                         |    6 
 drivers/gpu/drm/exynos/exynos_drm_fimd.c                                      |    2 
 drivers/gpu/drm/i915/display/intel_atomic_plane.c                             |    1 
 drivers/gpu/drm/i915/display/intel_display.c                                  |   12 
 drivers/gpu/drm/i915/display/intel_dmc.c                                      |   55 
 drivers/gpu/drm/i915/display/intel_dmc_regs.h                                 |   12 
 drivers/gpu/drm/i915/display/intel_psr.c                                      |   26 
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c                                |    2 
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c                                           |    3 
 drivers/gpu/drm/loongson/lsdc_gem.c                                           |   12 
 drivers/gpu/drm/loongson/lsdc_plane.c                                         |    2 
 drivers/gpu/drm/loongson/lsdc_ttm.c                                           |   14 
 drivers/gpu/drm/loongson/lsdc_ttm.h                                           |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                         |    6 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                         |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c                                 |  102 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h                                 |   10 
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c                                      |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                                   |   10 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c                                      |    9 
 drivers/gpu/drm/msm/dp/dp_ctrl.c                                              |    3 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                            |    2 
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c                                        |   32 
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                                           |   16 
 drivers/gpu/drm/msm/msm_io_utils.c                                            |    6 
 drivers/gpu/drm/msm/msm_ringbuffer.c                                          |    2 
 drivers/gpu/drm/msm/msm_ringbuffer.h                                          |    1 
 drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h                             |    1 
 drivers/gpu/drm/nouveau/nouveau_abi16.c                                       |    4 
 drivers/gpu/drm/nouveau/nouveau_connector.c                                   |    1 
 drivers/gpu/drm/nouveau/nouveau_dp.c                                          |    4 
 drivers/gpu/drm/nouveau/nouveau_fence.c                                       |    6 
 drivers/gpu/drm/nouveau/nouveau_svm.c                                         |   13 
 drivers/gpu/drm/nouveau/nvkm/core/subdev.c                                    |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c                             |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild                                |    1 
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c                               |   36 
 drivers/gpu/drm/omapdrm/dss/dsi.c                                             |   63 
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c                                     |   11 
 drivers/gpu/drm/panel/panel-edp.c                                             |    1 
 drivers/gpu/drm/panel/panel-simple.c                                          |    3 
 drivers/gpu/drm/panfrost/panfrost_devfreq.c                                   |    2 
 drivers/gpu/drm/panfrost/panfrost_mmu.c                                       |   11 
 drivers/gpu/drm/radeon/atombios_crtc.c                                        |    5 
 drivers/gpu/drm/radeon/atombios_encoders.c                                    |   23 
 drivers/gpu/drm/radeon/r600_dpm.c                                             |   21 
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c                                   |    7 
 drivers/gpu/drm/tegra/submit.c                                                |   12 
 drivers/gpu/drm/tiny/simpledrm.c                                              |    4 
 drivers/gpu/drm/ttm/ttm_bo_util.c                                             |   11 
 drivers/gpu/drm/v3d/v3d_sched.c                                               |    2 
 drivers/gpu/drm/vc4/vc4_gem.c                                                 |   10 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                                |   10 
 drivers/gpu/drm/virtio/virtgpu_drv.h                                          |    1 
 drivers/gpu/drm/virtio/virtgpu_kms.c                                          |    1 
 drivers/gpu/drm/virtio/virtgpu_vq.c                                           |   15 
 drivers/gpu/host1x/hw/cdma_hw.c                                               |    2 
 drivers/greybus/manifest.c                                                    |    2 
 drivers/hid/amd-sfh-hid/amd_sfh_client.c                                      |    4 
 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h                     |    2 
 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h              |    7 
 drivers/hid/hid-core.c                                                        |    4 
 drivers/hid/hid-cougar.c                                                      |    3 
 drivers/hid/hid-cp2112.c                                                      |    9 
 drivers/hid/hid-elo.c                                                         |    3 
 drivers/hid/hid-ids.h                                                         |    6 
 drivers/hid/hid-input.c                                                       |   17 
 drivers/hid/hid-logitech-dj.c                                                 |    3 
 drivers/hid/hid-logitech-hidpp.c                                              |    2 
 drivers/hid/hid-mcp2200.c                                                     |    5 
 drivers/hid/hid-mcp2221.c                                                     |    2 
 drivers/hid/hid-multitouch.c                                                  |   19 
 drivers/hid/hid-nintendo.c                                                    |    8 
 drivers/hid/hid-picolcd_fb.c                                                  |   12 
 drivers/hid/hid-prodikeys.c                                                   |  120 
 drivers/hid/hid-pxrc.c                                                        |    3 
 drivers/hid/hid-quirks.c                                                      |    4 
 drivers/hid/hid-rmi.c                                                         |    2 
 drivers/hid/hid-roccat-isku.c                                                 |    3 
 drivers/hid/hid-roccat-koneplus.c                                             |    3 
 drivers/hid/hid-roccat-konepure.c                                             |    3 
 drivers/hid/hid-roccat-kovaplus.c                                             |    3 
 drivers/hid/hid-roccat-pyra.c                                                 |    3 
 drivers/hid/hid-roccat-ryos.c                                                 |    3 
 drivers/hid/hid-roccat-savu.c                                                 |    3 
 drivers/hid/hid-roccat.c                                                      |    8 
 drivers/hid/hid-zydacron.c                                                    |    3 
 drivers/hid/i2c-hid/i2c-hid-core.c                                            |   15 
 drivers/hid/intel-ish-hid/ishtp-hid-client.c                                  |    5 
 drivers/hid/usbhid/hiddev.c                                                   |   37 
 drivers/hid/wacom_sys.c                                                       |  198 
 drivers/hid/wacom_wac.c                                                       |  113 
 drivers/hid/wacom_wac.h                                                       |    6 
 drivers/hsi/controllers/omap_ssi_core.c                                       |    3 
 drivers/hte/hte-tegra194-test.c                                               |    2 
 drivers/hte/hte-tegra194.c                                                    |   10 
 drivers/hv/ring_buffer.c                                                      |   29 
 drivers/hv/vmbus_drv.c                                                        |    8 
 drivers/hwmon/acpi_power_meter.c                                              |   10 
 drivers/hwmon/aquacomputer_d5next.c                                           |   58 
 drivers/hwmon/asus_wmi_sensors.c                                              |   13 
 drivers/hwmon/coretemp.c                                                      |   40 
 drivers/hwmon/corsair-cpro.c                                                  |   12 
 drivers/hwmon/hp-wmi-sensors.c                                                |   29 
 drivers/hwmon/lm70.c                                                          |    8 
 drivers/hwmon/lm87.c                                                          |    7 
 drivers/hwmon/lm95245.c                                                       |    6 
 drivers/hwmon/nct6683.c                                                       |    4 
 drivers/hwmon/peci/dimmtemp.c                                                 |   21 
 drivers/hwmon/pmbus/pmbus_core.c                                              |   51 
 drivers/hwmon/pmbus/q54sj108a2.c                                              |    2 
 drivers/hwmon/sht15.c                                                         |   28 
 drivers/hwmon/sht3x.c                                                         |    5 
 drivers/hwmon/tmp102.c                                                        |    8 
 drivers/hwmon/tmp108.c                                                        |   26 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                            |    3 
 drivers/i2c/busses/i2c-designware-master.c                                    |    8 
 drivers/i2c/busses/i2c-mt7621.c                                               |    9 
 drivers/i2c/busses/i2c-qcom-cci.c                                             |   61 
 drivers/i2c/i2c-core-acpi.c                                                   |    7 
 drivers/i3c/master.c                                                          |    3 
 drivers/iio/accel/adis16201.c                                                 |   10 
 drivers/iio/accel/bma220_spi.c                                                |    3 
 drivers/iio/accel/fxls8962af-core.c                                           |    2 
 drivers/iio/accel/kionix-kx022a.h                                             |    2 
 drivers/iio/accel/kxcjk-1013.c                                                |    1 
 drivers/iio/accel/mma9551.c                                                   |    1 
 drivers/iio/accel/mma9553.c                                                   |    1 
 drivers/iio/adc/ad7192.c                                                      |    2 
 drivers/iio/adc/at91-sama5d2_adc.c                                            |    1 
 drivers/iio/adc/max1241.c                                                     |    1 
 drivers/iio/adc/stm32-adc.c                                                   |    4 
 drivers/iio/adc/ti-adc128s052.c                                               |    8 
 drivers/iio/adc/ti-ads1100.c                                                  |  121 
 drivers/iio/dac/ad5758.c                                                      |    8 
 drivers/iio/frequency/admv1013.c                                              |    7 
 drivers/iio/humidity/hts221_core.c                                            |  106 
 drivers/iio/imu/adis16400.c                                                   |    5 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c                             |    8 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c                              |    8 
 drivers/iio/light/isl29028.c                                                  |   23 
 drivers/iio/light/ltr501.c                                                    |    2 
 drivers/iio/potentiometer/x9250.c                                             |    7 
 drivers/iio/pressure/dps310.c                                                 |    6 
 drivers/iio/temperature/tmp117.c                                              |    9 
 drivers/infiniband/core/lag.c                                                 |   14 
 drivers/infiniband/core/mad.c                                                 |    2 
 drivers/infiniband/core/mad_rmpp.c                                            |    7 
 drivers/infiniband/core/nldev.c                                               |    5 
 drivers/infiniband/core/restrack.c                                            |    3 
 drivers/infiniband/core/sysfs.c                                               |    9 
 drivers/infiniband/core/uverbs_std_types_device.c                             |    1 
 drivers/infiniband/core/uverbs_std_types_wq.c                                 |    2 
 drivers/infiniband/core/verbs.c                                               |    3 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                      |   58 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                                     |    9 
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                                      |    2 
 drivers/infiniband/hw/cxgb4/cm.c                                              |    5 
 drivers/infiniband/hw/cxgb4/cq.c                                              |    8 
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h                                        |   36 
 drivers/infiniband/hw/cxgb4/provider.c                                        |   70 
 drivers/infiniband/hw/cxgb4/qp.c                                              |   32 
 drivers/infiniband/hw/efa/efa_com.c                                           |   28 
 drivers/infiniband/hw/erdma/erdma_main.c                                      |    4 
 drivers/infiniband/hw/erdma/erdma_verbs.c                                     |   16 
 drivers/infiniband/hw/hfi1/chip.c                                             |    4 
 drivers/infiniband/hw/hfi1/fault.c                                            |    1 
 drivers/infiniband/hw/hfi1/sdma.c                                             |    3 
 drivers/infiniband/hw/hfi1/verbs.c                                            |    4 
 drivers/infiniband/hw/hns/hns_roce_cq.c                                       |    1 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                    |   37 
 drivers/infiniband/hw/irdma/ctrl.c                                            |    8 
 drivers/infiniband/hw/irdma/pble.c                                            |    8 
 drivers/infiniband/hw/irdma/type.h                                            |    4 
 drivers/infiniband/hw/irdma/verbs.c                                           |   13 
 drivers/infiniband/hw/mlx4/main.c                                             |    4 
 drivers/infiniband/hw/mlx5/cq.c                                               |   24 
 drivers/infiniband/hw/mlx5/fs.c                                               |    4 
 drivers/infiniband/hw/mlx5/main.c                                             |    2 
 drivers/infiniband/hw/mlx5/mlx5_ib.h                                          |    2 
 drivers/infiniband/hw/mlx5/odp.c                                              |    2 
 drivers/infiniband/hw/mlx5/qp.c                                               |    8 
 drivers/infiniband/hw/mlx5/qpc.c                                              |    8 
 drivers/infiniband/hw/mlx5/srq.c                                              |    3 
 drivers/infiniband/hw/mlx5/wr.c                                               |    1 
 drivers/infiniband/hw/usnic/usnic_debugfs.c                                   |    2 
 drivers/infiniband/sw/rdmavt/qp.c                                             |    2 
 drivers/infiniband/sw/rxe/rxe_loc.h                                           |    8 
 drivers/infiniband/sw/rxe/rxe_mr.c                                            |   12 
 drivers/infiniband/sw/rxe/rxe_mw.c                                            |   23 
 drivers/infiniband/sw/rxe/rxe_net.c                                           |   95 
 drivers/infiniband/sw/rxe/rxe_qp.c                                            |   10 
 drivers/infiniband/sw/rxe/rxe_recv.c                                          |    9 
 drivers/infiniband/sw/rxe/rxe_req.c                                           |   11 
 drivers/infiniband/sw/rxe/rxe_resp.c                                          |   23 
 drivers/infiniband/sw/rxe/rxe_verbs.h                                         |    1 
 drivers/infiniband/sw/siw/siw_main.c                                          |    5 
 drivers/infiniband/sw/siw/siw_qp_tx.c                                         |   20 
 drivers/infiniband/ulp/ipoib/ipoib_main.c                                     |    7 
 drivers/infiniband/ulp/isert/ib_isert.c                                       |    2 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                                        |   32 
 drivers/infiniband/ulp/srp/ib_srp.c                                           |    2 
 drivers/input/joystick/xpad.c                                                 |    2 
 drivers/input/keyboard/matrix_keypad.c                                        |  186 
 drivers/input/serio/hp_sdc.c                                                  |    2 
 drivers/interconnect/qcom/icc-rpm.c                                           |   11 
 drivers/interconnect/qcom/icc-rpm.h                                           |    4 
 drivers/interconnect/qcom/smd-rpm.c                                           |    8 
 drivers/interconnect/samsung/exynos.c                                         |    1 
 drivers/iommu/amd/init.c                                                      |   37 
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                                       |   18 
 drivers/iommu/dma-iommu.c                                                     |   20 
 drivers/iommu/intel/dmar.c                                                    |   72 
 drivers/iommu/rockchip-iommu.c                                                |   13 
 drivers/iommu/virtio-iommu.c                                                  |    6 
 drivers/ipack/devices/ipoctal.c                                               |   16 
 drivers/irqchip/irq-atmel-aic.c                                               |    5 
 drivers/irqchip/irq-atmel-aic5.c                                              |    5 
 drivers/irqchip/irq-gic-common.c                                              |    2 
 drivers/irqchip/irq-gic-v3-its.c                                              |  158 
 drivers/irqchip/irq-gic-v3.c                                                  |   23 
 drivers/irqchip/irq-gic.c                                                     |   27 
 drivers/irqchip/irq-imx-intmux.c                                              |   29 
 drivers/irqchip/irq-mchp-eic.c                                                |    4 
 drivers/irqchip/irq-stm32-exti.c                                              |    6 
 drivers/leds/flash/leds-ktd2692.c                                             |   10 
 drivers/leds/led-class-flash.c                                                |    2 
 drivers/leds/leds-lm3692x.c                                                   |    4 
 drivers/leds/leds-lp8860.c                                                    |    5 
 drivers/leds/leds-pca9532.c                                                   |    9 
 drivers/mailbox/arm_mhuv2.c                                                   |    9 
 drivers/mailbox/mailbox-altera.c                                              |    2 
 drivers/mailbox/pcc.c                                                         |    5 
 drivers/mailbox/qcom-ipcc.c                                                   |    7 
 drivers/mailbox/ti-msgmgr.c                                                   |   14 
 drivers/md/dm-bufio.c                                                         |   45 
 drivers/md/dm-integrity.c                                                     |   56 
 drivers/md/dm-snap-persistent.c                                               |    7 
 drivers/md/dm-snap.c                                                          |   18 
 drivers/md/dm-writecache.c                                                    |   54 
 drivers/md/dm.c                                                               |    2 
 drivers/md/md.c                                                               |   33 
 drivers/md/raid10.c                                                           |    3 
 drivers/md/raid5-cache.c                                                      |   34 
 drivers/md/raid5.c                                                            |   62 
 drivers/md/raid5.h                                                            |    1 
 drivers/media/cec/core/cec-adap.c                                             |    1 
 drivers/media/cec/platform/stm32/stm32-cec.c                                  |   16 
 drivers/media/cec/platform/tegra/tegra_cec.c                                  |   14 
 drivers/media/common/cypress_firmware.c                                       |    2 
 drivers/media/common/saa7146/saa7146_core.c                                   |    3 
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c                                 |   14 
 drivers/media/dvb-core/dmxdev.c                                               |   11 
 drivers/media/dvb-frontends/stv0900_core.c                                    |    2 
 drivers/media/dvb-frontends/stv090x.c                                         |    2 
 drivers/media/i2c/adv7180.c                                                   |    2 
 drivers/media/i2c/adv748x/adv748x-core.c                                      |   13 
 drivers/media/i2c/adv7604.c                                                   |    3 
 drivers/media/i2c/ar0521.c                                                    |    1 
 drivers/media/i2c/ov5647.c                                                    |    4 
 drivers/media/i2c/ov5648.c                                                    |    4 
 drivers/media/i2c/ov8856.c                                                    |    3 
 drivers/media/i2c/ov8865.c                                                    |   44 
 drivers/media/i2c/tc358743.c                                                  |    3 
 drivers/media/pci/cx18/cx18-driver.c                                          |    9 
 drivers/media/pci/cx18/cx18-vbi.c                                             |    2 
 drivers/media/pci/cx23885/cx23885-core.c                                      |    4 
 drivers/media/pci/cx23885/cx23885-dvb.c                                       |   14 
 drivers/media/pci/cx88/cx88-mpeg.c                                            |   10 
 drivers/media/pci/intel/ipu-bridge.c                                          |    2 
 drivers/media/pci/ivtv/ivtv-vbi.c                                             |    2 
 drivers/media/pci/tw68/tw68-core.c                                            |    2 
 drivers/media/pci/tw686x/tw686x-core.c                                        |   10 
 drivers/media/platform/amphion/vpu_core.c                                     |   19 
 drivers/media/platform/amphion/vpu_drv.c                                      |    1 
 drivers/media/platform/atmel/atmel-isi.c                                      |    7 
 drivers/media/platform/m2m-deinterlace.c                                      |    2 
 drivers/media/platform/marvell/Kconfig                                        |    1 
 drivers/media/platform/marvell/mmp-driver.c                                   |    5 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c                          |   21 
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c                          |   14 
 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c           |    2 
 drivers/media/platform/mediatek/vpu/mtk_vpu.c                                 |    2 
 drivers/media/platform/microchip/microchip-csi2dc.c                           |    1 
 drivers/media/platform/microchip/microchip-isc-base.c                         |   82 
 drivers/media/platform/microchip/microchip-isc-clk.c                          |    7 
 drivers/media/platform/microchip/microchip-isc-regs.h                         |   16 
 drivers/media/platform/microchip/microchip-isc.h                              |    5 
 drivers/media/platform/microchip/microchip-sama5d2-isc.c                      |   55 
 drivers/media/platform/microchip/microchip-sama7g5-isc.c                      |   57 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                                |   23 
 drivers/media/platform/qcom/camss/camss-vfe-170.c                             |   62 
 drivers/media/platform/qcom/camss/camss-vfe-480.c                             |   40 
 drivers/media/platform/qcom/camss/camss-vfe.c                                 |   39 
 drivers/media/platform/qcom/camss/camss-vfe.h                                 |    9 
 drivers/media/platform/qcom/venus/hfi_msgs.c                                  |    3 
 drivers/media/platform/rockchip/rga/rga.c                                     |   69 
 drivers/media/platform/rockchip/rga/rga.h                                     |    7 
 drivers/media/platform/samsung/exynos4-is/fimc-lite.c                         |    3 
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c                              |    4 
 drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c                         |    7 
 drivers/media/platform/ti/davinci/vpif_capture.c                              |    5 
 drivers/media/platform/ti/davinci/vpif_display.c                              |    3 
 drivers/media/platform/verisilicon/hantro_drv.c                               |    9 
 drivers/media/platform/verisilicon/hantro_g1_mpeg2_dec.c                      |    5 
 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c               |   68 
 drivers/media/rc/bpf-lirc.c                                                   |   18 
 drivers/media/rc/ene_ir.c                                                     |    4 
 drivers/media/rc/fintek-cir.c                                                 |    4 
 drivers/media/rc/imon.c                                                       |    5 
 drivers/media/rc/ir-hix5hd2.c                                                 |    5 
 drivers/media/rc/ir-mce_kbd-decoder.c                                         |    5 
 drivers/media/rc/ir_toy.c                                                     |    2 
 drivers/media/rc/lirc_dev.c                                                   |    3 
 drivers/media/rc/meson-ir-tx.c                                                |   48 
 drivers/media/rc/rc-ir-raw.c                                                  |   66 
 drivers/media/rc/rc-main.c                                                    |   42 
 drivers/media/rc/redrat3.c                                                    |   32 
 drivers/media/rc/serial_ir.c                                                  |    2 
 drivers/media/rc/streamzap.c                                                  |    1 
 drivers/media/rc/sunxi-cir.c                                                  |    2 
 drivers/media/test-drivers/vicodec/codec-fwht.h                               |    2 
 drivers/media/test-drivers/vicodec/vicodec-core.c                             |   16 
 drivers/media/test-drivers/vidtv/vidtv_bridge.c                               |    4 
 drivers/media/test-drivers/vidtv/vidtv_demod.c                                |    9 
 drivers/media/test-drivers/vim2m.c                                            |   29 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c                              |   13 
 drivers/media/usb/au0828/au0828-core.c                                        |    4 
 drivers/media/usb/au0828/au0828-dvb.c                                         |   20 
 drivers/media/usb/cx231xx/cx231xx-cards.c                                     |    2 
 drivers/media/usb/cx231xx/cx231xx.h                                           |    2 
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c                                       |   14 
 drivers/media/usb/dvb-usb/dvb-usb-firmware.c                                  |    2 
 drivers/media/usb/em28xx/em28xx-audio.c                                       |    7 
 drivers/media/usb/em28xx/em28xx-cards.c                                       |    2 
 drivers/media/usb/em28xx/em28xx-core.c                                        |    3 
 drivers/media/usb/em28xx/em28xx-video.c                                       |   26 
 drivers/media/usb/go7007/go7007-driver.c                                      |    5 
 drivers/media/usb/go7007/go7007-fw.c                                          |   28 
 drivers/media/usb/go7007/go7007-usb.c                                         |    8 
 drivers/media/usb/go7007/s2250-board.c                                        |   54 
 drivers/media/usb/gspca/gspca.c                                               |    3 
 drivers/media/usb/hackrf/hackrf.c                                             |    7 
 drivers/media/usb/pvrusb2/pvrusb2-sysfs.c                                     |    1 
 drivers/media/usb/usbtv/usbtv-core.c                                          |    6 
 drivers/media/usb/usbtv/usbtv-video.c                                         |    4 
 drivers/media/usb/uvc/uvc_ctrl.c                                              |    2 
 drivers/media/usb/uvc/uvc_driver.c                                            |   20 
 drivers/media/v4l2-core/v4l2-common.c                                         |    2 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                                     |   12 
 drivers/memory/brcmstb_dpfe.c                                                 |   41 
 drivers/memory/emif.c                                                         |    9 
 drivers/memory/samsung/exynos5422-dmc.c                                       |   11 
 drivers/mfd/ab8500-core.c                                                     |   44 
 drivers/mfd/axp20x.c                                                          |    2 
 drivers/mfd/da903x.c                                                          |   34 
 drivers/mfd/da9150-core.c                                                     |    8 
 drivers/mfd/intel_quark_i2c_gpio.c                                            |   52 
 drivers/mfd/ipaq-micro.c                                                      |    2 
 drivers/mfd/rk8xx-core.c                                                      |    2 
 drivers/mfd/tps65217.c                                                        |   69 
 drivers/mfd/twl-core.c                                                        |   23 
 drivers/mfd/wcd934x.c                                                         |    8 
 drivers/misc/bcm-vk/bcm_vk_msg.c                                              |   18 
 drivers/misc/enclosure.c                                                      |    3 
 drivers/misc/fastrpc.c                                                        |   81 
 drivers/misc/genwqe/card_utils.c                                              |    2 
 drivers/misc/hpilo.c                                                          |    7 
 drivers/misc/ibmvmc.c                                                         |   17 
 drivers/mmc/core/block.c                                                      |    5 
 drivers/mmc/host/cqhci-core.c                                                 |   14 
 drivers/mmc/host/dw_mmc.c                                                     |    1 
 drivers/mtd/chips/cfi_cmdset_0002.c                                           |   15 
 drivers/mtd/maps/amd76xrom.c                                                  |    2 
 drivers/mtd/maps/l440gx.c                                                     |    2 
 drivers/mtd/maps/pci.c                                                        |    2 
 drivers/mtd/mtd_blkdevs.c                                                     |    5 
 drivers/mtd/mtdcore.c                                                         |    2 
 drivers/mtd/mtdsuper.c                                                        |    4 
 drivers/mtd/nand/raw/Kconfig                                                  |    3 
 drivers/mtd/nand/raw/atmel/nand-controller.c                                  |    6 
 drivers/mtd/nand/raw/ndfc.c                                                   |   41 
 drivers/mtd/nand/raw/pl35x-nand-controller.c                                  |   11 
 drivers/mtd/nand/raw/sunxi_nand.c                                             |    3 
 drivers/mtd/parsers/qcomsmempart.c                                            |    4 
 drivers/mtd/spi-nor/core.c                                                    |    9 
 drivers/mtd/spi-nor/sfdp.c                                                    |    8 
 drivers/net/amt.c                                                             |    8 
 drivers/net/bonding/bond_main.c                                               |    2 
 drivers/net/can/dev/netlink.c                                                 |    4 
 drivers/net/can/dev/skb.c                                                     |    4 
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c                                    |    7 
 drivers/net/dsa/mt7530.c                                                      |   24 
 drivers/net/dsa/mv88e6xxx/chip.c                                              |    8 
 drivers/net/ethernet/alacritech/slicoss.c                                     |    2 
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c                          |    2 
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c                               |   33 
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c                              |   32 
 drivers/net/ethernet/broadcom/bgmac.c                                         |   57 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c                               |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                     |   54 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                                 |   56 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h                                 |    2 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                                |  406 
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                                |    3 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c                            |   80 
 drivers/net/ethernet/broadcom/tg3.c                                           |   42 
 drivers/net/ethernet/cadence/macb_main.c                                      |    1 
 drivers/net/ethernet/cadence/macb_ptp.c                                       |    5 
 drivers/net/ethernet/hisilicon/hisi_femac.c                                   |    1 
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c                                 |   12 
 drivers/net/ethernet/ibm/ibmveth.c                                            |   41 
 drivers/net/ethernet/intel/ice/ice_lib.c                                      |    4 
 drivers/net/ethernet/intel/ice/ice_ptp.c                                      |   12 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                                 |   40 
 drivers/net/ethernet/jme.c                                                    |   37 
 drivers/net/ethernet/jme.h                                                    |    1 
 drivers/net/ethernet/marvell/mvneta.c                                         |   18 
 drivers/net/ethernet/marvell/mvneta_bm.c                                      |   72 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                           |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c                              |    2 
 drivers/net/ethernet/marvell/prestera/prestera_router.c                       |    6 
 drivers/net/ethernet/mellanox/mlx4/intf.c                                     |   15 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                               |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c                         |    4 
 drivers/net/ethernet/mellanox/mlxsw/core.c                                    |    4 
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c                              |    4 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c                           |    2 
 drivers/net/ethernet/microchip/lan966x/lan966x_mac.c                          |    4 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c                         |   19 
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c                          |   10 
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c                         |   15 
 drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c                           |   10 
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c                           |    1 
 drivers/net/ethernet/pensando/ionic/ionic_main.c                              |   13 
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c                              |    3 
 drivers/net/ethernet/stmicro/stmmac/descs.h                                   |    6 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c                            |    2 
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c                                |   25 
 drivers/net/ethernet/stmicro/stmmac/hwif.h                                    |    6 
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c                               |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                             |   32 
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c                         |    6 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c                        |    2 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                                      |    4 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                             |   86 
 drivers/net/gtp.c                                                             |   51 
 drivers/net/loopback.c                                                        |    8 
 drivers/net/macsec.c                                                          |    5 
 drivers/net/macvlan.c                                                         |    3 
 drivers/net/netdevsim/bpf.c                                                   |   11 
 drivers/net/pcs/pcs-mtk-lynxi.c                                               |    7 
 drivers/net/phy/mediatek-ge-soc.c                                             |   24 
 drivers/net/phy/sfp.c                                                         |    3 
 drivers/net/ppp/ppp_generic.c                                                 |    1 
 drivers/net/ppp/pppoe.c                                                       |   25 
 drivers/net/tap.c                                                             |    5 
 drivers/net/team/team_core.c                                                  |   11 
 drivers/net/team/team_mode_broadcast.c                                        |    2 
 drivers/net/tun.c                                                             |   24 
 drivers/net/usb/cdc_ether.c                                                   |   16 
 drivers/net/usb/cdc_mbim.c                                                    |    5 
 drivers/net/usb/cdc_ncm.c                                                     |    7 
 drivers/net/usb/lan78xx.c                                                     |    9 
 drivers/net/usb/pegasus.c                                                     |   16 
 drivers/net/usb/qmi_wwan.c                                                    |    1 
 drivers/net/usb/rtl8150.c                                                     |    4 
 drivers/net/usb/usbnet.c                                                      |   28 
 drivers/net/veth.c                                                            |   12 
 drivers/net/virtio_net.c                                                      |   20 
 drivers/net/vxlan/vxlan_core.c                                                |   16 
 drivers/net/wireless/ath/ath10k/htt_rx.c                                      |    6 
 drivers/net/wireless/ath/ath10k/htt_tx.c                                      |   12 
 drivers/net/wireless/ath/ath11k/ce.c                                          |    2 
 drivers/net/wireless/ath/ath11k/core.c                                        |    3 
 drivers/net/wireless/ath/ath11k/dp.c                                          |    2 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                       |   19 
 drivers/net/wireless/ath/ath11k/mac.c                                         |   33 
 drivers/net/wireless/ath/ath11k/mac.h                                         |    2 
 drivers/net/wireless/ath/ath11k/wmi.c                                         |    6 
 drivers/net/wireless/ath/ath12k/core.h                                        |    2 
 drivers/net/wireless/ath/ath12k/mac.c                                         |   21 
 drivers/net/wireless/ath/ath12k/pci.c                                         |  112 
 drivers/net/wireless/ath/ath12k/pci.h                                         |    2 
 drivers/net/wireless/ath/ath12k/wmi.c                                         |   20 
 drivers/net/wireless/ath/ath12k/wmi.h                                         |   10 
 drivers/net/wireless/ath/ath6kl/cfg80211.c                                    |    2 
 drivers/net/wireless/ath/ath9k/channel.c                                      |    2 
 drivers/net/wireless/ath/carl9170/debug.c                                     |    5 
 drivers/net/wireless/broadcom/b43/debugfs.c                                   |    2 
 drivers/net/wireless/broadcom/b43/main.c                                      |    5 
 drivers/net/wireless/broadcom/b43legacy/debugfs.c                             |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c                   |    7 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c                     |   49 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c                  |    2 
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c                                   |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                                  |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/time-sync.h                            |    4 
 drivers/net/wireless/marvell/mwifiex/cmdevt.c                                 |   10 
 drivers/net/wireless/marvell/mwifiex/fw.h                                     |    6 
 drivers/net/wireless/marvell/mwifiex/init.c                                   |    1 
 drivers/net/wireless/marvell/mwifiex/main.h                                   |    1 
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c                              |    3 
 drivers/net/wireless/mediatek/mt76/eeprom.c                                   |   17 
 drivers/net/wireless/mediatek/mt76/mac80211.c                                 |   25 
 drivers/net/wireless/mediatek/mt76/mt76.h                                     |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c                            |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c                               |   20 
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c                            |    1 
 drivers/net/wireless/mediatek/mt76/mt7603/main.c                              |   74 
 drivers/net/wireless/mediatek/mt76/mt7615/init.c                              |   20 
 drivers/net/wireless/mediatek/mt76/mt7615/main.c                              |    6 
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                               |   13 
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c                          |    1 
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c                           |    5 
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c                               |   17 
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c                          |    5 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h                          |   22 
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                              |   33 
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c                          |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/coredump.c                          |    7 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                            |    6 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                              |    4 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                               |    9 
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c                               |    5 
 drivers/net/wireless/mediatek/mt76/mt7921/init.c                              |    5 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                              |   23 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                               |    4 
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c                           |    4 
 drivers/net/wireless/mediatek/mt76/mt792x_core.c                              |   12 
 drivers/net/wireless/mediatek/mt76/mt7996/coredump.c                          |    7 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                               |   57 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                              |   16 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                               |  159 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                               |   48 
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                            |    1 
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c                               |    9 
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h                              |    8 
 drivers/net/wireless/mediatek/mt76/tx.c                                       |   25 
 drivers/net/wireless/mediatek/mt76/usb.c                                      |   47 
 drivers/net/wireless/microchip/wilc1000/mon.c                                 |   30 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c                         |   16 
 drivers/net/wireless/realtek/rtlwifi/pci.c                                    |   39 
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c                           |    6 
 drivers/net/wireless/realtek/rtw88/debug.c                                    |    5 
 drivers/net/wireless/realtek/rtw88/mac80211.c                                 |    4 
 drivers/net/wireless/realtek/rtw88/reg.h                                      |    2 
 drivers/net/wireless/realtek/rtw88/sdio.c                                     |   12 
 drivers/net/wireless/realtek/rtw88/tx.c                                       |    9 
 drivers/net/wireless/realtek/rtw88/tx.h                                       |    3 
 drivers/net/wireless/realtek/rtw88/usb.c                                      |   68 
 drivers/net/wireless/realtek/rtw88/usb.h                                      |    5 
 drivers/net/wireless/realtek/rtw89/fw.c                                       |   35 
 drivers/net/wireless/realtek/rtw89/fw.h                                       |    3 
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c                             |    4 
 drivers/net/wireless/rsi/rsi_91x_coex.c                                       |    3 
 drivers/net/wireless/rsi/rsi_91x_core.c                                       |    2 
 drivers/net/wireless/rsi/rsi_91x_main.c                                       |    7 
 drivers/net/wireless/rsi/rsi_91x_sdio_ops.c                                   |    3 
 drivers/net/wireless/rsi/rsi_91x_usb_ops.c                                    |    7 
 drivers/net/wireless/rsi/rsi_common.h                                         |    2 
 drivers/net/wireless/rsi/rsi_sdio.h                                           |    2 
 drivers/net/wireless/rsi/rsi_usb.h                                            |    2 
 drivers/net/wireless/silabs/wfx/bh.c                                          |    6 
 drivers/net/wireless/silabs/wfx/bus_sdio.c                                    |    1 
 drivers/net/wireless/silabs/wfx/main.c                                        |   36 
 drivers/net/wireless/virtual/mac80211_hwsim.c                                 |   10 
 drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c                                 |    5 
 drivers/net/wwan/wwan_hwsim.c                                                 |    4 
 drivers/net/xen-netback/netback.c                                             |    9 
 drivers/net/xen-netback/xenbus.c                                              |    8 
 drivers/nfc/nfcmrvl/spi.c                                                     |    4 
 drivers/nfc/nxp-nci/i2c.c                                                     |    4 
 drivers/nvdimm/pmem.c                                                         |    6 
 drivers/nvme/host/auth.c                                                      |   23 
 drivers/nvme/host/core.c                                                      |    7 
 drivers/nvme/host/fabrics.c                                                   |   30 
 drivers/nvme/host/fc.c                                                        |    2 
 drivers/nvme/host/ioctl.c                                                     |    4 
 drivers/nvme/host/nvme.h                                                      |    6 
 drivers/nvme/host/pci.c                                                       |    8 
 drivers/nvme/host/pr.c                                                        |    7 
 drivers/nvme/host/rdma.c                                                      |    1 
 drivers/nvme/host/sysfs.c                                                     |   14 
 drivers/nvme/host/tcp.c                                                       |   36 
 drivers/nvme/host/zns.c                                                       |    8 
 drivers/nvme/target/admin-cmd.c                                               |   18 
 drivers/nvme/target/auth.c                                                    |    2 
 drivers/nvme/target/configfs.c                                                |  105 
 drivers/nvme/target/core.c                                                    |   20 
 drivers/nvme/target/fabrics-cmd-auth.c                                        |   54 
 drivers/nvme/target/fabrics-cmd.c                                             |    3 
 drivers/nvme/target/fc.c                                                      |   33 
 drivers/nvme/target/io-cmd-bdev.c                                             |   34 
 drivers/nvme/target/io-cmd-file.c                                             |    4 
 drivers/nvme/target/loop.c                                                    |    2 
 drivers/nvme/target/nvmet.h                                                   |   10 
 drivers/nvme/target/passthru.c                                                |    9 
 drivers/nvme/target/rdma.c                                                    |   31 
 drivers/nvme/target/tcp.c                                                     |    7 
 drivers/nvme/target/zns.c                                                     |   18 
 drivers/nvmem/brcm_nvram.c                                                    |   15 
 drivers/nvmem/layouts/onie-tlv.c                                              |    1 
 drivers/nvmem/layouts/sl28vpd.c                                               |    1 
 drivers/nvmem/rockchip-otp.c                                                  |   24 
 drivers/opp/core.c                                                            |   52 
 drivers/opp/of.c                                                              |    2 
 drivers/parisc/eisa_enumerator.c                                              |   15 
 drivers/pci/ats.c                                                             |    7 
 drivers/pci/controller/cadence/pcie-cadence-plat.c                            |   38 
 drivers/pci/controller/dwc/pci-dra7xx.c                                       |   22 
 drivers/pci/controller/dwc/pcie-designware.c                                  |    5 
 drivers/pci/controller/dwc/pcie-designware.h                                  |    1 
 drivers/pci/controller/dwc/pcie-qcom.c                                        |   90 
 drivers/pci/controller/pci-aardvark.c                                         |   31 
 drivers/pci/controller/pci-xgene.c                                            |   11 
 drivers/pci/controller/pcie-rockchip-host.c                                   |   20 
 drivers/pci/controller/pcie-rockchip.c                                        |   14 
 drivers/pci/controller/pcie-rockchip.h                                        |    3 
 drivers/pci/controller/vmd.c                                                  |    3 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                                 |   77 
 drivers/pci/hotplug/pciehp_core.c                                             |    2 
 drivers/pci/iov.c                                                             |   25 
 drivers/pci/p2pdma.c                                                          |   10 
 drivers/pci/pci-label.c                                                       |   92 
 drivers/pci/pci.c                                                             |   25 
 drivers/pci/pci.h                                                             |    4 
 drivers/pci/pcie/Kconfig                                                      |    9 
 drivers/pci/pcie/aer.c                                                        |  153 
 drivers/pci/pcie/portdrv.c                                                    |   28 
 drivers/pci/probe.c                                                           |   15 
 drivers/pci/quirks.c                                                          |   13 
 drivers/pci/switch/switchtec.c                                                |    1 
 drivers/pci/xen-pcifront.c                                                    |   16 
 drivers/peci/controller/peci-aspeed.c                                         |    6 
 drivers/peci/controller/peci-npcm.c                                           |    6 
 drivers/perf/cxl_pmu.c                                                        |  100 
 drivers/perf/marvell_cn10k_ddr_pmu.c                                          |    6 
 drivers/perf/marvell_cn10k_tad_pmu.c                                          |    1 
 drivers/perf/xgene_pmu.c                                                      |    4 
 drivers/phy/cadence/phy-cadence-sierra.c                                      |   11 
 drivers/phy/hisilicon/phy-hi3670-pcie.c                                       |    4 
 drivers/phy/phy-core.c                                                        |   45 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                                      |  302 
 drivers/pinctrl/mediatek/pinctrl-mt7629.c                                     |    2 
 drivers/pinctrl/pinctrl-sx150x.c                                              |    1 
 drivers/pinctrl/sprd/pinctrl-sprd.c                                           |    3 
 drivers/pinctrl/stm32/Kconfig                                                 |    6 
 drivers/pinctrl/stm32/pinctrl-stm32.c                                         |   22 
 drivers/pinctrl/stm32/pinctrl-stm32.h                                         |   18 
 drivers/pinctrl/stm32/pinctrl-stm32mp257.c                                    |   11 
 drivers/pinctrl/sunplus/Kconfig                                               |    8 
 drivers/platform/chrome/cros_ec_proto.c                                       |   32 
 drivers/platform/chrome/cros_ec_proto_test.c                                  |  158 
 drivers/platform/chrome/cros_ec_typec.c                                       |   10 
 drivers/platform/olpc/olpc-ec.c                                               |    2 
 drivers/platform/x86/amd/pmc/pmc.c                                            |    5 
 drivers/platform/x86/amd/pmf/core.c                                           |    1 
 drivers/platform/x86/asus-nb-wmi.c                                            |    1 
 drivers/platform/x86/asus-wmi.c                                               |  130 
 drivers/platform/x86/gpd-pocket-fan.c                                         |    9 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c                                  |   82 
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c                           |    7 
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c                     |   18 
 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c                        |   12 
 drivers/platform/x86/hp/hp-wmi.c                                              |    7 
 drivers/platform/x86/ibm_rtl.c                                                |    8 
 drivers/platform/x86/intel/int3472/discrete.c                                 |   16 
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c                   |   68 
 drivers/platform/x86/intel/telemetry/core.c                                   |    4 
 drivers/platform/x86/intel/tpmi.c                                             |   13 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c                |    2 
 drivers/platform/x86/lenovo-ymc.c                                             |    8 
 drivers/platform/x86/msi-ec.c                                                 |    9 
 drivers/platform/x86/siemens/simatic-ipc.c                                    |   21 
 drivers/platform/x86/think-lmi.c                                              |   19 
 drivers/platform/x86/toshiba_acpi.c                                           |    9 
 drivers/pmdomain/imx/scu-pd.c                                                 |   10 
 drivers/pmdomain/qcom/rpmhpd.c                                                |   14 
 drivers/power/reset/piix4-poweroff.c                                          |    1 
 drivers/power/supply/ab8500_bmdata.c                                          |    2 
 drivers/power/supply/ab8500_btemp.c                                           |   31 
 drivers/power/supply/ab8500_chargalg.c                                        |   12 
 drivers/power/supply/ab8500_charger.c                                         |  403 
 drivers/power/supply/ab8500_fg.c                                              |   97 
 drivers/power/supply/apm_power.c                                              |    3 
 drivers/power/supply/bq24190_charger.c                                        |    9 
 drivers/power/supply/bq2515x_charger.c                                        |   15 
 drivers/power/supply/bq27xxx_battery.c                                        |   16 
 drivers/power/supply/cros_peripheral_charger.c                                |   13 
 drivers/power/supply/generic-adc-battery.c                                    |    5 
 drivers/power/supply/gpio-charger.c                                           |    5 
 drivers/power/supply/ltc2941-battery-gauge.c                                  |    6 
 drivers/power/supply/power_supply_core.c                                      |  201 
 drivers/power/supply/power_supply_sysfs.c                                     |   12 
 drivers/power/supply/qcom_battmgr.c                                           |   46 
 drivers/power/supply/qcom_pmi8998_charger.c                                   |   98 
 drivers/pwm/pwm-lp3943.c                                                      |   22 
 drivers/pwm/pwm-mtk-disp.c                                                    |    4 
 drivers/pwm/pwm-renesas-tpu.c                                                 |   45 
 drivers/pwm/pwm-tiehrpwm.c                                                    |    3 
 drivers/rapidio/devices/rio_mport_cdev.c                                      |    5 
 drivers/regulator/ab8500.c                                                    |  159 
 drivers/regulator/core.c                                                      |    6 
 drivers/regulator/devres.c                                                    |   18 
 drivers/regulator/fan53555.c                                                  |    6 
 drivers/regulator/fixed.c                                                     |   54 
 drivers/regulator/irq_helpers.c                                               |   40 
 drivers/regulator/max77802-regulator.c                                        |    4 
 drivers/regulator/mp886x.c                                                    |   13 
 drivers/regulator/of_regulator.c                                              |   27 
 drivers/regulator/qcom-rpmh-regulator.c                                       |    6 
 drivers/regulator/qcom_smd-regulator.c                                        |    2 
 drivers/regulator/rt6190-regulator.c                                          |   18 
 drivers/regulator/rt6245-regulator.c                                          |    5 
 drivers/remoteproc/imx_dsp_rproc.c                                            |   58 
 drivers/remoteproc/imx_rproc.c                                                |   18 
 drivers/remoteproc/qcom_q6v5_adsp.c                                           |    2 
 drivers/remoteproc/remoteproc_core.c                                          |   26 
 drivers/remoteproc/remoteproc_elf_loader.c                                    |   23 
 drivers/remoteproc/xlnx_r5_remoteproc.c                                       |    8 
 drivers/rpmsg/mtk_rpmsg.c                                                     |    1 
 drivers/rpmsg/rpmsg_char.c                                                    |    5 
 drivers/rpmsg/virtio_rpmsg_bus.c                                              |  118 
 drivers/rtc/Kconfig                                                           |   21 
 drivers/rtc/class.c                                                           |    8 
 drivers/rtc/rtc-ab-eoz9.c                                                     |    1 
 drivers/rtc/rtc-abx80x.c                                                      |  103 
 drivers/rtc/rtc-bd70528.c                                                     |    5 
 drivers/rtc/rtc-brcmstb-waketimer.c                                           |    1 
 drivers/rtc/rtc-cmos.c                                                        |    6 
 drivers/rtc/rtc-ds1307.c                                                      |    2 
 drivers/rtc/rtc-ds1685.c                                                      |   20 
 drivers/rtc/rtc-ftrtc010.c                                                    |   26 
 drivers/rtc/rtc-mpfs.c                                                        |    4 
 drivers/rtc/rtc-s35390a.c                                                     |  147 
 drivers/s390/block/dasd.c                                                     |   10 
 drivers/s390/char/vmcp.c                                                      |    4 
 drivers/s390/crypto/vfio_ap_ops.c                                             |   53 
 drivers/s390/crypto/zcrypt_ccamisc.c                                          |   22 
 drivers/s390/virtio/virtio_ccw.c                                              |    6 
 drivers/scsi/aic7xxx/aic7xxx_core.c                                           |    8 
 drivers/scsi/aic7xxx/aic7xxx_pci.c                                            |   20 
 drivers/scsi/dc395x.c                                                         |   10 
 drivers/scsi/elx/libefc/efclib.c                                              |    2 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                        |    9 
 drivers/scsi/ibmvscsi/ibmvfc.c                                                |   10 
 drivers/scsi/libiscsi_tcp.c                                                   |    3 
 drivers/scsi/libsas/sas_task.c                                                |    2 
 drivers/scsi/mpi3mr/mpi3mr.h                                                  |    2 
 drivers/scsi/mpi3mr/mpi3mr_app.c                                              |   45 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                               |   17 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                               |  159 
 drivers/scsi/mpi3mr/mpi3mr_transport.c                                        |   18 
 drivers/scsi/pm8001/pm8001_defs.h                                             |   98 
 drivers/scsi/pm8001/pm8001_hwi.c                                              |    2 
 drivers/scsi/pm8001/pm8001_hwi.h                                              |    4 
 drivers/scsi/pm8001/pm80xx_hwi.c                                              |    2 
 drivers/scsi/pm8001/pm80xx_hwi.h                                              |  100 
 drivers/scsi/qla2xxx/qla_fw.h                                                 |    4 
 drivers/scsi/qla2xxx/qla_init.c                                               |   13 
 drivers/scsi/qla2xxx/qla_mid.c                                                |    2 
 drivers/scsi/qla2xxx/qla_os.c                                                 |   15 
 drivers/scsi/scsi_bsg.c                                                       |    6 
 drivers/scsi/scsi_debug.c                                                     |    4 
 drivers/scsi/scsi_ioctl.c                                                     |   11 
 drivers/scsi/snic/snic_main.c                                                 |    1 
 drivers/scsi/st.c                                                             |   75 
 drivers/sh/intc/core.c                                                        |   11 
 drivers/sh/maple/maple.c                                                      |    4 
 drivers/slimbus/messaging.c                                                   |    2 
 drivers/soc/fsl/dpio/dpio-driver.c                                            |    9 
 drivers/soc/fsl/qe/tsa.c                                                      |   16 
 drivers/soc/ixp4xx/ixp4xx-qmgr.c                                              |    1 
 drivers/soc/qcom/apr.c                                                        |   44 
 drivers/soc/qcom/pmic_glink_altmode.c                                         |    4 
 drivers/soc/qcom/socinfo.c                                                    |    1 
 drivers/soc/tegra/flowctrl.c                                                  |    7 
 drivers/soundwire/dmi-quirks.c                                                |   42 
 drivers/soundwire/intel_auxdevice.c                                           |    2 
 drivers/spi/internals.h                                                       |    8 
 drivers/spi/spi-amd.c                                                         |   15 
 drivers/spi/spi-bcm-qspi.c                                                    |    9 
 drivers/spi/spi-bcm63xx-hsspi.c                                               |    7 
 drivers/spi/spi-bcm63xx.c                                                     |    5 
 drivers/spi/spi-bcmbca-hsspi.c                                                |    6 
 drivers/spi/spi-cadence-quadspi.c                                             |    3 
 drivers/spi/spi-cadence-xspi.c                                                |   19 
 drivers/spi/spi-fsl-spi.c                                                     |   22 
 drivers/spi/spi-jcore.c                                                       |    2 
 drivers/spi/spi-mtk-nor.c                                                     |    1 
 drivers/spi/spi-mxic.c                                                        |    8 
 drivers/spi/spi-npcm-fiu.c                                                    |    8 
 drivers/spi/spi-omap2-mcspi.c                                                 |  244 
 drivers/spi/spi-rspi.c                                                        |   63 
 drivers/spi/spi-sh-msiof.c                                                    |   50 
 drivers/spi/spi-sun4i.c                                                       |   63 
 drivers/spi/spi-tegra114.c                                                    |   49 
 drivers/spi/spi-zynq-qspi.c                                                   |   13 
 drivers/spi/spi.c                                                             |    2 
 drivers/staging/greybus/uart.c                                                |   30 
 drivers/staging/iio/adc/ad7816.c                                              |   33 
 drivers/staging/media/av7110/sp8870.c                                         |    5 
 drivers/staging/media/imx/imx-media-csc-scaler.c                              |    1 
 drivers/staging/media/meson/vdec/vdec.c                                       |    2 
 drivers/staging/octeon/ethernet-tx.c                                          |    2 
 drivers/staging/rtl8723bs/core/rtw_mlme.c                                     |   13 
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                                 |    9 
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c                                  |    6 
 drivers/staging/rtl8723bs/core/rtw_recv.c                                     |  154 
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c                                  |    4 
 drivers/staging/rtl8723bs/hal/hal_com.c                                       |   20 
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c                             |   16 
 drivers/staging/rtl8723bs/hal/sdio_halinit.c                                  |    8 
 drivers/staging/rtl8723bs/hal/sdio_ops.c                                      |    7 
 drivers/staging/rtl8723bs/include/drv_types.h                                 |   41 
 drivers/staging/rtl8723bs/include/recv_osdep.h                                |    4 
 drivers/staging/rtl8723bs/os_dep/os_intfs.c                                   |   21 
 drivers/staging/rtl8723bs/os_dep/recv_linux.c                                 |   44 
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c                                  |   50 
 drivers/staging/sm750fb/sm750.c                                               |   10 
 drivers/target/target_core_device.c                                           |   87 
 drivers/target/target_core_fabric_lib.c                                       |   10 
 drivers/target/target_core_stat.c                                             |   69 
 drivers/target/target_core_tpg.c                                              |   10 
 drivers/target/target_core_user.c                                             |    5 
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.c              |   10 
 drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c                |   11 
 drivers/thermal/intel/intel_powerclamp.c                                      |    3 
 drivers/thermal/sprd_thermal.c                                                |    6 
 drivers/thermal/thermal_trace.h                                               |    4 
 drivers/thermal/ti-soc-thermal/ti-bandgap.c                                   |   10 
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c                            |    4 
 drivers/thunderbolt/icm.c                                                     |    6 
 drivers/tty/serial/8250/8250_exar.c                                           |   59 
 drivers/tty/serial/8250/8250_lpss.c                                           |    7 
 drivers/tty/serial/8250/8250_omap.c                                           |   15 
 drivers/tty/serial/amba-pl011.c                                               |   15 
 drivers/tty/serial/ma35d1_serial.c                                            |    2 
 drivers/tty/serial/max310x.c                                                  |  380 
 drivers/tty/serial/pch_uart.c                                                 |    5 
 drivers/tty/serial/pmac_zilog.c                                               |    5 
 drivers/tty/serial/qcom_geni_serial.c                                         |    8 
 drivers/tty/serial/sc16is7xx.c                                                |   60 
 drivers/tty/serial/serial_core.c                                              |    7 
 drivers/tty/serial/sifive.c                                                   |    2 
 drivers/ufs/core/ufs_bsg.c                                                    |   23 
 drivers/ufs/core/ufshcd.c                                                     |   60 
 drivers/uio/uio_sercos3.c                                                     |    1 
 drivers/usb/cdns3/cdnsp-gadget.c                                              |  110 
 drivers/usb/cdns3/cdnsp-gadget.h                                              |    1 
 drivers/usb/cdns3/cdnsp-mem.c                                                 |   98 
 drivers/usb/class/cdc-acm.c                                                   |    6 
 drivers/usb/core/config.c                                                     |   32 
 drivers/usb/core/driver.c                                                     |    1 
 drivers/usb/core/message.c                                                    |    1 
 drivers/usb/core/quirks.c                                                     |    7 
 drivers/usb/dwc3/gadget.c                                                     |    1 
 drivers/usb/fotg210/fotg210-udc.c                                             |   17 
 drivers/usb/gadget/composite.c                                                |    2 
 drivers/usb/gadget/configfs.c                                                 |    4 
 drivers/usb/gadget/function/f_mass_storage.c                                  |    7 
 drivers/usb/gadget/function/u_audio.c                                         |   12 
 drivers/usb/gadget/legacy/inode.c                                             |   24 
 drivers/usb/gadget/udc/dummy_hcd.c                                            |    4 
 drivers/usb/gadget/udc/fsl_qe_udc.c                                           |    8 
 drivers/usb/host/pci-quirks.c                                                 |    1 
 drivers/usb/host/xhci-dbgtty.c                                                |    2 
 drivers/usb/host/xhci-ring.c                                                  |    9 
 drivers/usb/image/microtek.c                                                  |    1 
 drivers/usb/misc/cypress_cy7c63.c                                             |    8 
 drivers/usb/misc/uss720.c                                                     |    1 
 drivers/usb/mon/mon_main.c                                                    |    3 
 drivers/usb/mtu3/mtu3_trace.h                                                 |    4 
 drivers/usb/musb/da8xx.c                                                      |    8 
 drivers/usb/musb/musb_host.c                                                  |   14 
 drivers/usb/serial/option.c                                                   |    5 
 drivers/usb/serial/sierra.c                                                   |    3 
 drivers/usb/serial/usb_wwan.c                                                 |    3 
 drivers/usb/storage/alauda.c                                                  |   95 
 drivers/usb/typec/ucsi/ucsi_ccg.c                                             |   33 
 drivers/vdpa/solidrun/snet_ctrl.c                                             |    3 
 drivers/vdpa/vdpa_sim/vdpa_sim.c                                              |    3 
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c                                          |    9 
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c                                          |    9 
 drivers/vdpa/vdpa_user/iova_domain.c                                          |   11 
 drivers/vfio/cdx/main.c                                                       |   10 
 drivers/vfio/fsl-mc/vfio_fsl_mc.c                                             |   10 
 drivers/vfio/iova_bitmap.c                                                    |   18 
 drivers/vfio/pci/mlx5/cmd.c                                                   |    2 
 drivers/vfio/platform/vfio_platform_common.c                                  |   10 
 drivers/vhost/scsi.c                                                          |   31 
 drivers/vhost/vdpa.c                                                          |    8 
 drivers/vhost/vringh.c                                                        |   31 
 drivers/vhost/vsock.c                                                         |   36 
 drivers/video/backlight/lm3630a_bl.c                                          |    1 
 drivers/video/backlight/qcom-wled.c                                           |   35 
 drivers/video/fbdev/atmel_lcdfb.c                                             |   24 
 drivers/video/fbdev/core/bitblit.c                                            |    7 
 drivers/video/fbdev/core/fb_info.c                                            |    1 
 drivers/video/fbdev/core/fbcon.c                                              |   64 
 drivers/video/fbdev/core/fbcon_rotate.c                                       |    3 
 drivers/video/fbdev/gxt4500.c                                                 |    1 
 drivers/video/fbdev/kyro/fbdev.c                                              |   19 
 drivers/video/fbdev/nvidia/nvidia.c                                           |    1 
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c                                    |    9 
 drivers/video/fbdev/platinumfb.c                                              |   35 
 drivers/video/fbdev/sh_mobile_lcdcfb.c                                        |    6 
 drivers/video/fbdev/smscufx.c                                                 |    9 
 drivers/video/fbdev/ssd1307fb.c                                               |    6 
 drivers/video/fbdev/udlfb.c                                                   |   36 
 drivers/video/fbdev/xen-fbfront.c                                             |    7 
 drivers/virtio/virtio.c                                                       |    2 
 drivers/virtio/virtio_balloon.c                                               |    6 
 drivers/virtio/virtio_ring.c                                                  |    8 
 drivers/w1/masters/ds2482.c                                                   |    8 
 drivers/xen/gntdev-dmabuf.c                                                   |    4 
 drivers/xen/gntdev.c                                                          |    7 
 fs/9p/v9fs.c                                                                  |   16 
 fs/9p/vfs_inode.c                                                             |    8 
 fs/affs/bitmap.c                                                              |    2 
 fs/afs/rxrpc.c                                                                |   53 
 fs/aio.c                                                                      |   18 
 fs/btrfs/ctree.h                                                              |    2 
 fs/btrfs/defrag.c                                                             |    2 
 fs/btrfs/disk-io.c                                                            |    6 
 fs/btrfs/inode.c                                                              |    3 
 fs/btrfs/ioctl.c                                                              |   34 
 fs/btrfs/messages.c                                                           |    5 
 fs/btrfs/qgroup.c                                                             |    4 
 fs/btrfs/raid56.c                                                             |   11 
 fs/btrfs/relocation.c                                                         |   11 
 fs/btrfs/sysfs.c                                                              |    1 
 fs/btrfs/tree-mod-log.c                                                       |   13 
 fs/btrfs/verity.c                                                             |   31 
 fs/btrfs/volumes.c                                                            |    6 
 fs/btrfs/zoned.c                                                              |    8 
 fs/ceph/addr.c                                                                |   30 
 fs/ceph/caps.c                                                                |   23 
 fs/ceph/crypto.c                                                              |   11 
 fs/ceph/dir.c                                                                 |   14 
 fs/ceph/inode.c                                                               |    5 
 fs/ceph/mds_client.c                                                          |   28 
 fs/ceph/mdsmap.c                                                              |   12 
 fs/ceph/snap.c                                                                |    7 
 fs/ceph/super.c                                                               |   18 
 fs/ceph/super.h                                                               |    1 
 fs/ceph/xattr.c                                                               |   10 
 fs/dax.c                                                                      |   14 
 fs/dcache.c                                                                   |    4 
 fs/debugfs/file.c                                                             |   81 
 fs/dlm/lock.c                                                                 |    4 
 fs/dlm/lowcomms.c                                                             |    6 
 fs/erofs/decompressor.c                                                       |    2 
 fs/erofs/zdata.c                                                              |   11 
 fs/eventpoll.c                                                                |   18 
 fs/exec.c                                                                     |   11 
 fs/exfat/balloc.c                                                             |   31 
 fs/exfat/dir.c                                                                |    8 
 fs/exportfs/expfs.c                                                           |    6 
 fs/ext2/file.c                                                                |   10 
 fs/ext2/inode.c                                                               |   13 
 fs/ext4/balloc.c                                                              |    6 
 fs/ext4/crypto.c                                                              |   10 
 fs/ext4/dir.c                                                                 |   20 
 fs/ext4/ext4.h                                                                |   38 
 fs/ext4/extents.c                                                             |   26 
 fs/ext4/indirect.c                                                            |   17 
 fs/ext4/inode.c                                                               |   20 
 fs/ext4/namei.c                                                               |   23 
 fs/ext4/super.c                                                               |   18 
 fs/f2fs/checkpoint.c                                                          |    9 
 fs/f2fs/compress.c                                                            |   10 
 fs/f2fs/data.c                                                                |  113 
 fs/f2fs/dir.c                                                                 |    6 
 fs/f2fs/file.c                                                                |   95 
 fs/f2fs/gc.c                                                                  |    9 
 fs/f2fs/inline.c                                                              |    2 
 fs/f2fs/namei.c                                                               |    6 
 fs/f2fs/node.c                                                                |   59 
 fs/f2fs/segment.c                                                             |    5 
 fs/f2fs/super.c                                                               |   39 
 fs/fat/fat.h                                                                  |    2 
 fs/fat/fatent.c                                                               |   21 
 fs/fat/file.c                                                                 |    3 
 fs/fat/inode.c                                                                |    2 
 fs/fat/misc.c                                                                 |    6 
 fs/fat/namei_msdos.c                                                          |    3 
 fs/fs-writeback.c                                                             |   32 
 fs/fs_pin.c                                                                   |   24 
 fs/fuse/dir.c                                                                 |    3 
 fs/fuse/file.c                                                                |   21 
 fs/fuse/virtio_fs.c                                                           |   80 
 fs/gfs2/bmap.c                                                                |    2 
 fs/gfs2/glops.c                                                               |   10 
 fs/gfs2/inode.c                                                               |    2 
 fs/gfs2/lops.c                                                                |    4 
 fs/hfs/btree.c                                                                |    7 
 fs/hfsplus/btree.c                                                            |    7 
 fs/hfsplus/extents.c                                                          |    2 
 fs/hugetlbfs/inode.c                                                          |    6 
 fs/inode.c                                                                    |   15 
 fs/iomap/buffered-io.c                                                        |    3 
 fs/iomap/fiemap.c                                                             |    8 
 fs/isofs/dir.c                                                                |    4 
 fs/isofs/inode.c                                                              |    2 
 fs/isofs/isofs.h                                                              |   13 
 fs/isofs/joliet.c                                                             |   27 
 fs/isofs/namei.c                                                              |    3 
 fs/isofs/rock.c                                                               |   11 
 fs/jbd2/journal.c                                                             |    2 
 fs/kernfs/dir.c                                                               |   12 
 fs/kernfs/symlink.c                                                           |   17 
 fs/lockd/svclock.c                                                            |    2 
 fs/namespace.c                                                                |   13 
 fs/nfs/blocklayout/blocklayout.h                                              |    5 
 fs/nfs/blocklayout/rpc_pipefs.c                                               |   79 
 fs/nfs/callback_xdr.c                                                         |    9 
 fs/nfs/delegation.c                                                           |    2 
 fs/nfs/dir.c                                                                  |   13 
 fs/nfs/file.c                                                                 |    4 
 fs/nfs/filelayout/filelayout.c                                                |   13 
 fs/nfs/filelayout/filelayoutdev.c                                             |   17 
 fs/nfs/flexfilelayout/flexfilelayout.c                                        |  106 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                                     |   17 
 fs/nfs/fs_context.c                                                           |    1 
 fs/nfs/internal.h                                                             |   31 
 fs/nfs/netns.h                                                                |    5 
 fs/nfs/nfs3proc.c                                                             |    8 
 fs/nfs/nfs4_fs.h                                                              |    2 
 fs/nfs/nfs4client.c                                                           |    7 
 fs/nfs/nfs4proc.c                                                             |   25 
 fs/nfs/nfs4state.c                                                            |   52 
 fs/nfs/nfs4xdr.c                                                              |    2 
 fs/nfs/pnfs.c                                                                 |   14 
 fs/nfs/pnfs.h                                                                 |    1 
 fs/nfs/pnfs_nfs.c                                                             |   21 
 fs/nfs/proc.c                                                                 |    8 
 fs/nfs/write.c                                                                |    4 
 fs/nfsd/blocklayout.c                                                         |    4 
 fs/nfsd/flexfilelayout.c                                                      |   24 
 fs/nfsd/flexfilelayoutxdr.c                                                   |    4 
 fs/nfsd/flexfilelayoutxdr.h                                                   |    5 
 fs/nfsd/netns.h                                                               |    6 
 fs/nfsd/nfs4idmap.c                                                           |    4 
 fs/nfsd/nfs4layouts.c                                                         |   17 
 fs/nfsd/nfs4proc.c                                                            |    6 
 fs/nfsd/nfs4recover.c                                                         |  123 
 fs/nfsd/nfs4state.c                                                           |  104 
 fs/nfsd/nfs4xdr.c                                                             |   26 
 fs/nfsd/nfsctl.c                                                              |   12 
 fs/nfsd/pnfs.h                                                                |    4 
 fs/nfsd/xdr4.h                                                                |    1 
 fs/nilfs2/dir.c                                                               |   34 
 fs/nilfs2/gcinode.c                                                           |   24 
 fs/nilfs2/inode.c                                                             |   22 
 fs/nilfs2/ioctl.c                                                             |    2 
 fs/nilfs2/mdt.c                                                               |    6 
 fs/nilfs2/namei.c                                                             |    8 
 fs/nilfs2/page.c                                                              |   51 
 fs/nilfs2/page.h                                                              |    5 
 fs/nilfs2/recovery.c                                                          |   49 
 fs/nilfs2/segbuf.c                                                            |   12 
 fs/nilfs2/segment.c                                                           |   54 
 fs/nilfs2/sysfs.c                                                             |    5 
 fs/nilfs2/the_nilfs.c                                                         |   46 
 fs/notify/fanotify/fanotify.c                                                 |    7 
 fs/notify/fanotify/fanotify.h                                                 |   21 
 fs/notify/inotify/inotify_fsnotify.c                                          |    2 
 fs/ntfs3/attrib.c                                                             |   33 
 fs/ntfs3/dir.c                                                                |   14 
 fs/ntfs3/frecord.c                                                            |   32 
 fs/ntfs3/fslog.c                                                              |   29 
 fs/ntfs3/fsntfs.c                                                             |    3 
 fs/ntfs3/index.c                                                              |   14 
 fs/ntfs3/inode.c                                                              |   25 
 fs/ntfs3/namei.c                                                              |    9 
 fs/ntfs3/ntfs_fs.h                                                            |    4 
 fs/ntfs3/super.c                                                              |   18 
 fs/ntfs3/xattr.c                                                              |   33 
 fs/ocfs2/alloc.c                                                              |   18 
 fs/ocfs2/cluster/heartbeat.c                                                  |   72 
 fs/ocfs2/cluster/netdebug.c                                                   |    4 
 fs/ocfs2/cluster/nodemanager.c                                                |   10 
 fs/ocfs2/cluster/quorum.c                                                     |    7 
 fs/ocfs2/cluster/quorum.h                                                     |    1 
 fs/ocfs2/cluster/tcp.c                                                        |   13 
 fs/ocfs2/dcache.h                                                             |    5 
 fs/ocfs2/dir.c                                                                |   76 
 fs/ocfs2/dlm/dlmconvert.c                                                     |   10 
 fs/ocfs2/dlm/dlmdebug.c                                                       |    5 
 fs/ocfs2/dlm/dlmdomain.c                                                      |    3 
 fs/ocfs2/dlm/dlmlock.c                                                        |    8 
 fs/ocfs2/dlm/dlmmaster.c                                                      |   70 
 fs/ocfs2/dlmglue.c                                                            |   97 
 fs/ocfs2/dlmglue.h                                                            |    5 
 fs/ocfs2/export.c                                                             |   10 
 fs/ocfs2/file.c                                                               |  118 
 fs/ocfs2/filecheck.c                                                          |    7 
 fs/ocfs2/inode.c                                                              |   42 
 fs/ocfs2/journal.c                                                            |   18 
 fs/ocfs2/journal.h                                                            |    2 
 fs/ocfs2/move_extents.c                                                       |   62 
 fs/ocfs2/namei.c                                                              |    6 
 fs/ocfs2/ocfs2.h                                                              |    2 
 fs/ocfs2/quota_local.c                                                        |   36 
 fs/ocfs2/refcounttree.c                                                       |   15 
 fs/ocfs2/super.c                                                              |   20 
 fs/ocfs2/xattr.c                                                              |  528 
 fs/ocfs2/xattr.h                                                              |   12 
 fs/overlayfs/copy_up.c                                                        |  104 
 fs/overlayfs/dir.c                                                            |   22 
 fs/overlayfs/export.c                                                         |    4 
 fs/overlayfs/file.c                                                           |    5 
 fs/overlayfs/inode.c                                                          |   14 
 fs/overlayfs/namei.c                                                          |   21 
 fs/overlayfs/overlayfs.h                                                      |   10 
 fs/overlayfs/readdir.c                                                        |   70 
 fs/overlayfs/super.c                                                          |   17 
 fs/overlayfs/util.c                                                           |    2 
 fs/proc/generic.c                                                             |    3 
 fs/proc/kcore.c                                                               |    8 
 fs/pstore/ram.c                                                               |    1 
 fs/pstore/ram_core.c                                                          |    6 
 fs/quota/dquot.c                                                              |   10 
 fs/read_write.c                                                               |    8 
 fs/romfs/super.c                                                              |    8 
 fs/signalfd.c                                                                 |   28 
 fs/smb/client/cached_dir.c                                                    |   62 
 fs/smb/client/cifs_fs_sb.h                                                    |    1 
 fs/smb/client/cifsacl.c                                                       |    9 
 fs/smb/client/cifsfs.c                                                        |   48 
 fs/smb/client/cifsglob.h                                                      |    7 
 fs/smb/client/cifspdu.h                                                       |  125 
 fs/smb/client/cifssmb.c                                                       |   96 
 fs/smb/client/connect.c                                                       |   38 
 fs/smb/client/file.c                                                          |   33 
 fs/smb/client/inode.c                                                         |    8 
 fs/smb/client/misc.c                                                          |    4 
 fs/smb/client/readdir.c                                                       |   69 
 fs/smb/client/reparse.c                                                       |   67 
 fs/smb/client/reparse.h                                                       |    7 
 fs/smb/client/sess.c                                                          |    6 
 fs/smb/client/smb2file.c                                                      |    2 
 fs/smb/client/smb2inode.c                                                     |    2 
 fs/smb/client/smb2maperror.c                                                  |    2 
 fs/smb/client/smb2misc.c                                                      |    2 
 fs/smb/client/smb2ops.c                                                       |  121 
 fs/smb/client/smb2pdu.c                                                       |   51 
 fs/smb/client/smb2pdu.h                                                       |   69 
 fs/smb/client/smb2status.h                                                    | 1771 
 fs/smb/client/smb2transport.c                                                 |    2 
 fs/smb/client/transport.c                                                     |    6 
 fs/smb/common/smb2pdu.h                                                       |  250 
 fs/smb/common/smb2status.h                                                    | 1773 
 fs/smb/server/Kconfig                                                         |    1 
 fs/smb/server/auth.c                                                          |    3 
 fs/smb/server/connection.c                                                    |   24 
 fs/smb/server/ksmbd_netlink.h                                                 |    2 
 fs/smb/server/mgmt/user_config.c                                              |    6 
 fs/smb/server/mgmt/user_session.c                                             |    4 
 fs/smb/server/misc.c                                                          |    8 
 fs/smb/server/oplock.c                                                        |   30 
 fs/smb/server/server.c                                                        |   25 
 fs/smb/server/smb2misc.c                                                      |    2 
 fs/smb/server/smb2ops.c                                                       |    6 
 fs/smb/server/smb2pdu.c                                                       |  603 
 fs/smb/server/smb2pdu.h                                                       |   59 
 fs/smb/server/smb_common.c                                                    |   12 
 fs/smb/server/smb_common.h                                                    |   75 
 fs/smb/server/smbacl.c                                                        |   34 
 fs/smb/server/smbstatus.h                                                     | 1822 
 fs/smb/server/transport_ipc.c                                                 |   16 
 fs/smb/server/transport_rdma.c                                                |    3 
 fs/smb/server/transport_tcp.c                                                 |   15 
 fs/smb/server/vfs.c                                                           |  137 
 fs/smb/server/vfs.h                                                           |    5 
 fs/smb/server/vfs_cache.c                                                     |   46 
 fs/smb/server/vfs_cache.h                                                     |    2 
 fs/smb/server/xattr.h                                                         |    2 
 fs/splice.c                                                                   |   55 
 fs/stat.c                                                                     |    6 
 fs/udf/balloc.c                                                               |   23 
 fs/udf/inode.c                                                                |   75 
 fs/udf/super.c                                                                |  125 
 fs/udf/truncate.c                                                             |    9 
 fs/udf/udfdecl.h                                                              |    3 
 fs/ufs/cylinder.c                                                             |   31 
 fs/ufs/dir.c                                                                  |    2 
 fs/userfaultfd.c                                                              |   17 
 fs/verity/measure.c                                                           |   10 
 fs/verity/open.c                                                              |   38 
 fs/verity/read_metadata.c                                                     |   14 
 fs/xattr.c                                                                    |    2 
 fs/xfs/libxfs/xfs_attr_leaf.c                                                 |   22 
 fs/xfs/libxfs/xfs_bmap.c                                                      |   14 
 fs/xfs/libxfs/xfs_bmap.h                                                      |   10 
 fs/xfs/libxfs/xfs_btree.c                                                     |    4 
 fs/xfs/libxfs/xfs_da_btree.c                                                  |   13 
 fs/xfs/scrub/attr.c                                                           |   29 
 fs/xfs/scrub/bmap.c                                                           |    7 
 fs/xfs/scrub/btree.c                                                          |   16 
 fs/xfs/scrub/common.c                                                         |    7 
 fs/xfs/scrub/dabtree.c                                                        |   27 
 fs/xfs/scrub/dir.c                                                            |   59 
 fs/xfs/scrub/fscounters.c                                                     |   12 
 fs/xfs/scrub/quota.c                                                          |    8 
 fs/xfs/scrub/readdir.c                                                        |    2 
 fs/xfs/scrub/refcount.c                                                       |   25 
 fs/xfs/scrub/rmap.c                                                           |   20 
 fs/xfs/scrub/stats.c                                                          |    5 
 fs/xfs/scrub/trace.c                                                          |   13 
 fs/xfs/scrub/trace.h                                                          |   10 
 fs/xfs/xfs_discard.c                                                          |    9 
 fs/xfs/xfs_inode_item_recover.c                                               |   20 
 fs/xfs/xfs_ioctl.c                                                            |    2 
 fs/xfs/xfs_ioctl32.c                                                          |    4 
 fs/xfs/xfs_iomap.c                                                            |    8 
 fs/xfs/xfs_pnfs.c                                                             |   43 
 include/acpi/acpi_bus.h                                                       |    2 
 include/acpi/acpi_drivers.h                                                   |    9 
 include/acpi/cppc_acpi.h                                                      |    6 
 include/asm-generic/bitops/le.h                                               |   18 
 include/asm-generic/tlb.h                                                     |    3 
 include/drm/drm_panel.h                                                       |   22 
 include/dt-bindings/arm/qcom,ids.h                                            |    1 
 include/dt-bindings/clock/nuvoton,ma35d1-clk.h                                |    3 
 include/dt-bindings/clock/qcom,dsi-phy-28nm.h                                 |    9 
 include/kvm/arm_arch_timer.h                                                  |   15 
 include/kvm/arm_vgic.h                                                        |    1 
 include/linux/acpi.h                                                          |   24 
 include/linux/amd-pstate.h                                                    |  121 
 include/linux/assoc_array_priv.h                                              |    2 
 include/linux/bio.h                                                           |   15 
 include/linux/bitfield.h                                                      |   21 
 include/linux/bitmap-str.h                                                    |   16 
 include/linux/bitmap.h                                                        |   23 
 include/linux/blk-mq.h                                                        |    6 
 include/linux/bpf.h                                                           |    5 
 include/linux/can/can-ml.h                                                    |    3 
 include/linux/clk-provider.h                                                  |   22 
 include/linux/damon.h                                                         |    6 
 include/linux/device.h                                                        |   20 
 include/linux/device/bus.h                                                    |    3 
 include/linux/etherdevice.h                                                   |   28 
 include/linux/fault-inject.h                                                  |   10 
 include/linux/firewire.h                                                      |    1 
 include/linux/fortify-string.h                                                |    2 
 include/linux/fs.h                                                            |    4 
 include/linux/hid.h                                                           |    1 
 include/linux/hiddev.h                                                        |    2 
 include/linux/hugetlb.h                                                       |   17 
 include/linux/if_bridge.h                                                     |   77 
 include/linux/intel_tpmi.h                                                    |   13 
 include/linux/interrupt.h                                                     |    3 
 include/linux/irq.h                                                           |    2 
 include/linux/libata.h                                                        |    6 
 include/linux/memcontrol.h                                                    |   10 
 include/linux/memfd.h                                                         |    9 
 include/linux/mfd/da9150/core.h                                               |    1 
 include/linux/mm.h                                                            |    7 
 include/linux/mm_types.h                                                      |   11 
 include/linux/mmu_notifier.h                                                  |   10 
 include/linux/mtd/spinand.h                                                   |    2 
 include/linux/nvme.h                                                          |   10 
 include/linux/perf_event.h                                                    |    7 
 include/linux/pm_wakeirq.h                                                    |    6 
 include/linux/pm_wakeup.h                                                     |   17 
 include/linux/power_supply.h                                                  |    5 
 include/linux/quotaops.h                                                      |    5 
 include/linux/remoteproc.h                                                    |    2 
 include/linux/rtc.h                                                           |    2 
 include/linux/rtnetlink.h                                                     |   12 
 include/linux/shmem_fs.h                                                      |   15 
 include/linux/skbuff.h                                                        |  106 
 include/linux/soc/ti/k3-ringacc.h                                             |   31 
 include/linux/spi/rspi.h                                                      |   18 
 include/linux/srcu.h                                                          |   40 
 include/linux/usb/quirks.h                                                    |    3 
 include/linux/userfaultfd_k.h                                                 |   13 
 include/linux/virtio_vsock.h                                                  |    9 
 include/linux/wait.h                                                          |    6 
 include/linux/watch_queue.h                                                   |    6 
 include/math-emu/op-common.h                                                  |   23 
 include/math-emu/soft-fp.h                                                    |    8 
 include/media/v4l2-ctrls.h                                                    |    6 
 include/net/addrconf.h                                                        |    3 
 include/net/bluetooth/bluetooth.h                                             |    4 
 include/net/bluetooth/l2cap.h                                                 |    3 
 include/net/cfg80211.h                                                        |   32 
 include/net/espintcp.h                                                        |    5 
 include/net/gso.h                                                             |    8 
 include/net/inet_frag.h                                                       |    9 
 include/net/ip.h                                                              |   15 
 include/net/ip_vs.h                                                           |   50 
 include/net/mctp.h                                                            |    6 
 include/net/mptcp.h                                                           |    9 
 include/net/netfilter/nf_conntrack_expect.h                                   |    3 
 include/net/netfilter/nf_conntrack_seqadj.h                                   |    1 
 include/net/netns/can.h                                                       |    2 
 include/net/sctp/sm.h                                                         |    1 
 include/net/seg6.h                                                            |    7 
 include/net/seg6_hmac.h                                                       |   10 
 include/net/switchdev.h                                                       |    1 
 include/sound/control.h                                                       |    4 
 include/sound/core.h                                                          |   25 
 include/sound/hdaudio.h                                                       |    5 
 include/sound/hwdep.h                                                         |    1 
 include/sound/pcm.h                                                           |    9 
 include/sound/pcm_oss.h                                                       |    1 
 include/sound/pcm_params.h                                                    |    2 
 include/sound/soc-component.h                                                 |    2 
 include/sound/soundfont.h                                                     |    8 
 include/target/target_core_base.h                                             |   20 
 include/trace/events/huge_memory.h                                            |   12 
 include/trace/events/power.h                                                  |    3 
 include/trace/events/rxrpc.h                                                  |    2 
 include/trace/misc/nfs.h                                                      |   10 
 include/uapi/linux/bpf.h                                                      |    1 
 include/uapi/linux/firewire-cdev.h                                            |    4 
 include/uapi/linux/pci_regs.h                                                 |    3 
 include/uapi/sound/asound.h                                                   |    7 
 include/video/maxinefb.h                                                      |    4 
 init/Kconfig                                                                  |    4 
 init/main.c                                                                   |   14 
 init/version.c                                                                |    9 
 io_uring/cancel.c                                                             |    3 
 io_uring/io-wq.c                                                              |   14 
 io_uring/io_uring.c                                                           |   26 
 io_uring/net.c                                                                |   12 
 io_uring/poll.c                                                               |   77 
 io_uring/rsrc.c                                                               |   25 
 io_uring/sqpoll.c                                                             |   42 
 io_uring/sqpoll.h                                                             |    3 
 io_uring/tctx.c                                                               |    6 
 io_uring/timeout.c                                                            |    3 
 ipc/mqueue.c                                                                  |    7 
 ipc/namespace.c                                                               |    9 
 kernel/bpf/bpf_iter.c                                                         |    7 
 kernel/bpf/bpf_lsm.c                                                          |    4 
 kernel/bpf/btf.c                                                              |   27 
 kernel/bpf/core.c                                                             |    4 
 kernel/bpf/offload.c                                                          |   25 
 kernel/bpf/queue_stack_maps.c                                                 |    3 
 kernel/bpf/syscall.c                                                          |  144 
 kernel/bpf/verifier.c                                                         |    9 
 kernel/cgroup/cgroup.c                                                        |    2 
 kernel/cgroup/cpuset.c                                                        |   17 
 kernel/cpu_pm.c                                                               |    9 
 kernel/debug/gdbstub.c                                                        |   55 
 kernel/debug/kdb/kdb_io.c                                                     |    1 
 kernel/debug/kdb/kdb_main.c                                                   |    6 
 kernel/debug/kdb/kdb_private.h                                                |    3 
 kernel/dma/swiotlb.c                                                          |    4 
 kernel/events/core.c                                                          |  297 
 kernel/events/ring_buffer.c                                                   |    7 
 kernel/fork.c                                                                 |   45 
 kernel/futex/core.c                                                           |    8 
 kernel/futex/pi.c                                                             |  102 
 kernel/irq/internals.h                                                        |    2 
 kernel/irq/irqdomain.c                                                        |    4 
 kernel/irq/manage.c                                                           |   80 
 kernel/kcov.c                                                                 |    8 
 kernel/kcsan/core.c                                                           |    7 
 kernel/kexec_file.c                                                           |    4 
 kernel/module/kallsyms.c                                                      |   31 
 kernel/module/main.c                                                          |  478 
 kernel/module/tracking.c                                                      |    2 
 kernel/nsproxy.c                                                              |    2 
 kernel/profile.c                                                              |    2 
 kernel/rcu/rcutorture.c                                                       |    2 
 kernel/rcu/tree.c                                                             |   36 
 kernel/rcu/tree.h                                                             |    3 
 kernel/rcu/tree_exp.h                                                         |    2 
 kernel/rcu/tree_nocb.h                                                        |   61 
 kernel/reboot.c                                                               |    4 
 kernel/resource.c                                                             |   11 
 kernel/sched/cpufreq_schedutil.c                                              |   14 
 kernel/sched/fair.c                                                           |    7 
 kernel/seccomp.c                                                              |    7 
 kernel/signal.c                                                               |    5 
 kernel/sys.c                                                                  |    3 
 kernel/time/itimer.c                                                          |    2 
 kernel/time/namespace.c                                                       |    2 
 kernel/time/posix-cpu-timers.c                                                |    4 
 kernel/time/posix-stubs.c                                                     |    4 
 kernel/time/posix-timers.c                                                    |   22 
 kernel/time/timeconv.c                                                        |    6 
 kernel/time/timekeeping.c                                                     |    3 
 kernel/time/timer.c                                                           |    2 
 kernel/trace/bpf_trace.c                                                      |   13 
 kernel/trace/trace.c                                                          |    2 
 kernel/trace/trace_btf.c                                                      |   22 
 kernel/trace/trace_btf.h                                                      |    3 
 kernel/trace/trace_events_hist.c                                              |  133 
 kernel/trace/trace_probe.c                                                    |    5 
 kernel/trace/trace_uprobe.c                                                   |    2 
 kernel/ucount.c                                                               |   28 
 kernel/watch_queue.c                                                          |    2 
 lib/842/842_decompress.c                                                      |    7 
 lib/Makefile                                                                  |    2 
 lib/assoc_array.c                                                             |  355 
 lib/bitmap-str.c                                                              |  524 
 lib/bitmap.c                                                                  |  535 
 lib/cmdline.c                                                                 |   13 
 lib/cmdline_kunit.c                                                           |  101 
 lib/decompress_bunzip2.c                                                      |    6 
 lib/decompress_unlz4.c                                                        |    4 
 lib/fault-inject.c                                                            |    7 
 lib/klist.c                                                                   |   16 
 lib/kobject.c                                                                 |    2 
 lib/kobject_uevent.c                                                          |    8 
 lib/raid6/avx2.c                                                              |    6 
 lib/raid6/avx512.c                                                            |    6 
 lib/raid6/recov_avx2.c                                                        |    2 
 lib/raid6/recov_avx512.c                                                      |    2 
 lib/test_hmm.c                                                                |    2 
 mm/cma.c                                                                      |    2 
 mm/damon/core-test.h                                                          |   11 
 mm/damon/core.c                                                               |   54 
 mm/damon/sysfs-schemes.c                                                      |    6 
 mm/damon/sysfs.c                                                              |    2 
 mm/filemap.c                                                                  |   93 
 mm/gup.c                                                                      |   17 
 mm/gup_test.c                                                                 |   17 
 mm/huge_memory.c                                                              |    8 
 mm/hugetlb.c                                                                  |  135 
 mm/hugetlb_cgroup.c                                                           |   33 
 mm/internal.h                                                                 |    4 
 mm/khugepaged.c                                                               |   23 
 mm/kmemleak.c                                                                 |   12 
 mm/ksm.c                                                                      |   32 
 mm/madvise.c                                                                  |   18 
 mm/memcontrol.c                                                               |   95 
 mm/memfd.c                                                                    |    2 
 mm/memory-tiers.c                                                             |   29 
 mm/memory.c                                                                   |   74 
 mm/mempolicy.c                                                                |   37 
 mm/migrate.c                                                                  |   10 
 mm/mlock.c                                                                    |    2 
 mm/mmap.c                                                                     |    6 
 mm/mmu_notifier.c                                                             |   24 
 mm/mremap.c                                                                   |   57 
 mm/nommu.c                                                                    |    6 
 mm/page-writeback.c                                                           |   13 
 mm/page_alloc.c                                                               |   16 
 mm/page_isolation.c                                                           |    6 
 mm/page_table_check.c                                                         |    6 
 mm/page_vma_mapped.c                                                          |   29 
 mm/rmap.c                                                                     |   31 
 mm/shmem.c                                                                    |  104 
 mm/shmem_quota.c                                                              |   28 
 mm/slub.c                                                                     |   76 
 mm/swapfile.c                                                                 |    8 
 mm/truncate.c                                                                 |   10 
 mm/util.c                                                                     |   13 
 mm/vmscan.c                                                                   |   50 
 mm/zsmalloc.c                                                                 |   11 
 net/8021q/vlan_dev.c                                                          |   33 
 net/9p/trans_virtio.c                                                         |    5 
 net/9p/trans_xen.c                                                            |   14 
 net/batman-adv/bat_iv_ogm.c                                                   |    9 
 net/batman-adv/distributed-arp-table.c                                        |    1 
 net/batman-adv/main.c                                                         |   12 
 net/batman-adv/main.h                                                         |    3 
 net/batman-adv/tp_meter.c                                                     |    2 
 net/batman-adv/translation-table.c                                            |  145 
 net/batman-adv/types.h                                                        |    8 
 net/bluetooth/6lowpan.c                                                       |    4 
 net/bluetooth/hci_core.c                                                      |    4 
 net/bluetooth/hci_debugfs.c                                                   |    9 
 net/bluetooth/hci_event.c                                                     |    7 
 net/bluetooth/hci_sync.c                                                      |   65 
 net/bluetooth/iso.c                                                           |   10 
 net/bluetooth/l2cap_core.c                                                    |  112 
 net/bluetooth/l2cap_sock.c                                                    |    4 
 net/bluetooth/mgmt.c                                                          |   32 
 net/bluetooth/msft.c                                                          |    6 
 net/bluetooth/selftest.c                                                      |    1 
 net/bluetooth/smp.c                                                           |    1 
 net/bpf/test_run.c                                                            |  171 
 net/bridge/br_mdb.c                                                           |   16 
 net/bridge/br_multicast.c                                                     |   14 
 net/bridge/br_netlink.c                                                       |    2 
 net/bridge/br_private.h                                                       |   12 
 net/bridge/br_stp.c                                                           |    4 
 net/bridge/br_stp_bpdu.c                                                      |    2 
 net/bridge/br_switchdev.c                                                     |   23 
 net/bridge/br_vlan.c                                                          |    7 
 net/bridge/br_vlan_options.c                                                  |    2 
 net/bridge/netfilter/ebtables.c                                               |   12 
 net/can/af_can.c                                                              |   51 
 net/can/bcm.c                                                                 |   50 
 net/can/gw.c                                                                  |    7 
 net/can/isotp.c                                                               |  230 
 net/can/proc.c                                                                |   69 
 net/can/raw.c                                                                 |  136 
 net/ceph/messenger_v1.c                                                       |    8 
 net/ceph/mon_client.c                                                         |    5 
 net/ceph/osd_client.c                                                         |   13 
 net/ceph/osdmap.c                                                             |   18 
 net/core/bpf_sk_storage.c                                                     |    7 
 net/core/dev.c                                                                |   85 
 net/core/filter.c                                                             |   79 
 net/core/gro.c                                                                |    9 
 net/core/gso.c                                                                |    1 
 net/core/lwtunnel.c                                                           |    6 
 net/core/selftests.c                                                          |    2 
 net/core/skbuff.c                                                             |   26 
 net/core/sock.c                                                               |    7 
 net/dcb/dcbnl.c                                                               |    2 
 net/devlink/region.c                                                          |    5 
 net/ipv4/af_inet.c                                                            |    3 
 net/ipv4/gre_offload.c                                                        |    2 
 net/ipv4/inet_connection_sock.c                                               |   16 
 net/ipv4/inet_fragment.c                                                      |   66 
 net/ipv4/inet_hashtables.c                                                    |    5 
 net/ipv4/ip_fragment.c                                                        |   13 
 net/ipv4/ip_output.c                                                          |   24 
 net/ipv4/ip_sockglue.c                                                        |   48 
 net/ipv4/ip_tunnel.c                                                          |   14 
 net/ipv4/ipmr.c                                                               |   37 
 net/ipv4/metrics.c                                                            |    5 
 net/ipv4/netfilter/nf_nat_h323.c                                              |   22 
 net/ipv4/netfilter/nf_reject_ipv4.c                                           |   11 
 net/ipv4/netfilter/nf_tproxy_ipv4.c                                           |    2 
 net/ipv4/ping.c                                                               |    2 
 net/ipv4/raw.c                                                                |    2 
 net/ipv4/syncookies.c                                                         |    2 
 net/ipv4/sysctl_net_ipv4.c                                                    |    2 
 net/ipv4/tcp.c                                                                |   14 
 net/ipv4/tcp_bic.c                                                            |   14 
 net/ipv4/tcp_cong.c                                                           |    4 
 net/ipv4/tcp_cubic.c                                                          |   14 
 net/ipv4/tcp_hybla.c                                                          |   16 
 net/ipv4/tcp_input.c                                                          |    4 
 net/ipv4/tcp_metrics.c                                                        |   20 
 net/ipv4/tcp_offload.c                                                        |   12 
 net/ipv4/tcp_output.c                                                         |    2 
 net/ipv4/udp.c                                                                |    2 
 net/ipv6/addrconf.c                                                           |   46 
 net/ipv6/calipso.c                                                            |    6 
 net/ipv6/datagram.c                                                           |    4 
 net/ipv6/exthdrs.c                                                            |    2 
 net/ipv6/inet6_hashtables.c                                                   |    4 
 net/ipv6/ip6_offload.c                                                        |    4 
 net/ipv6/ip6mr.c                                                              |    5 
 net/ipv6/netfilter/nf_conntrack_reasm.c                                       |   15 
 net/ipv6/netfilter/nf_reject_ipv6.c                                           |   13 
 net/ipv6/netfilter/nf_tproxy_ipv6.c                                           |    2 
 net/ipv6/raw.c                                                                |    3 
 net/ipv6/reassembly.c                                                         |   14 
 net/ipv6/route.c                                                              |   22 
 net/ipv6/seg6.c                                                               |   33 
 net/ipv6/seg6_hmac.c                                                          |    5 
 net/ipv6/seg6_local.c                                                         |    6 
 net/ipv6/sit.c                                                                |    4 
 net/ipv6/udp.c                                                                |   13 
 net/l2tp/l2tp_core.c                                                          |   51 
 net/l2tp/l2tp_core.h                                                          |    6 
 net/l2tp/l2tp_debugfs.c                                                       |    4 
 net/l2tp/l2tp_netlink.c                                                       |   11 
 net/l2tp/l2tp_ppp.c                                                           |    8 
 net/mac80211/cfg.c                                                            |   53 
 net/mac80211/debugfs.c                                                        |    2 
 net/mac80211/ibss.c                                                           |    4 
 net/mac80211/ieee80211_i.h                                                    |    3 
 net/mac80211/main.c                                                           |    2 
 net/mac80211/mesh_pathtbl.c                                                   |   17 
 net/mac80211/rx.c                                                             |    1 
 net/mac80211/tdls.c                                                           |    3 
 net/mac80211/tx.c                                                             |  234 
 net/mctp/af_mctp.c                                                            |    4 
 net/mctp/route.c                                                              |  133 
 net/mctp/test/route-test.c                                                    |    7 
 net/mptcp/options.c                                                           |    9 
 net/mptcp/pm_netlink.c                                                        |    1 
 net/mptcp/protocol.c                                                          |   41 
 net/mptcp/protocol.h                                                          |   10 
 net/mptcp/subflow.c                                                           |   55 
 net/mptcp/token.c                                                             |   68 
 net/mptcp/token_test.c                                                        |    4 
 net/netfilter/ipvs/ip_vs_conn.c                                               |    8 
 net/netfilter/ipvs/ip_vs_ctl.c                                                |   38 
 net/netfilter/ipvs/ip_vs_dh.c                                                 |   16 
 net/netfilter/ipvs/ip_vs_fo.c                                                 |    2 
 net/netfilter/ipvs/ip_vs_lblc.c                                               |    4 
 net/netfilter/ipvs/ip_vs_lblcr.c                                              |    8 
 net/netfilter/ipvs/ip_vs_lc.c                                                 |    2 
 net/netfilter/ipvs/ip_vs_mh.c                                                 |    2 
 net/netfilter/ipvs/ip_vs_nq.c                                                 |    2 
 net/netfilter/ipvs/ip_vs_ovf.c                                                |    2 
 net/netfilter/ipvs/ip_vs_rr.c                                                 |    2 
 net/netfilter/ipvs/ip_vs_sed.c                                                |    4 
 net/netfilter/ipvs/ip_vs_sh.c                                                 |    2 
 net/netfilter/ipvs/ip_vs_sync.c                                               |   27 
 net/netfilter/ipvs/ip_vs_twos.c                                               |    4 
 net/netfilter/ipvs/ip_vs_wlc.c                                                |    4 
 net/netfilter/ipvs/ip_vs_wrr.c                                                |    2 
 net/netfilter/nf_conntrack_core.c                                             |    5 
 net/netfilter/nf_conntrack_expect.c                                           |   35 
 net/netfilter/nf_conntrack_netlink.c                                          |   10 
 net/netfilter/nf_conntrack_proto_tcp.c                                        |    6 
 net/netfilter/nf_conntrack_seqadj.c                                           |   17 
 net/netfilter/nf_flow_table_ip.c                                              |   30 
 net/netfilter/nf_nat_sip.c                                                    |   20 
 net/netfilter/nf_synproxy_core.c                                              |    4 
 net/netfilter/nft_compat.c                                                    |   15 
 net/netfilter/nft_meta.c                                                      |    6 
 net/netfilter/nft_rt.c                                                        |    6 
 net/netfilter/nft_xfrm.c                                                      |    9 
 net/netfilter/xt_dccp.c                                                       |    2 
 net/netlink/af_netlink.c                                                      |   12 
 net/openvswitch/actions.c                                                     |    9 
 net/openvswitch/vport-internal_dev.c                                          |    8 
 net/packet/af_packet.c                                                        |  110 
 net/rds/af_rds.c                                                              |   29 
 net/rds/bind.c                                                                |    4 
 net/rds/ib_cm.c                                                               |    6 
 net/rds/ib_rdma.c                                                             |    4 
 net/rds/ib_recv.c                                                             |   13 
 net/rds/ib_sysctl.c                                                           |    2 
 net/rds/message.c                                                             |   26 
 net/rds/rdma.c                                                                |   63 
 net/rds/rdma_transport.c                                                      |    3 
 net/rds/rds.h                                                                 |   18 
 net/rds/recv.c                                                                |   17 
 net/rds/send.c                                                                |   27 
 net/rds/sysctl.c                                                              |    2 
 net/rds/tcp.c                                                                 |    9 
 net/rds/tcp_recv.c                                                            |    4 
 net/rxrpc/recvmsg.c                                                           |   28 
 net/rxrpc/rxperf.c                                                            |   28 
 net/rxrpc/sendmsg.c                                                           |   59 
 net/sched/act_api.c                                                           |   24 
 net/sched/act_ct.c                                                            |    5 
 net/sched/act_ife.c                                                           |    4 
 net/sched/cls_flower.c                                                        |   50 
 net/sched/sch_etf.c                                                           |    1 
 net/sched/sch_generic.c                                                       |   51 
 net/sched/sch_gred.c                                                          |   16 
 net/sched/sch_qfq.c                                                           |    3 
 net/sched/sch_taprio.c                                                        |   11 
 net/sched/sch_teql.c                                                          |   60 
 net/sctp/associola.c                                                          |    4 
 net/sctp/endpointola.c                                                        |    4 
 net/sctp/sm_make_chunk.c                                                      |   14 
 net/sctp/socket.c                                                             |   83 
 net/smc/smc_pnet.c                                                            |   29 
 net/smc/smc_rx.c                                                              |   39 
 net/smc/smc_tx.c                                                              |    7 
 net/sunrpc/auth_gss/svcauth_gss.c                                             |   29 
 net/sunrpc/svc.c                                                              |    9 
 net/sunrpc/svc_xprt.c                                                         |   24 
 net/sunrpc/svcauth_unix.c                                                     |    7 
 net/sunrpc/svcsock.c                                                          |   86 
 net/sunrpc/xprtrdma/rpc_rdma.c                                                |   27 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                                      |   10 
 net/sunrpc/xprtrdma/verbs.c                                                   |    9 
 net/sunrpc/xprtsock.c                                                         |   34 
 net/switchdev/switchdev.c                                                     |    2 
 net/tipc/bearer.c                                                             |    4 
 net/tipc/group.c                                                              |   19 
 net/tipc/node.c                                                               |    2 
 net/tipc/socket.c                                                             |   12 
 net/tls/tls_device.c                                                          |   21 
 net/tls/tls_main.c                                                            |   13 
 net/unix/sysctl_net_unix.c                                                    |    4 
 net/vmw_vsock/virtio_transport.c                                              |    4 
 net/vmw_vsock/vmci_transport.c                                                |   34 
 net/wireless/nl80211.c                                                        |   10 
 net/wireless/reg.c                                                            |   44 
 net/wireless/sme.c                                                            |   38 
 net/xdp/xsk_buff_pool.c                                                       |    2 
 net/xdp/xsk_queue.c                                                           |   12 
 net/xfrm/espintcp.c                                                           |   43 
 net/xfrm/xfrm_input.c                                                         |   10 
 net/xfrm/xfrm_interface_core.c                                                |    8 
 net/xfrm/xfrm_policy.c                                                        |   11 
 scripts/Makefile.vmlinux_o                                                    |    2 
 scripts/checkkconfigsymbols.py                                                |    2 
 scripts/checkpatch.pl                                                         |    2 
 scripts/clang-tools/run-clang-tools.py                                        |    1 
 scripts/gdb/linux/radixtree.py                                                |  197 
 scripts/kconfig/conf.c                                                        |   33 
 scripts/kconfig/symbol.c                                                      |   71 
 scripts/kconfig/tests/conftest.py                                             |    9 
 scripts/kconfig/tests/randconfig_probability/Kconfig                          |   12 
 scripts/kconfig/tests/randconfig_probability/__init__.py                      |  130 
 scripts/kconfig/tests/savedefconfig_range/Kconfig                             |   60 
 scripts/kconfig/tests/savedefconfig_range/__init__.py                         |    8 
 scripts/kconfig/tests/savedefconfig_range/config                              |    7 
 scripts/link-vmlinux.sh                                                       |   19 
 security/apparmor/apparmorfs.c                                                |   25 
 security/apparmor/domain.c                                                    |   24 
 security/apparmor/include/label.h                                             |    6 
 security/apparmor/include/match.h                                             |    8 
 security/apparmor/include/policy.h                                            |    1 
 security/apparmor/include/policy_ns.h                                         |   16 
 security/apparmor/label.c                                                     |   15 
 security/apparmor/lsm.c                                                       |    7 
 security/apparmor/match.c                                                     |  152 
 security/apparmor/mount.c                                                     |    4 
 security/apparmor/policy.c                                                    |   17 
 security/apparmor/policy_ns.c                                                 |    8 
 security/apparmor/policy_unpack.c                                             |   19 
 security/integrity/ima/ima_template.c                                         |    5 
 security/keys/encrypted-keys/encrypted.c                                      |   20 
 security/landlock/fs.c                                                        |   10 
 security/security.c                                                           |    3 
 sound/core/compress_offload.c                                                 |   60 
 sound/core/control.c                                                          |    2 
 sound/core/hwdep.c                                                            |    2 
 sound/core/info.c                                                             |   96 
 sound/core/info_oss.c                                                         |   10 
 sound/core/init.c                                                             |  243 
 sound/core/jack.c                                                             |    5 
 sound/core/misc.c                                                             |   27 
 sound/core/oss/mixer_oss.c                                                    |   36 
 sound/core/oss/pcm_oss.c                                                      |   12 
 sound/core/pcm.c                                                              |   16 
 sound/core/pcm_compat.c                                                       |    4 
 sound/core/pcm_lib.c                                                          |   50 
 sound/core/pcm_local.h                                                        |    6 
 sound/core/pcm_native.c                                                       |  162 
 sound/core/rawmidi.c                                                          |  254 
 sound/core/seq/oss/seq_oss_device.h                                           |    1 
 sound/core/seq/oss/seq_oss_event.c                                            |    3 
 sound/core/seq/oss/seq_oss_init.c                                             |    2 
 sound/core/seq/seq_compat.c                                                   |   27 
 sound/core/seq/seq_midi.c                                                     |   14 
 sound/core/sound.c                                                            |   28 
 sound/core/sound_oss.c                                                        |   17 
 sound/core/ump.c                                                              |    2 
 sound/core/ump_convert.c                                                      |    4 
 sound/core/vmaster.c                                                          |   10 
 sound/drivers/aloop.c                                                         |   80 
 sound/drivers/mpu401/mpu401_uart.c                                            |    8 
 sound/drivers/pcmtest.c                                                       |   67 
 sound/hda/ext/hdac_ext_stream.c                                               |    4 
 sound/hda/hdac_bus.c                                                          |    9 
 sound/hda/hdac_device.c                                                       |  124 
 sound/isa/sb/emu8000_patch.c                                                  |   13 
 sound/mips/sgio2audio.c                                                       |   13 
 sound/oss/dmasound/dmasound_q40.c                                             |   65 
 sound/pci/cs46xx/dsp_spos.c                                                   |    4 
 sound/pci/cs46xx/dsp_spos_scb_lib.c                                           |    3 
 sound/pci/emu10k1/emu10k1_patch.c                                             |   85 
 sound/pci/hda/hda_codec.c                                                     |   14 
 sound/pci/hda/hda_eld.c                                                       |    6 
 sound/pci/hda/hda_intel.c                                                     |   19 
 sound/pci/hda/hda_jack.c                                                      |    9 
 sound/pci/hda/hda_sysfs.c                                                     |    4 
 sound/pci/hda/patch_conexant.c                                                |   17 
 sound/pci/hda/patch_hdmi.c                                                    |    3 
 sound/pci/hda/patch_realtek.c                                                 |   72 
 sound/pci/hda/patch_via.c                                                     |    1 
 sound/pci/oxygen/oxygen.c                                                     |   12 
 sound/pci/oxygen/oxygen_mixer.c                                               |   60 
 sound/pci/oxygen/oxygen_pcm.c                                                 |   54 
 sound/pci/oxygen/xonar_cs43xx.c                                               |    3 
 sound/pci/oxygen/xonar_dg_mixer.c                                             |   33 
 sound/pci/oxygen/xonar_pcm179x.c                                              |   18 
 sound/pci/oxygen/xonar_wm87x6.c                                               |   31 
 sound/pci/via82xx.c                                                           |   11 
 sound/sh/aica.c                                                               |    2 
 sound/soc/amd/acp-config.c                                                    |   14 
 sound/soc/amd/acp-es8336.c                                                    |    5 
 sound/soc/amd/acp/acp-platform.c                                              |    2 
 sound/soc/amd/ps/ps-pdm-dma.c                                                 |    2 
 sound/soc/amd/ps/ps-sdw-dma.c                                                 |    2 
 sound/soc/amd/raven/acp3x-pcm-dma.c                                           |    4 
 sound/soc/amd/renoir/acp3x-pdm-dma.c                                          |    2 
 sound/soc/amd/vangogh/acp5x-pcm-dma.c                                         |    2 
 sound/soc/amd/yc/acp6x-mach.c                                                 |   28 
 sound/soc/amd/yc/acp6x-pdm-dma.c                                              |    2 
 sound/soc/atmel/atmel-i2s.c                                                   |   43 
 sound/soc/atmel/atmel-pcm-pdc.c                                               |    2 
 sound/soc/codecs/adau17x1.c                                                   |    4 
 sound/soc/codecs/ak4642.c                                                     |    3 
 sound/soc/codecs/arizona-jack.c                                               |    1 
 sound/soc/codecs/cs42l56.c                                                    |    1 
 sound/soc/codecs/da732x.c                                                     |    2 
 sound/soc/codecs/es8316.c                                                     |    4 
 sound/soc/codecs/es8326.c                                                     |  177 
 sound/soc/codecs/es8326.h                                                     |    2 
 sound/soc/codecs/hdac_hda.c                                                   |   40 
 sound/soc/codecs/hdac_hdmi.c                                                  |   10 
 sound/soc/codecs/max98396.c                                                   |   24 
 sound/soc/codecs/max98926.c                                                   |    2 
 sound/soc/codecs/mt6359-accdet.c                                              |   50 
 sound/soc/codecs/nau8540.c                                                    |    4 
 sound/soc/codecs/rt1011.c                                                     |    4 
 sound/soc/codecs/rt1016.c                                                     |    4 
 sound/soc/codecs/rt1305.c                                                     |    4 
 sound/soc/codecs/rt1308.c                                                     |    4 
 sound/soc/codecs/rt5616.c                                                     |    3 
 sound/soc/codecs/rt5659.c                                                     |   10 
 sound/soc/codecs/rt5660.c                                                     |    4 
 sound/soc/codecs/rt5665.c                                                     |    4 
 sound/soc/codecs/rt5682-sdw.c                                                 |    3 
 sound/soc/codecs/rt711-sdca-sdw.c                                             |    6 
 sound/soc/codecs/rt711-sdw.c                                                  |    8 
 sound/soc/codecs/rt712-sdca-dmic.c                                            |    4 
 sound/soc/codecs/rt712-sdca-sdw.c                                             |    6 
 sound/soc/codecs/rt722-sdca-sdw.c                                             |    6 
 sound/soc/codecs/sma1303.c                                                    |    2 
 sound/soc/codecs/sta32x.c                                                     |   20 
 sound/soc/codecs/sta350.c                                                     |   20 
 sound/soc/codecs/tlv320adc3xxx.c                                              |    2 
 sound/soc/codecs/tlv320aic26.c                                                |    6 
 sound/soc/codecs/tlv320aic32x4-clk.c                                          |   76 
 sound/soc/codecs/tlv320aic32x4-i2c.c                                          |   38 
 sound/soc/codecs/tlv320aic32x4-spi.c                                          |   41 
 sound/soc/codecs/tlv320aic32x4.c                                              |  288 
 sound/soc/codecs/tlv320aic32x4.h                                              |    9 
 sound/soc/codecs/wcd-mbhc-v2.c                                                |    8 
 sound/soc/codecs/wcd9335.c                                                    |   25 
 sound/soc/codecs/wm5100.c                                                     |    2 
 sound/soc/codecs/wm8510.c                                                     |    2 
 sound/soc/codecs/wm8737.c                                                     |    8 
 sound/soc/codecs/wm8750.c                                                     |    2 
 sound/soc/codecs/wm8955.c                                                     |    2 
 sound/soc/codecs/wm8983.c                                                     |    2 
 sound/soc/codecs/wm8985.c                                                     |    2 
 sound/soc/codecs/wm8990.c                                                     |   10 
 sound/soc/codecs/wm8991.c                                                     |   10 
 sound/soc/codecs/wm8994.c                                                     |  162 
 sound/soc/codecs/wm8994.h                                                     |    2 
 sound/soc/codecs/wm_hubs.c                                                    |    2 
 sound/soc/codecs/wsa883x.c                                                    |    4 
 sound/soc/codecs/wsa884x.c                                                    |    4 
 sound/soc/dwc/dwc-i2s.c                                                       |    6 
 sound/soc/fsl/fsl_asrc.c                                                      |    8 
 sound/soc/fsl/fsl_asrc_dma.c                                                  |    5 
 sound/soc/fsl/imx-pcm-rpmsg.c                                                 |    2 
 sound/soc/intel/atom/sst-atom-controls.c                                      |   38 
 sound/soc/intel/atom/sst-mfld-platform-pcm.c                                  |   36 
 sound/soc/intel/atom/sst/sst_acpi.c                                           |   14 
 sound/soc/intel/avs/boards/da7219.c                                           |    4 
 sound/soc/intel/avs/boards/es8336.c                                           |    8 
 sound/soc/intel/avs/boards/i2s_test.c                                         |    2 
 sound/soc/intel/avs/boards/max98373.c                                         |    2 
 sound/soc/intel/avs/boards/max98927.c                                         |    2 
 sound/soc/intel/avs/boards/nau8825.c                                          |    8 
 sound/soc/intel/avs/boards/rt274.c                                            |    4 
 sound/soc/intel/avs/boards/rt286.c                                            |    8 
 sound/soc/intel/avs/boards/rt298.c                                            |    8 
 sound/soc/intel/avs/boards/rt5663.c                                           |    8 
 sound/soc/intel/avs/boards/rt5682.c                                           |    8 
 sound/soc/intel/avs/boards/ssm4567.c                                          |    4 
 sound/soc/intel/avs/loader.c                                                  |    4 
 sound/soc/intel/avs/path.c                                                    |    2 
 sound/soc/intel/avs/pcm.c                                                     |  195 
 sound/soc/intel/avs/probes.c                                                  |    3 
 sound/soc/intel/avs/utils.c                                                   |    6 
 sound/soc/intel/boards/bytcr_rt5651.c                                         |   17 
 sound/soc/intel/boards/sof_sdw_rt711.c                                        |    1 
 sound/soc/mediatek/common/mtk-afe-fe-dai.c                                    |    8 
 sound/soc/mediatek/mt6797/mt6797-afe-clk.c                                    |   14 
 sound/soc/mediatek/mt8183/mt8183-afe-clk.c                                    |   22 
 sound/soc/mediatek/mt8186/mt8186-afe-clk.c                                    |   95 
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c                                    |  104 
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c                                    |   24 
 sound/soc/mediatek/mt8192/mt8192-afe-clk.c                                    |  139 
 sound/soc/mediatek/mt8192/mt8192-afe-gpio.c                                   |   90 
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c                                    |    6 
 sound/soc/mediatek/mt8192/mt8192-dai-adda.c                                   |   48 
 sound/soc/mediatek/mt8192/mt8192-dai-i2s.c                                    |   24 
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c                                    |   18 
 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c                       |   37 
 sound/soc/mediatek/mt8195/mt8195-afe-clk.c                                    |   77 
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c                                    |   98 
 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c                                   |   99 
 sound/soc/qcom/qdsp6/q6afe.c                                                  |   10 
 sound/soc/qcom/qdsp6/q6apm-dai.c                                              |   12 
 sound/soc/qcom/qdsp6/q6apm.c                                                  |    8 
 sound/soc/qcom/qdsp6/q6prm.c                                                  |    3 
 sound/soc/qcom/sdm845.c                                                       |   26 
 sound/soc/rockchip/rockchip_i2s.c                                             |    4 
 sound/soc/samsung/midas_wm1811.c                                              |   16 
 sound/soc/soc-ac97.c                                                          |    4 
 sound/soc/soc-component.c                                                     |    2 
 sound/soc/soc-link.c                                                          |   10 
 sound/soc/soc-ops.c                                                           |   10 
 sound/soc/sof/intel/hda-codec.c                                               |   22 
 sound/soc/stm/stm32_i2s.c                                                     |   27 
 sound/soc/ti/davinci-mcasp.c                                                  |    1 
 sound/soc/xilinx/xlnx_formatter_pcm.c                                         |   18 
 sound/synth/emux/emux.c                                                       |   16 
 sound/synth/emux/emux_effect.c                                                |   29 
 sound/synth/emux/emux_hwdep.c                                                 |    9 
 sound/synth/emux/emux_oss.c                                                   |   12 
 sound/synth/emux/emux_seq.c                                                   |   17 
 sound/synth/emux/emux_synth.c                                                 |   69 
 sound/synth/emux/soundfont.c                                                  |  196 
 sound/usb/6fire/control.c                                                     |    7 
 sound/usb/bcd2000/bcd2000.c                                                   |   20 
 sound/usb/caiaq/device.c                                                      |    9 
 sound/usb/caiaq/device.h                                                      |    6 
 sound/usb/caiaq/input.c                                                       |   31 
 sound/usb/caiaq/midi.c                                                        |    2 
 sound/usb/line6/capture.c                                                     |   61 
 sound/usb/line6/capture.h                                                     |    2 
 sound/usb/line6/driver.c                                                      |   31 
 sound/usb/line6/midi.c                                                        |   10 
 sound/usb/line6/pcm.c                                                         |   43 
 sound/usb/line6/playback.c                                                    |   31 
 sound/usb/midi.c                                                              |   22 
 sound/usb/mixer.c                                                             |  123 
 sound/usb/mixer.h                                                             |    5 
 sound/usb/mixer_maps.c                                                        |   27 
 sound/usb/mixer_quirks.c                                                      |    9 
 sound/usb/mixer_us16x08.c                                                     |    3 
 sound/usb/pcm.c                                                               |   20 
 sound/usb/quirks-table.h                                                      |   24 
 sound/usb/quirks.c                                                            |   26 
 sound/usb/usbaudio.h                                                          |    4 
 sound/usb/usx2y/us122l.c                                                      |   31 
 sound/usb/usx2y/usX2Yhwdep.c                                                  |    5 
 sound/usb/usx2y/usb_stream.c                                                  |    9 
 sound/usb/usx2y/usbusx2yaudio.c                                               |   44 
 sound/x86/intel_hdmi_audio.c                                                  |    9 
 tools/bootconfig/main.c                                                       |   32 
 tools/bpf/bpftool/common.c                                                    |   40 
 tools/bpf/bpftool/gen.c                                                       |  245 
 tools/bpf/bpftool/link.c                                                      |  121 
 tools/bpf/bpftool/main.c                                                      |   24 
 tools/bpf/bpftool/main.h                                                      |    1 
 tools/bpf/bpftool/map.c                                                       |  101 
 tools/bpf/bpftool/prog.c                                                      |    2 
 tools/bpf/bpftool/tracelog.c                                                  |    2 
 tools/cgroup/memcg_shrinker.py                                                |    2 
 tools/include/linux/types.h                                                   |    5 
 tools/include/nolibc/stdlib.h                                                 |    8 
 tools/include/nolibc/types.h                                                  |    2 
 tools/include/uapi/linux/bpf.h                                                |    1 
 tools/include/uapi/sound/asound.h                                             |    7 
 tools/lib/api/fd/array.c                                                      |    5 
 tools/lib/bpf/btf.c                                                           |    4 
 tools/lib/bpf/ringbuf.c                                                       |    2 
 tools/lib/perf/mmap.c                                                         |    2 
 tools/lib/thermal/include/thermal.h                                           |    4 
 tools/perf/Documentation/perf-c2c.txt                                         |    2 
 tools/perf/builtin-c2c.c                                                      |   16 
 tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json              |    6 
 tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json                   |   68 
 tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json            |   10 
 tools/perf/util/Build                                                         |    2 
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c                               |    2 
 tools/perf/util/header.c                                                      |   18 
 tools/perf/util/jitdump.c                                                     |  128 
 tools/perf/util/mem-events.c                                                  |    2 
 tools/perf/util/mmap.c                                                        |    3 
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c               |   18 
 tools/testing/selftests/Makefile                                              |    4 
 tools/testing/selftests/alsa/mixer-test.c                                     |    2 
 tools/testing/selftests/alsa/test-pcmtest-driver.c                            |   27 
 tools/testing/selftests/arm64/signal/Makefile                                 |    4 
 tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c            |    4 
 tools/testing/selftests/bpf/prog_tests/empty_skb.c                            |   59 
 tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c                 |   10 
 tools/testing/selftests/bpf/prog_tests/test_tunnel.c                          |   13 
 tools/testing/selftests/bpf/progs/cpumask_success.c                           |    6 
 tools/testing/selftests/bpf/progs/empty_skb.c                                 |    7 
 tools/testing/selftests/clone3/clone3_clear_sighand.c                         |    6 
 tools/testing/selftests/core/Makefile                                         |    2 
 tools/testing/selftests/core/unshare_test.c                                   |  109 
 tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c                 |   32 
 tools/testing/selftests/ftrace/ftracetest                                     |    5 
 tools/testing/selftests/mm/vm_util.h                                          |    1 
 tools/testing/selftests/net/csum.c                                            |   67 
 tools/testing/selftests/net/fib_nexthops.sh                                   |   46 
 tools/testing/selftests/net/fin_ack_lat.c                                     |    2 
 tools/testing/selftests/net/reuseport_bpf_numa.c                              |   24 
 tools/testing/selftests/net/tcp_mmap.c                                        |    6 
 tools/testing/selftests/net/txtimestamp.c                                     |   23 
 tools/testing/selftests/netfilter/conntrack_vrf.sh                            |  140 
 tools/testing/selftests/seccomp/seccomp_bpf.c                                 |  179 
 tools/testing/selftests/timers/clocksource-switch.c                           |   23 
 tools/thermal/tmon/tmon.c                                                     |    2 
 usr/gen_init_cpio.c                                                           |    1 
 virt/kvm/kvm_main.c                                                           |   31 
 2568 files changed, 116817 insertions(+), 24310 deletions(-)

Aamir Ahmed (2):
      clk: mvebu: ap-cpu-clk: Assign .num before accessing .hws
      lib: decompress_bunzip2: fix integer overflow in run-length decoding

Aaradhana Sahu (2):
      wifi: ath12k: Free allocated CE IRQs on request_irq() failure
      wifi: ath12k: Free allocated external IRQs on request_irq() failure

Aaron Kling (2):
      dt-bindings: vendor-prefixes: Add Chip Wealth Technology
      dt-bindings: vendor-prefixes: Add Retroid Pocket

Aaron Ma (1):
      HID: quirks: Add ALWAYS_POLL quirk for Beitong BTP-KP20D dongle

Abdelnasser Hussein (4):
      staging: iio: adc: ad7816: Fix DMA safety issues in SPI transfers
      staging: iio: adc: ad7816: Sort headers alphabetically
      staging: iio: adc: ad7816: Serialize SPI operations
      staging: iio: adc: ad7816: Protect sysfs attributes with mutex

Abdifatah Suruur (7):
      ksmbd: reserve space for the UTF-16 terminator in stream info
      smb: client: fix fiemap wild read on empty truncated response
      xen/gntdev: prevent private mappings from becoming writable
      smb: client: validate the data area in SMB2_read()
      vfio/platform: prevent read-only region mappings from becoming writable
      vfio/fsl-mc: prevent read-only region mappings from becoming writable
      vfio/cdx: prevent read-only region mappings from becoming writable

Abdun Nihaal (1):
      wifi: ath11k: Fix possible memory leak in ath11k_dp_srng_setup()

Abdurrahman Karadag (1):
      wifi: rtw88: debugfs: don't vzalloc(0) when rsvd_page is read unconfigured

Abel Vesa (5):
      soc: qcom: pmic_glink: Fix device access from worker during suspend
      arm64: dts: qcom: sm8150: Use SM8150_CX for the SDHC power domain
      clk: qcom: mmcc-msm8996: Fix FD AHB clock register offset
      clk: qcom: mmcc-sdm660: Fix MDSS AHB clock HWCG register offset
      clk: qcom: mmcc-msm8960: Configure PLL15 only on APQ8064

Abhijeeth Babu (1):
      i2c: acpi: Force ELAN1300 touchpads to 100 kHz

Abhishek Dubey (1):
      powerpc/bpf: fix buffer overflow in JIT for large BPF programs

Abin Joseph (1):
      dmaengine: zynqmp_dma: Add support for AMD Versal Gen 2 DMA IP

Abraham Zukor (1):
      spi: tegra114: initialize native chip selects inactive

Adam Skladowski (1):
      dt-bindings: vendor-prefixes: Add LeEco

Adarsh Das (1):
      smb: client: delete compound mids on send failure before unlock

Adi Nata (1):
      iio: humidity: hts221: report available values via read_avail()

Adrian Ambrozewicz (1):
      gpiolib: cdev: don't set GPIOD_FLAG_IS_OUT

Adrian Hunter (1):
      i3c: master: Fix potential UAF in i3c_device_uevent()

Adrián Larumbe (2):
      drm/panfrost: Prevent division by 0
      drm/panfrost: Explicitly enable MMU interrupts at device init

Ahmad Fatoum (2):
      ARM: dts: stm32: lxa-mc1: change stdout-path baud rate from 9600 to 115200
      ARM: dts: stm32: lxa-tac: change stdout-path baud rate from 9600 to 115200

Ahmed Naseef (3):
      wifi: mt76: mt7603: add 0x7592 EEPROM chip ID
      net: phy: mediatek: do not report link and per-speed LED rules together
      wifi: mt76: mt7615: read MT7663 temperature from the correct offset

Ahmed Yaseen (1):
      platform/x86: asus-wmi: validate custom fan curves on enable

Ahsan Atta (3):
      crypto: qat - initialise state_lock on every path in adf_devmgr_add_dev()
      crypto: qat - avoid OOB read when stripping RSA leading zeros
      crypto: qat - fix active_devs leak on crypto alg registration failure

Ajay Kumar Nandam (1):
      ASoC: qcom: q6apm: clear g_apm on driver removal

Akash Sukhavasi (1):
      phy: HiSilicon: Fix error handling in hi3670_pcie_allclk_ctrl()

Akhil P Oommen (1):
      drm/msm/a6xx: Fix secondary rail vote in ARC votes

Akshay Jindal (1):
      iommu/amd: Skip non-IVMD entries when parsing IVRS memory definitions

Al Viro (2):
      ufs: fix ufs_read_cylinder() failure handling
      selftests:core: test coverage for dup_fd() failure handling in unshare_fd()

Alan Stern (1):
      HID: core: Fix out-of-bounds left shift by 32 in s32ton()

Aldo Ariel Panzardo (11):
      Bluetooth: ISO: release unused CIS holds after channel attach
      xfs: reject out-of-range attribute value lengths in xfs_attr_copy_value
      xfs: reject remote xattr entries with an out-of-range value length
      xfs: bound inode fork length against the fork size during log recovery
      nfsd: clear XDR padding in GETXATTR replies
      NFSD: copy SETXATTR data from all XDR buffer segments
      nfsd: propagate SETXATTR value decode errors
      nfsd: zero NFSv4 COMPOUND tag padding
      nilfs2: fix checkpoint root lifetime on sysfs errors
      crypto: nx - validate 'ignore' before subtracting in decompress
      xfs: bound da-node entry count against the correct geometry

Alejandro Lucero (1):
      ACPI: HMAT: preserve hmat_adist_nb notifier block

Aleksander Jan Bajkowski (1):
      net: sfp: add quirk for HORACO copper SFP+ module

Aleksandr Nogikh (2):
      media: usbtv: fix null-pointer dereference on disconnect
      usb: gadget: dummy_hcd: prevent unbind via sysfs

Aleksandrova Alyona (1):
      platform/x86: intel_telemetry: initialize default trace verbosity

Alex Deucher (4):
      drm/amd: Fix UBSAN array-index-out-of-bounds for Powerplay headers
      drm/amdgpu/atomfirmware: WARN() rather than BUG()
      drm/amdgpu/gfx11: WARN() rather than BUG() for invalid SDMA engine
      drm/amdgpu/pm: add workload profile pause helper

Alex Elder (1):
      net: stmmac: use dma_addr_t for DMA addresses

Alex Hung (1):
      drm/amd/display: Avoid closing unowned DDC pins

Alex Kazinsky (3):
      ASoC: tlv320aic32x4: Prevent division by zero in divider callbacks
      wifi: rsi: Skip TX aggregation setup for non-QoS frames
      ALSA: cs46xx: Handle SCB creation failures before dereferencing

Alex Markuze (1):
      ceph: fix page vector leak on encrypted netfs read EIO path

Alexander A. Klimov (1):
      microblaze: CCF: fix refcount leak

Alexander Kochetkov (1):
      Revert "Input: matrix_keypad - force switch rows to input mode"

Alexander Sverdlin (2):
      pwm: tiehrpwm: Clear period on disable to allow reconfiguration
      tpm: tpm2_probe: propagate transport errors

Alexander Wilhelm (1):
      wifi: ath12k: fix scan command endianness on big endian

Alexandre Belloni (1):
      rtc: s35390a: fix typo in comment

Alexandre Cassen (1):
      net/sched: act_api: inherit filter offload flags only on new actions

Alexei Starovoitov (5):
      net: reject a negative TCP header offset in qdisc_pkt_len_segs_init()
      bpf: Clear sk_refcnt of a clone before its storage is linked
      bpf: Don't take an extension for a writable raw tracepoint program
      bpf: Don't take a program with a target program for an iterator
      bpf: Use memmove() to store bytes in an xdp_buff

Alexey Charkov (2):
      regulator: of: fill in supply names in of_regulator_bulk_get_all()
      nvmem: rockchip-otp: Serialize reads

Alexey Klimov (1):
      ASoC: qcom: sdm845: add handling of secondary MI2S clock

Ali Alaei (1):
      PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow Lake-HX

Ali Resool Tuama (1):
      USB: quirks: add USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE for GameSir G7 SE

Alison Schofield (1):
      cxl/hdm: Reject switch decoder interleave ways that overflow targets

Allison Henderson (6):
      net/rds: don't use unpin_user_pages_dirty_lock() from atomic context
      net/rds: unpin MR pages with unpin_user_pages_dirty_lock()
      net/rds: include the scope id in the sendmsg connection cache check
      net/rds: keep the connected peer's scope id apart from the bound one
      net/rds: do not fail init when CONFIG_SYSCTL=n
      net/rds: do not initialize transports after rds_init() failed

Alok Tiwari (1):
      octeontx2-af: Fix CQ enable state tracking after AQ writes

Aloka Dixit (2):
      Revert "wifi: mac80211: do not use old MBSSID elements"
      wifi: mac80211: remove redundant null check in ieee80211_assign_beacon()

Amadeusz Sławiński (5):
      ALSA: pcm: Fix driver_tstamp value reporting
      ASoC: soc-link: Correct stream stop operations in snd_soc_link_trigger
      ASoC: ops: Fix return value in snd_soc_limit_volume()
      ASoC: soc-ac97: Fix error handling in snd_soc_new_ac97_component()
      ASoC: soc-component: Fix return type of snd_soc_pcm_component_pointer()

Ameer Hamza (2):
      nfsd: don't modify a session slot when replaying its cached reply
      sunrpc: treat empty auth.unix.gid replies as negative entries

Amir Goldstein (4):
      ovl: fortify ovl_copy_xattr() against underlying layer modifications
      ovl: skip copy up of empty security.capability
      ovl: inherit FMODE_NONOTIFY when opening directory realfiles
      ovl: inherit FMODE_NONOTIFY when reading directory layers

Amit Machhiwal (3):
      KVM: PPC: Book3S HV: Add SRCU protection for virtual-mode HPT hcalls
      KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-lock users
      KVM: PPC: Fix get_d_signext() 12-bit displacement for paired-single D-form

Anastasios Papagiannis (1):
      mm/nommu: reject wrapping ranges in access_remote_vm()

Andi Shyti (1):
      media: cx231xx: Fix cleanup path on failure

Andrea Parri (8):
      kcsan: Avoid division by zero in kcsan_prandom_u32_max()
      iomap: don't lose a fiemap iteration error when emitting the last extent
      nvmet: zns: don't leak stale memory in zone management receive
      nvmet-fc: only send read data for successful commands
      iommufd/iova_bitmap: Ensure that iova_bitmap_set() handles the full IOVA
      pstore: don't leave an ERR_PTR in the ramoops zone pointer
      pstore: reject persistent RAM zones too small for the buffer header
      nvmet: zns: reject a NUMD whose byte count wraps

Andrea Pesaresi (1):
      arm64: dts: mediatek: mt7986: correct timer frequency

Andrea Scian (1):
      mtd: rawnand: pl353: Add message about ECC mode

Andreas Haufler (1):
      tools/lib/thermal: Fix misplaced extern "C" closing brace

Andreas Kemnade (3):
      fbdev: omap2: dsi: do not copy isr table
      drm/omap: dsi: avoid sending bta sync all the time in writes
      rtc: bd70528: properly enable wakeup

Andreas Wendleder (1):
      wifi: b43: fix use-after-free in b43_bcma_remove()

Andrejs Cainikovs (1):
      arm64: dts: ti: verdin-am62: add support for Verdin USB1 interface

Andrew Gaylard (1):
      pinctrl: fix PINCTRL_SPPCTL=m

Andrew Morton (1):
      openrisc: export __mulsi3 for modules

Andrew Stellman (1):
      nvmet-rdma: fix out-of-bounds write in nvmet_rdma_map_sgl_inline()

Andrey Albershteyn (1):
      fsverity: hoist statx reporting of fs-verity flag

Andrey Misiurov (1):
      fbdev: core: Initialize modelist in framebuffer_alloc()

André Draszik (4):
      kbuild: link-vmlinux.sh: improve detection of third pass requirement
      drm/drm_crtc: ensure dma_fence_ops remain valid during device unbind
      rtc: ftrtc010: drop needless struct ftrtc010_rtc::rtc_dev member
      rtc: s35390a: drop needless struct s35390a::rtc member

Andy Shevchenko (7):
      iio: adc: ad7192: Revert "properly check spi_get_device_match_data()"
      serial: 8250_exar: Clear interrupts before registering handler
      gpio: pca953x: Utilise temporary variable for struct gpio_chip
      bitmap: Remove dead code, i.e. bitmap_copy_le()
      spi: rspi: Get rid of unused struct rspi_plat_data
      spi: Introduce internal spi_xfer_is_dma_mapped() helper
      spi: omap2-mcspi: Use new spi_xfer_is_dma_mapped() helper

AngeloGioacchino Del Regno (1):
      clk: mediatek: reset: Remove unused mtk_register_reset_controller()

Aniket Randive (1):
      serial: qcom_geni: Disable closing_wait for console to prevent shutdown timeout

Anil Kaushik (2):
      gtp: set a valid genl command in PDP context get and dump replies
      gtp: hold RCU for the device lookup when adding a PDP context

Anthony Krowiak (1):
      s390/vfio-ap: fix KVM GISC and page leak when queue removed from host config

Antoni Pokusinski (3):
      rtc: abx80x: fix error check after i2c_smbus_read in read_alarm()
      rtc: abx80x: add mutex protection for register writes
      rtc: abx80x: properly handle shared IRQs

Antonio Borneo (1):
      pinctrl: stm32: Declare stm32_pmx_get_mode() as static

Antonio Quartulli (1):
      net/sched: fix packet reordering on requeue

Anuj Bolewar (2):
      drm/virtio: reclaim pending vbufs before tearing down vqs
      media: hackrf: fix use-after-free in hackrf_alloc_urbs() error path

Anumula Murali Mohan Reddy (1):
      RDMA/cxgb4: use dma_mmap_coherent() for mapping non-contiguous memory

Anup Vishwakarma (3):
      mailbox: qcom-ipcc: Guard against NULL con_priv in send_data()
      remoteproc: qcom_q6v5_adsp: Fix double jiffies conversion in adsp_start()
      mailbox: qcom-ipcc: remove stray disable_irq_wake() call

Anusha Srivatsa (2):
      drm/panel: Add new helpers for refcounted panel allocatons
      panel/ebbg-ft8719: Use refcounted allocation in place of devm_kzalloc()

Arash Golgol (1):
      regulator: fan53555: Add support for FAN53555BUC23X type

Ard Biesheuvel (3):
      arm64/efi: Clear PTE_WRITE when applying EFI_MEMORY_RO
      efi/libstub: Don't replace an existing LINUX_EFI_MEMRESERVE table
      efi/libstub: arm64: Don't use the platform register x18

Arka Mondal (6):
      usb-storage: alauda: do not do DMA from the stack
      usb-storage: alauda: check the return value of alauda_read_map()
      usb-storage: alauda: fix out-of-bounds zone index
      iio: dac: ad5758: Fix alignment for DMA safety
      iio: dac: ad5758: Reject out-of-range raw values
      iio: dac: ad5758: Fix the offset calculation

Armaan Sandhu (1):
      lib/cmdline: fix get_options() count and overflow with large ranges

Armin Wolf (1):
      hwmon: (acpi_power_meter) Fix 18.45 TW bug

Arnaldo Carvalho de Melo (11):
      perf jitdump: Fix extended header read that always fails
      perf jitdump: Fix debug_data and unwinding_data leaks
      perf jitdump: Validate code_size against total_size in code load
      perf jitdump: Prevent integer underflow in debug info size calculation
      perf jitdump: Bounds-check debug entry byte-swap loop
      perf jitdump: Check snprintf return before computing header size
      perf jitdump: Fix funlockfile on unlocked stream in jit_open() error path
      perf jitdump: Use dirname() return value in jit_open()
      perf jitdump: Validate debug entries on native (non-swap) path
      perf jitdump: Validate sym string NUL-termination in code load
      perf jitdump: Validate unwinding sizes against record payload

Arnd Bergmann (5):
      media: v4l2-tpg: reduce stack usage for kasan builds
      mtd: rawnand: ndfc: add CONFIG_OF dependency
      KMSAN: fix memset() when using fortify-source, again
      cpufreq: amd-pstate: remove global header file
      wifi: mt76: mt7996: fix mt7996_mcu_all_sta_info_event struct packing

Asad Kamal (2):
      drm/amd/pm: Validate OD DPM triples before mutating tables
      drm/amdgpu: Gate debugfs MMIO access on kernel lockdown

Atharva Vartak (1):
      net/smc: hold a reference on net_device returned by pnet_find_base_ndev()

Atul Akella (1):
      rpmsg: virtio: fix error handling in TX buffer wait

Aurabindo Pillai (1):
      drm/amd: Add DCN6 register headers

Aurelien Jarno (1):
      riscv: fix RVG_SYSTEM_CSR_MASK width mask

Avi Weiss (5):
      init/bootconfig: pass init arguments in documented order
      rpmsg: mtk: release channel OF node on device teardown
      signal: skip blocked signals in dequeue_synchronous_signal()
      profiling: fix sampling step on 64-bit big-endian systems
      nvmet: prevent double-free after metadata SGL allocation failure

Ayushman Rout (1):
      bpf: Use memmove() to load bytes from an skb and an xdp_buff

Azeem Shaikh (1):
      init/version.c: Replace strlcpy with strscpy

Babanpreet Singh (1):
      regulator: ab8500: Remove stale expand_register kernel-doc entry

Baek Kyu, Kim (3):
      hwmon: (sht3x) Return the consumed count for heater writes
      hwmon: (corsair-cpro) Cache fan target only after a successful command
      rtc: mpfs: Fix alarm register word order

Balakrishnan Sambath (11):
      media: microchip-isc: take a reference on the parsed endpoints
      media: microchip-isc: fix awb_mutex and lock lifecycle
      media: microchip-isc: synchronize the IRQ before disabling clocks on stop
      media: microchip-isc: disable histogram and flush AWB work on teardown
      media: microchip-isc: do not touch WB registers when not streaming
      media: microchip-isc: fix PM runtime leak in AWB work handler
      media: microchip-isc: don't sleep in the clk .is_enabled callback
      media: microchip-isc: store the unshifted PFE_CFG0 BPS value
      media: microchip-isc: fix WB offset and gain register field masking
      media: microchip-isc: fix ISC_PFG_CFG0_BPS macro name typo
      media: microchip-isc: fix SBGGR10 Bayer pattern

Baokun Li (2):
      ext4: reduce max cluster size to match documented 256MB limit
      blk-crypto: fix NULL deref and UAF in __blk_crypto_evict_key()

Baolin Liu (2):
      isofs: fix Rock Ridge CE extent validation on multisession media
      fs/ntfs3: update ctime only on successful setxattr

Baolin Wang (1):
      mm: vmscan: fix dirty folios throttling on cgroup v1 for MGLRU

Bard Liao (1):
      soundwire: dmi-quirks: add a global ghost list

Bart Van Assche (1):
      scsi: pm8001: Fix SATA FIS offset in struct hw_event_resp

Bartosz Golaszewski (1):
      dmaengine: qcom: bam_dma: free interrupt before the clock in error path

Bartosz Szpila (1):
      platform/chrome: cros_ec_typec: Validate SVID and mode counts in discovery data

Bartu Alev (1):
      platform/x86: asus-wmi: fix TUF keyboard power state shutdown naming

Basavaraj Natikar (2):
      HID: amd_sfh: Remove unsupported motion-state field from accelerometer report
      HID: amd_sfh: Use report type from request node

Beleswar Padhi (1):
      mailbox: ti-msgmgr: Read exact number of trailing message bytes

Ben Dooks (2):
      dmaengine: dw-axi-dmac: fix __le32 on set of CH_CTL_H_LLI_VALID
      mmc: cqhci: fix to missed endian conversions

Ben Hutchings (1):
      bootconfig: Fix negative seeks on 32-bit with LFS enabled

Benjamin Coddington (6):
      pNFS: Fix CB_NOTIFY_DEVICEID CHANGE to consume ndc_immediate
      NFSv4.1/pnfs: suspend pNFS on NFS4ERR_TOOSMALL from LAYOUTGET
      NFSv4/filelayout: Anchor page coalescing on pattern_offset
      NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before allocating
      NFSv4/flexfiles: fail I/O to the data server once a lock is lost
      NFSv4/pnfs: Free the netid when draining a data-server address list

Benjamin Lin (1):
      wifi: mt76: mt7996: switch to mcu command for TX GI report

Benjamin Marzinski (1):
      bitops: make the *_bit_le functions use unsigned long

Bert Karwatzki (1):
      mac80211: tx: Use info->flags in ieee80211_tx_h_select_key()

Bharath SM (1):
      smb: align durable reconnect v2 context to 8 byte boundary

Bihaan Sen (1):
      Input: xpad - add support for 8BitDo Pro 2 Wired Controller for Xbox

Biju Das (3):
      ASoC: codec: tlv320aic32x4: Add enum aic32x4_type to aic32x4_probe()
      ASoC: tlv320aic32x4-i2c: Simplify probe()
      ASoC: tlv320aic32x4-spi: Simplify probe()

Binbin Deng (5):
      apparmor: fix a use-after-free in aa_lookupn_ns()
      module: Fix uninitialized count read of unloaded taint tracking record
      octeontx2: Fix use-after-free of qos node in delete path
      tipc: fix use-after-free of broadcast reception link at node release
      net: atlantic: Unregister before clearing RXNFC rules

BingKun Yue (1):
      fbdev: platinumfb: add error checking for ioremap calls

Bjorn Andersson (1):
      power: supply: qcom_battmgr: report full batteries

Bob Pearson (2):
      RDMA/rxe: Make rxe_loopback match rxe_send behavior
      RDMA/rxe: Let destroy qp succeed with stuck packet

Bob Song (4):
      ALSA: hda: Check snd_hda_power_pm construct error before executing verb
      ALSA: hda/realtek: add missing NULL check for codec->bus->pci
      ALSA: hda/realtek: add missing error checks for COEF index reads in alc269
      ALSA: hda/conexant: Always enable the headset-mic pin on plugin

Boris Faure (1):
      soundwire: intel: initialise quirk_mask before reading it

Borislav Petkov (AMD) (2):
      x86/bugs: Mitigate TSA on AMD Zen5
      x86/microcode/AMD: Move the no-revision fixup to get_patch_level()

Brad Fitzpatrick (1):
      gre: keep the UDP tunnel GSO type when completing GRO

Bradley Morgan (1):
      PM: CPU: Restore synchronize_rcu() to cpu_pm_unregister_notifier()

Brandon Williams (1):
      power: supply: qcom_battmgr: Notify charger supplies of online changes

Breno Leitao (14):
      mm/kmemleak: report RCU-tasks quiescent states during the scan
      mm, swap: ratelimit bad swap entry reports
      mm/shmem: report RCU-tasks quiescent states while undoing a range
      net: free_netdev: exit earlier if dummy
      net: get stats64 if device if driver is configured
      vxlan: Remove generic .ndo_get_stats64
      x86/nmi: Ignore negative NMI handler durations
      ACPI: APEI: accumulate the queued flag across error sections
      dcache: report a Tasks-RCU quiescent state in dentry_kill()
      kexec_file: stop the top-down search before it underflows
      wifi: ath12k: allocate dummy net_device dynamically
      cpuidle: menu: Remove incorrect unlikely() annotation
      ACPICA: Fix memory leak in acpi_ds_create_field()
      mailbox: pcc: Free the channel before unmapping the shared memory

Brian Grech (1):
      selftests/net: fin_ack_lat: fix latency threshold typo

Brian Norris (1):
      PCI/portdrv: Allow probing even without child services

Bruno Produit (1):
      hfs/hfsplus: serialize B-tree close against folio release

Bryam Vargas (3):
      iio: accel: fxls8962af: clamp the device-reported FIFO sample count
      net/smc: queue the copied chunk when smc_tx_sendmsg() faults
      net/smc: don't spin in smc_rx_recvmsg() while a pipe holds spliced data

Bryan O'Donoghue (4):
      i2c: qcom-cci: Stop complaining about DT set clock rate
      phy: core: Fix race-condition between _of_phy_get() and try_module_get()
      media: qcom: camss: Move vfe_disable into a common routine where applicable
      media: qcom: camss: Propagate vfe_reset error up the callstack

Bui Viet Dung (5):
      wwan: wwan_hwsim: Pin module for debugfs file operations
      Bluetooth: hci_vhci: Pin module for debugfs file operations
      Bluetooth: 6lowpan: Pin module for 6lowpan_control debugfs file
      Bluetooth: hci_debugfs: Pin module for debugfs file operations
      Bluetooth: selftest: Pin module for selftest debugfs file operations

Cai Xinchen (1):
      lsm: don't call security_backing_file_free() multiple times

Can Peng (2):
      wifi: brcmfmac: Set DMA direction for msgbuf packet IDs
      wifi: brcmfmac: validate msgbuf flowring IDs before use

Cao Guanghui (2):
      md/raid5: track disks array size to fix extra_page leak on error paths
      md/raid5: fix NULL pointer dereference in raid5_free_percpu

Carl Quist (1):
      ALSA: hda/realtek: Enable mute LED on HP Laptop 15-dy0xxx

Carolina Jubran (2):
      IB/IPoIB: Cancel normal flush work on device stop
      net: skbuff: don't copy alloc_cpu in skb header copies

Casey Connolly (1):
      drm/panel: ebbg-ft8719: Set prepare_prev_first

Catalin Marinas (1):
      arm64: Use load LSE atomics for the non-return per-CPU atomic operations

Cen Zhang (41):
      ocfs2/dlm: drain join handlers before releasing module text
      ocfs2: drain quorum work before removing the cluster
      ocfs2: pin owning modules for open debugfs files
      ocfs2: publish the filecheck owner before adding sysfs attributes
      KEYS: encrypted: fix integer overflow of datablob_len
      ocfs2/heartbeat: unlink live slots when their node is missing
      ocfs2/dlm: hold a lock reference across grant AST enqueue
      ocfs2: cancel quota sync work before freeing quota info
      ocfs2: pin refcount trees before dropping the lookup lock
      ocfs2: snapshot dentry names in file and setattr traces
      ocfs2/cluster: initialize heartbeat regions before publishing them
      ocfs2: snapshot the dentry name while tracing file release
      ocfs2/cluster: remove zero-address nodes from IP tree on teardown
      ocfs2: keep locking_state within the cluster connection lifetime
      ocfs2/dlm: serialize migration MLE cleanup on failure
      ocfs2: stop recovery before shutting down local allocators
      ocfs2/cluster: unlink socket containers before releasing resources
      ocfs2: wait for filecheck kobject release after a failed add
      ocfs2: cache the mount context for dentry lock callbacks
      ocfs2: validate move extents against a stable EOF
      ALSA: jack: Remove debugfs before freeing unregistered jacks
      ALSA: rawmidi: Drain input work before freeing the runtime
      ALSA: vmaster: Serialize hook registration with control callbacks
      ALSA: pcm: Unlink substreams before releasing them
      Bluetooth: 6LoWPAN: Use RCU-safe device list removal
      Bluetooth: hci_core: Keep RCU protection through LTK filtering
      Bluetooth: hci_sync: Serialize devcoredump reset during device open
      Bluetooth: ISO: Hold the listener during disconnect notification
      Bluetooth: MGMT: Reject quality report requests during unregister
      Bluetooth: msft: Lock failed probe cleanup against feature readers
      Bluetooth: 6lowpan: Drain RCU readers on registration failure
      Bluetooth: hci_sync: Protect IRK identity reads with RCU
      Bluetooth: MSFT: Serialize handle map cleanup with event processing
      ALSA: vmaster: Protect follower lookup and setup
      ALSA: pcm: Protect the unregister notifier traversal
      ALSA: oss: Keep emulation modules loaded until object teardown
      ALSA: pcmtest: Pin the module while pattern files are open
      ALSA: pcm: Remove channel-map controls before freeing substreams
      ALSA: pcm: Protect channel-map reads against runtime detach
      ALSA: aloop: Keep the timer source alive until card release
      ocfs2: initialize status waiters before publishing them

Cen Zhang (Microsoft Security FORGE Labs) (1):
      nfsd: hold cl_lock in client_has_openowners()

Cen Zhang (Microsoft) (3):
      ksmbd: fix parent dentry lifetime in directory enumeration
      posix-cpu-timers: Fix pid refcount leak in do_cpu_nanosleep() signal path
      apparmor: fix query_data() output overlapping the lookup key

Cezary Rojewski (8):
      ALSA: hda: Upgrade stream-format infrastructure
      ASoC: Intel: avs: Switch to new stream-format interface
      ASoC: Intel: avs: Relocate HDA BE DAI specific operations
      ASoC: Intel: avs: Remove redundancy around DAI shutdown
      ASoC: Intel: avs: Store pointer to adev in DAI dma_data
      ASoC: Intel: avs: Store pointer to link_stream in dma_data
      ASoC: Intel: avs: Unprepare a stream when recovery occurs
      ASoC: Intel: avs: Prevent module info underflow

Chaitanya Kulkarni (1):
      nvmet: ignore discard return value

Chaithanya Lagisetty (3):
      dmaengine: dw-axi-dmac: convert clock handling to clk_bulk API
      dmaengine: sprd: use clk_bulk API to fix clock imbalance
      x86/svm: Avoid sign extension of SVM_EVTINJ_VALID in 64-bit expressions

Chandradhar Kumar (1):
      regulator: fixed: reject incompatible platform devices

Chandrakanth Patil (16):
      scsi: mpi3mr: Fix buffer overflow in BSG passthrough request copy
      scsi: mpi3mr: Fix out-of-bounds read when copying BSG MPI requests
      scsi: mpi3mr: Fix I/O block counter leak on admin request post failure
      scsi: mpi3mr: Fix target device reference leak in BSG task management
      scsi: mpi3mr: Fix buffer overflow when caching log data
      scsi: mpi3mr: Fix out-of-bounds reply frame access
      scsi: mpi3mr: Fix out-of-bounds sense buffer access
      scsi: mpi3mr: Fix out-of-bounds bitmap access during device removal
      scsi: mpi3mr: Fix target device reference leak in device removal handshake
      scsi: mpi3mr: Fix out-of-bounds read in SAS topology change events
      scsi: mpi3mr: Fix device loss during enclosure reboot due to zero link speed
      scsi: mpi3mr: Fix out-of-bounds read of event data
      scsi: mpi3mr: Fix out-of-bounds phy array access on link change
      scsi: mpi3mr: Fix buffer overflow in the BSG target device map
      scsi: mpi3mr: Fix out-of-bounds read in PCIe topology change events
      scsi: mpi3mr: Fix use-after-free of the firmware event workqueue

Chang S. Bae (1):
      x86/microcode/intel: Reject problematic loading on Granite Rapids systems

Chao Shi (1):
      nvme: ratelimit the completion-path messages driven by device data

Chao Yu (8):
      f2fs: compress: fix to handle race between truncate and writeback
      f2fs: fix to check continuousness in f2fs_sync_meta_pages() correctly
      f2fs: convert f2fs_mpage_readpages() to use folio
      f2fs: convert f2fs_read_single_page() to use folio
      f2fs: atomic: fix to forbid dio in atomic_file
      f2fs: fix to use bio_in_atomic() in f2fs_read_end_io()
      f2fs: fix to update superblock crc in sanity_check_area_boundary()
      f2fs: fix to fetch ino via ino_of_node() under cache lock

Charles Keepax (3):
      soundwire: dmi-quirks: Disable ghost Realtek on Asus Expertbook
      soundwire: dmi-quirks: Disable ghost Realtek on Asus Zenbook Duo
      soundwire: dmi-quirks: Disable ghost Realtek on Asus ROG Zephyrus Duo

Cheick Traore (1):
      iio: adc: stm32: fix minimum sampling time values

Chen Changcheng (3):
      media: cx88: fix memory leak in cx8802_register_driver() error path
      Bluetooth: btrsi: Move set_bt_context after successful HCI registration
      scsi: snic: Fix SCSI host leak on workqueue allocation failure

Chen Wang (1):
      dt-bindings: vendor-prefixes: add milkv/sophgo

Chen-Yu Tsai (7):
      pwm: mtk-disp: Fix period readback
      regulator: Unify "negative error number" terminology in comments
      arm64: dts: mediatek: mt8173: Fix MFG_ASYNC power domain clock
      drm/exynos/fimd: fix register offset type in fimd_trigger()
      dt-bindings: media: sun4i-a10-video-engine: Fix IOMMU count for H6
      arm64: dts: allwinner: sun50i-h6: Add missing SRAM region for video engine
      arm64: dts: allwinner: sun50i-h6: Add missing IOMMU for video engine

ChenXiaoSong (6):
      smb/server: cancel async requests when closing connection
      smb: move SMB2 Status code to common header file
      smb: move create_durable_req_v2 to common/smb2pdu.h
      smb: move create_durable_handle_reconnect_v2 to common/smb2pdu.h
      smb: move create_durable_rsp_v2 to common/smb2pdu.h
      smb/server: fix trailing period in generated short names

Cheng Xu (1):
      RDMA/erdma: Use IRQ-safe XArray helpers for QP and CQ tables

Cheng Yongkang (2):
      io_uring/timeout: count cancelled timeouts in cq_timeouts
      net: tun: hold napi_mutex when deleting NAPI in tun_detach_all()

Chengfeng Ye (4):
      xfrm: retry inexact policy lookup after node reinsertion
      batman-adv: Close OGM aggregation before transmission
      mm/ksm: mark migration stores with WRITE_ONCE()
      l2tp: snapshot sequencing state when building transmit headers

Chengjun Yao (1):
      drm/amdgpu: fix rmmio iounmap skipped on device removal

Chien Wong (2):
      wifi: mac80211: fix encryption tailroom
      wifi: mac80211: reserve MME tailroom for protected beacons

Chris Down (1):
      mm: make swapoff interruptible when unusing mms/shmem

Chris Lew (1):
      rpmsg: char: Check for ongoing chrdev destroy

Chris Mason (33):
      ovl: do not copy up an xattr value that was never read
      ovl: fix a torn path in ovl_get_redirect()
      ovl: read the nlink xattr of every indexed non-dir
      ovl: set the revalidate flags after d_instantiate()
      sunrpc: pin gss module across auth_domain RCU free
      ovl: take a snapshot of the name for copy up
      ovl: use the pinned upper dir in ovl_fix_origin()
      ovl: set OVL_WHITEOUTS before publishing the upper dir
      io_uring/rsrc: charge buffer arrays and nodes to memcg
      io_uring: charge tctx nodes and personalities
      io_uring: free XArray nodes left by a failed store
      io_uring/sqpoll: don't wait for the thread to exit
      ovl: check that the parents of volatile/dirty are dirs
      ovl: hold a reference on the parent in readdir
      ovl: do not copy up a dentry that was removed
      aio: fix NULL deref when a fault races ring truncation
      backing-file: always end a queued write
      io_uring/cancel: drop sqd->lock while SQPOLL waits
      mm/mempolicy: charge shared policy nodes
      mm/shmem: stop retrying folios that cannot be split
      mm/shmem: preserve data in clean folios when splitting fails
      mm/gup: fix out-of-bounds write for nr_pages == 0 in GUP-fast
      mm/mmu_notifier: set ->mm only after mmgrab()
      mm/shmem: honour F_SEAL_EXEC when an ACL is set
      ovl: look up the index by the decoded origin
      mm/huge_memory: fix truncate racing with PMD zapping
      mm/memory: reject remote COW faults on PFN mappings
      nvmet-rdma: flush nvmet-wq on module exit
      nvmet-rdma: disable interrupts under rsp_wr_wait_lock
      nvmet-rdma: fix double puts after a failed RDMA WRITE
      nvmet: don't clear sq->ctrl for a Connect with sqsize 0
      rnbd-srv: fix use-after-free on two CLOSE messages
      rnbd-srv: publish the sess_dev at the end of OPEN

Chris Simpson (1):
      ALSA: hda/realtek: Enable bass speakers on Alienware m17 R3

Christian Borntraeger (1):
      s390/vmcp: Initialize full session info to zero

Christian Brauner (10):
      exec: cancel io_uring requests before de_thread()
      fork: move the coredump and exec checks into create_io_thread()
      fork: don't create io threads once PF_POSTCOREDUMP is set
      fs/ntfs3: use d_instantiate_new() in ntfs_create_inode() and murder syzbot's "WARNING in do_new_mount" saga
      namespace: check a recursive bind mount for mount namespace loops
      namespace: never expire a locked mount
      ipc: drop the mqueue mount with kern_unmount() on setup failure
      ntfs3: free replaced mount options after a grace period
      iomap: don't mark unwritten parts of a folio uptodate
      proc: don't let an entry below /proc/<pid>/net be a mountpoint

Christian Gmeiner (1):
      drm/etnaviv: Flush the tile status cache through both the PE and BLT

Christian Loehle (5):
      ACPI: CPPC: Validate FFH register fields before hardware access
      ACPI: CPPC: Propagate errors from cross-CPU FFH calls
      ACPI: CPPC: Accept requests to retain immutable autonomous selection
      cpuidle: menu: Remove single state handling
      ACPI: CPPC: Validate the _CPC package header

Christian Marangi (1):
      i2c: mt7621: fix copying uninitialized kernel stack with reduced page_len

Christoph Hellwig (1):
      xfs: fix recovery of partial attr removals

Christophe JAILLET (2):
      ocfs2: constify struct ocfs2_lock_res_ops
      hwrng: virtio - Remove usage of the deprecated ida_simple_xx() API

Christopher Lusk (1):
      m68k: Fix seccomp filtering on ColdFire and 68000

Chuanhong Guo (1):
      pinctrl: mediatek: mt7629: fix the 2.4 GHz Wi-Fi pin mode array

Chuck Lever (24):
      svcrdma: Clear sc_cm_id when ADDR_CHANGE replacement fails
      lockd: Fix use-after-free in nlmsvc_retry_blocked
      pnfs/blocklayout: Complete a device upcall only on its own reply
      pnfs/blocklayout: Complete a device upcall when the pipe is closed
      NFSD: Do not send CB_RECALL_ANY to NFSv4.0 clients
      NFSD: Don't complete a cld upcall the daemon has not read
      NFSD: Fail a pool_threads read whose reply does not fit
      NFSD: Reject an oversized principal hash from nfsdcld
      NFSD: Resolve the recall-any mask names in the trace format
      SUNRPC: Copy the deferred RPC Call from the head buffer
      SUNRPC: Do not credit control-record octets to the RPC stream
      SUNRPC: Reject a socket that already has an svc_sock attached
      SUNRPC: Reject a TLS alert record that is not two octets
      SUNRPC: Resume receiving after a TLS control record
      SUNRPC: Treat every TLS error alert as fatal
      svcrdma: Grant credits from the clamped sc_max_requests
      exportfs: Release the get_name() directory file synchronously
      NFSD: Move the cld upcall message out of the caller's stack frame
      NFSD: Complete a cld upcall when the daemon closes the pipe
      NFSD: Complete a cld upcall when copying its reply fails
      NFSD: Map flex file layout IDs through the request's user namespace
      NFS: use TCP for MOUNT when xprtsec= selects TLS
      SUNRPC: reject a client-side TLS alert record that is not two octets
      SUNRPC: treat every client-side TLS error alert as fatal

ChunYuZhiQiang (1):
      can: dev: can_fill_info(): don't wake up controller if interface is down

Claudiu Beznea (1):
      phy: renesas: rcar-gen3-usb2: Avoid long delay in atomic context

Cong Nguyen (3):
      media: microchip-csi2dc: fix async notifier leak on probe error path
      staging: media: imx: csc-scaler: fix ipu_image_convert_run leak on queue error
      leds: lm3692x: Fix regulator/gpio leak and wrong enabled state on last write failure

Cong Zhang (1):
      virtio_blk: use synchronous quiesce in virtblk_freeze_priv()

Cristian Papa (2):
      wifi: mt76: mt7603: don't drop short frames looped back on PS entry
      wifi: mt76: feed the station RSSI average from the chain signals

Cryolitia PukNgae (1):
      ALSA: usb-audio: rename QUIRK_FLAG_MIXER_MIN_MUTE to QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE

Cunhao Lu (1):
      can: dev: can_put_echo_skb(): free skb on invalid echo index

DAI RENJIE (1):
      resource: fix lost wakeup when waiting for a muxed region

Daan De Meyer (1):
      io_uring/net: don't retry a non-blocking connect() that fails with -EAGAIN

Daasaradhi Mannava (1):
      platform/x86: msi-ec: Report valid charge thresholds when unset

DaeMyung Kang (5):
      ksmbd: avoid restoring only in-memory EOF after allocation change
      ksmbd: preserve unreadable named streams on open
      ksmbd: return end of file for reads past a named stream's data
      ksmbd: use the existing xattr name for a named stream
      ksmbd: fix named stream write and EOF handling

Daeho Jeong (5):
      f2fs: avoid setting SBI_NEED_FSCK on transient resize failure
      f2fs: don't use truncate_inode_pages_final() on live inodes
      f2fs: return -EIO for a lost inode block after cp_error
      f2fs: disallow mmap write and data-modifying fallocate on atomic files
      f2fs: release a removed xattr node in roll-forward recovery

Daehyeon Ko (10):
      vsock/vmci: validate packet source for connected sockets
      aio: prevent eventfd/epoll recursion on poll
      ipc/mqueue: release notification resources during inode eviction
      ipv6: remove ifaddr from hash during ifdown list cleanup
      ipv6: serialize address publication with device teardown
      ipv6: initialize temporary ifaddr before publication
      ipv6: do not restart DAD for a dead ifaddr
      splice: avoid stale f_pos writeback on error
      crypto: algif_skcipher - rewind rounded output bytes
      vhost/vsock: size receive SKBs from declared payload

Daejun Park (9):
      ext4: don't report delalloc data as a hole on indirect-mapped inodes
      jbd2: don't advance j_fc_off before the buffer is recorded
      xfs: mark the inode preallocated for pNFS write layouts past EOF
      xfs: clamp a pNFS LAYOUTCOMMIT extent before computing its end
      xfs: cap the block count of xfs_iomap_write_direct() at one extent
      xfs: clamp the pNFS layout range to the maximum file size
      xfs: don't skip free extents of the longest length in a whole-AG FITRIM
      nvme: unregister when pr_register() is given a zero new key
      xfs: add a flag to convert unwritten extents without allocating blocks

Dairui Zhang (3):
      ksmbd: fix OOB read and cross-share confusion in ksmbd_validate_name_reconnect()
      ksmbd: verify transform SessionId matches the decrypted header
      IB/mad: fix UAF and double-free in RMPP receive reassembly

Damien Le Moal (1):
      block: Allow using bio_attempt_back_merge() internally

Damon Ding (2):
      drm/panel-edp: Add BOE NE160QDM-NY1 panel
      drm/bridge: analogix_dp: Restore mandatory samsung DP DT properties

Dan Carpenter (4):
      wifi: b43: don't pass unterminated string to sscanf()
      wifi: b43legacy: debugfs: NUL terminate string in debugfs
      wifi: carl9170: NUL terminate string in debugfs
      mm/hmm/test: reject overflowing page counts

Daniel Borkmann (1):
      bpf, lsm: Reject writes into the BPF LSM program context

Daniel Golle (2):
      net: dsa: mt7530: error out on failed PHY_IAC command writes
      net: pcs: mtk-lynxi: check regmap reads in mtk_pcs_lynxi_get_state()

Daniel Machon (5):
      net: sparx5/lan969x: do not clobber the PSFP cycle timer update period
      net: sparx5/lan969x: do not read past skb->len when injecting a frame
      net: lan966x: do not inject uninitialised bytes past skb->len
      net: lan966x: do not warn on MAC entries that are not port destined
      net: lan966x: release the in-flight slot of a stale TX skb

Daniel Ortiz (1):
      ASoC: amd: yc: Add DMI quirk for Lenovo V15 G6 ARP

Daniel Palmer (2):
      m68k: Fix task info flags handling for 68000
      m68k: apollo: Fix interrupt setup

Daniel Phillips (1):
      amdkfd: Fix memory availability double accounting of kfd pinned objects

Daniel Wagner (3):
      nvme-fabrics: reset io_queues before computing the queue mapping
      nvme-fabrics: limit each queue type to the number of online CPUs
      nvme-fabrics: clear the poll map if no poll queues are mapped

Danielle Ratson (1):
      bridge: Add internal flags for neigh_forward_grat

Danila Chernetsov (1):
      dlm: validate lock modes in recovery messages

Danish Khateeb (4):
      perf/core: Don't send SIGTRAP after exec removed the event
      tools/nolibc: fix WIFSIGNALED() for status 0
      tools/nolibc: stop rounding malloc() sizes up to 4096 bytes
      tools/nolibc: check for overflow in malloc()

Dapeng Mi (3):
      perf/x86/intel: Fallback to sw branch type decoding if no hw decoding
      perf/x86: Unregister PMI handler on PMU init failure
      perf/x86: Free hybrid state on PMU init failure

Darong Lu (1):
      libceph: initialize CRUSH choose argument weights

Darrick J. Wong (23):
      xfs: fix backwards mergeability logic in refcount scrubber
      xfs: strengthen the "is cow staging" helpers in scrub
      xfs: don't cross reference rmapbt with bitmaps if they're incomplete
      xfs: fix unnecessary dapos truncation in xchk_dir_walk
      xfs: assign an owner to scrub_stats_fops
      xfs: check fork type against dabtree block magic number
      xfs: mark overfull dabtree node blocks as corrupt
      xfs: jump out of xchk_bmap_check_rmap if fatal signals
      xfs: fix xchk_stats_estimate_bufsize to allow for the trailing null
      xfs: check for fragments when full-extent sharing matches
      xfs: don't rescan ifree and icount when frozen
      xfs: only written file data blocks can be shared
      xfs: opportunistically skip btree block checks
      xfs: propagate errors while checking null siblings
      xfs: range-check bc_levels array access in scrub tracepoints
      xfs: fix buffer overruns in xfs_ioc_attr_list
      xfs: check for buffer overruns when examining local/remote xattr entries
      xfs: improve dirent bounds checking in scrub and repair
      xfs: allow softlimit with no hardlimit in quota scrub
      xfs: fix buffer overflow in corrupt inline attr structure
      xfs: rescan the AGs if incore delalloc counter is negative
      xfs: reject absurdly large xattr value lengths in xchk_xattr_actor
      xfs: always report scrub errors in tracepoints

Dave Carey (1):
      HID: multitouch: Fix stale MT slots when contact count drops to zero

Dave Jiang (14):
      efi/cper: Reject CPER records with an out-of-range error_data_length
      efi/cper: Reject an error status block length that wraps a u32
      ACPI: extlog: Validate elog record length before walking sections
      efi/cper: Read only validated fields in cper_mem_err_pack()
      perf/cxl: Program the requested event group on configurable counters
      perf/cxl: Clear stale event fields before reprogramming a counter
      perf/cxl: Fix the counter overflow delta fixup
      perf/cxl: Accept an overflow interrupt on MSI message number 0
      cxl/pci: Add the PMUs after configuring events
      perf/cxl: Don't share the overflow interrupt, and keep it pinned
      perf/cxl: Unfreeze counters after handling an overflow interrupt
      perf/cxl: Validate the hardware-reported counter width
      perf/cxl: Don't log through pmu.dev in the overflow interrupt handler
      perf/cxl: Clear stale overflow status before using a counter

David Bauer (2):
      wifi: mt76: mt7603: free beacon SKB on error
      wifi: mt76: mt7915: configure noise floor reporting on reset

David C.C.M. Gall (3):
      crypto: keembay - use crypto_memneq() to compare GCM AEAD tags
      crypto: sa2ul - use crypto_memneq() to compare AEAD tag
      crypto: keembay - use crypto_memneq() to compare CCM AEAD tags

David Cemin (1):
      ASoC: sdw_utils: clear stale RT711 device reference on exit

David Francis (2):
      drm/amdkfd: Avoid integer underflow with ffs in EOP ring size calc
      drm/amdkfd: Avoid integer underflow in EOP ring size calculation.

David Heidelberg (10):
      soc: qcom: socinfo: Add SoC ID for SDM850
      dt-bindings: arm: qcom,ids: Add SoC ID for Snapdragon SDM 850
      backlight: qcom-wled: Fix NULL pointer dereference in wled_remove()
      backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe
      backlight: qcom-wled: Fix WLED3 brightness register stride
      mfd: wcd934x: set DMA mask on parent to silence "DMA mask not set"
      mfd: wcd934x: Fix NULL pointer dereference on IRQ probe deferral
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Extend the xbl_mem region
      arm64: dts: qcom: sdm845-xiaomi-polaris: Extend the xbl_mem region
      ASoC: wcd-mbhc-v2: Fix incorrect properties names and typos

David Hildenbrand (Arm) (21):
      mm/gup: fix always draining LRU caches in collect_longterm_unpinnable_folios()
      mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()
      mm/shmem: discard whole new large folios on fallocate rollback
      mm/shmem: fix truncation of files containing only swapin-error markers
      mm/gup: check for overflow when converting nr_pages to bytes in GUP-fast
      mm/ksm: reset the unstable trees of all nodes
      mm/madvise: fix data loss from MADV_FREE on a KSM page
      mm: disallow ioremap'ing ordinary RAM in generic_access_phys()
      mm/ksm: fix use of a freed anon_vma at swap-in
      mm/userfaultfd: write-lock the VMA before waking waiters when unregistering
      mm/userfaultfd: wake waiters when registration modes are removed
      mm/memory-tiers: unregister empty tiers outside memory_tier_lock
      mm/mremap: recheck PUDs under the page table lock
      mm/hugetlb: disable PMD sharing for UFFD missing mode
      mm/vma: don't leak the charge for stack growth
      mm/mremap: use pudp_huge_get_and_clear() when moving huge PUDs
      mm/rmap: handle device-exclusive entries in folio_referenced_one()
      fork: take mmap_lock before copying mm_struct
      mm/filemap: finish fault cleanup before dropping the fault lock
      mm/shmem: make shmem_file() check the file's inode
      mm/shmem: fix accounting of swapin-error markers

David Howells (5):
      rxrpc: Fix double IRQ enablement
      rxrpc: Fix update of call->tx_pending without holding lock
      afs: Fix afs to abort the rxrpc call on send error
      rxrpc: Fix return in rxrpc_recvmsg_data() for service calls
      rxrpc: Revert "rxrpc: rxperf: Fix missing decoding of terminal magic cookie"

David Laight (1):
      usb_string_copy: Use kzalloc() to avoid leaking old data

David Lee (1):
      sctp: hold shkey across socket migration

David Woodhouse (2):
      KVM: x86/xen: Take kvm->srcu in __kvm_xen_has_interrupt()
      tun: Require CAP_NET_ADMIN to attach to an ownerless device

David Yang (1):
      net: hisilicon: hisi_femac: Stop the receiver before releasing the RX ring

Dawei Li (1):
      irqchip/gic(v3): Replace gic_irq() with irqd_to_hwirq()

Deepanshu Kartikey (2):
      udf: avoid recursive s_alloc_mutex deadlock when freeing AED blocks
      media: imon: fix use-after-free in display_close via dev_dbg

Denis Arefev (1):
      ALSA: cs46xx: fix unit mismatch in DSP code area bounds check

Denis Batishchev (1):
      ALSA: hda/realtek: Enable micmute LED on HP EliteBook 6 G1a p/n: AD3Q9ET#UUG

Denis Efremov (Oracle) (2):
      floppy: don't store a stack buffer in timeout_message
      floppy: return the drive state flags from the 32-bit FDGETDRVSTAT

Denis V. Lunev (1):
      virtio_balloon: warn on failed buffer add in tell_host()

Deren Wu (1):
      wifi: mt76: connac: add more unified event IDs

Detlev Casanova (2):
      arm64: dts: rockchip: Rename rk3328 HDMI audio card
      arm64: dts: rockchip: Rename rk3566 and rk3568 HDMI audio cards

Dev Jain (4):
      mm/rmap: use huge_ptep_get() in try_to_unmap_one()
      mm/rmap: use huge_ptep_get() in try_to_migrate_one()
      mm/migrate: use huge_ptep_get() in remove_migration_pte()
      mm/page_vma_mapped: use huge_ptep_get() for hugetlb

Devansh Soni (1):
      staging: rtl8723bs: fix missing unregister_netdev on sdio_alloc_irq failure

Devin Wittmayer (6):
      wifi: mt76: mt76x02: report rx FCS errors to mac80211
      wifi: mac80211: refuse to make a monitor active when it has no queue
      wifi: mt76: move the channel survey when the channel changes
      wifi: mt76: mt7921: fix lock inversion between dev->mutex and iflist_mtx
      wifi: mt76: mt7921: check drv_pmctrl return in the PCIe reset path
      wifi: mt76: mt7921: fix the lock inversion in suspend and resume

Dibin Moolakadan Subrahmanian (1):
      drm/i915/dmc: Add sanity check for DMC load address

Diego Fernando Mancera Gomez (1):
      usb: image: microtek: stop SG processing after transfer errors

Diego Oliva (5):
      smb: client: fix use-after-free infoleak via the readdir resume name
      smb: client: fix OOB last_entry pointer from unbounded LastNameOffset
      smb: client: fix OOB read of the resume name sent in TRANS2_FIND_NEXT2
      smb: client: reject FIND data areas that run past the received response
      smb: client: fix OOB read in the SMB_FIND_FILE_UNIX name scan

Dinh Nguyen (1):
      EDAC/altera: Use parent device for devres in altr_portb_setup()

Dmitrii Tulnov (1):
      kconfig: warn about malformed KCONFIG_PROBABILITY values

Dmitry Antipov (2):
      HID: roccat: fix locking in roccat_connect() and roccat_disconnect()
      leds: flash: Prevent using uninitialized variable in flash_fault_show()

Dmitry Baryshkov (7):
      ARM: dts: qcom: msm8974: add MDSS reset
      drm/msm/mdp5: drop cursor pipe for msm8x76
      drm/msm/dpu: extract bandwidth aggregation function
      drm/msm/dpu: change ib values to u32
      drm/msm/dpu: make fix_core_ab_vote consistent with fix_core_ib_vote
      drm/msm/dpu: drop core_clk_rate overrides from _dpu_core_perf_calc_crtc
      drm/msm/dpu: handle perf mode in _dpu_core_perf_crtc_update_bus()

Dmitry Osipenko (1):
      clk: tegra: support 48MHz clock for pll_p_out1

Dmitry Torokhov (9):
      mfd: ipaq-micro: Fix out-of-bounds stack read in ipaq_micro_str
      Input: matrix_keypad - avoid repeatedly converting GPIO to IRQ
      Input: matrix_keypad - consolidate handling of clustered interrupt
      Input: matrix_keypad - switch to using managed resources
      Input: matrix_keypad - remove support for clustered interrupt
      gpio: crystalcove: add missing MODULE_ALIAS()
      ASoC: tlv320aic32x4: move regmap_config into i2c and spi drivers
      ASoC: tlv320aic32x4: clean up driver code formatting and logging
      Input: matrix_keypad - propagate error code from matrix_keypad_build_keymap()

Dmytro Moroziuk (1):
      ALSA: hda/conexant: Add mute LED quirk for HP ProBook 440 G5

Dominic White (1):
      wifi: cfg80211: allow zero HE OBSS PD offsets

Dominik Maier (3):
      smb: client: fix slab-out-of-bounds write in id_mode_to_cifs_acl()
      loop: check for read-write open mode on LOOP_SET_STATUS in lo_compat_ioctl()
      xattr: always invoke cap_convert_nscap() for security.capability writes

Dominique Martinet (1):
      libbpf: fix cross-endian build with newer libbpf

Donggeun Yoo (8):
      swiotlb: use the adjusted address for the highmem page lookup
      tracing: Fix NULL dereference when copying keys for a field variable
      mm/damon/core: charge only the part of a region the filter left
      tracing: Add the bucket size to expr_field_str()
      tracing: Print the bucket size as unsigned
      tracing: Only report the stacktrace modifier on a real field
      tracing: Clamp the printed end of a histogram bucket at U64_MAX
      tracing: Print a signed histogram key as signed

Doug Berger (4):
      net: bcmgenet: remove dma_ctrl argument
      net: bcmgenet: consolidate dma initialization
      net: bcmgenet: introduce bcmgenet_[r|t]dma_disable
      net: bcmgenet: revise suspend/resume

Dr. David Alan Gilbert (1):
      rpmsg: virtio: Remove uncallable offchannel functions

Dragan Simic (5):
      arm64: dts: rockchip: Add cache information to the SoC dtsi for RK356x
      arm64: dts: rockchip: Add GPU OPP voltage ranges to RK356x SoC dtsi
      arm64: dts: rockchip: Update GPU OPP voltages in RK356x SoC dtsi
      arm64: dts: rockchip: Update CPU OPP voltages in RK356x SoC dtsi
      arm64: dts: rockchip: Prepare RK356x SoC dtsi files for per-variant OPPs

Drobyshev Vladimir (1):
      USB: cdc-acm: add VeriFone VX820 device ID

Dudu Lu (4):
      net/sched: etf: initialise the sock_exterr_skb before filling it
      net/sched: gred: keep the qdisc lock while updating the table
      net/sched: taprio: unwind the netdevice notifier if register_qdisc() fails
      net: xps: bound the cleanup loop by the old map's num_tc

EJ Campbell (1):
      x86/kvm: Don't consume async #PF flags on a kernel #PF in NMI context

Eason Lai (2):
      wifi: mt76: mt792x: fix UAF in SDIO TX path when out of memory
      wifi: mt76: fix memory leak in USB TX path

Eckhart Mohr (4):
      ALSA: hda/realtek: Add quirk for ASRock NUC BOX-358H
      ALSA: hda/realtek: Add quirk for TongFang X6xx45xU
      ALSA: hda/realtek: Add quirk for TongFang X6SP45xU
      ALSA: hda/realtek: Add quirk for TongFang XxAF5xxx

Eduard Zateev (1):
      smb: client: hold server info until cifsd exits

Edward Adam Davis (2):
      ocfs2: fix oob in __ocfs2_find_path
      kernel/reboot: avoid potential deadlocks during suspension

Eklavya Singh (1):
      ocfs2/heartbeat: serialize concurrent writes to a region's dev attribute

Emmanuel Grumbach (2):
      wifi: iwlwifi: mvm: reset the smart fifo state upon FW stop
      wifi: iwlwifi: mvm: ignore sync frames when sync is disabled

Erhan Bilgili (1):
      drm/amdgpu: Fix duplicate dependency fence releases

Eric Anderson (1):
      mfd: rk8xx: Register poweroff handler in atomic phase

Eric Biggers (6):
      fsverity: Be more careful with return value of ->get_verity_descriptor()
      fsverity: Explicitly require FMODE_READ to retrieve hashes
      xor: add missing vzeroupper to AVX code
      raid6: add missing vzeroupper to AVX-512 code
      raid6: add missing vzeroupper to AVX2 code
      lib/crypto: mips: Disable Octeon SHA code on little-endian kernels

Eric Dumazet (23):
      vlan: restore HW VLAN tag insertion with reorder_hdr off
      dlm: fix send buffer backpressure handling
      ixgbe: reserve TX timestamp after skb preparation
      ipmr: prevent info-leak in pmr_cache_report()
      inet: frags: limit the truesize of a reassembly queue
      inet: frags: bound the wmem charge of the socket completing a reassembly
      sit: fix UAF in ipip6_tunnel_del_prl()
      ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup
      ipv4: fix IP ID reuse in ip_select_ident_segs()
      inet: implement lockless IP_MULTICAST_TTL
      inet: implement lockless IP_MTU_DISCOVER
      ipv4: reserve one IP ID per segment for UDP GSO packets
      tcp: tcp_metrics: use the socket netns, not the dst device netns
      ipv6: account route exceptions to the netns of their dst
      net: shrink the payload-only part of skb dataref to one bit
      net: fix frag_list leak in skb_segment_list() error path
      ipmr: clear skb->cb[] in reg_vif_xmit()
      bridge: add bridge_flags_bit enum
      net: bridge: use atomic ops to read/change p->flags (III)
      net: add eth_type_trans_careful()
      loopback: use eth_type_trans_careful()
      net: use eth_type_trans_careful() in __dev_forward_skb2()
      openvswitch: use eth_type_trans_careful() in internal_dev_recv()

Eric Huang (1):
      drm/amdkfd: add sanity check in svm_range_is_valid

Eric Joyner (1):
      ionic: free port_info when probe fails after the port is set up

Eric Kim (1):
      sched/fair: Reset NUMA fault locality after scan period update

Eric Woudstra (1):
      bridge: No DEV_PATH_BR_VLAN_UNTAG_HW for dsa foreign

Esben Haabendal (5):
      drm/bridge: nwl-dsi: Cleanup endpoint mux control selection
      drm/bridge: nwl-dsi: Limit LCDIF specific sync override
      iio: light: ltr501: Power down chip if request irq fails
      dt-bindings: iio: light: ltr501: Sort compatible enum array
      dt-bindings: iio: light: ltr501: Add missing ltr303 compatible

Esteban Urrutia (1):
      clk: qcom: dispcc-sm8450: Fix disp_cc_mdss_mdp_clk_src ops

Ethan Nelson-Moore (1):
      ata: sata_inic162x: remove dangerous broken driver

Ethan Tidmore (1):
      staging: rtl8723bs: remove unused private debug counters

Eva Kurchatova (1):
      hugetlbfs: enforce F_SEAL_EXEC in setattr

Evanshenf (3):
      drm/loongson: Fix framebuffer selection in async cursor updates
      drm/loongson: Fix double free on BO initialization failure
      drm/loongson: Handle buffer mapping failures when clearing a BO

Ewan D. Milne (1):
      nvmet: don't return memory contents beyond valid data when reading ANA log page

Fabio Cesari (1):
      iio: light: isl29028: fix runtime PM reference leak on error paths

Fabrice Derepas (2):
      crypto: asymmetric_keys - fix OOB read in pefile_parse_binary
      ima: reject a kexec buffer whose declared size exceeds the buffer

Fan Wu (9):
      media: au0828: fix use-after-free in bulk_timeout timer on disconnect
      media: imx-jpeg: cancel timeout worker when streaming stops
      media: s5p-mfc: use timer_shutdown_sync() for the self-rearming watchdog
      scsi: dc395x: sync the waiting_timer before freeing the host
      media: imx-jpeg: finish the job on device_run() error paths
      media: mediatek: vpu: free IRQ before destroying watchdog workqueue
      media: rockchip: rga: quiesce IRQ before releasing m2m state
      power: supply: bq27xxx: Ensure poll work is cancelled on remove
      virtio_fs: read the vring size under virtio_fs_mutex in ->get_tree

Fang Xieyan (6):
      kcov: ignore an out-of-range comparison count in write_comp_data()
      kgdb: Fix buffer overflow in the 'm' packet handler
      kgdb: Fix buffer overflow in the 'M' and 'X' packet handlers
      kgdb: Fix buffer overflow in the qRcmd packet handler
      vringh: bound top-level re-entry into indirect tables
      vringh: reject empty / undersized indirect descriptor tables

Farhan Ali (1):
      PCI: Avoid saving config space state if inaccessible

Federico Musto (1):
      net: atl1c: drop oversized RX frames instead of panicking

Federico Valentín Andrade (1):
      ALSA: usb-audio: Skip mixer creation on M-Audio Venom

Fei Shao (1):
      clk: mediatek: reset: Return regmap's error code

Felix Fietkau (10):
      wifi: mt76: mt7615: fix NULL deref in mt7615_mac_set_rates
      wifi: mt76: set the EOSP bit in the QoS header of the last released frame
      wifi: mt76: mt7603: fix U-APSD service period termination
      wifi: mt76: mt7603: file buffered frames under the TID reported to mac80211
      wifi: mt76: mt7915: check default EEPROM firmware size before copying
      wifi: mt76: mt7996: validate firmware event lengths before parsing
      wifi: mt76: mt7915: unregister thermal cooling device on hwmon failure
      wifi: mt76: mt7915: guard firmware memory dump write on disabled memdump
      wifi: mt76: mt7996: fix PLE free page and AC queue register offsets
      wifi: mac80211: use link address as TA for non-MLO 4-addr station on MLD AP

Felix Gu (4):
      spi: omap2-mcspi: Remove unbalanced pm_runtime_put_sync() calls
      spi: mtk-nor: fix runtime PM usage count leak in probe error path
      PCI: dra7xx: Fix clock enable leak on probe failure
      spi: mxic: fix ps_clk leak in runtime resume

Felix Hoffmann (1):
      libceph: reject mismatched CRUSH weight-set sizes

Feng Tang (1):
      selftests: net: reuseport_bpf_numa: consider cpuless numa node

Feng Yang (2):
      bpf: Propagate btf_add_type() errors in btf_check_all_metas()
      bpf: Fix out-of-bounds btf->types write for split BTF

Fernando Fernandez Mancera (5):
      netfilter: tproxy: use DEBUG_NET_WARN_ON_ONCE for protocol fallbacks
      netfilter: synproxy: fix reset of ct seqadj when reopening a connection
      net: openvswitch: skip IPv4 later fragments on TCP/UDP set actions
      net: openvswitch: drop IP fragments on SCTP set action
      devlink: region: fix snapshot id leak on kernel-allocated ids

Filipe Manana (6):
      btrfs: fix memory barrier order in reloc_root_is_dead()
      btrfs: fix off by one super block end offset calculation when writing super blocks
      btrfs: fix dangling nodes in tree-mod-log after error in btrfs_tree_mod_log_insert_root()
      btrfs: fix incomplete iteration over fs state when logging messages
      btrfs: qgroup: fix swapped blocks existence check when tracing after COW
      btrfs: defrag: fix check to see if next extent can be defragged too

Finn Thain (18):
      swim: Assert strobe with stable outputs
      swim: Select appropriate drive once only
      swim: Enable the drive when probing
      swim: Don't disable drive after every sector
      swim: Perform ISM/IWM mode switching according to specs
      swim: Configure parameter memory
      swim: Don't start motor until medium is present
      swim: Recalibrate when drive is probed
      swim: Handle FIFO timeout error
      swim: Check for CRC errors
      swim: Simplify return value initialization
      swim: Check error register during sector read
      swim: Don't use the mark register to read data
      swim: Fix buffer overflow
      swim: Don't search beyond the first data mark
      swim: Return -EROFS when opened with BLK_OPEN_WRITE flag
      swim: Fix FDEJECT ioctl for exclusive open
      swim3: Fix FDEJECT ioctl for exclusive open

Florian Fainelli (6):
      tools/thermal/tmon: Fix string truncation warning in optarg copy
      net: bcmasp: unmap previous DMA mappings on TX map failure
      net: bcmasp: validate minimum RX packet size in bcmasp_rx_poll()
      net: bcmasp: fix OF node reference leak for phy_dn
      net: bcmasp: account for offload header in TX short packet padding
      net: dsa: mv88e6xxx: fix 6351 family statistics snapshot

Florian Fuchs (2):
      sh: uaccess: Require offsettable operands for 64-bit user access
      ALSA: sh: aica: Fix spu_memset() stride

Florian Schmaus (1):
      selftests/epoll: fix race condition in multi-waiter wakeup tests

Florian Westphal (5):
      netfilter: conntrack: fix unlikely UaF in gc worker
      selftests: netfilter: conntrack_vrf.sh: move to lib.sh infra
      selftests: netfilter: conntrack_vrf.sh: prefer socat, not iperf3
      selftests: netfilter: fix return value in zone subtest
      netfilter: nft_compat: restrict raw table targets/matches

Francesco Dolcini (3):
      arm64: dts: ti: k3-am62-verdin: Set MMC clock pins as OUTPUT
      arm64: dts: freescale: imx8mp-verdin-yavia: fix external GPIOs
      arm64: dts: ti: k3-am62-verdin: fix main_gpio0/main_gpio1 line names size

Francesco Orlando (1):
      Input: xpad - add GameSir Nova Lite support

Franck Baur (1):
      net: jme: keep RX MAC clock enabled for WoL

Frederic Weisbecker (2):
      rcu: Remove swake_up_one_online() bandaid
      Revert "rcu/nocb: Fix rcuog wake-up from offline softirq"

Fredric Cover (1):
      smb: client: fix early procfs exposure race

Fuad Tabba (9):
      KVM: arm64: Transfer the hyp stack pages out of the host stage-2
      irqchip/gic-v3-its: Don't clamp nvecs to zero when id_bits is 32
      KVM: arm64: timers: Compute an offset-applied CVAL from the current count
      KVM: arm64: Validate the host vCPU's VM before reading it under pKVM
      KVM: arm64: vgic-its: Don't map an LPI from more than one event
      arm64: pi: Run the source checker on the libfdt objects under C=2
      irqchip/gic-v3-its: Clear vpt_page after freeing the pending table
      irqchip/gic-v3-its: Don't free a vPE table shared with another ITS
      irqchip/gic-v3-its: Don't free the tables of an enabled ITS

Gabor Juhos (1):
      clk: qcom: gcc-ipq5018: mark 'gpll0_main' clock as critical

Gabor Tanz (1):
      HID: quirks: Always poll the Anne Pro 2 with product ID a292

Gabriel Krisman Bertazi (1):
      ext4: Move CONFIG_UNICODE defguards into the code flow

Gabriel Prostitis (1):
      USB: gadget: inode: fix mm lifetime handling

Gael Blivet (5):
      ksmbd: fix durable handle v2 default timeout units (60 -> 60000)
      ksmbd: skip fallocate for SMB2_CREATE_ALLOCATION_SIZE on a stream handle
      ksmbd: report actual xattr value length in stream enumeration
      ksmbd: fix AsyncId zeroed before use in smb2_lock() cancel response
      ksmbd: look up stream size by exact xattr name

Gangliang Xie (1):
      drm/amdgpu: add buf length check

Gary Guo (1):
      ata: ata_generic: Don't store pci_device_id

Gaurav Batra (1):
      powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped

Geert Uytterhoeven (2):
      spi: sh-msiof: SITMDR1/SIRMDR1 bitfield conversion
      clk: rs9: Add clock index range check to rs9_of_clk_get()

Geetha sowjanya (1):
      perf: marvell: Cancel CN10K DDR PMU hrtimer on device remove

Geliang Tang (1):
      nvme-tcp: look up host_iface in the current netns

George Melikov (1):
      bnx2x: fix header length calculation for encapsulated TSO

Georgia Garcia (1):
      apparmor: remove fs entries created by a failed policy load

Geraldo Nascimento (2):
      PCI: rockchip-host: Do not attempt 5.0 GT/s retraining
      PCI: rockchip: Drive at 2.5 GT/s, error other speeds

Gianluca Balboni (1):
      ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx

Gilles Risch (1):
      drm/radeon: fix internal display on iMac11, 1 (RV770/DCE3.1)

Ginger Li (3):
      media: exynos4-is: Fix a race between s_stream(0) and the interrupt handler
      media: i2c: ov5648: Fix a data race on state->streaming
      wifi: mac80211: Fix a race when expiring a mesh path

Giorgi Kobakhia (3):
      udf: fix return value for non-recorded-allocated extents in udf_map_block()
      ksmbd: fix overflow in dacloffset bounds check in build_sec_desc()
      ocfs2: fix array out of bound access in __ocfs2_find_path()

Giovanni Di Santi (2):
      fbdev: kyro: Use devm_ioremap() for mmio registers
      fbdev: kyro: Use devm_ioremap_wc() for screen mem

Glenn Judd (1):
      net/mlx5e: do not HW-GRO coalesce small frames

Golla Nagendra (1):
      dmaengine: zynqmp_dma: Fix chan probe/remove error handling

Greg Kroah-Hartman (4):
      media: adv7604: avoid negative array index in log_status when cp_read fails
      media: stv090x: bound DiSEqC reply length to msg[] size
      media: stv0900: bound DiSEqC reply length to msg[] size
      Linux 6.6.163

Greg Thelen (1):
      selftests/net: tcp_mmap: remove unused -k option and keepflag

Gregory CLEMENT (1):
      phy: cadence: Sierra: Do not modify register when getting parent clock

Gregory Price (4):
      mm/mempolicy: take a cpuset cookie for the interleave node count
      mm/madvise: use folio_trylock() in the cold/pageout PMD split
      rtc: cmos: Disable ACPI RTC event before handling it
      mm/userfaultfd: compare exact registration modes before skipping

Gregory Price (Meta) (3):
      mm/mempolicy: apply bind policies against the scoped allocation zone
      cgroup/cpuset: use mems_allowed_seq when checking a policy nodemask
      cgroup/cpuset: check effective mems for a movable-only configuration

Griffin Kroah-Hartman (2):
      nfc: mrvl: spi: Unregister dev on allocation fail
      nfc: nxp-nci: Add remove on IRQ error

Guanghui Feng (1):
      iommu/vt-d: Fix IQE handling to cover all descriptors in submission range

Guanglei Zhu (3):
      ceph: fix out-of-bounds read in ceph_netfs_issue_op_inline()
      ceph: clamp the inline data length in ceph_fill_inline_data()
      apparmor: check accept index + 1 is in bounds

Guangshuo Li (20):
      i2c: qcom-cci: fix autosuspend cleanup
      iio: accel: kxcjk-1013: Disable autosuspend on remove
      iio: accel: mma9551: disable autosuspend on remove
      iio: accel: mma9553: disable autosuspend on remove
      iio: adc: at91-sama5d2: disable autosuspend on remove
      media: atmel-isi: release unregistered video device on remove
      ASoC: Intel: atom: Fix platform device leak on probe failure
      media: tw686x: fix V4L2 device lifetime on probe failure
      media: rtl28xxu: fix SDR platform device leak
      media: mediatek: vcodec: destroy core workqueue on remove
      media: mediatek: vpu: release reserved memory on remove
      platform/x86: simatic-ipc: fix platform device leak on registration failure
      mfd: ab8500: Fix child device leaks on probe failure
      media: i2c: ov5647: fix power cleanup on remove
      irqchip/imx-intmux: Fix runtime PM teardown on remove
      crypto: omap-sham - fix crypto engine cleanup
      media: i2c: ar0521: remove duplicate media entity cleanup
      spi: fsl: unmap immr_spi_cs on remove
      spi: bcm63xx-hsspi: Disable runtime PM on remove
      floppy: unregister platform device on add_disk failure

Guenter Roeck (14):
      hwmon: (aquacomputer_d5next) Check maxcollection when probing AQUAERO devices
      hwmon: (asus_wmi_sensors) Avoid global struct mutation
      hwmon: (hp-wmi-sensors) Avoid global struct mutation
      hwmon: (hp-wmi-sensors) Fix unbounded loops in scale_numeric_sensor()
      hwmon: (lm87) Fix drvdata type confusion in vrm_show() and vrm_store()
      hwmon: (nct6683) Fix incorrect struct cast in show_pwm() and store_pwm()
      hwmon: (peci/dimmtemp) Fix devres leak and UAF on concurrent unbind
      hwmon: (pmbus/q54sj108a2) Add missing NULL pointer check
      hwmon: (pmbus) Release devres allocated memory after devm_thermal_of_zone_register error
      hwmon: (pmbus) Fix return value check from thermal zone registration
      hwmon: (coretemp) Check for NULL platform device in hotplug callbacks
      hwmon: (pmbus) Check return value from pmbus_thermal_add_sensor()
      hwmon: (coretemp) Fix 32-bit jiffies wraparound in show_temp()
      hwmon: (tmp108) Fix initial conversion delay and wait until ready

Gui-Dong Han (1):
      xen/blkback: Prevent missed completion when draining I/O

Guixin Liu (3):
      nvmet-fc: Tear down the association when the admin queue allocation fails
      nvmet: Finish the blk plug when integrity allocation fails
      nvmet: Free the old negotiation state when restarting authentication

Guixiong Wei (1):
      platform/x86/intel-uncore-freq: Continue restoring limits on resume

Gyokhan Kochmarla (1):
      erofs: use on-disk blkszbits for lz4 max pcluster bound

Günther Noack (1):
      landlock: Fix superblock use-after-free in release_inode()

Haibo Chen (1):
      leds: pca9532: Check i2c_smbus_read_byte_data() return value

Haitam Lazaar (1):
      RDMA/siw: Enforce IB_ACCESS_REMOTE_READ for read responses

Hangbin Liu (1):
      ipv6: sr: restruct ifdefines

Hannes Reinecke (3):
      nvme: add TCP TSAS definitions
      nvmet: make TCP sectype settable via configfs
      nvmet: do not return 'reserved' for empty TSAS values

Hans Verkuil (5):
      media: em28xx: dev_info->pr_info since dev has been freed
      media: em28xx: requeue buffers if start_streaming fails
      media: em28xx: use vb2_video_unregister_device
      media: cec: tegra_cec: don't break off msg on NACK
      media: cec/core: drop cec_post_state_event call

Hao Qin (2):
      Bluetooth: btmtk: Remove resetting mt7921 before downloading the fw
      Bluetooth: btmtk: Remove the resetting step before downloading the fw

Hao-Qun Huang (1):
      accel/qaic: reject BO sizes that overflow page count

Haotian Zhang (4):
      phy: hisilicon: hi3670: Fix OF node and device reference leaks
      cpufreq: qcom-cpufreq-hw: fix device node refcount leak in phandle parsing
      mtd: rawnand: pl353: fix clk reference leak in pl35x_nfc_setup_interface()
      scsi: elx: libefc: Fix resource leak in efcport_init() error path

Haoxiang Li (4):
      ASoC: hdac_hdmi: Fix resource cleanup on probe failure
      tty: serial: pch_uart: add check for pci_get_slot()
      usb: fsl_qe_udc: check qe_alloc_request() failure in ch9getstatus()
      iwlwifi: dvm: add missing cleaup for on error path

Harald Freudenberger (3):
      s390/crypto: Fix skcipher_walk return code handling in aes_s390
      s390/crypto: Fix use of mutex in atomic context
      s390/zcrypt: Fix out-of-bounds ptr advance in cca_query_crypto_facility()

Hari Mishal (5):
      nvme: bound ns descriptor header and body to identify buffer
      virtio_console: take a kref in find_port_by_vq() to fix port UAF
      nvmet: passthru: fix OOB reads when parsing ns id descriptor list
      drm/amd/display: guard dc_sink dereferences in MST mode validation
      drm/amd/pm: bound SCLK FCW range entries to the table size

Harry Wentland (1):
      drm/amd/display: Force GAMCOR for subsampled surfaces with PQ/Gamma22/HLG

Heiko Carstens (3):
      s390/probes: Fix wrong opcode for cgrb fixup
      s390/signal: Fix incorrect return address in signal frame
      s390/uprobes: Fix off-by-one bug in emulated PER handling

Heiko Schocher (1):
      drm/panel: simple: Add Kyocera tcg070wvlq panel

Helge Deller (1):
      fbcon: Fix KASAN slab-out-of-bounds Read in fbcon_prepare_logo

Hemanth Selam (2):
      ext4: skip extra isize expansion while unmounting
      nvdimm/pmem: Release gendisk on probe failure

Henrik Enquist (2):
      ALSA: aloop: Don't constrain playback params in notify mode
      ALSA: aloop: Update the PCM Slave controls for a matching playback

Henry Hu (5):
      ksmbd: fix invalid pointer dereference when get_inode_acl() fails
      ksmbd: fix link speed query in fsctl_query_iface_info_ioctl()
      ksmbd: fix unlocked IPv6 addr_list walk in fsctl_query_iface_info_ioctl()
      ksmbd: fix invalid Next offset in interface info replies
      ksmbd: report IPv4 and IPv6 addresses independently in iface query

Henry Martin (5):
      smb: client: fix use-after-free in cifs_ses_add_channel()
      tipc: fix broadcast sender hang on last acker departure
      rds: fix out-of-bounds conn_path walks via handshake exthdrs
      drm/amdkfd: fix doorbell allocation race creating duplicate allocations
      netlink: fix out-of-bounds bitmap access clearing stale mc groups

Herbert Xu (1):
      crypto: tcrypt - Avoid reading req->base after submission

Hernan Ganzo (1):
      ALSA: hda/realtek: Limit internal mic boost on HP Pavilion 15 (103c:2164)

Hitalo Souza (1):
      Bluetooth: Add missing newline to bt_dev_{err,warn}_ratelimited()

Hitesh Patel (3):
      media: qcom: camss: vfe-17x: Fix write master buffer done being dropped
      media: qcom: camss: vfe: Fix VFE reset while another line is streaming
      media: qcom: camss: vfe-17x: Fix write master selection for RDI lines

Hongbo Li (1):
      ASoC: remove unused substream in macro soc_link_mark_pop

Hongfu Li (3):
      mm/hugetlb_cgroup: move per-node usage on cross node migration
      mm/hugetlb_cgroup: move per-node usage on cgroup reparenting
      rds:Simplify the allocation of slab caches

Honggang LI (1):
      RDMA/rxe: Fix out-of-range unsigned-to-signed conversion for RDMA message in 2GiB size

Hongling Zeng (3):
      ntfs3: fix mapping pairs bounds check for alignment
      dmaengine: sun6i-dma: Fix use-after-free in error handling paths
      dmaengine: at_hdmac: Fix use-after-free by proper tasklet cleanup

Hongyan Xu (5):
      mfd: da903x: Cancel IRQ work during teardown
      soc: qcom: apr: clean up failed service registrations
      RDMA/hfi1: shut down the trap timer before unregistering
      RDMA/hfi1: quiesce SDMA asynchronous cleanup on exit
      ASoC: mt6359-accdet: manage private workqueues with devres

Hrishikesh Suresh (1):
      perf: replace strcpy() with strncpy() in util/jitdump.c

Hsiu-Hsien Lee (1):
      ext4: fix fast commit replay failing on a read-only mount

Huacai Chen (1):
      LoongArch: Use pa_to_nid()/nid_to_addrbase() rather than hard-code

Hugo Villeneuve (8):
      serial: sc16is7xx: declare SPR/TLR/XOFF2 register as volatile
      serial: sc16is7xx: add comments for lock requirements
      serial: sc16is7xx: declare MCR and IER as volatile registers
      serial: max310x: remove trailing whitespaces
      serial: max310x: remove holes in struct max310x_devtype
      serial: max310x: simplify probe() and remove() error handling
      serial: max310x: use common detect function for all variants
      serial: max310x: use common power function for all variants

Hui Peng (3):
      mctp: route: iterate socket tag list in mctp_lookup_prealloc_tag()
      ata: libata-scsi: abort multi-sector pass-through commands when multi_count is 0
      seccomp: restore knotif->state when SECCOMP_ADDFD_FLAG_SEND is interrupted

Hui Su (2):
      cpufreq: schedutil: Serialize sugov_start() against rate limit updates
      bpftool: Fix CPU IDs in per-CPU map output

Hung-Jui Lin (1):
      posix-timers: Report zero remaining time for disarmed SIGEV_NONE timers

Hungyu Lin (12):
      compat: avoid double rounding in times()
      timers/itimer: Keep a nonzero value at CPU timer expiry
      time/namespace: Fix overflow when converting absolute deadlines
      fs: skip copy_file_range write limits when there is no data
      posix-timers: Accept NULL clock_getres() output in stubs
      ext2: preserve completed DIO bytes when buffered fallback fails
      mm/migrate: untag addresses when querying page nodes
      inotify: do not coalesce rename events
      block: Return the soft block size for compat BLKBSZGET
      ext2: preserve IOMAP_F_DIRTY for extending direct writes
      mm/page-writeback: avoid 32-bit overflow in dirty threshold shares
      thermal: Fix CPU mask truncation in power limit trace event

HyeongJun An (32):
      ALSA: rawmidi: Return the error from snd_rawmidi_input_params()
      remoteproc: elf_loader: Bound the section header table
      mtd: spi-nor: sfdp: check the length of the xSPI Profile 1.0 table
      mtd: spi-nor: sfdp: check the length of the SCCR map
      ALSA: ump: Fix dropped data bytes at UMP System message conversion
      selftests/alsa: Do not take another control's event as our own
      ASoC: codecs: wm8990: Fix definition of right input PGA controls
      ASoC: codecs: wm8990: Fix definition of LOMIX AINLMUX Bypass Volume control
      ASoC: codecs: wm8991: Fix definition of right input PGA controls
      ASoC: codecs: wm8991: Fix definition of LOMIX AINLMUX Bypass Volume control
      ASoC: codecs: wm8983: Fix definition of ADC 128x Oversampling control
      ASoC: codecs: wm8985: Fix definition of ADC 128x Oversampling control
      ASoC: codecs: wm8994: Fix definition of WM8958 noise gate hold time controls
      ASoC: codecs: wm8955: Fix definition of Treble Cutoff control
      ASoC: codecs: wm_hubs: Fix definition of MIXINR to MIXOUTR volume control
      ASoC: codecs: wm8737: Fix definition of zero cross switches
      ASoC: codecs: wm5100: Fix definition of EQ3 Band 1 Volume control
      ASoC: codecs: wm8750: Fix definition of ALC Capture NG Type control
      ASoC: codecs: wm8510: Fix definition of ADC Inversion Switch control
      ASoC: codecs: da732x: Fix definition of ADC2 EQ Overall Volume control
      ASoC: codecs: tlv320adc3xxx: Fix definition of AGC Target Level control
      ASoC: codecs: sta32x: Fix definition of Ch2 and Ch3 Volume Bypass controls
      ASoC: codecs: sta350: Fix definition of Ch2 and Ch3 Volume Bypass controls
      ASoC: codecs: sta32x: Fix definition of limiter threshold controls
      ASoC: codecs: sta350: Fix definition of limiter threshold controls
      ASoC: tlv320aic32x4: Fix definition of TAS2505 HP Driver Gain Volume control
      ASoC: cs42l56: Remove the ADC Mute Switch control
      selftests: ALSA: pcmtest: Check the frame count of each transfer
      selftests: ALSA: pcmtest: Make room for the longest fill pattern
      selftests: ALSA: pcmtest: Compare all captured bytes in ni_capture
      ALSA: pcmtest: Reject invalid fill_mode values
      ALSA: pcmtest: Honor the enable parameter

Hyeontae Lee (2):
      fs/ntfs3: bound CreateAttribute asize against record_size in do_action
      fs/ntfs3: bound DeleteAttribute asize against rec->used in do_action

Hyunwoo Kim (1):
      inet: reject unhashed sockets during established lookups

Håkon Bugge (1):
      net/rds: hold the socket while an rds_mr references it

Ian Abbott (11):
      comedi: ni_atmio16d: Add sanity check to interrupt handler
      comedi: ni_at_a2150: Fix sanity check in interrupt handler
      comedi: pcm818: Fix sanity check in interrupt handler
      comedi: quatech_daqp_cs: Fix sanity check in interrupt handler
      comedi: das6402: Add sanity check to interrupt handler
      comedi: dt2811: Fix sanity check in interrupt handler
      comedi: pcm711: Fix sanity check in interrupt handler
      comedi: aio_iiro_16: Add sanity check to interrupt handler
      comedi: pcmmio: Add sanity check to interrupt handler
      comedi: pcm816: Fix sanity check in interrupt handler
      comedi: pcmuio: Add sanity check to interrupt handler

Ian Bridges (8):
      ksmbd: fix out-of-bounds read when padding the final compound response
      ksmbd: fix use-after-free after a failed durable reconnect
      ksmbd: fix session reference leak on compounded SESSION_SETUP
      ksmbd: require DELETE access for delete-on-close opens
      ksmbd: grant a POSIX ACL group entry only to the group's members
      ksmbd: revert fsids on durable reconnect and replay failure
      ksmbd: enforce the read-only share flag when creating a stream
      ksmbd: do not read past the DACL in the access denied debug message

Ian Gallagher (1):
      ACPI: button: Add lid_init_state quirk for Razer Blade Stealth 13 (Early 2020) RZ09-0310

Ian Rogers (5):
      perf: Replace perf_event_header__init_id with full header init
      perf header: Fix potential memory corruption in cpu_cache_level__read
      perf build: Check the version of the compiler that is used
      perf vendor events intel: Fix skylakex umask encoding.
      perf vendor events intel: Fix snowridgex umask encoding.

Ibrahim Hashimov (1):
      fs/ntfs3: fix integer overflow in find_log_rec() causing OOB read

Ido Schimmel (7):
      ipv6: Fix redirect exception creation for UDP/RAW sockets
      ipv6: udp: Create exceptions before socket matching
      ipmr: fully initialize the synthetic IP header in ipmr_get_route()
      vxlan: Stop rejecting dynamic FDB entries with a nexthop ID
      ipmr, ip6mr: validate packets injected into the register vif on xmit
      bridge: mcast: Delete empty MDB entry when port group creation fails
      ipv6: Hold RCU when emitting route hardware flags notification

Igor Putko (1):
      serial: core: shut down initialized port on removal

Igor Skalkin (1):
      usb: gadget: dummy_hcd: fix SuperSpeed ep0 maxpacket

Igor Velkov (4):
      genirq/kexec: Do not take the bus lock of an interrupt chip on the crash path
      arm64: dts: amlogic: meson-sm1-odroid-hc4: mux the SPI NOR HOLD# and WP# pins
      arm64: dts: amlogic: meson-sm1-odroid-hc4: run the SPI NOR at 40 MHz
      power: supply: gpio-charger: Report discharging without input power

Ilya Leoshkevich (1):
      scripts/gdb/radix-tree: add lx-radix-tree-command

Ilya Maximets (1):
      net/sched: act_ct: remove 'add_helper' dead code

Imre Kaloz (7):
      PCI: Disable MSI for ULi M1575 EHCI controller
      scsi: aic7xxx: Use default settings on the SGI O2 onboard controllers
      MIPS: mm: Fix the cache error vector jump for XKPHYS kernels
      MIPS: sgi-ip32: Mask MACE PCI interrupts in CRIME only
      MIPS: sgi-ip32: Leave MACE PCI control alone in config accesses
      rtc: ds1685: arm the wake-up alarm at power-off only if an alarm is set
      rtc: ds1685: do not sleep in the power-off handler

Ionut Nechita (1):
      x86/crash: Reserve elfcorehdr for CONFIG_NR_CPUS, not CONFIG_NR_CPUS_DEFAULT

Israel Téllez García (1):
      libbpf: Fix ring buffer consumer loop on 32-bit position wrap

Ivan Hu (1):
      ACPICA: Initialize parser_state.aml_end in acpi_install_method()

Ivan Lipski (1):
      drm/amd/display: Bump frame warning limit for clang builds of dml

Jacob Keller (1):
      ice: set in_use only after preparing Tx timestamp index

Jacob Moroni (2):
      RDMA/irdma: Fix erroneous -ENOMEM for large MR registration
      RDMA/irdma: Fix FRWR IRDMAQPSQ_PBLADDR field population

Jaewon Jung (1):
      selftests/ftrace: Avoid unlink error on first run

Jake Labelle (2):
      nilfs2: validate directory position after llseek in readdir
      nilfs2: reject non-regular inodes in dsync recovery

Jakub Kicinski (2):
      eth: bnxt: free XDP frags when xdp_do_redirect() fails
      eth: bnxt: hand XDP frags over to the copybreak skb

Jakub Sitnicki (3):
      net: Helper to move packet data and metadata after skb_push/pull
      bpf: Make bpf_skb_adjust_room metadata-safe
      net: lwtunnel: Drop skb metadata before LWT encapsulation

Jakub Szczudlo (1):
      iio: adc: ti-ads1100: Fix incorrect reading when datarate changed in single mode

Jamal Hadi Salim (7):
      net/sched: sch_teql: fix slaves_lock IRQ deadlock
      net/sched: act_ife: do not consume the inner header on egress
      netdevsim: reject cls_bpf programs bound to another device
      bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
      net/sched: clamp skb->queue_mapping before indexing the tx queue
      net: rtnl: introduce rcu_replace_pointer_rtnl
      net/sched: act_api: reject duplicate actions in a batch

James Clark (1):
      net: ethernet: ti: am65-cpsw-nuss: Enable timestamping of unicast PTP packets

James Hilliard (2):
      mtd: rawnand: sunxi: reject ECC maximization on small pages
      net: stmmac: avoid duplicate XSK TX completions

James Kim (1):
      rapidio: mport_cdev: fix use-after-free in mport_mm_close()

Jamie Nguyen (1):
      selftests: net: txtimestamp: fix out-of-bounds read in raw UDP checksum

Jan Beulich (1):
      x86/PVH: don't truncate initrd address/size

Jan Kara (4):
      udf: Fix bh leak for unallocated space entries
      udf: Avoid invalid LVID used on mount
      udf: Make sure there's enough space for LVID implementation use field
      gfs2: Fix journaled truncate range end offset

Jan Koester (1):
      ksmbd: ignore network devices of other namespaces

Jan Stancek (1):
      .gitignore: drop Module.markers

Jann Horn (1):
      mm: document mmu_notifier_invalidate_range_start_nonblock()

Janne Grunau (1):
      wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload

Jaroslav Kysela (1):
      ALSA: pcm: Introduce MSBITS subformat interface

Jason Gunthorpe (2):
      efi/libstub: Fix error unwind freeing fdt in allocate_new_fdt_and_exit_boot()
      efi/riscv: libstub: Don't set image_size in handle_kernel_image()

Jason J. Herne (1):
      s390/vfio-ap: handle hardware checkstop state on queue reset operation

Jason Perlow (1):
      wifi: brcmfmac: map msgbuf RX packet IDs bidirectional

Jasper Firth (1):
      ASoC: Intel: bytcr_rt5651: Add quirk for Chuwi Hi8 with generic DMI strings

Jay Vadayath (1):
      udf: bound lengthAllocDescs from unallocated space entry

Jean Delu (1):
      parisc: eisa_enumerator: Fix out-of-bounds reads of the EEPROM buffer

Jean Delvare (1):
      EDAC/mc: Really fix error path ordering in edac_mc_alloc()

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: fix odr change not caught in certain cases

Jeff Chen (1):
      wifi: mwifiex: append hotfix number to firmware version string

Jeff Layton (5):
      nfsd: dedup nfs4_client_to_reclaim inserts
      nfsd: use test_and_clear_bit for somebody_reclaimed to prevent lost update
      SUNRPC: keep the first error in svc_register()
      nfs: convert to using new filelock helpers
      nfsd: don't offer flexfiles layouts when NFSv3 isn't being served

Jeffin Philip (1):
      media: vidtv: fix uaf in vidtv_bridge_on_new_pkts_avail

Jens Axboe (3):
      io_uring/sqpoll: don't attach to a thread that is canceling
      io_uring/poll: don't poll a writer for a read side hangup
      io_uring/poll: don't poll a writer for urgent data

Jenson Johnathon Reggentin (1):
      docs: block: fix dead http link in blk-mq.rst

Jeremy Bongio (1):
      RDMA/irdma: Use kvzalloc for lvl2 leafmem allocation

Jeremy Kerr (5):
      net: mctp: avoid confusion over local/peer dest/source addresses
      net: mctp: Add some detail on the key allocation implementation
      net: mctp: separate key correlation across nets
      net: core: Implement dstats-type stats collections
      net: mctp: mctp_fraq_queue should take ownership of passed skb

Jerome Brunet (3):
      clk: sunxi-ng: fix ccu probe clock unregister on error
      clk: fix self-consuming provider module pinning
      clk: cdce925: Size the PLL child name buffer for any int

Jesse Zhang (11):
      drm/amdgpu: force complete the MES ring fences on reset
      drm/ttm: return an error when kmapping a BO without pages
      drm/amdgpu: reject ANONONLY userptrs that span multiple VMAs
      drm/amdkfd: evict the queues only once for CRIU PROCESS_INFO
      drm/amdgpu: parse CS IBs at the BO offset their VA mapping starts at
      drm/amdgpu: keep the CS user fence BO in GTT
      drm/amdgpu: don't drop the gang dependency fence twice
      drm/amdgpu: reject CS chunks too large for kvmalloc()
      drm/amdgpu: drop the gang leader reference when freeing gang jobs
      drm/amdgpu: don't walk the CS chunks when allocating them failed
      drm/amdkfd: use the queue's process info for the WPTR BO eviction fence

Jhonata Poma-Hansen (1):
      netlink: check sk_rcvbuf before charging the dump skb

Jia Wang (3):
      dmaengine: dw-axi-dmac: Fix AXI burst length encoding
      dmaengine: dw-axi-dmac: Fix LLI dump out-of-bounds access
      dmaengine: dw-axi-dmac: Fix CH_CFG2 channel priority position

Jiacheng Xu (1):
      kobject: fix out-of-bounds access in kobject_action_type()

Jiale Yao (47):
      HID: zydacron: validate key report length
      HID: cougar: reject short special-key reports
      HID: cp2112: validate response report lengths
      HID: elo: reject short touchscreen reports
      HID: logitech-dj: validate unnumbered keyboard reports
      HID: mcp2200: validate READ_ALL response length
      HID: mcp2221: validate response report length
      HID: pxrc: reject short input reports
      HID: roccat: isku: reject short button reports
      HID: roccat: koneplus: reject short button reports
      HID: roccat: konepure: reject short button reports
      HID: roccat: kovaplus: reject short button reports
      HID: roccat: pyra: reject short button reports
      HID: roccat: ryos: reject short special reports
      HID: roccat: savu: reject short special reports
      iio: potentiometer: x9250: reject devices without match data
      iio: adc: ti-adc128s052: validate SPI match data
      cxl/acpi: Check ACPI companion before use
      wifi: mt76: mt7615: cancel reset work during unregister
      drm/amdkfd: validate SRAT subtables before parsing
      HID: prodikeys: validate fixed-format MIDI reports
      iio: adc: ad7192: reject devices without match data
      hwmon: (aquacomputer_d5next) reject short status reports
      crypto: ccp - kill v3 IRQ tasklet during teardown
      crypto: ccp - kill v5 IRQ tasklet during teardown
      ext2: drain in-flight DIO before buffered write fallback
      RDMA/mad: Reject receive completions shorter than GRH
      RDMA/mlx4: Do not allow the user to write to the clock page
      RDMA/cxgb4: Do not allow userspace to write the status page
      ASoC: rt5682-sdw: always cancel jack work on remove
      ASoC: rt711-sdw: always cancel jack work on remove
      ASoC: rt711-sdca: always cancel jack work on remove
      ASoC: rt712-sdca: always cancel jack work on remove
      ASoC: rt722-sdca: always cancel jack work on remove
      pinctrl: sprd: free maps on DT map failure
      wifi: mt76: mt76x02: validate RX padding before use
      wifi: mt76: usb: fix source overread in mt76u_copy
      wifi: mt76: mt7615: usb: fix source overread in mt7663u_copy
      ACPI: PCI: pci_link: clear driver_data before free
      wifi: ath10k: avoid IDR mutation during TX cleanup
      wifi: ath11k: avoid IDR mutation during pending mgmt TX cleanup
      wifi: ath11k: avoid IDR mutation during vif mgmt TX cleanup
      wifi: ath12k: avoid IDR mutation during vif mgmt TX cleanup
      platform/olpc: Reserve space for a string terminator
      team: reject CAN, IEEE 802.15.4 and 6LoWPAN devices in team_port_add
      Drivers: hv: vmbus: Check ACPI companion before use
      regulator: irq: freeze deferred hardware access during suspend

Jiaming Zhang (4):
      hfsplus: validate extent record length before writing it back
      ocfs2: fix chunk number of the first chunk in a local quota file
      gfs2: reject invalid inode sizes
      nilfs2: force clear dirty state when restoring from the shadow map

Jiangong.Han (1):
      USB: usbmon: fix null-ptr-deref in mon_bus_remove() when mon_bus_init() fails

Jiangshan Yi (2):
      HID: nintendo: register input device after capabilities are set
      ceph: fix longname buffer overflow in ceph_fname_to_usr()

Jianyun Gao (4):
      dax: Return errors from dax_core_init()
      dax: fix dax_range_compare_iter() to use correct size and address offset
      xfs: fix temporary cursor leak in btree shift corruption paths
      dax: fix wrong error code returned from dax_dedupe_file_range_compare()

Jiapeng Chong (1):
      i2c: qcom-cci: Remove the unused variable cci_clk_rate

Jiawen Liu (6):
      spi: bcm-qspi: return error from failed controller suspend
      spi: bcm63xx: return error from failed controller suspend
      spi: bcm63xx-hsspi: return error from failed controller suspend
      spi: bcmbca-hsspi: return error from failed controller suspend
      media: amphion: fix runtime PM imbalance on probe failure
      memory: exynos5422-dmc: handle clock enable failures

Jiaxing Hu (1):
      iommu/rockchip: Clear stale page faults before enabling stall

Jiayuan Chen (8):
      netfilter: ebtables: bound num_counters like nentries in do_replace()
      bonding: fix out-of-bounds read of arp_ip_target
      mm/memcontrol: fix data-race on reading jiffies_64
      bpftool: Using the right format specifiers
      tcp_bic: fix divide by zero on max_increment == 0
      tcp_hybla: fix divide by zero on rtt0 == 0
      tcp_cubic: fix divide by zero and endless loop on bad module params
      bpf: Fix verifier WARN on narrow read of bpf_tcp_sock u64 fields

Jiebin Sun (1):
      perf c2c: Fix documented default coalesce fields

Jimmy Zuber (1):
      fuse: zero the partial EOF page when extending a file

Jingyi Wang (2):
      remoteproc: qcom: Check subdev start status in rproc_stop()
      remoteproc: core: cancel crash_handler work in rproc_add() error path

Jinhui Guo (1):
      net: usb: cdc_ether: add quirk for AMI BMC stale link events

Jinjie Ruan (3):
      ext4: fix out-of-bounds read in ext4_get_group_info()
      arm64: kexec_file: Fix elf_headers memory leak in retry loop
      wifi: mt76: Use PTR_ERR_OR_ZERO() to simplify code

Jinqian Yang (1):
      virtio_ring: fix infinite loop in virtnet_poll_cleantx when device is broken

Jinwang Li (1):
      Bluetooth: L2CAP: Ignore connection responses with wrong ident

Jiri Olsa (3):
      bpftool: Add support to display uprobe_multi links
      bpf: Add support to retrieve ref_ctr_offset for uprobe perf link
      bpftool: Fix wrong free call in do_show_link

Jiri Slaby (SUSE) (3):
      serial: 8250_lpss: do not touch uninitialized line in ehl_serial_exit()
      HID: hid-prodikeys: remove struct pk_device
      serial: 8250_exar: store the GPIO platform device in struct exar8250

Jisheng Zhang (3):
      regulator: mp886x: fix vsel_mask
      regulator: mp886x: check get_voltage_sel() return value
      regulator: mp886x: fix pontential division by zero

Jiucheng Xu (1):
      f2fs: force out-place update for all writes on compressed file

Joanne Chang (2):
      f2fs: dirty directory inodes on mtime/ctime update
      f2fs: allow pinning empty compressed files

Joanne Koong (2):
      fuse: don't launder folios of a bad inode
      fuse: don't drop destination page cache on a zero byte copy reply

Joas Antonio dos Santos (4):
      calipso: hash the cache key, not the option start, in calipso_cache_add()
      calipso: update payload_len when removing the CALIPSO option
      net: dcb: initialize PFC value before calling getpfccfg
      net: mctp: free reassembly head skb when key_add fails on SOM

Joe Damato (1):
      mm: memcontrol: raise MEMCG_MAX for charges that fail without reclaiming

Joe Hattori (1):
      PM: wakeup: implement devm_device_init_wakeup() helper

Joel Fernandes (1):
      rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path

Johan Alvarado (1):
      net: stmmac: raise TX completion interrupt at the end of an xmit burst

Johan Hovold (8):
      driver core: take parent lock on deferred probe
      driver core: fix parent lock use-after-free on USB disconnect
      media: usbtv: drop redundant device reference
      staging: greybus: uart: fix racy TIOCMIWAIT implementation
      USB: cdc-acm: fix urb leak on disconnect
      USB: serial: usb_wwan: fix urb leak on disconnect
      USB: serial: sierra: fix urb leak on write completion
      spi: fsl: switch to managed controller allocation

Johannes Berg (12):
      wifi: mac80211: fix unauthorised port check for encap offload
      wifi: mac80211: fix key selection for encap offload frames
      wifi: mac80211: don't send encap offload frames unencrypted
      wifi: mac80211: drop encap offload frames with a tainted key
      wifi: ath6kl: don't take RTNL in del_virtual_intf
      wifi: mac80211: clear fragment cache entry 'is_protected'
      wifi: mac80211: mesh: use hlist_add_head_rcu()
      wifi: mac80211: kill wake_txqs_tasklet on unregistration
      wifi: mac80211: init radiotap iter after length checks
      wifi: mac80211: fix mbssid/rnr allocation in beacon data
      wifi: cfg80211: reg: protect regdb pointer with RCU
      wifi: cfg80211: track SSID regardless of country data

Johannes Thumshirn (1):
      btrfs: zoned: fix double list add in btrfs_load_block_group_zone_info

Johannes Weiner (2):
      mm: mempolicy: fix automatic numa balancing for shmem
      mm: page_alloc: do not give all non-blocking requests reserve access

John Garry (1):
      nvme: don't reference NS after unlocking in nvme_ns_head_ctrl_ioctl()

John Johansen (6):
      apparmor: fix auditing of mount binary data
      apparmor: fix refcount leak in aa_get_newest_profile()
      apparmor: on failed load ensure profile files are removed before parent
      apparmor: advertise availability of exended perms
      apparmor: allow restricting unprivileged change_profile
      apparmor: add support for 2^24 states to the dfa state machine.

Jonas Karlman (1):
      drm/rockchip: dw_hdmi: Use resume_early pm ops for system suspend

Jonathan Gopel (1):
      thunderbolt: Do not RPM complete unrelated subtrees on unplug

Jonghyuk Kim(MalHyuk) (1):
      drm/msm: RCU-free the scheduler-containing ring and VM objects

Joonhoe Kim (3):
      drm/msm/dpu: disable the slave encoder before the master
      drm/msm/dpu: compute the CRTC bandwidth from the state being checked
      power: supply: qcom_battmgr: report the USB type from USB_ADAP_TYPE

Jose Maria Casanova Crespo (1):
      drm/v3d: Initialize timedout_batches when running a CSD job

Jose Villaseñor Montfort (1):
      HID: input: read battery capacity from its actual report offset

Josef Bacik (52):
      driver core: Limit the messages on a refused uevent
      io_uring/io-wq: no new workers once the exit has begun
      mm/hugetlb: fix use-after-free of a new anon folio
      aoe: pull in the headers each received packet type reads
      net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()
      mount: refuse setns() with a shared fs_struct again
      tmpfs: keep the quota soft limits of an unused id
      tmpfs: preserve explicitly disabled quota limits
      mm/mglru: don't use stack pointers when walking PUD and PMD tables
      mm/memfd: make f_pos accesses atomic
      mm/filemap: don't lose a folio lock wakeup to a signal
      mm/mmu_gather: fix flushing ranges with 4 GiB or larger
      mm: fix unmap_mapping_range() beyond 4 GiB on 32-bit
      blk-mq: end the request if getting a keyslot fails
      mm/hugetlb: unmap the page where the other VMA maps it
      mm/hugetlb: fix endless write fault on a leftover uffd bit
      mm/mremap: fix moving PUD leaves
      mm/filemap: read mapping->a_ops->free_folio under i_lock
      mm/mmu_notifier: finish non-blocking interval invalidation on error
      bpf: Don't let bpf_skb_adjust_room() use up the MSS
      bpf: Read the probe of a perf event under event_mutex
      bpf: Validate the SRH which End.DT6 uncovers in End.BPF
      bpf: Pull the inner header for End.DT6 in End.BPF
      bpf: Update the SRH state if End.B6 fails late
      bpf: Bound the nesting that the BTF show code follows
      bpf: Fix stale offload->prog pointer after realloc
      bpf: Don't bind a program to a netdev that goes away
      bpf: Don't take an extension for an iterator program
      bpf: Use the socket of a sk_lookup test run under RCU
      bpf: Use memmove() to store bytes in an skb
      nvmet: don't truncate the length of big discards
      nvmet-auth: take only AUTH_Negotiate for a negotiation
      nvmet-tcp: stop listening when a port is removed
      nvmet-tcp: don't read a removed port at Connect time
      nvme-loop: don't BUG() if a scan runs beside a reset
      blk-throttle: don't truncate the cgroup v1 iops limits
      blk-cgroup: fix root io.stat byte counts on 32-bit
      blk-cgroup: don't free a blkg with its punt work queued
      blk-iolatency: flush enable_work after going offline
      fork: Let nobody keep a task that may not come to life
      block: fix use-after-free of the disk in sync_bdevs()
      block: don't lose the status of a failed flush request
      blk-mq: keep sharing tags fairly after a queue update
      blk-mq: don't bring back flags of a completed request
      blk-mq: don't forget a timer the driver has restarted
      blk-mq: quiesce a queue that joins a quiesced tag set
      blk-mq: exit the hctxs of a queue under tag_list_lock
      block: partitions/mac: compute the sectors in 64 bits
      drbd: stop the start_resync timer of a dying device
      drbd: take req_lock to skip the initial sync as peer
      block/rnbd-srv: don't free the device on a sysfs error
      block/rnbd-srv: drop the sess_dev kobject unlocked

Joseph Qi (24):
      ocfs2/dlm: hold the lookup reference across convert AST enqueue
      ksmbd: fix breaking_cnt leak on early return in oplock_break()
      ocfs2: exit recovery thread on mount error path
      ocfs2: free replay slots in ocfs2_recovery_exit()
      ocfs2: skip uninitialized lockres in ocfs2_mark_lockres_freeing()
      ocfs2: reserve metadata for a new xattr block and its value tree
      ocfs2: reserve value tree metadata when moving an xattr into the inode
      ocfs2: deal with legacy signed dir index name hash values
      ocfs2: use the stored hash when checking xattr bucket collision
      ocfs2: deal with legacy signed xattr name hash values
      ocfs2: read the xattr entry hash before defragmenting the bucket
      nfsd: fix NULL dereference in nfsd4_free_layout_stateid()
      ocfs2: find the xattr entry again after defragmenting a bucket
      ocfs2: find the xattr entry again after converting a block to a bucket
      ocfs2: do not read the entry array of an empty xattr bucket
      ocfs2: do not index before the entry array when dividing an empty bucket
      ocfs2: do not read the entry array of an empty xattr block
      ocfs2: restrict OCFS2_INVALID_SLOT suballoc slot to system inodes
      ocfs2: fix deadlock in inline-data truncate transactions
      ocfs2: allow xattr bucket entries to span multiple blocks
      ocfs2: reject inconsistent xattr bucket during defrag
      ocfs2: retain all security xattrs during inode creation
      ocfs2: fix possible deadlock between nfs_sync_rwlock and fs_reclaim
      ocfs2: reserve xattr value tree metadata only once

Jouni Högander (2):
      drm/i915/psr: Clear selective fetch area when duplicating plane state
      drm/i915/display: Add enabled pipe planes into state for selective fetch

Ju Nan (1):
      irqchip/stm32mp-exti: Fix the unit of the hwspinlock timeout

Juan Perdomo (1):
      media: cx231xx: preserve I2C transfer length

Judith Mendez (5):
      arm64: dts: ti: k3-am62a7-sk: Set SD clock pin as OUTPUT
      arm64: dts: ti: k3-am625-beagleplay: Set MMC clock pins as OUTPUT
      arm64: dts: ti: k3-am62x-sk-common: Set SD clock pin as OUTPUT
      arm64: dts: ti: k3-am62-phycore-som: Set eMMC clock pin as OUTPUT
      arm64: dts: ti: k3-am625-sk-common: Set eMMC clock pin as OUTPUT

Julian Anastasov (2):
      ipvs: fix buffer overflow when sending sync messages
      ipvs: fix more races around the overload flag

Julian Braha (2):
      media: marvell-cam: fix unmet dependency for VIDEO_MMP_CAMERA
      kconfig: fix extra output from savedefconfig on out-of-range defaults

Julian Haarmann (1):
      platform/x86: lenovo/ymc: Only match lower byte in WMI lid switch query response

Julian Sun (2):
      writeback: reset dirtied_when when switching wbs
      writeback: clear old wb dirty state after inode switches

Julius Bairaktaris (2):
      wifi: mac80211: fix swapped fq_overlimit/fq_overmemory in aqm debugfs
      wifi: mac80211: don't reset the TXQ scheduling round number

Jun Yang (1):
      sctp: re-point retained control chunks on association migration

Junhao He (1):
      ACPI: APEI: Handle repeated SEA error storms

Junjie Cao (1):
      ASoC: rt712-sdca-dmic: fix drvdata type in the gain controls

Junrui Luo (4):
      media: vicodec: fix out-of-bounds write on under-rounded coded dimensions
      media: vicodec: make encoder CAPTURE dimensions read-only
      media: vicodec: zero-initialize stateful decoder heap buffers
      media: vicodec: fix NULL deref on oversized frame

Junxian Huang (1):
      RDMA/hns: Fix GID capacity loss in 64K system

Junzhe Yu (1):
      ext4: guard against NULL s_group_info in ext4_get_group_info

Jurison Murati (2):
      media: i2c: ov8865: Drop the runtime PM usage count on stream failure
      media: i2c: ov8865: Program the sensor on stream start

Justin Chen (3):
      memory: brcmstb_dpfe: Fix out-of-bounds access due to DCPU offset
      memory: brcmstb_dpfe: Bounds check DCPU-supplied MSG_ARG_COUNT
      net: bcmgenet: if UMAC was suspended in SW_RESET, restore it to SW_RESET

Justin Yeh (1):
      HID: i2c-hid: Unfollow the panel on shutdown

Jérémy Jean (14):
      lib/crypto: arm64: Fix lost Poly1305 carry when resuming NEON state
      nfsd: preflight SEQUENCE replies before accepting a slot
      SUNRPC: fix oversized GSS proxy token copy
      nvmet-auth: serialize access to DH-HMAC-CHAP state to fix UAF
      nvmet: free the bvec on file namespace range errors
      ceph: fix 32-bit overflow in readdir reply count check
      libceph: fix out-of-bounds reads from repeated CRUSH bucket entries
      crypto: ecc - Handle exceptional points in Shamir multiplication
      microblaze: prevent ptrace writes to MSR and pt_mode
      md: reject v0.90 arrays with too many devices
      NFS: filelayout: calculate dense stripe width in 64 bits
      macsec: prevent AES-GCM nonce reuse after packet number wrap
      netfilter: nf_conntrack: avoid truncating IPv6 nexthdr offset
      nvmet-auth: reject incomplete DHCHAP messages

Jérôme Pouiller (2):
      wifi: wfx: fix possible device hang during init
      wifi: wfx: fix use-after-free of the cooling work on device removal

KaFai Wan (1):
      selftests/bpf: Fix prog_tests framework subtest count checks

Kaho Jiang (2):
      net: ipv4: add zero check for snd_cwnd_clamp
      media: em28xx: fix double free in em28xx_alloc_urbs

Kaixuan Li (3):
      f2fs: check every cur_*_segno[] entry on readonly images
      can: isotp: check the frame type, not just the length
      f2fs: bound the SIT/NAT bitmaps by the checkpoint pack

Kameron Carr (1):
      Drivers: hv: vmbus: Bounds check the shared ring buffer indices

Kamil Sawicki (1):
      net: limit priority VLAN untag depth

Kanala Ramalingeswara Reddy (1):
      drm/amdgpu: Skip accessing psp rum time db for APUs

Kang Yang (1):
      wifi: ath12k: refactor multiple MSI vector implementation

Karl Asseily (1):
      dt-bindings: vendor-prefixes: add ESS Technology

Karl Mehltretter (47):
      ksmbd: use u8 for SMB2 oplock level values
      klist: avoid accesses after waking klist_remove()
      microblaze: Fix MB_MANAGER build with older binutils
      fs_pin: publish pins with RCU list helpers
      ACPI: pfr_update: zero-initialize capability query result
      crypto: atmel-tdes - zero-initialize device state
      crypto: atmel-aes - fix AADLENR for standalone GHASH
      lib/842: reject output overflows from index and short data
      lib/842: require a complete history block for repeat templates
      crypto: atmel-tdes - sync output bounce buffer before DMA
      fpga: Fix of_fpga_mgr_get() reference in fpga_mgr_lock() docs
      KVM: arm64: vgic-v3: Undo assignment on iodev registration failure
      KVM: arm64: vgic-v3: Roll back assignments from the new region
      sh: intc: Sort the prio and sense lists after filling them
      ARM: 9488/1: smp: set current pointer in assembly before jumping into C
      ARM: 9491/1: alignment: restore uaccess state on emulation fault
      irqchip/atmel-aic[5]: Disable interrupts in the irq_pm_shutdown() callbacks
      ocfs2/cluster: hold a reference on the heartbeat thread
      irqchip/gic-v3-its: Don't WARN on LPI free allocation failure
      virtio_ccw: fix synchronize_cbs() after interrupt fallback
      virtio_ccw: always take irq_lock in the classic interrupt handler
      mtd: spinand: Fix spinand_manufacturer_ops kernel-doc
      power: supply: mp2629: Use the full batt_impedance_compensation name in the ABI document
      efi/libstub: Fix efi_set_event_at() parameter documentation
      firewire: cdev: Fix FW_CDEV_IOC_CREATE_ISO_CONTEXT references in kernel-doc
      clk: mediatek: reset: Fix device registration kernel-doc
      spi: Fix the return value in spi_new_ancillary_device() kernel-doc
      ata: libata-scsi: Fix ata_scsi_hotplug() reference in kernel-doc
      gfs2: Fix the return value in gfs2_get_link() kernel-doc
      ALSA: control: Fix virtual master creation reference in kernel-doc
      regulator: qcom-rpmh: Fix the return value in rpmh_regulator_vrm_get_optimum_mode() kernel-doc
      wifi: mac80211: Fix the return value in mesh_path_add() kernel-doc
      loadpin: Fix stale KEXEC_VERIFY_SIG reference in documentation
      pinctrl: stm32: Drop the nonexistent CONFIG_MACH_STM32MP25 from the STM32MP257 default
      soc: ti: k3-ringacc: Correct ring API kernel-doc
      soc: ti: k3-ringacc: Fix DMA ring initialization kernel-doc
      time: Prevent time64_to_tm() day truncation on 32-bit
      OPP: Fix the return value in dev_pm_opp_get_of_node() kernel-doc
      crypto: atmel - handle authenc requests without plaintext
      floppy: flush pending work before releasing resources on init failure
      kobject: Fix the kobj_set_name reference in kset_register() kernel-doc
      sh: sh7785lcr: Register the PCA9564 controller as I2C bus 0
      thermal: ti-soc-thermal: Fix the return value in ti_bandgap_get_sensor_data() kernel-doc
      serial: ma35d1: Do not force-enable an unselected console
      ARM: 9486/1: set !LPAE MAX_PHYSMEM_BITS to 32 and remove supersection mappings
      ARM: 9492/1: alignment: fix LSR #32 and ASR #32 offset decoding
      rtc: class: Make the time32 hctosys limit configurable

Kathiravan Thirumoorthy (3):
      clk: qcom: ipq5018: add 24MHz rate for USB UTMI clock
      clk: qcom: ipq5332: add 24MHz rate for USB UTMI clock
      arm64: dts: qcom: ipq9574: Wire up USB3 PHY PIPE clock to GCC

Kazuki Hanai (1):
      media: mediatek: jpeg: Avoid context access after job finish

Kees Cook (1):
      kbuild: Mark the initcall ordering recipe as recursive

Keisuke Tsukuda (2):
      usb: gadget: composite: avoid warning on aborted delayed status
      usb: gadget: f_mass_storage: ignore class requests while inactive

Keita Morisaki (1):
      drm/amd/display: Fix swap in median3() for DSC rate control

Keith Busch (1):
      nvme: tcp: split controller bringup handling

Kemeng Shi (1):
      irqdomain: Plug leak in irq_domain_alloc_irqs_locked() error path

Kendall Willis (1):
      serial: 8250_omap: fix wake irq cleared during suspend

Kenneth Feng (1):
      drm/amd/pm:restate all customized OD features on every table upload for smu 13.0.0/smu 14.0.2

Keqiang Duan (1):
      KVM: x86: Clear hardware HLT state when userspace makes a vCPU not-halted

Kevin Wang (1):
      drm/amd/pm: populate unique ID for smu 13.0.7

Kexin Sun (1):
      wifi: mac80211: update outdated comment

Khasar Munkh-Erdene (1):
      staging: rtl8723bs: fix spacing around operators in rtw_recv.c

Kim Wooseok (1):
      wifi: rtl8xxxu: free RX skb when URB submission fails

Kir Kolyshkin (1):
      cgroup: fix cgroup.kill for exited thread group leader

Kiran K (2):
      Bluetooth: btusb: Preserve event and ACL packet ordering
      Bluetooth: btintel: Zero version data before parsing TLVs

Kiryl Shutsemau (Meta) (2):
      arm64: sdei: Run the event handler on the kernel vectors
      arm64: sdei: Preserve the interrupted context's exception registers

Koichiro Den (3):
      PCI: endpoint: pci-epf-vntb: Manage virtual NTB and PCI bus lifetime
      PCI: endpoint: pci-epf-vntb: Pass PF/VF number when BAR programming
      PCI: endpoint: pci-epf-vntb: Serialize virtual PCI bus scan

Konrad Dybcio (5):
      interconnect: qcom: icc-rpm: Handle icc_link_create() failures
      interconnect: qcom: use 64-bit SMD RPM bus votes
      clk: qcom: rcg2: Initialize shared floor clock state
      clk: qcom: rcg2: Propagate force-enable status errors
      clk: qcom: rcg2: Clear force enable after rate failure

Konstantin Khorenko (1):
      selftests/core: fix unshare_test with large fs.nr_open

Konstantin Komarov (4):
      ntfs3: fix info-leak in ntfs_rename()
      fs/ntfs3: load ATTR_BITMAP run extents from $MFT extension records
      fs/ntfs3: Fix memory leak in indx_find_sort()
      fs/ntfs3: validate EA entry layout against ef->size in ntfs_read_ea

Krunoslav Kovac (1):
      drm/amd/display: Send PQ bit in AMD VSIF

Kryštof Černý (1):
      w1: ds2482: add OF device match table

Krzysztof Karas (1):
      iommu/dma: Catch scatterlist length overflows

Krzysztof Kozlowski (9):
      drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure
      drm/msm/hdmi_bridge: Correct poweroff/audio cleanup order in post_disable
      drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
      dt-bindings: display/msm/dsi-phy: Add header with exposed clock IDs
      ARM: dts: qcom: msm8974: Use the header with DSI phy clock IDs
      ASoC: mediatek: mt8192: Handle component name prefix
      drm/msm: Properly handle msm_ioremap() without name
      dt-bindings: display/msm: hdmi: Correct name of disallowed supplies
      ASoC: samsung: Use snd_soc_substream_to_rtd() for accessing private_data

Krzysztof Wilczyński (4):
      PCI/sysfs: Pass the device name length in UTF-16 code units
      PCI/sysfs: Stop reporting _DSM failures as -EPERM
      PCI/sysfs: Handle a malformed _DSM result in acpi_attr_is_visible()
      PCI/sysfs: Decouple acpi_index from the optional device name element

Kuan-Wei Chiu (2):
      riscv, bpf: Add support for BPF_SDIV and BPF_SMOD in RV32 JIT
      riscv, bpf: Add support for BPF_MOVSX in RV32 JIT

Kui-Feng Lee (1):
      bpftool: Generated shadow variables for struct_ops maps.

Kumari Pallavi (1):
      misc: fastrpc: Rename phys to dma_addr for clarity

Kunhai Dai (1):
      blk-iocost: abort weight transfer on invalid donation weights

Kuninori Morimoto (3):
      ASoC: codec: max98926: fixup invert setup mask
      media: platform: microchip: use for_each_endpoint_of_node()
      ASoC: intel: avs: convert not to use asoc_xxx()

Kuniyuki Iwashima (2):
      tcp: Fix potential UAF in reqsk_timer_handler().
      ipmr: Call ipmr_fib_lookup() under RCU.

Kunwu Chan (1):
      rcutorture: Fix divide-by-zero with fwd_progress_div=1

Kyle Zeng (13):
      udf: validate extent partition references in udf_current_aext()
      fs/ntfs3: reserve NUL byte when converting UTF-16 names
      io_uring/io-wq: save worker type before dropping its reference
      affs: validate blocks before freeing them
      netfilter: nf_reject: initialize IPCB at inet ingress
      net/packet: check TX_RING fragments before memory accounting
      tcp: fix reordering addition overflow in MTU probing
      net/sched: sch_qfq: prevent aggregate self-replacement
      mm/page_vma_mapped: continue past nonmatching huge PMDs
      mptcp: pm: kernel: use RCU to free endpoint listeners
      mm/khugepaged: flush deferred unmaps before dropping a failed folio
      gro: do not GRO GSO packets with inconsistent payload
      tcp: avoid double destroy in tcp_abort() of an unaccepted child

Kylie C (1):
      drm/amd/display: Don't select zero V_TOTAL_MIN/MAX on seamless boot

Kyrylo Biryuk (1):
      ata: libahci: re-enable FBS after error handling on a port multiplier

Lachlan Hodges (1):
      wifi: cfg80211: include cf1 offset when sending chandef

Laurence Oberman (2):
      scsi: st: Restore changed drive settings after reset also for MTLOAD and MTRETEN
      scsi: st: Record the tape position after a successful MTLOAD

Laxman Acharya (1):
      Bluetooth: hci_event: fix out-of-bounds read in LE PA report reassembly

Laxman Acharya Padhya (2):
      wifi: rtw89: cap firmware section_num before parsing
      Bluetooth: btintel: propagate version TLV parsing errors

Lee Jones (5):
      HID: wacom: Use hdev->product in wacom_setup_touch_input_capabilities
      HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration
      HID: wacom: Fix Use-After-Free in wacom_intuos_pad
      HID: wacom: Fix Use-After-Free in wacom_bamboo_pad
      HID: wacom: Redesign shared sibling data lifecycle

Leizhen Zhang (1):
      gen_init_cpio: stop parsing on lines with a missing argument list

Len Brown (2):
      x86_energy_perf_policy: Fix optarg keyword matching
      x86_energy_perf_policy: Cleanup: Check fseek() in VM path

Leo Cheng (2):
      nvmem: layouts: sl28vpd: fix device_node reference leak in error path
      nvmem: layouts: onie-tlv: fix device_node reference leak in error path

Leo Liu (1):
      drm/amdgpu: cancel idle work in hw_init failure paths for vcn/uvd/vce/jpeg

Leon Romanovsky (6):
      RDMA/irdma: Preserve fast-registration IOVA on 32-bit
      PCI/P2PDMA: Safely terminate ACS redirect lists
      PCI/P2PDMA: Gate the host bridge whitelist warning on verbose
      RDMA/core: Preserve the selected source GID on failed AH modification
      RDMA/core: Free unpublished port statistics after initial-read failure
      RDMA/core: Reject LAG selection when source MAC lookup fails

Leonardo Costa (1):
      drm/bridge: tc358768: Enforce input bus flags via atomic_check

Li Jun (1):
      tpm: tpm_tis_spi: fix nodef CR50 tpm_tis_spi_resume is null

Li Qiang (1):
      Bluetooth: hci_bcsp: validate received packet lengths

Li RongQing (11):
      x86/ioperm: Prevent NULL dereference on theoretical missing IO bitmap
      RDMA/uverbs: Make CQ handle mandatory for WQ creation
      RDMA/restrack: Don't set RESTRACK_DD mark after a failed xa_insert()
      RDMA/uverbs: Drop restrack ref on ib_init_ucontext() failure in GET_CONTEXT
      RDMA/core: Fix partial copy of IPv6 flow_lbl in LAG hash skb
      RDMA/mlx5: Guard steering anchor resource destruction on create error
      RDMA/mlx5: Restore mr->pi_mr after temporary stack-local assignment
      IB/isert: Don't share drop_cmd_list across concurrent connection teardowns
      block, bfq: initialize active lists for all actuators
      RDMA/mlx5: Fix CQ resize destination index mask
      apparmor: avoid potential double free when remapping DFA tables

Li Xiasong (1):
      mm/slub: fix missing debugfs entries for caches created before sysfs init

Li Youhong (1):
      md/raid5: drain released_stripes before destroying the cache

Li Zetao (1):
      btrfs: convert read_key_bytes() to take a folio

Li Zhe (2):
      mm/hugetlb: fix mremap move length truncation
      mm/hugetlb: fix mremap deadlock when PMD sharing is possible

Liang Hao (1):
      timers: Clear pending_map on CPU hotplug

Lijo Lazar (3):
      drm/amdgpu: Add checks to vbios fetch through ATRM
      drm/amdgpu: Validate ATIF buffer length before use
      drm/amd/pm: validate vega10 profile mode inputs

Linkai Gong (7):
      media: i2c: tc358743: add missing color-space strings
      drivers/base/node: fix UAF on device_register() failure
      firmware: imx: dsp: fix mailbox channel leak on kasprintf failure
      misc: enclosure: fix UAF on device_register() failure
      clk: imx: composite-93: return timeout from gate enable
      mailbox: arm_mhuv2: time out if the receiver never comes up
      char: scx200_gpio: check cdev_add() return value

Linkui Xiao (1):
      net: bridge: netlink: do not clear the vlan info dump error

Linlin Yang (1):
      wifi: mt76: mt7996: fix PCI device reference leak in mt7996_pci_init_hif2()

Linmao Li (2):
      PCI: cadence: Store the core controller in platform drvdata
      power: supply: bq2515x: Propagate charge-enable read errors

Linus Torvalds (11):
      assoc_array: don't lose objects when a shortcut is split on a word boundary
      assoc_array: don't lose objects when a root shortcut is split at level 4
      assoc_array: move in-place insertion into a function of its own
      assoc_array: fill the segment cache in one place
      assoc_array: move node splitting into a function of its own
      assoc_array: move shortcut creation into a function of its own
      assoc_array: choose between splitting a node and a shortcut without gotos
      assoc_array: don't chain a new shortcut onto an existing one
      assoc_array: keep gc's cleanup out of the live tree on allocation failure
      vhost: vringh: use get_user()/put_user() for IOTLB 16-bit accesses
      vdpa_sim: disable page faults around vringh_need_notify_iotlb()

Linus Walleij (43):
      power: supply: ab8500_fg: Accept status from supplied power
      power: supply: ab8500_fg: Report sub-percent charge changes
      regulator: ab8500: Fix AB8505 VANA voltage selectors
      regulator: ab8500: Add AB8505 VAUX3 3.05 V setting
      regulator: ab8500: Handle AB8505 VINTCORE selector 7
      regulator: ab8500: Treat cut 1.0 VAUX3 as fixed
      regulator: ab8500: Test dedicated enable bits only
      regulator: ab8500: Propagate mode enable read errors
      dt-bindings: Add vendor prefixes
      ARM: dts: gemini: Use a level-high interrupt for TVE200
      dt-bindings: power: supply: ab8500: Add AB8505 charger
      power: supply: ab8500_btemp: Fix event temperature reporting
      power: supply: ab8500: Preserve battery termination current
      power: supply: ab8500_charger: Fix AC charger re-enable
      power: supply: ab8500_charger: Decode AB8505 USB status
      power: supply: ab8500_charger: Respect AB8505 register layout
      power: supply: ab8500_charger: Handle detection errors
      power: supply: ab8500_charger: Skip absent AB8505 main charger
      power: supply: ab8500_charger: Retry AB8505 USB detection
      power: supply: ab8500_charger: Recover inactive AB8505 charger
      power: supply: ab8500_fg: Finalize current measurements
      power: supply: ab8500_fg: Avoid reserved AB8505 CCConf bit
      ARM: dts: ux500: Use AB8505 charger compatible
      dmaengine: ste_dma40: Fix physical cyclic capability
      dmaengine: ste_dma40: Fix failed start cleanup
      dmaengine: ste_dma40: Fix probe runtime PM disable
      dmaengine: ste_dma40: Check runtime PM in IRQ
      dmaengine: ste_dma40: Handle runtime PM resume errors
      dmaengine: ste_dma40: Return IRQ_NONE when no interrupt is pending
      dmaengine: ste_dma40: Fix probe IRQ leak
      dmaengine: ste_dma40: Fix LCLA allocation order
      dmaengine: ste_dma40: Fix probe LCLA free
      dmaengine: ste_dma40: Put the LCPA SRAM node
      dmaengine: ste_dma40: Fix memcpy channel parsing
      dmaengine: ste_dma40: Validate disabled channel indexes
      dmaengine: ste_dma40: Validate DMA specifier length
      dmaengine: ste_dma40: Reject direction changes after allocation
      dmaengine: ste_dma40: Fix logical channel bounds check
      dmaengine: ste_dma40: Fix event group bounds
      dmaengine: ste_dma40: Fix V4B event group mapping
      dmaengine: ste_dma40: Validate fixed physical channel indexes
      dmaengine: ste_dma40: Validate memcpy configuration
      dt-bindings: dma: dma40: Restore disabled-channels

Liu Changjie (1):
      can: peak_usb: pcan_usb_fd_decode_buf(): accept short uCAN end-of-list records

Liu Chao (2):
      usb: fotg210: validate endpoint index in ep0 handlers
      net: wwan: iosm: validate msg_head before indexing msg_ring

Liu Dalin (2):
      rtc: ftrtc010: fix clock resource leak on probe failure
      rtc: ftrtc010: fix integer overflow in time calculation

Liu Zhenlong (1):
      i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()

Liz Fong-Jones (1):
      writeback: keep cleanup_offline_cgwb()'s scan out of syncs

Loc Nguyen (1):
      KVM: x86: Request event processing for exception VM-Exits

Logan Gunthorpe (4):
      PCI: switchtec: Add Microchip PCI1008 device ID
      PCI: switchtec: Add Microchip PCI1008 to NTB DMA alias quirk
      dmaengine: ioat: disable relaxed ordering before registering the device
      dmaengine: plx_dma: fix NULL pointer deref in plx_dma_isr()

Logan Odell (1):
      PCI/IOV: Read VF config values that need not match PF

Long Zhao (1):
      dt-bindings: vendor-prefixes: add Ambarella

Longlong Xia (3):
      zsmalloc: account for handle size in class lookup
      mm/hugetlb: do not dissolve gigantic pages without runtime support
      rcu: fix shrink budget underflow in lazy_rcu_shrink_scan

Lorenzo Stoakes (ARM) (11):
      HID: picoLCD: check for fb_deferred_io_init() error
      fbdev: ssd1307fb: check for fb_deferred_io_init() error
      fbdev: xen-fbfront: check for fb_deferred_io_init() error
      fbdev: udlfb: check for fb_deferred_io_init() error
      fbdev: smscufx: check for fb_deferred_io_init() error
      fbdev: sh_mobile_lcdc: check for fb_deferred_io_init() error
      mm/mremap: correctly uncharge accountable VMAs in error path
      mm/vma: avoid broken uffd merge on mremap
      mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
      mm/vma: avoid spurious write locks when mm->mm_lock_seq overflows
      ALSA: us122l: mark hwdep mappings VM_MIXEDMAP

Lu Yao (1):
      drm/i915/gem: Reset err for each fence entry

Luca Leonardo Scorcia (1):
      clocksource/drivers/timer-mediatek: Fix random crash at boot

Luca Weiss (1):
      ARM: dts: qcom: msm8974: Sort header includes alphabetically

Lucas Costa (1):
      staging: sm750fb: free cmap on framebuffer release

Lucas De Marchi (1):
      drm/panel: Fix build error on !CONFIG_OF

Lucas Martins Alves (1):
      usb: musb: host: clear stale RX interrupt on three-strikes error

Lucas Stach (1):
      drm/etnaviv: check all modules for idle after reset

Lucas Tanure (2):
      drm/vc4: hdmi: always cancel the scrambling work synchronously
      drm/vc4: hdmi: enable scrambling before the TMDS clock starts

Luigi Lauro (1):
      drm/amd/display: take a runtime PM reference only when a CRTC turns on

Luis Banha (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion 15-ec1xxx

Luis Gerardo Lopez Hernandez (1):
      ALSA: hda/realtek: Fix internal speakers on Acer Aspire AL16-31P

Luiz Augusto von Dentz (2):
      Bluetooth: MGMT: Fix pending state of instances added without HCI traffic
      Bluetooth: MGMT: Fix leaking instance on Add Extended Advertising Parameters

Luka Gejak (1):
      wifi: rtw88: sdio: zero the padding added to a TX transfer

Lukas Wunner (4):
      PCI/AER: Fix mapping of errors to agent & layer
      PCI/AER: Emit TLP Log only for unmasked errors
      driver core: Add device_show_string() helper for sysfs attributes
      platform/x86: Use device_show_string() helper for sysfs attributes

Luo Jie (1):
      bitfield: Add FIELD_MODIFY() helper

Luxiao Xu (2):
      smb: client: fix buffer overflow in SMB2_tcon()
      mm/memory: constrain generic_access_phys() to page boundary

Ma Ke (4):
      ASoC: wcd9335: Fix device reference leak in wcd9335_slim_status()
      pinctrl: stm32: Fix fwnode reference leak in stm32_gpiolib_register_bank()
      platform/x86/amd/pmc: Fix RTC reference leak in amd_pmc_verify_czn_rtc()
      i2c: acpi: Fix adapter reference leak in i2c_acpi_new_device_by_fwnode()

Maciej Kucharek (3):
      drm/amdgpu: reset CIK ASIC on Apple boards with VRAM at 0
      drm/amdgpu: reset VI ASIC on Apple boards with VRAM at 0
      drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0

Maciej W. Rozycki (1):
      PCI: Skip Target Speed quirk on clamped ports with no link

Magnus Lindholm (10):
      alpha: run check_mmu_context() from finish_arch_post_lock_switch()
      alpha: only use a targeted tbi() when the target mm is really current
      alpha: invalidate the local context in flush_tlb_page()
      alpha: fix the local TLB invalidate in flush_tlb_page()
      alpha: fix the local TLB invalidate in the UP flush_tlb_page()
      alpha: invalidate the local context in flush_tlb_mm()
      alpha: invalidate the local context in flush_icache_user_page()
      alpha: do not clear remote MMU contexts in migrate_flush_tlb_page()
      alpha: do not skip TLB shootdown IPIs for kthread-borrowed mms
      alpha: load the MMU context when switch_mm() switches the current task

Mahe Tardy (1):
      bpf: fix cgroup_skb prog test run direct packet access

Manikanta Pubbisetty (1):
      wifi: ath10k: trigger hardware recovery upon rx failures

Manivannan Sadhasivam (1):
      PCI: qcom: Honor IOMMU provider's #iommu-cells in qcom_pcie_config_sid_1_9_0()

Manush Prajwal (1):
      pwm: lp3943: fix NULL pointer dereference for an unconfigured channel

Marc Kleine-Budde (4):
      spi: spi-sun4i: sun4i_spi_transfer_one(): fix transfers for SUN4I_FIFO_DEPTH
      spi: spi-sun4i: sun4i_spi_fill_fifo(): always apply A10 FIFO fill level workaround
      spi: spi-sun4i: sun4i_spi_transfer_one(): fix setting of clock rate
      spi: spi-sun4i: sun4i_spi_handler(): fix race condition between transfer completion and RX FIFO interrupt

Marc Zyngier (4):
      KVM: arm64: Move OUTSIDE_GUEST_MODE publication past context being saved
      KVM: arm64: Turn vcpu->arch.pause into a counter
      KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded
      KVM: arm64: vgic: Stop the target vcpu when disabling LPIs

Marcel Hofmann (1):
      remoteproc: imx_rproc: Allow mappings ending at region boundary

Marco Crivellari (2):
      nvmet: replace use of system_wq with system_percpu_wq
      regulator: irq_helper: replace use of system_wq with system_dfl_wq

Marco Scardovi (1):
      platform/x86: asus-wmi: Serialize WMI method evaluations with a mutex

Marco Ziliani (1):
      ata: libata-pmp: disable the SEMB port on Marvell 88SM9705

Marek Czernohous (4):
      drm/nouveau: cancel the DP IRQ work before freeing the connector
      drm/nouveau: don't dereference outp before checking it in nouveau_dp_irq
      drm/nouveau/pci: use config-space MSI rearm on MCP79/MCP7A (NVAC)
      drm/nouveau: disable the fence uevent work instead of just cancelling it

Marek Szyprowski (8):
      mmc: dw_mmc: stop and complete DMA also in STATE_DATA_BUSY state
      ARM: 9519/1: dma-mapping: Fix wrong free function in __iommu_alloc_simple() error path
      ASoC: wm8994: fix MCLK gating for AIF clocks sourced from MCLK2
      ASoC: wm8994: don't lose the AIF clock ratio when staying at 32kHz SYSCLK
      ASoC: wm8994: fix MCLK index used for setting MCLK rate
      ASoC: samsung: midas_wm1811: run FLL1 at the AIF1 configured rate when idle
      ASoC: wm8994: follow AIF clock source changes in MCLK gating
      clk: samsung: Revert "clk: Use device_get_match_data()"

Marek Vasut (3):
      drm: of: Fix drm_of_get_data_lanes_count_ep() return value documentation
      ARM: dts: stm32: Drop bias-disable from STM32MP15xx DHCOM SoM sdmmc1_b4_pins_a
      dt-bindings: vendor-prefixes: Add Retronix Technology Inc.

Mariano Baragiola (1):
      wifi: wilc1000: validate monitor transmit frame headers

Mario Limonciello (6):
      drm/amd/display: don't WARN when removing an unallocated MST payload
      platform/x86/amd/pmf: Add AMDI0112 ACPI ID
      cpufreq/amd-pstate: Export symbols for changing modes
      cpufreq: amd-pstate: Restore previous mode when changing driver mode fails
      cpufreq: amd-pstate: Propagate cppc_set_auto_sel() errors on mode change
      cpufreq/amd-pstate-ut: Don't check for highest perf matching on prefcore

Mario Peter (1):
      driver core: take parent lock in async device attach

Mark Anthony Agarro (2):
      wifi: mt76: mt76x02: validate TX-status rate index before mac80211 handoff
      wifi: mt76: mt7615: do not tear down BSS/STA state for monitor vifs

Mark O'Donovan (1):
      nvme-auth: add flag for bi-directional auth

Mark Rutland (1):
      arm64: percpu: Fix LSE operations on {8,16}-bit types

Mark Zhang (1):
      RDMA/mlx5: Support driver APIs pre_destroy_cq and post_destroy_cq

Markus Probst (3):
      rtc: s35390a: Add missing newline to dev_err
      rtc: s35390a: Fix alarm not disabling
      rtc: s35390a: Read 24-hour mode on access

Martin Belanger (1):
      nvme: make the DH-HMAC-CHAP secret attributes readable by root only

Martin Fuzzey (1):
      serial: sc16is7xx: fix data corruption due to unexpected xon/xoff

Martin Wilck (1):
      md/raid5: validate payload size before calculating payload_len

Masafumi Suzuki (1):
      sctp: account for chunk padding in sctp_init_cause()

Masahiro Yamada (3):
      kconfig: remove unneeded symbol_empty variable
      kconfig: default to zero if int/hex symbol lacks default property
      kconfig: initialize sym->curr.tri to 'no' for all symbol types again

Masami Hiramatsu (Google) (4):
      tracing/probes: Fix BTF kflag check for anonymous struct member access
      tools/bootconfig: Cleanup bootconfig footer size calculations
      tools/bootconfig: Fix integer overflow and truncation in size checks
      x86/mce: Fix hardware debug register corruption on task migration

Matheus Alves de Almeida (2):
      fat: hold truncate_lock in fat_write_failed()
      HID: wacom: fix wacom_intuos_irq NULL pen_input deref

Matt Turner (5):
      alpha: run the remote RTC access in a worker, not an IPI callback
      lib/decompress_bunzip2: fix off-by-one in run-length bounds check
      alpha: handle VM_FAULT_HWPOISON in do_page_fault()
      alpha: determine tininess after rounding in the FP emulation
      alpha: select SYSCTL_EXCEPTION_TRACE

Matthew Jacob (1):
      drm/amdgpu: Support some Barco AMD based graphics adapters

Matthew Maurer (7):
      module: Factor out elf_validity_ehdr
      module: Factor out elf_validity_cache_sechdrs
      module: Factor out elf_validity_cache_secstrings
      module: Factor out elf_validity_cache_index_info
      module: Factor out elf_validity_cache_index_mod
      module: Factor out elf_validity_cache_index_sym
      module: Factor out elf_validity_cache_index_str

Matthew Wilcox (Oracle) (5):
      mm: call wp_page_copy() under the VMA lock
      mm: make lock_folio_maybe_drop_mmap() VMA lock aware
      ntfs3: Convert attr_wof_frame_info() to use a folio
      ntfs3: Remove calls to set/clear the error flag
      ntfs: Do not kmap page cache pages for compression

Matthias Goergens (7):
      fanotify: report names longer than NAME_MAX
      udf: don't let the extent type hide an exhausted free-space table extent
      udf: check the unallocated space table when it is loaded
      udf: fix preallocation discarding before an empty allocation extent
      udf: don't use eloc after the end of the unallocated space table
      x86/hibernate: Ignore page-zero RAM in E820 checksum
      isofs: return long Joliet names whole

Matthieu Baerts (NGI0) (2):
      mptcp: options: mpc: avoid printing uninit data
      mptcp: options: dss: avoid printing uninit csum

Matti Vaittinen (1):
      iio: accel: kionix-kx022a: Fix IPOL macro name

Matus Gajdos (1):
      ALSA: usb-audio: Add native DSD support for Cambridge Audio streamers

Mauricio Orozco (1):
      ALSA: hda/realtek: Add quirk for ASUS VivoBook M515DA/X515DAP

Maurizio Casciano (1):
      power: supply: core: Honor supplied-from with CONFIG_OF=y

Maurizio Lombardi (1):
      nvme-fc: do not warn on controller removal race

Max Kellermann (2):
      ceph: avoid pending truncate during nonblocking cap acquire
      ceph: remove unused field `i_cap_migration_resv`

Maxim Skokov (2):
      media: vivid: round the height down to the vertical subsampling factor
      bpf: test_run: Fix false -EBADMSG after skb leaves CHECKSUM_COMPLETE

Maxime Bélair (2):
      apparmor: report a label allocation failure as -ENOMEM
      apparmor: convert duplicated dfa transitions to match_char()

Maíra Canal (1):
      drm/vc4: Publish the output fence outside of job_lock

Md Rabbani (1):
      net: stmmac: fix device node reference leaks in stmmac_mtl_setup()

Mehmet Aysel (1):
      ASoC: amd: acp-config: Add HVY-WXX9/M1060 DMI quirk

Mehmet Fide (4):
      wifi: rtw88: usb: route bmc frames via the high queue only for DTIM delivery
      wifi: rtw88: usb: bound what the driver feeds the after-DTIM queue
      wifi: rtw88: usb: only let the frames a dozing station needs use the after-DTIM queue
      wifi: rtw88: widen the ATIM window while an AP interface is up

Melissa Wen (5):
      drm/amd/display: Signal PQ EOTF in FreeSync infopacket for DP HDR
      drm/amd/display: assign missing trace entry in amdgpu_dm_dc_clocks_state
      drm/amd/display: remove duplicated prev_p_state_change_support assignment
      drm/amd/display: fix vready offset assignment in dcn_optc_lock_unlock_state
      drm/amd/display: use right type for amdgpu_dc_performance event entries

Meng Li (1):
      cpufreq: amd-pstate: Update amd-pstate preferred core ranking dynamically

Michael Auer (1):
      ASoC: qcom: sdm845: Disable the quaternary MI2S bit clock on shutdown

Michael Bommarito (1):
      9p/trans_virtio: reject mount tags longer than NAME_MAX at probe

Michael Freidkin (1):
      media: meson: vdec: size capture planes from the aligned canvas

Michael Kelley (1):
      Documentation: hyperv: Update documentation for sending VMBus packets

Michael Liang (1):
      fault-inject: fix dentry leak

Michael S. Tsirkin (1):
      virtio: synchronize callbacks after device reset

Michael Straube (3):
      staging: rtl8723bs: remove return from void function
      staging: rtl8723bs: remove wrapper rtw_init_recv_timer
      staging: rtl8723bs: move rtw_recv_indicatepkt to rtw_recv.c

Michael Wyraz (1):
      USB: serial: option: add support for ASR 1286:4e3c modem

Michail Andreas Michalopoulos (3):
      ksmbd: accept share config responses from ksmbd-tools before 3.5.3
      ksmbd: reject FILE_ATTRIBUTE_TEMPORARY on directories
      ksmbd: select CRYPTO_AES

Michail Tatas (3):
      USB: misc: uss720: Fix leak in get_1284_register
      ipmi: Fix leak in __ipmi_bmc_register
      media: verisilicon: rockchip: Fix leaks in init

Michal Pecio (2):
      ALSA: usx2y: Stop clearing urb->hcpriv before submission
      usb: xhci: Fix bounce buffer overflow

Mike Christie (3):
      scsi: target: Move I/O path stats to per CPU
      scsi: target: Fix LUN/device R/W and total command stats
      vhost-scsi: Reduce mem use by moving upages to per queue

Mike Rapoport (Microsoft) (1):
      mm/cma: accept memory of CMA areas reserved at a fixed address

Mike Snitzer (3):
      pNFS/flexfiles: honor FF_FLAGS_NO_IO_THRU_MDS over the mdsthreshold hint
      pNFS/flexfiles: don't read through MDS when previous layout forbid it
      pNFS/flexfiles: don't reset to MDS for v4 error when previous layout forbid it

Mike Tipton (1):
      pmdomain: qcom: rpmhpd: Skip retention by default

Mikhail Gavrilov (1):
      drm/amd/display: set allow_freesync before validating a new stream

Mikhail Lobanov (1):
      wifi: ath11k: modify null check logic in ath11k_ce_rx_post_pipe()

Mikko Perttunen (4):
      gpu: host1x: Wait for timeout worker completion on channel free
      drm/tegra: Fix syncobj_in wait return value check
      drm/tegra: Don't pass an ERR_PTR to drm_syncobj_replace_fence()
      drm/tegra: Drop reference on postfence

Mikulas Patocka (12):
      dm-integrity: fix NULL pointer dereference when the 'R' flag is used
      dm-integrity: validate the superblock on resume
      dm: fix a bug in dm_accept_partial_bio
      dm-writecache: report I/O error if flush failed
      dm-writecache: fix a quirk in statistics
      dm-writecache: fix a crash if we attempt to use non-dax device
      dm-writecache: fix uncommitted_blocks underflow
      dm-writecache: fix REQ_FUA processing
      dm-snapshot: fix crash if dm_io_client_create fails
      dm-bufio: fix a race leading to an unsigned integer underflow
      dm-bufio: fix non-working memory limit
      dm-snapshot: make the chunk list sorted by the chunk number

Milan Milicevic (2):
      drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts for navi10_ih
      drm/amdgpu: publish IH enabled before PSP programs IH_RB_CNTL

Miles Krause (2):
      memory: emif: fix device_node reference leak on np_ddr
      leds: lp8860: Fix device_node leak in lp8860_probe()

Minghao Zhang (1):
      netfilter: conntrack: tcp: use UNACK timeout for non-closing RST packets

Mingming Cao (4):
      ibmveth: fix netpoll races with RX replenish
      ibmveth: return the error when set_channels cannot add TX queues
      ibmveth: wait for in-flight transmits in ibmveth_close()
      ibmveth: wait for the RX poll to return before freeing the RX queue

Mingxuan Guo (1):
      firmware: cs_dsp: clear dsp->running on the cs_dsp_run() error path

Miquel Raynal (7):
      spi: cadence-qspi: Fix status polling with octal DTR chips
      mtd: spi-nor: Unprepare legacy controllers upon RWW wait interruption
      dt-bindings: clock: ma35d1: Document the missing crystal inputs
      clk: nuvoton: ma35d1: Keep the clock count in the driver
      dt-bindings: clock: ma35d1: Drop CLK_MAX_IDX define
      dt-bindings: clock: ma35d1: Add missing WDT/WWDT parent clocks
      clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks

Miquel Raynal (DAVE) (2):
      mtd: rawnand: pl353: Make sure we use the monolithic helpers for raw accesses
      mtd: rawnand: pl353: Fix debug prints

Miquel Raynal (Schneider Electric) (1):
      clk: Use the generic OF phandle parsing in only one place

Misha Nasledov (1):
      drm/amd/display: Drop clock requirements on DCN32 when no displays are active

Mohamad Raizudeen (3):
      crypto: amlogic - Fix IRQ handler return value and fallthrough logic
      crypto: amlogic - Fix DMA memory leak in cipher error path
      PCI: Fix out-of-bounds MMIO read in nvme_disable_and_flr()

Mohammed Alquraini (1):
      ksmbd: reject foreign RPC pipe handles on IPC$ read and write

Mohd Ayaan Anwar (1):
      arm64: dts: qcom: lemans-ride-common: fix SerDes PHY regulator supplies

Mohit Sharma (1):
      ASoC: qcom: q6apm: Guard callbacks until probe data is ready

Muchun Song (2):
      block: remove redundant explicit memory barrier from rq_qos waiter and waker
      block: introduce init_wait_func()

Muhammad Bilal (11):
      platform/x86: hp-bioscfg: fix slab-out-of-bounds write in hp_convert_hexstr_to_str()
      platform/x86: hp-bioscfg: fix 16-byte heap overflow for empty auth token
      platform/x86: hp-wmi: fix heap OOB read and memory corruption in hp_wmi_perform_query()
      platform/x86: hp-bioscfg: fix OOB reads in hp_get_string_from_buffer()
      platform/x86: hp-bioscfg: fix non-ASCII truncation in hp_get_string_from_buffer()
      platform/x86: hp-bioscfg: return -E2BIG from validate_password_input()
      platform/x86: hp-bioscfg: allow clearing current_password
      platform/x86: hp-bioscfg: NUL-terminate the SPM auth token
      platform/x86: hp-bioscfg: fix off-by-one in password length check
      platform/x86: hp-bioscfg: validate SPM state returned by firmware
      platform/x86: hp-bioscfg: fix oops on short integer attribute buffer

Muhammad Saheed (1):
      Bluetooth: hci_sync: Disable legacy instance's ext adv before setup snapshot

Muhtasham Nawr al-Mahmud (1):
      ALSA: hda/realtek: Fix speakers on ASUS PM3406CHA

Mukesh Ojha (3):
      iommu/qcom: Check pm_runtime_resume_and_get() return in probe
      iommu/qcom: Enable clocks before hardware access in qcom_iommu_ctx_probe()
      iommu/qcom: Publish pgtbl_ops before releasing init_mutex

Muzaffer Kadir (1):
      dt-bindings: vendor-prefixes: Add General Mobile

Myeonghun Pak (29):
      media: cx88: Disable PCI device on MPEG initialization failure
      backlight: lm3630a: Cancel delayed work before destroying workqueue
      media: cx23885: unregister DVB bus when SP2 CI setup fails
      media: marvell: manage the MMP camera clock provider
      media: go7007: unregister the I2C adapter on USB probe failure
      media: cx18: Disable PCI device on probe failure
      media: tw68: balance PCI enable on cleanup
      mtd: maps: pci: balance PCI enable on cleanup
      media: amphion: drain message work before releasing core state
      media: amphion: prevent unbind while video instances are open
      soc: fsl: dpio: Fix cleanup on IRQ registration failure
      soc: fsl: dpio: Free the IRQ before releasing the I/O object
      ASoC: stm: stm32_i2s: request IRQ after regmap initialization
      mfd: twl-core: Unregister the auxiliary platform device on unbind
      leds: ktd2692: Pass context to regulator cleanup
      wifi: mt76: mt7615: restore DBDC state after ext PHY failure
      fbdev: nvidia: Release write-combining handle on probe failure
      hwmon: (sht15) Stop deferred work before releasing its resources
      fbdev: kyro: Release WC setup on registration failure
      staging: rtl8723bs: disable SDIO function on block size failure
      dmaengine: mediatek: hsdma: fix runtime PM leak on init failure
      interconnect: exynos: Remove the PM QoS request on unbind
      mfd: intel_quark_i2c_gpio: Manage the fixed-rate clock
      mfd: da9150: Balance IRQ wake on teardown
      PCI: aardvark: Disable PHY on probe failures
      clk: ti: adpll: unregister OF clock provider on remove
      fbdev: gxt4500: Release WC setup on probe failure
      net: hix5hd2: serialize timeout recovery with interface teardown
      platform/x86: gpd pocket fan: Cancel work before releasing GPIOs

Naman Jain (1):
      x86/init: Initialize wall clock in get_rtc_noop()

Namhyung Kim (2):
      tools/lib/api: Fix potential double-free from fdarray__grow()
      perf c2c: Fix memory leaks on output fields

Namjae Jeon (18):
      ksmbd: wait for negotiation before receiving another PDU
      ksmbd: protect private extended attributes
      ksmbd: preserve access denied status for copychunk
      ksmbd: allow I/O on directory named streams
      ksmbd: return buffer too small for short security queries
      ksmbd: handle empty QUERY_ALLOCATED_RANGES output
      ksmbd: honor byte-range locks for zero data
      ksmbd: allow FSCTL_SET_SPARSE without input buffer
      ksmbd: fix SMB2 byte-range lock end offset
      ksmbd: reject blocking compound lock requests
      ksmbd: honor client signing-required in all modes
      ksmbd: notify parent directory leases on child create
      ksmbd: enable TCP keepalive for accepted connections
      ksmbd: handle allocated range queries on dense files
      ksmbd: fix extended session security negotiation for raw NTLMSSP
      ksmbd: validate security descriptor offsets before pointer arithmetic
      ksmbd: prevent stale data from being written by SMB2 WRITE requests
      ksmbd: prevent share root removal through empty paths

Nandor Kracser (1):
      tls: avoid field-spanning write when copying crypto info

Nanzhe Zhao (2):
      f2fs: read i_size once in f2fs_vm_page_mkwrite
      f2fs: remove mappedtodisk flag usage in mmap write path

Nas Chung (1):
      media: v4l2-common: Fix P010 format info

Nathan Chancellor (1):
      wifi: brcmsmac: Adjust txpwrindex value in nphy_ipa_rxcal_gaintbl_2GHz

Naveen Kumar Chaudhary (1):
      kdb: unify CMD_BUFLEN definition into kdb_private.h

Navon John Lukose (1):
      i2c: designware: queue only one read command for block reads

Neil Andrews (1):
      ALSA: usb-audio: Rename the Audient iD14 monitor mix volume control

Neil Armstrong (1):
      dt-bindings: vendor-prefixes: add vendor prefix for Nexperia B.V.

NeilBrown (1):
      nfsd: honour client-provided attributes for NFS4_CREATE_EXCLUSIVE4_1

Nguyen Ngoc Thang (4):
      net/rds: ib: don't enable IRQs in rds_ib_conn_free()
      md: take reconfig_mutex when enabling PPL on an inactive array
      ocfs2: validate chunk and block counts of the local quota file
      libceph: reject bad connect_seq in msgr1 READY reply

Nguyen Quang Le Kien (1):
      usb: gadget: fix refcount underflow in gadgetfs_bind() error path

Nguyễn Văn Cao Nguyên (1):
      RDMA/irdma: Do not move a fresh RoCE QP to ERROR on RESET

Nick Huang (1):
      rtc: s35390a: use u8 instead of char for register buffer

Nickolai Zeldovich (8):
      resource: report a devm_request_resource() conflict under the lock
      ucount: take the rlimit reference before checking the limit
      mm/mlock: use a long for the page count in mlock_fixup()
      proc/kcore: advance the vmalloc retry by the last copy, not the total
      nsproxy: Fix cred leak in the error path of prepare_nsset()
      splice: retry tee() instead of returning 0 when it races
      ucount: read the parent ucounts before dropping the rlimit count
      fs_pin: do not trust the pin after a spurious wakeup in pin_kill()

Nicolai Buchwitz (9):
      serial: amba-pl011: keep transmitter enabled when disabling RS485
      net: selftests: use skb_share_check() in the loopback receive hook
      net: stmmac: selftests: use skb_share_check() in the loopback receive hook
      net/mlx5e: use skb_share_check() in the loopback selftest hook
      net: usb: cdc_ncm: don't enable BHs in tx_fixup under netpoll
      net: usb: cdc_mbim: don't enable BHs in tx_fixup under netpoll
      net: bcmgenet: recover from a failed resume
      net: bcmgenet: restore the Tx coalescing setting when the rings are rebuilt
      net: bcmgenet: stop Tx NAPI before disabling the queues

Nicolas Escande (1):
      wifi: ath11k: fix locking problem in ath11k_dp_rx_tid_del_func()

Nicolas Morey (1):
      RDMA/rxe: Use validated num_sge in local buffer

Nicolas Schier (1):
      kconfig: tests: Provide defconfig outfile for savedefconfig

Nicolo Giuliani (1):
      dt-bindings: vendor-prefixes: Add Sophos

Nikhil P. Rao (1):
      ionic: fix port_info use-after-free on firmware recovery

Nikhil Solanke (1):
      usb: core: Add quirk for 255-bytes initial config read

Niklas Cassel (7):
      ata: sata_fsl: Fix use-after-free of host_priv on probe() failure
      ata: ahci_st: Do not ignore errors when getting the reset controls
      ata: ahci_st: Assert the power down reset in the probe() error path
      ata: ahci: print the lpm policy on boot
      ata: libahci: Free the IRQs when activating a multi-IRQ host fails
      ata: libata: Do not leave ata_host_stop() registered when activation fails
      scsi: scsi_debug: Refuse a negative physblk_exp

Niko Huuskonen (2):
      ALSA: caiaq: Serialize access to the EP1 command buffer
      ALSA: caiaq: Fix the Kore controller key map

Nikolaj Klitlund Børty (1):
      Bluetooth: btusb: Add device ID for Realtek RTL8761BUE (StarTech AV53C1)

Nikolaos Karaolidis (2):
      fs: rotate inodes whose page cache could not be dropped
      fs: don't lose inodes that another LRU walker is isolating

Nikolay Borisov (1):
      ata: sata_dwc_460ex: Don't enable interrupt if libATA core registration fails

Nilesh Javali (1):
      scsi: qla2xxx: Clamp max_npiv_vports to VP_CTRL bitmap capacity

Nirmoy Das (1):
      blk-mq: clear stale inactive flag on hctx reuse

Nizar Al-Kabbani (1):
      platform/x86: asus-nb-wmi: map ProArt key (0x8b) to KEY_PROG3

Noam D. Eliyahu (1):
      tg3: Invert restart quirk logic to restrict SNP power-down bypass

Nora Schiffer (1):
      ARM: dts: imx7-tqma7: correctly specify PMIC voltage constraints

OGAWA Hirofumi (1):
      fat: fix fat_ent_write() for reverting the value

Oleg Keri (1):
      drm/msm/dp: don't report link training success after a reinit

Oleg Nesterov (1):
      signalfd: don't dequeue the forced fatal signals

Oleg Proshkin (1):
      mfd: axp20x: Preserve other control bits when powering off

Oleksij Rempel (1):
      regulator: fixed: add support for under-voltage IRQ

Oliver Hartkopp (5):
      can: isotp: check the return values of can_rx_register() in isotp_bind()
      can: proc: skip stats calculation after reset in can_stat_update()
      can: replace ARPHRD_CAN type checks with can_get_ml_priv()
      can: protect the receive lists with a per-device lock
      can: raw, isotp: copy socket options outside of lock_sock()

Oliver Neukum (1):
      usb: misc: cypress_cy7c63: check result of IO

Olivier Kaloudoff (2):
      ALSA: usb-audio: Add mic resolution quirk for Logitech Webcam C200
      drm/amdkfd: stop restore retries on device unplug

Omar Ramadan (1):
      amt: pull the AMT header behind the transport header in amt_parse_type()

Orgad Shaneh (4):
      mtd: cfi_cmdset_0002: cap the write-buffer chunk at 256 bytes on an x8 device
      MIPS: mm: do not write a huge TLB entry when the probe misses
      staging: octeon: schedule the TX cleanup tasklet every 1024th packet
      MIPS: Octeon: size the swiotlb for a modular OHCI platform driver

Oswald Buddenhagen (5):
      ALSA: emux: prune unused parameter from snd_soundfont_load_guspatch()
      ALSA: emux: fix validation of snd_emux.num_ports
      ALSA: emu10k1: prune vestiges of SNDRV_SFNT_SAMPLE_{BIDIR,REVERSE}_LOOP support
      ALSA: emux: centralize & improve patch info validation
      ALSA: emux: simplify snd_sf_list.callback handling

Ovidiu Panait (1):
      spi: rspi: Fix DMA mode when the DMA controller is built as a module

Pablo Neira Ayuso (5):
      netfilter: nf_tables: call skb_valid_dst() before skb_dst()
      netfilter: nf_conntrack_expect: add and use nf_ct_expect_related_pair()
      netfilter: ctnetlink: do not expose expectation DEAD flag
      netfilter: conntrack: always lower timeout for non-closing RST packets
      netfilter: flowtable: ensure sufficient headroom in xmit path

Pali Rohár (4):
      cifs: Remove duplicate struct reparse_symlink_data and SYMLINK_FLAG_RELATIVE
      cifs: Remove struct reparse_posix_data from struct cifs_open_info_data
      cifs: Rename struct reparse_posix_data to reparse_nfs_data_buffer and move to common/smb2pdu.h
      cifs: Update description about ACL permissions

Palla Raghunath (1):
      nvmet-fc: don't drop the last assoc reference in nvmet_fc_delete_ctrl()

Pankaj Gupta (1):
      KVM: SEV: Drop FOLL_WRITE for encrypted region registration

Paolo Abeni (2):
      mptcp: fix subflow bitfield misuse
      gtp: hold RCU in gtp_genl_send_echo_req()

Parker Newman (2):
      serial: exar: add optional board_init function
      serial: exar: fix checkpach warnings

Patrick Oppenlander (1):
      rpmsg: virtio: EPOLLOUT support

Paul Chaignon (3):
      bpf: Refactor cleanup of bpf_prog_test_run_skb
      bpf: Reorder bpf_prog_test_run_skb initialization
      bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN

Paul Dolan (1):
      selftests/clone3: tighten CLONE_CLEAR_SIGHAND conflict test

Paul E. McKenney (2):
      srcu: Add NUM_ACTIVE_SRCU_POLL_OLDSTATE
      sh: Emulate one-byte cmpxchg

Paul Mbewe (1):
      serial: sc16is7xx: refill TX FIFO below trigger using fresh TXLVL

Paul Moses (3):
      xsk: restore UMEM flags after failed pool assignment
      perf mmap: Use the head selected by read_init
      perf mmap: Preserve the consumed cursor in forward mode

Paul Sajna (1):
      arm64: dts: qcom: sdm845-lg: fix sdcard pinctrl nodes

Pauli Virtanen (4):
      ALSA: usb-audio: add volume quirks for MS LifeChat LX-3000
      Bluetooth: L2CAP: take chan->lock for l2cap_chan_add/ready/del
      Bluetooth: L2CAP: hold l2cap_conn::lock in l2cap_connect_cfm()
      Bluetooth: L2CAP: hold chan in l2cap_ecred_conn_rsp()

Paulo Alcantara (11):
      smb: client: fix uid/gid override in getattr with posix extensions
      smb: client: fix WSL reparse point uid/gid override
      smb: client: fix file type corruption in posix_reparse_to_fattr()
      smb: client: fix unaligned access in WSL reparse point parser
      smb: client: fix fattr leaking on wsl_to_fattr() failure
      smb: client: discard post-EOF pagecache when extending a file via clone range
      smb: client: flush and commit data before querying allocated ranges
      smb: client: flush dirty data before zeroing a range
      smb: client: drain and invalidate before server-side copy/clone
      smb: client: only require read lease for size-extending zero range
      smb: client: don't resurrect an exiting tcon from cached dir workers

Pavel Zverev (1):
      Bluetooth: btusb: Add support for 1357:c123 Realtek 8852BE device

Pawel Laszczak (1):
      usb: cdnsp: fix wakeup from S3 after controller context loss

Pedro Falcato (1):
      mm/madvise: atomically clear the young bit on THP MADV_COLD

Pei Xiao (9):
      ipack: ipoctal: add rwsem to guard against TOCTOU in remove path
      usb: dwc3: gadget: Fix use-after-free in dwc3_gadget_free_endpoints due to race condition
      media: cx23885: Fix use-after-free in cx23885_finidev due to race condition
      tpm: tpm_nsc: fix NULL pointer dereference on init failure
      tpm: tpm_nsc: stop using the cleanup callback as dev.release
      tpm: fix zero-length read discarding the pending response
      comedi: dt2811: fix shift-out-of-bounds in IRQ check
      ata: pata_parport: Fix use-after-free in new_device_store
      ata: pata_parport: fix parport attach idr_alloc for

Peijie Shao (1):
      nvme-tcp: fix selinux denied when calling sock_sendmsg

Peng Fan (3):
      remoteproc: imx_dsp_rproc: Drop extra space
      PM: sleep: wakeirq: Introduce device-managed variant of dev_pm_set_wake_irq()
      arm64: dts: imx8ulp-evk: fix reserved memory node names for remoteproc

Peng Hao (1):
      KVM: X86: Reduce size of kvm_vcpu_arch structure when CONFIG_KVM_XEN=n

Pengfei Zhang (1):
      net: stmmac: xgmac: do not treat TBU as a TX event

Pengpeng Hou (62):
      gpio: pca9570: Use I2C match data
      media: cec: stm32: return an error when log-address wait times out
      ASoC: sma1303: remove fault-check sysfs group on remove
      ASoC: tlv320aic26: remove keyclick sysfs file
      dmaengine: pl330: remove debugfs file on teardown
      iio: adc: max1241: add missing MODULE_DEVICE_TABLE()
      gpio: sifive: add missing MODULE_DEVICE_TABLE()
      ASoC: codecs: max98396: Unwind supplies on resume failure
      media: cec: tegra: add missing MODULE_DEVICE_TABLE()
      pinctrl: sx150x: add missing MODULE_DEVICE_TABLE()
      crypto: keembay - add missing MODULE_DEVICE_TABLE()
      media: ivtv: stop VBI start-code scan before short tail
      media: cx18: stop VBI start-code scan before short tail
      uio: sercos3: add missing MODULE_DEVICE_TABLE()
      greybus: manifest: validate string descriptor header
      ACPI: FPDT: validate table and record lengths
      power: supply: cros_pchg: unregister EC notifier
      power: reset: piix4-poweroff: add missing MODULE_DEVICE_TABLE()
      thermal: intel: int340x: clean up RFIM groups on DVFS failure
      wifi: ath11k: validate regulatory capability phy_id
      soc: ixp4xx: qmgr: add missing MODULE_DEVICE_TABLE()
      firmware: imx: scu: manage mailbox channels and global handle
      hsi: omap_ssi: remove debugfs on port creation failure
      clk: imx: imx8qxp: add missing MODULE_DEVICE_TABLE()
      clk: imx: imx8qxp-lpcg: add missing MODULE_DEVICE_TABLE()
      HID: rmi: check report length before trimming sentinel bytes
      Bluetooth: hci_nokia: validate firmware packet bounds
      fbdev: udlfb: validate vendor descriptor items
      rtc: ab-eoz9: add missing MODULE_DEVICE_TABLE()
      rtc: brcmstb-waketimer: add missing MODULE_DEVICE_TABLE()
      tracing: Use __free() for expr_str() buffer
      tracing: Return ERR_PTR() from expr_str()
      tracing: Bound histogram expression strings with seq_buf
      media: mediatek: jpeg: retry HW selection after successful wait
      media: require two-byte Cypress type 04 records
      spi: sh-msiof: propagate setup runtime-PM errors
      remoteproc: imx_dsp: Acquire runtime PM before adding carveouts
      memory: brcmstb_dpfe: validate firmware section sizes
      ASoC: es8326: report resume restore errors
      usb: musb: da8xx: depopulate OF children on remove
      usb: musb: da8xx: depopulate OF children on probe failure
      clk: s2mps11: Propagate OF provider registration failures
      clk: si521xx: correct the SI52147 OF output enable map
      clk: milbeaut: Return divider update timeouts
      pmdomain: imx: Propagate SCU provider registration failures
      hwrng: starfive - propagate clock and reset errors
      ASoC: adau17x1: return cache sync errors from resume
      ASoC: ak4642: return cache sync errors from resume
      ASoC: es8316: return cache sync errors from resume
      ASoC: nau8540: return cache sync errors from resume
      ASoC: rt1011: return cache sync errors from resume
      ASoC: rt1016: return cache sync errors from resume
      ASoC: rt1305: return cache sync errors from resume
      ASoC: rt1308: return cache sync errors from resume
      ASoC: rt5616: return cache sync errors from resume
      ASoC: rt5659: return cache sync errors from resume
      ASoC: rt5660: return cache sync errors from resume
      ASoC: rt5665: return cache sync errors from resume
      iio: accel: bma220: publish the SPI driver ACPI alias
      clk: si5351: fail prepare when PLL reset times out
      sh: defconfig: Enable the current M66592 UDC symbol
      wifi: mt76: mt7615: validate MCU response lengths

Perry Yuan (2):
      cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_nonlinear}_freq
      cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities missing

Peter Griffin (1):
      opp: fix use after free in _update_opp_table_clk()

Peter Morrow (1):
      net/mlx4: always create the eth and ib auxiliary devices

Peter Ujfalusi (11):
      ALSA: compress: add missing OPEN-state gate to SET_METADATA
      ALSA: hda: Reject codec reset on ASoC (ext_ops) buses
      ASoC: hdac_hda: Balance the runtime PM disable in codec remove
      ASoC: hdac_hda: Keep runtime PM state in sync across codec remove/probe
      ALSA: x86: hdmi: fix chmap array missing terminator entry
      ALSA: compress: reject buffer geometry change on gapless next_track
      ALSA: hda/hdmi: clamp sad_count in ELD proc write handler
      ALSA: hda/hdmi: clamp num_cvts against cvt_nids[] in hdmi_read_pin_conn
      ASoC: hdac_hda: Allocate the private data at codec driver bind
      ASoC: hdac_hda: Restore the codec device type on unbind
      ALSA: compress: fix buffer leak on failed SET_PARAMS

Petr Vorel (1):
      checkpatch: skip CamelCase cache for --no-tree without root

Ping Cheng (2):
      HID: wacom: Setup SW_MUTE_DEVICE according to the order of input registration
      HID: wacom: Write shared touch initial status only once

Ping-Ke Shih (2):
      wifi: rtw88: TX report with long timeout for non-PCIE devices
      wifi: rtw89: fw: consider checksum length of security data

Piotr Gliźniewicz (1):
      ALSA: 6fire: take stream_mutex in the Digital Thru control

Piotr Kubik (1):
      netfilter: ctnetlink: fix inverted IPv6 address match in dump filter

Piyush Patle (1):
      media: vidtv: fix frontend reference leak on unbind

Pranjal Shrivastava (1):
      PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs

Prashant Rahul (1):
      wifi: mt76: mt7921: fix memory leak when skb_linearize fails in mcu rx event

Prathamesh Deshpande (2):
      RDMA/mlx5: Cancel deferred page-fault EQ work before teardown
      RDMA/mlx5: Cancel software CQ notifications before teardown

Praveen Talari (1):
      opp: Use clk_get_optional() to avoid leaving opp_table->clk as an error pointer

Prike Liang (2):
      drm/amdgpu: skip gfx switch_power_profile during GPU reset
      drm/amdgpu: finish GPU recovery callbacks before restarting schedulers

Priyank Rathod (3):
      PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overflow
      PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing
      PCI/AER: Fix struct pci_dev reference leak in aer_process_err_devices()

Przemek Kitszel (1):
      ice: skip stats handling for channel VSIs on rebuild

Pufan Jin (1):
      spi: zynq-qspi: fix address buffer corruption and support 4-byte address

Punnay Sharma (2):
      staging: media: av7110: fix corrupted BER reporting in sp8870
      staging: media: av7110: fix sp8870 initialization failure state

Qi Xi (1):
      mm/page_isolation: fix UBSAN shift-out-of-bounds warning

Qihang (1):
      xfrm: interface: validate the IP header on xmit

Qiliang Yuan (6):
      srcu: Add list_splice_init_srcu()
      nvme: wait for SRCU readers before splicing the namespace list
      selftests/bpf: Create the vxlan devices of test_tunnel with their MAC
      selftests/bpf: Keep the bpffs of cgroup_hierarchical_stats private
      selftests/bpf: Unmount the bpffs that cgroup_hierarchical_stats mounted
      selftests/bpf: Run the cpumask map insert tests only for the test task

Qing Luo (1):
      sctp: auth: discard auth_chunk when skb_clone fails

Qing Zhang (1):
      nvmet: protect nvmet_ports_list with nvmet_config_sem

Qingfang Deng (4):
      pppoe: delete session hash entries by pointer match
      mtd: block: prevent reclaim I/O during request processing
      ARM: mvebu: fix Cortex-A9 errata selection for Armada 38x
      pppoe: drop discovery frames with no MAC header

Qingshuang Fu (1):
      selftests/timers: clocksource-switch: Fix unchecked open()/read()

Qiuxu Zhuo (1):
      EDAC/i10nm: Fix Granite Rapids ADXL MC mapping

Qu Wenruo (4):
      btrfs: do not overwrite NODATASUM flag when removing NODATACOW flag
      btrfs: raid56: do not verify the content if there is no data checksum
      btrfs: refactor read_key_bytes() to remove the dest_folio parameter
      btrfs: qgroup: do not treat "ret > 0" as error when deleting a qgroup

Quanye Yang (4):
      mptcp: reset msk state on early connect failure
      RDMA/rtrs-clt: Reject invalid queue_depth from the peer
      RDMA/rtrs-clt: Don't WARN on unexpected info-response opcode
      RDMA/rtrs-clt: Validate peer-supplied IO completion msg_id

Radiy Zhambakiev (3):
      mfd: tps65217: Fix NULL pointer dereference on IRQ init failure
      mfd: tps65217: Check return value when masking interrupt sources
      mfd: tps65217: Use devres for IRQ domain and wake teardown

Rafael J. Wysocki (7):
      ACPI: PM: Drop parent state update from acpi_device_get_power()
      ACPI: PCI: Introduce acpi_dev_get_pci_dev()
      ACPI: scan: Stop calling acpi_bus_init_power() early
      ACPI: utils: Adjust message printing macros for ACPI objects
      ACPI: glue: Fix up and adjust acpi_unbind_one()
      ACPI: video: Fix backlight unregistration ordering
      ASoC: amd: acp-es8336: Switch to use acpi_bus_get_primary_device()

Ramin Moussavi (3):
      microblaze: reserve the ABI argument-home area in the signal frame
      microblaze: don't clobber r3/r4 restored by rt_sigreturn
      microblaze: restore the ABI argument home area below pt_regs (PTO)

Rand Deeb (1):
      ata: libata-core: Ignore forced transfer modes the host does not support

Randy Dunlap (2):
      fbdev: maxine: fix 64-bit build error
      wifi: cfg80211: fix header kernel-doc typos

Ranjan Kumar (2):
      scsi: mpi3mr: Event processing debug improvement
      scsi: mpi3mr: Rename log data save helper to reflect threaded/BH context

Raphael Zimmer (2):
      libceph: Fix unsafe decode in ceph_redirect_decode()
      libceph: Fix multiple unsafe decodes in ceph_oloc_decode()

Ratnaker Gautam (3):
      scsi: libiscsi_tcp: Prevent R2T range check overflow
      smb: client: validate SMB1 EA list bounds before parsing
      smb: client: bound POSIX lock data area by response length

Raveendra Talabattula (1):
      drm/komeda: Fix bits parsing of GLB_CORE_ID

Ray Zhang (1):
      net: count last skb of each sk_backlog pass in __release_sock()

Reid Downing (1):
      xfs: fix wrong compat fields in xfs_ioctl32_bstat_copyin()

Reinhard Speyerer (2):
      net: usb: qmi_wwan: add Rolling Wireless RN947R
      USB: serial: option: add Rolling Wireless RN947R

Ren Tamura (1):
      tools/cgroup: sum shrinker object counts across NUMA nodes

Ricardo B. Marliere (1):
      power: supply: core: make power_supply_class constant

Ricardo Neri (1):
      hwmon: (coretemp) Refresh the temperature on the first read

Ricardo Ribalda (2):
      media: uvcvideo: Add autosuspend quirk for AVerMedia Live Gamer HD 2
      media: uvcvideo: Force UVC version for Avermedia GC515

Richard Patel (2):
      genirq: Defer kfree(irqaction) until irq_thread_dtor() finishes
      genirq: Move interrupt thread exit_work object to irqaction

Richard Weinberger (1):
      mtd: Call get_wunit() on the master partition

Ridham Khurana (2):
      hwmon: (lm95245) Fix negative temperature conversion
      hwmon: (lm70) Fix rounding of negative temperatures

Ridong Chen (1):
      mm/mglru: fix ineffective memory protection for non-kswapd reclaim

Rik van Riel (2):
      media: redrat3: fix UAF in probe error path leaving rc device registered
      mm/memcontrol: fix stuck FLUSHING_CACHED_CHARGE bit on isolated cpus

Rishikesh Jethwani (1):
      tls: device: protect async RX resync state during device-down

Rituparna Warwatkar (1):
      media: dvb-core: fix feed leak on failed DMX_ADD_PID

Rob Barnes (1):
      platform/chrome: cros_ec_proto: Fix deferred response

Rob Herring (1):
      clk: Use device_get_match_data()

Rob Herring (Arm) (1):
      dt-bindings: clock: mediatek: Add MT8516 fallbacks

Robert Leussler (1):
      rtc: ds1307: fix RX8130 wakeup alarm WADA bit for day-of-month mode

Robert Oscilowski (1):
      ASoC: qcom: sdm845: set quaternary MI2S codec DAI to I2S format

Robert Richter (1):
      PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem dev handler

Roberto Bergantinos Corpas (1):
      nfs: set gencount on protocol-specific remove

Robin Everaars (1):
      ACPI: button: Add DMI quirk for Razer Blade Pro 17 early 2020 lid switch

Robin Snyders (5):
      power: supply: qcom_smbx: include base when petting watchdog
      power: supply: qcom_smbx: test battery health status bits
      power: supply: qcom_smbx: fix float voltage selector
      power: supply: qcom_smbx: notify battery overvoltage recovery
      power: supply: qcom_smbx: validate battery float voltage

Rodrigo Gobbi (1):
      staging: rtl8723bs: change remaining printk to proper api

Rohinthan P (2):
      media: em28xx: use video_unregister_device for radio_dev
      media: v4l2-ctrls: do nothing if controls[0] == NULL in cluster functions

Roland Dreier (2):
      firmware: arm_scmi: Protect xfer->async_done with xfer->lock
      firmware: arm_scmi: Don't reuse raw xfers with async_done still armed

Roman Demidov (1):
      drm/msm/a6xx: fix use-after-free of OPP in a6xx_pm_resume

Rongguang Wei (1):
      tap: fix incorrect variable used for USO check in set_offload()

Rongzheng Wang (1):
      nvmet: use the enabled transport when disabling a port

Rosen Penev (26):
      nvmem: brcm_nvram: reject empty NVRAM partition
      nvmem: brcm_nvram: fix out-of-bounds access on malformed flash data
      gpio: mvebu: keep resume masks within the irqchip cache
      wifi: ath9k: delete channel-context timers on deinit
      mtd: rawnand: ndfc: use ioread32be/iowrite32be and allow COMPILE_TEST
      mtd: rawnand: ndfc: fix gcc uninitialized var
      mtd: rawnand: ndfc: use devm_platform_ioremap_resource()
      net: bgmac: enable interrupts only after NAPI is ready
      drm/nouveau/nvkm: clear use.enabled when subdev init fails
      nvmem: rockchip-otp: alloc clks with main struct
      ARM: dts: helios4: fix lm75 supply name
      ARM: dts: armada-385-clearfog-gtr: fix vmmc property name
      ARM: dts: armada-395-gp: drop unsupported SDHCI clock-frequency
      ARM: dts: armada-388-helios4: fix vmmc property name
      ARM: dts: helios4: fix vbus-supply for USB2 PHY
      ARM: dts: helios4: fix spi1 location
      dmaengine: fsl_raid: don't invoke client callback under desc_lock
      dmaengine: fsl_raid: avoid free_q underflow in free_chan_resources
      dmaengine: fsl_raid: zero CF descriptor pool allocations
      dmaengine: mv_xor: kill tasklet on channel add error path
      dmaengine: ste_dma40: turn d40_base phy_chans into a flexible array
      crypto: talitos - allocate channels with main struct
      crypto: talitos - use devm_platform_ioremap_resource()
      crypto: talitos - Use platform_get_irq() to retrieve interrupt
      crypto: talitos - init tasklets before requesting IRQs
      net: bgmac: fix TX DMA unmapping and slot cleanup

Ross Lagerwall (1):
      xen-blkfront: Fix IO race during unplug

Rounak Das (1):
      EDAC/altera: Use ECC manager compatible to select A10/S10 IRQ layout

Rui Qi (2):
      selftests/ftrace: Force C locale in ftracetest
      riscv: kprobes: Prevent probes in breakpoint handlers

Ruide Cao (2):
      mptcp: hold MP_JOIN msk ref when cloning reqsk
      mptcp: fix MP_CAPABLE token migration when cloning reqsk

Runyu Xiao (26):
      iio: admv1013: initialize callback mutex before registering notifier
      net: macb: initialize PTP state before registering clock
      Input: hp_sdc - shut down kicker timer on module exit
      hte: tegra194: Initialize slice locks before registering chip
      media: saa7146: Initialize interrupt lock before requesting IRQ
      dmaengine: altera-msgdma: initialize state before requesting IRQ
      crypto: ccp - Initialize DBC ioctl mutex before registering device
      PCI: pciehp: Make 'pciehp_poll_mode' parameter read-only
      media: adv7180: Initialize mutex before ancillary clients
      peci: aspeed: Initialize state before requesting IRQ
      peci: npcm: Initialize state before requesting IRQ
      ALSA: sgio2audio: Only free successfully requested IRQs
      m68k: dmasound: Keep the Q40 IRQ handler registered
      perf: xgene: initialize lock before requesting IRQ
      sh: maple: Use the matching IRQ cookie when invoking free_irq()
      can: proc: reset pkg_stats atomics individually
      ALSA: usb-audio: Protect Roland control activation
      hte: tegra194-test: shut down timer before GPIO release
      mailbox: altera: shut down RX polling timer on channel teardown
      ALSA: mpu401: shut down timer before freeing MPU
      IB/hfi1: Shutdown self-rearming timers before freeing
      block: amiflop: synchronize flush timer before track flush
      media: sti: delta: use unaligned accessors for MJPEG SOF fields
      remoteproc: xlnx: Initialize mailbox work before requesting channels
      ALSA: oxygen: use helper to activate the SPDIF PCM control
      ALSA: via82xx: use helper to activate DXS controls

Ruoyu Wang (8):
      drm/radeon: avoid double free in r600 DPM cleanup
      media: au0828: Free URBs when starting DVB streaming fails
      media: adv748x: Fix endpoint reference leaks on probe failure
      pwm: renesas-tpu: Fix runtime PM reference leak
      hwrng: cctrng - Fix runtime PM usage counter leak
      dmaengine: img-mdc: Fix runtime PM usage counter leak
      media: venus: Drop session events without an instance
      xen/pcifront: Fix PCI device reference leak in AER handling

Rupesh Majhi (1):
      iio: pressure: dps310: fix CFG_REG bit definitions

Ryan Brue (1):
      power: supply: bq24190_charger: use the wake irq API

Ryan Leung (3):
      wifi: mt76: fix unlocked wcid check in mt76_tx_status_skb_add()
      wifi: mt76: fix wcid teardown ordering in mt76_reset_device()
      wifi: mt76: fix wcid->pktid corruption in mt76_wcid_cleanup()

Ryusuke Konishi (4):
      nilfs2: fix deadlock between nilfs_evict_inode() and find_inode()
      nilfs2: correct return value kernel-doc descriptions for the rest
      nilfs2: ignore non-fatal signals during synchronous log write wait
      nilfs2: fix link count underflow when removing corrupted directory

SJ Park (7):
      mm/damon/sysfs: put target pids for damon_start() failure
      mm/damon/sysfs: put target pids for apply_inputs() failure
      mm/damon/sysfs-schemes: read sysfs_filter->addr_range only once
      mm/damon/core: skip applying scheme if region split for quota fails
      mm/damon/core: filter out damos address filter-split failed region
      mm/damon/core: remove unreachable damos charge_{target,addr}_from
      mm/damon/core: move static variable last_nr_regions to damon_ctx

Sabrina Dubroca (1):
      xfrm: espintcp: reorder operations within espintcp_init_sk

Sagi Maimon (2):
      net: axienet: free outstanding TX buffers in axienet_dma_bd_release()
      net: axienet: release every RX buffer in axienet_dma_bd_release()

Sahaj Chaudhari (4):
      gpio: davinci: Clear interrupt status in every bank on suspend
      gpio: pca953x: Preserve wakeup accounting on parent IRQ failure
      gpio: pca953x: Handle direction register read errors in IRQ paths
      spi: omap2-mcspi: handle DMA setup failures

Sakari Ailus (2):
      platform/x86: int3472: Fix uninitialised variable warning
      dmaengine: ste_dma40: Remove redundant pm_runtime_mark_last_busy() calls

Salah Triki (2):
      iio: temperature: tmp117: fix calibbias cache update on I2C write failure
      iio: imu: adis16400: Check return value of spi_setup()

Sally Marcher (1):
      ALSA: usb-audio: Add correct datainterval in the quirks-table for Microbook II

Sam Price (1):
      microblaze: preserve the MSR carry flags across signals

Samarth Narang (1):
      mm/ksm: keep soft-dirty when merging a page

Samuel Moelius (1):
      mm/gup_test: reject wrapped user ranges

Samuel Thibault (1):
      speakup: Fix NULL pointer dereference on VT switch + selection

Sanan Hasanov (1):
      hwmon: (corsair-cpro) Make wait_input_report_lock IRQ safe

Sang-Hoon Choi (1):
      xhci: dbc: lock the minor IDR on registration failure

Sanghyun Park (1):
      bpf: Fix program BTF use-after-free in sleepable programs

Sarthak Sharma (2):
      mm/gup_test: safely calculate GUP batch size
      mm/gup_test: report actual pinned bytes

Sasha Levin (5):
      cgroup: don't kill migrated processes through their exiting threads
      nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for KIOXIA XG10d
      kselftest/arm64: signal: copy each test binary only once
      selftests: keep the build status from wrapping to success
      ARC: Strip libgcc debug information when generating BTF

Scott Gauche (1):
      ALSA: hda/realtek: Fix audio after Windows reboot on ASUS Q423SA

Sean Anderson (1):
      selftests: net: csum: Clean up recv_verify_packet_ipv6

Sean Christopherson (20):
      KVM: nVMX: Decouple INVVPID operand checks from flushing of vpid02
      KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails
      KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages() error paths
      KVM: SVM: Preserve TLB control (i.e. pending TLB flush) on failed VMRUN
      KVM: SVM: Update control fields on #VMEXIT if and only if VMRUN succeeded
      KVM: nVMX: Force MSR bitmap refresh if runtime eVMCS controls are modified
      KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is cleared on VM-Exit
      KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when preparing L2 state
      KVM: Use goto to handle errors during memslot preparation
      KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the MMU has
      KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with EFER.LMA=1 && CR4.PAE=0
      KVM: x86: Preserve DR6.BLD (Bus Lock Detect) when delivering #DB payload
      KVM: x86: Zero reserved synic flags when delivering message to avoid stack leak
      KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1 && EFER.LME=0
      KVM: x86/mmu: Conditionally resched when retrying gPTE walk on A/D update failure
      KVM: x86: Conditionally resched when restarting REP string emulation
      KVM: nVMX: Process each host MSR entry at most once when unwinding failed VM-Entry
      KVM: x86/mmu: Cap number of parent PTEs per SP at 1000 (the arbitrary rmap limit)
      KVM: x86: Unconditionally reset MMU context when emulating INIT
      KVM: nSVM: Check validity of vmcs01 save area copied from SMRAM on RSM

Sean Young (22):
      media: rc: Ensure that rc_unregister_device() does not free input device
      media: rc: Ensure registered is cleared in error path
      media: rc: mce_kbd: Fix inconsistent locking of keylock
      media: rc: Use after free in ir_raw_event_handle()
      media: rc: After rc_unregister_device() timers can be re-armed
      media: rc: Fix use after free in bpf progs
      media: rc: Fix ABBA deadlock by making locks more fine grained
      media: rc: Fix build failure with CONFIG_LIRC disabled
      media: rc: Fix race between bpf(BPG_PROG_ATTACH) and device unregister
      media: streamzap: Add missing rc_unregister_device()
      media: redrat3: Ensure we don't read beyond the end of the packet
      media: redrat3: Ensure all urbs are suspended
      media: sunxi-cir: Ensure no more interrupts can occur before free
      media: meson-ir-tx: Ensure clock is disabled on unbind
      media: meson-ir-tx: Ensure probe error is propagated
      media: ir-hix5hd2: Ensure rdev is setup before interrupts are enabled
      media: ir_toy: Validate the maximum tx carrier
      media: meson-ir-tx: Prevent divide by zero in meson_irtx_prepare_pulse()
      media: meson-ir-tx: Ensure rc_free_device() is called on unbind
      media: ene_ir: Ensure teardown is done in the correct order
      media: redrat3: Error path leaves device in transmitting state
      media: serial_ir: Fix race condition where timer can be re-armed

Sebastian Andrzej Siewior (1):
      module: Use RCU in find_kallsyms_symbol().

Sebastian Reichel (2):
      power: supply: core: add power_supply_for_each_device()
      power: supply: core: get rid of of_node

Seiji Adachi (1):
      ASoC: amd: yc: Add Lenovo ThinkPad E16 Gen 2 (21JN) to quirks

Selvin Xavier (5):
      RDMA/bnxt_re: Fix integer overflow in send payload size computation
      RDMA/bnxt_re: Detect wrong sge_len passed for inline
      RDMA/bnxt_re: Validate SRQ max_sge at create time
      RDMA/bnxt_re: Initialize wqe.flags in bnxt_re_post_srq_recv()
      RDMA/bnxt_re: Fix the PD and DPI table size

Senjin (1):
      fs/ntfs3: fix lseek EINVAL on sparse/compressed files with 64-bit clusters

Seongjae Jeong (1):
      f2fs: fix submit accounting for IPU writeback

Seongjun Hong (1):
      vfio/mlx5: Fix boundary check in set_report_output()

Sergey Senozhatsky (1):
      ext4: fix ABBA deadlock in ext4_rmdir()

Serhat Kumral (4):
      RDMA/siw: Fix length of first chunk in siw_try_1seg()
      IB/rdmavt: Fix error unwind path for qp_priv_init() in rvt_create_qp()
      RDMA/srp: Avoid reading uninitialized has_port on srp_parse_in() failure
      RDMA/usnic: Bound buffer size to sizeof(buf) in flowinfo_read()

Serin Yeh (1):
      media: i2c: ov8856: fix debug message to report actual CSI-2 lane count

Seung Min Shin (1):
      sctp: hold transport reference across connect wait

Seungjin Bae (1):
      usb: typec: ucsi: ccg: Validate altmode index in GET_CURRENT_CAM response

Shahar Tzarfati (1):
      wifi: mac80211: ibss: read deauth reason_code after frame length check

Shakeel Butt (3):
      memcg: bypass the reclaim and oom killer for dying tasks once oom_reaper is done
      kernfs: fix up the unlocked attribute reads on the creation paths
      kernfs: avoid READ_ONCE() on a kgid_t in kernfs_new_node()

Shang En Sim (1):
      io_uring/poll: cancel all matching requests in one pass

Shao Mingyin (3):
      nvmet-auth: fix error handling on CHALLENGE failure
      scsi: target: tcmu: Fix divide-by-zero in data_pages_per_blk store
      nvmet: bound the traddr and trsvcid configfs writes

Sharath Srinivasan (1):
      net/rds: fix rds_message leak in the rds_send_xmit() drop path

Shashank Mohan Jain (3):
      bitmap: bitmap_parse(): reject non-hex character before 8 digits
      bitmap: bitmap_parselist(): reject trailing characters after group size
      bitmap: bitmap_parselist(): don't wrap around on a huge group size

Shehryar Ahmad (1):
      iio: accel: adis16201: fix channel order for buffer mode

Shen Lichuan (1):
      ksmbd: Correct typos in multiple comments across various files

Shengjiu Wang (3):
      remoteproc: imx_dsp_rproc: Add support of recovery and coredump process
      ASoC: fsl_asrc: use regmap_write_bits to update clock source registers
      remoteproc: imx_dsp_rproc: Only reset carveout memory at RPROC_OFFLINE state

Shengming Hu (1):
      cpufreq: conservative: Restrict deferred downscaling to low load

Shengzhuo Wei (1):
      media: go7007: bound EZ-USB I2C transfers to the usb_buf size

Shivaprasad G Bhat (1):
      scsi: qla2xxx: Handle INTx not connected while passing through

Shrikanth Hegde (1):
      powerpc/ftrace: Don't restore r13 during ftrace_regs_caller

Shuai Liu (1):
      io_uring/sqpoll: don't set IO_SQ_THREAD_SHOULD_STOP on thread exit

Shuangfeng He (1):
      netfilter: flowtable: use the vlan id, not the full tci, in the tuple key

Shuangpeng Bai (1):
      media: gspca: use vb2_video_unregister_device() on disconnect

Shubham Antil (2):
      RDS/IB: validate receive fragment completions
      vhost-scsi: zero misaligned I/O bounce pages

Shujath Mohd (1):
      arm64: dts: qcom: sdm845-sony-xperia-tama: Fix Bluetooth UART pinctrl

Shuvam Pandey (1):
      lib/tests: extend cmdline KUnit with next_arg() tests

Siddharth Chintamaneni (2):
      smb: client: fix busy dentry warning on unmount after DIO
      mm: multi-gen LRU: fix NULL lruvec->pgdat deref with memcg disabled on cmdline

Simon Glass (1):
      kconfig: abort rather than loop for ever on EOF

Simon Horman (1):
      net: tls: Pass union tls_crypto_context pointer to memzero_explicit

Sinan Turunc (4):
      ALSA: line6: Reject capture buffers smaller than two packets
      ALSA: usx2y: Require a buffer of two URBs
      ALSA: usx2y: Guard the playback copy
      ALSA: usb-audio: Bound packet copies by the PCM buffer size

Siwei Zhang (5):
      Bluetooth: L2CAP: Reject mode changes on connected channels
      Bluetooth: L2CAP: Reject invalid TxWindow in configuration requests
      Bluetooth: L2CAP: Use default TxWindow for zero socket option
      Bluetooth: L2CAP: Reject signalling responses in invalid states
      Bluetooth: L2CAP: Only accept connection responses to outstanding requests

Slavin Liu (5):
      ACPI: tables: handle failed initrd override mappings
      crypto: atmel-sha - reject initialization without a device
      clk: starfive: jh7110: reject oscillator lookup errors
      ASoC: fsl_asrc: check the second front-end DMA channel
      clocksource/drivers/dbx500-prcmu: Check timer register mapping

Somnath Kotur (2):
      bnxt_en: Change bnxt_rx_xdp function prototype
      bnxt_en: Add XDP Metadata support

Sorah Fukumori (1):
      net: gro: don't chain linear parts larger than gso_size into frag_list

Srinivas Kandagatla (2):
      ASoC: codecs: wsa884x: disable runtime PM on unbind
      ASoC: codecs: wsa883x: disable runtime PM on unbind

Srinivas Neeli (2):
      dmaengine: xilinx_dma: Fix MCDMA descriptor fields based on DMA direction
      dmaengine: xilinx_dma: Move descriptors to done list based on completion bit

Srinivas Pandruvada (5):
      platform/x86/intel/tpmi: Move TPMI ID definition
      platform/x86: ISST: Process read/write blocked feature status
      platform/x86: ISST: Validate parameter for frequency and priority
      platform/x86: ISST: Use PP level enable mask
      platform/x86: ISST: Return error during profile addition

Srinivasan Shanmugam (1):
      drm/amdgpu/powerplay: Align get_tonga_state_array() header with prototype

Srish Srinivasan (4):
      pseries/plpks: fix error handling in plpks_read_var()
      pseries/plpks: validate input to plpks_signed_update_var()
      pseries/plpks: clear sensitive PLPKS buffers
      pseries/plpks: clear signed update authentication buffer

Stanislaw Gruszka (2):
      module/kallsyms: fix nextval for data symbol lookup
      wifi: mac80211: queue frames while off-channel

Stanley Jhu (7):
      scsi: ufs: bsg: Complete the job on error
      scsi: ufs: bsg: Clear the reply buffer before use
      scsi: ufs: core: Clear stale UIC result byte before peer DME retries
      scsi: ufs: core: Remove an always-false WARN_ONCE()
      scsi: ufs: bsg: Validate request_len before accessing request
      scsi: ufs: bsg: Reject UIC commands with a non-zero result byte
      scsi: ufs: core: Add a helper for clearing hba->outstanding_reqs

StanleyYP Wang (1):
      wifi: mt76: mt7996: fix alignment of sta info event

Stefan Haberland (1):
      s390/dasd: Snapshot intrc before freeing the request block

Stefan Hansson (1):
      wifi: rsi: Fix types to appease CFI

Stefan Metzmacher (1):
      smb: smbdirect: fix buffer length underflow in RDMA transfers

Stefano Munari (1):
      net: usb: lan78xx: reject invalid EEPROM write requests

Stephane Danieau (1):
      pinctrl: stm32: Allow compile as module for stm32mp257

Stephen Brennan (1):
      powerpc/pseries/iommu: Restore CONFIG_IOMMU_API dependency

Steven Price (2):
      irqchip/gic-v3-its: Share ITS tables with a non-trusted hypervisor
      irqchip/gic-v3-its: Fix over allocation in itt_alloc_pool()

Steven Rostedt (1):
      cpuidle: haltpoll: Only define guest_halt_poll_ns tracepoint when used

Stuart Hayhurst (1):
      HID: logitech-hidpp: Add support for G502 X Plus USB mouse

Sudeep Holla (3):
      ACPICA: Fix PCC OperationRegion command offsets
      ACPI: PCC: Simplify PCC shared memory region handling
      ACPI: PCC: Preserve shared memory signature in OpRegion handler

Sumanth Korikkar (1):
      s390/cpum_cf: Check session mask before cpu offline

Sumit Kumar (1):
      PCI: dwc: Set DMA_BYPASS bit in outbound IATU CTRL2 register

Sun Jian (1):
      selftests/bpf: cover short IPv4/IPv6 inputs with adjust_room

Sung Byeongchan (4):
      ALSA: pcmtest: handle multiple wraps in random capture fill
      virtiofs: validate fixed-output response length
      nvmet-auth: reject undersized AUTH_SEND payloads
      netfilter: xt_dccp: handle reserved options as single-byte

Surabhi Gogte (1):
      nvme-tcp: store and use the caller's network namespace

Suravee Suthikulpanit (1):
      iommu/amd: Force device table to maximum size

Sven Eckelmann (11):
      batman-adv: dat: initialize orig_node of unfilled candidate slots
      batman-adv: fix skb leak when hard_iface is being released
      batman-adv: Limit number of aggregated packets directly
      batman-adv: tpmeter: fix u32 truncation of reported bytes
      batman-adv: stop originator purge worker before freeing TT
      batman-adv: tt: only transmit local ROAM flag together with DEL
      batman-adv: tt: clear ROAM flag when re-adding a pending local client
      batman-adv: tt: send ROAM_ADV on each roamed back client
      batman-adv: tt: ignore ROAM flag of received ADD changes
      batman-adv: tt: only update flags for TT events
      batman-adv: tt: don't drop local events queued during TVLV update

Sven Püschel (1):
      media: rockchip: rga: use clk_bulk api

T.J. Mercier (1):
      mm: memcontrol: fix NULL pointer deref and UAF from high_work_func() on dying memcg

TJ Adams (1):
      block: advance iterator after copy-in for SG_DXFER_TO_FROM_DEV

Takashi Iwai (44):
      ALSA: hda/intel: Add sanity check for BAR0 size
      ALSA: rawmidi: Use guard() for locking
      ALSA: core: Use guard() for locking
      ALSA: core: Fix potential UAF after asynchronous card release
      ALSA: rawmidi: Fix kvfree() call in spinlock
      ALSA: control: Fix UAF in snd_ctl_elem_add() on card disconnect
      ALSA: core: Check shutdown flag at D0 power-state, too
      ALSA: ump: Correct return size of fill_rpn()
      ALSA: seq: oss: Skip events until fully initialized
      ALSA: compress_offload: Use automatic cleanup of kfree()
      ALSA: line6: Use guard() for spin locks
      ALSA: line6: Handle period elapsed calls outside the locks
      ALSA: emux: Use standard print API
      ALSA: synth: Use guard() for spin locks
      ALSA: emux: Fix UAF of soundfont zones at note-on
      ALSA: emux: Stop voices before freeing zones in all cases
      ALSA: aloop: Use guard() for mutex locks
      ALSA: pcm: Optimize cpu_latency_qos_*() calls
      ALSA: pcm: Prevent O_APPEND open on OSS streams
      ALSA: oxygen: Use guard() for mutex locks
      ALSA: ump: Avoid dereference with max_src_size=0
      ALSA: caiaq: Allow zero-length packet handling for EP1
      ALSA: hda: Fix potential UAF for gating jack
      ALSA: usb-audio: Check mixer matrix size for UAC2/3 at parsing
      ALSA: usb-audio: Fix invalid UAC2/3 mixer unit matrix evaluation
      ALSA: core: Remove superfluous CONFIG_PM
      ALSA: core: Add missing barriers for power_ref vs card->shutdown
      ALSA: seq: core: Use automatic cleanup of kfree()
      ALSA: seq: Fix missing direction and ump_group handling in 32bit compat ioctl
      ALSA: info: Use guard() for locking
      ALSA: info: Fix memory leak at card removal
      ALSA: hda: Avoid non-operational GPU warning at regular device removal
      ALSA: caiaq: Fix races at MIDI URB and trigger accesses
      ALSA: line6: Reject too small max packet sizes
      ALSA: line6: Fix potential OOB write in line6_capture_copy()
      ALSA: hda: intel: Cancel delayed work at shutdown, too
      ALSA: hda: Add NULL check for the driver pointer at unsol event work
      ALSA: jack: Fix kctl free at error in snd_jack_kctl_new()
      ALSA: line6: Use kzalloc() for PCM buffer allocation
      ALSA: usb-audio: Use fixed control index for us16x08 mixer elements
      ALSA: Add simple refcount helper functions
      ALSA: pcm: Add refcount for races between drain and unlink
      ALSA: core: Serialize snd_refcount put and sync
      platform/x86: ibm_rtl: Fix potential OOB read at signature search

Takashi Sakamoto (1):
      firewire: core: remove unused link field in fw_packet structure

Tal Zussman (5):
      gfs2: fix the escaped block copy in gfs2_before_commit()
      vhost-vdpa: fix pinned page leak in vhost_vdpa_pa_map() error path
      block: introduce bio_in_atomic()
      block: use iomap_dirty_folio for block devices
      block: honor IOCB_NOWAIT in the block device buffered read path

Tanmay Shah (1):
      remoteproc: core: Full attach detach during recovery

Tao Chen (1):
      bpf: Add show_fdinfo for perf_event

Tao Cui (2):
      blk-iocost: charge zone appends as writes
      blk-iocost: account zone append completions in latency stats

Tapio Reijonen (5):
      serial: max310x: don't clobber the TX break bit in set_termios
      serial: max310x: fix breaks not reaching the wire in RS485 mode
      serial: max310x: centralize the RS485 transceiver programming
      serial: max310x: fix RS485 delays being programmed as bit-times
      serial: max310x: don't power down the port mid-transmission on close

Tarun Noonemunthala (1):
      ALSA: hda/realtek: Add quirk for HP ENVY 13-aq1xxx

Tharit Tangkijwanichakul (2):
      media: hantro: Harden MPEG-2 control access against NULL
      media: hantro: disable runtime PM before hardware teardown

Theo Andersen Carton (1):
      drm/amdgpu: skip the noirq suspend reset for a switcheroo-parked GPU

Theodor Arsenij Larionov Trichkine (1):
      net: use the full socket in sk_mc_loop()

Thiébaud Weksteen (1):
      module: validate string table section types

Thomas Falcon (1):
      perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()

Thomas Fourier (1):
      net: alacritech: fix dma_free_coherent() in error path

Thomas Gleixner (1):
      futex: Sanitize and document task_struct::futex::state transitions

Thomas Huth (2):
      smb: server: Make sure that passkey is not leaked on the heap in user_config.c
      smb: server: Free session data in user_session.c with kfree_sensitive()

Thomas Weißschuh (6):
      power: supply: core: remove opencoded string_lower()
      power: supply: core: introduce power_supply_for_each_psy()
      power: supply: core: use power_supply_for_each_psy()
      microblaze: uaccess: Zero out destination on failed get_user()
      microblaze: Pass -m{big,little}-endian through KBUILD_CPPFLAGS
      nios2: ksyms: Declare __mulsi3 export

Thomas Weißschuh (Schneider Electric) (1):
      timekeeping: Update offsets on sequence counter retry in ktime_get_update_offsets_now()

Thomas Zimmermann (1):
      drm/sysfb: simpledrm: Improve framebuffer-size validation

Thorsten Blum (13):
      platform/x86: think-lmi: Fix certificate thumbprint sysfs output
      platform/x86: think-lmi: Fix current password length check
      thermal: intel: powerclamp: Reject invalid window_size values
      thermal: intel: int340x: Fix temperature selection around 0 C
      hwrng: amd - report partial reads in non-blocking mode
      hwrng: ba431 - fix reported byte count
      hwrng: core - reject unknown RNG names
      x86/boot: Fix off-by-one error in sme_clear_pgd()
      init: fix early boot crash with bare hostname parameter
      mfd: twl-core: Use i2c_check_functionality as boolean value
      hwrng: virtio - prevent use-after-free after a failed restore
      hwrng: intel - return -ENOMEM when kmalloc_obj() fails
      hwrng: intel - return -ENOMEM when ioremap() fails

Tianchu Chen (2):
      staging: rtl8723bs: fix protected RX frame validation in decrypt path
      staging: rtl8723bs: fix RX buffer OOB write from device-reported length

Tianyi Chen (1):
      eventpoll: propagate wakeup source creation failure in ep_modify()

Tianyi Gao (1):
      veth: schedule the peer's NAPI after XDP_TX when only GRO is enabled

Tiezhu Yang (6):
      LoongArch: Remove redundant call in update_bp_registers()
      LoongArch: Fix bitmask corruption in update_bp_registers()
      LoongArch: Fix architectural naming typo for CSR_FWPS_SKIP
      LoongArch: Only send SIGTRAP signal if necessary in do_watch()
      LoongArch: Fix perf hardware breakpoint failure via installation
      LoongArch: Fix one-shot limitation for perf hardware breakpoints

Tigran Mkrtchyan (2):
      nfsv4/pnfs: use the MDS authflavor for data server connections
      pNFS/flexfiles: make pg_init retry loops killable

Til Kaiser (1):
      mlxsw: Initialize register query payloads

Tim Douglas (3):
      serial: pmac_zilog: push received data to the port that received it
      power: supply: generic-adc-battery: fix status with no supplier
      serial: pmac_zilog: report received breaks

Tim Menninger (1):
      xprtrdma: prevent disconnect feedback during endpoint teardown

Timur Kristóf (2):
      drm/amd/display: Fix fast updates on DCE 6.x
      drm/amdgpu/uvd3.1: Fix checking whether UVD firmware keyselect was already set

Ting-Han Hou (3):
      checkkconfigsymbols.py: Parse Git status output line by line
      clang-tools: Import os for broken pipe handling
      scripts/gdb: fix radix tree lookup pointer handling

Tingjie Zhong (1):
      fbdev: bitblit: Fix glyph clipping when fbcon pans

Tobias Schumacher (1):
      s390/pci: Add error cleanup in zpci_directed_irq_init()

Toke Høiland-Jørgensen (2):
      wifi: mac80211: reinstate IEEE80211_TX_CTL_AMPDU flag in ieee80211_tx_prep_agg()
      bpftool: Set BPF_F_XDP_DEV_BOUND_ONLY flag non-destructively

Tom Verdonck (2):
      hwmon: (tmp102) Fix jiffies wraparound in conversion-ready check
      hwmon: (tmp108) Fix jiffies wraparound in conversion-ready check

Tom Zanussi (1):
      tracing: Fix fully-qualified variable reference printing in histograms

Tomasz Bojanowski (1):
      ALSA: usb-audio: Add mixer mapping for MSI MAG B850M MORTAR WIFI

Triet Hoang (1):
      clk: raspberrypi: Handle cpufreq device registration failure

Tristan Madani (1):
      ppp: fix stale pointer access after pskb_may_pull in ppp_ccp_peek

Troy Mitchell (1):
      dt-bindings: vendor-prefixes: Add Sensylink

Tu Dinh (2):
      xen-netback: Fix XenBus connection failure cleanup
      xen-netback: Zero out sring pointers on unmap

Tung Nguyen (1):
      tipc: fix refcount panic in tipc_rcv() when receiving shared skb

Tvrtko Ursulin (1):
      drm/amdgpu: Use (v)memdup_array_user in amdgpu_cs_pass1

Tyrel Datwyler (2):
      scsi: ibmvfc: check for NULL evt in implicit LOGO and target delete path
      scsi: ibmvfc: free ibmvfc_target allocations with mempool_free

Uwe Kleine-König (7):
      media: meson-ir-tx: Convert to use devm_rc_register_device()
      media: meson-ir-tx: Simplify and improve using dev_err_probe()
      irqchip/imx-intmux: Convert to platform_driver::remove_new() callback
      Input: matrix_keypad - convert to platform remove callback returning void
      pwm: renesas: Drop usage of pwm_[gs]et_chip_data()
      pwm: lp3943: Drop usage of pwm_[gs]et_chip_data()
      memory: emif: Convert to platform remove callback returning void

Uwe Kleine-König (The Capable Hub) (1):
      regmap: maple: Workaround for another false-positive compiler warning

Vadim Klishko (1):
      HID: i2c-hid: Add a quirk for a Cirque I2C device.

Vaibhav Nagare (1):
      bnxt_en: don't leave an XDP program installed when the open fails

Val Packett (1):
      ASoC: qcom: qdsp6: q6afe: fix clk vote response type mismatch

Valentin Caron (1):
      perf cs-etm: fix a compilation issue in cs_etm_decoder__set_tid()

Valentin Kindschi (2):
      Bluetooth: hci_sync: re-enable legacy advertising on resume
      Bluetooth: hci_sync: pause advertising for the scan address update

Vas Zayarskiy (1):
      hwmon: (aquacomputer_d5next) Avoid truncating scaled sensor readings

Vasiliy Kovalev (1):
      ALSA: hda/via: Apply runtime PM workaround for ASUS X55A

Venky Shankar (1):
      ceph: don't fail write_begin with -EAGAIN after flushing old snapc

Vernon Yang (3):
      mm: khugepaged: fix swap entry value to folio_pfn()
      mm: khugepaged: fix folio is used after folio_put/unlock()
      selftests/mm: include kselftest.h in vm_util.h

VeroFess (1):
      smb: server: size directory name conversion buffer correctly

Vincent Donnefort (2):
      tracing: Fix logged instance name on creation failure
      KVM: arm64: Fix MMFR0 TGRAN advertisement for pVMs

Vincent Jardin (1):
      dt-bindings: vendor-prefixes: add Free Mobile

Vincent Liu (1):
      driver core: Check drivers_autoprobe for all added devices

Vincent Mailhol (1):
      can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices

Vinod Koul (1):
      dmaengine: zynqmp_dma: drop redundant label

Vishnu Santhosh (1):
      dmaengine: qcom: bam_dma: Defer IRQ trigger type to device tree

Vitaly Kuznetsov (5):
      KVM: x86/xen: Remove unneeded xen context from kvm_arch when !CONFIG_KVM_XEN
      KVM: VMX: Split off hyperv_evmcs.{ch}
      KVM: nVMX: Split off helper for emulating VMCLEAR on Hyper-V eVMCS
      KVM: nVMX: Move guest_cpuid_has_evmcs() to hyperv.h
      KVM: x86: Make Hyper-V emulation optional

Vlad Kulikov (1):
      ipc: create_ipc_ns: drop mqueue mount on sysctl setup failure

Vladimir Murzin (1):
      usb: mtu3: Fix double dereference in TP_printk

Vladimir Oltean (1):
      PCI: cadence: Preserve all error codes in cdns_plat_pcie_probe()

Vladimir Zapolskiy (2):
      i2c: qcom-cci: Do not check return value of cci_init()
      i2c: qcom-cci: Remove overcautious disable_irq() calls

Vladyslav Tymoshchuk (2):
      ASoC: qcom: q6apm: reset the hw pointer with the fragment queue
      ASoC: qcom: q6apm-dai: wrap the position of a full ring to 0

Wahid Khan (1):
      HID: intel-ish-hid: ignore post-init ENUM_DEVICES from firmware

Waldemar Brodkorb (1):
      sh: Select BINFMT_FLAT_NO_DATA_START_OFFSET for !MMU

Wang Haoran (1):
      fbdev: atmel_lcdfb: fix list_first_entry() on possibly empty modelist in probe

WangYuli (1):
      MIPS: Only check -msym32 when need-compiler

Wayne Chang (1):
      usb: typec: ucsi_ccg: Add retry mechanism in ccg_read

Wei Jie Law (3):
      net: usb: pegasus: do not advance rx_skb->data on dropped frames
      media: uvcvideo: Fix NULL deref on events for uninitialized controls
      net: usb: pegasus: check rx pkt_len against the received length

Wei Wang (1):
      arm64: suspend: Save and restore TPIDR2_EL0 across CPU suspend

Wei Yang (1):
      mm/madvise: add cond_resched() in THP branch of madvise_cold_or_pageout_pte_range()

Weibin Liu (6):
      spi: jcore: fix divide-by-zero when speed_hz is zero
      spi: npcm-fiu: limit UMA data_size to the 16-byte staging buffer
      spi: amd: fix len==0 underflow and FIFO overflow
      spi: amd: validate FIFO usage before executing message
      spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op
      spi: cadence-xspi: reject SDMA transfers larger than the requested length

Weigang He (7):
      media: rc: fintek-cir: process a full RX buffer instead of overflowing it
      mtd: parsers: qcom: fix offset/size overflow on large partitions
      wifi: mac80211: reload TDLS header pointer after skb_linearize()
      ARM: vexpress: fix device_node refcount leak in vexpress_flags_set()
      ARM: vexpress: fix device_node refcount leak in vexpress_smp_dt_prepare_cpus()
      thermal/drivers/ti-soc-thermal: Cancel pending alert work on remove
      thermal/drivers/sprd: validate the sensor id from the device tree

Weili Qian (5):
      crypto: hisilicon/hpre - fix pointer dereference before length check
      crypto: hisilicon/hpre - return -EOVERFLOW for small ECDH output buffer
      crypto: hisilicon/hpre - fix ECDH destination DMA mapping
      crypto: hisilicon/hpre - fix GFP flags for dma_alloc_coherent
      crypto: hisilicon/hpre - remove dma_free_coherent on NULL req->dst in ECDH

Weiming Shi (6):
      net: team: free skb when broadcast has no txable port
      smb: client: stop processing a read response after a receive error
      nvmet-rdma: reject short connection requests
      fs/ntfs3: take run_lock when freeing offs_folio in ni_decompress_file
      fs/ntfs3: zero frame pages on read error
      ntfs3: fix out-of-bounds read in ntfs_read_mft()

Wenjie Qi (1):
      f2fs: flush SIT journal during filesystem resize

Wentao Liang (47):
      ata: libahci_platform: Fix device reference leak in ahci_platform_get_resources()
      nfsd: Fix id-to-name cache entry leak in idtoname_parse()
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
      btrfs: zoned: fix block group reference leak in btrfs_repair_one_zone()
      irqchip/mchp-eic: Fix clock reference leak in mchp_eic_probe()
      ceph: Fix xattr buffer leak in __send_cap()
      ceph: Fix mds session leak in __open_export_target_session()
      ALSA: caiaq: free the EP4 URB when input setup fails
      drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()
      xen/gntdev: Fix gntdev_dmabuf ref leak in dmabuf_exp_wait_released()
      power: supply: ltc2941: Fix of_node reference leak in ltc294x_i2c_probe()
      clk: versatile: clk-icst: Fix node reference leak in of_syscon_icst_setup()
      RDMA/cxgb4: Fix neigh reference leak in rx_pkt()
      RDMA/cxgb4: Fix skb reference leak in rx_pkt()
      RDMA/mlx5: Fix RQ resource reference leak in mlx5_ib_wq_event()
      RDMA/siw: Fix qp use-after-free in siw_get_base_qp()
      pinctrl: stm32: Fix clock reference leak in stm32_pctl_probe()
      apparmor: Fix namespace reference leak in __aa_find_or_create_ns()

Will Deacon (3):
      tools: linux/types.h: Add 128-bit integer types for arm64 UAPI structures
      vsock/virtio: Move length check to callers of virtio_vsock_skb_rx_put()
      vsock/virtio: Rename virtio_vsock_skb_rx_put()

Will Porter (1):
      ALSA: usb-audio: Add iD14 MkI to monitor-mix volume quirk

Willem de Bruijn (4):
      virtio_net: copy zerocopy frags in start_xmit without NAPI
      packet: use ubuf_info completion for TX_RING packets
      selftests: net: csum: filter packets by source address and port
      virtio-net: fix frag overflow in big packets receive

William Hansen-Baird (2):
      wifi: rtlwifi: rtl8723be: Remove unnecessary irq save/restore in hw_init()
      wifi: rtlwifi: fix disabling of ASPM for RTL8723BE with AER flooding

William Theesfeld (1):
      clk: zynq: handle kasprintf() failure in periph_clk registration

Wilson Felipe Pereira (2):
      init/main: fix off-by-one in argv_init cleanup
      init/main: fix false-positive kernel panic on environment variable overwrite

Wolfram Sang (1):
      spi: sun4i: use 'time_left' variable with wait_for_completion_timeout()

Xia Yan (3):
      macvlan: fix passthru promiscuity accounting while down
      veth: keep carrier off when resizing channels with a down peer
      ipv6: fix device binding after failed datagram connect

Xiang Liu (1):
      drm/amd/pm: Guard VBIOS AC timing table walk

Xiang Mei (9):
      libceph: bound mon_command ack decode to front len
      media: em28xx: reject audio endpoint with zero packet size
      media: go7007: only set audio_enabled if go7007_snd_init() succeeded
      fbdev: udlfb: don't rebuild the mode list while the framebuffer is in use
      ceph: reject mdsmaps that claim more than CEPH_MAX_MDS ranks
      ceph: require the dentry lease record to cover struct ceph_mds_reply_lease
      ceph: fix integer overflow in the snap trace bounds check
      fs/ntfs3: validate $SDH entry size in ntfs_insert_security
      ceph: fix off-by-one NUL termination in decode_encrypted_symlink()

Xiang Mei (Microsoft) (2):
      fs/ntfs3: check INDEX_ROOT resident size before use in ntfs_read_mft()
      fs/ntfs3: fix slab-out-of-bounds write in attr_insert_range()

Xiao Liang (1):
      tun: drop batched packets while the device is down

Xiaofeng Yuan (1):
      RISC-V: KVM: Fix IPI delivery for out-of-order vcpu_id

Xiaogang Chen (1):
      drm/amdkfd: Guard m->cp_hqd_eop_control setting by q->eop_ring_buffer_size

Xiaoyao Li (2):
      x86/kvm: Use separate percpu variable to track the enabling of asyncpf
      KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus lock detected

Xie Bo (1):
      RISC-V: KVM: Propagate interrupted G-stage faults

Ximing Zhang (1):
      hwmon: (coretemp) Fix handling of isolated SMT siblings

Xin Yin (1):
      writeback: size foreign flushes by target wb dirty pages

Xingui Yang (2):
      scsi: libsas: Fix out-of-bounds memcpy() in sas_ssp_task_response()
      scsi: hisi_sas: Fix incorrect delay values from magic-number cleanup

Xiong Weimin (1):
      vdpa_sim: hold iommu_lock across dma_unmap passthrough transition

Xiubo Li (4):
      ceph: do not cache negative dentries for snapped directories
      ceph: fix use-after-dereference of NULL ci in __ceph_remove_cap()
      libceph: only set read_from_replica on read requests
      ceph: mark the superblock active after mounting

Xixin Liu (2):
      nvme-auth: use crypto_memneq for DH-HMAC-CHAP response comparison
      nvme: zns: cap zone report nr_zones by DMA buffer size

Xu Rao (4):
      mmc: block: reject invalid perdev_minors before division
      usb: gadget: u_audio: clean up capture endpoint on feedback failure
      ALSA: hda/ext: preserve PPLCCTL bits when clearing reset
      media: m2m-deinterlace: fix default capture field

Xueqin Luo (5):
      cpuidle: menu: Do not return a disabled idle state
      cpuidle: teo: Do not return a disabled idle state
      cpufreq: sparc-us2e: fix frequency table index copy-paste error
      cpufreq: tegra194: fix double-pointer error in get_cpu_ndiv
      cpufreq: sti: avoid NULL dereference in dev_err()

YANXIN LI (1):
      ufs: use u64 for directory size in ufs_last_byte

Yafang Shao (1):
      mm/migrate: snapshot the source nid before the misplaced migration

Yang Wang (8):
      drm/amd/pm: Validate Vega hwmgr PowerPlay table bounds
      drm/amd/pm: Validate pp_table header before reading size
      drm/amd/pm: Use uploaded size for legacy custom PPTable
      drm/amd/pm: Validate Tonga PowerPlay state array bounds
      drm/amd/pm: Validate Tonga PPTable subtable bounds
      drm/amd/pm: Validate Vega10 PPTable subtable bounds
      drm/amd/pm: Validate legacy hwmgr PP table offsets
      drm/amdgpu: Disable runtime PM for externally attached dGPUs

Yang Wen (1):
      exfat: keep FITRIM within the requested range

Yang Xiuwei (1):
      floppy: avoid NULL deref in reset_interrupt when cont is cleared

Yang Zi (1):
      comedi: addi_apci_3xxx: fix subdevice count underallocation

Yao Kai (1):
      ext4: validate readdir offset before accessing dirent

Yao Sang (1):
      nvme: pass partition flags to passthrough checks

Yao Yiqi (2):
      fbcon: Retry rotated font allocation after failure
      fbcon: Rebuild rotated font buffer on font change

Yao Zi (1):
      x86/locking: Use sfence for wmb() if SSE is available

Yaozhong Li (2):
      arm64: dts: rockchip: fix analog headphone output on rk3399-firefly
      arm64: dts: rockchip: disable unused i2s0 on rk3399-firefly

Yehyeong Lee (5):
      nvmet-fc: fix use-after-free in nvmet_fc_ls_create_connection()
      xen/pcifront: check that an AER callback exists before calling it
      nvme-rdma: don't complete a request after a bogus remote invalidation
      9p/xen: validate the response size from the backend
      nvme-auth: fail when the controller does not authenticate itself

Yeoreum Yun (2):
      coresight/etm4: fix missing disable active config
      arm64: Fix cleared E0POE bit after cpu_suspend()/resume()

Yi Cong (2):
      wifi: rtw89: 8851b: fix swapped DPK channel/bandwidth backup fields
      wifi: mt76: mt792x: fix negative errno truncation in offload capability

Yi-Chia Hsieh (1):
      wifi: mt76: mt7996: Add mcu commands for getting sta tx statistic

YiPeng Chai (1):
      drm/amdgpu: add bounds check to prevent array overflow

Yibo Tan (3):
      fbdev: atmel_lcdfb: Prevent FIFO work after removal
      media: ipu-bridge: Fix use-after-free in IVSC error path
      ASoC: amd: acp-es8336: Use an owned codec device reference

Yichong Chen (3):
      exfat: free new directory cluster if zeroing fails
      io_uring/net: keep recvmsg buffer select length within MAX_RW_COUNT
      debugfs: make debugfs_create_str() read-only

Yifei Gao (2):
      9p/xen: fix refcount leak in p9_xen_response() on wrong tag
      misc: fastrpc: fix double-free in fastrpc_map_attach() error path

Yili Zhang (1):
      RDMA/nldev: Fix NULL deref in dumps of objects abandoned by DRIVER_FAILURE

Yilin Zhang (1):
      mptcp: do not use Fast Open on MP_JOIN subflows

Yingjie Wang (5):
      net: unix: reject negative max_dgram_qlen values
      tcp: limit tcp_tso_rtt_log to a valid shift count
      scsi: handle out-of-range SG_SET_TIMEOUT values
      scsi: bsg: Report synchronous data copyback failures
      nvmet: reject keep-alive timeouts that would overflow

Yishai Hadas (5):
      RDMA/hns: Pin CQ buffer writable to match device DMA write access
      RDMA/mlx5: Set WQ event handler before firmware RQ insertion
      RDMA/mlx5: Set SRQ event handler before xarray insertion
      RDMA/mlx5: Set RQ event handler for raw-packet QP
      RDMA/mlx5: Initialize QP/RQ/SQ resource refcount before publishing it

Yizhou Zhao (1):
      9p/xen: drain response work after unbinding IRQ

Yoann Congal (1):
      printk: Fix LOG_CPU_MAX_BUF_SHIFT when BASE_SMALL is enabled

Yogesh Gaur (10):
      md: don't hand out the array before md_alloc() has added mddev->kobj
      libceph: reject an initial monmap with no monitors
      md/raid5: don't BUG() on an inconsistent reshape state from the superblock
      comedi: comedi_parport: validate the IRQ supplied by userspace
      comedi: ni_atmio16d: validate the IRQ supplied by userspace
      comedi: dt2814: validate the IRQ supplied by userspace
      comedi: dmm32at: validate the IRQ supplied by userspace
      comedi: pcmmio: validate the IRQ supplied by userspace
      comedi: pcmuio: validate the IRQs supplied by userspace
      ceph: don't keep a mon_addr string that failed to parse

Yonatan Nachum (1):
      RDMA/efa: Fix race between admin command timeout and completion

Yonghao Zhang (1):
      remoteproc: core: Set trace buffer name for diagnostics

Yongjian Mu (1):
      xprtrdma: trim head iovec when the payload arrives via a Write chunk

Yongjun Gwon (1):
      ksmbd: serialize directory emptiness checks with readdir

Yosry Ahmed (3):
      KVM: x86: Always initialize EFER reserved bits on vendor initialization
      KVM: x86: Check EFER validity on KVM_SET_SREGS*
      KVM: SVM: Trigger new ASID allocation in both VMCBs on pCPU switch

YouYou Yu (1):
      quota: initialize dquot cache before mounting rootfs

Youngsung Ahn (4):
      RDMA/rxe: refuse to destroy a QP with type 2 MWs still bound
      RDMA/rxe: reject IB_WR_REG_MR from user QPs in rxe_reg_fast_mr()
      RDMA/rxe: validate inline sge_offset in finish_packet() before indexing inline_data[]
      RDMA/rxe: bound the WQE opcode before indexing rxe_wr_opcode_info[]

Younho Choi (1):
      media: vim2m: keep transaction buffer count stable while streaming

Yousef Alhouseen (10):
      net: usb: rtl8150: handle link status read failures
      media: go7007: avoid undefined shifts in MPEG-4 headers
      misc: bcm-vk: validate write size before allocation
      misc: genwqe: handle a first DMA address of zero
      misc: hpilo: validate device queue entries before use
      misc: ibmvmc: release send buffer on write errors
      misc: ibmvmc: reject oversized inbound messages
      media: go7007: s2250: propagate control I/O failures
      HID: hiddev: keep state alive through disconnect unlock
      ntfs3: bound index head insertions by buffer capacity

Youth Cao (1):
      HID: i2c-hid: Add i2c-hid-quirk-bad-input-size quirk for 0911:5288 device

Yu Kuai (1):
      md/raid5: reject zero-sector reshape chunks

Yu Zhang (2):
      nvmet: take subsys->lock while force-reconnecting in nvmet_subsys_attr_qid_max_store()
      scsi: target: Fix demo-mode dynamic ACL dev-entry UAF vs LUN teardown

Yu-Hsiang Tseng (1):
      ALSA: hda/realtek: Fix silent speaker on Higole F9B

YuBiao Wang (1):
      drm/amdgpu: recompute the dw estimate after allocating a new VM update job

Yuan Chen (4):
      bpf: Fix queue/stack map u32 index overflow
      bpftool: Fix spurious batch file read error
      bpftool: Fix out-of-bounds read in kprobe_multi link info dump
      bpftool: Fix inverted tracefs validation when scanning /proc/mounts

YuanZhe Liu (7):
      ALSA: line6: Clear prev_fbuf on capture buffer release
      ALSA: us122l: Add missing NULL check in usb_stream_hwdep_mmap()
      ALSA: us122l: Fix NULL dereference at hwdep open and release
      ALSA: usx2y: Initialize idle URBs before submitting streams
      ALSA: hwdep: Serialize DSP load requests
      ALSA: bcd2000: Fix use-after-free of MIDI URBs on file close
      ALSA: usx2y: Refuse a retried DSP load after a failure

Yuanfu Xie (3):
      ceph: fail readdir when the MDS reply carries no dirfrag
      ceph: clamp MDS reply result code to the errno range
      9p: don't decrement a server-owned zero nlink

Yuanhe Shu (2):
      mm/page_alloc: do not boost watermarks in kdump capture kernels
      scsi: target: Verify the iSCSI ISID is null-terminated

Yuansheng Yang (1):
      io_uring/rsrc: hold uring_lock across index-alloc put_user

Yuchao Zhang (2):
      xen-blkfront: unbind irq before tearing down ring and shadow requests
      md: validate bblog_size when loading v1.x badblocks metadata

Yuejie Shi (1):
      fs/ntfs3: validate the EA value length in ntfs_read_ea()

Yuhang Zheng (1):
      net/sched: cls_flower: avoid stale mask references after delete

Yuho Choi (8):
      driver core: attribute_container: Unwind device_add() on attr failure
      iommu/virtio: Reset device before deleting virtqueues on probe failure
      vdpa/snet: Don't discard the DPU error in snet_send_ctrl_msg()
      PCI: xgene: Use managed clock for PCIe controller
      USB: pci-quirks: Release EHCI device reference
      soc/tegra: flowctrl: Release OF node reference on error
      bus: arm-cci: Drop CPU node reference in cci_ace_init_ports()
      bus: arm-cci: Drop cci-control-port node reference in __cci_ace_get_port()

Yun Zhou (3):
      net: mvneta_bm: add suspend/resume support to prevent crash after resume
      block: reject block device inodes with i_rdev == 0 in lookup_bdev()
      ext4: set EXT4_STATE_NO_EXPAND in ext4_evict_inode

Yunhui Cui (1):
      riscv: mm: exclude invalid THP PMDs from page table check

Yunpeng Tian (2):
      smb: client: reject SetEA requests that do not fit the request buffer
      udf: validate the device specification EA before using it

Yunye Zhao (1):
      md: add cond_resched() to md_do_sync()'s skip path

Yuri Zaporozhets (1):
      ASoC: dwc: Use OF match data again for StarFive JH7110

Yury Norov (1):
      lib/bitmap: split-out string-related operations to a separate files

Yuto Ohnuki (1):
      virtiofs: add FUSE protocol validation

Yuxiang Lin (1):
      HID: quirks: add ALWAYS_POLL quirk for AULA Mini 60 HE Pro Dongle

Yuya Kusakabe (1):
      seg6: fix HMAC validation when an extension header precedes the SRH

Yuyang Huang (1):
      net: prestera: ignore duplicate RIF destruction events

Ze Huang (1):
      drm/imx/lcdc: avoid duplicate clk_per enable

Zeng Heng (1):
      f2fs: Fix not used variable 'index'

Zeng Jingxiang (1):
      mm/vmscan: wake up flushers conditionally to avoid cgroup OOM

Zhan Xusheng (2):
      f2fs: fix defragment writeback range truncation on 32-bit
      fs/ntfs3: fix valid_size not being updated in attr_allocate_frame()

Zhang Heng (4):
      ALSA: hda/realtek: Fix headset mic on ASUS Vivobook S14 S5406SA
      ALSA: hda/realtek: Add quirk for Lenovo IdeaPad Slim 3 15ABR8
      ASoC: amd: yc: Add DMI entry for Alienware m18 R1 AMD
      ALSA: hda/realtek: Add quirk for Acer Nitro AN515-45

Zhang Yi (5):
      ext4: check return value of ext4_get_block() in ext4_load_tail_bh()
      ext4: use FGP_WRITEBEGIN for tail block zeroing
      ASoC: codecs: ES8326: Solve error interruption issue
      ASoC: codecs: ES8326: Minimize the pop noise
      ASoC: codecs: es*: Modify the registers related to ALC RECOVERY

Zhang Zekun (1):
      ata: libahci_platform: Simplify code with for_each_child_of_node_scoped()

ZhangGuoDong (2):
      smb: move smb_sockaddr_in and smb_sockaddr_in6 to common/smb2pdu.h
      smb: move some duplicate definitions to common/smb2pdu.h

Zhao Gongyi (2):
      arm64: mm: validate /dev/mem mmap ranges without overflow
      ata: libata-scsi: reject data-in commands with a data-out buffer

Zhao Li (2):
      wifi: mac80211_hwsim: clear PMSR request state on abort
      wifi: mt76: mt7996: unlink TWT flow if the MCU rejects the agreement

Zhao Zhang (1):
      9p: fix caches_show() out-of-bounds write

ZhaoJinming (1):
      crypto: caam - fix double-free in caam_rsa_set_priv_key_form()

Zhe Liu (2):
      docs: cgroup-v2: fix stale "io" controller introduction
      blk-iocost: account flush sequence latency only once

Zhenhao Wan (2):
      drm/nouveau: reject zero-size notifier object allocation
      drm/nouveau/svm: drain fault handler before freeing svmm

Zhiguo Niu (1):
      f2fs: fix to adjust appropirate defragment pg_end

Zhihao Cheng (1):
      md/raid5: setup_conf: Fix null-ptr-def in error handling path

Zhiling Zou (7):
      xfrm: save input state data before secpath resets
      SUNRPC: trace an accepted transport before publishing it
      tcp: check congestion control restriction first
      ipmr: drop packets with unknown ingress VIF
      ipmr: only copy pktinfo to cache reports
      mm/page_table_check: skip zero pages
      lib: validate in-memory LZ4 chunk length

Zhiwei Zhang (2):
      RDMA/rxe: Check PDs for memory window binds
      RDMA/rxe: Clear pkt->qp before the early drop exits in rxe_rcv()

Zhiyu Zhang (1):
      watch_queue: keep info_id separate from rcu_head

Zhongqiu Han (1):
      cpufreq: stats: Fix potential out-of-bounds access in deferred reset

Zhou Qiuyue (1):
      ipv6: raw: fix use-after-free in rawv6_send_hdrinc()

Zhu Ling (1):
      irqchip/gic: Fix UBSAN shift-out-of-bounds in GIC helpers

Zhu Ning (4):
      ASoC: codecs: ES8326: Changing initialisation and broadcasting
      ASoC: codecs: ES8326: Improving the THD+N performance
      ASoC: codecs: ES8326: Minimize the pop noise on headphone
      ASoC: codecs: ES8326: fix the capture noise issue

Zhu Yanjun (1):
      RDMA/rxe: Flush delayed SKBs while releasing RXE resources

Zi Yan (1):
      USB: gadgetfs: do not WARN about excessively large memory allocations

Zide Chen (1):
      perf/x86/intel/uncore: Fix PCI PMU cleanup on setup failure

Zihan Xi (3):
      net: gso: limit recursive IP-in-IP segmentation
      xsk: account ring allocations to memcg
      smb: client: clean up failed cached directory opens

Zijing Yin (2):
      SUNRPC: fix netns use-after-free in write_gssp()
      wifi: cfg80211: fix out-of-bounds read in valid_rule()

Zijun Hu (1):
      Bluetooth: btusb: Make btusb_recv_{event,acl}() take struct hci_dev *

Zikang Gao (1):
      smb: client: do not pass a NULL buf to is_oplock_break()

Zixuan Chai (1):
      ipv6: defrag: orphan skb before queuing

Zizhen Liu (1):
      net: skbuff: propagate shared-frag marker in skb_zerocopy()

Zizhi Wo (2):
      fat: reject name longer than NAME_MAX in msdos_format_name()
      md/raid10: fix missing wakeup in wait_barrier_nolock

Zongmin Zhou (2):
      slimbus: messaging: fix leaked PM vote on tid allocation failure
      serial: sifive: fix off-by-one in console port bounds check

Zqiang (1):
      rcu/nocb: Check rdp_gp->nocb_timer in __call_rcu_nocb_wake()

alex todadze (1):
      net: stmmac: fix rx checksum offload with extended descriptors

bui duc phuc (64):
      regulator: rt6245: Restore state on enable failure
      ASoC: stm: stm32_i2s: Drop redundant error messages
      ASoC: mediatek: mt8186: Fix APLL mux setting error handling
      ASoC: mediatek: mt8186: Fix clock handling in mux disable path
      ASoC: mediatek: mt8186: Fix AFE clock error handling
      ASoC: mediatek: mt8186: Fix APLL enable error handling
      ASoC: mediatek: mt8186: Fix MCK error handling
      ASoC: mediatek: mt6797: fix wrong unwind order and error code in enable_clock
      ASoC: mediatek: mt8188: mt8188-afe-clk: Handle tuner clock enable errors
      ASoC: mediatek: mt8188: mt8188-afe-clk: Propagate regmap update errors
      ASoC: mediatek: mt8188: mt8188-afe-clk: Handle clock enable errors
      ASoC: mediatek: mt8188: mt8188-afe-pcm: Handle runtime resume errors
      ASoC: mediatek: mt8183: Fix wrong clock cleanup on clk_set_parent() failure
      ASoC: mediatek: mt8183: Fix clock handling in mux disable path
      ASoC: mediatek: mt8183: Fix APLL enable error handling
      ASoC: mediatek: mt8192: fix APLL mux error handling
      ASoC: mediatek: mt8192: fix AFE clock error handling
      ASoC: mediatek: mt8192: fix error handling in APLL enable functions
      ASoC: mediatek: mt8192: fix MCK clock error handling
      ASoC: mediatek: mt8192: switch to devm_clk_get_optional()
      ASoC: mediatek: mt8192: mt8192-afe-gpio: Use guard() for mutex locks
      ASoC: mediatek: mt8192: Propagate errors in mt8192_afe_gpio_request()
      ASoC: mediatek: mt8192: check return values in mt8192_afe_gpio_init()
      ASoC: mediatek: mt8192: Handle regcache_sync() failure in runtime resume
      ASoC: mediatek: mt8192: Propagate mt8192_afe_gpio_request() errors in ADDA DAI
      ASoC: mediatek: mt8192: Propagate errors in TDM DAI DAPM event handlers
      ASoC: mediatek: mt8192: Propagate errors in I2S DAI DAPM event handlers
      ASoC: mediatek: mt8192-mt6359: Fix error handling in MTKAIF calibration
      ASoC: rockchip: rockchip_i2s: Handle runtime PM resume failures in set_fmt
      ASoC: mediatek: common: Handle constraint return value in FE startup
      ASoC: mediatek: mt8188: Handle constraint return value in FE startup
      power: supply: generic-adc-battery: Propagate charged GPIO errors
      ASoC: codecs: rt5659: propagate GPIO errors
      ASoC: amd: acp: Fix .close() being skipped on rollback
      ASoC: amd: ps: Fix acp63_pdm_dma_close() being skipped on rollback
      ASoC: amd: ps: Fix acp63_sdw_dma_close() being skipped on rollback
      ASoC: amd: raven: Fix acp3x_dma_close() being skipped on rollback
      ASoC: amd: renoir: Fix acp_pdm_dma_close() being skipped on rollback
      ASoC: amd: vangogh: Fix acp5x_dma_close() being skipped on rollback
      ASoC: amd: yc: Fix acp6x_pdm_dma_close() being skipped on rollback
      ASoC: atmel: atmel-pcm-pdc: Fix atmel_pcm_close() being skipped on rollback
      ASoC: imx-pcm-rpmsg: Fix imx_rpmsg_pcm_close() being skipped on rollback
      ASoC: intel: atom: Use __free(kfree) for stream pointer
      ASoC: Intel: atom: Use scoped_guard() for scoped locking
      ASoC: intel: atom: Fix .shutdown() being skipped on rollback
      ASoC: atmel-i2s: fix MCK generator error handling
      ASoC: atmel-i2s: use optional API for muxclk
      ASoC: atmel-i2s: use optional API for gclk
      ASoC: mediatek: mt8195: Fix tuner clock error handling
      ASoC: mediatek: mt8195: Fix register access clock error handling
      ASoC: mediatek: mt8195: Fix timing system clock error handling
      ASoC: mediatek: mt8195: Fix main clock error handling
      ASoC: mediatek: mt8195: Fix paired memif clock error handling
      ASoC: mediatek: mt8195: Fix FE startup error handling
      ASoC: mediatek: mt8195: Check paired MEMIF clock enable in FE trigger
      ASoC: mediatek: mt8195: Fix runtime resume error handling
      ASoC: mediatek: mt8195: Propagate IRQ lookup errors
      ASoC: mediatek: mt8195: Fix ETDM MCLK error handling
      ASoC: mediatek: mt8195: Fix ETDM startup error handling
      ASoC: mediatek: mt8195: Fix HDMI TX startup error handling
      ASoC: mediatek: mt8195: Fix ETDM probe error handling
      ASoC: amd: raven: Fix memory leak in acp3x_dma_close()
      clk: lmk04832: Handle reset GPIO lookup errors
      ASoC: xilinx: formatter_pcm: Fix read-modify-write of AUD_CTRL in hw_params

chenglong.ma (1):
      vduse: fix VA/PA confusion in the coherent page fault path

guolingxing (2):
      btrfs: sysfs: restore NOFS context on early return in btrfs_sysfs_add_block_group_type()
      btrfs: prevent deleting the wrong subvolume by ID

hanzhijian (1):
      clk: mstar: msc313-mpll: fix off-by-one in clock array allocation

hpp.iscas (1):
      perf/marvell: cn10k_tad: Publish the OF module alias

liulhong617 (1):
      arm64: mm: fix accidental linear mapping of no-map reserved memory

owen kwan (1):
      net/sched: sch_teql: fix use-after-free on lower qdisc drop

pengdonglin (1):
      tracing: Avoid BTF lookup in atomic context

renpanpan (2):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion 14-dv1001TU
      drm/amdgpu: Only enable HDMI audio if display supports it

sung byeongchan (4):
      ceph: validate fscrypt auth blob length
      ceph: bound name skips in ceph_mdsmap_decode() by the message end
      ceph: validate encoded xattr name lengths
      ceph: validate MDS reply fragtree split array length

vladimir.oltean@nxp.com (1):
      PCI: dra7xx: Remove device links to PHY

wangdicheng (1):
      ALSA: hda/conexant: Add NULL check for dc_mode_path

xiongweimin (1):
      RDMA/rxe: Hold netdev reference for transmit skbs

yanxia (1):
      veth: fix stale peer max_mtu on XDP program replacement

Ömer Mete Kaya (2):
      usbnet: fix smp_processor_id() use in preemptible context
      usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()

イムティヤズ (1):
      wifi: rtw88: fix out-of-bounds CAM write when key table is full

이상호 (1):
      romfs: detect hard link cycles

