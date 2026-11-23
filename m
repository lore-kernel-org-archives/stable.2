Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420814;
	b=iB1J4gtDILuWa6F99bh5MiYQ+QkLSZhGuxSzk/Ty5YcKqt2Keuu8D5rgcYvcp8ejIQqL
	 KJsGIVGOsiQ9ZMo4vzM7tREJDU7ImxRC/OXy0P2Atd+ETtxae/cJPm+R9BjjRuV7Q1ae6
	 h2RbEK4dBeOzUnXVSs3bXp/TkgjhO7PROJFFzqAjFnkrSMR31yN754ANwyKJ1UfIJ61OG
	 j/RhCvmIeK2zvSdHjVvMOR3gC/ZSAhZGqBHi54w1zDQxFAwZuF79tbGqYQ6tOHXhB9hl8
	 5VsqNDUMpXQD2LJLxdjVpWNot9vLXbVA7cuukyF5Csfx5u5xzQurI5I5OjzyRijoHPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420814;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DVqbRrIUxaaoJzZsk9QHjs+OfaEIhv2nMdcdsqY5WwQ=;
	b=T+2QgB7O57mI355pZ7xVWjtYLM1qmSKfuFOWddqWw+JmeyCmAcAJArAdwLwQ4Wue5iIR
	 8CLzSNuywMG26KW7bSNw3qhWAk3i0cFAHsrIUmVaAcoNPxV1wyUUKl8NXqshIDzl1N6wr
	 u9IAKNdF0zU+EvvDrYmtLWYUoNraZ8QM6Sl+NycynyHi6SrIwisaTPusp1kgNUaN8yHBq
	 4JAA1icxpN1A5uupVXvdNYJsmgjn6QZNyWYpFQSrxlQYmV+clFyS606zF2iX+B6cL05DT
	 uHHotQRbzxI1xLfrcDIZdIfOXUVagecPEopI3CVbjiZFTciolRu9T1lMiKes5t341JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZhVSBWCj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B6A60A260B;
	Mon, 23 Nov 2026 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZhVSBWCj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475D81F000C4;
	Mon, 23 Nov 2026 08:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795420813;
	bh=DVqbRrIUxaaoJzZsk9QHjs+OfaEIhv2nMdcdsqY5WwQ=;
	h=From:To:Cc:Subject:Date;
	b=ZhVSBWCj7FhyV9Wpi6oKevBBSmmOv7yE2k/jwJB9u3B3AAhSd5eLpUJvB7FWvOmP7
	 FnvitYVjas6gwoPEGlhMD33PGeEcVs5MjELub+kj9bwPB0KCarDI036oWcvgAqFPqf
	 bZ3yFiW5RByUbj6zbAlHE4xOSEWN6a89dEfZHfao=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.193
Date: Mon, 23 Nov 2026 08:59:41 +0100
Message-ID: <2026112341-monstrous-facedown-f4a0@gregkh>
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

I'm announcing the release of the 6.1.193 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 .gitignore                                                                    |    1 
 Documentation/ABI/testing/sysfs-bus-pci                                       |   14 
 Documentation/ABI/testing/sysfs-class-power-mp2629                            |    2 
 Documentation/PCI/pci-error-recovery.rst                                      |    7 
 Documentation/admin-guide/LSM/LoadPin.rst                                     |   10 
 Documentation/admin-guide/cgroup-v1/memory.rst                                |   46 
 Documentation/admin-guide/cgroup-v2.rst                                       |   10 
 Documentation/admin-guide/kernel-parameters.txt                               |    5 
 Documentation/block/blk-mq.rst                                                |    2 
 Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml              |    2 
 Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml                |    2 
 Documentation/devicetree/bindings/display/msm/hdmi.yaml                       |    4 
 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml                |    3 
 Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml |   21 
 Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml |   76 
 Documentation/devicetree/bindings/vendor-prefixes.yaml                        |  116 
 Documentation/filesystems/fsverity.rst                                        |    3 
 Documentation/filesystems/overlayfs.rst                                       |    3 
 Documentation/networking/ip-sysctl.rst                                        |    5 
 Documentation/trace/histogram.rst                                             |  231 
 Documentation/virt/hyperv/vmbus.rst                                           |   17 
 Documentation/virt/kvm/x86/msr.rst                                            |    1 
 MAINTAINERS                                                                   |    2 
 Makefile                                                                      |    2 
 arch/alpha/include/asm/mmu_context.h                                          |   35 
 arch/alpha/include/asm/sfp-machine.h                                          |    4 
 arch/alpha/include/asm/switch_to.h                                            |    1 
 arch/alpha/include/asm/tlbflush.h                                             |    3 
 arch/alpha/kernel/rtc.c                                                       |   37 
 arch/alpha/kernel/smp.c                                                       |   67 
 arch/alpha/mm/fault.c                                                         |    4 
 arch/alpha/mm/tlbflush.c                                                      |    2 
 arch/arc/Makefile                                                             |    9 
 arch/arc/lib/Makefile                                                         |    8 
 arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi                                |    2 
 arch/arm/boot/dts/armada-388-helios4.dts                                      |   23 
 arch/arm/boot/dts/armada-395-gp.dts                                           |    1 
 arch/arm/boot/dts/gemini.dtsi                                                 |    2 
 arch/arm/boot/dts/imx7-tqma7.dtsi                                             |   40 
 arch/arm/boot/dts/ste-ab8505.dtsi                                             |   17 
 arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts                                     |    2 
 arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi                                  |    2 
 arch/arm/include/asm/smp.h                                                    |    2 
 arch/arm/kernel/head-nommu.S                                                  |    1 
 arch/arm/kernel/head.S                                                        |    1 
 arch/arm/kernel/smp.c                                                         |   15 
 arch/arm/mach-mvebu/Kconfig                                                   |    4 
 arch/arm/mach-versatile/platsmp-vexpress.c                                    |    4 
 arch/arm/mach-versatile/v2m.c                                                 |    4 
 arch/arm/mm/alignment.c                                                       |   61 
 arch/arm/mm/dma-mapping.c                                                     |    5 
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi                                  |    4 
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi                             |    9 
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts                          |    4 
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi                                     |    1 
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                                      |    2 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts                          |    6 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts                            |    6 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                          |    2 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                                      |    2 
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts                               |   32 
 arch/arm64/boot/dts/rockchip/rk3566-base.dtsi                                 |   39 
 arch/arm64/boot/dts/rockchip/rk3566.dtsi                                      |  116 
 arch/arm64/boot/dts/rockchip/rk3568.dtsi                                      |  117 
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi                                 | 1801 
 arch/arm64/boot/dts/rockchip/rk356x.dtsi                                      | 1842 
 arch/arm64/boot/dts/ti/k3-am625-sk.dts                                        |    4 
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                                       |    2 
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
 arch/arm64/kvm/arm.c                                                          |   48 
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h                                |    3 
 arch/arm64/kvm/hyp/nvhe/setup.c                                               |   10 
 arch/arm64/kvm/hyp/nvhe/sys_regs.c                                            |    9 
 arch/arm64/kvm/vgic/vgic-its.c                                                |   37 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                            |   33 
 arch/arm64/mm/mmap.c                                                          |    4 
 arch/arm64/mm/mmu.c                                                           |   14 
 arch/arm64/mm/proc.S                                                          |    8 
 arch/loongarch/include/asm/numa.h                                             |    2 
 arch/loongarch/kernel/irq.c                                                   |    3 
 arch/loongarch/pci/pci.c                                                      |    3 
 arch/m68k/apollo/dn_ints.c                                                    |    6 
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
 arch/powerpc/include/asm/plpks.h                                              |   12 
 arch/powerpc/kvm/book3s_hv.c                                                  |   76 
 arch/powerpc/kvm/book3s_paired_singles.c                                      |    7 
 arch/powerpc/net/bpf_jit.h                                                    |    7 
 arch/powerpc/net/bpf_jit_comp.c                                               |   34 
 arch/powerpc/perf/hv-24x7.c                                                   |   10 
 arch/powerpc/perf/imc-pmu.c                                                   |   23 
 arch/powerpc/platforms/pseries/plpks.c                                        |   31 
 arch/riscv/include/asm/pgtable.h                                              |    9 
 arch/riscv/net/bpf_jit_comp32.c                                               |   47 
 arch/s390/crypto/aes_s390.c                                                   |   10 
 arch/s390/kernel/perf_cpum_cf.c                                               |    3 
 arch/s390/kernel/process.c                                                    |   12 
 arch/s390/kernel/signal.c                                                     |    6 
 arch/s390/kernel/uprobes.c                                                    |    2 
 arch/s390/lib/probes.c                                                        |    2 
 arch/s390/mm/hugetlbpage.c                                                    |    2 
 arch/s390/mm/mmap.c                                                           |    2 
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
 arch/x86/include/asm/cpufeatures.h                                            |    5 
 arch/x86/include/asm/kvm-x86-ops.h                                            |    1 
 arch/x86/include/asm/kvm_host.h                                               |    7 
 arch/x86/include/asm/svm.h                                                    |    4 
 arch/x86/include/asm/xor_avx.h                                                |    4 
 arch/x86/include/uapi/asm/kvm_para.h                                          |    1 
 arch/x86/kernel/acpi/cppc.c                                                   |   15 
 arch/x86/kernel/cpu/amd.c                                                     |   18 
 arch/x86/kernel/cpu/mce/core.c                                                |   23 
 arch/x86/kernel/cpu/microcode/intel.c                                         |   55 
 arch/x86/kernel/kvm.c                                                         |   43 
 arch/x86/kernel/nmi.c                                                         |    8 
 arch/x86/kernel/process.c                                                     |    1 
 arch/x86/kernel/x86_init.c                                                    |    2 
 arch/x86/kvm/hyperv.c                                                         |    2 
 arch/x86/kvm/mmu/mmu.c                                                        |   13 
 arch/x86/kvm/mmu/paging_tmpl.h                                                |   24 
 arch/x86/kvm/svm/nested.c                                                     |   34 
 arch/x86/kvm/svm/svm.c                                                        |   37 
 arch/x86/kvm/svm/svm.h                                                        |    3 
 arch/x86/kvm/vmx/nested.c                                                     |   69 
 arch/x86/kvm/vmx/vmx.c                                                        |    6 
 arch/x86/kvm/x86.c                                                            |  111 
 arch/x86/kvm/xen.c                                                            |   10 
 arch/x86/mm/mem_encrypt_identity.c                                            |    2 
 arch/x86/platform/pvh/enlighten.c                                             |    2 
 arch/x86/power/hibernate.c                                                    |   51 
 block/Kconfig                                                                 |    5 
 block/Makefile                                                                |    1 
 block/bdev.c                                                                  |   22 
 block/blk-cgroup.c                                                            |    6 
 block/blk-crypto-fallback.c                                                   |    6 
 block/blk-flush.c                                                             |    8 
 block/blk-iocost.c                                                            |   11 
 block/blk-map.c                                                               |    1 
 block/blk-merge.c                                                             |    8 
 block/blk-mq-rdma.c                                                           |   44 
 block/blk-mq.c                                                                |   15 
 block/blk-rq-qos.c                                                            |   18 
 block/blk-throttle.c                                                          |    3 
 block/blk-timeout.c                                                           |    3 
 block/blk.h                                                                   |   22 
 block/bsg.c                                                                   |    5 
 block/fops.c                                                                  |   10 
 block/genhd.c                                                                 |    6 
 block/ioctl.c                                                                 |    4 
 block/partitions/mac.c                                                        |    4 
 crypto/algif_skcipher.c                                                       |    9 
 crypto/asymmetric_keys/verify_pefile.c                                        |    5 
 crypto/ecc.c                                                                  |   33 
 crypto/jitterentropy-kcapi.c                                                  |    9 
 crypto/tcrypt.c                                                               |  202 
 crypto/testmgr.c                                                              |   10 
 crypto/testmgr.h                                                              |  339 
 drivers/accessibility/speakup/selection.c                                     |    6 
 drivers/acpi/acpi_extlog.c                                                    |    9 
 drivers/acpi/acpi_fpdt.c                                                      |   53 
 drivers/acpi/acpi_pcc.c                                                       |   68 
 drivers/acpi/acpi_video.c                                                     |   12 
 drivers/acpi/acpica/dsfield.c                                                 |    3 
 drivers/acpi/acpica/exfield.c                                                 |   11 
 drivers/acpi/acpica/nsxfname.c                                                |    1 
 drivers/acpi/apei/ghes.c                                                      |   16 
 drivers/acpi/button.c                                                         |   23 
 drivers/acpi/cppc_acpi.c                                                      |   32 
 drivers/acpi/device_pm.c                                                      |   77 
 drivers/acpi/glue.c                                                           |   10 
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
 drivers/ata/sata_dwc_460ex.c                                                  |    5 
 drivers/ata/sata_fsl.c                                                        |   24 
 drivers/ata/sata_inic162x.c                                                   |  904 
 drivers/ata/sata_qstor.c                                                      |    8 
 drivers/base/attribute_container.c                                            |    7 
 drivers/base/bus.c                                                            |    4 
 drivers/base/core.c                                                           |   13 
 drivers/base/dd.c                                                             |    8 
 drivers/base/node.c                                                           |   17 
 drivers/base/power/wakeirq.c                                                  |   75 
 drivers/block/amiflop.c                                                       |   69 
 drivers/block/aoe/aoenet.c                                                    |   14 
 drivers/block/drbd/drbd_receiver.c                                            |    2 
 drivers/block/floppy.c                                                        |   18 
 drivers/block/loop.c                                                          |    6 
 drivers/block/rnbd/rnbd-srv-sysfs.c                                           |   28 
 drivers/block/rnbd/rnbd-srv.c                                                 |   50 
 drivers/block/rnbd/rnbd-srv.h                                                 |    2 
 drivers/block/swim.c                                                          |  174 
 drivers/block/swim3.c                                                         |    8 
 drivers/block/swim_asm.S                                                      |  136 
 drivers/block/ublk_drv.c                                                      |    6 
 drivers/block/virtio_blk.c                                                    |    2 
 drivers/block/xen-blkback/blkback.c                                           |    7 
 drivers/block/xen-blkfront.c                                                  |   17 
 drivers/bluetooth/btintel.c                                                   |    6 
 drivers/bluetooth/btrsi.c                                                     |    3 
 drivers/bluetooth/btrtl.c                                                     |   11 
 drivers/bluetooth/btrtl.h                                                     |   21 
 drivers/bluetooth/btusb.c                                                     |   51 
 drivers/bluetooth/hci_bcsp.c                                                  |    5 
 drivers/bluetooth/hci_nokia.c                                                 |   20 
 drivers/bluetooth/virtio_bt.c                                                 |    4 
 drivers/bus/arm-cci.c                                                         |    6 
 drivers/char/hw_random/amd-rng.c                                              |    2 
 drivers/char/hw_random/ba431-rng.c                                            |    2 
 drivers/char/hw_random/cctrng.c                                               |    7 
 drivers/char/hw_random/core.c                                                 |    1 
 drivers/char/hw_random/intel-rng.c                                            |    5 
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
 drivers/clk/clk-milbeaut.c                                                    |   10 
 drivers/clk/clk-renesas-pcie.c                                                |    5 
 drivers/clk/clk-si5351.c                                                      |   20 
 drivers/clk/clk.c                                                             |   51 
 drivers/clk/clk.h                                                             |    5 
 drivers/clk/clkdev.c                                                          |    4 
 drivers/clk/imx/clk-composite-93.c                                            |   11 
 drivers/clk/imx/clk-imx8qxp-lpcg.c                                            |    1 
 drivers/clk/imx/clk-imx8qxp.c                                                 |    1 
 drivers/clk/imx/clk.c                                                         |   15 
 drivers/clk/mstar/clk-msc313-mpll.c                                           |    2 
 drivers/clk/qcom/clk-rcg2.c                                                   |   35 
 drivers/clk/qcom/dispcc-sm8450.c                                              |    2 
 drivers/clk/qcom/mmcc-msm8996.c                                               |    4 
 drivers/clk/qcom/mmcc-sdm660.c                                                |    2 
 drivers/clk/sunxi-ng/ccu_common.c                                             |   12 
 drivers/clk/tegra/clk-pll.c                                                   |    1 
 drivers/clk/ti/adpll.c                                                        |    1 
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
 drivers/cpufreq/cpufreq_conservative.c                                        |    8 
 drivers/cpufreq/cpufreq_governor.c                                            |   29 
 drivers/cpufreq/cpufreq_governor.h                                            |    2 
 drivers/cpufreq/cpufreq_stats.c                                               |    4 
 drivers/cpufreq/sparc-us2e-cpufreq.c                                          |   11 
 drivers/cpufreq/sti-cpufreq.c                                                 |    4 
 drivers/cpufreq/tegra194-cpufreq.c                                            |    2 
 drivers/cpuidle/governors/menu.c                                              |    8 
 drivers/cpuidle/governors/teo.c                                               |   11 
 drivers/crypto/amlogic/amlogic-gxl-cipher.c                                   |   25 
 drivers/crypto/amlogic/amlogic-gxl-core.c                                     |    7 
 drivers/crypto/atmel-aes.c                                                    |    4 
 drivers/crypto/atmel-ecc.c                                                    |    8 
 drivers/crypto/atmel-sha.c                                                    |   17 
 drivers/crypto/atmel-tdes.c                                                   |    6 
 drivers/crypto/caam/caampkc.c                                                 |    6 
 drivers/crypto/ccp/ccp-dev-v3.c                                               |    4 
 drivers/crypto/ccp/ccp-dev-v5.c                                               |    4 
 drivers/crypto/hisilicon/hpre/hpre_crypto.c                                   |   22 
 drivers/crypto/keembay/keembay-ocs-ecc.c                                      |    1 
 drivers/crypto/nx/nx-842.c                                                    |    2 
 drivers/crypto/omap-sham.c                                                    |    1 
 drivers/crypto/qat/qat_common/adf_dev_mgr.c                                   |    2 
 drivers/crypto/qat/qat_common/qat_asym_algs.c                                 |    8 
 drivers/crypto/talitos.c                                                      |   93 
 drivers/crypto/talitos.h                                                      |    5 
 drivers/cxl/acpi.c                                                            |   10 
 drivers/dax/super.c                                                           |    2 
 drivers/dma/altera-msgdma.c                                                   |   10 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                                |   75 
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h                                         |    6 
 drivers/dma/fsl_raid.c                                                        |   32 
 drivers/dma/img-mdc-dma.c                                                     |    2 
 drivers/dma/ioat/init.c                                                       |   18 
 drivers/dma/mediatek/mtk-hsdma.c                                              |   26 
 drivers/dma/mv_xor.c                                                          |    1 
 drivers/dma/pl330.c                                                           |   19 
 drivers/dma/plx_dma.c                                                         |   10 
 drivers/dma/qcom/bam_dma.c                                                    |   12 
 drivers/dma/sprd-dma.c                                                        |   45 
 drivers/dma/sun6i-dma.c                                                       |   31 
 drivers/dma/xilinx/xilinx_dma.c                                               |   46 
 drivers/dma/xilinx/zynqmp_dma.c                                               |   56 
 drivers/edac/altera_edac.c                                                    |  115 
 drivers/edac/altera_edac.h                                                    |    1 
 drivers/edac/edac_mc.c                                                        |    6 
 drivers/firmware/cirrus/cs_dsp.c                                              |    2 
 drivers/firmware/efi/cper.c                                                   |   51 
 drivers/firmware/efi/libstub/Makefile                                         |    2 
 drivers/firmware/efi/libstub/efi-stub.c                                       |    8 
 drivers/firmware/efi/libstub/efistub.h                                        |    4 
 drivers/firmware/efi/libstub/fdt.c                                            |    6 
 drivers/firmware/imx/imx-dsp.c                                                |    6 
 drivers/firmware/imx/imx-scu.c                                                |   25 
 drivers/firmware/imx/scu-pd.c                                                 |   10 
 drivers/fpga/fpga-mgr.c                                                       |    2 
 drivers/gpio/gpio-crystalcove.c                                               |    1 
 drivers/gpio/gpio-davinci.c                                                   |    6 
 drivers/gpio/gpio-mvebu.c                                                     |   33 
 drivers/gpio/gpio-pca953x.c                                                   |   28 
 drivers/gpio/gpio-sifive.c                                                    |    1 
 drivers/gpio/gpiolib-cdev.c                                                   |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                                      |   68 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                                    |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c                            |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                              |   43 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c                              |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c                                      |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                        |   51 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                                   |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                    |   57 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                       |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                                       |   20 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                                       |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                                       |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                                       |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                       |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c                                   |    5 
 drivers/gpu/drm/amd/amdgpu/cik.c                                              |   10 
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c                                        |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c                                         |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c                                         |    5 
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c                                          |   13 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c                                        |    4 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c                                        |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c                                        |    8 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c                                        |    6 
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
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c                                         |   17 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/vi.c                                               |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                      |   27 
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c                                         |   35 
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c                                     |   23 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c                              |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c                              |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c                               |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c                               |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                                         |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                                      |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                        |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                          |   16 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                             |   41 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c                     |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c                   |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c                       |   15 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h                       |   24 
 drivers/gpu/drm/amd/display/dc/core/dc_link.c                                 |    6 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c                             |    7 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c                         |   15 
 drivers/gpu/drm/amd/display/dc/dml/Makefile                                   |    4 
 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c                          |    2 
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
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c               |   59 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c               |    7 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c               |    7 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                                     |   19 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                          |   20 
 drivers/gpu/drm/arm/display/include/malidp_product.h                          |   10 
 drivers/gpu/drm/arm/malidp_crtc.c                                             |    1 
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c                            |   13 
 drivers/gpu/drm/bridge/nwl-dsi.c                                              |   17 
 drivers/gpu/drm/bridge/tc358768.c                                             |   11 
 drivers/gpu/drm/drm_connector.c                                               |    1 
 drivers/gpu/drm/drm_crtc.c                                                    |   15 
 drivers/gpu/drm/drm_edid.c                                                    |   42 
 drivers/gpu/drm/drm_of.c                                                      |    8 
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c                                      |   40 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                                         |    6 
 drivers/gpu/drm/exynos/exynos_drm_fimd.c                                      |    2 
 drivers/gpu/drm/i915/display/intel_atomic_plane.c                             |    1 
 drivers/gpu/drm/i915/display/intel_dmc.c                                      |   55 
 drivers/gpu/drm/i915/display/intel_dmc_regs.h                                 |   12 
 drivers/gpu/drm/i915/display/intel_psr.c                                      |    9 
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c                                |    2 
 drivers/gpu/drm/i915/i915_user_extensions.c                                   |    2 
 drivers/gpu/drm/i915/i915_utils.h                                             |    4 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                         |    6 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c                                 |  181 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h                                 |   22 
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c                                      |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c                                       |    2 
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
 drivers/gpu/drm/nouveau/nouveau_svm.c                                         |   13 
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c                             |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild                                |    1 
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c                               |   36 
 drivers/gpu/drm/omapdrm/dss/dsi.c                                             |   63 
 drivers/gpu/drm/panel/panel-simple.c                                          |    3 
 drivers/gpu/drm/panfrost/panfrost_devfreq.c                                   |    2 
 drivers/gpu/drm/panfrost/panfrost_mmu.c                                       |   11 
 drivers/gpu/drm/radeon/r600_dpm.c                                             |   21 
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c                                   |    7 
 drivers/gpu/drm/tegra/submit.c                                                |   12 
 drivers/gpu/drm/tiny/simpledrm.c                                              |    2 
 drivers/gpu/drm/ttm/ttm_bo_util.c                                             |    7 
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
 drivers/hid/hid-ids.h                                                         |    5 
 drivers/hid/hid-input.c                                                       |   17 
 drivers/hid/hid-logitech-dj.c                                                 |    3 
 drivers/hid/hid-mcp2221.c                                                     |    2 
 drivers/hid/hid-multitouch.c                                                  |   21 
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
 drivers/hid/i2c-hid/i2c-hid-core.c                                            |    2 
 drivers/hid/intel-ish-hid/ishtp-hid-client.c                                  |    5 
 drivers/hid/usbhid/hiddev.c                                                   |   37 
 drivers/hid/wacom_sys.c                                                       |  198 
 drivers/hid/wacom_wac.c                                                       |  113 
 drivers/hid/wacom_wac.h                                                       |    6 
 drivers/hsi/controllers/omap_ssi_core.c                                       |    3 
 drivers/hte/hte-tegra194-test.c                                               |    2 
 drivers/hte/hte-tegra194.c                                                    |   10 
 drivers/hv/ring_buffer.c                                                      |   29 
 drivers/hwmon/acpi_power_meter.c                                              |   10 
 drivers/hwmon/aquacomputer_d5next.c                                           |   45 
 drivers/hwmon/asus_wmi_sensors.c                                              |   13 
 drivers/hwmon/coretemp.c                                                      |   13 
 drivers/hwmon/corsair-cpro.c                                                  |   12 
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
 drivers/i2c/busses/i2c-designware-master.c                                    |    8 
 drivers/i2c/busses/i2c-imx.c                                                  |    1 
 drivers/i2c/busses/i2c-mt7621.c                                               |    9 
 drivers/i2c/busses/i2c-qcom-cci.c                                             |   54 
 drivers/i2c/i2c-core-acpi.c                                                   |    7 
 drivers/i3c/master.c                                                          |    3 
 drivers/iio/Makefile                                                          |    1 
 drivers/iio/accel/adis16201.c                                                 |   10 
 drivers/iio/accel/bma220_spi.c                                                |    3 
 drivers/iio/accel/fxls8962af-core.c                                           |    2 
 drivers/iio/accel/kxcjk-1013.c                                                |    1 
 drivers/iio/accel/mma9551.c                                                   |    1 
 drivers/iio/accel/mma9553.c                                                   |    1 
 drivers/iio/adc/at91-sama5d2_adc.c                                            |    1 
 drivers/iio/adc/max1241.c                                                     |    1 
 drivers/iio/dac/ad5758.c                                                      |    8 
 drivers/iio/frequency/admv1013.c                                              |    7 
 drivers/iio/health/max30102.c                                                 |   12 
 drivers/iio/humidity/hts221_core.c                                            |  106 
 drivers/iio/imu/adis16400.c                                                   |    5 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c                             |    8 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c                              |    8 
 drivers/iio/industrialio-acpi.c                                               |   85 
 drivers/iio/industrialio-buffer.c                                             |   48 
 drivers/iio/light/isl29028.c                                                  |   23 
 drivers/iio/light/ltr501.c                                                    |    2 
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
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                      |   50 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                                     |    9 
 drivers/infiniband/hw/cxgb4/cm.c                                              |    5 
 drivers/infiniband/hw/hfi1/chip.c                                             |    4 
 drivers/infiniband/hw/hfi1/fault.c                                            |    1 
 drivers/infiniband/hw/hfi1/file_ops.c                                         |   92 
 drivers/infiniband/hw/hfi1/sdma.c                                             |    3 
 drivers/infiniband/hw/hfi1/verbs.c                                            |    4 
 drivers/infiniband/hw/hns/hns_roce_cq.c                                       |    1 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                    |   37 
 drivers/infiniband/hw/irdma/ctrl.c                                            |    2 
 drivers/infiniband/hw/irdma/pble.c                                            |    6 
 drivers/infiniband/hw/irdma/verbs.c                                           |   10 
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
 drivers/infiniband/sw/rxe/rxe_loc.h                                           |    3 
 drivers/infiniband/sw/rxe/rxe_mr.c                                            |    4 
 drivers/infiniband/sw/rxe/rxe_mw.c                                            |   23 
 drivers/infiniband/sw/rxe/rxe_qp.c                                            |   10 
 drivers/infiniband/sw/rxe/rxe_recv.c                                          |    9 
 drivers/infiniband/sw/rxe/rxe_req.c                                           |    9 
 drivers/infiniband/sw/rxe/rxe_resp.c                                          |    2 
 drivers/infiniband/sw/rxe/rxe_verbs.h                                         |    1 
 drivers/infiniband/sw/siw/siw_main.c                                          |    5 
 drivers/infiniband/sw/siw/siw_qp_tx.c                                         |   20 
 drivers/infiniband/ulp/ipoib/ipoib_main.c                                     |    7 
 drivers/infiniband/ulp/isert/ib_isert.c                                       |    2 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                                        |   32 
 drivers/infiniband/ulp/srp/ib_srp.c                                           |    2 
 drivers/input/joystick/xpad.c                                                 |    5 
 drivers/input/serio/hp_sdc.c                                                  |    2 
 drivers/interconnect/core.c                                                   |   16 
 drivers/interconnect/samsung/exynos.c                                         |    7 
 drivers/iommu/amd/init.c                                                      |   37 
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                                       |   11 
 drivers/iommu/dma-iommu.c                                                     |   20 
 drivers/iommu/intel/dmar.c                                                    |   72 
 drivers/iommu/rockchip-iommu.c                                                |   13 
 drivers/iommu/virtio-iommu.c                                                  |    6 
 drivers/ipack/devices/ipoctal.c                                               |   16 
 drivers/irqchip/irq-atmel-aic.c                                               |    5 
 drivers/irqchip/irq-atmel-aic5.c                                              |    5 
 drivers/irqchip/irq-gic-v3-its.c                                              |  323 
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
 drivers/md/dm-integrity.c                                                     |   54 
 drivers/md/dm-snap-persistent.c                                               |    7 
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
 drivers/media/pci/ivtv/ivtv-vbi.c                                             |    2 
 drivers/media/pci/tw68/tw68-core.c                                            |    2 
 drivers/media/pci/tw686x/tw686x-core.c                                        |   10 
 drivers/media/platform/amphion/vpu_core.c                                     |   19 
 drivers/media/platform/amphion/vpu_drv.c                                      |    1 
 drivers/media/platform/atmel/atmel-isc-base.c                                 |   67 
 drivers/media/platform/atmel/atmel-isc-clk.c                                  |    7 
 drivers/media/platform/atmel/atmel-isc-regs.h                                 |    6 
 drivers/media/platform/atmel/atmel-isc.h                                      |    1 
 drivers/media/platform/atmel/atmel-isi.c                                      |    7 
 drivers/media/platform/atmel/atmel-sama5d2-isc.c                              |   35 
 drivers/media/platform/atmel/atmel-sama7g5-isc.c                              |   37 
 drivers/media/platform/atmel/microchip-csi2dc.c                               |    1 
 drivers/media/platform/m2m-deinterlace.c                                      |    2 
 drivers/media/platform/marvell/Kconfig                                        |    1 
 drivers/media/platform/marvell/mmp-driver.c                                   |    5 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c                          |    4 
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c                   |    2 
 drivers/media/platform/mediatek/vpu/mtk_vpu.c                                 |    2 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                                |   23 
 drivers/media/platform/qcom/camss/camss-vfe-170.c                             |   57 
 drivers/media/platform/qcom/camss/camss-vfe-480.c                             |   40 
 drivers/media/platform/qcom/camss/camss-vfe.c                                 |   39 
 drivers/media/platform/qcom/camss/camss-vfe.h                                 |    9 
 drivers/media/platform/qcom/venus/hfi_msgs.c                                  |    3 
 drivers/media/platform/rockchip/rga/rga.c                                     |   69 
 drivers/media/platform/rockchip/rga/rga.h                                     |    7 
 drivers/media/platform/samsung/exynos4-is/fimc-lite.c                         |    3 
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c                              |    4 
 drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c                         |    7 
 drivers/media/platform/ti/davinci/vpif_capture.c                              |   25 
 drivers/media/platform/ti/davinci/vpif_display.c                              |    3 
 drivers/media/platform/verisilicon/hantro_drv.c                               |   14 
 drivers/media/platform/verisilicon/hantro_g1_mpeg2_dec.c                      |    5 
 drivers/media/rc/fintek-cir.c                                                 |    4 
 drivers/media/rc/imon.c                                                       |    5 
 drivers/media/rc/ir-hix5hd2.c                                                 |    5 
 drivers/media/rc/ir-mce_kbd-decoder.c                                         |    5 
 drivers/media/rc/ir_toy.c                                                     |    2 
 drivers/media/rc/meson-ir-tx.c                                                |   14 
 drivers/media/rc/rc-ir-raw.c                                                  |   38 
 drivers/media/rc/redrat3.c                                                    |   28 
 drivers/media/rc/serial_ir.c                                                  |    2 
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
 drivers/media/usb/uvc/uvc_driver.c                                            |   34 
 drivers/media/v4l2-core/v4l2-common.c                                         |    2 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                                     |   12 
 drivers/memory/brcmstb_dpfe.c                                                 |   41 
 drivers/memory/emif.c                                                         |    9 
 drivers/memory/samsung/exynos5422-dmc.c                                       |   11 
 drivers/mfd/ab8500-core.c                                                     |   44 
 drivers/mfd/da903x.c                                                          |   34 
 drivers/mfd/da9150-core.c                                                     |    8 
 drivers/mfd/intel_quark_i2c_gpio.c                                            |   52 
 drivers/mfd/ipaq-micro.c                                                      |    2 
 drivers/mfd/tps65217.c                                                        |   69 
 drivers/mfd/twl-core.c                                                        |   23 
 drivers/mfd/wcd934x.c                                                         |    8 
 drivers/misc/bcm-vk/bcm_vk_msg.c                                              |   18 
 drivers/misc/enclosure.c                                                      |    3 
 drivers/misc/genwqe/card_utils.c                                              |    2 
 drivers/misc/hpilo.c                                                          |    7 
 drivers/misc/ibmvmc.c                                                         |   17 
 drivers/mmc/core/block.c                                                      |    5 
 drivers/mmc/host/cqhci-core.c                                                 |   14 
 drivers/mmc/host/dw_mmc.c                                                     |    1 
 drivers/mmc/host/mmc_hsq.c                                                    |   48 
 drivers/mmc/host/mmc_hsq.h                                                    |    5 
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
 drivers/mtd/spi-nor/sfdp.c                                                    |    4 
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
 drivers/net/ethernet/broadcom/bgmac.c                                         |   57 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                     |   54 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                                 |   56 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h                                 |    2 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                                |   10 
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                                |    1 
 drivers/net/ethernet/broadcom/tg3.c                                           |   42 
 drivers/net/ethernet/cadence/macb_main.c                                      |    1 
 drivers/net/ethernet/cadence/macb_ptp.c                                       |    4 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c                          |    2 
 drivers/net/ethernet/hisilicon/hisi_femac.c                                   |    1 
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c                                 |   12 
 drivers/net/ethernet/ibm/ibmveth.c                                            |   41 
 drivers/net/ethernet/intel/ice/ice_ptp.c                                      |  276 
 drivers/net/ethernet/intel/ice/ice_ptp.h                                      |   15 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                                 |   40 
 drivers/net/ethernet/jme.c                                                    |   37 
 drivers/net/ethernet/jme.h                                                    |    1 
 drivers/net/ethernet/marvell/mvneta.c                                         |   18 
 drivers/net/ethernet/marvell/mvneta_bm.c                                      |   72 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                           |    4 
 drivers/net/ethernet/marvell/prestera/prestera_router.c                       |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c                         |    4 
 drivers/net/ethernet/mellanox/mlxsw/core.c                                    |    4 
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c                              |    4 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c                           |    2 
 drivers/net/ethernet/microchip/lan966x/lan966x_mac.c                          |    4 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c                         |   19 
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c                          |   10 
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c                         |   15 
 drivers/net/ethernet/pensando/ionic/ionic_main.c                              |   13 
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c                              |    3 
 drivers/net/ethernet/stmicro/stmmac/descs.h                                   |    6 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c                            |   24 
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c                                |   25 
 drivers/net/ethernet/stmicro/stmmac/hwif.h                                    |    6 
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c                               |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                             |   38 
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c                         |    6 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c                        |    2 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                                      |    4 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                             |   86 
 drivers/net/gtp.c                                                             |    7 
 drivers/net/loopback.c                                                        |    8 
 drivers/net/macsec.c                                                          |    5 
 drivers/net/macvlan.c                                                         |    3 
 drivers/net/netdevsim/bpf.c                                                   |   11 
 drivers/net/ppp/ppp_generic.c                                                 |    1 
 drivers/net/ppp/pppoe.c                                                       |   25 
 drivers/net/team/team.c                                                       |   11 
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
 drivers/net/virtio_net.c                                                      |    8 
 drivers/net/vxlan/vxlan_core.c                                                |   14 
 drivers/net/wireless/ath/ath10k/htt_rx.c                                      |    6 
 drivers/net/wireless/ath/ath10k/htt_tx.c                                      |   12 
 drivers/net/wireless/ath/ath11k/ce.c                                          |    2 
 drivers/net/wireless/ath/ath11k/core.c                                        |    3 
 drivers/net/wireless/ath/ath11k/dp.c                                          |    2 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                       |   19 
 drivers/net/wireless/ath/ath11k/mac.c                                         |   33 
 drivers/net/wireless/ath/ath11k/mac.h                                         |    2 
 drivers/net/wireless/ath/ath11k/wmi.c                                         |    6 
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
 drivers/net/wireless/mediatek/mt76/eeprom.c                                   |   17 
 drivers/net/wireless/mediatek/mt76/mac80211.c                                 |   15 
 drivers/net/wireless/mediatek/mt76/mt76.h                                     |    1 
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c                            |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c                            |    1 
 drivers/net/wireless/mediatek/mt76/mt7603/main.c                              |   74 
 drivers/net/wireless/mediatek/mt76/mt7615/init.c                              |   15 
 drivers/net/wireless/mediatek/mt76/mt7615/main.c                              |    6 
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                               |   13 
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c                          |    1 
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c                           |    5 
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c                               |   17 
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c                          |    5 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h                          |    1 
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                              |   33 
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c                          |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                            |    6 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                              |   24 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                               |   28 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                              |    8 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                               |   35 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                               |    8 
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                            |    6 
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h                              |   22 
 drivers/net/wireless/mediatek/mt76/mt7921/init.c                              |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                              |   83 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                               |   40 
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                            |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/testmode.c                          |    1 
 drivers/net/wireless/mediatek/mt76/tx.c                                       |   25 
 drivers/net/wireless/mediatek/mt76/usb.c                                      |   47 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c                         |   22 
 drivers/net/wireless/realtek/rtlwifi/pci.c                                    |   39 
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c                           |    6 
 drivers/net/wireless/realtek/rtw88/debug.c                                    |    5 
 drivers/net/wireless/realtek/rtw88/mac80211.c                                 |    2 
 drivers/net/wireless/realtek/rtw89/fw.c                                       |   15 
 drivers/net/wireless/rsi/rsi_91x_core.c                                       |    2 
 drivers/net/wireless/silabs/wfx/bh.c                                          |    6 
 drivers/net/wireless/silabs/wfx/bus_sdio.c                                    |    1 
 drivers/net/wireless/silabs/wfx/main.c                                        |   46 
 drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c                                 |    5 
 drivers/net/wwan/wwan_hwsim.c                                                 |    4 
 drivers/net/xen-netback/netback.c                                             |    9 
 drivers/net/xen-netback/xenbus.c                                              |    8 
 drivers/nfc/nfcmrvl/spi.c                                                     |    4 
 drivers/nfc/nxp-nci/i2c.c                                                     |    4 
 drivers/nvdimm/pmem.c                                                         |    6 
 drivers/nvme/host/auth.c                                                      |   22 
 drivers/nvme/host/core.c                                                      |   32 
 drivers/nvme/host/fabrics.c                                                   |   94 
 drivers/nvme/host/fabrics.h                                                   |   11 
 drivers/nvme/host/fc.c                                                        |    2 
 drivers/nvme/host/nvme.h                                                      |    6 
 drivers/nvme/host/pci.c                                                       |    7 
 drivers/nvme/host/rdma.c                                                      |   83 
 drivers/nvme/host/tcp.c                                                       |  128 
 drivers/nvme/host/zns.c                                                       |    8 
 drivers/nvme/target/admin-cmd.c                                               |   16 
 drivers/nvme/target/auth.c                                                    |    2 
 drivers/nvme/target/configfs.c                                                |  114 
 drivers/nvme/target/core.c                                                    |   20 
 drivers/nvme/target/fabrics-cmd-auth.c                                        |   49 
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
 drivers/nvmem/rockchip-otp.c                                                  |   95 
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
 drivers/pci/pcie/aer.c                                                        |  107 
 drivers/pci/pcie/portdrv_core.c                                               |   28 
 drivers/pci/probe.c                                                           |   15 
 drivers/pci/quirks.c                                                          |    5 
 drivers/pci/switch/switchtec.c                                                |    1 
 drivers/pci/xen-pcifront.c                                                    |   16 
 drivers/peci/controller/peci-aspeed.c                                         |    6 
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
 drivers/pinctrl/stm32/pinctrl-stm32.c                                         |    9 
 drivers/pinctrl/sunplus/Kconfig                                               |    8 
 drivers/platform/chrome/cros_ec_proto.c                                       |   32 
 drivers/platform/chrome/cros_ec_proto_test.c                                  |  158 
 drivers/platform/chrome/cros_ec_typec.c                                       |   87 
 drivers/platform/chrome/cros_ec_typec.h                                       |   85 
 drivers/platform/olpc/olpc-ec.c                                               |    2 
 drivers/platform/x86/amd/pmc.c                                                |    5 
 drivers/platform/x86/amd/pmf/core.c                                           |    1 
 drivers/platform/x86/asus-nb-wmi.c                                            |    1 
 drivers/platform/x86/asus-wmi.c                                               |  117 
 drivers/platform/x86/gpd-pocket-fan.c                                         |    9 
 drivers/platform/x86/hp/hp-wmi.c                                              |    7 
 drivers/platform/x86/ibm_rtl.c                                                |    8 
 drivers/platform/x86/intel/int3472/discrete.c                                 |   16 
 drivers/platform/x86/intel/telemetry/core.c                                   |    4 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c                |    2 
 drivers/platform/x86/simatic-ipc.c                                            |   12 
 drivers/platform/x86/think-lmi.c                                              |   86 
 drivers/platform/x86/toshiba_acpi.c                                           |    9 
 drivers/power/reset/piix4-poweroff.c                                          |    1 
 drivers/power/supply/ab8500_bmdata.c                                          |    2 
 drivers/power/supply/ab8500_btemp.c                                           |   28 
 drivers/power/supply/ab8500_chargalg.c                                        |    9 
 drivers/power/supply/ab8500_charger.c                                         |  400 
 drivers/power/supply/ab8500_fg.c                                              |   94 
 drivers/power/supply/bq24190_charger.c                                        |    9 
 drivers/power/supply/bq2515x_charger.c                                        |   15 
 drivers/power/supply/bq27xxx_battery.c                                        |   16 
 drivers/power/supply/cros_peripheral_charger.c                                |   13 
 drivers/power/supply/generic-adc-battery.c                                    |   86 
 drivers/power/supply/gpio-charger.c                                           |    5 
 drivers/power/supply/ltc2941-battery-gauge.c                                  |    6 
 drivers/power/supply/power_supply_core.c                                      |   67 
 drivers/pwm/pwm-lp3943.c                                                      |   22 
 drivers/pwm/pwm-mtk-disp.c                                                    |    4 
 drivers/pwm/pwm-renesas-tpu.c                                                 |   45 
 drivers/pwm/pwm-tiehrpwm.c                                                    |    3 
 drivers/rapidio/devices/rio_mport_cdev.c                                      |    5 
 drivers/regulator/ab8500.c                                                    |  159 
 drivers/regulator/core.c                                                      |   48 
 drivers/regulator/devres.c                                                    |   80 
 drivers/regulator/fixed.c                                                     |   54 
 drivers/regulator/internal.h                                                  |    2 
 drivers/regulator/irq_helpers.c                                               |   40 
 drivers/regulator/max77802-regulator.c                                        |    4 
 drivers/regulator/mp886x.c                                                    |   13 
 drivers/regulator/of_regulator.c                                              |   27 
 drivers/regulator/qcom-rpmh-regulator.c                                       |    6 
 drivers/regulator/qcom_smd-regulator.c                                        |    2 
 drivers/regulator/rt6245-regulator.c                                          |    5 
 drivers/remoteproc/imx_dsp_rproc.c                                            |   58 
 drivers/remoteproc/qcom_q6v5_adsp.c                                           |    2 
 drivers/remoteproc/remoteproc_core.c                                          |   26 
 drivers/remoteproc/remoteproc_elf_loader.c                                    |   23 
 drivers/rpmsg/mtk_rpmsg.c                                                     |    1 
 drivers/rpmsg/rpmsg_char.c                                                    |    5 
 drivers/rpmsg/virtio_rpmsg_bus.c                                              |  118 
 drivers/rtc/Kconfig                                                           |   21 
 drivers/rtc/class.c                                                           |    8 
 drivers/rtc/rtc-ab-eoz9.c                                                     |    1 
 drivers/rtc/rtc-abx80x.c                                                      |    6 
 drivers/rtc/rtc-bd70528.c                                                     |    5 
 drivers/rtc/rtc-brcmstb-waketimer.c                                           |    1 
 drivers/rtc/rtc-cmos.c                                                        |    6 
 drivers/rtc/rtc-ds1307.c                                                      |    2 
 drivers/rtc/rtc-ds1685.c                                                      |   20 
 drivers/rtc/rtc-ftrtc010.c                                                    |   26 
 drivers/rtc/rtc-mpfs.c                                                        |    4 
 drivers/rtc/rtc-s35390a.c                                                     |  149 
 drivers/s390/block/dasd.c                                                     |   10 
 drivers/s390/char/vmcp.c                                                      |    4 
 drivers/s390/crypto/zcrypt_ccamisc.c                                          |   22 
 drivers/s390/virtio/virtio_ccw.c                                              |    2 
 drivers/scsi/aic7xxx/aic7xxx_core.c                                           |    8 
 drivers/scsi/aic7xxx/aic7xxx_pci.c                                            |   20 
 drivers/scsi/dc395x.c                                                         |   10 
 drivers/scsi/elx/libefc/efclib.c                                              |    2 
 drivers/scsi/ibmvscsi/ibmvfc.c                                                |   10 
 drivers/scsi/libiscsi_tcp.c                                                   |    3 
 drivers/scsi/libsas/sas_task.c                                                |    2 
 drivers/scsi/mpi3mr/mpi3mr.h                                                  |   10 
 drivers/scsi/mpi3mr/mpi3mr_app.c                                              |   45 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                               |   17 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                               |  207 
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
 drivers/soc/ixp4xx/ixp4xx-qmgr.c                                              |    1 
 drivers/soc/qcom/apr.c                                                        |   44 
 drivers/soc/tegra/flowctrl.c                                                  |    7 
 drivers/soundwire/Makefile                                                    |    2 
 drivers/soundwire/dmi-quirks.c                                                |   42 
 drivers/soundwire/intel.c                                                     |  658 
 drivers/soundwire/intel.h                                                     |   96 
 drivers/soundwire/intel_auxdevice.c                                           |  678 
 drivers/soundwire/intel_auxdevice.h                                           |   18 
 drivers/soundwire/intel_init.c                                                |    2 
 drivers/spi/spi-amd.c                                                         |   15 
 drivers/spi/spi-bcm-qspi.c                                                    |    3 
 drivers/spi/spi-bcm63xx-hsspi.c                                               |    8 
 drivers/spi/spi-cadence-quadspi.c                                             |    3 
 drivers/spi/spi-cadence-xspi.c                                                |   19 
 drivers/spi/spi-jcore.c                                                       |    2 
 drivers/spi/spi-mtk-nor.c                                                     |    1 
 drivers/spi/spi-mxic.c                                                        |    8 
 drivers/spi/spi-npcm-fiu.c                                                    |    8 
 drivers/spi/spi-omap2-mcspi.c                                                 |    2 
 drivers/spi/spi-rspi.c                                                        |   63 
 drivers/spi/spi-sh-msiof.c                                                    |   50 
 drivers/spi/spi-sun4i.c                                                       |   63 
 drivers/spi/spi-tegra114.c                                                    |   49 
 drivers/spi/spi-zynq-qspi.c                                                   |   13 
 drivers/spi/spi.c                                                             |    2 
 drivers/staging/greybus/uart.c                                                |   30 
 drivers/staging/iio/adc/ad7816.c                                              |   33 
 drivers/staging/media/deprecated/saa7146/av7110/sp8870.c                      |    5 
 drivers/staging/media/deprecated/saa7146/common/saa7146_core.c                |    3 
 drivers/staging/media/imx/imx-media-csc-scaler.c                              |    1 
 drivers/staging/media/meson/vdec/vdec.c                                       |    2 
 drivers/staging/octeon/ethernet-tx.c                                          |    2 
 drivers/staging/rtl8723bs/core/rtw_mlme.c                                     |   43 
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                                 |   11 
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c                                  |    6 
 drivers/staging/rtl8723bs/core/rtw_recv.c                                     |  162 
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c                                  |    6 
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
 drivers/thermal/intel/intel_powerclamp.c                                      |    3 
 drivers/thermal/sprd_thermal.c                                                |    6 
 drivers/thermal/ti-soc-thermal/ti-bandgap.c                                   |   10 
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c                            |    4 
 drivers/thunderbolt/icm.c                                                     |    6 
 drivers/tty/n_gsm.c                                                           |   47 
 drivers/tty/serial/8250/8250_exar.c                                           |   59 
 drivers/tty/serial/8250/8250_lpss.c                                           |    7 
 drivers/tty/serial/8250/8250_omap.c                                           |   17 
 drivers/tty/serial/amba-pl011.c                                               |   15 
 drivers/tty/serial/max310x.c                                                  |  380 
 drivers/tty/serial/pch_uart.c                                                 |    5 
 drivers/tty/serial/pmac_zilog.c                                               |    5 
 drivers/tty/serial/sc16is7xx.c                                                |   12 
 drivers/tty/serial/serial_core.c                                              |   69 
 drivers/tty/serial/sifive.c                                                   |    2 
 drivers/ufs/core/ufs_bsg.c                                                    |    6 
 drivers/ufs/core/ufshcd.c                                                     |   60 
 drivers/uio/uio_sercos3.c                                                     |    1 
 drivers/usb/cdns3/cdnsp-gadget.c                                              |  111 
 drivers/usb/cdns3/cdnsp-gadget.h                                              |    1 
 drivers/usb/cdns3/cdnsp-mem.c                                                 |   98 
 drivers/usb/class/cdc-acm.c                                                   |    6 
 drivers/usb/core/config.c                                                     |   32 
 drivers/usb/core/driver.c                                                     |    1 
 drivers/usb/core/message.c                                                    |    1 
 drivers/usb/core/quirks.c                                                     |    7 
 drivers/usb/gadget/composite.c                                                |    2 
 drivers/usb/gadget/configfs.c                                                 |    4 
 drivers/usb/gadget/function/f_mass_storage.c                                  |    7 
 drivers/usb/gadget/function/u_audio.c                                         |   12 
 drivers/usb/gadget/legacy/inode.c                                             |   24 
 drivers/usb/gadget/udc/dummy_hcd.c                                            |    4 
 drivers/usb/gadget/udc/fotg210-udc.c                                          |   17 
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
 drivers/vdpa/vdpa_user/iova_domain.c                                          |   11 
 drivers/vfio/iova_bitmap.c                                                    |   18 
 drivers/vfio/pci/mlx5/cmd.c                                                   |    2 
 drivers/vhost/vdpa.c                                                          |    8 
 drivers/vhost/vringh.c                                                        |   27 
 drivers/vhost/vsock.c                                                         |   36 
 drivers/video/backlight/lm3630a_bl.c                                          |    1 
 drivers/video/backlight/qcom-wled.c                                           |   35 
 drivers/video/console/sticore.c                                               |   22 
 drivers/video/fbdev/atmel_lcdfb.c                                             |   24 
 drivers/video/fbdev/core/bitblit.c                                            |    7 
 drivers/video/fbdev/core/fbcon.c                                              |   64 
 drivers/video/fbdev/core/fbcon_rotate.c                                       |    3 
 drivers/video/fbdev/core/fbsysfs.c                                            |    1 
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
 fs/afs/rxrpc.c                                                                |   34 
 fs/aio.c                                                                      |   18 
 fs/btrfs/ctree.h                                                              |    2 
 fs/btrfs/disk-io.c                                                            |    6 
 fs/btrfs/inode.c                                                              |    3 
 fs/btrfs/ioctl.c                                                              |   34 
 fs/btrfs/qgroup.c                                                             |    4 
 fs/btrfs/relocation.c                                                         |   11 
 fs/btrfs/sysfs.c                                                              |    1 
 fs/btrfs/tree-mod-log.c                                                       |  161 
 fs/btrfs/verity.c                                                             |  101 
 fs/btrfs/volumes.c                                                            |    6 
 fs/btrfs/zoned.c                                                              |    8 
 fs/ceph/addr.c                                                                |   16 
 fs/ceph/caps.c                                                                |    6 
 fs/ceph/dir.c                                                                 |   14 
 fs/ceph/inode.c                                                               |    3 
 fs/ceph/mds_client.c                                                          |   26 
 fs/ceph/mdsmap.c                                                              |   12 
 fs/ceph/snap.c                                                                |    7 
 fs/ceph/super.c                                                               |   18 
 fs/ceph/super.h                                                               |    1 
 fs/ceph/xattr.c                                                               |   10 
 fs/configfs/dir.c                                                             |   13 
 fs/configfs/symlink.c                                                         |   51 
 fs/dax.c                                                                      |   12 
 fs/dcache.c                                                                   |    2 
 fs/dlm/lock.c                                                                 |    4 
 fs/dlm/lowcomms.c                                                             |    6 
 fs/erofs/decompressor.c                                                       |    2 
 fs/eventpoll.c                                                                |   18 
 fs/exec.c                                                                     |   12 
 fs/exfat/balloc.c                                                             |   31 
 fs/exfat/dir.c                                                                |    8 
 fs/ext4/balloc.c                                                              |    6 
 fs/ext4/crypto.c                                                              |   10 
 fs/ext4/ext4.h                                                                |   38 
 fs/ext4/extents.c                                                             |   26 
 fs/ext4/indirect.c                                                            |   17 
 fs/ext4/inode.c                                                               |   18 
 fs/ext4/mballoc.c                                                             |   28 
 fs/ext4/namei.c                                                               |   23 
 fs/ext4/super.c                                                               |   37 
 fs/f2fs/compress.c                                                            |   10 
 fs/f2fs/data.c                                                                |   11 
 fs/f2fs/dir.c                                                                 |    6 
 fs/f2fs/file.c                                                                |   48 
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
 fs/fuse/file.c                                                                |   12 
 fs/fuse/virtio_fs.c                                                           |   80 
 fs/gfs2/bmap.c                                                                |    2 
 fs/gfs2/glops.c                                                               |   10 
 fs/gfs2/inode.c                                                               |    2 
 fs/hfs/btree.c                                                                |    7 
 fs/hfsplus/btree.c                                                            |    7 
 fs/hfsplus/extents.c                                                          |    2 
 fs/hugetlbfs/inode.c                                                          |    2 
 fs/inode.c                                                                    |   15 
 fs/iomap/buffered-io.c                                                        |    3 
 fs/iomap/fiemap.c                                                             |    8 
 fs/isofs/dir.c                                                                |    4 
 fs/isofs/inode.c                                                              |    2 
 fs/isofs/isofs.h                                                              |   13 
 fs/isofs/joliet.c                                                             |   27 
 fs/isofs/namei.c                                                              |    3 
 fs/isofs/rock.c                                                               |   11 
 fs/jbd2/checkpoint.c                                                          |   50 
 fs/jbd2/commit.c                                                              |    2 
 fs/jbd2/journal.c                                                             |    2 
 fs/lockd/svclock.c                                                            |    2 
 fs/namespace.c                                                                |   57 
 fs/nfs/blocklayout/blocklayout.h                                              |    5 
 fs/nfs/blocklayout/rpc_pipefs.c                                               |   79 
 fs/nfs/callback_xdr.c                                                         |    9 
 fs/nfs/dir.c                                                                  |   13 
 fs/nfs/filelayout/filelayout.c                                                |   13 
 fs/nfs/filelayout/filelayoutdev.c                                             |   17 
 fs/nfs/flexfilelayout/flexfilelayout.c                                        |   25 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                                     |   17 
 fs/nfs/internal.h                                                             |    1 
 fs/nfs/netns.h                                                                |    5 
 fs/nfs/nfs3proc.c                                                             |    8 
 fs/nfs/nfs4_fs.h                                                              |    2 
 fs/nfs/nfs4proc.c                                                             |   13 
 fs/nfs/nfs4state.c                                                            |   38 
 fs/nfs/pnfs.c                                                                 |    2 
 fs/nfs/pnfs.h                                                                 |    1 
 fs/nfs/pnfs_nfs.c                                                             |   21 
 fs/nfs/proc.c                                                                 |    8 
 fs/nfsd/blocklayout.c                                                         |    4 
 fs/nfsd/flexfilelayout.c                                                      |   24 
 fs/nfsd/flexfilelayoutxdr.c                                                   |    4 
 fs/nfsd/flexfilelayoutxdr.h                                                   |    5 
 fs/nfsd/netns.h                                                               |   25 
 fs/nfsd/nfs4idmap.c                                                           |    4 
 fs/nfsd/nfs4layouts.c                                                         |    7 
 fs/nfsd/nfs4proc.c                                                            |    8 
 fs/nfsd/nfs4recover.c                                                         |  128 
 fs/nfsd/nfs4state.c                                                           |  166 
 fs/nfsd/nfs4xdr.c                                                             |   26 
 fs/nfsd/nfsctl.c                                                              |   14 
 fs/nfsd/nfssvc.c                                                              |   20 
 fs/nfsd/pnfs.h                                                                |    4 
 fs/nfsd/xdr4.h                                                                |    1 
 fs/nilfs2/dir.c                                                               |   34 
 fs/nilfs2/gcinode.c                                                           |   24 
 fs/nilfs2/inode.c                                                             |   22 
 fs/nilfs2/ioctl.c                                                             |    2 
 fs/nilfs2/mdt.c                                                               |    6 
 fs/nilfs2/namei.c                                                             |    8 
 fs/nilfs2/page.c                                                              |   50 
 fs/nilfs2/page.h                                                              |    4 
 fs/nilfs2/recovery.c                                                          |   49 
 fs/nilfs2/segbuf.c                                                            |   12 
 fs/nilfs2/segment.c                                                           |   54 
 fs/nilfs2/sysfs.c                                                             |    5 
 fs/nilfs2/the_nilfs.c                                                         |   46 
 fs/notify/fanotify/fanotify.c                                                 |    7 
 fs/notify/fanotify/fanotify.h                                                 |   21 
 fs/notify/inotify/inotify_fsnotify.c                                          |    2 
 fs/ntfs3/attrib.c                                                             |   33 
 fs/ntfs3/dir.c                                                                |    5 
 fs/ntfs3/frecord.c                                                            |   36 
 fs/ntfs3/fslog.c                                                              |   29 
 fs/ntfs3/fsntfs.c                                                             |    3 
 fs/ntfs3/index.c                                                              |   14 
 fs/ntfs3/inode.c                                                              |   25 
 fs/ntfs3/namei.c                                                              |    9 
 fs/ntfs3/ntfs_fs.h                                                            |    2 
 fs/ntfs3/super.c                                                              |    2 
 fs/ntfs3/xattr.c                                                              |   27 
 fs/ocfs2/alloc.c                                                              |   18 
 fs/ocfs2/cluster/heartbeat.c                                                  |   60 
 fs/ocfs2/cluster/netdebug.c                                                   |    4 
 fs/ocfs2/cluster/nodemanager.c                                                |   10 
 fs/ocfs2/cluster/quorum.c                                                     |    7 
 fs/ocfs2/cluster/quorum.h                                                     |    1 
 fs/ocfs2/cluster/tcp.c                                                        |   13 
 fs/ocfs2/dcache.h                                                             |    5 
 fs/ocfs2/dlm/dlmconvert.c                                                     |   10 
 fs/ocfs2/dlm/dlmdebug.c                                                       |    5 
 fs/ocfs2/dlm/dlmdomain.c                                                      |    3 
 fs/ocfs2/dlm/dlmlock.c                                                        |    8 
 fs/ocfs2/dlm/dlmmaster.c                                                      |   70 
 fs/ocfs2/dlmglue.c                                                            |   97 
 fs/ocfs2/dlmglue.h                                                            |    5 
 fs/ocfs2/export.c                                                             |   10 
 fs/ocfs2/file.c                                                               |  102 
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
 fs/ocfs2/xattr.c                                                              |  414 
 fs/ocfs2/xattr.h                                                              |   12 
 fs/overlayfs/copy_up.c                                                        |  104 
 fs/overlayfs/dir.c                                                            |   21 
 fs/overlayfs/export.c                                                         |    4 
 fs/overlayfs/file.c                                                           |    4 
 fs/overlayfs/inode.c                                                          |   14 
 fs/overlayfs/namei.c                                                          |   21 
 fs/overlayfs/overlayfs.h                                                      |   10 
 fs/overlayfs/readdir.c                                                        |   70 
 fs/overlayfs/super.c                                                          |   17 
 fs/overlayfs/util.c                                                           |    2 
 fs/proc/generic.c                                                             |    3 
 fs/pstore/ram.c                                                               |    1 
 fs/pstore/ram_core.c                                                          |    6 
 fs/read_write.c                                                               |    8 
 fs/romfs/super.c                                                              |    8 
 fs/signalfd.c                                                                 |   28 
 fs/smb/client/cached_dir.c                                                    |   33 
 fs/smb/client/cifs_fs_sb.h                                                    |    1 
 fs/smb/client/cifsacl.c                                                       |    2 
 fs/smb/client/cifsfs.c                                                        |   48 
 fs/smb/client/cifsglob.h                                                      |    2 
 fs/smb/client/cifssmb.c                                                       |  269 
 fs/smb/client/connect.c                                                       |   51 
 fs/smb/client/file.c                                                          |   34 
 fs/smb/client/misc.c                                                          |   21 
 fs/smb/client/readdir.c                                                       |   69 
 fs/smb/client/sess.c                                                          |    6 
 fs/smb/client/smb2ops.c                                                       |  117 
 fs/smb/client/smb2pdu.c                                                       |   35 
 fs/smb/client/transport.c                                                     |    4 
 fs/smb/common/smb2pdu.h                                                       |    6 
 fs/smb/server/Kconfig                                                         |    1 
 fs/smb/server/auth.c                                                          |    3 
 fs/smb/server/connection.c                                                    |   24 
 fs/smb/server/ksmbd_netlink.h                                                 |    2 
 fs/smb/server/mgmt/user_session.c                                             |    4 
 fs/smb/server/misc.c                                                          |    8 
 fs/smb/server/oplock.c                                                        |   13 
 fs/smb/server/server.c                                                        |   23 
 fs/smb/server/smb2pdu.c                                                       |  425 
 fs/smb/server/smb2pdu.h                                                       |    1 
 fs/smb/server/smb_common.c                                                    |   10 
 fs/smb/server/smbacl.c                                                        |   34 
 fs/smb/server/transport_ipc.c                                                 |   16 
 fs/smb/server/transport_rdma.c                                                |    1 
 fs/smb/server/transport_tcp.c                                                 |   15 
 fs/smb/server/vfs.c                                                           |  131 
 fs/smb/server/vfs.h                                                           |    3 
 fs/smb/server/xattr.h                                                         |    2 
 fs/splice.c                                                                   |   95 
 fs/stat.c                                                                     |    6 
 fs/udf/balloc.c                                                               |   11 
 fs/udf/inode.c                                                                |   54 
 fs/udf/super.c                                                                |   45 
 fs/udf/truncate.c                                                             |    7 
 fs/ufs/cylinder.c                                                             |   31 
 fs/ufs/dir.c                                                                  |    2 
 fs/userfaultfd.c                                                              |   14 
 fs/verity/measure.c                                                           |   10 
 fs/verity/open.c                                                              |   38 
 fs/verity/read_metadata.c                                                     |   14 
 fs/xfs/libxfs/xfs_attr_leaf.c                                                 |   22 
 fs/xfs/libxfs/xfs_bmap.c                                                      |   14 
 fs/xfs/libxfs/xfs_bmap.h                                                      |   10 
 fs/xfs/libxfs/xfs_btree.c                                                     |    4 
 fs/xfs/libxfs/xfs_da_btree.c                                                  |   13 
 fs/xfs/scrub/attr.c                                                           |   18 
 fs/xfs/scrub/bmap.c                                                           |    7 
 fs/xfs/scrub/btree.c                                                          |   16 
 fs/xfs/scrub/common.c                                                         |    7 
 fs/xfs/scrub/dabtree.c                                                        |   27 
 fs/xfs/scrub/dir.c                                                            |   60 
 fs/xfs/scrub/fscounters.c                                                     |    7 
 fs/xfs/scrub/quota.c                                                          |    8 
 fs/xfs/scrub/refcount.c                                                       |   23 
 fs/xfs/scrub/trace.c                                                          |   13 
 fs/xfs/scrub/trace.h                                                          |   10 
 fs/xfs/xfs_discard.c                                                          |    5 
 fs/xfs/xfs_inode_item_recover.c                                               |   20 
 fs/xfs/xfs_ioctl32.c                                                          |    4 
 fs/xfs/xfs_iomap.c                                                            |    8 
 fs/xfs/xfs_pnfs.c                                                             |   43 
 include/acpi/acpi_bus.h                                                       |    2 
 include/acpi/acpi_drivers.h                                                   |    9 
 include/asm-generic/bitops/le.h                                               |   18 
 include/asm-generic/tlb.h                                                     |    3 
 include/drm/drm_connector.h                                                   |   18 
 include/drm/ttm/ttm_bo_api.h                                                  |    4 
 include/kvm/arm_vgic.h                                                        |    1 
 include/linux/acpi.h                                                          |   24 
 include/linux/assoc_array_priv.h                                              |    2 
 include/linux/blk-mq-rdma.h                                                   |   11 
 include/linux/can/can-ml.h                                                    |    3 
 include/linux/cleanup.h                                                       |   52 
 include/linux/clk-provider.h                                                  |   22 
 include/linux/compiler.h                                                      |    1 
 include/linux/damon.h                                                         |    6 
 include/linux/device.h                                                        |  131 
 include/linux/device/bus.h                                                    |    3 
 include/linux/etherdevice.h                                                   |   28 
 include/linux/fault-inject.h                                                  |   10 
 include/linux/firewire.h                                                      |    1 
 include/linux/fortify-string.h                                                |    2 
 include/linux/fs.h                                                            |    4 
 include/linux/hid.h                                                           |    1 
 include/linux/hiddev.h                                                        |    2 
 include/linux/hugetlb.h                                                       |   25 
 include/linux/hugetlb_cgroup.h                                                |   20 
 include/linux/iio/iio.h                                                       |   72 
 include/linux/interrupt.h                                                     |    3 
 include/linux/jbd2.h                                                          |    4 
 include/linux/kernel.h                                                        |   30 
 include/linux/libata.h                                                        |    6 
 include/linux/mfd/da9150/core.h                                               |    1 
 include/linux/mmu_notifier.h                                                  |   10 
 include/linux/mtd/spinand.h                                                   |    2 
 include/linux/mutex.h                                                         |    3 
 include/linux/nvme.h                                                          |   10 
 include/linux/overflow.h                                                      |   47 
 include/linux/path.h                                                          |    9 
 include/linux/pci.h                                                           |    3 
 include/linux/perf_event.h                                                    |    7 
 include/linux/pgtable.h                                                       |    2 
 include/linux/pm_wakeirq.h                                                    |   10 
 include/linux/pm_wakeup.h                                                     |   17 
 include/linux/regulator/consumer.h                                            |    2 
 include/linux/remoteproc.h                                                    |    2 
 include/linux/rtc.h                                                           |    2 
 include/linux/rtnetlink.h                                                     |   12 
 include/linux/rwsem.h                                                         |    8 
 include/linux/sched.h                                                         |    2 
 include/linux/sched/signal.h                                                  |    5 
 include/linux/shmem_fs.h                                                      |   15 
 include/linux/skbuff.h                                                        |  105 
 include/linux/soc/ti/k3-ringacc.h                                             |   31 
 include/linux/soundwire/sdw_intel.h                                           |   44 
 include/linux/spi/rspi.h                                                      |   18 
 include/linux/spinlock.h                                                      |   15 
 include/linux/sprintf.h                                                       |   26 
 include/linux/string_helpers.h                                                |    2 
 include/linux/usb/quirks.h                                                    |    3 
 include/linux/virtio_vsock.h                                                  |    9 
 include/linux/wait.h                                                          |    6 
 include/linux/watch_queue.h                                                   |    6 
 include/math-emu/op-common.h                                                  |   23 
 include/math-emu/soft-fp.h                                                    |    8 
 include/media/v4l2-ctrls.h                                                    |    6 
 include/net/addrconf.h                                                        |    3 
 include/net/bluetooth/bluetooth.h                                             |    4 
 include/net/bluetooth/hci.h                                                   |   10 
 include/net/bluetooth/hci_core.h                                              |    1 
 include/net/bluetooth/hci_sync.h                                              |    1 
 include/net/cfg80211.h                                                        |   32 
 include/net/espintcp.h                                                        |    5 
 include/net/inet_frag.h                                                       |    9 
 include/net/ip.h                                                              |    2 
 include/net/ip_vs.h                                                           |   50 
 include/net/mctp.h                                                            |    6 
 include/net/mptcp.h                                                           |    9 
 include/net/netfilter/nf_conntrack_expect.h                                   |    3 
 include/net/netfilter/nf_conntrack_seqadj.h                                   |    1 
 include/net/netns/can.h                                                       |    2 
 include/net/sctp/sm.h                                                         |    1 
 include/net/tls.h                                                             |   10 
 include/sound/control.h                                                       |    4 
 include/sound/core.h                                                          |   27 
 include/sound/hwdep.h                                                         |    1 
 include/sound/pcm.h                                                           |    2 
 include/sound/pcm_oss.h                                                       |    1 
 include/sound/soc-card.h                                                      |    4 
 include/sound/soc-component.h                                                 |    2 
 include/sound/soc.h                                                           |   41 
 include/sound/soundfont.h                                                     |    8 
 include/target/target_core_base.h                                             |   20 
 include/trace/events/huge_memory.h                                            |    6 
 include/trace/events/power.h                                                  |    3 
 include/trace/events/thermal.h                                                |    4 
 include/trace/misc/nfs.h                                                      |   10 
 include/uapi/linux/firewire-cdev.h                                            |    4 
 include/video/maxinefb.h                                                      |    4 
 init/Kconfig                                                                  |    4 
 init/main.c                                                                   |   41 
 init/version.c                                                                |    9 
 io_uring/cancel.c                                                             |    3 
 io_uring/io-wq.c                                                              |   14 
 io_uring/io_uring.c                                                           |   26 
 io_uring/net.c                                                                |   12 
 io_uring/poll.c                                                               |   77 
 io_uring/rsrc.c                                                               |   25 
 io_uring/rw.c                                                                 |   30 
 io_uring/sqpoll.c                                                             |   42 
 io_uring/sqpoll.h                                                             |    3 
 io_uring/tctx.c                                                               |    6 
 io_uring/timeout.c                                                            |    3 
 ipc/mqueue.c                                                                  |    7 
 ipc/namespace.c                                                               |    9 
 kernel/bpf/bpf_iter.c                                                         |    7 
 kernel/bpf/bpf_lsm.c                                                          |    4 
 kernel/bpf/btf.c                                                              |   27 
 kernel/bpf/queue_stack_maps.c                                                 |    3 
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
 kernel/fork.c                                                                 |   33 
 kernel/futex/core.c                                                           |    8 
 kernel/futex/pi.c                                                             |  100 
 kernel/irq/internals.h                                                        |    2 
 kernel/irq/irqdomain.c                                                        |    4 
 kernel/irq/manage.c                                                           |   86 
 kernel/kcov.c                                                                 |    8 
 kernel/kcsan/core.c                                                           |    7 
 kernel/kexec_file.c                                                           |    4 
 kernel/module/main.c                                                          |   10 
 kernel/module/tracking.c                                                      |    2 
 kernel/nsproxy.c                                                              |    2 
 kernel/profile.c                                                              |    2 
 kernel/rcu/rcutorture.c                                                       |    2 
 kernel/reboot.c                                                               |    9 
 kernel/resource.c                                                             |   11 
 kernel/sched/cpufreq_schedutil.c                                              |   14 
 kernel/sched/fair.c                                                           |    7 
 kernel/seccomp.c                                                              |    7 
 kernel/signal.c                                                               |   17 
 kernel/sys.c                                                                  |    3 
 kernel/sysctl.c                                                               |   45 
 kernel/time/itimer.c                                                          |    2 
 kernel/time/namespace.c                                                       |    2 
 kernel/time/posix-cpu-timers.c                                                |    4 
 kernel/time/posix-stubs.c                                                     |    4 
 kernel/time/posix-timers.c                                                    |   18 
 kernel/time/timeconv.c                                                        |    6 
 kernel/time/timekeeping.c                                                     |    3 
 kernel/time/timer.c                                                           |    2 
 kernel/trace/trace.c                                                          |   48 
 kernel/trace/trace.h                                                          |    1 
 kernel/trace/trace_events_hist.c                                              |  148 
 kernel/ucount.c                                                               |   28 
 kernel/watch_queue.c                                                          |    2 
 lib/842/842_decompress.c                                                      |    7 
 lib/Makefile                                                                  |    1 
 lib/assoc_array.c                                                             |  355 
 lib/cmdline.c                                                                 |   13 
 lib/cmdline_kunit.c                                                           |  101 
 lib/decompress_bunzip2.c                                                      |    6 
 lib/decompress_unlz4.c                                                        |    4 
 lib/fault-inject.c                                                            |    7 
 lib/klist.c                                                                   |   16 
 lib/kobject_uevent.c                                                          |    8 
 lib/overflow_kunit.c                                                          |  381 
 lib/raid6/avx2.c                                                              |    6 
 lib/raid6/avx512.c                                                            |    6 
 lib/raid6/recov_avx2.c                                                        |    2 
 lib/raid6/recov_avx512.c                                                      |    2 
 lib/string_helpers.c                                                          |   17 
 lib/test_hmm.c                                                                |    2 
 lib/test_printf.c                                                             |    1 
 lib/vsprintf.c                                                                |    1 
 mm/damon/core.c                                                               |   39 
 mm/damon/sysfs.c                                                              |    2 
 mm/damon/vaddr.c                                                              |   17 
 mm/filemap.c                                                                  |  106 
 mm/gup.c                                                                      |   19 
 mm/gup_test.c                                                                 |   17 
 mm/huge_memory.c                                                              |    8 
 mm/hugetlb.c                                                                  |  230 
 mm/hugetlb_cgroup.c                                                           |   50 
 mm/internal.h                                                                 |    6 
 mm/khugepaged.c                                                               |   19 
 mm/kmemleak.c                                                                 |   12 
 mm/ksm.c                                                                      |   31 
 mm/madvise.c                                                                  |   18 
 mm/memcontrol.c                                                               |   81 
 mm/memfd.c                                                                    |    2 
 mm/memory-tiers.c                                                             |   29 
 mm/memory.c                                                                   |   35 
 mm/mempolicy.c                                                                |   37 
 mm/migrate.c                                                                  |    5 
 mm/mlock.c                                                                    |    2 
 mm/mmap.c                                                                     |   25 
 mm/mmu_notifier.c                                                             |   24 
 mm/mremap.c                                                                   |   46 
 mm/nommu.c                                                                    |    6 
 mm/page_alloc.c                                                               |   16 
 mm/page_isolation.c                                                           |    6 
 mm/page_table_check.c                                                         |    6 
 mm/page_vma_mapped.c                                                          |   40 
 mm/rmap.c                                                                     |   34 
 mm/shmem.c                                                                    |   74 
 mm/swapfile.c                                                                 |    8 
 mm/truncate.c                                                                 |   21 
 mm/util.c                                                                     |   13 
 mm/vmscan.c                                                                   |   41 
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
 net/bluetooth/hci_core.c                                                      |   47 
 net/bluetooth/hci_debugfs.c                                                   |    9 
 net/bluetooth/hci_event.c                                                     |   65 
 net/bluetooth/hci_sync.c                                                      |   98 
 net/bluetooth/iso.c                                                           |    4 
 net/bluetooth/l2cap_core.c                                                    |   93 
 net/bluetooth/l2cap_sock.c                                                    |    4 
 net/bluetooth/mgmt.c                                                          |  115 
 net/bluetooth/msft.c                                                          |  418 
 net/bluetooth/selftest.c                                                      |    1 
 net/bluetooth/smp.c                                                           |    3 
 net/bpf/test_run.c                                                            |   27 
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
 net/core/dev.c                                                                |   73 
 net/core/filter.c                                                             |   67 
 net/core/gro.c                                                                |    9 
 net/core/lwtunnel.c                                                           |    6 
 net/core/selftests.c                                                          |    2 
 net/core/skbuff.c                                                             |   26 
 net/core/sock.c                                                               |    6 
 net/dcb/dcbnl.c                                                               |    2 
 net/ipv4/gre_offload.c                                                        |    2 
 net/ipv4/inet_connection_sock.c                                               |   16 
 net/ipv4/inet_fragment.c                                                      |    4 
 net/ipv4/inet_hashtables.c                                                    |    5 
 net/ipv4/ip_fragment.c                                                        |    1 
 net/ipv4/ip_gre.c                                                             |   10 
 net/ipv4/ip_tunnel.c                                                          |   46 
 net/ipv4/ip_vti.c                                                             |   20 
 net/ipv4/ipip.c                                                               |    2 
 net/ipv4/ipmr.c                                                               |   49 
 net/ipv4/metrics.c                                                            |    5 
 net/ipv4/netfilter/nf_nat_h323.c                                              |   22 
 net/ipv4/netfilter/nf_reject_ipv4.c                                           |   11 
 net/ipv4/netfilter/nf_tproxy_ipv4.c                                           |    2 
 net/ipv4/syncookies.c                                                         |    2 
 net/ipv4/sysctl_net_ipv4.c                                                    |    2 
 net/ipv4/tcp_bic.c                                                            |   14 
 net/ipv4/tcp_cong.c                                                           |    4 
 net/ipv4/tcp_cubic.c                                                          |   14 
 net/ipv4/tcp_hybla.c                                                          |   16 
 net/ipv4/tcp_input.c                                                          |    4 
 net/ipv4/tcp_metrics.c                                                        |   20 
 net/ipv4/tcp_offload.c                                                        |   12 
 net/ipv4/tcp_output.c                                                         |    2 
 net/ipv6/addrconf.c                                                           |   46 
 net/ipv6/calipso.c                                                            |    6 
 net/ipv6/datagram.c                                                           |    4 
 net/ipv6/inet6_hashtables.c                                                   |    4 
 net/ipv6/ip6mr.c                                                              |    5 
 net/ipv6/netfilter/nf_conntrack_reasm.c                                       |    2 
 net/ipv6/netfilter/nf_reject_ipv6.c                                           |   13 
 net/ipv6/netfilter/nf_tproxy_ipv6.c                                           |    2 
 net/ipv6/raw.c                                                                |    3 
 net/ipv6/reassembly.c                                                         |    1 
 net/ipv6/route.c                                                              |   22 
 net/ipv6/sit.c                                                                |    4 
 net/ipv6/udp.c                                                                |   13 
 net/l2tp/l2tp_core.c                                                          |   51 
 net/l2tp/l2tp_core.h                                                          |    6 
 net/l2tp/l2tp_debugfs.c                                                       |    4 
 net/l2tp/l2tp_netlink.c                                                       |   11 
 net/l2tp/l2tp_ppp.c                                                           |    8 
 net/mac80211/cfg.c                                                            |   15 
 net/mac80211/debugfs.c                                                        |    2 
 net/mac80211/ibss.c                                                           |    4 
 net/mac80211/ieee80211_i.h                                                    |    3 
 net/mac80211/main.c                                                           |    2 
 net/mac80211/mesh_pathtbl.c                                                   |   17 
 net/mac80211/rx.c                                                             |    1 
 net/mac80211/tdls.c                                                           |    3 
 net/mac80211/tx.c                                                             |  121 
 net/mctp/af_mctp.c                                                            |    4 
 net/mctp/route.c                                                              |   94 
 net/mctp/test/route-test.c                                                    |    7 
 net/mptcp/options.c                                                           |    9 
 net/mptcp/pm_netlink.c                                                        |    1 
 net/mptcp/protocol.c                                                          |   37 
 net/mptcp/protocol.h                                                          |   10 
 net/mptcp/subflow.c                                                           |   44 
 net/mptcp/token.c                                                             |   65 
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
 net/netfilter/ipvs/ip_vs_sync.c                                               |   23 
 net/netfilter/ipvs/ip_vs_twos.c                                               |    4 
 net/netfilter/ipvs/ip_vs_wlc.c                                                |    4 
 net/netfilter/ipvs/ip_vs_wrr.c                                                |    2 
 net/netfilter/nf_conntrack_core.c                                             |    5 
 net/netfilter/nf_conntrack_expect.c                                           |   35 
 net/netfilter/nf_conntrack_netlink.c                                          |    8 
 net/netfilter/nf_conntrack_proto_tcp.c                                        |    6 
 net/netfilter/nf_conntrack_seqadj.c                                           |   17 
 net/netfilter/nf_flow_table_ip.c                                              |    4 
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
 net/rds/message.c                                                             |   26 
 net/rds/rdma.c                                                                |   63 
 net/rds/rdma_transport.c                                                      |    3 
 net/rds/rds.h                                                                 |   18 
 net/rds/recv.c                                                                |   17 
 net/rds/send.c                                                                |   27 
 net/rds/tcp.c                                                                 |    7 
 net/rds/tcp_recv.c                                                            |    4 
 net/rxrpc/sendmsg.c                                                           |   57 
 net/sched/act_api.c                                                           |   24 
 net/sched/act_ife.c                                                           |    4 
 net/sched/cls_flower.c                                                        |   49 
 net/sched/sch_etf.c                                                           |    1 
 net/sched/sch_generic.c                                                       |   51 
 net/sched/sch_gred.c                                                          |   16 
 net/sched/sch_qfq.c                                                           |    3 
 net/sched/sch_taprio.c                                                        |   11 
 net/sched/sch_teql.c                                                          |   60 
 net/sctp/associola.c                                                          |    4 
 net/sctp/endpointola.c                                                        |    4 
 net/sctp/ipv6.c                                                               |    6 
 net/sctp/sm_make_chunk.c                                                      |   38 
 net/sctp/sm_statefuns.c                                                       |    2 
 net/sctp/socket.c                                                             |   83 
 net/smc/smc_pnet.c                                                            |   29 
 net/smc/smc_rx.c                                                              |   39 
 net/smc/smc_tx.c                                                              |    7 
 net/sunrpc/auth_gss/svcauth_gss.c                                             |   29 
 net/sunrpc/svc.c                                                              |    9 
 net/sunrpc/svc_xprt.c                                                         |   16 
 net/sunrpc/svcauth_unix.c                                                     |    7 
 net/sunrpc/svcsock.c                                                          |    3 
 net/sunrpc/xprtrdma/rpc_rdma.c                                                |   27 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                                      |   10 
 net/sunrpc/xprtrdma/verbs.c                                                   |    9 
 net/tipc/bearer.c                                                             |    4 
 net/tipc/group.c                                                              |   19 
 net/tipc/node.c                                                               |    2 
 net/tipc/socket.c                                                             |   12 
 net/tls/tls.h                                                                 |   53 
 net/tls/tls_device.c                                                          |   55 
 net/tls/tls_device_fallback.c                                                 |   42 
 net/tls/tls_main.c                                                            |   93 
 net/unix/sysctl_net_unix.c                                                    |    4 
 net/vmw_vsock/virtio_transport.c                                              |    4 
 net/vmw_vsock/vmci_transport.c                                                |   34 
 net/wireless/nl80211.c                                                        |   10 
 net/wireless/reg.c                                                            |   44 
 net/wireless/sme.c                                                            |   38 
 net/wireless/wext-sme.c                                                       |    6 
 net/xfrm/espintcp.c                                                           |   43 
 net/xfrm/xfrm_input.c                                                         |   10 
 net/xfrm/xfrm_interface_core.c                                                |    8 
 net/xfrm/xfrm_policy.c                                                        |   11 
 scripts/Makefile.vmlinux_o                                                    |    2 
 scripts/checkkconfigsymbols.py                                                |    2 
 scripts/checkpatch.pl                                                         |    2 
 scripts/clang-tools/run-clang-tools.py                                        |    1 
 scripts/kconfig/conf.c                                                        |   33 
 scripts/kconfig/symbol.c                                                      |   71 
 scripts/kconfig/tests/conftest.py                                             |    9 
 scripts/kconfig/tests/randconfig_probability/Kconfig                          |   12 
 scripts/kconfig/tests/randconfig_probability/__init__.py                      |  130 
 scripts/kconfig/tests/savedefconfig_range/Kconfig                             |   60 
 scripts/kconfig/tests/savedefconfig_range/__init__.py                         |    8 
 scripts/kconfig/tests/savedefconfig_range/config                              |    7 
 scripts/link-vmlinux.sh                                                       |   19 
 security/apparmor/apparmorfs.c                                                |   15 
 security/apparmor/include/label.h                                             |    6 
 security/apparmor/include/policy_ns.h                                         |   16 
 security/apparmor/label.c                                                     |   15 
 security/apparmor/policy.c                                                    |   16 
 security/apparmor/policy_ns.c                                                 |    8 
 security/integrity/ima/ima_template.c                                         |    5 
 security/keys/encrypted-keys/encrypted.c                                      |   20 
 security/landlock/fs.c                                                        |   10 
 security/selinux/netlabel.c                                                   |    1 
 sound/core/compress_offload.c                                                 |   12 
 sound/core/control.c                                                          |   31 
 sound/core/hwdep.c                                                            |    2 
 sound/core/info.c                                                             |   96 
 sound/core/info_oss.c                                                         |   10 
 sound/core/init.c                                                             |  265 
 sound/core/jack.c                                                             |    7 
 sound/core/misc.c                                                             |   27 
 sound/core/oss/mixer_oss.c                                                    |   36 
 sound/core/oss/pcm_oss.c                                                      |   12 
 sound/core/pcm.c                                                              |   15 
 sound/core/pcm_compat.c                                                       |    4 
 sound/core/pcm_lib.c                                                          |   16 
 sound/core/pcm_local.h                                                        |    6 
 sound/core/pcm_native.c                                                       |  107 
 sound/core/rawmidi.c                                                          |    2 
 sound/core/seq/oss/seq_oss_device.h                                           |    1 
 sound/core/seq/oss/seq_oss_event.c                                            |    3 
 sound/core/seq/oss/seq_oss_init.c                                             |    2 
 sound/core/sound.c                                                            |   28 
 sound/core/sound_oss.c                                                        |   17 
 sound/core/vmaster.c                                                          |    7 
 sound/drivers/aloop.c                                                         |   80 
 sound/drivers/mpu401/mpu401_uart.c                                            |    8 
 sound/hda/ext/hdac_ext_stream.c                                               |    4 
 sound/hda/hdac_bus.c                                                          |    9 
 sound/isa/sb/emu8000.c                                                        |    2 
 sound/isa/sb/emu8000_patch.c                                                  |   13 
 sound/isa/sb/sb16_csp.c                                                       |    2 
 sound/mips/sgio2audio.c                                                       |   13 
 sound/oss/dmasound/dmasound_q40.c                                             |   65 
 sound/pci/cs46xx/dsp_spos.c                                                   |    4 
 sound/pci/cs46xx/dsp_spos_scb_lib.c                                           |    3 
 sound/pci/emu10k1/emu10k1_patch.c                                             |   85 
 sound/pci/emu10k1/emufx.c                                                     |    2 
 sound/pci/hda/hda_codec.c                                                     |   16 
 sound/pci/hda/hda_eld.c                                                       |    6 
 sound/pci/hda/hda_intel.c                                                     |   19 
 sound/pci/hda/hda_jack.c                                                      |    9 
 sound/pci/hda/hda_sysfs.c                                                     |    4 
 sound/pci/hda/patch_conexant.c                                                |   17 
 sound/pci/hda/patch_hdmi.c                                                    |    3 
 sound/pci/hda/patch_realtek.c                                                 |   62 
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
 sound/soc/amd/acp-es8336.c                                                    |    5 
 sound/soc/amd/acp/acp-platform.c                                              |    2 
 sound/soc/amd/ps/ps-pdm-dma.c                                                 |    2 
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
 sound/soc/codecs/es8326.c                                                     |    2 
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
 sound/soc/codecs/sta32x.c                                                     |   20 
 sound/soc/codecs/sta350.c                                                     |   20 
 sound/soc/codecs/tlv320adc3xxx.c                                              |    2 
 sound/soc/codecs/tlv320aic26.c                                                |    6 
 sound/soc/codecs/tlv320aic32x4-clk.c                                          |  103 
 sound/soc/codecs/tlv320aic32x4-i2c.c                                          |   38 
 sound/soc/codecs/tlv320aic32x4-spi.c                                          |   41 
 sound/soc/codecs/tlv320aic32x4.c                                              |  288 
 sound/soc/codecs/tlv320aic32x4.h                                              |   14 
 sound/soc/codecs/wcd-mbhc-v2.c                                                |    8 
 sound/soc/codecs/wcd9335.c                                                    |   12 
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
 sound/soc/fsl/fsl_asrc.c                                                      |    8 
 sound/soc/fsl/fsl_asrc_dma.c                                                  |    5 
 sound/soc/fsl/imx-pcm-rpmsg.c                                                 |    2 
 sound/soc/intel/atom/sst-atom-controls.c                                      |   38 
 sound/soc/intel/atom/sst-mfld-platform-pcm.c                                  |   36 
 sound/soc/intel/atom/sst/sst_acpi.c                                           |   14 
 sound/soc/intel/avs/utils.c                                                   |    6 
 sound/soc/intel/boards/bytcr_rt5651.c                                         |   17 
 sound/soc/intel/boards/sof_sdw_rt711.c                                        |    1 
 sound/soc/mediatek/common/mtk-afe-fe-dai.c                                    |    8 
 sound/soc/mediatek/mt6797/mt6797-afe-clk.c                                    |   14 
 sound/soc/mediatek/mt8183/mt8183-afe-clk.c                                    |   22 
 sound/soc/mediatek/mt8186/mt8186-afe-clk.c                                    |   95 
 sound/soc/mediatek/mt8192/mt8192-afe-clk.c                                    |  143 
 sound/soc/mediatek/mt8192/mt8192-afe-gpio.c                                   |   90 
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c                                    |   10 
 sound/soc/mediatek/mt8192/mt8192-dai-adda.c                                   |   44 
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c                                    |   20 
 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c                       |   39 
 sound/soc/mediatek/mt8195/mt8195-afe-clk.c                                    |   77 
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c                                    |   98 
 sound/soc/mediatek/mt8195/mt8195-dai-adda.c                                   |   17 
 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c                                   |  274 
 sound/soc/mediatek/mt8195/mt8195-dai-pcm.c                                    |   26 
 sound/soc/qcom/qdsp6/q6afe.c                                                  |   10 
 sound/soc/qcom/qdsp6/q6apm.c                                                  |   21 
 sound/soc/qcom/qdsp6/q6apm.h                                                  |    2 
 sound/soc/qcom/qdsp6/q6prm.c                                                  |    7 
 sound/soc/qcom/sdm845.c                                                       |   26 
 sound/soc/rockchip/rockchip_i2s.c                                             |    4 
 sound/soc/samsung/midas_wm1811.c                                              |   16 
 sound/soc/soc-ac97.c                                                          |    4 
 sound/soc/soc-component.c                                                     |    2 
 sound/soc/soc-link.c                                                          |   10 
 sound/soc/soc-ops.c                                                           |   10 
 sound/soc/soc-topology.c                                                      |    3 
 sound/soc/soc-utils.c                                                         |    7 
 sound/soc/sof/intel/hda-codec.c                                               |   74 
 sound/soc/sof/intel/hda.c                                                     |   12 
 sound/soc/sof/intel/hda.h                                                     |   20 
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
 sound/usb/endpoint.c                                                          |   40 
 sound/usb/line6/capture.c                                                     |   49 
 sound/usb/line6/capture.h                                                     |    2 
 sound/usb/line6/pcm.c                                                         |   16 
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
 sound/usb/usx2y/us122l.c                                                      |   29 
 sound/usb/usx2y/usX2Yhwdep.c                                                  |    5 
 sound/usb/usx2y/usb_stream.c                                                  |    9 
 sound/usb/usx2y/usbusx2y.c                                                    |    7 
 sound/usb/usx2y/usbusx2yaudio.c                                               |   44 
 sound/x86/intel_hdmi_audio.c                                                  |    9 
 tools/bootconfig/main.c                                                       |   13 
 tools/bpf/bpftool/main.c                                                      |   16 
 tools/bpf/bpftool/tracelog.c                                                  |    2 
 tools/cgroup/memcg_shrinker.py                                                |    2 
 tools/include/linux/types.h                                                   |    5 
 tools/include/nolibc/stdlib.h                                                 |    8 
 tools/lib/api/fd/array.c                                                      |    5 
 tools/lib/bpf/btf.c                                                           |    4 
 tools/lib/bpf/ringbuf.c                                                       |    2 
 tools/lib/perf/mmap.c                                                         |    2 
 tools/lib/thermal/include/thermal.h                                           |    4 
 tools/perf/Documentation/perf-c2c.txt                                         |    2 
 tools/perf/builtin-c2c.c                                                      |   16 
 tools/perf/util/Build                                                         |    2 
 tools/perf/util/header.c                                                      |   18 
 tools/perf/util/jitdump.c                                                     |  119 
 tools/perf/util/mem-events.c                                                  |    2 
 tools/perf/util/mmap.c                                                        |    3 
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c               |   18 
 tools/testing/selftests/Makefile                                              |    4 
 tools/testing/selftests/alsa/mixer-test.c                                     |    2 
 tools/testing/selftests/arm64/signal/Makefile                                 |    4 
 tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c            |    4 
 tools/testing/selftests/bpf/prog_tests/empty_skb.c                            |   59 
 tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c                 |   10 
 tools/testing/selftests/bpf/prog_tests/test_tunnel.c                          |   13 
 tools/testing/selftests/bpf/progs/empty_skb.c                                 |    7 
 tools/testing/selftests/clone3/clone3_clear_sighand.c                         |    6 
 tools/testing/selftests/core/Makefile                                         |    2 
 tools/testing/selftests/core/unshare_test.c                                   |  109 
 tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c                 |   32 
 tools/testing/selftests/ftrace/ftracetest                                     |    3 
 tools/testing/selftests/net/Makefile                                          |    2 
 tools/testing/selftests/net/fib_nexthops.sh                                   |   46 
 tools/testing/selftests/net/fin_ack_lat.c                                     |    2 
 tools/testing/selftests/net/reuseport_bpf_numa.c                              |   24 
 tools/testing/selftests/net/tcp_mmap.c                                        |  110 
 tools/testing/selftests/net/txtimestamp.c                                     |   23 
 tools/testing/selftests/netfilter/conntrack_vrf.sh                            |  140 
 tools/testing/selftests/seccomp/seccomp_bpf.c                                 |  179 
 tools/testing/selftests/timers/clocksource-switch.c                           |   23 
 tools/thermal/tmon/tmon.c                                                     |    2 
 usr/gen_init_cpio.c                                                           |    1 
 virt/kvm/kvm_main.c                                                           |   31 
 2178 files changed, 108913 insertions(+), 17562 deletions(-)

Aamir Ahmed (1):
      lib: decompress_bunzip2: fix integer overflow in run-length decoding

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

Abdifatah Suruur (4):
      ksmbd: reserve space for the UTF-16 terminator in stream info
      smb: client: fix fiemap wild read on empty truncated response
      smb: client: validate the data area in SMB2_read()
      xen/gntdev: prevent private mappings from becoming writable

Abdun Nihaal (1):
      wifi: ath11k: Fix possible memory leak in ath11k_dp_srng_setup()

Abdurrahman Karadag (1):
      wifi: rtw88: debugfs: don't vzalloc(0) when rsvd_page is read unconfigured

Abel Vesa (3):
      arm64: dts: qcom: sm8150: Use SM8150_CX for the SDHC power domain
      clk: qcom: mmcc-msm8996: Fix FD AHB clock register offset
      clk: qcom: mmcc-sdm660: Fix MDSS AHB clock HWCG register offset

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

Ahelenia Ziemiańska (3):
      splice: always fsnotify_access(in), fsnotify_modify(out) on success
      splice: fsnotify_access(in), fsnotify_modify(out) on success in tee
      splice: fsnotify_access(fd)/fsnotify_modify(fd) in vmsplice

Ahmad Fatoum (1):
      ARM: dts: stm32: lxa-mc1: change stdout-path baud rate from 9600 to 115200

Ahmed Naseef (2):
      wifi: mt76: mt7603: add 0x7592 EEPROM chip ID
      wifi: mt76: mt7615: read MT7663 temperature from the correct offset

Ahmed Yaseen (1):
      platform/x86: asus-wmi: validate custom fan curves on enable

Ahsan Atta (2):
      crypto: qat - initialise state_lock on every path in adf_devmgr_add_dev()
      crypto: qat - avoid OOB read when stripping RSA leading zeros

Ajay Kumar Nandam (1):
      ASoC: qcom: q6apm: clear g_apm on driver removal

Akash Sukhavasi (1):
      phy: HiSilicon: Fix error handling in hi3670_pcie_allclk_ctrl()

Akhil P Oommen (1):
      drm/msm/a6xx: Fix secondary rail vote in ARC votes

Akshay Jindal (1):
      iommu/amd: Skip non-IVMD entries when parsing IVRS memory definitions

Al Viro (3):
      configfs:get_target() - release path as soon as we grab configfs_item reference
      ufs: fix ufs_read_cylinder() failure handling
      selftests:core: test coverage for dup_fd() failure handling in unshare_fd()

Alan Stern (1):
      HID: core: Fix out-of-bounds left shift by 32 in s32ton()

Aldo Ariel Panzardo (11):
      HID: multitouch: stop the release timer from being rearmed on remove
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

Aleksandr Nogikh (3):
      media: usbtv: fix null-pointer dereference on disconnect
      usb: gadget: dummy_hcd: prevent unbind via sysfs
      Bluetooth: hci_core: Fix race condition during device registration

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
      wifi: rsi: Skip TX aggregation setup for non-QoS frames
      ALSA: cs46xx: Handle SCB creation failures before dereferencing
      ASoC: tlv320aic32x4: Prevent division by zero in divider callbacks

Alexander A. Klimov (1):
      microblaze: CCF: fix refcount leak

Alexander Sverdlin (2):
      pwm: tiehrpwm: Clear period on disable to allow reconfiguration
      tpm: tpm2_probe: propagate transport errors

Alexandre Belloni (1):
      rtc: s35390a: fix typo in comment

Alexandre Cassen (1):
      net/sched: act_api: inherit filter offload flags only on new actions

Alexei Starovoitov (2):
      bpf: Clear sk_refcnt of a clone before its storage is linked
      bpf: Don't take a program with a target program for an iterator

Alexey Charkov (2):
      regulator: of: fill in supply names in of_regulator_bulk_get_all()
      nvmem: rockchip-otp: Serialize reads

Alexey Klimov (1):
      ASoC: qcom: sdm845: add handling of secondary MI2S clock

Ali Alaei (1):
      PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow Lake-HX

Ali Resool Tuama (1):
      USB: quirks: add USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE for GameSir G7 SE

Allison Henderson (5):
      net/rds: don't use unpin_user_pages_dirty_lock() from atomic context
      net/rds: unpin MR pages with unpin_user_pages_dirty_lock()
      net/rds: include the scope id in the sendmsg connection cache check
      net/rds: keep the connected peer's scope id apart from the bound one
      net/rds: do not initialize transports after rds_init() failed

Alok Tiwari (1):
      octeontx2-af: Fix CQ enable state tracking after AQ writes

Aloka Dixit (1):
      Revert "wifi: mac80211: do not use old MBSSID elements"

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

Andrew Donnellan (1):
      powerpc/pseries: Make caller pass buffer to plpks_read_var()

Andrew Gaylard (1):
      pinctrl: fix PINCTRL_SPPCTL=m

Andrew Kanner (1):
      selinux: prevent KMSAN warning in selinux_inet_conn_request()

Andrew Morton (1):
      openrisc: export __mulsi3 for modules

Andrew Stellman (1):
      nvmet-rdma: fix out-of-bounds write in nvmet_rdma_map_sgl_inline()

Andrey Albershteyn (1):
      fsverity: hoist statx reporting of fs-verity flag

Andrey Misiurov (2):
      Bluetooth: ISO: drop unbalanced sock_put() in iso_conn_ready()
      fbdev: core: Initialize modelist in framebuffer_alloc()

André Draszik (4):
      kbuild: link-vmlinux.sh: improve detection of third pass requirement
      drm/drm_crtc: ensure dma_fence_ops remain valid during device unbind
      rtc: ftrtc010: drop needless struct ftrtc010_rtc::rtc_dev member
      rtc: s35390a: drop needless struct s35390a::rtc member

Andy Shevchenko (7):
      lib/string_helpers: Add kstrdup_and_replace() helper
      platform/x86: think-lmi: Replace kstrdup() + strreplace() with kstrdup_and_replace()
      platform/x86: think-lmi: Use strreplace() to replace a character by nul
      lib/vsprintf: split out sprintf() and friends
      serial: 8250_exar: Clear interrupts before registering handler
      gpio: pca953x: Utilise temporary variable for struct gpio_chip
      spi: rspi: Get rid of unused struct rspi_plat_data

Aneesh Kumar K.V (1):
      mm/huge pud: use transparent huge pud helpers only with CONFIG_TRANSPARENT_HUGEPAGE

Anil Kaushik (2):
      gtp: set a valid genl command in PDP context get and dump replies
      gtp: hold RCU for the device lookup when adding a PDP context

Anirudh Venkataramanan (2):
      crypto: tcrypt - Use pr_info/pr_err
      crypto: tcrypt - Drop leading newlines from prints

Antoni Pokusinski (1):
      rtc: abx80x: fix error check after i2c_smbus_read in read_alarm()

Antonio Quartulli (1):
      net/sched: fix packet reordering on requeue

Anuj Bolewar (2):
      drm/virtio: reclaim pending vbufs before tearing down vqs
      media: hackrf: fix use-after-free in hackrf_alloc_urbs() error path

Anup Vishwakarma (3):
      mailbox: qcom-ipcc: Guard against NULL con_priv in send_data()
      remoteproc: qcom_q6v5_adsp: Fix double jiffies conversion in adsp_start()
      mailbox: qcom-ipcc: remove stray disable_irq_wake() call

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

Arnaldo Carvalho de Melo (10):
      perf jitdump: Fix extended header read that always fails
      perf jitdump: Fix debug_data and unwinding_data leaks
      perf jitdump: Validate code_size against total_size in code load
      perf jitdump: Prevent integer underflow in debug info size calculation
      perf jitdump: Bounds-check debug entry byte-swap loop
      perf jitdump: Check snprintf return before computing header size
      perf jitdump: Fix funlockfile on unlocked stream in jit_open() error path
      perf jitdump: Validate debug entries on native (non-swap) path
      perf jitdump: Validate sym string NUL-termination in code load
      perf jitdump: Validate unwinding sizes against record payload

Arnd Bergmann (3):
      media: v4l2-tpg: reduce stack usage for kasan builds
      mtd: rawnand: ndfc: add CONFIG_OF dependency
      KMSAN: fix memset() when using fortify-source, again

Asad Kamal (2):
      drm/amd/pm: Validate OD DPM triples before mutating tables
      drm/amdgpu: Gate debugfs MMIO access on kernel lockdown

Atharva Vartak (1):
      net/smc: hold a reference on net_device returned by pnet_find_base_ndev()

Atul Akella (1):
      rpmsg: virtio: fix error handling in TX buffer wait

Aurabindo Pillai (1):
      drm/amd: Add DCN6 register headers

Avi Weiss (5):
      init/bootconfig: pass init arguments in documented order
      rpmsg: mtk: release channel OF node on device teardown
      signal: skip blocked signals in dequeue_synchronous_signal()
      profiling: fix sampling step on 64-bit big-endian systems
      nvmet: prevent double-free after metadata SGL allocation failure

Azeem Shaikh (1):
      init/version.c: Replace strlcpy with strscpy

Babanpreet Singh (1):
      regulator: ab8500: Remove stale expand_register kernel-doc entry

Baek Kyu, Kim (3):
      hwmon: (sht3x) Return the consumed count for heater writes
      hwmon: (corsair-cpro) Cache fan target only after a successful command
      rtc: mpfs: Fix alarm register word order

Bagas Sanjaya (1):
      tracing/histogram: Wrap remaining shell snippets in code blocks

Balakrishnan Sambath (7):
      media: microchip-isc: take a reference on the parsed endpoints
      media: microchip-isc: do not touch WB registers when not streaming
      media: microchip-isc: fix PM runtime leak in AWB work handler
      media: microchip-isc: fix awb_mutex and lock lifecycle
      media: microchip-isc: fix WB offset and gain register field masking
      media: microchip-isc: synchronize the IRQ before disabling clocks on stop
      media: microchip-isc: don't sleep in the clk .is_enabled callback

Baokun Li (2):
      ext4: reduce max cluster size to match documented 256MB limit
      blk-crypto: fix NULL deref and UAF in __blk_crypto_evict_key()

Baolin Liu (1):
      isofs: fix Rock Ridge CE extent validation on multisession media

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

Benjamin Coddington (6):
      pNFS: Fix CB_NOTIFY_DEVICEID CHANGE to consume ndc_immediate
      NFSv4.1/pnfs: suspend pNFS on NFS4ERR_TOOSMALL from LAYOUTGET
      NFSv4/filelayout: Anchor page coalescing on pattern_offset
      NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before allocating
      NFSv4/flexfiles: fail I/O to the data server once a lock is lost
      NFSv4/pnfs: Free the netid when draining a data-server address list

Benjamin Marzinski (1):
      bitops: make the *_bit_le functions use unsigned long

Biju Das (3):
      ASoC: codec: tlv320aic32x4: Add enum aic32x4_type to aic32x4_probe()
      ASoC: tlv320aic32x4-i2c: Simplify probe()
      ASoC: tlv320aic32x4-spi: Simplify probe()

Binbin Deng (4):
      apparmor: fix a use-after-free in aa_lookupn_ns()
      module: Fix uninitialized count read of unloaded taint tracking record
      tipc: fix use-after-free of broadcast reception link at node release
      net: atlantic: Unregister before clearing RXNFC rules

BingKun Yue (1):
      fbdev: platinumfb: add error checking for ioremap calls

Bitterblue Smith (1):
      wifi: rtl8xxxu: Use dev_* instead of pr_info

Bob Song (4):
      ALSA: hda: Check snd_hda_power_pm construct error before executing verb
      ALSA: hda/realtek: add missing NULL check for codec->bus->pci
      ALSA: hda/realtek: add missing error checks for COEF index reads in alc269
      ALSA: hda/conexant: Always enable the headset-mic pin on plugin

Boris Faure (1):
      soundwire: intel: initialise quirk_mask before reading it

Brad Fitzpatrick (1):
      gre: keep the UDP tunnel GSO type when completing GRO

Bradley Morgan (1):
      PM: CPU: Restore synchronize_rcu() to cpu_pm_unregister_notifier()

Breno Leitao (10):
      mm/kmemleak: report RCU-tasks quiescent states during the scan
      mm, swap: ratelimit bad swap entry reports
      x86/nmi: Ignore negative NMI handler durations
      mm/shmem: report RCU-tasks quiescent states while undoing a range
      ACPI: APEI: accumulate the queued flag across error sections
      dcache: report a Tasks-RCU quiescent state in dentry_kill()
      kexec_file: stop the top-down search before it underflows
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

Bui Viet Dung (4):
      wwan: wwan_hwsim: Pin module for debugfs file operations
      Bluetooth: 6lowpan: Pin module for 6lowpan_control debugfs file
      Bluetooth: hci_debugfs: Pin module for debugfs file operations
      Bluetooth: selftest: Pin module for selftest debugfs file operations

Can Peng (3):
      wifi: brcmfmac: Set DMA direction for msgbuf packet IDs
      wifi: brcmfmac: validate msgbuf flowring IDs before use
      spi: bcm63xx-hsspi: disable clocks on resume failure

Cao Guanghui (2):
      md/raid5: track disks array size to fix extra_page leak on error paths
      md/raid5: fix NULL pointer dereference in raid5_free_percpu

Carl Quist (1):
      ALSA: hda/realtek: Enable mute LED on HP Laptop 15-dy0xxx

Carolina Jubran (2):
      IB/IPoIB: Cancel normal flush work on device stop
      net: skbuff: don't copy alloc_cpu in skb header copies

Catalin Marinas (1):
      arm64: Use load LSE atomics for the non-return per-CPU atomic operations

Cen Zhang (38):
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
      ALSA: pcm: Protect the unregister notifier traversal
      ALSA: oss: Keep emulation modules loaded until object teardown
      ALSA: pcm: Remove channel-map controls before freeing substreams
      ALSA: pcm: Protect channel-map reads against runtime detach
      ALSA: aloop: Keep the timer source alive until card release
      ocfs2: initialize status waiters before publishing them

Cen Zhang (Microsoft Security FORGE Labs) (1):
      nfsd: hold cl_lock in client_has_openowners()

Cen Zhang (Microsoft) (4):
      reboot: fix cad_pid use-after-free race
      ksmbd: fix parent dentry lifetime in directory enumeration
      posix-cpu-timers: Fix pid refcount leak in do_cpu_nanosleep() signal path
      apparmor: fix query_data() output overlapping the lookup key

Cezary Rojewski (1):
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

Chao Yu (4):
      f2fs: compress: fix to handle race between truncate and writeback
      f2fs: fix to use bio_in_atomic() in f2fs_read_end_io()
      f2fs: fix to update superblock crc in sanity_check_area_boundary()
      f2fs: fix to fetch ino via ino_of_node() under cache lock

Charles Keepax (3):
      soundwire: dmi-quirks: Disable ghost Realtek on Asus Expertbook
      soundwire: dmi-quirks: Disable ghost Realtek on Asus Zenbook Duo
      soundwire: dmi-quirks: Disable ghost Realtek on Asus ROG Zephyrus Duo

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

ChenXiaoSong (2):
      smb/server: cancel async requests when closing connection
      smb/server: fix trailing period in generated short names

Cheng Yongkang (2):
      io_uring/timeout: count cancelled timeouts in cq_timeouts
      net: tun: hold napi_mutex when deleting NAPI in tun_detach_all()

Chengfeng Ye (6):
      Bluetooth: Serialize SMP remote OOB data access
      Bluetooth: hci_core: Serialize SCO and ISO scheduling with teardown
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
      nfsd: convert nfsd_net boolean flags to unsigned long flags word
      ovl: do not copy up an xattr value that was never read
      ovl: fix a torn path in ovl_get_redirect()
      ovl: read the nlink xattr of every indexed non-dir
      sunrpc: pin gss module across auth_domain RCU free
      ovl: set OVL_WHITEOUTS before publishing the upper dir
      ovl: set the revalidate flags after d_instantiate()
      io_uring/rsrc: charge buffer arrays and nodes to memcg
      io_uring: charge tctx nodes and personalities
      io_uring: free XArray nodes left by a failed store
      io_uring/sqpoll: don't wait for the thread to exit
      ovl: take a snapshot of the name for copy up
      ovl: use the pinned upper dir in ovl_fix_origin()
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
      ovl: look up the index by the decoded origin
      mm/huge_memory: fix truncate racing with PMD zapping
      mm/memory: reject remote COW faults on PFN mappings
      nvmet-rdma: flush nvmet-wq on module exit
      nvmet-rdma: disable interrupts under rsp_wr_wait_lock
      nvmet-rdma: fix double puts after a failed RDMA WRITE
      nvmet: don't clear sq->ctrl for a Connect with sqsize 0
      rnbd-srv: fix use-after-free on two CLOSE messages
      rnbd-srv: publish the sess_dev at the end of OPEN

Chris Morgan (1):
      dt-bindings: vendor-prefixes: add NewVision vendor prefix

Chris Simpson (1):
      ALSA: hda/realtek: Enable bass speakers on Alienware m17 R3

Christian Borntraeger (1):
      s390/vmcp: Initialize full session info to zero

Christian Brauner (10):
      exec: cancel io_uring requests before de_thread()
      fork: move the coredump and exec checks into create_io_thread()
      fork: don't create io threads once PF_POSTCOREDUMP is set
      path: add cleanup helper
      fs/ntfs3: use d_instantiate_new() in ntfs_create_inode() and murder syzbot's "WARNING in do_new_mount" saga
      namespace: check a recursive bind mount for mount namespace loops
      namespace: never expire a locked mount
      ipc: drop the mqueue mount with kern_unmount() on setup failure
      iomap: don't mark unwritten parts of a folio uptodate
      proc: don't let an entry below /proc/<pid>/net be a mountpoint

Christian Gmeiner (1):
      drm/etnaviv: Flush the tile status cache through both the PE and BLT

Christian Loehle (4):
      ACPI: CPPC: Validate FFH register fields before hardware access
      ACPI: CPPC: Propagate errors from cross-CPU FFH calls
      cpuidle: menu: Remove single state handling
      ACPI: CPPC: Validate the _CPC package header

Christian Marangi (1):
      i2c: mt7621: fix copying uninitialized kernel stack with reduced page_len

Christoph Hellwig (2):
      xfs: fix recovery of partial attr removals
      block: set the disk capacity to 0 in blk_mark_disk_dead

Christophe JAILLET (3):
      ocfs2: constify struct ocfs2_lock_res_ops
      hwrng: virtio - Remove usage of the deprecated ida_simple_xx() API
      wifi: wfx: Remove some dead code

Chuanhong Guo (1):
      pinctrl: mediatek: mt7629: fix the 2.4 GHz Wi-Fi pin mode array

Chuck Lever (17):
      svcrdma: Clear sc_cm_id when ADDR_CHANGE replacement fails
      NFSD: Prevent client use-after-free during blocked-lock reaping
      lockd: Fix use-after-free in nlmsvc_retry_blocked
      pnfs/blocklayout: Complete a device upcall only on its own reply
      pnfs/blocklayout: Complete a device upcall when the pipe is closed
      NFSD: Do not send CB_RECALL_ANY to NFSv4.0 clients
      NFSD: Don't complete a cld upcall the daemon has not read
      NFSD: Fail a pool_threads read whose reply does not fit
      NFSD: Reject an oversized principal hash from nfsdcld
      NFSD: Resolve the recall-any mask names in the trace format
      SUNRPC: Reject a socket that already has an svc_sock attached
      svcrdma: Grant credits from the clamped sc_max_requests
      NFSD: Move the cld upcall message out of the caller's stack frame
      NFSD: Complete a cld upcall when the daemon closes the pipe
      NFSD: Complete a cld upcall when copying its reply fails
      NFSD: Map flex file layout IDs through the request's user namespace
      SUNRPC: Copy the deferred RPC Call from the head buffer

ChunYuZhiQiang (1):
      can: dev: can_fill_info(): don't wake up controller if interface is down

Chung-Chiang Cheng (1):
      splice: report related fsnotify events

Claudiu Beznea (1):
      phy: renesas: rcar-gen3-usb2: Avoid long delay in atomic context

Cong Nguyen (3):
      media: microchip-csi2dc: fix async notifier leak on probe error path
      staging: media: imx: csc-scaler: fix ipu_image_convert_run leak on queue error
      leds: lm3692x: Fix regulator/gpio leak and wrong enabled state on last write failure

Cong Zhang (1):
      virtio_blk: use synchronous quiesce in virtblk_freeze_priv()

Cristian Ciocaltea (1):
      nvmem: rockchip-otp: Add clks and reg_read to rockchip_data

Cristian Papa (1):
      wifi: mt76: feed the station RSSI average from the chain signals

Cryolitia PukNgae (1):
      ALSA: usb-audio: rename QUIRK_FLAG_MIXER_MIN_MUTE to QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE

Cunhao Lu (1):
      can: dev: can_put_echo_skb(): free skb on invalid echo index

DAI RENJIE (1):
      resource: fix lost wakeup when waiting for a muxed region

Daan De Meyer (1):
      io_uring/net: don't retry a non-blocking connect() that fails with -EAGAIN

DaeMyung Kang (5):
      ksmbd: avoid restoring only in-memory EOF after allocation change
      ksmbd: preserve unreadable named streams on open
      ksmbd: return end of file for reads past a named stream's data
      ksmbd: use the existing xattr name for a named stream
      ksmbd: fix named stream write and EOF handling

Daeho Jeong (5):
      f2fs: avoid setting SBI_NEED_FSCK on transient resize failure
      f2fs: return -EIO for a lost inode block after cp_error
      f2fs: disallow mmap write and data-modifying fallocate on atomic files
      f2fs: don't use truncate_inode_pages_final() on live inodes
      f2fs: release a removed xattr node in roll-forward recovery

Daehyeon Ko (10):
      vsock/vmci: validate packet source for connected sockets
      aio: prevent eventfd/epoll recursion on poll
      ipc/mqueue: release notification resources during inode eviction
      ipv6: remove ifaddr from hash during ifdown list cleanup
      ipv6: serialize address publication with device teardown
      ipv6: initialize temporary ifaddr before publication
      ipv6: do not restart DAD for a dead ifaddr
      crypto: algif_skcipher - rewind rounded output bytes
      splice: avoid stale f_pos writeback on error
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

Dairui Zhang (2):
      ksmbd: verify transform SessionId matches the decrypted header
      IB/mad: fix UAF and double-free in RMPP receive reassembly

Damien Le Moal (1):
      block: Allow using bio_attempt_back_merge() internally

Damon Ding (1):
      drm/bridge: analogix_dp: Restore mandatory samsung DP DT properties

Dan Carpenter (5):
      wifi: b43: don't pass unterminated string to sscanf()
      wifi: b43legacy: debugfs: NUL terminate string in debugfs
      wifi: carl9170: NUL terminate string in debugfs
      mm/hmm/test: reject overflowing page counts
      Bluetooth: msft: Fix error code in msft_cancel_address_filter_sync()

Daniel Borkmann (1):
      bpf, lsm: Reject writes into the BPF LSM program context

Daniel Golle (1):
      net: dsa: mt7530: error out on failed PHY_IAC command writes

Daniel Machon (4):
      net: sparx5/lan969x: do not read past skb->len when injecting a frame
      net: lan966x: do not inject uninitialised bytes past skb->len
      net: lan966x: do not warn on MAC entries that are not port destined
      net: lan966x: release the in-flight slot of a stale TX skb

Daniel Ortiz (1):
      ASoC: amd: yc: Add DMI quirk for Lenovo V15 G6 ARP

Daniel Palmer (1):
      m68k: apollo: Fix interrupt setup

Daniel Phillips (1):
      amdkfd: Fix memory availability double accounting of kfd pinned objects

Daniel Starke (1):
      tty: n_gsm: fix missing modem controls after DLCI open in convergence layer type 2

Daniel Wagner (4):
      nvmet: force reconnect when number of queue changes
      nvme-fabrics: reset io_queues before computing the queue mapping
      nvme-fabrics: limit each queue type to the number of online CPUs
      nvme-fabrics: clear the poll map if no poll queues are mapped

Danila Chernetsov (1):
      dlm: validate lock modes in recovery messages

Danish Khateeb (3):
      perf/core: Don't send SIGTRAP after exec removed the event
      tools/nolibc: stop rounding malloc() sizes up to 4096 bytes
      tools/nolibc: check for overflow in malloc()

Dapeng Mi (3):
      perf/x86/intel: Fallback to sw branch type decoding if no hw decoding
      perf/x86: Unregister PMI handler on PMU init failure
      perf/x86: Free hybrid state on PMU init failure

Darong Lu (1):
      libceph: initialize CRUSH choose argument weights

Darrick J. Wong (15):
      xfs: strengthen the "is cow staging" helpers in scrub
      xfs: check fork type against dabtree block magic number
      xfs: mark overfull dabtree node blocks as corrupt
      xfs: jump out of xchk_bmap_check_rmap if fatal signals
      xfs: check for fragments when full-extent sharing matches
      xfs: only written file data blocks can be shared
      xfs: opportunistically skip btree block checks
      xfs: propagate errors while checking null siblings
      xfs: range-check bc_levels array access in scrub tracepoints
      xfs: check for buffer overruns when examining local/remote xattr entries
      xfs: improve dirent bounds checking in scrub and repair
      xfs: allow softlimit with no hardlimit in quota scrub
      xfs: rescan the AGs if incore delalloc counter is negative
      xfs: reject absurdly large xattr value lengths in xchk_xattr_actor
      xfs: always report scrub errors in tracepoints

Dave Carey (1):
      HID: multitouch: Fix stale MT slots when contact count drops to zero

Dave Jiang (5):
      efi/cper: Reject CPER records with an out-of-range error_data_length
      efi/cper: Reject an error status block length that wraps a u32
      ACPI: extlog: Validate elog record length before walking sections
      efi/cper: Read only validated fields in cper_mem_err_pack()
      PCI/AER: Add optional logging callback for correctable error

David Bauer (2):
      wifi: mt76: mt7603: free beacon SKB on error
      wifi: mt76: mt7915: configure noise floor reporting on reset

David Cemin (1):
      ASoC: sdw_utils: clear stale RT711 device reference on exit

David Francis (2):
      drm/amdkfd: Avoid integer underflow with ffs in EOP ring size calc
      drm/amdkfd: Avoid integer underflow in EOP ring size calculation.

David Heidelberg (8):
      backlight: qcom-wled: Fix NULL pointer dereference in wled_remove()
      backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe
      backlight: qcom-wled: Fix WLED3 brightness register stride
      mfd: wcd934x: set DMA mask on parent to silence "DMA mask not set"
      mfd: wcd934x: Fix NULL pointer dereference on IRQ probe deferral
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Extend the xbl_mem region
      arm64: dts: qcom: sdm845-xiaomi-polaris: Extend the xbl_mem region
      ASoC: wcd-mbhc-v2: Fix incorrect properties names and typos

David Hildenbrand (Arm) (19):
      mm/gup: fix always draining LRU caches in collect_longterm_unpinnable_folios()
      mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()
      mm/shmem: discard whole new large folios on fallocate rollback
      mm/shmem: fix truncation of files containing only swapin-error markers
      mm/ksm: reset the unstable trees of all nodes
      mm/madvise: fix data loss from MADV_FREE on a KSM page
      mm: disallow ioremap'ing ordinary RAM in generic_access_phys()
      mm/gup: check for overflow when converting nr_pages to bytes in GUP-fast
      mm/ksm: fix use of a freed anon_vma at swap-in
      mm/userfaultfd: wake waiters when registration modes are removed
      mm/memory-tiers: unregister empty tiers outside memory_tier_lock
      mm/mremap: recheck PUDs under the page table lock
      mm/vma: don't leak the charge for stack growth
      mm/mremap: use pudp_huge_get_and_clear() when moving huge PUDs
      mm/rmap: handle device-exclusive entries in folio_referenced_one()
      fork: take mmap_lock before copying mm_struct
      mm/filemap: finish fault cleanup before dropping the fault lock
      mm/shmem: make shmem_file() check the file's inode
      mm/shmem: fix accounting of swapin-error markers

David Howells (2):
      rxrpc: Fix update of call->tx_pending without holding lock
      afs: Fix afs to abort the rxrpc call on send error

David Laight (1):
      usb_string_copy: Use kzalloc() to avoid leaking old data

David Lechner (2):
      iio: introduce struct iio_scan_type
      iio: buffer: use struct iio_scan_type to simplify code

David Lee (1):
      sctp: hold shkey across socket migration

David Woodhouse (2):
      tun: Require CAP_NET_ADMIN to attach to an ownerless device
      KVM: x86/xen: Take kvm->srcu in __kvm_xen_has_interrupt()

David Yang (1):
      net: hisilicon: hisi_femac: Stop the receiver before releasing the RX ring

Dean Luick (1):
      IB/hfi1: Use dma_mmap_coherent for matching buffers

Deepanshu Kartikey (1):
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

Detlev Casanova (2):
      arm64: dts: rockchip: Rename rk3328 HDMI audio card
      arm64: dts: rockchip: Rename rk3566 and rk3568 HDMI audio cards

Dev Jain (3):
      mm/rmap: use huge_ptep_get() in try_to_unmap_one()
      mm/rmap: use huge_ptep_get() in try_to_migrate_one()
      mm/page_vma_mapped: use huge_ptep_get() for hugetlb

Devansh Soni (1):
      staging: rtl8723bs: fix missing unregister_netdev on sdio_alloc_irq failure

Devin Wittmayer (4):
      wifi: mt76: mt76x02: report rx FCS errors to mac80211
      wifi: mac80211: refuse to make a monitor active when it has no queue
      wifi: mt76: mt7921: fix lock inversion between dev->mutex and iflist_mtx
      wifi: mt76: mt7921: fix the lock inversion in suspend and resume

Dibin Moolakadan Subrahmanian (1):
      drm/i915/dmc: Add sanity check for DMC load address

Diego Fernando Mancera Gomez (1):
      usb: image: microtek: stop SG processing after transfer errors

Diego Oliva (4):
      smb: client: fix use-after-free infoleak via the readdir resume name
      smb: client: fix OOB last_entry pointer from unbounded LastNameOffset
      smb: client: fix OOB read of the resume name sent in TRANS2_FIND_NEXT2
      smb: client: fix OOB read in the SMB_FIND_FILE_UNIX name scan

Dinh Nguyen (1):
      EDAC/altera: Use parent device for devres in altr_portb_setup()

Dmitrii Tulnov (1):
      kconfig: warn about malformed KCONFIG_PROBABILITY values

Dmitry Antipov (2):
      HID: roccat: fix locking in roccat_connect() and roccat_disconnect()
      leds: flash: Prevent using uninitialized variable in flash_fault_show()

Dmitry Baryshkov (10):
      drm/msm/mdp5: drop cursor pipe for msm8x76
      drm/msm/dpu: bail from _dpu_core_perf_crtc_update_bus if there are no ICC paths
      drm/msm/dpu: drop separate dpu_core_perf_tune overrides
      drm/msm/dpu: use dpu_perf_cfg in DPU core_perf code
      drm/msm/dpu: extract bandwidth aggregation function
      drm/msm/dpu: change ib values to u32
      drm/msm/dpu: make fix_core_ab_vote consistent with fix_core_ib_vote
      drm/msm/dpu: drop core_clk_rate overrides from _dpu_core_perf_calc_crtc
      drm/msm/dpu: handle perf mode in _dpu_core_perf_crtc_update_bus()
      drm/msm/dpu: initialise clk_rate to 0 in _dpu_core_perf_get_core_clk_rate

Dmitry Osipenko (1):
      clk: tegra: support 48MHz clock for pll_p_out1

Dmitry Torokhov (4):
      mfd: ipaq-micro: Fix out-of-bounds stack read in ipaq_micro_str
      gpio: crystalcove: add missing MODULE_ALIAS()
      ASoC: tlv320aic32x4: move regmap_config into i2c and spi drivers
      ASoC: tlv320aic32x4: clean up driver code formatting and logging

Dmytro Moroziuk (1):
      ALSA: hda/conexant: Add mute LED quirk for HP ProBook 440 G5

Dominic White (1):
      wifi: cfg80211: allow zero HE OBSS PD offsets

Dominik Maier (2):
      smb: client: fix slab-out-of-bounds write in id_mode_to_cifs_acl()
      loop: check for read-write open mode on LOOP_SET_STATUS in lo_compat_ioctl()

Dominique Martinet (1):
      libbpf: fix cross-endian build with newer libbpf

Donggeun Yoo (7):
      swiotlb: use the adjusted address for the highmem page lookup
      tracing: Undo the registration when enabling the histogram trigger fails
      tracing: Fix NULL dereference when copying keys for a field variable
      tracing: Add the bucket size to expr_field_str()
      tracing: Print the bucket size as unsigned
      tracing: Clamp the printed end of a histogram bucket at U64_MAX
      tracing: Print a signed histogram key as signed

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

Duoming Zhou (1):
      cxgb4: fix use after free bugs caused by circular dependency problem

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

Elliot Berman (2):
      ext4: fix NULL folio dereference in mballoc
      bs/ntfs3: fix NULL folio dereference in ntfs_lock_new_page()

Emily Peri (1):
      staging: rtl8723bs: Fix indentation in conditional statements

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: reset the smart fifo state upon FW stop

Eric Biggers (6):
      fsverity: Be more careful with return value of ->get_verity_descriptor()
      fsverity: Explicitly require FMODE_READ to retrieve hashes
      xor: add missing vzeroupper to AVX code
      raid6: add missing vzeroupper to AVX-512 code
      raid6: add missing vzeroupper to AVX2 code
      lib/crypto: mips: Disable Octeon SHA code on little-endian kernels

Eric Dumazet (18):
      ixgbe: reserve TX timestamp after skb preparation
      ipv4: tunnels: use DEV_STATS_INC()
      ipmr: prevent info-leak in pmr_cache_report()
      dlm: fix send buffer backpressure handling
      inet: frags: limit the truesize of a reassembly queue
      sit: fix UAF in ipip6_tunnel_del_prl()
      ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup
      ipv4: fix IP ID reuse in ip_select_ident_segs()
      tcp: tcp_metrics: use the socket netns, not the dst device netns
      ipv6: account route exceptions to the netns of their dst
      net: shrink the payload-only part of skb dataref to one bit
      net: fix frag_list leak in skb_segment_list() error path
      ipmr: clear skb->cb[] in reg_vif_xmit()
      net: add eth_type_trans_careful()
      loopback: use eth_type_trans_careful()
      net: use eth_type_trans_careful() in __dev_forward_skb2()
      openvswitch: use eth_type_trans_careful() in internal_dev_recv()
      selftests/net: fix typo in tcp_mmap

Eric Huang (1):
      drm/amdkfd: add sanity check in svm_range_is_valid

Eric Kim (1):
      sched/fair: Reset NUMA fault locality after scan period update

EricChan (1):
      net: stmmac: Fix interrupt handling for level-triggered mode in DWC_XGMAC2

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

Ewan D. Milne (1):
      nvmet: don't return memory contents beyond valid data when reading ANA log page

Fabio Cesari (1):
      iio: light: isl29028: fix runtime PM reference leak on error paths

Fabrice Derepas (2):
      crypto: asymmetric_keys - fix OOB read in pefile_parse_binary
      ima: reject a kexec buffer whose declared size exceeds the buffer

Fan Wu (10):
      mmc: hsq: Fix use-after-free in retry work
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

Felix Fietkau (4):
      wifi: mt76: mt7615: fix NULL deref in mt7615_mac_set_rates
      wifi: mt76: set the EOSP bit in the QoS header of the last released frame
      wifi: mt76: mt7603: fix U-APSD service period termination
      wifi: mt76: mt7915: check default EEPROM firmware size before copying

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

Fernando Fernandez Mancera (4):
      netfilter: tproxy: use DEBUG_NET_WARN_ON_ONCE for protocol fallbacks
      netfilter: synproxy: fix reset of ct seqadj when reopening a connection
      net: openvswitch: skip IPv4 later fragments on TCP/UDP set actions
      net: openvswitch: drop IP fragments on SCTP set action

Filipe Manana (5):
      btrfs: fix memory barrier order in reloc_root_is_dead()
      btrfs: fix off by one super block end offset calculation when writing super blocks
      btrfs: avoid tree mod log ENOMEM failures when we don't need to log
      btrfs: fix dangling nodes in tree-mod-log after error in btrfs_tree_mod_log_insert_root()
      btrfs: qgroup: fix swapped blocks existence check when tracing after COW

Finn Thain (17):
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
      swim: Fix FDEJECT ioctl for exclusive open
      swim3: Fix FDEJECT ioctl for exclusive open

Florian Fainelli (2):
      tools/thermal/tmon: Fix string truncation warning in optarg copy
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

Francesco Orlando (1):
      Input: xpad - add GameSir Nova Lite support

Franck Baur (1):
      net: jme: keep RX MAC clock enabled for WoL

Fredric Cover (1):
      smb: client: fix early procfs exposure race

Fuad Tabba (7):
      KVM: arm64: Transfer the hyp stack pages out of the host stage-2
      irqchip/gic-v3-its: Don't clamp nvecs to zero when id_bits is 32
      KVM: arm64: vgic-its: Don't map an LPI from more than one event
      arm64: pi: Run the source checker on the libfdt objects under C=2
      irqchip/gic-v3-its: Clear vpt_page after freeing the pending table
      irqchip/gic-v3-its: Don't free a vPE table shared with another ITS
      irqchip/gic-v3-its: Don't free the tables of an enabled ITS

Gabor Tanz (1):
      HID: quirks: Always poll the Anne Pro 2 with product ID a292

Gabriel Krisman Bertazi (1):
      ext4: Move CONFIG_UNICODE defguards into the code flow

Gabriel Prostitis (1):
      USB: gadget: inode: fix mm lifetime handling

Gael Blivet (2):
      ksmbd: skip fallocate for SMB2_CREATE_ALLOCATION_SIZE on a stream handle
      ksmbd: fix AsyncId zeroed before use in smb2_lock() cancel response

Gary Guo (1):
      ata: ata_generic: Don't store pci_device_id

Geert Uytterhoeven (2):
      spi: sh-msiof: SITMDR1/SIRMDR1 bitfield conversion
      clk: rs9: Add clock index range check to rs9_of_clk_get()

Geetha sowjanya (1):
      perf: marvell: Cancel CN10K DDR PMU hrtimer on device remove

Geliang Tang (1):
      nvme-tcp: look up host_iface in the current netns

Georgia Garcia (1):
      apparmor: remove fs entries created by a failed policy load

Geraldo Nascimento (2):
      PCI: rockchip-host: Do not attempt 5.0 GT/s retraining
      PCI: rockchip: Drive at 2.5 GT/s, error other speeds

Gianluca Balboni (1):
      ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx

Ginger Li (3):
      media: exynos4-is: Fix a race between s_stream(0) and the interrupt handler
      media: i2c: ov5648: Fix a data race on state->streaming
      wifi: mac80211: Fix a race when expiring a mesh path

Giorgi Kobakhia (2):
      ksmbd: fix overflow in dacloffset bounds check in build_sec_desc()
      ocfs2: fix array out of bound access in __ocfs2_find_path()

Giovanni Di Santi (2):
      fbdev: kyro: Use devm_ioremap() for mmio registers
      fbdev: kyro: Use devm_ioremap_wc() for screen mem

Golla Nagendra (1):
      dmaengine: zynqmp_dma: Fix chan probe/remove error handling

Greg Kroah-Hartman (5):
      Revert "net: stmmac: protect updates of 64-bit statistics counters"
      media: adv7604: avoid negative array index in log_status when cp_read fails
      media: stv090x: bound DiSEqC reply length to msg[] size
      media: stv0900: bound DiSEqC reply length to msg[] size
      Linux 6.1.193

Greg Thelen (1):
      selftests/net: tcp_mmap: remove unused -k option and keepflag

Gregory CLEMENT (1):
      phy: cadence: Sierra: Do not modify register when getting parent clock

Gregory Price (4):
      mm/mempolicy: take a cpuset cookie for the interleave node count
      rtc: cmos: Disable ACPI RTC event before handling it
      mm/madvise: use folio_trylock() in the cold/pageout PMD split
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

Guanglei Zhu (2):
      ceph: fix out-of-bounds read in ceph_netfs_issue_op_inline()
      ceph: clamp the inline data length in ceph_fill_inline_data()

Guangshuo Li (19):
      i2c: qcom-cci: fix autosuspend cleanup
      i2c: imx: disable autosuspend on remove
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
      mfd: ab8500: Fix child device leaks on probe failure
      media: i2c: ov5647: fix power cleanup on remove
      irqchip/imx-intmux: Fix runtime PM teardown on remove
      platform/x86: simatic-ipc: fix platform device leak on registration failure
      crypto: omap-sham - fix crypto engine cleanup
      media: i2c: ar0521: remove duplicate media entity cleanup
      floppy: unregister platform device on add_disk failure

Guenter Roeck (11):
      hwmon: (asus_wmi_sensors) Avoid global struct mutation
      hwmon: (lm87) Fix drvdata type confusion in vrm_show() and vrm_store()
      hwmon: (nct6683) Fix incorrect struct cast in show_pwm() and store_pwm()
      hwmon: (peci/dimmtemp) Fix devres leak and UAF on concurrent unbind
      hwmon: (pmbus/q54sj108a2) Add missing NULL pointer check
      hwmon: (pmbus) Release devres allocated memory after devm_thermal_of_zone_register error
      hwmon: (pmbus) Fix return value check from thermal zone registration
      hwmon: (pmbus) Check return value from pmbus_thermal_add_sensor()
      hwmon: (coretemp) Fix 32-bit jiffies wraparound in show_temp()
      hwmon: (tmp108) Fix initial conversion delay and wait until ready
      hwmon: (coretemp) Check for NULL platform device in hotplug callbacks

Gui-Dong Han (1):
      xen/blkback: Prevent missed completion when draining I/O

Guiting Shen (1):
      ASoC: tlv320aic32x4: Fix the divide by zero

Guixin Liu (3):
      nvmet-fc: Tear down the association when the admin queue allocation fails
      nvmet: Finish the blk plug when integrity allocation fails
      nvmet: Free the old negotiation state when restarting authentication

Guixiong Wei (1):
      platform/x86/intel-uncore-freq: Continue restoring limits on resume

Guoqing Jiang (1):
      block/rnbd-srv: rename one member in rnbd_srv_dev

Gyokhan Kochmarla (1):
      erofs: use on-disk blkszbits for lz4 max pcluster bound

Günther Noack (1):
      landlock: Fix superblock use-after-free in release_inode()

Haibo Chen (1):
      leds: pca9532: Check i2c_smbus_read_byte_data() return value

Haitam Lazaar (1):
      RDMA/siw: Enforce IB_ACCESS_REMOTE_READ for read responses

Hannes Reinecke (3):
      nvme: add TCP TSAS definitions
      nvmet: make TCP sectype settable via configfs
      nvmet: do not return 'reserved' for empty TSAS values

Hans Verkuil (6):
      media: em28xx: dev_info->pr_info since dev has been freed
      media: em28xx: requeue buffers if start_streaming fails
      media: em28xx: use vb2_video_unregister_device
      media: cec: tegra_cec: don't break off msg on NACK
      media: cec/core: drop cec_post_state_event call
      media: rockchip: rga: fix clock cleanup

Hans de Goede (1):
      iio: core: Add iio_read_acpi_mount_matrix() helper function

Haotian Zhang (3):
      phy: hisilicon: hi3670: Fix OF node and device reference leaks
      mtd: rawnand: pl353: fix clk reference leak in pl35x_nfc_setup_interface()
      scsi: elx: libefc: Fix resource leak in efcport_init() error path

Haoxiang Li (4):
      ASoC: hdac_hdmi: Fix resource cleanup on probe failure
      tty: serial: pch_uart: add check for pci_get_slot()
      usb: fsl_qe_udc: check qe_alloc_request() failure in ch9getstatus()
      iwlwifi: dvm: add missing cleaup for on error path

Harald Freudenberger (2):
      s390/crypto: Fix skcipher_walk return code handling in aes_s390
      s390/zcrypt: Fix out-of-bounds ptr advance in cca_query_crypto_facility()

Hari Mishal (5):
      nvme: bound ns descriptor header and body to identify buffer
      virtio_console: take a kref in find_port_by_vq() to fix port UAF
      nvmet: passthru: fix OOB reads when parsing ns id descriptor list
      drm/amd/display: guard dc_sink dereferences in MST mode validation
      drm/amd/pm: bound SCLK FCW range entries to the table size

Heiko Carstens (3):
      s390/probes: Fix wrong opcode for cgrb fixup
      s390/signal: Fix incorrect return address in signal frame
      s390/uprobes: Fix off-by-one bug in emulated PER handling

Heiko Schocher (1):
      drm/panel: simple: Add Kyocera tcg070wvlq panel

Helge Deller (2):
      fbcon: Fix KASAN slab-out-of-bounds Read in fbcon_prepare_logo
      sticon/parisc: Detect default STI graphics card for console output

Hemanth Selam (2):
      ext4: skip extra isize expansion while unmounting
      nvdimm/pmem: Release gendisk on probe failure

Hengyu Liang (1):
      serial: core: fix TIOCSSERIAL and TIOCSERCONFIG on uninitialised ports

Henrik Enquist (2):
      ALSA: aloop: Don't constrain playback params in notify mode
      ALSA: aloop: Update the PCM Slave controls for a matching playback

Henry Hu (4):
      ksmbd: fix invalid pointer dereference when get_inode_acl() fails
      ksmbd: fix link speed query in fsctl_query_iface_info_ioctl()
      ksmbd: fix unlocked IPv6 addr_list walk in fsctl_query_iface_info_ioctl()
      ksmbd: fix invalid Next offset in interface info replies

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

Hilda Wu (3):
      Bluetooth: btrtl: Add btrealtek data struct
      Bluetooth: btusb: Ignore zero length of USB packets on ALT 6 for specific chip
      Bluetooth: msft: Extended monitor tracking by address filter

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

Hongling Zeng (2):
      ntfs3: fix mapping pairs bounds check for alignment
      dmaengine: sun6i-dma: Fix use-after-free in error handling paths

Hongyan Xu (5):
      mfd: da903x: Cancel IRQ work during teardown
      soc: qcom: apr: clean up failed service registrations
      RDMA/hfi1: shut down the trap timer before unregistering
      RDMA/hfi1: quiesce SDMA asynchronous cleanup on exit
      ASoC: mt6359-accdet: manage private workqueues with devres

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

Hui Su (1):
      cpufreq: schedutil: Serialize sugov_start() against rate limit updates

Huisong Li (1):
      ACPI: PCC: Setup PCC Opregion handler only if platform interrupt is available

Hung-Jui Lin (1):
      posix-timers: Report zero remaining time for disarmed SIGEV_NONE timers

Hungyu Lin (9):
      compat: avoid double rounding in times()
      timers/itimer: Keep a nonzero value at CPU timer expiry
      time/namespace: Fix overflow when converting absolute deadlines
      fs: skip copy_file_range write limits when there is no data
      posix-timers: Accept NULL clock_getres() output in stubs
      inotify: do not coalesce rename events
      block: Return the soft block size for compat BLKBSZGET
      mm/migrate: untag addresses when querying page nodes
      thermal: Fix CPU mask truncation in power limit trace event

HyeongJun An (25):
      ALSA: rawmidi: Return the error from snd_rawmidi_input_params()
      remoteproc: elf_loader: Bound the section header table
      mtd: spi-nor: sfdp: check the length of the xSPI Profile 1.0 table
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

Ian Bridges (6):
      ksmbd: fix out-of-bounds read when padding the final compound response
      ksmbd: fix session reference leak on compounded SESSION_SETUP
      ksmbd: require DELETE access for delete-on-close opens
      ksmbd: grant a POSIX ACL group entry only to the group's members
      ksmbd: enforce the read-only share flag when creating a stream
      ksmbd: do not read past the DACL in the access denied debug message

Ian Gallagher (1):
      ACPI: button: Add lid_init_state quirk for Razer Blade Stealth 13 (Early 2020) RZ09-0310

Ian Rogers (3):
      perf: Replace perf_event_header__init_id with full header init
      perf header: Fix potential memory corruption in cpu_cache_level__read
      perf build: Check the version of the compiler that is used

Ibrahim Hashimov (1):
      fs/ntfs3: fix integer overflow in find_log_rec() causing OOB read

Icenowy Zheng (2):
      dt-bindings: vendor-prefixes: add Genesys Logic
      dt-bindings: vendor-prefixes: add Source Parts and Lctech names

Ido Schimmel (6):
      ipv6: Fix redirect exception creation for UDP/RAW sockets
      ipv6: udp: Create exceptions before socket matching
      ipmr: fully initialize the synthetic IP header in ipmr_get_route()
      vxlan: Stop rejecting dynamic FDB entries with a nexthop ID
      ipmr, ip6mr: validate packets injected into the register vif on xmit
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

Imre Kaloz (7):
      PCI: Disable MSI for ULi M1575 EHCI controller
      scsi: aic7xxx: Use default settings on the SGI O2 onboard controllers
      MIPS: mm: Fix the cache error vector jump for XKPHYS kernels
      MIPS: sgi-ip32: Mask MACE PCI interrupts in CRIME only
      MIPS: sgi-ip32: Leave MACE PCI control alone in config accesses
      rtc: ds1685: arm the wake-up alarm at power-off only if an alarm is set
      rtc: ds1685: do not sleep in the power-off handler

Israel Téllez García (1):
      libbpf: Fix ring buffer consumer loop on 32-bit position wrap

Ivan Hu (1):
      ACPICA: Initialize parser_state.aml_end in acpi_install_method()

Ivan Lipski (1):
      drm/amd/display: Bump frame warning limit for clang builds of dml

Jacob Keller (5):
      ice: handle discarding old Tx requests in ice_ptp_tx_tstamp
      ice: protect init and calibrating check in ice_ptp_request_ts
      ice: cleanup allocations in ice_ptp_alloc_tx_tracker
      ice: handle flushing stale Tx timestamps in ice_ptp_tx_tstamp
      ice: set in_use only after preparing Tx timestamp index

Jacob Moroni (1):
      RDMA/irdma: Fix FRWR IRDMAQPSQ_PBLADDR field population

Jagan Teki (1):
      dt-bindings: vendor-prefixes: Document Chongzhou

Jake Labelle (2):
      nilfs2: validate directory position after llseek in readdir
      nilfs2: reject non-regular inodes in dsync recovery

Jakub Kicinski (3):
      net: skbuff: move alloc_cpu into a potential hole
      eth: bnxt: free XDP frags when xdp_do_redirect() fails
      eth: bnxt: hand XDP frags over to the copybreak skb

Jakub Sitnicki (3):
      net: Helper to move packet data and metadata after skb_push/pull
      bpf: Make bpf_skb_adjust_room metadata-safe
      net: lwtunnel: Drop skb metadata before LWT encapsulation

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

James Seo (1):
      driver core: device.h: add some missing kerneldocs

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

Jani Nikula (2):
      drm/edid: parse VICs from CTA VDB early
      drm/edid: parse display info has_audio similar to is_hdmi

Jann Horn (1):
      mm: document mmu_notifier_invalidate_range_start_nonblock()

Janne Grunau (1):
      wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload

Jason Gunthorpe (1):
      efi/libstub: Fix error unwind freeing fdt in allocate_new_fdt_and_exit_boot()

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

Jeff Layton (4):
      nfsd: dedup nfs4_client_to_reclaim inserts
      nfsd: use test_and_clear_bit for somebody_reclaimed to prevent lost update
      SUNRPC: keep the first error in svc_register()
      nfsd: don't offer flexfiles layouts when NFSv3 isn't being served

Jeffin Philip (1):
      media: vidtv: fix uaf in vidtv_bridge_on_new_pkts_avail

Jens Axboe (4):
      io_uring/rw: end write accounting from ->ki_complete
      io_uring/sqpoll: don't attach to a thread that is canceling
      io_uring/poll: don't poll a writer for a read side hangup
      io_uring/poll: don't poll a writer for urgent data

Jenson Johnathon Reggentin (1):
      docs: block: fix dead http link in blk-mq.rst

Jeremy Bongio (1):
      RDMA/irdma: Use kvzalloc for lvl2 leafmem allocation

Jeremy Kerr (3):
      net: mctp: avoid confusion over local/peer dest/source addresses
      net: mctp: Add some detail on the key allocation implementation
      net: mctp: separate key correlation across nets

Jerome Brunet (3):
      clk: sunxi-ng: fix ccu probe clock unregister on error
      clk: fix self-consuming provider module pinning
      clk: cdce925: Size the PLL child name buffer for any int

Jesse Zhang (10):
      drm/amdgpu: force complete the MES ring fences on reset
      drm/amdgpu: reject ANONONLY userptrs that span multiple VMAs
      drm/amdkfd: evict the queues only once for CRIU PROCESS_INFO
      drm/amdgpu: parse CS IBs at the BO offset their VA mapping starts at
      drm/amdgpu: reject CS chunks too large for kvmalloc()
      drm/ttm: return an error when kmapping a BO without pages
      drm/amdgpu: drop the gang leader reference when freeing gang jobs
      drm/amdgpu: keep the CS user fence BO in GTT
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

Jiale Yao (36):
      HID: zydacron: validate key report length
      HID: cougar: reject short special-key reports
      HID: cp2112: validate response report lengths
      HID: elo: reject short touchscreen reports
      HID: logitech-dj: validate unnumbered keyboard reports
      HID: mcp2221: validate response report length
      HID: pxrc: reject short input reports
      HID: roccat: isku: reject short button reports
      HID: roccat: koneplus: reject short button reports
      HID: roccat: konepure: reject short button reports
      HID: roccat: kovaplus: reject short button reports
      HID: roccat: pyra: reject short button reports
      HID: roccat: ryos: reject short special reports
      HID: roccat: savu: reject short special reports
      cxl/acpi: Check ACPI companion before use
      wifi: mt76: mt7615: cancel reset work during unregister
      drm/amdkfd: validate SRAT subtables before parsing
      HID: prodikeys: validate fixed-format MIDI reports
      hwmon: (aquacomputer_d5next) reject short status reports
      crypto: ccp - kill v3 IRQ tasklet during teardown
      crypto: ccp - kill v5 IRQ tasklet during teardown
      RDMA/mad: Reject receive completions shorter than GRH
      ASoC: rt5682-sdw: always cancel jack work on remove
      ASoC: rt711-sdw: always cancel jack work on remove
      ASoC: rt711-sdca: always cancel jack work on remove
      pinctrl: sprd: free maps on DT map failure
      wifi: mt76: mt76x02: validate RX padding before use
      wifi: mt76: usb: fix source overread in mt76u_copy
      wifi: mt76: mt7615: usb: fix source overread in mt7663u_copy
      ACPI: PCI: pci_link: clear driver_data before free
      wifi: ath10k: avoid IDR mutation during TX cleanup
      wifi: ath11k: avoid IDR mutation during pending mgmt TX cleanup
      wifi: ath11k: avoid IDR mutation during vif mgmt TX cleanup
      platform/olpc: Reserve space for a string terminator
      team: reject CAN, IEEE 802.15.4 and 6LoWPAN devices in team_port_add
      regulator: irq: freeze deferred hardware access during suspend

Jiaming Zhang (4):
      hfsplus: validate extent record length before writing it back
      ocfs2: fix chunk number of the first chunk in a local quota file
      gfs2: reject invalid inode sizes
      nilfs2: force clear dirty state when restoring from the shadow map

Jiangong.Han (1):
      USB: usbmon: fix null-ptr-deref in mon_bus_remove() when mon_bus_init() fails

Jianyun Gao (3):
      dax: Return errors from dax_core_init()
      dax: fix dax_range_compare_iter() to use correct size and address offset
      xfs: fix temporary cursor leak in btree shift corruption paths

Jiapeng Chong (1):
      i2c: qcom-cci: Remove the unused variable cci_clk_rate

Jiawen Liu (2):
      media: amphion: fix runtime PM imbalance on probe failure
      memory: exynos5422-dmc: handle clock enable failures

Jiaxing Hu (1):
      iommu/rockchip: Clear stale page faults before enabling stall

Jiayuan Chen (6):
      netfilter: ebtables: bound num_counters like nentries in do_replace()
      bonding: fix out-of-bounds read of arp_ip_target
      tcp_bic: fix divide by zero on max_increment == 0
      tcp_hybla: fix divide by zero on rtt0 == 0
      tcp_cubic: fix divide by zero and endless loop on bad module params
      bpf: Fix verifier WARN on narrow read of bpf_tcp_sock u64 fields

Jiebin Sun (1):
      perf c2c: Fix documented default coalesce fields

Jingyi Wang (2):
      remoteproc: qcom: Check subdev start status in rproc_stop()
      remoteproc: core: cancel crash_handler work in rproc_add() error path

Jinhui Guo (1):
      net: usb: cdc_ether: add quirk for AMI BMC stale link events

Jinjie Ruan (2):
      ext4: fix out-of-bounds read in ext4_get_group_info()
      arm64: kexec_file: Fix elf_headers memory leak in retry loop

Jinqian Yang (1):
      virtio_ring: fix infinite loop in virtnet_poll_cleantx when device is broken

Jinwang Li (1):
      Bluetooth: L2CAP: Ignore connection responses with wrong ident

Jiri Slaby (SUSE) (3):
      serial: 8250_lpss: do not touch uninitialized line in ehl_serial_exit()
      HID: hid-prodikeys: remove struct pk_device
      serial: 8250_exar: store the GPIO platform device in struct exar8250

Jisheng Zhang (4):
      net: stmmac: don't clear network statistics in .ndo_open()
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

Joas Antonio dos Santos (3):
      calipso: hash the cache key, not the option start, in calipso_cache_add()
      calipso: update payload_len when removing the CALIPSO option
      net: dcb: initialize PFC value before calling getpfccfg

Joe Damato (1):
      mm: memcontrol: raise MEMCG_MAX for charges that fail without reclaiming

Joe Hattori (1):
      PM: wakeup: implement devm_device_init_wakeup() helper

Johan Alvarado (1):
      net: stmmac: raise TX completion interrupt at the end of an xmit burst

Johan Hovold (11):
      serial: fix ioctl hangup race
      serial: abort TIOCMIWAIT on hangup
      media: usbtv: drop redundant device reference
      driver core: fix parent lock use-after-free on USB disconnect
      staging: greybus: uart: fix racy TIOCMIWAIT implementation
      USB: cdc-acm: fix urb leak on disconnect
      USB: serial: usb_wwan: fix urb leak on disconnect
      USB: serial: sierra: fix urb leak on write completion
      PM: sleep: wakeirq: drop unused enable helpers
      interconnect: exynos: drop redundant link destroy
      irqchip/gic-v3-its: Use irq_domain_create_hierarchy()

Johannes Berg (8):
      wifi: mac80211: fix unauthorised port check for encap offload
      wifi: ath6kl: don't take RTNL in del_virtual_intf
      wifi: mac80211: clear fragment cache entry 'is_protected'
      wifi: mac80211: mesh: use hlist_add_head_rcu()
      wifi: mac80211: kill wake_txqs_tasklet on unregistration
      wifi: mac80211: init radiotap iter after length checks
      wifi: cfg80211: reg: protect regdb pointer with RCU
      wifi: cfg80211: track SSID regardless of country data

Johannes Thumshirn (1):
      btrfs: zoned: fix double list add in btrfs_load_block_group_zone_info

Johannes Weiner (2):
      mm: mempolicy: fix automatic numa balancing for shmem
      mm: page_alloc: do not give all non-blocking requests reserve access

John Johansen (2):
      apparmor: fix refcount leak in aa_get_newest_profile()
      apparmor: on failed load ensure profile files are removed before parent

Jonas Karlman (1):
      drm/rockchip: dw_hdmi: Use resume_early pm ops for system suspend

Jonathan Gopel (1):
      thunderbolt: Do not RPM complete unrelated subtrees on unplug

Jonghyuk Kim(MalHyuk) (1):
      drm/msm: RCU-free the scheduler-containing ring and VM objects

Joonhoe Kim (1):
      drm/msm/dpu: compute the CRTC bandwidth from the state being checked

Jose Maria Casanova Crespo (1):
      drm/v3d: Initialize timedout_batches when running a CSD job

Jose Villaseñor Montfort (1):
      HID: input: read battery capacity from its actual report offset

Josef Bacik (39):
      driver core: Limit the messages on a refused uevent
      io_uring/io-wq: no new workers once the exit has begun
      aoe: pull in the headers each received packet type reads
      net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()
      mount: refuse setns() with a shared fs_struct again
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
      bpf: Validate the SRH which End.DT6 uncovers in End.BPF
      bpf: Pull the inner header for End.DT6 in End.BPF
      bpf: Update the SRH state if End.B6 fails late
      bpf: Bound the nesting that the BTF show code follows
      bpf: Don't take an extension for an iterator program
      bpf: Use the socket of a sk_lookup test run under RCU
      nvmet: don't truncate the length of big discards
      nvmet-auth: take only AUTH_Negotiate for a negotiation
      nvmet-tcp: stop listening when a port is removed
      nvmet-tcp: don't read a removed port at Connect time
      nvme-loop: don't BUG() if a scan runs beside a reset
      blk-throttle: don't truncate the cgroup v1 iops limits
      blk-cgroup: fix root io.stat byte counts on 32-bit
      block: fix use-after-free of the disk in sync_bdevs()
      block: don't lose the status of a failed flush request
      blk-mq: keep sharing tags fairly after a queue update
      blk-mq: don't bring back flags of a completed request
      blk-mq: don't forget a timer the driver has restarted
      block: partitions/mac: compute the sectors in 64 bits
      drbd: take req_lock to skip the initial sync as peer
      block/rnbd-srv: don't free the device on a sysfs error
      block/rnbd-srv: drop the sess_dev kobject unlocked

Joseph Qi (19):
      ocfs2/dlm: hold the lookup reference across convert AST enqueue
      ocfs2: exit recovery thread on mount error path
      ocfs2: free replay slots in ocfs2_recovery_exit()
      ocfs2: skip uninitialized lockres in ocfs2_mark_lockres_freeing()
      ocfs2: reserve metadata for a new xattr block and its value tree
      ocfs2: reserve value tree metadata when moving an xattr into the inode
      ocfs2: find the xattr entry again after defragmenting a bucket
      ocfs2: find the xattr entry again after converting a block to a bucket
      ocfs2: do not index before the entry array when dividing an empty bucket
      ocfs2: do not read the entry array of an empty xattr block
      ocfs2: restrict OCFS2_INVALID_SLOT suballoc slot to system inodes
      ocfs2: use the stored hash when checking xattr bucket collision
      ocfs2: do not read the entry array of an empty xattr bucket
      ocfs2: read the xattr entry hash before defragmenting the bucket
      ocfs2: fix deadlock in inline-data truncate transactions
      ocfs2: reject inconsistent xattr bucket during defrag
      ocfs2: retain all security xattrs during inode creation
      ocfs2: fix possible deadlock between nfs_sync_rwlock and fs_reclaim
      ocfs2: reserve xattr value tree metadata only once

Jouni Högander (1):
      drm/i915/psr: Clear selective fetch area when duplicating plane state

Ju Nan (1):
      irqchip/stm32mp-exti: Fix the unit of the hwspinlock timeout

Juan Perdomo (1):
      media: cx231xx: preserve I2C transfer length

Judith Mendez (3):
      arm64: dts: ti: k3-am62a7-sk: Set SD clock pin as OUTPUT
      arm64: dts: ti: k3-am625-sk-common: Set eMMC clock pin as OUTPUT
      arm64: dts: ti: k3-am62x-sk-common: Set SD clock pin as OUTPUT

Julian Anastasov (2):
      ipvs: fix buffer overflow when sending sync messages
      ipvs: fix more races around the overload flag

Julian Braha (2):
      media: marvell-cam: fix unmet dependency for VIDEO_MMP_CAMERA
      kconfig: fix extra output from savedefconfig on out-of-range defaults

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

Justin Chen (2):
      memory: brcmstb_dpfe: Fix out-of-bounds access due to DCPU offset
      memory: brcmstb_dpfe: Bounds check DCPU-supplied MSG_ARG_COUNT

Jérémy Jean (14):
      lib/crypto: arm64: Fix lost Poly1305 carry when resuming NEON state
      nfsd: preflight SEQUENCE replies before accepting a slot
      nvmet-auth: serialize access to DH-HMAC-CHAP state to fix UAF
      nvmet: free the bvec on file namespace range errors
      libceph: fix out-of-bounds reads from repeated CRUSH bucket entries
      SUNRPC: fix oversized GSS proxy token copy
      crypto: ecc - Handle exceptional points in Shamir multiplication
      ceph: fix 32-bit overflow in readdir reply count check
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

Kanishka De Silva (1):
      ublk: clear VM_MAYWRITE on read-only ublk char device mmap

Karl Asseily (1):
      dt-bindings: vendor-prefixes: add ESS Technology

Karl Mehltretter (41):
      smb: client: pin DFS superblock in iterator callback
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
      ARM: 9491/1: alignment: restore uaccess state on emulation fault
      irqchip/atmel-aic[5]: Disable interrupts in the irq_pm_shutdown() callbacks
      ARM: 9488/1: smp: set current pointer in assembly before jumping into C
      irqchip/gic-v3-its: Don't WARN on LPI free allocation failure
      virtio_ccw: fix synchronize_cbs() after interrupt fallback
      mtd: spinand: Fix spinand_manufacturer_ops kernel-doc
      power: supply: mp2629: Use the full batt_impedance_compensation name in the ABI document
      efi/libstub: Fix efi_set_event_at() parameter documentation
      firewire: cdev: Fix FW_CDEV_IOC_CREATE_ISO_CONTEXT references in kernel-doc
      spi: Fix the return value in spi_new_ancillary_device() kernel-doc
      ata: libata-scsi: Fix ata_scsi_hotplug() reference in kernel-doc
      gfs2: Fix the return value in gfs2_get_link() kernel-doc
      ALSA: control: Fix virtual master creation reference in kernel-doc
      regulator: qcom-rpmh: Fix the return value in rpmh_regulator_vrm_get_optimum_mode() kernel-doc
      wifi: mac80211: Fix the return value in mesh_path_add() kernel-doc
      loadpin: Fix stale KEXEC_VERIFY_SIG reference in documentation
      soc: ti: k3-ringacc: Correct ring API kernel-doc
      soc: ti: k3-ringacc: Fix DMA ring initialization kernel-doc
      time: Prevent time64_to_tm() day truncation on 32-bit
      OPP: Fix the return value in dev_pm_opp_get_of_node() kernel-doc
      crypto: atmel - handle authenc requests without plaintext
      floppy: flush pending work before releasing resources on init failure
      sh: sh7785lcr: Register the PCA9564 controller as I2C bus 0
      thermal: ti-soc-thermal: Fix the return value in ti_bandgap_get_sensor_data() kernel-doc
      ARM: 9492/1: alignment: fix LSR #32 and ASR #32 offset decoding
      rtc: class: Make the time32 hctosys limit configurable

Kazuki Hanai (1):
      media: mediatek: jpeg: Avoid context access after job finish

Kees Cook (2):
      overflow: Introduce overflows_type() and castable_to_type()
      kbuild: Mark the initcall ordering recipe as recursive

Kefeng Wang (1):
      mm: hugetlb: move hugeltb sysctls to its own file

Keisuke Tsukuda (2):
      usb: gadget: composite: avoid warning on aborted delayed status
      usb: gadget: f_mass_storage: ignore class requests while inactive

Keita Morisaki (1):
      drm/amd/display: Fix swap in median3() for DSC rate control

Keith Busch (2):
      nvme: tcp: split controller bringup handling
      nvme-fabrics: add queue setup helpers

Kemeng Shi (2):
      irqdomain: Plug leak in irq_domain_alloc_irqs_locked() error path
      irqchip/gic-v3-its: Fix its node leak in gic_acpi_parse_madt_its()

Kendall Willis (1):
      serial: 8250_omap: fix wake irq cleared during suspend

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

Konrad Dybcio (3):
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

Kryštof Černý (1):
      w1: ds2482: add OF device match table

Krzysztof Furman (1):
      Input: xpad - add support for Corsair Novablade Pro

Krzysztof Karas (1):
      iommu/dma: Catch scatterlist length overflows

Krzysztof Kozlowski (8):
      drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure
      drm/msm/hdmi_bridge: Correct poweroff/audio cleanup order in post_disable
      drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
      dt-bindings: vendor-prefixes: sort entries alphabetically
      drm/msm: Properly handle msm_ioremap() without name
      dt-bindings: display/msm: hdmi: Correct name of disallowed supplies
      ASoC: codecs: tlv320aic32x4: Fix Wvoid-pointer-to-enum-cast warning
      ASoC: samsung: Use snd_soc_substream_to_rtd() for accessing private_data

Krzysztof Wilczyński (4):
      PCI/sysfs: Pass the device name length in UTF-16 code units
      PCI/sysfs: Stop reporting _DSM failures as -EPERM
      PCI/sysfs: Handle a malformed _DSM result in acpi_attr_is_visible()
      PCI/sysfs: Decouple acpi_index from the optional device name element

Kuan-Wei Chiu (2):
      riscv, bpf: Add support for BPF_SDIV and BPF_SMOD in RV32 JIT
      riscv, bpf: Add support for BPF_MOVSX in RV32 JIT

Kunhai Dai (1):
      blk-iocost: abort weight transfer on invalid donation weights

Kuninori Morimoto (4):
      ASoC: codec: max98926: fixup invert setup mask
      media: platform: microchip: use for_each_endpoint_of_node()
      ASoC: soc-utils.c: add asoc_dummy_dlc
      ASoC: soc.h: convert asoc_xxx() to snd_soc_xxx()

Kuniyuki Iwashima (2):
      tcp: Fix potential UAF in reqsk_timer_handler().
      ipmr: Call ipmr_fib_lookup() under RCU.

Kunwu Chan (1):
      rcutorture: Fix divide-by-zero with fwd_progress_div=1

Kyle Zeng (12):
      udf: validate extent partition references in udf_current_aext()
      fs/ntfs3: reserve NUL byte when converting UTF-16 names
      io_uring/io-wq: save worker type before dropping its reference
      affs: validate blocks before freeing them
      netfilter: nf_reject: initialize IPCB at inet ingress
      tcp: fix reordering addition overflow in MTU probing
      net/sched: sch_qfq: prevent aggregate self-replacement
      mm/page_vma_mapped: continue past nonmatching huge PMDs
      net/packet: check TX_RING fragments before memory accounting
      mptcp: pm: kernel: use RCU to free endpoint listeners
      mm/khugepaged: flush deferred unmaps before dropping a failed folio
      gro: do not GRO GSO packets with inconsistent payload

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

Leo Li (1):
      drm/amd/display: Fix direct scanout alpha on some DRM_FORMATs

Leo Liu (1):
      drm/amdgpu: cancel idle work in hw_init failure paths for vcn/uvd/vce/jpeg

Leon Romanovsky (5):
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

Li RongQing (9):
      x86/ioperm: Prevent NULL dereference on theoretical missing IO bitmap
      RDMA/uverbs: Make CQ handle mandatory for WQ creation
      RDMA/restrack: Don't set RESTRACK_DD mark after a failed xa_insert()
      RDMA/uverbs: Drop restrack ref on ib_init_ucontext() failure in GET_CONTEXT
      RDMA/core: Fix partial copy of IPv6 flow_lbl in LAG hash skb
      RDMA/mlx5: Guard steering anchor resource destruction on create error
      RDMA/mlx5: Restore mr->pi_mr after temporary stack-local assignment
      IB/isert: Don't share drop_cmd_list across concurrent connection teardowns
      RDMA/mlx5: Fix CQ resize destination index mask

Li Youhong (1):
      md/raid5: drain released_stripes before destroying the cache

Li Zetao (1):
      btrfs: convert read_key_bytes() to take a folio

Li Zhe (2):
      mm/hugetlb: fix mremap deadlock when PMD sharing is possible
      mm/hugetlb: fix mremap move length truncation

Liang Hao (1):
      timers: Clear pending_map on CPU hotplug

Lijo Lazar (3):
      drm/amdgpu: Add checks to vbios fetch through ATRM
      drm/amdgpu: Validate ATIF buffer length before use
      drm/amd/pm: validate vega10 profile mode inputs

Lin, Meng-Bo (1):
      dt-bindings: vendor-prefixes: Add GPLUS

Linkai Gong (7):
      media: i2c: tc358743: add missing color-space strings
      drivers/base/node: fix UAF on device_register() failure
      firmware: imx: dsp: fix mailbox channel leak on kasprintf failure
      misc: enclosure: fix UAF on device_register() failure
      clk: imx: composite-93: return timeout from gate enable
      mailbox: arm_mhuv2: time out if the receiver never comes up
      char: scx200_gpio: check cdev_add() return value

Linmao Li (2):
      PCI: cadence: Store the core controller in platform drvdata
      power: supply: bq2515x: Propagate charge-enable read errors

Linus Torvalds (10):
      mm: move 'mmap_min_addr' logic from callers into vm_unmapped_area()
      assoc_array: don't lose objects when a shortcut is split on a word boundary
      assoc_array: don't lose objects when a root shortcut is split at level 4
      assoc_array: move in-place insertion into a function of its own
      assoc_array: fill the segment cache in one place
      assoc_array: move node splitting into a function of its own
      assoc_array: move shortcut creation into a function of its own
      assoc_array: choose between splitting a node and a shortcut without gotos
      assoc_array: don't chain a new shortcut onto an existing one
      assoc_array: keep gc's cleanup out of the live tree on allocation failure

Linus Walleij (23):
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

Longlong Xia (1):
      mm/hugetlb: do not dissolve gigantic pages without runtime support

Lorenzo Stoakes (ARM) (9):
      HID: picoLCD: check for fb_deferred_io_init() error
      fbdev: ssd1307fb: check for fb_deferred_io_init() error
      fbdev: xen-fbfront: check for fb_deferred_io_init() error
      fbdev: udlfb: check for fb_deferred_io_init() error
      fbdev: smscufx: check for fb_deferred_io_init() error
      fbdev: sh_mobile_lcdc: check for fb_deferred_io_init() error
      mm/mremap: correctly uncharge accountable VMAs in error path
      mm/vma: avoid broken uffd merge on mremap
      mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs

Lu Yao (1):
      drm/i915/gem: Reset err for each fence entry

Luca Leonardo Scorcia (1):
      clocksource/drivers/timer-mediatek: Fix random crash at boot

Lucas Costa (1):
      staging: sm750fb: free cmap on framebuffer release

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

Luiz Augusto von Dentz (4):
      Bluetooth: MGMT: Fix advertising instances with Global Advertising
      Bluetooth: HCI: Fix tracking of instances sharing handle 0x00
      Bluetooth: MGMT: Fix pending state of instances added without HCI traffic
      Bluetooth: MGMT: Fix leaking instance on Add Extended Advertising Parameters

Lukas Wunner (3):
      PCI/AER: Emit TLP Log only for unmasked errors
      driver core: Add device_show_string() helper for sysfs attributes
      platform/x86: Use device_show_string() helper for sysfs attributes

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

Magnus Lindholm (9):
      alpha: run check_mmu_context() from finish_arch_post_lock_switch()
      alpha: only use a targeted tbi() when the target mm is really current
      alpha: invalidate the local context in flush_tlb_page()
      alpha: fix the local TLB invalidate in flush_tlb_page()
      alpha: fix the local TLB invalidate in the UP flush_tlb_page()
      alpha: invalidate the local context in flush_tlb_mm()
      alpha: invalidate the local context in flush_icache_user_page()
      alpha: load the MMU context when switch_mm() switches the current task
      alpha: do not skip TLB shootdown IPIs for kthread-borrowed mms

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

Marc Zyngier (5):
      KVM: arm64: Move OUTSIDE_GUEST_MODE publication past context being saved
      KVM: arm64: Turn vcpu->arch.pause into a counter
      KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded
      irqchip/gic-v3-its: Split allocation from initialisation of its_node
      irqchip/gic-v3-its: Restore quirk probing for ACPI-based systems

Marco Chen (1):
      iio: health: max30102: fix NULL dereference in interrupt handler

Marco Crivellari (1):
      regulator: irq_helper: replace use of system_wq with system_dfl_wq

Marco Scardovi (1):
      platform/x86: asus-wmi: Serialize WMI method evaluations with a mutex

Marco Ziliani (1):
      ata: libata-pmp: disable the SEMB port on Marvell 88SM9705

Marek Czernohous (1):
      drm/nouveau/pci: use config-space MSI rearm on MCP79/MCP7A (NVAC)

Marek Szyprowski (7):
      mmc: dw_mmc: stop and complete DMA also in STATE_DATA_BUSY state
      ARM: 9519/1: dma-mapping: Fix wrong free function in __iommu_alloc_simple() error path
      ASoC: wm8994: fix MCLK gating for AIF clocks sourced from MCLK2
      ASoC: wm8994: don't lose the AIF clock ratio when staying at 32kHz SYSCLK
      ASoC: wm8994: fix MCLK index used for setting MCLK rate
      ASoC: samsung: midas_wm1811: run FLL1 at the AIF1 configured rate when idle
      ASoC: wm8994: follow AIF clock source changes in MCLK gating

Marek Vasut (3):
      drm: of: Fix drm_of_get_data_lanes_count_ep() return value documentation
      ARM: dts: stm32: Drop bias-disable from STM32MP15xx DHCOM SoM sdmmc1_b4_pins_a
      dt-bindings: vendor-prefixes: Add Retronix Technology Inc.

Mario Limonciello (2):
      drm/amd/display: don't WARN when removing an unallocated MST payload
      platform/x86/amd/pmf: Add AMDI0112 ACPI ID

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

Markus Theil (1):
      crypto: jitter - fix intermediary handling

Martin Belanger (1):
      nvme: make the DH-HMAC-CHAP secret attributes readable by root only

Martin Wilck (2):
      md/raid5: validate payload size before calculating payload_len
      nvme-auth: use chap->s2 to indicate bidirectional authentication

Masafumi Suzuki (1):
      sctp: account for chunk padding in sctp_init_cause()

Masahiro Yamada (3):
      kconfig: remove unneeded symbol_empty variable
      kconfig: default to zero if int/hex symbol lacks default property
      kconfig: initialize sym->curr.tri to 'no' for all symbol types again

Masami Hiramatsu (Google) (4):
      tools/bootconfig: Fix integer overflow and truncation in size checks
      bootconfig: Fix integer overflow in initrd size check
      x86/mce: Fix hardware debug register corruption on task migration
      tracing: docs: Update histogram doc for .percent/.graph and 'nohitcount'

Matheus Alves de Almeida (2):
      fat: hold truncate_lock in fat_write_failed()
      HID: wacom: fix wacom_intuos_irq NULL pen_input deref

Matt Turner (3):
      alpha: run the remote RTC access in a worker, not an IPI callback
      lib/decompress_bunzip2: fix off-by-one in run-length bounds check
      alpha: determine tininess after rounding in the FP emulation

Matthew Jacob (1):
      drm/amdgpu: Support some Barco AMD based graphics adapters

Matthew Wilcox (Oracle) (4):
      ntfs3: Convert attr_wof_frame_info() to use a folio
      ntfs3: Remove calls to set/clear the error flag
      ntfs: Do not kmap page cache pages for compression
      btrfs: convert btrfs_read_merkle_tree_page() to use a folio

Matthias Goergens (6):
      fanotify: report names longer than NAME_MAX
      udf: don't let the extent type hide an exhausted free-space table extent
      udf: fix preallocation discarding before an empty allocation extent
      udf: don't use eloc after the end of the unallocated space table
      x86/hibernate: Ignore page-zero RAM in E820 checksum
      isofs: return long Joliet names whole

Matthieu Baerts (NGI0) (2):
      mptcp: options: mpc: avoid printing uninit data
      mptcp: options: dss: avoid printing uninit csum

Matus Gajdos (1):
      ALSA: usb-audio: Add native DSD support for Cambridge Audio streamers

Mauricio Orozco (1):
      ALSA: hda/realtek: Add quirk for ASUS VivoBook M515DA/X515DAP

Maurizio Casciano (1):
      power: supply: core: Honor supplied-from with CONFIG_OF=y

Maurizio Lombardi (1):
      nvme-fc: do not warn on controller removal race

Max Kellermann (4):
      jbd2: check need_resched() when skipping busy checkpoint buffers
      jbd2: bound shrinker scans by examined checkpoint buffers
      ceph: avoid pending truncate during nonblocking cap acquire
      ceph: remove unused field `i_cap_migration_resv`

Maxim Skokov (2):
      media: vivid: round the height down to the vertical subsampling factor
      bpf: test_run: Fix false -EBADMSG after skb leaves CHECKSUM_COMPLETE

Maxime Bélair (1):
      apparmor: report a label allocation failure as -ENOMEM

Maxime Ripard (1):
      ASoC: tlv320aic32x4: div: Switch to determine_rate

Maíra Canal (1):
      drm/vc4: Publish the output fence outside of job_lock

Md Rabbani (1):
      net: stmmac: fix device node reference leaks in stmmac_mtl_setup()

Melissa Wen (3):
      drm/amd/display: assign missing trace entry in amdgpu_dm_dc_clocks_state
      drm/amd/display: remove duplicated prev_p_state_change_support assignment
      drm/amd/display: use right type for amdgpu_dc_performance event entries

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

Michael Wu (1):
      mmc: mmc-hsq: Use fifo to dispatch mmc_request

Michael Wyraz (1):
      USB: serial: option: add support for ASR 1286:4e3c modem

Michail Andreas Michalopoulos (3):
      ksmbd: accept share config responses from ksmbd-tools before 3.5.3
      ksmbd: reject FILE_ATTRIBUTE_TEMPORARY on directories
      ksmbd: select CRYPTO_AES

Michail Tatas (2):
      USB: misc: uss720: Fix leak in get_1284_register
      ipmi: Fix leak in __ipmi_bmc_register

Michal Pecio (2):
      ALSA: usx2y: Stop clearing urb->hcpriv before submission
      usb: xhci: Fix bounce buffer overflow

Mike Christie (2):
      scsi: target: Move I/O path stats to per CPU
      scsi: target: Fix LUN/device R/W and total command stats

Mikhail Lobanov (1):
      wifi: ath11k: modify null check logic in ath11k_ce_rx_post_pipe()

Mikko Perttunen (4):
      gpu: host1x: Wait for timeout worker completion on channel free
      drm/tegra: Fix syncobj_in wait return value check
      drm/tegra: Don't pass an ERR_PTR to drm_syncobj_replace_fence()
      drm/tegra: Drop reference on postfence

Mikulas Patocka (9):
      dm-integrity: fix NULL pointer dereference when the 'R' flag is used
      dm-integrity: validate the superblock on resume
      dm: fix a bug in dm_accept_partial_bio
      dm-writecache: report I/O error if flush failed
      dm-writecache: fix a quirk in statistics
      dm-writecache: fix a crash if we attempt to use non-dax device
      dm-writecache: fix uncommitted_blocks underflow
      dm-writecache: fix REQ_FUA processing
      dm-snapshot: fix crash if dm_io_client_create fails

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

Miquel Raynal (1):
      spi: cadence-qspi: Fix status polling with octal DTR chips

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

Mohit Sharma (1):
      ASoC: qcom: q6apm: Guard callbacks until probe data is ready

Muchun Song (2):
      block: remove redundant explicit memory barrier from rq_qos waiter and waker
      block: introduce init_wait_func()

Muhammad Bilal (1):
      platform/x86: hp-wmi: fix heap OOB read and memory corruption in hp_wmi_perform_query()

Muhammad Saheed (1):
      Bluetooth: hci_sync: Disable legacy instance's ext adv before setup snapshot

Mukesh Ojha (2):
      iommu/qcom: Check pm_runtime_resume_and_get() return in probe
      iommu/qcom: Publish pgtbl_ops before releasing init_mutex

Muzaffer Kadir (1):
      dt-bindings: vendor-prefixes: Add General Mobile

Myeonghun Pak (30):
      media: cx88: Disable PCI device on MPEG initialization failure
      nvme-pci: disable controller on admin queue IRQ setup failure
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

Namjae Jeon (17):
      ksmbd: wait for negotiation before receiving another PDU
      ksmbd: protect private extended attributes
      ksmbd: preserve access denied status for copychunk
      ksmbd: allow I/O on directory named streams
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

Nanzhe Zhao (1):
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

Neil Chen (2):
      wifi: mt76: mt7921: fix rx filter incorrect by drv/fw inconsistent
      wifi: mt76: mt7921: use driver flags rather than mac80211 flags to mcu

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

Nickolai Zeldovich (7):
      resource: report a devm_request_resource() conflict under the lock
      ucount: take the rlimit reference before checking the limit
      mm/mlock: use a long for the page count in mlock_fixup()
      nsproxy: Fix cred leak in the error path of prepare_nsset()
      splice: retry tee() instead of returning 0 when it races
      ucount: read the parent ucounts before dropping the rlimit count
      fs_pin: do not trust the pin after a spurious wakeup in pin_kill()

Nicolai Buchwitz (7):
      serial: amba-pl011: keep transmitter enabled when disabling RS485
      net: selftests: use skb_share_check() in the loopback receive hook
      net: stmmac: selftests: use skb_share_check() in the loopback receive hook
      net/mlx5e: use skb_share_check() in the loopback selftest hook
      net: usb: cdc_ncm: don't enable BHs in tx_fixup under netpoll
      net: usb: cdc_mbim: don't enable BHs in tx_fixup under netpoll
      net: bcmgenet: restore the Tx coalescing setting when the rings are rebuilt

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

Nuno Sa (1):
      iio: core: add accessors 'masklength'

Nícolas F. R. A. Prado via Alsa-devel (1):
      ASoC: mt8192: Remove function name log messages

OGAWA Hirofumi (1):
      fat: fix fat_ent_write() for reverting the value

Oleg Keri (1):
      drm/msm/dp: don't report link training success after a reinit

Oleg Nesterov (1):
      signalfd: don't dequeue the forced fatal signals

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

Pablo Neira Ayuso (3):
      netfilter: nf_tables: call skb_valid_dst() before skb_dst()
      netfilter: nf_conntrack_expect: add and use nf_ct_expect_related_pair()
      netfilter: conntrack: always lower timeout for non-closing RST packets

Palla Raghunath (1):
      nvmet-fc: don't drop the last assoc reference in nvmet_fc_delete_ctrl()

Paolo Abeni (1):
      mptcp: fix subflow bitfield misuse

Parker Newman (2):
      serial: exar: add optional board_init function
      serial: exar: fix checkpach warnings

Patrick Oppenlander (1):
      rpmsg: virtio: EPOLLOUT support

Paul Dolan (1):
      selftests/clone3: tighten CLONE_CLEAR_SIGHAND conflict test

Paul E. McKenney (1):
      sh: Emulate one-byte cmpxchg

Paul Moses (2):
      perf mmap: Use the head selected by read_init
      perf mmap: Preserve the consumed cursor in forward mode

Pauli Virtanen (2):
      ALSA: usb-audio: add volume quirks for MS LifeChat LX-3000
      Bluetooth: L2CAP: hold chan in l2cap_ecred_conn_rsp()

Paulo Alcantara (9):
      smb: client: cancel reconnect work in clean_demultiplex_info()
      smb: client: fix rlist race and missing initialization
      smb: client: discard post-EOF pagecache when extending a file via clone range
      smb: client: flush and commit data before querying allocated ranges
      smb: client: flush dirty data before zeroing a range
      smb: client: drain and invalidate before server-side copy/clone
      smb: client: only require read lease for size-extending zero range
      smb: client: fix warning in CIFSFindFirst()
      smb: client: fix warning in CIFSFindNext()

Pavel Zverev (1):
      Bluetooth: btusb: Add support for 1357:c123 Realtek 8852BE device

Pawel Laszczak (1):
      usb: cdnsp: fix wakeup from S3 after controller context loss

Pedro Falcato (1):
      mm/madvise: atomically clear the young bit on THP MADV_COLD

Pei Xiao (6):
      ipack: ipoctal: add rwsem to guard against TOCTOU in remove path
      media: cx23885: Fix use-after-free in cx23885_finidev due to race condition
      tpm: tpm_nsc: fix NULL pointer dereference on init failure
      tpm: tpm_nsc: stop using the cleanup callback as dev.release
      tpm: fix zero-length read discarding the pending response
      comedi: dt2811: fix shift-out-of-bounds in IRQ check

Peijie Shao (1):
      nvme-tcp: fix selinux denied when calling sock_sendmsg

Peng Fan (2):
      remoteproc: imx_dsp_rproc: Drop extra space
      PM: sleep: wakeirq: Introduce device-managed variant of dev_pm_set_wake_irq()

Pengfei Zhang (1):
      net: stmmac: xgmac: do not treat TBU as a TX event

Pengjie Zhang (1):
      ACPI: PCC: Fix race condition by removing static qualifier

Pengpeng Hou (54):
      media: cec: stm32: return an error when log-address wait times out
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
      media: require two-byte Cypress type 04 records
      spi: sh-msiof: propagate setup runtime-PM errors
      remoteproc: imx_dsp: Acquire runtime PM before adding carveouts
      memory: brcmstb_dpfe: validate firmware section sizes
      usb: musb: da8xx: depopulate OF children on remove
      usb: musb: da8xx: depopulate OF children on probe failure
      clk: milbeaut: Return divider update timeouts
      pmdomain: imx: Propagate SCU provider registration failures
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

Peter Griffin (1):
      opp: fix use after free in _update_opp_table_clk()

Peter Ujfalusi (10):
      ALSA: compress: add missing OPEN-state gate to SET_METADATA
      ALSA: hda: Reject codec reset on ASoC (ext_ops) buses
      ASoC: hdac_hda: Balance the runtime PM disable in codec remove
      ASoC: hdac_hda: Keep runtime PM state in sync across codec remove/probe
      ALSA: x86: hdmi: fix chmap array missing terminator entry
      ALSA: hda/hdmi: clamp sad_count in ELD proc write handler
      ALSA: hda/hdmi: clamp num_cvts against cvt_nids[] in hdmi_read_pin_conn
      ASoC: hdac_hda: Allocate the private data at codec driver bind
      ASoC: hdac_hda: Restore the codec device type on unbind
      ALSA: compress: fix buffer leak on failed SET_PARAMS

Peter Zijlstra (1):
      cleanup: Add conditional guard support

Petr Tesarik (1):
      net: stmmac: protect updates of 64-bit statistics counters

Petr Vorel (1):
      checkpatch: skip CamelCase cache for --no-tree without root

Pierre-Louis Bossart (10):
      ASoC: SOF: Intel: remove option to disable the common_hdmi handling
      ASoC: SOF: Intel: remove all dependencies on SND_SOC_HDAC_HDMI
      ASoC: SOF: Intel: hda-codec: simplify SND_SOC_SOF_HDA_AUDIO_CODEC handling
      soundwire: intel: start using hw_ops
      soundwire: intel: add debugfs callbacks in hw_ops
      soundwire: intel: add register_dai callback in hw_ops
      soundwire: intel: add bus management callbacks in hw_ops
      soundwire: intel: add link power management callbacks in hw_ops
      soundwire: intel: add in-band wake callbacks in hw_ops
      soundwire: intel: split auxdevice to different file

Ping Cheng (2):
      HID: wacom: Setup SW_MUTE_DEVICE according to the order of input registration
      HID: wacom: Write shared touch initial status only once

Piotr Gliźniewicz (1):
      ALSA: 6fire: take stream_mutex in the Digital Thru control

Piotr Kubik (1):
      netfilter: ctnetlink: fix inverted IPv6 address match in dump filter

Piyush Patle (1):
      media: vidtv: fix frontend reference leak on unbind

Pranjal Shrivastava (1):
      PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs

Prashant Malani (2):
      platform/chrome: cros_ec_typec: Stash port driver info
      platform/chrome: cros_ec_typec: Move structs to header

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

Priyank Rathod (1):
      PCI/AER: Fix struct pci_dev reference leak in aer_process_err_devices()

Pufan Jin (1):
      spi: zynq-qspi: fix address buffer corruption and support 4-byte address

Punnay Sharma (2):
      staging: media: av7110: fix corrupted BER reporting in sp8870
      staging: media: av7110: fix sp8870 initialization failure state

Qi Xi (1):
      mm/page_isolation: fix UBSAN shift-out-of-bounds warning

Qihang (1):
      xfrm: interface: validate the IP header on xmit

Qiliang Yuan (3):
      selftests/bpf: Create the vxlan devices of test_tunnel with their MAC
      selftests/bpf: Keep the bpffs of cgroup_hierarchical_stats private
      selftests/bpf: Unmount the bpffs that cgroup_hierarchical_stats mounted

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

Qu Wenruo (3):
      btrfs: do not overwrite NODATASUM flag when removing NODATACOW flag
      btrfs: refactor read_key_bytes() to remove the dest_folio parameter
      btrfs: qgroup: do not treat "ret > 0" as error when deleting a qgroup

Quanye Yang (4):
      mptcp: reset msk state on early connect failure
      RDMA/rtrs-clt: Reject invalid queue_depth from the peer
      RDMA/rtrs-clt: Don't WARN on unexpected info-response opcode
      RDMA/rtrs-clt: Validate peer-supplied IO completion msg_id

Radhey Shyam Pandey (1):
      dmaengine: xilinx_dma: Freeup active list based on descriptor completion bit

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

Ranjan Kumar (3):
      scsi: mpi3mr: Successive VD delete and add causes FW fault
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

Ricardo Ribalda (3):
      media: uvcvideo: Disable autosuspend for Insta360 Link
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

Rishikesh Jethwani (1):
      tls: device: protect async RX resync state during device-down

Rituparna Warwatkar (1):
      media: dvb-core: fix feed leak on failed DMX_ADD_PID

Rob Barnes (1):
      platform/chrome: cros_ec_proto: Fix deferred response

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

Rodrigo Gobbi (1):
      staging: rtl8723bs: change remaining printk to proper api

Rohinthan P (2):
      media: em28xx: use video_unregister_device for radio_dev
      media: v4l2-ctrls: do nothing if controls[0] == NULL in cluster functions

Rongzheng Wang (1):
      nvmet: use the enabled transport when disabling a port

Rosen Penev (22):
      gpio: mvebu: keep resume masks within the irqchip cache
      wifi: ath9k: delete channel-context timers on deinit
      mtd: rawnand: ndfc: use ioread32be/iowrite32be and allow COMPILE_TEST
      mtd: rawnand: ndfc: fix gcc uninitialized var
      mtd: rawnand: ndfc: use devm_platform_ioremap_resource()
      net: bgmac: enable interrupts only after NAPI is ready
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
      crypto: talitos - allocate channels with main struct
      crypto: talitos - use devm_platform_ioremap_resource()
      crypto: talitos - Use platform_get_irq() to retrieve interrupt
      crypto: talitos - init tasklets before requesting IRQs
      net: bgmac: fix TX DMA unmapping and slot cleanup

Ross Lagerwall (1):
      xen-blkfront: Fix IO race during unplug

Rounak Das (1):
      EDAC/altera: Use ECC manager compatible to select A10/S10 IRQ layout

Rui Qi (1):
      selftests/ftrace: Force C locale in ftracetest

Ruide Cao (2):
      mptcp: hold MP_JOIN msk ref when cloning reqsk
      mptcp: fix MP_CAPABLE token migration when cloning reqsk

Runyu Xiao (23):
      iio: admv1013: initialize callback mutex before registering notifier
      net: macb: initialize PTP state before registering clock
      Input: hp_sdc - shut down kicker timer on module exit
      hte: tegra194: Initialize slice locks before registering chip
      media: saa7146: Initialize interrupt lock before requesting IRQ
      dmaengine: altera-msgdma: initialize state before requesting IRQ
      PCI: pciehp: Make 'pciehp_poll_mode' parameter read-only
      media: adv7180: Initialize mutex before ancillary clients
      peci: aspeed: Initialize state before requesting IRQ
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

Ryan Leung (1):
      wifi: mt76: fix unlocked wcid check in mt76_tx_status_skb_add()

Ryder Lee (2):
      wifi: mt76: mt7915: improve accuracy of time_busy calculation
      wifi: mt76: mt7915: add ack signal support

Ryusuke Konishi (4):
      nilfs2: fix deadlock between nilfs_evict_inode() and find_inode()
      nilfs2: correct return value kernel-doc descriptions for the rest
      nilfs2: ignore non-fatal signals during synchronous log write wait
      nilfs2: fix link count underflow when removing corrupted directory

SJ Park (6):
      mm/damon/sysfs: put target pids for damon_start() failure
      mm/damon/sysfs: put target pids for apply_inputs() failure
      mm/damon/vaddr: avoid hw-driven pte updates during damon_hugetlb_mkold()
      mm/damon/core: skip applying scheme if region split for quota fails
      mm/damon/core: remove unreachable damos charge_{target,addr}_from
      mm/damon/core: move static variable last_nr_regions to damon_ctx

Sabrina Dubroca (7):
      xfrm: espintcp: reorder operations within espintcp_init_sk
      tls: move tls_cipher_size_desc to net/tls/tls.h
      tls: add TLS_CIPHER_ARIA_GCM_* to tls_cipher_size_desc
      tls: reduce size of tls_cipher_size_desc
      tls: rename tls_cipher_size_desc to tls_cipher_desc
      tls: extend tls_cipher_desc to fully describe the ciphers
      tls: get crypto_info size from tls_cipher_desc in do_tls_setsockopt_conf

Sagi Grimberg (2):
      nvme-auth: check chap ctrl_key once constructed
      blk-mq-rdma: remove queue mapping helper for rdma devices

Sagi Maimon (2):
      net: axienet: free outstanding TX buffers in axienet_dma_bd_release()
      net: axienet: release every RX buffer in axienet_dma_bd_release()

Sahaj Chaudhari (3):
      gpio: davinci: Clear interrupt status in every bank on suspend
      gpio: pca953x: Preserve wakeup accounting on parent IRQ failure
      gpio: pca953x: Handle direction register read errors in IRQ paths

Sakari Ailus (2):
      platform/x86: int3472: Fix uninitialised variable warning
      media: davinci: Init async notifier after registering V4L2 device

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

Sarthak Sharma (2):
      mm/gup_test: safely calculate GUP batch size
      mm/gup_test: report actual pinned bytes

Sasha Levin (6):
      Revert "interconnect: Don't access req_list while it's being manipulated"
      Revert "interconnect: Fix locking for runpm vs reclaim"
      cgroup: don't kill migrated processes through their exiting threads
      kselftest/arm64: signal: copy each test binary only once
      selftests: keep the build status from wrapping to success
      ARC: Strip libgcc debug information when generating BTF

Scott Gauche (1):
      ALSA: hda/realtek: Fix audio after Windows reboot on ASUS Q423SA

Sean Christopherson (20):
      KVM: nVMX: Decouple INVVPID operand checks from flushing of vpid02
      KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails
      KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages() error paths
      KVM: SVM: Preserve TLB control (i.e. pending TLB flush) on failed VMRUN
      KVM: SVM: Update control fields on #VMEXIT if and only if VMRUN succeeded
      KVM: nVMX: Force MSR bitmap refresh if runtime eVMCS controls are modified
      KVM: Use goto to handle errors during memslot preparation
      KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with EFER.LMA=1 && CR4.PAE=0
      KVM: x86: Preserve DR6.BLD (Bus Lock Detect) when delivering #DB payload
      KVM: x86: Zero reserved synic flags when delivering message to avoid stack leak
      KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1 && EFER.LME=0
      KVM: x86/mmu: Conditionally resched when retrying gPTE walk on A/D update failure
      KVM: x86: Conditionally resched when restarting REP string emulation
      KVM: nVMX: Process each host MSR entry at most once when unwinding failed VM-Entry
      KVM: x86/mmu: Cap number of parent PTEs per SP at 1000 (the arbitrary rmap limit)
      KVM: x86: Unconditionally reset MMU context when emulating INIT
      KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when preparing L2 state
      KVM: x86/mmu: Bug the VM if a vCPU ends up in long mode without PAE enabled
      KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the MMU has
      KVM: nSVM: Check validity of vmcs01 save area copied from SMRAM on RSM

Sean Young (11):
      media: rc: mce_kbd: Fix inconsistent locking of keylock
      media: rc: Fix ABBA deadlock by making locks more fine grained
      media: redrat3: Ensure we don't read beyond the end of the packet
      media: redrat3: Ensure all urbs are suspended
      media: meson-ir-tx: Ensure clock is disabled on unbind
      media: meson-ir-tx: Ensure probe error is propagated
      media: ir-hix5hd2: Ensure rdev is setup before interrupts are enabled
      media: ir_toy: Validate the maximum tx carrier
      media: meson-ir-tx: Prevent divide by zero in meson_irtx_prepare_pulse()
      media: redrat3: Error path leaves device in transmitting state
      media: serial_ir: Fix race condition where timer can be re-armed

Sebastian Reichel (1):
      power: supply: generic-adc-battery: convert to managed resources

Seiji Adachi (1):
      ASoC: amd: yc: Add Lenovo ThinkPad E16 Gen 2 (21JN) to quirks

Selvin Xavier (4):
      RDMA/bnxt_re: Fix integer overflow in send payload size computation
      RDMA/bnxt_re: Detect wrong sge_len passed for inline
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

Sergey Temerkhanov (1):
      ice: Use more generic names for ice_ptp_tx fields

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

Shakeel Butt (2):
      memcg: bypass the reclaim and oom killer for dying tasks once oom_reaper is done
      memcg: make the v1 soft limit knob inert

Shang En Sim (1):
      io_uring/poll: cancel all matching requests in one pass

Shao Mingyin (3):
      nvmet-auth: fix error handling on CHALLENGE failure
      scsi: target: tcmu: Fix divide-by-zero in data_pages_per_blk store
      nvmet: bound the traddr and trsvcid configfs writes

Sharath Srinivasan (1):
      net/rds: fix rds_message leak in the rds_send_xmit() drop path

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

Shuai Liu (1):
      io_uring/sqpoll: don't set IO_SQ_THREAD_SHOULD_STOP on thread exit

Shuangfeng He (1):
      netfilter: flowtable: use the vlan id, not the full tci, in the tuple key

Shuangpeng Bai (1):
      media: gspca: use vb2_video_unregister_device() on disconnect

Shubham Antil (1):
      RDS/IB: validate receive fragment completions

Shuhei Takeshita (2):
      IB/hfi1: Resolve the credit-return buffer through the send context's node
      IB/hfi1: Fix the PIO_CRED credit-return mmap

Shuvam Pandey (1):
      lib/tests: extend cmdline KUnit with next_arg() tests

Siddharth Chintamaneni (1):
      smb: client: fix busy dentry warning on unmount after DIO

Sidhartha Kumar (2):
      mm/hugetlb_cgroup: convert set_hugetlb_cgroup*() to folios
      mm/hugetlb_cgroup: convert hugetlb_cgroup_migrate to folios

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

Slavin Liu (4):
      ACPI: tables: handle failed initrd override mappings
      crypto: atmel-sha - reject initialization without a device
      ASoC: fsl_asrc: check the second front-end DMA channel
      clocksource/drivers/dbx500-prcmu: Check timer register mapping

Somnath Kotur (2):
      bnxt_en: Change bnxt_rx_xdp function prototype
      bnxt_en: Add XDP Metadata support

Sorah Fukumori (1):
      net: gro: don't chain linear parts larger than gso_size into frag_list

Srinivas Kandagatla (2):
      ASoC: qcom: audioreach: fix ADSP ready check
      ASoC: codecs: wsa883x: disable runtime PM on unbind

Srinivas Neeli (2):
      dmaengine: xilinx_dma: Fix MCDMA descriptor fields based on DMA direction
      dmaengine: xilinx_dma: Move descriptors to done list based on completion bit

Srinivasa Rao Mandadapu (1):
      ASoC: qdsp6: audioreach: Add ADSP ready check

Srinivasan Shanmugam (1):
      drm/amdgpu/powerplay: Align get_tonga_state_array() header with prototype

Srish Srinivasan (2):
      pseries/plpks: clear sensitive PLPKS buffers
      pseries/plpks: fix error handling in plpks_read_var()

Stanislaw Gruszka (1):
      wifi: mac80211: queue frames while off-channel

Stanley Jhu (5):
      scsi: ufs: bsg: Clear the reply buffer before use
      scsi: ufs: core: Clear stale UIC result byte before peer DME retries
      scsi: ufs: core: Remove an always-false WARN_ONCE()
      scsi: ufs: core: Add a helper for clearing hba->outstanding_reqs
      scsi: ufs: bsg: Reject UIC commands with a non-zero result byte

Stefan Haberland (1):
      s390/dasd: Snapshot intrc before freeing the request block

Stefan Metzmacher (1):
      smb: smbdirect: fix buffer length underflow in RDMA transfers

Stefano Munari (1):
      net: usb: lan78xx: reject invalid EEPROM write requests

Stephen Rothwell (1):
      sprintf.h requires stdarg.h

Steven Price (2):
      irqchip/gic-v3-its: Share ITS tables with a non-trusted hypervisor
      irqchip/gic-v3-its: Fix over allocation in itt_alloc_pool()

Steven Rostedt (2):
      tracing: Take trace_array reference when opening a tracer options file
      cpuidle: haltpoll: Only define guest_halt_poll_ns tracepoint when used

Steven Rostedt (Google) (1):
      tracing/histogram: Document variable stacktrace

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

Sunday Clement (1):
      drm/amdkfd: Reject zero-sized AQL queue allocations after size halving

Sung Byeongchan (3):
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

TJ Adams (1):
      block: advance iterator after copy-in for SG_DXFER_TO_FROM_DEV

Takashi Iwai (38):
      ALSA: hda/intel: Add sanity check for BAR0 size
      ALSA: core: Use guard() for locking
      ALSA: core: Fix potential UAF after asynchronous card release
      ALSA: core: Check shutdown flag at D0 power-state, too
      ALSA: seq: oss: Skip events until fully initialized
      ALSA: usb-audio: Don't try to submit URBs after disconnection
      ALSA: control: Fix UAF in snd_ctl_elem_add() on card disconnect
      ALSA: line6: Handle period elapsed calls outside the locks
      ALSA: emux: Use standard print API
      ALSA: synth: Use guard() for spin locks
      ALSA: emux: Fix UAF of soundfont zones at note-on
      ALSA: emux: Stop voices before freeing zones in all cases
      ALSA: aloop: Use guard() for mutex locks
      ALSA: pcm: Optimize cpu_latency_qos_*() calls
      ALSA: pcm: Prevent O_APPEND open on OSS streams
      ALSA: oxygen: Use guard() for mutex locks
      ALSA: caiaq: Allow zero-length packet handling for EP1
      ALSA: hda: Fix potential UAF for gating jack
      ALSA: usb-audio: Check mixer matrix size for UAC2/3 at parsing
      ALSA: usb-audio: Fix invalid UAC2/3 mixer unit matrix evaluation
      ALSA: core: Remove superfluous CONFIG_PM
      ALSA: core: Add missing barriers for power_ref vs card->shutdown
      ALSA: info: Use guard() for locking
      ALSA: info: Fix memory leak at card removal
      ALSA: hda: Avoid non-operational GPU warning at regular device removal
      ALSA: caiaq: Fix races at MIDI URB and trigger accesses
      ALSA: line6: Reject too small max packet sizes
      ALSA: line6: Fix potential OOB write in line6_capture_copy()
      ALSA: hda: intel: Cancel delayed work at shutdown, too
      ALSA: hda: Add NULL check for the driver pointer at unsol event work
      ALSA: control: Take controls_rwsem lock in snd_ctl_remove()
      ALSA: jack: Fix kctl free at error in snd_jack_kctl_new()
      ALSA: line6: Use kzalloc() for PCM buffer allocation
      ALSA: usb-audio: Use fixed control index for us16x08 mixer elements
      ALSA: Add simple refcount helper functions
      ALSA: pcm: Add refcount for races between drain and unlink
      ALSA: core: Serialize snd_refcount put and sync
      platform/x86: ibm_rtl: Fix potential OOB read at signature search

Takashi Sakamoto (1):
      firewire: core: remove unused link field in fw_packet structure

Tal Zussman (2):
      vhost-vdpa: fix pinned page leak in vhost_vdpa_pa_map() error path
      block: honor IOCB_NOWAIT in the block device buffered read path

Tanmay Shah (1):
      remoteproc: core: Full attach detach during recovery

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

Theodore Ts'o (1):
      ext4: avoid updating the superblock on a r/o mount if not needed

Thiébaud Weksteen (1):
      module: validate string table section types

Thomas Falcon (1):
      perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()

Thomas Fourier (1):
      net: alacritech: fix dma_free_coherent() in error path

Thomas Gleixner (1):
      futex: Sanitize and document task_struct::futex::state transitions

Thomas Huth (1):
      smb: server: Free session data in user_session.c with kfree_sensitive()

Thomas Weißschuh (3):
      microblaze: uaccess: Zero out destination on failed get_user()
      microblaze: Pass -m{big,little}-endian through KBUILD_CPPFLAGS
      nios2: ksyms: Declare __mulsi3 export

Thomas Weißschuh (Schneider Electric) (1):
      timekeeping: Update offsets on sequence counter retry in ktime_get_update_offsets_now()

Thomas Zimmermann (1):
      drm/sysfb: simpledrm: Improve framebuffer-size validation

Thorsten Blum (13):
      crypto: atmel-ecc - avoid stale fallback key after set_secret failure
      platform/x86: think-lmi: Fix certificate thumbprint sysfs output
      platform/x86: think-lmi: Fix current password length check
      thermal: intel: powerclamp: Reject invalid window_size values
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

Til Kaiser (1):
      mlxsw: Initialize register query payloads

Tim Douglas (3):
      serial: pmac_zilog: push received data to the port that received it
      power: supply: generic-adc-battery: fix status with no supplier
      serial: pmac_zilog: report received breaks

Tim Menninger (1):
      xprtrdma: prevent disconnect feedback during endpoint teardown

Timur Kristóf (1):
      drm/amdgpu/uvd3.1: Fix checking whether UVD firmware keyselect was already set

Ting-Han Hou (2):
      checkkconfigsymbols.py: Parse Git status output line by line
      clang-tools: Import os for broken pipe handling

Tingjie Zhong (1):
      fbdev: bitblit: Fix glyph clipping when fbcon pans

Tobias Schumacher (1):
      s390/pci: Add error cleanup in zpci_directed_irq_init()

Tom Verdonck (2):
      hwmon: (tmp102) Fix jiffies wraparound in conversion-ready check
      hwmon: (tmp108) Fix jiffies wraparound in conversion-ready check

Tom Zanussi (1):
      tracing: Fix fully-qualified variable reference printing in histograms

Tomasz Bojanowski (1):
      ALSA: usb-audio: Add mixer mapping for MSI MAG B850M MORTAR WIFI

Trevor Wu (1):
      ASoC: mediatek: mt8195: add dai id check before accessing array

Triet Hoang (1):
      clk: raspberrypi: Handle cpufreq device registration failure

Tristan Madani (2):
      ALSA: usbusx2y: validate URB actual_length in interrupt callback
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

Uros Bizjak (1):
      cleanup: Remove address space of returned pointer

Uwe Kleine-König (7):
      ALSA: core: Make snd_card_disconnect() return void
      drm/amd/display: Whitespace cleanup
      media: hantro_drv: Convert to platform remove callback returning void
      irqchip/imx-intmux: Convert to platform_driver::remove_new() callback
      pwm: renesas: Drop usage of pwm_[gs]et_chip_data()
      pwm: lp3943: Drop usage of pwm_[gs]et_chip_data()
      memory: emif: Convert to platform remove callback returning void

Vaibhav Nagare (1):
      bnxt_en: don't leave an XDP program installed when the open fails

Val Packett (1):
      ASoC: qcom: qdsp6: q6afe: fix clk vote response type mismatch

Valentin Kindschi (2):
      Bluetooth: hci_sync: re-enable legacy advertising on resume
      Bluetooth: hci_sync: pause advertising for the scan address update

Vas Zayarskiy (1):
      hwmon: (aquacomputer_d5next) Avoid truncating scaled sensor readings

Vasileios Almpanis (2):
      configfs: pin the symlink target's dirent instead of chasing ->ci_dentry
      configfs: unhash the dentry before dropping the item in rmdir

Vasiliy Kovalev (1):
      ALSA: hda/via: Apply runtime PM workaround for ASUS X55A

Venky Shankar (1):
      ceph: don't fail write_begin with -EAGAIN after flushing old snapc

Vernon Yang (1):
      mm: khugepaged: fix swap entry value to folio_pfn()

VeroFess (1):
      smb: server: size directory name conversion buffer correctly

Vincent Donnefort (1):
      KVM: arm64: Fix MMFR0 TGRAN advertisement for pVMs

Vincent Jardin (1):
      dt-bindings: vendor-prefixes: add Free Mobile

Vincent Mailhol (1):
      can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices

Vinod Koul (1):
      dmaengine: zynqmp_dma: drop redundant label

Vishal Moola (Oracle) (1):
      filemap: find_lock_entries() now updates start offset

Vishnu Santhosh (1):
      dmaengine: qcom: bam_dma: Defer IRQ trigger type to device tree

Vitaly Prosyak (1):
      drm/amdgpu: serialize vblank counter reads against GPU reset

Vlad Kulikov (1):
      ipc: create_ipc_ns: drop mqueue mount on sysctl setup failure

Vladimir Murzin (1):
      usb: mtu3: Fix double dereference in TP_printk

Vladimir Oltean (1):
      PCI: cadence: Preserve all error codes in cdns_plat_pcie_probe()

Wahid Khan (1):
      HID: intel-ish-hid: ignore post-init ENUM_DEVICES from firmware

Waldemar Brodkorb (1):
      sh: Select BINFMT_FLAT_NO_DATA_START_OFFSET for !MMU

Walker Chen (1):
      dmaengine: dw-axi-dmac: Add support for StarFive JH7110 DMA

Wang Haoran (1):
      fbdev: atmel_lcdfb: fix list_first_entry() on possibly empty modelist in probe

Wang Yan (1):
      selftests/net: fix EVP_MD_CTX leak in tcp_mmap

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

Weiming Shi (5):
      net: team: free skb when broadcast has no txable port
      nvmet-rdma: reject short connection requests
      fs/ntfs3: take run_lock when freeing offs_folio in ni_decompress_file
      fs/ntfs3: zero frame pages on read error
      ntfs3: fix out-of-bounds read in ntfs_read_mft()

Wenjie Qi (1):
      f2fs: flush SIT journal during filesystem resize

Wentao Guan (1):
      wifi: cfg80211: release locks on error in cfg80211_wext_siwgenie()

Wentao Liang (40):
      ata: libahci_platform: Fix device reference leak in ahci_platform_get_resources()
      drm/amd/display: Fix dc stream excess put in dm_update_crtc_state()
      nfsd: Fix id-to-name cache entry leak in idtoname_parse()
      ASoC: wm8994: Fix runtime PM imbalance in wm8994_component_probe()
      ASoC: arizona-jack: Fix runtime PM imbalance in arizona_start_hpdet_acc_id()
      regulator: core: Fix c_rdev reference leak in regulator_resolve_coupling()
      regulator: core: Fix rdev reference leak in regulator_resolve_supply()
      ASoC: codecs: wm8994: Fix runtime PM leak in wm8994_mic_detect()
      ASoC: ti: davinci-mcasp: Fix runtime PM imbalance in __davinci_mcasp_set_clkdiv()
      drm/mali-dp: Fix runtime PM leak in malidp_crtc_atomic_enable()
      media: au0828: Fix media device leak in au0828_usb_probe()
      media: vpif_display: Fix i2c adapter reference leak in vpif_probe()
      regulator: core: Fix coupled regulators reference leak on removal
      mtd: rawnand: atmel: Fix MCK clock leak in atmel_nand_controller_init()
      mtd: amd76xrom: Fix PCI device reference leak in amd76xrom_init_one()
      mtd: maps: l440gx: Fix double put of the ISA bridge in init_l440gx()
      mtd: maps: l440gx: Fix double put of the PM device in init_l440gx()
      media: pvrusb2: Fix USB parent device leak in class_dev_create()
      wifi: mt76: Fix of_node reference leak in mt76_get_rate_power_limits()
      clocksource/drivers/fttmr010: Fix clk reference leak in error paths
      clocksource/drivers/digicolor: Fix clk reference leak on request_irq failure
      clk: imx: Fix clock reference leak in imx_get_clk_hw_by_name()
      clk: imx: Fix clock reference leak in imx_obtain_fixed_clock_hw()
      btrfs: zoned: fix block group reference leak in btrfs_repair_one_zone()
      irqchip/mchp-eic: Fix clock reference leak in mchp_eic_probe()
      ceph: Fix xattr buffer leak in __send_cap()
      ceph: Fix mds session leak in __open_export_target_session()
      ALSA: caiaq: free the EP4 URB when input setup fails
      mtd: mtdsuper: Fix MTD device reference leak in mtd_get_sb()
      media: vpif_capture: Fix i2c adapter reference leak in vpif_probe()
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

Willem de Bruijn (3):
      virtio_net: copy zerocopy frags in start_xmit without NAPI
      packet: use ubuf_info completion for TX_RING packets
      net: extend IPv6 exthdr detection of tunneled packets

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

Xiang Mei (7):
      libceph: bound mon_command ack decode to front len
      media: em28xx: reject audio endpoint with zero packet size
      media: go7007: only set audio_enabled if go7007_snd_init() succeeded
      fbdev: udlfb: don't rebuild the mode list while the framebuffer is in use
      ceph: reject mdsmaps that claim more than CEPH_MAX_MDS ranks
      ceph: fix integer overflow in the snap trace bounds check
      fs/ntfs3: validate $SDH entry size in ntfs_insert_security

Xiang Mei (Microsoft) (2):
      fs/ntfs3: check INDEX_ROOT resident size before use in ntfs_read_mft()
      fs/ntfs3: fix slab-out-of-bounds write in attr_insert_range()

Xiao Liang (1):
      tun: drop batched packets while the device is down

Xiaoyan Li (1):
      selftests/net: Add SHA256 computation over data sent in tcp_mmap

Xiaoyao Li (2):
      x86/kvm: Use separate percpu variable to track the enabling of asyncpf
      KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus lock detected

Xin Yin (1):
      writeback: size foreign flushes by target wb dirty pages

Xingui Yang (1):
      scsi: libsas: Fix out-of-bounds memcpy() in sas_ssp_task_response()

Xingyuan Mo (1):
      sctp: reject forged cookie peer_addr with unknown address family

Xiubo Li (3):
      ceph: do not cache negative dentries for snapped directories
      libceph: only set read_from_replica on read requests
      ceph: mark the superblock active after mounting

Xixin Liu (1):
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

Yang Wang (7):
      drm/amd/pm: Validate Vega hwmgr PowerPlay table bounds
      drm/amd/pm: Validate pp_table header before reading size
      drm/amd/pm: Use uploaded size for legacy custom PPTable
      drm/amd/pm: Validate Tonga PowerPlay state array bounds
      drm/amd/pm: Validate Tonga PPTable subtable bounds
      drm/amd/pm: Validate legacy hwmgr PP table offsets
      drm/amdgpu: Disable runtime PM for externally attached dGPUs

Yang Wen (1):
      exfat: keep FITRIM within the requested range

Yang Xiuwei (1):
      floppy: avoid NULL deref in reset_interrupt when cont is cleared

Yang Yingliang (1):
      media: davinci: vpif_capture: fix error return code in vpif_probe()

Yang Zi (1):
      comedi: addi_apci_3xxx: fix subdevice count underallocation

Yao Yiqi (2):
      fbcon: Retry rotated font allocation after failure
      fbcon: Rebuild rotated font buffer on font change

Yao Zi (1):
      x86/locking: Use sfence for wmb() if SSE is available

Yaozhong Li (2):
      arm64: dts: rockchip: fix analog headphone output on rk3399-firefly
      arm64: dts: rockchip: disable unused i2s0 on rk3399-firefly

Ye Bin (3):
      jbd2: use shrink_type type instead of bool type for __jbd2_journal_clean_checkpoint_list()
      jbd2: add prefix 'jbd2' for 'shrink_type'
      ext4: commit super block if fs record error when journal record without error

Yehyeong Lee (5):
      nvmet-fc: fix use-after-free in nvmet_fc_ls_create_connection()
      xen/pcifront: check that an AER callback exists before calling it
      nvme-rdma: don't complete a request after a bogus remote invalidation
      9p/xen: validate the response size from the backend
      nvme-auth: fail when the controller does not authenticate itself

YiPeng Chai (1):
      drm/amdgpu: add bounds check to prevent array overflow

Yibo Tan (2):
      fbdev: atmel_lcdfb: Prevent FIFO work after removal
      ASoC: amd: acp-es8336: Use an owned codec device reference

Yichong Chen (3):
      exfat: free new directory cluster if zeroing fails
      io_uring/net: keep recvmsg buffer select length within MAX_RW_COUNT
      btrfs: retry verity reads for not-uptodate Merkle folios

Yifei Gao (1):
      9p/xen: fix refcount leak in p9_xen_response() on wrong tag

Yili Zhang (1):
      RDMA/nldev: Fix NULL deref in dumps of objects abandoned by DRIVER_FAILURE

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

Yonghao Zhang (1):
      remoteproc: core: Set trace buffer name for diagnostics

Yongjian Mu (1):
      xprtrdma: trim head iovec when the payload arrives via a Write chunk

Yongjun Gwon (1):
      ksmbd: serialize directory emptiness checks with readdir

Yosry Ahmed (4):
      KVM: nVM: Ensure INVVPID is emulated on the correct physical CPU
      KVM: x86: Always initialize EFER reserved bits on vendor initialization
      KVM: x86: Check EFER validity on KVM_SET_SREGS*
      KVM: SVM: Trigger new ASID allocation in both VMCBs on pCPU switch

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

Yuan Chen (3):
      bpf: Fix queue/stack map u32 index overflow
      bpftool: Fix spurious batch file read error
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

Yuho Choi (7):
      driver core: attribute_container: Unwind device_add() on attr failure
      iommu/virtio: Reset device before deleting virtqueues on probe failure
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

Yuto Ohnuki (1):
      virtiofs: add FUSE protocol validation

Yuxiang Lin (1):
      HID: quirks: add ALWAYS_POLL quirk for AULA Mini 60 HE Pro Dongle

Yuyang Huang (1):
      net: prestera: ignore duplicate RIF destruction events

Zeng Jingxiang (1):
      mm/vmscan: wake up flushers conditionally to avoid cgroup OOM

Zev Weiss (1):
      regulator: devres: Add devm_regulator_bulk_get_exclusive()

Zhan Xusheng (2):
      f2fs: fix defragment writeback range truncation on 32-bit
      fs/ntfs3: fix valid_size not being updated in attr_allocate_frame()

Zhang Heng (4):
      ALSA: hda/realtek: Fix headset mic on ASUS Vivobook S14 S5406SA
      ALSA: hda/realtek: Add quirk for Lenovo IdeaPad Slim 3 15ABR8
      ASoC: amd: yc: Add DMI entry for Alienware m18 R1 AMD
      ALSA: hda/realtek: Add quirk for Acer Nitro AN515-45

Zhang Yi (2):
      ext4: check return value of ext4_get_block() in ext4_load_tail_bh()
      ASoC: codecs: es*: Modify the registers related to ALC RECOVERY

Zhang Zekun (1):
      ata: libahci_platform: Simplify code with for_each_child_of_node_scoped()

Zhao Gongyi (2):
      arm64: mm: validate /dev/mem mmap ranges without overflow
      ata: libata-scsi: reject data-in commands with a data-out buffer

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
      ipmr: only copy pktinfo to cache reports
      mm/page_table_check: skip zero pages
      ipmr: drop packets with unknown ingress VIF
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

Zi Yan (1):
      USB: gadgetfs: do not WARN about excessively large memory allocations

Zide Chen (1):
      perf/x86/intel/uncore: Fix PCI PMU cleanup on setup failure

Zihan Xi (1):
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

alex todadze (1):
      net: stmmac: fix rx checksum offload with extended descriptors

bui duc phuc (57):
      regulator: rt6245: Restore state on enable failure
      ASoC: stm: stm32_i2s: Drop redundant error messages
      ASoC: mediatek: mt8186: Fix APLL mux setting error handling
      ASoC: mediatek: mt8186: Fix clock handling in mux disable path
      ASoC: mediatek: mt8186: Fix AFE clock error handling
      ASoC: mediatek: mt8186: Fix APLL enable error handling
      ASoC: mediatek: mt8186: Fix MCK error handling
      ASoC: mediatek: mt6797: fix wrong unwind order and error code in enable_clock
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
      ASoC: mediatek: mt8192-mt6359: Fix error handling in MTKAIF calibration
      ASoC: rockchip: rockchip_i2s: Handle runtime PM resume failures in set_fmt
      ASoC: mediatek: common: Handle constraint return value in FE startup
      power: supply: generic-adc-battery: Propagate charged GPIO errors
      ASoC: codecs: rt5659: propagate GPIO errors
      ASoC: amd: acp: Fix .close() being skipped on rollback
      ASoC: amd: ps: Fix acp63_pdm_dma_close() being skipped on rollback
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

renpanpan (2):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion 14-dv1001TU
      drm/amdgpu: Only enable HDMI audio if display supports it

sung byeongchan (3):
      ceph: bound name skips in ceph_mdsmap_decode() by the message end
      ceph: validate encoded xattr name lengths
      ceph: validate MDS reply fragtree split array length

vladimir.oltean@nxp.com (1):
      PCI: dra7xx: Remove device links to PHY

wangdicheng (1):
      ALSA: hda/conexant: Add NULL check for dc_mode_path

yanxia (1):
      veth: fix stale peer max_mtu on XDP program replacement

ye xingchen (1):
      rtc: s35390a: Remove the unneeded result variable

Ömer Mete Kaya (2):
      usbnet: fix smp_processor_id() use in preemptible context
      usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()

イムティヤズ (1):
      wifi: rtw88: fix out-of-bounds CAM write when key table is full

胡连勤 (1):
      block: set QUEUE_FLAG_DYING unconditionally in blk_mark_disk_dead()

이상호 (1):
      romfs: detect hard link cycles

