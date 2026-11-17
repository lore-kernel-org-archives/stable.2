Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912669;
	b=Ryv6pANwBiBK0USiqCZi+jEIfHBybyNESLmyamSYI3TdcRqgLU7bP9SabP/19Hm/enED
	 fqnr4hVz6TR2jqfLk5oWDRRNbmElOb0VFeBu22M2lv1mYfUAnTUaJyjjGpSglwzbvAC8a
	 r2hQ/j72o6yib7mAsGagedIYETK39IT84vFZBcORPEbZ80mvOyVzGPwIW9xcMuSjZPrgj
	 L9B06ibdSf884i4FPvu42d84nLVF1LnrESmi9/a1xeIE4Hj85pbz9/n95KPLvsUEo4Cwd
	 csvgHKlmlwm4KaDoJQA+vQXHBQ9xoPiPnrM14+xP7mgoBgIwKYb3ANcwqDho95b60tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912669;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/4Msve951vjMd5H2rP5Ck4iSQpX00hXSi/wTeKU0v4E=;
	b=V/HSq5nbnH+wvJ95u56dQMZN5MdpqoXEkW0JKTBxbda2teHvn12SJZ1JXj3UyH5dzDx4
	 vomg5/N02sti/DjXs3AftyzPLLCb35GtP1Hs76nIBqR99WtTdfrr/ELwN/HRyEdIZvuin
	 xT8eInNRhSZqoLFRTHlUhfMYtV0akwyo7wuhE6siIBUs36gs3b0Y6hVRWb7LF21Flz4nQ
	 SW95PIDOWziZdFjwk5r9ivL9gaDwb4xpBbhIpGS5RuxWQ0rr4VVb15uNceoINO4JyPqgY
	 WcgFxeeYFDJYhVUZXf+kaOhNouE1LnutYKklWvTAR+COsqwT1KDeh/d97rpBhnToCJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=B0+dG2BA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FFD606A323;
	Tue, 17 Nov 2026 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=B0+dG2BA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C781F000C4;
	Tue, 17 Nov 2026 10:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794912668;
	bh=/4Msve951vjMd5H2rP5Ck4iSQpX00hXSi/wTeKU0v4E=;
	h=From:To:Cc:Subject:Date;
	b=B0+dG2BAU1UohNRu9hHazqyR2qtYsklY7f2vpTC9wJLHtL3KeB805MOF/HMjCaBYE
	 yRSKXSZNxe6SzSkLFE12eXCQgCLhKj4fk0l4il71neQp3Me2XoD3qPb97kvQ47YJ7h
	 Ui5CERS7qKMLVc0g8Nj+1bSLYlfBRc5K/hnfWtaU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.118
Date: Tue, 17 Nov 2026 11:45:23 +0100
Message-ID: <2026111724-motivate-lifting-94f1@gregkh>
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

I'm announcing the release of the 6.12.118 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                    |   10 
 Documentation/filesystems/fsverity.rst                             |    3 
 Documentation/filesystems/overlayfs.rst                            |    3 
 Documentation/hwmon/coretemp.rst                                   |    3 
 Makefile                                                           |    2 
 arch/arm64/boot/dts/qcom/ipq9574.dtsi                              |    2 
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts                           |    8 
 arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi                     |  304 ++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts                             |  308 --
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi                     |    8 
 arch/arm64/include/asm/sdei.h                                      |    3 
 arch/arm64/include/asm/suspend.h                                   |    2 
 arch/arm64/kernel/entry-common.c                                   |   40 
 arch/arm64/kernel/machine_kexec_file.c                             |    2 
 arch/arm64/kernel/sdei.c                                           |   59 
 arch/arm64/kernel/topology.c                                       |   13 
 arch/arm64/kvm/arch_timer.c                                        |   16 
 arch/arm64/kvm/arm.c                                               |   17 
 arch/arm64/kvm/hyp/exception.c                                     |    5 
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h                         |   28 
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h                     |    3 
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h                             |    2 
 arch/arm64/kvm/hyp/nvhe/pkvm.c                                     |   42 
 arch/arm64/kvm/hyp/nvhe/sys_regs.c                                 |    9 
 arch/arm64/kvm/hyp/vhe/switch.c                                    |    3 
 arch/arm64/kvm/ptdump.c                                            |   50 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                 |   10 
 arch/arm64/mm/mmap.c                                               |    4 
 arch/arm64/mm/proc.S                                               |    8 
 arch/loongarch/include/asm/hw_breakpoint.h                         |    4 
 arch/loongarch/include/asm/loongarch.h                             |    3 
 arch/loongarch/include/asm/processor.h                             |    1 
 arch/loongarch/include/asm/switch_to.h                             |    2 
 arch/loongarch/kernel/hw_breakpoint.c                              |   39 
 arch/loongarch/kernel/numa.c                                       |    8 
 arch/m68k/68000/entry.S                                            |   24 
 arch/m68k/coldfire/entry.S                                         |    3 
 arch/microblaze/include/asm/entry.h                                |   13 
 arch/microblaze/include/asm/processor.h                            |    2 
 arch/microblaze/kernel/entry.S                                     |  329 +-
 arch/microblaze/kernel/hw_exception_handler.S                      |    5 
 arch/microblaze/kernel/process.c                                   |    5 
 arch/mips/crypto/Kconfig                                           |    6 
 arch/mips/mm/cex-gen.S                                             |   16 
 arch/mips/pci/ops-mace.c                                           |   26 
 arch/mips/pci/pci-ip32.c                                           |    9 
 arch/mips/sgi-ip32/ip32-irq.c                                      |   45 
 arch/openrisc/kernel/or32_ksyms.c                                  |    1 
 arch/powerpc/net/bpf_jit.h                                         |    7 
 arch/powerpc/net/bpf_jit_comp.c                                    |   35 
 arch/powerpc/platforms/pseries/iommu.c                             |   67 
 arch/s390/pci/pci_irq.c                                            |   26 
 arch/x86/include/asm/cpufeatures.h                                 |    5 
 arch/x86/include/asm/kvm-x86-ops.h                                 |    1 
 arch/x86/include/asm/kvm_host.h                                    |    7 
 arch/x86/include/asm/vmware.h                                      |   24 
 arch/x86/include/asm/xor_avx.h                                     |    4 
 arch/x86/kernel/acpi/cppc.c                                        |   15 
 arch/x86/kernel/cpu/amd.c                                          |    6 
 arch/x86/kernel/nmi.c                                              |    8 
 arch/x86/kernel/x86_init.c                                         |    2 
 arch/x86/kvm/mmu/mmu.c                                             |   10 
 arch/x86/kvm/mmu/paging_tmpl.h                                     |   11 
 arch/x86/kvm/svm/nested.c                                          |    1 
 arch/x86/kvm/vmx/main.c                                            |    1 
 arch/x86/kvm/vmx/nested.c                                          |    1 
 arch/x86/kvm/vmx/vmx.c                                             |    2 
 arch/x86/kvm/vmx/x86_ops.h                                         |    1 
 arch/x86/kvm/x86.c                                                 |   44 
 arch/x86/mm/mem_encrypt_identity.c                                 |    2 
 block/blk-iocost.c                                                 |    3 
 block/blk-mq.c                                                     |   10 
 block/bsg.c                                                        |    5 
 block/ioctl.c                                                      |    4 
 crypto/ecc.c                                                       |   33 
 crypto/testmgr.c                                                   |   10 
 crypto/testmgr.h                                                   |  339 +++
 drivers/acpi/apei/ghes.c                                           |    6 
 drivers/acpi/cppc_acpi.c                                           |   58 
 drivers/acpi/riscv/cppc.c                                          |   26 
 drivers/ata/Kconfig                                                |    7 
 drivers/ata/Makefile                                               |    1 
 drivers/ata/ahci.c                                                 |    6 
 drivers/ata/ahci_da850.c                                           |    6 
 drivers/ata/ahci_dm816.c                                           |    2 
 drivers/ata/ahci_imx.c                                             |   13 
 drivers/ata/ahci_qoriq.c                                           |    4 
 drivers/ata/ahci_xgene.c                                           |    8 
 drivers/ata/ata_piix.c                                             |    4 
 drivers/ata/libahci.c                                              |   10 
 drivers/ata/libata-core.c                                          |    4 
 drivers/ata/libata-eh.c                                            |   80 
 drivers/ata/libata-pmp.c                                           |   40 
 drivers/ata/libata-sata.c                                          |    2 
 drivers/ata/libata-scsi.c                                          |   25 
 drivers/ata/libata-sff.c                                           |   18 
 drivers/ata/libata.h                                               |   11 
 drivers/ata/pata_acpi.c                                            |    2 
 drivers/ata/pata_ali.c                                             |   10 
 drivers/ata/pata_amd.c                                             |    4 
 drivers/ata/pata_artop.c                                           |    4 
 drivers/ata/pata_atiixp.c                                          |    2 
 drivers/ata/pata_efar.c                                            |    2 
 drivers/ata/pata_ep93xx.c                                          |    4 
 drivers/ata/pata_hpt366.c                                          |    2 
 drivers/ata/pata_hpt37x.c                                          |    4 
 drivers/ata/pata_hpt3x2n.c                                         |    2 
 drivers/ata/pata_icside.c                                          |    2 
 drivers/ata/pata_it8213.c                                          |    2 
 drivers/ata/pata_jmicron.c                                         |    2 
 drivers/ata/pata_marvell.c                                         |    2 
 drivers/ata/pata_mpiix.c                                           |    2 
 drivers/ata/pata_ns87410.c                                         |    2 
 drivers/ata/pata_octeon_cf.c                                       |    2 
 drivers/ata/pata_oldpiix.c                                         |    2 
 drivers/ata/pata_opti.c                                            |    2 
 drivers/ata/pata_optidma.c                                         |    2 
 drivers/ata/pata_parport/pata_parport.c                            |    4 
 drivers/ata/pata_pdc2027x.c                                        |    2 
 drivers/ata/pata_rdc.c                                             |    2 
 drivers/ata/pata_sis.c                                             |    2 
 drivers/ata/pata_sl82c105.c                                        |    2 
 drivers/ata/pata_triflex.c                                         |    2 
 drivers/ata/pata_via.c                                             |    2 
 drivers/ata/pdc_adma.c                                             |    2 
 drivers/ata/sata_dwc_460ex.c                                       |    2 
 drivers/ata/sata_fsl.c                                             |    6 
 drivers/ata/sata_highbank.c                                        |    2 
 drivers/ata/sata_inic162x.c                                        |  902 --------
 drivers/ata/sata_mv.c                                              |   10 
 drivers/ata/sata_nv.c                                              |    2 
 drivers/ata/sata_promise.c                                         |    4 
 drivers/ata/sata_qstor.c                                           |    4 
 drivers/ata/sata_rcar.c                                            |    2 
 drivers/ata/sata_sil24.c                                           |    8 
 drivers/ata/sata_svw.c                                             |    4 
 drivers/ata/sata_sx4.c                                             |    2 
 drivers/ata/sata_uli.c                                             |    2 
 drivers/ata/sata_via.c                                             |    4 
 drivers/block/amiflop.c                                            |   69 
 drivers/block/ublk_drv.c                                           |   17 
 drivers/char/hw_random/virtio-rng.c                                |    7 
 drivers/char/tpm/tpm2-cmd.c                                        |    3 
 drivers/clk/nuvoton/clk-ma35d1.c                                   |    7 
 drivers/cpufreq/amd-pstate.c                                       |   23 
 drivers/crypto/omap-aes.c                                          |   15 
 drivers/crypto/omap-aes.h                                          |    2 
 drivers/crypto/omap-des.c                                          |   19 
 drivers/crypto/omap-sham.c                                         |   43 
 drivers/dma/qcom/bam_dma.c                                         |   10 
 drivers/firmware/efi/libstub/Makefile                              |    2 
 drivers/gpio/gpio-pca953x.c                                        |    7 
 drivers/gpio/gpiolib-cdev.c                                        |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                         |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                   |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                             |   50 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                         |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                            |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c                           |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c                        |    1 
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c                             |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c                              |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c                              |    5 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                             |    2 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                              |   46 
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c                               |   13 
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                             |    4 
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c                             |    4 
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c                             |   41 
 drivers/gpu/drm/amd/amdgpu/si.c                                    |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                            |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c                             |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                               |   20 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c     |    3 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c |    6 
 drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c             |    7 
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c     |   15 
 drivers/gpu/drm/amd/include/kgd_pp_interface.h                     |    2 
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                                |  143 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h                            |    1 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                   |   33 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                          |   87 
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h                      |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c               |   34 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c               |   31 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c               |   38 
 drivers/gpu/drm/bridge/nwl-dsi.c                                   |   17 
 drivers/gpu/drm/drm_crtc.c                                         |   15 
 drivers/gpu/drm/drm_panel.c                                        |   25 
 drivers/gpu/drm/drm_panic.c                                        |   10 
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c                           |   40 
 drivers/gpu/drm/i915/display/intel_psr.c                           |   20 
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c                     |    2 
 drivers/gpu/drm/loongson/lsdc_gem.c                                |   12 
 drivers/gpu/drm/loongson/lsdc_plane.c                              |    2 
 drivers/gpu/drm/loongson/lsdc_ttm.c                                |   14 
 drivers/gpu/drm/loongson/lsdc_ttm.h                                |    2 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                 |    2 
 drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h                  |    1 
 drivers/gpu/drm/nouveau/nvkm/core/subdev.c                         |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c                  |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c                |   20 
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild                     |    1 
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c                    |   36 
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c                          |   11 
 drivers/gpu/drm/v3d/v3d_sched.c                                    |    2 
 drivers/gpu/drm/vc4/vc4_gem.c                                      |   10 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                     |   10 
 drivers/hte/hte-tegra194-test.c                                    |    2 
 drivers/hwmon/acpi_power_meter.c                                   |   10 
 drivers/hwmon/aquacomputer_d5next.c                                |   58 
 drivers/hwmon/asus_wmi_sensors.c                                   |   13 
 drivers/hwmon/chipcap2.c                                           |   53 
 drivers/hwmon/coretemp.c                                           |   27 
 drivers/hwmon/corsair-cpro.c                                       |    3 
 drivers/hwmon/hp-wmi-sensors.c                                     |   29 
 drivers/hwmon/lm70.c                                               |    8 
 drivers/hwmon/lm87.c                                               |    7 
 drivers/hwmon/nct6683.c                                            |    4 
 drivers/hwmon/nct6775-platform.c                                   |   24 
 drivers/hwmon/peci/dimmtemp.c                                      |   21 
 drivers/hwmon/pmbus/pmbus_core.c                                   |   51 
 drivers/hwmon/pmbus/q54sj108a2.c                                   |    2 
 drivers/hwmon/tmp102.c                                             |    8 
 drivers/hwmon/tmp108.c                                             |    8 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                 |    3 
 drivers/iio/adc/ad7192.c                                           |    2 
 drivers/iio/adc/ti-ads1100.c                                       |  121 +
 drivers/iio/dac/mcp4821.c                                          |    7 
 drivers/iio/light/isl29028.c                                       |   23 
 drivers/iio/light/ltr501.c                                         |    2 
 drivers/iio/pressure/dps310.c                                      |    6 
 drivers/infiniband/hw/hfi1/chip.c                                  |    4 
 drivers/input/input.c                                              |    4 
 drivers/input/joystick/xpad.c                                      |    1 
 drivers/iommu/amd/init.c                                           |   37 
 drivers/iommu/iommufd/io_pagetable.c                               |    2 
 drivers/iommu/iommufd/iova_bitmap.c                                |   19 
 drivers/iommu/virtio-iommu.c                                       |    6 
 drivers/irqchip/irq-atmel-aic.c                                    |    5 
 drivers/irqchip/irq-atmel-aic5.c                                   |    5 
 drivers/mailbox/mailbox-altera.c                                   |    2 
 drivers/md/dm-bufio.c                                              |   41 
 drivers/media/common/cypress_firmware.c                            |    2 
 drivers/media/i2c/adv748x/adv748x-core.c                           |   13 
 drivers/media/i2c/og01a1b.c                                        |   95 
 drivers/media/i2c/ov5647.c                                         |    4 
 drivers/media/pci/intel/ipu6/ipu6-fw-isys.c                        |   29 
 drivers/media/platform/chips-media/wave5/wave5-vpu.c               |    7 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c               |    4 
 drivers/media/platform/microchip/microchip-isc-base.c              |   20 
 drivers/media/platform/microchip/microchip-isc-regs.h              |   16 
 drivers/media/platform/microchip/microchip-isc.h                   |    4 
 drivers/media/platform/microchip/microchip-sama5d2-isc.c           |   20 
 drivers/media/platform/microchip/microchip-sama7g5-isc.c           |   20 
 drivers/media/platform/qcom/camss/camss-vfe-17x.c                  |  153 -
 drivers/media/platform/qcom/camss/camss-vfe-4-1.c                  |    9 
 drivers/media/platform/qcom/camss/camss-vfe-4-7.c                  |   11 
 drivers/media/platform/qcom/camss/camss-vfe-4-8.c                  |   11 
 drivers/media/platform/qcom/camss/camss-vfe-480.c                  |  274 --
 drivers/media/platform/qcom/camss/camss-vfe.c                      |  268 ++
 drivers/media/platform/qcom/camss/camss-vfe.h                      |   58 
 drivers/media/platform/rockchip/rga/rga.c                          |   69 
 drivers/media/platform/rockchip/rga/rga.h                          |    7 
 drivers/media/rc/ene_ir.c                                          |    4 
 drivers/media/rc/redrat3.c                                         |   11 
 drivers/media/rc/serial_ir.c                                       |    2 
 drivers/media/usb/dvb-usb/dvb-usb-firmware.c                       |    2 
 drivers/media/usb/uvc/uvc_driver.c                                 |   20 
 drivers/mfd/ab8500-core.c                                          |   44 
 drivers/mfd/twl-core.c                                             |   25 
 drivers/misc/fastrpc.c                                             |   81 
 drivers/mtd/nand/raw/Kconfig                                       |    3 
 drivers/mtd/nand/raw/ndfc.c                                        |   41 
 drivers/net/can/dev/netlink.c                                      |    4 
 drivers/net/can/dev/skb.c                                          |    1 
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c                         |    7 
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c                    |   33 
 drivers/net/ethernet/broadcom/bgmac.c                              |   10 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                      |   54 
 drivers/net/ethernet/broadcom/tg3.c                                |   42 
 drivers/net/ethernet/jme.c                                         |   37 
 drivers/net/ethernet/jme.h                                         |    1 
 drivers/net/ethernet/mellanox/mlxsw/core.c                         |    4 
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c                   |    4 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c                |    2 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                           |    4 
 drivers/net/hamradio/6pack.c                                       |    6 
 drivers/net/hamradio/bpqether.c                                    |    8 
 drivers/net/hamradio/mkiss.c                                       |   70 
 drivers/net/ppp/pppoe.c                                            |   22 
 drivers/net/veth.c                                                 |    5 
 drivers/net/vxlan/vxlan_core.c                                     |   14 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c        |    7 
 drivers/net/wireless/mediatek/mt76/mac80211.c                      |   14 
 drivers/net/wireless/mediatek/mt76/mt76.h                          |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                   |    1 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                   |    2 
 drivers/net/wireless/mediatek/mt76/mt792x_core.c                   |   12 
 drivers/net/wireless/realtek/rtw88/mac80211.c                      |    2 
 drivers/net/wireless/realtek/rtw88/reg.h                           |    2 
 drivers/net/wireless/realtek/rtw88/tx.c                            |    9 
 drivers/net/wireless/realtek/rtw88/tx.h                            |    3 
 drivers/net/wireless/realtek/rtw88/usb.c                           |   68 
 drivers/net/wireless/realtek/rtw88/usb.h                           |    5 
 drivers/net/wireless/rsi/rsi_91x_core.c                            |    2 
 drivers/nvme/common/keyring.c                                      |    1 
 drivers/nvme/host/core.c                                           |    3 
 drivers/nvme/host/pci.c                                            |    2 
 drivers/nvme/host/tcp.c                                            |  207 +
 drivers/nvme/target/admin-cmd.c                                    |    9 
 drivers/nvme/target/configfs.c                                     |    4 
 drivers/nvme/target/rdma.c                                         |    3 
 drivers/nvmem/rockchip-otp.c                                       |   24 
 drivers/pci/controller/cadence/pcie-cadence-plat.c                 |   33 
 drivers/pci/controller/dwc/pcie-designware.c                       |    2 
 drivers/pci/controller/dwc/pcie-designware.h                       |    1 
 drivers/pci/controller/dwc/pcie-rcar-gen4.c                        |   54 
 drivers/pci/controller/pcie-rockchip.c                             |   14 
 drivers/pci/controller/pcie-rockchip.h                             |    3 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                      |   69 
 drivers/pci/pci.c                                                  |   36 
 drivers/pci/quirks.c                                               |    8 
 drivers/platform/x86/amd/pmf/core.c                                |    1 
 drivers/platform/x86/asus-wmi.c                                    |   30 
 drivers/platform/x86/intel/int3472/discrete.c                      |   18 
 drivers/power/supply/Makefile                                      |    2 
 drivers/power/supply/bq27xxx_battery.c                             |   24 
 drivers/power/supply/cros_charge-control.c                         |   29 
 drivers/power/supply/ltc2941-battery-gauge.c                       |    6 
 drivers/power/supply/mt6370-charger.c                              |   11 
 drivers/power/supply/power_supply_core.c                           |  166 -
 drivers/power/supply/qcom_battmgr.c                                |   26 
 drivers/power/supply/qcom_pmi8998_charger.c                        | 1053 ---------
 drivers/power/supply/qcom_smbx.c                                   | 1108 ++++++++++
 drivers/power/supply/rt9467-charger.c                              |   33 
 drivers/ptp/ptp_sysfs.c                                            |    6 
 drivers/s390/char/vmcp.c                                           |    4 
 drivers/scsi/aic7xxx/aic79xx_core.c                                |    4 
 drivers/scsi/aic7xxx/aic79xx_osm.h                                 |   26 
 drivers/scsi/aic7xxx/aic7xxx_core.c                                |    8 
 drivers/scsi/aic7xxx/aic7xxx_pci.c                                 |   20 
 drivers/scsi/libsas/sas_ata.c                                      |    4 
 drivers/scsi/scsi_bsg.c                                            |    6 
 drivers/scsi/scsi_ioctl.c                                          |   11 
 drivers/soc/qcom/pmic_glink_altmode.c                              |    4 
 drivers/spi/spi-cadence-xspi.c                                     |  522 ++--
 drivers/target/target_core_fabric_lib.c                            |   10 
 drivers/target/target_core_user.c                                  |    5 
 drivers/tty/serial/amba-pl011.c                                    |   15 
 drivers/tty/serial/sc16is7xx.c                                     |   14 
 drivers/ufs/core/ufs_bsg.c                                         |   13 
 drivers/ufs/core/ufshcd.c                                          |   48 
 drivers/usb/core/config.c                                          |   32 
 drivers/usb/core/quirks.c                                          |    7 
 drivers/usb/host/xhci-ring.c                                       |    9 
 drivers/usb/typec/ucsi/ucsi_ccg.c                                  |   21 
 drivers/vdpa/solidrun/snet_ctrl.c                                  |    3 
 drivers/vdpa/vdpa_user/iova_domain.c                               |   11 
 drivers/vhost/vdpa.c                                               |    8 
 drivers/vhost/vringh.c                                             |   27 
 drivers/vhost/vsock.c                                              |   34 
 drivers/video/fbdev/core/fb_info.c                                 |    1 
 drivers/video/fbdev/core/fbcon_rotate.c                            |    3 
 drivers/video/fbdev/nvidia/nvidia.c                                |   20 
 drivers/watchdog/hpwdt.c                                           |   24 
 drivers/xen/gntdev-dmabuf.c                                        |    4 
 fs/9p/v9fs.c                                                       |   16 
 fs/9p/vfs_inode.c                                                  |    8 
 fs/afs/rxrpc.c                                                     |   49 
 fs/backing-file.c                                                  |    5 
 fs/btrfs/sysfs.c                                                   |    1 
 fs/ceph/addr.c                                                     |    6 
 fs/ceph/crypto.c                                                   |    8 
 fs/dax.c                                                           |    2 
 fs/erofs/zdata.c                                                   |   11 
 fs/exfat/file.c                                                    |   18 
 fs/ext2/file.c                                                     |    3 
 fs/ext2/inode.c                                                    |   13 
 fs/f2fs/checkpoint.c                                               |    9 
 fs/f2fs/data.c                                                     |   20 
 fs/f2fs/file.c                                                     |    2 
 fs/f2fs/node.c                                                     |   55 
 fs/f2fs/segment.c                                                  |    3 
 fs/f2fs/super.c                                                    |   24 
 fs/fat/inode.c                                                     |    2 
 fs/fs-writeback.c                                                  |    8 
 fs/fuse/file.c                                                     |   12 
 fs/fuse/virtio_fs.c                                                |   59 
 fs/gfs2/glops.c                                                    |   10 
 fs/inode.c                                                         |   15 
 fs/iomap/buffered-io.c                                             |    3 
 fs/iomap/direct-io.c                                               |   15 
 fs/nfs/callback_xdr.c                                              |    7 
 fs/nfs/filelayout/filelayoutdev.c                                  |   17 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                          |   17 
 fs/nfs/pnfs.h                                                      |    1 
 fs/nfs/pnfs_nfs.c                                                  |   21 
 fs/nfsd/blocklayout.c                                              |    4 
 fs/nfsd/flexfilelayout.c                                           |   24 
 fs/nfsd/flexfilelayoutxdr.c                                        |    4 
 fs/nfsd/flexfilelayoutxdr.h                                        |    5 
 fs/nfsd/nfs2acl.c                                                  |   18 
 fs/nfsd/nfs4callback.c                                             |    2 
 fs/nfsd/nfs4layouts.c                                              |   14 
 fs/nfsd/nfs4proc.c                                                 |    4 
 fs/nfsd/nfs4recover.c                                              |   49 
 fs/nfsd/nfs4state.c                                                |   53 
 fs/nfsd/nfsctl.c                                                   |   56 
 fs/nfsd/pnfs.h                                                     |    4 
 fs/nfsd/state.h                                                    |   13 
 fs/nilfs2/dir.c                                                    |    2 
 fs/nilfs2/gcinode.c                                                |   24 
 fs/nilfs2/inode.c                                                  |   49 
 fs/nilfs2/ioctl.c                                                  |    2 
 fs/nilfs2/mdt.c                                                    |    6 
 fs/nilfs2/page.c                                                   |   54 
 fs/nilfs2/page.h                                                   |    8 
 fs/nilfs2/recovery.c                                               |   32 
 fs/nilfs2/segbuf.c                                                 |   12 
 fs/nilfs2/segment.c                                                |   54 
 fs/nilfs2/the_nilfs.c                                              |   12 
 fs/notify/inotify/inotify_fsnotify.c                               |    2 
 fs/ntfs3/xattr.c                                                   |   25 
 fs/ocfs2/alloc.c                                                   |   18 
 fs/ocfs2/cluster/tcp.c                                             |    5 
 fs/ocfs2/dcache.h                                                  |    5 
 fs/ocfs2/dlm/dlmmaster.c                                           |   70 
 fs/ocfs2/dlmglue.c                                                 |   34 
 fs/ocfs2/filecheck.c                                               |    2 
 fs/ocfs2/inode.c                                                   |   37 
 fs/ocfs2/journal.c                                                 |   15 
 fs/ocfs2/journal.h                                                 |    1 
 fs/ocfs2/super.c                                                   |    3 
 fs/ocfs2/xattr.c                                                   |  120 -
 fs/overlayfs/export.c                                              |    4 
 fs/overlayfs/namei.c                                               |   13 
 fs/overlayfs/overlayfs.h                                           |    2 
 fs/proc/task_mmu.c                                                 |    2 
 fs/smb/client/cifsglob.h                                           |    2 
 fs/smb/client/cifssmb.c                                            |   59 
 fs/smb/client/connect.c                                            |   33 
 fs/smb/client/inode.c                                              |    4 
 fs/smb/client/readdir.c                                            |   66 
 fs/smb/client/smb2misc.c                                           |   15 
 fs/smb/client/smb2pdu.c                                            |   41 
 fs/smb/server/smb2pdu.c                                            |   28 
 fs/smb/server/smbacl.c                                             |    5 
 fs/smb/server/vfs.c                                                |    4 
 fs/smb/server/vfs.h                                                |    2 
 fs/udf/balloc.c                                                    |   11 
 fs/udf/inode.c                                                     |   42 
 fs/udf/super.c                                                     |   80 
 fs/udf/truncate.c                                                  |    7 
 fs/verity/enable.c                                                 |    8 
 fs/verity/fsverity_private.h                                       |    8 
 fs/verity/measure.c                                                |   10 
 fs/verity/open.c                                                   |    9 
 fs/verity/read_metadata.c                                          |   14 
 fs/verity/signature.c                                              |   55 
 fs/xfs/libxfs/xfs_attr_leaf.c                                      |    9 
 fs/xfs/libxfs/xfs_btree.c                                          |    4 
 fs/xfs/scrub/attr.c                                                |  102 
 fs/xfs/scrub/attr_repair.c                                         |   16 
 fs/xfs/scrub/cow_repair.c                                          |   66 
 fs/xfs/scrub/dir.c                                                 |  110 
 fs/xfs/scrub/dir_repair.c                                          |  100 
 fs/xfs/scrub/dirtree.c                                             |    4 
 fs/xfs/scrub/fscounters.c                                          |   24 
 fs/xfs/scrub/inode_repair.c                                        |  132 +
 fs/xfs/scrub/newbt.c                                               |    2 
 fs/xfs/scrub/quota_repair.c                                        |   33 
 fs/xfs/scrub/reap.c                                                |    4 
 fs/xfs/scrub/rtsummary.c                                           |    9 
 fs/xfs/scrub/rtsummary.h                                           |    1 
 fs/xfs/scrub/rtsummary_repair.c                                    |    2 
 fs/xfs/scrub/xfarray.c                                             |   22 
 fs/xfs/xfs_discard.c                                               |   26 
 fs/xfs/xfs_ioctl32.c                                               |    4 
 fs/xfs/xfs_iomap.c                                                 |    8 
 fs/xfs/xfs_pnfs.c                                                  |   43 
 include/acpi/cppc_acpi.h                                           |    6 
 include/asm-generic/tlb.h                                          |    3 
 include/drm/drm_panel.h                                            |   22 
 include/dt-bindings/clock/nuvoton,ma35d1-clk.h                     |    3 
 include/kvm/arm_arch_timer.h                                       |   15 
 include/linux/assoc_array_priv.h                                   |    2 
 include/linux/bio.h                                                |   15 
 include/linux/bitfield.h                                           |   21 
 include/linux/can/can-ml.h                                         |    3 
 include/linux/damon.h                                              |    6 
 include/linux/hugetlb.h                                            |   22 
 include/linux/libata.h                                             |   26 
 include/linux/memcontrol.h                                         |   10 
 include/linux/memfd.h                                              |    9 
 include/linux/mm.h                                                 |    6 
 include/linux/mmu_notifier.h                                       |    3 
 include/linux/panic.h                                              |    6 
 include/linux/pci.h                                                |    2 
 include/linux/power_supply.h                                       |    4 
 include/linux/srcu.h                                               |   36 
 include/linux/sunrpc/clnt.h                                        |    3 
 include/linux/sunrpc/svc.h                                         |    7 
 include/linux/usb/quirks.h                                         |    3 
 include/net/espintcp.h                                             |    5 
 include/net/ip.h                                                   |   25 
 include/net/ip6_route.h                                            |   37 
 include/net/netns/can.h                                            |    2 
 include/net/netrom.h                                               |   15 
 include/net/rose.h                                                 |    3 
 include/net/sctp/sm.h                                              |    1 
 include/sound/hwdep.h                                              |    1 
 include/trace/events/rxrpc.h                                       |    2 
 include/uapi/linux/iommufd.h                                       |    6 
 io_uring/cancel.c                                                  |    3 
 io_uring/io_uring.c                                                |   23 
 io_uring/poll.c                                                    |   77 
 io_uring/rsrc.c                                                    |   21 
 io_uring/sqpoll.c                                                  |   26 
 kernel/events/core.c                                               |    9 
 kernel/irq/internals.h                                             |    1 
 kernel/irq/kexec.c                                                 |    2 
 kernel/irq/manage.c                                                |   49 
 kernel/panic.c                                                     |   41 
 kernel/sched/ext.c                                                 |   14 
 kernel/time/posix-stubs.c                                          |    4 
 kernel/time/posix-timers.c                                         |   22 
 kernel/time/tick-sched.c                                           |   14 
 kernel/trace/trace_events_hist.c                                   |    3 
 lib/assoc_array.c                                                  |  355 +--
 lib/cmdline.c                                                      |   13 
 lib/cmdline_kunit.c                                                |  101 
 lib/raid6/avx2.c                                                   |    6 
 lib/raid6/avx512.c                                                 |    6 
 lib/raid6/recov_avx2.c                                             |    2 
 lib/raid6/recov_avx512.c                                           |    2 
 lib/stackdepot.c                                                   |    2 
 mm/damon/core.c                                                    |   64 
 mm/damon/paddr.c                                                   |    6 
 mm/damon/tests/core-kunit.h                                        |   11 
 mm/filemap.c                                                       |   55 
 mm/gup.c                                                           |   36 
 mm/huge_memory.c                                                   |   70 
 mm/hugetlb.c                                                       |  117 -
 mm/khugepaged.c                                                    |   10 
 mm/ksm.c                                                           |   10 
 mm/madvise.c                                                       |    9 
 mm/memcontrol.c                                                    |   84 
 mm/memfd.c                                                         |    2 
 mm/memory.c                                                        |   45 
 mm/mempolicy.c                                                     |   15 
 mm/migrate.c                                                       |    5 
 mm/mm_init.c                                                       |    2 
 mm/mmap.c                                                          |   11 
 mm/mmu_notifier.c                                                  |   24 
 mm/mremap.c                                                        |   15 
 mm/page-writeback.c                                                |   12 
 mm/page_alloc.c                                                    |   25 
 mm/page_counter.c                                                  |   21 
 mm/page_isolation.c                                                |   40 
 mm/page_owner.c                                                    |    2 
 mm/page_table_check.c                                              |    6 
 mm/page_vma_mapped.c                                               |   22 
 mm/shmem.c                                                         |   87 
 mm/shmem_quota.c                                                   |   28 
 mm/swapfile.c                                                      |    4 
 mm/userfaultfd.c                                                   |   11 
 mm/vma.c                                                           |    5 
 mm/vmscan.c                                                        |   16 
 mm/zswap.c                                                         |    2 
 net/9p/trans_usbg.c                                                |   89 
 net/9p/trans_virtio.c                                              |    5 
 net/9p/trans_xen.c                                                 |   10 
 net/ax25/af_ax25.c                                                 |  123 -
 net/ax25/ax25_ds_timer.c                                           |    2 
 net/ax25/ax25_in.c                                                 |   56 
 net/ax25/ax25_ip.c                                                 |    9 
 net/ax25/ax25_out.c                                                |   17 
 net/ax25/ax25_std_timer.c                                          |    2 
 net/ax25/sysctl_net_ax25.c                                         |    2 
 net/batman-adv/bat_iv_ogm.c                                        |    9 
 net/batman-adv/distributed-arp-table.c                             |    1 
 net/batman-adv/main.c                                              |   12 
 net/batman-adv/main.h                                              |    3 
 net/batman-adv/multicast_forw.c                                    |    5 
 net/batman-adv/tp_meter.c                                          |    2 
 net/batman-adv/translation-table.c                                 |  145 -
 net/batman-adv/types.h                                             |    8 
 net/bluetooth/hci_sync.c                                           |   25 
 net/bluetooth/l2cap_core.c                                         |   47 
 net/bluetooth/selftest.c                                           |    1 
 net/bluetooth/smp.c                                                |    1 
 net/can/af_can.c                                                   |   51 
 net/can/bcm.c                                                      |   50 
 net/can/gw.c                                                       |    7 
 net/can/isotp.c                                                    |  230 +-
 net/can/proc.c                                                     |   69 
 net/can/raw.c                                                      |  132 -
 net/core/dev.c                                                     |   10 
 net/core/filter.c                                                  |   23 
 net/core/sock.c                                                    |    6 
 net/ipv4/cipso_ipv4.c                                              |    9 
 net/ipv4/inet_connection_sock.c                                    |    6 
 net/ipv4/inet_hashtables.c                                         |    2 
 net/ipv4/inet_timewait_sock.c                                      |    4 
 net/ipv4/ip_gre.c                                                  |    1 
 net/ipv4/ipmr.c                                                    |   31 
 net/ipv4/route.c                                                   |    4 
 net/ipv4/syncookies.c                                              |    2 
 net/ipv4/tcp_fastopen.c                                            |    2 
 net/ipv6/addrconf.c                                                |    3 
 net/ipv6/datagram.c                                                |    4 
 net/ipv6/inet6_hashtables.c                                        |    2 
 net/ipv6/ip6_gre.c                                                 |    1 
 net/ipv6/ip6mr.c                                                   |    5 
 net/ipv6/raw.c                                                     |    3 
 net/ipv6/route.c                                                   |    2 
 net/l2tp/l2tp_core.c                                               |   13 
 net/mac80211/tdls.c                                                |    3 
 net/mac80211/tx.c                                                  |   57 
 net/mptcp/pm_kernel.c                                              |    1 
 net/mptcp/protocol.c                                               |   31 
 net/mptcp/protocol.h                                               |   10 
 net/mptcp/subflow.c                                                |   17 
 net/mptcp/token.c                                                  |   68 
 net/mptcp/token_test.c                                             |    4 
 net/netrom/af_netrom.c                                             |  109 
 net/netrom/nr_in.c                                                 |   46 
 net/netrom/nr_out.c                                                |   23 
 net/netrom/nr_route.c                                              |  100 
 net/rds/recv.c                                                     |    6 
 net/rose/af_rose.c                                                 |  124 -
 net/rose/rose_in.c                                                 |   11 
 net/rose/rose_link.c                                               |   85 
 net/rose/rose_loopback.c                                           |    1 
 net/rose/rose_route.c                                              |   67 
 net/rose/sysctl_net_rose.c                                         |   13 
 net/rxrpc/sendmsg.c                                                |   59 
 net/sched/sch_generic.c                                            |   41 
 net/sched/sch_qfq.c                                                |    3 
 net/sched/sch_taprio.c                                             |    5 
 net/sctp/sm_make_chunk.c                                           |   14 
 net/sctp/socket.c                                                  |   57 
 net/smc/smc_rx.c                                                   |   39 
 net/sunrpc/rpcb_clnt.c                                             |   22 
 net/sunrpc/svc.c                                                   |   42 
 net/wireless/reg.c                                                 |    3 
 net/xfrm/espintcp.c                                                |   43 
 net/xfrm/xfrm_interface_core.c                                     |    8 
 net/xfrm/xfrm_policy.c                                             |   11 
 security/apparmor/policy_unpack.c                                  |   19 
 sound/core/compress_offload.c                                      |   18 
 sound/core/control.c                                               |   19 
 sound/core/hwdep.c                                                 |   25 
 sound/core/init.c                                                  |   23 
 sound/core/jack.c                                                  |   38 
 sound/core/oss/mixer_oss.c                                         |   13 
 sound/core/oss/pcm_oss.c                                           |   21 
 sound/core/pcm_native.c                                            |   44 
 sound/core/rawmidi.c                                               |   16 
 sound/core/seq/oss/seq_oss.c                                       |   21 
 sound/core/seq/seq_clientmgr.c                                     |   19 
 sound/core/sound.c                                                 |    9 
 sound/core/timer.c                                                 |   26 
 sound/core/timer_compat.c                                          |    1 
 sound/core/ump_convert.c                                           |    2 
 sound/drivers/aloop.c                                              |  103 
 sound/drivers/mpu401/mpu401_uart.c                                 |    8 
 sound/pci/cs46xx/dsp_spos.c                                        |    2 
 sound/pci/cs46xx/dsp_spos_scb_lib.c                                |    3 
 sound/pci/hda/cs35l41_hda.c                                        |   22 
 sound/pci/hda/hda_eld.c                                            |    6 
 sound/pci/hda/patch_hdmi.c                                         |    3 
 sound/pci/hda/patch_realtek.c                                      |   10 
 sound/soc/amd/acp-config.c                                         |   43 
 sound/soc/amd/yc/acp6x-mach.c                                      |    7 
 sound/soc/codecs/hdac_hda.c                                        |   25 
 sound/soc/qcom/qdsp6/q6apm-dai.c                                   |   12 
 sound/soc/qcom/qdsp6/q6apm.c                                       |    6 
 sound/soc/qcom/qdsp6/q6prm.c                                       |    3 
 sound/soc/sof/intel/hda-codec.c                                    |   23 
 sound/soc/stm/stm32_i2s.c                                          |   27 
 sound/synth/emux/emux_effect.c                                     |   29 
 sound/synth/emux/emux_synth.c                                      |   57 
 sound/synth/emux/soundfont.c                                       |   70 
 sound/usb/bcd2000/bcd2000.c                                        |   20 
 sound/usb/caiaq/input.c                                            |    2 
 sound/usb/line6/capture.c                                          |   58 
 sound/usb/line6/capture.h                                          |    2 
 sound/usb/line6/driver.c                                           |   31 
 sound/usb/line6/midi.c                                             |   10 
 sound/usb/line6/pcm.c                                              |   27 
 sound/usb/line6/playback.c                                         |   31 
 sound/usb/midi.c                                                   |   22 
 sound/usb/mixer.c                                                  |    8 
 sound/usb/mixer_quirks.c                                           |    7 
 sound/usb/pcm.c                                                    |   20 
 sound/usb/quirks.c                                                 |   24 
 sound/usb/usbaudio.h                                               |    4 
 sound/usb/usx2y/us122l.c                                           |   27 
 sound/usb/usx2y/usX2Yhwdep.c                                       |    5 
 sound/usb/usx2y/usb_stream.c                                       |    9 
 sound/usb/usx2y/usbusx2yaudio.c                                    |   43 
 sound/x86/intel_hdmi_audio.c                                       |    9 
 tools/arch/x86/include/asm/cpufeatures.h                           |    5 
 tools/testing/selftests/net/fib_nexthops.sh                        |   40 
 tools/testing/vma/vma_internal.h                                   |    2 
 virt/kvm/guest_memfd.c                                             |  107 
 virt/kvm/kvm_main.c                                                |   45 
 virt/kvm/kvm_mm.h                                                  |   18 
 710 files changed, 12035 insertions(+), 7213 deletions(-)

Abdifatah Suruur (2):
      smb: client: validate the data area in SMB2_read()
      smb: client: reject short SESSION_SETUP responses

Abel Vesa (1):
      soc: qcom: pmic_glink: Fix device access from worker during suspend

Abhishek Dubey (1):
      powerpc/bpf: fix buffer overflow in JIT for large BPF programs

Adrian Ambrozewicz (1):
      gpiolib: cdev: don't set GPIOD_FLAG_IS_OUT

Akshay Jindal (1):
      iommu/amd: Skip non-IVMD entries when parsing IVRS memory definitions

Alex Hung (1):
      drm/amd/display: Avoid closing unowned DDC pins

Alex Kazinsky (2):
      wifi: rsi: Skip TX aggregation setup for non-QoS frames
      ALSA: cs46xx: Handle SCB creation failures before dereferencing

Alex Sierra (2):
      drm/amd: define gc ip version local variable
      drm/amd: update mtype flags for gfx 9.5.0

Alexander Sverdlin (1):
      tpm: tpm2_probe: propagate transport errors

Alexei Starovoitov (1):
      net: reject a negative TCP header offset in qdisc_pkt_len_segs_init()

Alexey Charkov (1):
      nvmem: rockchip-otp: Serialize reads

Ali Resool Tuama (1):
      USB: quirks: add USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE for GameSir G7 SE

Andrea Parri (2):
      iomap: don't lose a failed direct I/O bio's error when zeroing the tail
      iommufd/iova_bitmap: Ensure that iova_bitmap_set() handles the full IOVA

Andrew Davis (1):
      arm64: dts: ti: k3-am625-sk: Remove M4 mailbox node redefinition

Andrew Luebke (1):
      scsi: aic79xx: Fix NULL pointer dereference in device reset

Andrew Morton (1):
      openrisc: export __mulsi3 for modules

Andrew Pam (1):
      power: supply: cros_charge-control: restore EC state on resume

Andrew Stellman (1):
      nvmet-rdma: fix out-of-bounds write in nvmet_rdma_map_sgl_inline()

Andrey Misiurov (1):
      fbdev: core: Initialize modelist in framebuffer_alloc()

André Draszik (1):
      drm/drm_crtc: ensure dma_fence_ops remain valid during device unbind

Andy Shevchenko (2):
      iio: adc: ad7192: Revert "properly check spi_get_device_match_data()"
      spi: cadence-xspi: Replace ACPI specifics by agnostic APIs

Anshul Dalal (1):
      arm64: dts: ti: k3-am62*: remove SoC dtsi from common dtsi

Anusha Srivatsa (2):
      drm/panel: Add new helpers for refcounted panel allocatons
      panel/ebbg-ft8719: Use refcounted allocation in place of devm_kzalloc()

Apurv Mishra (1):
      drm/amdkfd: Drop workaround for GC v9.4.3 revID 0

Ard Biesheuvel (1):
      efi/libstub: arm64: Don't use the platform register x18

Armaan Sandhu (1):
      lib/cmdline: fix get_options() count and overflow with large ranges

Armin Wolf (1):
      hwmon: (acpi_power_meter) Fix 18.45 TW bug

Arnd Bergmann (1):
      mtd: rawnand: ndfc: add CONFIG_OF dependency

Art O Cathain (1):
      ASoC: amd: acp-config: force SoundWire probe on Dell 14S DS14265

Baek Kyu, Kim (1):
      hwmon: (corsair-cpro) Cache fan target only after a successful command

Balakrishnan Sambath (4):
      media: microchip-isc: fix WB offset and gain register field masking
      media: microchip-isc: store the unshifted PFE_CFG0 BPS value
      media: microchip-isc: fix ISC_PFG_CFG0_BPS macro name typo
      media: microchip-isc: fix SBGGR10 Bayer pattern

Bart Van Assche (1):
      ata: libata: Add an argument to ata_eh_reset()

Bartosz Golaszewski (1):
      dmaengine: qcom: bam_dma: free interrupt before the clock in error path

Benjamin Coddington (2):
      NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before allocating
      NFSv4/pnfs: Free the netid when draining a data-server address list

Bernard Pidoux (41):
      mkiss: size the frame buffers for worst-case KISS escaping
      mkiss: don't use a tty write error as a byte count
      bpqether: leave the Ethernet device's queue and counters alone
      bpqether: fix truncated /proc/net/bpqether on partial reads
      rose: arm the neighbour timers with mod_timer()
      netrom: ignore a BPQ transport timeout below the sysctl minimum
      rose: don't give the same LCI to two calls placed at the same time
      ax25: don't create a second connection for a link on an incoming SABM
      ax25: free a closed socket when its device goes down
      mkiss: restart the transmit queue when the interface is opened
      6pack: restart the transmit queue when the interface is opened
      ax25: don't build a frame header from an uninitialised digipeater list
      ax25: don't take a reference on a gone device in ax25_accept()
      ax25: don't copy an uninitialised address to recvmsg()'s caller
      ax25: free the old digipeater path of a listed socket under ax25_list_lock
      ax25: put an incoming connection on the listener's queue once it is set up
      ax25: don't test the socket flags of a connection that has no socket
      ax25: free the copy of an IP packet that ax25_send_frame() turned down
      ax25: don't leave half a message on a connection when fragmenting fails
      ax25: make 16 the smallest maximum_packet_length of a port
      ax25: keep the window below 8 when a socket goes back to modulo 8
      ax25: let a socket connect again after a failed or ended connection
      ax25: don't let connect() find its own socket when calling the same station
      netrom: don't convert the maximum number of tries to jiffies
      netrom: don't leak frames in nr_route_frame()
      netrom: use the more flag of each frame taken from the resequencing queue
      netrom: give a frame back intact when it cannot be delivered
      netrom: don't give the same circuit ID to two sockets
      netrom: return the peer node in the address given by recvmsg()
      netrom: keep the selected route when a route of a node is removed
      netrom: drop a frame received with a TTL of 0
      netrom: check the window size given by the peer
      netrom: don't send part of a message that cannot be fragmented whole
      netrom: disconnect sockets under their lock when a device goes down
      netrom: only update the BPQ extension flag on circuit set-up frames
      rose: hold the listener while a Call Request is queued on it
      rose: hold the socket a received frame is delivered to
      rose: report a timed out call to connect()
      rose: drop the neighbour reference once when a cleared socket is closed
      rose: swap the AX.25 connection of a neighbour under a lock
      rose: give the sysctl timer limits in milliseconds

Bradley Morgan (2):
      panic: flatten nmi_panic control flow
      panic: restore variable arguments to nmi_panic()

Brandon Williams (1):
      power: supply: qcom_battmgr: Notify charger supplies of online changes

Breno Leitao (2):
      x86/nmi: Ignore negative NMI handler durations
      ACPI: APEI: accumulate the queued flag across error sections

Bryam Vargas (1):
      net/smc: don't spin in smc_rx_recvmsg() while a pipe holds spliced data

Bui Viet Dung (1):
      Bluetooth: selftest: Pin module for selftest debugfs file operations

Caleb Kan (1):
      stackdepot: stop preallocating after the final pool

Casey Connolly (2):
      power: supply: pmi8998_charger: rename to qcom_smbx
      drm/panel: ebbg-ft8719: Set prepare_prev_first

Cen Zhang (6):
      ocfs2: keep locking_state within the cluster connection lifetime
      ocfs2/dlm: serialize migration MLE cleanup on failure
      ocfs2: stop recovery before shutting down local allocators
      ocfs2/cluster: unlink socket containers before releasing resources
      ocfs2: wait for filecheck kobject release after a failed add
      ocfs2: cache the mount context for dentry lock callbacks

Cen Zhang (Microsoft) (1):
      userfaultfd: fix UFFDIO_MOVE livelock on large folio with extra references

Chao Yu (4):
      f2fs: fix to check continuousness in f2fs_sync_meta_pages() correctly
      f2fs: zone: fix to avoid bio split on sequential zone
      f2fs: fix to use bio_in_atomic() in f2fs_read_end_io()
      f2fs: fix to invalidate curseg if change_curseg() fails

Chengfeng Ye (3):
      xfrm: retry inexact policy lookup after node reinsertion
      net/9p/usbg: clear stale request context after abort
      batman-adv: Close OGM aggregation before transmission

Chi Zhiling (1):
      exfat: advance valid_size to EOF for append writes

Chris Down (1):
      mm: make swapoff interruptible when unusing mms/shmem

Chris Mason (12):
      backing-file: always end a queued write
      io_uring/cancel: drop sqd->lock while SQPOLL waits
      mm/mempolicy: charge shared policy nodes
      mm/shmem: stop retrying folios that cannot be split
      mm/shmem: preserve data in clean folios when splitting fails
      mm/gup: fix clearing folios in memfd_pin_folios()
      mm/gup: fix out-of-bounds write for nr_pages == 0 in GUP-fast
      mm/mmu_notifier: set ->mm only after mmgrab()
      mm/memory: reject remote COW faults on PFN mappings
      mm: fix unkillable fault loop on MAP_DROPPABLE memory
      ovl: look up the index by the decoded origin
      mm/shmem: honour F_SEAL_EXEC when an ACL is set

Chris Simpson (1):
      ALSA: hda/realtek: Enable bass speakers on Alienware m17 R3

Christian Borntraeger (1):
      s390/vmcp: Initialize full session info to zero

Christian Brauner (1):
      iomap: don't mark unwritten parts of a folio uptodate

Christian Gmeiner (1):
      drm/etnaviv: Flush the tile status cache through both the PE and BLT

Christian Loehle (3):
      ACPI: CPPC: Validate FFH register fields before hardware access
      ACPI: CPPC: Propagate errors from cross-CPU FFH calls
      ACPI: CPPC: Accept requests to retain immutable autonomous selection

Christoph Hellwig (1):
      xfs: fix recovery of partial attr removals

Christophe JAILLET (1):
      power: supply: Use devm_mutex_init()

Christopher Lusk (1):
      m68k: Fix seccomp filtering on ColdFire and 68000

Chuck Lever (7):
      NFSD: map fh_verify() status codes for NFS_ACLv2 replies
      NFSD: Count the delegations held by each client
      NFSD: Send a meaningful CB_RECALL_ANY keep count
      NFSD: Move the cld upcall message out of the caller's stack frame
      NFSD: Complete a cld upcall when the daemon closes the pipe
      NFSD: Complete a cld upcall when copying its reply fails
      NFSD: Map flex file layout IDs through the request's user namespace

ChunYuZhiQiang (1):
      can: dev: can_fill_info(): don't wake up controller if interface is down

Cryolitia PukNgae (1):
      ALSA: usb-audio: rename QUIRK_FLAG_MIXER_MIN_MUTE to QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE

Cunhao Lu (1):
      can: dev: can_put_echo_skb(): free skb on invalid echo index

Daeho Jeong (3):
      f2fs: don't use truncate_inode_pages_final() on live inodes
      f2fs: return -EIO for a lost inode block after cp_error
      f2fs: release a removed xattr node in roll-forward recovery

Daehyeon Ko (1):
      vhost/vsock: size receive SKBs from declared payload

Daejun Park (6):
      xfs: don't skip free extents in later batches of a whole-AG FITRIM
      xfs: don't skip free extents of the longest length in a whole-AG FITRIM
      xfs: mark the inode preallocated for pNFS write layouts past EOF
      xfs: clamp a pNFS LAYOUTCOMMIT extent before computing its end
      xfs: cap the block count of xfs_iomap_write_direct() at one extent
      xfs: clamp the pNFS layout range to the maximum file size

Damien Le Moal (3):
      ata: libata-eh: Rename and make ata_set_mode() static
      ata: libata-eh: Remove ata_do_eh()
      ata: libata-eh: Simplify reset operation management

Daniel Palmer (1):
      m68k: Fix task info flags handling for 68000

Daniel Phillips (1):
      amdkfd: Fix memory availability double accounting of kfd pinned objects

Danish Khateeb (2):
      perf/core: Don't send SIGTRAP after exec removed the event
      ALSA: timer: Handle userspace-driven timer ioctls from 32-bit tasks

Darrick J. Wong (15):
      xfs: break out xattr entry checks into separate functions
      xfs: check for buffer overruns when examining local/remote xattr entries
      xfs: refactor directory data block walking loops in scrub
      xfs: improve dirent bounds checking in scrub and repair
      xfs: flag excessive delalloc rt extents as corruption
      xfs: mark cow extents bad if there's no rmap mapping for them
      xfs: rescan the AGs if incore delalloc counter is negative
      xfs: don't queue rmap update twice when reaping a fork
      xfs: complain loudly when dirtree checker finds broken links
      xfs: reinitialize dquot block if non-first dquot can't load
      xfs: forcibly reset quota timers when upgrading to bigtime during repair
      xfs: don't try to repair rtsummary if the summary file isn't computed
      xfs: reattach dquots after changing inode ids
      xfs: reduce new btree slack factor if free space is negative
      xfarray: don't crash when sorting if array element crosses a folio

David Carlier (1):
      media: ipu6: Fix firmware config leak on stream start

David Hildenbrand (1):
      mm/page_alloc: reject unreasonable folio/compound page sizes in alloc_contig_range_noprof()

David Hildenbrand (Arm) (11):
      mm/shmem: discard whole new large folios on fallocate rollback
      mm/shmem: fix truncate hang in large swap entry
      mm/shmem: fix truncate loop after boundary swapin failure
      mm/shmem: fix truncation of files containing only swapin-error markers
      mm/filemap: finish fault cleanup before dropping the fault lock
      mm/gup: check for overflow when converting nr_pages to bytes in GUP-fast
      mm/madvise: fix data loss from MADV_FREE on a KSM page
      mm/ksm: reset the unstable trees of all nodes
      mm/userfaultfd: only allocate anon_vma in CoW mappings
      mm: disallow ioremap'ing ordinary RAM in generic_access_phys()
      mm/huge_memory: split huge PUDs when adjusting VMA boundaries

David Howells (2):
      rxrpc: Fix update of call->tx_pending without holding lock
      afs: Fix afs to abort the rxrpc call on send error

David Lee (1):
      sctp: hold shkey across socket migration

Denis Pauk (1):
      hwmon: (nct6775) Add ASUS X870/W480 to WMI monitoring list

Depeng Shao (1):
      media: qcom: camss: vfe: Move common code into vfe core

Devin Wittmayer (2):
      drm/panic: Fix kmsg screen hang on a long log line
      wifi: mt76: move the channel survey when the channel changes

Diego Oliva (3):
      smb: client: fix OOB read of the resume name sent in TRANS2_FIND_NEXT2
      smb: client: reject FIND data areas that run past the received response
      smb: client: fix OOB read in the SMB_FIND_FILE_UNIX name scan

Dmitry Torokhov (1):
      Input: always accept EV_SYN in input_event()

Donggeun Yoo (1):
      tracing: Add the bucket size to expr_field_str()

Eduard Zateev (1):
      smb: client: hold server info until cifsd exits

Edward Adam Davis (1):
      ocfs2: fix oob in __ocfs2_find_path

Elena Sakhnovitch (1):
      drm/amdgpu/gmc9: add extra type-2 TLB flush for gfx942/gfx950

Erhan Bilgili (2):
      drm/amdgpu: Fix duplicate dependency fence releases
      drm/amdgpu: Report MES ring wait timeouts.

Eric Biggers (6):
      fsverity: Tell LSMs about signature only after verity is enabled
      fsverity: Explicitly require FMODE_READ to retrieve hashes
      xor: add missing vzeroupper to AVX code
      raid6: add missing vzeroupper to AVX-512 code
      raid6: add missing vzeroupper to AVX2 code
      lib/crypto: mips: Disable Octeon SHA code on little-endian kernels

Eric Dumazet (1):
      ipmr: prevent info-leak in pmr_cache_report()

Esben Haabendal (3):
      drm/bridge: nwl-dsi: Cleanup endpoint mux control selection
      drm/bridge: nwl-dsi: Limit LCDIF specific sync override
      iio: light: ltr501: Power down chip if request irq fails

Ethan Nelson-Moore (1):
      ata: sata_inic162x: remove dangerous broken driver

Evanshenf (3):
      drm/loongson: Fix framebuffer selection in async cursor updates
      drm/loongson: Fix double free on BO initialization failure
      drm/loongson: Handle buffer mapping failures when clearing a BO

Ewan D. Milne (1):
      nvmet: don't return memory contents beyond valid data when reading ANA log page

Fabio Cesari (1):
      iio: light: isl29028: fix runtime PM reference leak on error paths

Fan Wu (2):
      media: rockchip: rga: quiesce IRQ before releasing m2m state
      power: supply: bq27xxx: Ensure poll work is cancelled on remove

Fang Xieyan (2):
      vringh: bound top-level re-entry into indirect tables
      vringh: reject empty / undersized indirect descriptor tables

Federico Musto (1):
      net: atl1c: drop oversized RX frames instead of panicking

Francesco Orlando (1):
      Input: xpad - add GameSir Nova Lite support

Franck Baur (1):
      net: jme: keep RX MAC clock enabled for WoL

Frank Li (1):
      PCI: Add enable_device() and disable_device() callbacks for bridges

Fuad Tabba (2):
      KVM: arm64: timers: Compute an offset-applied CVAL from the current count
      KVM: arm64: Validate the host vCPU's VM before reading it under pKVM

Gael Blivet (1):
      ksmbd: look up stream size by exact xattr name

Gaurav Batra (1):
      powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped

Ge Yang (2):
      mm/hugetlb: fix kernel NULL pointer dereference when replacing free hugetlb folios
      mm/hugetlb: remove unnecessary holding of hugetlb_lock

Geraldo Nascimento (1):
      PCI: rockchip: Drive at 2.5 GT/s, error other speeds

Gianluca Balboni (1):
      ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx

Giorgi Kobakhia (1):
      ocfs2: fix array out of bound access in __ocfs2_find_path()

Greg Kroah-Hartman (1):
      Linux 6.12.118

Gregory Price (1):
      mm/mempolicy: use vm_normal_folio_pmd() in queue_folios_pmd()

Guanglei Zhu (2):
      ceph: clamp the inline data length in ceph_fill_inline_data()
      apparmor: check accept index + 1 is in bounds

Guangshuo Li (5):
      mfd: ab8500: Fix child device leaks on probe failure
      crypto: omap-des - fix crypto engine cleanup
      media: i2c: og01a1b: power off sensor on remove
      media: i2c: ov5647: fix power cleanup on remove
      crypto: omap-sham - fix crypto engine cleanup

Guenter Roeck (12):
      hwmon: (aquacomputer_d5next) Check maxcollection when probing AQUAERO devices
      hwmon: (asus_wmi_sensors) Avoid global struct mutation
      hwmon: (hp-wmi-sensors) Avoid global struct mutation
      hwmon: (hp-wmi-sensors) Fix unbounded loops in scale_numeric_sensor()
      hwmon: (lm87) Fix drvdata type confusion in vrm_show() and vrm_store()
      hwmon: (nct6683) Fix incorrect struct cast in show_pwm() and store_pwm()
      hwmon: (peci/dimmtemp) Fix devres leak and UAF on concurrent unbind
      hwmon: (pmbus/q54sj108a2) Add missing NULL pointer check
      hwmon: (pmbus) Check return value from pmbus_thermal_add_sensor()
      hwmon: (pmbus) Release devres allocated memory after devm_thermal_of_zone_register error
      hwmon: (pmbus) Fix return value check from thermal zone registration
      hwmon: (coretemp) Check for NULL platform device in hotplug callbacks

Hamid Nassiby (1):
      Revert "mm/page_owner: fix memory leak in page_owner_stack_fops->release()"

Hans Zhang (1):
      spi: cadence-xspi: Use FIELD_MODIFY()

Hasun Park (1):
      ASoC: amd: acp: add DMI override for ACP70 flag

Hengyu Liang (2):
      fs/proc/task_mmu: return -ENOTTY for unknown pagemap ioctls
      l2tp: only return sessions of the given tunnel in l2tp_session_get()

Henrik Enquist (1):
      ALSA: aloop: Don't constrain playback params in notify mode

Henry Martin (1):
      rds: fix out-of-bounds conn_path walks via handshake exthdrs

Hitesh Patel (1):
      media: qcom: camss: vfe-17x: Fix write master selection for RDI lines

Huacai Chen (1):
      LoongArch: Don't init & online empty nodes

Hugo Villeneuve (3):
      serial: sc16is7xx: declare SPR/TLR/XOFF2 register as volatile
      serial: sc16is7xx: add comments for lock requirements
      serial: sc16is7xx: declare MCR and IER as volatile registers

Hung-Jui Lin (1):
      posix-timers: Report zero remaining time for disarmed SIGEV_NONE timers

Hungyu Lin (7):
      posix-timers: Accept NULL clock_getres() output in stubs
      ext2: preserve completed DIO bytes when buffered fallback fails
      mm/migrate: untag addresses when querying page nodes
      inotify: do not coalesce rename events
      block: Return the soft block size for compat BLKBSZGET
      ext2: preserve IOMAP_F_DIRTY for extending direct writes
      mm/page-writeback: avoid 32-bit overflow in dirty threshold shares

HyeongJun An (1):
      ALSA: ump: Fix dropped data bytes at UMP System message conversion

Hyungjung Joo (1):
      net/9p/usbg: clear stale client pointer on close

Hyunwoo Kim (1):
      net: restore refcount ordering for lockless socket access

Ian Bridges (2):
      ksmbd: require DELETE access for delete-on-close opens
      ksmbd: grant a POSIX ACL group entry only to the group's members

Ido Schimmel (2):
      vxlan: Stop rejecting dynamic FDB entries with a nexthop ID
      ipmr, ip6mr: validate packets injected into the register vif on xmit

Igor Velkov (1):
      genirq/kexec: Do not take the bus lock of an interrupt chip on the crash path

Ilia Mirkin (1):
      drm/nouveau/devinit/gf100-: try to avoid double-running vbios scripts

Imre Kaloz (4):
      scsi: aic7xxx: Use default settings on the SGI O2 onboard controllers
      MIPS: mm: Fix the cache error vector jump for XKPHYS kernels
      MIPS: sgi-ip32: Mask MACE PCI interrupts in CRIME only
      MIPS: sgi-ip32: Leave MACE PCI control alone in config accesses

Jackie Dong (1):
      ASoC: amd: acp: Add DMI quirk for Lenovo Yoga Pro 7 15ASH11

Jakub Szczudlo (1):
      iio: adc: ti-ads1100: Fix incorrect reading when datarate changed in single mode

Jamal Hadi Salim (2):
      bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
      net/sched: clamp skb->queue_mapping before indexing the tx queue

James Clark (1):
      net: ethernet: ti: am65-cpsw-nuss: Enable timestamping of unicast PTP packets

Janne Grunau (1):
      wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload

Jarkko Sakkinen (1):
      nvme-keyring: Add a missing key_put() call to nvme_tls_key_lookup()

Jasper Smet (1):
      ASoC: amd: acp: Add DMI quirk for ASUS Zenbook S16 UM5606GA

Javier Carrasco (7):
      hwmon: chipcap2: fix command error diagnostics
      hwmon: chipcap2: fix off-by-one in command mode retry loop
      hwmon: chipcap2: fix be16 handling
      hwmon: chipcap2: defer probe when IRQs are unavailable
      hwmon: chipcap2: enable IRQ processing when regulator is already enabled
      hwmon: chipcap2: balance regulator state
      hwmon: chipcap2: do not discard pending alarms on disable

Jeff Layton (9):
      nfsd: don't offer flexfiles layouts when NFSv3 isn't being served
      NFSD: report listener creation failures through extack
      SUNRPC: report local rpcbind calls that get no answer
      NFSD: stop registering with rpcbind after a failure in listener_set
      nfsd: prevent callback tasks running concurrently
      nfsd: eliminate cl_ra_cblist and NFSD4_CLIENT_CB_RECALL_ANY
      nfsd: defer setting NFSD4_CALLBACK_RUNNING in deleg_reaper
      nfsd: clear CALLBACK_RUNNING on failed delegation recall queue
      nfsd: shorten extack string returned with dodgy listener

Jens Axboe (3):
      io_uring/sqpoll: don't attach to a thread that is canceling
      io_uring/poll: don't poll a writer for a read side hangup
      io_uring/poll: don't poll a writer for urgent data

Jesse Zhang (6):
      drm/amdgpu: parse CS IBs at the BO offset their VA mapping starts at
      drm/amdgpu: keep the CS user fence BO in GTT
      drm/amdgpu/gfx12: disallow GFXOFF while updating the SPM VMID
      drm/amdgpu: drop the dma-buf reference when a KFD import fails
      drm/amdgpu: don't drop the gang dependency fence twice
      drm/amdgpu: reject CS chunks too large for kvmalloc()

Jiale Yao (3):
      hwmon: (aquacomputer_d5next) reject short status reports
      iio: adc: ad7192: reject devices without match data
      iio: dac: mcp4821: reject devices without match data

Jiaming Zhang (2):
      gfs2: reject invalid inode sizes
      nilfs2: force clear dirty state when restoring from the shadow map

Jiangshan Yi (1):
      ceph: fix longname buffer overflow in ceph_fname_to_usr()

Jianyun Gao (2):
      xfs: fix temporary cursor leak in btree shift corruption paths
      dax: fix wrong error code returned from dax_dedupe_file_range_compare()

Jiayuan Chen (1):
      mm/memcontrol: fix data-race on reading jiffies_64

Jinchao Wang (1):
      panic: use panic_try_start() in nmi_panic()

Jinjie Ruan (1):
      arm64: kexec_file: Fix elf_headers memory leak in retry loop

Jinmeng Zhou (1):
      mm/hugetlb: charge folios to the target mm's memcg

Jinwang Li (1):
      Bluetooth: L2CAP: Ignore connection responses with wrong ident

Jisheng Zhang (1):
      spi: cadence-xspi: group marvell support code together

Joanne Koong (2):
      fuse: don't launder folios of a bad inode
      fuse: don't drop destination page cache on a zero byte copy reply

Joe Damato (1):
      mm: memcontrol: raise MEMCG_MAX for charges that fail without reclaiming

Johan Hovold (1):
      media: qcom: camss: vfe: suppress VFE version log spam

Jose Maria Casanova Crespo (1):
      drm/v3d: Initialize timedout_batches when running a CSD job

Josef Bacik (11):
      tmpfs: keep the quota soft limits of an unused id
      tmpfs: preserve explicitly disabled quota limits
      mm/mglru: don't use stack pointers when walking PUD and PMD tables
      mm/memfd: make f_pos accesses atomic
      mm/filemap: don't lose a folio lock wakeup to a signal
      mm/mmu_gather: fix flushing ranges with 4 GiB or larger
      mm/mmu_notifier: finish non-blocking interval invalidation on error
      mm: fix unmap_mapping_range() beyond 4 GiB on 32-bit
      blk-mq: end the request if getting a keyslot fails
      mm/hugetlb: unmap the page where the other VMA maps it
      mm/vma: don't leak the commit charge on mmap failure

Joseph Qi (6):
      ocfs2: find the xattr entry again after defragmenting a bucket
      ocfs2: find the xattr entry again after converting a block to a bucket
      ocfs2: do not read the entry array of an empty xattr bucket
      ocfs2: do not index before the entry array when dividing an empty bucket
      ocfs2: do not read the entry array of an empty xattr block
      ocfs2: restrict OCFS2_INVALID_SLOT suballoc slot to system inodes

José Miguel Castellanos Valladolid (1):
      ALSA: hda/realtek: Enable mute LEDs on HP OmniBook X Flip 14-fm0xxx

Jouni Högander (1):
      drm/i915/psr: Don't clip plane state destination rectangle

Judith Mendez (1):
      arm64: dts: ti: k3-am625-sk-common: Set eMMC clock pin as OUTPUT

Jun Yang (1):
      sctp: re-point retained control chunks on association migration

Jérémy Jean (1):
      crypto: ecc - Handle exceptional points in Shamir multiplication

Kaixuan Li (2):
      can: isotp: check the frame type, not just the length
      f2fs: bound the SIT/NAT bitmaps by the checkpoint pack

Kamil Sawicki (1):
      net: limit priority VLAN untag depth

Karl Mehltretter (1):
      irqchip/atmel-aic[5]: Disable interrupts in the irq_pm_shutdown() callbacks

Kathiravan Thirumoorthy (1):
      arm64: dts: qcom: ipq9574: Wire up USB3 PHY PIPE clock to GCC

Kazuki Hanai (1):
      media: mediatek: jpeg: Avoid context access after job finish

Kenneth Feng (1):
      drm/amd/pm:restate all customized OD features on every table upload for smu 13.0.0/smu 14.0.2

Keqiang Duan (1):
      KVM: x86: Clear hardware HLT state when userspace makes a vCPU not-halted

Kevin Wang (1):
      drm/amd/pm: reapply umd profile state after recovery

Kiryl Shutsemau (Meta) (2):
      arm64: sdei: Run the event handler on the kernel vectors
      arm64: sdei: Preserve the interrupted context's exception registers

Koichiro Den (1):
      PCI: endpoint: pci-epf-vntb: Manage virtual NTB and PCI bus lifetime

Kumari Pallavi (1):
      misc: fastrpc: Rename phys to dma_addr for clarity

Kuniyuki Iwashima (1):
      ipmr: Call ipmr_fib_lookup() under RCU.

Kyle Zeng (5):
      batman-adv: mcast: validate tracker padding before forwarding
      mm/khugepaged: flush deferred unmaps before dropping a failed folio
      net/sched: sch_qfq: prevent aggregate self-replacement
      mptcp: pm: kernel: use RCU to free endpoint listeners
      mm/page_vma_mapped: continue past nonmatching huge PMDs

Kylie C (1):
      drm/amd/display: Don't select zero V_TOTAL_MIN/MAX on seamless boot

Li Zhe (1):
      mm/hugetlb: fix mremap move length truncation

Lijo Lazar (1):
      drm/amd/pm: Revert state if force level fails

Linmao Li (2):
      media: chips-media: wave5: Handle polling IRQ thread failure
      PCI: cadence: Store the core controller in platform drvdata

Linus Torvalds (9):
      assoc_array: don't lose objects when a shortcut is split on a word boundary
      assoc_array: don't lose objects when a root shortcut is split at level 4
      assoc_array: move in-place insertion into a function of its own
      assoc_array: fill the segment cache in one place
      assoc_array: move node splitting into a function of its own
      assoc_array: move shortcut creation into a function of its own
      assoc_array: choose between splitting a node and a shortcut without gotos
      assoc_array: don't chain a new shortcut onto an existing one
      assoc_array: keep gc's cleanup out of the live tree on allocation failure

Liu Changjie (1):
      can: peak_usb: pcan_usb_fd_decode_buf(): accept short uCAN end-of-list records

Liz Fong-Jones (1):
      writeback: keep cleanup_offline_cgwb()'s scan out of syncs

Longlong Xia (1):
      mm/zswap: publish the initial pool with list_add_rcu()

Lorenzo Stoakes (ARM) (2):
      mm/mremap: correctly uncharge accountable VMAs in error path
      mm/vma: avoid broken uffd merge on mremap

Lu Yao (1):
      drm/i915/gem: Reset err for each fence entry

Lucas De Marchi (1):
      drm/panel: Fix build error on !CONFIG_OF

Lucas Tanure (2):
      drm/vc4: hdmi: always cancel the scrambling work synchronously
      drm/vc4: hdmi: enable scrambling before the TMDS clock starts

Luo Jie (1):
      bitfield: Add FIELD_MODIFY() helper

Luxiao Xu (1):
      mm/memory: constrain generic_access_phys() to page boundary

Ma Ke (1):
      ALSA: hda: cs35l41: Fix ACPI device reference leak on probe failure

Maciej Kucharek (1):
      drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0

Maciej W. Rozycki (1):
      PCI: Skip Target Speed quirk on clamped ports with no link

Marc Zyngier (2):
      KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded
      KVM: arm64: vgic: Stop the target vcpu when disabling LPIs

Marco Scardovi (1):
      platform/x86: asus-wmi: Serialize WMI method evaluations with a mutex

Marco Ziliani (1):
      ata: libata-pmp: disable the SEMB port on Marvell 88SM9705

Marek Czernohous (1):
      drm/nouveau/pci: use config-space MSI rearm on MCP79/MCP7A (NVAC)

Marek Vasut (1):
      PCI: rcar-gen4: Limit Max_Read_Request_Size to 256 Bytes

Mario Limonciello (1):
      platform/x86/amd/pmf: Add AMDI0112 ACPI ID

Martin Belanger (1):
      nvme-tcp: skip TLS control records while waiting for the ICResp

Martin Fuzzey (1):
      serial: sc16is7xx: fix data corruption due to unexpected xon/xoff

Masafumi Suzuki (1):
      sctp: account for chunk padding in sctp_init_cause()

Matheus Alves de Almeida (1):
      fat: hold truncate_lock in fat_write_failed()

Matthew Wilcox (Oracle) (2):
      nilfs2: remove nilfs_writepage
      nilfs2: convert nilfs_page_count_clean_buffers() to take a folio

Matthias Goergens (4):
      udf: don't let the extent type hide an exhausted free-space table extent
      udf: check the unallocated space table when it is loaded
      udf: fix preallocation discarding before an empty allocation extent
      udf: don't use eloc after the end of the unallocated space table

Maurizio Casciano (1):
      power: supply: core: Honor supplied-from with CONFIG_OF=y

Maximilian Luz (1):
      hwmon: (nct6775) Add ASUS ROG STRIX X870E-H GAMING WIFI7

Maíra Canal (1):
      drm/vc4: Publish the output fence outside of job_lock

Mehmet Fide (4):
      wifi: rtw88: usb: route bmc frames via the high queue only for DTIM delivery
      wifi: rtw88: usb: bound what the driver feeds the after-DTIM queue
      wifi: rtw88: usb: only let the frames a dozing station needs use the after-DTIM queue
      wifi: rtw88: widen the ATIM window while an AP interface is up

Michael Bommarito (1):
      9p/trans_virtio: reject mount tags longer than NAME_MAX at probe

Michael Grzeschik (6):
      net/9p/usbg: also disable endpoints on p9_usbg_close
      net/9p/usbg: set client to Disconnected on usb9pfs_disable
      net/9p/usbg: always reset completion when disconnecting
      net/9p/usbg: call disable_usb9pfs() from usb9pfs_disable()
      net/9p/usbg: fix out_req buffer leak in disable_usb9pfs
      net/9p/usbg: remove bogus context initialization in alloc_requests

Michal Blaszczyk (1):
      sched_ext: Reset runnable_at when a task leaves its scheduler

Michal Pecio (1):
      usb: xhci: Fix bounce buffer overflow

Mikulas Patocka (1):
      dm-bufio: fix non-working memory limit

Milan Milicevic (2):
      drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts for navi10_ih
      drm/amdgpu: publish IH enabled before PSP programs IH_RB_CNTL

Ming Lei (1):
      ublk: mark the io command cancelable before publishing it

Miquel Raynal (4):
      clk: nuvoton: ma35d1: Keep the clock count in the driver
      dt-bindings: clock: ma35d1: Drop CLK_MAX_IDX define
      dt-bindings: clock: ma35d1: Add missing WDT/WWDT parent clocks
      clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks

Misha Nasledov (1):
      drm/amd/display: Drop clock requirements on DCN32 when no displays are active

Mohit Sharma (1):
      ASoC: qcom: q6apm: Guard callbacks until probe data is ready

Myeonghun Pak (3):
      ASoC: stm: stm32_i2s: request IRQ after regmap initialization
      mfd: twl-core: Unregister the auxiliary platform device on unbind
      fbdev: nvidia: Release write-combining handle on probe failure

Nam Cao (1):
      panic: Add vpanic()

Naman Jain (1):
      x86/init: Initialize wall clock in get_rtc_noop()

Nicolai Buchwitz (1):
      serial: amba-pl011: keep transmitter enabled when disabling RS485

Nikhil Solanke (1):
      usb: core: Add quirk for 255-bytes initial config read

Nikolaos Karaolidis (2):
      fs: rotate inodes whose page cache could not be dropped
      fs: don't lose inodes that another LRU walker is isolating

Noam D. Eliyahu (1):
      tg3: Invert restart quirk logic to restrict SNP power-down bypass

Oliver Hartkopp (5):
      can: isotp: check the return values of can_rx_register() in isotp_bind()
      can: proc: skip stats calculation after reset in can_stat_update()
      can: replace ARPHRD_CAN type checks with can_get_ml_priv()
      can: protect the receive lists with a per-device lock
      can: raw, isotp: copy socket options outside of lock_sock()

Olivier Kaloudoff (1):
      ALSA: usb-audio: Add mic resolution quirk for Logitech Webcam C200

Paolo Abeni (1):
      mptcp: fix subflow bitfield misuse

Pauli Virtanen (1):
      ALSA: usb-audio: add volume quirks for MS LifeChat LX-3000

Paulo Alcantara (1):
      smb: client: require stable pages for SMB compression

Peng Wang (1):
      tick/nohz: Reevaluate the tick for kicks flushed outside hardirq

Pengpeng Hou (1):
      media: require two-byte Cypress type 04 records

Peter Ujfalusi (5):
      ALSA: x86: hdmi: fix chmap array missing terminator entry
      ALSA: hda/hdmi: clamp sad_count in ELD proc write handler
      ALSA: hda/hdmi: clamp num_cvts against cvt_nids[] in hdmi_read_pin_conn
      ASoC: hdac_hda: Allocate the private data at codec driver bind
      ASoC: hdac_hda: Restore the codec device type on unbind

Ping-Ke Shih (1):
      wifi: rtw88: TX report with long timeout for non-PCIE devices

Qi Xi (2):
      mm/page_isolation: guard compound_order() against racing
      mm/page_isolation: fix UBSAN shift-out-of-bounds warning

Qihang (2):
      xfrm: interface: validate the IP header on xmit
      cipso: fix optlen corruption in cipso_v4_delopt()

Qiliang Yuan (2):
      srcu: Add list_splice_init_srcu()
      nvme: wait for SRCU readers before splicing the namespace list

Qingfang Deng (1):
      pppoe: delete session hash entries by pointer match

Ramin Moussavi (1):
      microblaze: restore the ABI argument home area below pt_regs (PTO)

Ratnaker Gautam (2):
      smb: client: validate SMB1 EA list bounds before parsing
      smb: client: bound POSIX lock data area by response length

Ray Zhang (1):
      net: count last skb of each sk_backlog pass in __release_sock()

Reid Downing (1):
      xfs: fix wrong compat fields in xfs_ioctl32_bstat_copyin()

Ricardo Neri (1):
      hwmon: (coretemp) Return -ENODATA for invalid temperature readings

Ricardo Ribalda (2):
      media: uvcvideo: Add autosuspend quirk for AVerMedia Live Gamer HD 2
      media: uvcvideo: Force UVC version for Avermedia GC515

Ridham Khurana (1):
      hwmon: (lm70) Fix rounding of negative temperatures

Ridong Chen (2):
      mm/page_counter: avoid integer overflow in effective_protection()
      mm/mglru: fix ineffective memory protection for non-kswapd reclaim

Robin Snyders (1):
      power: supply: qcom_smbx: validate battery float voltage

Roman Demidov (1):
      drm/amd/display: Fix NULL deref in dcn401_update_clocks_update_dtb_dto

Rosen Penev (6):
      mtd: rawnand: ndfc: use ioread32be/iowrite32be and allow COMPILE_TEST
      mtd: rawnand: ndfc: fix gcc uninitialized var
      mtd: rawnand: ndfc: use devm_platform_ioremap_resource()
      net: bgmac: enable interrupts only after NAPI is ready
      drm/nouveau/nvkm: clear use.enabled when subdev init fails
      nvmem: rockchip-otp: alloc clks with main struct

Ruide Cao (1):
      mptcp: fix MP_CAPABLE token migration when cloning reqsk

Runyu Xiao (7):
      can: proc: reset pkg_stats atomics individually
      ALSA: usb-audio: Protect Roland control activation
      hte: tegra194-test: shut down timer before GPIO release
      mailbox: altera: shut down RX polling timer on channel teardown
      ALSA: mpu401: shut down timer before freeing MPU
      IB/hfi1: Shutdown self-rearming timers before freeing
      block: amiflop: synchronize flush timer before track flush

Ruoyu Wang (1):
      media: adv748x: Fix endpoint reference leaks on probe failure

Rupesh Majhi (1):
      iio: pressure: dps310: fix CFG_REG bit definitions

Ryo Takakura (1):
      crypto: omap - convert from tasklet to BH workqueue

Ryusuke Konishi (2):
      nilfs2: correct return value kernel-doc descriptions for the rest
      nilfs2: ignore non-fatal signals during synchronous log write wait

SJ Park (6):
      mm/damon/core: skip applying scheme if region split for quota fails
      mm/damon/paddr: respect folio end for DAMOS actions except STAT
      mm/damon/core: filter out damos address filter-split failed region
      mm/damon/core: remove unreachable damos charge_{target,addr}_from
      mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
      mm/damon/core: move static variable last_nr_regions to damon_ctx

Sabrina Dubroca (1):
      xfrm: espintcp: reorder operations within espintcp_init_sk

Sahaj Chaudhari (1):
      gpio: pca953x: Preserve wakeup accounting on parent IRQ failure

Sakari Ailus (1):
      platform/x86: int3472: Fix uninitialised variable warning

Samarth Narang (1):
      mm/ksm: keep soft-dirty when merging a page

Samiullah Khawaja (1):
      mm/gup: check folio->mapping under folio lock in memfd_pin_folios()

Sasha Levin (1):
      nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for KIOXIA XG10d

Sean Christopherson (10):
      KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1 && EFER.LME=0
      KVM: Harden and prepare for modifying existing guest_memfd memslots
      KVM: Only bind memslot to guest_memfd instance for CREATE operations
      KVM: x86/mmu: Conditionally resched when retrying gPTE walk on A/D update failure
      KVM: x86: Conditionally resched when restarting REP string emulation
      KVM: nVMX: Process each host MSR entry at most once when unwinding failed VM-Entry
      KVM: x86/mmu: Cap number of parent PTEs per SP at 1000 (the arbitrary rmap limit)
      KVM: x86: Unconditionally reset MMU context when emulating INIT
      KVM: guest_memfd: Split bind() into prepare()+commit() phases
      KVM: guest_memfd: Establish memslot<=>guest_memfd bindings *after* memslot is ready

Sean Young (3):
      media: ene_ir: Ensure teardown is done in the correct order
      media: redrat3: Error path leaves device in transmitting state
      media: serial_ir: Fix race condition where timer can be re-armed

Sebastian Reichel (1):
      power: supply: core: get rid of of_node

Sehat Mahde (1):
      ASoC: amd: acp-config: force SoundWire probe on HP OmniBook X Flip 16

Seiji Nishikawa (1):
      nvme-tcp: fix io_work priority inversion when send_mutex is held

Seungjin Bae (1):
      usb: typec: ucsi: ccg: Validate altmode index in GET_CURRENT_CAM response

Shakeel Butt (1):
      io_uring/sqpoll: do the return-to-userspace work in the SQPOLL thread

Shang En Sim (2):
      io_uring/cancel: count all requests that a CANCEL_ALL cancels
      io_uring/poll: cancel all matching requests in one pass

Shao Mingyin (2):
      scsi: target: tcmu: Fix divide-by-zero in data_pages_per_blk store
      nvmet: bound the traddr and trsvcid configfs writes

Shivank Garg (1):
      KVM: guest_memfd: take the invalidate lock when unbinding a dying file

Shixiong Ou (1):
      fbdev: nvidia: Convert to managed PCI and ioremap API

Shuai Liu (1):
      io_uring/sqpoll: don't set IO_SQ_THREAD_SHOULD_STOP on thread exit

Shuvam Pandey (1):
      lib/tests: extend cmdline KUnit with next_arg() tests

Sinan Turunc (4):
      ALSA: line6: Reject capture buffers smaller than two packets
      ALSA: usx2y: Require a buffer of two URBs
      ALSA: usx2y: Guard the playback copy
      ALSA: usb-audio: Bound packet copies by the PCM buffer size

Siwei Zhang (2):
      Bluetooth: L2CAP: Reject signalling responses in invalid states
      Bluetooth: L2CAP: Only accept connection responses to outstanding requests

Sravan Kumar Gundu (1):
      kernel/panic.c: format kernel-doc comments

Stanislaw Gruszka (1):
      wifi: mac80211: queue frames while off-channel

Stanley Jhu (3):
      scsi: ufs: bsg: Validate request_len before accessing request
      scsi: ufs: bsg: Reject UIC commands with a non-zero result byte
      scsi: ufs: core: Add a helper for clearing hba->outstanding_reqs

Steve Wahl (1):
      watchdog/hpwdt: Refine hpwdt message for UV platform

Sumit Kumar (1):
      PCI: dwc: Set DMA_BYPASS bit in outbound IATU CTRL2 register

Sung Byeongchan (1):
      virtiofs: validate fixed-output response length

Suravee Suthikulpanit (1):
      iommu/amd: Force device table to maximum size

Sven Eckelmann (11):
      batman-adv: dat: initialize orig_node of unfilled candidate slots
      batman-adv: fix skb leak when hard_iface is being released
      batman-adv: stop originator purge worker before freeing TT
      batman-adv: Limit number of aggregated packets directly
      batman-adv: tpmeter: fix u32 truncation of reported bytes
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

Takashi Iwai (6):
      ALSA: line6: Use guard() for spin locks
      ALSA: line6: Handle period elapsed calls outside the locks
      ALSA: hda: cs35l41: Use auto-cleanup for put_device()
      ALSA: synth: Use guard() for spin locks
      ALSA: emux: Fix UAF of soundfont zones at note-on
      ALSA: aloop: Use guard() for mutex locks

Tal Zussman (2):
      vhost-vdpa: fix pinned page leak in vhost_vdpa_pa_map() error path
      block: introduce bio_in_atomic()

Thomas Weißschuh (4):
      power: supply: core: add wakeup source inhibit by power_supply_config
      power: supply: bq27xxx_battery: register power supply with power_supply_register()
      power: supply: core: introduce power_supply_for_each_psy()
      power: supply: core: use power_supply_for_each_psy()

Thomas Zimmermann (1):
      drm/panic: Do not use un-escaped URL as format string

Thorsten Blum (4):
      hwrng: virtio - prevent use-after-free after a failed restore
      x86/boot: Fix off-by-one error in sme_clear_pgd()
      mfd: twl-core: Use i2c_check_functionality as boolean value
      crypto: omap - add omap_sham_unregister_algs helper

Tiezhu Yang (1):
      LoongArch: Fix one-shot limitation for perf hardware breakpoints

Til Kaiser (1):
      mlxsw: Initialize register query payloads

Tobias Schumacher (1):
      s390/pci: Add error cleanup in zpci_directed_irq_init()

Toke Høiland-Jørgensen (1):
      wifi: mac80211: reinstate IEEE80211_TX_CTL_AMPDU flag in ieee80211_tx_prep_agg()

Tom Verdonck (2):
      hwmon: (tmp102) Fix jiffies wraparound in conversion-ready check
      hwmon: (tmp108) Fix jiffies wraparound in conversion-ready check

Tvrtko Ursulin (1):
      drm/amdgpu: Use (v)memdup_array_user in amdgpu_cs_pass1

Vaibhav Nagare (1):
      bnxt_en: don't leave an XDP program installed when the open fails

Valentin Kindschi (2):
      Bluetooth: hci_sync: re-enable legacy advertising on resume
      Bluetooth: hci_sync: pause advertising for the scan address update

Vas Zayarskiy (1):
      hwmon: (aquacomputer_d5next) Avoid truncating scaled sensor readings

Vincent Donnefort (1):
      KVM: arm64: Fix MMFR0 TGRAN advertisement for pVMs

Vishnu Santhosh (1):
      dmaengine: qcom: bam_dma: Defer IRQ trigger type to device tree

Vladimir Zapolskiy (1):
      media: i2c: og01a1b: Switch from .s_stream to .enable_streams/.disable_streams

Vladyslav Tymoshchuk (1):
      ASoC: qcom: q6apm-dai: wrap the position of a full ring to 0

Wei Wang (1):
      arm64: suspend: Save and restore TPIDR2_EL0 across CPU suspend

Wei-Lin Chang (1):
      KVM: arm64: ptdump: Check the page tables aren't freed when accessing

Weibin Liu (1):
      spi: cadence-xspi: reject SDMA transfers larger than the requested length

Weigang He (1):
      wifi: mac80211: reload TDLS header pointer after skb_linearize()

Wentao Liang (4):
      ALSA: caiaq: free the EP4 URB when input setup fails
      drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()
      xen/gntdev: Fix gntdev_dmabuf ref leak in dmabuf_exp_wait_released()
      power: supply: ltc2941: Fix of_node reference leak in ltc294x_i2c_probe()

Xia Yan (2):
      veth: keep carrier off when resizing channels with a down peer
      ipv6: fix device binding after failed datagram connect

Yafang Shao (1):
      mm/migrate: snapshot the source nid before the misplaced migration

Yao Yiqi (1):
      fbcon: Retry rotated font allocation after failure

Yehyeong Lee (1):
      9p/xen: validate the response size from the backend

Yeoreum Yun (1):
      coresight/etm4: fix missing disable active config

Yi Cong (1):
      wifi: mt76: mt792x: fix negative errno truncation in offload capability

Yifei Gao (2):
      9p/xen: fix refcount leak in p9_xen_response() on wrong tag
      misc: fastrpc: fix double-free in fastrpc_map_attach() error path

Yilin Zhang (1):
      mptcp: do not use Fast Open on MP_JOIN subflows

Yingjie Wang (4):
      scsi: handle out-of-range SG_SET_TIMEOUT values
      scsi: bsg: Report synchronous data copyback failures
      ipv6: reject wrapped temporary address preferred lifetimes
      nvme-tcp: validate the TLS handshake timeout

Yitang Yang (1):
      ublk: add missing DEL_DEV_ASYNC to unprivileged permission check

Yizhou Zhao (2):
      net/9p/usbg: fix prefix matching in device lookup
      net/9p/usbg: Fix use-after-free in disable_usb9pfs()

Yongjian Wang (1):
      Revert "net: advertise TCP MSS from the configured MTU, not the learned PMTU"

Yu Zhang (1):
      ptp: fix use-after-free in extts_fifo_show() reading tsevqs unlocked

YuanZhe Liu (6):
      ALSA: us122l: Add missing NULL check in usb_stream_hwdep_mmap()
      ALSA: us122l: Fix NULL dereference at hwdep open and release
      ALSA: usx2y: Initialize idle URBs before submitting streams
      ALSA: hwdep: Serialize DSP load requests
      ALSA: bcd2000: Fix use-after-free of MIDI URBs on file close
      ALSA: usx2y: Refuse a retried DSP load after a failure

Yuanfu Xie (1):
      9p: don't decrement a server-owned zero nlink

Yuanhe Shu (1):
      scsi: target: Verify the iSCSI ISID is null-terminated

Yuansheng Yang (1):
      io_uring/rsrc: hold uring_lock across index-alloc put_user

Yuejie Shi (1):
      fs/ntfs3: validate the EA value length in ntfs_read_ea()

Yuho Choi (2):
      iommu/virtio: Reset device before deleting virtqueues on probe failure
      vdpa/snet: Don't discard the DPU error in snet_send_ctrl_msg()

Yun Zhou (1):
      net: erspan: set lltx to avoid sch_direct_xmit deadlock

Yunpeng Tian (1):
      udf: validate the device specification EA before using it

Yuto Ohnuki (1):
      virtiofs: add FUSE protocol validation

Zack Rusin (1):
      x86/vmware: Fix i386 high-bandwidth hypercall arguments

Zenghui Yu (Huawei) (1):
      mm/page_alloc: mark pages freed by __free_pages_core() as not tagged

Zhao Gongyi (2):
      arm64: mm: validate /dev/mem mmap ranges without overflow
      ata: libata-scsi: reject data-in commands with a data-out buffer

Zhao Zhang (1):
      9p: fix caches_show() out-of-bounds write

Zhaoyang Huang (1):
      mm: remove '!root_reclaim' checking in should_abort_scan()

Zhe Liu (1):
      blk-iocost: account flush sequence latency only once

Zhiling Zou (3):
      ipmr: drop packets with unknown ingress VIF
      ipmr: only copy pktinfo to cache reports
      mm/page_table_check: skip zero pages

Zhou Qiuyue (1):
      ipv6: raw: fix use-after-free in rawv6_send_hdrinc()

Zijing Yin (1):
      wifi: cfg80211: fix out-of-bounds read in valid_rule()

bui duc phuc (2):
      ALSA: core: Clean up file_operations definitions
      ASoC: stm: stm32_i2s: Drop redundant error messages

chenglong.ma (1):
      vduse: fix VA/PA confusion in the coherent page fault path

guolingxing (1):
      btrfs: sysfs: restore NOFS context on early return in btrfs_sysfs_add_block_group_type()

renpanpan (1):
      drm/amdgpu: Only enable HDMI audio if display supports it

yangge (1):
      mm: replace free hugepage folios after migration

