Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9674582FE;
	Mon, 14 Sep 2026 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387161; cv=none; b=JaLgb1tPN+aP5nyUrtMcWXtWBQqlMe24yA6cLzagWvRS0ceZsIh9RTLpgjCB7MvHL+H4HEbwtI2GreKD8u2RWHhBUJQkXL5Kjbr+8cmquj5nxueptAETswVnAYITJz/0WAjhSBqZyoMlVpETFgFfrUQdfjHL52w4hRMwUbJppLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387161; c=relaxed/simple;
	bh=leUxSbif63yjjsQ+VauNz/bZU2+hk0Zcs5fQdbKNIQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nx4R+CaLUtZTR4VtcxyXkrxRD1oXSNA7r0aEthY5SV9h+FZrr1irgiPbVJpMcttC7umdqjqQHY/Zp3vzwiN1JUDVdXn/Q4asn/DFz1XTpw9/yh/k1xe1qmYPn2JCYePUJBcMa1/DQtFkZe67fRJpnQLrvRwDqr7/OqR3+OeX4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KwqyiQUl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KwqyiQUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3041F00899;
	Mon, 14 Sep 2026 11:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789387131;
	bh=WRAFWQlHsfueiOXNMgt04oN24D9qs9UQAkd8gWfSeuA=;
	h=From:To:Cc:Subject:Date;
	b=KwqyiQUlJX9fFBmCRAx/ebMG15Yj3CaNLSP3IAoLzvaNt5jhkULTB6NVwQzjt7TJw
	 xiwcsb9e2UIPT2XCZbLu+S3HtB2ISzM4bAOwV8tFP1Da7CLOc1b1UPnbh+MazD/New
	 YoOjIDXXQJToXve31JkeSk/o0opJg5bwRYm4h81I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.2.6
Date: Mon, 14 Sep 2026 13:58:26 +0200
Message-ID: <2026091427-finally-dove-794b@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.2.6 kernel.

All users of the 7.2 kernel series must upgrade.

The updated 7.2.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.2.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/configfs-usb-gadget-uac1_legacy                     |    3 
 Documentation/admin-guide/device-mapper/dm-ima.rst                            |    7 
 Documentation/admin-guide/device-mapper/dm-integrity.rst                      |   13 
 Documentation/hwmon/emc1403.rst                                               |    8 
 Documentation/leds/leds-st1202.rst                                            |    2 
 Documentation/sunrpc/xdr/nfs4_1.x                                             |  241 +
 Documentation/usb/gadget-testing.rst                                          |    3 
 Makefile                                                                      |    8 
 arch/arm/Kconfig                                                              |    1 
 arch/arm/boot/dts/allwinner/sun4i-a10.dtsi                                    |    2 
 arch/arm/boot/dts/marvell/armada-388-helios4.dts                              |   13 
 arch/arm/kernel/hw_breakpoint.c                                               |   11 
 arch/arm/mach-imx/avic.c                                                      |    2 
 arch/arm/mach-imx/src.c                                                       |    3 
 arch/arm/mach-lpc32xx/common.c                                                |    5 
 arch/arm/mach-lpc32xx/common.h                                                |    2 
 arch/arm/mach-lpc32xx/phy3250.c                                               |    2 
 arch/arm/mach-lpc32xx/pm.c                                                    |    5 
 arch/arm/mach-omap2/omap_hwmod.c                                              |   26 
 arch/arm/mach-tegra/irq.c                                                     |    9 
 arch/arm/mm/fault.c                                                           |   22 
 arch/arm64/Kconfig                                                            |    2 
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi                       |    4 
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts                                |    4 
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                                    |    3 
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi                              |    8 
 arch/arm64/boot/dts/freescale/imx8mp-ab2.dts                                  |    4 
 arch/arm64/boot/dts/freescale/imx8mp-frdm.dts                                 |    2 
 arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi                        |    4 
 arch/arm64/boot/dts/freescale/imx94.dtsi                                      |    5 
 arch/arm64/boot/dts/freescale/imx943.dtsi                                     |    5 
 arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi                        |    1 
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts                        |    3 
 arch/arm64/boot/dts/mediatek/mt8390-tungsten-smarc.dtsi                       |    4 
 arch/arm64/boot/dts/nvidia/tegra264.dtsi                                      |   10 
 arch/arm64/boot/dts/qcom/agatti.dtsi                                          |    1 
 arch/arm64/boot/dts/qcom/eliza-mtp.dts                                        |    4 
 arch/arm64/boot/dts/qcom/eliza.dtsi                                           |    4 
 arch/arm64/boot/dts/qcom/glymur-crd.dts                                       |  399 ---
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi                                      |  434 +++
 arch/arm64/boot/dts/qcom/glymur.dtsi                                          |   25 
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi                                   |   20 
 arch/arm64/boot/dts/qcom/hamoa-lenovo-ideacentre-mini-01q8x10.dts             |   20 
 arch/arm64/boot/dts/qcom/hamoa.dtsi                                           |    4 
 arch/arm64/boot/dts/qcom/ipq5018.dtsi                                         |    5 
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts                                    |    4 
 arch/arm64/boot/dts/qcom/kaanapali-qrd.dts                                    |    4 
 arch/arm64/boot/dts/qcom/kaanapali.dtsi                                       |    4 
 arch/arm64/boot/dts/qcom/kodiak.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/lemans-evk-ifp-mezzanine.dtso                        |   18 
 arch/arm64/boot/dts/qcom/lemans-evk.dts                                       |    4 
 arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi                              |    8 
 arch/arm64/boot/dts/qcom/lemans.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/milos.dtsi                                           |    2 
 arch/arm64/boot/dts/qcom/monaco-evk-ifp-mezzanine.dtso                        |   18 
 arch/arm64/boot/dts/qcom/monaco-monza-som.dtsi                                |   16 
 arch/arm64/boot/dts/qcom/monaco.dtsi                                          |   24 
 arch/arm64/boot/dts/qcom/msm8976-longcheer-l9360.dts                          |    4 
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts                            |    2 
 arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi                     |    4 
 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts                             |    5 
 arch/arm64/boot/dts/qcom/msm8998.dtsi                                         |   24 
 arch/arm64/boot/dts/qcom/purwa-iot-som.dtsi                                   |   20 
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts                            |    4 
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts                                      |    4 
 arch/arm64/boot/dts/qcom/qcm6490-particle-tachyon.dts                         |    4 
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts                              |    4 
 arch/arm64/boot/dts/qcom/qcs404.dtsi                                          |   16 
 arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts                         |   18 
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-industrial-mezzanine.dtso            |   50 
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts                                  |   22 
 arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts                 |   22 
 arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts                     |    4 
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi                                  |    4 
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts                                      |    8 
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts                                      |    8 
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts                                      |   16 
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts                                     |    8 
 arch/arm64/boot/dts/qcom/sar2130p-qar2130p.dts                                |    4 
 arch/arm64/boot/dts/qcom/sar2130p.dtsi                                        |    8 
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts                              |    4 
 arch/arm64/boot/dts/qcom/sc7180-ecs-liva-qc710.dts                            |    4 
 arch/arm64/boot/dts/qcom/sc7180-idp.dts                                       |    4 
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi                                  |    9 
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi                                |    5 
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi                                      |    4 
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi                                    |    4 
 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts                           |   73 
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts                                   |   72 
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                                         |   16 
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                                     |    4 
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts                    |    2 
 arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts                        |    4 
 arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts                     |   19 
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                                        |   10 
 arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts                            |    2 
 arch/arm64/boot/dts/qcom/sdm670-google-common.dtsi                            |    5 
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts                                    |    8 
 arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi                            |    4 
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi                                |    4 
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts                                       |    8 
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts                       |    4 
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts                             |    4 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi                  |    4 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts                            |    4 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                                          |   64 
 arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dts                    |    8 
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts                          |    8 
 arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts                              |    8 
 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts                      |    2 
 arch/arm64/boot/dts/qcom/sm6125.dtsi                                          |  153 -
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts                             |    6 
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts                                       |    8 
 arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts                     |    4 
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts                                       |    4 
 arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi                       |    4 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sm8250-hdk.dts                                       |    8 
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts                                       |    8 
 arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi                          |    4 
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi                      |    2 
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dts                               |    4 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                                          |   48 
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts                                       |    8 
 arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts                    |    8 
 arch/arm64/boot/dts/qcom/sm8350-mtp.dts                                       |    8 
 arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi                       |    4 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts                                       |    4 
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts                                       |    4 
 arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi                       |    4 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts                                       |    4 
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts                                       |    4 
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts                                       |    4 
 arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts                   |    4 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sm8650-ayaneo-pocket-s2.dts                          |    4 
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts                                       |    4 
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts                                       |    4 
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts                                       |    4 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                                          |    8 
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts                                       |    4 
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts                                       |    4 
 arch/arm64/boot/dts/qcom/sm8750.dtsi                                          |    5 
 arch/arm64/boot/dts/qcom/talos-evk-som.dtsi                                   |    4 
 arch/arm64/boot/dts/qcom/talos.dtsi                                           |    8 
 arch/arm64/boot/dts/qcom/x1-asus-vivobook-s15.dtsi                            |   20 
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi                             |   20 
 arch/arm64/boot/dts/qcom/x1-crd.dtsi                                          |   20 
 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi                                   |   16 
 arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi                              |   12 
 arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi                             |    8 
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                                  |   20 
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi                   |   20 
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts                         |   16 
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts                      |   12 
 arch/arm64/boot/dts/qcom/x1e80100-medion-sprchrgd-14-s1.dts                   |   16 
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi                      |   16 
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                                     |   20 
 arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts                     |   20 
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi                                    |    2 
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi                                    |    2 
 arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts                        |   14 
 arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts                        |   15 
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi                       |    3 
 arch/arm64/boot/dts/rockchip/rk3566-bigtreetech-cb2.dtsi                      |    2 
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi                                 |    4 
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi                                |    4 
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi                                      |    2 
 arch/arm64/include/asm/processor.h                                            |    2 
 arch/arm64/include/asm/ptdump.h                                               |    2 
 arch/arm64/include/asm/rsi_cmds.h                                             |   27 
 arch/arm64/kernel/efi.c                                                       |    4 
 arch/arm64/kernel/entry-common.c                                              |   30 
 arch/arm64/kernel/hibernate.c                                                 |   16 
 arch/arm64/kernel/ptrace.c                                                    |   54 
 arch/arm64/kernel/smp.c                                                       |    2 
 arch/arm64/lib/Makefile                                                       |    4 
 arch/arm64/mm/ptdump.c                                                        |   14 
 arch/arm64/net/bpf_jit_comp.c                                                 |   68 
 arch/csky/kernel/entry.S                                                      |    6 
 arch/m68k/emu/nfcon.c                                                         |    2 
 arch/m68k/kernel/traps.c                                                      |    4 
 arch/mips/kernel/ptrace.c                                                     |    6 
 arch/powerpc/configs/85xx-hw.config                                           |    1 
 arch/powerpc/include/asm/syscall.h                                            |    6 
 arch/powerpc/include/asm/thread_info.h                                        |    1 
 arch/powerpc/include/asm/xive.h                                               |    4 
 arch/powerpc/kernel/irq.c                                                     |   16 
 arch/powerpc/kernel/smp.c                                                     |    3 
 arch/powerpc/kernel/syscall.c                                                 |    3 
 arch/powerpc/kexec/crash.c                                                    |    2 
 arch/powerpc/net/bpf_jit_comp64.c                                             |    6 
 arch/powerpc/net/bpf_timed_may_goto.S                                         |    2 
 arch/powerpc/platforms/44x/gpio.c                                             |    1 
 arch/powerpc/platforms/powernv/smp.c                                          |    8 
 arch/powerpc/platforms/pseries/smp.c                                          |    8 
 arch/powerpc/sysdev/cpm_common.c                                              |   13 
 arch/powerpc/sysdev/xive/common.c                                             |   22 
 arch/riscv/boot/dts/sophgo/cv180x.dtsi                                        |    2 
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts                               |    4 
 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts                             |    4 
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts                                |    2 
 arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts                              |    4 
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi                                  |   24 
 arch/riscv/boot/dts/spacemit/k3-com260.dtsi                                   |    6 
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts                                  |   10 
 arch/riscv/boot/dts/thead/th1520.dtsi                                         |    3 
 arch/riscv/kernel/cpufeature.c                                                |    3 
 arch/riscv/kernel/machine_kexec_file.c                                        |   14 
 arch/riscv/net/bpf_jit_comp64.c                                               |   28 
 arch/riscv/net/bpf_jit_core.c                                                 |    1 
 arch/s390/include/asm/irqflags.h                                              |   20 
 arch/s390/kernel/Makefile                                                     |    1 
 arch/s390/kernel/debug.c                                                      |   10 
 arch/s390/kernel/irqflags.c                                                   |   28 
 arch/s390/kernel/vdso/Makefile                                                |    3 
 arch/s390/net/bpf_jit_comp.c                                                  |   15 
 arch/x86/entry/entry_64_fred.S                                                |    2 
 arch/x86/events/amd/uncore.c                                                  |   31 
 arch/x86/events/core.c                                                        |    3 
 arch/x86/events/intel/core.c                                                  |    6 
 arch/x86/events/intel/pt.c                                                    |   96 
 arch/x86/events/intel/uncore.c                                                |  151 -
 arch/x86/events/intel/uncore.h                                                |   33 
 arch/x86/events/intel/uncore_discovery.c                                      |   21 
 arch/x86/events/intel/uncore_discovery.h                                      |    6 
 arch/x86/events/intel/uncore_nhmex.c                                          |    3 
 arch/x86/events/intel/uncore_snb.c                                            |   82 
 arch/x86/events/intel/uncore_snbep.c                                          |   77 
 arch/x86/events/perf_event.h                                                  |    2 
 arch/x86/include/asm/linkage.h                                                |    2 
 arch/x86/include/asm/pkeys.h                                                  |    3 
 arch/x86/kernel/cpu/common.c                                                  |   25 
 arch/x86/kernel/uprobes.c                                                     |  404 +--
 arch/x86/kvm/Makefile                                                         |    4 
 arch/x86/kvm/regs.c                                                           |  874 ++++++
 arch/x86/kvm/regs.h                                                           |   30 
 arch/x86/kvm/x86.c                                                            |  885 ------
 arch/x86/kvm/x86.h                                                            |    2 
 arch/x86/mm/pat/set_memory.c                                                  |    8 
 arch/x86/net/bpf_jit_comp.c                                                   |   49 
 block/bio-integrity-auto.c                                                    |   10 
 block/bio-integrity-fs.c                                                      |    6 
 block/blk-cgroup.c                                                            |    5 
 block/blk-iocost.c                                                            |    9 
 block/blk-iolatency.c                                                         |   13 
 block/blk-stat.c                                                              |    2 
 block/fops.c                                                                  |    6 
 block/kyber-iosched.c                                                         |    2 
 crypto/acompress.c                                                            |   16 
 crypto/lskcipher.c                                                            |    1 
 drivers/accessibility/speakup/keyhelp.c                                       |   17 
 drivers/accessibility/speakup/kobjects.c                                      |    6 
 drivers/acpi/acpi_platform.c                                                  |   16 
 drivers/acpi/battery.c                                                        |   36 
 drivers/acpi/bus.c                                                            |   68 
 drivers/acpi/ec.c                                                             |   40 
 drivers/acpi/pci_root.c                                                       |   14 
 drivers/acpi/processor_core.c                                                 |   31 
 drivers/acpi/processor_driver.c                                               |    6 
 drivers/acpi/processor_idle.c                                                 |   28 
 drivers/acpi/riscv/irq.c                                                      |   33 
 drivers/acpi/scan.c                                                           |   33 
 drivers/acpi/video_detect.c                                                   |    4 
 drivers/base/cacheinfo.c                                                      |    9 
 drivers/base/firmware_loader/fallback.c                                       |   10 
 drivers/base/soc.c                                                            |   15 
 drivers/base/swnode.c                                                         |    2 
 drivers/base/transport_class.c                                                |    5 
 drivers/block/mtip32xx/mtip32xx.c                                             |    7 
 drivers/block/mtip32xx/mtip32xx.h                                             |    2 
 drivers/block/null_blk/main.c                                                 |   78 
 drivers/block/ublk_drv.c                                                      |  127 -
 drivers/bluetooth/btintel.c                                                   |    2 
 drivers/bluetooth/btmtk.c                                                     |   11 
 drivers/bluetooth/btmtksdio.c                                                 |   36 
 drivers/bluetooth/btnxpuart.c                                                 |   15 
 drivers/bluetooth/btqca.c                                                     |    3 
 drivers/bluetooth/btusb.c                                                     |   17 
 drivers/bluetooth/virtio_bt.c                                                 |    8 
 drivers/bus/mhi/ep/main.c                                                     |   15 
 drivers/bus/mhi/host/init.c                                                   |    4 
 drivers/bus/mhi/host/main.c                                                   |    6 
 drivers/bus/qcom-ebi2.c                                                       |   44 
 drivers/bus/ti-sysc.c                                                         |   12 
 drivers/char/hw_random/core.c                                                 |    4 
 drivers/char/hw_random/imx-rngc.c                                             |    4 
 drivers/char/hw_random/ks-sa-rng.c                                            |    9 
 drivers/char/hw_random/omap-rng.c                                             |   30 
 drivers/char/hw_random/xilinx-trng.c                                          |   32 
 drivers/char/ppdev.c                                                          |   10 
 drivers/char/tlclk.c                                                          |   36 
 drivers/char/tpm/st33zp24/st33zp24.c                                          |    8 
 drivers/char/xilinx_hwicap/xilinx_hwicap.c                                    |    5 
 drivers/clk/clk-devres.c                                                      |   12 
 drivers/clk/clk-k230.c                                                        |    4 
 drivers/clk/clk-moxart.c                                                      |   14 
 drivers/clk/clk-palmas.c                                                      |   14 
 drivers/clk/clk-versaclock7.c                                                 |    2 
 drivers/clk/eswin/clk-eic7700.c                                               |    3 
 drivers/clk/eswin/clk.c                                                       |    4 
 drivers/clk/hisilicon/reset.c                                                 |    2 
 drivers/clk/imx/clk-scu.c                                                     |    1 
 drivers/clk/mediatek/clk-mt6735-apmixedsys.c                                  |    5 
 drivers/clk/mediatek/clk-mt8135.c                                             |    5 
 drivers/clk/mediatek/clk-pllfh.c                                              |   98 
 drivers/clk/nuvoton/clk-ma35d1-pll.c                                          |   38 
 drivers/clk/qcom/camcc-sc8280xp.c                                             |   19 
 drivers/clk/qcom/common.c                                                     |    4 
 drivers/clk/qcom/dispcc-qcm2290.c                                             |   44 
 drivers/clk/qcom/gcc-glymur.c                                                 |   33 
 drivers/clk/qcom/gcc-nord.c                                                   |   45 
 drivers/clk/qcom/gcc-qcm2290.c                                                |   18 
 drivers/clk/qcom/gcc-qcs8300.c                                                |    8 
 drivers/clk/qcom/gcc-sm6115.c                                                 |    6 
 drivers/clk/qcom/gdsc.c                                                       |   47 
 drivers/clk/qcom/gdsc.h                                                       |    1 
 drivers/clk/qcom/gpucc-qcm2290.c                                              |   89 
 drivers/clk/qcom/gxclkctl-kaanapali.c                                         |    1 
 drivers/clk/qcom/negcc-nord.c                                                 |   75 
 drivers/clk/rockchip/clk-pll.c                                                |   16 
 drivers/clk/rockchip/clk-rk3576.c                                             |   15 
 drivers/clk/rockchip/clk-rk3588.c                                             |    4 
 drivers/clk/rockchip/clk.h                                                    |    8 
 drivers/clk/spacemit/ccu-k3.c                                                 |   17 
 drivers/clk/stm32/clk-stm32mp21.c                                             |    1 
 drivers/clk/stm32/clk-stm32mp25.c                                             |    1 
 drivers/clk/sunxi-ng/ccu_mux.c                                                |   57 
 drivers/clk/tegra/clk-tegra124-emc.c                                          |    1 
 drivers/clk/ti/adpll.c                                                        |    4 
 drivers/clk/ti/divider.c                                                      |    2 
 drivers/clk/ti/mux.c                                                          |   22 
 drivers/clk/visconti/clkc.c                                                   |    2 
 drivers/clk/x86/clk-pmc-atom.c                                                |    3 
 drivers/clocksource/clps711x-timer.c                                          |    2 
 drivers/clocksource/samsung_pwm_timer.c                                       |   22 
 drivers/clocksource/timer-armada-370-xp.c                                     |   18 
 drivers/cpufreq/amd-pstate-ut.c                                               |    5 
 drivers/cpufreq/amd-pstate.c                                                  |   47 
 drivers/cpufreq/imx6q-cpufreq.c                                               |    6 
 drivers/cpufreq/intel_pstate.c                                                |   19 
 drivers/cpufreq/spear-cpufreq.c                                               |    4 
 drivers/crypto/aspeed/aspeed-acry.c                                           |    2 
 drivers/crypto/aspeed/aspeed-hace.c                                           |    2 
 drivers/crypto/atmel-ecc.c                                                    |    3 
 drivers/crypto/atmel-sha204a.c                                                |    6 
 drivers/crypto/ccp/sev-dev.c                                                  |   19 
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
 drivers/cxl/core/features.c                                                   |   15 
 drivers/cxl/core/mbox.c                                                       |   12 
 drivers/cxl/core/memdev.c                                                     |    2 
 drivers/cxl/core/port.c                                                       |    4 
 drivers/cxl/core/region.c                                                     |    7 
 drivers/cxl/pci.c                                                             |   13 
 drivers/dax/dax-private.h                                                     |    2 
 drivers/dax/fsdev.c                                                           |  133 -
 drivers/dax/super.c                                                           |   54 
 drivers/dma/dw-edma/dw-edma-core.c                                            |  104 
 drivers/dma/hisi_dma.c                                                        |    2 
 drivers/dma/mediatek/mtk-uart-apdma.c                                         |    2 
 drivers/dma/qcom/bam_dma.c                                                    |    1 
 drivers/dma/xilinx/xilinx_dma.c                                               |   26 
 drivers/dma/xilinx/zynqmp_dma.c                                               |    4 
 drivers/dpll/dpll_core.c                                                      |   24 
 drivers/dpll/dpll_netlink.c                                                   |   59 
 drivers/firewire/.kunitconfig                                                 |    1 
 drivers/firewire/Kconfig                                                      |   15 
 drivers/firewire/core-topology.c                                              |   62 
 drivers/firewire/node-tree-test.c                                             |  607 ++++
 drivers/firmware/arm_scmi/bus.c                                               |  182 -
 drivers/firmware/arm_scmi/common.h                                            |    2 
 drivers/firmware/arm_scmi/driver.c                                            |   81 
 drivers/firmware/arm_scmi/notify.c                                            |   21 
 drivers/firmware/arm_scmi/notify.h                                            |    1 
 drivers/firmware/arm_scmi/transports/mailbox.c                                |   26 
 drivers/firmware/arm_scmi/transports/smc.c                                    |   15 
 drivers/firmware/google/coreboot_table.c                                      |   17 
 drivers/firmware/imx/sm-misc.c                                                |    3 
 drivers/firmware/qcom/Makefile                                                |    1 
 drivers/firmware/qcom/qcom_scm-smc.c                                          |   12 
 drivers/firmware/qcom/qcom_scm.c                                              |   42 
 drivers/firmware/qcom/qcom_scm.h                                              |    2 
 drivers/firmware/qcom/qcom_scm_trace.h                                        |  143 +
 drivers/firmware/qcom/qcom_tzmem.c                                            |   13 
 drivers/gpib/common/gpib_os.c                                                 |   21 
 drivers/gpib/common/iblib.c                                                   |    3 
 drivers/gpib/include/amccs5933.h                                              |   10 
 drivers/gpib/tnt4882/mite.h                                                   |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                                       |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                                        |   15 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                                         |   74 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                             |   22 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h                             |    7 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c                        |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c                        |   10 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h                        |   10 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c                       |   10 
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c                        |    2 
 drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c                        |    3 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c           |    1 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c                           |   10 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c                         |   11 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c                           |   24 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c                         |   35 
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c                          |    5 
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c                                |    2 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c                           |    2 
 drivers/gpu/drm/bridge/display-connector.c                                    |   36 
 drivers/gpu/drm/bridge/of-display-mode-bridge.c                               |    2 
 drivers/gpu/drm/bridge/synopsys/dw-dp.c                                       |    6 
 drivers/gpu/drm/bridge/tc358767.c                                             |    2 
 drivers/gpu/drm/display/drm_hdmi_state_helper.c                               |   15 
 drivers/gpu/drm/drm_atomic_state_helper.c                                     |    2 
 drivers/gpu/drm/drm_dumb_buffers.c                                            |    1 
 drivers/gpu/drm/lima/lima_device.c                                            |   12 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                                         |    5 
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c                                     |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                         |    5 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                         |    8 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c                                   |    5 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h                                   |   12 
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c                                         |    5 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h                    |   12 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c                                 |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                                   |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c                                |   12 
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
 drivers/gpu/drm/msm/msm_gpu.c                                                 |    8 
 drivers/gpu/drm/msm/msm_ringbuffer.c                                          |    7 
 drivers/gpu/drm/msm/msm_ringbuffer.h                                          |    1 
 drivers/gpu/drm/mxsfb/lcdif_kms.c                                             |   15 
 drivers/gpu/drm/omapdrm/dss/dsi.c                                             |    7 
 drivers/gpu/drm/omapdrm/dss/dsi.h                                             |    2 
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c                                 |   10 
 drivers/gpu/drm/panthor/panthor_drv.c                                         |    2 
 drivers/gpu/drm/panthor/panthor_gem.c                                         |   18 
 drivers/gpu/drm/panthor/panthor_gem.h                                         |    2 
 drivers/gpu/drm/panthor/panthor_mmu.c                                         |  251 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c                               |   22 
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c                                     |   15 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                                  |    5 
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c                                  |   21 
 drivers/gpu/drm/solomon/ssd130x.c                                             |    9 
 drivers/gpu/drm/sun4i/sun4i_crtc.c                                            |    2 
 drivers/gpu/drm/sun4i/sun4i_drv.c                                             |    3 
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c                                        |    2 
 drivers/gpu/drm/sun4i/sun4i_tcon.c                                            |   22 
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c                                         |    2 
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c                                        |    2 
 drivers/gpu/drm/sun4i/sun8i_mixer.c                                           |    2 
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c                                        |   71 
 drivers/gpu/drm/sun4i/sun8i_tcon_top.h                                        |    6 
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c                                       |   20 
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h                                       |    1 
 drivers/gpu/drm/tegra/dsi.c                                                   |    9 
 drivers/gpu/drm/tve200/tve200_drv.c                                           |    1 
 drivers/gpu/drm/v3d/Kconfig                                                   |    1 
 drivers/gpu/drm/v3d/v3d_drv.h                                                 |   39 
 drivers/gpu/drm/v3d/v3d_sched.c                                               |   60 
 drivers/gpu/drm/v3d/v3d_submit.c                                              |  709 ++---
 drivers/gpu/drm/xe/tests/xe_migrate.c                                         |    3 
 drivers/gpu/drm/xe/xe_gt_idle.c                                               |    3 
 drivers/gpu/drm/xe/xe_guc_submit.c                                            |    6 
 drivers/gpu/drm/xe/xe_pagefault.c                                             |    2 
 drivers/gpu/drm/xe/xe_ras.c                                                   |   91 
 drivers/gpu/drm/xe/xe_ras.h                                                   |    3 
 drivers/gpu/drm/xe/xe_ras_types.h                                             |   26 
 drivers/gpu/drm/xe/xe_sysctrl.c                                               |    7 
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c                                       |   36 
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.h                                       |    4 
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h                                 |    2 
 drivers/gpu/drm/xe/xe_sysctrl_types.h                                         |    3 
 drivers/gpu/drm/xe/xe_wa_oob.rules                                            |    2 
 drivers/gpu/host1x/bus.c                                                      |    2 
 drivers/gpu/host1x/debug.c                                                    |    4 
 drivers/gpu/host1x/hw/channel_hw.c                                            |    5 
 drivers/gpu/nova-core/fb/hal/gb100.rs                                         |    1 
 drivers/gpu/nova-core/fb/hal/gb202.rs                                         |    1 
 drivers/gpu/nova-core/fsp.rs                                                  |   87 
 drivers/gpu/nova-core/fsp/hal.rs                                              |    4 
 drivers/gpu/nova-core/fsp/hal/gb100.rs                                        |    6 
 drivers/gpu/nova-core/fsp/hal/gb202.rs                                        |    9 
 drivers/gpu/nova-core/fsp/hal/gh100.rs                                        |    9 
 drivers/gpu/nova-core/gpu.rs                                                  |    6 
 drivers/gpu/nova-core/gsp/boot.rs                                             |    2 
 drivers/gpu/nova-core/gsp/commands.rs                                         |   73 
 drivers/gpu/nova-core/gsp/hal/tu102.rs                                        |   19 
 drivers/gpu/nova-core/regs.rs                                                 |    2 
 drivers/hid/hid-asus.c                                                        |  394 ++-
 drivers/hid/hid-core.c                                                        |    9 
 drivers/hid/hid-haptic.c                                                      |    2 
 drivers/hid/hid-lg4ff.c                                                       |    8 
 drivers/hid/hid-logitech-hidpp.c                                              |   23 
 drivers/hid/hid-multitouch.c                                                  |    2 
 drivers/hid/hid-nintendo.c                                                    |    1 
 drivers/hid/hid-roccat-kone.c                                                 |    8 
 drivers/hid/hid-sony.c                                                        |    2 
 drivers/hid/hid-steam.c                                                       |  518 ++--
 drivers/hid/hid-tmff.c                                                        |    9 
 drivers/hid/i2c-hid/Makefile                                                  |    2 
 drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c                                    |  104 
 drivers/hid/i2c-hid/i2c-hid-acpi.c                                            |   52 
 drivers/hid/i2c-hid/i2c-hid-acpi.h                                            |   33 
 drivers/hid/i2c-hid/i2c-hid-core.c                                            |    2 
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c                                       |    4 
 drivers/hv/vmbus_drv.c                                                        |   15 
 drivers/hwmon/coretemp.c                                                      |    1 
 drivers/hwmon/cros_ec_hwmon.c                                                 |   17 
 drivers/hwmon/emc1403.c                                                       |   27 
 drivers/hwmon/ltc4283.c                                                       |    1 
 drivers/hwspinlock/hwspinlock_core.c                                          |    2 
 drivers/hwtracing/coresight/coresight-etm4x-cfg.c                             |    2 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                            |   59 
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c                           |    6 
 drivers/hwtracing/coresight/coresight-etm4x.h                                 |    7 
 drivers/i2c/busses/i2c-ocores.c                                               |    6 
 drivers/i3c/master.c                                                          |   63 
 drivers/i3c/master/adi-i3c-master.c                                           |    1 
 drivers/i3c/master/dw-i3c-master.c                                            |   10 
 drivers/i3c/master/mipi-i3c-hci/pio.c                                         |    7 
 drivers/i3c/master/renesas-i3c.c                                              |   28 
 drivers/idle/intel_idle.c                                                     |   23 
 drivers/iio/accel/dmard09.c                                                   |    7 
 drivers/iio/dac/ad5686-spi.c                                                  |    9 
 drivers/iio/dac/ad5696-i2c.c                                                  |    9 
 drivers/iio/light/gp2ap002.c                                                  |   14 
 drivers/iio/light/isl29028.c                                                  |    2 
 drivers/iio/light/opt4060.c                                                   |    4 
 drivers/iio/light/tsl2583.c                                                   |    2 
 drivers/iio/light/tsl2772.c                                                   |    2 
 drivers/iio/orientation/hid-sensor-rotation.c                                 |   20 
 drivers/infiniband/core/cma.c                                                 |    6 
 drivers/infiniband/core/counters.c                                            |    5 
 drivers/infiniband/core/cq.c                                                  |    2 
 drivers/infiniband/core/device.c                                              |    1 
 drivers/infiniband/core/nldev.c                                               |    5 
 drivers/infiniband/core/restrack.c                                            |  165 +
 drivers/infiniband/core/restrack.h                                            |    3 
 drivers/infiniband/core/ucma.c                                                |    2 
 drivers/infiniband/core/uverbs_std_types_dmah.c                               |    7 
 drivers/infiniband/core/verbs.c                                               |   28 
 drivers/infiniband/hw/bng_re/bng_fw.c                                         |   10 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                      |   71 
 drivers/infiniband/hw/cxgb4/device.c                                          |    2 
 drivers/infiniband/hw/cxgb4/mem.c                                             |   50 
 drivers/infiniband/hw/efa/efa_verbs.c                                         |   13 
 drivers/infiniband/hw/erdma/Kconfig                                           |    2 
 drivers/infiniband/hw/erdma/erdma_cm.c                                        |    6 
 drivers/infiniband/hw/erdma/erdma_eq.c                                        |   10 
 drivers/infiniband/hw/erdma/erdma_verbs.c                                     |   39 
 drivers/infiniband/hw/erdma/erdma_verbs.h                                     |   40 
 drivers/infiniband/hw/hfi1/init.c                                             |   16 
 drivers/infiniband/hw/hfi1/user_sdma.c                                        |   13 
 drivers/infiniband/hw/irdma/utils.c                                           |    6 
 drivers/infiniband/hw/irdma/verbs.c                                           |  116 
 drivers/infiniband/hw/irdma/verbs.h                                           |    3 
 drivers/infiniband/hw/mana/qp.c                                               |   10 
 drivers/infiniband/hw/mlx5/cong.c                                             |    8 
 drivers/infiniband/hw/mlx5/main.c                                             |    7 
 drivers/infiniband/hw/mlx5/qp.c                                               |   25 
 drivers/infiniband/sw/rdmavt/vt.c                                             |    4 
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
 drivers/iommu/amd/init.c                                                      |   36 
 drivers/iommu/amd/ppr.c                                                       |    2 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                                   |    9 
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c                                |  173 -
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                                       |    6 
 drivers/iommu/dma-iommu.c                                                     |   26 
 drivers/iommu/intel/iommu.c                                                   |   32 
 drivers/iommu/intel/iommu.h                                                   |    2 
 drivers/iommu/intel/pasid.c                                                   |    9 
 drivers/iommu/iommufd/device.c                                                |   13 
 drivers/iommu/iommufd/iommufd_private.h                                       |    9 
 drivers/iommu/iommufd/main.c                                                  |   20 
 drivers/iommu/iommufd/selftest.c                                              |    5 
 drivers/iommu/msm_iommu.c                                                     |    2 
 drivers/iommu/mtk_iommu_v1.c                                                  |    2 
 drivers/ipack/devices/ipoctal.c                                               |   56 
 drivers/irqchip/irq-ast2700-intc0.c                                           |    4 
 drivers/irqchip/irq-ast2700-intc1.c                                           |    3 
 drivers/irqchip/irq-gic-v3-its.c                                              |   23 
 drivers/irqchip/irq-gic-v5-irs.c                                              |   38 
 drivers/irqchip/irq-gic-v5.c                                                  |   29 
 drivers/irqchip/irq-realtek-rtl.c                                             |  121 
 drivers/irqchip/irq-renesas-irqc.c                                            |    1 
 drivers/irqchip/irq-renesas-rzg2l.c                                           |    4 
 drivers/leds/leds-gpio.c                                                      |    1 
 drivers/leds/leds-pca9532.c                                                   |   18 
 drivers/leds/leds-st1202.c                                                    |   96 
 drivers/leds/rgb/leds-lp5860-core.c                                           |    3 
 drivers/leds/rgb/leds-lp5860-spi.c                                            |   10 
 drivers/mailbox/pcc.c                                                         |   41 
 drivers/mailbox/qcom-cpucp-mbox.c                                             |   25 
 drivers/mailbox/riscv-sbi-mpxy-mbox.c                                         |   12 
 drivers/mailbox/rockchip-mailbox.c                                            |   17 
 drivers/md/dm-integrity.c                                                     |  139 -
 drivers/md/dm-pcache/cache.c                                                  |   11 
 drivers/md/dm-pcache/cache.h                                                  |   17 
 drivers/md/dm-pcache/cache_gc.c                                               |   16 
 drivers/md/dm-pcache/cache_key.c                                              |   80 
 drivers/md/dm-pcache/cache_writeback.c                                        |   23 
 drivers/md/md-bitmap.c                                                        |   14 
 drivers/md/md-bitmap.h                                                        |    3 
 drivers/md/md-linear.c                                                        |    1 
 drivers/md/md-llbitmap.c                                                      |   30 
 drivers/md/md.c                                                               |   80 
 drivers/md/md.h                                                               |    1 
 drivers/md/raid0.c                                                            |    1 
 drivers/md/raid1-10.c                                                         |    8 
 drivers/md/raid1.c                                                            |  121 
 drivers/md/raid10.c                                                           |  112 
 drivers/md/raid5-ppl.c                                                        |    4 
 drivers/md/raid5.c                                                            |  108 
 drivers/media/cec/core/cec-pin.c                                              |    8 
 drivers/media/i2c/rdacm21.c                                                   |    5 
 drivers/media/pci/intel/ipu6/ipu6.c                                           |   10 
 drivers/media/platform/amd/isp4/Kconfig                                       |    1 
 drivers/media/platform/amd/isp4/isp4_interface.c                              |   10 
 drivers/media/platform/amd/isp4/isp4_interface.h                              |    2 
 drivers/media/platform/amd/isp4/isp4_subdev.c                                 |   30 
 drivers/media/platform/broadcom/bcm2835-unicam.c                              |    2 
 drivers/media/platform/qcom/iris/iris_core.c                                  |   12 
 drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c                      |    1 
 drivers/media/platform/qcom/iris/iris_state.c                                 |    2 
 drivers/media/platform/st/stm32/stm32-dcmi.c                                  |   15 
 drivers/media/platform/ti/Kconfig                                             |    1 
 drivers/media/v4l2-core/v4l2-async.c                                          |   15 
 drivers/mfd/cs42l43.c                                                         |   16 
 drivers/mfd/iqs62x.c                                                          |    2 
 drivers/mfd/macsmc.c                                                          |    8 
 drivers/mfd/rave-sp.c                                                         |   64 
 drivers/misc/ad525x_dpot-i2c.c                                                |    1 
 drivers/misc/ad525x_dpot-spi.c                                                |    1 
 drivers/misc/ad525x_dpot.c                                                    |  177 -
 drivers/misc/ad525x_dpot.h                                                    |    3 
 drivers/misc/bcm-vk/bcm_vk_msg.c                                              |    6 
 drivers/misc/cardreader/rtsx_pcr.c                                            |    2 
 drivers/misc/cardreader/rtsx_usb.c                                            |   26 
 drivers/misc/lan966x_pci.c                                                    |    1 
 drivers/misc/mei/mei_lb.c                                                     |    4 
 drivers/misc/pch_phub.c                                                       |   20 
 drivers/misc/pci_endpoint_test.c                                              |   11 
 drivers/misc/sgi-gru/grufault.c                                               |  101 
 drivers/misc/sgi-gru/gruprocfs.c                                              |    1 
 drivers/misc/sgi-gru/grutables.h                                              |    1 
 drivers/misc/vmw_vmci/vmci_event.c                                            |    4 
 drivers/mtd/devices/mtd_intel_dg.c                                            |    2 
 drivers/mtd/mtdpart.c                                                         |    3 
 drivers/mtd/mtdswap.c                                                         |    1 
 drivers/mtd/nand/raw/pl35x-nand-controller.c                                  |    8 
 drivers/mtd/ubi/attach.c                                                      |    4 
 drivers/mtd/ubi/build.c                                                       |   11 
 drivers/mtd/ubi/fastmap.c                                                     |    6 
 drivers/mtd/ubi/io.c                                                          |   11 
 drivers/mtd/ubi/ubi.h                                                         |    4 
 drivers/mtd/ubi/wl.c                                                          |   15 
 drivers/net/amt.c                                                             |    3 
 drivers/net/bonding/bond_netlink.c                                            |    2 
 drivers/net/can/m_can/m_can.c                                                 |    2 
 drivers/net/dsa/b53/b53_common.c                                              |    2 
 drivers/net/dsa/mv88e6xxx/pcs-6352.c                                          |    5 
 drivers/net/dsa/mxl862xx/mxl862xx.c                                           |    1 
 drivers/net/ethernet/airoha/airoha_eth.c                                      |   18 
 drivers/net/ethernet/airoha/airoha_eth.h                                      |    7 
 drivers/net/ethernet/airoha/airoha_npu.c                                      |    2 
 drivers/net/ethernet/allwinner/sun4i-emac.c                                   |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                     |    8 
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c                               |    2 
 drivers/net/ethernet/freescale/enetc/enetc.c                                  |   72 
 drivers/net/ethernet/freescale/enetc/enetc.h                                  |   11 
 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c                         |   30 
 drivers/net/ethernet/freescale/enetc/enetc4_hw.h                              |    4 
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c                              |  347 +-
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c                          |    2 
 drivers/net/ethernet/freescale/enetc/enetc_hw.h                               |    7 
 drivers/net/ethernet/freescale/enetc/enetc_pf.c                               |   76 
 drivers/net/ethernet/freescale/enetc/enetc_pf.h                               |    4 
 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c                        |   84 
 drivers/net/ethernet/freescale/enetc/enetc_pf_common.h                        |    4 
 drivers/net/ethernet/freescale/fec_main.c                                     |    6 
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c                             |    2 
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c                                |    9 
 drivers/net/ethernet/intel/ice/devlink/devlink.c                              |   32 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                                  |   16 
 drivers/net/ethernet/intel/ice/ice_lib.c                                      |    3 
 drivers/net/ethernet/intel/ice/ice_nvm.c                                      |   90 
 drivers/net/ethernet/intel/ice/ice_nvm.h                                      |    2 
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c                                   |   38 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                                   |    2 
 drivers/net/ethernet/intel/igc/igc_main.c                                     |    3 
 drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h                         |    1 
 drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c                   |   21 
 drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c                        |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                               |   43 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c                       |    6 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                           |   11 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c                      |    6 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c                     |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c                          |   20 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c                         |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c                           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c                              |   20 
 drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c                       |   22 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c                    |    4 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                             |    2 
 drivers/net/ethernet/mellanox/mlx5/core/vport.c                               |   44 
 drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c                         |   11 
 drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c                      |    5 
 drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c                        |   21 
 drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.h                        |   14 
 drivers/net/ethernet/microsoft/mana/gdma_main.c                               |   19 
 drivers/net/ethernet/nvidia/forcedeth.c                                       |    2 
 drivers/net/ethernet/pensando/ionic/ionic_main.c                              |    4 
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c                              |   31 
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c                              |  445 +--
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c                          |    1 
 drivers/net/ethernet/realtek/8139cp.c                                         |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c                          |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c                             |    2 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c                           |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac.h                                  |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                             |   30 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c                        |   57 
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c                                   |   18 
 drivers/net/ethernet/wangxun/libwx/wx_type.h                                  |    2 
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c                                |    5 
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h                               |    2 
 drivers/net/gtp.c                                                             |    2 
 drivers/net/ipa/ipa_main.c                                                    |    6 
 drivers/net/netdevsim/netdev.c                                                |    2 
 drivers/net/phy/air_en8811h.c                                                 |   18 
 drivers/net/ppp/pppox.c                                                       |   17 
 drivers/net/slip/slip.c                                                       |    8 
 drivers/net/thunderbolt/main.c                                                |    6 
 drivers/net/virtio_net.c                                                      |   14 
 drivers/net/vxlan/vxlan_core.c                                                |   20 
 drivers/net/vxlan/vxlan_mdb.c                                                 |    9 
 drivers/net/vxlan/vxlan_vnifilter.c                                           |    6 
 drivers/net/wireless/ath/ath10k/snoc.c                                        |    9 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                       |   30 
 drivers/net/wireless/ath/ath11k/wmi.c                                         |   40 
 drivers/net/wireless/ath/ath12k/ahb.c                                         |   18 
 drivers/net/wireless/ath/ath12k/core.c                                        |   29 
 drivers/net/wireless/ath/ath12k/core.h                                        |   13 
 drivers/net/wireless/ath/ath12k/dp_tx.c                                       |   46 
 drivers/net/wireless/ath/ath12k/dp_tx.h                                       |    2 
 drivers/net/wireless/ath/ath12k/hal.c                                         |    8 
 drivers/net/wireless/ath/ath12k/hal.h                                         |    5 
 drivers/net/wireless/ath/ath12k/mac.c                                         |   72 
 drivers/net/wireless/ath/ath12k/peer.c                                        |  130 -
 drivers/net/wireless/ath/ath12k/peer.h                                        |   14 
 drivers/net/wireless/ath/ath12k/qmi.c                                         |  168 -
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c                                 |   64 
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx_desc.h                           |   34 
 drivers/net/wireless/ath/ath12k/wifi7/hw.c                                    |   61 
 drivers/net/wireless/ath/ath12k/wmi.c                                         |  160 -
 drivers/net/wireless/ath/ath12k/wmi.h                                         |    8 
 drivers/net/wireless/ath/ath6kl/wmi.c                                         |   17 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c                        |    4 
 drivers/net/wireless/intel/iwlwifi/fw/dump.c                                  |    2 
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c                              |    8 
 drivers/net/wireless/intel/iwlwifi/mei/main.c                                 |    8 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                                  |    2 
 drivers/net/wireless/mediatek/mt76/channel.c                                  |   92 
 drivers/net/wireless/mediatek/mt76/dma.c                                      |   48 
 drivers/net/wireless/mediatek/mt76/dma.h                                      |    2 
 drivers/net/wireless/mediatek/mt76/mac80211.c                                 |   15 
 drivers/net/wireless/mediatek/mt76/mcu.c                                      |   12 
 drivers/net/wireless/mediatek/mt76/mmio.c                                     |   18 
 drivers/net/wireless/mediatek/mt76/mt76.h                                     |    7 
 drivers/net/wireless/mediatek/mt76/mt76_connac.h                              |    8 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c                          |    6 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c                          |   16 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h                          |    4 
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                              |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                            |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                              |   11 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                               |    8 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                              |   24 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                               |   14 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                               |    6 
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                            |   18 
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c                               |    9 
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c                               |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c                          |    5 
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c                               |    5 
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c                               |  103 
 drivers/net/wireless/mediatek/mt76/mt7925/Makefile                            |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                               |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                              |   54 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                               |   16 
 drivers/net/wireless/mediatek/mt76/mt7925/nan.c                               |  927 +++++++
 drivers/net/wireless/mediatek/mt76/mt7925/nan.h                               |  419 +++
 drivers/net/wireless/mediatek/mt76/mt7925/regd.c                              |   30 
 drivers/net/wireless/mediatek/mt76/mt7925/regd.h                              |    3 
 drivers/net/wireless/mediatek/mt76/mt792x.h                                   |   38 
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c                               |   91 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                              |   20 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                               |   60 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                              |   40 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                               |   21 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                               |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c                              |   88 
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                            |    1 
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h                              |   24 
 drivers/net/wireless/mediatek/mt76/scan.c                                     |   17 
 drivers/net/wireless/mediatek/mt76/sdio.c                                     |   11 
 drivers/net/wireless/mediatek/mt76/tx.c                                       |    9 
 drivers/net/wireless/mediatek/mt76/usb.c                                      |   11 
 drivers/net/wireless/realtek/rtlwifi/pci.c                                    |    6 
 drivers/net/wireless/realtek/rtw89/debug.c                                    |    2 
 drivers/net/wireless/realtek/rtw89/fw.c                                       |   10 
 drivers/net/wireless/realtek/rtw89/fw.h                                       |    3 
 drivers/net/wireless/realtek/rtw89/mac.c                                      |    2 
 drivers/net/wireless/realtek/rtw89/mac80211.c                                 |   35 
 drivers/net/wireless/realtek/rtw89/rtw8852a.c                                 |    2 
 drivers/net/wireless/virtual/mac80211_hwsim_main.c                            |    5 
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c                                  |    8 
 drivers/nfc/pn533/pn533.c                                                     |   21 
 drivers/nvdimm/label.c                                                        |   15 
 drivers/nvdimm/nd_virtio.c                                                    |  121 
 drivers/nvdimm/pmem.c                                                         |   15 
 drivers/nvdimm/region_devs.c                                                  |    5 
 drivers/nvdimm/virtio_pmem.c                                                  |   17 
 drivers/nvdimm/virtio_pmem.h                                                  |    6 
 drivers/nvme/host/apple.c                                                     |   62 
 drivers/nvme/host/core.c                                                      |    5 
 drivers/nvme/host/fc.c                                                        |    6 
 drivers/nvme/host/ioctl.c                                                     |  117 
 drivers/nvme/host/nvme.h                                                      |    7 
 drivers/nvme/host/pci.c                                                       |    2 
 drivers/nvme/target/admin-cmd.c                                               |   12 
 drivers/nvme/target/configfs.c                                                |   10 
 drivers/nvme/target/core.c                                                    |   52 
 drivers/nvme/target/fabrics-cmd-auth.c                                        |   12 
 drivers/nvme/target/fabrics-cmd.c                                             |    2 
 drivers/nvme/target/nvmet.h                                                   |    6 
 drivers/nvme/target/pci-epf.c                                                 |    2 
 drivers/nvme/target/pr.c                                                      |   27 
 drivers/nvme/target/rdma.c                                                    |   31 
 drivers/nvme/target/zns.c                                                     |    2 
 drivers/of/irq.c                                                              |    4 
 drivers/opp/core.c                                                            |   13 
 drivers/pci/controller/cadence/Kconfig                                        |    4 
 drivers/pci/controller/cadence/pci-j721e.c                                    |    4 
 drivers/pci/controller/dwc/Kconfig                                            |    2 
 drivers/pci/controller/dwc/pci-keystone.c                                     |    6 
 drivers/pci/controller/dwc/pcie-designware-ep.c                               |   19 
 drivers/pci/controller/dwc/pcie-designware.h                                  |    1 
 drivers/pci/controller/dwc/pcie-qcom.c                                        |   37 
 drivers/pci/controller/dwc/pcie-ultrarisc.c                                   |   85 
 drivers/pci/controller/pci-xgene.c                                            |    5 
 drivers/pci/controller/plda/pcie-starfive.c                                   |   10 
 drivers/pci/pci-driver.c                                                      |  194 -
 drivers/pci/pci-sysfs.c                                                       |   26 
 drivers/pci/pci.h                                                             |   43 
 drivers/pci/pcie/aspm.c                                                       |   19 
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c                                      |   24 
 drivers/pci/search.c                                                          |    8 
 drivers/perf/arm_pmuv3.c                                                      |    2 
 drivers/perf/arm_spe_pmu.c                                                    |    2 
 drivers/perf/cxl_pmu.c                                                        |    2 
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c                                     |   33 
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c                                      |    1 
 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c                                |   12 
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c                                       |   12 
 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c                                     |   37 
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c                                 |   26 
 drivers/phy/renesas/phy-rcar-gen2.c                                           |    1 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                                      |   27 
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c                              |    2 
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c                             |  160 -
 drivers/phy/starfive/phy-jh7110-dphy-rx.c                                     |    5 
 drivers/phy/starfive/phy-jh7110-dphy-tx.c                                     |    5 
 drivers/phy/sunplus/phy-sunplus-usb2.c                                        |    6 
 drivers/pinctrl/Kconfig                                                       |    4 
 drivers/pinctrl/airoha/pinctrl-airoha.c                                       |  362 ++
 drivers/pinctrl/bcm/Kconfig                                                   |    2 
 drivers/pinctrl/bcm/pinctrl-bcm2835.c                                         |    1 
 drivers/pinctrl/freescale/pinctrl-imx1-core.c                                 |    7 
 drivers/pinctrl/mediatek/mtk-eint.c                                           |   25 
 drivers/pinctrl/mediatek/pinctrl-moore.c                                      |    6 
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c                                 |   14 
 drivers/pinctrl/mediatek/pinctrl-paris.c                                      |    2 
 drivers/pinctrl/pinctrl-eic7700.c                                             |    3 
 drivers/pinctrl/pinctrl-generic.c                                             |   25 
 drivers/pinctrl/pinctrl-rockchip.c                                            |   50 
 drivers/pinctrl/qcom/pinctrl-shikra.c                                         |    1 
 drivers/pinctrl/spacemit/pinctrl-k1.c                                         |   10 
 drivers/pinctrl/tegra/pinctrl-tegra264.c                                      |   24 
 drivers/platform/arm64/qcom-hamoa-ec.c                                        |    4 
 drivers/platform/chrome/cros_ec_debugfs.c                                     |    6 
 drivers/platform/chrome/cros_ec_lightbar.c                                    |    7 
 drivers/platform/chrome/cros_ec_sensorhub_ring.c                              |    9 
 drivers/platform/chrome/cros_ec_typec.c                                       |    6 
 drivers/platform/mellanox/mlxbf-bootctl.c                                     |    1 
 drivers/platform/mellanox/mlxbf-pmc.c                                         |   10 
 drivers/platform/surface/surface_acpi_notify.c                                |    6 
 drivers/platform/x86/acer-wmi.c                                               |    4 
 drivers/platform/x86/amd/hsmp/hwmon.c                                         |    3 
 drivers/platform/x86/asus-wireless.c                                          |   11 
 drivers/platform/x86/asus-wmi.c                                               |    6 
 drivers/platform/x86/dell/dell-wmi-base.c                                     |   19 
 drivers/platform/x86/dell/dell-wmi-privacy.c                                  |    4 
 drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h                   |    2 
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c                     |    5 
 drivers/platform/x86/lg-laptop.c                                              |   21 
 drivers/pmdomain/bcm/bcm2835-power.c                                          |    7 
 drivers/power/reset/reboot-mode.c                                             |   30 
 drivers/power/supply/bd71828-power.c                                          |   20 
 drivers/power/supply/bd99954-charger.h                                        |   23 
 drivers/power/supply/bq27xxx_battery.c                                        |    6 
 drivers/power/supply/isp1704_charger.c                                        |    1 
 drivers/power/supply/sbs-battery.c                                            |    7 
 drivers/power/supply/sc2731_charger.c                                         |    2 
 drivers/powercap/intel_rapl_common.c                                          |   11 
 drivers/powercap/intel_rapl_tpmi.c                                            |    5 
 drivers/pps/clients/pps-gpio.c                                                |   72 
 drivers/pps/pps.c                                                             |   10 
 drivers/ptp/ptp_netc.c                                                        |   13 
 drivers/pwm/pwm-samsung.c                                                     |   22 
 drivers/rapidio/rio-scan.c                                                    |    1 
 drivers/regulator/adp5055-regulator.c                                         |    2 
 drivers/regulator/core.c                                                      |    6 
 drivers/regulator/qcom-rpmh-regulator.c                                       |    6 
 drivers/regulator/tps65185.c                                                  |   11 
 drivers/regulator/tps6594-regulator.c                                         |   19 
 drivers/remoteproc/qcom_common.c                                              |    4 
 drivers/remoteproc/qcom_common.h                                              |    6 
 drivers/remoteproc/qcom_q6v5.c                                                |    5 
 drivers/remoteproc/qcom_q6v5_adsp.c                                           |    1 
 drivers/remoteproc/qcom_q6v5_mss.c                                            |   19 
 drivers/remoteproc/qcom_q6v5_pas.c                                            |   68 
 drivers/remoteproc/qcom_sysmon.c                                              |   19 
 drivers/remoteproc/qcom_wcnss.c                                               |   23 
 drivers/remoteproc/remoteproc_core.c                                          |   67 
 drivers/remoteproc/remoteproc_sysfs.c                                         |    1 
 drivers/resctrl/mpam_devices.c                                                |   10 
 drivers/rpmsg/qcom_glink_native.c                                             |    3 
 drivers/rtc/rtc-gamecube.c                                                    |    4 
 drivers/rtc/rtc-pcf85363.c                                                    |   17 
 drivers/rtc/rtc-pcf8563.c                                                     |    4 
 drivers/rtc/rtc-spacemit-p1.c                                                 |    5 
 drivers/rtc/rtc-zynqmp.c                                                      |    7 
 drivers/scsi/mpt3sas/mpt3sas_base.c                                           |    2 
 drivers/scsi/qla2xxx/qla_attr.c                                               |    1 
 drivers/scsi/qla2xxx/qla_nx2.c                                                |    2 
 drivers/scsi/sd.c                                                             |   55 
 drivers/scsi/smartpqi/smartpqi_init.c                                         |   18 
 drivers/soc/fsl/qe/gpio.c                                                     |   25 
 drivers/soc/fsl/qe/qe_ic.c                                                    |    3 
 drivers/soc/fsl/qe/qe_io.c                                                    |   15 
 drivers/soc/qcom/pmic_glink_altmode.c                                         |    3 
 drivers/soc/qcom/rpmh-rsc.c                                                   |   37 
 drivers/soc/renesas/Kconfig                                                   |    1 
 drivers/soc/samsung/exynos-pmu.c                                              |    4 
 drivers/soc/ti/knav_qmss.h                                                    |    1 
 drivers/soc/ti/knav_qmss_queue.c                                              |    7 
 drivers/soundwire/cadence_master.c                                            |   24 
 drivers/soundwire/qcom.c                                                      |    2 
 drivers/spi/spi-amlogic-spisg.c                                               |    2 
 drivers/spi/spi-davinci.c                                                     |    7 
 drivers/spi/spi-geni-qcom.c                                                   |   17 
 drivers/spi/spi-img-spfi.c                                                    |    5 
 drivers/spi/spi-oc-tiny.c                                                     |   24 
 drivers/spi/spi-sprd-adi.c                                                    |    6 
 drivers/staging/fbtft/fbtft-sysfs.c                                           |    2 
 drivers/staging/greybus/audio_gb.c                                            |   13 
 drivers/staging/greybus/audio_manager_sysfs.c                                 |    2 
 drivers/staging/media/ipu7/ipu7-isys.c                                        |    1 
 drivers/staging/media/ipu7/ipu7.c                                             |    4 
 drivers/staging/octeon/ethernet-rx.c                                          |    2 
 drivers/staging/octeon/ethernet-tx.c                                          |    2 
 drivers/staging/rtl8723bs/core/rtw_cmd.c                                      |    8 
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                                 |   22 
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c                                  |    4 
 drivers/staging/sm750fb/Kconfig                                               |    1 
 drivers/staging/sm750fb/sm750.c                                               |    6 
 drivers/staging/sm750fb/sm750.h                                               |    2 
 drivers/staging/sm750fb/sm750_accel.c                                         |    6 
 drivers/staging/sm750fb/sm750_accel.h                                         |    4 
 drivers/thermal/airoha_thermal.c                                              |    4 
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c                       |    4 
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c                                      |    3 
 drivers/thermal/renesas/rcar_thermal.c                                        |   15 
 drivers/thermal/spacemit/k1_tsensor.c                                         |    5 
 drivers/thermal/thermal_hwmon.c                                               |   87 
 drivers/thunderbolt/stream.c                                                  |   12 
 drivers/tty/hvc/Kconfig                                                       |    2 
 drivers/tty/serial/amba-pl011.c                                               |   48 
 drivers/tty/serial/ma35d1_serial.c                                            |   12 
 drivers/tty/serial/qcom_geni_serial.c                                         |   10 
 drivers/tty/serial/serial_core.c                                              |   32 
 drivers/tty/tty_io.c                                                          |    6 
 drivers/ufs/core/ufs-debugfs.c                                                |    2 
 drivers/ufs/core/ufs-rpmb.c                                                   |    4 
 drivers/ufs/core/ufs-txeq.c                                                   |   27 
 drivers/ufs/core/ufshcd.c                                                     |   33 
 drivers/uio/uio.c                                                             |    5 
 drivers/usb/atm/usbatm.c                                                      |    4 
 drivers/usb/chipidea/ci_hdrc_imx.c                                            |    2 
 drivers/usb/core/driver.c                                                     |   12 
 drivers/usb/gadget/configfs.c                                                 |    4 
 drivers/usb/gadget/function/f_fs.c                                            |    8 
 drivers/usb/gadget/function/f_uac1.c                                          |   13 
 drivers/usb/gadget/function/f_uac1_legacy.c                                   |   56 
 drivers/usb/gadget/function/f_uac2.c                                          |   13 
 drivers/usb/gadget/function/u_uac1_legacy.h                                   |    3 
 drivers/usb/gadget/udc/aspeed_udc.c                                           |   50 
 drivers/usb/gadget/udc/r8a66597-udc.c                                         |    1 
 drivers/usb/misc/usb-ljca.c                                                   |    3 
 drivers/usb/mtu3/mtu3_core.c                                                  |   11 
 drivers/usb/renesas_usbhs/common.c                                            |    6 
 drivers/usb/typec/ucsi/debugfs.c                                              |    1 
 drivers/usb/typec/ucsi/ucsi.c                                                 |    2 
 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c                                   |   15 
 drivers/vdpa/mlx5/core/mr.c                                                   |    2 
 drivers/vdpa/vdpa_sim/vdpa_sim.c                                              |   25 
 drivers/vfio/pci/vfio_pci_config.c                                            |    1 
 drivers/vfio/pci/vfio_pci_core.c                                              |    3 
 drivers/vhost/net.c                                                           |    3 
 drivers/video/backlight/Kconfig                                               |    2 
 drivers/video/backlight/aw99706.c                                             |   15 
 drivers/video/fbdev/clps711x-fb.c                                             |    2 
 drivers/video/fbdev/kyro/fbdev.c                                              |   24 
 drivers/video/fbdev/tdfxfb.c                                                  |    2 
 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c                               |   97 
 drivers/virtio/virtio.c                                                       |   41 
 drivers/virtio/virtio_balloon.c                                               |   40 
 drivers/virtio/virtio_pci_common.c                                            |    2 
 drivers/virtio/virtio_rtc_driver.c                                            |   14 
 drivers/w1/masters/ds2482.c                                                   |    4 
 drivers/xen/xenbus/xenbus_probe.c                                             |    3 
 drivers/xen/xenbus/xenbus_xs.c                                                |   16 
 fs/btrfs/acl.c                                                                |    4 
 fs/btrfs/block-group.c                                                        |    8 
 fs/btrfs/defrag.c                                                             |   50 
 fs/btrfs/disk-io.c                                                            |   29 
 fs/btrfs/extent_io.c                                                          |  274 +-
 fs/btrfs/fiemap.c                                                             |    4 
 fs/btrfs/file.c                                                               |  102 
 fs/btrfs/qgroup.c                                                             |   18 
 fs/btrfs/relocation.c                                                         |   49 
 fs/btrfs/transaction.c                                                        |    8 
 fs/btrfs/transaction.h                                                        |   25 
 fs/btrfs/verity.c                                                             |   16 
 fs/ceph/dir.c                                                                 |    2 
 fs/ceph/file.c                                                                |   48 
 fs/dax.c                                                                      |   12 
 fs/dcache.c                                                                   |    7 
 fs/erofs/Kconfig                                                              |    8 
 fs/erofs/decompressor.c                                                       |    1 
 fs/erofs/internal.h                                                           |    2 
 fs/erofs/zdata.c                                                              |   12 
 fs/erofs/zmap.c                                                               |   38 
 fs/exfat/exfat_fs.h                                                           |    2 
 fs/exfat/file.c                                                               |  180 +
 fs/exfat/iomap.c                                                              |   11 
 fs/ext4/dir.c                                                                 |   20 
 fs/ext4/ext4.h                                                                |    6 
 fs/ext4/extents.c                                                             |    2 
 fs/ext4/file.c                                                                |    7 
 fs/ext4/inline.c                                                              |   25 
 fs/ext4/inode.c                                                               |  131 -
 fs/ext4/migrate.c                                                             |    3 
 fs/ext4/namei.c                                                               |    2 
 fs/ext4/orphan.c                                                              |   10 
 fs/ext4/xattr.c                                                               |    2 
 fs/f2fs/f2fs.h                                                                |   22 
 fs/f2fs/file.c                                                                |   17 
 fs/f2fs/gc.c                                                                  |    2 
 fs/f2fs/segment.c                                                             |    8 
 fs/f2fs/super.c                                                               |    4 
 fs/fat/nfs.c                                                                  |    4 
 fs/fuse/cuse.c                                                                |    8 
 fs/fuse/dev.c                                                                 |   14 
 fs/fuse/dev_uring.c                                                           |   29 
 fs/fuse/dir.c                                                                 |   23 
 fs/fuse/file.c                                                                |    5 
 fs/fuse/fuse_i.h                                                              |    2 
 fs/fuse/inode.c                                                               |    9 
 fs/fuse/readdir.c                                                             |    2 
 fs/hfsplus/catalog.c                                                          |   25 
 fs/hfsplus/hfsplus_fs.h                                                       |    6 
 fs/hugetlbfs/inode.c                                                          |    3 
 fs/inode.c                                                                    |   18 
 fs/iomap/bio.c                                                                |    1 
 fs/iomap/iter.c                                                               |  128 -
 fs/isofs/compress.c                                                           |    7 
 fs/lockd/nlm3xdr_gen.c                                                        |    2 
 fs/lockd/nlm3xdr_gen.h                                                        |    2 
 fs/lockd/nlm4xdr_gen.c                                                        |   47 
 fs/lockd/nlm4xdr_gen.h                                                        |    2 
 fs/nfs/blocklayout/dev.c                                                      |   21 
 fs/nfs/callback_xdr.c                                                         |    2 
 fs/nfs/client.c                                                               |   14 
 fs/nfs/delegation.c                                                           |   20 
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
 fs/nfsd/nfs4state.c                                                           |    8 
 fs/nfsd/nfs4xdr_gen.c                                                         |  589 ++++
 fs/nfsd/nfs4xdr_gen.h                                                         |    5 
 fs/nfsd/nfsd.h                                                                |    9 
 fs/nfsd/trace.h                                                               |    1 
 fs/nilfs2/page.c                                                              |   17 
 fs/nilfs2/segment.c                                                           |    4 
 fs/nilfs2/the_nilfs.c                                                         |    6 
 fs/notify/fanotify/fanotify.c                                                 |    1 
 fs/notify/fanotify/fanotify_user.c                                            |   12 
 fs/ntfs/attrib.c                                                              |    7 
 fs/ntfs/compress.c                                                            |   94 
 fs/ntfs/ea.c                                                                  |  120 
 fs/ntfs/ea.h                                                                  |    3 
 fs/ntfs/file.c                                                                |   10 
 fs/ntfs/index.c                                                               |   96 
 fs/ntfs/inode.c                                                               |   79 
 fs/ntfs/inode.h                                                               |    1 
 fs/ntfs/iomap.c                                                               |   62 
 fs/ntfs/mft.c                                                                 |   12 
 fs/ntfs/namei.c                                                               |   10 
 fs/ntfs3/fslog.c                                                              |   13 
 fs/ntfs3/fsntfs.c                                                             |    8 
 fs/ntfs3/record.c                                                             |   34 
 fs/ntfs3/super.c                                                              |   13 
 fs/ntfs3/xattr.c                                                              |   21 
 fs/ocfs2/acl.c                                                                |  135 -
 fs/ocfs2/acl.h                                                                |   19 
 fs/ocfs2/cluster/heartbeat.c                                                  |  142 -
 fs/ocfs2/cluster/heartbeat.h                                                  |    5 
 fs/ocfs2/cluster/nodemanager.c                                                |   23 
 fs/ocfs2/cluster/nodemanager.h                                                |    2 
 fs/ocfs2/cluster/tcp.c                                                        |  186 +
 fs/ocfs2/cluster/tcp.h                                                        |    2 
 fs/ocfs2/inode.c                                                              |   22 
 fs/ocfs2/namei.c                                                              |   17 
 fs/ocfs2/xattr.c                                                              |  301 ++
 fs/ocfs2/xattr.h                                                              |   11 
 fs/resctrl/monitor.c                                                          |   60 
 fs/resctrl/rdtgroup.c                                                         |   71 
 fs/smb/client/cifs_debug.c                                                    |    2 
 fs/smb/client/dir.c                                                           |    2 
 fs/smb/client/inode.c                                                         |   14 
 fs/smb/client/smb2inode.c                                                     |    9 
 fs/smb/client/smb2pdu.c                                                       |   18 
 fs/smb/common/smb2pdu.h                                                       |    4 
 fs/smb/common/smbglob.h                                                       |    1 
 fs/smb/server/Kconfig                                                         |    1 
 fs/smb/server/auth.c                                                          |   20 
 fs/smb/server/compress.c                                                      |   76 
 fs/smb/server/compress.h                                                      |    1 
 fs/smb/server/connection.c                                                    |   59 
 fs/smb/server/connection.h                                                    |    8 
 fs/smb/server/ksmbd_netlink.h                                                 |    6 
 fs/smb/server/ksmbd_work.c                                                    |    5 
 fs/smb/server/ksmbd_work.h                                                    |   14 
 fs/smb/server/mgmt/share_config.c                                             |  104 
 fs/smb/server/mgmt/share_config.h                                             |   25 
 fs/smb/server/mgmt/tree_connect.c                                             |   10 
 fs/smb/server/mgmt/user_config.c                                              |   12 
 fs/smb/server/mgmt/user_session.c                                             |   84 
 fs/smb/server/mgmt/user_session.h                                             |    4 
 fs/smb/server/misc.h                                                          |    4 
 fs/smb/server/oplock.c                                                        |  202 +
 fs/smb/server/oplock.h                                                        |    4 
 fs/smb/server/proc.c                                                          |   13 
 fs/smb/server/server.c                                                        |   61 
 fs/smb/server/server.h                                                        |    2 
 fs/smb/server/smb2ops.c                                                       |   15 
 fs/smb/server/smb2pdu.c                                                       | 1265 ++++++++--
 fs/smb/server/smb2pdu.h                                                       |   60 
 fs/smb/server/smbacl.c                                                        |   98 
 fs/smb/server/smbacl.h                                                        |    3 
 fs/smb/server/transport_ipc.c                                                 |   42 
 fs/smb/server/transport_tcp.c                                                 |    6 
 fs/smb/server/vfs.c                                                           |    3 
 fs/smb/server/vfs_cache.c                                                     |   80 
 fs/smb/server/vfs_cache.h                                                     |   24 
 fs/smb/smbdirect/accept.c                                                     |   16 
 fs/smb/smbdirect/connection.c                                                 |   13 
 fs/smb/smbdirect/socket.c                                                     |   98 
 fs/squashfs/cache.c                                                           |    2 
 fs/stat.c                                                                     |    2 
 fs/super.c                                                                    |    4 
 fs/udf/inode.c                                                                |  129 -
 fs/udf/super.c                                                                |   23 
 fs/udf/symlink.c                                                              |    2 
 include/acpi/acpi_bus.h                                                       |    6 
 include/asm-generic/vmlinux.lds.h                                             |   10 
 include/clocksource/samsung_pwm.h                                             |    2 
 include/cxl/mailbox.h                                                         |    2 
 include/drm/bridge/dw_dp.h                                                    |    1 
 include/linux/bio-integrity.h                                                 |    3 
 include/linux/bpf.h                                                           |   36 
 include/linux/cpuset.h                                                        |    1 
 include/linux/efi.h                                                           |    4 
 include/linux/filter.h                                                        |   55 
 include/linux/fs.h                                                            |   20 
 include/linux/fsl/ntmp.h                                                      |    2 
 include/linux/i3c/master.h                                                    |    3 
 include/linux/iomap.h                                                         |  111 
 include/linux/irqchip/arm-gic-v5.h                                            |    2 
 include/linux/libnvdimm.h                                                     |    9 
 include/linux/liveupdate.h                                                    |   11 
 include/linux/maple_tree.h                                                    |    2 
 include/linux/memcontrol.h                                                    |    9 
 include/linux/memory_hotplug.h                                                |    2 
 include/linux/mlx5/vport.h                                                    |    3 
 include/linux/nfs4.h                                                          |  127 -
 include/linux/nfs_xdr.h                                                       |    2 
 include/linux/pci.h                                                           |    1 
 include/linux/remoteproc.h                                                    |   15 
 include/linux/rsc_table.h                                                     |   17 
 include/linux/rtsx_usb.h                                                      |    3 
 include/linux/soc/qcom/ubwc.h                                                 |    1 
 include/linux/sunrpc/xdrgen/_defs.h                                           |    2 
 include/linux/sunrpc/xdrgen/nfs4_1.h                                          |  279 ++
 include/linux/sunrpc/xdrgen/nlm3.h                                            |    2 
 include/linux/sunrpc/xdrgen/nlm4.h                                            |    2 
 include/linux/uprobes.h                                                       |    5 
 include/linux/usb.h                                                           |    3 
 include/linux/usb/pd.h                                                        |    2 
 include/linux/virtio.h                                                        |    1 
 include/linux/virtio_net.h                                                    |    4 
 include/media/rc-map.h                                                        |    2 
 include/net/bluetooth/hci_core.h                                              |    2 
 include/net/bluetooth/l2cap.h                                                 |    5 
 include/net/inetpeer.h                                                        |    4 
 include/net/libeth/xsk.h                                                      |    2 
 include/net/netfilter/nf_conntrack_helper.h                                   |    1 
 include/net/netfilter/nf_tables.h                                             |    2 
 include/net/pkt_sched.h                                                       |    1 
 include/net/xdp_sock_drv.h                                                    |   22 
 include/net/xsk_buff_pool.h                                                   |    3 
 include/rdma/uverbs_ioctl.h                                                   |   20 
 include/sound/sdca_fdl.h                                                      |    4 
 include/uapi/drm/panthor_drm.h                                                |   12 
 include/uapi/drm/xe_drm.h                                                     |   11 
 include/uapi/linux/if_xdp.h                                                   |    1 
 include/uapi/linux/nfs4.h                                                     |    2 
 include/uapi/linux/time_types.h                                               |    2 
 kernel/Kconfig.preempt                                                        |    1 
 kernel/bpf/arena.c                                                            |   10 
 kernel/bpf/bpf_lsm.c                                                          |    1 
 kernel/bpf/bpf_struct_ops.c                                                   |   12 
 kernel/bpf/btf.c                                                              |   47 
 kernel/bpf/cgroup.c                                                           |   27 
 kernel/bpf/const_fold.c                                                       |   11 
 kernel/bpf/core.c                                                             |    7 
 kernel/bpf/cpumask.c                                                          |    6 
 kernel/bpf/fixups.c                                                           |   25 
 kernel/bpf/helpers.c                                                          |   17 
 kernel/bpf/liveness.c                                                         |    9 
 kernel/bpf/mmap_unlock_work.h                                                 |   51 
 kernel/bpf/net_namespace.c                                                    |   17 
 kernel/bpf/queue_stack_maps.c                                                 |    8 
 kernel/bpf/ringbuf.c                                                          |    2 
 kernel/bpf/stackmap.c                                                         |  148 -
 kernel/bpf/states.c                                                           |    3 
 kernel/bpf/syscall.c                                                          |   23 
 kernel/bpf/task_iter.c                                                        |   48 
 kernel/bpf/trampoline.c                                                       |   20 
 kernel/bpf/verifier.c                                                         |  160 -
 kernel/cgroup/cpuset-internal.h                                               |    2 
 kernel/cgroup/cpuset.c                                                        |   79 
 kernel/crash_dump_dm_crypt.c                                                  |   15 
 kernel/dma/swiotlb.c                                                          |   31 
 kernel/events/uprobes.c                                                       |   10 
 kernel/fork.c                                                                 |    1 
 kernel/kcsan/core.c                                                           |   12 
 kernel/liveupdate/luo_flb.c                                                   |   20 
 kernel/liveupdate/luo_session.c                                               |    6 
 kernel/locking/lockdep.c                                                      |    2 
 kernel/module/dups.c                                                          |   99 
 kernel/module/stats.c                                                         |    2 
 kernel/power/snapshot.c                                                       |    5 
 kernel/power/wakelock.c                                                       |    2 
 kernel/printk/printk.c                                                        |   11 
 kernel/rcu/tree_plugin.h                                                      |   10 
 kernel/sched/cpufreq_schedutil.c                                              |    2 
 kernel/sched/deadline.c                                                       |    6 
 kernel/sched/ext/ext.c                                                        |   59 
 kernel/sched/ext/internal.h                                                   |    2 
 kernel/sched/fair.c                                                           |   34 
 kernel/sched/isolation.c                                                      |   16 
 kernel/sched/rt.c                                                             |    3 
 kernel/sys.c                                                                  |    2 
 kernel/time/clocksource.c                                                     |    8 
 kernel/time/hrtimer.c                                                         |    4 
 kernel/time/namespace.c                                                       |    6 
 kernel/time/timekeeping.c                                                     |   27 
 kernel/time/timer_migration.c                                                 |    4 
 kernel/trace/ring_buffer.c                                                    |    2 
 kernel/trace/trace.c                                                          |    2 
 kernel/trace/trace.h                                                          |    4 
 kernel/trace/trace_btf.c                                                      |   19 
 kernel/trace/trace_btf.h                                                      |    3 
 kernel/trace/trace_events.c                                                   |    6 
 kernel/trace/trace_probe.c                                                    |   18 
 kernel/workqueue.c                                                            |   38 
 lib/interval_tree_test.c                                                      |    4 
 lib/maple_tree.c                                                              |   43 
 lib/string.c                                                                  |    3 
 lib/test_bitmap.c                                                             |    1 
 lib/test_hmm.c                                                                |    2 
 mm/damon/core.c                                                               |   21 
 mm/damon/tests/core-kunit.h                                                   |    2 
 mm/memory_hotplug.c                                                           |    3 
 mm/mm_init.c                                                                  |   19 
 mm/mremap.c                                                                   |   21 
 mm/swap.c                                                                     |    9 
 mm/vmscan.c                                                                   |    5 
 net/batman-adv/bridge_loop_avoidance.c                                        |   63 
 net/batman-adv/distributed-arp-table.c                                        |   58 
 net/batman-adv/types.h                                                        |    2 
 net/bluetooth/hci_conn.c                                                      |   20 
 net/bluetooth/hci_sync.c                                                      |   26 
 net/bluetooth/l2cap_core.c                                                    |   23 
 net/bluetooth/l2cap_sock.c                                                    |  100 
 net/bluetooth/mgmt.c                                                          |   40 
 net/bluetooth/msft.c                                                          |    5 
 net/bluetooth/rfcomm/core.c                                                   |    4 
 net/bridge/br_arp_nd_proxy.c                                                  |   24 
 net/bridge/br_netlink_tunnel.c                                                |    3 
 net/bridge/br_vlan.c                                                          |    4 
 net/ceph/messenger_v2.c                                                       |    5 
 net/core/dev.c                                                                |   60 
 net/core/filter.c                                                             |    4 
 net/core/lwt_bpf.c                                                            |   15 
 net/core/net_namespace.c                                                      |   25 
 net/core/page_pool.c                                                          |   73 
 net/core/skbuff.c                                                             |    6 
 net/hsr/hsr_device.c                                                          |    2 
 net/ife/ife.c                                                                 |   14 
 net/ipv4/inetpeer.c                                                           |   38 
 net/ipv4/tcp.c                                                                |    6 
 net/ipv4/tcp_output.c                                                         |    2 
 net/ipv6/ip6mr.c                                                              |    3 
 net/ipv6/route.c                                                              |    2 
 net/ipv6/xfrm6_input.c                                                        |    2 
 net/kcm/kcmsock.c                                                             |    3 
 net/mac80211/link.c                                                           |    3 
 net/mac80211/mlme.c                                                           |    2 
 net/mac80211/s1g.c                                                            |    2 
 net/mac80211/spectmgmt.c                                                      |   11 
 net/mac80211/tx.c                                                             |    3 
 net/netfilter/ipset/ip_set_hash_gen.h                                         |  168 -
 net/netfilter/ipset/ip_set_hash_netiface.c                                    |    1 
 net/netfilter/ipset/ip_set_hash_netportnet.c                                  |    1 
 net/netfilter/ipvs/ip_vs_ftp.c                                                |   10 
 net/netfilter/nf_conntrack_helper.c                                           |   14 
 net/netfilter/nf_conntrack_netlink.c                                          |    2 
 net/netfilter/nf_nat_sip.c                                                    |    5 
 net/netfilter/nf_tables_api.c                                                 |   70 
 net/netfilter/nft_ct.c                                                        |  168 +
 net/netfilter/nft_dynset.c                                                    |   25 
 net/netfilter/xt_cgroup.c                                                     |   12 
 net/netfilter/xt_hl.c                                                         |    4 
 net/nfc/digital_core.c                                                        |    2 
 net/nfc/llcp_core.c                                                           |   29 
 net/nfc/llcp_sock.c                                                           |   14 
 net/nfc/nci/data.c                                                            |   10 
 net/nfc/nci/rsp.c                                                             |   41 
 net/phonet/pep.c                                                              |    2 
 net/rds/cong.c                                                                |    4 
 net/sched/act_api.c                                                           |    5 
 net/sched/act_bpf.c                                                           |   26 
 net/sched/act_ct.c                                                            |   46 
 net/sched/act_ctinfo.c                                                        |   11 
 net/sched/act_ife.c                                                           |   55 
 net/sched/act_pedit.c                                                         |   24 
 net/sched/act_police.c                                                        |   12 
 net/sched/act_sample.c                                                        |    9 
 net/sched/act_skbmod.c                                                        |   12 
 net/sched/act_tunnel_key.c                                                    |   80 
 net/sched/cls_api.c                                                           |   21 
 net/sched/cls_basic.c                                                         |    6 
 net/sched/cls_bpf.c                                                           |    6 
 net/sched/cls_cgroup.c                                                        |    2 
 net/sched/cls_flow.c                                                          |    2 
 net/sched/cls_flower.c                                                        |    4 
 net/sched/cls_fw.c                                                            |    4 
 net/sched/cls_matchall.c                                                      |    4 
 net/sched/cls_route.c                                                         |    4 
 net/sched/cls_u32.c                                                           |   11 
 net/sched/sch_api.c                                                           |    7 
 net/sched/sch_cake.c                                                          |    1 
 net/sched/sch_codel.c                                                         |    2 
 net/sched/sch_fifo.c                                                          |    2 
 net/sched/sch_fq.c                                                            |   26 
 net/sched/sch_fq_codel.c                                                      |    6 
 net/sched/sch_fq_pie.c                                                        |    3 
 net/sched/sch_gred.c                                                          |    4 
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
 net/vmw_vsock/af_vsock.c                                                      |   16 
 net/wireless/core.c                                                           |    3 
 net/wireless/nl80211.c                                                        |   10 
 net/xdp/xsk.c                                                                 |   30 
 net/xdp/xsk_buff_pool.c                                                       |    7 
 net/xfrm/xfrm_output.c                                                        |    4 
 rust/helpers/helpers.c                                                        |    2 
 rust/kernel/cpufreq.rs                                                        |   24 
 rust/kernel/device.rs                                                         |   10 
 rust/kernel/drm/gpuvm/mod.rs                                                  |   32 
 rust/uapi/uapi_helper.h                                                       |    2 
 samples/ftrace/ftrace-direct-modify.c                                         |   12 
 samples/ftrace/ftrace-direct-multi-modify.c                                   |   12 
 samples/rust/rust_debugfs.rs                                                  |    4 
 samples/rust/rust_debugfs_scoped.rs                                           |    5 
 scripts/Makefile.vmlinux_o                                                    |    3 
 scripts/livepatch/klp-build                                                   |    9 
 scripts/mod/modpost.c                                                         |    7 
 scripts/tags.sh                                                               |    2 
 security/apparmor/domain.c                                                    |  106 
 security/apparmor/include/policy.h                                            |    3 
 security/apparmor/lib.c                                                       |    4 
 security/apparmor/policy.c                                                    |   22 
 security/apparmor/policy_unpack.c                                             |    2 
 security/smack/smack.h                                                        |    5 
 security/smack/smack_lsm.c                                                    |   67 
 security/smack/smackfs.c                                                      |  218 -
 sound/core/control_led.c                                                      |    2 
 sound/core/init.c                                                             |    4 
 sound/core/seq/seq_clientmgr.c                                                |   16 
 sound/core/seq/seq_midi.c                                                     |   61 
 sound/drivers/mtpav.c                                                         |    4 
 sound/hda/codecs/realtek/alc269.c                                             |   13 
 sound/hda/common/proc.c                                                       |    2 
 sound/hda/controllers/Kconfig                                                 |    1 
 sound/pci/asihpi/hpi6000.c                                                    |    5 
 sound/pci/ice1712/ice1712.c                                                   |    7 
 sound/pci/via82xx_modem.c                                                     |   26 
 sound/soc/amd/acp-config.c                                                    |    2 
 sound/soc/apple/mca.c                                                         |    6 
 sound/soc/codecs/rt700-sdw.c                                                  |    6 
 sound/soc/codecs/tas2783-sdw.c                                                |   26 
 sound/soc/codecs/tas675x.c                                                    |   18 
 sound/soc/fsl/Kconfig                                                         |    4 
 sound/soc/fsl/efika-audio-fabric.c                                            |    2 
 sound/soc/fsl/fsl-asoc-card.c                                                 |    4 
 sound/soc/fsl/fsl_audmix.c                                                    |   24 
 sound/soc/fsl/pcm030-audio-fabric.c                                           |    2 
 sound/soc/meson/meson-card-utils.c                                            |   17 
 sound/soc/pxa/pxa-ssp.c                                                       |    7 
 sound/soc/qcom/qdsp6/q6apm.c                                                  |   12 
 sound/soc/samsung/i2s.c                                                       |   25 
 sound/soc/soc-dapm.c                                                          |    2 
 sound/soc/sof/ipc4-topology.c                                                 |    2 
 sound/soc/sof/topology.c                                                      |   18 
 sound/soc/spacemit/k1_i2s.c                                                   |   36 
 sound/soc/ti/j721e-evm.c                                                      |    4 
 sound/soc/xilinx/xlnx_formatter_pcm.c                                         |   14 
 tools/bpf/bpftool/Makefile                                                    |    2 
 tools/bpf/bpftool/map.c                                                       |   16 
 tools/bpf/bpftool/sign.c                                                      |    7 
 tools/bpf/bpftool/struct_ops.c                                                |    4 
 tools/build/Makefile.feature                                                  |    2 
 tools/build/feature/Makefile                                                  |   14 
 tools/include/linux/filter.h                                                  |    1 
 tools/include/nolibc/arch-powerpc.h                                           |    2 
 tools/include/nolibc/arch-sparc.h                                             |    2 
 tools/include/uapi/linux/if_xdp.h                                             |    1 
 tools/lib/api/fd/array.c                                                      |   12 
 tools/lib/bpf/features.c                                                      |    4 
 tools/lib/bpf/libbpf.c                                                        |    3 
 tools/lib/bpf/usdt.c                                                          |   16 
 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2                  |    1 
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/string.j2                 |    2 
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_opaque.j2 |    2 
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/string.j2                  |    2 
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_opaque.j2  |    2 
 tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2                 |    6 
 tools/objtool/Build                                                           |    4 
 tools/objtool/arch/x86/special.c                                              |   27 
 tools/objtool/builtin-check.c                                                 |    7 
 tools/objtool/check.c                                                         |    7 
 tools/objtool/elf.c                                                           |   13 
 tools/objtool/include/objtool/builtin.h                                       |    1 
 tools/objtool/include/objtool/elf.h                                           |    1 
 tools/objtool/include/objtool/klp.h                                           |   33 
 tools/objtool/include/objtool/special.h                                       |    7 
 tools/objtool/klp-diff.c                                                      |  233 +
 tools/objtool/klp-post-link.c                                                 |   53 
 tools/objtool/klp-symid.c                                                     |  119 
 tools/objtool/klp-sympos.c                                                    |  411 +++
 tools/perf/arch/arm/util/cs-etm.c                                             |   10 
 tools/perf/arch/arm64/util/arm-spe.c                                          |    8 
 tools/perf/arch/arm64/util/hisi-ptt.c                                         |    2 
 tools/perf/arch/x86/tests/amd-ibs-period.c                                    |   20 
 tools/perf/arch/x86/tests/hybrid.c                                            |   22 
 tools/perf/arch/x86/tests/topdown.c                                           |    4 
 tools/perf/arch/x86/util/auxtrace.c                                           |    2 
 tools/perf/arch/x86/util/intel-bts.c                                          |    6 
 tools/perf/arch/x86/util/intel-pt.c                                           |    9 
 tools/perf/arch/x86/util/iostat.c                                             |   14 
 tools/perf/bench/evlist-open-close.c                                          |   29 
 tools/perf/builtin-annotate.c                                                 |    7 
 tools/perf/builtin-c2c.c                                                      |  106 
 tools/perf/builtin-ftrace.c                                                   |   27 
 tools/perf/builtin-inject.c                                                   |    4 
 tools/perf/builtin-kvm.c                                                      |   14 
 tools/perf/builtin-kwork.c                                                    |    8 
 tools/perf/builtin-lock.c                                                     |    4 
 tools/perf/builtin-record.c                                                   |  148 -
 tools/perf/builtin-report.c                                                   |    6 
 tools/perf/builtin-sched.c                                                    |  130 -
 tools/perf/builtin-script.c                                                   |   16 
 tools/perf/builtin-stat.c                                                     |  112 
 tools/perf/builtin-top.c                                                      |  106 
 tools/perf/builtin-trace.c                                                    |  131 -
 tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json                     |   28 
 tools/perf/pmu-events/arch/arm64/nvidia/t410/misc.json                        |    6 
 tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json                    |  160 +
 tools/perf/pmu-events/arch/x86/amdzen5/load-store.json                        |    8 
 tools/perf/pmu-events/arch/x86/amdzen6/floating-point.json                    |   34 
 tools/perf/pmu-events/jevents.py                                              |    5 
 tools/perf/pmu-events/metric.py                                               |    6 
 tools/perf/scripts/python/arm-cs-trace-disasm.py                              |    9 
 tools/perf/tests/backward-ring-buffer.c                                       |   26 
 tools/perf/tests/builtin-test.c                                               |  172 -
 tools/perf/tests/code-reading.c                                               |   14 
 tools/perf/tests/event-times.c                                                |    6 
 tools/perf/tests/event_update.c                                               |    4 
 tools/perf/tests/evsel-roundtrip-name.c                                       |    8 
 tools/perf/tests/evsel-tp-sched.c                                             |    4 
 tools/perf/tests/expand-cgroup.c                                              |   15 
 tools/perf/tests/hists_cumulate.c                                             |    2 
 tools/perf/tests/hists_filter.c                                               |    2 
 tools/perf/tests/hists_link.c                                                 |    2 
 tools/perf/tests/hists_output.c                                               |    2 
 tools/perf/tests/hwmon_pmu.c                                                  |    7 
 tools/perf/tests/keep-tracking.c                                              |   10 
 tools/perf/tests/mmap-basic.c                                                 |   24 
 tools/perf/tests/openat-syscall-all-cpus.c                                    |    6 
 tools/perf/tests/openat-syscall-tp-fields.c                                   |   26 
 tools/perf/tests/openat-syscall.c                                             |    6 
 tools/perf/tests/parse-events.c                                               |  150 -
 tools/perf/tests/parse-metric.c                                               |   11 
 tools/perf/tests/parse-no-sample-id-all.c                                     |    2 
 tools/perf/tests/perf-record.c                                                |   38 
 tools/perf/tests/perf-time-to-tsc.c                                           |   12 
 tools/perf/tests/pfm.c                                                        |   12 
 tools/perf/tests/pmu-events.c                                                 |   21 
 tools/perf/tests/pmu.c                                                        |    4 
 tools/perf/tests/sample-parsing.c                                             |   45 
 tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh                 |    4 
 tools/perf/tests/shell/inject_aslr.sh                                         |   10 
 tools/perf/tests/shell/jitdump-python.sh                                      |   79 
 tools/perf/tests/shell/kvm.sh                                                 |   61 
 tools/perf/tests/shell/lib/perf_metric_validation.py                          |   11 
 tools/perf/tests/shell/lib/perf_record.sh                                     |   58 
 tools/perf/tests/shell/pipe_test.sh                                           |    4 
 tools/perf/tests/shell/record+zstd_comp_decomp_multi_record.sh                |   63 
 tools/perf/tests/shell/record.sh                                              |  173 -
 tools/perf/tests/shell/record_lbr.sh                                          |   50 
 tools/perf/tests/shell/stat_all_metrics.sh                                    |   75 
 tools/perf/tests/shell/stat_bpf_counters.sh                                   |   28 
 tools/perf/tests/shell/stat_metrics_values.sh                                 |    7 
 tools/perf/tests/shell/test_brstack.sh                                        |  107 
 tools/perf/tests/shell/test_dwarf_unwind_multithreaded.sh                     |   65 
 tools/perf/tests/shell/trace_record_replay.sh                                 |   38 
 tools/perf/tests/sw-clock.c                                                   |   20 
 tools/perf/tests/switch-tracking.c                                            |   11 
 tools/perf/tests/task-exit.c                                                  |   20 
 tools/perf/tests/time-utils-test.c                                            |   14 
 tools/perf/tests/tool_pmu.c                                                   |    7 
 tools/perf/tests/topology.c                                                   |    4 
 tools/perf/tests/uncore-event-sorting.c                                       |    6 
 tools/perf/ui/browsers/annotate.c                                             |    4 
 tools/perf/ui/browsers/hists.c                                                |  177 -
 tools/perf/util/amd-sample-raw.c                                              |    2 
 tools/perf/util/annotate-data.c                                               |    2 
 tools/perf/util/annotate.c                                                    |   61 
 tools/perf/util/annotate.h                                                    |    3 
 tools/perf/util/arm-spe.c                                                     |    4 
 tools/perf/util/auxtrace.c                                                    |   29 
 tools/perf/util/block-info.c                                                  |    4 
 tools/perf/util/bpf-event.c                                                   |    3 
 tools/perf/util/bpf-filter.c                                                  |   22 
 tools/perf/util/bpf_counter.c                                                 |    2 
 tools/perf/util/bpf_counter_cgroup.c                                          |   14 
 tools/perf/util/bpf_ftrace.c                                                  |    9 
 tools/perf/util/bpf_lock_contention.c                                         |   12 
 tools/perf/util/bpf_off_cpu.c                                                 |   44 
 tools/perf/util/bpf_trace_augment.c                                           |    8 
 tools/perf/util/cap.c                                                         |    4 
 tools/perf/util/cap.h                                                         |    3 
 tools/perf/util/capstone.c                                                    |   62 
 tools/perf/util/cgroup.c                                                      |   26 
 tools/perf/util/compress.h                                                    |    6 
 tools/perf/util/cs-etm.c                                                      |  105 
 tools/perf/util/data-convert-bt.c                                             |    2 
 tools/perf/util/data-convert-json.c                                           |    1 
 tools/perf/util/dso.c                                                         |   48 
 tools/perf/util/dso.h                                                         |   57 
 tools/perf/util/evlist.c                                                      |  496 ++-
 tools/perf/util/evlist.h                                                      |  258 +-
 tools/perf/util/evsel.c                                                       |  135 -
 tools/perf/util/evsel.h                                                       |   21 
 tools/perf/util/expr.c                                                        |    2 
 tools/perf/util/header.c                                                      |   74 
 tools/perf/util/header.h                                                      |    2 
 tools/perf/util/intel-bts.c                                                   |    2 
 tools/perf/util/intel-pt.c                                                    |    2 
 tools/perf/util/intel-tpebs.c                                                 |    7 
 tools/perf/util/iostat.c                                                      |    2 
 tools/perf/util/iostat.h                                                      |    2 
 tools/perf/util/kvm-stat.h                                                    |    2 
 tools/perf/util/libbfd.c                                                      |   23 
 tools/perf/util/libdw.c                                                       |   34 
 tools/perf/util/machine.c                                                     |   43 
 tools/perf/util/map.h                                                         |    9 
 tools/perf/util/metricgroup.c                                                 |   45 
 tools/perf/util/metricgroup.h                                                 |    4 
 tools/perf/util/parse-events.c                                                |   40 
 tools/perf/util/parse-events.h                                                |   17 
 tools/perf/util/parse-events.y                                                |    2 
 tools/perf/util/perf_api_probe.c                                              |   20 
 tools/perf/util/pfm.c                                                         |    4 
 tools/perf/util/pmu.c                                                         |    6 
 tools/perf/util/pmus.c                                                        |    2 
 tools/perf/util/print-events.c                                                |    2 
 tools/perf/util/python.c                                                      |  792 ++++--
 tools/perf/util/record.c                                                      |   11 
 tools/perf/util/s390-sample-raw.c                                             |   19 
 tools/perf/util/sample-raw.c                                                  |    4 
 tools/perf/util/session.c                                                     |   48 
 tools/perf/util/sideband_evlist.c                                             |   54 
 tools/perf/util/sort.c                                                        |   78 
 tools/perf/util/stat-display.c                                                |    6 
 tools/perf/util/stat-shadow.c                                                 |   24 
 tools/perf/util/stat.c                                                        |   20 
 tools/perf/util/stream.c                                                      |    4 
 tools/perf/util/symbol.c                                                      |    3 
 tools/perf/util/synthetic-events.c                                            |   17 
 tools/perf/util/thread-stack.c                                                |    2 
 tools/perf/util/time-utils.c                                                  |   12 
 tools/perf/util/top.c                                                         |    4 
 tools/perf/util/trace-event-read.c                                            |   33 
 tools/perf/util/unwind-libdw.c                                                |   24 
 tools/perf/util/util.c                                                        |   12 
 tools/perf/util/zstd.c                                                        |   25 
 tools/sched_ext/include/scx/compat.bpf.h                                      |    2 
 tools/sched_ext/scx_flatcg.bpf.c                                              |   19 
 tools/sched_ext/scx_flatcg.c                                                  |    4 
 tools/sched_ext/scx_qmap.bpf.c                                                |    2 
 tools/scripts/Makefile.include                                                |   37 
 tools/testing/cxl/test/cxl.c                                                  |  485 +++
 tools/testing/cxl/test/hmem_test.c                                            |    3 
 tools/testing/cxl/test/mock.h                                                 |    2 
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
 tools/testing/selftests/bpf/Makefile                                          |    9 
 tools/testing/selftests/bpf/README.rst                                        |    4 
 tools/testing/selftests/bpf/libarena/include/libarena/userspace.h             |    2 
 tools/testing/selftests/bpf/libarena/src/common.bpf.c                         |    6 
 tools/testing/selftests/bpf/network_helpers.c                                 |    4 
 tools/testing/selftests/bpf/network_helpers.h                                 |    5 
 tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c                    |   43 
 tools/testing/selftests/bpf/prog_tests/global_map_resize.c                    |    8 
 tools/testing/selftests/bpf/prog_tests/libarena.c                             |    8 
 tools/testing/selftests/bpf/prog_tests/libarena_asan.c                        |    8 
 tools/testing/selftests/bpf/prog_tests/lsm_bdev.c                             |    3 
 tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c                         |   11 
 tools/testing/selftests/bpf/prog_tests/mptcp.c                                |   13 
 tools/testing/selftests/bpf/prog_tests/sha256.c                               |    4 
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c                       |    2 
 tools/testing/selftests/bpf/progs/bpf_tracing_net.h                           |    3 
 tools/testing/selftests/bpf/progs/mptcpify.c                                  |    2 
 tools/testing/selftests/bpf/test_loader.c                                     |    2 
 tools/testing/selftests/bpf/test_progs.c                                      |   22 
 tools/testing/selftests/bpf/test_sockmap.c                                    |    3 
 tools/testing/selftests/bpf/veristat.c                                        |   76 
 tools/testing/selftests/bpf/vmtest.sh                                         |   13 
 tools/testing/selftests/cgroup/test_cpuset_prs.sh                             |   18 
 tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh                           |    2 
 tools/testing/selftests/drivers/net/config                                    |    5 
 tools/testing/selftests/drivers/net/lib/py/env.py                             |   11 
 tools/testing/selftests/drivers/net/ring_reconfig.py                          |  255 +-
 tools/testing/selftests/drivers/net/so_txtime.py                              |   21 
 tools/testing/selftests/kselftest_harness.h                                   |    2 
 tools/testing/selftests/lsm/common.c                                          |    4 
 tools/testing/selftests/mm/cow.c                                              |    9 
 tools/testing/selftests/mm/hmm-tests.c                                        |   21 
 tools/testing/selftests/mm/hugepage_settings.c                                |    2 
 tools/testing/selftests/mm/khugepaged.c                                       |    4 
 tools/testing/selftests/mm/ksm_tests.c                                        |   28 
 tools/testing/selftests/mm/memory-failure.c                                   |   44 
 tools/testing/selftests/mm/thuge-gen.c                                        |   15 
 tools/testing/selftests/mm/vm_util.c                                          |   28 
 tools/testing/selftests/mm/vm_util.h                                          |    1 
 tools/testing/selftests/namespaces/nsid_test.c                                |    4 
 tools/testing/selftests/proc/proc-maps-race.c                                 |    3 
 tools/testing/selftests/proc/proc-pidns.c                                     |    1 
 tools/testing/selftests/rseq/rseq-x86-thread-pointer.h                        |    4 
 tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c                   |   20 
 tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c                  |   13 
 tools/testing/selftests/sched_ext/exit.c                                      |    1 
 tools/testing/selftests/sched_ext/prog_run.c                                  |   34 
 tools/testing/selftests/timers/leap-a-day.c                                   |   19 
 tools/testing/selftests/vfio/lib/vfio_pci_device.c                            |   26 
 tools/testing/selftests/zram/zram_lib.sh                                      |    2 
 1764 files changed, 31693 insertions(+), 13863 deletions(-)

Aaradhana Sahu (4):
      wifi: ath12k: correct monitor destination ring size
      wifi: ath12k: switch to name-based reserved memory lookup
      wifi: ath12k: refactor QMI memory assignment
      wifi: ath12k: allocate HOST_DDR and BDF regions after Q6 RO region

Aaron Tomlin (3):
      perf trace: Correct default cpumask formatting to hexadecimal
      perf sched: Suppress latency table output when trace samples are missing
      perf sched: Handle missing trace samples in pipe mode

Abd-Alrhman Masalkhi (4):
      md: remove REQ_NOWAIT support from raid1/10/456
      md: recheck spare changes before starting sync
      md/raid1: restrict atomic write limits and handle runtime constraints
      md/raid10: consistently fail atomic writes that require splitting

Abdun Nihaal (2):
      wifi: rtlwifi: pci: fix error path in rtl_pci_probe()
      misc: vmc_vmci: Fix potential memory leak in vmci_event_subscribe()

Abel Vesa (4):
      arm64: dts: qcom: eliza: Enable first QUPv3 wrapper by default
      clk: qcom: gcc-glymur: Enable runtime PM
      arm64: dts: qcom: glymur: Add CX power domain to GCC
      arm64: dts: qcom: eliza: Add fallback compatible for ADSP remoteproc

Ada Couprie Diaz (1):
      arm64: hibernate: mask DAIF before restoring hibernated kernel

Aditya Prakash Srivastava (2):
      ext4: fix ABBA deadlock in ext4_xattr_inode_cache_find()
      ext4: use fsdata to track inline data write state and fix race

Adrian Hunter (7):
      i3c: master: Fix device_register() error path
      i3c: master: Fix recursive locking during device registration
      i3c: master: Fix use-after-free of master->this
      i3c: master: Do not treat master device as a duplicate target
      perf/x86/intel/pt: Factor out pt_config_enable()
      perf/x86/intel/pt: Use bitwise access for PERF_HES_STOPPED
      perf/x86/intel/pt: Fix stop/start with no update

Adrián Larumbe (3):
      drm/panthor: Pass vm_bind_op to vm_prepare_map_op_ctx
      drm/panthor: Support sparse mappings
      drm/panthor: Add vm_bind region with kbo range overlap check

Ahmet Sezgin Duran (1):
      staging: sm750fb: gate dualview dataflow using g_dualview

Ahsan Atta (1):
      crypto: qat - remove dead ADF_HEX code

Ai Chao (1):
      HID: i2c-hid: Fix "(null)" output when reading report descriptor fails

Akari Tsuyukusa (2):
      iommu/mediatek-v1: Fix off-by-one in MT2701_LARB_NR_MAX
      clk: mediatek: mt8135: Fix inverted gate control for devapc_ck

Akash Goel (1):
      drm/panthor: Fix NPD issue on partial unmap of an evicted BO

Akhmed Zhitaev (1):
      drm/amd/display: Scale custom brightness curve from full range

Aksh Garg (1):
      PCI: cadence: Fix host/endpoint dependencies for cadence-plat driver

Alain Volmat (1):
      media: stm32: dcmi: fix error handling on MDMA pool alloc failure

Alban Bedel (1):
      software node: Fix software_node_get_reference_args() with index -1

Aleksandr Nogikh (3):
      udf: Mark LVID buffer as uptodate before marking it dirty
      ALSA: core: Fix use-after-free in snd_card_do_free()
      libceph: validate banner payload length

Alessio Podda (1):
      perf unwind-libdw: Fix unwinding of multi-threaded processes

Alex Bereza (1):
      dmaengine: xilinx_dma: Fix CPU stall in xilinx_dma_poll_timeout

Alex Deucher (1):
      drm/gfx12: Program DB_RING_CONTROL

Alex Mastro (1):
      vfio: selftests: Avoid VLAs

Alexander A. Klimov (3):
      clk: moxart: remove unused variables, fix refcount leak
      staging: greybus: audio: correct sscanf() return value check
      tlclk: if sscanf() fails, fall back to 0, not random value

Alexander Usyskin (1):
      mei: lb: fix incorrect type in assignment

Alexandre Courbot (2):
      gpu: nova-core: gsp: tu102: keep unloading if FWSEC-SB fails
      gpu: nova-core: fix packed registry table size

Alexandro Calo (1):
      ntfs: Fix index_root heap OOB write in ntfs_ir_to_ib()

Alexey Charkov (3):
      clk: rockchip: Fix the fractional part denominator on RK3588/RK3576 PLLs
      clk: rockchip: Fractional PLL coefficient on RK3588/RK3576 is two's complement
      clk: rockchip: rk3576: fix source muxes for SPI0..SPI4

Alexis Savery (1):
      platform/chrome: lightbar: Limit payload to max packet size

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

Allison Henderson (2):
      RDMA/rxe: Avoid reprocessing the current packet after the QP enters the error state
      net/rds: use wq_has_sleeper() in rds_cong_map_updated()

Alvin Šipraga (1):
      pinctrl: fix PINCTRL_GENERIC_MUX not always being selectable

Amin Vakil (1):
      selftests: proc: include fcntl.h in proc-pidns

Ananthu C V (1):
      arm64: dts: qcom: glymur: fix SoCCP memory mappings

Anas Khan (1):
      drm/amd/display: remove duplicate link_dp_panel_replay.h include

Andre Przywara (1):
      ARM: dts: allwinner: a10: Fix PMU interrupt

Andreas Kemnade (1):
      drm/omap: dsi: Do not copy isr table

Andreas Schwab (1):
      m68k: nfcon: Do not call console_is_registered() in nfcon_device()

Andrew Jones (1):
      iommu/dma: Restore locking around msi_page_list

Andrey Golovko (1):
      ASoC: tas2783-sdw: drop stale regcache on uninitialized re-attach

Andrii Nakryiko (3):
      bpftool: Strip all -Wformat* flags from bootstrap libbpf build
      selftests/bpf: Use ping_command() for IPv6 pings in lwt_ip_encap
      selftests/bpf: Retry stat generation in cgroup_iter_memcg

Aneesh Kumar K.V (Arm) (2):
      iommu/dma: Check atomic pool allocation result directly
      swiotlb: Preserve allocation virtual address for dynamic pools

AngeloGioacchino Del Regno (1):
      arm64: dts: mediatek: tungsten-smarc: Remove unnecessary cells

Anna Maniscalco (1):
      drm/msm: remove objects from evit list after pinning them

Anoop Vijay (1):
      drm/xe/sysctrl: Read mailbox phase bit from hardware

Anshumali Gaur (3):
      octeontx2-af: fix NULL deref in NIX TM tree debugfs read path
      octeontx2-af: fix out-of-bounds read setting MSI-X irq affinity
      octeontx2-vf: fix workqueue and netdev race in probe/remove

Anton Protopopov (1):
      virtio_net: Fix resize of the RX ring

Armin Wolf (4):
      platform/x86: dell-privacy: Fix race condition
      platform/x86: dell-wmi-base: Fix resource leak on module load failure
      platform/x86: dell-wmi-base: Fix handling of ultra performance key
      platform/x86: lg-laptop: Fix LED resource handling

Arnaldo Carvalho de Melo (25):
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
      perf header: Use write lock when translating BPF prog info pointers
      perf bpf: Add PROG_TAGS to required arrays in __bpf_event__print_bpf_prog_info()
      perf libbfd: Fix memory leaks and NULL fclose in BPF disassembly
      perf c2c: Fix error masking, OOM, and unchecked caller errors in hpp_list__parse()
      perf c2c: Clean up registered formats on c2c_hists__init() and c2c_hists__reinit() failure
      perf build: Remove leftover feature tests for removed cxx and clang support
      perf dso: Guard against errno==0 when dso__get_filename() returns NULL
      perf dso: Guard close() against invalid fd in dso__decompress_kmodule_path()
      perf dso: Use stored fd error instead of stale errno in file_read() and file_size()
      perf dso: Guard against cache underflow on short reads in dso_cache__memcpy()
      perf dso: Replace assert with runtime check in dso__read_symbol()

Arnaud Bonnet (2):
      nfs: replace atomic bitops sequence with clear_and_wake_up_bit helper
      nfs: refactor pNFS functions using clear_and_wake_up_bit

Arnd Bergmann (3):
      PCI: imx6: Fix building against PCI_HOST_COMMON
      PCI: imx6: Fix building against PCI_PWRCTRL_GENERIC
      gpib: use 'static inline' instead of 'extern inline'

Arvind Yadav (1):
      drm/xe: Reject page faults from non-fault-mode scratch VMs

Asad Kamal (3):
      drm/amd/powerplay: fix VoltageObjectInfo zero-stride loop and OOB read
      drm/amdgpu/pm/powerplay: bounds-check voltage index in SMU7 lookup
      drm/amdgpu/pm/powerplay: bounds-check voltage index in Vega10 lookup

Ashish Mhetre (1):
      arm64: tegra: Fix CMDQV interrupt type on Tegra264

Atish Patra (2):
      crypto: ccp - Fix possible deadlock in SEV init failure path
      crypto: ccp - Fix memory leak in SEV INIT_EX path

Aurelien Jarno (2):
      riscv: dts: spacemit: set console baud rate on K3 Pico-ITX board
      riscv: dts: spacemit: improve RTL8211F PHY configuration on K3 Pico-ITX board

Avraham Stern (2):
      wifi: iwlwifi: mei: check SAP message length before reading it
      wifi: iwlwifi: mei: pass correct argument to function

Ayush Mukkanwar (2):
      staging: octeon: add missing tasklet_kill in cvm_oct_tx_shutdown
      staging: octeon: add missing napi_disable in cvm_oct_rx_shutdown

Babanpreet Singh (3):
      power: supply: sbs-battery: Use a per-device serial number buffer
      w1: ds2482: Fix signedness bug in ds2482_w1_triplet()
      spi: sprd-adi: Fix probe succeeding without registering the controller

Balasubramani Vivekanandan (1):
      drm/xe/xe_gt_idle: Add CCS to the powergating info print

Baochen Qiang (3):
      wifi: ath12k: fix dp_link_peer dangling references on AP vdev rollback
      wifi: ath12k: fix MLO peer delete race
      wifi: ath11k: cap out-of-range rx MCS instead of leaving bogus rate

Baokun Li (5):
      ext4: drain in-flight DIO before buffered write fallback
      cuse: wait for pending RCU callbacks on module exit
      fuse: reject a duplicate fd= mount option
      fuse: check for NULL root inode in fuse_fill_super_submount
      fuse: invalidate the correct range after O_APPEND direct write

Baolin Liu (1):
      ntfs: do not update ctime when setxattr fails

Bard Liao (1):
      soundwire: cadence_master: add BRA_NumBytes[8] support

Bart Van Assche (1):
      scsi: ufs: core: Set task state before io_schedule_timeout()

Baul Lee (1):
      vxlan: mdb: Fix use-after-free in vxlan_mdb_flush()

Ben Cressey (1):
      dm-integrity: fix buffer overflow with keyed discard

Ben Horgan (2):
      arm_mpam: Fix a NULL pointer dereference on unbinding after an error interrupt
      arm_mpam: Disable driver unbind to avoid UAF

Bernd Schubert (1):
      fuse: Fix the condition to enable over-io-uring

Besar Wicaksono (1):
      perf vendor events arm64: Fix Tegra410 Olympus event 0x0197

Bijan Tabatabai (1):
      x86/pkeys: Fix pkey_alloc() return value when pkeys are not supported

Biju Das (3):
      usb: renesas_usbhs: Fix power-off ordering on unbind
      phy: renesas: phy-rcar-gen3-usb2: Fix devm action registration for disabled VBUS regulator
      irqchip/renesas-rzg2l: Fix loss of interrupt

Biren Pandya (1):
      media: i2c: rdacm21: Fix missing media_entity_cleanup()

Biswapriyo Nath (1):
      arm64: dts: qcom: sm6125: Use 64 bit addressing

Bjorn Andersson (4):
      usb: typec: ucsi: unregister debugfs entries on teardown
      remoteproc: Allow shutdown of crashed processors
      remoteproc: Prevent crash handling to race with rproc_del()
      remoteproc: qcom: q6v5: Request shutdown if crash is triggered host-side

Bradley Morgan (2):
      lib/string: fix memchr_inv() for large ranges
      prctl: fix PR_SET_MM_AUXV losing the forced AT_NULL terminator

Breno Leitao (6):
      workqueue: only show running workers in stall diagnostics
      efi: fix stale reference to efi_recover_from_page_fault()
      cacheinfo: don't propagate DT/ACPI error when arch supplies info (arm64)
      phonet: pep: do not write beyond optlen in getsockopt
      nfc: llcp: avoid userspace overflow on invalid optlen
      nfc: llcp: read llcp_sock->local under the socket lock in getsockopt

Brian Foster (1):
      iomap: release the folio batch on iomap callback failures

Brian Masney (2):
      clk: imx: scu: drop redundant init.ops variable assignment
      clk: qcom: camcc-sc8280xp: unregister CAMCC_GDSC_CLK

Brian Norris (1):
      arm64: dts: qcom: Add #{address,size}-cells to Chromium-based /firmware

Bruce Johnston (1):
      md/raid1: don't set array_frozen in raid1_takeover()

Bryam Vargas (4):
      dm-pcache: validate seg_id fields from persistent memory
      dm-pcache: validate the persisted dirty_tail chain at load
      greybus: audio: bound the topology section sizes against the fetched size
      libnvdimm/labels: Bound the on-media label size before the shift

Caleb Sander Mateos (2):
      ublk: check import_ubuf() return value
      ublk: check for ublk_unmap_io() returning 0

Calvin Owens (2):
      pps: don't try to wait for negative timeouts in PPS_FETCH
      pps-gpio: remove dead capture_clear code

Can Guo (1):
      scsi: ufs: core: Avoid possible memory reclaim deadlock in TX EQTR context

Can Peng (6):
      phy: starfive: Fix runtime PM cleanup in JH7110 DPHY TX probe
      phy: starfive: Fix runtime PM cleanup in JH7110 DPHY RX probe
      drm/tve200: add OF module alias for autoloading
      crypto: keembay - publish OF module alias for OCS AES/SM4
      i3c: master: adi: add OF module alias for autoloading
      ACPI: processor: Unregister cpufreq notifier on init failure

Casey Schaufler (1):
      Smack: Fix error in capability bypass

Cen Zhang (6):
      wifi: mac80211_hwsim: avoid NULL skb in stop queue drain
      ocfs2/cluster: keep heartbeat local node stable
      ocfs2: validate inline xattrs during inode block validation
      ocfs2: validate external xattr entries when reading metadata
      ocfs2: synchronize heartbeat callbacks with o2net teardown
      ocfs2: o2hb: quiesce negotiate handlers and timeout work

Cen Zhang (Microsoft Security FORGE Labs) (1):
      ksmbd: fix tree connection use-after-free in smb2_tree_connect()

Cen Zhang (Microsoft) (3):
      xsk: fix NULL pointer dereference in __xsk_rcv()
      ipv6: avoid divide by zero in rt6_multipath_rebalance
      gtp: add synchronize_net() in gtp_newlink() error path to prevent use-after-free

Chad Monroe (2):
      wifi: mt76: mt7996: fix EAPOL source BSS for non-MLD stations
      wifi: mt76: mt7996: fix non-MLD station num_sta leak

Chandrakanth Patil (1):
      scsi: mpt3sas: Avoid freeing unallocated PCIe SGL buffers

Chao Huang (1):
      HID: i2c-hid: goodix: Disable VDD on VDDIO enable failure

Chao Shi (1):
      nvme: reject passthrough of driver-managed Set Features

Chao Yu (2):
      f2fs: cleanup w/ f2fs_need_rand_{blk, seg, seg_blk}
      f2fs: fix to avoid pinfile fragment on fragment:{block, segment} mode

Charles Keepax (2):
      ASoC: SDCA: Add missing stub for sdca_fdl_free_state()
      mfd: cs42l43: Fix regmap defaults ordering

Chen Cheng (5):
      md/raid5: protect bitmap batch counters aka seq_flush/seq_write consistency
      md/raid5: fix lockless max_nr_stripes reads
      md/raid5: protect lockless recovery_offset accesses during reshape
      md/bitmap: resume array on backlog_store() error path
      md: scope memalloc_noio to allocation critical sections

Chen Pei (1):
      ACPI: PCI: Clear driver_data on all paths that free the acpi_pci_root

Chen, Yu C (1):
      sched/fair: Fix overflow in update_tg_cfs_runnable()

ChenXiaoSong (1):
      smb/client: return EOPNOTSUPP for unsupported O_TMPFILE

Cheng Xu (2):
      RDMA/erdma: Hold CQ references when processing EQ events
      RDMA/erdma: Hold QP references for AE and CM processing

Cheng-Han Wu (1):
      selftests/zram: fix kernel_gte() for POSIX sh

Cheng-Yang Chou (1):
      sched_ext: Fix exit_cpu accuracy for lockup paths

Chia-Yuan Li (1):
      wifi: rtw89: fw: use MAC source for IO offload delay command

Chih-Kang Chang (1):
      wifi: rtw89: 8852a: fix RSSI report when average beacon RSSI is not ready

Chris Lu (2):
      Bluetooth: btmtksdio: Take exclusive ownership of the SKB before TX
      Bluetooth: btmtksdio: Fix out-of-bounds DMA read in the TX path

Christian Marangi (2):
      thermal/drivers/airoha: Fix copy paste error on clamp_t low temp
      thermal/drivers/airoha: Fix copy paste error for sen internal

Christoph Hellwig (4):
      block: remove bip_should_check
      block: lift BIP_CHECK_FLAGS to include/linux/bio-integrity.h
      block: handle nogenerate/noverify properly in fs-integrity
      iomap: iomap_bio_read_folio_range_sync is missing a call to bio_uninit

Christophe JAILLET (3):
      leds: lp5860: Fix a potential double-unlock
      leds: lp5860-spi: Fix an error handling path
      accessibility: speakup: Fix incorrect string length computation in report_char_chartab_status()

Christophe Leroy (CS GROUP) (4):
      bitmap: Properly initialise destination bitmap for scatter & gather test
      powerpc: implement get_direction() in cpm2
      soc: fsl: qe: properly scan GPIO nodes at startup
      soc: fsl: qe: implement get_direction()

Christopher Lusk (2):
      smb: client: fix request buffer leak in smb2_new_read_req()
      smb: client: set replay flag on the read send-error retry path

Christos Maragkos (1):
      HID: nintendo: Fix imu_timestamp_us double increment per report

Chuck Lever (7):
      NFSD: Release the export reference when reaping open stateids
      lockd: Regenerate NLMv4 XDR code
      xdrgen: Emit a blank line ahead of enum declarations
      xdrgen: Do not declare union XDR functions in the definitions header
      xdrgen: Add XDR width macros for short integer types
      xdrgen: Fix opaque and string encoders for unbounded members
      NFS: Return a delegation the client fails to record

Claudiu Beznea (2):
      i3c: renesas: Return immediately if there is no transfer
      i3c: renesas: Follow a unified pattern for transfer and command initialization

Cong Nguyen (2):
      staging: rtl8723bs: fix xmit_frame/xmit_buf leaks on mgnt-frame error paths
      media: staging/ipu7: fix async notifier leak on init error

Cosmo Chou (3):
      leds: pca9532: Fix inverted GPIO output polarity
      leds: pca9532: Fix phantom device registration on missing hardware
      rtc: pcf85363: Add error checking to regmap calls in probe()

Cristian Ciocaltea (10):
      drm/bridge: synopsys: dw-dp: Support unregistering the AUX channel
      drm/rockchip: dw_dp: Add missing newline in dev_err_probe() message
      drm/rockchip: dw_dp: Release core resources
      drm/rockchip: vop2: Fix wrong wait target in layer cfg done check
      drm/rockchip: vop2: Wait for layer cfg done before switching LAYERSEL_REGDONE_SEL
      phy: rockchip: samsung-hdptx: Fix rate recalculation for high bpc
      phy: rockchip: samsung-hdptx: Prevent divide-by-zero when computing clk rate
      phy: rockchip: samsung-hdptx: Guard against clk rate integer underflow
      phy: rockchip: samsung-hdptx: Fix rate recalculation for 3.2GHz FRL
      phy: rockchip: samsung-hdptx: Handle uncommitted PHY config changes

Damon Ding (5):
      drm/rockchip: analogix_dp: Enable hclk for RK3588
      drm/rockchip: analogix_dp: Fix OF node reference leak via auto cleanup
      drm/bridge: of-display-mode-bridge: Fix missing static const for the bridge funcs
      arm64: dts: rockchip: Add missing hclk for RK3588 eDP0
      arm64: dts: rockchip: Add missing hclk for RK3588 eDP1

Dan Carpenter (10):
      wifi: rtw89: debug: fix off by on in rtw89_ppdu_str()
      staging: fbtft: Use sysfs_emit_at() to print to sysfs file
      thermal/drivers/rcar: Fix error checking in probe()
      regulator: adp5055: Fix error code in adp5055_of_parse_cb()
      cpufreq: spear: Fix an IS_ERR() vs NULL bug in spear1340_set_cpu_rate()
      drm/msm/adreno: fix use after free on error path in a6xx_gpu_init()
      media: stm32: dcmi: fix some error handling bugs in probe()
      drm/amd/pm: silence uninitialized variable warnings
      drm/xe: tests: fix error message in xe_migrate_sanity_test()
      scsi: qla2xxx: Fix an loop timeout test

Daniel Baluta (1):
      soc: qcom: ubwc: Fix missing include

Daniel Borkmann (14):
      bpftool: Check EVP_Digest when computing excl_prog_hash
      bpf: Fix vmlinux BTF prep race in bpf_get_btf_vmlinux
      bpf: Fix security_bpf_map_create error handling
      bpf: Drop scalar id on sign-extending narrowing stack fills
      bpf: Check load-acquire src ptr type before the load
      bpf: Reject load-acquire from pointers requiring fault protection
      bpf, riscv: Add and use bpf_atomic_is_load_acq() helper
      bpf, x86: Fix exception table metadata for arena load-acquire
      bpf, arm64: Fix exception table metadata for arena load-acquire
      bpf, riscv: Clear fetch destination on faulting arena atomic
      bpf: Derive the atomic load register in one place
      bpf, x86: Clear fetch destination on faulting arena atomic
      bpf, arm64: Clear fetch destination on faulting arena atomic
      bpf, s390: Clear fetch destination on faulting arena atomic

Daniel Machon (2):
      net: microchip: vcap: use port number instead of netdev name for debugfs
      net: sparx5: fix sleep in atomic context in MAC table access

Daniel McCarthy (1):
      pinctrl: bcm2835: Don't remove an unregistered GPIO chip

Daniel Pawlik (1):
      net: airoha: npu: fix missing streaming DMA mask

Daniele Ceraolo Spurio (1):
      drm/xe: Do not apply WA 14025883347 to media 3503

Danila Chernetsov (2):
      RDMA/hfi1: Propagate sdma_txinit_ahg() errors
      fbdev: kyro: Validate overlay viewport coordinates

Dapeng Mi (1):
      perf/x86/intel: Keep cap_user_rdpmc in sync with RDPMC user-disable state

Dave Jiang (7):
      cxl/test: Add test for module parameters
      cxl/test: Refactor platform device enumerations
      cxl/test: Add hierarchy enumeration support for type2 device
      cxl/test: Propagate -ENOMEM on platform_device_alloc() failures
      cxl/mbox: Break poison list loop on an empty payload
      cxl/pci: Honor -EPROBE_DEFER from component register setup
      cxl/features: Serialize multi-part Get/Set Feature transfers

David Carlier (1):
      clk: canaan: Clear rate fields before reprogramming dividers

David Lee (2):
      UDF symlink pathComponent header OOB read
      nilfs2: prevent out-of-bounds read in super root block parsing

David Matlack (3):
      liveupdate: Reference count outgoing FLB data
      liveupdate: Remember FLB retrieve() status
      selftests: harness: Mark test fixture objects __maybe_unused

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

Deborah Brouwer (1):
      rust: drm: gpuvm: update DriverGpuVm for DeviceContext

Deepanshu Kartikey (1):
      usb: atm: usbatm: fix invalid ci_range initialization

Denis Benato (2):
      HID: asus: refactor the two workqueues and init sequence
      HID: asus: fix a off-by-one in mcu_parse_version_string() validation

Denis V. Lunev (4):
      x86/mm/pat: Take cpa_lock around large-page collapse
      virtio: add virtio_device_shutdown() helper
      virtio_balloon: factor out virtballoon_quiesce()
      virtio_balloon: quiesce balloon work before device shutdown

Dennis Tighe (2):
      ntfs: fix off-by-one page overflow in ntfs_decompress()
      ntfs: validate usa_ofs before preserving the update sequence number

Desnes Nunes (1):
      iommu/vt-d: Fix UCTP context table slot when copying root entries

Devin Wittmayer (1):
      wifi: mt76: mt76x02: do not WARN on invalid rx descriptor length

Dikshita Agarwal (2):
      media: qcom: iris: Fix bitmask test in iris_allow_cmd()
      media: qcom: iris: Remove duplicate HFI_PROP_OPB_ENABLE entry

Dmitry Antipov (2):
      smack: simplify write handlers of sysfs entries
      ocfs2: do not use make_bad_inode() in ocfs2_read_inode_block_full()

Dmitry Baryshkov (10):
      drm/bridge: display-connector: don't autoenable HPD IRQ
      drm/bridge: display-connector: trigger initial HPD event for DP
      arm64: dts: qcom: sc8280xp: sort reserved memory regions
      Revert "drm/msm: dsi: fix PLL init in bonded mode"
      arm64: dts: qcom: sm8250: sort out Iris power domains
      arm64: dts: qcom: sm8250: correct frequencies in the Iris OPP table
      clk: qcom: gcc-qcm2290: don't park QUP RCGs upon registration
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

Dyllan Kobal (1):
      drm/amd/display: fix wrong register field in dccg35_set_hdmistreamclk_src_new

EDAMAMEX (1):
      cpufreq/amd-pstate: handle missing policy in dynamic EPP callbacks

Eason Lai (3):
      wifi: mt76: mt792x: fix use-after-free in mt76_rx_poll_complete
      wifi: mt76: mt7921: Add PCIe AER handler support to prevent system crash
      wifi: mt76: mt792x: Fix memory leak in SDIO TX path

Edoardo Pinci (1):
      net: dsa: mxl862xx: enable assisted learning on CPU port

Eduard Zingerman (1):
      selftests/bpf: Fix for veristat file/prog filters processing

Eliot Courtney (2):
      gpu: nova-core: correct RISC-V HALTED field
      gpu: nova-core: correct FRTS vidmem offset calculation

Emil Tsalapatis (1):
      selftests/bpf: libarena: Clean up allocation state before buddy tests

Emmanuel Grumbach (3):
      wifi: iwlwifi: fix counter type in iwl_fwrt_dump_error_logs
      wifi: iwlwifi: mvm: fix off-by-one in TXF key sanitiser
      wifi: iwlwifi: guard against division by zero in iwl_dbg_tlv_alloc_fragments

Enzo Matsumiya (1):
      smb: server: fix leak of ksmbd_ipc_login_request_ext() returned buffer

Eric Dumazet (6):
      netdevsim: update queue NAPI association on queue reset
      ip6mr: do not clone dst in ip6mr_cache_report()
      inetpeer: randomize RB-tree node comparison using SipHash
      net_sched: sch_fq: fix pacing delay underflow with pacing offload
      net/sched: act_skbmod: fix length calculations and avoid invalid header warnings
      slip: remove slip_hangup() to fix use-after-free in slip_receive_buf()

Eric Joyner (1):
      ionic: add missing dma_rmb() after the completion publish check

Esteban Urrutia (3):
      phy: qcom: qmp-pcie: Add pcs_lane1 offset to V5 offsets
      phy: qcom: qmp-combo: Correct pre-emphasis table for QMP v4 DP PHYs
      phy: qcom: qmp-combo: Drop qmp_v4_calibrate_dp_phy

Eugen Hristev (1):
      media: bcm2835-unicam: Fix asc leaked in error/remove path

Evgenii Burenchev (4):
      drm/amd/display: Fix dangling pointer in plane reset function
      drm/amd/display: Fix dangling pointer in CRTC reset function
      ALSA: via82xx: Remove unreachable branch in snd_via686_pcm_pointer()
      ALSA: hpi: Check transport errors during HPI6000 adapter initialization

Ewan D. Milne (1):
      drivers: base: Remove statistics group if encryption group not created

Fabio Estevam (2):
      arm64: dts: rockchip: Fix Gru WLAN sideband interrupt
      arm64: dts: rockchip: Fix rk3566-bigtreetech-cb2 touchscreen property

Fabrice Derepas (1):
      apparmor: fix integer overflow in verify_tags() bounds check

Fan Gong (1):
      hinic3: Fix skb linearization mismatch and drop skb when skb_checksum_help() failed

Fan Wu (3):
      spi: oc-tiny: switch to managed controller allocation
      spi: davinci: switch to managed controller allocation
      RDMA/cxgb4: Free debugfs on registration failure

Fan Ye (1):
      net: thunderbolt: Count delivered packets in rx_packets and rx_bytes

Farhan Ali (1):
      vfio/pci: Avoid mapping BARs for devices with non-mappable BARs

Fei Shao (1):
      usb: mtu3: allow system suspend during active gadget connection

Felix Fietkau (41):
      wifi: mt76: mt7996: validate RX band_idx before dereferencing phys[]
      wifi: mt76: mt7996: set MT76_MCU_RESET before waking MCU waiters on full reset
      wifi: mt76: mt7915: clear wcid mask under mutex after RCU pointer clear
      wifi: mt76: mt7915: avoid nss underflow in mt7915_mcu_get_sta_nss
      wifi: mt76: mt7996: don't report a zero TX bitrate
      wifi: mt76: mt7915: write RX header translation bit to the correct register
      wifi: mt76: fix 4th chain ACK RSSI bitmask in sta_poll
      wifi: mt76: fix stranded frames in mt76_txq_schedule_pending
      wifi: mt76: fix uninitialised RXDMAD_C descriptor info
      wifi: mt76: fix RXDMAD_C buffer recycling race
      wifi: mt76: mt7915: poll the correct SLP CTRL register for the second adie
      wifi: mt76: fix HE DCM max-RU capability encoding
      wifi: mt76: mt7996: bound TLV walk in mt7996_mcu_get_chip_config
      wifi: mt76: fix out-of-bounds access in mmio copy helpers
      wifi: mt76: mt7915: unwind state on add_interface failure
      wifi: mt76: mt7996: hold dev->mt76.mutex while disabling tx worker in SER
      wifi: mt76: decode the full VHT Rx STBC capability field
      wifi: mt76: fix ER-SU 106-tone RU check in RX rate decode
      wifi: mt76: mt7996: reserve space for the CSA-abort countdown TLV
      wifi: mt76: mt7996: don't leak MLD group index on remap alloc failure
      wifi: mt76: cancel reset and rc work on device unregister
      wifi: mt76: report data NSS for STBC frames in RX rate decode
      wifi: mt76: mt7915: use little-endian for bss_info_ra wire fields
      wifi: mt76: only consume the WO drop bit on WED v2 devices
      wifi: mt76: mt7915: unlink TWT flow if the MCU rejects the agreement
      wifi: mt76: mt7996: skip key upload when adding an offchannel link
      wifi: mt76: mt7996: wake MCU waiters before aborting scan in L1 SER
      wifi: mt76: mt7996: free vif links after clearing wcid entries on full reset
      wifi: mt76: mt7996: clear stale link state on full reset
      wifi: mt76: set MT76_SCANNING when starting a hw scan
      wifi: mt76: mt7996: fix MIB TX aggregation counter registers for mt7990
      wifi: mt76: mt7915: fix double hif2 init on the non-WED path
      wifi: mt76: mt7915: fix ext PHY use-after-free on register error path
      wifi: mt76: mt7915: release hif2 reference on probe IRQ failure
      wifi: mt76: mt7996: do not attach hif2 WED when the main WED attach failed
      wifi: mt76: mt7996: do not leave state behind after a failed WED attach
      wifi: mt76: mt7915: fix chainmask handling for non-dbdc phys on band 1
      wifi: mt76: mt7915: report RX chain signal for all RX paths
      wifi: mt76: reject out-of-range link ids in mt76_vif_link()
      wifi: mt76: mt7996: fix out-of-bounds link array access in mt7996_tx()
      wifi: mac80211: skip default WMM setup for AP_VLAN links

Felix Gu (5):
      pinctrl: imx1: fix device_node leak in dt_is_flat_functions()
      remoteproc: qcom_q6v5_adsp: Fix reference leak for device node
      phy: renesas: rcar-gen2: Fix double of_node_put on phy creation failure
      phy: sunplus: fix error handling in sp_uphy_init()
      spi: img-spfi: don't disable runtime PM on DMA deferred probe

Feng Jiang (1):
      bpf, riscv: Fix extable handling for arena load_acquire

Feng Yang (4):
      selftests/bpf: Fix memory leak in msg_alloc_iov
      selftests/bpf: Fix incorrect error checking for pthread_create
      selftests/bpf: Fix missing allocation null checks in test_progs.c
      selftests/bpf: Fix memory leak on subtest_states reallocation

Filipe Manana (1):
      btrfs: defrag: fix deadlock between defrag and delalloc space reservation

Florian Westphal (3):
      netfilter: nf_nat_sip: rewind offset when NAT shrinks the packet
      netfilter: nft_ct: support expectation creation for natted flows
      netfilter: ipset: remove need to allocate memory on delete operations

Francesco Dolcini (1):
      arm64: dts: freescale: imx95-toradex-smarc: add alias for lpuart5

Frank Li (1):
      arm64: dts: imx8-ss-audio: Fix LPCG clock indices for ASRC0

Frank Sorenson (2):
      cifs: remove dead size-update blocks in cifs_setattr_unix/nounix
      cifs: fix clearing stats for fastest execution of each smb2 command

Frieder Schrempf (1):
      arm64: dts: imx93-kontron: set memory node to 0x80000000/1GiB

Fuad Tabba (1):
      of/irq: Fix device node refcount leak in of_irq_get_affinity()

Fushuai Wang (2):
      serial: 8250: Clear CON_PRINTBUFFER on port re-registration
      Revert "serial: 8250: Clear CON_PRINTBUFFER on port re-registration"

Gael Blivet (3):
      ksmbd: fix durable handle v2 default timeout units (60 -> 60000)
      ksmbd: add AAPL kAAPL_SERVER_QUERY create context support
      ksmbd: defer CHANGE_NOTIFY completion instead of STATUS_NOT_IMPLEMENTED

Gao Xiang (2):
      erofs: fix interlaced ztailpacking pclusters
      erofs: guard on-disk algorithm IDs against Z_EROFS_COMPRESSION_MAX

Gary Guo (6):
      usb: fix UAF when probe runs concurrent to dyn ID removal
      rust: device: make lifetime on `Core` and `CoreInternal` invariant
      samples: rust: debugfs: fix excessive stack use
      PCI: Make pci_match_one_device() match on ID instead of device
      PCI: Fix dyn_id add TOCTOU
      PCI: Fix UAF when probe runs concurrent to dyn ID removal

Geert Uytterhoeven (5):
      soc: renesas: r8a78000: Drop duplicate "default ARCH_RENESAS"
      clk: ti: Make sure clk_init_data is fully initialized
      clk: visconti: Make sure clk_init_data is fully initialized
      spi: amlogic-spisg: Make sure clk_init_data is fully initialized
      erofs: Fix EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS default logic

Geoffrey McRae (2):
      drm/amdgpu/mes: Fix hung_queue_db_array loop limit for multi-XCC
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

Giuseppe Piscitelli (1):
      net/sched: sch_cake: fix autorate reconfiguration throttling

Gleb Markov (2):
      drm/amd/display: Remove unused-but-set variable hubp from
      misc: rtsx: add missing write register handling

Golla Nagendra (1):
      dmaengine: zynqmp_dma: fix race between runtime PM and device removal

Gopikrishna Garmidi (4):
      arm64: dts: qcom: glymur: Fix unit-address mismatch for spmi_bus2
      arm64: dts: qcom: glymur: Fix gcc clock specifier for usb_mp_qmpphy nodes
      arm64: dts: qcom: glymur-crd: Move common board nodes to shared DTSI
      arm64: dts: qcom: glymur-crd: merge duplicate &pmh0101_gpios node extensions

Gou Hao (4):
      powerpc/xive: make xive IPI allocation NULL-safe
      powerpc/xive: add error return value to xive_smp_probe()
      powerpc/xive: propagate IPI init errors to prevent use-after-free
      powerpc/smp: add NULL guard for cause_ipi in smp_muxed_ipi_message_pass

Greg Kroah-Hartman (1):
      Linux 7.2.6

Gregor Herburger (1):
      OPP: Fix cleanup ordering

Gregory Price (1):
      mm/mm_init: handle alloc_percpu failure in free_area_init_core_hotplug

Guanghui Yang (1):
      ext4: fix buffer_head leak in ext4_init_orphan_info

Guangshuo Li (11):
      serial: qcom-geni: do not advance stale DMA completions
      crash_dump: release keyring reference at the correct time
      mtd: intel-dg: Fix runtime PM error path in probe
      clk: tegra: tegra124-emc: put EMC node on register failure
      rapidio: clear mport->net when rio_add_net() fails
      Bluetooth: btmtksdio: fix usage_count leak when autosuspend_delay is negative
      dmaengine: qcom-bam-dma: fix autosuspend cleanup during removal
      clocksource/drivers/clps711x: Do not unmap clocksource MMIO
      ksmbd: Do not skip lock checks for single-byte ranges
      NFS: Fix delayed delegation return list handling
      platform/x86: hp-bioscfg: fix password encoding bounds check

Guenter Roeck (1):
      bnxt_en: Fix call to hardware monitoring event handler

Gui-Dong Han (4):
      media: cec-pin: Fix event FIFO ordering
      nvme-apple: Use acquire/release for queue enabled state
      gpib: Move stuck SRQ update under lock
      misc: bcm-vk: Use acquire/release for msgq_inited

Guillaume Maudoux (1):
      selftests/bpf: Mask socket type flags in mptcpify prog

Guixin Liu (8):
      nvmet: fix return status of RMI log page on allocation failure
      nvme-fc: unmap cmd_iu DMA on rsp_iu mapping failure in init_request
      nvme-pci: return error when parsing a quirk string fails
      nvmet: reject out-of-range mdts values in configfs store
      nvmet: propagate percpu_ref_init() failure in nvmet_ns_enable()
      nvme-pci: release descriptor pools on probe failure
      nvmet: fix heap out-of-bounds read in nvmet_auth_negotiate()
      nvmet: fix NULL pointer dereference in nvmet_execute_identify_ns_zns()

GuoHan Zhao (1):
      virtio: rtc: time out alarm requests

Guodong Xu (1):
      riscv: cpufeature: Clarify ISA spec version for canonical order

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

Haoxiang Li (2):
      iommu/qcom: Remove sysfs device on probe failure path
      HID: logitech-hidpp: Fix FF device cleanup on init failure

Harry Wentland (1):
      drm/amd/display: Resize MST HDCP per-connector arrays to 32

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

Hongfu Li (2):
      selftests/mm: fix memleak in migration benchmark
      selftests/mm: fix read_file() return value check

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

Hui Zhu (1):
      bpf: Fix UAF in bpf_trampoline_multi_attach_free on update failure

Huisong Li (1):
      mailbox: pcc: Fix command timeout due to missed interrupt

Hungyu Lin (1):
      media: qcom: iris: handle runtime PM resume failure in core deinit

HyeongJun An (4):
      Bluetooth: virtio_bt: avoid OOB read of build info string
      ALSA: seq: Don't leak the extension cell pointer in the bounce payload
      platform/x86: dell-wmi-sysman: Fix instance ID bounds
      ASoC: dapm: Fix off-by-one check on the second enum channel

Hyeontae Lee (1):
      ntfs: serialize resident iomap reads with mrec_lock

Hyunwoo Kim (1):
      Bluetooth: RFCOMM: Validate MTU in rfcomm_apply_pn() to prevent infinite loop

Ian Rogers (35):
      perf pmu: Recognize default_core as a core PMU in more places
      perf util: Sort includes and add missed explicit dependencies
      perf evlist: Add reference count
      perf evsel: Add reference count
      perf evlist: Add reference count checking
      perf parse-events: Restrict core PMU bypass to --cputype option
      perf test: Truncate test description to fit terminal width
      perf tests: Skip metrics validation if system-wide recording lacks permission
      perf tests: Fix Python JIT dump profiling test failure
      perf tests: Add robust record retry helper and use subsecond workloads
      perf tests: Fix flakiness in trace record and replay test
      perf tests: Fix flakiness in BPF counters test on hybrid systems
      perf tests: Fix flakiness in branch stack sampling tests
      perf record: Fix teardown hang on system-wide multi-threaded sessions
      perf jevents: Add more components to the metric sorting order
      perf ui hists: Fix uninitialized stack memory free on pstack allocation failure
      perf cap: Remove used_root parameter and simplify capability checks
      perf ui hists: In report UI ensure thread is set with reference counting
      perf annotate: Be robust to annotating without a thread
      perf script: Fix metric_evlist leak in script_find_metrics
      perf stat: Fix evsel_list leak in cmd_stat
      perf tools: Fix sb_evlist leaks in top and record
      perf python: Fix memory leak in pyrf_evlist__get_pollfd
      perf synthetic-events: Fix uninitialized pthread_join
      perf test: Fix skiplist leak in cmd_test
      perf python: Check counts_values size in set_values
      perf python: Handle Py_None for thread and cpu maps
      perf python: Validate CPU and thread maps in pyrf_evsel__open
      perf python: Validate attribute setters in pyrf_evsel
      perf python: Fix count_values memory leak in pyrf_evsel__read
      perf python: Fix memory leak in pyrf__metrics_cb
      perf synthetic-events: Fix divide by zero in perf_event__synthesize_threads
      perf hists browser: Increase MAX_OPTIONS to prevent stack buffer overflow
      perf ui hists: Fix dso_filter reference leak and exit zoom cleanup
      perf python: Add missed explicit dependencies

Ibrahim Hashimov (1):
      RDMA/rxe: Validate num_sge/cur_sge before indexing wqe->dma.sge[]

Icenowy Zheng (1):
      riscv: dts: thead: th1520: remove pclk for I2C1

Ihor Solodrai (1):
      selftests/bpf: Fix selftest build after filter.h update

Iker Pedrosa (1):
      drm/solomon: remove unneeded variables in blit functions

Ilan Dudnik (1):
      ksmbd: defer publishing granted locks to prevent UAF/double-free race

Ilya Leoshkevich (1):
      s390/irqflags: Add out-of-line definitions of arch_local_irq_*() for KMSAN

Imran Shaik (12):
      clk: qcom: Fix test_ctl_hi field for DEFAULT_EVO PLLs
      arm64: dts: qcom: talos: Fix cpu6 1094.4MHz OPP frequency typo
      clk: qcom: dispcc-qcm2290: Move to the latest common qcom_cc_probe() model
      clk: qcom: dispcc-qcm2290: Enable runtime PM support
      clk: qcom: qcm2290: Set POLL_CFG_GDSCR flag for DISPCC and GPUCC GDSCs
      clk: qcom: qcm2290: Add RETAIN_FF_ENABLE flag for DISPCC and GPUCC GDSCs
      clk: qcom: qcm2290: Update DISPCC and GPUCC GDSC *wait_val values
      clk: qcom: gpucc-qcm2290: Drop pm_clk handling
      clk: qcom: gpucc-qcm2290: Move to the latest common qcom_cc_probe() model
      clk: qcom: gpucc-qcm2290: Keep the critical clocks always-on from probe
      clk: qcom: gpucc-qcm2290: Park RCG's clk source at XO during disable
      arm64: dts: qcom: agatti: Add missing CX power domain to DISPCC

Inochi Amaoto (7):
      riscv: dts: spacemit: Add enough deassert time for the PHY on PICO ITX
      riscv: dts: spacemit: Add enough deassert time for the PHY on com260 board
      riscv: dts: spacemit: Fix phy id check for the phy on pico-itx board
      riscv: dts: spacemit: Fix phy id check for the phy on com260 board
      riscv: dts: spacemit: Make dtschema recognize the etherent PHY correctly on K3 pico-itx board
      riscv: dts: spacemit: Make dtschema recognize the etherent PHY correctly on K3 com260 board
      riscv: dts: sophgo: cv180x: Allow the DMA multiplexer to set channel number for DMA controller

Ismail Tarim (2):
      Bluetooth: btmtk: Do not report success when subsys reset fails
      Bluetooth: btmtk: Do not discard the subsystem reset timeout

Israel Téllez García (1):
      bpf: Fix pending_pos walk on 32-bit ring position wrap

Itai Handler (1):
      rcu: Mark accesses to ->rcu_urgent_qs and ->rcu_need_heavy_qs

Ivy Lopez (1):
      staging: rtl8723bs: use kfree_sensitive() for key material

Jackie Dong (1):
      ALSA: hda/realtek: ALC269 fixup for Yoga/Legion Mic noise

Jackie Liu (1):
      liveupdate: reject nonzero reserved value for SESSION_FINISH

Jacob Moroni (5):
      RDMA/irdma: Deduplicate the irdma_del_memlist logic
      RDMA/irdma: Add a refcount to track user ring MR associations
      RDMA/irdma: Add irdma_cq fields to track pbl allocations
      RDMA/irdma: Add refcounting to user ring MRs
      RDMA/core: Add ib_no_udata_io() helper

Jagadeesh Kona (1):
      clk: qcom: gdsc: Add custom disable callback for GX GDSC

Jakub Kicinski (1):
      i3c: dw: avoid shift-out-of-bounds when DAA assigns no devices

Jamal Hadi Salim (11):
      net: sched: fix 32-bit backlog wrap in gred, bfifo and plug enqueue
      net/sched: account classifier filter allocations to memcg
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

James Clark (2):
      tools/build: Allow versioning of all LLVM tools defined in Makefile.include
      perf: arm_pmuv3: Zero initialize hw_id branch stack field

Jan Kara (5):
      udf: Move udf_map_block() up
      udf: Fix data loss when converting inline inodes to out of line
      ext4: fix spurious message about orphan cleanup on RO fs
      ext4: teach ext4_meta_trans_blocks() about number of allocated extents
      ext4: fix transaction overflow during writeback

Jared.Huang (2):
      wifi: mt76: mt7925: update clc before setting sar power table
      wifi: mt76: mt7925: fix msg len mismatch between driver and firmware

Jason Gunthorpe (1):
      iommufd: Simplify iommufd_device_remove_vdev()

Jason Huang (1):
      wifi: brcmfmac: fix P2P action frame handling without device vif

Jeff Johnson (11):
      wifi: ath6kl: avoid buffer overreads in WMI event handlers
      wifi: ath12k: Correctly copy the hint BSSID in WMI scan request
      wifi: ath11k: Correctly copy the hint BSSID in WMI scan request
      wifi: ath12k: Avoid buffer overread in ath12k_wmi_op_rx()
      wifi: ath11k: Avoid buffer overread in ath11k_wmi_tlv_op_rx()
      wifi: ath12k: fix overreads in ath12k_wmi_process_csa_switch_count_event()
      wifi: ath11k: fix overreads in ath11k_wmi_process_csa_switch_count_event()
      wifi: ath12k: validate TLV length in process_tpc_stats()
      wifi: ath12k: fix stride mismatch in mac_phy_caps_parse()
      wifi: ath11k: fix stride mismatch in mac_phy_caps_parse()
      wifi: ath11k: fix leak in ath11k_service_ready_ext_event()

Jeff Layton (1):
      nfsd: add protocol support for CB_NOTIFY

Jens Glathe (2):
      arm64: dts: qcom: sc8280xp-blackrock: switch to uefi rtc offset
      drm/msm/dp: add missing drm_edid_connector_update() before add_modes on cached EDID

Jens Remus (2):
      x86/cfi: Use symmetric SYM_START and SYM_END in __CFI_TYPE()
      s390/vdso: Pass --eh-frame-hdr to the linker

Jernej Skrabec (12):
      drm/sun4i: Fix V3s YUV scanline size
      drm/sun4i: vi scaler: Fix coefficient selection
      drm/sun4i: vi scaler: Restore opaque alpha in video modes
      drm/sun4i: tcon-top: Keep mixer routes distinct
      drm/sun4i: tcon: Set output mux for DSI and LVDS
      drm/sun4i: tcon: Drop TCON TOP device reference
      drm/sun4i: hdmi: Don't leak sync polarity bits into packet control
      drm/sun4i: crtc: Propagate layer initialization error
      drm/sun4i: tcon: Drop remote endpoint reference
      drm/sun4i: dw-hdmi: Drop TCON TOP port reference
      drm/sun4i: Drop node references while building component list
      drm/sun4i: hdmi-phy: Fix H6 8-bit MPLL config at 594 MHz

Jerome Brunet (1):
      clk: sunxi-ng: mux: fix determine helper rate propagation

Jeuk Kim (1):
      NFSv4/flexfiles: fix NULL dereference for NFSv4.0 data servers

Jia Wang (1):
      PCI: ultrarisc: Get and enable DP1000 PCIe controller clocks

Jia Yang (2):
      mailbox: qcom-cpucp: fix PREEMPT_RT self-deadlock in IRQ handler
      mailbox: qcom-cpucp: handle NULL data in send_data callback

Jian Shen (1):
      net: hibmcge: fix page_pool DMA direction mismatch

Jian-Ming Liao (1):
      i3c: mipi-i3c-hci: Fix missing STAT_IBI_STATUS_THLD in PIO mode

Jiancheng Huang (1):
      HID: lg4ff: validate report length before fixed offsets

Jiangshan Yi (1):
      selftests: timers: leap-a-day: Fix -w option and update usage comment

Jiawei Sun (1):
      perf record: fix poll storm when monitored threads exit

Jiawen Wu (3):
      net: txgbe: fix MISC interrupt unmasking in non-MSI-X mode and device shutdown
      net: libwx: fix concurrent bitmap overwrite in PTP setup
      net: wangxun: use BIT_ULL() to prevent shift overflow on 32-bit archs

Jiayuan Chen (3):
      bpf: Fix mmap_lock deadlock on arena lock failure
      bpf, xdp: move offload check into dev_xdp_install()
      tcp: fix corruption of urgent data on multi-segment retransmit

Jie Gan (1):
      arm64: dts: qcom: monaco: fix wrong connection for the replicator

Jie Zhang (5):
      drm/msm: Recover HW before retire hung submit
      drm/msm/a6xx: Fix A663 GPUCC register list for state capture
      drm/msm/a6xx: Fix A621 GPUCC register list for state capture
      drm/msm/a6xx: Fix IRQ storm during msm_recovery test
      drm/msm: Fix task_struct reference leak in recover_worker

Jijie Shao (1):
      net: page_pool: fix UAF in __page_pool_release_netmem_dma on xa_cmpxchg race

Jingyi Wang (2):
      remoteproc: core: Attach rproc asynchronously in rproc_add() path via schedule_work()
      remoteproc: qcom: pas: Add late attach support for subsystems

Jinjie Ruan (2):
      riscv: kexec_file: Fix crashk_low_res not exclude bug
      powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()

Jiri Olsa (10):
      uprobes/x86: Remove struct uprobe_trampoline object
      uprobes/x86: Do not leak trampoline vma mapping on optimization failure
      uprobes/x86: Allow to copy uprobe trampolines on fork
      uprobes/x86: Move optimized uprobe from nop5 to nop10
      libbpf: Change has_nop_combo to work on top of nop10
      libbpf: Detect uprobe syscall with new error
      bpf: Factor callchain_store function from __bpf_get_stack
      bpf: Factor callchain_finalize function from __bpf_get_stack
      bpf: Remove trace_in argument from __bpf_get_stack
      bpf: Clear buf on error in __bpf_get_task_stack

Joanne Koong (4):
      iomap: split iomap_iter() logic into iomap_iter_next()
      iomap: add ->iomap_next()
      ntfs: convert iomap ops to ->iomap_next()
      fuse: use release/acquire for fch->initialized

Joas Antonio dos Santos (1):
      ipvs: fix integer overflow in ftp helper port/address parsing

Joe Lawrence (1):
      objtool/klp: Normalize Module.symvers paths to module names

Joey Lu (3):
      clk: nuvoton: ma35d1: fix ignored div_u64 return values in PLL freq calculation
      clk: nuvoton: ma35d1: fix PLL_CTL1_FRAC bit field width and fractional calc
      clk: nuvoton: ma35d1: fix ma35d1_clk_pll_determine_rate logic

Johannes Berg (1):
      wifi: mac80211: disconnect on CSA to channel 0

Johannes Thumshirn (3):
      btrfs: zoned: don't force read-only on transient -EAGAIN from reloc merge
      btrfs: zoned: flush active metadata block group at btree_writepages() start
      btrfs: zoned: don't clobber the extent buffer when zeroing it out

John Groves (9):
      dax: fix misleading comment about share/index union in dax_folio_reset_order()
      dax/fsdev: fix multi-range offset in memory_failure handler
      dax/fsdev: clear vmemmap_shift when binding static pgmap
      dax/fsdev: don't leave a dangling dev_dax->pgmap on probe failure
      dax/fsdev: clear pgmap ops and owner on unbind
      dax/fsdev: use __va(phys) for kaddr in direct_access
      dax/fsdev: fail probe on invalid pgmap offset
      dax: read holder_ops once in dax_holder_notify_failure()
      dax: fix holder_ops race in fs_put_dax()

John Hubbard (1):
      gpu: nova-core: clean up FSP FRTS comments

John Johansen (3):
      apparmor: fix unconfined user namespace restriction forced stack
      apparmor: fix deadlock in complain-mode change_hat
      apparmor: policy_int make sure list heads are initialized before fail path

John Keeping (1):
      ALSA: seq: midi: Serialize input teardown with event_input

John Ogness (1):
      printk: Fix possible console use-after-free

Jorijn van der Graaf (1):
      ASoC: qcom: q6apm: keep the graph start count in sync with the DSP

Jose Ignacio Tornos Martinez (1):
      wifi: mt76: mt7996: remove beacon_int_min_gcd from ADHOC interface combinations

Josh Poimboeuf (13):
      objtool/klp: Fix module name normalization for paths with dots
      objtool/klp: Fix false module dependencies caused by dead relocs
      objtool/klp: Add .klp.symid for sympos disambiguation
      objtool/klp: Fix symbol resolution for duplicate data symbols
      arm64: bti: Disable in-kernel BTI with recent versions of Clang
      objtool/klp: Fix vmlinux .klp.symid link error for .no_trim_symbol symbols
      objtool/klp: Fix size of empty special section entries
      objtool/klp: Ignore replacement offset of empty x86 alternatives
      objtool/klp: Fix cross-module klp relocation section naming
      objtool/klp: Don't match local symbols against exports
      objtool/klp: Fix relocations for EXPORT_SYMBOL_FOR_MODULES() symbols
      objtool/klp: Fix .kcfi_traps special section extraction
      objtool/klp: Fix vmlinux klp relocations for EXPORT_SYMBOL_FOR_MODULES()

Joshua Crofts (1):
      nilfs2: fix infinite loop in nilfs_clean_segments()

Joy Zou (1):
      regulator: core: use system_freezable_wq for init complete work

Julian Braha (4):
      media: platform: amd: fix unmet dependency for VIDEO_V4L2_SUBDEV_API
      pinctrl: fix unmet dependencies from missing GPIOLIB
      backlight: ktd2801: Fix unmet dependency on GPIOLIB
      ASoC: fix unmet dependencies on PPC_BESTCOMM and SND_SOC_AC97_BUS

Jun Yan (2):
      arm64: dts: amlogic: meson-axg: Add missing nand_rb0 pin to nand_all_pins
      arm64: dts: amlogic: meson-axg-s400: enable mipi_pcie_analog_dphy for PCIe

Junhui Liu (1):
      riscv: dts: spacemit: k1: Split gmac_clk_ref into independent pinctrl groups

Junjie Cao (1):
      backlight: aw99706: Validate all DT property values consistently

Junrui Luo (2):
      NFSv4.2: fix LAYOUTSTATS send buffer exhaustion
      NFSv4/pnfs: key the data server cache on the NFS version

Junseo Lim (4):
      lwt_bpf: Restore reserved headroom after xmit program
      bpf: Disallow bpf_{g,s}etsockopt() in cgroup UNIX getname hooks
      bpf: Reject negative optlen in cgroup getsockopt hook
      net: kcm: Hold RCU read lock while running BPF parser

Justin Yeh (2):
      pinctrl: mediatek: use devm_gpiochip_add_data() for GPIO chip
      pinctrl: mediatek: free EINT resources on unbind

Jérémy Jean (2):
      NFSv4.1: zero referring call lists before decoding
      crypto: acomp - allocate async request context when cloning

Jérôme de Bretagne (1):
      arm64: dts: qcom: sc8280xp-arcata: Fix top USB-C DP alt mode

K Prateek Nayak (1):
      cpufreq/amd-pstate: Set min_limit_freq based on bios_min_perf

Kamal Wadhwa (1):
      regulator: qcom-rpmh: Fix PMIC5 BOB bypass mode handling

Karl Mehltretter (23):
      tty: hvc: restrict HVC_DCC to ARMv6+ and ARM64
      ARM: lpc32xx: only run SoC init on LPC32xx hardware
      dcache: keep shrink_dcache_for_umount() making progress on busy roots
      arm64/fpsimd: ptrace: Fix inactive SVE and SSVE regsets
      kselftest/arm64: fp-ptrace: Fix checks for inactive SVE and SSVE regsets
      serial: amba-pl011: unprepare console clock on unregister
      serial: amba-pl011: keep console clock enabled for atomic writes
      serial: core: do fallible allocations before the console can be registered
      serial: core: clear freed pointers on uart_register_driver() failure
      tty: skip cdev_del() when no cdev is registered
      tty: clear cdev pointer after cdev_add() failure
      ARM: 9483/1: select HAVE_POSIX_CPU_TIMERS_TASK_WORK
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

Kazuma Kondo (1):
      ACPI: PCI: Avoid misleading _OSC messages for non-PCIe host bridges without _OSC

Keith Busch (1):
      block: fix dio leak on metadata mapping error

Kemeng Shi (3):
      irqchip/gic-v3-its: Fix memleak in its_probe_one()
      irqchip/gic-v3-its: Fix its node leak in gic_acpi_parse_madt_its()
      irqchip/gic-v3-its: Prevent leak in its_vpe_irq_domain_alloc()

Kohei Enju (2):
      virt: arm-cca-guest: use migrate_disable() for attestation token requests
      arm64: RSI: fix field-spanning write warning in attestation token init

Koichiro Den (4):
      dmaengine: dw-edma: Terminate all descriptors without callbacks
      dmaengine: dw-edma: Serialize abort state updates
      dmaengine: dw-edma: Serialize channel state checks
      dmaengine: dw-edma: Clear stale requests on termination

Komal Bajaj (1):
      pinctrl: qcom: shikra: Fix intr_target_width for summary interrupt routing

Konrad Dybcio (15):
      arm64: dts: qcom: hamoa: Fix clocks for HSPHYs
      arm64: dts: qcom: sc8180x-primus: Rename regulator nodes
      arm64: dts: qcom: sc8180x-primus: Describe the display power net
      arm64: dts: qcom: sc8180x-lenovo-flex-5g: Rename regulator nodes
      arm64: dts: qcom: sc8180x-lenovo-flex-5g: Describe the display power net
      arm64: dts: qcom: msm8996-xiaomi-gemini: Fix up ti,drv2604 enable GPIO
      arm64: dts: qcom: msm8998: Don't pull-up I2C pins by default in sleep
      arm64: dts: qcom: msm8976-longcheer-l9360: Fix accidental node override
      arm64: dts: qcom: sdm632-motorola-ocean: Fix LED default trigger property
      soc: qcom: pmic_glink_altmode: Define the TBT extradata properly
      arm64: dts: qcom: sc8280xp-crd: Fix the pin index for misc_3p3_reg_en
      arm64: dts: qcom: glymur: Fix PDC IRQ mapping
      drm/msm/dpu: Drop sneaky dev_pm_opp_set_rate(0)
      drm/msm/dp: Drop dev_pm_opp_set_rate(0)
      drm/msm/dsi: Drop dev_pm_opp_set_rate(0)

Konstantin Andreev (3):
      smack: fix incorrect task context in smack_msg_queue_msgrcv
      smack: deduplicate smackfs/{direct,mapped} file_operations
      smack: restrict smackfs/{direct,mapped} values to 0-255

Konstantin Komarov (1):
      fs/ntfs3: fix out-of-bounds read in read_log_rec_buf()

Kostas Damaskinakis (1):
      clk: eswin: Zero-initialize stack-allocated clk_init_data

Krishna Chaitanya Chundru (2):
      PCI/ASPM: Use pcie_capability_clear_and_set_word() for ASPM disable/restore
      PCI/ASPM: Disable/restore ASPM on every function for multi-function devices

Krishna Kurapati (1):
      arm64: dts: qcom: qcs404: Fix DTBS Check errors in usb controller nodes

Krystian Kaniewski (1):
      ocfs2: fix circular locking dependency in ocfs2_init_acl()

Krzysztof Kozlowski (1):
      arm64: dts: qcom: talos: Fix GMU unit address

Krzysztof Wilczyński (2):
      PCI/sysfs: Return -EINVAL for unsupported I/O BAR mmap
      PCI/sysfs: Add lockdown checks to legacy I/O and memory handlers

Kuldeep Singh (1):
      arm64: dts: qcom: sm8750: wire UFS to ice instance

Kumar Kartikeya Dwivedi (4):
      bpf: Zero queue and stack outputs on lock failure
      bpf: Fix offset warn check for bpf_res_spin_lock
      bpf: Preserve unique-field state across nested structs
      bpf: Mark bpf_refcount field as unique

Kuniyuki Iwashima (1):
      amt: Don't support cross-netns setup.

Kyle Zeng (1):
      hfsplus: validate thread record before delete key rebuild

Lad Prabhakar (4):
      arm64: dts: renesas: rzt2h-n2h-evk: Remove unused MII/GMII pins
      arm64: dts: renesas: r9a09g056: Fix PCIe dma-ranges memory space code
      arm64: dts: renesas: r9a09g047: Fix PCIe dma-ranges memory space code
      phy: renesas: rcar-gen3-usb2: Ignore missing VBUS regulator

Laxman Acharya Padhya (2):
      drm/panel: samsung-s6d16d0: Power off on prepare failure
      firmware: coreboot: Validate table bounds

Leo Martins (2):
      btrfs: abort transaction before releasing tree_log_mutex on commit failure
      btrfs: replace writeback inhibition xarray with a fixed inline buffer

Leo Yan (5):
      perf cs-etm: Fix thread leaks on trace queue init failure
      perf cs-etm: Filter synthesized branch samples
      perf cs-etm: Flush thread stacks after decoder reset
      perf cs-etm: Avoid truncating AUX buffer sizes to int
      perf: arm_spe: Make wakeup range check overflow safe

Leon Hwang (7):
      bpf: Copy per-CPU map value padding in copy_map_value_long()
      bpf: Mark tracing_multi trampolines as ftrace managed
      bpf: Disallow interpreter fallback for arena-related insns
      bpf: Disallow interpreter fallback for gotox insn
      bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU insn
      bpf: Fix WARNING in bpf_tracing_link_release
      bpf: Fix sleepable check for tracing/lsm prog

Leon Romanovsky (17):
      RDMA/core: Wait for RCU callbacks before unloading ib_core
      RDMA/mlx5: Drain RCU callbacks during module teardown
      RDMA/ipoib: Drain RCU callbacks during module teardown
      RDMA/rvt: Return NULL after port allocation failure
      RDMA/hfi1: Preserve unit 0 on allocation failure
      RDMA/hfi1: Free RX data on late probe failure
      RDMA/hfi1: Stop flushing the global IB workqueue
      RDMA/hfi1: Initialize debugfs after probe completes
      RDMA/bnxt_re: Validate udata before executing commands
      RDMA/srpt: Pass the mapped task attribute to target_init_cmd()
      RDMA/mana_ib: drain QP references after partial table insertion
      RDMA/erdma: complete object teardown when the destroy command fails
      RDMA/cxgb4: Fix dereg_skb leak and double free in write_tpt_entry()
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

Li Jun (1):
      firmware: imx: sm-misc: Add NULL check for kmalloc in syslog_show

Li Ming (1):
      cxl/test: Rework cxl_type2_mem_init() to use cxl_mock_platform_device_add()

Li Qiang (5):
      scsi: ufs: core: Validate string descriptors
      scsi: ufs: Avoid NULL CQE dereference when reporting invalid tags
      scsi: ufs: core: Validate connected lane counts
      scsi: ufs: rpmb: Validate request frame length before parsing
      scsi: ufs: debugfs: Reserve space for a string terminator

Li RongQing (3):
      iommu/amd: Fix undefined behavior in devid_write debugfs function
      virtio_pci: fix wrong queue index for admin vq in intx path
      vdpa/mlx5: fix wrong list iterated in add_direct_chain error path

Li, Yifan (1):
      powercap: intel_rapl: Sign-extend the PMU delta on counter wraparound

Liam R. Howlett (Oracle) (2):
      maple_tree: catch race in mas_alloc_cyclic()
      maple_tree: fix argument name in header

Liang Hao (1):
      hrtimer: Account nr_retries on recovered interrupt retries

Liang Luo (4):
      selftests/sched_ext: Fix bpf_link leak on early return in prog_run
      tools/sched_ext: scx_flatcg: Fix uninitialized stats on allocation failure
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

Linmao Li (14):
      platform/x86: asus-wireless: Fail probe when there is no ACPI match
      platform/mellanox: mlxbf-pmc: Check ACPI_COMPANION() against NULL
      platform/surface: acpi-notify: Check ACPI companion before use
      ppdev: prevent overflow when setting port timeout
      ASoC: meson: Keep link pointers valid on realloc failure
      crypto: keembay - Initialize completion before requesting IRQ
      platform: arm64: qcom-hamoa-ec: reject incomplete responses
      Bluetooth: hci_conn: fix the SCO setup context lifetime
      Bluetooth: hci_sync: free the advertising instance on the failure and cancel paths
      Bluetooth: MGMT: free the mesh send cancel command when it is cancelled
      Bluetooth: MGMT: free the HCI command when it is cancelled
      nfc: digital: Do not dump a NULL response in command completion
      HID: tmff: Use 64-bit arithmetic for force feedback scaling
      mailbox: rockchip: disable pclk on probe failure and unbind

Linus Walleij (1):
      ARM: 9481/2: breakpoint: CFI breakpoints only on demand

Loic Poulain (5):
      clk: qcom: gcc-qcs8300: Use retention for PCIe power domains
      clk: qcom: gcc-qcs8300: Use retention for USB power domains
      phy: qcom: qmp-usb-legacy: Fix possible NULL-deref on early runtime suspend
      phy: qcom: snps-femto-v2: Fix possible NULL-deref on early runtime suspend
      phy: qcom: qmp-usb: Fix possible NULL-deref on early runtime suspend

Long Li (1):
      net: mana: Cap MSI-X vectors to the device MSI-X table size

Lorenzo Bianconi (2):
      net: airoha: fix ETS QoS stats counter underflow and cross-channel corruption
      net: stmmac: drop gso_enabled_types and rely on netdev features

Lorenzo Pieralisi (10):
      ACPI: RISC-V: Fix riscv_acpi_irq_get_dep() loop termination
      ACPI: RISC-V: Check acpi_get_handle() status in riscv_acpi_add_prt_dep()
      ACPI: RISC-V: Fix riscv_acpi_add_prt_dep() loop handling
      irqchip/gic-v5: Check get_logical_index() return value in MADT IAFFID parsing
      irqchip/gic-v5: Check for NULL LPI domain on domain teardown
      irqchip/gic-v5: Disable IRSes on probe failures
      irqchip/gic-v5: Fix gicv5_init_common() error paths
      irqchip/gic-v5: Release IRS iomem region on driver init failure
      irqchip/gic-v5: Use logical cpu 0 irs_data for dynamic IST allocation
      irqchip/gic-v5: Defer default SPI and LPI IAFFID programming

Lorenzo Stoakes (ARM) (1):
      mm/mremap: reset unfaulted VMA page offset for MREMAP_DONTUNMAP

Lothar Rubusch (1):
      crypto: atmel-sha204a - fix heap info leak on I2C transfer failure

Louis-Alexis Eyraud (1):
      clk: mediatek: pllfh: Fix IO remapping leak in register_pllfhs error path

Lu Baolu (4):
      iommu/vt-d: Clear Present bit before tearing down copied context entry
      iommu/vt-d: Fix iopf_refcount leak on RID domain replacement
      iommu/vt-d: Tear down scalable-mode context on probe failure
      iommu/vt-d: Flush context cache with correct SID when tearing down aliases

Luca Weiss (2):
      arm64: dts: qcom: sm7225-fairphone-fp4: Fix address in fb node name
      arm64: dts: qcom: milos: Add reset for sdhc_2

Madhavan Srinivasan (1):
      powerpc64/bpf: Fix build break in bpf_jit_emit_func_call_rel()

Mahanta Jambigi (3):
      net/smc: hash socket only after full initialisation in smc_sk_init()
      net/smc: free stashed qentry before overwrite in REQ_ADD_LINK to ADD_LINK transition
      net/smc: free pending qentry in smc_llc_flow_stop() before memset

Maher Azzouzi (1):
      esp: do not unref managed frag pages in esp_ssg_unref()

Maher Sanalla (1):
      RDMA/mlx5: Fix integer overflow of user QP buffer size

Malaya Kumar Rout (4):
      selftests/bpf: Fix memory leak in msg_alloc_iov error path
      timers/migration: Fix memory leak in tmigr_setup_groups() error path
      time/namespace: Validate nanosecond field in proc_timens_set_offset()
      PM: hibernate: Fix memory leak in snapshot_write_next() error path

Manish Dharanenthiran (1):
      wifi: ath12k: advertise ieee_link_id in vdev start MLO params

Manish Rangankar (1):
      scsi: qla2xxx: Remove redundant VPD flash read in sysfs read path

Manivannan Sadhasivam (54):
      PCI: qcom: Skip PERST# GPIOs provided by downstream PCIe devices
      PCI/pwrctrl: tc9563: Fix parsing the integrated Ethernet MAC Endpoint node
      PCI/pwrctrl: tc9563: Power off only the external ports in tc9563_pwrctrl_disable_port()
      bus: mhi: host: Flush the posted write after writing to MHI_SOC_RESET_REQ_OFFSET
      PCI: dwc: ep: Clear MSI iATU mapping in dw_pcie_ep_cleanup()
      arm64: dts: qcom: kaanapali: Fix the PCIe iommu-map entries
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
      arm64: dts: qcom: monaco: Fix the PCIe iommu-map entries
      arm64: dts: qcom: monaco-monza-som: Fix the PCIe iommu-map entries
      arm64: dts: qcom: monaco-evk-ifp-mezzanine: Fix the PCIe iommu-map entries
      arm64: dts: qcom: lemans-evk-ifp-mezzanine: Fix the PCIe iommu-map entries
      arm64: dts: qcom: qcs6490-radxa-dragon-q6a: Fix the PCIe iommu-map entries
      arm64: dts: qcom: qcs6490-thundercomm-minipc-g1iot: Fix the PCIe iommu-map entries
      arm64: dts: qcom: qcs6490-rb3gen2: Fix the PCIe iommu-map entries
      arm64: dts: qcom: qcs6490-rb3gen2-industrial-mezzanine: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sc8280xp-blackrock: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sa8540p: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sdm845: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sdm850: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sm8150: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sm8250: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sm8350: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sm8450: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sm8550: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: qcs8550-aim300: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: qcm6490: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: qcs6490: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sm7225-fairphone-fp4: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sc7180: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sc7280: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sc8180x: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: hamoa: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: purwa: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sm8650: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sm8750: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sar2130p: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: kaanapali: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: glymur: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: lemans: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: eliza-mtp: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: sa8155p-adp: Fix swapped USB and UFS QMP PHY vdda-phy/vdda-pll supplies
      arm64: dts: qcom: talos-evk: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies

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

Marco Elver (2):
      kcsan: avoid unintended access checking in NMIs
      arm64: Disable KCSAN instrumentation in delay.o

Marco Scardovi (3):
      platform/x86: asus-wmi: fix resource leaks on probe failure
      cpufreq/amd-pstate: Fix EPP return type and handle errors during initialization
      cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory systems

Marek Czernohous (1):
      forcedeth: stop the tx_timeout register dump past the requested window

Marek Marczykowski-Górecki (1):
      xen/xenbus: check otherend_id only after it has been initialized

Marek Szyprowski (1):
      clocksource/drivers/samsung_pwm: Switch to raw_spinlock_t type

Mario Rugiero (1):
      regulator: tps65185: wait for the IC to wake before the first I2C access

Marius Cristea (1):
      hwmon: (emc1403) Drop hysteresis for low limit temperature

Mark Bloch (1):
      net/mlx5: E-Switch, use state lock for vport state changes

Mark Brown (2):
      kselftest/arm64: Don't write to P0 in irritator on SME only systems
      tools: Ensure tools copy of linux/filter.h exports the UAPI

Markus Stockhausen (3):
      irqchip/irq-realtek-rtl: Split out parent setup code
      irqchip/irq-realtek-rtl: Add interrupt data structure
      irqchip/irq-realtek-rtl: Add mask for interrupt handling

Martin Kaiser (1):
      tracing/probes: ignore id update from btf_type_skip_modifiers

Martin Wilck (1):
      md/raid1: create serial pool adding rdev to array with serialize_policy=1

Masami Hiramatsu (Google) (1):
      tracing/probes: Fix BTF kflag check for anonymous struct member access

Mathieu Dubois-Briand (1):
      clk: ti: mux: resolve parent clocks by DT index, not by name

Matthew Leach (1):
      wifi: ath12k: fix survey indexing across bands

Matthew Wilcox (Oracle) (4):
      ntfs: Inline zero_partial_compressed_page()
      ntfs: Remove use of __folio_index in handle_bounds_compressed_page()
      ntfs: Use zero_user_segment() in handle_bounds_compressed_page()
      ntfs: Remove references to page->__folio_index

Matti Vaittinen (5):
      power: supply: bd71815: Fix temperature reading
      power: supply: bd71828: Fix current direction
      power: supply: bd71828: Drop duplicate power-supply property
      power: supply: bd71828: Do not hide errors
      power: supply: bd99954: Drop bad register fields

Maurizio Lombardi (1):
      nvmet: fix max_qid race between configfs and controller allocation

Maxim Khmelevskii (1):
      s390/bpf: Replace ly instruction with llgf

Maxime Chevallier (7):
      net: stmmac: selftests: Pass the IP proto mask in the TC selftest
      net: stmmac: selftests: Check multiple MMC counters
      net: stmmac: dwmac1000: Account for the primary MAC address for UC filtering
      net: stmmac: dwmac4: Account for the primary MAC address for UC filtering
      net: stmmac: dwxgmac: Account for the primary MAC address for UC filtering
      net: stmmac: selftests: Account for the UC filter list for filtering tests
      net: stmmac: selftests: Don't test flow control for small rx fifos

Maxime Ripard (3):
      drm/atomic: Drop drm_private_obj.state assignment from create_state
      drm/bridge: cdns-dsi: Return an error pointer on allocation failure
      drm/bridge: cdns-mhdp8546: Return an error pointer on allocation failure

Maximilian Immanuel Brandtner (1):
      tls: fix RX desync on overlapping skbs

Maíra Canal (8):
      drm/v3d: Clear queue->active_job when v3d_fence_create() fails
      drm/v3d: Drop unused drm_encoder.h include from v3d_drv.h
      drm/v3d: Extract v3d_job_add_syncobjs() helper
      drm/v3d: Migrate BO reservation locking to DRM exec
      drm/v3d: Introduce struct v3d_submit and convert CL/TFU/CSD ioctls
      drm/v3d: Make v3d_get_cpu_indirect_csd_params() a pure parser
      drm/v3d: Convert submit helpers to operate on struct v3d_submit
      drm/v3d: Associate BOs with every job that accesses them

Meghana Malladi (1):
      arm64: dts: ti: k3-am64: Fix MDIO clock reference for ICSSG0 node

Mert Seftali (2):
      ASoC: SOF: ipc4-topology: Return error for invalid number of formats
      iio: accel: dmard09: Implement IIO_CHAN_INFO_SCALE

Miaoqing Pan (2):
      wifi: ath12k: fix TLV32 length mask
      wifi: ath12k: fix ML-STA authentication timeout on QCC2072

Michael Bommarito (2):
      HID: roccat: bound device-supplied profile index
      usb: gadget: configfs: fix out-of-bounds read of qw_sign

Michael Byczkowski (1):
      pps: pps-gpio: split IRQ handler into hardirq timestamper + threaded handler

Michael Kelley (1):
      Drivers: hv: vmbus: Skip VMBus module cleanup for non-nested root partition

Michael Liang (1):
      perf libdw: Fix outer-frame name resolution and spurious "(inlined)" tag

Michael Nemanov (1):
      nfs: fix ENXIO on O_CREAT open of existing symlink over NFSv3

Michael Pesa (1):
      irqchip/ast2700-intc: Disable all interrupt merge banks on probe

Michael S. Tsirkin (1):
      virtio_balloon: disable indirect descriptors

Michael Walle (1):
      powerpc/configs: enable CONFIG_RAS to fix EDAC support

Michael-CY Lee (2):
      wifi: mt76: fix non-AQL packet accounting for MLO stations
      wifi: mt76: assign link_id when sending probe request during scan

Michal Blaszczyk (1):
      selftests/sched_ext: Fix flaky ddsp failure tests on busy systems

Mika Westerberg (2):
      thunderbolt: stream: Restore consumer if copying from iter fails
      thunderbolt: stream: Fix possible short reads/writes

Mike Rapoport (Microsoft) (1):
      selftests/mm: thuge-gen: fix test_shmget() for PAGE_SIZE check

Mikhail Kshevetskiy (11):
      pinctrl: airoha: fix mdio bitfield names
      pinctrl: airoha: an7581: fix pinconf of i2c_scl/i2c_sda pins
      pinctrl: airoha: an7583: fix I2C0_SDA_PD register bit order
      pinctrl: airoha: an7581: fix mux/conf of pcie_reset pins
      pinctrl: airoha: an7583: fix muxing of non-gpio default pins
      pinctrl: airoha: an7583: fix spi group pins
      pinctrl: airoha: add missed get_direction() function for gpio_chip
      pinctrl: airoha: fix getting gpiochip/pinctrl pointers in the IRQ handling code
      pinctrl: airoha: add missed IRQ resource helpers
      pinctrl: airoha: fix IRQ mask/unmask code
      pinctrl: airoha: fix edge-triggered interrupts handling

Mikko Perttunen (3):
      gpu: host1x: Avoid double device_add when clients already present
      gpu: host1x: Fix offset calculation in trace_write_gather
      gpu: host1x: Avoid stack over-read in debug output helpers

Miklos Szeredi (1):
      fuse: move "epoch" from dentry.d_time to fuse_dentry.epoch

Min zhang (1):
      clk: hisilicon: reset: Use devm_kzalloc to initialize hisi_reset_controller

Mina Almasry (2):
      net: tcp: block mixing readable and unreadable frags
      net: core: check skb_frags_readable before uncloning in skb_copy_ubufs

Miquel Raynal (DAVE) (1):
      mtd: rawnand: pl353: Fix debug prints

Mohammad Abu-Khader (1):
      kunit: tool: fix _list_tests filtering wrong variable when list has TAP prefix

Mohd Ayaan Anwar (1):
      phy: qcom: sgmii-eth: vote for both voltage rails with correct current loads

Mohsin Bashir (1):
      selftests: drv-net: Test queue stall upon reconfig

Muhammad Bilal (1):
      staging: sm750fb: fix mono image source stride mismatch in lynxfb_ops_imageblit()

Muhammad Usama Anjum (6):
      misc: sgi-gru: remove interrupt-context page-table walks
      selftests/mm: unpoison pages in memory-failure teardown
      selftests/mm: skip COW tmpfile cases when fallocate() is unsupported
      selftests/arm64: Print missing MTE TAP headers
      selftests/arm64: Treat KSM merge_across_nodes as optional
      selftests/arm64: Fix MTE prctl TAP plan

Mukesh Kumar Chaurasiya (IBM) (3):
      dma-resv: Fix undefined symbol when CONFIG_DMA_SHARED_BUFFER is disabled
      powerpc/syscall: Fix syscall skip handling for seccomp and ptrace
      rust: uapi: replace direct asm-generic/ioctl.h include with linux/ioctl.h

Mukesh Ojha (6):
      iommu/qcom: Fix inverted fault report check in qcom_iommu_fault()
      firmware: qcom: scm: Fix NULL dereference in IRQ handler before __scm is published
      firmware: qcom: scm: Fix reserved memory cleanup on probe failure
      firmware: qcom: scm: Fix tzmem state on probe retry
      remoteproc: fix OOB read via signed offset in rsc_table_for_each_entry()
      firmware_loader: do not queue completed sysfs fallback requests

Myeonghun Pak (8):
      clk: versaclock7: Fix APLL clock leak on probe failure
      hwrng: omap - Fix probe error path cleanup
      crypto: keembay - Fix AEAD unregister count in error path
      char: xilinx_hwicap: unregister class on init errors
      RDMA/erdma: Fix CEQ tasklet use-after-free on removal
      clk: mediatek: mt6735: Unregister PLLs on probe failure
      clk: palmas: Manage external-control prepare with devm
      fbdev: tdfxfb: fix PCI enable cleanup with pcim_enable_device()

Mykyta Yatsenko (2):
      bpf: Fix CFI mismatch in task work callback
      bpf: Fix arm64 KASAN false positive after bpf_throw

Namhyung Kim (6):
      perf sched: Add missing perf_session__delete()
      perf sched: Fix memory leaks in perf sched stats report
      perf sched: Free subcommand string after perf sched stats
      perf stat: Fix duplicate output with --for-each-cgroup
      perf build: Fix compiler errors with old capstone
      perf build: Fix a build error on 32-bit x86

Namjae Jeon (28):
      ksmbd: fix maximum allowed access checks
      exfat: fix valid_size extension over a shared writable mapping
      ksmbd: do not advertise unimplemented CA support
      ksmbd: free preauth sessions on connection teardown
      ksmbd: support access-based directory enumeration
      ksmbd: retain connection for pending notify work
      ksmbd: add SMB3 request replay support
      ksmbd: serialize oplock close with pending break ownership
      ksmbd: recognize replayed SMB2 lock sequences
      ksmbd: safely discard unregistered deferred locks
      ksmbd: detach blocked lock requests before freeing
      ksmbd: validate SMB2 write offsets
      ksmbd: expire SMB sessions when Kerberos tickets expire
      ksmbd: fix encrypted request lookup on bound channels
      ksmbd: scope session state changes to bound connections
      ksmbd: disconnect on SMB3 decryption failure
      ksmbd: decrypt requests from expired encrypted sessions
      ksmbd: handle encrypted compressed requests
      ksmbd: add procfs monitoring for active shares
      ntfs: validate final EA attribute size
      ntfs: remove empty EA attribute pair
      ntfs: rewrite EA stream before updating metadata
      ntfs: fix kmap_local_page() usage in compress
      ntfs: apply Windows name checks only with windows_names
      ntfs: respect per-file chmod mode over mount masks
      ntfs: allow index root relocation
      smb: server: remove unused DES crypto header
      ksmbd: prevent out-of-bounds reads in share config responses

Narasimharao Vadlamudi (1):
      crypto: aspeed - Propagate platform_get_irq() errors

Naveen Kumar Chaudhary (2):
      locking/lockdep: Fix NULL pointer dereference in __lock_set_class()
      module: use strscpy() to copy module names in stats and dup tracking

Naveen Mamindlapalli (1):
      octeontx2-af: Fix TL3/TL2 link config ENA clearing

Nguyen Dinh Phi (2):
      vsock: don't check the listener's sk_err in vsock_accept()
      vsock: use sock_error() to consume sk_err after a failed connect

Nicholas Dudar (3):
      bpf: Reject writes through untrusted BTF pointers
      bpf: Reject rdonly/rdwr_buf_size kfunc arguments that exceed u32 max
      bpf: Require a BPF cpumask for bpf_cpumask_populate()

Nicolas Frattaroli (3):
      drm/display: hdmi-state-helper: Try subsampling in mode_valid
      drm/rockchip: vop2: Add RK3576 to the RG swap special case
      drm/rockchip: vop2: Recognise 10-bit YUV422 as YUV format

Nicolin Chen (8):
      iommu/arm-smmu-v3: Declare eats_s1chk and eats_trans as host-endian u64
      iommu/tegra241-cmdqv: Publish an LVCMDQ only after it is fully initialized
      iommu/tegra241-cmdqv: Synchronize the error ISR against VINTF (de)init
      iommu/tegra241-cmdqv: Don't run the error ISR before probe sets up vintfs
      iommu/tegra241-cmdqv: Don't fall back to a freed smmu after devm_krealloc()
      iommu/tegra241-cmdqv: Free the error IRQ before tearing down VINTFs
      iommu/tegra241-cmdqv: Require exactly one Stream ID for a vSID
      iommu/tegra241-cmdqv: Fix VINTF0 leak on the init-failure path

Nikhil Gautam (2):
      iio: light: gp2ap002: Fix unbalanced runtime PM on repeated event writes
      iio: light: gp2ap002: re-enable irq if runtime suspend fails

Niklas Cassel (4):
      misc: pci_endpoint_test: Check SUCCESS bit for doorbell status
      PCI: dwc: ep: Flush cached MSI write before unmapping the iATU
      PCI: dwc: ep: Fix unmap potentially unmapping the wrong iATU
      null_blk: serialize configfs attribute updates with device setup

Nikolay Aleksandrov (3):
      net: bridge: vlan: fix inverted default vlan notification
      net: bridge: arp/nd proxy: fix reading neigh ha
      vxlan: fix reading neigh ha

Nikolay Kulikov (1):
      mlxbf-bootctl: fix the build error with FIELD_PREP()

Ning Ding (2):
      bpf: Invalidate RCU pointers after final spin unlock
      bpf: Compare iterator types during state pruning

Nitin Gote (1):
      drm/xe: don't WARN on kernel job timeout when device already wedged

Nuno Sá (1):
      usb: gadget: f_fs: Fix fence cleanup in ffs_dmabuf_transfer() error paths

Ojaswin Mujoo (1):
      erofs: fix unused pcluster_pools for higher page sizes

Ondrej Jirman (1):
      arm64: dts: allwinner: sun50i-a64-pinephone: Fix mpu6050 mount matrix

Ondrej Mosnacek (1):
      perf test amd ibs: avoid using executable heap

Onur Özkan (1):
      clk: devres: fix cleanup in devm_clk_get_optional_enabled_with_rate()

Or Har-Toov (2):
      net/mlx5: Move vport DOWN state check out of mlx5_query_vport_max_tx_speed()
      net/mlx5: E-Switch, preserve max tx speed on vport state modification

Osama Abdelkader (1):
      drm/panthor: return PTR_ERR() from devm_drm_dev_alloc()

Pablo Neira Ayuso (5):
      netfilter: nft_ct: move custom expectation support to helper
      netfilter: ctnetlink: do not expose expectation DEAD flag
      netfilter: nf_tables: move hardware offload step after building the chain blob
      netfilter: x_tables: replace pr_{info,err}() by pr_info_ratelimited()
      netfilter: nf_tables: skip double clone set expressions on element insert

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

Pauli Virtanen (5):
      Bluetooth: L2CAP: use proto_lock for l2cap_data to fix l2cap_disconn_ind
      Bluetooth: L2CAP: access chan->conn safely in get/setsockopt
      Bluetooth: L2CAP: reject accept queue add unless BT_LISTEN
      Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen() vs. put_chan
      Bluetooth: hci_sync: add conditional locking annotations

Pavel Begunkov (1):
      tcp: reject non zerocopy devmem tx

Pavel Shpakovskiy (1):
      Bluetooth: mgmt: fix 'hdev->discovery.uuids' NULL dereference

Pavel Zhigulin (1):
      speakup: keyhelp: guard letter_offsets possible out-of-range indexing

Pawan Gupta (1):
      x86/bugs: Don't use cpu-type matching in cpu_vuln_blacklist

Pei Xiao (1):
      ipack: ipoctal: fix UAF, null-ptr-deref, and use-after-free in cleanup on remove

Peiyang He (1):
      RDMA/rxe: Fix UAF in ODP init error-handling path

Pengpeng Hou (22):
      wifi: rtw89: fix HE extended capability length check
      crypto: sa2ul - stop probe if context pool creation fails
      hwrng: xilinx-trng - propagate timeout before any data is read
      crypto: rk3288 - fail ahash requests on HASH idle timeout
      RDMA/bng_re: return a timeout when firmware responses stall
      usb: typec: ucsi: gaokun: unwind notifier on UCSI register failure
      soc: qcom: rpmh-rsc: manage PM notifiers with devres
      bus: qcom-ebi2: use managed resources for clocks and children
      pmdomain: bcm: bcm2835: handle genpd provider registration errors
      misc: ad525x_dpot: use driver core groups for sysfs files
      misc: lan966x_pci: depopulate children on populate failure
      soc: ti: knav_qmss: Remove debugfs file on teardown
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

Pengyu Luo (1):
      arm64: dts: qcom: sc8280xp-x13s: Fix the drive-strength of mclk pin

Peter Chiu (2):
      wifi: mt76: mt7996: fix MLD ID in MAC TXD and HIF TXP
      wifi: mt76: fix queue assignment for disassoc packets

Peter Oberparleiter (1):
      s390/debug: Fix deadlock during unregister

Peter Ujfalusi (1):
      ASoC: tas675x: sort the register default table

Peter Zijlstra (1):
      sched/core: Fix inter-class wakeup_preempt()

Petr Oros (2):
      ice: clear the default forwarding VSI rule when releasing a VSI
      dpll: fix NULL deref in dpll_device_ops() during teardown race

Petr Pavlu (2):
      module/dups: Inform duplicate requests about the result directly
      module/dups: Fix use-after-free in kmod_dup_req lifetime handling

Philipp Weber (1):
      HID: core: quiesce input in hid_hw_stop() to prevent use-after-free

Philipp Zabel (1):
      arm64: dts: imx8mp-frdm: Add missing HDMI DDC pinctrl

Phillip Lougher (1):
      Squashfs: check block offset is not negative

Pisit Preechapramoth (1):
      ntfs: reject unprivileged writes to reserved $LX* xattrs

Prabu Thayalan (1):
      ionic: fix completion descriptor access with 2x desc size

Pradyot Kumar Nayak (2):
      arm64: dts: glymur-crd: Add reset GPIO to touchscreen node
      arm64: dts: qcom: glymur-crd: Add FocalTech ft3d81 touchscreen support

Pranjal Shrivastava (1):
      iommu/arm-smmu-v3: Convert to use atomic poll timeout

Prathamesh Shete (1):
      pinctrl: tegra264: fix DAP2 DIN/DOUT pin assignment

Praveen Talari (2):
      spi: qcom-geni: Fix missing error check on pm_runtime_get_sync()
      spi: geni-qcom: Fix sticky ret causing wrong return value on invalid proto

Priya Bala Govindasamy (2):
      rust: cpufreq: Add CPUFREQ_TABLE_END as last table entry in TableBuilder::to_table
      rust: cpufreq: Fix temporary write in Registration::bios_limit_callback

Przemyslaw Korba (1):
      ice: fall back to SBQ when LL PHY timer interface times out

Pu Lehui (8):
      bpf: Sync tail_call_reachable with callee state on entry
      riscv, bpf: Fix memory leak in bpf_jit_free
      riscv, bpf: Fix kernel stack corruption in tailcall with CFI
      bpf: Fix potential UAF in bpf_netns_link_update_prog
      bpf: Fix potential UAF when reading bpf link info
      bpf, cgroup: Fix invalid storage access after __cgroup_bpf_attach failed
      bpf, cgroup: Fix storage null-ptr-deref after replacing prog
      riscv, bpf: Fix missing sign-ext for signed 1-byte and 2-byte kfunc args

Puranam V G Tejaswi (1):
      drm/msm/a6xx: Fix RBBM_CLOCK_CNTL3_TP0 value in a730_hwcg

Puranjay Mohan (2):
      objtool/klp: Fix vmlinux .klp.symid link error for .exitcall.exit symbols
      bpf, arm64: Fix stack-passed arguments for indirect trampolines

Qiang Yu (1):
      drm/amdgpu: read TRUNCATE_COORD_MODE on gfx12

Qianheng Peng (1):
      cpufreq: amd-pstate-ut: Skip tests when amd-pstate driver is not active

Qing Ming (1):
      usb: gadget: uac: validate rate list length before storing

Qingfang Deng (1):
      pppox: drain queued packets on channel handoff

Qingshuang Fu (1):
      irqchip/renesas-irqc: Fix generic interrupt chip leak on remove

Qu Wenruo (4):
      btrfs: always wait for ordered extents to avoid OE races
      btrfs: make sure EXTENT_BUFFER_READING is cleared under refs_lock
      btrfs: use aligned range for locking in extent_fiemap()
      btrfs: qgroup: fix a wrong length calculation in qgroup_free_reserved_data()

Radek Podgorny (1):
      Bluetooth: do not leak an hci_conn when a second LE connect is rejected

Rafael J. Wysocki (9):
      cpufreq: intel_pstate: Fix setting minimum P-state at init time
      ACPI: processor: idle: Expand _LPI package sanity checks
      ACPI: battery: Adjust charging status validation check
      ACPI: bus: Avoid confusing complaints regarding missing _OSC features
      thermal: hwmon: Remove hwmon class device along with its parent
      intel_idle: Avoid using deep idle states during initialization
      ACPI: bus: Introduce acpi_bus_get_primary_device()
      ACPI: platform: Use acpi_bus_get_primary_device()
      ACPI: scan: Use acpi_bus_get_primary_device()

Rakesh Kota (1):
      thermal/drivers/qcom-spmi-adc-tm5: Drop IIO_VAL_INT check in adc_tm5_get_temp

Ran Hongyun (1):
      UBI: fix two issues in the ubi.mtd MODULE_PARM_DESC

Reinette Chatre (2):
      fs/resctrl: Prevent use-after-free in rdtgroup_kn_put()
      fs/resctrl: Fix UAF from worker threads when domains are removed

Reshma Immaculate Rajkumar (1):
      wifi: ath12k: fix encrypted EAPOL TX in encap offload mode

Rex Lu (2):
      wifi: mt76: fix RX data queuing of RRO 3.0
      wifi: mt76: check txfree done event on the WED hw path

Riana Tauro (2):
      drm/xe/uapi: Add additional error components to xe drm_ras
      drm/xe/xe_ras: Add support to get error counter value

Ricardo B. Marlière (3):
      selftests/bpf: Fix make install target
      selftests/bpf: Fix lsm_bdev dev_t encoding mismatch
      libbpf: Search /lib64 and /lib in resolve_full_path()

Ricardo B. Marlière (SUSE) (1):
      selftests/namespaces: Fix racy pipe handshake in timens and pidns_separate

Ricardo Neri (2):
      sched/fair: Also gate overloaded status update for SD_ASYM_CPUCAPACITY
      sched/fair: Check CPU capacity before comparing group types during load balance

Ricardo Ribalda (1):
      media: platform: amd: use refcount_t instead of atomic_t

Richard Acayan (1):
      arm64: dts: qcom: sdm670-google: add lpi reserved gpios

Richard Cheng (4):
      cxl/mbox: Clamp mailbox output allocation to the payload size
      cxl/features: Reject Get Feature count larger than the output buffer
      cxl/features: Reject Set Features output buffer smaller than the header
      cxl/features: Clamp Get Feature output size to the remaining buffer

Richard Zhu (2):
      arm64: dts: imx94: Correct PCIe outbound address space configuration
      arm64: dts: imx943: Correct PCIe outbound address space configuration

Robert Malz (1):
      ice: acquire NVM lock around each flash read

Robertus Diawan Chris (1):
      modpost: prevent leak when early return no suffix .o in read_symbols()

Rodrigo Alencar (1):
      iio: dac: ad5686: missing NULL check on match data

Rong Zhang (2):
      staging: sm750fb: Add missing Kconfig dependency
      net: page_pool: Remove zone/policy GFP flags when allocating XArray entries

Rosalie Wanders (1):
      HID: sony: add missing __packed to struct with static_assert()

Rosen Penev (6):
      clk: stm32: add missing bitfield.h header
      powerpc/44x: Set GPIO chip parent
      ARM: dts: helios4: add vcc-supply to EEPROM
      ARM: dts: helios4: add vcc-supply to GPIO expander
      ARM: dts: helios4: add SATA regulator supplies
      ASoC: xilinx: formatter_pcm: fix stream_data leak on open error

Rui Qi (2):
      selftests/cgroup: Avoid awk -e in cpuset tests
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

Rustam Adilov (1):
      irqchip/irq-realtek-rtl: Use readl_be()/writel_be() instead of readl()/writel()

Ryan Chen (1):
      irqchip/ast2700-intc: Avoid allocating in the irq_domain activate() callback

Ryusuke Konishi (1):
      nilfs2: fix BUG in nilfs_copy_dirty_pages() on dirty state mismatch

SJ Park (1):
      mm/damon/core: skip aging from repeated aggressive merging

Sai Krishna (1):
      octeontx2-af: fix cn20k mailbox lifetime on repeated rvu_mbox_init()

Sajal Gupta (1):
      md/raid5-ppl: fix use-after-free in ppl_do_flush()

Saket Kumar Bhaskar (2):
      powerpc64/bpf: Fix build break for arch_bpf_timed_may_goto
      powerpc/irq: Fix missing r2 clobber in PCREL inline assembly

Sami Tolvanen (1):
      rust: drm: gpuvm: require Send + Sync for the driver's associated data

Samuel Moelius (1):
      iommufd/selftest: Avoid selftest dirty bitmap size wrap

Sandipan Das (4):
      perf/x86/amd/uncore: Add group validation
      perf vendor events amd: Update Zen 5 core events
      perf vendor events amd: Update Zen 6 core events
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

Sascha Bischoff (2):
      irqchip/gic-v5: Clear per-CPU IRS data on teardown
      irqchip/gic-v5: Synchronize CPU interface disable

Saurav Sachidanand (1):
      perf vendor events arm64: fix swapped MetricGroup for Tegra410 L1 prefetcher metrics

Sayali Patil (3):
      selftests/mm: handle EINVAL when configuring gigantic hugepages
      selftests/mm: fix ksm NUMA merge test for systems with memoryless NUMA nodes
      selftests/mm: fix ternary operator precedence in ksm_tests

Sean Christopherson (4):
      KVM: x86: Extract REGS and SREGS runtime sync code to helpers
      KVM: x86: Move get_segment_base() to regs.h, as kvm_get_segment_base()
      KVM: x86: Rename __{g,s}et_sregs2() => kvm_vcpu_ioctl_x86_{g,s}et_sregs2()
      KVM: x86: Move the bulk of register specific code from x86.c to regs.c

Sean Rhodes (1):
      misc: rtsx_usb: avoid USB I/O in runtime autosuspend

Sean Wang (5):
      wifi: mt76: mt792x: stop USB register access after bus hang
      wifi: mt76: connac: add NAN connection type
      wifi: mt76: mt7925: add NAN MCU helpers
      wifi: mt76: add init_wiphy callback
      wifi: mt76: mt7927: set band index for sniffer mode

Sean Young (2):
      media: keymaps: Remove obsolete RC_MAP_RC5_TV keymap define
      media: keymaps: Remove obsolete RC_MAP_HAUPPAUGE_NEW keymap define

Sebastian Andrzej Siewior (1):
      sched/topology: Add a cpus_read_lock to rebuild_sched_domains()

Sechang Lim (1):
      bpf,lsm: Drop bpf_prog_free from sleepable_lsm_hooks

Selvin Xavier (1):
      RDMA/bnxt_re: Clear VM_MAYWRITE on DBR/toggle page mmap

Seongjae Jeong (1):
      f2fs: use adjusted write range after f2fs_write_checks()

Sergei Litvin (1):
      scripts/tags.sh: Prevent binary files appearing in cscope.files

Serhat Kumral (1):
      RDMA/ucma: Allow path records to exactly fit the output buffer

Shakeel Butt (1):
      memcg: move LRU size accounting on reparenting instead of copying it

Shanker Donthineni (1):
      arm_mpam: Apply T241-MPAM-6 to 63-bit counters

Shayne Chen (2):
      wifi: mt76: fix handling channel context with different bands in mt76_switch_vif_chanctx()
      wifi: mt76: mt7996: fix capability of EHT-MCS 15 in MRU

Shengjiu Wang (2):
      ASoC: fsl_audmix: rework runtime PM handling in probe
      arm64: dts: imx8mp-ab2: Enable MU2 for DSP communication

Shengyu Qu (1):
      ASoC: amd: acp-config: change quirks to cover all ASUS FA401EA variants

Shin'ichiro Kawasaki (2):
      nvmet-rdma: factor out response resource cleanup
      nvmet-rdma: fix response resource leak on queue teardown

Shivam Rawat (1):
      drm/msm/a6xx: Fix stale rpmh votes after suspend

Shivendra Pratap (1):
      power: reset: reboot-mode: Remove devres based allocations

Shuangpeng Bai (1):
      RDMA/siw: Fix use-after-free in siw_accept()

Shukai Ni (1):
      dm-integrity: replace forgeable discard filler with a keyed sector marker

Sibi Sankar (1):
      arm64: dts: qcom: glymur-crd: Add Embedded controller node

Simon Glass (3):
      pinctrl: rockchip: Reset the pin count when recalculating SoC data
      pinctrl: rockchip: Restrict the RV1103B 2-bit drive type to bank 2
      pinctrl: rockchip: Decode drive strength in the get function

Slawomir Stepien (1):
      wifi: zd1211rw: reject secondary interfaces to prevent conflicts

Srinivas Kandagatla (1):
      soundwire: qcom: Fix port exhaustion check in stream_alloc_ports

Stanislav Fomichev (2):
      xsk: align TX metadata layout across ABIs
      xsk: honor XDP_TX_METADATA in zero-copy path

Stanislav Kinsburskii (1):
      lib/test_hmm: fail dmirror_fault() when the mirrored mm is gone

StanleyYP Wang (2):
      wifi: mt76: mt7996: add missing rdd_idx check when enabling background radar
      wifi: mt76: mt7996: fix reg addr remap when addr is 0

Steffen Klassert (1):
      Revert "esp: do not unref managed frag pages in esp_ssg_unref()"

Stephan Gerhold (2):
      remoteproc: qcom_q6v5_mss: Make ssctl_id configurable per platform
      remoteproc: qcom_q6v5_mss: Fix MDM9607 subsystem control instance ID

Steve Dunnagan (1):
      leds: gpio: Clear error pointers for skipped LEDs

Steven Rostedt (1):
      tracing: Have trace_event_update_all() only handle module that is loading

Sudeep Holla (19):
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
      firmware: arm_scmi: Clear SystemPower flag on create failure
      firmware: arm_scmi: Fix OF node reference handling
      firmware: arm_scmi: Unwind TX receiver mailbox setup failure
      firmware: arm_scmi: Unwind P2A receiver mailbox setup failure
      firmware: arm_scmi: Fix SCMI device destroy lifetimes
      firmware: arm_scmi: Fix transport device teardown lookup
      firmware: arm_scmi: Fix requested device removal race
      firmware: arm_scmi: Roll back partial protocol table registration
      firmware: arm_scmi: Unrequest devices if driver registration fails

Suman Ghosh (1):
      octeontx2-pf: fix NULL deref of af_xdp_zc_qidx on rep setup

Sumeet Pawnikar (1):
      powercap: intel_rapl_tpmi: Handle PMU registration failure during probe

Sun YangKai (1):
      btrfs: check if root is readonly when setting posix acl

Suraj Gupta (1):
      dmaengine: xilinx_dma: Fix channel idle state management in AXIDMA and MCDMA interrupt handlers

Surendra Singh Chouhan (3):
      regulator: tps65185: handle gpiod_get_value_cansleep() error returns
      pinctrl: generic: free maps on pinctrl_generic_to_map() failure
      rtc: spacemit: handle regmap_test_bits() error return

Sven Eckelmann (2):
      batman-adv: dat: atomically update mac addresses
      batman-adv: bla: avoid CRC corruption due to parallel claim add

Sven Peter (7):
      mfd: macsmc: Fix key count endianness annotation
      nvme-apple: Destroy the admin queue on removal
      nvme-apple: Don't set a DMA direction for commands without a data transfer
      nvme-apple: Never set the opcode in the NVMMU TCB
      nvme: Add a quirk for page aligned admin queue buffers
      nvme-apple: Require page aligned buffers on the admin queue
      nvme-apple: Drop the PRP null check chicken bit

Svyatoslav Ryhel (1):
      drm/tegra: dsi: Re-add clear enable register if DSI was powered by bootloader

Szymon Wilczek (1):
      hwmon: (coretemp) Fix core_data leak on CPUs without PTS

Takashi Iwai (3):
      ALSA: hda: cix-ipbloq: Avoid build with 32bit archs
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

Tamizh Chelvam Raja (2):
      wifi: ath12k: Advertise multicast Ethernet encapsulation offload support
      wifi: ath12k: Set IEEE80211_OFFLOAD_ENCAP_4ADDR after tx_encap_type vdev param

TanZheng (1):
      RDMA/srpt: Fix srpt_alloc_rw_ctxs() unwind counters

Taniya Das (6):
      clk: qcom: gxclkctl: Use custom disable callback for gx_gdsc
      clk: qcom: gcc-glymur: Move EVA clocks to critical clock list
      clk: qcom: nord: use BRANCH_HALT_SKIP for PHY pipe clocks
      clk: qcom: negcc-nord: use clk_regmap_phy_mux for USB3 pipe clock srcs
      clk: qcom: gcc-nord: mark PCIe link clocks as critical
      clk: qcom: negcc-nord: keep GPU2 CFG clock enabled via critical CBCR

Tanushree Shah (4):
      perf data convert json: Fix trace_seq memory leak in process_sample_event()
      perf dso: Fix kallsyms DSO detection with fallback logic
      perf trace-event: Fix buffer overflow in read_string()
      perf trace-event: Fix integer truncation in do_read() and skip()

Tao Cui (5):
      block/blk-stat: drain per-cpu callback stats over possible CPUs
      block/blk-iolatency: account per-cpu latency stats over possible CPUs
      block/blk-iocost: collect per-cpu latency stats over possible CPUs
      block/kyber-iosched: flush per-cpu latency buckets over possible CPUs
      sched_ext/scx_flatcg: Fix cvtime true-up on slice expiry

Tejun Heo (3):
      sched_ext: Abort directly from the hardlockup handler
      sched_ext: Drop unlocked scx_rq_clock_invalidate() from scx_root_disable()
      sched_ext: Make SCHED_CLASS_EXT select GENERIC_ALLOCATOR

Tengda Wu (1):
      perf capstone: Fix kernel map reference count leak

Tetsuo Handa (3):
      net: add missing ref_tracker_dir_exit() to alloc_netdev_mqs()
      net: add missing ref_tracker_dir_exit() to net_passive_dec()
      net: fix a resource leak in copy_net_ns() error handling path

Thomas Bogendoerfer (1):
      MIPS: ptrace: Fix syscall skipping via PTRACE_SYSCALL

Thomas Huth (1):
      smb: server: Remove obsolete "select CRYPTO_LIB_DES" from Kconfig file

Thomas Richter (1):
      perf test: Skip failing 'perf test aslr' test case

Thomas Walsh (1):
      bnxt_en: Gate TPH enablement behind BNXT_SUPPORTS_QUEUE_API check

Thomas Weißschuh (7):
      tools/nolibc: mark arg1 operand in __nolibc_syscall0() as write-only
      kbuild: unset sub_make_done before calling kselftest build system
      y2038: uapi: Use 64-bit __kernel_old_timespec::tv_nsec on x32
      tools/nolibc/powerpc: mark ctr and xer as clobbered by system call
      hwmon: (cros_ec) Register the thermal devices after the hwmon ones
      hwmon: (cros_ec) Store the hwmon device in cros_ec_hwmon_priv
      hwmon: (cros_ec) Synchronize EC access from the thermal device callbacks

Thorsten Blum (3):
      crypto: atmel-ecc - reject hardware ECDH without a public key
      crypto: sl3516 - drop invalid sg_dma_len checks before DMA mapping
      crypto: qat - use 2-arg strscpy where destination size is known

Tiezhu Yang (2):
      bpf: Introduce jit_required flag and remove bpf_prog_has_kfunc_call()
      bpf: Reject programs with inlined helpers if JIT is not available

Timur Kristóf (3):
      drm/amdgpu/gfx6: Fixup emit_cntxcntl()
      drm/amdgpu/gfx6: Fixup emitting SWITCH_BUFFER packets
      drm/amdgpu/gfx6: Use PFP on the compute queues too

Tommaso Merciai (1):
      i3c: renesas: Don't register devices when ENTDAA times out

Tomáš Macholda (1):
      arm64: dts: turris-mox: fix usb3 phys

Troy Mitchell (3):
      ASoC: spacemit: rename clock inputs to match binding
      clk: spacemit: k3: fix missing /2 factor in i2s sysclk dividers
      pinctrl: spacemit: validate pins in pinconf callbacks

Tzung-Bi Shih (1):
      platform/chrome: sensorhub: Fix memory overread in ring handler

Uday Khare (2):
      regulator: tps6594: Fix device node reference leaks in multiphase loop
      remoteproc: qcom: Fix glink->node reference leak in qcom_add_glink_subdev

Usama Arif (3):
      blk-iolatency: clear delay state when freeing policy data
      blk-iocost: clear delay state when freeing policy data
      mm/memcontrol: avoid false sharing between vmstats and events

Uwe Kleine-König (The Capable Hub) (1):
      misc: pch_phub: Complete enum usage for device identification

Val Packett (1):
      remoteproc: qcom_wcnss: Fix handling the lack of PD regulators in v3

Vasant Hegde (1):
      iommu/amd: Fix incorrect device ID in invalid PASID error message

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

Viktor Malik (4):
      selftests/bpf: Check malloc result with ASSERT_NEQ in test_loader
      selftests/bpf: Check malloc result with ASSERT_NEQ in test_sha256
      selftests/bpf: Silence array bounds warning in global_map_resize
      selftests/bpf: Silence maybe-uninitialized compiler warning in libarena

Vincent Donnefort (1):
      ring-buffer: Remove trace_buffer::cpus

Vineet Gupta (1):
      selftests/bpf: vmtest.sh: Preserve command quoting when running in the VM

Vishnu Santhosh (1):
      rpmsg: glink: fix deadlock in endpoint destroy during driver detach

Vitaliy Sochnev (1):
      net: phy: air_en8811h: move LED GPIO configuration to config_init

Vladimir Murzin (4):
      arm64: smp: Fix IPI teardown for GICv5 flow
      arm64: hibernate: Restore DAIF state on error
      arm64: entry: Avoid unnecessary local_irq_disable() on kernel exit
      arm64: process: Fix context switching MTE store-only tag check

Vladimir Oltean (1):
      net: dsa: b53: fix error propagation from b53_fdb_dump()

Vladimir Zapolskiy (4):
      dmaengine: mediatek: mtk-uart-apdma: Return -ENOMEM on memory allocation failure
      dmaengine: hisilicon: Return -ENOMEM on dynamic memory allocation in probe
      iommu/msm: Return -ENOMEM on memory allocation failure in probe
      clk: qcom: Return expected ENOMEM error on dynamic allocation failure

Waiman Long (3):
      cgroup/cpuset: Avoid unnecessary cpus & mems update in cpuset_hotplug_update_tasks()
      cgroup/cpuset: Make nr_deadline_tasks an atomic_t
      sched/isolation: Defer freeing of cpumask memblock memory to initcall

Wang Yan (1):
      selftests/lsm: Fix memory leak in attr_lsm_count

Wanwu Li (1):
      sched_ext/scx_flatcg: Fix cvtime_delta race and add hweight scaling to bypass charging

Wei Fang (9):
      ptp: netc: skip PEROUT disable if channel is not enabled
      ptp: netc: fix period truncation and potential divide-by-zero in PEROUT
      net: enetc: restore RX ring congestion mode after ring reconfiguration
      net: enetc: extract common helpers for MAC promiscuous mode setting
      net: enetc: extract common helpers for MAC hash filter configuration
      net: enetc: convert ndo_set_rx_mode() to ndo_set_rx_mode_async()
      net: enetc: improve MAFT entry management with bitmap tracking
      net: enetc: remove invalid code from enetc4_pl_mac_link_up()
      net: enetc: restore RX ring congestion mode for ENETC v4

Wei Hou (1):
      cxl/pci: Remove incorrect mbox.valid check in cxl_pci_type3_init_mailbox()

Wei Wang (2):
      iommu/amd: Prevent SB IOAPIC from overriding IVRS validation errors
      iommu/amd: Fix false positive in SB IOAPIC IVRS validation

Wei Yang (1):
      mm/mm_init: fix incorrect node_spanned_pages

Wei Zhang (1):
      wifi: ath12k: fix rx_mpdu_start layout for QCC2072

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

Wentao Guan (1):
      wifi: rtw89: fw: correct preload field of w2 in rtw89_fw_h2c_default_cmac_tbl_be()

Will Deacon (2):
      arm64: ptrace: Keep 'orig_x0' in-sync with x0 on syscall entry
      arm64/efi: Avoid voluntary preemption with efi_mm installed

Willem de Bruijn (3):
      selftests: drv-net: so_txtime: only send test traffic to sch_etf
      idpf: add missing cpu_to_le32 in idpf_tx_splitq_build_flow_desc
      selftests: drv-net: so_txtime: fix qdisc replace with handle

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

Xie Yuanbin (2):
      ARM: 9484/1: enable interrupts when unhandled user faults are triggered
      ARM: 9485/1: mm: acquire mmap write lock around show_pte() for user faults

Xin Xie (1):
      net: hsr: free learned nodes on device setup failure

Xiubo Li (1):
      ceph: revalidate ki_pos for O_APPEND writes after cap acquisition

Xu Rao (2):
      usb: typec: tcpm: fix EPR AVS APDO maximum voltage decoding
      ALSA: hda: Fix connection list comparison in proc output

Xu Yang (2):
      usb: chipidea: imx: fix missing ret assignment for dev_err_probe
      usb: gadget: f_uac1_legacy: remove broken string configfs attributes

Xuanqiang Luo (1):
      fanotify: initialize permission event watchdog state

Xuyang Dong (1):
      clk: eswin: Add CLK_IGNORE_UNUSED to NoC clock

Yang Xiuwei (6):
      ublk: validate auto buf reg before taking uring_cmd
      ublk: clear auto buf reg before updating io->buf in batch commit
      scsi: sd: Fix error handling in sd_probe() after large pool creation failure
      scsi: sd: Fix special_vec mempool leak when scsi_alloc_sgtables() fails
      scsi: sd: Fix sd_done() sense handling condition
      nvme/ioctl: check SUBMIT_IO with nvme_cmd_allowed()

Yao Kai (1):
      ext4: validate readdir offset before accessing dirent

Yao Sang (2):
      ublk: reject non-power-of-2 zone sizes in SET_PARAMS
      ublk: avoid teardown retry loop on xarray allocation failure

Yedaya Katsman (1):
      arm64: dts: qcom: sm6125-xiaomi-laurel-sprout: Fixup panel compatible

Yehyeong Lee (5):
      IB/isert: reject PDUs declaring more data than was received
      IB/isert: reject login PDUs declaring more data than was received
      RDMA/srp: fix heap information leak on a truncated SRP_CRED_REQ
      IB/isert: delay the final Login Response until the session is registered
      IB/isert: post the full-feature receive buffers after session registration

Yemike Abhilash Chandra (1):
      media: ti: vpe: Select V4L2_FWNODE for VIP

Yeoreum Yun (4):
      coresight: etm4x: fix wrong check of etm4x_sspcicrn_present()
      coresight: etm4x: fix underflow for usage of (nrseqstate - 1)
      coresight: etm4x: fix leaked trace id
      coresight: etm4x: missing cscfg_csdev_disable_active_config() in perf enable

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

Yifei Gao (2):
      media: amd: isp4: release partial allocations in isp4if_alloc_fw_gpumem()
      media: amd: isp4: fix self-deadlock in isp4sd_pwron_and_init() error path

Yinhao Hu (1):
      nfc: pn533: hold a reference to the request skb during send_frame

Yixun Lan (1):
      clk: spacemit: k3: fix parent clock of UFS aclk

Yiyang Chen (3):
      bpf: Reject MEM_ALLOC BTF accesses past object bounds
      bpf: Reject arena frees below the arena base
      bpf: Check pointer type for all atomic RMW paths

Yonatan Nachum (1):
      RDMA/efa: Fix PBL chunk length computation

Yonghong Song (2):
      bpf: Reject >8 byte return values on return-reading trampoline paths
      bpf, x86: Fix trampoline stack size for 128-bit arguments

Yongxing Mou (1):
      drm/msm/dpu: Fix DMA SSPP REC block offsets on DPU v13

Yosry Ahmed (1):
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

Yuho Choi (20):
      ARM: imx: avic: Fix OF node reference leaks
      ARM: OMAP2+: Fix OF node reference leaks in omap_hwmod
      bus: ti-sysc: Fix /chosen node reference leak
      clocksource: Unregister subsystem on device registration failure
      timekeeping: Unwind aux clock sysfs children on failure
      bus: mhi: ep: Fix device refcount leak in the error path of MHI device creation
      serial: ma35d1: Fix OF node reference leaks in console init
      hwrng: ks-sa - Fix runtime PM cleanup on registration failure
      PCI: xgene: Drop unnecessary OF node reference
      PCI: keystone: Fix OF node reference leak in init
      uio: Fix stale info pointer in failed registration path
      driver core: soc: Unregister bus on early device registration failure
      bus: mhi: host: Fix controller cleanup on EDL sysfs failure
      ARM: tegra: Fix OF node reference leaks in IRQ init
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

Yunseong Kim (6):
      ksmbd: fix slab-out-of-bounds read in ksmbd_alloc_user()
      smb: smbdirect: free completion queues with ib_free_cq()
      smb: smbdirect: destroy QP before mem pools on accept failure
      smb: smbdirect: avoid recursive listen.lock during cleanup
      smb: smbdirect: release pending child sockets outside the handler lock
      ksmbd: validate ipc response length before dereferencing its fields

Yuntao Wang (1):
      kbuild: fix modules.builtin(.modinfo) targets in the top-level Makefile

Yuvaraj Ranganathan (2):
      firmware: qcom: scm: add trace events for the SMC call interface
      firmware: qcom: scm: instrument SMC call path with tracepoints

Ze Tan (6):
      smb/server: fix tree connection leak in smb2_tree_connect()
      smb/server: fix session leak in ksmbd_session_register()
      smb/server: warn if ksmbd_proc_create() fails
      smb/server: update session counter under sessions table lock
      smb/server: fix session counter on session removal
      smb/client: preserve open info type across compound queries

Zhan Xusheng (2):
      fs/ntfs3: fix integer overflow in MFT cluster validation
      fs/ntfs3: reject out-of-range evcn in mi_enum_attr()

Zhang Yi (1):
      ext4: skip tail block zeroing for inline data files

ZhangGuoDong (6):
      smb/server: fix null-ptr-deref in ksmbd_ipc_tree_connect_request()
      smb/server: fix invalid pointer dereference in ksmbd_stop_durable_scavenger()
      smb/server: abort initialization when proc setup fails
      smb/server: call ksmbd_proc_cleanup() on module init failure
      smb/server: preserve error status in smb2_handle_negotiate()
      pnfs/blocklayout: Fix device leaks on parse failure

Zhansong Gao (1):
      NFSv4: Fix incorrect argument passed to nfs4_delete_lease() in nfs4_add_lease()

Zhao Li (5):
      wifi: mac80211: fix per-STA profile length in cross-link CSA parsing
      wifi: mac80211: send TWT teardown to peer after setup TX failure
      wifi: nl80211: clean up color-change beacon data on errors
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

Zhi Wang (2):
      gpu: nova-core: build SetRegistry entries dynamically
      gpu: nova-core: factor out common FSP message header

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

Zide Chen (7):
      perf/x86/intel/uncore: Keep PCI PMUs working when MMIO/MSR setup fails
      perf/x86/intel/uncore: Fix PCI PMU cleanup on setup failure
      perf/x86/intel/uncore: Fix refcnt and other cleanups
      perf/x86/intel/uncore: Let init_box() callback report failures
      perf/x86/intel/uncore: Factor out box setup code
      perf/x86/intel/uncore: Introduce PMU flags and broken state
      perf/x86/intel/uncore: Fix uncore_box ref/unref ordering

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

Zong-Zhe Yang (1):
      wifi: rtw89: fw: fix link ID filling for LPS MLO common info

Zxyan Zhu (1):
      net: stmmac: Skip PHY attach if custom PCS is in use

bui duc phuc (7):
      ASoC: samsung: i2s: Avoid mixing goto with guard()
      ASoC: ti: j721e-evm: Avoid mixing goto with guard()
      ASoC: pxa: Use devm_clk_get_optional() for extclk clock
      ASoC: spacemit: advertise only DMA-backed DAI streams
      can: m_can: Use of_property_present() for wakeup-source
      net: ethernet: sun4i-emac: Fix IRQ error handling
      net: fec: only stop PTP if it was initialized

longlong yan (1):
      clk/x86: pmc_atom: add kasprintf return value check

shengwei.lu (1):
      wifi: mt76: mt7925: Fix EHT Beamformee SS subfields to meet 802.11be minimum

surendra (2):
      thermal/drivers/spacemit: Validate clamped trip thresholds
      hwmon: (pmbus/ltc4283) Add missing MODULE_DEVICE_TABLE for OF match table

zhouminqiang (1):
      mtd: part: reject MTDPART_OFS_RETAIN in mtd_add_partition()

谢致邦 (XIE Zhibang) (1):
      HID: i2c-hid: Refactor _DSM helper and add i2c-hid-acpi-prp0001 driver

