Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA8448CEA;
	Mon, 14 Sep 2026 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387126; cv=none; b=IK+ucYX6uZ66YM54KtluqBEU0+vD48WnpMjv3YJ83XzDkMUM9WngpBnJEx9ljpI61q7mRPf2V91tcau95mzfEU/4vKFEgqk7jI3gt3Z8AWU14ItAMsfu5TcdHCcFj4TPknKUO3zAgZuAgQ8qKKWFhFA6/xkTVA/e4xyNFe3m0yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387126; c=relaxed/simple;
	bh=lFYZywDvHYVFKmF6u3YSf8Oyva4wmWq8oP5CQouCtvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E9sVvmdUNwAxYyQXKQqnOoaWklgbTPFZ3N59T5BMvT7oMQjnLxx3G7AZjZXmhnMLQb4xvqx6mvnBml+w9blw9r6rgfz8WDt/2wl/zRI1/c42AiIcyCrT8Q3VKDnIIGw+f70VBuXrh/WdlywOb6y/Ero4kJl5zong0fQlp2mw1u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YFTpU6p2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YFTpU6p2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DD31F0089C;
	Mon, 14 Sep 2026 11:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789387105;
	bh=xJb39Uvo/KgRVrUtEtXtneVneGExWrg8sgoBuJb2Yx4=;
	h=From:To:Cc:Subject:Date;
	b=YFTpU6p2IEbmOJwGQIHLv0/wGoMAxnMVMluCumIdNlOFk6uyfaOQAUBxCsckN5HvX
	 7KfjhHQSG4yaKJCvLTLOil/FACUSvIWcUcTJfRGi9GJr5duMcHICYg04aY7GsAmbzW
	 HGr6XbBjlCHCLOR3y63jf+Oi7hpWbiKhO08nuXxg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.157
Date: Mon, 14 Sep 2026 13:58:05 +0200
Message-ID: <2026091406-thrill-unfeeling-f7af@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.157 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/configfs-usb-gadget-uac1_legacy       |    3 
 Documentation/ABI/testing/sysfs-bus-nvdimm                      |    3 
 Documentation/hwmon/emc1403.rst                                 |   25 
 Documentation/usb/gadget-testing.rst                            |    3 
 Documentation/userspace-api/media/v4l/ext-ctrls-colorimetry.rst |   12 
 Makefile                                                        |    2 
 arch/alpha/include/uapi/asm/fpu.h                               |    8 
 arch/alpha/kernel/pci-sysfs.c                                   |    6 
 arch/alpha/kernel/sys_marvel.c                                  |   25 
 arch/alpha/kernel/traps.c                                       |    6 
 arch/alpha/math-emu/math.c                                      |   88 +
 arch/arm/Kconfig                                                |    2 
 arch/arm/boot/dts/allwinner/sun4i-a10.dtsi                      |    2 
 arch/arm/boot/dts/marvell/armada-388-helios4.dts                |   13 
 arch/arm/mach-imx/src.c                                         |    3 
 arch/arm/mach-lpc32xx/common.c                                  |    5 
 arch/arm/mach-lpc32xx/common.h                                  |    2 
 arch/arm/mach-lpc32xx/phy3250.c                                 |    2 
 arch/arm/mach-lpc32xx/pm.c                                      |    5 
 arch/arm/mm/fault.c                                             |   16 
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi         |    4 
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts                  |    4 
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts          |    3 
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts              |    2 
 arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi       |    4 
 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts               |    5 
 arch/arm64/boot/dts/qcom/msm8998.dtsi                           |   24 
 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts             |   61 
 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi                     |    2 
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts                     |   12 
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                           |   20 
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                       |    4 
 arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts              |    2 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                            |   64 
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts               |    6 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                            |    8 
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi        |    2 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                            |   48 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                            |    8 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                            |    8 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                            |   12 
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi                 |    2 
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi         |    3 
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts             |   12 
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi                        |    2 
 arch/arm64/kernel/compat_alignment.c                            |    4 
 arch/arm64/kernel/hibernate.c                                   |   16 
 arch/arm64/lib/Makefile                                         |    4 
 arch/arm64/mm/fault.c                                           |   12 
 arch/arm64/mm/mmu.c                                             |   58 
 arch/csky/kernel/entry.S                                        |    6 
 arch/loongarch/kernel/kprobes.c                                 |    3 
 arch/loongarch/kernel/rethook_trampoline.S                      |    2 
 arch/m68k/emu/nfcon.c                                           |    2 
 arch/m68k/kernel/traps.c                                        |    4 
 arch/mips/kernel/ptrace.c                                       |    6 
 arch/openrisc/kernel/entry.S                                    |   43 
 arch/parisc/kernel/head.S                                       |    1 
 arch/powerpc/configs/85xx-hw.config                             |    1 
 arch/powerpc/include/asm/papr-watchdog.h                        |   64 
 arch/powerpc/kernel/irq.c                                       |   16 
 arch/powerpc/kernel/smp.c                                       |    3 
 arch/powerpc/mm/book3s64/radix_pgtable.c                        |    7 
 arch/powerpc/platforms/powermac/low_i2c.c                       |    2 
 arch/powerpc/platforms/pseries/iommu.c                          |   23 
 arch/powerpc/platforms/pseries/setup.c                          |   28 
 arch/riscv/kernel/cpufeature.c                                  |    3 
 arch/s390/kernel/debug.c                                        |   10 
 arch/s390/kernel/perf_cpum_cf.c                                 |  215 +-
 arch/s390/kvm/guestdbg.c                                        |    9 
 arch/s390/kvm/interrupt.c                                       |    2 
 arch/s390/kvm/kvm-s390.c                                        |   15 
 arch/x86/coco/tdx/tdx.c                                         |   10 
 arch/x86/events/amd/uncore.c                                    |  753 +++++-----
 arch/x86/events/intel/lbr.c                                     |   12 
 arch/x86/events/intel/uncore.c                                  |    3 
 arch/x86/events/intel/uncore_snbep.c                            |   13 
 arch/x86/include/asm/insn-eval.h                                |   36 
 arch/x86/include/asm/linkage.h                                  |    2 
 arch/x86/include/asm/pkeys.h                                    |    3 
 arch/x86/kvm/emulate.c                                          |   26 
 arch/x86/kvm/hyperv.c                                           |   25 
 arch/x86/kvm/vmx/nested.c                                       |   18 
 block/blk-cgroup.c                                              |    2 
 block/blk-iocost.c                                              |    2 
 block/blk-stat.c                                                |    2 
 block/genhd.c                                                   |    8 
 block/kyber-iosched.c                                           |    2 
 drivers/accessibility/speakup/keyhelp.c                         |   17 
 drivers/accessibility/speakup/kobjects.c                        |    6 
 drivers/acpi/ec.c                                               |   40 
 drivers/acpi/pci_root.c                                         |    3 
 drivers/acpi/pfr_update.c                                       |   45 
 drivers/acpi/processor_core.c                                   |   31 
 drivers/acpi/processor_driver.c                                 |   18 
 drivers/acpi/processor_idle.c                                   |  116 +
 drivers/acpi/scan.c                                             |   13 
 drivers/acpi/video_detect.c                                     |    4 
 drivers/ata/ahci.c                                              |   49 
 drivers/ata/libata-scsi.c                                       |   28 
 drivers/auxdisplay/charlcd.c                                    |   21 
 drivers/base/arch_numa.c                                        |   12 
 drivers/base/cacheinfo.c                                        |    9 
 drivers/base/firmware_loader/fallback.c                         |   10 
 drivers/base/property.c                                         |   19 
 drivers/base/soc.c                                              |   15 
 drivers/base/swnode.c                                           |    2 
 drivers/block/mtip32xx/mtip32xx.c                               |    7 
 drivers/block/mtip32xx/mtip32xx.h                               |    2 
 drivers/block/null_blk/main.c                                   |   96 -
 drivers/block/null_blk/null_blk.h                               |    1 
 drivers/block/ublk_drv.c                                        |   14 
 drivers/bluetooth/btintel.c                                     |    2 
 drivers/bluetooth/btmtk.c                                       |    7 
 drivers/bluetooth/btmtksdio.c                                   |   33 
 drivers/bluetooth/btqca.c                                       |    3 
 drivers/bluetooth/btusb.c                                       |   80 -
 drivers/bluetooth/hci_bcm.c                                     |    1 
 drivers/bluetooth/hci_h5.c                                      |    4 
 drivers/bluetooth/hci_intel.c                                   |    1 
 drivers/bluetooth/hci_ldisc.c                                   |    2 
 drivers/bluetooth/hci_serdev.c                                  |    2 
 drivers/bluetooth/virtio_bt.c                                   |    8 
 drivers/bus/mhi/ep/main.c                                       |   15 
 drivers/bus/mhi/host/main.c                                     |    6 
 drivers/bus/qcom-ebi2.c                                         |   51 
 drivers/bus/ti-sysc.c                                           |   12 
 drivers/char/hw_random/ks-sa-rng.c                              |   22 
 drivers/char/ipmi/ipmb_dev_int.c                                |    5 
 drivers/char/ipmi/ipmi_msghandler.c                             |    1 
 drivers/char/ppdev.c                                            |   10 
 drivers/char/tpm/st33zp24/st33zp24.c                            |    8 
 drivers/char/tpm/tpm_i2c_nuvoton.c                              |    6 
 drivers/char/xilinx_hwicap/xilinx_hwicap.c                      |    5 
 drivers/clk/clk-moxart.c                                        |   14 
 drivers/clk/clk-palmas.c                                        |   14 
 drivers/clk/clk-versaclock7.c                                   |    2 
 drivers/clk/hisilicon/reset.c                                   |    2 
 drivers/clk/imx/clk-scu.c                                       |    1 
 drivers/clk/mediatek/clk-mt8135.c                               |    5 
 drivers/clk/meson/gxbb.c                                        |    2 
 drivers/clk/nuvoton/clk-ma35d1-pll.c                            |   52 
 drivers/clk/qcom/common.c                                       |    4 
 drivers/clk/qcom/gcc-mdm9607.c                                  |  182 --
 drivers/clk/qcom/gcc-msm8916.c                                  |    5 
 drivers/clk/qcom/gcc-msm8939.c                                  |    5 
 drivers/clk/qcom/gcc-qcm2290.c                                  |   12 
 drivers/clk/qcom/gdsc.c                                         |   25 
 drivers/clk/rockchip/clk-pll.c                                  |    9 
 drivers/clk/rockchip/clk-rk3588.c                               |    2 
 drivers/clk/tegra/clk-tegra124-emc.c                            |    1 
 drivers/clk/ti/adpll.c                                          |    4 
 drivers/clk/ti/divider.c                                        |    2 
 drivers/clk/ti/mux.c                                            |   22 
 drivers/clk/visconti/clkc.c                                     |    2 
 drivers/clk/x86/clk-pmc-atom.c                                  |    3 
 drivers/clocksource/clps711x-timer.c                            |    2 
 drivers/clocksource/timer-armada-370-xp.c                       |   18 
 drivers/clocksource/timer-sun4i.c                               |    2 
 drivers/cpufreq/imx6q-cpufreq.c                                 |    6 
 drivers/cpufreq/intel_pstate.c                                  |   19 
 drivers/cpufreq/spear-cpufreq.c                                 |    4 
 drivers/cpuidle/dt_idle_genpd.c                                 |    3 
 drivers/crypto/atmel-ecc.c                                      |   45 
 drivers/crypto/atmel-sha204a.c                                  |    6 
 drivers/crypto/gemini/sl3516-ce-cipher.c                        |    8 
 drivers/crypto/hisilicon/sec2/sec_crypto.c                      |   12 
 drivers/crypto/intel/keembay/keembay-ocs-aes-core.c             |    9 
 drivers/crypto/intel/qat/qat_common/qat_algs.c                  |    1 
 drivers/crypto/rockchip/rk3288_crypto_ahash.c                   |    7 
 drivers/crypto/sa2ul.c                                          |    6 
 drivers/cxl/core/mbox.c                                         |    7 
 drivers/cxl/core/pmem.c                                         |   10 
 drivers/cxl/core/region.c                                       |    7 
 drivers/cxl/cxl.h                                               |    3 
 drivers/cxl/cxlmem.h                                            |    2 
 drivers/cxl/pci.c                                               |   14 
 drivers/cxl/pmem.c                                              |    2 
 drivers/dax/super.c                                             |   12 
 drivers/dma/dw-edma/dw-edma-core.c                              |  127 +
 drivers/dma/dw-edma/dw-hdma-v0-core.c                           |    2 
 drivers/dma/hisi_dma.c                                          |    2 
 drivers/dma/mediatek/mtk-uart-apdma.c                           |    2 
 drivers/dma/qcom/bam_dma.c                                      |    1 
 drivers/dma/xilinx/xilinx_dma.c                                 |   12 
 drivers/firmware/arm_scmi/bus.c                                 |   69 
 drivers/firmware/arm_scmi/driver.c                              |   54 
 drivers/firmware/google/coreboot_table.c                        |   26 
 drivers/fpga/altera-cvp.c                                       |   10 
 drivers/fpga/stratix10-soc.c                                    |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                      |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                         |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                           |   74 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                           |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                           |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                        |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c         |    6 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c |    5 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c             |   24 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c           |   35 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c             |    2 
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c                       |    3 
 drivers/gpu/drm/bridge/tc358767.c                               |    2 
 drivers/gpu/drm/drm_atomic_uapi.c                               |    2 
 drivers/gpu/drm/drm_drv.c                                       |   34 
 drivers/gpu/drm/drm_dumb_buffers.c                              |    1 
 drivers/gpu/drm/gud/gud_connector.c                             |   12 
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c                  |   52 
 drivers/gpu/drm/i915/i915_pci.c                                 |    3 
 drivers/gpu/drm/lima/lima_device.c                              |   12 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                           |    5 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c                   |    4 
 drivers/gpu/drm/msm/dsi/dsi_host.c                              |   14 
 drivers/gpu/drm/mxsfb/lcdif_kms.c                               |   15 
 drivers/gpu/drm/nouveau/nouveau_gem.c                           |   11 
 drivers/gpu/drm/nouveau/nouveau_sgdma.c                         |    4 
 drivers/gpu/drm/nouveau/nouveau_uvmm.c                          |    3 
 drivers/gpu/drm/omapdrm/dss/dsi.c                               |    7 
 drivers/gpu/drm/omapdrm/dss/dsi.h                               |    2 
 drivers/gpu/drm/panel/panel-edp.c                               |   19 
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c                   |   10 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                    |    2 
 drivers/gpu/drm/sun4i/sun4i_backend.c                           |    2 
 drivers/gpu/drm/sun4i/sun4i_crtc.c                              |    2 
 drivers/gpu/drm/sun4i/sun4i_tcon.c                              |   22 
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c                           |    2 
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c                          |    2 
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c                         |   18 
 drivers/gpu/drm/tve200/tve200_drv.c                             |    1 
 drivers/gpu/host1x/debug.c                                      |    4 
 drivers/gpu/host1x/hw/channel_hw.c                              |    5 
 drivers/hid/hid-core.c                                          |    9 
 drivers/hid/hid-lg4ff.c                                         |    8 
 drivers/hid/hid-mcp2221.c                                       |    9 
 drivers/hid/hid-nintendo.c                                      |    1 
 drivers/hid/hid-picolcd_debugfs.c                               |    9 
 drivers/hid/hid-rmi.c                                           |   46 
 drivers/hid/hid-roccat-kone.c                                   |    8 
 drivers/hid/hid-roccat.c                                        |   13 
 drivers/hid/hid-sensor-custom.c                                 |    9 
 drivers/hid/hid-sensor-hub.c                                    |   42 
 drivers/hid/i2c-hid/Makefile                                    |    2 
 drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c                      |  104 +
 drivers/hid/i2c-hid/i2c-hid-acpi.c                              |   52 
 drivers/hid/i2c-hid/i2c-hid-acpi.h                              |   33 
 drivers/hid/i2c-hid/i2c-hid-core.c                              |  119 -
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c                         |    4 
 drivers/hid/wacom_wac.c                                         |   13 
 drivers/hsi/controllers/omap_ssi_core.c                         |    6 
 drivers/hwmon/emc1403.c                                         |  752 ++++++---
 drivers/hwmon/max6621.c                                         |    8 
 drivers/hwspinlock/hwspinlock_core.c                            |    2 
 drivers/hwtracing/coresight/coresight-etm4x-cfg.c               |    2 
 drivers/hwtracing/coresight/coresight-etm4x-core.c              |   15 
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c             |    6 
 drivers/hwtracing/coresight/coresight-etm4x.h                   |    9 
 drivers/hwtracing/ptt/hisi_ptt.c                                |   20 
 drivers/i2c/busses/i2c-ocores.c                                 |    6 
 drivers/i2c/i2c-core-base.c                                     |    6 
 drivers/i2c/i2c-mux.c                                           |    1 
 drivers/i2c/muxes/i2c-demux-pinctrl.c                           |    1 
 drivers/i3c/master.c                                            |   11 
 drivers/i3c/master/dw-i3c-master.c                              |   10 
 drivers/i3c/master/mipi-i3c-hci/core.c                          |   30 
 drivers/i3c/master/mipi-i3c-hci/dma.c                           |    4 
 drivers/i3c/master/mipi-i3c-hci/ext_caps.c                      |   55 
 drivers/i3c/master/mipi-i3c-hci/pio.c                           |   54 
 drivers/i3c/master/svc-i3c-master.c                             |   10 
 drivers/iio/accel/dmard09.c                                     |    7 
 drivers/iio/chemical/atlas-sensor.c                             |   19 
 drivers/iio/chemical/sgp30.c                                    |    3 
 drivers/iio/dac/m62332.c                                        |   17 
 drivers/iio/gyro/mpu3050-core.c                                 |    2 
 drivers/iio/light/cm32181.c                                     |    2 
 drivers/iio/light/gp2ap002.c                                    |   24 
 drivers/iio/light/isl29028.c                                    |    2 
 drivers/iio/light/opt4001.c                                     |   37 
 drivers/iio/light/tsl2583.c                                     |    2 
 drivers/iio/light/tsl2772.c                                     |    2 
 drivers/iio/orientation/hid-sensor-rotation.c                   |   20 
 drivers/iio/pressure/dps310.c                                   |    3 
 drivers/iio/pressure/mpl115.c                                   |   11 
 drivers/iio/proximity/srf04.c                                   |    1 
 drivers/iio/temperature/hid-sensor-temperature.c                |    3 
 drivers/infiniband/core/cma.c                                   |    6 
 drivers/infiniband/core/core_priv.h                             |    1 
 drivers/infiniband/core/counters.c                              |    5 
 drivers/infiniband/core/cq.c                                    |   14 
 drivers/infiniband/core/device.c                                |    3 
 drivers/infiniband/core/nldev.c                                 |  106 +
 drivers/infiniband/core/restrack.c                              |  186 ++
 drivers/infiniband/core/restrack.h                              |    4 
 drivers/infiniband/core/ucma.c                                  |    7 
 drivers/infiniband/core/uverbs_cmd.c                            |   13 
 drivers/infiniband/core/verbs.c                                 |   28 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                        |    6 
 drivers/infiniband/hw/cxgb4/device.c                            |    8 
 drivers/infiniband/hw/cxgb4/mem.c                               |    4 
 drivers/infiniband/hw/efa/efa_verbs.c                           |   13 
 drivers/infiniband/hw/erdma/Kconfig                             |    2 
 drivers/infiniband/hw/erdma/erdma_eq.c                          |    7 
 drivers/infiniband/hw/erdma/erdma_verbs.c                       |   12 
 drivers/infiniband/hw/erdma/erdma_verbs.h                       |   25 
 drivers/infiniband/hw/hfi1/chip.c                               |    4 
 drivers/infiniband/hw/hfi1/hfi.h                                |    2 
 drivers/infiniband/hw/hfi1/init.c                               |   44 
 drivers/infiniband/hw/hfi1/user_sdma.c                          |   13 
 drivers/infiniband/hw/mlx5/cong.c                               |    8 
 drivers/infiniband/hw/mlx5/main.c                               |    2 
 drivers/infiniband/hw/mlx5/qp.c                                 |   25 
 drivers/infiniband/sw/rxe/rxe_req.c                             |   15 
 drivers/infiniband/sw/rxe/rxe_resp.c                            |    9 
 drivers/infiniband/sw/siw/siw_cm.c                              |   32 
 drivers/infiniband/ulp/ipoib/ipoib_main.c                       |    2 
 drivers/infiniband/ulp/isert/ib_isert.c                         |   85 -
 drivers/infiniband/ulp/isert/ib_isert.h                         |    1 
 drivers/infiniband/ulp/srp/ib_srp.c                             |   45 
 drivers/infiniband/ulp/srpt/ib_srpt.c                           |    9 
 drivers/input/tablet/aiptek.c                                   |   13 
 drivers/interconnect/core.c                                     |    7 
 drivers/iommu/amd/init.c                                        |   42 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                     |    5 
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                         |    6 
 drivers/iommu/dma-iommu.c                                       |   13 
 drivers/iommu/intel/dmar.c                                      |   15 
 drivers/iommu/intel/iommu.c                                     |   18 
 drivers/iommu/intel/iommu.h                                     |    2 
 drivers/iommu/msm_iommu.c                                       |    2 
 drivers/iommu/mtk_iommu_v1.c                                    |    2 
 drivers/ipack/devices/ipoctal.c                                 |   70 
 drivers/irqchip/irq-gic-v3-its.c                                |   23 
 drivers/irqchip/irq-mbigen.c                                    |   20 
 drivers/irqchip/irq-renesas-irqc.c                              |    1 
 drivers/irqchip/irq-renesas-rzg2l.c                             |    4 
 drivers/leds/leds-pca9532.c                                     |   18 
 drivers/mailbox/pcc.c                                           |   70 
 drivers/mailbox/qcom-ipcc.c                                     |   17 
 drivers/mailbox/rockchip-mailbox.c                              |   17 
 drivers/md/dm-era-target.c                                      |    5 
 drivers/md/dm-log-userspace-base.c                              |    1 
 drivers/md/dm-stats.c                                           |    6 
 drivers/md/dm-switch.c                                          |    2 
 drivers/md/dm.c                                                 |   14 
 drivers/md/md-bitmap.c                                          |    6 
 drivers/md/md.c                                                 |    9 
 drivers/md/persistent-data/dm-array.c                           |   16 
 drivers/md/raid1.c                                              |    2 
 drivers/md/raid5-ppl.c                                          |    4 
 drivers/md/raid5.c                                              |   23 
 drivers/media/cec/core/cec-adap.c                               |    8 
 drivers/media/cec/core/cec-core.c                               |    2 
 drivers/media/cec/core/cec-pin.c                                |    8 
 drivers/media/cec/platform/meson/ao-cec-g12a.c                  |    1 
 drivers/media/cec/platform/stm32/stm32-cec.c                    |    3 
 drivers/media/dvb-frontends/rtl2832_sdr.c                       |   21 
 drivers/media/i2c/ov02a10.c                                     |   12 
 drivers/media/i2c/ov7740.c                                      |    4 
 drivers/media/i2c/rdacm21.c                                     |    5 
 drivers/media/i2c/video-i2c.c                                   |    8 
 drivers/media/pci/cobalt/cobalt-alsa-main.c                     |    1 
 drivers/media/pci/cx23885/cimax2.c                              |    1 
 drivers/media/pci/saa7164/saa7164-core.c                        |    8 
 drivers/media/pci/zoran/zoran_card.c                            |    2 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c         |    6 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c            |    2 
 drivers/media/platform/qcom/venus/hfi_parser.c                  |    9 
 drivers/media/rc/sunxi-cir.c                                    |    9 
 drivers/media/test-drivers/vicodec/vicodec-core.c               |    4 
 drivers/media/test-drivers/vimc/vimc-capture.c                  |    4 
 drivers/media/tuners/tda18250.c                                 |    4 
 drivers/media/usb/airspy/airspy.c                               |   17 
 drivers/media/usb/cx231xx/cx231xx-video.c                       |    4 
 drivers/media/usb/em28xx/em28xx-cards.c                         |    3 
 drivers/media/usb/em28xx/em28xx-core.c                          |    2 
 drivers/media/usb/go7007/snd-go7007.c                           |   10 
 drivers/media/usb/s2255/s2255drv.c                              |   11 
 drivers/media/usb/usbtv/usbtv-audio.c                           |   11 
 drivers/media/v4l2-core/v4l2-async.c                            |   19 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                       |   49 
 drivers/media/v4l2-core/v4l2-dev.c                              |   14 
 drivers/media/v4l2-core/v4l2-fwnode.c                           |    2 
 drivers/mfd/iqs62x.c                                            |    2 
 drivers/mfd/rave-sp.c                                           |   64 
 drivers/misc/ad525x_dpot-i2c.c                                  |    1 
 drivers/misc/ad525x_dpot-spi.c                                  |    1 
 drivers/misc/ad525x_dpot.c                                      |  177 +-
 drivers/misc/ad525x_dpot.h                                      |    3 
 drivers/misc/bcm-vk/bcm_vk_msg.c                                |    6 
 drivers/misc/cardreader/rtsx_pcr.c                              |    2 
 drivers/misc/cardreader/rtsx_usb.c                              |   23 
 drivers/misc/vmw_vmci/vmci_event.c                              |    4 
 drivers/mmc/host/via-sdmmc.c                                    |    8 
 drivers/mtd/mtdoops.c                                           |    3 
 drivers/mtd/mtdpart.c                                           |    3 
 drivers/mtd/mtdswap.c                                           |    1 
 drivers/mtd/nand/raw/nand_onfi.c                                |   27 
 drivers/mtd/parsers/afs.c                                       |    7 
 drivers/mtd/ubi/attach.c                                        |    4 
 drivers/mtd/ubi/build.c                                         |   35 
 drivers/mtd/ubi/cdev.c                                          |    3 
 drivers/mtd/ubi/eba.c                                           |    3 
 drivers/mtd/ubi/fastmap-wl.c                                    |   53 
 drivers/mtd/ubi/fastmap.c                                       |   68 
 drivers/mtd/ubi/io.c                                            |   11 
 drivers/mtd/ubi/ubi.h                                           |   12 
 drivers/mtd/ubi/wl.c                                            |   32 
 drivers/mtd/ubi/wl.h                                            |    6 
 drivers/net/bonding/bond_netlink.c                              |    2 
 drivers/net/can/usb/peak_usb/pcan_usb_core.c                    |    2 
 drivers/net/dsa/b53/b53_common.c                                |    2 
 drivers/net/dsa/mv88e6xxx/pcs-6352.c                            |    5 
 drivers/net/ethernet/allwinner/sun4i-emac.c                     |    4 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c                |    3 
 drivers/net/ethernet/freescale/fec_main.c                       |    6 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c         |   12 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c          |    3 
 drivers/net/ethernet/intel/ice/ice_lib.c                        |    3 
 drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c          |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c             |   11 
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c               |    2 
 drivers/net/ethernet/nvidia/forcedeth.c                         |    6 
 drivers/net/ethernet/qlogic/qede/qede.h                         |    8 
 drivers/net/ethernet/qlogic/qede/qede_fp.c                      |    1 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c            |    1 
 drivers/net/ethernet/realtek/8139cp.c                           |    2 
 drivers/net/ethernet/renesas/ravb.h                             |    1 
 drivers/net/ethernet/renesas/ravb_main.c                        |    3 
 drivers/net/ethernet/renesas/ravb_ptp.c                         |   15 
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c            |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c               |    2 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c             |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c          |   41 
 drivers/net/ethernet/sun/niu.c                                  |    2 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                     |    4 
 drivers/net/gtp.c                                               |    2 
 drivers/net/ipa/ipa_main.c                                      |   29 
 drivers/net/ntb_netdev.c                                        |   38 
 drivers/net/ppp/pppox.c                                         |   17 
 drivers/net/slip/slip.c                                         |   19 
 drivers/net/thunderbolt/main.c                                  |   18 
 drivers/net/tun.c                                               |   21 
 drivers/net/usb/qmi_wwan.c                                      |    1 
 drivers/net/vxlan/vxlan_core.c                                  |    2 
 drivers/net/vxlan/vxlan_mdb.c                                   |  365 ++++
 drivers/net/vxlan/vxlan_private.h                               |    4 
 drivers/net/vxlan/vxlan_vnifilter.c                             |    6 
 drivers/net/wireless/ath/ath10k/snoc.c                          |    9 
 drivers/net/wireless/ath/ath11k/Makefile                        |    4 
 drivers/net/wireless/ath/ath11k/core.c                          |    8 
 drivers/net/wireless/ath/ath11k/core.h                          |   15 
 drivers/net/wireless/ath/ath11k/dp_rx.c                         |   30 
 drivers/net/wireless/ath/ath11k/fw.c                            |  168 ++
 drivers/net/wireless/ath/ath11k/fw.h                            |   27 
 drivers/net/wireless/ath/ath11k/mhi.c                           |   18 
 drivers/net/wireless/ath/ath11k/p2p.c                           |  149 +
 drivers/net/wireless/ath/ath11k/p2p.h                           |   22 
 drivers/net/wireless/ath/ath11k/pci.c                           |    2 
 drivers/net/wireless/ath/ath11k/qmi.c                           |   56 
 drivers/net/wireless/ath/ath11k/testmode.c                      |    2 
 drivers/net/wireless/ath/ath11k/wmi.c                           |  167 +-
 drivers/net/wireless/ath/ath11k/wmi.h                           |   35 
 drivers/net/wireless/ath/ath12k/wmi.c                           |   12 
 drivers/net/wireless/ath/ath6kl/cfg80211.c                      |    5 
 drivers/net/wireless/ath/ath6kl/wmi.c                           |   17 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c         |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c          |    2 
 drivers/net/wireless/intel/iwlwifi/fw/dump.c                    |    2 
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c                |    8 
 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h                |   10 
 drivers/net/wireless/intel/iwlwifi/mei/main.c                   |   66 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                    |    2 
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c                |   12 
 drivers/net/wireless/marvell/mwifiex/usb.c                      |    2 
 drivers/net/wireless/mediatek/mt76/mt7615/main.c                |    5 
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c              |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                |    9 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                 |    6 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                |    8 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                 |   10 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                 |    6 
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h              |   18 
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c                 |    9 
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c                 |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c            |    5 
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c              |    6 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                 |    1 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                 |   16 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                 |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c                |   12 
 drivers/net/wireless/mediatek/mt76/sdio.c                       |   11 
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c              |    2 
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c              |    2 
 drivers/net/wireless/realtek/rtlwifi/pci.c                      |    6 
 drivers/net/wireless/realtek/rtw88/tx.c                         |    1 
 drivers/net/wireless/realtek/rtw89/mac.c                        |    2 
 drivers/net/wireless/virtual/mac80211_hwsim.c                   |    5 
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c                    |    8 
 drivers/nfc/pn533/pn533.c                                       |   21 
 drivers/ntb/ntb_transport.c                                     |   38 
 drivers/nvdimm/btt.c                                            |    8 
 drivers/nvdimm/label.c                                          |   17 
 drivers/nvme/host/apple.c                                       |  227 ++-
 drivers/nvme/host/core.c                                        |    2 
 drivers/nvme/host/fc.c                                          |    8 
 drivers/nvme/host/ioctl.c                                       |  117 +
 drivers/nvme/host/pci.c                                         |    1 
 drivers/nvme/host/tcp.c                                         |   52 
 drivers/nvme/target/auth.c                                      |    6 
 drivers/nvme/target/core.c                                      |    2 
 drivers/nvme/target/fabrics-cmd-auth.c                          |   12 
 drivers/nvme/target/nvmet.h                                     |    2 
 drivers/nvme/target/rdma.c                                      |  121 +
 drivers/nvme/target/tcp.c                                       |   10 
 drivers/nvme/target/zns.c                                       |    2 
 drivers/of/base.c                                               |    2 
 drivers/of/property.c                                           |   91 +
 drivers/parisc/eisa.c                                           |    5 
 drivers/pci/controller/cadence/pci-j721e.c                      |    4 
 drivers/pci/controller/dwc/pci-meson.c                          |    2 
 drivers/pci/controller/pci-hyperv.c                             |    1 
 drivers/pci/controller/pci-xgene.c                              |   11 
 drivers/pci/msi/msi.c                                           |   10 
 drivers/pci/pci-sysfs.c                                         |    4 
 drivers/pci/proc.c                                              |   16 
 drivers/pci/quirks.c                                            |    6 
 drivers/perf/arm_spe_pmu.c                                      |    2 
 drivers/perf/cxl_pmu.c                                          |    2 
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c                       |    2 
 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c                  |   12 
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c                         |   12 
 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c                       |   43 
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c                   |   26 
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c                |    2 
 drivers/phy/starfive/phy-jh7110-dphy-rx.c                       |    5 
 drivers/phy/sunplus/phy-sunplus-usb2.c                          |    6 
 drivers/pinctrl/bcm/pinctrl-bcm2835.c                           |    1 
 drivers/pinctrl/mediatek/mtk-eint.c                             |  344 ++--
 drivers/pinctrl/mediatek/mtk-eint.h                             |   28 
 drivers/pinctrl/mediatek/pinctrl-moore.h                        |   12 
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c                |   40 
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h                |    1 
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c                   |   14 
 drivers/pinctrl/mediatek/pinctrl-paris.h                        |   19 
 drivers/pinctrl/pinctrl-rockchip.c                              |   10 
 drivers/platform/chrome/cros_ec_debugfs.c                       |    6 
 drivers/platform/chrome/cros_ec_sensorhub_ring.c                |   28 
 drivers/platform/chrome/cros_ec_typec.c                         |    6 
 drivers/platform/mellanox/mlxbf-bootctl.c                       |    1 
 drivers/platform/mellanox/mlxbf-pmc.c                           |   10 
 drivers/platform/surface/surface_acpi_notify.c                  |    6 
 drivers/platform/x86/dell/dell-wmi-base.c                       |   17 
 drivers/platform/x86/dell/dell-wmi-privacy.c                    |    4 
 drivers/platform/x86/dell/dell-wmi-sysman/biosattr-interface.c  |    1 
 drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h     |    2 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c                    |   18 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h                    |    8 
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c            |   15 
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c             |    6 
 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c      |   14 
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c       |   19 
 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c          |    4 
 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c          |    6 
 drivers/platform/x86/intel/ishtp_eclite.c                       |    5 
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c     |   30 
 drivers/pmdomain/bcm/bcm2835-power.c                            |    7 
 drivers/power/supply/bd99954-charger.h                          |   23 
 drivers/power/supply/bq24257_charger.c                          |   16 
 drivers/power/supply/bq256xx_charger.c                          |   29 
 drivers/power/supply/bq25890_charger.c                          |   12 
 drivers/power/supply/bq27xxx_battery.c                          |    6 
 drivers/power/supply/cros_usbpd-charger.c                       |   17 
 drivers/power/supply/isp1704_charger.c                          |    1 
 drivers/power/supply/lp8727_charger.c                           |    4 
 drivers/power/supply/max17040_battery.c                         |    6 
 drivers/power/supply/qcom_battmgr.c                             |    2 
 drivers/power/supply/rt9455_charger.c                           |   21 
 drivers/power/supply/sbs-battery.c                              |    7 
 drivers/power/supply/sc2731_charger.c                           |    8 
 drivers/power/supply/twl4030_charger.c                          |   12 
 drivers/power/supply/ucs1002_power.c                            |    6 
 drivers/pps/clients/pps-gpio.c                                  |   62 
 drivers/pps/pps.c                                               |   10 
 drivers/rapidio/devices/rio_mport_cdev.c                        |   10 
 drivers/rapidio/rio-scan.c                                      |    1 
 drivers/regulator/Kconfig                                       |    4 
 drivers/regulator/as3722-regulator.c                            |    1 
 drivers/regulator/core.c                                        |    6 
 drivers/regulator/max8998.c                                     |    1 
 drivers/regulator/qcom-refgen-regulator.c                       |    4 
 drivers/regulator/qcom-rpmh-regulator.c                         |    6 
 drivers/regulator/tps6594-regulator.c                           |  437 ++++-
 drivers/remoteproc/mtk_scp.c                                    |    9 
 drivers/remoteproc/qcom_common.c                                |    4 
 drivers/remoteproc/qcom_q6v5_adsp.c                             |    1 
 drivers/remoteproc/remoteproc_core.c                            |  150 +
 drivers/remoteproc/remoteproc_sysfs.c                           |    1 
 drivers/rpmsg/qcom_glink_native.c                               |   42 
 drivers/rpmsg/qcom_glink_smem.c                                 |    7 
 drivers/rtc/rtc-gamecube.c                                      |    4 
 drivers/rtc/rtc-pcf85363.c                                      |   17 
 drivers/rtc/rtc-pcf8563.c                                       |    4 
 drivers/rtc/rtc-rzn1.c                                          |   10 
 drivers/rtc/rtc-zynqmp.c                                        |    7 
 drivers/s390/block/dasd.c                                       |    6 
 drivers/s390/block/dasd_eckd.c                                  |   40 
 drivers/s390/block/dasd_erp.c                                   |    3 
 drivers/s390/crypto/vfio_ap_ops.c                               |  176 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                             |    2 
 drivers/scsi/pm8001/pm8001_init.c                               |    4 
 drivers/scsi/qla2xxx/qla_attr.c                                 |    7 
 drivers/scsi/qla2xxx/qla_bsg.c                                  |   39 
 drivers/scsi/qla2xxx/qla_dbg.c                                  |    2 
 drivers/scsi/qla2xxx/qla_dfs.c                                  |    4 
 drivers/scsi/qla2xxx/qla_edif.c                                 |    3 
 drivers/scsi/qla2xxx/qla_gs.c                                   |    4 
 drivers/scsi/qla2xxx/qla_init.c                                 |   61 
 drivers/scsi/qla2xxx/qla_inline.h                               |   13 
 drivers/scsi/qla2xxx/qla_isr.c                                  |   39 
 drivers/scsi/qla2xxx/qla_mbx.c                                  |   28 
 drivers/scsi/qla2xxx/qla_nvme.c                                 |   31 
 drivers/scsi/qla2xxx/qla_nx2.c                                  |    2 
 drivers/scsi/qla2xxx/qla_os.c                                   |   14 
 drivers/scsi/scsi_lib.c                                         |    2 
 drivers/scsi/sd.c                                               |    4 
 drivers/scsi/smartpqi/smartpqi_init.c                           |   18 
 drivers/soc/fsl/qe/qe_ic.c                                      |    3 
 drivers/soc/qcom/rpmh-rsc.c                                     |   37 
 drivers/soc/samsung/exynos-pmu.c                                |    4 
 drivers/soundwire/qcom.c                                        |    2 
 drivers/spi/spi-bcm63xx-hsspi.c                                 |    8 
 drivers/spi/spi-bcm63xx.c                                       |    6 
 drivers/spi/spi-bcmbca-hsspi.c                                  |    8 
 drivers/spi/spi-davinci.c                                       |   22 
 drivers/spi/spi-img-spfi.c                                      |    5 
 drivers/spi/spi-sprd-adi.c                                      |    6 
 drivers/staging/fbtft/fbtft-sysfs.c                             |    2 
 drivers/staging/greybus/audio_gb.c                              |   13 
 drivers/staging/greybus/audio_manager_sysfs.c                   |    2 
 drivers/staging/greybus/hid.c                                   |    2 
 drivers/staging/media/meson/vdec/vdec.c                         |    4 
 drivers/staging/media/sunxi/cedrus/cedrus.c                     |    4 
 drivers/staging/media/tegra-video/vi.c                          |    9 
 drivers/staging/media/tegra-video/vip.c                         |   10 
 drivers/staging/octeon/ethernet-mem.c                           |   43 
 drivers/staging/octeon/ethernet-mem.h                           |    8 
 drivers/staging/octeon/ethernet-rx.c                            |   51 
 drivers/staging/octeon/ethernet-rx.h                            |   11 
 drivers/staging/octeon/ethernet-tx.c                            |    2 
 drivers/staging/octeon/ethernet.c                               |   43 
 drivers/staging/octeon/octeon-ethernet.h                        |   14 
 drivers/staging/rtl8723bs/core/rtw_cmd.c                        |    8 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c                  |    7 
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c                    |    4 
 drivers/staging/sm750fb/sm750.c                                 |    4 
 drivers/target/iscsi/iscsi_target_login.c                       |    2 
 drivers/thermal/imx_thermal.c                                   |    9 
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c         |    4 
 drivers/thermal/qoriq_thermal.c                                 |   13 
 drivers/thermal/rcar_thermal.c                                  |   15 
 drivers/tty/hvc/Kconfig                                         |    2 
 drivers/tty/serial/amba-pl011.c                                 |   10 
 drivers/tty/serial/ma35d1_serial.c                              |   12 
 drivers/tty/tty_io.c                                            |    4 
 drivers/ufs/core/ufs-debugfs.c                                  |    2 
 drivers/ufs/core/ufshcd.c                                       |   18 
 drivers/uio/uio.c                                               |    5 
 drivers/usb/atm/usbatm.c                                        |    4 
 drivers/usb/common/common.c                                     |    3 
 drivers/usb/core/driver.c                                       |   88 -
 drivers/usb/core/usb.c                                          |    2 
 drivers/usb/core/usb.h                                          |    8 
 drivers/usb/dwc2/gadget.c                                       |   11 
 drivers/usb/gadget/configfs.c                                   |    4 
 drivers/usb/gadget/function/f_fs.c                              |   14 
 drivers/usb/gadget/function/f_mass_storage.c                    |    2 
 drivers/usb/gadget/function/f_midi2.c                           |   19 
 drivers/usb/gadget/function/f_tcm.c                             |   23 
 drivers/usb/gadget/function/f_uac1_legacy.c                     |   56 
 drivers/usb/gadget/function/f_uvc.c                             |    7 
 drivers/usb/gadget/function/u_audio.c                           |   24 
 drivers/usb/gadget/function/u_uac1_legacy.h                     |    3 
 drivers/usb/gadget/functions.c                                  |    2 
 drivers/usb/gadget/legacy/inode.c                               |    3 
 drivers/usb/gadget/udc/aspeed_udc.c                             |   43 
 drivers/usb/gadget/udc/r8a66597-udc.c                           |    1 
 drivers/usb/gadget/udc/snps_udc_plat.c                          |    5 
 drivers/usb/host/xhci-ring.c                                    |   32 
 drivers/usb/image/mdc800.c                                      |    4 
 drivers/usb/misc/onboard_usb_hub.c                              |    2 
 drivers/usb/mtu3/mtu3_core.c                                    |   11 
 drivers/usb/phy/phy-fsl-usb.c                                   |   52 
 drivers/usb/phy/phy-fsl-usb.h                                   |    6 
 drivers/usb/renesas_usbhs/common.c                              |    6 
 drivers/usb/serial/bus.c                                        |    6 
 drivers/usb/serial/usb-serial.c                                 |    6 
 drivers/usb/storage/ene_ub6250.c                                |    2 
 drivers/usb/storage/uas.c                                       |    2 
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c             |    2 
 drivers/usb/typec/ucsi/debugfs.c                                |    1 
 drivers/usb/typec/ucsi/displayport.c                            |    2 
 drivers/usb/typec/ucsi/ucsi.c                                   |   12 
 drivers/usb/typec/ucsi/ucsi.h                                   |    3 
 drivers/usb/typec/ucsi/ucsi_acpi.c                              |    3 
 drivers/usb/usbip/stub_main.c                                   |    8 
 drivers/vdpa/mlx5/core/mr.c                                     |    2 
 drivers/vdpa/vdpa_sim/vdpa_sim.c                                |   25 
 drivers/vfio/pci/vfio_pci_config.c                              |    1 
 drivers/video/fbdev/kyro/fbdev.c                                |   24 
 drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c        |    4 
 drivers/video/fbdev/pvr2fb.c                                    |    4 
 drivers/video/fbdev/ssd1307fb.c                                 |   72 
 drivers/video/fbdev/tdfxfb.c                                    |    2 
 drivers/video/fbdev/uvesafb.c                                   |    2 
 drivers/video/sticore.c                                         |   22 
 drivers/virtio/virtio_balloon.c                                 |    6 
 drivers/w1/masters/ds2482.c                                     |    4 
 drivers/w1/slaves/w1_ds28e17.c                                  |    8 
 drivers/watchdog/pseries-wdt.c                                  |   53 
 drivers/xen/xenbus/xenbus_xs.c                                  |   16 
 fs/btrfs/verity.c                                               |   16 
 fs/ceph/caps.c                                                  |   11 
 fs/ceph/crypto.c                                                |   34 
 fs/ceph/export.c                                                |   26 
 fs/ceph/file.c                                                  |   48 
 fs/ceph/mdsmap.c                                                |   11 
 fs/ceph/xattr.c                                                 |   17 
 fs/ecryptfs/crypto.c                                            |    2 
 fs/ecryptfs/ecryptfs_kernel.h                                   |    3 
 fs/ecryptfs/keystore.c                                          |   45 
 fs/ecryptfs/messaging.c                                         |   11 
 fs/ecryptfs/miscdev.c                                           |    5 
 fs/ecryptfs/super.c                                             |    7 
 fs/efivarfs/super.c                                             |   30 
 fs/erofs/Kconfig                                                |    8 
 fs/ext4/file.c                                                  |    7 
 fs/ext4/inline.c                                                |   11 
 fs/ext4/inode.c                                                 |   28 
 fs/ext4/migrate.c                                               |    3 
 fs/ext4/namei.c                                                 |    2 
 fs/ext4/orphan.c                                                |   10 
 fs/f2fs/file.c                                                  |  116 +
 fs/f2fs/namei.c                                                 |   11 
 fs/f2fs/xattr.c                                                 |    2 
 fs/fat/misc.c                                                   |    4 
 fs/fat/nfs.c                                                    |    4 
 fs/fuse/control.c                                               |    2 
 fs/fuse/cuse.c                                                  |    5 
 fs/fuse/dev.c                                                   |   40 
 fs/fuse/dir.c                                                   |   21 
 fs/fuse/fuse_i.h                                                |   36 
 fs/fuse/inode.c                                                 |   87 -
 fs/fuse/readdir.c                                               |   42 
 fs/hfsplus/catalog.c                                            |   25 
 fs/hfsplus/hfsplus_fs.h                                         |    6 
 fs/hugetlbfs/inode.c                                            |    3 
 fs/isofs/compress.c                                             |    7 
 fs/lockd/svcsubs.c                                              |   55 
 fs/nfs/client.c                                                 |   21 
 fs/nfs/filelayout/filelayoutdev.c                               |    3 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                       |    3 
 fs/nfs/inode.c                                                  |    4 
 fs/nfs/internal.h                                               |    1 
 fs/nfs/netns.h                                                  |    6 
 fs/nfs/nfs4client.c                                             |    1 
 fs/nfs/pnfs.c                                                   |   36 
 fs/nfs/pnfs.h                                                   |    3 
 fs/nfs/pnfs_nfs.c                                               |   39 
 fs/nfsd/flexfilelayoutxdr.c                                     |   20 
 fs/nfsd/nfs2acl.c                                               |   52 
 fs/nfsd/nfs3acl.c                                               |   17 
 fs/nfsd/nfs4proc.c                                              |   39 
 fs/nfsd/nfs4state.c                                             |  202 ++
 fs/nfsd/nfs4xdr.c                                               |   17 
 fs/nfsd/nfscache.c                                              |    2 
 fs/nfsd/nfsfh.c                                                 |    4 
 fs/nfsd/nfsproc.c                                               |    7 
 fs/nfsd/nfssvc.c                                                |    4 
 fs/nfsd/nfsxdr.c                                                |   32 
 fs/nfsd/vfs.c                                                   |    4 
 fs/nilfs2/bmap.c                                                |    2 
 fs/nilfs2/bmap.h                                                |    2 
 fs/nilfs2/btnode.c                                              |   30 
 fs/nilfs2/btree.c                                               |   39 
 fs/nilfs2/direct.c                                              |    4 
 fs/nilfs2/page.c                                                |   66 
 fs/nilfs2/page.h                                                |    8 
 fs/nilfs2/segment.c                                             |   40 
 fs/nilfs2/the_nilfs.c                                           |    6 
 fs/notify/fanotify/fanotify_user.c                              |   17 
 fs/notify/inotify/inotify_user.c                                |   15 
 fs/ntfs3/attrib.c                                               |   11 
 fs/ntfs3/frecord.c                                              |   88 -
 fs/ntfs3/fslog.c                                                |   47 
 fs/ntfs3/fsntfs.c                                               |    8 
 fs/ntfs3/ntfs_fs.h                                              |   21 
 fs/ntfs3/record.c                                               |  125 +
 fs/ntfs3/super.c                                                |   13 
 fs/ntfs3/xattr.c                                                |   21 
 fs/ocfs2/acl.c                                                  |  135 +
 fs/ocfs2/acl.h                                                  |   19 
 fs/ocfs2/cluster/heartbeat.c                                    |  191 +-
 fs/ocfs2/cluster/heartbeat.h                                    |    5 
 fs/ocfs2/cluster/nodemanager.c                                  |   10 
 fs/ocfs2/cluster/nodemanager.h                                  |    1 
 fs/ocfs2/cluster/tcp.c                                          |   83 -
 fs/ocfs2/cluster/tcp.h                                          |    1 
 fs/ocfs2/dir.c                                                  |    2 
 fs/ocfs2/dlm/dlmmaster.c                                        |    6 
 fs/ocfs2/dlm/dlmrecovery.c                                      |    9 
 fs/ocfs2/namei.c                                                |   17 
 fs/ocfs2/refcounttree.c                                         |   47 
 fs/ocfs2/xattr.c                                                |   91 -
 fs/ocfs2/xattr.h                                                |    9 
 fs/orangefs/devorangefs-req.c                                   |    1 
 fs/orangefs/orangefs-debugfs.c                                  |    1 
 fs/smb/client/cifs_debug.c                                      |    2 
 fs/smb/client/cifsfs.c                                          |   15 
 fs/smb/client/dfs_cache.c                                       |   33 
 fs/smb/client/smb1ops.c                                         |    2 
 fs/smb/client/smb2file.c                                        |    5 
 fs/smb/client/smb2pdu.c                                         |   16 
 fs/smb/server/auth.c                                            |    1 
 fs/smb/server/connection.c                                      |   19 
 fs/smb/server/connection.h                                      |    1 
 fs/smb/server/mgmt/user_config.c                                |    1 
 fs/smb/server/mgmt/user_session.c                               |   11 
 fs/smb/server/mgmt/user_session.h                               |    1 
 fs/smb/server/server.c                                          |    4 
 fs/smb/server/smb2ops.c                                         |   11 
 fs/smb/server/smb2pdu.c                                         |   39 
 fs/smb/server/smbacl.c                                          |   20 
 fs/smb/server/transport_ipc.c                                   |   12 
 fs/smb/server/transport_tcp.c                                   |    6 
 fs/smb/server/vfs.c                                             |    3 
 fs/smb/server/vfs_cache.c                                       |   13 
 fs/squashfs/cache.c                                             |    2 
 fs/tracefs/event_inode.c                                        |    7 
 fs/ubifs/auth.c                                                 |    2 
 fs/udf/inode.c                                                  |    2 
 fs/udf/partition.c                                              |    2 
 fs/udf/super.c                                                  |   23 
 fs/udf/symlink.c                                                |    2 
 include/acpi/pcc.h                                              |    5 
 include/acpi/processor.h                                        |    2 
 include/linux/bpf.h                                             |    4 
 include/linux/efi.h                                             |    4 
 include/linux/irq.h                                             |   35 
 include/linux/irqdomain.h                                       |   46 
 include/linux/kprobes.h                                         |    1 
 include/linux/list.h                                            |   15 
 include/linux/maple_tree.h                                      |    2 
 include/linux/mfd/tps6594.h                                     |  347 ++++
 include/linux/netdevice.h                                       |   10 
 include/linux/nfs_xdr.h                                         |    2 
 include/linux/nvme.h                                            |   81 +
 include/linux/of_graph.h                                        |   53 
 include/linux/rcutiny.h                                         |    2 
 include/linux/rcutree.h                                         |    3 
 include/linux/remoteproc.h                                      |  284 ---
 include/linux/rsc_table.h                                       |  364 ++++
 include/linux/rtsx_usb.h                                        |    3 
 include/linux/sunrpc/svc_rdma_pcl.h                             |    2 
 include/linux/usb.h                                             |   29 
 include/linux/virtio_net.h                                      |    4 
 include/media/rc-map.h                                          |    2 
 include/net/bluetooth/hci_core.h                                |    2 
 include/net/bluetooth/l2cap.h                                   |    5 
 include/net/dst.h                                               |   34 
 include/net/inet_connection_sock.h                              |   12 
 include/net/inet_hashtables.h                                   |    2 
 include/net/inetpeer.h                                          |    4 
 include/net/ip.h                                                |   11 
 include/net/ip_tunnels.h                                        |   11 
 include/net/pkt_sched.h                                         |    1 
 include/net/route.h                                             |    2 
 include/net/sctp/structs.h                                      |    2 
 include/net/tcp.h                                               |   13 
 include/net/xsk_buff_pool.h                                     |   19 
 include/rdma/ib_verbs.h                                         |   14 
 include/rdma/restrack.h                                         |    7 
 include/sound/core.h                                            |    2 
 include/uapi/linux/if_bridge.h                                  |   19 
 include/uapi/linux/if_link.h                                    |    1 
 include/uapi/linux/landlock.h                                   |    1 
 include/uapi/linux/time_types.h                                 |    2 
 include/uapi/rdma/rdma_netlink.h                                |    8 
 kernel/auditfilter.c                                            |    6 
 kernel/bpf/bloom_filter.c                                       |   19 
 kernel/bpf/cgroup.c                                             |   18 
 kernel/bpf/net_namespace.c                                      |   17 
 kernel/bpf/ringbuf.c                                            |    2 
 kernel/bpf/syscall.c                                            |   21 
 kernel/bpf/task_iter.c                                          |   36 
 kernel/bpf/verifier.c                                           |   20 
 kernel/cgroup/cpuset.c                                          |    4 
 kernel/dma/swiotlb.c                                            |   31 
 kernel/entry/common.c                                           |    3 
 kernel/futex/requeue.c                                          |   12 
 kernel/irq/generic-chip.c                                       |   91 -
 kernel/irq/irqdomain.c                                          |   91 +
 kernel/kcsan/core.c                                             |   12 
 kernel/kprobes.c                                                |   14 
 kernel/locking/lockdep.c                                        |    2 
 kernel/power/snapshot.c                                         |    5 
 kernel/power/wakelock.c                                         |    2 
 kernel/rcu/rcutorture.c                                         |    4 
 kernel/rcu/tree.c                                               |    4 
 kernel/rcu/tree_nocb.h                                          |    2 
 kernel/rcu/tree_plugin.h                                        |   16 
 kernel/sched/cpufreq_schedutil.c                                |   17 
 kernel/sched/fair.c                                             |   27 
 kernel/signal.c                                                 |    4 
 kernel/stop_machine.c                                           |    2 
 kernel/sys.c                                                    |    2 
 kernel/taskstats.c                                              |    3 
 kernel/time/clocksource.c                                       |    8 
 kernel/time/itimer.c                                            |    2 
 kernel/time/timekeeping.c                                       |    6 
 kernel/time/timer.c                                             |    1 
 kernel/trace/trace.c                                            |   28 
 kernel/trace/trace.h                                            |    4 
 kernel/trace/trace_events.c                                     |  134 +
 kernel/trace/trace_events_hist.c                                |    4 
 kernel/trace/trace_events_user.c                                |    3 
 kernel/trace/trace_mmiotrace.c                                  |   24 
 kernel/trace/trace_osnoise.c                                    |    4 
 lib/string.c                                                    |    3 
 lib/test_hmm.c                                                  |    2 
 lib/ucs2_string.c                                               |    2 
 lib/xarray.c                                                    |    3 
 mm/damon/core-test.h                                            |   15 
 mm/damon/core.c                                                 |   17 
 mm/damon/paddr.c                                                |   21 
 mm/damon/sysfs-schemes.c                                        |   10 
 mm/damon/sysfs.c                                                |   19 
 mm/damon/vaddr-test.h                                           |    5 
 mm/damon/vaddr.c                                                |   34 
 mm/hugetlb.c                                                    |   14 
 mm/kasan/quarantine.c                                           |    7 
 mm/memcontrol.c                                                 |    6 
 mm/migrate.c                                                    |    2 
 mm/mm_init.c                                                    |    5 
 mm/vmscan.c                                                     |    2 
 net/batman-adv/bridge_loop_avoidance.c                          |   78 -
 net/batman-adv/distributed-arp-table.c                          |   66 
 net/batman-adv/main.c                                           |    4 
 net/batman-adv/types.h                                          |    2 
 net/bluetooth/eir.c                                             |    3 
 net/bluetooth/hci_conn.c                                        |   23 
 net/bluetooth/hci_core.c                                        |    2 
 net/bluetooth/hci_event.c                                       |    7 
 net/bluetooth/hci_sync.c                                        |   14 
 net/bluetooth/iso.c                                             |    8 
 net/bluetooth/l2cap_sock.c                                      |   36 
 net/bluetooth/mgmt.c                                            |   27 
 net/bluetooth/msft.c                                            |    5 
 net/bluetooth/rfcomm/core.c                                     |   12 
 net/bridge/br_mrp_netlink.c                                     |    4 
 net/bridge/br_netlink_tunnel.c                                  |    3 
 net/bridge/br_vlan.c                                            |    4 
 net/ceph/messenger_v2.c                                         |    5 
 net/ceph/osd_client.c                                           |   30 
 net/ceph/osdmap.c                                               |    2 
 net/core/dst.c                                                  |    4 
 net/core/filter.c                                               |   26 
 net/core/lwt_bpf.c                                              |   15 
 net/core/net_namespace.c                                        |    4 
 net/core/skbuff.c                                               |   10 
 net/core/sock.c                                                 |    8 
 net/core/xdp.c                                                  |    4 
 net/dccp/dccp.h                                                 |    4 
 net/dccp/ipv4.c                                                 |    4 
 net/dccp/ipv6.c                                                 |    7 
 net/dccp/minisocks.c                                            |    2 
 net/hsr/hsr_device.c                                            |   70 
 net/hsr/hsr_device.h                                            |    4 
 net/hsr/hsr_forward.c                                           |   85 +
 net/hsr/hsr_framereg.c                                          |   52 
 net/hsr/hsr_framereg.h                                          |    4 
 net/hsr/hsr_main.h                                              |    7 
 net/hsr/hsr_netlink.c                                           |   30 
 net/hsr/hsr_slave.c                                             |   23 
 net/ipv4/icmp.c                                                 |   28 
 net/ipv4/igmp.c                                                 |    2 
 net/ipv4/inet_connection_sock.c                                 |    9 
 net/ipv4/inetpeer.c                                             |   38 
 net/ipv4/ip_fragment.c                                          |    6 
 net/ipv4/ip_output.c                                            |    4 
 net/ipv4/ip_tunnel.c                                            |    2 
 net/ipv4/ip_vti.c                                               |    4 
 net/ipv4/ipip.c                                                 |    2 
 net/ipv4/ipmr.c                                                 |    2 
 net/ipv4/netfilter.c                                            |    4 
 net/ipv4/route.c                                                |   10 
 net/ipv4/syncookies.c                                           |    2 
 net/ipv4/tcp_fastopen.c                                         |    6 
 net/ipv4/tcp_ipv4.c                                             |   11 
 net/ipv4/tcp_metrics.c                                          |    8 
 net/ipv4/tcp_minisocks.c                                        |    2 
 net/ipv4/tcp_output.c                                           |    2 
 net/ipv4/xfrm4_output.c                                         |    2 
 net/ipv6/ip6_gre.c                                              |   14 
 net/ipv6/ip6_tunnel.c                                           |   22 
 net/ipv6/route.c                                                |    2 
 net/ipv6/seg6_local.c                                           |    9 
 net/ipv6/sit.c                                                  |    2 
 net/ipv6/tcp_ipv6.c                                             |   97 -
 net/ipv6/xfrm6_input.c                                          |    2 
 net/iucv/af_iucv.c                                              |    2 
 net/kcm/kcmsock.c                                               |    3 
 net/mac80211/link.c                                             |    3 
 net/mac80211/s1g.c                                              |    2 
 net/mac80211/tx.c                                               |    3 
 net/mpls/af_mpls.c                                              |    2 
 net/mptcp/subflow.c                                             |    6 
 net/mptcp/syncookies.c                                          |    1 
 net/netfilter/Kconfig                                           |    2 
 net/netfilter/ipvs/ip_vs_ftp.c                                  |   10 
 net/netfilter/nf_nat_sip.c                                      |    5 
 net/netfilter/nf_tables_api.c                                   |   14 
 net/netfilter/nft_counter.c                                     |   20 
 net/netfilter/xt_cgroup.c                                       |   21 
 net/netfilter/xt_hl.c                                           |   27 
 net/nfc/digital_core.c                                          |    2 
 net/nfc/llcp_core.c                                             |   29 
 net/nfc/llcp_sock.c                                             |   14 
 net/nfc/nci/data.c                                              |   10 
 net/nfc/nci/rsp.c                                               |   41 
 net/openvswitch/conntrack.c                                     |  130 +
 net/openvswitch/conntrack.h                                     |    6 
 net/openvswitch/datapath.c                                      |   58 
 net/openvswitch/datapath.h                                      |   26 
 net/openvswitch/vport.h                                         |    9 
 net/phonet/pep.c                                                |    2 
 net/rds/cong.c                                                  |    4 
 net/sched/act_skbmod.c                                          |   12 
 net/sched/cls_api.c                                             |   18 
 net/sched/sch_api.c                                             |    7 
 net/sched/sch_codel.c                                           |    2 
 net/sched/sch_fq_codel.c                                        |    6 
 net/sched/sch_fq_pie.c                                          |    3 
 net/sched/sch_generic.c                                         |    2 
 net/sched/sch_hhf.c                                             |    4 
 net/sched/sch_htb.c                                             |    7 
 net/sched/sch_sfq.c                                             |    3 
 net/sched/sch_teql.c                                            |    1 
 net/sctp/inqueue.c                                              |    7 
 net/sctp/sm_sideeffect.c                                        |    4 
 net/sctp/stream.c                                               |   48 
 net/smc/af_smc.c                                                |   11 
 net/smc/smc_core.c                                              |   27 
 net/smc/smc_llc.c                                               |    3 
 net/smc/smc_rx.c                                                |   11 
 net/smc/smc_tx.h                                                |    6 
 net/sunrpc/auth_gss/auth_gss.c                                  |    6 
 net/sunrpc/auth_gss/gss_krb5_wrap.c                             |   13 
 net/sunrpc/auth_gss/gss_rpc_upcall.c                            |    6 
 net/sunrpc/auth_gss/gss_rpc_upcall.h                            |    1 
 net/sunrpc/auth_gss/svcauth_gss.c                               |    8 
 net/sunrpc/cache.c                                              |    7 
 net/sunrpc/rpcb_clnt.c                                          |    4 
 net/sunrpc/sunrpc_syms.c                                        |    1 
 net/sunrpc/svc.c                                                |   74 
 net/sunrpc/xdr.c                                                |    2 
 net/sunrpc/xprtrdma/svc_rdma_rw.c                               |    9 
 net/sunrpc/xprtsock.c                                           |   32 
 net/tls/tls_strp.c                                              |   16 
 net/vmw_vsock/af_vsock.c                                        |    6 
 net/vmw_vsock/virtio_transport.c                                |    2 
 net/xdp/xsk.c                                                   |   46 
 net/xdp/xsk_buff_pool.c                                         |    4 
 net/xdp/xsk_queue.h                                             |   16 
 net/xfrm/xfrm_output.c                                          |    4 
 samples/ftrace/ftrace-direct-modify.c                           |   12 
 samples/ftrace/ftrace-direct-multi-modify.c                     |   12 
 scripts/mod/modpost.c                                           |    6 
 scripts/tags.sh                                                 |    2 
 security/apparmor/lib.c                                         |   20 
 security/integrity/ima/ima_appraise.c                           |    2 
 security/landlock/errata/abi-1.h                                |   23 
 security/landlock/fs.c                                          |   40 
 security/smack/smack.h                                          |    5 
 security/smack/smack_lsm.c                                      |   67 
 security/smack/smackfs.c                                        |  218 --
 sound/core/control.c                                            |  464 ++----
 sound/core/control_compat.c                                     |   87 -
 sound/core/control_led.c                                        |    9 
 sound/core/init.c                                               |    4 
 sound/core/pcm_native.c                                         |    2 
 sound/core/seq/seq_midi.c                                       |   61 
 sound/core/ump_convert.c                                        |    1 
 sound/drivers/aloop.c                                           |  104 -
 sound/drivers/mpu401/mpu401.c                                   |    6 
 sound/drivers/mts64.c                                           |    6 
 sound/drivers/portman2x4.c                                      |    6 
 sound/drivers/serial-u16550.c                                   |    6 
 sound/drivers/virmidi.c                                         |    6 
 sound/parisc/harmony.c                                          |    6 
 sound/pci/asihpi/hpi6000.c                                      |    5 
 sound/pci/hda/hda_proc.c                                        |    2 
 sound/pci/ice1712/ice1712.c                                     |    7 
 sound/pci/pcxhr/pcxhr.c                                         |   14 
 sound/pci/via82xx_modem.c                                       |   26 
 sound/soc/amd/yc/acp6x-mach.c                                   |    7 
 sound/soc/apple/mca.c                                           |    6 
 sound/soc/codecs/cs35l33.c                                      |   14 
 sound/soc/codecs/cs35l34.c                                      |   14 
 sound/soc/codecs/rt700-sdw.c                                    |    6 
 sound/soc/fsl/fsl-asoc-card.c                                   |    4 
 sound/soc/fsl/mpc5200_psc_i2s.c                                 |    1 
 sound/soc/intel/atom/sst/sst_pci.c                              |    4 
 sound/soc/meson/meson-card-utils.c                              |   17 
 sound/soc/pxa/pxa-ssp.c                                         |    7 
 sound/soc/qcom/qdsp6/q6apm.c                                    |   12 
 sound/soc/samsung/aries_wm8994.c                                |    1 
 sound/soc/soc-dapm.c                                            |    2 
 sound/soc/sof/topology.c                                        |   18 
 sound/soc/xilinx/xlnx_formatter_pcm.c                           |   14 
 sound/usb/6fire/comm.c                                          |    9 
 sound/usb/bcd2000/bcd2000.c                                     |   11 
 sound/usb/midi.c                                                |    2 
 tools/bpf/bpftool/map.c                                         |   16 
 tools/bpf/bpftool/struct_ops.c                                  |    4 
 tools/build/Makefile.feature                                    |    3 
 tools/build/feature/Makefile                                    |    3 
 tools/include/linux/compiler.h                                  |    2 
 tools/include/nolibc/arch-powerpc.h                             |    2 
 tools/lib/bpf/libbpf.c                                          |    3 
 tools/perf/builtin-sched.c                                      |   40 
 tools/perf/builtin-stat.c                                       |    9 
 tools/perf/pmu-events/jevents.py                                |    5 
 tools/perf/pmu-events/metric.py                                 |    6 
 tools/perf/tests/shell/lib/perf_metric_validation.py            |  238 +--
 tools/perf/tests/shell/stat_all_metrics.sh                      |  151 +-
 tools/perf/tests/shell/stat_bpf_counters.sh                     |  101 -
 tools/perf/tests/shell/stat_metrics_values.sh                   |   11 
 tools/perf/ui/browsers/hists.c                                  |    6 
 tools/perf/util/auxtrace.c                                      |   15 
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c                 |   21 
 tools/perf/util/cs-etm.c                                        |  587 +++++--
 tools/perf/util/cs-etm.h                                        |    8 
 tools/perf/util/data-convert-json.c                             |    1 
 tools/perf/util/dso.c                                           |   19 
 tools/perf/util/intel-bts.c                                     |    2 
 tools/perf/util/intel-pt.c                                      |    2 
 tools/perf/util/machine.c                                       |   37 
 tools/perf/util/metricgroup.c                                   |    7 
 tools/perf/util/synthetic-events.c                              |    6 
 tools/perf/util/thread-stack.c                                  |    2 
 tools/perf/util/trace-event-read.c                              |   33 
 tools/scripts/Makefile.include                                  |   38 
 tools/testing/kunit/kunit.py                                    |    2 
 tools/testing/kunit/kunit_tool_test.py                          |   12 
 tools/testing/selftests/arm64/mte/check_buffer_fill.c           |    2 
 tools/testing/selftests/arm64/mte/check_child_memory.c          |    2 
 tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c       |    1 
 tools/testing/selftests/arm64/mte/check_hugetlb_options.c       |  298 +++
 tools/testing/selftests/arm64/mte/check_ksm_options.c           |   31 
 tools/testing/selftests/arm64/mte/check_mmap_options.c          |    2 
 tools/testing/selftests/arm64/mte/check_tags_inclusion.c        |    2 
 tools/testing/selftests/arm64/mte/check_user_mem.c              |    2 
 tools/testing/selftests/bpf/README.rst                          |   32 
 tools/testing/selftests/bpf/prog_tests/global_map_resize.c      |    8 
 tools/testing/selftests/bpf/test_progs.c                        |   11 
 tools/testing/selftests/bpf/test_sockmap.c                      |    3 
 tools/testing/selftests/bpf/veristat.c                          |   76 -
 tools/testing/selftests/bpf/vmtest.sh                           |   71 
 tools/testing/selftests/mm/Makefile                             |    4 
 tools/testing/selftests/mm/cow.c                                |  547 ++++---
 tools/testing/selftests/mm/khugepaged.c                         |  417 +----
 tools/testing/selftests/mm/ksm_tests.c                          |  210 +-
 tools/testing/selftests/mm/migration.c                          |  107 +
 tools/testing/selftests/mm/run_vmtests.sh                       |    2 
 tools/testing/selftests/mm/soft-dirty.c                         |    9 
 tools/testing/selftests/mm/thp_settings.c                       |  394 +++++
 tools/testing/selftests/mm/thp_settings.h                       |   89 +
 tools/testing/selftests/rseq/rseq-x86-thread-pointer.h          |    4 
 tools/testing/selftests/timers/leap-a-day.c                     |   19 
 tools/testing/selftests/zram/zram_lib.sh                        |    2 
 1183 files changed, 17639 insertions(+), 8298 deletions(-)

Abdun Nihaal (4):
      wifi: brcmfmac: Fix memory leak in brcmf_sdio_read_control()
      wifi: rtw88: Fix potential memory leak in rtw_txq_push_skb()
      wifi: rtlwifi: pci: fix error path in rtl_pci_probe()
      misc: vmc_vmci: Fix potential memory leak in vmci_event_subscribe()

Abdurrahman Hussain (1):
      of: fix out-of-bounds read in of_alias_scan() stem parser

Ada Couprie Diaz (1):
      arm64: hibernate: mask DAIF before restoring hibernated kernel

Adam Young (1):
      mailbox/pcc: support mailbox management of the shared buffer

Adrian Hunter (5):
      i3c: master: Fix info leak and UAF in device unregister path
      i3c: master: Fix device_register() error path
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
      parse_longname(): strrchr() expects NUL-terminated string

Alban Bedel (1):
      software node: Fix software_node_get_reference_args() with index -1

Aleksandr Khromov (1):
      slip: fix use-after-free in sl_sync()

Aleksandr Nogikh (4):
      usb: gadget: midi2: Fix null-pointer dereference in f_midi2_free_ep_reqs
      udf: Mark LVID buffer as uptodate before marking it dirty
      ALSA: core: Fix use-after-free in snd_card_do_free()
      libceph: validate banner payload length

Alexander A. Klimov (2):
      clk: moxart: remove unused variables, fix refcount leak
      staging: greybus: audio: correct sscanf() return value check

Alexandra Winter (1):
      net/iucv: filter frames in afiucv_hs_rcv() by ingress device

Alexey Charkov (1):
      clk: rockchip: Fix the fractional part denominator on RK3588/RK3576 PLLs

Ali Ahmet Memis (2):
      openrisc: fix arbitrary kernel memory access via or1k_atomic syscall
      Bluetooth: MSFT: validate evt_prefix_len against the response length

Alice Mikityanska (1):
      virtio-net: Ensure that TCP packets don't overflow gso_segs

Alison Schofield (2):
      cxl/pmem: Format the nvdimm serial number as unsigned decimal
      cxl/region: Fix use-after-free in find_pos_and_ways() error path

Alistair Francis (1):
      nvme: Add the DHCHAP maximum HD IDs

Allison Henderson (2):
      RDMA/rxe: Avoid reprocessing the current packet after the QP enters the error state
      net/rds: use wq_has_sleeper() in rds_cong_map_updated()

Andre Przywara (1):
      ARM: dts: allwinner: a10: Fix PMU interrupt

Andreas Kemnade (1):
      drm/omap: dsi: Do not copy isr table

Andreas Schwab (1):
      m68k: nfcon: Do not call console_is_registered() in nfcon_device()

Andrew Halaney (1):
      scsi: ufs: core: Remove unnecessary wmb() after ringing doorbell

Andy Shevchenko (2):
      usb: f_mass_storage: Bump local buffer size in fsg_common_create_luns()
      pinctrl: mediatek: Use C99 initializers in PINCTRL_PIN_GROUP()

Aneesh Kumar K.V (Arm) (2):
      iommu/dma: Check atomic pool allocation result directly
      swiotlb: Preserve allocation virtual address for dynamic pools

Anilkumar Kolli (1):
      wifi: ath11k: add firmware-2.bin support

Anirudh Prasad (1):
      ACPI: pfr_update: fix stack buffer overflow in query_capability()

Anthony Krowiak (8):
      s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
      s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap_mdev_cfg_remove
      s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
      s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL
      s390/vfio-ap: Fix hot-unplug skipped when last AP adapter or domain removed
      s390/vfio-ap: Fix NULL deref in status_show() during queue probe
      s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap
      s390/vfio-ap: Fix required lock not held during update of ap_matrix_mdev object

Anton Bambura (1):
      arm64: dts: qcom: sc8180x-lenovo-flex-5g: move pinctrl to appropriate nodes

Anton Danilov (1):
      ipip: fix skb leak in collect_md mode when metadata_dst allocation fails

Anup Vishwakarma (1):
      mailbox: qcom-ipcc: fix duplicate channel allocation across holes

Arash Golgol (1):
      media: vimc: fix pixel format lookup in enum_framesizes

Ard Biesheuvel (1):
      efivarfs: Rate limit statfs() handler

Armin Wolf (2):
      platform/x86: dell-privacy: Fix race condition
      platform/x86: dell-wmi-base: Fix resource leak on module load failure

Arnaldo Carvalho de Melo (15):
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
      perf dso: Guard close() against invalid fd in dso__decompress_kmodule_path()
      perf dso: Guard against cache underflow on short reads in dso_cache__memcpy()

Arnaud Bonnet (2):
      nfs: replace atomic bitops sequence with clear_and_wake_up_bit helper
      nfs: refactor pNFS functions using clear_and_wake_up_bit

Arthur Gautier (1):
      xhci: fix lost bounce buffers on TDs spanning several ring segments

Asad Kamal (2):
      drm/amdgpu/pm/powerplay: bounds-check voltage index in SMU7 lookup
      drm/amdgpu/pm/powerplay: bounds-check voltage index in Vega10 lookup

Asim Viladi Oglu Manizada (1):
      net: tun: bound receive headroom

Avraham Stern (3):
      wifi: iwlwifi: mei: add support for SAP version 4
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

Baolin Wang (1):
      selftests: mm: support shmem mTHP collapse testing

Bart Van Assche (1):
      scsi: ufs: core: Set task state before io_schedule_timeout()

Bartosz Golaszewski (1):
      powerpc/powermac: fix OF node refcount

Bastien Curutchet (2):
      spi: davinci: Unset POWERDOWN bit when releasing resources
      pps: clients: gpio: Bypass edge's direction check when not needed

Baul Lee (3):
      ALSA: 6fire: bound the MIDI event length from the device
      ALSA: bcd2000: clear the URB pointers on disconnect
      vxlan: mdb: Fix use-after-free in vxlan_mdb_flush()

Besar Wicaksono (1):
      perf cs-etm: Fix incorrect or missing decoder for raw trace

Bijan Tabatabai (1):
      x86/pkeys: Fix pkey_alloc() return value when pkeys are not supported

Biju Das (2):
      usb: renesas_usbhs: Fix power-off ordering on unbind
      irqchip/renesas-rzg2l: Fix loss of interrupt

Biren Pandya (4):
      media: i2c: ov02a10: fix endpoint parsing use-after-free
      media: i2c: ov7740: fix use-after-destroy in remove
      media: v4l2-fwnode: Fix fwnode leak in v4l2_fwnode_parse_link
      media: i2c: rdacm21: Fix missing media_entity_cleanup()

Bjorn Andersson (4):
      arm64: dts: qcom: sc8180x: Enable the power key
      usb: typec: ucsi: unregister debugfs entries on teardown
      remoteproc: Allow shutdown of crashed processors
      remoteproc: Prevent crash handling to race with rproc_del()

Bradley Morgan (5):
      signal: avoid shared siginfo namespace rewrites
      taskstats: fix cpumask parsing cutting off the last character
      ima: Check for ERR_PTR from dentry_path() in validate_hash_algo()
      lib/string: fix memchr_inv() for large ranges
      prctl: fix PR_SET_MM_AUXV losing the forced AT_NULL terminator

Breno Leitao (8):
      mm/migrate: report RCU-tasks quiescent states in migrate_pages_batch()
      mm/vmscan: report RCU-tasks quiescent states in shrink_lruvec()
      net: fix spurious TX timeout after dev_activate()
      efi: fix stale reference to efi_recover_from_page_fault()
      cacheinfo: don't propagate DT/ACPI error when arch supplies info (arm64)
      phonet: pep: do not write beyond optlen in getsockopt
      nfc: llcp: avoid userspace overflow on invalid optlen
      nfc: llcp: read llcp_sock->local under the socket lock in getsockopt

Brian Masney (2):
      clk: nuvoton: ma35d1-pll: convert from round_rate() to determine_rate()
      clk: imx: scu: drop redundant init.ops variable assignment

Brian Witte (1):
      netfilter: nft_counter: serialize reset with spinlock

Bruce Johnston (1):
      md/raid1: don't set array_frozen in raid1_takeover()

Bryam Vargas (12):
      dm array: reject an array block whose value size is not the caller's
      libnvdimm/labels: Prevent integer overflow in __nd_label_validate()
      ocfs2: bound namelen in dlm_migrate_request_handler
      ocfs2: validate lengths in dlm_mig_lockres_handler
      power: supply: cros_usbpd-charger: bound the EC-reported port count
      platform/chrome: sensorhub: Bound the EC-reported sensor number
      net/smc: do not dereference an unset send buffer on the SMC-D teardown path
      net/smc: unregister the connection before draining the rx tasklet
      nvdimm/btt: reject an arena whose nfree is below the lane count
      media: cx231xx: reject geometry changes while the VBI queue is busy
      greybus: audio: bound the topology section sizes against the fetched size
      libnvdimm/labels: Bound the on-media label size before the shift

Caleb Sander Mateos (1):
      ublk: check for ublk_unmap_io() returning 0

Calvin Owens (2):
      pps: don't try to wait for negative timeouts in PPS_FETCH
      pps-gpio: remove dead capture_clear code

Can Peng (10):
      thermal/drivers/imx: Disable clock on runtime resume failure
      thermal/drivers/qoriq: Disable clock on resume failure
      spi: bcm63xx-hsspi: disable clocks on resume failure
      spi: bcm63xx: disable clock on resume failure
      spi: bcmbca-hsspi: disable clocks on resume failure
      iio: pressure: mpl115: Fix runtime PM cleanup
      phy: starfive: Fix runtime PM cleanup in JH7110 DPHY RX probe
      drm/tve200: add OF module alias for autoloading
      crypto: keembay - publish OF module alias for OCS AES/SM4
      ACPI: processor: Unregister cpufreq notifier on init failure

Carlos López (1):
      KVM: x86: hyper-v: Clamp stimer deadline to avoid livelock

Catalin Marinas (2):
      kselftest/arm64: mte: Skip the hugetlb tests if MTE not supported on such mappings
      kselftest/arm64: mte: Use the correct naming for tag check modes in check_hugetlb_options.c

Cen Zhang (2):
      wifi: mac80211_hwsim: avoid NULL skb in stop queue drain
      ocfs2: synchronize heartbeat callbacks with o2net teardown

Cen Zhang (Microsoft) (2):
      xsk: fix NULL pointer dereference in __xsk_rcv()
      gtp: add synchronize_net() in gtp_newlink() error path to prevent use-after-free

Chandrakanth Patil (1):
      scsi: mpt3sas: Avoid freeing unallocated PCIe SGL buffers

Chao Huang (1):
      HID: i2c-hid: goodix: Disable VDD on VDDIO enable failure

Chao Shi (1):
      nvme: reject passthrough of driver-managed Set Features

Chao Yu (2):
      f2fs: fix to off-by-one issue in f2fs_zero_post_eof_page()
      f2fs: fix to zero post-EOF data when extending file size

Chen Cheng (1):
      md/raid5: protect bitmap batch counters aka seq_flush/seq_write consistency

Chen Pei (1):
      ACPI: PCI: Clear driver_data on all paths that free the acpi_pci_root

Chen, Yu C (1):
      sched/fair: Fix overflow in update_tg_cfs_runnable()

Chen-Yu Tsai (2):
      pinctrl: mediatek: eint: Drop base from mtk_eint_chip_write_mask()
      pinctrl: mediatek: common-v1: Fix EINT breakage on older controllers

Cheng Xu (1):
      RDMA/erdma: Hold CQ references when processing EQ events

Cheng-Han Wu (1):
      selftests/zram: fix kernel_gte() for POSIX sh

Chengfeng Ye (2):
      Bluetooth: RFCOMM: serialize security confirmation handling
      vsock/virtio: flush works in dependency order

Chiara Meiohas (1):
      RDMA/core: Add an option to display driver-specific QPs in the rdmatool

Chris Lu (2):
      Bluetooth: btmtksdio: Take exclusive ownership of the SKB before TX
      Bluetooth: btmtksdio: Fix out-of-bounds DMA read in the TX path

Chris Mason (12):
      nfsd: release path refs on follow_down() error
      nfsd: fix cpntf publish race in nfs4_init_cp_state
      nfsd: gate nfs3 setacl by argp->mask
      SUNRPC: xdr_buf_trim: clamp buf->len to avoid underflow
      SUNRPC: Zero rpc_gss_wire_cred at svcauth_gss_decode_credbody() entry
      SUNRPC: svcauth_gss: enforce krb5 token minimum length
      SUNRPC: Guard svcauth_gss_release() dispatch on rq_auth_stat
      SUNRPC: harden gss_krb5_unwrap_v2 against short tokens
      SUNRPC: harden gss_unwrap_resp_priv length checks
      sunrpc: init gssp_lock before publishing proc entry
      svcrdma: Fix offset arithmetic in read_chunk_range
      svcrdma: Fix pcl_for_each_segment for empty chunks

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

Christoph Zwerschke (2):
      Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU
      Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU

Christophe JAILLET (3):
      regulator: tps6594-regulator: Constify struct tps6594_regulator_irq_type
      accessibility: speakup: Fix incorrect string length computation in report_char_chartab_status()
      wifi: ath11k: Fix error handling in ath11k_wmi_p2p_noa_event()

Christopher Lusk (1):
      smb: client: fix request buffer leak in smb2_new_read_req()

Christopher Tolang (1):
      ASoC: amd: yc: Add DMI entry for MSI Thin A15 B7UC

Christos Maragkos (1):
      HID: nintendo: Fix imu_timestamp_us double increment per report

Chuck Lever (8):
      NFSD: Encode only the status in NFS-ACL v2 GETACL error replies
      NFSD: Fix off-by-one in DRC bucket pruning limit
      nfsd: Reset write verifier when async COPY writeback fails
      nfsd: sample writeback error cursor before async COPY loop
      nfsd: gate nfs2 setacl by argp->mask
      NFSD: Prevent lock owner use-after-free during client teardown
      SUNRPC: Check svc pool percpu counter allocation
      SUNRPC: Reject krb5 v2 wrap tokens with oversized ec field

Chunkai Deng (1):
      rpmsg: glink: smem: order FIFO read after availability check

Coly Li (1):
      md: do overflow check for sb->bblog_shift in super_1_load()

Cong Nguyen (4):
      hwmon: (max6621) fix negative temperature offset and crit readings
      hwmon: (max6621) fix temperature clamp range
      iio: gyro: mpu3050: fix sign of raw angular velocity readings
      iio: srf04: fix pm_runtime handling on probe error path

Cosmo Chou (3):
      leds: pca9532: Fix inverted GPIO output polarity
      leds: pca9532: Fix phantom device registration on missing hardware
      rtc: pcf85363: Add error checking to regmap calls in probe()

Cristian Marussi (1):
      firmware: arm_scmi: Add multiple protocols registration support

Cássio Gabriel (2):
      ALSA: aloop: Fix peer runtime UAF during format-change stop
      ALSA: core: Add scoped cleanup helper for card references

Daisuke Matsuda (1):
      fpga: altera-cvp: Avoid out-of-bounds read in trailing byte write

Damien Le Moal (1):
      block: flag zoned disks with GENHD_FL_NO_PART

Dan Carpenter (5):
      staging: fbtft: Use sysfs_emit_at() to print to sysfs file
      thermal/drivers/rcar: Fix error checking in probe()
      cpufreq: spear: Fix an IS_ERR() vs NULL bug in spear1340_set_cpu_rate()
      scsi: qla2xxx: Fix an loop timeout test
      pinctrl: mediatek: common-v1: Fix error checking in mtk_eint_init()

Daniel Borkmann (1):
      bpf: Fix vmlinux BTF prep race in bpf_get_btf_vmlinux

Daniel McCarthy (1):
      pinctrl: bcm2835: Don't remove an unregistered GPIO chip

Daniel Vogelbacher (1):
      ceph: fix oops due to invalid pointer for kfree() in parse_longname()

Danila Chernetsov (2):
      RDMA/hfi1: Propagate sdma_txinit_ahg() errors
      fbdev: kyro: Validate overlay viewport coordinates

Danilo Krummrich (1):
      drm: fix race between partial drm_dev_register() failure and ioctl

Dapeng Mi (1):
      perf/x86/intel: Fix kernel address leakages in LBR stack

Dave Airlie (1):
      nouveau/gem: reserve the bo in the info ioctl around the vma lookup

Dave Jiang (2):
      cxl/mbox: Break poison list loop on an empty payload
      cxl/pci: Honor -EPROBE_DEFER from component register setup

David (Ming Qiang) Wu (1):
      drm/amdgpu/vcn: fix integer overflow in dec_msg buffer count check

David Hildenbrand (1):
      selftests: mm: cow: flag vmsplice() hugetlb tests as XFAIL

David Lee (3):
      udf: reject VAT indexes equal to the entry count
      UDF symlink pathComponent header OOB read
      nilfs2: prevent out-of-bounds read in super root block parsing

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

Deepanshu Kartikey (4):
      eventfs: Initialize ei->children and ei->list in init_ei()
      drm/i915: Guard against NULL driver_data in i915_pci_probe()
      drm/gud: NUL-terminate TV mode names read from the device
      usb: atm: usbatm: fix invalid ci_range initialization

Delphine CC Chiu (1):
      hwmon: (emc1403) Add support for EMC1442

Desnes Nunes (1):
      iommu/vt-d: Fix UCTP context table slot when copying root entries

Devin Wittmayer (1):
      wifi: mt76: mt76x02: do not WARN on invalid rx descriptor length

Diego Fernando Mancera Gomez (1):
      media: em28xx: defer audio-only extension registration

Dmitry Antipov (3):
      ocfs2: always run deallocs on copy-on-write completion
      smack: simplify write handlers of sysfs entries
      wifi: ath11k: refactor ath11k_wmi_tlv_parse_alloc()

Dmitry Baryshkov (3):
      arm64: dts: qcom: sm8250: sort out Iris power domains
      arm64: dts: qcom: sm8250: correct frequencies in the Iris OPP table
      clk: qcom: gcc-qcm2290: don't park QUP RCGs upon registration

Donet Tom (1):
      selftests/mm: add new test cases to the migration test

Doruk Tan Ozturk (2):
      wifi: ath6kl: clamp assoc request/response lengths before subtracting IE offsets
      nfc: llcp: bound SNL TLV parsing to the skb and add length checks

Dragos Tatulea (1):
      net/mlx5e: xsk: Fix unlocked writing to ICOSQ

Eason Lai (1):
      wifi: mt76: mt792x: Fix memory leak in SDIO TX path

Eduard Zingerman (1):
      selftests/bpf: Fix for veristat file/prog filters processing

Emmanuel Grumbach (3):
      wifi: iwlwifi: fix counter type in iwl_fwrt_dump_error_logs
      wifi: iwlwifi: mvm: fix off-by-one in TXF key sanitiser
      wifi: iwlwifi: guard against division by zero in iwl_dbg_tlv_alloc_fragments

Enzo Matsumiya (1):
      smb: server: fix leak of ksmbd_ipc_login_request_ext() returned buffer

Eric Dumazet (10):
      net: dst: add four helpers to annotate data-races around dst->dev
      ipv4: adopt dst_dev, skb_dst_dev and skb_dst_dev_net[_rcu]
      net: dst: introduce dst->dev_rcu
      ipv4: start using dst_dev_rcu()
      tcp: fix potential race in tcp_v6_syn_recv_sock()
      inetpeer: randomize RB-tree node comparison using SipHash
      net/sched: act_skbmod: fix length calculations and avoid invalid header warnings
      slip: remove slip_hangup() to fix use-after-free in slip_receive_buf()
      net: hsr: init prune_proxy_timer sooner
      net: hsr: must allocate more bytes for RedBox support

Erick Henrique (1):
      iio: dac: m62332: Fix regulator reference count imbalance

Esteban Urrutia (1):
      phy: qcom: qmp-combo: Correct pre-emphasis table for QMP v4 DP PHYs

Ethan Carter Edwards (1):
      clk: ti: use kcalloc() instead of kzalloc()

Ethan Nelson-Moore (1):
      ARM: 9477/1: Disable broken eBPF JIT on the Risc PC

Evgenii Burenchev (2):
      ALSA: via82xx: Remove unreachable branch in snd_via686_pcm_pointer()
      ALSA: hpi: Check transport errors during HPI6000 adapter initialization

Ewan D. Milne (1):
      nvme: nvme-fc: Fix nvme_fc_create_hw_io_queues() queue deletion in error path

Fabio Estevam (3):
      arm64: dts: rockchip: Fix rk3399-roc-pc-plus analog audio
      wifi: mwifiex: Detach sync cmd buffer on interrupted wait
      arm64: dts: rockchip: Fix Gru WLAN sideband interrupt

Fabio Porcedda (1):
      net: usb: qmi_wwan: add Telit Cinterion FE990D50 composition

Faith Ekstrand (1):
      drm/nouveau: Use write-combined maps for coherent

Fan Wu (12):
      RDMA/cxgb4: Cancel reg_work before freeing device on remove
      power: supply: bq24257: fix use-after-free on remove
      power: supply: bq256xx: drain usb_work before freeing the charger
      power: supply: lp8727: fix use-after-free in lp8727_release_irq()
      power: supply: rt9455: quiesce delayed work before teardown
      power: supply: ucs1002: fix use-after-free on remove
      mmc: via-sdmmc: stop card-detect handling on probe failure
      usb: typec: qcom-pmic: cancel reset_work on stop
      iio: chemical: atlas-sensor: use iio_trigger_poll_nested() to fix remove UAF
      media: cx23885: cancel NetUP CI work before teardown
      spi: davinci: switch to managed controller allocation
      RDMA/cxgb4: Free debugfs on registration failure

Fan Ye (3):
      net: thunderbolt: Release the Rx HopID that was handed out on mismatch
      net: thunderbolt: Mark the connection down when bringing it up fails
      net: thunderbolt: Count delivered packets in rx_packets and rx_bytes

Farhan Ali (1):
      PCI/MSI: Enable memory decoding before restoring MSI-X messages

Fei Shao (1):
      usb: mtu3: allow system suspend during active gadget connection

Felix Fietkau (14):
      wifi: mt76: mt7996: set MT76_MCU_RESET before waking MCU waiters on full reset
      wifi: mt76: mt7915: avoid nss underflow in mt7915_mcu_get_sta_nss
      wifi: mt76: mt7996: don't report a zero TX bitrate
      wifi: mt76: mt7915: poll the correct SLP CTRL register for the second adie
      wifi: mt76: mt7996: bound TLV walk in mt7996_mcu_get_chip_config
      wifi: mt76: mt7996: reserve space for the CSA-abort countdown TLV
      wifi: mt76: mt7915: use little-endian for bss_info_ra wire fields
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

Felix Yan (1):
      clocksource/drivers/timer-sun4i: Advertise a real minimum delta

Feng Yang (3):
      selftests/bpf: Fix memory leak in msg_alloc_iov
      selftests/bpf: Fix incorrect error checking for pthread_create
      selftests/bpf: Fix memory leak on subtest_states reallocation

Florian Fuchs (1):
      fbdev: pvr2fb: correct user pointer annotation and sentinel initializer

Florian Westphal (1):
      netfilter: nf_nat_sip: rewind offset when NAT shrinks the packet

Francesco Lavra (1):
      usb: dwc2: gadget: Exit partial power down state when changing USB pull-up

Frank Sorenson (4):
      cifs: fix loff_t underflow in cifs_remap_file_range() when len == 0
      smb: client: fix ALIGN() overflow in symlink_data() error context loop
      smb: client: fix copy-paste error in WSL EA length accounting for $LXDEV
      cifs: fix clearing stats for fastest execution of each smb2 command

Fredric Cover (2):
      smb: client: clear ce->tgthint in free_tgts()
      smb: client: harden DFS cache against invalid target hints

Fu Hao (1):
      iommu/amd: Add support for Hygon family 18h model 4h IOAPIC

Gary Guo (1):
      usb: fix UAF when probe runs concurrent to dyn ID removal

Gaurav Batra (1):
      powerpc/pseries/iommu: switch to Default DMA window during kdump

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

Giovanni Cabiddu (1):
      crypto: qat - clear AES key schedule from stack

Gleb Markov (1):
      misc: rtsx: add missing write register handling

Gongwei Li (1):
      Bluetooth: hci_uart: Fix false success return in hci_uart_setup()

Gou Hao (1):
      powerpc/smp: add NULL guard for cause_ipi in smp_muxed_ipi_message_pass

Greg Kroah-Hartman (3):
      USB: make single lock for all usb dynamic id lists
      USB: make to_usb_driver() use container_of_const()
      Linux 6.6.157

Griffin Kroah-Hartman (1):
      usb: image: mdc800: change kmalloc() to kzalloc()

Guanghui Yang (1):
      ext4: fix buffer_head leak in ext4_init_orphan_info

Guangshuo Li (11):
      Bluetooth: hci_bcm: fix usage_count leak when autosuspend_delay is negative
      Bluetooth: hci_h5: fix usage_count leak when autosuspend_delay is negative
      Bluetooth: hci_intel: fix usage_count leak when autosuspend_delay is negative
      media: saa7164: fix cleanup on resource allocation failure
      drm/amdgpu: fix autosuspend cleanup during removal
      clk: tegra: tegra124-emc: put EMC node on register failure
      rapidio: clear mport->net when rio_add_net() fails
      dmaengine: qcom-bam-dma: fix autosuspend cleanup during removal
      clocksource/drivers/clps711x: Do not unmap clocksource MMIO
      ksmbd: Do not skip lock checks for single-byte ranges
      platform/x86: hp-bioscfg: fix password encoding bounds check

Guenter Roeck (3):
      hwmon: (emc1403) Convert to with_info API
      hwmon: (emc1403) Support 11 bit accuracy
      hwmon: (emc1403) Rely on subsystem locking

Gui-Dong Han (3):
      media: cec-pin: Fix event FIFO ordering
      nvme-apple: Use acquire/release for queue enabled state
      misc: bcm-vk: Use acquire/release for msgq_inited

Guixin Liu (6):
      nvmet-rdma: use sbitmap to replace rsp free list
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

Guopeng Zhang (1):
      mm: memcg: stop reclaim when a limit update is superseded

Guoqing Jiang (1):
      RDMA/siw: Introduce siw_free_cm_id

Günther Noack (1):
      landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout creation

HE WEI（ギカク） (1):
      fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()

Hajo Noerenberg (1):
      ata: ahci: work around lost interrupts on Marvell 88SE61xx

HanQuan (1):
      ecryptfs: reject oversized encrypted_key_size in parse_tag_3_packet

Hang Nan (2):
      Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready
      ksmbd: bound smb_check_perm_dacl() ACE walks by DACL size

Hanlin Song (1):
      csky: Fix a4/a5 restoration in syscall trace path

Hannes Reinecke (1):
      nvmet-rdma: avoid circular locking dependency on install_queue()

Hans Verkuil (2):
      Revert "media: v4l2-dev: fix error handling in __video_register_device()"
      media: v4l2-async: Unregister sub-device if asc_list is empty

Hans de Goede (4):
      HID: i2c-hid: Fold i2c_hid_execute_reset() into i2c_hid_hwreset()
      HID: i2c-hid: Split i2c_hid_hwreset() in start() and finish() functions
      HID: i2c-hid: Switch i2c_hid_parse() to goto style error handling
      HID: i2c-hid: Move i2c_hid_finish_hwreset() to after reading the report-descriptor

Hao Chang (3):
      pinctrl: mediatek: Add EINT support for multiple addresses
      pinctrl: mediatek: Fix the invalid conditions
      pinctrl: mediatek: Fix new design debounce issue

Hao Ge (1):
      selftests/mm/cow: modify the incorrect checking parameters

Hao-Qun Huang (4):
      staging: greybus: hid: fix SET_REPORT return value
      staging: media: tegra-video: fix of_node_put() on VIP parse errors
      staging: media: tegra-video: vi: fix probe failure on skipped last port
      f2fs: reject overlapping move range after len expansion

Haotian Zhang (4):
      dm-switch: use WRITE_ONCE() in switch_region_table_write()
      ALSA: ice1712: Fix the card leak at probe error with the auto-cleanup
      samples/ftrace: Fix kthread_stop() on ERR_PTR in ftrace-direct-modify
      samples/ftrace: Fix kthread_stop() on ERR_PTR in ftrace-direct-multi-modify

Haowen Tu (1):
      PM: sleep: Fix off-by-one in wakelocks number limit check

Haoxiang Li (4):
      HID: sensor: custom: Fix field sysfs group cleanup on failure
      ASoC: fsl: mpc5200-i2s: Free DMA resources on probe failure
      AsoC: intel: sst: fix PCI device reference leak on probe failure
      iommu/qcom: Remove sysfs device on probe failure path

Hari Mishal (1):
      drm/amd/display: fix division by zero in get_estimated_bw()

Harry Wentland (1):
      drm/amd/display: avoid divide-by-zero in __is_lut_linear()

Harshit Varu (1):
      mptcp: fix uninitialized local_id in syncookie MP_JOIN reconstruction

Heiko Stuebner (1):
      clk: rockchip: rk3588: Don't change PLL rates when setting dclk_vop2_src

Helge Deller (2):
      sticon/parisc: Detect default STI graphics card for console output
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

Herve Codina (7):
      irqdomain: Introduce irq_domain_free()
      irqdomain: Introduce irq_domain_instantiate()
      irqdomain: Handle additional domain flags in irq_domain_instantiate()
      irqdomain: Handle domain hierarchy parent in irq_domain_instantiate()
      irqdomain: Introduce init() and exit() hooks
      genirq/generic_chip: Introduce irq_domain_{alloc,remove}_generic_chips()
      irqdomain: Add support for generic irq chips creation before publishing a domain

Hidayath Khan (2):
      net/smc: fix socket refcount leak in smc_switch_conns()
      net/smc: fix use-after-free in smc_rx_pipe_buf_release()

Hisam Mehboob (1):
      selftests/rseq: Replace glibc-specific __GNUC_PREREQ with portable check

Hongyan Xu (8):
      auxdisplay: charlcd: cancel backlight work on registration failure
      usb: gadget: r8a66597: avoid double free of ep0_req in probe error path
      platform/chrome: cros_ec_debugfs: Clean up console log on probe failure
      platform/chrome: cros_ec_debugfs: Unregister panic notifier
      power: supply: isp1704_charger: cancel work on remove
      power: supply: sc2731_charger: cancel work on remove
      ACPI: scan: fix bus ID cleanup on device_add() failures
      block: mtip32xx: synchronize ioctls with device removal

Huang Wei (1):
      usb: typec: ucsi: use UCSI_TIMEOUT_MS for sync command completion

Hui Su (5):
      tracing: Fix crash passing ERR_PTR to kthread_stop()
      tracing: Fix use-after-free with same-name named triggers
      fbdev: ssd1307fb: defer I2C transfers from damage callbacks
      cpufreq: schedutil: Fix rate limit overflow
      kasan: fix cache shrink race with CPU hotplug

Huisong Li (5):
      ACPI: processor: idle: Optimize ACPI idle driver registration
      mailbox: pcc: Fix command timeout due to missed interrupt
      ACPI: processor: idle: Remove redundant cstate check in acpi_processor_power_init
      ACPI: processor: idle: Move max_cstate update out of the loop
      ACPI: processor: idle: Remove redundant static variable and rename cstate check function

HyeongJun An (11):
      Bluetooth: eir: Fix OOB read in eir_get_service_data()
      ALSA: ump: Fix corrupted data bytes at MIDI 1.0 SysEx to UMP conversion
      power: supply: qcom_battmgr: terminate the strings from firmware
      platform/x86: dell-wmi-sysman: Don't hex dump attribute security buffer
      platform/x86: ISST: Validate level in perf mask ioctls
      platform/x86: ISST: Validate socket ID in clos_assoc ioctl
      ALSA: usb-audio: fix OOB write in snd_usbmidi_us122l_output()
      media: s2255: bound JPEG frame size before copying into the buffer
      Bluetooth: virtio_bt: avoid OOB read of build info string
      platform/x86: dell-wmi-sysman: Fix instance ID bounds
      ASoC: dapm: Fix off-by-one check on the second enum channel

Hyunwoo Kim (3):
      sctp: stop processing a packet once its association is deleted
      sctp: drop a chunk if its transport was removed
      Bluetooth: RFCOMM: Validate MTU in rfcomm_apply_pn() to prevent infinite loop

Ian Rogers (12):
      perf test stat_all_metrics: Ensure missing events fail test
      perf tests metrics: Permission related fixes
      perf test metrics: Update all metrics for possibly failing default metrics
      perf test all metrics: Fully ignore Default metric failures
      perf tests: Skip metrics validation if system-wide recording lacks permission
      perf test bpf-counters: Add test for BPF event modifier
      perf tests: Fix flakiness in BPF counters test on hybrid systems
      perf jevents: Add more components to the metric sorting order
      perf ui hists: Fix uninitialized stack memory free on pstack allocation failure
      perf stat: Fix evsel_list leak in cmd_stat
      perf synthetic-events: Fix uninitialized pthread_join
      perf synthetic-events: Fix divide by zero in perf_event__synthesize_threads

Ibrahim Abdelkader (1):
      Bluetooth: hci_sync: Clear HCI_CMD_PENDING when dropping the last request

Ibrahim Hashimov (5):
      ubifs: fix out-of-bounds read in signature length check
      HID: picolcd: clamp eeprom debugfs read to bytes actually received
      ocfs2: validate rl_used against rl_count in refcount block validator
      HID: wacom: validate report length in wacom_intuos_pro2_bt_irq
      RDMA/rxe: Validate num_sge/cur_sge before indexing wqe->dma.sge[]

Ido Schimmel (8):
      vxlan: mdb: Adjust function arguments
      vxlan: mdb: Factor out a helper for remote entry size calculation
      bridge: add MDB get uAPI attributes
      net: Add MDB get device operation
      vxlan: mdb: Add MDB get support
      bridge: add MDB state mask uAPI attribute
      net: Add MDB bulk deletion device operation
      vxlan: mdb: Add MDB bulk deletion support

Ilya Krutskih (2):
      dm raid1: reserve space for NUL-terminator in build_constructor_string()
      media: tda18250: fix possible integer overflow

Ilya Maximets (2):
      net: openvswitch: fix flow mask use-after-free on flow deletion
      net: openvswitch: fix kernel-doc warnings in internal headers

Ismail Tarim (1):
      Bluetooth: btmtk: Do not discard the subsystem reset timeout

Israel Téllez García (1):
      bpf: Fix pending_pos walk on 32-bit ring position wrap

Itai Handler (1):
      rcu: Mark accesses to ->rcu_urgent_qs and ->rcu_need_heavy_qs

Ivaylo Dimitrov (1):
      hsi: omap_ssi_core: fix missing DMA mask setup for SSI controller device

Ivy Lopez (2):
      usb: gadget: f_midi2: fix use-after-free in string attribute show path
      staging: rtl8723bs: use kfree_sensitive() for key material

Jakub Kicinski (1):
      i3c: dw: avoid shift-out-of-bounds when DAA assigns no devices

Jamal Hadi Salim (7):
      net/sched: fq_codel: clamp default quantum and mtu
      net/sched: sch_codel: clamp default mtu to avoid disabling CoDel
      net/sched: fq_pie: clamp default quantum to avoid signed overflow
      net/sched: hhf: clamp quantum before hhf_change() to avoid overflow
      net/sched: sfq: clamp quantum to avoid signed overflow soft lockup
      net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup
      net/sched: sch_htb: limit htb_classify inner-class filter hops

James Calligeros (1):
      ASoC: apple: mca: increase SERDES reset delay

James Clark (4):
      perf cs-etm: Create decoders after both AUX and HW_ID search passes
      perf cs-etm: Queue context packets for frontend
      tools/build: Allow versioning of all LLVM tools defined in Makefile.include
      coresight: Change syncfreq to be a u8

James Kim (1):
      rapidio: mport_cdev: fix use-after-free in dma_req_free()

Jameson Thies (2):
      power: supply: cros_usbpd: Limit port counts to EC_USB_PD_MAX_PORTS
      usb: typec: ucsi: displayport: Fix OOB altmode array index

Jan Kara (1):
      ext4: fix spurious message about orphan cleanup on RO fs

Jann Horn (1):
      smack: fix cred UAF in smack_file_send_sigiotask()

Jarkko Nikula (2):
      i3c: mipi-i3c-hci: Fix DAT/DCT entry sizes
      i3c: mipi-i3c-hci: Fix number of DAT/DCT entries for HCI versions < 1.1

Jason Gunthorpe (1):
      RDMA/nldev: Fix locking when accessing mr->pd

Jeff Johnson (7):
      wifi: ath6kl: avoid buffer overreads in WMI event handlers
      wifi: ath12k: Correctly copy the hint BSSID in WMI scan request
      wifi: ath11k: Correctly copy the hint BSSID in WMI scan request
      wifi: ath12k: Avoid buffer overread in ath12k_wmi_op_rx()
      wifi: ath11k: Avoid buffer overread in ath11k_wmi_tlv_op_rx()
      wifi: ath11k: fix overreads in ath11k_wmi_process_csa_switch_count_event()
      wifi: ath11k: fix leak in ath11k_service_ready_ext_event()

Jeff Layton (16):
      nfsd: return NFS4ERR_NOTSUPP for unsupported netloc4 types
      nfsd: validate symlink target length in NFSv4 CREATE
      nfsd: add fh_want_write() for early-verified SETATTR in nfsd_proc_setattr()
      nfsd: add filehandle match check to nfsd4_delegreturn()
      nfsd: block non-SAVEFH ops after FOREIGN PUTFH to prevent NULL deref
      nfsd: check client ownership when cancelling a copy-notify stateid
      nfsd: fix version mismatch loops in nfsd_acl_init_request()
      nfsd: fix XDR length calculation in nfsd4_ff_encode_layoutget
      nfsd: fix XDR padding calculation in ff_encode_getdeviceinfo
      nfsd: initialize copy-notify stateid before publishing it
      nfsd: reject reclaim LOCK after RECLAIM_COMPLETE
      nfsd: revoke copy-notify stateids before dropping their reference
      sunrpc: route to a populated pool in svc_pool_for_cpu()
      SUNRPC: always drain cache_cleaner before destroying a cache_detail
      fuse: convert to new timestamp accessors
      nfs: move the nfs4_data_server_cache into struct nfs_net

Jeffin Philip (2):
      usb: gadget: uvc: fix dangling pointers in uvc_function_bind() and uvc_function_unbind()
      usb: gadget: fix null pointer dereference in usb_put_function_instance()

Jens Remus (1):
      x86/cfi: Use symmetric SYM_START and SYM_END in __CFI_TYPE()

Jernej Skrabec (7):
      drm/sun4i: vi scaler: Fix coefficient selection
      drm/sun4i: tcon: Set output mux for DSI and LVDS
      drm/sun4i: tcon: Drop TCON TOP device reference
      drm/sun4i: crtc: Propagate layer initialization error
      drm/sun4i: tcon: Drop remote endpoint reference
      drm/sun4i: dw-hdmi: Drop TCON TOP port reference
      drm/sun4i: hdmi-phy: Fix H6 8-bit MPLL config at 594 MHz

Jian Shen (1):
      net: hns3: don't auto enable misc vector

Jian-Ming Liao (1):
      i3c: mipi-i3c-hci: Fix missing STAT_IBI_STATUS_THLD in PIO mode

Jiancheng Huang (1):
      HID: lg4ff: validate report length before fixed offsets

Jiangong.Han (1):
      media: em28xx: fix use-after-free of dev_next->devlist on disconnect

Jiangshan Yi (4):
      HID: mcp2221: stop device IO before hid_hw_stop
      HID: mcp2221: validate report size in mcp2221_raw_event()
      bnx2x: fix double free in bnx2x_init_firmware() error path
      selftests: timers: leap-a-day: Fix -w option and update usage comment

Jianing Li (2):
      power: supply: max17040: drop incorrect I2C functionality check
      power: supply: max17040: synchronize work cancellation on suspend

Jiawen Wu (1):
      net: libwx: fix Tx L4 checksum

Jiayuan Chen (2):
      bpf: Fix same-register dst/src OOB read and pointer leak in sock_ops
      tcp: fix corruption of urgent data on multi-segment retransmit

Jie Wang (1):
      net: hns3: fix kernel crash when 1588 is sent on HIP08 devices

Jingyi Wang (1):
      remoteproc: core: Attach rproc asynchronously in rproc_add() path via schedule_work()

Jinjie Ruan (1):
      entry: Fix seccomp bypass after ptrace with TSYNC

Jiri Slaby (SUSE) (1):
      tty: ipoctal: convert to u8 and size_t

Joanne Koong (2):
      fuse: support folios in struct fuse_args_pages and fuse_copy_pages()
      fuse: convert readdir to use folios

Joas Antonio dos Santos (1):
      ipvs: fix integer overflow in ftp helper port/address parsing

Joey Lu (3):
      clk: nuvoton: ma35d1: fix ignored div_u64 return values in PLL freq calculation
      clk: nuvoton: ma35d1: fix PLL_CTL1_FRAC bit field width and fractional calc
      clk: nuvoton: ma35d1: fix ma35d1_clk_pll_determine_rate logic

Johan Hovold (5):
      USB: phy: fsl-usb: fix missing static keywords
      remoteproc: scp: Fix device reference leak on failed lookup
      drm/bridge: dw-hdmi: fix i2c adapter leak on probe failure
      drm/panel-edp: fix i2c adapter leak on probe failure
      Bluetooth: btusb: refactor endpoint lookup

John Groves (1):
      dax: read holder_ops once in dax_holder_notify_failure()

John Johansen (1):
      apparmor: policy_int make sure list heads are initialized before fail path

John Keeping (1):
      ALSA: seq: midi: Serialize input teardown with event_input

Jonas Karlman (1):
      media: cec: core: Fix kmemleak due to missed rc_free_device() call

Jonathan Currier (1):
      net/niu: Niu requires MSIX ENTRY_DATA fields touch before entry reads

Jordan R Abrahams-Whitehead (1):
      include/linux/list.h: mark list_add and __list_add as __always_inline

Jorijn van der Graaf (1):
      ASoC: qcom: q6apm: keep the graph start count in sync with the DSP

Joseph Qi (3):
      ocfs2: cluster: don't sleep while holding o2hb_live_lock in o2hb_region_pin()
      ocfs2: cluster: avoid lock order inversion in o2hb_region_pin() from drop_item
      ocfs2: cluster: fix o2hb_dependent_users leak on pin failure

Joshua Crofts (2):
      usb: gadget: midi2: remove default configfs groups on teardown
      nilfs2: fix infinite loop in nilfs_clean_segments()

Joy H.J. Lee (1):
      tools/compiler: match glibc 2.42 definition of __attribute_const__

Joy Zou (1):
      regulator: core: use system_freezable_wq for init complete work

Jun Yan (1):
      arm64: dts: amlogic: meson-axg-s400: enable mipi_pcie_analog_dphy for PCIe

Jun Yang (2):
      sctp: distinguish sequence zero from wildcard in reconf lookup
      sctp: fix stream->outcnt underflow on duplicate RECONF responses

Junrui Luo (4):
      media: vicodec: fix out-of-bounds write in FWHT encoder
      NFSv4.1: fix layout segment leak on the pnfs_layout_process() forget path
      NFSv4.2: fix LAYOUTSTATS send buffer exhaustion
      NFSv4/pnfs: key the data server cache on the NFS version

Junseo Lim (3):
      lwt_bpf: Restore reserved headroom after xmit program
      bpf: Reject negative optlen in cgroup getsockopt hook
      net: kcm: Hold RCU read lock while running BPF parser

Junyi Liu (1):
      ksmbd: fix durable reconnect error path file lifetime

Justin Yeh (1):
      pinctrl: mediatek: free EINT resources on unbind

Jérémy Jean (8):
      timers/itimer: Zero-init old itimerval before copy to userspace
      tracing/user_events: Clear copied tracing state before fork duplication
      libceph: reject buckets with mismatched CRUSH ids
      ceph: reject export_targets ranks >= CEPH_MAX_MDS in mdsmap decode
      audit: avoid dropping live tree ref on fsnotify rule autoremove
      bpf: Harden bloom filter sizing and indexing on 32-bit kernels
      SUNRPC: wait for in-flight client TLS handshake callback
      LoongArch: Avoid preempt count underflow without probe

Kalesh AP (1):
      RDMA/restrack: Fix typos in the comments

Kalle Valo (1):
      wifi: ath11k: qmi: refactor ath11k_qmi_m3_load()

Kamal Wadhwa (1):
      regulator: qcom-rpmh: Fix PMIC5 BOB bypass mode handling

Kang Yang (1):
      wifi: ath11k: implement handling of P2P NoA event

Kanishka De Silva (1):
      ublk: clear VM_MAYWRITE on read-only ublk char device mmap

Karl Mehltretter (13):
      Revert "arm64: mm: Don't remap pgtables for allocate vs populate"
      arm64: compat: Fix decrementing LDM/STM alignment emulation
      cgroup/cpuset: Fix misplaced DL migration reset
      arm64: mm: Fix the lockless page-table walk in show_pte()
      tty: hvc: restrict HVC_DCC to ARMv6+ and ARM64
      ARM: lpc32xx: only run SoC init on LPC32xx hardware
      serial: amba-pl011: unprepare console clock on unregister
      tty: clear cdev pointer after cdev_add() failure
      cpufreq: imx6q: fix devres accumulation across driver rebind
      cpufreq: imx6q: fix out-of-bounds write when probed more than once
      m68k: Fix backtraces for non-running tasks
      octeontx2-af: initialize lmac_bmap in rvu_mcs_set_lmac_bmap()
      8139cp: fix Rx and Tx not being disabled in cp_suspend

Kathiravan Thirumoorthy (1):
      regulator: qcom-refgen: correct the regulator type to CURRENT

Kavan Smith (1):
      drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value

Kazuki Hanai (1):
      nvmet-auth: Synchronize timeout work during SQ teardown

Kemeng Shi (3):
      irqchip/gic-v3-its: Fix memleak in its_probe_one()
      irqchip/gic-v3-its: Fix its node leak in gic_acpi_parse_madt_its()
      irqchip/gic-v3-its: Prevent leak in its_vpe_irq_domain_alloc()

Kenny Levinsen (1):
      HID: i2c-hid: Revert to await reset ACK before reading report descriptor

Kevin Tian (2):
      iommu/vt-d: Fix no_iommu to disable platform opt-in
      iommu/vt-d: Force requesting ACS when tboot is enabled

Kiryl Shutsemau (Meta) (3):
      x86/tdx: Fix off-by-one in port I/O handling
      x86/insn-eval: Move assign_register() out of KVM as insn_assign_reg()
      x86/tdx: Fix zero-extension for 32-bit port I/O

Koichiro Den (13):
      NTB: ntb_transport: Recycle TX entries before client callbacks
      NTB: ntb_transport: Fail TX enqueue when the QP link is down
      NTB: ntb_transport: Reject oversized TX buffers
      net: ntb_netdev: Avoid double-accounting netif_rx() drops
      net: ntb_netdev: Count packets dropped on RX refill failure
      net: ntb_netdev: Fix TX busy and drop handling
      dmaengine: dw-edma: Fix HDMA channel status register access
      dmaengine: dw-edma: Complete descriptors before pausing
      dmaengine: dw-edma: Initialize IRQ data before requesting IRQs
      dmaengine: dw-edma: Terminate all descriptors without callbacks
      dmaengine: dw-edma: Serialize abort state updates
      dmaengine: dw-edma: Serialize channel state checks
      dmaengine: dw-edma: Clear stale requests on termination

Konrad Dybcio (8):
      arm64: dts: qcom: sc8180x-primus: Rename regulator nodes
      arm64: dts: qcom: sc8180x-lenovo-flex-5g: Rename regulator nodes
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

Konstantin Komarov (4):
      fs/ntfs3: bound page_lcns[] index by the log record
      fs/ntfs3: Add more checks in mi_enum_attr (part 2)
      fs/ntfs3: Mark inode as bad as soon as error detected in mi_enum_attr()
      fs/ntfs3: fix out-of-bounds read in read_log_rec_buf()

Krystian Kaniewski (1):
      ocfs2: fix circular locking dependency in ocfs2_init_acl()

Krzysztof Kozlowski (2):
      bus: qcom-ebi2: Simplify with scoped for each OF child loop
      arm64: dts: qcom: sc8180x: drop duplicated PCI iommus property

Krzysztof Wilczyński (5):
      alpha/PCI: Fix I/O port accessor argument order in pci_legacy_write()
      PCI/sysfs: Avoid spurious runtime PM wakeup on config space accesses
      PCI/proc: Avoid spurious runtime PM wakeup on config space accesses
      PCI/proc: Use file_ns_capable() when checking config space read access
      PCI/proc: Warn on writes to kernel-exclusive config space regions

Kuan-Wei Chiu (1):
      interconnect: Fix use after free in icc_get() and of_icc_get_by_index()

Kuninori Morimoto (4):
      of: property: add missing kerneldoc for of_graph_get_endpoint_count()
      of: property: use unsigned int return on of_graph_get_endpoint_count()
      of: property: add of_graph_get_next_port()
      of: property: add of_graph_get_next_port_endpoint()

Kyle Zeng (1):
      hfsplus: validate thread record before delete key rebuild

Lad Prabhakar (2):
      rtc: rzn1: Fix weekday underflow when alarm crosses month boundary
      rtc: rzn1: Disable alarm interrupt before reprogramming alarm registers

Lars Petter Mostad (1):
      hwmon: (emc1403) Add support for EMC1428 and EMC1438.

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

Leon Romanovsky (14):
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
      RDMA/mlx5: Fix stack out-of-bounds read in cc_params debugfs
      RDMA/mlx5: Send cong param changes to the resolved port mdev
      RDMA/cxgb4: free STAG index when TPT entry write fails
      RDMA/erdma: restrict the driver to little-endian systems

Li Qiang (1):
      scsi: ufs: debugfs: Reserve space for a string terminator

Li RongQing (1):
      vdpa/mlx5: fix wrong list iterated in add_direct_chain error path

Li Wang (1):
      ksm_tests: skip hugepage test when Transparent Hugepages are disabled

Li Zetao (1):
      spi: davinci: Use helper function devm_clk_get_enabled()

Liam R. Howlett (Oracle) (1):
      maple_tree: fix argument name in header

LiangCheng Wang (1):
      ASoC: fsl-asoc-card: defer probe when the CPU DAI device is not ready

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

Liu Qi (1):
      usb-storage: ene_ub6250: fix race between scan work and probe

Loic Poulain (3):
      phy: qcom: qmp-usb-legacy: Fix possible NULL-deref on early runtime suspend
      phy: qcom: snps-femto-v2: Fix possible NULL-deref on early runtime suspend
      phy: qcom: qmp-usb: Fix possible NULL-deref on early runtime suspend

Lothar Rubusch (1):
      crypto: atmel-sha204a - fix heap info leak on I2C transfer failure

Lovekesh Solanki (1):
      USB: gadget: fix NULL pointer dereference in gadget_dev_ioctl()

Luca Weiss (1):
      arm64: dts: qcom: sm7225-fairphone-fp4: Fix address in fb node name

Lukasz Majewski (2):
      net: hsr: Use full string description when opening HSR network device
      net: hsr: Provide RedBox support (HSR-SAN)

MD Danish Anwar (1):
      net: hsr: enable promiscuous mode on interlink port with fwd offload

Ma Ke (2):
      power: supply: bq25890: Fix power_supply reference leak
      platform/x86: ishtp_eclite: Fix ACPI device reference leak in probe error path

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
      wifi: ath11k: Clear affinity hint before calling ath11k_pcic_free_irq() in error path
      bus: mhi: host: Flush the posted write after writing to MHI_SOC_RESET_REQ_OFFSET
      arm64: dts: qcom: sc8180x: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sdm845: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8150: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8250: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8350: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8450: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm8550: Fix the msi-map entries
      arm64: dts: qcom: sm8550: Fix the PCIe iommu-map entries
      arm64: dts: qcom: sm7225-fairphone-fp4: Fix swapped USB QMP PHY vdda-phy/vdda-pll supplies

Maoyi Xie (5):
      power: supply: twl4030_charger: cancel workers via devm
      i3c: master: svc: bound IBI payload to the requested max_payload_len
      w1: ds28e17: reject an oversize length on an I2C block read
      platform/chrome: cros_ec_typec: Reject out-of-bounds PD cap count
      drm/bridge: tc358767: clamp the reported AUX read size to the request

Marc Zyngier (1):
      PCI: xgene: Drop XGENE_PCIE_IP_VER_UNKN

Marco Elver (2):
      kcsan: avoid unintended access checking in NMIs
      arm64: Disable KCSAN instrumentation in delay.o

Marek Czernohous (2):
      forcedeth: fix off-by-one when saving/restoring non-PCI config space
      forcedeth: stop the tx_timeout register dump past the requested window

Marino Dzalto (1):
      netfilter: xt_HL: add pr_fmt and checkentry validation

Marius Cristea (1):
      hwmon: (emc1403) Drop hysteresis for low limit temperature

Mark Brown (1):
      selftests/mm: report unique test names for each cow test

Mark Zhang (1):
      RDMA/core: Add driver APIs pre_destroy_cq() and post_destroy_cq()

Martin Blumenstingl (1):
      clk: meson: align gxbb_32k_clk_sel number of parents with actual count

Martin Kaiser (1):
      hwrng: ks-sa - access private data via struct hwrng

Masami Hiramatsu (Google) (3):
      tracing/mmiotrace: Add NULL check for mmio_trace_array in logging functions
      kprobes: Protect kprobe_blacklist with RCU
      tracing: Remove "__attribute__()" from the type field of event format

Mathieu Dubois-Briand (1):
      clk: ti: mux: resolve parent clocks by DT index, not by name

Matt Turner (4):
      alpha: fix ieee_swcr_to_fpcr setting FPCR_DNOD unconditionally
      alpha: don't leak hardware-fabricated FP exception bits to user space
      alpha: marvel: Fix irq_set_status_flags to use correct IRQ number
      alpha: marvel: Fix lock ordering in init_io7_irqs()

Matthew Wilcox (Oracle) (6):
      nilfs2: add nilfs_end_folio_io()
      nilfs2: convert nilfs_forget_buffer to use a folio
      nilfs2: convert to nilfs_folio_buffers_clean()
      nilfs2: convert nilfs_btnode_prepare_change_key to use a folio
      nilfs2: convert nilfs_btnode_commit_change_key to use a folio
      nilfs2: convert nilfs_page_bug() to nilfs_folio_bug()

Matti Vaittinen (1):
      power: supply: bd99954: Drop bad register fields

Matvey Kovalev (1):
      wifi: ath11k: fix NULL dereference in ath11k_qmi_m3_load()

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

Meghana Malladi (1):
      arm64: dts: ti: k3-am64: Fix MDIO clock reference for ICSSG0 node

Mert Seftali (1):
      iio: accel: dmard09: Implement IIO_CHAN_INFO_SCALE

Michael Bommarito (8):
      NFSD: restart ssc_expire_umount walk after dropping nfsd_ssc_lock
      libceph: validate OSD extent maps before cursor advance
      ceph: bound copied dentry name length in NFS export get_name
      ceph: bound num_export_targets array for mds info v2/v3
      ceph: bound xattr value length in __build_xattrs()
      lockd: pin next file across nlm_inspect_file lock-drop
      HID: roccat: bound device-supplied profile index
      usb: gadget: configfs: fix out-of-bounds read of qw_sign

Michael Byczkowski (1):
      pps: pps-gpio: split IRQ handler into hardirq timestamper + threaded handler

Michael S. Tsirkin (1):
      virtio_balloon: disable indirect descriptors

Michael Walle (4):
      regulator: tps6594-regulator: remove interrupt_count
      regulator: tps6594-regulator: remove hardcoded buck config
      regulator: tps6594-regulator: refactor variant descriptions
      powerpc/configs: enable CONFIG_RAS to fix EDAC support

Michal Koutný (1):
      netfilter: xt_cgroup: Make it independent from net_cls

Mike Rapoport (Microsoft) (1):
      selftests/mm: ksm_tests: use kselftest framework

Mike Snitzer (1):
      NFSD: remove flawed WARN_ON_ONCE from nfsd_mode_check

Mikko Perttunen (2):
      gpu: host1x: Fix offset calculation in trace_write_gather
      gpu: host1x: Avoid stack over-read in debug output helpers

Miklos Szeredi (1):
      fuse: use FUSE_ROOT_ID in fuse_get_root_inode()

Mikulas Patocka (3):
      dm-stats: fix a crash if allocation of per-cpu data fails
      dm: fix race when loading and unloading a table
      dm: fix resume-vs-remove race

Min zhang (1):
      clk: hisilicon: reset: Use devm_kzalloc to initialize hisi_reset_controller

Ming Qian (1):
      media: v4l2-ctrls: Allow unknown HDR10 white point and luminance

Mohamad Raizudeen (1):
      PCI: Fix 32-bit config write in Intel PCH Root Port MPC ACS quirk

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

Muhammad Bilal (12):
      platform/x86: hp-bioscfg: accept reduced ACPI packages from older HP BIOS
      platform/x86: hp-bioscfg: advance elem past consumed array elements
      platform/x86: hp-bioscfg: bound ordered-list parsing by the package count
      platform/x86: hp-bioscfg: fix heap OOB read in sk_store() and kek_store()
      platform/x86: hp-bioscfg: fix heap OOB read on empty password write
      platform/x86: hp-bioscfg: fix new_password_store() overwriting current_password
      platform/x86: hp-bioscfg: fix off-by-one write in hp_get_string_from_buffer()
      platform/x86: hp-bioscfg: fix ORD_LIST_ELEMENTS never being parsed
      platform/x86: hp-bioscfg: pass validated element count to package parsers
      platform/x86: hp-bioscfg: warn on element type mismatch instead of failing
      staging: rtl8723bs: fix OOB read / stack overflow in rtw_get_wps_attr()
      staging: rtl8723bs: fix OOB read in rtw_action_frame_parse()

Muhammad Usama Anjum (3):
      selftests/mm: skip COW tmpfile cases when fallocate() is unsupported
      selftests/arm64: Print missing MTE TAP headers
      selftests/arm64: Treat KSM merge_across_nodes as optional

Mukesh Ojha (5):
      iommu/qcom: Fix inverted fault report check in qcom_iommu_fault()
      remoteproc: Move resource table data structure to its own header
      remoteproc: use rsc_table_for_each_entry() in rproc_handle_resources()
      remoteproc: fix OOB read via signed offset in rsc_table_for_each_entry()
      firmware_loader: do not queue completed sysfs fallback requests

Myeonghun Pak (11):
      usb: gadget: snps_udc_plat: clean up PHY on probe deferral
      fbdev: uvesafb: unregister connector callback on init failure
      nvme-pci: disable controller on admin queue IRQ setup failure
      tpm: tpm_i2c_nuvoton: disable IRQ on wait timeout
      media: rc: sunxi-cir: Unregister rc device on probe failure
      clk: versaclock7: Fix APLL clock leak on probe failure
      crypto: keembay - Fix AEAD unregister count in error path
      char: xilinx_hwicap: unregister class on init errors
      RDMA/erdma: Fix CEQ tasklet use-after-free on removal
      clk: palmas: Manage external-control prepare with devm
      fbdev: tdfxfb: fix PCI enable cleanup with pcim_enable_device()

Naman Jain (1):
      PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip

Namhyung Kim (3):
      perf test: Update all metrics test like metricgroups test
      perf test: Do not skip when some metrics tests succeeded
      perf test: Fix perf stat --bpf-counters on hybrid machines

Namjae Jeon (4):
      ksmbd: fix WARNING "do not call blocking ops when !TASK_RUNNING"
      ksmbd: do not advertise unimplemented CA support
      ksmbd: free preauth sessions on connection teardown
      ksmbd: disconnect on SMB3 decryption failure

Nathan Chancellor (1):
      arch_numa: avoid false positive fortify warning in setup_node_to_cpumask_map()

Naveen Kumar Chaudhary (1):
      locking/lockdep: Fix NULL pointer dereference in __lock_set_class()

Naveen Mamindlapalli (1):
      octeontx2-af: Fix TL3/TL2 link config ENA clearing

Neil Armstrong (1):
      arm64: dts: qcom: sm8550: Use GIC-ITS for PCIe0 and PCIe1

Neill Kapron (1):
      usb: gadget: f_fs: Prevent deadlock during ep0 read loop

Nguyen Dinh Phi (1):
      vsock: use sock_error() to consume sk_err after a failed connect

Nick Chan (3):
      nvme: apple: Add Apple A11 support
      nvme-apple: Prevent shared tags across queues on Apple A11
      nvme-apple: Reset q->sq_tail during queue init

Nicolas Frattaroli (1):
      drm/rockchip: vop2: Recognise 10-bit YUV422 as YUV format

Nikhil Gautam (6):
      iio: light: opt4001: Fix power down clearing bits of the wrong register
      iio: light: opt4001: Fix incompatible pointer type passed to div_u64_rem()
      iio: light: opt4001: Reject integration times with a non-zero seconds part
      iio: light: opt4001: Fix reversed GENMASK() arguments in fault count mask
      iio: light: gp2ap002: Fix unbalanced runtime PM on repeated event writes
      iio: light: gp2ap002: re-enable irq if runtime suspend fails

Niklas Cassel (2):
      ata: libata-scsi: fix DSM TRIM for sector sizes larger than 2048 bytes
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

Nirmala Devi Mal Nadar (2):
      mfd: tps6594: Add register definitions for TI TPS65224 PMIC
      regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators

Norbert Szetei (5):
      RDMA/ucma: Lock the handler in ucma_set_ib_path()
      openvswitch: only skb_tx_error() a packet we are about to drop
      net: skbuff: don't touch shared zerocopy state in skb_tx_error()
      net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
      ksmbd: fix overflow in dacloffset bounds check

Nícolas F. R. A. Prado (1):
      pinctrl: mediatek: eint: Fix invalid pointer dereference for v1 platforms

Ondrej Jirman (1):
      arm64: dts: allwinner: sun50i-a64-pinephone: Fix mpu6050 mount matrix

Pablo Neira Ayuso (2):
      netfilter: nf_tables: move hardware offload step after building the chain blob
      netfilter: x_tables: replace pr_{info,err}() by pr_info_ratelimited()

Patrisious Haddad (8):
      RDMA/core: Add support to set privileged QKEY parameter
      RDMA/core: Add rdma_restrack_begin/abort/commit_del() operations
      RDMA/core: Fix use after free in ib_query_qp()
      RDMA/core: Fix potential use after free in ib_destroy_cq_user()
      RDMA/core: Fix potential use after free in ib_destroy_srq_user()
      RDMA/core: Fix potential use after free in counter_release()
      RDMA/core: Fix potential use after free in ib_free_cq()
      RDMA/core: Fix potential use after free in ib_dealloc_pd_user()

Paul Chaignon (1):
      bpf: Reject narrower access to pointer ctx fields

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
      eCryptfs: bound the packet-length peek to the user buffer
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

Peter Oberparleiter (1):
      s390/debug: Fix deadlock during unregister

Petr Oros (1):
      ice: clear the default forwarding VSI rule when releasing a VSI

Petr Vaganov (1):
      scsi: core: Fill in DMA padding bytes in scsi_alloc_sgtables()

Philipp Weber (1):
      HID: core: quiesce input in hid_hw_stop() to prevent use-after-free

Phillip Lougher (1):
      Squashfs: check block offset is not negative

Pranjal Shrivastava (1):
      iommu/arm-smmu-v3: Convert to use atomic poll timeout

Pu Lehui (6):
      bpf: Fix potential UAF in bpf_netns_link_update_prog
      bpf: Fix potential UAF when reading bpf link info
      bpf, cgroup: Fix invalid storage access after __cgroup_bpf_attach failed
      selftests/bpf: Limit URLS parsing logic to actual scope in vmtest
      selftests/bpf: Support local rootfs image for vmtest
      selftests/bpf: Add description for running vmtest on RV64

Qing Ming (1):
      mpls: reload header after pskb_may_pull()

Qingfang Deng (1):
      pppox: drain queued packets on channel handoff

Qingshuang Fu (1):
      irqchip/renesas-irqc: Fix generic interrupt chip leak on remove

Quentin Schulz (1):
      arm64: dts: rockchip: fix eMMC reset polarity on PX30 Ringneck

Rafael J. Wysocki (3):
      cpufreq: intel_pstate: Fix setting minimum P-state at init time
      ACPI: processor: idle: Expand _LPI package sanity checks
      ACPI: processor: Update cpuidle driver check in __acpi_processor_start()

Ran Hongyun (1):
      UBI: fix two issues in the ubi.mtd MODULE_PARM_DESC

Ricardo B. Marlière (1):
      libbpf: Search /lib64 and /lib in resolve_full_path()

Ricardo Neri (1):
      sched/fair: Check CPU capacity before comparing group types during load balance

Robbie Ko (1):
      nfsd: reject out-of-range useconds in NFSv2 SETATTR/CREATE

Robert Richter (1):
      cxl/pci: Store the endpoint's Component Register mappings in struct cxl_dev_state

Robertus Diawan Chris (1):
      modpost: prevent leak when early return no suffix .o in read_symbols()

Ronald Claveau (1):
      PCI: meson: Fix GPIO state while requesting PERST#

Rosen Penev (4):
      ARM: dts: helios4: add vcc-supply to EEPROM
      ARM: dts: helios4: add vcc-supply to GPIO expander
      ARM: dts: helios4: add SATA regulator supplies
      ASoC: xilinx: formatter_pcm: fix stream_data leak on open error

Runyu Xiao (9):
      fbdev: omapfb: panel-dsi-cm: initialize lock before registering display
      ALSA: pcxhr: initialize mutexes before requesting threaded IRQ
      wifi: mt76: mt7615: avoid waiting for mac work under the mt76 mutex
      scsi: pm8001: Use rollback index when freeing MSI-X vectors
      ALSA: harmony: initialize locks before requesting IRQ
      ASoC: cs35l33: drain threaded IRQ before runtime suspend
      ASoC: cs35l34: drain threaded IRQ before runtime suspend
      ASoC: rt700-sdw: always drain jack work on remove
      sunrpc: xprtsock: annotate shared socket callbacks with READ_ONCE/WRITE_ONCE

Ruoyu Wang (15):
      net: openvswitch: fix nf_connlabels leak in ovs_ct_init
      media: cec: Serialize exclusive follower delivery
      media: cobalt: Avoid freeing ALSA private data twice
      media: zoran: Avoid freeing a registered video_device twice
      bus: qcom-ebi2: Fix clock leak on probe failure
      usb: gadget: aspeed_udc: check endpoint DMA allocation
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

Ryan Roberts (5):
      selftests/mm/kugepaged: restore thp settings at exit
      selftests/mm: factor out thp settings management
      selftests/mm: support multi-size THP interface in thp_settings
      selftests/mm/khugepaged: enlighten for multi-size THP
      selftests/mm/cow: generalize do_run_with_thp() helper

Ryusuke Konishi (2):
      nilfs2: fix slab-out-of-bounds in nilfs_direct_propagate after truncation
      nilfs2: fix BUG in nilfs_copy_dirty_pages() on dirty state mismatch

SJ Park (12):
      mm/damon/sysfs-schemes: kobject_del() scheme dirs
      mm/damon/sysfs-schemes: kobject_del() scheme filter dirs
      mm/damon/sysfs-schemes: kobject_del() scheme region dirs
      mm/damon/sysfs: kobject_del() region and target (error) dirs
      mm/damon/sysfs: kobject_del() target (normal), context and kdamond dirs
      mm/damon/core-kunit: check region count before testing in split_at()
      mm/damon/vaddr: drop last same folio access check optimization
      mm/damon/paddr: drop last same folio access check reuse optimization
      mm/damon/vaddr-kunit: check region count in three_regions test
      mm/damon/core-kunit: handle region split failure in filter_out()
      mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
      mm/damon/core: skip aging from repeated aggressive merging

Sajal Gupta (1):
      md/raid5-ppl: fix use-after-free in ppl_do_flush()

Saket Kumar Bhaskar (1):
      powerpc/irq: Fix missing r2 clobber in PCREL inline assembly

Samuel Page (1):
      fs/ntfs3: fix info-leak on partial LZNT decompress in ni_read_frame()

Sandipan Das (3):
      perf/x86/amd/uncore: Refactor uncore management
      perf/x86/amd/uncore: Add group validation
      perf/x86/amd/uncore: Fix the return value of amd_uncore_df_event_init() on error

Sang-Heon Jeon (2):
      iio: light: isl29028: return zero in write_raw() on success
      iio: light: tsl2583: return zero in write_raw() on success

Sanghyun Park (2):
      bpf: Fix use-after-free on mm_struct in bpf_find_vma()
      xfrm: Fix skb double-free in xfrm_dev_direct_output()

Sanjay Chitroda (2):
      iio: temperature: hid-sensor-temperature: switch to non-devm iio_device_register()
      iio: orientation: hid-sensor-rotation: Avoid race between callback setup and device exposure

Sanman Pradhan (1):
      hwtracing: hisi_ptt: Propagate DMA reset timeout in trace_start()

Sayali Patil (2):
      selftests/mm: fix ksm NUMA merge test for systems with memoryless NUMA nodes
      selftests/mm: fix ternary operator precedence in ksm_tests

Sean Rhodes (1):
      misc: rtsx_usb: avoid USB I/O in runtime autosuspend

Sean Young (2):
      media: keymaps: Remove obsolete RC_MAP_RC5_TV keymap define
      media: keymaps: Remove obsolete RC_MAP_HAUPPAUGE_NEW keymap define

Sebastian Andrzej Siewior (1):
      net: hsr: Use the seqnr lock for frames received via interlink port.

Sebastian Reichel (1):
      media: v4l: async: Drop useless list move operation

Sechang Lim (1):
      tcp: clear sock_ops cb flags before force-closing a child socket

Seiji Nishikawa (1):
      ipmi: si: Fix NULL pointer dereference after failed registration

Selvin Xavier (1):
      RDMA/bnxt_re: Clear VM_MAYWRITE on DBR/toggle page mmap

Sergei Litvin (1):
      scripts/tags.sh: Prevent binary files appearing in cscope.files

Serhat Kumral (1):
      RDMA/ucma: Allow path records to exactly fit the output buffer

Shin'ichiro Kawasaki (3):
      nvmet-rdma: factor out response resource cleanup
      nvmet-rdma: fix response resource leak on queue teardown
      null_blk: add configfs variable shared_tags

Shivam Kumar (2):
      nvmet-tcp: fix out-of-bounds write when receiving an over-long PDU
      nvmet-tcp: reject unsolicited H2CData PDUs

Shivam Rawat (1):
      drm/msm/a6xx: Fix stale rpmh votes after suspend

Shuangpeng Bai (3):
      media: usbtv: keep device alive while ALSA card exists
      media: go7007: defer the ALSA v4l2 put until card release
      RDMA/siw: Fix use-after-free in siw_accept()

Simon Glass (1):
      pinctrl: rockchip: Reset the pin count when recalculating SoC data

Slawomir Stepien (1):
      wifi: zd1211rw: reject secondary interfaces to prevent conflicts

Sonali Pradhan (1):
      usb: gadget: u_audio: Fix use-after-free on sound card disconnect

Sourabh Jain (3):
      powerpc/pseries: Handle and log pseries-wdt registration failures
      powerpc/pseries: Move H_WATCHDOG definitions to a common header
      powerpc/crash: stop watchdogs before booting kdump kernel

Srinivas Kandagatla (2):
      soundwire: qcom: Fix port exhaustion check in stream_alloc_ports
      rpmsg: glink: remove duplicate code for rpmsg device remove

Srinivas Pandruvada (2):
      platform/x86: ISST: Just allow 2 bits for SST feature enable
      platform/x86: ISST: Validate logical CPU id and clos id

Stanislav Kinsburskii (1):
      lib/test_hmm: fail dmirror_fault() when the mirrored mm is gone

Stanislaw Gruszka (1):
      wifi: rtl818x: initialize eeprom_93cx6 struct to zero

StanleyYP Wang (1):
      wifi: mt76: mt7996: fix reg addr remap when addr is 0

Stefan Haberland (3):
      s390/dasd: Do not complete a failed ESE read as successful
      s390/dasd: Guard sysfs discipline callbacks against unallocated private data
      s390/dasd: Propagate partial completion length across ERP recovery

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
      tracing/mmiotrace: Remove reference to unused per CPU data pointer
      tracing: Have trace_event_update_all() only handle module that is loading

Su Yue (1):
      md/md-bitmap: fix wrong bitmap_limit for clustermd when write sb

Sudeep Holla (12):
      firmware: arm_scmi: Unregister device notifier before IDR teardown
      firmware: arm_scmi: Free transport channel on IDR failure
      firmware: arm_scmi: Avoid IDR updates while cleaning channels
      firmware: arm_scmi: Reject out of range DT protocol IDs
      firmware: arm_scmi: Use channel ID for transport teardown
      firmware: arm_scmi: Protect device request lookup with RCU
      firmware: arm_scmi: Drop handle on protocol bind failures
      firmware: arm_scmi: Fix requested device removal race
      firmware: arm_scmi: Unrequest devices if driver registration fails
      mailbox: pcc: Always map the shared memory communication address
      Revert "mailbox/pcc: support mailbox management of the shared buffer"
      firmware: arm_scmi: Roll back partial protocol table registration

Sujal Tuladhar (1):
      scsi: target: iscsi: Reserve a terminator byte for the login payload

Sunday Clement (1):
      drm/amdkfd: Reject zero-sized AQL queue allocations after size halving

Sunil Khatri (1):
      drm/amdgpu: use AMDGPU_GPU_PAGE_SHIFT instead of PAGE_SHIFT

Suraj Gupta (1):
      dmaengine: xilinx_dma: Fix channel idle state management in AXIDMA and MCDMA interrupt handlers

Sven Eckelmann (5):
      batman-adv: dat: avoid unaligned fault in IP extraction
      batman-adv: bla: fix freeing of claims on meshif deletion
      batman-adv: bla: prevent CRC corruptions after claim flush
      batman-adv: dat: atomically update mac addresses
      batman-adv: bla: avoid CRC corruption due to parallel claim add

Sven Peter (4):
      nvme-apple: Destroy the admin queue on removal
      nvme-apple: Don't set a DMA direction for commands without a data transfer
      nvme-apple: Never set the opcode in the NVMMU TCB
      nvme-apple: Drop the PRP null check chicken bit

Takashi Iwai (12):
      ALSA: aloop: Fix racy access at PCM trigger
      ALSA: aloop: Check card index validity at probe
      ALSA: mpu401: Check card index validity at probe
      ALSA: mts64: Check card index validity at probe
      ALSA: portman2x4: Check card index validity at probe
      ALSA: serial-u16550: Check card index validity at probe
      ALSA: virmidi: Check card index validity at probe
      ALSA: pcm: Fix race between non-atomic ops and trigger-start
      ALSA: seq: midi: Optimize event_input locking with RCU
      ALSA: control: Use automatic cleanup of kfree()
      ALSA: control: Use guard() for locking
      ALSA: control: Fix unannotated kfree() cleanup

Takuma Fujiwara (1):
      PCI: j721e: Fix incorrect max_lanes for J7200

TanZheng (1):
      RDMA/srpt: Fix srpt_alloc_rw_ctxs() unwind counters

Tanushree Shah (3):
      perf data convert json: Fix trace_seq memory leak in process_sample_event()
      perf trace-event: Fix buffer overflow in read_string()
      perf trace-event: Fix integer truncation in do_read() and skip()

Tao Cui (3):
      block/blk-stat: drain per-cpu callback stats over possible CPUs
      block/blk-iocost: collect per-cpu latency stats over possible CPUs
      block/kyber-iosched: flush per-cpu latency buckets over possible CPUs

Tao Yu (1):
      drm/gud: validate TV mode names before creating enum property

Tengda Wu (1):
      perf test: Use sqrtloop workload to test bperf event

Tetsuo Handa (1):
      net: add missing ref_tracker_dir_exit() to net_passive_dec()

Thadeu Lima de Souza Cascardo (1):
      drm: Fix drm_crtc_commit leak if signaled when PAGE_FLIP_EVENT is used

Thomas Bogendoerfer (1):
      MIPS: ptrace: Fix syscall skipping via PTRACE_SYSCALL

Thomas Gleixner (2):
      timer: Keep debugobjects state consistent in migrate_timer_list()
      irqdomain: Make build work for CONFIG_GENERIC_IRQ_CHIP=n

Thomas Richard (1):
      regulator: tps6594-regulator: Fix the number of irqs for TPS65224 and TPS6594

Thomas Richter (2):
      s390/cpum_cf: Handle CPU hotplug via prepare/dead callbacks
      perf test: raise limit to 20 percent for perf_stat_--bpf-counters_test

Thomas Weißschuh (2):
      y2038: uapi: Use 64-bit __kernel_old_timespec::tv_nsec on x32
      tools/nolibc/powerpc: mark ctr and xer as clobbered by system call

Thomas Zimmermann (2):
      drm/hibmc: Fix list of formats on the primary plane
      drm/hibmc: Use drm_atomic_helper_check_plane_state()

Thorsten Blum (5):
      crypto: atmel-ecc - replace min_t with min
      crypto: atmel-ecc - clean up and improve ECDH comments
      crypto: atmel-ecc - reject hardware ECDH without a public key
      crypto: sl3516 - drop invalid sg_dma_len checks before DMA mapping
      apparmor: Replace sprintf/strcpy with scnprintf/strscpy in aa_policy_init

Tien Sung Ang (1):
      fpga: stratix10-soc: Fix SVC mailbox handling during reconfiguration

Tim Harvey (1):
      PCI: Add ACS quirk for Pericom PI7C9X2G608 switches [12d8:2608]

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

Tzung-Bi Shih (2):
      platform/chrome: sensorhub: Fix dropped timestamp events and log spam
      platform/chrome: sensorhub: Fix memory overread in ring handler

Uday Khare (3):
      media: video-i2c: fix kthread error pointer left in kthread_vid_cap on failure
      regulator: tps6594: Fix device node reference leaks in multiphase loop
      remoteproc: qcom: Fix glink->node reference leak in qcom_add_glink_subdev

Uwe Kleine-König (3):
      usb: gadget: aspeed_udc: Convert to platform remove callback returning void
      power: supply: sc2731_charger: Convert to platform remove callback returning void
      net: ipa: Convert to platform remove callback returning void

Vaibhav Nagare (1):
      qede: Fix NULL pointer dereference in TPA fragment processing

Valentin Kindschi (2):
      Bluetooth: hci_conn: re-enable advertising only for peripheral role
      Bluetooth: hci_event: clear HCI_LE_ADV only on a created connection

Valentin Schneider (1):
      rcu: Rename rcu_momentary_dyntick_idle() into rcu_momentary_eqs()

Valery Borovsky (3):
      media: airspy: use vb2_video_unregister_device() on disconnect to fix NULL deref
      media: rtl2832_sdr: use vb2_video_unregister_device() on remove to fix DMA leak
      media: rtl2832_sdr: release URBs and stream buffers on start_streaming() failure

Vasileios Almpanis (1):
      i2c: core: fix debugfs UAF on adapter removal

Veronika Molnarova (1):
      perf test stat_bpf_counter.sh: Stabilize the test results

Viacheslav Dubeyko (1):
      ceph: fix BUG_ON in __ceph_build_xattrs_blob() due to stale blob size

Victor Nogueira (2):
      net/sched: cls_api: fix teardown of an adopted proto on insert-race loss
      net/sched: sch_teql: restore skb->dev on the slave failure path

Viktor Malik (1):
      selftests/bpf: Silence array bounds warning in global_map_resize

Vincent Mailhol (1):
      lib/ucs2_string.c: fix out-of-bounds read in ucs2_strnlen()

Vineet Gupta (1):
      selftests/bpf: vmtest.sh: Preserve command quoting when running in the VM

Vishnu Santhosh (1):
      rpmsg: glink: fix deadlock in endpoint destroy during driver detach

Vladimir Murzin (1):
      arm64: hibernate: Restore DAIF state on error

Vladimir Oltean (1):
      net: dsa: b53: fix error propagation from b53_fdb_dump()

Vladimir Zapolskiy (4):
      dmaengine: mediatek: mtk-uart-apdma: Return -ENOMEM on memory allocation failure
      dmaengine: hisilicon: Return -ENOMEM on dynamic memory allocation in probe
      iommu/msm: Return -ENOMEM on memory allocation failure in probe
      clk: qcom: Return expected ENOMEM error on dynamic allocation failure

Wei Jie Law (1):
      HID: rmi: fix OOB access with undersized RMI reports

Wei Wang (2):
      iommu/amd: Prevent SB IOAPIC from overriding IVRS validation errors
      iommu/amd: Fix false positive in SB IOAPIC IVRS validation

Wei Yang (1):
      mm/mm_init: fix incorrect node_spanned_pages

Weigang He (4):
      media: cec: stm32: prevent out-of-bounds write on RX overflow
      soc: samsung: exynos-pmu: fix of_node refcount leak in exynos_get_pmu_regmap()
      ARM: imx: fix device_node refcount leak in imx_src_init()
      ARM: imx: fix device_node refcount leaks in imx7_src_init()

Weilin Wang (1):
      perf test: Simplify metric value validation test final report

Weiming Shi (5):
      sctp: fix NULL deref on untransmitted RECONF completion
      xdp: fix zero-copy frame layout
      fs/ntfs3: reject restart table growth beyond U16_MAX entries
      SUNRPC: check rpc_sockaddr2uaddr() return value in rpcb_register_inet4/6
      fs/ntfs3: validate ef->size covers the record's name and value

Weiming Wu (1):
      fs/ntfs3: fix out-of-bounds read of INDEX_ROOT in reparse/objid init

WenTao Liang (3):
      regulator: as3722_get_regulator_dt_data: fix premature of_node_put leaving dangling of_node pointer
      regulator: max8998_pmic_dt_parse_pdata: of_node_put on reg_np after ownership transferred to rdata
      ASoC: samsung: aries_audio_probe: double of_node_put due to direct assignment without of_node_get

Wenjie Qi (2):
      f2fs: return symlink writeback errors
      f2fs: return writeback error from collapse range

Wentao Guan (1):
      LoongArch: Do not save/restore percpu base register in rethook trampoline

Wentao Liang (2):
      drm/sun4i: fix refcount leak in sun4i_backend_init_sat()
      nvme: target: rdma: fix ndev refcount leak on queue connect

Wolfram Sang (1):
      hwspinlock: propagate errno when registering single lock

Wupeng Ma (1):
      mm/hugetlb: fix missing migratable flag on same-node hugetlb migration

Xiang Mei (9):
      fs/ntfs3: validate dirty page table on log replay
      bridge: mrp: reject zero test interval to avoid OOM panic
      xfrm6: fix out-of-bounds write in xfrm6_input_addr() when secpath is full
      isofs: fix out-of-bounds page array access on empty zisofs block
      vfio/pci: clear vdev->msi_perm after freeing it on init failure
      ext4: fix out-of-bounds read in ext4_read_inline_dir()
      ext4: check dir entry fits before reading the hash trailer in ext4_search_dir()
      vxlan: vnifilter: enforce exact length of GROUP/GROUP6 attributes
      net: qualcomm: rmnet: restore skb->dev on deaggregated frames

Xie Yuanbin (1):
      ARM: 9485/1: mm: acquire mmap write lock around show_pte() for user faults

Xin Chen (1):
      Bluetooth: hci_core: use skb_get() instead of skb_clone() for req_skb

Xin Xie (1):
      net: hsr: free learned nodes on device setup failure

Xingrui Li (1):
      HID: sensor-hub: Fix out-of-bounds write in sensor_hub_get_feature

Xiubo Li (2):
      ceph: fix UAF in __kick_flushing_caps() on cf entry freed during unlock
      ceph: revalidate ki_pos for O_APPEND writes after cap acquisition

Xixin Liu (1):
      nvmet-rdma: fix queue leak when connect backlog is exceeded

Xu Rao (4):
      HID: roccat: free buffered reports when destroying device
      mtd: mtdoops: free page bitmap when the backing MTD is removed
      media: v4l2-async: avoid deleting unlinked ASC entry on link error
      ALSA: hda: Fix connection list comparison in proc output

Xu Yang (2):
      device property: fix infinite loop in fwnode_for_each_child_node()
      usb: gadget: f_uac1_legacy: remove broken string configfs attributes

Xuanqiang Luo (1):
      net: ravb: avoid dereferencing an invalid PTP clock

Yajun Deng (1):
      USB: core: Use device_driver directly in struct usb_driver and usb_device_driver

Yang Shi (1):
      selftests: arm64: add hugetlb mte tests

Yang Wang (1):
      drm/amdgpu: check thunderbolt before switcheroo registration

Yang Xiuwei (2):
      scsi: sd: Fix sd_done() sense handling condition
      nvme/ioctl: check SUBMIT_IO with nvme_cmd_allowed()

Yao Kai (1):
      futex: Prevent rcuwait use-after-free during requeue PI

Yehyeong Lee (10):
      nvme: zero the discard fallback page
      nvme-tcp: do not accept C2HData based on blk_rq_payload_bytes() alone
      nvme-tcp: fix host memory disclosure on R2T for a read command
      nvme-tcp: reject a read that transferred too few bytes
      nvme-tcp: check the data direction of a C2HData PDU
      IB/isert: reject PDUs declaring more data than was received
      IB/isert: reject login PDUs declaring more data than was received
      RDMA/srp: fix heap information leak on a truncated SRP_CRED_REQ
      IB/isert: delay the final Login Response until the session is registered
      IB/isert: post the full-feature receive buffers after session registration

Yemu Lu (1):
      fat: restore original value when fat_ent_write failed

Yeoreum Yun (3):
      coresight: etm4x: fix wrong check of etm4x_sspcicrn_present()
      coresight: etm4x: fix underflow for usage of (nrseqstate - 1)
      coresight: etm4x: fix leaked trace id

Yi Ding (2):
      media: cec: meson: ao-cec-g12a: name the CEC core regmap to avoid debugfs clash
      rtc: pcf8563: fix clock provider leak on unbind

Yichong Chen (13):
      ecryptfs: fix tag 11 packet exact-fit size check
      ecryptfs: hold msg ctx list lock when cleaning daemon queue
      ecryptfs: pass packet set buffer size to parser
      ecryptfs: reject too-small tag 70 packets
      ecryptfs: release message context on send failure
      ecryptfs: show filename encryption options
      tools/bpf/bpftool: Reset vmlinux BTF after map commands
      tools/bpf/bpftool: Reset vmlinux BTF after struct_ops commands
      isofs: release zisofs block pointer buffer head
      fanotify: report full event length for FIONREAD
      fat: release buffer head after rebuilding parent
      hugetlbfs: release subpool on fill_super failure
      btrfs: retry verity reads for not-uptodate Merkle folios

Yicong Hui (1):
      drm: Remove unused header in drm_dumb_buffers.c

Yifei Gao (1):
      orangefs: fix double-free of trailer_buf on readdir copy failure

Yinhao Hu (1):
      nfc: pn533: hold a reference to the request skb during send_frame

Yonatan Nachum (1):
      RDMA/efa: Fix PBL chunk length computation

Yosry Ahmed (2):
      KVM: nVMX: Always flush vpid02 on first use
      KVM: nVMX: Service local TLB flushes on failed nested VM-Enter

Youngjae Kwon (1):
      fsnotify: Fix stale object mask after concurrent mark updates

Yousef Alhouseen (2):
      ipmi: ipmb: validate write message length
      HID: synchronize input before cleaning up a failed probe

Yu Kuai (2):
      md/raid5: round bitmap stripes with sector division
      md: avoid stale clone I/O accounting timestamps

Yu Peng (1):
      perf metricgroup: Fix metric expression copy leaks

Yuan Chen (1):
      bpftool: Fix double close in map dump

Yuanshen Cao (1):
      iio: light: tsl2772: fix ALS calibscale readback

Yue Haibing (1):
      rcu: Remove unused function declaration rcu_eqs_special_set()

Yuho Choi (12):
      bus: ti-sysc: Fix /chosen node reference leak
      clocksource: Unregister subsystem on device registration failure
      bus: mhi: ep: Fix device refcount leak in the error path of MHI device creation
      serial: ma35d1: Fix OF node reference leaks in console init
      hwrng: ks-sa - Fix runtime PM cleanup on registration failure
      PCI: xgene: Drop unnecessary OF node reference
      uio: Fix stale info pointer in failed registration path
      driver core: soc: Unregister bus on early device registration failure
      ACPI: video: Release PCI device reference after lookup
      ubi: Fix rollback for explicit UBI device numbers
      xenbus: Unregister reboot notifier on init failure
      clocksource/drivers/armada: Unwind timer clock on init failure

Yun Zhou (4):
      usb: gadget: f_tcm: fix deadlock in usbg_make_tpg()
      ext4: fix circular lock dependency in ext4_ext_migrate
      ext4: skip extra isize expansion during mount to prevent deadlock
      nfc: nci: fix use of uninitialized memory in CORE_INIT_RSP parsing

Yunseong Kim (1):
      ksmbd: validate ipc response length before dereferencing its fields

Yuqi Xu (1):
      openvswitch: Fix CT limit teardown use-after-free

Yuvraj Singh Chauhan (1):
      staging: octeon: fix free_irq dev_id mismatch in cvm_oct_rx_shutdown

Yuyang Huang (1):
      ipv6: use RCU iterator to dump route exceptions

Zhan Xusheng (6):
      ocfs2: fix readdir position truncation on 32-bit kernels
      udf: Fix i_lenExtents truncation on 32-bit kernels
      f2fs: use the mount idmap for the owner check in f2fs_xattr_advise_set()
      f2fs: fix i_size when pinned fallocate partially fails
      fs/ntfs3: fix integer overflow in MFT cluster validation
      fs/ntfs3: reject out-of-range evcn in mi_enum_attr()

Zhang Tianci (1):
      fuse: check attributes staleness on fuse_iget()

ZhangGuoDong (2):
      smb/server: fix invalid pointer dereference in ksmbd_stop_durable_scavenger()
      smb/server: preserve error status in smb2_handle_negotiate()

Zhao Li (2):
      wifi: mac80211: send TWT teardown to peer after setup TX failure
      wifi: mac80211: skip unused probe response countdown offsets

Zheng Qixing (1):
      blk-cgroup: skip dying blkg in blkcg_activate_policy()

Zhenghang Xiao (1):
      nfc: nci: fix double completion race in nci_data_exchange_complete

Zhenhao Wan (2):
      drm/nouveau/uvmm: fix premature region free on failed OP_UNMAP_SPARSE
      drm/nouveau/uvmm: clear the dirty flag when unwinding an OP_UNMAP_SPARSE

Zhi-Jun You (1):
      wifi: mt76: mt7915: fix net_fill_forward_path for non-DBDC mt7986

Zhihao Cheng (9):
      ubi: fastmap: Fix missed ec updating after erasing old fastmap data block
      ubi: fastmap: erase_block: Get erase counter from wl_entry rather than flash
      ubi: fastmap: Allocate memory with GFP_NOFS in ubi_update_fastmap
      ubi: Replace erase_block() with sync_erase()
      UBI: Preserve torture flag when rescheduling failed erasures
      UBI: fastmap: Pass to_be_tortured when reusing old fastmap PEBs
      ubi: fastmap: Wait until there are enough free PEBs before filling pools
      ubi: fastmap: Fix lapsed wear leveling for first 64 PEBs
      ubi: fastmap: Add module parameter to control reserving filling pool PEBs

Zhiling Zou (6):
      ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
      ip6_gre: fix hardware header length for NBMA tunnels
      orangefs: skip leading spaces before parsing client debug masks
      net: cap advertised IP tunnel headroom
      seg6: reset IP6CB after IPv6 decapsulation
      batman-adv: fix stale receive device on merged fragments

Zhongqiu Han (1):
      cpufreq: schedutil: Fix self-contradictory comment in sugov_iowait_apply()

Zhu Ling (1):
      ACPI: EC: Avoid _REG disconnect on GPIO IRQ defer

Zhu Yanjun (1):
      RDMA/cma: Fix WARNING in res_to_rt

Zhushuai Yin (1):
      crypto: hisilicon/sec2 - fix CCM algorithm long packet failure

Zi Yan (1):
      xarray: honor XA_FLAGS_ACCOUNT in xas_split_alloc()

Zide Chen (2):
      perf/x86/intel/uncore: Fix die ID init and look up bugs
      perf/x86/intel/uncore: Keep PCI PMUs working when MMIO/MSR setup fails

Zijun Hu (5):
      Bluetooth: btqca: Fix qca_set_bdaddr() waiting for wrong HCI event
      Bluetooth: btusb: Fix BD_ADDR byte order in btusb_set_bdaddr_wcn6855()
      Bluetooth: btusb: Record matched usb_device_id into btusb_data
      Bluetooth: btusb: QCA: Fix populating devcoredump fields on unenabled devices
      Bluetooth: btintel: Fix diagnostics event detection

Zizhi Wo (5):
      null_blk: use DEFINE_MUTEX for the file-scope mutex
      null_blk: register configfs subsystem after creating default devices
      null_blk: free global tag_set on init error path
      null_blk: reject per-device queue resize for shared tag set
      null_blk: serialize configfs attribute stores with the lock

bui duc phuc (3):
      ASoC: pxa: Use devm_clk_get_optional() for extclk clock
      net: ethernet: sun4i-emac: Fix IRQ error handling
      net: fec: only stop PTP if it was initialized

caina (1):
      Revert "irqchip/mbigen: Fix mbigen node address layout"

e.kubanski (1):
      xsk: Fix offset calculation in unaligned mode

liyouhong (1):
      dm-era: fix shadowed superblock leak on take-snap failure

longlong yan (1):
      clk/x86: pmc_atom: add kasprintf return value check

zhouminqiang (1):
      mtd: part: reject MTDPART_OFS_RETAIN in mtd_add_partition()

胡连勤 (1):
      block: set QUEUE_FLAG_DYING unconditionally in blk_mark_disk_dead()

谢致邦 (XIE Zhibang) (1):
      HID: i2c-hid: Refactor _DSM helper and add i2c-hid-acpi-prp0001 driver

