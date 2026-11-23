Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420864;
	b=fcVghI3wrMZFt2IuYBd2SJKis5U6/jNzMP43Bopusj2BbWsiJFi6HONxyQ6S1E9JxBRB
	 k21296AtYrbRg/ZaDVFu1RT4GfpGIBFu3w32AXBGJs/UpPWIjXrZebKR34iuKyCoYSqp5
	 y6UumXuNn+Z2J2BobjjMxfUlLnJoKr33EKnQh7kQ0wUCykGyM50x8PURwgLG8xdcq0esY
	 I+fq/HQx89/ElPAGh+Ro0V62aS97KvxNhrH5Gfh3Ga67BVEDYhhNggw/f9+52VlAQUy7h
	 wn8b7JtbCI0FNihttvQsAesTIXRU+RaZ0Jeu6NE5e5GTM1SI2cM4QEGQoCjbolAFB3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420864;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VjCLXLK4F/9M2tZSZyJpYRLdce48+QbVMvfFdw8Ymyk=;
	b=ua6623f7EvQQTbXntnI8SfyHi0LKpS2MiVdv7EiSrv2Yo1XFu+z3I61X+y+B8wa2ghhG
	 E0HttBLuBXFB6cfIxTb7sNJ/Gnm5BszR10TVLHWoodzXFD6aadLkDdMNf9WFZj+QbG3g2
	 O0+KdBjcuqIoLFw4ToO5FU3idVt9iZ+lDycSp9L/W4GvWWuSG6wWhJI//f8R3DoqiUnnW
	 2G3/YNse07fA6q1vZoj0O7wS+V/5zKXjwrE/TPa7vPT/jEhQhiRafmbh8i0th/nTPoFtm
	 nw57MLZv7Vq+gpmk2VsWotFUuwybHexmlgph3/YSEwZ8XabLvtwoWLyPkcWnPTmH1gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=I8T7VQqe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5DD60A5BC8;
	Mon, 23 Nov 2026 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=I8T7VQqe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA3F1F000CF;
	Mon, 23 Nov 2026 08:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795420864;
	bh=VjCLXLK4F/9M2tZSZyJpYRLdce48+QbVMvfFdw8Ymyk=;
	h=From:To:Cc:Subject:Date;
	b=I8T7VQqej080jA5fahQ/5Mw99i/7tVDS5aB8gFMM20SnadzNnSVi8MgyFrZ06nciS
	 Eo7y0bBEq5xsapZAO2VgSAzTJbBug7HivdN0APcNRUlPiProhSQCieVwTzVCTCDStn
	 3VzW22krbF1L5s9Jicuy/SPW0gsiMXB/HhId8/P4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.3.6
Date: Mon, 23 Nov 2026 09:00:09 +0100
Message-ID: <2026112310-virus-ecology-b943@gregkh>
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

I'm announcing the release of the 7.3.6 kernel.

All users of the 7.3 kernel series must upgrade.

The updated 7.3.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.3.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 .gitignore                                                                             |    1 
 Documentation/ABI/stable/sysfs-class-infiniband                                        |  118 
 Documentation/ABI/testing/sysfs-bus-pci                                                |   14 
 Documentation/ABI/testing/sysfs-class-led                                              |    4 
 Documentation/ABI/testing/sysfs-class-power-mp2629                                     |    2 
 Documentation/admin-guide/LSM/LoadPin.rst                                              |   10 
 Documentation/admin-guide/LSM/ipe.rst                                                  |    4 
 Documentation/admin-guide/cgroup-v2.rst                                                |    4 
 Documentation/admin-guide/kernel-parameters.txt                                        |   10 
 Documentation/admin-guide/pm/amd-pstate.rst                                            |    6 
 Documentation/bpf/bpf_iterators.rst                                                    |   10 
 Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.yaml                    |    2 
 Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml                       |    2 
 Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml                         |    2 
 Documentation/devicetree/bindings/clock/qcom,milos-camcc.yaml                          |   19 
 Documentation/devicetree/bindings/clock/qcom,milos-videocc.yaml                        |   19 
 Documentation/devicetree/bindings/clock/qcom,sm8750-gcc.yaml                           |    7 
 Documentation/devicetree/bindings/display/msm/gmu.yaml                                 |    2 
 Documentation/devicetree/bindings/display/msm/hdmi.yaml                                |    4 
 Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml     |    2 
 Documentation/devicetree/bindings/dma/stericsson,dma40.yaml                            |   14 
 Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml                   |   10 
 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml                         |    3 
 Documentation/devicetree/bindings/interrupt-controller/chrp,open-pic.yaml              |    7 
 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-mswi.yaml     |    1 
 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml     |    5 
 Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml          |   21 
 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml                             |    9 
 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml                            |    1 
 Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml          |   76 
 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml                         |   29 
 Documentation/devicetree/bindings/timer/sifive,clint.yaml                              |    1 
 Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml                  |    1 
 Documentation/devicetree/bindings/vendor-prefixes.yaml                                 |   20 
 Documentation/filesystems/erofs.rst                                                    |    7 
 Documentation/filesystems/f2fs.rst                                                     |    3 
 Documentation/filesystems/resctrl.rst                                                  |    2 
 Documentation/leds/leds-st1202.rst                                                     |    5 
 Documentation/mm/process_addrs.rst                                                     |   14 
 Documentation/netlink/specs/devlink.yaml                                               |   64 
 Documentation/networking/psp.rst                                                       |    8 
 Documentation/networking/tls-offload.rst                                               |   16 
 Documentation/rust/testing.rst                                                         |    2 
 Documentation/trace/histogram.rst                                                      |    3 
 Documentation/translations/zh_CN/rust/testing.rst                                      |    2 
 Documentation/virt/hyperv/overview.rst                                                 |   12 
 Makefile                                                                               |    3 
 arch/alpha/Kconfig                                                                     |    1 
 arch/alpha/include/asm/ptrace.h                                                        |    7 
 arch/alpha/kernel/ptrace.c                                                             |   12 
 arch/alpha/mm/fault.c                                                                  |   29 
 arch/arc/Makefile                                                                      |    9 
 arch/arc/include/asm/cmpxchg.h                                                         |    4 
 arch/arc/lib/Makefile                                                                  |    8 
 arch/arm/boot/dts/gemini/gemini.dtsi                                                   |    2 
 arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi                                 |    2 
 arch/arm/boot/dts/marvell/armada-388-helios4.dts                                       |   23 
 arch/arm/boot/dts/marvell/armada-395-gp.dts                                            |    1 
 arch/arm/boot/dts/nvidia/tegra114-dalmore.dts                                          |    4 
 arch/arm/boot/dts/nvidia/tegra114-roth.dts                                             |    4 
 arch/arm/boot/dts/nvidia/tegra114-tn7.dts                                              |    4 
 arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi                                              |   40 
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi                                               |    3 
 arch/arm/boot/dts/st/ste-ab8500.dtsi                                                   |    6 
 arch/arm/boot/dts/st/ste-ab8505.dtsi                                                   |   23 
 arch/arm/boot/dts/st/ste-dbx5x0.dtsi                                                   |    5 
 arch/arm/boot/dts/st/ste-href-ab8500.dtsi                                              |  104 
 arch/arm/boot/dts/st/ste-href-ab8505.dtsi                                              |  118 
 arch/arm/boot/dts/st/stm32mp135.dtsi                                                   |   42 
 arch/arm/boot/dts/st/stm32mp135f-dk.dts                                                |    1 
 arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi                                    |    2 
 arch/arm/boot/dts/st/stm32mp157c-ev1.dts                                               |    1 
 arch/arm/boot/dts/st/stm32mp157c-lxa-mc1.dts                                           |    2 
 arch/arm/boot/dts/st/stm32mp157f-dk2-scmi.dtsi                                         |    1 
 arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi                                          |    2 
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi                                        |    2 
 arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi                                              |    1 
 arch/arm/include/asm/domain.h                                                          |   17 
 arch/arm/include/asm/memory.h                                                          |    4 
 arch/arm/include/asm/pgtable-2level-hwdef.h                                            |    1 
 arch/arm/include/asm/pgtable-2level.h                                                  |    7 
 arch/arm/include/asm/sparsemem.h                                                       |    4 
 arch/arm/kernel/efi.c                                                                  |   13 
 arch/arm/mach-mvebu/Kconfig                                                            |    4 
 arch/arm/mach-versatile/platsmp-vexpress.c                                             |    4 
 arch/arm/mach-versatile/v2m.c                                                          |    4 
 arch/arm/mm/Kconfig                                                                    |    7 
 arch/arm/mm/alignment.c                                                                |   10 
 arch/arm/mm/dma-mapping.c                                                              |    5 
 arch/arm/mm/ioremap.c                                                                  |   53 
 arch/arm/mm/mmu.c                                                                      |   76 
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi                                           |    4 
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi                                      |    9 
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts                                   |    4 
 arch/arm64/boot/dts/apple/t6030.dtsi                                                   |    2 
 arch/arm64/boot/dts/apple/t6032.dtsi                                                   |    2 
 arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dts                                     |    5 
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi                                 |   35 
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi                                              |   11 
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts                                          |   14 
 arch/arm64/boot/dts/freescale/imx8dxl-sr-som.dtsi                                      |   14 
 arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso                                   |   11 
 arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi                    |    5 
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts                                           |   32 
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts                                          |   20 
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts                                          |    4 
 arch/arm64/boot/dts/freescale/imx93-11x11-evk-common.dtsi                              |    4 
 arch/arm64/boot/dts/freescale/imx93-11x11-frdm-common.dtsi                             |  680 +
 arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts                                     |  679 -
 arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts                                      |    4 
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts                                        |    4 
 arch/arm64/boot/dts/freescale/imx94.dtsi                                               |    2 
 arch/arm64/boot/dts/freescale/imx943.dtsi                                              |    2 
 arch/arm64/boot/dts/freescale/imx95-15x15-frdm.dts                                     |   16 
 arch/arm64/boot/dts/freescale/imx95.dtsi                                               |    4 
 arch/arm64/boot/dts/mediatek/mt6878-pinfunc.h                                          |    2 
 arch/arm64/boot/dts/mediatek/mt6893-pinfunc.h                                          |    2 
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-cn13.dtso                     |    1 
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-cn14.dtso                     |    1 
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-cn15.dtso                     |    1 
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-cn18.dtso                     |    1 
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi                                           |    5 
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                                               |    2 
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi                                         |    5 
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi                                       |    5 
 arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi                                        |    7 
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi                                       |    5 
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi                                        |    5 
 arch/arm64/boot/dts/qcom/agatti.dtsi                                                   |   11 
 arch/arm64/boot/dts/qcom/eliza.dtsi                                                    |    2 
 arch/arm64/boot/dts/qcom/glymur-asus-zenbook-a16-ux3607oa.dts                          |    3 
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi                                               |    3 
 arch/arm64/boot/dts/qcom/glymur.dtsi                                                   |   59 
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts                                             |   16 
 arch/arm64/boot/dts/qcom/kaanapali.dtsi                                                |    2 
 arch/arm64/boot/dts/qcom/lemans-evk-ifp-mezzanine.dtso                                 |   15 
 arch/arm64/boot/dts/qcom/lemans-evk.dts                                                |    3 
 arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi                                       |    8 
 arch/arm64/boot/dts/qcom/milos.dtsi                                                    |   10 
 arch/arm64/boot/dts/qcom/monaco-evk-ifp-mezzanine.dtso                                 |   12 
 arch/arm64/boot/dts/qcom/monaco-evk.dts                                                |    3 
 arch/arm64/boot/dts/qcom/purwa-iot-evk.dts                                             |   27 
 arch/arm64/boot/dts/qcom/purwa.dtsi                                                    |    5 
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-industrial-mezzanine.dtso                     |   24 
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts                                           |   12 
 arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts                          |   12 
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts                                              |    4 
 arch/arm64/boot/dts/qcom/qcs8550-rb5gen2.dts                                           |   12 
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi                                         |   13 
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi                                  |    2 
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts                                      |    4 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                                   |    2 
 arch/arm64/boot/dts/qcom/x1-asus-vivobook-s15.dtsi                                     |    1 
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi                                      |    1 
 arch/arm64/boot/dts/qcom/x1-crd.dtsi                                                   |    1 
 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi                                            |    1 
 arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi                                       |    1 
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                                           |    3 
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi                            |    1 
 arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts                       |    4 
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts                                  |    1 
 arch/arm64/boot/dts/qcom/x1e80100-honor-magicbook-art-14.dts                           |    3 
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts                               |    1 
 arch/arm64/boot/dts/qcom/x1e80100-medion-sprchrgd-14-s1.dts                            |    1 
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                                              |    1 
 arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts                              |    1 
 arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts                                      |   12 
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi                                             |   18 
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi                                             |   18 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                                               |    2 
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts                                        |   32 
 arch/arm64/boot/dts/rockchip/rk3566-base.dtsi                                          |    4 
 arch/arm64/boot/dts/rockchip/rk3568.dtsi                                               |    4 
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi                                          |    1 
 arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts                              |    9 
 arch/arm64/boot/dts/rockchip/rk3576.dtsi                                               |    2 
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi                                          |    2 
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi                                         |    2 
 arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts                                 |    7 
 arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi                                    |   20 
 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-pro.dts                                |   14 
 arch/arm64/boot/dts/st/stm32mp231.dtsi                                                 |    4 
 arch/arm64/boot/dts/st/stm32mp251.dtsi                                                 |    4 
 arch/arm64/boot/dts/ti/k3-am62-verdin-ivy.dtsi                                         |   41 
 arch/arm64/boot/dts/ti/k3-am62-verdin-zinnia.dtsi                                      |   41 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                                             |   41 
 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi                                       |    2 
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                                                |    2 
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts                                               |    2 
 arch/arm64/boot/dts/ti/k3-am62l3-evm.dts                                               |    4 
 arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi                                            |    2 
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                                                |    2 
 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi                                          |    2 
 arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi                                             |    2 
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts                                                |   25 
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi                                |    2 
 arch/arm64/include/asm/rsi_smc.h                                                       |    2 
 arch/arm64/kernel/pi/Makefile                                                          |    1 
 arch/arm64/net/bpf_jit_comp.c                                                          |   32 
 arch/arm64/net/bpf_timed_may_goto.S                                                    |   10 
 arch/hexagon/include/asm/cmpxchg.h                                                     |    6 
 arch/loongarch/net/bpf_jit.c                                                           |    8 
 arch/m68k/apollo/dn_ints.c                                                             |    6 
 arch/m68k/mac/config.c                                                                 |   31 
 arch/microblaze/Makefile                                                               |    6 
 arch/microblaze/include/asm/uaccess.h                                                  |    3 
 arch/microblaze/kernel/cpu/cpuinfo.c                                                   |    1 
 arch/microblaze/kernel/ptrace.c                                                        |    3 
 arch/mips/Makefile                                                                     |   22 
 arch/mips/cavium-octeon/dma-octeon.c                                                   |    2 
 arch/mips/include/asm/dec/reset.h                                                      |    1 
 arch/nios2/kernel/nios2_ksyms.c                                                        |    1 
 arch/openrisc/include/asm/cmpxchg.h                                                    |    2 
 arch/powerpc/include/asm/interrupt.h                                                   |    7 
 arch/powerpc/include/asm/kasan.h                                                       |   15 
 arch/powerpc/include/asm/string.h                                                      |   21 
 arch/powerpc/kernel/cputable.c                                                         |   14 
 arch/powerpc/kernel/prom_init.c                                                        |   10 
 arch/powerpc/kernel/prom_init_check.sh                                                 |   15 
 arch/powerpc/kernel/trace/ftrace_entry.S                                               |    6 
 arch/powerpc/lib/copy_32.S                                                             |   10 
 arch/powerpc/lib/mem_64.S                                                              |    7 
 arch/powerpc/lib/memcpy_64.S                                                           |    4 
 arch/powerpc/net/bpf_jit.h                                                             |    6 
 arch/powerpc/net/bpf_jit_comp.c                                                        |   46 
 arch/powerpc/net/bpf_jit_comp64.c                                                      |    8 
 arch/riscv/boot/dts/sophgo/cv180x.dtsi                                                 |    2 
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts                                       |    2 
 arch/riscv/boot/dts/spacemit/k3-com260.dtsi                                            |    1 
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts                                           |    2 
 arch/riscv/boot/dts/spacemit/k3.dtsi                                                   |   48 
 arch/riscv/boot/dts/starfive/jh7100-common.dtsi                                        |   28 
 arch/riscv/boot/dts/starfive/jh7100.dtsi                                               |   67 
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi                                        |   27 
 arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts                                     |    6 
 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi                                  |    6 
 arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts                                  |    6 
 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi                    |    6 
 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi                         |    6 
 arch/riscv/boot/dts/starfive/jh7110.dtsi                                               |   67 
 arch/riscv/include/asm/insn.h                                                          |    2 
 arch/riscv/net/bpf_jit_comp64.c                                                        |   24 
 arch/riscv/net/bpf_jit_core.c                                                          |    1 
 arch/riscv/net/bpf_timed_may_goto.S                                                    |   33 
 arch/s390/include/asm/entry-percpu.h                                                   |   71 
 arch/s390/include/asm/lowcore.h                                                        |    3 
 arch/s390/include/asm/percpu.h                                                         |  358 
 arch/s390/kernel/early.c                                                               |   15 
 arch/s390/kernel/irq.c                                                                 |   10 
 arch/s390/kernel/nmi.c                                                                 |    4 
 arch/s390/kernel/ptrace.c                                                              |    9 
 arch/s390/kernel/traps.c                                                               |    4 
 arch/s390/kernel/uprobes.c                                                             |    2 
 arch/sh/Kconfig                                                                        |    1 
 arch/sh/boards/board-sh7785lcr.c                                                       |    2 
 arch/sh/boot/dts/Makefile                                                              |    2 
 arch/sh/configs/migor_defconfig                                                        |    2 
 arch/sh/configs/sdk7786_defconfig                                                      |    2 
 arch/sh/configs/shx3_defconfig                                                         |    2 
 arch/sh/include/asm/uaccess_32.h                                                       |    8 
 arch/um/include/shared/skas/stub-data.h                                                |    9 
 arch/um/kernel/skas/syscall.c                                                          |    5 
 arch/x86/boot/string.c                                                                 |   13 
 arch/x86/include/asm/cpuid/api.h                                                       |    2 
 arch/x86/include/asm/shared/string.h                                                   |   52 
 arch/x86/include/asm/string.h                                                          |   21 
 arch/x86/include/asm/svm.h                                                             |    4 
 arch/x86/kernel/cpu/common.c                                                           |   76 
 arch/x86/kernel/cpu/mshyperv.c                                                         |   27 
 arch/x86/kernel/crash.c                                                                |    6 
 arch/x86/kernel/fpu/xstate.c                                                           |    7 
 arch/x86/kvm/svm/nested.c                                                              |   31 
 arch/x86/kvm/svm/svm.c                                                                 |    8 
 arch/x86/kvm/svm/svm.h                                                                 |    9 
 arch/x86/net/bpf_jit_comp.c                                                            |   34 
 arch/x86/net/bpf_timed_may_goto.S                                                      |   13 
 arch/x86/platform/pvh/enlighten.c                                                      |    5 
 arch/x86/power/hibernate.c                                                             |   51 
 block/bdev.c                                                                           |   14 
 block/bfq-iosched.c                                                                    |    4 
 block/bio-integrity-fs.c                                                               |   13 
 block/bio.c                                                                            |   50 
 block/blk-cgroup.c                                                                     |   39 
 block/blk-cgroup.h                                                                     |    6 
 block/blk-flush.c                                                                      |    8 
 block/blk-iocost.c                                                                     |  120 
 block/blk-iolatency.c                                                                  |    6 
 block/blk-map.c                                                                        |    1 
 block/blk-mq-dma.c                                                                     |    2 
 block/blk-mq-tag.c                                                                     |   25 
 block/blk-mq.c                                                                         |   93 
 block/blk-mq.h                                                                         |    2 
 block/blk-settings.c                                                                   |    6 
 block/blk-throttle.c                                                                   |   28 
 block/blk-timeout.c                                                                    |    3 
 block/blk.h                                                                            |   14 
 block/fops.c                                                                           |  117 
 block/partitions/mac.c                                                                 |    4 
 crypto/algapi.c                                                                        |   23 
 crypto/asymmetric_keys/pkcs7_parser.c                                                  |    6 
 crypto/asymmetric_keys/verify_pefile.c                                                 |    5 
 crypto/asymmetric_keys/x509_public_key.c                                               |    6 
 crypto/lskcipher.c                                                                     |    6 
 crypto/rsassa-pkcs1.c                                                                  |    4 
 crypto/tcrypt.c                                                                        |  182 
 drivers/accel/amdxdna/aie2_ctx.c                                                       |  126 
 drivers/accel/amdxdna/aie2_pci.c                                                       |   15 
 drivers/accel/amdxdna/aie2_pci.h                                                       |    6 
 drivers/accel/amdxdna/amdxdna_gem.c                                                    |  461 
 drivers/accel/amdxdna/amdxdna_gem.h                                                    |    6 
 drivers/accel/ethosu/ethosu_drv.c                                                      |    2 
 drivers/accel/ivpu/ivpu_gem.c                                                          |    2 
 drivers/accel/qaic/qaic_data.c                                                         |   22 
 drivers/accel/qaic/qaic_debugfs.c                                                      |    1 
 drivers/accel/qaic/qaic_drv.c                                                          |    1 
 drivers/accel/qaic/qaic_ras.c                                                          |    1 
 drivers/accel/qaic/qaic_ssr.c                                                          |    1 
 drivers/accel/qaic/qaic_timesync.c                                                     |    1 
 drivers/accel/qaic/sahara.c                                                            |    1 
 drivers/accel/rocket/rocket_gem.c                                                      |    2 
 drivers/accel/rocket/rocket_job.c                                                      |    2 
 drivers/acpi/acpi_extlog.c                                                             |   64 
 drivers/acpi/acpi_pcc.c                                                                |   33 
 drivers/acpi/acpi_video.c                                                              |   12 
 drivers/acpi/acpica/dsfield.c                                                          |    3 
 drivers/acpi/acpica/exfield.c                                                          |   11 
 drivers/acpi/acpica/nsxfname.c                                                         |    1 
 drivers/acpi/apei/ghes.c                                                               |   92 
 drivers/acpi/apei/ghes_helpers.c                                                       |   18 
 drivers/acpi/button.c                                                                  |   12 
 drivers/acpi/cppc_acpi.c                                                               |   22 
 drivers/acpi/device_pm.c                                                               |   77 
 drivers/acpi/fan_core.c                                                                |    9 
 drivers/acpi/glue.c                                                                    |  142 
 drivers/acpi/numa/hmat.c                                                               |    2 
 drivers/acpi/pci_link.c                                                                |    1 
 drivers/acpi/pci_root.c                                                                |   78 
 drivers/acpi/platform_profile.c                                                        |   82 
 drivers/acpi/scan.c                                                                    |   40 
 drivers/acpi/tables.c                                                                  |    3 
 drivers/android/binder/process.rs                                                      |    4 
 drivers/ata/ahci.c                                                                     |   31 
 drivers/ata/libahci.c                                                                  |   15 
 drivers/ata/libata-core.c                                                              |   21 
 drivers/ata/libata-scsi.c                                                              |    2 
 drivers/ata/pata_parport/pata_parport.c                                                |    9 
 drivers/ata/sata_dwc_460ex.c                                                           |    5 
 drivers/base/node.c                                                                    |   17 
 drivers/base/power/runtime.c                                                           |    6 
 drivers/block/drbd/drbd_main.c                                                         |    1 
 drivers/block/drbd/drbd_receiver.c                                                     |    2 
 drivers/block/floppy.c                                                                 |   10 
 drivers/block/rnbd/rnbd-srv-sysfs.c                                                    |   28 
 drivers/block/rnbd/rnbd-srv.c                                                          |   36 
 drivers/block/rnull/configfs.rs                                                        |    2 
 drivers/block/swim.c                                                                   |  287 
 drivers/block/swim3.c                                                                  |    8 
 drivers/block/swim_asm.S                                                               |  136 
 drivers/block/ublk_drv.c                                                               |    9 
 drivers/block/xen-blkback/blkback.c                                                    |    7 
 drivers/block/zloop.c                                                                  |   80 
 drivers/block/zram/zram_drv.c                                                          |  102 
 drivers/bluetooth/Makefile                                                             |    2 
 drivers/bluetooth/btintel.c                                                            |    8 
 drivers/bluetooth/btintel.h                                                            |    1 
 drivers/bluetooth/btintel_pcie.c                                                       |  530 -
 drivers/bluetooth/btintel_pcie.h                                                       |   64 
 drivers/bluetooth/btmtk.c                                                              |   88 
 drivers/bluetooth/btmtksdio.c                                                          |   13 
 drivers/bluetooth/btusb.c                                                              | 4866 ----------
 drivers/bluetooth/btusb_main.c                                                         | 4861 +++++++++
 drivers/bluetooth/hci_h4.c                                                             |  123 
 drivers/bluetooth/hci_uart.h                                                           |   39 
 drivers/bluetooth/virtio_bt.c                                                          |    4 
 drivers/bus/arm-cci.c                                                                  |    6 
 drivers/bus/mhi/host/pci_generic.c                                                     |    5 
 drivers/char/hw_random/cctrng.c                                                        |    7 
 drivers/char/hw_random/intel-rng.c                                                     |    5 
 drivers/char/hw_random/jh7110-trng.c                                                   |   39 
 drivers/char/scx200_gpio.c                                                             |    8 
 drivers/clk/aspeed/Kconfig                                                             |    1 
 drivers/clk/bcm/clk-raspberrypi.c                                                      |    2 
 drivers/clk/clk-cdce925.c                                                              |    9 
 drivers/clk/clk-lmk04832.c                                                             |    3 
 drivers/clk/clk-milbeaut.c                                                             |   10 
 drivers/clk/clk-renesas-pcie.c                                                         |    5 
 drivers/clk/clk-s2mps11.c                                                              |   12 
 drivers/clk/clk-si521xx.c                                                              |    2 
 drivers/clk/clk-si5351.c                                                               |   20 
 drivers/clk/clk.c                                                                      |   65 
 drivers/clk/clk.h                                                                      |    5 
 drivers/clk/clk_test.c                                                                 |   12 
 drivers/clk/clkdev.c                                                                   |    4 
 drivers/clk/imx/clk-composite-93.c                                                     |   11 
 drivers/clk/kunit_clk_assigned_rates.h                                                 |    4 
 drivers/clk/mediatek/reset.h                                                           |    6 
 drivers/clk/meson/t7-peripherals.c                                                     |   13 
 drivers/clk/qcom/Kconfig                                                               |    2 
 drivers/clk/qcom/cambistmclkcc-kaanapali.c                                             |    7 
 drivers/clk/qcom/cambistmclkcc-sm8750.c                                                |    7 
 drivers/clk/qcom/camcc-glymur.c                                                        |    7 
 drivers/clk/qcom/clk-alpha-pll.c                                                       |    9 
 drivers/clk/qcom/clk-rcg2.c                                                            |   35 
 drivers/clk/qcom/clk-rpmh.c                                                            |    5 
 drivers/clk/qcom/dispcc-sm8450.c                                                       |    2 
 drivers/clk/qcom/gcc-eliza.c                                                           |    1 
 drivers/clk/qcom/gcc-glymur.c                                                          |   69 
 drivers/clk/qcom/gcc-ipq5424.c                                                         |    4 
 drivers/clk/qcom/gcc-kaanapali.c                                                       |    1 
 drivers/clk/qcom/gcc-qcs615.c                                                          |    2 
 drivers/clk/qcom/gcc-x1e80100.c                                                        |    6 
 drivers/clk/qcom/lpasscc-sm6115.c                                                      |    4 
 drivers/clk/qcom/mmcc-msm8960.c                                                        |    3 
 drivers/clk/qcom/mmcc-msm8996.c                                                        |    4 
 drivers/clk/qcom/mmcc-sdm660.c                                                         |    2 
 drivers/clk/qcom/negcc-nord.c                                                          |    4 
 drivers/clk/qcom/nwgcc-nord.c                                                          |    5 
 drivers/clk/qcom/segcc-nord.c                                                          |    8 
 drivers/clk/starfive/clk-starfive-jh7110-sys.c                                         |    3 
 drivers/clk/stm32/clk-stm32mp21.c                                                      |    4 
 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c                                               |   37 
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c                                                 |  128 
 drivers/clk/sunxi-ng/ccu_div.h                                                         |   18 
 drivers/clk/ti/adpll.c                                                                 |    1 
 drivers/clk/versatile/clk-icst.c                                                       |    4 
 drivers/clocksource/clksrc-dbx500-prcmu.c                                              |    2 
 drivers/clocksource/timer-econet-en751221.c                                            |    1 
 drivers/clocksource/timer-mediatek.c                                                   |    4 
 drivers/clocksource/timer-ti-dm.c                                                      |   10 
 drivers/comedi/drivers/addi_apci_3xxx.c                                                |    2 
 drivers/comedi/drivers/comedi_parport.c                                                |    3 
 drivers/comedi/drivers/dmm32at.c                                                       |    3 
 drivers/comedi/drivers/dt2811.c                                                        |    2 
 drivers/comedi/drivers/dt2814.c                                                        |    3 
 drivers/comedi/drivers/ni_atmio16d.c                                                   |    4 
 drivers/comedi/drivers/pcmmio.c                                                        |    3 
 drivers/comedi/drivers/pcmuio.c                                                        |    5 
 drivers/cpufreq/amd-pstate-ut.c                                                        |   23 
 drivers/cpufreq/amd-pstate.c                                                           |   37 
 drivers/cpufreq/amd-pstate.h                                                           |   14 
 drivers/cpufreq/qcom-cpufreq-hw.c                                                      |    3 
 drivers/cpufreq/sparc-us2e-cpufreq.c                                                   |   11 
 drivers/cpufreq/sti-cpufreq.c                                                          |    4 
 drivers/cpufreq/tegra194-cpufreq.c                                                     |    2 
 drivers/cpuidle/governors/menu.c                                                       |    8 
 drivers/cpuidle/governors/teo.c                                                        |   11 
 drivers/crypto/amlogic/amlogic-gxl-cipher.c                                            |   25 
 drivers/crypto/atmel-aes.c                                                             |    2 
 drivers/crypto/atmel-sha.c                                                             |   17 
 drivers/crypto/caam/caamalg_qi.c                                                       |    2 
 drivers/crypto/caam/caamalg_qi2.c                                                      |    2 
 drivers/crypto/ccp/ccp-dev-v3.c                                                        |    4 
 drivers/crypto/ccp/ccp-dev-v5.c                                                        |    4 
 drivers/crypto/ccp/sfs.c                                                               |    9 
 drivers/crypto/hisilicon/hpre/hpre_crypto.c                                            |    2 
 drivers/crypto/inside-secure/eip93/eip93-regs.h                                        |    2 
 drivers/crypto/inside-secure/safexcel_hash.c                                           |    3 
 drivers/crypto/intel/qat/qat_common/adf_cfg.c                                          |   49 
 drivers/crypto/intel/qat/qat_common/adf_init.c                                         |   24 
 drivers/crypto/intel/qat/qat_common/adf_isr.c                                          |   15 
 drivers/crypto/intel/qat/qat_common/adf_sysfs_kpt.c                                    |   24 
 drivers/crypto/intel/qat/qat_common/qat_algs.c                                         |   15 
 drivers/crypto/intel/qat/qat_common/qat_asym_algs.c                                    |   38 
 drivers/crypto/mxs-dcp.c                                                               |    3 
 drivers/crypto/starfive/jh7110-cryp.c                                                  |   20 
 drivers/crypto/talitos.c                                                               |   54 
 drivers/cxl/core/cdat.c                                                                |    8 
 drivers/cxl/core/core.h                                                                |   14 
 drivers/cxl/core/edac.c                                                                |   30 
 drivers/cxl/core/features.c                                                            |   56 
 drivers/cxl/core/hdm.c                                                                 |   62 
 drivers/cxl/core/mce.c                                                                 |    8 
 drivers/cxl/core/pci.c                                                                 |   21 
 drivers/cxl/core/port.c                                                                |  218 
 drivers/cxl/core/ras.c                                                                 |    6 
 drivers/cxl/core/ras_rch.c                                                             |   12 
 drivers/cxl/core/region.c                                                              |   15 
 drivers/cxl/core/region_pmem.c                                                         |    6 
 drivers/cxl/cxl.h                                                                      |   24 
 drivers/cxl/mem.c                                                                      |   28 
 drivers/cxl/pci.c                                                                      |   22 
 drivers/dax/bus.c                                                                      |    8 
 drivers/dax/fsdev.c                                                                    |   23 
 drivers/dax/super.c                                                                    |    3 
 drivers/dma/at_hdmac.c                                                                 |   44 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                                         |   37 
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h                                                  |    5 
 drivers/dma/fsl_raid.c                                                                 |   32 
 drivers/dma/img-mdc-dma.c                                                              |    2 
 drivers/dma/ioat/init.c                                                                |   18 
 drivers/dma/loongson/loongson2-apb-cmc-dma.c                                           |    2 
 drivers/dma/mediatek/mtk-hsdma.c                                                       |   26 
 drivers/dma/mv_xor.c                                                                   |    1 
 drivers/dma/plx_dma.c                                                                  |   10 
 drivers/dma/sprd-dma.c                                                                 |   45 
 drivers/dma/ste_dma40.c                                                                |  587 -
 drivers/dma/ste_dma40_ll.c                                                             |    8 
 drivers/dma/ste_dma40_ll.h                                                             |    4 
 drivers/dma/sun6i-dma.c                                                                |   31 
 drivers/dma/switchtec_dma.c                                                            |   56 
 drivers/dma/xilinx/xilinx_dma.c                                                        |   37 
 drivers/dma/xilinx/zynqmp_dma.c                                                        |   48 
 drivers/dpll/zl3073x/dpll.c                                                            |  237 
 drivers/dpll/zl3073x/out.h                                                             |   36 
 drivers/dpll/zl3073x/prop.c                                                            |   56 
 drivers/edac/i10nm_base.c                                                              |    1 
 drivers/firmware/arm_scmi/common.h                                                     |   22 
 drivers/firmware/arm_scmi/driver.c                                                     |   38 
 drivers/firmware/arm_scmi/protocols.h                                                  |    9 
 drivers/firmware/arm_scmi/raw_mode.c                                                   |   30 
 drivers/firmware/cirrus/cs_dsp.c                                                       |    2 
 drivers/firmware/efi/cper.c                                                            |   51 
 drivers/firmware/efi/libstub/efi-stub-entry.c                                          |    4 
 drivers/firmware/efi/libstub/efi-stub-helper.c                                         |   10 
 drivers/firmware/efi/libstub/efi-stub.c                                                |    2 
 drivers/firmware/efi/libstub/efistub.h                                                 |    4 
 drivers/firmware/efi/libstub/fdt.c                                                     |    6 
 drivers/firmware/efi/libstub/file.c                                                    |    8 
 drivers/firmware/efi/libstub/kaslr.c                                                   |    2 
 drivers/firmware/efi/libstub/mem.c                                                     |    2 
 drivers/firmware/efi/libstub/pci.c                                                     |    2 
 drivers/firmware/efi/libstub/random.c                                                  |    8 
 drivers/firmware/efi/libstub/riscv-stub.c                                              |    7 
 drivers/firmware/efi/libstub/riscv.c                                                   |    2 
 drivers/firmware/efi/libstub/tpm.c                                                     |    8 
 drivers/firmware/efi/libstub/unaccepted_memory.c                                       |    2 
 drivers/firmware/efi/libstub/x86-stub.c                                                |   10 
 drivers/firmware/efi/runtime-wrappers.c                                                |   14 
 drivers/firmware/imx/imx-dsp.c                                                         |    6 
 drivers/firmware/qcom/qcom_scm.c                                                       |   16 
 drivers/firmware/qcom/qcom_tzmem.c                                                     |    2 
 drivers/gpio/gpio-crystalcove.c                                                        |    1 
 drivers/gpio/gpio-pcf857x.c                                                            |   16 
 drivers/gpio/gpiolib.c                                                                 |   20 
 drivers/gpu/buddy.c                                                                    |    1 
 drivers/gpu/drm/Makefile                                                               |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                                             |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c                                        |    7 
 drivers/gpu/drm/amd/amdgpu/atom.c                                                      |   29 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c                                                 |   72 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c                                                 |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c                                                 |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c                                                 |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c                                                 |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c                                               |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c                                               |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c                                               |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c                                               |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c                                               |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c                                               |    6 
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c                                             |    3 
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c                                                  |    8 
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                                                  |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c                                                  |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c                                                  |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c                                                  |    4 
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c                                                  |    4 
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c                                                  |    6 
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c                                                  |    6 
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                                                  |    6 
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c                                                  |    6 
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c                                                  |   11 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c                                                  |    8 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c                                                  |   12 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                                                  |   12 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                                  |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c                                                |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c                                                |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c                                                |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c                                                |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c                                                |   14 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                                                  |    2 
 drivers/gpu/drm/amd/display/Kconfig                                                    |    9 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                                      |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c                            |   18 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c                                 |   11 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c                              |   18 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h                                |   94 
 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c                   |   17 
 drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c                             |    7 
 drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c                            |    2 
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile                                        |    8 
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c                                       |    4 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c                            |  115 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h                            |    8 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c                         |   59 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.h                         |    4 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c                           |  181 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h                           |   29 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                               |    4 
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c                                  |  113 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                                      |   79 
 drivers/gpu/drm/amd/display/dc/dc_types.h                                              |    1 
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c                                  |    6 
 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c |    2 
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c                                       |    4 
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c                                     |    4 
 drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.h                             |    7 
 drivers/gpu/drm/amd/display/dc/hwss/Makefile                                           |    6 
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c                              |   25 
 drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c                                |    3 
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c                                |   35 
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h                                |    3 
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c                                |   63 
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h                                |    7 
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c                                |   55 
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h                                |    8 
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c                                |   60 
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h                                |   10 
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c                              |   53 
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h                              |    9 
 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c                                |   51 
 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h                                |   12 
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h                                     |   23 
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h                             |   18 
 drivers/gpu/drm/amd/display/dc/irq/Makefile                                            |    2 
 drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c                         |   21 
 drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.h                         |    9 
 drivers/gpu/drm/amd/display/dc/irq/irq_service.c                                       |   28 
 drivers/gpu/drm/amd/display/dc/irq/irq_service.h                                       |    9 
 drivers/gpu/drm/amd/display/dc/resource/Makefile                                       |    4 
 drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c                       |   62 
 drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c                       |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c                                    |    3 
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h                                           |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c                                         |  166 
 drivers/gpu/drm/amd/ras/core/eeprom.c                                                  |    6 
 drivers/gpu/drm/arm/display/include/malidp_product.h                                   |   10 
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c                                        |    5 
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c                                              |    2 
 drivers/gpu/drm/drm_connector.c                                                        |    2 
 drivers/gpu/drm/drm_of.c                                                               |    8 
 drivers/gpu/drm/drm_pagemap.c                                                          |    3 
 drivers/gpu/drm/drm_ras.c                                                              |   19 
 drivers/gpu/drm/drm_syncobj.c                                                          |   35 
 drivers/gpu/drm/drm_timeout.c                                                          |   95 
 drivers/gpu/drm/exynos/exynos_drm_fimd.c                                               |    2 
 drivers/gpu/drm/i915/display/intel_psr.c                                               |   13 
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c                                                    |    3 
 drivers/gpu/drm/lima/lima_gem.c                                                        |    2 
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c                                                  |   12 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                                                  |   49 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                                  |   20 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                                  |   40 
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c                                                  |    3 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                                                |    3 
 drivers/gpu/drm/msm/adreno/adreno_gpu.h                                                |    7 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c                                          |   17 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                                            |   10 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c                                   |    4 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c                                               |    9 
 drivers/gpu/drm/msm/dp/dp_ctrl.c                                                       |    3 
 drivers/gpu/drm/msm/dp/dp_debug.c                                                      |    1 
 drivers/gpu/drm/msm/msm_io_utils.c                                                     |    6 
 drivers/gpu/drm/omapdrm/dss/dsi.c                                                      |   63 
 drivers/gpu/drm/panel/Kconfig                                                          |    2 
 drivers/gpu/drm/panfrost/panfrost_devfreq.c                                            |    2 
 drivers/gpu/drm/panfrost/panfrost_device.c                                             |   19 
 drivers/gpu/drm/panfrost/panfrost_device.h                                             |    1 
 drivers/gpu/drm/panfrost/panfrost_drv.c                                                |   43 
 drivers/gpu/drm/panfrost/panfrost_drv.h                                                |    9 
 drivers/gpu/drm/panfrost/panfrost_gem.c                                                |   35 
 drivers/gpu/drm/panfrost/panfrost_gem.h                                                |    7 
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c                                       |    9 
 drivers/gpu/drm/panfrost/panfrost_gpu.c                                                |    2 
 drivers/gpu/drm/panfrost/panfrost_job.c                                                |    2 
 drivers/gpu/drm/panfrost/panfrost_mmu.c                                                |   14 
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c                                            |  313 
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h                                            |    1 
 drivers/gpu/drm/panthor/panthor_gem.c                                                  |    3 
 drivers/gpu/drm/panthor/panthor_gpu.c                                                  |   89 
 drivers/gpu/drm/panthor/panthor_mmu.c                                                  |   28 
 drivers/gpu/drm/panthor/panthor_trace.h                                                |   38 
 drivers/gpu/drm/pl111/pl111_display.c                                                  |    6 
 drivers/gpu/drm/pl111/pl111_drv.c                                                      |   16 
 drivers/gpu/drm/pl111/pl111_versatile.c                                                |   18 
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c                                         |   18 
 drivers/gpu/drm/tegra/submit.c                                                         |   12 
 drivers/gpu/drm/tegra/uapi.c                                                           |    2 
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c                                     |   54 
 drivers/gpu/drm/tiny/appletbdrm.c                                                      |   48 
 drivers/gpu/drm/vc4/vc4_bo.c                                                           |    3 
 drivers/gpu/drm/vc4/vc4_drv.c                                                          |   29 
 drivers/gpu/drm/vc4/vc4_gem.c                                                          |    3 
 drivers/gpu/drm/vc4/vc4_hvs.c                                                          |   10 
 drivers/gpu/drm/vc4/vc4_v3d.c                                                          |    8 
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c                                          |    8 
 drivers/gpu/drm/verisilicon/vs_plane.c                                                 |   20 
 drivers/gpu/drm/verisilicon/vs_plane.h                                                 |    2 
 drivers/gpu/drm/verisilicon/vs_primary_plane.c                                         |    7 
 drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py                                       |   87 
 drivers/gpu/drm/vkms/tests/vkms_format_test.c                                          |   38 
 drivers/gpu/drm/vkms/vkms_formats.c                                                    |   55 
 drivers/gpu/drm/xe/xe_pagefault.c                                                      |    7 
 drivers/gpu/drm/xe/xe_wait_user_fence.c                                                |    2 
 drivers/gpu/nova-core/gsp/boot.rs                                                      |   10 
 drivers/hid/hid-asus.c                                                                 |   28 
 drivers/hid/hid-ids.h                                                                  |    1 
 drivers/hid/hid-logitech-hidpp.c                                                       |    1 
 drivers/hid/hid-magicmouse.c                                                           |    4 
 drivers/hid/hid-nintendo.c                                                             |   14 
 drivers/hid/i2c-hid/i2c-hid-core.c                                                     |   11 
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c                                |    4 
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h                                |    2 
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c                                |    6 
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.h                                |    2 
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c                                |    2 
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h                                |    2 
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c                                |    6 
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.h                                |    2 
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c                           |    2 
 drivers/hid/wacom_wac.c                                                                |   14 
 drivers/hv/hv_common.c                                                                 |   10 
 drivers/hv/mshv_vtl_main.c                                                             |    4 
 drivers/hv/vmbus_drv.c                                                                 |   30 
 drivers/hwmon/coretemp.c                                                               |   15 
 drivers/hwtracing/coresight/coresight-config.c                                         |   18 
 drivers/hwtracing/coresight/coresight-config.h                                         |   22 
 drivers/hwtracing/coresight/coresight-etm.h                                            |    4 
 drivers/hwtracing/coresight/coresight-etm3x-core.c                                     |   66 
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c                                    |   83 
 drivers/hwtracing/coresight/coresight-etm4x-cfg.c                                      |   13 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                                     |  121 
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c                                    |    6 
 drivers/hwtracing/coresight/coresight-etm4x.h                                          |    4 
 drivers/i3c/device.c                                                                   |   15 
 drivers/i3c/internals.h                                                                |    2 
 drivers/i3c/master.c                                                                   |   76 
 drivers/i3c/master/mipi-i3c-hci/core.c                                                 |   16 
 drivers/i3c/master/mipi-i3c-hci/dma.c                                                  |  134 
 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c                                     |    1 
 drivers/iio/accel/bma220_spi.c                                                         |    3 
 drivers/iio/accel/kionix-kx022a.h                                                      |    2 
 drivers/iio/dac/ad5758.c                                                               |    8 
 drivers/iio/dac/mcp47feb02.c                                                           |    4 
 drivers/iio/humidity/hts221_core.c                                                     |  106 
 drivers/iio/imu/adis16400.c                                                            |    5 
 drivers/iio/pressure/rohm-bm1390.c                                                     |    4 
 drivers/iio/temperature/tmp117.c                                                       |    9 
 drivers/infiniband/core/device.c                                                       |    2 
 drivers/infiniband/core/ib_core_uverbs.c                                               |   12 
 drivers/infiniband/core/lag.c                                                          |   14 
 drivers/infiniband/core/mad.c                                                          |    2 
 drivers/infiniband/core/mad_rmpp.c                                                     |    7 
 drivers/infiniband/core/nldev.c                                                        |    9 
 drivers/infiniband/core/rdma_core.c                                                    |    2 
 drivers/infiniband/core/rdma_core.h                                                    |   17 
 drivers/infiniband/core/restrack.c                                                     |    3 
 drivers/infiniband/core/sysfs.c                                                        |    9 
 drivers/infiniband/core/uverbs_std_types_device.c                                      |    1 
 drivers/infiniband/core/uverbs_std_types_wq.c                                          |    2 
 drivers/infiniband/core/verbs.c                                                        |    6 
 drivers/infiniband/hw/bnxt_re/bnxt_re.h                                                |    4 
 drivers/infiniband/hw/bnxt_re/hw_counters.c                                            |    6 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                               |   58 
 drivers/infiniband/hw/bnxt_re/main.c                                                   |   24 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                                             |    4 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                                              |   23 
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                                               |    2 
 drivers/infiniband/hw/cxgb4/cm.c                                                       |    5 
 drivers/infiniband/hw/cxgb4/provider.c                                                 |    5 
 drivers/infiniband/hw/efa/efa_com.c                                                    |   28 
 drivers/infiniband/hw/hfi1/sdma.c                                                      |    3 
 drivers/infiniband/hw/hfi1/verbs.c                                                     |    4 
 drivers/infiniband/hw/hns/hns_roce_bond.c                                              |    4 
 drivers/infiniband/hw/hns/hns_roce_cq.c                                                |    1 
 drivers/infiniband/hw/hns/hns_roce_device.h                                            |    1 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                             |   55 
 drivers/infiniband/hw/ionic/ionic_controlpath.c                                        |   16 
 drivers/infiniband/hw/ionic/ionic_ibdev.c                                              |    4 
 drivers/infiniband/hw/irdma/ctrl.c                                                     |   14 
 drivers/infiniband/hw/irdma/hw.c                                                       |   14 
 drivers/infiniband/hw/irdma/main.c                                                     |    2 
 drivers/infiniband/hw/irdma/pble.c                                                     |    8 
 drivers/infiniband/hw/irdma/type.h                                                     |    4 
 drivers/infiniband/hw/irdma/verbs.c                                                    |   13 
 drivers/infiniband/hw/mlx4/cm.c                                                        |   10 
 drivers/infiniband/hw/mlx4/main.c                                                      |    4 
 drivers/infiniband/hw/mlx5/cq.c                                                        |    5 
 drivers/infiniband/hw/mlx5/fs.c                                                        |   52 
 drivers/infiniband/hw/mlx5/main.c                                                      |   56 
 drivers/infiniband/hw/mlx5/odp.c                                                       |    2 
 drivers/infiniband/hw/mlx5/qp.c                                                        |   30 
 drivers/infiniband/hw/mlx5/qpc.c                                                       |   18 
 drivers/infiniband/hw/mlx5/srq.c                                                       |    3 
 drivers/infiniband/hw/mlx5/wr.c                                                        |    1 
 drivers/infiniband/hw/usnic/usnic_debugfs.c                                            |    2 
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c                                           |    6 
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c                                          |    3 
 drivers/infiniband/sw/rdmavt/qp.c                                                      |    2 
 drivers/infiniband/sw/rxe/rxe_loc.h                                                    |    8 
 drivers/infiniband/sw/rxe/rxe_mr.c                                                     |   12 
 drivers/infiniband/sw/rxe/rxe_mw.c                                                     |    3 
 drivers/infiniband/sw/rxe/rxe_net.c                                                    |   73 
 drivers/infiniband/sw/rxe/rxe_odp.c                                                    |    9 
 drivers/infiniband/sw/rxe/rxe_qp.c                                                     |   10 
 drivers/infiniband/sw/rxe/rxe_recv.c                                                   |    9 
 drivers/infiniband/sw/rxe/rxe_req.c                                                    |   11 
 drivers/infiniband/sw/rxe/rxe_resp.c                                                   |   23 
 drivers/infiniband/sw/rxe/rxe_verbs.h                                                  |    1 
 drivers/infiniband/sw/siw/siw_main.c                                                   |    5 
 drivers/infiniband/sw/siw/siw_qp_tx.c                                                  |   20 
 drivers/infiniband/ulp/ipoib/ipoib_main.c                                              |    7 
 drivers/infiniband/ulp/isert/ib_isert.c                                                |    2 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                                                 |   77 
 drivers/infiniband/ulp/srp/ib_srp.c                                                    |    2 
 drivers/interconnect/qcom/bcm-voter.c                                                  |   25 
 drivers/interconnect/qcom/icc-common.h                                                 |    9 
 drivers/interconnect/qcom/icc-rpm.c                                                    |  101 
 drivers/interconnect/qcom/icc-rpm.h                                                    |    6 
 drivers/interconnect/qcom/msm8976.c                                                    |    3 
 drivers/interconnect/qcom/msm8996.c                                                    |    1 
 drivers/interconnect/qcom/smd-rpm.c                                                    |    8 
 drivers/interconnect/samsung/exynos.c                                                  |    1 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c                                       |   19 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                                            |   20 
 drivers/iommu/intel/dmar.c                                                             |   72 
 drivers/iommu/intel/iommu.c                                                            |  152 
 drivers/iommu/intel/nested.c                                                           |    2 
 drivers/iommu/iommufd/device.c                                                         |    8 
 drivers/iommu/iommufd/selftest.c                                                       |    6 
 drivers/irqchip/Kconfig                                                                |    4 
 drivers/irqchip/irq-aclint-sswi.c                                                      |    1 
 drivers/irqchip/irq-gic-common.c                                                       |    2 
 drivers/irqchip/irq-gic-v3-its.c                                                       |   20 
 drivers/irqchip/irq-gic-v3.c                                                           |   22 
 drivers/irqchip/irq-gic.c                                                              |    4 
 drivers/irqchip/irq-mips-gic.c                                                         |   59 
 drivers/irqchip/irq-mst-intc.c                                                         |    3 
 drivers/irqchip/irq-riscv-imsic-state.c                                                |   21 
 drivers/irqchip/irq-sifive-plic.c                                                      |    2 
 drivers/leds/led-class-flash.c                                                         |    2 
 drivers/leds/led-class.c                                                               |   25 
 drivers/leds/led-triggers.c                                                            |   28 
 drivers/leds/leds-lm3692x.c                                                            |    4 
 drivers/leds/leds-lp8860.c                                                             |    5 
 drivers/leds/leds-max77705.c                                                           |    3 
 drivers/leds/leds-pca9532.c                                                            |    9 
 drivers/leds/leds-st1202.c                                                             |  225 
 drivers/mailbox/arm_mhu_db.c                                                           |    4 
 drivers/mailbox/arm_mhuv2.c                                                            |    9 
 drivers/mailbox/axiado-mailbox.c                                                       |  116 
 drivers/mailbox/pcc.c                                                                  |    5 
 drivers/mailbox/qcom-cpucp-mbox.c                                                      |    2 
 drivers/mailbox/qcom-ipcc.c                                                            |    6 
 drivers/mailbox/ti-msgmgr.c                                                            |   14 
 drivers/md/dm-snap.c                                                                   |   18 
 drivers/md/md.c                                                                        |   33 
 drivers/md/raid0.c                                                                     |   16 
 drivers/md/raid10.c                                                                    |    3 
 drivers/md/raid5-cache.c                                                               |   14 
 drivers/md/raid5-ppl.c                                                                 |   12 
 drivers/md/raid5.c                                                                     |   65 
 drivers/media/i2c/ar0521.c                                                             |    1 
 drivers/media/i2c/imx471.c                                                             |    2 
 drivers/media/i2c/ov5648.c                                                             |    4 
 drivers/media/i2c/t4ka3.c                                                              |    1 
 drivers/media/pci/intel/ivsc/mei_ace.c                                                 |    4 
 drivers/media/platform/qcom/iris/iris_ctrls.c                                          |    2 
 drivers/media/platform/qcom/iris/iris_firmware.c                                       |  119 
 drivers/media/platform/qcom/iris/iris_hfi_common.c                                     |    3 
 drivers/media/platform/qcom/iris/iris_hfi_gen1_response.c                              |    2 
 drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c                              |    1 
 drivers/media/platform/qcom/iris/iris_instance.h                                       |    4 
 drivers/media/platform/qcom/iris/iris_platform_common.h                                |    6 
 drivers/media/platform/qcom/iris/iris_platform_vpu2.c                                  |   13 
 drivers/media/platform/qcom/iris/iris_platform_vpu3x.c                                 |   10 
 drivers/media/platform/qcom/iris/iris_probe.c                                          |    6 
 drivers/media/platform/qcom/iris/iris_utils.c                                          |    6 
 drivers/media/platform/qcom/iris/iris_utils.h                                          |    1 
 drivers/media/platform/qcom/iris/iris_vb2.c                                            |    6 
 drivers/media/platform/qcom/iris/iris_vidc.c                                           |   45 
 drivers/media/platform/qcom/iris/iris_vpu_common.c                                     |    2 
 drivers/media/platform/qcom/venus/hfi_msgs.c                                           |    3 
 drivers/media/platform/renesas/rcar-isp/core-io.c                                      |   40 
 drivers/media/usb/em28xx/em28xx-video.c                                                |    3 
 drivers/memory/brcmstb_dpfe.c                                                          |   17 
 drivers/memory/emif.c                                                                  |    3 
 drivers/memory/samsung/exynos5422-dmc.c                                                |   11 
 drivers/mfd/cs42l43-i2c.c                                                              |    8 
 drivers/mfd/cs42l43-sdw.c                                                              |    8 
 drivers/mfd/cs42l43.c                                                                  |   12 
 drivers/mfd/cs42l43.h                                                                  |    1 
 drivers/mfd/da9150-core.c                                                              |    8 
 drivers/mfd/intel_quark_i2c_gpio.c                                                     |   52 
 drivers/mfd/rk8xx-core.c                                                               |    2 
 drivers/misc/enclosure.c                                                               |    3 
 drivers/misc/mei/vsc-tp.c                                                              |   17 
 drivers/misc/nsm.c                                                                     |    7 
 drivers/mtd/mtd_blkdevs.c                                                              |    5 
 drivers/mtd/nand/raw/pl35x-nand-controller.c                                           |    1 
 drivers/mtd/nand/raw/sunxi_nand.c                                                      |   32 
 drivers/mtd/spi-nor/spansion.c                                                         |    7 
 drivers/net/amt.c                                                                      |    8 
 drivers/net/dsa/mt7530.c                                                               |    7 
 drivers/net/dsa/mv88e6xxx/chip.c                                                       |   10 
 drivers/net/dsa/yt921x.c                                                               |    4 
 drivers/net/ethernet/alacritech/slicoss.c                                              |    2 
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c                                   |    2 
 drivers/net/ethernet/broadcom/asp2/bcmasp.c                                            |  121 
 drivers/net/ethernet/broadcom/asp2/bcmasp.h                                            |    4 
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c                                       |   32 
 drivers/net/ethernet/broadcom/bgmac.c                                                  |   47 
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c                                       |   28 
 drivers/net/ethernet/broadcom/bnge/bnge_resc.c                                         |    6 
 drivers/net/ethernet/broadcom/bnge/bnge_resc.h                                         |    9 
 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c                                         |    6 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c                                        |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                              |   58 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                                      |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                                          |    1 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                                         |  102 
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                                         |    1 
 drivers/net/ethernet/cadence/macb.h                                                    |    2 
 drivers/net/ethernet/cadence/macb_main.c                                               |   20 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c                                       |    1 
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c                                       |    1 
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c                                      |    2 
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c                                          |   12 
 drivers/net/ethernet/ibm/ibmveth.c                                                     |  670 +
 drivers/net/ethernet/ibm/ibmveth.h                                                     |    5 
 drivers/net/ethernet/intel/ice/ice.h                                                   |    8 
 drivers/net/ethernet/intel/ice/ice_adapter.c                                           |   17 
 drivers/net/ethernet/intel/ice/ice_adapter.h                                           |   17 
 drivers/net/ethernet/intel/ice/ice_lib.c                                               |  343 
 drivers/net/ethernet/intel/ice/ice_ptp.c                                               |  174 
 drivers/net/ethernet/intel/ice/ice_ptp.h                                               |   10 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                                    |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c                               |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c                               |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h                               |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c                                 |   10 
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c                                       |    2 
 drivers/net/ethernet/mellanox/mlx4/intf.c                                              |   15 
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c                                      |    6 
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c                                         |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c                                       |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h                            |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c                               |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h                            |   13 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c                                   |   17 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                                      |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                                        |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c                                  |    4 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c                          |   66 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h                          |    1 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c                    |   11 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c                         |   12 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.h                         |    5 
 drivers/net/ethernet/meta/fbnic/fbnic.h                                                |    7 
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c                                             |   78 
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h                                             |   15 
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c                                            |   24 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c                                           |    2 
 drivers/net/ethernet/microchip/fdma/fdma_api.c                                         |   45 
 drivers/net/ethernet/microchip/fdma/fdma_api.h                                         |   20 
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c                                  |   17 
 drivers/net/ethernet/microchip/lan966x/lan966x_mac.c                                   |    4 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c                                  |   19 
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c                                   |   10 
 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_calendar.c                       |    8 
 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c                           |    5 
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c                                    |    3 
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c                                  |   15 
 drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c                                    |   10 
 drivers/net/ethernet/microsoft/mana/gdma_main.c                                        |  969 +
 drivers/net/ethernet/microsoft/mana/hw_channel.c                                       |    9 
 drivers/net/ethernet/microsoft/mana/mana_en.c                                          |   32 
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c                                     |   19 
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c                                      |    2 
 drivers/net/ethernet/netronome/nfp/flower/main.h                                       |    2 
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c                                |   24 
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c                                    |    1 
 drivers/net/ethernet/pensando/ionic/ionic_main.c                                       |   13 
 drivers/net/ethernet/qlogic/qede/qede_filter.c                                         |    2 
 drivers/net/ethernet/sfc/Kconfig                                                       |    2 
 drivers/net/ethernet/stmicro/stmmac/descs.h                                            |    6 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c                                     |    2 
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c                                         |   25 
 drivers/net/ethernet/stmicro/stmmac/hwif.h                                             |    6 
 drivers/net/ethernet/stmicro/stmmac/stmmac.h                                           |    7 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c                                   |   11 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                                      |  115 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c                                 |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                                        |   16 
 drivers/net/ethernet/ti/am65-cpts.c                                                    |    1 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                                      |   86 
 drivers/net/gtp.c                                                                      |   51 
 drivers/net/loopback.c                                                                 |    8 
 drivers/net/macsec.c                                                                   |    5 
 drivers/net/phy/marvell.c                                                              |   97 
 drivers/net/phy/qcom/at803x.c                                                          |   98 
 drivers/net/phy/qcom/qca83xx.c                                                         |   58 
 drivers/net/phy/realtek/realtek_main.c                                                 |    2 
 drivers/net/ppp/ppp_generic.c                                                          |   95 
 drivers/net/ppp/pppoe.c                                                                |    8 
 drivers/net/pse-pd/si3474.c                                                            |   27 
 drivers/net/team/team_core.c                                                           |   11 
 drivers/net/tun.c                                                                      |   10 
 drivers/net/usb/cdc_mbim.c                                                             |    5 
 drivers/net/usb/cdc_ncm.c                                                              |    7 
 drivers/net/usb/lan78xx.c                                                              |   18 
 drivers/net/usb/usbnet.c                                                               |   28 
 drivers/net/veth.c                                                                     |    7 
 drivers/net/virtio_net.c                                                               |   12 
 drivers/net/vxlan/vxlan_core.c                                                         |    2 
 drivers/net/wireless/ath/ath10k/htt_tx.c                                               |   12 
 drivers/net/wireless/ath/ath11k/Kconfig                                                |    3 
 drivers/net/wireless/ath/ath11k/ahb.c                                                  |    7 
 drivers/net/wireless/ath/ath11k/ce.c                                                   |    2 
 drivers/net/wireless/ath/ath11k/core.c                                                 |   11 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                                |   19 
 drivers/net/wireless/ath/ath11k/mac.c                                                  |   33 
 drivers/net/wireless/ath/ath11k/mac.h                                                  |    2 
 drivers/net/wireless/ath/ath11k/wmi.c                                                  |    9 
 drivers/net/wireless/ath/ath12k/ahb.c                                                  |   41 
 drivers/net/wireless/ath/ath12k/core.c                                                 |    3 
 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c                                    |    2 
 drivers/net/wireless/ath/ath12k/dp.c                                                   |    9 
 drivers/net/wireless/ath/ath12k/dp_mon.c                                               |   15 
 drivers/net/wireless/ath/ath12k/dp_mon.h                                               |    2 
 drivers/net/wireless/ath/ath12k/mac.c                                                  |   40 
 drivers/net/wireless/ath/ath12k/mac.h                                                  |    2 
 drivers/net/wireless/ath/ath12k/pci.c                                                  |   55 
 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c                                         |   47 
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c                                          |   30 
 drivers/net/wireless/ath/ath12k/wmi.c                                                  |   11 
 drivers/net/wireless/ath/ath6kl/cfg80211.c                                             |    2 
 drivers/net/wireless/ath/ath9k/xmit.c                                                  |    2 
 drivers/net/wireless/ath/carl9170/debug.c                                              |    5 
 drivers/net/wireless/broadcom/b43/debugfs.c                                            |    2 
 drivers/net/wireless/broadcom/b43legacy/debugfs.c                                      |    2 
 drivers/net/wireless/intel/iwlwifi/mld/low_latency.c                                   |    3 
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c                                         |    4 
 drivers/net/wireless/marvell/mwifiex/cmdevt.c                                          |   10 
 drivers/net/wireless/marvell/mwifiex/fw.h                                              |    6 
 drivers/net/wireless/marvell/mwifiex/init.c                                            |    1 
 drivers/net/wireless/marvell/mwifiex/main.h                                            |    1 
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c                                       |    3 
 drivers/net/wireless/mediatek/mt76/Kconfig                                             |    1 
 drivers/net/wireless/mediatek/mt76/channel.c                                           |   21 
 drivers/net/wireless/mediatek/mt76/mac80211.c                                          |   17 
 drivers/net/wireless/mediatek/mt76/mt76.h                                              |   27 
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c                                        |   18 
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                                        |   13 
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c                                        |   17 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c                                   |   20 
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                                       |   11 
 drivers/net/wireless/mediatek/mt76/mt7915/coredump.c                                   |    7 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                                     |    6 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                                       |   17 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                                       |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                                       |   47 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                                        |    9 
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                                     |    5 
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c                                        |    1 
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c                                    |    4 
 drivers/net/wireless/mediatek/mt76/mt7921/regd.c                                       |   28 
 drivers/net/wireless/mediatek/mt76/mt7925/init.c                                       |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                                        |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                                       |  113 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                                        |   67 
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h                                     |    9 
 drivers/net/wireless/mediatek/mt76/mt7925/nan.c                                        |  694 -
 drivers/net/wireless/mediatek/mt76/mt7925/nan.h                                        |  103 
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c                                        |    5 
 drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c                                    |    6 
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c                                        |   15 
 drivers/net/wireless/mediatek/mt76/mt792x.h                                            |   10 
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c                                        |    9 
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c                                        |   13 
 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig                                      |    1 
 drivers/net/wireless/mediatek/mt76/mt7996/coredump.c                                   |    7 
 drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c                                    |  323 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                                       |    6 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                                        |   15 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                                       |  379 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                                        |  120 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                                        |   23 
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                                     |    7 
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h                                       |   36 
 drivers/net/wireless/mediatek/mt76/scan.c                                              |  219 
 drivers/net/wireless/mediatek/mt76/tx.c                                                |    7 
 drivers/net/wireless/mediatek/mt76/usb.c                                               |   16 
 drivers/net/wireless/morsemicro/mm81x/fw.c                                             |    9 
 drivers/net/wireless/morsemicro/mm81x/mac.c                                            |   94 
 drivers/net/wireless/morsemicro/mm81x/sdio.c                                           |    9 
 drivers/net/wireless/morsemicro/mm81x/yaps_hw.c                                        |   14 
 drivers/net/wireless/nxp/nxpwifi/11ax.c                                                |    2 
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c                                            |    6 
 drivers/net/wireless/nxp/nxpwifi/main.c                                                |   10 
 drivers/net/wireless/nxp/nxpwifi/scan.c                                                |   18 
 drivers/net/wireless/nxp/nxpwifi/sdio.c                                                |    2 
 drivers/net/wireless/realtek/rtl8xxxu/core.c                                           |  154 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h                                       |    2 
 drivers/net/wireless/realtek/rtw88/debug.c                                             |    5 
 drivers/net/wireless/realtek/rtw88/sdio.c                                              |   12 
 drivers/net/wireless/realtek/rtw89/Kconfig                                             |    2 
 drivers/net/wireless/realtek/rtw89/coex.c                                              |    2 
 drivers/net/wireless/silabs/wfx/bh.c                                                   |    6 
 drivers/net/wireless/silabs/wfx/bus_sdio.c                                             |    1 
 drivers/net/wireless/silabs/wfx/main.c                                                 |   36 
 drivers/nvdimm/pmem.c                                                                  |    6 
 drivers/nvme/host/fabrics.c                                                            |   30 
 drivers/nvme/host/ioctl.c                                                              |    2 
 drivers/nvme/host/pci.c                                                                |    2 
 drivers/nvme/host/rdma.c                                                               |    2 
 drivers/nvme/host/tcp.c                                                                |   35 
 drivers/nvme/target/configfs.c                                                         |   24 
 drivers/nvme/target/core.c                                                             |   16 
 drivers/nvme/target/fabrics-cmd-auth.c                                                 |    9 
 drivers/nvme/target/fabrics-cmd.c                                                      |    3 
 drivers/nvme/target/fc.c                                                               |   15 
 drivers/nvme/target/io-cmd-bdev.c                                                      |    3 
 drivers/nvme/target/loop.c                                                             |    2 
 drivers/nvme/target/nvmet.h                                                            |    3 
 drivers/nvme/target/rdma.c                                                             |   26 
 drivers/nvme/target/tcp.c                                                              |    7 
 drivers/nvme/target/zns.c                                                              |   12 
 drivers/nvmem/layouts/onie-tlv.c                                                       |    1 
 drivers/nvmem/layouts/sl28vpd.c                                                        |    1 
 drivers/of/irq.c                                                                       |    2 
 drivers/opp/of.c                                                                       |    2 
 drivers/pci/controller/cadence/pcie-cadence-debugfs.c                                  |   15 
 drivers/pci/controller/dwc/pci-dra7xx.c                                                |   22 
 drivers/pci/controller/dwc/pci-imx6.c                                                  |   54 
 drivers/pci/controller/dwc/pcie-eswin.c                                                |    1 
 drivers/pci/controller/dwc/pcie-qcom.c                                                 |   93 
 drivers/pci/controller/dwc/pcie-rcar-gen4.c                                            |   27 
 drivers/pci/controller/pci-aardvark.c                                                  |   31 
 drivers/pci/controller/pci-xgene.c                                                     |   11 
 drivers/pci/controller/pcie-iproc-bcma.c                                               |   40 
 drivers/pci/controller/pcie-tegra264.c                                                 |    9 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                                          |  160 
 drivers/pci/hotplug/pciehp_core.c                                                      |    2 
 drivers/pci/iov.c                                                                      |   25 
 drivers/pci/p2pdma.c                                                                   |   23 
 drivers/pci/pci-acpi.c                                                                 |    3 
 drivers/pci/pci-label.c                                                                |   90 
 drivers/pci/pci.c                                                                      |   24 
 drivers/pci/pci.h                                                                      |    5 
 drivers/pci/pcie/aer.c                                                                 |   17 
 drivers/pci/pcie/aer_cxl_rch.c                                                         |    2 
 drivers/pci/pcie/err.c                                                                 |    2 
 drivers/pci/pcie/portdrv.c                                                             |    6 
 drivers/pci/pcie/portdrv.h                                                             |    2 
 drivers/pci/probe.c                                                                    |   18 
 drivers/pci/pwrctrl/core.c                                                             |   19 
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c                                               |    4 
 drivers/pci/quirks.c                                                                   |    2 
 drivers/pci/tph.c                                                                      |    6 
 drivers/pci/xen-pcifront.c                                                             |    5 
 drivers/perf/cxl_pmu.c                                                                 |  100 
 drivers/perf/dwc_pcie_pmu.c                                                            |   11 
 drivers/perf/marvell_cn10k_ddr_pmu.c                                                   |   85 
 drivers/perf/marvell_cn10k_tad_pmu.c                                                   |    1 
 drivers/phy/cadence/phy-cadence-sierra.c                                               |   11 
 drivers/phy/hisilicon/phy-hi3670-pcie.c                                                |    4 
 drivers/phy/qualcomm/Kconfig                                                           |    1 
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c                                      |  103 
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c                                     |   19 
 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c                                      |    8 
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c                                      |    8 
 drivers/phy/rockchip/phy-rockchip-usbdp.c                                              |  248 
 drivers/phy/samsung/phy-exynos5-usbdrd.c                                               |   78 
 drivers/phy/spacemit/Kconfig                                                           |    2 
 drivers/pinctrl/mediatek/pinctrl-mt7629.c                                              |    2 
 drivers/pinctrl/microchip/pinctrl-mpfs-mssio.c                                         |    2 
 drivers/pinctrl/nuvoton/pinctrl-ma35.c                                                 |    8 
 drivers/pinctrl/pinctrl-generic-mux.c                                                  |   76 
 drivers/pinctrl/sprd/pinctrl-sprd.c                                                    |    3 
 drivers/pinctrl/stm32/Kconfig                                                          |    2 
 drivers/pinctrl/stm32/pinctrl-stm32.c                                                  |   19 
 drivers/pinctrl/sunplus/Kconfig                                                        |    8 
 drivers/platform/arm64/qcom-hamoa-ec.c                                                 |   19 
 drivers/platform/chrome/cros_ec_proto.c                                                |   32 
 drivers/platform/chrome/cros_ec_proto_test.c                                           |  158 
 drivers/platform/chrome/cros_ec_typec.c                                                |  104 
 drivers/platform/cznic/turris-omnia-mcu-gpio.c                                         |   31 
 drivers/platform/olpc/olpc-ec.c                                                        |    2 
 drivers/platform/surface/surface_aggregator_registry.c                                 |    3 
 drivers/platform/x86/amd/pmc/pmc.c                                                     |    5 
 drivers/platform/x86/amd/pmf/util.c                                                    |    1 
 drivers/platform/x86/asus-armoury.c                                                    |   26 
 drivers/platform/x86/asus-wmi.c                                                        |   32 
 drivers/platform/x86/gpd-pocket-fan.c                                                  |    9 
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c                                    |    7 
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c                              |    2 
 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c                                 |    7 
 drivers/platform/x86/hp/hp-wmi.c                                                       |   23 
 drivers/platform/x86/ibm_rtl.c                                                         |    8 
 drivers/platform/x86/intel/pmc/core.h                                                  |    2 
 drivers/platform/x86/intel/pmc/nvl.c                                                   |    2 
 drivers/platform/x86/intel/pmt/class.c                                                 |    5 
 drivers/platform/x86/intel/pmt/class.h                                                 |    3 
 drivers/platform/x86/intel/pmt/discovery.c                                             |    2 
 drivers/platform/x86/intel/telemetry/core.c                                            |    4 
 drivers/platform/x86/intel/tpmi_power_domains.c                                        |    9 
 drivers/platform/x86/intel/vsec.c                                                      |   15 
 drivers/platform/x86/lenovo/ideapad-laptop.c                                           |   12 
 drivers/platform/x86/msi-ec.c                                                          |    9 
 drivers/platform/x86/msi-wmi.c                                                         |    6 
 drivers/platform/x86/topstar-laptop.c                                                  |    6 
 drivers/pmdomain/imx/scu-pd.c                                                          |   10 
 drivers/pmdomain/renesas/r8a78000-mdlc.c                                               |    6 
 drivers/power/sequencing/pwrseq-pcie-m2.c                                              |    2 
 drivers/power/supply/ab8500_bmdata.c                                                   |    2 
 drivers/power/supply/ab8500_btemp.c                                                    |   28 
 drivers/power/supply/ab8500_chargalg.c                                                 |    9 
 drivers/power/supply/ab8500_charger.c                                                  |  400 
 drivers/power/supply/ab8500_fg.c                                                       |   27 
 drivers/power/supply/bq24190_charger.c                                                 |   39 
 drivers/power/supply/bq2515x_charger.c                                                 |   15 
 drivers/power/supply/bq257xx_charger.c                                                 |    2 
 drivers/power/supply/generic-adc-battery.c                                             |    3 
 drivers/power/supply/gpio-charger.c                                                    |    5 
 drivers/power/supply/mm8013.c                                                          |    1 
 drivers/power/supply/qcom_battmgr.c                                                    |   21 
 drivers/power/supply/s2mu005-battery.c                                                 |    4 
 drivers/pps/generators/pps_gen.c                                                       |   10 
 drivers/ptp/ptp_qoriq.c                                                                |    1 
 drivers/pwm/core.c                                                                     |    1 
 drivers/pwm/pwm-ipq.c                                                                  |    2 
 drivers/pwm/pwm-loongson.c                                                             |    2 
 drivers/pwm/pwm-lp3943.c                                                               |    3 
 drivers/pwm/pwm-mtk-disp.c                                                             |    4 
 drivers/pwm/pwm-renesas-tpu.c                                                          |   23 
 drivers/regulator/ab8500.c                                                             |  158 
 drivers/regulator/fixed.c                                                              |    4 
 drivers/regulator/irq_helpers.c                                                        |   38 
 drivers/regulator/mp886x.c                                                             |   13 
 drivers/regulator/pf1550-regulator.c                                                   |   19 
 drivers/regulator/qcom-rpmh-regulator.c                                                |    2 
 drivers/remoteproc/imx_dsp_rproc.c                                                     |    7 
 drivers/remoteproc/imx_rproc.c                                                         |   18 
 drivers/remoteproc/qcom_q6v5_adsp.c                                                    |    2 
 drivers/remoteproc/remoteproc_core.c                                                   |    3 
 drivers/remoteproc/xlnx_r5_remoteproc.c                                                |    8 
 drivers/resctrl/mpam_devices.c                                                         |  122 
 drivers/resctrl/mpam_resctrl.c                                                         |   13 
 drivers/rpmsg/mtk_rpmsg.c                                                              |    1 
 drivers/rpmsg/virtio_rpmsg_bus.c                                                       |    5 
 drivers/rtc/Kconfig                                                                    |   21 
 drivers/rtc/class.c                                                                    |    8 
 drivers/rtc/rtc-abx80x.c                                                               |  103 
 drivers/rtc/rtc-bd70528.c                                                              |    5 
 drivers/rtc/rtc-ds1685.c                                                               |   20 
 drivers/rtc/rtc-ftrtc010.c                                                             |   74 
 drivers/rtc/rtc-mpfs.c                                                                 |    4 
 drivers/rtc/rtc-s35390a.c                                                              |  109 
 drivers/s390/net/ism_drv.c                                                             |    3 
 drivers/s390/virtio/virtio_ccw.c                                                       |    6 
 drivers/scsi/ch.c                                                                      |    2 
 drivers/scsi/device_handler/scsi_dh_hp_sw.c                                            |    4 
 drivers/scsi/device_handler/scsi_dh_rdac.c                                             |   10 
 drivers/scsi/elx/libefc/efclib.c                                                       |    2 
 drivers/scsi/hisi_sas/hisi_sas.h                                                       |    3 
 drivers/scsi/hisi_sas/hisi_sas_main.c                                                  |   43 
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c                                                 |    4 
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c                                                 |    4 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                                 |   13 
 drivers/scsi/libsas/sas_task.c                                                         |    2 
 drivers/scsi/mpi3mr/mpi3mr_app.c                                                       |   43 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                                        |   17 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                                        |   95 
 drivers/scsi/mpi3mr/mpi3mr_transport.c                                                 |    7 
 drivers/scsi/pm8001/pm8001_defs.h                                                      |   98 
 drivers/scsi/pm8001/pm8001_hwi.c                                                       |    2 
 drivers/scsi/pm8001/pm8001_hwi.h                                                       |    4 
 drivers/scsi/pm8001/pm80xx_hwi.c                                                       |    2 
 drivers/scsi/pm8001/pm80xx_hwi.h                                                       |  100 
 drivers/scsi/scsi_debug.c                                                              |  409 
 drivers/scsi/scsi_lib.c                                                                |    6 
 drivers/scsi/scsi_lib_test.c                                                           |   25 
 drivers/scsi/scsi_scan.c                                                               |    8 
 drivers/scsi/scsi_transport_spi.c                                                      |    2 
 drivers/scsi/sd.c                                                                      |   20 
 drivers/scsi/ses.c                                                                     |    8 
 drivers/scsi/st.c                                                                      |   75 
 drivers/soc/microchip/mpfs-sys-controller.c                                            |    7 
 drivers/soc/qcom/apr.c                                                                 |   44 
 drivers/soc/qcom/pmic_glink.c                                                          |    3 
 drivers/soc/qcom/pmic_pdcharger_ulog.c                                                 |    2 
 drivers/soc/qcom/qcom-geni-se.c                                                        |   14 
 drivers/soc/qcom/smem_dramc.c                                                          |   17 
 drivers/soc/tegra/flowctrl.c                                                           |    7 
 drivers/soundwire/debugfs.c                                                            |   63 
 drivers/soundwire/intel_auxdevice.c                                                    |    2 
 drivers/spi/spi-amlogic-spisg.c                                                        |   43 
 drivers/spi/spi-axi-spi-engine.c                                                       |   20 
 drivers/spi/spi-bcm63xx-hsspi.c                                                        |    1 
 drivers/spi/spi-cs42l43.c                                                              |    8 
 drivers/spi/spi-fsl-spi.c                                                              |    8 
 drivers/spi/spi-ma35d1-qspi.c                                                          |   27 
 drivers/spi/spi-meson-spicc.c                                                          |   11 
 drivers/spi/spi-mtk-nor.c                                                              |    1 
 drivers/spi/spi-mxic.c                                                                 |    8 
 drivers/spi/spi-omap2-mcspi.c                                                          |  238 
 drivers/spi/spi-qpic-snand.c                                                           |   30 
 drivers/spi/spi-rockchip-sfc.c                                                         |   21 
 drivers/spi/spi-rspi.c                                                                 |   49 
 drivers/spi/spi-sh-msiof.c                                                             |    5 
 drivers/spi/spi-sun4i.c                                                                |   56 
 drivers/spi/spi-tegra114.c                                                             |   49 
 drivers/spi/spi-virtio.c                                                               |    4 
 drivers/spi/spi.c                                                                      |    2 
 drivers/spmi/spmi-mtk-pmif.c                                                           |   42 
 drivers/spmi/spmi-pmic-arb.c                                                           |    2 
 drivers/staging/iio/adc/ad7816.c                                                       |   33 
 drivers/staging/media/ipu7/ipu7-isys.c                                                 |    1 
 drivers/staging/media/tegra-video/tegra20.c                                            |    7 
 drivers/staging/octeon/ethernet-tx.c                                                   |    2 
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c                                           |    4 
 drivers/staging/sm750fb/sm750.c                                                        |   10 
 drivers/thermal/airoha_thermal.c                                                       |   34 
 drivers/thermal/amlogic_thermal.c                                                      |   14 
 drivers/thermal/gov_power_allocator.c                                                  |    7 
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c                                            |    8 
 drivers/thermal/renesas/rzg3e_thermal.c                                                |   38 
 drivers/thermal/sprd_thermal.c                                                         |    6 
 drivers/thermal/thermal_trace.h                                                        |    4 
 drivers/thermal/ti-soc-thermal/ti-bandgap.c                                            |   10 
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c                                     |    4 
 drivers/tty/serial/8250/8250.h                                                         |   11 
 drivers/tty/serial/8250/8250_hub6.c                                                    |   11 
 drivers/tty/serial/8250/8250_mid.c                                                     |   16 
 drivers/tty/serial/8250/8250_mxpcie.c                                                  |   30 
 drivers/tty/serial/8250/8250_platform.c                                                |    9 
 drivers/tty/serial/8250/8250_port.c                                                    |   13 
 drivers/tty/serial/8250/8250_uniphier.c                                                |   10 
 drivers/tty/serial/8250/Kconfig                                                        |    4 
 drivers/tty/serial/8250/Makefile                                                       |    2 
 drivers/tty/serial/Kconfig                                                             |    1 
 drivers/tty/serial/ma35d1_serial.c                                                     |    2 
 drivers/tty/serial/max310x.c                                                           |  632 +
 drivers/tty/serial/pmac_zilog.c                                                        |    1 
 drivers/tty/serial/qcom_geni_serial.c                                                  |    6 
 drivers/tty/serial/serial_txx9.c                                                       |   55 
 drivers/tty/serial/sh-sci.c                                                            |    8 
 drivers/tty/serial/sifive.c                                                            |    2 
 drivers/ufs/core/ufshcd.c                                                              |   40 
 drivers/ufs/host/ufs-exynos.c                                                          |    4 
 drivers/ufs/host/ufs-mediatek.c                                                        |   16 
 drivers/ufs/host/ufs-qcom.c                                                            |    5 
 drivers/ufs/host/ufshcd-pci.c                                                          |    3 
 drivers/usb/gadget/composite.c                                                         |    2 
 drivers/usb/gadget/function/f_mass_storage.c                                           |    7 
 drivers/usb/gadget/udc/dummy_hcd.c                                                     |    4 
 drivers/usb/host/pci-quirks.c                                                          |    1 
 drivers/usb/host/xhci-dbgtty.c                                                         |    2 
 drivers/usb/image/microtek.c                                                           |    1 
 drivers/usb/mon/mon_main.c                                                             |    3 
 drivers/usb/musb/da8xx.c                                                               |    8 
 drivers/usb/storage/alauda.c                                                           |   95 
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c                                                   |    9 
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c                                                   |    9 
 drivers/vfio/cdx/main.c                                                                |   10 
 drivers/vfio/device_cdev.c                                                             |   12 
 drivers/vfio/fsl-mc/vfio_fsl_mc.c                                                      |   10 
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c                                         |   73 
 drivers/vfio/pci/ism/main.c                                                            |   19 
 drivers/vfio/pci/mlx5/main.c                                                           |   13 
 drivers/vfio/pci/nvgrace-gpu/main.c                                                    |   19 
 drivers/vfio/pci/pds/pci_drv.c                                                         |    8 
 drivers/vfio/pci/pds/vfio_dev.c                                                        |    5 
 drivers/vfio/pci/qat/main.c                                                            |   12 
 drivers/vfio/pci/vfio_pci.c                                                            |   33 
 drivers/vfio/pci/vfio_pci_core.c                                                       |   37 
 drivers/vfio/pci/virtio/main.c                                                         |    8 
 drivers/vfio/pci/xe/main.c                                                             |    8 
 drivers/vfio/platform/vfio_platform_common.c                                           |   10 
 drivers/vfio/vfio_main.c                                                               |    7 
 drivers/vhost/vringh.c                                                                 |    4 
 drivers/video/fbdev/atafb.c                                                            |   28 
 drivers/video/fbdev/gxt4500.c                                                          |    1 
 drivers/virtio/virtio.c                                                                |    2 
 drivers/virtio/virtio_pci_modern.c                                                     |   12 
 fs/btrfs/accessors.c                                                                   |    2 
 fs/btrfs/bio.c                                                                         |  141 
 fs/btrfs/bio.h                                                                         |    5 
 fs/btrfs/block-group.c                                                                 |    6 
 fs/btrfs/btrfs_inode.h                                                                 |   12 
 fs/btrfs/ctree.h                                                                       |    2 
 fs/btrfs/defrag.c                                                                      |    2 
 fs/btrfs/disk-io.c                                                                     |   31 
 fs/btrfs/extent-tree.c                                                                 |    3 
 fs/btrfs/file-item.c                                                                   |   19 
 fs/btrfs/free-space-cache.c                                                            |   10 
 fs/btrfs/inode.c                                                                       |  118 
 fs/btrfs/messages.c                                                                    |    9 
 fs/btrfs/qgroup.c                                                                      |    4 
 fs/btrfs/raid56.c                                                                      |   57 
 fs/btrfs/tree-mod-log.c                                                                |   13 
 fs/btrfs/verity.c                                                                      |   31 
 fs/btrfs/volumes.c                                                                     |   37 
 fs/btrfs/zoned.c                                                                       |    8 
 fs/ceph/addr.c                                                                         |   67 
 fs/ceph/inode.c                                                                        |    2 
 fs/ceph/super.c                                                                        |   18 
 fs/ceph/super.h                                                                        |    1 
 fs/dcache.c                                                                            |    2 
 fs/debugfs/file.c                                                                      |   81 
 fs/dlm/config.c                                                                        |   39 
 fs/dlm/dlm_internal.h                                                                  |    5 
 fs/dlm/lock.c                                                                          |   18 
 fs/dlm/lock.h                                                                          |    4 
 fs/dlm/member.c                                                                        |   17 
 fs/erofs/data.c                                                                        |    5 
 fs/erofs/internal.h                                                                    |    1 
 fs/erofs/super.c                                                                       |   63 
 fs/eventpoll.c                                                                         |   18 
 fs/exfat/fatent.c                                                                      |   46 
 fs/ext2/file.c                                                                         |    7 
 fs/ext4/inode.c                                                                        |    3 
 fs/f2fs/checkpoint.c                                                                   |   14 
 fs/f2fs/gc.c                                                                           |    6 
 fs/f2fs/inode.c                                                                        |    4 
 fs/f2fs/node.c                                                                         |    4 
 fs/f2fs/segment.c                                                                      |    2 
 fs/f2fs/segment.h                                                                      |   11 
 fs/f2fs/super.c                                                                        |   48 
 fs/fs-writeback.c                                                                      |   20 
 fs/fs_pin.c                                                                            |   15 
 fs/fuse/dev.c                                                                          |  105 
 fs/fuse/dev.h                                                                          |    2 
 fs/fuse/file.c                                                                         |    7 
 fs/fuse/notify.c                                                                       |    2 
 fs/fuse/req.c                                                                          |    7 
 fs/gfs2/bmap.c                                                                         |    2 
 fs/gfs2/inode.c                                                                        |    2 
 fs/hfs/btree.c                                                                         |    7 
 fs/hfsplus/btree.c                                                                     |    7 
 fs/hugetlbfs/inode.c                                                                   |    5 
 fs/internal.h                                                                          |    1 
 fs/iomap/bio.c                                                                         |    4 
 fs/iomap/direct-io.c                                                                   |   21 
 fs/iomap/ioend.c                                                                       |   14 
 fs/isofs/dir.c                                                                         |    4 
 fs/isofs/isofs.h                                                                       |   11 
 fs/isofs/joliet.c                                                                      |   27 
 fs/isofs/namei.c                                                                       |    3 
 fs/kernfs/dir.c                                                                        |   65 
 fs/kernfs/file.c                                                                       |   25 
 fs/kernfs/symlink.c                                                                    |   17 
 fs/minix/namei.c                                                                       |    4 
 fs/namei.c                                                                             |   10 
 fs/namespace.c                                                                         |    2 
 fs/netfs/internal.h                                                                    |   32 
 fs/nfs/client.c                                                                        |    2 
 fs/nfs/dir.c                                                                           |   13 
 fs/nfs/filelayout/filelayout.c                                                         |    5 
 fs/nfs/flexfilelayout/flexfilelayout.c                                                 |   81 
 fs/nfs/fs_context.c                                                                    |    1 
 fs/nfs/internal.h                                                                      |   31 
 fs/nfs/nfs3proc.c                                                                      |    8 
 fs/nfs/nfs4client.c                                                                    |    7 
 fs/nfs/nfs4proc.c                                                                      |    5 
 fs/nfs/nfs4xdr.c                                                                       |    3 
 fs/nfs/pnfs.c                                                                          |   12 
 fs/nfs/proc.c                                                                          |    8 
 fs/nfs_common/nfslocalio.c                                                             |  101 
 fs/nilfs2/namei.c                                                                      |    8 
 fs/nilfs2/recovery.c                                                                   |   17 
 fs/nsfs.c                                                                              |    4 
 fs/ntfs/aops.c                                                                         |    7 
 fs/ntfs/attrib.c                                                                       |   10 
 fs/ntfs/attrlist.c                                                                     |    9 
 fs/ntfs/bitmap.c                                                                       |   19 
 fs/ntfs/collate.c                                                                      |    2 
 fs/ntfs/compress.c                                                                     |    4 
 fs/ntfs/dir.c                                                                          |   15 
 fs/ntfs/ea.c                                                                           |    2 
 fs/ntfs/file.c                                                                         |   22 
 fs/ntfs/index.c                                                                        |   27 
 fs/ntfs/inode.c                                                                        |  132 
 fs/ntfs/layout.h                                                                       |   13 
 fs/ntfs/lcnalloc.c                                                                     |   35 
 fs/ntfs/logfile.c                                                                      |    2 
 fs/ntfs/mft.c                                                                          |   14 
 fs/ntfs/mst.c                                                                          |    4 
 fs/ntfs/reparse.c                                                                      |    2 
 fs/ntfs/runlist.c                                                                      |    5 
 fs/ntfs3/attrib.c                                                                      |   10 
 fs/ntfs3/dir.c                                                                         |   56 
 fs/ntfs3/file.c                                                                        |    3 
 fs/ntfs3/frecord.c                                                                     |   11 
 fs/ntfs3/fsntfs.c                                                                      |    3 
 fs/ntfs3/index.c                                                                       |   19 
 fs/ntfs3/inode.c                                                                       |    9 
 fs/ntfs3/xattr.c                                                                       |    8 
 fs/ocfs2/cluster/heartbeat.c                                                           |   52 
 fs/ocfs2/cluster/tcp.c                                                                 |    8 
 fs/ocfs2/dlmglue.c                                                                     |   29 
 fs/ocfs2/dlmglue.h                                                                     |    5 
 fs/ocfs2/export.c                                                                      |   10 
 fs/ocfs2/inode.c                                                                       |    5 
 fs/ocfs2/namei.c                                                                       |    6 
 fs/ocfs2/ocfs2.h                                                                       |    5 
 fs/ocfs2/quota_local.c                                                                 |   24 
 fs/ocfs2/suballoc.c                                                                    |  202 
 fs/ocfs2/suballoc.h                                                                    |    2 
 fs/ocfs2/super.c                                                                       |   16 
 fs/ocfs2/xattr.c                                                                       |  319 
 fs/ocfs2/xattr.h                                                                       |   12 
 fs/overlayfs/readdir.c                                                                 |   54 
 fs/pidfs.c                                                                             |    8 
 fs/proc/base.c                                                                         |    8 
 fs/proc/internal.h                                                                     |    1 
 fs/proc/kcore.c                                                                        |    8 
 fs/proc/task_mmu.c                                                                     |    9 
 fs/pstore/ram.c                                                                        |    1 
 fs/pstore/ram_core.c                                                                   |    6 
 fs/quota/dquot.c                                                                       |   10 
 fs/resctrl/rdtgroup.c                                                                  |    2 
 fs/smb/client/connect.c                                                                |    6 
 fs/smb/server/Kconfig                                                                  |    1 
 fs/smb/server/connection.c                                                             |    2 
 fs/smb/server/connection.h                                                             |    3 
 fs/smb/server/ksmbd_work.h                                                             |    9 
 fs/smb/server/mgmt/share_config.c                                                      |   43 
 fs/smb/server/mgmt/share_config.h                                                      |    2 
 fs/smb/server/mgmt/user_session.c                                                      |  132 
 fs/smb/server/mgmt/user_session.h                                                      |   18 
 fs/smb/server/oplock.c                                                                 |   46 
 fs/smb/server/oplock.h                                                                 |    3 
 fs/smb/server/server.c                                                                 |    8 
 fs/smb/server/smb2pdu.c                                                                |  838 +
 fs/smb/server/smb2pdu.h                                                                |    1 
 fs/smb/server/smb_common.c                                                             |    4 
 fs/smb/server/transport_ipc.c                                                          |   45 
 fs/smb/server/transport_ipc.h                                                          |   14 
 fs/smb/server/transport_tcp.c                                                          |    8 
 fs/smb/server/vfs.c                                                                    |    9 
 fs/smb/server/vfs_cache.c                                                              |   31 
 fs/smb/smbdirect/accept.c                                                              |    2 
 fs/smb/smbdirect/connect.c                                                             |    2 
 fs/smb/smbdirect/connection.c                                                          |    2 
 fs/splice.c                                                                            |   43 
 fs/super.c                                                                             |  355 
 fs/xattr.c                                                                             |    2 
 include/acpi/acpi_bus.h                                                                |    2 
 include/acpi/ghes.h                                                                    |    4 
 include/asm-generic/mshyperv.h                                                         |    2 
 include/asm-generic/vmlinux.lds.h                                                      |    2 
 include/cxl/event.h                                                                    |    4 
 include/drm/drm_timeout.h                                                              |   17 
 include/drm/drm_utils.h                                                                |    2 
 include/dt-bindings/clock/qcom,nord-nwgcc.h                                            |    3 
 include/linux/acpi.h                                                                   |   24 
 include/linux/bio-integrity.h                                                          |    3 
 include/linux/blk-mq.h                                                                 |    9 
 include/linux/blkdev.h                                                                 |    7 
 include/linux/bpf.h                                                                    |   49 
 include/linux/bpf_local_storage.h                                                      |   13 
 include/linux/bpf_verifier.h                                                           |  115 
 include/linux/btf.h                                                                    |    1 
 include/linux/clk-provider.h                                                           |   22 
 include/linux/dax.h                                                                    |    3 
 include/linux/device.h                                                                 |    1 
 include/linux/dibs.h                                                                   |    6 
 include/linux/dma-fence.h                                                              |    2 
 include/linux/etherdevice.h                                                            |   28 
 include/linux/firewire.h                                                               |    1 
 include/linux/fortify-string.h                                                         |    2 
 include/linux/fs/super_types.h                                                         |   11 
 include/linux/fs_context.h                                                             |    4 
 include/linux/ftrace.h                                                                 |    1 
 include/linux/hrtimer.h                                                                |   24 
 include/linux/i3c/master.h                                                             |    3 
 include/linux/iomap.h                                                                  |   11 
 include/linux/kernel_stat.h                                                            |    7 
 include/linux/kexec.h                                                                  |    2 
 include/linux/leds.h                                                                   |   10 
 include/linux/mfd/da9150/core.h                                                        |    1 
 include/linux/mm.h                                                                     |  166 
 include/linux/mm_types.h                                                               |   12 
 include/linux/mmap_lock.h                                                              |   54 
 include/linux/mtd/spinand.h                                                            |    2 
 include/linux/netdevice.h                                                              |    7 
 include/linux/nfslocalio.h                                                             |   12 
 include/linux/pci.h                                                                    |    2 
 include/linux/platform_data/dmtimer-omap.h                                             |    2 
 include/linux/platform_data/mipi-i3c-hci.h                                             |    4 
 include/linux/platform_data/x86/asus-wmi.h                                             |    3 
 include/linux/ppp_channel.h                                                            |    1 
 include/linux/quotaops.h                                                               |    5 
 include/linux/rcuref.h                                                                 |    2 
 include/linux/sched.h                                                                  |    5 
 include/linux/sched/ext.h                                                              |    1 
 include/linux/seq_buf.h                                                                |    4 
 include/linux/skbuff.h                                                                 |   12 
 include/linux/soc/ti/k3-ringacc.h                                                      |   31 
 include/linux/sunrpc/svc_rdma.h                                                        |    2 
 include/linux/trace_seq.h                                                              |    5 
 include/linux/userfaultfd_k.h                                                          |   16 
 include/linux/vfio_pci_core.h                                                          |   41 
 include/linux/watch_queue.h                                                            |    6 
 include/net/bluetooth/bluetooth.h                                                      |    4 
 include/net/bluetooth/hci.h                                                            |    1 
 include/net/bluetooth/hci_h4.h                                                         |   60 
 include/net/bluetooth/hci_sync.h                                                       |    1 
 include/net/bluetooth/l2cap.h                                                          |   22 
 include/net/cfg80211.h                                                                 |   36 
 include/net/cipso_ipv4.h                                                               |   11 
 include/net/ip.h                                                                       |    2 
 include/net/ip_vs.h                                                                    |   50 
 include/net/mac80211.h                                                                 |    2 
 include/net/mana/gdma.h                                                                |  121 
 include/net/mana/mana.h                                                                |    1 
 include/net/netfilter/nf_conntrack_seqadj.h                                            |    1 
 include/net/netlabel.h                                                                 |   11 
 include/net/netns/netfilter.h                                                          |    2 
 include/net/seg6_hmac.h                                                                |    3 
 include/net/xsk_buff_pool.h                                                            |    3 
 include/scsi/scsi_cmnd.h                                                               |    7 
 include/scsi/scsi_common.h                                                             |   31 
 include/scsi/scsi_device.h                                                             |   37 
 include/scsi/scsi_proto.h                                                              |   20 
 include/scsi/scsi_sense.h                                                              |  950 +
 include/sound/aw88399.h                                                                |    5 
 include/sound/control.h                                                                |    4 
 include/sound/core.h                                                                   |    4 
 include/sound/hda_codec.h                                                              |    6 
 include/sound/hdaudio.h                                                                |    2 
 include/sound/pcm.h                                                                    |    2 
 include/sound/pcm_oss.h                                                                |    1 
 include/sound/sdca_class.h                                                             |   49 
 include/sound/soc-component.h                                                          |    2 
 include/sound/ump.h                                                                    |    5 
 include/trace/events/iocost.h                                                          |    7 
 include/trace/events/power.h                                                           |    3 
 include/trace/events/rxrpc.h                                                           |    2 
 include/uapi/drm/panfrost_drm.h                                                        |   29 
 include/uapi/linux/amd-pmf.h                                                           |    3 
 include/uapi/linux/firewire-cdev.h                                                     |    4 
 include/uapi/linux/iommufd.h                                                           |    2 
 include/uapi/linux/nl80211.h                                                           |   31 
 include/ufs/ufshcd.h                                                                   |    8 
 include/vdso/math64.h                                                                  |   20 
 init/do_mounts.c                                                                       |   10 
 init/main.c                                                                            |    8 
 kernel/bpf/arena.c                                                                     |  408 
 kernel/bpf/arraymap.c                                                                  |    8 
 kernel/bpf/backtrack.c                                                                 |   18 
 kernel/bpf/bpf_insn_array.c                                                            |   15 
 kernel/bpf/bpf_iter.c                                                                  |   24 
 kernel/bpf/bpf_local_storage.c                                                         |   51 
 kernel/bpf/bpf_lsm.c                                                                   |    4 
 kernel/bpf/btf.c                                                                       |   40 
 kernel/bpf/cfg.c                                                                       |  111 
 kernel/bpf/const_fold.c                                                                |    2 
 kernel/bpf/core.c                                                                      |   56 
 kernel/bpf/cpumap.c                                                                    |   35 
 kernel/bpf/devmap.c                                                                    |    1 
 kernel/bpf/diagnostics.c                                                               |   37 
 kernel/bpf/fixups.c                                                                    |  135 
 kernel/bpf/hashtab.c                                                                   |   32 
 kernel/bpf/helpers.c                                                                   |   74 
 kernel/bpf/liveness.c                                                                  |  580 -
 kernel/bpf/log.c                                                                       |   13 
 kernel/bpf/map_in_map.c                                                                |    7 
 kernel/bpf/offload.c                                                                   |   25 
 kernel/bpf/states.c                                                                    |  109 
 kernel/bpf/stream.c                                                                    |   66 
 kernel/bpf/syscall.c                                                                   |   92 
 kernel/bpf/task_iter.c                                                                 |   12 
 kernel/bpf/token.c                                                                     |    5 
 kernel/bpf/trampoline.c                                                                |   29 
 kernel/bpf/verifier.c                                                                  |  590 -
 kernel/cgroup/cgroup-internal.h                                                        |    2 
 kernel/cgroup/cgroup-v1.c                                                              |   16 
 kernel/cgroup/cgroup.c                                                                 |   98 
 kernel/cgroup/cpuset-internal.h                                                        |    6 
 kernel/cgroup/cpuset.c                                                                 |  502 -
 kernel/cgroup/debug.c                                                                  |   10 
 kernel/cgroup/dmem.c                                                                   |    4 
 kernel/debug/kdb/kdb_io.c                                                              |    1 
 kernel/debug/kdb/kdb_main.c                                                            |    7 
 kernel/debug/kdb/kdb_private.h                                                         |    3 
 kernel/dma/debug.c                                                                     |    7 
 kernel/dma/direct.c                                                                    |   22 
 kernel/events/core.c                                                                   |    3 
 kernel/fork.c                                                                          |   12 
 kernel/kcov.c                                                                          |   35 
 kernel/kexec_core.c                                                                    |    7 
 kernel/kexec_file.c                                                                    |    4 
 kernel/kthread.c                                                                       |    2 
 kernel/module/tracking.c                                                               |    2 
 kernel/nsproxy.c                                                                       |    2 
 kernel/power/suspend.c                                                                 |   20 
 kernel/profile.c                                                                       |    2 
 kernel/rcu/rcutorture.c                                                                |    2 
 kernel/rcu/srcutree.c                                                                  |    7 
 kernel/rcu/tree_nocb.h                                                                 |    3 
 kernel/reboot.c                                                                        |    4 
 kernel/resource_kunit.c                                                                |    3 
 kernel/sched/core.c                                                                    |   37 
 kernel/sched/cputime.c                                                                 |   44 
 kernel/sched/deadline.c                                                                |    7 
 kernel/sched/ext/cid.c                                                                 |    6 
 kernel/sched/ext/ext.c                                                                 |  459 
 kernel/sched/ext/ext.h                                                                 |    7 
 kernel/sched/ext/inlines.h                                                             |   15 
 kernel/sched/ext/internal.h                                                            |   86 
 kernel/sched/ext/sub.c                                                                 |  320 
 kernel/sched/ext/sub.h                                                                 |   12 
 kernel/sched/fair.c                                                                    |   29 
 kernel/sched/idle.c                                                                    |   21 
 kernel/sched/rt.c                                                                      |    7 
 kernel/sched/sched.h                                                                   |   20 
 kernel/sched/stop_task.c                                                               |    5 
 kernel/signal.c                                                                        |    5 
 kernel/time/hrtimer.c                                                                  |    8 
 kernel/time/tick-sched.c                                                               |   22 
 kernel/time/timeconv.c                                                                 |    6 
 kernel/time/timer.c                                                                    |    2 
 kernel/time/vsyscall.c                                                                 |   26 
 kernel/trace/bpf_trace.c                                                               |   29 
 kernel/trace/rv/monitors/wakeup/wakeup.c                                               |    6 
 kernel/trace/rv/rv_reactors.c                                                          |   10 
 kernel/trace/trace.h                                                                   |    3 
 kernel/trace/trace_btf.c                                                               |    3 
 kernel/trace/trace_events_hist.c                                                       |   25 
 kernel/ucount.c                                                                        |    7 
 kernel/watch_queue.c                                                                   |    2 
 kernel/watchdog_perf.c                                                                 |    4 
 lib/Kconfig.debug                                                                      |    1 
 lib/bitmap-str.c                                                                       |   24 
 lib/decompress_unlz4.c                                                                 |    4 
 lib/kobject.c                                                                          |    2 
 lib/maple_tree.c                                                                       |   43 
 lib/region_alloc_benchmark.c                                                           |    8 
 lib/seq_buf.c                                                                          |    2 
 lib/test_hmm.c                                                                         |    2 
 lib/test_sysctl.c                                                                      |    2 
 lib/tests/seq_buf_kunit.c                                                              |  174 
 lib/vdso/gettimeofday.c                                                                |    4 
 mm/gup.c                                                                               |   17 
 mm/gup_test.c                                                                          |   11 
 mm/hugetlb.c                                                                           |    1 
 mm/madvise.c                                                                           |   10 
 mm/memblock.c                                                                          |    9 
 mm/memory_hotplug.c                                                                    |    6 
 mm/mlock.c                                                                             |    6 
 mm/mmap_lock.c                                                                         |  150 
 mm/mprotect.c                                                                          |    2 
 mm/shmem.c                                                                             |   22 
 mm/slab_common.c                                                                       |    4 
 mm/slub.c                                                                              |    1 
 mm/userfaultfd.c                                                                       |   23 
 mm/vma.c                                                                               |   77 
 net/9p/trans_xen.c                                                                     |    4 
 net/Kconfig                                                                            |    1 
 net/bluetooth/6lowpan.c                                                                |   45 
 net/bluetooth/Makefile                                                                 |    2 
 net/bluetooth/hci_core.c                                                               |    4 
 net/bluetooth/hci_event.c                                                              |  104 
 net/bluetooth/hci_h4.c                                                                 |  160 
 net/bluetooth/hci_sync.c                                                               |   66 
 net/bluetooth/iso.c                                                                    |    3 
 net/bluetooth/l2cap_core.c                                                             |  114 
 net/bluetooth/l2cap_sock.c                                                             |   88 
 net/bluetooth/mgmt.c                                                                   |  122 
 net/bluetooth/msft.c                                                                   |    6 
 net/bpf/test_run.c                                                                     |   27 
 net/bridge/br_mdb.c                                                                    |   16 
 net/bridge/br_multicast.c                                                              |    9 
 net/bridge/br_netlink.c                                                                |    2 
 net/bridge/br_private.h                                                                |    1 
 net/ceph/messenger_v1.c                                                                |    8 
 net/core/bpf_ksock.c                                                                   |    7 
 net/core/bpf_sk_storage.c                                                              |   79 
 net/core/dev.c                                                                         |   48 
 net/core/dev.h                                                                         |    1 
 net/core/devmem.c                                                                      |  174 
 net/core/devmem.h                                                                      |   41 
 net/core/filter.c                                                                      |   71 
 net/core/gro.c                                                                         |    5 
 net/core/net-sysfs.c                                                                   |    7 
 net/core/netdev-genl.c                                                                 |   11 
 net/core/selftests.c                                                                   |    2 
 net/core/skbuff.c                                                                      |   11 
 net/core/sock.c                                                                        |    3 
 net/core/sysctl_net_core.c                                                             |    7 
 net/dcb/dcbnl.c                                                                        |    2 
 net/devlink/region.c                                                                   |    5 
 net/ethtool/ioctl.c                                                                    |    7 
 net/ipv4/cipso_ipv4.c                                                                  |   16 
 net/ipv4/devinet.c                                                                     |   35 
 net/ipv4/gre_offload.c                                                                 |    2 
 net/ipv4/inet_connection_sock.c                                                        |    3 
 net/ipv4/inet_fragment.c                                                               |   61 
 net/ipv4/ip_fragment.c                                                                 |   13 
 net/ipv4/ip_output.c                                                                   |   15 
 net/ipv4/ip_tunnel.c                                                                   |   14 
 net/ipv4/ipmr.c                                                                        |    5 
 net/ipv4/syncookies.c                                                                  |   12 
 net/ipv4/tcp.c                                                                         |   26 
 net/ipv4/tcp_bic.c                                                                     |   14 
 net/ipv4/tcp_bpf.c                                                                     |    1 
 net/ipv4/tcp_cubic.c                                                                   |   14 
 net/ipv4/tcp_hybla.c                                                                   |   16 
 net/ipv4/tcp_ipv4.c                                                                    |   17 
 net/ipv4/tcp_metrics.c                                                                 |   20 
 net/ipv4/tcp_offload.c                                                                 |   12 
 net/ipv6/calipso.c                                                                     |    6 
 net/ipv6/exthdrs.c                                                                     |    2 
 net/ipv6/ip6_fib.c                                                                     |    4 
 net/ipv6/ip6mr.c                                                                       |    6 
 net/ipv6/netfilter/nf_conntrack_reasm.c                                                |   15 
 net/ipv6/reassembly.c                                                                  |   13 
 net/ipv6/route.c                                                                       |   37 
 net/ipv6/seg6_hmac.c                                                                   |    5 
 net/ipv6/seg6_local.c                                                                  |    6 
 net/ipv6/sit.c                                                                         |    6 
 net/ipv6/tcp_ipv6.c                                                                    |    9 
 net/mac80211/cfg.c                                                                     |   62 
 net/mac80211/debugfs.c                                                                 |    2 
 net/mac80211/ieee80211_i.h                                                             |    6 
 net/mac80211/main.c                                                                    |    2 
 net/mac80211/mesh_pathtbl.c                                                            |   17 
 net/mac80211/mlme.c                                                                    |   14 
 net/mac80211/nan.c                                                                     |   33 
 net/mac80211/rate.c                                                                    |    1 
 net/mac80211/rx.c                                                                      |    1 
 net/mac80211/s1g.c                                                                     |    8 
 net/mac80211/tx.c                                                                      |  216 
 net/mctp/route.c                                                                       |   10 
 net/mptcp/options.c                                                                    |    9 
 net/netfilter/core.c                                                                   |   18 
 net/netfilter/ipvs/ip_vs_conn.c                                                        |    8 
 net/netfilter/ipvs/ip_vs_ctl.c                                                         |   38 
 net/netfilter/ipvs/ip_vs_dh.c                                                          |   16 
 net/netfilter/ipvs/ip_vs_fo.c                                                          |    2 
 net/netfilter/ipvs/ip_vs_lblc.c                                                        |    4 
 net/netfilter/ipvs/ip_vs_lblcr.c                                                       |    8 
 net/netfilter/ipvs/ip_vs_lc.c                                                          |    2 
 net/netfilter/ipvs/ip_vs_mh.c                                                          |    2 
 net/netfilter/ipvs/ip_vs_nq.c                                                          |    2 
 net/netfilter/ipvs/ip_vs_ovf.c                                                         |    2 
 net/netfilter/ipvs/ip_vs_rr.c                                                          |    2 
 net/netfilter/ipvs/ip_vs_sed.c                                                         |    4 
 net/netfilter/ipvs/ip_vs_sh.c                                                          |    2 
 net/netfilter/ipvs/ip_vs_sync.c                                                        |   23 
 net/netfilter/ipvs/ip_vs_twos.c                                                        |    4 
 net/netfilter/ipvs/ip_vs_wlc.c                                                         |    4 
 net/netfilter/ipvs/ip_vs_wrr.c                                                         |    2 
 net/netfilter/nf_conntrack_core.c                                                      |    5 
 net/netfilter/nf_conntrack_seqadj.c                                                    |   17 
 net/netfilter/nf_flow_table_ip.c                                                       |    6 
 net/netfilter/nf_nat_core.c                                                            |   11 
 net/netfilter/nf_synproxy_core.c                                                       |    4 
 net/netfilter/nfnetlink_hook.c                                                         |   74 
 net/netfilter/nft_compat.c                                                             |   15 
 net/netfilter/nft_set_rbtree.c                                                         |    3 
 net/netfilter/xt_dccp.c                                                                |    2 
 net/netlabel/netlabel_kapi.c                                                           |   24 
 net/netlink/af_netlink.c                                                               |   12 
 net/openvswitch/actions.c                                                              |    9 
 net/openvswitch/vport-internal_dev.c                                                   |    8 
 net/psp/psp_sock.c                                                                     |   12 
 net/rds/af_rds.c                                                                       |   29 
 net/rds/bind.c                                                                         |    4 
 net/rds/ib_sysctl.c                                                                    |    2 
 net/rds/rdma_transport.c                                                               |    3 
 net/rds/rds.h                                                                          |    3 
 net/rds/recv.c                                                                         |   11 
 net/rds/send.c                                                                         |    9 
 net/rds/sysctl.c                                                                       |    2 
 net/rds/tcp.c                                                                          |    5 
 net/rxrpc/rxperf.c                                                                     |   25 
 net/rxrpc/sendmsg.c                                                                    |   17 
 net/sched/act_api.c                                                                    |   24 
 net/sched/sch_etf.c                                                                    |    1 
 net/sched/sch_gred.c                                                                   |   16 
 net/sched/sch_taprio.c                                                                 |    6 
 net/sctp/ipv6.c                                                                        |    6 
 net/sctp/sm_make_chunk.c                                                               |   24 
 net/sctp/sm_statefuns.c                                                                |    2 
 net/smc/smc_pnet.c                                                                     |   29 
 net/sunrpc/xprtsock.c                                                                  |   34 
 net/tipc/bearer.c                                                                      |    4 
 net/tipc/node.c                                                                        |    2 
 net/tls/tls_device.c                                                                   |   45 
 net/tls/tls_main.c                                                                     |   26 
 net/tls/tls_sw.c                                                                       |    9 
 net/wireless/core.c                                                                    |   35 
 net/wireless/core.h                                                                    |    4 
 net/wireless/nl80211.c                                                                 |   84 
 net/wireless/rdev-ops.h                                                                |   17 
 net/wireless/reg.c                                                                     |   41 
 net/wireless/sme.c                                                                     |   38 
 net/wireless/trace.h                                                                   |   25 
 net/xdp/xsk.c                                                                          |    5 
 net/xdp/xsk_buff_pool.c                                                                |   46 
 rust/Makefile                                                                          |    9 
 rust/helpers/dma.c                                                                     |    5 
 rust/kernel/bitmap.rs                                                                  |   17 
 rust/kernel/block/mq/tag_set.rs                                                        |    7 
 rust/kernel/clk.rs                                                                     |   15 
 rust/kernel/configfs.rs                                                                |   63 
 rust/kernel/i2c.rs                                                                     |   21 
 rust/kernel/id_pool.rs                                                                 |   15 
 rust/kernel/scatterlist.rs                                                             |   12 
 rust/kernel/sync/completion.rs                                                         |    2 
 rust/kernel/sync/lock/spinlock.rs                                                      |    2 
 rust/kernel/workqueue.rs                                                               |   52 
 rust/macros/lib.rs                                                                     |    2 
 rust/macros/module.rs                                                                  |    2 
 rust/zerocopy-derive/README.md                                                         |    2 
 rust/zerocopy/README.md                                                                |    2 
 scripts/Makefile.vmlinux                                                               |   20 
 scripts/Makefile.vmlinux_o                                                             |    2 
 scripts/checkkconfigsymbols.py                                                         |    2 
 scripts/checkpatch.pl                                                                  |    2 
 scripts/clang-tools/run-clang-tools.py                                                 |    1 
 scripts/gcc-plugins/randomize_layout_plugin.c                                          |   61 
 scripts/gdb/linux/radixtree.py                                                         |   66 
 scripts/gdb/linux/stackdepot.py                                                        |    2 
 scripts/kconfig/conf.c                                                                 |   19 
 scripts/kconfig/symbol.c                                                               |   39 
 scripts/kconfig/tests/conftest.py                                                      |   20 
 scripts/kconfig/tests/randconfig_probability/Kconfig                                   |   12 
 scripts/kconfig/tests/randconfig_probability/__init__.py                               |  130 
 scripts/kconfig/tests/savedefconfig_range/Kconfig                                      |   60 
 scripts/kconfig/tests/savedefconfig_range/__init__.py                                  |    8 
 scripts/kconfig/tests/savedefconfig_range/config                                       |    7 
 scripts/make_fit.py                                                                    |    3 
 security/apparmor/af_inet.c                                                            |    5 
 security/apparmor/include/match.h                                                      |   11 
 security/apparmor/label.c                                                              |   14 
 security/apparmor/lsm.c                                                                |   19 
 security/apparmor/match.c                                                              |   58 
 security/apparmor/net.c                                                                |    4 
 security/apparmor/policy_ns.c                                                          |    6 
 security/apparmor/policy_unpack.c                                                      |   10 
 security/integrity/ima/ima_template.c                                                  |    5 
 security/ipe/audit.c                                                                   |    8 
 security/security.c                                                                    |    3 
 security/selinux/netlabel.c                                                            |    5 
 security/smack/smack_lsm.c                                                             |   14 
 sound/core/control_led.c                                                               |   62 
 sound/core/ctljack.c                                                                   |    1 
 sound/core/info.c                                                                      |    3 
 sound/core/init.c                                                                      |   47 
 sound/core/jack.c                                                                      |   11 
 sound/core/misc.c                                                                      |    5 
 sound/core/oss/mixer_oss.c                                                             |   36 
 sound/core/oss/pcm_oss.c                                                               |   12 
 sound/core/pcm.c                                                                       |   13 
 sound/core/pcm_compat.c                                                                |    4 
 sound/core/pcm_lib.c                                                                   |   16 
 sound/core/pcm_local.h                                                                 |    6 
 sound/core/pcm_native.c                                                                |  122 
 sound/core/rawmidi.c                                                                   |    3 
 sound/core/seq/seq_clientmgr.c                                                         |   21 
 sound/core/seq/seq_compat.c                                                            |   15 
 sound/core/seq/seq_ports.c                                                             |   41 
 sound/core/seq/seq_ports.h                                                             |    1 
 sound/core/seq/seq_ump_client.c                                                        |    5 
 sound/core/timer.c                                                                     |    1 
 sound/core/ump.c                                                                       |   61 
 sound/core/vmaster.c                                                                   |   10 
 sound/drivers/aloop.c                                                                  |   39 
 sound/drivers/pcmtest.c                                                                |   94 
 sound/hda/codecs/realtek/alc269.c                                                      |   64 
 sound/hda/common/bind.c                                                                |   15 
 sound/hda/common/codec.c                                                               |    4 
 sound/hda/common/hda_jack.h                                                            |    1 
 sound/hda/common/jack.c                                                                |   88 
 sound/hda/controllers/intel.c                                                          |   33 
 sound/hda/core/bus.c                                                                   |   30 
 sound/pci/oxygen/oxygen_pcm.c                                                          |   37 
 sound/pci/via82xx.c                                                                    |   11 
 sound/sh/aica.c                                                                        |    2 
 sound/soc/amd/acp-es8336.c                                                             |    5 
 sound/soc/amd/acp/Kconfig                                                              |    4 
 sound/soc/amd/acp/acp-platform.c                                                       |    2 
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c                                          |   14 
 sound/soc/amd/ps/ps-pdm-dma.c                                                          |    2 
 sound/soc/amd/ps/ps-sdw-dma.c                                                          |    2 
 sound/soc/amd/raven/acp3x-pcm-dma.c                                                    |    4 
 sound/soc/amd/renoir/acp3x-pdm-dma.c                                                   |    2 
 sound/soc/amd/vangogh/acp5x-pcm-dma.c                                                  |    2 
 sound/soc/amd/yc/acp6x-pdm-dma.c                                                       |    2 
 sound/soc/atmel/atmel-i2s.c                                                            |   43 
 sound/soc/atmel/atmel-pcm-pdc.c                                                        |    2 
 sound/soc/codecs/ab8500-codec.c                                                        |  144 
 sound/soc/codecs/adau17x1.c                                                            |    4 
 sound/soc/codecs/ak4642.c                                                              |    3 
 sound/soc/codecs/aw88399-lib.c                                                         |   13 
 sound/soc/codecs/cs42l56.c                                                             |    1 
 sound/soc/codecs/da7213.c                                                              |   23 
 sound/soc/codecs/da732x.c                                                              |    2 
 sound/soc/codecs/es8316.c                                                              |    4 
 sound/soc/codecs/es8323.c                                                              |    4 
 sound/soc/codecs/es8326.c                                                              |   22 
 sound/soc/codecs/es8375.c                                                              |   20 
 sound/soc/codecs/es8375.h                                                              |    2 
 sound/soc/codecs/es8389.c                                                              |   20 
 sound/soc/codecs/fs210x.c                                                              |    5 
 sound/soc/codecs/mt6359-accdet.c                                                       |   50 
 sound/soc/codecs/nau8540.c                                                             |    4 
 sound/soc/codecs/nau8822.c                                                             |   15 
 sound/soc/codecs/rt1011.c                                                              |    4 
 sound/soc/codecs/rt1015.c                                                              |   81 
 sound/soc/codecs/rt1016.c                                                              |    4 
 sound/soc/codecs/rt1305.c                                                              |    4 
 sound/soc/codecs/rt1308.c                                                              |    4 
 sound/soc/codecs/rt1318.c                                                              |    3 
 sound/soc/codecs/rt1320-sdw.c                                                          |    2 
 sound/soc/codecs/rt5616.c                                                              |    3 
 sound/soc/codecs/rt5645.c                                                              |    7 
 sound/soc/codecs/rt5659.c                                                              |   10 
 sound/soc/codecs/rt5660.c                                                              |    4 
 sound/soc/codecs/rt5665.c                                                              |    4 
 sound/soc/codecs/rt5682-sdw.c                                                          |    3 
 sound/soc/codecs/rt711-sdca-sdw.c                                                      |    6 
 sound/soc/codecs/rt711-sdw.c                                                           |    8 
 sound/soc/codecs/rt712-sdca-sdw.c                                                      |    6 
 sound/soc/codecs/rt712-sdca.c                                                          |    5 
 sound/soc/codecs/rt721-sdca-sdw.c                                                      |    6 
 sound/soc/codecs/rt722-sdca-sdw.c                                                      |    6 
 sound/soc/codecs/sma1307.c                                                             |   14 
 sound/soc/codecs/sta32x.c                                                              |  121 
 sound/soc/codecs/sta350.c                                                              |   20 
 sound/soc/codecs/tas2781-fmwlib.c                                                      |    6 
 sound/soc/codecs/tlv320adc3xxx.c                                                       |    2 
 sound/soc/codecs/tlv320aic32x4.c                                                       |    2 
 sound/soc/codecs/tlv320aic32x4.h                                                       |    1 
 sound/soc/codecs/wcd-mbhc-v2.c                                                         |    8 
 sound/soc/codecs/wcd937x.c                                                             |   44 
 sound/soc/codecs/wcd939x.c                                                             |   10 
 sound/soc/codecs/wcd939x.h                                                             |    1 
 sound/soc/codecs/wm5100.c                                                              |    2 
 sound/soc/codecs/wm8510.c                                                              |    2 
 sound/soc/codecs/wm8737.c                                                              |    8 
 sound/soc/codecs/wm8750.c                                                              |    2 
 sound/soc/codecs/wm8955.c                                                              |    2 
 sound/soc/codecs/wm8983.c                                                              |    2 
 sound/soc/codecs/wm8985.c                                                              |    2 
 sound/soc/codecs/wm8990.c                                                              |   10 
 sound/soc/codecs/wm8991.c                                                              |   10 
 sound/soc/codecs/wm8994.c                                                              |  159 
 sound/soc/codecs/wm8994.h                                                              |    2 
 sound/soc/codecs/wm_hubs.c                                                             |    2 
 sound/soc/codecs/wsa881x.c                                                             |   18 
 sound/soc/codecs/wsa883x.c                                                             |    8 
 sound/soc/codecs/wsa884x.c                                                             |    8 
 sound/soc/dwc/dwc-i2s.c                                                                |    6 
 sound/soc/fsl/fsl_asrc.c                                                               |    8 
 sound/soc/fsl/fsl_asrc_dma.c                                                           |    5 
 sound/soc/fsl/fsl_asrc_m2m.c                                                           |    4 
 sound/soc/fsl/imx-pcm-rpmsg.c                                                          |    2 
 sound/soc/intel/atom/sst-mfld-platform-pcm.c                                           |    2 
 sound/soc/intel/avs/pcm.c                                                              |    2 
 sound/soc/intel/avs/utils.c                                                            |    6 
 sound/soc/mediatek/common/mtk-afe-fe-dai.c                                             |    8 
 sound/soc/mediatek/common/mtk-soundcard-driver.c                                       |   67 
 sound/soc/mediatek/mt6797/mt6797-afe-clk.c                                             |   14 
 sound/soc/mediatek/mt8183/mt8183-afe-clk.c                                             |   22 
 sound/soc/mediatek/mt8186/mt8186-afe-clk.c                                             |   95 
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c                                             |  104 
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c                                             |   24 
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.c                                          |   12 
 sound/soc/mediatek/mt8188/mt8188-mt6359.c                                              |    3 
 sound/soc/mediatek/mt8189/mt8189-afe-clk.c                                             |  127 
 sound/soc/mediatek/mt8189/mt8189-afe-pcm.c                                             |   40 
 sound/soc/mediatek/mt8189/mt8189-dai-i2s.c                                             |   18 
 sound/soc/mediatek/mt8189/mt8189-dai-tdm.c                                             |   19 
 sound/soc/mediatek/mt8192/mt8192-afe-clk.c                                             |  139 
 sound/soc/mediatek/mt8192/mt8192-afe-gpio.c                                            |   86 
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c                                             |    6 
 sound/soc/mediatek/mt8192/mt8192-dai-adda.c                                            |   44 
 sound/soc/mediatek/mt8192/mt8192-dai-i2s.c                                             |   20 
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c                                             |   18 
 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c                                |   37 
 sound/soc/mediatek/mt8195/mt8195-afe-clk.c                                             |   77 
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c                                             |   98 
 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c                                            |   99 
 sound/soc/mediatek/mt8196/mt8196-afe-clk.c                                             |  138 
 sound/soc/mediatek/mt8196/mt8196-afe-pcm.c                                             |   18 
 sound/soc/mediatek/mt8196/mt8196-dai-i2s.c                                             |   17 
 sound/soc/mediatek/mt8196/mt8196-dai-tdm.c                                             |   16 
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c                                             |    7 
 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c                                             |    2 
 sound/soc/qcom/qdsp6/q6apm.c                                                           |    1 
 sound/soc/qcom/sdm845.c                                                                |   19 
 sound/soc/renesas/rcar/msiof.c                                                         |    6 
 sound/soc/rockchip/rk3288_hdmi_analog.c                                                |   42 
 sound/soc/rockchip/rockchip_i2s.c                                                      |    4 
 sound/soc/rockchip/rockchip_sai.c                                                      |    4 
 sound/soc/samsung/midas_wm1811.c                                                       |   14 
 sound/soc/sdca/sdca_class.c                                                            |   82 
 sound/soc/sdca/sdca_class.h                                                            |   35 
 sound/soc/sdca/sdca_class_function.c                                                   |    2 
 sound/soc/sdca/sdca_fdl.c                                                              |   18 
 sound/soc/soc-ac97.c                                                                   |    4 
 sound/soc/soc-card-test.c                                                              |    7 
 sound/soc/soc-component.c                                                              |    2 
 sound/soc/soc-link.c                                                                   |    2 
 sound/soc/soc-ops.c                                                                    |   10 
 sound/soc/soc-topology-test.c                                                          |    8 
 sound/soc/sof/amd/acp.c                                                                |   11 
 sound/soc/sof/imx/imx-common.c                                                         |    1 
 sound/soc/sof/intel/hda-codec.c                                                        |    4 
 sound/soc/sof/intel/hda-ctrl.c                                                         |    1 
 sound/soc/sof/intel/hda.c                                                              |    4 
 sound/soc/xilinx/xlnx_formatter_pcm.c                                                  |   18 
 sound/usb/6fire/control.c                                                              |    7 
 sound/usb/caiaq/device.c                                                               |    9 
 sound/usb/caiaq/device.h                                                               |    6 
 sound/usb/caiaq/input.c                                                                |   29 
 sound/usb/caiaq/midi.c                                                                 |    2 
 sound/usb/line6/capture.c                                                              |    3 
 sound/usb/line6/pcm.c                                                                  |    8 
 sound/usb/mixer.c                                                                      |  172 
 sound/usb/mixer.h                                                                      |   10 
 sound/usb/mixer_quirks.c                                                               |    2 
 sound/usb/mixer_scarlett.c                                                             |   18 
 sound/usb/mixer_us16x08.c                                                              |   39 
 sound/usb/quirks-table.h                                                               |    2 
 sound/usb/quirks.c                                                                     |    9 
 sound/usb/usx2y/us122l.c                                                               |    2 
 sound/virtio/virtio_pcm.h                                                              |    2 
 sound/virtio/virtio_pcm_msg.c                                                          |   19 
 sound/virtio/virtio_pcm_ops.c                                                          |    1 
 tools/bpf/bpftool/Documentation/bpftool-prog.rst                                       |   11 
 tools/bpf/bpftool/btf.c                                                                |    6 
 tools/bpf/bpftool/common.c                                                             |   40 
 tools/bpf/bpftool/gen.c                                                                |   26 
 tools/bpf/bpftool/link.c                                                               |    4 
 tools/bpf/bpftool/main.c                                                               |   16 
 tools/bpf/bpftool/main.h                                                               |    1 
 tools/bpf/bpftool/map.c                                                                |   95 
 tools/bpf/bpftool/prog.c                                                               |  238 
 tools/bpf/bpftool/skeleton/profiler.bpf.c                                              |   29 
 tools/bpf/bpftool/tracelog.c                                                           |    2 
 tools/bpf/resolve_btfids/main.c                                                        |    3 
 tools/build/feature/test-libdw.c                                                       |   10 
 tools/cgroup/iocost_monitor.py                                                         |    7 
 tools/cgroup/memcg_shrinker.py                                                         |    2 
 tools/hv/vmbus_bufring.c                                                               |    6 
 tools/include/nolibc/dirent.h                                                          |    7 
 tools/include/nolibc/err.h                                                             |    2 
 tools/include/nolibc/stdlib.h                                                          |    8 
 tools/include/nolibc/sys/select.h                                                      |    6 
 tools/include/nolibc/types.h                                                           |    2 
 tools/lib/api/fd/array.c                                                               |    4 
 tools/lib/bpf/btf.c                                                                    |   16 
 tools/lib/bpf/libbpf.c                                                                 |   53 
 tools/lib/bpf/skel_internal.h                                                          |   48 
 tools/lib/bpf/usdt.c                                                                   |    4 
 tools/lib/perf/evlist.c                                                                |    5 
 tools/lib/perf/include/internal/evsel.h                                                |    2 
 tools/lib/perf/mmap.c                                                                  |    2 
 tools/perf/Build                                                                       |    4 
 tools/perf/Documentation/perf-c2c.txt                                                  |    2 
 tools/perf/Documentation/perf-record.txt                                               |    7 
 tools/perf/Documentation/perf-sched.txt                                                |    6 
 tools/perf/Makefile.config                                                             |   15 
 tools/perf/Makefile.perf                                                               |   25 
 tools/perf/arch/arm/tests/dwarf-unwind.c                                               |    1 
 tools/perf/arch/arm64/tests/dwarf-unwind.c                                             |    1 
 tools/perf/arch/powerpc/tests/dwarf-unwind.c                                           |    1 
 tools/perf/arch/powerpc/util/skip-callchain-idx.c                                      |    4 
 tools/perf/arch/x86/tests/topdown.c                                                    |   30 
 tools/perf/arch/x86/util/topdown.c                                                     |    3 
 tools/perf/builtin-buildid-list.c                                                      |   17 
 tools/perf/builtin-c2c.c                                                               |   16 
 tools/perf/builtin-inject.c                                                            |    3 
 tools/perf/builtin-lock.c                                                              |   61 
 tools/perf/builtin-record.c                                                            |   15 
 tools/perf/builtin-sched.c                                                             |  189 
 tools/perf/builtin-stat.c                                                              |    4 
 tools/perf/builtin-trace.c                                                             |    9 
 tools/perf/pmu-events/Build                                                            |    6 
 tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json                          |    3 
 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-cache.json                      |    5 
 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-interconnect.json               |    2 
 tools/perf/pmu-events/arch/x86/lunarlake/cache.json                                    |    3 
 tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json                                 |    2 
 tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json                          |    5 
 tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json                   |    2 
 tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json                       |    6 
 tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json                            |   68 
 tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json                     |   10 
 tools/perf/pmu-events/jevents.py                                                       |   11 
 tools/perf/tests/Build                                                                 |    4 
 tools/perf/tests/code-reading.c                                                        |   12 
 tools/perf/tests/demangle-java-test.c                                                  |    1 
 tools/perf/tests/demangle-rust-v0-test.c                                               |    1 
 tools/perf/tests/fdarray.c                                                             |   32 
 tools/perf/tests/hists_cumulate.c                                                      |    2 
 tools/perf/tests/hists_filter.c                                                        |    2 
 tools/perf/tests/hists_link.c                                                          |    2 
 tools/perf/tests/hists_output.c                                                        |    2 
 tools/perf/tests/make                                                                  |    3 
 tools/perf/tests/pe-file-parsing.c                                                     |    2 
 tools/perf/tests/sample-parsing.c                                                      |  109 
 tools/perf/tests/shell/attr.sh                                                         |    7 
 tools/perf/tests/shell/attr/README                                                     |   10 
 tools/perf/tests/shell/attr/base-record                                                |    2 
 tools/perf/tests/shell/attr/base-stat                                                  |    2 
 tools/perf/tests/shell/attr/base-stat-group                                            |   45 
 tools/perf/tests/shell/attr/system-wide-dummy                                          |    2 
 tools/perf/tests/shell/attr/test-record-dummy-C0                                       |    2 
 tools/perf/tests/shell/attr/test-record-graph-dwarf                                    |    2 
 tools/perf/tests/shell/attr/test-record-group-sampling                                 |    4 
 tools/perf/tests/shell/attr/test-record-group-sampling1                                |    4 
 tools/perf/tests/shell/attr/test-record-group-sampling2                                |    4 
 tools/perf/tests/shell/attr/test-record-group1                                         |    2 
 tools/perf/tests/shell/attr/test-record-group2                                         |    2 
 tools/perf/tests/shell/attr/test-record-group3                                         |    2 
 tools/perf/tests/shell/attr/test-stat-default                                          |   90 
 tools/perf/tests/shell/attr/test-stat-detailed-1                                       |   98 
 tools/perf/tests/shell/attr/test-stat-detailed-2                                       |  110 
 tools/perf/tests/shell/attr/test-stat-detailed-3                                       |  114 
 tools/perf/tests/shell/attr/test-stat-group1                                           |    2 
 tools/perf/tests/shell/c2c.sh                                                          |    1 
 tools/perf/tests/shell/coresight/callchain.sh                                          |    7 
 tools/perf/tests/shell/data_type_profiling.sh                                          |   46 
 tools/perf/tests/shell/lib/attr.py                                                     |   11 
 tools/perf/tests/shell/schedstat_snapshots.sh                                          |  155 
 tools/perf/tests/shell/stat.sh                                                         |    5 
 tools/perf/tests/shell/test_event_open_fallback.sh                                     |    2 
 tools/perf/tests/symbols.c                                                             |   96 
 tools/perf/tests/thread-maps-share.c                                                   |    3 
 tools/perf/tests/workloads/code_with_type.c                                            |    2 
 tools/perf/ui/browsers/annotate-data.c                                                 |    2 
 tools/perf/util/Build                                                                  |    2 
 tools/perf/util/addr2line.c                                                            |   68 
 tools/perf/util/annotate-data.c                                                        |   21 
 tools/perf/util/aslr.c                                                                 |   10 
 tools/perf/util/aslr.h                                                                 |    2 
 tools/perf/util/bpf-filter.c                                                           |   29 
 tools/perf/util/cs-etm.c                                                               |   12 
 tools/perf/util/debug.c                                                                |    2 
 tools/perf/util/dso.c                                                                  |   57 
 tools/perf/util/dso.h                                                                  |   26 
 tools/perf/util/dwarf-aux.c                                                            |   56 
 tools/perf/util/dwarf-aux.h                                                            |   13 
 tools/perf/util/evlist.c                                                               |    6 
 tools/perf/util/evsel.c                                                                |   92 
 tools/perf/util/evsel.h                                                                |    1 
 tools/perf/util/header.c                                                               |   18 
 tools/perf/util/jitdump.c                                                              |  126 
 tools/perf/util/libbfd.c                                                               |   76 
 tools/perf/util/libbfd.h                                                               |    9 
 tools/perf/util/libdw.c                                                                |   54 
 tools/perf/util/libdw.h                                                                |    5 
 tools/perf/util/llvm-c-helpers.cpp                                                     |   66 
 tools/perf/util/llvm.c                                                                 |   16 
 tools/perf/util/machine.c                                                              |    4 
 tools/perf/util/machine.h                                                              |   10 
 tools/perf/util/mem-events.c                                                           |    2 
 tools/perf/util/mmap.c                                                                 |    3 
 tools/perf/util/parse-events.c                                                         |    3 
 tools/perf/util/pmus.c                                                                 |   21 
 tools/perf/util/print_insn.h                                                           |    1 
 tools/perf/util/python.c                                                               |    1 
 tools/perf/util/session.c                                                              |    2 
 tools/perf/util/setup.py                                                               |    1 
 tools/perf/util/srcline.c                                                              |   81 
 tools/perf/util/symbol.c                                                               |   40 
 tools/perf/util/synthetic-events.c                                                     |   16 
 tools/perf/util/thread.c                                                               |    8 
 tools/perf/util/thread_map.c                                                           |   26 
 tools/perf/util/thread_map.h                                                           |    1 
 tools/perf/util/tp_pmu.c                                                               |    8 
 tools/perf/util/unwind-libdw.c                                                         |    2 
 tools/perf/util/unwind-libunwind.c                                                     |   64 
 tools/power/x86/turbostat/turbostat.c                                                  |    8 
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c                        |   18 
 tools/sched_ext/include/scx/enum_defs.autogen.h                                        |    1 
 tools/sched_ext/scx_flatcg.bpf.c                                                       |    2 
 tools/testing/cxl/test/cxl.c                                                           |    8 
 tools/testing/selftests/Makefile                                                       |    4 
 tools/testing/selftests/alsa/mixer-test.c                                              |    2 
 tools/testing/selftests/alsa/test-pcmtest-driver.c                                     |   27 
 tools/testing/selftests/arm64/signal/Makefile                                          |    4 
 tools/testing/selftests/bpf/Makefile                                                   |    8 
 tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected                           |   48 
 tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected                         |   48 
 tools/testing/selftests/bpf/bpftool_helpers.c                                          |    7 
 tools/testing/selftests/bpf/network_helpers.c                                          |   46 
 tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c                              |  178 
 tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c                     |    4 
 tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c                                   |    5 
 tools/testing/selftests/bpf/prog_tests/empty_skb.c                                     |   19 
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c                                |    2 
 tools/testing/selftests/bpf/prog_tests/global_data_init.c                              |   96 
 tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c                                  |   53 
 tools/testing/selftests/bpf/prog_tests/missed.c                                        |    8 
 tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c                          |   16 
 tools/testing/selftests/bpf/prog_tests/sockopt.c                                       |    4 
 tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c                         |   37 
 tools/testing/selftests/bpf/prog_tests/test_task_work.c                                |    2 
 tools/testing/selftests/bpf/prog_tests/test_tc_edt.c                                   |   13 
 tools/testing/selftests/bpf/prog_tests/test_tunnel.c                                   |   13 
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c                             |    4 
 tools/testing/selftests/bpf/prog_tests/wq.c                                            |    5 
 tools/testing/selftests/bpf/progs/cpumask_success.c                                    |    6 
 tools/testing/selftests/bpf/progs/dynptr_fail.c                                        |    4 
 tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c                          |   16 
 tools/testing/selftests/bpf/progs/test_global_percpu_data.c                            |   10 
 tools/testing/selftests/bpf/progs/test_tc_edt.c                                        |   13 
 tools/testing/selftests/bpf/progs/test_tc_link.c                                       |   10 
 tools/testing/selftests/bpf/progs/verifier_jit_inline.c                                |    2 
 tools/testing/selftests/bpf/progs/verifier_ldsx.c                                      |   17 
 tools/testing/selftests/bpf/progs/verifier_stack_arg.c                                 |    4 
 tools/testing/selftests/bpf/test_progs.c                                               |    5 
 tools/testing/selftests/bpf/unpriv_helpers.c                                           |    9 
 tools/testing/selftests/cgroup/test_cpuset_prs.sh                                      |   54 
 tools/testing/selftests/cgroup/test_zswap.c                                            |   24 
 tools/testing/selftests/clone3/clone3_clear_sighand.c                                  |    6 
 tools/testing/selftests/coredump/coredump_test_helpers.c                               |    8 
 tools/testing/selftests/damon/sysfs_no_op_commit_break.py                              |   35 
 tools/testing/selftests/drivers/net/psp.py                                             |   56 
 tools/testing/selftests/exec/Makefile                                                  |    2 
 tools/testing/selftests/filelock/ofdlocks.c                                            |    2 
 tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c                          |   32 
 tools/testing/selftests/filesystems/fscontext_ns/.gitignore                            |    2 
 tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c                     |   18 
 tools/testing/selftests/ftrace/ftracetest                                              |    2 
 tools/testing/selftests/namespaces/ns_active_ref_test.c                                |   29 
 tools/testing/selftests/net/lib/csum.c                                                 |   55 
 tools/testing/selftests/net/lib/gro.c                                                  |    2 
 tools/testing/selftests/net/netfilter/conntrack_vrf.sh                                 |   25 
 tools/testing/selftests/net/tcp_mmap.c                                                 |    6 
 tools/testing/selftests/net/txtimestamp.c                                              |   23 
 tools/testing/selftests/nolibc/Makefile                                                |    2 
 tools/testing/selftests/pidfd/pidfd_open_test.c                                        |    2 
 tools/testing/selftests/proc/proc-pid-vm.c                                             |   14 
 tools/testing/selftests/rdma/config                                                    |   12 
 tools/testing/selftests/rdma/rxe_sent_rcvd_bytes.sh                                    |    6 
 tools/testing/selftests/sched_ext/hotplug.c                                            |   34 
 tools/testing/selftests/sched_ext/rt_stall.c                                           |   80 
 tools/testing/selftests/sched_ext/runner.c                                             |    2 
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json                           |    2 
 tools/testing/selftests/thermal/intel/power_floor/Makefile                             |   12 
 tools/testing/selftests/thermal/intel/workload_hint/Makefile                           |   12 
 tools/testing/selftests/timers/clocksource-switch.c                                    |   23 
 tools/testing/selftests/ublk/fault_inject.c                                            |   14 
 tools/testing/selftests/vfio/lib/sysfs.c                                               |    1 
 tools/testing/shared/linux.c                                                           |    4 
 tools/testing/vma/include/dup.h                                                        |   80 
 tools/testing/vma/include/stubs.h                                                      |    2 
 tools/testing/vma/shared.c                                                             |    8 
 tools/testing/vma/shared.h                                                             |   16 
 tools/thermal/tmon/tmon.c                                                              |    2 
 tools/tracing/rtla/tests/engine.sh                                                     |    2 
 usr/gen_init_cpio.c                                                                    |    1 
 2353 files changed, 44904 insertions(+), 22932 deletions(-)

Aamir Ahmed (3):
      wifi: nxpwifi: validate variable IE lengths in beacon parser
      wifi: mm81x: validate n_channels in disabled channels response
      wifi: mt76: mt7996: validate TLV length in mt7996_mcu_ie_countdown()

Aaradhana Sahu (3):
      wifi: ath12k: Free allocated CE IRQs on request_irq() failure
      wifi: ath12k: Free allocated external IRQs on request_irq() failure
      wifi: ath12k: Fix NAPI resource leaks in AHB external IRQ paths

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

Abel Vesa (27):
      arm64: dts: qcom: glymur-crd: Mark the EC reset gpio as reserved
      PCI/pwrctrl: tc9563: Allow RESX reset assertion to sleep
      arm64: dts: qcom: eliza: Connect USB3 PHY pipe clock to GCC
      arm64: dts: qcom: x1-crd: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1e001de-devkit: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1e78100-t14s: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1e80100-dell-xps13-9345: Mark the EC reset gpio as reserved
      arm64: dts: qcom: honor-magicbook-art-14: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1e80100-yoga-slim7x: Mark the EC reset gpio as reserved
      arm64: dts: qcom: medion-sprchrgd-14-s1: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1e80100-qcp: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1-asus-vivobook-s15: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1-asus-zenbook-a14: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1-dell-thena: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1-hp-omnibook-x14: Mark the EC reset gpio as reserved
      arm64: dts: qcom: x1p42100-thinkbook-16: Mark the EC reset gpio as reserved
      clk: qcom: gcc-qcs615: Fix GCC_CPUSS_GNOC_CBCR offset
      dt-bindings: clock: qcom: sm8750-gcc: Add CX power domain
      arm64: dts: qcom: sm8150: Use SM8150_CX for the SDHC power domain
      arm64: dts: qcom: kaanapali: Add GCC CX power domain
      platform: arm64: qcom-hamoa-ec: Disable the SCI IRQ during suspend
      clk: qcom: gcc-eliza: Tie the CX power domain to controller
      clk: qcom: gcc-kaanapali: Tie the CX power domain to controller
      clk: qcom: gcc-ipq5424: Fix TME reset register offsets
      clk: qcom: mmcc-msm8996: Fix FD AHB clock register offset
      clk: qcom: mmcc-sdm660: Fix MDSS AHB clock HWCG register offset
      clk: qcom: mmcc-msm8960: Configure PLL15 only on APQ8064

Abhijit Gangurde (2):
      RDMA/ionic: Fix XArray initialization to use XArray flags
      RDMA/ionic: Fix double removal of CMB mmap entries in create QP error path

Abhishek Dubey (2):
      powerpc64/bpf: fix compare instruction emitted for tailcall
      powerpc/bpf: Move out dummy_tramp_addr after Long branch stub

Abhishek Mohapatra (1):
      RDMA/bnxt_re: Use kvzalloc for QP table allocation

Abraham Zukor (1):
      spi: tegra114: initialize native chip selects inactive

Adam Azuddin (1):
      drm/appletbdrm: Fix incorrect error message on encoder attach failure

Adam Skladowski (1):
      dt-bindings: vendor-prefixes: Add LeEco

Adi Nata (1):
      iio: humidity: hts221: report available values via read_avail()

Aditya Sharma (1):
      bpf: Remove nmi_uaccess_okay() check in bpf_send_signal_common()

Adrian Ambrozewicz (1):
      gpiolib: clear the event clock flags when a line is released

Adrian Hunter (7):
      i3c: master: Match ACPI targets to the correct bus controller instance
      i3c: mipi-i3c-hci: Restore controller state if i3c_hci_enable_ibi() returns an error
      i3c: mipi-i3c-hci: Fix runtime PM violation in i3c_hci_free_ibi()
      i3c: mipi-i3c-hci: Process multiple IBIs per interrupt
      i3c: mipi-i3c-hci: Move DMA suspend/resume callbacks
      i3c: mipi-i3c-hci: Stop rings gracefully when suspending
      i3c: Restrict HDR modes to those supported by the bus and target

Adrián Larumbe (11):
      drm/panfrost: Check another bo field for cache option query
      drm/panfrost: Prevent division by 0
      drm/panfrost: Move shrinker initialization and unplug one level down
      drm/panfrost: Fix PM refcnt and autosuspend issues at device probe/remove
      drm/panfrost: Explicitly enable MMU interrupts at device init
      drm/panfrost: Move lock and modparam initialisations into their subsystems
      drm/panfrost: Move perfcnt GPU disable sequence into a helper
      drm/panfrost: Skip cache flush/invalidate when enabling perfcnt
      drm/panfrost: Introduce a reset lock
      drm/panfrost: Fix races between perfcnt and reset sequence
      drm/panfrost: Fix race when restoring reset state in perfcnt

Ahmad Fatoum (3):
      ARM: dts: stm32: lxa-mc1: change stdout-path baud rate from 9600 to 115200
      ARM: dts: stm32: lxa-tac: change stdout-path baud rate from 9600 to 115200
      ARM: dts: stm32: fairytux2: change stdout-path baud rate from 9600 to 115200

Ahmed Naseef (1):
      wifi: mt76: mt7615: read MT7663 temperature from the correct offset

Ahmed Yaseen (1):
      platform/x86: asus-wmi: validate custom fan curves on enable

Ahsan Atta (4):
      crypto: qat - avoid OOB read when stripping RSA leading zeros
      crypto: qat - release instance on DH fallback allocation failure
      crypto: qat - fix active_devs leak on crypto alg registration failure
      crypto: qat - hold cfg->lock when accessing config sections

Aiman Najjar (1):
      HID: nintendo: add support for PDP Afterglow controller

Ajanesh Lal (1):
      ALSA: hda/realtek: Add mute and mic-mute LEDs for HP ENVY 16 (103c:8be5)

Ajay Kumar Nandam (1):
      ASoC: qcom: q6apm: clear g_apm on driver removal

Akash Goel (1):
      drm/panthor: Fix handling of NO_MMAP BOs

Akash Sukhavasi (1):
      phy: HiSilicon: Fix error handling in hi3670_pcie_allclk_ctrl()

Akhil P Oommen (3):
      drm/msm/a6xx: Honor perfmode_bw threshold on A8x
      drm/msm/a6xx: Fix secondary rail vote in ARC votes
      drm/msm/a6xx: Fix RPMH dependency votes

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

Alex Elder (6):
      arm64: dts: qcom: qcs6490-rb3gen2: clean up PCI function nodes
      arm64: dts: qcom: qcs6490-rb3gen2-industrial-mezzanine: clean up PCI function nodes
      arm64: dts: qcom: lemans-evk-ifp-mezzanine: clean up PCI function nodes
      arm64: dts: qcom: monaco-evk-ifp-mezzanine: clean up PCI function nodes
      arm64: dts: qcom: qcs6490-thundercomm-minipc-g1iot: clean up PCI function nodes
      arm64: dts: qcom: qcs8550-rb5gen2: clean up PCI function nodes

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

Alexander Koskovich (1):
      scsi: ufs: qcom: Power down UFS during system suspend on Milos

Alexandra Lu (1):
      bus: mhi: host: pci_generic: Fix runtime PM imbalance for no_m3 devices

Alexandra Winter (1):
      s390/ism: Zerorize dmb at allocation

Alexandre Cassen (5):
      net/mlx5: HWS, fix reformat pool creation race
      net/mlx5: HWS, fix modify header pool creation race
      net/mlx5: HWS, fix modify header pattern compare on big-endian
      net/mlx5: HWS, fix modify header pool match for copy actions
      net/sched: act_api: inherit filter offload flags only on new actions

Alexei Starovoitov (13):
      selftests/bpf: Wait for links to come up in lwt_ip_encap
      bpf, x86: Fix timed may_goto with private stack
      bpf: Adjust pc-relative insn copied into its own patch
      bpf: Fix overflow of jump offset in may_goto expansion
      bpf: Don't converge a loop on an iterator that was created anew
      bpf: Reject BTF ids with the same address in tracing_multi link
      bpf: Clear sk_refcnt of a clone before its storage is linked
      bpf: Link the first element after its storage is published
      bpf: Don't take an extension for a writable raw tracepoint program
      bpf: Don't take a program with a target program for an iterator
      bpf: Don't let an extension reach further into the context than its target
      bpf: Use memmove() to store bytes in an xdp_buff
      bpf: Keep stack arguments in arch_bpf_timed_may_goto()

Alexey Charkov (1):
      power: supply: bq257xx: Use psy directly instead of driver data

Alexis Lothoré (eBPF Foundation) (2):
      selftests/bpf: Allocate a larger timeout for connection
      selftests/bpf: make cmdline_contains stricter

Ali Ahmet Memiş (4):
      platform/x86: ideapad-laptop: Evaluate ACPI methods exclusively
      ALSA: seq: Wait for one RCU grace period when deleting all ports
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
      ovl: add assertions in dir cache code
      ovl: inherit FMODE_NONOTIFY when reading directory layers
      selftests/ovl: fix detached layer mountinfo expectations

Andrea Parri (3):
      pstore: don't leave an ERR_PTR in the ramoops zone pointer
      pstore: reject persistent RAM zones too small for the buffer header
      nvmet: zns: reject a NUMD whose byte count wraps

Andrea Righi (3):
      sched_ext: Use irq_work for deferred actions with proxy execution
      sched: Add sched_ext hooks for proxy execution
      sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors

Andreas Hindborg (1):
      rust: block: implement `Send` and `Sync` for `TagSet`

Andreas Kemnade (2):
      drm/omap: dsi: avoid sending bta sync all the time in writes
      rtc: bd70528: properly enable wakeup

Andrei Otcheretianski (2):
      wifi: cfg80211: add NL80211_CMD_NAN_SET_NON_EVAC_CHANNELS
      wifi: mac80211: implement NAN non-evacuable channels

Andrei Rusu de Castro (1):
      wifi: mt76: mt7925: keep MLD membership consistent during link add

Andrei Vagin (2):
      x86/fpu: Fix potential underflow in xstate_calculate_size()
      proc: report SIGEV_NONE in /proc/pid/timers if target task has died

Andrew Gaylard (1):
      pinctrl: fix PINCTRL_SPPCTL=m

AngeloGioacchino Del Regno (1):
      spmi: mtk-pmif: Add workaround for FSM lockup/error in read operation

Anil Kaushik (2):
      gtp: set a valid genl command in PDP context get and dump replies
      gtp: hold RCU for the device lookup when adding a PDP context

Anirudh Virdi (1):
      net: qede: initialize extack in qede_flow_spec_to_rule()

Antoni Pokusinski (3):
      rtc: abx80x: fix error check after i2c_smbus_read in read_alarm()
      rtc: abx80x: add mutex protection for register writes
      rtc: abx80x: properly handle shared IRQs

Anup Vishwakarma (4):
      remoteproc: qcom_q6v5_adsp: Fix double jiffies conversion in adsp_start()
      mailbox: qcom-ipcc: Remove redundant mbox_controller_unregister() on probe failure
      mailbox: arm_mhu_db: Remove redundant mbox_controller_unregister() on probe failure
      mailbox: qcom-ipcc: remove stray disable_irq_wake() call

Ard Biesheuvel (1):
      efi/runtime-wrappers: Don't park the worker after a recovered firmware fault

Ariana Lazar (1):
      iio: dac: mcp47feb02: protect EEPROM store sequence with mutex

Arka Mondal (6):
      usb-storage: alauda: do not do DMA from the stack
      usb-storage: alauda: check the return value of alauda_read_map()
      usb-storage: alauda: fix out-of-bounds zone index
      iio: dac: ad5758: Fix alignment for DMA safety
      iio: dac: ad5758: Reject out-of-range raw values
      iio: dac: ad5758: Fix the offset calculation

Arnaldo Carvalho de Melo (23):
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
      perf test: Skip data_type_profiling when the PMU cannot record memory events
      perf annotate-data: Show the sample count in the data-type browser
      perf test workload: Use unsigned int in code_with_type instead of uint
      perf dwarf-aux: Add die_same_file() and die_get_type_die()
      perf annotate-data: Resolve type DIEs in the debug file they came from
      perf test attr: Source setup_python.sh instead of calling python
      perf test attr: Fix record dwarf sample_type expectation
      perf test attr: Fix legacy event encodings in group tests
      perf test attr: Fix default stat metrics expectations
      perf test attr: Relax group checking for ungrouped expectations
      perf evsel: Mark the event as supported when retrying an open

Arnd Bergmann (11):
      bpf: Add printf attributes
      sfc: fix CONFIG_CXL_MEM dependency
      KMSAN: fix memset() when using fortify-source, again
      ASoC: amd: acp: add EFI dependency for selecting TAS2783
      f2fs: quota: fix unused-label warning
      drm/amd/display: fix unused function warnings
      drm/panel: fix novatek-nt36536 dependencies
      perf: marvell: avoid large stack variables
      wifi: mt76: mt7996: add NET_AIROHA dependency
      platform/x86/amd/pmf: fix compat ioctl handling
      irqchip/qcom-pdc: Fix linking against QCOM_SCM firmware

Atharva Vartak (1):
      net/smc: hold a reference on net_device returned by pnet_find_base_ndev()

Atul Akella (1):
      rpmsg: virtio: fix error handling in TX buffer wait

Aurelien Jarno (2):
      riscv: dts: spacemit: k3: move USB3 phy to board level
      riscv: fix RVG_SYSTEM_CSR_MASK width mask

Avi Weiss (5):
      rpmsg: mtk: release channel OF node on device teardown
      signal: skip blocked signals in dequeue_synchronous_signal()
      profiling: fix sampling step on 64-bit big-endian systems
      kthread: Fall back when no preferred housekeeping CPU is online
      nvmet: prevent double-free after metadata SGL allocation failure

Ayushman Rout (1):
      bpf: Use memmove() to load bytes from an skb and an xdp_buff

Baek Kyu, Kim (2):
      rtc: mpfs: Fix alarm register word order
      gpiolib: Propagate emulated drive errors when setting arrays

Baochen Qiang (4):
      wifi: ath12k: signal regd update completion when reg event is dropped
      wifi: ath12k: fix stale skb pointers after aligned TX payload shift
      wifi: ath12k: fix truncated TX buffer DMA address in MSDU ext descriptor
      wifi: ath11k: fix unbalanced IRQ enable/disable during suspend/resume

Baolin Liu (7):
      fs/ntfs3: update ctime only on successful setxattr
      fs/ntfs3: reject FS_IOC_SETFSLABEL on readonly mounts
      ntfs: return -EINVAL from ntfs_collate_ntofs_ulongs() on bad length
      ntfs: preserve the truncate error in ntfs_enlarge_attribute()
      ntfs: propagate the map_mft_record() error in ntfs_attrlist_entry_add()
      ntfs: propagate the ntfs_attr_iget() error in update_reparse_data()
      ntfs: fix error handling in ntfs_extent_inode_open and propagate errors

Barnabás Pőcze (1):
      media: rcar-isp: ispcore: Fix inconsistent step sizes

Bart Van Assche (2):
      scsi: pm8001: Fix SATA FIS offset in struct hw_event_resp
      scsi: scsi_debug: Fix a locking bug in resp_write_same()

Bartosz Szpila (1):
      platform/chrome: cros_ec_typec: Validate SVID and mode counts in discovery data

Beleswar Padhi (1):
      mailbox: ti-msgmgr: Read exact number of trailing message bytes

Ben Horgan (11):
      arm_mpam: Set mpam_feat_msmon_mbwu_31counter when there are bandwidth counters
      arm_mpam: Add missing mon_sel locking in MBWU save and restore
      arm_mpam: Ensure MBWU counters are reset on restore
      arm_mpam: Use __ris_msmon_read() for saving MBWU state
      arm_mpam: Initialize all of struct mon_read in mpam_restore_mbwu_state()
      arm_mpam: resctrl: Correct check that existing class is L3
      arm_mpam: resctrl: Make read_mon_cdp_safe() self consistent
      arm_mpam: Don't loop forever if there is the maximum possible amount of PARTIDs
      arm_mpam: Switch to kvzmalloc_objs() for allocation of component cfg
      arm_mpam: resctrl: Don't stop early when tearing down a class
      arm_mpam: On saving mbwu state read the monitors before clearing CFG_MBWU_CTL

Benoît Monin (4):
      perf build: Improve fix for "argument list too long" error
      irqchip/mips-gic: Fix unbalanced cm_core_lock in for_each_online_cpu_gic()
      irqchip/mips-gic: Fix recursive acquisition of gic_lock in gic_set_affinity()
      irqchip/mips-gic: Transfer interrupt mask state across clusters

Bert Karwatzki (1):
      mac80211: tx: Use info->flags in ieee80211_tx_h_select_key()

Binbin Deng (5):
      RDMA/rxe: unpublish the per-net tunnel socket before
      module: Fix uninitialized count read of unloaded taint tracking record
      octeontx2: Fix use-after-free of qos node in delete path
      tipc: fix use-after-free of broadcast reception link at node release
      net: atlantic: Unregister before clearing RXNFC rules

Binbin Zhou (1):
      dmaengine: loongson: loongson2-apb-cmc: Fix signedness bug in irq handling

Binglei Wang (1):
      erofs: fix xattrs handling when metadata compression is used

Bjoern Doebel (1):
      selftests/rdma: Skip rxe_sent_rcvd_bytes when rdma_rxe is missing

Bjorn Andersson (1):
      power: supply: qcom_battmgr: report full batteries

Bjorn Helgaas (2):
      PCI: tegra264: Fix Link Capabilities register offset
      PCI: Expose devm_pci_alloc_host_bridge_release()

Boris Brezillon (2):
      drm/panthor: Don't invalidate OTHER caches
      drm/panthor: Fully disable the AS even if it's going to be re-assigned

Boris Faure (1):
      soundwire: intel: initialise quirk_mask before reading it

Brad Fitzpatrick (1):
      gre: keep the UDP tunnel GSO type when completing GRO

Bradley Morgan (1):
      watchdog/perf: one digit too short in the raw event config copy

Breno Leitao (3):
      kexec_file: stop the top-down search before it underflows
      ACPICA: Fix memory leak in acpi_ds_create_field()
      mailbox: pcc: Free the channel before unmapping the shared memory

Brian Norris (3):
      arm64: dts: mediatek: Add #{address,size}-cells to Chromium-based /firmware
      PM: runtime: Only queue an idle check for RPM-linked suppliers
      PM: runtime: Only queue an idle check for RPM-linked suppliers (part 2)

Bruno Banelli (1):
      phy: spacemit: fix K1 USB 2.0 PHY Kconfig dependencies

Bruno Produit (1):
      hfs/hfsplus: serialize B-tree close against folio release

Cai Xinchen (1):
      lsm: don't call security_backing_file_free() multiple times

Calvin Owens (1):
      Revert "drm/amd/display: Allocate DCN32/1 dmub memory to GTT"

Carlo Szelinsky (1):
      net: pse-pd: si3474: fix use-after-free in ancillary client error path

Carolina Jubran (4):
      IB/IPoIB: Cancel normal flush work on device stop
      net/mlx5: DPLL, fix fractional frequency offset scaling
      net/mlx5e: Fix NULL deref in PTP TX timestamp recovery warn
      net: skbuff: don't copy alloc_cpu in skb header copies

Cen Zhang (27):
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

Cezary Rojewski (2):
      ASoC: Intel: avs: Unprepare a stream when recovery occurs
      ASoC: Intel: avs: Prevent module info underflow

Chaithanya Lagisetty (3):
      dmaengine: dw-axi-dmac: convert clock handling to clk_bulk API
      dmaengine: sprd: use clk_bulk API to fix clock imbalance
      x86/svm: Avoid sign extension of SVM_EVTINJ_VALID in 64-bit expressions

Chancel Liu (1):
      pinctrl: pinctrl-generic-mux: Fix provider resource leak on re-parse

Chandradhar Kumar (2):
      regulator: fixed: reject incompatible platform devices
      md/raid0: validate device count before allocating devlist

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

Chandrashekar Devegowda (2):
      Bluetooth: btintel_pcie: parse FW memory addresses via mailbox TLV
      Bluetooth: btintel_pcie: remove duplicate BTINTEL_PCIE_MAGIC_NUM definition

Chao Yu (1):
      f2fs: fix to fetch ino via ino_of_node() under cache lock

Charlene Liu (1):
      drm/amd/display: Fix zero dlg_reg write to program_ext_vblank

Charles Keepax (1):
      mfd: cs42l43: Move cancel_work_sync() into remove

Charlie Garner (1):
      arm64: dts: qcom: x1e80100-dell-inspiron-14-plus-7441: fix touchscreen i2c address

Charlie-cy Wu (1):
      wifi: mt76: connac2: fill TXD spe_idx for connac2 fixed-rate frames

Chen Cheng (1):
      md/raid5: reject raid4/5 arrays with too few disks

Chen Pei (2):
      perf test: Fix a leaked map reference in the arch dwarf unwind tests
      selftests/bpf: Enable arena LDSX tests for riscv64

Chen-Yu Tsai (7):
      drm/verisilicon: Switch to drm_fb_dma_get_addr() for framebuffer addresses
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

Cheng-Yang Chou (1):
      selftests/sched_ext: Fix rt_stall runner abort

Chengchang Tang (1):
      RDMA/hns: Fix missing CQE when UD QP use different SL

Chi Zhiling (2):
      exfat: fix used_clusters accounting during cluster allocation
      exfat: take bitmap_lock at the start of exfat_alloc_cluster()

Chien Wong (2):
      wifi: mac80211: fix encryption tailroom
      wifi: mac80211: reserve MME tailroom for protected beacons

Chris Lu (4):
      Bluetooth: btmtksdio: Remove redundant firmware filename override
      Bluetooth: btmtksdio: Pass the hardware device id to mt79xx_setup()
      Bluetooth: btmtk: Validate the firmware layout before parsing it
      Bluetooth: btmtk: Improve BT firmware logging

Chris Mason (6):
      nvmet-rdma: flush nvmet-wq on module exit
      nvmet-rdma: disable interrupts under rsp_wr_wait_lock
      nvmet-rdma: fix double puts after a failed RDMA WRITE
      nvmet: don't clear sq->ctrl for a Connect with sqsize 0
      rnbd-srv: fix use-after-free on two CLOSE messages
      rnbd-srv: publish the sess_dev at the end of OPEN

Chris Morgan (1):
      arm64: dts: rockchip: Correct Device Orientation on Gameforce Ace

Chris Scott (1):
      wifi: mt76: mt7996: refresh the tx BA session timer on NPU devices

Christian Aurich Zanettini Martins (2):
      nvme-tcp: fix use-after-free in nvme_tcp_free_ctrl()
      nvme-rdma: fix NULL metadata_sgl dereference with T10-PI

Christian Brauner (2):
      selftests/coredump: discard the right amount after the coredump request
      super: convert to plain hashtable

Christian Loehle (1):
      ACPI: CPPC: Validate the _CPC package header

Christoph Hellwig (9):
      block: avoid integer overflows in max_integrity_io_size
      block: cap atomic write size by PI buffer size constraints
      block: improve aligning down bios in bio_iov_iter_bounce_write
      block,iomap: fix protection information verification with initial bvec offset
      zloop: remove a duplicate call to zloop_get_block_size
      zloop: share more code for opening a zone backing file
      zloop: fput file after failed zone init
      zloop: check that the zone backing file support ->{read,write}_iter
      zloop: fix block size query

Christopher Snowhill (1):
      media: em28xx: hold the vb2 queue lock when releasing the queue on close

Chuanhong Guo (1):
      pinctrl: mediatek: mt7629: fix the 2.4 GHz Wi-Fi pin mode array

Chuck Lever (4):
      NFS: use TCP for MOUNT when xprtsec= selects TLS
      SUNRPC: reject a client-side TLS alert record that is not two octets
      SUNRPC: treat every client-side TLS error alert as fatal
      tls: Honor O_NONBLOCK in tls_sw_splice_read()

Chukun Pan (1):
      arm64: dts: rockchip: remove FRL GPIO for 100ASK DshanPi A1

Ciro Pedrini (1):
      platform/x86: hp-wmi: Add OMEN board 8A17 thermal profile support

Colin Ian King (1):
      selftests/bpf: Fix spelling mistakes in descr literal strings

Cong Nguyen (2):
      leds: lm3692x: Fix regulator/gpio leak and wrong enabled state on last write failure
      staging: media: tegra-video: fix syncpoint leak in tegra20 channel init

Conor Dooley (1):
      pinctrl: mpfs-mssio: fix whitespace in debugfs output

Cosmin Ratiu (3):
      net/mlx5e: Stop asserting for RTNL when closing channels
      net/mlx5e: SHAMPO: Do not merge PSP packets
      net/mlx5: Only set num_doorbells on a fully initialized SF

Cristian Ciocaltea (5):
      drm/connector: hdmi: Handle reset() state allocation failure
      phy: rockchip: samsung-hdptx: Handle PHY config after module reload
      drm/rockchip: dw_hdmi_qp: Fix invalid drvdata access in PM ops
      drm/rockchip: dw_hdmi_qp: Cancel pending HPD work on suspend
      drm/rockchip: dw_hdmi_qp: Add missing newlines in dev_err_probe() messages

Cristian Papa (2):
      wifi: mt76: mt7603: don't drop short frames looped back on PS entry
      wifi: mt76: feed the station RSSI average from the chain signals

Crystal Wood (1):
      rtla/tests: Use absolute path for $RTLA

Daasaradhi Mannava (1):
      platform/x86: msi-ec: Report valid charge thresholds when unset

DaeMyung Kang (1):
      ksmbd: round SetAllocation to the advertised allocation unit

Dairui Zhang (1):
      IB/mad: fix UAF and double-free in RMPP receive reassembly

Dale Whinham (2):
      platform/surface: aggregator_registry: Remove sensors device for Surface Pro 11
      platform/surface: aggregator_registry: Fix tablet-mode detection on Surface Pro 11

Damien Le Moal (5):
      scsi: core: Define all additional sense codes and their qualifiers
      scsi: core: Rename sense field of struct scsi_failure
      scsi: core: Prepare for using combined sense codes
      scsi: scsi_debug: Use combined sense codes
      scsi: core: Fix additional sense code definition

Dan Carpenter (6):
      soc: qcom: smem: Fix signedness bug in smem_dram_parse()
      wifi: mm81x: fix type bugs handling sdio_readl/writel()
      wifi: b43: don't pass unterminated string to sscanf()
      wifi: b43legacy: debugfs: NUL terminate string in debugfs
      wifi: carl9170: NUL terminate string in debugfs
      mm/hmm/test: reject overflowing page counts

Daniel Borkmann (9):
      bpf, lsm: Reject writes into the BPF LSM program context
      bpf: Avoid quadratic successor rescan in bpf_compute_scc
      bpf: Bound the number of indirect jump edges in a program
      bpf: Rebase the exception callback subprog when dead subprogs are removed
      bpf: Leave out the hidden exit edge of a subprogram without an exit
      bpf: Don't remove indirect jump targets in the nop removal pass
      bpf: Clear insn array jitted pointers on map reuse
      bpf: Clear the insn array used flag with release semantics
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

Daniel Zahka (4):
      selftests: drv-net: psp: swap closed for connected sockets in assoc tests
      net: psp: require an established connection for association setup
      net: psp: drop psp assoc clear in sk_clone()
      selftests: drv-net: psp: test that rx-assoc fails on closed and listen socks

Danila Chernetsov (2):
      dlm: validate lock modes in recovery messages
      dlm: fix NULL pointer dereference in dlm_dump_rsb_name()

Danilo Krummrich (1):
      rust: workqueue: replace deprecated system_wq with system_{percpu,dfl}_wq

Danish Khateeb (10):
      tools/nolibc: fix WIFSIGNALED() for status 0
      tools/nolibc: fix verrx() and errx() message formatting
      tools/nolibc: fix readdir_r() with 64-bit directory offsets
      tools/nolibc: fix FD_SET(), FD_CLR() and FD_ISSET() on 64-bit
      pwm: Allow 32-bit tasks to use the character device
      tools/nolibc: stop rounding malloc() sizes up to 4096 bytes
      tools/nolibc: check for overflow in malloc()
      serial: 8250: Fix section mismatch with CONFIG_MODULES=n
      pps: generators: wake up PPS_GEN_FETCHEVENT readers on unregister
      kselftest/filelock: plan for the five ofdlocks tests

Dario Binacchi (1):
      clk: validate spread spectrum configuration

Darren Carreras (1):
      libbpf: Avoid overflow in BTF.ext bounds check

Dave Jiang (25):
      cxl/ras: Pass the PCI device's struct device to match_memdev_by_parent()
      efi/cper: Reject CPER records with an out-of-range error_data_length
      efi/cper: Reject an error status block length that wraps a u32
      ACPI: extlog: Validate elog record length before walking sections
      ACPI: extlog: Avoid populating software AER metadata from raw hardware buffer
      ACPI: extlog: Validate PCIe error section length before payload access
      ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo
      ACPI: APEI: GHES: Bound CXL event record copy to the firmware section length
      ACPI: extlog: Defer CXL protocol error handling to avoid lock inversion
      ACPI: APEI: GHES: Validate CXL protocol error section length before RAS cap copy
      efi/cper: Read only validated fields in cper_mem_err_pack()
      ACPI: APEI: GHES: Validate memory error section length before payload access
      ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata
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
      cxl/core: Hold the dport host lock across dport lookup and use
      cxl/port: Attach endpoints to a dport under the lock that pins it

David Carlier (2):
      phy: qcom: qmp-pcie: Select MFD_SYSCON for the multi-PHY driver
      phy: qcom: qmp-pcie: Check clock-output-names count in the multi-PHY driver

David Heidelberg (2):
      ASoC: wcd-mbhc-v2: Fix incorrect properties names and typos
      serial: qcom-geni: power the console back up on system resume

David Hildenbrand (Arm) (3):
      mm/userfaultfd: wake waiters when registration modes are removed
      mm/madvise: preserve VMA_SOFTDIRTY_BIT when changing anonymous names
      mm/hugetlb: disable PMD sharing for UFFD missing mode

David Howells (4):
      rxrpc: Revert "rxrpc: rxperf: Fix missing decoding of terminal magic cookie"
      rxrpc: Fix rxperf test rxgk key kvno to be 0
      rxrpc: Fix aborting in rxperf test server
      rxrpc: Fix sendmsg length

David Yang (1):
      net: dsa: yt921x: Check lock status with lockdep_assert_held_once()

David Zhang (1):
      accel/amdxdna: Reject device heap BO when dev_mem_size is not set

Davidlohr Bueso (1):
      cxl/test: Map mock device nodes to an online node

Denis Benato (1):
      HID: asus: document and harden the worker teardown

Denis Kulikov (1):
      ksmbd: use the resolved share path for the share root

Dennis Gilmore (1):
      arm64: dts: rockchip: Use GPIO function for PCIe reset on Orange Pi 5 Pro

Detlev Casanova (4):
      arm64: dts: rockchip: Rename rk3328 HDMI audio card
      arm64: dts: rockchip: Rename rk3566 and rk3568 HDMI audio cards
      arm64: dts: rockchip: Rename rk3576 HDMI audio card
      arm64: dts: rockchip: Rename rk3588 HDMI audio cards

Devin Wittmayer (8):
      wifi: mt76: mt7921: fix lock inversion between dev->mutex and iflist_mtx
      wifi: mt76: mt7925: fix lock inversion between dev->mutex and iflist_mtx
      wifi: mt76: mt7921: check drv_pmctrl return in the PCIe reset path
      wifi: mt76: mt7925: check drv_pmctrl return in the PCIe reset path
      wifi: mt76: mt7921: fix the lock inversion in suspend and resume
      wifi: mt76: mt7925: fix the lock inversion in suspend and resume
      wifi: mt76: mt7921: honour FIF_FCSFAIL instead of hardcoding drop_err
      wifi: mt76: mt792x: defer the MCU shutdown past unregister on USB

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

Dmitry Antipov (2):
      leds: flash: Prevent using uninitialized variable in flash_fault_show()
      tcp_bpf: propagate error code in tcp_bpf_sendmsg()

Dmitry Baryshkov (9):
      ARM: dts: qcom: msm8974: add MDSS reset
      Revert "media: iris: Add Gen2 firmware autodetect and fallback"
      media: iris: fail firmware boot on invalid uc_region
      media: iris: take core lock when scanning the instance list
      media: iris: guard against a NULL hfi_sys_ops in the interrupt handler
      media: iris: reject open() when the session limit is reached
      media: iris: reference count video instances
      drm/msm/mdp5: drop cursor pipe for msm8x76
      drm/msm/a5xx: don't read the GPMU registers on GPUs without a GPMU

Dmitry Morgun (1):
      fs/ntfs3: check return values in indx_delete_entry()

Dmitry Sinyavin (1):
      serial: msm: select PM_OPP

Dmitry Torokhov (1):
      gpio: crystalcove: add missing MODULE_ALIAS()

Dmytro Laktyushkin (1):
      drm/amd/display: Enable dcn42 pstate pmo

Dominic White (1):
      wifi: cfg80211: allow zero HE OBSS PD offsets

Dominik Maier (1):
      xattr: always invoke cap_convert_nscap() for security.capability writes

Donggeun Yoo (6):
      regulator: pf1550: fix division by zero in the ramp rate selection
      iommufd: Keep reserved IOVA ranges when a replace within one IOAS fails
      tracing: Print the bucket size as unsigned
      tracing: Only report the stacktrace modifier on a real field
      tracing: Clamp the printed end of a histogram bucket at U64_MAX
      tracing: Print a signed histogram key as signed

Dudu Lu (5):
      net/sched: etf: initialise the sock_exterr_skb before filling it
      net/sched: gred: keep the qdisc lock while updating the table
      net/sched: taprio: unwind the netdevice notifier if register_qdisc() fails
      net: xps: bound the cleanup loop by the old map's num_tc
      net-sysfs: reject a one-entry RPS flow table

Eason Lai (1):
      wifi: mt76: mt7925: Fix MCU command timeouts during module unload

Eduard Zingerman (2):
      bpf: Fix arg_track_xfer() for atomic stack spills and fills
      bpf: Save DFS postorder numbers for program instructions

Edward Adam Davis (1):
      kernel/reboot: avoid potential deadlocks during suspension

Eklavya Singh (1):
      ocfs2/heartbeat: serialize concurrent writes to a region's dev attribute

Emil Tsalapatis (5):
      bpf: Use an llist for page allocations
      bpf: Add sleepable argument to bpf_alloc_pages()
      bpf: Add sleepable arena page allocation path
      bpf: Revalidate faulted arena pages before installing user mappings
      bpf: Fix arena race between page free and alloc leading to incoherency

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: fix the VHT MCS sent to a v1 firmware

Endrik Einberg (1):
      wifi: iwlwifi: mld: include VI packets in low latency detection

Eric Anderson (1):
      mfd: rk8xx: Register poweroff handler in atomic phase

Eric Dumazet (23):
      inet: frags: bound the wmem charge of the socket completing a reassembly
      sit: fix UAF in ipip6_tunnel_del_prl()
      sit: charge ip_tunnel_prl_entry allocations to memcg
      ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup
      net: synchronize proc_do_rss_key() with netdev_rss_key_fill()
      ipv4: fix IP ID reuse in ip_select_ident_segs()
      ipv4: reserve one IP ID per segment for UDP GSO packets
      bng_en: pad short frames before sampling nr_frags
      Bluetooth: btmtk: fix skb double free on ISO padding failure
      ipv4: use RCU protection in inet_netconf_get_devconf()
      tcp: use the echoed source route in cookie_v4_check()
      tcp: tcp_metrics: use the socket netns, not the dst device netns
      ipv6: account route exceptions to the netns of their dst
      ip6mr: clear skb->cb[] in reg_vif_xmit()
      net: shrink the payload-only part of skb dataref to one bit
      net: fix frag_list leak in skb_segment_list() error path
      net: harden qdisc_pkt_len_segs_init() against malicious GSO packets
      ipmr: clear skb->cb[] in reg_vif_xmit()
      ppp: linearize and segment bridged packets when required
      net: add eth_type_trans_careful()
      loopback: use eth_type_trans_careful()
      net: use eth_type_trans_careful() in __dev_forward_skb2()
      openvswitch: use eth_type_trans_careful() in internal_dev_recv()

Eric Joyner (1):
      ionic: free port_info when probe fails after the port is set up

Esben Haabendal (2):
      dt-bindings: iio: light: ltr501: Sort compatible enum array
      dt-bindings: iio: light: ltr501: Add missing ltr303 compatible

Esteban Urrutia (2):
      clk: qcom: dispcc-sm8450: Fix disp_cc_mdss_mdp_clk_src ops
      clk: qcom: alpha-pll: Check Lucid Ole PLL status before configuring

Ethan Tidmore (1):
      wifi: mt76: mt7925: Remove useless condition

Eva Kurchatova (1):
      hugetlbfs: enforce F_SEAL_EXEC in setattr

Even Xu (2):
      HID: Intel-thc-hid: Intel-quicki2c: Use hid_safe_input_report()
      HID: Intel-thc-hid: Intel-quickspi: Use hid_safe_input_report()

Fabrice Derepas (2):
      crypto: asymmetric_keys - fix OOB read in pefile_parse_binary
      ima: reject a kexec buffer whose declared size exceeds the buffer

Fabrice Gasnier (3):
      ARM: dts: stm32: fix vdda supply for onboard hub on stm32mp15 DK boards
      ARM: dts: stm32: fix vdda supply for onboard hub on stm32mp157c-ev1
      ARM: dts: stm32: fix vdda supply for onboard hub on stm32mp135f-dk

Fan Wu (1):
      ipe: fix enforcement audit

Fangzhi Zuo (3):
      drm/amd/display: Exit IPS before connector detection on resume
      drm/amd/display: Force FreeSync range minimum on quirky panels
      drm/amd/display: Restore FreeSync VCP code check for HDMI/PCON sinks

Felix Fietkau (32):
      wifi: mt76: check the owner of a remain-on-channel request
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
      wifi: mt76: mt7996: update the address of an AP link that is added again
      wifi: mt76: mt7996: size the MLD setup TLV by the links it describes
      wifi: mt76: mt7996: find the last MLD link among the links torn down
      wifi: mt76: mt7996: upload only the keys of the link being set up
      wifi: mt76: mt7996: report station statistics from the primary link
      wifi: mt76: mt7996: clear all link wcid entries in sta_pre_rcu_remove
      wifi: mt76: mt7996: free the WTBL index if a link allocation fails
      wifi: mt76: mt7996: pick the secondary link from links with driver state
      wifi: mt76: mt7996: make a returning link primary if a station has none
      wifi: mt76: mt7996: do not reuse the deflink of a removed station link
      wifi: mt76: mt7996: keep a returning link when adding station links fails
      wifi: mt76: mt7996: add the station BMC entry as new once per BSSID
      wifi: mt76: mt7996: keep 4-address and decap state per station
      wifi: mt76: mt7996: fix PLE free page and AC queue register offsets
      wifi: mt76: mt7996: fix the hw-queues debugfs queue requests
      wifi: mt76: mt7996: refuse scan and ROC until the hardware restart is done
      wifi: mt76: report an aborted scan or ROC to mac80211 during a reset
      wifi: mt76: mt7921: fix of_node reference leaks in regd update
      wifi: mt76: mt792x: compute the assoc RSSI from the chain signals
      wifi: mt76: keep beacons from queueing the scan work during an abort
      wifi: mac80211: use link address as TA for non-MLO 4-addr station on MLD AP

Felix Gu (4):
      spi: omap2-mcspi: Remove unbalanced pm_runtime_put_sync() calls
      spi: mtk-nor: fix runtime PM usage count leak in probe error path
      PCI: dra7xx: Fix clock enable leak on probe failure
      spi: mxic: fix ps_clk leak in runtime resume

Felix Hoffmann (1):
      wifi: mm81x: validate YAPS receive framing

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
      btrfs: fix duplicated code in fs state string in logged messages
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

Francesco Dolcini (4):
      arm64: dts: ti: k3-am69-aquila: fix AQUILA_B73 gpio-line-names typo
      arm64: dts: ti: k3-am62-verdin: fix main_gpio0/main_gpio1 line names size
      arm64: dts: ti: k3-am62-verdin-ivy: Fix main_gpio0/main_gpio1 line names size
      arm64: dts: ti: k3-am62-verdin-zinnia: Fix main_gpio0/main_gpio1 line names size

Francesco Valla (1):
      spi: virtio: fix max frequency setting

Frank Wunderlich (1):
      arm64: dts: mediatek: mt7988a-bpi-r4pro: label gpio-hogs

Fuad Tabba (7):
      arm64: pi: Run the source checker on the libfdt objects under C=2
      of/irq: Fix device node refcount leak in of_check_msi_parent()
      irqchip/gic-v3: Release the partition node in gic_irq_get_fwspec_info()
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

Gael Blivet (2):
      ksmbd: fix AFP_AfpInfo header fields in synthesized xattr
      ksmbd: print IPv6 client addresses correctly in procfs

Gaghik Khachatrian (1):
      drm/amd/display: gate DCE ASIC code behind CONFIG_DRM_AMD_DC_DCE

Gal Pressman (1):
      net/mlx5e: IPsec, Fix out-of-bounds comparison of neighbour keys

Gao Xiang (1):
      erofs: drop unnecessary .read_folio() checks for file-backed mounts

Geert Uytterhoeven (4):
      clk: rs9: Add clock index range check to rs9_of_clk_get()
      dt-bindings: interrupt-controller: chrp,open-pic: Typo s/pci/pic/
      dt-bindings: interrupt-controller: chrp,open-pic: Fix dangling reference
      pmdomain: renesas: r8a78000: Fix lockdep false positive

George Abraham P (1):
      crypto: qat - force an edge when re-enabling all VF2PF interrupts

George Melikov (1):
      bnx2x: fix header length calculation for encapsulated TSO

Georgi Djakov (1):
      thermal/drivers/qcom-spmi-temp-alarm: Fix temp_map indexing

Georgios Androutsopoulos (3):
      rust: clk: document overflow panics in `Hertz` constructors
      rust: id_pool: document panics in `find_unused_id` and `release_id`
      rust: bitmap: document panics in `next_bit` and `next_zero_bit`

Ginger Li (2):
      media: i2c: ov5648: Fix a data race on state->streaming
      wifi: mac80211: Fix a race when expiring a mesh path

Giuseppe Scrivano (2):
      fs: rename vfs_get_super() to get_tree_super() and export it
      erofs: reuse superblock for file-backed mounts

Golla Nagendra (3):
      dmaengine: zynqmp_dma: Fix PM rollback on sw_desc_pool alloc failure
      dmaengine: zynqmp_dma: Free sw_desc_pool on desc_pool_v alloc failure
      dmaengine: zynqmp_dma: Fix chan probe/remove error handling

Gongwei Li (1):
      wifi: rtw89: coex: Fix wrong constant check of GPIO MUX signal

Gopikrishna Garmidi (1):
      soc: qcom: smem: fix 32-bit overflow in DDR frequency calculation

Greg Kroah-Hartman (2):
      mm/gup: honour FOLL_PIN in NOMMU __get_user_pages_locked()
      Linux 7.3.6

Greg Ociepka (2):
      arm64: dts: qcom: glymur: Add missing USB clock, power and bandwidth votes
      arm64: dts: qcom: glymur: Mark USB controllers dma-coherent

Greg Thelen (1):
      selftests/net: tcp_mmap: remove unused -k option and keepflag

Gregor Herburger (1):
      arm64: dts: broadcom: bcm2712-d-rpi-5-b: add compatible

Gregory CLEMENT (1):
      phy: cadence: Sierra: Do not modify register when getting parent clock

Gregory Price (1):
      mm/userfaultfd: compare exact registration modes before skipping

Gregory Price (Meta) (2):
      cgroup/cpuset: use mems_allowed_seq when checking a policy nodemask
      cgroup/cpuset: check effective mems for a movable-only configuration

Guanghui Feng (1):
      iommu/vt-d: Fix IQE handling to cover all descriptors in submission range

Guanghui Yang (1):
      btrfs: roll back sprout setup after device add failure

Guangshuo Li (8):
      media: i2c: ar0521: remove duplicate media entity cleanup
      media: i2c: t4ka3: drop unmatched runtime PM put
      platform/x86/intel/vsec: reset state before re-enumerating
      media: staging/ipu7: release ISYS firmware resources on remove
      spi: fsl: unmap immr_spi_cs on remove
      spi: bcm63xx-hsspi: Disable runtime PM on remove
      floppy: unregister platform device on add_disk failure
      soc: mpfs: use kref cleanup on probe failure

Guenter Roeck (1):
      hwmon: (coretemp) Fix 32-bit jiffies wraparound in show_temp()

Gui-Dong Han (1):
      xen/blkback: Prevent missed completion when draining I/O

Guixin Liu (10):
      cxl/pci: Skip reset detection for DVSEC emulated decoders
      cxl/cdat: Fix uninitialized stack use in bandwidth gathering
      cxl/port: Fix uninitialized coordinates reported for RCDs
      cxl/core: Fix dport use-after-free via the einj_inject debugfs file
      cxl/region: Unregister the pmem region when the bridge is unbound
      cxl/region: Create node access attributes for CFMWS-only NUMA nodes
      cxl/core: Skip einj_inject creation when devm_add_action_or_reset() fails
      driver core: Add conditional guard support for device_trylock()
      cxl/memdev: Fix deadlock between poison debugfs and cxl_mem unbind
      cxl/pci: Update only the Port GPF timeout fields

HOYOUNG SEO (1):
      scsi: ufs: core: Change the error check sequence for auto hibern8

Haibo Chen (2):
      arm64: dts: imx95-15x15-frdm: fix duplicated can-phy node names
      leds: pca9532: Check i2c_smbus_read_byte_data() return value

Haitam Lazaar (1):
      RDMA/siw: Enforce IB_ACCESS_REMOTE_READ for read responses

Hal Feng (1):
      riscv: dts: starfive: Correct pwm nodes

Hang Nan (1):
      ntfs: reject index blocks with a too small entries offset

Hangbin Liu (1):
      selftests: gro: remove unused variable total_data

Hannes Laimer (1):
      vxlan: keep reserved_bits across changelink

Hans Zhang (1):
      PCI: cadence: Fix enum type mismatch warning in LTSSM debugfs

Hao Sun (2):
      bpf: Fix uninit read for non-fetch atomics on partially spilled slots
      bpf: Fix uninit read for helper mem args on partially spilled slots

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

Heiko Carstens (13):
      s390/ptrace: Preserve ILC when updating system call number
      s390/uprobes: Fix off-by-one bug in emulated PER handling
      s390/early: Fix early warning handling
      s390/percpu: Add sanity check to GEN_MVIY macro
      s390/percpu: Let MVIY_PERCPU() calculate alternative displacement
      s390/percpu/lowcore: Add and use LC_PERCPU lowcore offset defines
      s390/percpu: Rename inline assembly symbolic names
      s390/percpu: Use __PCPU_BEGIN() and __PCPU_END() for inline assemblies
      s390/percpu: Use percpu code section for this_cpu_cmpxchg128()
      s390/percpu: Use percpu code section for this_cpu_xchg()
      s390/percpu: Use percpu code section for this_cpu_cmpxchg()
      s390/percpu: Rework to simplify percpu_entry() and percpu_exit()
      s390/percpu: Use asm_inline for arch_this_cpu_add()

Helge Deller (2):
      fbdev: atafb: fix sparse warnings
      fbdev: atafb: avoid cast when assigning buffer address pointer

Hemanth Selam (1):
      nvdimm/pmem: Release gendisk on probe failure

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

Hisam Mehboob (1):
      vfio: selftests: Include <libgen.h> for basename() on non-glibc builds

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

Howard Hsu (1):
      wifi: mt76: mt7996: do not add a station link in disconnected state

Hui Peng (1):
      fuse: validate folio state before pipe_buf_try_steal() in fuse_try_move_folio()

Hui Su (8):
      perf synthetic-events: Fix schedstat event lifetime handling
      bpftool: Fix CPU IDs in per-CPU map output
      bpftool: Fix sparse CPU IDs in prog profile
      perf synthetic-events: Check schedstat domain allocation failure
      sched/mmcid: Fix affinity-triggered switch back to per-task mode
      sched_ext: Reject oversized automatic CID shards
      hrtimer: Add cleanup class for on-stack timers
      sched/idle: Use hrtimer cleanup class in play_idle_precise()

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

Hyunchul Lee (5):
      ntfs: fix FITRIM bitmap indexing for large pages
      ntfs: require page-aligned full-page attribute writes
      ntfs: avoid misclassifying directory reparse points
      ntfs: accept standard sparse compression unit
      ntfs: only require compressed size on first extent

Ian Bridges (1):
      ksmbd: fix SMB2 CREATE response buffer overflow in compound requests

Ian Gallagher (1):
      ACPI: button: Add lid_init_state quirk for Razer Blade Stealth 13 (Early 2020) RZ09-0310

Ian Rogers (28):
      perf test: Avoid call to missing cleanup function
      perf stat: Avoid uninitialized memory read on error
      perf header: Fix potential memory corruption in cpu_cache_level__read
      perf record: Fix unhandled POLLHUP on non_perf_event descriptors
      perf libdw: Fix Dwfl discovery with split files
      perf dso: Separate libbfd and cmd addr2line caches to fix confusion
      perf libbfd: Report success when an address is found
      perf libbfd: Fix the clang -Wthread-safety build failure
      perf symbol: Fix the build when demangling with libbfd
      perf build: Only pass clang flags to CXX when CXX is clang
      perf build: Use the given CC rather than clang in clang builds
      perf build: Check the version of the compiler that is used
      perf build: Remove leftovers of removed build options
      perf machine: Add session back pointer to fix out of bounds read
      perf test code-reading: Fix duplicate kernel maps and machine leak
      perf build: Clean libperf-gtk.so in 'make clean'
      perf vendor events intel: Fix clearwaterforest umask encoding.
      perf vendor events intel: Fix lunarlake umask encoding.
      perf vendor events intel: Fix sierraforest umask encoding.
      perf vendor events intel: Fix skylakex umask encoding.
      perf vendor events intel: Fix snowridgex umask encoding.
      perf evsel: Clamp sample_id size for ksymbol, bpf, and text_poke events
      perf python: Initialize debug output on module load
      perf pmu: Fix race with concurrent tracepoint creation and removal in perf list
      perf trace: Copy sockaddr arguments by their length
      perf thread_map: Add thread_map__tgid()
      perf lock contention: Filter events before creating lock_stat
      perf libdw: Optimize fallback logic for missing DWARF

Icenowy Zheng (1):
      drm: verisilicon: fix cursor offset field update

Ido Schimmel (2):
      bridge: mcast: Delete empty MDB entry when port group creation fails
      ipv6: Hold RCU when emitting route hardware flags notification

Igor Belwon (2):
      arm64: dts: mediatek: mt6878-pinfunc: Fix pinctrl header path
      arm64: dts: mediatek: mt6893-pinfunc: Fix pinctrl header path

Igor Skalkin (1):
      usb: gadget: dummy_hcd: fix SuperSpeed ep0 maxpacket

Igor Velkov (3):
      arm64: dts: amlogic: meson-sm1-odroid-hc4: mux the SPI NOR HOLD# and WP# pins
      arm64: dts: amlogic: meson-sm1-odroid-hc4: run the SPI NOR at 40 MHz
      power: supply: gpio-charger: Report discharging without input power

Ihor Solodrai (6):
      selftests/bpf: NUL-terminate bpftool command output
      selftests/bpf: Add tests for bpftool btf dump format c
      bpftool: Don't drop a type in the sorted C dump
      x86/cpu: Factor init_cpu_info() out of identify_cpu()
      x86/cpu: Inline generic_identify() into identify_cpu()
      x86/cpu: Don't transiently clear the boot CPU's capabilities

Imre Kaloz (2):
      rtc: ds1685: arm the wake-up alarm at power-off only if an alarm is set
      rtc: ds1685: do not sleep in the power-off handler

Ionut Nechita (1):
      x86/crash: Reserve elfcorehdr for CONFIG_NR_CPUS, not CONFIG_NR_CPUS_DEFAULT

Ivan Hu (1):
      ACPICA: Initialize parser_state.aml_end in acpi_install_method()

Ivan Vecera (6):
      dpll: zl3073x: do not offer 0 Hz as a supported pin frequency
      dpll: zl3073x: reject inexact frequencies for N-divided outputs
      dpll: zl3073x: reject output frequencies with too small divisor
      dpll: zl3073x: make embedded sync follow the output carrier frequency
      dpll: zl3073x: notify sibling pin when shared output config changes
      selftests: tc-testing: use $IP in hfsc test 8c39 setup

Jack Wang (1):
      md: fix mddev_unlock() called without holding lock in lbs_store()

Jacob Keller (2):
      ice: use reference counting and SRCU for PTP port access
      ice: set in_use only after preparing Tx timestamp index

Jacob Moroni (3):
      RDMA/irdma: Fix erroneous -ENOMEM for large MR registration
      RDMA/core: Clear driver_udata before destroying objects in rdma_core
      RDMA/irdma: Fix FRWR IRDMAQPSQ_PBLADDR field population

Jacobs Wu (2):
      wifi: mt76: mt7925: support deferred NAN schedule update and cluster events
      wifi: mt76: mt7925: fix HT/VHT caps and rates for NAN NDP peers

Jaewon Jung (1):
      selftests/ftrace: Avoid unlink error on first run

Jagadeesh Kona (3):
      clk: qcom: rpmhcc: Add LNBB clocks support for Glymur
      clk: qcom: gcc-glymur: Use clk_regmap_phy_mux_ops for GCC UFS muxes
      clk: qcom: Fix camera rivian PLL configuration settings

Jake Labelle (1):
      nilfs2: reject non-regular inodes in dsync recovery

Jakub Kicinski (7):
      netlink: specs: devlink: describe DEVLINK_ATTR_NESTED_DEVLINK
      netlink: specs: devlink: describe the netns id in the parent-dev nest
      eth: bnxt: recycle agg buffers when Rx head buffer allocation fails
      eth: bnxt: resize Rx head buffers when rx-copybreak changes
      eth: bnxt: don't leak buffers when XDP agg buffer allocation fails
      eth: bnxt: free XDP frags when xdp_do_redirect() fails
      eth: bnxt: hand XDP frags over to the copybreak skb

Jamal Hadi Salim (1):
      net/sched: act_api: reject duplicate actions in a batch

James Clark (4):
      perf buildid-list: Fix empty output for AUX data
      perf python: Track linked libraries as extension dependencies
      perf cs-etm: Don't add global v0 HW_IDs to unformatted queues
      net: ethernet: ti: am65-cpts: fix support for PTP_EXTTS_REQUEST2 ioctl

James Hilliard (5):
      mtd: rawnand: sunxi: propagate user-data allocation errors
      mtd: rawnand: sunxi: reserve a full user-data word for BBM
      mtd: rawnand: sunxi: use a stack buffer for BBM randomization
      xsk: freeze deferred pool teardown without blocking unregister
      net: stmmac: avoid duplicate XSK TX completions

James Lin (1):
      drm/amd/display: Cast DP DTO pixel clock math to avoid overflow and narrowing

James Morris (1):
      riscv: dts: spacemit: k3-com260: keep dldo4 enabled

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

Jeff Chen (3):
      wifi: nxpwifi: fix return value check in change_vif_to_sta/ap
      wifi: nxpwifi: fix missing error codes in _nxpwifi_fw_dpc()
      wifi: mwifiex: append hotfix number to firmware version string

Jeff Johnson (2):
      wifi: ath9k: use rcu_dereference_bh() for sta->rates in ath_merge_ratetbl()
      wifi: ath11k: fix reg_info_store leak in ath11k_service_ready_ext_event()

Jemmy Wong (1):
      sched/cache: Avoid publishing partial LLC utilization

Jennifer Berringer (1):
      riscv: dts: spacemit: set console baud rate on OrangePi RV2

Jens Remus (1):
      perf evsel: Improve callchain warning for s390

Jeremy Bongio (1):
      RDMA/irdma: Use kvzalloc for lvl2 leafmem allocation

Jerome Brunet (2):
      clk: fix self-consuming provider module pinning
      clk: cdce925: Size the PLL child name buffer for any int

Jesse Zhang (1):
      drm/amdgpu/userq: fix reading the WPTR at a non-zero BO offset

Jhonata Poma-Hansen (1):
      netlink: check sk_rcvbuf before charging the dump skb

Jia Wang (3):
      dmaengine: dw-axi-dmac: Fix AXI burst length encoding
      dmaengine: dw-axi-dmac: Fix LLI dump out-of-bounds access
      dmaengine: dw-axi-dmac: Fix CH_CFG2 channel priority position

Jiale Yao (31):
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
      wifi: ath12k: avoid IDR mutation during pending mgmt TX cleanup
      wifi: ath12k: avoid IDR mutation during vif mgmt TX cleanup
      platform/olpc: Reserve space for a string terminator
      clocksource/drivers/timer-ti-dm: Handle runtime resume failure
      ntfs: drain in-flight DIO before buffered write fallback
      team: reject CAN, IEEE 802.15.4 and 6LoWPAN devices in team_port_add
      Drivers: hv: vmbus: Check ACPI companion before use
      mshv_vtl: initialize poll file mutex before device registration
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

Jiayuan Chen (8):
      libbpf: Fix usdt attach failure when nop10 crosses page boundary
      bpf: arena: Allocate the fault-in page outside the lock
      tcp_bic: fix divide by zero on max_increment == 0
      tcp_hybla: fix divide by zero on rtt0 == 0
      tcp_cubic: fix divide by zero and endless loop on bad module params
      veth: clear rx queue hint in veth_xmit
      bpf: Fix verifier WARN on narrow read of bpf_tcp_sock u64 fields
      tls: fix the open record check in the max payload size setsockopt

Jie Zhang (1):
      dt-bindings: display/msm/gmu: Fix Glymur's compatible

Jiebin Sun (2):
      perf c2c: Fix documented default coalesce fields
      perf tests c2c: Report skip when the workload fails

Jijie Shao (1):
      net: hibmcge: set netdev_ops before hbg_init() to fix NULL pointer dereference

Jingbo Xu (1):
      fuse: don't bump attr_version for async direct read completion

Jinpyo Lee (1):
      nfs/localio: pin UUIDs during global invalidation

Jisheng Zhang (3):
      regulator: mp886x: fix vsel_mask
      regulator: mp886x: check get_voltage_sel() return value
      regulator: mp886x: fix pontential division by zero

Joachim Eastwood (2):
      arm64: dts: rockchip: fix missing sdmmc cd pinctrl on rk3588s-nanopi-r6
      arm64: dts: rockchip: fix missing pcie rst pinctrl on rk3588s-nanopi-r6

Joanne Koong (1):
      fuse: zero the correct range on a short read reply

Joas Antonio dos Santos (4):
      calipso: hash the cache key, not the option start, in calipso_cache_add()
      calipso: update payload_len when removing the CALIPSO option
      net: dcb: initialize PFC value before calling getpfccfg
      net: mctp: free reassembly head skb when key_add fails on SOM

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
      wifi: nl80211: reject zero RNR/MBSSID elements
      wifi: mac80211: init radiotap iter after length checks
      wifi: mac80211: limit injected HT/VHT MCSes
      wifi: mac80211: fix mbssid/rnr allocation in beacon data
      wifi: cfg80211: reg: protect regdb pointer with RCU
      wifi: cfg80211: track SSID regardless of country data

Johannes Thumshirn (1):
      btrfs: zoned: fix double list add in btrfs_load_block_group_zone_info

John Crispin (2):
      wifi: mt76: mt7996: disable the RX NAPIs before the DMA cleanup
      wifi: mt76: scan all radios of a request at the same time

John Johansen (3):
      apparmor: remove unconfined_profile() check in inet socket mediation
      apparmor: fix check SCTP bind, and connect permission checks
      apparmor: advertise that sctp is being mediated

John Stultz (1):
      sched: Switch rq->next_class in proxy_reset_donor()

Jonathan Santos (2):
      spi: axi-spi-engine: fix stale SYNC IRQ pending
      spi: axi-spi-engine: fix stale SYNC IRQ pending in trigger_enable

Joonhoe Kim (5):
      drm/msm/dpu: disable the slave encoder before the master
      drm/msm/dpu: compute the CRTC bandwidth from the state being checked
      drm/msm/dpu: round up the compressed INTF width
      ASoC: codecs: wcd939x: read the SoundWire port switches per channel
      power: supply: qcom_battmgr: report the USB type from USB_ADAP_TYPE

Josef Bacik (70):
      mm/shmem: hold off eviction in shmem_writeout()
      bpf: Use the frame mem type in devmap egress XDP
      bpf: Forbid sleeping in hash map for_each callbacks
      bpf: Don't leak the inode when token creation fails
      bpf: Don't hand out a linked element as extra element
      bpf: Reject sleepable programs for task_vma iterator
      bpf: Forbid sleeping in bpf_find_vma() callbacks
      bpf: Look at all 64 bits of a BPF_JSET mask on 32-bit
      bpf: Don't let bpf_skb_adjust_room() use up the MSS
      bpf: Read the probe of a perf event under event_mutex
      bpf: Don't saturate owner_refcnt on the last unpin
      bpf: Validate the SRH which End.DT6 uncovers in End.BPF
      bpf: Pull the inner header for End.DT6 in End.BPF
      bpf: Update the SRH state if End.B6 fails late
      bpf: Fix NULL deref in the sk_storage map iterator
      bpf: Hold the socket in the sk_storage map iterator
      bpf: Bound the nesting that the BTF show code follows
      bpf: Fix stale offload->prog pointer after realloc
      bpf: Don't bind a program to a netdev that goes away
      bpf: Keep a program until its bpf_wq callback has ended
      bpf: Count sleepable callbacks as sleepable map users
      bpf: Check the maps that sleepable callbacks use
      bpf: Assume no bounds for buffers behind a tail call
      bpf: Don't take an extension for an iterator program
      bpf: Assume no bounds for a writable tp with tail calls
      bpf: Free what map_free() unlinks for sleepable readers
      bpf: Keep values of a dead owner for sleepable programs
      bpf: Keep the symbols of a program until it has ended
      bpf: Use the socket of a sk_lookup test run under RCU
      bpf, cpumap: Hold the device of frames in the queue
      bpf: Let bpf_dynptr_write() mark a global function
      bpf: Don't take a dynptr argument for a local dynptr
      bpf: Follow the head if an skb is written from a slice
      bpf: Use memmove() to store bytes in an skb
      nvmet: don't truncate the length of big discards
      nvmet-auth: take only AUTH_Negotiate for a negotiation
      nvmet: fix NULL dereference of PCI endpoint targets
      nvmet-tcp: stop listening when a port is removed
      nvmet: fix NULL dereference in debugfs host_traddr
      nvmet-tcp: don't read a removed port at Connect time
      nvme-loop: don't BUG() if a scan runs beside a reset
      blk-cgroup: keep the old blkg while reassociating a bio
      blk-iocost: free struct ioc after a grace period
      blk-throttle: don't truncate the cgroup v1 iops limits
      blk-cgroup: fix root io.stat byte counts on 32-bit
      blk-cgroup: don't free a blkg with its punt work queued
      blk-iolatency: flush enable_work after going offline
      blk-throttle: pass the I/O counts of a dead group on
      blk-throttle: make blkio.reset_stats reset I/O counts
      block: don't enter reclaim under rq_qos_mutex
      writeback: don't kick a missing wb for dontcache writes
      fork: Let nobody keep a task that may not come to life
      namei: don't assert S_ISDIR on a stale rcu-walk inode
      block: fix use-after-free of the disk in sync_bdevs()
      block: don't lose the status of a failed flush request
      blk-mq: don't trust the cookie in blk_mq_poll()
      blk-mq: keep sharing tags fairly after a queue update
      blk-mq: don't bring back flags of a completed request
      blk-mq: don't forget a timer the driver has restarted
      blk-mq-dma: initialize the dma state for P2P, too
      blk-mq: quiesce a queue that joins a quiesced tag set
      blk-mq: exit the hctxs of a queue under tag_list_lock
      blk-mq: set up a queue under tag_list_lock
      block: partitions/mac: compute the sectors in 64 bits
      blk-mq: free the bitmaps of tags in the SRCU callback
      block: apply the segment size to the integrity buffer
      drbd: stop the start_resync timer of a dying device
      drbd: take req_lock to skip the initial sync as peer
      block/rnbd-srv: don't free the device on a sysfs error
      block/rnbd-srv: drop the sess_dev kobject unlocked

Joseph Guo (1):
      arm64: dts: imx93-11x11-frdm: factor out common parts into dtsi

Joseph Qi (8):
      dlm: fix buffer overflow from negative len in dlm_search_rsb_tree
      ocfs2: fix deadlock in inline-data truncate transactions
      ocfs2: defer suballocator block group reclaim to workqueue
      ocfs2: allow xattr bucket entries to span multiple blocks
      ocfs2: reject inconsistent xattr bucket during defrag
      ocfs2: retain all security xattrs during inode creation
      ocfs2: fix possible deadlock between nfs_sync_rwlock and fs_reclaim
      ocfs2: reserve xattr value tree metadata only once

Ju Nan (1):
      pinctrl: stm32: Fix the unit of the hwspinlock timeout

Judith Mendez (1):
      arm64: dts: ti: k3-am62l-evm: Remove unnecessary internal pullups for MMC0

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

Junbin Zhang (1):
      sched_ext: Reject rq-lock-taking kfuncs in tracing programs

Junhui Liu (11):
      riscv: dts: spacemit: k3: Drop guest properties from M-level IMSIC
      clk: sunxi-ng: div: Add feature support to M clock macro
      clk: sunxi-ng: sun55i-a523-ccu: Use M-only clocks for MBUS, IOMMU and DRAM
      clk: sunxi-ng: sun55i-a523-ccu: Use P-only clocks for high-speed timers
      clk: sunxi-ng: sun55i-a523-r-ccu: Use P-only clocks for timers
      dt-bindings: timer: thead,c900-aclint-mtimer: Add SpacemiT K3
      dt-bindings: interrupt-controller: thead,c900-aclint-mswi: Add SpacemiT K3
      dt-bindings: interrupt-controller: thead,c900-aclint-sswi: Add SpacemiT K3
      dt-bindings: timer: sifive,clint: Remove spacemit,k3-clint
      irqchip/aclint-sswi: Add support for SpacemiT K3
      riscv: dts: spacemit: k3: Replace incorrect CLINT node with ACLINT nodes

Junjie Cao (1):
      Bluetooth: btusb: drop BROKEN_EXT_SCAN quirk for 0bda:a728

Junxian Huang (3):
      RDMA/hns: Limit gmv_entry_num to avoid memory waste
      RDMA/hns: Fix GID capacity loss in 64K system
      RDMA/hns: Fix the use of uninitialized variable

Justin Yeh (2):
      arm64: dts: mediatek: mt8188-geralt: Enlarge SCP core0 memory region
      HID: i2c-hid: Unfollow the panel on shutdown

Jérémie Rodon (1):
      spi: cs42l43: Add speaker ID quirk for Dell XPS 13 DX13260 SKU 0E54

Jérémy Jean (11):
      microblaze: prevent ptrace writes to MSR and pt_mode
      crypto: rsassa-pkcs1 - reject undersized keys when signing
      crypto: rsassa-pkcs1 - reject undersized keys when verifying
      md: reject v0.90 arrays with too many devices
      crypto: asymmetric_keys/x509 - copy X.509 TBS for data signature algorithms
      crypto: asymmetric_keys/pkcs7 - Check all signers before waiving authattrs rejection
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

KaFai Wan (4):
      selftests/bpf: Fix prog_tests framework subtest count checks
      selftests/bpf: Skip expected_msgs subtests when stdout is not saved
      selftests/bpf: Fix stack arg pruning test JOIN log expectation
      selftests/bpf: Use _exit() in uprobe_multi_test clone-ed child

Kaifeng Wang (2):
      net: devmem: check uid and netns in net_devmem_get_binding()
      tcp: reject devmem tx with fastopen and repair

Kang Yang (7):
      wifi: ath12k: preserve PPDU state across monitor status buffers
      wifi: ath12k: fix skb leak on paddr mismatch in wifi7 mon RX pop
      wifi: ath12k: free pending MSDUs on duplicate mon link descriptor
      wifi: ath12k: fix stale tail_msdu pointer returned from mpdu_pop
      wifi: ath12k: place dp_mon_mpdu on stack in mon dst reap loop
      wifi: ath12k: fix skb leak on monitor PPDU ID wraparound
      wifi: ath12k: avoid double DMA unmap of held monitor RX buffers

Karl Asseily (1):
      dt-bindings: vendor-prefixes: add ESS Technology

Karl Mehltretter (49):
      ocfs2/cluster: hold a reference on the heartbeat thread
      ABI: sysfs-class-infiniband: Drop the entries of the removed qib driver
      irqchip/gic-v3-its: Don't WARN on LPI free allocation failure
      virtio_ccw: fix synchronize_cbs() after interrupt fallback
      virtio_ccw: always take irq_lock in the classic interrupt handler
      mtd: spinand: Fix spinand_manufacturer_ops kernel-doc
      power: supply: mp2629: Use the full batt_impedance_compensation name in the ABI document
      efi/libstub: Fix efi_set_event_at() parameter documentation
      cpufreq/amd-pstate: Remove obsolete amd_dynamic_epp documentation
      crypto: lskcipher - preserve state across unaligned chunks
      firewire: cdev: Fix FW_CDEV_IOC_CREATE_ISO_CONTEXT references in kernel-doc
      clk: mediatek: reset: Fix device registration kernel-doc
      spi: Fix the return value in spi_new_ancillary_device() kernel-doc
      ata: libata-scsi: Fix ata_scsi_hotplug() reference in kernel-doc
      gfs2: Fix the return value in gfs2_get_link() kernel-doc
      ALSA: control: Fix virtual master creation reference in kernel-doc
      cgroup/dmem: Fix eviction helper reference in dmem_cgroup_try_charge()
      regulator: qcom-rpmh: Fix the return value in rpmh_regulator_vrm_get_optimum_mode() kernel-doc
      dma-fence: Fix dma_fence_enable_signaling() reference in kernel-doc
      wifi: mac80211: Fix the return value in mesh_path_add() kernel-doc
      block: Fix the thaw_bdev reference in bdev_freeze() kernel-doc
      loadpin: Fix stale KEXEC_VERIFY_SIG reference in documentation
      pinctrl: stm32: Drop the nonexistent CONFIG_MACH_STM32MP25 from the STM32MP257 default
      clk: aspeed: ast2700: select AUXILIARY_BUS
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
      wifi: nxpwifi: return timeout error from nxpwifi_sdio_poll_card_status()
      thermal: ti-soc-thermal: Fix the return value in ti_bandgap_get_sensor_data() kernel-doc
      serial: ma35d1: Do not force-enable an unselected console
      ARM: 9486/1: set !LPAE MAX_PHYSMEM_BITS to 32 and remove supersection mappings
      ARM: 9492/1: alignment: fix LSR #32 and ASR #32 offset decoding
      mm/slub: initialize the free pointer of the bootstrap kmem_cache_node
      rtc: class: Make the time32 hctosys limit configurable
      net: phy: realtek: restore RTL8211F RGMII delays on resume
      netfs: Restore selective debug mask handling
      fs: fix ramfs_fs_info leak when rootfs is unmounted

Karol Kolacinski (1):
      ice: E822: keep Tx timestamps disabled during offset calibration

Kate Hsuan (1):
      media: i2c: imx471: Fix register size for IMX471_REG_DPGA_USE_GLOBAL_GAIN

Kees Cook (5):
      randstruct: fix container_of() false positives after __mptr removal
      kbuild: Mark the initcall ordering recipe as recursive
      seq_buf: Do not print an empty line from an overflowed seq_buf_do_printk()
      seq_buf: Do not pop from an overflowed seq_buf
      mm/slab: Mark the kmem_buckets_create() context as a Context: section

Keguang Zhang (1):
      pwm: loongson: Reload PWM configuration through counter reset

Keisuke Tsukuda (2):
      usb: gadget: composite: avoid warning on aborted delayed status
      usb: gadget: f_mass_storage: ignore class requests while inactive

Kent Gibson (1):
      gpiolib: fix memory leak in gpiod_set_array_value_complex() EPERM error path

Kevin Dewald (1):
      Bluetooth: hci_event: Fix LE link drop on remote features command status

Kim Wooseok (3):
      wifi: rtl8xxxu: free RX skb when URB submission fails
      wifi: rtl8xxxu: unwind incomplete receive startup
      wifi: rtl8xxxu: preserve RX requests across recoverable transfer errors

Kiran K (3):
      Bluetooth: btintel_pcie: sync mbox tlv parsing with GP0 alive interrupt
      Bluetooth: btusb: Preserve event and ACL packet ordering
      Bluetooth: btintel: Zero version data before parsing TLVs

Kohei Enju (1):
      arm64: rsi: Correct type of realm_config::hash_algo

Koichiro Den (5):
      PCI: endpoint: pci-epf-vntb: Pass PF/VF number when BAR programming
      PCI: endpoint: pci-epf-vntb: Serialize virtual PCI bus scan
      PCI: endpoint: pci-epf-vntb: Track link state from both sides
      PCI: endpoint: pci-epf-vntb: Use a local epf pointer in interrupt setup
      PCI: endpoint: pci-epf-vntb: Honor MSI-X selection

Konrad Dybcio (16):
      dt-bindings: display: panel: samsung,s6e8aa5x01: Allow common properties
      arm64: dts: qcom: glymur-asus-zenbook-a16: Fix up the mic sample rate
      interconnect: qcom: Move bcm_div() to common code
      interconnect: qcom: icc-rpm: Don't skip small votes
      interconnect: qcom: icc-rpm: Handle icc_link_create() failures
      interconnect: qcom: icc-rpm: Program SMD RPM auxiliary QoS ports
      interconnect: qcom: msm8996: Configure auxiliary Venus QoS port
      interconnect: qcom: msm8976: Configure auxiliary GPU QoS port
      interconnect: qcom: use 64-bit SMD RPM bus votes
      arm64: dts: qcom: glymur-asus-zenbook-a16: Remove RTC-through-EFIvars
      soc: qcom: pmic_glink: Avoid losing early rpmsg probe
      clk: qcom: gcc-x1e80100: Don't poll the status bit of GCC_USB4_n_SYS_CLK
      clk: qcom: rcg2: Initialize shared floor clock state
      clk: qcom: rcg2: Propagate force-enable status errors
      clk: qcom: rcg2: Clear force enable after rate failure
      PCI: qcom: Ignore -ENODEV after Root Port reset

Konstantin Komarov (2):
      fs/ntfs3: validate EA entry layout against ef->size in ntfs_read_ea
      fs/ntfs3: take ni_lock() once in ntfs_readdir()

Kris Pan (1):
      net: iterate online nodes in skb_defer_free_flush()

Krishna Chaitanya Chundru (1):
      phy: qcom: qmp-pcie: Refactor common multiphy handling

Kristen Carlson Accardi (1):
      platform/x86/intel: power-domains: Handle failed init in tpmi_get_linux_die_id()

Krzysztof Kozlowski (3):
      drm/msm: Properly handle msm_ioremap() without name
      dt-bindings: display/msm: hdmi: Correct name of disallowed supplies
      irqchip/qcom: Enable compile testing for QCOM_PDC and QCOM_MPM

Krzysztof Wilczyński (3):
      PCI/sysfs: Stop reporting _DSM failures as -EPERM
      PCI/sysfs: Handle a malformed _DSM result in acpi_attr_is_visible()
      PCI/sysfs: Decouple acpi_index from the optional device name element

Kumar Kartikeya Dwivedi (10):
      bpf: Reject oversized stream read buffers
      bpf: Check fastcall stack contract once for all stack accesses
      bpf: Add accessors for verifier stack slots
      bpf: Skip zero-length stream writes
      bpf: Widen the stack slot index in the jump history
      bpf: Size liveness stack masks by the stack each frame uses
      bpf, riscv: Fix stack-passed arguments for indirect trampolines
      bpf: Report non-sleepable kfunc programs accurately
      libbpf: Keep the fd_array fill index out of bpf_program__clone()
      LoongArch: BPF: Fix stack arguments for indirect trampolines

Kunhai Dai (1):
      blk-iocost: publish hweights as one atomic value

Kuniyuki Iwashima (1):
      ipv6: Protect multiple routes insertion by table lock.

Kunwu Chan (1):
      rcutorture: Fix divide-by-zero with fwd_progress_div=1

Kuppuswamy Sathyanarayanan (2):
      PCI/ACPI: Tidy _OSC control bit checking
      PCI/ACPI: Centralize pcie_ports_native checking

Kyle Pepper (1):
      Bluetooth: hci_sync: scan unfiltered for host-resolved RPAs

Kyle Zeng (3):
      gro: do not GRO GSO packets with inconsistent payload
      tcp: avoid double destroy in tcp_abort() of an unaccepted child
      tcp: initialize mapped children before route lookup

Kyrylo Biryuk (1):
      ata: libahci: re-enable FBS after error handling on a port multiplier

Lachlan Hodges (2):
      wifi: mac80211: don't seed an S1G sta's last_rate
      wifi: mm81x: move beacon work and init below the tx op

Lad Prabhakar (3):
      arm64: dts: renesas: r9a09g077: Drop unwired ADC interrupts
      arm64: dts: renesas: r9a09g087: Drop unwired ADC interrupts
      dt-bindings: iio: adc: renesas,r9a09g077-adc: Drop unwired interrupts

Lance Yang (1):
      mm/memory_hotplug: fix missing rollback in __add_pages()

Laurence Oberman (2):
      scsi: st: Restore changed drive settings after reset also for MTLOAD and MTRETEN
      scsi: st: Record the tape position after a successful MTLOAD

Le Ma (1):
      drm/amdgpu: disable GFX clockgating for GC 12.1.0

Le Qi (1):
      ASoC: codecs: da7213: Get MCLK in I2C probe

Lee Jia Jie (1):
      perf: Fix UAF in attach_task_ctx_data()

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
      perf test: Record kcore for the CoreSight callchain test
      perf build: Build the Python extension before pylint consumers

Leon Hwang (2):
      selftests/bpf: Avoid flaky resize value test for percpu data
      bpftool: Compute map size of light skeletons at runtime

Leon Romanovsky (9):
      RDMA/irdma: Preserve fast-registration IOVA on 32-bit
      PCI/P2PDMA: Do not tear down the allocate attribute on registration failure
      PCI/P2PDMA: Wait for RCU readers before freeing state
      PCI/P2PDMA: Safely terminate ACS redirect lists
      PCI/P2PDMA: Gate the host bridge whitelist warning on verbose
      dma-debug: Skip cacheline tracking for MMIO mappings
      RDMA/core: Preserve the selected source GID on failed AH modification
      RDMA/core: Free unpublished port statistics after initial-read failure
      RDMA/core: Reject LAG selection when source MAC lookup fails

Li RongQing (13):
      RDMA/nldev: Put the device when dellink fails
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

Li Youhong (3):
      spi: ma35d1-qspi: assert reset on probe error paths
      spi: amlogic-spisg: check clk_prepare_enable() return value
      md/raid5: drain released_stripes before destroying the cache

Liam R. Howlett (Google) (1):
      tools/testing/shared: catch a failed posix_memalign()

Liang Hao (1):
      timers: Clear pending_map on CPU hotplug

Lijo Lazar (2):
      drm/amdgpu: Add workaround to enable GCv12.1 MGCG
      drm/amdgpu: Move GC v12.1 spm vmid init to hw init

Linkai Gong (6):
      drivers/base/node: fix UAF on device_register() failure
      firmware: imx: dsp: fix mailbox channel leak on kasprintf failure
      misc: enclosure: fix UAF on device_register() failure
      clk: imx: composite-93: return timeout from gate enable
      mailbox: arm_mhuv2: time out if the receiver never comes up
      char: scx200_gpio: check cdev_add() return value

Linkui Xiao (1):
      net: bridge: netlink: do not clear the vlan info dump error

Linmao Li (8):
      soc: qcom: smem: Fix byte order in v3 14-frequency parser
      wifi: mm81x: free the firmware scratch buffer on parse failures
      wifi: mm81x: do not discard a failed firmware segment write
      power: supply: bq2515x: Propagate charge-enable read errors
      crypto: mxs-dcp - handle zero-length skcipher requests
      serial: 8250_mxpcie: set the driver data before registering ports
      serial: 8250_mxpcie: only unregister the ports that were registered
      serial: 8250_mxpcie: take the line settings from the new termios

Linus Torvalds (2):
      vhost: vringh: use get_user()/put_user() for IOTLB 16-bit accesses
      vdpa_sim: disable page faults around vringh_need_notify_iotlb()

Linus Walleij (47):
      regulator: ab8500: Fix AB8505 VANA voltage selectors
      regulator: ab8500: Add AB8505 VAUX3 3.05 V setting
      regulator: ab8500: Handle AB8505 VINTCORE selector 7
      regulator: ab8500: Treat cut 1.0 VAUX3 as fixed
      regulator: ab8500: Test dedicated enable bits only
      regulator: ab8500: Propagate mode enable read errors
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
      dmaengine: ste_dma40: Fix cyclic transfer residue
      dmaengine: ste_dma40: Recover coalesced cyclic callbacks
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
      dmaengine: ste_dma40: Preserve the LCPA I/O address space

Liu Dalin (3):
      rtc: ftrtc010: fix clock resource leak on probe failure
      rtc: ftrtc010: use devm clock APIs to fix use-after-disable in remove
      rtc: ftrtc010: fix integer overflow in time calculation

Liviu Nicoara (1):
      power: supply: qcom_battmgr: Report capacity on X1E80100

Lizhi Hou (9):
      accel/amdxdna: Fix unexpected wait when flushing notifier_wq
      accel/amdxdna: Fix possible use-after-free when freeing device BO
      accel/amdxdna: Disable BO import via flink
      accel/amdxdna: Fix potential deadlock in BO open and close callbacks
      accel/amdxdna: Fix unsafe use of handle_mm_fault()
      accel/amdxdna: Fully initialize map structure before registering notifier
      accel/amdxdna: Fix race between unmap and free BO
      accel/amdxdna: Set HMM_PFN_REQ_WRITE for writable BO faults
      accel/amdxdna: Preallocate hardware context schedulers

Logan Gunthorpe (5):
      dmaengine: switchtec-dma: fix double-free in switchtec_dma_free_desc()
      dmaengine: switchtec-dma: fix resource leak in alloc_chan_resources
      dmaengine: switchtec-dma: fix channel leak on registration failure
      dmaengine: ioat: disable relaxed ordering before registering the device
      dmaengine: plx_dma: fix NULL pointer deref in plx_dma_isr()

Logan Odell (1):
      PCI/IOV: Read VF config values that need not match PF

Long Zhao (1):
      dt-bindings: vendor-prefixes: add Ambarella

Longfang Liu (2):
      hisi_acc_vfio_pci: fix NULL dereference in reset_prepare on PF passthrough
      hisi_acc_vfio_pci: reject live migration on 64KB page with QM_HW_V3 hardware

Longlong Xia (1):
      rcu: fix shrink budget underflow in lazy_rcu_shrink_scan

Lorenzo Bianconi (5):
      net: stmmac: fix TX coalesce race and div-by-zero in XDP/legacy path
      net: stmmac: set real_num_tx_queues to max(offset + count)
      net: stmmac: align real_num_tx_queues to mqprio configuration
      netfilter: flowtable: reset transport header after nf_flow_encap_pop()
      PCI/pwrctrl: Power off child devices on power-on failure

Lorenzo Stoakes (ARM) (7):
      mm: do not unintentionally overwrite atomic VMA flags
      mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
      mm/vma: avoid spurious write locks when mm->mm_lock_seq overflows
      mm/vma: avoid losing atomic VMA flags when setting sticky VMA flags
      fs/proc/task_mmu: fix missed VMAs when reading /proc/PID/maps and friends
      kbuild: do not allocate .modinfo in vmlinux
      ALSA: us122l: mark hwdep mappings VM_MIXEDMAP

Lu Baolu (5):
      iommu/vt-d: Do not ignore context table copy failures
      iommu/vt-d: Handle DID reservation errors when copying context tables
      iommu/vt-d: Reserve scalable-mode DIDs from PASID entries during copy
      iommu/vt-d: Fix iopf refcount leak in nested attach
      iommu/vt-d: Drop old iopf ref only after attach succeeds

Lu Yao (2):
      drm/amd/display: Fix wrong plane index in dcn6 writeback latency loop
      drm/amdkfd: drop KFD_QUEUE_TYPE_DIQ note

Luca Leonardo Scorcia (1):
      clocksource/drivers/timer-mediatek: Fix random crash at boot

Luca Weiss (1):
      arm64: dts: qcom: sm7225-fairphone-fp4: Disable PMK8350 PON

Lucas Costa (1):
      staging: sm750fb: free cmap on framebuffer release

Lucas Tanure (1):
      clk: meson: t7: keep the memory fabric clocks running

Luiz Augusto von Dentz (7):
      Bluetooth: Move H:4 reassembly into the Bluetooth core
      Bluetooth: MGMT: Fix advertising instances with Global Advertising
      Bluetooth: HCI: Fix tracking of instances sharing handle 0x00
      Bluetooth: MGMT: Fix pending state of instances added without HCI traffic
      Bluetooth: MGMT: Fix leaking instance on Add Extended Advertising Parameters
      Bluetooth: MGMT: Allow connection rate request as peripheral
      Bluetooth: Fix the LE Read Connection Interval response layout

Luka Gejak (1):
      wifi: rtw88: sdio: zero the padding added to a TX transfer

Maciej Strozek (2):
      ASoC: SDCA: Improve scanning the SWFT during FDL
      ASoC: SDCA: Check return value on a missing FDL_Set_Index Range

Mahad Ibrahim (1):
      selftests/filesystems: Add .gitignore for fscontext_ns_test

Mahe Tardy (1):
      libbpf: fix log level propagation for light skeleton loaders

Mahesh Saran (1):
      wifi: mt76: mt7921: clear WM2 from MT7902 RX all_complete_mask

Maksim Krasutski (1):
      ALSA: hda/realtek: Fix mute LEDs on HP ENVY 17-cr1xxx

Malathi A (1):
      serial: 8250_uniphier: Use devm_clk_get_enabled()

Malte Wechter (1):
      rnull: configfs: add power to configfs features

Mani Tofigh (1):
      bpf: Fix bpf_timer callback running on a freed map

Manish Awasthi (1):
      net: mana: Introduce gdma_bus_ops for bus-specific operations

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

Manush Prajwal (2):
      leds: max77705: Use fwnode_for_each_child_node_scoped() in max77705_add_led()
      pwm: lp3943: fix NULL pointer dereference for an unconfigured channel

Marc Kleine-Budde (4):
      spi: spi-sun4i: sun4i_spi_transfer_one(): fix transfers for SUN4I_FIFO_DEPTH
      spi: spi-sun4i: sun4i_spi_fill_fifo(): always apply A10 FIFO fill level workaround
      spi: spi-sun4i: sun4i_spi_transfer_one(): fix setting of clock rate
      spi: spi-sun4i: sun4i_spi_handler(): fix race condition between transfer completion and RX FIFO interrupt

Marcel Hofmann (1):
      remoteproc: imx_rproc: Allow mappings ending at region boundary

Marco Giunta (1):
      ASoC: aw88399: skip BSTS check when boost converter is bypassed

Marco Scardovi (2):
      platform/x86: asus-wmi: Add ASUS_WMI_DEVID_DGPU_POWER_STATE define
      platform/x86: asus-armoury: Prevent disabling dGPU when in use

Marek Maslanka (1):
      platform/chrome: cros_ec_typec: Poll for role swap completion

Marek Szyprowski (8):
      dma-direct: Restore arch_dma_alloc() for the DMA_ATTR_NO_KERNEL_MAPPING case
      ARM: 9519/1: dma-mapping: Fix wrong free function in __iommu_alloc_simple() error path
      ASoC: wm8994: fix MCLK gating for AIF clocks sourced from MCLK2
      ASoC: wm8994: don't lose the AIF clock ratio when staying at 32kHz SYSCLK
      ASoC: wm8994: fix MCLK index used for setting MCLK rate
      ASoC: samsung: midas_wm1811: run FLL1 at the AIF1 configured rate when idle
      ASoC: wm8994: follow AIF clock source changes in MCLK gating
      ASoC: codecs: wsa881x: Fix shared powerdown GPIO handling

Marek Vasut (4):
      drm: of: Fix drm_of_get_data_lanes_count_ep() return value documentation
      ARM: dts: stm32: Drop bias-disable from STM32MP15xx DHCOM SoM sdmmc1_b4_pins_a
      arm64: dts: renesas: ironhide: Align inline ECC carveout sizes with bootloader settings
      PCI: rcar-gen4: Add missing PM ops

Marek Wesołowski (1):
      ntfs: fix directory lookup on large-page systems

Mario Limonciello (3):
      cpufreq: amd-pstate: Restore previous mode when changing driver mode fails
      cpufreq: amd-pstate: Propagate cppc_set_auto_sel() errors on mode change
      platform/x86/amd: pmc: Drop scratch_reg from amd_1ah_m80_cpu_info

Mark Amirkan (2):
      perf evsel: Validate branch stack before byte swapping
      perf evsel: Validate RAW sample before byte swapping

Mark Anthony Agarro (3):
      wifi: mt76: mt7925: honour mac80211's FIF_FCSFAIL instead of hardcoding drop_err
      wifi: mt76: mt7921: keep the join ROC until the station is authorized
      wifi: mt76: mt7925: keep the join ROC until the station is authorized

Markus Probst (3):
      rtc: s35390a: Add missing newline to dev_err
      rtc: s35390a: Fix alarm not disabling
      rtc: s35390a: Read 24-hour mode on access

Markus Schneider-Pargmann (TI) (7):
      arm64: dts: ti: k3-am62a-phycore-som: Fix wkup R5F memory region size
      arm64: dts: ti: k3-am62d2-evm: Fix wkup R5F memory region size
      arm64: dts: ti: k3-am62a7-sk: Fix wkup R5F memory region size
      arm64: dts: ti: k3-am62p-verdin: Fix wkup R5F memory region size
      arm64: dts: ti: k3-am62p5-sk: Fix wkup R5F memory region size
      arm64: dts: ti: var-som-am62p: Fix wkup R5F memory region size
      clocksource/drivers/timer-ti-dm: Register clocksource/event only for am654

Masoud Aghasi (2):
      bpf: Fix incorrect handling of user flags in bpf_percpu_array_update
      bpf: Fix incorrect handling of user flags by percpu hash map updates

Mateusz Nowicki (3):
      arm64: dts: st: fix arm,smc-id of the SMC watchdog on stm32mp2
      arm64: dts: st: fix sai3b unit address on stm32mp251
      arm64: dts: st: fix sai3b unit address on stm32mp231

Matheus Alves de Almeida (1):
      HID: wacom: fix wacom_intuos_irq NULL pen_input deref

Matt Turner (3):
      alpha: select SYSCTL_EXCEPTION_TRACE
      perf thread: Fix live-session detection in thread__e_machine()
      alpha: fix stale user_stack_pointer()

Matteo Kloiber (1):
      rust: scatterlist: honor the device's maximum segment size

Matthew Wood (1):
      bpf, arm64: Fix racy plt target update in bpf_arch_text_poke()

Matthias Goergens (7):
      x86/hibernate: Ignore page-zero RAM in E820 checksum
      isofs: return long Joliet names whole
      ntfs: reject non-resident attributes whose sizes exceed their allocation
      ntfs: set the attribute list size before reserving space for it
      ntfs: restart the zone search when the allocation hint fails
      ntfs: do not refuse fallocate() when the MFT zone is empty
      ntfs: do not give a contiguous cluster allocation a second run

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

Maurizio Lombardi (1):
      nvme-pci: fix early boot hang with nvme.quirks parameter

Max Kellermann (1):
      ceph: remove unused field `i_cap_migration_resv`

Maxim Skokov (1):
      bpf: test_run: Fix false -EBADMSG after skb leaves CHECKSUM_COMPLETE

Maxime Bélair (4):
      apparmor: fix a leak on a rejected string table entry
      apparmor: report a label allocation failure as -ENOMEM
      apparmor: fix table_size() integer overflow on 32 bit
      apparmor: convert duplicated dfa transitions to match_char()

Maxime Chevallier (1):
      net: Use a dedicated flag to track disabled napi instances

Maxime Ripard (1):
      drm/atmel-hlcdc: Drop spurious csc_init call from reset

Maíra Canal (4):
      drm: Move drm_timeout_abs_to_jiffies() to drm_timeout.c
      drm: Add drm_timeout_rel_to_jiffies()
      drm/vc4: Use drm_timeout_rel_to_jiffies()
      drm/vc4: Drop the undocumented brcm,vc4-v3d compatible

Melissa Wen (8):
      drm/amd/display: use translate_curve_to_degamma_hw_format on DCN30
      drm/amd/display: assign missing trace entry in amdgpu_dm_dc_clocks_state
      drm/amd/display: remove duplicated prev_p_state_change_support assignment
      drm/amd/display: fix vready offset assignment in dcn_optc_lock_unlock_state
      drm/amd/display: declare amdgpu_dm_atomic_state_template as an event class
      drm/amd/display: use right type for amdgpu_dc_performance event entries
      drm/amd/display: copy function name into dcn_fpu trace event
      drm/amd/display: copy function name into dcn_optc_lock_unlock_state trace event

Miaoqing Pan (3):
      wifi: ath11k: fix sporadic WLAN initialization failures
      wifi: ath11k: fix NULL dereference in ahb remove when QMI init incomplete
      wifi: ath11k: unregister PM notifier on QMI init failure path

Michael Auer (1):
      ASoC: qcom: sdm845: Disable the quaternary MI2S bit clock on shutdown

Michael J. Ruhl (1):
      platform/x86/intel/pmt: complete pcidev to device update

Michael Petlan (2):
      perf test attr: Propagate the return value from the test to the wrapper
      perf test attr: Fix wrong size expectation for events

Michael S. Tsirkin (2):
      virtio: synchronize callbacks after device reset
      virtio_pci_modern: move avq cleanup from reset to del_vqs

Michail Andreas Michalopoulos (3):
      ksmbd: reject FILE_ATTRIBUTE_TEMPORARY on directories
      ksmbd: select CRYPTO_AES
      apparmor: check address length before reading AF_UNSPEC bind address

Michal Pluta (2):
      perf test demangle: Fail when demangling fails
      perf symbol: Don't return an unterminated Rust demangle buffer

Michał Kopeć (3):
      ASoC: mediatek: common: Keep codec references until the card is bound
      ASoC: mediatek: Don't keep a freed topology name in the static card
      ASoC: mediatek: mt8188: Constrain UL8 FE to its back end's capabilities

Miguel Ojeda (1):
      rust: zerocopy: fix link to upstream `README.md`

Mika Penttilä (1):
      drm/tests: hdmi: fix infoframes tests

Mike Snitzer (3):
      pNFS/flexfiles: honor FF_FLAGS_NO_IO_THRU_MDS over the mdsthreshold hint
      pNFS/flexfiles: don't read through MDS when previous layout forbid it
      pNFS/flexfiles: don't reset to MDS for v4 error when previous layout forbid it

Mikhail Lobanov (1):
      wifi: ath11k: modify null check logic in ath11k_ce_rx_post_pipe()

Mikko Perttunen (4):
      ARM: tegra: Add core supply for Tegra114 boards
      drm/tegra: Fix syncobj_in wait return value check
      drm/tegra: Don't pass an ERR_PTR to drm_syncobj_replace_fence()
      drm/tegra: Drop reference on postfence

Miklos Szeredi (4):
      fuse: don't fill in.h.pid in case args->nocreds is set
      fuse: fall back to copy_splice_read() on FOPEN_DIRECT_IO
      fuse: fix NULL pointer dereference in fuse_request_find
      dax: add fsdev_dax_from_file()

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

Miquel Raynal (1):
      spi: ma35d1-qspi: Allow DTR operations with the regular SPI API

Miquel Raynal (Schneider Electric) (1):
      clk: Use the generic OF phandle parsing in only one place

Mohamad Raizudeen (2):
      crypto: amlogic - Fix DMA memory leak in cipher error path
      PCI: Fix out-of-bounds MMIO read in nvme_disable_and_flr()

Mohammed Alquraini (1):
      ksmbd: reject foreign RPC pipe handles on IPC$ read and write

Mohd Ayaan Anwar (4):
      arm64: dts: qcom: lemans-evk: fix SerDes PHY regulator supplies
      arm64: dts: qcom: lemans-ride-common: fix SerDes PHY regulator supplies
      arm64: dts: qcom: monaco-evk: fix SerDes PHY regulator supplies
      arm64: dts: qcom: qcs8300-ride: fix SerDes PHY regulator supplies

Mostafa Saleh (5):
      iommu/arm-smmu-v3: Ensure L2 tables are visible before L1 ptrs
      iommu/arm-smmu-v3-test: Fix arm_smmu_v3_test_debug_print_used_bits()
      iommu/arm-smmu-v3-test: Add missing error checks for inv array
      iommu/arm-smmu-v3-test: Fix OOB in arm_smmu_v3_invs_test_verify()
      iommu/arm-smmu-v3-test: Fix UBSAN error

Muchun Song (1):
      dax/bus: Return errors for invalid mapping targets

Muhammad Bilal (5):
      crypto: ccp - fix SFS ioctl race against device teardown
      wifi: mm81x: check bytes_remaining before reading delimiter
      platform/x86: hp-bioscfg: fix off-by-one in password length check
      platform/x86: hp-bioscfg: validate SPM state returned by firmware
      platform/x86: hp-bioscfg: fix oops on short integer attribute buffer

Mukesh Kumar Chaurasiya (IBM) (2):
      powerpc: fix NMI exit ordering: restore soft masks after irqentry_nmi_exit()
      powerpc/kasan: fix r2 corruption in mem*() on GENERIC_ENTRY with old compilers

Mukesh Ojha (3):
      firmware: qcom: tzmem: Use DO_ONCE_SLEEPABLE() in qcom_tzmem_enable()
      firmware: qcom_scm: handle empty PAS resource table
      firmware: qcom_scm: align PAS resource table retry

Muzaffer Kadir (1):
      dt-bindings: vendor-prefixes: Add General Mobile

Myeonghun Pak (14):
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

Mykyta Yatsenko (3):
      bpftool: Accept zero perf counter snapshots
      bpftool: Group profile events by CPU
      bpftool: Scale counters and report cycles per run

Nam Cao (1):
      rv/rtapp/wakeup: Use "rv_this" the rv_monitor variable

Naman Gulati (1):
      netdev-genl: ignore NETDEV_UNREGISTER rebroadcasts

Namhyung Kim (3):
      perf symbol: Fix symbol loading from libbfd
      perf symbol: Add missing symsrc__destroy() for libbfd
      perf c2c: Fix memory leaks on output fields

Namjae Jeon (11):
      ntfs: sync attribute inode size after resize
      ntfs: clear stale pagecache on initialized-size extension
      ntfs: propagate EA truncate errors
      ntfs: fix NULL dereference on index allocation open failure
      ksmbd: disconnect on invalid encryption transform flags
      ksmbd: cache the resolved share path for durable reconnects
      ksmbd: fix durable reconnects for root shares
      ksmbd: keep lease tables until their last lease is closed
      ksmbd: inherit FileIds in related compound requests
      ksmbd: fix fd_limit accounting across durable reconnects
      ksmbd: return complete and aligned stream information

Nandor Kracser (1):
      tls: avoid field-spanning write when copying crypto info

Nathan Chancellor (2):
      kbuild: Remove alignment on .modinfo section
      serial: 8250_mid: Add missing module namespace import for SERIAL_8250

Naveen Kumar Chaudhary (2):
      kdb: fix memory leak in kdb_setenv() when environment is full
      kdb: unify CMD_BUFLEN definition into kdb_private.h

Nehuen Lian Bova (1):
      HID: magicmouse: fix null pointer dereference in magicmouse_event()

Neil Armstrong (2):
      dt-bindings: vendor-prefixes: add vendor prefix for Nexperia B.V.
      soc: qcom: geni-se: provide PROG_RAM_DEPTH for I2C HUB Serial Engines

Nemesa Garg (1):
      drm/i915/psr: Clear stale sel fetch enable bits on sel fetch disable

Nguyen Ngoc Thang (4):
      md: take reconfig_mutex when enabling PPL on an inactive array
      ocfs2: validate chunk and block counts of the local quota file
      libceph: reject bad connect_seq in msgr1 READY reply
      minix: reject rmdir of a directory with a corrupted link count

Nguyễn Văn Cao Nguyên (1):
      RDMA/irdma: Do not move a fresh RoCE QP to ERROR on RESET

Nia Su (1):
      perf evlist: Don't restrict uncore events to PMU CPUs

Nickolai Zeldovich (7):
      proc/kcore: advance the vmalloc retry by the last copy, not the total
      nsfs: check the trailing bytes of a file handle in bytes, not words
      nsproxy: Fix cred leak in the error path of prepare_nsset()
      pidfs: do not report fields that do not fit into the caller's struct
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

Nicolas Falesy (1):
      exfat: clean stale bdev buffers of newly allocated clusters

Nicolas Frattaroli (3):
      drm/panthor: Add tracepoint for cache flushing
      drm/panthor: Revisit reqs_lock handling in flush/reset paths
      drm/panthor: Take reqs_lock in soft_reset for clearing pending_reqs

Nicolas Morey (1):
      RDMA/rxe: Use validated num_sge in local buffer

Nicolas Schier (3):
      kbuild: Mark usr_gen_init_cpio as no-dot-config-target
      kconfig: tests: Reset all KCONFIG_* env variables by default
      kconfig: tests: Provide defconfig outfile for savedefconfig

Nicolin Chen (1):
      iommu/arm-smmu-v3: Don't rb_erase() a never-inserted stream node

Nicolo Giuliani (1):
      dt-bindings: vendor-prefixes: Add Sophos

Nicolás Antinori (1):
      rust: i2c: remove TryFrom<&Device> implementation for &I2cClient

Nikhil P. Rao (1):
      ionic: fix port_info use-after-free on firmware recovery

Niklas Cassel (10):
      scsi: scsi_debug: Refuse a negative physblk_exp
      scsi: scsi_debug: Take the zone metadata lock before the data lock
      scsi: scsi_debug: Avoid 32-bit overflow in WRITE SCATTERED offsets
      scsi: scsi_debug: Enforce physical block alignment of zoned writes
      scsi: scsi_debug: Advance the write pointer over the data written
      scsi: scsi_debug: Refuse a short WRITE ATOMIC (16) before writing it
      scsi: scsi_debug: Map the region written by WRITE ATOMIC (16)
      scsi: scsi_debug: Validate the access parameters of WRITE ATOMIC (16)
      PCI: Update saved Max Payload Size in pcie_set_mps()
      ata: libata-core: Fix NO_FUA quirks shadowed by earlier quirk entries

Niko Huuskonen (2):
      ALSA: caiaq: Serialize access to the EP1 command buffer
      ALSA: caiaq: Fix the Kore controller key map

Nikolay Borisov (1):
      ata: sata_dwc_460ex: Don't enable interrupt if libATA core registration fails

Nitesh Venkatesh (1):
      crypto: qat - allow KPT disable when service is not asym

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

Ovidiu Panait (6):
      drivers/thermal/renesas/rzg3e: Fix signed integer overflow in temp_to_code()
      thermal/drivers/renesas/rzg3e: Fix runtime PM handling of compare irq
      thermal/drivers/renesas/rzg3e: Fix race between set_trips() and get_temp()
      spi: rspi: Fix DMA mode when the DMA controller is built as a module
      net: stmmac: Track the TX DMA threshold per queue
      PM: suspend: Do not call suspend_ops->begin()/end() for s2idle

Pablo Neira Ayuso (1):
      netfilter: nft_set_rbtree: narrow down range completion to anonymous sets

Palla Raghunath (1):
      nvmet-fc: don't drop the last assoc reference in nvmet_fc_delete_ctrl()

Paolo Abeni (1):
      gtp: hold RCU in gtp_genl_send_echo_req()

Paolo Bertinetti (1):
      ublk: hold RCU read lock in ublk_try_buf_match()

Pardeep Kaur (1):
      wifi: ath12k: fix out-of-bounds access on TX stats arrays

Patryk Pilichowski (1):
      platform/x86: msi-wmi: Fix hotkeys dropped with vendor backlight

Paul Dolan (2):
      selftests/clone3: tighten CLONE_CLEAR_SIGHAND conflict test
      selftests/pidfd: fix PPID values in error message

Paul Moses (2):
      perf mmap: Use the head selected by read_init
      perf mmap: Preserve the consumed cursor in forward mode

Paul Sajna (1):
      arm64: dts: qcom: sdm845-lg: fix sdcard pinctrl nodes

Pauli Virtanen (11):
      Bluetooth: L2CAP: hold l2cap_conn::lock in l2cap_connect_cfm()
      Bluetooth: L2CAP: hold chan in l2cap_ecred_conn_rsp()
      Bluetooth: hci_sync: fix mesh adv timeout units
      Bluetooth: L2CAP: avoid maybe-return-locked in l2cap_get_chan_by_scid/dcid
      Bluetooth: L2CAP: add locking annotations for l2cap_chan_lock/unlock
      Bluetooth: L2CAP: take chan->lock for l2cap_chan_add/ready/del
      Bluetooth: L2CAP: add l2cap_chan_close_unlocked() and locking helpers
      Bluetooth: L2CAP: fix race condition in l2cap_sock_shutdown()
      Bluetooth: 6lowpan: use l2cap_chan_close_unlocked()
      Bluetooth: 6lowpan: avoid concurrent peer_del() in bt_6lowpan_disconnect
      Bluetooth: L2CAP: hold conn->lock for __l2cap_ecred_conn_rsp_defer

Paulo Alcantara (1):
      smb: client: log the selected security type on session setup failure

Pei Xiao (3):
      comedi: dt2811: fix shift-out-of-bounds in IRQ check
      ata: pata_parport: Fix use-after-free in new_device_store
      ata: pata_parport: fix parport attach idr_alloc for

Peng Fan (12):
      arm64: dts: imx8dxl-evk: fix reserved memory node names for remoteproc
      arm64: dts: imx8qm-mek: fix reserved memory node names for remoteproc
      arm64: dts: imx8qm-mek: fix dsp reserved memory node names for remoteproc
      arm64: dts: imx8qxp-mek: fix reserved memory node names for remoteproc
      arm64: dts: imx8qxp-mek: fix dsp reserved memory node names for remoteproc
      arm64: dts: imx8ulp-evk: fix reserved memory node names for remoteproc
      arm64: dts: imx93-11x11-frdm: fix reserved memory node names for remoteproc
      arm64: dts: imx93-14x14-evk: fix reserved memory node names for remoteproc
      arm64: dts: imx93-9x9-qsb: fix reserved memory node names for remoteproc
      arm64: dts: imx8dxl-sr-som: fix reserved memory node names for remoteproc
      arm64: dts: imx93-11x11-evk: fix reserved memory node names for remoteproc
      arm64: dts: imx95-15x15-frdm: fix reserved memory node names for remoteproc

Pengfei Zhang (1):
      net: stmmac: xgmac: do not treat TBU as a TX event

Pengpeng Hou (44):
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
      phy: samsung: usbdrd: propagate GS101 PIPE3 lock failures
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
      PCI: eswin: Publish the platform driver OF alias
      irqchip/mst-intc: Validate the DT interrupt range
      irqchip/sifive-plic: Avoid signed shift in interrupt enable mask
      irqchip/riscv-imsic: Reject overlapping group index fields

Peter Morrow (1):
      net/mlx4: always create the eth and ib auxiliary devices

Peter Robinson (1):
      arm64: dts: broadcom: bcm2712: adjust display status

Peter Wang (2):
      scsi: ufs: core: Always notify POST_CHANGE even on gear switch failure
      scsi: ufs: core: Serialize AHIT register access between sysfs and host driver

Petr Pavlu (1):
      resolve_btfids: Fix the --fatal_warnings exit status

Petr Vorel (1):
      checkpatch: skip CamelCase cache for --no-tree without root

Phil Sutter (1):
      netfilter: nfnetlink: Fix for interrupted hook dumps

Ping-Ke Shih (1):
      wifi: rtw89: correct dependency of the multicolor LED

Piotr Gliźniewicz (1):
      ALSA: 6fire: take stream_mutex in the Digital Thru control

Piotr Kubik (2):
      net: pse-pd: si3474: keep detection enabled on the other PIs
      net: pse-pd: si3474: validate the channels of a PI

Pooyan Azad (1):
      zram: fix short reads from block_state

Prashant Sengar (1):
      net: usb: lan78xx: avoid NULL PHY dereference in WoL setup

Prathamesh Deshpande (2):
      RDMA/mlx5: Cancel deferred page-fault EQ work before teardown
      RDMA/mlx5: Cancel software CQ notifications before teardown

Praveen Kumar Kannoju (1):
      IB/mlx4: Avoid requeueing executing CM timeout work

Primoz Fiser (1):
      arm64: dts: imx8mp-phyboard-pollux-peb-av-10: Fix SAI master assignment

Priyank Rathod (2):
      PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing
      PCI/AER: Fix struct pci_dev reference leak in aer_process_err_devices()

Priyanka Mani (1):
      ASoC: mediatek: mt8365: Fix out-of-bounds read in get_iir_coef()

Przemek Kitszel (6):
      ice: skip stats handling for channel VSIs on rebuild
      ice: extract __ice_vsi_free_stats()
      ice: extract ice_vsi_new_stat_arrays()
      ice: extract ice_vsi_get_num_qs()
      ice: rebuild ring stats arrays instead of reallocating them in place
      ice: size ring stats arrays from the final queue count

Pu Lehui (2):
      bpf: Adjust bpf_func to account for CFI offset in bpf_jit_free on riscv
      riscv, bpf: Remap BPF_REG_0 and RV_REG_TCC

Puranjay Mohan (1):
      bpf: Look at frame 0 when telling async callback entries apart

Qiliang Yuan (16):
      selftests: ublk: don't keep the fault_inject timespec on the stack
      selftests: ublk: make the fault_inject delay a pure timeout
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
      selftests/bpf: Time tc_edt from its first packet with data
      selftests/bpf: Test freeing a struct_ops map under a running prog
      selftests/bpf: Wait for the struct_ops map to be freed in assoc_in_timer

Qing Ming (1):
      dlm: validate node weights before building member array

Qing Zhang (1):
      nvmet: protect nvmet_ports_list with nvmet_config_sem

Qingfang Deng (4):
      mtd: block: prevent reclaim I/O during request processing
      ARM: mvebu: fix Cortex-A9 errata selection for Armada 38x
      pppoe: drop discovery frames with no MAC header
      pppoe: wait for RCU readers before reusing a socket

Qingshuang Fu (1):
      selftests/timers: clocksource-switch: Fix unchecked open()/read()

Qinyun Tan (1):
      iommufd/selftest: Return dmabuf fd from IOMMU_TEST_OP_DMABUF_GET again

Qiuxu Zhuo (1):
      EDAC/i10nm: Fix Granite Rapids ADXL MC mapping

Qu Wenruo (9):
      btrfs: replace btrfs_repair_io_failure() to use bio for page iteration
      btrfs: enhance btrfs_data_csum_ok() to use bio for page iteration
      btrfs: use a shared helper to calculate data checksum for a bio
      btrfs: remove on-stack paddrs[] array usage
      btrfs: raid56: do not verify the content if there is no data checksum
      btrfs: refactor read_key_bytes() to remove the dest_folio parameter
      btrfs: qgroup: do not treat "ret > 0" as error when deleting a qgroup
      iomap: follow the alignment requirement for iomap_dio_hole_iter()
      iomap: only follow dio alignment requirement if specified

Quanye Yang (4):
      RDMA/rtrs-clt: Reject invalid queue_depth from the peer
      RDMA/rtrs-clt: Don't WARN on unexpected info-response opcode
      RDMA/rtrs-clt: Validate peer-supplied IO completion msg_id
      RDMA/rtrs-clt: Fix recv repost to satisfy ib_drain_rq

Raag Jadav (1):
      drm/ras: Cancel and free message on get counter failure

Rafael J. Wysocki (12):
      ACPI: PM: Drop parent state update from acpi_device_get_power()
      ACPI: scan: Stop calling acpi_bus_init_power() early
      ACPI: glue: Reduce debug noise from acpi_device_notify()
      ACPI: glue: Rework the success message in acpi_device_notify()
      ACPI: utils: Adjust message printing macros for ACPI objects
      ACPI: glue: Carry out companion lookup under bus_type_sem
      ACPI: glue: Rearrange acpi_bind_one() to avoid breakage
      ACPI: glue: Fix up and adjust acpi_unbind_one()
      ACPI: fan: Fix memory leak due to leftover devm_kcalloc() argument
      ACPI: video: Fix backlight unregistration ordering
      ASoC: amd: acp-es8336: Switch to use acpi_bus_get_primary_device()
      ASoC: amd: acp3x-es83xx: Switch to use acpi_bus_get_primary_device()

Rahul Pon (1):
      drm/msm/a8xx: report the GMEM size of the active slices

Rameshkumar Sundaram (1):
      wifi: ath12k: fix DMA unwind for ext MSDU descriptor retry

Rand Deeb (1):
      ata: libata-core: Ignore forced transfer modes the host does not support

Raveendra Talabattula (1):
      drm/komeda: Fix bits parsing of GLB_CORE_ID

Ravi Hothi (2):
      ASoC: codecs: wsa884x: Fix VI sense port channel count
      ASoC: codecs: wsa883x: Fix VI sense port channel count

Ravindra (2):
      Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
      Bluetooth: btintel_pcie: clear the GP0 cause with a W1C write

Ren Tamura (1):
      tools/cgroup: sum shrinker object counts across NUMA nodes

Ricardo B. Marlière (SUSE) (1):
      selftests/namespaces: Wait for thread exit via pidfd in active-ref tests

Ricardo Neri (1):
      hwmon: (coretemp) Read TjMax only when refreshing the temperature

Richard Cheng (2):
      cxl/features: Reject feature offset that overflows 16-bit field
      cxl/fwctl: Propagate feature RPC delivery errors

Richard Zhu (3):
      arm64: dts: imx95: Avoid 32-bit PCIe window System RAM overlap
      arm64: dts: imx94: Avoid 32-bit PCIe window System RAM overlap
      arm64: dts: imx943: Avoid 32-bit PCIe window System RAM overlap

Rishikesh Jethwani (2):
      tls: device: protect async RX resync state during device-down
      tls: keep TX and RX hardware offload on the same device

Rob Barnes (1):
      platform/chrome: cros_ec_proto: Fix deferred response

Rob Herring (Arm) (2):
      dt-bindings: arm: mediatek: Fix MT6779 audsys compatible
      dt-bindings: clock: mediatek: Add MT8516 fallbacks

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

Ronald Claveau (2):
      dt-bindings: thermal: amlogic: describe bus clock for t7-thermal
      thermal/drivers/amlogic: Switch to clk_bulk API to support multiple clocks

Rong Zhang (3):
      leds: class: Always protect brightness_show() with led_access
      leds: trigger: Move led_trigger_is_hw_controlled() to the right place
      leds: class: Remove hardware control trigger when writing brightness

Rongzheng Wang (1):
      nvmet: use the enabled transport when disabling a port

Rosen Penev (14):
      ARM: dts: helios4: fix lm75 supply name
      ARM: dts: armada-385-clearfog-gtr: fix vmmc property name
      ARM: dts: armada-395-gp: drop unsupported SDHCI clock-frequency
      ARM: dts: armada-388-helios4: fix vmmc property name
      ARM: dts: helios4: fix vbus-supply for USB2 PHY
      ARM: dts: helios4: fix spi1 location
      dmaengine: fsl_raid: don't invoke client callback under desc_lock
      dmaengine: fsl_raid: avoid free_q underflow in free_chan_resources
      dmaengine: at_hdmac: fix sparse '__iomem' cast warning in memset helpers
      dmaengine: fsl_raid: zero CF descriptor pool allocations
      dmaengine: mv_xor: kill tasklet on channel add error path
      crypto: talitos - init tasklets before requesting IRQs
      net: phy: marvell: keep WOL_EIE across interrupt reconfiguration
      net: bgmac: fix TX DMA unmapping and slot cleanup

Roshan Kumar (1):
      drm/pl111: drop alpha formats the hardware cannot scan out

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

Ryan Leung (5):
      wifi: mt76: mt7915: publish wcid before MCU add commands
      wifi: mt76: fix unlocked wcid check in mt76_tx_status_skb_add()
      wifi: mt76: fix wcid teardown ordering in mt76_reset_device()
      wifi: mt76: mt7915: fix thermal zone use-after-free
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

Sahil Chandna (1):
      net: mana: Add support to process throttled EQEs

Salah Triki (2):
      iio: temperature: tmp117: fix calibbias cache update on I2C write failure
      iio: imu: adis16400: Check return value of spi_setup()

Sally Marcher (1):
      ALSA: usb-audio: Add correct datainterval in the quirks-table for Microbook II

Sam Day (1):
      drm/msm/a3xx: fix VBIF halt mask for A306/A306A

Samuele Yang (1):
      wifi: mm81x: start beaconing on beacon enable not interface add

Sandipan Das (1):
      perf jevents: Limit the number of JSON reading workers

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

Sasha Levin (14):
      kbuild: keep .modinfo when vmlinux is linked with --gc-sections
      RDMA/selftests: Fix the kernel config fragment
      tools: hv: remove unused rte_smp_mb()
      selftests/nolibc: use the configured kernel header directory
      selftests/exec: report the skipped binfmt_misc_bpf test on stderr
      kselftest/arm64: signal: copy each test binary only once
      selftests: keep the build status from wrapping to success
      ARC: Strip libgcc debug information when generating BTF
      locking/atomic: arc, hexagon, openrisc: Define arch_cmpxchg_local()
      bpf: Fix ksock build with BPF_LSM=y and SECURITY_NETWORK=n
      selftests/proc: proc-pid-vm: fix unused variable warning on non-x86
      selftests/thermal: allow cross builds of the Intel tests
      ASoC: SOF: Intel: hda: Stop the controller before freeing its DMA buffers
      rust: bindings: derive Zeroable for bindgen's opaque array wrappers

Scott Gauche (1):
      ALSA: hda/realtek: Fix audio after Windows reboot on ASUS Q423SA

Sean Chang (1):
      drm: bridge: dw_hdmi: Fix constant truncation warning on phy_mask

Sean Christopherson (1):
      KVM: nSVM: Check validity of vmcs01 save area copied from SMRAM on RSM

Sebastian Andrzej Siewior (1):
      srcu: Use IRQ_WORK_INIT_HARD for srcu's irq_work

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

Selvin Xavier (8):
      RDMA/bnxt_re: Fix integer overflow in send payload size computation
      RDMA/bnxt_re: Detect wrong sge_len passed for inline
      RDMA/bnxt_re: Validate SRQ max_sge at create time
      RDMA/bnxt_re: Initialize wqe.flags in bnxt_re_post_srq_recv()
      RDMA/bnxt_re: Serialize dcb_wq access against async notifier
      RDMA/bnxt_re: Fix the PD and DPI table size
      RDMA/bnxt_re: Use bnxt_ext_stats_supported for counter count selection
      RDMA/bnxt_re: Unpublish QP table before freeing it

Semih Baskan (1):
      PCI: iproc: Use the EROM outbound window on BCMA

Seongjae Jeong (1):
      f2fs: reject device aliasing without a multi-device configuration

Sergey Lebedev (1):
      Bluetooth: btintel_pcie: verify and serialize D-state transitions

Serhat Kumral (6):
      RDMA/irdma: Free IRQ when CEQ vector mapping fails
      RDMA/siw: Fix length of first chunk in siw_try_1seg()
      IB/rdmavt: Fix error unwind path for qp_priv_init() in rvt_create_qp()
      RDMA/srp: Avoid reading uninitialized has_port on srp_parse_in() failure
      RDMA/usnic: Bound buffer size to sizeof(buf) in flowinfo_read()
      RDMA/mlx5: Validate priority in STEERING_ANCHOR_CREATE handler

Shaikh Kamaluddin (1):
      cxl/mce: Avoid alias page retirement for corrected errors

Shakeel Butt (5):
      kernfs: fix up the unlocked attribute reads on the creation paths
      kernfs: don't hold kernfs_rwsem across notification delivery
      kernfs: don't repeat or skip an entry when readdir resumes
      kernfs: don't hold kernfs_rwsem across dir_emit()
      kernfs: avoid READ_ONCE() on a kgid_t in kernfs_new_node()

Shang En Sim (1):
      platform/x86: hp-wmi: Fix hwmon keep-alive teardown

Shashank Mohan Jain (3):
      bitmap: bitmap_parse(): reject non-hex character before 8 digits
      bitmap: bitmap_parselist(): reject trailing characters after group size
      bitmap: bitmap_parselist(): don't wrap around on a huge group size

Shawn Lin (1):
      phy: rockchip: naneng-combphy: Fix TX detect RX termination errata

Shenghao Ding (1):
      ASoC: tas2781: Fix TAS2781/TAS5825 PPC version logic conflict

Shengjiu Wang (1):
      ASoC: fsl_asrc: use regmap_write_bits to update clock source registers

Shivansh Dhiman (1):
      KVM: SVM: Add a vCPU-aware helper to get supported DEBUGCTL bits

Shradha Gupta (2):
      kexec: Add helper to report an active kexec reboot
      Drivers: hv: Run VMBus kexec cleanup from syscore shutdown

Shrikanth Hegde (1):
      powerpc/ftrace: Don't restore r13 during ftrace_regs_caller

Shuangfeng He (1):
      netfilter: flowtable: use the vlan id, not the full tci, in the tuple key

Shubhang Kaushik (Ampere) (1):
      sched: Restart fair hrtick after same-task repicks

Shujath Mohd (1):
      arm64: dts: qcom: sdm845-sony-xperia-tama: Fix Bluetooth UART pinctrl

Shuming Fan (2):
      ASoC: rt1320: avoid re-initialize in advanced mode
      ASoC: rt712: avoid duplicate reset in io_init

Shuvam Pandey (1):
      accel/qaic: Protect perf stats BO state with bo->lock

Shyam Sundar S K (1):
      platform/x86/amd/pmc: clear devm-managed pointers on remove to prevent stale reuse

Sicong Huang (1):
      nfp: flower: fix use-after-free in neighbour update work

Sidong Yang (1):
      accel/rocket: Don't tear down the scheduler when drm_sched_init() fails

Simon Song (1):
      vfio/pci: Remove the core dependency on driver data

Sivansh Gupta (2):
      clk: qcom: Fix CLK_GLYMUR_GPUCC default and CLK_GLYMUR_EVACC duplicate
      mailbox: qcom-cpucp: read mbox hardware register using readq()

Slavin Liu (7):
      ACPI: tables: handle failed initrd override mappings
      crypto: atmel-sha - reject initialization without a device
      clk: starfive: jh7110: reject oscillator lookup errors
      RDMA/irdma: check vport device allocation
      ASoC: fsl_asrc: check the second front-end DMA channel
      clocksource/drivers/dbx500-prcmu: Check timer register mapping
      wifi: mt76: mt7996: guard station-only MLO TX handling

Slawomir Stepien (1):
      fs/ntfs3: handle partial allocation in attr_data_get_block_locked()

Sonny Jiang (3):
      drm/amdgpu: Config VCN instance for soc_v1_0"
      drm/amdgpu: Correct VCN V5_0_2 doorbell index setting
      drm/amdgpu: VCN 5_0_2 disable VCN_RRMT

Srinivas Kandagatla (5):
      ASoC: SDCA: export PM helpers keyed on sdca_class_drv
      ASoC: SDCA: re-enable IRQ on pm_runtime_force_suspend failure
      clk: qcom: fix SM6115 lpasscc register offset
      ASoC: codecs: wsa884x: disable runtime PM on unbind
      ASoC: codecs: wsa883x: disable runtime PM on unbind

Srinivas Neeli (2):
      dmaengine: xilinx_dma: Fix MCDMA descriptor fields based on DMA direction
      dmaengine: xilinx_dma: Move descriptors to done list based on completion bit

Srinivasan Shanmugam (3):
      drm/amd/pm: Remove unused functions in smu_v15_0
      drm/amd/display: Fix redundant NULL check on dc->clk_mgr in dcn42_prepare_bandwidth
      drm/amd/display: Fix null deref of link_enc in dce110_enable_tmds_link_output

Stanislav Fomichev (2):
      net: devmem: replace gen_pool with freelist
      net: devmem: embed net_iov_area in binding

Stefan Metzmacher (1):
      smb: smbdirect: don't WARN on an unexpected receive opcode

Stefan Wahren (1):
      dt-bindings: phy: ti,tcan104x-can: Fix property constrains

Stefano Munari (1):
      net: usb: lan78xx: reject invalid EEPROM write requests

Stella Liu (13):
      wifi: mt76: mt7925: fix NAN NDP STA record role index
      wifi: mt76: mt7925: fix NAN start failure
      wifi: mt76: mt7925: fix NAN committed CRB timeline layout
      wifi: mt76: mt7925: report only 2.4 GHz NAN supported band
      wifi: mt76: mt7925: drop unused NAN 2.4/5 GHz support config
      wifi: mt76: mt7925: drop deferred NAN local schedule update handling
      wifi: mt76: mt7925: use OFDM-only PHY mode for NAN STA records
      wifi: mt76: mt7925: share TLV setup for NAN enable command
      wifi: mt76: mt7925: replace NAN DW end event with DW start
      wifi: mt76: mt7925: fill all DW intervals in NAN avail_map
      wifi: mt76: mt7925: clear CRB before deactivating NAN peer record
      wifi: mt76: mt7925: add ULW event handling and peer ULW update
      wifi: mt76: mt7925: configure NAN PHY setting on enable

Steven Rostedt (1):
      cpuidle: haltpoll: Only define guest_halt_poll_ns tracepoint when used

Stian Halseth (2):
      sched/cputime: Don't account idle time twice after dyntick-idle
      sched/cputime: Don't warn when the tick period starts after idle exit

Sudeep Holla (3):
      ACPICA: Fix PCC OperationRegion command offsets
      ACPI: PCC: Preserve shared memory signature in OpRegion handler
      ACPI: PCC: Free channel on OpRegion deactivation

Sumeet Pawnikar (1):
      thermal: gov_power_allocator: Fix NULL pointer dereference in update_tz()

Sung Byeongchan (2):
      nvmet-auth: reject undersized AUTH_SEND payloads
      netfilter: xt_dccp: handle reserved options as single-byte

Sunny Luo (1):
      spi: amlogic: spisg: Fix the incorrect keep_ss of the last descriptor

Sunny Tiwari (1):
      RDMA/irdma: Bound in-flight CQP ops across deferred completions

Surabhi Gogte (1):
      nvme-tcp: refactor I/O queue setup path

Surendra Singh Chouhan (1):
      pwm: ipq: Prevent potential 32-bit integer overflow in hi_div calculation

Sven Peter (2):
      arm64: dts: apple: t6030: Fix cpus node indentation
      arm64: dts: apple: t6032: Fix cpus node indentation

Swark Yang (2):
      mailbox: axiado: fix RX frame draining and error handling
      mailbox: axiado: fix debugfs name truncation warning

Syed Saba Kareem (1):
      ASoC: amd: acp: fix TAS2783 SoundWire codec unmet dependencies

TJ Adams (1):
      block: advance iterator after copy-in for SG_DXFER_TO_FROM_DEV

Taimuraz Kaitmazov (2):
      accel/amdxdna: do not warn when a sync request is rejected
      accel/amdxdna: do not fail a sync for a BO with no debug context

Takahiro Kuwano (1):
      mtd: spi-nor: spansion: Remove s25fs256s0

Takashi Iwai (40):
      ALSA: pcm: Optimize cpu_latency_qos_*() calls
      ALSA: pcm: Prevent O_APPEND open on OSS streams
      ALSA: usb-audio: Fix UAC2 mixer unit request handling
      ALSA: ump: Avoid dereference with max_src_size=0
      ALSA: caiaq: Allow zero-length packet handling for EP1
      ALSA: seq: Drop the bogus RCU guard from clientptr()
      ALSA: hda: Fix potential UAF for gating jack
      ALSA: usb-audio: Check mixer matrix size for UAC2/3 at parsing
      ALSA: usb-audio: Fix invalid UAC2/3 mixer unit matrix evaluation
      ALSA: pcmtest: Fix a bogus pointer read in snd_pcmtst_pcm_pointer()
      ALSA: usb-audio: Fix mixer bitmap cache over 32 channels
      ALSA: core: Add missing barriers for power_ref vs card->shutdown
      ALSA: seq: Fix missing direction and ump_group handling in 32bit compat ioctl
      ALSA: pcmtest: Fix leak at probe error
      ALSA: info: Fix memory leak at card removal
      ALSA: aloop: Avoid a bad mixure of guard() and goto
      ALSA: core: Fix leaks at snd_card_init() error paths
      ALSA: hda: Use linked list for jack table
      ALSA: hda: Avoid non-operational GPU warning at regular device removal
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
      ALSA: jack: Fix kctl free at error in snd_jack_kctl_new()
      ALSA: pcm: Protect delay DMA sync in forward and rewind, too
      ALSA: line6: Use kzalloc() for PCM buffer allocation
      ALSA: usb-audio: Use fixed control index for us16x08 mixer elements
      ALSA: pcm: Add refcount for races between drain and unlink
      ALSA: core: Serialize snd_refcount put and sync
      ALSA: usb-audio: Avoid applying boot quirk for Behringer UMC204HD
      platform/x86: ibm_rtl: Fix potential OOB read at signature search
      ALSA: usb-audio: Correct a typo in UMC404HD model comment

Takashi Sakamoto (1):
      firewire: core: remove unused link field in fw_packet structure

Tal Zussman (12):
      block: use iomap_dirty_folio for block devices
      block: take i_rwsem for the direct I/O write fallback
      block: take i_rwsem for the splice read path
      block: honor IOCB_NOWAIT in the block device buffered read path
      block: don't fall back to buffered I/O for atomic writes
      block: unpin all pages of a bvec in bio_iov_iter_align_down()
      btrfs: drop the extent maps of the written part of a failed ordered extent
      btrfs: update the inode item when removing a free space inode
      ceph: fix error handling when the OSD client is stopping in ceph_submit_write()
      ceph: wait for pending fscache write in write_folio_nounlock()
      ceph: fix writeback_count leak when a bounce page allocation fails
      ceph: don't clear write_congested when collecting folios

Taniya Das (6):
      dt-bindings: clock: qcom,milos-camcc: Add missing power-domains support
      dt-bindings: clock: qcom,milos-videocc: Add missing power-domains support
      arm64: dts: qcom: milos: Add power-domains for camcc and videocc
      dt-bindings: clock: qcom: Add GCC video axi reset clocks for Nord
      clk: qcom: nwgcc-nord: Add video axi clock resets for Nord
      clk: qcom: gcc: Fix GPLL enable register offset for Nord SoC

Tao Cui (3):
      sched_ext/scx_flatcg: Make cgv_node_less() wraparound-safe
      blk-iocost: charge zone appends as writes
      blk-iocost: account zone append completions in latency stats

Tao Gong (1):
      net: dsa: mt7530: trap frames to conduit in MFC on EN7581 and AN7583

Tapio Reijonen (10):
      serial: max310x: schedule tx_work directly from the IRQ handler
      gpio: pcf857x: implement get_direction()
      serial: max310x: don't clobber the TX break bit in set_termios
      serial: max310x: fix breaks not reaching the wire in RS485 mode
      serial: max310x: centralize the RS485 transceiver programming
      serial: max310x: fix RS485 delays being programmed as bit-times
      serial: max310x: don't power down the port mid-transmission on close
      serial: max310x: support active-low RTS on the hardware path
      serial: max310x: drive RTS in software when hardware delays are too short
      serial: max310x: don't transmit while an RS485 reconfigure is pending

Tate Whiteberg (2):
      serial: 8250: export and rename wait_for_xmitr()
      serial: 8250_mid: wait for LSR tx empty before setting termios

Tejun Heo (17):
      bpf: sched_ext: Mark ops argument container pointer fields as trusted
      cgroup: Return -ENODEV consistently for a dead cgroup
      cgroup: Return ERR_PTR from cgroup_kn_lock_live()
      cgroup: Make the offline drain interruptible
      sched_ext: Clear a sub-scheduler's caps before ops.sub_detach()
      sched_ext: Fix the running task keeping its protection into bypass
      sched_ext: Fix a bypassed task stalling on a cpu its scheduler has no caps on
      sched_ext: Fix bypassed tasks looping on a host without SCX_CAP_ENQ
      sched_ext: Fix rescue served time disagreeing with the slice under proxy execution
      sched_ext: Fix the bypass load balancer stranding tasks on cpus where the host lacks SCX_CAP_BASE
      sched_ext: Add ops.sub_cid_sched_updated() to report the sched running on a cid
      sched_ext: Add ops.sub_child_ecaps_updated() to report a child's effective cap changes
      sched_ext: Factor out bypass_lb_move() and insert with the donor DSQ unlocked
      sched_ext: Let the bypass load balancer move tasks homed on other cpus
      sched_ext: Fix queued bypassed tasks stalling when the host loses SCX_CAP_BASE
      sched_ext: Fix a lone IMMED task waiting behind a kept prev
      sched_ext: Reject scx_bpf_sub_grant/revoke() in tracing programs

Tengda Wu (1):
      perf llvm: Fix memory leak of args->fileloc in symbol__disassemble_llvm()

Theodor Arsenij Larionov Trichkine (1):
      net: use the full socket in sk_mc_loop()

Thiébaud Weksteen (1):
      rust: macros: allow non-ASCII characters in `authors`

Thomas Falcon (1):
      perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()

Thomas Fourier (1):
      net: alacritech: fix dma_free_coherent() in error path

Thomas Huth (1):
      crypto: inside-secure - Zeroize temporary arrays on stack with sensitive data

Thomas Richter (1):
      perf test: perf stat tests fails on s390

Thomas Weißschuh (4):
      microblaze: uaccess: Zero out destination on failed get_user()
      microblaze: Pass -m{big,little}-endian through KBUILD_CPPFLAGS
      nios2: ksyms: Declare __mulsi3 export
      vdso/gettimeofday: Correct the read of tz_minuteswest and tz_dsttime

Thorsten Blum (2):
      hwrng: intel - return -ENOMEM when kmalloc_obj() fails
      hwrng: intel - return -ENOMEM when ioremap() fails

Tianyi Chen (4):
      selftests/sched_ext: Fail interrupted test runs
      selftests/sched_ext: Handle CPU hotplug write failures
      perf sched stats: Reject mismatched or incomplete snapshots
      eventpoll: propagate wakeup source creation failure in ep_modify()

Tianyi Gao (1):
      veth: schedule the peer's NAPI after XDP_TX when only GRO is enabled

Tigran Mkrtchyan (2):
      nfsv4/pnfs: use the MDS authflavor for data server connections
      pNFS/flexfiles: make pg_init retry loops killable

Tim Douglas (1):
      serial: pmac_zilog: report received breaks

Timur Tabi (1):
      gpu: nova-core: write initial RPCs before booting GSP-RM

Ting-Han Hou (6):
      checkkconfigsymbols.py: Parse Git status output line by line
      clang-tools: Import os for broken pipe handling
      scripts/make_fit: Ignore schema checks when decomposing DTBs
      ALSA: virtio: reset I/O message fill level on prepare
      scripts/gdb: fix radix tree lookup pointer handling
      scripts/gdb: fix stack depot out-of-bounds diagnostic

Toke Høiland-Jørgensen (2):
      bpftool: Set BPF_F_XDP_DEV_BOUND_ONLY flag non-destructively
      libbpf: Move section-defined program flags to prog_flags

Tomasz Siemek (2):
      drm/amd/display: Refactor HUBP_WAIT_FOR_DCC_META_PROP to drop pipe_ctx
      drm/amd/display: Refactor DPP_SET_INPUT_TRANSFER_FUNC to drop pipe_ctx

Tony Luck (2):
      x86/resctrl: Update documented unit for the "activity" event
      fs/resctrl: Ensure default group reports tasks on monitor-only systems

Triet Hoang (1):
      clk: raspberrypi: Handle cpufreq device registration failure

Troy Mitchell (1):
      dt-bindings: vendor-prefixes: Add Sensylink

Tung Nguyen (1):
      tipc: fix refcount panic in tipc_rcv() when receiving shared skb

Uwe Kleine-König (The Capable Hub) (3):
      serial: txx9: Drop noop probe function and dangerous remove callback
      serial: 8250: Fix corner case for port matching
      serial: 8250: hub6: Add cleanup code

Val Packett (1):
      power: sequencing: pcie-m2: Add Foxconn WCN7850 subsystem PCI ID

Varun Gupta (3):
      drm/xe: Guard page-fault worker with runtime PM check
      drm/pagemap: Prevent CPU stalls during unbounded pagemap teardown
      drm/pagemap: Drop ratelimiting from dev_unhold_work debug trace

Vasilij Markin (1):
      drm/appletbdrm: Add suspend and resume support

Vasily Gorbik (2):
      sched/core: Don't steal a proxy-exec donor
      sched/core: Don't proxy-exec unmatched cookie lock owners

Venkat Rao Bagalkote (1):
      powerpc/interrupt: Use early_radix_enabled() in NMI real-mode guard

Vijendar Mukunda (3):
      ASoC: SOF: amd: return -EINVAL for unknown PCI revision in acp7x suspend
      ASoC: SOF: amd: fix amd_sof_acp_remove() teardown ordering
      ASoC: SOF: amd: fix amd_sof_acp_probe() error unwind ordering

Vikas Gupta (1):
      bnge: skip dev_addr when building the VNIC unicast list

Viktor Menshin (1):
      ALSA: hda/realtek: Fix hiss/crackle on Lenovo Xiaoxin 14 GT (17aa:3912)

Vinayak Katoch (1):
      arm64: dts: qcom: agatti: Add memory-region for audio PD

Vincent Jardin (5):
      dt-bindings: vendor-prefixes: add Free Mobile
      crypto: caam/qi,qi2 - set plain_keylen for skcipher descriptors
      dpaa2-ptp: fix support for PTP_EXTTS_REQUEST2 ioctl
      net: enetc: fix support for PTP_EXTTS_REQUEST2 ioctl
      ptp: qoriq: fix support for PTP_EXTTS_REQUEST2 ioctl

Vincent Mailhol (1):
      efi/libstub: make local GUID variables static

Vineeth Karumanchi (1):
      net: macb: configure ENST registers for all queues

Vinod Koul (1):
      dmaengine: zynqmp_dma: drop redundant label

Vitaliy Sochnev (2):
      thermal/drivers/airoha: Request the EN7581 IRQ after zone registration
      thermal/drivers/airoha: Fix AN7583 ADC mux field mapping

Vitaly Prosyak (1):
      drm/amdgpu: reserve eviction-fence slot at WPTR caller

Vladimir V. Kondratyev (1):
      Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check

Waiman Long (16):
      cgroup/cpuset: Run SCHED_DEADLINE shrink test on valid partition root only
      cgroup/cpuset: Use cpuset_v2() in cpuset_num_cpus()
      cgroup/cpuset: Fix a missing isolated_cpus update in update_cpumasks_hier()
      cgroup/cpuset: Consolidate isolated_cpus_can_update() into prstate_housekeeping_conflict()
      cgroup/cpuset: Consider all the exclusive CPUs when doing housekeeping check
      cgroup/cpuset: Do housekeeping check before converting invalid partition to valid
      cgroup/cpuset: Properly disabling partition when partition state switching fails
      cgroup/cpuset: Find furthest isolated ancestor for invalidated isolated partition
      cgroup/cpuset: Don't allow a child root partition under an isolated parent
      cgroup/cpuset: Properly compute effective xcpus in update_parent_effective_cpumask()
      cgroup/cpuset: Fix incorrect effective_cpus bug in update_cpumasks_hier()
      cgroup/cpuset: Minor fixes to prstate_housekeeping_conflict()
      cgroup/cpuset: Prevent recursive call of remote_cpus_update() via update_cpumasks_hier()
      cgroup/cpuset: Make sure compute_partition_effective_cpumask() is only called for valid partition
      cgroup/cpuset: Release invalid isolated CPUs in compute_partition_effective_cpumask()
      cgroup/cpuset: Release invalid isolated CPUs with a shrunk root partition parent

Waldemar Brodkorb (1):
      sh: Select BINFMT_FLAT_NO_DATA_START_OFFSET for !MMU

Wang Zhaolong (2):
      ksmbd: avoid races between named-pipe operations
      ksmbd: fix named-pipe reply loss with small output buffers

WangYuli (2):
      MIPS: Only check -msym32 when need-compiler
      MIPS: dec: Add missing <linux/interrupt.h> inclusion to reset.h

Wei Huang (1):
      PCI/TPH: Validate the firmware Steering Tag response

Weigang He (4):
      ARM: vexpress: fix device_node refcount leak in vexpress_flags_set()
      ARM: vexpress: fix device_node refcount leak in vexpress_smp_dt_prepare_cpus()
      thermal/drivers/ti-soc-thermal: Cancel pending alert work on remove
      thermal/drivers/sprd: validate the sensor id from the device tree

Weili Qian (1):
      crypto: hisilicon/hpre - remove dma_free_coherent on NULL req->dst in ECDH

Weiming Shi (5):
      fs/ntfs3: take run_lock when freeing offs_folio in ni_decompress_file
      fs/ntfs3: zero frame pages on read error
      ntfs3: fix out-of-bounds read in ntfs_read_mft()
      fs/ntfs3: do not mark frame pages uptodate on read error
      bpf: Validate stack arg reads against caller state

Wen Yang (1):
      rv: Use LD_WAIT_SPIN as the reactor lockdep wait type

Wenjie Qi (2):
      f2fs: wait for inode record work before clearing ino bitmaps
      f2fs: refresh pinned allocation boundary after resize

Wentao Liang (11):
      media: ivsc: Fix csi_dev use-after-free in mei_ace_setup_dev_link()
      clk: versatile: clk-icst: Fix node reference leak in of_syscon_icst_setup()
      RDMA/cxgb4: Fix neigh reference leak in rx_pkt()
      RDMA/cxgb4: Fix skb reference leak in rx_pkt()
      RDMA/mlx5: Fix RQ resource reference leak in mlx5_ib_wq_event()
      RDMA/siw: Fix qp use-after-free in siw_get_base_qp()
      pinctrl: nuvoton: Fix clock reference leak in ma35_get_bank_data()
      pinctrl: stm32: Fix clock reference leak in stm32_pctl_probe()
      clocksource/drivers/timer-econet-en751221: Fix clock reference leak
      spmi: mtk-pmif: Fix clock reference leak in mtk_spmi_bus_probe()
      apparmor: Fix namespace reference leak in __aa_find_or_create_ns()

Willem de Bruijn (2):
      selftests: net: csum: filter packets by source address and port
      virtio-net: fix frag overflow in big packets receive

Wilson Felipe Pereira (3):
      selftests/cgroup: test_zswap: fix implicit unsigned promotion bug in test_no_kmem_bypass
      init/main: fix off-by-one in argv_init cleanup
      init/main: fix false-positive kernel panic on environment variable overwrite

Woojin Ji (1):
      bpf: Zero-extend the index in inlined bpf_get_func_arg()

Xi Pardee (1):
      platform/x86/intel/pmc: Fix stale NVL PCD-S S0ix_LPM telemetry constants

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

Xin Liu (2):
      arm64: dts: qcom: purwa-iot-evk: use on-board crystal for PS8830 retimers
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

Xu Yunxiang (2):
      bpf: Destroy callee-local dynptrs on subprog return
      bpf: Track borrowed iterator results by default

Xueqin Luo (7):
      cpuidle: menu: Do not return a disabled idle state
      cpuidle: teo: Do not return a disabled idle state
      platform/x86: Add ACPI_COMPANION() NULL check in topstar_acpi_probe
      cpufreq/amd-pstate: Restore previous EPP if profile_name allocation fails
      cpufreq: sparc-us2e: fix frequency table index copy-paste error
      cpufreq: tegra194: fix double-pointer error in get_cpu_ndiv
      cpufreq: sti: avoid NULL dereference in dev_err()

Xuewen Wang (3):
      ntfs: preserve the 64-bit FITRIM minimum length
      ntfs: wait for the bitmap scan before MFT bitmap extension
      ntfs: account for direct MFT bitmap cluster allocation

Yang Xiuwei (1):
      floppy: avoid NULL deref in reset_interrupt when cont is cleared

Yang Zi (1):
      comedi: addi_apci_3xxx: fix subdevice count underallocation

Yao Sang (1):
      nvme: pass partition flags to passthrough checks

Yaozhong Li (2):
      arm64: dts: rockchip: fix analog headphone output on rk3399-firefly
      arm64: dts: rockchip: disable unused i2s0 on rk3399-firefly

Yeoreum Yun (5):
      coresight: etm4x: Prohibit TRCSEQSTR modifications while tracing enabled
      coresight: etm4x: prohibit modifying cntr_val while session is enabled
      coresight: etm4x: fix inconsistencies with sysfs configuration
      coresight: etm3x: Prohibit modifying cntr_val while session is enabled
      coresight: etm3x: fix inconsistencies with sysfs configuration

YiPeng Chai (1):
      drm/amd/ras: use __le32 pointer type to resolve the sparse warnings

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

Yishai Hadas (8):
      RDMA/hns: Pin CQ buffer writable to match device DMA write access
      RDMA/vmw_pvrdma: Pin QP and SRQ rings writable to match device DMA write access
      RDMA/mlx5: Fix mlx5_ib_dev_res_init() failure when XRC cap is absent
      RDMA/mlx5: Set WQ event handler before firmware RQ insertion
      RDMA/mlx5: Set SRQ event handler before xarray insertion
      RDMA/mlx5: Set RQ event handler for raw-packet QP
      RDMA/mlx5: Set QP event handler before firmware QPC insertion
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

Yonghong Song (2):
      bpf: Read a kfunc's __sz argument only when it is in a register
      bpf, x86: Pass a trampoline's stack arguments by the calling convention

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

Youssef Samir (5):
      accel/qaic: Add missing <linux/device-id/mhi.h> to sahara and timesync
      accel/qaic: Add <linux/device-id/mhi.h> to qaic_drv.c
      accel/qaic: Add <linux/device-id/mhi.h> to qaic_debugfs.c
      accel/qaic: Add <linux/device-id/mhi.h> to qaic_ras.c
      accel/qaic: Add <linux/device-id/mhi.h> to qaic_ssr.c

Yuan Chen (6):
      bpftool: Fix spurious batch file read error
      bpf: Keep target extended until its last freplace link detaches
      bpf: Roll back freplace link state when bpf_arch_text_poke() fails
      bpftool: Fix out-of-bounds read in kprobe_multi link info dump
      bpftool: Fix inverted tracefs validation when scanning /proc/mounts
      bpf: Claim the per-CPU send_signal irq_work before filling it

Yuho Choi (5):
      PCI: xgene: Use managed clock for PCIe controller
      USB: pci-quirks: Release EHCI device reference
      soc/tegra: flowctrl: Release OF node reference on error
      bus: arm-cci: Drop CPU node reference in cci_ace_init_ports()
      bus: arm-cci: Drop cci-control-port node reference in __cci_ace_get_port()

Yun Lu (4):
      selftests/bpf: Clean up child when task_work__open() fails
      selftests/bpf: Fix map fd leak in no-BTF wq test
      bpf: Fix NULL task dereference in task work cancellation
      bpf: Prevent task work context reuse while irq_work is busy

Yun Zhou (1):
      ntfs3: release ni_lock before dir_emit in ntfs_readdir to fix deadlocks

Yuri Zaporozhets (1):
      ASoC: dwc: Use OF match data again for StarFive JH7110

Yury Norov (1):
      lib: fix lock initialization in region allocation benchmark

Yuya Kusakabe (1):
      seg6: fix HMAC validation when an extension header precedes the SRH

Ze Huang (1):
      drm/imx/lcdc: avoid duplicate clk_per enable

Zenghui Yu (Huawei) (1):
      selftests/damon: stop kdamond on error exits of no-op commit test

Zhan Xusheng (8):
      fs/ntfs3: fix valid_size not being updated in attr_allocate_frame()
      vdso/math64: Add and use __iter_div64_u64_rem()
      vdso/vsyscall: Keep the CLOCK_AUX base scaled
      ntfs: do not read ahead encrypted files
      ntfs: reject direct I/O reads of encrypted files
      ntfs: widen the sub-block offsets in ntfs_decompress()
      ntfs: fix u16 truncation of the update sequence array count check
      erofs: fix disallowing superblock_share if device= is set

Zhang Yi (3):
      ext4: fix orig_mlen initialization in ext4_map_blocks()
      ASoC: codecs: es*: Modify the registers related to ALC RECOVERY
      ASoC: codecs: es*: Modify the maximum value of DMIC_GAIN

Zhang Yubing (1):
      phy: rockchip: usbdp: Support single-lane DP

ZhengYuan Huang (1):
      ocfs2: reject inconsistent local xattr entries

Zhenxian Ma (3):
      block: skip redundant flush for O_DSYNC direct writes
      block: only use REQ_FUA for direct writes if the device supports it
      block: fix recursive i_rwsem locking in blkdev_write_iter()

Zhenzhong Duan (1):
      iommu/vt-d: Fix page table level calculation in compute_vasz_lg2_ss()

Zhewei Yuan (1):
      tcp: Fix fastreuse cache initialization on first bind

Zhiguo Niu (1):
      f2fs: fix to record both APPEND and UPDATE ino entries

Zhihao Cheng (2):
      md/raid5: setup_conf: Fix null-ptr-def in error handling path
      md: Fix the null-ptr-deref of 'mddev->private' while submitting IO

Zhijian Han (1):
      PCI: imx6: Fix resource leaks in probe error paths

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
      Bluetooth: btusb: Build the driver from multiple source files

Zizhi Wo (2):
      md/raid10: fix missing wakeup in wait_barrier_nolock
      md/raid5: reject a per-device size smaller than one chunk

Zongmin Zhou (2):
      power: supply: s2mu005-battery: return errors from dev_err_probe() in probe
      serial: sifive: fix off-by-one in console port bounds check

alex todadze (1):
      net: stmmac: fix rx checksum offload with extended descriptors

bui duc phuc (83):
      ASoC: mediatek: mt8186: Fix APLL mux setting error handling
      ASoC: mediatek: mt8186: Fix clock handling in mux disable path
      ASoC: mediatek: mt8186: Fix AFE clock error handling
      ASoC: mediatek: mt8186: Fix APLL enable error handling
      ASoC: mediatek: mt8186: Fix MCK error handling
      ASoC: mediatek: mt6797: fix wrong unwind order and error code in enable_clock
      ASoC: mediatek: mt8189: Propagate APLL enable errors
      ASoC: mediatek: mt8189: Propagate MCK enable errors
      ASoC: mediatek: mt8189: Validate MCK ID
      ASoC: mediatek: mt8189: Propagate reg_rw clock errors
      ASoC: mediatek: mt8189: Propagate runtime resume errors
      ASoC: mediatek: mt8189: Propagate APLL errors
      ASoC: mediatek: mt8189: Propagate MCLK errors
      ASoC: mediatek: mt8189: Validate sysclk frequency
      ASoC: mediatek: mt8189: Propagate TDM clock errors
      ASoC: mediatek: mt8189: Validate TDM MCLK frequency
      ASoC: mediatek: mt8188: mt8188-afe-clk: Handle tuner clock enable errors
      ASoC: mediatek: mt8188: mt8188-afe-clk: Propagate regmap update errors
      ASoC: mediatek: mt8188: mt8188-afe-clk: Handle clock enable errors
      ASoC: mediatek: mt8188: mt8188-afe-pcm: Handle runtime resume errors
      ASoC: mediatek: mt8188: fix clk leak on error in audsys_clk_register
      ASoC: fsl_asrc_m2m: fix pm_runtime usage counter leak on error
      ASoC: mediatek: mt8183: Fix wrong clock cleanup on clk_set_parent() failure
      ASoC: mediatek: mt8183: Fix clock handling in mux disable path
      ASoC: mediatek: mt8183: Fix APLL enable error handling
      ASoC: mediatek: mt8192: fix APLL mux error handling
      ASoC: mediatek: mt8192: fix AFE clock error handling
      ASoC: mediatek: mt8192: fix error handling in APLL enable functions
      ASoC: mediatek: mt8192: fix MCK clock error handling
      ASoC: mediatek: mt8192: switch to devm_clk_get_optional()
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
      ASoC: mediatek: mt8189: Handle constraint return value in FE startup
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
      ASoC: intel: atom: Fix .shutdown() being skipped on rollback
      ASoC: renesas: msiof: Fix msiof_close() being skipped on rollback
      ASoC: atmel-i2s: fix MCK generator error handling
      ASoC: atmel-i2s: use optional API for muxclk
      ASoC: atmel-i2s: use optional API for gclk
      ASoC: mediatek: mt8196: fix APLL mux error handling
      ASoC: mediatek: mt8196: fix APLL enable error handling
      ASoC: mediatek: mt8196: fix MCK error handling
      ASoC: mediatek: mt8196: fix register access clock error handling
      ASoC: mediatek: mt8196: propagate main clock errors
      ASoC: mediatek: mt8196: fix runtime resume error handling
      ASoC: mediatek: mt8196: propagate I2S clock errors
      ASoC: mediatek: mt8196: propagate TDM clock errors
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

hpp.iscas (2):
      power: supply: mm8013: Publish the OF module alias
      perf/marvell: cn10k_tad: Publish the OF module alias

liyouhong (1):
      fs/ntfs3: fix ntfs_fnd leak when compare function is missing

pengdonglin (1):
      tracing: Avoid BTF lookup in atomic context

pwngets (1):
      ntfs: fix runlist marker allocation and count

shaos (1):
      apparmor: mediate AF_UNSPEC socket disconnects

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

