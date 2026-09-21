Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA36447F3A9;
	Mon, 21 Sep 2026 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997455; cv=none; b=P2qqBZwQoVcg1O9qjX+yE3fu09SbyKtjV18ReKxu7GacdQk0K64MYaCb2bkmkl50gNGlXUm7m2F8PLnbywvhO8k4c3m+My3cVrobvshzkTBy/b9rjX8UwQLY9NB80Dtud7+E7w5YgIIFSAE9ps6oigJjy+xJOicQ0nWTT7nYBLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997455; c=relaxed/simple;
	bh=u95kSu990bOT2cNn/sKY1QZJ8ZnaztEwF1burHe6WNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D9Z6qkhTFFx26po86pmuNrnQv/s9V40SrOV1H8D5EflT4lv1iTjj+vxczibeJSjHYRTB9tAiB2lWDaTbGXPBtCarLnEnrcowMITnXElOXumhR5ehNZGl24IQ7hFhnMt+Wflhu/XRW5l5vzdeRJ6FAYY/B9S1tLcqJn/0HBUjZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TADMzGNJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TADMzGNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F2B1F00893;
	Mon, 21 Sep 2026 13:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789997449;
	bh=ArjpI/eSHbU3oCae6afDXnpZ45Zlq3XWlRj0hC1xmWQ=;
	h=From:To:Cc:Subject:Date;
	b=TADMzGNJcp8xNXDV1qgulE9cJewr85Zc7nyvK2GCu9smGA9Nq2gIkl6qA4nGz5qIQ
	 irpasQMvUIo728zA4iX1IJ1iv0FzEXCdvLP2jqeD8kVq7McI4RXl3XWYUD9cXCiM78
	 dAGVMjEVkADdnDbdyOo80D1iJvQAgGCuLV42tDx4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.111
Date: Mon, 21 Sep 2026 15:30:33 +0200
Message-ID: <2026092133-distort-turbine-4e57@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.111 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/filesystems/nfs/reexport.rst                                |   10 
 Documentation/hwmon/hwmon-kernel-api.rst                                  |    3 
 Documentation/netlink/specs/rt_link.yaml                                  |    2 
 Documentation/networking/ethtool-netlink.rst                              |    2 
 Documentation/networking/scaling.rst                                      |   15 
 Documentation/scheduler/sched-ext.rst                                     |    2 
 Documentation/sound/designs/midi-2.0.rst                                  |   11 
 MAINTAINERS                                                               |    4 
 Makefile                                                                  |    2 
 arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts                              |   13 
 arch/arm/kernel/hw_breakpoint.c                                           |   11 
 arch/arm/mach-ux500/cpu-db8500.c                                          |    6 
 arch/arm/mm/cache-feroceon-l2.c                                           |    2 
 arch/arm/mm/cache-tauros2.c                                               |    2 
 arch/arm/mm/fault.c                                                       |   12 
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                                     |   16 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                                      |   64 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                      |    8 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                                      |   12 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                                      |    8 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                                      |    8 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                                      |    8 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                                      |    8 
 arch/arm64/include/asm/daifflags.h                                        |   10 
 arch/arm64/include/asm/fixmap.h                                           |    6 
 arch/arm64/include/asm/kprobes.h                                          |    6 
 arch/arm64/kernel/machine_kexec.c                                         |    3 
 arch/arm64/kernel/probes/kprobes.c                                        |   23 
 arch/mips/kernel/cps-vec.S                                                |    6 
 arch/powerpc/kernel/eeh_driver.c                                          |    2 
 arch/powerpc/kexec/file_load_64.c                                         |    2 
 arch/powerpc/kvm/book3s_hv.c                                              |    4 
 arch/powerpc/perf/core-book3s.c                                           |    8 
 arch/powerpc/platforms/ps3/repository.c                                   |    5 
 arch/powerpc/platforms/pseries/kexec.c                                    |   13 
 arch/powerpc/platforms/pseries/rtas-fadump.c                              |   80 
 arch/powerpc/platforms/pseries/rtas-fadump.h                              |    6 
 arch/riscv/kernel/irq.c                                                   |   22 
 arch/s390/boot/physmem_info.c                                             |    2 
 arch/s390/crypto/aes_s390.c                                               |   87 
 arch/s390/kernel/ipl.c                                                    |   12 
 arch/s390/kernel/perf_pai_crypto.c                                        |    3 
 arch/s390/kernel/perf_pai_ext.c                                           |    3 
 arch/s390/kernel/vtime.c                                                  |   25 
 arch/s390/net/bpf_jit_comp.c                                              |   11 
 arch/sparc/Kconfig                                                        |    1 
 arch/sparc/kernel/uprobes.c                                               |    1 
 arch/x86/crypto/aria-aesni-avx2-asm_64.S                                  |    6 
 arch/x86/crypto/aria-gfni-avx512-asm_64.S                                 |    3 
 arch/x86/events/amd/brs.c                                                 |    3 
 arch/x86/events/amd/ibs.c                                                 |    3 
 arch/x86/events/amd/lbr.c                                                 |    3 
 arch/x86/events/core.c                                                    |    5 
 arch/x86/events/intel/core.c                                              |    4 
 arch/x86/events/intel/ds.c                                                |  210 -
 arch/x86/events/intel/lbr.c                                               |    3 
 arch/x86/events/perf_event.h                                              |   14 
 arch/x86/include/asm/alternative.h                                        |    2 
 arch/x86/include/asm/barrier.h                                            |   10 
 arch/x86/include/asm/cmpxchg.h                                            |    4 
 arch/x86/include/asm/cmpxchg_32.h                                         |    4 
 arch/x86/include/asm/edac.h                                               |    2 
 arch/x86/include/asm/perf_event.h                                         |   16 
 arch/x86/include/asm/pgtable.h                                            |    2 
 arch/x86/include/asm/sync_bitops.h                                        |   12 
 arch/x86/kvm/svm/sev.c                                                    |  239 -
 arch/x86/kvm/svm/svm.c                                                    |   33 
 arch/x86/kvm/svm/svm.h                                                    |   23 
 block/blk-cgroup.c                                                        |   13 
 crypto/Makefile                                                           |    5 
 drivers/accel/ivpu/ivpu_fw_log.c                                          |   87 
 drivers/accel/ivpu/ivpu_gem.h                                             |   14 
 drivers/accel/ivpu/ivpu_ipc.c                                             |    7 
 drivers/accel/qaic/qaic_control.c                                         |   46 
 drivers/acpi/acpi_apd.c                                                   |    7 
 drivers/acpi/acpi_tad.c                                                   |  180 -
 drivers/acpi/acpica/dsmethod.c                                            |   43 
 drivers/acpi/acpica/evhandler.c                                           |   11 
 drivers/acpi/acpica/exconfig.c                                            |   26 
 drivers/acpi/acpica/exoparg3.c                                            |    2 
 drivers/acpi/acpica/nsnames.c                                             |    6 
 drivers/acpi/acpica/nsprepkg.c                                            |    7 
 drivers/acpi/acpica/nsxfname.c                                            |    4 
 drivers/acpi/acpica/psargs.c                                              |  134 
 drivers/acpi/acpica/psloop.c                                              |   30 
 drivers/acpi/acpica/psparse.c                                             |   14 
 drivers/acpi/acpica/utcopy.c                                              |   10 
 drivers/acpi/acpica/utresrc.c                                             |   30 
 drivers/acpi/apei/ghes.c                                                  |   24 
 drivers/acpi/pci_root.c                                                   |    4 
 drivers/acpi/scan.c                                                       |    1 
 drivers/ata/ahci.c                                                        |   22 
 drivers/ata/libata-core.c                                                 |   10 
 drivers/ata/libata-pmp.c                                                  |    7 
 drivers/base/core.c                                                       |   91 
 drivers/block/sunvdc.c                                                    |   17 
 drivers/block/zram/zram_drv.c                                             |   62 
 drivers/block/zram/zram_drv.h                                             |    5 
 drivers/bluetooth/btintel.c                                               |   39 
 drivers/bluetooth/btintel_pcie.c                                          |   22 
 drivers/bluetooth/btmtk.c                                                 |   11 
 drivers/bluetooth/btmtk.h                                                 |    1 
 drivers/bluetooth/btqcomsmd.c                                             |    6 
 drivers/bluetooth/btrtl.c                                                 |   21 
 drivers/bluetooth/btusb.c                                                 |   47 
 drivers/bluetooth/hci_mrvl.c                                              |    3 
 drivers/bus/fsl-mc/fsl-mc-bus.c                                           |   46 
 drivers/char/ipmi/ipmi_si_platform.c                                      |    5 
 drivers/char/nvram.c                                                      |   16 
 drivers/char/virtio_console.c                                             |   21 
 drivers/clk/keystone/sci-clk.c                                            |    8 
 drivers/clk/renesas/renesas-cpg-mssr.c                                    |    3 
 drivers/clk/samsung/clk-exynos850.c                                       |    5 
 drivers/clk/socfpga/clk-agilex.c                                          |    2 
 drivers/clk/ux500/clk-prcmu.c                                             |   20 
 drivers/clk/ux500/u8500_of_clk.c                                          |    2 
 drivers/clocksource/timer-orion.c                                         |    2 
 drivers/cpufreq/apple-soc-cpufreq.c                                       |   36 
 drivers/cpufreq/cpufreq.c                                                 |    6 
 drivers/cpuidle/cpuidle-ux500.c                                           |    6 
 drivers/crypto/atmel-ecc.c                                                |   11 
 drivers/crypto/atmel-sha204a.c                                            |    3 
 drivers/crypto/ccp/sev-dev.c                                              |    2 
 drivers/crypto/intel/iaa/iaa_crypto_main.c                                |   36 
 drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c                               |   25 
 drivers/crypto/omap-des.c                                                 |   26 
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c                       |   81 
 drivers/crypto/virtio/virtio_crypto_skcipher_algs.c                       |   13 
 drivers/cxl/core/Makefile                                                 |    2 
 drivers/cxl/core/core.h                                                   |   12 
 drivers/cxl/core/pci.c                                                    |  318 --
 drivers/cxl/core/ras.c                                                    |  186 +
 drivers/cxl/core/ras_rch.c                                                |  136 
 drivers/cxl/pci.c                                                         |    1 
 drivers/dma/altera-msgdma.c                                               |   24 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                            |   11 
 drivers/edac/amd64_edac.c                                                 |    2 
 drivers/edac/edac_device_sysfs.c                                          |   11 
 drivers/edac/igen6_edac.c                                                 |   27 
 drivers/firmware/arm_scmi/base.c                                          |   15 
 drivers/firmware/arm_scmi/sensors.c                                       |   10 
 drivers/firmware/efi/cper.c                                               |    5 
 drivers/firmware/efi/cper_cxl.c                                           |   38 
 drivers/firmware/efi/cper_cxl.h                                           |   54 
 drivers/firmware/stratix10-svc.c                                          |    4 
 drivers/gpio/gpio-dwapb.c                                                 |   17 
 drivers/gpio/gpio-pisosr.c                                                |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                                |   23 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                   |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c                            |   95 
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c                                   |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                                   |   34 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h                                   |    2 
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c                                    |    8 
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c                                    |    8 
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c                                    |   14 
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c                                  |   14 
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c                                    |   14 
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c                                     |    8 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                  |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c                                    |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                     |   17 
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c                                 |    8 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c                           |   11 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                    |   12 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                         |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c                     |    7 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c                 |   20 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                  |   21 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c                   |    6 
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c                    |    8 
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c                 |   12 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                                |   31 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                          |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c                      |    4 
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c                           |    6 
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c                           |   14 
 drivers/gpu/drm/arm/malidp_drv.c                                          |   22 
 drivers/gpu/drm/bridge/tc358768.c                                         |    2 
 drivers/gpu/drm/display/drm_dp_helper.c                                   |    2 
 drivers/gpu/drm/drm_exec.c                                                |   13 
 drivers/gpu/drm/drm_gem.c                                                 |   10 
 drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c                                |   21 
 drivers/gpu/drm/gud/gud_drv.c                                             |    1 
 drivers/gpu/drm/i915/i915_query.c                                         |    4 
 drivers/gpu/drm/imagination/pvr_context.c                                 |   30 
 drivers/gpu/drm/logicvc/Kconfig                                           |    1 
 drivers/gpu/drm/mediatek/mtk_dsi.c                                        |    1 
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c                      |  110 
 drivers/gpu/drm/panel/Kconfig                                             |   11 
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c                          |    2 
 drivers/gpu/drm/panel/panel-simple.c                                      |   28 
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c                              |   16 
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h                              |    2 
 drivers/gpu/drm/tiny/cirrus.c                                             |    7 
 drivers/gpu/drm/vc4/vc4_hvs.c                                             |    2 
 drivers/gpu/drm/vc4/vc4_v3d.c                                             |    2 
 drivers/gpu/drm/virtio/virtgpu_display.c                                  |    2 
 drivers/gpu/drm/xe/xe_oa.c                                                |    6 
 drivers/gpu/host1x/bus.c                                                  |    4 
 drivers/hid/bpf/progs/Huion__Inspiroy-Frego-M.bpf.c                       |   87 
 drivers/hid/hid-apple.c                                                   |   18 
 drivers/hid/hid-logitech-hidpp.c                                          |    1 
 drivers/hid/hid-mcp2221.c                                                 |   15 
 drivers/hid/hid-multitouch.c                                              |  147 
 drivers/hid/hid-sony.c                                                    |   82 
 drivers/hid/hid-universal-pidff.c                                         |    4 
 drivers/hv/connection.c                                                   |   47 
 drivers/hv/hyperv_vmbus.h                                                 |    2 
 drivers/hwmon/adt7462.c                                                   |    8 
 drivers/hwmon/applesmc.c                                                  |    7 
 drivers/hwmon/aspeed-pwm-tacho.c                                          |    4 
 drivers/hwmon/chipcap2.c                                                  |    9 
 drivers/hwmon/corsair-cpro.c                                              |   24 
 drivers/hwmon/corsair-psu.c                                               |   23 
 drivers/hwmon/dell-smm-hwmon.c                                            |    8 
 drivers/hwmon/gpio-fan.c                                                  |   13 
 drivers/hwmon/hwmon.c                                                     |   14 
 drivers/hwmon/ina2xx.c                                                    |   14 
 drivers/hwmon/ltc4282.c                                                   |    2 
 drivers/hwmon/pmbus/lm25066.c                                             |   54 
 drivers/hwmon/pmbus/pmbus_core.c                                          |    4 
 drivers/hwmon/raspberrypi-hwmon.c                                         |   12 
 drivers/hwtracing/coresight/coresight-platform.c                          |   12 
 drivers/i2c/i2c-core-smbus.c                                              |   12 
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c                                  |    4 
 drivers/i3c/master/mipi-i3c-hci/cmd_v2.c                                  |    4 
 drivers/iio/accel/mma8452.c                                               |   19 
 drivers/iio/adc/qcom-spmi-iadc.c                                          |   18 
 drivers/iio/adc/rtq6056.c                                                 |   10 
 drivers/iio/light/stk3310.c                                               |   76 
 drivers/infiniband/core/umem.c                                            |   18 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                                 |   11 
 drivers/infiniband/hw/irdma/utils.c                                       |    2 
 drivers/infiniband/hw/mlx5/cq.c                                           |    3 
 drivers/infiniband/hw/mlx5/main.c                                         |   11 
 drivers/infiniband/hw/mlx5/mr.c                                           |    4 
 drivers/infiniband/hw/mlx5/odp.c                                          |    3 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                                    |   12 
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c                            |   21 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                                |    9 
 drivers/iommu/rockchip-iommu.c                                            |    8 
 drivers/irqchip/irq-gic-v3-its.c                                          |    1 
 drivers/leds/leds-pca9532.c                                               |    8 
 drivers/leds/trigger/ledtrig-gpio.c                                       |    3 
 drivers/leds/uleds.c                                                      |   11 
 drivers/mailbox/imx-mailbox.c                                             |   64 
 drivers/mailbox/mailbox.c                                                 |    6 
 drivers/md/raid10.c                                                       |    5 
 drivers/md/raid5.c                                                        |   35 
 drivers/media/i2c/video-i2c.c                                             |    2 
 drivers/media/pci/dm1105/dm1105.c                                         |    7 
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c                  |   47 
 drivers/media/platform/chips-media/wave5/wave5-vpuapi.c                   |   11 
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c |    5 
 drivers/media/platform/qcom/camss/camss-csiphy.c                          |   10 
 drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c                   |    6 
 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c           |   57 
 drivers/media/rc/imon.c                                                   |    4 
 drivers/media/rc/mceusb.c                                                 |    2 
 drivers/media/usb/as102/as102_usb_drv.c                                   |   73 
 drivers/media/usb/em28xx/em28xx-video.c                                   |    4 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                                 |   32 
 drivers/media/v4l2-core/v4l2-h264.c                                       |    3 
 drivers/mfd/ab8500-core.c                                                 |    2 
 drivers/mfd/db8500-prcmu.c                                                |    6 
 drivers/mfd/rsmu_i2c.c                                                    |    2 
 drivers/mfd/rsmu_spi.c                                                    |    2 
 drivers/mfd/tps65219.c                                                    |   14 
 drivers/mmc/core/queue.c                                                  |    8 
 drivers/mmc/host/davinci_mmc.c                                            |   16 
 drivers/mmc/host/renesas_sdhi_internal_dmac.c                             |    2 
 drivers/net/bonding/bond_alb.c                                            |   32 
 drivers/net/bonding/bond_main.c                                           |    4 
 drivers/net/dsa/bcm_sf2_cfp.c                                             |    2 
 drivers/net/dsa/lantiq_gswip.c                                            |  367 --
 drivers/net/dsa/lantiq_gswip.h                                            |  252 +
 drivers/net/dsa/mv88e6xxx/chip.c                                          |   23 
 drivers/net/dsa/qca/qca8k-8xxx.c                                          |   22 
 drivers/net/dsa/qca/qca8k.h                                               |    1 
 drivers/net/dsa/realtek/rtl8365mb.c                                       |   14 
 drivers/net/dsa/sja1105/sja1105_flower.c                                  |    4 
 drivers/net/ethernet/allwinner/sun4i-emac.c                               |    2 
 drivers/net/ethernet/amd/au1000_eth.c                                     |    3 
 drivers/net/ethernet/amd/pds_core/core.c                                  |    4 
 drivers/net/ethernet/amd/pds_core/fw.c                                    |   10 
 drivers/net/ethernet/amd/pds_core/main.c                                  |   10 
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c                                  |    3 
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c                          |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                 |   19 
 drivers/net/ethernet/cadence/macb.h                                       |    2 
 drivers/net/ethernet/cadence/macb_main.c                                  |   39 
 drivers/net/ethernet/cavium/thunder/nicvf_main.c                          |    8 
 drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c                             |    4 
 drivers/net/ethernet/cortina/gemini.c                                     |   77 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c                       |   69 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                   |   12 
 drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c                         |    4 
 drivers/net/ethernet/ibm/emac/core.c                                      |    3 
 drivers/net/ethernet/ibm/emac/mal.c                                       |    6 
 drivers/net/ethernet/intel/e1000e/ethtool.c                               |   19 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c                            |    2 
 drivers/net/ethernet/intel/ice/ice_common.c                               |    9 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                              |    2 
 drivers/net/ethernet/intel/ice/ice_sched.c                                |    4 
 drivers/net/ethernet/intel/ice/ice_trace.h                                |   64 
 drivers/net/ethernet/intel/ice/ice_txrx.c                                 |   20 
 drivers/net/ethernet/intel/ice/ice_type.h                                 |    2 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                               |   10 
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c                           |   10 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                           |   33 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c                   |   10 
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c                          |   60 
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig                           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c                         |   15 
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c                          |   27 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c                    |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c                        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c                      |    1 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                         |    8 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads_termtbl.c        |    7 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                            |    3 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_table.c      |    3 
 drivers/net/ethernet/micrel/ks8842.c                                      |    4 
 drivers/net/ethernet/micrel/ks8851_common.c                               |   10 
 drivers/net/ethernet/micrel/ks8851_spi.c                                  |    4 
 drivers/net/ethernet/micrel/ksz884x.c                                     |    4 
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c                     |   20 
 drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c                       |    5 
 drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c                  |   18 
 drivers/net/ethernet/microsoft/mana/mana_en.c                             |   12 
 drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c                      |   36 
 drivers/net/ethernet/oa_tc6.c                                             |  512 ++-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c                          |   13 
 drivers/net/ethernet/realtek/rtase/rtase.h                                |    4 
 drivers/net/ethernet/realtek/rtase/rtase_main.c                           |    3 
 drivers/net/ethernet/sfc/ethtool.c                                        |    1 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h                            |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                         |  165 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c                          |    1 
 drivers/net/ethernet/ti/cpsw_new.c                                        |    4 
 drivers/net/gtp.c                                                         |    5 
 drivers/net/ieee802154/cc2520.c                                           |    5 
 drivers/net/ieee802154/mac802154_hwsim.c                                  |   10 
 drivers/net/mctp/mctp-i3c.c                                               |    9 
 drivers/net/netconsole.c                                                  |    2 
 drivers/net/phy/Kconfig                                                   |   17 
 drivers/net/phy/Makefile                                                  |    3 
 drivers/net/phy/mediatek-ge-soc.c                                         | 1555 ----------
 drivers/net/phy/mediatek-ge.c                                             |  111 
 drivers/net/phy/mediatek/Kconfig                                          |   22 
 drivers/net/phy/mediatek/Makefile                                         |    3 
 drivers/net/phy/mediatek/mtk-ge-soc.c                                     | 1555 ++++++++++
 drivers/net/phy/mediatek/mtk-ge.c                                         |  140 
 drivers/net/phy/motorcomm.c                                               |   41 
 drivers/net/phy/phy_device.c                                              |   16 
 drivers/net/phy/sfp.c                                                     |    2 
 drivers/net/ppp/ppp_async.c                                               |   89 
 drivers/net/ppp/ppp_synctty.c                                             |   97 
 drivers/net/usb/cx82310_eth.c                                             |    1 
 drivers/net/usb/hso.c                                                     |    2 
 drivers/net/usb/pegasus.c                                                 |   54 
 drivers/net/usb/pegasus.h                                                 |    3 
 drivers/net/usb/qmi_wwan.c                                                |    2 
 drivers/net/vxlan/vxlan_core.c                                            |   13 
 drivers/net/vxlan/vxlan_mdb.c                                             |    8 
 drivers/net/vxlan/vxlan_vnifilter.c                                       |   13 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                   |   50 
 drivers/net/wireless/ath/ath9k/hif_usb.c                                  |   12 
 drivers/net/wireless/ath/ath9k/hif_usb.h                                  |    2 
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c                            |    4 
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c                              |    5 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                              |   13 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                               |   19 
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c                         |   25 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                         |    7 
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h                              |    3 
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c                               |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                             |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c                       |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                               |   45 
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c                              |    9 
 drivers/net/wireless/marvell/libertas/tx.c                                |    7 
 drivers/net/wireless/marvell/mwifiex/fw.h                                 |   18 
 drivers/net/wireless/marvell/mwifiex/join.c                               |    8 
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c                            |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                           |   33 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                           |    9 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                           |    5 
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c                           |    3 
 drivers/net/wireless/mediatek/mt76/pci.c                                  |    8 
 drivers/net/wireless/ralink/rt2x00/rt2400pci.c                            |    2 
 drivers/net/wireless/ralink/rt2x00/rt2500pci.c                            |    2 
 drivers/net/wireless/ralink/rt2x00/rt2800pci.c                            |    2 
 drivers/net/wireless/ralink/rt2x00/rt61pci.c                              |    2 
 drivers/net/wireless/realtek/rtw88/fw.c                                   |    3 
 drivers/net/wireless/realtek/rtw89/core.c                                 |    4 
 drivers/net/wireless/realtek/rtw89/mac_be.c                               |    4 
 drivers/net/wireless/realtek/rtw89/pci.c                                  |   16 
 drivers/net/wireless/rsi/rsi_91x_hal.c                                    |    8 
 drivers/net/wireless/rsi/rsi_91x_mgmt.c                                   |    6 
 drivers/net/wireless/virtual/mac80211_hwsim.c                             |    6 
 drivers/net/wwan/t7xx/t7xx_pci.c                                          |    3 
 drivers/nvdimm/claim.c                                                    |    9 
 drivers/nvme/host/apple.c                                                 |  182 -
 drivers/nvme/host/core.c                                                  |   34 
 drivers/nvme/host/fc.c                                                    |    7 
 drivers/nvme/host/rdma.c                                                  |   18 
 drivers/nvme/host/tcp.c                                                   |   17 
 drivers/nvme/target/rdma.c                                                |   15 
 drivers/of/dynamic.c                                                      |   20 
 drivers/of/overlay.c                                                      |   15 
 drivers/opp/of.c                                                          |    2 
 drivers/pci/controller/dwc/pcie-intel-gw.c                                |   19 
 drivers/pci/controller/pcie-altera.c                                      |    2 
 drivers/pci/controller/pcie-iproc.c                                       |    2 
 drivers/pci/controller/pcie-mediatek.c                                    |    2 
 drivers/pci/controller/pcie-rockchip-host.c                               |    2 
 drivers/pci/controller/plda/pcie-plda-host.c                              |    2 
 drivers/pci/pci-driver.c                                                  |   10 
 drivers/pci/pci-sysfs.c                                                   |   14 
 drivers/pci/pci.c                                                         |   24 
 drivers/pci/proc.c                                                        |   79 
 drivers/pci/quirks.c                                                      |    5 
 drivers/pci/switch/switchtec.c                                            |   16 
 drivers/perf/riscv_pmu_legacy.c                                           |    5 
 drivers/perf/riscv_pmu_sbi.c                                              |   98 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                                   |    3 
 drivers/pinctrl/renesas/pinctrl-rzv2m.c                                   |    4 
 drivers/platform/chrome/cros_ec_sensorhub.c                               |    6 
 drivers/platform/chrome/cros_ec_sysfs.c                                   |    5 
 drivers/platform/x86/dell/dell-laptop.c                                   |    9 
 drivers/platform/x86/intel/hid.c                                          |    7 
 drivers/platform/x86/msi-ec.c                                             |    1 
 drivers/platform/x86/sel3350-platform.c                                   |  136 
 drivers/powercap/intel_rapl_common.c                                      |    3 
 drivers/ptp/ptp_ocp.c                                                     |    1 
 drivers/ras/amd/atl/core.c                                                |    1 
 drivers/regulator/core.c                                                  |  163 -
 drivers/regulator/da9121-regulator.c                                      |   18 
 drivers/regulator/db8500-prcmu.c                                          |   12 
 drivers/rtc/rtc-aspeed.c                                                  |    1 
 drivers/rtc/rtc-bq32k.c                                                   |    9 
 drivers/rtc/rtc-mv.c                                                      |   23 
 drivers/s390/char/zcore.c                                                 |    8 
 drivers/s390/cio/device.c                                                 |    2 
 drivers/s390/net/ism_drv.c                                                |    4 
 drivers/s390/net/qeth_l2.h                                                |    3 
 drivers/s390/net/qeth_l2_main.c                                           |   26 
 drivers/s390/net/qeth_l2_sys.c                                            |    7 
 drivers/scsi/bfa/bfa_fcs_lport.c                                          |    2 
 drivers/scsi/mpi3mr/mpi3mr_transport.c                                    |    8 
 drivers/scsi/mpt3sas/mpt3sas_base.c                                       |    5 
 drivers/scsi/pm8001/pm8001_ctl.c                                          |    8 
 drivers/scsi/pm8001/pm80xx_hwi.c                                          |    7 
 drivers/scsi/scsi_error.c                                                 |    2 
 drivers/soc/tegra/fuse/fuse-tegra.c                                       |   14 
 drivers/soc/ti/pm33xx.c                                                   |    2 
 drivers/soundwire/bus.c                                                   |    4 
 drivers/soundwire/dmi-quirks.c                                            |   35 
 drivers/soundwire/intel.c                                                 |   31 
 drivers/soundwire/intel_ace2x.c                                           |   39 
 drivers/soundwire/intel_auxdevice.c                                       |    2 
 drivers/soundwire/slave.c                                                 |    4 
 drivers/spi/spi-dw-dma.c                                                  |    3 
 drivers/spi/spi-dw-mmio.c                                                 |    7 
 drivers/spi/spi-dw.h                                                      |    1 
 drivers/spi/spi-qcom-qspi.c                                               |   44 
 drivers/spi/spi-xilinx.c                                                  |    6 
 drivers/spi/spi.c                                                         |    9 
 drivers/staging/fbtft/fbtft-core.c                                        |    9 
 drivers/target/iscsi/iscsi_target.c                                       |    4 
 drivers/tee/optee/call.c                                                  |    3 
 drivers/thermal/db8500_thermal.c                                          |   10 
 drivers/thermal/qcom/tsens.c                                              |  111 
 drivers/thermal/qcom/tsens.h                                              |    1 
 drivers/thermal/tegra/soctherm.c                                          |    6 
 drivers/thermal/thermal_sysfs.c                                           |   12 
 drivers/thunderbolt/icm.c                                                 |   10 
 drivers/thunderbolt/path.c                                                |   31 
 drivers/thunderbolt/switch.c                                              |    6 
 drivers/thunderbolt/tb.c                                                  |    9 
 drivers/thunderbolt/tb_regs.h                                             |    1 
 drivers/thunderbolt/usb4.c                                                |   11 
 drivers/thunderbolt/xdomain.c                                             |   49 
 drivers/tty/serial/8250/8250_port.c                                       |    7 
 drivers/usb/atm/xusbatm.c                                                 |    6 
 drivers/usb/class/cdc-acm.c                                               |    6 
 drivers/usb/class/usbtmc.c                                                |    2 
 drivers/usb/core/hcd.c                                                    |   14 
 drivers/usb/gadget/function/f_fs.c                                        |   31 
 drivers/usb/gadget/udc/aspeed_udc.c                                       |    7 
 drivers/usb/gadget/udc/core.c                                             |    7 
 drivers/usb/gadget/udc/goku_udc.c                                         |    3 
 drivers/usb/host/Kconfig                                                  |    2 
 drivers/usb/host/xhci-debugfs.c                                           |   10 
 drivers/usb/host/xhci-hub.c                                               |    2 
 drivers/usb/host/xhci-mem.c                                               |   34 
 drivers/usb/host/xhci-pci.c                                               |    9 
 drivers/usb/host/xhci-ring.c                                              |   13 
 drivers/usb/host/xhci.c                                                   |   31 
 drivers/usb/host/xhci.h                                                   |   39 
 drivers/usb/serial/spcp8x5.c                                              |    6 
 drivers/usb/usbip/vhci_sysfs.c                                            |   52 
 drivers/vdpa/ifcvf/ifcvf_main.c                                           |   14 
 drivers/vdpa/octeon_ep/octep_vdpa_main.c                                  |    6 
 drivers/vdpa/solidrun/snet_main.c                                         |    6 
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c                                      |    3 
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c                                      |    7 
 drivers/vhost/scsi.c                                                      |    3 
 drivers/vhost/vdpa.c                                                      |   88 
 drivers/video/fbdev/core/fbcon.c                                          |    9 
 drivers/video/fbdev/pm2fb.c                                               |    1 
 drivers/video/fbdev/vfb.c                                                 |   11 
 drivers/virtio/virtio.c                                                   |    2 
 drivers/virtio/virtio_input.c                                             |    9 
 drivers/virtio/virtio_pci_common.c                                        |    4 
 drivers/watchdog/db8500_wdt.c                                             |   22 
 drivers/watchdog/imx7ulp_wdt.c                                            |   10 
 drivers/watchdog/lenovo_se10_wdt.c                                        |   82 
 drivers/watchdog/msc313e_wdt.c                                            |   74 
 drivers/watchdog/sunxi_wdt.c                                              |   45 
 drivers/watchdog/watchdog_hrtimer_pretimeout.c                            |    1 
 drivers/xen/balloon.c                                                     |   56 
 drivers/xen/gntalloc.c                                                    |   13 
 drivers/xen/xen-front-pgdir-shbuf.c                                       |   12 
 fs/9p/vfs_dir.c                                                           |   14 
 fs/affs/affs.h                                                            |    5 
 fs/affs/super.c                                                           |    6 
 fs/afs/addr_list.c                                                        |    5 
 fs/afs/fs_probe.c                                                         |    1 
 fs/afs/server.c                                                           |    1 
 fs/autofs/inode.c                                                         |    4 
 fs/befs/linuxvfs.c                                                        |    3 
 fs/bfs/inode.c                                                            |    3 
 fs/btrfs/accessors.h                                                      |    1 
 fs/btrfs/acl.h                                                            |    2 
 fs/btrfs/compression.c                                                    |   16 
 fs/btrfs/ctree.h                                                          |   11 
 fs/btrfs/defrag.c                                                         |   32 
 fs/btrfs/delayed-ref.h                                                    |    2 
 fs/btrfs/dir-item.h                                                       |    1 
 fs/btrfs/direct-io.c                                                      |   41 
 fs/btrfs/direct-io.h                                                      |    2 
 fs/btrfs/discard.h                                                        |    1 
 fs/btrfs/disk-io.c                                                        |   11 
 fs/btrfs/extent-io-tree.h                                                 |    6 
 fs/btrfs/extent-tree.h                                                    |    1 
 fs/btrfs/extent_io.c                                                      |   53 
 fs/btrfs/extent_map.c                                                     |   94 
 fs/btrfs/extent_map.h                                                     |    8 
 fs/btrfs/fiemap.c                                                         |    4 
 fs/btrfs/file-item.h                                                      |    2 
 fs/btrfs/file.c                                                           |  136 
 fs/btrfs/file.h                                                           |    2 
 fs/btrfs/free-space-cache.c                                               |   10 
 fs/btrfs/fs.c                                                             |   10 
 fs/btrfs/fs.h                                                             |   10 
 fs/btrfs/inode.c                                                          |  181 -
 fs/btrfs/ioctl.c                                                          |  171 -
 fs/btrfs/ioctl.h                                                          |    5 
 fs/btrfs/locking.c                                                        |    1 
 fs/btrfs/ordered-data.c                                                   |    8 
 fs/btrfs/ordered-data.h                                                   |    1 
 fs/btrfs/print-tree.h                                                     |    2 
 fs/btrfs/props.h                                                          |    1 
 fs/btrfs/qgroup.h                                                         |    3 
 fs/btrfs/raid-stripe-tree.c                                               |   25 
 fs/btrfs/raid-stripe-tree.h                                               |    2 
 fs/btrfs/reflink.c                                                        |    8 
 fs/btrfs/relocation.c                                                     |   71 
 fs/btrfs/send.c                                                           |    3 
 fs/btrfs/space-info.c                                                     |    2 
 fs/btrfs/subpage.c                                                        |    1 
 fs/btrfs/super.c                                                          |    2 
 fs/btrfs/sysfs.h                                                          |    1 
 fs/btrfs/tests/extent-io-tests.c                                          |    6 
 fs/btrfs/tests/extent-map-tests.c                                         |   56 
 fs/btrfs/tests/inode-tests.c                                              |   67 
 fs/btrfs/transaction.c                                                    |   13 
 fs/btrfs/tree-checker.c                                                   |   41 
 fs/btrfs/tree-log.c                                                       |   12 
 fs/btrfs/verity.c                                                         |    4 
 fs/btrfs/volumes.c                                                        |   10 
 fs/btrfs/volumes.h                                                        |    4 
 fs/btrfs/xattr.h                                                          |    2 
 fs/btrfs/zoned.c                                                          |   15 
 fs/cachefiles/namei.c                                                     |    1 
 fs/ceph/caps.c                                                            |   69 
 fs/ceph/crypto.c                                                          |   46 
 fs/ceph/mds_client.c                                                      |  194 +
 fs/ceph/mds_client.h                                                      |    2 
 fs/ceph/super.h                                                           |    5 
 fs/configfs/dir.c                                                         |   12 
 fs/dlm/memory.c                                                           |    4 
 fs/erofs/decompressor_lzma.c                                              |   18 
 fs/erofs/zutil.c                                                          |    2 
 fs/exec.c                                                                 |   22 
 fs/exfat/nls.c                                                            |   19 
 fs/f2fs/inline.c                                                          |    7 
 fs/freevxfs/vxfs_bmap.c                                                   |    3 
 fs/fuse/dev.c                                                             |   27 
 fs/fuse/file.c                                                            |    3 
 fs/fuse/virtio_fs.c                                                       |    2 
 fs/gfs2/bmap.c                                                            |   19 
 fs/gfs2/bmap.h                                                            |    1 
 fs/gfs2/file.c                                                            |   10 
 fs/gfs2/quota.c                                                           |   36 
 fs/hfs/catalog.c                                                          |    9 
 fs/hfs/dir.c                                                              |   28 
 fs/hfs/hfs.h                                                              |    3 
 fs/hfs/hfs_fs.h                                                           |    2 
 fs/hfs/inode.c                                                            |    4 
 fs/hfsplus/catalog.c                                                      |   11 
 fs/hfsplus/dir.c                                                          |   28 
 fs/hfsplus/hfsplus_fs.h                                                   |    5 
 fs/hfsplus/inode.c                                                        |   40 
 fs/hfsplus/super.c                                                        |    2 
 fs/hpfs/super.c                                                           |    3 
 fs/iomap/direct-io.c                                                      |    2 
 fs/isofs/inode.c                                                          |    3 
 fs/jfs/super.c                                                            |    3 
 fs/minix/inode.c                                                          |    3 
 fs/netfs/buffered_read.c                                                  |    2 
 fs/netfs/buffered_write.c                                                 |    2 
 fs/netfs/internal.h                                                       |   12 
 fs/nfs/blocklayout/rpc_pipefs.c                                           |   41 
 fs/nfs/export.c                                                           |    3 
 fs/nfs/nfs42proc.c                                                        |   15 
 fs/nfs/nfs4idmap.c                                                        |    8 
 fs/nfsd/filecache.c                                                       |   34 
 fs/nfsd/netns.h                                                           |   14 
 fs/nfsd/nfs4callback.c                                                    |   78 
 fs/nfsd/nfs4proc.c                                                        |   32 
 fs/nfsd/nfs4recover.c                                                     |   76 
 fs/nfsd/nfs4state.c                                                       |  257 +
 fs/nfsd/nfsctl.c                                                          |  199 -
 fs/nfsd/nfsd.h                                                            |   15 
 fs/nfsd/state.h                                                           |    5 
 fs/nfsd/trace.h                                                           |   14 
 fs/nfsd/xdr4.h                                                            |    1 
 fs/ntfs3/dir.c                                                            |    4 
 fs/ntfs3/fslog.c                                                          |   26 
 fs/ntfs3/index.c                                                          |   41 
 fs/ntfs3/super.c                                                          |    8 
 fs/ntfs3/xattr.c                                                          |    4 
 fs/ocfs2/dir.c                                                            |   71 
 fs/omfs/inode.c                                                           |    6 
 fs/qnx4/inode.c                                                           |    3 
 fs/smb/client/cifsacl.c                                                   |   30 
 fs/smb/client/cifspdu.h                                                   |    8 
 fs/smb/client/connect.c                                                   |   27 
 fs/smb/client/file.c                                                      |    5 
 fs/smb/client/link.c                                                      |    2 
 fs/smb/client/misc.c                                                      |   24 
 fs/smb/client/readdir.c                                                   |    9 
 fs/smb/client/reparse.c                                                   |    5 
 fs/smb/client/smb1ops.c                                                   |    2 
 fs/smb/client/smb2ops.c                                                   |  453 ++
 fs/smb/client/smb2pdu.h                                                   |   20 
 fs/smb/client/trace.h                                                     |    2 
 fs/smb/client/transport.c                                                 |   11 
 fs/smb/common/smb2pdu.h                                                   |   29 
 fs/smb/server/mgmt/share_config.c                                         |   38 
 fs/smb/server/mgmt/user_session.c                                         |   25 
 fs/smb/server/misc.c                                                      |   14 
 fs/smb/server/oplock.c                                                    |  221 +
 fs/smb/server/oplock.h                                                    |    2 
 fs/smb/server/server.c                                                    |    6 
 fs/smb/server/smb2misc.c                                                  |    9 
 fs/smb/server/smb2pdu.c                                                   |  277 -
 fs/smb/server/smb2pdu.h                                                   |   20 
 fs/smb/server/smbacl.c                                                    |   88 
 fs/smb/server/transport_ipc.c                                             |   21 
 fs/smb/server/vfs.c                                                       |   46 
 fs/smb/server/vfs_cache.c                                                 |   28 
 fs/smb/server/vfs_cache.h                                                 |    8 
 fs/super.c                                                                |    9 
 fs/ufs/cylinder.c                                                         |   10 
 fs/ufs/dir.c                                                              |    2 
 fs/ufs/super.c                                                            |   17 
 fs/xfs/libxfs/xfs_btree_mem.c                                             |    2 
 fs/xfs/libxfs/xfs_btree_staging.c                                         |    4 
 fs/xfs/libxfs/xfs_defer.c                                                 |    2 
 fs/xfs/libxfs/xfs_exchmaps.c                                              |   10 
 fs/xfs/libxfs/xfs_parent.c                                                |   13 
 fs/xfs/scrub/agheader_repair.c                                            |   39 
 fs/xfs/scrub/alloc_repair.c                                               |   18 
 fs/xfs/scrub/dir_repair.c                                                 |   10 
 fs/xfs/scrub/dirtree.c                                                    |   31 
 fs/xfs/scrub/dirtree_repair.c                                             |    2 
 fs/xfs/scrub/findparent.c                                                 |   54 
 fs/xfs/scrub/ialloc.c                                                     |    4 
 fs/xfs/scrub/quota_repair.c                                               |   14 
 fs/xfs/scrub/quotacheck.c                                                 |    4 
 fs/xfs/scrub/scrub.c                                                      |    3 
 fs/xfs/scrub/stats.c                                                      |   60 
 fs/xfs/scrub/stats.h                                                      |    4 
 fs/xfs/scrub/symlink_repair.c                                             |    2 
 fs/xfs/scrub/trace.h                                                      |   35 
 fs/xfs/xfs_exchmaps_item.c                                                |   19 
 fs/xfs/xfs_exchrange.c                                                    |   12 
 include/cxl/event.h                                                       |   80 
 include/linux/bio.h                                                       |   14 
 include/linux/bitfield.h                                                  |    2 
 include/linux/bpf.h                                                       |    1 
 include/linux/bpf_verifier.h                                              |    4 
 include/linux/cper.h                                                      |    4 
 include/linux/device.h                                                    |    1 
 include/linux/ethtool.h                                                   |   28 
 include/linux/exportfs.h                                                  |    1 
 include/linux/firmware/intel/stratix10-smc.h                              |   18 
 include/linux/fwnode.h                                                    |    1 
 include/linux/hwmon.h                                                     |    1 
 include/linux/igmp.h                                                      |    7 
 include/linux/kcsan-checks.h                                              |    6 
 include/linux/mailbox_controller.h                                        |    2 
 include/linux/mfd/db8500-prcmu.h                                          |  252 +
 include/linux/mfd/dbx500-prcmu.h                                          |  575 ---
 include/linux/mm.h                                                        |    2 
 include/linux/mm_types.h                                                  |   27 
 include/linux/oa_tc6.h                                                    |   50 
 include/linux/perf/riscv_pmu.h                                            |    2 
 include/linux/perf_event.h                                                |    7 
 include/linux/phy.h                                                       |    1 
 include/linux/platform_data/cros_ec_proto.h                               |    2 
 include/linux/skbuff.h                                                    |    5 
 include/linux/sunrpc/rpc_pipe_fs.h                                        |    4 
 include/linux/sunrpc/svc.h                                                |   21 
 include/linux/sunrpc/svc_rdma.h                                           |    3 
 include/linux/sunrpc/xdr.h                                                |   13 
 include/linux/switchtec.h                                                 |    1 
 include/linux/thunderbolt.h                                               |    2 
 include/linux/workqueue.h                                                 |   38 
 include/media/v4l2-hevc.h                                                 |   41 
 include/net/cfg80211.h                                                    |    2 
 include/net/cfg802154.h                                                   |    1 
 include/net/dst.h                                                         |    6 
 include/net/inet6_hashtables.h                                            |    2 
 include/net/ip.h                                                          |   28 
 include/net/ip6_route.h                                                   |   45 
 include/net/ip6_tunnel.h                                                  |    2 
 include/net/ip_fib.h                                                      |    5 
 include/net/ipv6.h                                                        |   10 
 include/net/netlink.h                                                     |   14 
 include/net/sch_generic.h                                                 |    2 
 include/net/tcp.h                                                         |    8 
 include/rdma/ib_umem.h                                                    |    4 
 include/sound/hda_codec.h                                                 |   30 
 include/sound/rawmidi.h                                                   |    2 
 include/sound/tas2781.h                                                   |    4 
 include/trace/events/hwmon.h                                              |   10 
 include/trace/events/icmp.h                                               |   13 
 include/uapi/linux/ethtool.h                                              |  138 
 include/uapi/linux/virtio_crypto.h                                        |    1 
 include/uapi/sound/asound.h                                               |    6 
 io_uring/net.c                                                            |   10 
 kernel/bpf/bpf_iter.c                                                     |    2 
 kernel/bpf/btf.c                                                          |   24 
 kernel/bpf/cgroup.c                                                       |    1 
 kernel/bpf/disasm.c                                                       |    5 
 kernel/bpf/stackmap.c                                                     |  175 -
 kernel/bpf/verifier.c                                                     |  123 
 kernel/events/core.c                                                      |   27 
 kernel/events/ring_buffer.c                                               |    9 
 kernel/locking/lockdep.c                                                  |   50 
 kernel/printk/nbcon.c                                                     |    2 
 kernel/rcu/tasks.h                                                        |    3 
 kernel/sched/ext.c                                                        |   10 
 kernel/sched/fair.c                                                       |   11 
 kernel/time/clockevents.c                                                 |   33 
 kernel/time/tick-broadcast.c                                              |   36 
 kernel/time/tick-internal.h                                               |    2 
 kernel/trace/Makefile                                                     |    5 
 kernel/trace/bpf_trace.c                                                  |   11 
 kernel/trace/ring_buffer.c                                                |   26 
 kernel/trace/trace_event_perf.c                                           |   12 
 kernel/trace/trace_events_hist.c                                          |   42 
 kernel/trace/trace_events_user.c                                          |   26 
 kernel/trace/trace_probe.c                                                |   48 
 kernel/trace/trace_probe.h                                                |    2 
 kernel/workqueue.c                                                        |    5 
 mm/damon/core.c                                                           |   13 
 mm/gup.c                                                                  |   10 
 mm/hugetlb.c                                                              |    1 
 mm/hugetlb_vmemmap.c                                                      |    6 
 mm/migrate_device.c                                                       |    6 
 mm/page_alloc.c                                                           |    5 
 mm/slab.h                                                                 |    8 
 mm/slab_common.c                                                          |   41 
 mm/slub.c                                                                 |  114 
 mm/swapfile.c                                                             |    8 
 net/8021q/vlan.c                                                          |    7 
 net/8021q/vlan_dev.c                                                      |   32 
 net/9p/client.c                                                           |    2 
 net/appletalk/aarp.c                                                      |    5 
 net/bluetooth/hci_core.c                                                  |    4 
 net/bluetooth/iso.c                                                       |   31 
 net/bluetooth/l2cap_core.c                                                |   38 
 net/bluetooth/msft.c                                                      |    2 
 net/bluetooth/rfcomm/core.c                                               |    5 
 net/bridge/br_arp_nd_proxy.c                                              |   16 
 net/bridge/br_device.c                                                    |    2 
 net/bridge/br_fdb.c                                                       |    7 
 net/bridge/br_input.c                                                     |    2 
 net/bridge/br_multicast.c                                                 |   11 
 net/core/dev.c                                                            |    2 
 net/core/drop_monitor.c                                                   |   18 
 net/core/filter.c                                                         |   17 
 net/core/gro_cells.c                                                      |    2 
 net/core/rtnetlink.c                                                      |    7 
 net/core/skbuff.c                                                         |    7 
 net/ethtool/ioctl.c                                                       |  210 +
 net/hsr/hsr_forward.c                                                     |    2 
 net/hsr/hsr_netlink.c                                                     |    9 
 net/hsr/hsr_slave.c                                                       |   11 
 net/ieee802154/6lowpan/core.c                                             |    2 
 net/ipv4/fib_rules.c                                                      |    4 
 net/ipv4/fib_trie.c                                                       |    4 
 net/ipv4/fou_core.c                                                       |    2 
 net/ipv4/icmp.c                                                           |    2 
 net/ipv4/igmp.c                                                           |  210 -
 net/ipv4/inet_fragment.c                                                  |    6 
 net/ipv4/ip_output.c                                                      |    4 
 net/ipv4/ip_sockglue.c                                                    |    2 
 net/ipv4/ip_tunnel_core.c                                                 |    6 
 net/ipv4/ipmr.c                                                           |    5 
 net/ipv4/netfilter/nf_reject_ipv4.c                                       |    2 
 net/ipv4/nexthop.c                                                        |    2 
 net/ipv4/route.c                                                          |    4 
 net/ipv4/tcp.c                                                            |   14 
 net/ipv4/tcp_ipv4.c                                                       |   15 
 net/ipv4/tcp_minisocks.c                                                  |    2 
 net/ipv4/tcp_offload.c                                                    |   22 
 net/ipv4/tcp_output.c                                                     |   10 
 net/ipv4/tcp_timer.c                                                      |    6 
 net/ipv4/udp.c                                                            |    4 
 net/ipv6/addrconf.c                                                       |   10 
 net/ipv6/af_inet6.c                                                       |    2 
 net/ipv6/exthdrs.c                                                        |   99 
 net/ipv6/ioam6.c                                                          |   17 
 net/ipv6/ip6_fib.c                                                        |    4 
 net/ipv6/ip6_gre.c                                                        |    8 
 net/ipv6/ip6_input.c                                                      |   34 
 net/ipv6/ip6_output.c                                                     |   54 
 net/ipv6/ip6_tunnel.c                                                     |    8 
 net/ipv6/ip6_vti.c                                                        |    2 
 net/ipv6/ip6mr.c                                                          |    9 
 net/ipv6/ipv6_sockglue.c                                                  |    4 
 net/ipv6/mcast.c                                                          |   18 
 net/ipv6/netfilter.c                                                      |    4 
 net/ipv6/netfilter/ip6_tables.c                                           |    5 
 net/ipv6/netfilter/nf_reject_ipv6.c                                       |    2 
 net/ipv6/output_core.c                                                    |    2 
 net/ipv6/reassembly.c                                                     |   10 
 net/ipv6/route.c                                                          |   14 
 net/ipv6/seg6_iptunnel.c                                                  |    6 
 net/ipv6/sit.c                                                            |    2 
 net/ipv6/tcp_ipv6.c                                                       |   15 
 net/ipv6/tcpv6_offload.c                                                  |   15 
 net/ipv6/xfrm6_output.c                                                   |    2 
 net/l2tp/l2tp_debugfs.c                                                   |    4 
 net/l2tp/l2tp_ppp.c                                                       |   56 
 net/mac80211/cfg.c                                                        |    9 
 net/mac80211/ibss.c                                                       |    9 
 net/mac80211/mlme.c                                                       |    6 
 net/mac80211/tx.c                                                         |    2 
 net/mac80211/util.c                                                       |    6 
 net/mac802154/ieee802154_i.h                                              |    8 
 net/mac802154/iface.c                                                     |    6 
 net/mac802154/main.c                                                      |    1 
 net/mac802154/rx.c                                                        |  120 
 net/mac802154/scan.c                                                      |   10 
 net/mptcp/options.c                                                       |    7 
 net/mptcp/protocol.c                                                      |   18 
 net/mptcp/protocol.h                                                      |    5 
 net/mptcp/subflow.c                                                       |   12 
 net/mptcp/syncookies.c                                                    |    5 
 net/netfilter/ipset/ip_set_hash_gen.h                                     |   13 
 net/netfilter/ipvs/ip_vs_sync.c                                           |   20 
 net/netfilter/nf_conntrack_expect.c                                       |    3 
 net/netfilter/nf_conntrack_netlink.c                                      |   13 
 net/netfilter/nf_conntrack_proto_tcp.c                                    |   10 
 net/netfilter/nf_conntrack_sip.c                                          |    2 
 net/netfilter/nf_log_syslog.c                                             |    6 
 net/netfilter/nfnetlink_log.c                                             |   28 
 net/netfilter/nft_set_pipapo_avx2.c                                       |    1 
 net/netlabel/netlabel_unlabeled.c                                         |    2 
 net/openvswitch/flow.c                                                    |    4 
 net/openvswitch/flow_table.c                                              |    4 
 net/packet/af_packet.c                                                    |  101 
 net/phonet/pn_dev.c                                                       |   30 
 net/qrtr/af_qrtr.c                                                        |    4 
 net/rds/af_rds.c                                                          |   63 
 net/rds/connection.c                                                      |  102 
 net/rds/ib_cm.c                                                           |   25 
 net/rds/ib_recv.c                                                         |    9 
 net/rds/message.c                                                         |    4 
 net/rds/send.c                                                            |   16 
 net/rds/tcp.c                                                             |  164 -
 net/rds/tcp_listen.c                                                      |    6 
 net/sched/act_api.c                                                       |   46 
 net/sched/act_csum.c                                                      |    8 
 net/sched/cls_api.c                                                       |    8 
 net/sched/cls_route.c                                                     |   76 
 net/sched/cls_u32.c                                                       |   32 
 net/sched/sch_api.c                                                       |    2 
 net/sched/sch_drr.c                                                       |   13 
 net/sched/sch_ets.c                                                       |   12 
 net/sched/sch_fq_pie.c                                                    |    3 
 net/sched/sch_generic.c                                                   |   20 
 net/sched/sch_hhf.c                                                       |    8 
 net/sched/sch_pie.c                                                       |    2 
 net/sched/sch_sfq.c                                                       |    7 
 net/sctp/ipv6.c                                                           |   10 
 net/sctp/protocol.c                                                       |   10 
 net/sctp/sm_make_chunk.c                                                  |   14 
 net/sctp/sm_sideeffect.c                                                  |   11 
 net/sctp/sm_statefuns.c                                                   |    5 
 net/sunrpc/auth_gss/auth_gss.c                                            |    7 
 net/sunrpc/auth_gss/gss_rpc_xdr.c                                         |    9 
 net/sunrpc/clnt.c                                                         |   52 
 net/sunrpc/rpc_pipe.c                                                     |   80 
 net/sunrpc/svc.c                                                          |   23 
 net/sunrpc/xprtrdma/ib_client.c                                           |   24 
 net/sunrpc/xprtrdma/svc_rdma_pcl.c                                        |    2 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                                   |   15 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                                  |   32 
 net/sunrpc/xprtrdma/verbs.c                                               |   21 
 net/tipc/link.c                                                           |    6 
 net/tipc/name_table.c                                                     |   30 
 net/tipc/socket.c                                                         |    4 
 net/tls/tls_main.c                                                        |   11 
 net/tls/tls_sw.c                                                          |   12 
 net/unix/af_unix.c                                                        |   12 
 net/unix/garbage.c                                                        |    1 
 net/vmw_vsock/hyperv_transport.c                                          |    2 
 net/vmw_vsock/vmci_transport.c                                            |    2 
 net/wireless/core.c                                                       |   21 
 net/wireless/mlme.c                                                       |  101 
 net/wireless/nl80211.c                                                    |    8 
 net/wireless/wext-sme.c                                                   |    9 
 rust/bindings/lib.rs                                                      |    3 
 rust/uapi/lib.rs                                                          |    3 
 scripts/mksysmap                                                          |    2 
 scripts/mod/modpost.c                                                     |   11 
 scripts/sorttable.c                                                       |    2 
 security/apparmor/match.c                                                 |   22 
 security/integrity/digsig_asymmetric.c                                    |    4 
 security/integrity/ima/ima_appraise.c                                     |    5 
 security/keys/trusted-keys/trusted_tpm1.c                                 |    2 
 sound/core/pcm_native.c                                                   |   35 
 sound/core/rawmidi.c                                                      |    4 
 sound/core/seq/oss/seq_oss_rw.c                                           |    3 
 sound/core/seq/seq_prioq.c                                                |   14 
 sound/core/ump.c                                                          |   94 
 sound/hda/ext/hdac_ext_controller.c                                       |    6 
 sound/hda/hdac_bus.c                                                      |    8 
 sound/hda/hdac_component.c                                                |    6 
 sound/hda/hdac_device.c                                                   |   28 
 sound/hda/hdac_regmap.c                                                   |   35 
 sound/isa/es18xx.c                                                        |    4 
 sound/pci/ctxfi/cthw20k2.c                                                |    1 
 sound/pci/hda/cs35l41_hda_property.c                                      |    2 
 sound/pci/hda/cs35l56_hda.c                                               |   30 
 sound/pci/hda/hda_codec.c                                                 |  119 
 sound/pci/hda/hda_controller.c                                            |   24 
 sound/pci/hda/hda_proc.c                                                  |    4 
 sound/pci/hda/hda_sysfs.c                                                 |   77 
 sound/pci/hda/patch_conexant.c                                            |   12 
 sound/pci/hda/patch_realtek.c                                             |   40 
 sound/soc/amd/renoir/acp3x-pdm-dma.c                                      |    2 
 sound/soc/amd/yc/acp6x-mach.c                                             |   21 
 sound/soc/amd/yc/acp6x-pdm-dma.c                                          |    2 
 sound/soc/bcm/bcm63xx-i2s-whistler.c                                      |    1 
 sound/soc/codecs/ab8500-codec.c                                           |  537 +--
 sound/soc/codecs/mt6351.c                                                 |    1 
 sound/soc/codecs/pcm3168a.c                                               |   20 
 sound/soc/codecs/rk3328_codec.c                                           |   54 
 sound/soc/codecs/rt5645.c                                                 |    4 
 sound/soc/codecs/rt712-sdca.c                                             |   11 
 sound/soc/fsl/fsl-asoc-card.c                                             |    8 
 sound/soc/intel/atom/sst/sst_pci.c                                        |    1 
 sound/soc/intel/avs/core.c                                                |   11 
 sound/soc/intel/avs/debugfs.c                                             |   12 
 sound/soc/intel/avs/pcm.c                                                 |   34 
 sound/soc/intel/avs/topology.c                                            |    2 
 sound/soc/intel/avs/topology.h                                            |    1 
 sound/soc/intel/boards/sof_sdw.c                                          |   25 
 sound/soc/intel/catpt/ipc.c                                               |    8 
 sound/soc/intel/catpt/loader.c                                            |    3 
 sound/soc/intel/catpt/registers.h                                         |   12 
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c                                |   13 
 sound/soc/meson/aiu-acodec-ctrl.c                                         |    3 
 sound/soc/meson/aiu-codec-ctrl.c                                          |    3 
 sound/soc/qcom/qdsp6/q6apm.c                                              |   10 
 sound/soc/rockchip/rockchip_pdm.c                                         |   16 
 sound/soc/rockchip/rockchip_spdif.c                                       |    1 
 sound/soc/soc-topology.c                                                  |   37 
 sound/soc/sprd/sprd-pcm-compress.c                                        |   15 
 sound/soc/sti/uniperif_reader.c                                           |    4 
 sound/soc/ti/omap3pandora.c                                               |    5 
 sound/soc/ux500/ux500_msp_dai.c                                           |  189 -
 sound/soc/ux500/ux500_msp_dai.h                                           |   14 
 sound/soc/ux500/ux500_msp_i2s.c                                           |  264 +
 sound/soc/ux500/ux500_msp_i2s.h                                           |   12 
 sound/usb/caiaq/audio.c                                                   |   10 
 sound/usb/caiaq/device.c                                                  |   53 
 sound/usb/caiaq/device.h                                                  |    4 
 sound/usb/caiaq/input.c                                                   |    6 
 sound/usb/caiaq/midi.c                                                    |    6 
 sound/usb/mixer.c                                                         |   17 
 sound/usb/mixer_maps.c                                                    |   25 
 sound/usb/quirks-table.h                                                  |   22 
 sound/usb/quirks.c                                                        |    4 
 sound/usb/usx2y/us122l.c                                                  |    9 
 sound/usb/usx2y/usbusx2y.c                                                |   49 
 sound/usb/usx2y/usbusx2y.h                                                |    4 
 tools/bpf/bpftool/Makefile                                                |    6 
 tools/build/feature/test-bpf.c                                            |    2 
 tools/include/nolibc/crt.h                                                |    2 
 tools/lib/bpf/bpf.c                                                       |    2 
 tools/lib/bpf/gen_loader.c                                                |    2 
 tools/net/sunrpc/xdrgen/templates/C/union/declaration/close.j2            |    4 
 tools/perf/tests/shell/stat_bpf_counters.sh                               |   28 
 tools/perf/util/evsel.c                                                   |    4 
 tools/perf/util/symbol.c                                                  |   11 
 tools/sched_ext/scx_central.bpf.c                                         |    6 
 tools/sched_ext/scx_qmap.bpf.c                                            |    2 
 tools/testing/cxl/Kbuild                                                  |    2 
 tools/testing/selftests/alsa/mixer-test.c                                 |    4 
 tools/testing/selftests/bpf/progs/test_bpf_nf.c                           |    8 
 tools/testing/selftests/cgroup/test_kmem.c                                |    2 
 tools/testing/selftests/kselftest_harness.h                               |    2 
 tools/testing/selftests/mm/cow.c                                          |  338 --
 tools/testing/selftests/net/fib_nexthops.sh                               |   28 
 tools/testing/selftests/net/mptcp/mptcp_connect.c                         |    4 
 tools/testing/selftests/net/pmtu.sh                                       |    2 
 tools/testing/selftests/net/test_vxlan_mdb.sh                             |    6 
 tools/testing/selftests/powerpc/tm/tm.h                                   |    8 
 1042 files changed, 16692 insertions(+), 9982 deletions(-)

Aamir Ahmed (1):
      net: hinic: fix mailbox segment buffer overflow

Abd-Alrhman Masalkhi (1):
      md/raid10: fix writes_pending and barrier reference leaks on discard failures

Abdifatah Suruur (1):
      ksmbd: fix use-after-free in oplock break notification

Adrian Hunter (2):
      i3c: mipi-i3c-hci: Tolerate i3c_master_add_i3c_dev_locked() failures in DAA
      perf symbol: Do not use debug file as the binary type

Adrian Ng Ho Yin (2):
      clk: socfpga: agilex: implement l3_main_free_clk
      dmaengine: altera-msgdma: Use memcpy_toio for descriptor FIFO writes

Adrian Wowk (1):
      usbip: vhci_hcd: fix NULL deref in status_show_vhci

Adriana Stancu (1):
      rtc: bq32000: add delay between RTC reads

Adriano Vero (1):
      powerpc/fadump: Add timeout to RTAS busy-wait loops

Agalakov Daniil (1):
      e1000e: limit endianness conversion to boundary words

Ai Chao (1):
      ALSA: usb-audio: Add quirk flags for SC13A

Akashdeep Kaur (1):
      mfd: tps65219: Make poweroff handler conditional on system-power-controller

Al Viro (4):
      configfs_depend_prep(): pass configfs_dirent instead of dentry
      rpc_populate(): lift cleanup into callers
      rpc_mkpipe_dentry(): saner calling conventions
      rpc_pipe: don't overdo directory locking

Alan Borzeszkowski (2):
      thunderbolt: Don't create multiple DMA tunnels on firmware connection manager
      thunderbolt: Improve multi-display DisplayPort tunnel allocation

Aleksandr Nogikh (1):
      Bluetooth: hci_core: Fix race condition during device registration

Alessandro Baldi (1):
      media: imon: Add iMON VFD HID OEM v1.2 key mappings

Alessandro Schino (1):
      ntfs3: fix out-of-bounds read in ntfs_dir_emit() and hdr_find_e()

Alex Markuze (1):
      ceph: harden send_mds_reconnect and handle active-MDS peer reset

Alexandra Winter (1):
      s390/ism: folio_put() after error

Alexandre Courbot (1):
      scripts: modpost: detect and report truncated buf_printf() output

Alexey Klimov (1):
      clk: samsung: exynos850: mark APM I3C clocks as critical

Ali Ahmet Memis (3):
      ufs: do not treat unreadable directory blocks as empty
      ufs: create the root dentry after loading cylinder metadata
      ufs: validate cylinder group metadata before caching it

Alice Mikityanska (3):
      net/sched: act_csum: don't mangle UDP tunnel GSO packets
      net: ipv6: Fix UDP length overflow with PMTU discover and big MTU
      net: ipv6: Clamp to IP6_MAX_MTU in ip6_dst_mtu_maybe_forward

Allison Henderson (6):
      net/rds: Don't sleep inside rds_ib_conn_path_shutdown
      net/rds: use wq_has_sleeper() in release_in_xmit()
      net/rds: use clear_bit_unlock() in release_refill()
      net/rds: clear cp_flags bits individually in rds_conn_path_reset()
      net/rds: acquire RDS_IN_XMIT in rds_tcp_reset_callbacks()
      net/rds: don't let rds_conn_shutdown() consume a concurrent drop

Alysa Liu (1):
      drm/amdkfd: fix UAF race in destroy_queue_cpsch

Ameer Hamza (1):
      SUNRPC: Restore NUMA_NO_NODE for svc thread allocations in global mode

Anand Jain (1):
      btrfs: use on-disk uuid for s_uuid in temp_fsid mounts

Andre Eikmeyer (1):
      HID: apple: preserve keyboard backlight across T2 resume

Andrea Mayer (1):
      ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_srh_rcv()

Andrea Righi (1):
      sched/fair: Reject misfit pulls onto busy SMT siblings on asym-capacity

Andreas Gruenbacher (1):
      gfs2: page poisoning fix

Andrei Faleichyk (1):
      ALSA: hda/realtek: Add quirk for ASUS VivoBook X509DAP

Andrew Stellman (1):
      virtio-pci: return IRQ_HANDLED after non-zero ISR

Andrii Nakryiko (1):
      bpftool: Strip all -Wformat* flags from bootstrap libbpf build

André Pragosa (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Victus 16-e0xxx (MB 88ED)

Andy Shevchenko (2):
      smb: client: transport: Fix debug printing in __release_mid()
      thermal: sysfs: switch to use scnprintf() to suppress truncation warning

Anna Maniscalco (1):
      iommu: arm-smmu-qcom: Ensure smmu is powered up in set_ttbr0_cfg

Anna Schumaker (2):
      SUNRPC: Introduce xdr_set_scratch_folio()
      SUNRPC: Update svcxdr_init_decode() to call xdr_set_scratch_folio()

Anton Protopopov (1):
      bpf: fix the return value of push_stack

Aohan Mei (1):
      smb: client: reject userspace cifs.idmap descriptions

Arash Golgol (1):
      media: video-i2c: use vb2_video_unregister_device on driver removal

Armin Wolf (1):
      hwmon: (dell-smm) Add Dell Latitude 7530 to fan control whitelist

Arnd Bergmann (3):
      media: qcom: camss: avoid format string warning
      scsi: bfa: Reduce kernel stack usage in bfa_fcs_lport_fdmi_build_portattr_block()
      eth: mlx5: fix macsec dependency

Arvind Yadav (1):
      mm/migrate_device: clear stale mapping after freeing swapcache

Asad Kamal (1):
      drm/amd/pm: bound pp_dpm_set_pp_table() memcpy

Ashish Kalra (1):
      KVM: SEV: Disable SEV-SNP support on initialization failure

Atish Patra (1):
      crypto: ccp - Fix possible deadlock in SEV init failure path

Aurelien DESBRIERES (1):
      RDMA/rtrs-srv: Fix integer underflow in process_read and process_write

Avi Weiss (1):
      btrfs: send: fix lost error return value in will_overwrite_ref()

Baojun Xu (1):
      ASoC: tas2781: Update default register address to TAS2563

Bard Liao (2):
      ASoC: Intel: sof_sdw: append dai type to dai link name unconditionally
      soundwire: only handle alert events when the peripheral is attached

Baul Lee (2):
      vxlan: mdb: Fix use-after-free in vxlan_mdb_remote_src_del()
      HID: universal-pidff: stop the device when force-feedback init fails

Ben Maurer (1):
      btrfs: use lockless read in nr_cached_objects shrinker callback

Ben Reed (1):
      PCI: switchtec: Add Gen6 Device IDs

Bjoern Doebel (3):
      smb: client: avoid leaking refcount in cifs_queue_oplock_break()
      smb: client: avoid leaking refcount when cifs_sb_tlink() fails
      smb: client: fix heap overflow in DACL owner/group rewrite

Bjorn Helgaas (1):
      PCI: Wait for device readiness after D3hot -> D0uninitialized transition

Boris Brezillon (1):
      drm/gem: Consider GEM object reclaimable if shrinking fails

Brahmajit Das (1):
      drm/amd/display: clean-up dead code in dml2_mall_phantom

Brajesh Gupta (1):
      drm/imagination: Populate FW common context ID before passing to the FW

Brandon Brnich (1):
      media: chips-media: wave5: Fix Reports from Kernel Lock Validator

Breno Leitao (4):
      netconsole: take target_cleanup_list_lock in drop_netconsole_target()
      arm64: trans_pgd: clone only the linear map that exists at runtime
      usb: xhci: bail out of setup if the controller is inaccessible
      mm, swap: ratelimit bad swap entry reports

Brodie Abrew (1):
      platform/x86: sel3350-platform: Retain LED state on load and unload

Bryam Vargas (1):
      crypto: virtio - bound the akcipher result length

Candice Li (1):
      drm/amdgpu: validate and share PSP fw_pri_buf copies via psp_copy_fw

Carolina Jubran (3):
      net/mlx5e: Fix ETS zero BW reporting when one TC holds 100%
      net/mlx5e: Fix use-after-free race in sample_restore_put()
      netlink: introduce type-checking attribute iteration for nlmsg

Cen Zhang (Microsoft) (1):
      tipc: fix integer overflow in tipc_recvmsg() and tipc_recvstream()

Cezary Rojewski (5):
      ASoC: Intel: catpt: Complete coredump handling
      ASoC: codecs: pcm3168a: Drop CONFIG_PM-conditional preproc directive
      ASoC: Intel: avs: Clean up the bus when fetching ML caps fails
      ASoC: Intel: avs: Do not ignore -ENOENT when loading a topology
      ASoC: Intel: avs: Fix unbalanced module reference count

Changbin Du (1):
      perf/x86/intel/ds: Remove redundant assignments to sample.period

Charles Keepax (3):
      soundwire: intel_auxdevice: Add cs42l43b to wake_capable_list
      soundwire: dmi-quirks: Disable ghost Realtek devices
      ASoC: Intel: sof_sdw: Add quirks for new Dell laptops

Chen Bowen (1):
      ALSA: hda/realtek: Fix speakers on MECHREVO WUJIE Series

Chen Cheng (1):
      md/raid5: let stripe batch bm_seq comparison wrap-safe

Chen Pei (2):
      ACPI: scan: Honor _DEP for ACPI0016 PCI/CXL host bridge
      ACPI: PCI: Clear _DEP dependencies after PCI root bridge attach

Chen Zhang (2):
      Bluetooth: btusb: Add Realtek RTL8922AE VID/PID 0bda/d922
      Bluetooth: btusb: Add Realtek RTL8922AE VID/PID 0bda/d923

ChenXiaoSong (1):
      smb/client: zero-initialize stack-allocated cifs_open_info_data

Chengfeng Ye (3):
      netfilter: nf_log: unregister loggers before per-net teardown
      afs: Clear stale peer app data after address list changes
      KEYS: trusted: Fix TPM teardown ordering

Chenguang Zhao (2):
      RDMA/mlx5: Use QP port when decoding responder CQEs
      netlabel: fix IPv6 unlabeled address add error handling

Chris Aherin (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga 7 16IAP7

Chris Lu (2):
      Bluetooth: btusb: MT7922: Add VID/PID 0e8d/223c
      Bluetooth: btusb: MT7925: Add VID/PID 0e8d/8c38

Chris Mason (2):
      SUNRPC: fix gssx_dec_option_array error path bugs
      svcrdma: Reject Write/Reply chunks with segcount 0

Christian Marangi (1):
      usb: host: add ARCH_AIROHA in XHCI MTK dependency

Christoph Hellwig (11):
      iomap: don't make REQ_POLLED imply REQ_NOWAIT
      befs: handle set_blocksize failures
      ntfs3: handle set_blocksize failures
      affs: handle set_blocksize failures
      bfs: handle set_blocksize failures
      minix: handle set_blocksize failures
      qnx4: handle set_blocksize failures
      jfs: handle set_blocksize failures
      hpfs: handle set_blocksize failures
      omfs: handle set_blocksize failures
      isofs: handle set_blocksize failures

Chuck Lever (17):
      xprtrdma: Add request-pool slack for delayed recycling
      tls: Flush backlog before waiting for a new record
      xdrgen: Fix union declarations
      NFSD: Rename a function parameter
      NFSD: Make nfsd_genl_rqstp::rq_ops array best-effort
      Revert "NFSD: Remove the cap on number of operations per NFSv4 COMPOUND"
      NFSD: Prevent client use-after-free during admin state revocation
      NFSD: Prevent client use-after-free during delegation revoke
      NFSD: Guard admin state-revocation walks with NFSD_NET_UP
      NFSD: Consolidate the revocation-path client unpin
      NFSD: Prevent client use-after-free during blocked-lock reaping
      NFSD: Prevent client use-after-free during close_lru reaping
      rpcrdma: arm rn_done before publishing the notification
      svcrdma: Release transport resources synchronously
      svcrdma: Reorder rpcrdma_rn_unregister before rdma_destroy_id
      sunrpc: Add a helper to derive maxpages from sv_max_mesg
      svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages

Ciprian Regus (3):
      net: ethernet: oa_tc6: Handle the OA TC6 SPI protected mode
      net: ethernet: oa_tc6: Export standard defined registers
      net: ethernet: oa_tc6: Add the OA_TC6_ prefix to standard registers

Claudiu Beznea (1):
      pinctrl: renesas: rzv2m: Use -ENOTSUPP instead of -EOPNOTSUPP

Colin Ian King (2):
      OPP: of: Fix potential multiplication overflow when calculating freq
      cxgb4: clip_tbl: Fix spelling mistake "wont" -> "won't"

Cong Nguyen (2):
      hwmon: (gpio-fan) take fan_data->lock in gpio_fan_shutdown()
      hwmon: (applesmc) fix key backlight workqueue leak on register failure

Corentin Labbe (1):
      wifi: ralink: RT2X00: init EEPROM properly

Cris (1):
      Bluetooth: btusb: Add support for TP-Link TL-UB250

Cyrill Gorcunov (1):
      RDMA/irdma: Fix typo in SQ completions generation

Cássio Gabriel (6):
      ALSA: usb-audio: Propagate write errors in generic mixer put callbacks
      ALSA: usx2y: Drain pending US-428 pipe-4 output commands
      ALSA: seq: Remove arbitrary prioq insertion limit
      ASoC: codecs: rk3328: Use managed GPIO and clock helpers
      ALSA: seq: oss: Reject reads that cannot fit the next event
      ASoC: topology: Check PCM and DAI name strings before use

Dai Ngo (1):
      NFS: fix eof updates after NFSv4.2 fallocate/zero-range

Dan Carpenter (1):
      drm/virtio: Fix a NULL vs ERR_PTR() bug in virtio_gpu_user_framebuffer_create()

Daniel Borkmann (2):
      libbpf: Also reset {insn,data}_cur on realloc failure
      bpf: Reject redirect helpers without a bpf_net_context

Daniel C. Ribeiro (1):
      ALSA: usb-audio: Add FIXED_RATE quirk for JBL Quantum650 Wireless

Daniel Golle (3):
      net: dsa: lantiq_gswip: deduplicate dsa_switch_ops
      net: dsa: lantiq_gswip: prepare for more CPU port options
      net: dsa: lantiq_gswip: move definitions to header

Daniel Lezcano (1):
      thermal/drivers/tegra/soctherma: Switch to devm cooling device registration

Danielle Ratson (1):
      bridge: Do not suppress ARP probes and DAD NS unconditionally

Dapeng Mi (2):
      perf/x86/intel/ds: Factor out PEBS group processing code to functions
      perf/x86/intel: Correct pt_regs->flags update for PEBS path

Dario Binacchi (1):
      drm/panel: simple: Add AM-1280800W8TZQW-T00H

Darrick J. Wong (22):
      xfs: truncate quota file correctly when repairing quota file
      xfs: snapshot scrub stats when rendering them
      xfs: snapshot old AGFL before rewriting it
      xfs: signal inode btree xref error if get_rec returns an error
      xfs: reset parent pointer args before each dir tree unlink repair
      xfs: report nonexistent parents as a filesystem corruption
      xfs: preserve owner on in-memory btree creation
      xfs: log the tempip after we convert it to extents format
      xfs: fix replaying dirent removals into the temporary directory
      xfs: fix name string recording in slowpath pptr tracepoints
      xfs: fix bnobt repair space reservation disposal failure
      xfs: fix backwards skipping logic in xrep_quota_block
      xfs: don't spin forever on zero-length dirents when salvaging them
      xfs: don't modify file attributes or poke fsnotify for dry runs
      xfs: don't leak new_bp if xfs_btree_bload_drop_buf fails
      xfs: don't leak dqacct if rhashtable insertion fails
      xfs: destroy seen inode bitmap when we fail to add a dirpath
      xfs: count escaped corruption errors in scrub stats
      xfs: compute dquot checksum after resetting dd_lsn in repair
      xfs: bail out on bitmap errors in xrep_agfl_fill
      xfs: advance the findparent inode scan cursor while holding ILOCK
      xfs: actually recover intended file sizes in xfs_xmi_item_recover_intent

Dave Carey (3):
      HID: multitouch: Fix Yoga Book 9 14IAH10 touchscreen misclassification
      USB: cdc-acm: start bulk-IN polling when ALWAYS_POLL_CTRL is set
      HID: multitouch: Honor ContactCount for Yoga Book 9 to suppress ghost contacts

Dave Chen (1):
      btrfs: only account delalloc bytes for regular file inodes in btrfs_getattr()

Dave Jiang (1):
      cxl/pci: Remove CXL VH handling in CONFIG_PCIEAER_CXL conditional blocks from core/pci.c

David Arcari (1):
      watchdog: fix hrtimer start when pretimeout is zero

David Carlier (2):
      ring-buffer: Check resize_disabled before publishing the new subbuf order
      ieee802154: hwsim: serialize pib updates to fix double-free

David Francis (3):
      drm/amdkfd: Check bounds for allocate_sdma_queue restore_sdma_id
      drm/amdkfd: Check bounds on allocate_doorbell
      drm/amdkfd: Properly acquire queue buffers in CRIU restore

David Heidelberg (1):
      drm/panel: Enable GPIOLIB for panels which uses functions from it

David Hildenbrand (2):
      mm: move hugetlb specific things in folio to page[3]
      mm: move _pincount in folio to page[2] on 32bit

David Hildenbrand (Arm) (1):
      mm/gup: fix always draining LRU caches in collect_longterm_unpinnable_folios()

David Howells (3):
      cachefiles: Fix double fput
      netfs: Fix decision whether to disallow write-streaming due to fscache use
      afs: Fix incorrect free in candidate cleanup in afs_lookup_server()

David Laight (1):
      tipc: Dont send random pad bytes in RESET/ACTIVATE messages

David Sterba (4):
      btrfs: update include and forward declarations in headers
      btrfs: parameter constification in ioctl.c
      btrfs: pass struct btrfs_inode to btrfs_sync_inode_flags_to_i_flags()
      btrfs: use BTRFS_PATH_AUTO_FREE in can_nocow_extent()

David Timber (1):
      exfat: fix handling of damaged volume in exfat_create_upcase_table()

David Yang (1):
      net: dsa: sja1105: flower: reject cross-chip redirect

Dawei Feng (1):
      bpf: NUL-terminate replaced sysctl value

Dawid Osuchowski (1):
      accel/ivpu: Limit firmware log name prints to field size

Deepanshu Kartikey (1):
      wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()

Devin Wittmayer (1):
      wifi: mt76: mt7925: add Netgear A8500 USB device ID

Dian-Syuan Yang (2):
      wifi: rtw89: disable CSI STBC for VHT 160MHz
      wifi: rtw89: pci: enable LTR based on pcie control register

Dmitry Baryshkov (1):
      drm/panel: jadard-jd9365da-h3: set prepare_prev_first

Dominik Kaszewski (1):
      drm/amd/display: Fix DPMS using partially updated pipe context

Dong Chenchen (1):
      net: iptunnel: fix stale transport header during tunnel decapsulation

Donggeun Yoo (6):
      tracing: Fix memory corruption from the histogram stacktrace modifier
      tracing: Free histogram the var ref when its initialization fails
      tracing: Free histogram var refs regardless of how often they are referenced
      tracing: Free histogram the field rejected for a bad modifier
      tracing: Let histogram values keep the percent and graph modifiers
      tracing: Keep the entry count when the histogram stats allocation fails

Doruk Tan Ozturk (3):
      HID: sony: fix UAF of ghl_poke_timer / ghl_urb at driver unbind
      HID: sony: clean up device list on probe failure
      ocfs2: validate directory-index entry counts when reading metadata

Dr. David Alan Gilbert (1):
      ceph: Remove fs/ceph deadcode

Eduard Zingerman (2):
      bpf: reject BPF_PSEUDO_FUNC reference to the main program
      bpf: Don't predict JMP32 pointer vs zero comparisons

Edward Adam Davis (1):
      ALSA: caiaq: Decoupling ep1_in_urb in caiaq dev

Eelco Chaudron (1):
      openvswitch: fix wrong flag value in get_ipv6_ext_hdrs()

Emmanuel Grumbach (12):
      wifi: iwlwifi: mvm: validate sta_id in BA window status notif
      wifi: iwlwifi: mvm: validate mac_link_id in session protect notif
      wifi: iwlwifi: mvm: fix an off-by-1 boundary check
      wifi: iwlwifi: mvm: parse beacon notif per layout
      wifi: iwlwifi: mvm: fix sched scan IE sizing
      wifi: iwlwifi: pcie: null RX pointers after free
      wifi: iwlwifi: mvm: validate TX_CMD response layout
      wifi: iwlwifi: mvm: fix a possible underflow
      wifi: iwlwifi: mvm: add a check on the tid coming from the firmware
      wifi: iwlwifi: mvm: fix out-of-bounds tid_data access in BA notif
      wifi: iwlwifi: bound aligned TLV advance in FW parser
      wifi: iwlwifi: acpi: validate WGDS table revision index

Eric Biggers (3):
      crypto: x86/aria - add missing vzeroupper in AVX2 code
      crypto: x86/aria - add missing vzeroupper in AVX-512 code
      netfilter: nft_set_pipapo_avx2: add missing vzeroupper

Eric Dumazet (24):
      net: bridge: remove stale rcu_barrier() in br_multicast_dev_del()
      net/sched: sch_drr: make cl->quantum lockless
      drop_monitor: perform u64_stats updates under IRQ-disabled section
      drop_monitor: fix size calculations for 64-bit attributes
      l2tp: fix tunnel and session refcount leak on seq_file release
      net: icmp: avoid invalid transport header access in icmp_send tracepoint
      tcp: use GFP_ATOMIC in tcp_send_active_reset()
      igmp: convert struct ip_sf_list to RCU
      ipv6: mcast: fix RCU list diversion in ip6_mc_del1_src()
      ip6_gre: check tunnel info before xmit in ip6gre_tunnel_xmit
      ipv6: sr: restore network header before routing and forwarding
      bonding: alb: fix uninitialized transport header access in alb_determine_nd()
      locking/lockdep: Invalidate stale class_cache entries for zapped classes
      bonding: do not clear curr_active_slave prematurely when releasing all slaves
      bonding: use skb_cow_head() in bond_do_alb_xmit() and rlb_arp_xmit()
      vxlan: initialize _md in vxlan_xmit_one()
      ipv6: pass proto by value to ipv6_push_nfrag_opts() and ipv6_push_frag_opts()
      ipv6: add some unlikely()/likely() clauses in ip6_output.c
      inet: add dst4_mtu() and dst6_mtu() helpers
      ipv6: use dst6_mtu() instead of dst_mtu()
      ipv4: use dst4_mtu() instead of dst_mtu()
      vlan: fix skb_under_panic and races when toggling HW VLAN offload
      ipv6: adopt skb_dst_dev() and skb_dst_dev_net[_rcu]() helpers
      ipv6: ip6_mc_input() and ip6_mr_input() cleanups

Erni Sri Satya Vennela (1):
      net: mana: hardening: Reject zero max_num_queues from MANA_QUERY_VPORT_CONFIG

Ethan Nelson-Moore (1):
      ASoC: ti: omap3pandora: update board check to use DT compatible

Evgenii Burenchev (1):
      vdpa/ifcvf: handle dev_set_name() failure in ifcvf_vdpa_dev_add()

Fan Wu (2):
      ieee802154: cc2520: fix FIFOP work use-after-free
      hwmon: (gpio-fan) Fix use-after-free in alarm work

Farhad Alemi (1):
      freevxfs: don't BUG() on unknown typed-extent type

Fernando Fernandez Mancera (1):
      ipv6: addrconf: fix temp address generation after prefix deprecation

Filipe Manana (7):
      btrfs: fix use-after-free on reloc root after error in insert_dirty_subvol()
      btrfs: fix reloc root cleanup in merge_reloc_roots()
      btrfs: move btrfs_is_empty_uuid() from ioctl.c into fs.c
      btrfs: move BTRFS_BYTES_TO_BLKS() into fs.h
      btrfs: move btrfs_alloc_write_mask() into fs.h
      btrfs: add btrfs prefix to main lock, try lock and unlock extent functions
      btrfs: rename extent map functions to get block start, end and check if in tree

Florian Eckert (1):
      PCI: intel-gw: Enable clock before PHY init

Florian Pradines (1):
      HID: mcp2221: fix OOB write in mcp2221_raw_event()

Florian Westphal (4):
      netfilter: nf_conntrack_expect: zero at allocation time
      netfilter: nfnetlink_log: wait for rcu grace period before freeing pernet state
      netfilter: nfnetlink_log: cope with concurrent instance destruction
      netfilter: ip6_tables: set F_PROTO when proto value is nonzero

Fourie Zhang (1):
      net: mpls: clear inner_protocol when the last label is popped

Fredric Cover (1):
      smb: client: fix races in cifsd thread creation

Furong Xu (1):
      net: stmmac: TSO: Simplify the code flow of DMA descriptor allocations

Furst Blumier (1):
      ALSA: hda/realtek: Add quirk for HP 255 15.6 inch G9 Notebook PC

Gabriel Krisman Bertazi (1):
      io_uring/net: let io_recv_buf_select return the length of the buffer region

Gabriel Prostitis (1):
      USB: gadget: ffs: fix mm lifetime handling

Gal Pressman (2):
      ethtool: Symmetric OR-XOR RSS hash
      ethtool: Block setting of symmetric RSS when non-symmetric rx-flow-hash is requested

Galen Hassen (1):
      ALSA: hda/conexant: Add pin config quirk for Lenovo IdeaPad Slim 5 16AKP10

Gang Yan (1):
      selftests: mptcp: fix an UAF in mptcp_connect.c

Gary Guo (6):
      usb: xusbatm: don't rely on id table pointer arithmetic
      wifi: ath9k_htc: don't store usb_device_id
      usb: usbtmc: don't store usb_device_id
      usb: serial: spcp8x5: don't store usb_device_id
      media: as102: do not rely on id table address comparison
      net: usb: pegasus: don't rely on id table pointer arithmetic

Geert Uytterhoeven (2):
      clk: renesas: cpg-mssr: Add number of clock cells check
      hwmon: (ltc4282) Make sure clk_init_data is fully initialized

Genevieve Chan (1):
      firmware: stratix10-svc: fix FCS SMC call kernel-doc

George Moussalem (1):
      net: dsa: qca8k: Add support for force mode for fixed link topology

Georgi Valkov (1):
      wifi: mwifiex: replace one-element arrays with flexible array members

Gerd Rausch (1):
      net/rds: tcp: don't force RDS_CONN_RESETTING over a concurrent shutdown

Gil Fine (3):
      thunderbolt: Avoid reserved fields in path config space for USB4 routers
      thunderbolt: Increase timeout for Configuration Ready bit
      thunderbolt: Verify Router Ready bit is set after router enumeration

Gil Portnoy (1):
      ksmbd: remove stale channels from all sessions on teardown

Gleb Sonichev (1):
      platform/x86: dell-laptop: add Inspiron N5110 to touchpad LED quirk table

Goldwyn Rodrigues (1):
      ima: return error early if file xattr cannot be changed

Gongwei Li (1):
      Bluetooth: hci_mrvl: Fix wrong return value check of wait_on_bit_timeout()

Greg Kroah-Hartman (1):
      Linux 6.12.111

Greg Marsden (1):
      net/rds: fix tcp stream corruption with large pages

Gregor Herburger (1):
      drm/vc4: hvs/v3d: Fix null dereference in unbind

Guanghui Yang (2):
      btrfs: detach failed sprout device from transaction update list
      btrfs: restore active device pointers after failed sprout

Guangshuo Li (2):
      net: cpsw_new: unregister devlink on port registration failure
      net: lan966x: restore RX state on reload failure

Guenter Roeck (2):
      hwmon: (corsair-psu) Fix linear11 calculation
      hwmon: Introduce 64-bit energy attribute support

Gustavo Kenji Mendonça Kaneko (2):
      drm/arm/malidp: use clk_bulk API in runtime PM resume and suspend
      drm/arm/komeda: fix error handling for clk_prepare_enable() and callers

HW He (1):
      net: gro: Fix nesting of TCP GSO SKBs in skb_gro_receive_list()

Hannes Reinecke (1):
      nvme-tcp: open-code nvme_tcp_queue_request() for R2T

Hans Zhang (5):
      PCI: iproc: Protect root bus removal with rescan lock
      PCI: altera: Protect root bus removal with rescan lock
      PCI: rockchip: Protect root bus removal with rescan lock
      PCI: mediatek: Protect root bus removal with rescan lock
      PCI: plda: Protect root bus removal with rescan lock

Haotian Zhang (1):
      media: v4l2-h264: Fix memcmp() size in B1 reference list comparison

Haoxiang Li (5):
      media: em28xx-video: fix missing res_free() on init_usb_xfer failure
      net: thunderx: fix PTP device ref leak in nicvf_probe()
      net: microchip: sparx5: clean up PSFP resources on flower setup failure
      fbdev: pm2fb: unwind WC setup on probe failure
      cpufreq: apple-soc: Fix OPP table cleanup

Harald Freudenberger (3):
      s390/crypto: Fix skcipher_walk return code handling in aes_s390
      s390/crypto: Fix use of mutex in atomic context
      s390/crypto: Fix missing scrub of temp buffers with AES ctr and gcm algorithm

Hardik Garg (1):
      Drivers: hv: vmbus: add VTL2 redirect connection ID

Harry Wentland (1):
      dm/amdgpu: fix malformed link_settings debugfs output

Heiko Carstens (3):
      s390/zcore: Removed unused variables
      s390/vtime: Use __this_cpu_read() / get rid of READ_ONCE()
      s390/time: Use jiffies instead of jiffies_64

Heiner Kallweit (1):
      net: phy: add phy_disable_eee

Henrique Carvalho (2):
      smb: client: batch SRV_COPYCHUNK entries to cut round trips
      smb: client: fix UBSAN array-index-out-of-bounds in smb2_copychunk_range

Henry Martin (3):
      sctp: fix soft lockup from unpadded ASCONF-ACK parameter iteration
      tracing/probes: Fix use-after-free on field name/type of events with multiple probes
      tracing/user_events: Don't destroy fields when event removal fails

Hirokazu Honda (1):
      tee: optee: Allow MT_NORMAL_TAGGED shared memory

Hongfu Li (1):
      selftests/cgroup: Fix cg_run_in_subcgroups ignoring arg parameter

Hrvoje Nuic (1):
      Bluetooth: btusb: Add Mercusys MA530 for Realtek RTL8761BUV

Hui Su (1):
      staging: fbtft: make dirty_lock IRQ-safe

Huiwen He (7):
      smb/client: reduce fallocate zero buffer allocation
      smb/client: flush dirty data before punching a hole
      smb/client: validate new EOF for insert range
      smb/client: validate new EOF for zero range
      smb/client: mark file sparse before emulating insert range
      smb/client: fix data corruption in emulated insert range
      smb/client: fix integer truncation in collapse range

HyeongJun An (3):
      ASoC: meson: aiu: Validate written enum values
      selftests/alsa: Fix the step check for INTEGER controls
      ALSA: hda: Report a change when only the channel status bytes move

Håkon Bugge (1):
      net/rds: acquire the fastpath locks in rds_conn_shutdown()

Ian Rogers (1):
      perf evsel: Add per-thread warning for EOPNOTSUPP open failues

Ibrahim Hashimov (2):
      wifi: mac80211_hwsim: reject undersized HWSIM_ATTR_TX_INFO
      mac802154: fix use-after-free of sdata via queued RX frames

Ido Schimmel (3):
      bridge: Add missing READ_ONCE() annotations around FDB destination port
      nexthop: Initialize extack in remove_nh_grp_entry()
      tunnels: Drop stale dst when building an ICMP error for PMTUD

Ilya Maximets (1):
      netfilter: report NLM_F_DUMP_FILTERED when all is filtered out

Imre Deak (1):
      drm/dp: Add DSC virtual DPCD quirk for Realtek MST branch device

Ioana Ciornei (4):
      bus: fsl-mc: wait for the MC firmware to complete its boot
      dpaa2-switch: rework FDB management on the bridge leave path
      dpaa2-switch: fix the error path in dpaa2_switch_rx()
      dpaa2-switch: fix handling of NAPI on the remove path

Ion Agorria (1):
      ARM: tegra: p880: Lower CPU thermal limit

Ivan Hu (1):
      Bluetooth: btmtk: Declare MT7920 (MT7961 1a) Bluetooth firmware

Ivan Lipski (1):
      drm/amd/display: Initialize dsc_caps to 0

Ivy Lopez (1):
      scsi: mpt3sas: Avoid out-of-bounds cpumask_of_node() call in _base_assign_reply_queues()

Jacob Keller (1):
      ice: add missing xa_destroy for sched_node_ids

Jad Keskes (1):
      EDAC/device_sysfs: Use kstrtouint() for poll_msec to prevent truncation

Jakub Kicinski (11):
      tls: reject the combination of TLS and sockmap
      net: dsa: bcm_sf2: bound the CFP rule dump by the caller's buffer size
      net: ethtool: copy the rxfh flow handling
      net: ethtool: remove the duplicated handling from rxfh and rxnfc
      net: ethtool: require drivers to opt into the per-RSS ctx RXFH
      net: ethtool: add dedicated callbacks for getting and setting rxfh fields
      eth: nfp: migrate to new RXFH callbacks
      eth: nfp: bound the ntuple rule dump by the caller's buffer size
      eth: nfp: drop the replaced rule from the list when reprogramming fails
      net: dsa: mv88e6xxx: bound the policy rule dump by the caller's buffer size
      eth: ice: don't dereference pointers from TP_printk()

Jamal Hadi Salim (9):
      net/sched: cls_u32: fix duplicate handle when node ID pool is exhausted
      net: cap tx_queue_len at S16_MAX to prevent oversized ring allocations
      net: reject oversized tx_queue_len at netlink parse time
      net/sched: fq_pie: clamp quantum in change path
      net/sched: sfq: clamp quantum in change path
      net/sched: hhf: clamp quantum in change and init paths
      net/sched: pie: clamp psched_mtu in pie_drop_early
      net/sched: drr: clamp quantum in change class
      net/sched: ets: clamp quantum in parse and fallback paths

James Hilliard (1):
      watchdog: sunxi_wdt: preserve boot-enabled watchdog

James Nugraha (1):
      net: amd-xgbe: discard rx packets with bad FCS

Jan Havran (Advantech Czech) (1):
      net: dsa: lantiq_gswip: fix GSWIP_MDIO_PHY_FCONTX_EN value

Jan Volckaert (1):
      net: usb: qmi_wwan: add MeiG SRM813Q

Jann Horn (1):
      exec: do_close_on_exec() before taking exec_update_lock

Jared Kangas (1):
      hwmon: (ina2xx) Parameterize ina2xx_data in ina226_alert_read()

Jason Gunthorpe (2):
      RDMA/umem: Be careful about boundary conditions in ib_umem_find_best_pgsz()
      RDMA/mlx5: Create ODP EQ for non-pinned dmabuf MRs

Jason Winter (1):
      net: usb: cx82310_eth: drop URB after 0xffff reboot sentinel to prevent partial_data heap overflow

Javier Carrasco (1):
      hwmon: (chipcap2) fix channels in humidity alarm notifications

Javier Tia (5):
      wifi: mt76: mt7925: handle 320MHz bandwidth in RXV and TXS
      wifi: mt76: mt7925: populate EHT 320MHz MCS map in sta_rec
      wifi: mt76: mt7925: add 320MHz bandwidth to bss_rlm_tlv
      xfs: initialise error in xfs_defer_finish_one()
      xfs: initialise args->total for parent pointer updates

Jay Vadayath (1):
      smb: client: bound dirent name against end of SMB response in cifs_filldir

Jean-Louis Colaco (1):
      ALSA: usb-audio: Add quirk for YAMAHA CDS3000

Jeff Layton (10):
      nfsd: validate sockaddr length per family in listener_set
      nfsd: check nfsd4_acl_to_attr() return value in nfsd4_create()
      nfsd: widen nfsd_genl_rqstp address fields to sockaddr_storage
      nfsd: dedup nfs4_client_to_reclaim inserts
      nfsd: RCU-protect cl_cb_session to fix use-after-free on session teardown
      nfsd: fix clock domain mismatch in clients_still_reclaiming()
      nfsd: fix netlink dumpit error handling for rpc_status_get
      nfsd: fix stale s2s_cp_stateids IDR entry for async COPY
      nfsd: close shrinker/GC/fsnotify vs per-net shutdown race in filecache
      sunrpc: defer rq_argp and rq_resp free until after RCU grace period

Jeffin Philip (1):
      fs: autofs: fix memory leak in autofs_fill_super()

Jeremy Klarenbeek (1):
      drm/amd/pm/si: Fix updating clock limits from power states

Jetha Chan (1):
      ASoC: amd: yc: Add Alienware m15 R7 AMD to DMIC quirk table

Jia Jia (3):
      vhost-scsi: flush backend after device ioctls
      virtio_console: do not free control-out buffers on remove
      vhost/vdpa: reject VRING_NUM larger than device max

Jiacheng Xu (1):
      workqueue: reject watchdog thresholds that overflow jiffies

Jiajia Liu (3):
      wifi: mt76: transform aspm_conf for pci_disable_link_state
      Bluetooth: btusb: mediatek: Fix leaked runtime PM reference in reset
      Bluetooth: btusb: Fix leaked runtime PM reference in btusb_reset

Jiale Yao (1):
      Bluetooth: RFCOMM: validate skb length in rfcomm_recv_frame

Jiangshan Yi (1):
      HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes

Jiayuan Chen (6):
      rds: annotate data-race around rs_seen_congestion
      bpf: Fix REG INVARIANTS VIOLATION on speculative pointer arithmetic
      bpf: Fix NULL-ptr-deref when showing a void BTF type
      bpf: Fix NULL-ptr-deref in btf_var_show()
      selftests/bpf: Fix flaky bpf_nf test when random NAT port is 0
      net: advertise TCP MSS from the configured MTU, not the learned PMTU

Jie Gan (1):
      coresight: platform: defer connection counter increment until alloc succeeds

Jie Wang (2):
      gfs2: fix quota init duplicate scan
      gfs2: move quota_init qc iterator increment

Jijie Shao (1):
      net: hns3: improve the unused_tuple parameter setting

Jiri Kosina (1):
      HID: hidpp: fix potential UAF in hidpp_connect_event()

Jiri Olsa (6):
      bpf: Guard __get_user acesss with access_ok for uprobe_multi data
      bpf: Factor stackid_init function from __bpf_get_stackid
      bpf: Factor stackid_fastpath function from __bpf_get_stackid
      bpf: Factor stackid_new_bucket from __bpf_get_stackid
      bpf: Use stack id functions instead of __bpf_get_stackid
      bpf: Disable preemption in bpf_get_stackid

Jisheng Zhang (1):
      spi: dw: fix wrong RX_SAMPLE_DLY setting after resume

Joas Antonio dos Santos (1):
      netfilter: nf_conntrack_sip: fix OOB read in sip_skip_whitespace()

Joe Damato (3):
      bnxt_en: Only restore LRO if the device supports TPA
      bnxt_en: Handle buffer allocation failure in bnxt_rx_ring_reset()
      bnxt_en: Propagate RX ring init failures in bnxt_init_nic()

Johan Hovold (1):
      net: hso: fix TIOCMIWAIT race

Johannes Berg (3):
      wifi: nl80211: reject beacons with bad HE operation
      wifi: mac80211: always allow transmitting null-data on TXQs
      wifi: mac80211: explicitly disable FTM responder on AP stop

Johannes Thumshirn (1):
      btrfs: zoned: finish active block group cleanup if call_zone_finish() fails

John Ogness (1):
      printk/nbcon: Change nbcon_irq_work to IRQ_WORK_LAZY

Joonwon Kang (1):
      mailbox: Make mbox_send_message() return error code when tx fails

Jose Ignacio Tornos Martinez (3):
      net: wwan: t7xx: Add delay between MD and SAP suspend
      PCI: Avoid FLR for MediaTek MT7925 WiFi
      PCI: Avoid SBR for Qualcomm WCN6855/WCN7850 WiFi, SDX62/SDX65 modems

Joseph Qi (1):
      ocfs2: validate dx_root extent list fields during block read

Joshua Hay (1):
      idpf: account for VLAN header when parsing RSC packet header

Jozsef Kadlecsik (1):
      netfilter: ipset: mark the rcu locked areas properly

Justin Chen (2):
      net: bcmasp: clear txcb->last before writing each descriptor
      net: bcmasp: fix tx_spb_ring_full() checking same slot cnt times

Justin Lai (1):
      rtase: Fix flow control configuration

Kamal Wadhwa (1):
      regulator: core: clamp voltage constraints before applying apply_uV

Kamlesh Chhetty (1):
      ALSA: hda: Add Lenovo Legion 7i 16IAX7 17AA3874 quirk

Kan Liang (2):
      perf: Supply task information to sched_task()
      perf/x86/intel/ds: Clarify adaptive PEBS processing

KangNing Liao (1):
      btrfs: protect sb_write_pointer() with invalidate lock

Karl Mehltretter (5):
      tracing: Disable KCOV instrumentation for trace_irqsoff.o
      virtio: fix use-after-free in unregister_virtio_device()
      virtio_input: stop callbacks before unregistering input device
      drm/logicvc: Drop the select of the nonexistent CONFIG_DRM_KMS_DMA_HELPER
      smb: client: pin DFS superblock in iterator callback

Kartik Rajput (1):
      soc/tegra: fuse: Register nvmem lookups at probe

Kazuki Hanai (1):
      ALSA: us122l: Prevent write upgrades for read mappings

Kees Cook (1):
      arm: Handle KCOV __init vs inline mismatches

Kevin Tung (1):
      iio: adc: rtq6056: add i2c_device_id support

Kiran K (4):
      Bluetooth: btintel_pcie: Add 50 ms delay before MAC init on BlazarIW
      Bluetooth: btintel_pcie: Clear automask on spurious interrupts
      Bluetooth: btintel_pcie: validate packet_len before skb_put_data
      Bluetooth: btintel_pcie: fix tx_handle bounds off-by-one

Kory Maincent (1):
      hwmon: (adt7462) Add of_match_table to support devicetree

Krzysztof Wilczyński (3):
      PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
      PCI/proc: Fix race between pci_proc_init() and pci_bus_add_device()
      PCI/sysfs: Use kstrtobool() to parse the ROM attribute input

Kumar Kartikeya Dwivedi (5):
      bpf: Mark sched_process_wait argument as nullable
      bpf: Mark bpf_btf_find_by_name_kind() as sleepable
      bpf: Mark faultable stack helpers as sleepable
      bpf: Require MEM_PERCPU for percpu kptr stores
      bpf: Reject non-scalar bpf_loop iteration counts

Kumar Meiyappan (2):
      scsi: pm8001: Reject firmware update in fatal error state
      scsi: pm8001: Reject non-fatal dump when controller is crashed

Kuniyuki Iwashima (6):
      ipv4: fib: Don't dump dying fib_info in fib_leaf_notify().
      af_unix: Unlink scc_entry in unix_del_edge().
      af_packet: Don't cast tpacket_hdr.tp_len to int in tpacket_parse_header().
      af_unix: Update last skb marker in manage_oob().
      af_unix: Return immediately when manage_oob() returns NULL for 0-length buffer.
      net/sched: cls_api: Don't replay RTM_GETCHAIN in tc_ctl_chain().

Kyle Zeng (3):
      ipvs: fix reversed sequence option serialization
      ipvs: reject invalid states in connection template sync records
      net/packet: defer vmalloc TX_RING free until skbs finish

Lad Prabhakar (3):
      pinctrl: renesas: rzg2l: Handle RZ/V2H(P) IOLH configuration in PM cache
      mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC
      mmc: renesas_sdhi: Add OF entry for RZ/G2E SoC

Lama Kayal (1):
      net/mlx5: E-Switch, prevent mc_list repopulation during vport disable

Laxman Acharya Padhya (4):
      wifi: mt76: mt7921: validate CLC firmware records
      wifi: mt76: mt7921: skip unknown CLC firmware records
      Bluetooth: btintel: validate version TLV value lengths
      Bluetooth: btintel: bound firmware ID by TLV length

Leo Yan (2):
      bpftool: Pass host flags to bootstrap libbpf
      perf/core: Skip empty AUX records with only format flags

Leonardo Bras (1):
      arm64/daifflags: Make local_daif_*() helpers __always_inline

Li Qiang (1):
      cifs: validate idmap key payload length

Li RongQing (1):
      RDMA/mlx5: Fix state and counter desync on loopback enable failure

Li Xiasong (1):
      mm/slub: fix missing debugfs entries for caches created before sysfs init

Li Youhong (1):
      net: sun4i-emac: fix missing of_node_put() for phy_node

Liang Hao (1):
      gpio: dwapb: Mask interrupts at hardware initialization

Liang Luo (1):
      sched_ext: Fix nonexistent field in sched-ext.rst example

Lijo Lazar (2):
      drm/amd/pm: Check SMUv13.0.6/12 metrics integrity
      drm/amdgpu: Prefer ROM BAR for default VGA device

Lin Jiapeng (1):
      xfs: fix exchange-range reflink flag clearing issue with INO1_WRITTEN

Lin Xianglin (1):
      ASoC: amd: yc: Add DMI quirk for HyperX OMEN Gaming Laptop 16-ap1xxx

Linfeng Sun (2):
      vdpa_sim_blk: reject out-of-range sector starts
      vdpa_sim_net: check TX pull result before RX copy

Linmao Li (2):
      hwmon: (corsair-cpro) Create debugfs entries after hwmon registration
      hwmon: (corsair-cpro) Remove debugfs entries when probe fails

Linus Walleij (20):
      ASoC: ab8500: Reset the audio block before configuring it
      ASoC: ab8500: Repair the DAPM capture graph
      ASoC: ab8500: Correct digital interface format setup
      ASoC: ab8500: Validate and program TDM slots correctly
      ASoC: ux500: Fix MSP stream lifecycle handling
      ASoC: ux500: Propagate MSP setup errors
      ASoC: ux500: Correct MSP frame and bit clock setup
      ASoC: ux500: Validate MSP DAI configuration
      mfd: db8500-prcmu: Fold dbx500 header into db8500
      ASoC: ux500: Deassert the MSP reset during probe
      ASoC: ux500: Request the MSP MMIO resource
      ASoC: ux500: Remove obsolete PRCMU QoS calls
      ASoC: ux500: Allow repeated MSP prepare calls
      ASoC: ux500: Program the MSP FIFO watermarks
      net: ethernet: cortina: Fix budget accounting
      net: ethernet: cortina: Finish RX updates before NAPI completion
      net: ethernet: cortina: Count dropped frames as NAPI work
      net: ethernet: cortina: No mapping is a dropped rx
      net: ethernet: cortina: Count RX drops once per frame
      net: ethernet: cortina: Count RX descriptors for freeq refill

Longlong Xia (2):
      zram: fix out-of-bounds access in read_block_state()
      zram: fix out-of-bounds access in writeback_store()

Lorenzo Bianconi (3):
      net: stmmac: reconfigure RX packet parser table in stmmac_hw_setup() after reset
      net: stmmac: initialize ptp_lock at probe time
      net: stmmac: fix TX descriptor availability check for TSO traffic

Lorenzo Stoakes (ARM) (1):
      scripts/mksysmap: fix escape of '$' in the __pi_ pattern

Lu Yao (2):
      fbcon: don't suspend/resume when vc is graphics mode
      drm/xe/oa: Remove sysfs entry on idr_alloc failure in xe_oa_add_config_ioctl()

Luca Leonardo Scorcia (1):
      drm/mediatek: dsi: Add compatible for mt8167-dsi

Luis de Carlos (1):
      platform/x86: msi-ec: Add support for MSI Pulse GL66 12th Gen

Luiz Augusto von Dentz (1):
      Bluetooth: btusb: Fix UAF of btusb_data by rx_work

Luka Gejak (1):
      net: hsr: require valid EOT supervision TLV

Lukas Wunner (5):
      PCI: Stop setting cached power state to 'unknown' on unbind
      crypto: ecc - Unbreak the build on arm with CONFIG_KASAN_STACK=y
      crypto: virtio - Drop sign/verify operations
      crypto: virtio - Drop superfluous [as]kcipher_ctx pointer
      crypto: virtio - Drop superfluous [as]kcipher_req pointer

Luxiao Xu (1):
      sunrpc: fix use-after-free in __rpc_clnt_handle_event and __rpc_clnt_remove_pipedir

MD Danish Anwar (1):
      net: hsr: enable promiscuous mode on interlink port with fwd offload

Madhavender Singh (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Laptop 14s-dr1xxx

Magdalena Schulfer (2):
      accel/ivpu: Validate full buffer range in ivpu_to_cpu_addr
      accel/ivpu: Validate firmware log buffer metadata

Mallesh Koujalagi (1):
      workqueue: Update documentation as per system_percpu_wq naming

Maoyi Xie (3):
      usb: gadget: aspeed_udc: avoid past-the-end iterator in dequeue
      rds: filter RDS_INFO_* getsockopt by caller's netns
      hsr: broadcast netlink notifications in the device's net namespace

Marcel Kłos (1):
      ALSA: hda/realtek: Add quirk for HP EliteBook 830 G8 (8AB8) to enable mute LEDs

Marco Crivellari (1):
      workqueue: replace use of system_wq with system_percpu_wq

Marco Elver (1):
      kcsan: Silence -Wmaybe-uninitialized when calling __kcsan_check_access()

Marco Felsch (1):
      serial: 8250: fix possible ISR soft lockup

Marek Behún (3):
      net: dsa: mv88e6xxx: fix number of g1 interrupts for 6320 family
      net: dsa: mv88e6xxx: define .pot_clear() for 6321
      net: dsa: mv88e6xxx: enable .rmu_disable() for 6320 family

Marek Vasut (1):
      net: ks8851: Fix receiver error in 100BASE-TX mode following software power-down

Mark Pearson (2):
      watchdog: lenovo_se10_wdt: Add support for SE10 Gen 2 platform
      watchdog: lenovo_se10_wdt: Fix use-after-free and resource leak risk

Markus Lindner (1):
      ALSA: usb-audio: Add dB map quirk for Razer Barracuda X 2.4

Mathias Nyman (1):
      xhci: Prevent queuing new commands if xhci is inaccessible

Matthew Bystrin (1):
      mfd: rsmu: Add 8a34002 support

Matthieu Baerts (NGI0) (3):
      mptcp: options: handle MPC data + csum reqd + no csum
      mptcp: subflow: no need to copy thmac during ulp_clone
      mptcp: syncookies: remember the request backup flag

Maurizio Lombardi (2):
      nvme-core: align fabrics_q teardown with admin_q in nvme_free_ctrl
      scsi: target: iscsi: Fix hang for aborted WRITE_PENDING commands

Max Chou (1):
      Bluetooth: btrtl: Add the support for RTL8761CUV

Max Kellermann (1):
      ceph: force a cap message when a deferred revoke can't be acked immediately

Maxime Bélair (1):
      apparmor: propagate -ENOMEM correctly in unpack_table

Miao Li (1):
      iio: light: stk3310: Deal with the ps interrupt issue in PM

Miaoqing Pan (1):
      wifi: ath11k: fix invalid data access in ath11k_dp_rx_h_undecap_nwifi

Michael Bommarito (7):
      media: hevc: add bounded tile-count helpers
      media: verisilicon: hantro: bound G2 HEVC tile loop to the buffer capacity
      media: mediatek: vcodec: bound AV1 tile-start copy to the array capacity
      media: verisilicon: rockchip: guard VPU981 AV1 divisor and tile buffer
      media: verisilicon: rockchip: reject AV1 frames exceeding the tile capacity
      media: v4l2-ctrls: validate HEVC tile counts
      media: v4l2-ctrls: validate AV1 tile counts

Michael Walle (1):
      clk: keystone: don't cache clock rate

Michal Pecio (1):
      usb: xhci: Improve Soft Retries after short transfers

Michal Swiatkowski (1):
      ice: pass the return value of skb_checksum_help()

Mieczyslaw Nalewaj (1):
      net: dsa: realtek: rtl8365mb: add support for RTL8367SB

Miguel Ojeda (1):
      rust: allow `unknown_lints` in generated bindings for Rust < 1.88

Mika Westerberg (5):
      thunderbolt: Don't disable lane adapter if XDomain lane bonding isn't possible
      thunderbolt: Release request if tb_cfg_request() fails in __tb_xdomain_response()
      thunderbolt: Keep XDomain reference during the lifetime of a service
      thunderbolt: Keep the domain reference while processing hotplug
      thunderbolt: Set tb->root_switch to NULL when domain is stopped

Mike Snitzer (1):
      nfsd: disallow file locking and delegations for NFSv4 reexport

Miklos Szeredi (1):
      fuse: fix race between interrupt and resend

Milan P. Gandhi (2):
      scsi: mpi3mr: Fix NULL pointer dereference in mpi3mr_sas_port_add()
      scsi: mpi3mr: Fix target device refcount leak in mpi3mr_sas_port_add()

Minhong He (1):
      phonet: check register_netdevice_notifier() error in phonet_device_init()

Miri Korenblit (1):
      wifi: mac80211: don't call ieee80211_handle_reconfig_failure when not needed

Mohamed Khalfella (2):
      nvme-fc: Do not cancel requests in io target before it is initialized
      nvme: remove stale namespaces by NSID range during scan

Moritz Baron (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14IRH8

Moritz Tanner (1):
      fs: don't return -EINVAL for successful nested thaw

Mostafa Saleh (1):
      irqchip/gic-v4: Don't advertise VLPIs if no ITS is probed

Nagamani PV (1):
      s390/qeth: allow bridgeport queries despite OS_MISMATCH

Namjae Jeon (19):
      ksmbd: fix lease break and ack state handling
      ksmbd: validate SMB2 lease create contexts
      ksmbd: align SMB2 oplock break ack handling
      ksmbd: use connection ClientGUID for lease lookup
      ksmbd: treat unnamed DATA stream as base file
      ksmbd: apply create security descriptor first
      ksmbd: deny renaming directory with open children
      ksmbd: start file id allocation at 1
      ksmbd: break RH leases before delete-on-close
      ksmbd: treat read-control opens as stat opens only for leases
      ksmbd: fix credit charge calculation for SMB2 QUERY_INFO
      ksmbd: find bound sessions during reauthentication
      ksmbd: mark invalid session responses as signed
      ksmbd: validate SID namespace before mapping IDs
      ksmbd: preserve VFS inherited POSIX ACL mask
      ksmbd: use memcmp() to compare ClientGUIDs
      ksmbd: propagate DACL parsing errors
      ksmbd: rate limit unmapped SID errors
      ksmbd: prevent out-of-bounds reads in share config responses

Nathan Chancellor (1):
      scripts/sorttable: Mark long_size as __maybe_unused

Nazim Amirul (1):
      net: stmmac: xgmac2: disable RBUE in default RX interrupt mask

Neill Kapron (1):
      usb: gadget: f_fs: Fix Use-After-Free in AIO error path

Nicolai Buchwitz (1):
      net: macb: destroy the phylink instance on the probe error path

Nicolin Chen (1):
      iommu/tegra241-cmdqv: Publish an LVCMDQ only after it is fully initialized

Nikhil Chatterjee (1):
      HID: bpf: Add Huion Inspiroy Frego M button quirk

Nikhil Gurudasani (2):
      erofs: preserve LZMA decoders on resize failure
      erofs: skip sufficiently large global buffers when resizing

Nikhil P. Rao (4):
      pds_core: quiesce DMA before freeing resources
      ionic: use netif_txq_maybe_stop() in ionic_tx()
      pds_core: fix cmd_regs access racing BAR unmap on reset
      pds_core: don't release PCI regions for VFs on reset

Niklas Cassel (3):
      ata: libata-core: Disable LPM on some WD drives
      ata: libata-core: Disable LPM on WD Green 2.5 480GB
      ata: libata-core: Disable LPM on WDC WD141KFGX-68FH9N0

Niklas Neronin (3):
      usb: xhci: add USB Port Register Set struct
      usb: xhci: use cached HCSPARAMS1 value
      usb: xhci: simplify handling of Structural Parameters 1 values

Nikolay Aleksandrov (1):
      net: bridge: mcast: properly convert mglist to rcu

Nikolay Metchev (1):
      platform/x86: intel-hid: Add HP ProBook x360 440 G1 to button_array_table

Nils Helmig (1):
      Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV

Ning Ding (1):
      bpf: Reject untrusted allocated-object pointers

Norbert Szetei (1):
      net: openvswitch: fix use-after-free of the flow table mask array

Nuoqi Gui (1):
      bpf: Mask pseudo pointer values in verifier logs

Olga Kornievskaia (1):
      nfsd: update mtime/ctime on COPY in presence of delegated attributes

Oliver Neukum (1):
      usb: core: hcd: fix possible deadlock in rh control transfers

Osama Abdelkader (2):
      mmc: davinci: fix mmc_add_host order in probe
      riscv: panic if IRQ handler stacks cannot be allocated

Oscar Salvador (1):
      mm, hugetlb: increment the number of pages to be reset on HVO

Ovidiu Bunea (1):
      drm/amd/display: Find link encoder for flexible DIG mapping cases

Pagadala Yesu Anjaneyulu (1):
      wifi: mac80211: ibss: wait for in-flight TX on disconnect

Pali Rohár (2):
      cifs: Fix support for creating SFU socket
      cifs: Fix support for creating SFU fifo

Panagiotis Petrakopoulos (1):
      wifi: rtw88: Add NULL check for chip->edcca_th in rtw_fw_adaptivity_result()

Paolo Abeni (4):
      mptcp: remove unneeded READ_ONCE() annotation
      mptcp: avoid unneeded actions on subflow reset
      mptcp: close race between scheduler and state change
      mptcp: fix bad accounting in __mptcp_subflow_push_pending()

Parth Pancholi (1):
      drm/bridge: tc358768: Set pre_enable_prev_first for reverse order

Pauli Virtanen (4):
      Bluetooth: ISO: fix malformed ISO_END/CONT handling
      Bluetooth: L2CAP: fix chan mode for LE_CONN_REQ + EXT_FLOWCTL pchan
      Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect
      Bluetooth: L2CAP: clear FLAG_DEFER_SETUP only for same PID/PSM

Paulo Alcantara (3):
      smb: client: fix one-byte OOB read in smb2_parse_native_symlink()
      smb: client: fix file type corruption in cifs_reparse_point_to_fattr()
      smb: client: fix file type corruption in wsl_to_fattr()

Pengpeng Hou (10):
      soundwire: validate DT compatible before parsing it
      drivers/of: validate status properties in reconfig state changes
      regulator: da9121: Use subvariant ids in the I2C table
      ALSA: usb-audio: caiaq: validate EP1 reply lengths
      wifi: rsi: avoid reading TKIP MIC keys for non-TKIP ciphers
      wifi: libertas: reject short monitor TX frames
      wifi: libipw: fix key index receive bound checks
      wifi: rsi: validate beacon length before fixed buffer copy
      drm/gma500: return errors from Oaktrail HDMI I2C reads
      hwmon: (aspeed-pwm-tacho) Propagate reset deassert errors

Perry Yuan (1):
      drm/amdgpu: flush pending RCU callbacks on module unload

Peter Ujfalusi (1):
      soundwire: intel: Move suspend tracking from trigger to pm suspend

Peter Zijlstra (1):
      perf: Fix addr_filter_ranges lifetime

Pierre Barre (2):
      9p: invalidate readdir buffer on seek
      9p: use kvzalloc for readdir buffer

Ping-Ke Shih (1):
      wifi: rtw89: phy: check length before parsing PHY status IE

Piotr Kubik (1):
      leds: trigger: gpio: Use GPIOD_FLAGS_BIT_NONEXCLUSIVE

Pooja Katiyar (1):
      thunderbolt: Don't access path config space on Lane 1 adapters in tb_switch_reset_host()

Potin Lai (1):
      hwmon: (pmbus/lm25066) Fix PMBus coefficients for LM5064/5066/5066i

Praveen Talari (1):
      spi: core: Abort active target transfer on controller suspend

Priyansh Jain (1):
      thermal/drivers/qcom/tsens: Atomic temperature read with hardware-guided retries

Pu Hu (1):
      arm64: kprobes: Allow reentering kprobes while single-stepping

Qiang Liu (3):
      ksmbd: fix sd_ndr.data memory leak in ksmbd_vfs_set_sd_xattr
      ksmbd: fix n.data memory leak in ksmbd_vfs_set_dos_attrib_xattr
      ksmbd: Fix acl.sd_buf memory leak and invalid sd_size error handling

Qingfang Deng (3):
      ppp: ppp_async: simplify tty disc_data access
      ppp: ppp_synctty: simplify tty disc_data access
      ppp_synctty: ensure a writeable skb header

Qingyu Zhang (1):
      ALSA: ump: do not touch legacy_rmidi before it exists

Qiuxu Zhuo (3):
      EDAC/igen6: Fix interleave boundary condition
      EDAC/igen6: Fix channel selection hash
      EDAC/igen6: Fix channel address decode for non-hash mode

Qu Wenruo (6):
      btrfs: fix the possible bioc_list memory leak during error
      btrfs: return proper negative error code for update_raid_extent_item()
      btrfs: do not force reloc root creation during qgroup_account_snapshot()
      btrfs: expose per-inode stable writes flag
      btrfs: prepare btrfs_punch_hole_lock_range() for large data folios
      btrfs: do not overwrite NODATASUM flag when removing NODATACOW flag

Raf Dickson (1):
      vsock: use sk_acceptq_is_full() helper in all transports

Rafael J. Wysocki (3):
      ACPI: TAD: Rearrange RT data validation checking
      ACPI: TAD: Split three functions to untangle runtime PM handling
      ACPI: TAD: Add locking around AML evaluations

Ranjani Vaidyanathan (1):
      watchdog: imx7ulp_wdt: Keep WDOG running until A55 enters WFI on i.MX94

Ratheesh Kannoth (2):
      octeontx2-pf: reset HTB scheduler topology before freeing queues
      octeontx2-af: fix PF/CGX debugfs PCI bus lookup

Ravindra (1):
      Bluetooth: btusb: Add support for Intel Lizard Peak 2 (0x8087:0x0040)

Ricardo Ribalda (1):
      media: chips-media: wave5: Add range checks for dec_output_info

Riccardo Boninsegna (1):
      media: rc: mceusb: Add support for 04eb:e033

Richard Fitzgerald (1):
      ALSA: hda: cs35l56: Fail if wmfw file is missing

Rik van Riel (1):
      perf/ftrace: Fix WARNING in __unregister_ftrace_function

Rob Herring (Arm) (1):
      gpio: pisosr: Read "ngpios" as u32

Robert Abrahamse (1):
      ALSA: usb-audio: Add quirk for Corsair Virtuoso (later revision)

Roger Pau Monne (2):
      xen/balloon: improve accuracy of initial balloon target for dom0
      x86/xen: fix init of balloon stats again

Rohit Sinha (1):
      ALSA: hda/realtek - Add quirk for HP Victus 15-fa0xxx (MB 8A50)

Roman Prucha (1):
      ALSA: ctxfi: Fix CA20K2 S/PDIF passthrough

Rong Zhang (2):
      Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925
      Bluetooth: btrtl: Don't leak return code when parsing firmware format v2

Rosalie Wanders (1):
      HID: sony: use guard() and scoped_guard()

Rosen Penev (7):
      mips: cps: Assemble jr.hb with an R2 ISA level
      net: ibm: emac: Reserve VLAN header in MJS limit
      ipmi: si: Use platform_get_irq_optional() to retrieve interrupt
      netfilter: nf_conntrack: use get_unaligned_be32() in tcp_sack()
      net: ibm: emac: mal: fix potential system hang in mal_remove()
      sparc64: uprobes: add missing break
      sparc: Disable compat support with LLD

Rudi Heitbaum (1):
      ASoC: rt5645: Perform the initial jack detect at probe

Runyu Xiao (4):
      ipv6: use READ_ONCE() for bindv6only default in inet6_create()
      net: au1000: move free_irq out of the close-time spinlocked section
      ASoC: sti: initialize IRQ lock before requesting IRQ
      cpufreq: initialize policy rwsem before sysfs publication

Ruoyu Wang (2):
      crypto: ixp4xx - fix buffer chain unwind on allocation failure
      ALSA: es18xx: check control allocation before private data setup

Russell King (Oracle) (4):
      ARM: ensure interrupts are enabled in __do_user_fault()
      net: stmmac: fix TSO support when some channels have TBS available
      net: stmmac: add stmmac_tso_header_size()
      net: stmmac: add TSO check for header length

SJ Park (1):
      mm/damon/core: avoid infinite kdamond_merge_regions() internal loop

Sahil Chandna (1):
      net: mana: Reserve extra CQ slot for the fence completion CQE

Sam Edwards (1):
      ceph: properly decrypt filenames in vmalloc() buffers

Samson Tam (1):
      drm/amd/display: Check for sharpening case when calculating max vtaps for scaler

Samuel Moelius (2):
      Bluetooth: L2CAP: validate connectionless PSM length
      f2fs: validate inline dentry name lengths before conversion

Sanjay Chitroda (1):
      iio: accel: mma8452: switch to non-devm request_threaded_irq()

Saravana Kannan (1):
      of: dynamic: Fix overlayed devices not probing because of fw_devlink

Sasha Levin (19):
      Revert "bpf, s390: Clear fetch destination on faulting arena atomic"
      Revert "ARM: 9481/2: breakpoint: CFI breakpoints only on demand"
      Revert "arm64: dts: qcom: sm8650: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sm8550: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sm8450: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sm8350: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sm8250: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sm8150: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sdm845: Fix the PCIe iommu-map entries"
      Revert "arm64: dts: qcom: sc8180x: Fix the PCIe iommu-map entries"
      Revert "nvme-apple: Reset q->sq_tail during queue init"
      Revert "nvme-apple: Prevent shared tags across queues on Apple A11"
      Revert "nvme-apple: Drop the PRP null check chicken bit"
      Revert "nvme: apple: Add Apple A11 support"
      Revert "selftests: harness: Mark test fixture objects __maybe_unused"
      Revert "selftests/mm: skip COW tmpfile cases when fallocate() is unsupported"
      Revert "selftests/mm: report unique test names for each cow test"
      Revert "slab: reset slab->obj_ext when freeing and it is OBJEXTS_ALLOC_FAIL"
      Revert "perf tests: Fix flakiness in BPF counters test on hybrid systems"

Sean Christopherson (8):
      KVM: SEV: Wire up kvm_x86_ops.gmem_xxx() if and only if CONFIG_KVM_AMD_SEV=y
      KVM: SEV: Make it more obvious when KVM is writing back the current PSC index
      KVM: SEV: Add an anonymous "psc" struct to track current PSC metadata
      KVM: SVM: Mark VMCB dirty before processing incoming snp_vmsa_gpa
      KVM: SVM: Use guard(mutex) to simplify SNP vCPU state updates
      KVM: SVM: Invalidate "next" SNP VMSA GPA even on failure
      KVM: SVM: Move SEV-ES VMSA allocation to a dedicated sev_vcpu_create() helper
      KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP guests

Sebastian Andrzej Siewior (4):
      mailbox: imx: Use devm_pm_runtime_enable()
      mailbox: imx: Add a channel shutdown field
      mailbox: imx: use devm_of_platform_populate()
      ring-buffer: Acquire the lock with irqsave in rb_wake_up_waiters()

Selvamani Rajagopal (5):
      net: ethernet: oa_tc6: Interrupt is active low, level triggered.
      net: ethernet: oa_tc6: Protect skb pointer used by two different kernel instances
      net: ethernet: oa_tc6: Improve the error recovery
      net: ethernet: oa_tc6: Disable tx queues on fatal error
      net: ethernet: oa_tc6: Fix for the wrong data type

Selvin Xavier (1):
      RDMA/bnxt_re: Proper rollback if the ioremap fails

Sergey Senozhatsky (5):
      zram: fixup read_block_state()
      zram: remove entry element member
      zram: use zram_read_from_zspool() in writeback
      zram: switch to guard() for init_lock
      zram: set default primary compressor in zram_destroy_comps()

Seungwon Bae (1):
      vxlan: reject dynamic fdb entries that reference a nexthop id

Shahar Shitrit (1):
      net/mlx5e: Fix setting RS FEC after remapping

Shawn Lin (1):
      mmc: core: Add validation for host-provided max_segs

Shay Drory (2):
      net/mlx5e: Verify unique vhca_id count instead of range
      net/mlx5: E-Switch, align disable sequence with switchdev-to-legacy transition

Shengjiu Wang (1):
      ASoC: fsl-asoc-card: reduce WM8904 PLL ratio to meet frequency limit

Shivaprasad G Bhat (1):
      powerpc/eeh: Fix recursive locking on devices without EEH sensitive driver

Shiwu Zhang (1):
      drm/amdgpu: fix buffer overflow during vBIOS update

Shuangpeng Bai (2):
      btrfs: fix transaction use-after-free in raid stripe insertion
      btrfs: fix extent map leak in NOCOW direct I/O write

Shubham Chakraborty (1):
      hwmon: (raspberrypi) Fix delayed-work teardown race

Shubham Nayak (1):
      ALSA: hda/realtek: Add quirk for HP Victus 16-e0xxx (88EE) to enable mute LED

Siew Chin Lim (1):
      firmware: stratix10-svc: change get provision data to async SMC call

Simon Xue (1):
      iommu/rockchip: disable fetch dte time limit

SkyLake.Huang (1):
      net: phy: mediatek: Re-organize MediaTek ethernet phy drivers

Slawomir Stepien (1):
      drm/cirrus-qemu: Validate BAR0 size during probe

Smita Koralahalli (2):
      efi/cper, cxl: Prefix protocol error struct and function names with cxl_
      efi/cper, cxl: Make definitions and structures global

Sophie D (1):
      drm/gud: Add RCade Display Adapter VID/PID pair

Srinivas Kandagatla (1):
      ASoC: qcom: q6apm: return error code to consumers on failures

Stanley.Yang (1):
      drm/amdgpu: harden FRU PIA parsing with bounded helpers

Stefan Berger (1):
      integrity: Check for NULL returned by asymmetric_key_public_key

Stepan Ionichev (3):
      mmc: davinci: avoid NULL deref of host->data in IRQ handler
      usb: gadget: goku_udc: avoid NULL deref of dev->driver in INT_USBRESET log
      iio: adc: qcom-spmi-iadc: balance enable_irq_wake() on driver unbind

Steven Rostedt (1):
      ring-buffer: Add checking nr_subbufs to persistent ring buffer validation

Stian Halseth (1):
      sunvdc: unmap LDC cookies when the descriptor send fails

Sudeep Holla (2):
      firmware: arm_scmi: Validate SENSOR_UPDATE payload size
      firmware: arm_scmi: Validate BASE_ERROR_EVENT payload size

Sumeet Pawnikar (1):
      powercap: intel_rapl: Fix memory leak in rapl_add_package_cpuslocked()

Sunday Clement (1):
      drm/amdkfd: Fix OOB memory exposure in get_wave_state()

Sunil Goutham (1):
      octeontx2-af: Fix limiting SRIOV VF count logic

Sunil Khatri (1):
      drm/drm_exec: fix up contended obj when num_objects is 0

Takashi Iwai (11):
      ALSA: hda/realtek: Add quirk for HP Pavilion x360
      ALSA: hda/core: Use guard() for mutex locks
      ALSA: rawmidi: Expose the tied device number in info ioctl
      ALSA: rawmidi: Show substream activity in info ioctl
      ALSA: ump: Copy FB name string more safely
      ALSA: ump: Copy safe string name to rawmidi
      ALSA: ump: Update rawmidi name per EP name update
      ALSA: caiaq: Fix potential double-free at error path
      ALSA: hda: Introduce auto cleanup macros for PM
      ALSA: hda/common: Use cleanup macros for PM controls
      ALSA: hda/common: Use guard() for mutex locks

Tao Cui (1):
      blk-cgroup: fix leaks and online flag on radix_tree_insert failure

Tejun Heo (1):
      sched_ext: Fix inverted ops.core_sched_before() invocation

Terry Bowman (5):
      cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
      cxl/pci: Remove unnecessary CXL RCH handling helper functions
      cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER register read
      acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks
      cxl/ras: Fix cxl_rch_get_aer_severity() wrong severity register

Thibault Ferrante (1):
      selftests/powerpc/tm: Fix tcheck() reading uninitialised CR value

Thiyagarajan Pandiyan (1):
      wifi: nl80211: Increase ie_len size to prevent truncated IEs in new peer notifications

Thomas Gleixner (1):
      tick/broadcast: Plug clockevents replacement race

Thomas Lin (1):
      spi: dw-mmio: Add ACPI ID LECA0002 for LECARC SoCs

Thomas Richter (1):
      perf/core: Allow list_del during perf_event_overflow()

Thomas Weißschuh (1):
      tools/nolibc: avoid call to wcslen() in _start_c() inserted by clang

Thomas Zimmermann (1):
      drm/cirrus: Use video aperture helpers

Thorsten Blum (7):
      crypto: omap - add omap_des_unregister_algs helper
      crypto: atmel-ecc - add support for atecc608b
      crypto: atmel-sha204a - remove sysfs group before hwrng
      powerpc/kexec_file: Use inclusive range checks in add_usable_mem()
      powerpc/ps3: Fix repository.c build failure
      drm/i915: Fix memory leak in query_perf_config_list()
      crypto: atmel-ecc - avoid stale fallback key after set_secret failure

Théo Lebrun (1):
      net: macb: rename bp->sgmii_phy field to bp->phy

Tianchu Chen (1):
      ASoC: sprd: validate compress buffer sizes against fixed allocations

Tianze Shao (1):
      ASoC: rt712-sdca: reset codec at io_init to fix silent headphone

Tiezhu Yang (1):
      libbpf: Add __NR_bpf definition for LoongArch

Timur Kristóf (2):
      drm/amdgpu: Use system unbound workqueue for soft IH ring
      drm/amd/pm/si: Don't schedule thermal work when queue isn't initialized

Timur Tabi (1):
      drm/nouveau/bios: skip the IFR header if present

Tobias Deiminger (1):
      leds: pca9532: Don't stop blinking for non-zero brightness

Tom Chung (1):
      drm/amd/display: Fix CRC open failure during active rendering

Tommaso Merciai (1):
      drm: rz-du: Ensure correct suspend/resume ordering with VSP

Tommy Huang (1):
      rtc: aspeed: add AST2700 compatible

Tristan Madani (2):
      ALSA: usbusx2y: fix in04_last array size mismatch with in04_buf
      ALSA: usbusx2y: validate URB actual_length in interrupt callback

Tung Nguyen (1):
      tipc: fix NULL deref in tipc_named_node_up() on empty publication list

Tuo Li (1):
      ASoC: mediatek: mt8365-afe-pcm: fix possible NULL-pointer dereferences in mt8365_afe_suspend()

Tze Yee Ng (1):
      dmaengine: dw-axi-dmac: fix PM for system sleep and channel alloc

Tzung-Bi Shih (8):
      platform/chrome: Resolve kb_wake_angle visibility race
      watchdog: msc313e: Fix NULL pointer dereference in PM callbacks
      watchdog: msc313e: Avoid division by zero
      watchdog: msc313e: Fix clock leak and spurious timer in settimeout()
      watchdog: msc313e: Enable clock before accessing hardware registers
      watchdog: msc313e: Fix spurious reset on suspend
      watchdog: msc313e: Fix undefined behavior
      watchdog: msc313e: Sync timeout value if WDT was running at boot

Ulf Hansson (1):
      driver core: Export get_dev_from_fwnode()

Uros Bizjak (1):
      x86/locking: Remove semicolon from "lock" prefix

Uwe Küchler (1):
      ALSA: usb-audio: Add quirk for Novation Mininova

Vadim Fedorenko (2):
      spi: xilinx: let transfers timeout in case of no IRQ
      ptp: ocp: add shutdown callback

Vaibhav Jain (1):
      powerpc/pseries: Ensure vpa,slb_shadow & dtl are unregistered during crash

Vamsi Attunuru (1):
      vdpa/octeon_ep: Use 4 bytes for mailbox signature

Vasily Gorbik (3):
      s390/ipl: Fix NULL deref in kdump without re-IPL parm block
      s390/ipl: Fix NULL deref in dump_reipl without re-IPL parm block
      s390/boot: Fix physical memory search range

Venkat Rao Bagalkote (1):
      char/nvram: Remove redundant nvram_mutex

Vernon Yang (1):
      x86/mm: Fix user-space data loss with MADV_FREE and THP

Viacheslav Dubeyko (3):
      hfsplus: fix issue of direct writes beyond end-of-file
      hfsplus: rework hfsplus_readdir() logic
      hfs: rework hfsplus_readdir() logic

Victor Nogueira (6):
      net/sched: act_api: budget all shared attributes in notify skbs
      net/sched: act_api: size the RTM_GETACTION reply from the actions
      net/sched: act_api: fix skb sizing and action leak on reoffload delete
      net/sched: cls_route: free emptied bucket on filter move
      net/sched: cls_route: Reject handle aliasing
      net/sched: cls_route: Fix in-place replace

Viken Dadhaniya (1):
      spi: spi-qcom-qspi: Fix incomplete error handling in runtime PM

Viktor Menshin (1):
      ALSA: hda/realtek: Add quirk for Lenovo Xiaoxin 14 GT

Vineeth Karumanchi (1):
      net: macb: fix NULL pointer dereference on unbind with fixed-link

Vineeth Vijayan (1):
      s390/cio: Purge based on the cdev's online status

Vinicius Costa Gomes (1):
      crypto: iaa - unmap dst before software fallback on decompress

Vishnu Razdan (1):
      hwmon: (pmbus) Clear generic status alarms with CLEAR_FAULTS

Viswajith Murali (1):
      octeontx2-af: mcs: Clear stale X2P calibration state before calibration

Vladislav Karmanov (1):
      net: phy: mediatek-ge: disable EEE on the MT7530 PHY

Vlastimil Babka (1):
      mm/slab: move and refactor __kmem_cache_alias()

Vlatko Kosturjak (1):
      ppp_async: drop the errored frame instead of resetting its headroom

Wang YuWei (1):
      spi: dw-dma: Wait for controller idle before completing Tx

Wanwu Li (1):
      sched_ext: Fix timer pinning and return value in scx_central

Wei Qisen (1):
      net: sfp: add quirk for OEM 2.5G optical modules

Weiming Shi (6):
      ACPICA: Fix NULL pointer dereference in acpi_ns_custom_package()
      btrfs: tree-checker: validate INODE_REF's namelen
      net/sched: defer qdisc freeing after failed creation
      fbdev: vfb: defer cleanup until the last reference
      i2c: smbus: reject oversized block transfers in the common path
      net: appletalk: fix NULL pointer dereference in aarp_send_ddp()

Wentao Liang (1):
      net: qrtr: fix node refcount leak on ctrl packet alloc failure

Xiaogang Chen (2):
      drm/amdkfd: Let driver decide buffer size at AMDKFD_IOC_GET_DMABUF_INFO ioctl
      drm/amdkfd: check find_first_zero_bit before __set_bit on kfd->doorbell_bitmap

Xie Yuanbin (1):
      ARM: 9484/1: enable interrupts when unhandled user faults are triggered

Xin Long (2):
      sctp: fix err_chunk memory leaks in INIT handling
      sctp: fix a TOCTOU race in SCTP_CMD_TIMER_START

XingWang Xiang (1):
      net: mctp: i3c: serialize probe with bus removal

Xiong Weimin (3):
      virtio_input: reset device if input_register_device() fails
      vdpa: ifcvf: Put device on unsupported feature error
      vdpa: solidrun: Free IRQs after request failure

Xixin Liu (6):
      nvme-rdma: fix -EIO cleanup order in queue_rq
      nvmet-rdma: fix queue leak when connect backlog is exceeded
      perf: RISC-V: check cpu_hw_evt before dereference in overflow IRQ
      nvme-tcp: defer TLS inline send to io_work
      perf: RISC-V: store available counter mask as bitmap
      perf: RISC-V: use BIT_ULL for u64 overflow masks

Xu Rao (3):
      ata: libata-pmp: add JMicron JMS562 quirk
      ALSA: hda: restore MFG widget enumeration after core split
      Bluetooth: btqcomsmd: destroy RPMsg endpoints before freeing hci_dev

Xu Yang (1):
      usb: gadget: udc: skip pullup() if already connected

Xuanqiang Luo (3):
      raw: annotate disconnect-side IPv4 match writers
      net/sched: act_api: release all action references on NEWACTION failure
      fou: Fix use-after-free in fou_create()

Xue Lei (1):
      rtc: mv: add suspend/resume support for wakeup

Yabin Cui (1):
      perf/core: Check sample_type in perf_sample_save_callchain

Yael Chemla (1):
      net/mlx5: E-Switch: fix use-after-free in mlx5_eswitch_termtbl_put

Yao Sang (1):
      nvme: refresh multipath head zoned limits from path limits

Yao Zi (1):
      x86/locking: Use sfence for wmb() if SSE is available

Yazen Ghannam (1):
      RAS/AMD/ATL, EDAC/amd64: Only load ATL when needed

Yehyeong Lee (1):
      net: drop_monitor: fix info leak in NET_DM_ATTR_PAYLOAD

Yevgeny Kliteynik (1):
      net/mlx5: HWS, Handle destroying table that has a miss table

Yicong Hui (1):
      net/micrel: Fix typos in micrel driver code comments

Yilin Zhang (2):
      ALSA: pcm: Serialize PCM mmap with buffer reallocation to fix page UAF
      inet: frags: invalidate queues before flushing them

Yong Wang (1):
      tcp: clamp route advmss to TCP_MIN_MSS

Yongqiang Sun (1):
      drm/amdkfd: Unwind debug trap enable on copy_to_user failure

Yousef Alhouseen (3):
      leds: uleds: Return -EFAULT on copy_to_user() failure
      xen/front-pgdir-shbuf: free grant reference head on errors
      xen/gntalloc: validate grant count before allocation

Youssef Samir (1):
      accel/qaic: Address potential out-of-bounds read in resp_worker()

Yu Kuai (2):
      md/raid5: account discard IO
      blk-cgroup: protect iterating blkgs with blkcg->lock in blkcg_print_stat()

Yu Peng (1):
      arm64: fixmap: Allow 256K early_ioremap() at any offset

Yu Zhang (2):
      vhost-vdpa: don't install the eventfd_ctx_fdget() error in config_ctx
      vhost-vdpa: protect config_ctx from being freed under the config callback

Yue Haibing (1):
      ipv6: annotate data-races around devconf->rpl_seg_enabled

Yuho Choi (1):
      sctp: Unwind address notifier registration on failure

Yung-Tse Cheng (1):
      virtio-fs: avoid double-free on failed queue setup

Yuqi Xu (1):
      wifi: cfg80211: reject duplicate wiphy cipher suite entries

Yury Norov (1):
      bitfield: wire __bf_shf to __builtin_ctzll

Zhang Cen (1):
      btrfs: tree-checker: validate names in ROOT_REF and ROOT_BACKREF

Zhang Heng (2):
      ALSA: hda/realtek: Add HDA_CODEC_QUIRK for Samsung 750XBE/730XBE
      ASoC: amd: yc: Add DMI quirk for HP Victus Laptop 16-e1xxx

Zhang Tianci (1):
      fuse: set ff->flock only on success

ZhangGuoDong (1):
      smb: move copychunk definitions to common/smb2pdu.h

Zhao Li (3):
      wifi: mac80211: validate deauth frame length before reason access
      wifi: cfg80211: validate assoc response length before status and IE access
      wifi: cfg80211: validate rx/tx MLME callback frame lengths before access

Zhaoyang Yu (1):
      media: dm1105: fix missing error check for dma_alloc_coherent

ZhengYuan Huang (3):
      fs/ntfs3: preserve non-DOS attribute bits in system.dos_attrib
      fs/ntfs3: validate index entry key bounds
      btrfs: balance: fix potential bg lookup failure in btrfs_may_alloc_data_chunk()

Zhiling Zou (2):
      ieee802154: 6lowpan: fix NULL dereference in lowpan_newlink
      ip: orphan prefetched skbs before multicast forwarding

Zhongqiu Han (1):
      cpufreq: zero-initialize policy cpumask before sysfs publication

Zihan Xi (2):
      ipv6: fix fib6 walker UAF on seq stop
      ipv4: fib: bound automatic table ID allocation

Zijun Hu (2):
      mfd: db8500-prcmu: Remove needless return in three void APIs
      libnvdimm: Replace namespace_match() with device_find_child_by_name()

Ziyi Guo (1):
      dlm: add usercopy whitelist to dlm_cb cache

Zizhi Wo (1):
      scsi: core: Do not block on tag allocation in scsi_eh_lock_door()

Zqiang (1):
      rcu-tasks: Fix possible boot-time tests failed for the call_rcu_tasks()

bui duc phuc (3):
      ASoC: rockchip: rockchip_pdm: Handle runtime PM resume failures in set_fmt
      ASoC: rockchip: rockchip_pdm: Reorder clock enable sequence
      ASoC: rockchip: spdif: Restore regcache cache-only mode on sync failure

chunzhi.lin (1):
      net: phy: motorcomm: use device properties for firmware tuning

gao xu (1):
      mm: fix possible NULL pointer dereference in __swap_duplicate

guoqi0226 (1):
      spi: Add NULL check for spi_get_device_id() in spi_get_device_match_data()

hpp.iscas (3):
      ASoC: bcm: bcm63xx: Publish the OF module aliases
      ASoC: Intel: SST: Publish the PCI module aliases
      ASoC: mt6351: Publish the OF module alias

ikaros (13):
      ACPICA: Fix condition check in acpi_ps_parse_loop()
      ACPICA: Fix use-after-free in acpi_ds_terminate_control_method()
      ACPICA: add boundary checks in acpi_ps_get_next_field()
      ACPICA: validate byte_count in acpi_ps_get_next_package_length()
      ACPICA: Prevent adding invalid references
      ACPICA: Fix integer overflow in acpi_ex_opcode_3A_1T_1R() (mid_op)
      ACPICA: Improve argument parsing in acpi_ps_get_next_simple_arg()
      ACPICA: validate handler object type in two places
      ACPICA: Add package limit checks in parser functions
      ACPICA: Add validation for node in acpi_ns_build_normalized_path()
      ACPICA: Enhance OEM ID and Table ID validation in acpi_ex_load_table_op()
      ACPICA: Enhance buffer validation in acpi_ut_walk_aml_resources()
      ACPICA: add boundary checks in two places

leixiang (1):
      KVM: PPC: Book3S HV: Set irqfd->producer only on success

liyouhong (1):
      ata: ahci: fail probe if BAR too small for claimed ports

shayderrr (1):
      host1x: bus: Fix missing ops null check in error teardown

wangdicheng (2):
      ASoC: amd: renoir: fix disable_pdm_interrupts() to clear mask bits
      ASoC: amd: yc: fix memory leak in acp6x_pdm_dma_close()

