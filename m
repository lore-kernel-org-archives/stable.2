Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420767;
	b=jjDE2VTomRdcZxtaKNB9/2Q/ytwSWJH4l21DdoFw+1bMMnxXqxHHgfMe1cClyJtw7ho/
	 DUcFcQe0uXZdYYqDM0MaiJxMoMTqyTmzEBaFMrLkcIFMdrKelD8M+pJq+IYN3Hp7d+uxC
	 HWZ9kKghfjocqoqDj/znBlLg08FXIg/j4KlEmWJzjMYIC3K8YmrJLCI2R8T9ry2QMEts/
	 SO76Xh/NfjLX88/zYr9ObbUYyhIFXXc2xmzSaYvmGgd/RMmBsPrAyU92fhnv68CPRTIsi
	 a6j8RSCbm0eHZ+DSF5IE6BoJNwJrfJIJWHaqnod+9Cr+MyeLvOjt4aw5TgMcbp05zsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420767;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=h8/+RMrLhLiymfBDxSL76grT71r4QaW3YB26SbKY7yg=;
	b=m3QDQh/LXiMXc3xYQXjAvLUTHgoraRunew5ffkTKHsFgM0qMOxBEiBfOKba/SQ6aG+PD
	 1nB7POMOSYODZhbUpzx9dLcS9MWawxnpiyV0ayaGzwRdijCLRyCzEF+P2w8yuWL+exFBI
	 +Dv2gQeM35nHA8ehArGkhORbbIffS/1uFBNQuKrzA2euizDBXpiAuH+zAYfJ5Re5os/Un
	 RAJdaVJ3P+FJBjzPJAuYHvhBJ4rCmjVOd1i7tSAD5tT9v+KMBLMDe6Yr64AteEtyX0t7M
	 AgvENIpJBxv/ZprdpFpojWH9WkqWmNdv14xlsMBtKAv/gqp5EaXJt6Pwnj8HkR1hnog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KByhKaGr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649F4606A31E;
	Mon, 23 Nov 2026 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KByhKaGr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DF01F000CF;
	Mon, 23 Nov 2026 07:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795420767;
	bh=h8/+RMrLhLiymfBDxSL76grT71r4QaW3YB26SbKY7yg=;
	h=From:To:Cc:Subject:Date;
	b=KByhKaGrMUoa7WN/V4UqOKIQJsi+dJ9FyOwYE4dbIjEWgGSsi/UCVwQ/7QqIh8ZJi
	 0yTOjhfrDmaMFYo5lkToOCy6JtiKciaLYkFLI/pubvai2/2HGjteSEn80wxiIWMe9h
	 kSCb7E3I2Pgkk7dKKyU+3XiR/N+kVC08/VgWWemk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.275
Date: Mon, 23 Nov 2026 08:59:21 +0100
Message-ID: <2026112322-hermit-obsessed-008f@gregkh>
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

I'm announcing the release of the 5.10.275 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 .gitignore                                                                    |    3 
 Documentation/ABI/testing/sysfs-class-power-mp2629                            |    2 
 Documentation/PCI/pci-error-recovery.rst                                      |    7 
 Documentation/admin-guide/LSM/LoadPin.rst                                     |   14 
 Documentation/admin-guide/cgroup-v2.rst                                       |   10 
 Documentation/admin-guide/kernel-parameters.txt                               |    6 
 Documentation/block/blk-mq.rst                                                |    2 
 Documentation/core-api/pin_user_pages.rst                                     |    6 
 Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml |   21 
 Documentation/devicetree/bindings/vendor-prefixes.yaml                        |   56 
 Documentation/filesystems/fsverity.rst                                        |    2 
 Documentation/filesystems/overlayfs.rst                                       |    3 
 Documentation/kbuild/kconfig-language.rst                                     |    5 
 Documentation/kbuild/kconfig.rst                                              |    8 
 Documentation/networking/ip-sysctl.rst                                        |    3 
 MAINTAINERS                                                                   |    5 
 Makefile                                                                      |    2 
 arch/alpha/include/asm/mmu_context.h                                          |   15 
 arch/alpha/include/asm/switch_to.h                                            |    1 
 arch/alpha/include/asm/tlbflush.h                                             |    3 
 arch/alpha/kernel/rtc.c                                                       |   37 
 arch/alpha/kernel/smp.c                                                       |   15 
 arch/arc/Kconfig                                                              |    1 
 arch/arc/Makefile                                                             |    9 
 arch/arc/lib/Makefile                                                         |    8 
 arch/arc/oprofile/Makefile                                                    |   10 
 arch/arc/oprofile/common.c                                                    |   23 
 arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi                                |    2 
 arch/arm/boot/dts/armada-388-helios4.dts                                      |   23 
 arch/arm/boot/dts/armada-395-gp.dts                                           |    1 
 arch/arm/boot/dts/gemini.dtsi                                                 |    2 
 arch/arm/boot/dts/imx7-tqma7.dtsi                                             |   83 
 arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts                                     |    2 
 arch/arm/mach-mvebu/Kconfig                                                   |    4 
 arch/arm/mach-vexpress/platsmp.c                                              |    4 
 arch/arm/mach-vexpress/v2m.c                                                  |    4 
 arch/arm/mm/alignment.c                                                       |   61 
 arch/arm/mm/dma-mapping.c                                                     |    5 
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi                                  |    4 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts                          |    6 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                                      |    2 
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts                               |   45 
 arch/arm64/crypto/poly1305-armv8.pl                                           |    2 
 arch/arm64/include/asm/kprobes.h                                              |    7 
 arch/arm64/include/asm/kvm_host.h                                             |    2 
 arch/arm64/kernel/efi.c                                                       |    8 
 arch/arm64/kernel/machine_kexec.c                                             |    2 
 arch/arm64/kernel/machine_kexec_file.c                                        |    2 
 arch/arm64/kernel/probes/kprobes.c                                            |   53 
 arch/arm64/kernel/sdei.c                                                      |  101 
 arch/arm64/kvm/arm.c                                                          |   26 
 arch/arm64/kvm/vgic/vgic-its.c                                                |   40 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                            |   13 
 arch/arm64/mm/mmap.c                                                          |    4 
 arch/arm64/mm/mmu.c                                                           |   14 
 arch/arm64/net/bpf_jit_comp.c                                                 |    4 
 arch/m68k/apollo/dn_ints.c                                                    |    6 
 arch/microblaze/Makefile                                                      |    6 
 arch/microblaze/include/asm/entry.h                                           |   13 
 arch/microblaze/include/asm/processor.h                                       |    2 
 arch/microblaze/include/asm/string.h                                          |    2 
 arch/microblaze/include/asm/uaccess.h                                         |    3 
 arch/microblaze/kernel/cpu/cpuinfo.c                                          |    1 
 arch/microblaze/kernel/entry.S                                                |  294 
 arch/microblaze/kernel/hw_exception_handler.S                                 |    5 
 arch/microblaze/kernel/process.c                                              |    5 
 arch/microblaze/kernel/ptrace.c                                               |    3 
 arch/microblaze/kernel/signal.c                                               |   26 
 arch/microblaze/lib/memset.c                                                  |   33 
 arch/mips/cavium-octeon/dma-octeon.c                                          |    2 
 arch/mips/mm/cex-gen.S                                                        |   16 
 arch/mips/mm/tlb-r4k.c                                                        |   21 
 arch/mips/pci/ops-mace.c                                                      |   26 
 arch/mips/pci/pci-ip32.c                                                      |    9 
 arch/mips/sgi-ip32/ip32-irq.c                                                 |   45 
 arch/nios2/kernel/nios2_ksyms.c                                               |    1 
 arch/openrisc/kernel/or32_ksyms.c                                             |    1 
 arch/powerpc/kvm/book3s_paired_singles.c                                      |    7 
 arch/riscv/net/bpf_jit_comp32.c                                               |   47 
 arch/s390/configs/debug_defconfig                                             |    2 
 arch/s390/configs/defconfig                                                   |    2 
 arch/s390/kernel/uprobes.c                                                    |    2 
 arch/s390/lib/probes.c                                                        |    2 
 arch/s390/mm/hugetlbpage.c                                                    |    2 
 arch/s390/mm/mmap.c                                                           |    2 
 arch/s390/pci/pci_irq.c                                                       |   26 
 arch/sh/boards/board-sh7785lcr.c                                              |    2 
 arch/sh/configs/migor_defconfig                                               |    2 
 arch/sh/configs/sdk7786_defconfig                                             |    2 
 arch/sh/configs/shx3_defconfig                                                |    2 
 arch/sh/include/asm/uaccess_32.h                                              |    8 
 arch/x86/include/asm/cpufeatures.h                                            |    6 
 arch/x86/include/asm/kvm_host.h                                               |    7 
 arch/x86/include/asm/svm.h                                                    |    4 
 arch/x86/include/asm/xor_avx.h                                                |    4 
 arch/x86/kernel/acpi/cppc_msr.c                                               |   15 
 arch/x86/kernel/cpu/amd.c                                                     |   18 
 arch/x86/kernel/nmi.c                                                         |    8 
 arch/x86/kernel/process.c                                                     |    1 
 arch/x86/kernel/x86_init.c                                                    |    2 
 arch/x86/kvm/hyperv.c                                                         |    2 
 arch/x86/kvm/mmu/mmu.c                                                        |   18 
 arch/x86/kvm/mmu/paging_tmpl.h                                                |   24 
 arch/x86/kvm/svm/nested.c                                                     |   11 
 arch/x86/kvm/vmx/nested.c                                                     |    9 
 arch/x86/kvm/vmx/vmx.c                                                        |    1 
 arch/x86/kvm/x86.c                                                            |   22 
 arch/x86/mm/mem_encrypt_identity.c                                            |    2 
 arch/x86/platform/pvh/enlighten.c                                             |    2 
 arch/x86/power/hibernate.c                                                    |   51 
 block/blk-flush.c                                                             |   25 
 block/blk-iocost.c                                                            |   10 
 block/blk-mq.c                                                                |    4 
 block/blk-throttle.c                                                          |    3 
 block/bsg.c                                                                   |    6 
 block/ioctl.c                                                                 |    4 
 block/partitions/mac.c                                                        |    4 
 block/scsi_ioctl.c                                                            |   11 
 crypto/Kconfig                                                                |    6 
 crypto/algif_skcipher.c                                                       |   13 
 crypto/asymmetric_keys/restrict.c                                             |    2 
 crypto/asymmetric_keys/verify_pefile.c                                        |    5 
 crypto/ecc.c                                                                  |   33 
 crypto/ecdh.c                                                                 |    2 
 crypto/tcrypt.c                                                               |  533 
 crypto/testmgr.h                                                              |  198 
 drivers/accessibility/speakup/selection.c                                     |    6 
 drivers/acpi/acpi_extlog.c                                                    |    9 
 drivers/acpi/acpi_video.c                                                     |   12 
 drivers/acpi/acpica/dsfield.c                                                 |    3 
 drivers/acpi/acpica/exfield.c                                                 |   11 
 drivers/acpi/acpica/nsxfname.c                                                |    1 
 drivers/acpi/apei/ghes.c                                                      |   16 
 drivers/acpi/button.c                                                         |   23 
 drivers/acpi/cppc_acpi.c                                                      |   22 
 drivers/acpi/glue.c                                                           |   10 
 drivers/acpi/pci_link.c                                                       |    1 
 drivers/acpi/tables.c                                                         |    3 
 drivers/ata/Kconfig                                                           |    7 
 drivers/ata/Makefile                                                          |    1 
 drivers/ata/ahci_st.c                                                         |   78 
 drivers/ata/ata_generic.c                                                     |    6 
 drivers/ata/libahci.c                                                         |   45 
 drivers/ata/libahci_platform.c                                                |    4 
 drivers/ata/libata-core.c                                                     |   89 
 drivers/ata/libata-pmp.c                                                      |   14 
 drivers/ata/libata-scsi.c                                                     |   32 
 drivers/ata/libata-sff.c                                                      |   15 
 drivers/ata/pata_cs5520.c                                                     |    2 
 drivers/ata/sata_dwc_460ex.c                                                  |   49 
 drivers/ata/sata_fsl.c                                                        |   24 
 drivers/ata/sata_inic162x.c                                                   |  906 
 drivers/ata/sata_qstor.c                                                      |    8 
 drivers/base/attribute_container.c                                            |    7 
 drivers/base/core.c                                                           |    4 
 drivers/base/node.c                                                           |   17 
 drivers/base/power/wakeirq.c                                                  |   75 
 drivers/base/power/wakeup.c                                                   |   30 
 drivers/base/swnode.c                                                         |   92 
 drivers/block/Kconfig                                                         |    2 
 drivers/block/amiflop.c                                                       |   69 
 drivers/block/aoe/aoenet.c                                                    |   14 
 drivers/block/drbd/drbd_receiver.c                                            |    2 
 drivers/block/floppy.c                                                        |   13 
 drivers/block/loop.c                                                          |    6 
 drivers/block/swim.c                                                          |  189 
 drivers/block/swim3.c                                                         |    8 
 drivers/block/swim_asm.S                                                      |  136 
 drivers/block/virtio_blk.c                                                    |    2 
 drivers/block/xen-blkback/blkback.c                                           |    7 
 drivers/block/xen-blkfront.c                                                  |   12 
 drivers/bluetooth/btrsi.c                                                     |    3 
 drivers/bluetooth/btusb.c                                                     |    4 
 drivers/bluetooth/hci_bcsp.c                                                  |    5 
 drivers/bluetooth/hci_nokia.c                                                 |   20 
 drivers/bus/arm-cci.c                                                         |    6 
 drivers/char/hw_random/amd-rng.c                                              |    2 
 drivers/char/hw_random/ba431-rng.c                                            |    2 
 drivers/char/hw_random/cctrng.c                                               |    7 
 drivers/char/hw_random/core.c                                                 |    1 
 drivers/char/hw_random/intel-rng.c                                            |    5 
 drivers/char/hw_random/virtio-rng.c                                           |    7 
 drivers/char/ipmi/ipmi_msghandler.c                                           |    1 
 drivers/char/scx200_gpio.c                                                    |    8 
 drivers/char/tpm/tpm-dev-common.c                                             |    3 
 drivers/char/tpm/tpm2-cmd.c                                                   |    3 
 drivers/char/tpm/tpm_nsc.c                                                    |    8 
 drivers/char/tpm/tpm_tis_spi.h                                                |    8 
 drivers/char/virtio_console.c                                                 |   13 
 drivers/clk/bcm/clk-raspberrypi.c                                             |    2 
 drivers/clk/clk-cdce925.c                                                     |    9 
 drivers/clk/clk-milbeaut.c                                                    |   10 
 drivers/clk/clk.c                                                             |    5 
 drivers/clk/imx/clk-imx8qxp-lpcg.c                                            |    1 
 drivers/clk/imx/clk-imx8qxp.c                                                 |    1 
 drivers/clk/imx/clk.c                                                         |   15 
 drivers/clk/qcom/clk-rcg2.c                                                   |    9 
 drivers/clk/qcom/mmcc-msm8996.c                                               |    4 
 drivers/clk/sunxi-ng/ccu_common.c                                             |   12 
 drivers/clk/tegra/clk-pll.c                                                   |    1 
 drivers/clk/ti/adpll.c                                                        |    1 
 drivers/clk/zynq/clkc.c                                                       |    8 
 drivers/clocksource/clksrc-dbx500-prcmu.c                                     |    2 
 drivers/clocksource/timer-digicolor.c                                         |    2 
 drivers/clocksource/timer-fttmr010.c                                          |    2 
 drivers/clocksource/timer-mediatek.c                                          |    4 
 drivers/cpufreq/cpufreq_conservative.c                                        |    8 
 drivers/cpufreq/cpufreq_governor.c                                            |   29 
 drivers/cpufreq/cpufreq_governor.h                                            |    2 
 drivers/cpufreq/cpufreq_stats.c                                               |    4 
 drivers/cpufreq/sparc-us2e-cpufreq.c                                          |   11 
 drivers/cpufreq/sti-cpufreq.c                                                 |    4 
 drivers/cpuidle/governors/menu.c                                              |    8 
 drivers/crypto/amlogic/amlogic-gxl-cipher.c                                   |   29 
 drivers/crypto/amlogic/amlogic-gxl-core.c                                     |    7 
 drivers/crypto/atmel-aes.c                                                    |    4 
 drivers/crypto/atmel-sha.c                                                    |   17 
 drivers/crypto/atmel-tdes.c                                                   |    6 
 drivers/crypto/caam/caampkc.c                                                 |    6 
 drivers/crypto/ccp/ccp-dev-v3.c                                               |    4 
 drivers/crypto/ccp/ccp-dev-v5.c                                               |    4 
 drivers/crypto/hisilicon/hpre/hpre_crypto.c                                   |    8 
 drivers/crypto/nx/nx-842.c                                                    |    2 
 drivers/crypto/omap-sham.c                                                    |    1 
 drivers/crypto/qat/qat_common/qat_asym_algs.c                                 |    8 
 drivers/crypto/talitos.c                                                      |   93 
 drivers/crypto/talitos.h                                                      |    5 
 drivers/dax/super.c                                                           |    2 
 drivers/dma/altera-msgdma.c                                                   |   10 
 drivers/dma/dw-edma/dw-edma-pcie.c                                            |    3 
 drivers/dma/fsl_raid.c                                                        |   32 
 drivers/dma/img-mdc-dma.c                                                     |    2 
 drivers/dma/ioat/init.c                                                       |   18 
 drivers/dma/mediatek/mtk-hsdma.c                                              |   26 
 drivers/dma/mv_xor.c                                                          |    1 
 drivers/dma/pl330.c                                                           |   19 
 drivers/dma/plx_dma.c                                                         |   10 
 drivers/dma/qcom/bam_dma.c                                                    |   12 
 drivers/dma/sprd-dma.c                                                        |   45 
 drivers/dma/sun6i-dma.c                                                       |   57 
 drivers/dma/xilinx/xilinx_dma.c                                               |   46 
 drivers/dma/xilinx/zynqmp_dma.c                                               |   74 
 drivers/extcon/extcon-arizona.c                                               |    1 
 drivers/firmware/efi/cper.c                                                   |   51 
 drivers/firmware/efi/libstub/Makefile                                         |    2 
 drivers/firmware/efi/libstub/efi-stub.c                                       |    8 
 drivers/firmware/efi/libstub/efistub.h                                        |    4 
 drivers/firmware/imx/imx-dsp.c                                                |    6 
 drivers/firmware/imx/imx-scu.c                                                |   25 
 drivers/firmware/imx/scu-pd.c                                                 |   10 
 drivers/fpga/fpga-mgr.c                                                       |    2 
 drivers/gpio/gpio-crystalcove.c                                               |    1 
 drivers/gpio/gpio-dwapb.c                                                     |   12 
 drivers/gpio/gpio-mvebu.c                                                     |   33 
 drivers/gpio/gpio-pca953x.c                                                   |   28 
 drivers/gpio/gpiolib-cdev.c                                                   |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                                      |   68 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                              |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c                                      |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c                                   |   43 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                        |   20 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                                   |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                    |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                       |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                       |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                                       |    4 
 drivers/gpu/drm/amd/amdgpu/cik.c                                              |   10 
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c                                        |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c                                         |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c                                         |    5 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c                                        |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c                                        |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c                                        |    1 
 drivers/gpu/drm/amd/amdgpu/si.c                                               |   10 
 drivers/gpu/drm/amd/amdgpu/vi.c                                               |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c                                         |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                             |   11 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h                       |   17 
 drivers/gpu/drm/amd/display/dc/core/dc_link.c                                 |    6 
 drivers/gpu/drm/amd/display/dc/dc_types.h                                     |    2 
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c                                  |    2 
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_6_0_0_offset.h                   |15799 ++
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_6_0_0_sh_mask.h                  |58556 ++++++++++
 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_6_0_0_offset.h                 |   47 
 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_6_0_0_sh_mask.h                |   55 
 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_5_0_1_offset.h               |   17 
 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_5_0_1_sh_mask.h              |   17 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c                           |    3 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h                         |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c                |   62 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c                      |  446 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c                           |   34 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c                         |   46 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h                       |   24 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c               |   59 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c               |    7 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c               |    7 
 drivers/gpu/drm/arm/display/include/malidp_product.h                          |   10 
 drivers/gpu/drm/arm/malidp_crtc.c                                             |    1 
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c                            |   13 
 drivers/gpu/drm/bridge/nwl-dsi.c                                              |   17 
 drivers/gpu/drm/drm_crtc.c                                                    |   15 
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c                                      |   40 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                                         |    6 
 drivers/gpu/drm/exynos/exynos_drm_fimd.c                                      |    2 
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c                                |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                         |    6 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c                                      |    9 
 drivers/gpu/drm/msm/dp/dp_ctrl.c                                              |  138 
 drivers/gpu/drm/msm/dp/dp_display.c                                           |    6 
 drivers/gpu/drm/msm/dp/dp_panel.c                                             |   15 
 drivers/gpu/drm/msm/dp/dp_panel.h                                             |    1 
 drivers/gpu/drm/msm/hdmi/hdmi.c                                               |   35 
 drivers/gpu/drm/msm/hdmi/hdmi.h                                               |    6 
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c                                        |   48 
 drivers/gpu/drm/msm/hdmi/hdmi_hpd.c                                           |   24 
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                                           |   47 
 drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h                             |    1 
 drivers/gpu/drm/nouveau/nouveau_abi16.c                                       |    4 
 drivers/gpu/drm/nouveau/nouveau_svm.c                                         |   13 
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c                             |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild                                |    1 
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c                               |   35 
 drivers/gpu/drm/panel/panel-simple.c                                          |    3 
 drivers/gpu/drm/panfrost/panfrost_devfreq.c                                   |    2 
 drivers/gpu/drm/panfrost/panfrost_mmu.c                                       |   11 
 drivers/gpu/drm/radeon/r600_dpm.c                                             |   21 
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c                                   |    7 
 drivers/gpu/drm/ttm/ttm_bo_util.c                                             |    4 
 drivers/gpu/drm/v3d/v3d_sched.c                                               |    2 
 drivers/gpu/drm/vc4/vc4_gem.c                                                 |   10 
 drivers/gpu/host1x/hw/cdma_hw.c                                               |    2 
 drivers/greybus/manifest.c                                                    |    2 
 drivers/hid/hid-core.c                                                        |    4 
 drivers/hid/hid-cougar.c                                                      |    3 
 drivers/hid/hid-cp2112.c                                                      |    9 
 drivers/hid/hid-elo.c                                                         |    3 
 drivers/hid/hid-ids.h                                                         |    4 
 drivers/hid/hid-logitech-dj.c                                                 |    3 
 drivers/hid/hid-mcp2221.c                                                     |    2 
 drivers/hid/hid-multitouch.c                                                  |   19 
 drivers/hid/hid-prodikeys.c                                                   |  120 
 drivers/hid/hid-quirks.c                                                      |    2 
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
 drivers/hid/wacom_sys.c                                                       |  192 
 drivers/hid/wacom_wac.c                                                       |  114 
 drivers/hid/wacom_wac.h                                                       |    6 
 drivers/hsi/controllers/omap_ssi_core.c                                       |    3 
 drivers/hv/ring_buffer.c                                                      |   29 
 drivers/hwmon/acpi_power_meter.c                                              |   10 
 drivers/hwmon/coretemp.c                                                      |   13 
 drivers/hwmon/corsair-cpro.c                                                  |   12 
 drivers/hwmon/lm70.c                                                          |    6 
 drivers/hwmon/lm87.c                                                          |    7 
 drivers/hwmon/lm95245.c                                                       |    6 
 drivers/hwmon/nct6683.c                                                       |    4 
 drivers/hwmon/sht3x.c                                                         |    5 
 drivers/hwmon/tmp102.c                                                        |    8 
 drivers/hwmon/tmp108.c                                                        |   26 
 drivers/i2c/busses/i2c-designware-master.c                                    |    8 
 drivers/i2c/busses/i2c-mt7621.c                                               |    9 
 drivers/i2c/i2c-core-acpi.c                                                   |   24 
 drivers/iio/accel/adis16201.c                                                 |   10 
 drivers/iio/accel/bma220_spi.c                                                |    3 
 drivers/iio/accel/kxcjk-1013.c                                                |    1 
 drivers/iio/accel/mma9551.c                                                   |    1 
 drivers/iio/accel/mma9553.c                                                   |    1 
 drivers/iio/adc/max1241.c                                                     |    1 
 drivers/iio/dac/ad5758.c                                                      |    6 
 drivers/iio/humidity/hts221_core.c                                            |  106 
 drivers/iio/imu/adis16400.c                                                   |    5 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c                             |    8 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c                              |    8 
 drivers/iio/light/isl29028.c                                                  |   23 
 drivers/iio/light/ltr501.c                                                    |    2 
 drivers/iio/pressure/dps310.c                                                 |    6 
 drivers/infiniband/core/lag.c                                                 |   19 
 drivers/infiniband/core/mad.c                                                 |    2 
 drivers/infiniband/core/mad_rmpp.c                                            |    7 
 drivers/infiniband/core/nldev.c                                               |    5 
 drivers/infiniband/core/uverbs_std_types_device.c                             |    1 
 drivers/infiniband/core/uverbs_std_types_wq.c                                 |    2 
 drivers/infiniband/core/verbs.c                                               |    3 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                      |   50 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                                     |    9 
 drivers/infiniband/hw/cxgb4/cm.c                                              |    4 
 drivers/infiniband/hw/hfi1/fault.c                                            |    1 
 drivers/infiniband/hw/hfi1/sdma.c                                             |    3 
 drivers/infiniband/hw/hns/hns_roce_cq.c                                       |    2 
 drivers/infiniband/hw/hns/hns_roce_device.h                                   |    1 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                    |    1 
 drivers/infiniband/hw/hns/hns_roce_mr.c                                       |  291 
 drivers/infiniband/hw/hns/hns_roce_qp.c                                       |    5 
 drivers/infiniband/hw/hns/hns_roce_srq.c                                      |    2 
 drivers/infiniband/hw/mlx5/cq.c                                               |    2 
 drivers/infiniband/hw/mlx5/odp.c                                              |    2 
 drivers/infiniband/hw/mlx5/qp.c                                               |    3 
 drivers/infiniband/hw/mlx5/qpc.c                                              |    8 
 drivers/infiniband/hw/mlx5/srq.c                                              |    3 
 drivers/infiniband/hw/mlx5/wr.c                                               |    1 
 drivers/infiniband/hw/usnic/usnic_debugfs.c                                   |    2 
 drivers/infiniband/sw/rxe/rxe_hdr.h                                           |  178 
 drivers/infiniband/sw/rxe/rxe_loc.h                                           |    3 
 drivers/infiniband/sw/rxe/rxe_recv.c                                          |   11 
 drivers/infiniband/sw/rxe/rxe_req.c                                           |    1 
 drivers/infiniband/sw/rxe/rxe_resp.c                                          |    3 
 drivers/infiniband/sw/siw/siw_main.c                                          |    5 
 drivers/infiniband/sw/siw/siw_qp_tx.c                                         |   20 
 drivers/infiniband/ulp/ipoib/ipoib_main.c                                     |    7 
 drivers/infiniband/ulp/isert/ib_isert.c                                       |    2 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                                        |    4 
 drivers/infiniband/ulp/srp/ib_srp.c                                           |    2 
 drivers/input/joystick/xpad.c                                                 |    2 
 drivers/iommu/amd/init.c                                                      |   23 
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                                       |   11 
 drivers/iommu/dma-iommu.c                                                     |   14 
 drivers/iommu/intel/dmar.c                                                    |  140 
 drivers/iommu/rockchip-iommu.c                                                |   13 
 drivers/iommu/virtio-iommu.c                                                  |    6 
 drivers/irqchip/irq-gic-v3-its.c                                              |  505 
 drivers/irqchip/irq-gic-v3-mbi.c                                              |    5 
 drivers/irqchip/irq-gic-v3.c                                                  |    1 
 drivers/irqchip/irq-imx-intmux.c                                              |   29 
 drivers/leds/led-class-flash.c                                                |    2 
 drivers/leds/leds-ktd2692.c                                                   |   10 
 drivers/leds/leds-lm3692x.c                                                   |    4 
 drivers/leds/leds-pca9532.c                                                   |    9 
 drivers/mailbox/qcom-ipcc.c                                                   |    6 
 drivers/mailbox/ti-msgmgr.c                                                   |   14 
 drivers/md/dm-snap-persistent.c                                               |    7 
 drivers/md/dm-writecache.c                                                    |   14 
 drivers/md/md.c                                                               |   21 
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
 drivers/media/dvb-frontends/sp8870.c                                          |    5 
 drivers/media/dvb-frontends/stv0900_core.c                                    |    2 
 drivers/media/dvb-frontends/stv090x.c                                         |    2 
 drivers/media/i2c/adv7180.c                                                   |    2 
 drivers/media/i2c/adv748x/adv748x-core.c                                      |   13 
 drivers/media/i2c/adv7604.c                                                   |    3 
 drivers/media/i2c/tc358743.c                                                  |    3 
 drivers/media/pci/cx18/cx18-driver.c                                          |    9 
 drivers/media/pci/cx18/cx18-vbi.c                                             |    2 
 drivers/media/pci/cx23885/cx23885-core.c                                      |    4 
 drivers/media/pci/cx23885/cx23885-dvb.c                                       |   14 
 drivers/media/pci/cx88/cx88-mpeg.c                                            |   10 
 drivers/media/pci/ivtv/ivtv-vbi.c                                             |    2 
 drivers/media/pci/tw68/tw68-core.c                                            |    2 
 drivers/media/pci/tw686x/tw686x-core.c                                        |   10 
 drivers/media/platform/atmel/atmel-isc-base.c                                 |   46 
 drivers/media/platform/atmel/atmel-isc-regs.h                                 |    6 
 drivers/media/platform/atmel/atmel-isc.h                                      |    1 
 drivers/media/platform/atmel/atmel-isi.c                                      |    7 
 drivers/media/platform/atmel/atmel-sama5d2-isc.c                              |    2 
 drivers/media/platform/davinci/vpif_capture.c                                 |    5 
 drivers/media/platform/davinci/vpif_display.c                                 |    3 
 drivers/media/platform/exynos4-is/fimc-lite.c                                 |    3 
 drivers/media/platform/m2m-deinterlace.c                                      |    2 
 drivers/media/platform/marvell-ccic/Kconfig                                   |    1 
 drivers/media/platform/marvell-ccic/mmp-driver.c                              |    5 
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c                               |    4 
 drivers/media/platform/mtk-vpu/mtk_vpu.c                                      |    6 
 drivers/media/platform/qcom/venus/hfi_msgs.c                                  |    3 
 drivers/media/platform/rockchip/rga/rga.c                                     |   69 
 drivers/media/platform/rockchip/rga/rga.h                                     |    7 
 drivers/media/platform/sti/delta/delta-mjpeg-hdr.c                            |    7 
 drivers/media/rc/fintek-cir.c                                                 |    4 
 drivers/media/rc/imon.c                                                       |    5 
 drivers/media/rc/ir-hix5hd2.c                                                 |    5 
 drivers/media/rc/ir-mce_kbd-decoder.c                                         |    5 
 drivers/media/rc/rc-ir-raw.c                                                  |   40 
 drivers/media/rc/redrat3.c                                                    |   28 
 drivers/media/test-drivers/vicodec/codec-fwht.h                               |    2 
 drivers/media/test-drivers/vicodec/vicodec-core.c                             |   16 
 drivers/media/test-drivers/vidtv/vidtv_bridge.c                               |    4 
 drivers/media/test-drivers/vidtv/vidtv_demod.c                                |    9 
 drivers/media/test-drivers/vim2m.c                                            |   29 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c                              |   13 
 drivers/media/usb/au0828/au0828-core.c                                        |    4 
 drivers/media/usb/au0828/au0828-dvb.c                                         |   19 
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
 drivers/media/usb/uvc/uvc_driver.c                                            |   51 
 drivers/media/usb/uvc/uvcvideo.h                                              |    1 
 drivers/memory/brcmstb_dpfe.c                                                 |   34 
 drivers/memory/emif.c                                                         |    9 
 drivers/memory/samsung/exynos5422-dmc.c                                       |   11 
 drivers/mfd/ab8500-core.c                                                     |  109 
 drivers/mfd/da903x.c                                                          |   35 
 drivers/mfd/da9150-core.c                                                     |    8 
 drivers/mfd/db8500-prcmu.c                                                    |    6 
 drivers/mfd/intel_quark_i2c_gpio.c                                            |  156 
 drivers/mfd/ipaq-micro.c                                                      |    2 
 drivers/mfd/mfd-core.c                                                        |   18 
 drivers/mfd/mt6360-core.c                                                     |   12 
 drivers/mfd/tps65217.c                                                        |   72 
 drivers/mfd/twl-core.c                                                        |  346 
 drivers/mfd/wcd934x.c                                                         |   34 
 drivers/misc/enclosure.c                                                      |    3 
 drivers/misc/genwqe/card_utils.c                                              |    2 
 drivers/misc/hpilo.c                                                          |    7 
 drivers/misc/ibmvmc.c                                                         |    7 
 drivers/mmc/core/block.c                                                      |    5 
 drivers/mmc/host/cqhci.c                                                      |   14 
 drivers/mtd/chips/cfi_cmdset_0002.c                                           |   15 
 drivers/mtd/maps/amd76xrom.c                                                  |    2 
 drivers/mtd/maps/l440gx.c                                                     |    2 
 drivers/mtd/maps/pci.c                                                        |    2 
 drivers/mtd/mtd_blkdevs.c                                                     |    5 
 drivers/mtd/mtdcore.c                                                         |    2 
 drivers/mtd/mtdsuper.c                                                        |    4 
 drivers/mtd/nand/raw/atmel/nand-controller.c                                  |    6 
 drivers/mtd/nand/raw/ndfc.c                                                   |   21 
 drivers/mtd/nand/raw/sunxi_nand.c                                             |    3 
 drivers/net/bonding/bond_main.c                                               |    2 
 drivers/net/can/dev/dev.c                                                     |    4 
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c                                    |    7 
 drivers/net/dsa/mt7530.c                                                      |   24 
 drivers/net/dsa/mv88e6xxx/chip.c                                              |    8 
 drivers/net/ethernet/alacritech/slicoss.c                                     |    2 
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c                          |    2 
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c                               |   34 
 drivers/net/ethernet/broadcom/bgmac.c                                         |   57 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                                 |   25 
 drivers/net/ethernet/broadcom/tg3.c                                           |   42 
 drivers/net/ethernet/hisilicon/hisi_femac.c                                   |    1 
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c                                 |   12 
 drivers/net/ethernet/ibm/ibmveth.c                                            |   34 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                                 |   40 
 drivers/net/ethernet/marvell/mvneta.c                                         |   18 
 drivers/net/ethernet/marvell/mvneta_bm.c                                      |   72 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                           |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c                         |    4 
 drivers/net/ethernet/mellanox/mlxsw/core.c                                    |    4 
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c                              |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c                           |    2 
 drivers/net/ethernet/pensando/ionic/ionic_dev.c                               |    2 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                               |    8 
 drivers/net/ethernet/pensando/ionic/ionic_main.c                              |   17 
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c                              |    3 
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c                               |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c                        |    2 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                                      |    4 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                             |  116 
 drivers/net/gtp.c                                                             |    7 
 drivers/net/macsec.c                                                          |    5 
 drivers/net/macvlan.c                                                         |    3 
 drivers/net/netdevsim/bpf.c                                                   |   11 
 drivers/net/ppp/ppp_generic.c                                                 |    1 
 drivers/net/ppp/pppoe.c                                                       |   25 
 drivers/net/team/team.c                                                       |   11 
 drivers/net/tun.c                                                             |   18 
 drivers/net/usb/cdc_mbim.c                                                    |    5 
 drivers/net/usb/cdc_ncm.c                                                     |    7 
 drivers/net/usb/lan78xx.c                                                     |    9 
 drivers/net/usb/pegasus.c                                                     |   16 
 drivers/net/usb/qmi_wwan.c                                                    |    1 
 drivers/net/usb/rtl8150.c                                                     |    4 
 drivers/net/usb/usbnet.c                                                      |   47 
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
 drivers/net/wireless/ath/carl9170/debug.c                                     |    5 
 drivers/net/wireless/broadcom/b43/debugfs.c                                   |    2 
 drivers/net/wireless/broadcom/b43/main.c                                      |    5 
 drivers/net/wireless/broadcom/b43legacy/debugfs.c                             |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c                   |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c                     |   49 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c                  |    2 
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c                                   |    4 
 drivers/net/wireless/mediatek/mt76/mt76.h                                     |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/main.c                              |   74 
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c                               |   24 
 drivers/net/wireless/mediatek/mt76/mt7615/init.c                              |   15 
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                               |   20 
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h                            |    2 
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c                          |    1 
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c                          |    1 
 drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c                           |    1 
 drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c                           |    1 
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                              |   33 
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c                              |   23 
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h                              |    2 
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c                          |    1 
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c                           |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                               |   15 
 drivers/net/wireless/mediatek/mt76/usb.c                                      |   16 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c                         |   22 
 drivers/net/wireless/realtek/rtlwifi/pci.c                                    |   39 
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c                           |    6 
 drivers/net/wireless/realtek/rtw88/debug.c                                    |    5 
 drivers/net/wireless/realtek/rtw88/mac80211.c                                 |    2 
 drivers/net/wireless/rsi/rsi_91x_core.c                                       |    2 
 drivers/net/xen-netback/netback.c                                             |    9 
 drivers/net/xen-netback/xenbus.c                                              |    8 
 drivers/nfc/nfcmrvl/spi.c                                                     |    4 
 drivers/nfc/nxp-nci/i2c.c                                                     |    4 
 drivers/nvme/host/core.c                                                      |   11 
 drivers/nvme/host/fc.c                                                        |    2 
 drivers/nvme/host/nvme.h                                                      |    6 
 drivers/nvme/host/pci.c                                                       |    6 
 drivers/nvme/host/rdma.c                                                      |    1 
 drivers/nvme/host/tcp.c                                                       |   34 
 drivers/nvme/host/zns.c                                                       |    8 
 drivers/nvme/target/admin-cmd.c                                               |   16 
 drivers/nvme/target/configfs.c                                                |   95 
 drivers/nvme/target/core.c                                                    |   17 
 drivers/nvme/target/fc.c                                                      |   16 
 drivers/nvme/target/io-cmd-bdev.c                                             |    5 
 drivers/nvme/target/io-cmd-file.c                                             |    4 
 drivers/nvme/target/loop.c                                                    |   10 
 drivers/nvme/target/nvmet.h                                                   |    8 
 drivers/nvme/target/rdma.c                                                    |   25 
 drivers/nvme/target/tcp.c                                                     |    7 
 drivers/nvmem/rockchip-otp.c                                                  |   13 
 drivers/of/fdt.c                                                              |    3 
 drivers/opp/of.c                                                              |    2 
 drivers/parisc/eisa_enumerator.c                                              |   15 
 drivers/pci/ats.c                                                             |    7 
 drivers/pci/controller/cadence/pcie-cadence-plat.c                            |   38 
 drivers/pci/controller/dwc/pcie-designware.c                                  |    7 
 drivers/pci/controller/dwc/pcie-designware.h                                  |    1 
 drivers/pci/controller/pci-xgene.c                                            |   11 
 drivers/pci/controller/pcie-rockchip-host.c                                   |   16 
 drivers/pci/controller/pcie-rockchip.c                                        |   14 
 drivers/pci/controller/pcie-rockchip.h                                        |    1 
 drivers/pci/controller/vmd.c                                                  |    3 
 drivers/pci/hotplug/pciehp_core.c                                             |    2 
 drivers/pci/iov.c                                                             |   25 
 drivers/pci/pci-label.c                                                       |   24 
 drivers/pci/pci.h                                                             |    4 
 drivers/pci/pcie/Kconfig                                                      |    9 
 drivers/pci/pcie/aer.c                                                        |  103 
 drivers/pci/pcie/portdrv_core.c                                               |   28 
 drivers/pci/probe.c                                                           |   15 
 drivers/pci/quirks.c                                                          |    4 
 drivers/pci/xen-pcifront.c                                                    |   57 
 drivers/perf/xgene_pmu.c                                                      |    4 
 drivers/phy/phy-core.c                                                        |   42 
 drivers/pinctrl/mediatek/pinctrl-mt7629.c                                     |    2 
 drivers/pinctrl/sprd/pinctrl-sprd.c                                           |    3 
 drivers/platform/olpc/olpc-ec.c                                               |    2 
 drivers/platform/x86/Kconfig                                                  |   50 
 drivers/platform/x86/Makefile                                                 |    6 
 drivers/platform/x86/asus-nb-wmi.c                                            |    1 
 drivers/platform/x86/asus-wmi.c                                               |   11 
 drivers/platform/x86/hp-wireless.c                                            |  102 
 drivers/platform/x86/hp-wmi.c                                                 | 1048 
 drivers/platform/x86/hp/Kconfig                                               |   61 
 drivers/platform/x86/hp/Makefile                                              |   10 
 drivers/platform/x86/hp/hp-wmi.c                                              | 1052 
 drivers/platform/x86/hp/hp_accel.c                                            |  453 
 drivers/platform/x86/hp/tc1100-wmi.c                                          |  265 
 drivers/platform/x86/hp_accel.c                                               |  453 
 drivers/platform/x86/ibm_rtl.c                                                |    8 
 drivers/platform/x86/intel_telemetry_core.c                                   |    4 
 drivers/platform/x86/tc1100-wmi.c                                             |  265 
 drivers/platform/x86/wireless-hotkey.c                                        |  103 
 drivers/power/reset/piix4-poweroff.c                                          |    1 
 drivers/power/supply/Kconfig                                                  |    2 
 drivers/power/supply/ab8500-bm.h                                              |  467 
 drivers/power/supply/ab8500_bmdata.c                                          |    3 
 drivers/power/supply/ab8500_btemp.c                                           |  237 
 drivers/power/supply/ab8500_charger.c                                         |  429 
 drivers/power/supply/ab8500_fg.c                                              |  258 
 drivers/power/supply/abx500_chargalg.c                                        |  151 
 drivers/power/supply/bq24190_charger.c                                        |    9 
 drivers/power/supply/bq2515x_charger.c                                        |   15 
 drivers/power/supply/generic-adc-battery.c                                    |    2 
 drivers/power/supply/gpio-charger.c                                           |    5 
 drivers/power/supply/ltc2941-battery-gauge.c                                  |    3 
 drivers/power/supply/pm2301_charger.c                                         |    2 
 drivers/power/supply/power_supply_core.c                                      |   81 
 drivers/pwm/pwm-lp3943.c                                                      |   22 
 drivers/pwm/pwm-renesas-tpu.c                                                 |  283 
 drivers/pwm/pwm-tiehrpwm.c                                                    |    3 
 drivers/rapidio/devices/rio_mport_cdev.c                                      |    5 
 drivers/regulator/ab8500.c                                                    |  159 
 drivers/regulator/core.c                                                      |    4 
 drivers/regulator/fixed.c                                                     |    4 
 drivers/regulator/mp886x.c                                                    |   45 
 drivers/remoteproc/qcom_q6v5_adsp.c                                           |    2 
 drivers/remoteproc/remoteproc_core.c                                          |    3 
 drivers/remoteproc/remoteproc_elf_loader.c                                    |   23 
 drivers/rpmsg/mtk_rpmsg.c                                                     |    1 
 drivers/rtc/Kconfig                                                           |   21 
 drivers/rtc/class.c                                                           |    8 
 drivers/rtc/rtc-ab-eoz9.c                                                     |    1 
 drivers/rtc/rtc-abx80x.c                                                      |    6 
 drivers/rtc/rtc-bd70528.c                                                     |    5 
 drivers/rtc/rtc-brcmstb-waketimer.c                                           |    1 
 drivers/rtc/rtc-cmos.c                                                        |    6 
 drivers/rtc/rtc-ds1307.c                                                      |    2 
 drivers/rtc/rtc-ds1685.c                                                      |   20 
 drivers/rtc/rtc-ftrtc010.c                                                    |    5 
 drivers/rtc/rtc-s35390a.c                                                     |   31 
 drivers/s390/block/dasd.c                                                     |   10 
 drivers/s390/char/vmcp.c                                                      |    4 
 drivers/scsi/aic7xxx/aic7xxx_core.c                                           |    8 
 drivers/scsi/aic7xxx/aic7xxx_pci.c                                            |   20 
 drivers/scsi/dc395x.c                                                         |   10 
 drivers/scsi/ibmvscsi/ibmvfc.c                                                |   10 
 drivers/scsi/libiscsi_tcp.c                                                   |    3 
 drivers/scsi/libsas/sas_task.c                                                |    2 
 drivers/scsi/pm8001/pm8001_defs.h                                             |   98 
 drivers/scsi/pm8001/pm8001_hwi.c                                              |    2 
 drivers/scsi/pm8001/pm8001_hwi.h                                              |    4 
 drivers/scsi/pm8001/pm80xx_hwi.c                                              |    2 
 drivers/scsi/pm8001/pm80xx_hwi.h                                              |  100 
 drivers/scsi/qla2xxx/qla_os.c                                                 |   15 
 drivers/scsi/scsi_debug.c                                                     |    4 
 drivers/scsi/snic/snic_main.c                                                 |    1 
 drivers/scsi/st.c                                                             |   75 
 drivers/scsi/ufs/ufs_bsg.c                                                    |    6 
 drivers/scsi/ufs/ufshcd.c                                                     |    9 
 drivers/sh/intc/core.c                                                        |   11 
 drivers/sh/maple/maple.c                                                      |    4 
 drivers/slimbus/messaging.c                                                   |    2 
 drivers/soc/fsl/dpio/dpio-driver.c                                            |    9 
 drivers/soc/ixp4xx/ixp4xx-qmgr.c                                              |    1 
 drivers/soc/tegra/flowctrl.c                                                  |    7 
 drivers/spi/spi-bcm-qspi.c                                                    |    3 
 drivers/spi/spi-jcore.c                                                       |    5 
 drivers/spi/spi-mtk-nor.c                                                     |    1 
 drivers/spi/spi-mxic.c                                                        |    8 
 drivers/spi/spi-npcm-fiu.c                                                    |    8 
 drivers/spi/spi-omap2-mcspi.c                                                 |    2 
 drivers/spi/spi-rspi.c                                                        |   88 
 drivers/spi/spi-sh-msiof.c                                                    |   50 
 drivers/spi/spi-sun4i.c                                                       |   26 
 drivers/spi/spi-zynq-qspi.c                                                   |    6 
 drivers/staging/comedi/drivers/addi_apci_3xxx.c                               |    2 
 drivers/staging/comedi/drivers/aio_iiro_16.c                                  |    3 
 drivers/staging/comedi/drivers/comedi_parport.c                               |    3 
 drivers/staging/comedi/drivers/das6402.c                                      |   10 
 drivers/staging/comedi/drivers/dmm32at.c                                      |    3 
 drivers/staging/comedi/drivers/dt2811.c                                       |    9 
 drivers/staging/comedi/drivers/dt2814.c                                       |    3 
 drivers/staging/comedi/drivers/ni_at_a2150.c                                  |   13 
 drivers/staging/comedi/drivers/ni_atmio16d.c                                  |    7 
 drivers/staging/comedi/drivers/pcl711.c                                       |    3 
 drivers/staging/comedi/drivers/pcl816.c                                       |    3 
 drivers/staging/comedi/drivers/pcl818.c                                       |    3 
 drivers/staging/comedi/drivers/pcmmio.c                                       |    6 
 drivers/staging/comedi/drivers/pcmuio.c                                       |   10 
 drivers/staging/comedi/drivers/quatech_daqp_cs.c                              |    4 
 drivers/staging/greybus/uart.c                                                |   30 
 drivers/staging/iio/adc/ad7816.c                                              |    6 
 drivers/staging/media/imx/imx-media-csc-scaler.c                              |    1 
 drivers/staging/media/meson/vdec/vdec.c                                       |    2 
 drivers/staging/octeon/ethernet-tx.c                                          |    2 
 drivers/staging/rtl8723bs/core/rtw_recv.c                                     |   25 
 drivers/staging/rtl8723bs/hal/sdio_ops.c                                      |    7 
 drivers/staging/sm750fb/sm750.c                                               |   10 
 drivers/target/target_core_device.c                                           |   18 
 drivers/target/target_core_fabric_lib.c                                       |   10 
 drivers/target/target_core_tpg.c                                              |   10 
 drivers/thermal/intel/intel_powerclamp.c                                      |    3 
 drivers/thermal/sprd_thermal.c                                                |    6 
 drivers/thermal/ti-soc-thermal/ti-bandgap.c                                   |   10 
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c                            |    4 
 drivers/thunderbolt/icm.c                                                     |    6 
 drivers/tty/serial/8250/8250_exar.c                                           |   27 
 drivers/tty/serial/8250/8250_lpss.c                                           |    7 
 drivers/tty/serial/max310x.c                                                  |  342 
 drivers/tty/serial/pch_uart.c                                                 |    5 
 drivers/tty/serial/pmac_zilog.c                                               |    5 
 drivers/tty/serial/sc16is7xx.c                                                |    2 
 drivers/tty/serial/serial-tegra.c                                             |    7 
 drivers/tty/serial/serial_core.c                                              |    7 
 drivers/tty/serial/sifive.c                                                   |    2 
 drivers/uio/uio_sercos3.c                                                     |    1 
 drivers/usb/class/cdc-acm.c                                                   |    6 
 drivers/usb/gadget/composite.c                                                |    2 
 drivers/usb/gadget/configfs.c                                                 |    4 
 drivers/usb/gadget/function/f_mass_storage.c                                  |    7 
 drivers/usb/gadget/legacy/inode.c                                             |   24 
 drivers/usb/gadget/udc/dummy_hcd.c                                            |    4 
 drivers/usb/gadget/udc/fotg210-udc.c                                          |   17 
 drivers/usb/gadget/udc/fsl_qe_udc.c                                           |    8 
 drivers/usb/host/pci-quirks.c                                                 |    1 
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
 drivers/usb/typec/tcpm/tcpm.c                                                 |    9 
 drivers/usb/typec/ucsi/ucsi_ccg.c                                             |   33 
 drivers/vhost/vringh.c                                                        |   27 
 drivers/video/backlight/lm3630a_bl.c                                          |    2 
 drivers/video/backlight/qcom-wled.c                                           |   35 
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
 drivers/video/fbdev/smscufx.c                                                 |    6 
 drivers/video/fbdev/udlfb.c                                                   |   33 
 drivers/virtio/virtio_balloon.c                                               |    6 
 drivers/w1/masters/ds2482.c                                                   |    8 
 drivers/xen/gntdev-dmabuf.c                                                   |    4 
 drivers/xen/gntdev.c                                                          |    7 
 fs/9p/v9fs.c                                                                  |   16 
 fs/9p/vfs_inode.c                                                             |    8 
 fs/affs/bitmap.c                                                              |    2 
 fs/afs/rxrpc.c                                                                |   34 
 fs/aio.c                                                                      |   18 
 fs/btrfs/ctree.h                                                              |    2 
 fs/btrfs/ioctl.c                                                              |   11 
 fs/btrfs/qgroup.c                                                             |    4 
 fs/btrfs/relocation.c                                                         |   11 
 fs/btrfs/sysfs.c                                                              |    1 
 fs/ceph/addr.c                                                                |    3 
 fs/ceph/caps.c                                                                |    2 
 fs/ceph/dir.c                                                                 |   14 
 fs/ceph/inode.c                                                               |    3 
 fs/ceph/mds_client.c                                                          |   26 
 fs/ceph/mdsmap.c                                                              |    4 
 fs/ceph/snap.c                                                                |    7 
 fs/ceph/super.c                                                               |    9 
 fs/ceph/super.h                                                               |    1 
 fs/ceph/xattr.c                                                               |   10 
 fs/cifs/cifsfs.c                                                              |   20 
 fs/cifs/cifsglob.h                                                            |    2 
 fs/cifs/cifssmb.c                                                             |  254 
 fs/cifs/connect.c                                                             |   33 
 fs/cifs/readdir.c                                                             |    3 
 fs/cifs/smb2ops.c                                                             |   35 
 fs/cifs/smb2pdu.c                                                             |   35 
 fs/coredump.c                                                                 |    4 
 fs/dcache.c                                                                   |   65 
 fs/dlm/lowcomms.c                                                             |    6 
 fs/eventpoll.c                                                                |   18 
 fs/exec.c                                                                     |   28 
 fs/exfat/dir.c                                                                |    8 
 fs/ext4/balloc.c                                                              |    6 
 fs/ext4/ext4.h                                                                |    5 
 fs/ext4/extents.c                                                             |   26 
 fs/ext4/indirect.c                                                            |   17 
 fs/ext4/inode.c                                                               |   13 
 fs/ext4/namei.c                                                               |   11 
 fs/ext4/super.c                                                               |   14 
 fs/f2fs/compress.c                                                            |   10 
 fs/f2fs/data.c                                                                |    9 
 fs/f2fs/file.c                                                                |    6 
 fs/f2fs/gc.c                                                                  |    9 
 fs/f2fs/node.c                                                                |   42 
 fs/f2fs/segment.c                                                             |    2 
 fs/f2fs/super.c                                                               |   30 
 fs/fat/fat.h                                                                  |    2 
 fs/fat/fatent.c                                                               |   21 
 fs/fat/file.c                                                                 |    3 
 fs/fat/inode.c                                                                |    2 
 fs/fat/misc.c                                                                 |    6 
 fs/fat/namei_msdos.c                                                          |    3 
 fs/fs_pin.c                                                                   |    9 
 fs/fuse/file.c                                                                |   12 
 fs/fuse/virtio_fs.c                                                           |   80 
 fs/gfs2/bmap.c                                                                |    2 
 fs/gfs2/glops.c                                                               |    8 
 fs/gfs2/inode.c                                                               |    2 
 fs/hfs/btree.c                                                                |    7 
 fs/hfsplus/btree.c                                                            |    7 
 fs/hfsplus/extents.c                                                          |    2 
 fs/hugetlbfs/inode.c                                                          |    2 
 fs/inode.c                                                                    |   15 
 fs/iomap/buffered-io.c                                                        |    3 
 fs/isofs/dir.c                                                                |    4 
 fs/isofs/inode.c                                                              |    2 
 fs/isofs/isofs.h                                                              |   13 
 fs/isofs/joliet.c                                                             |   27 
 fs/isofs/namei.c                                                              |    3 
 fs/isofs/rock.c                                                               |   11 
 fs/jbd2/journal.c                                                             |    2 
 fs/lockd/svclock.c                                                            |    2 
 fs/namespace.c                                                                |    2 
 fs/nfs/blocklayout/blocklayout.h                                              |    5 
 fs/nfs/blocklayout/rpc_pipefs.c                                               |   79 
 fs/nfs/callback_xdr.c                                                         |    9 
 fs/nfs/dir.c                                                                  |   13 
 fs/nfs/filelayout/filelayout.c                                                |   13 
 fs/nfs/flexfilelayout/flexfilelayout.c                                        |   25 
 fs/nfs/internal.h                                                             |    1 
 fs/nfs/netns.h                                                                |    5 
 fs/nfs/nfs3proc.c                                                             |    8 
 fs/nfs/nfs4_fs.h                                                              |    2 
 fs/nfs/nfs4proc.c                                                             |   13 
 fs/nfs/nfs4state.c                                                            |   38 
 fs/nfs/pnfs.c                                                                 |    2 
 fs/nfs/proc.c                                                                 |    8 
 fs/nfsd/blocklayout.c                                                         |    4 
 fs/nfsd/flexfilelayout.c                                                      |   24 
 fs/nfsd/flexfilelayoutxdr.c                                                   |    4 
 fs/nfsd/flexfilelayoutxdr.h                                                   |    5 
 fs/nfsd/nfs4idmap.c                                                           |    4 
 fs/nfsd/nfs4layouts.c                                                         |    7 
 fs/nfsd/nfs4proc.c                                                            |    6 
 fs/nfsd/nfs4recover.c                                                         |   77 
 fs/nfsd/nfs4state.c                                                           |   40 
 fs/nfsd/nfs4xdr.c                                                             |   26 
 fs/nfsd/nfsctl.c                                                              |   12 
 fs/nfsd/pnfs.h                                                                |    4 
 fs/nfsd/xdr4.h                                                                |    1 
 fs/nilfs2/dir.c                                                               |   34 
 fs/nilfs2/inode.c                                                             |   10 
 fs/nilfs2/ioctl.c                                                             |    2 
 fs/nilfs2/mdt.c                                                               |    6 
 fs/nilfs2/namei.c                                                             |    8 
 fs/nilfs2/page.c                                                              |   50 
 fs/nilfs2/page.h                                                              |    4 
 fs/nilfs2/recovery.c                                                          |   19 
 fs/nilfs2/segment.c                                                           |   10 
 fs/nilfs2/sysfs.c                                                             |    5 
 fs/nilfs2/the_nilfs.c                                                         |   34 
 fs/notify/fanotify/fanotify.c                                                 |    7 
 fs/notify/fanotify/fanotify.h                                                 |   21 
 fs/notify/inotify/inotify_fsnotify.c                                          |    2 
 fs/ocfs2/alloc.c                                                              |   18 
 fs/ocfs2/cluster/heartbeat.c                                                  |   51 
 fs/ocfs2/cluster/netdebug.c                                                   |    4 
 fs/ocfs2/cluster/nodemanager.c                                                |   10 
 fs/ocfs2/cluster/quorum.c                                                     |    7 
 fs/ocfs2/cluster/quorum.h                                                     |    1 
 fs/ocfs2/cluster/tcp.c                                                        |   13 
 fs/ocfs2/dcache.h                                                             |    5 
 fs/ocfs2/dlm/dlmconvert.c                                                     |   10 
 fs/ocfs2/dlm/dlmdebug.c                                                       |    5 
 fs/ocfs2/dlm/dlmlock.c                                                        |    8 
 fs/ocfs2/dlm/dlmmaster.c                                                      |   70 
 fs/ocfs2/dlmglue.c                                                            |   97 
 fs/ocfs2/dlmglue.h                                                            |    5 
 fs/ocfs2/export.c                                                             |   10 
 fs/ocfs2/file.c                                                               |  102 
 fs/ocfs2/filecheck.c                                                          |    7 
 fs/ocfs2/inode.c                                                              |    5 
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
 fs/overlayfs/copy_up.c                                                        |   29 
 fs/overlayfs/dir.c                                                            |   14 
 fs/overlayfs/export.c                                                         |    4 
 fs/overlayfs/file.c                                                           |    4 
 fs/overlayfs/inode.c                                                          |   14 
 fs/overlayfs/namei.c                                                          |   15 
 fs/overlayfs/overlayfs.h                                                      |    4 
 fs/overlayfs/readdir.c                                                        |   68 
 fs/overlayfs/super.c                                                          |   17 
 fs/overlayfs/util.c                                                           |    2 
 fs/proc/base.c                                                                |    9 
 fs/proc/generic.c                                                             |   11 
 fs/proc/internal.h                                                            |   15 
 fs/proc/namespaces.c                                                          |    3 
 fs/proc/proc_sysctl.c                                                         |   17 
 fs/pstore/ram.c                                                               |    1 
 fs/pstore/ram_core.c                                                          |    6 
 fs/read_write.c                                                               |    8 
 fs/romfs/super.c                                                              |    8 
 fs/splice.c                                                                   |  137 
 fs/udf/balloc.c                                                               |   11 
 fs/udf/inode.c                                                                |   47 
 fs/udf/super.c                                                                |   45 
 fs/udf/truncate.c                                                             |    7 
 fs/ufs/cylinder.c                                                             |   31 
 fs/ufs/dir.c                                                                  |    2 
 fs/userfaultfd.c                                                              |   16 
 fs/verity/fsverity_private.h                                                  |    7 
 fs/verity/measure.c                                                           |   10 
 fs/verity/open.c                                                              |  148 
 fs/xfs/libxfs/xfs_attr_leaf.c                                                 |   13 
 fs/xfs/libxfs/xfs_bmap.c                                                      |   12 
 fs/xfs/libxfs/xfs_bmap.h                                                      |   10 
 fs/xfs/libxfs/xfs_btree.c                                                     |    4 
 fs/xfs/libxfs/xfs_da_btree.c                                                  |   13 
 fs/xfs/scrub/attr.c                                                           |   18 
 fs/xfs/scrub/bmap.c                                                           |    7 
 fs/xfs/scrub/btree.c                                                          |   16 
 fs/xfs/scrub/common.c                                                         |    7 
 fs/xfs/scrub/dabtree.c                                                        |   27 
 fs/xfs/scrub/dir.c                                                            |   61 
 fs/xfs/scrub/fscounters.c                                                     |    7 
 fs/xfs/scrub/quota.c                                                          |    8 
 fs/xfs/scrub/refcount.c                                                       |   17 
 fs/xfs/xfs_discard.c                                                          |    5 
 fs/xfs/xfs_ioctl32.c                                                          |    4 
 fs/xfs/xfs_iomap.c                                                            |    8 
 fs/xfs/xfs_pnfs.c                                                             |   30 
 include/acpi/acpi_bus.h                                                       |    2 
 include/asm-generic/bitops/le.h                                               |   18 
 include/asm-generic/tlb.h                                                     |    3 
 include/drm/ttm/ttm_bo_api.h                                                  |    2 
 include/kvm/arm_vgic.h                                                        |    1 
 include/linux/acpi.h                                                          |   24 
 include/linux/assoc_array_priv.h                                              |    2 
 include/linux/blk-mq.h                                                        |    3 
 include/linux/can/can-ml.h                                                    |    3 
 include/linux/clocksource.h                                                   |    3 
 include/linux/dcache.h                                                        |    3 
 include/linux/fault-inject.h                                                  |   10 
 include/linux/firewire.h                                                      |    1 
 include/linux/hiddev.h                                                        |    2 
 include/linux/i2c.h                                                           |   17 
 include/linux/intel-iommu.h                                                   |    6 
 include/linux/interrupt.h                                                     |    3 
 include/linux/irqchip/arm-gic-v3.h                                            |    3 
 include/linux/libata.h                                                        |    6 
 include/linux/mfd/abx500/ab8500-bm.h                                          |  476 
 include/linux/mfd/core.h                                                      |   10 
 include/linux/mfd/da9150/core.h                                               |    1 
 include/linux/mfd/twl.h                                                       |   55 
 include/linux/mmu_notifier.h                                                  |   10 
 include/linux/mtd/spinand.h                                                   |    2 
 include/linux/netdevice.h                                                     |    1 
 include/linux/nvme.h                                                          |   11 
 include/linux/pci.h                                                           |    3 
 include/linux/pm_wakeirq.h                                                    |   10 
 include/linux/pm_wakeup.h                                                     |   48 
 include/linux/proc_fs.h                                                       |    2 
 include/linux/property.h                                                      |    3 
 include/linux/shmem_fs.h                                                      |   15 
 include/linux/skbuff.h                                                        |    8 
 include/linux/soc/ti/k3-ringacc.h                                             |   26 
 include/linux/spi/rspi.h                                                      |   18 
 include/linux/string.h                                                        |   40 
 include/linux/timekeeping.h                                                   |    1 
 include/linux/timer.h                                                         |    8 
 include/linux/usb/usbnet.h                                                    |    6 
 include/linux/watch_queue.h                                                   |    6 
 include/net/addrconf.h                                                        |    3 
 include/net/dst.h                                                             |   12 
 include/net/espintcp.h                                                        |    5 
 include/net/inet_frag.h                                                       |    9 
 include/net/ip_tunnels.h                                                      |    3 
 include/net/netfilter/nf_conntrack_seqadj.h                                   |    1 
 include/net/netns/can.h                                                       |    2 
 include/net/netns/ipv6.h                                                      |    4 
 include/net/sch_generic.h                                                     |   13 
 include/net/sctp/sm.h                                                         |    1 
 include/sound/control.h                                                       |    2 
 include/sound/core.h                                                          |    3 
 include/sound/hwdep.h                                                         |    1 
 include/sound/pcm_oss.h                                                       |    1 
 include/sound/soc-component.h                                                 |    2 
 include/trace/events/rpcrdma.h                                                |   32 
 include/trace/events/thermal.h                                                |    4 
 include/uapi/linux/firewire-cdev.h                                            |    4 
 include/video/maxinefb.h                                                      |    4 
 init/Kconfig                                                                  |   13 
 init/main.c                                                                   |    8 
 io_uring/io-wq.c                                                              |    8 
 io_uring/io_uring.c                                                           |    2 
 ipc/mqueue.c                                                                  |    7 
 kernel/bpf/bpf_iter.c                                                         |    7 
 kernel/bpf/btf.c                                                              |   20 
 kernel/cgroup/cpuset.c                                                        |   17 
 kernel/cpu_pm.c                                                               |    9 
 kernel/debug/gdbstub.c                                                        |   59 
 kernel/fork.c                                                                 |   29 
 kernel/irq/internals.h                                                        |    2 
 kernel/irq/irqdomain.c                                                        |    4 
 kernel/irq/manage.c                                                           |   86 
 kernel/kcov.c                                                                 |    8 
 kernel/kcsan/core.c                                                           |    7 
 kernel/kexec_file.c                                                           |    4 
 kernel/nsproxy.c                                                              |    2 
 kernel/profile.c                                                              |    2 
 kernel/rcu/rcutorture.c                                                       |    2 
 kernel/reboot.c                                                               |    4 
 kernel/resource.c                                                             |   11 
 kernel/sched/cpufreq_schedutil.c                                              |   14 
 kernel/sched/fair.c                                                           |    7 
 kernel/signal.c                                                               |    5 
 kernel/sys.c                                                                  |    3 
 kernel/sysctl.c                                                               |   11 
 kernel/time/Kconfig                                                           |   16 
 kernel/time/Makefile                                                          |    3 
 kernel/time/clocksource-wdtest.c                                              |  202 
 kernel/time/clocksource.c                                                     |    6 
 kernel/time/itimer.c                                                          |    2 
 kernel/time/namespace.c                                                       |    2 
 kernel/time/posix-cpu-timers.c                                                |    4 
 kernel/time/posix-stubs.c                                                     |    4 
 kernel/time/posix-timers.c                                                    |   18 
 kernel/time/tick-legacy.c                                                     |   19 
 kernel/time/time_test.c                                                       |   98 
 kernel/time/timeconv.c                                                        |  132 
 kernel/time/timekeeping.c                                                     |    3 
 kernel/time/timer.c                                                           |   55 
 kernel/trace/trace_events_hist.c                                              |   25 
 kernel/trace/trace_events_synth.c                                             |   10 
 kernel/trace/trace_synth.h                                                    |    1 
 kernel/watch_queue.c                                                          |    2 
 lib/842/842_decompress.c                                                      |    7 
 lib/Kconfig.debug                                                             |   12 
 lib/assoc_array.c                                                             |  377 
 lib/cmdline.c                                                                 |   13 
 lib/decompress_bunzip2.c                                                      |    6 
 lib/decompress_unlz4.c                                                        |    4 
 lib/fault-inject.c                                                            |    7 
 lib/klist.c                                                                   |   16 
 lib/kobject_uevent.c                                                          |    8 
 lib/raid6/avx2.c                                                              |    6 
 lib/raid6/avx512.c                                                            |    6 
 lib/raid6/recov_avx2.c                                                        |    2 
 lib/raid6/recov_avx512.c                                                      |    2 
 lib/test_hmm.c                                                                |    2 
 mm/Kconfig                                                                    |   15 
 mm/Makefile                                                                   |    2 
 mm/filemap.c                                                                  |   62 
 mm/gup.c                                                                      |    9 
 mm/gup_benchmark.c                                                            |  210 
 mm/gup_test.c                                                                 |  213 
 mm/huge_memory.c                                                              |    8 
 mm/hugetlb.c                                                                  |   24 
 mm/khugepaged.c                                                               |    2 
 mm/ksm.c                                                                      |   31 
 mm/madvise.c                                                                  |   18 
 mm/memfd.c                                                                    |    2 
 mm/memory.c                                                                   |   41 
 mm/mempolicy.c                                                                |    4 
 mm/migrate.c                                                                  |    2 
 mm/mlock.c                                                                    |    2 
 mm/mmap.c                                                                     |   21 
 mm/mmu_notifier.c                                                             |   24 
 mm/mremap.c                                                                   |    6 
 mm/nommu.c                                                                    |    6 
 mm/page_alloc.c                                                               |   12 
 mm/page_vma_mapped.c                                                          |   22 
 mm/shmem.c                                                                    |   13 
 mm/swapfile.c                                                                 |    4 
 mm/util.c                                                                     |   13 
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
 net/bluetooth/hci_core.c                                                      |  128 
 net/bluetooth/hci_debugfs.c                                                   |  182 
 net/bluetooth/hci_debugfs.h                                                   |    5 
 net/bluetooth/l2cap_core.c                                                    |   95 
 net/bluetooth/l2cap_sock.c                                                    |    4 
 net/bluetooth/selftest.c                                                      |    1 
 net/bluetooth/smp.c                                                           |   45 
 net/bluetooth/smp.h                                                           |    2 
 net/bridge/netfilter/ebtables.c                                               |   12 
 net/can/af_can.c                                                              |   49 
 net/can/bcm.c                                                                 |   50 
 net/can/gw.c                                                                  |    7 
 net/can/isotp.c                                                               |  222 
 net/can/proc.c                                                                |   69 
 net/can/raw.c                                                                 |  174 
 net/ceph/mon_client.c                                                         |    2 
 net/ceph/osd_client.c                                                         |   13 
 net/ceph/osdmap.c                                                             |   18 
 net/core/bpf_sk_storage.c                                                     |    2 
 net/core/dev.c                                                                |   22 
 net/core/filter.c                                                             |   33 
 net/core/skbuff.c                                                             |   22 
 net/core/sock.c                                                               |    9 
 net/dcb/dcbnl.c                                                               |    2 
 net/ipv4/af_inet.c                                                            |    3 
 net/ipv4/gre_offload.c                                                        |    2 
 net/ipv4/icmp.c                                                               |   10 
 net/ipv4/inet_fragment.c                                                      |    4 
 net/ipv4/inet_hashtables.c                                                    |    5 
 net/ipv4/ip_fragment.c                                                        |   10 
 net/ipv4/ip_tunnel.c                                                          |   14 
 net/ipv4/ipmr.c                                                               |   11 
 net/ipv4/metrics.c                                                            |    5 
 net/ipv4/netfilter/nf_reject_ipv4.c                                           |   11 
 net/ipv4/route.c                                                              |    5 
 net/ipv4/syncookies.c                                                         |    2 
 net/ipv4/tcp_bic.c                                                            |   14 
 net/ipv4/tcp_cong.c                                                           |    4 
 net/ipv4/tcp_hybla.c                                                          |   16 
 net/ipv4/tcp_input.c                                                          |    4 
 net/ipv4/tcp_output.c                                                         |    2 
 net/ipv6/addrconf.c                                                           |   54 
 net/ipv6/calipso.c                                                            |    6 
 net/ipv6/datagram.c                                                           |    4 
 net/ipv6/inet6_hashtables.c                                                   |    4 
 net/ipv6/ip6_offload.c                                                        |    4 
 net/ipv6/ip6mr.c                                                              |   11 
 net/ipv6/netfilter/nf_conntrack_reasm.c                                       |    2 
 net/ipv6/netfilter/nf_reject_ipv6.c                                           |   13 
 net/ipv6/raw.c                                                                |    3 
 net/ipv6/reassembly.c                                                         |    1 
 net/ipv6/route.c                                                              |   13 
 net/ipv6/sit.c                                                                |    4 
 net/iucv/af_iucv.c                                                            |   41 
 net/l2tp/l2tp_core.c                                                          |   47 
 net/l2tp/l2tp_core.h                                                          |    5 
 net/l2tp/l2tp_debugfs.c                                                       |    4 
 net/l2tp/l2tp_netlink.c                                                       |    9 
 net/l2tp/l2tp_ppp.c                                                           |    7 
 net/mac80211/agg-rx.c                                                         |    5 
 net/mac80211/debugfs.c                                                        |    2 
 net/mac80211/ibss.c                                                           |    4 
 net/mac80211/ieee80211_i.h                                                    |    2 
 net/mac80211/main.c                                                           |    2 
 net/mac80211/mesh_pathtbl.c                                                   |   17 
 net/mac80211/rx.c                                                             |    6 
 net/mac80211/tdls.c                                                           |    3 
 net/mac80211/tx.c                                                             |   57 
 net/netfilter/ipvs/ip_vs_sync.c                                               |   23 
 net/netfilter/nf_conntrack_core.c                                             |    5 
 net/netfilter/nf_conntrack_netlink.c                                          |    8 
 net/netfilter/nf_conntrack_proto_tcp.c                                        |    6 
 net/netfilter/nf_conntrack_seqadj.c                                           |   17 
 net/netfilter/nf_synproxy_core.c                                              |    4 
 net/netfilter/nf_tables_api.c                                                 |    1 
 net/netfilter/nft_compat.c                                                    |   15 
 net/netfilter/nft_meta.c                                                      |    6 
 net/netfilter/nft_rt.c                                                        |    6 
 net/netfilter/nft_xfrm.c                                                      |    9 
 net/netfilter/xt_dccp.c                                                       |    2 
 net/netlink/af_netlink.c                                                      |   12 
 net/openvswitch/actions.c                                                     |    9 
 net/openvswitch/vport-netdev.c                                                |    8 
 net/packet/af_packet.c                                                        |   12 
 net/rds/af_rds.c                                                              |   31 
 net/rds/bind.c                                                                |    4 
 net/rds/ib_cm.c                                                               |    6 
 net/rds/ib_rdma.c                                                             |    4 
 net/rds/ib_recv.c                                                             |   13 
 net/rds/message.c                                                             |   26 
 net/rds/rdma.c                                                                |   63 
 net/rds/rdma_transport.c                                                      |    7 
 net/rds/rds.h                                                                 |   18 
 net/rds/recv.c                                                                |   17 
 net/rds/send.c                                                                |   27 
 net/rds/tcp.c                                                                 |    9 
 net/rds/tcp_recv.c                                                            |    4 
 net/rxrpc/sendmsg.c                                                           |   57 
 net/sched/act_api.c                                                           |   21 
 net/sched/act_ife.c                                                           |    4 
 net/sched/cls_api.c                                                           |    9 
 net/sched/cls_flower.c                                                        |   72 
 net/sched/sch_etf.c                                                           |    1 
 net/sched/sch_generic.c                                                       |   52 
 net/sched/sch_gred.c                                                          |   16 
 net/sched/sch_netem.c                                                         |    5 
 net/sched/sch_qfq.c                                                           |    3 
 net/sched/sch_taprio.c                                                        |   11 
 net/sched/sch_teql.c                                                          |   14 
 net/sctp/associola.c                                                          |    4 
 net/sctp/endpointola.c                                                        |    4 
 net/sctp/sm_make_chunk.c                                                      |   14 
 net/sctp/socket.c                                                             |   83 
 net/smc/smc_rx.c                                                              |   39 
 net/smc/smc_tx.c                                                              |    7 
 net/sunrpc/auth_gss/svcauth_gss.c                                             |   29 
 net/sunrpc/svc.c                                                              |    9 
 net/sunrpc/svc_xprt.c                                                         |   16 
 net/sunrpc/svcauth_unix.c                                                     |    7 
 net/sunrpc/svcsock.c                                                          |    3 
 net/sunrpc/xprtrdma/rpc_rdma.c                                                |   27 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                                      |    3 
 net/sunrpc/xprtrdma/verbs.c                                                   |   27 
 net/tipc/bearer.c                                                             |    4 
 net/tipc/group.c                                                              |   19 
 net/tipc/node.c                                                               |    2 
 net/tipc/socket.c                                                             |   12 
 net/tls/tls_device.c                                                          |   21 
 net/unix/sysctl_net_unix.c                                                    |    4 
 net/wireless/nl80211.c                                                        |   10 
 net/wireless/reg.c                                                            |    3 
 net/wireless/sme.c                                                            |    3 
 net/wireless/wext-sme.c                                                       |    6 
 net/xfrm/espintcp.c                                                           |   41 
 net/xfrm/xfrm_interface_core.c                                                |    8 
 net/xfrm/xfrm_policy.c                                                        |   11 
 scripts/checkkconfigsymbols.py                                                |    2 
 scripts/checkpatch.pl                                                         |    2 
 scripts/extract-cert.c                                                        |  144 
 scripts/kconfig/Makefile                                                      |   10 
 scripts/kconfig/conf.c                                                        |  293 
 scripts/kconfig/confdata.c                                                    |  229 
 scripts/kconfig/expr.h                                                        |    1 
 scripts/kconfig/lexer.l                                                       |    1 
 scripts/kconfig/lkc.h                                                         |   13 
 scripts/kconfig/menu.c                                                        |    9 
 scripts/kconfig/parser.y                                                      |    6 
 scripts/kconfig/symbol.c                                                      |   72 
 scripts/kconfig/tests/conftest.py                                             |   13 
 scripts/kconfig/tests/randconfig_probability/Kconfig                          |   12 
 scripts/kconfig/tests/randconfig_probability/__init__.py                      |  130 
 scripts/kconfig/tests/savedefconfig_range/Kconfig                             |   60 
 scripts/kconfig/tests/savedefconfig_range/__init__.py                         |    8 
 scripts/kconfig/tests/savedefconfig_range/config                              |    7 
 scripts/link-vmlinux.sh                                                       |   19 
 scripts/sign-file.c                                                           |  132 
 scripts/ssl-common.h                                                          |   32 
 security/apparmor/apparmorfs.c                                                |   15 
 security/apparmor/include/label.h                                             |    6 
 security/apparmor/include/policy_ns.h                                         |   16 
 security/apparmor/label.c                                                     |   15 
 security/apparmor/policy.c                                                    |   16 
 security/apparmor/policy_ns.c                                                 |    8 
 security/integrity/ima/ima_template.c                                         |    5 
 security/selinux/netlabel.c                                                   |    1 
 sound/core/compress_offload.c                                                 |   12 
 sound/core/control.c                                                          |    5 
 sound/core/hwdep.c                                                            |   14 
 sound/core/init.c                                                             |   29 
 sound/core/jack.c                                                             |    2 
 sound/core/oss/mixer_oss.c                                                    |   36 
 sound/core/oss/pcm_oss.c                                                      |   12 
 sound/core/pcm.c                                                              |    6 
 sound/core/pcm_compat.c                                                       |    4 
 sound/core/pcm_local.h                                                        |    6 
 sound/core/pcm_native.c                                                       |   20 
 sound/core/rawmidi.c                                                          |    3 
 sound/core/seq/oss/seq_oss_device.h                                           |    1 
 sound/core/seq/oss/seq_oss_event.c                                            |    3 
 sound/core/seq/oss/seq_oss_init.c                                             |    2 
 sound/drivers/aloop.c                                                         |   31 
 sound/drivers/mpu401/mpu401_uart.c                                            |    8 
 sound/isa/sb/emu8000_patch.c                                                  |   13 
 sound/mips/sgio2audio.c                                                       |   13 
 sound/oss/dmasound/dmasound_q40.c                                             |   65 
 sound/pci/cs46xx/dsp_spos.c                                                   |    4 
 sound/pci/cs46xx/dsp_spos_scb_lib.c                                           |    3 
 sound/pci/emu10k1/emu10k1_patch.c                                             |   85 
 sound/pci/hda/hda_codec.c                                                     |    6 
 sound/pci/hda/hda_eld.c                                                       |    6 
 sound/pci/hda/hda_intel.c                                                     |   19 
 sound/pci/hda/hda_jack.c                                                      |    9 
 sound/pci/hda/hda_sysfs.c                                                     |    4 
 sound/pci/hda/patch_conexant.c                                                |    7 
 sound/pci/hda/patch_hdmi.c                                                    |    3 
 sound/pci/hda/patch_realtek.c                                                 |   18 
 sound/pci/hda/patch_via.c                                                     |    1 
 sound/pci/via82xx.c                                                           |   11 
 sound/sh/aica.c                                                               |    2 
 sound/soc/amd/raven/acp3x-pcm-dma.c                                           |    4 
 sound/soc/amd/renoir/acp3x-pdm-dma.c                                          |    2 
 sound/soc/atmel/atmel-i2s.c                                                   |   43 
 sound/soc/atmel/atmel-pcm-pdc.c                                               |    2 
 sound/soc/codecs/adau17x1.c                                                   |    4 
 sound/soc/codecs/ak4642.c                                                     |    3 
 sound/soc/codecs/cs42l56.c                                                    |    1 
 sound/soc/codecs/da732x.c                                                     |    2 
 sound/soc/codecs/hdac_hda.c                                                   |   16 
 sound/soc/codecs/hdac_hdmi.c                                                  |   10 
 sound/soc/codecs/max98926.c                                                   |    2 
 sound/soc/codecs/nau8540.c                                                    |    4 
 sound/soc/codecs/rt1011.c                                                     |    4 
 sound/soc/codecs/rt1016.c                                                     |    4 
 sound/soc/codecs/rt1305.c                                                     |    4 
 sound/soc/codecs/rt1308.c                                                     |    4 
 sound/soc/codecs/rt5616.c                                                     |    3 
 sound/soc/codecs/rt5659.c                                                     |   10 
 sound/soc/codecs/rt5660.c                                                     |    4 
 sound/soc/codecs/rt5665.c                                                     |    4 
 sound/soc/codecs/sta32x.c                                                     |   20 
 sound/soc/codecs/sta350.c                                                     |   20 
 sound/soc/codecs/tlv320aic26.c                                                |    6 
 sound/soc/codecs/tlv320aic32x4-clk.c                                          |   35 
 sound/soc/codecs/tlv320aic32x4.h                                              |    5 
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
 sound/soc/fsl/fsl_asrc.c                                                      |    8 
 sound/soc/fsl/fsl_asrc_dma.c                                                  |    5 
 sound/soc/intel/atom/sst/sst_acpi.c                                           |   14 
 sound/soc/intel/boards/bytcr_rt5651.c                                         |   17 
 sound/soc/mediatek/common/mtk-afe-fe-dai.c                                    |    8 
 sound/soc/mediatek/mt6797/mt6797-afe-clk.c                                    |   14 
 sound/soc/mediatek/mt8183/mt8183-afe-clk.c                                    |   22 
 sound/soc/qcom/qdsp6/q6afe.c                                                  |   10 
 sound/soc/rockchip/rockchip_i2s.c                                             |    4 
 sound/soc/soc-ac97.c                                                          |    4 
 sound/soc/soc-component.c                                                     |    2 
 sound/soc/soc-ops.c                                                           |   10 
 sound/soc/stm/stm32_i2s.c                                                     |   26 
 sound/soc/ti/davinci-mcasp.c                                                  |    1 
 sound/soc/xilinx/xlnx_formatter_pcm.c                                         |   18 
 sound/synth/emux/emux.c                                                       |   16 
 sound/synth/emux/emux_synth.c                                                 |    9 
 sound/synth/emux/soundfont.c                                                  |   71 
 sound/usb/6fire/control.c                                                     |    7 
 sound/usb/bcd2000/bcd2000.c                                                   |   62 
 sound/usb/caiaq/device.c                                                      |    3 
 sound/usb/caiaq/input.c                                                       |   31 
 sound/usb/line6/capture.c                                                     |   49 
 sound/usb/line6/capture.h                                                     |    2 
 sound/usb/line6/pcm.c                                                         |   20 
 sound/usb/line6/playback.c                                                    |   31 
 sound/usb/midi.c                                                              |   26 
 sound/usb/mixer.c                                                             |  116 
 sound/usb/mixer.h                                                             |    5 
 sound/usb/mixer_quirks.c                                                      |    2 
 sound/usb/mixer_us16x08.c                                                     |    3 
 sound/usb/pcm.c                                                               |   20 
 sound/usb/quirks-table.h                                                      |   24 
 sound/usb/usx2y/us122l.c                                                      |   29 
 sound/usb/usx2y/usX2Yhwdep.c                                                  |    4 
 sound/usb/usx2y/usb_stream.c                                                  |   15 
 sound/usb/usx2y/usbusx2yaudio.c                                               |   46 
 sound/usb/usx2y/usx2yhwdeppcm.c                                               |    2 
 sound/x86/intel_hdmi_audio.c                                                  |    9 
 tools/bpf/bpftool/main.c                                                      |   16 
 tools/bpf/bpftool/tracelog.c                                                  |    2 
 tools/include/linux/types.h                                                   |    5 
 tools/lib/api/fd/array.c                                                      |    5 
 tools/lib/bpf/btf.c                                                           |    4 
 tools/lib/bpf/ringbuf.c                                                       |    2 
 tools/lib/perf/mmap.c                                                         |    2 
 tools/perf/Documentation/perf-c2c.txt                                         |    2 
 tools/perf/util/header.c                                                      |   18 
 tools/perf/util/jitdump.c                                                     |  100 
 tools/perf/util/mmap.c                                                        |    3 
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c               |   18 
 tools/testing/selftests/Makefile                                              |    4 
 tools/testing/selftests/arm64/signal/Makefile                                 |    4 
 tools/testing/selftests/clone3/clone3_clear_sighand.c                         |    6 
 tools/testing/selftests/core/Makefile                                         |    2 
 tools/testing/selftests/core/unshare_test.c                                   |  109 
 tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c                 |   32 
 tools/testing/selftests/ftrace/ftracetest                                     |    3 
 tools/testing/selftests/net/Makefile                                          |    2 
 tools/testing/selftests/net/fib_nexthops.sh                                   |   46 
 tools/testing/selftests/net/fin_ack_lat.c                                     |    2 
 tools/testing/selftests/net/tcp_mmap.c                                        |  110 
 tools/testing/selftests/net/txtimestamp.c                                     |   23 
 tools/testing/selftests/netfilter/conntrack_vrf.sh                            |  140 
 tools/testing/selftests/timers/clocksource-switch.c                           |   23 
 tools/testing/selftests/vm/.gitignore                                         |    2 
 tools/testing/selftests/vm/Makefile                                           |    2 
 tools/testing/selftests/vm/config                                             |    2 
 tools/testing/selftests/vm/gup_benchmark.c                                    |  143 
 tools/testing/selftests/vm/gup_test.c                                         |  143 
 tools/testing/selftests/vm/run_vmtests                                        |    8 
 tools/thermal/tmon/tmon.c                                                     |    2 
 usr/gen_init_cpio.c                                                           |    1 
 1513 files changed, 96156 insertions(+), 13387 deletions(-)

Aamir Ahmed (1):
      lib: decompress_bunzip2: fix integer overflow in run-length decoding

Aaron Kling (2):
      dt-bindings: vendor-prefixes: Add Chip Wealth Technology
      dt-bindings: vendor-prefixes: Add Retroid Pocket

Aaron Ma (1):
      HID: quirks: Add ALWAYS_POLL quirk for Beitong BTP-KP20D dongle

Abdelnasser Hussein (1):
      staging: iio: adc: ad7816: Fix DMA safety issues in SPI transfers

Abdifatah Suruur (3):
      smb: client: validate the data area in SMB2_read()
      smb: client: fix fiemap wild read on empty truncated response
      xen/gntdev: prevent private mappings from becoming writable

Abdun Nihaal (1):
      wifi: ath11k: Fix possible memory leak in ath11k_dp_srng_setup()

Abdurrahman Karadag (1):
      wifi: rtw88: debugfs: don't vzalloc(0) when rsvd_page is read unconfigured

Abel Vesa (1):
      clk: qcom: mmcc-msm8996: Fix FD AHB clock register offset

Abhijeeth Babu (1):
      i2c: acpi: Force ELAN1300 touchpads to 100 kHz

Abin Joseph (1):
      dmaengine: zynqmp_dma: Add support for AMD Versal Gen 2 DMA IP

Adam Skladowski (1):
      dt-bindings: vendor-prefixes: Add LeEco

Adi Nata (1):
      iio: humidity: hts221: report available values via read_avail()

Adrian Ambrozewicz (1):
      gpiolib: cdev: don't set GPIOD_FLAG_IS_OUT

Adrián Larumbe (2):
      drm/panfrost: Prevent division by 0
      drm/panfrost: Explicitly enable MMU interrupts at device init

Ahelenia Ziemiańska (3):
      splice: always fsnotify_access(in), fsnotify_modify(out) on success
      splice: fsnotify_access(in), fsnotify_modify(out) on success in tee
      splice: fsnotify_access(fd)/fsnotify_modify(fd) in vmsplice

Ahmad Fatoum (1):
      ARM: dts: stm32: lxa-mc1: change stdout-path baud rate from 9600 to 115200

Ahmed Naseef (1):
      wifi: mt76: mt7615: read MT7663 temperature from the correct offset

Ahsan Atta (1):
      crypto: qat - avoid OOB read when stripping RSA leading zeros

Akhil P Oommen (1):
      drm/msm/a6xx: Fix secondary rail vote in ARC votes

Al Viro (8):
      ufs: fix ufs_read_cylinder() failure handling
      do_splice_to(): move the logics for limiting the read length in
      take the guts of file-to-pipe splice into a helper function
      /proc/sys: use d_splice_alias() calling conventions to simplify failure exits
      procfs: kill ->proc_dops
      new helper: d_splice_alias_ops()
      switch procfs from d_set_d_op() to d_splice_alias_ops()
      selftests:core: test coverage for dup_fd() failure handling in unshare_fd()

Alan Stern (1):
      HID: core: Fix out-of-bounds left shift by 32 in s32ton()

Aldo Ariel Panzardo (9):
      xfs: reject out-of-range attribute value lengths in xfs_attr_copy_value
      xfs: reject remote xattr entries with an out-of-range value length
      nfsd: clear XDR padding in GETXATTR replies
      NFSD: copy SETXATTR data from all XDR buffer segments
      nfsd: propagate SETXATTR value decode errors
      nfsd: zero NFSv4 COMPOUND tag padding
      nilfs2: fix checkpoint root lifetime on sysfs errors
      crypto: nx - validate 'ignore' before subtracting in decompress
      xfs: bound da-node entry count against the correct geometry

Aleksandr Nogikh (2):
      media: usbtv: fix null-pointer dereference on disconnect
      usb: gadget: dummy_hcd: prevent unbind via sysfs

Aleksandrova Alyona (1):
      platform/x86: intel_telemetry: initialize default trace verbosity

Alex Deucher (1):
      drm/amd: Fix UBSAN array-index-out-of-bounds for Powerplay headers

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

Alexei Starovoitov (1):
      bpf: Don't take a program with a target program for an iterator

Alexey Charkov (1):
      nvmem: rockchip-otp: Serialize reads

Ali Alaei (1):
      PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow Lake-HX

Allison Henderson (5):
      net/rds: don't use unpin_user_pages_dirty_lock() from atomic context
      net/rds: unpin MR pages with unpin_user_pages_dirty_lock()
      net/rds: include the scope id in the sendmsg connection cache check
      net/rds: keep the connected peer's scope id apart from the bound one
      net/rds: do not initialize transports after rds_init() failed

Alok Tiwari (1):
      octeontx2-af: Fix CQ enable state tracking after AQ writes

Amadeusz Sławiński (4):
      ALSA: pcm: Fix driver_tstamp value reporting
      ASoC: ops: Fix return value in snd_soc_limit_volume()
      ASoC: soc-ac97: Fix error handling in snd_soc_new_ac97_component()
      ASoC: soc-component: Fix return type of snd_soc_pcm_component_pointer()

Ameer Hamza (2):
      nfsd: don't modify a session slot when replaying its cached reply
      sunrpc: treat empty auth.unix.gid replies as negative entries

Amir Goldstein (2):
      ovl: inherit FMODE_NONOTIFY when opening directory realfiles
      ovl: inherit FMODE_NONOTIFY when reading directory layers

Amit Machhiwal (1):
      KVM: PPC: Fix get_d_signext() 12-bit displacement for paired-single D-form

Anastasios Papagiannis (1):
      mm/nommu: reject wrapping ranges in access_remote_vm()

Andi Shyti (1):
      media: cx231xx: Fix cleanup path on failure

Andre Przywara (1):
      of/fdt: Ignore disabled memory nodes

Andrea Parri (4):
      kcsan: Avoid division by zero in kcsan_prandom_u32_max()
      nvmet-fc: only send read data for successful commands
      pstore: don't leave an ERR_PTR in the ramoops zone pointer
      pstore: reject persistent RAM zones too small for the buffer header

Andreas Kemnade (2):
      fbdev: omap2: dsi: do not copy isr table
      rtc: bd70528: properly enable wakeup

Andreas Wendleder (1):
      wifi: b43: fix use-after-free in b43_bcma_remove()

Andrew Kanner (1):
      selinux: prevent KMSAN warning in selinux_inet_conn_request()

Andrew Morton (1):
      openrisc: export __mulsi3 for modules

Andrew Stellman (1):
      nvmet-rdma: fix out-of-bounds write in nvmet_rdma_map_sgl_inline()

Andrey Misiurov (1):
      fbdev: core: Initialize modelist in framebuffer_alloc()

André Draszik (2):
      kbuild: link-vmlinux.sh: improve detection of third pass requirement
      drm/drm_crtc: ensure dma_fence_ops remain valid during device unbind

Andy Shevchenko (13):
      gpio: pca953x: Utilise temporary variable for struct gpio_chip
      irqchip/gic-v3: Switch to bitmap_zalloc()
      ata: sata_dwc_460ex: Use devm_platform_*ioremap_resource() APIs
      ata: sata_dwc_460ex: Use temporary variable for struct device
      mfd: intel_quark_i2c_gpio: Unregister resources in reversed order
      mfd: intel_quark_i2c_gpio: Remove unused struct device member
      mfd: intel_quark_i2c_gpio: Replace I²C speeds with descriptive definitions
      mfd: intel_quark_i2c_gpio: Reuse BAR definitions for MFD cell indexing
      mfd: intel_quark_i2c_gpio: Enable MSI interrupt
      mfd: intel_quark_i2c_gpio: Don't play dirty trick with const
      mfd: intel_quark_i2c_gpio: Convert I²C to use software nodes
      spi: rspi: Get rid of unused struct rspi_plat_data
      mfd: Remove software node conditionally and locate at right place

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

Anuj Bolewar (1):
      media: hackrf: fix use-after-free in hackrf_alloc_urbs() error path

Anup Vishwakarma (2):
      mailbox: qcom-ipcc: Guard against NULL con_priv in send_data()
      remoteproc: qcom_q6v5_adsp: Fix double jiffies conversion in adsp_start()

Ard Biesheuvel (4):
      arm64/efi: Clear PTE_WRITE when applying EFI_MEMORY_RO
      efi/libstub: Don't replace an existing LINUX_EFI_MEMRESERVE table
      efi/libstub: arm64: Don't use the platform register x18
      crypto: tcrypt - include 1420 byte blocks in aead and skcipher benchmarks

Arka Mondal (5):
      usb-storage: alauda: do not do DMA from the stack
      usb-storage: alauda: check the return value of alauda_read_map()
      usb-storage: alauda: fix out-of-bounds zone index
      iio: dac: ad5758: Reject out-of-range raw values
      iio: dac: ad5758: Fix the offset calculation

Armaan Sandhu (1):
      lib/cmdline: fix get_options() count and overflow with large ranges

Armin Wolf (1):
      hwmon: (acpi_power_meter) Fix 18.45 TW bug

Arnaldo Carvalho de Melo (9):
      perf jitdump: Fix extended header read that always fails
      perf jitdump: Fix debug_data and unwinding_data leaks
      perf jitdump: Validate code_size against total_size in code load
      perf jitdump: Prevent integer underflow in debug info size calculation
      perf jitdump: Bounds-check debug entry byte-swap loop
      perf jitdump: Check snprintf return before computing header size
      perf jitdump: Fix funlockfile on unlocked stream in jit_open() error path
      perf jitdump: Validate debug entries on native (non-swap) path
      perf jitdump: Validate sym string NUL-termination in code load

Arnd Bergmann (2):
      media: v4l2-tpg: reduce stack usage for kasan builds
      timekeeping: add CONFIG_LEGACY_TIMER_TICK

Asad Kamal (2):
      drm/amd/pm: Validate OD DPM triples before mutating tables
      drm/amdgpu: Gate debugfs MMIO access on kernel lockdown

Aurabindo Pillai (1):
      drm/amd: Add DCN6 register headers

Avi Weiss (4):
      rpmsg: mtk: release channel OF node on device teardown
      signal: skip blocked signals in dequeue_synchronous_signal()
      profiling: fix sampling step on 64-bit big-endian systems
      nvmet: prevent double-free after metadata SGL allocation failure

Axel Lin (1):
      regulator: mp886x: Convert to use regulator_set_ramp_delay_regmap

Babanpreet Singh (1):
      regulator: ab8500: Remove stale expand_register kernel-doc entry

Baek Kyu, Kim (2):
      hwmon: (sht3x) Return the consumed count for heater writes
      hwmon: (corsair-cpro) Cache fan target only after a successful command

Balakrishnan Sambath (4):
      media: microchip-isc: fix WB offset and gain register field masking
      media: microchip-isc: synchronize the IRQ before disabling clocks on stop
      media: microchip-isc: don't sleep in the clk .is_enabled callback
      media: microchip-isc: do not touch WB registers when not streaming

Baokun Li (1):
      ext4: reduce max cluster size to match documented 256MB limit

Baolin Liu (1):
      isofs: fix Rock Ridge CE extent validation on multisession media

Bart Van Assche (2):
      blk-iocost: Simplify ioc_rqos_done()
      scsi: pm8001: Fix SATA FIS offset in struct hw_event_resp

Bartosz Golaszewski (1):
      dmaengine: qcom: bam_dma: free interrupt before the clock in error path

Beleswar Padhi (1):
      mailbox: ti-msgmgr: Read exact number of trailing message bytes

Ben Dooks (1):
      mmc: cqhci: fix to missed endian conversions

Benjamin Cheng (1):
      drm/amdgpu/vce: Prevent partial address patches

Benjamin Coddington (5):
      pNFS: Fix CB_NOTIFY_DEVICEID CHANGE to consume ndc_immediate
      NFSv4.1/pnfs: suspend pNFS on NFS4ERR_TOOSMALL from LAYOUTGET
      NFSv4/filelayout: Anchor page coalescing on pattern_offset
      NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before allocating
      NFSv4/flexfiles: fail I/O to the data server once a lock is lost

Benjamin Marzinski (1):
      bitops: make the *_bit_le functions use unsigned long

Bhaskar Chowdhury (1):
      kernel: debug: Ordinary typo fixes in the file gdbstub.c

Binbin Deng (3):
      apparmor: fix a use-after-free in aa_lookupn_ns()
      tipc: fix use-after-free of broadcast reception link at node release
      net: atlantic: Unregister before clearing RXNFC rules

BingKun Yue (1):
      fbdev: platinumfb: add error checking for ioremap calls

Bitterblue Smith (1):
      wifi: rtl8xxxu: Use dev_* instead of pr_info

Bjorn Helgaas (1):
      PM: wakeup: Unify device_init_wakeup() for PM_SLEEP and !PM_SLEEP

Bob Pearson (1):
      RDMA/rxe: Remove unused pkt->offset

Bob Song (1):
      ALSA: hda/realtek: add missing NULL check for codec->bus->pci

Brad Fitzpatrick (1):
      gre: keep the UDP tunnel GSO type when completing GRO

Bradley Morgan (1):
      PM: CPU: Restore synchronize_rcu() to cpu_pm_unregister_notifier()

Breno Leitao (7):
      x86/nmi: Ignore negative NMI handler durations
      mm/shmem: report RCU-tasks quiescent states while undoing a range
      ACPI: APEI: accumulate the queued flag across error sections
      dcache: report a Tasks-RCU quiescent state in dentry_kill()
      kexec_file: stop the top-down search before it underflows
      cpuidle: menu: Remove incorrect unlikely() annotation
      ACPICA: Fix memory leak in acpi_ds_create_field()

Brian Grech (1):
      selftests/net: fin_ack_lat: fix latency threshold typo

Brian Norris (1):
      PCI/portdrv: Allow probing even without child services

Bruno Produit (1):
      hfs/hfsplus: serialize B-tree close against folio release

Bryam Vargas (3):
      net/iucv: fix the recvmsg window update
      net/smc: queue the copied chunk when smc_tx_sendmsg() faults
      net/smc: don't spin in smc_rx_recvmsg() while a pipe holds spliced data

Bryan O'Donoghue (1):
      phy: core: Fix race-condition between _of_phy_get() and try_module_get()

Bui Viet Dung (3):
      Bluetooth: 6lowpan: Pin module for 6lowpan_control debugfs file
      Bluetooth: selftest: Pin module for selftest debugfs file operations
      Bluetooth: hci_debugfs: Pin module for debugfs file operations

Can Peng (2):
      wifi: brcmfmac: Set DMA direction for msgbuf packet IDs
      wifi: brcmfmac: validate msgbuf flowring IDs before use

Cao Guanghui (2):
      md/raid5: track disks array size to fix extra_page leak on error paths
      md/raid5: fix NULL pointer dereference in raid5_free_percpu

Carl Quist (1):
      ALSA: hda/realtek: Enable mute LED on HP Laptop 15-dy0xxx

Carolina Jubran (1):
      IB/IPoIB: Cancel normal flush work on device stop

Cassio Neri (1):
      time: Improve performance of time64_to_tm()

Cen Zhang (26):
      ocfs2: drain quorum work before removing the cluster
      ocfs2: pin owning modules for open debugfs files
      ocfs2: publish the filecheck owner before adding sysfs attributes
      ocfs2/heartbeat: unlink live slots when their node is missing
      ocfs2/dlm: hold a lock reference across grant AST enqueue
      ocfs2: cancel quota sync work before freeing quota info
      ocfs2: pin refcount trees before dropping the lookup lock
      ocfs2: snapshot dentry names in file and setattr traces
      ocfs2: snapshot the dentry name while tracing file release
      ocfs2/cluster: remove zero-address nodes from IP tree on teardown
      ocfs2: keep locking_state within the cluster connection lifetime
      ocfs2/dlm: serialize migration MLE cleanup on failure
      ocfs2: stop recovery before shutting down local allocators
      ocfs2/cluster: unlink socket containers before releasing resources
      ocfs2: wait for filecheck kobject release after a failed add
      ocfs2/cluster: initialize heartbeat regions before publishing them
      ocfs2: cache the mount context for dentry lock callbacks
      ocfs2: validate move extents against a stable EOF
      ALSA: rawmidi: Drain input work before freeing the runtime
      ALSA: pcm: Unlink substreams before releasing them
      Bluetooth: 6LoWPAN: Use RCU-safe device list removal
      Bluetooth: hci_core: Keep RCU protection through LTK filtering
      Bluetooth: 6lowpan: Drain RCU readers on registration failure
      ALSA: oss: Keep emulation modules loaded until object teardown
      ALSA: pcm: Remove channel-map controls before freeing substreams
      ocfs2: initialize status waiters before publishing them

Cen Zhang (Microsoft Security FORGE Labs) (1):
      nfsd: hold cl_lock in client_has_openowners()

Cen Zhang (Microsoft) (2):
      posix-cpu-timers: Fix pid refcount leak in do_cpu_nanosleep() signal path
      apparmor: fix query_data() output overlapping the lookup key

Chaithanya Lagisetty (2):
      dmaengine: sprd: use clk_bulk API to fix clock imbalance
      x86/svm: Avoid sign extension of SVM_EVTINJ_VALID in 64-bit expressions

Chandradhar Kumar (1):
      regulator: fixed: reject incompatible platform devices

Chao Shi (1):
      nvme: ratelimit the completion-path messages driven by device data

Chao Yu (3):
      f2fs: compress: fix to handle race between truncate and writeback
      f2fs: fix to update superblock crc in sanity_check_area_boundary()
      f2fs: fix to fetch ino via ino_of_node() under cache lock

Chen Changcheng (3):
      media: cx88: fix memory leak in cx8802_register_driver() error path
      Bluetooth: btrsi: Move set_bt_context after successful HCI registration
      scsi: snic: Fix SCSI host leak on workqueue allocation failure

Chen Wang (1):
      dt-bindings: vendor-prefixes: add milkv/sophgo

Chen-Yu Tsai (4):
      drm/exynos/fimd: fix register offset type in fimd_trigger()
      dt-bindings: media: sun4i-a10-video-engine: Fix IOMMU count for H6
      arm64: dts: allwinner: sun50i-h6: Add missing SRAM region for video engine
      arm64: dts: allwinner: sun50i-h6: Add missing IOMMU for video engine

Cheng Yongkang (2):
      io_uring/timeout: count cancelled timeouts in cq_timeouts
      net: tun: hold napi_mutex when deleting NAPI in tun_detach_all()

Chengfeng Ye (4):
      batman-adv: Close OGM aggregation before transmission
      mm/ksm: mark migration stores with WRITE_ONCE()
      l2tp: snapshot sequencing state when building transmit headers
      xfrm: retry inexact policy lookup after node reinsertion

Chien Wong (1):
      wifi: mac80211: fix encryption tailroom

Chris Down (1):
      mm: make swapoff interruptible when unusing mms/shmem

Chris Mason (19):
      ovl: fix a torn path in ovl_get_redirect()
      ovl: read the nlink xattr of every indexed non-dir
      sunrpc: pin gss module across auth_domain RCU free
      ovl: set OVL_WHITEOUTS before publishing the upper dir
      ovl: take a snapshot of the name for copy up
      ovl: do not copy up an xattr value that was never read
      ovl: hold a reference on the parent in readdir
      ovl: do not copy up a dentry that was removed
      ovl: check that the parents of volatile/dirty are dirs
      mm/mempolicy: charge shared policy nodes
      mm/gup: fix out-of-bounds write for nr_pages == 0 in GUP-fast
      mm/mmu_notifier: set ->mm only after mmgrab()
      backing-file: always end a queued write
      ovl: look up the index by the decoded origin
      aio: fix NULL deref when a fault races ring truncation
      mm/huge_memory: fix truncate racing with PMD zapping
      mm/memory: reject remote COW faults on PFN mappings
      nvmet-rdma: disable interrupts under rsp_wr_wait_lock
      nvmet-rdma: fix double puts after a failed RDMA WRITE

Chris Simpson (1):
      ALSA: hda/realtek: Enable bass speakers on Alienware m17 R3

Christian Borntraeger (1):
      s390/vmcp: Initialize full session info to zero

Christian Brauner (4):
      coredump: hold RCU while releasing parked threads
      iomap: don't mark unwritten parts of a folio uptodate
      proc: add proc_splice_unmountable()
      proc: don't let an entry below /proc/<pid>/net be a mountpoint

Christian Gmeiner (1):
      drm/etnaviv: Flush the tile status cache through both the PE and BLT

Christian Loehle (3):
      ACPI: CPPC: Validate FFH register fields before hardware access
      cpuidle: menu: Remove single state handling
      ACPI: CPPC: Validate the _CPC package header

Christian Marangi (1):
      i2c: mt7621: fix copying uninitialized kernel stack with reduced page_len

Christoph Hellwig (2):
      swim: don't call blk_queue_bounce_limit
      swim: use blk_mq_alloc_disk

Christophe JAILLET (3):
      media: mtk-vpu: Remove redundant 'flush_workqueue()' calls
      mfd: wcd934x: Fix an error handling path in wcd934x_slim_probe()
      ocfs2: constify struct ocfs2_lock_res_ops

Chuanhong Guo (1):
      pinctrl: mediatek: mt7629: fix the 2.4 GHz Wi-Fi pin mode array

Chuck Lever (15):
      lockd: Fix use-after-free in nlmsvc_retry_blocked
      pnfs/blocklayout: Complete a device upcall only on its own reply
      pnfs/blocklayout: Complete a device upcall when the pipe is closed
      NFSD: Do not send CB_RECALL_ANY to NFSv4.0 clients
      NFSD: Don't complete a cld upcall the daemon has not read
      NFSD: Fail a pool_threads read whose reply does not fit
      NFSD: Reject an oversized principal hash from nfsdcld
      SUNRPC: Reject a socket that already has an svc_sock attached
      svcrdma: Grant credits from the clamped sc_max_requests
      NFSD: Move the cld upcall message out of the caller's stack frame
      NFSD: Complete a cld upcall when the daemon closes the pipe
      NFSD: Complete a cld upcall when copying its reply fails
      NFSD: Map flex file layout IDs through the request's user namespace
      xprtrdma: Remove the RPC/RDMA QP event handler
      SUNRPC: Copy the deferred RPC Call from the head buffer

ChunYuZhiQiang (1):
      can: dev: can_fill_info(): don't wake up controller if interface is down

Chung-Chiang Cheng (1):
      splice: report related fsnotify events

Claire Chang (1):
      Bluetooth: Move force_bredr_smp debugfs into hci_debugfs_create_bredr

Codrin Ciubotariu (1):
      ASoC: atmel-i2s: do not warn if muxclk is missing

Cong Nguyen (2):
      staging: media: imx: csc-scaler: fix ipu_image_convert_run leak on queue error
      leds: lm3692x: Fix regulator/gpio leak and wrong enabled state on last write failure

Cong Zhang (1):
      virtio_blk: use synchronous quiesce in virtblk_freeze_priv()

DAI RENJIE (1):
      resource: fix lost wakeup when waiting for a muxed region

Daeho Jeong (2):
      f2fs: avoid setting SBI_NEED_FSCK on transient resize failure
      f2fs: release a removed xattr node in roll-forward recovery

Daehyeon Ko (6):
      ipc/mqueue: release notification resources during inode eviction
      ipv6: initialize temporary ifaddr before publication
      ipv6: do not restart DAD for a dead ifaddr
      aio: prevent eventfd/epoll recursion on poll
      crypto: algif_skcipher - rewind rounded output bytes
      splice: avoid stale f_pos writeback on error

Daejun Park (9):
      ext4: don't report delalloc data as a hole on indirect-mapped inodes
      jbd2: don't advance j_fc_off before the buffer is recorded
      xfs: clamp a pNFS LAYOUTCOMMIT extent before computing its end
      xfs: clamp the pNFS layout range to the maximum file size
      xfs: don't skip free extents of the longest length in a whole-AG FITRIM
      nvme: unregister when pr_register() is given a zero new key
      xfs: mark the inode preallocated for pNFS write layouts past EOF
      xfs: cap the block count of xfs_iomap_write_direct() at one extent
      xfs: add a flag to convert unwritten extents without allocating blocks

Dairui Zhang (1):
      IB/mad: fix UAF and double-free in RMPP receive reassembly

Damon Ding (1):
      drm/bridge: analogix_dp: Restore mandatory samsung DP DT properties

Dan Carpenter (5):
      nvme-tcp: fix error codes in nvme_tcp_setup_ctrl()
      wifi: b43: don't pass unterminated string to sscanf()
      wifi: b43legacy: debugfs: NUL terminate string in debugfs
      wifi: carl9170: NUL terminate string in debugfs
      mm/hmm/test: reject overflowing page counts

Daniel Borkmann (1):
      bpf, arm64: Fix off-by-one in check_imm signed range check

Daniel Golle (1):
      net: dsa: mt7530: error out on failed PHY_IAC command writes

Daniel Palmer (1):
      m68k: apollo: Fix interrupt setup

Darong Lu (1):
      libceph: initialize CRUSH choose argument weights

Darrick J. Wong (13):
      xfs: check fork type against dabtree block magic number
      xfs: mark overfull dabtree node blocks as corrupt
      xfs: check for fragments when full-extent sharing matches
      xfs: only written file data blocks can be shared
      xfs: opportunistically skip btree block checks
      xfs: propagate errors while checking null siblings
      xfs: check for buffer overruns when examining local/remote xattr entries
      xfs: improve dirent bounds checking in scrub and repair
      xfs: allow softlimit with no hardlimit in quota scrub
      xfs: rescan the AGs if incore delalloc counter is negative
      xfs: reject absurdly large xattr value lengths in xchk_xattr_actor
      xfs: jump out of xchk_bmap_check_rmap if fatal signals
      xfs: always report scrub errors in tracepoints

Dave Carey (1):
      HID: multitouch: Fix stale MT slots when contact count drops to zero

Dave Jiang (5):
      efi/cper: Reject CPER records with an out-of-range error_data_length
      efi/cper: Reject an error status block length that wraps a u32
      ACPI: extlog: Validate elog record length before walking sections
      efi/cper: Read only validated fields in cper_mem_err_pack()
      PCI/AER: Add optional logging callback for correctable error

David Gow (1):
      time/kunit: Use correct format specifier

David Heidelberg (6):
      backlight: qcom-wled: Fix NULL pointer dereference in wled_remove()
      backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe
      backlight: qcom-wled: Fix WLED3 brightness register stride
      mfd: wcd934x: Fix NULL pointer dereference on IRQ probe deferral
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Extend the xbl_mem region
      mfd: wcd934x: set DMA mask on parent to silence "DMA mask not set"

David Hildenbrand (Arm) (10):
      mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()
      mm/ksm: reset the unstable trees of all nodes
      mm/madvise: fix data loss from MADV_FREE on a KSM page
      mm: disallow ioremap'ing ordinary RAM in generic_access_phys()
      mm/gup: check for overflow when converting nr_pages to bytes in GUP-fast
      mm/ksm: fix use of a freed anon_vma at swap-in
      mm/userfaultfd: wake waiters when registration modes are removed
      mm/vma: don't leak the charge for stack growth
      fork: take mmap_lock before copying mm_struct
      mm/shmem: make shmem_file() check the file's inode

David Howells (2):
      rxrpc: Fix update of call->tx_pending without holding lock
      afs: Fix afs to abort the rxrpc call on send error

David Laight (1):
      usb_string_copy: Use kzalloc() to avoid leaking old data

David Lee (1):
      sctp: hold shkey across socket migration

David Woodhouse (1):
      tun: Require CAP_NET_ADMIN to attach to an ownerless device

David Yang (1):
      net: hisilicon: hisi_femac: Stop the receiver before releasing the RX ring

Deepanshu Kartikey (1):
      media: imon: fix use-after-free in display_close via dev_dbg

Denis Arefev (1):
      ALSA: cs46xx: fix unit mismatch in DSP code area bounds check

Denis Efremov (Oracle) (2):
      floppy: don't store a stack buffer in timeout_message
      floppy: return the drive state flags from the 32-bit FDGETDRVSTAT

Denis V. Lunev (1):
      virtio_balloon: warn on failed buffer add in tell_host()

Detlev Casanova (1):
      arm64: dts: rockchip: Rename rk3328 HDMI audio card

Devin Wittmayer (1):
      wifi: mt76: mt76x02: report rx FCS errors to mac80211

Diego Fernando Mancera Gomez (1):
      usb: image: microtek: stop SG processing after transfer errors

Diego Oliva (2):
      smb: client: fix use-after-free infoleak via the readdir resume name
      smb: client: fix OOB last_entry pointer from unbounded LastNameOffset

Dmitrii Tulnov (1):
      kconfig: warn about malformed KCONFIG_PROBABILITY values

Dmitry Antipov (2):
      HID: roccat: fix locking in roccat_connect() and roccat_disconnect()
      leds: flash: Prevent using uninitialized variable in flash_fault_show()

Dmitry Baryshkov (3):
      drm/msm/hdmi: use bulk regulator API
      drm/msm/hdmi: fill the pwr_regs bulk regulators
      drm/msm/mdp5: drop cursor pipe for msm8x76

Dmitry Osipenko (1):
      clk: tegra: support 48MHz clock for pll_p_out1

Dmitry Torokhov (2):
      mfd: ipaq-micro: Fix out-of-bounds stack read in ipaq_micro_str
      gpio: crystalcove: add missing MODULE_ALIAS()

Dmytro Moroziuk (1):
      ALSA: hda/conexant: Add mute LED quirk for HP ProBook 440 G5

Dominic White (1):
      wifi: cfg80211: allow zero HE OBSS PD offsets

Dominik Maier (1):
      loop: check for read-write open mode on LOOP_SET_STATUS in lo_compat_ioctl()

Dominique Martinet (1):
      libbpf: fix cross-endian build with newer libbpf

Donggeun Yoo (1):
      tracing: Print a signed histogram key as signed

Drobyshev Vladimir (1):
      USB: cdc-acm: add VeriFone VX820 device ID

Dudu Lu (3):
      net/sched: etf: initialise the sock_exterr_skb before filling it
      net/sched: gred: keep the qdisc lock while updating the table
      net/sched: taprio: unwind the netdevice notifier if register_qdisc() fails

Eckhart Mohr (1):
      ALSA: hda/realtek: Add quirk for ASRock NUC BOX-358H

Eduard Zateev (1):
      smb: client: hold server info until cifsd exits

Edward Adam Davis (2):
      ocfs2: fix oob in __ocfs2_find_path
      kernel/reboot: avoid potential deadlocks during suspension

Eklavya Singh (1):
      ocfs2/heartbeat: serialize concurrent writes to a region's dev attribute

Elia Devito (1):
      platform/x86: hp-wmi: rename "thermal policy" to "thermal profile"

Eric Biggers (7):
      fsverity: Explicitly require FMODE_READ to retrieve hashes
      fs-verity: factor out fsverity_get_descriptor()
      fsverity: Be more careful with return value of ->get_verity_descriptor()
      xor: add missing vzeroupper to AVX code
      raid6: add missing vzeroupper to AVX-512 code
      raid6: add missing vzeroupper to AVX2 code
      lib/crypto: mips: Disable Octeon SHA code on little-endian kernels

Eric Dumazet (13):
      ipv4: start using dst_dev_rcu()
      ixgbe: reserve TX timestamp after skb preparation
      can: raw: fix lockdep issue in raw_release()
      ip6mr: ip6mr_sk_done() can exit early in common cases
      ip6mr: fix use-after-free in ip6mr_sk_done()
      ipv6/addrconf: allocate a per netns hash table
      dlm: fix send buffer backpressure handling
      inet: frags: limit the truesize of a reassembly queue
      sit: fix UAF in ipip6_tunnel_del_prl()
      ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup
      ipv6: account route exceptions to the netns of their dst
      net: fix frag_list leak in skb_segment_list() error path
      selftests/net: fix typo in tcp_mmap

Eric Kim (1):
      sched/fair: Reset NUMA fault locality after scan period update

Esben Haabendal (3):
      drm/bridge: nwl-dsi: Cleanup endpoint mux control selection
      drm/bridge: nwl-dsi: Limit LCDIF specific sync override
      iio: light: ltr501: Power down chip if request irq fails

Ethan Nelson-Moore (1):
      ata: sata_inic162x: remove dangerous broken driver

Ewan D. Milne (1):
      nvmet: don't return memory contents beyond valid data when reading ANA log page

Fabio Cesari (1):
      iio: light: isl29028: fix runtime PM reference leak on error paths

Fabrice Derepas (2):
      crypto: asymmetric_keys - fix OOB read in pefile_parse_binary
      ima: reject a kexec buffer whose declared size exceeds the buffer

Fan Wu (4):
      scsi: dc395x: sync the waiting_timer before freeing the host
      media: mediatek: vpu: free IRQ before destroying watchdog workqueue
      media: rockchip: rga: quiesce IRQ before releasing m2m state
      virtio_fs: read the vring size under virtio_fs_mutex in ->get_tree

Fang Xieyan (6):
      kcov: ignore an out-of-range comparison count in write_comp_data()
      kgdb: Fix buffer overflow in the 'm' packet handler
      kgdb: Fix buffer overflow in the qRcmd packet handler
      vringh: bound top-level re-entry into indirect tables
      vringh: reject empty / undersized indirect descriptor tables
      kgdb: Fix buffer overflow in the 'M' and 'X' packet handlers

Federico Musto (1):
      net: atl1c: drop oversized RX frames instead of panicking

Federico Valentín Andrade (1):
      ALSA: usb-audio: Skip mixer creation on M-Audio Venom

Felix Fietkau (2):
      wifi: mt76: mt7603: fix U-APSD service period termination
      mt76: implement .mcu_parse_response in struct mt76_mcu_ops

Felix Gu (3):
      spi: omap2-mcspi: Remove unbalanced pm_runtime_put_sync() calls
      spi: mtk-nor: fix runtime PM usage count leak in probe error path
      spi: mxic: fix ps_clk leak in runtime resume

Felix Hoffmann (1):
      libceph: reject mismatched CRUSH weight-set sizes

Feng Yang (1):
      bpf: Propagate btf_add_type() errors in btf_check_all_metas()

Fernando Fernandez Mancera (3):
      netfilter: synproxy: fix reset of ct seqadj when reopening a connection
      net: openvswitch: skip IPv4 later fragments on TCP/UDP set actions
      net: openvswitch: drop IP fragments on SCTP set action

Filipe Manana (2):
      btrfs: fix memory barrier order in reloc_root_is_dead()
      btrfs: qgroup: fix swapped blocks existence check when tracing after COW

Finn Thain (16):
      swim: Assert strobe with stable outputs
      swim: Select appropriate drive once only
      swim: Enable the drive when probing
      swim: Don't disable drive after every sector
      swim: Perform ISM/IWM mode switching according to specs
      swim: Configure parameter memory
      swim: Don't start motor until medium is present
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

Fredric Cover (1):
      smb: client: fix early procfs exposure race

Fuad Tabba (5):
      irqchip/gic-v3-its: Don't clamp nvecs to zero when id_bits is 32
      KVM: arm64: vgic-its: Don't map an LPI from more than one event
      irqchip/gic-v3-its: Clear vpt_page after freeing the pending table
      irqchip/gic-v3-its: Don't free a vPE table shared with another ITS
      irqchip/gic-v3-its: Don't free the tables of an enabled ITS

Gabor Tanz (1):
      HID: quirks: Always poll the Anne Pro 2 with product ID a292

Gabriel Prostitis (1):
      USB: gadget: inode: fix mm lifetime handling

Gary Guo (1):
      ata: ata_generic: Don't store pci_device_id

Geert Uytterhoeven (1):
      spi: sh-msiof: SITMDR1/SIRMDR1 bitfield conversion

Georgia Garcia (1):
      apparmor: remove fs entries created by a failed policy load

Geraldo Nascimento (2):
      PCI: rockchip-host: Do not attempt 5.0 GT/s retraining
      PCI: rockchip: Drive at 2.5 GT/s, error other speeds

Ginger Li (2):
      media: exynos4-is: Fix a race between s_stream(0) and the interrupt handler
      wifi: mac80211: Fix a race when expiring a mesh path

Giorgi Kobakhia (1):
      ocfs2: fix array out of bound access in __ocfs2_find_path()

Giovanni Di Santi (2):
      fbdev: kyro: Use devm_ioremap() for mmio registers
      fbdev: kyro: Use devm_ioremap_wc() for screen mem

Golla Nagendra (1):
      dmaengine: zynqmp_dma: Fix chan probe/remove error handling

Greg Kroah-Hartman (5):
      usb: typec: tcpm: bound altmode_desc[] per iteration in svdm_consume_modes()
      media: adv7604: avoid negative array index in log_status when cp_read fails
      media: stv090x: bound DiSEqC reply length to msg[] size
      media: stv0900: bound DiSEqC reply length to msg[] size
      Linux 5.10.275

Greg Thelen (1):
      selftests/net: tcp_mmap: remove unused -k option and keepflag

Gregory Price (3):
      rtc: cmos: Disable ACPI RTC event before handling it
      mm/madvise: use folio_trylock() in the cold/pageout PMD split
      mm/userfaultfd: compare exact registration modes before skipping

Gregory Price (Meta) (2):
      cgroup/cpuset: use mems_allowed_seq when checking a policy nodemask
      cgroup/cpuset: check effective mems for a movable-only configuration

Griffin Kroah-Hartman (2):
      nfc: mrvl: spi: Unregister dev on allocation fail
      nfc: nxp-nci: Add remove on IRQ error

Guanghui Feng (1):
      iommu/vt-d: Fix IQE handling to cover all descriptors in submission range

Guanglei Zhu (1):
      ceph: clamp the inline data length in ceph_fill_inline_data()

Guangshuo Li (11):
      iio: accel: kxcjk-1013: Disable autosuspend on remove
      iio: accel: mma9551: disable autosuspend on remove
      iio: accel: mma9553: disable autosuspend on remove
      ASoC: Intel: atom: Fix platform device leak on probe failure
      media: tw686x: fix V4L2 device lifetime on probe failure
      media: rtl28xxu: fix SDR platform device leak
      media: mediatek: vpu: release reserved memory on remove
      mfd: ab8500: Fix child device leaks on probe failure
      irqchip/imx-intmux: Fix runtime PM teardown on remove
      crypto: omap-sham - fix crypto engine cleanup
      media: atmel-isi: release unregistered video device on remove

Guenter Roeck (5):
      hwmon: (lm87) Fix drvdata type confusion in vrm_show() and vrm_store()
      hwmon: (nct6683) Fix incorrect struct cast in show_pwm() and store_pwm()
      hwmon: (coretemp) Fix 32-bit jiffies wraparound in show_temp()
      hwmon: (tmp108) Fix initial conversion delay and wait until ready
      hwmon: (coretemp) Check for NULL platform device in hotplug callbacks

Gui-Dong Han (1):
      xen/blkback: Prevent missed completion when draining I/O

Guiting Shen (1):
      ASoC: tlv320aic32x4: Fix the divide by zero

Guixin Liu (1):
      nvmet: Finish the blk plug when integrity allocation fails

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
      i2c: acpi: Add i2c_acpi_new_device_by_fwnode() function

Haoxiang Li (4):
      ASoC: hdac_hdmi: Fix resource cleanup on probe failure
      tty: serial: pch_uart: add check for pci_get_slot()
      usb: fsl_qe_udc: check qe_alloc_request() failure in ch9getstatus()
      iwlwifi: dvm: add missing cleaup for on error path

Hari Mishal (3):
      nvme: bound ns descriptor header and body to identify buffer
      virtio_console: take a kref in find_port_by_vq() to fix port UAF
      drm/amd/pm: bound SCLK FCW range entries to the table size

Harry Wentland (1):
      drm/amd/display: Fix out-of-bounds read in dp_get_eq_aux_rd_interval()

Heikki Krogerus (5):
      software node: Introduce device_add_software_node()
      mfd: core: Add support for software nodes
      software node: Fix device_add_software_node()
      software node: Allow node addition to already existing device
      software node: Handle software node injection to an existing device properly

Heiko Carstens (2):
      s390/probes: Fix wrong opcode for cgrb fixup
      s390/uprobes: Fix off-by-one bug in emulated PER handling

Heiko Schocher (1):
      drm/panel: simple: Add Kyocera tcg070wvlq panel

Heiner Kallweit (2):
      net: core: add dev_get_tstats64 as a ndo_get_stats64 implementation
      usbnet: switch to core handling of rx/tx byte/packet counters

Helge Deller (1):
      fbcon: Fix KASAN slab-out-of-bounds Read in fbcon_prepare_logo

Hemanth Selam (1):
      ext4: skip extra isize expansion while unmounting

Henrik Enquist (2):
      ALSA: aloop: Don't constrain playback params in notify mode
      ALSA: aloop: Update the PCM Slave controls for a matching playback

Henry Martin (3):
      tipc: fix broadcast sender hang on last acker departure
      rds: fix out-of-bounds conn_path walks via handshake exthdrs
      netlink: fix out-of-bounds bitmap access clearing stale mc groups

Herbert Xu (1):
      crypto: tcrypt - Avoid reading req->base after submission

Hernan Ganzo (1):
      ALSA: hda/realtek: Limit internal mic boost on HP Pavilion 15 (103c:2164)

Hongfu Li (1):
      rds:Simplify the allocation of slab caches

Hongling Zeng (1):
      dmaengine: sun6i-dma: Fix use-after-free in error handling paths

Hongyan Xu (2):
      mfd: da903x: Cancel IRQ work during teardown
      RDMA/hfi1: quiesce SDMA asynchronous cleanup on exit

Horia Geantă (1):
      crypto: tcrypt - fix skcipher multi-buffer tests for 1420B blocks

Hou Wenlong (1):
      KVM: x86: Exit to userspace if emulation prepared a completion callback

Hsiu-Hsien Lee (1):
      ext4: fix fast commit replay failing on a read-only mount

Hugo Villeneuve (6):
      serial: sc16is7xx: declare MCR and IER as volatile registers
      serial: max310x: remove trailing whitespaces
      serial: max310x: remove holes in struct max310x_devtype
      serial: max310x: simplify probe() and remove() error handling
      serial: max310x: use common detect function for all variants
      serial: max310x: use common power function for all variants

Hui Peng (1):
      ata: libata-scsi: abort multi-sector pass-through commands when multi_count is 0

Hui Su (1):
      cpufreq: schedutil: Serialize sugov_start() against rate limit updates

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

HyeongJun An (20):
      remoteproc: elf_loader: Bound the section header table
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
      ASoC: codecs: sta32x: Fix definition of Ch2 and Ch3 Volume Bypass controls
      ASoC: codecs: sta350: Fix definition of Ch2 and Ch3 Volume Bypass controls
      ASoC: codecs: sta32x: Fix definition of limiter threshold controls
      ASoC: codecs: sta350: Fix definition of limiter threshold controls
      ASoC: cs42l56: Remove the ADC Mute Switch control

Hyunwoo Kim (2):
      exec: Cleanup POSIX timers right after de_thread()
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

Ian Gallagher (1):
      ACPI: button: Add lid_init_state quirk for Razer Blade Stealth 13 (Early 2020) RZ09-0310

Ian Rogers (1):
      perf header: Fix potential memory corruption in cpu_cache_level__read

Icenowy Zheng (2):
      dt-bindings: vendor-prefixes: add Genesys Logic
      dt-bindings: vendor-prefixes: add Source Parts and Lctech names

Ido Schimmel (4):
      net/sched: flower: Fix chain template offload
      ipmr: fully initialize the synthetic IP header in ipmr_get_route()
      vxlan: Stop rejecting dynamic FDB entries with a nexthop ID
      ipmr, ip6mr: validate packets injected into the register vif on xmit

Igor Putko (1):
      serial: core: shut down initialized port on removal

Igor Skalkin (1):
      usb: gadget: dummy_hcd: fix SuperSpeed ep0 maxpacket

Igor Velkov (2):
      genirq/kexec: Do not take the bus lock of an interrupt chip on the crash path
      power: supply: gpio-charger: Report discharging without input power

Ilya Maximets (1):
      openvswitch: vport: fix self-deadlock on release of tunnel ports

Imre Kaloz (7):
      PCI: Disable MSI for ULi M1575 EHCI controller
      MIPS: mm: Fix the cache error vector jump for XKPHYS kernels
      MIPS: sgi-ip32: Mask MACE PCI interrupts in CRIME only
      MIPS: sgi-ip32: Leave MACE PCI control alone in config accesses
      scsi: aic7xxx: Use default settings on the SGI O2 onboard controllers
      rtc: ds1685: arm the wake-up alarm at power-off only if an alarm is set
      rtc: ds1685: do not sleep in the power-off handler

Inseo An (1):
      netfilter: nf_tables: fix use-after-free in nf_tables_addchain()

Israel Téllez García (1):
      libbpf: Fix ring buffer consumer loop on 32-bit position wrap

Ivan Hu (1):
      ACPICA: Initialize parser_state.aml_end in acpi_install_method()

Ivan Uvarov (1):
      dt-bindings: add compatible vendor prefix for Forlinx

Jack Wang (1):
      crypto: amlogic - Fix dma_map_sg error check

Jagan Teki (1):
      dt-bindings: vendor-prefixes: Document Chongzhou

Jake Labelle (2):
      nilfs2: validate directory position after llseek in readdir
      nilfs2: reject non-regular inodes in dsync recovery

Jamal Hadi Salim (5):
      net/sched: act_ife: do not consume the inner header on egress
      netdevsim: reject cls_bpf programs bound to another device
      bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
      net/sched: clamp skb->queue_mapping before indexing the tx queue
      net/sched: act_api: reject duplicate actions in a batch

James Clark (1):
      net: ethernet: ti: am65-cpsw-nuss: Enable timestamping of unicast PTP packets

James Hilliard (1):
      mtd: rawnand: sunxi: reject ECC maximization on small pages

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

Jan Stancek (4):
      sign-file,extract-cert: move common SSL helper functions to a header
      sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
      sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
      .gitignore: drop Module.markers

Jann Horn (1):
      mm: document mmu_notifier_invalidate_range_start_nonblock()

Janne Grunau (1):
      wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload

Jason Perlow (1):
      wifi: brcmfmac: map msgbuf RX packet IDs bidirectional

Jasper Firth (1):
      ASoC: Intel: bytcr_rt5651: Add quirk for Chuwi Hi8 with generic DMI strings

Jay Fang (1):
      spi: jcore: Fix trailing statements should be on next line

Jay Vadayath (1):
      udf: bound lengthAllocDescs from unallocated space entry

Jean Delu (1):
      parisc: eisa_enumerator: Fix out-of-bounds reads of the EEPROM buffer

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: fix odr change not caught in certain cases

Jeff Layton (2):
      SUNRPC: keep the first error in svc_register()
      nfsd: don't offer flexfiles layouts when NFSv3 isn't being served

Jeffin Philip (1):
      media: vidtv: fix uaf in vidtv_bridge_on_new_pkts_avail

Jenson Johnathon Reggentin (1):
      docs: block: fix dead http link in blk-mq.rst

Jerome Brunet (2):
      clk: sunxi-ng: fix ccu probe clock unregister on error
      clk: cdce925: Size the PLL child name buffer for any int

Jesse Zhang (6):
      drm/amdgpu: reject ANONONLY userptrs that span multiple VMAs
      drm/amdgpu: reject CS chunks too large for kvmalloc()
      drm/ttm: return an error when kmapping a BO without pages
      drm/amdgpu: keep the CS user fence BO in GTT
      drm/amdgpu: don't walk the CS chunks when allocating them failed
      drm/amdgpu: parse CS IBs at the BO offset their VA mapping starts at

Jesse.Zhang (1):
      drm/amdgpu: Limit BO list entry count to prevent resource exhaustion

Jhonata Poma-Hansen (1):
      netlink: check sk_rcvbuf before charging the dump skb

Jiacheng Xu (1):
      kobject: fix out-of-bounds access in kobject_action_type()

Jiale Yao (27):
      HID: zydacron: validate key report length
      HID: cougar: reject short special-key reports
      HID: cp2112: validate response report lengths
      HID: elo: reject short touchscreen reports
      HID: logitech-dj: validate unnumbered keyboard reports
      HID: mcp2221: validate response report length
      HID: roccat: isku: reject short button reports
      HID: roccat: koneplus: reject short button reports
      HID: roccat: konepure: reject short button reports
      HID: roccat: kovaplus: reject short button reports
      HID: roccat: pyra: reject short button reports
      HID: roccat: ryos: reject short special reports
      HID: roccat: savu: reject short special reports
      wifi: mt76: mt7615: cancel reset work during unregister
      HID: prodikeys: validate fixed-format MIDI reports
      crypto: ccp - kill v3 IRQ tasklet during teardown
      crypto: ccp - kill v5 IRQ tasklet during teardown
      RDMA/mad: Reject receive completions shorter than GRH
      pinctrl: sprd: free maps on DT map failure
      wifi: mt76: mt76x02: validate RX padding before use
      wifi: mt76: usb: fix source overread in mt76u_copy
      ACPI: PCI: pci_link: clear driver_data before free
      wifi: ath10k: avoid IDR mutation during TX cleanup
      wifi: ath11k: avoid IDR mutation during pending mgmt TX cleanup
      wifi: ath11k: avoid IDR mutation during vif mgmt TX cleanup
      platform/olpc: Reserve space for a string terminator
      team: reject CAN, IEEE 802.15.4 and 6LoWPAN devices in team_port_add

Jiaming Zhang (4):
      hfsplus: validate extent record length before writing it back
      ocfs2: fix chunk number of the first chunk in a local quota file
      gfs2: reject invalid inode sizes
      nilfs2: force clear dirty state when restoring from the shadow map

Jiangong.Han (1):
      USB: usbmon: fix null-ptr-deref in mon_bus_remove() when mon_bus_init() fails

Jianyun Gao (2):
      dax: Return errors from dax_core_init()
      xfs: fix temporary cursor leak in btree shift corruption paths

Jiasheng Jiang (1):
      drm/amdkfd: Check for null pointer after calling kmemdup

Jiawen Liu (1):
      memory: exynos5422-dmc: handle clock enable failures

Jiaxing Hu (1):
      iommu/rockchip: Clear stale page faults before enabling stall

Jiayuan Chen (5):
      netfilter: ebtables: bound num_counters like nentries in do_replace()
      bonding: fix out-of-bounds read of arp_ip_target
      tcp_bic: fix divide by zero on max_increment == 0
      tcp_hybla: fix divide by zero on rtt0 == 0
      bpf: Fix verifier WARN on narrow read of bpf_tcp_sock u64 fields

Jiebin Sun (1):
      perf c2c: Fix documented default coalesce fields

Jiele zhao (1):
      security/loadpin: Update the changing interface in the source code.

Jinjie Ruan (2):
      ext4: fix out-of-bounds read in ext4_get_group_info()
      arm64: kexec_file: Fix elf_headers memory leak in retry loop

Jinwang Li (1):
      Bluetooth: L2CAP: Ignore connection responses with wrong ident

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

Joachim Vandersmissen (1):
      crypto: ecdh - explicitly zeroize private_key

Joanne Chang (1):
      f2fs: allow pinning empty compressed files

Joanne Koong (2):
      fuse: don't launder folios of a bad inode
      fuse: don't drop destination page cache on a zero byte copy reply

Joas Antonio dos Santos (3):
      calipso: hash the cache key, not the option start, in calipso_cache_add()
      calipso: update payload_len when removing the CALIPSO option
      net: dcb: initialize PFC value before calling getpfccfg

Joe Hattori (1):
      PM: wakeup: implement devm_device_init_wakeup() helper

Johan Hovold (7):
      media: usbtv: drop redundant device reference
      staging: greybus: uart: fix racy TIOCMIWAIT implementation
      USB: cdc-acm: fix urb leak on disconnect
      USB: serial: usb_wwan: fix urb leak on disconnect
      USB: serial: sierra: fix urb leak on write completion
      PM: sleep: wakeirq: drop unused enable helpers
      irqchip/gic-v3-its: Use irq_domain_create_hierarchy()

Johannes Berg (5):
      wifi: ath6kl: don't take RTNL in del_virtual_intf
      wifi: mac80211: clear fragment cache entry 'is_protected'
      wifi: mac80211: mesh: use hlist_add_head_rcu()
      wifi: mac80211: kill wake_txqs_tasklet on unregistration
      wifi: mac80211: init radiotap iter after length checks

John Hubbard (1):
      mm/gup_benchmark: rename to mm/gup_test

John Johansen (2):
      apparmor: fix refcount leak in aa_get_newest_profile()
      apparmor: on failed load ensure profile files are removed before parent

Jonas Karlman (1):
      drm/rockchip: dw_hdmi: Use resume_early pm ops for system suspend

Jonathan Gopel (1):
      thunderbolt: Do not RPM complete unrelated subtrees on unplug

Jorge Lopez (1):
      platform/x86: Move existing HP drivers to a new hp subdir

Jose Maria Casanova Crespo (1):
      drm/v3d: Initialize timedout_batches when running a CSD job

Josef Bacik (22):
      driver core: Limit the messages on a refused uevent
      aoe: pull in the headers each received packet type reads
      mount: refuse setns() with a shared fs_struct again
      mm/memfd: make f_pos accesses atomic
      mm/mmu_gather: fix flushing ranges with 4 GiB or larger
      mm: fix unmap_mapping_range() beyond 4 GiB on 32-bit
      mm/hugetlb: unmap the page where the other VMA maps it
      net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()
      mm/mremap: fix moving PUD leaves
      mm/filemap: read mapping->a_ops->free_folio under i_lock
      mm/mmu_notifier: finish non-blocking interval invalidation on error
      mm/filemap: don't lose a folio lock wakeup to a signal
      bpf: Update the SRH state if End.B6 fails late
      bpf: Bound the nesting that the BTF show code follows
      bpf: Don't take an extension for an iterator program
      nvmet-tcp: stop listening when a port is removed
      nvmet-tcp: don't read a removed port at Connect time
      nvme-loop: don't BUG() if a scan runs beside a reset
      blk-throttle: don't truncate the cgroup v1 iops limits
      blk-mq: keep sharing tags fairly after a queue update
      block: partitions/mac: compute the sectors in 64 bits
      drbd: take req_lock to skip the initial sync as peer

Joseph Qi (18):
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
      ocfs2: use the stored hash when checking xattr bucket collision
      ocfs2: do not read the entry array of an empty xattr bucket
      ocfs2: read the xattr entry hash before defragmenting the bucket
      ocfs2: fix deadlock in inline-data truncate transactions
      ocfs2: reject inconsistent xattr bucket during defrag
      ocfs2: retain all security xattrs during inode creation
      ocfs2: fix possible deadlock between nfs_sync_rwlock and fs_reclaim
      ocfs2: reserve xattr value tree metadata only once

Juan Perdomo (1):
      media: cx231xx: preserve I2C transfer length

Julian Anastasov (1):
      ipvs: fix buffer overflow when sending sync messages

Julian Braha (2):
      media: marvell-cam: fix unmet dependency for VIDEO_MMP_CAMERA
      kconfig: fix extra output from savedefconfig on out-of-range defaults

Julius Bairaktaris (1):
      wifi: mac80211: fix swapped fq_overlimit/fq_overmemory in aqm debugfs

Jun Yang (1):
      sctp: re-point retained control chunks on association migration

Junhao He (1):
      ACPI: APEI: Handle repeated SEA error storms

Junrui Luo (4):
      media: vicodec: fix out-of-bounds write on under-rounded coded dimensions
      media: vicodec: make encoder CAPTURE dimensions read-only
      media: vicodec: zero-initialize stateful decoder heap buffers
      media: vicodec: fix NULL deref on oversized frame

Junzhe Yu (1):
      ext4: guard against NULL s_group_info in ext4_get_group_info

Justin Chen (2):
      memory: brcmstb_dpfe: Fix out-of-bounds access due to DCPU offset
      memory: brcmstb_dpfe: Bounds check DCPU-supplied MSG_ARG_COUNT

Jérémy Jean (12):
      lib/crypto: arm64: Fix lost Poly1305 carry when resuming NEON state
      nfsd: preflight SEQUENCE replies before accepting a slot
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

Kaho Jiang (2):
      net: ipv4: add zero check for snd_cwnd_clamp
      media: em28xx: fix double free in em28xx_alloc_urbs

Kaixuan Li (1):
      f2fs: bound the SIT/NAT bitmaps by the checkpoint pack

Kameron Carr (1):
      Drivers: hv: vmbus: Bounds check the shared ring buffer indices

Kamil Sawicki (1):
      net: limit priority VLAN untag depth

Karl Asseily (1):
      dt-bindings: vendor-prefixes: add ESS Technology

Karl Mehltretter (30):
      klist: avoid accesses after waking klist_remove()
      fs_pin: publish pins with RCU list helpers
      crypto: atmel-tdes - zero-initialize device state
      crypto: atmel-aes - fix AADLENR for standalone GHASH
      lib/842: reject output overflows from index and short data
      lib/842: require a complete history block for repeat templates
      crypto: atmel-tdes - sync output bounce buffer before DMA
      fpga: Fix of_fpga_mgr_get() reference in fpga_mgr_lock() docs
      sh: intc: Sort the prio and sense lists after filling them
      ARM: 9491/1: alignment: restore uaccess state on emulation fault
      KVM: arm64: vgic-v3: Undo assignment on iodev registration failure
      irqchip/gic-v3-its: Don't WARN on LPI free allocation failure
      mtd: spinand: Fix spinand_manufacturer_ops kernel-doc
      power: supply: mp2629: Use the full batt_impedance_compensation name in the ABI document
      efi/libstub: Fix efi_set_event_at() parameter documentation
      firewire: cdev: Fix FW_CDEV_IOC_CREATE_ISO_CONTEXT references in kernel-doc
      ata: libata-scsi: Fix ata_scsi_hotplug() reference in kernel-doc
      gfs2: Fix the return value in gfs2_get_link() kernel-doc
      ALSA: control: Fix virtual master creation reference in kernel-doc
      wifi: mac80211: Fix the return value in mesh_path_add() kernel-doc
      loadpin: Fix stale KEXEC_VERIFY_SIG reference in documentation
      soc: ti: k3-ringacc: Correct ring API kernel-doc
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

Keisuke Tsukuda (2):
      usb: gadget: composite: avoid warning on aborted delayed status
      usb: gadget: f_mass_storage: ignore class requests while inactive

Keita Morisaki (1):
      drm/amd/display: Fix swap in median3() for DSC rate control

Keith Busch (1):
      nvme: tcp: split controller bringup handling

Kemeng Shi (2):
      irqdomain: Plug leak in irq_domain_alloc_irqs_locked() error path
      irqchip/gic-v3-its: Fix its node leak in gic_acpi_parse_madt_its()

Keqiang Duan (1):
      KVM: x86: Clear hardware HLT state when userspace makes a vCPU not-halted

Kim Wooseok (1):
      wifi: rtl8xxxu: free RX skb when URB submission fails

Kiryl Shutsemau (Meta) (2):
      arm64: sdei: Run the event handler on the kernel vectors
      arm64: sdei: Preserve the interrupted context's exception registers

Koichiro Den (2):
      dmaengine: dw-edma-pcie: Reject devices without driver data
      net: sched: avoid qdisc_reset_all_tx_gt() vs dequeue race for lockless qdiscs

Konrad Dybcio (2):
      clk: qcom: rcg2: Propagate force-enable status errors
      clk: qcom: rcg2: Clear force enable after rate failure

Konstantin Khorenko (1):
      selftests/core: fix unshare_test with large fs.nr_open

Kryštof Černý (1):
      w1: ds2482: add OF device match table

Krzysztof Karas (1):
      iommu/dma: Catch scatterlist length overflows

Krzysztof Kozlowski (4):
      drm/msm/hdmi_bridge: Correct poweroff/audio cleanup order in post_disable
      drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure
      drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
      dt-bindings: vendor-prefixes: add Revotics

Krzysztof Wilczyński (3):
      PCI/sysfs: Pass the device name length in UTF-16 code units
      PCI/sysfs: Rely on lengths from scnprintf(), dsm_label_utf16s_to_utf8s()
      PCI/sysfs: Stop reporting _DSM failures as -EPERM

Kuan-Wei Chiu (2):
      riscv, bpf: Add support for BPF_SDIV and BPF_SMOD in RV32 JIT
      riscv, bpf: Add support for BPF_MOVSX in RV32 JIT

Kunhai Dai (1):
      blk-iocost: abort weight transfer on invalid donation weights

Kuninori Morimoto (1):
      ASoC: codec: max98926: fixup invert setup mask

Kunwu Chan (1):
      rcutorture: Fix divide-by-zero with fwd_progress_div=1

Kuogee Hsieh (6):
      drm/msm/dp: reduce link rate if failed at link training 1
      drm/msm/dp: do not end dp link training until video is ready
      drm/msm/dp: stop link training after link training 2 failed
      drm/msm/dp: always add fail-safe mode into connector mode list
      drm/msm/dp: do not stop transmitting phy test pattern during DP phy compliance test
      drm/msm/dp: add fail safe mode outside of event_mutex context

Kyle Zeng (7):
      io_uring/io-wq: save worker type before dropping its reference
      affs: validate blocks before freeing them
      tcp: fix reordering addition overflow in MTU probing
      net/sched: sch_qfq: prevent aggregate self-replacement
      netfilter: nf_reject: initialize IPCB at inet ingress
      mm/page_vma_mapped: continue past nonmatching huge PMDs
      net/packet: check TX_RING fragments before memory accounting

Kyrylo Biryuk (1):
      ata: libahci: re-enable FBS after error handling on a port multiplier

Lachlan Hodges (1):
      wifi: cfg80211: include cf1 offset when sending chandef

Lad Prabhakar (1):
      spi: spi-rspi: Add support to deassert/assert reset line

Laurence Oberman (2):
      scsi: st: Restore changed drive settings after reset also for MTLOAD and MTRETEN
      scsi: st: Record the tape position after a successful MTLOAD

Laurent Pinchart (1):
      media: uvcvideo: Force UVC version to 1.0a for 1bcf:0b40

Lee Jones (7):
      HID: wacom: Use hdev->product in wacom_setup_touch_input_capabilities
      HID: wacom: Redesign shared sibling data lifecycle
      HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration
      HID: wacom: Fix Use-After-Free in wacom_intuos_pad
      HID: wacom: Fix Use-After-Free in wacom_bamboo_pad
      tracing/histograms: Verify event_call identity when updating synth_event refcount
      mfd: Standardise MFD_CELL_* helper names

Leizhen Zhang (1):
      gen_init_cpio: stop parsing on lines with a missing argument list

Len Baker (1):
      assoc_array: Avoid open coded arithmetic in allocator arguments

Len Brown (2):
      x86_energy_perf_policy: Fix optarg keyword matching
      x86_energy_perf_policy: Cleanup: Check fseek() in VM path

Leon Romanovsky (2):
      RDMA/core: Preserve the selected source GID on failed AH modification
      RDMA/core: Reject LAG selection when source MAC lookup fails

Li Jun (1):
      tpm: tpm_tis_spi: fix nodef CR50 tpm_tis_spi_resume is null

Li Qiang (1):
      Bluetooth: hci_bcsp: validate received packet lengths

Li RongQing (7):
      x86/ioperm: Prevent NULL dereference on theoretical missing IO bitmap
      RDMA/uverbs: Make CQ handle mandatory for WQ creation
      RDMA/uverbs: Drop restrack ref on ib_init_ucontext() failure in GET_CONTEXT
      RDMA/core: Fix partial copy of IPv6 flow_lbl in LAG hash skb
      RDMA/mlx5: Restore mr->pi_mr after temporary stack-local assignment
      IB/isert: Don't share drop_cmd_list across concurrent connection teardowns
      RDMA/mlx5: Fix CQ resize destination index mask

Li Youhong (1):
      md/raid5: drain released_stripes before destroying the cache

Liang Hao (1):
      timers: Clear pending_map on CPU hotplug

Lijo Lazar (3):
      drm/amdgpu: Add checks to vbios fetch through ATRM
      drm/amdgpu: Validate ATIF buffer length before use
      drm/amd/pm: validate vega10 profile mode inputs

Lin, Meng-Bo (1):
      dt-bindings: vendor-prefixes: Add GPLUS

Linkai Gong (5):
      media: i2c: tc358743: add missing color-space strings
      drivers/base/node: fix UAF on device_register() failure
      firmware: imx: dsp: fix mailbox channel leak on kasprintf failure
      misc: enclosure: fix UAF on device_register() failure
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

Linus Walleij (20):
      power: supply: ab8500_fg: Report sub-percent charge changes
      mfd: ab8500: Drop bm disable parameter
      regulator: ab8500: Fix AB8505 VANA voltage selectors
      regulator: ab8500: Add AB8505 VAUX3 3.05 V setting
      regulator: ab8500: Handle AB8505 VINTCORE selector 7
      regulator: ab8500: Treat cut 1.0 VAUX3 as fixed
      regulator: ab8500: Test dedicated enable bits only
      regulator: ab8500: Propagate mode enable read errors
      dt-bindings: Add vendor prefixes
      ARM: dts: gemini: Use a level-high interrupt for TVE200
      power: supply: ab8500_btemp: Fix event temperature reporting
      power: supply: ab8500: Use local helper
      power: supply: ab8500: Convert to dev_pm_ops
      power: supply: ab8500_charger: Oneshot threaded IRQs
      power: supply: ab8500_fg: Request all IRQs as threaded
      power: ab8500: Require device tree
      mfd/power: ab8500: Push data to power supply code
      power: supply: ab8500: Move to componentized binding
      power: supply: ab8500_charger: Handle detection errors
      power: supply: ab8500_fg: Avoid reserved AB8505 CCConf bit

Liu Changjie (1):
      can: peak_usb: pcan_usb_fd_decode_buf(): accept short uCAN end-of-list records

Liu Chao (1):
      usb: fotg210: validate endpoint index in ep0 handlers

Liu Dalin (1):
      rtc: ftrtc010: fix integer overflow in time calculation

Logan Gunthorpe (2):
      dmaengine: ioat: disable relaxed ordering before registering the device
      dmaengine: plx_dma: fix NULL pointer deref in plx_dma_isr()

Logan Odell (1):
      PCI/IOV: Read VF config values that need not match PF

Long Zhao (1):
      dt-bindings: vendor-prefixes: add Ambarella

Lorenzo Stoakes (ARM) (2):
      fbdev: smscufx: check for fb_deferred_io_init() error
      fbdev: udlfb: check for fb_deferred_io_init() error

Lu Baolu (1):
      iommu/vt-d: Report more information about invalidation errors

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

Luigi Lauro (1):
      drm/amd/display: take a runtime PM reference only when a CRTC turns on

Luis Banha (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion 15-ec1xxx

Luis Chamberlain (2):
      swim: simplify using blk_cleanup_disk() on swim_remove()
      swim: add helper for disk cleanup

Luis Gerardo Lopez Hernandez (1):
      ALSA: hda/realtek: Fix internal speakers on Acer Aspire AL16-31P

Luiz Augusto von Dentz (1):
      Bluetooth: hci_core: Move all debugfs handling to hci_debugfs.c

Luxiao Xu (1):
      smb: client: fix buffer overflow in SMB2_tcon()

Ma Ke (2):
      ASoC: wcd9335: Fix device reference leak in wcd9335_slim_status()
      i2c: acpi: Fix adapter reference leak in i2c_acpi_new_device_by_fwnode()

Maciej Kucharek (3):
      drm/amdgpu: reset CIK ASIC on Apple boards with VRAM at 0
      drm/amdgpu: reset VI ASIC on Apple boards with VRAM at 0
      drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0

Magnus Lindholm (7):
      alpha: run check_mmu_context() from finish_arch_post_lock_switch()
      alpha: only use a targeted tbi() when the target mm is really current
      alpha: invalidate the local context in flush_tlb_page()
      alpha: fix the local TLB invalidate in flush_tlb_page()
      alpha: fix the local TLB invalidate in the UP flush_tlb_page()
      alpha: invalidate the local context in flush_tlb_mm()
      alpha: invalidate the local context in flush_icache_user_page()

Manikanta Pubbisetty (1):
      wifi: ath10k: trigger hardware recovery upon rx failures

Manush Prajwal (1):
      pwm: lp3943: fix NULL pointer dereference for an unconfigured channel

Marc Kleine-Budde (2):
      spi: spi-sun4i: sun4i_spi_transfer_one(): fix transfers for SUN4I_FIFO_DEPTH
      spi: spi-sun4i: sun4i_spi_fill_fifo(): always apply A10 FIFO fill level workaround

Marc Zyngier (5):
      KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded
      KVM: arm64: Turn vcpu->arch.pause into a counter
      irqchip/gic-v3-its: Reset each ITS's BASERn register before probe
      irqchip/gic-v3-its: Split allocation from initialisation of its_node
      irqchip/gic-v3-its: Restore quirk probing for ACPI-based systems

Marco Scardovi (1):
      platform/x86: asus-wmi: Serialize WMI method evaluations with a mutex

Marco Ziliani (1):
      ata: libata-pmp: disable the SEMB port on Marvell 88SM9705

Marek Czernohous (1):
      drm/nouveau/pci: use config-space MSI rearm on MCP79/MCP7A (NVAC)

Marek Szyprowski (5):
      ARM: 9519/1: dma-mapping: Fix wrong free function in __iommu_alloc_simple() error path
      ASoC: wm8994: fix MCLK gating for AIF clocks sourced from MCLK2
      ASoC: wm8994: don't lose the AIF clock ratio when staying at 32kHz SYSCLK
      ASoC: wm8994: fix MCLK index used for setting MCLK rate
      ASoC: wm8994: follow AIF clock source changes in MCLK gating

Marek Vasut (1):
      dt-bindings: vendor-prefixes: Add Retronix Technology Inc.

Mario Limonciello (1):
      platform/x86: Rename hp-wireless to wireless-hotkey

Mark Anthony Agarro (1):
      wifi: mt76: mt76x02: validate TX-status rate index before mac80211 handoff

Markus Probst (2):
      rtc: s35390a: Add missing newline to dev_err
      rtc: s35390a: Fix alarm not disabling

Martin Wilck (1):
      md/raid5: validate payload size before calculating payload_len

Masafumi Suzuki (1):
      sctp: account for chunk padding in sctp_init_cause()

Masahiro Yamada (9):
      kconfig: change defconfig_list option to environment variable
      kconfig: remove unneeded symbol_empty variable
      kconfig: default to zero if int/hex symbol lacks default property
      kconfig: split randconfig setup code into set_randconfig_seed()
      kconfig: move conf_rewrite_mod_or_yes() to conf.c
      kconfig: move conf_set_all_new_symbols() to conf.c
      .gitignore: ignore only top-level modules.builtin
      kconfig: initialize sym->curr.tri to 'no' for all symbol types again
      kconfig: fix file name in warnings when loading KCONFIG_DEFCONFIG_LIST

Masami Hiramatsu (1):
      arm64: kprobes: Remove redundant kprobe_step_ctx

Matheus Alves de Almeida (2):
      fat: hold truncate_lock in fat_write_failed()
      HID: wacom: fix wacom_intuos_irq NULL pen_input deref

Matt Bobrowski (1):
      bpf: Fix UAF in sock clone early bailouts

Matt Turner (2):
      alpha: run the remote RTC access in a worker, not an IPI callback
      lib/decompress_bunzip2: fix off-by-one in run-length bounds check

Matthew Jacob (1):
      drm/amdgpu: Support some Barco AMD based graphics adapters

Matthias Goergens (6):
      fanotify: report names longer than NAME_MAX
      udf: don't let the extent type hide an exhausted free-space table extent
      udf: fix preallocation discarding before an empty allocation extent
      udf: don't use eloc after the end of the unallocated space table
      x86/hibernate: Ignore page-zero RAM in E820 checksum
      isofs: return long Joliet names whole

Matthias Schiffer (1):
      ARM: dts: imx7-tqma7: add SPI-NOR flash

Maurizio Casciano (1):
      power: supply: core: Honor supplied-from with CONFIG_OF=y

Maurizio Lombardi (1):
      nvme-fc: do not warn on controller removal race

Max Kellermann (1):
      ceph: remove unused field `i_cap_migration_resv`

Maxim Skokov (1):
      media: vivid: round the height down to the vertical subsampling factor

Maxime Bélair (1):
      apparmor: report a label allocation failure as -ENOMEM

Maxime Ripard (1):
      ASoC: tlv320aic32x4: div: Switch to determine_rate

Maíra Canal (2):
      drm/vc4: Publish the output fence outside of job_lock
      mfd: wcd934x: Replace legacy gpio interface for gpiod

Melissa Wen (1):
      drm/amd/display: use right type for amdgpu_dc_performance event entries

Michael Bommarito (1):
      9p/trans_virtio: reject mount tags longer than NAME_MAX at probe

Michael Freidkin (1):
      media: meson: vdec: size capture planes from the aligned canvas

Michael Liang (1):
      fault-inject: fix dentry leak

Michael Tretter (1):
      dmaengine: zynqmp_dma: simplify with dev_err_probe

Michael Wyraz (1):
      USB: serial: option: add support for ASR 1286:4e3c modem

Michail Tatas (2):
      USB: misc: uss720: Fix leak in get_1284_register
      ipmi: Fix leak in __ipmi_bmc_register

Michal Pecio (2):
      ALSA: usx2y: Stop clearing urb->hcpriv before submission
      usb: xhci: Fix bounce buffer overflow

Michal Simek (2):
      microblaze: Use simple memset implementation from lib/string.c
      microblaze: Do loop unrolling for optimized memset implementation

Mikhail Lobanov (1):
      wifi: ath11k: modify null check logic in ath11k_ce_rx_post_pipe()

Mikhail Zhilkin (1):
      dt-bindings: Add Sercomm (Suzhou) Corporation vendor prefix

Mikko Perttunen (1):
      gpu: host1x: Wait for timeout worker completion on channel free

Mikulas Patocka (4):
      dm-writecache: fix a crash if we attempt to use non-dax device
      dm-writecache: fix uncommitted_blocks underflow
      dm-snapshot: fix crash if dm_io_client_create fails
      dm-writecache: report I/O error if flush failed

Miles Krause (1):
      memory: emif: fix device_node reference leak on np_ddr

Ming Lei (2):
      blk-mq: add new API of blk_mq_hctx_set_fq_lock_class
      nvme-loop: use blk_mq_hctx_set_fq_lock_class to set loop's lock class

Minghao Zhang (1):
      netfilter: conntrack: tcp: use UNACK timeout for non-closing RST packets

Mingming Cao (2):
      ibmveth: fix netpoll races with RX replenish
      ibmveth: wait for the RX poll to return before freeing the RX queue

Miquel Raynal (Schneider Electric) (1):
      clk: Use the generic OF phandle parsing in only one place

Mohamad Raizudeen (3):
      crypto: amlogic - Fix IRQ handler return value and fallthrough logic
      crypto: amlogic - Fix DMA memory leak in cipher error path
      PCI: Fix out-of-bounds MMIO read in nvme_disable_and_flr()

Muhammad Bilal (1):
      platform/x86: hp-wmi: fix heap OOB read and memory corruption in hp_wmi_perform_query()

Mukesh Ojha (2):
      iommu/qcom: Check pm_runtime_resume_and_get() return in probe
      iommu/qcom: Publish pgtbl_ops before releasing init_mutex

Muzaffer Kadir (1):
      dt-bindings: vendor-prefixes: Add General Mobile

Myeonghun Pak (22):
      media: cx88: Disable PCI device on MPEG initialization failure
      media: cx23885: unregister DVB bus when SP2 CI setup fails
      backlight: lm3630a: Cancel delayed work before destroying workqueue
      media: marvell: manage the MMP camera clock provider
      media: go7007: unregister the I2C adapter on USB probe failure
      media: cx18: Disable PCI device on probe failure
      media: tw68: balance PCI enable on cleanup
      mtd: maps: pci: balance PCI enable on cleanup
      soc: fsl: dpio: Fix cleanup on IRQ registration failure
      ASoC: stm: stm32_i2s: request IRQ after regmap initialization
      mfd: twl-core: Unregister the auxiliary platform device on unbind
      soc: fsl: dpio: Free the IRQ before releasing the I/O object
      leds: ktd2692: Pass context to regulator cleanup
      wifi: mt76: mt7615: restore DBDC state after ext PHY failure
      fbdev: nvidia: Release write-combining handle on probe failure
      fbdev: kyro: Release WC setup on registration failure
      dmaengine: mediatek: hsdma: fix runtime PM leak on init failure
      mfd: intel_quark_i2c_gpio: Manage the fixed-rate clock
      mfd: da9150: Balance IRQ wake on teardown
      clk: ti: adpll: unregister OF clock provider on remove
      fbdev: gxt4500: Release WC setup on probe failure
      net: hix5hd2: serialize timeout recovery with interface teardown

Naman Jain (1):
      x86/init: Initialize wall clock in get_rtc_noop()

Namhyung Kim (1):
      tools/lib/api: Fix potential double-free from fdarray__grow()

Nanzhe Zhao (1):
      f2fs: remove mappedtodisk flag usage in mmap write path

Nathan Chancellor (2):
      wifi: brcmsmac: Adjust txpwrindex value in nphy_ipa_rxcal_gaintbl_2GHz
      extract-cert: Wrap key_pass with '#ifdef USE_PKCS11_ENGINE'

Navon John Lukose (1):
      i2c: designware: queue only one read command for block reads

Neil Armstrong (1):
      dt-bindings: vendor-prefixes: add vendor prefix for Nexperia B.V.

NeilBrown (1):
      nfsd: honour client-provided attributes for NFS4_CREATE_EXCLUSIVE4_1

Nguyen Ngoc Thang (3):
      net/rds: ib: don't enable IRQs in rds_ib_conn_free()
      md: take reconfig_mutex when enabling PPL on an inactive array
      ocfs2: validate chunk and block counts of the local quota file

Nguyen Quang Le Kien (1):
      usb: gadget: fix refcount underflow in gadgetfs_bind() error path

Nickolai Zeldovich (4):
      resource: report a devm_request_resource() conflict under the lock
      mm/mlock: use a long for the page count in mlock_fixup()
      nsproxy: Fix cred leak in the error path of prepare_nsset()
      splice: retry tee() instead of returning 0 when it races

Nicolai Buchwitz (4):
      net: stmmac: selftests: use skb_share_check() in the loopback receive hook
      net/mlx5e: use skb_share_check() in the loopback selftest hook
      net: usb: cdc_ncm: don't enable BHs in tx_fixup under netpoll
      net: usb: cdc_mbim: don't enable BHs in tx_fixup under netpoll

Nicolas Escande (1):
      wifi: ath11k: fix locking problem in ath11k_dp_rx_tid_del_func()

Nicolas Schier (1):
      kconfig: tests: Provide defconfig outfile for savedefconfig

Nicolo Giuliani (1):
      dt-bindings: vendor-prefixes: Add Sophos

Nikhil P. Rao (1):
      ionic: fix port_info use-after-free on firmware recovery

Niklas Cassel (7):
      ata: sata_fsl: Fix use-after-free of host_priv on probe() failure
      ata: ahci_st: Do not ignore errors when getting the reset controls
      ata: ahci_st: Assert the power down reset in the probe() error path
      ata: ahci: print the lpm policy on boot
      ata: libahci: Free the IRQs when activating a multi-IRQ host fails
      ata: libata: Do not leave ata_host_stop() registered when activation fails
      scsi: scsi_debug: Refuse a negative physblk_exp

Niko Huuskonen (1):
      ALSA: caiaq: Fix the Kore controller key map

Nikolaj Klitlund Børty (1):
      Bluetooth: btusb: Add device ID for Realtek RTL8761BUE (StarTech AV53C1)

Nikolaos Karaolidis (2):
      fs: rotate inodes whose page cache could not be dropped
      fs: don't lose inodes that another LRU walker is isolating

Nikolay Borisov (1):
      ata: sata_dwc_460ex: Don't enable interrupt if libATA core registration fails

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

Oliver Hartkopp (6):
      can: isotp: check the return values of can_rx_register() in isotp_bind()
      can: proc: skip stats calculation after reset in can_stat_update()
      can: raw: add missing refcount for memory leak fix
      can: replace ARPHRD_CAN type checks with can_get_ml_priv()
      can: protect the receive lists with a per-device lock
      can: raw, isotp: copy socket options outside of lock_sock()

Oliver Neukum (1):
      usb: misc: cypress_cy7c63: check result of IO

Olivier Kaloudoff (2):
      ALSA: usb-audio: Add mic resolution quirk for Logitech Webcam C200
      drm/amdkfd: stop restore retries on device unplug

Olivier Moysan (1):
      ASoC: stm32: i2s: remove irqf_oneshot flag

Orgad Shaneh (4):
      mtd: cfi_cmdset_0002: cap the write-buffer chunk at 256 bytes on an x8 device
      MIPS: mm: do not write a huge TLB entry when the probe misses
      staging: octeon: schedule the TX cleanup tasklet every 1024th packet
      MIPS: Octeon: size the swiotlb for a modular OHCI platform driver

Oswald Buddenhagen (3):
      ALSA: emu10k1: prune vestiges of SNDRV_SFNT_SAMPLE_{BIDIR,REVERSE}_LOOP support
      ALSA: emux: centralize & improve patch info validation
      ALSA: emux: simplify snd_sf_list.callback handling

Ovidiu Panait (1):
      spi: rspi: Fix DMA mode when the DMA controller is built as a module

Pablo Neira Ayuso (2):
      netfilter: nf_tables: call skb_valid_dst() before skb_dst()
      netfilter: conntrack: always lower timeout for non-closing RST packets

Paul Dolan (1):
      selftests/clone3: tighten CLONE_CLEAR_SIGHAND conflict test

Paul E. McKenney (1):
      clocksource: Provide kernel module to test clocksource watchdog

Paul Moses (2):
      perf mmap: Use the head selected by read_init
      perf mmap: Preserve the consumed cursor in forward mode

Pauli Virtanen (1):
      Bluetooth: L2CAP: hold chan in l2cap_ecred_conn_rsp()

Paulo Alcantara (2):
      smb: client: fix warning in CIFSFindFirst()
      smb: client: fix warning in CIFSFindNext()

Pedro Falcato (1):
      mm/madvise: atomically clear the young bit on THP MADV_COLD

Pei Xiao (5):
      media: cx23885: Fix use-after-free in cx23885_finidev due to race condition
      tpm: tpm_nsc: fix NULL pointer dereference on init failure
      tpm: tpm_nsc: stop using the cleanup callback as dev.release
      tpm: fix zero-length read discarding the pending response
      comedi: dt2811: fix shift-out-of-bounds in IRQ check

Peijie Shao (1):
      nvme-tcp: fix selinux denied when calling sock_sendmsg

Peng Fan (1):
      PM: sleep: wakeirq: Introduce device-managed variant of dev_pm_set_wake_irq()

Pengpeng Hou (41):
      media: cec: stm32: return an error when log-address wait times out
      ASoC: tlv320aic26: remove keyclick sysfs file
      dmaengine: pl330: remove debugfs file on teardown
      iio: adc: max1241: add missing MODULE_DEVICE_TABLE()
      media: cec: tegra: add missing MODULE_DEVICE_TABLE()
      media: ivtv: stop VBI start-code scan before short tail
      media: cx18: stop VBI start-code scan before short tail
      uio: sercos3: add missing MODULE_DEVICE_TABLE()
      greybus: manifest: validate string descriptor header
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
      media: require two-byte Cypress type 04 records
      spi: sh-msiof: propagate setup runtime-PM errors
      memory: brcmstb_dpfe: validate firmware section sizes
      usb: musb: da8xx: depopulate OF children on remove
      usb: musb: da8xx: depopulate OF children on probe failure
      clk: milbeaut: Return divider update timeouts
      pmdomain: imx: Propagate SCU provider registration failures
      ASoC: adau17x1: return cache sync errors from resume
      ASoC: ak4642: return cache sync errors from resume
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
      sh: defconfig: Enable the current M66592 UDC symbol

Peter Robinson (1):
      arm64: dts: rockchip: add infrared receiver node to RK3399 Firefly

Peter Ujfalusi (8):
      ALSA: compress: add missing OPEN-state gate to SET_METADATA
      ALSA: hda: Reject codec reset on ASoC (ext_ops) buses
      ASoC: hdac_hda: Balance the runtime PM disable in codec remove
      ASoC: hdac_hda: Keep runtime PM state in sync across codec remove/probe
      ALSA: x86: hdmi: fix chmap array missing terminator entry
      ALSA: hda/hdmi: clamp sad_count in ELD proc write handler
      ALSA: hda/hdmi: clamp num_cvts against cvt_nids[] in hdmi_read_pin_conn
      ALSA: compress: fix buffer leak on failed SET_PARAMS

Petr Vorel (1):
      checkpatch: skip CamelCase cache for --no-tree without root

Philipp Stanner (1):
      string.h: add array-wrappers for (v)memdup_user()

Ping Cheng (2):
      HID: wacom: Write shared touch initial status only once
      HID: wacom: Setup SW_MUTE_DEVICE according to the order of input registration

Piotr Gliźniewicz (1):
      ALSA: 6fire: take stream_mutex in the Digital Thru control

Piotr Kubik (1):
      netfilter: ctnetlink: fix inverted IPv6 address match in dump filter

Piyush Patle (1):
      media: vidtv: fix frontend reference leak on unbind

Pranjal Shrivastava (1):
      PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs

Prathamesh Deshpande (1):
      RDMA/mlx5: Cancel deferred page-fault EQ work before teardown

Prike Liang (1):
      drm/amdgpu: finish GPU recovery callbacks before restarting schedulers

Priyank Rathod (1):
      PCI/AER: Fix struct pci_dev reference leak in aer_process_err_devices()

Pufan Jin (1):
      spi: zynq-qspi: fix address buffer corruption and support 4-byte address

Punnay Sharma (2):
      staging: media: av7110: fix corrupted BER reporting in sp8870
      staging: media: av7110: fix sp8870 initialization failure state

Qais Yousef (1):
      arm64: kprobes: Fix Uexpected kernel BRK exception at EL1

Qihang (1):
      xfrm: interface: validate the IP header on xmit

Qing Luo (1):
      sctp: auth: discard auth_chunk when skb_clone fails

Qingfang Deng (4):
      pppoe: delete session hash entries by pointer match
      mtd: block: prevent reclaim I/O during request processing
      ARM: mvebu: fix Cortex-A9 errata selection for Armada 38x
      pppoe: drop discovery frames with no MAC header

Qingshuang Fu (1):
      selftests/timers: clocksource-switch: Fix unchecked open()/read()

Qu Wenruo (1):
      btrfs: qgroup: do not treat "ret > 0" as error when deleting a qgroup

Quanye Yang (1):
      RDMA/rtrs-clt: Reject invalid queue_depth from the peer

Radhey Shyam Pandey (1):
      dmaengine: xilinx_dma: Freeup active list based on descriptor completion bit

Radiy Zhambakiev (3):
      mfd: tps65217: Fix NULL pointer dereference on IRQ init failure
      mfd: tps65217: Check return value when masking interrupt sources
      mfd: tps65217: Use devres for IRQ domain and wake teardown

Rafael J. Wysocki (3):
      ACPI: utils: Adjust message printing macros for ACPI objects
      ACPI: glue: Fix up and adjust acpi_unbind_one()
      ACPI: video: Fix backlight unregistration ordering

Ramin Moussavi (3):
      microblaze: reserve the ABI argument-home area in the signal frame
      microblaze: don't clobber r3/r4 restored by rt_sigreturn
      microblaze: restore the ABI argument home area below pt_regs (PTO)

Rand Deeb (1):
      ata: libata-core: Ignore forced transfer modes the host does not support

Randy Dunlap (1):
      fbdev: maxine: fix 64-bit build error

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

Robert Hancock (1):
      net: axienet: Clean up device used for DMA calls

Robert Leussler (1):
      rtc: ds1307: fix RX8130 wakeup alarm WADA bit for day-of-month mode

Robert Richter (1):
      PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem dev handler

Roberto Bergantinos Corpas (1):
      nfs: set gencount on protocol-specific remove

Robin Everaars (1):
      ACPI: button: Add DMI quirk for Razer Blade Pro 17 early 2020 lid switch

Rohinthan P (1):
      media: em28xx: use video_unregister_device for radio_dev

Rongzheng Wang (1):
      nvmet: use the enabled transport when disabling a port

Rosen Penev (19):
      gpio: mvebu: keep resume masks within the irqchip cache
      net: bgmac: enable interrupts only after NAPI is ready
      mtd: rawnand: ndfc: fix gcc uninitialized var
      mtd: rawnand: ndfc: use devm_platform_ioremap_resource()
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

Rui Qi (1):
      selftests/ftrace: Force C locale in ftracetest

Runyu Xiao (14):
      media: saa7146: Initialize interrupt lock before requesting IRQ
      dmaengine: altera-msgdma: initialize state before requesting IRQ
      PCI: pciehp: Make 'pciehp_poll_mode' parameter read-only
      media: adv7180: Initialize mutex before ancillary clients
      ALSA: sgio2audio: Only free successfully requested IRQs
      m68k: dmasound: Keep the Q40 IRQ handler registered
      perf: xgene: initialize lock before requesting IRQ
      sh: maple: Use the matching IRQ cookie when invoking free_irq()
      can: proc: reset pkg_stats atomics individually
      ALSA: usb-audio: Protect Roland control activation
      ALSA: mpu401: shut down timer before freeing MPU
      block: amiflop: synchronize flush timer before track flush
      media: sti: delta: use unaligned accessors for MJPEG SOF fields
      ALSA: via82xx: use helper to activate DXS controls

Ruoyu Wang (7):
      drm/radeon: avoid double free in r600 DPM cleanup
      media: au0828: Free URBs when starting DVB streaming fails
      media: adv748x: Fix endpoint reference leaks on probe failure
      pwm: renesas-tpu: Fix runtime PM reference leak
      hwrng: cctrng - Fix runtime PM usage counter leak
      dmaengine: img-mdc: Fix runtime PM usage counter leak
      media: venus: Drop session events without an instance

Rupesh Majhi (1):
      iio: pressure: dps310: fix CFG_REG bit definitions

Ryan Brue (1):
      power: supply: bq24190_charger: use the wake irq API

Ryusuke Konishi (3):
      nilfs2: fix deadlock between nilfs_evict_inode() and find_inode()
      nilfs2: ignore non-fatal signals during synchronous log write wait
      nilfs2: fix link count underflow when removing corrupted directory

Sabrina Dubroca (1):
      xfrm: espintcp: reorder operations within espintcp_init_sk

Sagi Maimon (2):
      net: axienet: free outstanding TX buffers in axienet_dma_bd_release()
      net: axienet: release every RX buffer in axienet_dma_bd_release()

Sahaj Chaudhari (2):
      gpio: pca953x: Preserve wakeup accounting on parent IRQ failure
      gpio: pca953x: Handle direction register read errors in IRQ paths

Salah Triki (1):
      iio: imu: adis16400: Check return value of spi_setup()

Sally Marcher (1):
      ALSA: usb-audio: Add correct datainterval in the quirks-table for Microbook II

Sam Price (1):
      microblaze: preserve the MSR carry flags across signals

Samarth Narang (1):
      mm/ksm: keep soft-dirty when merging a page

Samuel Holland (1):
      dmaengine: sun6i: Do not use virt_to_phys

Samuel Moelius (1):
      mm/gup_test: reject wrapped user ranges

Samuel Thibault (1):
      speakup: Fix NULL pointer dereference on VT switch + selection

Sanan Hasanov (1):
      hwmon: (corsair-cpro) Make wait_input_report_lock IRQ safe

Sarthak Sharma (2):
      mm/gup_test: safely calculate GUP batch size
      mm/gup_test: report actual pinned bytes

Sasha Levin (3):
      kselftest/arm64: signal: copy each test binary only once
      selftests: keep the build status from wrapping to success
      ARC: Strip libgcc debug information when generating BTF

Sean Christopherson (10):
      KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails due to invalid guest state
      KVM: x86: Zero reserved synic flags when delivering message to avoid stack leak
      KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1 && EFER.LME=0
      KVM: x86/mmu: Conditionally resched when retrying gPTE walk on A/D update failure
      KVM: nVMX: Process each host MSR entry at most once when unwinding failed VM-Entry
      KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when preparing L2 state
      KVM: x86/mmu: Bug the VM if a vCPU ends up in long mode without PAE enabled
      KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the MMU has
      KVM: x86: Conditionally resched when restarting REP string emulation
      KVM: x86/mmu: Cap number of parent PTEs per SP at 1000 (the arbitrary rmap limit)

Sean Young (6):
      media: rc: mce_kbd: Fix inconsistent locking of keylock
      media: rc: Fix ABBA deadlock by making locks more fine grained
      media: redrat3: Ensure we don't read beyond the end of the packet
      media: redrat3: Ensure all urbs are suspended
      media: ir-hix5hd2: Ensure rdev is setup before interrupts are enabled
      media: redrat3: Error path leaves device in transmitting state

Selvin Xavier (4):
      RDMA/bnxt_re: Fix integer overflow in send payload size computation
      RDMA/bnxt_re: Detect wrong sge_len passed for inline
      RDMA/bnxt_re: Initialize wqe.flags in bnxt_re_post_srq_recv()
      RDMA/bnxt_re: Fix the PD and DPI table size

Sergey Senozhatsky (1):
      ext4: fix ABBA deadlock in ext4_rmdir()

Serhat Kumral (3):
      RDMA/siw: Fix length of first chunk in siw_try_1seg()
      RDMA/srp: Avoid reading uninitialized has_port on srp_parse_in() failure
      RDMA/usnic: Bound buffer size to sizeof(buf) in flowinfo_read()

Seung Min Shin (1):
      sctp: hold transport reference across connect wait

Seungjin Bae (1):
      usb: typec: ucsi: ccg: Validate altmode index in GET_CURRENT_CAM response

Shahar Tzarfati (1):
      wifi: mac80211: ibss: read deauth reason_code after frame length check

Shannon Nelson (1):
      ionic: remove some unnecessary oom messages

Shao Mingyin (1):
      nvmet: bound the traddr and trsvcid configfs writes

Sharath Srinivasan (1):
      net/rds: fix rds_message leak in the rds_send_xmit() drop path

Shehryar Ahmad (1):
      iio: accel: adis16201: fix channel order for buffer mode

Shengjiu Wang (1):
      ASoC: fsl_asrc: use regmap_write_bits to update clock source registers

Shengming Hu (1):
      cpufreq: conservative: Restrict deferred downscaling to low load

Shengzhuo Wei (1):
      media: go7007: bound EZ-USB I2C transfers to the usb_buf size

Shivaprasad G Bhat (1):
      scsi: qla2xxx: Handle INTx not connected while passing through

Shuai Xue (1):
      efi: cper: check section header more appropriately

Shuangpeng Bai (1):
      media: gspca: use vb2_video_unregister_device() on disconnect

Shubham Antil (1):
      RDS/IB: validate receive fragment completions

Simon Glass (1):
      kconfig: abort rather than loop for ever on EOF

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

Srinivas Neeli (2):
      dmaengine: xilinx_dma: Fix MCDMA descriptor fields based on DMA direction
      dmaengine: xilinx_dma: Move descriptors to done list based on completion bit

Stanislaw Gruszka (1):
      wifi: mac80211: queue frames while off-channel

Stanley Jhu (3):
      scsi: ufs: core: Clear stale UIC result byte before peer DME retries
      scsi: ufs: bsg: Clear the reply buffer before use
      scsi: ufs: bsg: Reject UIC commands with a non-zero result byte

Stefan Haberland (1):
      s390/dasd: Snapshot intrc before freeing the request block

Stefano Munari (1):
      net: usb: lan78xx: reject invalid EEPROM write requests

Steven Price (2):
      irqchip/gic-v3-its: Share ITS tables with a non-trusted hypervisor
      irqchip/gic-v3-its: Fix over allocation in itt_alloc_pool()

Sudeep Holla (1):
      ACPICA: Fix PCC OperationRegion command offsets

Sumit Kumar (1):
      PCI: dwc: Set DMA_BYPASS bit in outbound IATU CTRL2 register

Sung Byeongchan (2):
      virtiofs: validate fixed-output response length
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

Takashi Iwai (20):
      ALSA: hda/intel: Add sanity check for BAR0 size
      ALSA: seq: oss: Skip events until fully initialized
      ALSA: bcd2000: Fix race between rawmidi and disconnect
      ALSA: control: Fix UAF in snd_ctl_elem_add() on card disconnect
      ALSA: line6: Handle period elapsed calls outside the locks
      ALSA: emux: Fix UAF of soundfont zones at note-on
      ALSA: emux: Stop voices before freeing zones in all cases
      ALSA: pcm: Prevent O_APPEND open on OSS streams
      ALSA: caiaq: Allow zero-length packet handling for EP1
      ALSA: hda: Fix potential UAF for gating jack
      ALSA: usb-audio: Check mixer matrix size for UAC2/3 at parsing
      ALSA: usb-audio: Fix invalid UAC2/3 mixer unit matrix evaluation
      ALSA: hda: Avoid non-operational GPU warning at regular device removal
      ALSA: line6: Reject too small max packet sizes
      ALSA: line6: Fix potential OOB write in line6_capture_copy()
      ALSA: hda: intel: Cancel delayed work at shutdown, too
      ALSA: jack: Fix kctl free at error in snd_jack_kctl_new()
      ALSA: line6: Use kzalloc() for PCM buffer allocation
      ALSA: usb-audio: Use fixed control index for us16x08 mixer elements
      platform/x86: ibm_rtl: Fix potential OOB read at signature search

Takashi Sakamoto (1):
      firewire: core: remove unused link field in fw_packet structure

Tao Cui (2):
      blk-iocost: charge zone appends as writes
      blk-iocost: account zone append completions in latency stats

Tapio Reijonen (4):
      serial: max310x: don't clobber the TX break bit in set_termios
      serial: max310x: fix breaks not reaching the wire in RS485 mode
      serial: max310x: centralize the RS485 transceiver programming
      serial: max310x: fix RS485 delays being programmed as bit-times

Tarun Noonemunthala (1):
      ALSA: hda/realtek: Add quirk for HP ENVY 13-aq1xxx

Thomas Fourier (1):
      net: alacritech: fix dma_free_coherent() in error path

Thomas Weißschuh (3):
      microblaze: uaccess: Zero out destination on failed get_user()
      microblaze: Pass -m{big,little}-endian through KBUILD_CPPFLAGS
      nios2: ksyms: Declare __mulsi3 export

Thomas Weißschuh (Schneider Electric) (1):
      timekeeping: Update offsets on sequence counter retry in ktime_get_update_offsets_now()

Thorsten Blum (9):
      thermal: intel: powerclamp: Reject invalid window_size values
      hwrng: amd - report partial reads in non-blocking mode
      hwrng: ba431 - fix reported byte count
      hwrng: core - reject unknown RNG names
      x86/boot: Fix off-by-one error in sme_clear_pgd()
      mfd: twl-core: Use i2c_check_functionality as boolean value
      hwrng: virtio - prevent use-after-free after a failed restore
      hwrng: intel - return -ENOMEM when kmalloc_obj() fails
      hwrng: intel - return -ENOMEM when ioremap() fails

Tian Tao (1):
      power: supply: Fix missing IRQF_ONESHOT as only threaded handler

Tianchu Chen (2):
      staging: rtl8723bs: fix protected RX frame validation in decrypt path
      staging: rtl8723bs: fix RX buffer OOB write from device-reported length

Tianjia Zhang (3):
      crypto: tcrypt - Fix missing return value check
      crypto: tcrypt - add asynchronous speed test for SM3
      crypto: tcrypt - remove all multibuffer ahash tests

Tianyi Chen (1):
      eventpoll: propagate wakeup source creation failure in ep_modify()

Til Kaiser (1):
      mlxsw: Initialize register query payloads

Tim Douglas (3):
      serial: pmac_zilog: push received data to the port that received it
      power: supply: generic-adc-battery: fix status with no supplier
      serial: pmac_zilog: report received breaks

Tim Menninger (1):
      xprtrdma: prevent disconnect feedback during endpoint teardown

Ting-Han Hou (1):
      checkkconfigsymbols.py: Parse Git status output line by line

Tingjie Zhong (1):
      fbdev: bitblit: Fix glyph clipping when fbcon pans

Tobias Schumacher (1):
      s390/pci: Add error cleanup in zpci_directed_irq_init()

Tom Verdonck (2):
      hwmon: (tmp102) Fix jiffies wraparound in conversion-ready check
      hwmon: (tmp108) Fix jiffies wraparound in conversion-ready check

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
      drm/amdgpu: Use vmemdup_array_user in amdgpu_bo_create_list_entry_array

Tyrel Datwyler (2):
      scsi: ibmvfc: check for NULL evt in implicit LOGO and target delete path
      scsi: ibmvfc: free ibmvfc_target allocations with mempool_free

Uwe Kleine-König (9):
      mfd: twl: Remove platform data support
      irqchip/imx-intmux: Convert to platform_driver::remove_new() callback
      xen/pcifront: Drop pcifront_common_process() tests of pcidev, pdrv
      pwm: renesas-tpu: Implement .apply() callback
      pwm: renesas-tpu: Rename variables to match the usual naming
      pwm: renesas-tpu: Improve maths to compute register settings
      pwm: renesas: Drop usage of pwm_[gs]et_chip_data()
      pwm: lp3943: Drop usage of pwm_[gs]et_chip_data()
      memory: emif: Convert to platform remove callback returning void

Vaibhav Nagare (1):
      bnxt_en: don't leave an XDP program installed when the open fails

Val Packett (1):
      ASoC: qcom: qdsp6: q6afe: fix clk vote response type mismatch

Valentin Schneider (2):
      irqchip/gic-v3-its: Give the percpu rdist struct its own flags field
      irqchip/gic-v3-its: Postpone LPI pending table freeing and memreserve

Vasiliy Kovalev (1):
      ALSA: hda/via: Apply runtime PM workaround for ASUS X55A

Vinayak Yadawad (1):
      wifi: cfg80211: Allow P2P client interface to indicate port authorization

Vincent Jardin (1):
      dt-bindings: vendor-prefixes: add Free Mobile

Vincent Mailhol (1):
      sound: usb: remove third argument of usb_maxpacket()

Vinod Koul (1):
      dmaengine: zynqmp_dma: drop redundant label

Viresh Kumar (1):
      arch: arc: Remove CONFIG_OPROFILE support

Vishnu Santhosh (1):
      dmaengine: qcom: bam_dma: Defer IRQ trigger type to device tree

Vladimir Murzin (1):
      usb: mtu3: Fix double dereference in TP_printk

Vladimir Oltean (1):
      PCI: cadence: Preserve all error codes in cdns_plat_pcie_probe()

Wahid Khan (1):
      HID: intel-ish-hid: ignore post-init ENUM_DEVICES from firmware

Wang Haoran (1):
      fbdev: atmel_lcdfb: fix list_first_entry() on possibly empty modelist in probe

Wang Yan (1):
      selftests/net: fix EVP_MD_CTX leak in tcp_mmap

Waqar Hameed (1):
      power: supply: ab8500: Fix use-after-free in power_supply_changed()

Wayne Chang (1):
      usb: typec: ucsi_ccg: Add retry mechanism in ccg_read

Wei Jie Law (3):
      net: usb: pegasus: do not advance rx_skb->data on dropped frames
      media: uvcvideo: Fix NULL deref on events for uninitialized controls
      net: usb: pegasus: check rx pkt_len against the received length

Wei Yang (1):
      mm/madvise: add cond_resched() in THP branch of madvise_cold_or_pageout_pte_range()

Weibin Liu (3):
      spi: npcm-fiu: limit UMA data_size to the 16-byte staging buffer
      spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op
      spi: jcore: fix divide-by-zero when speed_hz is zero

Weigang He (6):
      media: rc: fintek-cir: process a full RX buffer instead of overflowing it
      wifi: mac80211: reload TDLS header pointer after skb_linearize()
      ARM: vexpress: fix device_node refcount leak in vexpress_flags_set()
      ARM: vexpress: fix device_node refcount leak in vexpress_smp_dt_prepare_cpus()
      thermal/drivers/ti-soc-thermal: Cancel pending alert work on remove
      thermal/drivers/sprd: validate the sensor id from the device tree

Weili Qian (2):
      crypto: hisilicon/hpre - fix pointer dereference before length check
      crypto: hisilicon/hpre - fix GFP flags for dma_alloc_coherent

Weiming Shi (2):
      asymmetric_keys: reject trust keys without IDs
      nvmet-rdma: reject short connection requests

Wenjie Qi (1):
      f2fs: flush SIT journal during filesystem resize

Wentao Guan (1):
      wifi: cfg80211: release locks on error in cfg80211_wext_siwgenie()

Wentao Liang (30):
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
      clocksource/drivers/fttmr010: Fix clk reference leak in error paths
      clocksource/drivers/digicolor: Fix clk reference leak on request_irq failure
      clk: imx: Fix clock reference leak in imx_get_clk_hw_by_name()
      clk: imx: Fix clock reference leak in imx_obtain_fixed_clock_hw()
      ceph: Fix xattr buffer leak in __send_cap()
      ceph: Fix mds session leak in __open_export_target_session()
      ALSA: caiaq: free the EP4 URB when input setup fails
      mtd: mtdsuper: Fix MTD device reference leak in mtd_get_sb()
      media: vpif_capture: Fix i2c adapter reference leak in vpif_probe()
      xen/gntdev: Fix gntdev_dmabuf ref leak in dmabuf_exp_wait_released()
      power: supply: ltc2941: Fix of_node reference leak in ltc294x_i2c_probe()
      RDMA/cxgb4: Fix skb reference leak in rx_pkt()
      RDMA/siw: Fix qp use-after-free in siw_get_base_qp()
      apparmor: Fix namespace reference leak in __aa_find_or_create_ns()

Will Deacon (1):
      tools: linux/types.h: Add 128-bit integer types for arm64 UAPI structures

William Hansen-Baird (2):
      wifi: rtlwifi: rtl8723be: Remove unnecessary irq save/restore in hw_init()
      wifi: rtlwifi: fix disabling of ASPM for RTL8723BE with AER flooding

William Theesfeld (1):
      clk: zynq: handle kasprintf() failure in periph_clk registration

Wilson Felipe Pereira (2):
      init/main: fix off-by-one in argv_init cleanup
      init/main: fix false-positive kernel panic on environment variable overwrite

Xi Wang (1):
      RDMA/hns: Refactor the MTR creation flow

Xia Yan (2):
      macvlan: fix passthru promiscuity accounting while down
      ipv6: fix device binding after failed datagram connect

Xiang Mei (5):
      libceph: bound mon_command ack decode to front len
      media: em28xx: reject audio endpoint with zero packet size
      media: go7007: only set audio_enabled if go7007_snd_init() succeeded
      fbdev: udlfb: don't rebuild the mode list while the framebuffer is in use
      ceph: fix integer overflow in the snap trace bounds check

Xiaoyan Li (1):
      selftests/net: Add SHA256 computation over data sent in tcp_mmap

Xingui Yang (1):
      scsi: libsas: Fix out-of-bounds memcpy() in sas_ssp_task_response()

Xiu Jianfeng (1):
      net: rds: add missing __init/__exit annotations to module init/exit funcs

Xiubo Li (3):
      ceph: do not cache negative dentries for snapped directories
      libceph: only set read_from_replica on read requests
      ceph: mark the superblock active after mounting

Xixin Liu (1):
      nvme: zns: cap zone report nr_zones by DMA buffer size

Xu Rao (2):
      mmc: block: reject invalid perdev_minors before division
      media: m2m-deinterlace: fix default capture field

Xu Wang (1):
      backlight: lm3630a_bl: Remove redundant 'flush_workqueue()' calls

Xueqin Luo (3):
      cpuidle: menu: Do not return a disabled idle state
      cpufreq: sparc-us2e: fix frequency table index copy-paste error
      cpufreq: sti: avoid NULL dereference in dev_err()

YANXIN LI (1):
      ufs: use u64 for directory size in ufs_last_byte

Yang Wang (3):
      drm/amd/pm: Validate Vega hwmgr PowerPlay table bounds
      drm/amd/pm: Validate Tonga PowerPlay state array bounds
      drm/amd/pm: Validate legacy hwmgr PP table offsets

Yang Xiuwei (1):
      floppy: avoid NULL deref in reset_interrupt when cont is cleared

Yang Yang (1):
      openvswitch: defer tunnel netdev_put to RCU release

Yang Zi (1):
      comedi: addi_apci_3xxx: fix subdevice count underallocation

Yao Yiqi (2):
      fbcon: Retry rotated font allocation after failure
      fbcon: Rebuild rotated font buffer on font change

Yaozhong Li (2):
      arm64: dts: rockchip: fix analog headphone output on rk3399-firefly
      arm64: dts: rockchip: disable unused i2s0 on rk3399-firefly

Yehyeong Lee (4):
      nvmet-fc: fix use-after-free in nvmet_fc_ls_create_connection()
      nvme-rdma: don't complete a request after a bogus remote invalidation
      9p/xen: validate the response size from the backend
      xen/pcifront: check that an AER callback exists before calling it

Yi Yang (1):
      serial: tegra: Add missing clk_disable_unprepare() in tegra_uart_hw_init()

Yibo Tan (1):
      fbdev: atmel_lcdfb: Prevent FIFO work after removal

Yichong Chen (1):
      exfat: free new directory cluster if zeroing fails

Yifei Gao (1):
      9p/xen: fix refcount leak in p9_xen_response() on wrong tag

Yili Zhang (1):
      RDMA/nldev: Fix NULL deref in dumps of objects abandoned by DRIVER_FAILURE

Yingjie Wang (4):
      net: unix: reject negative max_dgram_qlen values
      scsi: handle out-of-range SG_SET_TIMEOUT values
      scsi: bsg: Report synchronous data copyback failures
      nvmet: reject keep-alive timeouts that would overflow

Yinjie Yao (3):
      drm/amdgpu/jpeg: set no_user_fence for JPEG v3.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v2.5 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v2.0 ring

Yishai Hadas (5):
      RDMA/hns: Pin CQ buffer writable to match device DMA write access
      RDMA/mlx5: Set WQ event handler before firmware RQ insertion
      RDMA/mlx5: Set SRQ event handler before xarray insertion
      RDMA/mlx5: Set RQ event handler for raw-packet QP
      RDMA/mlx5: Initialize QP/RQ/SQ resource refcount before publishing it

Yixing Liu (1):
      RDMA/hns: Fix some print issues

Yizhou Zhao (1):
      9p/xen: drain response work after unbinding IRQ

Yoann Congal (1):
      printk: Fix LOG_CPU_MAX_BUF_SHIFT when BASE_SMALL is enabled

Yogesh Gaur (7):
      md/raid5: don't BUG() on an inconsistent reshape state from the superblock
      comedi: comedi_parport: validate the IRQ supplied by userspace
      comedi: ni_atmio16d: validate the IRQ supplied by userspace
      comedi: dt2814: validate the IRQ supplied by userspace
      comedi: dmm32at: validate the IRQ supplied by userspace
      comedi: pcmmio: validate the IRQ supplied by userspace
      comedi: pcmuio: validate the IRQs supplied by userspace

Yonghao Zhang (1):
      remoteproc: core: Set trace buffer name for diagnostics

Yongjian Mu (1):
      xprtrdma: trim head iovec when the payload arrives via a Write chunk

Youngsung Ahn (1):
      RDMA/rxe: bound the WQE opcode before indexing rxe_wr_opcode_info[]

Younho Choi (1):
      media: vim2m: keep transaction buffer count stable while streaming

Yousef Alhouseen (7):
      net: usb: rtl8150: handle link status read failures
      media: go7007: avoid undefined shifts in MPEG-4 headers
      misc: genwqe: handle a first DMA address of zero
      misc: hpilo: validate device queue entries before use
      misc: ibmvmc: reject oversized inbound messages
      media: go7007: s2250: propagate control I/O failures
      HID: hiddev: keep state alive through disconnect unlock

Youth Cao (1):
      HID: i2c-hid: Add i2c-hid-quirk-bad-input-size quirk for 0911:5288 device

Yu Kuai (1):
      md/raid5: reject zero-sector reshape chunks

Yu Zhang (1):
      scsi: target: Fix demo-mode dynamic ACL dev-entry UAF vs LUN teardown

Yuan Can (1):
      power: supply: ab8500: Fix error handling in ab8500_charger_init()

Yuan Chen (2):
      bpftool: Fix spurious batch file read error
      bpftool: Fix inverted tracefs validation when scanning /proc/mounts

YuanZhe Liu (7):
      ALSA: line6: Clear prev_fbuf on capture buffer release
      ALSA: us122l: Add missing NULL check in usb_stream_hwdep_mmap()
      ALSA: us122l: Fix NULL dereference at hwdep open and release
      ALSA: usx2y: Initialize idle URBs before submitting streams
      ALSA: usx2y: Refuse a retried DSP load after a failure
      ALSA: bcd2000: Fix use-after-free of MIDI URBs on file close
      ALSA: hwdep: Serialize DSP load requests

Yuanfu Xie (3):
      ceph: fail readdir when the MDS reply carries no dirfrag
      ceph: clamp MDS reply result code to the errno range
      9p: don't decrement a server-owned zero nlink

Yuanhe Shu (2):
      mm/page_alloc: do not boost watermarks in kdump capture kernels
      scsi: target: Verify the iSCSI ISID is null-terminated

Yuchao Zhang (2):
      xen-blkfront: unbind irq before tearing down ring and shadow requests
      md: validate bblog_size when loading v1.x badblocks metadata

Yucheng Lu (1):
      net/sched: sch_netem: fix out-of-bounds access in packet corruption

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

Yun Zhou (2):
      net: mvneta_bm: add suspend/resume support to prevent crash after resume
      ext4: set EXT4_STATE_NO_EXPAND in ext4_evict_inode

Yunpeng Tian (1):
      udf: validate the device specification EA before using it

Yunsheng Lin (1):
      RDMA/core: Remove 'device' argument from rdma_build_skb()

Yunye Zhao (1):
      md: add cond_resched() to md_do_sync()'s skip path

Yuto Ohnuki (1):
      virtiofs: add FUSE protocol validation

Zhang Yi (1):
      ext4: check return value of ext4_get_block() in ext4_load_tail_bh()

Zhao Gongyi (2):
      arm64: mm: validate /dev/mem mmap ranges without overflow
      ata: libata-scsi: reject data-in commands with a data-out buffer

Zhao Li (1):
      wifi: mac80211: shut down RX BA session timer on teardown

Zhao Zhang (1):
      9p: fix caches_show() out-of-bounds write

ZhaoJinming (1):
      crypto: caam - fix double-free in caam_rsa_set_priv_key_form()

Zhe Liu (2):
      docs: cgroup-v2: fix stale "io" controller introduction
      blk-iocost: account flush sequence latency only once

Zhengchao Shao (1):
      ip6mr: fix UAF issue in ip6mr_sk_done() when addrconf_init_net() failed

Zhenhao Wan (2):
      drm/nouveau: reject zero-size notifier object allocation
      drm/nouveau/svm: drain fault handler before freeing svmm

Zhihao Cheng (1):
      md/raid5: setup_conf: Fix null-ptr-def in error handling path

Zhiling Zou (3):
      tcp: check congestion control restriction first
      SUNRPC: trace an accepted transport before publishing it
      lib: validate in-memory LZ4 chunk length

Zhiwei Zhang (1):
      RDMA/rxe: Clear pkt->qp before the early drop exits in rxe_rcv()

Zhiyu Zhang (1):
      watch_queue: keep info_id separate from rcu_head

Zhongqiu Han (1):
      cpufreq: stats: Fix potential out-of-bounds access in deferred reset

Zhou Qiuyue (1):
      ipv6: raw: fix use-after-free in rawv6_send_hdrinc()

Zi Yan (1):
      USB: gadgetfs: do not WARN about excessively large memory allocations

Zihan Xi (1):
      net: gso: limit recursive IP-in-IP segmentation

Zijing Yin (2):
      SUNRPC: fix netns use-after-free in write_gssp()
      wifi: cfg80211: fix out-of-bounds read in valid_rule()

Zikang Gao (1):
      smb: client: do not pass a NULL buf to is_oplock_break()

Zixuan Chai (1):
      ipv6: defrag: orphan skb before queuing

Ziyang Xuan (1):
      can: raw: fix receiver memory leak

Zizhi Wo (1):
      fat: reject name longer than NAME_MAX in msdos_format_name()

Zongmin Zhou (2):
      slimbus: messaging: fix leaked PM vote on tid allocation failure
      serial: sifive: fix off-by-one in console port bounds check

bui duc phuc (16):
      ASoC: stm: stm32_i2s: Drop redundant error messages
      ASoC: mediatek: mt6797: fix wrong unwind order and error code in enable_clock
      ASoC: mediatek: mt8183: Fix wrong clock cleanup on clk_set_parent() failure
      ASoC: mediatek: mt8183: Fix clock handling in mux disable path
      ASoC: mediatek: mt8183: Fix APLL enable error handling
      ASoC: rockchip: rockchip_i2s: Handle runtime PM resume failures in set_fmt
      ASoC: mediatek: common: Handle constraint return value in FE startup
      ASoC: codecs: rt5659: propagate GPIO errors
      ASoC: amd: raven: Fix acp3x_dma_close() being skipped on rollback
      ASoC: amd: renoir: Fix acp_pdm_dma_close() being skipped on rollback
      ASoC: atmel: atmel-pcm-pdc: Fix atmel_pcm_close() being skipped on rollback
      ASoC: atmel-i2s: fix MCK generator error handling
      ASoC: atmel-i2s: use optional API for muxclk
      ASoC: atmel-i2s: use optional API for gclk
      ASoC: amd: raven: Fix memory leak in acp3x_dma_close()
      ASoC: xilinx: formatter_pcm: Fix read-modify-write of AUD_CTRL in hw_params

guolingxing (2):
      btrfs: sysfs: restore NOFS context on early return in btrfs_sysfs_add_block_group_type()
      btrfs: prevent deleting the wrong subvolume by ID

liulhong617 (1):
      arm64: mm: fix accidental linear mapping of no-map reserved memory

owen kwan (1):
      net/sched: sch_teql: fix use-after-free on lower qdisc drop

renpanpan (1):
      drm/amdgpu: Only enable HDMI audio if display supports it

sung byeongchan (3):
      ceph: bound name skips in ceph_mdsmap_decode() by the message end
      ceph: validate encoded xattr name lengths
      ceph: validate MDS reply fragtree split array length

tangmeng (1):
      timers: Move timer sysctl into the timer code

wangdicheng (1):
      ALSA: hda/conexant: Add NULL check for dc_mode_path

xiongxin (1):
      gpio: dwapb: mask/unmask IRQ when disable/enale it

Ömer Mete Kaya (2):
      usbnet: fix smp_processor_id() use in preemptible context
      usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()

イムティヤズ (1):
      wifi: rtw88: fix out-of-bounds CAM write when key table is full

이상호 (1):
      romfs: detect hard link cycles

