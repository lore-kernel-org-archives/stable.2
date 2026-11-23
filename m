Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420854;
	b=VifQ8V6+RwmoiBDdAarDmssY9dmuGyP5dukKcgtrPA4Kb4fFNqyNTJ0vrJqkBIlHA6Vf
	 3qcPKxBgnFr9BcMpszHkYR+NOZak6dXd74HbPAK+8TI/crJHh3vmq5wYOgDMxgo/+WPrS
	 ni3xuz4tAdZbCFnjiouyGK7vqK42pbRR740VwVYJ+85VG0mrEiwjPdFZNHwkjVrGm44t+
	 XP0H30dKtY1/JN6O2Bo1DCSevprEaC5FaVFqSJAlk+C8cHA8WwiNnEpPSs1h+4zQILkUn
	 I1JlCsm4iTn1AermjN96lBFIz0CZ8Pwf/x7BRaIBNDlPXvzXJP3hmWEwFXPwYlzG92w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420854;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sGD/SHsEtCbP3OArZG6dUvz/xFk5YvcBVozQkogz4zw=;
	b=tHbnNi3TBjrQQwypvU3/QKZNzMJo3cJll36QUTaRxH/9Lnjf/TQONmvCnV+fV+BrxP1b
	 fQfYFHKAsbZylVAG+Ji9Z8tqjUBVuSO8Yz9FO4xylLJ0b/3J0L79apmr42ez6e7yNUsFv
	 5tx5sJws7Fn96TgeDxIYsQ9urHxDTDxcHbeU4RL+tn1qlOE9XD6Of1c5kZHli4i+vSxaH
	 J+ZYnM2BtXLw9w80C0J6HqinsGrwvpYnTi0c0b43iaAKXGTIX+Wo8gr0f8m0BFNPsIQbW
	 k0MEgV1W0JfwsLDaRRu2MJSQcRxyFcmZlea2UgsQuhm/rFHH+ZAt9f09SFvDqYOKLuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="y/YqpM0+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF17A606A33D;
	Mon, 23 Nov 2026 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=y/YqpM0+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0884C1F000CA;
	Mon, 23 Nov 2026 08:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795420854;
	bh=sGD/SHsEtCbP3OArZG6dUvz/xFk5YvcBVozQkogz4zw=;
	h=From:To:Cc:Subject:Date;
	b=y/YqpM0+9eVpDCvrVTdMd9soOPR5tE2xFn4yyX69CmDvvOE7efWRAkbIYYbTdXi8s
	 TBU/DMZ69pevNekH4Igv+48TfCXI4JgmEzAoK/ZQskhQJjnK5zX/JwSzKXe5RnstrY
	 oth0ozTQvhyXPA2f6VImh4jOq8PmqSX+SR5esHv0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.65
Date: Mon, 23 Nov 2026 09:00:03 +0100
Message-ID: <2026112304-jaybird-unnamed-ff62@gregkh>
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

I'm announcing the release of the 6.18.65 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 .gitignore                                                                         |    1 
 Documentation/ABI/stable/sysfs-class-infiniband                                    |  118 
 Documentation/ABI/testing/sysfs-bus-pci                                            |   14 
 Documentation/ABI/testing/sysfs-class-power-mp2629                                 |    2 
 Documentation/admin-guide/LSM/LoadPin.rst                                          |   10 
 Documentation/admin-guide/LSM/ipe.rst                                              |    4 
 Documentation/admin-guide/kernel-parameters.txt                                    |    3 
 Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.yaml                |    2 
 Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml                   |    2 
 Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml                     |    2 
 Documentation/devicetree/bindings/clock/qcom,milos-camcc.yaml                      |   27 
 Documentation/devicetree/bindings/clock/qcom,milos-videocc.yaml                    |   19 
 Documentation/devicetree/bindings/display/msm/hdmi.yaml                            |    4 
 Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml |    2 
 Documentation/devicetree/bindings/dma/stericsson,dma40.yaml                        |   14 
 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml                     |    3 
 Documentation/devicetree/bindings/interrupt-controller/chrp,open-pic.yaml          |    7 
 Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml      |   21 
 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml                        |    1 
 Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml      |   76 
 Documentation/devicetree/bindings/vendor-prefixes.yaml                             |   20 
 Documentation/leds/leds-st1202.rst                                                 |    5 
 Documentation/mm/process_addrs.rst                                                 |   14 
 Documentation/networking/netdevices.rst                                            |    9 
 Documentation/networking/psp.rst                                                   |    8 
 Documentation/trace/histogram.rst                                                  |    3 
 Documentation/virt/hyperv/overview.rst                                             |   12 
 Makefile                                                                           |    2 
 arch/alpha/Kconfig                                                                 |    1 
 arch/alpha/mm/fault.c                                                              |   29 
 arch/arc/Makefile                                                                  |    9 
 arch/arc/lib/Makefile                                                              |    8 
 arch/arm/boot/dts/gemini/gemini.dtsi                                               |    2 
 arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi                             |    2 
 arch/arm/boot/dts/marvell/armada-388-helios4.dts                                   |   23 
 arch/arm/boot/dts/marvell/armada-395-gp.dts                                        |    1 
 arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi                                          |   40 
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi                                           |    9 
 arch/arm/boot/dts/st/ste-ab8500.dtsi                                               |    6 
 arch/arm/boot/dts/st/ste-ab8505.dtsi                                               |   23 
 arch/arm/boot/dts/st/ste-dbx5x0.dtsi                                               |    5 
 arch/arm/boot/dts/st/ste-href-ab8500.dtsi                                          |  104 
 arch/arm/boot/dts/st/ste-href-ab8505.dtsi                                          |  118 
 arch/arm/boot/dts/st/stm32mp135.dtsi                                               |   42 
 arch/arm/boot/dts/st/stm32mp135f-dk.dts                                            |    1 
 arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi                                |    2 
 arch/arm/boot/dts/st/stm32mp157c-ev1.dts                                           |    1 
 arch/arm/boot/dts/st/stm32mp157c-lxa-mc1.dts                                       |    2 
 arch/arm/boot/dts/st/stm32mp157f-dk2-scmi.dtsi                                     |    1 
 arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi                                      |    2 
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi                                    |    2 
 arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi                                          |    1 
 arch/arm/include/asm/domain.h                                                      |   17 
 arch/arm/include/asm/memory.h                                                      |    4 
 arch/arm/include/asm/pgtable-2level-hwdef.h                                        |    1 
 arch/arm/include/asm/pgtable-2level.h                                              |    7 
 arch/arm/include/asm/sparsemem.h                                                   |    4 
 arch/arm/kernel/efi.c                                                              |   13 
 arch/arm/mach-mvebu/Kconfig                                                        |    4 
 arch/arm/mach-versatile/platsmp-vexpress.c                                         |    4 
 arch/arm/mach-versatile/v2m.c                                                      |    4 
 arch/arm/mm/Kconfig                                                                |    7 
 arch/arm/mm/alignment.c                                                            |   10 
 arch/arm/mm/dma-mapping.c                                                          |    5 
 arch/arm/mm/ioremap.c                                                              |   53 
 arch/arm/mm/mmu.c                                                                  |   76 
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi                                       |    4 
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi                                  |    9 
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts                               |    4 
 arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dts                                 |    5 
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts                           |   90 
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi                                          |   33 
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts                                      |   14 
 arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso                               |   11 
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts                                       |   32 
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts                                      |   20 
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts                                      |    4 
 arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts                                  |    4 
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts                                    |    4 
 arch/arm64/boot/dts/freescale/imx95.dtsi                                           |    4 
 arch/arm64/boot/dts/mediatek/mt6893-pinfunc.h                                      |    2 
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi                                       |    5 
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                                           |    2 
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi                                     |    5 
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi                                   |    5 
 arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi                                    |    7 
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi                                   |    5 
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi                                    |    5 
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts                                         |  101 
 arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi                                   |    8 
 arch/arm64/boot/dts/qcom/monaco-evk.dts                                            |    3 
 arch/arm64/boot/dts/qcom/purwa.dtsi                                                |    5 
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts                                          |    4 
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi                                     |   13 
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts                                  |    4 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                               |    2 
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi                                  |    1 
 arch/arm64/boot/dts/qcom/x1-crd.dtsi                                               |    1 
 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi                                        |    1 
 arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi                                   |    1 
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                                       |    3 
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi                        |    1 
 arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts                   |    4 
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts                              |    1 
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts                           |    1 
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                                          |    1 
 arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts                          |    1 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                                           |    2 
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts                                    |   32 
 arch/arm64/boot/dts/rockchip/rk3566-base.dtsi                                      |    4 
 arch/arm64/boot/dts/rockchip/rk3568.dtsi                                           |    4 
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi                                      |    1 
 arch/arm64/boot/dts/rockchip/rk3576.dtsi                                           |    2 
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi                                      |    2 
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi                                     |    2 
 arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts                             |    7 
 arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi                                |   20 
 arch/arm64/boot/dts/st/stm32mp231.dtsi                                             |    4 
 arch/arm64/boot/dts/st/stm32mp251.dtsi                                             |    4 
 arch/arm64/boot/dts/ti/k3-am62-verdin-ivy.dtsi                                     |   41 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                                         |   41 
 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi                                   |    2 
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                                            |    2 
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts                                           |    2 
 arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi                                        |    2 
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                                            |    2 
 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi                                      |    2 
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts                                            |   20 
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi                            |    2 
 arch/arm64/include/asm/kvm_host.h                                                  |    1 
 arch/arm64/include/asm/rsi_smc.h                                                   |    2 
 arch/arm64/kernel/pi/Makefile                                                      |    1 
 arch/arm64/kvm/config.c                                                            |   77 
 arch/arm64/kvm/sys_regs.c                                                          |    3 
 arch/arm64/kvm/vgic/vgic-its.c                                                     |   26 
 arch/arm64/net/bpf_jit_comp.c                                                      |   32 
 arch/m68k/apollo/dn_ints.c                                                         |    6 
 arch/m68k/mac/config.c                                                             |   31 
 arch/microblaze/Makefile                                                           |    6 
 arch/microblaze/include/asm/uaccess.h                                              |    3 
 arch/microblaze/kernel/cpu/cpuinfo.c                                               |    1 
 arch/microblaze/kernel/ptrace.c                                                    |    3 
 arch/mips/Makefile                                                                 |   22 
 arch/mips/cavium-octeon/dma-octeon.c                                               |    2 
 arch/nios2/kernel/nios2_ksyms.c                                                    |    1 
 arch/powerpc/kernel/trace/ftrace_entry.S                                           |    6 
 arch/riscv/boot/dts/sophgo/cv180x.dtsi                                             |    2 
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts                                   |    2 
 arch/riscv/boot/dts/starfive/jh7100-common.dtsi                                    |   28 
 arch/riscv/boot/dts/starfive/jh7100.dtsi                                           |   67 
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi                                    |   27 
 arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts                                 |    6 
 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi                              |    6 
 arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts                              |    6 
 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi                |  165 +
 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi                     |    6 
 arch/riscv/boot/dts/starfive/jh7110.dtsi                                           |   67 
 arch/riscv/include/asm/insn.h                                                      |    2 
 arch/riscv/net/bpf_jit_comp64.c                                                    |   14 
 arch/riscv/net/bpf_jit_core.c                                                      |    1 
 arch/s390/kernel/ptrace.c                                                          |    9 
 arch/s390/kernel/uprobes.c                                                         |    2 
 arch/sh/Kconfig                                                                    |    1 
 arch/sh/boards/board-sh7785lcr.c                                                   |    2 
 arch/sh/boot/dts/Makefile                                                          |    2 
 arch/sh/configs/migor_defconfig                                                    |    2 
 arch/sh/configs/sdk7786_defconfig                                                  |    2 
 arch/sh/configs/shx3_defconfig                                                     |    2 
 arch/sh/include/asm/uaccess_32.h                                                   |    8 
 arch/um/include/shared/skas/stub-data.h                                            |    9 
 arch/um/kernel/skas/syscall.c                                                      |    5 
 arch/x86/boot/string.c                                                             |   13 
 arch/x86/include/asm/cpufeature.h                                                  |    2 
 arch/x86/include/asm/cpufeatures.h                                                 |    5 
 arch/x86/include/asm/cpuid/api.h                                                   |    2 
 arch/x86/include/asm/shared/string.h                                               |   52 
 arch/x86/include/asm/string.h                                                      |    7 
 arch/x86/include/asm/svm.h                                                         |    4 
 arch/x86/kernel/cpu/common.c                                                       |    8 
 arch/x86/kernel/cpu/mshyperv.c                                                     |   27 
 arch/x86/kernel/cpu/scattered.c                                                    |    3 
 arch/x86/kernel/crash.c                                                            |    6 
 arch/x86/kernel/fpu/xstate.c                                                       |    7 
 arch/x86/kvm/reverse_cpuid.h                                                       |    1 
 arch/x86/kvm/svm/nested.c                                                          |   23 
 arch/x86/kvm/svm/svm.c                                                             |    2 
 arch/x86/kvm/svm/svm.h                                                             |    2 
 arch/x86/platform/pvh/enlighten.c                                                  |    5 
 arch/x86/power/hibernate.c                                                         |   51 
 block/bdev.c                                                                       |   12 
 block/bfq-iosched.c                                                                |    4 
 block/blk-cgroup.c                                                                 |   19 
 block/blk-cgroup.h                                                                 |    6 
 block/blk-flush.c                                                                  |    8 
 block/blk-iocost.c                                                                 |  310 +-
 block/blk-iolatency.c                                                              |    3 
 block/blk-map.c                                                                    |    1 
 block/blk-mq-tag.c                                                                 |   27 
 block/blk-mq.c                                                                     |  147 
 block/blk-mq.h                                                                     |    4 
 block/blk-throttle.c                                                               |   25 
 block/blk-timeout.c                                                                |    3 
 block/blk-zoned.c                                                                  |   82 
 block/blk.h                                                                        |   14 
 block/fops.c                                                                       |  117 
 block/partitions/mac.c                                                             |    4 
 crypto/algapi.c                                                                    |   23 
 crypto/asymmetric_keys/verify_pefile.c                                             |    5 
 crypto/lskcipher.c                                                                 |    6 
 crypto/rsassa-pkcs1.c                                                              |    4 
 crypto/tcrypt.c                                                                    |  182 -
 drivers/accel/amdxdna/amdxdna_gem.c                                                |   26 
 drivers/accel/qaic/qaic_data.c                                                     |    8 
 drivers/accel/rocket/rocket_job.c                                                  |    2 
 drivers/acpi/Kconfig                                                               |    2 
 drivers/acpi/acpi_extlog.c                                                         |   78 
 drivers/acpi/acpi_pcc.c                                                            |   20 
 drivers/acpi/acpi_video.c                                                          |   12 
 drivers/acpi/acpica/dsfield.c                                                      |    3 
 drivers/acpi/acpica/evxfgpe.c                                                      |   50 
 drivers/acpi/acpica/exfield.c                                                      |   11 
 drivers/acpi/acpica/nsxfname.c                                                     |    1 
 drivers/acpi/apei/ghes.c                                                           |   73 
 drivers/acpi/apei/ghes_helpers.c                                                   |   51 
 drivers/acpi/button.c                                                              |   34 
 drivers/acpi/cppc_acpi.c                                                           |   22 
 drivers/acpi/device_pm.c                                                           |   77 
 drivers/acpi/fan_core.c                                                            |    9 
 drivers/acpi/glue.c                                                                |   84 
 drivers/acpi/numa/hmat.c                                                           |    2 
 drivers/acpi/pci_link.c                                                            |    1 
 drivers/acpi/pci_root.c                                                            |   22 
 drivers/acpi/platform_profile.c                                                    |   82 
 drivers/acpi/scan.c                                                                |   40 
 drivers/acpi/tables.c                                                              |    3 
 drivers/acpi/utils.c                                                               |   41 
 drivers/ata/ahci.c                                                                 |   31 
 drivers/ata/libahci.c                                                              |   15 
 drivers/ata/libata-core.c                                                          |   93 
 drivers/ata/libata-scsi.c                                                          |    2 
 drivers/ata/pata_parport/pata_parport.c                                            |    9 
 drivers/ata/sata_dwc_460ex.c                                                       |    5 
 drivers/base/class.c                                                               |    4 
 drivers/base/core.c                                                                |    7 
 drivers/base/node.c                                                                |   17 
 drivers/base/power/runtime.c                                                       |    6 
 drivers/block/drbd/drbd_main.c                                                     |    1 
 drivers/block/drbd/drbd_receiver.c                                                 |    2 
 drivers/block/floppy.c                                                             |   10 
 drivers/block/null_blk/null_blk.h                                                  |    3 
 drivers/block/null_blk/zoned.c                                                     |    4 
 drivers/block/rnbd/rnbd-srv-sysfs.c                                                |   28 
 drivers/block/rnbd/rnbd-srv.c                                                      |   36 
 drivers/block/rnull/configfs.rs                                                    |    2 
 drivers/block/swim.c                                                               |  287 -
 drivers/block/swim3.c                                                              |    8 
 drivers/block/swim_asm.S                                                           |  136 
 drivers/block/ublk_drv.c                                                           |    9 
 drivers/block/virtio_blk.c                                                         |   11 
 drivers/block/xen-blkback/blkback.c                                                |    7 
 drivers/block/zloop.c                                                              |   84 
 drivers/bluetooth/btintel.c                                                        |    6 
 drivers/bluetooth/btmtk.c                                                          |   88 
 drivers/bluetooth/btmtksdio.c                                                      |   13 
 drivers/bluetooth/btusb.c                                                          |   27 
 drivers/bluetooth/virtio_bt.c                                                      |    4 
 drivers/bus/arm-cci.c                                                              |    6 
 drivers/bus/mhi/host/pci_generic.c                                                 |    5 
 drivers/char/hw_random/cctrng.c                                                    |    7 
 drivers/char/hw_random/intel-rng.c                                                 |    5 
 drivers/char/hw_random/jh7110-trng.c                                               |   39 
 drivers/char/scx200_gpio.c                                                         |    8 
 drivers/clk/bcm/clk-raspberrypi.c                                                  |    2 
 drivers/clk/clk-cdce925.c                                                          |    9 
 drivers/clk/clk-lmk04832.c                                                         |    3 
 drivers/clk/clk-milbeaut.c                                                         |   10 
 drivers/clk/clk-renesas-pcie.c                                                     |    5 
 drivers/clk/clk-s2mps11.c                                                          |   12 
 drivers/clk/clk-si521xx.c                                                          |    2 
 drivers/clk/clk-si5351.c                                                           |   20 
 drivers/clk/clk.c                                                                  |   51 
 drivers/clk/clk.h                                                                  |    5 
 drivers/clk/clkdev.c                                                               |    4 
 drivers/clk/imx/clk-composite-93.c                                                 |   11 
 drivers/clk/mediatek/reset.h                                                       |    6 
 drivers/clk/qcom/clk-alpha-pll.c                                                   |    9 
 drivers/clk/qcom/clk-rcg2.c                                                        |   35 
 drivers/clk/qcom/clk-rpmh.c                                                        |   25 
 drivers/clk/qcom/dispcc-sm8450.c                                                   |    2 
 drivers/clk/qcom/gcc-glymur.c                                                      |   69 
 drivers/clk/qcom/gcc-ipq5424.c                                                     |    4 
 drivers/clk/qcom/gcc-qcs615.c                                                      |    2 
 drivers/clk/qcom/gcc-x1e80100.c                                                    |    6 
 drivers/clk/qcom/lpasscc-sm6115.c                                                  |    4 
 drivers/clk/qcom/mmcc-msm8960.c                                                    |    3 
 drivers/clk/qcom/mmcc-msm8996.c                                                    |    4 
 drivers/clk/qcom/mmcc-sdm660.c                                                     |    2 
 drivers/clk/starfive/clk-starfive-jh7110-sys.c                                     |    3 
 drivers/clk/stm32/clk-stm32mp21.c                                                  |    4 
 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c                                           |   37 
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c                                             |  128 
 drivers/clk/sunxi-ng/ccu_div.h                                                     |   18 
 drivers/clk/ti/adpll.c                                                             |    1 
 drivers/clk/versatile/clk-icst.c                                                   |    4 
 drivers/clocksource/clksrc-dbx500-prcmu.c                                          |    2 
 drivers/clocksource/timer-econet-en751221.c                                        |    1 
 drivers/clocksource/timer-mediatek.c                                               |    4 
 drivers/clocksource/timer-ti-dm.c                                                  |    6 
 drivers/comedi/drivers/addi_apci_3xxx.c                                            |    2 
 drivers/comedi/drivers/comedi_parport.c                                            |    3 
 drivers/comedi/drivers/dmm32at.c                                                   |    3 
 drivers/comedi/drivers/dt2811.c                                                    |    2 
 drivers/comedi/drivers/dt2814.c                                                    |    3 
 drivers/comedi/drivers/ni_atmio16d.c                                               |    4 
 drivers/comedi/drivers/pcmmio.c                                                    |    3 
 drivers/comedi/drivers/pcmuio.c                                                    |    5 
 drivers/cpufreq/amd-pstate-ut.c                                                    |   23 
 drivers/cpufreq/amd-pstate.c                                                       |   31 
 drivers/cpufreq/amd-pstate.h                                                       |   14 
 drivers/cpufreq/qcom-cpufreq-hw.c                                                  |    3 
 drivers/cpufreq/sparc-us2e-cpufreq.c                                               |   11 
 drivers/cpufreq/sti-cpufreq.c                                                      |    4 
 drivers/cpufreq/tegra194-cpufreq.c                                                 |    2 
 drivers/cpuidle/governors/menu.c                                                   |    8 
 drivers/cpuidle/governors/teo.c                                                    |   11 
 drivers/crypto/amlogic/amlogic-gxl-cipher.c                                        |   25 
 drivers/crypto/atmel-aes.c                                                         |    2 
 drivers/crypto/atmel-sha.c                                                         |   17 
 drivers/crypto/ccp/ccp-dev-v3.c                                                    |    4 
 drivers/crypto/ccp/ccp-dev-v5.c                                                    |    4 
 drivers/crypto/ccp/sfs.c                                                           |    9 
 drivers/crypto/hisilicon/hpre/hpre_crypto.c                                        |    2 
 drivers/crypto/inside-secure/eip93/eip93-regs.h                                    |    2 
 drivers/crypto/intel/qat/qat_common/adf_init.c                                     |   24 
 drivers/crypto/intel/qat/qat_common/adf_isr.c                                      |   15 
 drivers/crypto/intel/qat/qat_common/qat_algs.c                                     |   15 
 drivers/crypto/intel/qat/qat_common/qat_asym_algs.c                                |   38 
 drivers/crypto/mxs-dcp.c                                                           |    3 
 drivers/crypto/starfive/jh7110-cryp.c                                              |   20 
 drivers/crypto/talitos.c                                                           |   93 
 drivers/crypto/talitos.h                                                           |    5 
 drivers/cxl/core/core.h                                                            |   18 
 drivers/cxl/core/edac.c                                                            |   30 
 drivers/cxl/core/features.c                                                        |   56 
 drivers/cxl/core/hdm.c                                                             |   68 
 drivers/cxl/core/mce.c                                                             |    8 
 drivers/cxl/core/pci.c                                                             |   24 
 drivers/cxl/core/port.c                                                            |  175 -
 drivers/cxl/core/ras.c                                                             |   39 
 drivers/cxl/core/region.c                                                          |   15 
 drivers/cxl/cxl.h                                                                  |   33 
 drivers/cxl/cxlpci.h                                                               |    7 
 drivers/cxl/mem.c                                                                  |    2 
 drivers/cxl/pci.c                                                                  |   11 
 drivers/cxl/port.c                                                                 |   62 
 drivers/dax/bus.c                                                                  |    8 
 drivers/dma/at_hdmac.c                                                             |   28 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                                     |   37 
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h                                              |    5 
 drivers/dma/fsl_raid.c                                                             |   32 
 drivers/dma/img-mdc-dma.c                                                          |    2 
 drivers/dma/ioat/init.c                                                            |   18 
 drivers/dma/mediatek/mtk-hsdma.c                                                   |   26 
 drivers/dma/mv_xor.c                                                               |    1 
 drivers/dma/plx_dma.c                                                              |   10 
 drivers/dma/sprd-dma.c                                                             |   45 
 drivers/dma/ste_dma40.c                                                            |  434 +-
 drivers/dma/ste_dma40_ll.h                                                         |    2 
 drivers/dma/sun6i-dma.c                                                            |   31 
 drivers/dma/xilinx/xilinx_dma.c                                                    |   37 
 drivers/dma/xilinx/zynqmp_dma.c                                                    |   29 
 drivers/dpll/zl3073x/core.h                                                        |   30 
 drivers/dpll/zl3073x/dpll.c                                                        |  149 
 drivers/dpll/zl3073x/out.h                                                         |   17 
 drivers/dpll/zl3073x/prop.c                                                        |   82 
 drivers/edac/i10nm_base.c                                                          |    1 
 drivers/firmware/arm_scmi/common.h                                                 |   22 
 drivers/firmware/arm_scmi/driver.c                                                 |   38 
 drivers/firmware/arm_scmi/protocols.h                                              |    9 
 drivers/firmware/arm_scmi/raw_mode.c                                               |   30 
 drivers/firmware/cirrus/cs_dsp.c                                                   |    2 
 drivers/firmware/efi/cper.c                                                        |   51 
 drivers/firmware/efi/libstub/efi-stub-entry.c                                      |    4 
 drivers/firmware/efi/libstub/efi-stub-helper.c                                     |   10 
 drivers/firmware/efi/libstub/efi-stub.c                                            |    2 
 drivers/firmware/efi/libstub/efistub.h                                             |    4 
 drivers/firmware/efi/libstub/fdt.c                                                 |    6 
 drivers/firmware/efi/libstub/file.c                                                |    8 
 drivers/firmware/efi/libstub/kaslr.c                                               |    2 
 drivers/firmware/efi/libstub/mem.c                                                 |    2 
 drivers/firmware/efi/libstub/pci.c                                                 |    2 
 drivers/firmware/efi/libstub/random.c                                              |    8 
 drivers/firmware/efi/libstub/riscv-stub.c                                          |    7 
 drivers/firmware/efi/libstub/riscv.c                                               |    2 
 drivers/firmware/efi/libstub/tpm.c                                                 |    8 
 drivers/firmware/efi/libstub/unaccepted_memory.c                                   |    2 
 drivers/firmware/efi/libstub/x86-stub.c                                            |   10 
 drivers/firmware/imx/imx-dsp.c                                                     |    6 
 drivers/firmware/qcom/qcom_tzmem.c                                                 |    2 
 drivers/gpio/gpio-crystalcove.c                                                    |    1 
 drivers/gpio/gpio-pcf857x.c                                                        |   16 
 drivers/gpio/gpiolib.c                                                             |   20 
 drivers/gpu/buddy.c                                                                |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                                         |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c                                       |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                             |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                                            |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                                            |   19 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c                                          |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c                                    |   61 
 drivers/gpu/drm/amd/amdgpu/atom.c                                                  |   82 
 drivers/gpu/drm/amd/amdgpu/atom.h                                                  |    3 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c                                             |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c                                             |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c                                             |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c                                             |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c                                           |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c                                           |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c                                           |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c                                           |    6 
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                                              |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c                                              |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c                                              |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c                                              |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c                                              |    4 
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c                                              |    6 
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                                              |    6 
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c                                              |    6 
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c                                              |   11 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c                                              |    8 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c                                              |   12 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                                              |   12 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                              |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c                                            |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c                                            |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c                                            |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c                                            |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c                                   |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c                                   |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c                                    |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c                                    |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                             |   30 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                                  |   20 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h                            |   38 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                           |    6 
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c                              |   32 
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h                                 |    3 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c                                |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                               |   20 
 drivers/gpu/drm/arm/display/include/malidp_product.h                               |   10 
 drivers/gpu/drm/drm_of.c                                                           |    8 
 drivers/gpu/drm/exynos/exynos_drm_fimd.c                                           |    2 
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c                                                |    3 
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c                                          |   16 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                              |   29 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                              |   77 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c                                        |    3 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                                            |    1 
 drivers/gpu/drm/msm/adreno/adreno_gpu.h                                            |   16 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c                                      |   17 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                                        |   10 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c                               |    4 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c                                           |    9 
 drivers/gpu/drm/msm/dp/dp_ctrl.c                                                   |    3 
 drivers/gpu/drm/msm/dp/dp_debug.c                                                  |    1 
 drivers/gpu/drm/msm/msm_io_utils.c                                                 |    6 
 drivers/gpu/drm/omapdrm/dss/dsi.c                                                  |   63 
 drivers/gpu/drm/panfrost/panfrost_devfreq.c                                        |    2 
 drivers/gpu/drm/panfrost/panfrost_mmu.c                                            |   11 
 drivers/gpu/drm/panthor/panthor_gpu.c                                              |    5 
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c                                     |   16 
 drivers/gpu/drm/tegra/submit.c                                                     |   12 
 drivers/gpu/drm/tiny/appletbdrm.c                                                  |   48 
 drivers/gpu/drm/vc4/vc4_bo.c                                                       |    3 
 drivers/gpu/drm/vc4/vc4_drv.c                                                      |   29 
 drivers/gpu/drm/vc4/vc4_hvs.c                                                      |   10 
 drivers/gpu/drm/vc4/vc4_v3d.c                                                      |    8 
 drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py                                   |   87 
 drivers/gpu/drm/vkms/tests/vkms_format_test.c                                      |   38 
 drivers/gpu/drm/vkms/vkms_formats.c                                                |   55 
 drivers/hid/hid-logitech-hidpp.c                                                   |    1 
 drivers/hid/hid-magicmouse.c                                                       |    4 
 drivers/hid/i2c-hid/i2c-hid-core.c                                                 |   11 
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c                            |    4 
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h                            |    2 
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c                            |    6 
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.h                            |    2 
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c                            |    2 
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h                            |    2 
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c                            |    6 
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.h                            |    2 
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c                       |    2 
 drivers/hid/wacom_wac.c                                                            |   14 
 drivers/hv/hv_common.c                                                             |   10 
 drivers/hv/vmbus_drv.c                                                             |   31 
 drivers/hwmon/chipcap2.c                                                           |  169 -
 drivers/hwmon/coretemp.c                                                           |   29 
 drivers/hwmon/gpd-fan.c                                                            |    1 
 drivers/hwmon/sht15.c                                                              |   26 
 drivers/hwmon/tmp108.c                                                             |   26 
 drivers/hwtracing/coresight/coresight-etm3x-core.c                                 |    8 
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c                                |    7 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                                 |    9 
 drivers/hwtracing/coresight/coresight-sysfs.c                                      |    7 
 drivers/i3c/master/mipi-i3c-hci/core.c                                             |   12 
 drivers/iio/accel/bma220_spi.c                                                     |    3 
 drivers/iio/accel/kionix-kx022a.h                                                  |    2 
 drivers/iio/dac/ad5758.c                                                           |    8 
 drivers/iio/humidity/hts221_core.c                                                 |  106 
 drivers/iio/imu/adis16400.c                                                        |    5 
 drivers/iio/pressure/rohm-bm1390.c                                                 |    4 
 drivers/iio/temperature/tmp117.c                                                   |    9 
 drivers/infiniband/core/device.c                                                   |    7 
 drivers/infiniband/core/lag.c                                                      |   14 
 drivers/infiniband/core/mad.c                                                      |    2 
 drivers/infiniband/core/mad_rmpp.c                                                 |    7 
 drivers/infiniband/core/nldev.c                                                    |    5 
 drivers/infiniband/core/restrack.c                                                 |    3 
 drivers/infiniband/core/sysfs.c                                                    |    9 
 drivers/infiniband/core/uverbs_std_types_device.c                                  |    1 
 drivers/infiniband/core/uverbs_std_types_wq.c                                      |    2 
 drivers/infiniband/core/verbs.c                                                    |    3 
 drivers/infiniband/hw/bnxt_re/hw_counters.c                                        |    6 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                           |   58 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                                          |    9 
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                                           |    2 
 drivers/infiniband/hw/cxgb4/cm.c                                                   |    5 
 drivers/infiniband/hw/cxgb4/provider.c                                             |    5 
 drivers/infiniband/hw/efa/efa_com.c                                                |   28 
 drivers/infiniband/hw/hfi1/sdma.c                                                  |    3 
 drivers/infiniband/hw/hfi1/verbs.c                                                 |    4 
 drivers/infiniband/hw/hns/hns_roce_cq.c                                            |    1 
 drivers/infiniband/hw/hns/hns_roce_device.h                                        |    1 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                         |   55 
 drivers/infiniband/hw/ionic/ionic_controlpath.c                                    |   16 
 drivers/infiniband/hw/ionic/ionic_ibdev.c                                          |    4 
 drivers/infiniband/hw/irdma/ctrl.c                                                 |   14 
 drivers/infiniband/hw/irdma/hw.c                                                   |   14 
 drivers/infiniband/hw/irdma/main.c                                                 |    2 
 drivers/infiniband/hw/irdma/pble.c                                                 |    8 
 drivers/infiniband/hw/irdma/type.h                                                 |    4 
 drivers/infiniband/hw/irdma/verbs.c                                                |   13 
 drivers/infiniband/hw/mlx4/main.c                                                  |    4 
 drivers/infiniband/hw/mlx5/cq.c                                                    |    5 
 drivers/infiniband/hw/mlx5/fs.c                                                    |   49 
 drivers/infiniband/hw/mlx5/main.c                                                  |   56 
 drivers/infiniband/hw/mlx5/odp.c                                                   |    2 
 drivers/infiniband/hw/mlx5/qp.c                                                    |    8 
 drivers/infiniband/hw/mlx5/qpc.c                                                   |    8 
 drivers/infiniband/hw/mlx5/srq.c                                                   |    3 
 drivers/infiniband/hw/mlx5/wr.c                                                    |    1 
 drivers/infiniband/hw/usnic/usnic_debugfs.c                                        |    2 
 drivers/infiniband/sw/rdmavt/qp.c                                                  |    2 
 drivers/infiniband/sw/rxe/rxe_loc.h                                                |    8 
 drivers/infiniband/sw/rxe/rxe_mr.c                                                 |   12 
 drivers/infiniband/sw/rxe/rxe_mw.c                                                 |    3 
 drivers/infiniband/sw/rxe/rxe_net.c                                                |   70 
 drivers/infiniband/sw/rxe/rxe_odp.c                                                |    9 
 drivers/infiniband/sw/rxe/rxe_qp.c                                                 |   10 
 drivers/infiniband/sw/rxe/rxe_recv.c                                               |    9 
 drivers/infiniband/sw/rxe/rxe_req.c                                                |   11 
 drivers/infiniband/sw/rxe/rxe_resp.c                                               |   23 
 drivers/infiniband/sw/rxe/rxe_verbs.h                                              |    1 
 drivers/infiniband/sw/siw/siw_main.c                                               |    5 
 drivers/infiniband/sw/siw/siw_qp_tx.c                                              |   20 
 drivers/infiniband/ulp/ipoib/ipoib_main.c                                          |    7 
 drivers/infiniband/ulp/isert/ib_isert.c                                            |    2 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                                             |   32 
 drivers/infiniband/ulp/srp/ib_srp.c                                                |    9 
 drivers/interconnect/qcom/icc-rpm.c                                                |   11 
 drivers/interconnect/qcom/icc-rpm.h                                                |    4 
 drivers/interconnect/qcom/smd-rpm.c                                                |    8 
 drivers/interconnect/samsung/exynos.c                                              |    1 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c                                   |    4 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                                        |    6 
 drivers/iommu/intel/dmar.c                                                         |   73 
 drivers/iommu/intel/iommu.c                                                        |  173 -
 drivers/iommu/intel/iommu.h                                                        |    1 
 drivers/iommu/intel/nested.c                                                       |    2 
 drivers/iommu/iommufd/device.c                                                     |    8 
 drivers/irqchip/irq-gic-common.c                                                   |    2 
 drivers/irqchip/irq-gic-v3-its.c                                                   |   20 
 drivers/irqchip/irq-gic-v3.c                                                       |   15 
 drivers/irqchip/irq-gic.c                                                          |    4 
 drivers/irqchip/irq-mips-gic.c                                                     |   59 
 drivers/irqchip/irq-riscv-imsic-state.c                                            |   21 
 drivers/leds/led-class-flash.c                                                     |    2 
 drivers/leds/leds-lm3692x.c                                                        |    4 
 drivers/leds/leds-lp8860.c                                                         |    5 
 drivers/leds/leds-pca9532.c                                                        |    9 
 drivers/leds/leds-st1202.c                                                         |  225 +
 drivers/mailbox/arm_mhu_db.c                                                       |    5 
 drivers/mailbox/arm_mhuv2.c                                                        |   18 
 drivers/mailbox/arm_mhuv3.c                                                        |    5 
 drivers/mailbox/armada-37xx-rwtm-mailbox.c                                         |    4 
 drivers/mailbox/bcm-pdc-mailbox.c                                                  |    5 
 drivers/mailbox/bcm2835-mailbox.c                                                  |    5 
 drivers/mailbox/bcm74110-mailbox.c                                                 |    2 
 drivers/mailbox/cv1800-mailbox.c                                                   |    2 
 drivers/mailbox/hi6220-mailbox.c                                                   |    5 
 drivers/mailbox/mailbox-mpfs.c                                                     |    2 
 drivers/mailbox/mailbox-sti.c                                                      |    4 
 drivers/mailbox/pcc.c                                                              |    5 
 drivers/mailbox/qcom-cpucp-mbox.c                                                  |   39 
 drivers/mailbox/qcom-ipcc.c                                                        |   10 
 drivers/mailbox/sprd-mailbox.c                                                     |   12 
 drivers/mailbox/stm32-ipcc.c                                                       |    4 
 drivers/mailbox/sun6i-msgbox.c                                                     |    4 
 drivers/mailbox/tegra-hsp.c                                                        |   11 
 drivers/mailbox/ti-msgmgr.c                                                        |   14 
 drivers/md/dm-snap.c                                                               |   18 
 drivers/md/dm-zone.c                                                               |   54 
 drivers/md/dm.h                                                                    |    3 
 drivers/md/md.c                                                                    |   30 
 drivers/md/raid10.c                                                                |    3 
 drivers/md/raid5-cache.c                                                           |   14 
 drivers/md/raid5-ppl.c                                                             |   12 
 drivers/md/raid5.c                                                                 |   65 
 drivers/media/i2c/ar0521.c                                                         |    1 
 drivers/media/i2c/ov5648.c                                                         |    4 
 drivers/media/platform/qcom/iris/iris_ctrls.c                                      |    2 
 drivers/media/platform/qcom/iris/iris_hfi_gen1_response.c                          |    2 
 drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c                          |    1 
 drivers/media/platform/qcom/iris/iris_instance.h                                   |    4 
 drivers/media/platform/qcom/iris/iris_probe.c                                      |    2 
 drivers/media/platform/qcom/iris/iris_utils.c                                      |    6 
 drivers/media/platform/qcom/iris/iris_utils.h                                      |    1 
 drivers/media/platform/qcom/iris/iris_vb2.c                                        |    6 
 drivers/media/platform/qcom/iris/iris_vidc.c                                       |   42 
 drivers/media/platform/qcom/iris/iris_vpu_common.c                                 |    2 
 drivers/media/platform/qcom/venus/hfi_msgs.c                                       |    3 
 drivers/memory/brcmstb_dpfe.c                                                      |   17 
 drivers/memory/emif.c                                                              |    3 
 drivers/memory/samsung/exynos5422-dmc.c                                            |   11 
 drivers/mfd/da9150-core.c                                                          |    8 
 drivers/mfd/intel_quark_i2c_gpio.c                                                 |   52 
 drivers/mfd/rk8xx-core.c                                                           |    2 
 drivers/misc/enclosure.c                                                           |    3 
 drivers/misc/mei/vsc-tp.c                                                          |   17 
 drivers/misc/nsm.c                                                                 |    7 
 drivers/mtd/mtd_blkdevs.c                                                          |    5 
 drivers/mtd/nand/raw/pl35x-nand-controller.c                                       |    1 
 drivers/mtd/spi-nor/spansion.c                                                     |    7 
 drivers/net/amt.c                                                                  |    8 
 drivers/net/bonding/bond_sysfs.c                                                   |    4 
 drivers/net/can/dev/skb.c                                                          |    2 
 drivers/net/dsa/mt7530.c                                                           |    7 
 drivers/net/dsa/mv88e6xxx/chip.c                                                   |   10 
 drivers/net/ethernet/alacritech/slicoss.c                                          |    2 
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c                               |    2 
 drivers/net/ethernet/broadcom/asp2/bcmasp.c                                        |  121 
 drivers/net/ethernet/broadcom/asp2/bcmasp.h                                        |    4 
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c                                   |   32 
 drivers/net/ethernet/broadcom/bgmac.c                                              |   47 
 drivers/net/ethernet/broadcom/bnge/bnge_resc.c                                     |    6 
 drivers/net/ethernet/broadcom/bnge/bnge_resc.h                                     |    9 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c                                    |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                          |   83 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                                  |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                                      |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h                                      |    7 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                                     |  102 
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                                     |    1 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c                                   |    1 
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c                                   |    1 
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c                                  |    2 
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c                                      |   12 
 drivers/net/ethernet/ibm/ibmveth.c                                                 |  670 +++-
 drivers/net/ethernet/ibm/ibmveth.h                                                 |    5 
 drivers/net/ethernet/intel/ice/ice_lib.c                                           |    4 
 drivers/net/ethernet/intel/ice/ice_ptp.c                                           |   49 
 drivers/net/ethernet/intel/ice/ice_ptp.h                                           |    6 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                                |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c                           |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c                           |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h                           |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c                             |   10 
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c                                   |    2 
 drivers/net/ethernet/mellanox/mlx4/intf.c                                          |   15 
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c                                  |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h                        |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c                           |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h                        |   13 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c                               |   17 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                                  |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                                    |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c                              |    4 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c                      |   66 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h                      |    1 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c                |   11 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c                     |   12 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.h                     |    5 
 drivers/net/ethernet/meta/fbnic/fbnic.h                                            |    7 
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c                                         |   78 
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h                                         |   15 
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c                                     |   25 
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h                                     |    4 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c                                        |    8 
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c                                        |   28 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c                                       |    2 
 drivers/net/ethernet/microchip/fdma/fdma_api.c                                     |   45 
 drivers/net/ethernet/microchip/fdma/fdma_api.h                                     |   20 
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c                              |   17 
 drivers/net/ethernet/microchip/lan966x/lan966x_mac.c                               |    4 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c                              |   19 
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c                               |   10 
 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_calendar.c                   |    8 
 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c                       |    5 
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c                                |    3 
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c                              |   15 
 drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c                                |   10 
 drivers/net/ethernet/netronome/nfp/flower/main.h                                   |    2 
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c                            |   24 
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c                                |    1 
 drivers/net/ethernet/pensando/ionic/ionic_main.c                                   |   13 
 drivers/net/ethernet/qlogic/qede/qede_filter.c                                     |    2 
 drivers/net/ethernet/stmicro/stmmac/descs.h                                        |    6 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c                                 |    2 
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c                                     |   25 
 drivers/net/ethernet/stmicro/stmmac/hwif.h                                         |    6 
 drivers/net/ethernet/stmicro/stmmac/stmmac.h                                       |    1 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                                  |   61 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c                             |    2 
 drivers/net/ethernet/ti/am65-cpts.c                                                |    1 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                                  |   86 
 drivers/net/gtp.c                                                                  |   51 
 drivers/net/hamradio/hdlcdrv.c                                                     |    5 
 drivers/net/ipvlan/ipvtap.c                                                        |    5 
 drivers/net/loopback.c                                                             |    8 
 drivers/net/macsec.c                                                               |    5 
 drivers/net/macvtap.c                                                              |    5 
 drivers/net/phy/marvell.c                                                          |   97 
 drivers/net/phy/qcom/at803x.c                                                      |   98 
 drivers/net/phy/qcom/qca83xx.c                                                     |   58 
 drivers/net/phy/realtek/realtek_main.c                                             |    2 
 drivers/net/ppp/ppp_generic.c                                                      |   95 
 drivers/net/ppp/pppoe.c                                                            |    8 
 drivers/net/pse-pd/si3474.c                                                        |   27 
 drivers/net/team/team_core.c                                                       |   11 
 drivers/net/tun.c                                                                  |   10 
 drivers/net/usb/cdc_mbim.c                                                         |    5 
 drivers/net/usb/cdc_ncm.c                                                          |    7 
 drivers/net/usb/lan78xx.c                                                          |   18 
 drivers/net/usb/usbnet.c                                                           |   28 
 drivers/net/veth.c                                                                 |    7 
 drivers/net/virtio_net.c                                                           |   12 
 drivers/net/vxlan/vxlan_core.c                                                     |    2 
 drivers/net/wireless/ath/ath10k/htt_tx.c                                           |   12 
 drivers/net/wireless/ath/ath11k/Kconfig                                            |    3 
 drivers/net/wireless/ath/ath11k/ahb.c                                              |    7 
 drivers/net/wireless/ath/ath11k/ce.c                                               |    2 
 drivers/net/wireless/ath/ath11k/core.c                                             |   11 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                            |   19 
 drivers/net/wireless/ath/ath11k/mac.c                                              |   33 
 drivers/net/wireless/ath/ath11k/mac.h                                              |    2 
 drivers/net/wireless/ath/ath11k/wmi.c                                              |    9 
 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c                                |    2 
 drivers/net/wireless/ath/ath12k/dp.c                                               |    9 
 drivers/net/wireless/ath/ath12k/mac.c                                              |   21 
 drivers/net/wireless/ath/ath12k/pci.c                                              |   55 
 drivers/net/wireless/ath/ath12k/wmi.c                                              |   11 
 drivers/net/wireless/ath/ath6kl/cfg80211.c                                         |    2 
 drivers/net/wireless/ath/carl9170/debug.c                                          |    5 
 drivers/net/wireless/broadcom/b43/debugfs.c                                        |    2 
 drivers/net/wireless/broadcom/b43legacy/debugfs.c                                  |    2 
 drivers/net/wireless/intel/iwlwifi/mld/low_latency.c                               |    3 
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h                                       |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c                                        |  164 -
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h                                        |    3 
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c                                     |  164 +
 drivers/net/wireless/marvell/mwifiex/cmdevt.c                                      |   10 
 drivers/net/wireless/marvell/mwifiex/fw.h                                          |    6 
 drivers/net/wireless/marvell/mwifiex/init.c                                        |    1 
 drivers/net/wireless/marvell/mwifiex/main.h                                        |    1 
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c                                   |    3 
 drivers/net/wireless/mediatek/mt76/channel.c                                       |   27 
 drivers/net/wireless/mediatek/mt76/mac80211.c                                      |  112 
 drivers/net/wireless/mediatek/mt76/mt76.h                                          |   13 
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c                                    |   18 
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                                    |   13 
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c                                    |   17 
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                                   |   11 
 drivers/net/wireless/mediatek/mt76/mt7915/coredump.c                               |    7 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                                 |    6 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                                   |    7 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                                   |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                                   |   47 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                                    |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                                 |    5 
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c                                |    4 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                                   |   50 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                                    |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h                                 |    5 
 drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c                                |    6 
 drivers/net/wireless/mediatek/mt76/mt792x.h                                        |    2 
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c                                    |    6 
 drivers/net/wireless/mediatek/mt76/mt7996/coredump.c                               |    7 
 drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c                                |  325 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                                   |    6 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                                    |   15 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                                   |  127 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                                    |  321 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                                    |   31 
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                                 |    3 
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h                                   |   36 
 drivers/net/wireless/mediatek/mt76/scan.c                                          |   36 
 drivers/net/wireless/mediatek/mt76/tx.c                                            |    7 
 drivers/net/wireless/mediatek/mt76/usb.c                                           |   16 
 drivers/net/wireless/realtek/rtl8xxxu/core.c                                       |   16 
 drivers/net/wireless/realtek/rtw88/debug.c                                         |    5 
 drivers/net/wireless/realtek/rtw88/sdio.c                                          |   12 
 drivers/net/wireless/silabs/wfx/bh.c                                               |    6 
 drivers/net/wireless/silabs/wfx/bus_sdio.c                                         |    1 
 drivers/net/wireless/silabs/wfx/main.c                                             |   36 
 drivers/nvdimm/pmem.c                                                              |    6 
 drivers/nvme/host/core.c                                                           |    5 
 drivers/nvme/host/fabrics.c                                                        |   30 
 drivers/nvme/host/ioctl.c                                                          |    2 
 drivers/nvme/host/multipath.c                                                      |    4 
 drivers/nvme/host/nvme.h                                                           |    2 
 drivers/nvme/host/tcp.c                                                            |    7 
 drivers/nvme/host/zns.c                                                            |   10 
 drivers/nvme/target/configfs.c                                                     |   24 
 drivers/nvme/target/core.c                                                         |   16 
 drivers/nvme/target/fabrics-cmd-auth.c                                             |    9 
 drivers/nvme/target/fabrics-cmd.c                                                  |    3 
 drivers/nvme/target/fc.c                                                           |   15 
 drivers/nvme/target/io-cmd-bdev.c                                                  |   29 
 drivers/nvme/target/loop.c                                                         |    2 
 drivers/nvme/target/nvmet.h                                                        |    3 
 drivers/nvme/target/rdma.c                                                         |   26 
 drivers/nvme/target/tcp.c                                                          |    7 
 drivers/nvme/target/zns.c                                                          |   12 
 drivers/nvmem/layouts/onie-tlv.c                                                   |    1 
 drivers/nvmem/layouts/sl28vpd.c                                                    |    1 
 drivers/of/irq.c                                                                   |    2 
 drivers/opp/of.c                                                                   |    2 
 drivers/pci/controller/dwc/pci-dra7xx.c                                            |   22 
 drivers/pci/controller/dwc/pcie-qcom.c                                             |   90 
 drivers/pci/controller/dwc/pcie-rcar-gen4.c                                        |   27 
 drivers/pci/controller/pci-aardvark.c                                              |   31 
 drivers/pci/controller/pci-xgene.c                                                 |   11 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                                      |    8 
 drivers/pci/iov.c                                                                  |   25 
 drivers/pci/p2pdma.c                                                               |   59 
 drivers/pci/pci-label.c                                                            |   90 
 drivers/pci/pci.h                                                                  |    4 
 drivers/pci/pcie/aer.c                                                             |    4 
 drivers/pci/probe.c                                                                |   15 
 drivers/pci/pwrctrl/slot.c                                                         |   31 
 drivers/pci/quirks.c                                                               |    2 
 drivers/pci/tph.c                                                                  |    6 
 drivers/pci/xen-pcifront.c                                                         |    5 
 drivers/perf/cxl_pmu.c                                                             |  100 
 drivers/perf/dwc_pcie_pmu.c                                                        |   11 
 drivers/perf/marvell_cn10k_tad_pmu.c                                               |    1 
 drivers/phy/cadence/phy-cadence-sierra.c                                           |   11 
 drivers/phy/hisilicon/phy-hi3670-pcie.c                                            |    4 
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c                                 |   19 
 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c                                  |    8 
 drivers/phy/rockchip/phy-rockchip-usbdp.c                                          |  248 -
 drivers/pinctrl/mediatek/pinctrl-mt7629.c                                          |    2 
 drivers/pinctrl/nuvoton/pinctrl-ma35.c                                             |    8 
 drivers/pinctrl/sprd/pinctrl-sprd.c                                                |    3 
 drivers/pinctrl/stm32/Kconfig                                                      |    2 
 drivers/pinctrl/stm32/pinctrl-stm32.c                                              |    3 
 drivers/pinctrl/sunplus/Kconfig                                                    |    8 
 drivers/platform/chrome/cros_ec_proto.c                                            |   32 
 drivers/platform/chrome/cros_ec_proto_test.c                                       |  158 +
 drivers/platform/chrome/cros_ec_typec.c                                            |  104 
 drivers/platform/cznic/turris-omnia-mcu-gpio.c                                     |   31 
 drivers/platform/olpc/olpc-ec.c                                                    |    2 
 drivers/platform/x86/amd/pmc/pmc.c                                                 |    4 
 drivers/platform/x86/asus-wmi.c                                                    |   32 
 drivers/platform/x86/gpd-pocket-fan.c                                              |    9 
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c                                |    7 
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c                          |    2 
 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c                             |    7 
 drivers/platform/x86/hp/hp-wmi.c                                                   |   24 
 drivers/platform/x86/ibm_rtl.c                                                     |    8 
 drivers/platform/x86/intel/telemetry/core.c                                        |    4 
 drivers/platform/x86/intel/tpmi_power_domains.c                                    |    9 
 drivers/platform/x86/intel/vsec.c                                                  |   15 
 drivers/platform/x86/lenovo/ideapad-laptop.c                                       |   12 
 drivers/platform/x86/msi-ec.c                                                      |    9 
 drivers/pmdomain/imx/scu-pd.c                                                      |   10 
 drivers/power/supply/ab8500_bmdata.c                                               |    2 
 drivers/power/supply/ab8500_btemp.c                                                |   28 
 drivers/power/supply/ab8500_chargalg.c                                             |    9 
 drivers/power/supply/ab8500_charger.c                                              |  400 ++
 drivers/power/supply/ab8500_fg.c                                                   |   27 
 drivers/power/supply/bq24190_charger.c                                             |   39 
 drivers/power/supply/bq2515x_charger.c                                             |   15 
 drivers/power/supply/bq257xx_charger.c                                             |    2 
 drivers/power/supply/generic-adc-battery.c                                         |    3 
 drivers/power/supply/gpio-charger.c                                                |    5 
 drivers/power/supply/mm8013.c                                                      |    1 
 drivers/power/supply/qcom_battmgr.c                                                |   21 
 drivers/pps/generators/pps_gen.c                                                   |   10 
 drivers/ptp/ptp_qoriq.c                                                            |    1 
 drivers/pwm/core.c                                                                 |    1 
 drivers/pwm/pwm-loongson.c                                                         |    2 
 drivers/pwm/pwm-lp3943.c                                                           |    3 
 drivers/pwm/pwm-mtk-disp.c                                                         |    4 
 drivers/pwm/pwm-renesas-tpu.c                                                      |   23 
 drivers/regulator/ab8500.c                                                         |  159 -
 drivers/regulator/fixed.c                                                          |    4 
 drivers/regulator/irq_helpers.c                                                    |   38 
 drivers/regulator/mp886x.c                                                         |   13 
 drivers/regulator/qcom-rpmh-regulator.c                                            |    2 
 drivers/remoteproc/imx_dsp_rproc.c                                                 |   11 
 drivers/remoteproc/imx_rproc.c                                                     |   18 
 drivers/remoteproc/qcom_q6v5_adsp.c                                                |    2 
 drivers/remoteproc/remoteproc_core.c                                               |    3 
 drivers/remoteproc/xlnx_r5_remoteproc.c                                            |    8 
 drivers/rpmsg/mtk_rpmsg.c                                                          |    1 
 drivers/rpmsg/virtio_rpmsg_bus.c                                                   |  104 
 drivers/rtc/Kconfig                                                                |   21 
 drivers/rtc/class.c                                                                |    8 
 drivers/rtc/rtc-abx80x.c                                                           |  103 
 drivers/rtc/rtc-bd70528.c                                                          |    5 
 drivers/rtc/rtc-ds1685.c                                                           |   20 
 drivers/rtc/rtc-ftrtc010.c                                                         |   74 
 drivers/rtc/rtc-mpfs.c                                                             |    4 
 drivers/rtc/rtc-s35390a.c                                                          |  125 
 drivers/s390/net/ism_drv.c                                                         |    3 
 drivers/s390/virtio/virtio_ccw.c                                                   |    6 
 drivers/scsi/ch.c                                                                  |    2 
 drivers/scsi/device_handler/scsi_dh_hp_sw.c                                        |    4 
 drivers/scsi/device_handler/scsi_dh_rdac.c                                         |   10 
 drivers/scsi/elx/libefc/efclib.c                                                   |    2 
 drivers/scsi/hisi_sas/hisi_sas.h                                                   |    3 
 drivers/scsi/hisi_sas/hisi_sas_main.c                                              |   43 
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c                                             |    4 
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c                                             |    4 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                             |   13 
 drivers/scsi/hosts.c                                                               |   15 
 drivers/scsi/libsas/sas_task.c                                                     |    2 
 drivers/scsi/mpi3mr/mpi3mr.h                                                       |    2 
 drivers/scsi/mpi3mr/mpi3mr_app.c                                                   |   47 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                                    |   17 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                                    |  100 
 drivers/scsi/mpi3mr/mpi3mr_transport.c                                             |    7 
 drivers/scsi/pm8001/pm8001_defs.h                                                  |   98 
 drivers/scsi/pm8001/pm8001_hwi.c                                                   |    2 
 drivers/scsi/pm8001/pm8001_hwi.h                                                   |    4 
 drivers/scsi/pm8001/pm80xx_hwi.c                                                   |    2 
 drivers/scsi/pm8001/pm80xx_hwi.h                                                   |  100 
 drivers/scsi/scsi.c                                                                |    7 
 drivers/scsi/scsi_debug.c                                                          |  316 +-
 drivers/scsi/scsi_lib.c                                                            |  101 
 drivers/scsi/scsi_lib_test.c                                                       |   25 
 drivers/scsi/scsi_priv.h                                                           |    1 
 drivers/scsi/scsi_scan.c                                                           |   81 
 drivers/scsi/scsi_sysfs.c                                                          |    5 
 drivers/scsi/scsi_transport_spi.c                                                  |    2 
 drivers/scsi/sd.c                                                                  |   20 
 drivers/scsi/sd.h                                                                  |    2 
 drivers/scsi/sd_zbc.c                                                              |   20 
 drivers/scsi/ses.c                                                                 |    8 
 drivers/scsi/st.c                                                                  |   75 
 drivers/soc/qcom/apr.c                                                             |   44 
 drivers/soc/qcom/pmic_glink.c                                                      |    3 
 drivers/soc/qcom/pmic_pdcharger_ulog.c                                             |    2 
 drivers/soc/qcom/qcom-geni-se.c                                                    |   14 
 drivers/soc/tegra/flowctrl.c                                                       |    7 
 drivers/soundwire/debugfs.c                                                        |   63 
 drivers/soundwire/intel_ace2x.c                                                    |    4 
 drivers/soundwire/intel_auxdevice.c                                                |    2 
 drivers/spi/spi-amlogic-spisg.c                                                    |   43 
 drivers/spi/spi-axi-spi-engine.c                                                   |   20 
 drivers/spi/spi-bcm63xx-hsspi.c                                                    |    1 
 drivers/spi/spi-cs42l43.c                                                          |    8 
 drivers/spi/spi-fsl-spi.c                                                          |   22 
 drivers/spi/spi-meson-spicc.c                                                      |   11 
 drivers/spi/spi-mtk-nor.c                                                          |    1 
 drivers/spi/spi-mxic.c                                                             |    8 
 drivers/spi/spi-omap2-mcspi.c                                                      |  238 +
 drivers/spi/spi-qpic-snand.c                                                       |   30 
 drivers/spi/spi-rockchip-sfc.c                                                     |   21 
 drivers/spi/spi-rspi.c                                                             |   49 
 drivers/spi/spi-sh-msiof.c                                                         |    5 
 drivers/spi/spi-sun4i.c                                                            |   56 
 drivers/spi/spi-tegra114.c                                                         |   49 
 drivers/spi/spi-virtio.c                                                           |    4 
 drivers/spi/spi.c                                                                  |    2 
 drivers/spmi/spmi-pmic-arb.c                                                       |    2 
 drivers/staging/iio/adc/ad7816.c                                                   |   33 
 drivers/staging/media/ipu7/ipu7-isys.c                                             |    1 
 drivers/staging/octeon/ethernet-tx.c                                               |    2 
 drivers/staging/rtl8723bs/core/rtw_mlme.c                                          |   13 
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                                      |    3 
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c                                       |    6 
 drivers/staging/rtl8723bs/core/rtw_recv.c                                          |   24 
 drivers/staging/rtl8723bs/hal/hal_com.c                                            |   13 
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c                                  |    4 
 drivers/staging/rtl8723bs/hal/sdio_halinit.c                                       |    8 
 drivers/staging/rtl8723bs/include/drv_types.h                                      |   41 
 drivers/staging/rtl8723bs/os_dep/os_intfs.c                                        |   15 
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c                                       |   43 
 drivers/staging/sm750fb/sm750.c                                                    |   10 
 drivers/thermal/gov_power_allocator.c                                              |    7 
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c                                        |    8 
 drivers/thermal/renesas/rzg3e_thermal.c                                            |  143 
 drivers/thermal/sprd_thermal.c                                                     |    6 
 drivers/thermal/thermal_trace.h                                                    |    4 
 drivers/thermal/ti-soc-thermal/ti-bandgap.c                                        |   10 
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c                                 |    4 
 drivers/tty/serial/8250/8250.h                                                     |   16 
 drivers/tty/serial/8250/8250_hub6.c                                                |   19 
 drivers/tty/serial/8250/8250_platform.c                                            |    9 
 drivers/tty/serial/8250/8250_uniphier.c                                            |   10 
 drivers/tty/serial/8250/Kconfig                                                    |    4 
 drivers/tty/serial/8250/Makefile                                                   |    2 
 drivers/tty/serial/Kconfig                                                         |    1 
 drivers/tty/serial/ma35d1_serial.c                                                 |    2 
 drivers/tty/serial/max310x.c                                                       |  686 ++++
 drivers/tty/serial/pmac_zilog.c                                                    |    1 
 drivers/tty/serial/serial_core.c                                                   |    4 
 drivers/tty/serial/serial_txx9.c                                                   |   55 
 drivers/tty/serial/sh-sci.c                                                        |   23 
 drivers/tty/serial/sifive.c                                                        |    2 
 drivers/ufs/core/ufshcd.c                                                          |   13 
 drivers/usb/gadget/composite.c                                                     |    2 
 drivers/usb/gadget/function/f_mass_storage.c                                       |    7 
 drivers/usb/gadget/udc/dummy_hcd.c                                                 |    4 
 drivers/usb/host/pci-quirks.c                                                      |    1 
 drivers/usb/host/xhci-dbgtty.c                                                     |    2 
 drivers/usb/image/microtek.c                                                       |    1 
 drivers/usb/mon/mon_main.c                                                         |    3 
 drivers/usb/musb/da8xx.c                                                           |    8 
 drivers/usb/storage/alauda.c                                                       |   95 
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c                                               |    9 
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c                                               |    9 
 drivers/vfio/cdx/main.c                                                            |   10 
 drivers/vfio/device_cdev.c                                                         |   12 
 drivers/vfio/fsl-mc/vfio_fsl_mc.c                                                  |   10 
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c                                     |   14 
 drivers/vfio/pci/vfio_pci_core.c                                                   |    1 
 drivers/vfio/platform/vfio_platform_common.c                                       |   10 
 drivers/vfio/vfio_main.c                                                           |    7 
 drivers/vhost/vringh.c                                                             |    4 
 drivers/video/fbdev/core/fbcon.c                                                   |   57 
 drivers/video/fbdev/gxt4500.c                                                      |    1 
 drivers/virtio/virtio.c                                                            |    2 
 drivers/virtio/virtio_pci_modern.c                                                 |   12 
 fs/btrfs/accessors.c                                                               |    2 
 fs/btrfs/block-group.c                                                             |    6 
 fs/btrfs/ctree.h                                                                   |    2 
 fs/btrfs/defrag.c                                                                  |    2 
 fs/btrfs/disk-io.c                                                                 |   10 
 fs/btrfs/extent-tree.c                                                             |    3 
 fs/btrfs/free-space-cache.c                                                        |   10 
 fs/btrfs/inode.c                                                                   |    4 
 fs/btrfs/ioctl.c                                                                   |   11 
 fs/btrfs/messages.c                                                                |    5 
 fs/btrfs/qgroup.c                                                                  |    4 
 fs/btrfs/raid56.c                                                                  |   11 
 fs/btrfs/tree-mod-log.c                                                            |   13 
 fs/btrfs/verity.c                                                                  |   31 
 fs/btrfs/volumes.c                                                                 |  266 +
 fs/btrfs/volumes.h                                                                 |   38 
 fs/btrfs/zoned.c                                                                   |    8 
 fs/ceph/addr.c                                                                     |   67 
 fs/ceph/inode.c                                                                    |    2 
 fs/ceph/super.c                                                                    |   18 
 fs/ceph/super.h                                                                    |    1 
 fs/dcache.c                                                                        |    2 
 fs/debugfs/file.c                                                                  |   81 
 fs/dlm/config.c                                                                    |   30 
 fs/dlm/dlm_internal.h                                                              |    5 
 fs/dlm/lock.c                                                                      |   18 
 fs/dlm/lock.h                                                                      |    4 
 fs/erofs/data.c                                                                    |    5 
 fs/eventpoll.c                                                                     |   18 
 fs/ext2/file.c                                                                     |    7 
 fs/ext4/inode.c                                                                    |    3 
 fs/f2fs/node.c                                                                     |    4 
 fs/f2fs/super.c                                                                    |   27 
 fs/fs-writeback.c                                                                  |   17 
 fs/fs_pin.c                                                                        |   15 
 fs/fuse/dev.c                                                                      |   26 
 fs/fuse/file.c                                                                     |    5 
 fs/gfs2/bmap.c                                                                     |    2 
 fs/gfs2/inode.c                                                                    |    2 
 fs/hfs/btree.c                                                                     |    7 
 fs/hfsplus/btree.c                                                                 |    7 
 fs/hugetlbfs/inode.c                                                               |    6 
 fs/isofs/dir.c                                                                     |    4 
 fs/isofs/isofs.h                                                                   |   11 
 fs/isofs/joliet.c                                                                  |   27 
 fs/isofs/namei.c                                                                   |    3 
 fs/kernfs/dir.c                                                                    |   90 
 fs/kernfs/file.c                                                                   |   27 
 fs/kernfs/kernfs-internal.h                                                        |    2 
 fs/kernfs/mount.c                                                                  |    2 
 fs/kernfs/symlink.c                                                                |   17 
 fs/minix/inode.c                                                                   |   16 
 fs/minix/minix.h                                                                   |    9 
 fs/minix/namei.c                                                                   |   29 
 fs/netfs/internal.h                                                                |   32 
 fs/nfs/client.c                                                                    |    2 
 fs/nfs/dir.c                                                                       |   13 
 fs/nfs/filelayout/filelayout.c                                                     |    5 
 fs/nfs/flexfilelayout/flexfilelayout.c                                             |   81 
 fs/nfs/fs_context.c                                                                |    1 
 fs/nfs/internal.h                                                                  |   31 
 fs/nfs/nfs3proc.c                                                                  |    8 
 fs/nfs/nfs4client.c                                                                |    7 
 fs/nfs/nfs4proc.c                                                                  |    5 
 fs/nfs/nfs4xdr.c                                                                   |    3 
 fs/nfs/pnfs.c                                                                      |   12 
 fs/nfs/proc.c                                                                      |    8 
 fs/nfs/sysfs.c                                                                     |   16 
 fs/nfs_common/nfslocalio.c                                                         |  101 
 fs/nilfs2/namei.c                                                                  |    8 
 fs/nilfs2/recovery.c                                                               |   17 
 fs/nsfs.c                                                                          |    4 
 fs/ntfs3/attrib.c                                                                  |   10 
 fs/ntfs3/file.c                                                                    |    9 
 fs/ntfs3/frecord.c                                                                 |  180 -
 fs/ntfs3/fsntfs.c                                                                  |  126 
 fs/ntfs3/inode.c                                                                   |   13 
 fs/ntfs3/ntfs_fs.h                                                                 |   20 
 fs/ntfs3/xattr.c                                                                   |    8 
 fs/ocfs2/cluster/heartbeat.c                                                       |   52 
 fs/ocfs2/cluster/tcp.c                                                             |    8 
 fs/ocfs2/dlmglue.c                                                                 |   29 
 fs/ocfs2/dlmglue.h                                                                 |    5 
 fs/ocfs2/export.c                                                                  |   10 
 fs/ocfs2/inode.c                                                                   |    5 
 fs/ocfs2/move_extents.c                                                            |   72 
 fs/ocfs2/namei.c                                                                   |    6 
 fs/ocfs2/quota_local.c                                                             |   24 
 fs/ocfs2/xattr.c                                                                   |  245 +
 fs/ocfs2/xattr.h                                                                   |   12 
 fs/open.c                                                                          |    1 
 fs/overlayfs/overlayfs.h                                                           |    9 
 fs/overlayfs/readdir.c                                                             |   39 
 fs/overlayfs/util.c                                                                |   11 
 fs/pidfs.c                                                                         |   53 
 fs/proc/base.c                                                                     |    8 
 fs/proc/internal.h                                                                 |    1 
 fs/proc/kcore.c                                                                    |    8 
 fs/proc/task_mmu.c                                                                 |    9 
 fs/pstore/ram.c                                                                    |    1 
 fs/pstore/ram_core.c                                                               |    6 
 fs/quota/dquot.c                                                                   |   10 
 fs/resctrl/rdtgroup.c                                                              |    2 
 fs/smb/server/Kconfig                                                              |    1 
 fs/smb/server/smb2pdu.c                                                            |  292 +
 fs/smb/server/smb_common.c                                                         |    4 
 fs/smb/server/smbacl.c                                                             |   41 
 fs/smb/server/transport_tcp.c                                                      |   80 
 fs/smb/server/vfs_cache.c                                                          |   15 
 fs/smb/server/vfs_cache.h                                                          |    3 
 fs/splice.c                                                                        |   43 
 fs/sysfs/dir.c                                                                     |    6 
 fs/sysfs/file.c                                                                    |    8 
 fs/sysfs/mount.c                                                                   |   10 
 fs/sysfs/symlink.c                                                                 |    7 
 fs/sysfs/sysfs.h                                                                   |    4 
 fs/userfaultfd.c                                                                   |   12 
 fs/xattr.c                                                                         |    2 
 fs/xfs/xfs_aops.c                                                                  |    2 
 fs/xfs/xfs_file.c                                                                  |    2 
 fs/xfs/xfs_iomap.c                                                                 |   20 
 fs/xfs/xfs_iomap.h                                                                 |    3 
 fs/xfs/xfs_pnfs.c                                                                  |    9 
 include/acpi/acpi_bus.h                                                            |    9 
 include/acpi/acpi_drivers.h                                                        |    9 
 include/acpi/acpixf.h                                                              |    5 
 include/acpi/ghes.h                                                                |    4 
 include/asm-generic/mshyperv.h                                                     |    2 
 include/asm-generic/vmlinux.lds.h                                                  |    2 
 include/cxl/event.h                                                                |   16 
 include/kvm/arm_vgic.h                                                             |    1 
 include/linux/acpi.h                                                               |   24 
 include/linux/blk-mq.h                                                             |   12 
 include/linux/blkdev.h                                                             |    9 
 include/linux/bpf.h                                                                |   11 
 include/linux/clk-provider.h                                                       |   22 
 include/linux/device-mapper.h                                                      |   10 
 include/linux/device/class.h                                                       |    6 
 include/linux/dibs.h                                                               |    6 
 include/linux/etherdevice.h                                                        |   28 
 include/linux/filter.h                                                             |    9 
 include/linux/firewire.h                                                           |    1 
 include/linux/fortify-string.h                                                     |    2 
 include/linux/huge_mm.h                                                            |    5 
 include/linux/if_bridge.h                                                          |   77 
 include/linux/ipv6.h                                                               |    4 
 include/linux/kernfs.h                                                             |   40 
 include/linux/kexec.h                                                              |    2 
 include/linux/kobject.h                                                            |    4 
 include/linux/kobject_ns.h                                                         |   13 
 include/linux/libata.h                                                             |   76 
 include/linux/mfd/da9150/core.h                                                    |    1 
 include/linux/mm.h                                                                 |    7 
 include/linux/mm_types.h                                                           |   12 
 include/linux/mmap_lock.h                                                          |   54 
 include/linux/mtd/spinand.h                                                        |    2 
 include/linux/netdevice.h                                                          |   31 
 include/linux/netfilter.h                                                          |    7 
 include/linux/nfslocalio.h                                                         |   12 
 include/linux/pci-p2pdma.h                                                         |   21 
 include/linux/ppp_channel.h                                                        |    1 
 include/linux/quotaops.h                                                           |    5 
 include/linux/rcuref.h                                                             |    2 
 include/linux/sched.h                                                              |    5 
 include/linux/shmem_fs.h                                                           |   15 
 include/linux/skbuff.h                                                             |   87 
 include/linux/soc/ti/k3-ringacc.h                                                  |   31 
 include/linux/sunrpc/svc_rdma.h                                                    |    2 
 include/linux/sysfs.h                                                              |   24 
 include/linux/userfaultfd_k.h                                                      |   23 
 include/linux/watch_queue.h                                                        |    6 
 include/net/bluetooth/bluetooth.h                                                  |    4 
 include/net/bluetooth/hci_sync.h                                                   |    1 
 include/net/bluetooth/l2cap.h                                                      |    3 
 include/net/cfg80211.h                                                             |   12 
 include/net/cipso_ipv4.h                                                           |   11 
 include/net/inet_frag.h                                                            |    9 
 include/net/ip.h                                                                   |    2 
 include/net/ip_vs.h                                                                |   50 
 include/net/net_namespace.h                                                        |    8 
 include/net/netfilter/nf_conntrack_seqadj.h                                        |    1 
 include/net/netlabel.h                                                             |   11 
 include/net/netns/netfilter.h                                                      |    2 
 include/net/seg6_hmac.h                                                            |    3 
 include/net/switchdev.h                                                            |    1 
 include/scsi/scsi_cmnd.h                                                           |    7 
 include/scsi/scsi_common.h                                                         |   31 
 include/scsi/scsi_device.h                                                         |   57 
 include/scsi/scsi_host.h                                                           |   33 
 include/scsi/scsi_proto.h                                                          |   65 
 include/scsi/scsi_sense.h                                                          |  950 ++++++
 include/sound/aw88399.h                                                            |  624 ++++
 include/sound/control.h                                                            |    4 
 include/sound/core.h                                                               |   25 
 include/sound/hda-sdw-bpt.h                                                        |    5 
 include/sound/hda_codec.h                                                          |    6 
 include/sound/hdaudio.h                                                            |    2 
 include/sound/pcm.h                                                                |    2 
 include/sound/pcm_oss.h                                                            |    1 
 include/sound/soc-component.h                                                      |    2 
 include/sound/ump.h                                                                |    5 
 include/trace/events/iocost.h                                                      |    7 
 include/trace/events/power.h                                                       |    3 
 include/trace/events/rxrpc.h                                                       |    2 
 include/uapi/linux/firewire-cdev.h                                                 |    4 
 include/uapi/linux/iommufd.h                                                       |    2 
 include/vdso/math64.h                                                              |   20 
 init/main.c                                                                        |    8 
 io_uring/eventfd.c                                                                 |    1 
 kernel/bpf/bpf_iter.c                                                              |   24 
 kernel/bpf/bpf_lsm.c                                                               |    4 
 kernel/bpf/btf.c                                                                   |   27 
 kernel/bpf/core.c                                                                  |   54 
 kernel/bpf/cpumap.c                                                                |   35 
 kernel/bpf/devmap.c                                                                |    1 
 kernel/bpf/helpers.c                                                               |  110 
 kernel/bpf/offload.c                                                               |   25 
 kernel/bpf/stream.c                                                                |   66 
 kernel/bpf/syscall.c                                                               |   43 
 kernel/bpf/task_iter.c                                                             |    6 
 kernel/bpf/verifier.c                                                              |   37 
 kernel/cgroup/cpuset.c                                                             |   31 
 kernel/cgroup/dmem.c                                                               |    4 
 kernel/debug/kdb/kdb_io.c                                                          |    1 
 kernel/debug/kdb/kdb_main.c                                                        |    7 
 kernel/debug/kdb/kdb_private.h                                                     |    3 
 kernel/events/core.c                                                               |    3 
 kernel/fork.c                                                                      |   32 
 kernel/kcov.c                                                                      |   35 
 kernel/kexec_core.c                                                                |    7 
 kernel/kexec_file.c                                                                |    4 
 kernel/module/tracking.c                                                           |    2 
 kernel/nsproxy.c                                                                   |    2 
 kernel/profile.c                                                                   |    2 
 kernel/rcu/rcutorture.c                                                            |    2 
 kernel/rcu/tree.c                                                                  |    2 
 kernel/rcu/tree.h                                                                  |    3 
 kernel/rcu/tree_nocb.h                                                             |   52 
 kernel/reboot.c                                                                    |    4 
 kernel/resource_kunit.c                                                            |    3 
 kernel/sched/core.c                                                                |   60 
 kernel/sched/ext.c                                                                 |   33 
 kernel/sched/fair.c                                                                |    4 
 kernel/sched/idle.c                                                                |    4 
 kernel/sched/rt.c                                                                  |    2 
 kernel/sched/sched.h                                                               |   67 
 kernel/sched/stop_task.c                                                           |    4 
 kernel/sched/syscalls.c                                                            |    7 
 kernel/signal.c                                                                    |    5 
 kernel/time/timeconv.c                                                             |    6 
 kernel/time/timer.c                                                                |    2 
 kernel/time/vsyscall.c                                                             |   26 
 kernel/trace/bpf_trace.c                                                           |   29 
 kernel/trace/trace_btf.c                                                           |    3 
 kernel/trace/trace_events_hist.c                                                   |   25 
 kernel/ucount.c                                                                    |    7 
 kernel/watch_queue.c                                                               |    2 
 kernel/watchdog_perf.c                                                             |    4 
 lib/Kconfig.debug                                                                  |    1 
 lib/bitmap-str.c                                                                   |   24 
 lib/decompress_unlz4.c                                                             |    4 
 lib/kobject.c                                                                      |   10 
 lib/kobject_uevent.c                                                               |   13 
 lib/maple_tree.c                                                                   |   43 
 lib/seq_buf.c                                                                      |    3 
 lib/test_hmm.c                                                                     |    2 
 lib/test_sysctl.c                                                                  |    2 
 lib/tests/seq_buf_kunit.c                                                          |  166 +
 lib/vdso/gettimeofday.c                                                            |    4 
 mm/filemap.c                                                                       |   29 
 mm/gup.c                                                                           |   17 
 mm/gup_test.c                                                                      |   17 
 mm/huge_memory.c                                                                   |   57 
 mm/hugetlb.c                                                                       |   23 
 mm/internal.h                                                                      |   31 
 mm/khugepaged.c                                                                    |   51 
 mm/ksm.c                                                                           |   35 
 mm/madvise.c                                                                       |    6 
 mm/memblock.c                                                                      |    9 
 mm/memcontrol.c                                                                    |    6 
 mm/memory.c                                                                        |  109 
 mm/mmap.c                                                                          |    8 
 mm/mmap_lock.c                                                                     |  150 
 mm/mremap.c                                                                        |   87 
 mm/nommu.c                                                                         |    2 
 mm/oom_kill.c                                                                      |   22 
 mm/page_alloc.c                                                                    |    6 
 mm/rmap.c                                                                          |   20 
 mm/shmem.c                                                                         |   62 
 mm/slab_common.c                                                                   |    4 
 mm/userfaultfd.c                                                                   |   41 
 mm/util.c                                                                          |   13 
 mm/vma.c                                                                           |   58 
 net/9p/trans_xen.c                                                                 |    4 
 net/bluetooth/6lowpan.c                                                            |    3 
 net/bluetooth/hci_core.c                                                           |    4 
 net/bluetooth/hci_event.c                                                          |   58 
 net/bluetooth/hci_sync.c                                                           |   66 
 net/bluetooth/iso.c                                                                |    3 
 net/bluetooth/l2cap_core.c                                                         |   24 
 net/bluetooth/mgmt.c                                                               |  115 
 net/bluetooth/msft.c                                                               |    6 
 net/bpf/test_run.c                                                                 |  170 -
 net/bridge/br_mdb.c                                                                |   16 
 net/bridge/br_multicast.c                                                          |   14 
 net/bridge/br_netlink.c                                                            |    2 
 net/bridge/br_private.h                                                            |   12 
 net/bridge/br_stp.c                                                                |    4 
 net/bridge/br_stp_bpdu.c                                                           |    2 
 net/bridge/br_switchdev.c                                                          |   23 
 net/bridge/br_vlan.c                                                               |    7 
 net/bridge/br_vlan_options.c                                                       |    2 
 net/ceph/messenger_v1.c                                                            |    8 
 net/ceph/osdmap.c                                                                  |    2 
 net/core/bpf_sk_storage.c                                                          |    7 
 net/core/dev.c                                                                     |   79 
 net/core/dev.h                                                                     |    4 
 net/core/dev_addr_lists.c                                                          |  318 ++
 net/core/dev_addr_lists_test.c                                                     |  363 ++
 net/core/dev_api.c                                                                 |    3 
 net/core/dev_ioctl.c                                                               |    6 
 net/core/filter.c                                                                  |   96 
 net/core/gro.c                                                                     |    5 
 net/core/lwtunnel.c                                                                |    6 
 net/core/net-sysfs.c                                                               |   50 
 net/core/net_namespace.c                                                           |    8 
 net/core/netdev-genl.c                                                             |    6 
 net/core/rtnetlink.c                                                               |    1 
 net/core/selftests.c                                                               |    2 
 net/core/skbuff.c                                                                  |   11 
 net/core/sock.c                                                                    |    3 
 net/dcb/dcbnl.c                                                                    |    2 
 net/devlink/region.c                                                               |    5 
 net/ipv4/cipso_ipv4.c                                                              |   16 
 net/ipv4/devinet.c                                                                 |   35 
 net/ipv4/gre_offload.c                                                             |    2 
 net/ipv4/inet_connection_sock.c                                                    |    3 
 net/ipv4/inet_fragment.c                                                           |   66 
 net/ipv4/ip_fragment.c                                                             |   13 
 net/ipv4/ip_output.c                                                               |   15 
 net/ipv4/ip_tunnel.c                                                               |   14 
 net/ipv4/ipmr.c                                                                    |    5 
 net/ipv4/syncookies.c                                                              |   12 
 net/ipv4/tcp.c                                                                     |   26 
 net/ipv4/tcp_bic.c                                                                 |   14 
 net/ipv4/tcp_bpf.c                                                                 |    1 
 net/ipv4/tcp_cubic.c                                                               |   14 
 net/ipv4/tcp_hybla.c                                                               |   16 
 net/ipv4/tcp_ipv4.c                                                                |   17 
 net/ipv4/tcp_metrics.c                                                             |   20 
 net/ipv4/tcp_offload.c                                                             |   12 
 net/ipv6/calipso.c                                                                 |    6 
 net/ipv6/exthdrs.c                                                                 |    2 
 net/ipv6/netfilter/nf_conntrack_reasm.c                                            |   15 
 net/ipv6/reassembly.c                                                              |   13 
 net/ipv6/route.c                                                                   |   20 
 net/ipv6/seg6_hmac.c                                                               |    5 
 net/ipv6/seg6_local.c                                                              |    6 
 net/ipv6/sit.c                                                                     |    4 
 net/ipv6/tcp_ipv6.c                                                                |   56 
 net/l2tp/l2tp_core.c                                                               |   51 
 net/l2tp/l2tp_core.h                                                               |    6 
 net/l2tp/l2tp_debugfs.c                                                            |    4 
 net/l2tp/l2tp_netlink.c                                                            |   11 
 net/l2tp/l2tp_ppp.c                                                                |    8 
 net/mac80211/cfg.c                                                                 |   49 
 net/mac80211/debugfs.c                                                             |    2 
 net/mac80211/ieee80211_i.h                                                         |    4 
 net/mac80211/main.c                                                                |    2 
 net/mac80211/mesh_pathtbl.c                                                        |   17 
 net/mac80211/mlme.c                                                                |   14 
 net/mac80211/rate.c                                                                |    1 
 net/mac80211/rx.c                                                                  |    1 
 net/mac80211/s1g.c                                                                 |    8 
 net/mac80211/tx.c                                                                  |  216 -
 net/mctp/route.c                                                                   |   10 
 net/mptcp/options.c                                                                |    9 
 net/netfilter/core.c                                                               |   18 
 net/netfilter/ipvs/ip_vs_conn.c                                                    |    8 
 net/netfilter/ipvs/ip_vs_ctl.c                                                     |   38 
 net/netfilter/ipvs/ip_vs_dh.c                                                      |   16 
 net/netfilter/ipvs/ip_vs_fo.c                                                      |    2 
 net/netfilter/ipvs/ip_vs_lblc.c                                                    |    4 
 net/netfilter/ipvs/ip_vs_lblcr.c                                                   |    8 
 net/netfilter/ipvs/ip_vs_lc.c                                                      |    2 
 net/netfilter/ipvs/ip_vs_mh.c                                                      |    2 
 net/netfilter/ipvs/ip_vs_nq.c                                                      |    2 
 net/netfilter/ipvs/ip_vs_ovf.c                                                     |    2 
 net/netfilter/ipvs/ip_vs_rr.c                                                      |    2 
 net/netfilter/ipvs/ip_vs_sed.c                                                     |    4 
 net/netfilter/ipvs/ip_vs_sh.c                                                      |    2 
 net/netfilter/ipvs/ip_vs_sync.c                                                    |   23 
 net/netfilter/ipvs/ip_vs_twos.c                                                    |    4 
 net/netfilter/ipvs/ip_vs_wlc.c                                                     |    4 
 net/netfilter/ipvs/ip_vs_wrr.c                                                     |    2 
 net/netfilter/nf_conntrack_core.c                                                  |    5 
 net/netfilter/nf_conntrack_seqadj.c                                                |   17 
 net/netfilter/nf_flow_table_ip.c                                                   |    4 
 net/netfilter/nf_nat_core.c                                                        |   17 
 net/netfilter/nf_nat_proto.c                                                       |    8 
 net/netfilter/nf_synproxy_core.c                                                   |    4 
 net/netfilter/nfnetlink_hook.c                                                     |   77 
 net/netfilter/nft_compat.c                                                         |   15 
 net/netfilter/nft_set_rbtree.c                                                     |    3 
 net/netfilter/xt_dccp.c                                                            |    2 
 net/netlabel/netlabel_kapi.c                                                       |   24 
 net/netlink/af_netlink.c                                                           |   12 
 net/openvswitch/actions.c                                                          |    9 
 net/openvswitch/vport-internal_dev.c                                               |    8 
 net/psp/psp_sock.c                                                                 |   12 
 net/rds/af_rds.c                                                                   |   29 
 net/rds/bind.c                                                                     |    4 
 net/rds/ib_sysctl.c                                                                |    2 
 net/rds/rdma_transport.c                                                           |    3 
 net/rds/rds.h                                                                      |    3 
 net/rds/recv.c                                                                     |   11 
 net/rds/send.c                                                                     |    9 
 net/rds/sysctl.c                                                                   |    2 
 net/rds/tcp.c                                                                      |    5 
 net/rose/af_rose.c                                                                 |   56 
 net/rose/rose_link.c                                                               |    7 
 net/rose/rose_loopback.c                                                           |    7 
 net/rose/rose_route.c                                                              |   65 
 net/rxrpc/rxperf.c                                                                 |   25 
 net/rxrpc/sendmsg.c                                                                |   17 
 net/sched/act_api.c                                                                |   24 
 net/sched/sch_etf.c                                                                |    1 
 net/sched/sch_gred.c                                                               |   16 
 net/sched/sch_taprio.c                                                             |    6 
 net/sctp/ipv6.c                                                                    |    6 
 net/sctp/sm_make_chunk.c                                                           |   24 
 net/sctp/sm_statefuns.c                                                            |    2 
 net/smc/smc_pnet.c                                                                 |   29 
 net/sunrpc/sysfs.c                                                                 |   17 
 net/sunrpc/xprtsock.c                                                              |   34 
 net/switchdev/switchdev.c                                                          |    2 
 net/tipc/bearer.c                                                                  |    4 
 net/tipc/node.c                                                                    |    2 
 net/tls/tls_device.c                                                               |   21 
 net/tls/tls_main.c                                                                 |    4 
 net/wireless/nl80211.c                                                             |    6 
 net/wireless/reg.c                                                                 |   41 
 net/wireless/sme.c                                                                 |   38 
 net/wireless/sysfs.c                                                               |    4 
 rust/helpers/dma.c                                                                 |   11 
 rust/kernel/bitmap.rs                                                              |   17 
 rust/kernel/block/mq/tag_set.rs                                                    |    7 
 rust/kernel/clk.rs                                                                 |   15 
 rust/kernel/configfs.rs                                                            |   63 
 rust/kernel/dma.rs                                                                 |   17 
 rust/kernel/id_pool.rs                                                             |   15 
 rust/kernel/scatterlist.rs                                                         |   12 
 samples/vfs/Makefile                                                               |    1 
 scripts/Makefile.vmlinux                                                           |   20 
 scripts/Makefile.vmlinux_o                                                         |    2 
 scripts/checkkconfigsymbols.py                                                     |    2 
 scripts/checkpatch.pl                                                              |    2 
 scripts/clang-tools/run-clang-tools.py                                             |    1 
 scripts/gdb/linux/radixtree.py                                                     |  197 +
 scripts/gdb/linux/stackdepot.py                                                    |    2 
 scripts/kconfig/conf.c                                                             |   19 
 scripts/kconfig/symbol.c                                                           |   39 
 scripts/kconfig/tests/conftest.py                                                  |    9 
 scripts/kconfig/tests/randconfig_probability/Kconfig                               |   12 
 scripts/kconfig/tests/randconfig_probability/__init__.py                           |  130 
 scripts/kconfig/tests/savedefconfig_range/Kconfig                                  |   60 
 scripts/kconfig/tests/savedefconfig_range/__init__.py                              |    8 
 scripts/kconfig/tests/savedefconfig_range/config                                   |    7 
 scripts/make_fit.py                                                                |    3 
 security/apparmor/af_unix.c                                                        |   27 
 security/apparmor/apparmorfs.c                                                     |   69 
 security/apparmor/capability.c                                                     |    2 
 security/apparmor/domain.c                                                         |   50 
 security/apparmor/include/capability.h                                             |    2 
 security/apparmor/include/cred.h                                                   |   16 
 security/apparmor/include/label.h                                                  |    2 
 security/apparmor/include/match.h                                                  |   11 
 security/apparmor/include/net.h                                                    |    2 
 security/apparmor/include/perms.h                                                  |   15 
 security/apparmor/include/policy.h                                                 |   22 
 security/apparmor/label.c                                                          |   24 
 security/apparmor/lib.c                                                            |    7 
 security/apparmor/lsm.c                                                            |   64 
 security/apparmor/match.c                                                          |   58 
 security/apparmor/mount.c                                                          |    2 
 security/apparmor/net.c                                                            |    8 
 security/apparmor/policy.c                                                         |    3 
 security/apparmor/policy_ns.c                                                      |    6 
 security/apparmor/policy_unpack.c                                                  |   11 
 security/integrity/ima/ima_template.c                                              |    5 
 security/ipe/audit.c                                                               |    8 
 security/security.c                                                                |    3 
 security/selinux/netlabel.c                                                        |    5 
 security/smack/smack_lsm.c                                                         |   14 
 sound/core/control.c                                                               |   12 
 sound/core/control_compat.c                                                        |   21 
 sound/core/control_led.c                                                           |   74 
 sound/core/ctljack.c                                                               |    1 
 sound/core/info.c                                                                  |    3 
 sound/core/init.c                                                                  |   33 
 sound/core/jack.c                                                                  |   11 
 sound/core/misc.c                                                                  |   27 
 sound/core/oss/mixer_oss.c                                                         |   36 
 sound/core/oss/pcm_oss.c                                                           |   12 
 sound/core/pcm.c                                                                   |   13 
 sound/core/pcm_compat.c                                                            |    4 
 sound/core/pcm_lib.c                                                               |   16 
 sound/core/pcm_local.h                                                             |    6 
 sound/core/pcm_native.c                                                            |  122 
 sound/core/rawmidi.c                                                               |    3 
 sound/core/seq/seq_compat.c                                                        |   15 
 sound/core/seq/seq_ump_client.c                                                    |    5 
 sound/core/timer.c                                                                 |    1 
 sound/core/ump.c                                                                   |   61 
 sound/core/vmaster.c                                                               |   10 
 sound/drivers/aloop.c                                                              |   41 
 sound/drivers/pcmtest.c                                                            |   28 
 sound/hda/codecs/realtek/alc269.c                                                  |   51 
 sound/hda/common/bind.c                                                            |   15 
 sound/hda/common/codec.c                                                           |    4 
 sound/hda/common/hda_controller.h                                                  |    4 
 sound/hda/common/hda_jack.h                                                        |    1 
 sound/hda/common/jack.c                                                            |   88 
 sound/hda/controllers/intel.c                                                      |   91 
 sound/hda/core/bus.c                                                               |   30 
 sound/pci/oxygen/oxygen_pcm.c                                                      |   37 
 sound/pci/via82xx.c                                                                |   11 
 sound/sh/aica.c                                                                    |    2 
 sound/soc/amd/acp-es8336.c                                                         |    5 
 sound/soc/amd/acp/acp-platform.c                                                   |    2 
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c                                      |   14 
 sound/soc/amd/ps/ps-pdm-dma.c                                                      |    2 
 sound/soc/amd/ps/ps-sdw-dma.c                                                      |    2 
 sound/soc/amd/raven/acp3x-pcm-dma.c                                                |    4 
 sound/soc/amd/renoir/acp3x-pdm-dma.c                                               |    2 
 sound/soc/amd/vangogh/acp5x-pcm-dma.c                                              |    2 
 sound/soc/amd/yc/acp6x-pdm-dma.c                                                   |    2 
 sound/soc/atmel/atmel-i2s.c                                                        |   43 
 sound/soc/atmel/atmel-pcm-pdc.c                                                    |    2 
 sound/soc/codecs/Kconfig                                                           |    5 
 sound/soc/codecs/Makefile                                                          |    6 
 sound/soc/codecs/ab8500-codec.c                                                    |  560 ---
 sound/soc/codecs/adau17x1.c                                                        |    4 
 sound/soc/codecs/ak4642.c                                                          |    3 
 sound/soc/codecs/aw88081.c                                                         |    2 
 sound/soc/codecs/aw88166.c                                                         |  133 
 sound/soc/codecs/aw88166.h                                                         |    5 
 sound/soc/codecs/aw88261.c                                                         |    2 
 sound/soc/codecs/aw88395/aw88395.c                                                 |    2 
 sound/soc/codecs/aw88395/aw88395_device.c                                          |   39 
 sound/soc/codecs/aw88395/aw88395_device.h                                          |    8 
 sound/soc/codecs/aw88399-lib.c                                                     | 1403 +++++++++
 sound/soc/codecs/aw88399.c                                                         | 1550 ----------
 sound/soc/codecs/aw88399.h                                                         |  587 ---
 sound/soc/codecs/cs42l43-jack.c                                                    |    2 
 sound/soc/codecs/cs42l43.c                                                         |    4 
 sound/soc/codecs/cs42l56.c                                                         |    1 
 sound/soc/codecs/da732x.c                                                          |    2 
 sound/soc/codecs/es8316.c                                                          |    4 
 sound/soc/codecs/es8323.c                                                          |    4 
 sound/soc/codecs/es8326.c                                                          |   34 
 sound/soc/codecs/es8375.c                                                          |   20 
 sound/soc/codecs/es8375.h                                                          |    2 
 sound/soc/codecs/es8389.c                                                          |   47 
 sound/soc/codecs/fs210x.c                                                          |    5 
 sound/soc/codecs/mt6359-accdet.c                                                   |   50 
 sound/soc/codecs/nau8540.c                                                         |    4 
 sound/soc/codecs/nau8822.c                                                         |   71 
 sound/soc/codecs/nau8822.h                                                         |    3 
 sound/soc/codecs/rt1011.c                                                          |    4 
 sound/soc/codecs/rt1015.c                                                          |   86 
 sound/soc/codecs/rt1016.c                                                          |    4 
 sound/soc/codecs/rt1305.c                                                          |    4 
 sound/soc/codecs/rt1308.c                                                          |    4 
 sound/soc/codecs/rt1318.c                                                          |    3 
 sound/soc/codecs/rt5616.c                                                          |    3 
 sound/soc/codecs/rt5645.c                                                          |    7 
 sound/soc/codecs/rt5659.c                                                          |   10 
 sound/soc/codecs/rt5660.c                                                          |    4 
 sound/soc/codecs/rt5663.c                                                          |    6 
 sound/soc/codecs/rt5665.c                                                          |    4 
 sound/soc/codecs/rt5682-sdw.c                                                      |    3 
 sound/soc/codecs/rt711-sdca-sdw.c                                                  |    6 
 sound/soc/codecs/rt711-sdw.c                                                       |    8 
 sound/soc/codecs/rt712-sdca-sdw.c                                                  |    6 
 sound/soc/codecs/rt712-sdca.c                                                      |    5 
 sound/soc/codecs/rt721-sdca-sdw.c                                                  |    6 
 sound/soc/codecs/rt722-sdca-sdw.c                                                  |    6 
 sound/soc/codecs/sma1307.c                                                         |   14 
 sound/soc/codecs/sta32x.c                                                          |  127 
 sound/soc/codecs/sta350.c                                                          |   20 
 sound/soc/codecs/tas2781-fmwlib.c                                                  |    6 
 sound/soc/codecs/tlv320adc3xxx.c                                                   |    2 
 sound/soc/codecs/tlv320aic32x4-clk.c                                               |   68 
 sound/soc/codecs/tlv320aic32x4-i2c.c                                               |   21 
 sound/soc/codecs/tlv320aic32x4-spi.c                                               |   25 
 sound/soc/codecs/tlv320aic32x4.c                                                   |  283 -
 sound/soc/codecs/tlv320aic32x4.h                                                   |    6 
 sound/soc/codecs/wcd-mbhc-v2.c                                                     |    8 
 sound/soc/codecs/wcd937x.c                                                         |   44 
 sound/soc/codecs/wcd939x.c                                                         |   10 
 sound/soc/codecs/wcd939x.h                                                         |    1 
 sound/soc/codecs/wm5100.c                                                          |    2 
 sound/soc/codecs/wm8510.c                                                          |    2 
 sound/soc/codecs/wm8737.c                                                          |    8 
 sound/soc/codecs/wm8750.c                                                          |    2 
 sound/soc/codecs/wm8955.c                                                          |    2 
 sound/soc/codecs/wm8983.c                                                          |    2 
 sound/soc/codecs/wm8985.c                                                          |    2 
 sound/soc/codecs/wm8990.c                                                          |   10 
 sound/soc/codecs/wm8991.c                                                          |   10 
 sound/soc/codecs/wm8994.c                                                          |  159 -
 sound/soc/codecs/wm8994.h                                                          |    2 
 sound/soc/codecs/wm_hubs.c                                                         |    2 
 sound/soc/codecs/wsa883x.c                                                         |    8 
 sound/soc/codecs/wsa884x.c                                                         |    8 
 sound/soc/dwc/dwc-i2s.c                                                            |    6 
 sound/soc/fsl/fsl_asrc.c                                                           |    8 
 sound/soc/fsl/fsl_asrc_dma.c                                                       |    5 
 sound/soc/fsl/fsl_asrc_m2m.c                                                       |    4 
 sound/soc/fsl/imx-pcm-rpmsg.c                                                      |    2 
 sound/soc/intel/atom/sst-atom-controls.c                                           |   38 
 sound/soc/intel/atom/sst-mfld-platform-pcm.c                                       |   36 
 sound/soc/intel/avs/pcm.c                                                          |    2 
 sound/soc/intel/avs/utils.c                                                        |    6 
 sound/soc/intel/boards/sof_es8336.c                                                |    2 
 sound/soc/mediatek/common/mtk-afe-fe-dai.c                                         |    8 
 sound/soc/mediatek/common/mtk-soundcard-driver.c                                   |   23 
 sound/soc/mediatek/mt6797/mt6797-afe-clk.c                                         |   14 
 sound/soc/mediatek/mt8183/mt8183-afe-clk.c                                         |   22 
 sound/soc/mediatek/mt8186/mt8186-afe-clk.c                                         |   95 
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c                                         |  104 
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c                                         |   24 
 sound/soc/mediatek/mt8188/mt8188-mt6359.c                                          |    3 
 sound/soc/mediatek/mt8192/mt8192-afe-clk.c                                         |  139 
 sound/soc/mediatek/mt8192/mt8192-afe-gpio.c                                        |   90 
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c                                         |    6 
 sound/soc/mediatek/mt8192/mt8192-dai-adda.c                                        |   44 
 sound/soc/mediatek/mt8192/mt8192-dai-i2s.c                                         |   20 
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c                                         |   18 
 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c                            |   37 
 sound/soc/mediatek/mt8195/mt8195-afe-clk.c                                         |   77 
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c                                         |   98 
 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c                                        |   99 
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c                                         |    7 
 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c                                         |    2 
 sound/soc/qcom/qdsp6/q6apm.c                                                       |    1 
 sound/soc/qcom/qdsp6/topology.c                                                    |   31 
 sound/soc/qcom/sdm845.c                                                            |   21 
 sound/soc/renesas/rcar/msiof.c                                                     |    6 
 sound/soc/rockchip/rk3288_hdmi_analog.c                                            |   48 
 sound/soc/rockchip/rockchip_i2s.c                                                  |    4 
 sound/soc/rockchip/rockchip_sai.c                                                  |    4 
 sound/soc/samsung/midas_wm1811.c                                                   |   14 
 sound/soc/soc-ac97.c                                                               |    4 
 sound/soc/soc-card-test.c                                                          |    7 
 sound/soc/soc-component.c                                                          |    2 
 sound/soc/soc-link.c                                                               |    2 
 sound/soc/soc-ops.c                                                                |   10 
 sound/soc/soc-topology-test.c                                                      |    8 
 sound/soc/sof/amd/acp.c                                                            |    8 
 sound/soc/sof/imx/imx-common.c                                                     |    1 
 sound/soc/sof/intel/cnl.c                                                          |    2 
 sound/soc/sof/intel/hda-codec.c                                                    |    4 
 sound/soc/sof/intel/hda-ipc.c                                                      |    2 
 sound/soc/sof/intel/hda-sdw-bpt.c                                                  |   37 
 sound/soc/xilinx/xlnx_formatter_pcm.c                                              |   18 
 sound/usb/6fire/control.c                                                          |    7 
 sound/usb/caiaq/device.c                                                           |    9 
 sound/usb/caiaq/device.h                                                           |    6 
 sound/usb/caiaq/input.c                                                            |   29 
 sound/usb/caiaq/midi.c                                                             |    2 
 sound/usb/line6/capture.c                                                          |    3 
 sound/usb/line6/pcm.c                                                              |    8 
 sound/usb/mixer.c                                                                  |  129 
 sound/usb/mixer.h                                                                  |    6 
 sound/usb/mixer_quirks.c                                                           |    2 
 sound/usb/mixer_us16x08.c                                                          |   19 
 sound/usb/qcom/qc_audio_offload.c                                                  |    9 
 sound/usb/quirks-table.h                                                           |    2 
 sound/usb/usx2y/us122l.c                                                           |    2 
 sound/virtio/virtio_pcm.h                                                          |    2 
 sound/virtio/virtio_pcm_msg.c                                                      |   19 
 sound/virtio/virtio_pcm_ops.c                                                      |    1 
 tools/arch/x86/include/asm/cpufeatures.h                                           |    5 
 tools/bpf/bpftool/Documentation/bpftool-prog.rst                                   |   11 
 tools/bpf/bpftool/common.c                                                         |   40 
 tools/bpf/bpftool/gen.c                                                            |   81 
 tools/bpf/bpftool/link.c                                                           |    4 
 tools/bpf/bpftool/main.c                                                           |   16 
 tools/bpf/bpftool/main.h                                                           |    1 
 tools/bpf/bpftool/map.c                                                            |   95 
 tools/bpf/bpftool/prog.c                                                           |  238 -
 tools/bpf/bpftool/skeleton/profiler.bpf.c                                          |   29 
 tools/bpf/bpftool/tracelog.c                                                       |    2 
 tools/build/Makefile.feature                                                       |   17 
 tools/build/feature/Makefile                                                       |   46 
 tools/build/feature/test-all.c                                                     |    6 
 tools/build/feature/test-babeltrace2-ctf-writer.c                                  |    9 
 tools/build/feature/test-libbabeltrace.c                                           |   10 
 tools/build/feature/test-libunwind-aarch64.c                                       |   27 
 tools/build/feature/test-libunwind-arm.c                                           |   28 
 tools/build/feature/test-libunwind-debug-frame-aarch64.c                           |   17 
 tools/build/feature/test-libunwind-debug-frame-arm.c                               |   17 
 tools/build/feature/test-libunwind-debug-frame.c                                   |    1 
 tools/build/feature/test-libunwind-x86.c                                           |   28 
 tools/build/feature/test-libunwind-x86_64.c                                        |   28 
 tools/build/feature/test-libunwind.c                                               |    1 
 tools/cgroup/iocost_monitor.py                                                     |    7 
 tools/cgroup/memcg_shrinker.py                                                     |    2 
 tools/hv/vmbus_bufring.c                                                           |    6 
 tools/include/linux/types.h                                                        |    5 
 tools/include/nolibc/Makefile                                                      |    1 
 tools/include/nolibc/nolibc.h                                                      |    1 
 tools/include/nolibc/stdlib.h                                                      |    8 
 tools/include/nolibc/sys.h                                                         |   45 
 tools/include/nolibc/sys/select.h                                                  |  103 
 tools/include/nolibc/types.h                                                       |   49 
 tools/lib/bpf/btf.c                                                                |   20 
 tools/lib/bpf/libbpf.c                                                             |   12 
 tools/lib/bpf/skel_internal.h                                                      |   64 
 tools/lib/perf/evlist.c                                                            |   41 
 tools/lib/perf/include/internal/evsel.h                                            |    4 
 tools/lib/perf/mmap.c                                                              |    2 
 tools/perf/Build                                                                   |    4 
 tools/perf/Documentation/perf-c2c.txt                                              |    2 
 tools/perf/Documentation/perf-check.txt                                            |    1 
 tools/perf/Makefile.config                                                         |   53 
 tools/perf/Makefile.perf                                                           |   44 
 tools/perf/arch/arm/annotate/instructions.c                                        |    1 
 tools/perf/arch/arm/tests/dwarf-unwind.c                                           |    1 
 tools/perf/arch/arm/util/Build                                                     |    2 
 tools/perf/arch/arm/util/auxtrace.c                                                |    1 
 tools/perf/arch/arm/util/pmu.c                                                     |    2 
 tools/perf/arch/arm64/annotate/instructions.c                                      |    1 
 tools/perf/arch/arm64/tests/dwarf-unwind.c                                         |    1 
 tools/perf/arch/arm64/util/Build                                                   |   19 
 tools/perf/arch/arm64/util/arm-spe.c                                               |    1 
 tools/perf/arch/arm64/util/hisi-ptt.c                                              |    1 
 tools/perf/arch/powerpc/tests/dwarf-unwind.c                                       |    1 
 tools/perf/arch/powerpc/util/Build                                                 |    2 
 tools/perf/arch/powerpc/util/auxtrace.c                                            |    2 
 tools/perf/arch/s390/util/Build                                                    |    2 
 tools/perf/arch/s390/util/auxtrace.c                                               |    1 
 tools/perf/arch/x86/tests/Build                                                    |    4 
 tools/perf/arch/x86/tests/arch-tests.c                                             |    4 
 tools/perf/arch/x86/tests/topdown.c                                                |  197 +
 tools/perf/arch/x86/util/Build                                                     |    6 
 tools/perf/arch/x86/util/pmu.c                                                     |    2 
 tools/perf/arch/x86/util/topdown.c                                                 |    4 
 tools/perf/bench/evlist-open-close.c                                               |    1 
 tools/perf/bench/futex.c                                                           |    1 
 tools/perf/bench/pmu-scan.c                                                        |    1 
 tools/perf/bench/synthesize.c                                                      |    1 
 tools/perf/builtin-annotate.c                                                      |    3 
 tools/perf/builtin-c2c.c                                                           |   16 
 tools/perf/builtin-check.c                                                         |    2 
 tools/perf/builtin-data.c                                                          |   18 
 tools/perf/builtin-evlist.c                                                        |    3 
 tools/perf/builtin-inject.c                                                        |   47 
 tools/perf/builtin-mem.c                                                           |    1 
 tools/perf/builtin-record.c                                                        |   36 
 tools/perf/builtin-report.c                                                        |    5 
 tools/perf/builtin-script.c                                                        |   43 
 tools/perf/builtin-stat.c                                                          |   15 
 tools/perf/builtin-trace.c                                                         |   15 
 tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json                      |    5 
 tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json               |    2 
 tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json                   |    6 
 tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json                        |   68 
 tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json                 |   10 
 tools/perf/python/perf.pyi                                                         |  672 ++++
 tools/perf/tests/Build                                                             |    4 
 tools/perf/tests/code-reading.c                                                    |   12 
 tools/perf/tests/demangle-java-test.c                                              |    1 
 tools/perf/tests/demangle-rust-v0-test.c                                           |    1 
 tools/perf/tests/hwmon_pmu.c                                                       |    1 
 tools/perf/tests/make                                                              |   11 
 tools/perf/tests/parse-metric.c                                                    |    1 
 tools/perf/tests/pe-file-parsing.c                                                 |    2 
 tools/perf/tests/pfm.c                                                             |    1 
 tools/perf/tests/shell/attr.sh                                                     |    7 
 tools/perf/tests/shell/test_perf_data_converter_ctf.sh                             |  104 
 tools/perf/tests/symbols.c                                                         |   96 
 tools/perf/ui/browsers/annotate-data.c                                             |    2 
 tools/perf/ui/hist.c                                                               |    1 
 tools/perf/util/Build                                                              |   28 
 tools/perf/util/annotate-data.c                                                    |    2 
 tools/perf/util/arm-spe-decoder/Build                                              |    2 
 tools/perf/util/auxtrace.c                                                         |    9 
 tools/perf/util/auxtrace.h                                                         |  226 -
 tools/perf/util/bpf-filter.c                                                       |   29 
 tools/perf/util/bpf-filter.h                                                       |    2 
 tools/perf/util/bpf-trace-summary.c                                                |    1 
 tools/perf/util/bpf_counter_cgroup.c                                               |    1 
 tools/perf/util/bpf_ftrace.c                                                       |    3 
 tools/perf/util/bpf_map.c                                                          |    1 
 tools/perf/util/btf.c                                                              |    2 
 tools/perf/util/cgroup.c                                                           |    1 
 tools/perf/util/cs-etm-decoder/Build                                               |    2 
 tools/perf/util/cs-etm.c                                                           |   12 
 tools/perf/util/data-convert-bt.c                                                  |   33 
 tools/perf/util/data-convert.h                                                     |    4 
 tools/perf/util/drm_pmu.c                                                          |    1 
 tools/perf/util/evsel.c                                                            |    7 
 tools/perf/util/evswitch.c                                                         |    1 
 tools/perf/util/header.c                                                           |   24 
 tools/perf/util/header.h                                                           |    6 
 tools/perf/util/hisi-ptt-decoder/Build                                             |    2 
 tools/perf/util/intel-pt-decoder/Build                                             |    8 
 tools/perf/util/intel-tpebs.c                                                      |    4 
 tools/perf/util/jitdump.c                                                          |  129 
 tools/perf/util/kvm-stat.h                                                         |    1 
 tools/perf/util/libbfd.c                                                           |   23 
 tools/perf/util/libbfd.h                                                           |    9 
 tools/perf/util/llvm.c                                                             |    4 
 tools/perf/util/mem-events.c                                                       |    2 
 tools/perf/util/mmap.c                                                             |    4 
 tools/perf/util/parse-events.c                                                     |    4 
 tools/perf/util/pfm.c                                                              |    1 
 tools/perf/util/pmu.c                                                              |   11 
 tools/perf/util/pmu.h                                                              |   34 
 tools/perf/util/pmus.c                                                             |   21 
 tools/perf/util/powerpc-vpadtl.c                                                   |    1 
 tools/perf/util/print_insn.h                                                       |    1 
 tools/perf/util/session.c                                                          |   35 
 tools/perf/util/session.h                                                          |    3 
 tools/perf/util/setup.py                                                           |  278 +
 tools/perf/util/stat-shadow.c                                                      |    1 
 tools/perf/util/stat.c                                                             |    3 
 tools/perf/util/stat.h                                                             |    3 
 tools/perf/util/symbol.c                                                           |   40 
 tools/perf/util/synthetic-events.h                                                 |   15 
 tools/perf/util/thread_map.c                                                       |   26 
 tools/perf/util/thread_map.h                                                       |    1 
 tools/perf/util/tool.c                                                             |   46 
 tools/perf/util/tool.h                                                             |   10 
 tools/perf/util/tp_pmu.c                                                           |    8 
 tools/power/x86/turbostat/turbostat.c                                              |    8 
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c                    |   18 
 tools/sched_ext/scx_flatcg.bpf.c                                                   |    2 
 tools/testing/cxl/Kbuild                                                           |    4 
 tools/testing/cxl/cxl_core_exports.c                                               |   22 
 tools/testing/cxl/exports.h                                                        |   13 
 tools/testing/cxl/test/cxl.c                                                       |   21 
 tools/testing/cxl/test/mock.c                                                      |   56 
 tools/testing/cxl/test/mock.h                                                      |    3 
 tools/testing/selftests/Makefile                                                   |    4 
 tools/testing/selftests/acct/acct_syscall.c                                        |    2 
 tools/testing/selftests/alsa/conf.c                                                |    2 
 tools/testing/selftests/alsa/mixer-test.c                                          |    4 
 tools/testing/selftests/alsa/pcm-test.c                                            |    2 
 tools/testing/selftests/alsa/test-pcmtest-driver.c                                 |   29 
 tools/testing/selftests/alsa/utimer-test.c                                         |    2 
 tools/testing/selftests/arm64/abi/hwcap.c                                          |    2 
 tools/testing/selftests/arm64/abi/ptrace.c                                         |    2 
 tools/testing/selftests/arm64/abi/syscall-abi.c                                    |    2 
 tools/testing/selftests/arm64/fp/fp-ptrace.c                                       |    2 
 tools/testing/selftests/arm64/fp/fp-stress.c                                       |    2 
 tools/testing/selftests/arm64/fp/sve-probe-vls.c                                   |    2 
 tools/testing/selftests/arm64/fp/sve-ptrace.c                                      |    2 
 tools/testing/selftests/arm64/fp/vec-syscfg.c                                      |    2 
 tools/testing/selftests/arm64/fp/za-ptrace.c                                       |    2 
 tools/testing/selftests/arm64/fp/zt-ptrace.c                                       |    2 
 tools/testing/selftests/arm64/gcs/gcs-stress.c                                     |    2 
 tools/testing/selftests/arm64/pauth/pac.c                                          |    2 
 tools/testing/selftests/arm64/signal/Makefile                                      |    4 
 tools/testing/selftests/arm64/tags/tags_test.c                                     |    2 
 tools/testing/selftests/bpf/network_helpers.c                                      |   46 
 tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c                 |    4 
 tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c                               |    5 
 tools/testing/selftests/bpf/prog_tests/empty_skb.c                                 |   59 
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c                            |    2 
 tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c                              |   53 
 tools/testing/selftests/bpf/prog_tests/missed.c                                    |    8 
 tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c                      |   16 
 tools/testing/selftests/bpf/prog_tests/sockopt.c                                   |    4 
 tools/testing/selftests/bpf/prog_tests/test_task_work.c                            |    2 
 tools/testing/selftests/bpf/prog_tests/test_tunnel.c                               |   13 
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c                         |    4 
 tools/testing/selftests/bpf/progs/cpumask_success.c                                |    6 
 tools/testing/selftests/bpf/progs/empty_skb.c                                      |    7 
 tools/testing/selftests/bpf/progs/test_tc_link.c                                   |   10 
 tools/testing/selftests/bpf/test_progs.c                                           |    5 
 tools/testing/selftests/bpf/unpriv_helpers.c                                       |    9 
 tools/testing/selftests/bpf/xskxceiver.c                                           |    2 
 tools/testing/selftests/breakpoints/Makefile                                       |    4 
 tools/testing/selftests/breakpoints/breakpoint_test.c                              |    2 
 tools/testing/selftests/breakpoints/breakpoint_test_arm64.c                        |    2 
 tools/testing/selftests/breakpoints/step_after_suspend_test.c                      |    2 
 tools/testing/selftests/cachestat/test_cachestat.c                                 |    2 
 tools/testing/selftests/capabilities/test_execve.c                                 |    2 
 tools/testing/selftests/capabilities/validate_cap.c                                |    2 
 tools/testing/selftests/cgroup/test_core.c                                         |    9 
 tools/testing/selftests/cgroup/test_cpu.c                                          |    9 
 tools/testing/selftests/cgroup/test_cpuset.c                                       |    9 
 tools/testing/selftests/cgroup/test_freezer.c                                      |    9 
 tools/testing/selftests/cgroup/test_hugetlb_memcg.c                                |    2 
 tools/testing/selftests/cgroup/test_kill.c                                         |    9 
 tools/testing/selftests/cgroup/test_kmem.c                                         |    9 
 tools/testing/selftests/cgroup/test_memcontrol.c                                   |    9 
 tools/testing/selftests/cgroup/test_pids.c                                         |    4 
 tools/testing/selftests/cgroup/test_zswap.c                                        |  242 +
 tools/testing/selftests/clone3/clone3.c                                            |    2 
 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c                     |    2 
 tools/testing/selftests/clone3/clone3_clear_sighand.c                              |    8 
 tools/testing/selftests/clone3/clone3_selftests.h                                  |    2 
 tools/testing/selftests/clone3/clone3_set_tid.c                                    |    2 
 tools/testing/selftests/connector/proc_filter.c                                    |    2 
 tools/testing/selftests/core/close_range_test.c                                    |    2 
 tools/testing/selftests/core/unshare_test.c                                        |    2 
 tools/testing/selftests/coredump/stackdump_test.c                                  |    2 
 tools/testing/selftests/damon/sysfs_no_op_commit_break.py                          |   35 
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c                                 |    2 
 tools/testing/selftests/drivers/dma-buf/udmabuf.c                                  |    2 
 tools/testing/selftests/drivers/net/psp.py                                         |   56 
 tools/testing/selftests/drivers/ntsync/ntsync.c                                    |    2 
 tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c                     |    2 
 tools/testing/selftests/exec/check-exec.c                                          |    2 
 tools/testing/selftests/exec/execveat.c                                            |    2 
 tools/testing/selftests/exec/load_address.c                                        |    2 
 tools/testing/selftests/exec/non-regular.c                                         |    2 
 tools/testing/selftests/exec/null-argv.c                                           |    2 
 tools/testing/selftests/exec/recursion-depth.c                                     |    2 
 tools/testing/selftests/fchmodat2/fchmodat2_test.c                                 |    2 
 tools/testing/selftests/filelock/ofdlocks.c                                        |    2 
 tools/testing/selftests/filesystems/anon_inode_test.c                              |    2 
 tools/testing/selftests/filesystems/binderfs/binderfs_test.c                       |    2 
 tools/testing/selftests/filesystems/devpts_pts.c                                   |    2 
 tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c                      |   34 
 tools/testing/selftests/filesystems/eventfd/eventfd_test.c                         |    2 
 tools/testing/selftests/filesystems/fclog.c                                        |    2 
 tools/testing/selftests/filesystems/file_stressor.c                                |    2 
 tools/testing/selftests/filesystems/fuse/fusectl_test.c                            |    2 
 tools/testing/selftests/filesystems/kernfs_test.c                                  |    2 
 tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c               |    2 
 tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c            |    2 
 tools/testing/selftests/filesystems/nsfs/iterate_mntns.c                           |    2 
 tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c                        |    2 
 tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c                 |   20 
 tools/testing/selftests/filesystems/statmount/listmount_test.c                     |    2 
 tools/testing/selftests/filesystems/statmount/statmount_test.c                     |    2 
 tools/testing/selftests/filesystems/statmount/statmount_test_ns.c                  |    2 
 tools/testing/selftests/filesystems/utils.c                                        |    2 
 tools/testing/selftests/ftrace/ftracetest                                          |    2 
 tools/testing/selftests/futex/functional/futex_numa_mpol.c                         |    2 
 tools/testing/selftests/futex/functional/futex_priv_hash.c                         |    2 
 tools/testing/selftests/futex/functional/futex_requeue.c                           |    2 
 tools/testing/selftests/futex/functional/futex_requeue_pi.c                        |    2 
 tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c         |    2 
 tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c         |    2 
 tools/testing/selftests/futex/functional/futex_wait.c                              |    2 
 tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c          |    2 
 tools/testing/selftests/futex/functional/futex_wait_timeout.c                      |    2 
 tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c           |    2 
 tools/testing/selftests/futex/functional/futex_wait_wouldblock.c                   |    2 
 tools/testing/selftests/futex/functional/futex_waitv.c                             |    2 
 tools/testing/selftests/hid/hid_common.h                                           |    2 
 tools/testing/selftests/intel_pstate/aperf.c                                       |    2 
 tools/testing/selftests/iommu/iommufd_utils.h                                      |    2 
 tools/testing/selftests/ipc/Makefile                                               |    8 
 tools/testing/selftests/ipc/msgque.c                                               |    2 
 tools/testing/selftests/ir/ir_loopback.c                                           |    2 
 tools/testing/selftests/kcmp/kcmp_test.c                                           |    2 
 tools/testing/selftests/kselftest_harness.h                                        |    2 
 tools/testing/selftests/kselftest_harness/harness-selftest.c                       |    2 
 tools/testing/selftests/landlock/audit.h                                           |    2 
 tools/testing/selftests/landlock/common.h                                          |    2 
 tools/testing/selftests/lib.mk                                                     |    3 
 tools/testing/selftests/lsm/lsm_get_self_attr_test.c                               |    2 
 tools/testing/selftests/lsm/lsm_list_modules_test.c                                |    2 
 tools/testing/selftests/lsm/lsm_set_self_attr_test.c                               |    2 
 tools/testing/selftests/media_tests/media_device_open.c                            |    2 
 tools/testing/selftests/media_tests/media_device_test.c                            |    2 
 tools/testing/selftests/membarrier/membarrier_test_impl.h                          |    2 
 tools/testing/selftests/mincore/mincore_selftest.c                                 |    4 
 tools/testing/selftests/mm/compaction_test.c                                       |    2 
 tools/testing/selftests/mm/cow.c                                                   |    2 
 tools/testing/selftests/mm/droppable.c                                             |    2 
 tools/testing/selftests/mm/guard-regions.c                                         |    2 
 tools/testing/selftests/mm/gup_longterm.c                                          |    2 
 tools/testing/selftests/mm/gup_test.c                                              |    2 
 tools/testing/selftests/mm/hmm-tests.c                                             |    2 
 tools/testing/selftests/mm/hugepage-mmap.c                                         |    2 
 tools/testing/selftests/mm/hugepage-mremap.c                                       |    2 
 tools/testing/selftests/mm/hugetlb-madvise.c                                       |    2 
 tools/testing/selftests/mm/hugetlb-read-hwpoison.c                                 |    2 
 tools/testing/selftests/mm/hugetlb-soft-offline.c                                  |    2 
 tools/testing/selftests/mm/hugetlb_dio.c                                           |    2 
 tools/testing/selftests/mm/hugetlb_fault_after_madv.c                              |    2 
 tools/testing/selftests/mm/hugetlb_madv_vs_map.c                                   |    2 
 tools/testing/selftests/mm/ksm_functional_tests.c                                  |    2 
 tools/testing/selftests/mm/ksm_tests.c                                             |    2 
 tools/testing/selftests/mm/madv_populate.c                                         |    2 
 tools/testing/selftests/mm/map_fixed_noreplace.c                                   |    2 
 tools/testing/selftests/mm/map_hugetlb.c                                           |    2 
 tools/testing/selftests/mm/map_populate.c                                          |    2 
 tools/testing/selftests/mm/mdwe_test.c                                             |    2 
 tools/testing/selftests/mm/memfd_secret.c                                          |    2 
 tools/testing/selftests/mm/merge.c                                                 |    2 
 tools/testing/selftests/mm/migration.c                                             |    2 
 tools/testing/selftests/mm/mkdirty.c                                               |    2 
 tools/testing/selftests/mm/mlock-random-test.c                                     |    2 
 tools/testing/selftests/mm/mlock2-tests.c                                          |    2 
 tools/testing/selftests/mm/mrelease_test.c                                         |    2 
 tools/testing/selftests/mm/mremap_dontunmap.c                                      |    2 
 tools/testing/selftests/mm/mremap_test.c                                           |    2 
 tools/testing/selftests/mm/mseal_test.c                                            |    2 
 tools/testing/selftests/mm/on-fault-limit.c                                        |    2 
 tools/testing/selftests/mm/pagemap_ioctl.c                                         |    2 
 tools/testing/selftests/mm/pfnmap.c                                                |    2 
 tools/testing/selftests/mm/pkey-helpers.h                                          |    2 
 tools/testing/selftests/mm/prctl_thp_disable.c                                     |    2 
 tools/testing/selftests/mm/process_madv.c                                          |    2 
 tools/testing/selftests/mm/rmap.c                                                  |    2 
 tools/testing/selftests/mm/soft-dirty.c                                            |    2 
 tools/testing/selftests/mm/split_huge_page_test.c                                  |    2 
 tools/testing/selftests/mm/thuge-gen.c                                             |    2 
 tools/testing/selftests/mm/transhuge-stress.c                                      |    2 
 tools/testing/selftests/mm/uffd-common.h                                           |    2 
 tools/testing/selftests/mm/uffd-wp-mremap.c                                        |    2 
 tools/testing/selftests/mm/va_high_addr_switch.c                                   |    2 
 tools/testing/selftests/mm/virtual_address_range.c                                 |    2 
 tools/testing/selftests/mm/vm_util.c                                               |    2 
 tools/testing/selftests/mm/vm_util.h                                               |    2 
 tools/testing/selftests/mount_setattr/mount_setattr_test.c                         |    2 
 tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c           |    2 
 tools/testing/selftests/mqueue/mq_open_tests.c                                     |    2 
 tools/testing/selftests/mqueue/mq_perf_tests.c                                     |    2 
 tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c                   |    4 
 tools/testing/selftests/namespaces/file_handle_test.c                              |    2 
 tools/testing/selftests/namespaces/init_ino_test.c                                 |    2 
 tools/testing/selftests/namespaces/nsid_test.c                                     |    2 
 tools/testing/selftests/nci/nci_dev.c                                              |    2 
 tools/testing/selftests/net/af_unix/diag_uid.c                                     |    2 
 tools/testing/selftests/net/af_unix/msg_oob.c                                      |    2 
 tools/testing/selftests/net/af_unix/scm_inq.c                                      |    2 
 tools/testing/selftests/net/af_unix/scm_pidfd.c                                    |    2 
 tools/testing/selftests/net/af_unix/scm_rights.c                                   |    2 
 tools/testing/selftests/net/af_unix/unix_connect.c                                 |    2 
 tools/testing/selftests/net/bind_timewait.c                                        |    2 
 tools/testing/selftests/net/bind_wildcard.c                                        |    2 
 tools/testing/selftests/net/can/test_raw_filter.c                                  |    2 
 tools/testing/selftests/net/cmsg_sender.c                                          |    2 
 tools/testing/selftests/net/epoll_busy_poll.c                                      |    2 
 tools/testing/selftests/net/gro.c                                                  |    2 
 tools/testing/selftests/net/ip_local_port_range.c                                  |    2 
 tools/testing/selftests/net/ipsec.c                                                |    2 
 tools/testing/selftests/net/ipv6_fragmentation.c                                   |    2 
 tools/testing/selftests/net/lib/csum.c                                             |   55 
 tools/testing/selftests/net/netfilter/conntrack_dump_flush.c                       |    2 
 tools/testing/selftests/net/netfilter/conntrack_vrf.sh                             |   25 
 tools/testing/selftests/net/netlink-dumps.c                                        |    2 
 tools/testing/selftests/net/ovpn/ovpn-cli.c                                        |    2 
 tools/testing/selftests/net/proc_net_pktgen.c                                      |    2 
 tools/testing/selftests/net/psock_fanout.c                                         |    2 
 tools/testing/selftests/net/psock_tpacket.c                                        |    2 
 tools/testing/selftests/net/reuseaddr_ports_exhausted.c                            |    2 
 tools/testing/selftests/net/reuseport_bpf.c                                        |    2 
 tools/testing/selftests/net/reuseport_bpf_numa.c                                   |    2 
 tools/testing/selftests/net/rxtimestamp.c                                          |    2 
 tools/testing/selftests/net/sk_so_peek_off.c                                       |    2 
 tools/testing/selftests/net/so_incoming_cpu.c                                      |    2 
 tools/testing/selftests/net/socket.c                                               |    2 
 tools/testing/selftests/net/tap.c                                                  |    2 
 tools/testing/selftests/net/tcp_ao/lib/setup.c                                     |    2 
 tools/testing/selftests/net/tcp_fastopen_backup_key.c                              |    2 
 tools/testing/selftests/net/tcp_mmap.c                                             |    6 
 tools/testing/selftests/net/tcp_port_share.c                                       |    2 
 tools/testing/selftests/net/tls.c                                                  |    2 
 tools/testing/selftests/net/toeplitz.c                                             |    2 
 tools/testing/selftests/net/tun.c                                                  |    2 
 tools/testing/selftests/net/txtimestamp.c                                          |   23 
 tools/testing/selftests/net/udpgso_bench_tx.c                                      |    2 
 tools/testing/selftests/nolibc/Makefile                                            |   10 
 tools/testing/selftests/openat2/helpers.h                                          |    2 
 tools/testing/selftests/openat2/openat2_test.c                                     |    2 
 tools/testing/selftests/openat2/rename_attack_test.c                               |    2 
 tools/testing/selftests/openat2/resolve_test.c                                     |    2 
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c                           |    2 
 tools/testing/selftests/perf_events/mmap.c                                         |    2 
 tools/testing/selftests/perf_events/remove_on_exec.c                               |    2 
 tools/testing/selftests/perf_events/sigtrap_threads.c                              |    2 
 tools/testing/selftests/perf_events/watermark_signal.c                             |    2 
 tools/testing/selftests/pid_namespace/pid_max.c                                    |    2 
 tools/testing/selftests/pid_namespace/regression_enomem.c                          |    2 
 tools/testing/selftests/pidfd/pidfd.h                                              |    2 
 tools/testing/selftests/pidfd/pidfd_bind_mount.c                                   |    2 
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c                                  |    2 
 tools/testing/selftests/pidfd/pidfd_file_handle_test.c                             |    2 
 tools/testing/selftests/pidfd/pidfd_getfd_test.c                                   |    2 
 tools/testing/selftests/pidfd/pidfd_info_test.c                                    |    2 
 tools/testing/selftests/pidfd/pidfd_open_test.c                                    |    4 
 tools/testing/selftests/pidfd/pidfd_poll_test.c                                    |    2 
 tools/testing/selftests/pidfd/pidfd_setattr_test.c                                 |    2 
 tools/testing/selftests/pidfd/pidfd_setns_test.c                                   |    2 
 tools/testing/selftests/pidfd/pidfd_test.c                                         |    2 
 tools/testing/selftests/pidfd/pidfd_wait.c                                         |    2 
 tools/testing/selftests/pidfd/pidfd_xattr_test.c                                   |    2 
 tools/testing/selftests/prctl/Makefile                                             |    4 
 tools/testing/selftests/prctl/set-anon-vma-name-test.c                             |    2 
 tools/testing/selftests/prctl/set-process-name.c                                   |    2 
 tools/testing/selftests/proc/proc-maps-race.c                                      |    2 
 tools/testing/selftests/proc/proc-pid-vm.c                                         |   16 
 tools/testing/selftests/proc/proc-pidns.c                                          |    2 
 tools/testing/selftests/ptrace/get_set_sud.c                                       |    2 
 tools/testing/selftests/ptrace/get_syscall_info.c                                  |    2 
 tools/testing/selftests/ptrace/set_syscall_info.c                                  |    2 
 tools/testing/selftests/ptrace/vmaccess.c                                          |    2 
 tools/testing/selftests/resctrl/resctrl.h                                          |    2 
 tools/testing/selftests/ring-buffer/map_test.c                                     |    2 
 tools/testing/selftests/riscv/abi/pointer_masking.c                                |    2 
 tools/testing/selftests/riscv/hwprobe/cbo.c                                        |    2 
 tools/testing/selftests/riscv/hwprobe/hwprobe.c                                    |    2 
 tools/testing/selftests/riscv/hwprobe/which-cpus.c                                 |    2 
 tools/testing/selftests/riscv/mm/mmap_bottomup.c                                   |    2 
 tools/testing/selftests/riscv/mm/mmap_default.c                                    |    2 
 tools/testing/selftests/riscv/mm/mmap_test.h                                       |    2 
 tools/testing/selftests/riscv/sigreturn/sigreturn.c                                |    2 
 tools/testing/selftests/riscv/vector/v_initval.c                                   |    2 
 tools/testing/selftests/riscv/vector/vstate_prctl.c                                |    2 
 tools/testing/selftests/rseq/basic_percpu_ops_test.c                               |    2 
 tools/testing/selftests/rseq/rseq.c                                                |    2 
 tools/testing/selftests/rtc/rtctest.c                                              |    2 
 tools/testing/selftests/sched_ext/hotplug.c                                        |   34 
 tools/testing/selftests/seccomp/seccomp_benchmark.c                                |    2 
 tools/testing/selftests/seccomp/seccomp_bpf.c                                      |    2 
 tools/testing/selftests/sgx/main.c                                                 |    2 
 tools/testing/selftests/signal/mangle_uc_sigmask.c                                 |    2 
 tools/testing/selftests/signal/sas.c                                               |    2 
 tools/testing/selftests/sparc64/Makefile                                           |    4 
 tools/testing/selftests/sparc64/drivers/adi-test.c                                 |    2 
 tools/testing/selftests/sync/sync_test.c                                           |    2 
 tools/testing/selftests/syscall_user_dispatch/sud_test.c                           |    2 
 tools/testing/selftests/tdx/tdx_guest_test.c                                       |    2 
 tools/testing/selftests/thermal/intel/power_floor/Makefile                         |   12 
 tools/testing/selftests/thermal/intel/workload_hint/Makefile                       |   12 
 tools/testing/selftests/timens/timens.h                                            |    2 
 tools/testing/selftests/timers/adjtick.c                                           |    2 
 tools/testing/selftests/timers/alarmtimer-suspend.c                                |    2 
 tools/testing/selftests/timers/change_skew.c                                       |    2 
 tools/testing/selftests/timers/clocksource-switch.c                                |   25 
 tools/testing/selftests/timers/freq-step.c                                         |    2 
 tools/testing/selftests/timers/inconsistency-check.c                               |    2 
 tools/testing/selftests/timers/leap-a-day.c                                        |    2 
 tools/testing/selftests/timers/leapcrash.c                                         |    2 
 tools/testing/selftests/timers/mqueue-lat.c                                        |    2 
 tools/testing/selftests/timers/nanosleep.c                                         |    2 
 tools/testing/selftests/timers/nsleep-lat.c                                        |    2 
 tools/testing/selftests/timers/posix_timers.c                                      |    2 
 tools/testing/selftests/timers/raw_skew.c                                          |    2 
 tools/testing/selftests/timers/rtcpie.c                                            |    2 
 tools/testing/selftests/timers/set-2038.c                                          |    2 
 tools/testing/selftests/timers/set-tai.c                                           |    2 
 tools/testing/selftests/timers/set-timer-lat.c                                     |    2 
 tools/testing/selftests/timers/set-tz.c                                            |    2 
 tools/testing/selftests/timers/skew_consistency.c                                  |    2 
 tools/testing/selftests/timers/threadtest.c                                        |    2 
 tools/testing/selftests/timers/valid-adjtimex.c                                    |    2 
 tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c                                 |    2 
 tools/testing/selftests/tty/tty_tstamp_update.c                                    |    2 
 tools/testing/selftests/uevent/uevent_filtering.c                                  |    2 
 tools/testing/selftests/user_events/abi_test.c                                     |    2 
 tools/testing/selftests/user_events/dyn_test.c                                     |    2 
 tools/testing/selftests/user_events/ftrace_test.c                                  |    2 
 tools/testing/selftests/user_events/perf_test.c                                    |    2 
 tools/testing/selftests/user_events/user_events_selftests.h                        |    2 
 tools/testing/selftests/vDSO/vdso_test_abi.c                                       |    2 
 tools/testing/selftests/vDSO/vdso_test_chacha.c                                    |    2 
 tools/testing/selftests/vDSO/vdso_test_correctness.c                               |    2 
 tools/testing/selftests/vDSO/vdso_test_getcpu.c                                    |    2 
 tools/testing/selftests/vDSO/vdso_test_getrandom.c                                 |    2 
 tools/testing/selftests/vDSO/vdso_test_gettimeofday.c                              |    2 
 tools/testing/selftests/vfio/lib/include/vfio_util.h                               |    2 
 tools/testing/selftests/vfio/lib/vfio_pci_device.c                                 |    2 
 tools/testing/selftests/vfio/lib/vfio_pci_driver.c                                 |    2 
 tools/testing/selftests/vfio/vfio_dma_mapping_test.c                               |    2 
 tools/testing/selftests/vfio/vfio_iommufd_setup_test.c                             |    2 
 tools/testing/selftests/vfio/vfio_pci_device_test.c                                |    2 
 tools/testing/selftests/vfio/vfio_pci_driver_test.c                                |    2 
 tools/testing/selftests/x86/Makefile                                               |    1 
 tools/testing/selftests/x86/corrupt_xstate_header.c                                |    2 
 tools/testing/selftests/x86/helpers.h                                              |    2 
 tools/testing/selftests/x86/lam.c                                                  |    2 
 tools/testing/selftests/x86/syscall_numbering.c                                    |    2 
 tools/testing/selftests/x86/test_mremap_vdso.c                                     |    2 
 tools/testing/selftests/x86/test_vsyscall.c                                        |    2 
 tools/testing/selftests/x86/xstate.h                                               |    2 
 tools/testing/shared/linux.c                                                       |    4 
 tools/testing/vma/vma.c                                                            |    8 
 tools/testing/vma/vma_internal.h                                                   |    2 
 tools/thermal/tmon/tmon.c                                                          |    2 
 usr/gen_init_cpio.c                                                                |    1 
 2240 files changed, 32398 insertions(+), 15765 deletions(-)

Aamir Ahmed (1):
      wifi: mt76: mt7996: validate TLV length in mt7996_mcu_ie_countdown()

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

Abel Vesa (16):
      arm64: dts: qcom: x1-crd: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1e001de-devkit: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1e78100-t14s: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1e80100-dell-xps13-9345: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1e80100-yoga-slim7x: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1e80100-qcp: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1-asus-zenbook-a14: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1-dell-thena: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1-hp-omnibook-x14: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1p42100-thinkbook-16: Mark the EC reset gpio as reserved
      clk: qcom: gcc-qcs615: Fix GCC_CPUSS_GNOC_CBCR offset
      arm64: dts: qcom: sm8150: Use SM8150_CX for the SDHC power domain
      clk: qcom: gcc-ipq5424: Fix TME reset register offsets
      clk: qcom: mmcc-msm8996: Fix FD AHB clock register offset
      clk: qcom: mmcc-sdm660: Fix MDSS AHB clock HWCG register offset
      clk: qcom: mmcc-msm8960: Configure PLL15 only on APQ8064

Abhijit Gangurde (2):
      RDMA/ionic: Fix XArray initialization to use XArray flags
      RDMA/ionic: Fix double removal of CMB mmap entries in create QP error path

Abraham Zukor (1):
      spi: tegra114: initialize native chip selects inactive

Adam Azuddin (1):
      drm/appletbdrm: Fix incorrect error message on encoder attach failure

Adam Skladowski (1):
      dt-bindings: vendor-prefixes: Add LeEco

Adi Nata (1):
      iio: humidity: hts221: report available values via read_avail()

Aditya Sharma (2):
      mm/memory: update stale locking comments for fault handlers
      bpf: Remove nmi_uaccess_okay() check in bpf_send_signal_common()

Adrian Ambrozewicz (1):
      gpiolib: clear the event clock flags when a line is released

Adrian Hunter (2):
      i3c: mipi-i3c-hci: Restore controller state if i3c_hci_enable_ibi() returns an error
      i3c: mipi-i3c-hci: Fix runtime PM violation in i3c_hci_free_ibi()

Adrián Larumbe (2):
      drm/panfrost: Prevent division by 0
      drm/panfrost: Explicitly enable MMU interrupts at device init

Ahmad Fatoum (3):
      ARM: dts: stm32: lxa-mc1: change stdout-path baud rate from 9600 to 115200
      ARM: dts: stm32: lxa-tac: change stdout-path baud rate from 9600 to 115200
      ARM: dts: stm32: fairytux2: change stdout-path baud rate from 9600 to 115200

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

Aleksander Jan Bajkowski (1):
      crypto: eip93 - fix ssl mac bit field definition

Aleksandr Nogikh (1):
      usb: gadget: dummy_hcd: prevent unbind via sysfs

Aleksandrova Alyona (1):
      platform/x86: intel_telemetry: initialize default trace verbosity

Aleksei Oladko (1):
      selftests: fix ARCH normalization to handle command-line argument

Alex Markuze (1):
      ceph: fix page vector leak on encrypted netfs read EIO path

Alex Williamson (1):
      vfio: Reject a second cdev open before mutating shared device state

Alexander A. Klimov (1):
      microblaze: CCF: fix refcount leak

Alexander Aring (1):
      dlm: fix variable key length lookup

Alexander Duyck (1):
      fbnic: Rework the BMC state pulled from the capabilities message

Alexandr (1):
      ALSA: hda/realtek: Enable mute and mic-mute LEDs on HP ENVY 17-cr0xxx

Alexandra Lu (1):
      bus: mhi: host: pci_generic: Fix runtime PM imbalance for no_m3 devices

Alexandra Winter (1):
      s390/ism: Zerorize dmb at allocation

Alexandre Belloni (1):
      rtc: s35390a: fix typo in comment

Alexandre Cassen (5):
      net/mlx5: HWS, fix reformat pool creation race
      net/mlx5: HWS, fix modify header pool creation race
      net/mlx5: HWS, fix modify header pattern compare on big-endian
      net/mlx5: HWS, fix modify header pool match for copy actions
      net/sched: act_api: inherit filter offload flags only on new actions

Alexei Solcanu (1):
      hwmon: (gpd-fan) Reset both fans to automatic on duo boards

Alexei Starovoitov (6):
      selftests/bpf: Wait for links to come up in lwt_ip_encap
      bpf: Clear sk_refcnt of a clone before its storage is linked
      bpf: Don't take an extension for a writable raw tracepoint program
      bpf: Don't take a program with a target program for an iterator
      bpf: Don't let an extension reach further into the context than its target
      bpf: Use memmove() to store bytes in an xdp_buff

Alexey Charkov (3):
      PCI/pwrctrl: generic: Fix leaking array from of_regulator_bulk_get_all()
      ASoC: codecs: nau8822: add support for supply regulators
      power: supply: bq257xx: Use psy directly instead of driver data

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

Alison Schofield (4):
      cxl/hdm: Reject switch decoder interleave ways that overflow targets
      cxl/hdm: Make switch decoder target parsing endian-safe
      cxl/hdm: Restore commit_end when decoder enumeration fails
      cxl/port: Bound switch decoder target array access by nr_targets

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

Amir Goldstein (3):
      ovl: inherit FMODE_NONOTIFY when opening directory realfiles
      ovl: inherit FMODE_NONOTIFY when reading directory layers
      selftests/ovl: fix detached layer mountinfo expectations

Andrea Parri (3):
      pstore: don't leave an ERR_PTR in the ramoops zone pointer
      pstore: reject persistent RAM zones too small for the buffer header
      nvmet: zns: reject a NUMD whose byte count wraps

Andreas Hindborg (1):
      rust: block: implement `Send` and `Sync` for `TagSet`

Andreas Kemnade (2):
      drm/omap: dsi: avoid sending bta sync all the time in writes
      rtc: bd70528: properly enable wakeup

Andrei Vagin (2):
      x86/fpu: Fix potential underflow in xstate_calculate_size()
      proc: report SIGEV_NONE in /proc/pid/timers if target task has died

Andrew Gaylard (1):
      pinctrl: fix PINCTRL_SPPCTL=m

Anil Kaushik (2):
      gtp: set a valid genl command in PDP context get and dump replies
      gtp: hold RCU for the device lookup when adding a PDP context

Anirudh Virdi (1):
      net: qede: initialize extack in qede_flow_spec_to_rule()

Antoni Pokusinski (3):
      rtc: abx80x: fix error check after i2c_smbus_read in read_alarm()
      rtc: abx80x: add mutex protection for register writes
      rtc: abx80x: properly handle shared IRQs

Anubhav Shelat (1):
      perf pmu: fix duplicate conditional statement

Anup Vishwakarma (4):
      remoteproc: qcom_q6v5_adsp: Fix double jiffies conversion in adsp_start()
      mailbox: qcom-ipcc: Remove redundant mbox_controller_unregister() on probe failure
      mailbox: arm_mhu_db: Remove redundant mbox_controller_unregister() on probe failure
      mailbox: qcom-ipcc: remove stray disable_irq_wake() call

Arka Mondal (6):
      usb-storage: alauda: do not do DMA from the stack
      usb-storage: alauda: check the return value of alauda_read_map()
      usb-storage: alauda: fix out-of-bounds zone index
      iio: dac: ad5758: Fix alignment for DMA safety
      iio: dac: ad5758: Reject out-of-range raw values
      iio: dac: ad5758: Fix the offset calculation

Arnaldo Carvalho de Melo (16):
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
      perf annotate-data: Show the sample count in the data-type browser
      perf test attr: Source setup_python.sh instead of calling python
      perf evsel: Mark the event as supported when retrying an open
      perf auxtrace: Include sys/types.h for pid_t

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

Baek Kyu, Kim (2):
      rtc: mpfs: Fix alarm register word order
      gpiolib: Propagate emulated drive errors when setting arrays

Bala-Vignesh-Reddy (2):
      selftests: complete kselftest include centralization
      selftests/x86: Add selftests include path for kselftest.h after centralization

Baochen Qiang (2):
      wifi: ath12k: signal regd update completion when reg event is dropped
      wifi: ath11k: fix unbalanced IRQ enable/disable during suspend/resume

Baolin Liu (2):
      fs/ntfs3: update ctime only on successful setxattr
      fs/ntfs3: reject FS_IOC_SETFSLABEL on readonly mounts

Bard Liao (1):
      ASoC/soundwire: Intel: reset the PCMSyCM registers in hda_sdw_bpt_close

Bart Van Assche (6):
      scsi: pm8001: Fix SATA FIS offset in struct hw_event_resp
      scsi: core: Move two statements
      scsi: scsi_debug: Abort SCSI commands via an internal command
      scsi: scsi_debug: Fix a locking bug in resp_write_same()
      block/blk-iocost: Split ioc_rqos_throttle()
      block/blk-iocost: Inline iocg_lock() and iocg_unlock()

Bartosz Szpila (1):
      platform/chrome: cros_ec_typec: Validate SVID and mode counts in discovery data

Beata Michalska (1):
      rust: dma: allow drivers to tune max segment size

Beleswar Padhi (1):
      mailbox: ti-msgmgr: Read exact number of trailing message bytes

Benoît Monin (3):
      irqchip/mips-gic: Fix unbalanced cm_core_lock in for_each_online_cpu_gic()
      irqchip/mips-gic: Fix recursive acquisition of gic_lock in gic_set_affinity()
      irqchip/mips-gic: Transfer interrupt mask state across clusters

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

Bert Karwatzki (1):
      mac80211: tx: Use info->flags in ieee80211_tx_h_select_key()

Biju Das (1):
      serial: sh-sci: Drop checking port type for device file{create, remove}

Binbin Deng (4):
      module: Fix uninitialized count read of unloaded taint tracking record
      octeontx2: Fix use-after-free of qos node in delete path
      tipc: fix use-after-free of broadcast reception link at node release
      net: atlantic: Unregister before clearing RXNFC rules

Binglei Wang (1):
      erofs: fix xattrs handling when metadata compression is used

Bjorn Andersson (1):
      power: supply: qcom_battmgr: report full batteries

Bjorn Helgaas (1):
      PCI/pwrctrl: slot: Rename private struct and pointers for consistency

Boris Faure (1):
      soundwire: intel: initialise quirk_mask before reading it

Borislav Petkov (AMD) (1):
      x86/cpufeatures: Make X86_FEATURE leaf 17 Linux-specific

Brad Fitzpatrick (1):
      gre: keep the UDP tunnel GSO type when completing GRO

Bradley Morgan (1):
      watchdog/perf: one digit too short in the raw event config copy

Breno Leitao (4):
      kexec_file: stop the top-down search before it underflows
      cpuidle: menu: Remove incorrect unlikely() annotation
      ACPICA: Fix memory leak in acpi_ds_create_field()
      mailbox: pcc: Free the channel before unmapping the shared memory

Brian Norris (3):
      arm64: dts: mediatek: Add #{address,size}-cells to Chromium-based /firmware
      PM: runtime: Only queue an idle check for RPM-linked suppliers
      PM: runtime: Only queue an idle check for RPM-linked suppliers (part 2)

Bruno Produit (1):
      hfs/hfsplus: serialize B-tree close against folio release

Cai Xinchen (1):
      lsm: don't call security_backing_file_free() multiple times

Carlo Szelinsky (1):
      net: pse-pd: si3474: fix use-after-free in ancillary client error path

Carolina Jubran (2):
      IB/IPoIB: Cancel normal flush work on device stop
      net: skbuff: don't copy alloc_cpu in skb header copies

Cen Zhang (28):
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
      ALSA: aloop: Keep shared timer callbacks alive through close
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

Chandrakanth Patil (17):
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
      scsi: mpi3mr: Fix out-of-bounds read of event data
      scsi: mpi3mr: Fix out-of-bounds phy array access on link change
      scsi: mpi3mr: Fix buffer overflow in the BSG target device map
      scsi: mpi3mr: Fix out-of-bounds read in PCIe topology change events
      scsi: mpi3mr: zero out diagnostic buffer status memory
      scsi: mpi3mr: Fix use-after-free of the firmware event workqueue
      scsi: mpi3mr: Fix NULL pointer dereference on PCI error recovery

Chao Yu (1):
      f2fs: fix to fetch ino via ino_of_node() under cache lock

Charlie Garner (1):
      arm64: dts: qcom: x1e80100-dell-inspiron-14-plus-7441: fix touchscreen i2c address

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

Chen-Yu Yeh (1):
      riscv: dts: sophgo: cv180x: Fix internal ephy node name

ChenXiaoSong (1):
      smb/server: fix trailing period in generated short names

Cheng Yongkang (1):
      net: tun: hold napi_mutex when deleting NAPI in tun_detach_all()

Chengchang Tang (1):
      RDMA/hns: Fix missing CQE when UD QP use different SL

Chengfeng Ye (1):
      l2tp: snapshot sequencing state when building transmit headers

Chien Wong (2):
      wifi: mac80211: fix encryption tailroom
      wifi: mac80211: reserve MME tailroom for protected beacons

Chris J Arges (1):
      bnxt_en: use bnxt_xdp_buff for xdp context

Chris Lu (4):
      Bluetooth: btmtksdio: Remove redundant firmware filename override
      Bluetooth: btmtksdio: Pass the hardware device id to mt79xx_setup()
      Bluetooth: btmtk: Validate the firmware layout before parsing it
      Bluetooth: btmtk: Improve BT firmware logging

Chris Mason (8):
      mm/huge_memory: fix truncate racing with PMD zapping
      mm: fix deadlock of mremap() against UFFDIO_MOVE
      nvmet-rdma: flush nvmet-wq on module exit
      nvmet-rdma: disable interrupts under rsp_wr_wait_lock
      nvmet-rdma: fix double puts after a failed RDMA WRITE
      nvmet: don't clear sq->ctrl for a Connect with sqsize 0
      rnbd-srv: fix use-after-free on two CLOSE messages
      rnbd-srv: publish the sess_dev at the end of OPEN

Chris Morgan (1):
      arm64: dts: rockchip: Correct Device Orientation on Gameforce Ace

Christian Brauner (4):
      pidfs: prepare to drop exit_info pointer
      ovl: port ovl_dir_llseek() to cred guard
      kernfs: pass struct ns_common instead of const void * for namespace tags
      kernfs: make directory seek namespace-aware

Christian Loehle (2):
      cpuidle: menu: Remove single state handling
      ACPI: CPPC: Validate the _CPC package header

Christoph Hellwig (5):
      zloop: remove a duplicate call to zloop_get_block_size
      zloop: share more code for opening a zone backing file
      zloop: fput file after failed zone init
      zloop: check that the zone backing file support ->{read,write}_iter
      zloop: fix block size query

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

Cosmin Ratiu (3):
      net/mlx5e: Stop asserting for RTNL when closing channels
      net/mlx5e: SHAMPO: Do not merge PSP packets
      net/mlx5: Only set num_doorbells on a fully initialized SF

Cosmin Tanislav (2):
      thermal: renesas: rzg3e: make min and max temperature per-chip
      thermal: renesas: rzg3e: make calibration value retrieval per-chip

Cristian Ciocaltea (2):
      drm/rockchip: dw_hdmi_qp: Fix invalid drvdata access in PM ops
      drm/rockchip: dw_hdmi_qp: Cancel pending HPD work on suspend

Cristian Papa (2):
      wifi: mt76: mt7603: don't drop short frames looped back on PS entry
      wifi: mt76: feed the station RSSI average from the chain signals

Daasaradhi Mannava (1):
      platform/x86: msi-ec: Report valid charge thresholds when unset

DaeMyung Kang (1):
      ksmbd: round SetAllocation to the advertised allocation unit

Daehyeon Ko (1):
      sched/fair: Clear throttle state when leaving the fair class

Daejun Park (1):
      xfs: refuse a pNFS LAYOUTCOMMIT of a range without blocks

Dairui Zhang (1):
      IB/mad: fix UAF and double-free in RMPP receive reassembly

Damien Le Moal (7):
      scsi: scsi_debug: move ASC and ASCQ definitions to scsi_proto.h
      scsi: core: Define all additional sense codes and their qualifiers
      scsi: core: Rename sense field of struct scsi_failure
      scsi: core: Prepare for using combined sense codes
      block: cleanup blkdev_report_zones()
      block: introduce disk_report_zone()
      scsi: core: Fix additional sense code definition

Dan Carpenter (4):
      wifi: b43: don't pass unterminated string to sscanf()
      wifi: b43legacy: debugfs: NUL terminate string in debugfs
      wifi: carl9170: NUL terminate string in debugfs
      mm/hmm/test: reject overflowing page counts

Dan Williams (5):
      cxl/port: Reduce number of @dport variables in cxl_port_add_dport()
      cxl/port: Cleanup dport removal with a devres group
      cxl/port: Move decoder setup before dport creation
      cxl/port: Move dport probe operations to a driver event
      cxl/port: Move dport RAS setup to dport add time

Daniel Borkmann (2):
      bpf, lsm: Reject writes into the BPF LSM program context
      bpf: Don't echo user-supplied map info fields back to userspace

Daniel Drake (1):
      drm/vc4: Set DRM DMA device directly from HVS and V3D

Daniel Lezcano (1):
      ACPI: platform_profile: Separate handler locking from sysfs lifetime

Daniel Machon (12):
      net: lan969x: fix DSM calendar for empty taxis
      net: sparx5/lan969x: do not clobber the PSFP cycle timer update period
      net: lan969x: don't disable hardirqs in fdma tx clear
      net: sparx5/lan969x: do not read past skb->len when injecting a frame
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

Daniel Zahka (5):
      eth: fbnic: take netif_addr_lock_bh() around rx mode address programming
      selftests: drv-net: psp: swap closed for connected sockets in assoc tests
      net: psp: require an established connection for association setup
      net: psp: drop psp assoc clear in sk_clone()
      selftests: drv-net: psp: test that rx-assoc fails on closed and listen socks

Danielle Ratson (1):
      bridge: Add internal flags for neigh_forward_grat

Danila Chernetsov (2):
      dlm: validate lock modes in recovery messages
      dlm: fix NULL pointer dereference in dlm_dump_rsb_name()

Danish Khateeb (7):
      tools/nolibc: fix WIFSIGNALED() for status 0
      tools/nolibc: fix FD_SET(), FD_CLR() and FD_ISSET() on 64-bit
      pwm: Allow 32-bit tasks to use the character device
      tools/nolibc: stop rounding malloc() sizes up to 4096 bytes
      tools/nolibc: check for overflow in malloc()
      serial: 8250: Fix section mismatch with CONFIG_MODULES=n
      pps: generators: wake up PPS_GEN_FETCHEVENT readers on unregister

Darong Lu (1):
      libceph: initialize CRUSH choose argument weights

Darren Carreras (1):
      libbpf: Avoid overflow in BTF.ext bounds check

Dave Jiang (23):
      cxl/ras: Pass the PCI device's struct device to match_memdev_by_parent()
      efi/cper: Reject CPER records with an out-of-range error_data_length
      efi/cper: Reject an error status block length that wraps a u32
      ACPI: extlog: Validate elog record length before walking sections
      ACPI: APEI: GHES: Bound CXL event record copy to the firmware section length
      ACPI: extlog: Defer CXL protocol error handling to avoid lock inversion
      ACPI: APEI: GHES: Validate CXL protocol error section length before RAS cap copy
      efi/cper: Read only validated fields in cper_mem_err_pack()
      ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata
      cxl/test: Add support for acpi extended linear cache
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
      ACPI: extlog: Avoid populating software AER metadata from raw hardware buffer
      ACPI: extlog: Validate PCIe error section length before payload access
      ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo

David (Ming Qiang) Wu (1):
      drm/amdgpu/userq: need to unref bo

David Heidelberg (1):
      ASoC: wcd-mbhc-v2: Fix incorrect properties names and typos

David Hildenbrand (Arm) (13):
      mm/ksm: fix use of a freed anon_vma at swap-in
      mm/userfaultfd: write-lock the VMA before waking waiters when unregistering
      mm/userfaultfd: wake waiters when registration modes are removed
      mm: fix address wraparound when scanning large folio PTEs
      mm/vma: don't leak the charge for stack growth
      mm/madvise: preserve VMA_SOFTDIRTY_BIT when changing anonymous names
      mm/shmem: preserve allocation errors when swapping in large entries
      mm/rmap: handle device-exclusive entries in folio_referenced_one()
      mm/huge_memory: properly handle refcounted PUD mappings on fork
      fork: take mmap_lock before copying mm_struct
      mm/shmem: make shmem_file() check the file's inode
      mm/shmem: fix accounting of swapin-error markers
      mm/hugetlb: disable PMD sharing for UFFD missing mode

David Howells (4):
      rxrpc: Revert "rxrpc: rxperf: Fix missing decoding of terminal magic cookie"
      rxrpc: Fix rxperf test rxgk key kvno to be 0
      rxrpc: Fix aborting in rxperf test server
      rxrpc: Fix sendmsg length

Deepti Jaggi (1):
      mailbox: qcom-cpucp: Add support for Nord CPUCP mailbox controller

Detlev Casanova (4):
      arm64: dts: rockchip: Rename rk3328 HDMI audio card
      arm64: dts: rockchip: Rename rk3566 and rk3568 HDMI audio cards
      arm64: dts: rockchip: Rename rk3576 HDMI audio card
      arm64: dts: rockchip: Rename rk3588 HDMI audio cards

Devin Wittmayer (7):
      wifi: mt76: mt7921: fix lock inversion between dev->mutex and iflist_mtx
      wifi: mt76: mt7925: fix lock inversion between dev->mutex and iflist_mtx
      wifi: mt76: mt7921: check drv_pmctrl return in the PCIe reset path
      wifi: mt76: mt7925: check drv_pmctrl return in the PCIe reset path
      wifi: mt76: mt7921: fix the lock inversion in suspend and resume
      wifi: mt76: mt7925: fix the lock inversion in suspend and resume
      wifi: mt76: mt7921: honour FIF_FCSFAIL instead of hardcoding drop_err

Dharmender Garg (2):
      bnge: cap RSS contexts and RX rings to the RSS table size
      bnge: fix RSS table sizing for large RX ring counts

Diego Fernando Mancera Gomez (1):
      usb: image: microtek: stop SG processing after transfer errors

Dimitri Daskalakis (2):
      net/mlx5e: Update netdev features only after a successful ringparam set
      eth: fbnic: Correct packet header prefetch

Dimitris Charisis (1):
      maple_tree: fix maple_range_64 crashes in RCU mode

Dmitrii Tulnov (1):
      kconfig: warn about malformed KCONFIG_PROBABILITY values

Dmitriy Geels (1):
      HID: logitech-hidpp: cancel reset_hi_res_work on probe failure

Dmitry Antipov (3):
      ocfs2: add extra flags check in ocfs2_ioctl_move_extents()
      leds: flash: Prevent using uninitialized variable in flash_fault_show()
      tcp_bpf: propagate error code in tcp_bpf_sendmsg()

Dmitry Baryshkov (6):
      ARM: dts: qcom: msm8974: add MDSS reset
      media: iris: fail firmware boot on invalid uc_region
      media: iris: take core lock when scanning the instance list
      media: iris: reject open() when the session limit is reached
      media: iris: reference count video instances
      drm/msm/mdp5: drop cursor pipe for msm8x76

Dmitry Sinyavin (1):
      serial: msm: select PM_OPP

Dmitry Torokhov (3):
      gpio: crystalcove: add missing MODULE_ALIAS()
      ASoC: tlv320aic32x4: move regmap_config into i2c and spi drivers
      ASoC: tlv320aic32x4: clean up driver code formatting and logging

Dominic White (1):
      wifi: cfg80211: allow zero HE OBSS PD offsets

Dominik Maier (1):
      xattr: always invoke cap_convert_nscap() for security.capability writes

Dominique Martinet (1):
      libbpf: fix cross-endian build with newer libbpf

Donggeun Yoo (5):
      iommufd: Keep reserved IOVA ranges when a replace within one IOAS fails
      tracing: Print the bucket size as unsigned
      tracing: Only report the stacktrace modifier on a real field
      tracing: Clamp the printed end of a histogram bucket at U64_MAX
      tracing: Print a signed histogram key as signed

Dudu Lu (4):
      net/sched: etf: initialise the sock_exterr_skb before filling it
      net/sched: gred: keep the qdisc lock while updating the table
      net/sched: taprio: unwind the netdevice notifier if register_qdisc() fails
      net: xps: bound the cleanup loop by the old map's num_tc

Edward Adam Davis (1):
      kernel/reboot: avoid potential deadlocks during suspension

Eklavya Singh (1):
      ocfs2/heartbeat: serialize concurrent writes to a region's dev attribute

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: fix the VHT MCS sent to a v1 firmware

Endrik Einberg (1):
      wifi: iwlwifi: mld: include VI packets in low latency detection

Eric Anderson (1):
      mfd: rk8xx: Register poweroff handler in atomic phase

Eric Dumazet (23):
      inet: frags: limit the truesize of a reassembly queue
      inet: frags: bound the wmem charge of the socket completing a reassembly
      sit: fix UAF in ipip6_tunnel_del_prl()
      ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup
      ipv4: fix IP ID reuse in ip_select_ident_segs()
      ipv4: reserve one IP ID per segment for UDP GSO packets
      ipv6: add daddr/final storage in struct ipv6_pinfo
      tcp: populate inet->cork.fl.u.ip6 in tcp_v6_connect()
      Bluetooth: btmtk: fix skb double free on ISO padding failure
      ipv4: use RCU protection in inet_netconf_get_devconf()
      tcp: use the echoed source route in cookie_v4_check()
      tcp: tcp_metrics: use the socket netns, not the dst device netns
      ipv6: account route exceptions to the netns of their dst
      net: shrink the payload-only part of skb dataref to one bit
      net: fix frag_list leak in skb_segment_list() error path
      ipmr: clear skb->cb[] in reg_vif_xmit()
      ppp: linearize and segment bridged packets when required
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

Ethan Tidmore (1):
      staging: rtl8723bs: remove unused private debug counters

Eva Kurchatova (1):
      hugetlbfs: enforce F_SEAL_EXEC in setattr

Even Xu (2):
      HID: Intel-thc-hid: Intel-quicki2c: Use hid_safe_input_report()
      HID: Intel-thc-hid: Intel-quickspi: Use hid_safe_input_report()

Ewan D. Milne (1):
      scsi: scsi_debug: Add missing newline in scsi_debug_device_reset()

Fabio M. De Francesco (4):
      ACPI: extlog: Trace CPER Non-standard Section Body
      ACPI: extlog: Trace CPER PCI Express Error Section
      ACPI: APEI: GHES: Add helper to copy CPER CXL protocol error info to work struct
      ACPI: extlog: Trace CPER CXL Protocol Error Section

Fabrice Derepas (2):
      crypto: asymmetric_keys - fix OOB read in pefile_parse_binary
      ima: reject a kexec buffer whose declared size exceeds the buffer

Fabrice Gasnier (3):
      ARM: dts: stm32: fix vdda supply for onboard hub on stm32mp15 DK boards
      ARM: dts: stm32: fix vdda supply for onboard hub on stm32mp157c-ev1
      ARM: dts: stm32: fix vdda supply for onboard hub on stm32mp135f-dk

Fan Wu (1):
      ipe: fix enforcement audit

Felix Fietkau (25):
      wifi: mt76: check the owner of a remain-on-channel request
      wifi: mt76: add offchannel check to mt76_roc_complete
      wifi: mt76: check chanctx before restoring channel after ROC
      wifi: mt76: optimize ROC for same-channel case
      wifi: mt76: send nullfunc PS frames on offchannel transitions
      wifi: mt76: set MT76_SCANNING when starting a hw scan
      wifi: mt76: clear offchannel state if a scan has no channel to restore
      wifi: mt76: mt7915: check default EEPROM firmware size before copying
      wifi: mt76: mt7996: validate firmware event lengths before parsing
      wifi: mt76: mt7915: unregister thermal cooling device on hwmon failure
      wifi: mt76: mt7915: guard firmware memory dump write on disabled memdump
      wifi: mt76: mt7996: bound RRO session id before indexing addr_elem[]
      wifi: mt76: mt7925: restore the reset state when fw_pmctrl fails
      wifi: mt76: abort a scan only for a link change on the scanning radio
      wifi: mt76: mt7996: enable the SKU power limit table
      wifi: mt76: mt7996: set sniffer mode on a radio that is already running
      wifi: mt76: mt7996: upload only the keys of the link being set up
      wifi: mt76: mt7996: report station statistics from the primary link
      wifi: mt76: mt7996: clear all link wcid entries in sta_pre_rcu_remove
      wifi: mt76: mt7996: fix PLE free page and AC queue register offsets
      wifi: mt76: mt7996: fix the hw-queues debugfs queue requests
      wifi: mt76: mt7996: refuse scan and ROC until the hardware restart is done
      wifi: mt76: report an aborted scan or ROC to mac80211 during a reset
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

Fengnan Chang (1):
      blk-mq: use array manage hctx map instead of xarray

Fernando Fernandez Mancera (4):
      netfilter: synproxy: fix reset of ct seqadj when reopening a connection
      net: openvswitch: skip IPv4 later fragments on TCP/UDP set actions
      net: openvswitch: drop IP fragments on SCTP set action
      devlink: region: fix snapshot id leak on kernel-allocated ids

Filipe Manana (7):
      btrfs: fix off by one super block end offset calculation when writing super blocks
      btrfs: fix dangling nodes in tree-mod-log after error in btrfs_tree_mod_log_insert_root()
      btrfs: fix incomplete iteration over fs state when logging messages
      btrfs: fix off-by-one end offset check in report_setget_bounds()
      btrfs: qgroup: fix swapped blocks existence check when tracing after COW
      btrfs: fix lost error return value in btrfs_alloc_logged_file_extent()
      btrfs: defrag: fix check to see if next extent can be defragged too

Finn Thain (26):
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
      swim: Add track zero recalibration delay
      swim: Handle FIFO timeout error
      swim: Check for CRC errors
      swim: Simplify return value initialization
      swim: Check error register during sector read
      swim: Don't use the mark register to read data
      swim: Fix buffer overflow
      swim: Convert to blocking queue
      swim: Remove redundant RELAX actions
      swim: Deduplicate polling loops
      swim: Check drive ready bit
      swim: Revisit delays
      swim: Don't search beyond the first data mark
      swim: Return -EROFS when opened with BLK_OPEN_WRITE flag
      swim: Fix FDEJECT ioctl for exclusive open
      swim3: Fix FDEJECT ioctl for exclusive open

Florian Fainelli (12):
      um: Add definition of __NR_close_range for older host OSs
      tools/thermal/tmon: Fix string truncation warning in optarg copy
      net: bcmasp: fix mib counters struct alignment with ethtool stats
      net: bcmasp: unmap previous DMA mappings on TX map failure
      net: bcmasp: validate minimum RX packet size in bcmasp_rx_poll()
      net: bcmasp: fix OF node reference leak for phy_dn
      net: bcmasp: account for offload header in TX short packet padding
      net: bcmasp: fix network filter lookup and wake filter pair allocation
      perf print_insn: Include sys/types.h for ssize_t
      perf parse-events: Include errno.h before kernel headers
      net: dsa: mv88e6xxx: fix 6351 family statistics snapshot
      net: dsa: mv88e6xxx: fix 88E6171 statistics type

Florian Fuchs (3):
      sh: Fix built-in DTB build with generic rule
      sh: uaccess: Require offsettable operands for 64-bit user access
      ALSA: sh: aica: Fix spu_memset() stride

Florian Schmaus (1):
      selftests/epoll: fix race condition in multi-waiter wakeup tests

Florian Westphal (3):
      netfilter: conntrack: fix unlikely UaF in gc worker
      selftests: netfilter: fix return value in zone subtest
      netfilter: nft_compat: restrict raw table targets/matches

Francesco Dolcini (2):
      arm64: dts: ti: k3-am62-verdin: fix main_gpio0/main_gpio1 line names size
      arm64: dts: ti: k3-am62-verdin-ivy: Fix main_gpio0/main_gpio1 line names size

Francesco Valla (1):
      spi: virtio: fix max frequency setting

Fuad Tabba (7):
      KVM: arm64: vgic-its: Don't map an LPI from more than one event
      arm64: pi: Run the source checker on the libfdt objects under C=2
      of/irq: Fix device node refcount leak in of_check_msi_parent()
      irqchip/gic-v3-its: Clear vpt_page after freeing the pending table
      irqchip/gic-v3-its: Don't free a vPE table shared with another ITS
      irqchip/gic-v3-its: Don't free the tables of an enabled ITS
      irqchip/gic-v3: Don't register a redistributor that was never counted

Gabor Juhos (3):
      spi: spi-qpic-snand: fix read location register usage in qcom_spi_config_cw_read()
      spi: spi-qpic-snand: set 'qpic_version2' flag
      spi: spi-qpic-snand: skip BBM copy on regular raw reads

Gabriel Fernandez (1):
      clk: stm32: fix clock array size for STM32MP21

Gal Pressman (1):
      net/mlx5e: IPsec, Fix out-of-bounds comparison of neighbour keys

Geert Uytterhoeven (3):
      clk: rs9: Add clock index range check to rs9_of_clk_get()
      dt-bindings: interrupt-controller: chrp,open-pic: Typo s/pci/pic/
      dt-bindings: interrupt-controller: chrp,open-pic: Fix dangling reference

George Abraham P (1):
      crypto: qat - force an edge when re-enabling all VF2PF interrupts

George Melikov (1):
      bnx2x: fix header length calculation for encapsulated TSO

Georgi Djakov (1):
      thermal/drivers/qcom-spmi-temp-alarm: Fix temp_map indexing

Georgia Garcia (1):
      apparmor: fix profile leak when a policy load fails

Georgios Androutsopoulos (3):
      rust: clk: document overflow panics in `Hertz` constructors
      rust: id_pool: document panics in `find_unused_id` and `release_id`
      rust: bitmap: document panics in `next_bit` and `next_zero_bit`

Ginger Li (2):
      media: i2c: ov5648: Fix a data race on state->streaming
      wifi: mac80211: Fix a race when expiring a mesh path

Giuseppe Piscitelli (1):
      scsi: core: Balance the pseudo target reap reference

Golla Nagendra (1):
      dmaengine: zynqmp_dma: Fix chan probe/remove error handling

Greg Kroah-Hartman (2):
      mm/gup: honour FOLL_PIN in NOMMU __get_user_pages_locked()
      Linux 6.18.65

Greg Thelen (1):
      selftests/net: tcp_mmap: remove unused -k option and keepflag

Gregor Herburger (1):
      arm64: dts: broadcom: bcm2712-d-rpi-5-b: add compatible

Gregory CLEMENT (1):
      phy: cadence: Sierra: Do not modify register when getting parent clock

Gregory Price (1):
      mm/userfaultfd: compare exact registration modes before skipping

Gregory Price (Meta) (3):
      mm/page_alloc: let the highest memory node recover from hopeless state
      cgroup/cpuset: use mems_allowed_seq when checking a policy nodemask
      cgroup/cpuset: check effective mems for a movable-only configuration

Guanghui Feng (1):
      iommu/vt-d: Fix IQE handling to cover all descriptors in submission range

Guanghui Yang (1):
      btrfs: roll back sprout setup after device add failure

Guangshuo Li (6):
      media: i2c: ar0521: remove duplicate media entity cleanup
      platform/x86/intel/vsec: reset state before re-enumerating
      media: staging/ipu7: release ISYS firmware resources on remove
      spi: fsl: unmap immr_spi_cs on remove
      spi: bcm63xx-hsspi: Disable runtime PM on remove
      floppy: unregister platform device on add_disk failure

Guenter Roeck (4):
      hwmon: (chipcap2) Drop unnecessary include files
      hwmon: (coretemp) Set nr_cores only after core_data allocation succeeds
      hwmon: (coretemp) Fix 32-bit jiffies wraparound in show_temp()
      hwmon: (tmp108) Fix initial conversion delay and wait until ready

Gui-Dong Han (1):
      xen/blkback: Prevent missed completion when draining I/O

Guixin Liu (7):
      cxl/pci: Use the Device GPF DVSEC for restricted endpoints
      cxl/pci: Skip reset detection for DVSEC emulated decoders
      cxl/port: Fix uninitialized coordinates reported for RCDs
      cxl/core: Fix dport use-after-free via the einj_inject debugfs file
      cxl/region: Create node access attributes for CFMWS-only NUMA nodes
      cxl/core: Skip einj_inject creation when devm_add_action_or_reset() fails
      cxl/pci: Update only the Port GPF timeout fields

Guopeng Zhang (1):
      selftests/cgroup: conform test to KTAP format output

HOYOUNG SEO (1):
      scsi: ufs: core: Change the error check sequence for auto hibern8

Haibo Chen (1):
      leds: pca9532: Check i2c_smbus_read_byte_data() return value

Haitam Lazaar (1):
      RDMA/siw: Enforce IB_ACCESS_REMOTE_READ for read responses

Hal Feng (2):
      riscv: dts: starfive: Add common board dtsi for VisionFive 2 Lite variants
      riscv: dts: starfive: Correct pwm nodes

Hannes Laimer (1):
      vxlan: keep reserved_bits across changelink

Hannes Reinecke (3):
      scsi: core: Support allocating reserved commands
      scsi: core: Support allocating a pseudo SCSI device
      scsi: core: Add scsi_{get,put}_internal_cmd() helpers

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

Harry Wentland (1):
      drm/vkms: Fix limited-range YCbCr to RGB conversion scaling

Harry Yoo (Meta) (1):
      selftests/cgroup: ignore memory.reclaim -EAGAIN for zswap writeback test

Heiko Carstens (2):
      s390/ptrace: Preserve ILC when updating system call number
      s390/uprobes: Fix off-by-one bug in emulated PER handling

Hemanth Selam (2):
      nvdimm/pmem: Release gendisk on probe failure
      selftests/cgroup: set the test plan after the setup checks

Henrik Grimler (1):
      dt-bindings: power: bq27xxx: bq27z561: allow interrupts property

Henry Hu (5):
      ksmbd: fix iface_list use-after-free during server reset
      ksmbd: fix link speed query in fsctl_query_iface_info_ioctl()
      ksmbd: fix unlocked IPv6 addr_list walk in fsctl_query_iface_info_ioctl()
      ksmbd: fix invalid Next offset in interface info replies
      ksmbd: report IPv4 and IPv6 addresses independently in iface query

Henry Martin (1):
      netlink: fix out-of-bounds bitmap access clearing stale mc groups

Herbert Xu (2):
      crypto: api - Fix DUP_FIRST crash on unregister
      crypto: tcrypt - Avoid reading req->base after submission

Hitalo Souza (1):
      Bluetooth: Add missing newline to bt_dev_{err,warn}_ratelimited()

Honggang LI (1):
      RDMA/rxe: Fix out-of-range unsigned-to-signed conversion for RDMA message in 2GiB size

Hongjian Dai (1):
      spi: meson-spicc: fix invalid DMA unmap on mapping failure

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

Hugo Villeneuve (3):
      serial: 8250_hub6: add hub6_match_port()
      serial: 8250: fix compile error with hub6_match_port() when compiled as a module
      serial: 8250_hub6: add missing include for hub6_match_port()

Hui Peng (1):
      fuse: validate folio state before pipe_buf_try_steal() in fuse_try_move_folio()

Hui Su (2):
      bpftool: Fix CPU IDs in per-CPU map output
      bpftool: Fix sparse CPU IDs in prog profile

Hungyu Lin (2):
      media: iris: cancel sys error work on driver removal
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

Ian Rogers (28):
      perf header: Fix potential memory corruption in cpu_cache_level__read
      perf tool: Add the perf_tool argument to all callbacks
      perf build: Don't add NO_AUXTRACE if missing feature-get_cpuid
      perf build: Remove NO_AUXTRACE build option
      perf auxtrace: Remove errno.h from auxtrace.h and fix transitive dependencies
      perf arch x86 tests: Add test for topdown event sorting
      perf libbfd: Fix the clang -Wthread-safety build failure
      perf symbol: Fix the build when demangling with libbfd
      perf build: Only pass clang flags to CXX when CXX is clang
      perf build: Use the given CC rather than clang in clang builds
      perf build: Check the version of the compiler that is used
      perf check: Add libbabeltrace to the listed features
      perf test: perf data --to-ctf testing
      tools build: Deduplicate test-libunwind for different architectures
      perf build: Remove leftovers of removed build options
      perf pmu: Add PMU kind to simplify differentiating
      perf evlist: Special map propagation for tool events that read on 1 CPU
      perf test code-reading: Fix duplicate kernel maps and machine leak
      perf build: Clean libperf-gtk.so in 'make clean'
      perf vendor events intel: Fix sierraforest umask encoding.
      perf vendor events intel: Fix skylakex umask encoding.
      perf vendor events intel: Fix snowridgex umask encoding.
      perf pmu: Fix race with concurrent tracepoint creation and removal in perf list
      perf trace: Copy sockaddr arguments by their length
      perf thread_map: Add thread_map__tgid()
      perf build python: Don't leave a.out file when building with clang
      perf python: Add perf.pyi stubs file
      perf python: Clean up and restructure setup.py

Ido Schimmel (2):
      bridge: mcast: Delete empty MDB entry when port group creation fails
      ipv6: Hold RCU when emitting route hardware flags notification

Igor Belwon (1):
      arm64: dts: mediatek: mt6893-pinfunc: Fix pinctrl header path

Igor Skalkin (1):
      usb: gadget: dummy_hcd: fix SuperSpeed ep0 maxpacket

Igor Velkov (3):
      arm64: dts: amlogic: meson-sm1-odroid-hc4: mux the SPI NOR HOLD# and WP# pins
      arm64: dts: amlogic: meson-sm1-odroid-hc4: run the SPI NOR at 40 MHz
      power: supply: gpio-charger: Report discharging without input power

Ilpo Järvinen (1):
      platform/x86: hp-wmi: Order DMI board name arrays

Ilya Leoshkevich (1):
      scripts/gdb/radix-tree: add lx-radix-tree-command

Imre Kaloz (2):
      rtc: ds1685: arm the wake-up alarm at power-off only if an alarm is set
      rtc: ds1685: do not sleep in the power-off handler

Ionut Nechita (1):
      x86/crash: Reserve elfcorehdr for CONFIG_NR_CPUS, not CONFIG_NR_CPUS_DEFAULT

Ivan Hu (1):
      ACPICA: Initialize parser_state.aml_end in acpi_install_method()

Ivan Vecera (6):
      dpll: zl3073x: Add output pin frequency helper
      dpll: zl3073x: Include current frequency in supported frequencies list
      dpll: zl3073x: do not offer 0 Hz as a supported pin frequency
      dpll: zl3073x: clean up esync get/set and use zl3073x_out_is_ndiv()
      dpll: zl3073x: reject inexact frequencies for N-divided outputs
      dpll: zl3073x: reject output frequencies with too small divisor

Jackie Dong (3):
      ALSA: hda/realtek: ALC269 fixup for Lenovo Yoga Pro 7 15ASH111 audio
      ALSA: hda/realtek:ALC269 fixup for Yoga Pro 7 15ASH11 mic mute LED
      ALSA: hda/realtek: ALC269 fixup for Yoga/Legion Mic noise

Jacob Keller (1):
      ice: set in_use only after preparing Tx timestamp index

Jacob Moroni (2):
      RDMA/irdma: Fix erroneous -ENOMEM for large MR registration
      RDMA/irdma: Fix FRWR IRDMAQPSQ_PBLADDR field population

Jaewon Jung (1):
      selftests/ftrace: Avoid unlink error on first run

Jagadeesh Kona (2):
      clk: qcom: rpmhcc: Add LNBB clocks support for Glymur
      clk: qcom: gcc-glymur: Use clk_regmap_phy_mux_ops for GCC UFS muxes

Jake Labelle (1):
      nilfs2: reject non-regular inodes in dsync recovery

Jakub Kicinski (5):
      eth: bnxt: recycle agg buffers when Rx head buffer allocation fails
      eth: bnxt: resize Rx head buffers when rx-copybreak changes
      eth: bnxt: don't leak buffers when XDP agg buffer allocation fails
      eth: bnxt: free XDP frags when xdp_do_redirect() fails
      eth: bnxt: hand XDP frags over to the copybreak skb

Jakub Sitnicki (4):
      net: Helper to move packet data and metadata after skb_push/pull
      bpf: Make bpf_skb_adjust_room metadata-safe
      bpf: Unclone skb head on bpf_dynptr_write to skb metadata
      net: lwtunnel: Drop skb metadata before LWT encapsulation

Jamal Hadi Salim (1):
      net/sched: act_api: reject duplicate actions in a batch

James Clark (3):
      perf python: Track linked libraries as extension dependencies
      perf cs-etm: Don't add global v0 HW_IDs to unformatted queues
      net: ethernet: ti: am65-cpts: fix support for PTP_EXTTS_REQUEST2 ioctl

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

Jared McArthur (2):
      arm64: dts: ti: k3-j722s-evm: Switch audio codec clock from audio_refclk1 to external clock
      arm64: dts: ti: k3-j784s4-j742s2-evm-common: Set ACSPCIe refclk to MAIN_PLL2_HSDIV4 for pcie1

Jason Gunthorpe (3):
      efi/libstub: Fix error unwind freeing fdt in allocate_new_fdt_and_exit_boot()
      efi/riscv: libstub: Don't set image_size in handle_kernel_image()
      efi/libstub: Free cmdline_ptr in efi_pe_entry

Jason Yang (1):
      phy: rockchip-samsung-dcphy: Enable runtime PM at PHY core level

Jasper Wise (1):
      misc: nsm: mark device ready before registering the hwrng and misc device

Javier Carrasco (4):
      hwmon: chipcap2: fix IRQ teardown ordering
      hwmon: chipcap2: disable device after hwmon teardown
      hwmon: chipcap2: serialize access to the alarm indicators
      hwmon: chipcap2: synchronize ready IRQ state

Jeff Chen (1):
      wifi: mwifiex: append hotfix number to firmware version string

Jeff Johnson (1):
      wifi: ath11k: fix reg_info_store leak in ath11k_service_ready_ext_event()

Jennifer Berringer (1):
      riscv: dts: spacemit: set console baud rate on OrangePi RV2

Jens Remus (2):
      perf build: Respect V=1 for Python extension builds
      perf build: Do not duplicate CFLAGS in Python extension builds

Jeremy Bongio (1):
      RDMA/irdma: Use kvzalloc for lvl2 leafmem allocation

Jerome Brunet (2):
      clk: fix self-consuming provider module pinning
      clk: cdce925: Size the PLL child name buffer for any int

Jesse Zhang (4):
      drm/amdgpu: sign extend the addresses GEM_OP(GET_MAPPING_INFO) returns
      drm/amdgpu: drop the gang leader reference when freeing gang jobs
      drm/amdgpu: don't walk the CS chunks when allocating them failed
      drm/amdgpu/userq: fix reading the WPTR at a non-zero BO offset

Jhonata Poma-Hansen (1):
      netlink: check sk_rcvbuf before charging the dump skb

Jia Wang (3):
      dmaengine: dw-axi-dmac: Fix AXI burst length encoding
      dmaengine: dw-axi-dmac: Fix LLI dump out-of-bounds access
      dmaengine: dw-axi-dmac: Fix CH_CFG2 channel priority position

Jiale Yao (28):
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
      ASoC: rt721-sdca: always cancel jack work on remove
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
      clocksource/drivers/timer-ti-dm: Handle runtime resume failure
      team: reject CAN, IEEE 802.15.4 and 6LoWPAN devices in team_port_add
      Drivers: hv: vmbus: Check ACPI companion before use
      regulator: irq: freeze deferred hardware access during suspend

Jianan Huang (2):
      f2fs: quota: fix stale lock holder on remount failure
      f2fs: quota: fix quota flush failure during filesystem freeze

Jiangong.Han (1):
      USB: usbmon: fix null-ptr-deref in mon_bus_remove() when mon_bus_init() fails

Jianlin Shi (4):
      bpf: Roll back stream capacity when allocation fails
      bpf: Fix stream capacity leak in staging path
      bpf: Return partial progress from bpf_stream_read on fault
      bpf: Reject oversized bpf_stream_vprintk output with -E2BIG

Jiawen Liu (3):
      memory: exynos5422-dmc: handle clock enable failures
      crypto: starfive - handle clock enable failures
      spi: rockchip-sfc: disable runtime PM in remove

Jiayuan Chen (6):
      selftests/cgroup: add test for zswap incompressible pages
      tcp_bic: fix divide by zero on max_increment == 0
      tcp_hybla: fix divide by zero on rtt0 == 0
      tcp_cubic: fix divide by zero and endless loop on bad module params
      veth: clear rx queue hint in veth_xmit
      bpf: Fix verifier WARN on narrow read of bpf_tcp_sock u64 fields

Jie Zhang (1):
      drm/msm/a6xx: Add support for Adreno 612

Jiebin Sun (1):
      perf c2c: Fix documented default coalesce fields

Jijie Shao (1):
      net: hibmcge: set netdev_ops before hbg_init() to fix NULL pointer dereference

Jinpyo Lee (1):
      nfs/localio: pin UUIDs during global invalidation

Jisheng Zhang (3):
      regulator: mp886x: fix vsel_mask
      regulator: mp886x: check get_voltage_sel() return value
      regulator: mp886x: fix pontential division by zero

Joachim Eastwood (2):
      arm64: dts: rockchip: fix missing sdmmc cd pinctrl on rk3588s-nanopi-r6
      arm64: dts: rockchip: fix missing pcie rst pinctrl on rk3588s-nanopi-r6

Joas Antonio dos Santos (4):
      calipso: hash the cache key, not the option start, in calipso_cache_add()
      calipso: update payload_len when removing the CALIPSO option
      net: dcb: initialize PFC value before calling getpfccfg
      net: mctp: free reassembly head skb when key_add fails on SOM

Joel Fernandes (1):
      rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path

Johan Hovold (1):
      spi: fsl: switch to managed controller allocation

Johannes Berg (16):
      wifi: mac80211: fix unauthorised port check for encap offload
      wifi: mac80211: fix key selection for encap offload frames
      wifi: mac80211: don't send encap offload frames unencrypted
      wifi: mac80211: drop encap offload frames with a tainted key
      wifi: mac80211: fix IEEE80211_TX_CTL_REQ_TX_STATUS mixup
      um: time-travel: fix sched_yield() behaviour
      wifi: ath6kl: don't take RTNL in del_virtual_intf
      wifi: mac80211: clear fragment cache entry 'is_protected'
      wifi: mac80211: mesh: use hlist_add_head_rcu()
      wifi: mac80211: kill wake_txqs_tasklet on unregistration
      wifi: mac80211: init radiotap iter after length checks
      wifi: mac80211: limit injected HT/VHT MCSes
      wifi: mac80211: fix mbssid/rnr allocation in beacon data
      wifi: cfg80211: reg: protect regdb pointer with RCU
      wifi: iwlwifi: mvm: move rate conversions to utils.c
      wifi: cfg80211: track SSID regardless of country data

Johannes Thumshirn (1):
      btrfs: zoned: fix double list add in btrfs_load_block_group_zone_info

Johannes Weiner (1):
      mm: page_alloc: do not give all non-blocking requests reserve access

John Crispin (1):
      wifi: mt76: mt7996: disable the RX NAPIs before the DMA cleanup

John Garry (2):
      scsi: core: Introduce .queue_reserved_command()
      scsi: scsi_debug: Stop printing extra function name in debug logs

John Johansen (6):
      apparmor: refactor xattr attachment, to take the file path
      apparmor: constify aa_perms parameters that are read-only
      apparmor: constify aa_profile parameters on read-only compute paths
      apparmor: optimize current_label_crit_section() with needput
      apparmor: fix check SCTP bind, and connect permission checks
      apparmor: advertise that sctp is being mediated

John Madieu (1):
      thermal: renesas: rzg3e: Remove stale @trim_offset kernel-doc entry

Jonathan Santos (2):
      spi: axi-spi-engine: fix stale SYNC IRQ pending
      spi: axi-spi-engine: fix stale SYNC IRQ pending in trigger_enable

Joonhoe Kim (5):
      drm/msm/dpu: disable the slave encoder before the master
      drm/msm/dpu: compute the CRTC bandwidth from the state being checked
      drm/msm/dpu: round up the compressed INTF width
      ASoC: codecs: wcd939x: read the SoundWire port switches per channel
      power: supply: qcom_battmgr: report the USB type from USB_ADAP_TYPE

Jori Koolstra (2):
      Add error handling to minix filesystem for inode corruption detection
      Fix a drop_nlink warning in minix_rmdir

Jork Loeser (1):
      x86/hyperv: move stimer cleanup to hv_machine_shutdown()

Josef Bacik (50):
      mm/hugetlb: fix endless write fault on a leftover uffd bit
      mm/shmem: hold off eviction in shmem_writeout()
      pidfs: don't let PIDFD_GET_INFO miss a reaped task
      mm/filemap: read mapping->a_ops->free_folio under i_lock
      bpf: Use the frame mem type in devmap egress XDP
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
      bpf, cpumap: Hold the device of frames in the queue
      bpf: Follow the head if an skb is written from a slice
      bpf: Use memmove() to store bytes in an skb
      nvmet: don't truncate the length of big discards
      nvmet-auth: take only AUTH_Negotiate for a negotiation
      nvmet: fix NULL dereference of PCI endpoint targets
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
      blk-mq: don't trust the cookie in blk_mq_poll()
      blk-mq: keep sharing tags fairly after a queue update
      blk-mq: don't bring back flags of a completed request
      blk-mq: don't forget a timer the driver has restarted
      blk-mq: quiesce a queue that joins a quiesced tag set
      blk-mq: exit the hctxs of a queue under tag_list_lock
      blk-mq: set up a queue under tag_list_lock
      block: partitions/mac: compute the sectors in 64 bits
      blk-mq: free the bitmaps of tags in the SRCU callback
      drbd: stop the start_resync timer of a dying device
      drbd: take req_lock to skip the initial sync as peer
      block/rnbd-srv: don't free the device on a sysfs error
      block/rnbd-srv: drop the sess_dev kobject unlocked

Joseph Qi (6):
      dlm: fix buffer overflow from negative len in dlm_search_rsb_tree
      ocfs2: fix deadlock in inline-data truncate transactions
      ocfs2: reject inconsistent xattr bucket during defrag
      ocfs2: retain all security xattrs during inode creation
      ocfs2: fix possible deadlock between nfs_sync_rwlock and fs_reclaim
      ocfs2: reserve xattr value tree metadata only once

Julian Anastasov (2):
      ipvs: fix buffer overflow when sending sync messages
      ipvs: fix more races around the overload flag

Julian Braha (1):
      kconfig: fix extra output from savedefconfig on out-of-range defaults

Julian Sun (2):
      block: reject NOWAIT buffered write fallback
      block: take the inode lock for buffered write fallback

Julius Bairaktaris (3):
      wifi: ath11k: disable interrupts during firmware crash recovery
      wifi: mac80211: fix swapped fq_overlimit/fq_overmemory in aqm debugfs
      wifi: mac80211: don't reset the TXQ scheduling round number

Junhui Liu (4):
      clk: sunxi-ng: div: Add feature support to M clock macro
      clk: sunxi-ng: sun55i-a523-ccu: Use M-only clocks for MBUS, IOMMU and DRAM
      clk: sunxi-ng: sun55i-a523-ccu: Use P-only clocks for high-speed timers
      clk: sunxi-ng: sun55i-a523-r-ccu: Use P-only clocks for timers

Junjie Cao (1):
      Bluetooth: btusb: drop BROKEN_EXT_SCAN quirk for 0bda:a728

Junxian Huang (2):
      RDMA/hns: Limit gmv_entry_num to avoid memory waste
      RDMA/hns: Fix GID capacity loss in 64K system

Justin Yeh (2):
      arm64: dts: mediatek: mt8188-geralt: Enlarge SCP core0 memory region
      HID: i2c-hid: Unfollow the panel on shutdown

Jérémie Rodon (1):
      spi: cs42l43: Add speaker ID quirk for Dell XPS 13 DX13260 SKU 0E54

Jérémy Jean (9):
      microblaze: prevent ptrace writes to MSR and pt_mode
      crypto: rsassa-pkcs1 - reject undersized keys when signing
      crypto: rsassa-pkcs1 - reject undersized keys when verifying
      md: reject v0.90 arrays with too many devices
      NFS: filelayout: calculate dense stripe width in 64 bits
      macsec: prevent AES-GCM nonce reuse after packet number wrap
      netfilter: nf_conntrack: avoid truncating IPv6 nexthdr offset
      apparmor: check connect permission for SCTP
      nvmet-auth: reject incomplete DHCHAP messages

Jérôme Pouiller (2):
      wifi: wfx: fix possible device hang during init
      wifi: wfx: fix use-after-free of the cooling work on device removal

K Prateek Nayak (1):
      cpufreq/amd-pstate-ut: Fix amd_pstate_ut_check_freq failure with 'Requested CPU Min frequency' BIOS option

KaFai Wan (3):
      selftests/bpf: Fix prog_tests framework subtest count checks
      selftests/bpf: Skip expected_msgs subtests when stdout is not saved
      selftests/bpf: Use _exit() in uprobe_multi_test clone-ed child

Kaifeng Wang (1):
      tcp: reject devmem tx with fastopen and repair

Kang Yang (1):
      wifi: ath12k: avoid double DMA unmap of held monitor RX buffers

Karl Asseily (1):
      dt-bindings: vendor-prefixes: add ESS Technology

Karl Mehltretter (43):
      ocfs2/cluster: hold a reference on the heartbeat thread
      ABI: sysfs-class-infiniband: Drop the entries of the removed qib driver
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
      cgroup/dmem: Fix eviction helper reference in dmem_cgroup_try_charge()
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
      ASoC: codecs: es8375: use devm_clk_get_optional() for mclk
      floppy: flush pending work before releasing resources on init failure
      rcuref: Fix the rcuread_is_dead reference in rcuref_read() kernel-doc
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

Kees Cook (3):
      kbuild: Mark the initcall ordering recipe as recursive
      seq_buf: Do not print an empty line from an overflowed seq_buf_do_printk()
      mm/slab: Mark the kmem_buckets_create() context as a Context: section

Keguang Zhang (1):
      pwm: loongson: Reload PWM configuration through counter reset

Keisuke Tsukuda (2):
      usb: gadget: composite: avoid warning on aborted delayed status
      usb: gadget: f_mass_storage: ignore class requests while inactive

Kent Gibson (1):
      gpiolib: fix memory leak in gpiod_set_array_value_complex() EPERM error path

Kevin Wang (1):
      drm/amd/pm: populate unique ID for smu 13.0.7

Khalid Faisal Ansari (1):
      arm64: dts: qcom: hamoa-iot-evk: Enable TPM (ST33) on SPI11

Kim Wooseok (1):
      wifi: rtl8xxxu: free RX skb when URB submission fails

Kiran K (2):
      Bluetooth: btusb: Preserve event and ACL packet ordering
      Bluetooth: btintel: Zero version data before parsing TLVs

Kohei Enju (1):
      arm64: rsi: Correct type of realm_config::hash_algo

Koichiro Den (2):
      PCI: endpoint: pci-epf-vntb: Pass PF/VF number when BAR programming
      PCI: endpoint: pci-epf-vntb: Serialize virtual PCI bus scan

Konrad Dybcio (8):
      dt-bindings: display: panel: samsung,s6e8aa5x01: Allow common properties
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

Kris Pan (1):
      net: iterate online nodes in skb_defer_free_flush()

Kristen Carlson Accardi (1):
      platform/x86/intel: power-domains: Handle failed init in tpmi_get_linux_die_id()

Krzysztof Kozlowski (2):
      drm/msm: Properly handle msm_ioremap() without name
      dt-bindings: display/msm: hdmi: Correct name of disallowed supplies

Krzysztof Wilczyński (3):
      PCI/sysfs: Stop reporting _DSM failures as -EPERM
      PCI/sysfs: Handle a malformed _DSM result in acpi_attr_is_visible()
      PCI/sysfs: Decouple acpi_index from the optional device name element

Kuba Piecuch (1):
      sched_ext: Skip ops.set_weight() for disabled tasks

Kumar Kartikeya Dwivedi (3):
      bpf: Reject oversized stream read buffers
      bpf: Skip zero-length stream writes
      bpf, riscv: Fix stack-passed arguments for indirect trampolines

Kunhai Dai (1):
      blk-iocost: publish hweights as one atomic value

Kuninori Morimoto (5):
      ASoC: codecs: sta32x: convert to snd_soc_dapm_xxx()
      ASoC: codecs: nau8822: convert to snd_soc_dapm_xxx()
      ASoC: codecs: rt1015: convert to snd_soc_dapm_xxx()
      ASoC: codecs: ab8500: use snd_kcontrol_chip() instead of snd_soc_kcontrol_component()
      ASoC: codecs: ab8500: convert to snd_soc_dapm_xxx()

Kunwu Chan (1):
      rcutorture: Fix divide-by-zero with fwd_progress_div=1

Kyle Pepper (1):
      Bluetooth: hci_sync: scan unfiltered for host-resolved RPAs

Kyle Zeng (3):
      gro: do not GRO GSO packets with inconsistent payload
      tcp: avoid double destroy in tcp_abort() of an unaccepted child
      tcp: initialize mapped children before route lookup

Kyrylo Biryuk (1):
      ata: libahci: re-enable FBS after error handling on a port multiplier

Lachlan Hodges (1):
      wifi: mac80211: don't seed an S1G sta's last_rate

Lance Yang (1):
      khugepaged: fix readahead lock inversion in collapse_file()

Laurence Oberman (2):
      scsi: st: Restore changed drive settings after reset also for MTLOAD and MTRETEN
      scsi: st: Record the tape position after a successful MTLOAD

Laxman Acharya Padhya (1):
      Bluetooth: btintel: propagate version TLV parsing errors

Lee Jia Jie (1):
      perf: Fix UAF in attach_task_ctx_data()

Lee Jones (1):
      ASoC: SOF: Intel: hda-sdw-bpt: Stop active DMA before closing BPT streams

Leizhen Zhang (2):
      gen_init_cpio: stop parsing on lines with a missing argument list
      kconfig: fix infinite loop in conf_choice() when no choice value is visible

Len Brown (3):
      tools/power turbostat: pmt: Improve sscanf() hygiene
      x86_energy_perf_policy: Fix optarg keyword matching
      x86_energy_perf_policy: Cleanup: Check fseek() in VM path

Leo Cheng (2):
      nvmem: layouts: sl28vpd: fix device_node reference leak in error path
      nvmem: layouts: onie-tlv: fix device_node reference leak in error path

Leo Liu (1):
      drm/amdgpu: cancel idle work in hw_init failure paths for vcn/uvd/vce/jpeg

Leo Yan (2):
      perf build: Build the Python extension before pylint consumers
      coresight: Take hotplug lock in enable_source_store() for Sysfs mode

Leon Hwang (2):
      bpftool: Generate skeleton for global percpu data
      bpftool: Compute map size of light skeletons at runtime

Leon Romanovsky (9):
      RDMA/irdma: Preserve fast-registration IOVA on 32-bit
      PCI/P2PDMA: Separate the mmap() support from the core logic
      PCI/P2PDMA: Do not tear down the allocate attribute on registration failure
      PCI/P2PDMA: Safely terminate ACS redirect lists
      PCI/P2PDMA: Gate the host bridge whitelist warning on verbose
      RDMA/core: Preserve the selected source GID on failed AH modification
      RDMA/core: Free unpublished port statistics after initial-read failure
      RDMA/core: Reject LAG selection when source MAC lookup fails
      PCI/P2PDMA: Add missing struct p2pdma_provider documentation

Li RongQing (12):
      RDMA/uverbs: Make CQ handle mandatory for WQ creation
      RDMA/core: Fix swapped list_add_tail() arguments in ib_add_sub_device()
      RDMA/restrack: Don't set RESTRACK_DD mark after a failed xa_insert()
      RDMA/uverbs: Drop restrack ref on ib_init_ucontext() failure in GET_CONTEXT
      RDMA/core: Fix partial copy of IPv6 flow_lbl in LAG hash skb
      RDMA/mlx5: Guard steering anchor resource destruction on create error
      RDMA/mlx5: Use DEFINE_RAW_FLEX for leftovers flow attributes
      RDMA/mlx5: Restore mr->pi_mr after temporary stack-local assignment
      IB/isert: Don't share drop_cmd_list across concurrent connection teardowns
      ublk: use global index for reported zones
      block, bfq: initialize active lists for all actuators
      RDMA/mlx5: Fix CQ resize destination index mask

Li Wang (4):
      selftests/cgroup: skip test_zswap if zswap is globally disabled
      selftests/cgroup: avoid OOM in test_swapin_nozswap
      selftests/cgroup: use runtime page size for zswpin check
      selftests/cgroup: replace hardcoded page size values in test_zswap

Li Youhong (2):
      spi: amlogic-spisg: check clk_prepare_enable() return value
      md/raid5: drain released_stripes before destroying the cache

Liam R. Howlett (Google) (1):
      tools/testing/shared: catch a failed posix_memalign()

Liang Hao (1):
      timers: Clear pending_map on CPU hotplug

Lijo Lazar (2):
      drm/amdgpu: Print full vbios info
      drm/amdgpu: bounds check ATOM IIO table parsing

Linkai Gong (6):
      drivers/base/node: fix UAF on device_register() failure
      firmware: imx: dsp: fix mailbox channel leak on kasprintf failure
      misc: enclosure: fix UAF on device_register() failure
      clk: imx: composite-93: return timeout from gate enable
      mailbox: arm_mhuv2: time out if the receiver never comes up
      char: scx200_gpio: check cdev_add() return value

Linkui Xiao (1):
      net: bridge: netlink: do not clear the vlan info dump error

Linmao Li (2):
      power: supply: bq2515x: Propagate charge-enable read errors
      crypto: mxs-dcp - handle zero-length skcipher requests

Linus Torvalds (2):
      vhost: vringh: use get_user()/put_user() for IOTLB 16-bit accesses
      vdpa_sim: disable page faults around vringh_need_notify_iotlb()

Linus Walleij (45):
      regulator: ab8500: Fix AB8505 VANA voltage selectors
      regulator: ab8500: Add AB8505 VAUX3 3.05 V setting
      regulator: ab8500: Handle AB8505 VINTCORE selector 7
      regulator: ab8500: Treat cut 1.0 VAUX3 as fixed
      regulator: ab8500: Test dedicated enable bits only
      regulator: ab8500: Propagate mode enable read errors
      ASoC: ab8500: Remove the nonfunctional sidetone apply control
      ASoC: ab8500: Skip digital microphone support on AB8505
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

Liviu Nicoara (1):
      power: supply: qcom_battmgr: Report capacity on X1E80100

Lizhi Hou (2):
      accel/amdxdna: Fully initialize map structure before registering notifier
      accel/amdxdna: Set HMM_PFN_REQ_WRITE for writable BO faults

Logan Gunthorpe (2):
      dmaengine: ioat: disable relaxed ordering before registering the device
      dmaengine: plx_dma: fix NULL pointer deref in plx_dma_isr()

Logan Odell (1):
      PCI/IOV: Read VF config values that need not match PF

Long Zhao (1):
      dt-bindings: vendor-prefixes: add Ambarella

Longfang Liu (1):
      hisi_acc_vfio_pci: fix NULL dereference in reset_prepare on PF passthrough

Longlong Xia (1):
      rcu: fix shrink budget underflow in lazy_rcu_shrink_scan

Lorenzo Bianconi (1):
      wifi: mt76: mt7996: Remove unnecessary phy filed in mt7996_vif_link struct

Lorenzo Stoakes (ARM) (6):
      mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
      mm/vma: avoid spurious write locks when mm->mm_lock_seq overflows
      mm/vma: avoid losing atomic VMA flags when setting sticky VMA flags
      fs/proc/task_mmu: fix missed VMAs when reading /proc/PID/maps and friends
      kbuild: do not allocate .modinfo in vmlinux
      ALSA: us122l: mark hwdep mappings VM_MIXEDMAP

Lu Baolu (6):
      iommu/vt-d: Do not ignore context table copy failures
      iommu/vt-d: Cache max domain ID to avoid redundant calculation
      iommu/vt-d: Handle DID reservation errors when copying context tables
      iommu/vt-d: Reserve scalable-mode DIDs from PASID entries during copy
      iommu/vt-d: Fix iopf refcount leak in nested attach
      iommu/vt-d: Drop old iopf ref only after attach succeeds

Luca Ceresoli (1):
      drm/rockchip: dw_hdmi_qp: remove now-redundant call to drm_connector_attach_encoder()

Luca Leonardo Scorcia (1):
      clocksource/drivers/timer-mediatek: Fix random crash at boot

Luca Weiss (3):
      dt-bindings: clock: qcom,milos-camcc: Document interconnect path
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

Mahe Tardy (1):
      libbpf: fix log level propagation for light skeleton loaders

Malathi A (1):
      serial: 8250_uniphier: Use devm_clk_get_enabled()

Malte Wechter (1):
      rnull: configfs: add power to configfs features

Manivannan Sadhasivam (1):
      PCI: qcom: Honor IOMMU provider's #iommu-cells in qcom_pcie_config_sid_1_9_0()

Manuel Ebner (1):
      ipe: fix invalid sgid value in audit event documentation

Manuel Fombuena (11):
      leds: st1202: Clear unused pattern slots in pattern_set()
      leds: st1202: Name pattern index variables consistently
      leds: st1202: Scale pattern brightness to the 12-bit PWM range
      leds: st1202: Add hardware-accelerated blink support
      leds: st1202: Spell out the phase-shift configuration bit
      leds: st1202: Program the channel current for hardware patterns
      leds: st1202: Take a reference on the LED firmware node
      leds: st1202: Do not set brightness from atomic context
      leds: st1202: Clear unused pattern slots in blink_set()
      leds: st1202: Honour max_brightness when blinking
      leds: st1202: Cap the channel current in st1202_led_set()

Manush Prajwal (1):
      pwm: lp3943: fix NULL pointer dereference for an unconfigured channel

Marc Kleine-Budde (4):
      spi: spi-sun4i: sun4i_spi_transfer_one(): fix transfers for SUN4I_FIFO_DEPTH
      spi: spi-sun4i: sun4i_spi_fill_fifo(): always apply A10 FIFO fill level workaround
      spi: spi-sun4i: sun4i_spi_transfer_one(): fix setting of clock rate
      spi: spi-sun4i: sun4i_spi_handler(): fix race condition between transfer completion and RX FIFO interrupt

Marc Zyngier (1):
      KVM: arm64: Sanitise ID_AA64MMFR3_EL1.S1P[IO]E

Marcel Hofmann (1):
      remoteproc: imx_rproc: Allow mappings ending at region boundary

Marco Crivellari (2):
      ASoC: replace use of system_wq with system_dfl_wq
      regulator: irq_helper: replace use of system_wq with system_dfl_wq

Marco Giunta (3):
      ASoC: aw88399: extract shared device library
      ASoC: aw88399: add per-instance BSTS status bypass flag
      ASoC: aw88399: skip BSTS check when boost converter is bypassed

Marek Maslanka (1):
      platform/chrome: cros_ec_typec: Poll for role swap completion

Marek Szyprowski (6):
      ARM: 9519/1: dma-mapping: Fix wrong free function in __iommu_alloc_simple() error path
      ASoC: wm8994: fix MCLK gating for AIF clocks sourced from MCLK2
      ASoC: wm8994: don't lose the AIF clock ratio when staying at 32kHz SYSCLK
      ASoC: wm8994: fix MCLK index used for setting MCLK rate
      ASoC: samsung: midas_wm1811: run FLL1 at the AIF1 configured rate when idle
      ASoC: wm8994: follow AIF clock source changes in MCLK gating

Marek Vasut (3):
      drm: of: Fix drm_of_get_data_lanes_count_ep() return value documentation
      ARM: dts: stm32: Drop bias-disable from STM32MP15xx DHCOM SoM sdmmc1_b4_pins_a
      PCI: rcar-gen4: Add missing PM ops

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

Markus Probst (3):
      rtc: s35390a: Add missing newline to dev_err
      rtc: s35390a: Fix alarm not disabling
      rtc: s35390a: Read 24-hour mode on access

Markus Schneider-Pargmann (TI) (6):
      arm64: dts: ti: k3-am62a-phycore-som: Fix wkup R5F memory region size
      arm64: dts: ti: k3-am62d2-evm: Fix wkup R5F memory region size
      arm64: dts: ti: k3-am62a7-sk: Fix wkup R5F memory region size
      arm64: dts: ti: k3-am62p-verdin: Fix wkup R5F memory region size
      arm64: dts: ti: k3-am62p5-sk: Fix wkup R5F memory region size
      arm64: dts: ti: var-som-am62p: Fix wkup R5F memory region size

Mateusz Nowicki (3):
      arm64: dts: st: fix arm,smc-id of the SMC watchdog on stm32mp2
      arm64: dts: st: fix sai3b unit address on stm32mp251
      arm64: dts: st: fix sai3b unit address on stm32mp231

Matheus Alves de Almeida (1):
      HID: wacom: fix wacom_intuos_irq NULL pen_input deref

Mathieu Desnoyers (1):
      mm: fix OOM killer inaccuracy on large many-core systems

Matt Turner (1):
      alpha: select SYSCTL_EXCEPTION_TRACE

Matteo Kloiber (1):
      rust: scatterlist: honor the device's maximum segment size

Matthew Wilcox (Oracle) (2):
      ntfs: Do not kmap page cache pages for compression
      ntfs: Do not kmap pages used for reading from disk

Matthew Wood (1):
      bpf, arm64: Fix racy plt target update in bpf_arch_text_poke()

Matthias Goergens (2):
      x86/hibernate: Ignore page-zero RAM in E820 checksum
      isofs: return long Joliet names whole

Matthieu Baerts (NGI0) (2):
      mptcp: options: mpc: avoid printing uninit data
      mptcp: options: dss: avoid printing uninit csum

Matti Vaittinen (2):
      iio: pressure: rohm-bm1390: Fix AVE_NUM initialization
      iio: accel: kionix-kx022a: Fix IPOL macro name

Maulik Shah (1):
      arm64: dts: qcom: purwa: Drop the Hamoa workaround for PDC

Mauricio Faria de Oliveira (4):
      x86/boot: Remove redundant "cc" clobber in memcmp() and document it
      x86/asm, x86/boot: Carve out inline memcmp() into a separate header
      x86/asm: Group inline string functions
      x86/pvh: Really inline memcmp() and memset() to fix unbootable VMs

Max Kellermann (1):
      ceph: remove unused field `i_cap_migration_resv`

Maxim Skokov (1):
      bpf: test_run: Fix false -EBADMSG after skb leaves CHECKSUM_COMPLETE

Maxime Bélair (3):
      apparmor: report a label allocation failure as -ENOMEM
      apparmor: fix table_size() integer overflow on 32 bit
      apparmor: convert duplicated dfa transitions to match_char()

Maxime Chevallier (1):
      net: Use a dedicated flag to track disabled napi instances

Maíra Canal (2):
      arm64: dts: broadcom: bcm2712: Add V3D device node
      drm/vc4: Drop the undocumented brcm,vc4-v3d compatible

Melissa Wen (7):
      drm/amd/display: Signal PQ EOTF in FreeSync infopacket for DP HDR
      drm/amd/display: assign missing trace entry in amdgpu_dm_dc_clocks_state
      drm/amd/display: remove duplicated prev_p_state_change_support assignment
      drm/amd/display: fix vready offset assignment in dcn_optc_lock_unlock_state
      drm/amd/display: use right type for amdgpu_dc_performance event entries
      drm/amd/display: copy function name into dcn_fpu trace event
      drm/amd/display: copy function name into dcn_optc_lock_unlock_state trace event

Miaoqing Pan (3):
      wifi: ath11k: fix sporadic WLAN initialization failures
      wifi: ath11k: fix NULL dereference in ahb remove when QMI init incomplete
      wifi: ath11k: unregister PM notifier on QMI init failure path

Michael Auer (1):
      ASoC: qcom: sdm845: Disable the quaternary MI2S bit clock on shutdown

Michael Jeanson (1):
      perf data ctf: replace libbabeltrace with babeltrace2-ctf-writer

Michael Petlan (1):
      perf test attr: Propagate the return value from the test to the wrapper

Michael S. Tsirkin (2):
      virtio: synchronize callbacks after device reset
      virtio_pci_modern: move avq cleanup from reset to del_vqs

Michail Andreas Michalopoulos (2):
      ksmbd: reject FILE_ATTRIBUTE_TEMPORARY on directories
      ksmbd: select CRYPTO_AES

Michal Pluta (2):
      perf test demangle: Fail when demangling fails
      perf symbol: Don't return an unterminated Rust demangle buffer

Michał Kopeć (2):
      ASoC: mediatek: common: Keep codec references until the card is bound
      ASoC: mediatek: mt8188: Constrain UL8 FE to its back end's capabilities

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

Ming Lei (1):
      ublk: allow a NULL io->cmd in the cancel callback

Mingming Cao (9):
      ibmveth: fix netpoll races with RX replenish
      ibmveth: do not close twice after a failed reopen
      ibmveth: disable the reset work before unregister in remove
      ibmveth: step past bad RX correlators instead of spinning or oopsing
      ibmveth: release the pool kobjects when probe fails
      ibmveth: return the error when set_channels cannot add TX queues
      ibmveth: wait for in-flight transmits in ibmveth_close()
      ibmveth: wait for the RX poll to return before freeing the RX queue
      ibmveth: check headers in the RX large send and checksum helpers

Mingpei CAO (2):
      libbpf: Fix array comparison in BTF dedup
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

Mohd Ayaan Anwar (3):
      arm64: dts: qcom: lemans-ride-common: fix SerDes PHY regulator supplies
      arm64: dts: qcom: monaco-evk: fix SerDes PHY regulator supplies
      arm64: dts: qcom: qcs8300-ride: fix SerDes PHY regulator supplies

Mostafa Saleh (2):
      iommu/arm-smmu-v3: Ensure L2 tables are visible before L1 ptrs
      iommu/arm-smmu-v3-test: Fix arm_smmu_v3_test_debug_print_used_bits()

Muchun Song (1):
      dax/bus: Return errors for invalid mapping targets

Muhammad Bilal (4):
      crypto: ccp - fix SFS ioctl race against device teardown
      platform/x86: hp-bioscfg: fix off-by-one in password length check
      platform/x86: hp-bioscfg: validate SPM state returned by firmware
      platform/x86: hp-bioscfg: fix oops on short integer attribute buffer

Mukesh Ojha (1):
      firmware: qcom: tzmem: Use DO_ONCE_SLEEPABLE() in qcom_tzmem_enable()

Muzaffer Kadir (1):
      dt-bindings: vendor-prefixes: Add General Mobile

Myeonghun Pak (15):
      hwmon: (sht15) Stop deferred work before releasing its resources
      staging: rtl8723bs: disable SDIO function on block size failure
      dmaengine: mediatek: hsdma: fix runtime PM leak on init failure
      interconnect: exynos: Remove the PM QoS request on unbind
      serial: sh-sci: Unregister UART on sysfs setup failure
      mfd: intel_quark_i2c_gpio: Manage the fixed-rate clock
      mfd: da9150: Balance IRQ wake on teardown
      spi: rockchip-sfc: skip DMA cleanup in PIO mode
      PCI: aardvark: Disable PHY on probe failures
      clk: ti: adpll: unregister OF clock provider on remove
      fbdev: gxt4500: Release WC setup on probe failure
      ASoC: rt5645: Shut down the button timer on removal
      platform: cznic: turris-omnia-mcu: stop button emulation producers
      net: hix5hd2: serialize timeout recovery with interface teardown
      platform/x86: gpd pocket fan: Cancel work before releasing GPIOs

Mykyta Yatsenko (4):
      bpftool: Accept zero perf counter snapshots
      bpftool: Group profile events by CPU
      bpftool: Scale counters and report cycles per run
      bpf: Migrate bpf_task_work to kmalloc_nolock

Naman Gulati (1):
      netdev-genl: ignore NETDEV_UNREGISTER rebroadcasts

Namhyung Kim (3):
      perf symbol: Fix symbol loading from libbfd
      perf symbol: Add missing symsrc__destroy() for libbfd
      perf c2c: Fix memory leaks on output fields

Namjae Jeon (5):
      ksmbd: fix listener task lifetime on netdev events
      ksmbd: preserve open change time across rename
      ksmbd: return requested create allocation size
      ksmbd: stabilize allocation size after buffered writes
      ksmbd: fix fd_limit accounting across durable reconnects

Nandor Kracser (1):
      tls: avoid field-spanning write when copying crypto info

Nathan Chancellor (1):
      kbuild: Remove alignment on .modinfo section

Naveen Kumar Chaudhary (2):
      kdb: fix memory leak in kdb_setenv() when environment is full
      kdb: unify CMD_BUFLEN definition into kdb_private.h

Nehuen Lian Bova (1):
      HID: magicmouse: fix null pointer dereference in magicmouse_event()

Neil Armstrong (2):
      dt-bindings: vendor-prefixes: add vendor prefix for Nexperia B.V.
      soc: qcom: geni-se: provide PROG_RAM_DEPTH for I2C HUB Serial Engines

Nguyen Ngoc Thang (4):
      md: take reconfig_mutex when enabling PPL on an inactive array
      ocfs2: validate chunk and block counts of the local quota file
      libceph: reject bad connect_seq in msgr1 READY reply
      minix: reject rmdir of a directory with a corrupted link count

Nguyễn Văn Cao Nguyên (1):
      RDMA/irdma: Do not move a fresh RoCE QP to ERROR on RESET

Nia Su (1):
      perf evlist: Don't restrict uncore events to PMU CPUs

Nick Huang (1):
      rtc: s35390a: use u8 instead of char for register buffer

Nickolai Zeldovich (6):
      proc/kcore: advance the vmalloc retry by the last copy, not the total
      nsfs: check the trailing bytes of a file handle in bytes, not words
      nsproxy: Fix cred leak in the error path of prepare_nsset()
      splice: retry tee() instead of returning 0 when it races
      ucount: read the parent ucounts before dropping the rlimit count
      fs_pin: do not trust the pin after a spurious wakeup in pin_kill()

Nicolai Buchwitz (9):
      net: selftests: use skb_share_check() in the loopback receive hook
      net: stmmac: selftests: use skb_share_check() in the loopback receive hook
      net/mlx5e: use skb_share_check() in the loopback selftest hook
      net: usb: cdc_ncm: don't enable BHs in tx_fixup under netpoll
      net: usb: cdc_mbim: don't enable BHs in tx_fixup under netpoll
      net: bcmgenet: recover from a failed resume
      net: bcmgenet: restore the Tx coalescing setting when the rings are rebuilt
      octeontx2-pf: fix skb use-after-free on ipsec transmit drop
      octeontx2-pf: pass the skb to otx2_dma_unmap_skb_frags()

Nicolas Escande (1):
      wifi: ath11k: fix locking problem in ath11k_dp_rx_tid_del_func()

Nicolas Frattaroli (1):
      drm/panthor: Take reqs_lock in soft_reset for clearing pending_reqs

Nicolas Morey (1):
      RDMA/rxe: Use validated num_sge in local buffer

Nicolas Schier (1):
      kconfig: tests: Provide defconfig outfile for savedefconfig

Nicolo Giuliani (1):
      dt-bindings: vendor-prefixes: Add Sophos

Nikhil P. Rao (1):
      ionic: fix port_info use-after-free on firmware recovery

Niklas Cassel (12):
      scsi: scsi_debug: Refuse a negative physblk_exp
      scsi: scsi_debug: Take the zone metadata lock before the data lock
      scsi: scsi_debug: Avoid 32-bit overflow in WRITE SCATTERED offsets
      scsi: scsi_debug: Advance the write pointer over the data written
      scsi: scsi_debug: Refuse a short WRITE ATOMIC (16) before writing it
      scsi: scsi_debug: Map the region written by WRITE ATOMIC (16)
      scsi: scsi_debug: Validate the access parameters of WRITE ATOMIC (16)
      ata: libata: Move quirk flags to their own enum
      ata: libata-core: Quirk DELLBOSS VD max_sectors
      ata: libata: Add ATA_QUIRK_MAX_SEC and convert all device quirks
      ata: libata-core: Quirk INTEL SSDSC2KG480G8 max_sectors
      ata: libata-core: Fix NO_FUA quirks shadowed by earlier quirk entries

Niko Huuskonen (2):
      ALSA: caiaq: Serialize access to the EP1 command buffer
      ALSA: caiaq: Fix the Kore controller key map

Nikolay Borisov (1):
      ata: sata_dwc_460ex: Don't enable interrupt if libATA core registration fails

Nora Schiffer (1):
      ARM: dts: imx7-tqma7: correctly specify PMIC voltage constraints

Norbert Szetei (1):
      RDMA/rxe: Reject prefetch of a non-ODP MR

Oleg Keri (1):
      drm/msm/dp: don't report link training success after a reinit

Omar Ramadan (1):
      amt: pull the AMT header behind the transport header in amt_parse_type()

Orgad Shaneh (2):
      staging: octeon: schedule the TX cleanup tasklet every 1024th packet
      MIPS: Octeon: size the swiotlb for a modular OHCI platform driver

Oualid Derouiche (1):
      arm64: dts: imx8mp-kontron: Fix LVDS clock frequency for DL device

Ovidiu Panait (5):
      drivers/thermal/renesas/rzg3e: Fix signed integer overflow in temp_to_code()
      thermal/drivers/renesas/rzg3e: Fix runtime PM handling of compare irq
      thermal/drivers/renesas/rzg3e: Fix race between set_trips() and get_temp()
      spi: rspi: Fix DMA mode when the DMA controller is built as a module
      net: stmmac: Track the TX DMA threshold per queue

Pablo Neira Ayuso (1):
      netfilter: nft_set_rbtree: narrow down range completion to anonymous sets

Palla Raghunath (1):
      nvmet-fc: don't drop the last assoc reference in nvmet_fc_delete_ctrl()

Pan Chuang (2):
      hwmon: (sht15) Remove redundant dev_err()
      mailbox: Remove redundant dev_err()/dev_err_probe()

Paolo Abeni (1):
      gtp: hold RCU in gtp_genl_send_echo_req()

Patrick Oppenlander (1):
      rpmsg: virtio: EPOLLOUT support

Paul Chaignon (3):
      bpf: Refactor cleanup of bpf_prog_test_run_skb
      bpf: Reorder bpf_prog_test_run_skb initialization
      bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN

Paul Dolan (2):
      selftests/clone3: tighten CLONE_CLEAR_SIGHAND conflict test
      selftests/pidfd: fix PPID values in error message

Paul Moses (2):
      perf mmap: Use the head selected by read_init
      perf mmap: Preserve the consumed cursor in forward mode

Paul Sajna (1):
      arm64: dts: qcom: sdm845-lg: fix sdcard pinctrl nodes

Pauli Virtanen (4):
      Bluetooth: L2CAP: take chan->lock for l2cap_chan_add/ready/del
      Bluetooth: L2CAP: hold l2cap_conn::lock in l2cap_connect_cfm()
      Bluetooth: L2CAP: hold chan in l2cap_ecred_conn_rsp()
      Bluetooth: hci_sync: fix mesh adv timeout units

Pei Xiao (3):
      comedi: dt2811: fix shift-out-of-bounds in IRQ check
      ata: pata_parport: Fix use-after-free in new_device_store
      ata: pata_parport: fix parport attach idr_alloc for

Peng Fan (9):
      remoteproc: imx_dsp_rproc: Drop extra space
      arm64: dts: imx8dxl-evk: fix reserved memory node names for remoteproc
      arm64: dts: imx8qm-mek: fix reserved memory node names for remoteproc
      arm64: dts: imx8qm-mek: fix dsp reserved memory node names for remoteproc
      arm64: dts: imx8qxp-mek: fix reserved memory node names for remoteproc
      arm64: dts: imx8qxp-mek: fix dsp reserved memory node names for remoteproc
      arm64: dts: imx8ulp-evk: fix reserved memory node names for remoteproc
      arm64: dts: imx93-14x14-evk: fix reserved memory node names for remoteproc
      arm64: dts: imx93-9x9-qsb: fix reserved memory node names for remoteproc

Pengfei Zhang (1):
      net: stmmac: xgmac: do not treat TBU as a TX event

Pengpeng Hou (40):
      spi: sh-msiof: propagate setup runtime-PM errors
      remoteproc: imx_dsp: Acquire runtime PM before adding carveouts
      irqchip/riscv-imsic: Use GENMASK for base address masks
      memory: brcmstb_dpfe: validate firmware section sizes
      ASoC: es8326: report resume restore errors
      ASoC: es8375: report resume restore errors
      ASoC: es8389: report resume restore errors
      ASoC: fs210x: report register restore errors
      ASoC: codecs: sma1307: validate setting firmware layout
      ASoC: sta32x: make power restoration transactional
      ASoC: nau8822: keep regcache offline while supplies are off
      usb: musb: da8xx: depopulate OF children on remove
      usb: musb: da8xx: depopulate OF children on probe failure
      clk: s2mps11: Propagate OF provider registration failures
      ASoC: rt1015: make control calibration failures observable
      clk: si521xx: correct the SI52147 OF output enable map
      clk: milbeaut: Return divider update timeouts
      pmdomain: imx: Propagate SCU provider registration failures
      hwrng: starfive - propagate clock and reset errors
      crypto: starfive - propagate clock and reset errors
      ASoC: adau17x1: return cache sync errors from resume
      ASoC: ak4642: return cache sync errors from resume
      ASoC: es8316: return cache sync errors from resume
      ASoC: es8323: return cache sync errors from resume
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
      thermal/drivers/rzg3e: Propagate reset assertion failure from suspend
      irqchip/riscv-imsic: Reject overlapping group index fields

Peter Morrow (1):
      net/mlx4: always create the eth and ib auxiliary devices

Peter Robinson (1):
      arm64: dts: broadcom: bcm2712: adjust display status

Peter Zijlstra (2):
      sched: Re-arrange the {EN,DE}QUEUE flags
      sched: Fold sched_class::switch{ing,ed}_{to,from}() into the change pattern

Peter Zijlstra (Intel) (1):
      x86/asm: Introduce inline memcpy and memset

Petr Vorel (1):
      checkpatch: skip CamelCase cache for --no-tree without root

Phil Sutter (2):
      netfilter: nfnetlink_hook: Dump nat type chains
      netfilter: nfnetlink: Fix for interrupted hook dumps

Piotr Gliźniewicz (1):
      ALSA: 6fire: take stream_mutex in the Digital Thru control

Piotr Kubik (2):
      net: pse-pd: si3474: keep detection enabled on the other PIs
      net: pse-pd: si3474: validate the channels of a PI

Prashant Sengar (1):
      net: usb: lan78xx: avoid NULL PHY dereference in WoL setup

Prathamesh Deshpande (2):
      RDMA/mlx5: Cancel deferred page-fault EQ work before teardown
      RDMA/mlx5: Cancel software CQ notifications before teardown

Prike Liang (1):
      drm/amdgpu/userq: wait for GPU reset before mapping or unmapping queues

Priyank Rathod (1):
      PCI/AER: Fix struct pci_dev reference leak in aer_process_err_devices()

Priyanka Mani (1):
      ASoC: mediatek: mt8365: Fix out-of-bounds read in get_iir_coef()

Przemek Kitszel (1):
      ice: skip stats handling for channel VSIs on rebuild

Pu Lehui (1):
      bpf: Adjust bpf_func to account for CFI offset in bpf_jit_free on riscv

Qiliang Yuan (11):
      selftests/bpf: Use its own netns in flow_dissector_skb_less_direct_attach
      selftests/bpf: Report a failure to register the session key in test_progs
      selftests/bpf: Expect at least one tp_recursion miss in missed
      selftests/bpf: Create the vxlan devices of test_tunnel with their MAC
      selftests/bpf: Accept unnamed dma-bufs in the dmabuf_iter default test
      selftests/bpf: Keep the bpffs of cgroup_hierarchical_stats private
      selftests/bpf: Unmount the bpffs that cgroup_hierarchical_stats mounted
      selftests/bpf: Record only the test ICMP echo in tc8 of tc_netkit_scrub
      selftests/bpf: Expect at least one kprobe miss in missed/perf_kprobe
      blk-mq: share one tags_srcu instance across all tag sets
      selftests/bpf: Run the cpumask map insert tests only for the test task

Qing Zhang (1):
      nvmet: protect nvmet_ports_list with nvmet_config_sem

Qingfang Deng (5):
      mtd: block: prevent reclaim I/O during request processing
      ARM: mvebu: fix Cortex-A9 errata selection for Armada 38x
      ksmbd: server: avoid busy polling in accept loop
      pppoe: drop discovery frames with no MAC header
      pppoe: wait for RCU readers before reusing a socket

Qingshuang Fu (1):
      selftests/timers: clocksource-switch: Fix unchecked open()/read()

Qiuxu Zhuo (1):
      EDAC/i10nm: Fix Granite Rapids ADXL MC mapping

Qu Wenruo (7):
      btrfs: raid56: do not verify the content if there is no data checksum
      btrfs: add extra device item checks at mount
      btrfs: introduce the device layout aware per-profile available space
      btrfs: update per-profile available estimation
      btrfs: refactor read_key_bytes() to remove the dest_folio parameter
      btrfs: qgroup: do not treat "ret > 0" as error when deleting a qgroup
      btrfs: do not reject a valid running dev-replace

Quanye Yang (3):
      RDMA/rtrs-clt: Reject invalid queue_depth from the peer
      RDMA/rtrs-clt: Don't WARN on unexpected info-response opcode
      RDMA/rtrs-clt: Validate peer-supplied IO completion msg_id

Rafael J. Wysocki (13):
      ACPI: button: Enable wakeup GPEs for ACPI buttons at probe time
      ACPI: PM: Drop parent state update from acpi_device_get_power()
      ACPI: PCI: Introduce acpi_dev_get_pci_dev()
      ACPI: scan: Stop calling acpi_bus_init_power() early
      ACPI: glue: Reduce debug noise from acpi_device_notify()
      ACPI: glue: Rework the success message in acpi_device_notify()
      ACPI: utils: Adjust message printing macros for ACPI objects
      ACPI: glue: Carry out companion lookup under bus_type_sem
      ACPI: glue: Fix up and adjust acpi_unbind_one()
      ACPI: fan: Fix memory leak due to leftover devm_kcalloc() argument
      ACPI: video: Fix backlight unregistration ordering
      ASoC: amd: acp-es8336: Switch to use acpi_bus_get_primary_device()
      ASoC: amd: acp3x-es83xx: Switch to use acpi_bus_get_primary_device()

Rand Deeb (1):
      ata: libata-core: Ignore forced transfer modes the host does not support

Ranjan Kumar (1):
      scsi: mpi3mr: Rename log data save helper to reflect threaded/BH context

Raveendra Talabattula (1):
      drm/komeda: Fix bits parsing of GLB_CORE_ID

Ravi Hothi (3):
      ASoC: qcom: audioreach: fix module cfg blob size handling
      ASoC: codecs: wsa884x: Fix VI sense port channel count
      ASoC: codecs: wsa883x: Fix VI sense port channel count

Ren Tamura (1):
      tools/cgroup: sum shrinker object counts across NUMA nodes

Ricardo Neri (1):
      hwmon: (coretemp) Read TjMax only when refreshing the temperature

Richard Cheng (2):
      cxl/features: Reject feature offset that overflows 16-bit field
      cxl/fwctl: Propagate feature RPC delivery errors

Richard Zhu (1):
      arm64: dts: imx95: Avoid 32-bit PCIe window System RAM overlap

Rik van Riel (1):
      mm/memcontrol: fix stuck FLUSHING_CACHED_CHARGE bit on isolated cpus

Rishikesh Jethwani (1):
      tls: device: protect async RX resync state during device-down

Rob Barnes (1):
      platform/chrome: cros_ec_proto: Fix deferred response

Rob Herring (Arm) (3):
      arm64: dts: broadcom: bcm2712: Move non simple-bus nodes to root level
      dt-bindings: arm: mediatek: Fix MT6779 audsys compatible
      dt-bindings: clock: mediatek: Add MT8516 fallbacks

Robert Oscilowski (1):
      ASoC: qcom: sdm845: set quaternary MI2S codec DAI to I2S format

Roberto Bergantinos Corpas (2):
      NFS: return DENIED in decode_lock_denied if we cannot decode owner
      nfs: set gencount on protocol-specific remove

Roland Dreier (3):
      firmware: arm_scmi: Protect xfer->async_done with xfer->lock
      firmware: arm_scmi: Don't reuse raw xfers with async_done still armed
      firmware: arm_scmi: Fix error path leak in scmi_raw_message_send()

Roman Demidov (2):
      drm/msm/a6xx: fix use-after-free of OPP in a6xx_pm_resume
      drm/msm/a6xx: check pm_runtime_resume_and_get during resume

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

Runyu Xiao (5):
      remoteproc: xlnx: Initialize mailbox work before requesting channels
      ALSA: oxygen: use helper to activate the SPDIF PCM control
      ALSA: via82xx: use helper to activate DXS controls
      mei: vsc-tp: initialize IRQ state before requesting interrupt
      ASoC: codecs: wcd937x: request watchdog IRQs without devm

Ruoyu Wang (7):
      pwm: renesas-tpu: Fix runtime PM reference leak
      hwrng: cctrng - Fix runtime PM usage counter leak
      dmaengine: img-mdc: Fix runtime PM usage counter leak
      media: venus: Drop session events without an instance
      misc: nsm: fix CBOR short-length decoding
      perf/dwc_pcie: Fix PCI device reference leak in probe
      xen/pcifront: Fix PCI device reference leak in AER handling

Ryan Brue (2):
      power: supply: bq24190_charger: use the wake irq API
      power: supply: bq24190_charger: don't reset registers across system suspend

Ryan Leung (4):
      wifi: mt76: mt7915: publish wcid before MCU add commands
      wifi: mt76: fix unlocked wcid check in mt76_tx_status_skb_add()
      wifi: mt76: fix wcid teardown ordering in mt76_reset_device()
      wifi: mt76: fix wcid->pktid corruption in mt76_wcid_cleanup()

Ryusuke Konishi (1):
      nilfs2: fix link count underflow when removing corrupted directory

Sachin Kumar Garg (1):
      media: iris: cache work mode after computing it in iris_set_stage

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

Sang-Heon Jeon (1):
      memblock: reject non-page-aligned reserve_mem regions

Sang-Hoon Choi (2):
      md/raid5: protect big_stripe_tree lookup with RCU
      xhci: dbc: lock the minor IDR on registration failure

Sanghyun Park (1):
      bpf: Fix program BTF use-after-free in sleepable programs

Sarthak Sharma (2):
      mm/gup_test: safely calculate GUP batch size
      mm/gup_test: report actual pinned bytes

Sasha Levin (8):
      kbuild: keep .modinfo when vmlinux is linked with --gc-sections
      tools: hv: remove unused rte_smp_mb()
      selftests/nolibc: use the configured kernel header directory
      kselftest/arm64: signal: copy each test binary only once
      selftests: keep the build status from wrapping to success
      ARC: Strip libgcc debug information when generating BTF
      selftests/proc: proc-pid-vm: fix unused variable warning on non-x86
      selftests/thermal: allow cross builds of the Intel tests

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

Sechang Lim (1):
      sched: Set TIF_NEED_RESCHED before calling __trace_set_need_resched()

Selvin Xavier (6):
      RDMA/bnxt_re: Fix integer overflow in send payload size computation
      RDMA/bnxt_re: Detect wrong sge_len passed for inline
      RDMA/bnxt_re: Validate SRQ max_sge at create time
      RDMA/bnxt_re: Initialize wqe.flags in bnxt_re_post_srq_recv()
      RDMA/bnxt_re: Fix the PD and DPI table size
      RDMA/bnxt_re: Use bnxt_ext_stats_supported for counter count selection

Serhat Kumral (5):
      RDMA/irdma: Free IRQ when CEQ vector mapping fails
      RDMA/siw: Fix length of first chunk in siw_try_1seg()
      IB/rdmavt: Fix error unwind path for qp_priv_init() in rvt_create_qp()
      RDMA/srp: Avoid reading uninitialized has_port on srp_parse_in() failure
      RDMA/usnic: Bound buffer size to sizeof(buf) in flowinfo_read()

Shaikh Kamaluddin (1):
      cxl/mce: Avoid alias page retirement for corrected errors

Shakeel Butt (5):
      kernfs: fix up the unlocked attribute reads on the creation paths
      kernfs: don't hold kernfs_rwsem across notification delivery
      kernfs: don't repeat or skip an entry when readdir resumes
      kernfs: don't hold kernfs_rwsem across dir_emit()
      kernfs: avoid READ_ONCE() on a kgid_t in kernfs_new_node()

Shashank Mohan Jain (3):
      bitmap: bitmap_parse(): reject non-hex character before 8 digits
      bitmap: bitmap_parselist(): reject trailing characters after group size
      bitmap: bitmap_parselist(): don't wrap around on a huge group size

Shawn Lin (1):
      phy: rockchip: naneng-combphy: Fix TX detect RX termination errata

Shayne Chen (1):
      wifi: mt76: mt7996: extend CSA and CCA support for MLO

Shenghao Ding (1):
      ASoC: tas2781: Fix TAS2781/TAS5825 PPC version logic conflict

Shengjiu Wang (1):
      ASoC: fsl_asrc: use regmap_write_bits to update clock source registers

Shradha Gupta (2):
      kexec: Add helper to report an active kexec reboot
      Drivers: hv: Run VMBus kexec cleanup from syscore shutdown

Shrikanth Hegde (1):
      powerpc/ftrace: Don't restore r13 during ftrace_regs_caller

Shuangfeng He (1):
      netfilter: flowtable: use the vlan id, not the full tci, in the tuple key

Shujath Mohd (1):
      arm64: dts: qcom: sdm845-sony-xperia-tama: Fix Bluetooth UART pinctrl

Shuming Fan (1):
      ASoC: rt712: avoid duplicate reset in io_init

Shuvam Pandey (1):
      seq_buf: Export seq_buf_putmem_hex() and add KUnit tests

Shyam Sundar S K (1):
      platform/x86/amd/pmc: clear devm-managed pointers on remove to prevent stale reuse

Sicong Huang (1):
      nfp: flower: fix use-after-free in neighbour update work

Sidong Yang (1):
      accel/rocket: Don't tear down the scheduler when drm_sched_init() fails

Sivansh Gupta (1):
      mailbox: qcom-cpucp: read mbox hardware register using readq()

Slavin Liu (7):
      ACPI: tables: handle failed initrd override mappings
      crypto: atmel-sha - reject initialization without a device
      clk: starfive: jh7110: reject oscillator lookup errors
      RDMA/irdma: check vport device allocation
      ASoC: fsl_asrc: check the second front-end DMA channel
      clocksource/drivers/dbx500-prcmu: Check timer register mapping
      wifi: mt76: mt7996: guard station-only MLO TX handling

Srinivas Kandagatla (3):
      clk: qcom: fix SM6115 lpasscc register offset
      ASoC: codecs: wsa884x: disable runtime PM on unbind
      ASoC: codecs: wsa883x: disable runtime PM on unbind

Srinivas Neeli (2):
      dmaengine: xilinx_dma: Fix MCDMA descriptor fields based on DMA direction
      dmaengine: xilinx_dma: Move descriptors to done list based on completion bit

Stanislav Fomichev (3):
      net: add address list snapshot and reconciliation infrastructure
      net: introduce ndo_set_rx_mode_async and netdev_rx_mode_work
      fbnic: convert to ndo_set_rx_mode_async

Stefano Munari (1):
      net: usb: lan78xx: reject invalid EEPROM write requests

Steven Rostedt (1):
      cpuidle: haltpoll: Only define guest_halt_poll_ns tracepoint when used

Sudeep Holla (2):
      ACPICA: Fix PCC OperationRegion command offsets
      ACPI: PCC: Preserve shared memory signature in OpRegion handler

Sumeet Pawnikar (1):
      thermal: gov_power_allocator: Fix NULL pointer dereference in update_tz()

Sun Jian (1):
      selftests/bpf: cover short IPv4/IPv6 inputs with adjust_room

Sung Byeongchan (2):
      nvmet-auth: reject undersized AUTH_SEND payloads
      netfilter: xt_dccp: handle reserved options as single-byte

Sunil Khatri (1):
      drm/amdgpu/userq: use drm_exec in amdgpu_userq_fence_read_wptr

Sunny Luo (1):
      spi: amlogic: spisg: Fix the incorrect keep_ss of the last descriptor

Sunny Tiwari (1):
      RDMA/irdma: Bound in-flight CQP ops across deferred completions

Surabhi Gogte (1):
      nvme-tcp: store and use the caller's network namespace

Szymon Wilczek (1):
      fs/ntfs3: fix deadlock in ni_read_folio_cmpr

TJ Adams (1):
      block: advance iterator after copy-in for SG_DXFER_TO_FROM_DEV

Takahiro Kuwano (1):
      mtd: spi-nor: spansion: Remove s25fs256s0

Takashi Iwai (36):
      ALSA: pcm: Optimize cpu_latency_qos_*() calls
      ALSA: pcm: Prevent O_APPEND open on OSS streams
      ALSA: ump: Avoid dereference with max_src_size=0
      ALSA: caiaq: Allow zero-length packet handling for EP1
      ALSA: hda: Fix potential UAF for gating jack
      ALSA: usb-audio: Check mixer matrix size for UAC2/3 at parsing
      ALSA: usb-audio: Fix invalid UAC2/3 mixer unit matrix evaluation
      ALSA: pcmtest: Fix a bogus pointer read in snd_pcmtst_pcm_pointer()
      ALSA: core: Add missing barriers for power_ref vs card->shutdown
      ALSA: seq: Fix missing direction and ump_group handling in 32bit compat ioctl
      ALSA: info: Fix memory leak at card removal
      ALSA: hda: Use linked list for jack table
      ALSA: hda: Avoid non-operational GPU warning at regular device removal
      ALSA: hda/intel: Move firmware loading into the probe work
      ALSA: hda: Don't free card at probe error in vga_switcheroo handler
      ALSA: caiaq: Fix races at MIDI URB and trigger accesses
      ALSA: usb-audio: Fix data race at mixer_ctl_feature_info()
      ALSA: usb: us16x08: Fix racy accesses of mixer elements
      ALSA: line6: Reject too small max packet sizes
      ALSA: line6: Fix potential OOB write in line6_capture_copy()
      ASoC: fsl_asrc_m2m: Fix bogus compress task pointer assignments
      ALSA: hda: intel: Cancel delayed work at shutdown, too
      ALSA: hda: Stop unsol events and jack polling before codec unbind
      ALSA: hda: Disable unsol event handling at error and shutdown paths
      ALSA: hda: Stop unsol event and jack polling at hda-ext device removal, too
      ALSA: hda: Add NULL check for the driver pointer at unsol event work
      ALSA: control: Relax __free() variable declarations
      ALSA: jack: Fix kctl free at error in snd_jack_kctl_new()
      ALSA: pcm: Protect delay DMA sync in forward and rewind, too
      ALSA: line6: Use kzalloc() for PCM buffer allocation
      ALSA: usb-audio: Use fixed control index for us16x08 mixer elements
      ALSA: Add simple refcount helper functions
      ALSA: pcm: Add refcount for races between drain and unlink
      ALSA: core: Serialize snd_refcount put and sync
      ALSA: aloop: Use the new helper for stop-count refcount
      platform/x86: ibm_rtl: Fix potential OOB read at signature search

Takashi Sakamoto (1):
      firewire: core: remove unused link field in fw_packet structure

Tal Zussman (11):
      block: use iomap_dirty_folio for block devices
      block: take i_rwsem for the direct I/O write fallback
      block: take i_rwsem for the splice read path
      block: honor IOCB_NOWAIT in the block device buffered read path
      block: don't fall back to buffered I/O for atomic writes
      btrfs: drop the extent maps of the written part of a failed ordered extent
      btrfs: update the inode item when removing a free space inode
      ceph: fix error handling when the OSD client is stopping in ceph_submit_write()
      ceph: wait for pending fscache write in write_folio_nounlock()
      ceph: fix writeback_count leak when a bounce page allocation fails
      ceph: don't clear write_congested when collecting folios

Taniya Das (3):
      dt-bindings: clock: qcom,milos-camcc: Add missing power-domains support
      dt-bindings: clock: qcom,milos-videocc: Add missing power-domains support
      clk: qcom: rpmh: Update the clock suffix for Glymur

Tao Cui (3):
      sched_ext/scx_flatcg: Make cgv_node_less() wraparound-safe
      blk-iocost: charge zone appends as writes
      blk-iocost: account zone append completions in latency stats

Tao Gong (1):
      net: dsa: mt7530: trap frames to conduit in MFC on EN7581 and AN7583

Tapio Reijonen (11):
      serial: max310x: schedule tx_work directly from the IRQ handler
      gpio: pcf857x: implement get_direction()
      serial: max310x: don't clobber the TX break bit in set_termios
      serial: max310x: fix breaks not reaching the wire in RS485 mode
      serial: max310x: centralize the RS485 transceiver programming
      serial: max310x: fix RS485 delays being programmed as bit-times
      serial: max310x: don't power down the port mid-transmission on close
      serial: max310x: register GPIO controller before adding UART ports
      serial: max310x: support active-low RTS on the hardware path
      serial: max310x: drive RTS in software when hardware delays are too short
      serial: max310x: don't transmit while an RS485 reconfigure is pending

Tejun Heo (1):
      bpf: sched_ext: Mark ops argument container pointer fields as trusted

Tengda Wu (1):
      perf llvm: Fix memory leak of args->fileloc in symbol__disassemble_llvm()

Theodor Arsenij Larionov Trichkine (1):
      net: use the full socket in sk_mc_loop()

Thomas Falcon (1):
      perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()

Thomas Fourier (1):
      net: alacritech: fix dma_free_coherent() in error path

Thomas Weißschuh (5):
      microblaze: uaccess: Zero out destination on failed get_user()
      microblaze: Pass -m{big,little}-endian through KBUILD_CPPFLAGS
      selftests/nolibc: scope custom flags to the nolibc-test target
      nios2: ksyms: Declare __mulsi3 export
      vdso/gettimeofday: Correct the read of tz_minuteswest and tz_dsttime

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

Tony Luck (1):
      fs/resctrl: Ensure default group reports tasks on monitor-only systems

Triet Hoang (1):
      clk: raspberrypi: Handle cpufreq device registration failure

Troy Mitchell (1):
      dt-bindings: vendor-prefixes: Add Sensylink

Tung Nguyen (1):
      tipc: fix refcount panic in tipc_rcv() when receiving shared skb

Uwe Kleine-König (The Capable Hub) (4):
      ASoC: codecs: ab8500: Remove suspicious code
      serial: txx9: Drop noop probe function and dangerous remove callback
      serial: 8250: Fix corner case for port matching
      serial: 8250: hub6: Add cleanup code

Vasilij Markin (1):
      drm/appletbdrm: Add suspend and resume support

Vasily Gorbik (1):
      sched/core: Don't steal a proxy-exec donor

Vijendar Mukunda (2):
      ASoC: SOF: amd: fix amd_sof_acp_remove() teardown ordering
      ASoC: SOF: amd: fix amd_sof_acp_probe() error unwind ordering

Viken Dadhaniya (1):
      arm64: dts: qcom: hamoa-iot-evk: add MCP2518FD CAN on spi18

Viktor Menshin (1):
      ALSA: hda/realtek: Fix hiss/crackle on Lenovo Xiaoxin 14 GT (17aa:3912)

Vincent Jardin (4):
      dt-bindings: vendor-prefixes: add Free Mobile
      dpaa2-ptp: fix support for PTP_EXTTS_REQUEST2 ioctl
      net: enetc: fix support for PTP_EXTTS_REQUEST2 ioctl
      ptp: qoriq: fix support for PTP_EXTTS_REQUEST2 ioctl

Vincent Mailhol (2):
      can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices
      efi/libstub: make local GUID variables static

Vinod Koul (1):
      dmaengine: zynqmp_dma: drop redundant label

Waiman Long (2):
      cgroup/cpuset: Run SCHED_DEADLINE shrink test on valid partition root only
      cgroup/cpuset: Make sure compute_partition_effective_cpumask() is only called for valid partition

Waldemar Brodkorb (1):
      sh: Select BINFMT_FLAT_NO_DATA_START_OFFSET for !MMU

WanLi Niu (1):
      bpftool: Make skeleton C++ compatible with explicit casts

WangYuli (1):
      MIPS: Only check -msym32 when need-compiler

Wei Huang (1):
      PCI/TPH: Validate the firmware Steering Tag response

Weidong Wang (1):
      ASoC: codecs: Modify awinic amplifier dsp read and write functions

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

Wentao Liang (9):
      clk: versatile: clk-icst: Fix node reference leak in of_syscon_icst_setup()
      RDMA/cxgb4: Fix neigh reference leak in rx_pkt()
      RDMA/cxgb4: Fix skb reference leak in rx_pkt()
      RDMA/mlx5: Fix RQ resource reference leak in mlx5_ib_wq_event()
      RDMA/siw: Fix qp use-after-free in siw_get_base_qp()
      pinctrl: nuvoton: Fix clock reference leak in ma35_get_bank_data()
      pinctrl: stm32: Fix clock reference leak in stm32_pctl_probe()
      clocksource/drivers/timer-econet-en751221: Fix clock reference leak
      apparmor: Fix namespace reference leak in __aa_find_or_create_ns()

Will Deacon (1):
      tools: linux/types.h: Add 128-bit integer types for arm64 UAPI structures

Willem de Bruijn (2):
      selftests: net: csum: filter packets by source address and port
      virtio-net: fix frag overflow in big packets receive

William Palacek (1):
      drm/amdkfd: Validate the control stack of a restored queue

Willy Tarreau (1):
      tools/nolibc: provide the portable sys/select.h

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

Xianwei Zhao (1):
      spi: amlogic: spisg: Fix transfer size limit and timeout handling

Xiao Liang (1):
      tun: drop batched packets while the device is down

Xilin Wu (1):
      drm/msm/dp: Initialize the debugfs connector pointer

Xin Liu (1):
      arm64: dts: qcom: hamoa-iot-evk: use on-board crystal for PS8830 retimers

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

Xu Rao (1):
      ALSA: usb-audio: qcom: Free QMI handle

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

Yeoreum Yun (1):
      coresight: etm3x: Prohibit modifying cntr_val while session is enabled

Yibo Tan (4):
      sysctl: unregister tables before freeing bitmap
      ASoC: amd: acp-es8336: Use an owned codec device reference
      ASoC: amd: acp3x-es83xx: Keep an owned codec device reference
      soc: qcom: pmic_pdcharger_ulog: prevent work requeue during remove

Yichong Chen (2):
      soundwire: debugfs: replace writable string helper
      debugfs: make debugfs_create_str() read-only

Yili Zhang (1):
      RDMA/nldev: Fix NULL deref in dumps of objects abandoned by DRIVER_FAILURE

Yilin Chen (1):
      rust: configfs: require thread-safe callback data

Yishai Hadas (6):
      RDMA/hns: Pin CQ buffer writable to match device DMA write access
      RDMA/mlx5: Fix mlx5_ib_dev_res_init() failure when XRC cap is absent
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

Yongxing Mou (1):
      arm64: dts: qcom: hamoa-iot-evk: Add backlight support for eDP panel

Yongzhao Chen (2):
      net: phy: qcom: at803x: Apply IPQ5018 analog settings at probe
      net: phy: qca83xx: read resolved QCA8337 link status

YouYou Yu (1):
      quota: initialize dquot cache before mounting rootfs

Youngsung Ahn (5):
      RDMA/rxe: refuse to destroy a QP with type 2 MWs still bound
      RDMA/rxe: reject IB_WR_REG_MR from user QPs in rxe_reg_fast_mr()
      RDMA/rxe: bound the ODP page index against the umem in rxe_check_pagefault()
      RDMA/rxe: validate inline sge_offset in finish_packet() before indexing inline_data[]
      RDMA/rxe: bound the WQE opcode before indexing rxe_wr_opcode_info[]

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

Yun Lu (3):
      selftests/bpf: Clean up child when task_work__open() fails
      bpf: Fix NULL task dereference in task work cancellation
      bpf: Prevent task work context reuse while irq_work is busy

Yuqiang Sun (1):
      ALSA: usb-audio: qcom: Check the return value of qmi_handle_init()

Yuri Zaporozhets (1):
      ASoC: dwc: Use OF match data again for StarFive JH7110

Yuya Kusakabe (1):
      seg6: fix HMAC validation when an extension header precedes the SRH

Ze Huang (1):
      drm/imx/lcdc: avoid duplicate clk_per enable

Zenghui Yu (Huawei) (1):
      selftests/damon: stop kdamond on error exits of no-op commit test

Zhan Xusheng (3):
      fs/ntfs3: fix valid_size not being updated in attr_allocate_frame()
      vdso/math64: Add and use __iter_div64_u64_rem()
      vdso/vsyscall: Keep the CLOCK_AUX base scaled

Zhang Yi (4):
      ASoC: codecs: ES8389: Modify volatile_register
      ext4: fix orig_mlen initialization in ext4_map_blocks()
      ASoC: codecs: es*: Modify the registers related to ALC RECOVERY
      ASoC: codecs: es*: Modify the maximum value of DMIC_GAIN

Zhang Yubing (1):
      phy: rockchip: usbdp: Support single-lane DP

ZhaoJinming (1):
      iommu/vt-d: Fix copied_tables bitmap leak on error in copy_translation_tables

Zhenxian Ma (3):
      block: skip redundant flush for O_DSYNC direct writes
      block: only use REQ_FUA for direct writes if the device supports it
      block: fix recursive i_rwsem locking in blkdev_write_iter()

Zhewei Yuan (1):
      tcp: Fix fastreuse cache initialization on first bind

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

Zide Chen (1):
      perf topdown: Don't require config1==0 for a slots event

Zijun Hu (1):
      Bluetooth: btusb: Make btusb_recv_{event,acl}() take struct hci_dev *

Zizhi Wo (2):
      md/raid10: fix missing wakeup in wait_barrier_nolock
      md/raid5: reject a per-device size smaller than one chunk

Zongmin Zhou (1):
      serial: sifive: fix off-by-one in console port bounds check

alex todadze (1):
      net: stmmac: fix rx checksum offload with extended descriptors

bui duc phuc (69):
      ASoC: mediatek: mt8186: Fix APLL mux setting error handling
      ASoC: mediatek: mt8186: Fix clock handling in mux disable path
      ASoC: mediatek: mt8186: Fix AFE clock error handling
      ASoC: mediatek: mt8186: Fix APLL enable error handling
      ASoC: mediatek: mt8186: Fix MCK error handling
      ASoC: mediatek: mt6797: fix wrong unwind order and error code in enable_clock
      ASoC: codecs: ab8500: Use guard() for mutex locks
      ASoC: mediatek: mt8188: mt8188-afe-clk: Handle tuner clock enable errors
      ASoC: mediatek: mt8188: mt8188-afe-clk: Propagate regmap update errors
      ASoC: mediatek: mt8188: mt8188-afe-clk: Handle clock enable errors
      ASoC: mediatek: mt8188: mt8188-afe-pcm: Handle runtime resume errors
      ASoC: fsl_asrc_m2m: fix pm_runtime usage counter leak on error
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
      ASoC: rockchip: rockchip_sai: Handle runtime PM resume failures in set_fmt
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
      ASoC: renesas: msiof: Fix msiof_close() being skipped on rollback
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

zhoumin (1):
      ata: ahci: preserve preset port masks

Ömer Mete Kaya (2):
      usbnet: fix smp_processor_id() use in preemptible context
      usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()

Ștefan Ghețu (1):
      ASoC: SOF: imx: Prevent stack OOB read in DSP panic dump

