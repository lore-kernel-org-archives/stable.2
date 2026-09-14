Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DD0443A89;
	Mon, 14 Sep 2026 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387160; cv=none; b=PWiN5Wf9jwAC9y+yFeX4lZR71by3BtDignavydpqKS5RO+oRkNwU593mOhqArGNWyv+4nHOp4j4vrTJhBEU3sRTxrY+hlxqe+fNOfSMD5nRfOf+V1xHfQjDmnf1U8nwOMlHwkqePSa08JooGvYF8x+gQul+Rj0ve2xPDJNMhs3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387160; c=relaxed/simple;
	bh=juJ6Z6fFc322U1/XhIccOfRxbxk5blbzmSFpU0ORGWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A7u8WNlapu8S9vXDH7jj/vqkFmeBiXTGZupvldtZTCMs3bJolH9KOAswGoZT4MI+0U2VzjhFNPgvKBgyPhKCBDfsKRQyVazfuoUPDT7fn/btSfOxt6rfDyM0wDyA7CXpfbb+3PsmZcmacq2WitiSjyeyPE8QOf1suue/cNOdHLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bg8pc7tU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bg8pc7tU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E0C1F008A4;
	Mon, 14 Sep 2026 11:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789387120;
	bh=LTltkrcRyEsDTOVRtSWSVqv0TVtOduqq6T16GFTqQxY=;
	h=From:To:Cc:Subject:Date;
	b=Bg8pc7tUyjZ42S3+hduogxnQKTQtmV4xAyOeXnFVSWtcQyM9iz+zeUmbzqArX5RyG
	 vCLLdVGt2FKPNJzymGB7GqEgkE+1kYLDz4fpzE5CnoP02QInnOEdQpWIGRohDGoIxk
	 aPvVVFxJb9rfF2upSABY/SKdogJWswCcd/FhRvhA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.110
Date: Mon, 14 Sep 2026 13:58:11 +0200
Message-ID: <2026091412-pavilion-curfew-0637@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.110 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/configfs-usb-gadget-uac1_legacy                     |    3 
 Documentation/admin-guide/cgroup-v1/memory.rst                                |   49 
 Documentation/admin-guide/kernel-parameters.txt                               |   12 
 Documentation/admin-guide/mm/memory-hotplug.rst                               |    4 
 Documentation/admin-guide/pm/amd-pstate.rst                                   |    4 
 Documentation/hwmon/emc1403.rst                                               |    8 
 Documentation/usb/gadget-testing.rst                                          |    3 
 Documentation/userspace-api/media/v4l/ext-ctrls-colorimetry.rst               |   12 
 MAINTAINERS                                                                   |    1 
 Makefile                                                                      |    2 
 arch/Kconfig                                                                  |    3 
 arch/arm/boot/dts/allwinner/sun4i-a10.dtsi                                    |    2 
 arch/arm/boot/dts/marvell/armada-388-helios4.dts                              |   13 
 arch/arm/kernel/hw_breakpoint.c                                               |   11 
 arch/arm/mach-imx/src.c                                                       |    3 
 arch/arm/mach-lpc32xx/common.c                                                |    5 
 arch/arm/mach-lpc32xx/common.h                                                |    2 
 arch/arm/mach-lpc32xx/phy3250.c                                               |    2 
 arch/arm/mach-lpc32xx/pm.c                                                    |    5 
 arch/arm/mm/fault.c                                                           |   16 
 arch/arm64/Kconfig                                                            |    3 
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi                       |    4 
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts                                |    4 
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                                    |    3 
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi                              |    8 
 arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi                        |    4 
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts                        |    3 
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts                            |    2 
 arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi                     |    4 
 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts                             |    5 
 arch/arm64/boot/dts/qcom/msm8998.dtsi                                         |   24 
 arch/arm64/boot/dts/qcom/qcm2290.dtsi                                         |    1 
 arch/arm64/boot/dts/qcom/qcs404.dtsi                                          |   16 
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi                                  |    4 
 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts                           |   57 
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts                                   |   56 
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                                         |   16 
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                                     |    4 
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts                    |    2 
 arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts                            |    2 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                                          |   64 
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts                             |    6 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi                      |    2 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                                          |   48 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                                          |   97 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                                        |    4 
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi                       |    3 
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi                                      |    2 
 arch/arm64/include/asm/pgtable.h                                              |    8 
 arch/arm64/include/asm/ptdump.h                                               |   22 
 arch/arm64/kernel/hibernate.c                                                 |   16 
 arch/arm64/kvm/Kconfig                                                        |    4 
 arch/arm64/lib/Makefile                                                       |    4 
 arch/arm64/mm/Makefile                                                        |    2 
 arch/arm64/mm/fault.c                                                         |   12 
 arch/arm64/mm/ptdump.c                                                        |   60 
 arch/csky/kernel/entry.S                                                      |    6 
 arch/loongarch/Kconfig                                                        |    2 
 arch/loongarch/configs/loongson3_defconfig                                    |    5 
 arch/loongarch/include/asm/kvm_host.h                                         |    1 
 arch/loongarch/kernel/acpi.c                                                  |    3 
 arch/loongarch/kernel/kprobes.c                                               |    3 
 arch/loongarch/kernel/rethook_trampoline.S                                    |    2 
 arch/loongarch/kvm/main.c                                                     |    6 
 arch/loongarch/kvm/mmu.c                                                      |   10 
 arch/loongarch/kvm/vcpu.c                                                     |    6 
 arch/loongarch/kvm/vm.c                                                       |    1 
 arch/m68k/emu/nfcon.c                                                         |    2 
 arch/m68k/kernel/traps.c                                                      |    4 
 arch/mips/kernel/ptrace.c                                                     |    6 
 arch/parisc/kernel/head.S                                                     |    1 
 arch/powerpc/Kconfig                                                          |    4 
 arch/powerpc/configs/85xx-hw.config                                           |    1 
 arch/powerpc/include/asm/papr-watchdog.h                                      |   64 
 arch/powerpc/include/asm/thread_info.h                                        |    9 
 arch/powerpc/include/asm/vdso_datapage.h                                      |   24 
 arch/powerpc/kernel/asm-offsets.c                                             |    2 
 arch/powerpc/kernel/ima_arch.c                                                |    5 
 arch/powerpc/kernel/interrupt.c                                               |    4 
 arch/powerpc/kernel/irq.c                                                     |   16 
 arch/powerpc/kernel/secure_boot.c                                             |   11 
 arch/powerpc/kernel/smp.c                                                     |    3 
 arch/powerpc/kernel/vdso.c                                                    |   16 
 arch/powerpc/kernel/vdso/cacheflush.S                                         |    2 
 arch/powerpc/kernel/vdso/datapage.S                                           |    4 
 arch/powerpc/kernel/vdso/getrandom.S                                          |    3 
 arch/powerpc/kernel/vdso/gettimeofday.S                                       |    5 
 arch/powerpc/kernel/vdso/vdso32.lds.S                                         |    2 
 arch/powerpc/kernel/vdso/vdso64.lds.S                                         |    2 
 arch/powerpc/kexec/crash.c                                                    |    2 
 arch/powerpc/kexec/file_load_64.c                                             |    2 
 arch/powerpc/kexec/ranges.c                                                   |   12 
 arch/powerpc/mm/Makefile                                                      |    2 
 arch/powerpc/mm/book3s64/radix_pgtable.c                                      |    7 
 arch/powerpc/mm/ptdump/ptdump.c                                               |   46 
 arch/powerpc/platforms/pseries/setup.c                                        |   28 
 arch/riscv/Kconfig                                                            |    2 
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi                                        |    2 
 arch/riscv/include/asm/kexec.h                                                |    5 
 arch/riscv/kernel/Makefile                                                    |    2 
 arch/riscv/kernel/cpufeature.c                                                |    3 
 arch/riscv/kernel/elf_kexec.c                                                 |  485 ----
 arch/riscv/kernel/kexec_elf.c                                                 |  144 +
 arch/riscv/kernel/machine_kexec_file.c                                        |  368 +++
 arch/riscv/mm/Makefile                                                        |    2 
 arch/riscv/mm/ptdump.c                                                        |   46 
 arch/riscv/net/bpf_jit_comp64.c                                               |    5 
 arch/riscv/net/bpf_jit_core.c                                                 |    1 
 arch/s390/Kconfig                                                             |    5 
 arch/s390/include/asm/irqflags.h                                              |   20 
 arch/s390/include/asm/thread_info.h                                           |   21 
 arch/s390/kernel/Makefile                                                     |    2 
 arch/s390/kernel/debug.c                                                      |   10 
 arch/s390/kernel/ima_arch.c                                                   |   14 
 arch/s390/kernel/ipl.c                                                        |    6 
 arch/s390/kernel/irqflags.c                                                   |   28 
 arch/s390/kvm/guestdbg.c                                                      |    9 
 arch/s390/kvm/interrupt.c                                                     |    2 
 arch/s390/kvm/kvm-s390.c                                                      |   15 
 arch/s390/mm/Makefile                                                         |    2 
 arch/s390/mm/dump_pagetables.c                                                |   46 
 arch/s390/net/bpf_jit_comp.c                                                  |   11 
 arch/x86/Kconfig                                                              |    2 
 arch/x86/Kconfig.debug                                                        |    2 
 arch/x86/entry/entry_64_fred.S                                                |    2 
 arch/x86/events/amd/uncore.c                                                  |   31 
 arch/x86/events/intel/lbr.c                                                   |   12 
 arch/x86/events/intel/pt.c                                                    |  137 +
 arch/x86/events/intel/pt.h                                                    |    4 
 arch/x86/events/intel/uncore.c                                                |    2 
 arch/x86/include/asm/efi.h                                                    |    4 
 arch/x86/include/asm/linkage.h                                                |    2 
 arch/x86/include/asm/pkeys.h                                                  |    3 
 arch/x86/kvm/hyperv.c                                                         |   25 
 arch/x86/kvm/mmu/mmu.c                                                        |   35 
 arch/x86/kvm/vmx/nested.c                                                     |   75 
 arch/x86/kvm/x86.c                                                            |    5 
 arch/x86/kvm/x86.h                                                            |    2 
 arch/x86/mm/Makefile                                                          |    2 
 arch/x86/mm/dump_pagetables.c                                                 |   39 
 arch/x86/net/bpf_jit_comp.c                                                   |    7 
 arch/x86/platform/efi/efi.c                                                   |    2 
 block/blk-cgroup.c                                                            |    2 
 block/blk-iocost.c                                                            |    2 
 block/blk-stat.c                                                              |    2 
 block/genhd.c                                                                 |    7 
 block/kyber-iosched.c                                                         |    2 
 crypto/lskcipher.c                                                            |    1 
 drivers/accessibility/speakup/keyhelp.c                                       |   17 
 drivers/accessibility/speakup/kobjects.c                                      |    6 
 drivers/acpi/battery.c                                                        |   36 
 drivers/acpi/cppc_acpi.c                                                      |  224 --
 drivers/acpi/ec.c                                                             |   40 
 drivers/acpi/pci_root.c                                                       |    3 
 drivers/acpi/processor_core.c                                                 |   31 
 drivers/acpi/processor_driver.c                                               |   18 
 drivers/acpi/processor_idle.c                                                 |  103 
 drivers/acpi/riscv/irq.c                                                      |   33 
 drivers/acpi/scan.c                                                           |   13 
 drivers/acpi/video_detect.c                                                   |    4 
 drivers/ata/ahci.c                                                            |   49 
 drivers/base/cacheinfo.c                                                      |    9 
 drivers/base/firmware_loader/fallback.c                                       |   10 
 drivers/base/memory.c                                                         |    8 
 drivers/base/soc.c                                                            |   15 
 drivers/base/swnode.c                                                         |    2 
 drivers/block/mtip32xx/mtip32xx.c                                             |    7 
 drivers/block/mtip32xx/mtip32xx.h                                             |    2 
 drivers/block/null_blk/main.c                                                 |   78 
 drivers/block/ublk_drv.c                                                      |   16 
 drivers/bluetooth/btintel.c                                                   |    2 
 drivers/bluetooth/btmtk.c                                                     |  104 
 drivers/bluetooth/btmtk.h                                                     |    8 
 drivers/bluetooth/btmtksdio.c                                                 |   80 
 drivers/bluetooth/btqca.c                                                     |    3 
 drivers/bluetooth/btusb.c                                                     |   68 
 drivers/bluetooth/virtio_bt.c                                                 |    8 
 drivers/bus/mhi/ep/main.c                                                     |   15 
 drivers/bus/mhi/host/init.c                                                   |    4 
 drivers/bus/mhi/host/main.c                                                   |    6 
 drivers/bus/qcom-ebi2.c                                                       |   51 
 drivers/bus/ti-sysc.c                                                         |   12 
 drivers/char/hw_random/core.c                                                 |    4 
 drivers/char/hw_random/ks-sa-rng.c                                            |    9 
 drivers/char/ppdev.c                                                          |   10 
 drivers/char/tpm/st33zp24/st33zp24.c                                          |    8 
 drivers/char/xilinx_hwicap/xilinx_hwicap.c                                    |    5 
 drivers/clk/clk-devres.c                                                      |   12 
 drivers/clk/clk-moxart.c                                                      |   14 
 drivers/clk/clk-palmas.c                                                      |   14 
 drivers/clk/clk-versaclock7.c                                                 |    2 
 drivers/clk/hisilicon/reset.c                                                 |    2 
 drivers/clk/imx/clk-scu.c                                                     |    1 
 drivers/clk/mediatek/clk-mt8135.c                                             |    5 
 drivers/clk/meson/gxbb.c                                                      |    2 
 drivers/clk/nuvoton/clk-ma35d1-pll.c                                          |   52 
 drivers/clk/qcom/camcc-sc8280xp.c                                             |   19 
 drivers/clk/qcom/common.c                                                     |    4 
 drivers/clk/qcom/gcc-mdm9607.c                                                |  182 -
 drivers/clk/qcom/gcc-msm8916.c                                                |    5 
 drivers/clk/qcom/gcc-msm8939.c                                                |    5 
 drivers/clk/qcom/gcc-qcm2290.c                                                |   12 
 drivers/clk/qcom/gdsc.c                                                       |   25 
 drivers/clk/qcom/gpucc-qcm2290.c                                              |    2 
 drivers/clk/rockchip/clk-pll.c                                                |    9 
 drivers/clk/rockchip/clk-rk3576.c                                             |   11 
 drivers/clk/rockchip/clk-rk3588.c                                             |    2 
 drivers/clk/tegra/clk-tegra124-emc.c                                          |    1 
 drivers/clk/ti/adpll.c                                                        |    4 
 drivers/clk/ti/divider.c                                                      |    2 
 drivers/clk/ti/mux.c                                                          |   22 
 drivers/clk/visconti/clkc.c                                                   |    2 
 drivers/clk/x86/clk-pmc-atom.c                                                |    3 
 drivers/clocksource/clps711x-timer.c                                          |    2 
 drivers/clocksource/timer-armada-370-xp.c                                     |   18 
 drivers/cpufreq/amd-pstate.c                                                  |   33 
 drivers/cpufreq/imx6q-cpufreq.c                                               |    6 
 drivers/cpufreq/intel_pstate.c                                                |   19 
 drivers/cpufreq/spear-cpufreq.c                                               |    4 
 drivers/cpuidle/dt_idle_genpd.c                                               |    3 
 drivers/crypto/atmel-ecc.c                                                    |   45 
 drivers/crypto/atmel-sha204a.c                                                |    6 
 drivers/crypto/ccp/sev-dev.c                                                  |   17 
 drivers/crypto/gemini/sl3516-ce-cipher.c                                      |    8 
 drivers/crypto/hisilicon/sec2/sec_crypto.c                                    |   12 
 drivers/crypto/intel/keembay/keembay-ocs-aes-core.c                           |    9 
 drivers/crypto/intel/qat/qat_common/adf_aer.c                                 |    2 
 drivers/crypto/intel/qat/qat_common/qat_algs.c                                |    1 
 drivers/crypto/rockchip/rk3288_crypto_ahash.c                                 |    7 
 drivers/crypto/sa2ul.c                                                        |    6 
 drivers/cxl/core/core.h                                                       |    6 
 drivers/cxl/core/mbox.c                                                       |   95 
 drivers/cxl/core/memdev.c                                                     |   24 
 drivers/cxl/core/region.c                                                     |    7 
 drivers/cxl/cxlmem.h                                                          |   40 
 drivers/cxl/pci.c                                                             |   13 
 drivers/dax/super.c                                                           |   12 
 drivers/dma/dw-edma/dw-edma-core.c                                            |  127 -
 drivers/dma/dw-edma/dw-hdma-v0-core.c                                         |    2 
 drivers/dma/fsl-edma-trace.h                                                  |    4 
 drivers/dma/hisi_dma.c                                                        |    2 
 drivers/dma/mediatek/mtk-uart-apdma.c                                         |    2 
 drivers/dma/qcom/bam_dma.c                                                    |    1 
 drivers/dma/xilinx/xilinx_dma.c                                               |   12 
 drivers/firewire/.kunitconfig                                                 |    1 
 drivers/firewire/Kconfig                                                      |   15 
 drivers/firewire/core-topology.c                                              |   62 
 drivers/firewire/node-tree-test.c                                             |  607 +++++
 drivers/firmware/arm_scmi/bus.c                                               |   67 
 drivers/firmware/arm_scmi/driver.c                                            |   72 
 drivers/firmware/arm_scmi/notify.c                                            |   21 
 drivers/firmware/arm_scmi/notify.h                                            |    1 
 drivers/firmware/arm_scmi/transports/mailbox.c                                |   26 
 drivers/firmware/arm_scmi/transports/smc.c                                    |   15 
 drivers/firmware/google/coreboot_table.c                                      |   26 
 drivers/firmware/qcom/Makefile                                                |    1 
 drivers/firmware/qcom/qcom_scm-smc.c                                          |   12 
 drivers/firmware/qcom/qcom_scm.c                                              |  126 +
 drivers/firmware/qcom/qcom_scm.h                                              |    3 
 drivers/firmware/qcom/qcom_scm_trace.h                                        |  143 +
 drivers/firmware/qcom/qcom_tzmem.c                                            |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                              |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                    |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                       |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                                       |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                                        |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                                         |   74 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                                         |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                         |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                      |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                         |   10 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c                       |   13 
 drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c                        |    3 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c               |    5 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c                           |   24 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c                         |   35 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c                           |    2 
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c                                     |    3 
 drivers/gpu/drm/bridge/tc358767.c                                             |    2 
 drivers/gpu/drm/drm_atomic_uapi.c                                             |    2 
 drivers/gpu/drm/drm_drv.c                                                     |   34 
 drivers/gpu/drm/drm_dumb_buffers.c                                            |    1 
 drivers/gpu/drm/gud/gud_connector.c                                           |   12 
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c                                |   52 
 drivers/gpu/drm/i915/i915_pci.c                                               |    3 
 drivers/gpu/drm/lima/lima_device.c                                            |   12 
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c                                     |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                         |    5 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c                                 |    4 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                            |   14 
 drivers/gpu/drm/mxsfb/lcdif_kms.c                                             |   15 
 drivers/gpu/drm/nouveau/nouveau_chan.c                                        |    9 
 drivers/gpu/drm/nouveau/nouveau_sgdma.c                                       |    4 
 drivers/gpu/drm/nouveau/nouveau_uvmm.c                                        |    6 
 drivers/gpu/drm/omapdrm/dss/dsi.c                                             |    7 
 drivers/gpu/drm/omapdrm/dss/dsi.h                                             |    2 
 drivers/gpu/drm/panel/panel-edp.c                                             |   19 
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c                                 |   10 
 drivers/gpu/drm/panthor/panthor_drv.c                                         |    2 
 drivers/gpu/drm/panthor/panthor_fw.c                                          |   19 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                                  |    2 
 drivers/gpu/drm/solomon/ssd130x.c                                             |    9 
 drivers/gpu/drm/sun4i/sun4i_backend.c                                         |    2 
 drivers/gpu/drm/sun4i/sun4i_crtc.c                                            |    2 
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c                                        |    2 
 drivers/gpu/drm/sun4i/sun4i_tcon.c                                            |   22 
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c                                         |    2 
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c                                        |    2 
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c                                       |   18 
 drivers/gpu/drm/tve200/tve200_drv.c                                           |    1 
 drivers/gpu/drm/v3d/v3d_drv.h                                                 |    8 
 drivers/gpu/drm/v3d/v3d_fence.c                                               |   11 
 drivers/gpu/drm/v3d/v3d_gem.c                                                 |    3 
 drivers/gpu/drm/v3d/v3d_irq.c                                                 |    6 
 drivers/gpu/drm/v3d/v3d_sched.c                                               |   67 
 drivers/gpu/drm/xe/tests/xe_migrate.c                                         |    3 
 drivers/gpu/host1x/debug.c                                                    |    4 
 drivers/gpu/host1x/hw/channel_hw.c                                            |    5 
 drivers/hid/bpf/hid_bpf_struct_ops.c                                          |   17 
 drivers/hid/hid-core.c                                                        |    9 
 drivers/hid/hid-lg4ff.c                                                       |    8 
 drivers/hid/hid-multitouch.c                                                  |    2 
 drivers/hid/hid-nintendo.c                                                    |    1 
 drivers/hid/hid-rmi.c                                                         |   46 
 drivers/hid/hid-roccat-kone.c                                                 |    8 
 drivers/hid/i2c-hid/Makefile                                                  |    2 
 drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c                                    |  104 
 drivers/hid/i2c-hid/i2c-hid-acpi.c                                            |   52 
 drivers/hid/i2c-hid/i2c-hid-acpi.h                                            |   33 
 drivers/hid/i2c-hid/i2c-hid-core.c                                            |    2 
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c                                       |    4 
 drivers/hid/wacom_wac.c                                                       |   13 
 drivers/hwmon/coretemp.c                                                      |    1 
 drivers/hwmon/emc1403.c                                                       |   73 
 drivers/hwspinlock/hwspinlock_core.c                                          |    2 
 drivers/hwtracing/coresight/coresight-etm4x-cfg.c                             |    2 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                            |   15 
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c                           |    6 
 drivers/hwtracing/coresight/coresight-etm4x.h                                 |    9 
 drivers/i2c/busses/i2c-ocores.c                                               |    6 
 drivers/i2c/i2c-core-base.c                                                   |    6 
 drivers/i2c/i2c-mux.c                                                         |    1 
 drivers/i2c/muxes/i2c-demux-pinctrl.c                                         |    1 
 drivers/i3c/master.c                                                          |    2 
 drivers/i3c/master/dw-i3c-master.c                                            |   10 
 drivers/i3c/master/mipi-i3c-hci/core.c                                        |   18 
 drivers/i3c/master/mipi-i3c-hci/dma.c                                         |    4 
 drivers/i3c/master/mipi-i3c-hci/ext_caps.c                                    |   55 
 drivers/i3c/master/mipi-i3c-hci/pio.c                                         |   54 
 drivers/iio/accel/dmard09.c                                                   |    7 
 drivers/iio/adc/Kconfig                                                       |    1 
 drivers/iio/adc/pac1921.c                                                     |    2 
 drivers/iio/chemical/atlas-sensor.c                                           |   19 
 drivers/iio/chemical/sgp30.c                                                  |    3 
 drivers/iio/dac/m62332.c                                                      |   17 
 drivers/iio/gyro/mpu3050-core.c                                               |    2 
 drivers/iio/industrialio-buffer.c                                             |   38 
 drivers/iio/light/cm32181.c                                                   |    2 
 drivers/iio/light/gp2ap002.c                                                  |   24 
 drivers/iio/light/isl29028.c                                                  |    2 
 drivers/iio/light/ltrf216a.c                                                  |    3 
 drivers/iio/light/opt4001.c                                                   |   37 
 drivers/iio/light/tsl2583.c                                                   |    2 
 drivers/iio/light/tsl2772.c                                                   |    2 
 drivers/iio/orientation/hid-sensor-rotation.c                                 |   20 
 drivers/iio/pressure/dps310.c                                                 |    3 
 drivers/iio/pressure/mpl115.c                                                 |   11 
 drivers/iio/proximity/srf04.c                                                 |    1 
 drivers/iio/temperature/hid-sensor-temperature.c                              |    3 
 drivers/infiniband/core/cma.c                                                 |    6 
 drivers/infiniband/core/counters.c                                            |    5 
 drivers/infiniband/core/cq.c                                                  |   14 
 drivers/infiniband/core/device.c                                              |    3 
 drivers/infiniband/core/nldev.c                                               |   20 
 drivers/infiniband/core/restrack.c                                            |  174 +
 drivers/infiniband/core/restrack.h                                            |    4 
 drivers/infiniband/core/ucma.c                                                |    2 
 drivers/infiniband/core/uverbs_cmd.c                                          |   10 
 drivers/infiniband/core/verbs.c                                               |   28 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                      |    6 
 drivers/infiniband/hw/cxgb4/device.c                                          |    2 
 drivers/infiniband/hw/cxgb4/mem.c                                             |    4 
 drivers/infiniband/hw/efa/efa_verbs.c                                         |   13 
 drivers/infiniband/hw/erdma/Kconfig                                           |    4 
 drivers/infiniband/hw/erdma/erdma.h                                           |   12 
 drivers/infiniband/hw/erdma/erdma_cm.c                                        |   77 
 drivers/infiniband/hw/erdma/erdma_cmdq.c                                      |   26 
 drivers/infiniband/hw/erdma/erdma_cq.c                                        |   45 
 drivers/infiniband/hw/erdma/erdma_eq.c                                        |   16 
 drivers/infiniband/hw/erdma/erdma_hw.h                                        |   98 
 drivers/infiniband/hw/erdma/erdma_main.c                                      |   51 
 drivers/infiniband/hw/erdma/erdma_qp.c                                        |  230 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c                                     |  568 ++++-
 drivers/infiniband/hw/erdma/erdma_verbs.h                                     |  206 +
 drivers/infiniband/hw/hfi1/chip.c                                             |    4 
 drivers/infiniband/hw/hfi1/hfi.h                                              |    2 
 drivers/infiniband/hw/hfi1/init.c                                             |   44 
 drivers/infiniband/hw/hfi1/user_sdma.c                                        |   13 
 drivers/infiniband/hw/mlx5/cong.c                                             |    8 
 drivers/infiniband/hw/mlx5/main.c                                             |    2 
 drivers/infiniband/hw/mlx5/qp.c                                               |   25 
 drivers/infiniband/sw/rxe/rxe_req.c                                           |   15 
 drivers/infiniband/sw/rxe/rxe_resp.c                                          |    9 
 drivers/infiniband/sw/siw/siw_cm.c                                            |    2 
 drivers/infiniband/ulp/ipoib/ipoib_main.c                                     |    2 
 drivers/infiniband/ulp/isert/ib_isert.c                                       |   85 
 drivers/infiniband/ulp/isert/ib_isert.h                                       |    1 
 drivers/infiniband/ulp/srp/ib_srp.c                                           |   45 
 drivers/infiniband/ulp/srpt/ib_srpt.c                                         |    9 
 drivers/input/tablet/aiptek.c                                                 |   13 
 drivers/iommu/amd/init.c                                                      |   42 
 drivers/iommu/amd/ppr.c                                                       |    2 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                                   |    5 
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c                                |   43 
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                                       |    6 
 drivers/iommu/dma-iommu.c                                                     |   13 
 drivers/iommu/intel/iommu.c                                                   |   17 
 drivers/iommu/iommufd/selftest.c                                              |    5 
 drivers/iommu/msm_iommu.c                                                     |    2 
 drivers/iommu/mtk_iommu_v1.c                                                  |    2 
 drivers/ipack/devices/ipoctal.c                                               |   56 
 drivers/irqchip/irq-gic-v3-its.c                                              |   23 
 drivers/irqchip/irq-mbigen.c                                                  |   20 
 drivers/irqchip/irq-renesas-irqc.c                                            |    1 
 drivers/irqchip/irq-renesas-rzg2l.c                                           |    4 
 drivers/irqchip/irq-stm32mp-exti.c                                            |    4 
 drivers/leds/leds-pca9532.c                                                   |   18 
 drivers/mailbox/pcc.c                                                         |   70 
 drivers/mailbox/qcom-cpucp-mbox.c                                             |   25 
 drivers/mailbox/rockchip-mailbox.c                                            |   17 
 drivers/md/dm-raid.c                                                          |   42 
 drivers/md/dm.c                                                               |   14 
 drivers/md/md-bitmap.c                                                        |   17 
 drivers/md/md-cluster.c                                                       |   16 
 drivers/md/md.c                                                               |  334 ++-
 drivers/md/md.h                                                               |   15 
 drivers/md/raid0.c                                                            |   10 
 drivers/md/raid1-10.c                                                         |    2 
 drivers/md/raid1.c                                                            |   20 
 drivers/md/raid10.c                                                           |   20 
 drivers/md/raid5-ppl.c                                                        |   10 
 drivers/md/raid5.c                                                            |  138 -
 drivers/media/cec/core/cec-adap.c                                             |   10 
 drivers/media/cec/core/cec-core.c                                             |    2 
 drivers/media/cec/core/cec-pin.c                                              |    8 
 drivers/media/cec/platform/meson/ao-cec-g12a.c                                |    1 
 drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c             |    3 
 drivers/media/dvb-frontends/rtl2832_sdr.c                                     |   21 
 drivers/media/i2c/alvium-csi2.c                                               |    2 
 drivers/media/i2c/imx415.c                                                    |    2 
 drivers/media/i2c/ov02a10.c                                                   |   12 
 drivers/media/i2c/ov7740.c                                                    |    4 
 drivers/media/i2c/rdacm21.c                                                   |    5 
 drivers/media/i2c/video-i2c.c                                                 |    8 
 drivers/media/pci/cobalt/cobalt-alsa-main.c                                   |    1 
 drivers/media/pci/cx23885/cimax2.c                                            |    1 
 drivers/media/pci/intel/ipu6/ipu6-isys.c                                      |    1 
 drivers/media/pci/intel/ipu6/ipu6.c                                           |   10 
 drivers/media/pci/saa7164/saa7164-core.c                                      |    8 
 drivers/media/pci/zoran/zoran_card.c                                          |    2 
 drivers/media/platform/amphion/venc.c                                         |    2 
 drivers/media/platform/broadcom/bcm2835-unicam.c                              |    2 
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c                      |    3 
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c                          |    6 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c                       |    6 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c                          |    2 
 drivers/media/platform/qcom/venus/hfi_parser.c                                |    9 
 drivers/media/rc/sunxi-cir.c                                                  |    9 
 drivers/media/test-drivers/vimc/vimc-capture.c                                |    4 
 drivers/media/tuners/tda18250.c                                               |    4 
 drivers/media/usb/airspy/airspy.c                                             |   17 
 drivers/media/usb/cx231xx/cx231xx-video.c                                     |    4 
 drivers/media/usb/em28xx/em28xx-cards.c                                       |    3 
 drivers/media/usb/em28xx/em28xx-core.c                                        |    2 
 drivers/media/usb/go7007/snd-go7007.c                                         |   10 
 drivers/media/usb/s2255/s2255drv.c                                            |   11 
 drivers/media/usb/usbtv/usbtv-audio.c                                         |   11 
 drivers/media/v4l2-core/v4l2-async.c                                          |   16 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                                     |   49 
 drivers/media/v4l2-core/v4l2-fwnode.c                                         |    2 
 drivers/mfd/iqs62x.c                                                          |    2 
 drivers/mfd/rave-sp.c                                                         |   64 
 drivers/misc/ad525x_dpot-i2c.c                                                |    1 
 drivers/misc/ad525x_dpot-spi.c                                                |    1 
 drivers/misc/ad525x_dpot.c                                                    |  177 +
 drivers/misc/ad525x_dpot.h                                                    |    3 
 drivers/misc/bcm-vk/bcm_vk_msg.c                                              |    6 
 drivers/misc/cardreader/rtsx_pcr.c                                            |    2 
 drivers/misc/cardreader/rtsx_usb.c                                            |   23 
 drivers/misc/sgi-gru/grufault.c                                               |  101 
 drivers/misc/sgi-gru/gruprocfs.c                                              |    1 
 drivers/misc/sgi-gru/grutables.h                                              |    1 
 drivers/misc/vmw_vmci/vmci_event.c                                            |    4 
 drivers/mtd/mtdoops.c                                                         |    3 
 drivers/mtd/mtdpart.c                                                         |    3 
 drivers/mtd/mtdswap.c                                                         |    1 
 drivers/mtd/nand/raw/nand_onfi.c                                              |   27 
 drivers/mtd/parsers/afs.c                                                     |    7 
 drivers/mtd/ubi/attach.c                                                      |    4 
 drivers/mtd/ubi/build.c                                                       |   11 
 drivers/mtd/ubi/fastmap.c                                                     |    6 
 drivers/mtd/ubi/io.c                                                          |   11 
 drivers/mtd/ubi/ubi.h                                                         |    4 
 drivers/mtd/ubi/wl.c                                                          |   15 
 drivers/net/bonding/bond_netlink.c                                            |    2 
 drivers/net/dsa/b53/b53_common.c                                              |    2 
 drivers/net/dsa/mv88e6xxx/pcs-6352.c                                          |    5 
 drivers/net/ethernet/allwinner/sun4i-emac.c                                   |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c                               |    2 
 drivers/net/ethernet/freescale/fec_main.c                                     |    6 
 drivers/net/ethernet/intel/ice/ice_lib.c                                      |    3 
 drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c                        |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c                       |    6 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                           |   11 
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c                             |    2 
 drivers/net/ethernet/nvidia/forcedeth.c                                       |    2 
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c                              |   27 
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c                              |  445 ++--
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c                          |    1 
 drivers/net/ethernet/realtek/8139cp.c                                         |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c                          |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c                             |    2 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c                           |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                             |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c                        |   41 
 drivers/net/ethernet/wangxun/libwx/wx_type.h                                  |    2 
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h                               |    2 
 drivers/net/gtp.c                                                             |    2 
 drivers/net/ipa/ipa_main.c                                                    |    6 
 drivers/net/ntb_netdev.c                                                      |   27 
 drivers/net/ppp/pppox.c                                                       |   17 
 drivers/net/slip/slip.c                                                       |    8 
 drivers/net/thunderbolt/main.c                                                |    6 
 drivers/net/vxlan/vxlan_mdb.c                                                 |    9 
 drivers/net/vxlan/vxlan_vnifilter.c                                           |    6 
 drivers/net/wireless/ath/ath10k/snoc.c                                        |    9 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                       |   30 
 drivers/net/wireless/ath/ath11k/wmi.c                                         |   40 
 drivers/net/wireless/ath/ath12k/wmi.c                                         |   20 
 drivers/net/wireless/ath/ath6kl/wmi.c                                         |   17 
 drivers/net/wireless/intel/iwlwifi/fw/dump.c                                  |    2 
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c                              |    8 
 drivers/net/wireless/intel/iwlwifi/mei/main.c                                 |    8 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                                  |    2 
 drivers/net/wireless/mediatek/mt76/dma.c                                      |   16 
 drivers/net/wireless/mediatek/mt76/dma.h                                      |    2 
 drivers/net/wireless/mediatek/mt76/mac80211.c                                 |    7 
 drivers/net/wireless/mediatek/mt76/mt76.h                                     |    3 
 drivers/net/wireless/mediatek/mt76/mt76_connac.h                              |    5 
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                              |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                            |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                              |    9 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                               |    6 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                              |   24 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                               |   10 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                               |    6 
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                            |   18 
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c                               |    9 
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c                               |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c                          |    5 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                              |   66 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                               |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c                            |    6 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                              |   16 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                               |    7 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                              |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                               |   16 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                               |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c                              |   12 
 drivers/net/wireless/mediatek/mt76/sdio.c                                     |   11 
 drivers/net/wireless/mediatek/mt76/tx.c                                       |    8 
 drivers/net/wireless/realtek/rtlwifi/pci.c                                    |    6 
 drivers/net/wireless/realtek/rtw89/mac.c                                      |    2 
 drivers/net/wireless/virtual/mac80211_hwsim.c                                 |    5 
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c                                  |    8 
 drivers/nfc/pn533/pn533.c                                                     |   21 
 drivers/nvdimm/btt.c                                                          |    8 
 drivers/nvdimm/label.c                                                        |   15 
 drivers/nvme/host/apple.c                                                     |  227 +-
 drivers/nvme/host/fabrics.c                                                   |    2 
 drivers/nvme/host/fc.c                                                        |   32 
 drivers/nvme/host/ioctl.c                                                     |  117 -
 drivers/nvme/host/tcp.c                                                       |    7 
 drivers/nvme/target/auth.c                                                    |    6 
 drivers/nvme/target/core.c                                                    |    2 
 drivers/nvme/target/fabrics-cmd-auth.c                                        |   12 
 drivers/nvme/target/nvmet.h                                                   |    2 
 drivers/nvme/target/rdma.c                                                    |   31 
 drivers/nvme/target/tcp.c                                                     |   10 
 drivers/nvme/target/zns.c                                                     |    2 
 drivers/of/property.c                                                         |   81 
 drivers/of/unittest.c                                                         |    8 
 drivers/parisc/eisa.c                                                         |    5 
 drivers/pci/controller/cadence/pci-j721e.c                                    |    4 
 drivers/pci/controller/pci-xgene.c                                            |   11 
 drivers/pci/controller/plda/pcie-starfive.c                                   |   10 
 drivers/pci/pcie/aspm.c                                                       |   31 
 drivers/pci/probe.c                                                           |    7 
 drivers/perf/arm_spe_pmu.c                                                    |    2 
 drivers/perf/cxl_pmu.c                                                        |    2 
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c                                     | 1056 +++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v8.h                                 |   25 
 drivers/phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h                         |   52 
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h                                |   12 
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h                                |   17 
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h                               |   12 
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v8.h                               |   12 
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v8.h                                |   38 
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8.h                                    |   32 
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h                            |   64 
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h                           |  639 ++++++
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v8.h                           |   68 
 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c                                |   12 
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c                                       |   12 
 drivers/phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h                              |   33 
 drivers/phy/qualcomm/phy-qcom-qmp-usb43-qserdes-com-v8.h                      |  224 ++
 drivers/phy/qualcomm/phy-qcom-qmp.h                                           |    7 
 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c                                     |   43 
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c                                 |   26 
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c                              |    2 
 drivers/phy/starfive/phy-jh7110-dphy-rx.c                                     |    5 
 drivers/phy/starfive/phy-jh7110-dphy-tx.c                                     |    5 
 drivers/phy/sunplus/phy-sunplus-usb2.c                                        |    6 
 drivers/pinctrl/bcm/pinctrl-bcm2835.c                                         |    1 
 drivers/pinctrl/mediatek/mtk-eint.c                                           |  344 ++-
 drivers/pinctrl/mediatek/mtk-eint.h                                           |   28 
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c                              |   40 
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h                              |    1 
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c                                 |   14 
 drivers/pinctrl/mediatek/pinctrl-paris.h                                      |    7 
 drivers/pinctrl/pinctrl-rockchip.c                                            |   10 
 drivers/platform/chrome/cros_ec_debugfs.c                                     |    6 
 drivers/platform/chrome/cros_ec_sensorhub_ring.c                              |    9 
 drivers/platform/chrome/cros_ec_typec.c                                       |    6 
 drivers/platform/mellanox/mlxbf-bootctl.c                                     |    1 
 drivers/platform/mellanox/mlxbf-pmc.c                                         |   10 
 drivers/platform/surface/surface_acpi_notify.c                                |    6 
 drivers/platform/x86/dell/dell-wmi-base.c                                     |   17 
 drivers/platform/x86/dell/dell-wmi-privacy.c                                  |    4 
 drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h                   |    2 
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c                     |    5 
 drivers/platform/x86/lg-laptop.c                                              |   79 
 drivers/pmdomain/bcm/bcm2835-power.c                                          |    7 
 drivers/power/supply/bd99954-charger.h                                        |   23 
 drivers/power/supply/bq27xxx_battery.c                                        |    6 
 drivers/power/supply/isp1704_charger.c                                        |    1 
 drivers/power/supply/sbs-battery.c                                            |    7 
 drivers/power/supply/sc2731_charger.c                                         |    2 
 drivers/powercap/intel_rapl_tpmi.c                                            |    5 
 drivers/pps/clients/pps-gpio.c                                                |   62 
 drivers/pps/pps.c                                                             |   10 
 drivers/rapidio/rio-scan.c                                                    |    1 
 drivers/regulator/core.c                                                      |    6 
 drivers/regulator/qcom-rpmh-regulator.c                                       |    6 
 drivers/regulator/tps6594-regulator.c                                         |  271 +-
 drivers/remoteproc/qcom_common.c                                              |    4 
 drivers/remoteproc/qcom_q6v5_adsp.c                                           |    1 
 drivers/remoteproc/remoteproc_core.c                                          |  150 -
 drivers/remoteproc/remoteproc_sysfs.c                                         |    1 
 drivers/rpmsg/qcom_glink_native.c                                             |   42 
 drivers/rtc/rtc-gamecube.c                                                    |    4 
 drivers/rtc/rtc-pcf85363.c                                                    |   17 
 drivers/rtc/rtc-pcf8563.c                                                     |    4 
 drivers/rtc/rtc-rzn1.c                                                        |   10 
 drivers/rtc/rtc-zynqmp.c                                                      |    7 
 drivers/s390/crypto/vfio_ap_ops.c                                             |  176 +
 drivers/scsi/mpt3sas/mpt3sas_base.c                                           |    2 
 drivers/scsi/pm8001/pm8001_init.c                                             |    4 
 drivers/scsi/qla2xxx/qla_attr.c                                               |    7 
 drivers/scsi/qla2xxx/qla_bsg.c                                                |   39 
 drivers/scsi/qla2xxx/qla_dbg.c                                                |    2 
 drivers/scsi/qla2xxx/qla_dfs.c                                                |    4 
 drivers/scsi/qla2xxx/qla_edif.c                                               |    3 
 drivers/scsi/qla2xxx/qla_gs.c                                                 |    4 
 drivers/scsi/qla2xxx/qla_init.c                                               |   61 
 drivers/scsi/qla2xxx/qla_inline.h                                             |   13 
 drivers/scsi/qla2xxx/qla_isr.c                                                |   39 
 drivers/scsi/qla2xxx/qla_mbx.c                                                |   28 
 drivers/scsi/qla2xxx/qla_nvme.c                                               |   31 
 drivers/scsi/qla2xxx/qla_nx2.c                                                |    2 
 drivers/scsi/qla2xxx/qla_os.c                                                 |   14 
 drivers/scsi/sd.c                                                             |    4 
 drivers/scsi/smartpqi/smartpqi_init.c                                         |   18 
 drivers/soc/fsl/qe/qe_ic.c                                                    |    3 
 drivers/soc/qcom/rpmh-rsc.c                                                   |   37 
 drivers/soc/samsung/exynos-pmu.c                                              |    4 
 drivers/soundwire/qcom.c                                                      |    2 
 drivers/spi/spi-bcm63xx-hsspi.c                                               |    8 
 drivers/spi/spi-bcm63xx.c                                                     |    6 
 drivers/spi/spi-bcmbca-hsspi.c                                                |    8 
 drivers/spi/spi-davinci.c                                                     |    7 
 drivers/spi/spi-img-spfi.c                                                    |    5 
 drivers/spi/spi-oc-tiny.c                                                     |   24 
 drivers/spi/spi-sprd-adi.c                                                    |    6 
 drivers/spi/spi.c                                                             |   34 
 drivers/staging/fbtft/fbtft-sysfs.c                                           |    2 
 drivers/staging/greybus/audio_gb.c                                            |   13 
 drivers/staging/greybus/audio_manager_sysfs.c                                 |    2 
 drivers/staging/media/meson/vdec/vdec.c                                       |    4 
 drivers/staging/media/sunxi/cedrus/cedrus.c                                   |    4 
 drivers/staging/octeon/ethernet-mem.c                                         |   43 
 drivers/staging/octeon/ethernet-mem.h                                         |    8 
 drivers/staging/octeon/ethernet-rx.c                                          |   51 
 drivers/staging/octeon/ethernet-rx.h                                          |   11 
 drivers/staging/octeon/ethernet-tx.c                                          |    2 
 drivers/staging/octeon/ethernet.c                                             |   43 
 drivers/staging/octeon/octeon-ethernet.h                                      |   14 
 drivers/staging/rtl8723bs/core/rtw_cmd.c                                      |    8 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c                                |    7 
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c                                  |    4 
 drivers/staging/sm750fb/Kconfig                                               |    1 
 drivers/staging/sm750fb/sm750.c                                               |    4 
 drivers/target/iscsi/iscsi_target_login.c                                     |    2 
 drivers/thermal/imx_thermal.c                                                 |    9 
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c                       |    4 
 drivers/thermal/qoriq_thermal.c                                               |   13 
 drivers/thermal/renesas/rcar_thermal.c                                        |   15 
 drivers/tty/hvc/Kconfig                                                       |    2 
 drivers/tty/serial/amba-pl011.c                                               |   10 
 drivers/tty/serial/ma35d1_serial.c                                            |   12 
 drivers/tty/serial/qcom_geni_serial.c                                         |   10 
 drivers/tty/tty_io.c                                                          |    4 
 drivers/ufs/core/ufs-debugfs.c                                                |    2 
 drivers/ufs/core/ufshcd.c                                                     |   15 
 drivers/uio/uio.c                                                             |    5 
 drivers/usb/atm/usbatm.c                                                      |    4 
 drivers/usb/common/common.c                                                   |    3 
 drivers/usb/core/driver.c                                                     |   29 
 drivers/usb/gadget/configfs.c                                                 |    4 
 drivers/usb/gadget/function/f_fs.c                                            |    8 
 drivers/usb/gadget/function/f_mass_storage.c                                  |    2 
 drivers/usb/gadget/function/f_midi.c                                          |    2 
 drivers/usb/gadget/function/f_midi2.c                                         |   17 
 drivers/usb/gadget/function/f_uac1_legacy.c                                   |   56 
 drivers/usb/gadget/function/u_uac1_legacy.h                                   |    3 
 drivers/usb/gadget/functions.c                                                |    2 
 drivers/usb/gadget/legacy/inode.c                                             |    3 
 drivers/usb/gadget/udc/aspeed_udc.c                                           |   50 
 drivers/usb/gadget/udc/r8a66597-udc.c                                         |    1 
 drivers/usb/host/xhci-ring.c                                                  |   32 
 drivers/usb/image/mdc800.c                                                    |    4 
 drivers/usb/misc/usb-ljca.c                                                   |    3 
 drivers/usb/mtu3/mtu3_core.c                                                  |   11 
 drivers/usb/renesas_usbhs/common.c                                            |    6 
 drivers/usb/serial/bus.c                                                      |    4 
 drivers/usb/serial/usb-serial.c                                               |    4 
 drivers/usb/storage/ene_ub6250.c                                              |    2 
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c                           |    2 
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c                            |    5 
 drivers/usb/typec/ucsi/debugfs.c                                              |    1 
 drivers/usb/typec/ucsi/displayport.c                                          |    2 
 drivers/usb/typec/ucsi/ucsi.c                                                 |    2 
 drivers/vdpa/mlx5/core/mr.c                                                   |    2 
 drivers/vdpa/vdpa_sim/vdpa_sim.c                                              |   25 
 drivers/vfio/pci/vfio_pci_config.c                                            |    1 
 drivers/video/fbdev/kyro/fbdev.c                                              |   24 
 drivers/video/fbdev/tdfxfb.c                                                  |    2 
 drivers/virtio/virtio_balloon.c                                               |    6 
 drivers/virtio/virtio_pci_common.c                                            |    2 
 drivers/w1/masters/ds2482.c                                                   |    4 
 drivers/watchdog/pseries-wdt.c                                                |   53 
 drivers/xen/xenbus/xenbus_xs.c                                                |   16 
 fs/afs/callback.c                                                             |    1 
 fs/btrfs/verity.c                                                             |   16 
 fs/ceph/file.c                                                                |   48 
 fs/ceph/mds_client.c                                                          |    4 
 fs/ceph/mds_client.h                                                          |    1 
 fs/crypto/inline_crypt.c                                                      |    3 
 fs/erofs/Kconfig                                                              |    8 
 fs/erofs/compress.h                                                           |   23 
 fs/erofs/decompressor.c                                                       |    2 
 fs/erofs/zdata.c                                                              |  162 -
 fs/ext4/file.c                                                                |    7 
 fs/ext4/inline.c                                                              |   11 
 fs/ext4/inode.c                                                               |   28 
 fs/ext4/migrate.c                                                             |    3 
 fs/ext4/namei.c                                                               |    2 
 fs/ext4/orphan.c                                                              |   10 
 fs/f2fs/data.c                                                                |    5 
 fs/f2fs/f2fs.h                                                                |   27 
 fs/f2fs/file.c                                                                |  120 -
 fs/f2fs/gc.c                                                                  |    7 
 fs/f2fs/namei.c                                                               |   11 
 fs/f2fs/segment.c                                                             |   41 
 fs/f2fs/segment.h                                                             |    4 
 fs/f2fs/super.c                                                               |    4 
 fs/f2fs/sysfs.c                                                               |    7 
 fs/f2fs/xattr.c                                                               |    2 
 fs/fat/nfs.c                                                                  |    4 
 fs/fuse/cuse.c                                                                |    5 
 fs/fuse/dev.c                                                                 |   40 
 fs/fuse/dir.c                                                                 |   11 
 fs/fuse/fuse_i.h                                                              |   36 
 fs/fuse/inode.c                                                               |   58 
 fs/fuse/readdir.c                                                             |   36 
 fs/hfsplus/catalog.c                                                          |   25 
 fs/hfsplus/hfsplus_fs.h                                                       |    6 
 fs/hugetlbfs/inode.c                                                          |    3 
 fs/isofs/compress.c                                                           |    7 
 fs/netfs/buffered_read.c                                                      |    2 
 fs/nfs/blocklayout/dev.c                                                      |   21 
 fs/nfs/client.c                                                               |   21 
 fs/nfs/dir.c                                                                  |    7 
 fs/nfs/filelayout/filelayoutdev.c                                             |    3 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                                     |    3 
 fs/nfs/inode.c                                                                |    4 
 fs/nfs/internal.h                                                             |    1 
 fs/nfs/netns.h                                                                |    6 
 fs/nfs/nfs4client.c                                                           |    1 
 fs/nfs/nfs4proc.c                                                             |    4 
 fs/nfs/pnfs.c                                                                 |   35 
 fs/nfs/pnfs.h                                                                 |    3 
 fs/nfs/pnfs_nfs.c                                                             |   39 
 fs/nilfs2/page.c                                                              |   17 
 fs/nilfs2/segment.c                                                           |    4 
 fs/nilfs2/the_nilfs.c                                                         |    6 
 fs/notify/fanotify/fanotify_user.c                                            |   17 
 fs/notify/inotify/inotify_user.c                                              |   15 
 fs/ntfs3/attrib.c                                                             |   11 
 fs/ntfs3/frecord.c                                                            |   79 
 fs/ntfs3/fslog.c                                                              |   13 
 fs/ntfs3/fsntfs.c                                                             |    8 
 fs/ntfs3/ntfs_fs.h                                                            |   21 
 fs/ntfs3/record.c                                                             |  125 -
 fs/ntfs3/super.c                                                              |   13 
 fs/ntfs3/xattr.c                                                              |   21 
 fs/ocfs2/acl.c                                                                |  135 -
 fs/ocfs2/acl.h                                                                |   19 
 fs/ocfs2/cluster/heartbeat.c                                                  |   97 
 fs/ocfs2/cluster/heartbeat.h                                                  |    5 
 fs/ocfs2/cluster/nodemanager.c                                                |   23 
 fs/ocfs2/cluster/nodemanager.h                                                |    2 
 fs/ocfs2/cluster/tcp.c                                                        |   83 
 fs/ocfs2/cluster/tcp.h                                                        |    1 
 fs/ocfs2/namei.c                                                              |   17 
 fs/ocfs2/xattr.c                                                              |   86 
 fs/ocfs2/xattr.h                                                              |    9 
 fs/smb/client/cifs_debug.c                                                    |    2 
 fs/smb/client/smb2pdu.c                                                       |   16 
 fs/smb/server/auth.c                                                          |    1 
 fs/smb/server/connection.c                                                    |   19 
 fs/smb/server/connection.h                                                    |    1 
 fs/smb/server/mgmt/share_config.c                                             |    7 
 fs/smb/server/mgmt/user_config.c                                              |    1 
 fs/smb/server/mgmt/user_session.c                                             |   24 
 fs/smb/server/mgmt/user_session.h                                             |    1 
 fs/smb/server/server.c                                                        |    4 
 fs/smb/server/smb2ops.c                                                       |   11 
 fs/smb/server/smb2pdu.c                                                       |   57 
 fs/smb/server/smbacl.c                                                        |    4 
 fs/smb/server/transport_ipc.c                                                 |   12 
 fs/smb/server/transport_tcp.c                                                 |    6 
 fs/smb/server/vfs.c                                                           |    3 
 fs/smb/server/vfs_cache.c                                                     |    5 
 fs/squashfs/cache.c                                                           |    2 
 fs/super.c                                                                    |    4 
 fs/udf/super.c                                                                |   23 
 fs/udf/symlink.c                                                              |    2 
 include/acpi/cppc_acpi.h                                                      |    6 
 include/acpi/pcc.h                                                            |    5 
 include/acpi/processor.h                                                      |    2 
 include/cxl/mailbox.h                                                         |   41 
 include/linux/bpf-cgroup-defs.h                                               |    1 
 include/linux/bpf-cgroup.h                                                    |    5 
 include/linux/bpf.h                                                           |    4 
 include/linux/efi.h                                                           |    4 
 include/linux/ima.h                                                           |    7 
 include/linux/kprobes.h                                                       |    1 
 include/linux/maple_tree.h                                                    |    2 
 include/linux/memcontrol.h                                                    |   10 
 include/linux/memory.h                                                        |   27 
 include/linux/memory_hotplug.h                                                |   19 
 include/linux/mmc/sdio_ids.h                                                  |    1 
 include/linux/nfs_xdr.h                                                       |    2 
 include/linux/nvme.h                                                          |   81 
 include/linux/of_graph.h                                                      |   49 
 include/linux/panic.h                                                         |    6 
 include/linux/pci.h                                                           |    2 
 include/linux/printk.h                                                        |    2 
 include/linux/ptdump.h                                                        |    9 
 include/linux/remoteproc.h                                                    |  284 --
 include/linux/rsc_table.h                                                     |  364 +++
 include/linux/rtsx_usb.h                                                      |    3 
 include/linux/secure_boot.h                                                   |   23 
 include/linux/sunrpc/xdr.h                                                    |   21 
 include/linux/usb.h                                                           |    7 
 include/linux/virtio_net.h                                                    |    4 
 include/media/rc-map.h                                                        |    2 
 include/net/bluetooth/hci_core.h                                              |    2 
 include/net/bluetooth/l2cap.h                                                 |    5 
 include/net/inet_connection_sock.h                                            |   12 
 include/net/inetpeer.h                                                        |    4 
 include/net/pkt_sched.h                                                       |    1 
 include/net/tc_act/tc_ct.h                                                    |    2 
 include/net/tc_act/tc_ctinfo.h                                                |    1 
 include/net/tc_act/tc_skbedit.h                                               |    1 
 include/net/tc_act/tc_skbmod.h                                                |    1 
 include/net/tc_act/tc_tunnel_key.h                                            |    1 
 include/net/tc_act/tc_vlan.h                                                  |    1 
 include/net/tcp.h                                                             |   13 
 include/net/xsk_buff_pool.h                                                   |   19 
 include/rdma/ib_verbs.h                                                       |   14 
 include/sound/core.h                                                          |    2 
 include/uapi/linux/bpf.h                                                      |    7 
 include/uapi/linux/landlock.h                                                 |    1 
 include/uapi/linux/raid/md_p.h                                                |    2 
 include/uapi/linux/time_types.h                                               |    2 
 kernel/bpf/arena.c                                                            |    2 
 kernel/bpf/bpf_lsm.c                                                          |    1 
 kernel/bpf/btf.c                                                              |   26 
 kernel/bpf/cgroup.c                                                           |  220 +-
 kernel/bpf/net_namespace.c                                                    |   17 
 kernel/bpf/ringbuf.c                                                          |    2 
 kernel/bpf/syscall.c                                                          |   73 
 kernel/bpf/task_iter.c                                                        |   36 
 kernel/bpf/verifier.c                                                         |   20 
 kernel/cgroup/cgroup.c                                                        |    5 
 kernel/cgroup/cpuset-internal.h                                               |    2 
 kernel/cgroup/cpuset.c                                                        |  301 +-
 kernel/dma/direct.c                                                           |   18 
 kernel/dma/swiotlb.c                                                          |   31 
 kernel/entry/common.c                                                         |    3 
 kernel/futex/requeue.c                                                        |   12 
 kernel/kcsan/core.c                                                           |   12 
 kernel/kprobes.c                                                              |   14 
 kernel/locking/lockdep.c                                                      |    2 
 kernel/module/dups.c                                                          |   99 
 kernel/module/stats.c                                                         |    2 
 kernel/panic.c                                                                |   53 
 kernel/power/snapshot.c                                                       |    5 
 kernel/power/wakelock.c                                                       |    2 
 kernel/printk/internal.h                                                      |    2 
 kernel/printk/nbcon.c                                                         |   10 
 kernel/printk/printk.c                                                        |  218 +-
 kernel/printk/printk_ringbuffer.c                                             |   13 
 kernel/rcu/tree_plugin.h                                                      |   10 
 kernel/sched/cpufreq_schedutil.c                                              |    2 
 kernel/sched/fair.c                                                           |   27 
 kernel/sys.c                                                                  |    2 
 kernel/time/clocksource.c                                                     |    8 
 kernel/time/timekeeping.c                                                     |    6 
 kernel/trace/ftrace.c                                                         |   13 
 kernel/trace/ring_buffer.c                                                    |    2 
 kernel/trace/trace.c                                                          |   28 
 kernel/trace/trace.h                                                          |    4 
 kernel/trace/trace_events.c                                                   |  132 +
 lib/dump_stack.c                                                              |    2 
 lib/maple_tree.c                                                              |   43 
 lib/string.c                                                                  |    3 
 lib/test_hmm.c                                                                |    2 
 mm/Kconfig                                                                    |   57 
 mm/Kconfig.debug                                                              |   11 
 mm/Makefile                                                                   |    2 
 mm/damon/core.c                                                               |   17 
 mm/damon/ops-common.c                                                         |    5 
 mm/damon/paddr.c                                                              |   20 
 mm/damon/sysfs-schemes.c                                                      |   14 
 mm/damon/sysfs.c                                                              |   19 
 mm/damon/tests/core-kunit.h                                                   |   15 
 mm/damon/tests/vaddr-kunit.h                                                  |    5 
 mm/damon/vaddr.c                                                              |   34 
 mm/hugetlb.c                                                                  |   22 
 mm/memcontrol-v1.c                                                            |   43 
 mm/memory_hotplug.c                                                           |   42 
 mm/mempolicy.c                                                                |    2 
 mm/mm_init.c                                                                  |   19 
 mm/page_vma_mapped.c                                                          |    8 
 mm/ptdump.c                                                                   |   42 
 mm/slab.h                                                                     |    1 
 mm/slub.c                                                                     |   36 
 net/batman-adv/bridge_loop_avoidance.c                                        |   78 
 net/batman-adv/distributed-arp-table.c                                        |   66 
 net/batman-adv/main.c                                                         |    4 
 net/batman-adv/multicast_forw.c                                               |    7 
 net/batman-adv/soft-interface.c                                               |    7 
 net/batman-adv/types.h                                                        |    2 
 net/bluetooth/hci_conn.c                                                      |   20 
 net/bluetooth/hci_sync.c                                                      |   12 
 net/bluetooth/l2cap_sock.c                                                    |   36 
 net/bluetooth/mgmt.c                                                          |   27 
 net/bluetooth/msft.c                                                          |    5 
 net/bluetooth/rfcomm/core.c                                                   |    4 
 net/bridge/br_netlink_tunnel.c                                                |    3 
 net/bridge/br_vlan.c                                                          |    4 
 net/ceph/messenger_v2.c                                                       |    5 
 net/core/dev.c                                                                |    1 
 net/core/filter.c                                                             |    4 
 net/core/lwt_bpf.c                                                            |   15 
 net/core/net_namespace.c                                                      |    4 
 net/core/page_pool.c                                                          |   79 
 net/core/skbuff.c                                                             |   11 
 net/dccp/dccp.h                                                               |    4 
 net/dccp/ipv4.c                                                               |    4 
 net/dccp/ipv6.c                                                               |    7 
 net/dccp/minisocks.c                                                          |    2 
 net/hsr/hsr_device.c                                                          |    2 
 net/ipv4/inet_connection_sock.c                                               |    9 
 net/ipv4/inetpeer.c                                                           |   38 
 net/ipv4/syncookies.c                                                         |    2 
 net/ipv4/tcp_fastopen.c                                                       |    2 
 net/ipv4/tcp_ipv4.c                                                           |    8 
 net/ipv4/tcp_minisocks.c                                                      |    2 
 net/ipv4/tcp_output.c                                                         |    2 
 net/ipv6/tcp_ipv6.c                                                           |   97 
 net/ipv6/xfrm6_input.c                                                        |    2 
 net/kcm/kcmsock.c                                                             |    3 
 net/mac80211/link.c                                                           |    3 
 net/mac80211/mlme.c                                                           |    2 
 net/mac80211/s1g.c                                                            |    2 
 net/mac80211/spectmgmt.c                                                      |   11 
 net/mac80211/tx.c                                                             |    3 
 net/mptcp/subflow.c                                                           |    6 
 net/netfilter/Kconfig                                                         |    2 
 net/netfilter/ipvs/ip_vs_ftp.c                                                |   10 
 net/netfilter/nf_nat_sip.c                                                    |    5 
 net/netfilter/nf_tables_api.c                                                 |   14 
 net/netfilter/xt_cgroup.c                                                     |   21 
 net/netfilter/xt_hl.c                                                         |   27 
 net/nfc/digital_core.c                                                        |    2 
 net/nfc/llcp_core.c                                                           |   29 
 net/nfc/llcp_sock.c                                                           |   14 
 net/nfc/nci/data.c                                                            |   10 
 net/nfc/nci/rsp.c                                                             |   41 
 net/openvswitch/conntrack.c                                                   |  121 -
 net/openvswitch/conntrack.h                                                   |    6 
 net/openvswitch/datapath.c                                                    |   10 
 net/openvswitch/datapath.h                                                    |   26 
 net/openvswitch/vport.h                                                       |    9 
 net/phonet/pep.c                                                              |    2 
 net/rds/cong.c                                                                |    4 
 net/sched/act_api.c                                                           |    5 
 net/sched/act_bpf.c                                                           |   26 
 net/sched/act_ct.c                                                            |   76 
 net/sched/act_ctinfo.c                                                        |   34 
 net/sched/act_ife.c                                                           |   23 
 net/sched/act_pedit.c                                                         |   24 
 net/sched/act_police.c                                                        |   12 
 net/sched/act_sample.c                                                        |    9 
 net/sched/act_skbedit.c                                                       |   20 
 net/sched/act_skbmod.c                                                        |   34 
 net/sched/act_tunnel_key.c                                                    |   96 
 net/sched/act_vlan.c                                                          |   16 
 net/sched/cls_api.c                                                           |   18 
 net/sched/sch_api.c                                                           |    7 
 net/sched/sch_codel.c                                                         |    2 
 net/sched/sch_fifo.c                                                          |    2 
 net/sched/sch_fq.c                                                            |   18 
 net/sched/sch_fq_codel.c                                                      |    6 
 net/sched/sch_fq_pie.c                                                        |    3 
 net/sched/sch_gred.c                                                          |    4 
 net/sched/sch_hhf.c                                                           |    4 
 net/sched/sch_htb.c                                                           |    7 
 net/sched/sch_plug.c                                                          |    2 
 net/sched/sch_sfq.c                                                           |    3 
 net/sched/sch_teql.c                                                          |    1 
 net/smc/af_smc.c                                                              |    8 
 net/smc/smc_inet.c                                                            |   16 
 net/smc/smc_llc.c                                                             |    3 
 net/sunrpc/rpcb_clnt.c                                                        |    4 
 net/sunrpc/xprtsock.c                                                         |   20 
 net/tls/tls_strp.c                                                            |   16 
 net/vmw_vsock/af_vsock.c                                                      |   23 
 net/xdp/xsk.c                                                                 |   57 
 net/xdp/xsk_buff_pool.c                                                       |    4 
 net/xdp/xsk_queue.h                                                           |   16 
 net/xfrm/xfrm_output.c                                                        |    4 
 samples/ftrace/ftrace-direct-modify.c                                         |   12 
 samples/ftrace/ftrace-direct-multi-modify.c                                   |   12 
 scripts/mod/modpost.c                                                         |    6 
 scripts/tags.sh                                                               |    2 
 security/apparmor/lib.c                                                       |   20 
 security/integrity/Makefile                                                   |    1 
 security/integrity/efi_secureboot.c                                           |   56 
 security/integrity/ima/ima_appraise.c                                         |    4 
 security/integrity/ima/ima_efi.c                                              |   47 
 security/integrity/ima/ima_main.c                                             |    3 
 security/integrity/integrity.h                                                |    1 
 security/integrity/platform_certs/load_uefi.c                                 |    2 
 security/landlock/errata/abi-1.h                                              |   23 
 security/landlock/fs.c                                                        |   40 
 security/smack/smack.h                                                        |    5 
 security/smack/smack_lsm.c                                                    |   67 
 security/smack/smackfs.c                                                      |  218 --
 sound/core/control.c                                                          |    6 
 sound/core/control_led.c                                                      |   13 
 sound/core/init.c                                                             |    4 
 sound/core/pcm_native.c                                                       |    2 
 sound/core/rawmidi.c                                                          |    2 
 sound/core/seq/seq_clientmgr.c                                                |   16 
 sound/core/seq/seq_midi.c                                                     |   61 
 sound/parisc/harmony.c                                                        |    6 
 sound/pci/asihpi/hpi6000.c                                                    |    5 
 sound/pci/hda/hda_proc.c                                                      |    2 
 sound/pci/ice1712/ice1712.c                                                   |    7 
 sound/pci/via82xx_modem.c                                                     |   26 
 sound/soc/apple/mca.c                                                         |    6 
 sound/soc/codecs/cs35l33.c                                                    |   14 
 sound/soc/codecs/cs35l34.c                                                    |   14 
 sound/soc/codecs/hdac_hda.c                                                   |    4 
 sound/soc/codecs/rt700-sdw.c                                                  |    6 
 sound/soc/fsl/fsl-asoc-card.c                                                 |    4 
 sound/soc/fsl/fsl_audmix.c                                                    |   24 
 sound/soc/fsl/mpc5200_psc_i2s.c                                               |    1 
 sound/soc/intel/atom/sst/sst_pci.c                                            |    4 
 sound/soc/loongson/loongson_card.c                                            |    6 
 sound/soc/meson/meson-card-utils.c                                            |   17 
 sound/soc/pxa/pxa-ssp.c                                                       |    7 
 sound/soc/qcom/qdsp6/q6apm.c                                                  |   12 
 sound/soc/samsung/aries_wm8994.c                                              |    1 
 sound/soc/soc-dapm.c                                                          |    2 
 sound/soc/sof/topology.c                                                      |   18 
 sound/soc/xilinx/xlnx_formatter_pcm.c                                         |   14 
 sound/usb/midi.c                                                              |    2 
 tools/bpf/bpftool/map.c                                                       |   16 
 tools/bpf/bpftool/struct_ops.c                                                |    4 
 tools/build/Makefile.feature                                                  |    3 
 tools/build/feature/Makefile                                                  |    3 
 tools/include/nolibc/arch-powerpc.h                                           |    2 
 tools/include/uapi/linux/bpf.h                                                |    7 
 tools/lib/bpf/libbpf.c                                                        |    3 
 tools/net/sunrpc/xdrgen/README                                                |   17 
 tools/net/sunrpc/xdrgen/generators/enum.py                                    |   17 
 tools/net/sunrpc/xdrgen/generators/union.py                                   |   34 
 tools/net/sunrpc/xdrgen/grammars/xdr.lark                                     |    4 
 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/close.j2                 |    5 
 tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum.j2                      |    2 
 tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum_be.j2                   |   14 
 tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2                  |    2 
 tools/net/sunrpc/xdrgen/templates/C/enum/definition/close_be.j2               |    4 
 tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum.j2                      |    2 
 tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum_be.j2                   |   14 
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_opaque.j2 |    2 
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_string.j2 |    2 
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_opaque.j2  |    2 
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_string.j2  |    2 
 tools/net/sunrpc/xdrgen/templates/C/union/decoder/case_spec_be.j2             |    2 
 tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2                 |    5 
 tools/net/sunrpc/xdrgen/templates/C/union/encoder/case_spec_be.j2             |    2 
 tools/net/sunrpc/xdrgen/xdr_ast.py                                            |    7 
 tools/objtool/check.c                                                         |    3 
 tools/perf/builtin-sched.c                                                    |   40 
 tools/perf/builtin-stat.c                                                     |    9 
 tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json                    |  160 +
 tools/perf/pmu-events/arch/x86/amdzen5/load-store.json                        |    8 
 tools/perf/pmu-events/jevents.py                                              |    5 
 tools/perf/pmu-events/metric.py                                               |    6 
 tools/perf/scripts/python/Perf-Trace-Util/Context.c                           |   18 
 tools/perf/tests/builtin-test.c                                               |  511 +++-
 tools/perf/tests/shell/lib/perf_metric_validation.py                          |   11 
 tools/perf/tests/shell/stat_all_metrics.sh                                    |  151 +
 tools/perf/tests/shell/stat_bpf_counters.sh                                   |   44 
 tools/perf/tests/shell/stat_metrics_values.sh                                 |    7 
 tools/perf/tests/shell/test_brstack.sh                                        |  237 ++
 tools/perf/tests/task-exit.c                                                  |    9 
 tools/perf/tests/tests-scripts.c                                              |    7 
 tools/perf/tests/tests.h                                                      |   12 
 tools/perf/tests/workloads/Build                                              |    2 
 tools/perf/tests/workloads/traploop.c                                         |   31 
 tools/perf/ui/browsers/hists.c                                                |    6 
 tools/perf/util/auxtrace.c                                                    |   15 
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c                         |  155 -
 tools/perf/util/color.h                                                       |    1 
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c                               |   21 
 tools/perf/util/cs-etm.c                                                      |  321 +--
 tools/perf/util/cs-etm.h                                                      |    8 
 tools/perf/util/data-convert-json.c                                           |    1 
 tools/perf/util/dso.c                                                         |   23 
 tools/perf/util/dso.h                                                         |   57 
 tools/perf/util/intel-bts.c                                                   |    2 
 tools/perf/util/intel-pt.c                                                    |    2 
 tools/perf/util/machine.c                                                     |   37 
 tools/perf/util/metricgroup.c                                                 |    7 
 tools/perf/util/python.c                                                      |  187 +
 tools/perf/util/scripting-engines/trace-event-python.c                        |   63 
 tools/perf/util/synthetic-events.c                                            |    6 
 tools/perf/util/thread-stack.c                                                |    2 
 tools/perf/util/trace-event-read.c                                            |   33 
 tools/sched_ext/scx_flatcg.bpf.c                                              |   19 
 tools/scripts/Makefile.include                                                |   38 
 tools/testing/kunit/kunit.py                                                  |    2 
 tools/testing/kunit/kunit_tool_test.py                                        |   12 
 tools/testing/selftests/arm64/mte/check_buffer_fill.c                         |    2 
 tools/testing/selftests/arm64/mte/check_child_memory.c                        |    2 
 tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c                     |    1 
 tools/testing/selftests/arm64/mte/check_hugetlb_options.c                     |  298 ++
 tools/testing/selftests/arm64/mte/check_ksm_options.c                         |   31 
 tools/testing/selftests/arm64/mte/check_mmap_options.c                        |    2 
 tools/testing/selftests/arm64/mte/check_tags_inclusion.c                      |    2 
 tools/testing/selftests/arm64/mte/check_user_mem.c                            |    2 
 tools/testing/selftests/bpf/README.rst                                        |    4 
 tools/testing/selftests/bpf/network_helpers.c                                 |   10 
 tools/testing/selftests/bpf/network_helpers.h                                 |    5 
 tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c                        |   69 
 tools/testing/selftests/bpf/prog_tests/global_map_resize.c                    |    8 
 tools/testing/selftests/bpf/prog_tests/mptcp.c                                |   13 
 tools/testing/selftests/bpf/progs/bpf_tracing_net.h                           |    3 
 tools/testing/selftests/bpf/progs/mptcpify.c                                  |    2 
 tools/testing/selftests/bpf/test_progs.c                                      |   11 
 tools/testing/selftests/bpf/test_sockmap.c                                    |    3 
 tools/testing/selftests/bpf/veristat.c                                        |   76 
 tools/testing/selftests/bpf/vmtest.sh                                         |   13 
 tools/testing/selftests/cgroup/test_cpuset_prs.sh                             |  494 ++--
 tools/testing/selftests/kselftest_harness.h                                   |   14 
 tools/testing/selftests/lsm/common.c                                          |    4 
 tools/testing/selftests/mm/cow.c                                              |  348 ++-
 tools/testing/selftests/mm/khugepaged.c                                       |    5 
 tools/testing/selftests/mm/ksm_tests.c                                        |  210 -
 tools/testing/selftests/mm/migration.c                                        |  107 +
 tools/testing/selftests/mm/soft-dirty.c                                       |    9 
 tools/testing/selftests/mm/thp_settings.c                                     |   11 
 tools/testing/selftests/mm/thp_settings.h                                     |    2 
 tools/testing/selftests/rseq/rseq-x86-thread-pointer.h                        |    4 
 tools/testing/selftests/sched_ext/prog_run.c                                  |   34 
 tools/testing/selftests/timers/leap-a-day.c                                   |   19 
 tools/testing/selftests/zram/zram_lib.sh                                      |    2 
 1219 files changed, 20716 insertions(+), 8746 deletions(-)

Abd-Alrhman Masalkhi (2):
      md: recheck spare changes before starting sync
      md: skip redundant raid_disks update when value is unchanged

Abdun Nihaal (2):
      wifi: rtlwifi: pci: fix error path in rtl_pci_probe()
      misc: vmc_vmci: Fix potential memory leak in vmci_event_subscribe()

Abel Vesa (1):
      phy: qualcomm: qmp-combo: Add DP offsets and settings for Glymur platforms

Ada Couprie Diaz (1):
      arm64: hibernate: mask DAIF before restoring hibernated kernel

Adam Young (1):
      mailbox/pcc: support mailbox management of the shared buffer

Adrian Hunter (8):
      i3c: master: Fix device_register() error path
      perf/x86/intel/pt: Add support for pause / resume
      perf/x86/intel/pt: Factor out pt_config_enable()
      perf/x86/intel/pt: Use bitwise access for PERF_HES_STOPPED
      perf/x86/intel/pt: Fix stop/start with no update
      i3c: mipi-i3c-hci: Quieten initialization messages
      i3c: mipi-i3c-hci: Switch PIO data allocation to devm_kzalloc()
      i3c: mipi-i3c-hci: Refactor PIO register initialization

Ahmad Byagowi (1):
      i2c: mux: Fix channel node leak on adapter add failure

Ahmet Sezgin Duran (1):
      staging: sm750fb: gate dualview dataflow using g_dualview

Ai Chao (1):
      HID: i2c-hid: Fix "(null)" output when reading report descriptor fails

Akari Tsuyukusa (2):
      iommu/mediatek-v1: Fix off-by-one in MT2701_LARB_NR_MAX
      clk: mediatek: mt8135: Fix inverted gate control for devapc_ck

Akif (1):
      ksmbd: fix use-after-free in smb2_open during durable reconnect

Al Viro (1):
      o2hb_region_dev_store(): avoid goto around fdget()/fdput()

Alban Bedel (1):
      software node: Fix software_node_get_reference_args() with index -1

Aleksandr Nogikh (4):
      usb: gadget: midi2: Fix null-pointer dereference in f_midi2_free_ep_reqs
      udf: Mark LVID buffer as uptodate before marking it dirty
      ALSA: core: Fix use-after-free in snd_card_do_free()
      libceph: validate banner payload length

Alexander A. Klimov (2):
      clk: moxart: remove unused variables, fix refcount leak
      staging: greybus: audio: correct sscanf() return value check

Alexander Popov (1):
      x86/Kconfig: Reenable PTDUMP on i386

Alexei Starovoitov (2):
      slab: Make slub local_(try)lock more precise for LOCKDEP
      slab: Reuse first bit for OBJEXTS_ALLOC_FAIL

Alexey Charkov (2):
      clk: rockchip: Fix the fractional part denominator on RK3588/RK3576 PLLs
      clk: rockchip: rk3576: fix source muxes for SPI0..SPI4

Alexis Lothoré (eBPF Foundation) (1):
      selftests/bpf: Systematically add SO_REUSEADDR in start_server_addr

Ali Ahmet Memis (1):
      Bluetooth: MSFT: validate evt_prefix_len against the response length

Ali Tariq (2):
      PCI: starfive: Fix Runtime PM handling and teardown ordering
      PCI: starfive: Fix unchecked pm_runtime_get_sync() in probe

Alice Mikityanska (1):
      virtio-net: Ensure that TCP packets don't overflow gso_segs

Alison Schofield (1):
      cxl/region: Fix use-after-free in find_pos_and_ways() error path

Alistair Francis (1):
      nvme: Add the DHCHAP maximum HD IDs

Allison Henderson (2):
      RDMA/rxe: Avoid reprocessing the current packet after the QP enters the error state
      net/rds: use wq_has_sleeper() in rds_cong_map_updated()

Amit Barzilai (2):
      drm/ssd130x: fix column and row end address in partial updates for ssd132x
      drm/ssd130x: fix column and row end address in partial updates in ssd133x

Andre Przywara (1):
      ARM: dts: allwinner: a10: Fix PMU interrupt

Andreas Kemnade (1):
      drm/omap: dsi: Do not copy isr table

Andreas Schwab (1):
      m68k: nfcon: Do not call console_is_registered() in nfcon_device()

Andrew Murray (1):
      printk: Introduce console_flush_one_record

Andy Shevchenko (1):
      usb: f_mass_storage: Bump local buffer size in fsg_common_create_luns()

Aneesh Kumar K.V (Arm) (3):
      dma-direct: return struct page from dma_direct_alloc_from_pool()
      iommu/dma: Check atomic pool allocation result directly
      swiotlb: Preserve allocation virtual address for dynamic pools

Anshumali Gaur (1):
      octeontx2-af: fix NULL deref in NIX TM tree debugfs read path

Anshuman Khandual (3):
      mm: make DEBUG_WX depdendent on GENERIC_PTDUMP
      mm: rename GENERIC_PTDUMP and PTDUMP_CORE
      mm/ptdump: split note_page() into level specific callbacks

Anthony Krowiak (8):
      s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
      s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap_mdev_cfg_remove
      s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
      s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL
      s390/vfio-ap: Fix hot-unplug skipped when last AP adapter or domain removed
      s390/vfio-ap: Fix NULL deref in status_show() during queue probe
      s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap
      s390/vfio-ap: Fix required lock not held during update of ap_matrix_mdev object

Arash Golgol (1):
      media: vimc: fix pixel format lookup in enum_framesizes

Armin Wolf (3):
      platform/x86: dell-privacy: Fix race condition
      platform/x86: dell-wmi-base: Fix resource leak on module load failure
      platform/x86: lg-laptop: Fix LED resource handling

Arnaldo Carvalho de Melo (17):
      perf sched: Fix register_pid() overflow, strcpy, and BUG_ON
      perf machine: Fix NULL parent dereference in fork event processing
      perf machine: Guard against NULL strlist in machines__findnew()
      perf machine: Use snprintf() for guestmount path construction
      perf machine: Check snprintf truncation in machines__findnew()
      perf machine: Don't abort guest map creation on first inaccessible dir
      perf machine: Reset errno before strtol in guest kernel map creation
      perf machine: Free scandir entries in guest kernel map creation
      perf machine: Check snprintf truncation for guest kallsyms path
      perf thread-stack: Fix heap buffer overflow on branch stack wrap copy
      perf auxtrace: Fix queue grow overflow and old array leak
      perf intel-pt: Fix off-by-one in auxtrace_info minimum size check
      perf intel-bts: Fix off-by-one in auxtrace_info minimum size check
      perf test: Introduce workloads__for_each()
      perf dso: Guard close() against invalid fd in dso__decompress_kmodule_path()
      perf dso: Use stored fd error instead of stale errno in file_read() and file_size()
      perf dso: Guard against cache underflow on short reads in dso_cache__memcpy()

Arnaud Bonnet (2):
      nfs: replace atomic bitops sequence with clear_and_wake_up_bit helper
      nfs: refactor pNFS functions using clear_and_wake_up_bit

Arnd Bergmann (1):
      Bluetooth: btmtk: hide unused btmtk_mt6639_devs[] array

Arthur Gautier (1):
      xhci: fix lost bounce buffers on TDs spanning several ring segments

Asad Kamal (2):
      drm/amdgpu/pm/powerplay: bounds-check voltage index in SMU7 lookup
      drm/amdgpu/pm/powerplay: bounds-check voltage index in Vega10 lookup

Atish Patra (1):
      crypto: ccp - Fix memory leak in SEV INIT_EX path

Avraham Stern (2):
      wifi: iwlwifi: mei: check SAP message length before reading it
      wifi: iwlwifi: mei: pass correct argument to function

Avri Altman (1):
      scsi: ufs: core: Remove redundant host_lock calls around UTMRLDBR

Ayush Mukkanwar (4):
      staging: octeon: add missing tasklet_kill in cvm_oct_tx_shutdown
      staging: octeon: ethernet-mem: replace pr_warn with dev_warn in free functions
      staging: octeon: replace pr_warn with dev_warn in fill and rx paths
      staging: octeon: add missing napi_disable in cvm_oct_rx_shutdown

Babanpreet Singh (3):
      power: supply: sbs-battery: Use a per-device serial number buffer
      w1: ds2482: Fix signedness bug in ds2482_w1_triplet()
      spi: sprd-adi: Fix probe succeeding without registering the controller

Baochen Qiang (1):
      wifi: ath11k: cap out-of-range rx MCS instead of leaving bogus rate

Baokun Li (3):
      ext4: drain in-flight DIO before buffered write fallback
      cuse: wait for pending RCU callbacks on module exit
      fuse: check for NULL root inode in fuse_fill_super_submount

Bart Van Assche (1):
      scsi: ufs: core: Set task state before io_schedule_timeout()

Bastien Curutchet (1):
      pps: clients: gpio: Bypass edge's direction check when not needed

Baul Lee (1):
      vxlan: mdb: Fix use-after-free in vxlan_mdb_flush()

Bibo Mao (1):
      LoongArch: Fix acpi_package_ids[] array overflow

Bijan Tabatabai (1):
      x86/pkeys: Fix pkey_alloc() return value when pkeys are not supported

Biju Das (2):
      usb: renesas_usbhs: Fix power-off ordering on unbind
      irqchip/renesas-rzg2l: Fix loss of interrupt

Binbin Zhou (1):
      ASoC: loongson: Fix error handling in ACPI property parsing

Biren Pandya (5):
      media: cec: disable delayed work before freeing an interrupted transmit
      media: i2c: ov02a10: fix endpoint parsing use-after-free
      media: i2c: ov7740: fix use-after-destroy in remove
      media: v4l2-fwnode: Fix fwnode leak in v4l2_fwnode_parse_link
      media: i2c: rdacm21: Fix missing media_entity_cleanup()

Bjorn Andersson (3):
      usb: typec: ucsi: unregister debugfs entries on teardown
      remoteproc: Allow shutdown of crashed processors
      remoteproc: Prevent crash handling to race with rproc_del()

Bjorn Helgaas (1):
      PCI/ASPM: Cache L0s/L1 Supported so advertised link states can be overridden

Boshi Yu (9):
      RDMA/erdma: Probe the erdma RoCEv2 device
      RDMA/erdma: Add GID table management interfaces
      RDMA/erdma: Add the erdma_query_pkey() interface
      RDMA/erdma: Add address handle implementation
      RDMA/erdma: Add erdma_modify_qp_rocev2() interface
      RDMA/erdma: Refactor the code of the modify_qp interface
      RDMA/erdma: Add the query_qp command to the cmdq
      RDMA/erdma: Fix incorrect response returned from query_qp
      RDMA/erdma: Support non-sleeping erdma_post_cmd_wait()

Bradley Morgan (3):
      ima: Check for ERR_PTR from dentry_path() in validate_hash_algo()
      lib/string: fix memchr_inv() for large ranges
      prctl: fix PR_SET_MM_AUXV losing the forced AT_NULL terminator

Breno Leitao (5):
      efi: fix stale reference to efi_recover_from_page_fault()
      cacheinfo: don't propagate DT/ACPI error when arch supplies info (arm64)
      phonet: pep: do not write beyond optlen in getsockopt
      nfc: llcp: avoid userspace overflow on invalid optlen
      nfc: llcp: read llcp_sock->local under the socket lock in getsockopt

Brian Masney (3):
      clk: nuvoton: ma35d1-pll: convert from round_rate() to determine_rate()
      clk: imx: scu: drop redundant init.ops variable assignment
      clk: qcom: camcc-sc8280xp: unregister CAMCC_GDSC_CLK

Bruce Johnston (1):
      md/raid1: don't set array_frozen in raid1_takeover()

Bryam Vargas (4):
      nvdimm/btt: reject an arena whose nfree is below the lane count
      media: cx231xx: reject geometry changes while the VBI queue is busy
      greybus: audio: bound the topology section sizes against the fetched size
      libnvdimm/labels: Bound the on-media label size before the shift

Byungchul Park (1):
      page_pool: rename __page_pool_release_page_dma() to __page_pool_release_netmem_dma()

Caleb Sander Mateos (1):
      ublk: check for ublk_unmap_io() returning 0

Calvin Owens (2):
      pps: don't try to wait for negative timeouts in PPS_FETCH
      pps-gpio: remove dead capture_clear code

Can Peng (11):
      thermal/drivers/imx: Disable clock on runtime resume failure
      thermal/drivers/qoriq: Disable clock on resume failure
      spi: bcm63xx-hsspi: disable clocks on resume failure
      spi: bcm63xx: disable clock on resume failure
      spi: bcmbca-hsspi: disable clocks on resume failure
      iio: pressure: mpl115: Fix runtime PM cleanup
      phy: starfive: Fix runtime PM cleanup in JH7110 DPHY TX probe
      phy: starfive: Fix runtime PM cleanup in JH7110 DPHY RX probe
      drm/tve200: add OF module alias for autoloading
      crypto: keembay - publish OF module alias for OCS AES/SM4
      ACPI: processor: Unregister cpufreq notifier on init failure

Carlos López (1):
      KVM: x86: hyper-v: Clamp stimer deadline to avoid livelock

Casey Schaufler (1):
      Smack: Fix error in capability bypass

Catalin Marinas (2):
      kselftest/arm64: mte: Skip the hugetlb tests if MTE not supported on such mappings
      kselftest/arm64: mte: Use the correct naming for tag check modes in check_hugetlb_options.c

Cen Zhang (3):
      wifi: mac80211_hwsim: avoid NULL skb in stop queue drain
      ocfs2/cluster: keep heartbeat local node stable
      ocfs2: synchronize heartbeat callbacks with o2net teardown

Cen Zhang (Microsoft) (2):
      xsk: fix NULL pointer dereference in __xsk_rcv()
      gtp: add synchronize_net() in gtp_newlink() error path to prevent use-after-free

Chaithanya Lagisetty (1):
      LoongArch: KVM: Free init resources if kvm_init() fails

Chandrakanth Patil (1):
      scsi: mpt3sas: Avoid freeing unallocated PCIe SGL buffers

Chao Huang (1):
      HID: i2c-hid: goodix: Disable VDD on VDDIO enable failure

Chao Shi (1):
      nvme: reject passthrough of driver-managed Set Features

Chao Yu (5):
      f2fs: fix to off-by-one issue in f2fs_zero_post_eof_page()
      f2fs: fix to zero post-EOF data when extending file size
      f2fs: fix to parse temperature correctly in f2fs_get_segment_temp()
      f2fs: cleanup w/ f2fs_need_rand_{blk, seg, seg_blk}
      f2fs: fix to avoid pinfile fragment on fragment:{block, segment} mode

Chen Changcheng (1):
      f2fs: fix valid block count leak on data block allocation failure

Chen Cheng (5):
      md/raid5: protect bitmap batch counters aka seq_flush/seq_write consistency
      md/raid5: protect lockless recovery_offset accesses during reshape
      md/bitmap: resume array on backlog_store() error path
      md: remove unused mddev argument from export_rdev
      md: scope memalloc_noio to allocation critical sections

Chen Pei (1):
      ACPI: PCI: Clear driver_data on all paths that free the acpi_pci_root

Chen Ridong (1):
      cpuset: fix warning when disabling remote partition

Chen, Yu C (1):
      sched/fair: Fix overflow in update_tg_cfs_runnable()

Chen-Yu Tsai (2):
      pinctrl: mediatek: eint: Drop base from mtk_eint_chip_write_mask()
      pinctrl: mediatek: common-v1: Fix EINT breakage on older controllers

Cheng Xu (2):
      RDMA/erdma: Hold CQ references when processing EQ events
      RDMA/erdma: Hold QP references for AE and CM processing

Cheng-Han Wu (1):
      selftests/zram: fix kernel_gte() for POSIX sh

Chris Lu (2):
      Bluetooth: btmtksdio: Take exclusive ownership of the SKB before TX
      Bluetooth: btmtksdio: Fix out-of-bounds DMA read in the TX path

Christian Borntraeger (8):
      KVM: s390: Fix length check __import_wp_info()
      KVM: s390: Fix memory leak in guest debug handling
      KVM: s390: Fix old_data leak in guest debug error path
      KVM: s390: Free guest debug data on vcpu destroy
      KVM: s390: Take srcu when importing watchpoint data
      KVM: s390: Zero initialize irq in reinject_machine_check
      KVM: s390: pv: Fix rc/rrc offset for PVM_DUMP
      KVM: s390: Restore sigset on error path

Christian Hewitt (1):
      media: meson: vdec: fix NULL pointer deref in vdec_try_fmt_common

Christophe JAILLET (2):
      regulator: tps6594-regulator: Constify struct tps6594_regulator_irq_type
      accessibility: speakup: Fix incorrect string length computation in report_char_chartab_status()

Christophe Leroy (1):
      powerpc/vdso: Add a page for non-time data

Christopher Lusk (1):
      smb: client: fix request buffer leak in smb2_new_read_req()

Christos Maragkos (1):
      HID: nintendo: Fix imu_timestamp_us double increment per report

Chuck Lever (5):
      xdrgen: Rename "enum yada" types as just "yada"
      xdrgen: Implement big-endian enums
      xdrgen: Address some checkpatch whitespace complaints
      xdrgen: Do not declare union XDR functions in the definitions header
      xdrgen: Fix opaque and string encoders for unbounded members

Coiby Xu (2):
      integrity: Make arch_ima_get_secureboot integrity-wide
      s390: Drop unnecessary CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT

Cong Nguyen (4):
      iio: adc: pac1921: fix wrong channel used in trigger handler read
      iio: gyro: mpu3050: fix sign of raw angular velocity readings
      iio: srf04: fix pm_runtime handling on probe error path
      media: intel/ipu6: fix async notifier cleanup leak on parse error

Cosmo Chou (3):
      leds: pca9532: Fix inverted GPIO output polarity
      leds: pca9532: Fix phantom device registration on missing hardware
      rtc: pcf85363: Add error checking to regmap calls in probe()

Cássio Gabriel (1):
      ALSA: core: Add scoped cleanup helper for card references

Daeho Jeong (1):
      f2fs: fix to migrate all curseg types during free_segment_range

Damien Le Moal (1):
      block: flag zoned disks with GENHD_FL_NO_PART

Dan Carpenter (6):
      staging: fbtft: Use sysfs_emit_at() to print to sysfs file
      thermal/drivers/rcar: Fix error checking in probe()
      cpufreq: spear: Fix an IS_ERR() vs NULL bug in spear1340_set_cpu_rate()
      drm/xe: tests: fix error message in xe_migrate_sanity_test()
      scsi: qla2xxx: Fix an loop timeout test
      pinctrl: mediatek: common-v1: Fix error checking in mtk_eint_init()

Daniel Borkmann (2):
      bpf: Fix vmlinux BTF prep race in bpf_get_btf_vmlinux
      bpf, s390: Clear fetch destination on faulting arena atomic

Daniel McCarthy (1):
      pinctrl: bcm2835: Don't remove an unregistered GPIO chip

Danila Chernetsov (2):
      RDMA/hfi1: Propagate sdma_txinit_ahg() errors
      fbdev: kyro: Validate overlay viewport coordinates

Danilo Krummrich (1):
      drm: fix race between partial drm_dev_register() failure and ioctl

Dapeng Mi (1):
      perf/x86/intel: Fix kernel address leakages in LBR stack

Dave Jiang (3):
      cxl: Refactor user ioctl command path from mds to mailbox
      cxl/mbox: Break poison list loop on an empty payload
      cxl/pci: Honor -EPROBE_DEFER from component register setup

David (Ming Qiang) Wu (1):
      drm/amdgpu/vcn: fix integer overflow in dec_msg buffer count check

David Howells (2):
      netfs: Fix netfs_read_folio() to wait on writeback
      afs: Fix leak of ungot volume

David Lee (2):
      UDF symlink pathComponent header OOB read
      nilfs2: prevent out-of-bounds read in super root block parsing

David Matlack (1):
      selftests: harness: Mark test fixture objects __maybe_unused

David Stevens (1):
      x86/entry/fred: Encode frame pointer on entry

David Strahan (1):
      scsi: smartpqi: Fix AIO retry marker cleared by SCSI core between dispatches.

David Woodhouse (1):
      timekeeping: Account for monotonicity adjustment in ntp_error

Davidlohr Bueso (1):
      perf/cxlpmu: Fix 64-bit write to 32-bit HDM filter register

Dawei Feng (2):
      media: cedrus: fix memory leak in cedrus_init_ctrls()
      staging: rtl8723bs: fix mismatched free of HalData in rtw_sdio_if1_init()

Dawid Wróbel (1):
      arm64: dts: qcom: sm8250-xiaomi-elish: correct the board ID

Deepanshu Kartikey (3):
      drm/i915: Guard against NULL driver_data in i915_pci_probe()
      drm/gud: NUL-terminate TV mode names read from the device
      usb: atm: usbatm: fix invalid ci_range initialization

Desnes Nunes (1):
      iommu/vt-d: Fix UCTP context table slot when copying root entries

Dev Jain (1):
      mm/page_vma_mapped: use huge_ptep_get() for hugetlb

Devin Wittmayer (1):
      wifi: mt76: mt76x02: do not WARN on invalid rx descriptor length

Diego Fernando Mancera Gomez (1):
      media: em28xx: defer audio-only extension registration

Dmitry Antipov (1):
      smack: simplify write handlers of sysfs entries

Dmitry Baryshkov (4):
      arm64: dts: qcom: sm8250: sort out Iris power domains
      arm64: dts: qcom: sm8250: correct frequencies in the Iris OPP table
      clk: qcom: gcc-qcm2290: don't park QUP RCGs upon registration
      phy: qualcomm: qmp-combo: add support for SAR2130P

Donet Tom (1):
      selftests/mm: add new test cases to the migration test

Donghyeok Choe (1):
      printk/panic: Add option to allow non-panic CPUs to write to the ring buffer.

Doruk Tan Ozturk (1):
      nfc: llcp: bound SNL TLV parsing to the skb and add length checks

Dragos Tatulea (1):
      net/mlx5e: xsk: Fix unlocked writing to ICOSQ

Eason Lai (2):
      wifi: mt76: mt792x: fix use-after-free in mt76_rx_poll_complete
      wifi: mt76: mt792x: Fix memory leak in SDIO TX path

Eduard Zingerman (1):
      selftests/bpf: Fix for veristat file/prog filters processing

Emmanuel Grumbach (3):
      wifi: iwlwifi: fix counter type in iwl_fwrt_dump_error_logs
      wifi: iwlwifi: mvm: fix off-by-one in TXF key sanitiser
      wifi: iwlwifi: guard against division by zero in iwl_dbg_tlv_alloc_fragments

Enzo Matsumiya (1):
      smb: server: fix leak of ksmbd_ipc_login_request_ext() returned buffer

Eric Dumazet (12):
      tcp: fix potential race in tcp_v6_syn_recv_sock()
      mm/mempolicy: fix sleeping allocation in alloc_pages_bulk_weighted_interleave()
      inetpeer: randomize RB-tree node comparison using SipHash
      net_sched: act_skbmod: use RCU in tcf_skbmod_dump()
      net/sched: act_skbmod: fix length calculations and avoid invalid header warnings
      slip: remove slip_hangup() to fix use-after-free in slip_receive_buf()
      net_sched: act_ct: use RCU in tcf_ct_dump()
      net_sched: act_ctinfo: use RCU in tcf_ctinfo_dump()
      net_sched: act_skbedit: use RCU in tcf_skbedit_dump()
      net_sched: act_vlan: use RCU in tcf_vlan_dump()
      net_sched: act_tunnel_key: use RCU in tunnel_key_dump()
      net_sched: add back BH safety to tcf_lock

Erick Henrique (1):
      iio: dac: m62332: Fix regulator reference count imbalance

Esteban Urrutia (2):
      phy: qcom: qmp-combo: Correct pre-emphasis table for QMP v4 DP PHYs
      phy: qcom: qmp-combo: Drop qmp_v4_calibrate_dp_phy

Ethan Carter Edwards (1):
      clk: ti: use kcalloc() instead of kzalloc()

Eugen Hristev (1):
      media: bcm2835-unicam: Fix asc leaked in error/remove path

Evgenii Burenchev (2):
      ALSA: via82xx: Remove unreachable branch in snd_via686_pcm_pointer()
      ALSA: hpi: Check transport errors during HPI6000 adapter initialization

FUJITA Tomonori (1):
      objtool/rust: add one more `noreturn` Rust function

Fabio Estevam (1):
      arm64: dts: rockchip: Fix Gru WLAN sideband interrupt

Faisal Hassan (1):
      phy: qcom-qmp-combo: Use regulator_bulk_data with init_load_uA for regulator setup

Faith Ekstrand (1):
      drm/nouveau: Use write-combined maps for coherent

Fan Wu (8):
      usb: typec: qcom-pmic-typec: disable cc_debounce_dwork on stop
      usb: typec: qcom-pmic-typec: drain cc_debounce_dwork if port_start() fails
      usb: typec: qcom-pmic: cancel reset_work on stop
      iio: chemical: atlas-sensor: use iio_trigger_poll_nested() to fix remove UAF
      media: cx23885: cancel NetUP CI work before teardown
      spi: oc-tiny: switch to managed controller allocation
      spi: davinci: switch to managed controller allocation
      RDMA/cxgb4: Free debugfs on registration failure

Fan Ye (1):
      net: thunderbolt: Count delivered packets in rx_packets and rx_bytes

Fei Shao (1):
      usb: mtu3: allow system suspend during active gadget connection

Felix Fietkau (20):
      wifi: mt76: mt7996: validate RX band_idx before dereferencing phys[]
      wifi: mt76: mt7996: set MT76_MCU_RESET before waking MCU waiters on full reset
      wifi: mt76: mt7915: clear wcid mask under mutex after RCU pointer clear
      wifi: mt76: mt7915: avoid nss underflow in mt7915_mcu_get_sta_nss
      wifi: mt76: mt7996: don't report a zero TX bitrate
      wifi: mt76: mt7915: write RX header translation bit to the correct register
      wifi: mt76: fix stranded frames in mt76_txq_schedule_pending
      wifi: mt76: mt7915: poll the correct SLP CTRL register for the second adie
      wifi: mt76: mt7996: bound TLV walk in mt7996_mcu_get_chip_config
      wifi: mt76: mt7915: unwind state on add_interface failure
      wifi: mt76: mt7996: reserve space for the CSA-abort countdown TLV
      wifi: mt76: mt7915: use little-endian for bss_info_ra wire fields
      wifi: mt76: only consume the WO drop bit on WED v2 devices
      wifi: mt76: mt7915: unlink TWT flow if the MCU rejects the agreement
      wifi: mt76: mt7915: fix double hif2 init on the non-WED path
      wifi: mt76: mt7915: fix ext PHY use-after-free on register error path
      wifi: mt76: mt7915: release hif2 reference on probe IRQ failure
      wifi: mt76: mt7915: fix chainmask handling for non-dbdc phys on band 1
      wifi: mt76: mt7915: report RX chain signal for all RX paths
      wifi: mac80211: skip default WMM setup for AP_VLAN links

Felix Gu (3):
      remoteproc: qcom_q6v5_adsp: Fix reference leak for device node
      phy: sunplus: fix error handling in sp_uphy_init()
      spi: img-spfi: don't disable runtime PM on DMA deferred probe

Feng Yang (3):
      selftests/bpf: Fix memory leak in msg_alloc_iov
      selftests/bpf: Fix incorrect error checking for pthread_create
      selftests/bpf: Fix memory leak on subtest_states reallocation

Florian Westphal (1):
      netfilter: nf_nat_sip: rewind offset when NAT shrinks the packet

Frank Li (1):
      arm64: dts: imx8-ss-audio: Fix LPCG clock indices for ASRC0

Frank Sorenson (1):
      cifs: fix clearing stats for fastest execution of each smb2 command

Frieder Schrempf (1):
      arm64: dts: imx93-kontron: set memory node to 0x80000000/1GiB

Fu Hao (1):
      iommu/amd: Add support for Hygon family 18h model 4h IOAPIC

Gao Xiang (3):
      erofs: convert z_erofs_bind_cache() to folios
      erofs: support unaligned encoded data
      erofs: fix managed cache race for unaligned extents

Gary Guo (1):
      usb: fix UAF when probe runs concurrent to dyn ID removal

Gautam Menghani (1):
      perf python: Add support for 'struct perf_counts_values' to return counter data

Geert Uytterhoeven (3):
      clk: ti: Make sure clk_init_data is fully initialized
      clk: visconti: Make sure clk_init_data is fully initialized
      erofs: Fix EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS default logic

Gerald Loacker (1):
      phy: rockchip: phy-rockchip-inno-csidphy: fix rk1808 hsfreq table

Gerald Yang (1):
      ext4: clear stale xarray tags on folios skipped during writeback

Giorgi Tchankvetadze (1):
      iio: light: cm32181: return zero after writing calibscale

Giovanni Cabiddu (2):
      crypto: qat - cancel work on re-enable SR-IOV timeout
      crypto: qat - clear AES key schedule from stack

Gleb Markov (2):
      drm/amd/display: Remove unused-but-set variable hubp from
      misc: rtsx: add missing write register handling

Gou Hao (1):
      powerpc/smp: add NULL guard for cause_ipi in smp_muxed_ipi_message_pass

Greg Kroah-Hartman (4):
      USB: make single lock for all usb dynamic id lists
      USB: make to_usb_driver() use container_of_const()
      Bluetooth: btmtk: Fix short read errors in btmtk_usb_reg_read()
      Linux 6.12.110

Gregory Price (3):
      mm: add build-time option for hotplug memory default online type
      mm: name the anonymous MMOP enum as enum mmop
      mm/mm_init: handle alloc_percpu failure in free_area_init_core_hotplug

Griffin Kroah-Hartman (1):
      usb: image: mdc800: change kmalloc() to kzalloc()

Guanghui Yang (1):
      ext4: fix buffer_head leak in ext4_init_orphan_info

Guangshuo Li (11):
      media: platform: mtk-mdp3: Fix SCP device refcounting
      media: saa7164: fix cleanup on resource allocation failure
      drm/amdgpu: fix autosuspend cleanup during removal
      serial: qcom-geni: do not advance stale DMA completions
      clk: tegra: tegra124-emc: put EMC node on register failure
      rapidio: clear mport->net when rio_add_net() fails
      Bluetooth: btmtksdio: fix usage_count leak when autosuspend_delay is negative
      dmaengine: qcom-bam-dma: fix autosuspend cleanup during removal
      clocksource/drivers/clps711x: Do not unmap clocksource MMIO
      ksmbd: Do not skip lock checks for single-byte ranges
      platform/x86: hp-bioscfg: fix password encoding bounds check

Guenter Roeck (2):
      hwmon: (emc1403) Rely on subsystem locking
      bnxt_en: Fix call to hardware monitoring event handler

Gui-Dong Han (3):
      media: cec-pin: Fix event FIFO ordering
      nvme-apple: Use acquire/release for queue enabled state
      misc: bcm-vk: Use acquire/release for msgq_inited

Guillaume Maudoux (1):
      selftests/bpf: Mask socket type flags in mptcpify prog

Guillaume Morin (1):
      hugetlb: only adjust reservation during unmapping if mapcount is 0

Guixin Liu (5):
      nvme-fc: unmap cmd_iu DMA on rsp_iu mapping failure in init_request
      nvme: add reservation command's defines
      nvme: introduce change ptpl and iekey definition
      nvmet: fix heap out-of-bounds read in nvmet_auth_negotiate()
      nvmet: fix NULL pointer dereference in nvmet_execute_identify_ns_zns()

Guodong Xu (1):
      riscv: cpufeature: Clarify ISA spec version for canonical order

Guoniu Zhou (3):
      media: nxp: imx8-isi: Fix stream ID validation bypass in crossbar routing
      media: nxp: imx8-isi: Correct color map between V4L2 and ISI
      media: nxp: imx8-isi: Use BIT_ULL() for 64-bit stream masks

Guzebing (1):
      cxl/memdev: Fix firmware upload exact-fit handling

Günther Noack (1):
      landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout creation

HE WEI（ギカク） (1):
      fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()

Hajo Noerenberg (1):
      ata: ahci: work around lost interrupts on Marvell 88SE61xx

Hang Nan (1):
      ksmbd: bound smb_check_perm_dacl() ACE walks by DACL size

Hanlin Song (1):
      csky: Fix a4/a5 restoration in syscall trace path

Hans Verkuil (2):
      media: cec: extron-da-hd-4k-plus: add sanity check
      media: v4l2-async: Unregister sub-device if asc_list is empty

Hao Chang (3):
      pinctrl: mediatek: Add EINT support for multiple addresses
      pinctrl: mediatek: Fix the invalid conditions
      pinctrl: mediatek: Fix new design debounce issue

Hao Ge (2):
      selftests/mm/cow: modify the incorrect checking parameters
      slab: reset slab->obj_ext when freeing and it is OBJEXTS_ALLOC_FAIL

Hao-Qun Huang (1):
      f2fs: reject overlapping move range after len expansion

Haotian Zhang (3):
      ALSA: ice1712: Fix the card leak at probe error with the auto-cleanup
      samples/ftrace: Fix kthread_stop() on ERR_PTR in ftrace-direct-modify
      samples/ftrace: Fix kthread_stop() on ERR_PTR in ftrace-direct-multi-modify

Haowen Tu (1):
      PM: sleep: Fix off-by-one in wakelocks number limit check

Haoxiang Li (4):
      ASoC: fsl: mpc5200-i2s: Free DMA resources on probe failure
      ASoC: hdac_hda: Fix hlink refcount leak on component registration failure
      AsoC: intel: sst: fix PCI device reference leak on probe failure
      iommu/qcom: Remove sysfs device on probe failure path

Hari Mishal (1):
      drm/amd/display: fix division by zero in get_estimated_bw()

Harry Wentland (2):
      drm/amd/display: avoid divide-by-zero in __is_lut_linear()
      drm/amd/display: validate plane degamma LUT size for private color prop

Heiko Carstens (2):
      s390: Add missing _TIF defines
      s390: Add ARCH_HAS_PREEMPT_LAZY support

Heiko Stuebner (1):
      clk: rockchip: rk3588: Don't change PLL rates when setting dclk_vop2_src

Helge Deller (1):
      parisc: Fix alignment of asm statements in head.S

Henrik Grimler (4):
      drm/lima: call drm_mm_init() with a valid allocation range
      power: supply: bq27xxx: bq27520g4: fix REG_TTES address
      power: supply: bq27xxx: bq28z610: fix invalid AverageEnergy address
      power: supply: bq27xxx: bq27z561: fix invalid AverageEnergy address

Herman van Hazendonk (3):
      clk: qcom: gdsc: propagate gdsc_check_status() errors from gdsc_poll_status
      clk: qcom: gdsc: propagate gdsc_enable() failure for ALWAYS_ON domains
      clk: qcom: gdsc: tear down per-domain genpds in gdsc_unregister()

Hisam Mehboob (1):
      selftests/rseq: Replace glibc-specific __GNUC_PREREQ with portable check

Honghui Jiang (1):
      spi: Fix DMA mapping ownership on partial map failure

Hongyan Xu (7):
      usb: gadget: r8a66597: avoid double free of ep0_req in probe error path
      platform/chrome: cros_ec_debugfs: Clean up console log on probe failure
      platform/chrome: cros_ec_debugfs: Unregister panic notifier
      power: supply: isp1704_charger: cancel work on remove
      power: supply: sc2731_charger: cancel work on remove
      ACPI: scan: fix bus ID cleanup on device_add() failures
      block: mtip32xx: synchronize ioctls with device removal

Huisong Li (2):
      ACPI: processor: idle: Optimize ACPI idle driver registration
      mailbox: pcc: Fix command timeout due to missed interrupt

HyeongJun An (7):
      ALSA: usb-audio: fix OOB write in snd_usbmidi_us122l_output()
      ALSA: rawmidi: Return the error from snd_rawmidi_input_params()
      media: s2255: bound JPEG frame size before copying into the buffer
      Bluetooth: virtio_bt: avoid OOB read of build info string
      ALSA: seq: Don't leak the extension cell pointer in the bounce payload
      platform/x86: dell-wmi-sysman: Fix instance ID bounds
      ASoC: dapm: Fix off-by-one check on the second enum channel

Hyunwoo Kim (1):
      Bluetooth: RFCOMM: Validate MTU in rfcomm_apply_pn() to prevent infinite loop

Ian Rogers (25):
      perf test stat_all_metrics: Ensure missing events fail test
      perf tests metrics: Permission related fixes
      perf test metrics: Update all metrics for possibly failing default metrics
      perf test all metrics: Fully ignore Default metric failures
      perf tests: Skip metrics validation if system-wide recording lacks permission
      perf tests: Fix flakiness in BPF counters test on hybrid systems
      perf tests: Harden branch stack sampling test
      perf test: Fixes for check branch stack sampling
      perf tests: Fix flakiness in branch stack sampling tests
      perf jevents: Add more components to the metric sorting order
      perf ui hists: Fix uninitialized stack memory free on pstack allocation failure
      perf stat: Fix evsel_list leak in cmd_stat
      perf synthetic-events: Fix uninitialized pthread_join
      perf test: Display number of active running tests
      perf test: Add a signal handler around running a test
      perf test: Run parallel tests in two passes
      perf test: Add a signal handler to kill forked child processes
      perf test: Sort tests placing exclusive tests last
      perf test: Rename functions and variables for better clarity
      perf test: Send list output to stdout rather than stderr
      perf test: Support dynamic test suites with setup callback and private data
      perf test: Fix skiplist leak in cmd_test
      perf python: Remove python 2 scripting support
      perf python: Check counts_values size in set_values
      perf synthetic-events: Fix divide by zero in perf_event__synthesize_threads

Ibrahim Hashimov (2):
      HID: wacom: validate report length in wacom_intuos_pro2_bt_irq
      RDMA/rxe: Validate num_sge/cur_sge before indexing wqe->dma.sge[]

Ilya Krutskih (1):
      media: tda18250: fix possible integer overflow

Ilya Leoshkevich (1):
      s390/irqflags: Add out-of-line definitions of arch_local_irq_*() for KMSAN

Ilya Maximets (1):
      net: openvswitch: fix kernel-doc warnings in internal headers

Imran Shaik (2):
      clk: qcom: gpucc-qcm2290: Park RCG's clk source at XO during disable
      arm64: dts: qcom: agatti: Add missing CX power domain to DISPCC

Inochi Amaoto (1):
      riscv: dts: sophgo: cv180x: Allow the DMA multiplexer to set channel number for DMA controller

Ismail Tarim (2):
      Bluetooth: btmtk: Do not report success when subsys reset fails
      Bluetooth: btmtk: Do not discard the subsystem reset timeout

Israel Batista (2):
      mm: convert memory block states (MEM_*) macros to enum
      mm: change type of state in struct memory_block

Israel Téllez García (1):
      bpf: Fix pending_pos walk on 32-bit ring position wrap

Itai Handler (1):
      rcu: Mark accesses to ->rcu_urgent_qs and ->rcu_need_heavy_qs

Ivy Lopez (2):
      usb: gadget: f_midi2: fix use-after-free in string attribute show path
      staging: rtl8723bs: use kfree_sensitive() for key material

Jackson Lee (1):
      media: chips-media: wave5: Guard bit depth check with initial_info_obtained

Jakub Kicinski (1):
      i3c: dw: avoid shift-out-of-bounds when DAA assigns no devices

Jamal Hadi Salim (10):
      net: sched: fix 32-bit backlog wrap in gred, bfifo and plug enqueue
      net/sched: fq: add overflow bounds to quantum and initial quantum
      net/sched: fq_codel: clamp default quantum and mtu
      net/sched: sch_codel: clamp default mtu to avoid disabling CoDel
      net/sched: fq_pie: clamp default quantum to avoid signed overflow
      net/sched: hhf: clamp quantum before hhf_change() to avoid overflow
      net/sched: sfq: clamp quantum to avoid signed overflow soft lockup
      net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup
      net/sched: sch_htb: limit htb_classify inner-class filter hops
      net/sched: fq: clamp quantum and initial_quantum in change path

James Calligeros (1):
      ASoC: apple: mca: increase SERDES reset delay

James Clark (8):
      perf test brstack: Speed up running test by using tr -s instead of xargs
      perf test: Refactor brstack test
      perf test: Add syscall and address tests to brstack test
      perf test: Extend branch stack sampling test for Arm64 BRBE
      perf cs-etm: Queue context packets for frontend
      tools/build: Allow versioning of all LLVM tools defined in Makefile.include
      coresight: Change syncfreq to be a u8
      perf test: Don't signal all processes on system when interrupting tests

Jameson Thies (1):
      usb: typec: ucsi: displayport: Fix OOB altmode array index

Jan Kara (1):
      ext4: fix spurious message about orphan cleanup on RO fs

Jared.Huang (1):
      wifi: mt76: mt7925: fix msg len mismatch between driver and firmware

Jason Gunthorpe (1):
      RDMA/nldev: Fix locking when accessing mr->pd

Jason Xing (1):
      xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()

Javier Tia (2):
      wifi: mt76: mt7925: advertise EHT 320MHz capabilities for 6GHz band
      Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support

Jeff Johnson (9):
      wifi: ath6kl: avoid buffer overreads in WMI event handlers
      wifi: ath12k: Correctly copy the hint BSSID in WMI scan request
      wifi: ath11k: Correctly copy the hint BSSID in WMI scan request
      wifi: ath12k: Avoid buffer overread in ath12k_wmi_op_rx()
      wifi: ath11k: Avoid buffer overread in ath11k_wmi_tlv_op_rx()
      wifi: ath11k: fix overreads in ath11k_wmi_process_csa_switch_count_event()
      wifi: ath12k: fix stride mismatch in mac_phy_caps_parse()
      wifi: ath11k: fix stride mismatch in mac_phy_caps_parse()
      wifi: ath11k: fix leak in ath11k_service_ready_ext_event()

Jeff Layton (1):
      nfs: move the nfs4_data_server_cache into struct nfs_net

Jeffin Philip (2):
      usb: gadget: f_midi: initialize work in f_midi_alloc()
      usb: gadget: fix null pointer dereference in usb_put_function_instance()

Jens Remus (1):
      x86/cfi: Use symmetric SYM_START and SYM_END in __CFI_TYPE()

Jernej Skrabec (8):
      drm/sun4i: vi scaler: Fix coefficient selection
      drm/sun4i: tcon: Set output mux for DSI and LVDS
      drm/sun4i: tcon: Drop TCON TOP device reference
      drm/sun4i: hdmi: Don't leak sync polarity bits into packet control
      drm/sun4i: crtc: Propagate layer initialization error
      drm/sun4i: tcon: Drop remote endpoint reference
      drm/sun4i: dw-hdmi: Drop TCON TOP port reference
      drm/sun4i: hdmi-phy: Fix H6 8-bit MPLL config at 594 MHz

Jia Yang (2):
      mailbox: qcom-cpucp: fix PREEMPT_RT self-deadlock in IRQ handler
      mailbox: qcom-cpucp: handle NULL data in send_data callback

Jian-Ming Liao (1):
      i3c: mipi-i3c-hci: Fix missing STAT_IBI_STATUS_THLD in PIO mode

Jiancheng Huang (1):
      HID: lg4ff: validate report length before fixed offsets

Jiangong.Han (1):
      media: em28xx: fix use-after-free of dev_next->devlist on disconnect

Jiangshan Yi (1):
      selftests: timers: leap-a-day: Fix -w option and update usage comment

Jiawen Wu (1):
      net: wangxun: use BIT_ULL() to prevent shift overflow on 32-bit archs

Jiayuan Chen (1):
      tcp: fix corruption of urgent data on multi-segment retransmit

Jijie Shao (1):
      net: page_pool: fix UAF in __page_pool_release_netmem_dma on xa_cmpxchg race

Jinchao Wang (3):
      panic: introduce helper functions for panic state
      panic/printk: replace this_cpu_in_panic() with panic_on_this_cpu()
      panic/printk: replace other_cpu_in_panic() with panic_on_other_cpu()

Jingyi Wang (1):
      remoteproc: core: Attach rproc asynchronously in rproc_add() path via schedule_work()

Jinjie Ruan (5):
      entry: Fix seccomp bypass after ptrace with TSYNC
      powerpc/kexec_file: Fix null-ptr-def in extra size calculation
      powerpc/kexec_file: Prevent kexec range truncation
      riscv: kexec_file: Fix crashk_low_res not exclude bug
      powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()

Joanne Koong (2):
      fuse: support folios in struct fuse_args_pages and fuse_copy_pages()
      fuse: convert readdir to use folios

Joas Antonio dos Santos (1):
      ipvs: fix integer overflow in ftp helper port/address parsing

Joey Lu (3):
      clk: nuvoton: ma35d1: fix ignored div_u64 return values in PLL freq calculation
      clk: nuvoton: ma35d1: fix PLL_CTL1_FRAC bit field width and fractional calc
      clk: nuvoton: ma35d1: fix ma35d1_clk_pll_determine_rate logic

Johan Hovold (4):
      media: platform: mtk-mdp3: fix NULL deref on failed SCP lookup
      drm/bridge: dw-hdmi: fix i2c adapter leak on probe failure
      drm/panel-edp: fix i2c adapter leak on probe failure
      Bluetooth: btusb: refactor endpoint lookup

Johannes Berg (1):
      wifi: mac80211: disconnect on CSA to channel 0

John Groves (1):
      dax: read holder_ops once in dax_holder_notify_failure()

John Johansen (1):
      apparmor: policy_int make sure list heads are initialized before fail path

John Keeping (1):
      ALSA: seq: midi: Serialize input teardown with event_input

John Ogness (1):
      printk: Fix possible console use-after-free

Jonas Karlman (1):
      media: cec: core: Fix kmemleak due to missed rc_free_device() call

Jorijn van der Graaf (1):
      ASoC: qcom: q6apm: keep the graph start count in sync with the DSP

Joshua Crofts (2):
      iio: adc: max34408: add missing 'select REGMAP_I2C' to Kconfig
      nilfs2: fix infinite loop in nilfs_clean_segments()

Joy Zou (1):
      regulator: core: use system_freezable_wq for init complete work

Ju Nan (1):
      irqchip/stm32mp-exti: Fix the unit of the hwspinlock timeout

Jun Yan (2):
      arm64: dts: amlogic: meson-axg: Add missing nand_rb0 pin to nand_all_pins
      arm64: dts: amlogic: meson-axg-s400: enable mipi_pcie_analog_dphy for PCIe

Junrui Luo (2):
      NFSv4.2: fix LAYOUTSTATS send buffer exhaustion
      NFSv4/pnfs: key the data server cache on the NFS version

Junseo Lim (4):
      lwt_bpf: Restore reserved headroom after xmit program
      bpf: Disallow bpf_{g,s}etsockopt() in cgroup UNIX getname hooks
      bpf: Reject negative optlen in cgroup getsockopt hook
      net: kcm: Hold RCU read lock while running BPF parser

Junyi Liu (1):
      ksmbd: fix durable reconnect error path file lifetime

Justin Yeh (1):
      pinctrl: mediatek: free EINT resources on unbind

Jérémy Jean (1):
      LoongArch: Avoid preempt count underflow without probe

Kalesh AP (1):
      RDMA/restrack: Fix typos in the comments

Kamal Wadhwa (1):
      regulator: qcom-rpmh: Fix PMIC5 BOB bypass mode handling

Kanala Ramalingeswara Reddy (1):
      drm/amdgpu: Skip accessing psp rum time db for APUs

Kanishka De Silva (1):
      ublk: clear VM_MAYWRITE on read-only ublk char device mmap

Karl Mehltretter (12):
      arm64: mm: Fix the lockless page-table walk in show_pte()
      tty: hvc: restrict HVC_DCC to ARMv6+ and ARM64
      ARM: lpc32xx: only run SoC init on LPC32xx hardware
      serial: amba-pl011: unprepare console clock on unregister
      tty: clear cdev pointer after cdev_add() failure
      cpufreq: imx6q: fix devres accumulation across driver rebind
      cpufreq: imx6q: fix out-of-bounds write when probed more than once
      m68k: Fix backtraces for non-running tasks
      super: fix dying superblock warning messages
      crypto: lskcipher - propagate errors from unaligned crypt
      octeontx2-af: initialize lmac_bmap in rvu_mcs_set_lmac_bmap()
      8139cp: fix Rx and Tx not being disabled in cp_suspend

Kavan Smith (1):
      drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value

Kazuki Hanai (1):
      nvmet-auth: Synchronize timeout work during SQ teardown

Kemeng Shi (3):
      irqchip/gic-v3-its: Fix memleak in its_probe_one()
      irqchip/gic-v3-its: Fix its node leak in gic_acpi_parse_madt_its()
      irqchip/gic-v3-its: Prevent leak in its_vpe_irq_domain_alloc()

Koichiro Den (8):
      net: ntb_netdev: Fix TX busy and drop handling
      dmaengine: dw-edma: Fix HDMA channel status register access
      dmaengine: dw-edma: Complete descriptors before pausing
      dmaengine: dw-edma: Initialize IRQ data before requesting IRQs
      dmaengine: dw-edma: Terminate all descriptors without callbacks
      dmaengine: dw-edma: Serialize abort state updates
      dmaengine: dw-edma: Serialize channel state checks
      dmaengine: dw-edma: Clear stale requests on termination

Konrad Dybcio (11):
      arm64: dts: qcom: hamoa: Fix clocks for HSPHYs
      arm64: dts: qcom: sc8180x-primus: Rename regulator nodes
      arm64: dts: qcom: sc8180x-primus: Describe the display power net
      arm64: dts: qcom: sc8180x-lenovo-flex-5g: Rename regulator nodes
      arm64: dts: qcom: sc8180x-lenovo-flex-5g: Describe the display power net
      arm64: dts: qcom: msm8996-xiaomi-gemini: Fix up ti,drv2604 enable GPIO
      arm64: dts: qcom: msm8998: Don't pull-up I2C pins by default in sleep
      arm64: dts: qcom: sdm632-motorola-ocean: Fix LED default trigger property
      arm64: dts: qcom: sc8280xp-crd: Fix the pin index for misc_3p3_reg_en
      drm/msm/dpu: Drop sneaky dev_pm_opp_set_rate(0)
      drm/msm/dsi: Drop dev_pm_opp_set_rate(0)

Konstantin Andreev (3):
      smack: fix incorrect task context in smack_msg_queue_msgrcv
      smack: deduplicate smackfs/{direct,mapped} file_operations
      smack: restrict smackfs/{direct,mapped} values to 0-255

Konstantin Komarov (3):
      fs/ntfs3: Add more checks in mi_enum_attr (part 2)
      fs/ntfs3: Mark inode as bad as soon as error detected in mi_enum_attr()
      fs/ntfs3: fix out-of-bounds read in read_log_rec_buf()

Krishna Chaitanya Chundru (2):
      PCI/ASPM: Use pcie_capability_clear_and_set_word() for ASPM disable/restore
      PCI/ASPM: Disable/restore ASPM on every function for multi-function devices

Krishna Kurapati (1):
      arm64: dts: qcom: qcs404: Fix DTBS Check errors in usb controller nodes

Krystian Kaniewski (1):
      ocfs2: fix circular locking dependency in ocfs2_init_acl()

Krzysztof Kozlowski (2):
      bus: qcom-ebi2: Simplify with scoped for each OF child loop
      phy: qcom: qmp-combo: Add missing PLL (VCO) configuration on SM8750

Kumar Kartikeya Dwivedi (1):
      bpf: Preserve unique-field state across nested structs

Kuninori Morimoto (2):
      of: property: add of_graph_get_next_port()
      of: property: add of_graph_get_next_port_endpoint()

Kuniyuki Iwashima (1):
      slub: Don't call lockdep_unregister_key() for immature kmem_cache.

Kyle Zeng (1):
      hfsplus: validate thread record before delete key rebuild

Lad Prabhakar (2):
      rtc: rzn1: Fix weekday underflow when alarm crosses month boundary
      rtc: rzn1: Disable alarm interrupt before reprogramming alarm registers

Lars-Peter Clausen (3):
      iio: buffer: Fix potential use-after-free in anonymous buffer release
      iio: buffer: Make IIO DMA fence release RCU-safe
      iio: buffer: Tie IIO dma fence lock lifetime to the fence

Laurence Rowe (1):
      vsock: avoid timeout for non-blocking accept() with empty backlog

Laxman Acharya Padhya (4):
      wifi: mt76: mt7996: validate default EEPROM firmware size
      iio: light: gp2ap002: Disable regulators on resume failure
      drm/panel: samsung-s6d16d0: Power off on prepare failure
      firmware: coreboot: Validate table bounds

Lei Huang (1):
      media: s2255: check firmware size before reading trailing marker

Leo Yan (4):
      perf cs-etm: Fix thread leaks on trace queue init failure
      perf cs-etm: Flush thread stacks after decoder reset
      perf cs-etm: Avoid truncating AUX buffer sizes to int
      perf: arm_spe: Make wakeup range check overflow safe

Leon Hwang (1):
      bpf: Copy per-CPU map value padding in copy_map_value_long()

Leon Romanovsky (15):
      RDMA/core: Wait for RCU callbacks before unloading ib_core
      RDMA/mlx5: Drain RCU callbacks during module teardown
      RDMA/ipoib: Drain RCU callbacks during module teardown
      RDMA/hfi1: Preserve unit 0 on allocation failure
      RDMA/hfi1: Free RX data on late probe failure
      RDMA/hfi1: Remove redundant PCI device ID validation
      RDMA/hfi1: Create workqueues before device initialization
      RDMA/hfi1: Stop flushing the global IB workqueue
      RDMA/hfi1: Initialize debugfs after probe completes
      RDMA/srpt: Pass the mapped task attribute to target_init_cmd()
      RDMA/erdma: complete object teardown when the destroy command fails
      RDMA/mlx5: Fix stack out-of-bounds read in cc_params debugfs
      RDMA/mlx5: Send cong param changes to the resolved port mdev
      RDMA/cxgb4: free STAG index when TPT entry write fails
      RDMA/erdma: restrict the driver to little-endian systems

Li Nan (2):
      md: ensure resync is prioritized over recovery
      md: rename recovery_cp to resync_offset

Li Qiang (1):
      scsi: ufs: debugfs: Reserve space for a string terminator

Li RongQing (2):
      virtio_pci: fix wrong queue index for admin vq in intx path
      vdpa/mlx5: fix wrong list iterated in add_direct_chain error path

Li Wang (1):
      ksm_tests: skip hugepage test when Transparent Hugepages are disabled

Liam R. Howlett (Oracle) (2):
      maple_tree: catch race in mas_alloc_cyclic()
      maple_tree: fix argument name in header

Liang Luo (1):
      selftests/sched_ext: Fix bpf_link leak on early return in prog_run

LiangCheng Wang (1):
      ASoC: fsl-asoc-card: defer probe when the CPU DAI device is not ready

Lifeng Zheng (6):
      ACPI: CPPC: Add IS_OPTIONAL_CPC_REG macro to judge if a cpc_reg is optional
      ACPI: CPPC: Optimize cppc_get_perf()
      ACPI: CPPC: Rename cppc_get_perf() to cppc_get_reg_val()
      ACPI: CPPC: Add cppc_set_reg_val()
      ACPI: CPPC: Refactor register value get and set ABIs
      ACPI: CPPC: Modify cppc_get_auto_sel_caps() to cppc_get_auto_sel()

Linfeng Sun  (1):
      vdpa_sim: fix cleanup after worker creation failure

Linghui Wu (1):
      wifi: ath10k: snoc: use memcpy_fromio() for MSA ramdump

Linkai Gong (4):
      cpuidle: dt_idle_genpd: kfree() the original name allocation
      i2c: mux: demux-pinctrl: fix OF node leak on kstrdup failure
      soc: fsl: qe: check platform_driver_register() in qe_ic_of_init()
      rtc: gamecube: check return value of devm_rtc_register_device()

Linmao Li (11):
      iio: chemical: sgp30: Handle IAQ thread creation failure
      platform/mellanox: mlxbf-pmc: Check ACPI_COMPANION() against NULL
      platform/surface: acpi-notify: Check ACPI companion before use
      ppdev: prevent overflow when setting port timeout
      ASoC: meson: Keep link pointers valid on realloc failure
      crypto: keembay - Initialize completion before requesting IRQ
      Bluetooth: hci_conn: fix the SCO setup context lifetime
      Bluetooth: hci_sync: free the advertising instance on the failure and cancel paths
      Bluetooth: MGMT: free the mesh send cancel command when it is cancelled
      nfc: digital: Do not dump a NULL response in command completion
      mailbox: rockchip: disable pclk on probe failure and unbind

Linus Walleij (1):
      ARM: 9481/2: breakpoint: CFI breakpoints only on demand

Liu Qi (1):
      usb-storage: ene_ub6250: fix race between scan work and probe

Loic Poulain (3):
      phy: qcom: qmp-usb-legacy: Fix possible NULL-deref on early runtime suspend
      phy: qcom: snps-femto-v2: Fix possible NULL-deref on early runtime suspend
      phy: qcom: qmp-usb: Fix possible NULL-deref on early runtime suspend

Lorenzo Pieralisi (3):
      ACPI: RISC-V: Fix riscv_acpi_irq_get_dep() loop termination
      ACPI: RISC-V: Check acpi_get_handle() status in riscv_acpi_add_prt_dep()
      ACPI: RISC-V: Fix riscv_acpi_add_prt_dep() loop handling

Lothar Rubusch (1):
      crypto: atmel-sha204a - fix heap info leak on I2C transfer failure

Lovekesh Solanki (1):
      USB: gadget: fix NULL pointer dereference in gadget_dev_ioctl()

Lu Baolu (2):
      iommu/vt-d: Clear Present bit before tearing down copied context entry
      iommu/vt-d: Tear down scalable-mode context on probe failure

Luca Weiss (1):
      arm64: dts: qcom: sm7225-fairphone-fp4: Fix address in fb node name

Maciej Fijalkowski (2):
      xsk: Get rid of xdp_buff_xsk::orig_addr
      xsk: avoid double checking against rx queue being full

Mahanta Jambigi (3):
      net/smc: hash socket only after full initialisation in smc_sk_init()
      net/smc: free stashed qentry before overwrite in REQ_ADD_LINK to ADD_LINK transition
      net/smc: free pending qentry in smc_llc_flow_stop() before memset

Maher Sanalla (1):
      RDMA/mlx5: Fix integer overflow of user QP buffer size

Malaya Kumar Rout (2):
      selftests/bpf: Fix memory leak in msg_alloc_iov error path
      PM: hibernate: Fix memory leak in snapshot_write_next() error path

Manish Rangankar (1):
      scsi: qla2xxx: Remove redundant VPD flash read in sysfs read path

Manivannan Sadhasivam (11):
      bus: mhi: host: Flush the posted write after writing to MHI_SOC_RESET_REQ_OFFSET
      arm64: dts: qcom: sc8180x: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sdm845: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8150: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8250: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8350: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8450: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8550: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8650: Fix the PCIe iommu-map entries
      arm64: dts: qcom: qcs8550-aim300: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sm7225-fairphone-fp4: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies

Manos Pitsidianakis (1):
      hwrng: core - fix rng list on registration error

Maoyi Xie (3):
      platform/chrome: cros_ec_typec: Reject out-of-bounds PD cap count
      usb: ljca: bound bank_num in ljca_enumerate_gpio()
      drm/bridge: tc358767: clamp the reported AUX read size to the request

Marc Zyngier (1):
      PCI: xgene: Drop XGENE_PCIE_IP_VER_UNKN

Marco Crivellari (1):
      module: replace use of system_wq with system_dfl_wq

Marco Elver (2):
      kcsan: avoid unintended access checking in NMIs
      arm64: Disable KCSAN instrumentation in delay.o

Marco Scardovi (1):
      cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory systems

Marek Czernohous (2):
      drm/nouveau: unsubscribe the channel-kill event before the fence context
      forcedeth: stop the tx_timeout register dump past the requested window

Marino Dzalto (1):
      netfilter: xt_HL: add pr_fmt and checkentry validation

Mario Limonciello (2):
      cpufreq/amd-pstate: Store the boost numerator as highest perf again
      cpufreq/amd-pstate: Fix prefcore rankings

Marius Cristea (1):
      hwmon: (emc1403) Drop hysteresis for low limit temperature

Mark Brown (1):
      selftests/mm: report unique test names for each cow test

Mark Zhang (1):
      RDMA/core: Add driver APIs pre_destroy_cq() and post_destroy_cq()

Martin Blumenstingl (1):
      clk: meson: align gxbb_32k_clk_sel number of parents with actual count

Martin Hecht (1):
      media: i2c: alvium: Fix: Correct name of register in alvium_set_ctrl_auto_exposure

Martin Kaiser (1):
      dmaengine: fsl-edma: tracing: no ptr dereference during log output

Martin Wilck (1):
      md/raid1: create serial pool adding rdev to array with serialize_policy=1

Masami Hiramatsu (Google) (2):
      kprobes: Protect kprobe_blacklist with RCU
      tracing: Remove "__attribute__()" from the type field of event format

Mathieu Dubois-Briand (1):
      clk: ti: mux: resolve parent clocks by DT index, not by name

Matti Vaittinen (1):
      power: supply: bd99954: Drop bad register fields

Max Kellermann (1):
      ceph: lock mutex in ceph_mds_check_access()

Maxime Chevallier (6):
      net: stmmac: selftests: Pass the IP proto mask in the TC selftest
      net: stmmac: selftests: Check multiple MMC counters
      net: stmmac: dwmac1000: Account for the primary MAC address for UC filtering
      net: stmmac: dwmac4: Account for the primary MAC address for UC filtering
      net: stmmac: dwxgmac: Account for the primary MAC address for UC filtering
      net: stmmac: selftests: Account for the UC filter list for filtering tests

Maxime Ripard (1):
      drm/bridge: cdns-mhdp8546: Return an error pointer on allocation failure

Maximilian Immanuel Brandtner (1):
      tls: fix RX desync on overlapping skbs

Maíra Canal (2):
      drm/v3d: Replace a global spinlock with a per-queue spinlock
      drm/v3d: Clear queue->active_job when v3d_fence_create() fails

Meghana Malladi (1):
      arm64: dts: ti: k3-am64: Fix MDIO clock reference for ICSSG0 node

Mert Seftali (1):
      iio: accel: dmard09: Implement IIO_CHAN_INFO_SCALE

Michael Bommarito (2):
      HID: roccat: bound device-supplied profile index
      usb: gadget: configfs: fix out-of-bounds read of qw_sign

Michael Byczkowski (1):
      pps: pps-gpio: split IRQ handler into hardirq timestamper + threaded handler

Michael Nemanov (1):
      nfs: fix ENXIO on O_CREAT open of existing symlink over NFSv3

Michael S. Tsirkin (1):
      virtio_balloon: disable indirect descriptors

Michael Walle (4):
      regulator: tps6594-regulator: remove interrupt_count
      regulator: tps6594-regulator: remove hardcoded buck config
      regulator: tps6594-regulator: refactor variant descriptions
      powerpc/configs: enable CONFIG_RAS to fix EDAC support

Michael-CY Lee (1):
      wifi: mt76: fix non-AQL packet accounting for MLO stations

Michal Koutný (1):
      netfilter: xt_cgroup: Make it independent from net_cls

Mike Rapoport (Microsoft) (1):
      selftests/mm: ksm_tests: use kselftest framework

Mikko Perttunen (2):
      gpu: host1x: Fix offset calculation in trace_write_gather
      gpu: host1x: Avoid stack over-read in debug output helpers

Mikulas Patocka (2):
      dm: fix race when loading and unloading a table
      dm: fix resume-vs-remove race

Min zhang (1):
      clk: hisilicon: reset: Use devm_kzalloc to initialize hisi_reset_controller

Mina Almasry (1):
      net: core: check skb_frags_readable before uncloning in skb_copy_ubufs

Ming Qian (2):
      media: amphion: Remove obsolete frame_count check in venc_start_session
      media: v4l2-ctrls: Allow unknown HDR10 white point and luminance

Mohammad Abu-Khader (1):
      kunit: tool: fix _list_tests filtering wrong variable when list has TAP prefix

Mohammed EL Kadiri (2):
      media: venus: fix payload size returned by parse_caps() and parse_alloc_mode()
      media: venus: fix payload size calculation in parse_raw_formats()

Mohd Ayaan Anwar (1):
      phy: qcom: sgmii-eth: vote for both voltage rails with correct current loads

Moksh Panicker (1):
      iio: chemical: atlas-sensor: fix PM reference leak in buffer postenable

Muchun Song (1):
      powerpc/mm: fix wrong addr_pfn tracking in compound vmemmap population

Muhammad Bilal (2):
      staging: rtl8723bs: fix OOB read / stack overflow in rtw_get_wps_attr()
      staging: rtl8723bs: fix OOB read in rtw_action_frame_parse()

Muhammad Usama Anjum (4):
      misc: sgi-gru: remove interrupt-context page-table walks
      selftests/mm: skip COW tmpfile cases when fallocate() is unsupported
      selftests/arm64: Print missing MTE TAP headers
      selftests/arm64: Treat KSM merge_across_nodes as optional

Mukesh Ojha (7):
      iommu/qcom: Fix inverted fault report check in qcom_iommu_fault()
      firmware: qcom: scm: Fix NULL dereference in IRQ handler before __scm is published
      firmware: qcom: scm: Fix tzmem state on probe retry
      remoteproc: Move resource table data structure to its own header
      remoteproc: use rsc_table_for_each_entry() in rproc_handle_resources()
      remoteproc: fix OOB read via signed offset in rsc_table_for_each_entry()
      firmware_loader: do not queue completed sysfs fallback requests

Myeonghun Pak (7):
      media: rc: sunxi-cir: Unregister rc device on probe failure
      clk: versaclock7: Fix APLL clock leak on probe failure
      crypto: keembay - Fix AEAD unregister count in error path
      char: xilinx_hwicap: unregister class on init errors
      RDMA/erdma: Fix CEQ tasklet use-after-free on removal
      clk: palmas: Manage external-control prepare with devm
      fbdev: tdfxfb: fix PCI enable cleanup with pcim_enable_device()

Namhyung Kim (3):
      perf test: Update all metrics test like metricgroups test
      perf test: Do not skip when some metrics tests succeeded
      perf test: Fix perf stat --bpf-counters on hybrid machines

Namjae Jeon (4):
      ksmbd: zero pipe read compound padding
      ksmbd: do not advertise unimplemented CA support
      ksmbd: free preauth sessions on connection teardown
      ksmbd: disconnect on SMB3 decryption failure

Narasimharao Vadlamudi (1):
      media: i2c: imx415: Return test pattern write errors

Nathan Chancellor (2):
      LoongArch: Do not select HAVE_RUST when KASAN is enabled
      integrity: Eliminate weak definition of arch_get_secureboot()

Naveen Kumar Chaudhary (2):
      locking/lockdep: Fix NULL pointer dereference in __lock_set_class()
      module: use strscpy() to copy module names in stats and dup tracking

Naveen Mamindlapalli (1):
      octeontx2-af: Fix TL3/TL2 link config ENA clearing

Neil Armstrong (1):
      arm64: dts: qcom: sm8650: add OPP table support to PCIe

Nguyen Dinh Phi (2):
      vsock: don't check the listener's sk_err in vsock_accept()
      vsock: use sock_error() to consume sk_err after a failed connect

Nick Chan (3):
      nvme: apple: Add Apple A11 support
      nvme-apple: Prevent shared tags across queues on Apple A11
      nvme-apple: Reset q->sq_tail during queue init

Nicolas Frattaroli (1):
      drm/rockchip: vop2: Recognise 10-bit YUV422 as YUV format

Nicolin Chen (3):
      iommu/tegra241-cmdqv: Use request_threaded_irq
      iommu/tegra241-cmdqv: Don't run the error ISR before probe sets up vintfs
      iommu/tegra241-cmdqv: Free the error IRQ before tearing down VINTFs

Nikhil Gautam (6):
      iio: light: opt4001: Fix power down clearing bits of the wrong register
      iio: light: opt4001: Fix incompatible pointer type passed to div_u64_rem()
      iio: light: opt4001: Reject integration times with a non-zero seconds part
      iio: light: opt4001: Fix reversed GENMASK() arguments in fault count mask
      iio: light: gp2ap002: Fix unbalanced runtime PM on repeated event writes
      iio: light: gp2ap002: re-enable irq if runtime suspend fails

Niklas Cassel (2):
      nvme-fc: fix double free of fabrics options when nvme_add_ctrl() fails
      null_blk: serialize configfs attribute updates with device setup

Nikolay Aleksandrov (1):
      net: bridge: vlan: fix inverted default vlan notification

Nikolay Kulikov (1):
      mlxbf-bootctl: fix the build error with FIELD_PREP()

Nilesh Javali (28):
      scsi: qla2xxx: Zero SFP DMA buffer in FRU/I2C bsg handlers
      scsi: qla2xxx: Bound i2c->length in I2C bsg handlers
      scsi: qla2xxx: edif: Fix NULL pointer deref in RX SA delete check
      scsi: qla2xxx: Fix Name Server logout detection on FWI2 adapters
      scsi: qla2xxx: Hold vport reference in qla24xx_report_id_acquisition()
      scsi: qla2xxx: Initialize NVMe abort_work once at submission
      scsi: qla2xxx: Check entry_status in qla24xx_modify_vp_config()
      scsi: qla2xxx: Bound image count in qla2x00_update_fru_versions()
      scsi: qla2xxx: Hold qpair lock when sending NVMe LS reject
      scsi: qla2xxx: Clamp MSI-X derived queue counts to avoid truncation
      scsi: qla2xxx: Serialize flash version read in reset handler
      scsi: qla2xxx: Fix cs84xx use-after-free on host teardown
      scsi: qla2xxx: Fix FCE trace use-after-free during firmware dump
      scsi: qla2xxx: Zero mailbox struct in qla2x00_get_firmware_state()
      scsi: qla2xxx: Fix FCE trace enable parsing in debugfs
      scsi: qla2xxx: Don't query firmware state while chip is down
      scsi: qla2xxx: Reject non-SCSI SRB on status IOCB fast path
      scsi: qla2xxx: Fix response queue over-consumption in __qla_consume_iocb()
      scsi: qla2xxx: Quiesce response IRQ before freeing request queue
      scsi: qla2xxx: Avoid double completion in async IOCB timeout
      scsi: qla2xxx: Bound rsp_info_len to avoid OOB sense-data read
      scsi: qla2xxx: Avoid req_q_map double-read in qla2x00_error_entry()
      scsi: qla2xxx: Fix NVMe abort reference leak on repeated abort
      scsi: qla2xxx: Drop vport reference under lock in report ID acquisition
      scsi: qla2xxx: Hold vport_slock for host map update in report ID acquisition
      scsi: qla2xxx: Use coherent DMA buffer for D_Port diagnostics
      scsi: qla2xxx: Zero-init bsg stack buffers to avoid info leak
      scsi: qla2xxx: Skip NVMe LS reject IOCB when FW not started

Nirbhay Sharma (1):
      fs/ntfs3: fix KMSAN uninit-value in ni_create_attr_list

Norbert Szetei (1):
      net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()

Nuno Sá (1):
      usb: gadget: f_fs: Fix fence cleanup in ffs_dmabuf_transfer() error paths

Nícolas F. R. A. Prado (1):
      pinctrl: mediatek: eint: Fix invalid pointer dereference for v1 platforms

Ojaswin Mujoo (1):
      erofs: fix unused pcluster_pools for higher page sizes

Ondrej Jirman (1):
      arm64: dts: allwinner: sun50i-a64-pinephone: Fix mpu6050 mount matrix

Onur Özkan (1):
      clk: devres: fix cleanup in devm_clk_get_optional_enabled_with_rate()

Osama Abdelkader (2):
      drm/panthor: fix firmware control interface bounds checks
      drm/panthor: return PTR_ERR() from devm_drm_dev_alloc()

Pablo Neira Ayuso (2):
      netfilter: nf_tables: move hardware offload step after building the chain blob
      netfilter: x_tables: replace pr_{info,err}() by pr_info_ratelimited()

Patrisious Haddad (7):
      RDMA/core: Add rdma_restrack_begin/abort/commit_del() operations
      RDMA/core: Fix use after free in ib_query_qp()
      RDMA/core: Fix potential use after free in ib_destroy_cq_user()
      RDMA/core: Fix potential use after free in ib_destroy_srq_user()
      RDMA/core: Fix potential use after free in counter_release()
      RDMA/core: Fix potential use after free in ib_free_cq()
      RDMA/core: Fix potential use after free in ib_dealloc_pd_user()

Paul Kocialkowski (1):
      drm: lcdif: Wait for vblank before disabling DMA

Pauli Virtanen (2):
      Bluetooth: L2CAP: reject accept queue add unless BT_LISTEN
      Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen() vs. put_chan

Pavel Shpakovskiy (1):
      Bluetooth: mgmt: fix 'hdev->discovery.uuids' NULL dereference

Pavel Zhigulin (1):
      speakup: keyhelp: guard letter_offsets possible out-of-range indexing

Pei Xiao (2):
      parisc: eisa: Fix infinite loop when parsing invalid IRQ value
      ipack: ipoctal: fix UAF, null-ptr-deref, and use-after-free in cleanup on remove

Peng Fan (1):
      remoteproc: core: Drop redundant initialization of 'ret' in rproc_shutdown()

Pengpeng Hou (18):
      Input: aiptek - validate raw macro indices before updating state
      mtd: afs: validate v2 image info bounds
      mtd: rawnand: validate ONFI extended parameter page sections
      wifi: rtw89: fix HE extended capability length check
      crypto: sa2ul - stop probe if context pool creation fails
      crypto: rk3288 - fail ahash requests on HASH idle timeout
      soc: qcom: rpmh-rsc: manage PM notifiers with devres
      bus: qcom-ebi2: use managed resources for clocks and children
      pmdomain: bcm: bcm2835: handle genpd provider registration errors
      misc: ad525x_dpot: use driver core groups for sysfs files
      RDMA/nldev: validate dynamic counter attribute length
      ACPI: processor: validate MADT IOAPIC entry bounds
      thermal: intel: int3400: clean up ODVP on probe failures
      mfd: rave-sp: validate received frame payload lengths
      mfd: iqs62x: Reject zero-length firmware records
      ASoC: SOF: validate topology volume range before allocation
      rtc: zynqmp: Return optional clock lookup errors
      net: qlcnic: validate unified ROM sections before loading

Pengyu Luo (1):
      arm64: dts: qcom: sc8280xp-x13s: Fix the drive-strength of mclk pin

Peter Oberparleiter (1):
      s390/debug: Fix deadlock during unregister

Petr Oros (1):
      ice: clear the default forwarding VSI rule when releasing a VSI

Petr Pavlu (2):
      module/dups: Inform duplicate requests about the result directly
      module/dups: Fix use-after-free in kmod_dup_req lifetime handling

Philipp Weber (1):
      HID: core: quiesce input in hid_hw_stop() to prevent use-after-free

Phillip Lougher (1):
      Squashfs: check block offset is not negative

Prabu Thayalan (1):
      ionic: fix completion descriptor access with 2x desc size

Pranjal Shrivastava (1):
      iommu/arm-smmu-v3: Convert to use atomic poll timeout

Pu Lehui (6):
      riscv, bpf: Fix memory leak in bpf_jit_free
      bpf: Fix potential UAF in bpf_netns_link_update_prog
      bpf: Fix potential UAF when reading bpf link info
      bpf, cgroup: Fix invalid storage access after __cgroup_bpf_attach failed
      bpf, cgroup: Fix storage null-ptr-deref after replacing prog
      riscv, bpf: Fix missing sign-ext for signed 1-byte and 2-byte kfunc args

Puranam V G Tejaswi (1):
      drm/msm/a6xx: Fix RBBM_CLOCK_CNTL3_TP0 value in a730_hwcg

Qingfang Deng (1):
      pppox: drain queued packets on channel handoff

Qingshuang Fu (1):
      irqchip/renesas-irqc: Fix generic interrupt chip leak on remove

Rafael J. Wysocki (7):
      platform/x86: lg-laptop: Drop debug-only ACPI notify handler
      platform/x86: lg-laptop: Convert ACPI driver to a platform one
      cpufreq: intel_pstate: Fix setting minimum P-state at init time
      ACPI: processor: idle: Expand _LPI package sanity checks
      ACPI: battery: Adjust charging status validation check
      platform/x86: lg-laptop: Check ACPI_COMPANION() against NULL
      ACPI: processor: Update cpuidle driver check in __acpi_processor_start()

Ran Hongyun (1):
      UBI: fix two issues in the ubi.mtd MODULE_PARM_DESC

Rex Lu (1):
      wifi: mt76: check txfree done event on the WED hw path

Ricardo B. Marlière (1):
      libbpf: Search /lib64 and /lib in resolve_full_path()

Ricardo Neri (1):
      sched/fair: Check CPU capacity before comparing group types during load balance

Richard Cheng (1):
      cxl/mbox: Clamp mailbox output allocation to the payload size

Robertus Diawan Chris (1):
      modpost: prevent leak when early return no suffix .o in read_symbols()

Rong Zhang (2):
      staging: sm750fb: Add missing Kconfig dependency
      net: page_pool: Remove zone/policy GFP flags when allocating XArray entries

Rosen Penev (4):
      ARM: dts: helios4: add vcc-supply to EEPROM
      ARM: dts: helios4: add vcc-supply to GPIO expander
      ARM: dts: helios4: add SATA regulator supplies
      ASoC: xilinx: formatter_pcm: fix stream_data leak on open error

Rui Qi (1):
      selftests/cgroup: Preserve CPU hotplug write errors

Runyu Xiao (6):
      scsi: pm8001: Use rollback index when freeing MSI-X vectors
      ALSA: harmony: initialize locks before requesting IRQ
      ASoC: cs35l33: drain threaded IRQ before runtime suspend
      ASoC: cs35l34: drain threaded IRQ before runtime suspend
      ASoC: rt700-sdw: always drain jack work on remove
      sunrpc: xprtsock: annotate shared socket callbacks with READ_ONCE/WRITE_ONCE

Ruoyu Wang (15):
      media: cec: Serialize exclusive follower delivery
      media: cobalt: Avoid freeing ALSA private data twice
      media: zoran: Avoid freeing a registered video_device twice
      bus: qcom-ebi2: Fix clock leak on probe failure
      usb: gadget: aspeed_udc: check endpoint DMA allocation
      media: ipu6: Do not free aux device pdata after init
      mtd: mtdswap: Avoid freeing registered blktrans device twice
      NFSv4: remove callback IDR entry on client allocation failure
      net: dsa: mv88e6xxx: Fix PCS link check on CMODE read error
      bonding: initialize err for empty target lists
      i2c: ocores: Disable clock on failed resume
      net: bridge: Reject descending VLAN tunnel ranges
      net: ipa: balance runtime PM reference on remove error
      tpm: st33zp24: Return zero on status read failure
      tpm: st33zp24: Validate locality read result

Rupesh Majhi (1):
      iio: pressure: dps310: fix NULL pointer dereference on ACPI probe

Russell King (Oracle) (1):
      phy: qcom-sgmii-eth: relax order of .power_on() vs .set_mode*()

Ryusuke Konishi (1):
      nilfs2: fix BUG in nilfs_copy_dirty_pages() on dirty state mismatch

SJ Park (14):
      mm/damon/sysfs-schemes: kobject_del() scheme dirs
      mm/damon/sysfs-schemes: kobject_del() scheme filter dirs
      mm/damon/sysfs-schemes: kobject_del() scheme quota goal dirs
      mm/damon/sysfs-schemes: kobject_del() scheme region dirs
      mm/damon/sysfs: kobject_del() region and target (error) dirs
      mm/damon/sysfs: kobject_del() target (normal), context and kdamond dirs
      mm/damon/core-kunit: check region count before testing in split_at()
      mm/damon/vaddr: drop last same folio access check optimization
      mm/damon/ops-common: use nr_accesses moving sum for quota score
      mm/damon/paddr: drop last same folio access check reuse optimization
      mm/damon/vaddr-kunit: check region count in three_regions test
      mm/damon/core-kunit: handle region split failure in filter_out()
      mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
      mm/damon/core: skip aging from repeated aggressive merging

Sajal Gupta (1):
      md/raid5-ppl: fix use-after-free in ppl_do_flush()

Saket Kumar Bhaskar (1):
      powerpc/irq: Fix missing r2 clobber in PCREL inline assembly

Samuel Moelius (1):
      iommufd/selftest: Avoid selftest dirty bitmap size wrap

Sandipan Das (3):
      perf/x86/amd/uncore: Add group validation
      perf vendor events amd: Update Zen 5 core events
      perf vendor events amd: Reintroduce deprecated Zen 5 core events

Sang-Heon Jeon (2):
      iio: light: isl29028: return zero in write_raw() on success
      iio: light: tsl2583: return zero in write_raw() on success

Sanghyun Park (2):
      bpf: Fix use-after-free on mm_struct in bpf_find_vma()
      xfrm: Fix skb double-free in xfrm_dev_direct_output()

Sanjay Chitroda (2):
      iio: temperature: hid-sensor-temperature: switch to non-devm iio_device_register()
      iio: orientation: hid-sensor-rotation: Avoid race between callback setup and device exposure

Sayali Patil (2):
      selftests/mm: fix ksm NUMA merge test for systems with memoryless NUMA nodes
      selftests/mm: fix ternary operator precedence in ksm_tests

Sean Christopherson (5):
      KVM: nVMX: Decouple INVVPID operand checks from flushing of vpid02
      KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is cleared on VM-Exit
      KVM: x86/mmu: Fold kvm_mmu_zap_memslot() into kvm_arch_flush_shadow_memslot()
      KVM: x86: Serialize writes to disabled_quirks using kvm->lock
      KVM: x86: Ensure runtime reads of disabled_quirks are resolved once

Sean Rhodes (1):
      misc: rtsx_usb: avoid USB I/O in runtime autosuspend

Sean Shen (1):
      ksmbd: fix FSCTL permission bypass by adding a permission check for FSCTL_SET_SPARSE

Sean Wang (4):
      wifi: mt76: add init_wiphy callback
      mmc: sdio: add MediaTek MT7902 SDIO device ID
      Bluetooth: btmtk: add MT7902 MCU support
      Bluetooth: btmtk: add MT7902 SDIO support

Sean Young (2):
      media: keymaps: Remove obsolete RC_MAP_RC5_TV keymap define
      media: keymaps: Remove obsolete RC_MAP_HAUPPAUGE_NEW keymap define

Sechang Lim (2):
      tcp: clear sock_ops cb flags before force-closing a child socket
      bpf,lsm: Drop bpf_prog_free from sleepable_lsm_hooks

Selvin Xavier (1):
      RDMA/bnxt_re: Clear VM_MAYWRITE on DBR/toggle page mmap

Sergei Litvin (1):
      scripts/tags.sh: Prevent binary files appearing in cscope.files

Serhat Kumral (1):
      RDMA/ucma: Allow path records to exactly fit the output buffer

Shakeel Butt (1):
      memcg: make the v1 soft limit knob inert

Shayne Chen (1):
      wifi: mt76: mt7996: fix capability of EHT-MCS 15 in MRU

Shen Yongchao (1):
      HID: bpf: serialize device reference release in struct_ops destroy path

Shengjiu Wang (1):
      ASoC: fsl_audmix: rework runtime PM handling in probe

Shin'ichiro Kawasaki (2):
      nvmet-rdma: factor out response resource cleanup
      nvmet-rdma: fix response resource leak on queue teardown

Shivam Kumar (2):
      nvmet-tcp: fix out-of-bounds write when receiving an over-long PDU
      nvmet-tcp: reject unsolicited H2CData PDUs

Shivam Rawat (1):
      drm/msm/a6xx: Fix stale rpmh votes after suspend

Shrikanth Hegde (1):
      powerpc: Add preempt lazy support

Shuangpeng Bai (3):
      media: usbtv: keep device alive while ALSA card exists
      media: go7007: defer the ALSA v4l2 put until card release
      RDMA/siw: Fix use-after-free in siw_accept()

Simon Glass (1):
      pinctrl: rockchip: Reset the pin count when recalculating SoC data

Slawomir Stepien (1):
      wifi: zd1211rw: reject secondary interfaces to prevent conflicts

Song Shuai (1):
      riscv: kexec_file: Split the loading of kernel and others

Sourabh Jain (3):
      powerpc/pseries: Handle and log pseries-wdt registration failures
      powerpc/pseries: Move H_WATCHDOG definitions to a common header
      powerpc/crash: stop watchdogs before booting kdump kernel

Srinivas Kandagatla (2):
      soundwire: qcom: Fix port exhaustion check in stream_alloc_ports
      rpmsg: glink: remove duplicate code for rpmsg device remove

Stanislav Kinsburskii (1):
      lib/test_hmm: fail dmirror_fault() when the mirrored mm is gone

StanleyYP Wang (1):
      wifi: mt76: mt7996: fix reg addr remap when addr is 0

Stephan Gerhold (8):
      clk: qcom: gcc-mdm9607: Increase delay for USB PHY reset
      clk: qcom: gcc-msm8916: Fix enable_reg for gcc_blsp1_sleep_clk
      clk: qcom: gcc-msm8939: Fix enable_reg for gcc_blsp1_sleep_clk
      clk: qcom: gcc-mdm9607: Drop incorrect apss_tcu_clk_src
      clk: qcom: gcc-mdm9607: Drop incorrect system_noc_bfdcd_clk_src
      clk: qcom: gcc-mdm9607: Fix enable_reg for gcc_blsp1_sleep_clk
      clk: qcom: gcc-mdm9607: Fix halt_reg for gcc_apss_axi_clk
      clk: qcom: gcc-mdm9607: Drop incorrect BIMC PLL and related clocks

Steven Rostedt (2):
      ftrace: Synchronize the initialization of ftrace_ops
      tracing: Have trace_event_update_all() only handle module that is loading

Sudeep Holla (17):
      firmware: arm_scmi: Publish channel state before callbacks
      firmware: arm_scmi: Unregister device notifier before IDR teardown
      firmware: arm_scmi: Quiesce notifications before teardown
      firmware: arm_scmi: Clean up channels on setup failure
      firmware: arm_scmi: Free transport channel on IDR failure
      firmware: arm_scmi: Avoid IDR updates while cleaning channels
      firmware: arm_scmi: Reject out of range DT protocol IDs
      firmware: arm_scmi: Use channel ID for transport teardown
      firmware: arm_scmi: Protect device request lookup with RCU
      firmware: arm_scmi: Drop handle on protocol bind failures
      firmware: arm_scmi: Unwind TX receiver mailbox setup failure
      firmware: arm_scmi: Unwind P2A receiver mailbox setup failure
      firmware: arm_scmi: Fix requested device removal race
      firmware: arm_scmi: Roll back partial protocol table registration
      firmware: arm_scmi: Unrequest devices if driver registration fails
      mailbox: pcc: Always map the shared memory communication address
      Revert "mailbox/pcc: support mailbox management of the shared buffer"

Sujal Tuladhar (1):
      scsi: target: iscsi: Reserve a terminator byte for the login payload

Sumeet Pawnikar (1):
      powercap: intel_rapl_tpmi: Handle PMU registration failure during probe

Sun Jian (1):
      fsnotify: inotify: pass mark connector to fsnotify_recalc_mask()

Sunday Clement (1):
      drm/amdkfd: Reject zero-sized AQL queue allocations after size halving

Sunil Khatri (1):
      drm/amdgpu: use AMDGPU_GPU_PAGE_SHIFT instead of PAGE_SHIFT

Suraj Gupta (1):
      dmaengine: xilinx_dma: Fix channel idle state management in AXIDMA and MCDMA interrupt handlers

Sven Eckelmann (8):
      batman-adv: mcast: ensure unshared skb for multicast packets
      batman-adv: mcast: linearize skbuff for packet generation
      batman-adv: dat: avoid unaligned fault in IP extraction
      batman-adv: bla: fix freeing of claims on meshif deletion
      batman-adv: bla: prevent CRC corruptions after claim flush
      batman-adv: dat: atomically update mac addresses
      batman-adv: bla: avoid CRC corruption due to parallel claim add
      batman-adv: fix TX priority extraction for BATADV_FORW_MCAST

Sven Peter (4):
      nvme-apple: Destroy the admin queue on removal
      nvme-apple: Don't set a DMA direction for commands without a data transfer
      nvme-apple: Never set the opcode in the NVMMU TCB
      nvme-apple: Drop the PRP null check chicken bit

Szymon Wilczek (1):
      hwmon: (coretemp) Fix core_data leak on CPUs without PTS

Takashi Iwai (3):
      ALSA: pcm: Fix race between non-atomic ops and trigger-start
      ALSA: seq: midi: Optimize event_input locking with RCU
      ALSA: control: Don't add invalid kcontrols to LED layer

Takashi Sakamoto (6):
      firewire: core: add KUnit test skeleton for node tree
      firewire: core: add KUnit tests for successful tree building
      firewire: core: add KUnit tests for failure of tree building
      firewire: core: consolidate port counting in build_tree()
      firewire: core: validate parent port count before allocating nodes in build_tree()
      firewire: core: fix memory leak in error path of build_tree()

Takuma Fujiwara (1):
      PCI: j721e: Fix incorrect max_lanes for J7200

TanZheng (1):
      RDMA/srpt: Fix srpt_alloc_rw_ctxs() unwind counters

Tanushree Shah (4):
      perf data convert json: Fix trace_seq memory leak in process_sample_event()
      perf dso: Fix kallsyms DSO detection with fallback logic
      perf trace-event: Fix buffer overflow in read_string()
      perf trace-event: Fix integer truncation in do_read() and skip()

Tao Cui (5):
      LoongArch: KVM: Fix TOCTOU race on pv_features
      block/blk-stat: drain per-cpu callback stats over possible CPUs
      block/blk-iocost: collect per-cpu latency stats over possible CPUs
      block/kyber-iosched: flush per-cpu latency buckets over possible CPUs
      sched_ext/scx_flatcg: Fix cvtime true-up on slice expiry

Tao Yu (1):
      drm/gud: validate TV mode names before creating enum property

Tengda Wu (1):
      perf test: Use sqrtloop workload to test bperf event

Tetsuo Handa (2):
      net: add missing ref_tracker_dir_exit() to alloc_netdev_mqs()
      net: add missing ref_tracker_dir_exit() to net_passive_dec()

Thadeu Lima de Souza Cascardo (1):
      drm: Fix drm_crtc_commit leak if signaled when PAGE_FLIP_EVENT is used

Thomas Bogendoerfer (1):
      MIPS: ptrace: Fix syscall skipping via PTRACE_SYSCALL

Thomas Weißschuh (4):
      y2038: uapi: Use 64-bit __kernel_old_timespec::tv_nsec on x32
      tools/nolibc/powerpc: mark ctr and xer as clobbered by system call
      selftests: harness: Restore order of test functions
      powerpc/vdso: Remove unused clockmode asm offsets

Thomas Zimmermann (2):
      drm/hibmc: Fix list of formats on the primary plane
      drm/hibmc: Use drm_atomic_helper_check_plane_state()

Thorsten Blum (6):
      crypto: atmel-ecc - replace min_t with min
      crypto: atmel-ecc - clean up and improve ECDH comments
      crypto: atmel-ecc - reject hardware ECDH without a public key
      crypto: sl3516 - drop invalid sg_dma_len checks before DMA mapping
      powerpc: Use str_enabled_disabled() helper function
      apparmor: Replace sprintf/strcpy with scnprintf/strscpy in aa_policy_init

Timur Kristóf (3):
      drm/amdgpu/gfx6: Fixup emit_cntxcntl()
      drm/amdgpu/gfx6: Fixup emitting SWITCH_BUFFER packets
      drm/amdgpu/gfx6: Use PFP on the compute queues too

Titouan Ameline de Cadeville (1):
      firmware: google: Add bounds checks in coreboot_table_populate()

Tomas Glozar (2):
      tools/build: Add bpftool-skeletons feature test
      tools/build: Use SYSTEM_BPFTOOL for system bpftool

Tomáš Macholda (1):
      arm64: dts: turris-mox: fix usb3 phys

Tony W Wang-oc (1):
      ACPI: processor: Add cpuidle driver check in acpi_processor_register_idle_driver()

Tzung-Bi Shih (1):
      platform/chrome: sensorhub: Fix memory overread in ring handler

Uday Khare (3):
      media: video-i2c: fix kthread error pointer left in kthread_vid_cap on failure
      regulator: tps6594: Fix device node reference leaks in multiphase loop
      remoteproc: qcom: Fix glink->node reference leak in qcom_add_glink_subdev

Unnathi Chalicheemala (2):
      firmware: qcom_scm: Add API to get waitqueue IRQ info
      firmware: qcom_scm: Support multiple waitq contexts

Valery Borovsky (3):
      media: airspy: use vb2_video_unregister_device() on disconnect to fix NULL deref
      media: rtl2832_sdr: use vb2_video_unregister_device() on remove to fix DMA leak
      media: rtl2832_sdr: release URBs and stream buffers on start_streaming() failure

Vasant Hegde (1):
      iommu/amd: Fix incorrect device ID in invalid PASID error message

Vasileios Almpanis (1):
      i2c: core: fix debugfs UAF on adapter removal

Victor Nogueira (3):
      net/sched: cls_api: fix teardown of an adopted proto on insert-race loss
      net/sched: add get_fill_size callbacks for actions missing them
      net/sched: sch_teql: restore skb->dev on the slave failure path

Vidhu Sarwal (1):
      iio: light: ltrf216a: fix runtime PM reference leak in error path

Viktor Malik (3):
      perf trace: Factor out BPF loop body
      perf trace: Refactor augmented_raw_syscalls using bpf_for
      selftests/bpf: Silence array bounds warning in global_map_resize

Vincent Donnefort (1):
      ring-buffer: Remove trace_buffer::cpus

Vineet Gupta (1):
      selftests/bpf: vmtest.sh: Preserve command quoting when running in the VM

Vishnu Santhosh (1):
      rpmsg: glink: fix deadlock in endpoint destroy during driver detach

Vladimir Marioukhine (1):
      drm/amdkfd: guard against NULL restore_mqd in CRIU queue restore

Vladimir Murzin (1):
      arm64: hibernate: Restore DAIF state on error

Vladimir Oltean (1):
      net: dsa: b53: fix error propagation from b53_fdb_dump()

Vladimir Zapolskiy (4):
      dmaengine: mediatek: mtk-uart-apdma: Return -ENOMEM on memory allocation failure
      dmaengine: hisilicon: Return -ENOMEM on dynamic memory allocation in probe
      iommu/msm: Return -ENOMEM on memory allocation failure in probe
      clk: qcom: Return expected ENOMEM error on dynamic allocation failure

Vlastimil Babka (1):
      slab: simplify init_kmem_cache_nodes() error handling

Waiman Long (4):
      cgroup/cpuset: Make nr_deadline_tasks an atomic_t
      cgroup/cpuset: Remove remote_partition_check() & make update_cpumasks_hier() handle remote partition
      selftest/cgroup: Update test_cpuset_prs.sh to use | as effective CPUs and state separator
      selftest/cgroup: Clean up and restructure test_cpuset_prs.sh

Wang Yan (1):
      selftests/lsm: Fix memory leak in attr_lsm_count

Wanwu Li (1):
      sched_ext/scx_flatcg: Fix cvtime_delta race and add hweight scaling to bypass charging

Wei Hou (1):
      cxl/pci: Remove incorrect mbox.valid check in cxl_pci_type3_init_mailbox()

Wei Jie Law (1):
      HID: rmi: fix OOB access with undersized RMI reports

Wei Wang (2):
      iommu/amd: Prevent SB IOAPIC from overriding IVRS validation errors
      iommu/amd: Fix false positive in SB IOAPIC IVRS validation

Wei Yang (1):
      mm/mm_init: fix incorrect node_spanned_pages

Wei-Lin Chang (1):
      arm64: ptdump: Make note_page_flush() range aware

Weigang He (3):
      soc: samsung: exynos-pmu: fix of_node refcount leak in exynos_get_pmu_regmap()
      ARM: imx: fix device_node refcount leak in imx_src_init()
      ARM: imx: fix device_node refcount leaks in imx7_src_init()

Weiming Shi (3):
      fs/ntfs3: reject restart table growth beyond U16_MAX entries
      SUNRPC: check rpc_sockaddr2uaddr() return value in rpcb_register_inet4/6
      fs/ntfs3: validate ef->size covers the record's name and value

Weiming Wu (1):
      fs/ntfs3: fix out-of-bounds read of INDEX_ROOT in reparse/objid init

WenTao Liang (1):
      ASoC: samsung: aries_audio_probe: double of_node_put due to direct assignment without of_node_get

Wenjie Qi (3):
      f2fs: return symlink writeback errors
      f2fs: return writeback error from collapse range
      f2fs: avoid NULL checkpoint thread access in sysfs

Wentao Guan (1):
      LoongArch: Do not save/restore percpu base register in rethook trampoline

Wentao Liang (1):
      drm/sun4i: fix refcount leak in sun4i_backend_init_sat()

Wesley Cheng (3):
      phy: qcom: qmp-combo: Add new PHY sequences for SM8750
      phy: qualcomm: Update the QMP clamp register for V6
      phy: qualcomm: qmp-combo: Update QMP PHY with Glymur settings

Wolfram Sang (1):
      hwspinlock: propagate errno when registering single lock

Wupeng Ma (1):
      mm/hugetlb: fix missing migratable flag on same-node hugetlb migration

Xiang Mei (7):
      xfrm6: fix out-of-bounds write in xfrm6_input_addr() when secpath is full
      isofs: fix out-of-bounds page array access on empty zisofs block
      vfio/pci: clear vdev->msi_perm after freeing it on init failure
      ext4: fix out-of-bounds read in ext4_read_inline_dir()
      ext4: check dir entry fits before reading the hash trailer in ext4_search_dir()
      vxlan: vnifilter: enforce exact length of GROUP/GROUP6 attributes
      net: qualcomm: rmnet: restore skb->dev on deaggregated frames

Xianglin Lin (1):
      HID: multitouch: reclassify HTIX5288 to WIN_8_FORCE_MULTI_INPUT_NSMU

Xiao Ni (1):
      md: keep recovery_cp in mdp_superblock_s

Xie Yuanbin (1):
      ARM: 9485/1: mm: acquire mmap write lock around show_pte() for user faults

Xin Xie (1):
      net: hsr: free learned nodes on device setup failure

Xiubo Li (1):
      ceph: revalidate ki_pos for O_APPEND writes after cap acquisition

Xu Rao (4):
      nvme-fabrics: fix DHCHAP secret leak on parse failure
      mtd: mtdoops: free page bitmap when the backing MTD is removed
      media: v4l2-async: avoid deleting unlinked ASC entry on link error
      ALSA: hda: Fix connection list comparison in proc output

Xu Yang (1):
      usb: gadget: f_uac1_legacy: remove broken string configfs attributes

Yang Shi (1):
      selftests: arm64: add hugetlb mte tests

Yang Wang (1):
      drm/amdgpu: check thunderbolt before switcheroo registration

Yang Xiuwei (2):
      scsi: sd: Fix sd_done() sense handling condition
      nvme/ioctl: check SUBMIT_IO with nvme_cmd_allowed()

Yao Kai (1):
      futex: Prevent rcuwait use-after-free during requeue PI

Yao Sang (1):
      ublk: reject non-power-of-2 zone sizes in SET_PARAMS

Yehyeong Lee (6):
      nvme-tcp: check the data direction of a C2HData PDU
      IB/isert: reject PDUs declaring more data than was received
      IB/isert: reject login PDUs declaring more data than was received
      RDMA/srp: fix heap information leak on a truncated SRP_CRED_REQ
      IB/isert: delay the final Login Response until the session is registered
      IB/isert: post the full-feature receive buffers after session registration

Yeoreum Yun (3):
      coresight: etm4x: fix wrong check of etm4x_sspcicrn_present()
      coresight: etm4x: fix underflow for usage of (nrseqstate - 1)
      coresight: etm4x: fix leaked trace id

Yi Ding (2):
      media: cec: meson: ao-cec-g12a: name the CEC core regmap to avoid debugfs clash
      rtc: pcf8563: fix clock provider leak on unbind

Yichong Chen (7):
      tools/bpf/bpftool: Reset vmlinux BTF after map commands
      tools/bpf/bpftool: Reset vmlinux BTF after struct_ops commands
      isofs: release zisofs block pointer buffer head
      fanotify: report full event length for FIONREAD
      fat: release buffer head after rebuilding parent
      hugetlbfs: release subpool on fill_super failure
      btrfs: retry verity reads for not-uptodate Merkle folios

Yicong Hui (1):
      drm: Remove unused header in drm_dumb_buffers.c

Yicong Yang (1):
      arm64: Enable ARCH_HAS_NONLEAF_PMD_YOUNG

Yifei Chu (1):
      net/smc: release the internal TCP sock on IPPROTO_SMC socket creation failure

Yinhao Hu (1):
      nfc: pn533: hold a reference to the request skb during send_frame

Yiyang Chen (1):
      bpf: Reject arena frees below the arena base

Yonatan Nachum (1):
      RDMA/efa: Fix PBL chunk length computation

Yonghong Song (3):
      bpf, x86: Fix trampoline stack size for 128-bit arguments
      cgroup: Add bpf prog revisions to struct cgroup_bpf
      bpf: Implement mprog API on top of existing cgroup progs

Yongpeng Yang (1):
      fscrypt: fix left shift underflow when inode->i_blkbits > PAGE_SHIFT

Yosry Ahmed (3):
      KVM: nVMX: Always flush vpid02 on first use
      KVM: nVMX: Service local TLB flushes on failed nested VM-Enter
      KVM: nVM: Ensure INVVPID is emulated on the correct physical CPU

Youngjae Kwon (1):
      fsnotify: Fix stale object mask after concurrent mark updates

Yousef Alhouseen (1):
      HID: synchronize input before cleaning up a failed probe

Yu Kuai (6):
      md: add a new recovery_flag MD_RECOVERY_LAZY_RECOVER
      md: merge mddev has_superblock into mddev_flags
      md: merge mddev faillast_dev into mddev_flags
      md: merge mddev serialize_policy into mddev_flags
      md/raid5: round bitmap stripes with sector division
      md: avoid stale clone I/O accounting timestamps

Yu Peng (1):
      perf metricgroup: Fix metric expression copy leaks

Yuan Chen (1):
      bpftool: Fix double close in map dump

Yuanshen Cao (1):
      iio: light: tsl2772: fix ALS calibscale readback

Yuho Choi (14):
      bus: ti-sysc: Fix /chosen node reference leak
      clocksource: Unregister subsystem on device registration failure
      bus: mhi: ep: Fix device refcount leak in the error path of MHI device creation
      serial: ma35d1: Fix OF node reference leaks in console init
      hwrng: ks-sa - Fix runtime PM cleanup on registration failure
      PCI: xgene: Drop unnecessary OF node reference
      uio: Fix stale info pointer in failed registration path
      driver core: soc: Unregister bus on early device registration failure
      bus: mhi: host: Fix controller cleanup on EDL sysfs failure
      ACPI: video: Release PCI device reference after lookup
      ubi: Fix rollback for explicit UBI device numbers
      mtd: ubi: Release device reference on busy detach
      xenbus: Unregister reboot notifier on init failure
      clocksource/drivers/armada: Unwind timer clock on init failure

Yun Zhou (3):
      ext4: fix circular lock dependency in ext4_ext_migrate
      ext4: skip extra isize expansion during mount to prevent deadlock
      nfc: nci: fix use of uninitialized memory in CORE_INIT_RSP parsing

Yunseong Kim (1):
      ksmbd: validate ipc response length before dereferencing its fields

Yuqi Xu (1):
      openvswitch: Fix CT limit teardown use-after-free

Yuvaraj Ranganathan (2):
      firmware: qcom: scm: add trace events for the SMC call interface
      firmware: qcom: scm: instrument SMC call path with tracepoints

Yuvraj Singh Chauhan (1):
      staging: octeon: fix free_irq dev_id mismatch in cvm_oct_rx_shutdown

Yuyang Huang (2):
      selftests/bpf: add verification for BPF_PROG_QUERY attr size boundaries
      bpf: fix BPF_PROG_QUERY OOB write and cgroup backward compat

Ze Tan (1):
      smb/server: fix session leak in ksmbd_session_register()

Zeng Chi (1):
      LoongArch: KVM: Preserve memslot arch flags on KVM_MR_FLAGS_ONLY

Zhan Xusheng (4):
      f2fs: use the mount idmap for the owner check in f2fs_xattr_advise_set()
      f2fs: fix i_size when pinned fallocate partially fails
      fs/ntfs3: fix integer overflow in MFT cluster validation
      fs/ntfs3: reject out-of-range evcn in mi_enum_attr()

Zhang Tianci (1):
      fuse: check attributes staleness on fuse_iget()

ZhangGuoDong (4):
      smb/server: fix null-ptr-deref in ksmbd_ipc_tree_connect_request()
      smb/server: fix invalid pointer dereference in ksmbd_stop_durable_scavenger()
      smb/server: preserve error status in smb2_handle_negotiate()
      pnfs/blocklayout: Fix device leaks on parse failure

Zhansong Gao (1):
      NFSv4: Fix incorrect argument passed to nfs4_delete_lease() in nfs4_add_lease()

Zhao Li (3):
      wifi: mac80211: fix per-STA profile length in cross-link CSA parsing
      wifi: mac80211: send TWT teardown to peer after setup TX failure
      wifi: mac80211: skip unused probe response countdown offsets

Zheng Qixing (4):
      md: allow removing faulty rdev during resync
      blk-cgroup: skip dying blkg in blkcg_activate_policy()
      md: add helper rdev_needs_recovery()
      md: fix sync_action incorrect display during resync

Zhenghang Xiao (1):
      nfc: nci: fix double completion race in nci_data_exchange_complete

Zhenhao Wan (3):
      drm/nouveau/uvmm: fix NULL deref unwinding an OP_MAP_SPARSE op
      drm/nouveau/uvmm: fix premature region free on failed OP_UNMAP_SPARSE
      drm/nouveau/uvmm: clear the dirty flag when unwinding an OP_UNMAP_SPARSE

Zhi-Jun You (1):
      wifi: mt76: mt7915: fix net_fill_forward_path for non-DBDC mt7986

Zhihao Cheng (2):
      UBI: Preserve torture flag when rescheduling failed erasures
      UBI: fastmap: Pass to_be_tortured when reusing old fastmap PEBs

Zhiling Zou (1):
      batman-adv: fix stale receive device on merged fragments

Zhongqiu Han (1):
      cpufreq: schedutil: Fix self-contradictory comment in sugov_iowait_apply()

Zhu Ling (1):
      ACPI: EC: Avoid _REG disconnect on GPIO IRQ defer

Zhu Yanjun (1):
      RDMA/cma: Fix WARNING in res_to_rt

Zhushuai Yin (1):
      crypto: hisilicon/sec2 - fix CCM algorithm long packet failure

Zide Chen (1):
      perf/x86/intel/uncore: Keep PCI PMUs working when MMIO/MSR setup fails

Zijun Hu (5):
      Bluetooth: btqca: Fix qca_set_bdaddr() waiting for wrong HCI event
      Bluetooth: btusb: Fix BD_ADDR byte order in btusb_set_bdaddr_wcn6855()
      Bluetooth: btusb: Record matched usb_device_id into btusb_data
      Bluetooth: btusb: QCA: Fix populating devcoredump fields on unenabled devices
      Bluetooth: btintel: Fix diagnostics event detection

Zilin Guan (1):
      of: unittest: Fix memory leak in unittest_data_add()

Zizhi Wo (6):
      null_blk: use DEFINE_MUTEX for the file-scope mutex
      null_blk: register configfs subsystem after creating default devices
      null_blk: free global tag_set on init error path
      null_blk: free zones array on device power-off
      null_blk: reject per-device queue resize for shared tag set
      null_blk: serialize configfs attribute stores with the lock

Zxyan Zhu (1):
      net: stmmac: Skip PHY attach if custom PCS is in use

bui duc phuc (3):
      ASoC: pxa: Use devm_clk_get_optional() for extclk clock
      net: ethernet: sun4i-emac: Fix IRQ error handling
      net: fec: only stop PTP if it was initialized

caina (1):
      Revert "irqchip/mbigen: Fix mbigen node address layout"

e.kubanski (1):
      xsk: Fix offset calculation in unaligned mode

everestkc (1):
      cgroup/cpuset: Fix spelling errors in file kernel/cgroup/cpuset.c

liujinbao1 (1):
      f2fs:Fix incomplete search range in f2fs_get_victim when f2fs_need_rand_seg is enabled

longlong yan (1):
      clk/x86: pmc_atom: add kasprintf return value check

shengwei.lu (1):
      wifi: mt76: mt7925: Fix EHT Beamformee SS subfields to meet 802.11be minimum

zhouminqiang (1):
      mtd: part: reject MTDPART_OFS_RETAIN in mtd_add_partition()

谢致邦 (XIE Zhibang) (1):
      HID: i2c-hid: Refactor _DSM helper and add i2c-hid-acpi-prp0001 driver

