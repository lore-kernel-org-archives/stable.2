Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335330;
	b=uJHSb7yv5hYbX/w31t9t4ZVQx23IcKc2K54y6FtEMCxmgnE+H0CMNDppWqqdAzO4sE+8
	 xexfRzwlF+1pzwN0gj/OAHytC7VZCIrpXPDiyTKNS3OaOxid53nQLBiowulfMqvzwjFVp
	 AZmBWhuT8TXOLF2Idbbbn5i65nz3fobenYGg3KlzUZtdXjq/f/vAM9+etOInhLrL/wTwL
	 qIij2jlepT6ANzEWIBDdZixm/twPQcR7YbbDRp49/jsJ4zTbgr72y+nIYdp52ijmkcuiN
	 v/lGu1pHy47rCfCRL2JSTrXJtEbBSxemKw8reKVEALSAdhAcyp00E8DFED4gYJFjWYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335330;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BOuU33t0/rAmtpfCxOOrkQO/FBGp7bBA+1O9rXGh0mA=;
	b=hj8RNaqAakFmsiPfbHg2eZKUCZqUPclUkgBGaaLwaOqwVJR6AnRmJSYW2LI2RThgybSH
	 eZR5t2OG1e8x0n9cNaGfA5UooIjaS1yLm3RE9McOWqArnD9pjIjw27HNKCOHZuQvuZCkZ
	 kJDWVaoLrwW6IPRautQqnErx4ILnjVJ0JCmNdLX3jumSVRuY+x0NBX9QcEssUuYt7xn2A
	 5e0VgzeuNzxzwArWAK5vOdwrbAR5L4ZGHKdeb90JQ0/cKhMxX695+JAIaJOP2Gl2SMTAb
	 9ETRZO4buNxNYfKCut4PlWBbAYLgyU1El62SCAX/PM4VYNWXWokVuiym98ovOfCBAig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zanAPdEy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C896606A327;
	Tue, 10 Nov 2026 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zanAPdEy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE411F0089F;
	Tue, 10 Nov 2026 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794335329;
	bh=BOuU33t0/rAmtpfCxOOrkQO/FBGp7bBA+1O9rXGh0mA=;
	h=From:To:Cc:Subject:Date;
	b=zanAPdEyZeAHbz6KMVQJFxnYOmZfHwZvy9utbLOaGRTlQuOpIS5K5OKGSCAYidR5F
	 ko/lAkDDAcmlUAGeI8gtXI6CzkigPpRb8XBsEtbJT0V+tH3Z+1Jydys4tqCsEiB8tE
	 iDKDKz7CXueI/R1PB4d0AEU73hJ0Z+0qKw32AN6I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.117
Date: Tue, 10 Nov 2026 13:28:43 -0500
Message-ID: <2026111044-whinny-thinness-bff9@gregkh>
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

I'm announcing the release of the 6.12.117 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/cgroup-v2.rst                                        |   10 
 Documentation/block/blk-mq.rst                                                 |    2 
 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml                |   16 
 Documentation/networking/ip-sysctl.rst                                         |    5 
 Documentation/networking/rxrpc.rst                                             |   13 
 Documentation/virt/hyperv/vmbus.rst                                            |   17 
 Makefile                                                                       |    5 
 arch/alpha/include/asm/mmu_context.h                                           |   35 
 arch/alpha/include/asm/sfp-machine.h                                           |    4 
 arch/alpha/include/asm/switch_to.h                                             |    1 
 arch/alpha/include/asm/tlbflush.h                                              |    3 
 arch/alpha/kernel/rtc.c                                                        |   37 
 arch/alpha/kernel/smp.c                                                        |   67 
 arch/alpha/mm/fault.c                                                          |   23 
 arch/alpha/mm/tlbflush.c                                                       |   18 
 arch/arm/include/asm/smp.h                                                     |    2 
 arch/arm/kernel/head-nommu.S                                                   |    1 
 arch/arm/kernel/head.S                                                         |    1 
 arch/arm/kernel/smp.c                                                          |   15 
 arch/arm/mach-omap2/sleep44xx.S                                                |    5 
 arch/arm/mm/alignment.c                                                        |   51 
 arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi                         |    7 
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi                                      |    1 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi                   |    6 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts                             |    6 
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts                                       |    2 
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi                                |    2 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                                     |    6 
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts                                 |    6 
 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi                               |    2 
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                                        |    5 
 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi                             |    2 
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi                                 |    2 
 arch/arm64/crypto/poly1305-armv8.pl                                            |    2 
 arch/arm64/include/asm/kvm_host.h                                              |    7 
 arch/arm64/include/asm/pgtable.h                                               |    3 
 arch/arm64/kernel/efi.c                                                        |    8 
 arch/arm64/kvm/arm.c                                                           |   31 
 arch/arm64/kvm/hyp/nvhe/setup.c                                                |   10 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                             |   33 
 arch/arm64/mm/contpte.c                                                        |    4 
 arch/arm64/mm/mmu.c                                                            |   14 
 arch/loongarch/include/asm/barrier.h                                           |    3 
 arch/loongarch/include/asm/hw_breakpoint.h                                     |    4 
 arch/loongarch/include/asm/loongarch.h                                         |    4 
 arch/loongarch/include/asm/numa.h                                              |    2 
 arch/loongarch/include/asm/pgtable.h                                           |    2 
 arch/loongarch/kernel/hw_breakpoint.c                                          |   27 
 arch/loongarch/kernel/irq.c                                                    |    3 
 arch/loongarch/kernel/traps.c                                                  |   13 
 arch/loongarch/kvm/vcpu.c                                                      |   38 
 arch/loongarch/mm/init.c                                                       |   17 
 arch/loongarch/pci/pci.c                                                       |    3 
 arch/microblaze/kernel/entry.S                                                 |   19 
 arch/microblaze/kernel/signal.c                                                |   26 
 arch/mips/Kconfig                                                              |    1 
 arch/mips/mm/tlb-r4k.c                                                         |   21 
 arch/powerpc/kvm/book3s_hv.c                                                   |   76 
 arch/powerpc/kvm/book3s_paired_singles.c                                       |    7 
 arch/powerpc/platforms/pseries/plpks.c                                         |   27 
 arch/powerpc/platforms/pseries/plpks_sed_ops.c                                 |   12 
 arch/riscv/include/asm/pgtable.h                                               |    9 
 arch/riscv/kernel/traps.c                                                      |    3 
 arch/riscv/kvm/mmu.c                                                           |    2 
 arch/riscv/kvm/vcpu_exit.c                                                     |    2 
 arch/riscv/kvm/vcpu_pmu.c                                                      |    9 
 arch/riscv/kvm/vcpu_sbi_replace.c                                              |   12 
 arch/riscv/net/bpf_jit_comp32.c                                                |   47 
 arch/s390/include/asm/gmap.h                                                   |    3 
 arch/s390/include/asm/uv.h                                                     |    6 
 arch/s390/kernel/perf_cpum_cf.c                                                |    3 
 arch/s390/kernel/process.c                                                     |   12 
 arch/s390/kernel/signal.c                                                      |    6 
 arch/s390/kernel/uv.c                                                          |  363 
 arch/s390/kvm/Makefile                                                         |    2 
 arch/s390/kvm/gaccess.c                                                        |   42 
 arch/s390/kvm/gmap.c                                                           |  121 
 arch/s390/kvm/gmap.h                                                           |   19 
 arch/s390/kvm/intercept.c                                                      |    3 
 arch/s390/kvm/kvm-s390.c                                                       |  156 
 arch/s390/kvm/kvm-s390.h                                                       |    6 
 arch/s390/kvm/pv.c                                                             |   21 
 arch/s390/lib/probes.c                                                         |    2 
 arch/s390/mm/gmap.c                                                            |   45 
 arch/x86/events/core.c                                                         |   19 
 arch/x86/events/intel/lbr.c                                                    |    2 
 arch/x86/events/intel/uncore.c                                                 |    5 
 arch/x86/include/asm/cpufeatures.h                                             |    2 
 arch/x86/include/asm/kvm_host.h                                                |   18 
 arch/x86/include/asm/vmx.h                                                     |    8 
 arch/x86/kernel/cpu/amd.c                                                      |    9 
 arch/x86/kernel/cpu/common.c                                                   |    6 
 arch/x86/kernel/cpu/scattered.c                                                |    1 
 arch/x86/kernel/process.c                                                      |    1 
 arch/x86/kvm/cpuid.c                                                           |    3 
 arch/x86/kvm/hyperv.c                                                          |    5 
 arch/x86/kvm/mmu/mmu.c                                                         |   29 
 arch/x86/kvm/mmu/paging_tmpl.h                                                 |   39 
 arch/x86/kvm/regs.c                                                            |    3 
 arch/x86/kvm/reverse_cpuid.h                                                   |    2 
 arch/x86/kvm/svm/nested.c                                                      |   15 
 arch/x86/kvm/svm/sev.c                                                         |   73 
 arch/x86/kvm/svm/svm.c                                                         |   35 
 arch/x86/kvm/svm/svm.h                                                         |    1 
 arch/x86/kvm/vmx/nested.c                                                      |   41 
 arch/x86/kvm/vmx/vmx.c                                                         |    9 
 arch/x86/kvm/x86.c                                                             |   82 
 arch/x86/kvm/xen.c                                                             |   18 
 arch/x86/mm/pat/set_memory.c                                                   |   23 
 block/bdev.c                                                                   |   12 
 block/blk-crypto-fallback.c                                                    |    6 
 block/blk-iocost.c                                                             |    2 
 block/blk-mq.c                                                                 |    2 
 crypto/algif_skcipher.c                                                        |    8 
 drivers/accessibility/speakup/selection.c                                      |    6 
 drivers/acpi/acpi_fpdt.c                                                       |   53 
 drivers/acpi/apei/ghes.c                                                       |   10 
 drivers/acpi/battery.c                                                         |   14 
 drivers/acpi/button.c                                                          |   11 
 drivers/acpi/pfr_update.c                                                      |    2 
 drivers/acpi/sysfs.c                                                           |    9 
 drivers/acpi/video_detect.c                                                    |    8 
 drivers/ata/ahci_st.c                                                          |   78 
 drivers/ata/ata_generic.c                                                      |    6 
 drivers/ata/libahci.c                                                          |   28 
 drivers/ata/libahci_platform.c                                                 |    4 
 drivers/ata/libata-core.c                                                      |   75 
 drivers/ata/libata-scsi.c                                                      |    5 
 drivers/ata/libata-sff.c                                                       |    5 
 drivers/ata/pata_ep93xx.c                                                      |   30 
 drivers/ata/sata_fsl.c                                                         |   24 
 drivers/ata/sata_qstor.c                                                       |    8 
 drivers/base/attribute_container.c                                             |    7 
 drivers/base/base.h                                                            |    1 
 drivers/base/bus.c                                                             |   35 
 drivers/base/core.c                                                            |    4 
 drivers/base/dd.c                                                              |   92 
 drivers/base/regmap/regcache-maple.c                                           |    2 
 drivers/base/regmap/regmap-debugfs.c                                           |    1 
 drivers/base/regmap/regmap.c                                                   |   15 
 drivers/block/aoe/aoenet.c                                                     |   14 
 drivers/block/floppy.c                                                         |    8 
 drivers/block/loop.c                                                           |    6 
 drivers/block/xen-blkfront.c                                                   |   16 
 drivers/bluetooth/btrsi.c                                                      |    3 
 drivers/bluetooth/btusb.c                                                      |    8 
 drivers/bluetooth/hci_bcsp.c                                                   |    5 
 drivers/bluetooth/hci_nokia.c                                                  |   20 
 drivers/bluetooth/hci_vhci.c                                                   |    4 
 drivers/bus/mhi/host/pm.c                                                      |   14 
 drivers/char/hw_random/amd-rng.c                                               |    2 
 drivers/char/hw_random/ba431-rng.c                                             |    2 
 drivers/char/hw_random/core.c                                                  |    1 
 drivers/char/ipmi/ipmi_msghandler.c                                            |    1 
 drivers/char/tpm/tpm-dev-common.c                                              |    3 
 drivers/char/tpm/tpm_nsc.c                                                     |    8 
 drivers/char/tpm/tpm_tis_spi.h                                                 |    8 
 drivers/char/virtio_console.c                                                  |   13 
 drivers/clk/imx/clk-imx8qxp-lpcg.c                                             |    1 
 drivers/clk/imx/clk-imx8qxp.c                                                  |    1 
 drivers/clk/imx/clk.c                                                          |   15 
 drivers/clk/mstar/clk-msc313-mpll.c                                            |    2 
 drivers/clk/mvebu/ap-cpu-clk.c                                                 |    4 
 drivers/clk/qcom/gcc-ipq5018.c                                                 |   10 
 drivers/clk/qcom/gcc-ipq5332.c                                                 |    1 
 drivers/clk/starfive/clk-starfive-jh7110-isp.c                                 |    2 
 drivers/clk/sunxi-ng/ccu_common.c                                              |   12 
 drivers/clk/tegra/clk-pll.c                                                    |    1 
 drivers/clk/zynq/clkc.c                                                        |    8 
 drivers/clocksource/timer-digicolor.c                                          |    2 
 drivers/clocksource/timer-fttmr010.c                                           |    2 
 drivers/comedi/drivers/aio_iiro_16.c                                           |    3 
 drivers/comedi/drivers/das6402.c                                               |   10 
 drivers/comedi/drivers/dt2811.c                                                |    7 
 drivers/comedi/drivers/ni_at_a2150.c                                           |   13 
 drivers/comedi/drivers/ni_atmio16d.c                                           |    3 
 drivers/comedi/drivers/pcl711.c                                                |    3 
 drivers/comedi/drivers/pcl816.c                                                |    3 
 drivers/comedi/drivers/pcl818.c                                                |    3 
 drivers/comedi/drivers/pcmmio.c                                                |    3 
 drivers/comedi/drivers/pcmuio.c                                                |    5 
 drivers/comedi/drivers/quatech_daqp_cs.c                                       |    4 
 drivers/cpufreq/Kconfig                                                        |    1 
 drivers/cpufreq/amd-pstate.c                                                   |    6 
 drivers/cpufreq/cpufreq_conservative.c                                         |    8 
 drivers/cpufreq/cpufreq_governor.c                                             |   29 
 drivers/cpufreq/cpufreq_governor.h                                             |    2 
 drivers/cpufreq/cpufreq_stats.c                                                |    4 
 drivers/cpufreq/intel_pstate.c                                                 |    2 
 drivers/cpufreq/loongson3_cpufreq.c                                            |   73 
 drivers/crypto/amlogic/amlogic-gxl-core.c                                      |    7 
 drivers/crypto/atmel-aes.c                                                     |    2 
 drivers/crypto/atmel-tdes.c                                                    |    6 
 drivers/crypto/caam/caampkc.c                                                  |    6 
 drivers/crypto/ccp/dbc.c                                                       |    4 
 drivers/crypto/hisilicon/hpre/hpre_crypto.c                                    |   20 
 drivers/crypto/intel/keembay/keembay-ocs-aes-core.c                            |    3 
 drivers/crypto/intel/keembay/keembay-ocs-ecc.c                                 |    1 
 drivers/crypto/intel/keembay/ocs-aes.c                                         |    3 
 drivers/crypto/intel/qat/qat_common/adf_dev_mgr.c                              |   10 
 drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c                          |    5 
 drivers/crypto/intel/qat/qat_common/adf_vf_isr.c                               |    2 
 drivers/crypto/nx/nx-842.c                                                     |    2 
 drivers/crypto/sa2ul.c                                                         |    3 
 drivers/cxl/acpi.c                                                             |   20 
 drivers/cxl/core/pci.c                                                         |   22 
 drivers/cxl/core/port.c                                                        |    3 
 drivers/dax/super.c                                                            |    2 
 drivers/dma/altera-msgdma.c                                                    |   10 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                                 |    2 
 drivers/dma/pl330.c                                                            |   19 
 drivers/edac/edac_mc.c                                                         |    6 
 drivers/edac/i10nm_base.c                                                      |    1 
 drivers/firewire/ohci-serdes-test.c                                            |    4 
 drivers/firewire/ohci.h                                                        |    2 
 drivers/firmware/efi/libstub/efi-stub.c                                        |    8 
 drivers/firmware/imx/imx-scu.c                                                 |   25 
 drivers/fpga/fpga-mgr.c                                                        |    2 
 drivers/gpio/gpio-davinci.c                                                    |    6 
 drivers/gpio/gpio-mvebu.c                                                      |   33 
 drivers/gpio/gpio-pca953x.c                                                    |   14 
 drivers/gpio/gpio-pca9570.c                                                    |    2 
 drivers/gpio/gpio-sifive.c                                                     |    1 
 drivers/gpio/gpiolib.c                                                         |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                                       |   68 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c                             |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                               |   18 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c                                       |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                                    |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                     |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                        |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c                                        |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c                                     |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                                        |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                        |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c                                    |    5 
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c                                     |   59 
 drivers/gpu/drm/amd/amdgpu/cik.c                                               |   10 
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                                          |    2 
 drivers/gpu/drm/amd/amdgpu/vi.c                                                |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                       |   36 
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c                                          |   35 
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c                                      |   23 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c                               |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c                               |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c                               |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c                                |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c                                |    7 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                                          |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                                       |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c                                         |   23 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                           |   29 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                              |   11 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c                      |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c                    |    3 
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c                          |    7 
 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c                           |    2 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c                      |    8 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c |    2 
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c                        |    3 
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_6_0_0_offset.h                    |15799 ++
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_6_0_0_sh_mask.h                   |58556 ++++++++++
 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_6_0_0_offset.h                  |   47 
 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_6_0_0_sh_mask.h                 |   55 
 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_5_0_1_offset.h                |   17 
 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_5_0_1_sh_mask.h               |   17 
 drivers/gpu/drm/amd/include/kgd_pp_interface.h                                 |    1 
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                                            |   23 
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h                                        |    2 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                               |   21 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c                            |   28 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c                 |  675 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c                       |  446 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c                            |   34 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c                          |   46 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c                |  623 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c                |    7 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c                |    7 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                                      |   19 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                           |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                           |    4 
 drivers/gpu/drm/arm/malidp_crtc.c                                              |    1 
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c                             |   13 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                                          |   16 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h                                          |    6 
 drivers/gpu/drm/i915/display/intel_dmc.c                                       |   55 
 drivers/gpu/drm/i915/display/intel_dmc_regs.h                                  |   12 
 drivers/gpu/drm/i915/display/intel_dp_mst.c                                    |   21 
 drivers/gpu/drm/i915/display/intel_dp_mst.h                                    |    2 
 drivers/gpu/drm/i915/display/intel_link_bw.c                                   |    4 
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c                                      |    2 
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c                                         |    2 
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                                            |   16 
 drivers/gpu/drm/msm/msm_ringbuffer.c                                           |    2 
 drivers/gpu/drm/msm/msm_ringbuffer.h                                           |    1 
 drivers/gpu/drm/nouveau/nouveau_abi16.c                                        |    4 
 drivers/gpu/drm/nouveau/nouveau_connector.c                                    |    1 
 drivers/gpu/drm/nouveau/nouveau_dp.c                                           |    4 
 drivers/gpu/drm/nouveau/nouveau_fence.c                                        |    2 
 drivers/gpu/drm/nouveau/nouveau_svm.c                                          |   13 
 drivers/gpu/drm/panel/panel-edp.c                                              |    2 
 drivers/gpu/drm/panel/panel-simple.c                                           |    3 
 drivers/gpu/drm/panthor/panthor_sched.c                                        |   14 
 drivers/gpu/drm/radeon/atombios_crtc.c                                         |    5 
 drivers/gpu/drm/radeon/atombios_encoders.c                                     |   23 
 drivers/gpu/drm/radeon/r600_dpm.c                                              |   21 
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c                                    |    7 
 drivers/gpu/drm/ttm/ttm_bo_util.c                                              |   11 
 drivers/gpu/drm/virtio/virtgpu_drv.h                                           |    1 
 drivers/gpu/drm/virtio/virtgpu_kms.c                                           |    1 
 drivers/gpu/drm/virtio/virtgpu_vq.c                                            |   15 
 drivers/gpu/drm/xe/display/intel_fb_bo.c                                       |    3 
 drivers/gpu/drm/xe/display/xe_fb_pin.c                                         |    3 
 drivers/gpu/drm/xe/xe_exec_queue_types.h                                       |   12 
 drivers/gpu/drm/xe/xe_preempt_fence.c                                          |    7 
 drivers/gpu/drm/xe/xe_vm.c                                                     |   18 
 drivers/gpu/host1x/hw/cdma_hw.c                                                |    2 
 drivers/greybus/manifest.c                                                     |    2 
 drivers/hid/amd-sfh-hid/amd_sfh_client.c                                       |    4 
 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h                      |    2 
 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h               |    7 
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c                             |    6 
 drivers/hid/hid-core.c                                                         |    4 
 drivers/hid/hid-cougar.c                                                       |    3 
 drivers/hid/hid-cp2112.c                                                       |    9 
 drivers/hid/hid-elo.c                                                          |    3 
 drivers/hid/hid-ids.h                                                          |    6 
 drivers/hid/hid-input.c                                                        |   17 
 drivers/hid/hid-logitech-dj.c                                                  |    3 
 drivers/hid/hid-logitech-hidpp.c                                               |    2 
 drivers/hid/hid-mcp2200.c                                                      |    5 
 drivers/hid/hid-mcp2221.c                                                      |    2 
 drivers/hid/hid-multitouch.c                                                   |   19 
 drivers/hid/hid-picolcd_fb.c                                                   |   12 
 drivers/hid/hid-prodikeys.c                                                    |    7 
 drivers/hid/hid-pxrc.c                                                         |    3 
 drivers/hid/hid-quirks.c                                                       |    4 
 drivers/hid/hid-rmi.c                                                          |    2 
 drivers/hid/hid-roccat-isku.c                                                  |    3 
 drivers/hid/hid-roccat-koneplus.c                                              |    3 
 drivers/hid/hid-roccat-konepure.c                                              |    3 
 drivers/hid/hid-roccat-kovaplus.c                                              |    3 
 drivers/hid/hid-roccat-pyra.c                                                  |    3 
 drivers/hid/hid-roccat-ryos.c                                                  |    3 
 drivers/hid/hid-roccat-savu.c                                                  |    3 
 drivers/hid/hid-roccat.c                                                       |    8 
 drivers/hid/hid-zydacron.c                                                     |    3 
 drivers/hid/i2c-hid/i2c-hid-core.c                                             |    4 
 drivers/hid/intel-ish-hid/ishtp-hid-client.c                                   |    5 
 drivers/hid/usbhid/hiddev.c                                                    |   37 
 drivers/hid/wacom_sys.c                                                        |  198 
 drivers/hid/wacom_wac.c                                                        |   99 
 drivers/hid/wacom_wac.h                                                        |    6 
 drivers/hsi/controllers/omap_ssi_core.c                                        |    3 
 drivers/hte/hte-tegra194.c                                                     |   10 
 drivers/hv/ring_buffer.c                                                       |   29 
 drivers/hwmon/asus_rog_ryujin.c                                                |   22 
 drivers/hwmon/coretemp.c                                                       |   31 
 drivers/hwmon/corsair-cpro.c                                                   |    9 
 drivers/hwmon/gigabyte_waterforce.c                                            |    5 
 drivers/hwmon/lm95245.c                                                        |    6 
 drivers/hwmon/sht3x.c                                                          |    5 
 drivers/i2c/busses/i2c-designware-master.c                                     |    8 
 drivers/i2c/busses/i2c-imx-lpi2c.c                                             |   21 
 drivers/i2c/busses/i2c-mt7621.c                                                |    9 
 drivers/i2c/busses/i2c-qcom-cci.c                                              |   24 
 drivers/i2c/i2c-core-acpi.c                                                    |    7 
 drivers/i3c/master.c                                                           |    3 
 drivers/iio/accel/adis16201.c                                                  |   10 
 drivers/iio/accel/adxl313_spi.c                                                |    2 
 drivers/iio/accel/adxl380_spi.c                                                |    2 
 drivers/iio/accel/fxls8962af-core.c                                            |    2 
 drivers/iio/accel/kxcjk-1013.c                                                 |    1 
 drivers/iio/accel/mma9551.c                                                    |    1 
 drivers/iio/accel/mma9553.c                                                    |    1 
 drivers/iio/adc/adi-axi-adc.c                                                  |    4 
 drivers/iio/adc/at91-sama5d2_adc.c                                             |    1 
 drivers/iio/adc/max11205.c                                                     |    2 
 drivers/iio/adc/max1241.c                                                      |    1 
 drivers/iio/adc/mcp3911.c                                                      |    2 
 drivers/iio/adc/stm32-adc.c                                                    |    4 
 drivers/iio/adc/ti-adc128s052.c                                                |    8 
 drivers/iio/dac/ad5755.c                                                       |    3 
 drivers/iio/frequency/adf4377.c                                                |    3 
 drivers/iio/imu/inv_icm42600/inv_icm42600.h                                    |    1 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c                              |   17 
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c                             |    2 
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c                               |    9 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c                               |    8 
 drivers/iio/light/apds9306.c                                                   |    2 
 drivers/iio/light/hid-sensor-als.c                                             |   22 
 drivers/iio/potentiometer/x9250.c                                              |    7 
 drivers/iio/pressure/bmp280-spi.c                                              |    2 
 drivers/infiniband/hw/hfi1/fault.c                                             |    1 
 drivers/infiniband/sw/rxe/rxe_mw.c                                             |   20 
 drivers/input/joystick/xpad.c                                                  |    1 
 drivers/input/keyboard/matrix_keypad.c                                         |    3 
 drivers/iommu/amd/amd_iommu_types.h                                            |    1 
 drivers/iommu/amd/iommu.c                                                      |   38 
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c                                 |   16 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                                     |    1 
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                                        |   18 
 drivers/iommu/dma-iommu.c                                                      |   20 
 drivers/iommu/intel/cache.c                                                    |    5 
 drivers/iommu/intel/iommu.h                                                    |   17 
 drivers/iommu/iommufd/fault.c                                                  |    4 
 drivers/iommu/iommufd/io_pagetable.c                                           |    3 
 drivers/iommu/rockchip-iommu.c                                                 |   13 
 drivers/ipack/devices/ipoctal.c                                                |   16 
 drivers/irqchip/irq-gic-v3-its.c                                               |    2 
 drivers/irqchip/irq-imx-intmux.c                                               |   15 
 drivers/irqchip/irq-mchp-eic.c                                                 |    4 
 drivers/irqchip/irq-msi-lib.c                                                  |    1 
 drivers/irqchip/irq-riscv-imsic-platform.c                                     |    2 
 drivers/leds/flash/leds-ktd2692.c                                              |   10 
 drivers/mailbox/mtk-cmdq-mailbox.c                                             |    7 
 drivers/mailbox/qcom-ipcc.c                                                    |    6 
 drivers/md/dm-bufio.c                                                          |    4 
 drivers/md/dm-integrity.c                                                      |   55 
 drivers/md/dm-snap-persistent.c                                                |    7 
 drivers/md/dm-vdo/indexer/chapter-index.c                                      |   15 
 drivers/md/dm-vdo/indexer/delta-index.c                                        |   17 
 drivers/md/dm-vdo/indexer/volume.c                                             |    6 
 drivers/md/dm-writecache.c                                                     |   54 
 drivers/md/dm.c                                                                |    2 
 drivers/md/md.c                                                                |   21 
 drivers/md/raid5-cache.c                                                       |   34 
 drivers/md/raid5.c                                                             |   13 
 drivers/md/raid5.h                                                             |    1 
 drivers/media/cec/core/cec-adap.c                                              |    1 
 drivers/media/cec/platform/stm32/stm32-cec.c                                   |   16 
 drivers/media/cec/platform/tegra/tegra_cec.c                                   |   14 
 drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c              |    4 
 drivers/media/common/saa7146/saa7146_core.c                                    |    3 
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c                                  |   14 
 drivers/media/dvb-core/dmxdev.c                                                |   11 
 drivers/media/dvb-frontends/stv0900_core.c                                     |    2 
 drivers/media/dvb-frontends/stv090x.c                                          |    2 
 drivers/media/i2c/adv7180.c                                                    |    2 
 drivers/media/i2c/adv7604.c                                                    |    3 
 drivers/media/i2c/alvium-csi2.c                                                |    1 
 drivers/media/i2c/ov8856.c                                                     |    3 
 drivers/media/i2c/ov8865.c                                                     |   44 
 drivers/media/i2c/tc358743.c                                                   |    3 
 drivers/media/pci/cx18/cx18-driver.c                                           |    9 
 drivers/media/pci/cx18/cx18-vbi.c                                              |    2 
 drivers/media/pci/cx23885/cx23885-core.c                                       |    4 
 drivers/media/pci/cx23885/cx23885-dvb.c                                        |   14 
 drivers/media/pci/cx88/cx88-mpeg.c                                             |   10 
 drivers/media/pci/intel/ipu-bridge.c                                           |    2 
 drivers/media/pci/ivtv/ivtv-vbi.c                                              |    2 
 drivers/media/pci/tw68/tw68-core.c                                             |    2 
 drivers/media/pci/tw686x/tw686x-core.c                                         |   10 
 drivers/media/platform/amphion/vpu_core.c                                      |   19 
 drivers/media/platform/amphion/vpu_drv.c                                       |    1 
 drivers/media/platform/atmel/atmel-isi.c                                       |    7 
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c                       |   24 
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c                       |    6 
 drivers/media/platform/imagination/e5010-jpeg-enc.c                            |    4 
 drivers/media/platform/m2m-deinterlace.c                                       |    2 
 drivers/media/platform/marvell/Kconfig                                         |    1 
 drivers/media/platform/marvell/mcam-core.c                                     |   14 
 drivers/media/platform/marvell/mmp-driver.c                                    |    5 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c                           |   17 
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c                           |   14 
 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c            |    2 
 drivers/media/platform/mediatek/vpu/mtk_vpu.c                                  |    2 
 drivers/media/platform/microchip/microchip-csi2dc.c                            |    1 
 drivers/media/platform/microchip/microchip-isc-base.c                          |   62 
 drivers/media/platform/microchip/microchip-isc-clk.c                           |    7 
 drivers/media/platform/microchip/microchip-isc.h                               |    1 
 drivers/media/platform/microchip/microchip-sama5d2-isc.c                       |   28 
 drivers/media/platform/microchip/microchip-sama7g5-isc.c                       |   28 
 drivers/media/platform/nuvoton/npcm-video.c                                    |    9 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                                 |   23 
 drivers/media/platform/qcom/camss/camss-vfe-17x.c                              |    5 
 drivers/media/platform/qcom/camss/camss-vfe.c                                  |   14 
 drivers/media/platform/samsung/exynos4-is/fimc-lite.c                          |    3 
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c                               |    4 
 drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c                          |    7 
 drivers/media/platform/ti/davinci/vpif_capture.c                               |    5 
 drivers/media/platform/ti/davinci/vpif_display.c                               |    3 
 drivers/media/platform/verisilicon/hantro_drv.c                                |    9 
 drivers/media/platform/verisilicon/hantro_g1_mpeg2_dec.c                       |    5 
 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c                |   68 
 drivers/media/rc/bpf-lirc.c                                                    |   18 
 drivers/media/rc/fintek-cir.c                                                  |    4 
 drivers/media/rc/imon.c                                                        |    5 
 drivers/media/rc/ir-hix5hd2.c                                                  |    5 
 drivers/media/rc/ir-mce_kbd-decoder.c                                          |    5 
 drivers/media/rc/ir_toy.c                                                      |    2 
 drivers/media/rc/lirc_dev.c                                                    |    3 
 drivers/media/rc/meson-ir-tx.c                                                 |   20 
 drivers/media/rc/rc-ir-raw.c                                                   |   66 
 drivers/media/rc/rc-main.c                                                     |   42 
 drivers/media/rc/redrat3.c                                                     |   21 
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
 drivers/media/usb/au0828/au0828-dvb.c                                          |   20 
 drivers/media/usb/cx231xx/cx231xx-audio.c                                      |   15 
 drivers/media/usb/cx231xx/cx231xx-cards.c                                      |    2 
 drivers/media/usb/cx231xx/cx231xx.h                                            |    2 
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c                                        |   14 
 drivers/media/usb/em28xx/em28xx-audio.c                                        |    7 
 drivers/media/usb/em28xx/em28xx-cards.c                                        |    2 
 drivers/media/usb/em28xx/em28xx-core.c                                         |    3 
 drivers/media/usb/em28xx/em28xx-video.c                                        |   26 
 drivers/media/usb/go7007/go7007-driver.c                                       |    5 
 drivers/media/usb/go7007/go7007-fw.c                                           |   28 
 drivers/media/usb/go7007/go7007-usb.c                                          |    8 
 drivers/media/usb/go7007/s2250-board.c                                         |   54 
 drivers/media/usb/gspca/gspca.c                                                |    3 
 drivers/media/usb/hackrf/hackrf.c                                              |    7 
 drivers/media/usb/pvrusb2/pvrusb2-sysfs.c                                      |    1 
 drivers/media/usb/usbtv/usbtv-core.c                                           |    6 
 drivers/media/usb/usbtv/usbtv-video.c                                          |    4 
 drivers/media/usb/uvc/uvc_ctrl.c                                               |    2 
 drivers/media/v4l2-core/v4l2-common.c                                          |    2 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                                      |   12 
 drivers/memory/brcmstb_dpfe.c                                                  |   24 
 drivers/mfd/axp20x.c                                                           |    2 
 drivers/mfd/da903x.c                                                           |   34 
 drivers/mfd/ipaq-micro.c                                                       |    2 
 drivers/mfd/tps65217.c                                                         |   69 
 drivers/mfd/wcd934x.c                                                          |    8 
 drivers/misc/bcm-vk/bcm_vk_msg.c                                               |   18 
 drivers/misc/genwqe/card_utils.c                                               |    2 
 drivers/misc/hpilo.c                                                           |    7 
 drivers/misc/ibmvmc.c                                                          |   17 
 drivers/misc/mei/vsc-tp.c                                                      |    2 
 drivers/mmc/core/block.c                                                       |    5 
 drivers/mmc/host/cqhci-core.c                                                  |   14 
 drivers/mmc/host/dw_mmc.c                                                      |    1 
 drivers/mmc/host/moxart-mmc.c                                                  |   11 
 drivers/mmc/host/sdhci-of-ma35d1.c                                             |    1 
 drivers/mtd/chips/cfi_cmdset_0002.c                                            |   15 
 drivers/mtd/maps/amd76xrom.c                                                   |    2 
 drivers/mtd/maps/l440gx.c                                                      |    2 
 drivers/mtd/maps/pci.c                                                         |    2 
 drivers/mtd/mtdcore.c                                                          |    2 
 drivers/mtd/mtdsuper.c                                                         |    4 
 drivers/mtd/nand/raw/atmel/nand-controller.c                                   |    6 
 drivers/mtd/nand/raw/sunxi_nand.c                                              |    3 
 drivers/mtd/parsers/qcomsmempart.c                                             |    4 
 drivers/mtd/spi-nor/core.c                                                     |    9 
 drivers/mtd/spi-nor/sfdp.c                                                     |    8 
 drivers/net/bonding/bond_main.c                                                |    2 
 drivers/net/dsa/mt7530.c                                                       |   44 
 drivers/net/ethernet/google/gve/gve_flow_rule.c                                |    1 
 drivers/net/ethernet/hisilicon/hisi_femac.c                                    |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                                  |   40 
 drivers/net/ethernet/marvell/mvneta.c                                          |   18 
 drivers/net/ethernet/marvell/mvneta_bm.c                                       |   72 
 drivers/net/ethernet/marvell/prestera/prestera_router.c                        |    6 
 drivers/net/ethernet/mediatek/mtk_wed.c                                        |    5 
 drivers/net/ethernet/mediatek/mtk_wed_regs.h                                   |    1 
 drivers/net/ethernet/sfc/efx.c                                                 |    4 
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c                               |    3 
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c                                |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                              |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c                          |    6 
 drivers/net/macvlan.c                                                          |    3 
 drivers/net/netdevsim/bpf.c                                                    |   11 
 drivers/net/pcs/pcs-mtk-lynxi.c                                                |    7 
 drivers/net/phy/sfp.c                                                          |    3 
 drivers/net/ppp/ppp_generic.c                                                  |    1 
 drivers/net/tap.c                                                              |    5 
 drivers/net/team/team_mode_broadcast.c                                         |    2 
 drivers/net/tun.c                                                              |   14 
 drivers/net/usb/cdc_ether.c                                                    |   16 
 drivers/net/usb/pegasus.c                                                      |   16 
 drivers/net/usb/qmi_wwan.c                                                     |    1 
 drivers/net/usb/rtl8150.c                                                      |    4 
 drivers/net/veth.c                                                             |    5 
 drivers/net/virtio_net.c                                                       |   25 
 drivers/net/wireless/ath/ath10k/htt_rx.c                                       |    6 
 drivers/net/wireless/ath/ath11k/ahb.c                                          |   79 
 drivers/net/wireless/ath/ath11k/dp.c                                           |    2 
 drivers/net/wireless/ath/ath11k/wmi.c                                          |    6 
 drivers/net/wireless/ath/ath12k/wmi.c                                          |   37 
 drivers/net/wireless/ath/ath12k/wmi.h                                          |   10 
 drivers/net/wireless/ath/ath9k/channel.c                                       |    2 
 drivers/net/wireless/broadcom/b43/main.c                                       |    5 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c                      |   49 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c                   |    2 
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c                                    |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                                   |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/time-sync.h                             |    4 
 drivers/net/wireless/mediatek/mt76/eeprom.c                                    |   17 
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c                             |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c                                |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c                             |    1 
 drivers/net/wireless/mediatek/mt76/mt7603/main.c                               |   74 
 drivers/net/wireless/mediatek/mt76/mt7615/init.c                               |   17 
 drivers/net/wireless/mediatek/mt76/mt7615/main.c                               |    6 
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c                           |    1 
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c                            |    5 
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c                           |    5 
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                               |   22 
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c                           |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                                |    9 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                                |    4 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                                |    4 
 drivers/net/wireless/mediatek/mt76/tx.c                                        |   18 
 drivers/net/wireless/mediatek/mt76/usb.c                                       |   31 
 drivers/net/wireless/microchip/wilc1000/mon.c                                  |   30 
 drivers/net/wireless/realtek/rtlwifi/pci.c                                     |   39 
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c                            |    6 
 drivers/net/wireless/realtek/rtw88/mac80211.c                                  |    2 
 drivers/net/wireless/realtek/rtw89/fw.c                                        |   63 
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c                              |    4 
 drivers/net/wireless/realtek/rtw89/wow.c                                       |    9 
 drivers/net/wireless/rsi/rsi_91x_coex.c                                        |    3 
 drivers/net/wireless/rsi/rsi_91x_main.c                                        |    7 
 drivers/net/wireless/rsi/rsi_91x_sdio_ops.c                                    |    3 
 drivers/net/wireless/rsi/rsi_91x_usb_ops.c                                     |    7 
 drivers/net/wireless/rsi/rsi_common.h                                          |    2 
 drivers/net/wireless/rsi/rsi_sdio.h                                            |    2 
 drivers/net/wireless/rsi/rsi_usb.h                                             |    2 
 drivers/net/wireless/virtual/mac80211_hwsim.c                                  |   10 
 drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c                                  |    5 
 drivers/net/wwan/wwan_hwsim.c                                                  |    4 
 drivers/net/xen-netback/netback.c                                              |    9 
 drivers/net/xen-netback/xenbus.c                                               |    8 
 drivers/nfc/nfcmrvl/spi.c                                                      |    4 
 drivers/nfc/nxp-nci/i2c.c                                                      |    4 
 drivers/nvme/host/auth.c                                                       |   18 
 drivers/nvme/host/core.c                                                       |    4 
 drivers/nvme/host/fc.c                                                         |    2 
 drivers/nvme/host/ioctl.c                                                      |    2 
 drivers/nvme/host/nvme.h                                                       |    6 
 drivers/nvme/host/pci.c                                                        |    6 
 drivers/nvme/host/rdma.c                                                       |    1 
 drivers/nvme/host/sysfs.c                                                      |   18 
 drivers/nvme/host/tcp.c                                                        |   16 
 drivers/nvme/host/zns.c                                                        |    8 
 drivers/nvme/target/admin-cmd.c                                                |    2 
 drivers/nvme/target/auth.c                                                     |    2 
 drivers/nvme/target/configfs.c                                                 |    2 
 drivers/nvme/target/fabrics-cmd-auth.c                                         |   45 
 drivers/nvme/target/fc.c                                                       |   18 
 drivers/nvme/target/io-cmd-bdev.c                                              |    5 
 drivers/nvme/target/io-cmd-file.c                                              |    4 
 drivers/nvme/target/nvmet.h                                                    |    2 
 drivers/nvme/target/passthru.c                                                 |    9 
 drivers/nvme/target/rdma.c                                                     |    2 
 drivers/nvme/target/zns.c                                                      |   10 
 drivers/nvmem/brcm_nvram.c                                                     |   15 
 drivers/nvmem/core.c                                                           |    4 
 drivers/opp/core.c                                                             |   52 
 drivers/parisc/eisa_enumerator.c                                               |   15 
 drivers/pci/ats.c                                                              |    7 
 drivers/pci/controller/dwc/pcie-qcom-ep.c                                      |    2 
 drivers/pci/controller/pcie-rockchip-host.c                                    |   20 
 drivers/pci/controller/pcie-xilinx-dma-pl.c                                    |   10 
 drivers/pci/controller/vmd.c                                                   |    3 
 drivers/pci/hotplug/pciehp_core.c                                              |    2 
 drivers/pci/pci-label.c                                                        |    2 
 drivers/pci/pci.c                                                              |   48 
 drivers/pci/pcie/aer.c                                                         |   35 
 drivers/pci/pcie/portdrv.c                                                     |   28 
 drivers/pci/probe.c                                                            |    5 
 drivers/pci/quirks.c                                                           |   21 
 drivers/pci/switch/switchtec.c                                                 |    1 
 drivers/pci/xen-pcifront.c                                                     |   11 
 drivers/peci/controller/peci-aspeed.c                                          |    6 
 drivers/peci/controller/peci-npcm.c                                            |    6 
 drivers/perf/marvell_cn10k_ddr_pmu.c                                           |    6 
 drivers/perf/riscv_pmu_sbi.c                                                   |   33 
 drivers/perf/xgene_pmu.c                                                       |    4 
 drivers/phy/phy-core.c                                                         |   45 
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c                                      |   96 
 drivers/pinctrl/pinctrl-sx150x.c                                               |    1 
 drivers/pinctrl/stm32/pinctrl-stm32.c                                          |    6 
 drivers/platform/cznic/turris-omnia-mcu-base.c                                 |    1 
 drivers/platform/x86/amd/pmc/mp1_stb.c                                         |   23 
 drivers/platform/x86/amd/pmc/pmc.c                                             |    5 
 drivers/platform/x86/amd/pmf/spc.c                                             |    8 
 drivers/platform/x86/amd/pmf/sps.c                                             |   10 
 drivers/platform/x86/asus-nb-wmi.c                                             |    1 
 drivers/platform/x86/asus-wmi.c                                                |   42 
 drivers/platform/x86/dell/dell-smbios-wmi.c                                    |   67 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c                                   |   82 
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c                      |   16 
 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c                         |    5 
 drivers/platform/x86/hp/hp-wmi.c                                               |    7 
 drivers/platform/x86/intel/int1092/intel_sar.c                                 |    8 
 drivers/platform/x86/intel/pmt/class.c                                         |    9 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c                 |    2 
 drivers/platform/x86/lenovo-ymc.c                                              |    8 
 drivers/platform/x86/msi-ec.c                                                  |    1 
 drivers/platform/x86/siemens/simatic-ipc.c                                     |   21 
 drivers/platform/x86/thinkpad_acpi.c                                           |    1 
 drivers/pmdomain/qcom/rpmhpd.c                                                 |   14 
 drivers/power/reset/piix4-poweroff.c                                           |    1 
 drivers/power/supply/ab8500_fg.c                                               |   67 
 drivers/power/supply/bq27xxx_battery.c                                         |    2 
 drivers/power/supply/cros_peripheral_charger.c                                 |   13 
 drivers/power/supply/generic-adc-battery.c                                     |    2 
 drivers/power/supply/qcom_pmi8998_charger.c                                    |   41 
 drivers/power/supply/sbs-battery.c                                             |   11 
 drivers/powercap/intel_rapl_common.c                                           |    4 
 drivers/pwm/pwm-tiehrpwm.c                                                     |    3 
 drivers/rapidio/devices/rio_mport_cdev.c                                       |    5 
 drivers/regulator/core.c                                                       |    4 
 drivers/regulator/fan53555.c                                                   |    6 
 drivers/regulator/of_regulator.c                                               |   26 
 drivers/regulator/rt6190-regulator.c                                           |   18 
 drivers/regulator/rt6245-regulator.c                                           |    5 
 drivers/remoteproc/remoteproc_core.c                                           |   23 
 drivers/remoteproc/remoteproc_elf_loader.c                                     |   23 
 drivers/rpmsg/rpmsg_char.c                                                     |    5 
 drivers/rtc/rtc-ab-eoz9.c                                                      |    1 
 drivers/rtc/rtc-brcmstb-waketimer.c                                            |    1 
 drivers/rtc/rtc-cmos.c                                                         |    6 
 drivers/rtc/rtc-ds1307.c                                                       |    2 
 drivers/s390/block/dasd.c                                                      |   10 
 drivers/s390/crypto/zcrypt_ccamisc.c                                           |   22 
 drivers/scsi/dc395x.c                                                          |   10 
 drivers/scsi/ibmvscsi/ibmvfc.c                                                 |   10 
 drivers/scsi/libiscsi_tcp.c                                                    |    3 
 drivers/scsi/qla2xxx/qla_os.c                                                  |   15 
 drivers/scsi/scsi_devinfo.c                                                    |    2 
 drivers/scsi/smartpqi/smartpqi_init.c                                          |   36 
 drivers/scsi/snic/snic_main.c                                                  |    1 
 drivers/sh/intc/core.c                                                         |   11 
 drivers/sh/maple/maple.c                                                       |    4 
 drivers/slimbus/messaging.c                                                    |    2 
 drivers/soc/fsl/dpio/dpio-driver.c                                             |    9 
 drivers/soc/fsl/qe/tsa.c                                                       |   16 
 drivers/soc/ixp4xx/ixp4xx-qmgr.c                                               |    1 
 drivers/soc/qcom/socinfo.c                                                     |    1 
 drivers/soundwire/dmi-quirks.c                                                 |   42 
 drivers/soundwire/intel_auxdevice.c                                            |    1 
 drivers/spi/spi-amd.c                                                          |   15 
 drivers/spi/spi-bcm-qspi.c                                                     |    9 
 drivers/spi/spi-bcm2835.c                                                      |    4 
 drivers/spi/spi-bcm63xx-hsspi.c                                                |    6 
 drivers/spi/spi-bcm63xx.c                                                      |    5 
 drivers/spi/spi-bcmbca-hsspi.c                                                 |    6 
 drivers/spi/spi-cadence-quadspi.c                                              |    3 
 drivers/spi/spi-cadence-xspi.c                                                 |   16 
 drivers/spi/spi-ch341.c                                                        |    6 
 drivers/spi/spi-jcore.c                                                        |    2 
 drivers/spi/spi-ljca.c                                                         |    8 
 drivers/spi/spi-npcm-fiu.c                                                     |    8 
 drivers/spi/spi-nxp-fspi.c                                                     |   31 
 drivers/spi/spi-zynq-qspi.c                                                    |   13 
 drivers/staging/greybus/uart.c                                                 |   30 
 drivers/staging/media/av7110/sp8870.c                                          |    5 
 drivers/staging/media/imx/imx-media-csc-scaler.c                               |    1 
 drivers/staging/media/meson/vdec/vdec.c                                        |    2 
 drivers/staging/rtl8723bs/core/rtw_recv.c                                      |  101 
 drivers/staging/rtl8723bs/hal/sdio_ops.c                                       |    7 
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c                                   |    5 
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.c               |   10 
 drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c                 |   11 
 drivers/thermal/intel/intel_powerclamp.c                                       |    3 
 drivers/thunderbolt/icm.c                                                      |    6 
 drivers/tty/serial/8250/8250_exar.c                                            |   36 
 drivers/tty/serial/8250/8250_lpss.c                                            |    7 
 drivers/tty/serial/8250/8250_omap.c                                            |   15 
 drivers/tty/serial/8250/8250_platform.c                                        |    1 
 drivers/tty/serial/8250/8250_pnp.c                                             |    1 
 drivers/tty/serial/pch_uart.c                                                  |    5 
 drivers/tty/serial/pmac_zilog.c                                                |    4 
 drivers/tty/serial/qcom_geni_serial.c                                          |    8 
 drivers/tty/serial/serial_core.c                                               |    7 
 drivers/ufs/core/ufs_bsg.c                                                     |   10 
 drivers/ufs/core/ufshcd.c                                                      |   21 
 drivers/uio/uio_sercos3.c                                                      |    1 
 drivers/usb/class/cdc-acm.c                                                    |    6 
 drivers/usb/core/driver.c                                                      |    1 
 drivers/usb/core/message.c                                                     |    1 
 drivers/usb/fotg210/fotg210-udc.c                                              |   17 
 drivers/usb/gadget/configfs.c                                                  |    4 
 drivers/usb/gadget/function/u_audio.c                                          |   12 
 drivers/usb/gadget/legacy/inode.c                                              |   24 
 drivers/usb/gadget/udc/fsl_qe_udc.c                                            |    8 
 drivers/usb/misc/cypress_cy7c63.c                                              |    8 
 drivers/usb/misc/uss720.c                                                      |    1 
 drivers/usb/mtu3/mtu3_trace.h                                                  |    4 
 drivers/usb/musb/musb_host.c                                                   |   14 
 drivers/usb/serial/option.c                                                    |    5 
 drivers/usb/serial/sierra.c                                                    |    3 
 drivers/usb/serial/usb_wwan.c                                                  |    3 
 drivers/usb/typec/ucsi/ucsi_ccg.c                                              |   15 
 drivers/vdpa/mlx5/net/mlx5_vnet.c                                              |   23 
 drivers/vdpa/vdpa_sim/vdpa_sim.c                                               |    3 
 drivers/vfio/pci/mlx5/cmd.c                                                    |    2 
 drivers/video/backlight/lm3630a_bl.c                                           |    1 
 drivers/video/backlight/qcom-wled.c                                            |   35 
 drivers/video/fbdev/atmel_lcdfb.c                                              |   24 
 drivers/video/fbdev/core/bitblit.c                                             |    7 
 drivers/video/fbdev/core/fbcon.c                                               |    7 
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c                                     |    9 
 drivers/video/fbdev/platinumfb.c                                               |   35 
 drivers/video/fbdev/sh_mobile_lcdcfb.c                                         |    6 
 drivers/video/fbdev/smscufx.c                                                  |    9 
 drivers/video/fbdev/ssd1307fb.c                                                |    6 
 drivers/video/fbdev/udlfb.c                                                    |   36 
 drivers/video/fbdev/xen-fbfront.c                                              |    7 
 drivers/virtio/virtio_balloon.c                                                |    6 
 drivers/virtio/virtio_ring.c                                                   |    8 
 drivers/w1/masters/ds2482.c                                                    |    8 
 drivers/watchdog/rzv2h_wdt.c                                                   |   59 
 drivers/xen/gntdev.c                                                           |    7 
 drivers/xen/privcmd.c                                                          |   47 
 drivers/xen/xen-pciback/pci_stub.c                                             |    7 
 fs/affs/bitmap.c                                                               |    2 
 fs/afs/rxrpc.c                                                                 |    4 
 fs/aio.c                                                                       |   18 
 fs/btrfs/inode.c                                                               |    3 
 fs/btrfs/relocation.c                                                          |   11 
 fs/btrfs/super.c                                                               |    3 
 fs/btrfs/volumes.c                                                             |    6 
 fs/ceph/addr.c                                                                 |   15 
 fs/ceph/caps.c                                                                 |   23 
 fs/ceph/crypto.c                                                               |    3 
 fs/ceph/dir.c                                                                  |   14 
 fs/ceph/inode.c                                                                |    3 
 fs/ceph/mds_client.c                                                           |   28 
 fs/ceph/mdsmap.c                                                               |   12 
 fs/ceph/snap.c                                                                 |    7 
 fs/ceph/xattr.c                                                                |   10 
 fs/crypto/keysetup.c                                                           |    8 
 fs/dax.c                                                                       |   12 
 fs/dcache.c                                                                    |   16 
 fs/dlm/lowcomms.c                                                              |    6 
 fs/erofs/decompressor.c                                                        |    2 
 fs/exec.c                                                                      |   11 
 fs/exfat/balloc.c                                                              |   31 
 fs/exfat/dir.c                                                                 |    8 
 fs/exfat/namei.c                                                               |   27 
 fs/exportfs/expfs.c                                                            |    6 
 fs/ext4/balloc.c                                                               |    6 
 fs/ext4/dir.c                                                                  |   20 
 fs/ext4/ext4.h                                                                 |    5 
 fs/ext4/extents.c                                                              |   26 
 fs/ext4/indirect.c                                                             |   17 
 fs/ext4/inode.c                                                                |   20 
 fs/ext4/namei.c                                                                |   11 
 fs/ext4/super.c                                                                |   24 
 fs/f2fs/compress.c                                                             |   10 
 fs/f2fs/data.c                                                                 |   11 
 fs/f2fs/file.c                                                                 |   49 
 fs/f2fs/gc.c                                                                   |    9 
 fs/f2fs/segment.c                                                              |    3 
 fs/f2fs/super.c                                                                |   42 
 fs/fat/fat.h                                                                   |    2 
 fs/fat/fatent.c                                                                |   21 
 fs/fat/file.c                                                                  |    3 
 fs/fat/misc.c                                                                  |    6 
 fs/fat/namei_msdos.c                                                           |    3 
 fs/fs-writeback.c                                                              |    7 
 fs/fs_pin.c                                                                    |    9 
 fs/fuse/dir.c                                                                  |    3 
 fs/fuse/file.c                                                                 |    9 
 fs/fuse/virtio_fs.c                                                            |   21 
 fs/gfs2/lops.c                                                                 |    4 
 fs/hfsplus/extents.c                                                           |    2 
 fs/hugetlbfs/inode.c                                                           |    2 
 fs/iomap/fiemap.c                                                              |    8 
 fs/isofs/inode.c                                                               |    2 
 fs/isofs/isofs.h                                                               |    2 
 fs/isofs/rock.c                                                                |   11 
 fs/jbd2/journal.c                                                              |    2 
 fs/lockd/svclock.c                                                             |    2 
 fs/namei.c                                                                     |   29 
 fs/namespace.c                                                                 |   20 
 fs/netfs/objects.c                                                             |    4 
 fs/netfs/rolling_buffer.c                                                      |    2 
 fs/nfs/blocklayout/blocklayout.h                                               |    5 
 fs/nfs/blocklayout/rpc_pipefs.c                                                |   79 
 fs/nfs/callback_proc.c                                                         |    3 
 fs/nfs/callback_xdr.c                                                          |    2 
 fs/nfs/dir.c                                                                   |    6 
 fs/nfs/filelayout/filelayout.c                                                 |    8 
 fs/nfs/flexfilelayout/flexfilelayout.c                                         |   25 
 fs/nfs/netns.h                                                                 |    5 
 fs/nfs/nfs4_fs.h                                                               |    2 
 fs/nfs/nfs4proc.c                                                              |    8 
 fs/nfs/nfs4state.c                                                             |   78 
 fs/nfs/pnfs.c                                                                  |   24 
 fs/nfs/pnfs.h                                                                  |    2 
 fs/nfsd/nfs3acl.c                                                              |   15 
 fs/nfsd/nfs4idmap.c                                                            |    4 
 fs/nfsd/nfs4proc.c                                                             |    4 
 fs/nfsd/nfs4recover.c                                                          |   42 
 fs/nfsd/nfs4state.c                                                            |   43 
 fs/nfsd/nfs4xdr.c                                                              |   26 
 fs/nfsd/nfsctl.c                                                               |   73 
 fs/nfsd/nfsproc.c                                                              |   19 
 fs/nfsd/xdr4.h                                                                 |    1 
 fs/nilfs2/dir.c                                                                |   34 
 fs/nilfs2/inode.c                                                              |    6 
 fs/nilfs2/segment.c                                                            |    2 
 fs/nilfs2/sysfs.c                                                              |    5 
 fs/nilfs2/the_nilfs.c                                                          |   34 
 fs/notify/fanotify/fanotify.c                                                  |    7 
 fs/notify/fanotify/fanotify.h                                                  |   21 
 fs/ntfs3/attrib.c                                                              |    2 
 fs/ntfs3/dir.c                                                                 |   14 
 fs/ntfs3/fslog.c                                                               |   29 
 fs/ntfs3/index.c                                                               |   14 
 fs/ntfs3/inode.c                                                               |   10 
 fs/ntfs3/namei.c                                                               |    9 
 fs/ntfs3/ntfs_fs.h                                                             |    2 
 fs/ntfs3/super.c                                                               |   18 
 fs/ocfs2/cluster/heartbeat.c                                                   |   39 
 fs/ocfs2/cluster/netdebug.c                                                    |    4 
 fs/ocfs2/cluster/nodemanager.c                                                 |   10 
 fs/ocfs2/cluster/quorum.c                                                      |    7 
 fs/ocfs2/cluster/quorum.h                                                      |    1 
 fs/ocfs2/dir.c                                                                 |   76 
 fs/ocfs2/dlm/dlmconvert.c                                                      |   10 
 fs/ocfs2/dlm/dlmdebug.c                                                        |    5 
 fs/ocfs2/dlm/dlmdomain.c                                                       |    3 
 fs/ocfs2/dlm/dlmlock.c                                                         |    8 
 fs/ocfs2/dlmglue.c                                                             |    6 
 fs/ocfs2/file.c                                                                |  118 
 fs/ocfs2/filecheck.c                                                           |    5 
 fs/ocfs2/journal.c                                                             |    3 
 fs/ocfs2/journal.h                                                             |    1 
 fs/ocfs2/quota_local.c                                                         |   12 
 fs/ocfs2/refcounttree.c                                                        |   15 
 fs/ocfs2/super.c                                                               |   17 
 fs/ocfs2/xattr.c                                                               |  142 
 fs/overlayfs/copy_up.c                                                         |  112 
 fs/overlayfs/dir.c                                                             |   22 
 fs/overlayfs/inode.c                                                           |   14 
 fs/overlayfs/namei.c                                                           |    8 
 fs/overlayfs/overlayfs.h                                                       |    8 
 fs/overlayfs/readdir.c                                                         |   29 
 fs/overlayfs/super.c                                                           |   17 
 fs/pnode.c                                                                     |  125 
 fs/proc/task_mmu.c                                                             |    9 
 fs/read_write.c                                                                |    8 
 fs/romfs/super.c                                                               |    8 
 fs/signalfd.c                                                                  |   28 
 fs/smb/client/cached_dir.c                                                     |   30 
 fs/smb/client/cifsacl.c                                                        |    9 
 fs/smb/client/cifsfs.c                                                         |   61 
 fs/smb/client/cifsfs.h                                                         |    4 
 fs/smb/client/cifsglob.h                                                       |    5 
 fs/smb/client/cifspdu.h                                                        |   30 
 fs/smb/client/cifssmb.c                                                        |   37 
 fs/smb/client/connect.c                                                        |    4 
 fs/smb/client/inode.c                                                          |   46 
 fs/smb/client/readdir.c                                                        |    3 
 fs/smb/client/reparse.c                                                        |   67 
 fs/smb/client/sess.c                                                           |    6 
 fs/smb/client/smb2ops.c                                                        |  122 
 fs/smb/client/smb2pdu.c                                                        |   12 
 fs/smb/client/transport.c                                                      |    6 
 fs/smb/common/smb2pdu.h                                                        |   14 
 fs/smb/server/auth.c                                                           |    3 
 fs/smb/server/connection.c                                                     |   22 
 fs/smb/server/mgmt/user_config.c                                               |    6 
 fs/smb/server/mgmt/user_session.c                                              |    4 
 fs/smb/server/misc.c                                                           |    8 
 fs/smb/server/oplock.c                                                         |   16 
 fs/smb/server/server.c                                                         |   21 
 fs/smb/server/smb2pdu.c                                                        |  426 
 fs/smb/server/smb2pdu.h                                                        |    1 
 fs/smb/server/smb_common.c                                                     |    6 
 fs/smb/server/smbacl.c                                                         |   51 
 fs/smb/server/transport_ipc.c                                                  |   16 
 fs/smb/server/transport_rdma.c                                                 |    1 
 fs/smb/server/transport_tcp.c                                                  |   15 
 fs/smb/server/vfs.c                                                            |  133 
 fs/smb/server/vfs.h                                                            |    3 
 fs/smb/server/vfs_cache.c                                                      |   46 
 fs/smb/server/vfs_cache.h                                                      |    2 
 fs/splice.c                                                                    |   12 
 fs/stat.c                                                                      |    6 
 fs/udf/balloc.c                                                                |   12 
 fs/udf/inode.c                                                                 |   33 
 fs/udf/super.c                                                                 |    5 
 fs/udf/truncate.c                                                              |    2 
 fs/udf/udfdecl.h                                                               |    3 
 fs/ufs/cylinder.c                                                              |   31 
 fs/ufs/dir.c                                                                   |    2 
 fs/verity/open.c                                                               |   38 
 fs/xfs/libxfs/xfs_attr_leaf.c                                                  |   13 
 fs/xfs/libxfs/xfs_da_btree.c                                                   |   14 
 fs/xfs/libxfs/xfs_inode_fork.c                                                 |    4 
 fs/xfs/libxfs/xfs_symlink_remote.c                                             |    8 
 fs/xfs/libxfs/xfs_symlink_remote.h                                             |    2 
 fs/xfs/libxfs/xfs_trans_space.c                                                |    6 
 fs/xfs/scrub/agheader_repair.c                                                 |    6 
 fs/xfs/scrub/alloc_repair.c                                                    |   11 
 fs/xfs/scrub/attr.c                                                            |   17 
 fs/xfs/scrub/attr_repair.c                                                     |   18 
 fs/xfs/scrub/bitmap.c                                                          |   20 
 fs/xfs/scrub/bmap.c                                                            |    7 
 fs/xfs/scrub/btree.c                                                           |   16 
 fs/xfs/scrub/common.c                                                          |    7 
 fs/xfs/scrub/dabtree.c                                                         |   27 
 fs/xfs/scrub/dir.c                                                             |    2 
 fs/xfs/scrub/dirtree_repair.c                                                  |   76 
 fs/xfs/scrub/dqiterate.c                                                       |    1 
 fs/xfs/scrub/fscounters.c                                                      |   14 
 fs/xfs/scrub/ialloc_repair.c                                                   |    8 
 fs/xfs/scrub/inode.c                                                           |    2 
 fs/xfs/scrub/inode_repair.c                                                    |   39 
 fs/xfs/scrub/iscan.c                                                           |    2 
 fs/xfs/scrub/newbt.c                                                           |   13 
 fs/xfs/scrub/newbt.h                                                           |    1 
 fs/xfs/scrub/parent_repair.c                                                   |    4 
 fs/xfs/scrub/quota.c                                                           |    8 
 fs/xfs/scrub/quota_repair.c                                                    |   39 
 fs/xfs/scrub/quotacheck_repair.c                                               |   54 
 fs/xfs/scrub/readdir.c                                                         |    2 
 fs/xfs/scrub/reap.c                                                            |    2 
 fs/xfs/scrub/refcount.c                                                        |   17 
 fs/xfs/scrub/repair.h                                                          |    2 
 fs/xfs/scrub/rmap.c                                                            |   20 
 fs/xfs/scrub/stats.c                                                           |    5 
 fs/xfs/scrub/symlink.c                                                         |   17 
 fs/xfs/scrub/trace.c                                                           |   13 
 fs/xfs/scrub/trace.h                                                           |   10 
 fs/xfs/scrub/xfarray.c                                                         |    4 
 fs/xfs/xfs_dquot.c                                                             |   20 
 fs/xfs/xfs_dquot.h                                                             |    2 
 fs/xfs/xfs_handle.c                                                            |    2 
 fs/xfs/xfs_inode_item_recover.c                                                |   20 
 fs/xfs/xfs_qm.c                                                                |    6 
 fs/xfs/xfs_trans_dquot.c                                                       |    6 
 include/asm-generic/bitops/le.h                                                |   18 
 include/dt-bindings/arm/qcom,ids.h                                             |    1 
 include/linux/device.h                                                         |    5 
 include/linux/device/bus.h                                                     |    3 
 include/linux/fault-inject.h                                                   |   10 
 include/linux/fs.h                                                             |    4 
 include/linux/hid.h                                                            |    1 
 include/linux/hiddev.h                                                         |    2 
 include/linux/hugetlb.h                                                        |    4 
 include/linux/interrupt.h                                                      |    2 
 include/linux/libata.h                                                         |    1 
 include/linux/mempool.h                                                        |    7 
 include/linux/pci.h                                                            |    2 
 include/linux/remoteproc.h                                                     |    2 
 include/linux/rtc.h                                                            |    2 
 include/math-emu/op-common.h                                                   |   23 
 include/math-emu/soft-fp.h                                                     |    8 
 include/media/v4l2-ctrls.h                                                     |    6 
 include/net/addrconf.h                                                         |    3 
 include/net/gso.h                                                              |    8 
 include/net/mptcp.h                                                            |    9 
 include/net/netfilter/nf_conntrack_expect.h                                    |    3 
 include/trace/events/huge_memory.h                                             |   12 
 include/trace/misc/nfs.h                                                       |   10 
 include/uapi/linux/pci_regs.h                                                  |    6 
 include/video/maxinefb.h                                                       |    4 
 init/main.c                                                                    |    6 
 init/version.c                                                                 |    3 
 io_uring/io-wq.c                                                               |   14 
 io_uring/io_uring.c                                                            |    3 
 io_uring/kbuf.c                                                                |    4 
 io_uring/net.c                                                                 |   12 
 io_uring/rsrc.c                                                                |    4 
 io_uring/sqpoll.c                                                              |   28 
 io_uring/sqpoll.h                                                              |    3 
 io_uring/tctx.c                                                                |    6 
 io_uring/timeout.c                                                             |    3 
 io_uring/waitid.c                                                              |    5 
 ipc/mqueue.c                                                                   |    7 
 ipc/msgutil.c                                                                  |    3 
 ipc/namespace.c                                                                |    9 
 ipc/shm.c                                                                      |   23 
 kernel/bpf/queue_stack_maps.c                                                  |    3 
 kernel/cgroup/cgroup.c                                                         |    2 
 kernel/cpu_pm.c                                                                |    9 
 kernel/debug/gdbstub.c                                                         |   55 
 kernel/fork.c                                                                  |    4 
 kernel/futex/core.c                                                            |    8 
 kernel/futex/pi.c                                                              |  100 
 kernel/irq/internals.h                                                         |    2 
 kernel/irq/irqdomain.c                                                         |    4 
 kernel/irq/manage.c                                                            |   31 
 kernel/kcov.c                                                                  |    8 
 kernel/kcsan/core.c                                                            |    7 
 kernel/module/kallsyms.c                                                       |   31 
 kernel/module/main.c                                                           |  478 
 kernel/reboot.c                                                                |    9 
 kernel/resource.c                                                              |   11 
 kernel/sched/cpufreq_schedutil.c                                               |   14 
 kernel/sched/ext.c                                                             |    2 
 kernel/sched/fair.c                                                            |    7 
 kernel/seccomp.c                                                               |    7 
 kernel/sys.c                                                                   |    3 
 kernel/time/itimer.c                                                           |    2 
 kernel/time/namespace.c                                                        |    2 
 kernel/time/posix-cpu-timers.c                                                 |    4 
 kernel/time/timekeeping.c                                                      |    3 
 kernel/trace/ring_buffer.c                                                     |    2 
 kernel/trace/trace_events_hist.c                                               |  105 
 kernel/ucount.c                                                                |   21 
 lib/842/842_decompress.c                                                       |    7 
 lib/buildid.c                                                                  |    4 
 lib/decompress_bunzip2.c                                                       |    6 
 lib/fault-inject.c                                                             |    7 
 lib/klist.c                                                                    |   16 
 lib/kobject_uevent.c                                                           |    8 
 mm/damon/core.c                                                                |   19 
 mm/damon/sysfs-schemes.c                                                       |    6 
 mm/damon/sysfs.c                                                               |   21 
 mm/hugetlb.c                                                                   |  153 
 mm/hugetlb_cgroup.c                                                            |   33 
 mm/khugepaged.c                                                                |   11 
 mm/kmemleak.c                                                                  |   32 
 mm/madvise.c                                                                   |   12 
 mm/memcontrol-v1.c                                                             |   12 
 mm/memcontrol.c                                                                |   13 
 mm/mempolicy.c                                                                 |   14 
 mm/migrate.c                                                                   |    6 
 mm/mlock.c                                                                     |    2 
 mm/nommu.c                                                                     |    6 
 mm/page_alloc.c                                                                |   18 
 mm/percpu.c                                                                    |    5 
 mm/rmap.c                                                                      |   11 
 mm/shmem.c                                                                     |    4 
 mm/slab_common.c                                                               |   17 
 mm/vmscan.c                                                                    |   19 
 mm/zswap.c                                                                     |    3 
 net/8021q/vlan_dev.c                                                           |   33 
 net/bluetooth/6lowpan.c                                                        |    1 
 net/bluetooth/hci_debugfs.c                                                    |    9 
 net/bluetooth/hci_event.c                                                      |    7 
 net/bluetooth/hci_sync.c                                                       |   30 
 net/bluetooth/l2cap_core.c                                                     |   41 
 net/bluetooth/l2cap_sock.c                                                     |    4 
 net/bridge/netfilter/ebtables.c                                                |   12 
 net/ceph/mon_client.c                                                          |    5 
 net/ceph/osd_client.c                                                          |   13 
 net/ceph/osdmap.c                                                              |   16 
 net/core/gro.c                                                                 |    4 
 net/core/gso.c                                                                 |    1 
 net/core/skbuff.c                                                              |   15 
 net/ipv4/af_inet.c                                                             |    3 
 net/ipv4/inet_connection_sock.c                                                |   16 
 net/ipv4/inet_hashtables.c                                                     |    5 
 net/ipv4/ip_gre.c                                                              |   42 
 net/ipv4/ipmr.c                                                                |    1 
 net/ipv4/metrics.c                                                             |    5 
 net/ipv4/netfilter/nf_nat_h323.c                                               |   22 
 net/ipv4/netfilter/nf_reject_ipv4.c                                            |   11 
 net/ipv4/netfilter/nf_tproxy_ipv4.c                                            |    2 
 net/ipv4/syncookies.c                                                          |    2 
 net/ipv4/sysctl_net_ipv4.c                                                     |    2 
 net/ipv4/tcp_cong.c                                                            |    4 
 net/ipv4/tcp_input.c                                                           |    4 
 net/ipv4/tcp_output.c                                                          |    2 
 net/ipv6/addrconf.c                                                            |   46 
 net/ipv6/inet6_hashtables.c                                                    |    4 
 net/ipv6/ip6_gre.c                                                             |    5 
 net/ipv6/ip6_offload.c                                                         |    4 
 net/ipv6/netfilter/nf_reject_ipv6.c                                            |   13 
 net/ipv6/netfilter/nf_tproxy_ipv6.c                                            |    2 
 net/ipv6/reassembly.c                                                          |    1 
 net/ipv6/route.c                                                               |    2 
 net/ipv6/udp.c                                                                 |   13 
 net/mac80211/ibss.c                                                            |    4 
 net/mptcp/protocol.c                                                           |    9 
 net/mptcp/subflow.c                                                            |   35 
 net/netfilter/nf_conntrack_expect.c                                            |   35 
 net/netfilter/nf_conntrack_netlink.c                                           |    8 
 net/netfilter/nf_conntrack_proto_tcp.c                                         |    6 
 net/netfilter/nf_nat_sip.c                                                     |   20 
 net/netfilter/nft_meta.c                                                       |    6 
 net/netfilter/nft_rt.c                                                         |    6 
 net/netfilter/nft_xfrm.c                                                       |    9 
 net/packet/af_packet.c                                                         |   12 
 net/rds/ib_cm.c                                                                |    6 
 net/rds/ib_rdma.c                                                              |    4 
 net/rds/ib_recv.c                                                              |   13 
 net/rds/message.c                                                              |   26 
 net/rds/rdma.c                                                                 |   63 
 net/rds/rds.h                                                                  |   15 
 net/rds/send.c                                                                 |   18 
 net/rxrpc/recvmsg.c                                                            |   22 
 net/rxrpc/rxperf.c                                                             |   16 
 net/sched/act_ct.c                                                             |    5 
 net/sched/act_ife.c                                                            |    4 
 net/sched/cls_bpf.c                                                            |   28 
 net/sched/cls_flower.c                                                         |   50 
 net/sched/sch_generic.c                                                        |   10 
 net/sched/sch_teql.c                                                           |   60 
 net/sctp/associola.c                                                           |    4 
 net/sctp/endpointola.c                                                         |    4 
 net/sctp/socket.c                                                              |   26 
 net/smc/smc_tx.c                                                               |    7 
 net/sunrpc/auth_gss/svcauth_gss.c                                              |   29 
 net/sunrpc/svc.c                                                               |    9 
 net/sunrpc/svc_xprt.c                                                          |   24 
 net/sunrpc/svcauth_unix.c                                                      |    7 
 net/sunrpc/svcsock.c                                                           |   86 
 net/sunrpc/xprtrdma/rpc_rdma.c                                                 |   27 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                                       |    3 
 net/sunrpc/xprtrdma/verbs.c                                                    |    9 
 net/tipc/group.c                                                               |   19 
 net/tipc/socket.c                                                              |   12 
 net/unix/sysctl_net_unix.c                                                     |    4 
 net/vmw_vsock/vmci_transport.c                                                 |   34 
 net/wireless/nl80211.c                                                         |    4 
 net/xdp/xsk_buff_pool.c                                                        |    2 
 net/xdp/xsk_queue.c                                                            |   12 
 rust/bindings/lib.rs                                                           |    1 
 rust/uapi/lib.rs                                                               |    1 
 scripts/kconfig/conf.c                                                         |   17 
 scripts/link-vmlinux.sh                                                        |   20 
 security/apparmor/include/label.h                                              |    6 
 security/apparmor/include/policy_ns.h                                          |   16 
 security/apparmor/label.c                                                      |    1 
 security/apparmor/mount.c                                                      |    4 
 security/apparmor/policy.c                                                     |   16 
 security/apparmor/policy_ns.c                                                  |    2 
 security/landlock/fs.c                                                         |   10 
 sound/core/compress_offload.c                                                  |   28 
 sound/core/control.c                                                           |    2 
 sound/core/init.c                                                              |   12 
 sound/core/seq/oss/seq_oss_device.h                                            |    1 
 sound/core/seq/oss/seq_oss_event.c                                             |    3 
 sound/core/seq/oss/seq_oss_init.c                                              |    2 
 sound/core/ump_convert.c                                                       |    2 
 sound/drivers/aloop.c                                                          |   11 
 sound/drivers/pcmtest.c                                                        |   42 
 sound/mips/sgio2audio.c                                                        |   13 
 sound/oss/dmasound/dmasound_q40.c                                              |   65 
 sound/pci/cs46xx/dsp_spos.c                                                    |    2 
 sound/pci/hda/hda_codec.c                                                      |   12 
 sound/pci/hda/hda_intel.c                                                      |    9 
 sound/pci/hda/hda_sysfs.c                                                      |    4 
 sound/pci/hda/patch_conexant.c                                                 |   17 
 sound/pci/hda/patch_realtek.c                                                  |   98 
 sound/pci/hda/patch_via.c                                                      |    1 
 sound/soc/amd/acp-config.c                                                     |   14 
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c                                  |    8 
 sound/soc/amd/ps/pci-ps.c                                                      |    2 
 sound/soc/amd/yc/acp6x-mach.c                                                  |   21 
 sound/soc/codecs/arizona-jack.c                                                |    1 
 sound/soc/codecs/hdac_hda.c                                                    |   16 
 sound/soc/codecs/hdac_hdmi.c                                                   |   10 
 sound/soc/codecs/lpass-wsa-macro.c                                             |   42 
 sound/soc/codecs/max98396.c                                                    |   24 
 sound/soc/codecs/max98926.c                                                    |    2 
 sound/soc/codecs/pcm6240.c                                                     |    2 
 sound/soc/codecs/rt5682s.c                                                     |    4 
 sound/soc/codecs/rt712-sdca-dmic.c                                             |    4 
 sound/soc/codecs/rt712-sdca.c                                                  |    1 
 sound/soc/codecs/rt712-sdca.h                                                  |    1 
 sound/soc/codecs/sma1303.c                                                     |    2 
 sound/soc/codecs/tlv320aic26.c                                                 |    6 
 sound/soc/codecs/tlv320aic32x4-clk.c                                           |    8 
 sound/soc/codecs/wcd9335.c                                                     |   25 
 sound/soc/codecs/wm8994.c                                                      |    3 
 sound/soc/codecs/wsa884x.c                                                     |   11 
 sound/soc/intel/atom/sst/sst_acpi.c                                            |   14 
 sound/soc/intel/boards/bytcr_rt5651.c                                          |   17 
 sound/soc/qcom/qdsp6/q6afe.c                                                   |   10 
 sound/soc/qcom/qdsp6/q6apm.c                                                   |    1 
 sound/soc/sdw_utils/soc_sdw_rt711.c                                            |    1 
 sound/soc/sof/intel/mtl.c                                                      |   23 
 sound/soc/ti/davinci-mcasp.c                                                   |    1 
 sound/synth/emux/emux.c                                                        |   10 
 sound/synth/emux/soundfont.c                                                   |    9 
 sound/usb/line6/pcm.c                                                          |    8 
 sound/usb/mixer_maps.c                                                         |   27 
 sound/usb/pcm.c                                                                |    3 
 sound/usb/quirks-table.h                                                       |   22 
 sound/usb/quirks.c                                                             |    2 
 sound/usb/usx2y/usbusx2yaudio.c                                                |    1 
 tools/lib/api/fd/array.c                                                       |    5 
 tools/lib/bpf/libbpf.c                                                         |   10 
 tools/lib/bpf/ringbuf.c                                                        |    2 
 tools/lib/thermal/include/thermal.h                                            |    4 
 tools/objtool/check.c                                                          |    1 
 tools/perf/arch/loongarch/util/header.c                                        |    2 
 tools/sched_ext/scx_flatcg.bpf.c                                               |    3 
 tools/testing/selftests/core/unshare_test.c                                    |   19 
 tools/testing/selftests/ftrace/ftracetest                                      |    3 
 tools/testing/selftests/net/fin_ack_lat.c                                      |    2 
 tools/testing/selftests/net/reuseport_bpf_numa.c                               |   24 
 tools/testing/selftests/seccomp/seccomp_bpf.c                                  |  179 
 virt/kvm/guest_memfd.c                                                         |    8 
 virt/kvm/kvm_main.c                                                            |   31 
 1297 files changed, 89171 insertions(+), 5553 deletions(-)

Aamir Ahmed (4):
      ksmbd: deny access for an empty DACL instead of granting the request
      clk: mvebu: ap-cpu-clk: Assign .num before accessing .hws
      lib: decompress_bunzip2: fix integer overflow in run-length decoding
      gve: fix out-of-bounds read in gve_get_flow_rule_entry()

Aaron Ma (1):
      HID: quirks: Add ALWAYS_POLL quirk for Beitong BTP-KP20D dongle

Abdifatah Suruur (3):
      ksmbd: reserve space for the UTF-16 terminator in stream info
      smb: client: fix fiemap wild read on empty truncated response
      xen/gntdev: prevent private mappings from becoming writable

Abdun Nihaal (2):
      platform/x86: int1092: Fix info leak in parse_package()
      wifi: ath11k: Fix possible memory leak in ath11k_dp_srng_setup()

Abhijeeth Babu (1):
      i2c: acpi: Force ELAN1300 touchpads to 100 kHz

Adarsh Das (1):
      smb: client: delete compound mids on send failure before unlock

Aditya Sherawat (1):
      drm/msm/adreno: Add support for A704 GPU

Adrian Ambrozewicz (1):
      gpiolib: don't report -ENOMEM for a requested line without a label

Adrian Hunter (1):
      i3c: master: Fix potential UAF in i3c_device_uevent()

Ahmed Naseef (1):
      wifi: mt76: mt7603: add 0x7592 EEPROM chip ID

Ahsan Atta (2):
      crypto: qat - initialise state_lock on every path in adf_devmgr_add_dev()
      crypto: qat - fix use of destroyed vf2pf_lock on VF restart

Al Viro (1):
      ufs: fix ufs_read_cylinder() failure handling

Alan Stern (1):
      HID: core: Fix out-of-bounds left shift by 32 in s32ton()

Aldo Ariel Panzardo (10):
      xfs: reject out-of-range attribute value lengths in xfs_attr_copy_value
      xfs: reject remote xattr entries with an out-of-range value length
      xfs: bound da-node entry count against the correct geometry
      xfs: bound inode fork length against the fork size during log recovery
      nfsd: clear XDR padding in GETXATTR replies
      NFSD: copy SETXATTR data from all XDR buffer segments
      nfsd: propagate SETXATTR value decode errors
      nfsd: zero NFSv4 COMPOUND tag padding
      nilfs2: fix checkpoint root lifetime on sysfs errors
      crypto: nx - validate 'ignore' before subtracting in decompress

Aleksander Jan Bajkowski (1):
      net: sfp: add quirk for HORACO copper SFP+ module

Aleksandr Nogikh (1):
      media: usbtv: fix null-pointer dereference on disconnect

Alex Deucher (4):
      drm/amdgpu/atomfirmware: WARN() rather than BUG()
      drm/amdgpu/gfx11: WARN() rather than BUG() for invalid SDMA engine
      drm/amdgpu/pm: add workload profile pause helper
      drm/amdgpu/gmc12: properly pass flush_type to gmc_v12_0_flush_vm_hub()

Alex Elder (1):
      net: stmmac: use dma_addr_t for DMA addresses

Alex Kazinsky (1):
      ASoC: tlv320aic32x4: Prevent division by zero in divider callbacks

Alex Markuze (1):
      ceph: fix uninitialized err in ceph_netfs_issue_read()

Alexander Kochetkov (1):
      Revert "Input: matrix_keypad - force switch rows to input mode"

Alexander Sverdlin (1):
      pwm: tiehrpwm: Clear period on disable to allow reconfiguration

Alexander Wilhelm (1):
      wifi: ath12k: fix scan command endianness on big endian

Alexey Charkov (1):
      regulator: of: fill in supply names in of_regulator_bulk_get_all()

Ali Alaei (1):
      PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow Lake-HX

Allison Henderson (2):
      net/rds: don't use unpin_user_pages_dirty_lock() from atomic context
      net/rds: unpin MR pages with unpin_user_pages_dirty_lock()

Ameer Hamza (2):
      nfsd: don't modify a session slot when replaying its cached reply
      sunrpc: treat empty auth.unix.gid replies as negative entries

Amir Goldstein (4):
      ovl: fortify ovl_copy_xattr() against underlying layer modifications
      ovl: skip copy up of empty security.capability
      fs: make sure to call fsnotify_inoderemove() only once when inode is dead
      fs: don't fail __d_obtain_alias() for unlinked inodes

Amit Machhiwal (3):
      KVM: PPC: Book3S HV: Add SRCU protection for virtual-mode HPT hcalls
      KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-lock users
      KVM: PPC: Fix get_d_signext() 12-bit displacement for paired-single D-form

Anastasios Papagiannis (1):
      mm/nommu: reject wrapping ranges in access_remote_vm()

Andi Shyti (1):
      media: cx231xx: Fix cleanup path on failure

Andrea Parri (5):
      kcsan: Avoid division by zero in kcsan_prandom_u32_max()
      iomap: don't lose a fiemap iteration error when emitting the last extent
      nvmet: zns: don't leak stale memory in zone management receive
      iommufd: Reject a zero-length dirty bitmap request
      nvmet-fc: only send read data for successful commands

Andrea Pesaresi (1):
      arm64: dts: mediatek: mt7986: correct timer frequency

Andreas Haufler (1):
      tools/lib/thermal: Fix misplaced extern "C" closing brace

Andreas Kemnade (1):
      fbdev: omap2: dsi: do not copy isr table

Andreas Wendleder (1):
      wifi: b43: fix use-after-free in b43_bcma_remove()

Andrew Onyshchuk (1):
      platform/x86: thinkpad_acpi: Fix fan speed reporting on Edge E330

Andrey Albershteyn (1):
      fsverity: hoist statx reporting of fs-verity flag

André Draszik (1):
      kbuild: link-vmlinux.sh: improve detection of third pass requirement

Andy Moreton (1):
      sfc: add X4D PF support

Aniket Randive (1):
      serial: qcom_geni: Disable closing_wait for console to prevent shutdown timeout

Antonio Quartulli (1):
      net/sched: fix packet reordering on requeue

Anuj Bolewar (2):
      drm/virtio: reclaim pending vbufs before tearing down vqs
      media: hackrf: fix use-after-free in hackrf_alloc_urbs() error path

Anup Vishwakarma (1):
      mailbox: qcom-ipcc: Guard against NULL con_priv in send_data()

Arash Golgol (1):
      regulator: fan53555: Add support for FAN53555BUC23X type

Ard Biesheuvel (2):
      arm64/efi: Clear PTE_WRITE when applying EFI_MEMORY_RO
      efi/libstub: Don't replace an existing LINUX_EFI_MEMRESERVE table

Arie Miller (1):
      hwmon: (asus_rog_ryujin) Synchronize HID command and report handling

Armin Wolf (1):
      platform/x86: dell-smbios-wmi: Fix chardev resource management

Arnd Bergmann (1):
      media: v4l2-tpg: reduce stack usage for kasan builds

Arpith Alexander (1):
      spi: ljca: Don't require data in write replies

Asad Kamal (2):
      drm/amd/pm: Validate OD DPM triples before mutating tables
      drm/amdgpu: Gate debugfs MMIO access on kernel lockdown

Atish Patra (1):
      RISC-V: perf: fix resource cleanup on driver probe failure

Aurabindo Pillai (1):
      drm/amd: Add DCN6 register headers

Avi Weiss (4):
      drm/amd/display: Initialize missing TD-LUT programming inputs
      irqchip/riscv-imsic: Report successful hardware retrigger
      irqchip/irq-msi-lib: Free wired MSI descriptors
      init/bootconfig: pass init arguments in documented order

Baek Kyu, Kim (2):
      hwmon: (sht3x) Return the consumed count for heater writes
      gpiolib: Free chip resources when allocating the label fails

Balakrishnan Sambath (7):
      media: microchip-isc: take a reference on the parsed endpoints
      media: microchip-isc: fix awb_mutex and lock lifecycle
      media: microchip-isc: synchronize the IRQ before disabling clocks on stop
      media: microchip-isc: disable histogram and flush AWB work on teardown
      media: microchip-isc: do not touch WB registers when not streaming
      media: microchip-isc: fix PM runtime leak in AWB work handler
      media: microchip-isc: don't sleep in the clk .is_enabled callback

Baokun Li (4):
      ext4: reduce max cluster size to match documented 256MB limit
      ext4: reject mount if clusters/inodes per group are not 8-aligned
      blk-crypto: fix NULL deref and UAF in __blk_crypto_evict_key()
      fscrypt: Fix missing barrier in fscrypt_find_mode_key()

Baolin Liu (1):
      isofs: fix Rock Ridge CE extent validation on multisession media

Baolin Wang (1):
      mm: vmscan: fix dirty folios throttling on cgroup v1 for MGLRU

Bard Liao (1):
      soundwire: dmi-quirks: add a global ghost list

Bartu Alev (1):
      platform/x86: asus-wmi: fix TUF keyboard power state shutdown naming

Basavaraj Natikar (3):
      HID: amd_sfh: Serialize access to the shared emp2 pointer
      HID: amd_sfh: Remove unsupported motion-state field from accelerometer report
      HID: amd_sfh: Use report type from request node

Ben Dooks (2):
      dmaengine: dw-axi-dmac: fix __le32 on set of CH_CTL_H_LLI_VALID
      mmc: cqhci: fix to missed endian conversions

Benjamin Coddington (5):
      pNFS: honor clora_changed when recalling a layout
      pNFS: Fix CB_NOTIFY_DEVICEID CHANGE to consume ndc_immediate
      NFSv4.1/pnfs: suspend pNFS on NFS4ERR_TOOSMALL from LAYOUTGET
      NFSv4/filelayout: Anchor page coalescing on pattern_offset
      NFSv4/flexfiles: fail I/O to the data server once a lock is lost

Benjamin Marzinski (1):
      bitops: make the *_bit_le functions use unsigned long

Bibo Mao (4):
      LoongArch: KVM: Skip PMU checking on vCPU context switch
      LoongArch: KVM: Check kvm_request_pending() in kvm_late_check_requests()
      LoongArch: KVM: Deliver interrupt after IN_GUEST_MODE is set
      LoongArch: KVM: Set vcpu->cpu before IN_GUEST_MODE is set

Bihaan Sen (1):
      Input: xpad - add support for 8BitDo Pro 2 Wired Controller for Xbox

Binbin Deng (1):
      apparmor: fix a use-after-free in aa_lookupn_ns()

BingKun Yue (1):
      fbdev: platinumfb: add error checking for ioremap calls

Bob Song (4):
      ALSA: hda: Check snd_hda_power_pm construct error before executing verb
      ALSA: hda/realtek: add missing NULL check for codec->bus->pci
      ALSA: hda/realtek: add missing error checks for COEF index reads in alc269
      ALSA: hda/conexant: Always enable the headset-mic pin on plugin

Borislav Petkov (AMD) (1):
      x86/bugs: Mitigate TSA on AMD Zen5

Bradley Morgan (1):
      PM: CPU: Restore synchronize_rcu() to cpu_pm_unregister_notifier()

Breno Leitao (4):
      mm/kmemleak: stop the task stack scan early when interrupted
      mm/kmemleak: report RCU-tasks quiescent states during the scan
      dcache: report a Tasks-RCU quiescent state in dentry_kill()
      mm/shmem: report RCU-tasks quiescent states while undoing a range

Brian Grech (1):
      selftests/net: fin_ack_lat: fix latency threshold typo

Brian Norris (1):
      PCI/portdrv: Allow probing even without child services

Bryam Vargas (2):
      iio: accel: fxls8962af: clamp the device-reported FIFO sample count
      net/smc: queue the copied chunk when smc_tx_sendmsg() faults

Bryan O'Donoghue (1):
      phy: core: Fix race-condition between _of_phy_get() and try_module_get()

Bui Viet Dung (4):
      wwan: wwan_hwsim: Pin module for debugfs file operations
      Bluetooth: hci_vhci: Pin module for debugfs file operations
      Bluetooth: 6lowpan: Pin module for 6lowpan_control debugfs file
      Bluetooth: hci_debugfs: Pin module for debugfs file operations

Can Peng (2):
      wifi: brcmfmac: Set DMA direction for msgbuf packet IDs
      wifi: brcmfmac: validate msgbuf flowring IDs before use

Cao Guanghui (2):
      md/raid5: track disks array size to fix extra_page leak on error paths
      md/raid5: fix NULL pointer dereference in raid5_free_percpu

Carl Quist (1):
      ALSA: hda/realtek: Enable mute LED on HP Laptop 15-dy0xxx

Carlos Song (1):
      i2c: imx-lpi2c: properly unwind resources on probe failure

Cen Zhang (12):
      ocfs2/dlm: drain join handlers before releasing module text
      ocfs2: drain quorum work before removing the cluster
      ocfs2: pin owning modules for open debugfs files
      ocfs2: publish the filecheck owner before adding sysfs attributes
      ocfs2/heartbeat: unlink live slots when their node is missing
      ocfs2/dlm: hold a lock reference across grant AST enqueue
      ocfs2: cancel quota sync work before freeing quota info
      ocfs2: pin refcount trees before dropping the lookup lock
      ocfs2: snapshot dentry names in file and setattr traces
      ocfs2/cluster: initialize heartbeat regions before publishing them
      ocfs2: snapshot the dentry name while tracing file release
      ocfs2/cluster: remove zero-address nodes from IP tree on teardown

Cen Zhang (Microsoft Security FORGE Labs) (1):
      nfsd: hold cl_lock in client_has_openowners()

Cen Zhang (Microsoft) (2):
      ksmbd: fix parent dentry lifetime in directory enumeration
      posix-cpu-timers: Fix pid refcount leak in do_cpu_nanosleep() signal path

Chao Shi (1):
      nvme: ratelimit the completion-path messages driven by device data

Chao Yu (1):
      f2fs: compress: fix to handle race between truncate and writeback

Charlene Liu (1):
      drm/amd/display: fix max dispclk_khz/dppclk_khz double 1000

Charles Keepax (4):
      soundwire: dmi-quirks: Disable ghost Realtek on Asus Expertbook
      soundwire: intel_auxdevice: Add cs42l44 to wake_capable_list
      soundwire: dmi-quirks: Disable ghost Realtek on Asus Zenbook Duo
      soundwire: dmi-quirks: Disable ghost Realtek on Asus ROG Zephyrus Duo

Cheick Traore (1):
      iio: adc: stm32: fix minimum sampling time values

Chen Changcheng (3):
      media: cx88: fix memory leak in cx8802_register_driver() error path
      Bluetooth: btrsi: Move set_bt_context after successful HCI registration
      scsi: snic: Fix SCSI host leak on workqueue allocation failure

ChenXiaoSong (1):
      smb/server: cancel async requests when closing connection

Cheng Yongkang (1):
      io_uring/timeout: count cancelled timeouts in cq_timeouts

Chengfeng Ye (1):
      KVM: x86: Take SRCU in kvm_zap_gfn_range()

Chih-Kang Chang (1):
      wifi: rtw89: wow: only WiFi 6 chips initialize RF registers in WoWLAN mode

Chin-Yen Lee (1):
      wifi: rtw89: wow: add QoS control field to WoWLAN ARP response for MLO

Chris Lew (1):
      rpmsg: char: Check for ongoing chrdev destroy

Chris Mason (17):
      ovl: take a snapshot of the name for copy up
      ovl: use the pinned upper dir in ovl_fix_origin()
      ovl: always encode the origin fh when index is enabled
      ovl: do not copy up an xattr value that was never read
      ovl: fix a torn path in ovl_get_redirect()
      ovl: read the nlink xattr of every indexed non-dir
      ovl: set the revalidate flags after d_instantiate()
      sunrpc: pin gss module across auth_domain RCU free
      ovl: set OVL_WHITEOUTS before publishing the upper dir
      io_uring/rsrc: charge buffer arrays and nodes to memcg
      io_uring: charge tctx nodes and personalities
      io_uring: free XArray nodes left by a failed store
      io_uring/sqpoll: don't wait for the thread to exit
      ovl: check that the parents of volatile/dirty are dirs
      ovl: hold a reference on the parent in readdir
      ovl: do not copy up a dentry that was removed
      aio: fix NULL deref when a fault races ring truncation

Christian Brauner (11):
      exec: cancel io_uring requests before de_thread()
      fork: move the coredump and exec checks into create_io_thread()
      fork: don't create io threads once PF_POSTCOREDUMP is set
      Revert "namei: don't reveal overmounted entries in refwalk"
      fs: don't silently unmount busy mounts
      namespace: check a recursive bind mount for mount namespace loops
      namespace: never expire a locked mount
      ipc: drop the mqueue mount with kern_unmount() on setup failure
      ntfs3: free replaced mount options after a grace period
      statmount: don't copy the reserved empty string past the buffer
      listmount: don't wrap around with a U64_MAX cursor

Christian Marangi (1):
      i2c: mt7621: fix copying uninitialized kernel stack with reduced page_len

Christoph Zwerschke (2):
      Revert "Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU"
      Revert "Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU"

Chuck Lever (20):
      lockd: Fix use-after-free in nlmsvc_retry_blocked
      pnfs/blocklayout: Complete a device upcall only on its own reply
      pnfs/blocklayout: Complete a device upcall when the pipe is closed
      NFSD: Do not send CB_RECALL_ANY to NFSv4.0 clients
      NFSD: Don't complete a cld upcall the daemon has not read
      NFSD: Fail a pool_threads read whose reply does not fit
      NFSD: Fix out-of-bounds read in the rpc_status dump
      NFSD: map fh_verify() status codes for NFS_ACLv3 replies
      NFSD: Reject an oversized principal hash from nfsdcld
      NFSD: Resolve the recall-any mask names in the trace format
      NFSD: Return NFSERR_ISDIR for NFSv2 READ and WRITE on a non-regular file
      NFSD: Set nn->cld_net before registering the cld pipe
      SUNRPC: Copy the deferred RPC Call from the head buffer
      SUNRPC: Do not credit control-record octets to the RPC stream
      SUNRPC: Reject a socket that already has an svc_sock attached
      SUNRPC: Reject a TLS alert record that is not two octets
      SUNRPC: Resume receiving after a TLS control record
      SUNRPC: Treat every TLS error alert as fatal
      svcrdma: Grant credits from the clamped sc_max_requests
      exportfs: Release the get_name() directory file synchronously

Cong Nguyen (2):
      media: microchip-csi2dc: fix async notifier leak on probe error path
      staging: media: imx: csc-scaler: fix ipu_image_convert_run leak on queue error

Csaba Budai (1):
      ALSA: hda/realtek: Fix ALC700 audio on Intel Hades Canyon

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

Daeho Jeong (3):
      f2fs: avoid setting SBI_NEED_FSCK on transient resize failure
      f2fs: convert inline quota files when turning quota on
      f2fs: disallow mmap write and data-modifying fallocate on atomic files

Daehyeon Ko (9):
      vsock/vmci: validate packet source for connected sockets
      aio: prevent eventfd/epoll recursion on poll
      ipc/mqueue: release notification resources during inode eviction
      crypto: algif_skcipher - rewind rounded output bytes
      ipv6: remove ifaddr from hash during ifdown list cleanup
      ipv6: serialize address publication with device teardown
      ipv6: initialize temporary ifaddr before publication
      ipv6: do not restart DAD for a dead ifaddr
      splice: avoid stale f_pos writeback on error

Daejun Park (2):
      jbd2: don't advance j_fc_off before the buffer is recorded
      ext4: don't report delalloc data as a hole on indirect-mapped inodes

Dairui Zhang (2):
      ksmbd: fix OOB read and cross-share confusion in ksmbd_validate_name_reconnect()
      ksmbd: verify transform SessionId matches the decrypted header

Damon Ding (2):
      drm/panel-edp: Add BOE NE160QDM-NY1 panel
      drm/bridge: analogix_dp: Restore mandatory samsung DP DT properties

Daniel Golle (4):
      net: dsa: mt7530: error out on failed PHY_IAC command writes
      net: dsa: mt7530: check bus->read() error in core_rmw()
      net: pcs: mtk-lynxi: check regmap reads in mtk_pcs_lynxi_get_state()
      net: dsa: mt7530: check CORE_PLL_GROUP4 access in mt7531_setup()

Daniel Ortiz (1):
      ASoC: amd: yc: Add DMI quirk for Lenovo V15 G6 ARP

Daniel Schaefer (1):
      iio: hid-sensor: als: scale each channel individually

Dapeng Mi (3):
      perf/x86/intel: Fallback to sw branch type decoding if no hw decoding
      perf/x86: Unregister PMI handler on PMU init failure
      perf/x86: Free hybrid state on PMU init failure

Darrick J. Wong (50):
      xfs: don't cross reference rmapbt with bitmaps if they're incomplete
      xfs: clear the symlink zapped flag if inline symlink is ok
      xfs: compute the correct fdblocks/frextents for repair when they're negative
      xfs: fix ondisk symlink target validation in xrep_dinode_check_dfork
      xfs: fix xfs_rename_space_res for non-pptr filesystems
      xfs: fix missing xfs_qm_adjust_dqlimits call in quotacheck repair
      xfs: fix buffer overruns in xfs_ioc_attr_list
      xfs: online quotacheck must dirty dquot if enforcement adjustments needed
      xfs: fix unnecessary dapos truncation in xchk_dir_walk
      xfs: fix buffer overflow in corrupt inline attr structure
      xfs: actually report corrupt xattrs as XFAIL during cross-referencing
      xfs: fix inode btree repair when a cluster is larger than a chunk
      xfs: always reset incore attr fork buffer when resetting fork
      xfs: don't pass iget failures up when marking ondisk inodes
      xfs: don't fix the directory tree if live update fails
      xfs: don't proceed with xattr repair if the live update fails
      xfs: fix skipped inode mask handling in iscan
      xfs: don't repair fs summary counters with garbage
      xfs: fix lost errno returned from xfarray_foliosort
      xfs: allow softlimit with no hardlimit in quota scrub
      xfs: assign an owner to scrub_stats_fops
      xfs: bail out of directory tree repairs on error
      xfs: fix revalidation of xchk_dquot_iter cached mappings
      xfs: abort dirtree repair if the live update hook dies
      xfs: check fork type against dabtree block magic number
      xfs: mark overfull dabtree node blocks as corrupt
      xfs: jump out of xchk_bmap_check_rmap if fatal signals
      xfs: adjust checks for cross-AG reaping issues
      xfs: fix xchk_stats_estimate_bufsize to allow for the trailing null
      xfs: reject absurdly large xattr value lengths in xchk_xattr_actor
      xfs: abort directory tree repair whenever dl->aborted is set
      xfs: always forget cached ACLs if the attr fork swap succeeds
      xfs: always report inode repair setup failures
      xfs: always report scrub errors in tracepoints
      xfs: always zero the whole shortform header when zeroing attr fork
      xfs: check for fragments when full-extent sharing matches
      xfs: check for termination during rmap btree walk
      xfs: clarify various parts of the bitmap API
      xfs: clear set[ug]id mode bits when zapping attr fork
      xfs: don't clear COWEXTSIZE on directories on reflink filesystems
      xfs: don't overrun incore inode when cleaning attr forks
      xfs: don't rescan ifree and icount when frozen
      xfs: don't subtract excess usage twice when computing agf_btreeblks
      xfs: fix correction of unwritten extents in quota file data fork
      xfs: fix data fork block count check in xrep_inode_blockcounts
      xfs: never reset the default quota timer
      xfs: only written file data blocks can be shared
      xfs: opportunistically skip btree block checks
      xfs: propagate errors while checking null siblings
      xfs: range-check bc_levels array access in scrub tracepoints

Dave Carey (1):
      HID: multitouch: Fix stale MT slots when contact count drops to zero

David Bauer (2):
      wifi: mt76: mt7603: free beacon SKB on error
      wifi: mt76: mt7915: configure noise floor reporting on reset

David C.C.M. Gall (3):
      crypto: keembay - use crypto_memneq() to compare GCM AEAD tags
      crypto: sa2ul - use crypto_memneq() to compare AEAD tag
      crypto: keembay - use crypto_memneq() to compare CCM AEAD tags

David Carlier (1):
      ring-buffer: Take cpus_read_lock() when changing the subbuf order

David Cemin (1):
      ASoC: sdw_utils: clear stale RT711 device reference on exit

David Francis (2):
      drm/amdkfd: Avoid integer underflow with ffs in EOP ring size calc
      drm/amdkfd: Avoid integer underflow in EOP ring size calculation.

David Heidelberg (9):
      soc: qcom: socinfo: Add SoC ID for SDM850
      dt-bindings: arm: qcom,ids: Add SoC ID for Snapdragon SDM 850
      backlight: qcom-wled: Fix NULL pointer dereference in wled_remove()
      backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe
      backlight: qcom-wled: Fix WLED3 brightness register stride
      mfd: wcd934x: set DMA mask on parent to silence "DMA mask not set"
      mfd: wcd934x: Fix NULL pointer dereference on IRQ probe deferral
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Extend the xbl_mem region
      arm64: dts: qcom: sdm845-xiaomi-polaris: Extend the xbl_mem region

David Hildenbrand (Arm) (1):
      mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()

David Howells (2):
      rxrpc: Fix double IRQ enablement
      rxrpc: Fix return in rxrpc_recvmsg_data() for service calls

David Laight (1):
      usb_string_copy: Use kzalloc() to avoid leaking old data

David Strahan (1):
      scsi: smartpqi: Add new PCI device-ids

David Woodhouse (3):
      KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration
      KVM: x86/xen: Take kvm->srcu in __kvm_xen_has_interrupt()
      tun: Require CAP_NET_ADMIN to attach to an ownerless device

David Yang (1):
      net: hisilicon: hisi_femac: Stop the receiver before releasing the RX ring

Deepanshu Kartikey (2):
      udf: avoid recursive s_alloc_mutex deadlock when freeing AED blocks
      media: imon: fix use-after-free in display_close via dev_dbg

Denis Arefev (1):
      ALSA: cs46xx: fix unit mismatch in DSP code area bounds check

Denis Batishchev (1):
      ALSA: hda/realtek: Enable micmute LED on HP EliteBook 6 G1a p/n: AD3Q9ET#UUG

Denis Benato (2):
      platform/x86: asus-wmi: fix unclear usage of bd->props.power
      platform/x86: asus-wmi: fix screenpad power state detection

Denis Efremov (Oracle) (2):
      floppy: don't store a stack buffer in timeout_message
      floppy: return the drive state flags from the 32-bit FDGETDRVSTAT

Denis V. Lunev (1):
      virtio_balloon: warn on failed buffer add in tell_host()

Dev Jain (2):
      mm/rmap: use huge_ptep_get() in try_to_migrate_one()
      mm/migrate: use huge_ptep_get() in remove_migration_pte()

Devansh Soni (1):
      staging: rtl8723bs: fix missing unregister_netdev on sdio_alloc_irq failure

Devin Wittmayer (1):
      wifi: mt76: mt76x02: report rx FCS errors to mac80211

Dibin Moolakadan Subrahmanian (1):
      drm/i915/dmc: Add sanity check for DMC load address

Diego Oliva (2):
      smb: client: fix use-after-free infoleak via the readdir resume name
      smb: client: fix OOB last_entry pointer from unbounded LastNameOffset

Dmitry Antipov (1):
      HID: roccat: fix locking in roccat_connect() and roccat_disconnect()

Dmitry Osipenko (1):
      clk: tegra: support 48MHz clock for pll_p_out1

Dmitry Torokhov (1):
      mfd: ipaq-micro: Fix out-of-bounds stack read in ipaq_micro_str

Dmytro Moroziuk (1):
      ALSA: hda/conexant: Add mute LED quirk for HP ProBook 440 G5

Dominik Maier (2):
      smb: client: fix slab-out-of-bounds write in id_mode_to_cifs_acl()
      loop: check for read-write open mode on LOOP_SET_STATUS in lo_compat_ioctl()

Donggeun Yoo (2):
      tracing: Fix NULL dereference when copying keys for a field variable
      mm/damon/core: charge only the part of a region the filter left

Drobyshev Vladimir (1):
      USB: cdc-acm: add VeriFone VX820 device ID

Eason Lai (2):
      wifi: mt76: mt792x: fix UAF in SDIO TX path when out of memory
      wifi: mt76: fix memory leak in USB TX path

Eckhart Mohr (4):
      ALSA: hda/realtek: Add quirk for ASRock NUC BOX-358H
      ALSA: hda/realtek: Add quirk for TongFang X6xx45xU
      ALSA: hda/realtek: Add quirk for TongFang X6SP45xU
      ALSA: hda/realtek: Add quirk for TongFang XxAF5xxx

Emmanuel Grumbach (2):
      wifi: iwlwifi: mvm: reset the smart fifo state upon FW stop
      wifi: iwlwifi: mvm: ignore sync frames when sync is disabled

Eric Biggers (1):
      fsverity: Be more careful with return value of ->get_verity_descriptor()

Eric Dumazet (4):
      gre: fix ERSPAN o_flags race/corruption in xmit and fill_info
      vlan: restore HW VLAN tag insertion with reorder_hdr off
      dlm: fix send buffer backpressure handling
      ixgbe: reserve TX timestamp after skb preparation

Eric Huang (1):
      drm/amdkfd: add sanity check in svm_range_is_valid

Eric Kim (1):
      sched/fair: Reset NUMA fault locality after scan period update

Esteban Urrutia (1):
      iommu/arm-smmu-qcom: Add SM8450 MDSS compatible

Ewan D. Milne (1):
      scsi: devinfo: Add BLIST_SKIP_IO_HINTS for EMC Symmetrix

Fan Wu (12):
      media: au0828: fix use-after-free in bulk_timeout timer on disconnect
      media: imx-jpeg: cancel timeout worker when streaming stops
      media: marvell: mcam: stop DMA and cancel s_bh_work before freeing DMA buffers
      ASoC: amd: ps: fix snd_acp63_remove() teardown ordering
      media: s5p-mfc: use timer_shutdown_sync() for the self-rearming watchdog
      scsi: dc395x: sync the waiting_timer before freeing the host
      media: imx-jpeg: finish the job on device_run() error paths
      media: cx231xx-audio: drain wq_trigger before audio fini
      media: nuvoton: npcm-video: quiesce VCD IRQ before teardown
      media: vivid: cancel svid ctrl work on release
      media: mediatek: vpu: free IRQ before destroying watchdog workqueue
      virtio_fs: read the vring size under virtio_fs_mutex in ->get_tree

Fang Xieyan (4):
      kcov: ignore an out-of-range comparison count in write_comp_data()
      kgdb: Fix buffer overflow in the 'm' packet handler
      kgdb: Fix buffer overflow in the 'M' and 'X' packet handlers
      kgdb: Fix buffer overflow in the qRcmd packet handler

Farhan Ali (1):
      PCI: Avoid saving config space state if inaccessible

Federico Valentín Andrade (1):
      ALSA: usb-audio: Skip mixer creation on M-Audio Venom

Felix Fietkau (4):
      wifi: mt76: mt7615: fix NULL deref in mt7615_mac_set_rates
      wifi: mt76: set the EOSP bit in the QoS header of the last released frame
      wifi: mt76: mt7603: fix U-APSD service period termination
      wifi: mt76: mt7603: file buffered frames under the TID reported to mac80211

Felix Hoffmann (1):
      libceph: reject mismatched CRUSH weight-set sizes

Feng Tang (1):
      selftests: net: reuseport_bpf_numa: consider cpuless numa node

Fernando Fernandez Mancera (1):
      netfilter: tproxy: use DEBUG_NET_WARN_ON_ONCE for protocol fallbacks

Filipe Manana (1):
      btrfs: fix memory barrier order in reloc_root_is_dead()

Francesco Dolcini (2):
      arm64: dts: ti: k3-am62-verdin: Set MMC clock pins as OUTPUT
      arm64: dts: freescale: imx8mp-verdin-yavia: fix external GPIOs

Frank Sorenson (1):
      cifs: add cifs_resize_file_locked() to guard fscache_resize_cookie() under i_rwsem

Fredric Cover (1):
      smb: client: fix early procfs exposure race

Fuad Tabba (2):
      KVM: arm64: Transfer the hyp stack pages out of the host stage-2
      irqchip/gic-v3-its: Don't clamp nvecs to zero when id_bits is 32

Gabor Juhos (1):
      clk: qcom: gcc-ipq5018: mark 'gpll0_main' clock as critical

Gabor Tanz (1):
      HID: quirks: Always poll the Anne Pro 2 with product ID a292

Gabriel Prostitis (1):
      USB: gadget: inode: fix mm lifetime handling

Gael Blivet (5):
      ksmbd: fix durable handle v2 default timeout units (60 -> 60000)
      ksmbd: fix off-by-one rejecting minimal COPYCHUNK query-limits request
      ksmbd: skip fallocate for SMB2_CREATE_ALLOCATION_SIZE on a stream handle
      ksmbd: report actual xattr value length in stream enumeration
      ksmbd: fix AsyncId zeroed before use in smb2_lock() cancel response

Gangliang Xie (1):
      drm/amdgpu: add buf length check

Garrett Blackmon (1):
      ALSA: hda/realtek: Fix speakers on ASUS ROG Zephyrus G14 GA403UM

Gary Guo (2):
      ata: ata_generic: Don't store pci_device_id
      rust: cfi: disable function merging if CFI is enabled

Geetha sowjanya (1):
      perf: marvell: Cancel CN10K DDR PMU hrtimer on device remove

Geliang Tang (1):
      nvme-tcp: look up host_iface in the current netns

Georgia Garcia (1):
      apparmor: remove fs entries created by a failed policy load

Geraldo Nascimento (1):
      PCI: rockchip-host: Do not attempt 5.0 GT/s retraining

Gilles Risch (1):
      drm/radeon: fix internal display on iMac11, 1 (RV770/DCE3.1)

Ginger Li (1):
      media: exynos4-is: Fix a race between s_stream(0) and the interrupt handler

Giorgi Kobakhia (2):
      udf: fix return value for non-recorded-allocated extents in udf_map_block()
      ksmbd: fix overflow in dacloffset bounds check in build_sec_desc()

Greg Kroah-Hartman (4):
      media: adv7604: avoid negative array index in log_status when cp_read fails
      media: stv090x: bound DiSEqC reply length to msg[] size
      media: stv0900: bound DiSEqC reply length to msg[] size
      Linux 6.12.117

Gregory Price (4):
      mm/mempolicy: take a cpuset cookie for the interleave node count
      mm/madvise: reclaim isolated folios if PTE restart fails
      mm/madvise: use folio_trylock() in the cold/pageout PMD split
      rtc: cmos: Disable ACPI RTC event before handling it

Gregory Price (Meta) (1):
      mm/mempolicy: apply bind policies against the scoped allocation zone

Griffin Kroah-Hartman (2):
      nfc: mrvl: spi: Unregister dev on allocation fail
      nfc: nxp-nci: Add remove on IRQ error

Guanghui Feng (1):
      iommu/vt-d: Fix CACHE_TAG_NESTING_DEVTLB polluting shared variables in flush loop

Guanglei Zhu (1):
      ceph: fix out-of-bounds read in ceph_netfs_issue_op_inline()

Guangshuo Li (15):
      i2c: qcom-cci: fix autosuspend cleanup
      media: i2c: alvium-csi2: balance runtime PM usage count on remove
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
      irqchip/imx-intmux: Fix runtime PM teardown on remove
      PCI: qcom-ep: Deinitialize endpoint on remove

Guixin Liu (3):
      nvmet-fc: Tear down the association when the admin queue allocation fails
      nvmet: Finish the blk plug when integrity allocation fails
      nvmet: Free the old negotiation state when restarting authentication

Guixiong Wei (1):
      platform/x86/intel-uncore-freq: Continue restoring limits on resume

Guopeng Zhang (1):
      mm: memcg-v1: fix wrong linux-mm list address in deprecation warnings

Gyokhan Kochmarla (1):
      erofs: use on-disk blkszbits for lz4 max pcluster bound

Günther Noack (1):
      landlock: Fix superblock use-after-free in release_inode()

Haikun Zhou (1):
      drm/panel-edp: Support MB116AS01'3 edp panel

Hans Verkuil (5):
      media: em28xx: dev_info->pr_info since dev has been freed
      media: em28xx: requeue buffers if start_streaming fails
      media: em28xx: use vb2_video_unregister_device
      media: cec: tegra_cec: don't break off msg on NACK
      media: cec/core: drop cec_post_state_event call

Hao Ge (1):
      netfs: Fix missing alloc tagging of direct mempool allocations

Haoxiang Li (4):
      ASoC: hdac_hdmi: Fix resource cleanup on probe failure
      tty: serial: pch_uart: add check for pci_get_slot()
      usb: fsl_qe_udc: check qe_alloc_request() failure in ch9getstatus()
      iwlwifi: dvm: add missing cleaup for on error path

Harald Freudenberger (1):
      s390/zcrypt: Fix out-of-bounds ptr advance in cca_query_crypto_facility()

Hari Mishal (4):
      nvme: bound ns descriptor header and body to identify buffer
      virtio_console: take a kref in find_port_by_vq() to fix port UAF
      nvmet: passthru: fix OOB reads when parsing ns id descriptor list
      drm/amd/display: guard dc_sink dereferences in MST mode validation

Harry Wentland (1):
      drm/amd/display: Force GAMCOR for subsampled surfaces with PQ/Gamma22/HLG

Harry Yoo (Meta) (1):
      mm/percpu: account full object size for percpu memory allocations

Heiko Carstens (2):
      s390/probes: Fix wrong opcode for cgrb fixup
      s390/signal: Fix incorrect return address in signal frame

Heiko Schocher (1):
      drm/panel: simple: Add Kyocera tcg070wvlq panel

Helge Deller (1):
      fbcon: Fix KASAN slab-out-of-bounds Read in fbcon_prepare_logo

Hemanth Selam (1):
      ext4: skip extra isize expansion while unmounting

Hengyu Liang (1):
      btrfs: return -ENOTTY for unknown ioctls on the control device

Henrik Enquist (1):
      ALSA: aloop: Update the PCM Slave controls for a matching playback

Henry Hu (1):
      ksmbd: fix invalid pointer dereference when get_inode_acl() fails

Henry Martin (3):
      smb: client: fix use-after-free in cifs_ses_add_channel()
      drm/amdkfd: fix doorbell allocation race creating duplicate allocations
      tipc: fix broadcast sender hang on last acker departure

Hernan Ganzo (1):
      ALSA: hda/realtek: Limit internal mic boost on HP Pavilion 15 (103c:2164)

Hitesh Patel (2):
      media: qcom: camss: vfe-17x: Fix write master buffer done being dropped
      media: qcom: camss: vfe: Fix VFE reset while another line is streaming

Hongfu Li (2):
      mm/hugetlb_cgroup: move per-node usage on cross node migration
      mm/hugetlb_cgroup: move per-node usage on cgroup reparenting

Honglei Huang (1):
      drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages

Hongling Zeng (1):
      ntfs3: fix mapping pairs bounds check for alignment

Hongyan Xu (1):
      mfd: da903x: Cancel IRQ work during teardown

Hsiu-Hsien Lee (1):
      ext4: fix fast commit replay failing on a read-only mount

Huacai Chen (6):
      cpufreq: loongson3: Make this driver depend on MACH_LOONGSON64
      cpufreq: loongson3: Adjust the width of id and val in smc_message
      cpufreq: loongson3: Replace per-package mutex with per-node
      cpufreq: loongson3: Use global physical CPU ID in get/target callbacks
      cpufreq: loongson3: Replace IOCSR read/write with MMIO ones
      LoongArch: Use pa_to_nid()/nid_to_addrbase() rather than hard-code

Hui Peng (2):
      ata: libata-scsi: abort multi-sector pass-through commands when multi_count is 0
      seccomp: restore knotif->state when SECCOMP_ADDFD_FLAG_SEND is interrupted

Hui Su (2):
      io_uring/waitid: honor task_work cancellation
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

Ian Bridges (3):
      ksmbd: fix out-of-bounds read when padding the final compound response
      ksmbd: fix use-after-free after a failed durable reconnect
      ksmbd: fix session reference leak on compounded SESSION_SETUP

Ibrahim Hashimov (1):
      fs/ntfs3: fix integer overflow in find_log_rec() causing OOB read

Ido Schimmel (3):
      ipv6: Fix redirect exception creation for UDP/RAW sockets
      ipv6: udp: Create exceptions before socket matching
      ipmr: fully initialize the synthetic IP header in ipmr_get_route()

Igor Putko (1):
      serial: core: shut down initialized port on removal

Ilya Maximets (1):
      net/sched: act_ct: remove 'add_helper' dead code

Imre Deak (1):
      drm/i915/dp_mst: Fix configuring TUs for a disconnected stream

Imre Kaloz (3):
      mm/slab: sample slab_state once in kmem_cache_destroy()
      PCI: Disable MSI for ULi M1575 EHCI controller
      PCI: Avoid D3 on PLX PEX 8532/8533/8548 downstream ports

Israel Téllez García (1):
      libbpf: Fix ring buffer consumer loop on 32-bit position wrap

Jack Boykin (1):
      platform/x86/amd/pmf: Fix power_supply refcount leak in amd_pmf_get_battery_prop()

Jack Yu (1):
      ASoC: rt712-sdca: Pull high JD2 to prevent from entering TV mode

Jackson Lee (2):
      media: chips-media: wave5: Set inst->std during default format initialization
      media: chips-media: wave5: Resume device before setting EOS flag

Jaidheer Sirigineedi (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion 15-eg3xxx (103c:8bfd)

Jake Labelle (1):
      nilfs2: validate directory position after llseek in readdir

Jamal Hadi Salim (4):
      net/sched: cls_bpf: accept dev-bound programs on shared blocks
      net/sched: sch_teql: fix slaves_lock IRQ deadlock
      net/sched: act_ife: do not consume the inner header on egress
      netdevsim: reject cls_bpf programs bound to another device

James Hilliard (1):
      mtd: rawnand: sunxi: reject ECC maximization on small pages

James Kim (1):
      rapidio: mport_cdev: fix use-after-free in mport_mm_close()

Jan Kara (2):
      udf: Fix bh leak for unallocated space entries
      udf: Make sure there's enough space for LVID implementation use field

Jan Koester (1):
      ksmbd: ignore network devices of other namespaces

Janani Sunil (1):
      iio: adc: adi-axi-adc: Initialize state mutex

Janne Grunau (1):
      nvmem: core: Fix OOB read for bit offsets of more than one byte

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

Jean-Baptiste Maneyrol (2):
      iio: imu: inv_icm42600: fix odr change not caught in certain cases
      iio: imu: inv_icm42600: force accel odr change when switching power mode

Jeff Layton (4):
      nfsd: use test_and_clear_bit for somebody_reclaimed to prevent lost update
      NFSD: cap the number of listeners accepted in listener_set
      NFSD: validate transport name in listener_set before serv creation
      SUNRPC: keep the first error in svc_register()

Jeffin Philip (1):
      media: vidtv: fix uaf in vidtv_bridge_on_new_pkts_avail

Jenson Johnathon Reggentin (1):
      docs: block: fix dead http link in blk-mq.rst

Jerome Brunet (1):
      clk: sunxi-ng: fix ccu probe clock unregister on error

Jesse Zhang (5):
      drm/ttm: return an error when kmapping a BO without pages
      drm/amdgpu: reject ANONONLY userptrs that span multiple VMAs
      drm/amdkfd: don't drop an SVM CWSR reference that was never taken
      drm/amdkfd: split vram_pages of SVM ranges prefetched without a GPU mapping
      drm/amdkfd: evict the queues only once for CRIU PROCESS_INFO

Jia Zhu (1):
      NFSv4: pin the superblock for active state owners

Jiacheng Xu (1):
      kobject: fix out-of-bounds access in kobject_action_type()

Jiakai Xu (1):
      RISC-V: KVM: Fix double-free of sdata in kvm_pmu_clear_snapshot_area()

Jiale Yao (29):
      HID: zydacron: validate key report length
      HID: cougar: reject short special-key reports
      HID: cp2112: validate response report lengths
      HID: elo: reject short touchscreen reports
      HID: logitech-dj: validate unnumbered keyboard reports
      HID: mcp2200: validate READ_ALL response length
      HID: mcp2221: validate response report length
      HID: prodikeys: validate fixed-format MIDI reports
      HID: pxrc: reject short input reports
      HID: roccat: isku: reject short button reports
      HID: roccat: koneplus: reject short button reports
      HID: roccat: konepure: reject short button reports
      HID: roccat: kovaplus: reject short button reports
      HID: roccat: pyra: reject short button reports
      HID: roccat: ryos: reject short special reports
      HID: roccat: savu: reject short special reports
      iio: dac: ad5755: validate SPI match data
      iio: frequency: adf4377: reject devices without match data
      iio: potentiometer: x9250: reject devices without match data
      iio: pressure: bmp280: validate SPI match data
      iio: adc: max11205: reject devices without match data
      iio: adc: mcp3911: reject devices without match data
      iio: adc: ti-adc128s052: validate SPI match data
      iio: accel: adxl313: reject devices without match data
      iio: accel: adxl380: reject devices without match data
      cxl/acpi: Check ACPI companion before use
      wifi: mt76: mt7615: cancel reset work during unregister
      hwmon: (gigabyte_waterforce) reject short input reports
      drm/amdkfd: validate SRAT subtables before parsing

Jiaming Zhang (2):
      hfsplus: validate extent record length before writing it back
      ocfs2: fix chunk number of the first chunk in a local quota file

Jianyun Gao (2):
      dax: Return errors from dax_core_init()
      dax: fix dax_range_compare_iter() to use correct size and address offset

Jiawen Liu (6):
      spi: bcm-qspi: return error from failed controller suspend
      spi: bcm63xx: return error from failed controller suspend
      spi: bcm63xx-hsspi: return error from failed controller suspend
      spi: nxp-fspi: disable runtime PM on probe failures
      spi: bcmbca-hsspi: return error from failed controller suspend
      media: amphion: fix runtime PM imbalance on probe failure

Jiaxing Hu (1):
      iommu/rockchip: Clear stale page faults before enabling stall

Jiayuan Chen (2):
      netfilter: ebtables: bound num_counters like nentries in do_replace()
      bonding: fix out-of-bounds read of arp_ip_target

Jimmy Zuber (1):
      fuse: zero the partial EOF page when extending a file

Jingyi Wang (2):
      remoteproc: qcom: Check subdev start status in rproc_stop()
      remoteproc: core: cancel crash_handler work in rproc_add() error path

Jinhui Guo (1):
      net: usb: cdc_ether: add quirk for AMI BMC stale link events

Jinjie Ruan (1):
      ext4: fix out-of-bounds read in ext4_get_group_info()

Jinqian Yang (1):
      virtio_ring: fix infinite loop in virtnet_poll_cleantx when device is broken

Jiri Slaby (SUSE) (2):
      serial: 8250_exar: store the GPIO platform device in struct exar8250
      serial: 8250_lpss: do not touch uninitialized line in ehl_serial_exit()

Jiucheng Xu (1):
      f2fs: force out-place update for all writes on compressed file

Joanne Chang (1):
      f2fs: allow pinning empty compressed files

Johan Alvarado (1):
      net: stmmac: raise TX completion interrupt at the end of an xmit burst

Johan Hovold (7):
      driver core: take parent lock on deferred probe
      driver core: fix parent lock use-after-free on USB disconnect
      media: usbtv: drop redundant device reference
      staging: greybus: uart: fix racy TIOCMIWAIT implementation
      USB: cdc-acm: fix urb leak on disconnect
      USB: serial: usb_wwan: fix urb leak on disconnect
      USB: serial: sierra: fix urb leak on write completion

John Garry (2):
      nvme: handle positive error codes in nuse_show()
      nvme: don't reference NS after unlocking in nvme_ns_head_ctrl_ioctl()

John Hubbard (1):
      rust: allow `clippy::as_underscore` in the generated bindings

John Johansen (3):
      apparmor: fix auditing of mount binary data
      apparmor: fix refcount leak in aa_get_newest_profile()
      apparmor: on failed load ensure profile files are removed before parent

Jonas Karlman (1):
      drm/rockchip: dw_hdmi: Use resume_early pm ops for system suspend

Jonathan Gopel (1):
      thunderbolt: Do not RPM complete unrelated subtrees on unplug

Jonghyuk Kim(MalHyuk) (1):
      drm/msm: RCU-free the scheduler-containing ring and VM objects

Jose Villaseñor Montfort (1):
      HID: input: read battery capacity from its actual report offset

Josef Bacik (6):
      driver core: Limit the messages on a refused uevent
      io_uring/io-wq: no new workers once the exit has begun
      mm/hugetlb: fix use-after-free of a new anon folio
      aoe: pull in the headers each received packet type reads
      net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()
      mount: refuse setns() with a shared fs_struct again

Joseph Qi (11):
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

Juan Perdomo (1):
      media: cx231xx: preserve I2C transfer length

Judith Mendez (9):
      arm64: dts: ti: k3-am62a: Fix MMC0_CLK register address
      arm64: dts: ti: k3-am62a7-sk: Set eMMC clock pin as OUTPUT
      arm64: dts: ti: k3-am62a7-sk: Set SD clock pin as OUTPUT
      arm64: dts: ti: k3-am62a-phycore-som: Set eMMC clock pin as OUTPUT
      arm64: dts: ti: k3-am62-lp-sk: Set eMMC clock pins as OUTPUT
      arm64: dts: ti: k3-am625-beagleplay: Set MMC clock pins as OUTPUT
      arm64: dts: ti: k3-am62x-sk-common: Set SD clock pin as OUTPUT
      arm64: dts: ti: k3-am62-phycore-som: Set eMMC clock pin as OUTPUT
      arm64: dts: ti: k3-am62x-phyboard-lyra: Set SD clock pin as OUTPUT

Julian Braha (1):
      media: marvell-cam: fix unmet dependency for VIDEO_MMP_CAMERA

Julian Haarmann (1):
      platform/x86: lenovo/ymc: Only match lower byte in WMI lid switch query response

Julian Sun (2):
      writeback: reset dirtied_when when switching wbs
      writeback: clear old wb dirty state after inode switches

Junhao He (1):
      ACPI: APEI: Handle repeated SEA error storms

Junjie Cao (1):
      ASoC: rt712-sdca-dmic: fix drvdata type in the gain controls

Junrui Luo (4):
      media: vicodec: fix out-of-bounds write on under-rounded coded dimensions
      media: vicodec: make encoder CAPTURE dimensions read-only
      media: vicodec: zero-initialize stateful decoder heap buffers
      media: vicodec: fix NULL deref on oversized frame

Junzhe Yu (1):
      ext4: guard against NULL s_group_info in ext4_get_group_info

Jurison Murati (2):
      media: i2c: ov8865: Drop the runtime PM usage count on stream failure
      media: i2c: ov8865: Program the sensor on stream start

Justin Chen (2):
      memory: brcmstb_dpfe: Fix out-of-bounds access due to DCPU offset
      memory: brcmstb_dpfe: Bounds check DCPU-supplied MSG_ARG_COUNT

Jérémy Jean (7):
      lib/crypto: arm64: Fix lost Poly1305 carry when resuming NEON state
      nfsd: preflight SEQUENCE replies before accepting a slot
      SUNRPC: fix oversized GSS proxy token copy
      nvmet-auth: serialize access to DH-HMAC-CHAP state to fix UAF
      nvmet: free the bvec on file namespace range errors
      ceph: fix 32-bit overflow in readdir reply count check
      libceph: fix out-of-bounds reads from repeated CRUSH bucket entries

KIM MinWoo (1):
      ALSA: hda/realtek: Add quirk for Lenovo ThinkBook 16p Gen 3 ARH (21EK)

Kaho Jiang (2):
      net: ipv4: add zero check for snd_cwnd_clamp
      media: em28xx: fix double free in em28xx_alloc_urbs

Kaixuan Li (1):
      f2fs: check every cur_*_segno[] entry on readonly images

Kameron Carr (1):
      Drivers: hv: vmbus: Bounds check the shared ring buffer indices

Karl Mehltretter (17):
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
      crypto: qat - zero the VF migration state buffer on save
      KVM: arm64: vgic-v3: Undo assignment on iodev registration failure
      KVM: arm64: vgic-v3: Roll back assignments from the new region
      sh: intc: Sort the prio and sense lists after filling them
      ARM: 9488/1: smp: set current pointer in assembly before jumping into C
      ARM: 9491/1: alignment: restore uaccess state on emulation fault

Kate Hsuan (1):
      ACPI: battery: Sanitise model_number by dropping unprintable characters

Kathiravan Thirumoorthy (2):
      clk: qcom: ipq5018: add 24MHz rate for USB UTMI clock
      clk: qcom: ipq5332: add 24MHz rate for USB UTMI clock

Kees Cook (1):
      ipc, msg: Account msg_msg allocations with GFP_KERNEL_ACCOUNT again

Keita Morisaki (1):
      drm/amd/display: Fix swap in median3() for DSC rate control

Kemeng Shi (1):
      irqdomain: Plug leak in irq_domain_alloc_irqs_locked() error path

Kendall Willis (1):
      serial: 8250_omap: fix wake irq cleared during suspend

Keren Sun (1):
      mm: remove unnecessary whitespace before a quoted newline

Kevin Cheng (1):
      KVM: VMX: Synthesize nested EPT violation GVA_IS_VALID/GVA_TRANSLATED bits

Kevin Wang (1):
      drm/amd/pm: fix gpu metrics energy accumulator for smu 13.0.0/13.0.7

Khasar Munkh-Erdene (1):
      staging: rtl8723bs: fix spacing around operators in rtw_recv.c

Kir Kolyshkin (1):
      cgroup: fix cgroup.kill for exited thread group leader

Koichiro Den (4):
      xen/privcmd: Only claim ioreqs matching an ioeventfd
      cxl/port: Convert PCIe link latency to nanoseconds
      cxl: Account for link width in latency calculation
      cxl/acpi: Convert QTG _DSM latencies to picoseconds

Konstantin Khorenko (1):
      selftests/core: fix unshare_test with large fs.nr_open

Konstantin Komarov (3):
      ntfs3: fix info-leak in ntfs_rename()
      fs/ntfs3: load ATTR_BITMAP run extents from $MFT extension records
      fs/ntfs3: Fix memory leak in indx_find_sort()

Kryštof Černý (1):
      w1: ds2482: add OF device match table

Krzysztof Karas (1):
      iommu/dma: Catch scatterlist length overflows

Krzysztof Kozlowski (2):
      drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure
      drm/msm/hdmi_bridge: Correct poweroff/audio cleanup order in post_disable

Krzysztof Wilczyński (1):
      PCI/sysfs: Pass the device name length in UTF-16 code units

Kuan-Wei Chiu (2):
      riscv, bpf: Add support for BPF_SDIV and BPF_SMOD in RV32 JIT
      riscv, bpf: Add support for BPF_MOVSX in RV32 JIT

Kunhai Dai (1):
      blk-iocost: abort weight transfer on invalid donation weights

Kuninori Morimoto (1):
      ASoC: codec: max98926: fixup invert setup mask

Kuniyuki Iwashima (1):
      tcp: Fix potential UAF in reqsk_timer_handler().

Kyle Zeng (7):
      udf: validate extent partition references in udf_current_aext()
      fs/ntfs3: reserve NUL byte when converting UTF-16 names
      io_uring/io-wq: save worker type before dropping its reference
      affs: validate blocks before freeing them
      netfilter: nf_reject: initialize IPCB at inet ingress
      net/packet: check TX_RING fragments before memory accounting
      tcp: fix reordering addition overflow in MTU probing

Lachlan Hodges (1):
      wifi: cfg80211: include cf1 offset when sending chandef

Lad Prabhakar (2):
      watchdog: rzv2h: Obtain clock-divider and timeout values from OF match data
      watchdog: rzv2h: Add support for configurable count clock source

Laxman Acharya (1):
      Bluetooth: hci_event: fix out-of-bounds read in LE PA report reassembly

Laxman Acharya Padhya (1):
      wifi: rtw89: cap firmware section_num before parsing

Lee Jones (5):
      HID: wacom: Use hdev->product in wacom_setup_touch_input_capabilities
      HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration
      HID: wacom: Fix Use-After-Free in wacom_intuos_pad
      HID: wacom: Fix Use-After-Free in wacom_bamboo_pad
      HID: wacom: Redesign shared sibling data lifecycle

Li Jun (1):
      tpm: tpm_tis_spi: fix nodef CR50 tpm_tis_spi_resume is null

Li Qiang (1):
      Bluetooth: hci_bcsp: validate received packet lengths

Li RongQing (1):
      x86/ioperm: Prevent NULL dereference on theoretical missing IO bitmap

Lijo Lazar (4):
      drm/amdgpu: Add checks to vbios fetch through ATRM
      drm/amdgpu: Validate ATIF buffer length before use
      drm/amd/pm: validate vega10 profile mode inputs
      drm/amdgpu: Guard reads in pcie state readout

Linkai Gong (1):
      media: i2c: tc358743: add missing color-space strings

Linus Walleij (2):
      power: supply: ab8500_fg: Accept status from supplied power
      power: supply: ab8500_fg: Report sub-percent charge changes

Liu Chao (2):
      usb: fotg210: validate endpoint index in ep0 handlers
      net: wwan: iosm: validate msg_head before indexing msg_ring

Loc Nguyen (1):
      KVM: x86: Request event processing for exception VM-Exits

Logan Gunthorpe (2):
      PCI: switchtec: Add Microchip PCI1008 device ID
      PCI: switchtec: Add Microchip PCI1008 to NTB DMA alias quirk

Longlong Xia (1):
      mm/zswap: enable zswap_ever_enabled in zswap_pool_create()

Lorenzo Stoakes (ARM) (6):
      HID: picoLCD: check for fb_deferred_io_init() error
      fbdev: ssd1307fb: check for fb_deferred_io_init() error
      fbdev: xen-fbfront: check for fb_deferred_io_init() error
      fbdev: udlfb: check for fb_deferred_io_init() error
      fbdev: smscufx: check for fb_deferred_io_init() error
      fbdev: sh_mobile_lcdc: check for fb_deferred_io_init() error

Lu Baolu (1):
      iommu/vt-d: Avoid out-of-range shift in qi_desc_dev_iotlb_pasid()

Lucas Costa (1):
      spi: bcm2835: fix device_node reference leak in bcm2835_spi_setup()

Lucas Martins Alves (1):
      usb: musb: host: clear stale RX interrupt on three-strikes error

Lucas Stach (1):
      drm/etnaviv: check all modules for idle after reset

Luigi Lauro (2):
      drm/amdgpu: require _PR3 for BOCO
      drm/amd/display: take a runtime PM reference only when a CRTC turns on

Luis Banha (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion 15-ec1xxx

Luis Gerardo Lopez Hernandez (1):
      ALSA: hda/realtek: Fix internal speakers on Acer Aspire AL16-31P

Lukas Wunner (2):
      PCI/AER: Fix mapping of errors to agent & layer
      PCI/AER: Emit TLP Log only for unmasked errors

Luxiao Xu (1):
      smb: client: fix buffer overflow in SMB2_tcon()

Ma Ke (4):
      ASoC: wcd9335: Fix device reference leak in wcd9335_slim_status()
      pinctrl: stm32: Fix fwnode reference leak in stm32_gpiolib_register_bank()
      platform/x86/amd/pmc: Fix RTC reference leak in amd_pmc_verify_czn_rtc()
      i2c: acpi: Fix adapter reference leak in i2c_acpi_new_device_by_fwnode()

Maciej Kucharek (2):
      drm/amdgpu: reset CIK ASIC on Apple boards with VRAM at 0
      drm/amdgpu: reset VI ASIC on Apple boards with VRAM at 0

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

Manikanta Pubbisetty (1):
      wifi: ath10k: trigger hardware recovery upon rx failures

Marc Zyngier (2):
      KVM: arm64: Move OUTSIDE_GUEST_MODE publication past context being saved
      KVM: arm64: Turn vcpu->arch.pause into a counter

Marco Crivellari (1):
      nvmet: replace use of system_wq with system_percpu_wq

Marcos Paulo Medeiros (1):
      ACPI: video: force native backlight on Acer Nitro AN515-46

Marek Czernohous (3):
      drm/nouveau: disable the fence uevent work instead of just cancelling it
      drm/nouveau: cancel the DP IRQ work before freeing the connector
      drm/nouveau: don't dereference outp before checking it in nouveau_dp_irq

Marek Szyprowski (1):
      mmc: dw_mmc: stop and complete DMA also in STATE_DATA_BUSY state

Mariano Baragiola (1):
      wifi: wilc1000: validate monitor transmit frame headers

Mario Limonciello (3):
      platform/x86/amd/pmc: Fix msg_port restoration in amd_stb_debugfs_open_v2()
      platform/x86/amd/pmf: Validate the APTS state index
      drm/amd/display: don't WARN when removing an unallocated MST payload

Mario Peter (1):
      driver core: take parent lock in async device attach

Mark Anthony Agarro (2):
      wifi: mt76: mt76x02: validate TX-status rate index before mac80211 handoff
      wifi: mt76: mt7615: do not tear down BSS/STA state for monitor vifs

Martin Belanger (2):
      nvme: make the DH-HMAC-CHAP secret attributes readable by root only
      nvme-tcp: start error recovery when read_sock fails

Martin Wilck (1):
      md/raid5: validate payload size before calculating payload_len

Matt Turner (4):
      alpha: run the remote RTC access in a worker, not an IPI callback
      lib/decompress_bunzip2: fix off-by-one in run-length bounds check
      alpha: handle VM_FAULT_HWPOISON in do_page_fault()
      alpha: determine tininess after rounding in the FP emulation

Matthew Auld (1):
      drm/xe/display: skip FORCE_WC and vm_bound check for external dma-bufs

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

Matthew Sakai (2):
      dm vdo indexer: prevent delta list overflow on load
      dm vdo indexer: validate record page numbers better

Matthias Goergens (1):
      fanotify: report names longer than NAME_MAX

Matus Gajdos (1):
      ALSA: usb-audio: Add native DSD support for Cambridge Audio streamers

Mauricio Orozco (1):
      ALSA: hda/realtek: Add quirk for ASUS VivoBook M515DA/X515DAP

Maurizio Lombardi (1):
      nvme-fc: do not warn on controller removal race

Max Kellermann (1):
      ceph: avoid pending truncate during nonblocking cap acquire

Maxim Skokov (1):
      media: vivid: round the height down to the vertical subsampling factor

Md Rabbani (1):
      net: stmmac: fix device node reference leaks in stmmac_mtl_setup()

Mehmet Aysel (2):
      ASoC: amd: acp3x-es83xx: Add HVY-WXX9/M1060 DMI quirk
      ASoC: amd: acp-config: Add HVY-WXX9/M1060 DMI quirk

Michael Freidkin (1):
      media: meson: vdec: size capture planes from the aligned canvas

Michael J. Ruhl (1):
      platform/x86/intel/pmt: Block mmap when callback is present

Michael Kelley (1):
      Documentation: hyperv: Update documentation for sending VMBus packets

Michael Liang (1):
      fault-inject: fix dentry leak

Michael Reeves (1):
      regmap: Remove debugfs before cache teardown

Michael Wyraz (1):
      USB: serial: option: add support for ASR 1286:4e3c modem

Michail Andreas Michalopoulos (1):
      ksmbd: accept share config responses from ksmbd-tools before 3.5.3

Michail Tatas (3):
      USB: misc: uss720: Fix leak in get_1284_register
      ipmi: Fix leak in __ipmi_bmc_register
      media: verisilicon: rockchip: Fix leaks in init

Michal Pecio (1):
      ALSA: usx2y: Stop clearing urb->hcpriv before submission

Miguel Ojeda (1):
      objtool/rust: add one more `noreturn` Rust function for Rust 1.101.0

Mike Rapoport (Microsoft) (2):
      x86/mm/pat: Fix effective RW computation in lookup_address_in_pgd_attr()
      x86/mm/pat: Use pr_warn() for early W^X warnings

Mike Tipton (1):
      pmdomain: qcom: rpmhpd: Skip retention by default

Mikko Perttunen (1):
      gpu: host1x: Wait for timeout worker completion on channel free

Mikulas Patocka (10):
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

Minghao Zhang (1):
      netfilter: conntrack: tcp: use UNACK timeout for non-closing RST packets

Miquel Raynal (3):
      spi: cadence-qspi: Fix status polling with octal DTR chips
      mtd: spi-nor: Unprepare legacy controllers upon RWW wait interruption
      dt-bindings: clock: ma35d1: Document the missing crystal inputs

Mithil Bavishi (1):
      ARM: OMAP2+: Add CFI type for omap4_finish_suspend

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

Muhammad Saheed (1):
      Bluetooth: hci_sync: Disable legacy instance's ext adv before setup snapshot

Muhtasham Nawr al-Mahmud (1):
      ALSA: hda/realtek: Fix speakers on ASUS PM3406CHA

Mukesh Ojha (3):
      iommu/qcom: Check pm_runtime_resume_and_get() return in probe
      iommu/qcom: Enable clocks before hardware access in qcom_iommu_ctx_probe()
      iommu/qcom: Publish pgtbl_ops before releasing init_mutex

Myeonghun Pak (16):
      media: cx88: Disable PCI device on MPEG initialization failure
      backlight: lm3630a: Cancel delayed work before destroying workqueue
      media: cx23885: unregister DVB bus when SP2 CI setup fails
      power: supply: sbs-battery: disable polling before supply teardown
      leds: ktd2692: Pass context to regulator cleanup
      media: marvell: manage the MMP camera clock provider
      media: go7007: unregister the I2C adapter on USB probe failure
      media: cx18: Disable PCI device on probe failure
      media: tw68: balance PCI enable on cleanup
      mtd: maps: pci: balance PCI enable on cleanup
      media: amphion: drain message work before releasing core state
      media: amphion: prevent unbind while video instances are open
      ASoC: codecs: rt5682s: disable jack detection work on shutdown
      wifi: mt76: mt7615: restore DBDC state after ext PHY failure
      soc: fsl: dpio: Fix cleanup on IRQ registration failure
      soc: fsl: dpio: Free the IRQ before releasing the I/O object

Namhyung Kim (1):
      tools/lib/api: Fix potential double-free from fdarray__grow()

Namjae Jeon (19):
      ksmbd: wait for negotiation before receiving another PDU
      ksmbd: protect private extended attributes
      ksmbd: preserve access denied status for copychunk
      ksmbd: allow I/O on directory named streams
      ksmbd: reject SMB3.1.1 binding with mismatched cipher
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

Nanzhe Zhao (2):
      f2fs: remove mappedtodisk flag usage in mmap write path
      f2fs: read i_size once in f2fs_vm_page_mkwrite

Nas Chung (1):
      media: v4l2-common: Fix P010 format info

Nathan Chancellor (1):
      wifi: brcmsmac: Adjust txpwrindex value in nphy_ipa_rxcal_gaintbl_2GHz

Navon John Lukose (1):
      i2c: designware: queue only one read command for block reads

Neil Andrews (1):
      ALSA: usb-audio: Rename the Audient iD14 monitor mix volume control

NeilBrown (1):
      nfsd: honour client-provided attributes for NFS4_CREATE_EXCLUSIVE4_1

Ngoc Quy (1):
      fs/proc/task_mmu: pin mm_users in do_pagemap_scan()

Nguyen Ngoc Thang (1):
      net/rds: ib: don't enable IRQs in rds_ib_conn_free()

Nguyen Quang Le Kien (1):
      usb: gadget: fix refcount underflow in gadgetfs_bind() error path

Nickolai Zeldovich (4):
      resource: report a devm_request_resource() conflict under the lock
      lib/buildid: reject file offsets that do not fit in pgoff_t
      ucount: take the rlimit reference before checking the limit
      mm/mlock: use a long for the page count in mlock_fixup()

Nicolas Escande (1):
      wifi: ath12k: avoid setting 320MHz support on non 6GHz band

Nicolin Chen (1):
      iommu/tegra241-cmdqv: Rate-limit the error ISR's log message

Niklas Cassel (5):
      ata: sata_fsl: Fix use-after-free of host_priv on probe() failure
      ata: ahci_st: Do not ignore errors when getting the reset controls
      ata: ahci_st: Assert the power down reset in the probe() error path
      ata: libahci: Free the IRQs when activating a multi-IRQ host fails
      ata: libata: Do not leave ata_host_stop() registered when activation fails

Nikolaj Klitlund Børty (1):
      Bluetooth: btusb: Add device ID for Realtek RTL8761BUE (StarTech AV53C1)

Niranjana Vishwanathapura (1):
      drm/xe: only resume exec queues that were actually suspended

Nirmoy Das (2):
      iommufd: Fix event queue release use-after-free
      blk-mq: clear stale inactive flag on hctx reuse

Nizar Al-Kabbani (1):
      platform/x86: asus-nb-wmi: map ProArt key (0x8b) to KEY_PROG3

OGAWA Hirofumi (1):
      fat: fix fat_ent_write() for reverting the value

Oleg Nesterov (1):
      signalfd: don't dequeue the forced fatal signals

Oleg Proshkin (1):
      mfd: axp20x: Preserve other control bits when powering off

Oliver Neukum (1):
      usb: misc: cypress_cy7c63: check result of IO

Olivier Kaloudoff (1):
      drm/amdkfd: stop restore retries on device unplug

Orgad Shaneh (2):
      mtd: cfi_cmdset_0002: cap the write-buffer chunk at 256 bytes on an x8 device
      MIPS: mm: do not write a huge TLB entry when the probe misses

Osama Abdelkader (1):
      drm/panthor: Fix TOCTOU race between GROUP_REGISTERED check and erase

Oscar Salvador (2):
      mm,hugetlb: change mechanism to detect a COW on private mapping
      mm,hugetlb: sort out folio locking in the faulting path

Pablo Neira Ayuso (3):
      netfilter: nf_tables: call skb_valid_dst() before skb_dst()
      netfilter: nf_conntrack_expect: add and use nf_ct_expect_related_pair()
      netfilter: conntrack: always lower timeout for non-closing RST packets

Pali Rohár (3):
      cifs: Remove duplicate struct reparse_symlink_data and SYMLINK_FLAG_RELATIVE
      cifs: Remove struct reparse_posix_data from struct cifs_open_info_data
      cifs: Rename struct reparse_posix_data to reparse_nfs_data_buffer and move to common/smb2pdu.h

Paolo Bonzini (1):
      KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to kvm_translate_gpa

Paul Moses (1):
      xsk: restore UMEM flags after failed pool assignment

Paulo Alcantara (12):
      smb: client: fix uid/gid override in getattr with posix extensions
      smb: client: fix WSL reparse point uid/gid override
      smb: client: fix file type corruption in posix_reparse_to_fattr()
      smb: client: fix fattr leaking on wsl_to_fattr() failure
      smb: client: clear post-EOF pagecache when extending a file via truncate
      smb: client: discard post-EOF pagecache when extending a file via clone range
      smb: client: flush and commit data before querying allocated ranges
      smb: client: flush dirty data before zeroing a range
      smb: client: drain and invalidate before server-side copy/clone
      smb: client: only require read lease for size-extending zero range
      smb: client: require stable pages for signed connections
      smb: client: don't resurrect an exiting tcon from cached dir workers

Pavel Zverev (1):
      Bluetooth: btusb: Add support for 1357:c123 Realtek 8852BE device

Pedro Falcato (1):
      mm/madvise: atomically clear the young bit on THP MADV_COLD

Pei Xiao (5):
      ipack: ipoctal: add rwsem to guard against TOCTOU in remove path
      media: cx23885: Fix use-after-free in cx23885_finidev due to race condition
      tpm: tpm_nsc: fix NULL pointer dereference on init failure
      tpm: tpm_nsc: stop using the cleanup callback as dev.release
      tpm: fix zero-length read discarding the pending response

Pengpeng Hou (37):
      gpio: pca9570: Use I2C match data
      media: cec: stm32: return an error when log-address wait times out
      ASoC: sma1303: remove fault-check sysfs group on remove
      ASoC: tlv320aic26: remove keyclick sysfs file
      dmaengine: pl330: remove debugfs file on teardown
      iio: adc: max1241: add missing MODULE_DEVICE_TABLE()
      gpio: sifive: add missing MODULE_DEVICE_TABLE()
      mmc: moxart: report DMA completion timeout
      mmc: sdhci-of-ma35d1: add missing MODULE_DEVICE_TABLE()
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
      media: cec: extron: clear response tail before dispatch
      media: mediatek: jpeg: retry HW selection after successful wait

Peter Griffin (1):
      opp: fix use after free in _update_opp_table_clk()

Peter Ujfalusi (7):
      ASoC: SOF: Intel: mtl: Power down DSP if it is left enabled in pre_fw_run()
      ALSA: compress: fix buffer leak on failed SET_PARAMS
      ALSA: compress: reject buffer geometry change on gapless next_track
      ALSA: compress: add missing OPEN-state gate to SET_METADATA
      ALSA: hda: Reject codec reset on ASoC (ext_ops) buses
      ASoC: hdac_hda: Balance the runtime PM disable in codec remove
      ASoC: hdac_hda: Keep runtime PM state in sync across codec remove/probe

Peter Xu (2):
      mm/hugetlb: stop using avoid_reserve flag in fork()
      mm/hugetlb: rename avoid_reserve to cow_from_owner

Petr Mladek (1):
      nbcon/reboot: Switch NBCON consoles into the emergency mode in emergency_restart()

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: remove gart_window_lock usage from gmc v12

Ping Cheng (2):
      HID: wacom: Setup SW_MUTE_DEVICE according to the order of input registration
      HID: wacom: Write shared touch initial status only once

Piotr Kubik (1):
      netfilter: ctnetlink: fix inverted IPv6 address match in dump filter

Piyush Patle (1):
      media: vidtv: fix frontend reference leak on unbind

Pranjal Shrivastava (1):
      PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs

Prashant Rahul (1):
      wifi: mt76: mt7921: fix memory leak when skb_linearize fails in mcu rx event

Praveen Talari (1):
      opp: Use clk_get_optional() to avoid leaving opp_table->clk as an error pointer

Prike Liang (1):
      drm/amdgpu: skip gfx switch_power_profile during GPU reset

Priyank Rathod (1):
      PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overflow

Pufan Jin (1):
      spi: zynq-qspi: fix address buffer corruption and support 4-byte address

Punnay Sharma (2):
      staging: media: av7110: fix corrupted BER reporting in sp8870
      staging: media: av7110: fix sp8870 initialization failure state

Qing Luo (1):
      sctp: auth: discard auth_chunk when skb_clone fails

Qingtao Cao (1):
      bus: mhi: core: Fix sys error transition latency

Quanye Yang (1):
      mptcp: reset msk state on early connect failure

Radiy Zhambakiev (3):
      mfd: tps65217: Fix NULL pointer dereference on IRQ init failure
      mfd: tps65217: Check return value when masking interrupt sources
      mfd: tps65217: Use devres for IRQ domain and wake teardown

Rahul Bukte (1):
      serial: 8250: force synchronous probe for the ISA and PNP drivers

Ramin Moussavi (2):
      microblaze: reserve the ABI argument-home area in the signal frame
      microblaze: don't clobber r3/r4 restored by rt_sigreturn

Randolph Sapp (1):
      drm/etnaviv: force flush on power register ops

Randy Dunlap (1):
      fbdev: maxine: fix 64-bit build error

Raphael Zimmer (2):
      libceph: Fix unsafe decode in ceph_redirect_decode()
      libceph: Fix multiple unsafe decodes in ceph_oloc_decode()

Ratnaker Gautam (1):
      scsi: libiscsi_tcp: Prevent R2T range check overflow

Reinhard Speyerer (2):
      net: usb: qmi_wwan: add Rolling Wireless RN947R
      USB: serial: option: add Rolling Wireless RN947R

Ricardo Neri (1):
      hwmon: (coretemp) Refresh the temperature on the first read

Richard Patel (2):
      genirq: Defer kfree(irqaction) until irq_thread_dtor() finishes
      genirq: Move interrupt thread exit_work object to irqaction

Richard Weinberger (1):
      mtd: Call get_wunit() on the master partition

Ridham Khurana (2):
      platform: cznic: turris-omnia-mcu: Add missing MODULE_DEVICE_TABLE()
      hwmon: (lm95245) Fix negative temperature conversion

Rik van Riel (2):
      media: redrat3: fix UAF in probe error path leaving rc device registered
      mm/page_alloc: count guard pages as free again when their buddy merges

Rituparna Warwatkar (1):
      media: dvb-core: fix feed leak on failed DMX_ADD_PID

Robert Leussler (1):
      rtc: ds1307: fix RX8130 wakeup alarm WADA bit for day-of-month mode

Robin Everaars (1):
      ACPI: button: Add DMI quirk for Razer Blade Pro 17 early 2020 lid switch

Robin Snyders (4):
      power: supply: qcom_smbx: include base when petting watchdog
      power: supply: qcom_smbx: test battery health status bits
      power: supply: qcom_smbx: fix float voltage selector
      power: supply: qcom_smbx: notify battery overvoltage recovery

Rohinthan P (2):
      media: em28xx: use video_unregister_device for radio_dev
      media: v4l2-ctrls: do nothing if controls[0] == NULL in cluster functions

Rongguang Wei (1):
      tap: fix incorrect variable used for USO check in set_offload()

Rosen Penev (5):
      ata: pata_ep93xx: fix PIO fallback when DMA init fails
      nvmem: brcm_nvram: reject empty NVRAM partition
      nvmem: brcm_nvram: fix out-of-bounds access on malformed flash data
      gpio: mvebu: keep resume masks within the irqchip cache
      wifi: ath9k: delete channel-context timers on deinit

Ross Lagerwall (1):
      xen-blkfront: Fix IO race during unplug

Rui Qi (2):
      selftests/ftrace: Force C locale in ftracetest
      riscv: kprobes: Prevent probes in breakpoint handlers

Ruide Cao (1):
      mptcp: hold MP_JOIN msk ref when cloning reqsk

Runyu Xiao (14):
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
      ASoC: pcm6240: do not free an unrequested IRQ
      media: sti: delta: use unaligned accessors for MJPEG SOF fields
      perf: xgene: initialize lock before requesting IRQ
      sh: maple: Use the matching IRQ cookie when invoking free_irq()

Ruoyu Wang (3):
      drm/radeon: avoid double free in r600 DPM cleanup
      ntfs3: initialize err in attr_wof_frame_info
      media: au0828: Free URBs when starting DVB streaming fails

Ryusuke Konishi (2):
      nilfs2: fix deadlock between nilfs_evict_inode() and find_inode()
      nilfs2: clear dirty flag on bdev buffers on log write failure

SJ Park (4):
      mm/damon/core: error damos_commit_quota_goal() for zero target_value
      mm/damon/sysfs: put target pids for damon_start() failure
      mm/damon/sysfs: put target pids for apply_inputs() failure
      mm/damon/sysfs-schemes: read sysfs_filter->addr_range only once

Sahaj Chaudhari (2):
      gpio: davinci: Clear interrupt status in every bank on suspend
      gpio: pca953x: Handle direction register read errors in IRQ paths

Sam Price (1):
      microblaze: preserve the MSR carry flags across signals

Samuel Thibault (1):
      speakup: Fix NULL pointer dereference on VT switch + selection

Sanan Hasanov (1):
      hwmon: (corsair-cpro) Make wait_input_report_lock IRQ safe

Sasha Levin (7):
      Revert "s390/uv: Don't return 0 from make_hva_secure() if the operation was not successful"
      Revert "KVM: s390: Fix FOLL_*/FAULT_FLAG_* confusion"
      Revert "KVM: s390: pv: fix race when making a page secure"
      Revert "KVM: s390: move gmap_shadow_pgt_lookup() into kvm"
      Revert "KVM: s390: use __kvm_faultin_pfn()"
      Revert "KVM: s390: move pv gmap functions into kvm"
      cgroup: don't kill migrated processes through their exiting threads

Scott Gauche (1):
      ALSA: hda/realtek: Fix audio after Windows reboot on ASUS Q423SA

Sean Christopherson (16):
      KVM: SEV: Extract loading of guest-provided VMSA to a separate helper
      KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is unusable
      KVM: x86/mmu: Use split "zap all fast" helpers when invalidating memslot
      KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails
      KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages() error paths
      KVM: SVM: Preserve TLB control (i.e. pending TLB flush) on failed VMRUN
      KVM: SVM: Update control fields on #VMEXIT if and only if VMRUN succeeded
      KVM: x86: Tell ->inject_page_fault() whether or a fault came from hardware
      KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when preparing L2 state
      KVM: Use goto to handle errors during memslot preparation
      KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the MMU has
      KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with EFER.LMA=1 && CR4.PAE=0
      KVM: x86: Preserve DR6.BLD (Bus Lock Detect) when delivering #DB payload
      KVM: x86: Zero reserved synic flags when delivering message to avoid stack leak
      KVM: VMX: Formally define KVM's "0xdead" exit reason used for failed VM-Enter
      KVM: guest_memfd: Gracefully handle xarray errors when binding a memslot

Sean Young (19):
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
      media: meson-ir-tx: Ensure rc_free_device() is called on unbind
      media: meson-ir-tx: Ensure probe error is propagated
      media: ir-hix5hd2: Ensure rdev is setup before interrupts are enabled
      media: ir_toy: Validate the maximum tx carrier
      media: meson-ir-tx: Prevent divide by zero in meson_irtx_prepare_pulse()

Sebastian Andrzej Siewior (1):
      module: Use RCU in find_kallsyms_symbol().

Seiji Adachi (1):
      ASoC: amd: yc: Add Lenovo ThinkPad E16 Gen 2 (21JN) to quirks

Senjin (1):
      fs/ntfs3: fix lseek EINVAL on sparse/compressed files with 64-bit clusters

Seongjae Jeong (1):
      f2fs: fix submit accounting for IPU writeback

Seongjun Hong (1):
      vfio/mlx5: Fix boundary check in set_report_output()

Sergey Senozhatsky (1):
      ext4: fix ABBA deadlock in ext4_rmdir()

Serin Yeh (1):
      media: i2c: ov8856: fix debug message to report actual CSI-2 lane count

Seung Min Shin (1):
      sctp: hold transport reference across connect wait

Shahar Tzarfati (1):
      wifi: mac80211: ibss: read deauth reason_code after frame length check

Shakeel Butt (1):
      memcg: bypass the reclaim and oom killer for dying tasks once oom_reaper is done

Shang En Sim (1):
      ALSA: hda/realtek: Enable mute LEDs on HP Spectre x360 16-aa0xxx

Shao Mingyin (1):
      nvmet-auth: fix error handling on CHALLENGE failure

Sharath Srinivasan (1):
      net/rds: fix rds_message leak in the rds_send_xmit() drop path

Shehryar Ahmad (1):
      iio: accel: adis16201: fix channel order for buffer mode

Shengming Hu (1):
      cpufreq: conservative: Restrict deferred downscaling to low load

Shengzhuo Wei (2):
      media: go7007: bound EZ-USB I2C transfers to the usb_buf size
      power: supply: bq27xxx: synchronize work cancellation on suspend

Shiji Yang (1):
      net: ethernet: mtk_wed: increase WED v2 WDMA RESV_BUFF to 0x80

Shivaprasad G Bhat (1):
      scsi: qla2xxx: Handle INTx not connected while passing through

Shuangpeng Bai (1):
      media: gspca: use vb2_video_unregister_device() on disconnect

Shubham Antil (1):
      RDS/IB: validate receive fragment completions

Siddharth Chintamaneni (1):
      mm: multi-gen LRU: fix NULL lruvec->pgdat deref with memcg disabled on cmdline

Simon Glass (1):
      kconfig: abort rather than loop for ever on EOF

Siwei Zhang (3):
      Bluetooth: L2CAP: Reject mode changes on connected channels
      Bluetooth: L2CAP: Reject invalid TxWindow in configuration requests
      Bluetooth: L2CAP: Use default TxWindow for zero socket option

Sorah Fukumori (1):
      net: gro: don't chain linear parts larger than gso_size into frag_list

Srinivas Kandagatla (2):
      ASoC: codecs: lpass-wsa-macro: use v2.5 Compander1 addresses on v2.5+
      ASoC: codecs: wsa884x: Accept temperatures across the full trim range

Srinivasan Shanmugam (1):
      drm/amdgpu/powerplay: Align get_tonga_state_array() header with prototype

Srish Srinivasan (5):
      pseries/plpks: fix error handling in plpks_read_var()
      pseries/plpks: validate input to plpks_signed_update_var()
      pseries/plpks: clear sensitive PLPKS buffers
      pseries/plpks: clear signed update authentication buffer
      pseries/plpks: clear SED key data after use

Stanislaw Gruszka (1):
      module/kallsyms: fix nextval for data symbol lookup

Stanley Jhu (5):
      scsi: ufs: bsg: Complete the job on error
      scsi: ufs: bsg: Clear the reply buffer before use
      scsi: ufs: core: Clear stale UIC result byte before peer DME retries
      scsi: ufs: core: Remove an always-false WARN_ONCE()
      scsi: ufs: core: Remove completed-without-interrupt path in ufshcd_abort()

Stefan Haberland (1):
      s390/dasd: Snapshot intrc before freeing the request block

Stefan Hansson (1):
      wifi: rsi: Fix types to appease CFI

Stefan Metzmacher (1):
      smb: smbdirect: fix buffer length underflow in RDMA transfers

Stian Halseth (1):
      PCI: Set supported_speeds in set_pcie_port_type()

Stuart Hayhurst (1):
      HID: logitech-hidpp: Add support for G502 X Plus USB mouse

Sumanth Korikkar (1):
      s390/cpum_cf: Check session mask before cpu offline

Sumeet Pawnikar (1):
      powercap: intel_rapl: Fix kernel panic during PMU unbind

Sung Byeongchan (1):
      ALSA: pcmtest: handle multiple wraps in random capture fill

Takashi Iwai (7):
      ALSA: hda/intel: Add sanity check for BAR0 size
      ALSA: control: Fix UAF in snd_ctl_elem_add() on card disconnect
      ALSA: usb-audio: Use the right limit for PCM OOB check
      ALSA: core: Check shutdown flag at D0 power-state, too
      ALSA: ump: Correct return size of fill_rpn()
      ALSA: seq: oss: Skip events until fully initialized
      ALSA: emux: Stop voices before freeing zones in all cases

Takashi Sakamoto (1):
      firewire: core: fix source bus ID detection for AT context in big-endian systems

Tal Zussman (1):
      gfs2: fix the escaped block copy in gfs2_before_commit()

Tanmay Shah (1):
      remoteproc: core: Full attach detach during recovery

Tao Cui (1):
      sched_ext/scx_flatcg: expire cached hweights on weight changes

Tarun Noonemunthala (1):
      ALSA: hda/realtek: Add quirk for HP ENVY 13-aq1xxx

Tharit Tangkijwanichakul (2):
      media: hantro: Harden MPEG-2 control access against NULL
      media: hantro: disable runtime PM before hardware teardown

Theo Andersen Carton (1):
      drm/amdgpu: skip the noirq suspend reset for a switcheroo-parked GPU

Thiébaud Weksteen (1):
      module: validate string table section types

Thomas Gleixner (1):
      futex: Sanitize and document task_struct::futex::state transitions

Thomas Huth (2):
      smb: server: Make sure that passkey is not leaked on the heap in user_config.c
      smb: server: Free session data in user_session.c with kfree_sensitive()

Thomas Renninger (1):
      ACPI: sysfs: Properly map BERT and CCEL data to their ACPI tables

Thomas Weißschuh (Schneider Electric) (1):
      timekeeping: Update offsets on sequence counter retry in ktime_get_update_offsets_now()

Thorsten Blum (7):
      thermal: intel: powerclamp: Reject invalid window_size values
      thermal: intel: int340x: Fix temperature selection around 0 C
      hwrng: amd - report partial reads in non-blocking mode
      hwrng: ba431 - fix reported byte count
      hwrng: core - reject unknown RNG names
      media: imagination: Fix value clamping in calculate_qp_tables
      init: fix early boot crash with bare hostname parameter

Théo Lebrun (1):
      mips: select CONFIG_WEAK_REORDERING_BEYOND_LLSC from CONFIG_EYEQ

Tianchu Chen (2):
      staging: rtl8723bs: fix protected RX frame validation in decrypt path
      staging: rtl8723bs: fix RX buffer OOB write from device-reported length

Tiezhu Yang (8):
      LoongArch: Expand module virtual address space to 2GB
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

Timur Kristóf (2):
      drm/amd/display: Fix fast updates on DCE 6.x
      drm/amdgpu/uvd3.1: Fix checking whether UVD firmware keyselect was already set

Tingjie Zhong (1):
      fbdev: bitblit: Fix glyph clipping when fbcon pans

Tom Zanussi (1):
      tracing: Fix fully-qualified variable reference printing in histograms

Tomasz Bojanowski (1):
      ALSA: usb-audio: Add mixer mapping for MSI MAG B850M MORTAR WIFI

Tomer Maimon (4):
      pinctrl: npcm8xx: enable RMII outputs from RMII groups
      pinctrl: npcm8xx: clear pending GPIO events during init
      pinctrl: npcm8xx: fix debounce register selection
      pinctrl: npcm8xx: move GPIO IRQ setup into request_resources

Tristan Madani (3):
      wifi: rtw89: fix IE length passed to cfg80211_find_ie() in WoW AKM
      cpufreq: intel_pstate: cancel HWP notify work in driver cleanup
      ppp: fix stale pointer access after pskb_may_pull in ppp_ccp_peek

Tsz Shan Chan (1):
      iio: light: apds9306: fix default sampling frequency definition

Tu Dinh (2):
      xen-netback: Fix XenBus connection failure cleanup
      xen-netback: Zero out sring pointers on unmap

Tyrel Datwyler (2):
      scsi: ibmvfc: check for NULL evt in implicit LOGO and target delete path
      scsi: ibmvfc: free ibmvfc_target allocations with mempool_free

Tzung-Bi Shih (1):
      watchdog: rzv2h: Avoid division by zero

Uwe Kleine-König (The Capable Hub) (1):
      regmap: maple: Workaround for another false-positive compiler warning

Vadim Klishko (1):
      HID: i2c-hid: Add a quirk for a Cirque I2C device.

Val Packett (1):
      ASoC: qcom: qdsp6: q6afe: fix clk vote response type mismatch

Vasant Hegde (1):
      iommu/amd: Fix missing CMD_COMPLETE_PPR response for invalid PPR requests

Vasileios Almpanis (1):
      block: drop the cached plug time when blk_add_rq_to_plug() flushes

Vasiliy Kovalev (1):
      ALSA: hda/via: Apply runtime PM workaround for ASUS X55A

Venky Shankar (1):
      ceph: don't fail write_begin with -EAGAIN after flushing old snapc

Vernon Yang (2):
      mm: khugepaged: fix folio is used after folio_put/unlock()
      mm: khugepaged: fix swap entry value to folio_pfn()

VeroFess (1):
      smb: server: size directory name conversion buffer correctly

Vincent Liu (1):
      driver core: Check drivers_autoprobe for all added devices

Vlad Kulikov (1):
      ipc: create_ipc_ns: drop mqueue mount on sysctl setup failure

Vladimir Murzin (1):
      usb: mtu3: Fix double dereference in TP_printk

Vladimir Zapolskiy (2):
      i2c: qcom-cci: Do not check return value of cci_init()
      i2c: qcom-cci: Remove overcautious disable_irq() calls

Vladyslav Tymoshchuk (1):
      ASoC: qcom: q6apm: reset the hw pointer with the fragment queue

Wahid Khan (1):
      HID: intel-ish-hid: ignore post-init ENUM_DEVICES from firmware

Wang Haoran (1):
      fbdev: atmel_lcdfb: fix list_first_entry() on possibly empty modelist in probe

Wayne Chang (1):
      usb: typec: ucsi_ccg: Add retry mechanism in ccg_read

Wei Jie Law (3):
      net: usb: pegasus: do not advance rx_skb->data on dropped frames
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

Weigang He (2):
      media: rc: fintek-cir: process a full RX buffer instead of overflowing it
      mtd: parsers: qcom: fix offset/size overflow on large partitions

Weili Qian (4):
      crypto: hisilicon/hpre - fix pointer dereference before length check
      crypto: hisilicon/hpre - return -EOVERFLOW for small ECDH output buffer
      crypto: hisilicon/hpre - fix ECDH destination DMA mapping
      crypto: hisilicon/hpre - fix GFP flags for dma_alloc_coherent

Weilin Tong (1):
      ipc/shm: fix RSS accounting for hugetlb shared memory

Weimin Xiong (1):
      vdpa/mlx5: roll back MR update after VQ setup failure

Weiming Shi (4):
      net: team: free skb when broadcast has no txable port
      smb: client: stop processing a read response after a receive error
      virtio_net: atomically disable rx mode work
      nvmet-rdma: reject short connection requests

Wenjie Qi (1):
      f2fs: flush SIT journal during filesystem resize

Wentao Guan (2):
      cpufreq/amd-pstate: Skip auto_sel write when it already matches the mode
      mei: vsc: Fix packet CRC computed over pointer size

Wentao Liang (38):
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
      xen-pciback: Fix pcistub_device ref leak in pcistub_get_gsi_from_sbdf()
      mailbox: mtk-cmdq: Fix runtime PM leak in cmdq_mbox_flush()
      btrfs: zoned: fix block group reference leak in btrfs_repair_one_zone()
      PCI: xilinx-xdma: Fix device node reference leak in xilinx_pl_dma_pcie_init_irq_domain()
      irqchip/mchp-eic: Fix clock reference leak in mchp_eic_probe()
      ceph: Fix xattr buffer leak in __send_cap()
      ceph: Fix mds session leak in __open_export_target_session()

Will Porter (1):
      ALSA: usb-audio: Add iD14 MkI to monitor-mix volume quirk

William Hansen-Baird (2):
      wifi: rtlwifi: rtl8723be: Remove unnecessary irq save/restore in hw_init()
      wifi: rtlwifi: fix disabling of ASPM for RTL8723BE with AER flooding

William Palacek (1):
      drm/amdkfd: wait for a GPU reset before freeing a BO

William Theesfeld (1):
      clk: zynq: handle kasprintf() failure in periph_clk registration

Xia Yan (1):
      macvlan: fix passthru promiscuity accounting while down

Xiang Liu (1):
      drm/amd/pm: Guard VBIOS AC timing table walk

Xiang Mei (7):
      libceph: bound mon_command ack decode to front len
      media: em28xx: reject audio endpoint with zero packet size
      media: go7007: only set audio_enabled if go7007_snd_init() succeeded
      fbdev: udlfb: don't rebuild the mode list while the framebuffer is in use
      ceph: reject mdsmaps that claim more than CEPH_MAX_MDS ranks
      ceph: require the dentry lease record to cover struct ceph_mds_reply_lease
      ceph: fix integer overflow in the snap trace bounds check

Xiaofeng Yuan (1):
      RISC-V: KVM: Fix IPI delivery for out-of-order vcpu_id

Xiaogang Chen (1):
      drm/amdkfd: Guard m->cp_hqd_eop_control setting by q->eop_ring_buffer_size

Xiaoyao Li (1):
      KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus lock detected

Xie Bo (1):
      RISC-V: KVM: Propagate interrupted G-stage faults

Ximing Zhang (1):
      hwmon: (coretemp) Fix handling of isolated SMT siblings

Xiong Weimin (1):
      vdpa_sim: hold iommu_lock across dma_unmap passthrough transition

Xiubo Li (3):
      ceph: do not cache negative dentries for snapped directories
      ceph: fix use-after-dereference of NULL ci in __ceph_remove_cap()
      libceph: only set read_from_replica on read requests

Xixin Liu (2):
      nvme-auth: use crypto_memneq for DH-HMAC-CHAP response comparison
      nvme: zns: cap zone report nr_zones by DMA buffer size

Xu Rao (3):
      mmc: block: reject invalid perdev_minors before division
      usb: gadget: u_audio: clean up capture endpoint on feedback failure
      media: m2m-deinterlace: fix default capture field

YANXIN LI (1):
      ufs: use u64 for directory size in ufs_last_byte

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

Yao Kai (1):
      ext4: validate readdir offset before accessing dirent

Yaroslav Dudkov (1):
      platform/x86: msi-ec: Add MSI Katana GF76 11UEK EC firmware

Yashraj Ghule (1):
      ALSA: hda/realtek: Fix mute LED for HP Victus 15-fa1xxx (MB 8C3F)

Yehyeong Lee (4):
      nvmet-fc: fix use-after-free in nvmet_fc_ls_create_connection()
      xen/pcifront: check that an AER callback exists before calling it
      nvme-rdma: don't complete a request after a bogus remote invalidation
      nvme-auth: fail when the controller does not authenticate itself

Yi Cong (1):
      wifi: rtw89: 8851b: fix swapped DPK channel/bandwidth backup fields

YiPeng Chai (1):
      drm/amdgpu: add bounds check to prevent array overflow

Yibo Tan (2):
      fbdev: atmel_lcdfb: Prevent FIFO work after removal
      media: ipu-bridge: Fix use-after-free in IVSC error path

Yichong Chen (5):
      exfat: write moved entry before removing source
      exfat: clean up new entry on add entry failure
      exfat: free new directory cluster if zeroing fails
      io_uring/kbuf: advance head when a pickup empties the buffer ring
      io_uring/net: keep recvmsg buffer select length within MAX_RW_COUNT

Yingjie Wang (2):
      net: unix: reject negative max_dgram_qlen values
      tcp: limit tcp_tso_rtt_log to a valid shift count

Yogesh Gaur (2):
      md: don't hand out the array before md_alloc() has added mddev->kobj
      libceph: reject an initial monmap with no monitors

Yongjian Mu (1):
      xprtrdma: trim head iovec when the payload arrives via a Write chunk

Yongjun Gwon (1):
      ksmbd: serialize directory emptiness checks with readdir

Yosry Ahmed (2):
      KVM: x86: Always initialize EFER reserved bits on vendor initialization
      KVM: SVM: Trigger new ASID allocation in both VMCBs on pCPU switch

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

Yu Zhang (1):
      nvmet: take subsys->lock while force-reconnecting in nvmet_subsys_attr_qid_max_store()

Yu-Hsiang Tseng (1):
      ALSA: hda/realtek: Fix silent speaker on Higole F9B

YuBiao Wang (1):
      drm/amdgpu: recompute the dw estimate after allocating a new VM update job

Yuan Chen (2):
      libbpf: Skip bpf_object__probe_loading() when BPF token is in use
      bpf: Fix queue/stack map u32 index overflow

YuanZhe Liu (1):
      ALSA: line6: Clear prev_fbuf on capture buffer release

Yuanfu Xie (2):
      ceph: fail readdir when the MDS reply carries no dirfrag
      ceph: clamp MDS reply result code to the errno range

Yuanhe Shu (1):
      mm/page_alloc: do not boost watermarks in kdump capture kernels

Yuchao Zhang (2):
      xen-blkfront: unbind irq before tearing down ring and shadow requests
      md: validate bblog_size when loading v1.x badblocks metadata

Yuhang Zheng (1):
      net/sched: cls_flower: avoid stale mask references after delete

Yuho Choi (1):
      driver core: attribute_container: Unwind device_add() on attr failure

Yun Zhou (3):
      net: mvneta_bm: add suspend/resume support to prevent crash after resume
      block: reject block device inodes with i_rdev == 0 in lookup_bdev()
      ext4: set EXT4_STATE_NO_EXPAND in ext4_evict_inode

Yunhui Cui (1):
      riscv: mm: exclude invalid THP PMDs from page table check

Yunpeng Tian (1):
      smb: client: reject SetEA requests that do not fit the request buffer

Yunye Zhao (1):
      md: add cond_resched() to md_do_sync()'s skip path

Yuxiang Lin (1):
      HID: quirks: add ALWAYS_POLL quirk for AULA Mini 60 HE Pro Dongle

Yuyang Huang (1):
      net: prestera: ignore duplicate RIF destruction events

Zhan Xusheng (1):
      f2fs: fix defragment writeback range truncation on 32-bit

Zhang Heng (5):
      ALSA: hda/realtek: Fix headset mic on ASUS Vivobook S14 S5406SA
      ALSA: hda/realtek: Add quirk for Lenovo IdeaPad Slim 3 15ABR8
      ASoC: amd: yc: Add DMI entry for Alienware m18 R1 AMD
      ALSA: hda/realtek: Add quirk for Lenovo ThinkBook G8+
      ALSA: hda/realtek: Add quirk for Acer Nitro AN515-45

Zhang Yi (2):
      ext4: check return value of ext4_get_block() in ext4_load_tail_bh()
      ext4: use FGP_WRITEBEGIN for tail block zeroing

ZhangGuoDong (1):
      NFS: Verify symlink inode before caching target

Zhao Gongyi (1):
      arm64/mm: restrict transparent contpte mappings to valid PTEs

Zhao Li (2):
      wifi: mac80211_hwsim: clear PMSR request state on abort
      wifi: mt76: mt7996: unlink TWT flow if the MCU rejects the agreement

ZhaoJinming (2):
      wifi: ath11k: fix resource leak on error in ext IRQ setup
      crypto: caam - fix double-free in caam_rsa_set_priv_key_form()

Zhe Liu (1):
      docs: cgroup-v2: fix stale "io" controller introduction

Zhenhao Wan (2):
      drm/nouveau: reject zero-size notifier object allocation
      drm/nouveau/svm: drain fault handler before freeing svmm

Zhiling Zou (2):
      SUNRPC: trace an accepted transport before publishing it
      tcp: check congestion control restriction first

Zhiwei Zhang (1):
      RDMA/rxe: Check PDs for memory window binds

Zhongqiu Han (1):
      cpufreq: stats: Fix potential out-of-bounds access in deferred reset

Zi Yan (2):
      mm/rmap: don't discard lazyfree THPs at PMD level
      USB: gadgetfs: do not WARN about excessively large memory allocations

Zide Chen (1):
      perf/x86/intel/uncore: Fix PCI PMU cleanup on setup failure

Zihan Xi (2):
      net: gso: limit recursive IP-in-IP segmentation
      xsk: account ring allocations to memcg

Zijing Yin (1):
      SUNRPC: fix netns use-after-free in write_gssp()

Zikang Gao (1):
      smb: client: do not pass a NULL buf to is_oplock_break()

Zixuan Chai (1):
      ipv6: defrag: orphan skb before queuing

Zizhen Liu (1):
      net: skbuff: propagate shared-frag marker in skb_zerocopy()

Zizhi Wo (1):
      fat: reject name longer than NAME_MAX in msdos_format_name()

Zongmin Zhou (2):
      RISC-V: KVM: Fix sdata leak and stale snapshot_addr in snapshot_set_shmem
      slimbus: messaging: fix leaked PM vote on tid allocation failure

bui duc phuc (1):
      regulator: rt6245: Restore state on enable failure

fangqiurong (1):
      sched_ext: Fix exit_task leak on fork failure during enable

hanzhijian (1):
      clk: mstar: msc313-mpll: fix off-by-one in clock array allocation

liulhong617 (1):
      arm64: mm: fix accidental linear mapping of no-map reserved memory

owen kwan (1):
      net/sched: sch_teql: fix use-after-free on lower qdisc drop

renpanpan (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion 14-dv1001TU

sung byeongchan (4):
      ceph: validate fscrypt auth blob length
      ceph: bound name skips in ceph_mdsmap_decode() by the message end
      ceph: validate MDS reply fragtree split array length
      ceph: validate encoded xattr name lengths

wangdicheng (1):
      ALSA: hda/conexant: Add NULL check for dc_mode_path

yanxia (1):
      veth: fix stale peer max_mtu on XDP program replacement

イムティヤズ (1):
      wifi: rtw88: fix out-of-bounds CAM write when key table is full

이상호 (1):
      romfs: detect hard link cycles

