Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC444B69C;
	Mon, 14 Sep 2026 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387151; cv=none; b=dG+JkgRVQpkdwv80wxThcrO4Xfnkc1TWpsTFSEE5k/c9j64v0bpwr6NEdAZvxgc76bP6QvJpOoGgYX9FowscDar6UZYl7SOF0QNFWMTtnti4DU4D0ngv3OcFTkUHAHtp0PabNvLuWKmpBiW/VtFbatm/6msPU9GjmyhZ5QwLSqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387151; c=relaxed/simple;
	bh=97+1a7tAoRTPuJX6pXIAXMBi56SzeUwTbs1YvWPBrFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SBC3DQtCdJV6/7ESx7Iz5vBibwd3kYb8tIYhmPYAAAO8AHLvx6gJ9OOspAOFF9hf0HRinx/qGLClpGFKErUfUzEk+B/PL0u+XQIwOkcZiTVBe0qw/a4Eb2dvjSAsmL452cPgFA4SuY32N3xxRf2TCQgWxndbh42O7pC/IXspFKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sFfBhVwJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sFfBhVwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1476D1F0089E;
	Mon, 14 Sep 2026 11:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789387128;
	bh=FyF6SNy56zrLHLVHdx6cmMKW6NAUEvCV8x7vMxHwQkQ=;
	h=From:To:Cc:Subject:Date;
	b=sFfBhVwJp92YDRhZmUdFcmOTcLj6YdsPLQolw90TN6aPgyuaA5hAGPEcHCpvMGzZr
	 DI70PJRfVmPZ4wHtU6TI7g6y9S4mZSgZEQXFqTdWwKINvstobH9C4tJiYnv5vFaEXc
	 IQsLwaO+9Ajm+uveoyoqASUhg4xGFxcpWX2CsrqY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.52
Date: Mon, 14 Sep 2026 13:58:20 +0200
Message-ID: <2026091420-unjustly-faceplate-5812@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.52 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/configfs-usb-gadget-uac1_legacy                     |    3 
 Documentation/admin-guide/device-mapper/dm-ima.rst                            |    7 
 Documentation/admin-guide/device-mapper/dm-integrity.rst                      |   13 
 Documentation/admin-guide/pm/amd-pstate.rst                                   |   34 
 Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml                     |   11 
 Documentation/hwmon/cros_ec_hwmon.rst                                         |   26 
 Documentation/hwmon/emc1403.rst                                               |    8 
 Documentation/hwmon/hwmon-kernel-api.rst                                      |    7 
 Documentation/leds/leds-st1202.rst                                            |    2 
 Documentation/netlink/specs/devlink.yaml                                      |    2 
 Documentation/networking/devlink/devlink-eswitch-attr.rst                     |   13 
 Documentation/usb/gadget-testing.rst                                          |    3 
 MAINTAINERS                                                                   |    3 
 Makefile                                                                      |    4 
 arch/Kconfig                                                                  |    3 
 arch/arm/boot/dts/allwinner/sun4i-a10.dtsi                                    |    2 
 arch/arm/boot/dts/marvell/armada-388-helios4.dts                              |   13 
 arch/arm/kernel/hw_breakpoint.c                                               |   11 
 arch/arm/mach-exynos/mcpm-exynos.c                                            |   12 
 arch/arm/mach-exynos/suspend.c                                                |   48 
 arch/arm/mach-imx/src.c                                                       |    3 
 arch/arm/mach-lpc32xx/common.c                                                |    5 
 arch/arm/mach-lpc32xx/common.h                                                |    2 
 arch/arm/mach-lpc32xx/phy3250.c                                               |    2 
 arch/arm/mach-lpc32xx/pm.c                                                    |    5 
 arch/arm/mach-pxa/generic.h                                                   |    6 
 arch/arm/mach-pxa/irq.c                                                       |   10 
 arch/arm/mach-pxa/mfp-pxa2xx.c                                                |   10 
 arch/arm/mach-pxa/mfp-pxa3xx.c                                                |   10 
 arch/arm/mach-pxa/pxa25x.c                                                    |    4 
 arch/arm/mach-pxa/pxa27x.c                                                    |    4 
 arch/arm/mach-pxa/pxa3xx.c                                                    |    4 
 arch/arm/mach-pxa/smemc.c                                                     |   12 
 arch/arm/mach-s3c/irq-pm-s3c64xx.c                                            |   12 
 arch/arm/mach-s5pv210/pm.c                                                    |   10 
 arch/arm/mach-versatile/integrator_ap.c                                       |   12 
 arch/arm/mm/cache-b15-rac.c                                                   |   12 
 arch/arm/mm/fault.c                                                           |   16 
 arch/arm64/Kconfig                                                            |    2 
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi                       |    4 
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts                                |    4 
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                                    |    3 
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi                              |    8 
 arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi                        |    4 
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts                        |    3 
 arch/arm64/boot/dts/qcom/hamoa.dtsi                                           |    4 
 arch/arm64/boot/dts/qcom/ipq5018.dtsi                                         |    5 
 arch/arm64/boot/dts/qcom/lemans.dtsi                                          |  977 ++--
 arch/arm64/boot/dts/qcom/msm8976-longcheer-l9360.dts                          |    4 
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts                            |    2 
 arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi                     |    4 
 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts                             |    5 
 arch/arm64/boot/dts/qcom/msm8998.dtsi                                         |   24 
 arch/arm64/boot/dts/qcom/qcm2290.dtsi                                         |    1 
 arch/arm64/boot/dts/qcom/qcs404.dtsi                                          |   16 
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts                                  |   18 
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi                                  |    4 
 arch/arm64/boot/dts/qcom/sar2130p-qar2130p.dts                                |    4 
 arch/arm64/boot/dts/qcom/sar2130p.dtsi                                        |    8 
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi                                  |    5 
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi                                |    5 
 arch/arm64/boot/dts/qcom/sc7280.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts                           |   57 
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts                                   |   56 
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                                         |   16 
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                                     |    4 
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts                    |    2 
 arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts                        |    4 
 arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts                     |   19 
 arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts                            |    2 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                                          |   64 
 arch/arm64/boot/dts/qcom/sm6150.dtsi                                          |    4 
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts                             |    6 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi                      |    2 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                                          |   48 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sm8750.dtsi                                          |    5 
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi                       |    3 
 arch/arm64/boot/dts/rockchip/rk3566-bigtreetech-cb2.dtsi                      |    2 
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi                                 |    4 
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi                                |    4 
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi                                      |    2 
 arch/arm64/include/asm/kvm_host.h                                             |    3 
 arch/arm64/include/asm/processor.h                                            |    2 
 arch/arm64/include/asm/ptdump.h                                               |    2 
 arch/arm64/include/asm/rsi_cmds.h                                             |   27 
 arch/arm64/kernel/hibernate.c                                                 |   16 
 arch/arm64/kernel/ptrace.c                                                    |    4 
 arch/arm64/kernel/smp.c                                                       |    2 
 arch/arm64/kvm/hyp/vhe/switch.c                                               |    3 
 arch/arm64/kvm/nested.c                                                       |   64 
 arch/arm64/lib/Makefile                                                       |    4 
 arch/arm64/mm/ptdump.c                                                        |   14 
 arch/arm64/net/bpf_jit_comp.c                                                 |   28 
 arch/csky/kernel/entry.S                                                      |    6 
 arch/loongarch/kernel/smp.c                                                   |   12 
 arch/m68k/emu/nfcon.c                                                         |    2 
 arch/m68k/kernel/traps.c                                                      |    4 
 arch/mips/alchemy/common/dbdma.c                                              |   12 
 arch/mips/alchemy/common/irq.c                                                |   24 
 arch/mips/alchemy/common/usb.c                                                |   12 
 arch/mips/kernel/ptrace.c                                                     |    6 
 arch/mips/pci/pci-alchemy.c                                                   |   16 
 arch/powerpc/Kconfig                                                          |    1 
 arch/powerpc/configs/85xx-hw.config                                           |    1 
 arch/powerpc/kernel/ima_arch.c                                                |    5 
 arch/powerpc/kernel/irq.c                                                     |   16 
 arch/powerpc/kernel/secure_boot.c                                             |    6 
 arch/powerpc/kernel/smp.c                                                     |    3 
 arch/powerpc/kexec/crash.c                                                    |    2 
 arch/powerpc/platforms/44x/gpio.c                                             |    1 
 arch/powerpc/platforms/cell/spu_base.c                                        |   10 
 arch/powerpc/platforms/powermac/pic.c                                         |   12 
 arch/powerpc/sysdev/cpm_common.c                                              |   13 
 arch/powerpc/sysdev/fsl_lbc.c                                                 |   12 
 arch/powerpc/sysdev/fsl_pci.c                                                 |   12 
 arch/powerpc/sysdev/ipic.c                                                    |   12 
 arch/powerpc/sysdev/mpic.c                                                    |   14 
 arch/powerpc/sysdev/mpic_timer.c                                              |   10 
 arch/riscv/boot/dts/sophgo/cv180x.dtsi                                        |    2 
 arch/riscv/boot/dts/spacemit/Makefile                                         |    2 
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts                               |    4 
 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts                             |    4 
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts                                |   79 
 arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts                              |   90 
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi                                  |   24 
 arch/riscv/kernel/cpufeature.c                                                |    3 
 arch/riscv/kernel/machine_kexec_file.c                                        |   14 
 arch/riscv/net/bpf_jit_comp64.c                                               |   19 
 arch/riscv/net/bpf_jit_core.c                                                 |    1 
 arch/s390/Kconfig                                                             |    2 
 arch/s390/include/asm/irqflags.h                                              |   20 
 arch/s390/kernel/Makefile                                                     |    2 
 arch/s390/kernel/debug.c                                                      |   10 
 arch/s390/kernel/ima_arch.c                                                   |   14 
 arch/s390/kernel/ipl.c                                                        |    8 
 arch/s390/kernel/irqflags.c                                                   |   28 
 arch/s390/kvm/kvm-s390.c                                                      |    4 
 arch/sh/mm/pmb.c                                                              |   10 
 arch/x86/entry/entry_64_fred.S                                                |    2 
 arch/x86/events/amd/ibs.c                                                     |   12 
 arch/x86/events/amd/uncore.c                                                  |   31 
 arch/x86/events/intel/core.c                                                  |   10 
 arch/x86/events/intel/pt.c                                                    |   96 
 arch/x86/events/intel/uncore.c                                                |    2 
 arch/x86/events/perf_event.h                                                  |    2 
 arch/x86/hyperv/hv_init.c                                                     |   12 
 arch/x86/include/asm/efi.h                                                    |    4 
 arch/x86/include/asm/linkage.h                                                |    2 
 arch/x86/include/asm/pkeys.h                                                  |    3 
 arch/x86/kernel/amd_gart_64.c                                                 |   10 
 arch/x86/kernel/apic/apic.c                                                   |   12 
 arch/x86/kernel/apic/io_apic.c                                                |   17 
 arch/x86/kernel/cpu/aperfmperf.c                                              |   20 
 arch/x86/kernel/cpu/common.c                                                  |   25 
 arch/x86/kernel/cpu/cpu.h                                                     |    9 
 arch/x86/kernel/cpu/intel_epb.c                                               |   16 
 arch/x86/kernel/cpu/mce/core.c                                                |   14 
 arch/x86/kernel/cpu/microcode/core.c                                          |   15 
 arch/x86/kernel/cpu/mtrr/legacy.c                                             |   12 
 arch/x86/kernel/cpu/tsx.c                                                     |    9 
 arch/x86/kernel/cpu/umwait.c                                                  |   10 
 arch/x86/kernel/i8237.c                                                       |   10 
 arch/x86/kernel/i8259.c                                                       |   14 
 arch/x86/kernel/kvm.c                                                         |   12 
 arch/x86/kvm/Makefile                                                         |    4 
 arch/x86/kvm/regs.c                                                           |  787 +++
 arch/x86/kvm/x86.c                                                            |  793 ---
 arch/x86/kvm/x86.h                                                            |   16 
 arch/x86/mm/pat/set_memory.c                                                  |    8 
 arch/x86/net/bpf_jit_comp.c                                                   |   14 
 arch/x86/platform/efi/efi.c                                                   |    2 
 block/bio.c                                                                   |   10 
 block/blk-cgroup.c                                                            |    5 
 block/blk-core.c                                                              |   13 
 block/blk-crypto-fallback.c                                                   |  387 -
 block/blk-crypto-internal.h                                                   |   19 
 block/blk-crypto.c                                                            |   52 
 block/blk-iocost.c                                                            |    2 
 block/blk-map.c                                                               |    3 
 block/blk-merge.c                                                             |   48 
 block/blk-mq-dma.c                                                            |    4 
 block/blk-mq.c                                                                |   12 
 block/blk-stat.c                                                              |    2 
 block/fops.c                                                                  |    9 
 block/kyber-iosched.c                                                         |    2 
 crypto/acompress.c                                                            |   16 
 crypto/lskcipher.c                                                            |    1 
 drivers/accel/amdxdna/amdxdna_gem.c                                           |    4 
 drivers/accessibility/speakup/keyhelp.c                                       |   17 
 drivers/accessibility/speakup/kobjects.c                                      |    6 
 drivers/acpi/battery.c                                                        |   36 
 drivers/acpi/ec.c                                                             |   40 
 drivers/acpi/pci_link.c                                                       |   10 
 drivers/acpi/pci_root.c                                                       |    3 
 drivers/acpi/processor_core.c                                                 |   31 
 drivers/acpi/processor_driver.c                                               |   16 
 drivers/acpi/processor_idle.c                                                 |  116 
 drivers/acpi/riscv/irq.c                                                      |   33 
 drivers/acpi/scan.c                                                           |   13 
 drivers/acpi/sleep.c                                                          |   12 
 drivers/acpi/video_detect.c                                                   |    4 
 drivers/base/cacheinfo.c                                                      |    9 
 drivers/base/firmware_loader/fallback.c                                       |   10 
 drivers/base/firmware_loader/main.c                                           |   12 
 drivers/base/memory.c                                                         |    4 
 drivers/base/soc.c                                                            |   15 
 drivers/base/swnode.c                                                         |    2 
 drivers/base/syscore.c                                                        |   82 
 drivers/block/mtip32xx/mtip32xx.c                                             |    7 
 drivers/block/mtip32xx/mtip32xx.h                                             |    2 
 drivers/block/null_blk/main.c                                                 |   78 
 drivers/block/ublk_drv.c                                                      |   20 
 drivers/bluetooth/btintel.c                                                   |    2 
 drivers/bluetooth/btmtk.c                                                     |  104 
 drivers/bluetooth/btmtk.h                                                     |    8 
 drivers/bluetooth/btmtksdio.c                                                 |   80 
 drivers/bluetooth/btnxpuart.c                                                 |   15 
 drivers/bluetooth/btqca.c                                                     |    3 
 drivers/bluetooth/btusb.c                                                     |   68 
 drivers/bluetooth/virtio_bt.c                                                 |    8 
 drivers/bus/mhi/ep/main.c                                                     |   15 
 drivers/bus/mhi/host/init.c                                                   |    4 
 drivers/bus/mhi/host/main.c                                                   |    6 
 drivers/bus/mvebu-mbus.c                                                      |   16 
 drivers/bus/qcom-ebi2.c                                                       |   51 
 drivers/bus/ti-sysc.c                                                         |   12 
 drivers/char/hw_random/core.c                                                 |    4 
 drivers/char/hw_random/imx-rngc.c                                             |    4 
 drivers/char/hw_random/ks-sa-rng.c                                            |    9 
 drivers/char/ppdev.c                                                          |   10 
 drivers/char/tpm/st33zp24/st33zp24.c                                          |    8 
 drivers/char/xilinx_hwicap/xilinx_hwicap.c                                    |    5 
 drivers/clk/at91/pmc.c                                                        |   12 
 drivers/clk/clk-devres.c                                                      |   12 
 drivers/clk/clk-moxart.c                                                      |   14 
 drivers/clk/clk-palmas.c                                                      |   14 
 drivers/clk/clk-versaclock7.c                                                 |    2 
 drivers/clk/hisilicon/reset.c                                                 |    2 
 drivers/clk/imx/clk-scu.c                                                     |    1 
 drivers/clk/imx/clk-vf610.c                                                   |   12 
 drivers/clk/ingenic/jz4725b-cgu.c                                             |    2 
 drivers/clk/ingenic/jz4740-cgu.c                                              |    2 
 drivers/clk/ingenic/jz4755-cgu.c                                              |    2 
 drivers/clk/ingenic/jz4760-cgu.c                                              |    2 
 drivers/clk/ingenic/jz4770-cgu.c                                              |    2 
 drivers/clk/ingenic/jz4780-cgu.c                                              |    2 
 drivers/clk/ingenic/pm.c                                                      |   14 
 drivers/clk/ingenic/pm.h                                                      |    2 
 drivers/clk/ingenic/tcu.c                                                     |   12 
 drivers/clk/ingenic/x1000-cgu.c                                               |    2 
 drivers/clk/ingenic/x1830-cgu.c                                               |    2 
 drivers/clk/mediatek/clk-mt2701.c                                             |    2 
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c                                  |    2 
 drivers/clk/mediatek/clk-mt6735-apmixedsys.c                                  |    9 
 drivers/clk/mediatek/clk-mt6765.c                                             |    2 
 drivers/clk/mediatek/clk-mt6779.c                                             |    2 
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c                                  |    2 
 drivers/clk/mediatek/clk-mt6797.c                                             |    2 
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c                                  |    2 
 drivers/clk/mediatek/clk-mt7629.c                                             |    2 
 drivers/clk/mediatek/clk-mt7981-apmixed.c                                     |    2 
 drivers/clk/mediatek/clk-mt7986-apmixed.c                                     |    2 
 drivers/clk/mediatek/clk-mt7988-apmixed.c                                     |    2 
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c                                  |    3 
 drivers/clk/mediatek/clk-mt8135.c                                             |    5 
 drivers/clk/mediatek/clk-mt8167-apmixedsys.c                                  |    2 
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c                                  |   14 
 drivers/clk/mediatek/clk-mt8183-apmixedsys.c                                  |    2 
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c                                  |    2 
 drivers/clk/mediatek/clk-mt8188-apmixedsys.c                                  |    2 
 drivers/clk/mediatek/clk-mt8192-apmixedsys.c                                  |    2 
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c                                  |    2 
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c                                  |    3 
 drivers/clk/mediatek/clk-mt8196-apmixedsys.c                                  |    3 
 drivers/clk/mediatek/clk-mt8196-mcu.c                                         |    2 
 drivers/clk/mediatek/clk-mt8196-mfg.c                                         |    2 
 drivers/clk/mediatek/clk-mt8196-vlpckgen.c                                    |    2 
 drivers/clk/mediatek/clk-mt8365-apmixedsys.c                                  |    2 
 drivers/clk/mediatek/clk-mt8516-apmixedsys.c                                  |    2 
 drivers/clk/mediatek/clk-pll.c                                                |   16 
 drivers/clk/mediatek/clk-pll.h                                                |   14 
 drivers/clk/mediatek/clk-pllfh.c                                              |  111 
 drivers/clk/mediatek/clk-pllfh.h                                              |    2 
 drivers/clk/mvebu/common.c                                                    |   12 
 drivers/clk/nuvoton/clk-ma35d1-pll.c                                          |   38 
 drivers/clk/qcom/camcc-sc8280xp.c                                             |   19 
 drivers/clk/qcom/common.c                                                     |    4 
 drivers/clk/qcom/gcc-glymur.c                                                 |   33 
 drivers/clk/qcom/gcc-qcm2290.c                                                |   18 
 drivers/clk/qcom/gcc-qcs8300.c                                                |    8 
 drivers/clk/qcom/gcc-sm6115.c                                                 |    6 
 drivers/clk/qcom/gdsc.c                                                       |   25 
 drivers/clk/qcom/gpucc-qcm2290.c                                              |    2 
 drivers/clk/rockchip/clk-pll.c                                                |    9 
 drivers/clk/rockchip/clk-rk3288.c                                             |   12 
 drivers/clk/rockchip/clk-rk3576.c                                             |   11 
 drivers/clk/samsung/clk-s5pv210-audss.c                                       |   12 
 drivers/clk/samsung/clk.c                                                     |   12 
 drivers/clk/stm32/clk-stm32mp21.c                                             |    1 
 drivers/clk/stm32/clk-stm32mp25.c                                             |    1 
 drivers/clk/tegra/clk-tegra124-emc.c                                          |    1 
 drivers/clk/tegra/clk-tegra210.c                                              |   12 
 drivers/clk/ti/adpll.c                                                        |    4 
 drivers/clk/ti/divider.c                                                      |    2 
 drivers/clk/ti/mux.c                                                          |   22 
 drivers/clk/visconti/clkc.c                                                   |    2 
 drivers/clk/x86/clk-pmc-atom.c                                                |    3 
 drivers/clocksource/clps711x-timer.c                                          |    2 
 drivers/clocksource/timer-armada-370-xp.c                                     |   30 
 drivers/cpufreq/Kconfig.x86                                                   |   14 
 drivers/cpufreq/amd-pstate-ut.c                                               |    5 
 drivers/cpufreq/amd-pstate.c                                                  |  463 +-
 drivers/cpufreq/amd-pstate.h                                                  |   17 
 drivers/cpufreq/imx6q-cpufreq.c                                               |    6 
 drivers/cpufreq/intel_pstate.c                                                |   19 
 drivers/cpufreq/spear-cpufreq.c                                               |    4 
 drivers/cpuidle/cpuidle-psci.c                                                |   12 
 drivers/crypto/atmel-ecc.c                                                    |    3 
 drivers/crypto/atmel-sha204a.c                                                |    6 
 drivers/crypto/ccp/sev-dev.c                                                  |   17 
 drivers/crypto/gemini/sl3516-ce-cipher.c                                      |    8 
 drivers/crypto/hisilicon/sec2/sec_crypto.c                                    |   12 
 drivers/crypto/intel/keembay/keembay-ocs-aes-core.c                           |    9 
 drivers/crypto/intel/qat/qat_common/adf_aer.c                                 |    2 
 drivers/crypto/intel/qat/qat_common/adf_cfg.c                                 |   10 
 drivers/crypto/intel/qat/qat_common/adf_cfg_common.h                          |    1 
 drivers/crypto/intel/qat/qat_common/adf_cfg_services.c                        |    2 
 drivers/crypto/intel/qat/qat_common/adf_mstate_mgr.c                          |    3 
 drivers/crypto/intel/qat/qat_common/adf_transport_debug.c                     |    3 
 drivers/crypto/intel/qat/qat_common/qat_algs.c                                |    1 
 drivers/crypto/intel/qat/qat_common/qat_compression.c                         |    3 
 drivers/crypto/rockchip/rk3288_crypto_ahash.c                                 |    7 
 drivers/crypto/sa2ul.c                                                        |    6 
 drivers/crypto/xilinx/xilinx-trng.c                                           |   32 
 drivers/cxl/core/features.c                                                   |   12 
 drivers/cxl/core/mbox.c                                                       |   11 
 drivers/cxl/core/memdev.c                                                     |    2 
 drivers/cxl/core/port.c                                                       |    4 
 drivers/cxl/core/region.c                                                     |    7 
 drivers/cxl/pci.c                                                             |   13 
 drivers/dax/super.c                                                           |   12 
 drivers/dma-buf/dma-heap.c                                                    |   80 
 drivers/dma/dw-edma/dw-edma-core.c                                            |  104 
 drivers/dma/hisi_dma.c                                                        |    2 
 drivers/dma/mediatek/mtk-uart-apdma.c                                         |    2 
 drivers/dma/qcom/bam_dma.c                                                    |    1 
 drivers/dma/xilinx/xilinx_dma.c                                               |   12 
 drivers/dma/xilinx/zynqmp_dma.c                                               |    4 
 drivers/firewire/.kunitconfig                                                 |    1 
 drivers/firewire/Kconfig                                                      |   15 
 drivers/firewire/core-topology.c                                              |   62 
 drivers/firewire/node-tree-test.c                                             |  607 ++
 drivers/firmware/arm_scmi/bus.c                                               |   89 
 drivers/firmware/arm_scmi/common.h                                            |    2 
 drivers/firmware/arm_scmi/driver.c                                            |   77 
 drivers/firmware/arm_scmi/notify.c                                            |   21 
 drivers/firmware/arm_scmi/notify.h                                            |    1 
 drivers/firmware/arm_scmi/transports/mailbox.c                                |   26 
 drivers/firmware/arm_scmi/transports/smc.c                                    |   15 
 drivers/firmware/google/coreboot_table.c                                      |   26 
 drivers/firmware/qcom/Makefile                                                |    1 
 drivers/firmware/qcom/qcom_scm-smc.c                                          |   12 
 drivers/firmware/qcom/qcom_scm.c                                              |  180 
 drivers/firmware/qcom/qcom_scm.h                                              |    3 
 drivers/firmware/qcom/qcom_scm_trace.h                                        |  143 
 drivers/firmware/qcom/qcom_tzmem.c                                            |   13 
 drivers/gpio/gpio-mxc.c                                                       |   12 
 drivers/gpio/gpio-pxa.c                                                       |   12 
 drivers/gpio/gpio-sa1100.c                                                    |   12 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                                         |   74 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                             |   28 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h                             |    7 
 drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c                        |    3 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c                           |   24 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c                         |   35 
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c                                |    2 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c                           |    2 
 drivers/gpu/drm/bridge/display-connector.c                                    |   36 
 drivers/gpu/drm/bridge/synopsys/dw-dp.c                                       |   14 
 drivers/gpu/drm/bridge/tc358767.c                                             |    2 
 drivers/gpu/drm/drm_dumb_buffers.c                                            |    1 
 drivers/gpu/drm/lima/lima_device.c                                            |   12 
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c                                     |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                         |  105 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h                                         |   20 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c                                   |    5 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h                                   |   68 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c                                 |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                                   |    3 
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c                                      |   22 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c                                      |   11 
 drivers/gpu/drm/msm/dp/dp_ctrl.c                                              |    5 
 drivers/gpu/drm/msm/dp/dp_display.c                                           |   28 
 drivers/gpu/drm/msm/dp/dp_panel.c                                             |    4 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                            |    2 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h                                         |    1 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c                                     |   18 
 drivers/gpu/drm/msm/msm_drv.h                                                 |    8 
 drivers/gpu/drm/msm/msm_gem_vma.c                                             |    2 
 drivers/gpu/drm/msm/msm_gpu.c                                                 |    6 
 drivers/gpu/drm/msm/msm_ringbuffer.c                                          |    7 
 drivers/gpu/drm/msm/msm_ringbuffer.h                                          |    1 
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml                             |  248 -
 drivers/gpu/drm/mxsfb/lcdif_kms.c                                             |   15 
 drivers/gpu/drm/omapdrm/dss/dsi.c                                             |    7 
 drivers/gpu/drm/omapdrm/dss/dsi.h                                             |    2 
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c                                 |   10 
 drivers/gpu/drm/panthor/panthor_drv.c                                         |    2 
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c                               |   22 
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c                                     |   45 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                                  |    5 
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c                                  |   21 
 drivers/gpu/drm/sun4i/sun4i_crtc.c                                            |    2 
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c                                        |    2 
 drivers/gpu/drm/sun4i/sun4i_tcon.c                                            |   22 
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c                                         |    2 
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c                                        |    2 
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c                                       |   18 
 drivers/gpu/drm/tve200/tve200_drv.c                                           |    1 
 drivers/gpu/drm/v3d/v3d_sched.c                                               |   60 
 drivers/gpu/drm/xe/tests/xe_migrate.c                                         |    3 
 drivers/gpu/drm/xe/xe_gt_idle.c                                               |    3 
 drivers/gpu/host1x/debug.c                                                    |    4 
 drivers/gpu/host1x/hw/channel_hw.c                                            |    5 
 drivers/hid/hid-core.c                                                        |    9 
 drivers/hid/hid-haptic.c                                                      |    2 
 drivers/hid/hid-lg4ff.c                                                       |    8 
 drivers/hid/hid-multitouch.c                                                  |    2 
 drivers/hid/hid-nintendo.c                                                    |    1 
 drivers/hid/hid-roccat-kone.c                                                 |    8 
 drivers/hid/hid-steam.c                                                       |  518 +-
 drivers/hid/i2c-hid/Makefile                                                  |    2 
 drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c                                    |  104 
 drivers/hid/i2c-hid/i2c-hid-acpi.c                                            |   52 
 drivers/hid/i2c-hid/i2c-hid-acpi.h                                            |   33 
 drivers/hid/i2c-hid/i2c-hid-core.c                                            |    2 
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c                                       |    4 
 drivers/hv/vmbus_drv.c                                                        |   29 
 drivers/hwmon/coretemp.c                                                      |    1 
 drivers/hwmon/cros_ec_hwmon.c                                                 |  121 
 drivers/hwmon/emc1403.c                                                       |   73 
 drivers/hwspinlock/hwspinlock_core.c                                          |    2 
 drivers/hwtracing/coresight/coresight-etm4x-cfg.c                             |    2 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                            |  111 
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c                           |    6 
 drivers/hwtracing/coresight/coresight-etm4x.h                                 |   63 
 drivers/i2c/busses/i2c-ocores.c                                               |    6 
 drivers/i2c/busses/i2c-qcom-cci.c                                             |   24 
 drivers/i3c/master.c                                                          |   63 
 drivers/i3c/master/adi-i3c-master.c                                           |    1 
 drivers/i3c/master/dw-i3c-master.c                                            |   10 
 drivers/i3c/master/renesas-i3c.c                                              |   28 
 drivers/idle/intel_idle.c                                                     |  194 
 drivers/iio/accel/dmard09.c                                                   |    7 
 drivers/iio/light/apds9306.c                                                  |    8 
 drivers/iio/light/gp2ap002.c                                                  |   14 
 drivers/iio/light/isl29028.c                                                  |    2 
 drivers/iio/light/opt4060.c                                                   |    4 
 drivers/iio/light/tsl2583.c                                                   |    2 
 drivers/iio/light/tsl2772.c                                                   |    2 
 drivers/iio/orientation/hid-sensor-rotation.c                                 |   20 
 drivers/infiniband/core/cma.c                                                 |    6 
 drivers/infiniband/core/counters.c                                            |    5 
 drivers/infiniband/core/cq.c                                                  |    2 
 drivers/infiniband/core/device.c                                              |    2 
 drivers/infiniband/core/nldev.c                                               |   20 
 drivers/infiniband/core/restrack.c                                            |  174 
 drivers/infiniband/core/restrack.h                                            |    4 
 drivers/infiniband/core/ucma.c                                                |    2 
 drivers/infiniband/core/uverbs_cmd.c                                          |   10 
 drivers/infiniband/core/uverbs_std_types_device.c                             |   42 
 drivers/infiniband/core/uverbs_std_types_dmah.c                               |    7 
 drivers/infiniband/core/verbs.c                                               |   79 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                      |    6 
 drivers/infiniband/hw/cxgb4/device.c                                          |    2 
 drivers/infiniband/hw/cxgb4/mem.c                                             |    4 
 drivers/infiniband/hw/efa/efa_verbs.c                                         |   13 
 drivers/infiniband/hw/erdma/Kconfig                                           |    2 
 drivers/infiniband/hw/erdma/erdma_cm.c                                        |    6 
 drivers/infiniband/hw/erdma/erdma_eq.c                                        |   10 
 drivers/infiniband/hw/erdma/erdma_verbs.c                                     |   39 
 drivers/infiniband/hw/erdma/erdma_verbs.h                                     |   40 
 drivers/infiniband/hw/hfi1/chip.c                                             |    4 
 drivers/infiniband/hw/hfi1/hfi.h                                              |    2 
 drivers/infiniband/hw/hfi1/init.c                                             |   44 
 drivers/infiniband/hw/hfi1/user_sdma.c                                        |   13 
 drivers/infiniband/hw/irdma/utils.c                                           |    6 
 drivers/infiniband/hw/irdma/verbs.c                                           |  116 
 drivers/infiniband/hw/irdma/verbs.h                                           |    3 
 drivers/infiniband/hw/mana/qp.c                                               |   10 
 drivers/infiniband/hw/mlx5/cong.c                                             |    8 
 drivers/infiniband/hw/mlx5/main.c                                             |  127 
 drivers/infiniband/hw/mlx5/mlx5_ib.h                                          |    2 
 drivers/infiniband/hw/mlx5/qp.c                                               |   25 
 drivers/infiniband/sw/rxe/rxe_odp.c                                           |    1 
 drivers/infiniband/sw/rxe/rxe_req.c                                           |   15 
 drivers/infiniband/sw/rxe/rxe_resp.c                                          |    9 
 drivers/infiniband/sw/siw/siw_cm.c                                            |    2 
 drivers/infiniband/ulp/ipoib/ipoib_main.c                                     |    2 
 drivers/infiniband/ulp/isert/ib_isert.c                                       |   85 
 drivers/infiniband/ulp/isert/ib_isert.h                                       |    1 
 drivers/infiniband/ulp/srp/ib_srp.c                                           |   45 
 drivers/infiniband/ulp/srpt/ib_srpt.c                                         |    9 
 drivers/iommu/amd/debugfs.c                                                   |   12 
 drivers/iommu/amd/init.c                                                      |   58 
 drivers/iommu/amd/ppr.c                                                       |    2 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                                   |    9 
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c                                |  119 
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                                       |    6 
 drivers/iommu/dma-iommu.c                                                     |   26 
 drivers/iommu/intel/iommu.c                                                   |   31 
 drivers/iommu/intel/iommu.h                                                   |    2 
 drivers/iommu/intel/pasid.c                                                   |    9 
 drivers/iommu/iommufd/device.c                                                |   13 
 drivers/iommu/iommufd/iommufd_private.h                                       |    9 
 drivers/iommu/iommufd/main.c                                                  |   20 
 drivers/iommu/iommufd/selftest.c                                              |    5 
 drivers/iommu/msm_iommu.c                                                     |    2 
 drivers/iommu/mtk_iommu_v1.c                                                  |    2 
 drivers/ipack/devices/ipoctal.c                                               |   56 
 drivers/irqchip/exynos-combiner.c                                             |   14 
 drivers/irqchip/irq-armada-370-xp.c                                           |   12 
 drivers/irqchip/irq-bcm7038-l1.c                                              |   12 
 drivers/irqchip/irq-gic-v3-its.c                                              |   35 
 drivers/irqchip/irq-gic-v5-irs.c                                              |    2 
 drivers/irqchip/irq-gic-v5.c                                                  |   11 
 drivers/irqchip/irq-i8259.c                                                   |   12 
 drivers/irqchip/irq-imx-gpcv2.c                                               |   16 
 drivers/irqchip/irq-loongson-eiointc.c                                        |   12 
 drivers/irqchip/irq-loongson-htpic.c                                          |   10 
 drivers/irqchip/irq-loongson-htvec.c                                          |   12 
 drivers/irqchip/irq-loongson-pch-lpc.c                                        |   12 
 drivers/irqchip/irq-loongson-pch-pic.c                                        |   12 
 drivers/irqchip/irq-mchp-eic.c                                                |   12 
 drivers/irqchip/irq-mst-intc.c                                                |   12 
 drivers/irqchip/irq-mtk-cirq.c                                                |   12 
 drivers/irqchip/irq-realtek-rtl.c                                             |  187 
 drivers/irqchip/irq-renesas-irqc.c                                            |    1 
 drivers/irqchip/irq-renesas-rzg2l.c                                           |   16 
 drivers/irqchip/irq-sa11x0.c                                                  |   12 
 drivers/irqchip/irq-sifive-plic.c                                             |   12 
 drivers/irqchip/irq-sun6i-r.c                                                 |   18 
 drivers/irqchip/irq-tegra.c                                                   |   12 
 drivers/irqchip/irq-vic.c                                                     |   12 
 drivers/leds/leds-gpio.c                                                      |    1 
 drivers/leds/leds-pca9532.c                                                   |   18 
 drivers/leds/leds-st1202.c                                                    |   96 
 drivers/leds/trigger/ledtrig-cpu.c                                            |   14 
 drivers/macintosh/via-pmu.c                                                   |   12 
 drivers/mailbox/pcc.c                                                         |   41 
 drivers/mailbox/qcom-cpucp-mbox.c                                             |   25 
 drivers/mailbox/riscv-sbi-mpxy-mbox.c                                         |   12 
 drivers/mailbox/rockchip-mailbox.c                                            |   17 
 drivers/md/dm-integrity.c                                                     |  139 
 drivers/md/dm-pcache/cache.c                                                  |    7 
 drivers/md/dm-pcache/cache.h                                                  |    3 
 drivers/md/dm-pcache/cache_gc.c                                               |    5 
 drivers/md/dm-pcache/cache_key.c                                              |   83 
 drivers/md/dm-pcache/cache_writeback.c                                        |    8 
 drivers/md/md-bitmap.c                                                        |    5 
 drivers/md/md-bitmap.h                                                        |    1 
 drivers/md/md-llbitmap.c                                                      |   20 
 drivers/md/md.c                                                               |  109 
 drivers/md/md.h                                                               |    1 
 drivers/md/raid1.c                                                            |    2 
 drivers/md/raid10.c                                                           |   14 
 drivers/md/raid5-ppl.c                                                        |    4 
 drivers/md/raid5.c                                                            |   87 
 drivers/media/cec/core/cec-pin.c                                              |    8 
 drivers/media/i2c/rdacm21.c                                                   |    5 
 drivers/media/pci/intel/ipu6/ipu6.c                                           |   10 
 drivers/media/platform/broadcom/bcm2835-unicam.c                              |    2 
 drivers/media/platform/qcom/iris/iris_core.c                                  |   12 
 drivers/media/platform/qcom/iris/iris_state.c                                 |    2 
 drivers/media/v4l2-core/v4l2-async.c                                          |   15 
 drivers/mfd/iqs62x.c                                                          |    2 
 drivers/mfd/macsmc.c                                                          |    8 
 drivers/mfd/rave-sp.c                                                         |   64 
 drivers/misc/ad525x_dpot-i2c.c                                                |    1 
 drivers/misc/ad525x_dpot-spi.c                                                |    1 
 drivers/misc/ad525x_dpot.c                                                    |  177 
 drivers/misc/ad525x_dpot.h                                                    |    3 
 drivers/misc/bcm-vk/bcm_vk_msg.c                                              |    6 
 drivers/misc/cardreader/rtsx_pcr.c                                            |    2 
 drivers/misc/cardreader/rtsx_usb.c                                            |   26 
 drivers/misc/fastrpc.c                                                        |   16 
 drivers/misc/lan966x_pci.c                                                    |    1 
 drivers/misc/pci_endpoint_test.c                                              |   11 
 drivers/misc/sgi-gru/grufault.c                                               |  101 
 drivers/misc/sgi-gru/gruprocfs.c                                              |    1 
 drivers/misc/sgi-gru/grutables.h                                              |    1 
 drivers/misc/vmw_vmci/vmci_event.c                                            |    4 
 drivers/mtd/devices/mtd_intel_dg.c                                            |   76 
 drivers/mtd/mtdpart.c                                                         |    3 
 drivers/mtd/mtdswap.c                                                         |    1 
 drivers/mtd/nand/raw/pl35x-nand-controller.c                                  |   10 
 drivers/mtd/ubi/attach.c                                                      |    4 
 drivers/mtd/ubi/build.c                                                       |   11 
 drivers/mtd/ubi/fastmap.c                                                     |    6 
 drivers/mtd/ubi/io.c                                                          |   11 
 drivers/mtd/ubi/ubi.h                                                         |    4 
 drivers/mtd/ubi/wl.c                                                          |   15 
 drivers/net/amt.c                                                             |    3 
 drivers/net/bonding/bond_netlink.c                                            |    2 
 drivers/net/dsa/b53/b53_common.c                                              |    2 
 drivers/net/dsa/mv88e6xxx/pcs-6352.c                                          |    5 
 drivers/net/ethernet/airoha/airoha_npu.c                                      |    2 
 drivers/net/ethernet/allwinner/sun4i-emac.c                                   |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                     |    8 
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c                               |    2 
 drivers/net/ethernet/freescale/enetc/enetc.c                                  |   72 
 drivers/net/ethernet/freescale/enetc/enetc.h                                  |    9 
 drivers/net/ethernet/freescale/enetc/enetc_pf.c                               |   14 
 drivers/net/ethernet/freescale/fec_main.c                                     |    6 
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c                                |    9 
 drivers/net/ethernet/intel/ice/devlink/devlink.c                              |   32 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                                  |   64 
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c                                |    8 
 drivers/net/ethernet/intel/ice/ice_lag.c                                      |    3 
 drivers/net/ethernet/intel/ice/ice_lib.c                                      |    3 
 drivers/net/ethernet/intel/ice/ice_main.c                                     |   10 
 drivers/net/ethernet/intel/ice/ice_nvm.c                                      |   90 
 drivers/net/ethernet/intel/ice/ice_nvm.h                                      |    2 
 drivers/net/ethernet/intel/ice/ice_ptp.c                                      |    6 
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c                                   |   38 
 drivers/net/ethernet/intel/ice/ice_sriov.c                                    |    3 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                                   |    2 
 drivers/net/ethernet/intel/igc/igc_main.c                                     |    3 
 drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c                        |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c                       |    6 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                           |   11 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c                      |    6 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c                     |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c                          |   20 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c                         |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c                           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c                              |   20 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                               |   39 
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c                             |    2 
 drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c                       |   37 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                             |   21 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                             |    7 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c                    |  211 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c                             |    5 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                             |  222 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h                             |   11 
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c                           |   39 
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h                           |   14 
 drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c                            |  116 
 drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.h                            |    9 
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h                           |    1 
 drivers/net/ethernet/mellanox/mlx5/core/port.c                                |   24 
 drivers/net/ethernet/mellanox/mlx5/core/vport.c                               |  102 
 drivers/net/ethernet/nvidia/forcedeth.c                                       |    2 
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c                              |   27 
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c                              |  445 +
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c                          |    1 
 drivers/net/ethernet/realtek/8139cp.c                                         |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c                          |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c                             |    2 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c                           |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                             |   11 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c                        |   41 
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c                               |   61 
 drivers/net/ethernet/wangxun/libwx/wx_hw.c                                    |   71 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                                   |   99 
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c                                   |   18 
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c                                 |    6 
 drivers/net/ethernet/wangxun/libwx/wx_type.h                                  |   52 
 drivers/net/ethernet/wangxun/libwx/wx_vf.h                                    |    1 
 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c                             |   14 
 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c                                |    3 
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c                              |    6 
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c                                 |   48 
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c                            |    6 
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c                                |    7 
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c                               |   19 
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h                               |    2 
 drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c                           |   11 
 drivers/net/gtp.c                                                             |    2 
 drivers/net/ipa/ipa_main.c                                                    |    6 
 drivers/net/netdevsim/netdev.c                                                |    2 
 drivers/net/ppp/pppox.c                                                       |   17 
 drivers/net/slip/slip.c                                                       |    8 
 drivers/net/thunderbolt/main.c                                                |    6 
 drivers/net/vxlan/vxlan_mdb.c                                                 |    9 
 drivers/net/vxlan/vxlan_vnifilter.c                                           |    6 
 drivers/net/wireless/ath/ath10k/snoc.c                                        |    9 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                       |   30 
 drivers/net/wireless/ath/ath11k/wmi.c                                         |   40 
 drivers/net/wireless/ath/ath12k/ahb.c                                         |   18 
 drivers/net/wireless/ath/ath12k/core.c                                        |   27 
 drivers/net/wireless/ath/ath12k/core.h                                        |    2 
 drivers/net/wireless/ath/ath12k/qmi.c                                         |  168 
 drivers/net/wireless/ath/ath12k/wmi.c                                         |   28 
 drivers/net/wireless/ath/ath6kl/wmi.c                                         |   17 
 drivers/net/wireless/intel/iwlwifi/fw/dump.c                                  |    2 
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c                              |    8 
 drivers/net/wireless/intel/iwlwifi/mei/main.c                                 |    8 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                                  |    2 
 drivers/net/wireless/mediatek/mt76/Kconfig                                    |    4 
 drivers/net/wireless/mediatek/mt76/Makefile                                   |    5 
 drivers/net/wireless/mediatek/mt76/dma.c                                      |  125 
 drivers/net/wireless/mediatek/mt76/dma.h                                      |   69 
 drivers/net/wireless/mediatek/mt76/mac80211.c                                 |   14 
 drivers/net/wireless/mediatek/mt76/mcu.c                                      |   12 
 drivers/net/wireless/mediatek/mt76/mt76.h                                     |  138 
 drivers/net/wireless/mediatek/mt76/mt76_connac.h                              |   13 
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
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c                               |    3 
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c                               |  103 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                              |   38 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                               |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c                           |   74 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                              |   18 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                               |   55 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                              |   60 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                               |  106 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                               |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c                              |   39 
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                            |   26 
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h                              |   24 
 drivers/net/wireless/mediatek/mt76/npu.c                                      |  502 ++
 drivers/net/wireless/mediatek/mt76/scan.c                                     |    5 
 drivers/net/wireless/mediatek/mt76/sdio.c                                     |   11 
 drivers/net/wireless/mediatek/mt76/tx.c                                       |    9 
 drivers/net/wireless/realtek/rtlwifi/pci.c                                    |    6 
 drivers/net/wireless/realtek/rtw89/cam.c                                      |  156 
 drivers/net/wireless/realtek/rtw89/cam.h                                      |  435 -
 drivers/net/wireless/realtek/rtw89/core.c                                     |   52 
 drivers/net/wireless/realtek/rtw89/core.h                                     |   22 
 drivers/net/wireless/realtek/rtw89/debug.c                                    |  387 +
 drivers/net/wireless/realtek/rtw89/fw.c                                       |   58 
 drivers/net/wireless/realtek/rtw89/fw.h                                       |    9 
 drivers/net/wireless/realtek/rtw89/mac.c                                      |    6 
 drivers/net/wireless/realtek/rtw89/mac.h                                      |    2 
 drivers/net/wireless/realtek/rtw89/mac80211.c                                 |   40 
 drivers/net/wireless/realtek/rtw89/pci.c                                      |   29 
 drivers/net/wireless/realtek/rtw89/pci.h                                      |    1 
 drivers/net/wireless/realtek/rtw89/phy.c                                      |   17 
 drivers/net/wireless/realtek/rtw89/rtw8851be.c                                |    1 
 drivers/net/wireless/realtek/rtw89/rtw8852a.c                                 |    7 
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c                                |    1 
 drivers/net/wireless/realtek/rtw89/rtw8852be.c                                |    1 
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c                               |    1 
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c                                |    1 
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c                                |    1 
 drivers/net/wireless/realtek/rtw89/wow.c                                      |    6 
 drivers/net/wireless/virtual/mac80211_hwsim.c                                 |    5 
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c                                  |    8 
 drivers/nfc/pn533/pn533.c                                                     |   21 
 drivers/nvdimm/label.c                                                        |   15 
 drivers/nvdimm/nd_virtio.c                                                    |  121 
 drivers/nvdimm/pmem.c                                                         |   15 
 drivers/nvdimm/region_devs.c                                                  |    5 
 drivers/nvdimm/virtio_pmem.c                                                  |   17 
 drivers/nvdimm/virtio_pmem.h                                                  |    6 
 drivers/nvme/host/apple.c                                                     |   63 
 drivers/nvme/host/core.c                                                      |   79 
 drivers/nvme/host/fabrics.h                                                   |    6 
 drivers/nvme/host/fc.c                                                        |    7 
 drivers/nvme/host/ioctl.c                                                     |  117 
 drivers/nvme/host/nvme.h                                                      |   68 
 drivers/nvme/host/pci.c                                                       |   29 
 drivers/nvme/host/rdma.c                                                      |    1 
 drivers/nvme/host/sysfs.c                                                     |   23 
 drivers/nvme/host/tcp.c                                                       |    1 
 drivers/nvme/target/core.c                                                    |    3 
 drivers/nvme/target/fabrics-cmd-auth.c                                        |   12 
 drivers/nvme/target/loop.c                                                    |    1 
 drivers/nvme/target/pr.c                                                      |   27 
 drivers/nvme/target/rdma.c                                                    |   31 
 drivers/nvme/target/zns.c                                                     |    2 
 drivers/pci/controller/cadence/pci-j721e.c                                    |    4 
 drivers/pci/controller/pci-xgene.c                                            |    5 
 drivers/pci/controller/plda/pcie-starfive.c                                   |   10 
 drivers/pci/hotplug/pnv_php.c                                                 |    2 
 drivers/pci/hotplug/rpaphp_slot.c                                             |    2 
 drivers/pci/pci.c                                                             |    5 
 drivers/pci/pcie/aspm.c                                                       |   19 
 drivers/pci/slot.c                                                            |   67 
 drivers/perf/arm_pmuv3.c                                                      |    2 
 drivers/perf/arm_spe_pmu.c                                                    |    2 
 drivers/perf/cxl_pmu.c                                                        |    2 
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c                                     |  736 ++-
 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v8.h                                 |   25 
 drivers/phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h                         |   52 
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c                                      |    1 
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h                                |   12 
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h                                |   17 
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h                               |   12 
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v8.h                               |   12 
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h                           |  639 ++
 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c                                |   12 
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c                                       |   12 
 drivers/phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h                              |   33 
 drivers/phy/qualcomm/phy-qcom-qmp-usb43-qserdes-com-v8.h                      |  224 
 drivers/phy/qualcomm/phy-qcom-qmp.h                                           |    2 
 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c                                     |   43 
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c                                 |   26 
 drivers/phy/renesas/Kconfig                                                   |    1 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                                      |  187 
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c                              |    2 
 drivers/phy/starfive/phy-jh7110-dphy-rx.c                                     |    5 
 drivers/phy/starfive/phy-jh7110-dphy-tx.c                                     |    5 
 drivers/phy/sunplus/phy-sunplus-usb2.c                                        |    6 
 drivers/pinctrl/bcm/pinctrl-bcm2835.c                                         |    1 
 drivers/pinctrl/mediatek/mtk-eint.c                                           |   25 
 drivers/pinctrl/mediatek/pinctrl-airoha.c                                     | 2278 +++++-----
 drivers/pinctrl/pinctrl-eic7700.c                                             |    3 
 drivers/pinctrl/pinctrl-rockchip.c                                            |   10 
 drivers/pinctrl/spacemit/pinctrl-k1.c                                         |   10 
 drivers/platform/chrome/cros_ec_debugfs.c                                     |    6 
 drivers/platform/chrome/cros_ec_sensorhub_ring.c                              |    9 
 drivers/platform/chrome/cros_ec_typec.c                                       |    6 
 drivers/platform/mellanox/mlxbf-bootctl.c                                     |    1 
 drivers/platform/mellanox/mlxbf-pmc.c                                         |   10 
 drivers/platform/surface/surface_acpi_notify.c                                |    6 
 drivers/platform/x86/acer-wmi.c                                               |    4 
 drivers/platform/x86/amd/hsmp/hwmon.c                                         |    3 
 drivers/platform/x86/amd/pmc/mp1_stb.c                                        |   23 
 drivers/platform/x86/dell/dell-wmi-base.c                                     |   17 
 drivers/platform/x86/dell/dell-wmi-privacy.c                                  |    4 
 drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h                   |    2 
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c                     |    5 
 drivers/platform/x86/hp/hp-wmi.c                                              |    4 
 drivers/platform/x86/intel/int1092/intel_sar.c                                |   39 
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c                   |   14 
 drivers/platform/x86/lg-laptop.c                                              |   79 
 drivers/pmdomain/bcm/bcm2835-power.c                                          |    7 
 drivers/power/reset/sc27xx-poweroff.c                                         |   10 
 drivers/power/supply/bd99954-charger.h                                        |   23 
 drivers/power/supply/bq27xxx_battery.c                                        |    6 
 drivers/power/supply/isp1704_charger.c                                        |    1 
 drivers/power/supply/sbs-battery.c                                            |    7 
 drivers/power/supply/sc2731_charger.c                                         |    2 
 drivers/powercap/intel_rapl_tpmi.c                                            |    5 
 drivers/pps/clients/pps-gpio.c                                                |   72 
 drivers/pps/pps.c                                                             |   10 
 drivers/ptp/ptp_netc.c                                                        |   13 
 drivers/rapidio/rio-scan.c                                                    |    1 
 drivers/regulator/adp5055-regulator.c                                         |    2 
 drivers/regulator/core.c                                                      |    6 
 drivers/regulator/qcom-rpmh-regulator.c                                       |    6 
 drivers/regulator/tps6594-regulator.c                                         |   19 
 drivers/remoteproc/qcom_common.c                                              |    4 
 drivers/remoteproc/qcom_q6v5_adsp.c                                           |    1 
 drivers/remoteproc/remoteproc_core.c                                          |  150 
 drivers/remoteproc/remoteproc_sysfs.c                                         |    1 
 drivers/rpmsg/qcom_glink_native.c                                             |   42 
 drivers/rtc/rtc-gamecube.c                                                    |    4 
 drivers/rtc/rtc-pcf85363.c                                                    |   17 
 drivers/rtc/rtc-pcf8563.c                                                     |    4 
 drivers/rtc/rtc-spacemit-p1.c                                                 |    5 
 drivers/rtc/rtc-zynqmp.c                                                      |    7 
 drivers/scsi/mpt3sas/mpt3sas_base.c                                           |    2 
 drivers/scsi/qla2xxx/qla_attr.c                                               |    1 
 drivers/scsi/qla2xxx/qla_nx2.c                                                |    2 
 drivers/scsi/sd.c                                                             |    4 
 drivers/scsi/smartpqi/smartpqi_init.c                                         |   18 
 drivers/sh/clk/core.c                                                         |   10 
 drivers/sh/intc/core.c                                                        |   12 
 drivers/soc/bcm/brcmstb/biuctrl.c                                             |   12 
 drivers/soc/fsl/qe/gpio.c                                                     |   25 
 drivers/soc/fsl/qe/qe_ic.c                                                    |    3 
 drivers/soc/fsl/qe/qe_io.c                                                    |   15 
 drivers/soc/qcom/rpmh-rsc.c                                                   |   37 
 drivers/soc/renesas/Kconfig                                                   |    1 
 drivers/soc/samsung/exynos-pmu.c                                              |    4 
 drivers/soc/tegra/pmc.c                                                       |   17 
 drivers/soundwire/bus.c                                                       |   31 
 drivers/soundwire/qcom.c                                                      |    2 
 drivers/spi/spi-amlogic-spisg.c                                               |    2 
 drivers/spi/spi-davinci.c                                                     |    7 
 drivers/spi/spi-geni-qcom.c                                                   |   17 
 drivers/spi/spi-img-spfi.c                                                    |    5 
 drivers/spi/spi-oc-tiny.c                                                     |   24 
 drivers/spi/spi-sprd-adi.c                                                    |    6 
 drivers/staging/fbtft/fbtft-sysfs.c                                           |    2 
 drivers/staging/gpib/common/gpib_os.c                                         |   21 
 drivers/staging/gpib/common/iblib.c                                           |    3 
 drivers/staging/greybus/audio_gb.c                                            |   13 
 drivers/staging/greybus/audio_manager_sysfs.c                                 |    2 
 drivers/staging/media/ipu7/ipu7-isys.c                                        |    1 
 drivers/staging/media/ipu7/ipu7.c                                             |    4 
 drivers/staging/octeon/ethernet-mem.c                                         |   43 
 drivers/staging/octeon/ethernet-mem.h                                         |    8 
 drivers/staging/octeon/ethernet-rx.c                                          |   51 
 drivers/staging/octeon/ethernet-rx.h                                          |   11 
 drivers/staging/octeon/ethernet-tx.c                                          |    2 
 drivers/staging/octeon/ethernet.c                                             |   43 
 drivers/staging/octeon/octeon-ethernet.h                                      |   14 
 drivers/staging/rtl8723bs/core/rtw_ap.c                                       |    8 
 drivers/staging/rtl8723bs/core/rtw_cmd.c                                      |   89 
 drivers/staging/rtl8723bs/core/rtw_efuse.c                                    |    1 
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c                                |    1 
 drivers/staging/rtl8723bs/core/rtw_mlme.c                                     |   29 
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                                 |  106 
 drivers/staging/rtl8723bs/core/rtw_recv.c                                     |   27 
 drivers/staging/rtl8723bs/core/rtw_security.c                                 |  159 
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c                                |    3 
 drivers/staging/rtl8723bs/core/rtw_xmit.c                                     |   97 
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c                                |    2 
 drivers/staging/rtl8723bs/hal/sdio_ops.c                                      |    2 
 drivers/staging/rtl8723bs/include/basic_types.h                               |    1 
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c                             |   29 
 drivers/staging/rtl8723bs/os_dep/os_intfs.c                                   |    2 
 drivers/staging/rtl8723bs/os_dep/osdep_service.c                              |    7 
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c                                  |    4 
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c                                 |    2 
 drivers/staging/sm750fb/Kconfig                                               |    1 
 drivers/staging/sm750fb/sm750.c                                               |    6 
 drivers/staging/sm750fb/sm750.h                                               |    2 
 drivers/staging/sm750fb/sm750_accel.c                                         |    6 
 drivers/staging/sm750fb/sm750_accel.h                                         |    4 
 drivers/thermal/airoha_thermal.c                                              |    4 
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c                       |    4 
 drivers/thermal/intel/intel_hfi.c                                             |   12 
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c                                      |    3 
 drivers/thermal/renesas/rcar_thermal.c                                        |   15 
 drivers/tty/hvc/Kconfig                                                       |    2 
 drivers/tty/serial/8250/8250_core.c                                           |    6 
 drivers/tty/serial/8250/8250_port.c                                           |   21 
 drivers/tty/serial/amba-pl011.c                                               |   48 
 drivers/tty/serial/bcm63xx_uart.c                                             |    2 
 drivers/tty/serial/ma35d1_serial.c                                            |   12 
 drivers/tty/serial/omap-serial.c                                              |    2 
 drivers/tty/serial/pch_uart.c                                                 |    2 
 drivers/tty/serial/pxa.c                                                      |    2 
 drivers/tty/serial/qcom_geni_serial.c                                         |   10 
 drivers/tty/serial/samsung_tty.c                                              |    8 
 drivers/tty/serial/serial_core.c                                              |   21 
 drivers/tty/serial/serial_txx9.c                                              |    4 
 drivers/tty/serial/sunsu.c                                                    |    2 
 drivers/tty/tty_io.c                                                          |    4 
 drivers/ufs/core/ufs-debugfs.c                                                |    2 
 drivers/ufs/core/ufshcd.c                                                     |    1 
 drivers/uio/uio.c                                                             |    5 
 drivers/usb/atm/usbatm.c                                                      |    4 
 drivers/usb/cdns3/cdnsp-gadget.c                                              |  110 
 drivers/usb/cdns3/cdnsp-gadget.h                                              |    1 
 drivers/usb/cdns3/cdnsp-mem.c                                                 |   98 
 drivers/usb/core/driver.c                                                     |   12 
 drivers/usb/gadget/configfs.c                                                 |    4 
 drivers/usb/gadget/function/f_fs.c                                            |    8 
 drivers/usb/gadget/function/f_mass_storage.c                                  |    3 
 drivers/usb/gadget/function/f_uac1_legacy.c                                   |   56 
 drivers/usb/gadget/function/u_uac1_legacy.h                                   |    3 
 drivers/usb/gadget/udc/aspeed_udc.c                                           |   50 
 drivers/usb/gadget/udc/r8a66597-udc.c                                         |    1 
 drivers/usb/misc/usb-ljca.c                                                   |    3 
 drivers/usb/mtu3/mtu3_core.c                                                  |   11 
 drivers/usb/renesas_usbhs/common.c                                            |    6 
 drivers/usb/typec/ucsi/debugfs.c                                              |    1 
 drivers/usb/typec/ucsi/ucsi.c                                                 |    2 
 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c                                   |   68 
 drivers/vdpa/mlx5/core/mr.c                                                   |    2 
 drivers/vdpa/vdpa_sim/vdpa_sim.c                                              |   25 
 drivers/vfio/pci/vfio_pci_config.c                                            |    1 
 drivers/vhost/net.c                                                           |    3 
 drivers/video/fbdev/clps711x-fb.c                                             |    2 
 drivers/video/fbdev/kyro/fbdev.c                                              |   24 
 drivers/video/fbdev/tdfxfb.c                                                  |    2 
 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c                               |   97 
 drivers/virtio/virtio.c                                                       |   41 
 drivers/virtio/virtio_balloon.c                                               |   40 
 drivers/virtio/virtio_pci_common.c                                            |    2 
 drivers/virtio/virtio_rtc_driver.c                                            |   14 
 drivers/w1/masters/ds2482.c                                                   |    4 
 drivers/xen/xen-acpi-processor.c                                              |   12 
 drivers/xen/xenbus/xenbus_xs.c                                                |   16 
 fs/btrfs/bio.c                                                                |   68 
 fs/btrfs/bio.h                                                                |    5 
 fs/btrfs/block-group.c                                                        |    3 
 fs/btrfs/ctree.c                                                              |    3 
 fs/btrfs/defrag.c                                                             |   50 
 fs/btrfs/delayed-inode.c                                                      |    4 
 fs/btrfs/disk-io.c                                                            |   53 
 fs/btrfs/extent-io-tree.c                                                     |   10 
 fs/btrfs/extent-tree.c                                                        |   10 
 fs/btrfs/extent_io.c                                                          |   31 
 fs/btrfs/extent_io.h                                                          |   23 
 fs/btrfs/fiemap.c                                                             |    4 
 fs/btrfs/file.c                                                               |  101 
 fs/btrfs/free-space-tree.c                                                    |    4 
 fs/btrfs/inode-item.c                                                         |    7 
 fs/btrfs/inode.c                                                              |   13 
 fs/btrfs/qgroup.c                                                             |   37 
 fs/btrfs/relocation.c                                                         |    5 
 fs/btrfs/verity.c                                                             |   16 
 fs/btrfs/volumes.c                                                            |    9 
 fs/ceph/dir.c                                                                 |    2 
 fs/ceph/file.c                                                                |   48 
 fs/erofs/Kconfig                                                              |    8 
 fs/erofs/decompressor.c                                                       |    2 
 fs/erofs/internal.h                                                           |   25 
 fs/erofs/zdata.c                                                              |   31 
 fs/erofs/zmap.c                                                               |   82 
 fs/ext4/dir.c                                                                 |   20 
 fs/ext4/ext4.h                                                                |    1 
 fs/ext4/file.c                                                                |    7 
 fs/ext4/inline.c                                                              |   25 
 fs/ext4/inode.c                                                               |   52 
 fs/ext4/migrate.c                                                             |    3 
 fs/ext4/namei.c                                                               |    2 
 fs/ext4/orphan.c                                                              |   10 
 fs/f2fs/f2fs.h                                                                |   22 
 fs/f2fs/gc.c                                                                  |    5 
 fs/f2fs/segment.c                                                             |    8 
 fs/f2fs/super.c                                                               |    4 
 fs/fat/nfs.c                                                                  |    4 
 fs/fuse/cuse.c                                                                |    5 
 fs/fuse/inode.c                                                               |    2 
 fs/hfsplus/catalog.c                                                          |   25 
 fs/hfsplus/hfsplus_fs.h                                                       |    6 
 fs/hugetlbfs/inode.c                                                          |    3 
 fs/inode.c                                                                    |   18 
 fs/isofs/compress.c                                                           |    7 
 fs/nfs/blocklayout/dev.c                                                      |   21 
 fs/nfs/client.c                                                               |   14 
 fs/nfs/dir.c                                                                  |    7 
 fs/nfs/filelayout/filelayoutdev.c                                             |    3 
 fs/nfs/flexfilelayout/flexfilelayout.c                                        |    3 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                                     |    3 
 fs/nfs/inode.c                                                                |    4 
 fs/nfs/internal.h                                                             |    1 
 fs/nfs/nfs4client.c                                                           |    1 
 fs/nfs/nfs4proc.c                                                             |    4 
 fs/nfs/nfs4session.c                                                          |   16 
 fs/nfs/pnfs.c                                                                 |   35 
 fs/nfs/pnfs.h                                                                 |    3 
 fs/nfs/pnfs_nfs.c                                                             |   14 
 fs/nilfs2/page.c                                                              |   17 
 fs/nilfs2/segment.c                                                           |    4 
 fs/nilfs2/the_nilfs.c                                                         |    6 
 fs/notify/fanotify/fanotify.c                                                 |    1 
 fs/notify/fanotify/fanotify_user.c                                            |   12 
 fs/ntfs3/fslog.c                                                              |   13 
 fs/ntfs3/fsntfs.c                                                             |    8 
 fs/ntfs3/record.c                                                             |   34 
 fs/ntfs3/super.c                                                              |   13 
 fs/ntfs3/xattr.c                                                              |   21 
 fs/ocfs2/acl.c                                                                |  135 
 fs/ocfs2/acl.h                                                                |   19 
 fs/ocfs2/cluster/heartbeat.c                                                  |   86 
 fs/ocfs2/cluster/heartbeat.h                                                  |    5 
 fs/ocfs2/cluster/nodemanager.c                                                |   23 
 fs/ocfs2/cluster/nodemanager.h                                                |    2 
 fs/ocfs2/cluster/tcp.c                                                        |   83 
 fs/ocfs2/cluster/tcp.h                                                        |    1 
 fs/ocfs2/inode.c                                                              |   16 
 fs/ocfs2/namei.c                                                              |   17 
 fs/ocfs2/xattr.c                                                              |   86 
 fs/ocfs2/xattr.h                                                              |    9 
 fs/resctrl/rdtgroup.c                                                         |   19 
 fs/smb/client/cifs_debug.c                                                    |    2 
 fs/smb/client/inode.c                                                         |   14 
 fs/smb/client/smb2pdu.c                                                       |   16 
 fs/smb/server/Kconfig                                                         |    1 
 fs/smb/server/auth.c                                                          |    2 
 fs/smb/server/connection.c                                                    |   19 
 fs/smb/server/connection.h                                                    |    1 
 fs/smb/server/mgmt/share_config.c                                             |    7 
 fs/smb/server/mgmt/user_config.c                                              |    1 
 fs/smb/server/mgmt/user_session.c                                             |   24 
 fs/smb/server/mgmt/user_session.h                                             |    1 
 fs/smb/server/server.c                                                        |    4 
 fs/smb/server/smb2ops.c                                                       |   11 
 fs/smb/server/smb2pdu.c                                                       |   15 
 fs/smb/server/smbacl.c                                                        |    4 
 fs/smb/server/transport_ipc.c                                                 |   12 
 fs/smb/server/transport_tcp.c                                                 |    6 
 fs/smb/server/vfs.c                                                           |    3 
 fs/smb/server/vfs_cache.c                                                     |    5 
 fs/squashfs/cache.c                                                           |    2 
 fs/stat.c                                                                     |    2 
 fs/super.c                                                                    |    4 
 fs/udf/inode.c                                                                |  129 
 fs/udf/super.c                                                                |   23 
 fs/udf/symlink.c                                                              |    2 
 include/acpi/processor.h                                                      |    2 
 include/drm/bridge/dw_dp.h                                                    |    8 
 include/linux/bio.h                                                           |   22 
 include/linux/blk-mq.h                                                        |   16 
 include/linux/blk_types.h                                                     |   12 
 include/linux/bpf.h                                                           |   19 
 include/linux/compiler-context-analysis.h                                     |   32 
 include/linux/compiler_types.h                                                |   18 
 include/linux/dma-buf.h                                                       |    5 
 include/linux/efi.h                                                           |    4 
 include/linux/filter.h                                                        |   31 
 include/linux/firmware/qcom/qcom_scm.h                                        |   14 
 include/linux/fs.h                                                            |   20 
 include/linux/ftrace.h                                                        |    5 
 include/linux/hwmon.h                                                         |    3 
 include/linux/i3c/master.h                                                    |    3 
 include/linux/ieee80211-uhr.h                                                 |  220 
 include/linux/ieee80211.h                                                     |   33 
 include/linux/ima.h                                                           |    7 
 include/linux/io_uring_types.h                                                |    7 
 include/linux/libnvdimm.h                                                     |    9 
 include/linux/maple_tree.h                                                    |    2 
 include/linux/memory.h                                                        |   27 
 include/linux/memory_hotplug.h                                                |   18 
 include/linux/mlx5/driver.h                                                   |    1 
 include/linux/mlx5/fs.h                                                       |    1 
 include/linux/mlx5/mlx5_ifc.h                                                 |    9 
 include/linux/mlx5/vport.h                                                    |    7 
 include/linux/mmc/sdio_ids.h                                                  |    1 
 include/linux/mroute_base.h                                                   |    3 
 include/linux/nfs_xdr.h                                                       |    2 
 include/linux/nvme.h                                                          |    4 
 include/linux/pci.h                                                           |   14 
 include/linux/pm_runtime.h                                                    |   24 
 include/linux/remoteproc.h                                                    |  284 -
 include/linux/rsc_table.h                                                     |  364 +
 include/linux/rtsx_usb.h                                                      |    3 
 include/linux/sched/rt.h                                                      |    2 
 include/linux/sched/user.h                                                    |    3 
 include/linux/secure_boot.h                                                   |   23 
 include/linux/serial_core.h                                                   |   20 
 include/linux/soc/airoha/airoha_offload.h                                     |    1 
 include/linux/soc/qcom/ubwc.h                                                 |    1 
 include/linux/soundwire/sdw.h                                                 |    8 
 include/linux/syscore_ops.h                                                   |   15 
 include/linux/time_namespace.h                                                |   11 
 include/linux/usb.h                                                           |    3 
 include/linux/virtio.h                                                        |    1 
 include/linux/virtio_net.h                                                    |    4 
 include/media/rc-map.h                                                        |    2 
 include/net/act_api.h                                                         |    2 
 include/net/bluetooth/hci_core.h                                              |    2 
 include/net/bluetooth/l2cap.h                                                 |    5 
 include/net/cfg80211.h                                                        |  156 
 include/net/inetpeer.h                                                        |    4 
 include/net/libeth/xsk.h                                                      |    2 
 include/net/netns/ipv4.h                                                      |    2 
 include/net/pkt_sched.h                                                       |    1 
 include/net/sch_generic.h                                                     |    9 
 include/net/sock.h                                                            |   17 
 include/net/xdp_sock_drv.h                                                    |   22 
 include/net/xsk_buff_pool.h                                                   |    3 
 include/rdma/ib_verbs.h                                                       |   21 
 include/sound/core.h                                                          |    2 
 include/trace/events/erofs.h                                                  |    7 
 include/uapi/linux/devlink.h                                                  |    1 
 include/uapi/linux/if_xdp.h                                                   |    1 
 include/uapi/linux/nl80211.h                                                  |  140 
 include/uapi/linux/time_types.h                                               |    2 
 include/uapi/rdma/ib_user_ioctl_cmds.h                                        |    6 
 io_uring/futex.c                                                              |   16 
 io_uring/io_uring.c                                                           |   45 
 io_uring/io_uring.h                                                           |   17 
 io_uring/msg_ring.c                                                           |    3 
 io_uring/notif.c                                                              |    5 
 io_uring/poll.c                                                               |   13 
 io_uring/poll.h                                                               |    2 
 io_uring/rw.c                                                                 |    5 
 io_uring/rw.h                                                                 |    2 
 io_uring/timeout.c                                                            |   20 
 io_uring/uring_cmd.c                                                          |    5 
 io_uring/waitid.c                                                             |   81 
 kernel/bpf/arena.c                                                            |    2 
 kernel/bpf/bpf_lsm.c                                                          |    1 
 kernel/bpf/btf.c                                                              |   30 
 kernel/bpf/cgroup.c                                                           |   27 
 kernel/bpf/cpumask.c                                                          |    6 
 kernel/bpf/helpers.c                                                          |    9 
 kernel/bpf/mmap_unlock_work.h                                                 |   51 
 kernel/bpf/net_namespace.c                                                    |   17 
 kernel/bpf/queue_stack_maps.c                                                 |    8 
 kernel/bpf/ringbuf.c                                                          |    2 
 kernel/bpf/stackmap.c                                                         |  186 
 kernel/bpf/syscall.c                                                          |   23 
 kernel/bpf/task_iter.c                                                        |   48 
 kernel/bpf/verifier.c                                                         |   51 
 kernel/cgroup/cpuset-internal.h                                               |    2 
 kernel/cgroup/cpuset.c                                                        |  118 
 kernel/cpu_pm.c                                                               |   12 
 kernel/crash_dump_dm_crypt.c                                                  |   15 
 kernel/dma/swiotlb.c                                                          |   31 
 kernel/events/core.c                                                          |   90 
 kernel/events/internal.h                                                      |    1 
 kernel/events/ring_buffer.c                                                   |    2 
 kernel/futex/core.c                                                           |  103 
 kernel/futex/futex.h                                                          |   28 
 kernel/futex/pi.c                                                             |   37 
 kernel/futex/requeue.c                                                        |   20 
 kernel/futex/waitwake.c                                                       |   17 
 kernel/irq/generic-chip.c                                                     |   14 
 kernel/irq/pm.c                                                               |   11 
 kernel/kcsan/core.c                                                           |   12 
 kernel/locking/lockdep.c                                                      |    2 
 kernel/locking/rtmutex_api.c                                                  |    2 
 kernel/module/dups.c                                                          |   99 
 kernel/module/stats.c                                                         |    2 
 kernel/power/snapshot.c                                                       |    5 
 kernel/power/wakelock.c                                                       |    2 
 kernel/printk/printk.c                                                        |  176 
 kernel/rcu/tree_plugin.h                                                      |   10 
 kernel/sched/core.c                                                           |   16 
 kernel/sched/cpufreq_schedutil.c                                              |    2 
 kernel/sched/fair.c                                                           |   31 
 kernel/sys.c                                                                  |    2 
 kernel/time/Makefile                                                          |    2 
 kernel/time/clocksource.c                                                     |    8 
 kernel/time/namespace.c                                                       |  157 
 kernel/time/namespace_internal.h                                              |   13 
 kernel/time/namespace_vdso.c                                                  |  146 
 kernel/time/sched_clock.c                                                     |   22 
 kernel/time/timekeeping.c                                                     |   49 
 kernel/time/timer_migration.c                                                 |    4 
 kernel/trace/ftrace.c                                                         |   57 
 kernel/trace/ring_buffer.c                                                    |   67 
 kernel/trace/trace.c                                                          |  111 
 kernel/trace/trace.h                                                          |   12 
 kernel/trace/trace_btf.c                                                      |   31 
 kernel/trace/trace_btf.h                                                      |    3 
 kernel/trace/trace_events.c                                                   |    6 
 kernel/trace/trace_functions.c                                                |    2 
 kernel/trace/trace_probe.c                                                    |   18 
 kernel/trace/trace_stack.c                                                    |    2 
 lib/interval_tree_test.c                                                      |    4 
 lib/maple_tree.c                                                              |   43 
 lib/string.c                                                                  |    3 
 lib/test_hmm.c                                                                |    2 
 lib/vdso/datastore.c                                                          |   25 
 mm/damon/sysfs.c                                                              |    6 
 mm/huge_memory.c                                                              |    2 
 mm/khugepaged.c                                                               |    6 
 mm/madvise.c                                                                  |    8 
 mm/memory_hotplug.c                                                           |   13 
 mm/mm_init.c                                                                  |   19 
 mm/mremap.c                                                                   |   21 
 mm/secretmem.c                                                                |  117 
 net/batman-adv/bridge_loop_avoidance.c                                        |   63 
 net/batman-adv/distributed-arp-table.c                                        |   58 
 net/batman-adv/mesh-interface.c                                               |    7 
 net/batman-adv/types.h                                                        |    2 
 net/bluetooth/hci_conn.c                                                      |   20 
 net/bluetooth/hci_sync.c                                                      |   12 
 net/bluetooth/l2cap_sock.c                                                    |   36 
 net/bluetooth/mgmt.c                                                          |   40 
 net/bluetooth/msft.c                                                          |    5 
 net/bluetooth/rfcomm/core.c                                                   |    4 
 net/bridge/br_netlink_tunnel.c                                                |    3 
 net/bridge/br_vlan.c                                                          |    4 
 net/can/bcm.c                                                                 |    5 
 net/can/isotp.c                                                               |    3 
 net/can/j1939/socket.c                                                        |    3 
 net/can/raw.c                                                                 |    3 
 net/ceph/messenger_v2.c                                                       |    5 
 net/core/dev.c                                                                |   60 
 net/core/filter.c                                                             |    4 
 net/core/lwt_bpf.c                                                            |   15 
 net/core/net_namespace.c                                                      |   25 
 net/core/page_pool.c                                                          |   73 
 net/core/skbuff.c                                                             |    6 
 net/core/sock.c                                                               |   20 
 net/devlink/netlink_gen.c                                                     |    2 
 net/hsr/hsr_device.c                                                          |    2 
 net/ife/ife.c                                                                 |   14 
 net/ipv4/inetpeer.c                                                           |   38 
 net/ipv4/ipmr.c                                                               |  186 
 net/ipv4/ipmr_base.c                                                          |   16 
 net/ipv4/ping.c                                                               |    3 
 net/ipv4/raw.c                                                                |    3 
 net/ipv4/tcp.c                                                                |    6 
 net/ipv4/tcp_output.c                                                         |    2 
 net/ipv6/ip6mr.c                                                              |   22 
 net/ipv6/raw.c                                                                |    3 
 net/ipv6/route.c                                                              |    2 
 net/ipv6/xfrm6_input.c                                                        |    2 
 net/kcm/kcmsock.c                                                             |    3 
 net/mac80211/link.c                                                           |    3 
 net/mac80211/mlme.c                                                           |    2 
 net/mac80211/s1g.c                                                            |    2 
 net/mac80211/spectmgmt.c                                                      |   11 
 net/mac80211/tx.c                                                             |    3 
 net/netfilter/ipvs/ip_vs_ftp.c                                                |   10 
 net/netfilter/nf_nat_sip.c                                                    |    5 
 net/netfilter/nf_tables_api.c                                                 |   14 
 net/netfilter/xt_cgroup.c                                                     |   12 
 net/netfilter/xt_hl.c                                                         |   27 
 net/nfc/digital_core.c                                                        |    2 
 net/nfc/llcp_core.c                                                           |   29 
 net/nfc/llcp_sock.c                                                           |   14 
 net/nfc/nci/data.c                                                            |   10 
 net/nfc/nci/rsp.c                                                             |   41 
 net/phonet/pep.c                                                              |    2 
 net/rds/cong.c                                                                |    4 
 net/sched/act_api.c                                                           |    7 
 net/sched/act_bpf.c                                                           |   28 
 net/sched/act_ct.c                                                            |   46 
 net/sched/act_ctinfo.c                                                        |   11 
 net/sched/act_ife.c                                                           |   63 
 net/sched/act_mpls.c                                                          |    2 
 net/sched/act_pedit.c                                                         |   24 
 net/sched/act_police.c                                                        |   14 
 net/sched/act_sample.c                                                        |    9 
 net/sched/act_skbedit.c                                                       |    2 
 net/sched/act_skbmod.c                                                        |   12 
 net/sched/act_tunnel_key.c                                                    |   80 
 net/sched/cls_api.c                                                           |   18 
 net/sched/sch_api.c                                                           |    7 
 net/sched/sch_cake.c                                                          |    2 
 net/sched/sch_codel.c                                                         |    2 
 net/sched/sch_fifo.c                                                          |    2 
 net/sched/sch_fq.c                                                            |   26 
 net/sched/sch_fq_codel.c                                                      |    8 
 net/sched/sch_fq_pie.c                                                        |    3 
 net/sched/sch_gred.c                                                          |    6 
 net/sched/sch_hhf.c                                                           |    4 
 net/sched/sch_htb.c                                                           |    7 
 net/sched/sch_plug.c                                                          |    2 
 net/sched/sch_sfq.c                                                           |    3 
 net/sched/sch_teql.c                                                          |    1 
 net/smc/af_smc.c                                                              |    2 
 net/smc/smc_inet.c                                                            |   16 
 net/smc/smc_llc.c                                                             |    3 
 net/sunrpc/rpcb_clnt.c                                                        |    4 
 net/sunrpc/xprtsock.c                                                         |   20 
 net/tls/tls_strp.c                                                            |   16 
 net/vmw_vsock/af_vsock.c                                                      |   23 
 net/wireless/core.c                                                           |   57 
 net/wireless/core.h                                                           |    4 
 net/wireless/nl80211.c                                                        |  491 ++
 net/wireless/nl80211.h                                                        |    5 
 net/wireless/pmsr.c                                                           |    5 
 net/wireless/rdev-ops.h                                                       |   16 
 net/wireless/reg.c                                                            |    4 
 net/wireless/trace.h                                                          |   57 
 net/wireless/util.c                                                           |  101 
 net/xdp/xsk.c                                                                 |   44 
 net/xdp/xsk_buff_pool.c                                                       |    7 
 net/xdp/xsk_queue.h                                                           |   16 
 net/xfrm/xfrm_output.c                                                        |    4 
 rust/kernel/cpufreq.rs                                                        |   24 
 rust/uapi/uapi_helper.h                                                       |    2 
 samples/ftrace/ftrace-direct-modify.c                                         |   12 
 samples/ftrace/ftrace-direct-multi-modify.c                                   |   12 
 scripts/mod/modpost.c                                                         |    6 
 scripts/tags.sh                                                               |    2 
 security/apparmor/af_unix.c                                                   |    2 
 security/apparmor/apparmorfs.c                                                |    2 
 security/apparmor/domain.c                                                    |  201 
 security/apparmor/include/lib.h                                               |   31 
 security/apparmor/include/policy.h                                            |    3 
 security/apparmor/label.c                                                     |   26 
 security/apparmor/lib.c                                                       |   20 
 security/apparmor/mount.c                                                     |   17 
 security/apparmor/policy.c                                                    |   22 
 security/integrity/Makefile                                                   |    1 
 security/integrity/efi_secureboot.c                                           |   56 
 security/integrity/ima/ima_appraise.c                                         |    2 
 security/integrity/ima/ima_efi.c                                              |   47 
 security/integrity/ima/ima_main.c                                             |    3 
 security/integrity/integrity.h                                                |    1 
 security/integrity/platform_certs/load_uefi.c                                 |    2 
 security/smack/smack.h                                                        |    5 
 security/smack/smack_lsm.c                                                    |   67 
 security/smack/smackfs.c                                                      |  218 
 sound/core/control.c                                                          |    6 
 sound/core/control_led.c                                                      |   13 
 sound/core/init.c                                                             |    4 
 sound/core/seq/seq_clientmgr.c                                                |   16 
 sound/core/seq/seq_midi.c                                                     |   61 
 sound/drivers/mtpav.c                                                         |    4 
 sound/hda/common/proc.c                                                       |    2 
 sound/pci/asihpi/hpi6000.c                                                    |    5 
 sound/pci/ice1712/ice1712.c                                                   |    7 
 sound/pci/via82xx_modem.c                                                     |   26 
 sound/soc/apple/mca.c                                                         |    6 
 sound/soc/codecs/rt700-sdw.c                                                  |    6 
 sound/soc/codecs/tas2783-sdw.c                                                |   42 
 sound/soc/fsl/fsl-asoc-card.c                                                 |    4 
 sound/soc/fsl/fsl_audmix.c                                                    |   24 
 sound/soc/meson/meson-card-utils.c                                            |   17 
 sound/soc/pxa/pxa-ssp.c                                                       |    7 
 sound/soc/qcom/qdsp6/q6apm.c                                                  |   12 
 sound/soc/soc-dapm.c                                                          |    2 
 sound/soc/sof/topology.c                                                      |   18 
 sound/soc/xilinx/xlnx_formatter_pcm.c                                         |   14 
 sound/usb/fcp.c                                                               |   38 
 sound/usb/mixer_scarlett2.c                                                   |   21 
 sound/usb/quirks.c                                                            |   13 
 tools/bpf/bpftool/map.c                                                       |   16 
 tools/bpf/bpftool/sign.c                                                      |    7 
 tools/bpf/bpftool/struct_ops.c                                                |    4 
 tools/build/Makefile.feature                                                  |    2 
 tools/build/feature/Makefile                                                  |   14 
 tools/include/nolibc/arch-powerpc.h                                           |    2 
 tools/include/nolibc/arch-sparc.h                                             |    2 
 tools/include/uapi/linux/if_xdp.h                                             |    1 
 tools/lib/bpf/libbpf.c                                                        |    3 
 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2                  |    1 
 tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2                  |    1 
 tools/net/sunrpc/xdrgen/templates/C/enum/definition/close_be.j2               |    1 
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/string.j2                 |    2 
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_opaque.j2 |    2 
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/string.j2                  |    2 
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_opaque.j2  |    2 
 tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2                 |    5 
 tools/perf/builtin-ftrace.c                                                   |   13 
 tools/perf/builtin-record.c                                                   |   55 
 tools/perf/builtin-stat.c                                                     |    9 
 tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json                    |  160 
 tools/perf/pmu-events/arch/x86/amdzen5/load-store.json                        |    8 
 tools/perf/pmu-events/jevents.py                                              |    5 
 tools/perf/pmu-events/metric.py                                               |    6 
 tools/perf/tests/builtin-test.c                                               |  846 +++
 tools/perf/tests/shell/kvm.sh                                                 |  169 
 tools/perf/tests/shell/lib/perf_metric_validation.py                          |   11 
 tools/perf/tests/shell/lib/perf_record.sh                                     |   58 
 tools/perf/tests/shell/pipe_test.sh                                           |    4 
 tools/perf/tests/shell/record+zstd_comp_decomp_multi_record.sh                |   63 
 tools/perf/tests/shell/record.sh                                              |  173 
 tools/perf/tests/shell/record_lbr.sh                                          |   50 
 tools/perf/tests/shell/stat_all_metrics.sh                                    |  112 
 tools/perf/tests/shell/stat_bpf_counters.sh                                   |   44 
 tools/perf/tests/shell/stat_metrics_values.sh                                 |    7 
 tools/perf/tests/shell/test_brstack.sh                                        |  131 
 tools/perf/tests/shell/trace_record_replay.sh                                 |   38 
 tools/perf/tests/tests.h                                                      |    2 
 tools/perf/ui/browsers/hists.c                                                |    6 
 tools/perf/util/arm-spe.c                                                     |    4 
 tools/perf/util/auxtrace.c                                                    |   15 
 tools/perf/util/bpf-event.c                                                   |    3 
 tools/perf/util/bpf-filter.c                                                  |   22 
 tools/perf/util/cap.c                                                         |    4 
 tools/perf/util/cap.h                                                         |    3 
 tools/perf/util/capstone.c                                                    |   13 
 tools/perf/util/compress.h                                                    |    6 
 tools/perf/util/cs-etm.c                                                      |   85 
 tools/perf/util/data-convert-json.c                                           |    1 
 tools/perf/util/dso.c                                                         |   48 
 tools/perf/util/dso.h                                                         |   57 
 tools/perf/util/evsel.c                                                       |    2 
 tools/perf/util/hist.h                                                        |    8 
 tools/perf/util/intel-bts.c                                                   |    2 
 tools/perf/util/intel-pt.c                                                    |    2 
 tools/perf/util/libbfd.c                                                      |   23 
 tools/perf/util/machine.c                                                     |   43 
 tools/perf/util/metricgroup.c                                                 |    7 
 tools/perf/util/python.c                                                      |   66 
 tools/perf/util/symbol.c                                                      |    3 
 tools/perf/util/synthetic-events.c                                            |    6 
 tools/perf/util/thread-stack.c                                                |    2 
 tools/perf/util/trace-event-read.c                                            |   33 
 tools/perf/util/util.c                                                        |   12 
 tools/perf/util/zstd.c                                                        |   40 
 tools/sched_ext/include/scx/compat.bpf.h                                      |  110 
 tools/sched_ext/scx_flatcg.bpf.c                                              |   29 
 tools/sched_ext/scx_qmap.bpf.c                                                |   16 
 tools/scripts/Makefile.include                                                |   37 
 tools/testing/kunit/kunit.py                                                  |    2 
 tools/testing/kunit/kunit_tool_test.py                                        |   12 
 tools/testing/selftests/arm64/fp/fp-ptrace.c                                  |   47 
 tools/testing/selftests/arm64/fp/sve-test.S                                   |    7 
 tools/testing/selftests/arm64/mte/check_buffer_fill.c                         |    2 
 tools/testing/selftests/arm64/mte/check_child_memory.c                        |    2 
 tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c                     |    1 
 tools/testing/selftests/arm64/mte/check_hugetlb_options.c                     |    2 
 tools/testing/selftests/arm64/mte/check_ksm_options.c                         |   31 
 tools/testing/selftests/arm64/mte/check_mmap_options.c                        |    2 
 tools/testing/selftests/arm64/mte/check_prctl.c                               |    2 
 tools/testing/selftests/arm64/mte/check_tags_inclusion.c                      |    2 
 tools/testing/selftests/arm64/mte/check_user_mem.c                            |    2 
 tools/testing/selftests/bpf/README.rst                                        |    4 
 tools/testing/selftests/bpf/network_helpers.c                                 |   10 
 tools/testing/selftests/bpf/network_helpers.h                                 |    5 
 tools/testing/selftests/bpf/prog_tests/global_map_resize.c                    |    8 
 tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c                         |  152 
 tools/testing/selftests/bpf/prog_tests/mptcp.c                                |   13 
 tools/testing/selftests/bpf/prog_tests/sha256.c                               |    4 
 tools/testing/selftests/bpf/progs/bpf_tracing_net.h                           |    3 
 tools/testing/selftests/bpf/progs/mptcpify.c                                  |    2 
 tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c                         |  155 
 tools/testing/selftests/bpf/test_progs.c                                      |   11 
 tools/testing/selftests/bpf/test_sockmap.c                                    |    3 
 tools/testing/selftests/bpf/veristat.c                                        |   76 
 tools/testing/selftests/bpf/vmtest.sh                                         |   13 
 tools/testing/selftests/cgroup/test_cpuset_prs.sh                             |    5 
 tools/testing/selftests/kselftest_harness.h                                   |   14 
 tools/testing/selftests/lsm/common.c                                          |    4 
 tools/testing/selftests/mm/cow.c                                              |    9 
 tools/testing/selftests/mm/ksm_tests.c                                        |  206 
 tools/testing/selftests/mm/memfd_secret.c                                     |   30 
 tools/testing/selftests/proc/proc-maps-race.c                                 |    3 
 tools/testing/selftests/proc/proc-pidns.c                                     |    1 
 tools/testing/selftests/rseq/rseq-x86-thread-pointer.h                        |    4 
 tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c                   |   20 
 tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c                  |   13 
 tools/testing/selftests/sched_ext/exit.c                                      |    1 
 tools/testing/selftests/sched_ext/prog_run.c                                  |   34 
 tools/testing/selftests/timers/leap-a-day.c                                   |   19 
 tools/testing/selftests/vDSO/vgetrandom-chacha.S                              |    2 
 tools/testing/selftests/zram/zram_lib.sh                                      |    2 
 virt/kvm/kvm_main.c                                                           |   18 
 1514 files changed, 28955 insertions(+), 12574 deletions(-)

Aaradhana Sahu (4):
      wifi: ath12k: correct monitor destination ring size
      wifi: ath12k: switch to name-based reserved memory lookup
      wifi: ath12k: refactor QMI memory assignment
      wifi: ath12k: allocate HOST_DDR and BDF regions after Q6 RO region

Abd-Alrhman Masalkhi (3):
      md: recheck spare changes before starting sync
      md/raid10: consistently fail atomic writes that require splitting
      md: skip redundant raid_disks update when value is unchanged

Abdun Nihaal (3):
      platform/x86: int1092: Fix potential memory leak in sar_probe()
      wifi: rtlwifi: pci: fix error path in rtl_pci_probe()
      misc: vmc_vmci: Fix potential memory leak in vmci_event_subscribe()

Abel Vesa (2):
      clk: qcom: gcc-glymur: Enable runtime PM
      phy: qualcomm: qmp-combo: Add DP offsets and settings for Glymur platforms

Abhinaba Rakshit (1):
      arm64: dts: qcom: lemans: add QCrypto node

Ada Couprie Diaz (1):
      arm64: hibernate: mask DAIF before restoring hibernated kernel

Aditya Prakash Srivastava (1):
      ext4: use fsdata to track inline data write state and fix race

Adrian Hunter (7):
      i3c: master: Fix device_register() error path
      i3c: master: Fix recursive locking during device registration
      i3c: master: Do not treat master device as a duplicate target
      i3c: master: Fix use-after-free of master->this
      perf/x86/intel/pt: Factor out pt_config_enable()
      perf/x86/intel/pt: Use bitwise access for PERF_HES_STOPPED
      perf/x86/intel/pt: Fix stop/start with no update

Ahmet Sezgin Duran (1):
      staging: sm750fb: gate dualview dataflow using g_dualview

Ahsan Atta (1):
      crypto: qat - remove dead ADF_HEX code

Ai Chao (1):
      HID: i2c-hid: Fix "(null)" output when reading report descriptor fails

Akari Tsuyukusa (2):
      iommu/mediatek-v1: Fix off-by-one in MT2701_LARB_NR_MAX
      clk: mediatek: mt8135: Fix inverted gate control for devapc_ck

Akhil P Oommen (1):
      drm/msm/a6xx: Rebase GMU register offsets

Akhmed Zhitaev (1):
      drm/amd/display: Scale custom brightness curve from full range

Alban Bedel (1):
      software node: Fix software_node_get_reference_args() with index -1

Aleksandr Nogikh (3):
      udf: Mark LVID buffer as uptodate before marking it dirty
      ALSA: core: Fix use-after-free in snd_card_do_free()
      libceph: validate banner payload length

Alexander A. Klimov (2):
      clk: moxart: remove unused variables, fix refcount leak
      staging: greybus: audio: correct sscanf() return value check

Alexander Usyskin (1):
      mtd: intel-dg: wake card on operations

Alexey Charkov (2):
      clk: rockchip: Fix the fractional part denominator on RK3588/RK3576 PLLs
      clk: rockchip: rk3576: fix source muxes for SPI0..SPI4

Alexis Lothoré (eBPF Foundation) (1):
      selftests/bpf: Systematically add SO_REUSEADDR in start_server_addr

Ali Ahmet Memis (2):
      Bluetooth: MSFT: validate evt_prefix_len against the response length
      Bluetooth: btnxpuart: Validate the FW dump header length

Ali Tariq (2):
      PCI: starfive: Fix Runtime PM handling and teardown ordering
      PCI: starfive: Fix unchecked pm_runtime_get_sync() in probe

Alice Mikityanska (1):
      virtio-net: Ensure that TCP packets don't overflow gso_segs

Alison Schofield (2):
      cxl/port: Restart port enumeration when a sibling adds the dport first
      cxl/region: Fix use-after-free in find_pos_and_ways() error path

Alistair Francis (1):
      nvme: Add the DHCHAP maximum HD IDs

Allison Henderson (2):
      RDMA/rxe: Avoid reprocessing the current packet after the QP enters the error state
      net/rds: use wq_has_sleeper() in rds_cong_map_updated()

Amin Vakil (1):
      selftests: proc: include fcntl.h in proc-pidns

Andre Przywara (1):
      ARM: dts: allwinner: a10: Fix PMU interrupt

Andrea Scian (1):
      mtd: rawnand: pl353: Add message about ECC mode

Andreas Kemnade (1):
      drm/omap: dsi: Do not copy isr table

Andreas Schwab (1):
      m68k: nfcon: Do not call console_is_registered() in nfcon_device()

Andrew Jones (1):
      iommu/dma: Restore locking around msi_page_list

Andrew Murray (1):
      printk: Introduce console_flush_one_record

Andrey Golovko (1):
      ASoC: tas2783-sdw: drop stale regcache on uninitialized re-attach

Andrii Nakryiko (1):
      selftests/bpf: Use ping_command() for IPv6 pings in lwt_ip_encap

Andy Yan (1):
      drm/bridge: synopsys: dw-dp: Set pixel mode by platform data

Aneesh Kumar K.V (Arm) (2):
      iommu/dma: Check atomic pool allocation result directly
      swiotlb: Preserve allocation virtual address for dynamic pools

Anna Maniscalco (1):
      drm/msm: remove objects from evit list after pinning them

Anshumali Gaur (2):
      octeontx2-af: fix NULL deref in NIX TM tree debugfs read path
      octeontx2-vf: fix workqueue and netdev race in probe/remove

Armin Wolf (3):
      platform/x86: dell-privacy: Fix race condition
      platform/x86: dell-wmi-base: Fix resource leak on module load failure
      platform/x86: lg-laptop: Fix LED resource handling

Arnaldo Carvalho de Melo (23):
      perf zstd: Fix compression error path in zstd_compress_stream_to_records()
      perf machine: Fix fd leak on bounds check in maps__set_modules_path_dir()
      perf machine: Fix NULL parent dereference in fork event processing
      perf machine: Guard against NULL strlist in machines__findnew()
      perf machine: Check snprintf truncation in machines__findnew()
      perf machine: Don't abort guest map creation on first inaccessible dir
      perf machine: Reset errno before strtol in guest kernel map creation
      perf machine: Free scandir entries in guest kernel map creation
      perf machine: Check snprintf truncation for guest kallsyms path
      perf thread-stack: Fix heap buffer overflow on branch stack wrap copy
      perf auxtrace: Fix queue grow overflow and old array leak
      perf intel-pt: Fix off-by-one in auxtrace_info minimum size check
      perf intel-bts: Fix off-by-one in auxtrace_info minimum size check
      perf arm-spe: Reject zero nr_cpu in metadata to prevent division by zero
      perf libbfd: Validate BPF prog info arrays before pointer cast
      perf bpf: Add PROG_TAGS to required arrays in __bpf_event__print_bpf_prog_info()
      perf libbfd: Fix memory leaks and NULL fclose in BPF disassembly
      perf build: Remove leftover feature tests for removed cxx and clang support
      perf dso: Guard against errno==0 when dso__get_filename() returns NULL
      perf dso: Guard close() against invalid fd in dso__decompress_kmodule_path()
      perf dso: Use stored fd error instead of stale errno in file_read() and file_size()
      perf dso: Guard against cache underflow on short reads in dso_cache__memcpy()
      perf dso: Replace assert with runtime check in dso__read_symbol()

Arnaud Bonnet (2):
      nfs: replace atomic bitops sequence with clear_and_wake_up_bit helper
      nfs: refactor pNFS functions using clear_and_wake_up_bit

Arnd Bergmann (4):
      usb: ucsi: huawei_gaokun: move typec_altmode off stack
      phy: renesas: rcar-gen3-usb2: add regulator dependency
      Bluetooth: btmtk: hide unused btmtk_mt6639_devs[] array
      wifi: mt76: fix airoha_npu dependency tracking

Artem Bityutskiy (2):
      intel_idle: Initialize sysfs after cpuidle driver initialization
      intel_idle: Add cmdline option to adjust C-states table

Asad Kamal (2):
      drm/amdgpu/pm/powerplay: bounds-check voltage index in SMU7 lookup
      drm/amdgpu/pm/powerplay: bounds-check voltage index in Vega10 lookup

Atish Patra (1):
      crypto: ccp - Fix memory leak in SEV INIT_EX path

Avraham Stern (2):
      wifi: iwlwifi: mei: check SAP message length before reading it
      wifi: iwlwifi: mei: pass correct argument to function

Ayush Mukkanwar (4):
      staging: octeon: add missing tasklet_kill in cvm_oct_tx_shutdown
      staging: octeon: ethernet-mem: replace pr_warn with dev_warn in free functions
      staging: octeon: replace pr_warn with dev_warn in fill and rx paths
      staging: octeon: add missing napi_disable in cvm_oct_rx_shutdown

Babanpreet Singh (3):
      power: supply: sbs-battery: Use a per-device serial number buffer
      w1: ds2482: Fix signedness bug in ds2482_w1_triplet()
      spi: sprd-adi: Fix probe succeeding without registering the controller

Baineng Shou (2):
      dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds
      misc: fastrpc: don't publish fd before copy_to_user() succeeds

Balasubramani Vivekanandan (1):
      drm/xe/xe_gt_idle: Add CCS to the powergating info print

Baochen Qiang (1):
      wifi: ath11k: cap out-of-range rx MCS instead of leaving bogus rate

Baokun Li (3):
      ext4: drain in-flight DIO before buffered write fallback
      cuse: wait for pending RCU callbacks on module exit
      fuse: check for NULL root inode in fuse_fill_super_submount

Baolin Wang (1):
      mm: fix incorrect vm_flags usage when checking allowable orders for tmpfs

Bart Van Assche (1):
      scsi: ufs: core: Set task state before io_schedule_timeout()

Baul Lee (2):
      ALSA: FCP: do not copy out an uninitialised init response
      vxlan: mdb: Fix use-after-free in vxlan_mdb_flush()

Ben Cressey (1):
      dm-integrity: fix buffer overflow with keyed discard

Bijan Tabatabai (1):
      x86/pkeys: Fix pkey_alloc() return value when pkeys are not supported

Biju Das (3):
      usb: renesas_usbhs: Fix power-off ordering on unbind
      phy: renesas: phy-rcar-gen3-usb2: Fix devm action registration for disabled VBUS regulator
      irqchip/renesas-rzg2l: Fix loss of interrupt

Biren Pandya (1):
      media: i2c: rdacm21: Fix missing media_entity_cleanup()

Bjorn Andersson (3):
      usb: typec: ucsi: unregister debugfs entries on teardown
      remoteproc: Allow shutdown of crashed processors
      remoteproc: Prevent crash handling to race with rproc_del()

Bradley Morgan (2):
      lib/string: fix memchr_inv() for large ranges
      prctl: fix PR_SET_MM_AUXV losing the forced AT_NULL terminator

Breno Leitao (5):
      efi: fix stale reference to efi_recover_from_page_fault()
      cacheinfo: don't propagate DT/ACPI error when arch supplies info (arm64)
      phonet: pep: do not write beyond optlen in getsockopt
      nfc: llcp: avoid userspace overflow on invalid optlen
      nfc: llcp: read llcp_sock->local under the socket lock in getsockopt

Brian Masney (2):
      clk: imx: scu: drop redundant init.ops variable assignment
      clk: qcom: camcc-sc8280xp: unregister CAMCC_GDSC_CLK

Brian Norris (1):
      arm64: dts: qcom: Add #{address,size}-cells to Chromium-based /firmware

Bruce Johnston (1):
      md/raid1: don't set array_frozen in raid1_takeover()

Bryam Vargas (6):
      wifi: mt76: mt7996: bound the device EEPROM address before the EFUSE copy
      dm-pcache: reject a kset that overruns its segment
      dm-pcache: bound the logical key offset from persistent memory
      dm-pcache: validate the persisted dirty_tail chain at load
      greybus: audio: bound the topology section sizes against the fetched size
      libnvdimm/labels: Bound the on-media label size before the shift

Caleb Sander Mateos (5):
      nvme: fold nvme_config_discard() into nvme_update_disk_info()
      io_uring: only call io_should_terminate_tw() once for ctx
      io_uring: add wrapper type for io_req_tw_func_t arg
      ublk: check import_ubuf() return value
      ublk: check for ublk_unmap_io() returning 0

Calvin Owens (2):
      pps: don't try to wait for negative timeouts in PPS_FETCH
      pps-gpio: remove dead capture_clear code

Can Peng (6):
      phy: starfive: Fix runtime PM cleanup in JH7110 DPHY TX probe
      phy: starfive: Fix runtime PM cleanup in JH7110 DPHY RX probe
      drm/tve200: add OF module alias for autoloading
      crypto: keembay - publish OF module alias for OCS AES/SM4
      i3c: master: adi: add OF module alias for autoloading
      ACPI: processor: Unregister cpufreq notifier on init failure

Casey Schaufler (1):
      Smack: Fix error in capability bypass

Cen Zhang (3):
      wifi: mac80211_hwsim: avoid NULL skb in stop queue drain
      ocfs2/cluster: keep heartbeat local node stable
      ocfs2: synchronize heartbeat callbacks with o2net teardown

Cen Zhang (Microsoft) (3):
      xsk: fix NULL pointer dereference in __xsk_rcv()
      ipv6: avoid divide by zero in rt6_multipath_rebalance
      gtp: add synchronize_net() in gtp_newlink() error path to prevent use-after-free

Chad Monroe (1):
      wifi: mt76: mt7996: fix EAPOL source BSS for non-MLD stations

Chandrakanth Patil (1):
      scsi: mpt3sas: Avoid freeing unallocated PCIe SGL buffers

Chao Huang (1):
      HID: i2c-hid: goodix: Disable VDD on VDDIO enable failure

Chao Shi (2):
      nvme: skip the zoned limits update if the zone info query failed
      nvme: reject passthrough of driver-managed Set Features

Chao Yu (2):
      f2fs: cleanup w/ f2fs_need_rand_{blk, seg, seg_blk}
      f2fs: fix to avoid pinfile fragment on fragment:{block, segment} mode

Charles Keepax (2):
      soundwire: Add a helper function to wait for device initialisation
      ASoC: tas2783: Use new SoundWire enumeration helper

Chen Cheng (5):
      md/raid5: protect bitmap batch counters aka seq_flush/seq_write consistency
      md/raid5: protect lockless recovery_offset accesses during reshape
      md/bitmap: resume array on backlog_store() error path
      md: remove unused mddev argument from export_rdev
      md: scope memalloc_noio to allocation critical sections

Chen Pei (1):
      ACPI: PCI: Clear driver_data on all paths that free the acpi_pci_root

Chen, Yu C (1):
      sched/fair: Fix overflow in update_tg_cfs_runnable()

Cheng Xu (2):
      RDMA/erdma: Hold CQ references when processing EQ events
      RDMA/erdma: Hold QP references for AE and CM processing

Cheng-Han Wu (1):
      selftests/zram: fix kernel_gte() for POSIX sh

Chih-Kang Chang (2):
      wifi: rtw89: update format of addr cam H2C command
      wifi: rtw89: 8852a: fix RSSI report when average beacon RSSI is not ready

Chris Lu (2):
      Bluetooth: btmtksdio: Take exclusive ownership of the SKB before TX
      Bluetooth: btmtksdio: Fix out-of-bounds DMA read in the TX path

Christian Borntraeger (1):
      KVM: s390: Zero initialize data structures for inject_pfault_token

Christian Marangi (5):
      thermal/drivers/airoha: Fix copy paste error on clamp_t low temp
      thermal/drivers/airoha: Fix copy paste error for sen internal
      pinctrl: airoha: convert PHY LED GPIO to macro
      pinctrl: airoha: add support for Airoha AN7583 PINs
      pinctrl: airoha: convert PWM GPIO to macro

Christoph Hellwig (5):
      blk-crypto: submit the encrypted bio in blk_crypto_fallback_bio_prep
      blk-crypto: optimize bio splitting in blk_crypto_fallback_encrypt_bio
      blk-crypto: use on-stack skcipher requests for fallback en/decryption
      block: don't set BIO_QUIET for BLK_STS_AGAIN
      block: add a bio_endio_status helper

Christophe JAILLET (1):
      accessibility: speakup: Fix incorrect string length computation in report_char_chartab_status()

Christophe Leroy (CS GROUP) (3):
      powerpc: implement get_direction() in cpm2
      soc: fsl: qe: properly scan GPIO nodes at startup
      soc: fsl: qe: implement get_direction()

Christopher Lusk (1):
      smb: client: fix request buffer leak in smb2_new_read_req()

Christos Maragkos (1):
      HID: nintendo: Fix imu_timestamp_us double increment per report

Chuck Lever (3):
      xdrgen: Address some checkpatch whitespace complaints
      xdrgen: Do not declare union XDR functions in the definitions header
      xdrgen: Fix opaque and string encoders for unbounded members

Claudiu Beznea (2):
      i3c: renesas: Return immediately if there is no transfer
      i3c: renesas: Follow a unified pattern for transfer and command initialization

Coiby Xu (2):
      integrity: Make arch_ima_get_secureboot integrity-wide
      s390: Drop unnecessary CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT

Cong Nguyen (2):
      staging: rtl8723bs: fix xmit_frame/xmit_buf leaks on mgnt-frame error paths
      media: staging/ipu7: fix async notifier leak on init error

Cosmo Chou (3):
      leds: pca9532: Fix inverted GPIO output polarity
      leds: pca9532: Fix phantom device registration on missing hardware
      rtc: pcf85363: Add error checking to regmap calls in probe()

Cristian Ciocaltea (6):
      drm/bridge: synopsys: dw-dp: Support unregistering the AUX channel
      drm/rockchip: dw_dp: Simplify error handling
      drm/rockchip: dw_dp: Add missing newline in dev_err_probe() message
      drm/rockchip: dw_dp: Release core resources
      drm/rockchip: vop2: Fix wrong wait target in layer cfg done check
      drm/rockchip: vop2: Wait for layer cfg done before switching LAYERSEL_REGDONE_SEL

Cássio Gabriel (1):
      ALSA: core: Add scoped cleanup helper for card references

Damon Ding (4):
      drm/rockchip: analogix_dp: Enable hclk for RK3588
      drm/rockchip: analogix_dp: Fix OF node reference leak via auto cleanup
      arm64: dts: rockchip: Add missing hclk for RK3588 eDP0
      arm64: dts: rockchip: Add missing hclk for RK3588 eDP1

Dan Carpenter (6):
      staging: fbtft: Use sysfs_emit_at() to print to sysfs file
      thermal/drivers/rcar: Fix error checking in probe()
      regulator: adp5055: Fix error code in adp5055_of_parse_cb()
      cpufreq: spear: Fix an IS_ERR() vs NULL bug in spear1340_set_cpu_rate()
      drm/xe: tests: fix error message in xe_migrate_sanity_test()
      scsi: qla2xxx: Fix an loop timeout test

Daniel Baluta (1):
      soc: qcom: ubwc: Fix missing include

Daniel Borkmann (8):
      bpftool: Check EVP_Digest when computing excl_prog_hash
      bpf: Fix vmlinux BTF prep race in bpf_get_btf_vmlinux
      bpf: Fix security_bpf_map_create error handling
      bpf: Check load-acquire src ptr type before the load
      bpf: Reject load-acquire from pointers requiring fault protection
      bpf, riscv: Add and use bpf_atomic_is_load_acq() helper
      bpf, x86: Fix exception table metadata for arena load-acquire
      bpf, arm64: Fix exception table metadata for arena load-acquire

Daniel McCarthy (1):
      pinctrl: bcm2835: Don't remove an unregistered GPIO chip

Daniel Pawlik (1):
      net: airoha: npu: fix missing streaming DMA mask

Danila Chernetsov (2):
      RDMA/hfi1: Propagate sdma_txinit_ahg() errors
      fbdev: kyro: Validate overlay viewport coordinates

Dapeng Mi (1):
      perf/x86/intel: Remove anythread_deprecated bit from perf_capabilities

Dave Jiang (2):
      cxl/mbox: Break poison list loop on an empty payload
      cxl/pci: Honor -EPROBE_DEFER from component register setup

David Lee (2):
      UDF symlink pathComponent header OOB read
      nilfs2: prevent out-of-bounds read in super root block parsing

David Matlack (1):
      selftests: harness: Mark test fixture objects __maybe_unused

David Sterba (1):
      btrfs: merge setting ret and return ret

David Stevens (1):
      x86/entry/fred: Encode frame pointer on entry

David Strahan (1):
      scsi: smartpqi: Fix AIO retry marker cleared by SCSI core between dispatches.

David Woodhouse (1):
      timekeeping: Account for monotonicity adjustment in ntp_error

Davidlohr Bueso (1):
      perf/cxlpmu: Fix 64-bit write to 32-bit HDM filter register

Dawei Feng (1):
      staging: rtl8723bs: fix mismatched free of HalData in rtw_sdio_if1_init()

Dawid Wróbel (1):
      arm64: dts: qcom: sm8250-xiaomi-elish: correct the board ID

Deepanshu Kartikey (1):
      usb: atm: usbatm: fix invalid ci_range initialization

Denis V. Lunev (4):
      x86/mm/pat: Take cpa_lock around large-page collapse
      virtio: add virtio_device_shutdown() helper
      virtio_balloon: factor out virtballoon_quiesce()
      virtio_balloon: quiesce balloon work before device shutdown

Desnes Nunes (1):
      iommu/vt-d: Fix UCTP context table slot when copying root entries

Devin Wittmayer (2):
      wifi: mt76: mt76x02: do not WARN on invalid rx descriptor length
      wifi: mt76: restrict NPU/PPE active checks to MMIO devices

Dikshita Agarwal (1):
      media: qcom: iris: Fix bitmask test in iris_allow_cmd()

Dmitry Antipov (1):
      smack: simplify write handlers of sysfs entries

Dmitry Baryshkov (11):
      drm/bridge: display-connector: don't autoenable HPD IRQ
      drm/bridge: display-connector: trigger initial HPD event for DP
      Revert "drm/msm: dsi: fix PLL init in bonded mode"
      arm64: dts: qcom: sm8250: sort out Iris power domains
      arm64: dts: qcom: sm8250: correct frequencies in the Iris OPP table
      clk: qcom: gcc-qcm2290: don't park QUP RCGs upon registration
      arm64: dts: qcom: lemans: move USB PHYs to a proper place
      arm64: dts: qcom: lemans: add refgen regulator and use it for DSI
      drm/msm: don't tear down KMS twice when KMS init fails
      drm/msm/dp: reject YUV420-only modes without VSC SDP support
      drm/msm/dp: do not reject wide-bus modes while a YUV420 mode is active

Dmitry Gomzyakov (1):
      wifi: mt76: connac: add MT7991A (0x7991) to is_mt7996()

Dmitry Ilvokhin (2):
      perf record: Return the written size from process_comp_header()
      perf record: Fix multiple PERF_RECORD_COMPRESSED2 records per push

Dmitry Morgun (1):
      wifi: rtw89: check return values in rtw89_ops_start_ap()

Doruk Tan Ozturk (1):
      nfc: llcp: bound SNL TLV parsing to the skb and add length checks

Dragos Tatulea (2):
      net/mlx5e: xsk: Fix unlocked writing to ICOSQ
      net/mlx5e: SHAMPO, Always calculate page size

EDAMAMEX (1):
      cpufreq/amd-pstate: handle missing policy in dynamic EPP callbacks

Eason Lai (2):
      wifi: mt76: mt7921: Add PCIe AER handler support to prevent system crash
      wifi: mt76: mt792x: Fix memory leak in SDIO TX path

Eduard Zingerman (1):
      selftests/bpf: Fix for veristat file/prog filters processing

Emmanuel Grumbach (3):
      wifi: iwlwifi: fix counter type in iwl_fwrt_dump_error_logs
      wifi: iwlwifi: mvm: fix off-by-one in TXF key sanitiser
      wifi: iwlwifi: guard against division by zero in iwl_dbg_tlv_alloc_fragments

Enzo Matsumiya (1):
      smb: server: fix leak of ksmbd_ipc_login_request_ext() returned buffer

Eric Dumazet (8):
      netdevsim: update queue NAPI association on queue reset
      net: change sock_queue_rcv_skb_reason() to return a drop_reason
      ip6mr: plug drop_reason to ip6mr_cache_report()
      inetpeer: randomize RB-tree node comparison using SipHash
      net_sched: sch_fq: fix pacing delay underflow with pacing offload
      net/sched: add qstats_cpu_drop_inc() helper
      net/sched: act_skbmod: fix length calculations and avoid invalid header warnings
      slip: remove slip_hangup() to fix use-after-free in slip_receive_buf()

Esteban Urrutia (3):
      phy: qcom: qmp-pcie: Add pcs_lane1 offset to V5 offsets
      phy: qcom: qmp-combo: Correct pre-emphasis table for QMP v4 DP PHYs
      phy: qcom: qmp-combo: Drop qmp_v4_calibrate_dp_phy

Eugen Hristev (1):
      media: bcm2835-unicam: Fix asc leaked in error/remove path

Evgenii Burenchev (2):
      ALSA: via82xx: Remove unreachable branch in snd_via686_pcm_pointer()
      ALSA: hpi: Check transport errors during HPI6000 adapter initialization

Fabio Estevam (2):
      arm64: dts: rockchip: Fix Gru WLAN sideband interrupt
      arm64: dts: rockchip: Fix rk3566-bigtreetech-cb2 touchscreen property

Faisal Hassan (1):
      phy: qcom-qmp-combo: Use regulator_bulk_data with init_load_uA for regulator setup

Fan Gong (1):
      hinic3: Fix skb linearization mismatch and drop skb when skb_checksum_help() failed

Fan Wu (3):
      spi: oc-tiny: switch to managed controller allocation
      spi: davinci: switch to managed controller allocation
      RDMA/cxgb4: Free debugfs on registration failure

Fan Ye (1):
      net: thunderbolt: Count delivered packets in rx_packets and rx_bytes

Farhan Ali (2):
      PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value
      PCI: Allow per function PCI slots to fix slot reset on s390

Fei Shao (1):
      usb: mtu3: allow system suspend during active gadget connection

Felix Fietkau (32):
      wifi: mt76: mt7996: fix out-of-bounds array access during hardware restart
      wifi: mt76: mt7996: validate RX band_idx before dereferencing phys[]
      wifi: mt76: mt7996: set MT76_MCU_RESET before waking MCU waiters on full reset
      wifi: mt76: mt7915: clear wcid mask under mutex after RCU pointer clear
      wifi: mt76: mt7915: avoid nss underflow in mt7915_mcu_get_sta_nss
      wifi: mt76: mt7996: don't report a zero TX bitrate
      wifi: mt76: mt7915: write RX header translation bit to the correct register
      wifi: mt76: fix stranded frames in mt76_txq_schedule_pending
      wifi: mt76: fix uninitialised RXDMAD_C descriptor info
      wifi: mt76: fix RXDMAD_C buffer recycling race
      wifi: mt76: mt7915: poll the correct SLP CTRL register for the second adie
      wifi: mt76: mt7996: bound TLV walk in mt7996_mcu_get_chip_config
      wifi: mt76: mt7915: unwind state on add_interface failure
      wifi: mt76: mt7996: hold dev->mt76.mutex while disabling tx worker in SER
      wifi: mt76: mt7996: reserve space for the CSA-abort countdown TLV
      wifi: mt76: mt7996: don't leak MLD group index on remap alloc failure
      wifi: mt76: mt7915: use little-endian for bss_info_ra wire fields
      wifi: mt76: only consume the WO drop bit on WED v2 devices
      wifi: mt76: mt7915: unlink TWT flow if the MCU rejects the agreement
      wifi: mt76: mt7996: skip key upload when adding an offchannel link
      wifi: mt76: mt7996: wake MCU waiters before aborting scan in L1 SER
      wifi: mt76: mt7996: free vif links after clearing wcid entries on full reset
      wifi: mt76: mt7996: fix MIB TX aggregation counter registers for mt7990
      wifi: mt76: mt7915: fix double hif2 init on the non-WED path
      wifi: mt76: mt7915: fix ext PHY use-after-free on register error path
      wifi: mt76: mt7915: release hif2 reference on probe IRQ failure
      wifi: mt76: mt7996: do not attach hif2 WED when the main WED attach failed
      wifi: mt76: mt7915: fix chainmask handling for non-dbdc phys on band 1
      wifi: mt76: mt7915: report RX chain signal for all RX paths
      wifi: mt76: reject out-of-range link ids in mt76_vif_link()
      wifi: mt76: mt7996: fix out-of-bounds link array access in mt7996_tx()
      wifi: mac80211: skip default WMM setup for AP_VLAN links

Felix Gu (3):
      remoteproc: qcom_q6v5_adsp: Fix reference leak for device node
      phy: sunplus: fix error handling in sp_uphy_init()
      spi: img-spfi: don't disable runtime PM on DMA deferred probe

Feng Jiang (1):
      bpf, riscv: Fix extable handling for arena load_acquire

Feng Yang (3):
      selftests/bpf: Fix memory leak in msg_alloc_iov
      selftests/bpf: Fix incorrect error checking for pthread_create
      selftests/bpf: Fix memory leak on subtest_states reallocation

Filipe Manana (1):
      btrfs: defrag: fix deadlock between defrag and delalloc space reservation

Florian Westphal (1):
      netfilter: nf_nat_sip: rewind offset when NAT shrinks the packet

Frank Li (1):
      arm64: dts: imx8-ss-audio: Fix LPCG clock indices for ASRC0

Frank Sorenson (2):
      cifs: remove dead size-update blocks in cifs_setattr_unix/nounix
      cifs: fix clearing stats for fastest execution of each smb2 command

Frieder Schrempf (1):
      arm64: dts: imx93-kontron: set memory node to 0x80000000/1GiB

Fu Hao (1):
      iommu/amd: Add support for Hygon family 18h model 4h IOAPIC

Fushuai Wang (2):
      serial: 8250: Clear CON_PRINTBUFFER on port re-registration
      Revert "serial: 8250: Clear CON_PRINTBUFFER on port re-registration"

Gabriele Monaco (1):
      cgroup/cpuset: Rename update_unbound_workqueue_cpumask() to update_isolation_cpumasks()

Gao Xiang (5):
      erofs: clean up encoded map flags
      erofs: error out obviously illegal extents in advance
      erofs: fix interlaced ztailpacking pclusters
      erofs: guard on-disk algorithm IDs against Z_EROFS_COMPRESSION_MAX
      erofs: relax sanity check for tail pclusters due to ztailpacking

Gary Guo (1):
      usb: fix UAF when probe runs concurrent to dyn ID removal

Gautham R. Shenoy (1):
      amd-pstate: Make certain freq_attrs conditionally visible

Geert Uytterhoeven (5):
      soc: renesas: r8a78000: Drop duplicate "default ARCH_RENESAS"
      clk: ti: Make sure clk_init_data is fully initialized
      clk: visconti: Make sure clk_init_data is fully initialized
      spi: amlogic-spisg: Make sure clk_init_data is fully initialized
      erofs: Fix EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS default logic

Geoffrey McRae (1):
      drm/amd/display: Fix DM I2C teardown race

George Moussalem (2):
      arm64: dts: qcom: ipq5018: Correct CMN PLL reference clock rate
      arm64: qcom: ipq5018: Add GEPHY RX and TX clocks

Gerald Loacker (1):
      phy: rockchip: phy-rockchip-inno-csidphy: fix rk1808 hsfreq table

Gerald Yang (1):
      ext4: clear stale xarray tags on folios skipped during writeback

Giovanni Cabiddu (2):
      crypto: qat - cancel work on re-enable SR-IOV timeout
      crypto: qat - clear AES key schedule from stack

Gleb Markov (2):
      drm/amd/display: Remove unused-but-set variable hubp from
      misc: rtsx: add missing write register handling

Glenn Judd (1):
      net/mlx5e: do not HW-GRO coalesce small frames

Golla Nagendra (1):
      dmaengine: zynqmp_dma: fix race between runtime PM and device removal

Gou Hao (1):
      powerpc/smp: add NULL guard for cause_ipi in smp_muxed_ipi_message_pass

Greg Kroah-Hartman (2):
      Bluetooth: btmtk: Fix short read errors in btmtk_usb_reg_read()
      Linux 6.18.52

Gregory Price (2):
      mm: name the anonymous MMOP enum as enum mmop
      mm/mm_init: handle alloc_percpu failure in free_area_init_core_hotplug

Guanghui Yang (1):
      ext4: fix buffer_head leak in ext4_init_orphan_info

Guangshuo Li (11):
      i2c: qcom-cci: fix autosuspend cleanup
      serial: qcom-geni: do not advance stale DMA completions
      crash_dump: release keyring reference at the correct time
      mtd: intel-dg: Fix runtime PM error path in probe
      clk: tegra: tegra124-emc: put EMC node on register failure
      rapidio: clear mport->net when rio_add_net() fails
      Bluetooth: btmtksdio: fix usage_count leak when autosuspend_delay is negative
      dmaengine: qcom-bam-dma: fix autosuspend cleanup during removal
      clocksource/drivers/clps711x: Do not unmap clocksource MMIO
      ksmbd: Do not skip lock checks for single-byte ranges
      platform/x86: hp-bioscfg: fix password encoding bounds check

Guenter Roeck (3):
      hwmon: Support guard() and scoped_guard for subsystem locks
      hwmon: (emc1403) Rely on subsystem locking
      bnxt_en: Fix call to hardware monitoring event handler

Gui-Dong Han (4):
      media: cec-pin: Fix event FIFO ordering
      nvme-apple: Use acquire/release for queue enabled state
      gpib: Move stuck SRQ update under lock
      misc: bcm-vk: Use acquire/release for msgq_inited

Guillaume Maudoux (1):
      selftests/bpf: Mask socket type flags in mptcpify prog

Guixin Liu (5):
      nvme-fc: unmap cmd_iu DMA on rsp_iu mapping failure in init_request
      nvmet: propagate percpu_ref_init() failure in nvmet_ns_enable()
      nvme-pci: release descriptor pools on probe failure
      nvmet: fix heap out-of-bounds read in nvmet_auth_negotiate()
      nvmet: fix NULL pointer dereference in nvmet_execute_identify_ns_zns()

GuoHan Zhao (1):
      virtio: rtc: time out alarm requests

Guodong Xu (1):
      riscv: cpufeature: Clarify ISA spec version for canonical order

Guoniu Zhou (1):
      media: dt-bindings: nxp,imx8-isi: Drop fsl,blk-ctrl requirement for i.MX8ULP

Guopeng Zhang (1):
      cgroup/cpuset: Use WRITE_ONCE() for shared prs_err updates

Guzebing (1):
      cxl/memdev: Fix firmware upload exact-fit handling

Hang Nan (1):
      ksmbd: bound smb_check_perm_dacl() ACE walks by DACL size

Hanlin Song (1):
      csky: Fix a4/a5 restoration in syscall trace path

Hans Verkuil (1):
      media: v4l2-async: Unregister sub-device if asc_list is empty

Haotian Zhang (3):
      ALSA: ice1712: Fix the card leak at probe error with the auto-cleanup
      samples/ftrace: Fix kthread_stop() on ERR_PTR in ftrace-direct-modify
      samples/ftrace: Fix kthread_stop() on ERR_PTR in ftrace-direct-multi-modify

Haowen Tu (1):
      PM: sleep: Fix off-by-one in wakelocks number limit check

Haoxiang Li (1):
      iommu/qcom: Remove sysfs device on probe failure path

Hari Chandrakanthan (1):
      wifi: cfg80211: add support to handle incumbent signal detected event from mac80211/driver

Hemanth Selam (1):
      platform/x86/amd/hsmp: Reject negative power cap writes in hwmon

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

Hongling Zeng (2):
      perf: evsel: Fix error handling in tp_format lookup
      ceph: Fix ERR_PTR(0) in ceph_mkdir()

Hongyan Xu (7):
      usb: gadget: r8a66597: avoid double free of ep0_req in probe error path
      platform/chrome: cros_ec_debugfs: Clean up console log on probe failure
      platform/chrome: cros_ec_debugfs: Unregister panic notifier
      power: supply: isp1704_charger: cancel work on remove
      power: supply: sc2731_charger: cancel work on remove
      ACPI: scan: fix bus ID cleanup on device_add() failures
      block: mtip32xx: synchronize ioctls with device removal

Hui Su (2):
      io_uring/waitid: honor task_work cancellation
      io_uring/waitid: avoid siginfo copy during ring teardown

Huisong Li (5):
      ACPI: processor: idle: Optimize ACPI idle driver registration
      mailbox: pcc: Fix command timeout due to missed interrupt
      ACPI: processor: idle: Remove redundant cstate check in acpi_processor_power_init
      ACPI: processor: idle: Move max_cstate update out of the loop
      ACPI: processor: idle: Remove redundant static variable and rename cstate check function

Hungyu Lin (1):
      media: qcom: iris: handle runtime PM resume failure in core deinit

HyeongJun An (4):
      Bluetooth: virtio_bt: avoid OOB read of build info string
      ALSA: seq: Don't leak the extension cell pointer in the bounce payload
      platform/x86: dell-wmi-sysman: Fix instance ID bounds
      ASoC: dapm: Fix off-by-one check on the second enum channel

Hyunwoo Kim (1):
      Bluetooth: RFCOMM: Validate MTU in rfcomm_apply_pn() to prevent infinite loop

Ian Rogers (30):
      perf test: Drain pipe after child finishes to avoid losing output
      perf test: Refactor parallel poll loop to drain all pipes simultaneously
      perf test: Show snippet failure output for verbose=1
      perf test: Add summary reporting
      perf test: Fix subtest status alignment for multi-digit indexes
      perf test: Add -j/--junit option for JUnit XML test reports
      perf test: Truncate printed test descriptions dynamically to avoid terminal wrapping
      perf test: Truncate test description to fit terminal width
      perf test metrics: Update all metrics for possibly failing default metrics
      perf test all metrics: Fully ignore Default metric failures
      perf tests: Skip metrics validation if system-wide recording lacks permission
      perf test kvm: Add some basic perf kvm test coverage
      perf tests: Add robust record retry helper and use subsecond workloads
      perf tests: Fix flakiness in trace record and replay test
      perf tests: Fix flakiness in BPF counters test on hybrid systems
      perf test: Fixes for check branch stack sampling
      perf tests: Fix flakiness in branch stack sampling tests
      perf jevents: Add more components to the metric sorting order
      perf ui hists: Fix uninitialized stack memory free on pstack allocation failure
      perf cap: Remove used_root parameter and simplify capability checks
      perf stat: Fix evsel_list leak in cmd_stat
      perf synthetic-events: Fix uninitialized pthread_join
      perf test: Support dynamic test suites with setup callback and private data
      perf test: Fix skiplist leak in cmd_test
      perf python: Check counts_values size in set_values
      perf python: Handle Py_None for thread and cpu maps
      perf python: Validate CPU and thread maps in pyrf_evsel__open
      perf python: Fix memory leak in pyrf__metrics_cb
      perf synthetic-events: Fix divide by zero in perf_event__synthesize_threads
      perf tests kvm: Avoid leaving perf.data.guest file around

Ibrahim Hashimov (1):
      RDMA/rxe: Validate num_sge/cur_sge before indexing wqe->dma.sge[]

Ihor Solodrai (2):
      bpf: Factor out stack_map build ID helpers
      bpf: Avoid faultable build ID reads under mm locks

Ilya Leoshkevich (1):
      s390/irqflags: Add out-of-line definitions of arch_local_irq_*() for KMSAN

Imran Shaik (3):
      clk: qcom: Fix test_ctl_hi field for DEFAULT_EVO PLLs
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

Ivy Lopez (1):
      staging: rtl8723bs: use kfree_sensitive() for key material

Jacob Moroni (4):
      RDMA/irdma: Deduplicate the irdma_del_memlist logic
      RDMA/irdma: Add a refcount to track user ring MR associations
      RDMA/irdma: Add irdma_cq fields to track pbl allocations
      RDMA/irdma: Add refcounting to user ring MRs

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

James Clark (4):
      tools/build: Allow versioning of all LLVM tools defined in Makefile.include
      coresight: Change syncfreq to be a u8
      coresight: Refactor etm4_config_timestamp_event()
      perf: arm_pmuv3: Zero initialize hw_id branch stack field

Jan Kara (3):
      udf: Move udf_map_block() up
      udf: Fix data loss when converting inline inodes to out of line
      ext4: fix spurious message about orphan cleanup on RO fs

Jared.Huang (2):
      wifi: mt76: mt7925: update clc before setting sar power table
      wifi: mt76: mt7925: fix msg len mismatch between driver and firmware

Jason Gunthorpe (2):
      iommufd: Simplify iommufd_device_remove_vdev()
      RDMA/nldev: Fix locking when accessing mr->pd

Javier Tia (2):
      wifi: mt76: mt7925: advertise EHT 320MHz capabilities for 6GHz band
      Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support

Jeff Johnson (10):
      wifi: ath6kl: avoid buffer overreads in WMI event handlers
      wifi: ath12k: Correctly copy the hint BSSID in WMI scan request
      wifi: ath11k: Correctly copy the hint BSSID in WMI scan request
      wifi: ath12k: Avoid buffer overread in ath12k_wmi_op_rx()
      wifi: ath11k: Avoid buffer overread in ath11k_wmi_tlv_op_rx()
      wifi: ath11k: fix overreads in ath11k_wmi_process_csa_switch_count_event()
      wifi: ath12k: validate TLV length in process_tpc_stats()
      wifi: ath12k: fix stride mismatch in mac_phy_caps_parse()
      wifi: ath11k: fix stride mismatch in mac_phy_caps_parse()
      wifi: ath11k: fix leak in ath11k_service_ready_ext_event()

Jeffin Philip (1):
      usb: gadget: f_mass_storage: fix null pointer dereference in fsg_common_set_num_buffers()

Jens Axboe (4):
      io_uring: unify task_work cancelation checks
      io_uring/waitid: have io_waitid_complete() remove wait queue entry
      io_uring/waitid: use io_waitid_remove_wq() consistently
      io_uring/waitid: fix KCSAN warning on io_waitid->head

Jens Glathe (2):
      arm64: dts: qcom: sc8280xp-blackrock: switch to uefi rtc offset
      drm/msm/dp: add missing drm_edid_connector_update() before add_modes on cached EDID

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

Jesse Brandeburg (1):
      ice: refactor to use helpers

Jeuk Kim (1):
      NFSv4/flexfiles: fix NULL dereference for NFSv4.0 data servers

Jia Yang (2):
      mailbox: qcom-cpucp: fix PREEMPT_RT self-deadlock in IRQ handler
      mailbox: qcom-cpucp: handle NULL data in send_data callback

Jiancheng Huang (1):
      HID: lg4ff: validate report length before fixed offsets

Jiangshan Yi (1):
      selftests: timers: leap-a-day: Fix -w option and update usage comment

Jiawen Wu (8):
      net: txgbe: support RX desc merge mode
      net: txgbe: support RSC offload
      net: wangxun: replace busy-wait reset flag with kernel mutex
      net: wangxun: schedule hardware stats update in watchdog
      net: wangxun: introduce WX_STATE_DOWN to serialize device shutdown state
      net: txgbe: fix MISC interrupt unmasking in non-MSI-X mode and device shutdown
      net: libwx: fix concurrent bitmap overwrite in PTP setup
      net: wangxun: use BIT_ULL() to prevent shift overflow on 32-bit archs

Jiayuan Chen (2):
      bpf, xdp: move offload check into dev_xdp_install()
      tcp: fix corruption of urgent data on multi-segment retransmit

Jie Zhang (4):
      drm/msm: Recover HW before retire hung submit
      drm/msm/a6xx: Fix A663 GPUCC register list for state capture
      drm/msm/a6xx: Fix A621 GPUCC register list for state capture
      drm/msm: Fix task_struct reference leak in recover_worker

Jijie Shao (1):
      net: page_pool: fix UAF in __page_pool_release_netmem_dma on xa_cmpxchg race

Jingyi Wang (1):
      remoteproc: core: Attach rproc asynchronously in rproc_add() path via schedule_work()

Jinjie Ruan (2):
      riscv: kexec_file: Fix crashk_low_res not exclude bug
      powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()

Joas Antonio dos Santos (1):
      ipvs: fix integer overflow in ftp helper port/address parsing

Joey Lu (3):
      clk: nuvoton: ma35d1: fix ignored div_u64 return values in PLL freq calculation
      clk: nuvoton: ma35d1: fix PLL_CTL1_FRAC bit field width and fractional calc
      clk: nuvoton: ma35d1: fix ma35d1_clk_pll_determine_rate logic

Johan Hovold (1):
      Bluetooth: btusb: refactor endpoint lookup

Johannes Berg (5):
      wifi: mac80211: disconnect on CSA to channel 0
      wifi: ieee80211: add some initial UHR definitions
      wifi: cfg80211: add initial UHR support
      wifi: nl80211: split out UHR operation information
      wifi: nl80211: fix UHR capability validation

Johannes Thumshirn (1):
      btrfs: zoned: don't clobber the extent buffer when zeroing it out

John Groves (1):
      dax: read holder_ops once in dax_holder_notify_failure()

John Johansen (6):
      apparmor: split xxx_in_ns into its two separate semantic use cases
      apparmor: change fn_label_build() call to not return NULL
      apparmor: fix unconfined user namespace restriction forced stack
      apparmor: fix deadlock in complain-mode change_hat
      apparmor: policy_int make sure list heads are initialized before fail path
      apparmor: fix kernel-doc comments for inview

John Keeping (1):
      ALSA: seq: midi: Serialize input teardown with event_input

John Ogness (6):
      printk: Fix possible console use-after-free
      serial: core: Add dedicated uart_port field for console flow
      serial: Replace driver usage of UPF_CONS_FLOW
      serial: 8250: Set cons_flow on port registration
      serial: 8250: Add support for console flow control
      serial: 8250: Ignore flow control on suspend/resume with no_console_suspend

Jorijn van der Graaf (1):
      ASoC: qcom: q6apm: keep the graph start count in sync with the DSP

Jose Ignacio Tornos Martinez (1):
      wifi: mt76: mt7996: remove beacon_int_min_gcd from ADHOC interface combinations

Josh Poimboeuf (1):
      arm64: bti: Disable in-kernel BTI with recent versions of Clang

Joshua Crofts (1):
      nilfs2: fix infinite loop in nilfs_clean_segments()

Joy Zou (1):
      regulator: core: use system_freezable_wq for init complete work

Juan Martinez (1):
      cpufreq/amd-pstate: Add comment explaining nominal_perf usage for performance policy

Jun Yan (2):
      arm64: dts: amlogic: meson-axg: Add missing nand_rb0 pin to nand_all_pins
      arm64: dts: amlogic: meson-axg-s400: enable mipi_pcie_analog_dphy for PCIe

Junhui Liu (1):
      riscv: dts: spacemit: k1: Split gmac_clk_ref into independent pinctrl groups

Junrui Luo (2):
      NFSv4.2: fix LAYOUTSTATS send buffer exhaustion
      NFSv4/pnfs: key the data server cache on the NFS version

Junseo Lim (4):
      lwt_bpf: Restore reserved headroom after xmit program
      bpf: Disallow bpf_{g,s}etsockopt() in cgroup UNIX getname hooks
      bpf: Reject negative optlen in cgroup getsockopt hook
      net: kcm: Hold RCU read lock while running BPF parser

Justin Yeh (1):
      pinctrl: mediatek: free EINT resources on unbind

Jérémy Jean (1):
      crypto: acomp - allocate async request context when cloning

Jérôme de Bretagne (1):
      arm64: dts: qcom: sc8280xp-arcata: Fix top USB-C DP alt mode

K Prateek Nayak (6):
      cpufreq/amd-pstate: Set min_limit_freq based on bios_min_perf
      cpufreq/amd-pstate: Reorder notifier unregistration and floor perf reset
      cpufreq/amd-pstate: Return -ENOMEM on failure to allocate profile_name
      cpufreq/amd-pstate: Grab "amd_pstate_driver_lock" when toggling dynamic_epp
      cpufreq/amd-pstate: Use "epp_default_dc" as default when dynamic_epp is disabled
      cpufreq/amd-pstate: Allow writes to dynamic_epp when state isn't modified

Kalesh AP (1):
      RDMA/restrack: Fix typos in the comments

Kamal Wadhwa (1):
      regulator: qcom-rpmh: Fix PMIC5 BOB bypass mode handling

Karl Mehltretter (18):
      tty: hvc: restrict HVC_DCC to ARMv6+ and ARM64
      ARM: lpc32xx: only run SoC init on LPC32xx hardware
      arm64/fpsimd: ptrace: Fix inactive SVE and SSVE regsets
      kselftest/arm64: fp-ptrace: Fix checks for inactive SVE and SSVE regsets
      serial: amba-pl011: unprepare console clock on unregister
      serial: amba-pl011: keep console clock enabled for atomic writes
      tty: clear cdev pointer after cdev_add() failure
      cpufreq: imx6q: fix devres accumulation across driver rebind
      cpufreq: imx6q: fix out-of-bounds write when probed more than once
      fbdev: clps711x-fb: Remove unreachable unregister_framebuffer() call
      m68k: Fix backtraces for non-running tasks
      super: fix dying superblock warning messages
      HID: haptic: don't write an uninitialized value to unhandled usages
      crypto: lskcipher - propagate errors from unaligned crypt
      octeontx2-af: initialize lmac_bmap in rvu_mcs_set_lmac_bmap()
      8139cp: fix Rx and Tx not being disabled in cp_suspend
      lib/interval_tree: fix allocation warning messages
      selftests/proc: make proc-maps-race work with READ_IMPLIES_EXEC

Keith Busch (6):
      block: fix dio leak on metadata mapping error
      block: accumulate memory segment gaps per bio
      nvme: remove virtual boundary for sgl capable devices
      block: save page offset gaps in cloned bio
      blk-mq-dma: always initialize dma state
      block: fix merging data-less bios

Kemeng Shi (3):
      irqchip/gic-v3-its: Fix memleak in its_probe_one()
      irqchip/gic-v3-its: Fix its node leak in gic_acpi_parse_madt_its()
      irqchip/gic-v3-its: Prevent leak in its_vpe_irq_domain_alloc()

Khushal Chitturi (1):
      staging: rtl8723bs: fix operator and type cast spacing

Kohei Enju (2):
      virt: arm-cca-guest: use migrate_disable() for attestation token requests
      arm64: RSI: fix field-spanning write warning in attestation token init

Koichiro Den (4):
      dmaengine: dw-edma: Terminate all descriptors without callbacks
      dmaengine: dw-edma: Serialize abort state updates
      dmaengine: dw-edma: Serialize channel state checks
      dmaengine: dw-edma: Clear stale requests on termination

Konrad Dybcio (13):
      arm64: dts: qcom: hamoa: Fix clocks for HSPHYs
      arm64: dts: qcom: sc8180x-primus: Rename regulator nodes
      arm64: dts: qcom: sc8180x-primus: Describe the display power net
      arm64: dts: qcom: sc8180x-lenovo-flex-5g: Rename regulator nodes
      arm64: dts: qcom: sc8180x-lenovo-flex-5g: Describe the display power net
      arm64: dts: qcom: msm8996-xiaomi-gemini: Fix up ti,drv2604 enable GPIO
      arm64: dts: qcom: msm8998: Don't pull-up I2C pins by default in sleep
      arm64: dts: qcom: msm8976-longcheer-l9360: Fix accidental node override
      arm64: dts: qcom: sdm632-motorola-ocean: Fix LED default trigger property
      arm64: dts: qcom: sc8280xp-crd: Fix the pin index for misc_3p3_reg_en
      drm/msm/dpu: Drop sneaky dev_pm_opp_set_rate(0)
      drm/msm/dp: Drop dev_pm_opp_set_rate(0)
      drm/msm/dsi: Drop dev_pm_opp_set_rate(0)

Konstantin Andreev (3):
      smack: fix incorrect task context in smack_msg_queue_msgrcv
      smack: deduplicate smackfs/{direct,mapped} file_operations
      smack: restrict smackfs/{direct,mapped} values to 0-255

Konstantin Komarov (1):
      fs/ntfs3: fix out-of-bounds read in read_log_rec_buf()

Krishna Chaitanya Chundru (2):
      PCI/ASPM: Use pcie_capability_clear_and_set_word() for ASPM disable/restore
      PCI/ASPM: Disable/restore ASPM on every function for multi-function devices

Krishna Chomal (1):
      platform/x86: hp-wmi: Add support for OMEN MAX 16-ak0xxx (8DD6)

Krishna Kurapati (1):
      arm64: dts: qcom: qcs404: Fix DTBS Check errors in usb controller nodes

Krystian Kaniewski (1):
      ocfs2: fix circular locking dependency in ocfs2_init_acl()

Krzysztof Kozlowski (1):
      bus: qcom-ebi2: Simplify with scoped for each OF child loop

Kuan-Chung Chen (2):
      wifi: rtw89: mlo: rearrange MLSR link decision flow
      wifi: rtw89: phy: support per PHY RX statistics

Kuldeep Singh (1):
      arm64: dts: qcom: sm8750: wire UFS to ice instance

Kumar Kartikeya Dwivedi (4):
      bpf: Zero queue and stack outputs on lock failure
      bpf: Fix offset warn check for bpf_res_spin_lock
      bpf: Preserve unique-field state across nested structs
      bpf: Mark bpf_refcount field as unique

Kuniyuki Iwashima (8):
      amt: Don't support cross-netns setup.
      ipmr: Move unregister_netdevice_many() out of mroute_clean_tables().
      ipmr: Move unregister_netdevice_many() out of ipmr_free_table().
      ipmr: Convert ipmr_net_exit_batch() to ->exit_rtnl().
      ipmr: Remove RTNL in ipmr_rules_init() and ipmr_net_init().
      ipmr: Free mr_table after RCU grace period.
      ipmr: Call ipmr_fib_lookup() under RCU.
      ipmr: Add __rcu to netns_ipv4.mrt.

Kyle Zeng (1):
      hfsplus: validate thread record before delete key rebuild

Lachlan Hodges (1):
      wifi: cfg80211: include S1G_NO_PRIMARY flag when sending channel

Lad Prabhakar (1):
      phy: renesas: rcar-gen3-usb2: Ignore missing VBUS regulator

Laurence Rowe (1):
      vsock: avoid timeout for non-blocking accept() with empty backlog

Laxman Acharya Padhya (2):
      drm/panel: samsung-s6d16d0: Power off on prepare failure
      firmware: coreboot: Validate table bounds

Leo Martins (1):
      btrfs: avoid GFP_ATOMIC allocations in qgroup free paths

Leo Yan (4):
      perf cs-etm: Fix thread leaks on trace queue init failure
      perf cs-etm: Flush thread stacks after decoder reset
      perf cs-etm: Avoid truncating AUX buffer sizes to int
      perf: arm_spe: Make wakeup range check overflow safe

Leon Hwang (2):
      bpf: Copy per-CPU map value padding in copy_map_value_long()
      selftests/bpf: Add tests to verify the fix of encapsulating VxLAN in lwt

Leon Romanovsky (16):
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
      RDMA/mana_ib: drain QP references after partial table insertion
      RDMA/erdma: complete object teardown when the destroy command fails
      RDMA/mlx5: Fix stack out-of-bounds read in cc_params debugfs
      RDMA/mlx5: Send cong param changes to the resolved port mdev
      RDMA/cxgb4: free STAG index when TPT entry write fails
      RDMA/erdma: restrict the driver to little-endian systems

Li Chen (6):
      nvdimm: preserve flush callback -ENOMEM
      nvdimm: pmem: keep PREFLUSH before data writes
      nvdimm: virtio_pmem: stop allocating child flush bio
      nvdimm: virtio_pmem: always wake -ENOSPC waiters
      nvdimm: virtio_pmem: use READ_ONCE()/WRITE_ONCE() for wait flags
      nvdimm: virtio_pmem: refcount requests for token lifetime

Li Qiang (1):
      scsi: ufs: debugfs: Reserve space for a string terminator

Li RongQing (3):
      iommu/amd: Fix undefined behavior in devid_write debugfs function
      virtio_pci: fix wrong queue index for admin vq in intx path
      vdpa/mlx5: fix wrong list iterated in add_direct_chain error path

Liam R. Howlett (Oracle) (2):
      maple_tree: catch race in mas_alloc_cyclic()
      maple_tree: fix argument name in header

Liang Luo (3):
      selftests/sched_ext: Fix bpf_link leak on early return in prog_run
      tools/sched_ext: scx_qmap: Fix stale API name in comment
      selftests/sched_ext: Check skeleton open failure in exit test

LiangCheng Wang (1):
      ASoC: fsl-asoc-card: defer probe when the CPU DAI device is not ready

Linfeng Sun  (1):
      vdpa_sim: fix cleanup after worker creation failure

Linghui Wu (1):
      wifi: ath10k: snoc: use memcpy_fromio() for MSA ramdump

Linkai Gong (2):
      soc: fsl: qe: check platform_driver_register() in qe_ic_of_init()
      rtc: gamecube: check return value of devm_rtc_register_device()

Linmao Li (11):
      platform/mellanox: mlxbf-pmc: Check ACPI_COMPANION() against NULL
      platform/surface: acpi-notify: Check ACPI companion before use
      ppdev: prevent overflow when setting port timeout
      ASoC: meson: Keep link pointers valid on realloc failure
      crypto: keembay - Initialize completion before requesting IRQ
      Bluetooth: hci_conn: fix the SCO setup context lifetime
      Bluetooth: hci_sync: free the advertising instance on the failure and cancel paths
      Bluetooth: MGMT: free the mesh send cancel command when it is cancelled
      Bluetooth: MGMT: free the HCI command when it is cancelled
      nfc: digital: Do not dump a NULL response in command completion
      mailbox: rockchip: disable pclk on probe failure and unbind

Linus Walleij (1):
      ARM: 9481/2: breakpoint: CFI breakpoints only on demand

Loic Poulain (5):
      clk: qcom: gcc-qcs8300: Use retention for PCIe power domains
      clk: qcom: gcc-qcs8300: Use retention for USB power domains
      phy: qcom: qmp-usb-legacy: Fix possible NULL-deref on early runtime suspend
      phy: qcom: snps-femto-v2: Fix possible NULL-deref on early runtime suspend
      phy: qcom: qmp-usb: Fix possible NULL-deref on early runtime suspend

Lorenzo Bianconi (4):
      wifi: mt76: Move Q_READ/Q_WRITE definitions in dma.h
      wifi: mt76: Introduce the NPU generic layer
      wifi: mt76: always enable RRO queues for non-MT7992 chipset
      wifi: mt76: npu: Add missing rx_token_size initialization

Lorenzo Pieralisi (6):
      ACPI: RISC-V: Fix riscv_acpi_irq_get_dep() loop termination
      ACPI: RISC-V: Check acpi_get_handle() status in riscv_acpi_add_prt_dep()
      ACPI: RISC-V: Fix riscv_acpi_add_prt_dep() loop handling
      irqchip/gic-v5: Check for NULL LPI domain on domain teardown
      irqchip/gic-v5: Fix gicv5_init_common() error paths
      irqchip/gic-v5: Use logical cpu 0 irs_data for dynamic IST allocation

Lorenzo Stoakes (ARM) (2):
      mm/mremap: reset unfaulted VMA page offset for MREMAP_DONTUNMAP
      mm/secretmem: properly account locked pages

Lothar Rubusch (1):
      crypto: atmel-sha204a - fix heap info leak on I2C transfer failure

Louis-Alexis Eyraud (1):
      clk: mediatek: pllfh: Fix IO remapping leak in register_pllfhs error path

Lu Baolu (3):
      iommu/vt-d: Clear Present bit before tearing down copied context entry
      iommu/vt-d: Tear down scalable-mode context on probe failure
      iommu/vt-d: Flush context cache with correct SID when tearing down aliases

Luca Weiss (1):
      arm64: dts: qcom: sm7225-fairphone-fp4: Fix address in fb node name

Maciej Fijalkowski (1):
      xsk: avoid double checking against rx queue being full

Mahanta Jambigi (3):
      net/smc: hash socket only after full initialisation in smc_sk_init()
      net/smc: free stashed qentry before overwrite in REQ_ADD_LINK to ADD_LINK transition
      net/smc: free pending qentry in smc_llc_flow_stop() before memset

Maher Sanalla (1):
      RDMA/mlx5: Fix integer overflow of user QP buffer size

Malaya Kumar Rout (4):
      selftests/bpf: Fix memory leak in msg_alloc_iov error path
      timers/migration: Fix memory leak in tmigr_setup_groups() error path
      time/namespace: Validate nanosecond field in proc_timens_set_offset()
      PM: hibernate: Fix memory leak in snapshot_write_next() error path

Manish Rangankar (1):
      scsi: qla2xxx: Remove redundant VPD flash read in sysfs read path

Manivannan Sadhasivam (19):
      bus: mhi: host: Flush the posted write after writing to MHI_SOC_RESET_REQ_OFFSET
      arm64: dts: qcom: kodiak: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sar2130p: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sc8180x: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sdm845: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8150: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8250: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8350: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8450: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8550: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8650: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8750: Fix the PCIe iommu-map entries
      arm64: dts: qcom: talos: Fix the PCIe iommu-map entries
      arm64: dts: qcom: lemans: Fix the PCIe iommu-map entries
      arm64: dts: qcom: qcs6490-rb3gen2: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sc8280xp-blackrock: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: qcs8550-aim300: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sm7225-fairphone-fp4: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sar2130p: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies

Manos Pitsidianakis (1):
      hwrng: core - fix rng list on registration error

Manuel Fombuena (7):
      leds: st1202: Stop pattern sequence before reprogramming
      leds: st1202: Fix pattern duration prescaler and pattern_clear skip marker
      leds: st1202: Fix spurious pattern sequence start in setup
      leds: st1202: Set all pattern PWM slots to full after clearing pattern
      leds: st1202: Fix brightness having no effect while pattern mode is active
      leds: st1202: Disable channel when brightness is set to zero
      leds: st1202: Validate LED reg property against channel count

Maoyi Xie (3):
      platform/chrome: cros_ec_typec: Reject out-of-bounds PD cap count
      usb: ljca: bound bank_num in ljca_enumerate_gpio()
      drm/bridge: tc358767: clamp the reported AUX read size to the request

Marc Zyngier (2):
      KVM: arm64: Handle VNCR TLB invalidation race with vcpu_put() VNCR unmapping
      KVM: arm64: Remove VM-wide VNCR mapping counter

Marco Crivellari (1):
      module: replace use of system_wq with system_dfl_wq

Marco Elver (3):
      compiler_types: Move lock checking attributes to compiler-context-analysis.h
      kcsan: avoid unintended access checking in NMIs
      arm64: Disable KCSAN instrumentation in delay.o

Marco Scardovi (2):
      cpufreq/amd-pstate: Fix EPP return type and handle errors during initialization
      cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory systems

Marek Czernohous (1):
      forcedeth: stop the tx_timeout register dump past the requested window

Marino Dzalto (1):
      netfilter: xt_HL: add pr_fmt and checkentry validation

Mario Limonciello (3):
      drm/amd/display: Fix backlight max_brightness to match exported range
      platform/x86/amd/pmc: Fix msg_port restoration in amd_stb_debugfs_open_v2()
      cpufreq/amd-pstate: Add POWER_SUPPLY select for dynamic EPP

Mario Limonciello (AMD) (7):
      cpufreq/amd-pstate: Use sysfs_match_string() for epp
      cpufreq/amd-pstate: Add dynamic energy performance preference
      cpufreq/amd-pstate: Add support for platform profile class
      cpufreq/amd-pstate: Fix setting EPP in performance mode
      cpufreq/amd-pstate: Fix some whitespace issues
      cpufreq/amd-pstate: Add static asserts for EPP indices
      cpufreq/amd-pstate: Add support for raw EPP writes

Marius Cristea (1):
      hwmon: (emc1403) Drop hysteresis for low limit temperature

Mark Bloch (1):
      net/mlx5: E-Switch, use state lock for vport state changes

Mark Brown (1):
      kselftest/arm64: Don't write to P0 in irritator on SME only systems

Markus Stockhausen (5):
      irqchip/irq-realtek-rtl: Add/simplify register helpers
      irqchip/irq-realtek-rtl: Add multicore support
      irqchip/irq-realtek-rtl: Split out parent setup code
      irqchip/irq-realtek-rtl: Add interrupt data structure
      irqchip/irq-realtek-rtl: Add mask for interrupt handling

Martin Kaiser (1):
      tracing/probes: ignore id update from btf_type_skip_modifiers

Martin Wilck (1):
      md/raid1: create serial pool adding rdev to array with serialize_policy=1

Masami Hiramatsu (Google) (2):
      tracing/probes: Fix BTF kflag check for anonymous struct member access
      tracing/probes: Fix anon_stack check for unnamed bitfields in btf_find_struct_member

Mathieu Dubois-Briand (1):
      clk: ti: mux: resolve parent clocks by DT index, not by name

Matti Vaittinen (1):
      power: supply: bd99954: Drop bad register fields

Maurizio Lombardi (1):
      nvme: expose active quirks in sysfs

Maxime Chevallier (6):
      net: stmmac: selftests: Pass the IP proto mask in the TC selftest
      net: stmmac: selftests: Check multiple MMC counters
      net: stmmac: dwmac1000: Account for the primary MAC address for UC filtering
      net: stmmac: dwmac4: Account for the primary MAC address for UC filtering
      net: stmmac: dwxgmac: Account for the primary MAC address for UC filtering
      net: stmmac: selftests: Account for the UC filter list for filtering tests

Maxime Ripard (2):
      drm/bridge: cdns-dsi: Return an error pointer on allocation failure
      drm/bridge: cdns-mhdp8546: Return an error pointer on allocation failure

Maximilian Immanuel Brandtner (1):
      tls: fix RX desync on overlapping skbs

Maíra Canal (1):
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

Michael Kelley (1):
      Drivers: hv: vmbus: Skip VMBus module cleanup for non-nested root partition

Michael Nemanov (1):
      nfs: fix ENXIO on O_CREAT open of existing symlink over NFSv3

Michael Opdenacker (1):
      riscv: dts: spacemit: Add OrangePi R2S board device tree

Michael S. Tsirkin (1):
      virtio_balloon: disable indirect descriptors

Michael Walle (1):
      powerpc/configs: enable CONFIG_RAS to fix EDAC support

Michael-CY Lee (2):
      wifi: mt76: fix non-AQL packet accounting for MLO stations
      wifi: mt76: assign link_id when sending probe request during scan

Michal Blaszczyk (1):
      selftests/sched_ext: Fix flaky ddsp failure tests on busy systems

Mike Rapoport (Microsoft) (1):
      selftests/mm: ksm_tests: use kselftest framework

Mikhail Kshevetskiy (20):
      pinctrl: airoha: fix mdio bitfield names
      pinctrl: airoha: an7581: fix pinconf of i2c_scl/i2c_sda pins
      pinctrl: airoha: an7583: fix I2C0_SDA_PD register bit order
      pinctrl: airoha: fix pwm pin function for an7581 and an7583
      pinctrl: airoha: an7581: fix mux/conf of pcie_reset pins
      pinctrl: airoha: an7583: fix muxing of non-gpio default pins
      pinctrl: airoha: an7583: fix spi group pins
      pinctrl: airoha: add missed get_direction() function for gpio_chip
      pinctrl: airoha: fix getting gpiochip/pinctrl pointers in the IRQ handling code
      pinctrl: airoha: add missed IRQ resource helpers
      pinctrl: airoha: fix IRQ mask/unmask code
      pinctrl: airoha: fix edge-triggered interrupts handling
      pinctrl: airoha: an7583: remove undefined groups from pcm_spi pin function
      pinctrl: airoha: an7583: fix phy1_led1 pin function
      pinctrl: airoha: an7583: fix gpio21 pin group
      pinctrl: airoha: an7583: fix incorrect led mapping in phy4_led1 pin function
      pinctrl: airoha: an7583: fix misprint in gpio19 pinconf
      pinctrl: airoha: an7583: add missed gpio32 pin group
      pinctrl: airoha: an7581: fix incorrect led mapping in phy4_led1 pin function
      pinctrl: airoha: an7583: add missed gpio22 pin group

Mikko Perttunen (2):
      gpu: host1x: Fix offset calculation in trace_write_gather
      gpu: host1x: Avoid stack over-read in debug output helpers

Min zhang (1):
      clk: hisilicon: reset: Use devm_kzalloc to initialize hisi_reset_controller

Mina Almasry (2):
      net: tcp: block mixing readable and unreadable frags
      net: core: check skb_frags_readable before uncloning in skb_copy_ubufs

Minu Jin (1):
      staging: rtl8723bs: replace rtw_zmalloc() with kzalloc()

Miquel Raynal (DAVE) (2):
      mtd: rawnand: pl353: Make sure we use the monolithic helpers for raw accesses
      mtd: rawnand: pl353: Fix debug prints

Miri Korenblit (2):
      wifi: nl80211: refactor nl80211_parse_chandef
      wifi: cfg80211: Add an API to configure local NAN schedule

Mohammad Abu-Khader (1):
      kunit: tool: fix _list_tests filtering wrong variable when list has TAP prefix

Mohammed Rizwan Kaniyate (1):
      staging: rtl8723bs: remove multiple blank lines in core/

Mohd Ayaan Anwar (1):
      phy: qcom: sgmii-eth: vote for both voltage rails with correct current loads

Moksh Panicker (1):
      iio: light: apds9306: fix PM reference leak in apds9306_read_data()

Muhammad Bilal (2):
      staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()
      staging: sm750fb: fix mono image source stride mismatch in lynxfb_ops_imageblit()

Muhammad Usama Anjum (5):
      misc: sgi-gru: remove interrupt-context page-table walks
      selftests/mm: skip COW tmpfile cases when fallocate() is unsupported
      selftests/arm64: Print missing MTE TAP headers
      selftests/arm64: Treat KSM merge_across_nodes as optional
      selftests/arm64: Fix MTE prctl TAP plan

Mukesh Kumar Chaurasiya (IBM) (1):
      rust: uapi: replace direct asm-generic/ioctl.h include with linux/ioctl.h

Mukesh Ojha (9):
      iommu/qcom: Fix inverted fault report check in qcom_iommu_fault()
      firmware: qcom_scm: Introduce PAS context allocator helper function
      firmware: qcom: scm: Fix NULL dereference in IRQ handler before __scm is published
      firmware: qcom: scm: Fix reserved memory cleanup on probe failure
      firmware: qcom: scm: Fix tzmem state on probe retry
      remoteproc: Move resource table data structure to its own header
      remoteproc: use rsc_table_for_each_entry() in rproc_handle_resources()
      remoteproc: fix OOB read via signed offset in rsc_table_for_each_entry()
      firmware_loader: do not queue completed sysfs fallback requests

Myeonghun Pak (7):
      clk: versaclock7: Fix APLL clock leak on probe failure
      crypto: keembay - Fix AEAD unregister count in error path
      char: xilinx_hwicap: unregister class on init errors
      RDMA/erdma: Fix CEQ tasklet use-after-free on removal
      clk: mediatek: mt6735: Unregister PLLs on probe failure
      clk: palmas: Manage external-control prepare with devm
      fbdev: tdfxfb: fix PCI enable cleanup with pcim_enable_device()

Mykyta Yatsenko (1):
      bpf: Fix CFI mismatch in task work callback

Namhyung Kim (3):
      perf test: Do not skip when some metrics tests succeeded
      perf test: Fix perf stat --bpf-counters on hybrid machines
      perf annotate: Fix build with NO_SLANG=1

Namjae Jeon (4):
      ksmbd: do not advertise unimplemented CA support
      ksmbd: free preauth sessions on connection teardown
      ksmbd: disconnect on SMB3 decryption failure
      smb: server: remove unused DES crypto header

Nathan Chancellor (2):
      pinctrl: airoha: Fix AIROHA_PINCTRL_CONFS_DRIVE_E2 in an7583_pinctrl_match_data
      integrity: Eliminate weak definition of arch_get_secureboot()

Navaneeth K (1):
      staging: rtl8723bs: use standard offsetof in cfg80211 operations

Naveen Kumar Chaudhary (2):
      locking/lockdep: Fix NULL pointer dereference in __lock_set_class()
      module: use strscpy() to copy module names in stats and dup tracking

Naveen Mamindlapalli (1):
      octeontx2-af: Fix TL3/TL2 link config ENA clearing

Nayana Mariyappa (1):
      staging: rtl8723bs: expand multiple assignment into separate statements

Nguyen Dinh Phi (2):
      vsock: don't check the listener's sk_err in vsock_accept()
      vsock: use sock_error() to consume sk_err after a failed connect

Nicholas Dudar (1):
      bpf: Require a BPF cpumask for bpf_cpumask_populate()

Nicolas Frattaroli (5):
      drm/rockchip: vop2: Add RK3576 to the RG swap special case
      drm/rockchip: vop2: Recognise 10-bit YUV422 as YUV format
      clk: mediatek: Refactor pll registration to pass device
      clk: mediatek: Pass device to clk_hw_register for PLLs
      clk: mediatek: Refactor pllfh registration to pass device

Nicolin Chen (7):
      iommu/arm-smmu-v3: Declare eats_s1chk and eats_trans as host-endian u64
      iommu/tegra241-cmdqv: Publish an LVCMDQ only after it is fully initialized
      iommu/tegra241-cmdqv: Synchronize the error ISR against VINTF (de)init
      iommu/tegra241-cmdqv: Don't run the error ISR before probe sets up vintfs
      iommu/tegra241-cmdqv: Free the error IRQ before tearing down VINTFs
      iommu/tegra241-cmdqv: Require exactly one Stream ID for a vSID
      iommu/tegra241-cmdqv: Fix VINTF0 leak on the init-failure path

Nikhil Gautam (2):
      iio: light: gp2ap002: Fix unbalanced runtime PM on repeated event writes
      iio: light: gp2ap002: re-enable irq if runtime suspend fails

Niklas Cassel (2):
      misc: pci_endpoint_test: Check SUCCESS bit for doorbell status
      null_blk: serialize configfs attribute updates with device setup

Nikolay Aleksandrov (1):
      net: bridge: vlan: fix inverted default vlan notification

Nikolay Kulikov (1):
      mlxbf-bootctl: fix the build error with FIELD_PREP()

Nuno Sá (1):
      usb: gadget: f_fs: Fix fence cleanup in ffs_dmabuf_transfer() error paths

Odelu Kukatla (1):
      arm64: dts: qcom: sa8775p: Add reg and clocks for QoS configuration

Ojaswin Mujoo (1):
      erofs: fix unused pcluster_pools for higher page sizes

Oliver Upton (1):
      KVM: arm64: nv: Fully update VNCR fixmap state in kvm_translate_vncr()

Ondrej Jirman (1):
      arm64: dts: allwinner: sun50i-a64-pinephone: Fix mpu6050 mount matrix

Onur Özkan (1):
      clk: devres: fix cleanup in devm_clk_get_optional_enabled_with_rate()

Or Har-Toov (10):
      net/mlx5: Add max_tx_speed and its CAP bit to IFC
      net/mlx5: Propagate LAG effective max_tx_speed to vports
      net/mlx5: Handle port and vport speed change events in MPESW
      net/mlx5: Add support for querying bond speed
      IB/core: Add helper to convert port attributes to data rate
      IB/core: Add query_port_speed verb
      RDMA/mlx5: Implement query_port_speed callback
      net/mlx5: Skip disabled vports when setting max TX speed
      net/mlx5: Move vport DOWN state check out of mlx5_query_vport_max_tx_speed()
      net/mlx5: E-Switch, preserve max tx speed on vport state modification

Osama Abdelkader (1):
      drm/panthor: return PTR_ERR() from devm_drm_dev_alloc()

Pablo Neira Ayuso (2):
      netfilter: nf_tables: move hardware offload step after building the chain blob
      netfilter: x_tables: replace pr_{info,err}() by pr_info_ratelimited()

Pascal Kneuper (1):
      net: stmmac: restore NET_IP_ALIGN in the RX DMA offset

Patrisious Haddad (8):
      RDMA/core: Add rdma_restrack_begin/abort/commit_del() operations
      RDMA/core: Fix use after free in ib_query_qp()
      RDMA/core: Fix potential use after free in ib_destroy_cq_user()
      RDMA/core: Fix potential use after free in ib_destroy_srq_user()
      RDMA/core: Fix potential use after free in counter_release()
      RDMA/core: Fix potential use after free in ib_free_cq()
      RDMA/core: Fix potential use after free in uverbs_free_dmah()
      RDMA/core: Fix potential use after free in ib_dealloc_pd_user()

Paul Kocialkowski (1):
      drm: lcdif: Wait for vblank before disabling DMA

Pauli Virtanen (2):
      Bluetooth: L2CAP: reject accept queue add unless BT_LISTEN
      Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen() vs. put_chan

Pavel Begunkov (1):
      tcp: reject non zerocopy devmem tx

Pavel Shpakovskiy (1):
      Bluetooth: mgmt: fix 'hdev->discovery.uuids' NULL dereference

Pavel Zhigulin (1):
      speakup: keyhelp: guard letter_offsets possible out-of-range indexing

Pawan Gupta (1):
      x86/bugs: Don't use cpu-type matching in cpu_vuln_blacklist

Pawel Laszczak (1):
      usb: cdnsp: fix wakeup from S3 after controller context loss

Pei Xiao (1):
      ipack: ipoctal: fix UAF, null-ptr-deref, and use-after-free in cleanup on remove

Peiyang He (1):
      RDMA/rxe: Fix UAF in ODP init error-handling path

Peng Fan (1):
      remoteproc: core: Drop redundant initialization of 'ret' in rproc_shutdown()

Pengpeng Hou (20):
      wifi: rtw89: fix HE extended capability length check
      crypto: sa2ul - stop probe if context pool creation fails
      hwrng: xilinx-trng - propagate timeout before any data is read
      crypto: rk3288 - fail ahash requests on HASH idle timeout
      usb: typec: ucsi: gaokun: unwind notifier on UCSI register failure
      soc: qcom: rpmh-rsc: manage PM notifiers with devres
      bus: qcom-ebi2: use managed resources for clocks and children
      pmdomain: bcm: bcm2835: handle genpd provider registration errors
      misc: ad525x_dpot: use driver core groups for sysfs files
      misc: lan966x_pci: depopulate children on populate failure
      RDMA/nldev: validate dynamic counter attribute length
      ACPI: processor: validate MADT IOAPIC entry bounds
      thermal: intel: int3400: clean up ODVP on probe failures
      ASoC: codecs: tas2783-sdw: Propagate regcache_sync() errors
      mfd: rave-sp: validate received frame payload lengths
      mfd: iqs62x: Reject zero-length firmware records
      ASoC: SOF: validate topology volume range before allocation
      mailbox: riscv-sbi-mpxy: validate RPMI notification lengths
      rtc: zynqmp: Return optional clock lookup errors
      net: qlcnic: validate unified ROM sections before loading

Pengyu Luo (2):
      usb: ucsi: huawei_gaokun: support mode switching
      arm64: dts: qcom: sc8280xp-x13s: Fix the drive-strength of mclk pin

Peter Chiu (2):
      wifi: mt76: mt7996: fix MLD ID in MAC TXD and HIF TXP
      wifi: mt76: fix queue assignment for disassoc packets

Peter Oberparleiter (1):
      s390/debug: Fix deadlock during unregister

Peter Zijlstra (2):
      perf/core: Fix deadlock in perf_mmap() failure path
      futex: Optimize futex hash bucket access patterns

Petr Oros (1):
      ice: clear the default forwarding VSI rule when releasing a VSI

Petr Pavlu (2):
      module/dups: Inform duplicate requests about the result directly
      module/dups: Fix use-after-free in kmod_dup_req lifetime handling

Petr Tesarik (1):
      x86/tsx: Make tsx_ctrl_state static

Philipp Weber (1):
      HID: core: quiesce input in hid_hw_stop() to prevent use-after-free

Phillip Lougher (1):
      Squashfs: check block offset is not negative

Ping-Ke Shih (4):
      wifi: rtw89: fill addr cam H2C command by struct
      wifi: rtw89: pci: add to read PCI configuration space from common code
      wifi: rtw89: fw: parse firmware element of DIAG_MAC
      wifi: rtw89: debug: add parser to diagnose along DIAG_MAC fw element

Prabu Thayalan (1):
      ionic: fix completion descriptor access with 2x desc size

Pranjal Shrivastava (1):
      iommu/arm-smmu-v3: Convert to use atomic poll timeout

Praveen Talari (2):
      spi: qcom-geni: Fix missing error check on pm_runtime_get_sync()
      spi: geni-qcom: Fix sticky ret causing wrong return value on invalid proto

Priya Bala Govindasamy (2):
      rust: cpufreq: Add CPUFREQ_TABLE_END as last table entry in TableBuilder::to_table
      rust: cpufreq: Fix temporary write in Registration::bios_limit_callback

Przemyslaw Korba (1):
      ice: fall back to SBQ when LL PHY timer interface times out

Pu Lehui (7):
      riscv, bpf: Fix memory leak in bpf_jit_free
      riscv, bpf: Fix kernel stack corruption in tailcall with CFI
      bpf: Fix potential UAF in bpf_netns_link_update_prog
      bpf: Fix potential UAF when reading bpf link info
      bpf, cgroup: Fix invalid storage access after __cgroup_bpf_attach failed
      bpf, cgroup: Fix storage null-ptr-deref after replacing prog
      riscv, bpf: Fix missing sign-ext for signed 1-byte and 2-byte kfunc args

Puranam V G Tejaswi (1):
      drm/msm/a6xx: Fix RBBM_CLOCK_CNTL3_TP0 value in a730_hwcg

Puranjay Mohan (1):
      bpf, arm64: Fix stack-passed arguments for indirect trampolines

Qianheng Peng (1):
      cpufreq: amd-pstate-ut: Skip tests when amd-pstate driver is not active

Qingfang Deng (1):
      pppox: drain queued packets on channel handoff

Qingshuang Fu (1):
      irqchip/renesas-irqc: Fix generic interrupt chip leak on remove

Qu Wenruo (4):
      btrfs: make btrfs_repair_io_failure() handle bs > ps cases without large folios
      btrfs: always wait for ordered extents to avoid OE races
      btrfs: use aligned range for locking in extent_fiemap()
      btrfs: qgroup: fix a wrong length calculation in qgroup_free_reserved_data()

Rafael J. Wysocki (9):
      platform/x86: intel_sar: Check ACPI_HANDLE() against NULL
      PM: runtime: Wrapper macros for ACQUIRE()/ACQUIRE_ERR()
      platform/x86: lg-laptop: Drop debug-only ACPI notify handler
      platform/x86: lg-laptop: Convert ACPI driver to a platform one
      cpufreq: intel_pstate: Fix setting minimum P-state at init time
      ACPI: processor: idle: Expand _LPI package sanity checks
      ACPI: battery: Adjust charging status validation check
      intel_idle: Avoid using deep idle states during initialization
      platform/x86: lg-laptop: Check ACPI_COMPANION() against NULL

Rakesh Kota (1):
      thermal/drivers/qcom-spmi-adc-tm5: Drop IIO_VAL_INT check in adc_tm5_get_temp

Ran Hongyun (1):
      UBI: fix two issues in the ubi.mtd MODULE_PARM_DESC

Reinette Chatre (1):
      fs/resctrl: Prevent use-after-free in rdtgroup_kn_put()

Rex Lu (2):
      wifi: mt76: fix RX data queuing of RRO 3.0
      wifi: mt76: check txfree done event on the WED hw path

Ricardo B. Marlière (1):
      libbpf: Search /lib64 and /lib in resolve_full_path()

Ricardo Neri (2):
      sched/fair: Also gate overloaded status update for SD_ASYM_CPUCAPACITY
      sched/fair: Check CPU capacity before comparing group types during load balance

Richard Cheng (4):
      cxl/mbox: Clamp mailbox output allocation to the payload size
      cxl/features: Reject Get Feature count larger than the output buffer
      cxl/features: Reject Set Features output buffer smaller than the header
      cxl/features: Clamp Get Feature output size to the remaining buffer

Robert Malz (1):
      ice: acquire NVM lock around each flash read

Robertus Diawan Chris (1):
      modpost: prevent leak when early return no suffix .o in read_symbols()

Rong Zhang (2):
      staging: sm750fb: Add missing Kconfig dependency
      net: page_pool: Remove zone/policy GFP flags when allocating XArray entries

Rosen Penev (6):
      clk: stm32: add missing bitfield.h header
      powerpc/44x: Set GPIO chip parent
      ARM: dts: helios4: add vcc-supply to EEPROM
      ARM: dts: helios4: add vcc-supply to GPIO expander
      ARM: dts: helios4: add SATA regulator supplies
      ASoC: xilinx: formatter_pcm: fix stream_data leak on open error

Rui Qi (1):
      selftests/cgroup: Preserve CPU hotplug write errors

Runyu Xiao (3):
      ASoC: rt700-sdw: always drain jack work on remove
      sunrpc: xprtsock: annotate shared socket callbacks with READ_ONCE/WRITE_ONCE
      ALSA: mtpav: shut down output timer before card teardown

Ruoyu Wang (13):
      bus: qcom-ebi2: Fix clock leak on probe failure
      usb: gadget: aspeed_udc: check endpoint DMA allocation
      media: ipu6: Do not free aux device pdata after init
      drm/msm: Only fini scheduler after successful init
      mtd: mtdswap: Avoid freeing registered blktrans device twice
      NFSv4: remove callback IDR entry on client allocation failure
      net: dsa: mv88e6xxx: Fix PCS link check on CMODE read error
      bonding: initialize err for empty target lists
      i2c: ocores: Disable clock on failed resume
      net: bridge: Reject descending VLAN tunnel ranges
      net: ipa: balance runtime PM reference on remove error
      tpm: st33zp24: Return zero on status read failure
      tpm: st33zp24: Validate locality read result

Russell King (Oracle) (1):
      phy: qcom-sgmii-eth: relax order of .power_on() vs .set_mode*()

Rustam Adilov (1):
      irqchip/irq-realtek-rtl: Use readl_be()/writel_be() instead of readl()/writel()

Ryusuke Konishi (1):
      nilfs2: fix BUG in nilfs_copy_dirty_pages() on dirty state mismatch

SJ Park (1):
      mm/damon/sysfs: read ops_id only once in damon_sysfs_apply_inputs()

Saeed Mahameed (3):
      devlink: Introduce switchdev_inactive eswitch mode
      net/mlx5: MPFS, add support for dynamic enable/disable
      net/mlx5: E-Switch, support eswitch inactive mode

Sai Pratyusha Magam (1):
      wifi: nl80211: Add support for EPP peer indication

Sajal Gupta (1):
      md/raid5-ppl: fix use-after-free in ppl_do_flush()

Saket Kumar Bhaskar (1):
      powerpc/irq: Fix missing r2 clobber in PCREL inline assembly

Salman Alghamdi (1):
      staging: rtl8723bs: rtw_mlme: add bounds checks before ie_length subtraction

Sameeksha Sankpal (1):
      staging: rtl8723bs: Fix operator spacing in rtw_security.c

Samuel Moelius (1):
      iommufd/selftest: Avoid selftest dirty bitmap size wrap

Sandipan Das (3):
      perf/x86/amd/uncore: Add group validation
      perf vendor events amd: Update Zen 5 core events
      perf vendor events amd: Reintroduce deprecated Zen 5 core events

Sang-Heon Jeon (2):
      iio: light: isl29028: return zero in write_raw() on success
      iio: light: tsl2583: return zero in write_raw() on success

Sanghyun Park (3):
      bpf: Fix use-after-free on mm_struct in bpf_find_vma()
      xfrm: Fix skb double-free in xfrm_dev_direct_output()
      bpf: Fix mmap_lock leak in irq_work path

Sanjay Chitroda (1):
      iio: orientation: hid-sensor-rotation: Avoid race between callback setup and device exposure

Sascha Bischoff (1):
      irqchip/gic-v5: Synchronize CPU interface disable

Sayali Patil (2):
      selftests/mm: fix ksm NUMA merge test for systems with memoryless NUMA nodes
      selftests/mm: fix ternary operator precedence in ksm_tests

Sean Christopherson (3):
      KVM: x86: Extract REGS and SREGS runtime sync code to helpers
      KVM: x86: Rename __{g,s}et_sregs2() => kvm_vcpu_ioctl_x86_{g,s}et_sregs2()
      KVM: x86: Move the bulk of register specific code from x86.c to regs.c

Sean Rhodes (1):
      misc: rtsx_usb: avoid USB I/O in runtime autosuspend

Sean Wang (3):
      mmc: sdio: add MediaTek MT7902 SDIO device ID
      Bluetooth: btmtk: add MT7902 MCU support
      Bluetooth: btmtk: add MT7902 SDIO support

Sean Young (2):
      media: keymaps: Remove obsolete RC_MAP_RC5_TV keymap define
      media: keymaps: Remove obsolete RC_MAP_HAUPPAUGE_NEW keymap define

Sebastian Andrzej Siewior (1):
      futex: Provide rt_mutex_.*_schedule() equivalents for futex scheduling

Sechang Lim (1):
      bpf,lsm: Drop bpf_prog_free from sleepable_lsm_hooks

Selvin Xavier (1):
      RDMA/bnxt_re: Clear VM_MAYWRITE on DBR/toggle page mmap

Sergei Litvin (1):
      scripts/tags.sh: Prevent binary files appearing in cscope.files

Serhat Kumral (1):
      RDMA/ucma: Allow path records to exactly fit the output buffer

Shawn Guo (1):
      arm64: dts: qcom: lemans: Move PCIe devices into soc node

Shayne Chen (2):
      wifi: mt76: mt7996: fix capability of EHT-MCS 15 in MRU
      wifi: mt76: mt7996: support fixed rate for link station

Shengjiu Wang (1):
      ASoC: fsl_audmix: rework runtime PM handling in probe

Shin'ichiro Kawasaki (2):
      nvmet-rdma: factor out response resource cleanup
      nvmet-rdma: fix response resource leak on queue teardown

Shivam Rawat (1):
      drm/msm/a6xx: Fix stale rpmh votes after suspend

Shuangpeng Bai (1):
      RDMA/siw: Fix use-after-free in siw_accept()

Shukai Ni (1):
      dm-integrity: replace forgeable discard filler with a keyed sector marker

Shyam Sunder Reddy Padira (1):
      staging: rtl8723bs: os_dep: avoid NULL pointer dereference in rtw_cbuf_alloc

Simon Glass (1):
      pinctrl: rockchip: Reset the pin count when recalculating SoC data

Slawomir Stepien (1):
      wifi: zd1211rw: reject secondary interfaces to prevent conflicts

Srinivas Kandagatla (2):
      soundwire: qcom: Fix port exhaustion check in stream_alloc_ports
      rpmsg: glink: remove duplicate code for rpmsg device remove

Srinivas Pandruvada (2):
      platform/x86: ISST: Check for admin capability for write commands
      platform/x86: ISST: Validate max level for set feature

Stanislav Fomichev (2):
      xsk: align TX metadata layout across ABIs
      xsk: honor XDP_TX_METADATA in zero-copy path

Stanislav Kinsburskii (1):
      lib/test_hmm: fail dmirror_fault() when the mirrored mm is gone

StanleyYP Wang (3):
      wifi: mt76: mt7996: set specific BSSINFO and STAREC commands after channel switch
      wifi: mt76: mt7996: add missing rdd_idx check when enabling background radar
      wifi: mt76: mt7996: fix reg addr remap when addr is 0

Steve Dunnagan (1):
      leds: gpio: Clear error pointers for skipped LEDs

Steven Rostedt (7):
      ring-buffer: Show persistent buffer dropped events in trace_pipe file
      tracing: Clean up use of trace_create_maxlat_file()
      tracing: Make printk_trace global for tracing system
      tracing: Take trace_array reference when opening options file
      ftrace: Take trace_array reference before accessing its ftrace_ops
      tracing: Have trace_event_update_all() only handle module that is loading
      tracing: Move d_max_latency out of CONFIG_FSNOTIFY protection

Sudeep Holla (16):
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
      firmware: arm_scmi: Fix transport device teardown lookup
      firmware: arm_scmi: Fix requested device removal race
      firmware: arm_scmi: Roll back partial protocol table registration
      firmware: arm_scmi: Unrequest devices if driver registration fails

Suman Ghosh (1):
      octeontx2-pf: fix NULL deref of af_xdp_zc_qidx on rep setup

Sumeet Pawnikar (1):
      powercap: intel_rapl_tpmi: Handle PMU registration failure during probe

Suraj Gupta (1):
      dmaengine: xilinx_dma: Fix channel idle state management in AXIDMA and MCDMA interrupt handlers

Surendra Singh Chouhan (1):
      rtc: spacemit: handle regmap_test_bits() error return

Sven Eckelmann (3):
      batman-adv: dat: atomically update mac addresses
      batman-adv: bla: avoid CRC corruption due to parallel claim add
      batman-adv: fix TX priority extraction for BATADV_FORW_MCAST

Sven Peter (7):
      mfd: macsmc: Fix key count endianness annotation
      nvme-apple: Destroy the admin queue on removal
      nvme-apple: Don't set a DMA direction for commands without a data transfer
      nvme-apple: Never set the opcode in the NVMMU TCB
      nvme: Add a quirk for page aligned admin queue buffers
      nvme-apple: Require page aligned buffers on the admin queue
      nvme-apple: Drop the PRP null check chicken bit

Szymon Wilczek (1):
      hwmon: (coretemp) Fix core_data leak on CPUs without PTS

Taimuraz Kaitmazov (1):
      accel/amdxdna: return early from a zero-length flush

Takashi Iwai (3):
      ALSA: usb-audio: Relax __free() variable declarations
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

Taniya Das (1):
      clk: qcom: gcc-glymur: Move EVA clocks to critical clock list

Tanushree Shah (4):
      perf data convert json: Fix trace_seq memory leak in process_sample_event()
      perf dso: Fix kallsyms DSO detection with fallback logic
      perf trace-event: Fix buffer overflow in read_string()
      perf trace-event: Fix integer truncation in do_read() and skip()

Tao Cui (4):
      block/blk-stat: drain per-cpu callback stats over possible CPUs
      block/blk-iocost: collect per-cpu latency stats over possible CPUs
      block/kyber-iosched: flush per-cpu latency buckets over possible CPUs
      sched_ext/scx_flatcg: Fix cvtime true-up on slice expiry

Tejun Heo (1):
      tools/sched_ext: Strip compatibility macros for cgroup and dispatch APIs

Tengda Wu (1):
      perf capstone: Fix kernel map reference count leak

Tetsuo Handa (3):
      net: add missing ref_tracker_dir_exit() to alloc_netdev_mqs()
      net: add missing ref_tracker_dir_exit() to net_passive_dec()
      net: fix a resource leak in copy_net_ns() error handling path

Thierry Reding (1):
      syscore: Pass context data to callbacks

Thomas Bogendoerfer (1):
      MIPS: ptrace: Fix syscall skipping via PTRACE_SYSCALL

Thomas Huth (1):
      smb: server: Remove obsolete "select CRYPTO_LIB_DES" from Kconfig file

Thomas Walsh (1):
      bnxt_en: Gate TPH enablement behind BNXT_SUPPORTS_QUEUE_API check

Thomas Weißschuh (14):
      tools/nolibc: mark arg1 operand in __nolibc_syscall0() as write-only
      vdso/timens: Move functions to new file
      timens: Add a __free() wrapper for put_time_ns()
      timens: Simplify some calls to put_time_ns()
      y2038: uapi: Use 64-bit __kernel_old_timespec::tv_nsec on x32
      tools/nolibc/powerpc: mark ctr and xer as clobbered by system call
      hwmon: (cros_ec) Split up supported features in the documentation
      hwmon: (cros_ec) Move temperature channel params to a macro
      hwmon: (cros_ec) Add support for temperature thresholds
      hwmon: (cros_ec) Register the thermal devices after the hwmon ones
      hwmon: (cros_ec) Store the hwmon device in cros_ec_hwmon_priv
      hwmon: (cros_ec) Synchronize EC access from the thermal device callbacks
      selftests: harness: Restore order of test functions
      selftests: vDSO: getrandom: Fix path to s390 chacha implementation

Thorsten Blum (4):
      crypto: atmel-ecc - reject hardware ECDH without a public key
      crypto: sl3516 - drop invalid sg_dma_len checks before DMA mapping
      crypto: qat - use 2-arg strscpy where destination size is known
      apparmor: Replace sprintf/strcpy with scnprintf/strscpy in aa_policy_init

Timur Kristóf (3):
      drm/amdgpu/gfx6: Fixup emit_cntxcntl()
      drm/amdgpu/gfx6: Fixup emitting SWITCH_BUFFER packets
      drm/amdgpu/gfx6: Use PFP on the compute queues too

Titouan Ameline de Cadeville (1):
      firmware: google: Add bounds checks in coreboot_table_populate()

Tommaso Merciai (3):
      phy: renesas: rcar-gen3-usb2: Factor out VBUS control logic
      phy: renesas: rcar-gen3-usb2: Add regulator for OTG VBUS control
      i3c: renesas: Don't register devices when ENTDAA times out

Tomáš Macholda (1):
      arm64: dts: turris-mox: fix usb3 phys

Tony W Wang-oc (1):
      ACPI: processor: Add cpuidle driver check in acpi_processor_register_idle_driver()

Troy Mitchell (2):
      riscv: dts: spacemit: add MusePi Pro board device tree
      pinctrl: spacemit: validate pins in pinconf callbacks

Tzung-Bi Shih (1):
      platform/chrome: sensorhub: Fix memory overread in ring handler

Uday Khare (2):
      regulator: tps6594: Fix device node reference leaks in multiphase loop
      remoteproc: qcom: Fix glink->node reference leak in qcom_add_glink_subdev

Unnathi Chalicheemala (2):
      firmware: qcom_scm: Add API to get waitqueue IRQ info
      firmware: qcom_scm: Support multiple waitq contexts

Usama Arif (1):
      mm/huge_memory: transfer the pmd dirty bit to the folio on zap

Vasant Hegde (1):
      iommu/amd: Fix incorrect device ID in invalid PASID error message

Vasily Gorbik (1):
      s390/kexec: Disable stack protector in s390_reset_system()

Vicki Pfau (5):
      HID: steam: Refactor and clean up report parsing
      HID: steam: Rename some constants that got renamed upstream
      HID: steam: Add support for sensor events on the Steam Controller (2015)
      HID: steam: Improve logging and other cleanup
      HID: steam: Reject short reads

Victor Nogueira (4):
      net/sched: cls_api: fix teardown of an adopted proto on insert-race loss
      net/sched: add get_fill_size callbacks for actions missing them
      net/sched: act_ife: Only operate on Ethernet frames
      net/sched: sch_teql: restore skb->dev on the slave failure path

Vidhu Sarwal (3):
      staging: media: ipu7: fix pm_runtime refcount leak in ipu7_init_fw_code_region_by_sys()
      staging: media: ipu7: fix pm_runtime refcount leak in ipu7_resume()
      iio: light: opt4060: Fix pointer type passed to div_u64_rem()

Viktor Malik (2):
      selftests/bpf: Check malloc result with ASSERT_NEQ in test_sha256
      selftests/bpf: Silence array bounds warning in global_map_resize

Vincent Donnefort (2):
      ring-buffer: Allow splice reads on static buffers
      ring-buffer: Remove trace_buffer::cpus

Vineet Gupta (1):
      selftests/bpf: vmtest.sh: Preserve command quoting when running in the VM

Vishnu Santhosh (1):
      rpmsg: glink: fix deadlock in endpoint destroy during driver detach

Vivek BalachandharTN (1):
      staging: rtl8723bs: fix spacing around operators

Vladimir Murzin (3):
      arm64: smp: Fix IPI teardown for GICv5 flow
      arm64: hibernate: Restore DAIF state on error
      arm64: process: Fix context switching MTE store-only tag check

Vladimir Oltean (1):
      net: dsa: b53: fix error propagation from b53_fdb_dump()

Vladimir Zapolskiy (6):
      i2c: qcom-cci: Do not check return value of cci_init()
      i2c: qcom-cci: Remove overcautious disable_irq() calls
      dmaengine: mediatek: mtk-uart-apdma: Return -ENOMEM on memory allocation failure
      dmaengine: hisilicon: Return -ENOMEM on dynamic memory allocation in probe
      iommu/msm: Return -ENOMEM on memory allocation failure in probe
      clk: qcom: Return expected ENOMEM error on dynamic allocation failure

Waiman Long (2):
      cgroup/cpuset: Make nr_deadline_tasks an atomic_t
      cgroup/cpuset: Fail if isolated and nohz_full don't leave any housekeeping

Wang Yan (1):
      selftests/lsm: Fix memory leak in attr_lsm_count

Wanwu Li (1):
      sched_ext/scx_flatcg: Fix cvtime_delta race and add hweight scaling to bypass charging

Wei Fang (3):
      ptp: netc: skip PEROUT disable if channel is not enabled
      ptp: netc: fix period truncation and potential divide-by-zero in PEROUT
      net: enetc: restore RX ring congestion mode after ring reconfiguration

Wei Hou (1):
      cxl/pci: Remove incorrect mbox.valid check in cxl_pci_type3_init_mailbox()

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

Wesley Cheng (2):
      phy: qualcomm: Update the QMP clamp register for V6
      phy: qualcomm: qmp-combo: Update QMP PHY with Glymur settings

Willem de Bruijn (1):
      idpf: add missing cpu_to_le32 in idpf_tx_splitq_build_flow_desc

Wolfram Sang (1):
      hwspinlock: propagate errno when registering single lock

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

Xie Yuanbin (1):
      ARM: 9485/1: mm: acquire mmap write lock around show_pte() for user faults

Xin Xie (1):
      net: hsr: free learned nodes on device setup failure

Xiubo Li (1):
      ceph: revalidate ki_pos for O_APPEND writes after cap acquisition

Xu Rao (1):
      ALSA: hda: Fix connection list comparison in proc output

Xu Yang (1):
      usb: gadget: f_uac1_legacy: remove broken string configfs attributes

Xuanqiang Luo (1):
      fanotify: initialize permission event watchdog state

Yang Xiuwei (2):
      scsi: sd: Fix sd_done() sense handling condition
      nvme/ioctl: check SUBMIT_IO with nvme_cmd_allowed()

Yao Kai (1):
      ext4: validate readdir offset before accessing dirent

Yao Sang (1):
      ublk: reject non-power-of-2 zone sizes in SET_PARAMS

Yehyeong Lee (5):
      IB/isert: reject PDUs declaring more data than was received
      IB/isert: reject login PDUs declaring more data than was received
      RDMA/srp: fix heap information leak on a truncated SRP_CRED_REQ
      IB/isert: delay the final Login Response until the session is registered
      IB/isert: post the full-feature receive buffers after session registration

Yeoreum Yun (3):
      coresight: etm4x: fix wrong check of etm4x_sspcicrn_present()
      coresight: etm4x: fix underflow for usage of (nrseqstate - 1)
      coresight: etm4x: fix leaked trace id

Yi Ding (1):
      rtc: pcf8563: fix clock provider leak on unbind

Yichong Chen (8):
      tools/bpf/bpftool: Reset vmlinux BTF after map commands
      tools/bpf/bpftool: Reset vmlinux BTF after struct_ops commands
      isofs: release zisofs block pointer buffer head
      fanotify: stop permission watchdog when timeout is zero
      fanotify: report full event length for FIONREAD
      fat: release buffer head after rebuilding parent
      hugetlbfs: release subpool on fill_super failure
      btrfs: retry verity reads for not-uptodate Merkle folios

Yicong Hui (1):
      drm: Remove unused header in drm_dumb_buffers.c

Yifei Chu (1):
      net/smc: release the internal TCP sock on IPPROTO_SMC socket creation failure

Yilin Zhang (1):
      perf: Fix use-after-free when perf mmap() revival races with the last munmap()

Yinhao Hu (1):
      nfc: pn533: hold a reference to the request skb during send_frame

Yiyang Chen (1):
      bpf: Reject arena frees below the arena base

Yonatan Nachum (1):
      RDMA/efa: Fix PBL chunk length computation

Yonghong Song (1):
      bpf, x86: Fix trampoline stack size for 128-bit arguments

Yosry Ahmed (2):
      KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported
      KVM: x86: Check EFER validity on KVM_SET_SREGS*

Yousef Alhouseen (2):
      platform/x86: acer-wmi: reject missing gaming WMI results
      HID: synchronize input before cleaning up a failed probe

Yu Kuai (5):
      md/raid5: round bitmap stripes with sector division
      md: wait for behind writes before destroying bitmap
      md: avoid stale clone I/O accounting timestamps
      md/md-llbitmap: prevent create failure bitmap UAF
      md/md-llbitmap: stop daemon timer rearm on destroy

Yu Peng (2):
      perf metricgroup: Fix metric expression copy leaks
      fs: annotate inode timestamp accessors

Yuan Chen (1):
      bpftool: Fix double close in map dump

Yuanshen Cao (1):
      iio: light: tsl2772: fix ALS calibscale readback

Yufeng Wang (1):
      vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY

Yuhang.chen (1):
      wifi: rtw89: pci: add .shutdown callback to stop rfkill polling on reboot

Yuho Choi (16):
      bus: ti-sysc: Fix /chosen node reference leak
      clocksource: Unregister subsystem on device registration failure
      timekeeping: Unwind aux clock sysfs children on failure
      bus: mhi: ep: Fix device refcount leak in the error path of MHI device creation
      serial: ma35d1: Fix OF node reference leaks in console init
      hwrng: ks-sa - Fix runtime PM cleanup on registration failure
      PCI: xgene: Drop unnecessary OF node reference
      uio: Fix stale info pointer in failed registration path
      driver core: soc: Unregister bus on early device registration failure
      bus: mhi: host: Fix controller cleanup on EDL sysfs failure
      ACPI: video: Release PCI device reference after lookup
      hwrng: imx-rngc - Disable clock on registration failure
      ubi: Fix rollback for explicit UBI device numbers
      mtd: ubi: Release device reference on busy detach
      xenbus: Unregister reboot notifier on init failure
      clocksource/drivers/armada: Unwind timer clock on init failure

Yulin Lu (1):
      pinctrl: eswin: Fix Handling of PIN_CONFIG_PERSIST_STATE

Yun Zhou (3):
      ext4: fix circular lock dependency in ext4_ext_migrate
      ext4: skip extra isize expansion during mount to prevent deadlock
      nfc: nci: fix use of uninitialized memory in CORE_INIT_RSP parsing

Yunseong Kim (1):
      ksmbd: validate ipc response length before dereferencing its fields

Yuntao Wang (1):
      kbuild: fix modules.builtin(.modinfo) targets in the top-level Makefile

Yuvaraj Ranganathan (2):
      firmware: qcom: scm: add trace events for the SMC call interface
      firmware: qcom: scm: instrument SMC call path with tracepoints

Yuvraj Singh Chauhan (1):
      staging: octeon: fix free_irq dev_id mismatch in cvm_oct_rx_shutdown

Ze Tan (1):
      smb/server: fix session leak in ksmbd_session_register()

Zhan Xusheng (3):
      fs/ntfs3: fix integer overflow in MFT cluster validation
      fs/ntfs3: reject out-of-range evcn in mi_enum_attr()
      erofs: fix EFSCORRUPTED on multi-algorithm images in z_erofs_map_sanity_check()

ZhangGuoDong (4):
      smb/server: fix null-ptr-deref in ksmbd_ipc_tree_connect_request()
      smb/server: fix invalid pointer dereference in ksmbd_stop_durable_scavenger()
      smb/server: preserve error status in smb2_handle_negotiate()
      pnfs/blocklayout: Fix device leaks on parse failure

Zhansong Gao (1):
      NFSv4: Fix incorrect argument passed to nfs4_delete_lease() in nfs4_add_lease()

Zhao Li (4):
      wifi: mac80211: fix per-STA profile length in cross-link CSA parsing
      wifi: mac80211: send TWT teardown to peer after setup TX failure
      wifi: mac80211: skip unused probe response countdown offsets
      wifi: cfg80211: stop PMSR before P2P and NAN teardown

Zheng Qixing (2):
      blk-cgroup: fix race between policy activation and blkg destruction
      blk-cgroup: skip dying blkg in blkcg_activate_policy()

ZhengYuan Huang (2):
      ocfs2: validate orphan slot during inode read
      ocfs2: validate DIO orphan slot during inode read

Zhenghang Xiao (1):
      nfc: nci: fix double completion race in nci_data_exchange_complete

Zhengrong Li (1):
      nvmet: fix Reservation Register Replace for unregistered host with IEKEY

Zhi-Jun You (1):
      wifi: mt76: mt7915: fix net_fill_forward_path for non-DBDC mt7986

Zhihao Cheng (2):
      UBI: Preserve torture flag when rescheduling failed erasures
      UBI: fastmap: Pass to_be_tortured when reusing old fastmap PEBs

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

