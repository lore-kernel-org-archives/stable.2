Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420844;
	b=G+aUlOGvQRKtEB2ElLgQtBgWY0Gkng71OGIZysLFUnLxMwO3pTnlM1YTrr36n6ziwbEm
	 VHB1W6dHHN97PJmNMPOZkbqAGPQG/2QDHeWjRccWkZrnGYqoBXyjUpC1s9VjyDu3XBCUe
	 +7lh7uPqx/9IJm/s1J3jEXobYNDrm1NnWUklTmV9GEJ7jNFNsIx4r2OBUp2Y0cKcOylKI
	 Xfs4DQuVzODVDFJ1ts1QmuYi/1XU+vKiUJahFcLOLOAWDbIc7065KupbLGDcqXw4jY7fe
	 Z8PR6ROxweJ/kvnN4FzQDyPq3o+tJd+3b1OCNZn0/9O09xB1/22vFUlpr86x2v9ptlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420844;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VAOF2oWJWASbFcaB6H9+ZsV4TtsgvaxP9vEL+rLWyc4=;
	b=UPYHeR1CJ+5Z8T0/Cyf6TK1jZ99X6iZZFtsmYtEnzNAD7J5qTkMIX4L5F1DMSDilJfh4
	 4Lh23/umUggh/r4kXF4X/7GyItiXkG0ISDDaq+23AouLQEkaTaW6TdsZtVRqoWYKpqQrq
	 oJv3NYNv0hRTQw3/Yv9QdwAE3lyPgsAVetTiwitk7+YUovAc5vENimYJwbpwVxaJw1DzU
	 Ol3DF6Ac+BglZ3WrMok213/Q19g8LiyfL2mdHW6YeXccVa8jHhToVR9IzFyIWVP8IYxqT
	 iVpTPH5ZGvbKIJVJk2628Pj8b+wE9uDGBljsOzIM50J0qyEdjFoEbziMcslM3ZpQcKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Yujt4AuE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0DE606A321;
	Mon, 23 Nov 2026 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Yujt4AuE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FD71F00A01;
	Mon, 23 Nov 2026 08:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795420843;
	bh=VAOF2oWJWASbFcaB6H9+ZsV4TtsgvaxP9vEL+rLWyc4=;
	h=From:To:Cc:Subject:Date;
	b=Yujt4AuEKheKTi8ZQo+wo9FDu3FxONw5Ai8L/a9ucAUxtUde5HRXv1L7sv7hbFNfe
	 dzvukaNC5T5D7oyvHieVZR2WbAUYzyaL9h27RxVg1B6UC69CjcIbmcniNL3fXosKUI
	 y0keneDT4CrN938SaS9hNmmfTne6uacmw3hFpDDA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.119
Date: Mon, 23 Nov 2026 08:59:56 +0100
Message-ID: <2026112357-negligent-path-fee4@gregkh>
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

I'm announcing the release of the 6.12.119 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 .gitignore                                                                    |    1 
 Documentation/ABI/testing/sysfs-bus-pci                                       |   14 
 Documentation/ABI/testing/sysfs-class-power-mp2629                            |    2 
 Documentation/admin-guide/LSM/LoadPin.rst                                     |   10 
 Documentation/admin-guide/LSM/ipe.rst                                         |    4 
 Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.yaml           |    2 
 Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml              |    2 
 Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml                |    2 
 Documentation/devicetree/bindings/display/msm/dsi-phy-common.yaml             |    2 
 Documentation/devicetree/bindings/display/msm/hdmi.yaml                       |    4 
 Documentation/devicetree/bindings/dma/stericsson,dma40.yaml                   |   14 
 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml                |    3 
 Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml |   21 
 Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml |   76 
 Documentation/devicetree/bindings/vendor-prefixes.yaml                        |   22 
 Documentation/sound/designs/midi-2.0.rst                                      |    7 
 Documentation/trace/histogram.rst                                             |    3 
 MAINTAINERS                                                                   |    1 
 Makefile                                                                      |    2 
 arch/alpha/Kconfig                                                            |    1 
 arch/alpha/mm/fault.c                                                         |   29 
 arch/arc/Makefile                                                             |    9 
 arch/arc/include/asm/syscall.h                                                |   11 
 arch/arc/lib/Makefile                                                         |    8 
 arch/arm/boot/dts/gemini/gemini.dtsi                                          |    2 
 arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi                        |    2 
 arch/arm/boot/dts/marvell/armada-388-helios4.dts                              |   23 
 arch/arm/boot/dts/marvell/armada-395-gp.dts                                   |    1 
 arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi                                     |   40 
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi                                      |   30 
 arch/arm/boot/dts/st/ste-ab8500.dtsi                                          |    6 
 arch/arm/boot/dts/st/ste-ab8505.dtsi                                          |   23 
 arch/arm/boot/dts/st/ste-dbx5x0.dtsi                                          |    5 
 arch/arm/boot/dts/st/ste-href-ab8500.dtsi                                     |  104 
 arch/arm/boot/dts/st/ste-href-ab8505.dtsi                                     |  118 
 arch/arm/boot/dts/st/stm32mp135.dtsi                                          |   42 
 arch/arm/boot/dts/st/stm32mp157c-lxa-mc1.dts                                  |    2 
 arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi                                 |    2 
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi                               |    2 
 arch/arm/include/asm/domain.h                                                 |   17 
 arch/arm/include/asm/memory.h                                                 |    4 
 arch/arm/include/asm/pgtable-2level-hwdef.h                                   |    1 
 arch/arm/include/asm/pgtable-2level.h                                         |    7 
 arch/arm/include/asm/sparsemem.h                                              |    4 
 arch/arm/include/asm/syscall.h                                                |   24 
 arch/arm/kernel/efi.c                                                         |   13 
 arch/arm/mach-mvebu/Kconfig                                                   |    4 
 arch/arm/mach-versatile/platsmp-vexpress.c                                    |    4 
 arch/arm/mach-versatile/v2m.c                                                 |    4 
 arch/arm/mm/Kconfig                                                           |    7 
 arch/arm/mm/alignment.c                                                       |   10 
 arch/arm/mm/dma-mapping.c                                                     |    5 
 arch/arm/mm/ioremap.c                                                         |   53 
 arch/arm/mm/mmu.c                                                             |   76 
 arch/arm64/Kconfig.platforms                                                  |    1 
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi                                  |    4 
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi                             |    9 
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts                          |    4 
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts                                 |   14 
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts                                  |   26 
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts                                 |    4 
 arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts                             |    4 
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts                               |    4 
 arch/arm64/boot/dts/freescale/imx95.dtsi                                      |    4 
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                                      |    2 
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi                                    |    8 
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi                                |   13 
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi                         |    2 
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts                             |    4 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                          |    2 
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts                      |    1 
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                                     |    1 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                                      |    2 
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts                               |   32 
 arch/arm64/boot/dts/rockchip/rk3566-base.dtsi                                 |   39 
 arch/arm64/boot/dts/rockchip/rk3566.dtsi                                      |  116 
 arch/arm64/boot/dts/rockchip/rk3568.dtsi                                      |  117 
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi                                 | 1857 +++++++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi                                      | 1939 ----------
 arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts                        |    7 
 arch/arm64/boot/dts/st/stm32mp231.dtsi                                        | 1213 ++++++
 arch/arm64/boot/dts/st/stm32mp233.dtsi                                        |   94 
 arch/arm64/boot/dts/st/stm32mp235.dtsi                                        |   16 
 arch/arm64/boot/dts/st/stm32mp23xc.dtsi                                       |    8 
 arch/arm64/boot/dts/st/stm32mp23xf.dtsi                                       |    8 
 arch/arm64/boot/dts/st/stm32mp251.dtsi                                        |    2 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                                    |   41 
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts                                       |  124 
 arch/arm64/include/asm/syscall.h                                              |   16 
 arch/arm64/kernel/pi/Makefile                                                 |    1 
 arch/arm64/kvm/vgic/vgic-its.c                                                |   37 
 arch/hexagon/include/asm/syscall.h                                            |    7 
 arch/loongarch/include/asm/syscall.h                                          |    7 
 arch/m68k/apollo/dn_ints.c                                                    |    6 
 arch/m68k/include/asm/syscall.h                                               |    7 
 arch/m68k/mac/config.c                                                        |   31 
 arch/microblaze/Makefile                                                      |    6 
 arch/microblaze/include/asm/syscall.h                                         |    7 
 arch/microblaze/include/asm/uaccess.h                                         |    3 
 arch/microblaze/kernel/cpu/cpuinfo.c                                          |    1 
 arch/microblaze/kernel/ptrace.c                                               |    3 
 arch/mips/Makefile                                                            |   22 
 arch/mips/cavium-octeon/dma-octeon.c                                          |    2 
 arch/mips/include/asm/syscall.h                                               |   15 
 arch/nios2/include/asm/syscall.h                                              |    5 
 arch/nios2/kernel/nios2_ksyms.c                                               |    1 
 arch/openrisc/include/asm/syscall.h                                           |    6 
 arch/parisc/include/asm/syscall.h                                             |    7 
 arch/powerpc/include/asm/syscall.h                                            |   10 
 arch/powerpc/kernel/trace/ftrace_entry.S                                      |    6 
 arch/riscv/include/asm/insn.h                                                 |    2 
 arch/riscv/include/asm/syscall.h                                              |    7 
 arch/riscv/net/bpf_jit_comp64.c                                               |   14 
 arch/riscv/net/bpf_jit_core.c                                                 |    1 
 arch/s390/include/asm/syscall.h                                               |   12 
 arch/s390/kernel/ptrace.c                                                     |    9 
 arch/s390/kernel/uprobes.c                                                    |    2 
 arch/sh/Kconfig                                                               |    1 
 arch/sh/boards/board-sh7785lcr.c                                              |    2 
 arch/sh/configs/migor_defconfig                                               |    2 
 arch/sh/configs/sdk7786_defconfig                                             |    2 
 arch/sh/configs/shx3_defconfig                                                |    2 
 arch/sh/include/asm/syscall_32.h                                              |   12 
 arch/sh/include/asm/uaccess_32.h                                              |    8 
 arch/sparc/include/asm/syscall.h                                              |   12 
 arch/um/include/asm/syscall-generic.h                                         |    5 
 arch/x86/boot/compressed/efi_mixed.S                                          |   16 
 arch/x86/include/asm/efi.h                                                    |    3 
 arch/x86/include/asm/svm.h                                                    |    4 
 arch/x86/include/asm/syscall.h                                                |    7 
 arch/x86/kernel/cpu/microcode/amd.c                                           |   12 
 arch/x86/kernel/crash.c                                                       |    6 
 arch/x86/kvm/svm/nested.c                                                     |   23 
 arch/x86/kvm/svm/svm.c                                                        |    2 
 arch/x86/kvm/svm/svm.h                                                        |    2 
 arch/x86/mm/pat/set_memory.c                                                  |   23 
 arch/x86/platform/efi/efi.c                                                   |   29 
 arch/x86/platform/efi/efi_64.c                                                |   42 
 arch/x86/platform/pvh/enlighten.c                                             |    2 
 arch/x86/power/hibernate.c                                                    |   51 
 arch/xtensa/include/asm/syscall.h                                             |    7 
 block/bdev.c                                                                  |   12 
 block/bfq-iosched.c                                                           |    4 
 block/blk-cgroup.c                                                            |   19 
 block/blk-cgroup.h                                                            |    6 
 block/blk-flush.c                                                             |    8 
 block/blk-iocost.c                                                            |  311 +
 block/blk-iolatency.c                                                         |    3 
 block/blk-map.c                                                               |    1 
 block/blk-mq.c                                                                |   42 
 block/blk-rq-qos.c                                                            |   18 
 block/blk-throttle.c                                                          |   91 
 block/blk-timeout.c                                                           |    3 
 block/blk.h                                                                   |   14 
 block/fops.c                                                                  |   12 
 block/partitions/mac.c                                                        |    4 
 crypto/asymmetric_keys/verify_pefile.c                                        |    5 
 crypto/lskcipher.c                                                            |    6 
 crypto/tcrypt.c                                                               |  182 
 drivers/accel/qaic/qaic_data.c                                                |    8 
 drivers/acpi/acpi_extlog.c                                                    |    9 
 drivers/acpi/acpi_pcc.c                                                       |   29 
 drivers/acpi/acpi_video.c                                                     |   12 
 drivers/acpi/acpica/dsfield.c                                                 |    3 
 drivers/acpi/acpica/exfield.c                                                 |   11 
 drivers/acpi/acpica/nsxfname.c                                                |    1 
 drivers/acpi/apei/ghes.c                                                      |   16 
 drivers/acpi/button.c                                                         |   12 
 drivers/acpi/cppc_acpi.c                                                      |   22 
 drivers/acpi/device_pm.c                                                      |   77 
 drivers/acpi/fan_core.c                                                       |    9 
 drivers/acpi/glue.c                                                           |   10 
 drivers/acpi/numa/hmat.c                                                      |    2 
 drivers/acpi/pci_link.c                                                       |    1 
 drivers/acpi/pci_root.c                                                       |   22 
 drivers/acpi/scan.c                                                           |   40 
 drivers/acpi/tables.c                                                         |    3 
 drivers/acpi/utils.c                                                          |   41 
 drivers/ata/libahci.c                                                         |   15 
 drivers/ata/libata-core.c                                                     |   12 
 drivers/ata/libata-scsi.c                                                     |    2 
 drivers/ata/pata_parport/pata_parport.c                                       |    9 
 drivers/ata/sata_dwc_460ex.c                                                  |    5 
 drivers/base/node.c                                                           |   17 
 drivers/base/power/runtime.c                                                  |    6 
 drivers/base/power/wakeirq.c                                                  |   26 
 drivers/block/drbd/drbd_main.c                                                |    1 
 drivers/block/drbd/drbd_receiver.c                                            |    2 
 drivers/block/floppy.c                                                        |   10 
 drivers/block/rnbd/rnbd-srv-sysfs.c                                           |   28 
 drivers/block/rnbd/rnbd-srv.c                                                 |   36 
 drivers/block/swim.c                                                          |  189 
 drivers/block/swim3.c                                                         |    8 
 drivers/block/swim_asm.S                                                      |  136 
 drivers/block/virtio_blk.c                                                    |    2 
 drivers/block/xen-blkback/blkback.c                                           |    7 
 drivers/bluetooth/btintel.c                                                   |    6 
 drivers/bluetooth/btmtk.c                                                     |   88 
 drivers/bluetooth/btmtksdio.c                                                 |   13 
 drivers/bluetooth/btusb.c                                                     |   19 
 drivers/bluetooth/virtio_bt.c                                                 |    4 
 drivers/bus/arm-cci.c                                                         |    6 
 drivers/char/hw_random/cctrng.c                                               |    7 
 drivers/char/hw_random/intel-rng.c                                            |    5 
 drivers/char/hw_random/jh7110-trng.c                                          |   39 
 drivers/char/scx200_gpio.c                                                    |    8 
 drivers/clk/bcm/clk-raspberrypi.c                                             |    2 
 drivers/clk/clk-cdce925.c                                                     |    9 
 drivers/clk/clk-lmk04832.c                                                    |    3 
 drivers/clk/clk-milbeaut.c                                                    |   10 
 drivers/clk/clk-renesas-pcie.c                                                |    5 
 drivers/clk/clk-s2mps11.c                                                     |   12 
 drivers/clk/clk-si521xx.c                                                     |    2 
 drivers/clk/clk-si5351.c                                                      |   20 
 drivers/clk/clk.c                                                             |   51 
 drivers/clk/clk.h                                                             |    5 
 drivers/clk/clkdev.c                                                          |    4 
 drivers/clk/imx/clk-composite-93.c                                            |   11 
 drivers/clk/mediatek/reset.h                                                  |    6 
 drivers/clk/qcom/clk-alpha-pll.c                                              |    9 
 drivers/clk/qcom/clk-rcg2.c                                                   |   35 
 drivers/clk/qcom/dispcc-sm8450.c                                              |    2 
 drivers/clk/qcom/gcc-x1e80100.c                                               |    6 
 drivers/clk/qcom/mmcc-msm8960.c                                               |    3 
 drivers/clk/qcom/mmcc-msm8996.c                                               |    4 
 drivers/clk/qcom/mmcc-sdm660.c                                                |    2 
 drivers/clk/starfive/clk-starfive-jh7110-sys.c                                |    3 
 drivers/clk/ti/adpll.c                                                        |    1 
 drivers/clk/versatile/clk-icst.c                                              |    4 
 drivers/clocksource/clksrc-dbx500-prcmu.c                                     |    2 
 drivers/clocksource/timer-mediatek.c                                          |    4 
 drivers/comedi/drivers/addi_apci_3xxx.c                                       |    2 
 drivers/comedi/drivers/comedi_parport.c                                       |    3 
 drivers/comedi/drivers/dmm32at.c                                              |    3 
 drivers/comedi/drivers/dt2811.c                                               |    2 
 drivers/comedi/drivers/dt2814.c                                               |    3 
 drivers/comedi/drivers/ni_atmio16d.c                                          |    4 
 drivers/comedi/drivers/pcmmio.c                                               |    3 
 drivers/comedi/drivers/pcmuio.c                                               |    5 
 drivers/cpufreq/amd-pstate.c                                                  |   18 
 drivers/cpufreq/qcom-cpufreq-hw.c                                             |    3 
 drivers/cpufreq/sparc-us2e-cpufreq.c                                          |   11 
 drivers/cpufreq/sti-cpufreq.c                                                 |    4 
 drivers/cpufreq/tegra194-cpufreq.c                                            |    2 
 drivers/cpuidle/governors/menu.c                                              |    8 
 drivers/cpuidle/governors/teo.c                                               |   11 
 drivers/crypto/amlogic/amlogic-gxl-cipher.c                                   |   25 
 drivers/crypto/atmel-aes.c                                                    |    2 
 drivers/crypto/atmel-sha.c                                                    |   17 
 drivers/crypto/ccp/ccp-dev-v3.c                                               |    4 
 drivers/crypto/ccp/ccp-dev-v5.c                                               |    4 
 drivers/crypto/hisilicon/hpre/hpre_crypto.c                                   |    2 
 drivers/crypto/intel/qat/qat_common/adf_init.c                                |   24 
 drivers/crypto/intel/qat/qat_common/adf_isr.c                                 |   15 
 drivers/crypto/intel/qat/qat_common/qat_algs.c                                |   15 
 drivers/crypto/intel/qat/qat_common/qat_asym_algs.c                           |   38 
 drivers/crypto/mxs-dcp.c                                                      |    3 
 drivers/crypto/starfive/jh7110-cryp.c                                         |   20 
 drivers/crypto/talitos.c                                                      |   93 
 drivers/crypto/talitos.h                                                      |    5 
 drivers/cxl/acpi.c                                                            |    7 
 drivers/cxl/core/hdm.c                                                        |   57 
 drivers/cxl/core/pci.c                                                        |    9 
 drivers/cxl/core/port.c                                                       |   28 
 drivers/cxl/core/region.c                                                     |    4 
 drivers/cxl/cxl.h                                                             |   10 
 drivers/cxl/pci.c                                                             |   11 
 drivers/dax/bus.c                                                             |    8 
 drivers/dma/at_hdmac.c                                                        |   28 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                                |   37 
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h                                         |    5 
 drivers/dma/fsl_raid.c                                                        |   32 
 drivers/dma/img-mdc-dma.c                                                     |    2 
 drivers/dma/ioat/init.c                                                       |   18 
 drivers/dma/mediatek/mtk-hsdma.c                                              |   26 
 drivers/dma/mv_xor.c                                                          |    1 
 drivers/dma/plx_dma.c                                                         |   10 
 drivers/dma/sprd-dma.c                                                        |   45 
 drivers/dma/ste_dma40.c                                                       |  434 +-
 drivers/dma/ste_dma40_ll.h                                                    |    2 
 drivers/dma/sun6i-dma.c                                                       |   31 
 drivers/dma/xilinx/xilinx_dma.c                                               |   37 
 drivers/dma/xilinx/zynqmp_dma.c                                               |   29 
 drivers/edac/i10nm_base.c                                                     |    1 
 drivers/firmware/arm_scmi/common.h                                            |   22 
 drivers/firmware/arm_scmi/driver.c                                            |   38 
 drivers/firmware/arm_scmi/protocols.h                                         |    9 
 drivers/firmware/arm_scmi/raw_mode.c                                          |   29 
 drivers/firmware/cirrus/cs_dsp.c                                              |    2 
 drivers/firmware/efi/cper.c                                                   |   51 
 drivers/firmware/efi/efi.c                                                    |    3 
 drivers/firmware/efi/libstub/efi-stub-entry.c                                 |    4 
 drivers/firmware/efi/libstub/efi-stub-helper.c                                |   10 
 drivers/firmware/efi/libstub/efi-stub.c                                       |   30 
 drivers/firmware/efi/libstub/efistub.h                                        |   22 
 drivers/firmware/efi/libstub/fdt.c                                            |    6 
 drivers/firmware/efi/libstub/file.c                                           |    8 
 drivers/firmware/efi/libstub/gop.c                                            |   58 
 drivers/firmware/efi/libstub/kaslr.c                                          |    6 
 drivers/firmware/efi/libstub/mem.c                                            |   22 
 drivers/firmware/efi/libstub/pci.c                                            |   36 
 drivers/firmware/efi/libstub/random.c                                         |    8 
 drivers/firmware/efi/libstub/randomalloc.c                                    |    4 
 drivers/firmware/efi/libstub/relocate.c                                       |   10 
 drivers/firmware/efi/libstub/riscv-stub.c                                     |    7 
 drivers/firmware/efi/libstub/riscv.c                                          |    2 
 drivers/firmware/efi/libstub/tpm.c                                            |    8 
 drivers/firmware/efi/libstub/unaccepted_memory.c                              |    2 
 drivers/firmware/efi/libstub/x86-stub.c                                       |  210 -
 drivers/firmware/imx/imx-dsp.c                                                |    6 
 drivers/firmware/qcom/qcom_tzmem.c                                            |    2 
 drivers/gpio/gpio-crystalcove.c                                               |    1 
 drivers/gpio/gpio-pcf857x.c                                                   |   33 
 drivers/gpu/buddy.c                                                           |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                                    |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                                    |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                              |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c                                  |   35 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                        |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                    |   48 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                                       |   19 
 drivers/gpu/drm/amd/amdgpu/atom.c                                             |  105 
 drivers/gpu/drm/amd/amdgpu/atom.h                                             |    5 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c                                        |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c                                        |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c                                        |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c                                        |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c                                      |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c                                      |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c                                      |    6 
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c                                         |    6 
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                                         |    6 
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c                                         |    6 
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c                                         |    9 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c                                         |    8 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c                                         |    8 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                                         |    8 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                         |    6 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c                                       |    6 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c                                       |    6 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c                                       |    6 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c                                       |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c                              |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c                              |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c                               |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c                               |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                        |   48 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                             |   20 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h                       |   38 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                      |    9 
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c                         |   32 
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h                            |    3 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c                           |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                          |   20 
 drivers/gpu/drm/arm/display/include/malidp_product.h                          |   10 
 drivers/gpu/drm/drm_of.c                                                      |    8 
 drivers/gpu/drm/exynos/exynos_drm_fimd.c                                      |    2 
 drivers/gpu/drm/i915/display/intel_atomic_plane.c                             |    1 
 drivers/gpu/drm/i915/display/intel_display.c                                  |   12 
 drivers/gpu/drm/i915/display/intel_psr.c                                      |   49 
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c                                           |    3 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                         |    6 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                         |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c                                 |  102 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h                                 |   10 
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c                                      |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                                   |   10 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c                          |    4 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c                                      |    9 
 drivers/gpu/drm/msm/dp/dp_ctrl.c                                              |    3 
 drivers/gpu/drm/msm/dp/dp_debug.c                                             |    1 
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c                                        |   30 
 drivers/gpu/drm/msm/msm_io_utils.c                                            |    6 
 drivers/gpu/drm/omapdrm/dss/dsi.c                                             |   63 
 drivers/gpu/drm/panfrost/panfrost_devfreq.c                                   |    2 
 drivers/gpu/drm/panfrost/panfrost_mmu.c                                       |   11 
 drivers/gpu/drm/panthor/panthor_gpu.c                                         |    5 
 drivers/gpu/drm/tegra/submit.c                                                |   12 
 drivers/hid/hid-logitech-hidpp.c                                              |    1 
 drivers/hid/i2c-hid/i2c-hid-core.c                                            |   11 
 drivers/hid/wacom_wac.c                                                       |   14 
 drivers/hv/vmbus_drv.c                                                        |    8 
 drivers/hwmon/chipcap2.c                                                      |  238 -
 drivers/hwmon/coretemp.c                                                      |   19 
 drivers/hwmon/sht15.c                                                         |   26 
 drivers/hwmon/tmp108.c                                                        |   65 
 drivers/iio/accel/bma220_spi.c                                                |    3 
 drivers/iio/accel/kionix-kx022a.h                                             |    2 
 drivers/iio/dac/ad5758.c                                                      |    8 
 drivers/iio/humidity/hts221_core.c                                            |  106 
 drivers/iio/imu/adis16400.c                                                   |    5 
 drivers/iio/pressure/rohm-bm1390.c                                            |    4 
 drivers/iio/temperature/tmp117.c                                              |    9 
 drivers/infiniband/core/device.c                                              |    2 
 drivers/infiniband/core/lag.c                                                 |   14 
 drivers/infiniband/core/mad.c                                                 |    2 
 drivers/infiniband/core/mad_rmpp.c                                            |    7 
 drivers/infiniband/core/nldev.c                                               |    5 
 drivers/infiniband/core/restrack.c                                            |    3 
 drivers/infiniband/core/sysfs.c                                               |    9 
 drivers/infiniband/core/uverbs_std_types_device.c                             |    1 
 drivers/infiniband/core/uverbs_std_types_wq.c                                 |    2 
 drivers/infiniband/core/verbs.c                                               |    3 
 drivers/infiniband/hw/bnxt_re/hw_counters.c                                   |    6 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                      |   58 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                                     |    9 
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                                      |    2 
 drivers/infiniband/hw/cxgb4/cm.c                                              |    5 
 drivers/infiniband/hw/cxgb4/provider.c                                        |    5 
 drivers/infiniband/hw/efa/efa_com.c                                           |   28 
 drivers/infiniband/hw/erdma/erdma_main.c                                      |    4 
 drivers/infiniband/hw/erdma/erdma_verbs.c                                     |   16 
 drivers/infiniband/hw/hfi1/sdma.c                                             |    3 
 drivers/infiniband/hw/hfi1/verbs.c                                            |    4 
 drivers/infiniband/hw/hns/hns_roce_cq.c                                       |    1 
 drivers/infiniband/hw/hns/hns_roce_device.h                                   |    1 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                    |   55 
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
 drivers/infiniband/sw/rxe/rxe_mw.c                                            |    3 
 drivers/infiniband/sw/rxe/rxe_net.c                                           |   70 
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
 drivers/interconnect/qcom/icc-rpm.c                                           |   11 
 drivers/interconnect/qcom/icc-rpm.h                                           |    4 
 drivers/interconnect/qcom/smd-rpm.c                                           |    8 
 drivers/interconnect/samsung/exynos.c                                         |    1 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c                              |    4 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                                   |    6 
 drivers/iommu/intel/dmar.c                                                    |   72 
 drivers/irqchip/irq-gic-common.c                                              |    2 
 drivers/irqchip/irq-gic-v3-its.c                                              |  156 
 drivers/irqchip/irq-gic-v3.c                                                  |   15 
 drivers/irqchip/irq-gic.c                                                     |    4 
 drivers/irqchip/irq-riscv-imsic-state.c                                       |   21 
 drivers/leds/led-class-flash.c                                                |    2 
 drivers/leds/leds-lm3692x.c                                                   |    4 
 drivers/leds/leds-lp8860.c                                                    |    5 
 drivers/leds/leds-pca9532.c                                                   |    9 
 drivers/mailbox/arm_mhuv2.c                                                   |    9 
 drivers/mailbox/pcc.c                                                         |    5 
 drivers/mailbox/qcom-cpucp-mbox.c                                             |   37 
 drivers/mailbox/qcom-ipcc.c                                                   |    1 
 drivers/mailbox/ti-msgmgr.c                                                   |   14 
 drivers/md/dm-snap.c                                                          |   18 
 drivers/md/md.c                                                               |   30 
 drivers/md/raid10.c                                                           |    3 
 drivers/md/raid5-cache.c                                                      |   14 
 drivers/md/raid5-ppl.c                                                        |   12 
 drivers/md/raid5.c                                                            |   65 
 drivers/media/i2c/ar0521.c                                                    |    1 
 drivers/media/i2c/ov5648.c                                                    |    4 
 drivers/media/platform/qcom/venus/hfi_msgs.c                                  |    3 
 drivers/memory/brcmstb_dpfe.c                                                 |   17 
 drivers/memory/emif.c                                                         |    3 
 drivers/memory/samsung/exynos5422-dmc.c                                       |   11 
 drivers/mfd/da9150-core.c                                                     |    8 
 drivers/mfd/intel_quark_i2c_gpio.c                                            |   52 
 drivers/mfd/rk8xx-core.c                                                      |    2 
 drivers/misc/enclosure.c                                                      |    3 
 drivers/misc/nsm.c                                                            |    7 
 drivers/mtd/mtd_blkdevs.c                                                     |    5 
 drivers/mtd/nand/raw/pl35x-nand-controller.c                                  |    1 
 drivers/mtd/spi-nor/spansion.c                                                |    7 
 drivers/net/amt.c                                                             |    8 
 drivers/net/can/dev/skb.c                                                     |    2 
 drivers/net/dsa/mv88e6xxx/chip.c                                              |    8 
 drivers/net/ethernet/alacritech/slicoss.c                                     |    2 
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c                          |    2 
 drivers/net/ethernet/broadcom/asp2/bcmasp.c                                   |  121 
 drivers/net/ethernet/broadcom/asp2/bcmasp.h                                   |    4 
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c                              |   32 
 drivers/net/ethernet/broadcom/bgmac.c                                         |   47 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c                               |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                     |    8 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                                 |    1 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                                |  406 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                                |    3 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c                            |   80 
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c                                 |   12 
 drivers/net/ethernet/ibm/ibmveth.c                                            |   41 
 drivers/net/ethernet/intel/ice/ice_lib.c                                      |    4 
 drivers/net/ethernet/intel/ice/ice_ptp.c                                      |   49 
 drivers/net/ethernet/intel/ice/ice_ptp.h                                      |    6 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                           |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c                              |    2 
 drivers/net/ethernet/mellanox/mlx4/intf.c                                     |   15 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c                      |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c                         |    4 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.c        |    4 
 drivers/net/ethernet/microchip/fdma/fdma_api.c                                |   45 
 drivers/net/ethernet/microchip/fdma/fdma_api.h                                |   20 
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c                         |   17 
 drivers/net/ethernet/microchip/lan966x/lan966x_mac.c                          |    4 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c                         |   19 
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c                          |   10 
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c                           |   58 
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c                           |    7 
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h                           |    2 
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c                         |   15 
 drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c                           |   10 
 drivers/net/ethernet/netronome/nfp/flower/main.h                              |    2 
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c                       |   24 
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c                           |    1 
 drivers/net/ethernet/pensando/ionic/ionic_main.c                              |   13 
 drivers/net/ethernet/qlogic/qede/qede_filter.c                                |    2 
 drivers/net/ethernet/realtek/r8169_phy_config.c                               |    6 
 drivers/net/ethernet/stmicro/stmmac/common.h                                  |    4 
 drivers/net/ethernet/stmicro/stmmac/descs.h                                   |    6 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c                            |    2 
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c                                |   25 
 drivers/net/ethernet/stmicro/stmmac/hwif.h                                    |    6 
 drivers/net/ethernet/stmicro/stmmac/stmmac.h                                  |   10 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c                          |   39 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                             |   66 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c                        |    2 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                             |   86 
 drivers/net/gtp.c                                                             |   51 
 drivers/net/hamradio/hdlcdrv.c                                                |    5 
 drivers/net/loopback.c                                                        |    8 
 drivers/net/macsec.c                                                          |    5 
 drivers/net/phy/Kconfig                                                       |    5 
 drivers/net/phy/Makefile                                                      |    2 
 drivers/net/phy/marvell.c                                                     |   97 
 drivers/net/phy/qcom/qca83xx.c                                                |   58 
 drivers/net/phy/realtek.c                                                     | 1545 -------
 drivers/net/phy/realtek/Kconfig                                               |    5 
 drivers/net/phy/realtek/Makefile                                              |    3 
 drivers/net/phy/realtek/realtek_main.c                                        | 1648 ++++++++
 drivers/net/ppp/pppoe.c                                                       |    3 
 drivers/net/team/team_core.c                                                  |   11 
 drivers/net/tun.c                                                             |   10 
 drivers/net/usb/cdc_mbim.c                                                    |    5 
 drivers/net/usb/cdc_ncm.c                                                     |    7 
 drivers/net/usb/lan78xx.c                                                     |    9 
 drivers/net/usb/usbnet.c                                                      |   28 
 drivers/net/veth.c                                                            |    7 
 drivers/net/virtio_net.c                                                      |   12 
 drivers/net/wireless/ath/ath10k/htt_tx.c                                      |   12 
 drivers/net/wireless/ath/ath11k/Kconfig                                       |    3 
 drivers/net/wireless/ath/ath11k/ahb.c                                         |    1 
 drivers/net/wireless/ath/ath11k/ce.c                                          |    2 
 drivers/net/wireless/ath/ath11k/core.c                                        |   13 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                       |   19 
 drivers/net/wireless/ath/ath11k/mac.c                                         |   33 
 drivers/net/wireless/ath/ath11k/mac.h                                         |    2 
 drivers/net/wireless/ath/ath11k/wmi.c                                         |    9 
 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c                           |    2 
 drivers/net/wireless/ath/ath12k/mac.c                                         |   21 
 drivers/net/wireless/ath/ath12k/pci.c                                         |   55 
 drivers/net/wireless/ath/ath6kl/cfg80211.c                                    |    2 
 drivers/net/wireless/ath/carl9170/debug.c                                     |    5 
 drivers/net/wireless/ath/wil6210/txrx.h                                       |    4 
 drivers/net/wireless/broadcom/b43/debugfs.c                                   |    2 
 drivers/net/wireless/broadcom/b43legacy/debugfs.c                             |    2 
 drivers/net/wireless/marvell/mwifiex/cmdevt.c                                 |   10 
 drivers/net/wireless/marvell/mwifiex/fw.h                                     |    6 
 drivers/net/wireless/marvell/mwifiex/init.c                                   |    1 
 drivers/net/wireless/marvell/mwifiex/main.c                                   |    4 
 drivers/net/wireless/marvell/mwifiex/main.h                                   |    1 
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c                              |    3 
 drivers/net/wireless/mediatek/mt76/mac80211.c                                 |   11 
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c                               |   18 
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                               |   13 
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c                               |   17 
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                              |   11 
 drivers/net/wireless/mediatek/mt76/mt7915/coredump.c                          |    7 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                            |    6 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                              |    7 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                              |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                              |   47 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                               |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                            |    5 
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c                           |    4 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                              |   50 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                               |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h                            |    5 
 drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c                           |    6 
 drivers/net/wireless/mediatek/mt76/mt792x.h                                   |    2 
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c                               |    6 
 drivers/net/wireless/mediatek/mt76/mt7996/coredump.c                          |    7 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                              |    6 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                               |   46 
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c                               |    9 
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h                              |    8 
 drivers/net/wireless/mediatek/mt76/tx.c                                       |    7 
 drivers/net/wireless/mediatek/mt76/usb.c                                      |   16 
 drivers/net/wireless/realtek/rtl8xxxu/core.c                                  |   16 
 drivers/net/wireless/realtek/rtw88/debug.c                                    |    5 
 drivers/net/wireless/realtek/rtw88/sdio.c                                     |   12 
 drivers/net/wireless/silabs/wfx/bh.c                                          |    6 
 drivers/net/wireless/silabs/wfx/bus_sdio.c                                    |    1 
 drivers/net/wireless/silabs/wfx/main.c                                        |   36 
 drivers/nvdimm/pmem.c                                                         |    6 
 drivers/nvme/host/fabrics.c                                                   |   30 
 drivers/nvme/host/ioctl.c                                                     |    2 
 drivers/nvme/host/pr.c                                                        |  126 
 drivers/nvme/host/tcp.c                                                       |   10 
 drivers/nvme/target/admin-cmd.c                                               |    7 
 drivers/nvme/target/configfs.c                                                |   24 
 drivers/nvme/target/core.c                                                    |   23 
 drivers/nvme/target/fabrics-cmd-auth.c                                        |    9 
 drivers/nvme/target/fabrics-cmd.c                                             |    3 
 drivers/nvme/target/fc.c                                                      |   15 
 drivers/nvme/target/io-cmd-bdev.c                                             |   29 
 drivers/nvme/target/loop.c                                                    |    2 
 drivers/nvme/target/nvmet.h                                                   |    8 
 drivers/nvme/target/rdma.c                                                    |   26 
 drivers/nvme/target/tcp.c                                                     |    7 
 drivers/nvme/target/zns.c                                                     |   12 
 drivers/nvmem/layouts/onie-tlv.c                                              |    1 
 drivers/nvmem/layouts/sl28vpd.c                                               |    1 
 drivers/opp/of.c                                                              |    2 
 drivers/pci/controller/dwc/pci-dra7xx.c                                       |   22 
 drivers/pci/controller/dwc/pcie-qcom.c                                        |   90 
 drivers/pci/controller/pci-aardvark.c                                         |   31 
 drivers/pci/controller/pci-xgene.c                                            |   11 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                                 |    8 
 drivers/pci/iov.c                                                             |   25 
 drivers/pci/p2pdma.c                                                          |   10 
 drivers/pci/pci-label.c                                                       |   90 
 drivers/pci/pci.h                                                             |    4 
 drivers/pci/pcie/aer.c                                                        |   25 
 drivers/pci/probe.c                                                           |   15 
 drivers/pci/quirks.c                                                          |    2 
 drivers/pci/xen-pcifront.c                                                    |    5 
 drivers/perf/cxl_pmu.c                                                        |  100 
 drivers/perf/dwc_pcie_pmu.c                                                   |   11 
 drivers/perf/marvell_cn10k_tad_pmu.c                                          |    1 
 drivers/phy/cadence/phy-cadence-sierra.c                                      |   11 
 drivers/phy/hisilicon/phy-hi3670-pcie.c                                       |    4 
 drivers/phy/rockchip/phy-rockchip-usbdp.c                                     |  285 -
 drivers/pinctrl/mediatek/pinctrl-mt7629.c                                     |    2 
 drivers/pinctrl/nuvoton/pinctrl-ma35.c                                        |    8 
 drivers/pinctrl/sprd/pinctrl-sprd.c                                           |    3 
 drivers/pinctrl/stm32/Kconfig                                                 |    6 
 drivers/pinctrl/stm32/pinctrl-stm32.c                                         |   16 
 drivers/pinctrl/stm32/pinctrl-stm32.h                                         |   18 
 drivers/pinctrl/stm32/pinctrl-stm32mp257.c                                    |   11 
 drivers/pinctrl/sunplus/Kconfig                                               |    8 
 drivers/platform/chrome/cros_ec_proto.c                                       |   32 
 drivers/platform/chrome/cros_ec_proto_test.c                                  |  158 
 drivers/platform/chrome/cros_ec_typec.c                                       |   10 
 drivers/platform/cznic/turris-omnia-mcu-gpio.c                                |   31 
 drivers/platform/olpc/olpc-ec.c                                               |    2 
 drivers/platform/x86/amd/pmc/pmc.c                                            |    9 
 drivers/platform/x86/asus-wmi.c                                               |   32 
 drivers/platform/x86/gpd-pocket-fan.c                                         |    9 
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c                           |    7 
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c                     |    2 
 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c                        |    7 
 drivers/platform/x86/hp/hp-wmi.c                                              |   24 
 drivers/platform/x86/ibm_rtl.c                                                |    8 
 drivers/platform/x86/ideapad-laptop.c                                         |   12 
 drivers/platform/x86/intel/telemetry/core.c                                   |    4 
 drivers/platform/x86/msi-ec.c                                                 |    9 
 drivers/pmdomain/imx/scu-pd.c                                                 |   10 
 drivers/power/supply/ab8500_bmdata.c                                          |    2 
 drivers/power/supply/ab8500_btemp.c                                           |   28 
 drivers/power/supply/ab8500_chargalg.c                                        |    9 
 drivers/power/supply/ab8500_charger.c                                         |  400 +-
 drivers/power/supply/ab8500_fg.c                                              |   27 
 drivers/power/supply/bq24190_charger.c                                        |    9 
 drivers/power/supply/bq2515x_charger.c                                        |   15 
 drivers/power/supply/generic-adc-battery.c                                    |    3 
 drivers/power/supply/gpio-charger.c                                           |    5 
 drivers/power/supply/mm8013.c                                                 |    1 
 drivers/power/supply/qcom_battmgr.c                                           |   20 
 drivers/pwm/pwm-lp3943.c                                                      |    3 
 drivers/pwm/pwm-mtk-disp.c                                                    |    4 
 drivers/pwm/pwm-renesas-tpu.c                                                 |   23 
 drivers/regulator/ab8500.c                                                    |  159 
 drivers/regulator/fixed.c                                                     |    4 
 drivers/regulator/irq_helpers.c                                               |   38 
 drivers/regulator/mp886x.c                                                    |   13 
 drivers/regulator/qcom-rpmh-regulator.c                                       |    2 
 drivers/remoteproc/imx_dsp_rproc.c                                            |   58 
 drivers/remoteproc/imx_rproc.c                                                |   18 
 drivers/remoteproc/qcom_q6v5_adsp.c                                           |    2 
 drivers/remoteproc/remoteproc_core.c                                          |    3 
 drivers/remoteproc/xlnx_r5_remoteproc.c                                       |    8 
 drivers/rpmsg/mtk_rpmsg.c                                                     |    1 
 drivers/rpmsg/virtio_rpmsg_bus.c                                              |  118 
 drivers/rtc/Kconfig                                                           |   21 
 drivers/rtc/class.c                                                           |    8 
 drivers/rtc/rtc-abx80x.c                                                      |  103 
 drivers/rtc/rtc-bd70528.c                                                     |    5 
 drivers/rtc/rtc-ds1685.c                                                      |   20 
 drivers/rtc/rtc-ftrtc010.c                                                    |   85 
 drivers/rtc/rtc-mpfs.c                                                        |    4 
 drivers/rtc/rtc-s35390a.c                                                     |  147 
 drivers/s390/virtio/virtio_ccw.c                                              |    6 
 drivers/scsi/ch.c                                                             |    2 
 drivers/scsi/device_handler/scsi_dh_hp_sw.c                                   |    4 
 drivers/scsi/device_handler/scsi_dh_rdac.c                                    |   10 
 drivers/scsi/elx/libefc/efclib.c                                              |    2 
 drivers/scsi/hisi_sas/hisi_sas.h                                              |    3 
 drivers/scsi/hisi_sas/hisi_sas_main.c                                         |   43 
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c                                        |    4 
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c                                        |    4 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                        |   13 
 drivers/scsi/libsas/sas_expander.c                                            |    5 
 drivers/scsi/libsas/sas_task.c                                                |    2 
 drivers/scsi/mpi3mr/mpi3mr.h                                                  |    2 
 drivers/scsi/mpi3mr/mpi3mr_app.c                                              |   47 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                               |   17 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                               |  161 
 drivers/scsi/mpi3mr/mpi3mr_transport.c                                        |   18 
 drivers/scsi/pm8001/pm8001_defs.h                                             |   98 
 drivers/scsi/pm8001/pm8001_hwi.c                                              |    2 
 drivers/scsi/pm8001/pm8001_hwi.h                                              |    4 
 drivers/scsi/pm8001/pm80xx_hwi.c                                              |    2 
 drivers/scsi/pm8001/pm80xx_hwi.h                                              |  100 
 drivers/scsi/scsi_debug.c                                                     |  415 +-
 drivers/scsi/scsi_lib.c                                                       |    6 
 drivers/scsi/scsi_lib_test.c                                                  |   25 
 drivers/scsi/scsi_scan.c                                                      |    8 
 drivers/scsi/scsi_transport_spi.c                                             |    2 
 drivers/scsi/sd.c                                                             |   20 
 drivers/scsi/ses.c                                                            |    8 
 drivers/scsi/st.c                                                             |   75 
 drivers/soc/qcom/apr.c                                                        |   44 
 drivers/soc/qcom/pmic_glink.c                                                 |   73 
 drivers/soc/qcom/pmic_pdcharger_ulog.c                                        |    2 
 drivers/soc/tegra/flowctrl.c                                                  |    7 
 drivers/soundwire/intel_auxdevice.c                                           |    2 
 drivers/spi/spi-bcm63xx-hsspi.c                                               |    1 
 drivers/spi/spi-fsl-spi.c                                                     |   22 
 drivers/spi/spi-mtk-nor.c                                                     |    1 
 drivers/spi/spi-mxic.c                                                        |    8 
 drivers/spi/spi-omap2-mcspi.c                                                 |  238 -
 drivers/spi/spi-rspi.c                                                        |   49 
 drivers/spi/spi-sh-msiof.c                                                    |   50 
 drivers/spi/spi-sun4i.c                                                       |   56 
 drivers/spi/spi-tegra114.c                                                    |   49 
 drivers/spi/spi.c                                                             |    2 
 drivers/spmi/spmi-pmic-arb.c                                                  |    2 
 drivers/staging/iio/adc/ad7816.c                                              |   33 
 drivers/staging/octeon/ethernet-tx.c                                          |    2 
 drivers/staging/rtl8723bs/core/rtw_mlme.c                                     |   13 
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                                 |    9 
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c                                  |    6 
 drivers/staging/rtl8723bs/core/rtw_recv.c                                     |   53 
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c                                  |    4 
 drivers/staging/rtl8723bs/hal/hal_com.c                                       |   20 
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c                             |   16 
 drivers/staging/rtl8723bs/hal/sdio_halinit.c                                  |    8 
 drivers/staging/rtl8723bs/include/drv_types.h                                 |   41 
 drivers/staging/rtl8723bs/include/recv_osdep.h                                |    4 
 drivers/staging/rtl8723bs/os_dep/os_intfs.c                                   |   21 
 drivers/staging/rtl8723bs/os_dep/recv_linux.c                                 |   44 
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c                                  |   45 
 drivers/staging/sm750fb/sm750.c                                               |   10 
 drivers/target/target_core_device.c                                           |   87 
 drivers/target/target_core_stat.c                                             |   69 
 drivers/target/target_core_tpg.c                                              |   10 
 drivers/thermal/gov_power_allocator.c                                         |    7 
 drivers/thermal/sprd_thermal.c                                                |    6 
 drivers/thermal/thermal_trace.h                                               |    4 
 drivers/thermal/ti-soc-thermal/ti-bandgap.c                                   |   10 
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c                            |    4 
 drivers/tty/serial/8250/8250_aspeed_vuart.c                                   |    2 
 drivers/tty/serial/8250/8250_bcm2835aux.c                                     |    2 
 drivers/tty/serial/8250/8250_bcm7271.c                                        |    2 
 drivers/tty/serial/8250/8250_dw.c                                             |    2 
 drivers/tty/serial/8250/8250_em.c                                             |    2 
 drivers/tty/serial/8250/8250_fsl.c                                            |    2 
 drivers/tty/serial/8250/8250_ingenic.c                                        |    2 
 drivers/tty/serial/8250/8250_ioc3.c                                           |    2 
 drivers/tty/serial/8250/8250_lpc18xx.c                                        |    2 
 drivers/tty/serial/8250/8250_mtk.c                                            |    2 
 drivers/tty/serial/8250/8250_of.c                                             |    2 
 drivers/tty/serial/8250/8250_omap.c                                           |    2 
 drivers/tty/serial/8250/8250_platform.c                                       |    2 
 drivers/tty/serial/8250/8250_pxa.c                                            |    2 
 drivers/tty/serial/8250/8250_tegra.c                                          |    2 
 drivers/tty/serial/8250/8250_uniphier.c                                       |   12 
 drivers/tty/serial/Kconfig                                                    |    1 
 drivers/tty/serial/altera_jtaguart.c                                          |    2 
 drivers/tty/serial/altera_uart.c                                              |    2 
 drivers/tty/serial/amba-pl011.c                                               |    2 
 drivers/tty/serial/ar933x_uart.c                                              |    2 
 drivers/tty/serial/atmel_serial.c                                             |    2 
 drivers/tty/serial/bcm63xx_uart.c                                             |    2 
 drivers/tty/serial/clps711x.c                                                 |    2 
 drivers/tty/serial/cpm_uart.c                                                 |    2 
 drivers/tty/serial/digicolor-usart.c                                          |    2 
 drivers/tty/serial/esp32_acm.c                                                |    2 
 drivers/tty/serial/esp32_uart.c                                               |    2 
 drivers/tty/serial/fsl_linflexuart.c                                          |    2 
 drivers/tty/serial/fsl_lpuart.c                                               |    2 
 drivers/tty/serial/imx.c                                                      |    2 
 drivers/tty/serial/lantiq.c                                                   |    2 
 drivers/tty/serial/liteuart.c                                                 |    2 
 drivers/tty/serial/lpc32xx_hs.c                                               |    2 
 drivers/tty/serial/ma35d1_serial.c                                            |    4 
 drivers/tty/serial/max310x.c                                                  |  185 
 drivers/tty/serial/mcf.c                                                      |    2 
 drivers/tty/serial/meson_uart.c                                               |    2 
 drivers/tty/serial/milbeaut_usio.c                                            |    2 
 drivers/tty/serial/mpc52xx_uart.c                                             |    2 
 drivers/tty/serial/msm_serial.c                                               |    2 
 drivers/tty/serial/mxs-auart.c                                                |    2 
 drivers/tty/serial/omap-serial.c                                              |    2 
 drivers/tty/serial/owl-uart.c                                                 |    2 
 drivers/tty/serial/pic32_uart.c                                               |    2 
 drivers/tty/serial/pmac_zilog.c                                               |    3 
 drivers/tty/serial/qcom_geni_serial.c                                         |    2 
 drivers/tty/serial/rda-uart.c                                                 |    2 
 drivers/tty/serial/sa1100.c                                                   |    2 
 drivers/tty/serial/samsung_tty.c                                              |    2 
 drivers/tty/serial/sccnxp.c                                                   |    2 
 drivers/tty/serial/serial-tegra.c                                             |    2 
 drivers/tty/serial/serial_txx9.c                                              |   55 
 drivers/tty/serial/sh-sci.c                                                   |    2 
 drivers/tty/serial/sifive.c                                                   |    4 
 drivers/tty/serial/sprd_serial.c                                              |    2 
 drivers/tty/serial/st-asc.c                                                   |    2 
 drivers/tty/serial/stm32-usart.c                                              |    2 
 drivers/tty/serial/sunhv.c                                                    |    2 
 drivers/tty/serial/sunplus-uart.c                                             |    2 
 drivers/tty/serial/sunsab.c                                                   |    2 
 drivers/tty/serial/sunsu.c                                                    |    2 
 drivers/tty/serial/sunzilog.c                                                 |    2 
 drivers/tty/serial/tegra-tcu.c                                                |    2 
 drivers/tty/serial/timbuart.c                                                 |    2 
 drivers/tty/serial/uartlite.c                                                 |    2 
 drivers/tty/serial/ucc_uart.c                                                 |    2 
 drivers/tty/serial/xilinx_uartps.c                                            |    2 
 drivers/usb/gadget/composite.c                                                |    2 
 drivers/usb/gadget/function/f_mass_storage.c                                  |    7 
 drivers/usb/gadget/udc/dummy_hcd.c                                            |    4 
 drivers/usb/host/pci-quirks.c                                                 |    1 
 drivers/usb/host/xhci-dbgtty.c                                                |    2 
 drivers/usb/image/microtek.c                                                  |    1 
 drivers/usb/mon/mon_main.c                                                    |    3 
 drivers/usb/musb/da8xx.c                                                      |    8 
 drivers/usb/storage/alauda.c                                                  |   95 
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c                                          |    9 
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c                                          |    9 
 drivers/vfio/cdx/main.c                                                       |   10 
 drivers/vfio/fsl-mc/vfio_fsl_mc.c                                             |   10 
 drivers/vfio/pci/vfio_pci_core.c                                              |    1 
 drivers/vfio/platform/vfio_platform_common.c                                  |   10 
 drivers/vhost/scsi.c                                                          |   31 
 drivers/vhost/vringh.c                                                        |    4 
 drivers/video/fbdev/core/fbcon.c                                              |   57 
 drivers/video/fbdev/gxt4500.c                                                 |    1 
 drivers/video/fbdev/kyro/fbdev.c                                              |   19 
 drivers/virtio/virtio.c                                                       |    2 
 drivers/virtio/virtio_pci_modern.c                                            |   12 
 fs/backing-file.c                                                             |   28 
 fs/btrfs/accessors.c                                                          |  123 
 fs/btrfs/accessors.h                                                          |   37 
 fs/btrfs/block-group.c                                                        |    6 
 fs/btrfs/ctree.c                                                              |   51 
 fs/btrfs/ctree.h                                                              |    2 
 fs/btrfs/defrag.c                                                             |    2 
 fs/btrfs/disk-io.c                                                            |    6 
 fs/btrfs/extent-io-tree.h                                                     |    7 
 fs/btrfs/extent-tree.c                                                        |    3 
 fs/btrfs/free-space-cache.c                                                   |   10 
 fs/btrfs/inode.c                                                              |   84 
 fs/btrfs/ioctl.c                                                              |   11 
 fs/btrfs/messages.c                                                           |    5 
 fs/btrfs/qgroup.c                                                             |    4 
 fs/btrfs/raid56.c                                                             |   11 
 fs/btrfs/relocation.c                                                         |    3 
 fs/btrfs/tests/inode-tests.c                                                  |   12 
 fs/btrfs/tree-mod-log.c                                                       |   13 
 fs/btrfs/verity.c                                                             |   31 
 fs/btrfs/zoned.c                                                              |    8 
 fs/ceph/addr.c                                                                |  100 
 fs/ceph/inode.c                                                               |    2 
 fs/ceph/mds_client.c                                                          |    2 
 fs/ceph/mds_client.h                                                          |    3 
 fs/ceph/super.c                                                               |   29 
 fs/ceph/super.h                                                               |    1 
 fs/dcache.c                                                                   |    2 
 fs/dlm/config.c                                                               |   30 
 fs/dlm/dlm_internal.h                                                         |    5 
 fs/dlm/lock.c                                                                 |   18 
 fs/dlm/lock.h                                                                 |    4 
 fs/eventpoll.c                                                                |   18 
 fs/ext2/file.c                                                                |    7 
 fs/f2fs/node.c                                                                |    4 
 fs/f2fs/super.c                                                               |   33 
 fs/fs-writeback.c                                                             |   17 
 fs/fs_pin.c                                                                   |   15 
 fs/fuse/file.c                                                                |    5 
 fs/gfs2/bmap.c                                                                |    2 
 fs/gfs2/inode.c                                                               |    2 
 fs/hfs/btree.c                                                                |    7 
 fs/hfsplus/btree.c                                                            |    7 
 fs/hugetlbfs/inode.c                                                          |    6 
 fs/isofs/dir.c                                                                |    4 
 fs/isofs/isofs.h                                                              |   11 
 fs/isofs/joliet.c                                                             |   27 
 fs/isofs/namei.c                                                              |    3 
 fs/kernfs/dir.c                                                               |   12 
 fs/kernfs/symlink.c                                                           |   17 
 fs/minix/inode.c                                                              |   16 
 fs/minix/minix.h                                                              |    9 
 fs/minix/namei.c                                                              |   29 
 fs/netfs/internal.h                                                           |   32 
 fs/nfs/dir.c                                                                  |   13 
 fs/nfs/filelayout/filelayout.c                                                |    5 
 fs/nfs/flexfilelayout/flexfilelayout.c                                        |   81 
 fs/nfs/fs_context.c                                                           |    1 
 fs/nfs/internal.h                                                             |   31 
 fs/nfs/nfs3proc.c                                                             |    8 
 fs/nfs/nfs4client.c                                                           |    7 
 fs/nfs/nfs4proc.c                                                             |    5 
 fs/nfs/nfs4xdr.c                                                              |    3 
 fs/nfs/pnfs.c                                                                 |   12 
 fs/nfs/proc.c                                                                 |    8 
 fs/nilfs2/namei.c                                                             |    8 
 fs/nilfs2/recovery.c                                                          |   17 
 fs/ntfs3/attrib.c                                                             |   10 
 fs/ntfs3/file.c                                                               |   35 
 fs/ntfs3/frecord.c                                                            |  180 
 fs/ntfs3/fsntfs.c                                                             |  126 
 fs/ntfs3/inode.c                                                              |   13 
 fs/ntfs3/ntfs_fs.h                                                            |   20 
 fs/ntfs3/xattr.c                                                              |    8 
 fs/ocfs2/cluster/heartbeat.c                                                  |   52 
 fs/ocfs2/cluster/tcp.c                                                        |    8 
 fs/ocfs2/dlmglue.c                                                            |   29 
 fs/ocfs2/dlmglue.h                                                            |    5 
 fs/ocfs2/export.c                                                             |   10 
 fs/ocfs2/inode.c                                                              |    5 
 fs/ocfs2/move_extents.c                                                       |   62 
 fs/ocfs2/namei.c                                                              |    6 
 fs/ocfs2/quota_local.c                                                        |   24 
 fs/ocfs2/xattr.c                                                              |  266 +
 fs/ocfs2/xattr.h                                                              |   12 
 fs/overlayfs/readdir.c                                                        |   41 
 fs/overlayfs/util.c                                                           |    2 
 fs/proc/generic.c                                                             |    4 
 fs/proc/kcore.c                                                               |    8 
 fs/pstore/ram.c                                                               |    1 
 fs/pstore/ram_core.c                                                          |    6 
 fs/quota/dquot.c                                                              |   10 
 fs/smb/client/cifspdu.h                                                       |   95 
 fs/smb/client/smb2ops.c                                                       |    8 
 fs/smb/client/smb2pdu.c                                                       |   14 
 fs/smb/client/smb2pdu.h                                                       |   69 
 fs/smb/common/smb2pdu.h                                                       |  230 +
 fs/smb/server/Kconfig                                                         |    1 
 fs/smb/server/oplock.c                                                        |    8 
 fs/smb/server/smb2ops.c                                                       |    6 
 fs/smb/server/smb2pdu.c                                                       |  186 
 fs/smb/server/smb2pdu.h                                                       |   58 
 fs/smb/server/smb_common.c                                                    |    4 
 fs/smb/server/smb_common.h                                                    |   75 
 fs/smb/server/smbacl.c                                                        |   41 
 fs/smb/server/vfs_cache.c                                                     |   15 
 fs/splice.c                                                                   |   43 
 fs/stat.c                                                                     |    4 
 fs/userfaultfd.c                                                              |   12 
 fs/xattr.c                                                                    |    2 
 fs/xfs/libxfs/xfs_bmap.c                                                      |   14 
 fs/xfs/libxfs/xfs_bmap.h                                                      |   10 
 include/acpi/acpi_bus.h                                                       |    9 
 include/acpi/acpi_drivers.h                                                   |    9 
 include/asm-generic/syscall.h                                                 |   14 
 include/dt-bindings/clock/qcom,dsi-phy-28nm.h                                 |    9 
 include/kvm/arm_vgic.h                                                        |    1 
 include/linux/acpi.h                                                          |   24 
 include/linux/blk-mq.h                                                        |    6 
 include/linux/bpf.h                                                           |    9 
 include/linux/clk-provider.h                                                  |   22 
 include/linux/efi.h                                                           |   21 
 include/linux/etherdevice.h                                                   |   28 
 include/linux/firewire.h                                                      |    1 
 include/linux/fortify-string.h                                                |    2 
 include/linux/if_bridge.h                                                     |   77 
 include/linux/mfd/da9150/core.h                                               |    1 
 include/linux/mm.h                                                            |   53 
 include/linux/mm_types.h                                                      |   13 
 include/linux/mmap_lock.h                                                     |   16 
 include/linux/mtd/spinand.h                                                   |    2 
 include/linux/pm_wakeirq.h                                                    |    6 
 include/linux/pm_wakeup.h                                                     |   17 
 include/linux/quotaops.h                                                      |    5 
 include/linux/shmem_fs.h                                                      |   15 
 include/linux/skbuff.h                                                        |   90 
 include/linux/slab.h                                                          |   62 
 include/linux/soc/ti/k3-ringacc.h                                             |   31 
 include/linux/sunrpc/svc_rdma.h                                               |    2 
 include/linux/userfaultfd_k.h                                                 |   21 
 include/linux/wait.h                                                          |    6 
 include/linux/watch_queue.h                                                   |    6 
 include/net/bluetooth/bluetooth.h                                             |    4 
 include/net/bluetooth/hci_sync.h                                              |    1 
 include/net/bluetooth/l2cap.h                                                 |    3 
 include/net/cfg80211.h                                                        |   12 
 include/net/cipso_ipv4.h                                                      |   11 
 include/net/inet_frag.h                                                       |    9 
 include/net/ip.h                                                              |    2 
 include/net/ip_vs.h                                                           |   50 
 include/net/netfilter/nf_conntrack_seqadj.h                                   |    1 
 include/net/netlabel.h                                                        |   11 
 include/net/seg6_hmac.h                                                       |    3 
 include/net/sock.h                                                            |    8 
 include/net/switchdev.h                                                       |    1 
 include/scsi/libsas.h                                                         |    8 
 include/scsi/scsi_cmnd.h                                                      |    7 
 include/scsi/scsi_common.h                                                    |   31 
 include/scsi/scsi_device.h                                                    |   37 
 include/scsi/scsi_proto.h                                                     |   65 
 include/scsi/scsi_sense.h                                                     |  950 ++++
 include/sound/control.h                                                       |    4 
 include/sound/core.h                                                          |   25 
 include/sound/pcm.h                                                           |    2 
 include/sound/pcm_oss.h                                                       |    1 
 include/sound/soc-component.h                                                 |    2 
 include/sound/ump.h                                                           |    6 
 include/target/target_core_base.h                                             |   20 
 include/trace/events/iocost.h                                                 |    7 
 include/trace/events/power.h                                                  |    3 
 include/uapi/linux/bpf.h                                                      |    1 
 include/uapi/linux/firewire-cdev.h                                            |    4 
 include/uapi/linux/iommufd.h                                                  |    2 
 include/uapi/sound/asequencer.h                                               |   12 
 init/main.c                                                                   |    8 
 io_uring/eventfd.c                                                            |    1 
 kernel/bpf/bpf_iter.c                                                         |   24 
 kernel/bpf/bpf_lsm.c                                                          |    4 
 kernel/bpf/btf.c                                                              |   27 
 kernel/bpf/core.c                                                             |   54 
 kernel/bpf/helpers.c                                                          |    1 
 kernel/bpf/offload.c                                                          |   25 
 kernel/bpf/syscall.c                                                          |  149 
 kernel/bpf/task_iter.c                                                        |    6 
 kernel/bpf/verifier.c                                                         |   42 
 kernel/cgroup/cpuset.c                                                        |   45 
 kernel/debug/kdb/kdb_io.c                                                     |    1 
 kernel/debug/kdb/kdb_main.c                                                   |    6 
 kernel/debug/kdb/kdb_private.h                                                |    3 
 kernel/fork.c                                                                 |   44 
 kernel/kcov.c                                                                 |   35 
 kernel/kexec_file.c                                                           |    4 
 kernel/module/tracking.c                                                      |    2 
 kernel/nsproxy.c                                                              |    2 
 kernel/profile.c                                                              |    2 
 kernel/rcu/rcutorture.c                                                       |    2 
 kernel/rcu/tree.c                                                             |   36 
 kernel/rcu/tree.h                                                             |    3 
 kernel/rcu/tree_exp.h                                                         |    2 
 kernel/rcu/tree_nocb.h                                                        |   62 
 kernel/reboot.c                                                               |    4 
 kernel/resource_kunit.c                                                       |    3 
 kernel/signal.c                                                               |    5 
 kernel/time/timeconv.c                                                        |    6 
 kernel/time/timer.c                                                           |    2 
 kernel/trace/bpf_trace.c                                                      |   80 
 kernel/trace/trace_btf.c                                                      |    3 
 kernel/trace/trace_events_hist.c                                              |   25 
 kernel/trace/trace_uprobe.c                                                   |    2 
 kernel/ucount.c                                                               |    7 
 kernel/watch_queue.c                                                          |    2 
 lib/Kconfig.debug                                                             |    1 
 lib/bitmap-str.c                                                              |   24 
 lib/decompress_unlz4.c                                                        |    4 
 lib/kobject.c                                                                 |    2 
 lib/maple_tree.c                                                              |   65 
 lib/test_hmm.c                                                                |    2 
 mm/cma.c                                                                      |    2 
 mm/damon/reclaim.c                                                            |    4 
 mm/filemap.c                                                                  |   31 
 mm/gup_test.c                                                                 |   17 
 mm/huge_memory.c                                                              |   11 
 mm/hugetlb.c                                                                  |   56 
 mm/internal.h                                                                 |    4 
 mm/khugepaged.c                                                               |   51 
 mm/ksm.c                                                                      |   40 
 mm/memcontrol.c                                                               |    2 
 mm/memory-tiers.c                                                             |   29 
 mm/memory.c                                                                   |  106 
 mm/memory_hotplug.c                                                           |    6 
 mm/mmap.c                                                                     |    3 
 mm/mmap_lock.c                                                                |   39 
 mm/mremap.c                                                                   |   32 
 mm/oom_kill.c                                                                 |   22 
 mm/page_alloc.c                                                               |    4 
 mm/rmap.c                                                                     |   20 
 mm/shmem.c                                                                    |   40 
 mm/slab_common.c                                                              |   18 
 mm/truncate.c                                                                 |    7 
 mm/userfaultfd.c                                                              |   14 
 mm/util.c                                                                     |   13 
 mm/vma.c                                                                      |   66 
 net/9p/trans_xen.c                                                            |    4 
 net/bluetooth/6lowpan.c                                                       |    3 
 net/bluetooth/hci_core.c                                                      |    4 
 net/bluetooth/hci_event.c                                                     |   58 
 net/bluetooth/hci_sync.c                                                      |   47 
 net/bluetooth/iso.c                                                           |    3 
 net/bluetooth/l2cap_core.c                                                    |   24 
 net/bluetooth/mgmt.c                                                          |  115 
 net/bluetooth/msft.c                                                          |    6 
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
 net/ceph/messenger_v1.c                                                       |    8 
 net/ceph/osdmap.c                                                             |    2 
 net/core/bpf_sk_storage.c                                                     |    7 
 net/core/dev.c                                                                |   20 
 net/core/filter.c                                                             |   58 
 net/core/gro.c                                                                |    5 
 net/core/lwtunnel.c                                                           |    6 
 net/core/selftests.c                                                          |    2 
 net/core/skbuff.c                                                             |   11 
 net/core/sock.c                                                               |    1 
 net/dcb/dcbnl.c                                                               |    2 
 net/devlink/region.c                                                          |    5 
 net/ipv4/cipso_ipv4.c                                                         |   16 
 net/ipv4/devinet.c                                                            |   35 
 net/ipv4/gre_offload.c                                                        |    2 
 net/ipv4/inet_fragment.c                                                      |   66 
 net/ipv4/ip_fragment.c                                                        |   13 
 net/ipv4/ip_output.c                                                          |   15 
 net/ipv4/ip_tunnel.c                                                          |   14 
 net/ipv4/ipmr.c                                                               |    5 
 net/ipv4/tcp.c                                                                |   14 
 net/ipv4/tcp_bic.c                                                            |   14 
 net/ipv4/tcp_cubic.c                                                          |   14 
 net/ipv4/tcp_hybla.c                                                          |   16 
 net/ipv4/tcp_ipv4.c                                                           |   10 
 net/ipv4/tcp_metrics.c                                                        |   20 
 net/ipv4/tcp_offload.c                                                        |   12 
 net/ipv6/calipso.c                                                            |    6 
 net/ipv6/exthdrs.c                                                            |    2 
 net/ipv6/netfilter/nf_conntrack_reasm.c                                       |   15 
 net/ipv6/reassembly.c                                                         |   13 
 net/ipv6/route.c                                                              |   20 
 net/ipv6/seg6_hmac.c                                                          |    5 
 net/ipv6/seg6_local.c                                                         |    6 
 net/ipv6/sit.c                                                                |    4 
 net/l2tp/l2tp_core.c                                                          |   51 
 net/l2tp/l2tp_core.h                                                          |    6 
 net/l2tp/l2tp_debugfs.c                                                       |    4 
 net/l2tp/l2tp_netlink.c                                                       |   11 
 net/l2tp/l2tp_ppp.c                                                           |    8 
 net/mac80211/cfg.c                                                            |   49 
 net/mac80211/debugfs.c                                                        |    2 
 net/mac80211/ieee80211_i.h                                                    |    3 
 net/mac80211/main.c                                                           |    2 
 net/mac80211/mesh.c                                                           |    3 
 net/mac80211/mesh_pathtbl.c                                                   |   17 
 net/mac80211/rx.c                                                             |    1 
 net/mac80211/tx.c                                                             |  223 -
 net/mctp/route.c                                                              |   10 
 net/mptcp/options.c                                                           |    9 
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
 net/netfilter/nf_conntrack_seqadj.c                                           |   17 
 net/netfilter/nf_flow_table_ip.c                                              |   30 
 net/netfilter/nf_synproxy_core.c                                              |    4 
 net/netfilter/nft_compat.c                                                    |   15 
 net/netfilter/xt_dccp.c                                                       |    2 
 net/netlabel/netlabel_kapi.c                                                  |   24 
 net/netlink/af_netlink.c                                                      |   12 
 net/openvswitch/actions.c                                                     |    9 
 net/openvswitch/vport-internal_dev.c                                          |    8 
 net/rds/af_rds.c                                                              |   29 
 net/rds/bind.c                                                                |    4 
 net/rds/ib_sysctl.c                                                           |    2 
 net/rds/rdma_transport.c                                                      |    3 
 net/rds/rds.h                                                                 |    3 
 net/rds/recv.c                                                                |   11 
 net/rds/send.c                                                                |    9 
 net/rds/sysctl.c                                                              |    2 
 net/rds/tcp.c                                                                 |    5 
 net/rose/af_rose.c                                                            |   56 
 net/rose/rose_link.c                                                          |    7 
 net/rose/rose_loopback.c                                                      |    7 
 net/rose/rose_route.c                                                         |   65 
 net/rxrpc/rxperf.c                                                            |   12 
 net/sched/act_api.c                                                           |   24 
 net/sched/sch_etf.c                                                           |    1 
 net/sched/sch_gred.c                                                          |   16 
 net/sched/sch_taprio.c                                                        |    6 
 net/sctp/ipv6.c                                                               |    6 
 net/sctp/sm_make_chunk.c                                                      |   24 
 net/sctp/sm_statefuns.c                                                       |    2 
 net/smc/smc_pnet.c                                                            |   29 
 net/sunrpc/xprtsock.c                                                         |   34 
 net/switchdev/switchdev.c                                                     |    2 
 net/tipc/bearer.c                                                             |    4 
 net/tipc/node.c                                                               |    2 
 net/tls/tls_device.c                                                          |   21 
 net/tls/tls_main.c                                                            |    4 
 net/wireless/nl80211.c                                                        |    6 
 net/wireless/reg.c                                                            |   41 
 net/wireless/sme.c                                                            |   38 
 scripts/Makefile.vmlinux_o                                                    |    2 
 scripts/checkkconfigsymbols.py                                                |    2 
 scripts/checkpatch.pl                                                         |    2 
 scripts/clang-tools/run-clang-tools.py                                        |    1 
 scripts/gdb/linux/radixtree.py                                                |  197 -
 scripts/gdb/linux/stackdepot.py                                               |    2 
 scripts/kconfig/conf.c                                                        |   19 
 scripts/kconfig/symbol.c                                                      |   39 
 scripts/kconfig/tests/conftest.py                                             |    9 
 scripts/kconfig/tests/randconfig_probability/Kconfig                          |   12 
 scripts/kconfig/tests/randconfig_probability/__init__.py                      |  130 
 scripts/kconfig/tests/savedefconfig_range/Kconfig                             |   60 
 scripts/kconfig/tests/savedefconfig_range/__init__.py                         |    8 
 scripts/kconfig/tests/savedefconfig_range/config                              |    7 
 scripts/make_fit.py                                                           |    3 
 security/apparmor/apparmorfs.c                                                |   21 
 security/apparmor/domain.c                                                    |    9 
 security/apparmor/file.c                                                      |   23 
 security/apparmor/include/file.h                                              |    5 
 security/apparmor/include/lib.h                                               |    1 
 security/apparmor/include/match.h                                             |   19 
 security/apparmor/include/policy.h                                            |   27 
 security/apparmor/label.c                                                     |   14 
 security/apparmor/lib.c                                                       |   23 
 security/apparmor/lsm.c                                                       |   19 
 security/apparmor/match.c                                                     |  158 
 security/apparmor/net.c                                                       |    1 
 security/apparmor/policy.c                                                    |    3 
 security/apparmor/policy_compat.c                                             |    6 
 security/apparmor/policy_ns.c                                                 |    6 
 security/apparmor/policy_unpack.c                                             |   57 
 security/integrity/ima/ima_template.c                                         |    5 
 security/ipe/audit.c                                                          |    8 
 security/security.c                                                           |    3 
 security/selinux/netlabel.c                                                   |    5 
 security/smack/smack_lsm.c                                                    |   14 
 sound/core/control.c                                                          |   12 
 sound/core/control_compat.c                                                   |   21 
 sound/core/control_led.c                                                      |   74 
 sound/core/ctljack.c                                                          |    1 
 sound/core/info.c                                                             |    3 
 sound/core/init.c                                                             |   33 
 sound/core/jack.c                                                             |   11 
 sound/core/misc.c                                                             |   27 
 sound/core/oss/mixer_oss.c                                                    |   36 
 sound/core/oss/pcm_oss.c                                                      |   12 
 sound/core/pcm.c                                                              |   13 
 sound/core/pcm_compat.c                                                       |    4 
 sound/core/pcm_lib.c                                                          |   16 
 sound/core/pcm_local.h                                                        |    6 
 sound/core/pcm_native.c                                                       |  122 
 sound/core/rawmidi.c                                                          |    3 
 sound/core/seq/seq_clientmgr.c                                                |   12 
 sound/core/seq/seq_compat.c                                                   |   15 
 sound/core/seq/seq_system.c                                                   |    9 
 sound/core/seq/seq_system.h                                                   |   35 
 sound/core/seq/seq_ump_client.c                                               |   45 
 sound/core/timer.c                                                            |    1 
 sound/core/ump.c                                                              |   80 
 sound/core/vmaster.c                                                          |   10 
 sound/drivers/aloop.c                                                         |   17 
 sound/drivers/pcmtest.c                                                       |   28 
 sound/hda/hdac_bus.c                                                          |    9 
 sound/pci/hda/hda_codec.c                                                     |    2 
 sound/pci/hda/hda_controller.h                                                |    4 
 sound/pci/hda/hda_intel.c                                                     |   91 
 sound/pci/hda/hda_jack.c                                                      |    9 
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
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c                                 |   14 
 sound/soc/amd/ps/ps-pdm-dma.c                                                 |    2 
 sound/soc/amd/ps/ps-sdw-dma.c                                                 |    2 
 sound/soc/amd/raven/acp3x-pcm-dma.c                                           |    4 
 sound/soc/amd/renoir/acp3x-pdm-dma.c                                          |    2 
 sound/soc/amd/vangogh/acp5x-pcm-dma.c                                         |    2 
 sound/soc/amd/yc/acp6x-pdm-dma.c                                              |    2 
 sound/soc/atmel/atmel-i2s.c                                                   |   43 
 sound/soc/atmel/atmel-pcm-pdc.c                                               |    2 
 sound/soc/codecs/adau17x1.c                                                   |    4 
 sound/soc/codecs/ak4642.c                                                     |    3 
 sound/soc/codecs/cs42l56.c                                                    |    1 
 sound/soc/codecs/da732x.c                                                     |    2 
 sound/soc/codecs/es8316.c                                                     |    4 
 sound/soc/codecs/es8326.c                                                     |   22 
 sound/soc/codecs/mt6359-accdet.c                                              |   50 
 sound/soc/codecs/nau8540.c                                                    |    4 
 sound/soc/codecs/rt1011.c                                                     |    4 
 sound/soc/codecs/rt1016.c                                                     |    4 
 sound/soc/codecs/rt1305.c                                                     |    4 
 sound/soc/codecs/rt1308.c                                                     |    4 
 sound/soc/codecs/rt1318.c                                                     |    3 
 sound/soc/codecs/rt5616.c                                                     |    3 
 sound/soc/codecs/rt5659.c                                                     |   10 
 sound/soc/codecs/rt5660.c                                                     |    4 
 sound/soc/codecs/rt5665.c                                                     |    4 
 sound/soc/codecs/rt5682-sdw.c                                                 |    3 
 sound/soc/codecs/rt711-sdca-sdw.c                                             |    6 
 sound/soc/codecs/rt711-sdw.c                                                  |    8 
 sound/soc/codecs/rt712-sdca-sdw.c                                             |    6 
 sound/soc/codecs/rt712-sdca.c                                                 |    5 
 sound/soc/codecs/rt722-sdca-sdw.c                                             |    6 
 sound/soc/codecs/sta32x.c                                                     |   20 
 sound/soc/codecs/sta350.c                                                     |   20 
 sound/soc/codecs/tlv320adc3xxx.c                                              |    2 
 sound/soc/codecs/tlv320aic32x4-clk.c                                          |   68 
 sound/soc/codecs/tlv320aic32x4-i2c.c                                          |   21 
 sound/soc/codecs/tlv320aic32x4-spi.c                                          |   25 
 sound/soc/codecs/tlv320aic32x4.c                                              |  283 -
 sound/soc/codecs/tlv320aic32x4.h                                              |    6 
 sound/soc/codecs/wcd-mbhc-v2.c                                                |    8 
 sound/soc/codecs/wcd937x.c                                                    |   44 
 sound/soc/codecs/wm5100.c                                                     |    2 
 sound/soc/codecs/wm8510.c                                                     |    2 
 sound/soc/codecs/wm8737.c                                                     |    8 
 sound/soc/codecs/wm8750.c                                                     |    2 
 sound/soc/codecs/wm8955.c                                                     |    2 
 sound/soc/codecs/wm8983.c                                                     |    2 
 sound/soc/codecs/wm8985.c                                                     |    2 
 sound/soc/codecs/wm8990.c                                                     |   10 
 sound/soc/codecs/wm8991.c                                                     |   10 
 sound/soc/codecs/wm8994.c                                                     |  159 
 sound/soc/codecs/wm8994.h                                                     |    2 
 sound/soc/codecs/wm_hubs.c                                                    |    2 
 sound/soc/codecs/wsa883x.c                                                    |    8 
 sound/soc/codecs/wsa884x.c                                                    |    8 
 sound/soc/dwc/dwc-i2s.c                                                       |    6 
 sound/soc/fsl/fsl_asrc.c                                                      |    8 
 sound/soc/fsl/fsl_asrc_dma.c                                                  |    5 
 sound/soc/fsl/imx-pcm-rpmsg.c                                                 |    2 
 sound/soc/intel/atom/sst-atom-controls.c                                      |   38 
 sound/soc/intel/atom/sst-mfld-platform-pcm.c                                  |   36 
 sound/soc/intel/avs/pcm.c                                                     |    2 
 sound/soc/intel/avs/utils.c                                                   |    6 
 sound/soc/mediatek/common/mtk-afe-fe-dai.c                                    |    8 
 sound/soc/mediatek/common/mtk-soundcard-driver.c                              |   23 
 sound/soc/mediatek/mt2701/mt2701-cs42448.c                                    |   20 
 sound/soc/mediatek/mt2701/mt2701-wm8960.c                                     |    6 
 sound/soc/mediatek/mt6797/mt6797-afe-clk.c                                    |   14 
 sound/soc/mediatek/mt6797/mt6797-mt6351.c                                     |   24 
 sound/soc/mediatek/mt7986/mt7986-wm8960.c                                     |    6 
 sound/soc/mediatek/mt8173/mt8173-max98090.c                                   |    6 
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c                              |    6 
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c                              |   10 
 sound/soc/mediatek/mt8173/mt8173-rt5650.c                                     |   10 
 sound/soc/mediatek/mt8183/mt8183-afe-clk.c                                    |   22 
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c                            |   34 
 sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c                    |   34 
 sound/soc/mediatek/mt8186/mt8186-afe-clk.c                                    |   95 
 sound/soc/mediatek/mt8186/mt8186-mt6366.c                                     |   86 
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c                                    |  104 
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c                                    |   24 
 sound/soc/mediatek/mt8188/mt8188-mt6359.c                                     |   61 
 sound/soc/mediatek/mt8192/mt8192-afe-clk.c                                    |  139 
 sound/soc/mediatek/mt8192/mt8192-afe-gpio.c                                   |   90 
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c                                    |    6 
 sound/soc/mediatek/mt8192/mt8192-dai-adda.c                                   |   44 
 sound/soc/mediatek/mt8192/mt8192-dai-i2s.c                                    |   20 
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c                                    |   18 
 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c                       |  115 
 sound/soc/mediatek/mt8195/mt8195-afe-clk.c                                    |   77 
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c                                    |   98 
 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c                                   |   99 
 sound/soc/mediatek/mt8195/mt8195-mt6359.c                                     |   60 
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c                                    |    7 
 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c                                    |    2 
 sound/soc/mediatek/mt8365/mt8365-mt6357.c                                     |   14 
 sound/soc/qcom/qdsp6/q6apm.c                                                  |    1 
 sound/soc/qcom/sdm845.c                                                       |   26 
 sound/soc/rockchip/rk3288_hdmi_analog.c                                       |   48 
 sound/soc/rockchip/rockchip_i2s.c                                             |    4 
 sound/soc/samsung/midas_wm1811.c                                              |   14 
 sound/soc/soc-ac97.c                                                          |    4 
 sound/soc/soc-card-test.c                                                     |    7 
 sound/soc/soc-component.c                                                     |    2 
 sound/soc/soc-link.c                                                          |   10 
 sound/soc/soc-ops.c                                                           |   10 
 sound/soc/soc-topology-test.c                                                 |    8 
 sound/soc/sof/imx/imx-common.c                                                |    1 
 sound/soc/xilinx/xlnx_formatter_pcm.c                                         |   18 
 sound/usb/6fire/control.c                                                     |    7 
 sound/usb/caiaq/device.c                                                      |    9 
 sound/usb/caiaq/device.h                                                      |    6 
 sound/usb/caiaq/input.c                                                       |   29 
 sound/usb/caiaq/midi.c                                                        |    2 
 sound/usb/line6/capture.c                                                     |    3 
 sound/usb/line6/pcm.c                                                         |    8 
 sound/usb/mixer.c                                                             |  151 
 sound/usb/mixer.h                                                             |    6 
 sound/usb/mixer_quirks.c                                                      |    2 
 sound/usb/mixer_us16x08.c                                                     |   19 
 sound/usb/quirks-table.h                                                      |    2 
 sound/usb/usx2y/us122l.c                                                      |    2 
 sound/virtio/virtio_pcm.h                                                     |    2 
 sound/virtio/virtio_pcm_msg.c                                                 |   19 
 sound/virtio/virtio_pcm_ops.c                                                 |    1 
 tools/bpf/bpftool/common.c                                                    |   40 
 tools/bpf/bpftool/gen.c                                                       |   91 
 tools/bpf/bpftool/link.c                                                      |   18 
 tools/bpf/bpftool/main.c                                                      |   24 
 tools/bpf/bpftool/main.h                                                      |    1 
 tools/bpf/bpftool/map.c                                                       |  101 
 tools/bpf/bpftool/prog.c                                                      |    2 
 tools/bpf/bpftool/tracelog.c                                                  |    2 
 tools/cgroup/iocost_monitor.py                                                |    7 
 tools/cgroup/memcg_shrinker.py                                                |    2 
 tools/hv/vmbus_bufring.c                                                      |    6 
 tools/include/linux/types.h                                                   |    5 
 tools/include/nolibc/stdlib.h                                                 |    8 
 tools/include/nolibc/types.h                                                  |    2 
 tools/include/uapi/linux/bpf.h                                                |    1 
 tools/lib/bpf/btf.c                                                           |  300 +
 tools/lib/bpf/btf.h                                                           |    3 
 tools/lib/bpf/btf_dump.c                                                      |    2 
 tools/lib/bpf/btf_relocate.c                                                  |    2 
 tools/lib/bpf/libbpf.c                                                        |   67 
 tools/lib/bpf/libbpf.map                                                      |    2 
 tools/lib/bpf/libbpf_internal.h                                               |   39 
 tools/lib/bpf/relo_core.c                                                     |    2 
 tools/lib/bpf/skel_internal.h                                                 |   64 
 tools/lib/perf/mmap.c                                                         |    2 
 tools/perf/Documentation/perf-c2c.txt                                         |    2 
 tools/perf/Makefile.perf                                                      |    2 
 tools/perf/arch/arm/tests/dwarf-unwind.c                                      |    3 
 tools/perf/arch/arm/util/unwind-libdw.c                                       |    2 
 tools/perf/arch/arm64/tests/dwarf-unwind.c                                    |    3 
 tools/perf/arch/arm64/util/unwind-libdw.c                                     |    2 
 tools/perf/arch/csky/util/unwind-libdw.c                                      |    2 
 tools/perf/arch/loongarch/util/unwind-libdw.c                                 |    2 
 tools/perf/arch/powerpc/tests/dwarf-unwind.c                                  |    3 
 tools/perf/arch/powerpc/util/unwind-libdw.c                                   |    2 
 tools/perf/arch/riscv/util/unwind-libdw.c                                     |    2 
 tools/perf/arch/s390/util/unwind-libdw.c                                      |    2 
 tools/perf/arch/x86/tests/dwarf-unwind.c                                      |    2 
 tools/perf/arch/x86/util/unwind-libdw.c                                       |    2 
 tools/perf/builtin-buildid-list.c                                             |    5 
 tools/perf/builtin-c2c.c                                                      |   16 
 tools/perf/builtin-kallsyms.c                                                 |   21 
 tools/perf/builtin-record.c                                                   |    4 
 tools/perf/builtin-script.c                                                   |   10 
 tools/perf/builtin-top.c                                                      |    8 
 tools/perf/builtin-trace.c                                                    |   44 
 tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json                 |    5 
 tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json          |    2 
 tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json              |    6 
 tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json                   |   68 
 tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json            |   10 
 tools/perf/tests/builtin-test.c                                               |   15 
 tools/perf/tests/code-reading.c                                               |   30 
 tools/perf/tests/dlfilter-test.c                                              |   51 
 tools/perf/tests/dwarf-unwind.c                                               |   47 
 tools/perf/tests/mmap-basic.c                                                 |    3 
 tools/perf/tests/mmap-thread-lookup.c                                         |    6 
 tools/perf/tests/openat-syscall-tp-fields.c                                   |    4 
 tools/perf/tests/parse-no-sample-id-all.c                                     |    6 
 tools/perf/tests/perf-record.c                                                |    2 
 tools/perf/tests/perf-time-to-tsc.c                                           |    2 
 tools/perf/tests/sample-parsing.c                                             |   62 
 tools/perf/tests/sigtrap.c                                                    |   20 
 tools/perf/tests/sw-clock.c                                                   |    3 
 tools/perf/tests/switch-tracking.c                                            |   14 
 tools/perf/tests/symbols.c                                                    |  104 
 tools/perf/ui/browsers/annotate-data.c                                        |    2 
 tools/perf/ui/tui/setup.c                                                     |    2 
 tools/perf/util/Build                                                         |    4 
 tools/perf/util/arm-spe.c                                                     |   24 
 tools/perf/util/arm64-frame-pointer-unwind-support.c                          |   29 
 tools/perf/util/auxtrace.c                                                    |   15 
 tools/perf/util/bpf-filter.c                                                  |   30 
 tools/perf/util/bpf-utils.h                                                   |    5 
 tools/perf/util/btf.c                                                         |   27 
 tools/perf/util/btf.h                                                         |   10 
 tools/perf/util/cs-etm.c                                                      |   60 
 tools/perf/util/debug.c                                                       |   75 
 tools/perf/util/debug.h                                                       |    1 
 tools/perf/util/env.c                                                         |    1 
 tools/perf/util/evsel.c                                                       |   21 
 tools/perf/util/header.c                                                      |   18 
 tools/perf/util/intel-bts.c                                                   |    4 
 tools/perf/util/intel-pt.c                                                    |  136 
 tools/perf/util/jitdump.c                                                     |  139 
 tools/perf/util/machine.c                                                     |   61 
 tools/perf/util/machine.h                                                     |    5 
 tools/perf/util/mem-events.c                                                  |    2 
 tools/perf/util/mmap.c                                                        |    3 
 tools/perf/util/print_insn.h                                                  |    1 
 tools/perf/util/probe-event.c                                                 |    5 
 tools/perf/util/python.c                                                      |   64 
 tools/perf/util/s390-cpumsf.c                                                 |    6 
 tools/perf/util/sample.c                                                      |   43 
 tools/perf/util/sample.h                                                      |    9 
 tools/perf/util/scripting-engines/trace-event-python.c                        |   29 
 tools/perf/util/session.c                                                     |   94 
 tools/perf/util/symbol.c                                                      |    4 
 tools/perf/util/synthetic-events.c                                            |   24 
 tools/perf/util/thread_map.c                                                  |   26 
 tools/perf/util/thread_map.h                                                  |    1 
 tools/perf/util/unwind-libdw.c                                                |    9 
 tools/perf/util/unwind-libunwind-local.c                                      |   12 
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c               |   18 
 tools/sched_ext/scx_flatcg.bpf.c                                              |    2 
 tools/testing/cxl/test/cxl.c                                                  |    8 
 tools/testing/selftests/Makefile                                              |    4 
 tools/testing/selftests/alsa/mixer-test.c                                     |    2 
 tools/testing/selftests/alsa/test-pcmtest-driver.c                            |   27 
 tools/testing/selftests/arm64/signal/Makefile                                 |    4 
 tools/testing/selftests/bpf/network_helpers.c                                 |   46 
 tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c            |    4 
 tools/testing/selftests/bpf/prog_tests/empty_skb.c                            |   59 
 tools/testing/selftests/bpf/prog_tests/missed.c                               |    8 
 tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c                 |   10 
 tools/testing/selftests/bpf/prog_tests/sockopt.c                              |    4 
 tools/testing/selftests/bpf/prog_tests/test_tunnel.c                          |   13 
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c                    |    4 
 tools/testing/selftests/bpf/progs/cpumask_success.c                           |    6 
 tools/testing/selftests/bpf/progs/empty_skb.c                                 |    7 
 tools/testing/selftests/bpf/progs/verifier_vfs_accept.c                       |   18 
 tools/testing/selftests/bpf/progs/verifier_vfs_reject.c                       |   15 
 tools/testing/selftests/bpf/unpriv_helpers.c                                  |  101 
 tools/testing/selftests/breakpoints/Makefile                                  |    4 
 tools/testing/selftests/cgroup/test_core.c                                    |   53 
 tools/testing/selftests/cgroup/test_cpu.c                                     |    7 
 tools/testing/selftests/cgroup/test_cpuset.c                                  |    7 
 tools/testing/selftests/cgroup/test_freezer.c                                 |    7 
 tools/testing/selftests/cgroup/test_kill.c                                    |    7 
 tools/testing/selftests/cgroup/test_kmem.c                                    |    7 
 tools/testing/selftests/cgroup/test_memcontrol.c                              |    7 
 tools/testing/selftests/cgroup/test_pids.c                                    |    2 
 tools/testing/selftests/cgroup/test_zswap.c                                   |  240 +
 tools/testing/selftests/clone3/clone3_clear_sighand.c                         |    6 
 tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c                 |   32 
 tools/testing/selftests/ftrace/ftracetest                                     |    2 
 tools/testing/selftests/ipc/Makefile                                          |    8 
 tools/testing/selftests/mm/vm_util.h                                          |    1 
 tools/testing/selftests/net/lib/csum.c                                        |   67 
 tools/testing/selftests/net/netfilter/conntrack_vrf.sh                        |   25 
 tools/testing/selftests/net/tcp_mmap.c                                        |    6 
 tools/testing/selftests/net/txtimestamp.c                                     |   23 
 tools/testing/selftests/prctl/Makefile                                        |    4 
 tools/testing/selftests/sched_ext/hotplug.c                                   |   34 
 tools/testing/selftests/sparc64/Makefile                                      |    4 
 tools/testing/selftests/thermal/intel/power_floor/Makefile                    |   12 
 tools/testing/selftests/thermal/intel/workload_hint/Makefile                  |   12 
 tools/testing/selftests/timers/clocksource-switch.c                           |   23 
 tools/thermal/tmon/tmon.c                                                     |    2 
 usr/gen_init_cpio.c                                                           |    1 
 1604 files changed, 27413 insertions(+), 14120 deletions(-)

Aaradhana Sahu (2):
      wifi: ath12k: Free allocated CE IRQs on request_irq() failure
      wifi: ath12k: Free allocated external IRQs on request_irq() failure

Aaron Kling (2):
      dt-bindings: vendor-prefixes: Add Chip Wealth Technology
      dt-bindings: vendor-prefixes: Add Retroid Pocket

Aaron Tomlin (1):
      perf trace: Fix error checking in btf_struct_scnprintf()

Abdelnasser Hussein (4):
      staging: iio: adc: ad7816: Fix DMA safety issues in SPI transfers
      staging: iio: adc: ad7816: Sort headers alphabetically
      staging: iio: adc: ad7816: Serialize SPI operations
      staging: iio: adc: ad7816: Protect sysfs attributes with mutex

Abdifatah Suruur (3):
      vfio/platform: prevent read-only region mappings from becoming writable
      vfio/fsl-mc: prevent read-only region mappings from becoming writable
      vfio/cdx: prevent read-only region mappings from becoming writable

Abdurrahman Karadag (1):
      wifi: rtw88: debugfs: don't vzalloc(0) when rsvd_page is read unconfigured

Abel Vesa (6):
      arm64: dts: qcom: x1e80100-yoga-slim7x: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1e80100-qcp: Mark the EC reset gpio as reserved
      arm64: dts: qcom: sm8150: Use SM8150_CX for the SDHC power domain
      clk: qcom: mmcc-msm8996: Fix FD AHB clock register offset
      clk: qcom: mmcc-sdm660: Fix MDSS AHB clock HWCG register offset
      clk: qcom: mmcc-msm8960: Configure PLL15 only on APQ8064

Abraham Zukor (1):
      spi: tegra114: initialize native chip selects inactive

Adam Skladowski (1):
      dt-bindings: vendor-prefixes: Add LeEco

Adi Nata (1):
      iio: humidity: hts221: report available values via read_avail()

Aditya Sharma (2):
      mm/memory: update stale locking comments for fault handlers
      bpf: Remove nmi_uaccess_okay() check in bpf_send_signal_common()

Adrián Larumbe (2):
      drm/panfrost: Prevent division by 0
      drm/panfrost: Explicitly enable MMU interrupts at device init

Ahmad Fatoum (2):
      ARM: dts: stm32: lxa-mc1: change stdout-path baud rate from 9600 to 115200
      ARM: dts: stm32: lxa-tac: change stdout-path baud rate from 9600 to 115200

Ahmed Naseef (1):
      wifi: mt76: mt7615: read MT7663 temperature from the correct offset

Ahmed Yaseen (1):
      platform/x86: asus-wmi: validate custom fan curves on enable

Ahsan Atta (3):
      crypto: qat - avoid OOB read when stripping RSA leading zeros
      crypto: qat - release instance on DH fallback allocation failure
      crypto: qat - fix active_devs leak on crypto alg registration failure

Ajay Kumar Nandam (1):
      ASoC: qcom: q6apm: clear g_apm on driver removal

Akash Sukhavasi (1):
      phy: HiSilicon: Fix error handling in hi3670_pcie_allclk_ctrl()

Akhil P Oommen (1):
      drm/msm/a6xx: Fix secondary rail vote in ARC votes

Alain Volmat (1):
      ARM: dts: stm32: add LTDC / DCMIPP access controller for STM32MP135

Alejandro Lucero (1):
      ACPI: HMAT: preserve hmat_adist_nb notifier block

Aleksandr Nogikh (1):
      usb: gadget: dummy_hcd: prevent unbind via sysfs

Aleksandrova Alyona (1):
      platform/x86: intel_telemetry: initialize default trace verbosity

Aleksei Oladko (1):
      selftests: fix ARCH normalization to handle command-line argument

Alex Markuze (1):
      ceph: fix page vector leak on encrypted netfs read EIO path

Alexander A. Klimov (1):
      microblaze: CCF: fix refcount leak

Alexander Aring (1):
      dlm: fix variable key length lookup

Alexandre Belloni (1):
      rtc: s35390a: fix typo in comment

Alexandre Cassen (2):
      net/mlx5: HWS, fix modify header pattern compare on big-endian
      net/sched: act_api: inherit filter offload flags only on new actions

Alexandre Torgue (1):
      arm64: dts: st: introduce stm32mp23 SoCs family

Alexei Starovoitov (4):
      bpf: Clear sk_refcnt of a clone before its storage is linked
      bpf: Don't take an extension for a writable raw tracepoint program
      bpf: Don't take a program with a target program for an iterator
      bpf: Use memmove() to store bytes in an xdp_buff

Alexey Klimov (1):
      ASoC: qcom: sdm845: add handling of secondary MI2S clock

Alexis Lothoré (eBPF Foundation) (2):
      selftests/bpf: Allocate a larger timeout for connection
      selftests/bpf: make cmdline_contains stricter

Ali Ahmet Memiş (4):
      ACPI: utils: Add exclusive AML evaluation helpers
      platform/x86: ideapad-laptop: Evaluate ACPI methods exclusively
      ALSA: control_led: Fix deadlock between sysfs writes and card disconnect
      ALSA: hda: intel: Don't free card in the probe work

Alireza Haghdoost (1):
      perf symbols: Don't let a module's last symbol overlap the next module

Alison Schofield (2):
      cxl/hdm: Reject switch decoder interleave ways that overflow targets
      cxl/hdm: Make switch decoder target parsing endian-safe

Allison Henderson (4):
      net/rds: include the scope id in the sendmsg connection cache check
      net/rds: keep the connected peer's scope id apart from the bound one
      net/rds: do not fail init when CONFIG_SYSCTL=n
      net/rds: do not initialize transports after rds_init() failed

Alok Tiwari (1):
      octeontx2-af: Fix CQ enable state tracking after AQ writes

Aloka Dixit (2):
      Revert "wifi: mac80211: do not use old MBSSID elements"
      wifi: mac80211: remove redundant null check in ieee80211_assign_beacon()

Amadeusz Sławiński (7):
      ALSA: pcm: Fix driver_tstamp value reporting
      ASoC: soc-link: Correct stream stop operations in snd_soc_link_trigger
      ASoC: ops: Fix return value in snd_soc_limit_volume()
      ASoC: soc-topology-test: Check return value of kunit_device_register()
      ASoC: soc-card-test: Check return value of kunit_device_register()
      ASoC: soc-ac97: Fix error handling in snd_soc_new_ac97_component()
      ASoC: soc-component: Fix return type of snd_soc_pcm_component_pointer()

Amir Goldstein (2):
      ovl: inherit FMODE_NONOTIFY when opening directory realfiles
      ovl: inherit FMODE_NONOTIFY when reading directory layers

Andrea Parri (3):
      pstore: don't leave an ERR_PTR in the ramoops zone pointer
      pstore: reject persistent RAM zones too small for the buffer header
      nvmet: zns: reject a NUMD whose byte count wraps

Andreas Kemnade (2):
      drm/omap: dsi: avoid sending bta sync all the time in writes
      rtc: bd70528: properly enable wakeup

Andrew Gaylard (1):
      pinctrl: fix PINCTRL_SPPCTL=m

André Draszik (2):
      rtc: ftrtc010: drop needless struct ftrtc010_rtc::rtc_dev member
      rtc: s35390a: drop needless struct s35390a::rtc member

Anil Kaushik (2):
      gtp: set a valid genl command in PDP context get and dump replies
      gtp: hold RCU for the device lookup when adding a PDP context

Anirudh Virdi (1):
      net: qede: initialize extack in qede_flow_spec_to_rule()

Antoni Pokusinski (3):
      rtc: abx80x: fix error check after i2c_smbus_read in read_alarm()
      rtc: abx80x: add mutex protection for register writes
      rtc: abx80x: properly handle shared IRQs

Antonio Borneo (1):
      pinctrl: stm32: Declare stm32_pmx_get_mode() as static

Anup Vishwakarma (2):
      remoteproc: qcom_q6v5_adsp: Fix double jiffies conversion in adsp_start()
      mailbox: qcom-ipcc: remove stray disable_irq_wake() call

Ard Biesheuvel (6):
      x86/efistub: Drop long obsolete UGA support
      efi/libstub: Use C99-style for loop to traverse handle buffer
      efi/libstub: Simplify GOP handling code
      efi/libstub: Simplify PCI I/O handle buffer traversal
      efi/libstub: Use cleanup helpers for freeing copies of the memory map
      x86/efistub: Merge PE and handover entrypoints

Arka Mondal (6):
      usb-storage: alauda: do not do DMA from the stack
      usb-storage: alauda: check the return value of alauda_read_map()
      usb-storage: alauda: fix out-of-bounds zone index
      iio: dac: ad5758: Fix alignment for DMA safety
      iio: dac: ad5758: Reject out-of-range raw values
      iio: dac: ad5758: Fix the offset calculation

Arnaldo Carvalho de Melo (17):
      perf jitdump: Fix extended header read that always fails
      perf jitdump: Fix debug_data and unwinding_data leaks
      perf jitdump: Validate code_size against total_size in code load
      perf jitdump: Prevent integer underflow in debug info size calculation
      perf jitdump: Bounds-check debug entry byte-swap loop
      perf jitdump: Check snprintf return before computing header size
      perf jitdump: Fix funlockfile on unlocked stream in jit_open() error path
      perf jitdump: Free event in jit_repipe_code_move()
      perf jitdump: Use dirname() return value in jit_open()
      perf jitdump: Validate debug entries on native (non-swap) path
      perf jitdump: Validate sym string NUL-termination in code load
      perf jitdump: Validate unwinding sizes against record payload
      perf btf: Make the sigtrap test helper to find a member by name widely available
      perf annotate-data: Show the sample count in the data-type browser
      perf bpf: Move the LIBBPF_CURRENT_VERSION_GEQ macro to bpf-utils.h
      perf cs-etm: Bounds-check CPU in cs_etm__get_queue()
      perf libunwind: Fixup conversion perf_sample->user_regs to a pointer

Arnd Bergmann (2):
      KMSAN: fix memset() when using fortify-source, again
      f2fs: quota: fix unused-label warning

Atharva Vartak (1):
      net/smc: hold a reference on net_device returned by pnet_find_base_ndev()

Atul Akella (1):
      rpmsg: virtio: fix error handling in TX buffer wait

Aurelien Jarno (1):
      riscv: fix RVG_SYSTEM_CSR_MASK width mask

Avi Weiss (4):
      rpmsg: mtk: release channel OF node on device teardown
      signal: skip blocked signals in dequeue_synchronous_signal()
      profiling: fix sampling step on 64-bit big-endian systems
      nvmet: prevent double-free after metadata SGL allocation failure

Ayushman Rout (1):
      bpf: Use memmove() to load bytes from an skb and an xdp_buff

Babanpreet Singh (1):
      regulator: ab8500: Remove stale expand_register kernel-doc entry

Baek Kyu, Kim (1):
      rtc: mpfs: Fix alarm register word order

Baolin Liu (2):
      fs/ntfs3: update ctime only on successful setxattr
      fs/ntfs3: reject FS_IOC_SETFSLABEL on readonly mounts

Bart Van Assche (4):
      scsi: pm8001: Fix SATA FIS offset in struct hw_event_resp
      scsi: scsi_debug: Fix a locking bug in resp_write_same()
      block/blk-iocost: Split ioc_rqos_throttle()
      block/blk-iocost: Inline iocg_lock() and iocg_unlock()

Bartosz Golaszewski (1):
      gpio: pcf857x: use new GPIO line value setter callbacks

Bartosz Szpila (1):
      platform/chrome: cros_ec_typec: Validate SVID and mode counts in discovery data

Beleswar Padhi (1):
      mailbox: ti-msgmgr: Read exact number of trailing message bytes

Bernard Pidoux (10):
      rose: walk the neighbour list under its lock when a device goes down
      rose: hold RTNL while a route is added or deleted
      rose: change the loopback nodes under the neighbour list lock too
      rose: check the length of Restart Request and Diagnostic frames
      rose: keep a socket unbound when connect() fails to autobind it
      rose: refuse an empty message when the Q bit is included
      rose: give loopback answers LCIs that calls cannot be given
      rose: clear the other half of a through route a new call takes over
      rose: disconnect sockets under their lock when a neighbour goes away
      hdlcdrv: close the hardware driver once, and only if it was opened

Bert Karwatzki (2):
      wifi: check if socket flags are valid
      mac80211: tx: Use info->flags in ieee80211_tx_h_select_key()

Bharath SM (1):
      smb: align durable reconnect v2 context to 8 byte boundary

Binbin Deng (4):
      module: Fix uninitialized count read of unloaded taint tracking record
      octeontx2: Fix use-after-free of qos node in delete path
      tipc: fix use-after-free of broadcast reception link at node release
      net: atlantic: Unregister before clearing RXNFC rules

Bjorn Andersson (1):
      power: supply: qcom_battmgr: report full batteries

Boris Faure (1):
      soundwire: intel: initialise quirk_mask before reading it

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Move the no-revision fixup to get_patch_level()

Brad Fitzpatrick (1):
      gre: keep the UDP tunnel GSO type when completing GRO

Breno Leitao (4):
      kexec_file: stop the top-down search before it underflows
      cpuidle: menu: Remove incorrect unlikely() annotation
      ACPICA: Fix memory leak in acpi_ds_create_field()
      mailbox: pcc: Free the channel before unmapping the shared memory

Brian Norris (2):
      PM: runtime: Only queue an idle check for RPM-linked suppliers
      PM: runtime: Only queue an idle check for RPM-linked suppliers (part 2)

Bruno Produit (1):
      hfs/hfsplus: serialize B-tree close against folio release

Cai Xinchen (1):
      lsm: don't call security_backing_file_free() multiple times

Carolina Jubran (2):
      IB/IPoIB: Cancel normal flush work on device stop
      net: skbuff: don't copy alloc_cpu in skb header copies

Cen Zhang (27):
      ocfs2: validate move extents against a stable EOF
      ALSA: timer: Pin the module for userspace timer controllers
      ALSA: jack: Remove debugfs before freeing unregistered jacks
      ALSA: rawmidi: Drain input work before freeing the runtime
      ALSA: pcm: Protect delay DMA sync against concurrent HW_FREE
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
      ALSA: jack: Protect the index scan against control removal
      ALSA: pcm: Protect the unregister notifier traversal
      ALSA: oss: Keep emulation modules loaded until object teardown
      ALSA: pcmtest: Pin the module while pattern files are open
      ALSA: pcm: Remove channel-map controls before freeing substreams
      ALSA: jack: Pin the module while debugfs files are open
      ALSA: pcm: Protect channel-map reads against runtime detach
      ALSA: aloop: Keep the timer source alive until card release
      ocfs2: initialize status waiters before publishing them
      ALSA: ump: Drain sequencer callbacks before freeing their client

Cen Zhang (Microsoft) (1):
      apparmor: fix query_data() output overlapping the lookup key

Cezary Rojewski (2):
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

Chandrakanth Patil (18):
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
      scsi: mpi3mr: zero out diagnostic buffer status memory
      scsi: mpi3mr: Fix use-after-free of the firmware event workqueue
      scsi: mpi3mr: Fix NULL pointer dereference on PCI error recovery

Chao Yu (2):
      f2fs: fix to update superblock crc in sanity_check_area_boundary()
      f2fs: fix to fetch ino via ino_of_node() under cache lock

Chen Cheng (1):
      md/raid5: reject raid4/5 arrays with too few disks

Chen Pei (1):
      perf test: Fix a leaked map reference in the arch dwarf unwind tests

Chen-Yu Tsai (6):
      pwm: mtk-disp: Fix period readback
      arm64: dts: mediatek: mt8173: Fix MFG_ASYNC power domain clock
      drm/exynos/fimd: fix register offset type in fimd_trigger()
      dt-bindings: media: sun4i-a10-video-engine: Fix IOMMU count for H6
      arm64: dts: allwinner: sun50i-h6: Add missing SRAM region for video engine
      arm64: dts: allwinner: sun50i-h6: Add missing IOMMU for video engine

ChenXiaoSong (4):
      smb: move create_durable_req_v2 to common/smb2pdu.h
      smb: move create_durable_handle_reconnect_v2 to common/smb2pdu.h
      smb: move create_durable_rsp_v2 to common/smb2pdu.h
      smb/server: fix trailing period in generated short names

Cheng Xu (1):
      RDMA/erdma: Use IRQ-safe XArray helpers for QP and CQ tables

Cheng Yongkang (1):
      net: tun: hold napi_mutex when deleting NAPI in tun_detach_all()

Chengchang Tang (1):
      RDMA/hns: Fix missing CQE when UD QP use different SL

Chengfeng Ye (2):
      mm/ksm: mark migration stores with WRITE_ONCE()
      l2tp: snapshot sequencing state when building transmit headers

Chien Wong (2):
      wifi: mac80211: fix encryption tailroom
      wifi: mac80211: reserve MME tailroom for protected beacons

Chintan Vankar (1):
      arm64: dts: ti: k3-j722s-evm: Add bootph-all property to enable Ethernet boot

Chris Lu (4):
      Bluetooth: btmtksdio: Remove redundant firmware filename override
      Bluetooth: btmtksdio: Pass the hardware device id to mt79xx_setup()
      Bluetooth: btmtk: Validate the firmware layout before parsing it
      Bluetooth: btmtk: Improve BT firmware logging

Chris Mason (7):
      mm/huge_memory: fix truncate racing with PMD zapping
      nvmet-rdma: flush nvmet-wq on module exit
      nvmet-rdma: disable interrupts under rsp_wr_wait_lock
      nvmet-rdma: fix double puts after a failed RDMA WRITE
      nvmet: don't clear sq->ctrl for a Connect with sqsize 0
      rnbd-srv: fix use-after-free on two CLOSE messages
      rnbd-srv: publish the sess_dev at the end of OPEN

Chris Morgan (1):
      arm64: dts: rockchip: Correct Device Orientation on Gameforce Ace

Christian Brauner (2):
      proc: don't let an entry below /proc/<pid>/net be a mountpoint
      backing-file: enforce append-only and immutable backing inodes

Christian Bruel (2):
      arm64: dts: st: Adjust interrupt-controller for stm32mp23 SoCs
      arm64: dts: st: Use 128kB size for aliased GIC400 register access on stm32mp23 SoCs

Christian Loehle (2):
      cpuidle: menu: Remove single state handling
      ACPI: CPPC: Validate the _CPC package header

Chuanhong Guo (1):
      pinctrl: mediatek: mt7629: fix the 2.4 GHz Wi-Fi pin mode array

Chuck Lever (3):
      NFS: use TCP for MOUNT when xprtsec= selects TLS
      SUNRPC: reject a client-side TLS alert record that is not two octets
      SUNRPC: treat every client-side TLS error alert as fatal

Ciro Pedrini (1):
      platform/x86: hp-wmi: Add OMEN board 8A17 thermal profile support

Colin Ian King (1):
      selftests/bpf: Fix spelling mistakes in descr literal strings

Cong Nguyen (1):
      leds: lm3692x: Fix regulator/gpio leak and wrong enabled state on last write failure

Cong Zhang (1):
      virtio_blk: use synchronous quiesce in virtblk_freeze_priv()

Cristian Papa (2):
      wifi: mt76: mt7603: don't drop short frames looped back on PS entry
      wifi: mt76: feed the station RSSI average from the chain signals

Daasaradhi Mannava (1):
      platform/x86: msi-ec: Report valid charge thresholds when unset

Daejun Park (2):
      nvme: unregister when pr_register() is given a zero new key
      xfs: add a flag to convert unwritten extents without allocating blocks

Dairui Zhang (1):
      IB/mad: fix UAF and double-free in RMPP receive reassembly

Damien Le Moal (5):
      scsi: scsi_debug: move ASC and ASCQ definitions to scsi_proto.h
      scsi: core: Define all additional sense codes and their qualifiers
      scsi: core: Rename sense field of struct scsi_failure
      scsi: core: Prepare for using combined sense codes
      scsi: core: Fix additional sense code definition

Dan Carpenter (5):
      wifi: b43: don't pass unterminated string to sscanf()
      wifi: b43legacy: debugfs: NUL terminate string in debugfs
      wifi: carl9170: NUL terminate string in debugfs
      mm/hmm/test: reject overflowing page counts
      platform/x86/amd/pmc: fix leak in probe()

Daniel Borkmann (1):
      bpf, lsm: Reject writes into the BPF LSM program context

Daniel Braunwarth (1):
      net: phy: realtek: Add support for WOL magic packet on RTL8211F

Daniel Machon (12):
      net: sparx5/lan969x: do not clobber the PSFP cycle timer update period
      net: sparx5/lan969x: do not read past skb->len when injecting a frame
      net: sparx5: split sparx5_fdma_{start(),stop()}
      net: sparx5: activate FDMA tx in start()
      net: sparx5: fix tx DCB index drift in fdma xmit
      net: lan966x: do not inject uninitialised bytes past skb->len
      net: lan966x: do not warn on MAC entries that are not port destined
      net: lan966x: fix the DB dataptr of frames from ndo_xdp_xmit
      net: lan966x: release the in-flight slot of a stale TX skb
      net: microchip: fdma: use little-endian types for descriptor fields
      net: microchip: fdma: fix DCB corruption under sustained load
      net: lan966x: don't disable hardirqs in fdma tx clear path

Daniel Palmer (1):
      m68k: apollo: Fix interrupt setup

Daniel Wagner (3):
      nvme-fabrics: reset io_queues before computing the queue mapping
      nvme-fabrics: limit each queue type to the number of online CPUs
      nvme-fabrics: clear the poll map if no poll queues are mapped

Danielle Ratson (1):
      bridge: Add internal flags for neigh_forward_grat

Danila Chernetsov (2):
      dlm: validate lock modes in recovery messages
      dlm: fix NULL pointer dereference in dlm_dump_rsb_name()

Danish Khateeb (3):
      tools/nolibc: fix WIFSIGNALED() for status 0
      tools/nolibc: stop rounding malloc() sizes up to 4096 bytes
      tools/nolibc: check for overflow in malloc()

Darong Lu (1):
      libceph: initialize CRUSH choose argument weights

Darren Carreras (1):
      libbpf: Avoid overflow in BTF.ext bounds check

Dave Jiang (16):
      efi/cper: Reject CPER records with an out-of-range error_data_length
      efi/cper: Reject an error status block length that wraps a u32
      ACPI: extlog: Validate elog record length before walking sections
      ACPI: APEI: GHES: Bound CXL event record copy to the firmware section length
      efi/cper: Read only validated fields in cper_mem_err_pack()
      cxl: Add a cached copy of target_map to cxl_decoder
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

David Heidelberg (1):
      ASoC: wcd-mbhc-v2: Fix incorrect properties names and typos

David Hildenbrand (Arm) (13):
      mm/ksm: fix use of a freed anon_vma at swap-in
      mm/userfaultfd: write-lock the VMA before waking waiters when unregistering
      mm/userfaultfd: wake waiters when registration modes are removed
      mm/memory-tiers: unregister empty tiers outside memory_tier_lock
      mm/mremap: recheck PUDs under the page table lock
      mm/hugetlb: disable PMD sharing for UFFD missing mode
      mm: fix address wraparound when scanning large folio PTEs
      mm/vma: don't leak the charge for stack growth
      mm/mremap: use pudp_huge_get_and_clear() when moving huge PUDs
      mm/rmap: handle device-exclusive entries in folio_referenced_one()
      fork: take mmap_lock before copying mm_struct
      mm/shmem: make shmem_file() check the file's inode
      mm/shmem: fix accounting of swapin-error markers

David Howells (1):
      rxrpc: Revert "rxrpc: rxperf: Fix missing decoding of terminal magic cookie"

David Sterba (6):
      btrfs: don't use token set/get accessors for btrfs_item members
      btrfs: don't use token set/get accessors in inode.c:fill_inode_item()
      btrfs: accessors: delete token versions of set/get helpers
      btrfs: accessors: simplify folio bounds checks
      btrfs: accessors: use type sizeof constants directly
      btrfs: accessors: inline eb bounds check and factor out the error report

Deepti Jaggi (1):
      mailbox: qcom-cpucp: Add support for Nord CPUCP mailbox controller

Detlev Casanova (2):
      arm64: dts: rockchip: Rename rk3328 HDMI audio card
      arm64: dts: rockchip: Rename rk3566 and rk3568 HDMI audio cards

Devin Wittmayer (7):
      wifi: mt76: mt7921: fix lock inversion between dev->mutex and iflist_mtx
      wifi: mt76: mt7925: fix lock inversion between dev->mutex and iflist_mtx
      wifi: mt76: mt7921: check drv_pmctrl return in the PCIe reset path
      wifi: mt76: mt7925: check drv_pmctrl return in the PCIe reset path
      wifi: mt76: mt7921: fix the lock inversion in suspend and resume
      wifi: mt76: mt7925: fix the lock inversion in suspend and resume
      wifi: mt76: mt7921: honour FIF_FCSFAIL instead of hardcoding drop_err

Diego Fernando Mancera Gomez (1):
      usb: image: microtek: stop SG processing after transfer errors

Dimitris Charisis (1):
      maple_tree: fix maple_range_64 crashes in RCU mode

Dmitrii Tulnov (1):
      kconfig: warn about malformed KCONFIG_PROBABILITY values

Dmitriy Geels (1):
      HID: logitech-hidpp: cancel reset_hi_res_work on probe failure

Dmitry Antipov (1):
      leds: flash: Prevent using uninitialized variable in flash_fault_show()

Dmitry Baryshkov (7):
      ARM: dts: qcom: msm8974: add MDSS reset
      drm/msm/mdp5: drop cursor pipe for msm8x76
      drm/msm/dpu: extract bandwidth aggregation function
      drm/msm/dpu: change ib values to u32
      drm/msm/dpu: make fix_core_ab_vote consistent with fix_core_ib_vote
      drm/msm/dpu: drop core_clk_rate overrides from _dpu_core_perf_calc_crtc
      drm/msm/dpu: handle perf mode in _dpu_core_perf_crtc_update_bus()

Dmitry Sinyavin (1):
      serial: msm: select PM_OPP

Dmitry Torokhov (3):
      gpio: crystalcove: add missing MODULE_ALIAS()
      ASoC: tlv320aic32x4: move regmap_config into i2c and spi drivers
      ASoC: tlv320aic32x4: clean up driver code formatting and logging

Dmitry V. Levin (1):
      syscall.h: introduce syscall_set_nr()

Dominic White (1):
      wifi: cfg80211: allow zero HE OBSS PD offsets

Dominik Maier (1):
      xattr: always invoke cap_convert_nscap() for security.capability writes

Dominique Martinet (1):
      libbpf: fix cross-endian build with newer libbpf

Donggeun Yoo (4):
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

Dragan Simic (2):
      arm64: dts: rockchip: Update CPU OPP voltages in RK356x SoC dtsi
      arm64: dts: rockchip: Prepare RK356x SoC dtsi files for per-variant OPPs

Dudu Lu (4):
      net/sched: etf: initialise the sock_exterr_skb before filling it
      net/sched: gred: keep the qdisc lock while updating the table
      net/sched: taprio: unwind the netdevice notifier if register_qdisc() fails
      net: xps: bound the cleanup loop by the old map's num_tc

Eduard Zingerman (2):
      selftests/bpf: More precise cpu_mitigations state detection
      selftests/bpf: include limits.h needed for PATH_MAX directly

Edward Adam Davis (1):
      kernel/reboot: avoid potential deadlocks during suspension

Eklavya Singh (1):
      ocfs2/heartbeat: serialize concurrent writes to a region's dev attribute

Eric Anderson (1):
      mfd: rk8xx: Register poweroff handler in atomic phase

Eric Dumazet (19):
      inet: frags: limit the truesize of a reassembly queue
      inet: frags: bound the wmem charge of the socket completing a reassembly
      sit: fix UAF in ipip6_tunnel_del_prl()
      ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup
      ipv4: fix IP ID reuse in ip_select_ident_segs()
      ipv4: reserve one IP ID per segment for UDP GSO packets
      Bluetooth: btmtk: fix skb double free on ISO padding failure
      ipv4: use RCU protection in inet_netconf_get_devconf()
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

Eric Joyner (1):
      ionic: free port_info when probe fails after the port is set up

Eric Woudstra (1):
      bridge: No DEV_PATH_BR_VLAN_UNTAG_HW for dsa foreign

Esben Haabendal (2):
      dt-bindings: iio: light: ltr501: Sort compatible enum array
      dt-bindings: iio: light: ltr501: Add missing ltr303 compatible

Esteban Urrutia (2):
      clk: qcom: dispcc-sm8450: Fix disp_cc_mdss_mdp_clk_src ops
      clk: qcom: alpha-pll: Check Lucid Ole PLL status before configuring

Ethan Ferguson (2):
      ntfs3: add FS_IOC_GETFSLABEL ioctl
      ntfs3: add FS_IOC_SETFSLABEL ioctl

Ethan Tidmore (1):
      staging: rtl8723bs: remove unused private debug counters

Eva Kurchatova (1):
      hugetlbfs: enforce F_SEAL_EXEC in setattr

Fabrice Derepas (2):
      crypto: asymmetric_keys - fix OOB read in pefile_parse_binary
      ima: reject a kexec buffer whose declared size exceeds the buffer

Fan Wu (1):
      ipe: fix enforcement audit

Felix Fietkau (8):
      wifi: mt76: mt7915: check default EEPROM firmware size before copying
      wifi: mt76: mt7996: validate firmware event lengths before parsing
      wifi: mt76: mt7915: unregister thermal cooling device on hwmon failure
      wifi: mt76: mt7915: guard firmware memory dump write on disabled memdump
      wifi: mt76: mt7925: restore the reset state when fw_pmctrl fails
      wifi: mt76: mt7996: fix PLE free page and AC queue register offsets
      wifi: mt76: mt792x: compute the assoc RSSI from the chain signals
      wifi: mac80211: use link address as TA for non-MLO 4-addr station on MLD AP

Felix Gu (4):
      spi: omap2-mcspi: Remove unbalanced pm_runtime_put_sync() calls
      spi: mtk-nor: fix runtime PM usage count leak in probe error path
      PCI: dra7xx: Fix clock enable leak on probe failure
      spi: mxic: fix ps_clk leak in runtime resume

Feng Yang (2):
      bpf: Propagate btf_add_type() errors in btf_check_all_metas()
      bpf: Fix out-of-bounds btf->types write for split BTF

Fenglin Wu (1):
      spmi: pmic-arb: return 0 in spmi_pmic_arb_register_buses() on success

Fernando Fernandez Mancera (4):
      netfilter: synproxy: fix reset of ct seqadj when reopening a connection
      net: openvswitch: skip IPv4 later fragments on TCP/UDP set actions
      net: openvswitch: drop IP fragments on SCTP set action
      devlink: region: fix snapshot id leak on kernel-allocated ids

Filipe Manana (8):
      btrfs: fix off by one super block end offset calculation when writing super blocks
      btrfs: fix dangling nodes in tree-mod-log after error in btrfs_tree_mod_log_insert_root()
      btrfs: fix incomplete iteration over fs state when logging messages
      btrfs: fix off-by-one end offset check in report_setget_bounds()
      btrfs: qgroup: fix swapped blocks existence check when tracing after COW
      btrfs: fix lost error return value in btrfs_alloc_logged_file_extent()
      btrfs: defrag: fix check to see if next extent can be defragged too
      btrfs: remove leftover EXTENT_UPTODATE clear from an inode's io_tree

Finn Thain (20):
      swim: Assert strobe with stable outputs
      swim: Select appropriate drive once only
      swim: Enable the drive when probing
      swim: Don't disable drive after every sector
      swim: Perform ISM/IWM mode switching according to specs
      swim: Configure parameter memory
      swim: Refactor SWIM setup
      swim: Enable clock divider only where appropriate
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

Florian Fainelli (9):
      tools/thermal/tmon: Fix string truncation warning in optarg copy
      net: bcmasp: fix mib counters struct alignment with ethtool stats
      net: bcmasp: unmap previous DMA mappings on TX map failure
      net: bcmasp: validate minimum RX packet size in bcmasp_rx_poll()
      net: bcmasp: fix OF node reference leak for phy_dn
      net: bcmasp: account for offload header in TX short packet padding
      net: bcmasp: fix network filter lookup and wake filter pair allocation
      perf print_insn: Include sys/types.h for ssize_t
      net: dsa: mv88e6xxx: fix 6351 family statistics snapshot

Florian Fuchs (2):
      sh: uaccess: Require offsettable operands for 64-bit user access
      ALSA: sh: aica: Fix spu_memset() stride

Florian Schmaus (1):
      selftests/epoll: fix race condition in multi-waiter wakeup tests

Florian Westphal (3):
      netfilter: conntrack: fix unlikely UaF in gc worker
      selftests: netfilter: fix return value in zone subtest
      netfilter: nft_compat: restrict raw table targets/matches

Francesco Dolcini (1):
      arm64: dts: ti: k3-am62-verdin: fix main_gpio0/main_gpio1 line names size

Frank Li (1):
      hwmon: (tmp108) Add helper function tmp108_common_probe() to prepare I3C support

Frank Wang (1):
      phy: rockchip: usbdp: add rk3576 device match data

Frederic Weisbecker (2):
      rcu: Remove swake_up_one_online() bandaid
      Revert "rcu/nocb: Fix rcuog wake-up from offline softirq"

Fuad Tabba (6):
      KVM: arm64: vgic-its: Don't map an LPI from more than one event
      arm64: pi: Run the source checker on the libfdt objects under C=2
      irqchip/gic-v3-its: Clear vpt_page after freeing the pending table
      irqchip/gic-v3-its: Don't free a vPE table shared with another ITS
      irqchip/gic-v3-its: Don't free the tables of an enabled ITS
      irqchip/gic-v3: Don't register a redistributor that was never counted

Furong Xu (1):
      net: stmmac: Drop useless code related to ethtool rx-copybreak

Gal Pressman (1):
      net/mlx5e: IPsec, Fix out-of-bounds comparison of neighbour keys

Geert Uytterhoeven (2):
      spi: sh-msiof: SITMDR1/SIRMDR1 bitfield conversion
      clk: rs9: Add clock index range check to rs9_of_clk_get()

George Abraham P (1):
      crypto: qat - force an edge when re-enabling all VF2PF interrupts

George Melikov (1):
      bnx2x: fix header length calculation for encapsulated TSO

Georgia Garcia (2):
      apparmor: fix profile leak when a policy load fails
      apparmor: fix NULL pointer dereference in unpack_pdb

Ginger Li (2):
      media: i2c: ov5648: Fix a data race on state->streaming
      wifi: mac80211: Fix a race when expiring a mesh path

Giovanni Di Santi (2):
      fbdev: kyro: Use devm_ioremap() for mmio registers
      fbdev: kyro: Use devm_ioremap_wc() for screen mem

Golla Nagendra (1):
      dmaengine: zynqmp_dma: Fix chan probe/remove error handling

Greg Kroah-Hartman (1):
      Linux 6.12.119

Greg Thelen (1):
      selftests/net: tcp_mmap: remove unused -k option and keepflag

Gregory CLEMENT (1):
      phy: cadence: Sierra: Do not modify register when getting parent clock

Gregory Price (1):
      mm/userfaultfd: compare exact registration modes before skipping

Gregory Price (Meta) (2):
      cgroup/cpuset: use mems_allowed_seq when checking a policy nodemask
      cgroup/cpuset: check effective mems for a movable-only configuration

Guanghui Feng (1):
      iommu/vt-d: Fix IQE handling to cover all descriptors in submission range

Guangshuo Li (4):
      media: i2c: ar0521: remove duplicate media entity cleanup
      spi: fsl: unmap immr_spi_cs on remove
      spi: bcm63xx-hsspi: Disable runtime PM on remove
      floppy: unregister platform device on add_disk failure

Guenter Roeck (4):
      hwmon: (coretemp) Set nr_cores only after core_data allocation succeeds
      hwmon: (chipcap2) Drop unnecessary include files
      hwmon: (coretemp) Fix 32-bit jiffies wraparound in show_temp()
      hwmon: (tmp108) Fix initial conversion delay and wait until ready

Gui-Dong Han (1):
      xen/blkback: Prevent missed completion when draining I/O

Guixin Liu (3):
      nvme: tuning pr code by using defined structs and macros
      cxl/pci: Skip reset detection for DVSEC emulated decoders
      cxl/port: Fix uninitialized coordinates reported for RCDs

Guopeng Zhang (1):
      selftests/cgroup: conform test to KTAP format output

Haibo Chen (1):
      leds: pca9532: Check i2c_smbus_read_byte_data() return value

Haitam Lazaar (1):
      RDMA/siw: Enforce IB_ACCESS_REMOTE_READ for read responses

Hao-Qun Huang (1):
      accel/qaic: reject BO sizes that overflow page count

Haotian Zhang (5):
      phy: hisilicon: hi3670: Fix OF node and device reference leaks
      cpufreq: qcom-cpufreq-hw: fix device node refcount leak in phandle parsing
      mtd: rawnand: pl353: fix clk reference leak in pl35x_nfc_setup_interface()
      ASoC: rockchip: fix device node reference leak in rk3288_hdmi_analog
      scsi: elx: libefc: Fix resource leak in efcport_init() error path

Hari Mishal (2):
      drm/amd/pm: bound SCLK FCW range entries to the table size
      drm/amdgpu/atom: bound the VBIOS date, part number, version and build getters

Harkirat Gill (1):
      drm/amdgpu: re-enable GFXOFF for compute on GFX12

Harry Yoo (Meta) (1):
      selftests/cgroup: ignore memory.reclaim -EAGAIN for zswap writeback test

Heiko Carstens (2):
      s390/ptrace: Preserve ILC when updating system call number
      s390/uprobes: Fix off-by-one bug in emulated PER handling

Heiner Kallweit (3):
      r8169: align RTL8125/RTL8126 PHY config with vendor driver
      net: phy: move realtek PHY driver to its own subdirectory
      net: phy: realtek: use string choices helpers

Hemanth Selam (2):
      nvdimm/pmem: Release gendisk on probe failure
      selftests/cgroup: set the test plan after the setup checks

Henry Hu (4):
      ksmbd: fix link speed query in fsctl_query_iface_info_ioctl()
      ksmbd: fix unlocked IPv6 addr_list walk in fsctl_query_iface_info_ioctl()
      ksmbd: fix invalid Next offset in interface info replies
      ksmbd: report IPv4 and IPv6 addresses independently in iface query

Henry Martin (1):
      netlink: fix out-of-bounds bitmap access clearing stale mc groups

Herbert Xu (1):
      crypto: tcrypt - Avoid reading req->base after submission

Hitalo Souza (1):
      Bluetooth: Add missing newline to bt_dev_{err,warn}_ratelimited()

Hongbo Li (1):
      ASoC: remove unused substream in macro soc_link_mark_pop

Honggang LI (1):
      RDMA/rxe: Fix out-of-range unsigned-to-signed conversion for RDMA message in 2GiB size

Hongling Zeng (2):
      dmaengine: sun6i-dma: Fix use-after-free in error handling paths
      dmaengine: at_hdmac: Fix use-after-free by proper tasklet cleanup

Hongyan Xu (4):
      soc: qcom: apr: clean up failed service registrations
      RDMA/hfi1: shut down the trap timer before unregistering
      RDMA/hfi1: quiesce SDMA asynchronous cleanup on exit
      ASoC: mt6359-accdet: manage private workqueues with devres

Hrishikesh Suresh (1):
      perf: replace strcpy() with strncpy() in util/jitdump.c

Hui Su (1):
      bpftool: Fix CPU IDs in per-CPU map output

Hungyu Lin (1):
      thermal: Fix CPU mask truncation in power limit trace event

HyeongJun An (27):
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

Ian Bridges (4):
      ksmbd: revert fsids on durable reconnect and replay failure
      ksmbd: enforce the read-only share flag when creating a stream
      ksmbd: do not read past the DACL in the access denied debug message
      ksmbd: let the owner read and change the DACL when no ACE names it

Ian Gallagher (1):
      ACPI: button: Add lid_init_state quirk for Razer Blade Stealth 13 (Early 2020) RZ09-0310

Ian Rogers (15):
      perf python: Constify variables and parameters
      perf sample: Make user_regs and intr_regs optional
      perf header: Fix potential memory corruption in cpu_cache_level__read
      perf build: Check the version of the compiler that is used
      perf machine: Factor creating a "live" machine out of dwarf-unwind
      perf debug: Add function symbols to dump_stack
      perf test: Avoid use perf_env
      perf machine: Explicitly pass in host perf_env
      perf test code-reading: Fix duplicate kernel maps and machine leak
      perf build: Clean libperf-gtk.so in 'make clean'
      perf vendor events intel: Fix sierraforest umask encoding.
      perf vendor events intel: Fix skylakex umask encoding.
      perf vendor events intel: Fix snowridgex umask encoding.
      perf trace: Copy sockaddr arguments by their length
      perf thread_map: Add thread_map__tgid()

Ido Schimmel (2):
      bridge: mcast: Delete empty MDB entry when port group creation fails
      ipv6: Hold RCU when emitting route hardware flags notification

Igor Skalkin (1):
      usb: gadget: dummy_hcd: fix SuperSpeed ep0 maxpacket

Igor Velkov (3):
      arm64: dts: amlogic: meson-sm1-odroid-hc4: mux the SPI NOR HOLD# and WP# pins
      arm64: dts: amlogic: meson-sm1-odroid-hc4: run the SPI NOR at 40 MHz
      power: supply: gpio-charger: Report discharging without input power

Ilpo Järvinen (1):
      platform/x86: hp-wmi: Order DMI board name arrays

Ilya Bakoulin (1):
      drm/amd/display: Minimize wait for pending updates

Ilya Leoshkevich (1):
      scripts/gdb/radix-tree: add lx-radix-tree-command

Imre Kaloz (2):
      rtc: ds1685: arm the wake-up alarm at power-off only if an alarm is set
      rtc: ds1685: do not sleep in the power-off handler

Ionut Nechita (1):
      x86/crash: Reserve elfcorehdr for CONFIG_NR_CPUS, not CONFIG_NR_CPUS_DEFAULT

Ivan Hu (1):
      ACPICA: Initialize parser_state.aml_end in acpi_install_method()

Jacob Keller (1):
      ice: set in_use only after preparing Tx timestamp index

Jacob Moroni (2):
      RDMA/irdma: Fix erroneous -ENOMEM for large MR registration
      RDMA/irdma: Fix FRWR IRDMAQPSQ_PBLADDR field population

Jaewon Jung (1):
      selftests/ftrace: Avoid unlink error on first run

Jake Labelle (1):
      nilfs2: reject non-regular inodes in dsync recovery

Jakub Kicinski (2):
      eth: bnxt: free XDP frags when xdp_do_redirect() fails
      eth: bnxt: hand XDP frags over to the copybreak skb

Jakub Sitnicki (3):
      net: Helper to move packet data and metadata after skb_push/pull
      bpf: Make bpf_skb_adjust_room metadata-safe
      net: lwtunnel: Drop skb metadata before LWT encapsulation

Jamal Hadi Salim (1):
      net/sched: act_api: reject duplicate actions in a batch

James Clark (1):
      perf cs-etm: Don't add global v0 HW_IDs to unformatted queues

James Hilliard (1):
      net: stmmac: avoid duplicate XSK TX completions

Jamie Nguyen (1):
      selftests: net: txtimestamp: fix out-of-bounds read in raw UDP checksum

Jan Beulich (1):
      x86/PVH: don't truncate initrd address/size

Jan Kara (1):
      gfs2: Fix journaled truncate range end offset

Jan Stancek (1):
      .gitignore: drop Module.markers

Jann Horn (1):
      cipso: stop modifying live ip_options_rcu

Jared McArthur (1):
      arm64: dts: ti: k3-j722s-evm: Switch audio codec clock from audio_refclk1 to external clock

Jason Gunthorpe (3):
      efi/libstub: Fix error unwind freeing fdt in allocate_new_fdt_and_exit_boot()
      efi/riscv: libstub: Don't set image_size in handle_kernel_image()
      efi/libstub: Free cmdline_ptr in efi_pe_entry

Jasper Wise (1):
      misc: nsm: mark device ready before registering the hwrng and misc device

Javier Carrasco (5):
      hwmon: chipcap2: fix IRQ teardown ordering
      hwmon: chipcap2: disable device after hwmon teardown
      hwmon: (chipcap2) Switch to guard() for mutext handling
      hwmon: chipcap2: serialize access to the alarm indicators
      hwmon: chipcap2: synchronize ready IRQ state

Jeff Chen (1):
      wifi: mwifiex: append hotfix number to firmware version string

Jeff Johnson (1):
      wifi: ath11k: fix reg_info_store leak in ath11k_service_ready_ext_event()

Jeremy Bongio (1):
      RDMA/irdma: Use kvzalloc for lvl2 leafmem allocation

Jerome Brunet (2):
      clk: fix self-consuming provider module pinning
      clk: cdce925: Size the PLL child name buffer for any int

Jesse Zhang (3):
      drm/amdgpu: drop the gang leader reference when freeing gang jobs
      drm/amdgpu: don't walk the CS chunks when allocating them failed
      drm/amdkfd: use the queue's process info for the WPTR BO eviction fence

Jhonata Poma-Hansen (1):
      netlink: check sk_rcvbuf before charging the dump skb

Jia Wang (3):
      dmaengine: dw-axi-dmac: Fix AXI burst length encoding
      dmaengine: dw-axi-dmac: Fix LLI dump out-of-bounds access
      dmaengine: dw-axi-dmac: Fix CH_CFG2 channel priority position

Jiale Yao (26):
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
      wifi: ath12k: Reserve space for a string terminator
      pinctrl: sprd: free maps on DT map failure
      wifi: mt76: mt76x02: validate RX padding before use
      wifi: mt76: usb: fix source overread in mt76u_copy
      wifi: mt76: mt7615: usb: fix source overread in mt7663u_copy
      vfio/pci: Drain eventfd RCU callbacks on module exit
      ACPI: PCI: pci_link: clear driver_data before free
      wifi: ath10k: avoid IDR mutation during TX cleanup
      wifi: ath11k: avoid IDR mutation during pending mgmt TX cleanup
      wifi: ath11k: avoid IDR mutation during vif mgmt TX cleanup
      wifi: ath12k: avoid IDR mutation during vif mgmt TX cleanup
      platform/olpc: Reserve space for a string terminator
      team: reject CAN, IEEE 802.15.4 and 6LoWPAN devices in team_port_add
      Drivers: hv: vmbus: Check ACPI companion before use
      regulator: irq: freeze deferred hardware access during suspend

Jianan Huang (2):
      f2fs: quota: fix stale lock holder on remount failure
      f2fs: quota: fix quota flush failure during filesystem freeze

Jiangong.Han (1):
      USB: usbmon: fix null-ptr-deref in mon_bus_remove() when mon_bus_init() fails

Jiawen Liu (2):
      memory: exynos5422-dmc: handle clock enable failures
      crypto: starfive - handle clock enable failures

Jiayuan Chen (7):
      bpftool: Using the right format specifiers
      selftests/cgroup: add test for zswap incompressible pages
      tcp_bic: fix divide by zero on max_increment == 0
      tcp_hybla: fix divide by zero on rtt0 == 0
      tcp_cubic: fix divide by zero and endless loop on bad module params
      veth: clear rx queue hint in veth_xmit
      bpf: Fix verifier WARN on narrow read of bpf_tcp_sock u64 fields

Jiebin Sun (1):
      perf c2c: Fix documented default coalesce fields

Jinliang Zheng (1):
      mm: fix outdated incorrect code comments for handle_mm_fault()

Jiri Olsa (1):
      bpf: Add support to retrieve ref_ctr_offset for uprobe perf link

Jisheng Zhang (3):
      regulator: mp886x: fix vsel_mask
      regulator: mp886x: check get_voltage_sel() return value
      regulator: mp886x: fix pontential division by zero

Joas Antonio dos Santos (4):
      calipso: hash the cache key, not the option start, in calipso_cache_add()
      calipso: update payload_len when removing the CALIPSO option
      net: dcb: initialize PFC value before calling getpfccfg
      net: mctp: free reassembly head skb when key_add fails on SOM

Joe Hattori (1):
      PM: wakeup: implement devm_device_init_wakeup() helper

Joel Fernandes (1):
      rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path

Johan Hovold (1):
      spi: fsl: switch to managed controller allocation

Johannes Berg (15):
      wifi: mac80211: fix unauthorised port check for encap offload
      wifi: mac80211: fix key selection for encap offload frames
      wifi: mac80211: don't send encap offload frames unencrypted
      wifi: mac80211: drop encap offload frames with a tainted key
      wifi: free SKBTX_WIFI_STATUS skb tx_flags flag
      wifi: mac80211: fix IEEE80211_TX_CTL_REQ_TX_STATUS mixup
      wifi: ath6kl: don't take RTNL in del_virtual_intf
      wifi: mac80211: clear fragment cache entry 'is_protected'
      wifi: mac80211: mesh: use hlist_add_head_rcu()
      wifi: mac80211: kill wake_txqs_tasklet on unregistration
      wifi: mac80211: init radiotap iter after length checks
      wifi: mac80211: limit injected HT/VHT MCSes
      wifi: mac80211: fix mbssid/rnr allocation in beacon data
      wifi: cfg80211: reg: protect regdb pointer with RCU
      wifi: cfg80211: track SSID regardless of country data

Johannes Thumshirn (1):
      btrfs: zoned: fix double list add in btrfs_load_block_group_zone_info

Johannes Weiner (1):
      mm: page_alloc: do not give all non-blocking requests reserve access

John Crispin (1):
      wifi: mt76: mt7996: disable the RX NAPIs before the DMA cleanup

John Johansen (6):
      apparmor: add support for 2^24 states to the dfa state machine.
      apparmor: add additional flags to extended permission.
      apparmor: fix check SCTP bind, and connect permission checks
      apparmor: advertise that sctp is being mediated
      apparmor: fix: accept2 being specifie even when permission table is presnt
      apparmor: mitigate parser generating large xtables

Joonhoe Kim (4):
      drm/msm/dpu: disable the slave encoder before the master
      drm/msm/dpu: compute the CRTC bandwidth from the state being checked
      drm/msm/dpu: round up the compressed INTF width
      power: supply: qcom_battmgr: report the USB type from USB_ADAP_TYPE

Jori Koolstra (2):
      Add error handling to minix filesystem for inode corruption detection
      Fix a drop_nlink warning in minix_rmdir

Josef Bacik (43):
      mm/hugetlb: fix endless write fault on a leftover uffd bit
      mm/mremap: fix moving PUD leaves
      mm/hugetlb: don't clear the resv_map of a VMA whose lock is held
      mm/filemap: read mapping->a_ops->free_folio under i_lock
      bpf: Reject sleepable programs for task_vma iterator
      bpf: Look at all 64 bits of a BPF_JSET mask on 32-bit
      bpf: Don't let bpf_skb_adjust_room() use up the MSS
      bpf: Read the probe of a perf event under event_mutex
      bpf: Validate the SRH which End.DT6 uncovers in End.BPF
      bpf: Pull the inner header for End.DT6 in End.BPF
      bpf: Update the SRH state if End.B6 fails late
      bpf: Bound the nesting that the BTF show code follows
      bpf: Fix stale offload->prog pointer after realloc
      bpf: Don't bind a program to a netdev that goes away
      bpf: Don't take an extension for an iterator program
      bpf: Keep the symbols of a program until it has ended
      bpf: Use the socket of a sk_lookup test run under RCU
      bpf: Use memmove() to store bytes in an skb
      nvmet: don't truncate the length of big discards
      nvmet-auth: take only AUTH_Negotiate for a negotiation
      nvmet-tcp: stop listening when a port is removed
      nvmet: fix NULL dereference in debugfs host_traddr
      nvmet-tcp: don't read a removed port at Connect time
      nvme-loop: don't BUG() if a scan runs beside a reset
      blk-throttle: don't truncate the cgroup v1 iops limits
      blk-cgroup: fix root io.stat byte counts on 32-bit
      blk-cgroup: don't free a blkg with its punt work queued
      blk-iolatency: flush enable_work after going offline
      blk-throttle: pass the I/O counts of a dead group on
      blk-throttle: make blkio.reset_stats reset I/O counts
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

Joseph Qi (7):
      dlm: fix buffer overflow from negative len in dlm_search_rsb_tree
      ocfs2: fix deadlock in inline-data truncate transactions
      ocfs2: allow xattr bucket entries to span multiple blocks
      ocfs2: reject inconsistent xattr bucket during defrag
      ocfs2: retain all security xattrs during inode creation
      ocfs2: fix possible deadlock between nfs_sync_rwlock and fs_reclaim
      ocfs2: reserve xattr value tree metadata only once

Jouni Högander (2):
      drm/i915/psr: Clear selective fetch area when duplicating plane state
      drm/i915/display: Add enabled pipe planes into state for selective fetch

Julian Anastasov (2):
      ipvs: fix buffer overflow when sending sync messages
      ipvs: fix more races around the overload flag

Julian Braha (1):
      kconfig: fix extra output from savedefconfig on out-of-range defaults

Julius Bairaktaris (3):
      wifi: ath11k: disable interrupts during firmware crash recovery
      wifi: mac80211: fix swapped fq_overlimit/fq_overmemory in aqm debugfs
      wifi: mac80211: don't reset the TXQ scheduling round number

Junxian Huang (2):
      RDMA/hns: Limit gmv_entry_num to avoid memory waste
      RDMA/hns: Fix GID capacity loss in 64K system

Justin Chen (1):
      net: bcmgenet: if UMAC was suspended in SW_RESET, restore it to SW_RESET

Justin Yeh (1):
      HID: i2c-hid: Unfollow the panel on shutdown

Jérémy Jean (7):
      microblaze: prevent ptrace writes to MSR and pt_mode
      md: reject v0.90 arrays with too many devices
      NFS: filelayout: calculate dense stripe width in 64 bits
      macsec: prevent AES-GCM nonce reuse after packet number wrap
      netfilter: nf_conntrack: avoid truncating IPv6 nexthdr offset
      apparmor: check connect permission for SCTP
      nvmet-auth: reject incomplete DHCHAP messages

Jérôme Pouiller (2):
      wifi: wfx: fix possible device hang during init
      wifi: wfx: fix use-after-free of the cooling work on device removal

KaFai Wan (2):
      selftests/bpf: Fix prog_tests framework subtest count checks
      selftests/bpf: Use _exit() in uprobe_multi_test clone-ed child

Kai Mäkisara (2):
      scsi: scsi_debug: Add READ BLOCK LIMITS and modify LOAD for tapes
      scsi: scsi_debug: Add write support with block lengths and 4 bytes of data

Karl Asseily (1):
      dt-bindings: vendor-prefixes: add ESS Technology

Karl Mehltretter (39):
      ocfs2/cluster: hold a reference on the heartbeat thread
      irqchip/gic-v3-its: Don't WARN on LPI free allocation failure
      virtio_ccw: fix synchronize_cbs() after interrupt fallback
      virtio_ccw: always take irq_lock in the classic interrupt handler
      mtd: spinand: Fix spinand_manufacturer_ops kernel-doc
      power: supply: mp2629: Use the full batt_impedance_compensation name in the ABI document
      efi/libstub: Fix efi_set_event_at() parameter documentation
      crypto: lskcipher - preserve state across unaligned chunks
      firewire: cdev: Fix FW_CDEV_IOC_CREATE_ISO_CONTEXT references in kernel-doc
      clk: mediatek: reset: Fix device registration kernel-doc
      spi: Fix the return value in spi_new_ancillary_device() kernel-doc
      ata: libata-scsi: Fix ata_scsi_hotplug() reference in kernel-doc
      gfs2: Fix the return value in gfs2_get_link() kernel-doc
      ALSA: control: Fix virtual master creation reference in kernel-doc
      regulator: qcom-rpmh: Fix the return value in rpmh_regulator_vrm_get_optimum_mode() kernel-doc
      wifi: mac80211: Fix the return value in mesh_path_add() kernel-doc
      block: Fix the thaw_bdev reference in bdev_freeze() kernel-doc
      loadpin: Fix stale KEXEC_VERIFY_SIG reference in documentation
      pinctrl: stm32: Drop the nonexistent CONFIG_MACH_STM32MP25 from the STM32MP257 default
      iommufd: Fix iommufd_hw_capabilities reference in kernel-doc
      soc: ti: k3-ringacc: Correct ring API kernel-doc
      soc: ti: k3-ringacc: Fix DMA ring initialization kernel-doc
      time: Prevent time64_to_tm() day truncation on 32-bit
      OPP: Fix the return value in dev_pm_opp_get_of_node() kernel-doc
      crypto: atmel - handle authenc requests without plaintext
      svcrdma: Fix svc_rdma_recv_cid_init() kernel-doc
      floppy: flush pending work before releasing resources on init failure
      kobject: Fix the kobj_set_name reference in kset_register() kernel-doc
      gpu: buddy: Drop the stale @p line from the gpu_buddy_print() kernel-doc
      sh: sh7785lcr: Register the PCA9564 controller as I2C bus 0
      resource, kunit: stop selecting GET_FREE_REGION
      kcov: report spurious PCs in the interrupt selftest
      thermal: ti-soc-thermal: Fix the return value in ti_bandgap_get_sensor_data() kernel-doc
      serial: ma35d1: Do not force-enable an unselected console
      ARM: 9486/1: set !LPAE MAX_PHYSMEM_BITS to 32 and remove supersection mappings
      ARM: 9492/1: alignment: fix LSR #32 and ASR #32 offset decoding
      rtc: class: Make the time32 hctosys limit configurable
      net: phy: realtek: restore RTL8211F RGMII delays on resume
      netfs: Restore selective debug mask handling

Karol Kolacinski (1):
      ice: E822: keep Tx timestamps disabled during offset calibration

Kees Cook (2):
      kbuild: Mark the initcall ordering recipe as recursive
      mm/slab: Mark the kmem_buckets_create() context as a Context: section

Keisuke Tsukuda (2):
      usb: gadget: composite: avoid warning on aborted delayed status
      usb: gadget: f_mass_storage: ignore class requests while inactive

Kevin Wang (1):
      drm/amd/pm: populate unique ID for smu 13.0.7

Kim Wooseok (1):
      wifi: rtl8xxxu: free RX skb when URB submission fails

Kiran K (2):
      Bluetooth: btusb: Preserve event and ACL packet ordering
      Bluetooth: btintel: Zero version data before parsing TLVs

Koichiro Den (2):
      PCI: endpoint: pci-epf-vntb: Pass PF/VF number when BAR programming
      PCI: endpoint: pci-epf-vntb: Serialize virtual PCI bus scan

Konrad Dybcio (7):
      interconnect: qcom: icc-rpm: Handle icc_link_create() failures
      interconnect: qcom: use 64-bit SMD RPM bus votes
      soc: qcom: pmic_glink: Avoid losing early rpmsg probe
      clk: qcom: gcc-x1e80100: Don't poll the status bit of GCC_USB4_n_SYS_CLK
      clk: qcom: rcg2: Initialize shared floor clock state
      clk: qcom: rcg2: Propagate force-enable status errors
      clk: qcom: rcg2: Clear force enable after rate failure

Konstantin Komarov (2):
      fs/ntfs3: validate EA entry layout against ef->size in ntfs_read_ea
      fs/ntfs3: remove ntfs_bio_pages and use page cache for compressed I/O

Krzysztof Kozlowski (7):
      drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
      dt-bindings: display/msm/dsi-phy: Add header with exposed clock IDs
      ARM: dts: qcom: msm8974: Use the header with DSI phy clock IDs
      drm/msm: Properly handle msm_ioremap() without name
      dt-bindings: display/msm: hdmi: Correct name of disallowed supplies
      soc: qcom: pmic_glink: simplify locking with guard()
      soc: qcom: pmic_glink: Drop redundant pg assignment before taking lock

Krzysztof Wilczyński (3):
      PCI/sysfs: Stop reporting _DSM failures as -EPERM
      PCI/sysfs: Handle a malformed _DSM result in acpi_attr_is_visible()
      PCI/sysfs: Decouple acpi_index from the optional device name element

Kumar Kartikeya Dwivedi (1):
      bpf, riscv: Fix stack-passed arguments for indirect trampolines

Kunhai Dai (1):
      blk-iocost: publish hweights as one atomic value

Kunihiko Hayashi (1):
      net: stmmac: Correct usage of maximum queue number macros

Kuninori Morimoto (2):
      ASoC: mediatek: remove dpcm_xxx flags
      ALSA: usb: mixer: use snd_kcontrol_chip()

Kuniyuki Iwashima (1):
      nvme-tcp: fix use-after-free of netns by kernel TCP socket.

Kunwu Chan (1):
      rcutorture: Fix divide-by-zero with fwd_progress_div=1

Kyle Zeng (3):
      gro: do not GRO GSO packets with inconsistent payload
      tcp: avoid double destroy in tcp_abort() of an unaccepted child
      tcp: initialize mapped children before route lookup

Kyrylo Biryuk (1):
      ata: libahci: re-enable FBS after error handling on a port multiplier

Lance Yang (2):
      khugepaged: fix readahead lock inversion in collapse_file()
      mm/memory_hotplug: fix missing rollback in __add_pages()

Lang Yu (1):
      drm/amdkfd: Map wptr BO to GART unconditionally

Laurence Oberman (2):
      scsi: st: Restore changed drive settings after reset also for MTLOAD and MTRETEN
      scsi: st: Record the tape position after a successful MTLOAD

Laxman Acharya Padhya (1):
      Bluetooth: btintel: propagate version TLV parsing errors

Leizhen Zhang (2):
      gen_init_cpio: stop parsing on lines with a missing argument list
      kconfig: fix infinite loop in conf_choice() when no choice value is visible

Len Brown (2):
      x86_energy_perf_policy: Fix optarg keyword matching
      x86_energy_perf_policy: Cleanup: Check fseek() in VM path

Leo Cheng (2):
      nvmem: layouts: sl28vpd: fix device_node reference leak in error path
      nvmem: layouts: onie-tlv: fix device_node reference leak in error path

Leo Liu (1):
      drm/amdgpu: cancel idle work in hw_init failure paths for vcn/uvd/vce/jpeg

Leo Yan (1):
      perf tools: Fix compilation error on arm64

Leon Hwang (2):
      bpftool: Generate skeleton for global percpu data
      bpftool: Compute map size of light skeletons at runtime

Leon Romanovsky (6):
      RDMA/irdma: Preserve fast-registration IOVA on 32-bit
      PCI/P2PDMA: Safely terminate ACS redirect lists
      PCI/P2PDMA: Gate the host bridge whitelist warning on verbose
      RDMA/core: Preserve the selected source GID on failed AH modification
      RDMA/core: Free unpublished port statistics after initial-read failure
      RDMA/core: Reject LAG selection when source MAC lookup fails

Li Lingfeng (1):
      block: flush all throttled bios when deleting the cgroup

Li RongQing (11):
      RDMA/uverbs: Make CQ handle mandatory for WQ creation
      RDMA/core: Fix swapped list_add_tail() arguments in ib_add_sub_device()
      RDMA/restrack: Don't set RESTRACK_DD mark after a failed xa_insert()
      RDMA/uverbs: Drop restrack ref on ib_init_ucontext() failure in GET_CONTEXT
      RDMA/core: Fix partial copy of IPv6 flow_lbl in LAG hash skb
      RDMA/mlx5: Guard steering anchor resource destruction on create error
      RDMA/mlx5: Restore mr->pi_mr after temporary stack-local assignment
      IB/isert: Don't share drop_cmd_list across concurrent connection teardowns
      block, bfq: initialize active lists for all actuators
      RDMA/mlx5: Fix CQ resize destination index mask
      apparmor: avoid potential double free when remapping DFA tables

Li Wang (4):
      selftests/cgroup: skip test_zswap if zswap is globally disabled
      selftests/cgroup: avoid OOM in test_swapin_nozswap
      selftests/cgroup: use runtime page size for zswpin check
      selftests/cgroup: replace hardcoded page size values in test_zswap

Li Youhong (1):
      md/raid5: drain released_stripes before destroying the cache

Li Zhe (1):
      mm/hugetlb: fix mremap deadlock when PMD sharing is possible

Liang Hao (1):
      timers: Clear pending_map on CPU hotplug

Lijo Lazar (4):
      drm/amdgpu: Add vbios build number interface
      drm/amdgpu: Print full vbios info
      drm/amdgpu: bounds check ATOM IIO table parsing
      drm/amdgpu: Fix vbios build number parsing logic

Linkai Gong (6):
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
      power: supply: bq2515x: Propagate charge-enable read errors
      crypto: mxs-dcp - handle zero-length skcipher requests

Linus Torvalds (2):
      vhost: vringh: use get_user()/put_user() for IOTLB 16-bit accesses
      vdpa_sim: disable page faults around vringh_need_notify_iotlb()

Linus Walleij (43):
      regulator: ab8500: Fix AB8505 VANA voltage selectors
      regulator: ab8500: Add AB8505 VAUX3 3.05 V setting
      regulator: ab8500: Handle AB8505 VINTCORE selector 7
      regulator: ab8500: Treat cut 1.0 VAUX3 as fixed
      regulator: ab8500: Test dedicated enable bits only
      regulator: ab8500: Propagate mode enable read errors
      ARM: dts: ux500: Convert HREF audio to audio-graph-card2
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
      dmaengine: ste_dma40: Init hardware before registration
      dmaengine: ste_dma40: Fix probe IRQ leak
      dmaengine: ste_dma40: Fix DMA registration unwind
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

Liu Dalin (3):
      rtc: ftrtc010: fix clock resource leak on probe failure
      rtc: ftrtc010: use devm clock APIs to fix use-after-disable in remove
      rtc: ftrtc010: fix integer overflow in time calculation

Logan Gunthorpe (2):
      dmaengine: ioat: disable relaxed ordering before registering the device
      dmaengine: plx_dma: fix NULL pointer deref in plx_dma_isr()

Logan Odell (1):
      PCI/IOV: Read VF config values that need not match PF

Long Zhao (1):
      dt-bindings: vendor-prefixes: add Ambarella

Longlong Xia (1):
      rcu: fix shrink budget underflow in lazy_rcu_shrink_scan

Lorenzo Stoakes (ARM) (4):
      mm/vma: update VMA iterator state on error in new VMA merge
      mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
      mm/vma: avoid spurious write locks when mm->mm_lock_seq overflows
      ALSA: us122l: mark hwdep mappings VM_MIXEDMAP

Luca Leonardo Scorcia (1):
      clocksource/drivers/timer-mediatek: Fix random crash at boot

Luca Weiss (2):
      arm64: dts: qcom: sm7225-fairphone-fp4: Disable PMK8350 PON
      ARM: dts: qcom: msm8974: Sort header includes alphabetically

Lucas Costa (1):
      staging: sm750fb: free cmap on framebuffer release

Luiz Augusto von Dentz (4):
      Bluetooth: MGMT: Fix advertising instances with Global Advertising
      Bluetooth: HCI: Fix tracking of instances sharing handle 0x00
      Bluetooth: MGMT: Fix pending state of instances added without HCI traffic
      Bluetooth: MGMT: Fix leaking instance on Add Extended Advertising Parameters

Luka Gejak (1):
      wifi: rtw88: sdio: zero the padding added to a TX transfer

Mahe Tardy (2):
      libbpf: fix log level propagation for light skeleton loaders
      bpf: fix cgroup_skb prog test run direct packet access

Malathi A (1):
      serial: 8250_uniphier: Use devm_clk_get_enabled()

Manivannan Sadhasivam (1):
      PCI: qcom: Honor IOMMU provider's #iommu-cells in qcom_pcie_config_sid_1_9_0()

Manuel Ebner (1):
      ipe: fix invalid sgid value in audit event documentation

Manush Prajwal (1):
      pwm: lp3943: fix NULL pointer dereference for an unconfigured channel

Marc Kleine-Budde (4):
      spi: spi-sun4i: sun4i_spi_transfer_one(): fix transfers for SUN4I_FIFO_DEPTH
      spi: spi-sun4i: sun4i_spi_fill_fifo(): always apply A10 FIFO fill level workaround
      spi: spi-sun4i: sun4i_spi_transfer_one(): fix setting of clock rate
      spi: spi-sun4i: sun4i_spi_handler(): fix race condition between transfer completion and RX FIFO interrupt

Marcel Hofmann (1):
      remoteproc: imx_rproc: Allow mappings ending at region boundary

Marco Crivellari (1):
      regulator: irq_helper: replace use of system_wq with system_dfl_wq

Marek Szyprowski (6):
      ARM: 9519/1: dma-mapping: Fix wrong free function in __iommu_alloc_simple() error path
      ASoC: wm8994: fix MCLK gating for AIF clocks sourced from MCLK2
      ASoC: wm8994: don't lose the AIF clock ratio when staying at 32kHz SYSCLK
      ASoC: wm8994: fix MCLK index used for setting MCLK rate
      ASoC: samsung: midas_wm1811: run FLL1 at the AIF1 configured rate when idle
      ASoC: wm8994: follow AIF clock source changes in MCLK gating

Marek Vasut (4):
      drm: of: Fix drm_of_get_data_lanes_count_ep() return value documentation
      ARM: dts: stm32: Drop bias-disable from STM32MP15xx DHCOM SoM sdmmc1_b4_pins_a
      dt-bindings: vendor-prefixes: Add Retronix Technology Inc.
      net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not present

Mario Limonciello (2):
      cpufreq: amd-pstate: Restore previous mode when changing driver mode fails
      cpufreq: amd-pstate: Propagate cppc_set_auto_sel() errors on mode change

Mario Limonciello (AMD) (1):
      drm/amd: Add correct prefix for VBIOS message

Mark Anthony Agarro (3):
      wifi: mt76: mt7925: honour mac80211's FIF_FCSFAIL instead of hardcoding drop_err
      wifi: mt76: mt7921: keep the join ROC until the station is authorized
      wifi: mt76: mt7925: keep the join ROC until the station is authorized

Mark Brown (1):
      perf bpf: Fix up build failure due to change of btf_vlen() return type

Mark Zhang (1):
      RDMA/mlx5: Support driver APIs pre_destroy_cq and post_destroy_cq

Markus Probst (3):
      rtc: s35390a: Add missing newline to dev_err
      rtc: s35390a: Fix alarm not disabling
      rtc: s35390a: Read 24-hour mode on access

Mateusz Nowicki (2):
      arm64: dts: st: fix arm,smc-id of the SMC watchdog on stm32mp2
      arm64: dts: st: fix sai3b unit address on stm32mp231

Matheus Alves de Almeida (1):
      HID: wacom: fix wacom_intuos_irq NULL pen_input deref

Mathieu Desnoyers (1):
      mm: fix OOM killer inaccuracy on large many-core systems

Matt Turner (1):
      alpha: select SYSCTL_EXCEPTION_TRACE

Matthew Brown (1):
      ceph: fix leaked inode reference on writeback abort at umount

Matthew Wilcox (Oracle) (3):
      ntfs: Do not kmap page cache pages for compression
      ntfs: Do not kmap pages used for reading from disk
      ceph: Convert ceph_move_dirty_page_in_page_array() to move_dirty_folio_in_page_array()

Matthias Goergens (2):
      x86/hibernate: Ignore page-zero RAM in E820 checksum
      isofs: return long Joliet names whole

Matthieu Baerts (NGI0) (2):
      mptcp: options: mpc: avoid printing uninit data
      mptcp: options: dss: avoid printing uninit csum

Matti Vaittinen (2):
      iio: pressure: rohm-bm1390: Fix AVE_NUM initialization
      iio: accel: kionix-kx022a: Fix IPOL macro name

Max Kellermann (1):
      ceph: remove unused field `i_cap_migration_resv`

Maxim Skokov (1):
      bpf: test_run: Fix false -EBADMSG after skb leaves CHECKSUM_COMPLETE

Maxime Bélair (3):
      apparmor: report a label allocation failure as -ENOMEM
      apparmor: fix table_size() integer overflow on 32 bit
      apparmor: convert duplicated dfa transitions to match_char()

Melissa Wen (7):
      drm/amd/display: Signal PQ EOTF in FreeSync infopacket for DP HDR
      drm/amd/display: assign missing trace entry in amdgpu_dm_dc_clocks_state
      drm/amd/display: remove duplicated prev_p_state_change_support assignment
      drm/amd/display: fix vready offset assignment in dcn_optc_lock_unlock_state
      drm/amd/display: use right type for amdgpu_dc_performance event entries
      drm/amd/display: copy function name into dcn_fpu trace event
      drm/amd/display: copy function name into dcn_optc_lock_unlock_state trace event

Miaoqing Pan (1):
      wifi: ath11k: fix sporadic WLAN initialization failures

Michael Auer (1):
      ASoC: qcom: sdm845: Disable the quaternary MI2S bit clock on shutdown

Michael Klein (1):
      net: phy: realtek: add RTL8211F register defines

Michael S. Tsirkin (2):
      virtio: synchronize callbacks after device reset
      virtio_pci_modern: move avq cleanup from reset to del_vqs

Michael Straube (3):
      staging: rtl8723bs: remove return from void function
      staging: rtl8723bs: remove wrapper rtw_init_recv_timer
      staging: rtl8723bs: move rtw_recv_indicatepkt to rtw_recv.c

Michail Andreas Michalopoulos (2):
      ksmbd: reject FILE_ATTRIBUTE_TEMPORARY on directories
      ksmbd: select CRYPTO_AES

Michal Koutný (1):
      selftests: cgroup: Optionally set up v1 environment

Michał Kopeć (2):
      ASoC: mediatek: common: Keep codec references until the card is bound
      ASoC: mediatek: mt8188: Constrain UL8 FE to its back end's capabilities

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

Mikhail Gavrilov (1):
      drm/amd/display: set allow_freesync before validating a new stream

Mikhail Lobanov (1):
      wifi: ath11k: modify null check logic in ath11k_ce_rx_post_pipe()

Mikko Perttunen (3):
      drm/tegra: Fix syncobj_in wait return value check
      drm/tegra: Don't pass an ERR_PTR to drm_syncobj_replace_fence()
      drm/tegra: Drop reference on postfence

Miklos Szeredi (1):
      fuse: fall back to copy_splice_read() on FOPEN_DIRECT_IO

Mikulas Patocka (1):
      dm-snapshot: make the chunk list sorted by the chunk number

Miles Krause (2):
      memory: emif: fix device_node reference leak on np_ddr
      leds: lp8860: Fix device_node leak in lp8860_probe()

Mingming Cao (4):
      ibmveth: fix netpoll races with RX replenish
      ibmveth: return the error when set_channels cannot add TX queues
      ibmveth: wait for in-flight transmits in ibmveth_close()
      ibmveth: wait for the RX poll to return before freeing the RX queue

Mingpei CAO (1):
      libbpf: Reject local struct_ops bitfields before data access

Mingxuan Guo (1):
      firmware: cs_dsp: clear dsp->running on the cs_dsp_run() error path

Miquel Raynal (Schneider Electric) (1):
      clk: Use the generic OF phandle parsing in only one place

Mohamad Raizudeen (2):
      crypto: amlogic - Fix DMA memory leak in cipher error path
      PCI: Fix out-of-bounds MMIO read in nvme_disable_and_flr()

Mohammed Alquraini (1):
      ksmbd: reject foreign RPC pipe handles on IPC$ read and write

Mohd Ayaan Anwar (1):
      arm64: dts: qcom: lemans-ride-common: fix SerDes PHY regulator supplies

Mostafa Saleh (2):
      iommu/arm-smmu-v3: Ensure L2 tables are visible before L1 ptrs
      iommu/arm-smmu-v3-test: Fix arm_smmu_v3_test_debug_print_used_bits()

Muchun Song (3):
      dax/bus: Return errors for invalid mapping targets
      block: remove redundant explicit memory barrier from rq_qos waiter and waker
      block: introduce init_wait_func()

Muhammad Bilal (3):
      platform/x86: hp-bioscfg: fix off-by-one in password length check
      platform/x86: hp-bioscfg: validate SPM state returned by firmware
      platform/x86: hp-bioscfg: fix oops on short integer attribute buffer

Mukesh Ojha (1):
      firmware: qcom: tzmem: Use DO_ONCE_SLEEPABLE() in qcom_tzmem_enable()

Muzaffer Kadir (1):
      dt-bindings: vendor-prefixes: Add General Mobile

Myeonghun Pak (13):
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
      platform: cznic: turris-omnia-mcu: stop button emulation producers
      net: hix5hd2: serialize timeout recovery with interface teardown
      platform/x86: gpd pocket fan: Cancel work before releasing GPIOs

Namhyung Kim (2):
      perf c2c: Fix memory leaks on output fields
      perf tools: Fix compile error on sample->user_regs

Namjae Jeon (1):
      ksmbd: fix fd_limit accounting across durable reconnects

Nandor Kracser (1):
      tls: avoid field-spanning write when copying crypto info

Naveen Kumar Chaudhary (1):
      kdb: unify CMD_BUFLEN definition into kdb_private.h

Neil Armstrong (1):
      dt-bindings: vendor-prefixes: add vendor prefix for Nexperia B.V.

Nguyen Ngoc Thang (4):
      md: take reconfig_mutex when enabling PPL on an inactive array
      ocfs2: validate chunk and block counts of the local quota file
      libceph: reject bad connect_seq in msgr1 READY reply
      minix: reject rmdir of a directory with a corrupted link count

Nguyễn Văn Cao Nguyên (1):
      RDMA/irdma: Do not move a fresh RoCE QP to ERROR on RESET

Nick Huang (1):
      rtc: s35390a: use u8 instead of char for register buffer

Nickolai Zeldovich (5):
      proc/kcore: advance the vmalloc retry by the last copy, not the total
      nsproxy: Fix cred leak in the error path of prepare_nsset()
      splice: retry tee() instead of returning 0 when it races
      ucount: read the parent ucounts before dropping the rlimit count
      fs_pin: do not trust the pin after a spurious wakeup in pin_kill()

Nicolai Buchwitz (8):
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

Nicolas Frattaroli (1):
      drm/panthor: Take reqs_lock in soft_reset for clearing pending_reqs

Nicolas Morey (1):
      RDMA/rxe: Use validated num_sge in local buffer

Nicolas Saenz Julienne (1):
      x86/efi: Drop support for the EFI_PROPERTIES_TABLE

Nicolas Schier (1):
      kconfig: tests: Provide defconfig outfile for savedefconfig

Nicolo Giuliani (1):
      dt-bindings: vendor-prefixes: Add Sophos

Nikhil P. Rao (1):
      ionic: fix port_info use-after-free on firmware recovery

Niklas Cassel (6):
      scsi: scsi_debug: Refuse a negative physblk_exp
      scsi: scsi_debug: Take the zone metadata lock before the data lock
      scsi: scsi_debug: Refuse a short WRITE ATOMIC (16) before writing it
      scsi: scsi_debug: Map the region written by WRITE ATOMIC (16)
      scsi: scsi_debug: Validate the access parameters of WRITE ATOMIC (16)
      scsi: libsas: Add dev_parent_is_expander() helper

Niko Huuskonen (2):
      ALSA: caiaq: Serialize access to the EP1 command buffer
      ALSA: caiaq: Fix the Kore controller key map

Nikolay Borisov (1):
      ata: sata_dwc_460ex: Don't enable interrupt if libATA core registration fails

Nora Schiffer (1):
      ARM: dts: imx7-tqma7: correctly specify PMIC voltage constraints

Oleg Keri (1):
      drm/msm/dp: don't report link training success after a reinit

Omar Ramadan (1):
      amt: pull the AMT header behind the transport header in amt_parse_type()

Orgad Shaneh (2):
      staging: octeon: schedule the TX cleanup tasklet every 1024th packet
      MIPS: Octeon: size the swiotlb for a modular OHCI platform driver

Ovidiu Panait (2):
      spi: rspi: Fix DMA mode when the DMA controller is built as a module
      net: stmmac: Track the TX DMA threshold per queue

Pablo Neira Ayuso (1):
      netfilter: flowtable: ensure sufficient headroom in xmit path

Pali Rohár (1):
      cifs: Update description about ACL permissions

Palla Raghunath (1):
      nvmet-fc: don't drop the last assoc reference in nvmet_fc_delete_ctrl()

Pan Chuang (1):
      hwmon: (sht15) Remove redundant dev_err()

Paolo Abeni (1):
      gtp: hold RCU in gtp_genl_send_echo_req()

Patrick Oppenlander (1):
      rpmsg: virtio: EPOLLOUT support

Paul Chaignon (3):
      bpf: Refactor cleanup of bpf_prog_test_run_skb
      bpf: Reorder bpf_prog_test_run_skb initialization
      bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN

Paul Dolan (1):
      selftests/clone3: tighten CLONE_CLEAR_SIGHAND conflict test

Paul Moses (2):
      perf mmap: Use the head selected by read_init
      perf mmap: Preserve the consumed cursor in forward mode

Paul Sajna (1):
      arm64: dts: qcom: sdm845-lg: fix sdcard pinctrl nodes

Pauli Virtanen (3):
      Bluetooth: L2CAP: take chan->lock for l2cap_chan_add/ready/del
      Bluetooth: L2CAP: hold l2cap_conn::lock in l2cap_connect_cfm()
      Bluetooth: L2CAP: hold chan in l2cap_ecred_conn_rsp()

Pedro Falcato (2):
      maple_tree: Use kfree_rcu in ma_free_rcu
      maple_tree: Replace mt_free_one() with kfree()

Pei Xiao (3):
      comedi: dt2811: fix shift-out-of-bounds in IRQ check
      ata: pata_parport: Fix use-after-free in new_device_store
      ata: pata_parport: fix parport attach idr_alloc for

Peijie Shao (1):
      nvme-tcp: fix selinux denied when calling sock_sendmsg

Peng Fan (7):
      remoteproc: imx_dsp_rproc: Drop extra space
      PM: sleep: wakeirq: Introduce device-managed variant of dev_pm_set_wake_irq()
      arm64: dts: imx8dxl-evk: fix reserved memory node names for remoteproc
      arm64: dts: imx8qm-mek: fix reserved memory node names for remoteproc
      arm64: dts: imx8ulp-evk: fix reserved memory node names for remoteproc
      arm64: dts: imx93-14x14-evk: fix reserved memory node names for remoteproc
      arm64: dts: imx93-9x9-qsb: fix reserved memory node names for remoteproc

Pengfei Zhang (1):
      net: stmmac: xgmac: do not treat TBU as a TX event

Pengpeng Hou (31):
      spi: sh-msiof: propagate setup runtime-PM errors
      remoteproc: imx_dsp: Acquire runtime PM before adding carveouts
      irqchip/riscv-imsic: Use GENMASK for base address masks
      memory: brcmstb_dpfe: validate firmware section sizes
      ASoC: es8326: report resume restore errors
      usb: musb: da8xx: depopulate OF children on remove
      usb: musb: da8xx: depopulate OF children on probe failure
      clk: s2mps11: Propagate OF provider registration failures
      clk: si521xx: correct the SI52147 OF output enable map
      clk: milbeaut: Return divider update timeouts
      pmdomain: imx: Propagate SCU provider registration failures
      hwrng: starfive - propagate clock and reset errors
      crypto: starfive - propagate clock and reset errors
      ASoC: adau17x1: return cache sync errors from resume
      ASoC: ak4642: return cache sync errors from resume
      ASoC: es8316: return cache sync errors from resume
      ASoC: nau8540: return cache sync errors from resume
      ASoC: rt1011: return cache sync errors from resume
      ASoC: rt1016: return cache sync errors from resume
      ASoC: rt1305: return cache sync errors from resume
      ASoC: rt1308: return cache sync errors from resume
      ASoC: rt1318: return cache sync errors from resume
      ASoC: rt5616: return cache sync errors from resume
      ASoC: rt5659: return cache sync errors from resume
      ASoC: rt5660: return cache sync errors from resume
      ASoC: rt5665: return cache sync errors from resume
      iio: accel: bma220: publish the SPI driver ACPI alias
      clk: si5351: fail prepare when PLL reset times out
      sh: defconfig: Enable the current M66592 UDC symbol
      wifi: mt76: mt7615: validate MCU response lengths
      irqchip/riscv-imsic: Reject overlapping group index fields

Peter Morrow (1):
      net/mlx4: always create the eth and ib auxiliary devices

Petr Vorel (1):
      checkpatch: skip CamelCase cache for --no-tree without root

Piotr Gliźniewicz (1):
      ALSA: 6fire: take stream_mutex in the Digital Thru control

Prathamesh Deshpande (2):
      RDMA/mlx5: Cancel deferred page-fault EQ work before teardown
      RDMA/mlx5: Cancel software CQ notifications before teardown

Prike Liang (1):
      drm/amdgpu: finish GPU recovery callbacks before restarting schedulers

Priyank Rathod (2):
      PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing
      PCI/AER: Fix struct pci_dev reference leak in aer_process_err_devices()

Priyanka Mani (1):
      ASoC: mediatek: mt8365: Fix out-of-bounds read in get_iir_coef()

Przemek Kitszel (1):
      ice: skip stats handling for channel VSIs on rebuild

Pu Lehui (1):
      bpf: Adjust bpf_func to account for CFI offset in bpf_jit_free on riscv

Puranjay Mohan (1):
      bpf: Implement bpf_send_signal_task() kfunc

Qiliang Yuan (6):
      selftests/bpf: Expect at least one tp_recursion miss in missed
      selftests/bpf: Create the vxlan devices of test_tunnel with their MAC
      selftests/bpf: Keep the bpffs of cgroup_hierarchical_stats private
      selftests/bpf: Unmount the bpffs that cgroup_hierarchical_stats mounted
      selftests/bpf: Expect at least one kprobe miss in missed/perf_kprobe
      selftests/bpf: Run the cpumask map insert tests only for the test task

Qing Zhang (1):
      nvmet: protect nvmet_ports_list with nvmet_config_sem

Qingfang Deng (3):
      mtd: block: prevent reclaim I/O during request processing
      ARM: mvebu: fix Cortex-A9 errata selection for Armada 38x
      pppoe: drop discovery frames with no MAC header

Qingshuang Fu (1):
      selftests/timers: clocksource-switch: Fix unchecked open()/read()

Qiuxu Zhuo (1):
      EDAC/i10nm: Fix Granite Rapids ADXL MC mapping

Qu Wenruo (3):
      btrfs: raid56: do not verify the content if there is no data checksum
      btrfs: refactor read_key_bytes() to remove the dest_folio parameter
      btrfs: qgroup: do not treat "ret > 0" as error when deleting a qgroup

Quanye Yang (3):
      RDMA/rtrs-clt: Reject invalid queue_depth from the peer
      RDMA/rtrs-clt: Don't WARN on unexpected info-response opcode
      RDMA/rtrs-clt: Validate peer-supplied IO completion msg_id

Rafael J. Wysocki (9):
      ACPI: PM: Drop parent state update from acpi_device_get_power()
      ACPI: PCI: Introduce acpi_dev_get_pci_dev()
      ACPI: scan: Stop calling acpi_bus_init_power() early
      ACPI: utils: Adjust message printing macros for ACPI objects
      ACPI: glue: Fix up and adjust acpi_unbind_one()
      ACPI: fan: Fix memory leak due to leftover devm_kcalloc() argument
      ACPI: video: Fix backlight unregistration ordering
      ASoC: amd: acp-es8336: Switch to use acpi_bus_get_primary_device()
      ASoC: amd: acp3x-es83xx: Switch to use acpi_bus_get_primary_device()

Rand Deeb (1):
      ata: libata-core: Ignore forced transfer modes the host does not support

Ranjan Kumar (2):
      scsi: mpi3mr: Event processing debug improvement
      scsi: mpi3mr: Rename log data save helper to reflect threaded/BH context

Raveendra Talabattula (1):
      drm/komeda: Fix bits parsing of GLB_CORE_ID

Ravi Hothi (2):
      ASoC: codecs: wsa884x: Fix VI sense port channel count
      ASoC: codecs: wsa883x: Fix VI sense port channel count

Ren Tamura (1):
      tools/cgroup: sum shrinker object counts across NUMA nodes

Richard Zhu (1):
      arm64: dts: imx95: Avoid 32-bit PCIe window System RAM overlap

Rik van Riel (1):
      mm/memcontrol: fix stuck FLUSHING_CACHED_CHARGE bit on isolated cpus

Rishikesh Jethwani (1):
      tls: device: protect async RX resync state during device-down

Rob Barnes (1):
      platform/chrome: cros_ec_proto: Fix deferred response

Rob Herring (Arm) (2):
      dt-bindings: arm: mediatek: Fix MT6779 audsys compatible
      dt-bindings: clock: mediatek: Add MT8516 fallbacks

Robert Oscilowski (1):
      ASoC: qcom: sdm845: set quaternary MI2S codec DAI to I2S format

Roberto Bergantinos Corpas (2):
      NFS: return DENIED in decode_lock_denied if we cannot decode owner
      nfs: set gencount on protocol-specific remove

Rodrigo Gobbi (1):
      staging: rtl8723bs: change remaining printk to proper api

Roland Dreier (2):
      firmware: arm_scmi: Protect xfer->async_done with xfer->lock
      firmware: arm_scmi: Don't reuse raw xfers with async_done still armed

Roman Demidov (1):
      drm/msm/a6xx: fix use-after-free of OPP in a6xx_pm_resume

Roman Li (1):
      drm/amd/display: Reset DET of HUBPs without a plane before outstanding updates

Rongzheng Wang (1):
      nvmet: use the enabled transport when disabling a port

Rosen Penev (17):
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
      net: phy: marvell: keep WOL_EIE across interrupt reconfiguration
      net: bgmac: fix TX DMA unmapping and slot cleanup

Runyu Xiao (4):
      remoteproc: xlnx: Initialize mailbox work before requesting channels
      ALSA: oxygen: use helper to activate the SPDIF PCM control
      ALSA: via82xx: use helper to activate DXS controls
      ASoC: codecs: wcd937x: request watchdog IRQs without devm

Ruoyu Wang (7):
      pwm: renesas-tpu: Fix runtime PM reference leak
      hwrng: cctrng - Fix runtime PM usage counter leak
      dmaengine: img-mdc: Fix runtime PM usage counter leak
      media: venus: Drop session events without an instance
      misc: nsm: fix CBOR short-length decoding
      perf/dwc_pcie: Fix PCI device reference leak in probe
      xen/pcifront: Fix PCI device reference leak in AER handling

Russell King (Oracle) (1):
      net: phy: realtek: disable PHY-mode EEE

Ryan Brue (1):
      power: supply: bq24190_charger: use the wake irq API

Ryan Leung (4):
      wifi: mt76: mt7915: publish wcid before MCU add commands
      wifi: mt76: fix unlocked wcid check in mt76_tx_status_skb_add()
      wifi: mt76: fix wcid teardown ordering in mt76_reset_device()
      wifi: mt76: fix wcid->pktid corruption in mt76_wcid_cleanup()

Ryusuke Konishi (1):
      nilfs2: fix link count underflow when removing corrupted directory

Sagi Maimon (2):
      net: axienet: free outstanding TX buffers in axienet_dma_bd_release()
      net: axienet: release every RX buffer in axienet_dma_bd_release()

Sahaj Chaudhari (1):
      spi: omap2-mcspi: handle DMA setup failures

Sakari Ailus (1):
      dmaengine: ste_dma40: Remove redundant pm_runtime_mark_last_busy() calls

Salah Triki (2):
      iio: temperature: tmp117: fix calibbias cache update on I2C write failure
      iio: imu: adis16400: Check return value of spi_setup()

Sally Marcher (1):
      ALSA: usb-audio: Add correct datainterval in the quirks-table for Microbook II

Samuel Moelius (1):
      mm/gup_test: reject wrapped user ranges

Sang-Hoon Choi (2):
      md/raid5: protect big_stripe_tree lookup with RCU
      xhci: dbc: lock the minor IDR on registration failure

Sanghyun Park (1):
      bpf: Fix program BTF use-after-free in sleepable programs

Sarthak Sharma (2):
      mm/gup_test: safely calculate GUP batch size
      mm/gup_test: report actual pinned bytes

Sasha Levin (7):
      Revert "x86/mm/pat: Use pr_warn() for early W^X warnings"
      Revert "x86/mm/pat: Fix effective RW computation in lookup_address_in_pgd_attr()"
      tools: hv: remove unused rte_smp_mb()
      kselftest/arm64: signal: copy each test binary only once
      selftests: keep the build status from wrapping to success
      ARC: Strip libgcc debug information when generating BTF
      selftests/thermal: allow cross builds of the Intel tests

Sean Anderson (1):
      selftests: net: csum: Clean up recv_verify_packet_ipv6

Sean Christopherson (1):
      KVM: nSVM: Check validity of vmcs01 save area copied from SMRAM on RSM

Sebastian Reichel (14):
      phy: rockchip: usbdp: Update mode_change after error handling
      phy: rockchip: usbdp: Do not lose USB3 PHY status
      phy: rockchip: usbdp: Fix devm_clk_bulk_get_all check
      phy: rockchip: usbdp: Handle missing clock-names DT property gracefully
      phy: rockchip: usbdp: Drop seamless DP takeover
      phy: rockchip: usbdp: Limit DP lane count to muxed lanes
      phy: rockchip: usbdp: Add missing mode_change update
      phy: rockchip: usbdp: Drop DP HPD handling
      phy: rockchip: usbdp: Properly handle TYPEC_STATE_SAFE and TYPEC_STATE_USB
      phy: rockchip: usbdp: Hold mutex in DP PHY configure
      phy: rockchip: usbdp: Rename mode_change to phy_needs_reinit
      phy: rockchip: usbdp: Avoid xHCI SErrors
      phy: rockchip: usbdp: Handle rk_udphy_reset_deassert errors
      phy: rockchip: usbdp: Only enable USB3 when not in high-speed mode

Selvin Xavier (6):
      RDMA/bnxt_re: Fix integer overflow in send payload size computation
      RDMA/bnxt_re: Detect wrong sge_len passed for inline
      RDMA/bnxt_re: Validate SRQ max_sge at create time
      RDMA/bnxt_re: Initialize wqe.flags in bnxt_re_post_srq_recv()
      RDMA/bnxt_re: Fix the PD and DPI table size
      RDMA/bnxt_re: Use bnxt_ext_stats_supported for counter count selection

SeongJae Park (1):
      mm/damon/reclaim: use parameter context correctly

Serhat Kumral (4):
      RDMA/siw: Fix length of first chunk in siw_try_1seg()
      IB/rdmavt: Fix error unwind path for qp_priv_init() in rvt_create_qp()
      RDMA/srp: Avoid reading uninitialized has_port on srp_parse_in() failure
      RDMA/usnic: Bound buffer size to sizeof(buf) in flowinfo_read()

Shakeel Butt (2):
      kernfs: fix up the unlocked attribute reads on the creation paths
      kernfs: avoid READ_ONCE() on a kgid_t in kernfs_new_node()

Shashank Mohan Jain (3):
      bitmap: bitmap_parse(): reject non-hex character before 8 digits
      bitmap: bitmap_parselist(): reject trailing characters after group size
      bitmap: bitmap_parselist(): don't wrap around on a huge group size

Shengjiu Wang (3):
      remoteproc: imx_dsp_rproc: Add support of recovery and coredump process
      ASoC: fsl_asrc: use regmap_write_bits to update clock source registers
      remoteproc: imx_dsp_rproc: Only reset carveout memory at RPROC_OFFLINE state

Shrikanth Hegde (1):
      powerpc/ftrace: Don't restore r13 during ftrace_regs_caller

Shuangfeng He (1):
      netfilter: flowtable: use the vlan id, not the full tci, in the tuple key

Shubham Antil (1):
      vhost-scsi: zero misaligned I/O bounce pages

Shujath Mohd (1):
      arm64: dts: qcom: sdm845-sony-xperia-tama: Fix Bluetooth UART pinctrl

Shuming Fan (1):
      ASoC: rt712: avoid duplicate reset in io_init

Shyam Sundar S K (2):
      platform/x86/amd/pmc: Use managed APIs for mutex
      platform/x86/amd/pmc: clear devm-managed pointers on remove to prevent stale reuse

Sicong Huang (1):
      nfp: flower: fix use-after-free in neighbour update work

Sivansh Gupta (1):
      mailbox: qcom-cpucp: read mbox hardware register using readq()

Slavin Liu (5):
      ACPI: tables: handle failed initrd override mappings
      crypto: atmel-sha - reject initialization without a device
      clk: starfive: jh7110: reject oscillator lookup errors
      ASoC: fsl_asrc: check the second front-end DMA channel
      clocksource/drivers/dbx500-prcmu: Check timer register mapping

Song Liu (1):
      bpf: Mark dentry->d_inode as trusted_or_null

Srinivas Kandagatla (2):
      ASoC: codecs: wsa884x: disable runtime PM on unbind
      ASoC: codecs: wsa883x: disable runtime PM on unbind

Srinivas Neeli (2):
      dmaengine: xilinx_dma: Fix MCDMA descriptor fields based on DMA direction
      dmaengine: xilinx_dma: Move descriptors to done list based on completion bit

Stefano Munari (1):
      net: usb: lan78xx: reject invalid EEPROM write requests

Stephane Danieau (1):
      pinctrl: stm32: Allow compile as module for stm32mp257

Steven Price (2):
      irqchip/gic-v3-its: Share ITS tables with a non-trusted hypervisor
      irqchip/gic-v3-its: Fix over allocation in itt_alloc_pool()

Steven Rostedt (1):
      cpuidle: haltpoll: Only define guest_halt_poll_ns tracepoint when used

Su Hui (1):
      fs/stat.c: avoid harmless garbage value problem in vfs_statx_path()

Sudeep Holla (3):
      ACPICA: Fix PCC OperationRegion command offsets
      ACPI: PCC: Simplify PCC shared memory region handling
      ACPI: PCC: Preserve shared memory signature in OpRegion handler

Sumeet Pawnikar (1):
      thermal: gov_power_allocator: Fix NULL pointer dereference in update_tz()

Sun Jian (1):
      selftests/bpf: cover short IPv4/IPv6 inputs with adjust_room

Sung Byeongchan (2):
      nvmet-auth: reject undersized AUTH_SEND payloads
      netfilter: xt_dccp: handle reserved options as single-byte

Surabhi Gogte (1):
      nvme-tcp: store and use the caller's network namespace

Szymon Wilczek (1):
      fs/ntfs3: fix deadlock in ni_read_folio_cmpr

TJ Adams (1):
      block: advance iterator after copy-in for SG_DXFER_TO_FROM_DEV

Takahiro Kuwano (1):
      mtd: spi-nor: spansion: Remove s25fs256s0

Takashi Iwai (33):
      ALSA: pcm: Optimize cpu_latency_qos_*() calls
      ALSA: pcm: Prevent O_APPEND open on OSS streams
      ALSA: oxygen: Use guard() for mutex locks
      ALSA: ump: Avoid dereference with max_src_size=0
      ALSA: caiaq: Allow zero-length packet handling for EP1
      ALSA: hda: Fix potential UAF for gating jack
      ALSA: usb-audio: Check mixer matrix size for UAC2/3 at parsing
      ALSA: usb-audio: Fix invalid UAC2/3 mixer unit matrix evaluation
      ALSA: pcmtest: Fix a bogus pointer read in snd_pcmtst_pcm_pointer()
      ALSA: core: Add missing barriers for power_ref vs card->shutdown
      ALSA: seq: Fix missing direction and ump_group handling in 32bit compat ioctl
      ALSA: info: Fix memory leak at card removal
      ALSA: hda: Avoid non-operational GPU warning at regular device removal
      ALSA: hda/intel: Move firmware loading into the probe work
      ALSA: hda: Don't free card at probe error in vga_switcheroo handler
      ALSA: caiaq: Fix races at MIDI URB and trigger accesses
      ALSA: usb-audio: Fix data race at mixer_ctl_feature_info()
      ALSA: usb: us16x08: Fix racy accesses of mixer elements
      ALSA: line6: Reject too small max packet sizes
      ALSA: line6: Fix potential OOB write in line6_capture_copy()
      ALSA: hda: intel: Cancel delayed work at shutdown, too
      ALSA: hda: Add NULL check for the driver pointer at unsol event work
      ALSA: control: Relax __free() variable declarations
      ALSA: jack: Fix kctl free at error in snd_jack_kctl_new()
      ALSA: pcm: Protect delay DMA sync in forward and rewind, too
      ALSA: line6: Use kzalloc() for PCM buffer allocation
      ALSA: usb-audio: Use fixed control index for us16x08 mixer elements
      ALSA: Add simple refcount helper functions
      ALSA: pcm: Add refcount for races between drain and unlink
      ALSA: core: Serialize snd_refcount put and sync
      platform/x86: ibm_rtl: Fix potential OOB read at signature search
      ALSA: seq: Allow system notification in atomic
      ALSA: seq: Notify UMP EP and FB changes

Takashi Sakamoto (1):
      firewire: core: remove unused link field in fw_packet structure

Tal Zussman (7):
      block: use iomap_dirty_folio for block devices
      block: honor IOCB_NOWAIT in the block device buffered read path
      btrfs: drop the extent maps of the written part of a failed ordered extent
      btrfs: update the inode item when removing a free space inode
      ceph: fix error handling when the OSD client is stopping in ceph_submit_write()
      ceph: fix writeback_count leak when a bounce page allocation fails
      ceph: don't clear write_congested when collecting folios

Tao Chen (1):
      bpf: Add show_fdinfo for perf_event

Tao Cui (3):
      sched_ext/scx_flatcg: Make cgv_node_less() wraparound-safe
      blk-iocost: charge zone appends as writes
      blk-iocost: account zone append completions in latency stats

Tapio Reijonen (6):
      gpio: pcf857x: implement get_direction()
      serial: max310x: don't clobber the TX break bit in set_termios
      serial: max310x: fix breaks not reaching the wire in RS485 mode
      serial: max310x: centralize the RS485 transceiver programming
      serial: max310x: fix RS485 delays being programmed as bit-times
      serial: max310x: don't power down the port mid-transmission on close

Tejun Heo (1):
      bpf: sched_ext: Mark ops argument container pointer fields as trusted

Theodor Arsenij Larionov Trichkine (1):
      net: use the full socket in sk_mc_loop()

Thomas Falcon (1):
      perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()

Thomas Fourier (1):
      net: alacritech: fix dma_free_coherent() in error path

Thomas Weißschuh (3):
      microblaze: uaccess: Zero out destination on failed get_user()
      microblaze: Pass -m{big,little}-endian through KBUILD_CPPFLAGS
      nios2: ksyms: Declare __mulsi3 export

Thorsten Blum (2):
      hwrng: intel - return -ENOMEM when kmalloc_obj() fails
      hwrng: intel - return -ENOMEM when ioremap() fails

Tianyi Chen (2):
      selftests/sched_ext: Handle CPU hotplug write failures
      eventpoll: propagate wakeup source creation failure in ep_modify()

Tianyi Gao (1):
      veth: schedule the peer's NAPI after XDP_TX when only GRO is enabled

Tigran Mkrtchyan (2):
      nfsv4/pnfs: use the MDS authflavor for data server connections
      pNFS/flexfiles: make pg_init retry loops killable

Tim Douglas (1):
      serial: pmac_zilog: report received breaks

Ting-Han Hou (6):
      checkkconfigsymbols.py: Parse Git status output line by line
      clang-tools: Import os for broken pipe handling
      scripts/make_fit: Ignore schema checks when decomposing DTBs
      ALSA: virtio: reset I/O message fill level on prepare
      scripts/gdb: fix radix tree lookup pointer handling
      scripts/gdb: fix stack depot out-of-bounds diagnostic

Toke Høiland-Jørgensen (1):
      bpftool: Set BPF_F_XDP_DEV_BOUND_ONLY flag non-destructively

Tony Ambardar (4):
      libbpf: Improve log message formatting
      libbpf: Support BTF.ext loading and output in either endianness
      libbpf: Support opening bpf objects of either endianness
      libbpf: Fix accessing BTF.ext core_relo header

Triet Hoang (1):
      clk: raspberrypi: Handle cpufreq device registration failure

Troy Mitchell (1):
      dt-bindings: vendor-prefixes: Add Sensylink

Tung Nguyen (1):
      tipc: fix refcount panic in tipc_rcv() when receiving shared skb

Udit Kumar (1):
      arm64: dts: ti: k3-j722s-evm: Enable PMIC

Uwe Kleine-König (1):
      serial: Switch back to struct platform_driver::remove()

Uwe Kleine-König (The Capable Hub) (1):
      serial: txx9: Drop noop probe function and dangerous remove callback

Vernon Yang (1):
      selftests/mm: include kselftest.h in vm_util.h

Viacheslav Dubeyko (1):
      ceph: fix generic/421 test failure

Vincent Jardin (1):
      dt-bindings: vendor-prefixes: add Free Mobile

Vincent Mailhol (2):
      can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices
      efi/libstub: make local GUID variables static

Vinod Koul (1):
      dmaengine: zynqmp_dma: drop redundant label

Vladimir Oltean (1):
      net: phy: realtek: create rtl8211f_config_rgmii_delay()

Vlastimil Babka (1):
      mm, slab: add kerneldocs for common SLAB_ flags

Waiman Long (3):
      cgroup/cpuset: Disable cpuset_cpumask_can_shrink() test if not load balancing
      cgroup/cpuset: Run SCHED_DEADLINE shrink test on valid partition root only
      cgroup/cpuset: Make sure compute_partition_effective_cpumask() is only called for valid partition

Waldemar Brodkorb (1):
      sh: Select BINFMT_FLAT_NO_DATA_START_OFFSET for !MMU

WanLi Niu (1):
      bpftool: Make skeleton C++ compatible with explicit casts

WangYuli (1):
      MIPS: Only check -msym32 when need-compiler

Weigang He (4):
      ARM: vexpress: fix device_node refcount leak in vexpress_flags_set()
      ARM: vexpress: fix device_node refcount leak in vexpress_smp_dt_prepare_cpus()
      thermal/drivers/ti-soc-thermal: Cancel pending alert work on remove
      thermal/drivers/sprd: validate the sensor id from the device tree

Weili Qian (1):
      crypto: hisilicon/hpre - remove dma_free_coherent on NULL req->dst in ECDH

Weiming Shi (4):
      fs/ntfs3: take run_lock when freeing offs_folio in ni_decompress_file
      fs/ntfs3: zero frame pages on read error
      ntfs3: fix out-of-bounds read in ntfs_read_mft()
      fs/ntfs3: do not mark frame pages uptodate on read error

Wentao Liang (8):
      clk: versatile: clk-icst: Fix node reference leak in of_syscon_icst_setup()
      RDMA/cxgb4: Fix neigh reference leak in rx_pkt()
      RDMA/cxgb4: Fix skb reference leak in rx_pkt()
      RDMA/mlx5: Fix RQ resource reference leak in mlx5_ib_wq_event()
      RDMA/siw: Fix qp use-after-free in siw_get_base_qp()
      pinctrl: nuvoton: Fix clock reference leak in ma35_get_bank_data()
      pinctrl: stm32: Fix clock reference leak in stm32_pctl_probe()
      apparmor: Fix namespace reference leak in __aa_find_or_create_ns()

Will Deacon (1):
      tools: linux/types.h: Add 128-bit integer types for arm64 UAPI structures

Willem de Bruijn (2):
      selftests: net: csum: filter packets by source address and port
      virtio-net: fix frag overflow in big packets receive

William Palacek (1):
      drm/amdkfd: Validate the control stack of a restored queue

Wilson Felipe Pereira (3):
      selftests/cgroup: test_zswap: fix implicit unsigned promotion bug in test_no_kmem_bypass
      init/main: fix off-by-one in argv_init cleanup
      init/main: fix false-positive kernel panic on environment variable overwrite

Xiang Mei (2):
      fs/ntfs3: validate $SDH entry size in ntfs_insert_security
      ceph: fix off-by-one NUL termination in decode_encrypted_symlink()

Xiang Mei (Microsoft) (2):
      fs/ntfs3: check INDEX_ROOT resident size before use in ntfs_read_mft()
      fs/ntfs3: fix slab-out-of-bounds write in attr_insert_range()

Xiao Liang (1):
      tun: drop batched packets while the device is down

Xilin Wu (1):
      drm/msm/dp: Initialize the debugfs connector pointer

Xin Yin (1):
      writeback: size foreign flushes by target wb dirty pages

Xingui Yang (3):
      scsi: libsas: Fix out-of-bounds memcpy() in sas_ssp_task_response()
      scsi: hisi_sas: Fix incorrect delay values from magic-number cleanup
      scsi: hisi_sas: Fix spinup failure for SAS SSP devices in Active_Wait state

Xingyuan Mo (1):
      sctp: reject forged cookie peer_addr with unknown address family

Xiubo Li (1):
      ceph: mark the superblock active after mounting

Xueqin Luo (5):
      cpuidle: menu: Do not return a disabled idle state
      cpuidle: teo: Do not return a disabled idle state
      cpufreq: sparc-us2e: fix frequency table index copy-paste error
      cpufreq: tegra194: fix double-pointer error in get_cpu_ndiv
      cpufreq: sti: avoid NULL dereference in dev_err()

Yang Xiuwei (1):
      floppy: avoid NULL deref in reset_interrupt when cont is cleared

Yang Zi (1):
      comedi: addi_apci_3xxx: fix subdevice count underallocation

Yao Sang (1):
      nvme: pass partition flags to passthrough checks

Yao Yiqi (1):
      fbcon: Rebuild rotated font buffer on font change

Yaozhong Li (2):
      arm64: dts: rockchip: fix analog headphone output on rk3399-firefly
      arm64: dts: rockchip: disable unused i2s0 on rk3399-firefly

Yemike Abhilash Chandra (1):
      arm64: dts: ti: j722s-evm: Add MUX to control CSI2RX

Yibo Tan (3):
      ASoC: amd: acp-es8336: Use an owned codec device reference
      ASoC: amd: acp3x-es83xx: Keep an owned codec device reference
      soc: qcom: pmic_pdcharger_ulog: prevent work requeue during remove

Yili Zhang (1):
      RDMA/nldev: Fix NULL deref in dumps of objects abandoned by DRIVER_FAILURE

Yingjie Wang (1):
      nvmet: reject keep-alive timeouts that would overflow

Yishai Hadas (5):
      RDMA/hns: Pin CQ buffer writable to match device DMA write access
      RDMA/mlx5: Set WQ event handler before firmware RQ insertion
      RDMA/mlx5: Set SRQ event handler before xarray insertion
      RDMA/mlx5: Set RQ event handler for raw-packet QP
      RDMA/mlx5: Initialize QP/RQ/SQ resource refcount before publishing it

Yizhou Zhao (1):
      9p/xen: drain response work after unbinding IRQ

Yogesh Gaur (9):
      md/raid5: don't BUG() on an inconsistent reshape state from the superblock
      md/raid5: give the io_unit slab caches per-array names
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

Yongzhao Chen (1):
      net: phy: qca83xx: read resolved QCA8337 link status

YouYou Yu (1):
      quota: initialize dquot cache before mounting rootfs

Youngsung Ahn (4):
      RDMA/rxe: refuse to destroy a QP with type 2 MWs still bound
      RDMA/rxe: reject IB_WR_REG_MR from user QPs in rxe_reg_fast_mr()
      RDMA/rxe: validate inline sge_offset in finish_packet() before indexing inline_data[]
      RDMA/rxe: bound the WQE opcode before indexing rxe_wr_opcode_info[]

Yu Zhang (1):
      scsi: target: Fix demo-mode dynamic ACL dev-entry UAF vs LUN teardown

Yuan Chen (4):
      bpftool: Fix spurious batch file read error
      bpftool: Fix out-of-bounds read in kprobe_multi link info dump
      bpftool: Fix inverted tracefs validation when scanning /proc/mounts
      bpf: Claim the per-CPU send_signal irq_work before filling it

Yufan Chen (1):
      io_uring/eventfd: reset deferred signal state

Yuho Choi (5):
      PCI: xgene: Use managed clock for PCIe controller
      USB: pci-quirks: Release EHCI device reference
      soc/tegra: flowctrl: Release OF node reference on error
      bus: arm-cci: Drop CPU node reference in cci_ace_init_ports()
      bus: arm-cci: Drop cci-control-port node reference in __cci_ace_get_port()

Yuri Zaporozhets (1):
      ASoC: dwc: Use OF match data again for StarFive JH7110

Yuya Kusakabe (1):
      seg6: fix HMAC validation when an extension header precedes the SRH

Ze Huang (1):
      drm/imx/lcdc: avoid duplicate clk_per enable

Zhan Xusheng (1):
      fs/ntfs3: fix valid_size not being updated in attr_allocate_frame()

Zhang Yi (1):
      ASoC: codecs: es*: Modify the registers related to ALC RECOVERY

Zhang Yubing (1):
      phy: rockchip: usbdp: Support single-lane DP

ZhangGuoDong (2):
      smb: move smb_sockaddr_in and smb_sockaddr_in6 to common/smb2pdu.h
      smb: move some duplicate definitions to common/smb2pdu.h

Zhihao Cheng (2):
      md/raid5: setup_conf: Fix null-ptr-def in error handling path
      md: Fix the null-ptr-deref of 'mddev->private' while submitting IO

Zhiling Zou (1):
      lib: validate in-memory LZ4 chunk length

Zhiwei Zhang (1):
      RDMA/rxe: Clear pkt->qp before the early drop exits in rxe_rcv()

Zhiyu Zhang (1):
      watch_queue: keep info_id separate from rcu_head

Zhu Ling (1):
      irqchip/gic: Fix UBSAN shift-out-of-bounds in GIC helpers

Zijun Hu (1):
      Bluetooth: btusb: Make btusb_recv_{event,acl}() take struct hci_dev *

Zizhi Wo (2):
      md/raid10: fix missing wakeup in wait_barrier_nolock
      md/raid5: reject a per-device size smaller than one chunk

Zongmin Zhou (1):
      serial: sifive: fix off-by-one in console port bounds check

Zygmunt Krynicki (1):
      apparmor: fail policy unpack on accept2 allocation failure

alex todadze (1):
      net: stmmac: fix rx checksum offload with extended descriptors

bui duc phuc (65):
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
      ASoC: mediatek: mt8365: Handle constraint return value in FE startup
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
      ASoC: rockchip: rk3288_hdmi_analog: Drop redundant probe error messages
      ASoC: rockchip: rk3288_hdmi_analog: Use dev_err_probe() for error handling
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

guolingxing (1):
      btrfs: prevent deleting the wrong subvolume by ID

hpp.iscas (2):
      power: supply: mm8013: Publish the OF module alias
      perf/marvell: cn10k_tad: Publish the OF module alias

pengdonglin (1):
      tracing: Avoid BTF lookup in atomic context

vladimir.oltean@nxp.com (1):
      PCI: dra7xx: Remove device links to PHY

xiongweimin (1):
      RDMA/rxe: Hold netdev reference for transmit skbs

Ömer Mete Kaya (2):
      usbnet: fix smp_processor_id() use in preemptible context
      usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()

Ștefan Ghețu (1):
      ASoC: SOF: imx: Prevent stack OOB read in DSP panic dump

