Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571957;
	b=aml00ppHGwkTeHu9JxjVSActYOLl2w0Qphj5be8QisaB/+OhHuh3YuGrn76mGJKvsY3h
	 4D074QYKitzwjyuQeMihqp3jSNKxzK9MYAVRhJ0usk1Z7UBG0Ygu5FXLatGYYXtxHyE7D
	 +DQyNOHSFNEP+6iB9ssuTp3W2V/6CM6TEt1PnsQ9yPKSldQKuWR+CvrmC4lIodnAWb8u8
	 itl58Bke4/c1n/0hEc1kn9HHVwGuaThXjGqKuFxzAaSifsejZems7dM70DpJxiwQMoFFJ
	 AcAyZQuzvJzYbjhIbDURruf3wWp27fc1SDoh/sv9nMS+KcH4YR/9aGZdGND+u6QS9xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571957;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xxxk3hcXfFbrMUlr9NOZk9V9nKJXWatRXg556Xf/ECE=;
	b=yUvzuLcSs8heU1O2LlHLsyNbt9cVpbX5TeNd0PpfTQubbPwCjeuDLkCvw32VeASDV3AK
	 NYQMvH12DahL8ib6uO4n6Tz8Isrsb7eques7h9JWEQD6gUit5ATdcr3cpP62IaxYlhdsN
	 HMWLNPHZ1qRx9j7fjTkgmKvOYgKtY5FlnEOjGuMuA+c8cq55nUS5N1EJ4MRRwVxJUaFb1
	 wjegereGfuzCbpamh//3wCJyH+oO0Ggbh9wlY/rxRgdZKhUMduaovtu5WSZQzVCWM+vOG
	 6rEqC8L3y7+5CRmvy3Ix2+OnH2h4gw/pn+DnsSFnSnYLdcu7fWnNJUkw1x8zdFkvRPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bFFpk0NT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E5606A321;
	Wed, 21 Oct 2026 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bFFpk0NT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D691E1F000C9;
	Wed, 21 Oct 2026 08:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792571956;
	bh=xxxk3hcXfFbrMUlr9NOZk9V9nKJXWatRXg556Xf/ECE=;
	h=From:To:Cc:Subject:Date;
	b=bFFpk0NT4QjDIu41DfcJ4YJoJNSB/+EFN4zRXsKchy+rah2FSOh/tIM7repCutbyx
	 gOgWEknZGMzzyyZIq7KsXA+L3KPsmLU6ZQXmoPRFi7wUvO1WmWLhsFRGxFTtJrePiA
	 pzC/dAdRsiwwx1CGS+i6dET9+NsJpO21/X4u8l3U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.114
Date: Wed, 21 Oct 2026 10:38:07 +0200
Message-ID: <2026102108-stoning-enunciate-650c@gregkh>
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

I'm announcing the release of the 6.12.114 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/RCU/whatisRCU.rst                                                |   10 
 Documentation/admin-guide/device-mapper/dm-ima.rst                             |    7 
 Documentation/admin-guide/device-mapper/dm-integrity.rst                       |   13 
 Documentation/core-api/refcount-vs-atomic.rst                                  |   37 
 Documentation/networking/af_xdp.rst                                            |   54 
 Documentation/networking/net_cachelines/net_device.rst                         |    2 
 Documentation/networking/rxrpc.rst                                             |   11 
 Documentation/networking/switchdev.rst                                         |    2 
 Makefile                                                                       |   29 
 arch/arm/mach-exynos/mcpm-exynos.c                                             |   12 
 arch/arm/mach-exynos/suspend.c                                                 |   48 
 arch/arm/mach-pxa/generic.h                                                    |    6 
 arch/arm/mach-pxa/irq.c                                                        |   10 
 arch/arm/mach-pxa/mfp-pxa2xx.c                                                 |   10 
 arch/arm/mach-pxa/mfp-pxa3xx.c                                                 |   10 
 arch/arm/mach-pxa/pxa25x.c                                                     |    4 
 arch/arm/mach-pxa/pxa27x.c                                                     |    4 
 arch/arm/mach-pxa/pxa3xx.c                                                     |    4 
 arch/arm/mach-pxa/smemc.c                                                      |   12 
 arch/arm/mach-s3c/irq-pm-s3c64xx.c                                             |   12 
 arch/arm/mach-s5pv210/pm.c                                                     |   10 
 arch/arm/mach-versatile/integrator_ap.c                                        |   12 
 arch/arm/mm/cache-b15-rac.c                                                    |   12 
 arch/arm64/kernel/ptrace.c                                                     |   50 
 arch/arm64/kvm/at.c                                                            |    3 
 arch/arm64/kvm/vgic/vgic-v3.c                                                  |   12 
 arch/arm64/kvm/vgic/vgic.c                                                     |    9 
 arch/loongarch/kernel/machine_kexec.c                                          |    5 
 arch/loongarch/kernel/smp.c                                                    |   12 
 arch/loongarch/net/bpf_jit.c                                                   |   20 
 arch/mips/alchemy/common/dbdma.c                                               |   12 
 arch/mips/alchemy/common/irq.c                                                 |   24 
 arch/mips/alchemy/common/usb.c                                                 |   12 
 arch/mips/pci/pci-alchemy.c                                                    |   16 
 arch/powerpc/include/asm/book3s/64/pgtable.h                                   |   15 
 arch/powerpc/include/asm/xive.h                                                |    4 
 arch/powerpc/mm/book3s64/pgtable.c                                             |   13 
 arch/powerpc/mm/pgtable-frag.c                                                 |    1 
 arch/powerpc/platforms/cell/spu_base.c                                         |   10 
 arch/powerpc/platforms/powermac/pic.c                                          |   12 
 arch/powerpc/platforms/powernv/smp.c                                           |    8 
 arch/powerpc/platforms/pseries/smp.c                                           |    8 
 arch/powerpc/sysdev/fsl_lbc.c                                                  |   12 
 arch/powerpc/sysdev/fsl_pci.c                                                  |   12 
 arch/powerpc/sysdev/ipic.c                                                     |   12 
 arch/powerpc/sysdev/mpic.c                                                     |   14 
 arch/powerpc/sysdev/mpic_timer.c                                               |   10 
 arch/powerpc/sysdev/xive/common.c                                              |   10 
 arch/riscv/include/asm/processor.h                                             |    2 
 arch/riscv/include/asm/switch_to.h                                             |    8 
 arch/riscv/kernel/Makefile                                                     |   15 
 arch/riscv/kernel/asm-offsets.c                                                |    5 
 arch/riscv/kernel/cpufeature.c                                                 |    9 
 arch/riscv/kernel/entry.S                                                      |    9 
 arch/riscv/kernel/patch.c                                                      |   21 
 arch/riscv/kernel/suspend.c                                                    |    4 
 arch/riscv/kvm/main.c                                                          |    4 
 arch/riscv/kvm/vcpu_vector.c                                                   |    5 
 arch/riscv/kvm/vmid.c                                                          |    2 
 arch/s390/include/asm/gmap.h                                                   |    3 
 arch/s390/include/asm/kvm_host.h                                               |    3 
 arch/s390/include/asm/nmi.h                                                    |    3 
 arch/s390/include/asm/pci.h                                                    |    2 
 arch/s390/include/asm/pci_insn.h                                               |   10 
 arch/s390/include/asm/processor.h                                              |    5 
 arch/s390/include/asm/ptrace.h                                                 |    2 
 arch/s390/include/asm/uv.h                                                     |    6 
 arch/s390/kernel/asm-offsets.c                                                 |    2 
 arch/s390/kernel/entry.S                                                       |   44 
 arch/s390/kernel/nmi.c                                                         |    5 
 arch/s390/kernel/traps.c                                                       |   24 
 arch/s390/kernel/uv.c                                                          |  363 +--
 arch/s390/kvm/Makefile                                                         |    2 
 arch/s390/kvm/gaccess.c                                                        |   42 
 arch/s390/kvm/gmap.c                                                           |  121 +
 arch/s390/kvm/gmap.h                                                           |   19 
 arch/s390/kvm/intercept.c                                                      |    7 
 arch/s390/kvm/interrupt.c                                                      |   24 
 arch/s390/kvm/kvm-s390.c                                                       |  222 +-
 arch/s390/kvm/kvm-s390.h                                                       |   14 
 arch/s390/kvm/pci.c                                                            |   17 
 arch/s390/kvm/pv.c                                                             |   21 
 arch/s390/kvm/vsie.c                                                           |   15 
 arch/s390/mm/fault.c                                                           |  191 -
 arch/s390/mm/gmap.c                                                            |   45 
 arch/s390/pci/pci.c                                                            |   35 
 arch/s390/pci/pci_sysfs.c                                                      |   11 
 arch/sh/mm/pmb.c                                                               |   10 
 arch/x86/crypto/Kconfig                                                        |    4 
 arch/x86/crypto/aegis128-aesni-asm.S                                           |  110 
 arch/x86/crypto/aegis128-aesni-glue.c                                          |  156 -
 arch/x86/events/amd/ibs.c                                                      |   12 
 arch/x86/events/intel/core.c                                                   |   32 
 arch/x86/events/intel/ds.c                                                     |    8 
 arch/x86/events/intel/uncore.c                                                 |   46 
 arch/x86/events/perf_event.h                                                   |    3 
 arch/x86/hyperv/hv_init.c                                                      |   12 
 arch/x86/kernel/amd_gart_64.c                                                  |   10 
 arch/x86/kernel/apic/apic.c                                                    |   12 
 arch/x86/kernel/apic/io_apic.c                                                 |   17 
 arch/x86/kernel/cpu/aperfmperf.c                                               |   20 
 arch/x86/kernel/cpu/intel_epb.c                                                |   16 
 arch/x86/kernel/cpu/mce/core.c                                                 |   14 
 arch/x86/kernel/cpu/microcode/core.c                                           |   15 
 arch/x86/kernel/cpu/mtrr/legacy.c                                              |   12 
 arch/x86/kernel/cpu/resctrl/rdtgroup.c                                         |   19 
 arch/x86/kernel/cpu/umwait.c                                                   |   10 
 arch/x86/kernel/i8237.c                                                        |   10 
 arch/x86/kernel/i8259.c                                                        |   14 
 arch/x86/kernel/kvm.c                                                          |   12 
 arch/x86/kvm/cpuid.c                                                           |    2 
 arch/x86/kvm/cpuid.h                                                           |   16 
 arch/x86/kvm/lapic.c                                                           |   61 
 arch/x86/kvm/lapic.h                                                           |    4 
 arch/x86/kvm/mmu.h                                                             |    2 
 arch/x86/kvm/mmu/mmu.c                                                         |    4 
 arch/x86/kvm/regs.c                                                            |    6 
 arch/x86/kvm/svm/nested.c                                                      |   64 
 arch/x86/kvm/svm/sev.c                                                         |   42 
 arch/x86/kvm/svm/svm.c                                                         |   70 
 arch/x86/kvm/svm/svm.h                                                         |    4 
 arch/x86/kvm/vmx/nested.c                                                      |   11 
 arch/x86/kvm/vmx/vmx.c                                                         |   16 
 arch/x86/kvm/x86.c                                                             |   60 
 arch/x86/kvm/x86.h                                                             |    5 
 block/bfq-cgroup.c                                                             |    9 
 block/bio-integrity.c                                                          |    6 
 block/blk-cgroup.c                                                             |    5 
 block/blk-cgroup.h                                                             |    2 
 block/blk-iocost.c                                                             |   21 
 block/blk-iolatency.c                                                          |   19 
 block/blk-throttle.c                                                           |   13 
 drivers/accel/ivpu/ivpu_drv.c                                                  |    2 
 drivers/accel/ivpu/ivpu_gem.c                                                  |  111 -
 drivers/accel/ivpu/ivpu_gem.h                                                  |    3 
 drivers/accel/ivpu/ivpu_job.c                                                  |    2 
 drivers/accel/qaic/mhi_controller.c                                            |   24 
 drivers/accel/qaic/qaic.h                                                      |   13 
 drivers/accel/qaic/qaic_drv.c                                                  |   76 
 drivers/accel/qaic/qaic_timesync.c                                             |    2 
 drivers/acpi/acpi_platform.c                                                   |   16 
 drivers/acpi/bus.c                                                             |   54 
 drivers/acpi/device_pm.c                                                       |    4 
 drivers/acpi/pci_link.c                                                        |   10 
 drivers/acpi/sleep.c                                                           |   12 
 drivers/ata/libata-core.c                                                      |    7 
 drivers/ata/libata-scsi.c                                                      |   10 
 drivers/base/core.c                                                            |   74 
 drivers/base/firmware_loader/main.c                                            |   12 
 drivers/base/power/main.c                                                      |   67 
 drivers/base/power/runtime.c                                                   |   61 
 drivers/base/syscore.c                                                         |   82 
 drivers/block/ublk_drv.c                                                       |   37 
 drivers/bus/mhi/host/pci_generic.c                                             |   20 
 drivers/bus/mvebu-mbus.c                                                       |   16 
 drivers/char/ipmi/ipmi_ssif.c                                                  |   20 
 drivers/clk/at91/pmc.c                                                         |   12 
 drivers/clk/imx/clk-vf610.c                                                    |   12 
 drivers/clk/ingenic/jz4725b-cgu.c                                              |    2 
 drivers/clk/ingenic/jz4740-cgu.c                                               |    2 
 drivers/clk/ingenic/jz4755-cgu.c                                               |    2 
 drivers/clk/ingenic/jz4760-cgu.c                                               |    2 
 drivers/clk/ingenic/jz4770-cgu.c                                               |    2 
 drivers/clk/ingenic/jz4780-cgu.c                                               |    2 
 drivers/clk/ingenic/pm.c                                                       |   14 
 drivers/clk/ingenic/pm.h                                                       |    2 
 drivers/clk/ingenic/tcu.c                                                      |   12 
 drivers/clk/ingenic/x1000-cgu.c                                                |    2 
 drivers/clk/ingenic/x1830-cgu.c                                                |    2 
 drivers/clk/mediatek/clk-pllfh.c                                               |   98 
 drivers/clk/mvebu/common.c                                                     |   12 
 drivers/clk/rockchip/clk-rk3288.c                                              |   12 
 drivers/clk/samsung/clk-s5pv210-audss.c                                        |   12 
 drivers/clk/samsung/clk.c                                                      |   12 
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c                                         |   64 
 drivers/clk/tegra/clk-tegra210.c                                               |   12 
 drivers/clk/thead/clk-th1520-ap.c                                              |   30 
 drivers/clocksource/samsung_pwm_timer.c                                        |   22 
 drivers/clocksource/timer-armada-370-xp.c                                      |   12 
 drivers/cpuidle/cpuidle-psci.c                                                 |   12 
 drivers/crypto/hisilicon/hpre/hpre_main.c                                      |   40 
 drivers/crypto/hisilicon/qm.c                                                  |   38 
 drivers/cxl/core/core.h                                                        |    2 
 drivers/cxl/core/mbox.c                                                        |   11 
 drivers/cxl/core/port.c                                                        |    7 
 drivers/cxl/core/ras.c                                                         |   10 
 drivers/cxl/core/region.c                                                      |   81 
 drivers/cxl/core/trace.h                                                       |   12 
 drivers/cxl/cxl.h                                                              |   22 
 drivers/dma/idxd/init.c                                                        |   36 
 drivers/dma/ti/k3-udma-glue.c                                                  |   15 
 drivers/dma/xilinx/xilinx_dma.c                                                |   14 
 drivers/dpll/dpll_core.c                                                       |   12 
 drivers/dpll/dpll_netlink.c                                                    |   68 
 drivers/edac/igen6_edac.c                                                      |  148 +
 drivers/firewire/ohci.c                                                        |    4 
 drivers/firmware/arm_ffa/driver.c                                              |   56 
 drivers/firmware/arm_scmi/bus.c                                                |   36 
 drivers/gpio/gpio-latch.c                                                      |    2 
 drivers/gpio/gpio-mxc.c                                                        |   12 
 drivers/gpio/gpio-pca953x.c                                                    |   18 
 drivers/gpio/gpio-pxa.c                                                        |   12 
 drivers/gpio/gpio-sa1100.c                                                     |   12 
 drivers/gpio/gpiolib.c                                                         |  134 -
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                                            |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                                     |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                                     |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c                                   |   25 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c                                       |   63 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                     |   52 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                                        |   23 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h                                        |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c                                        |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c                                        |   25 
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h                                        |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                                        |   32 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h                                        |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                        |   25 
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h                                    |  131 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                                         |   13 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                          |    2 
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h                                          |    3 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c                                          |    4 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                          |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c                                          |   17 
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                                        |   13 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                          |   20 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h                          |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c                                       |  195 -
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c                                |   11 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                                          |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                                       |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                         |   24 
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c                                    |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h                              |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c                          |   25 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c                         |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c                         |   10 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h                         |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c                          |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c                        |   10 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c                       |    7 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                       |    6 
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h                                   |    2 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c                        |   15 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c |   31 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c                        |   52 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h                        |    4 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c                         |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c                      |   13 
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c                 |    8 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                                      |   12 
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h                                  |   10 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c                           |   45 
 drivers/gpu/drm/etnaviv/etnaviv_sched.c                                        |   22 
 drivers/gpu/drm/exynos/exynos_drm_drv.h                                        |    1 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                                       |   14 
 drivers/gpu/drm/gud/gud_drv.c                                                  |    2 
 drivers/gpu/drm/i915/display/g4x_dp.c                                          |   15 
 drivers/gpu/drm/i915/display/i9xx_wm.c                                         |   15 
 drivers/gpu/drm/i915/display/intel_atomic_plane.c                              |    4 
 drivers/gpu/drm/i915/display/intel_bios.c                                      |    6 
 drivers/gpu/drm/i915/display/intel_cdclk.c                                     |    6 
 drivers/gpu/drm/i915/display/intel_crt.c                                       |  216 +
 drivers/gpu/drm/i915/display/intel_crt.h                                       |   10 
 drivers/gpu/drm/i915/display/intel_crtc.c                                      |   15 
 drivers/gpu/drm/i915/display/intel_crtc.h                                      |    3 
 drivers/gpu/drm/i915/display/intel_cx0_phy.c                                   |   76 
 drivers/gpu/drm/i915/display/intel_display.c                                   |   48 
 drivers/gpu/drm/i915/display/intel_display.h                                   |   17 
 drivers/gpu/drm/i915/display/intel_display_driver.c                            |   18 
 drivers/gpu/drm/i915/display/intel_display_irq.c                               |   20 
 drivers/gpu/drm/i915/display/intel_display_power.c                             |   73 
 drivers/gpu/drm/i915/display/intel_display_power_well.c                        |    6 
 drivers/gpu/drm/i915/display/intel_display_trace.h                             |   15 
 drivers/gpu/drm/i915/display/intel_dp.c                                        |    8 
 drivers/gpu/drm/i915/display/intel_dpll.c                                      |   12 
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c                                  |   90 
 drivers/gpu/drm/i915/display/intel_dsb.c                                       |    2 
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c                                   |    5 
 drivers/gpu/drm/i915/display/intel_dvo.c                                       |    8 
 drivers/gpu/drm/i915/display/intel_fbc.c                                       |    7 
 drivers/gpu/drm/i915/display/intel_fdi.c                                       |   52 
 drivers/gpu/drm/i915/display/intel_fifo_underrun.c                             |   15 
 drivers/gpu/drm/i915/display/intel_gmbus.c                                     |  290 +-
 drivers/gpu/drm/i915/display/intel_gmbus.h                                     |   15 
 drivers/gpu/drm/i915/display/intel_gmbus_regs.h                                |   16 
 drivers/gpu/drm/i915/display/intel_hdmi.c                                      |    8 
 drivers/gpu/drm/i915/display/intel_hotplug_irq.c                               |    6 
 drivers/gpu/drm/i915/display/intel_link_bw.c                                   |    3 
 drivers/gpu/drm/i915/display/intel_lvds.c                                      |    2 
 drivers/gpu/drm/i915/display/intel_modeset_setup.c                             |   12 
 drivers/gpu/drm/i915/display/intel_modeset_verify.c                            |   89 
 drivers/gpu/drm/i915/display/intel_pch_display.c                               |   56 
 drivers/gpu/drm/i915/display/intel_pps.c                                       |   26 
 drivers/gpu/drm/i915/display/intel_sdvo.c                                      |    9 
 drivers/gpu/drm/i915/display/intel_snps_phy.c                                  |   11 
 drivers/gpu/drm/i915/display/intel_sprite_uapi.c                               |    3 
 drivers/gpu/drm/i915/display/intel_vga.c                                       |   45 
 drivers/gpu/drm/i915/display/intel_vga.h                                       |   14 
 drivers/gpu/drm/i915/display/skl_watermark.c                                   |    7 
 drivers/gpu/drm/i915/display/vlv_dsi_pll.c                                     |    7 
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c                           |   19 
 drivers/gpu/drm/i915/gt/intel_rc6.c                                            |    2 
 drivers/gpu/drm/i915/i915_suspend.c                                            |    5 
 drivers/gpu/drm/i915/i915_utils.h                                              |   24 
 drivers/gpu/drm/imagination/pvr_queue.c                                        |   18 
 drivers/gpu/drm/lima/lima_sched.c                                              |   16 
 drivers/gpu/drm/mediatek/mtk_dsi.c                                             |   11 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                          |    5 
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c                                       |   24 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c                                       |   11 
 drivers/gpu/drm/msm/msm_gpu.c                                                  |   30 
 drivers/gpu/drm/msm/msm_ringbuffer.c                                           |   24 
 drivers/gpu/drm/msm/msm_ringbuffer.h                                           |    1 
 drivers/gpu/drm/nouveau/nouveau_sched.c                                        |   16 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c                                 |   29 
 drivers/gpu/drm/panfrost/panfrost_job.c                                        |   20 
 drivers/gpu/drm/panthor/panthor_mmu.c                                          |   25 
 drivers/gpu/drm/panthor/panthor_sched.c                                        |   77 
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c                                 |    8 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                                   |  182 -
 drivers/gpu/drm/scheduler/sched_main.c                                         |   50 
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c                                           |    2 
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                                            |   53 
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                                            |    2 
 drivers/gpu/drm/v3d/v3d_sched.c                                                |   65 
 drivers/gpu/drm/vc4/vc4_bo.c                                                   |    2 
 drivers/gpu/drm/vc4/vc4_drv.c                                                  |    9 
 drivers/gpu/drm/virtio/virtgpu_drv.h                                           |   25 
 drivers/gpu/drm/virtio/virtgpu_object.c                                        |    2 
 drivers/gpu/drm/virtio/virtgpu_plane.c                                         |    4 
 drivers/gpu/drm/virtio/virtgpu_prime.c                                         |   42 
 drivers/gpu/drm/virtio/virtgpu_vq.c                                            |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                                            |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                                            |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                                            |   30 
 drivers/gpu/drm/xe/xe_execlist.c                                               |   15 
 drivers/gpu/drm/xe/xe_gpu_scheduler.c                                          |   17 
 drivers/gpu/drm/xe/xe_guc.c                                                    |    8 
 drivers/gpu/drm/xe/xe_guc_ct.c                                                 |   41 
 drivers/gpu/drm/xe/xe_guc_ct.h                                                 |    1 
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h                                   |    5 
 drivers/gpu/drm/xe/xe_guc_submit.c                                             |    4 
 drivers/gpu/drm/xe/xe_vm.c                                                     |   31 
 drivers/gpu/drm/xe/xe_vm_types.h                                               |    3 
 drivers/hid/hid-core.c                                                         |   12 
 drivers/hid/hid-logitech-hidpp.c                                               |   23 
 drivers/hid/hid-steam.c                                                        |   33 
 drivers/hv/vmbus_drv.c                                                         |   29 
 drivers/hwmon/asus_rog_ryujin.c                                                |  135 -
 drivers/hwmon/lm90.c                                                           |   26 
 drivers/hwmon/pmbus/pmbus_core.c                                               |   82 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                             |   90 
 drivers/hwtracing/coresight/coresight-syscfg.c                                 |    2 
 drivers/hwtracing/coresight/coresight-tmc-core.c                               |    6 
 drivers/hwtracing/coresight/coresight-tmc-etf.c                                |   48 
 drivers/hwtracing/coresight/coresight-tmc-etr.c                                |   60 
 drivers/hwtracing/coresight/coresight-tmc.h                                    |    2 
 drivers/i3c/master.c                                                           |   39 
 drivers/i3c/master/mipi-i3c-hci/core.c                                         |    1 
 drivers/i3c/master/mipi-i3c-hci/dma.c                                          |   29 
 drivers/i3c/master/mipi-i3c-hci/hci.h                                          |    1 
 drivers/i3c/master/svc-i3c-master.c                                            |  108 
 drivers/infiniband/core/counters.c                                             |    9 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                       |   61 
 drivers/infiniband/hw/bnxt_re/ib_verbs.h                                       |    1 
 drivers/infiniband/hw/bnxt_re/qplib_sp.h                                       |    1 
 drivers/infiniband/hw/cxgb4/mem.c                                              |   46 
 drivers/infiniband/hw/efa/efa_com.c                                            |   28 
 drivers/infiniband/hw/irdma/hw.c                                               |    7 
 drivers/infiniband/hw/irdma/main.h                                             |    3 
 drivers/infiniband/hw/irdma/utils.c                                            |   12 
 drivers/infiniband/hw/irdma/verbs.c                                            |   22 
 drivers/infiniband/hw/mlx5/cq.c                                                |   15 
 drivers/infiniband/hw/mlx5/main.c                                              |   17 
 drivers/infiniband/hw/mlx5/mlx5_ib.h                                           |    1 
 drivers/infiniband/sw/rdmavt/vt.c                                              |    4 
 drivers/infiniband/sw/rxe/rxe.h                                                |   37 
 drivers/infiniband/sw/rxe/rxe_loc.h                                            |    1 
 drivers/infiniband/sw/rxe/rxe_mr.c                                             |  283 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h                                          |   47 
 drivers/iommu/amd/init.c                                                       |   45 
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c                                 |   60 
 drivers/iommu/intel/iommu.c                                                    |   20 
 drivers/iommu/intel/iommu.h                                                    |    2 
 drivers/iommu/intel/pasid.c                                                    |    9 
 drivers/iommu/io-pgfault.c                                                     |   24 
 drivers/iommu/iommufd/fault.c                                                  |    2 
 drivers/iommu/s390-iommu.c                                                     |   63 
 drivers/irqchip/exynos-combiner.c                                              |   14 
 drivers/irqchip/irq-armada-370-xp.c                                            |   12 
 drivers/irqchip/irq-bcm7038-l1.c                                               |   12 
 drivers/irqchip/irq-gic-v3-its.c                                               |   12 
 drivers/irqchip/irq-i8259.c                                                    |   12 
 drivers/irqchip/irq-imx-gpcv2.c                                                |   16 
 drivers/irqchip/irq-loongson-eiointc.c                                         |   12 
 drivers/irqchip/irq-loongson-htpic.c                                           |   10 
 drivers/irqchip/irq-loongson-htvec.c                                           |   12 
 drivers/irqchip/irq-loongson-pch-lpc.c                                         |   12 
 drivers/irqchip/irq-loongson-pch-pic.c                                         |   12 
 drivers/irqchip/irq-mchp-eic.c                                                 |   12 
 drivers/irqchip/irq-mst-intc.c                                                 |   12 
 drivers/irqchip/irq-mtk-cirq.c                                                 |   12 
 drivers/irqchip/irq-renesas-rzg2l.c                                            |   12 
 drivers/irqchip/irq-sa11x0.c                                                   |   12 
 drivers/irqchip/irq-sifive-plic.c                                              |   12 
 drivers/irqchip/irq-sun6i-r.c                                                  |   18 
 drivers/irqchip/irq-tegra.c                                                    |   12 
 drivers/irqchip/irq-vic.c                                                      |   12 
 drivers/leds/leds-aw200xx.c                                                    |    2 
 drivers/leds/trigger/ledtrig-cpu.c                                             |   14 
 drivers/macintosh/via-pmu.c                                                    |   12 
 drivers/md/dm-integrity.c                                                      |  156 +
 drivers/md/dm-table.c                                                          |   41 
 drivers/md/dm-verity-fec.c                                                     |  102 
 drivers/md/dm-zone.c                                                           |   34 
 drivers/md/dm.c                                                                |    6 
 drivers/md/dm.h                                                                |    5 
 drivers/md/md.c                                                                |  111 -
 drivers/md/md.h                                                                |    5 
 drivers/md/raid1.c                                                             |   32 
 drivers/md/raid10.c                                                            |   51 
 drivers/media/platform/chips-media/wave5/wave5-helper.c                        |   30 
 drivers/media/platform/chips-media/wave5/wave5-helper.h                        |    1 
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c                       |    5 
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c                       |    5 
 drivers/media/platform/chips-media/wave5/wave5-vpu.c                           |   97 
 drivers/media/platform/chips-media/wave5/wave5-vpuapi.h                        |    6 
 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c                  |   51 
 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-byteproc.c                 |  102 
 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-parallel.c                 |  110 
 drivers/media/platform/verisilicon/hantro.h                                    |    2 
 drivers/media/platform/verisilicon/hantro_drv.c                                |   42 
 drivers/media/platform/verisilicon/imx8m_vpu_hw.c                              |    8 
 drivers/media/v4l2-core/v4l2-mem2mem.c                                         |   23 
 drivers/mfd/intel-lpss.c                                                       |    2 
 drivers/mmc/host/vub300.c                                                      |   39 
 drivers/net/amt.c                                                              |    5 
 drivers/net/bonding/bond_main.c                                                |    2 
 drivers/net/ethernet/adi/adin1110.c                                            |    2 
 drivers/net/ethernet/airoha/airoha_eth.c                                       |   32 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                      |   76 
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                                      |   20 
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c                              |    8 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                              |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h                                  |  173 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c                                  |  345 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h                                  |   25 
 drivers/net/ethernet/cavium/liquidio/lio_main.c                                |   27 
 drivers/net/ethernet/cavium/liquidio/octeon_device.h                           |    3 
 drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c                          |   33 
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c                    |    4 
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.h                    |    1 
 drivers/net/ethernet/ibm/emac/core.c                                           |   18 
 drivers/net/ethernet/intel/ice/devlink/devlink_port.c                          |    2 
 drivers/net/ethernet/intel/ice/ice_base.c                                      |    9 
 drivers/net/ethernet/intel/ice/ice_ptp.c                                       |    8 
 drivers/net/ethernet/intel/ice/ice_txrx.c                                      |    6 
 drivers/net/ethernet/intel/idpf/idpf_dev.c                                     |    2 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                                     |   15 
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c                                  |    2 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                                |   12 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h                                |    2 
 drivers/net/ethernet/intel/igc/igc_main.c                                      |    3 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                                  |    3 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                                |   12 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h                                |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                                |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c                            |   79 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                            |   22 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                            |   29 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c                           |   20 
 drivers/net/ethernet/marvell/prestera/prestera_main.c                          |    2 
 drivers/net/ethernet/mellanox/mlx4/srq.c                                       |   13 
 drivers/net/ethernet/mellanox/mlx5/core/cq.c                                   |   24 
 drivers/net/ethernet/mellanox/mlx5/core/en.h                                   |   13 
 drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c                     |   10 
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c                            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c                               |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h                              |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c                            |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c                            |   11 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                              |   37 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c                               |   54 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.h                               |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                                |   23 
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c                             |    9 
 drivers/net/ethernet/mellanox/mlx5/core/eq.c                                   |    8 
 drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c                     |   36 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                              |    1 
 drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c                            |   16 
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c                          |    3 
 drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c                              |    8 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                                 |   11 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c                     |   29 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c          |  135 -
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.h          |    6 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_cmd.c             |    2 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_cmd.h             |    2 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_context.c         |   30 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_context.h         |    4 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_debug.c           |   56 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.h         |    2 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_internal.h        |    1 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c         |  201 -
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.h         |    8 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.h         |    2 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pool.c            |  509 +---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pool.h            |   77 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c            |   75 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.h            |    3 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c            |   16 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_table.c           |   16 
 drivers/net/ethernet/mellanox/mlx5/core/wc.c                                   |    4 
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c                                 |    2 
 drivers/net/ethernet/microsoft/mana/mana_en.c                                  |    7 
 drivers/net/ethernet/rocker/rocker_main.c                                      |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                              |   91 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                                       |  245 +-
 drivers/net/ethernet/ti/cpsw_new.c                                             |    2 
 drivers/net/ethernet/ti/icssg/icssg_common.c                                   |    2 
 drivers/net/ethernet/xilinx/xilinx_axienet.h                                   |    7 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                              |   51 
 drivers/net/loopback.c                                                         |    2 
 drivers/net/net_failover.c                                                     |    2 
 drivers/net/netconsole.c                                                       |    2 
 drivers/net/tap.c                                                              |   33 
 drivers/net/team/team_core.c                                                   |   95 
 drivers/net/team/team_mode_loadbalance.c                                       |    4 
 drivers/net/virtio_net.c                                                       |   26 
 drivers/net/vrf.c                                                              |    2 
 drivers/net/vxlan/vxlan_core.c                                                 |   36 
 drivers/net/wireguard/device.c                                                 |    8 
 drivers/net/wireless/ath/ath11k/mhi.c                                          |    8 
 drivers/net/wireless/ath/ath11k/pci.c                                          |    7 
 drivers/net/wireless/ath/ath12k/core.h                                         |    2 
 drivers/net/wireless/ath/ath12k/dp_mon.c                                       |  219 -
 drivers/net/wireless/ath/ath12k/dp_rx.c                                        |   62 
 drivers/net/wireless/ath/ath12k/dp_tx.c                                        |    5 
 drivers/net/wireless/ath/ath12k/hal_rx.c                                       |   10 
 drivers/net/wireless/ath/ath12k/hal_rx.h                                       |   12 
 drivers/net/wireless/ath/ath12k/mac.c                                          |   25 
 drivers/net/wireless/ath/ath12k/mhi.c                                          |    4 
 drivers/net/wireless/ath/ath12k/wmi.c                                          |   19 
 drivers/net/wireless/ath/ath9k/wmi.c                                           |   16 
 drivers/net/wireless/ath/ath9k/wmi.h                                           |    1 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c                         |    4 
 drivers/net/wireless/intel/iwlwifi/dvm/main.c                                  |   47 
 drivers/net/wireless/intel/iwlwifi/fw/smem.c                                   |    5 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                                   |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/binding.c                               |   10 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                                    |    3 
 drivers/net/wireless/intel/iwlwifi/mvm/link.c                                  |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                              |   12 
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h                                   |    3 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                                   |   24 
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c                            |    3 
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c                           |    6 
 drivers/net/wireless/mediatek/mt76/dma.c                                       |   10 
 drivers/net/wireless/mediatek/mt76/mac80211.c                                  |   59 
 drivers/net/wireless/mediatek/mt76/mt76.h                                      |   10 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c                           |    9 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h                           |   23 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                               |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                                |   12 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                               |   14 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                                |    6 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                               |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                                |    5 
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c                               |    4 
 drivers/net/wireless/mediatek/mt76/wed.c                                       |   10 
 drivers/net/wireless/realtek/rtw89/pci.c                                       |   41 
 drivers/ntb/ntb_transport.c                                                    |   18 
 drivers/nvme/target/admin-cmd.c                                                |    8 
 drivers/nvme/target/core.c                                                     |   41 
 drivers/nvme/target/fabrics-cmd.c                                              |    2 
 drivers/nvme/target/nvmet.h                                                    |    6 
 drivers/nvme/target/tcp.c                                                      |    6 
 drivers/opp/core.c                                                             |    5 
 drivers/pci/bus.c                                                              |   23 
 drivers/pci/endpoint/functions/pci-epf-ntb.c                                   |    5 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                                  |    5 
 drivers/pci/of.c                                                               |   27 
 drivers/pci/pci-driver.c                                                       |  200 +
 drivers/pci/pci.h                                                              |   48 
 drivers/pci/pwrctl/core.c                                                      |    2 
 drivers/pci/search.c                                                           |    8 
 drivers/perf/dwc_pcie_pmu.c                                                    |   81 
 drivers/pinctrl/mediatek/pinctrl-moore.c                                       |    6 
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c                                  |   14 
 drivers/pinctrl/mediatek/pinctrl-paris.c                                       |   33 
 drivers/platform/x86/amd/pmf/Kconfig                                           |    1 
 drivers/platform/x86/amd/pmf/acpi.c                                            |   46 
 drivers/platform/x86/amd/pmf/core.c                                            |    5 
 drivers/platform/x86/amd/pmf/pmf.h                                             |    7 
 drivers/platform/x86/amd/pmf/tee-if.c                                          |   64 
 drivers/platform/x86/asus-wmi.c                                                |    6 
 drivers/platform/x86/dell/dell-wmi-base.c                                      |    2 
 drivers/pmdomain/imx/imx93-blk-ctrl.c                                          |   60 
 drivers/power/reset/sc27xx-poweroff.c                                          |   10 
 drivers/ptp/ptp_ocp.c                                                          |    3 
 drivers/pwm/pwm-samsung.c                                                      |   22 
 drivers/remoteproc/Kconfig                                                     |   11 
 drivers/remoteproc/da8xx_remoteproc.c                                          |    2 
 drivers/remoteproc/imx_dsp_rproc.c                                             |    2 
 drivers/remoteproc/imx_rproc.c                                                 |    2 
 drivers/remoteproc/keystone_remoteproc.c                                       |    2 
 drivers/remoteproc/meson_mx_ao_arc.c                                           |    2 
 drivers/remoteproc/mtk_scp.c                                                   |    2 
 drivers/remoteproc/pru_rproc.c                                                 |    2 
 drivers/remoteproc/qcom_q6v5_adsp.c                                            |    2 
 drivers/remoteproc/qcom_q6v5_mss.c                                             |    2 
 drivers/remoteproc/qcom_q6v5_pas.c                                             |  629 ++---
 drivers/remoteproc/qcom_q6v5_wcss.c                                            |    2 
 drivers/remoteproc/qcom_wcnss.c                                                |   25 
 drivers/remoteproc/rcar_rproc.c                                                |    2 
 drivers/remoteproc/remoteproc_virtio.c                                         |    2 
 drivers/remoteproc/st_remoteproc.c                                             |    2 
 drivers/remoteproc/stm32_rproc.c                                               |    2 
 drivers/remoteproc/ti_k3_dsp_remoteproc.c                                      |    2 
 drivers/remoteproc/wkup_m3_rproc.c                                             |    2 
 drivers/s390/crypto/ap_bus.c                                                   |   74 
 drivers/s390/crypto/ap_bus.h                                                   |   30 
 drivers/s390/crypto/pkey_cca.c                                                 |   11 
 drivers/s390/crypto/zcrypt_api.c                                               |  120 -
 drivers/s390/crypto/zcrypt_api.h                                               |   11 
 drivers/s390/crypto/zcrypt_ccamisc.c                                           |   80 
 drivers/s390/crypto/zcrypt_ccamisc.h                                           |    6 
 drivers/s390/crypto/zcrypt_ep11misc.c                                          |   10 
 drivers/s390/crypto/zcrypt_msgtype50.c                                         |   36 
 drivers/s390/crypto/zcrypt_msgtype6.c                                          |  210 +
 drivers/s390/crypto/zcrypt_msgtype6.h                                          |   51 
 drivers/s390/net/ism_drv.c                                                     |   20 
 drivers/scsi/ch.c                                                              |   30 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                         |   12 
 drivers/scsi/qla2xxx/qla_iocb.c                                                |    2 
 drivers/scsi/qla2xxx/qla_os.c                                                  |   20 
 drivers/scsi/qla2xxx/qla_target.c                                              |    5 
 drivers/scsi/qla2xxx/qla_target.h                                              |    1 
 drivers/scsi/scsi_error.c                                                      |    6 
 drivers/scsi/sd.c                                                              |  141 -
 drivers/sh/clk/core.c                                                          |   10 
 drivers/sh/intc/core.c                                                         |   12 
 drivers/soc/aspeed/aspeed-lpc-snoop.c                                          |   31 
 drivers/soc/bcm/brcmstb/biuctrl.c                                              |   12 
 drivers/soc/tegra/pmc.c                                                        |  124 -
 drivers/soc/xilinx/zynqmp_power.c                                              |   43 
 drivers/soundwire/generic_bandwidth_allocation.c                               |   31 
 drivers/soundwire/intel_auxdevice.c                                            |   36 
 drivers/spi/spi-ch341.c                                                        |    7 
 drivers/spi/spi-microchip-core-qspi.c                                          |  100 
 drivers/spi/spi-mpc52xx.c                                                      |   26 
 drivers/staging/greybus/raw.c                                                  |   90 
 drivers/staging/most/Kconfig                                                   |    2 
 drivers/staging/most/Makefile                                                  |    1 
 drivers/staging/most/i2c/Kconfig                                               |   13 
 drivers/staging/most/i2c/Makefile                                              |    4 
 drivers/staging/most/i2c/i2c.c                                                 |  374 ---
 drivers/staging/rtl8723bs/core/rtw_mlme.c                                      |   14 
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                                  |   22 
 drivers/thermal/intel/intel_hfi.c                                              |   12 
 drivers/thermal/thermal_hwmon.c                                                |   87 
 drivers/tty/serial/8250/8250_core.c                                            |  253 +-
 drivers/tty/serial/serial_core.c                                               |  119 -
 drivers/tty/tty_io.c                                                           |    2 
 drivers/ufs/core/ufs-mcq.c                                                     |   35 
 drivers/ufs/core/ufs-sysfs.c                                                   |    2 
 drivers/ufs/core/ufshcd-priv.h                                                 |   14 
 drivers/ufs/core/ufshcd.c                                                      |   82 
 drivers/ufs/host/ufs-qcom.c                                                    |   71 
 drivers/usb/gadget/function/f_fs.c                                             |   55 
 drivers/usb/gadget/function/f_hid.c                                            |    4 
 drivers/usb/gadget/function/f_uac1.c                                           |   13 
 drivers/usb/gadget/function/f_uac2.c                                           |   13 
 drivers/vdpa/mlx5/core/mlx5_vdpa.h                                             |    2 
 drivers/vdpa/mlx5/core/mr.c                                                    |    5 
 drivers/vdpa/mlx5/core/resources.c                                             |   11 
 drivers/vdpa/mlx5/net/mlx5_vnet.c                                              |    6 
 drivers/vdpa/vdpa.c                                                            |   48 
 drivers/vdpa/vdpa_sim/vdpa_sim.c                                               |   10 
 drivers/vdpa/vdpa_user/iova_domain.c                                           |   11 
 drivers/vdpa/vdpa_user/vduse_dev.c                                             |    4 
 drivers/vhost/iotlb.c                                                          |   47 
 drivers/vhost/net.c                                                            |    2 
 drivers/vhost/vdpa.c                                                           |    9 
 drivers/vhost/vhost.c                                                          |   65 
 drivers/vhost/vhost.h                                                          |    1 
 drivers/vhost/vsock.c                                                          |    2 
 drivers/video/fbdev/core/fb_chrdev.c                                           |    6 
 drivers/video/fbdev/core/fbcon.c                                               |    2 
 drivers/video/fbdev/core/fbmem.c                                               |   13 
 drivers/video/fbdev/core/fbsysfs.c                                             |    4 
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c                                 |   11 
 drivers/video/fbdev/ps3fb.c                                                    |    5 
 drivers/video/fbdev/sh_mobile_lcdcfb.c                                         |    5 
 drivers/virt/acrn/irqfd.c                                                      |   71 
 drivers/virtio/virtio.c                                                        |   29 
 drivers/virtio/virtio_ring.c                                                   |   19 
 drivers/watchdog/at91sam9_wdt.c                                                |    4 
 drivers/xen/pvcalls-front.c                                                    |   88 
 drivers/xen/xen-acpi-processor.c                                               |   12 
 fs/9p/vfs_addr.c                                                               |    2 
 fs/afs/addr_list.c                                                             |    8 
 fs/afs/file.c                                                                  |    6 
 fs/afs/fsclient.c                                                              |    2 
 fs/afs/inode.c                                                                 |    1 
 fs/afs/internal.h                                                              |    4 
 fs/afs/rxrpc.c                                                                 |    4 
 fs/afs/super.c                                                                 |    2 
 fs/afs/yfsclient.c                                                             |    2 
 fs/btrfs/acl.c                                                                 |    4 
 fs/btrfs/bio.c                                                                 |    8 
 fs/btrfs/block-rsv.c                                                           |   19 
 fs/btrfs/defrag.c                                                              |   50 
 fs/btrfs/delayed-ref.c                                                         |   35 
 fs/btrfs/disk-io.c                                                             |   25 
 fs/btrfs/extent-tree.c                                                         |   35 
 fs/btrfs/extent-tree.h                                                         |    3 
 fs/btrfs/extent_io.c                                                           |   58 
 fs/btrfs/file.c                                                                |  101 
 fs/btrfs/fs.h                                                                  |    9 
 fs/btrfs/inode.c                                                               |    3 
 fs/btrfs/lzo.c                                                                 |   13 
 fs/btrfs/qgroup.c                                                              |   18 
 fs/btrfs/transaction.c                                                         |    9 
 fs/btrfs/tree-log.c                                                            |  142 -
 fs/btrfs/volumes.c                                                             |  241 +-
 fs/btrfs/zstd.c                                                                |   11 
 fs/ceph/addr.c                                                                 | 1101 ++++++----
 fs/ceph/mds_client.c                                                           |   65 
 fs/ceph/mds_client.h                                                           |    1 
 fs/ceph/super.h                                                                |    9 
 fs/erofs/decompressor.c                                                        |   61 
 fs/erofs/internal.h                                                            |    6 
 fs/erofs/xattr.c                                                               |    6 
 fs/erofs/zdata.c                                                               |   18 
 fs/erofs/zmap.c                                                                |    8 
 fs/ext2/inode.c                                                                |    3 
 fs/ext2/xattr.c                                                                |    4 
 fs/ext4/ext4.h                                                                 |    3 
 fs/ext4/inode.c                                                                |   35 
 fs/ext4/xattr.c                                                                |    2 
 fs/f2fs/checkpoint.c                                                           |   15 
 fs/f2fs/data.c                                                                 |   27 
 fs/f2fs/f2fs.h                                                                 |    3 
 fs/f2fs/gc.c                                                                   |    5 
 fs/f2fs/node.c                                                                 |   50 
 fs/f2fs/super.c                                                                |   65 
 fs/fcntl.c                                                                     |    3 
 fs/gfs2/ops_fstype.c                                                           |    2 
 fs/gfs2/super.c                                                                |    4 
 fs/iomap/buffered-io.c                                                         |    8 
 fs/lockd/svc.c                                                                 |    4 
 fs/lockd/svc4proc.c                                                            |    4 
 fs/lockd/svcproc.c                                                             |    4 
 fs/lockd/svcsubs.c                                                             |   45 
 fs/namespace.c                                                                 |   40 
 fs/netfs/Makefile                                                              |    1 
 fs/netfs/buffered_read.c                                                       |  131 -
 fs/netfs/direct_read.c                                                         |   16 
 fs/netfs/direct_write.c                                                        |   10 
 fs/netfs/internal.h                                                            |   11 
 fs/netfs/main.c                                                                |    7 
 fs/netfs/misc.c                                                                |  110 
 fs/netfs/objects.c                                                             |   35 
 fs/netfs/read_collect.c                                                        |   61 
 fs/netfs/read_pgpriv2.c                                                        |   32 
 fs/netfs/read_retry.c                                                          |    4 
 fs/netfs/rolling_buffer.c                                                      |  230 ++
 fs/netfs/write_collect.c                                                       |   25 
 fs/netfs/write_issue.c                                                         |   32 
 fs/nfs/callback_xdr.c                                                          |    6 
 fs/nfs/delegation.c                                                            |   18 
 fs/nfs/flexfilelayout/flexfilelayout.c                                         |    3 
 fs/nfs/fscache.c                                                               |    2 
 fs/nfs/fscache.h                                                               |    2 
 fs/nfs/localio.c                                                               |   15 
 fs/nfs/nfs4session.c                                                           |   16 
 fs/nfsd/filecache.c                                                            |   75 
 fs/nfsd/lockd.c                                                                |    6 
 fs/nfsd/netns.h                                                                |   22 
 fs/nfsd/nfs4proc.c                                                             |    2 
 fs/nfsd/nfs4recover.c                                                          |   12 
 fs/nfsd/nfs4state.c                                                            |   41 
 fs/nfsd/nfsctl.c                                                               |    4 
 fs/nfsd/nfssvc.c                                                               |   45 
 fs/ntfs3/bitmap.c                                                              |   62 
 fs/ntfs3/frecord.c                                                             |    1 
 fs/ntfs3/fsntfs.c                                                              |    2 
 fs/ntfs3/run.c                                                                 |   19 
 fs/ocfs2/cluster/heartbeat.c                                                   |  139 -
 fs/ocfs2/cluster/tcp.c                                                         |  105 
 fs/ocfs2/cluster/tcp.h                                                         |    1 
 fs/ocfs2/inode.c                                                               |  133 +
 fs/ocfs2/xattr.c                                                               |  215 +
 fs/ocfs2/xattr.h                                                               |    2 
 fs/overlayfs/file.c                                                            |   17 
 fs/smb/client/cifsacl.c                                                        |   28 
 fs/smb/client/cifsfs.c                                                         |    1 
 fs/smb/client/cifsglob.h                                                       |    5 
 fs/smb/client/connect.c                                                        |    5 
 fs/smb/client/file.c                                                           |   72 
 fs/smb/client/inode.c                                                          |   22 
 fs/smb/client/misc.c                                                           |   72 
 fs/smb/client/readdir.c                                                        |   17 
 fs/smb/client/smb2ops.c                                                        |   46 
 fs/smb/client/smb2pdu.c                                                        |    9 
 fs/smb/client/smbdirect.c                                                      |   20 
 fs/smb/client/transport.c                                                      |   40 
 fs/smb/server/auth.c                                                           |   14 
 fs/smb/server/connection.c                                                     |   37 
 fs/smb/server/connection.h                                                     |    7 
 fs/smb/server/mgmt/tree_connect.c                                              |   26 
 fs/smb/server/mgmt/user_config.c                                               |   11 
 fs/smb/server/mgmt/user_session.c                                              |    8 
 fs/smb/server/oplock.c                                                         |   81 
 fs/smb/server/oplock.h                                                         |    1 
 fs/smb/server/smb2pdu.c                                                        |  117 -
 fs/smb/server/smbacl.c                                                         |   86 
 fs/smb/server/smbacl.h                                                         |    2 
 fs/smb/server/transport_rdma.c                                                 |    4 
 fs/smb/server/vfs.c                                                            |    2 
 fs/smb/server/vfs_cache.c                                                      |    8 
 fs/sysfs/group.c                                                               |   26 
 fs/tracefs/event_inode.c                                                       |   24 
 fs/tracefs/internal.h                                                          |    4 
 fs/xfs/libxfs/xfs_alloc.c                                                      |   41 
 fs/xfs/libxfs/xfs_da_btree.c                                                   |   53 
 fs/xfs/libxfs/xfs_da_btree.h                                                   |    2 
 fs/xfs/libxfs/xfs_exchmaps.c                                                   |  103 
 fs/xfs/libxfs/xfs_ialloc.c                                                     |   31 
 fs/xfs/libxfs/xfs_log_format.h                                                 |    4 
 fs/xfs/xfs_attr_inactive.c                                                     |  100 
 fs/xfs/xfs_bmap_util.c                                                         |   15 
 fs/xfs/xfs_buf.c                                                               |   65 
 fs/xfs/xfs_buf.h                                                               |    1 
 fs/xfs/xfs_buf_item.c                                                          |  295 +-
 fs/xfs/xfs_buf_item.h                                                          |    3 
 fs/xfs/xfs_dquot.c                                                             |    4 
 fs/xfs/xfs_exchrange.c                                                         |   51 
 fs/xfs/xfs_icache.c                                                            |    8 
 fs/xfs/xfs_inode.c                                                             |    2 
 fs/xfs/xfs_qm.c                                                                |   87 
 fs/xfs/xfs_trace.h                                                             |    2 
 include/acpi/acpi_bus.h                                                        |    6 
 include/clocksource/samsung_pwm.h                                              |    2 
 include/drm/gpu_scheduler.h                                                    |   36 
 include/linux/arm_ffa.h                                                        |   24 
 include/linux/bpf.h                                                            |   10 
 include/linux/bpf_mprog.h                                                      |   10 
 include/linux/bpf_verifier.h                                                   |    2 
 include/linux/cgroup.h                                                         |    1 
 include/linux/device.h                                                         |   14 
 include/linux/dma/k3-udma-glue.h                                               |    3 
 include/linux/fb.h                                                             |    2 
 include/linux/folio_queue.h                                                    |   12 
 include/linux/gpio.h                                                           |    4 
 include/linux/gpio/consumer.h                                                  |   22 
 include/linux/gpio/driver.h                                                    |   10 
 include/linux/gpu_buddy.h                                                      |    9 
 include/linux/hid.h                                                            |    4 
 include/linux/hugetlb.h                                                        |    6 
 include/linux/i3c/master.h                                                     |    3 
 include/linux/ieee80211.h                                                      |   12 
 include/linux/if_team.h                                                        |    3 
 include/linux/io_uring_types.h                                                 |    8 
 include/linux/iommu.h                                                          |    5 
 include/linux/irq_work.h                                                       |    9 
 include/linux/irq_work_types.h                                                 |   14 
 include/linux/kasan.h                                                          |    6 
 include/linux/kvm_host.h                                                       |    8 
 include/linux/lockd/bind.h                                                     |   12 
 include/linux/mlx5/cq.h                                                        |    2 
 include/linux/mlx5/driver.h                                                    |    3 
 include/linux/mm_inline.h                                                      |   15 
 include/linux/mmzone.h                                                         |    2 
 include/linux/mount.h                                                          |    3 
 include/linux/net.h                                                            |   23 
 include/linux/netdevice.h                                                      |   13 
 include/linux/netfilter.h                                                      |    2 
 include/linux/netfilter/x_tables.h                                             |    1 
 include/linux/netfs.h                                                          |   22 
 include/linux/ntb.h                                                            |   24 
 include/linux/overflow.h                                                       |   70 
 include/linux/page-flags.h                                                     |    2 
 include/linux/pci.h                                                            |    1 
 include/linux/pm.h                                                             |    2 
 include/linux/pm_runtime.h                                                     |   21 
 include/linux/psi.h                                                            |    4 
 include/linux/rcupdate.h                                                       |   14 
 include/linux/rcuwait.h                                                        |   13 
 include/linux/refcount.h                                                       |  106 
 include/linux/ring_buffer.h                                                    |    5 
 include/linux/rolling_buffer.h                                                 |   61 
 include/linux/skmsg.h                                                          |   14 
 include/linux/slab.h                                                           |    9 
 include/linux/soc/mediatek/mtk_wed.h                                           |    1 
 include/linux/srcutiny.h                                                       |    4 
 include/linux/stddef.h                                                         |   20 
 include/linux/sunrpc/svc_rdma.h                                                |   14 
 include/linux/syscore_ops.h                                                    |   15 
 include/linux/types.h                                                          |   12 
 include/linux/vdpa.h                                                           |    4 
 include/media/v4l2-mem2mem.h                                                   |   21 
 include/net/act_api.h                                                          |    2 
 include/net/ax25.h                                                             |    1 
 include/net/bluetooth/hci_core.h                                               |    2 
 include/net/bluetooth/rfcomm.h                                                 |    1 
 include/net/cfg80211.h                                                         |  103 
 include/net/dropreason-core.h                                                  |   21 
 include/net/ip_vs.h                                                            |    2 
 include/net/net_namespace.h                                                    |    2 
 include/net/netfilter/nf_conntrack_expect.h                                    |   16 
 include/net/netfilter/nf_tables.h                                              |   32 
 include/net/netns/mpls.h                                                       |    2 
 include/net/pkt_cls.h                                                          |   14 
 include/net/sch_generic.h                                                      |   28 
 include/net/sctp/auth.h                                                        |    3 
 include/net/tcp.h                                                              |   15 
 include/net/xdp_sock.h                                                         |    1 
 include/net/xdp_sock_drv.h                                                     |    6 
 include/net/xsk_buff_pool.h                                                    |    9 
 include/scsi/scsi_host.h                                                       |    7 
 include/trace/events/netfs.h                                                   |  173 -
 include/trace/events/rv.h                                                      |   84 
 include/uapi/linux/netfilter/nf_conntrack_common.h                             |    1 
 include/ufs/ufshcd.h                                                           |    7 
 io_uring/eventfd.c                                                             |    6 
 io_uring/eventfd.h                                                             |    2 
 io_uring/futex.c                                                               |    4 
 io_uring/io_uring.c                                                            |    2 
 io_uring/napi.c                                                                |   72 
 io_uring/napi.h                                                                |    6 
 io_uring/poll.c                                                                |   23 
 io_uring/rw.c                                                                  |   16 
 io_uring/waitid.c                                                              |    2 
 kernel/bpf/bpf_struct_ops.c                                                    |   12 
 kernel/bpf/btf.c                                                               |   30 
 kernel/bpf/helpers.c                                                           |   15 
 kernel/bpf/mmap_unlock_work.h                                                  |   51 
 kernel/bpf/queue_stack_maps.c                                                  |    8 
 kernel/bpf/stackmap.c                                                          |  153 -
 kernel/bpf/syscall.c                                                           |   11 
 kernel/bpf/task_iter.c                                                         |   14 
 kernel/bpf/trampoline.c                                                        |    7 
 kernel/bpf/verifier.c                                                          |  479 +++-
 kernel/cgroup/cgroup.c                                                         |   47 
 kernel/cgroup/rstat.c                                                          |   19 
 kernel/cpu_pm.c                                                                |   12 
 kernel/irq/debugfs.c                                                           |    2 
 kernel/irq/generic-chip.c                                                      |   14 
 kernel/irq/pm.c                                                                |   11 
 kernel/irq/proc.c                                                              |   72 
 kernel/printk/nbcon.c                                                          |    2 
 kernel/printk/printk.c                                                         |   13 
 kernel/rcu/srcutiny.c                                                          |   19 
 kernel/sched/ext.c                                                             |   40 
 kernel/sched/psi.c                                                             |   69 
 kernel/sched/syscalls.c                                                        |   17 
 kernel/time/namespace.c                                                        |    5 
 kernel/time/sched_clock.c                                                      |   22 
 kernel/time/timekeeping.c                                                      |   22 
 kernel/trace/ring_buffer.c                                                     |  139 -
 kernel/trace/ring_buffer_benchmark.c                                           |    6 
 kernel/trace/trace.c                                                           |  108 
 kernel/trace/trace_probe.c                                                     |    2 
 lib/kunit_iov_iter.c                                                           |    4 
 mm/huge_memory.c                                                               |    3 
 mm/hugetlb.c                                                                   |    9 
 mm/hugetlb_vmemmap.c                                                           |  230 --
 mm/kasan/shadow.c                                                              |  111 -
 mm/memcontrol.c                                                                |    2 
 mm/mm_init.c                                                                   |    2 
 mm/mremap.c                                                                    |   68 
 mm/page_owner.c                                                                |   10 
 mm/page_table_check.c                                                          |   20 
 mm/vma.c                                                                       |   39 
 mm/vma.h                                                                       |   14 
 mm/vmalloc.c                                                                   |    8 
 mm/vmscan.c                                                                    |   47 
 net/ax25/af_ax25.c                                                             |   30 
 net/ax25/ax25_route.c                                                          |   74 
 net/batman-adv/soft-interface.c                                                |    2 
 net/bluetooth/6lowpan.c                                                        |   27 
 net/bluetooth/hci_conn.c                                                       |    2 
 net/bluetooth/hci_core.c                                                       |    4 
 net/bluetooth/hci_event.c                                                      |   93 
 net/bluetooth/hci_sync.c                                                       |  145 +
 net/bluetooth/hci_sysfs.c                                                      |   17 
 net/bluetooth/iso.c                                                            |   46 
 net/bluetooth/l2cap_core.c                                                     |   23 
 net/bluetooth/l2cap_sock.c                                                     |  116 -
 net/bluetooth/rfcomm/core.c                                                    |  134 -
 net/bridge/br_arp_nd_proxy.c                                                   |   24 
 net/bridge/br_device.c                                                         |    2 
 net/bridge/netfilter/ebtable_broute.c                                          |    2 
 net/bridge/netfilter/ebtable_filter.c                                          |    2 
 net/bridge/netfilter/ebtable_nat.c                                             |    2 
 net/bridge/netfilter/ebtables.c                                                |   71 
 net/ceph/auth_x.c                                                              |    5 
 net/core/bpf_sk_storage.c                                                      |   17 
 net/core/dev.c                                                                 |  182 +
 net/core/filter.c                                                              |    4 
 net/core/net_namespace.c                                                       |  175 -
 net/core/rtnetlink.c                                                           |    2 
 net/core/sock.c                                                                |    3 
 net/ethtool/module.c                                                           |    3 
 net/ethtool/rss.c                                                              |    4 
 net/handshake/handshake-test.c                                                 |    8 
 net/handshake/netlink.c                                                        |    6 
 net/handshake/request.c                                                        |   18 
 net/hsr/hsr_device.c                                                           |    2 
 net/ieee802154/6lowpan/core.c                                                  |    2 
 net/ieee802154/core.c                                                          |   14 
 net/ife/ife.c                                                                  |   14 
 net/ipv4/igmp.c                                                                |   14 
 net/ipv4/ip_tunnel.c                                                           |    2 
 net/ipv4/ipmr.c                                                                |    2 
 net/ipv4/netfilter/arp_tables.c                                                |   35 
 net/ipv4/netfilter/ip_tables.c                                                 |   41 
 net/ipv4/netfilter/iptable_nat.c                                               |    4 
 net/ipv4/tcp.c                                                                 |    5 
 net/ipv4/tcp_bpf.c                                                             |   17 
 net/ipv4/tcp_input.c                                                           |   15 
 net/ipv4/tcp_ipv4.c                                                            |    3 
 net/ipv4/udp_bpf.c                                                             |    9 
 net/ipv6/ioam6.c                                                               |   33 
 net/ipv6/ip6_gre.c                                                             |    9 
 net/ipv6/ip6_tunnel.c                                                          |    2 
 net/ipv6/ip6_vti.c                                                             |    2 
 net/ipv6/ip6mr.c                                                               |    5 
 net/ipv6/mcast.c                                                               |   20 
 net/ipv6/netfilter/ip6_tables.c                                                |   38 
 net/ipv6/netfilter/ip6table_nat.c                                              |    4 
 net/ipv6/sit.c                                                                 |    2 
 net/ipv6/tcp_ipv6.c                                                            |    3 
 net/mac80211/debug.h                                                           |   10 
 net/mac80211/mlme.c                                                            |   35 
 net/mac80211/rx.c                                                              |   50 
 net/mac80211/sta_info.c                                                        |   79 
 net/mac80211/util.c                                                            |    3 
 net/mpls/af_mpls.c                                                             |  232 +-
 net/mpls/internal.h                                                            |   16 
 net/mpls/mpls_iptunnel.c                                                       |    2 
 net/netfilter/ipvs/ip_vs_core.c                                                |   11 
 net/netfilter/ipvs/ip_vs_xmit.c                                                |    3 
 net/netfilter/nf_conntrack_bpf.c                                               |  111 -
 net/netfilter/nf_conntrack_core.c                                              |   33 
 net/netfilter/nf_conntrack_expect.c                                            |  148 -
 net/netfilter/nf_conntrack_h323_main.c                                         |    4 
 net/netfilter/nf_conntrack_helper.c                                            |   10 
 net/netfilter/nf_conntrack_netlink.c                                           |   24 
 net/netfilter/nf_conntrack_sip.c                                               |   13 
 net/netfilter/nf_flow_table_ip.c                                               |    3 
 net/netfilter/nf_nat_core.c                                                    |   10 
 net/netfilter/nf_tables_api.c                                                  |  317 +-
 net/netfilter/nft_bitwise.c                                                    |   15 
 net/netfilter/nft_byteorder.c                                                  |   13 
 net/netfilter/nft_ct.c                                                         |    3 
 net/netfilter/nft_dynset.c                                                     |   25 
 net/netfilter/nft_flow_offload.c                                               |    3 
 net/netfilter/nft_set_pipapo.c                                                 |   11 
 net/netfilter/x_tables.c                                                       |   77 
 net/openvswitch/vport-internal_dev.c                                           |    2 
 net/phonet/socket.c                                                            |   10 
 net/qrtr/mhi.c                                                                 |   69 
 net/rxrpc/af_rxrpc.c                                                           |   25 
 net/rxrpc/key.c                                                                |    2 
 net/rxrpc/peer_object.c                                                        |   22 
 net/rxrpc/proc.c                                                               |   32 
 net/rxrpc/recvmsg.c                                                            |   12 
 net/rxrpc/sendmsg.c                                                            |    7 
 net/rxrpc/server_key.c                                                         |    2 
 net/sched/act_api.c                                                            |    2 
 net/sched/act_bpf.c                                                            |    2 
 net/sched/act_ife.c                                                            |   40 
 net/sched/act_mpls.c                                                           |    2 
 net/sched/act_police.c                                                         |    2 
 net/sched/act_skbedit.c                                                        |    2 
 net/sched/cls_api.c                                                            |    6 
 net/sched/cls_basic.c                                                          |    6 
 net/sched/cls_bpf.c                                                            |    6 
 net/sched/cls_cgroup.c                                                         |    2 
 net/sched/cls_flow.c                                                           |    2 
 net/sched/cls_flower.c                                                         |    4 
 net/sched/cls_fw.c                                                             |    4 
 net/sched/cls_matchall.c                                                       |    4 
 net/sched/cls_route.c                                                          |    4 
 net/sched/cls_u32.c                                                            |   18 
 net/sched/sch_cake.c                                                           |    4 
 net/sched/sch_codel.c                                                          |   12 
 net/sched/sch_drr.c                                                            |    2 
 net/sched/sch_ets.c                                                            |    2 
 net/sched/sch_fq.c                                                             |   26 
 net/sched/sch_fq_codel.c                                                       |   16 
 net/sched/sch_fq_pie.c                                                         |   14 
 net/sched/sch_generic.c                                                        |   45 
 net/sched/sch_gred.c                                                           |    2 
 net/sched/sch_hfsc.c                                                           |    2 
 net/sched/sch_hhf.c                                                            |   12 
 net/sched/sch_htb.c                                                            |    2 
 net/sched/sch_multiq.c                                                         |    2 
 net/sched/sch_pie.c                                                            |   12 
 net/sched/sch_prio.c                                                           |    2 
 net/sched/sch_qfq.c                                                            |    2 
 net/sched/sch_sfb.c                                                            |    2 
 net/sched/sch_sfq.c                                                            |    2 
 net/sctp/auth.c                                                                |   76 
 net/sctp/bind_addr.c                                                           |   11 
 net/sctp/protocol.c                                                            |    3 
 net/sctp/sm_make_chunk.c                                                       |   20 
 net/sctp/sm_statefuns.c                                                        |   36 
 net/smc/af_smc.c                                                               |   90 
 net/smc/smc_loopback.c                                                         |   45 
 net/sunrpc/auth_gss/gss_krb5_unseal.c                                          |    3 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                                        |   17 
 net/sunrpc/xprtrdma/svc_rdma_rw.c                                              |  100 
 net/sunrpc/xprtrdma/svc_rdma_sendto.c                                          |   16 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                                       |   30 
 net/tipc/core.c                                                                |    4 
 net/tipc/udp_media.c                                                           |   75 
 net/tls/tls_sw.c                                                               |    2 
 net/wireless/core.c                                                            |   20 
 net/wireless/core.h                                                            |    2 
 net/wireless/nl80211.c                                                         |   16 
 net/wireless/scan.c                                                            |   15 
 net/wireless/sme.c                                                             |    6 
 net/xdp/xsk.c                                                                  |  251 ++
 net/xdp/xsk_buff_pool.c                                                        |   14 
 net/xdp/xsk_queue.h                                                            |   65 
 net/xfrm/xfrm_device.c                                                         |    8 
 security/apparmor/domain.c                                                     |  105 
 security/apparmor/include/policy.h                                             |    3 
 security/apparmor/policy.c                                                     |   22 
 security/selinux/selinuxfs.c                                                   |   27 
 sound/core/seq/oss/seq_oss_event.c                                             |    6 
 sound/core/seq/oss/seq_oss_event.h                                             |    3 
 sound/core/seq/oss/seq_oss_ioctl.c                                             |    5 
 sound/core/seq/oss/seq_oss_midi.c                                              |    6 
 sound/core/seq/oss/seq_oss_midi.h                                              |    2 
 sound/core/seq/oss/seq_oss_readq.c                                             |   83 
 sound/core/seq/oss/seq_oss_rw.c                                                |    5 
 sound/core/seq/seq_clientmgr.c                                                 |    3 
 sound/core/seq/seq_fifo.c                                                      |   67 
 sound/core/seq/seq_fifo.h                                                      |    1 
 sound/drivers/mtpav.c                                                          |    6 
 sound/soc/amd/acp/acp-mach-common.c                                            |   18 
 sound/soc/intel/avs/avs.h                                                      |    2 
 sound/soc/intel/avs/path.c                                                     |   11 
 sound/soc/intel/avs/pcm.c                                                      |   23 
 sound/soc/intel/avs/probes.c                                                   |    2 
 sound/soc/intel/avs/topology.c                                                 |   47 
 sound/soc/intel/avs/topology.h                                                 |    4 
 sound/soc/qcom/qdsp6/q6asm.c                                                   |    5 
 sound/soc/sof/ipc3-pcm.c                                                       |   13 
 sound/soc/sof/ipc3-topology.c                                                  |   20 
 sound/soc/sof/ipc4-pcm.c                                                       |   41 
 sound/soc/sof/ipc4-topology.c                                                  |   18 
 sound/soc/sof/pcm.c                                                            |  169 +
 sound/soc/sof/sof-audio.c                                                      |   49 
 sound/soc/sof/sof-audio.h                                                      |   17 
 sound/usb/pcm.c                                                                |    2 
 tools/testing/selftests/bpf/progs/exceptions_fail.c                            |    9 
 tools/testing/selftests/bpf/progs/verifier_subprog_precision.c                 |   12 
 tools/testing/selftests/net/forwarding/README                                  |    2 
 tools/testing/selftests/net/tls.c                                              |  515 ++++
 tools/testing/vma/vma.c                                                        |    4 
 virt/kvm/guest_memfd.c                                                         |    8 
 virt/kvm/kvm_main.c                                                            |   36 
 virt/kvm/kvm_mm.h                                                              |    7 
 1171 files changed, 21334 insertions(+), 12944 deletions(-)

Abd-Alrhman Masalkhi (6):
      md/raid10: fix writes_pending leak on write request failures
      md/raid1: fix writes_pending and barrier reference leaks on write failures
      md: replace wait loop with wait_event() in md_handle_request()
      md/raid1,raid10: fix deadlock in read error recovery path
      md/raid1,raid10: fix bio accounting for split md cloned bios
      md/raid1,raid10: fix error-path detection with md_cloned_bio()

Abdurrahman Hussain (1):
      hwmon: (pmbus/core) honor vrm_version in pmbus_data2reg_vid()

Aditya Prakash Srivastava (1):
      ext4: fix ABBA deadlock in ext4_xattr_inode_cache_find()

Adrian Hunter (4):
      i3c: mipi-i3c-hci: Correct RING_CTRL_ABORT handling in DMA dequeue
      i3c: mipi-i3c-hci: Fix race in DMA ring dequeue
      i3c: master: Fix recursive locking during device registration
      i3c: mipi-i3c-hci: Preserve RUN bit when aborting DMA ring

Adrián Larumbe (1):
      drm/panthor: Add vm_bind region with kbo range overlap check

Ahmed Abdelhaleem Ahmed (1):
      scsi: ch: Do not keep references to data transfer element devices

Akash Goel (1):
      drm/panthor: Prevent potential UAF in group creation

Akihiko Odaki (1):
      tap: Keep hdr_len in tap_get_user()

Akiva Goldberger (1):
      mlx5: Fix default values in create CQ

Al Viro (1):
      functionfs: fix the open/removal races

Alain Volmat (2):
      media: stm32: dcmipp: use v4l2_subdev_is_streaming
      media: stm32: dcmipp: replace s_stream with enable/disable_streams

Aleksandr Nogikh (1):
      firewire: ohci: fix NULL pointer dereference in ar_context_release

Alex Bereza (1):
      dmaengine: xilinx_dma: Fix CPU stall in xilinx_dma_poll_timeout

Alex Deucher (3):
      drm/amd/display: check if dml21_add_phantom_plane() is successful
      drm/amdgpu/atombios: drop empty function
      drm/amdgpu: rework i2c init and fini

Alexander Gordeev (1):
      kasan: avoid sleepable page allocation from atomic context

Alexander Graf (1):
      virtio_ring: fix stale descriptor flags after a failed packed add

Alexandra Winter (1):
      s390/ism: Fix UAF of sba and ieq during ism_dev_exit()

Alexey Velichayshiy (1):
      ksmbd: remove redundant DACL check in smb_check_perm_dacl

Ali Ahmet Memis (1):
      Bluetooth: ISO: zero the sockaddr before returning it in getname

Amadeusz Sławiński (1):
      ASoC: Intel: avs: Use topology information for endpoint numbers

Amir Goldstein (1):
      ovl: check access to copy_file_range source with src mounter creds

Andre Przywara (1):
      clk: sunxi-ng: h616: Reparent CPU clock during frequency changes

Andy Shevchenko (1):
      genirq: Consistently use '%u' format specifier for unsigned int variables

Andy Yan (1):
      drm/rockchip: vop2: Register the primary plane and overlay plane separately

Anna Maniscalco (1):
      drm/msm: always recover the gpu

Anshumali Gaur (1):
      octeontx2-vf: fix workqueue and netdev race in probe/remove

Antoine Tenart (1):
      net: vxlan: prevent NULL deref in vxlan_xmit_one

Anton Protopopov (1):
      virtio_net: Fix resize of the RX ring

Arie Miller (2):
      hwmon: (asus_rog_ryujin) Add per-device configuration
      hwmon: (asus_rog_ryujin) Validate HID report lengths

Armin Wolf (1):
      platform/x86: dell-wmi-base: Fix handling of ultra performance key

Arunpravin Paneer Selvam (1):
      drm/amdgpu: skip the VMID 0 flush for VRAM

Arvind Yadav (1):
      drm/xe/guc: Keep scheduler timeline name alive

Atish Patra (1):
      RISC-V: KVM: Teardown riscv specific bits after kvm_exit

Baoli.Zhang (1):
      soundwire: fix bug in sdw_add_element_group_count found by syzkaller

Bart Van Assche (3):
      scsi: ufs: core: Move an assignment in ufshcd_mcq_process_cqe()
      scsi: ufs: core: Add a comment block above ufshcd_mcq_compl_all_cqes_lock()
      scsi: sd: Move the sd_config_discard() function definition

Bartosz Golaszewski (6):
      gpiolib: make value setters have return values
      gpiolib: wrap gpio_chip::set()
      gpiolib: rework the wrapper around gpio_chip::set_multiple()
      gpiolib: introduce gpio_chip setters that return values
      pinctrl: mediatek: paris: don't double-check the GPIO number
      pinctrl: mediatek: paris: use new GPIO line value setter callbacks

Bean Huo (1):
      scsi: ufs: core: Convert string descriptor format macros to enum

Ben Cressey (2):
      dm-integrity: fix buffer overflow in inline mode with large tag size
      dm-integrity: fix buffer overflow with keyed discard

Ben Dooks (1):
      riscv: save the SR_SUM status over switches

Benjamin Berg (2):
      wifi: mac80211: fix typo in HE MCS check
      wifi: mac80211: log link information in ieee80211_determine_chan_mode

Benjamin Leggett (1):
      drm/virtio: use the DMA API for resource backing on Xen

Benjamin Marzinski (1):
      dm: limit swapping tables for devices with zone write plugs

Binbin Zhou (1):
      mmc: vub300: Use devm_mmc_alloc_host() helper

Bjorn Andersson (2):
      remoteproc: qcom: pas: Make remoteproc name human friendly
      remoteproc: qcom: pas: Conclude the rename from adsp

Bjorn Helgaas (1):
      perf/dwc_pcie: Qualify RAS DES VSEC Capability by Vendor, Revision

Boris Brezillon (1):
      drm/panthor: Always use the IRQ-safe variant when acquiring the fence lock

Boris Burkov (1):
      btrfs: fix EEXIST abort due to non-consecutive gaps in chunk allocation

Brandon Brnich (1):
      media: chips-media: wave5: Release m2m_ctx after Instance Removed from List

Breno Leitao (2):
      net: add getsockopt_iter callback to proto_ops
      Bluetooth: L2CAP: convert to getsockopt_iter

Brian Norris (1):
      PCI/pwrctrl: Cancel outstanding rescan work when unregistering

Bryam Vargas (2):
      ata: libata-core: Add NOLPM quirk for PNY CS900 1TB SSD
      smb: client: reject a tree connect response whose byte count is too small

Caleb Sander Mateos (2):
      block: zero non-PI portion of auto integrity buffer
      ublk: check import_ubuf() return value

Candice Li (1):
      drm/amdgpu: Bound GPIO I2C table entry count from VBIOS

Carlos López (1):
      KVM: x86: Unconditionally recompute CR8 intercept on PPR update

Carolina Jubran (1):
      net/mlx5e: Move representor vnic reporter to eswitch devlink port

Cen Zhang (7):
      wifi: cfg80211: use wiphy work for socket owner autodisconnect
      Bluetooth: 6lowpan: avoid untracked enable work
      ALSA: seq: avoid stale FIFO cells during resize
      ALSA: seq: oss: Serialize readq reset state with q->lock
      ocfs2: o2hb: quiesce negotiate handlers and timeout work
      ocfs2: validate inline xattrs during inode block validation
      ocfs2: validate external xattr entries when reading metadata

Cen Zhang (Microsoft Security FORGE Labs) (1):
      ksmbd: fix tree connection use-after-free in smb2_tree_connect()

Cen Zhang (Microsoft) (1):
      net/sched: cls_u32: validate offshift to prevent shift-out-of-bounds

Cezary Rojewski (2):
      ASoC: Intel: avs: Do not share the name pointer between components
      ASoC: Intel: avs: Refactor and fix init_config access

Chao Yu (2):
      f2fs: quota: fix to avoid warning in dquot_writeback_dquots()
      f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()

Chen Ni (1):
      ASoC: amd: acp-mach-common: Add missing error check for clock acquisition

Chen-Yu Tsai (1):
      pinctrl: mediatek: paris: bypass pinctrl GPIO layer in set GPIO direction

Chengfeng Ye (2):
      Bluetooth: hci_sync: Fix command skb lifetime during scan setup
      bpf: Fix netns reference imbalance in conntrack kfuncs

Chris Mason (1):
      nfsd: convert nfsd_net boolean flags to unsigned long flags word

Christian Borntraeger (1):
      KVM: s390: Fix memory corruption by not reinjecting CK machine checks

Christian Brauner (6):
      namespace: don't inherit MNT_UMOUNT in clone_mnt()
      namespace: check the mounts before reading their parents in pivot_root()
      namespace: unhash a dentry before detaching the mounts on it
      namespace: check the target before walking it in do_mount_setattr()
      fcntl: refuse F_SET_RW_HINT on an immutable inode
      namespace: handle mount locking for automounts correctly

Christian König (1):
      drm/amdgpu: fix amdgpu_hmm_range_get_pages

Christophe JAILLET (1):
      wifi: cfg80211: Fix an error handling path in cfg80211_wext_siwscan()

Chuck Lever (7):
      net/handshake: hand off the pinned file reference to accept_doit
      svcrdma: Reject Read lists that exceed the page budget
      svcrdma: Add Write chunk WRs to the RPC's Send WR chain
      svcrdma: wake sq waiters when the transport closes
      svcrdma: Clear sc_cm_id when ADDR_CHANGE replacement fails
      SUNRPC: Reject short RFC 4121 MIC tokens in gss_krb5_verify_mic_v2
      NFS: Return a delegation the client fails to record

Claudio Imbrenda (11):
      s390/entry: Remove __GMAP_ASCE and use _PIF_GUEST_FAULT again
      s390/kvm: Remove kvm_arch_fault_in_page()
      s390/mm/fault: Handle guest-related program interrupts in KVM
      s390/kvm: Initialize uninitialized flags variable
      KVM: s390: wrapper for KVM_BUG
      KVM: s390: move pv gmap functions into kvm
      KVM: s390: use __kvm_faultin_pfn()
      KVM: s390: move gmap_shadow_pgt_lookup() into kvm
      KVM: s390: pv: fix race when making a page secure
      KVM: s390: Fix FOLL_*/FAULT_FLAG_* confusion
      s390/kvm: Mask extra bits from program interrupt code

Colin Ian King (1):
      PM: sleep: Fix bit masking operation

Cong Nguyen (1):
      staging: rtl8723bs: fix xmit_frame/xmit_buf leaks on mgnt-frame error paths

Conor Dooley (4):
      spi: microchip-core-qspi: set min_speed_hz during probe
      spi: microchip-core-qspi: remove unused param from mchp_coreqspi_write_op()
      spi: microchip-core-qspi: control built-in cs manually
      spi: microchip-core-qspi: stop checking viability of op->max_freq in supports_op callback

Corey Minyard (1):
      ipmi:ssif: Clean up kthread on errors

Cosmin Ratiu (3):
      net/mlx5: Fix typo of MLX5_EQ_DOORBEL_OFFSET
      net/mlx5: Store the global doorbell in mlx5_priv
      net/mlx5e: Prepare for using different CQ doorbells

Cristian Ciocaltea (1):
      drm/rockchip: vop2: Consistently use dev_err_probe()

Cyril Bur (1):
      riscv: uaccess: Only restore the CSR_STATUS SUM bit

Cédric Bellegarde (1):
      ASoC: qcom: q6asm: drop DSP responses for closed data streams

D. Wythe (1):
      Revert "net/smc: Introduce TCP ULP support"

Daehyeon Ko (1):
      ip6_gre: remove obsolete ERSPAN PMTU update

Daisuke Matsuda (1):
      RDMA/rxe: Move some code to rxe_loc.h in preparation for ODP

Damien Riégel (2):
      greybus: raw: fix use-after-free on cdev close
      greybus: raw: fix use-after-free if write is called after disconnect

Dan Carpenter (1):
      wifi: iwlwifi: Fix error code in iwl_op_mode_dvm_start()

Dan Williams (2):
      cxl/region: Block region delete during region creation
      cxl/region: Resolve region deletion races

Daniel Borkmann (1):
      bpf: Fix incorrect pruning due to atomic fetch precision tracking

Daniil Dulov (1):
      ring-buffer: Fix possible dereference of uninitialized pointer

Danilo Krummrich (1):
      vdpa: use generic driver_override infrastructure

Dapeng Mi (1):
      perf/x86/intel: Prevent drain_pebs() reentry

Darrick J. Wong (1):
      xfs: fix exchange-range-to-eof file size exchange

Dave Airlie (1):
      nouveau/gsp: drop WARN_ON in ACPI probes

Dave Chinner (6):
      xfs: xfs_ifree_cluster vs xfs_iflush_shutdown_abort deadlock
      xfs: catch stale AGF/AGF metadata
      xfs: avoid dquot buffer pin deadlock
      xfs: rearrange code in xfs_buf_item.c
      xfs: factor out stale buffer item completion
      xfs: fix unmount hang with unflushable inodes stuck in the AIL

David Carlier (1):
      netfilter: flowtable: avoid num_encaps underflow on bridge VLAN untag

David Francis (1):
      drm/amdkfd: Check bounds on CRIU restore queue type and mqd size

David Hildenbrand (2):
      mm/mremap: fix WARN with uffd that has remap events disabled
      s390/uv: Don't return 0 from make_hva_secure() if the operation was not successful

David Howells (14):
      rxrpc: kdoc: Update function descriptions and add link from rxrpc.rst
      netfs: Fix leak of request in netfs_write_begin() error handling
      netfs: Fix missing locking around retry adding new subreqs
      netfs: Fix zeropoint update where i_size > remote_i_size
      netfs: Clean up some whitespace in trace header
      netfs: Use a folio_queue allocation and free functions
      netfs: Add a tracepoint to log the lifespan of folio_queue structs
      netfs: Abstract out a rolling folio buffer implementation
      netfs: Drop the was_async arg from netfs_read_subreq_terminated()
      netfs: Fix netfs_create_write_req() to handle async cache object creation
      afs: Fix reinitialisation of the inode, in particular ->lock_work
      afs: Fix UAF when sending a message
      netfs: Fix folio_queue ENOMEM in writeback by adding a mempool
      netfs: Fix folio state after ENOMEM whilst under writeback iteration

David Lee (1):
      btrfs: lzo: reject inline extents without valid headers

David Sterba (1):
      btrfs: tree-log: don't use token set/get accessors in fill_inode_item()

David Windsor (1):
      bpf: Reject sleepable BPF_LSM_CGROUP programs at load time

Davidlohr Bueso (1):
      cxl/mbox: validate payload size before accessing contents in cxl_payload_from_user_allowed()

Dawei Feng (1):
      wifi: iwlwifi: dvm: fix memory leak in iwl_op_mode_dvm_start()

Deepanshu Kartikey (2):
      gfs2: fix memory leaks in gfs2_fill_super error path
      ocfs2: validate i_refcount_loc when refcount flag is set

Di Shen (1):
      OPP: Fix race between OPP addition and lookup

Dmitry Antipov (2):
      ocfs2: add suballoc slot check in ocfs2_validate_inode_block()
      ocfs2: add extra consistency checks for chain allocator dinodes

Dmitry Baryshkov (1):
      drm/msm: don't tear down KMS twice when KMS init fails

Dongjiang Zhu (1):
      btrfs: skip global block reserve accounting for rescue mounts

Dongwon Kim (1):
      drm/virtio: Use drm_gem_plane_helper_prepare_fb()

Dr. David Alan Gilbert (2):
      virt: acrn: Remove unused list 'acrn_irqfd_clients'
      drm/amdgpu: Remove unused amdgpu_i2c functions

Dragos Tatulea (2):
      net/mlx5e: RX, Fix XDP multi-buf frag counting for legacy RQ
      net/mlx5e: RX, Fix XDP multi-buf frag counting for striding RQ

Duoming Zhou (1):
      ptp: ocp: fix use-after-free bugs causing by ptp_ocp_watchdog

Eduard Zingerman (7):
      bpf: mark a NULL call argument precise
      bpf: Don't infer non-NULL from a pointer with an unbounded offset
      bpf: don't rewrite bpf_fastcall patterns entered by a jump
      bpf: zero extend the result of an arena 32-bit cmpxchg
      bpf: backtracking shouldn't clear outer frame R1-R5 for callbacks
      bpf: backtrack_insn(): Handle ld_{abs,ind} subprog exit edge
      bpf: check_cond_jmp_op(): properly infer if register is null

Edward Adam Davis (2):
      ALSA: usb-audio: Prevent excessive number of frames
      sched/psi: fix race between file release and pressure write

Emil Tantilov (2):
      idpf: fix error handling in the init_task on load
      idpf: fix max_vport related crash on allocation error during init

Emily Deng (1):
      drm/amdkfd: Fix partial migrate issue

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: don't send a 6E related command when not supported

Eric Biggers (6):
      crypto: x86/aegis128 - eliminate some indirect calls
      crypto: x86/aegis128 - optimize length block preparation using SSE4.1
      crypto: x86/aegis128 - improve assembly function prototypes
      crypto: x86/aegis - Fix sleeping when disallowed on PREEMPT_RT
      crypto: x86/aegis - Add missing error checks
      dm-verity-fec: fix reading parity bytes split across blocks (take 3)

Eric Dumazet (14):
      ipv6: ioam: fix potential NULL dereferences in __ioam6_fill_trace_data()
      net: pull headers in qdisc_pkt_len_segs_init()
      tcp: fix stale per-CPU tcp_tw_isn leak enabling ISN prediction
      ipv4: igmp: Fix potential memory leaks in igmp_mod_timer() and igmp_stop_timer()
      tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
      net: serialize netif_running() check in enqueue_to_backlog()
      net: watchdog: fix refcount tracking races
      netfilter: nf_flow_table: drop existing skb dst before skb_dst_set_noref()
      tipc: avoid busy looping in tipc_exit_net()
      net_sched: sch_fq: add three drop_reason
      net/sched: add qstats_cpu_drop_inc() helper
      ip6mr: do not clone dst in ip6mr_cache_report()
      ipv6: mcast: use rcu_assign_pointer() for __rcu list updates
      net: do not acquire dev->tx_global_lock in netdev_watchdog_up()

Erni Sri Satya Vennela (1):
      net: mana: Guard mana_remove against double invocation

Ethan Tidmore (1):
      usb: gadget: f_hid: Add missing error code

Evgenii Burenchev (2):
      drm/amd/display: Fix dangling pointer in CRTC reset function
      drm/amd/display: Fix dangling pointer in plane reset function

FAN YE (1):
      btrfs: zstd: fix lost wakeup when waiting for a workspace

Fangyu Yu (1):
      RISC-V: KVM: Write hgatp register with valid mode bits

Fedor Pchelkin (1):
      wifi: fix leak if split 6 GHz scanning fails

Felix Fietkau (4):
      wifi: mt76: mt7915: fix list corruption after hardware restart
      wifi: mt76: mt7996: do not attach hif2 WED when the main WED attach failed
      wifi: mt76: cancel reset and rc work on device unregister
      wifi: mt76: mt7996: hold dev->mt76.mutex while disabling tx worker in SER

Felix Gu (1):
      drm/msm/adreno: Fix a reference leak in a6xx_gpu_init()

Feng Liu (1):
      net/mlx5e: Fix publication race for priv->channel_stats[]

Fernando Fernandez Mancera (2):
      sysfs: check visibility before changing group attribute ownership
      netfilter: nf_tables: fix dst corruption in same register operation

Filipe Manana (4):
      btrfs: fix zero size inode with non-zero size after log replay
      btrfs: remove 'reserved' argument from btrfs_pin_extent()
      btrfs: don't BUG() on unexpected delayed ref type in run_one_delayed_ref()
      btrfs: defrag: fix deadlock between defrag and delalloc space reservation

Florian Westphal (8):
      netfilter: nf_tables: use list_del_rcu for netlink hooks
      netfilter: bridge: eb_tables: close module init race
      netfilter: ebtables: move to two-stage removal scheme
      netfilter: x_tables: allow initial table replace without emitting audit log message
      netfilter: x_tables: allocate hook ops while under mutex
      netfilter: nf_tables: prefer nft_trans_elem_alloc helper
      netfilter: nf_tables: add nft_trans_commit_list_add_elem helper
      netfilter: nf_tables: prepare for multiple elements in nft_trans_elem structure

Frank Sorenson (3):
      cifs: prevent readdir from changing file size due to stale directory metadata
      cifs: fix cifsFileInfo leak on kmalloc failure in deferred close drain paths
      cifs: call pagecache_isize_extended() in cifs_setsize() when extending

Fushuai Wang (1):
      bpf: Use rcu_read_lock_dont_migrate in bpf_sk_storage.c

Gabriele Monaco (2):
      rv: Remove trailing whitespace from tracepoint string
      rv: Use strings in da monitors tracepoints

Gao Xiang (2):
      erofs: fix interlaced ztailpacking pclusters
      erofs: disable LZ4 rolling decompression for now

Gary Guo (3):
      PCI: Make pci_match_one_device() match on ID instead of device
      PCI: Fix dyn_id add TOCTOU
      PCI: Fix UAF when probe runs concurrent to dyn ID removal

Ge Yang (1):
      KVM: SEV: Use long-term pin when registering encrypted memory regions

Geliang Tang (1):
      nvmet-tcp: check return value of nvmet_tcp_set_queue_sock

George Guo (1):
      LoongArch: Fix address space mismatch in kexec command line lookup

George Zhang (1):
      drm/amd/display: Fix divide-by-zero in calculate_mcache_setting on zero viewport

Gou Hao (2):
      powerpc/xive: add error return value to xive_smp_probe()
      powerpc/xive: propagate IPI init errors to prevent use-after-free

Greg Kroah-Hartman (1):
      Linux 6.12.114

Guangshuo Li (1):
      mmc: vub300: fix use-after-free on probe failure

Guenter Roeck (4):
      hwmon: (lm90) Stop work before releasing hwmon device
      hwmon: (lm90) Add lock protection to lm90_alert
      hwmon: (pmbus) Fix type confusion in notification logic
      hwmon: (asus_rog_ryujin) Rely on subsystem locking

Guillaume Gonnet (1):
      bpf: Fix tcx/netkit detach permissions when prog fd isn't given

Guoniu Zhou (1):
      pmdomain: imx93-blk-ctrl: Extract PHY as shared domain for DSI/CSI

Gustavo A. R. Silva (2):
      stddef: Introduce TRAILING_OVERLAP() helper macro
      virtio_net: Fix misalignment bug in struct virtnet_info

Gustavo Luiz Duarte (1):
      netconsole: Acquire su_mutex before navigating configs hierarchy

Haofeng Li (1):
      ksmbd: validate NTLMv2 response before updating session key

Haotian Zhang (1):
      PCI: endpoint: Add missing NULL check for alloc_workqueue()

Haoxiang Li (1):
      HID: logitech-hidpp: Fix FF device cleanup on init failure

Harald Freudenberger (9):
      s390/zcrypt: Fix buffer over-read in cca_cipher2protkey
      s390/ap: Move response_type struct into ap_msg struct
      s390/ap/zcrypt: Rework AP message buffer allocation
      s390/ap: Introduce ap message buffer pool
      s390/ap/zcrypt: New xflag parameter
      s390/zcrypt: Move inline function rng_type6cprb_msgx from header to code
      s390/zcrypt: Rework domain processing within zcrypt device driver
      s390/zcrypt: Close speculative mem read possibility
      s390/zcrypt: Fix memory leak with CCA cards used as accelerator

Hariprasad Kelam (1):
      octeontx2-af: Block VFs from clobbering special CGX PKIND state

Harish Kasiviswanathan (1):
      drm/amdgpu: Fix kernel panic during driver load failure

Harry Wentland (2):
      drm/amd/display: Fix out-of-bounds read in dp_get_eq_aux_rd_interval()
      drm/amd/display: Resize MST HDCP per-connector arrays to 32

Heiko Carstens (3):
      s390/mm: Simplify get_fault_type()
      s390/mm: Get rid of fault type switch statements
      s390/mm: Fix in_atomic() handling in do_secure_storage_access()

Heiko Stuebner (1):
      drm/rockchip: vop2: fail cleanly if missing a primary plane for a video-port

Heinz Mauelshagen (1):
      md raid: fix hang when stopping arrays with metadata through dm-raid

Hengyu Liang (1):
      ata: libata-scsi: do not lose CHECK CONDITION for failed ATAPI commands

Herve Codina (1):
      driver core: Avoid warning when removing a device while its supplier is unbinding

Hidayath Khan (1):
      dibs: fix use-after-free of dmb_node in loopback attach/detach/unregister

Hongjie Fang (1):
      scsi: core: pair EH runtime PM get and put

Honglei Huang (1):
      drm/amd/display: use kvzalloc to allocate struct dc

Hongling Zeng (2):
      fbdev: omap2: fix inconsistent lock returns in omapfb_mmap
      fbdev: omap2: fix use-after-free in omapfb_mmap

Hongyan Xu (1):
      watchdog: at91sam9_wdt: prevent timer rearm during teardown

Hou Tao (3):
      bpf: Disable migration when destroying sock storage
      bpf: Disable migration when cloning sock storage
      bpf: Remove migrate_{disable|enable} in bpf_obj_free_fields()

Hristo Venev (1):
      ceph: do not skip the first folio of the next object in writeback

Hugo Villeneuve (1):
      drm: renesas: rz-du: mipi_dsi: fix kernel panic when rebooting for some panels

Huiwen He (1):
      smb/client: invalidate fscache for fallocate range operations

Hyunwoo Kim (1):
      KVM: arm64: Take the SRCU lock for page table walks in fault injection and AT emulation

Ian Bridges (1):
      ocfs2: fix UBSAN array-index-out-of-bounds in ocfs2_sum_rightmost_rec

Icenowy Zheng (1):
      clk: thead: th1520-ap: set all AXI clocks to CLK_IS_CRITICAL

Ihor Solodrai (1):
      bpf: Fix exception exit lock checking for subprogs

Ilan Dudnik (2):
      ksmbd: defer publishing granted locks to prevent UAF/double-free race
      ksmbd: fix heap out-of-bounds write in krb5_authenticate()

Ivan Abramov (1):
      ieee802154: Avoid calling WARN_ON() on -ENOMEM in cfg802154_switch_netns()

Jacek Lawrynowicz (2):
      accel/ivpu: Rework bind/unbind of imported buffers
      accel/ivpu: Fix page fault in ivpu_bo_unbind_all_bos_from_context()

Jackson Lee (1):
      media: chips-media: wave5: Fix Null reference while testing fluster

Jacob Moroni (2):
      RDMA/irdma: Prevent user-triggered null deref on QP create
      RDMA/irdma: Replace waitqueue and flag with completion

Jakub Kicinski (2):
      ethtool: module: call ethnl_ops_complete() on module flash errors
      ethtool: rss: fix indir_table and hkey leak on get_rxfh failure

Jamal Hadi Salim (2):
      net/sched: Handle TC_ACT_REDIRECT from qdisc filter chains
      net/sched: account classifier filter allocations to memcg

James Clark (1):
      coresight: ete: Always save state on power down

James Zhu (3):
      drm/amdkfd: return migration pages from copy function
      Revert "drm/amdkfd: return migration pages from copy function"
      drm/amdkfd: return migration pages from copy function - again

Jan Kara (1):
      ext2: Fix lost inode updates for IS_SYNC inodes

Jani Nikula (8):
      drm/i915/display: pass display to intel_crtc_for_pipe()
      drm/i915/display: convert I915_STATE_WARN() to struct intel_display
      drm/i915/gmbus: convert to struct intel_display
      drm/i915/crt: convert to struct intel_display
      drm/i915/mst: limit DP MST ESI service loop
      drm/i915: rename range_overflows_end() to range_end_overflows()
      drm/i915: document range_overflows() and range_end_overflows() macros
      overflow: add range_overflows() and range_end_overflows()

Janosch Frank (1):
      s390/mm: Add missing secure storage access fixups for donated memory

Jason Gunthorpe (1):
      RDMA/mlx4: Fix mis-use of RCU in mlx4_srq_event()

Jason Huang (1):
      wifi: brcmfmac: fix P2P action frame handling without device vif

Jason Xing (1):
      xsk: drain continuation descs after overflow in xsk_build_skb()

Jeff Johnson (1):
      wifi: ath12k: fix overreads in ath12k_wmi_process_csa_switch_count_event()

Jeff Layton (3):
      nfsd: fix fcache_disposal UAF by inlining dispose state into nfsd_net
      nfsd: restore rq_status_counter to even on all nfsd_dispatch() exit paths
      lockd, nfsd: RCU-protect nlmsvc_ops dispatch

Jeffrey Hugo (1):
      accel/qaic: Add config structs for supported cards

Jens Axboe (3):
      io_uring/rw: free potentially allocated iovec on cache put failure
      io_uring/napi: cap busy_poll_to 10 msec
      io_uring: defer eventfd signaling when queued from a wakeup handler

Jeongjun Park (1):
      drm/exynos: vidi: use priv->vidi_dev for ctx lookup in vidi_connection_ioctl()

Jesse Zhang (2):
      drm/amdgpu: force complete the MES ring fences on reset
      drm/amdgpu: force complete the KIQ ring fences on reset

Jeuk Kim (1):
      NFSv4/flexfiles: fix NULL dereference for NFSv4.0 data servers

Jia Jia (2):
      vhost: invalidate vring access on IOTLB transitions
      vduse: validate virtqueue alignment

Jia Zhu (1):
      erofs: fix metabuf leak in inode xattr initialization

Jiajia Liu (1):
      wifi: mt76: add wcid publish check in mt76_sta_add

Jianan Huang (1):
      f2fs: avoid reading already updated pages during GC

Jiayuan Chen (2):
      serial: core: fix infinite loop in handle_tx() for PORT_UNKNOWN
      bpf, xdp: move offload check into dev_xdp_install()

Jie Zhang (2):
      drm/msm: Recover HW before retire hung submit
      net: stmmac: fix oops when split header is enabled

Jinu Kim (1):
      KVM: x86: Use active memslots for the per-vCPU MMIO cache

Jiri Olsa (4):
      bpf: Factor callchain_store function from __bpf_get_stack
      bpf: Factor callchain_finalize function from __bpf_get_stack
      bpf: Remove trace_in argument from __bpf_get_stack
      bpf: Clear buf on error in __bpf_get_task_stack

Jiri Slaby (SUSE) (2):
      serial: rename local uart_port_lock() -> uart_port_ref_lock()
      serial: 8250: invert serial8250_register_8250_port() CIR condition

Joe Damato (1):
      bnxt: fix head underflow on XDP head-grow

Joel Fernandes (1):
      srcu: Use irq_work to start GP in tiny SRCU

Johan Hovold (5):
      spi: mpc52xx: clean up interrupt handling
      staging: most: remove broken i2c driver
      spi: ch341: fix devres lifetime
      mmc: vub300: fix use-after-free on disconnect
      mmc: vub300: rename probe error labels

Johannes Berg (7):
      wifi: iwlwifi: return ERR_PTR from opmode start()
      wifi: mac80211: don't WARN for connections on invalid channels
      wifi: iwlwifi: fix 22000 series SMEM parsing
      wifi: iwlwifi: dvm: pair transport op-mode enter/leave
      wifi: nl80211: check link is beaconing for color change
      wifi: iwlwifi: simplify nested if checks
      wifi: iwlwifi: mvm: fix P2P-Device binding handling

Johannes Thumshirn (1):
      btrfs: zoned: don't clobber the extent buffer when zeroing it out

John Johansen (2):
      apparmor: fix deadlock in complain-mode change_hat
      apparmor: fix unconfined user namespace restriction forced stack

Jon Hunter (1):
      soc/tegra: pmc: Add kerneldoc for wake-up variables

Joonas Lahtinen (1):
      drm/i915/gt: Fix NULL deref on sched_engine alloc failure

Joseph Qi (1):
      ocfs2: use correct endian in ocfs2_dinode_has_extents

Julian Anastasov (1):
      ipvs: revalidate ihl to prevent out-of-bounds access

Julian Sun (1):
      ocfs2: correct l_next_free_rec in online check

Juri Lelli (1):
      sched/deadline: Fix missing ENQUEUE_REPLENISH during PI de-boosting

Justin Iurman (1):
      net: ioam6: fix OOB and missing lock

Justin Yeh (1):
      pinctrl: mediatek: use devm_gpiochip_add_data() for GPIO chip

Jérémy Jean (3):
      tls: rx: restore msg_iter before TLS 1.3 optimistic retry
      sctp: validate cookie AUTH state before use
      NFSv4.1: zero referring call lists before decoding

Kai Huang (1):
      KVM: Export hardware virtualization enabling/disabling functions

Kairui Song (2):
      mm/mglru: use the common routine for dirty/writeback reactivation
      mm/mglru: fix and remove redundant unevictable folio handling

Kaitao Cheng (1):
      bpf: Clear rb node linkage when freeing bpf_rb_root

Kalle Valo (2):
      wifi: ath12k: convert struct ath12k_sta::update_wk to use struct wiphy_work
      wifi: ath12k: ath12k_mac_op_sta_state(): clean up update_wk cancellation

Kang Yang (1):
      wifi: ath12k: fix struct hal_rx_phyrx_rssi_legacy_info

Karl Mehltretter (5):
      tty: skip cdev_del() when no cdev is registered
      serial: core: clear freed pointers on uart_register_driver() failure
      serial: core: do fallible allocations before the console can be registered
      iommu/amd: Do not reallocate GA log buffers on resume
      tracing: Fix ring_buffer_read_page_size() kernel-doc

Karthikeyan KS (1):
      soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read

Karthikeyan Periyasamy (2):
      wifi: ath12k: fix incorrect TID updation in DP monitor status path
      wifi: ath12k: Avoid explicit type cast in monitor status parse handler

Kashyap Desai (1):
      RDMA/bnxt_re: Fix budget handling of notification queue

Kiryl Shutsemau (1):
      mm/hugetlb: refactor code around vmemmap_walk

Kohei Enju (1):
      ice: ptp: don't WARN when controlling PF is unavailable

Koichiro Den (2):
      NTB: core: Add .get_dma_dev() callback to ntb_dev_ops
      NTB: ntb_transport: Use ntb_get_dma_dev() for DMA buffers

Konstantin Khorenko (1):
      gcov: use atomic counter updates to fix concurrent access crashes

Konstantin Komarov (1):
      fs/ntfs3: Accumulated refactoring changes

Kory Maincent (TI.com) (1):
      drm/tilcdc: Fix removal actions in case of failed probe

Krystian Kaniewski (1):
      Bluetooth: hci_sysfs: Fix NULL pointer dereference in device_del()

Krzysztof Kozlowski (1):
      remoteproc: qcom_q6v5_pas: Simplify with dev_err_probe()

Kumar Kartikeya Dwivedi (8):
      bpf: Mark bpf_refcount field as unique
      bpf: Zero queue and stack outputs on lock failure
      bpf: Preserve inner map identity in callback frames
      bpf: Mark NULL kptr stores precise
      bpf: Reject legacy packet loads from callbacks
      bpf: Check ancestor frames for rbtree callbacks
      bpf: Mark syscall helpers as sleepable
      bpf: Mark signal tracepoint siginfo arguments as scalar

Kuniyuki Iwashima (16):
      net: Factorise setup_net() and cleanup_net().
      net: Add ops_undo_single for module load/unload.
      net: Add ->exit_rtnl() hook to struct pernet_operations.
      mpls: Hold dev refcnt for mpls_nh.
      mpls: Unify return paths in mpls_dev_notify().
      mpls: Add mpls_dev_rcu().
      mpls: Pass net to mpls_dev_get().
      mpls: Add mpls_route_input().
      mpls: Convert mpls_dump_routes() to RCU.
      mpls: Protect net->mpls.platform_label with a per-netns mutex.
      tcp: Remove sk->sk_prot->orphan_count.
      sockmap: Fix use-after-free in udp_bpf_recvmsg()
      amt: Don't support cross-netns setup.
      net: Remove conflicting altnames for dying netns in __dev_change_net_namespace().
      net: Fix wild-memory-access in __register_pernet_operations() when CONFIG_NET_NS=n.
      mpls: Set rt->rt_nhn just before returning from mpls_nh_build_multi().

Lama Kayal (2):
      net/mlx5: HWS, Fix memory leak in hws_pool_buddy_init error path
      net/mlx5: HWS, Fix memory leak in hws_action_get_shared_stc_nic error flow

Larysa Zaremba (2):
      ice: change XDP RxQ frag_size from DMA write length to xdp.frame_sz
      ixgbe: do not configure xps for XDP queues

Lee Jones (1):
      HID: core: Mitigate potential OOB by removing bogus memset()

Leon Hwang (1):
      bpf: Fix WARNING in bpf_tracing_link_release

Leon Romanovsky (4):
      RDMA/bnxt_re: Remove unusable nq variable
      ntb: Store original DMA address for future release
      RDMA/cxgb4: Fix dereg_skb leak and double free in write_tpt_entry()
      RDMA/rvt: Return NULL after port allocation failure

Li Chen (1):
      HID: rate-limit hid_warn to prevent log flooding

Li Nan (1):
      md: init bioset in mddev_init

Li Qiang (1):
      scsi: ufs: core: Validate string descriptors

Li Zhijian (1):
      RDMA/rxe: Fix iova-to-va conversion for MR page sizes != PAGE_SIZE

Lijo Lazar (3):
      drm/amdgpu: Skip vcn poison irq release on VF
      drm/amdgpu: Use dbg level for VBIOS check messages
      drm/amdgpu: Add wrapper for freeing vbios memory

Linfeng Sun  (1):
      vhost_iotlb: bound map allocation in add_range

Linmao Li (1):
      drm/vc4: Shut down BO cache timer before teardown

Long Li (3):
      xfs: remove bp->b_error check in xfs_attr3_root_inactive
      xfs: factor out xfs_attr3_node_entry_remove
      xfs: close crash window in attr dabtree inactivation

Lorenzo Bianconi (6):
      wifi: mt76: wed: use proper wed reference in mt76 wed driver callabacks
      net: airoha: fix BQL imbalance in TX path
      wifi: mt76: Fix memory leak destroying device
      net: airoha: Do not read uninitialized fragment address in airoha_dev_xmit()
      net: airoha: Add missing bits in airoha_qdma_cleanup_tx_queue()
      net: stmmac: fix dma mapping leak in stmmac_tso_xmit()

Lorenzo Stoakes (ARM) (2):
      mm/mremap: fix locked_vm leak by splitting VMA for MREMAP_DONTUNMAP
      mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge

Louis-Alexis Eyraud (1):
      clk: mediatek: pllfh: Fix IO remapping leak in register_pllfhs error path

Lu Baolu (1):
      iommu/vt-d: Flush context cache with correct SID when tearing down aliases

Luca Leonardo Scorcia (1):
      drm/mediatek: dsi: Store driver data before invoking mipi_dsi_host_register

Luxiao Xu (1):
      bpf: Check sk_state before sk_protocol in bpf_tcp_*_syncookie

Maaz Mombasawala (1):
      drm/vmwgfx: Stop using dev_private to store driver data.

Maciej Fijalkowski (2):
      xsk: provide sufficient space in pool->tx_descs
      xsk: reclaim invalid Tx descriptors in ZC batch path

Maher Azzouzi (1):
      esp: do not unref managed frag pages in esp_ssg_unref()

Malaya Kumar Rout (1):
      time/namespace: Validate nanosecond field in proc_timens_set_offset()

Manivannan Sadhasivam (3):
      PCI/pwrctl: Use of_platform_device_create() to create pwrctl devices
      PCI/pwrctl: Create pwrctl device only if at least one power supply is present
      net: qrtr: Drop the MHI auto_queue feature for IPCR DL channels

Maoyi Xie (1):
      wifi: mac80211: defer link RX stats percpu free to RCU

Marc Harvey (2):
      net: team: Remove unused team_mode_op, port_enabled
      net: team: Rename port_disabled team mode op to port_tx_disabled

Marc Zyngier (1):
      KVM: arm64: vgic: Handle race between interrupt affinity change and LPI disabling

Marco Scardovi (1):
      platform/x86: asus-wmi: fix resource leaks on probe failure

Marek Szyprowski (1):
      clocksource/drivers/samsung_pwm: Switch to raw_spinlock_t type

Mario Limonciello (3):
      drm/amd: Create a device link between APU display and XHCI devices
      platform/x86/amd: pmf: Use device managed allocations
      drm/amdgpu: Release VFCT ACPI table reference

Mark Tomlinson (1):
      gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock

Martin Kaiser (1):
      riscv: trace: fix snapshot deadlock with sbi ecall

Masami Hiramatsu (Google) (1):
      tracing/probes: Remove WARN_ON_ONCE from parse_btf_arg

Mathieu Dubois-Briand (1):
      gpiolib: Allow to use setters with return value for output-only gpios

Matt Bobrowski (1):
      bpf: Fix UAF in sock clone early bailouts

Matthew Brost (1):
      drm/xe: Don't allow evicting of BOs in same VM in array of VM binds

Matthew Rosato (2):
      iommu/s390: handle IOAT registration based on domain
      iommu/s390: set appropriate IOTA region type

Matthew Wilcox (Oracle) (2):
      ceph: Remove call to PagePrivate2()
      ceph: Remove uses of page from ceph_process_folio_batch()

Mattia Meleleo (1):
      bpf, sockmap: Account for receive queue in FIONREAD without a verdict program

Maurizio Lombardi (1):
      nvmet: fix max_qid race between configfs and controller allocation

Max Kellermann (2):
      ceph: fix crash after fscrypt_encrypt_pagecache_blocks() error
      ceph: always call ceph_shift_unused_folios_left()

Menglong Dong (1):
      rcu: add rcu_read_lock_dont_migrate()

Miaoqian Lin (1):
      rxrpc, afs: Fix missing error pointer check after rxrpc_kernel_lookup_peer()

Miaoqing Pan (1):
      wifi: ath12k: fix memory leak in ath12k_wifi7_dp_rx_h_verify_tkip_mic()

Michael Bommarito (3):
      xen/pvcalls: bound backend response req_id before indexing rsp[]
      idpf: bound interrupt-vector register fill to the allocated array
      ceph: cap delegated inode count in ceph_parse_deleg_inos()

Michael Chan (2):
      bnxt_en: Update firmware interface spec to 1.10.3.85
      bnxt_en: Disable EOP for TPA on all chips to prevent data corruption

Michael Kelley (1):
      Drivers: hv: vmbus: Skip VMBus module cleanup for non-nested root partition

Michael S. Tsirkin (1):
      virtio: break and reset virtio devices on device_shutdown()

Michal Schmidt (1):
      ice: fix double-free of tx_buf skb

Mike Snitzer (1):
      NFS/localio: prevent direct reclaim recursion into NFS via nfs_writepages

Mikhail Gavrilov (2):
      Bluetooth: RFCOMM: connect the session socket without rfcomm_mutex
      drm/amd/display: Wrap DCN32 phantom-plane allocation in DC_RUN_WITH_PREEMPTION_ENABLED

Mikhail Lobanov (1):
      f2fs: read COW data with the original inode during atomic write

Mikulas Patocka (3):
      dm-integrity: use internal variable for digestsize
      dm-integrity: rename internal_hash
      dm-verity: fix buffer overflow in FEC calculation

Ming Lei (2):
      ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd
      ublk: fix dead loop when canceling io command

Ming Qian (2):
      media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC
      media: verisilicon: Fix kernel panic due to __initconst misuse

Miquel Raynal (1):
      spi: microchip-core-qspi: Support per spi-mem operation frequency switches

Miquel Sabaté Solà (1):
      btrfs: fix double free of qgroup record after failure to add delayed ref head

Morduan Zang (2):
      net: phonet: do not BUG_ON() in pn_socket_autobind() on failed bind
      iomap: guard io_size EOF trim against concurrent truncate underflow

Mostafa Saleh (1):
      firmware: arm_ffa: Fix out-of-bound writes in ffa_setup_and_transmit()

Muchun Song (2):
      mm/hugetlb: initialize gigantic bootmem hugepage struct pages earlier
      mm/hugetlb_vmemmap: fix incorrect vmemmap restore in rollback

Murad Masimov (1):
      ax25: Remove broken autobind

Namjae Jeon (6):
      ksmbd: prevent path traversal bypass by restricting caseless retry
      ksmbd: scope session state changes to bound connections
      ksmbd: detach blocked lock requests before freeing
      ksmbd: safely discard unregistered deferred locks
      ksmbd: serialize oplock close with pending break ownership
      ksmbd: fix maximum allowed access checks

Nicholas Carlini (1):
      ksmbd: fix signededness bug in smb_direct_prepare_negotiation()

Nicholas Dudar (3):
      LoongArch: BPF: Zero-extend signed ALU32 div/mod results
      bpf: Reject rdonly/rdwr_buf_size kfunc arguments that exceed u32 max
      bpf: Reject writes through untrusted BTF pointers

Nicholas Kazlauskas (1):
      drm/amd/display: Adjust PHY FSM transition to TX_EN-to-PLL_ON for TMDS on DCN35

Nicolas Dichtel (2):
      net: rename netns_local to netns_immutable
      net: plumb extack in __dev_change_net_namespace()

Nicolas Dufresne (1):
      media: v4l2-mem2mem: Add a kref to the v4l2_m2m_dev structure

Nicolin Chen (2):
      iommu/tegra241-cmdqv: Fix VINTF0 leak on the init-failure path
      iommu/tegra241-cmdqv: Don't fall back to a freed smmu after devm_krealloc()

Niklas Cassel (1):
      ata: libata-core: Disable LPM on Silicon Motion MD619{H,G}XCLDE3TC

Niklas Schnelle (1):
      iommu/s390: Make attach succeed when the device was surprise removed

Nikolay Aleksandrov (2):
      vxlan: fix reading neigh ha
      net: bridge: arp/nd proxy: fix reading neigh ha

Ning Ding (2):
      bpf: Compare iterator types during state pruning
      bpf: Keep refcount_acquire nullable for borrowed RCU kptrs

Nitin Rawat (3):
      scsi: ufs: qcom : Refactor phy_power_on/off calls
      scsi: ufs: ufs-qcom: Fix UFS OCP issue during UFS power down (PC=3)
      scsi: ufs: qcom : Fix NULL pointer dereference in ufs_qcom_setup_clocks

Norbert Szetei (1):
      xfs: stop exchanging reflink flags when exchanging mappings

Oleh Konko (1):
      Bluetooth: hci_event: move wake reason storage into validated event handlers

Olivier Langlois (4):
      io_uring/napi: protect concurrent io_napi_entry timeout accesses
      io_uring/napi: improve __io_napi_add
      io_uring/napi: Use lock guards
      io_uring/napi: clean up __io_napi_do_busy_loop

Orange Kao (1):
      EDAC/igen6: Add polling support

Osama Abdelkader (1):
      riscv: kvm: fix vector context allocation leak

P Praneesh (1):
      wifi: ath12k: Avoid memory leak while enabling statistics

Pablo Neira Ayuso (5):
      netfilter: nf_tables: clone set on flush only
      netfilter: nat: use kfree_rcu to release ops
      netfilter: nf_conntrack_expect: use conntrack GC to reap expectations
      netfilter: nf_tables: skip double clone set expressions on element insert
      netfilter: ctnetlink: do not expose expectation DEAD flag

Pankaj Gupta (1):
      KVM: SEV: Drop FOLL_WRITE for encrypted region registration

Pauli Virtanen (10):
      Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if exists
      Bluetooth: hci_sync: extend conn_hash lookup critical sections
      Bluetooth: hci_sync: hold conn in hci_connect_pa_sync() callback
      Bluetooth: hci_sync: hold conn in hci_connect_big_sync() callback
      Bluetooth: ISO: hold sk properly in iso_conn_ready
      Bluetooth: ISO: lock sk in iso_connect_ind
      Bluetooth: hci_sync: hold conn in hci_connect_acl/le_sync() callbacks
      Bluetooth: L2CAP: access chan->conn safely in get/setsockopt
      Bluetooth: ISO: fix race of kfree vs kref_get_unless_zero
      Bluetooth: L2CAP: use proto_lock for l2cap_data to fix l2cap_disconn_ind

Paulo Alcantara (5):
      smb: client: improve compound padding in encryption
      smb: client: get rid of bounds check in SMB2_ioctl_init()
      smb: client: fix compound alignment with encryption
      smb: client: avoid using uninitialized SIDs in cifs_posix_to_fattr()
      smb: client: honor forceuid/forcegid when mapping SIDs to uid/gid

Pavan Chebbi (1):
      fwctl/bnxt_en: Refactor aux bus functions to be more generic

Peilin Ye (3):
      bpf: Factor out atomic_ptr_type_ok()
      bpf: Factor out check_atomic_rmw()
      bpf: Factor out check_load_mem() and check_store_reg()

Peiyang He (1):
      iommu/iommufd: Fix IOPF group ownership UAF

Pengpeng Hou (3):
      rxrpc: proc: size address buffers for %pISpc output
      bnxt_en: set backing store type from query type
      genirq/proc: Size interrupt directory names for 10-digit interrupt numbers

Peter Ujfalusi (4):
      ASoC: SOF: Relocate and rework functionality for PCM stream freeing
      ASoC: SOF: pcm: Move period/buffer configuration print after platform open
      ASoC: SOF: pcm: Add snd_sof_pcm specific wrappers for dev_dbg() and dev_err()
      ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in case of IPC timeout

Peter Wang (1):
      scsi: ufs: core: Add debug log for MCQ command timeout

Petr Oros (1):
      dpll: fix NULL deref in dpll_device_ops() during teardown race

Petr Wozniak (1):
      xfrm: fix stale skb->prev after async crypto steals a GSO segment

Philipp Stanner (2):
      drm/sched: Use struct for drm_sched_init() params
      drm/panfrost: Fix scheduler workqueue bug

Philippe Simons (1):
      clk: sunxi-ng: h616: Reparent GPU clock during frequency changes

Ping-Ke Shih (2):
      wifi: rtw89: pci: configure manual DAC mode via PCI config API only
      wifi: rtw89: pci: validate sequence number of TX release report

Prasanna Kumar T S M (1):
      soc: xilinx: Fix race condition in event registration

Prathamesh Shete (1):
      soc/tegra: pmc: Fix unsafe generic_handle_irq() call

Priya Hosur (1):
      drm/amdkfd: Add TLB flush after MES queue eviction/suspension

Pu Lehui (1):
      mm: fix uprobe pte be overwritten when expanding vma

Qihang (1):
      KVM: arm64: vgic-v3: take an LPI reference in vgic_v3_save_pending_tables

Qing Ming (2):
      cgroup/rstat: validate cpu before css_rstat_cpu() access
      usb: gadget: uac: validate rate list length before storing

Qiuxu Zhuo (5):
      EDAC/igen6: Initialize edac_op_state according to the configuration data
      EDAC/igen6: Skip absent memory controllers
      EDAC/igen6: Fix call trace due to missing release()
      EDAC/igen6: Fix the flood of invalid error reports
      EDAC/igen6: Fix NULL pointer dereference

Qu Wenruo (5):
      btrfs: do not ASSERT() when the fs flips RO inside btrfs_repair_io_failure()
      btrfs: only release the dirty pages io tree after successful writes
      btrfs: initialize inode mapping flags for cached inodes
      btrfs: qgroup: fix a wrong length calculation in qgroup_free_reserved_data()
      btrfs: always wait for ordered extents to avoid OE races

Radek Podgorny (1):
      Bluetooth: do not leak an hci_conn when a second LE connect is rejected

Rafael J. Wysocki (11):
      thermal: hwmon: Remove hwmon class device along with its parent
      ACPI: bus: Introduce acpi_bus_get_primary_device()
      PM: sleep: core: Synchronize runtime PM status of parents and children
      PM: sleep: core: Restrict power.set_active propagation
      PM: Rearrange documentation related to __pm_runtime_disable()
      PM: Block enabling of runtime PM during system suspend
      PM: runtime: Introduce pm_runtime_blocked()
      PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally
      driver core: Add device_link_test() for testing device link flags
      ACPI: platform: Use acpi_bus_get_primary_device()
      soundwire: intel_auxdevice: Fix system suspend/resume handling

Ralph Boehme (1):
      smb/client: fix chown/chgrp with SMB3 POSIX Extensions

Raphael Zimmer (1):
      libceph: Fix potential out-of-bounds access in __ceph_x_decrypt()

Ray Wu (1):
      drm/amd/display: disable replay when crc source is enabled

Reinette Chatre (1):
      fs/resctrl: Prevent use-after-free in rdtgroup_kn_put()

Ritesh Harjani (IBM) (2):
      powerpc/64s: Fix unmap race with PMD migration entries
      powerpc/pgtable-frag: Fix bad page state in pte_frag_destroy

Roger Quadros (2):
      net: ethernet: ti: am65-cpsw: streamline RX queue creation and cleanup
      dmaengine: ti: k3-udma-glue: Drop skip_fdq argument from k3_udma_glue_reset_rx_chn

Rosen Penev (3):
      net: ibm: emac: use devm_platform_ioremap_resource
      net: ibm: emac: use platform_get_irq
      net: emac: Fix NULL pointer dereference in emac_probe

Runyu Xiao (1):
      ALSA: mtpav: shut down output timer before card teardown

Ruoyu Wang (3):
      bnxt_en: Handle partially initialized auxiliary devices
      drm/msm: Only fini scheduler after successful init
      gpiolib: initialize return value in gpiochip_set_multiple()

Sabrina Dubroca (2):
      mpls: add seqcount to protect the platform_label{,s} pair
      selftests: tls: add rekey tests

Sajal Gupta (1):
      drm/gud: validate GUD_ROTATION_0 is present in supported rotations

Salman Alghamdi (1):
      staging: rtl8723bs: rtw_mlme: add bounds checks before ie_length subtraction

Sam Edwards (1):
      ceph: fix num_ops off-by-one when crypto allocation fails

Samuel Holland (2):
      riscv: Enable cbo.zero only when all harts support Zicboz
      riscv: Add support for per-thread envcfg CSR values

Sanghyun Park (1):
      bpf: Fix mmap_lock leak in irq_work path

Sarika Sharma (4):
      wifi: ath12k: Fix MSDU buffer types handling in RX error path
      wifi: mac80211: fix missing RX bitrate update for mesh forwarding path
      wifi: mac80211: refactor populating mesh related fields in sinfo
      wifi: cfg80211: add link_station_info structure to support MLO statistics

Satyanarayana K V P (1):
      drm/xe/guc: Add devm release action to safely tear down CT

Sean Christopherson (8):
      KVM: SEV: Protect *all* of sev_mem_enc_register_region() with kvm->lock
      KVM: x86: Rename "governed features" helpers to use "guest_cpu_cap"
      KVM: guest_memfd: Treat memslot binding offset+size as unsigned values
      KVM: x86: Drop superfluous kvm_lapic_set_base() call when setting APIC state
      KVM: x86: Move kvm_set_apic_base() implementation to lapic.c (from x86.c)
      KVM: x86: Rename APIC base setters to better capture their relationship
      KVM: x86: Move update_cr8_intercept() to lapic.c
      KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails due to invalid guest state

Sean Wang (2):
      wifi: mt76: connac: tolerate inactive BSS deactivation
      wifi: mt76: mt7925: fix potential deadlock in mt7925_roc_abort_sync

Sebastian Ene (1):
      firmware: arm_ffa: Fix Endpoint Memory Access Descriptor offset calculation

Selvin Xavier (5):
      RDMA/bnxt_re: Avoid repeated requests to allocate WC pages
      RDMA/bnxt_re: Add a max slot check for SQ
      RDMA/bnxt_re: Free CQ toggle page after firmware teardown
      RDMA/bnxt_re: Free SRQ toggle page after firmware teardown
      RDMA/bnxt_re: Initialize dpi variable to zero

Shardul Bankar (1):
      wireguard: device: use exit_rtnl callback instead of manual rtnl_lock in pre_exit

Shibo Zhu (1):
      PM: sleep: Unblock runtime PM when device prepare fails

Shukai Ni (1):
      dm-integrity: replace forgeable discard filler with a keyed sector marker

Shyam Sundar S K (1):
      platform/x86/amd/pmf: Switch to platform_get_resource() and devm_ioremap_resource()

Sicong Huang (1):
      virt: acrn: Fix irqfd use-after-free during eventfd shutdown

Sidhanta Sahu (1):
      wifi: ath12k: Fix memory leak due to multiple rx_stats allocation

Srinivas Kandagatla (1):
      ASoC: qcom: q6asm: handle the responses after closing

Srinivasan Shanmugam (2):
      drm/amd/display: Fix NULL pointer dereference in dcn401_init_hw()
      drm/amd/display: Fix dc_link NULL handling in HPD init

Sriram R (1):
      wifi: ath12k: prepare vif data structure for MLO handling

Stanislav Fomichev (1):
      xsk: honor XDP_TX_METADATA in zero-copy path

Stanley Chu (6):
      i3c: master: svc: Fix npcm845 FIFO empty issue
      i3c: master: svc: Fix npcm845 invalid slvstart event
      i3c: master: svc: Prevent IRQ storm from false SLVSTART on NPCM845
      i3c: master: svc: Fix missed IBI after false SLVSTART on NPCM845
      i3c: master: svc: Fix npcm845 FIFO_EMPTY quirk
      i3c: master: svc: Fix i3c_master_get_free_addr return check

Stanley Jhu (2):
      scsi: ufs: core: Decouple CQ sweep from request iterator in MCQ
      scsi: ufs: core: Avoid unsafe MMIO reads in ufshcd_mcq_compl_all_cqes_lock()

Stefan Metzmacher (1):
      smb: client: let recv_done verify data_offset, data_length and remaining_data_length

Steffen Klassert (1):
      Revert "esp: do not unref managed frag pages in esp_ssg_unref()"

Stepan Ionichev (1):
      tty: serial: 8250: protect against NULL uart->port.dev in register

Stephan Gerhold (1):
      remoteproc: qcom: pas: Shutdown lite ADSP DTB on X1E

Stephen Smalley (1):
      selinux: allow multiple opens of /sys/fs/selinux/policy

Steven Rostedt (3):
      eventfs: Use children field for rcu head and add memory barriers
      xfs: remove unused trace event xfs_dqreclaim_dirty
      tracing: Fix comment in tracing_buffers_splice_read()

Sudeep Holla (2):
      firmware: arm_scmi: Fix SCMI device destroy lifetimes
      firmware: arm_ffa: Add support for IMPDEF value in the memory access descriptor

Sun YangKai (1):
      btrfs: check if root is readonly when setting posix acl

Suraj Gupta (1):
      net: xilinx: axienet: Free outstanding DMA buffers on dmaengine stop

Suravee Suthikulpanit (1):
      iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported

Suren Baghdasaryan (2):
      types: move struct rcuwait into types.h
      refcount: provide ops for cases when object's memory can be reused

Szymon Wilczek (1):
      ntfs3: fix circular locking dependency in run_unpack_ex

Takashi Iwai (2):
      ALSA: seq: Clean up fifo locking with guard
      ALSA: seq: oss: Fix UAF at handling events with embedded SysEx data

Tamizh Chelvam Raja (1):
      wifi: ath12k: Pass ab pointer directly to ath12k_dp_tx_get_encap_type()

Tao Cui (1):
      RDMA/counter: Fix num_counters leak on bind_qp failure in alloc_and_bind()

Tatsuya S (1):
      HID: core: Add reserved item tag for main items

Tejun Heo (3):
      sched_ext: Fix CPU hotplug hang when a dying CPU's tasks sit in the BPF scheduler
      sched_ext: Don't warn on core-sched forced idle in put_prev_task_scx()
      sched/psi: Create the psimon kthread outside of cgroup_mutex

Terry Bowman (1):
      cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability size

Tetsuo Handa (2):
      team: avoid NETDEV_CHANGEMTU event when unregistering slave
      printk: Don't WARN on kthread_run failure.

Thierry Reding (2):
      syscore: Pass context data to callbacks
      soc/tegra: pmc: Document tegra_pmc.syscore field

Thomas Gleixner (2):
      irqwork: Move data struct to a types header
      genirq/proc: Switch to lock guards

Thomas Zimmermann (2):
      drm/vc4: Use video aperture helpers
      fbdev: Wrap user-invoked calls to fb_set_var() in helper

Tiezhu Yang (1):
      LoongArch: BPF: Refactor jump offset calculation in tail call

Toke Høiland-Jørgensen (1):
      wifi: atk9k: Revert "wifi: ath9k: reject short WMI command responses"

Tomasz Rusinowicz (1):
      accel/ivpu: Allow to import single buffer into multiple contexts

Tony Battersby (1):
      scsi: qla2xxx: Clear cmds after chip reset

Uladzislau Rezki (Sony) (1):
      mm/vmalloc, mm/kasan: respect gfp mask in kasan_populate_vmalloc()

Usama Arif (3):
      mm/huge_memory: transfer the pmd dirty bit to the folio on zap
      blk-iocost: clear delay state when freeing policy data
      blk-iolatency: clear delay state when freeing policy data

Uwe Kleine-König (1):
      remoteproc: Switch back to struct platform_driver::remove()

Val Packett (1):
      remoteproc: qcom_wcnss: Fix handling the lack of PD regulators in v3

Valery Borovsky (1):
      media: stm32-dcmipp: Return queued buffers on start_streaming() failure

Viacheslav Dubeyko (3):
      ceph: extend ceph_writeback_ctl for ceph_writepages_start() refactoring
      ceph: introduce ceph_process_folio_batch() method
      ceph: introduce ceph_submit_write() method

Vicki Pfau (1):
      HID: steam: Reject short reads

Victor Nogueira (1):
      net/sched: act_ife: Only operate on Ethernet frames

Victor Skvortsov (1):
      drm/amdgpu: Update SRIOV Exchange Headers for RAS Telemetry Support

Ville Syrjälä (2):
      drm/i915/vga: Convert VGA code to intel_display
      drm/i915: Grab intel_display from the encoder to avoid potential oopsies

Vincent Donnefort (1):
      tracing: Fix subbuf resize races with trace_pipe_raw readers

Vivek Kasireddy (1):
      drm/virtio: Add a helper to map and note the dma addrs and lengths

Vivian Wang (1):
      riscv: patch: Avoid early phys_to_page()

Vlad Dogaru (4):
      net/mlx5: HWS, handle returned error value in pool alloc
      net/mlx5: HWS, Remove unused element array
      net/mlx5: HWS, Make pool single resource
      net/mlx5: HWS, Refactor pool implementation

Vladimir Riabchun (1):
      scsi: qla2xxx: Completely fix fcport double free

Wei Fang (1):
      net: tap: fix wrong transport_header when sending VLAN-tagged frame

Wei Xu (1):
      mm/mglru: reset page lru tier bits when activating

Wei Zhang (1):
      wifi: ath11k: cancel SSR work items during PCI shutdown

Wei-Jie Hung (1):
      riscv: patch: fix handling of bpf-jit execmem addresses

Weili Qian (2):
      crypto: hisilicon/hpre - enable all clusters clock gating
      crypto: hisilicon/qm - request reserved interrupt for virtual function

Weiming Shi (5):
      net: team: fix NULL pointer dereference in team_xmit during mode change
      net: team: stop reusing skb after queue override
      tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR
      tipc: serialize udp bearer replicast list updates
      btrfs: lzo: reject compressed segment that overflows the compressed input

Wentao Liang (1):
      drm/vc4: Fix firmware reference leak in vc4_drm_bind()

Will Deacon (1):
      arm64: ptrace: Keep 'orig_x0' in-sync with x0 on syscall entry

William Liu (1):
      net/sched: Fix backlog accounting in qdisc_dequeue_internal

William Palacek (1):
      drm/amdkfd: Add bounds check for CRAT subtype length

Wludzik, Jozef (1):
      accel/ivpu: Fix race condition when mapping dmabuf

Xiaogang Chen (2):
      drm/amdkfd: Fix the case that vm range is hole at svm_migrate_copy_to_vram
      drm/amdkfd: Fix error path at svm_migrate_copy_to_ram

Xiaoqi Zhuang (1):
      coresight: ETR: Fix ETR buffer use-after-free issue

Xin Long (3):
      sctp: validate embedded INIT chunk and address list lengths in cookie
      sctp: fix addr_wq_timer race in sctp_free_addr_wq()
      sctp: add INIT verification after cookie unpacking

Xiubo Li (1):
      ceph: fix UAF in check_new_map() on session freed during unlock

Xuanqiang Luo (1):
      ice: fix use-after-free in dynamic port cleanup

Yang Xiuwei (1):
      scsi: sd: Fix special_vec mempool leak when scsi_alloc_sgtables() fails

Yang Yingliang (1):
      spi: ch341: switch to use devm_spi_alloc_host()

Ye Liu (1):
      mm/page_owner: use memcg_data snapshot to avoid TOCTOU in print_page_owner_memcg()

Yeoreum Yun (3):
      coresight: holding cscfg_csdev_lock while removing cscfg from csdev
      coresight-tmc: change tmc_drvdata spinlock's type to raw_spinlock_t
      coresight: etm4x: missing cscfg_csdev_disable_active_config() in perf enable

Yevgeny Kliteynik (4):
      net/mlx5: HWS, denote how refcounts are protected
      net/mlx5: HWS, simplify allocations as we support only FDB
      net/mlx5: HWS, update flow - remove the use of dual RTCs
      net/mlx5: HWS, fix bad parameter in CQ creation

Yichong Chen (1):
      netfs: release readahead folios on iterator preparation failure

Yicong Yang (1):
      coresight: tmc-etr: Fix race condition between sysfs and perf mode

Yifan Zhang (1):
      amd/amdkfd: enhance kfd process check in switch partition

Yihang Li (1):
      scsi: hisi_sas: Add slave_destroy interface for v3 hw

Yinjie Yao (1):
      drm/amdgpu/vcn: set no_user_fence for VCN v4.0 enc ring

Yishai Hadas (1):
      RDMA/mlx5: Remove the redundant MLX5_IB_STAGE_UAR stage

Yiyang Chen (3):
      bpf: Guard conntrack opts error writes
      bpf: Check pointer type for all atomic RMW paths
      bpf: Reject MEM_ALLOC BTF accesses past object bounds

Yonatan Nachum (1):
      RDMA/efa: Fix use of completion ctx after free

Yonghong Song (1):
      bpf: Reject >8 byte return values on return-reading trampoline paths

Yongpeng Yang (3):
      f2fs: fix fsck inconsistency caused by FGGC of node block
      f2fs: fix data loss caused by incorrect use of nat_entry flag
      f2fs: fix fsck inconsistency caused by incorrect nat_entry flag usage

Yongqiang Sun (3):
      drm/amdkfd: clamp v9 CRIU control stack checkpoint copy to BO size
      drm/amdkfd: Fix infinite loop parsing CRAT with zero subtype length
      drm/amdkfd: fix SMI event cross-process information leak

Yosry Ahmed (4):
      KVM: SVM: Add missing save/restore handling of LBR MSRs
      KVM: nSVM: Always use NextRIP as vmcb02's NextRIP after first L2 VMRUN
      KVM: nSVM: Avoid clearing VMCB_LBR in vmcb12
      KVM: nSVM: Triple fault if restore host CR3 fails on nested #VMEXIT

Yu Kuai (1):
      blk-cgroup: delay freeing policy data after rcu grace period

Yufan Chen (1):
      ocfs2/heartbeat: fix slot mapping rollback leaks on error paths

Yuho Choi (2):
      net/liquidio: drop cached VF pci_dev LUT
      dmaengine: idxd: fix double free of wq, engine, and group structs

Yun Zhou (1):
      xfs: handle NULL b_addr in xfs_buf_free

Yunhui Cui (1):
      perf/dwc_pcie: fix duplicate pci_dev devices

Yunseong Kim (1):
      ksmbd: fix slab-out-of-bounds read in ksmbd_alloc_user()

Yunxiang Li (1):
      drm/amdgpu/ras: add ras_suspend callback and use it for cp_ecc_error_irq

Zack Rusin (1):
      drm/vmwgfx: validate pitch coming from userspace

Zhang Cen (1):
      ocfs2: validate fast symlink target during inode read

Zhao Li (5):
      wifi: mac80211: capture fast-RX rate before mesh reuses skb->cb
      wifi: mac80211: validate extension-frame layout before RX
      wifi: ieee80211: validate MLE common info length
      wifi: cfg80211: stop PMSR before P2P and NAN teardown
      wifi: nl80211: clean up color-change beacon data on errors

Zhen Ni (1):
      iommu/amd: Fix ivrs_base memleak in early_amd_iommu_init()

Zheng Qixing (1):
      blk-cgroup: fix race between policy activation and blkg destruction

ZhengYuan Huang (2):
      ocfs2: validate DIO orphan slot during inode read
      ocfs2: validate orphan slot during inode read

Zhenzhong Duan (1):
      iommu/vt-d: Avoid NULL pointer dereference or refcount corruption

Zhi Wang (1):
      drm/nouveau: fix a use-after-free in r535_gsp_rpc_push()

Zhiling Zou (1):
      mm/page_table_check: skip special zero mappings

Zhongqiu Han (1):
      scsi: ufs: core: Fix data race in CPU latency PM QoS request handling

Zide Chen (1):
      perf/x86/intel/uncore: Fix uncore_box ref/unref ordering

