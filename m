Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365084;
	b=Aoga+NpgUm9litjQ5XEGiuix8AbMEM3bNwXV6TfC6PcR5U4f8FXTdtrWCtNnIRAitfow
	 +FKpvrPxu/iURAbBWNjzhiyiOtMTLxTdNuC7M8VRVWCPxjncGaTCgmiI7voMhIPhme5z2
	 N3RftI9Ft2GFt/WhrPASm7HOXMT4HSs8q4qlZJokW9VH5mZA+eo7mwWX9IDqDMcADsq4N
	 sEgR0sGT5YEcxgzXyRlSbix4dYYE9/F/dYS8Ubjwp+Z17TYrMBdjfqJZaeZfJ+pOCGO8H
	 hG/VunVB0tinJu0tLKsG7DsE0vsOZZ092jYJLPurT9Ipwx5T5bJsaBZpcPfSIlUFMGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365084;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YqwJjQo12odMj4YHyBvstWiZ+SZ6I2uzYByh2V/v1Ts=;
	b=tl+meJzYSbmy/hVyGLfXXT6220LhlbR6tu0lox/SHOaSKDiIlfoDVjbHnOtjwlDdXe/9
	 azPFfEJzSLJY1rwbmHPaDGYPV5bAFsZDfjKOWleieYzCGFoYeTjQDS80PJuEdqPFmR1LZ
	 7W0aFtyYiMvQp3ZorVu/WAWeXgSgeIUm5OV8OX3B9wzUTvmoQlGlCjz83skMt/eDtw7xS
	 gvhXqtAhawbZEbrelfbaD6/BZK0A+/wDbpXk8r1pj3ph1G2aG8gi6piMUmsVUr8bkX5Dh
	 n7a3gWHnqEzN02xagx93bzzZOfOHMRhK/rYPKxmpK9YLrlVahGNCH5M7yy+dkLMFHqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=II3dYURz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA0606A31A;
	Fri, 30 Oct 2026 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=II3dYURz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2DF1F00A16;
	Fri, 30 Oct 2026 12:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793365079;
	bh=YqwJjQo12odMj4YHyBvstWiZ+SZ6I2uzYByh2V/v1Ts=;
	h=From:To:Cc:Subject:Date;
	b=II3dYURzglDwiaXztpwQ06AFC8w/LZsyKnbT7d71j74eWueiol2PI/YArP2Zv8zcw
	 x1KwY3NOHJDQJvnxnveA7qg36KanMq5g8YHWXXEu54PCXTc4pESYSEO/vTZf0lq4Px
	 /dNN5KJVq86cQKbXxbxb7Jx51ssAf9wOrlUNC6fs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.191
Date: Fri, 30 Oct 2026 13:57:43 +0100
Message-ID: <2026103044-roman-unaudited-1277@gregkh>
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

I'm announcing the release of the 6.1.191 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 CREDITS                                                                 |    5 
 Documentation/arm64/silicon-errata.rst                                  |    2 
 Documentation/filesystems/index.rst                                     |    1 
 Documentation/filesystems/ntfs.rst                                      |  466 -
 Documentation/networking/ip-sysctl.rst                                  |    6 
 Documentation/networking/strparser.rst                                  |    2 
 Documentation/virt/kvm/api.rst                                          |    6 
 MAINTAINERS                                                             |   11 
 Makefile                                                                |   29 
 arch/alpha/include/asm/pgtable.h                                        |   33 
 arch/alpha/include/asm/tlbflush.h                                       |    4 
 arch/alpha/lib/Makefile                                                 |    1 
 arch/alpha/mm/Makefile                                                  |    4 
 arch/alpha/mm/tlbflush.c                                                |   96 
 arch/arm/mm/flush.c                                                     |    2 
 arch/arm64/Kconfig                                                      |   30 
 arch/arm64/include/asm/kvm_host.h                                       |    2 
 arch/arm64/kernel/Makefile                                              |    3 
 arch/arm64/kernel/cpu_errata.c                                          |   24 
 arch/arm64/kernel/cpufeature.c                                          |    2 
 arch/arm64/kernel/entry.S                                               |   22 
 arch/arm64/kernel/ptrace.c                                              |   50 
 arch/arm64/kernel/signal.c                                              |   25 
 arch/arm64/kernel/topology.c                                            |   11 
 arch/arm64/kvm/arch_timer.c                                             |    3 
 arch/arm64/kvm/arm.c                                                    |   18 
 arch/arm64/kvm/mmu.c                                                    |   25 
 arch/arm64/kvm/vgic/vgic-its.c                                          |    8 
 arch/arm64/kvm/vgic/vgic.c                                              |    9 
 arch/arm64/mm/fault.c                                                   |   15 
 arch/arm64/net/bpf_jit_comp.c                                           |    2 
 arch/arm64/tools/cpucaps                                                |    2 
 arch/loongarch/kernel/machine_kexec.c                                   |    5 
 arch/loongarch/kernel/module-sections.c                                 |   36 
 arch/loongarch/kernel/setup.c                                           |    1 
 arch/loongarch/kernel/smp.c                                             |  129 
 arch/loongarch/mm/hugetlbpage.c                                         |    3 
 arch/loongarch/net/bpf_jit.c                                            |    5 
 arch/mips/Kbuild                                                        |    6 
 arch/mips/include/asm/uasm.h                                            |    2 
 arch/mips/kernel/ftrace.c                                               |   25 
 arch/nios2/include/asm/checksum.h                                       |    2 
 arch/powerpc/include/asm/book3s/64/pgtable.h                            |   16 
 arch/powerpc/include/asm/xive.h                                         |    4 
 arch/powerpc/kernel/iommu.c                                             |    2 
 arch/powerpc/kernel/setup-common.c                                      |    1 
 arch/powerpc/kexec/ranges.c                                             |   12 
 arch/powerpc/mm/book3s64/pgtable.c                                      |   13 
 arch/powerpc/platforms/powernv/smp.c                                    |    8 
 arch/powerpc/platforms/pseries/iommu.c                                  |    3 
 arch/powerpc/platforms/pseries/smp.c                                    |    8 
 arch/powerpc/sysdev/xive/common.c                                       |   10 
 arch/riscv/include/asm/asm-prototypes.h                                 |    1 
 arch/riscv/include/asm/asm.h                                            |   23 
 arch/riscv/include/asm/processor.h                                      |    1 
 arch/riscv/include/asm/thread_info.h                                    |    4 
 arch/riscv/kernel/asm-offsets.c                                         |    6 
 arch/riscv/kernel/entry.S                                               |   79 
 arch/riscv/kernel/probes/kprobes_trampoline.S                           |    3 
 arch/riscv/kernel/traps.c                                               |   30 
 arch/riscv/kvm/vmid.c                                                   |    2 
 arch/s390/appldata/appldata_base.c                                      |  117 
 arch/s390/appldata/appldata_mem.c                                       |    2 
 arch/s390/include/asm/appldata.h                                        |    2 
 arch/s390/include/asm/cpu_mf.h                                          |   53 
 arch/s390/include/asm/dma.h                                             |    2 
 arch/s390/include/asm/nmi.h                                             |    3 
 arch/s390/kernel/cpcmd.c                                                |    2 
 arch/s390/kernel/dis.c                                                  |    2 
 arch/s390/kernel/nmi.c                                                  |    5 
 arch/s390/kernel/perf_cpum_sf.c                                         |   52 
 arch/s390/kernel/process.c                                              |    2 
 arch/s390/kvm/interrupt.c                                               |   24 
 arch/s390/kvm/kvm-s390.c                                                |    7 
 arch/s390/kvm/priv.c                                                    |    3 
 arch/s390/lib/spinlock.c                                                |    2 
 arch/s390/mm/fault.c                                                    |   15 
 arch/s390/mm/maccess.c                                                  |    2 
 arch/s390/pci/pci_sysfs.c                                               |    3 
 arch/sparc/kernel/Makefile                                              |    1 
 arch/sparc/lib/Makefile                                                 |    1 
 arch/sparc/mm/Makefile                                                  |    1 
 arch/sparc/prom/Makefile                                                |    1 
 arch/um/kernel/skas/syscall.c                                           |   34 
 arch/x86/events/amd/core.c                                              |   12 
 arch/x86/events/amd/lbr.c                                               |    3 
 arch/x86/events/intel/core.c                                            |   14 
 arch/x86/events/intel/ds.c                                              |   48 
 arch/x86/events/intel/uncore_snbep.c                                    |    5 
 arch/x86/events/perf_event.h                                            |   12 
 arch/x86/kernel/alternative.c                                           |   10 
 arch/x86/kernel/cpu/amd.c                                               |   11 
 arch/x86/kernel/cpu/mce/severity.c                                      |   12 
 arch/x86/kernel/cpu/resctrl/rdtgroup.c                                  |   13 
 arch/x86/kernel/ftrace.c                                                |    3 
 arch/x86/kvm/mmu/mmu.c                                                  |    4 
 arch/x86/kvm/svm/nested.c                                               |   34 
 arch/x86/kvm/svm/sev.c                                                  |   33 
 arch/x86/kvm/svm/svm.c                                                  |   24 
 arch/x86/kvm/vmx/nested.c                                               |    9 
 arch/x86/kvm/x86.c                                                      |    5 
 arch/x86/kvm/x86.h                                                      |    5 
 arch/x86/net/bpf_jit_comp.c                                             |    4 
 arch/x86/pci/fixup.c                                                    |   89 
 block/bfq-cgroup.c                                                      |   15 
 block/bfq-iosched.c                                                     |    8 
 block/bfq-iosched.h                                                     |    2 
 block/blk-cgroup.c                                                      |   18 
 block/blk-cgroup.h                                                      |    2 
 block/blk-core.c                                                        |    1 
 block/blk-iocost.c                                                      |   25 
 block/blk-iolatency.c                                                   |   19 
 block/blk-mq.c                                                          |   28 
 block/blk-rq-qos.c                                                      |    2 
 block/blk-rq-qos.h                                                      |   18 
 block/blk-throttle.c                                                    |   13 
 block/blk-wbt.c                                                         |    2 
 block/ioprio.c                                                          |    7 
 crypto/Kconfig                                                          |    1 
 crypto/af_alg.c                                                         |    2 
 crypto/algif_skcipher.c                                                 |    8 
 crypto/asymmetric_keys/restrict.c                                       |    8 
 crypto/drbg.c                                                           |   11 
 crypto/jitterentropy-kcapi.c                                            |  191 
 crypto/jitterentropy.c                                                  |  145 
 crypto/jitterentropy.h                                                  |   10 
 drivers/acpi/acpi_tad.c                                                 |  180 
 drivers/acpi/battery.c                                                  |    8 
 drivers/acpi/bus.c                                                      |   54 
 drivers/acpi/processor_idle.c                                           |    4 
 drivers/android/binder.c                                                |    3 
 drivers/ata/libata-core.c                                               |    5 
 drivers/ata/libata-eh.c                                                 |    6 
 drivers/ata/libata-scsi.c                                               |   93 
 drivers/ata/libata.h                                                    |    2 
 drivers/ata/sata_dwc_460ex.c                                            |    9 
 drivers/base/core.c                                                     |   38 
 drivers/block/drbd/drbd_receiver.c                                      |    3 
 drivers/block/loop.c                                                    |   40 
 drivers/block/nbd.c                                                     |    1 
 drivers/block/null_blk/main.c                                           |   16 
 drivers/block/ublk_drv.c                                                |    4 
 drivers/block/zram/zram_drv.c                                           |   21 
 drivers/bluetooth/btintel.c                                             |   15 
 drivers/bluetooth/btqcomsmd.c                                           |   10 
 drivers/bluetooth/btusb.c                                               |    4 
 drivers/bus/mhi/ep/ring.c                                               |   12 
 drivers/bus/mhi/host/pci_generic.c                                      |   20 
 drivers/char/hw_random/core.c                                           |  153 
 drivers/char/hw_random/stm32-rng.c                                      |   12 
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c                                  |   64 
 drivers/clocksource/samsung_pwm_timer.c                                 |   22 
 drivers/cpufreq/amd-pstate.c                                            |    7 
 drivers/crypto/hisilicon/qm.c                                           |   38 
 drivers/crypto/keembay/keembay-ocs-aes-core.c                           |    4 
 drivers/crypto/qat/qat_common/adf_init.c                                |   14 
 drivers/crypto/stm32/stm32-cryp.c                                       |    8 
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c                     |   91 
 drivers/crypto/virtio/virtio_crypto_skcipher_algs.c                     |   13 
 drivers/cxl/core/hdm.c                                                  |   48 
 drivers/cxl/core/mbox.c                                                 |   15 
 drivers/cxl/core/port.c                                                 |   23 
 drivers/cxl/core/region.c                                               |   29 
 drivers/cxl/cxl.h                                                       |    3 
 drivers/dma-buf/dma-buf.c                                               |   15 
 drivers/dma-buf/dma-heap.c                                              |   80 
 drivers/dma-buf/udmabuf.c                                               |   11 
 drivers/dma/dmaengine.c                                                 |   30 
 drivers/dma/dw-edma/dw-edma-core.c                                      |   90 
 drivers/dma/dw-edma/dw-edma-pcie.c                                      |    3 
 drivers/dma/dw-edma/dw-edma-v0-core.c                                   |   17 
 drivers/dma/idxd/init.c                                                 |   36 
 drivers/dma/ti/k3-udma-glue.c                                           |   15 
 drivers/dma/xilinx/xilinx_dma.c                                         |   14 
 drivers/edac/amd64_edac.c                                               |    2 
 drivers/edac/igen6_edac.c                                               |    6 
 drivers/firewire/core-topology.c                                        |   40 
 drivers/firmware/arm_ffa/driver.c                                       |    4 
 drivers/firmware/arm_scmi/bus.c                                         |  430 +
 drivers/firmware/arm_scmi/common.h                                      |   66 
 drivers/firmware/arm_scmi/driver.c                                      |  688 +-
 drivers/firmware/arm_scmi/mailbox.c                                     |   22 
 drivers/firmware/arm_scmi/optee.c                                       |    6 
 drivers/firmware/arm_scmi/smc.c                                         |   18 
 drivers/firmware/arm_scmi/virtio.c                                      |    4 
 drivers/firmware/efi/mokvar-table.c                                     |   42 
 drivers/gpio/gpio-exar.c                                                |    2 
 drivers/gpio/gpio-mvebu.c                                               |    6 
 drivers/gpio/gpio-mxc.c                                                 |  159 
 drivers/gpio/gpio-pca953x.c                                             |   18 
 drivers/gpio/gpio-xilinx.c                                              |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                                     |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c                                 |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                              |   27 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                              |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                        |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c                            |   30 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h                            |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c                                |   79 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                  |   42 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c                                 |   73 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h                                 |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                             |  106 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                              |   55 
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                           |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c                             |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                 |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c                               |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                                 |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c                                 |   54 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h                                 |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                                 |   18 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                                 |   46 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h                                 |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                 |   33 
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c                                 |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c                                 |  137 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                                 |   39 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                                  |  150 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h                                  |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c                            |   20 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                                   |    9 
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c                                  |   25 
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c                                  |   24 
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c                                   |   20 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                                   |   24 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c                                  |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c                                  |    2 
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c                                  |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c                                  |    1 
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c                                  |    8 
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c                                  |    8 
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c                                  |   14 
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c                                |   14 
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c                                   |    8 
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c                                  |   25 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                                  |   23 
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                                   |    2 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c                                   |    2 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c                                   |    4 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                                   |    3 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                   |   62 
 drivers/gpu/drm/amd/amdgpu/vi.c                                         |   21 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                |   13 
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c                                   |   17 
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                                 |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                   |   14 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h                   |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c                                |   56 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                                   |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                  |   24 
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c                             |   21 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                               |   11 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                       |   41 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h                       |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c                  |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c                  |   10 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h                  |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c                 |   15 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c          |    2 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                |   19 
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c                        |   14 
 drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c                      |    3 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                       |    2 
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                            |   40 
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h                            |    3 
 drivers/gpu/drm/amd/display/dc/dc_link.h                                |    3 
 drivers/gpu/drm/amd/display/dc/dc_types.h                               |    2 
 drivers/gpu/drm/amd/display/dc/dce/Makefile                             |    2 
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c                           |  258 
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c                       |  286 
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h                       |   46 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c             |    5 
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c                 |    5 
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c                   |    1 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c               |    4 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c                     |    3 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c                       |    3 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c                      |   17 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c                   |   12 
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c                 |    4 
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c                      |   24 
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c                   |    3 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c                      |    4 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c                     |    7 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c                       |    7 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c                   |    7 
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c                 |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c                  |   10 
 drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c                  |   10 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c                    |   10 
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c                  |   10 
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h                             |    4 
 drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c                     |    5 
 drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c                  |    3 
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h                         |   18 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                                      |    2 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                              |   39 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c                     |   10 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c                   |   11 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                    |    7 
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c                                 |    5 
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c                            |   22 
 drivers/gpu/drm/display/drm_dp_helper.c                                 |    4 
 drivers/gpu/drm/drm_fb_helper.c                                         |    8 
 drivers/gpu/drm/etnaviv/etnaviv_sched.c                                 |   13 
 drivers/gpu/drm/gud/gud_pipe.c                                          |    1 
 drivers/gpu/drm/i915/display/icl_dsi.c                                  |    4 
 drivers/gpu/drm/i915/display/intel_bios.c                               |   36 
 drivers/gpu/drm/i915/display/intel_dmc.c                                |   21 
 drivers/gpu/drm/i915/display/intel_dp.c                                 |    8 
 drivers/gpu/drm/i915/display/intel_hdcp.c                               |   14 
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c                          |    2 
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c                    |   34 
 drivers/gpu/drm/i915/gt/intel_rps.c                                     |    3 
 drivers/gpu/drm/lima/lima_sched.c                                       |   13 
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c                                 |    3 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                                 |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h                        |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c                    |   33 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c                    |   35 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c                     |   11 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c                       |    4 
 drivers/gpu/drm/msm/msm_gem_submit.c                                    |    3 
 drivers/gpu/drm/msm/msm_gpu.c                                           |   31 
 drivers/gpu/drm/msm/msm_ringbuffer.c                                    |   22 
 drivers/gpu/drm/msm/msm_ringbuffer.h                                    |    1 
 drivers/gpu/drm/nouveau/include/nvkm/core/client.h                      |    1 
 drivers/gpu/drm/nouveau/nouveau_chan.c                                  |    9 
 drivers/gpu/drm/nouveau/nouveau_gem.c                                   |   11 
 drivers/gpu/drm/nouveau/nvkm/core/client.c                              |    1 
 drivers/gpu/drm/nouveau/nvkm/core/object.c                              |   26 
 drivers/gpu/drm/panfrost/panfrost_job.c                                 |   16 
 drivers/gpu/drm/panfrost/panfrost_mmu.c                                 |   13 
 drivers/gpu/drm/radeon/radeon_bios.c                                    |    6 
 drivers/gpu/drm/radeon/radeon_fb.c                                      |    9 
 drivers/gpu/drm/radeon/radeon_gem.c                                     |    4 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                            |    4 
 drivers/gpu/drm/scheduler/sched_main.c                                  |   33 
 drivers/gpu/drm/tegra/gr2d.c                                            |    8 
 drivers/gpu/drm/tegra/gr3d.c                                            |    8 
 drivers/gpu/drm/tiny/simpledrm.c                                        |   10 
 drivers/gpu/drm/v3d/v3d_sched.c                                         |  106 
 drivers/gpu/drm/vc4/vc4_bo.c                                            |   13 
 drivers/gpu/drm/vc4/vc4_drv.c                                           |    5 
 drivers/gpu/drm/vc4/vc4_hvs.c                                           |    2 
 drivers/gpu/drm/vc4/vc4_v3d.c                                           |   10 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                                 |    6 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                                     |   22 
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c                                     |    2 
 drivers/hid/hid-alps.c                                                  |   21 
 drivers/hid/hid-core.c                                                  |   38 
 drivers/hid/hid-logitech-hidpp.c                                        |   27 
 drivers/hid/hid-mcp2221.c                                               |   17 
 drivers/hid/hid-nintendo.c                                              |   46 
 drivers/hid/hid-sony.c                                                  |   36 
 drivers/hid/hid-steam.c                                                 |  243 
 drivers/hid/i2c-hid/i2c-hid-core.c                                      |    7 
 drivers/hid/intel-ish-hid/ishtp/bus.c                                   |    2 
 drivers/hid/intel-ish-hid/ishtp/client.c                                |    4 
 drivers/hid/uhid.c                                                      |    8 
 drivers/hid/usbhid/hid-core.c                                           |   11 
 drivers/hv/channel_mgmt.c                                               |   12 
 drivers/hv/connection.c                                                 |    1 
 drivers/hv/vmbus_drv.c                                                  |   16 
 drivers/hwmon/drivetemp.c                                               |   10 
 drivers/hwmon/lm90.c                                                    |   26 
 drivers/hwmon/pmbus/pmbus_core.c                                        |   60 
 drivers/hwmon/pwm-fan.c                                                 |   13 
 drivers/hwmon/sht3x.c                                                   |    9 
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c                     |   15 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                      |   83 
 drivers/hwtracing/coresight/coresight-platform.c                        |   48 
 drivers/hwtracing/coresight/coresight-syscfg.c                          |    2 
 drivers/i2c/busses/i2c-at91-master.c                                    |    8 
 drivers/i2c/busses/i2c-mxs.c                                            |    5 
 drivers/i2c/busses/i2c-qcom-cci.c                                       |    4 
 drivers/i2c/busses/i2c-wmt.c                                            |    2 
 drivers/i2c/i2c-core-base.c                                             |   14 
 drivers/i3c/master.c                                                    |   58 
 drivers/i3c/master/mipi-i3c-hci/core.c                                  |    2 
 drivers/i3c/master/mipi-i3c-hci/dma.c                                   |   29 
 drivers/i3c/master/mipi-i3c-hci/hci.h                                   |    1 
 drivers/iio/accel/kxcjk-1013.c                                          |    2 
 drivers/iio/accel/sca3000.c                                             |    2 
 drivers/iio/accel/st_accel_core.c                                       |   10 
 drivers/iio/adc/ad_sigma_delta.c                                        |   26 
 drivers/iio/adc/aspeed_adc.c                                            |   13 
 drivers/iio/adc/axp288_adc.c                                            |    8 
 drivers/iio/adc/max1363.c                                               |    8 
 drivers/iio/adc/stm32-adc.c                                             |    9 
 drivers/iio/adc/sun4i-gpadc-iio.c                                       |   10 
 drivers/iio/adc/xilinx-xadc-core.c                                      |    9 
 drivers/iio/cdc/ad7150.c                                                |    8 
 drivers/iio/common/st_sensors/st_sensors_core.c                         |   72 
 drivers/iio/common/st_sensors/st_sensors_trigger.c                      |   20 
 drivers/iio/frequency/admv1013.c                                        |    2 
 drivers/iio/gyro/adis16136.c                                            |    2 
 drivers/iio/imu/adis16400.c                                             |    2 
 drivers/iio/imu/adis16480.c                                             |    4 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c                            |   18 
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c                            |   65 
 drivers/iio/industrialio-buffer.c                                       |    5 
 drivers/iio/industrialio-trigger.c                                      |    2 
 drivers/iio/light/gp2ap020a00f.c                                        |    2 
 drivers/iio/light/ltrf216a.c                                            |   13 
 drivers/iio/pressure/bmp280-core.c                                      |    2 
 drivers/iio/pressure/dps310.c                                           |    2 
 drivers/iio/proximity/isl29501.c                                        |    2 
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c                       |    4 
 drivers/iio/proximity/sx9324.c                                          |    2 
 drivers/iio/proximity/vcnl3020.c                                        |   24 
 drivers/infiniband/core/counters.c                                      |    9 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                |    2 
 drivers/infiniband/hw/cxgb4/mem.c                                       |   46 
 drivers/infiniband/hw/erdma/erdma_cm.c                                  |    6 
 drivers/infiniband/hw/erdma/erdma_eq.c                                  |    3 
 drivers/infiniband/hw/erdma/erdma_verbs.c                               |   23 
 drivers/infiniband/hw/erdma/erdma_verbs.h                               |   15 
 drivers/infiniband/hw/hns/hns_roce_cq.c                                 |    6 
 drivers/infiniband/hw/hns/hns_roce_device.h                             |    1 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                              |  130 
 drivers/infiniband/hw/hns/hns_roce_main.c                               |    5 
 drivers/infiniband/hw/hns/hns_roce_mr.c                                 |    6 
 drivers/infiniband/hw/hns/hns_roce_srq.c                                |    2 
 drivers/infiniband/hw/irdma/hw.c                                        |    7 
 drivers/infiniband/hw/irdma/main.h                                      |    3 
 drivers/infiniband/hw/irdma/utils.c                                     |   12 
 drivers/infiniband/hw/irdma/verbs.c                                     |   21 
 drivers/infiniband/hw/mlx5/cq.c                                         |   11 
 drivers/infiniband/hw/mlx5/main.c                                       |   55 
 drivers/infiniband/hw/mlx5/mlx5_ib.h                                    |   35 
 drivers/infiniband/hw/mlx5/mr.c                                         |  385 -
 drivers/infiniband/hw/mlx5/odp.c                                        |   59 
 drivers/infiniband/hw/mlx5/umr.c                                        |   87 
 drivers/infiniband/sw/rdmavt/vt.c                                       |    4 
 drivers/infiniband/sw/rxe/rxe_qp.c                                      |    9 
 drivers/infiniband/sw/rxe/rxe_srq.c                                     |    7 
 drivers/infiniband/sw/siw/siw_cm.c                                      |   48 
 drivers/infiniband/sw/siw/siw_qp_tx.c                                   |    2 
 drivers/input/keyboard/atkbd.c                                          |    8 
 drivers/input/keyboard/lkkbd.c                                          |    2 
 drivers/input/mouse/alps.c                                              |    2 
 drivers/input/mouse/synaptics.c                                         |    7 
 drivers/input/serio/i8042-acpipnpio.h                                   |    9 
 drivers/input/touchscreen/s6sy761.c                                     |   14 
 drivers/interconnect/core.c                                             |   16 
 drivers/iommu/amd/iommu.c                                               |   43 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                             |   46 
 drivers/iommu/intel/dmar.c                                              |   22 
 drivers/iommu/intel/iommu.c                                             |   28 
 drivers/iommu/intel/iommu.h                                             |    6 
 drivers/iommu/intel/pasid.c                                             |   22 
 drivers/iommu/msm_iommu.c                                               |    9 
 drivers/leds/leds-an30259a.c                                            |   14 
 drivers/mailbox/arm_mhu.c                                               |    1 
 drivers/mailbox/arm_mhu_db.c                                            |    1 
 drivers/mailbox/hi3660-mailbox.c                                        |    1 
 drivers/mailbox/hi6220-mailbox.c                                        |    1 
 drivers/mailbox/imx-mailbox.c                                           |    3 
 drivers/mailbox/mailbox-mpfs.c                                          |    1 
 drivers/mailbox/mailbox.c                                               |    1 
 drivers/mailbox/mtk-adsp-mailbox.c                                      |    3 
 drivers/mailbox/mtk-cmdq-mailbox.c                                      |    2 
 drivers/mailbox/omap-mailbox.c                                          |    2 
 drivers/mailbox/platform_mhu.c                                          |    1 
 drivers/mailbox/rockchip-mailbox.c                                      |    2 
 drivers/mailbox/sprd-mailbox.c                                          |    2 
 drivers/mailbox/stm32-ipcc.c                                            |    1 
 drivers/mailbox/tegra-hsp.c                                             |    1 
 drivers/mailbox/zynqmp-ipi-mailbox.c                                    |  137 
 drivers/md/dm-bio-prison-v1.c                                           |    6 
 drivers/md/dm-bufio.c                                                   |   30 
 drivers/md/dm-cache-metadata.c                                          |    7 
 drivers/md/dm-cache-target.c                                            |  129 
 drivers/md/dm-crypt.c                                                   |   17 
 drivers/md/dm-ebs-target.c                                              |    5 
 drivers/md/dm-era-target.c                                              |   58 
 drivers/md/dm-exception-store.h                                         |   44 
 drivers/md/dm-integrity.c                                               |    5 
 drivers/md/dm-io.c                                                      |   24 
 drivers/md/dm-ioctl.c                                                   |   99 
 drivers/md/dm-kcopyd.c                                                  |   20 
 drivers/md/dm-log.c                                                     |   24 
 drivers/md/dm-mpath.c                                                   |   33 
 drivers/md/dm-path-selector.h                                           |   27 
 drivers/md/dm-ps-queue-length.c                                         |    4 
 drivers/md/dm-ps-round-robin.c                                          |   13 
 drivers/md/dm-ps-service-time.c                                         |    8 
 drivers/md/dm-raid.c                                                    |   12 
 drivers/md/dm-raid1.c                                                   |   46 
 drivers/md/dm-region-hash.c                                             |    6 
 drivers/md/dm-snap-persistent.c                                         |    8 
 drivers/md/dm-snap-transient.c                                          |    8 
 drivers/md/dm-snap.c                                                    |   27 
 drivers/md/dm-table.c                                                   |    2 
 drivers/md/dm-thin-metadata.c                                           |   20 
 drivers/md/dm-thin.c                                                    |   24 
 drivers/md/dm-uevent.c                                                  |    2 
 drivers/md/dm-verity-fec.c                                              |    4 
 drivers/md/dm.c                                                         |   12 
 drivers/md/dm.h                                                         |   12 
 drivers/md/md-cluster.c                                                 |   11 
 drivers/md/md.c                                                         |    3 
 drivers/md/persistent-data/dm-array.c                                   |   37 
 drivers/md/persistent-data/dm-block-manager.c                           |    6 
 drivers/md/persistent-data/dm-btree.c                                   |    6 
 drivers/md/raid1.c                                                      |   12 
 drivers/md/raid10.c                                                     |   72 
 drivers/md/raid5.c                                                      |   12 
 drivers/media/common/videobuf2/videobuf2-dma-sg.c                       |    1 
 drivers/media/pci/ivtv/ivtvfb.c                                         |    4 
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c                    |    5 
 drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c          |    9 
 drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c              |    5 
 drivers/media/platform/verisilicon/hantro.h                             |    2 
 drivers/media/platform/verisilicon/hantro_drv.c                         |   89 
 drivers/media/platform/verisilicon/imx8m_vpu_hw.c                       |    8 
 drivers/media/test-drivers/vivid/vivid-core.c                           |    4 
 drivers/media/v4l2-core/v4l2-mem2mem.c                                  |   23 
 drivers/memstick/core/memstick.c                                        |    8 
 drivers/memstick/host/rtsx_usb_ms.c                                     |   31 
 drivers/mfd/sm501.c                                                     |   18 
 drivers/misc/habanalabs/common/habanalabs.h                             |    5 
 drivers/misc/habanalabs/common/memory.c                                 |  190 
 drivers/misc/habanalabs/gaudi/gaudi.c                                   |   19 
 drivers/misc/habanalabs/gaudi2/gaudi2.c                                 |    7 
 drivers/misc/sgi-gru/grufault.c                                         |  101 
 drivers/misc/sgi-gru/gruprocfs.c                                        |    1 
 drivers/misc/sgi-gru/grutables.h                                        |    1 
 drivers/mmc/host/cavium-octeon.c                                        |    5 
 drivers/mmc/host/cavium-thunderx.c                                      |    5 
 drivers/mmc/host/mtk-sd.c                                               |    1 
 drivers/mmc/host/sdhci-sprd.c                                           |    4 
 drivers/mmc/host/via-sdmmc.c                                            |    4 
 drivers/mtd/devices/block2mtd.c                                         |    2 
 drivers/mtd/maps/vmu-flash.c                                            |   12 
 drivers/mtd/mtdcore.c                                                   |  122 
 drivers/mtd/mtdcore.h                                                   |    1 
 drivers/mtd/mtdpart.c                                                   |   14 
 drivers/mtd/nand/raw/cadence-nand-controller.c                          |    6 
 drivers/mtd/nand/raw/vf610_nfc.c                                        |   85 
 drivers/mtd/nand/spi/core.c                                             |   37 
 drivers/net/amt.c                                                       |   51 
 drivers/net/bonding/bond_main.c                                         |   70 
 drivers/net/can/dev/skb.c                                               |    2 
 drivers/net/can/usb/gs_usb.c                                            |  159 
 drivers/net/dsa/b53/b53_common.c                                        |    8 
 drivers/net/dsa/microchip/ksz_common.h                                  |    2 
 drivers/net/ethernet/amazon/ena/ena_com.c                               |   25 
 drivers/net/ethernet/amazon/ena/ena_com.h                               |   14 
 drivers/net/ethernet/amazon/ena/ena_eth_com.c                           |   37 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                            |    3 
 drivers/net/ethernet/amazon/ena/ena_regs_defs.h                         |    1 
 drivers/net/ethernet/broadcom/bcmsysport.c                              |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                               |   70 
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                               |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                           |    2 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                          |   15 
 drivers/net/ethernet/brocade/bna/bnad.c                                 |   16 
 drivers/net/ethernet/cavium/liquidio/lio_main.c                         |   27 
 drivers/net/ethernet/cavium/liquidio/octeon_device.h                    |    3 
 drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c                   |   33 
 drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c          |    4 
 drivers/net/ethernet/freescale/enetc/enetc.c                            |    3 
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c                    |   10 
 drivers/net/ethernet/ibm/ibmveth.c                                      |   79 
 drivers/net/ethernet/ibm/ibmveth.h                                      |    1 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c                          |   31 
 drivers/net/ethernet/intel/ice/ice.h                                    |    2 
 drivers/net/ethernet/intel/ice/ice_eswitch.c                            |    2 
 drivers/net/ethernet/intel/ice/ice_lib.c                                |   18 
 drivers/net/ethernet/intel/ice/ice_main.c                               |   66 
 drivers/net/ethernet/intel/ice/ice_ptp.c                                |   70 
 drivers/net/ethernet/intel/ice/ice_ptp.h                                |    8 
 drivers/net/ethernet/intel/ice/ice_txrx.c                               |    6 
 drivers/net/ethernet/intel/ice/ice_xsk.c                                |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                           |    3 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                         |   12 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h                         |    1 
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c                         |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                         |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c                     |   79 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                     |   22 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                     |   69 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c                    |   20 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                             |    2 
 drivers/net/ethernet/mellanox/mlx4/srq.c                                |   14 
 drivers/net/ethernet/mellanox/mlx5/core/cq.c                            |   23 
 drivers/net/ethernet/mellanox/mlx5/core/en.h                            |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c              |   10 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h                    |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c                        |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c           |   16 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                       |   38 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                         |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c                      |    9 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                         |    4 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                       |   13 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                       |    4 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c              |   30 
 drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c                     |   17 
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c                   |    3 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                       |   12 
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h                     |    3 
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c                       |    3 
 drivers/net/ethernet/mellanox/mlx5/core/port.c                          |    4 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c              |   28 
 drivers/net/ethernet/mellanox/mlx5/core/vport.c                         |   78 
 drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c                |   18 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c                   |    2 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.h                   |    4 
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c                     |    1 
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h                     |    1 
 drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c                   |    1 
 drivers/net/ethernet/microsoft/mana/mana_en.c                           |   13 
 drivers/net/ethernet/mscc/ocelot_stats.c                                |    2 
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c                        |  445 -
 drivers/net/ethernet/renesas/ravb_main.c                                |    8 
 drivers/net/ethernet/renesas/ravb_ptp.c                                 |   37 
 drivers/net/ethernet/sfc/ef100_netdev.c                                 |    6 
 drivers/net/ethernet/sfc/ef100_nic.c                                    |   47 
 drivers/net/ethernet/stmicro/stmmac/common.h                            |   56 
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c                       |   15 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c                        |   15 
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c                         |   15 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c                      |   15 
 drivers/net/ethernet/stmicro/stmmac/stmmac.h                            |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c                    |  129 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                       |  191 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c                        |    8 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                         |   18 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                                |    4 
 drivers/net/gtp.c                                                       |   18 
 drivers/net/hyperv/netvsc.c                                             |   20 
 drivers/net/ieee802154/mac802154_hwsim.c                                |    9 
 drivers/net/phy/phy_device.c                                            |   19 
 drivers/net/tap.c                                                       |   55 
 drivers/net/team/team.c                                                 |  161 
 drivers/net/team/team_mode_loadbalance.c                                |    4 
 drivers/net/thunderbolt.c                                               |   12 
 drivers/net/usb/ax88179_178a.c                                          |    6 
 drivers/net/usb/qmi_wwan.c                                              |    1 
 drivers/net/vxlan/vxlan_core.c                                          |   44 
 drivers/net/vxlan/vxlan_private.h                                       |    4 
 drivers/net/wireguard/noise.c                                           |    7 
 drivers/net/wireguard/queueing.h                                        |    2 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                 |   10 
 drivers/net/wireless/ath/ath11k/mac.c                                   |    1 
 drivers/net/wireless/ath/ath11k/mhi.c                                   |    6 
 drivers/net/wireless/ath/ath11k/pci.c                                   |    7 
 drivers/net/wireless/ath/ath11k/wmi.c                                   |   29 
 drivers/net/wireless/ath/wcn36xx/dxe.c                                  |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c                 |   27 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c                  |    4 
 drivers/net/wireless/intel/iwlegacy/3945-mac.c                          |    1 
 drivers/net/wireless/intel/iwlwifi/dvm/main.c                           |    4 
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c                        |   28 
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h                          |    3 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                             |   18 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                             |   47 
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c                            |    9 
 drivers/net/wireless/intersil/p54/fwio.c                                |   42 
 drivers/net/wireless/marvell/libertas/tx.c                              |    7 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c                    |    4 
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c                     |    5 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                      |   33 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h                      |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                        |    9 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                        |   17 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                         |   15 
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                      |    3 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                        |    8 
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                      |    2 
 drivers/net/wireless/mediatek/mt76/tx.c                                 |    1 
 drivers/net/wireless/microchip/wilc1000/wlan_cfg.c                      |   37 
 drivers/net/wireless/microchip/wilc1000/wlan_cfg.h                      |    5 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c                   |   19 
 drivers/net/wireless/realtek/rtw88/debug.c                              |  303 
 drivers/net/wireless/realtek/rtw88/debug.h                              |    2 
 drivers/net/wireless/realtek/rtw88/main.c                               |   20 
 drivers/net/wireless/realtek/rtw88/main.h                               |    3 
 drivers/net/wireless/realtek/rtw89/core.c                               |    8 
 drivers/net/wireless/realtek/rtw89/mac80211.c                           |    9 
 drivers/net/wireless/realtek/rtw89/pci.c                                |    7 
 drivers/net/wireless/silabs/wfx/hif_tx.c                                |    4 
 drivers/net/wireless/st/cw1200/bh.c                                     |    8 
 drivers/net/wireless/st/cw1200/txrx.c                                   |   14 
 drivers/net/wireless/ti/wl12xx/main.c                                   |    6 
 drivers/net/wireless/ti/wl18xx/main.c                                   |    2 
 drivers/net/wireless/ti/wlcore/main.c                                   |   10 
 drivers/net/wireless/ti/wlcore/wlcore.h                                 |    2 
 drivers/net/xen-netfront.c                                              |   16 
 drivers/ntb/ntb_transport.c                                             |   18 
 drivers/nvdimm/nd_virtio.c                                              |   32 
 drivers/nvdimm/virtio_pmem.h                                            |    2 
 drivers/nvme/host/apple.c                                               |   38 
 drivers/nvme/host/core.c                                                |    3 
 drivers/nvme/host/fabrics.c                                             |    8 
 drivers/nvme/host/fc.c                                                  |    7 
 drivers/nvme/host/multipath.c                                           |    5 
 drivers/nvme/host/pci.c                                                 |   18 
 drivers/nvme/host/rdma.c                                                |    8 
 drivers/nvme/host/tcp.c                                                 |   33 
 drivers/nvme/target/admin-cmd.c                                         |   31 
 drivers/nvme/target/auth.c                                              |   20 
 drivers/nvme/target/configfs.c                                          |    9 
 drivers/nvme/target/core.c                                              |   94 
 drivers/nvme/target/discovery.c                                         |   37 
 drivers/nvme/target/fabrics-cmd-auth.c                                  |  100 
 drivers/nvme/target/fabrics-cmd.c                                       |   56 
 drivers/nvme/target/nvmet.h                                             |   23 
 drivers/nvme/target/rdma.c                                              |    1 
 drivers/nvme/target/tcp.c                                               |    8 
 drivers/of/irq.c                                                        |   14 
 drivers/of/overlay.c                                                    |   17 
 drivers/of/unittest.c                                                   |    7 
 drivers/opp/core.c                                                      |    6 
 drivers/pci/controller/dwc/pcie-designware-ep.c                         |   20 
 drivers/pci/endpoint/functions/pci-epf-ntb.c                            |    5 
 drivers/pci/endpoint/functions/pci-epf-test.c                           |   16 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                           |    5 
 drivers/pci/hotplug/pnv_php.c                                           |    2 
 drivers/pci/hotplug/rpaphp_slot.c                                       |    2 
 drivers/pci/pci-driver.c                                                |  189 
 drivers/pci/pci-sysfs.c                                                 |  125 
 drivers/pci/pci.c                                                       |   20 
 drivers/pci/pci.h                                                       |   43 
 drivers/pci/rebar.c                                                     |   19 
 drivers/pci/search.c                                                    |    4 
 drivers/pci/setup-bus.c                                                 |   56 
 drivers/pci/slot.c                                                      |   46 
 drivers/perf/riscv_pmu_legacy.c                                         |    5 
 drivers/perf/riscv_pmu_sbi.c                                            |  103 
 drivers/phy/qualcomm/phy-qcom-qusb2.c                                   |   16 
 drivers/pinctrl/core.c                                                  |    3 
 drivers/pinctrl/core.h                                                  |    1 
 drivers/pinctrl/freescale/pinctrl-scu.c                                 |    3 
 drivers/pinctrl/mediatek/pinctrl-moore.c                                |    6 
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c                           |   14 
 drivers/pinctrl/mediatek/pinctrl-paris.c                                |    7 
 drivers/pinctrl/pinctrl-amd.c                                           |    9 
 drivers/pinctrl/pinmux.c                                                |  175 
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                                   |   88 
 drivers/pinctrl/sunxi/pinctrl-sunxi.h                                   |    7 
 drivers/platform/x86/amd/pmc.c                                          |   26 
 drivers/platform/x86/asus-wmi.c                                         |    6 
 drivers/platform/x86/dell/dell-laptop.c                                 |   28 
 drivers/platform/x86/dell/dell-smbios-base.c                            |   25 
 drivers/platform/x86/dell/dell-smbios.h                                 |    5 
 drivers/platform/x86/dell/dell-wmi-base.c                               |    2 
 drivers/platform/x86/huawei-wmi.c                                       |    4 
 drivers/platform/x86/intel/int1092/intel_sar.c                          |   39 
 drivers/platform/x86/lg-laptop.c                                        |   26 
 drivers/platform/x86/system76_acpi.c                                    |    4 
 drivers/platform/x86/thinkpad_acpi.c                                    |    4 
 drivers/platform/x86/toshiba_acpi.c                                     |    4 
 drivers/platform/x86/x86-android-tablets.c                              |    6 
 drivers/power/supply/charger-manager.c                                  |   60 
 drivers/power/supply/ds2780_battery.c                                   |    2 
 drivers/power/supply/lp8788-charger.c                                   |   29 
 drivers/power/supply/max17040_battery.c                                 |   37 
 drivers/power/supply/rt9455_charger.c                                   |   26 
 drivers/ptp/ptp_ocp.c                                                   |    3 
 drivers/ptp/ptp_private.h                                               |    1 
 drivers/ptp/ptp_sysfs.c                                                 |    2 
 drivers/pwm/pwm-samsung.c                                               |   22 
 drivers/regulator/ltc3676.c                                             |   15 
 drivers/remoteproc/qcom_wcnss.c                                         |   23 
 drivers/rtc/dev.c                                                       |    2 
 drivers/rtc/rtc-mpfs.c                                                  |    6 
 drivers/rtc/rtc-rzn1.c                                                  |   16 
 drivers/rtc/rtc-spear.c                                                 |   11 
 drivers/s390/block/dasd_diag.c                                          |    2 
 drivers/s390/block/dasd_eckd.c                                          |   15 
 drivers/s390/block/dasd_fba.c                                           |    2 
 drivers/s390/block/dcssblk.c                                            |    2 
 drivers/s390/char/con3215.c                                             |    2 
 drivers/s390/char/monwriter.c                                           |    2 
 drivers/s390/cio/vfio_ccw_cp.c                                          |   13 
 drivers/s390/cio/vfio_ccw_cp.h                                          |    8 
 drivers/s390/crypto/pkey_api.c                                          |  120 
 drivers/s390/crypto/vfio_ap_ops.c                                       |  142 
 drivers/s390/crypto/zcrypt_api.c                                        |    3 
 drivers/s390/crypto/zcrypt_ccamisc.c                                    |   64 
 drivers/s390/crypto/zcrypt_ccamisc.h                                    |    6 
 drivers/s390/net/ctcm_mpc.c                                             |   13 
 drivers/s390/net/ism.h                                                  |    2 
 drivers/s390/net/ism_drv.c                                              |   45 
 drivers/s390/net/netiucv.c                                              |    2 
 drivers/s390/virtio/virtio_ccw.c                                        |    4 
 drivers/scsi/ch.c                                                       |   30 
 drivers/scsi/hisi_sas/hisi_sas.h                                        |    4 
 drivers/scsi/hisi_sas/hisi_sas_main.c                                   |   48 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                  |  279 
 drivers/scsi/hosts.c                                                    |    2 
 drivers/scsi/imm.c                                                      |    1 
 drivers/scsi/iscsi_tcp.c                                                |    1 
 drivers/scsi/libiscsi.c                                                 |   14 
 drivers/scsi/libsas/sas_expander.c                                      |   14 
 drivers/scsi/lpfc/lpfc_init.c                                           |    2 
 drivers/scsi/mpi3mr/mpi3mr.h                                            |   11 
 drivers/scsi/mpi3mr/mpi3mr_app.c                                        |   11 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                         |  148 
 drivers/scsi/qedi/qedi_main.c                                           |    3 
 drivers/scsi/qla2xxx/qla_bsg.c                                          |   47 
 drivers/scsi/qla2xxx/qla_init.c                                         |   17 
 drivers/scsi/qla2xxx/qla_iocb.c                                         |   12 
 drivers/scsi/qla2xxx/qla_isr.c                                          |   25 
 drivers/scsi/qla2xxx/qla_mbx.c                                          |    6 
 drivers/scsi/qla2xxx/qla_mid.c                                          |   41 
 drivers/scsi/qla2xxx/qla_nvme.c                                         |   10 
 drivers/scsi/qla2xxx/qla_os.c                                           |   33 
 drivers/scsi/qla2xxx/qla_target.c                                       |    5 
 drivers/scsi/qla2xxx/qla_target.h                                       |    1 
 drivers/scsi/scsi_error.c                                               |   28 
 drivers/scsi/scsi_priv.h                                                |    1 
 drivers/scsi/sd.c                                                       |   25 
 drivers/scsi/st.c                                                       |   18 
 drivers/scsi/xen-scsifront.c                                            |    1 
 drivers/soc/aspeed/aspeed-lpc-snoop.c                                   |   33 
 drivers/soc/imx/imx8m-blk-ctrl.c                                        |   34 
 drivers/soc/imx/imx8mp-blk-ctrl.c                                       |   18 
 drivers/soc/imx/imx93-blk-ctrl.c                                        |   54 
 drivers/soc/qcom/icc-bwmon.c                                            |    2 
 drivers/soc/rockchip/pm_domains.c                                       |   20 
 drivers/soc/xilinx/zynqmp_power.c                                       |   10 
 drivers/soundwire/generic_bandwidth_allocation.c                        |   31 
 drivers/spi/spi-bcm63xx.c                                               |   72 
 drivers/spi/spi-davinci.c                                               |    5 
 drivers/spi/spi-dw-dma.c                                                |    2 
 drivers/spi/spi-fsl-lpspi.c                                             |    9 
 drivers/spi/spi-fsl-qspi.c                                              |   42 
 drivers/spi/spi-fsl-spi.c                                               |   97 
 drivers/spi/spi-hisi-kunpeng.c                                          |   93 
 drivers/spi/spi-microchip-core-qspi.c                                   |   79 
 drivers/spi/spi-microchip-core.c                                        |    4 
 drivers/spi/spi-mpc52xx.c                                               |   66 
 drivers/spi/spi-oc-tiny.c                                               |   24 
 drivers/spi/spi-qcom-qspi.c                                             |   45 
 drivers/spi/spi-rockchip.c                                              |    2 
 drivers/spi/spi-rspi.c                                                  |   14 
 drivers/spi/spi-tegra114.c                                              |    7 
 drivers/spi/spi-tegra210-quad.c                                         |   20 
 drivers/staging/greybus/raw.c                                           |   90 
 drivers/staging/greybus/uart.c                                          |    3 
 drivers/staging/media/atomisp/i2c/atomisp-gc2235.c                      |   29 
 drivers/staging/media/deprecated/saa7146/av7110/av7110.h                |    4 
 drivers/staging/media/deprecated/saa7146/av7110/av7110_ca.c             |   26 
 drivers/staging/media/rkvdec/rkvdec.c                                   |    4 
 drivers/staging/most/Kconfig                                            |    2 
 drivers/staging/most/Makefile                                           |    1 
 drivers/staging/most/i2c/Kconfig                                        |   13 
 drivers/staging/most/i2c/Makefile                                       |    4 
 drivers/staging/most/i2c/i2c.c                                          |  371 -
 drivers/staging/rtl8723bs/core/rtw_mlme.c                               |    5 
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                           |   22 
 drivers/staging/sm750fb/sm750.c                                         |    2 
 drivers/staging/sm750fb/sm750.h                                         |    2 
 drivers/staging/sm750fb/sm750_accel.c                                   |    6 
 drivers/staging/sm750fb/sm750_accel.h                                   |    4 
 drivers/target/iscsi/iscsi_target_configfs.c                            |   26 
 drivers/tee/optee/ffa_abi.c                                             |   16 
 drivers/tee/optee/smc_abi.c                                             |   17 
 drivers/thermal/thermal_hwmon.c                                         |   87 
 drivers/thunderbolt/ctl.c                                               |   63 
 drivers/thunderbolt/quirks.c                                            |    3 
 drivers/thunderbolt/xdomain.c                                           |    4 
 drivers/tty/amiserial.c                                                 |    9 
 drivers/tty/n_gsm.c                                                     |   90 
 drivers/tty/pty.c                                                       |    2 
 drivers/tty/serial/8250/8250_bcm7271.c                                  |    2 
 drivers/tty/serial/8250/8250_core.c                                     |    2 
 drivers/tty/serial/imx.c                                                |   26 
 drivers/tty/serial/kgdboc.c                                             |    9 
 drivers/tty/serial/max3100.c                                            |   13 
 drivers/tty/serial/qcom_geni_serial.c                                   |    5 
 drivers/tty/serial/sc16is7xx.c                                          |   22 
 drivers/tty/serial/serial-tegra.c                                       |   18 
 drivers/tty/serial/serial_core.c                                        |   48 
 drivers/tty/serial/vt8500_serial.c                                      |    1 
 drivers/tty/tty_io.c                                                    |   80 
 drivers/tty/tty_port.c                                                  |   75 
 drivers/tty/vcc.c                                                       |    5 
 drivers/tty/vt/vc_screen.c                                              |   25 
 drivers/tty/vt/vt.c                                                     |    7 
 drivers/ufs/core/ufshcd.c                                               |   28 
 drivers/ufs/host/ufs-exynos.c                                           |   17 
 drivers/ufs/host/ufs-exynos.h                                           |    3 
 drivers/ufs/host/ufs-qcom.c                                             |   13 
 drivers/usb/cdns3/cdns3-gadget.c                                        |    4 
 drivers/usb/cdns3/cdns3-pci-wrap.c                                      |    5 
 drivers/usb/chipidea/ci_hdrc_tegra.c                                    |    4 
 drivers/usb/chipidea/udc.c                                              |    4 
 drivers/usb/class/cdc-acm.c                                             |   41 
 drivers/usb/class/cdc-acm.h                                             |    1 
 drivers/usb/core/hub.c                                                  |    7 
 drivers/usb/core/message.c                                              |    8 
 drivers/usb/dwc2/hcd.c                                                  |    3 
 drivers/usb/dwc3/core.c                                                 |   19 
 drivers/usb/dwc3/core.h                                                 |   23 
 drivers/usb/dwc3/dwc3-am62.c                                            |    1 
 drivers/usb/dwc3/ep0.c                                                  |    9 
 drivers/usb/dwc3/gadget.c                                               |  112 
 drivers/usb/gadget/function/f_ecm.c                                     |   41 
 drivers/usb/gadget/function/f_eem.c                                     |   59 
 drivers/usb/gadget/function/f_fs.c                                      |  239 
 drivers/usb/gadget/function/f_hid.c                                     |   17 
 drivers/usb/gadget/function/f_mass_storage.c                            |    3 
 drivers/usb/gadget/function/f_midi.c                                    |    6 
 drivers/usb/gadget/function/f_printer.c                                 |   10 
 drivers/usb/gadget/function/f_rndis.c                                   |   42 
 drivers/usb/gadget/function/f_subset.c                                  |   57 
 drivers/usb/gadget/function/f_uac1.c                                    |   13 
 drivers/usb/gadget/function/f_uac1_legacy.c                             |    6 
 drivers/usb/gadget/function/f_uac2.c                                    |   13 
 drivers/usb/gadget/function/u_ecm.h                                     |   21 
 drivers/usb/gadget/function/u_eem.h                                     |   21 
 drivers/usb/gadget/function/u_fs.h                                      |    2 
 drivers/usb/gadget/function/u_gether.h                                  |   22 
 drivers/usb/gadget/function/u_rndis.h                                   |   31 
 drivers/usb/gadget/legacy/g_ffs.c                                       |    9 
 drivers/usb/gadget/legacy/inode.c                                       |    7 
 drivers/usb/gadget/udc/aspeed-vhub/core.c                               |    4 
 drivers/usb/gadget/udc/aspeed-vhub/dev.c                                |    2 
 drivers/usb/gadget/udc/aspeed-vhub/hub.c                                |    5 
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h                               |    1 
 drivers/usb/gadget/udc/at91_udc.c                                       |   33 
 drivers/usb/gadget/udc/core.c                                           |    7 
 drivers/usb/gadget/udc/dummy_hcd.c                                      |    4 
 drivers/usb/host/ehci-sched.c                                           |   11 
 drivers/usb/host/fotg210-hcd.c                                          |    6 
 drivers/usb/host/octeon-hcd.c                                           |    2 
 drivers/usb/host/ohci-da8xx.c                                           |    2 
 drivers/usb/host/ohci-s3c2410.c                                         |    1 
 drivers/usb/host/ohci-spear.c                                           |    4 
 drivers/usb/host/ohci-st.c                                              |    1 
 drivers/usb/host/xhci.c                                                 |   11 
 drivers/usb/misc/iowarrior.c                                            |   57 
 drivers/usb/serial/ark3116.c                                            |    7 
 drivers/usb/serial/belkin_sa.c                                          |   12 
 drivers/usb/serial/bus.c                                                |    6 
 drivers/usb/serial/ch341.c                                              |   37 
 drivers/usb/serial/cp210x.c                                             |    9 
 drivers/usb/serial/digi_acceleport.c                                    |    7 
 drivers/usb/serial/f81232.c                                             |    4 
 drivers/usb/serial/f81534.c                                             |    4 
 drivers/usb/serial/ftdi_sio.c                                           |   10 
 drivers/usb/serial/generic.c                                            |   10 
 drivers/usb/serial/io_edgeport.c                                        |    6 
 drivers/usb/serial/io_ti.c                                              |    9 
 drivers/usb/serial/keyspan.c                                            |    5 
 drivers/usb/serial/keyspan_pda.c                                        |    8 
 drivers/usb/serial/mct_u232.c                                           |    6 
 drivers/usb/serial/mos7720.c                                            |    9 
 drivers/usb/serial/mos7840.c                                            |    7 
 drivers/usb/serial/mxuport.c                                            |    6 
 drivers/usb/serial/option.c                                             |   14 
 drivers/usb/serial/pl2303.c                                             |   14 
 drivers/usb/serial/quatech2.c                                           |   27 
 drivers/usb/serial/ssu100.c                                             |   18 
 drivers/usb/serial/ti_usb_3410_5052.c                                   |   10 
 drivers/usb/serial/upd78f0730.c                                         |    7 
 drivers/usb/serial/usb-serial.c                                         |  127 
 drivers/usb/serial/usb_debug.c                                          |   13 
 drivers/usb/serial/whiteheat.c                                          |    7 
 drivers/usb/serial/xr_serial.c                                          |    4 
 drivers/usb/storage/realtek_cr.c                                        |    9 
 drivers/usb/storage/sierra_ms.c                                         |    7 
 drivers/usb/typec/anx7411.c                                             |    5 
 drivers/usb/typec/tcpm/tcpci_maxim.c                                    |    9 
 drivers/usb/typec/tcpm/tcpci_rt1711h.c                                  |   13 
 drivers/usb/typec/tcpm/tcpm.c                                           |   53 
 drivers/usb/typec/tipd/core.c                                           |    3 
 drivers/usb/typec/ucsi/displayport.c                                    |    9 
 drivers/usb/typec/ucsi/ucsi.c                                           |   43 
 drivers/usb/typec/ucsi/ucsi.h                                           |   11 
 drivers/usb/typec/ucsi/ucsi_acpi.c                                      |   32 
 drivers/usb/usbip/usbip_common.c                                        |    1 
 drivers/vdpa/mlx5/core/mlx5_vdpa.h                                      |    2 
 drivers/vdpa/mlx5/core/mr.c                                             |    3 
 drivers/vdpa/mlx5/core/resources.c                                      |   11 
 drivers/vdpa/mlx5/net/mlx5_vnet.c                                       |    9 
 drivers/vdpa/vdpa_sim/vdpa_sim.c                                        |   11 
 drivers/vdpa/vdpa_user/iova_domain.c                                    |   11 
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c                          |   22 
 drivers/vfio/pci/mlx5/main.c                                            |    6 
 drivers/vhost/iotlb.c                                                   |   47 
 drivers/vhost/vdpa.c                                                    |   11 
 drivers/vhost/vhost.c                                                   |  116 
 drivers/video/fbdev/arcfb.c                                             |    3 
 drivers/video/fbdev/broadsheetfb.c                                      |    4 
 drivers/video/fbdev/cobalt_lcdfb.c                                      |    6 
 drivers/video/fbdev/core/fb_sys_fops.c                                  |    8 
 drivers/video/fbdev/core/fbcon.c                                        |    2 
 drivers/video/fbdev/core/fbmem.c                                        |   29 
 drivers/video/fbdev/core/fbsysfs.c                                      |   13 
 drivers/video/fbdev/hecubafb.c                                          |    4 
 drivers/video/fbdev/metronomefb.c                                       |    4 
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c                          |   11 
 drivers/video/fbdev/ps3fb.c                                             |    5 
 drivers/video/fbdev/pvr2fb.c                                            |    3 
 drivers/video/fbdev/sh_mobile_lcdcfb.c                                  |    5 
 drivers/video/fbdev/sm712fb.c                                           |   10 
 drivers/video/fbdev/ssd1307fb.c                                         |  126 
 drivers/virt/acrn/irqfd.c                                               |   71 
 drivers/virt/nitro_enclaves/ne_misc_dev.c                               |    1 
 drivers/virtio/virtio.c                                                 |   29 
 drivers/virtio/virtio_mmio.c                                            |   66 
 drivers/watchdog/at91sam9_wdt.c                                         |    4 
 drivers/watchdog/cpu5wdt.c                                              |    2 
 drivers/watchdog/rtd119x_wdt.c                                          |   21 
 drivers/xen/events/events_2l.c                                          |    8 
 drivers/xen/events/events_base.c                                        |  445 -
 drivers/xen/events/events_internal.h                                    |    1 
 drivers/xen/gntdev-dmabuf.c                                             |   31 
 drivers/xen/pvcalls-front.c                                             |   88 
 fs/9p/vfs_inode_dotl.c                                                  |    2 
 fs/Kconfig                                                              |    1 
 fs/Makefile                                                             |    1 
 fs/afs/inode.c                                                          |    1 
 fs/afs/internal.h                                                       |    2 
 fs/afs/rxrpc.c                                                          |   79 
 fs/afs/super.c                                                          |    2 
 fs/autofs/waitq.c                                                       |   25 
 fs/btrfs/acl.c                                                          |    3 
 fs/btrfs/block-group.c                                                  |    3 
 fs/btrfs/block-rsv.c                                                    |   19 
 fs/btrfs/ctree.c                                                        |   65 
 fs/btrfs/ctree.h                                                        |   23 
 fs/btrfs/dev-replace.c                                                  |    1 
 fs/btrfs/disk-io.c                                                      |    5 
 fs/btrfs/extent-tree.c                                                  |   46 
 fs/btrfs/extent_io.c                                                    |  173 
 fs/btrfs/file.c                                                         |  103 
 fs/btrfs/free-space-tree.c                                              |   10 
 fs/btrfs/inode.c                                                        |   82 
 fs/btrfs/ioctl.c                                                        |   68 
 fs/btrfs/lzo.c                                                          |   14 
 fs/btrfs/qgroup.c                                                       |   24 
 fs/btrfs/reflink.c                                                      |   58 
 fs/btrfs/relocation.c                                                   |   87 
 fs/btrfs/scrub.c                                                        |    9 
 fs/btrfs/transaction.c                                                  |   21 
 fs/btrfs/tree-log.c                                                     |  105 
 fs/btrfs/volumes.c                                                      |  243 
 fs/ceph/dir.c                                                           |   10 
 fs/ceph/export.c                                                        |   23 
 fs/ceph/mds_client.c                                                    |   63 
 fs/ceph/mds_client.h                                                    |    1 
 fs/ceph/super.h                                                         |    9 
 fs/ceph/xattr.c                                                         |   16 
 fs/coredump.c                                                           |   16 
 fs/dcache.c                                                             |    4 
 fs/dlm/config.c                                                         |    4 
 fs/dlm/lock.c                                                           |    2 
 fs/dlm/lowcomms.c                                                       |  193 
 fs/dlm/lowcomms.h                                                       |    5 
 fs/dlm/midcomms.c                                                       |   10 
 fs/erofs/decompressor_lzma.c                                            |   18 
 fs/erofs/xattr.c                                                        |    5 
 fs/erofs/zdata.c                                                        |   46 
 fs/erofs/zmap.c                                                         |   21 
 fs/exec.c                                                               |   23 
 fs/exfat/dir.c                                                          |   24 
 fs/exfat/exfat_fs.h                                                     |    3 
 fs/exfat/fatent.c                                                       |   10 
 fs/exfat/namei.c                                                        |   28 
 fs/exfat/nls.c                                                          |   24 
 fs/exfat/super.c                                                        |   32 
 fs/ext2/inode.c                                                         |    3 
 fs/ext2/xattr.c                                                         |    4 
 fs/ext4/ext4.h                                                          |   29 
 fs/ext4/extents.c                                                       |   20 
 fs/ext4/extents_status.c                                                |    7 
 fs/ext4/extents_status.h                                                |    1 
 fs/ext4/inode.c                                                         |   57 
 fs/ext4/ioctl.c                                                         |    5 
 fs/ext4/mballoc.c                                                       |  217 
 fs/ext4/mballoc.h                                                       |    4 
 fs/ext4/migrate.c                                                       |   14 
 fs/ext4/super.c                                                         |   61 
 fs/ext4/xattr.c                                                         |    2 
 fs/f2fs/checkpoint.c                                                    |    7 
 fs/f2fs/compress.c                                                      |   10 
 fs/f2fs/data.c                                                          |   14 
 fs/f2fs/debug.c                                                         |    4 
 fs/f2fs/dir.c                                                           |    1 
 fs/f2fs/extent_cache.c                                                  |  153 
 fs/f2fs/f2fs.h                                                          |   69 
 fs/f2fs/file.c                                                          |   32 
 fs/f2fs/gc.c                                                            |   70 
 fs/f2fs/gc.h                                                            |   20 
 fs/f2fs/inode.c                                                         |    8 
 fs/f2fs/node.c                                                          |   78 
 fs/f2fs/recovery.c                                                      |   33 
 fs/f2fs/segment.c                                                       |   37 
 fs/f2fs/super.c                                                         |   58 
 fs/f2fs/sysfs.c                                                         |   42 
 fs/fcntl.c                                                              |    3 
 fs/fsopen.c                                                             |    3 
 fs/fuse/inode.c                                                         |    2 
 fs/gfs2/glock.c                                                         |   35 
 fs/gfs2/glock.h                                                         |    1 
 fs/gfs2/incore.h                                                        |    1 
 fs/gfs2/lock_dlm.c                                                      |   12 
 fs/gfs2/ops_fstype.c                                                    |   13 
 fs/gfs2/super.c                                                         |    7 
 fs/inode.c                                                              |   24 
 fs/jfs/jfs_dtree.c                                                      |   18 
 fs/libfs.c                                                              |   36 
 fs/lockd/clntproc.c                                                     |    3 
 fs/lockd/svc.c                                                          |    6 
 fs/lockd/svc4proc.c                                                     |    4 
 fs/lockd/svcproc.c                                                      |    4 
 fs/lockd/svcsubs.c                                                      |   47 
 fs/mbcache.c                                                            |    1 
 fs/namei.c                                                              |    4 
 fs/namespace.c                                                          |  123 
 fs/nfs/blocklayout/dev.c                                                |   19 
 fs/nfs/callback_xdr.c                                                   |    6 
 fs/nfs/delegation.c                                                     |   27 
 fs/nfs/flexfilelayout/flexfilelayout.c                                  |    3 
 fs/nfs/nfs4proc.c                                                       |   32 
 fs/nfs/nfs4session.c                                                    |   16 
 fs/nfs/pnfs.c                                                           |   58 
 fs/nfs/pnfs.h                                                           |   17 
 fs/nfsd/export.c                                                        |   31 
 fs/nfsd/export.h                                                        |    4 
 fs/nfsd/filecache.c                                                     |   67 
 fs/nfsd/lockd.c                                                         |    6 
 fs/nfsd/netns.h                                                         |    5 
 fs/nfsd/nfs2acl.c                                                       |   21 
 fs/nfsd/nfs3acl.c                                                       |   17 
 fs/nfsd/nfs3proc.c                                                      |   38 
 fs/nfsd/nfs4layouts.c                                                   |   21 
 fs/nfsd/nfs4proc.c                                                      |   34 
 fs/nfsd/nfs4state.c                                                     |   33 
 fs/nfsd/trace.h                                                         |    4 
 fs/nfsd/vfs.c                                                           |   36 
 fs/nilfs2/page.c                                                        |   17 
 fs/notify/mark.c                                                        |   50 
 fs/ntfs/Kconfig                                                         |   80 
 fs/ntfs/Makefile                                                        |   15 
 fs/ntfs/aops.c                                                          | 1761 -----
 fs/ntfs/aops.h                                                          |   88 
 fs/ntfs/attrib.c                                                        | 2624 --------
 fs/ntfs/attrib.h                                                        |  102 
 fs/ntfs/bitmap.c                                                        |  179 
 fs/ntfs/bitmap.h                                                        |  104 
 fs/ntfs/collate.c                                                       |  110 
 fs/ntfs/collate.h                                                       |   36 
 fs/ntfs/compress.c                                                      |  950 --
 fs/ntfs/debug.c                                                         |  159 
 fs/ntfs/debug.h                                                         |   57 
 fs/ntfs/dir.c                                                           | 1538 ----
 fs/ntfs/dir.h                                                           |   34 
 fs/ntfs/endian.h                                                        |   79 
 fs/ntfs/file.c                                                          | 2006 ------
 fs/ntfs/index.c                                                         |  440 -
 fs/ntfs/index.h                                                         |  134 
 fs/ntfs/inode.c                                                         | 3100 ---------
 fs/ntfs/inode.h                                                         |  310 
 fs/ntfs/layout.h                                                        | 2421 -------
 fs/ntfs/lcnalloc.c                                                      | 1000 ---
 fs/ntfs/lcnalloc.h                                                      |  131 
 fs/ntfs/logfile.c                                                       |  849 --
 fs/ntfs/logfile.h                                                       |  295 
 fs/ntfs/malloc.h                                                        |   77 
 fs/ntfs/mft.c                                                           | 2906 ---------
 fs/ntfs/mft.h                                                           |  110 
 fs/ntfs/mst.c                                                           |  189 
 fs/ntfs/namei.c                                                         |  391 -
 fs/ntfs/ntfs.h                                                          |  150 
 fs/ntfs/quota.c                                                         |  103 
 fs/ntfs/quota.h                                                         |   21 
 fs/ntfs/runlist.c                                                       | 1893 -----
 fs/ntfs/runlist.h                                                       |   88 
 fs/ntfs/super.c                                                         | 3194 ----------
 fs/ntfs/sysctl.c                                                        |   69 
 fs/ntfs/sysctl.h                                                        |   27 
 fs/ntfs/time.h                                                          |   89 
 fs/ntfs/types.h                                                         |   55 
 fs/ntfs/unistr.c                                                        |  384 -
 fs/ntfs/upcase.c                                                        |   73 
 fs/ntfs/usnjrnl.c                                                       |   70 
 fs/ntfs/usnjrnl.h                                                       |  191 
 fs/ntfs/volume.h                                                        |  164 
 fs/ntfs3/attrib.c                                                       |   27 
 fs/ntfs3/file.c                                                         |   31 
 fs/ntfs3/frecord.c                                                      |   86 
 fs/ntfs3/fslog.c                                                        |   16 
 fs/ntfs3/index.c                                                        |   10 
 fs/ntfs3/inode.c                                                        |   17 
 fs/ntfs3/namei.c                                                        |   10 
 fs/ntfs3/ntfs_fs.h                                                      |   24 
 fs/ntfs3/record.c                                                       |   91 
 fs/ntfs3/super.c                                                        |   16 
 fs/ocfs2/cluster/heartbeat.c                                            |  168 
 fs/ocfs2/cluster/nodemanager.c                                          |   19 
 fs/ocfs2/cluster/nodemanager.h                                          |    2 
 fs/ocfs2/cluster/tcp.c                                                  |  104 
 fs/ocfs2/cluster/tcp.h                                                  |    1 
 fs/ocfs2/dir.c                                                          |   71 
 fs/ocfs2/dlm/dlmcommon.h                                                |    2 
 fs/ocfs2/dlm/dlmdebug.c                                                 |    5 
 fs/ocfs2/dlm/dlmrecovery.c                                              |    2 
 fs/ocfs2/inode.c                                                        |  129 
 fs/ocfs2/namei.c                                                        |    8 
 fs/overlayfs/file.c                                                     |   19 
 fs/pipe.c                                                               |    6 
 fs/proc/task_mmu.c                                                      |    3 
 fs/reiserfs/namei.c                                                     |   61 
 fs/smb/client/cached_dir.c                                              |  122 
 fs/smb/client/cifsacl.c                                                 |   71 
 fs/smb/client/cifsfs.c                                                  |    1 
 fs/smb/client/cifsglob.h                                                |   15 
 fs/smb/client/connect.c                                                 |  172 
 fs/smb/client/dir.c                                                     |   39 
 fs/smb/client/file.c                                                    |   41 
 fs/smb/client/fs_context.c                                              |    6 
 fs/smb/client/inode.c                                                   |   40 
 fs/smb/client/link.c                                                    |   15 
 fs/smb/client/misc.c                                                    |   72 
 fs/smb/client/readdir.c                                                 |   17 
 fs/smb/client/sess.c                                                    |  106 
 fs/smb/client/smb1ops.c                                                 |   21 
 fs/smb/client/smb2file.c                                                |   19 
 fs/smb/client/smb2misc.c                                                |   15 
 fs/smb/client/smb2ops.c                                                 |  107 
 fs/smb/client/smb2pdu.c                                                 |   96 
 fs/smb/client/smb2pdu.h                                                 |    9 
 fs/smb/client/smb2proto.h                                               |    4 
 fs/smb/client/smb2transport.c                                           |   58 
 fs/smb/client/smbdirect.c                                               |   22 
 fs/smb/client/transport.c                                               |   69 
 fs/smb/common/smb2pdu.h                                                 |   11 
 fs/smb/server/auth.c                                                    |   22 
 fs/smb/server/connection.c                                              |   23 
 fs/smb/server/connection.h                                              |   14 
 fs/smb/server/ksmbd_work.c                                              |    3 
 fs/smb/server/ksmbd_work.h                                              |    1 
 fs/smb/server/mgmt/share_config.c                                       |    7 
 fs/smb/server/mgmt/tree_connect.c                                       |   28 
 fs/smb/server/mgmt/user_config.c                                        |   11 
 fs/smb/server/mgmt/user_session.c                                       |   29 
 fs/smb/server/mgmt/user_session.h                                       |    2 
 fs/smb/server/misc.c                                                    |   33 
 fs/smb/server/misc.h                                                    |    1 
 fs/smb/server/oplock.c                                                  |  133 
 fs/smb/server/oplock.h                                                  |    2 
 fs/smb/server/server.c                                                  |   26 
 fs/smb/server/smb2ops.c                                                 |    1 
 fs/smb/server/smb2pdu.c                                                 |  292 
 fs/smb/server/smb2pdu.h                                                 |    8 
 fs/smb/server/smb_common.c                                              |   10 
 fs/smb/server/smb_common.h                                              |    2 
 fs/smb/server/smbacl.c                                                  |  315 
 fs/smb/server/smbacl.h                                                  |    4 
 fs/smb/server/transport_ipc.c                                           |    5 
 fs/smb/server/transport_rdma.c                                          |    4 
 fs/smb/server/vfs.c                                                     |   94 
 fs/smb/server/vfs_cache.c                                               |  135 
 fs/unicode/utf8-core.c                                                  |   21 
 fs/userfaultfd.c                                                        |   11 
 fs/verity/Kconfig                                                       |    3 
 fs/xfs/libxfs/xfs_alloc.c                                               |   46 
 fs/xfs/libxfs/xfs_attr.c                                                |   74 
 fs/xfs/libxfs/xfs_ialloc.c                                              |   32 
 fs/xfs/libxfs/xfs_sb.c                                                  |   17 
 fs/xfs/xfs_buf_item.c                                                   |  297 
 fs/xfs/xfs_buf_item.h                                                   |    3 
 fs/xfs/xfs_fsmap.c                                                      |    2 
 fs/xfs/xfs_icache.c                                                     |    8 
 fs/xfs/xfs_inode.c                                                      |    2 
 fs/xfs/xfs_ioctl.c                                                      |    2 
 fs/xfs/xfs_iops.c                                                       |    2 
 fs/xfs/xfs_log_recover.c                                                |   13 
 include/acpi/acpi_bus.h                                                 |    6 
 include/acpi/battery.h                                                  |    4 
 include/clocksource/samsung_pwm.h                                       |    2 
 include/drm/gpu_scheduler.h                                             |   29 
 include/linux/blkdev.h                                                  |    1 
 include/linux/bpf.h                                                     |   42 
 include/linux/can/skb.h                                                 |    2 
 include/linux/cgroup-defs.h                                             |    5 
 include/linux/cgroup.h                                                  |    1 
 include/linux/compiler_attributes.h                                     |   13 
 include/linux/device-mapper.h                                           |   23 
 include/linux/device.h                                                  |    3 
 include/linux/dm-dirty-log.h                                            |    2 
 include/linux/dm-region-hash.h                                          |    6 
 include/linux/dma-buf.h                                                 |    1 
 include/linux/dma/k3-udma-glue.h                                        |    3 
 include/linux/dmaengine.h                                               |    7 
 include/linux/f2fs_fs.h                                                 |    1 
 include/linux/fb.h                                                      |  115 
 include/linux/fs.h                                                      |    2 
 include/linux/fsnotify_backend.h                                        |    1 
 include/linux/ftrace.h                                                  |    5 
 include/linux/futex.h                                                   |   14 
 include/linux/hid.h                                                     |   10 
 include/linux/hw_random.h                                               |    2 
 include/linux/i2c.h                                                     |    1 
 include/linux/i3c/master.h                                              |    3 
 include/linux/ieee80211.h                                               |   12 
 include/linux/if_team.h                                                 |    3 
 include/linux/if_vlan.h                                                 |    3 
 include/linux/iio/common/st_sensors.h                                   |    4 
 include/linux/ima.h                                                     |    1 
 include/linux/io_uring.h                                                |    2 
 include/linux/iommu.h                                                   |    2 
 include/linux/ism.h                                                     |   23 
 include/linux/kasan.h                                                   |    6 
 include/linux/key-type.h                                                |    1 
 include/linux/key.h                                                     |    5 
 include/linux/libata.h                                                  |    3 
 include/linux/list.h                                                    |   15 
 include/linux/lockd/bind.h                                              |   12 
 include/linux/lockd/lockd.h                                             |    2 
 include/linux/memory_hotplug.h                                          |    2 
 include/linux/mlx5/cq.h                                                 |    1 
 include/linux/mlx5/driver.h                                             |    1 
 include/linux/mlx5/mlx5_ifc.h                                           |   13 
 include/linux/mlx5/vport.h                                              |    6 
 include/linux/mm.h                                                      |    2 
 include/linux/mm_types.h                                                |    3 
 include/linux/mount.h                                                   |    2 
 include/linux/mtd/mtd.h                                                 |    2 
 include/linux/netdevice.h                                               |    4 
 include/linux/netfilter.h                                               |   12 
 include/linux/nfs_xdr.h                                                 |    1 
 include/linux/ntb.h                                                     |   24 
 include/linux/nvme.h                                                    |    4 
 include/linux/of.h                                                      |    6 
 include/linux/of_device.h                                               |   11 
 include/linux/of_platform.h                                             |    5 
 include/linux/pagemap.h                                                 |   28 
 include/linux/pci.h                                                     |    7 
 include/linux/perf/riscv_pmu.h                                          |    5 
 include/linux/perf_event.h                                              |    1 
 include/linux/power_supply.h                                            |    6 
 include/linux/psi.h                                                     |    4 
 include/linux/qcom-geni-se.h                                            |   15 
 include/linux/sched.h                                                   |    2 
 include/linux/sched/signal.h                                            |   27 
 include/linux/sched/user.h                                              |   11 
 include/linux/scmi_protocol.h                                           |    5 
 include/linux/seq_buf.h                                                 |   27 
 include/linux/skbuff.h                                                  |   22 
 include/linux/stmmac.h                                                  |    1 
 include/linux/sunrpc/svc_rdma.h                                         |    1 
 include/linux/sunrpc/xdr.h                                              |    1 
 include/linux/trace_recursion.h                                         |    9 
 include/linux/trace_seq.h                                               |    2 
 include/linux/tty.h                                                     |    4 
 include/linux/tty_driver.h                                              |    6 
 include/linux/tty_port.h                                                |   22 
 include/linux/unicode.h                                                 |    1 
 include/linux/usb/gadget.h                                              |    2 
 include/linux/usb/serial.h                                              |    3 
 include/linux/userfaultfd_k.h                                           |    7 
 include/linux/virtio.h                                                  |    2 
 include/media/v4l2-mem2mem.h                                            |   21 
 include/net/af_vsock.h                                                  |    3 
 include/net/amt.h                                                       |    4 
 include/net/ax25.h                                                      |    1 
 include/net/bluetooth/hci.h                                             |    9 
 include/net/bluetooth/hci_core.h                                        |    5 
 include/net/bluetooth/l2cap.h                                           |    1 
 include/net/bluetooth/rfcomm.h                                          |    1 
 include/net/cfg80211.h                                                  |  105 
 include/net/codel_impl.h                                                |    1 
 include/net/dropreason.h                                                |    3 
 include/net/dsa.h                                                       |    1 
 include/net/inet_connection_sock.h                                      |   11 
 include/net/ip.h                                                        |   17 
 include/net/ip6_route.h                                                 |    2 
 include/net/ip_vs.h                                                     |    2 
 include/net/netfilter/nf_conntrack_expect.h                             |   16 
 include/net/netfilter/nf_conntrack_timeout.h                            |   27 
 include/net/netfilter/nf_queue.h                                        |    1 
 include/net/netfilter/nf_tables.h                                       |   16 
 include/net/netfilter/nft_fib.h                                         |    2 
 include/net/netfilter/nft_meta.h                                        |    4 
 include/net/netfilter/nft_reject.h                                      |    3 
 include/net/netns/mpls.h                                                |    1 
 include/net/netns/xfrm.h                                                |    1 
 include/net/nexthop.h                                                   |    6 
 include/net/pkt_cls.h                                                   |   45 
 include/net/pkt_sched.h                                                 |    3 
 include/net/route.h                                                     |    2 
 include/net/sch_generic.h                                               |   21 
 include/net/secure_seq.h                                                |   47 
 include/net/sock.h                                                      |   19 
 include/net/strparser.h                                                 |   10 
 include/net/tc_act/tc_pedit.h                                           |   18 
 include/net/tcp.h                                                       |   14 
 include/net/tls.h                                                       |   12 
 include/scsi/scsi_host.h                                                |    9 
 include/trace/events/btrfs.h                                            |    4 
 include/trace/events/rv.h                                               |   76 
 include/uapi/linux/ioprio.h                                             |  100 
 include/uapi/linux/netfilter/nf_conntrack_common.h                      |    1 
 include/uapi/linux/nexthop.h                                            |    7 
 include/uapi/linux/stddef.h                                             |    5 
 include/uapi/linux/virtio_crypto.h                                      |    1 
 include/xen/events.h                                                    |    4 
 io_uring/cancel.c                                                       |   33 
 io_uring/cancel.h                                                       |    2 
 io_uring/io-wq.c                                                        |   96 
 io_uring/io-wq.h                                                        |    4 
 io_uring/io_uring.c                                                     |  108 
 io_uring/io_uring.h                                                     |   44 
 io_uring/poll.c                                                         |   42 
 io_uring/rsrc.c                                                         |    7 
 io_uring/rw.c                                                           |   18 
 io_uring/sqpoll.c                                                       |    7 
 io_uring/tctx.c                                                         |    1 
 io_uring/timeout.c                                                      |   46 
 kernel/audit_tree.c                                                     |   24 
 kernel/bpf/arraymap.c                                                   |   30 
 kernel/bpf/bpf_struct_ops.c                                             |   77 
 kernel/bpf/btf.c                                                        |    5 
 kernel/bpf/cgroup.c                                                     |   23 
 kernel/bpf/core.c                                                       |    1 
 kernel/bpf/hashtab.c                                                    |   63 
 kernel/bpf/helpers.c                                                    |  102 
 kernel/bpf/mmap_unlock_work.h                                           |   51 
 kernel/bpf/queue_stack_maps.c                                           |    8 
 kernel/bpf/stackmap.c                                                   |   85 
 kernel/bpf/syscall.c                                                    |   93 
 kernel/bpf/task_iter.c                                                  |   14 
 kernel/bpf/trampoline.c                                                 |   54 
 kernel/bpf/verifier.c                                                   |  104 
 kernel/cgroup/Makefile                                                  |    2 
 kernel/cgroup/cgroup.c                                                  |   53 
 kernel/cgroup/cpuset-internal.h                                         |  222 
 kernel/cgroup/cpuset-v1.c                                               |    3 
 kernel/cgroup/cpuset.c                                                  |  222 
 kernel/cgroup/rstat.c                                                   |   19 
 kernel/dma/direct.c                                                     |   56 
 kernel/events/core.c                                                    |  111 
 kernel/exit.c                                                           |   51 
 kernel/fork.c                                                           |   38 
 kernel/futex/core.c                                                     |   49 
 kernel/kprobes.c                                                        |    8 
 kernel/params.c                                                         |   59 
 kernel/pid_namespace.c                                                  |    5 
 kernel/rcu/tasks.h                                                      |   82 
 kernel/rcu/tree.h                                                       |   13 
 kernel/rcu/tree_plugin.h                                                |   42 
 kernel/sched/core.c                                                     |   50 
 kernel/sched/deadline.c                                                 |    7 
 kernel/sched/psi.c                                                      |   69 
 kernel/sched/rt.c                                                       |   52 
 kernel/sched/sched.h                                                    |    1 
 kernel/signal.c                                                         |    4 
 kernel/time/namespace.c                                                 |    5 
 kernel/trace/blktrace.c                                                 |    3 
 kernel/trace/bpf_trace.c                                                |    6 
 kernel/trace/fgraph.c                                                   |    1 
 kernel/trace/ftrace.c                                                   |   76 
 kernel/trace/trace.c                                                    |  103 
 kernel/trace/trace.h                                                    |    4 
 kernel/trace/trace_events_filter.c                                      |    6 
 kernel/trace/trace_events_hist.c                                        |  102 
 kernel/trace/trace_events_synth.c                                       |   10 
 kernel/trace/trace_events_user.c                                        |   26 
 kernel/trace/trace_functions.c                                          |    2 
 kernel/trace/trace_seq.c                                                |    6 
 kernel/trace/trace_stack.c                                              |    2 
 kernel/trace/trace_synth.h                                              |    1 
 kernel/watch_queue.c                                                    |   11 
 kernel/workqueue.c                                                      |   24 
 lib/Kconfig.debug                                                       |    2 
 lib/seq_buf.c                                                           |   52 
 lib/test_kprobes.c                                                      |   28 
 mm/damon/core.c                                                         |   32 
 mm/filemap.c                                                            |    2 
 mm/huge_memory.c                                                        |   17 
 mm/hugetlb.c                                                            |   56 
 mm/kasan/quarantine.c                                                   |   39 
 mm/kasan/report.c                                                       |    4 
 mm/kasan/shadow.c                                                       |  111 
 mm/khugepaged.c                                                         |    3 
 mm/kmemleak.c                                                           |  190 
 mm/memcontrol.c                                                         |    2 
 mm/memory_hotplug.c                                                     |    3 
 mm/mempolicy.c                                                          |    2 
 mm/migrate.c                                                            |   27 
 mm/mlock.c                                                              |    2 
 mm/mmap.c                                                               |  100 
 mm/mremap.c                                                             |   70 
 mm/page_alloc.c                                                         |   14 
 mm/page_table_check.c                                                   |   20 
 mm/pagewalk.c                                                           |    8 
 mm/ptdump.c                                                             |    7 
 mm/readahead.c                                                          |   13 
 mm/rmap.c                                                               |    6 
 mm/secretmem.c                                                          |  119 
 mm/shmem.c                                                              |   13 
 mm/slab.h                                                               |    5 
 mm/slub.c                                                               |    9 
 mm/userfaultfd.c                                                        |   22 
 mm/vmalloc.c                                                            |    4 
 mm/vmscan.c                                                             |   18 
 net/8021q/vlan.c                                                        |    7 
 net/8021q/vlan_dev.c                                                    |   65 
 net/9p/trans_fd.c                                                       |    1 
 net/9p/trans_xen.c                                                      |   85 
 net/ax25/af_ax25.c                                                      |   30 
 net/ax25/ax25_route.c                                                   |   74 
 net/bluetooth/6lowpan.c                                                 |   49 
 net/bluetooth/af_bluetooth.c                                            |   10 
 net/bluetooth/hci_conn.c                                                |   98 
 net/bluetooth/hci_core.c                                                |   45 
 net/bluetooth/hci_debugfs.c                                             |    2 
 net/bluetooth/hci_event.c                                               |  129 
 net/bluetooth/hci_request.c                                             |    2 
 net/bluetooth/hci_sock.c                                                |    2 
 net/bluetooth/hci_sync.c                                                |   43 
 net/bluetooth/iso.c                                                     |  129 
 net/bluetooth/l2cap_core.c                                              |   64 
 net/bluetooth/l2cap_sock.c                                              |   59 
 net/bluetooth/mgmt.c                                                    |   10 
 net/bluetooth/rfcomm/core.c                                             |  134 
 net/bluetooth/rfcomm/sock.c                                             |    5 
 net/bluetooth/rfcomm/tty.c                                              |    9 
 net/bluetooth/sco.c                                                     |    6 
 net/bridge/br_arp_nd_proxy.c                                            |   24 
 net/bridge/br_cfm.c                                                     |   11 
 net/bridge/br_device.c                                                  |    1 
 net/bridge/br_input.c                                                   |   35 
 net/bridge/br_mrp.c                                                     |   13 
 net/bridge/br_multicast.c                                               |   45 
 net/bridge/br_private.h                                                 |   26 
 net/bridge/netfilter/ebt_dnat.c                                         |    4 
 net/bridge/netfilter/ebt_redirect.c                                     |   16 
 net/bridge/netfilter/ebtable_broute.c                                   |    2 
 net/bridge/netfilter/ebtable_filter.c                                   |    2 
 net/bridge/netfilter/ebtable_nat.c                                      |    2 
 net/bridge/netfilter/ebtables.c                                         |   71 
 net/can/af_can.c                                                        |    6 
 net/can/bcm.c                                                           |    2 
 net/can/isotp.c                                                         |   11 
 net/can/j1939/socket.c                                                  |    1 
 net/can/j1939/transport.c                                               |    2 
 net/can/raw.c                                                           |    7 
 net/ceph/auth_x.c                                                       |    5 
 net/ceph/messenger.c                                                    |    1 
 net/core/bpf_sk_storage.c                                               |    2 
 net/core/dev.c                                                          |   75 
 net/core/dst.c                                                          |    8 
 net/core/filter.c                                                       |    4 
 net/core/flow_dissector.c                                               |   26 
 net/core/netpoll.c                                                      |   10 
 net/core/page_pool.c                                                    |    3 
 net/core/pktgen.c                                                       |    5 
 net/core/secure_seq.c                                                   |   80 
 net/core/skmsg.c                                                        |   22 
 net/core/sock.c                                                         |   30 
 net/dccp/timer.c                                                        |    4 
 net/dsa/dsa2.c                                                          |   35 
 net/ethtool/channels.c                                                  |    9 
 net/ethtool/ioctl.c                                                     |   11 
 net/hsr/hsr_framereg.c                                                  |    4 
 net/ieee802154/core.c                                                   |    8 
 net/ife/ife.c                                                           |   14 
 net/ipv4/af_inet.c                                                      |    1 
 net/ipv4/esp4.c                                                         |    8 
 net/ipv4/fib_semantics.c                                                |    5 
 net/ipv4/fib_trie.c                                                     |    2 
 net/ipv4/igmp.c                                                         |   14 
 net/ipv4/inet_connection_sock.c                                         |   10 
 net/ipv4/inet_diag.c                                                    |    4 
 net/ipv4/ipconfig.c                                                     |   92 
 net/ipv4/ipmr.c                                                         |    6 
 net/ipv4/ipmr_base.c                                                    |    2 
 net/ipv4/netfilter/iptable_nat.c                                        |    4 
 net/ipv4/netfilter/nft_dup_ipv4.c                                       |    3 
 net/ipv4/nexthop.c                                                      |  113 
 net/ipv4/route.c                                                        |    9 
 net/ipv4/syncookies.c                                                   |   10 
 net/ipv4/tcp.c                                                          |   18 
 net/ipv4/tcp_cong.c                                                     |    4 
 net/ipv4/tcp_dctcp.c                                                    |    4 
 net/ipv4/tcp_fastopen.c                                                 |    7 
 net/ipv4/tcp_input.c                                                    |   70 
 net/ipv4/tcp_ipv4.c                                                     |   43 
 net/ipv4/tcp_metrics.c                                                  |    6 
 net/ipv4/tcp_minisocks.c                                                |   16 
 net/ipv4/tcp_output.c                                                   |    8 
 net/ipv4/tcp_timer.c                                                    |    5 
 net/ipv4/udp.c                                                          |   65 
 net/ipv4/udp_bpf.c                                                      |    9 
 net/ipv4/udp_tunnel_nic.c                                               |   32 
 net/ipv4/xfrm4_input.c                                                  |    5 
 net/ipv6/esp6.c                                                         |    8 
 net/ipv6/exthdrs.c                                                      |   26 
 net/ipv6/ioam6.c                                                        |   32 
 net/ipv6/ioam6_iptunnel.c                                               |    9 
 net/ipv6/ip6_flowlabel.c                                                |   20 
 net/ipv6/ip6_gre.c                                                      |    5 
 net/ipv6/ip6_input.c                                                    |    1 
 net/ipv6/ip6_output.c                                                   |   30 
 net/ipv6/ip6mr.c                                                        |    5 
 net/ipv6/netfilter/ip6table_nat.c                                       |    4 
 net/ipv6/netfilter/nft_dup_ipv6.c                                       |    3 
 net/ipv6/route.c                                                        |    6 
 net/ipv6/rpl_iptunnel.c                                                 |    9 
 net/ipv6/seg6_iptunnel.c                                                |    2 
 net/ipv6/syncookies.c                                                   |   11 
 net/ipv6/tcp_ipv6.c                                                     |   43 
 net/ipv6/udp.c                                                          |   50 
 net/ipv6/xfrm6_input.c                                                  |    5 
 net/iucv/af_iucv.c                                                      |   42 
 net/kcm/kcmsock.c                                                       |   21 
 net/l2tp/l2tp_core.c                                                    |   16 
 net/l2tp/l2tp_core.h                                                    |    3 
 net/l2tp/l2tp_debugfs.c                                                 |    4 
 net/l2tp/l2tp_netlink.c                                                 |   20 
 net/l2tp/l2tp_ppp.c                                                     |  141 
 net/mac80211/agg-rx.c                                                   |    2 
 net/mac80211/chan.c                                                     |   37 
 net/mac80211/fils_aead.c                                                |    8 
 net/mac80211/ibss.c                                                     |    9 
 net/mac80211/mesh_pathtbl.c                                             |   16 
 net/mac80211/mlme.c                                                     |   10 
 net/mac80211/rc80211_minstrel_ht.c                                      |   30 
 net/mac80211/sta_info.c                                                 |   85 
 net/mac80211/tx.c                                                       |   11 
 net/mctp/device.c                                                       |   21 
 net/mctp/route.c                                                        |   43 
 net/mpls/af_mpls.c                                                      |   40 
 net/mptcp/options.c                                                     |   70 
 net/mptcp/pm_netlink.c                                                  |   10 
 net/mptcp/pm_userspace.c                                                |   37 
 net/mptcp/protocol.c                                                    |   45 
 net/mptcp/protocol.h                                                    |   11 
 net/ncsi/ncsi-manage.c                                                  |    2 
 net/netfilter/core.c                                                    |    6 
 net/netfilter/ipset/ip_set_bitmap_gen.h                                 |    2 
 net/netfilter/ipvs/ip_vs_conn.c                                         |    3 
 net/netfilter/ipvs/ip_vs_core.c                                         |   11 
 net/netfilter/ipvs/ip_vs_lblc.c                                         |    4 
 net/netfilter/ipvs/ip_vs_lblcr.c                                        |    3 
 net/netfilter/ipvs/ip_vs_sync.c                                         |   33 
 net/netfilter/ipvs/ip_vs_xmit.c                                         |   49 
 net/netfilter/nf_conntrack_bpf.c                                        |   81 
 net/netfilter/nf_conntrack_core.c                                       |   39 
 net/netfilter/nf_conntrack_expect.c                                     |  148 
 net/netfilter/nf_conntrack_h323_main.c                                  |    4 
 net/netfilter/nf_conntrack_helper.c                                     |   10 
 net/netfilter/nf_conntrack_netlink.c                                    |   24 
 net/netfilter/nf_conntrack_sip.c                                        |   13 
 net/netfilter/nf_conntrack_timeout.c                                    |   27 
 net/netfilter/nf_flow_table_ip.c                                        |    3 
 net/netfilter/nf_nat_bpf.c                                              |    3 
 net/netfilter/nf_nat_core.c                                             |   15 
 net/netfilter/nf_synproxy_core.c                                        |   40 
 net/netfilter/nf_tables_api.c                                           |  149 
 net/netfilter/nf_tables_core.c                                          |    6 
 net/netfilter/nf_tables_trace.c                                         |    2 
 net/netfilter/nfnetlink_cttimeout.c                                     |  114 
 net/netfilter/nfnetlink_log.c                                           |   23 
 net/netfilter/nfnetlink_queue.c                                         |  186 
 net/netfilter/nft_bitwise.c                                             |   21 
 net/netfilter/nft_byteorder.c                                           |   16 
 net/netfilter/nft_cmp.c                                                 |    9 
 net/netfilter/nft_compat.c                                              |   33 
 net/netfilter/nft_connlimit.c                                           |    3 
 net/netfilter/nft_counter.c                                             |    3 
 net/netfilter/nft_ct.c                                                  |   24 
 net/netfilter/nft_dup_netdev.c                                          |    3 
 net/netfilter/nft_dynset.c                                              |   28 
 net/netfilter/nft_exthdr.c                                              |    9 
 net/netfilter/nft_fib.c                                                 |   11 
 net/netfilter/nft_fib_netdev.c                                          |   29 
 net/netfilter/nft_flow_offload.c                                        |   14 
 net/netfilter/nft_fwd_netdev.c                                          |    6 
 net/netfilter/nft_hash.c                                                |    4 
 net/netfilter/nft_immediate.c                                           |    3 
 net/netfilter/nft_last.c                                                |    3 
 net/netfilter/nft_limit.c                                               |    5 
 net/netfilter/nft_log.c                                                 |    3 
 net/netfilter/nft_lookup.c                                              |   17 
 net/netfilter/nft_masq.c                                                |    3 
 net/netfilter/nft_meta.c                                                |    5 
 net/netfilter/nft_nat.c                                                 |    3 
 net/netfilter/nft_numgen.c                                              |    6 
 net/netfilter/nft_objref.c                                              |    6 
 net/netfilter/nft_osf.c                                                 |    3 
 net/netfilter/nft_payload.c                                             |    6 
 net/netfilter/nft_queue.c                                               |    6 
 net/netfilter/nft_quota.c                                               |    3 
 net/netfilter/nft_range.c                                               |    3 
 net/netfilter/nft_redir.c                                               |    3 
 net/netfilter/nft_reject.c                                              |    3 
 net/netfilter/nft_rt.c                                                  |    2 
 net/netfilter/nft_set_bitmap.c                                          |    4 
 net/netfilter/nft_set_hash.c                                            |    8 
 net/netfilter/nft_set_pipapo.c                                          |   26 
 net/netfilter/nft_set_rbtree.c                                          |   10 
 net/netfilter/nft_socket.c                                              |    2 
 net/netfilter/nft_synproxy.c                                            |    3 
 net/netfilter/nft_tproxy.c                                              |    2 
 net/netfilter/nft_tunnel.c                                              |    2 
 net/netfilter/nft_xfrm.c                                                |    2 
 net/netfilter/xt_CT.c                                                   |    2 
 net/netfilter/xt_IDLETIMER.c                                            |   52 
 net/netlink/af_netlink.c                                                |    6 
 net/netlink/genetlink.c                                                 |   28 
 net/nfc/nci/core.c                                                      |    9 
 net/openvswitch/actions.c                                               |    7 
 net/openvswitch/conntrack.c                                             |   71 
 net/openvswitch/datapath.c                                              |    8 
 net/packet/af_packet.c                                                  |  103 
 net/phonet/socket.c                                                     |   10 
 net/qrtr/mhi.c                                                          |   61 
 net/rds/rdma_transport.c                                                |   38 
 net/rds/tcp.c                                                           |   66 
 net/rxrpc/ar-internal.h                                                 |    9 
 net/rxrpc/call_accept.c                                                 |    5 
 net/rxrpc/conn_event.c                                                  |   34 
 net/rxrpc/output.c                                                      |   12 
 net/rxrpc/peer_event.c                                                  |   17 
 net/rxrpc/proc.c                                                        |    4 
 net/rxrpc/recvmsg.c                                                     |   16 
 net/rxrpc/rxkad.c                                                       |    5 
 net/sched/act_api.c                                                     |   46 
 net/sched/act_ife.c                                                     |   32 
 net/sched/act_mirred.c                                                  |   14 
 net/sched/act_pedit.c                                                   |   11 
 net/sched/cls_api.c                                                     |   93 
 net/sched/cls_basic.c                                                   |    6 
 net/sched/cls_bpf.c                                                     |    8 
 net/sched/cls_cgroup.c                                                  |    2 
 net/sched/cls_flow.c                                                    |    2 
 net/sched/cls_flower.c                                                  |   34 
 net/sched/cls_fw.c                                                      |    4 
 net/sched/cls_matchall.c                                                |    6 
 net/sched/cls_route.c                                                   |    4 
 net/sched/cls_u32.c                                                     |   23 
 net/sched/em_text.c                                                     |    3 
 net/sched/sch_cake.c                                                    |    2 
 net/sched/sch_codel.c                                                   |   14 
 net/sched/sch_drr.c                                                     |    2 
 net/sched/sch_ets.c                                                     |    2 
 net/sched/sch_fifo.c                                                    |   13 
 net/sched/sch_fq.c                                                      |   18 
 net/sched/sch_fq_codel.c                                                |   18 
 net/sched/sch_fq_pie.c                                                  |   14 
 net/sched/sch_generic.c                                                 |   47 
 net/sched/sch_gred.c                                                    |    4 
 net/sched/sch_hfsc.c                                                    |    2 
 net/sched/sch_hhf.c                                                     |   12 
 net/sched/sch_htb.c                                                     |    2 
 net/sched/sch_multiq.c                                                  |    2 
 net/sched/sch_netem.c                                                   |    5 
 net/sched/sch_pie.c                                                     |   12 
 net/sched/sch_plug.c                                                    |    2 
 net/sched/sch_prio.c                                                    |    2 
 net/sched/sch_qfq.c                                                     |    2 
 net/sched/sch_sfb.c                                                     |    2 
 net/sched/sch_sfq.c                                                     |    2 
 net/sctp/bind_addr.c                                                    |   11 
 net/sctp/inqueue.c                                                      |    6 
 net/sctp/ipv6.c                                                         |   10 
 net/sctp/protocol.c                                                     |    5 
 net/sctp/sm_make_chunk.c                                                |   17 
 net/sctp/sm_statefuns.c                                                 |   36 
 net/sctp/socket.c                                                       |   39 
 net/smc/af_smc.c                                                        |  117 
 net/smc/smc.h                                                           |    6 
 net/strparser/strparser.c                                               |    6 
 net/sunrpc/auth_gss/gss_krb5_mech.c                                     |   17 
 net/sunrpc/auth_gss/gss_krb5_unseal.c                                   |    3 
 net/sunrpc/auth_gss/gss_rpc_xdr.c                                       |   15 
 net/sunrpc/auth_gss/svcauth_gss.c                                       |  137 
 net/sunrpc/clnt.c                                                       |   22 
 net/sunrpc/svc.c                                                        |   13 
 net/sunrpc/svcsock.c                                                    |    3 
 net/sunrpc/xdr.c                                                        |    7 
 net/sunrpc/xprtrdma/svc_rdma_pcl.c                                      |    2 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                                 |   22 
 net/sunrpc/xprtrdma/svc_rdma_rw.c                                       |   36 
 net/sunrpc/xprtrdma/svc_rdma_sendto.c                                   |   47 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                                |  123 
 net/sunrpc/xprtsock.c                                                   |   29 
 net/tipc/core.c                                                         |    4 
 net/tipc/crypto.c                                                       |   20 
 net/tipc/node.c                                                         |   12 
 net/tipc/topsrv.c                                                       |   80 
 net/tipc/udp_media.c                                                    |   75 
 net/tls/tls_device.c                                                    |    4 
 net/tls/tls_sw.c                                                        |    2 
 net/vmw_vsock/af_vsock.c                                                |   55 
 net/vmw_vsock/virtio_transport_common.c                                 |    3 
 net/wireless/core.c                                                     |   39 
 net/wireless/core.h                                                     |    4 
 net/wireless/lib80211_crypt_tkip.c                                      |   13 
 net/wireless/nl80211.c                                                  |   13 
 net/wireless/pmsr.c                                                     |    6 
 net/wireless/scan.c                                                     |   38 
 net/wireless/sme.c                                                      |    6 
 net/xfrm/espintcp.c                                                     |    1 
 net/xfrm/xfrm_device.c                                                  |   19 
 net/xfrm/xfrm_input.c                                                   |   15 
 net/xfrm/xfrm_policy.c                                                  |   21 
 net/xfrm/xfrm_state.c                                                   |  144 
 net/xfrm/xfrm_user.c                                                    |   10 
 samples/ftrace/ftrace-direct-multi-modify.c                             |   13 
 samples/pidfd/Makefile                                                  |    2 
 security/apparmor/domain.c                                              |   27 
 security/apparmor/include/cred.h                                        |    6 
 security/apparmor/include/label.h                                       |    6 
 security/apparmor/include/match.h                                       |   12 
 security/apparmor/include/policy.h                                      |    2 
 security/apparmor/include/task.h                                        |   17 
 security/apparmor/match.c                                               |   22 
 security/apparmor/policy.c                                              |   21 
 security/apparmor/task.c                                                |   32 
 security/integrity/ima/ima_appraise.c                                   |   21 
 security/integrity/ima/ima_kexec.c                                      |   35 
 security/keys/key.c                                                     |   19 
 security/keys/keyctl.c                                                  |   15 
 security/keys/keyring.c                                                 |  152 
 security/keys/persistent.c                                              |   55 
 security/keys/process_keys.c                                            |    5 
 security/keys/trusted-keys/trusted_tpm1.c                               |    6 
 security/keys/trusted-keys/trusted_tpm2.c                               |    2 
 security/landlock/fs.c                                                  |   10 
 security/selinux/avc.c                                                  |    5 
 security/selinux/hooks.c                                                |    9 
 security/selinux/selinuxfs.c                                            |   40 
 security/selinux/ss/policydb.c                                          |    4 
 sound/core/oss/mixer_oss.c                                              |   32 
 sound/core/oss/pcm_oss.c                                                |   29 
 sound/core/seq/oss/seq_oss_event.c                                      |    6 
 sound/core/seq/oss/seq_oss_event.h                                      |    3 
 sound/core/seq/oss/seq_oss_ioctl.c                                      |    5 
 sound/core/seq/oss/seq_oss_midi.c                                       |    6 
 sound/core/seq/oss/seq_oss_midi.h                                       |    2 
 sound/core/seq/oss/seq_oss_readq.c                                      |   83 
 sound/core/seq/oss/seq_oss_rw.c                                         |    5 
 sound/core/seq/seq_clientmgr.c                                          |   60 
 sound/core/seq/seq_compat.c                                             |    4 
 sound/core/seq/seq_fifo.c                                               |   98 
 sound/core/seq/seq_fifo.h                                               |    1 
 sound/drivers/mtpav.c                                                   |    6 
 sound/pci/hda/cs35l41_hda.c                                             |   74 
 sound/pci/hda/cs35l41_hda.h                                             |    4 
 sound/soc/amd/acp/acp-mach-common.c                                     |  355 -
 sound/soc/amd/yc/acp6x-mach.c                                           |    7 
 sound/soc/codecs/adau1372.c                                             |   18 
 sound/soc/codecs/cs42l52.c                                              |    2 
 sound/soc/codecs/cs42l56.c                                              |    2 
 sound/soc/codecs/hdac_hda.c                                             |    4 
 sound/soc/codecs/max98371.c                                             |    2 
 sound/soc/codecs/nau8822.c                                              |    4 
 sound/soc/codecs/pcm3168a.c                                             |    2 
 sound/soc/codecs/rt274.c                                                |    4 
 sound/soc/codecs/rt286.c                                                |    2 
 sound/soc/codecs/tas2562.c                                              |    8 
 sound/soc/codecs/wm8903.c                                               |    2 
 sound/soc/codecs/wm8978.c                                               |    4 
 sound/soc/intel/avs/pcm.c                                               |    6 
 sound/soc/qcom/lpass-cdc-dma.c                                          |    2 
 sound/soc/qcom/lpass-cpu.c                                              |    4 
 sound/soc/qcom/qdsp6/q6asm.c                                            |    5 
 sound/soc/samsung/i2s.c                                                 |    8 
 sound/soc/soc-topology.c                                                |   37 
 sound/soc/sof/intel/hda.c                                               |    5 
 sound/soc/sof/ipc4-pcm.c                                                |   17 
 sound/soc/sof/ipc4-topology.c                                           |    7 
 sound/soc/stm/stm32_spdifrx.c                                           |    2 
 sound/soc/tegra/tegra186_asrc.c                                         |    2 
 sound/usb/caiaq/device.c                                                |    3 
 sound/usb/card.h                                                        |    3 
 sound/usb/endpoint.c                                                    |   16 
 sound/usb/line6/playback.c                                              |    7 
 sound/usb/misc/ua101.c                                                  |    9 
 sound/usb/pcm.c                                                         |    3 
 sound/usb/quirks.c                                                      |    4 
 tools/gpio/Makefile                                                     |    6 
 tools/perf/tests/bpf.c                                                  |    3 
 tools/perf/util/parse-events.c                                          |    2 
 tools/testing/cxl/test/cxl.c                                            |   14 
 tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c                       |    4 
 tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c                       |    4 
 tools/testing/selftests/bpf/progs/test_global_func16.c                  |    2 
 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c                   |   11 
 tools/testing/selftests/bpf/verifier/basic_stack.c                      |   12 
 tools/testing/selftests/bpf/verifier/calls.c                            |    4 
 tools/testing/selftests/bpf/verifier/raw_stack.c                        |    8 
 tools/testing/selftests/bpf/verifier/var_off.c                          |   57 
 tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc |   24 
 tools/testing/selftests/net/forwarding/tc_actions.sh                    |    3 
 tools/testing/selftests/net/tls.c                                       |  584 +
 tools/testing/selftests/vm/memfd_secret.c                               |   30 
 virt/kvm/kvm_main.c                                                     |    3 
 1903 files changed, 30596 insertions(+), 45151 deletions(-)

Aakash Kumar S (1):
      xfrm: Duplicate SPI Handling

Aamir Ahmed (1):
      wifi: wfx: validate MIB read length before copying to caller

Aaron Ahmed (1):
      ftrace: Initialize modname and offset in print_rec()

Abd-Alrhman Masalkhi (3):
      md/raid10: fix writes_pending and barrier reference leaks on discard failures
      md/raid10: fix writes_pending leak on write request failures
      md/raid1: fix writes_pending and barrier reference leaks on write failures

Abdul Wasey (1):
      mptcp: move the OoO check back into __mptcp_try_fallback()

Abdun Nihaal (2):
      mfd: sm501: Fix potential memory leaks during remove
      platform/x86: int1092: Fix potential memory leak in sar_probe()

Abdurrahman Hussain (4):
      of/overlay: put property on deadprops only after changeset add succeeds
      of/overlay: only treat a positive changeset id as registered
      of/overlay: don't leak fragment references when changeset init fails
      of/overlay: don't create "//" paths for fragments targeting the root

Abhishek Ojha (1):
      regulator: ltc3676: don't read the write-only HRST and CLIRQ registers

Abhishek Pandit-Subedi (1):
      usb: typec: ucsi: Limit read size on v1.2

Adam Ford (1):
      pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock to hdmimix domain

Aditya Dutt (1):
      jfs: fix array-index-out-of-bounds read in add_missing_indices

Aditya Prakash Srivastava (2):
      ext4: fix kernel BUG in ext4_write_inline_data_end
      ext4: fix ABBA deadlock in ext4_xattr_inode_cache_find()

Adrian Betschart (1):
      drm/amd/display: Don't replace a sink mode that shares the native totals

Adrian Hunter (6):
      i3c: master: Do not treat master device as a duplicate target
      i3c: master: Fix use-after-free of master->this
      i3c: mipi-i3c-hci: Correct RING_CTRL_ABORT handling in DMA dequeue
      i3c: mipi-i3c-hci: Fix race in DMA ring dequeue
      i3c: master: Fix recursive locking during device registration
      i3c: mipi-i3c-hci: Preserve RUN bit when aborting DMA ring

Adrian Martinez (1):
      KEYS: Fix key_reject_and_link() race with keyring restriction

Aharon Landau (2):
      RDMA/mlx5: Don't keep umrable 'page_shift' in cache entries
      RDMA/mlx5: Remove implicit ODP cache entry

Ahmed Abdelhaleem Ahmed (1):
      scsi: ch: Do not keep references to data transfer element devices

Ahsan Atta (1):
      crypto: qat - protect service table iterations with service_lock

Ajay.Kathat@microchip.com (1):
      wifi: wilc1000: avoid buffer overflow in WID string configuration

Akihiko Odaki (1):
      tap: Keep hdr_len in tap_get_user()

Akiva Goldberger (1):
      mlx5: Fix default values in create CQ

Al Viro (4):
      xen: fix UAF in dmabuf_exp_from_pages()
      habanalabs: fix UAF in export_dmabuf()
      functionfs, gadgetfs: use simple_recursive_removal()
      functionfs: fix the open/removal races

Alan Stern (1):
      USB: gadget: dummy-hcd: Fix wait for outstanding request completions

Aldo Ariel Panzardo (1):
      Bluetooth: mgmt: fix race in read_unconf_index_list()

Aleksandr Khromov (3):
      ksmbd: fill in FileSysIdentifier in FS_POSIX_INFORMATION
      ksmbd: initialize FileSystemControlFlags in FS_CONTROL_INFORMATION
      ksmbd: zero the FS_OBJECT_ID_INFORMATION buffer before filling it in

Aleksandr Mishin (1):
      drm/msm/dpu: Add callback function pointer check before its call

Alex Bereza (1):
      dmaengine: xilinx_dma: Fix CPU stall in xilinx_dma_poll_timeout

Alex Deucher (1):
      drm/amdgpu: make Mac FB workaround generic

Alex Hung (9):
      drm/amd/display: Validate function returns
      drm/amd/display: Check index for aux_rd_interval before using
      drm/amd/display: Ensure array index tg_inst won't be -1
      drm/amd/display: Avoid overflow from uint32_t to uint8_t
      drm/amd/display: Check null pointers before multiple uses
      drm/amd/display: Check null pointers before used
      drm/amd/display: Check null pointers before using them
      drm/amd/display: Pass non-null to dcn20_validate_apply_pipe_split_flags
      drm/amd/display: Check link_index before accessing dc->links[]

Alexander Aring (4):
      dlm: fix add msg handle in send_queue ordered
      fs: dlm: use listen sock as dlm running indicator
      fs: dlm: remove socket shutdown handling
      fs: dlm: cleanup listen sock handling

Alexander Gordeev (1):
      kasan: avoid sleepable page allocation from atomic context

Alexander Stein (1):
      gpio: mxc: use BIT() macro

Alexander Sverdlin (1):
      spi: lpspi: Avoid potential use-after-free in probe()

Alexander Usyskin (2):
      mtd: call external _get and _put in right order
      mtd: fix use-after-free in mtd release

Alexandra Winter (1):
      s390/ism: Fix UAF of sba and ieq during ism_dev_exit()

Alexey Dobriyan (1):
      uapi: stddef.h: Fix header guard location

Ali Ahmet Memis (1):
      Bluetooth: ISO: zero the sockaddr before returning it in getname

Allen Pan (1):
      drm/amd/display: Add a dc_state NULL check in dc_state_release

Allison Henderson (2):
      net/rds: Fix circular locking dependency in rds_tcp_tune
      net/rds: don't let the rdma_cm destroy an id RDS still owns on route failure

Alvin Šipraga (2):
      ASoC: adau1372: allow sleepy powerdown GPIOs
      ASoC: adau1372: fix invalid default state of output ASRC and DAC muxes

Alysa Liu (1):
      drm/amdkfd: Add upper bound check for num_of_nodes

Amir Goldstein (2):
      fsnotify: fix inode reference leak in fsnotify_recalc_mask()
      ovl: check access to copy_file_range source with src mounter creds

Amir Shetaia (1):
      drm/amdkfd: Clear VRAM on allocation to prevent stale data exposure

Amirmohammad Eftekhar (1):
      KVM: nVMX: Reset MMU back to the root MMU if loading L2 state fails for !VM-Entry

Amit Machhiwal (1):
      tracing: Do not initialize tracefs work if tracing is disabled

Amit Sunil Dhamne (2):
      usb: typec: tcpm: recover after failure to start the frs ams
      usb: typec: tcpm: constrain TCPM_SOURCING_VBUS event handling

Anand Jain (3):
      btrfs: rename ret to err in btrfs_recover_relocation()
      btrfs: rename ret to ret2 in btrfs_recover_relocation()
      btrfs: rename err to ret in btrfs_recover_relocation()

Anastasia Belova (1):
      cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value

Andre Eikmeyer (1):
      drm/amdgpu: reset VI ASIC on MacBookPro15,1

Andre Przywara (1):
      clk: sunxi-ng: h616: Reparent CPU clock during frequency changes

Andre Werner (1):
      net: phy: phy_device: Prevent nullptr exceptions on ISR

Andrea Mayer (1):
      ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_srh_rcv()

Andreas Gruenbacher (1):
      gfs2: Fix potential glock use-after-free on unmount

Andrei Matei (1):
      bpf: Fix accesses to uninit stack slots

Andrew Davis (1):
      power: supply: lp8788: Use devm_power_supply_register() helper

Andrey Konovalov (1):
      kasan: use unchecked __memset internally

Andrey Misiurov (1):
      scsi: lpfc: Fix use-after-free of mboxq in lpfc_sli4_driver_resource_setup()

Andrii Nakryiko (1):
      bpf: support deferring bpf_link dealloc to after RCU grace period

Andrzej Pietrasiewicz (1):
      usb: gadget: function: Simplify diagnostic messaging in printer

Andy Shevchenko (5):
      params: Do not go over the limit when getting the string length
      params: Use size_add() for kmalloc()
      params: Sort headers
      params: Fix multi-line comment style
      i915: Move list_count() to list.h as list_count_nodes() for broader use

Aneesh Kumar K.V (Arm) (1):
      dma-direct: return struct page from dma_direct_alloc_from_pool()

Angel Iglesias (1):
      i2c: core: Introduce i2c_client_get_device_id helper function

Ankit Soni (1):
      iommu/amd: move wait_on_sem() out of spinlock

Anna Maniscalco (1):
      drm/msm: always recover the gpu

Anshumali Gaur (1):
      octeontx2-vf: fix workqueue and netdev race in probe/remove

Anthony Krowiak (4):
      s390/vfio-ap: Fix NULL deref in status_show() during queue probe
      s390/vfio-ap: Fix missing lock required to access list of ap_matrix_mdev objects
      s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL
      s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()

Antoine Tenart (1):
      net: decrease cached dst counters in dst_release

Aohan Mei (4):
      netfilter: nf_tables: skip expired catchall elements on insert and delete
      netfilter: nft_flow_offload: drop flowtable reference on init error path
      net: rds: fix uninitialized trans dereference in CM event handler
      net/sched: cls_flower: validate mask pointer after nla_next()

April Cardenas (1):
      smb/client: send lease break ACKs thru correct session for multiuser mounts

Arka Mondal (3):
      iio: gyro: adis16136: fix unprotected debugfs reads
      iio: imu: adis16400: fix unprotected debugfs reads
      iio: imu: adis16480: fix unprotected debugfs reads

Armin Wolf (3):
      ACPI: battery: Pass battery hook pointer to hook callbacks
      platform/x86: lg-laptop: Fix LED resource handling
      platform/x86: dell-wmi-base: Fix handling of ultra performance key

Arnaldo Carvalho de Melo (1):
      perf test bpf: Address error about non-null argument for epoll_pwait 2nd arg

Arnaud Lecomte (1):
      bpf: Fix stackmap overflow check in __bpf_get_stackid()

Arnd Bergmann (2):
      mips: unhide uasm_in_compat_space_p() declaration
      arch: turn off -Werror for architectures with known warnings

Asad Kamal (2):
      drm/amd/powerplay: fix VoltageObjectInfo zero-stride loop and OOB read
      drm/amdgpu: fix aperture mapping leak

Asbjørn Sloth Tønnesen (2):
      net: sched: cls_api: add skip_sw counter
      net: sched: cls_api: add filter counter

Asim Viladi Oglu Manizada (1):
      ksmbd: fix OOB write in QUERY_INFO for compound requests

Aswin Karuvally (1):
      s390/ctcm: Prevent XID null dereference

Atish Patra (1):
      perf: RISC-V: Define helper functions expose hpm counter width and count

Aurabindo Pillai (1):
      drm/amd/display: Fix null pointer deref in dcn20_resource.c

Avi Weiss (1):
      ASoC: stm32: spdifrx: fix synchronization state check

Aviv Vaknin (1):
      pid_namespace: make zap_pid_ns_processes() freezable

Baha Mesleh (1):
      octeontx2-af: mcs: Fix SC resource cleanup loop

Baineng Shou (1):
      dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds

Baokun Li (3):
      ext4: refactoring to use the unified helper ext4_quotas_off()
      ext4: fix uninitialized ratelimit_state->lock access in __ext4_fill_super()
      fuse: check for NULL root inode in fuse_fill_super_submount

Baoli.Zhang (1):
      soundwire: fix bug in sdw_add_element_group_count found by syzkaller

Baolin Wang (1):
      mm: migrate: fix getting incorrect page mapping during page migration

Baoquan He (1):
      s390/mm: do not include <asm-generic/io.h> directly

Bard Liao (1):
      ASoC: SOF: Intel: hda-dai: Ensure DAI widget is valid during params

Bartosz Golaszewski (1):
      gpio: mxc: use lock guards for the generic GPIO chip lock

Bastien Nocera (1):
      HID: hid-alps: Use pm_ptr instead of #ifdef CONFIG_PM

Beata Michalska (2):
      arm64: errata: Factor out broken AMU const counter cap
      arm64: errata: Add Cortex-A725 erratum 3821522 workaround

Ben Cressey (3):
      dm-crypt: reject the lmk IV mode with AEAD ciphers
      dm-crypt: fix a tiny race condition in crypt_dec_pending
      dm-integrity: fix infinite loop on discard with large tag size

Ben Dooks (1):
      riscv: save the SR_SUM status over switches

Ben Levinsky (2):
      mailbox: zynqmp: Move of_match structure closer to usage
      mailbox: zynqmp: Move buffered IPI setup to of_match selected routine

Bence Csókás (1):
      dmaengine: Add devm_dma_request_chan()

Benjamin Berg (1):
      wifi: cfg80211: avoid double free if updating BSS fails

Benjamin Cheng (1):
      drm/amdgpu/vcn4: Prevent OOB reads when parsing IB

Benjamin Coddington (1):
      Treewide: Stop corrupting socket's task_frag

Benjamin Marzinski (1):
      dm cache: fix issue with background work locking

Benjamin Poirier (3):
      nexthop: Factor out hash threshold fdb nexthop selection
      nexthop: Factor out neighbor validity check
      nexthop: Do not return invalid nexthop object during multipath selection

Benjamin Tissoires (1):
      HID: core: introduce hid_safe_input_report()

Bernard Metzler (1):
      RDMA/siw: Fix endpoint/socket association handling

Bert Karwatzki (1):
      wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_change

Binbin Deng (1):
      net/mctp: publish the mctp_dev only after it is initialised

Bitterblue Smith (1):
      wifi: rtw88: Use devm_kmemdup() in rtw_set_supported_band()

Bjoern Doebel (2):
      smb: client: fix heap overflow in DACL owner/group rewrite
      smb: client: fail DACL rewrite when the new DACL exceeds 64K

Bob Zhou (1):
      drm/amdgpu: fix double free err_addr pointer warnings

Boris Brezillon (1):
      drm/panfrost: Fix the error path in panfrost_mmu_map_fault_addr()

Boris Burkov (3):
      btrfs: fix block group refcount race in btrfs_create_pending_block_groups()
      btrfs: harden block_group::bg_list against list_del() races
      btrfs: fix EEXIST abort due to non-consecutive gaps in chunk allocation

Breno Leitao (4):
      usb: xhci: bail out of setup if the controller is inaccessible
      spi: tegra210-quad: Protect curr_xfer check in IRQ handler
      netpoll: fix a use-after-free on shutdown path
      mm/kmemleak: avoid soft lockup when scanning task stacks

Bryam Vargas (7):
      nvmet: fix pre-auth out-of-bounds heap read in Discovery Get Log Page
      selinux: reject a permission value exceeding the class permission count
      crypto: virtio - bound the akcipher result length
      wifi: mt76: mt7915: bound the device EEPROM address before the EFUSE copy
      dm array: validate array block headers on read
      smb: client: reject a tree connect response whose byte count is too small
      net/iucv: fix the recvmsg window update

Can Peng (2):
      hwrng: stm32 - Fix runtime PM cleanup on registration failure
      spi: bcm63xx: disable clock on resume failure

Candice Li (3):
      drm/amdgpu: reject oversized IBs with per-ring packet limits
      drm/amdgpu: Bound GPIO I2C table entry count from VBIOS
      drm/amdgpu: validate and share PSP fw_pri_buf copies via psp_copy_fw

Carlo Szelinsky (1):
      USB: serial: option: add Quectel EG060W

Carlos Jones Jr (1):
      spi: tegra114: assert CS GPIO for every transfer in a message

Carlos Llamas (1):
      HID: uhid: convert to hid_safe_input_report()

Carlos Maiolino (1):
      xfs: fix capability check in xfs

Cen Zhang (13):
      Bluetooth: hci_sync: annotate data-races around hdev->req_status
      wifi: cfg80211: use wiphy work for socket owner autodisconnect
      Bluetooth: 6lowpan: avoid untracked enable work
      ALSA: seq: avoid stale FIFO cells during resize
      ALSA: seq: oss: Serialize readq reset state with q->lock
      Bluetooth: 6lowpan: hold L2CAP conn across debugfs control
      ocfs2/cluster: keep heartbeat local node stable
      ocfs2: o2hb: quiesce negotiate handlers and timeout work
      ocfs2/dlm: Protect the recovery list during debugfs reads
      keys: Avoid the owner account dereference in named keyring lookup
      keys: Check the authorization payload in process keyring searches
      keys: Protect the type name while describing a key
      keys: Protect the read method check against type removal

Cen Zhang (Microsoft Security FORGE Labs) (3):
      ksmbd: fix tree connection use-after-free in smb2_tree_connect()
      tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
      tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)

Cen Zhang (Microsoft) (3):
      net/sched: cls_u32: validate offshift to prevent shift-out-of-bounds
      watch_queue: Fix note pool publication race in watch_queue_set_size()
      rds: tcp: unregister sysctl before tearing down listen socket

Cezary Rojewski (3):
      ASoC: codecs: rt286: Revert delay value for jack setup
      ASoC: codecs: rt274: Fix format setting for 44100 rate
      ASoC: Intel: avs: Do not share the name pointer between components

Chaitanya Kulkarni (2):
      blktrace: fix __this_cpu_read/write in preemptible context
      nvmet: move async event work off nvmet-wq

Chandrashekar Devegowda (1):
      Bluetooth: btintel: fix buffer over-read in btintel_hw_error()

Chao Yu (16):
      f2fs: embed f2fs_gc_kthread in f2fs_sb_info
      f2fs: don't reset unchangable mount option in f2fs_remount()
      f2fs: fix to do sanity check on direct node in truncate_dnode()
      f2fs: introduce f2fs_invalidate_internal_cache() for cleanup
      f2fs: fix to truncate meta inode pages forcely
      f2fs: fix to shrink read extent node in batches
      f2fs: fix to cover read extent cache access with lock
      f2fs: fix to do sanity check on F2FS_INLINE_DATA flag in inode during GC
      f2fs: fix to drop all discards after creating snapshot on lvm device
      f2fs: fix to do sanity check on node blkaddr in truncate_node()
      f2fs: convert f2fs_handle_page_eio() to use folio
      f2fs: fix potential deadloop in prepare_compress_overwrite()
      f2fs: fix to avoid overflow while left shift operation
      f2fs: fix to truncate first page in error path of f2fs_truncate()
      f2fs: fix to clear dirty flag on folio in error path
      f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()

Charles Vosburgh (1):
      sctp: validate chunk length in the inqueue parser

Chen Changcheng (1):
      HID: alps: unregister DualPoint Stick input device on remove

Chen Cheng (2):
      md/raid5: avoid R5_Overlap races while breaking stripe batches
      dm-integrity: require stable writes for internal hash modes

Chen Ni (2):
      usb: ohci-spear: Remove unnecessary NULL check before clk_disable_unprepare()
      ASoC: amd: acp-mach-common: Add missing error check for clock acquisition

Chen Ridong (2):
      cgroup/cpuset: introduce cpuset-v1.c
      cgroup/cpuset: move common code to cpuset-internal.h

Chen-Yu Tsai (1):
      pinctrl: mediatek: paris: bypass pinctrl GPIO layer in set GPIO direction

ChenXiaoSong (2):
      smb/client: use stack-allocated smb2_file_all_info in smb3_query_mf_symlink()
      smb/client: pass cifs_open_info_data to SMB2_open()

Cheng Xu (1):
      RDMA/erdma: Hold QP references for AE and CM processing

Chengfeng Ye (12):
      KEYS: trusted: Fix TPM teardown ordering
      Bluetooth: RFCOMM: Fix initial port reference race
      Bluetooth: hci_conn: Lock parent access during enhanced SCO setup
      Bluetooth: hci_core: Serialize ACL scheduling with channel deletion
      Bluetooth: hci_core: Serialize fragmented ISO packet queueing
      tipc: hold a reference to nodes found by link name
      net/smc: protect clcsock lifetime in smc_getname
      Bluetooth: hci_sock: Serialize dead-device detachment
      Bluetooth: ISO: Serialize concurrent connect calls
      bpf: Fix netns reference imbalance in conntrack kfuncs
      netfilter: cttimeout: prevent UAF during module unload
      tipc: protect node reset trace dump with node lock

Chenguang Zhao (1):
      net: ethernet: mtk_eth_soc: pass eth to mtk_handle_irq_rx in poll_controller

Chris Mason (7):
      nfsd: release path refs on follow_down() error
      nfsd: size fh_verify server sockaddr slot by xpt_locallen
      SUNRPC: fix gssx_dec_option_array error path bugs
      SUNRPC: reject duplicate CREDS_VALUE options
      SUNRPC: svcauth_gss: enforce krb5 token minimum length
      nfsd: gate nfs3 setacl by argp->mask
      svcrdma: Reject Write/Reply chunks with segcount 0

Chris Park (1):
      drm/amd/display: Prevent crash when disable stream

Christian Borntraeger (2):
      KVM: s390: Zero initialize data structures for inject_pfault_token
      KVM: s390: Fix memory corruption by not reinjecting CK machine checks

Christian Brauner (20):
      io-wq: order the exit bit against worker creation task work
      fs: refuse fspick() on internal superblocks
      namespace: check a submount for references right before unmounting it
      dcache: don't put a mountpoint on a dentry that's being removed
      namespace: refuse an automount below a mount that is in no namespace
      namespace: don't inherit MNT_UMOUNT in clone_mnt()
      namespace: check the mounts before reading their parents in pivot_root()
      namespace: unhash a dentry before detaching the mounts on it
      namespace: don't copy an unmounted mount tree
      namespace: check the target before walking it in do_mount_setattr()
      fcntl: refuse F_SET_RW_HINT on an immutable inode
      namespace: handle mount locking for automounts correctly
      fs: refuse O_TMPFILE creation with an unmapped fsuid or fsgid
      unicode: free the map after a grace period
      ext4: free the sbi after a grace period
      coredump: hold RCU while releasing parked threads
      signal: don't retarget shared signals in a dying thread group
      signal: only SIGKILL and the freezers interrupt a coredumping task
      signal: allow taks to temporarily block TIF_NOTIFY_SIGNAL
      pid_namespace: prevent TIF_NOTIFY_SIGNAL from interrupting the reaper

Christian Bruel (1):
      PCI: endpoint: pci-epf-test: Fix double free that causes kernel to oops

Christian Göttsche (2):
      selinux: fix data race on AVC latest_notif
      selinux: avoid dereference of garbage after mount failure

Christian König (1):
      drm/amdgpu: hide VRAM sysfs attributes on GPUs without VRAM

Christian Schoenebeck (1):
      fs/9p: fix NULL pointer dereference on mkdir

Christoph Hellwig (2):
      xfs: remove xfs_attr_leaf_hasname
      dma-direct: simplify the use atomic pool logic in dma_direct_alloc

Christoph Schlameuss (1):
      kvm: s390: Reject memory region operations for ucontrol VMs

Christophe JAILLET (4):
      kernel/params.c: Use kstrtobool() instead of strtobool()
      watchdog: rtd119x: Use devm_clk_get_enabled() helper
      drm/amdgpu: Remove usage of the deprecated ida_simple_xx() API
      wifi: mt76: mt7915: Fix an error handling path in mt7915_add_interface()

Christopher Lusk (1):
      smb: client: fix request buffer leak in smb2_new_read_req()

Chuck Lever (17):
      nfsd: gate nfs2 setacl by argp->mask
      svcrdma: Allocate new transports on device's NUMA node
      svcrdma: Refactor the creation of listener CMA ID
      svcrdma: Use svc_xprt_put to free listener on create failure
      svcrdma: Reject inline replies that overflow the pull-up buffer
      svcrdma: Handle ADDR_CHANGE CM event properly
      svcrdma: Reject connection when transport allocation fails
      SUNRPC: Reject short RFC 4121 MIC tokens in gss_krb5_verify_mic_v2
      SUNRPC: Fix crasher in unwrap_integ_data()
      SUNRPC: Rename automatic variables in unwrap_priv_data()
      SUNRPC: Convert unwrap_priv_data() to use xdr_stream
      NFSD: Prevent client use-after-free during delegation revoke
      NFSD: check truncate permission under inode lock
      svcrdma: Validate Read chunk positions before reconstruction
      svcrdma: Reject Read lists that exceed the page budget
      NFSD: Prevent client use-after-free during close_lru reaping
      NFS: Return a delegation the client fails to record

Chunguang Xu (1):
      nvme-fabrics: use reserved tag for reg read/write command

Chunguang.xu (1):
      nvme-rdma: unquiesce admin_q before destroy it

Clément Léger (1):
      of/irq: add missing of_node_put() for interrupt parent node

Coiby Xu (1):
      ima: don't clear IMA_DIGSIG flag when setting or removing non-IMA xattr

Colin Ian King (1):
      ASoC: qcom: Fix uninitialized pointer dmactl

Cong Nguyen (3):
      iio: proximity: pulsedlight: fix iio_device left registered on PM setup failure
      iio: adc: max1363: sign-extend bipolar differential channel reads
      staging: rtl8723bs: fix xmit_frame/xmit_buf leaks on mgnt-frame error paths

Cong Wang (1):
      bpf: Fix a potential use-after-free in bpf_link_free()

Conor Dooley (1):
      spi: microchip-core-qspi: control built-in cs manually

Cristian Marussi (11):
      firmware: arm_scmi: Simplify chan_available transport operation
      firmware: arm_scmi: Use dedicated devices to initialize channels
      firmware: arm_scmi: Move protocol registration helpers
      firmware: arm_scmi: Add common notifier helpers
      firmware: arm_scmi: Refactor protocol device creation
      firmware: arm_scmi: Move handle get/set helpers
      firmware: arm_scmi: Refactor device create/destroy helpers
      firmware: arm_scmi: Move errors defs and code to common.h
      firmware: arm_scmi: Add internal platform/channel identifiers
      firmware: arm_scmi: Add multiple protocols registration support
      firmware: arm_scmi: Introduce a new lifecycle for protocol devices

Cássio Gabriel (2):
      ALSA: hda/cs35l41: Fix firmware load work teardown
      ASoC: topology: Check PCM and DAI name strings before use

Cédric Bellegarde (1):
      ASoC: qcom: q6asm: drop DSP responses for closed data streams

D. Wythe (2):
      net/smc: fix UAF on smcsk after smc_listen_out()
      Revert "net/smc: Introduce TCP ULP support"

Daeho Jeong (2):
      f2fs: fix to migrate all curseg types during free_segment_range
      f2fs: accurately adjust free_sections during free_segment_range

Daehyeon Ko (10):
      wifi: libipw: reject TKIP frames without a full MIC
      nvme-multipath: fix underflow in ANA log bounds checks
      thunderbolt: Reject oversized XDomain properties responses
      ipv4: stop PMTU walk when nexthop group shrinks
      ipv4: stop route notification sizing when nexthop group shrinks
      ipv4: do not warn on route notification size race
      ipv6: do not warn on route notification size race
      ip6_gre: remove obsolete ERSPAN PMTU update
      sctp: revalidate output stream after association connect wait
      vsock/virtio: validate packet source for connected sockets

Damien Le Moal (6):
      ata: libata-scsi: avoid Non-NCQ command starvation
      nvmet: Introduce nvmet_req_transfer_len()
      scsi: block: ioprio: Clean up interface definition
      ata: libata-core: fix cancellation of a port deferred qc work
      scsi: block: Introduce ioprio hints
      scsi: block: Improve ioprio value validity checks

Damien Riégel (2):
      greybus: raw: fix use-after-free on cdev close
      greybus: raw: fix use-after-free if write is called after disconnect

Dan Carpenter (5):
      drm/mediatek: Fix potential NULL dereference in mtk_crtc_destroy()
      HID: hid-steam: Fix cleanup in probe()
      drm/msm/gem: prevent integer overflow in msm_ioctl_gem_submit()
      xen/events: fix error code in xen_bind_pirq_msi_to_irq()
      ext4: fix error pointer dereference in ext4_mb_load_buddy_gfp()

Dan Williams (2):
      cxl/port: Fix delete_endpoint() vs parent unregistration race
      cxl/port: Fix use-after-free, permit out-of-order decoder shutdown

Daniel Borkmann (3):
      bpf: Fix incorrect pruning due to atomic fetch precision tracking
      net, sched: Make tc-related drop reason more flexible
      bpf: Disable preemption in __bpf_get_stack

Daniel J. Ogorchock (1):
      HID: nintendo: avoid bluetooth suspend/resume stalls

Daniel Starke (2):
      tty: n_gsm: introduce macro for minimal unit size
      tty: n_gsm: add parameters used with parameter negotiation

Daniel Yang (1):
      exfat: resolve memory leak from exfat_create_upcase_table()

Daniil Stas (1):
      hwmon: (drivetemp) Fix driver producing garbage data when SCSI errors occur

Dapeng Mi (3):
      perf/x86/intel: Remove anythread_deprecated bit from perf_capabilities
      perf/x86/intel: Update event constraints and cache_extra_regsfor ADL
      perf/x86/intel: Fix GRT PEBS load/store direction for latency events, to fix sample classification

Darrick J. Wong (1):
      xfs: fix cursor and pointer handling when recovering iunlink buckets

Dave Airlie (2):
      nouveau/gem: reserve the bo in the info ioctl around the vma lookup
      nouveau: lock the client object tree.

Dave Chinner (5):
      xfs: xfs_ifree_cluster vs xfs_iflush_shutdown_abort deadlock
      xfs: catch stale AGF/AGF metadata
      xfs: rearrange code in xfs_buf_item.c
      xfs: factor out stale buffer item completion
      xfs: fix unmount hang with unflushable inodes stuck in the AIL

Dave Marquardt (1):
      net: ibmveth: make veth_pool_store stop hanging

David (Ming Qiang) Wu (1):
      drm/amdgpu: limit AV1 to the first instance on VCN4 encode

David Arinzon (1):
      net: ena: Add validation for completion descriptors consistency

David Carlier (2):
      netfilter: flowtable: avoid num_encaps underflow on bridge VLAN untag
      ieee802154: hwsim: serialize pib updates to fix double-free

David Francis (1):
      drm/amdkfd: Check bounds on CRIU restore queue type and mqd size

David Heidelberg (1):
      Input: s6sy761 - fix resume ordering and restore sensing

David Hildenbrand (1):
      mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM

David Howells (8):
      rxrpc: Fix delayed ACKs to not set the reference serial number
      afs: Fix lock recursion
      rxrpc: Fix recv-recv race of completed call
      rxrpc: Fix bug due to prealloc collision
      rxrpc: Fix data-race warning and potential load/store tearing
      rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
      rxrpc: Fix memory leaks in rxkad_verify_response()
      afs: Fix reinitialisation of the inode, in particular ->lock_work

David Jeffery (1):
      scsi: core: wake eh reliably when using scsi_schedule_eh

David Lee (1):
      btrfs: lzo: reject inline extents without valid headers

David Rosca (3):
      drm/amdgpu/vcn4: Fix IB parsing with multiple engine info packages
      drm/amdgpu: Fix UVD dpb min size calculation for H264
      drm/amdgpu: Fix VCE 3 ring align_mask

David Timber (1):
      exfat: fix handling of damaged volume in exfat_create_upcase_table()

David Windsor (1):
      bpf: Reject sleepable BPF_LSM_CGROUP programs at load time

Davide Ornaghi (1):
      ksmbd: fix path resolution in ksmbd_vfs_kern_path_create

Davidlohr Bueso (1):
      cxl/mbox: validate payload size before accessing contents in cxl_payload_from_user_allowed()

Dawei Feng (2):
      usb: free iso schedules on failed submit
      wifi: iwlwifi: dvm: fix memory leak in iwl_op_mode_dvm_start()

Deepak Gupta (1):
      riscv: VMAP_STACK overflow detection thread-safe

Deepanshu Kartikey (4):
      gfs2: fix memory leaks in gfs2_fill_super error path
      fs/ntfs3: fix missing run load for vcn0 in attr_data_get_block_locked()
      ocfs2: validate i_refcount_loc when refcount flag is set
      mm/hugetlb: fix hugetlb cgroup rsvd charge/uncharge mismatch

Denis V. Lunev (1):
      openvswitch: fix soft lockup in the netlink flow dump

Devyn Liu (1):
      spi: hisi-kunpeng: Add verification for the max_frequency provided by the firmware

Di Shen (1):
      OPP: Fix race between OPP addition and lookup

Dibin Moolakadan Subrahmanian (1):
      drm/i915/dmc: Harden DMC firmware payload parsing

Dmitry Antipov (2):
      ocfs2: add suballoc slot check in ocfs2_validate_inode_block()
      ocfs2: add extra consistency checks for chain allocator dinodes

Donggeun Yoo (5):
      tracing: Set the trace clock before registering the histogram trigger
      tracing: Fix the shift out of bounds in the log2 histogram modifier
      tracing: Save the event file instead of the compatible histogram
      tracing: Unregister field variable histograms when the command fails
      tracing: Fix 64-bit and signed histogram fields on 32-bit kernels

Dongjiang Zhu (1):
      btrfs: skip global block reserve accounting for rescue mounts

Dongli Zhang (1):
      net: tap: set skb->dev before parsing virtio net header in tap_get_user_xdp()

Doruk Tan Ozturk (3):
      HID: sony: fix UAF of ghl_poke_timer / ghl_urb at driver unbind
      ocfs2: validate directory-index entry counts when reading metadata
      HID: sony: clean up device list on probe failure

Douglas Anderson (1):
      spi: spi-qcom-qspi: Support pinctrl sleep states

Douya Le (1):
      crypto: af_alg - limit RX SG extraction by receive buffer budget

Dr. David Alan Gilbert (1):
      net: ena: Remove autopolling mode

Dragos Tatulea (4):
      net/mlx5e: xsk: Fix crash on regular rq reactivation
      net: esp: fix bad handling of pages from page_pool
      net/mlx5e: xsk: Fix DMA and xdp_frame leak on XDP_TX xmit failure
      net/mlx5: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list

Duoming Zhou (5):
      watchdog: cpu5wdt.c: Fix use-after-free bug caused by cpu5wdt_trigger
      ptp: ocp: fix use-after-free bugs causing by ptp_ocp_watchdog
      net: mscc: ocelot: Fix use-after-free caused by cyclic delayed work
      scsi: imm: Fix use-after-free bug caused by unfinished delayed work
      Input: alps - fix use-after-free bugs caused by dev3_register_work

Eddie James (1):
      net/ncsi: Disable the ncsi work before freeing the associated structure

Edward Adam Davis (4):
      fs/ntfs3: cancle set bad inode after removing name fails
      cifs: client: fix memory leak in smb3_fs_context_parse_param
      ALSA: usb-audio: Prevent excessive number of frames
      sched/psi: fix race between file release and pressure write

Edward Cree (1):
      sfc: fix NULL dereferences in ef100_process_design_param()

Emmanuel Grumbach (6):
      wifi: iwlwifi: guard against division by zero in iwl_dbg_tlv_alloc_fragments
      wifi: iwlwifi: mvm: fix out-of-bounds tid_data access in BA notif
      wifi: iwlwifi: mvm: add a check on the tid coming from the firmware
      wifi: iwlwifi: mvm: fix a possible underflow
      wifi: iwlwifi: mvm: validate TX_CMD response layout
      wifi: iwlwifi: pcie: null RX pointers after free

Eric Biggers (2):
      fsverity: add dependency on 64K or smaller pages
      crypto: drbg - Fix ineffective sanity check

Eric Dumazet (27):
      ipv6: sr: use skb_get_hash_net() in seg6_make_flowlabel()
      tcp: introduce icsk->icsk_keepalive_timer
      bnxt_en: fix DMA mapping length for padded small packets
      flow_dissector: avoid u16 truncation of skb->len when computing thoff
      flow_dissector: avoid u16 truncation of hlen in bpf_flow_dissect()
      net/sched: Fix mirred deadlock on device recursion
      pktgen: use cpus_read_lock() in pg_net_init()
      tcp_metrics: use dst_dev_net_rcu()
      ipv6: use RCU in ip6_output()
      net: use dst_dev_rcu() in sk_setup_caps()
      tcp: use dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check()
      dst: fix races in rt6_uncached_list_del() and rt_del_uncached_list()
      tcp: secure_seq: add back ports to TS offset
      ipv6: ioam: fix potential NULL dereferences in __ioam6_fill_trace_data()
      ipv4: igmp: Fix potential memory leaks in igmp_mod_timer() and igmp_stop_timer()
      tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
      net: udp_tunnel: prevent double queueing in udp_tunnel_nic_device_sync
      net: udp_tunnel: fix memory leak in udp_tunnel_nic_unregister()
      netfilter: nf_flow_table: drop existing skb dst before skb_dst_set_noref()
      l2tp: fix tunnel and session refcount leak on seq_file release
      tipc: avoid busy looping in tipc_exit_net()
      vlan: fix skb_under_panic and races when toggling HW VLAN offload
      net: watchdog: fix refcount tracking races
      net_sched: sch_fifo: implement lockless __fifo_dump()
      ip6mr: do not clone dst in ip6mr_cache_report()
      vlan: restore HW VLAN tag insertion with reorder_hdr off
      inet: control sockets should not use current thread task_frag

Eric Farman (2):
      s390/vfio_ccw: Limit the number of channel program segments
      s390/vfio_ccw: Ensure first IDAW remains constant

Eric Huang (1):
      drm/amdgpu: prevent immediate PASID reuse case

Erni Sri Satya Vennela (1):
      net: mana: Guard mana_remove against double invocation

Etienne Perot (1):
      cgroup: fix spurious SIGKILL of CLONE_INTO_CGROUP children

Eugenio Pérez (1):
      vhost: move vdpa group bound check to vhost_vdpa

Even Xu (1):
      HID: Intel-ish-hid: Ishtp: Fix sensor reads after ACPI S3 suspend

Evgenii Burenchev (2):
      drm/amd/display: Fix dangling pointer in CRTC reset function
      drm/amd/display: Fix dangling pointer in plane reset function

Ezrak1e (1):
      dlm: validate length in dlm_search_rsb_tree

Fabrice Gasnier (1):
      iio: adc: stm32-adc: fix possible division by zero in processed channel

Fan Wu (19):
      wifi: rtl8xxxu: fix use-after-free from rx_urb_wq on stop
      power: supply: rt9455: quiesce delayed work before teardown
      mmc: via-sdmmc: cancel card-detect work on remove
      smb: client: fix cifsFileInfo reference leak in deferred close
      wifi: wcn36xx: Fix potential use-after-free in TX ack timer teardown
      usb: gadget: aspeed-vhub: cancel wake work on device removal
      usb: cdns3: fix use-after-free in cdns3_gadget_exit()
      serial: 8250_bcm7271: fix use-after-free in brcmuart_remove()
      iio: adc: xilinx-xadc: free IRQ before cancelling the unmask worker on unbind
      iio: light: gp2ap020a00f: drain irq_work after free_irq
      iio: trigger: cancel reenable_work before freeing trigger
      usb: gadget: at91_udc: drain polled-VBUS timer/work before udc is freed
      tty: serial: max3100: shut down timer before freeing port
      iio: adc: ad_sigma_delta: fix use-after-free on unbind
      drm/vc4: drain the hangcheck timer and works on V3D unbind
      power: supply: lp8788-charger: fix use-after-free on remove
      power: supply: charger-manager: register regulators before exposing sysfs
      spi: davinci: switch to managed controller allocation
      spi: oc-tiny: switch to managed controller allocation

Fan Ye (2):
      net: thunderbolt: Release the Rx HopID that was handed out on mismatch
      net: thunderbolt: Mark the connection down when bringing it up fails

Fangyu Yu (1):
      RISC-V: KVM: Write hgatp register with valid mode bits

Farhan Ali (2):
      PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value
      PCI: Allow per function PCI slots to fix slot reset on s390

Fedor Pchelkin (1):
      wifi: fix leak if split 6 GHz scanning fails

Fei Shao (1):
      media: mediatek: vcodec: Only free buffer VA that is not NULL

Fei Wu (1):
      perf: RISCV: Fix panic on pmu overflow handler

Felix Fietkau (5):
      wifi: mac80211: set info->band for 802.3 encap offload frames
      netfilter: nf_tables: fix bidirectional offload regression
      wifi: mt76: cancel reset and rc work on device unregister
      wifi: mt76: mt7915: allocate vif wcid in the same range as stations
      wifi: mt76: mt7915: unwind state on add_interface failure

Felix Gu (2):
      iio: adc: sun4i-gpadc-iio: clean up on thermal zone registration failure
      iio: adc: sun4i-gpadc-iio: drop underflowing pm_runtime_put() calls

Feng Liu (1):
      net/mlx5e: Fix publication race for priv->channel_stats[]

Fernando Fernandez Mancera (7):
      netfilter: bpf: reject invalid NAT manipulation types
      net: openvswitch: validate transport header presence in set_ipv6_addr
      netfilter: nf_tables: fix dst corruption in same register operation
      netfilter: synproxy: drop packets if timestamp adjustment fails
      netfilter: synproxy: adjust duplicate timestamp options
      netfilter: synproxy: fix unaligned memory access in timestamp adjustment
      ipv4: nexthop: allocate skb dynamically in rtm_get_nexthop()

Filipe Manana (9):
      btrfs: do not BUG_ON() when freeing tree block after error
      btrfs: log new dentries when logging parent dir of a conflicting inode
      btrfs: fix zero size inode with non-zero size after log replay
      btrfs: don't BUG() on unexpected delayed ref type in run_one_delayed_ref()
      btrfs: reserve enough transaction items for qgroup ioctls
      btrfs: fix deadlock between reflink and transaction commit when using flushoncommit
      btrfs: fix deadlock cloning inline extent when using flushoncommit
      btrfs: defrag: fix deadlock between defrag and delalloc space reservation
      btrfs: fix race between ordered extent completion and fiemap

Florian Fainelli (1):
      net: systemport: Fix RUNT MIB counter register offset calculation

Florian Fuchs (1):
      mtd: maps: vmu-flash: fix fault in unaligned fixup

Florian Pradines (1):
      HID: mcp2221: fix OOB write in mcp2221_raw_event()

Florian Schauer (1):
      page_pool: keep frag_offset aligned for odd-sized requests

Florian Westphal (11):
      openvswitch: prepare for stolen verdict coming from conntrack and nat engine
      netfilter: ipset: do not update comments from kernel-side adds
      net: add and use skb_get_hash_net
      xfrm: state: fix out-of-bounds read during lookup
      netfilter: nf_tables: use list_del_rcu for netlink hooks
      netfilter: bridge: eb_tables: close module init race
      netfilter: ebtables: move to two-stage removal scheme
      netfilter: nft_compat: ebtables emulation must reject non-bridge targets
      netfilter: make nftables drops visible in net dropmonitor
      netfilter: nfnetlink_queue: do shared-unconfirmed check before segmentation
      netfilter: revalidate bridge ports

Fourie Zhang (1):
      netfilter: nf_tables: don't queue packet path object notifications

Francesco Lavra (1):
      iio: imu: st_lsm6dsx: fix iio_chan_spec for sensors without event detection

Francisco Beltrán Millalén (1):
      drm/amdgpu: reset VI ASIC on MacBookPro14,3

Frank Sorenson (7):
      smb: client: fix OOB read/write from unvalidated DataOffset in coalesce_t2()
      smb: client: fix OOB struct field reads in move_smb2_ea_to_cifs()
      smb: client: split cifsFileInfo bitfields to avoid shared-byte RMW races
      cifs: prevent readdir from changing file size due to stale directory metadata
      cifs: fix cifsFileInfo leak on kmalloc failure in deferred close drain paths
      cifs: call pagecache_isize_extended() in cifs_setsize() when extending
      cifs: add revalidation on FSCTL failure in smb2_duplicate_extents()

Frederic Weisbecker (1):
      perf: Fix hang while freeing sigtrap event

Fredric Cover (1):
      smb: client: fix races in cifsd thread creation

Fredrik Nyberg (1):
      net: usb: ax88179_178a: fix rx frame length for non-last packets

Fuad Tabba (2):
      bpf, arm64: Force 8-byte alignment for JIT buffer to prevent atomic tearing
      KVM: arm64: vgic-its: Don't dereference a NULL collection on ITT save

Gabriel Prostitis (1):
      USB: gadget: ffs: fix mm lifetime handling

Gabriele Monaco (1):
      rv: Use strings in da monitors tracepoints

Gal Pressman (1):
      net/mlx5: Fix MCIA register buffer overflow on 32 dword reads

Gao Xiang (4):
      erofs: unify lcn as u64 for 32-bit platforms
      erofs: fix use-after-free on sbi->sync_decompress
      erofs: fix inline data read failure for ztailpacking pclusters
      erofs: fix interlaced ztailpacking pclusters

Gary Guo (3):
      PCI: Make pci_match_one_device() match on ID instead of device
      PCI: Fix dyn_id add TOCTOU
      PCI: Fix UAF when probe runs concurrent to dyn ID removal

Gaurav Batra (1):
      powerpc/pseries/iommu: IOMMU incorrectly marks MMIO range in DDW

Gavin Shan (3):
      mm/filemap: make MAX_PAGECACHE_ORDER acceptable to xarray
      mm/filemap: skip to create PMD-sized page cache if needed
      mm/shmem: disable PMD-sized page cache if needed

Ge Yang (1):
      KVM: SEV: Use long-term pin when registering encrypted memory regions

Geliang Tang (4):
      mptcp: pm: drop match in userspace_pm_append_new_local_addr
      sock: add sock_kmemdup helper
      mptcp: use sock_kmemdup for address entry
      nvmet-tcp: fix page fragment cache leak in error path

Genjian Zhang (1):
      dm-ebs: fix incorrect device offset check in ebs_ctr()

George Guo (1):
      LoongArch: Fix address space mismatch in kexec command line lookup

George Stark (1):
      leds: an30259a: Use devm_mutex_init() for mutex initialization

Gilberto Conde (1):
      net: usb: qmi_wwan: add Quectel EG120K-EA

Gleb Markov (1):
      drm/amd/display: Remove unused-but-set variable hubp from

Gou Hao (3):
      ext4: delete redundant calculations in ext4_mb_get_buddy_page_lock()
      powerpc/xive: add error return value to xive_smp_probe()
      powerpc/xive: propagate IPI init errors to prevent use-after-free

Greg Kroah-Hartman (5):
      usb: typec: tcpm/tcpci_maxim: validate header NDO against RX_BYTE_CNT
      usb: typec: tcpm: bound altmode_desc[] per iteration in svdm_consume_modes()
      usb: typec: tcpm: validate VDO count in Discover Identity ACK handlers
      tty: make tty_class a static const structure
      Linux 6.1.191

Gregor Herburger (1):
      drm/vc4: hvs/v3d: Fix null dereference in unbind

Gregory CLEMENT (1):
      MIPS: ftrace: Fix memory corruption when kernel is located beyond 32 bits

Gregory Price (1):
      mm/mm_init: handle alloc_percpu failure in free_area_init_core_hotplug

Guanghui Feng (1):
      iommu/amd: Wait for completion instead of returning early in iommu_completion_wait()

Guanghui Yang (2):
      f2fs: fix dentry folio leak in find_in_level
      btrfs: drop recovered reloc root refs on recovery failure

Guangshuo Li (8):
      net: ena: fix MMIO read buffer leak on probe failure
      drm/amdgpu: fix IP instance memory leak on kobject add failure
      drm/amdgpu: fix ACP MFD device leak on init failure
      wifi: iwlegacy: 3945: free EEPROM data on remove
      mmc: cavium-octeon: destroy slot platform devices on remove
      mmc: cavium-thunderx: destroy slot platform devices on remove
      mmc: sdhci-sprd: disable runtime PM on remove
      media: vivid: fix cleanup bugs in vivid_init()

Guenter Roeck (4):
      hwmon: (pmbus/core) Protect regulator operations with mutex
      hwmon: (lm90) Stop work before releasing hwmon device
      hwmon: (lm90) Add lock protection to lm90_alert
      hwmon: (sht3x) Fix unaligned accesses

Guillaume Nault (1):
      net: Introduce sk_use_task_frag in struct sock.

Guixin Liu (1):
      scsi: mpi3mr: Fix possible crash when setting up bsg fails

Guoniu Zhou (1):
      pmdomain: imx93-blk-ctrl: Extract PHY as shared domain for DSI/CSI

Guoqing Jiang (1):
      RDMA/siw: Introduce siw_destroy_cep_sock

Guoyu Su (1):
      net: use skb_header_pointer() for TCPv4 GSO frag_off check

HE WEI（ギカク） (1):
      fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()

Haixin Xu (1):
      crypto: jitterentropy - replace long-held spinlock with mutex

Halil Pasic (1):
      s390/ism: fix concurrency management in ism_cmd()

Hamza Mahfooz (1):
      drm/amd/display: drop unused function set_abm_event()

Han Xu (2):
      mtd: spinand: Enable QE on all dies
      spi: fsl-qspi: use devm function instead of driver remove

HanQuan (1):
      ALSA: seq: Fix kernel heap address leak in bounce_error_event()

Hang Nan (1):
      ksmbd: bound smb_check_perm_dacl() ACE walks by DACL size

Hangbin Liu (1):
      bonding: do not set usable_slaves for broadcast mode

Hannes Reinecke (1):
      nvmet: return DHCHAP status codes from nvmet_setup_auth()

Hans de Goede (1):
      platform/x86: x86-android-tablets: Unregister devices in reverse order

Haofeng Li (2):
      ksmbd: validate NTLMv2 response before updating session key
      ksmbd: reject undersized DACLs before parsing ACEs

Haojie Li (1):
      drm/amdkfd: fix dma_buf reference leak in get_dmabuf_info

Haotian Zhang (2):
      PCI: endpoint: Add missing NULL check for alloc_workqueue()
      samples/ftrace: Fix kthread_stop() on ERR_PTR in ftrace-direct-multi-modify

Haoxiang Li (3):
      platform/x86: dell-laptop: fix missing cleanups in init error path
      ASoC: hdac_hda: Fix hlink refcount leak on component registration failure
      HID: logitech-hidpp: Fix FF device cleanup on init failure

Harald Freudenberger (2):
      s390/zcrypt: Fix buffer over-read in cca_cipher2protkey
      s390/zcrypt: Close speculative mem read possibility

Harini T (1):
      mailbox: zynqmp-ipi: Fix out-of-bounds access in mailbox cleanup loop

Hariprasad Kelam (1):
      octeontx2-af: Block VFs from clobbering special CGX PKIND state

Harry Wentland (2):
      drm/amd/display: Fix out-of-bounds read in dp_get_eq_aux_rd_interval()
      drm/amd/display: Resize MST HDCP per-connector arrays to 32

Harshit Agarwal (1):
      sched/rt: Fix race in push_rt_task

Harshit Mogalapalli (1):
      ima: verify the previous kernel's IMA buffer lies in addressable RAM

Heiko Carstens (3):
      s390/mm: Fix in_atomic() handling in do_secure_storage_access()
      s390/appldata: remove power management callbacks
      s390: include linux/io.h instead of asm/io.h

Heiko Stuebner (1):
      drm/rockchip: vop2: fail cleanly if missing a primary plane for a video-port

Heinz Mauelshagen (2):
      dm: avoid spaces before function arguments or in favour of tabs
      dm: correct block comments format.

Heitor Alves de Siqueira (1):
      Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close

Helge Deller (2):
      apparmor: Fix & Optimize table creation from possibly unaligned memory
      AppArmor: Allow apparmor to handle unaligned dfa tables

Hengqi Chen (1):
      LoongArch: BPF: Don't override subprog's return value

Henrique Carvalho (3):
      smb: client: fix potential UAF in smb2_close_cached_fid()
      smb: client: prevent races in ->query_interfaces()
      smb: client: protect tc_count increment in smb2_find_smb_sess_tcon_unlocked()

Henry Martin (1):
      tracing/user_events: Don't destroy fields when event removal fails

Hersen Wu (2):
      drm/amd/display: Add missing NULL pointer check within dpcd_extend_address_range
      drm/amd/display: Fix index may exceed array range within fpu_update_bw_bounding_box

Herve Codina (1):
      driver core: Avoid warning when removing a device while its supplier is unbinding

Heyang Tan (1):
      wifi: p54: validate firmware record lengths

Hidayath Khan (1):
      net/smc: stop killed, freed and out_of_sync sharing a byte

Holger Dengler (2):
      s390/pkey: Wipe copies of protected- and secure-keys
      s390/pkey: Wipe copies of clear-key structures on failure

Hongjian Dai (1):
      i2c: at91: release DMA channels when probe defers

Hongjie Fang (1):
      scsi: core: pair EH runtime PM get and put

Hongling Zeng (3):
      btrfs: take commit root semaphore when iterating in mark_block_group_to_copy()
      fbdev: omap2: fix inconsistent lock returns in omapfb_mmap
      fbdev: omap2: fix use-after-free in omapfb_mmap

Hongyan Xu (1):
      watchdog: at91sam9_wdt: prevent timer rearm during teardown

Horatiu Vultur (1):
      lan966x: Fix sleeping in atomic context

Hou Tao (1):
      bpf: Call free_htab_elem() after htab_unlock_bucket()

Huacai Chen (1):
      LoongArch: Update cpu_sibling_map when disabling nonboot CPUs

Hugh Dickins (1):
      arm64: allow pte_offset_map() to fail

Hugo Villeneuve (1):
      serial: sc16is7xx: fix TX fifo corruption

Hui Peng (2):
      usb: core: clear both ep_in and ep_out for non-ep0 control endpoints
      sctp: copy zeroed stats to user in sctp_getsockopt_pr_streamstatus() when !streamoute

Hui Su (3):
      kasan: fix cache shrink race with CPU hotplug
      iio: pressure: bmp280: fix out-of-bounds access in sampling frequency lookup
      fbdev: ssd1307fb: defer I2C transfers from damage callbacks

Huiwen He (1):
      smb/client: flush dirty data before punching a hole

HyeongJun An (8):
      ASoC: wm8903: Move the DRC QR threshold to the register that holds it
      ASoC: cs42l56: Put the Limiter Cushion control on the limiter register
      ASoC: cs42l52: Fix the NG Type Switch bit
      ASoC: pcm3168a: Fix the DAC zero flag polarity bit
      ASoC: max98371: Fix the Speaker DHT Min Volume bits
      ASoC: wm8978: Fix the 128x oversampling switch bits
      ASoC: nau8822: Fix the 128x oversampling switch bits
      ALSA: seq: Don't leak the extension cell pointer in the bounce payload

HyungJung Joo (1):
      fs/mbcache: cancel shrink work before destroying the cache

Hyunwoo Kim (3):
      apparmor: fix out-of-bounds write when null terminating a label vec
      exec: Cleanup POSIX timers right after de_thread()
      KVM: x86/mmu: Preserve nested TDP shadow page tables if they are used as roots

I Viswanath (1):
      ptp: Add a upper bound on max_vclocks

Ian Bridges (2):
      fbdev: fix use-after-free in store_modes()
      ocfs2: fix UBSAN array-index-out-of-bounds in ocfs2_sum_rightmost_rec

Ian Lin (2):
      USB: serial: option: add Compal EXM-G1x support
      USB: serial: option: add Compal EXC-T1 support

Iaroslav Voitovych (1):
      Bluetooth: MGMT: Fix status of pending commands flushed on power off

Ibrahim Hashimov (1):
      RDMA/rxe: Fix responder UAF on IB_QP_MAX_DEST_RD_ATOMIC modify_qp

Ido Schimmel (5):
      net/sched: flower: Fix chain template offload
      bridge: mcast: Fix use-after-free during router port configuration
      vxlan: Fix NPD in {arp,neigh}_reduce() when using nexthop objects
      vxlan: Fix NPD when refreshing an FDB entry with a nexthop object
      ipv4: udp: Create exceptions before socket matching

Ilan Dudnik (2):
      ksmbd: defer publishing granted locks to prevent UAF/double-free race
      ksmbd: fix heap out-of-bounds write in krb5_authenticate()

Ilkka Lappeteläinen (1):
      net/packet: prevent TX_RING byte count overflow

Ilpo Järvinen (2):
      PCI: Fix Resizable BAR restore order
      PCI/sysfs: Demacrofy pci_dev_resource_resize_attr(n) functions

Ilya Bakoulin (1):
      drm/amd/display: Fix hang/underflow when transitioning to ODM4:1

Ilya Maximets (1):
      net: openvswitch: conntrack: fix helper UAF due to extensions realloc

Ilya Titov (1):
      pinctrl: sunxi: keep a shadow copy of the data register output latches

Imre Kaloz (1):
      drm/radeon: Read the VRAM VBIOS signature with readb()

Ivan Abramov (1):
      ieee802154: Avoid calling WARN_ON() on -ENOMEM in cfg802154_switch_netns()

Jacky Bai (1):
      pmdomain: imx8mp-blk-ctrl: Keep the NOC_HDCP clock enabled

Jacob Keller (1):
      ice: Don't process extts if PTP is disabled

Jacob Moroni (2):
      RDMA/irdma: Prevent user-triggered null deref on QP create
      RDMA/irdma: Replace waitqueue and flag with completion

Jaegeuk Kim (1):
      f2fs: split initial and dynamic conditions for extent_cache

Jaewook You (1):
      mm/hugetlb: preserve mremap address delta when skipping page tables

Jakub Kicinski (4):
      ethtool: fail closed if we can't get max channel used in indirection tables
      net/sched: act_mirred: use the backlog for mirred ingress
      net: ipv6: fix dst ref loops in rpl, seg6 and ioam6 lwtunnels
      nfc: nci: complete pending data exchange on device close

Jamal Hadi Salim (12):
      net/sched: cls_api: reclaim an empty proto on the error path
      net/sched: fq_codel: match the no-drop threshold to the packet size
      net/sched: sch_codel: match the no-drop threshold to the packet size
      net/sched: em_text: reject unterminated algo before autoload
      net/sched: Handle TC_ACT_REDIRECT from qdisc filter chains
      net/sched: act_pedit: fix TOCTOU heap OOB write in tc offload
      net/sched: cls_api: Always acquire rtnl_lock when destroying locked classifiers
      net, sched: Fix SKB_NOT_DROPPED_YET splat under debug config
      net/sched: act_api: fix TOCTOU NULL deref on a->goto_chain
      net/sched: fq: add overflow bounds to quantum and initial quantum
      net/sched: account classifier filter allocations to memcg
      net: sched: fix 32-bit backlog wrap in gred, bfifo and plug enqueue

James Chapman (1):
      l2tp: prevent possible tunnel refcount underflow

James Clark (1):
      coresight: ete: Always save state on power down

James Zhu (1):
      drm/amdgpu: keep amdgpu_ctx_mgr in ctx structure

Jameson Thies (1):
      usb: typec: ucsi: displayport: Current CAM OOB index fixup

Jamie Nguyen (1):
      fs/ntfs3: resize log->one_page_buf when adopting on-disk page size

Jan Kara (5):
      ocfs2: Avoid touching renamed directory if parent does not change
      reiserfs: Avoid touching renamed directory if parent does not change
      ext4: avoid deadlock in fs reclaim with page writeback
      loop: Avoid updating block size under exclusive owner
      ext2: Fix lost inode updates for IS_SYNC inodes

Jani Nikula (2):
      drm/i915/mst: limit DP MST ESI service loop
      drm/i915/bios: range check LFP Data Block panel_type2

Jann Horn (4):
      userfaultfd: fix checks for huge PMDs
      udmabuf: fix memory leak on last export_udmabuf() error path
      apparmor: fix cred UAF caused by begin_current_label_crit_section()
      futex: Fix mm reuse handling for FUT_OFF_MMSHARED

Janne Grunau (1):
      media: videobuf2: Set vma_flags in vb2_dma_sg_mmap

Janosch Frank (1):
      s390/mm: Add missing secure storage access fixups for donated memory

Jason A. Donenfeld (1):
      wireguard: noise: reject response consumption after intermediate initiation

Jason Andryuk (1):
      xen/events: Return -EEXIST for bound VIRQs

Jason Gunthorpe (2):
      RDMA/mlx4: Fix mis-use of RCU in mlx4_srq_event()
      RDMA/mlx5: Follow rb_key.ats when creating new mkeys

Jason Huang (1):
      wifi: brcmfmac: fix P2P action frame handling without device vif

Jeff Jo (1):
      tcp: refresh TS.Recent for accepted old ACKs

Jeff Johnson (2):
      wifi: ath11k: fix stride mismatch in mac_phy_caps_parse()
      wifi: ath11k: fix overreads in ath11k_wmi_process_csa_switch_count_event()

Jeff Layton (10):
      nfsd: fix nfsd_file leak on inter-server COPY setup failure
      nfsd: check nfsd4_acl_to_attr() return value in nfsd4_create()
      nfsd: fix clock domain mismatch in clients_still_reclaiming()
      fs: new helper: simple_rename_timestamp
      reiserfs: convert to simple_rename_timestamp
      sunrpc: defer rq_argp and rq_resp free until after RCU grace period
      nfsd: fix stale s2s_cp_stateids IDR entry for async COPY
      nfsd: fix fcache_disposal UAF by inlining dispose state into nfsd_net
      nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on racing delegation revoke
      lockd, nfsd: RCU-protect nlmsvc_ops dispatch

Jeffin Philip (2):
      usb: gadget: f_mass_storage: fix null pointer dereference in fsg_common_set_num_buffers()
      usb: gadget: f_midi: initialize work in f_midi_alloc()

Jens Axboe (5):
      io_uring/timeout: don't put a sequence target behind the last flush
      io_uring/timeout: don't flush with the sequence behind the last flush
      io_uring/timeout: don't lose a cancel as io-wq arms a timeout
      io_uring/poll: don't loop on HUP with multiple references
      exit: move core of do_wait() into helper

Jesse Zhang (2):
      drm/amdgpu: force complete the KIQ ring fences on reset
      drm/amdgpu: don't drop the runtime PM reference twice in amdgpu_gpr

Jeuk Kim (1):
      NFSv4/flexfiles: fix NULL dereference for NFSv4.0 data servers

Jia Zhu (1):
      erofs: fix metabuf leak in inode xattr initialization

Jiacheng Yu (1):
      params: fix charp corruption on allocation failure

Jiajia Liu (2):
      Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING
      Bluetooth: btmtk: fix urb->setup_packet leak in error paths

Jiale Yao (1):
      iio: accel: kxcjk-1013: reject duplicate event disable

Jianan Huang (1):
      f2fs: avoid reading already updated pages during GC

Jianbo Liu (2):
      net/mlx5e: Remove skb secpath if xfrm state is not found
      net: sched: cls_api: fix slab-use-after-free in fl_dump_key

Jiangshan Yi (4):
      smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions
      drm/amd/display: check dc_state_create_copy() for NULL in dm_suspend
      HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes
      HID: nintendo: register input device after capabilities are set

Jianing Li (2):
      power: supply: max17040: drop incorrect I2C functionality check
      power: supply: max17040: propagate register read errors

Jiasheng Jiang (1):
      md-cluster: fix NULL pointer dereference in process_metadata_update

Jiayuan Chen (6):
      serial: core: fix infinite loop in handle_tx() for PORT_UNKNOWN
      team: fix header_ops type confusion with non-Ethernet ports
      kcm: fix zero-frag skb in frag_list on partial sendmsg error
      bonding: fix type confusion in bond_setup_by_slave()
      netfilter: nft_ct: bail out on template ct in get eval
      bpf, xdp: move offload check into dev_xdp_install()

Jiazi Liu (1):
      usb: dwc3: gadget: fix IRQ storm on invalid event buffer count

Jie Deng (1):
      usb: cdns3: Fix NULL pointer dereference in cdns3_pci_probe

Jie Zhang (2):
      drm/msm: Recover HW before retire hung submit
      net: stmmac: fix oops when split header is enabled

Jim Cromie (1):
      kmemleak: drop (age <increasing>) from leak record

Jinjiang Tu (2):
      mm/rmap: fix missing barrier between anon_vma init and vma->anon_vma publish
      mm/smaps: fix race between smaps_hugetlb_range and migration

Jinjie Ruan (1):
      powerpc/kexec_file: Prevent kexec range truncation

Jinseob Kim (1):
      iio: buffer: serialize buffer teardown with mode claims

Jinu Kim (1):
      KVM: x86: Use active memslots for the per-vCPU MMIO cache

Jiri Olsa (2):
      bpf: Disable preemption in bpf_get_stackid
      bpf: Clear buf on error in __bpf_get_task_stack

Joe Damato (1):
      bnxt: fix head underflow on XDP head-grow

Joel Fernandes (1):
      rcu: Fix rcu_read_unlock() deadloop due to IRQ work

Johan Hovold (23):
      media: platform: mtk-mdp3: fix NULL deref on failed SCP lookup
      USB: cdc-acm: fix racy TIOCMIWAIT implementation
      USB: serial: fix port tear down use-after-free
      tty: amiserial: fix broken TIOCMIWAIT
      tty: abort break signalling on hangup
      USB: serial: quatech2: fix baud rate overflow
      USB: serial: ssu100: fix baud rate overflow
      USB: serial: fix dynamic id driver deregistration race
      USB: serial: fix driver deregistration order
      tty: fix saved termios reset race
      tty: tty_port: restore TTY_IO_ERROR on activation failure
      serial: fix TIOCMIWAIT race
      USB: serial: return errors from break handling
      USB: serial: report unsupported break signalling
      USB: serial: fix ioctl hangup race
      tty: port: fix tty_port_tty_vhangup() race
      tty: add break_wait kernel-doc
      staging: most: remove broken i2c driver
      spi: mpc52xx: fix controller deregistration
      spi: rspi: fix controller deregistration
      spi: fsl: fix controller deregistration
      spi: mpc52xx: fix use-after-free on registration failure
      USB: iowarrior: fix use-after-free on disconnect race

Johannes Berg (6):
      Revert "wifi: libertas: reject short monitor TX frames"
      um: fix time-travel syscall scheduling hack
      wifi: iwlwifi: dbg-tlv: fix DRAM data init
      wifi: iwlwifi: fix debug actions order
      wifi: mac80211: don't WARN for connections on invalid channels
      net/sched: initialize noop_qdisc owner

John Garry (1):
      md/raid10: Handle bio_split() errors

John Johansen (1):
      apparmor: fix deadlock in complain-mode change_hat

Jonas Gorski (1):
      net: dsa: b53: do not enable EEE on bcm63xx

Jonas Köppeler (1):
      net_sched: codel: fix stale state for empty flows in fq_codel

Jonathan Cameron (2):
      iio: buffer: Ensure bounce buffer used for unaligned case is zeroed.
      iio: st_sensors: core and lsm9ds0 switch to devm_regulator_bulk_get_enable()

Joonas Lahtinen (1):
      drm/i915/gt: Fix NULL deref on sched_engine alloc failure

Jordan Walters (1):
      Bluetooth: hci_core: Fix UAF in hci_unregister_dev()

Josef Bacik (19):
      io_uring/io-wq: don't lose the signal that ends work
      io_uring/io-wq: don't hide a link from cancellations
      io_uring: don't flood a cancelling task with task_work
      io_uring/io-wq: don't strand work when a worker exits
      io_uring/io-wq: don't exit with a creation pending
      io_uring/io-wq: let cancel find picked up hashed work
      io_uring/poll: don't lose a cancel as io-wq arms poll
      io_uring/cancel: don't forget that the work was running
      io_uring/cancel: recognize "no timeout" on 32-bit
      io_uring/cancel: let CANCEL_ALL find parked requests
      io_uring/wait: look at all CQ waiters on wake up
      io_uring/poll: drop stale double poll entry on rearm
      io_uring/timeout: don't skip over reached sequences
      io_uring/sqpoll: let the thread sleep on disabled rings
      io_uring: don't pass restart error codes to userspace
      io_uring: look up the file before queueing to io-wq
      xen/netfront: drop RX packets with a short Ethernet header
      xen/netfront: don't leak the skb when xennet_fill_frags() fails
      btrfs: fix deadlock with fiemap and extent locking

Joseph Qi (3):
      ocfs2: validate dx_root extent list fields during block read
      smb: client: fix use-after-free of iface in cifs_try_adding_channels()
      ocfs2: use correct endian in ocfs2_dinode_has_extents

Joshua Rogers (3):
      tty: vcc: zero-initialize control packet in vcc_send_ctl()
      tty: vcc: hold port lock when clearing tty pointer in vcc_cleanup
      svcrdma: bound check rq_pages index in inline path

Juanlu Herrero (1):
      io_uring/poll: avoid retry wakeup loss when dropping ownership

Juergen Gross (5):
      xen/events: avoid using info_for_irq() in xen_send_IPI_one()
      xen/events: reduce externally visible helper functions
      xen/events: remove some simple helpers from events_base.c
      xen/events: drop xen_allocate_irqs_dynamic()
      xen/events: modify internal [un]bind interfaces

Jules Irenge (1):
      s390/pkey: Use kfree_sensitive() to fix Coccinelle warnings

Julian Anastasov (5):
      ipvs: fix missing counter decrement in lblc
      ipvs: do not create invisible templates
      ipvs: filter some flags received in the backup server
      ipvs: do not keep dest_dst if dev is going down
      ipvs: revalidate ihl to prevent out-of-bounds access

Julian Sun (2):
      nvmet: preserve device path on allocation failure
      ocfs2: correct l_next_free_rec in online check

Jun Yang (2):
      sctp: check RCV_SHUTDOWN after the sendmsg connect wait
      net: bridge: mcast: don't truncate the port group walk on teardown

Junhao He (1):
      coresight: Fix memory leak in acpi_buffer->pointer

Junxian Huang (1):
      RDMA/hns: Fix soft lockup under heavy CEQE load

Junyi Liu (1):
      ksmbd: validate SID in parent security descriptor during ACL inheritance

Juri Lelli (1):
      sched/deadline: Fix missing ENQUEUE_REPLENISH during PI de-boosting

Justin Iurman (1):
      net: ioam6: fix OOB and missing lock

Justin Yeh (1):
      pinctrl: mediatek: use devm_gpiochip_add_data() for GPIO chip

Jérémy Carrat (1):
      USB: serial: cp210x: add Corsair AX1500i Power Supply

Jérémy Jean (5):
      audit: fix exe mark UAF in kill_rules()
      tipc: prevent GCM nonce reuse on peer key changes
      tls: rx: restore msg_iter before TLS 1.3 optimistic retry
      NFSv4.1: zero referring call lists before decoding
      net/sched: fix use-after-free in __tcf_action_put()

Kairui Song (2):
      mm/mglru: fix and remove redundant unevictable folio handling
      mm, madvise: fix potential workingset node list_lru leaks

Kalpan Jani (1):
      mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0

Kang Yang (1):
      wifi: ath11k: add srng->lock for ath11k_hal_srng_* in monitor mode

Kanglong Wang (2):
      LoongArch: Optimize module load time by optimizing PLT/GOT counting
      LoongArch: Move jump_label_init() before parse_early_param()

Karl Bonde Torp (1):
      nvme: fix swapped ZRASF zone state values for full and read only

Karl Mehltretter (11):
      arm64: mm: Fix the lockless page-table walk in show_pte()
      mtd: core: call _get_device() with the master MTD
      serial: imx: serialize imx_uart_ports[] lifetime
      netfilter: nft_set_pipapo: restore cloned mapping table memcg accounting
      arm64: irq: exclude the softirq stack switch from KCOV
      keys: finalize persistent keyring timeout after link attempt
      tty: skip cdev_del() when no cdev is registered
      serial: core: clear freed pointers on uart_register_driver() failure
      serial: core: do fallible allocations before the console can be registered
      power: supply: Fix maintenance charge table kernel-doc
      virtio_ccw: always take irq_lock in the classic interrupt handler

Karthikeyan KS (1):
      soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read

Kashyap Desai (1):
      RDMA/bnxt_re: Fix the page details for the srq created by kernel consumers

Kaustabh Chakraborty (1):
      iio: st_sensors: relax WhoAmI check in st_sensors_verify_id()

Keenan Dong (1):
      xfrm: account XFRMA_IF_ID in aevent size calculation

Kees Cook (4):
      seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_str()
      Compiler Attributes: Add __counted_by macro
      usb: gadget: f_midi: Annotate struct f_midi with __counted_by
      Compiler Attributes: counted_by: Adjust name and identifier expansion

Keith Busch (3):
      nvme: apple: fix device reference counting
      blk-mq: pop cached request if it is usable
      nios2: fix __wsum type degradation in csum_fold()

Kemeng Shi (1):
      ext4: remove unnecessary e4b->bd_buddy_page check in ext4_mb_load_buddy_gfp

Kevin Tian (1):
      iommu/vt-d: Force requesting ACS when tboot is enabled

Kirill A. Shutemov (1):
      mm: split critical region in remap_file_pages() and invoke LSMs in between

Kohei Enju (1):
      iavf: fix out-of-bounds writes in iavf_get_ethtool_stats()

Koichiro Den (4):
      dmaengine: dw-edma-pcie: Reject devices without driver data
      NTB: core: Add .get_dma_dev() callback to ntb_dev_ops
      NTB: ntb_transport: Use ntb_get_dma_dev() for DMA buffers
      dmaengine: dw-edma: Terminate all descriptors without callbacks

Konrad Dybcio (1):
      drm/msm/adreno: Assign msm_gpu->pdev earlier to avoid nullptrs

Konstantin Khorenko (1):
      gcov: use atomic counter updates to fix concurrent access crashes

Konstantin Komarov (4):
      fs/ntfs3: Add more checks in mi_enum_attr (part 2)
      fs/ntfs3: Mark inode as bad as soon as error detected in mi_enum_attr()
      fs/ntfs3: Check 'folio' pointer for NULL
      fs/ntfs3: handle attr_set_size() errors when truncating files

Kory Maincent (2):
      dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
      net: ravb: Fix missing rtnl lock in suspend/resume path

Krzysztof Karas (2):
      drm/i915/gem: Prevent overstepping exec array boundary
      drm/i915/gt: Unmask interrupts only when ACTIVE is true

Krzysztof Kozlowski (1):
      iio: adc: aspeed: Simplify with dev_err_probe

Krzysztof Wilczyński (1):
      PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()

Kuan-Wei Chiu (1):
      coresight: etm3x: Fix cntr_val_show() to match cntr_val_store() behavior

Kuen-Han Tsai (4):
      usb: gadget: f_rndis: Fix net_device lifecycle with device_move
      usb: gadget: f_subset: Fix net_device lifecycle with device_move
      usb: gadget: f_eem: Fix net_device lifecycle with device_move
      usb: gadget: f_ecm: Fix net_device lifecycle with device_move

Kui-Feng Lee (1):
      bpf: Retire the struct_ops map kvalue->refcnt.

Kumar Kartikeya Dwivedi (3):
      bpf: Fail bpf_timer_cancel when callback is being cancelled
      bpf: Defer work in bpf_timer_cancel_and_free
      bpf: Zero queue and stack outputs on lock failure

Kuniyuki Iwashima (6):
      hsr: Remove WARN_ONCE() in hsr_addr_is_self().
      smc: Fix use-after-free in tcp_write_timer_handler().
      smb: client: Fix use-after-free of network namespace.
      bpf: sockmap: Fix use-after-free of sk->sk_socket in sk_psock_verdict_data_ready().
      sockmap: Fix use-after-free in udp_bpf_recvmsg()
      amt: Don't support cross-netns setup.

Kurt Lieber (1):
      thunderbolt: Disable CL states for the Anker Prime TB5 dock

Kyle Zeng (7):
      ALSA: seq: Serialize compat port-info ioctls
      net/packet: defer vmalloc TX_RING free until skbs finish
      pipe: preserve existing fasync readers on writer setup failure
      netlink: avoid hashing the network namespace pointer
      fsnotify: prevent mark additions during connector teardown
      tracing: Reject incomplete event filter expressions
      keys: make keyring indexes independent of kernel addresses

Lad Prabhakar (1):
      rtc: rzn1: Handle unset alarm weekday in rzn1_rtc_read_alarm

Lang Xu (1):
      bpf: Fix OOB in pcpu_init_value

Larysa Zaremba (2):
      ice: protect XDP configuration with a mutex
      ixgbe: do not configure xps for XDP queues

Laurence Oberman (2):
      scsi: st: Save the visited block for the partition the drive is in
      scsi: st: Fix use-after-free race between st_remove() and st_open()

Lee Jones (5):
      HID: core: Mitigate potential OOB by removing bogus memset()
      HID: logitech-hidpp: Prevent use-after-free on force feedback initialisation failure
      l2tp: pppol2tp: hold reference to session in pppol2tp_ioctl()
      tracing/histograms: Reject non-stacktrace fields for synthetic stacktrace fields
      tracing/histograms: Verify event_call identity when updating synth_event refcount

Lenko Donchev (1):
      drm/amd/display: Use kcalloc() instead of kzalloc()

Leon Huang (1):
      drm/amd/display: Refactor ABM feature

Leon Hwang (4):
      kprobes: Skip disarmed probes when checking optkprobe overlap
      bpf: Prevent tailcall infinite loop caused by freplace
      bpf: Fix WARNING in bpf_tracing_link_release
      bpf: Copy per-CPU map value padding in copy_map_value_long()

Leon Romanovsky (5):
      net/mlx5e: Provide intermediate pointer to access IPsec struct
      ntb: Store original DMA address for future release
      RDMA/cxgb4: Fix dereg_skb leak and double free in write_tpt_entry()
      RDMA/erdma: complete object teardown when the destroy command fails
      RDMA/rvt: Return NULL after port allocation failure

Li Chen (2):
      HID: rate-limit hid_warn to prevent log flooding
      nvdimm: virtio_pmem: refcount requests for token lifetime

Li Qiang (1):
      scsi: ufs: core: Validate string descriptors

Li RongQing (2):
      net/mlx5e: Order ICOSQ cc update after CQ doorbell
      ACPI: processor_idle: Mark LPI enter functions as __cpuidle

Lianfa Weng (1):
      RDMA/hns: Fix log flood after cmd_mbox failure

Lianjie Wang (1):
      hwrng: core - use RCU and work_struct to fix race condition

Liew Rui Yan (1):
      mm/damon/core: fix unconditionally skip last region

Lijo Lazar (4):
      drm/amdgpu: Show vram vendor only if available
      drm/amdgpu: Use dbg level for VBIOS check messages
      drm/amdgpu: Add wrapper for freeing vbios memory
      drm/amdgpu: Add vbios attribute only if supported

Linfeng Sun (1):
      scsi: target: iscsi: Fix race in discovery auth updates

Linfeng Sun  (1):
      vhost_iotlb: bound map allocation in add_range

Linkai Gong (1):
      usb: typec: anx7411 - stop the IRQ before destroying the workqueue

Linmao Li (3):
      Bluetooth: hci_core: Fix inquiry cache timestamps on 64-bit systems
      drm/vc4: Shut down BO cache timer before teardown
      drm/vc4: Prevent shader BO mappings from becoming writable

Linyu Yuan (1):
      usb: gadget: ffs: remove ENTER() macro

Liu Chao (1):
      usb: gadget: f_uac1_legacy: validate bRequest index in generic_{set,get}_cmd

Liu Dalin (1):
      rtc: dev: zero-initialize struct rtc_wkalrm to prevent information leak

Liu Jian (1):
      sunrpc: fix one UAF issue caused by sunrpc kernel tcp socket

Liz Fong-Jones (1):
      PCI: Fix BAR resize for devices on a root bus

Lizhi Xu (1):
      fs/ntfs3: Keep write operations atomic

Loic Poulain (2):
      phy: qcom-qusb2: Fix NULL pointer dereference on early suspend
      i2c: qcom-cci: Fix HALT_ACK reset request being dropped

Longfang Liu (1):
      hisi_acc_vfio_pci: bugfix live migration function without VF device driver

Longlong Xia (2):
      zram: fix out-of-bounds access in read_block_state()
      zram: fix out-of-bounds access in writeback_store()

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: fix LSM6DSV sensor description

Lorenzo Stoakes (ARM) (6):
      mm/mremap: reset unfaulted VMA page offset for MREMAP_DONTUNMAP
      mm/secretmem: properly account locked pages
      mm/mremap: fix locked_vm leak by splitting VMA for MREMAP_DONTUNMAP
      mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge
      mm/ptdump: always stabilise against page table freeing using init_mm
      perf: Track the perf mlock gift separately

Lovekesh Solanki (3):
      Input: i8042 - add nomux quirk for Fujitsu LIFEBOOK U7410
      Input: synaptics - add LEN205b entry to smbus_pnp_ids for ThinkPad T490
      usb: hub: use shorter 120ms post resume hold for SS root hubs

Lu Baolu (3):
      iommu/vt-d: Clear Present bit before tearing down PASID entry
      iommu/vt-d: Clear Present bit before tearing down context entry
      iommu: Add max_pasids field in struct iommu_device

Luis de Arquer (1):
      spi-rockchip: Fix register out of bounds access

Luiz Augusto von Dentz (4):
      Bluetooth: af_bluetooth: Fix deadlock
      Bluetooth: hci_core: Fix possible buffer overflow
      Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
      Bluetooth: hci_core: Print number of packets in conn->data_q

Lukas Wunner (3):
      crypto: virtio - Drop sign/verify operations
      crypto: virtio - Drop superfluous [as]kcipher_ctx pointer
      crypto: virtio - Drop superfluous [as]kcipher_req pointer

Luo Gengkun (1):
      perf: Fix race between perf_event_exit_task() and perf_pending_task()

Luxiao Xu (2):
      bpf: Check sk_state before sk_protocol in bpf_tcp_*_syncookie
      sunrpc: fix use-after-free in __rpc_clnt_handle_event and __rpc_clnt_remove_pipedir

Lyndon Sanche (1):
      platform/x86: dell-smbios: Move request functions for reuse

Ma Xinmeng (1):
      dm-snap: reject the transient exception store for snapshot-merge

Mads Bligaard Nielsen (1):
      drm/bridge: adv7511: fix crash on irq during probe

Magnus Lindholm (2):
      alpha: fix user-space corruption during memory compaction
      alpha: do not clear remote MMU contexts in migrate_flush_tlb_page()

Maher Azzouzi (1):
      esp: do not unref managed frag pages in esp_ssg_unref()

Maher Sanalla (1):
      net/mlx5: Reload only IB representors upon lag disable/enable

Malaya Kumar Rout (1):
      time/namespace: Validate nanosecond field in proc_timens_set_offset()

Manivannan Sadhasivam (2):
      PCI: endpoint: pci-epf-test: Make use of cached 'epc_features' in pci_epf_test_core_init()
      net: qrtr: Drop the MHI auto_queue feature for IPCR DL channels

Manos Pitsidianakis (1):
      hwrng: core - fix rng list on registration error

Manush Prajwal (1):
      rtc: mpfs: fix unchecked devm_clk_get() error pointer in probe()

Maoyi Xie (2):
      rds_tcp: close NULL deref window in rds_tcp_set_callbacks
      wifi: mac80211: defer link RX stats percpu free to RCU

Marc Harvey (2):
      net: team: Remove unused team_mode_op, port_enabled
      net: team: Rename port_disabled team mode op to port_tx_disabled

Marc Kleine-Budde (2):
      can: gs_usb: fix time stamp counter initialization
      can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing data

Marc Zyngier (1):
      KVM: arm64: vgic: Handle race between interrupt affinity change and LPI disabling

Marco Scardovi (1):
      platform/x86: asus-wmi: fix resource leaks on probe failure

Marcus Folkesson (1):
      HID: hid-alps: use default remove for hid device

Marek Czernohous (1):
      drm/nouveau: unsubscribe the channel-kill event before the fence context

Marek Szyprowski (2):
      ASoC: samsung: i2s: enable op_clk in probe to balance runtime PM
      clocksource/drivers/samsung_pwm: Switch to raw_spinlock_t type

Mario Limonciello (6):
      x86/CPU/AMD: Clear virtualized VMLOAD/VMSAVE on Zen4 client
      x86/PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and Phoenix USB4
      drm/amdgpu: Release VFCT ACPI table reference
      platform/x86/amd/pmc: Propagate SMU errors and validate S2D address
      drm/amd: Use attribute groups for PSP flashing attributes
      pinctrl: amd: Clear S4 wake bits when firmware has _AEI

Mario Peter (1):
      usb: chipidea: udc: fix DMA and SG cleanup in _ep_nuke()

Mark Brown (1):
      ASoC: tas2562: Validate values for volume writes

Mark Rutland (2):
      arm64/fpsimd: signal: Forbid non-streaming SVE payload on SME-only systems
      arm64: entry: fix ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD

Mark Tomlinson (1):
      gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock

Markus Elfring (1):
      crypto: virtio - Less function calls in __virtio_crypto_akcipher_do_req() after error detection

Martin Kaiser (2):
      test_kprobes: clear kprobes between test runs
      riscv: probes: save original sp in rethook trampoline

Martin Wilck (1):
      md/raid1: create serial pool adding rdev to array with serialize_policy=1

Martino Papero (1):
      Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3 15IWC11

Matt Bobrowski (1):
      bpf: Fix UAF in sock clone early bailouts

Matt Fleming (1):
      mm/huge_memory: initialise workingset state before folio split

Matt Johnston (2):
      net: mctp: unshare packets when reassembling
      net: mctp: Don't access ifa_index when missing

Matthew Wilcox (Oracle) (7):
      fs: Free any excess xarray nodes in clear_inode()
      f2fs: Use a folio in f2fs_truncate_partial_cluster()
      ext4: convert bd_bitmap_page to bd_bitmap_folio
      ext4: convert bd_buddy_page to bd_buddy_folio
      fs: Remove NTFS classic
      tracing: Move readpos from seq_buf to trace_seq
      powerpc: Remove initialisation of readpos

Matthieu Baerts (1):
      mptcp: userspace pm: use a single point of exit

Matthieu Baerts (NGI0) (3):
      mptcp: pm: reset retrans_time when ADD_ADDR entry is reused
      rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy
      mptcp: avoid combining some incoming suboptions

Maud Spierings (1):
      iio: common: st_sensors: Fix use of uninitialize device structs

Maurizio Lombardi (3):
      nvme-pci: fix race condition between reset and nvme_dev_disable()
      nvme-tcp: fix potential memory corruption in nvme_tcp_recv_pdu()
      nvmet: fix max_qid race between configfs and controller allocation

Mauro Carvalho Chehab (1):
      media: av7110: fix a spectre vulnerability

Max Kellermann (2):
      ceph: fix memory leaks in ceph_mdsc_build_path()
      ceph: do not repeat ceph_trim_dentries() if no progress possible

Maxim Skokov (1):
      Bluetooth: RFCOMM: free the skb when the DLC has no owner

Maxime Chevallier (1):
      net: phy: clean the sfp upstream if phy probing fails

Maxime Méré (1):
      crypto: stm32/cryp - call finalize with bh disabled

Maíra Canal (2):
      drm/vc4: Free the BO cache size list on teardown
      drm/v3d: Clear queue->active_job when v3d_fence_create() fails

Mehmet Fide (2):
      mtd: rawnand: vf610_nfc: fix reads on chips with more than 64 bytes of OOB
      mtd: rawnand: vf610_nfc: fix false bitflips on reads of erased pages

Miaohe Lin (1):
      fork: defer linking file vma until vma is fully initialized

Michael Bommarito (6):
      ceph: bound copied dentry name length in NFS export get_name
      ksmbd: validate num_aces and harden ACE walk in smb_inherit_dacl()
      ksmbd: validate response sizes in ipc_validate_msg()
      nvmet-auth: reject short AUTH_RECEIVE buffers
      xen/pvcalls: bound backend response req_id before indexing rsp[]
      ceph: cap delegated inode count in ceph_parse_deleg_inos()

Michael Garland (1):
      ASoC: amd: yc: Add DMI quirk for Acer Aspire Go 15 (AG15-21P)

Michael Guralnik (2):
      RDMA/mlx5: Change the cache structure to an RB-tree
      RDMA/mlx5: Introduce mlx5r_cache_rb_key

Michael Kelley (2):
      Drivers: hv: vmbus: Skip VMBus module cleanup for non-nested root partition
      Drivers: hv: Don't reset VMBus connection state on error/exit paths

Michael S. Tsirkin (3):
      virtio: break and reset virtio devices on device_shutdown()
      vhost: move smp_rmb() into vhost_get_avail_idx()
      vhost: fix vhost_get_avail_idx for a non empty ring

Michael Zimmermann (1):
      usb: gadget: f_hid: don't call cdev_init while cdev in use

Michael-CY Lee (1):
      wifi: mt76: fix non-AQL packet accounting for MLO stations

Michal Kubiak (1):
      ice: fix Tx scheduler error handling in XDP callback

Michal Luczaj (1):
      vsock: treat TCP_CLOSING as once-established

Michal Schmidt (1):
      ice: fix double-free of tx_buf skb

Michele Dionisio (1):
      wifi: brcmfmac: fix P2P device removal race in brcmf_detach()

Mika Westerberg (1):
      thunderbolt: Fix KASAN reported use-after-free when request is canceled

Mike Tipton (1):
      interconnect: Don't access req_list while it's being manipulated

Mikhail Gavrilov (3):
      Bluetooth: RFCOMM: connect the session socket without rfcomm_mutex
      drm/amdgpu: copy debugfs register data outside the GRBM/SRBM locks
      drm/amdgpu: replace PASID IDR with XArray

Mikhail Lobanov (1):
      KVM: SVM: Forcibly leave SMM mode on SHUTDOWN interception

Mikulas Patocka (4):
      dm: fix reading free memory in do_resume
      dm-verity: fix buffer overflow in FEC calculation
      dm ioctl: a small code cleanup in list_version_get_info
      dm-ioctl: fix a possible overflow in list_version_get_info

Milena Olech (1):
      ice: Fix improper extts handling

Ming Qian (3):
      pmdomain: imx8m-blk-ctrl: Serialize power on/off across sibling domains
      media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC
      media: verisilicon: Fix kernel panic due to __initconst misuse

Ming-Hung Tsai (1):
      dm cache: fix demotion stats in passthrough mode

Mingming Cao (2):
      ibmveth: h_free logical LAN on open-fail after register
      ibmveth: fix TX LTB and filter unwind on open-fail

Mingyu Wang (1):
      tty: vt: fix memory leak in vc_allocate()

Minseong Kim (1):
      Input: lkkbd - disable pending work before freeing device

Miquel Raynal (2):
      mtd: Clean refcounting with MTD_PARTITIONED_MASTER
      mtd: maps: vmu-flash: Fix the (mtd core) switch to ref counters

Miquel Sabaté Solà (1):
      btrfs: fix NULL dereference on root when tracing inode eviction

Miri Korenblit (1):
      wifi: iwlwifi: don't warn when if there is a FW error

Mohamed Khalfella (1):
      nvme-fc: Do not cancel requests in io target before it is initialized

Moon Hee Lee (1):
      fs/ntfs3: reject index allocation if $BITMAP is empty but blocks exist

Morduan Zang (1):
      net: phonet: do not BUG_ON() in pn_socket_autobind() on failed bind

Mostafa Saleh (2):
      KVM: arm64: Don't use the VMA to size stage-2 block mappings for VM_PFNMAP
      firmware: arm_ffa: Fix out-of-bound writes in ffa_setup_and_transmit()

Moti Haimovski (1):
      accel/habanalabs: support mapping cb with vmalloc-backed coherent memory

Muhammad Bilal (2):
      staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()
      staging: sm750fb: fix mono image source stride mismatch in lynxfb_ops_imageblit()

Muhammad Usama Anjum (1):
      misc: sgi-gru: remove interrupt-context page-table walks

Mukesh Ojha (2):
      pinmux: Use sequential access to access desc->pinmux data
      pinmux: fix race causing mux_owner NULL with active mux_usecount

Murad Masimov (1):
      ax25: Remove broken autobind

Myeonghun Pak (10):
      usb: storage: realtek_cr: fix use-after-free on disconnect
      bna: prevent IOC timer rearm during teardown
      usb: ohci-da8xx: disable controller wakeup on cleanup
      usb: ohci-s3c2410: disable controller wakeup on removal
      usb: ohci-st: disable controller wakeup on removal
      usb: chipidea: tegra: disable runtime PM on resume failure
      usb: ohci-spear: disable controller wakeup on removal
      drm/aspeed: Balance the display clock enable on teardown
      usb: typec: tcpci_rt1711h: unregister TCPCI port with devres
      crypto: keembay - Fix AEAD unregister count in error path

Namhyung Kim (1):
      perf tools: Fix a asan issue in parse_events_multi_pmu_add()

Namjae Jeon (20):
      smb: client: use finish_no_open() for non-regular inodes
      ksmbd: check outstanding simultaneous SMB operations
      ksmbd: prevent connection release during oplock break notification
      ksmbd: fix use-after-free in ksmbd_free_work_struct
      ksmbd: fix null pointer dereference in alloc_preauth_hash()
      ksmbd: prevent rename with empty string
      ksmbd: add chann_lock to protect ksmbd_chann_list xarray
      ksmbd: use volume UUID in FS_OBJECT_ID_INFORMATION
      ksmbd: use opener credentials for ADS I/O
      ksmbd: use opener credentials for delete-on-close
      ksmbd: prevent path traversal bypass by restricting caseless retry
      ksmbd: bound DACL dedup walk to copied ACEs
      ksmbd: zero pipe read compound padding
      ksmbd: detach blocked lock requests before freeing
      ksmbd: safely discard unregistered deferred locks
      ksmbd: serialize oplock close with pending break ownership
      ksmbd: free preauth sessions on connection teardown
      ksmbd: fix maximum allowed access checks
      ksmbd: preserve VFS inherited POSIX ACL mask
      ksmbd: fix r_count dec/increment mismatch

Narasimharao Vadlamudi (1):
      media: rkvdec: Propagate platform_get_irq() errors

Nathan Lynch (1):
      seq_buf: Make DECLARE_SEQ_BUF() usable

Neill Kapron (1):
      usb: gadget: f_fs: Fix Use-After-Free in AIO error path

Nguyen Dinh Phi (1):
      vsock: don't check the listener's sk_err in vsock_accept()

Nguyen Ngoc Thang (4):
      ALSA: caiaq: unregister the input device when probe fails
      Bluetooth: hci_sync: don't drain cmd_sync backlog on unregister
      memstick: rtsx_usb_ms: complete requests after eject instead of dropping them
      drm/fb-helper: defer setup when fbdev_probe() fails, not just on -EAGAIN

Nicholas Carlini (1):
      ksmbd: fix signededness bug in smb_direct_prepare_negotiation()

Nicholas Dudar (1):
      bpf: Reject rdonly/rdwr_buf_size kfunc arguments that exceed u32 max

Nick Child (1):
      ibmveth: Always stop tx queues during close

Nicolai Buchwitz (2):
      net: bcmgenet: fix NULL dereference in set_coalesce before first open
      net: bcmgenet: unshare the skb before writing the control block

Nicolas Dufresne (1):
      media: v4l2-mem2mem: Add a kref to the v4l2_m2m_dev structure

Nicolas Escande (1):
      wifi: ath11k: reset ar->num_stations on hardware start

Nikhil Gurudasani (1):
      erofs: preserve LZMA decoders on resize failure

Nikita Zhandarovich (1):
      drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()

Niklas Cassel (2):
      PCI: dwc: ep: Prevent changing BAR size/flags in pci_epc_set_bar()
      PCI: dwc: ep: Flush MSI-X write before unmapping its ATU entry

Niklas Schnelle (1):
      s390/pci: Fix leak of uninitialized kernel data in SCLP report

Nikola Prica (1):
      PCI: Accept AtomicOps already enabled by the hypervisor

Nikolay Aleksandrov (3):
      bonding: fix use-after-free due to enslave fail after slave array update
      vxlan: fix reading neigh ha
      net: bridge: arp/nd proxy: fix reading neigh ha

Nikolay Kuratov (1):
      drm/msm/dpu: Add missing NULL pointer check for pingpong interface

Nilesh Javali (13):
      scsi: qla2xxx: Zero dport diagnostics buffer to avoid info leak
      scsi: qla2xxx: Fix queue teardown NULL dma_free and bitmap locking
      scsi: qla2xxx: Fix use-after-free of qpair work on queue teardown
      scsi: qla2xxx: Validate BSG request_len before reading vendor_cmd[]
      scsi: qla2xxx: Null out freed pointers in qla2x00_mem_alloc() error path
      scsi: qla2xxx: Fix 64G link speed reporting in get_data_rate
      scsi: qla2xxx: Quiesce response IRQ before freeing request queue
      scsi: qla2xxx: Use memset_io() to clear QLAFX00 request ring slot
      scsi: qla2xxx: Fix soft lockup polling continuation IOCB signature
      scsi: qla2xxx: Initialize NVMe abort_work once at submission
      scsi: qla2xxx: Fix NVMe abort reference leak on repeated abort
      scsi: qla2xxx: Skip vport under deletion in report ID acquisition
      scsi: qla2xxx: Bound VP index against VP_CTRL IOCB bitmap size

Nirbhay Sharma (1):
      fs/ntfs3: fix KMSAN uninit-value in ni_create_attr_list

Nitin Rawat (1):
      scsi: ufs: ufs-qcom: Fix UFS OCP issue during UFS power down (PC=3)

Norbert Szetei (1):
      landlock: Fix use-after-free of the source's parent directory

Nuno Sá (2):
      mtd: spinand: fix zero oobavail when no ECC engine is used
      mtd: spinand: fix NULL pointer dereference with no ECC engine

Ohad Sharabi (2):
      habanalabs: remove support to export dmabuf from handle
      habanalabs: helper function to validate export params

Oleg Keri (1):
      drm/dp: don't mark the AUX backlight enabled when enabling failed

Oleh Konko (1):
      Bluetooth: hci_event: move wake reason storage into validated event handlers

Oleksij Rempel (1):
      net: stmmac: Correctly handle Rx checksum offload errors

Oliver Hartkopp (1):
      can: fix unique skb identifier regression under RPS

Omar Ramadan (1):
      amt: send the relay's General Query directly from the receive path

Orgad Shaneh (1):
      usb: octeon-hcd: fix the FIFO-flush timeout computation

Oscar Ou (1):
      lockd: fix swapped arguments in nlmsvc_match_ip()

Pablo Neira Ayuso (8):
      netfilter: nf_tables: set->ops->insert returns opaque set element in case of EEXIST
      netfilter: nf_tables: fix memleak in map from abort path
      netfilter: nat: use kfree_rcu to release ops
      netfilter: cttimeout: detach dataplane timeout policy and repurpose refcount
      netfilter: nf_conntrack_expect: use conntrack GC to reap expectations
      netfilter: nf_tables: clone set on flush only
      netfilter: nf_tables: skip double clone set expressions on element insert
      netfilter: ctnetlink: do not expose expectation DEAD flag

Pagadala Yesu Anjaneyulu (1):
      wifi: mac80211: ibss: wait for in-flight TX on disconnect

Palla Raghunath (2):
      dm ioctl: don't let data_start run past the buffer
      Bluetooth: RFCOMM: Fix NULL tty_dev dereference in rfcomm_dev_shutdown

Paloma Arellano (1):
      drm/msm/dpu: Add mutex lock in control vblank irq

Pankaj Gupta (1):
      KVM: SEV: Drop FOLL_WRITE for encrypted region registration

Pannarat Wiriyaarritham (1):
      usb: typec: ucsi: acpi: Assume UCSI 1.2 on Acer Nitro ANV15-41

Paolo Abeni (1):
      mptcp: prevent race between disconnect() and rtx

Patrisious Haddad (2):
      RDMA/mlx5: Move events notifier registration to be after device registration
      RDMA/mlx5: Fix implicit ODP use after free

Paul Aurich (2):
      smb: Don't leak cfid when reconnect races with open_cached_dir
      smb: Initialize cfid->tcon before performing network ops

Paul Cercueil (3):
      usb: gadget: Support already-mapped DMA SGs
      usb: gadget: functionfs: Factorize wait-for-endpoint code
      mfd: sm501: Remove #ifdef guards for PM related functions

Pauli Virtanen (4):
      Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if exists
      Bluetooth: ISO: hold sk properly in iso_conn_ready
      Bluetooth: L2CAP: access chan->conn safely in get/setsockopt
      Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn

Paulo Alcantara (12):
      smb: client: fix file type corruption in cifs_reparse_point_to_fattr()
      smb: client: discard post-EOF pagecache when extending a file via zero range
      smb: client: fix use-after-free in smb2_query_info_compound()
      smb: client: stop flooding dmesg in smb2_calc_signature()
      smb: client: fix use-after-free of signing key
      smb: client: fix double free of TCP_Server_Info::hostname
      smb: client: fix UAF in decryption with multichannel
      smb: client: fix potential deadlock when reconnecting channels
      cifs: get rid of dns resolve worker
      smb: client: avoid using uninitialized SIDs in cifs_posix_to_fattr()
      smb: client: honor forceuid/forcegid when mapping SIDs to uid/gid
      smb: client: fix multiuser mount with krb5

Pavankumar Kondeti (1):
      workqueue: Fix NULL current_pwq deref in chained work check

Pavel Begunkov (1):
      io_uring: check for overflows in io_pin_pages

Peddolla Harshavardhan Reddy (1):
      wifi: cfg80211: convert pmsr_free_wk to wiphy_work to fix deadlock

Pei Xiao (1):
      mtd: block2mtd: Fix divide error when erase_size is zero

Peilin Ye (1):
      bpf: Tell memcg to use allow_spinning=false path in bpf_timer_init()

Peng Fan (4):
      pmdomain: imx93-blk-ctrl: correct remove path
      pmdomain: imx: Fix i.MX8MP VC8000E power up sequence
      gpio: mxc: fix both_edges bit operations
      gpio: mxc: fix wakeup_pads bit operations

Pengpeng Hou (4):
      iio: adc: aspeed: propagate reset deassert errors
      iio: cdc: ad7150: fix OF matching and publish module aliases
      tracing: Bound synthetic-field strings with seq_buf
      net: qlcnic: validate unified ROM sections before loading

Perry Yuan (2):
      drm/amd/pm: Disable MMIO access during SMU Mode 1 reset
      drm/amdgpu: ensure no_hw_access is visible before MMIO

Peter Griffin (1):
      scsi: ufs: exynos: Disable iocc if dma-coherent property isn't set

Peter Jones (1):
      efi: Don't map the entire mokvar table to determine its size

Peter Ujfalusi (2):
      ASoC: SOF: ipc4-pcm: Workaround for crashed firmware on system suspend
      ASoC: SOF: ipc4-topology: Harden loops for looking up ALH copiers

Peter Xu (2):
      mm/hugetlb: fix avoid_reserve to allow taking folio from subpool
      mm/userfaultfd: reset ptes when close() for wr-protected ones

Peter Zijlstra (2):
      x86/ftrace: Remove SYSTEM_BOOTING exceptions
      perf: Fix addr_filter_ranges lifetime

Petr Machata (3):
      net: nexthop: Have all NH notifiers carry NH ID
      net: nexthop: Increase weight to u16
      Documentation: networking: Add a caveat to nexthop_compat_mode sysctl

Petr Tesarik (2):
      net: stmmac: protect updates of 64-bit statistics counters
      dma-direct: cleanup parameters to dma_direct_optimal_gfp_mask

Petr Wozniak (1):
      xfrm: fix stale skb->prev after async crypto steals a GSO segment

Phil Sutter (2):
      netfilter: IDLETIMER: Fix for possible ABBA deadlock
      netfilter: nf_tables: Extend nft_expr_ops::dump callback parameters

Philip Yang (1):
      drm/amdkfd: debugfs hang_hws skip GPU with MES

Philipp Stanner (1):
      drm/sched: Use struct for drm_sched_init() params

Philippe Simons (1):
      clk: sunxi-ng: h616: Reparent GPU clock during frequency changes

Ping-Ke Shih (4):
      wifi: rtw89: fix race between cancel_hw_scan and hw_scan completion
      wifi: rtw88: debugfs: support multiple adapters debugging
      wifi: rtw89: pci: validate sequence number of TX release report
      wifi: rtw89: phy: check length before parsing PHY status IE

Po-Hao Huang (1):
      wifi: rtw89: fix null pointer access when abort scan

Prasanna Kumar T S M (1):
      soc: xilinx: Shutdown and free rx mailbox channel

Prashanth K (2):
      usb: typec: ucsi: Get the connector fwnode based on reg value
      usb: dwc3: gadget: Move vbus draw to workqueue context

Prathamesh Deshpande (1):
      IB/mlx5: Fix transport-domain rollback and initialize lb mutex earlier

Prike Liang (1):
      drm/amdgpu: fix the idr allocation flags

Priya Hosur (1):
      drm/amdkfd: Add TLB flush after MES queue eviction/suspension

Pu Lehui (3):
      bpf, cgroup: Fix storage null-ptr-deref after replacing prog
      bpf, cgroup: Fix invalid storage access after __cgroup_bpf_attach failed
      bpf: Fix potential UAF when reading bpf link info

Qi Tang (1):
      xfrm: hold dev ref until after transport_finish NF_HOOK

Qianchang Zhao (1):
      ksmbd: vfs: fix race on m_flags in vfs_cache

Qihang (1):
      ksmbd: pin conn during async oplock break notification

Qing Luo (1):
      mptcp: pm: userspace: fix address ID overflow

Qing Ming (3):
      gtp: serialize PDP context updates
      cgroup/rstat: validate cpu before css_rstat_cpu() access
      usb: gadget: uac: validate rate list length before storing

Qiuxu Zhuo (1):
      EDAC/igen6: Fix call trace due to missing release()

Qu Wenruo (8):
      btrfs: do proper folio cleanup when cow_file_range() failed
      btrfs: reject new transactions if the fs is fully read-only
      btrfs: do not ASSERT() when the fs flips RO inside btrfs_repair_io_failure()
      btrfs: only release the dirty pages io tree after successful writes
      btrfs: avoid NULL pointer dereference if no valid extent tree
      btrfs: avoid NULL pointer dereference if no valid csum tree
      btrfs: qgroup: fix a wrong length calculation in qgroup_free_reserved_data()
      btrfs: always wait for ordered extents to avoid OE races

Quanfa Fu (1):
      apparmor: make aa_set_current_onexec return void

Quchaosheng (1):
      net/packet: guard the ll header push in packet_rcv_spkt()

Quentin Freimanis (1):
      net: sparx5: make ports inherit the switch base mac address type

Radek Podgorny (1):
      Bluetooth: do not leak an hci_conn when a second LE connect is rejected

Radhey Shyam Pandey (2):
      usb: dwc3: am62: Fix runtime PM usage count leak on probe error path
      usb: typec: tipd: fix uninitialized typec_partner_desc in tps6598x_connect()

Radim Krčmář (1):
      riscv: use lw when reading int cpu in asm_per_cpu

Rafael J. Wysocki (6):
      ACPI: TAD: Rearrange RT data validation checking
      ACPI: TAD: Split three functions to untangle runtime PM handling
      ACPI: TAD: Add locking around AML evaluations
      platform/x86: intel_sar: Check ACPI_HANDLE() against NULL
      thermal: hwmon: Remove hwmon class device along with its parent
      ACPI: bus: Introduce acpi_bus_get_primary_device()

Raghavendra Rao Ananta (1):
      KVM: arm64: Get rid of userspace_irqchip_in_use

Raj Ojha (1):
      memstick: core: wait for request completion before freeing card

Ralph Boehme (1):
      smb/client: fix chown/chgrp with SMB3 POSIX Extensions

Ramses de Norre (1):
      wireguard: queueing: preserve tstamp_type when encapsulating packet

Randy Dunlap (1):
      mailbox: zynqmp-ipi: fix an Excess struct member kernel-doc warning

Ranjan Kumar (2):
      scsi: mpi3mr: Fix corrupt config pages PHY state is switched in sysfs
      scsi: mpi3mr: Synchronous access b/w reset and tm thread for reply queue

Raphael Zimmer (1):
      libceph: Fix potential out-of-bounds access in __ceph_x_decrypt()

Raphaël Larocque (1):
      Input: synaptics - limit T440p InterTouch quirk to LEN0036

Ratheesh Kannoth (1):
      octeontx2-af: npc: Fix size of entry2cntr_map

Reinette Chatre (1):
      fs/resctrl: Prevent use-after-free in rdtgroup_kn_put()

Richard Cheng (1):
      cxl/mbox: Clamp mailbox output allocation to the payload size

Rick Edgecombe (1):
      hv_netvsc: Don't free decrypted memory

Ridham Khurana (1):
      gpio: xilinx: fix runtime PM leak on request error path

Ritesh Harjani (IBM) (1):
      powerpc/64s: Fix unmap race with PMD migration entries

Rob Clark (1):
      interconnect: Fix locking for runpm vs reclaim

Rob Herring (3):
      of: Move of_device_(add|register|unregister) to of_platform.h
      of: Move of_device_get_match_data() declaration
      mailbox: Explicitly include correct DT includes

Robbie Ko (1):
      nfsd: reject out-of-range nseconds in NFSv3 SETATTR and create ops

Rodrigo Siqueira (1):
      drm/amd/display: Check null pointer before try to access it

Roger Quadros (1):
      dmaengine: ti: k3-udma-glue: Drop skip_fdq argument from k3_udma_glue_reset_rx_chn

Romain Gantois (1):
      net: stmmac: Prevent DSA tags from breaking COE

Ronnie Sahlberg (1):
      ublk: santizize the arguments from userspace when adding a device

Rory Little (1):
      wifi: mt76: mt7921: Place upper limit on station AID

Rosen Penev (1):
      ata: sata_dwc_460ex: fix infinite loop in NCQ tag completion bit-scanning

Runyu Xiao (6):
      rtc: spear: initialize IRQ state before requesting alarm IRQ
      mtd: rawnand: cadence: Initialize IRQ state before requesting IRQ
      USB: dwc2: shut down wakeup timer before freeing HCD state
      scsi: qedi: Initialize callback state before registration
      ALSA: mtpav: shut down output timer before card teardown
      sunrpc: xprtsock: annotate shared socket callbacks with READ_ONCE/WRITE_ONCE

Ruoyu Wang (2):
      i2c: mxs: fix DMA channel leak on probe error
      drm/msm: Only fini scheduler after successful init

Rupesh Majhi (1):
      iio: pressure: dps310: fix NULL pointer dereference on ACPI probe

Ryan Lin (1):
      HID: intel-ish-hid: fix NULL-ptr-deref in ishtp_bus_remove_all_clients

Ryan Roberts (1):
      mm: clear uffd-wp PTE/PMD state on mremap()

Ryusuke Konishi (1):
      nilfs2: fix BUG in nilfs_copy_dirty_pages() on dirty state mismatch

SJ Park (1):
      mm/damon/core: don't skip damos_adjust_quota() while esz is not zero

Sabrina Dubroca (5):
      strparser: make sure __strp_recv isn't running before tearing down the parser
      mpls: add seqcount to protect the platform_label{,s} pair
      selftests: tls: add getsockopt test
      selftests: tls: add test with a partially invalid iov
      selftests: tls: add rekey tests

Sahil Chandna (1):
      net: mana: Reserve extra CQ slot for the fence completion CQE

Sai Teja Aluvala (1):
      Bluetooth: btintel: validate DDC record lengths

Sajal Gupta (1):
      drm/gud: don't keep a connector without a CRTC as connector_state

Salah Triki (4):
      iio: accel: sca3000: fix frequency divider condition check
      iio: frequency: admv1013: fix wrong channel field used in admv1013_read_raw()
      iio: proximity: isl29501: Fix return type of isl29501_register_write
      iio: proximity: vcnl3020: fix ISR bitmask check in IRQ handler

Samiullah Khawaja (1):
      PCI: Initialize temporary device in new_id_store()

Sandipan Das (2):
      perf/x86/amd/lbr: Fix kernel address leakage
      perf/x86/amd/core: Avoid enabling BRS from the SVM reload path

Sang-Hoon Choi (4):
      Bluetooth: hci_core: free the HCI ID if naming fails
      gpio: exar: initialize the ID before registering its cleanup
      cxgb4/ch_ktls: disable softirqs around tid_list erases
      nvmet: use the local P2P device on metadata allocation failure

Sanghyun Park (2):
      vxlan: use one headroom snapshot for neighbour replies
      bpf: Fix mmap_lock leak in irq_work path

Sarika Sharma (2):
      wifi: mac80211: refactor populating mesh related fields in sinfo
      wifi: cfg80211: add link_station_info structure to support MLO statistics

Sasha Levin (2):
      samples: pidfd: fix userprogs typo
      tools: gpio: fix building from the top level with O=

Sean Anderson (1):
      drm: zynqmp_kms: Unplug DRM device before removal

Sean Christopherson (5):
      KVM: SVM: Use the active VMCB's MSR bitmap when checking if MSR is intercepted
      KVM: SEV: Protect *all* of sev_mem_enc_register_region() with kvm->lock
      KVM: Don't WARN if memory is dirtied without a vCPU when the VM is dying
      KVM: SEV: Ignore Port I/O requests of length '0'
      KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails due to invalid guest state

Sean Heelan (1):
      ksmbd: Fix UAF in __close_file_table_ids

Sebastian Reichel (1):
      media: hantro: Disable multicore support

Sebastian Sjoholm (1):
      USB: serial: option: add Quectel RG660QB

Sebastien Royen (1):
      net: dsa: microchip: fix KSZ8765 fiber detection

Sechang Lim (1):
      bpf: Fix RCU stall in bpf_fd_array_map_clear()

SeongJae Park (1):
      mm/damon/core: do non-safe region walk on kdamond_apply_schemes()

Seppo Takalo (1):
      tty: n_gsm: Don't block input queue by waiting MSC

Sergey Senozhatsky (2):
      zram: fixup read_block_state()
      seq_buf: Add seq_buf_do_printk() helper

Sergey Tiraspolsky (1):
      ASoC: Intel: avs: Reset the stream unless it is already prepared

SeungJu Cheon (1):
      Bluetooth: ISO: Fix data-race on iso_pi fields in hci_get_route calls

Shakeel Butt (1):
      mm/mlock: use the IRQ-safe accessor for NR_MLOCK in __munlock_folio()

Shameer Kolothum (1):
      iommu/arm-smmu-v3: Manage teardown with devm

Shao-Fu Chen (1):
      optee: register TEE devices only once fully initialized

Shashank Sharma (1):
      drm/amdgpu: change vm->task_info handling

Shaurya Rane (1):
      cifs: fix memory leak in smb3_fs_context_parse_param error path

Shawn Lin (3):
      pmdomain: rockchip: fix clock leak on domain probe failure
      pmdomain: rockchip: don't ignore clock lookup errors on attach
      pmdomain: rockchip: propagate subdomain add errors

Shay Drory (4):
      net/mlx5e: Fix netif state handling
      RDMA/mlx5: Implement mkeys management via LIFO queue
      net/mlx5: Add generic getters for other functions caps
      net/mlx5e: TC, Check if flow is PEER before acquiring devcom lock

Sheetal (1):
      ASoC: tegra: Fix ASRC Stream6 input threshold control

Shenwei Wang (2):
      gpio: mxc: enable pad wakeup on i.MX8x platforms
      gpio: mxc: map Both Edge pad wakeup to Rising Edge

Shiwu Zhang (1):
      drm/amdgpu: fix buffer overflow during vBIOS update

Shota Zaizen (1):
      ksmbd: validate inherited ACE SID length

Showrya M N (1):
      RDMA/siw: Add sendpage_ok() check to disable MSG_SPLICE_PAGES

Shreeya Patel (1):
      iio: light: ltrf216a: Return floating point values

Shuai Xue (1):
      x86/mce: use is_copy_from_user() to determine copy-from-user context

Shuangpeng Bai (2):
      lockd: fix NULL dereference on lockowner allocation failure
      btrfs: fix extent map leak in NOCOW direct I/O write

Shyam Prasad N (1):
      cifs: Fix locking usage for tcon fields

Sibi Sankar (1):
      soc: qcom: icc-bwmon: Fix refcount imbalance seen during bwmon_remove

Sicong Huang (1):
      virt: acrn: Fix irqfd use-after-free during eventfd shutdown

Simon Gassner (1):
      serial: tegra: don't clear the Tx FIFO on an Rx-only reset

Siyang Liu (1):
      drm/amd/display: fix a Null pointer dereference vulnerability

Song Shuai (1):
      riscv: Remove SHADOW_OVERFLOW_STACK_SIZE macro

Sreekanth Reddy (1):
      bnxt_en: Fix memory corruption when FW resources change during ifdown

Srinivas Kandagatla (1):
      ASoC: qcom: q6asm: handle the responses after closing

Srinivasan Shanmugam (9):
      drm/amd/display: Add NULL test for 'timing generator' in 'dcn21_set_pipe()'
      drm/amd/display: Fix 'panel_cntl' could be null in 'dcn21_set_backlight_level()'
      drm/amd/display: Add null check for pipe_ctx->plane_state in dcn20_program_pipe
      drm/amd/display: Add null check for head_pipe in dcn32_acquire_idle_pipe_for_head_pipe_in_layer
      drm/amd/display: Add null check for head_pipe in dcn201_acquire_free_pipe_for_layer
      drm/amd/display: Implement bounds check for stream encoder creation in DCN401
      drm/amd/display: Avoid NULL dereference in dc_dmub_srv error paths
      drm/amd/amdgpu: Fix errors & warnings in amdgpu _bios, _cs, _dma_buf, _fence.c
      drm/amd/amdgpu: Fix errors & warnings in amdgpu _uvd, _vce.c

Srish Srinivasan (1):
      keys/trusted_keys: return immediately after TPM unseal failure

Stanislav Fomichev (1):
      bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in BPF_LINK_CREATE

StanleyYP Wang (1):
      wifi: mt76: mt7915: set correct background radar capability

Stefan Haberland (1):
      s390/dasd: Fix undersized format-check buffer

Stefan Metzmacher (2):
      smb: client: let smbd_destroy() call disable_work_sync(&info->post_send_credits_work)
      smb: client: let recv_done verify data_offset, data_length and remaining_data_length

Stefan Raspl (1):
      s390/ism: Introduce struct ism_dmb

Stefano Brivio (1):
      udp: Deal with race between UDP socket address change and rehash

Stefano Garzarella (1):
      KEYS: trusted: Fix blob allocation size in tpm2_key_decode()

Stefano Stabellini (1):
      9p/xen: protect xen_9pfs_front_free against concurrent calls

Steffen Klassert (2):
      xfrm: Wait for RCU readers during policy netns exit
      Revert "esp: do not unref managed frag pages in esp_ssg_unref()"

Stepan Ionichev (1):
      tty: serial: 8250: protect against NULL uart->port.dev in register

Stephan Müller (1):
      crypto: jitter - replace LFSR with SHA3-256

Stephen Smalley (2):
      selinux: preserve NATIVE_LABELS on already-initialized sb in set_mnt_opts
      selinux: allow multiple opens of /sys/fs/selinux/policy

Steve French (1):
      smb3: make query_on_disk_id open context consistent and move to common code

Steve Wilkins (1):
      spi: microchip-core: ensure TX and RX FIFOs are empty at start of a transfer

Steven Rostedt (4):
      ftrace: Take trace_array reference before accessing its ftrace_ops
      ftrace: Synchronize the initialization of ftrace_ops
      tracing: Add recursion protection in kernel stack trace recording
      tracing: Take trace_array reference when opening options file

Stylon Wang (1):
      drm/amd/display: Add interface to enable DPIA trace

Sudeep Holla (11):
      firmware: arm_scmi: Fix SCMI device destroy lifetimes
      firmware: arm_scmi: Publish channel state before callbacks
      firmware: arm_scmi: Use channel ID for transport teardown
      firmware: arm_scmi: Reject out of range DT protocol IDs
      firmware: arm_scmi: Avoid IDR updates while cleaning channels
      firmware: arm_scmi: Protect device request lookup with RCU
      firmware: arm_scmi: Free transport channel on IDR failure
      firmware: arm_scmi: Unregister device notifier before IDR teardown
      firmware: arm_scmi: Unrequest devices if driver registration fails
      firmware: arm_scmi: Fix requested device removal race
      firmware: arm_scmi: Drop handle on protocol bind failures

Sumit Kumar (1):
      bus: mhi: ep: Update read pointer only after buffer is written

Sun YangKai (1):
      btrfs: check if root is readonly when setting posix acl

Sung Byeongchan (1):
      autofs: ignore notification errors from a replaced pipe

Sungwoo Kim (1):
      Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()

Suraj Kandpal (2):
      drm/i915/hdcp: Add encoder check in intel_hdcp_get_capability
      drm/i915/hdcp: Add encoder check in hdcp2_get_capability

Sven Peter (1):
      nvme-apple: Destroy the admin queue on removal

Svyatoslav Ryhel (1):
      drm/tegra: gr2d/gr3d: Initialize address register map before HOST1X client is registered

Syed Labeeq Sajid Bukhari (1):
      usb: storage: sierra_ms: reject short SWoC info transfers

Taehee Yoo (1):
      eth: bnxt: fix truesize for mb-xdp-pass case

Taeyang Lee (1):
      perf/core: Detach event groups during remove_on_exec

Tahera Fahimi (1):
      xfrm: prevent policy_hthresh.work from racing with netns teardown

Takashi Iwai (8):
      ALSA: usb-audio: Optimize the copy of packet sizes for implicit fb handling
      ALSA: usb-audio: Apply IGNORE_CTL_ERROR quirk to all Audient devices
      ALSA: mixer: oss: Add card disconnect checkpoints
      ALSA: pcm: oss: Fix data race at accessing runtime.oss.trigger
      ALSA: seq: fifo: Use guard() for locking
      ALSA: seq: Clean up fifo locking with guard
      ALSA: seq: Drop superfluous filter argument of get_event_dest_client()
      ALSA: seq: oss: Fix UAF at handling events with embedded SysEx data

Takashi Sakamoto (1):
      firewire: core: fix memory leak in error path of build_tree()

Tamaki Yanagawa (1):
      netfilter: nft_lookup: fix catchall element handling with inverted lookups

Tao Cui (1):
      RDMA/counter: Fix num_counters leak on bind_qp failure in alloc_and_bind()

Tatsuya S (1):
      HID: core: Add reserved item tag for main items

Tejun Heo (2):
      sched/core: Make core-sched flips wait for in-flight selections
      sched/psi: Create the psimon kthread outside of cgroup_mutex

Tengda Wu (1):
      tracing: Fix hist trigger timestamps for buffered events

Tetsuo Handa (4):
      perf/core: Fix WARN in perf_sigtrap()
      xfrm: always flush state and policy upon NETDEV_UNREGISTER event
      team: avoid NETDEV_CHANGEMTU event when unregistering slave
      net: add missing ref_tracker_dir_exit() to alloc_netdev_mqs()

ThangNN99 (1):
      Bluetooth: hci_core: Fix queuing tx_work after workqueue is drained

Theodor Arsenij Larionov-Trichkine (1):
      netfilter: nft_fib: reject fib expression on the netdev egress hook

Theodore Ts'o (1):
      ext4: convert some BUG_ON's in mballoc to use WARN_RATELIMITED instead

Thomas Richter (1):
      s390/cpum_sf: move functions from header file to source file

Thomas Weißschuh (1):
      HID: core: remove #ifdef CONFIG_PM from hid_driver

Thomas Zimmermann (7):
      drm/sysfb: simpledrm: Improve stride validation
      fbdev: Wrap user-invoked calls to fb_set_var() in helper
      fbdev: Don't re-validate info->state in fb_ops implementations
      fbdev: Validate info->screen_{base, buffer} in fb_ops implementations
      fbdev: Add initializer macros for struct fb_ops
      fbdev/ssd1307fb: Generate deferred I/O ops
      fbdev: Use /* */ comment in initializer macro

Thorsten Blum (1):
      net: ipconfig: Remove outdated comment and indent code block

Tianchu Chen (2):
      wifi: cw1200: fix TX padding OOB read leaking heap data to device
      nvmet-auth: validate reply message payload bounds against transfer length

Tianyang Zhang (1):
      LoongArch: Fix panic caused by NULL-PMD in huge_pte_offset()

Tibor Harcsa (1):
      Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table

Timur Kristóf (4):
      drm/amd/pm/si: Check AMD_IS_MOBILITY flag for PPSMC_SYSTEMFLAG_GPIO_DC
      drm/amd/pm/si: Fix updating clock limits on AC/DC
      drm/amd/display: Mark DCE 6.4 as not APU
      drm/amdgpu/sdma3: Work around POLL_REGMEM / FENCE hang

Tomas Winkler (1):
      mtd: use refcount to prevent corruption

Tomer Pomeranc (2):
      binder: fix is_failure flag for superseded transaction cleanup
      binder: fix leaked fd fixups on TF_UPDATE_TXN supersede

Tomer Tayar (1):
      habanalabs: fix dma-buf release handling if dma_buf_fd() fails

Tony Battersby (1):
      scsi: qla2xxx: Clear cmds after chip reset

Tristan Madani (2):
      nvme: add missing SRCU grace period in error path
      ice: fix metadata_dst refcount handling on representor teardown

Trond Myklebust (1):
      pNFS: Fix a deadlock when returning a delegation during open()

Tvrtko Ursulin (2):
      workqueue: Do not warn when cancelling WQ_MEM_RECLAIM work from !WQ_MEM_RECLAIM worker
      drm/amdgpu: Fix context pstate override handling

Tzung-Bi Shih (1):
      watchdog: rtd119x: Avoid division by zero

Uladzislau Rezki (Sony) (1):
      mm/vmalloc, mm/kasan: respect gfp mask in kasan_populate_vmalloc()

Umio Yasuno (1):
      drm/amd/pm: fix null pointer access

Usama Arif (3):
      blk-iocost: clear delay state when freeing policy data
      blk-iolatency: clear delay state when freeing policy data
      mm/huge_memory: transfer the pmd dirty bit to the folio on zap

Uwe Kleine-König (15):
      Bluetooth: btqcomsmd: Convert to platform remove callback returning void
      power: supply: rt9455: Convert to i2c's .probe_new()
      power: supply: max17040: Convert to i2c's .probe_new()
      wifi: wlcore: Convert to platform remove callback returning void
      serial: imx: Convert to platform remove callback returning void
      usb: gadget: at91_udc: Convert to platform remove callback returning void
      spi: hisi-kunpeng: Convert to platform remove callback returning void
      spi: mpc52xx: Convert to platform remove callback returning void
      spi: rspi: Convert to platform remove callback returning void
      spi: fsl-spi: Convert to platform remove callback returning void
      gpio: mvebu: Use IS_REACHABLE instead of IS_ENABLED for CONFIG_PWM
      soc/xilinx: zynqmp_power: Convert to platform remove callback returning void
      mfd: sm501: Convert to platform remove callback returning void
      power: supply: lp8788-charger: Convert to platform remove callback returning void
      power: supply: charger-manager: Convert to platform remove callback returning void

Val Packett (1):
      remoteproc: qcom_wcnss: Fix handling the lack of PD regulators in v3

Varun R Mallya (1):
      bpf: Reject sleepable kprobe_multi programs at attach time

Vasant Hegde (1):
      iommu/amd: Fix clone_alias() to use the original device's devid

Venkata Prasad Potturu (3):
      ASoC: amd: acp: Add setbias level for rt5682s codec in machine driver
      ASoC: amd: acp: Refactor dai format implementation
      ASoC: amd: acp: Refactor i2s clocks programming sequence

Viacheslav Dubeyko (1):
      ceph: fix BUG_ON in __ceph_build_xattrs_blob() due to stale blob size

Vicki Pfau (6):
      HID: hid-steam: Make client_opened a counter
      HID: steam: Fully unregister controller when hidraw is opened
      HID: steam: Rearrange teardown sequence
      HID: steam: Refactor registration
      HID: steam: Clean up locking
      HID: steam: Reject short reads

Victor Nogueira (3):
      net: sched: Move drop_reason to struct tc_skb_cb
      net: sched: Add initial TC error skb drop reasons
      net/sched: act_ife: Only operate on Ethernet frames

Vidhu Sarwal (1):
      iio: light: ltrf216a: fix runtime PM reference leak in error path

Viken Dadhaniya (3):
      tty: serial: qcom_geni_serial: Keep console RX functional after deep idle
      soc: qcom: geni-se: Correct QUP Core ICC vote constants
      spi: spi-qcom-qspi: Fix incomplete error handling in runtime PM

Ville Syrjälä (1):
      drm/i915/dsi: Don't do DSC horizontal timing adjustments in command mode

Viresh Kumar (1):
      virtio-mmio: Remove virtqueue list from mmio device

Vishal Badole (1):
      EDAC/amd64: Mask UMC chip select to the four implemented selects

Vivek BalachandharTN (1):
      staging: rtl8723bs: fix spacing around operators

Vladimir Oltean (1):
      net: dsa: properly keep track of conduit reference

Vladimir Riabchun (1):
      scsi: qla2xxx: Completely fix fcport double free

Vladimir Yakovlev (1):
      spi: spi-dw-dma: fix print error log when wait finish transaction

Vladyslav Ivashchenko (1):
      iio: adc: axp288: Add TS bias override for Haier HV103H

Waiman Long (4):
      mm/kmemleak: simplify kmemleak_cond_resched() usage
      mm/kmemleak: fix UAF bug in kmemleak_scan()
      cgroup/cpuset: Make nr_deadline_tasks an atomic_t
      Drivers: hv: Avoid infinite retry loop in init_vp_index()

Wander Lairson Costa (2):
      sched/deadline: Fix task_struct reference leak
      sched/deadline: Fix warning in migrate_enable for boosted tasks

Wei Fang (2):
      net: enetc: VFs do not support HWTSTAMP_TX_ONESTEP_SYNC
      net: tap: fix wrong transport_header when sending VLAN-tagged frame

Wei Zhang (1):
      wifi: ath11k: cancel SSR work items during PCI shutdown

Weili Qian (1):
      crypto: hisilicon/qm - request reserved interrupt for virtual function

Weimin Xiong (1):
      iommu/msm: Unwind probe state on registration failure

Weiming Shi (7):
      nvmet-auth: fix out-of-bounds write in nvmet_auth_challenge()
      net: team: fix NULL pointer dereference in team_xmit during mode change
      net: team: stop reusing skb after queue override
      tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR
      tipc: serialize udp bearer replicast list updates
      btrfs: lzo: reject compressed segment that overflows the compressed input
      asymmetric_keys: reject trust keys without IDs

Wen Gu (1):
      net/smc: initialize close_work early to avoid warning

Wenjie Qi (3):
      f2fs: limit recovery filename logging to stored length
      f2fs: avoid NULL checkpoint thread access in sysfs
      f2fs: validate MOVE_RANGE destination size

Wentao Liang (7):
      of/irq: Fix remaining refcount leaks in of_irq_init()
      kgdboc: Fix tty driver reference leak in configure_kgdboc()
      serial: vt8500: Fix clock reference leak in vt8500_serial_probe()
      wifi: wlcore: Fix runtime PM leak in wlcore_remove()
      btrfs: scrub: fix local_root reference leak in scrub_print_warning_inode()
      drm/vc4: Fix firmware reference leak in vc4_drm_bind()
      i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()

Werner Kasselman (1):
      drm/radeon: fix integer overflow in radeon_align_pitch()

Werner Sembach (1):
      PCI: Avoid putting some root ports into D3 on TUXEDO Sirius Gen1

Will Deacon (1):
      arm64: ptrace: Keep 'orig_x0' in-sync with x0 on syscall entry

Willem de Bruijn (1):
      tcp: prevent collapsing skbs across boundary in rtx queue

William Liu (1):
      net/sched: Fix backlog accounting in qdisc_dequeue_internal

William Palacek (1):
      drm/amdkfd: Add bounds check for CRAT subtype length

Willian Oliveira (1):
      drm/amdgpu/gfx6: fix firmware leak on teardown

Xiang Chen (1):
      scsi: hisi_sas: Add function complete_v3_hw()

Xiang Mei (4):
      ALSA: usb-audio: Clamp implicit feedback packet count to URB capacity
      vlan: require the MAC header to be present in __vlan_insert_inner_tag()
      ALSA: line6: reject oversized playback packets
      ALSA: ua101: reject mismatched capture/playback packet sizes

Xianting Tian (1):
      vhost: correct misleading printing information

Xiao Ni (1):
      md/raid10: wait barrier before returning discard request with REQ_NOWAIT

Xiaogang Chen (3):
      drm/amdkfd: Fix the case that vm range is hole at svm_migrate_copy_to_vram
      drm/amdkfd: Fix error path at svm_migrate_copy_to_ram
      drm/amdkfd: Let driver decide buffer size at AMDKFD_IOC_GET_DMABUF_INFO ioctl

Xiaolei Wang (3):
      net: stmmac: move the EST lock to struct stmmac_priv
      mm/kmemleak: use object_cache instead of kmemleak_initialized to check in set_track_prepare()
      pinctrl: freescale: Fix a memory out of bounds when num_configs is 1

Xin Long (5):
      sctp: disable BH before calling udp_tunnel_xmit_skb()
      sctp: validate embedded INIT chunk and address list lengths in cookie
      sctp: fix addr_wq_timer race in sctp_free_addr_wq()
      sctp: add INIT verification after cookie unpacking
      net: sched: refine software bypass handling in tc_run

XingWang Xiang (1):
      genetlink: pin family module during policy dump

Xingui Yang (4):
      scsi: hisi_sas: Move slot variable definition in hisi_sas_abort_task()
      scsi: hisi_sas: Add SATA_DISK_ERR bit handling for v3 hw
      scsi: hisi_sas: Fix NULL pointer exception during user_scan()
      scsi: libsas: Fix SMP IO deadlock during HA resume

Xingwang Xiang (1):
      bpf, skmsg: fix verdict sk_data_ready racing with ktls rx

Xinqi Zhang (1):
      firmware: arm_scmi: Fix slab-use-after-free in scmi_bus_notifier()

Xiong Weimin (1):
      virtio_mmio: disable IRQ wake before free_irq

Xiubo Li (1):
      ceph: fix UAF in check_new_map() on session freed during unlock

Xixin Liu (1):
      perf: RISC-V: store available counter mask as bitmap

Xu Rao (3):
      Bluetooth: btqcomsmd: destroy RPMsg endpoints before freeing hci_dev
      nvme-fabrics: fix DHCHAP secret leak on parse failure
      usb: gadget: f_printer: take kref only for successful open

Xu Yang (2):
      usb: typec: tcpm: fix debug accessory mode detection for sink ports
      filemap: add helper mapping_max_folio_size()

Xuanqiang Luo (2):
      net/sched: act_api: release all action references on NEWACTION failure
      net: ravb: serialize PTP clock teardown

Xue Lei (1):
      mtd: fix double free and WARN_ON in add_mtd_device() error paths

Xueqin Luo (1):
      power: supply: ds2780: Fix ds2780_get_capacity() returning raw value

Yan Zhai (1):
      bnxt: properly flush XDP redirect lists

Yan Zhen (1):
      sunrpc: xprtrdma: Use ERR_CAST() to return

Yang Erkun (2):
      nfsd: release svc_expkey/svc_export with rcu_work
      nfs: use nfsi->rwsem to protect traversal of the file lock list

Yang Xiuwei (1):
      scsi: sd: Fix special_vec mempool leak when scsi_alloc_sgtables() fails

Yang Yingliang (4):
      spi: bcm63xx: switch to use modern name
      spi: hisi-kunpeng: switch to use modern name
      spi: mpc52xx: switch to use modern name
      spi: fsl-spi: switch to use modern name

Yangtao Li (3):
      f2fs: fix to set flush_merge opt and show noflush_merge
      f2fs: introduce f2fs_is_readonly() for readability
      f2fs: convert to use sysfs_emit

Yao Kai (1):
      rcu: Fix rcu_read_unlock() deadloop due to softirq

Ye Weihua (1):
      trace/fgraph: Fix the warning caused by missing unregister notifier

Yehyeong Lee (4):
      scsi: xen/scsifront: Check for a NULL shadow entry on a backend response
      scsi: libiscsi: Reject a negative task index from parse_pdu_itt
      scsi: libiscsi: Validate the ITT reflected in a Reject PDU
      scsi: libiscsi: Validate the task named by a management response

Yeoreum Yun (2):
      coresight: holding cscfg_csdev_lock while removing cscfg from csdev
      coresight: etm4x: missing cscfg_csdev_disable_active_config() in perf enable

Yi Yang (1):
      vc_screen: reload vc pointer before if (ret) in vcs_write() to avoid UAF

Yibo Tan (2):
      hwmon: (pwm-fan) Stop RPM timer before freeing tach data
      mmc: mtk-sd: Cancel request timeout work on remove

Yihang Li (7):
      scsi: hisi_sas: Directly call register snapshot instead of using workqueue
      scsi: hisi_sas: Allocate DFX memory during dump trigger
      scsi: hisi_sas: Create all dump files during debugfs initialization
      scsi: hisi_sas: Add slave_destroy interface for v3 hw
      scsi: hisi_sas: Check before using pointer variables
      scsi: hisi_sas: Fix a deadlock issue related to automatic dump
      scsi: hisi_sas: Remove redundant checks for automatic debugfs dump

Yinjie Yao (8):
      drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v3.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v2.5 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v2.0 ring
      drm/amdgpu/vcn: set no_user_fence for VCN v4.0 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v3.0 enc/dec rings
      drm/amdgpu/vcn: set no_user_fence for VCN v2.5 enc/dec rings
      drm/amdgpu/vcn: set no_user_fence for VCN v2.0 enc/dec rings

Yishai Hadas (5):
      vfio/mlx5: Fix an unwind issue in mlx5vf_add_migration_pages()
      RDMA/mlx5: Fix a race for an ODP MR which leads to CQE with error
      RDMA/mlx5: Fix a WARN during dereg_mr for DM type
      RDMA/mlx5: Fix the recovery flow of the UMR QP
      RDMA/mlx5: Fix implicit ODP hang on parent deregistration

Yiyang Chen (1):
      bpf: Guard conntrack opts error writes

Yong Wang (1):
      tcp: clamp route advmss to TCP_MIN_MSS

Yonghong Song (2):
      bpf: Fix kmemleak warning for percpu hashmap
      bpf, x86: Fix trampoline stack size for 128-bit arguments

Yongjian Sun (1):
      ext4: fix e4b bitmap inconsistency reports

Yongpeng Yang (4):
      f2fs: fix data loss caused by incorrect use of nat_entry flag
      f2fs: fix fsck inconsistency caused by incorrect nat_entry flag usage
      f2fs: fix fsck inconsistency caused by FGGC of node block
      f2fs: fix node_cnt race between extent node destroy and writeback

Yongqiang Liu (1):
      ARM: 9359/1: flush: check if the folio is reserved for no-mapping addresses

Yongqiang Sun (2):
      drm/amdkfd: Fix infinite loop parsing CRAT with zero subtype length
      drm/amdkfd: fix SMI event cross-process information leak

Yosry Ahmed (3):
      KVM: nSVM: Triple fault if restore host CR3 fails on nested #VMEXIT
      KVM: nSVM: Always use NextRIP as vmcb02's NextRIP after first L2 VMRUN
      KVM: nSVM: Avoid clearing VMCB_LBR in vmcb12

Yu Kuai (3):
      block/rq_qos: protect rq_qos apis with a new lock
      blk-cgroup: dropping parent refcount after pd_free_fn() is done
      blk-cgroup: delay freeing policy data after rcu grace period

Yuchao Zhang (2):
      USB: cdc-acm: skip URB restart in port_shutdown if disconnected
      usb: gadget: f_fs: Fix NULL pointer dereference in FUNCTIONFS_ENDPOINT_DESC

Yucheng Lu (1):
      net/sched: sch_netem: fix out-of-bounds access in packet corruption

Yuezhang Mo (3):
      exfat: fix out-of-bounds access of directory entries
      exfat: remove unnecessary arguments from exfat_find_dir_entry()
      exfat: add cluster chain loop check for dir

Yufan Chen (1):
      ocfs2/heartbeat: fix slot mapping rollback leaks on error paths

Yuho Choi (3):
      net/liquidio: drop cached VF pci_dev LUT
      media: atomisp: gc2235: fix UAF and memory leak
      dmaengine: idxd: fix double free of wq, engine, and group structs

Yun Zhou (4):
      gpio: mvebu: fix NULL pointer dereference in suspend/resume
      ext4: validate donor file superblock early in EXT4_IOC_MOVE_EXT
      ext4: fix circular lock dependency in ext4_ext_migrate
      xfs: don't hold buffer locks across sync transaction commit in xfs_sync_sb_buf

Yunfei Dong (1):
      media: mediatek: vcodec: Fix H264 stateless decoder smatch warning

Yunseong Kim (1):
      ksmbd: fix slab-out-of-bounds read in ksmbd_alloc_user()

Yuqi Xu (5):
      net: ipconfig: bound DHCP option construction
      wifi: mac80211: minstrel_ht: validate fixed rate index
      wifi: mac80211: handle empty FILS association request payload
      tipc: destroy topsrv workqueues before closing connections
      wifi: cfg80211: reject duplicate wiphy cipher suite entries

Yuxiang Yang (1):
      tcp: challenge ACK for non-exact RST in SYN-RECEIVED

Yuxiao Wang (1):
      nitro_enclaves: fix use-after-free on SLOT_ALLOC failure

Zack Rusin (2):
      drm/vmwgfx: validate pitch coming from userspace
      drm/vmwgfx: reject DX_BIND_QUERY without a DX context

Ze Tan (1):
      smb/server: fix session leak in ksmbd_session_register()

Zhan Xusheng (1):
      fs/ntfs3: fix integer overflow in MFT cluster validation

Zhang Cen (1):
      ocfs2: validate fast symlink target during inode read

Zhang Jie (1):
      iio: proximity: sx9324: Correct proximity channel resolution

Zhang Yi (2):
      ext4: drop extent cache when splitting extent fails
      ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before submitting I/O

ZhangGuoDong (2):
      pnfs/blocklayout: Fix device leaks on parse failure
      smb/server: fix null-ptr-deref in ksmbd_ipc_tree_connect_request()

Zhansong Gao (1):
      NFSv4: Fix incorrect argument passed to nfs4_delete_lease() in nfs4_add_lease()

Zhao Dongdong (1):
      USB: serial: option: add support for SIMCom SIM8260C

Zhao Li (9):
      wifi: cfg80211: preserve hidden-group beacon IE ownership
      wifi: mac80211: drain PS delivery work during station teardown
      wifi: mac80211: release mesh path quota on failed additions
      wifi: mac80211: shut down RX BA session timer on teardown
      wifi: mac80211: keep fallback association elements alive
      wifi: mac80211: account proxy paths against the mesh path limit
      wifi: ieee80211: validate MLE common info length
      wifi: cfg80211: stop PMSR before P2P and NAN teardown
      wifi: nl80211: clean up color-change beacon data on errors

Zhaoyang Huang (2):
      mm: use stack_depot for recording kmemleak's backtrace
      mm: use stack_depot_early_init for kmemleak

ZhengYuan Huang (2):
      ocfs2: validate DIO orphan slot during inode read
      ocfs2: validate orphan slot during inode read

Zhengchuan Liang (1):
      perf: Require kernel access for text poke events

Zhiguo Niu (1):
      f2fs: use new ioprio Macro to get ckpt thread ioprio level

Zhiling Zou (7):
      net: bridge: use option bits for CFM/MRP frame handlers
      ipvs: bound LBLCR and LBLC cache growth
      wifi: mac80211: keep paired old chanctx alive
      wifi: mac80211: count only matching reservations in reserved switch
      mm/page_table_check: skip special zero mappings
      ip: orphan prefetched skbs before multicast forwarding
      ipv6: flowlabel: cap duplicate leases per socket

Zhipeng Lu (1):
      SUNRPC: fix a memleak in gss_import_v2_context

Zhu Yanjun (1):
      RDMA/rxe: Fix null deref on srq->rq.queue after resize failure

Zicheng Qu (1):
      drm/amd/display: Fix null check for pipe_ctx->plane_state in dcn20_program_pipe

Zide Chen (1):
      perf/x86/intel/uncore: Fix die ID init and look up bugs

Zihan Xi (6):
      ipmr: account multicast table and route memory
      smb: client: fix create context out-of-bounds reads
      smb: client: close handle after create-context parsing failure
      smb: client: close completed creates on compound wait errors
      net: l2tp: do not propagate multicast notification errors
      ipv4: avoid divide by zero in fib_rebalance

Zijian Zhang (1):
      bpf: Add sk_is_inet and IS_ICSK check in tls_sw_has_ctx_tx/rx

Zilin Guan (2):
      of: unittest: Fix memory leak in unittest_data_add()
      wifi: mt76: Fix memory leak after mt76_connac_mcu_alloc_sta_req()

Zimeng Li (1):
      ASoC: qcom: lpass-cpu: use DAI table index for playback constraints

Zixuan Chai (1):
      net: bridge: avoid recursive multicast port cleanup

Ziyan Xu (1):
      ksmbd: fix refcount leak causing resource not released

Zizhi Wo (2):
      vt: skip screen update for DEC alignment test on backgroup consoles
      null_blk: free zones array on device power-off

Zqiang (2):
      kasan: fix lockdep report invalid wait context
      rcu-tasks: Fix access non-existent percpu rtpcp variable in rcu_tasks_need_gpcb()

wenglianfa (1):
      RDMA/hns: Fix double destruction of rsv_qp

yuan.gao (1):
      mm/slub: Avoid list corruption when removing a slab from the full list

성병찬 (1):
      KEYS: Fix add_key() race with keyring restriction

