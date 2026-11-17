Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912349;
	b=RPNApVoRIisleCS2t9+uC7KJ9WAGYrqkFALdstW0KbLhyUweQrsR+a7sKa/YO6TDQdQv
	 WgKdF/U4C36nj9rYbTQdsRGeOuSC+1xrWrjT8uMSis4LAoGOah0c54Pyur1Pn4eFkkF5c
	 Lzyd9dA+3ju3W3to5LgDIiwcx/46YLJTKLQvgxSu/ChRTn4YAWhczpwEXTBaLsiO2Hg0k
	 ZYhPm9ycKUenjStqeDWXjjSWRNiWnPm5XwG0H9+UtzlJMcqpQ9Sk9RGvFVvZPPj+eTI9s
	 RFHC/W9flyrXjvw60kHqKwfvwqpCpoDJsAAN+xYBlBIuzKM6agAdqtT6Go0MkDN3wqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912349;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RcxAkgS4tT240YnzLZWDSXhixXnU9TzZymxwuQcavIY=;
	b=Gvr+FO4vhRVLHNkab7RCaapt2DYz10kj35XBnV1fiGQ3Hd3CmTItbhlXhVNVN2+QWq4D
	 lyfO0unHBCZtJtCRF6EeJMiAZ5QFYGB+hfweyEOD17LePq9Yo2LGZJv3Uw8OusXdp+ULr
	 L6OnLndqQUM5ZbbmrNag5lkzh8lumh39D0q/6SFNcBFVrJ1d/Vj6f7IKWOl8OkkE/abMt
	 mwjGNFviSgNIumgjv9xNXwB3YCqq3rZHUxjm03P/myfoGEiac/l+S6A4b3zw/VgJOW8YL
	 Dhmbuha8nkV00PpG2NxAXQjFwmM6GaBALvXyHfu7lioRv2WmrkA5pr3Y5NJuGVrJLFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XCp5FyTA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1E1606A323;
	Tue, 17 Nov 2026 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XCp5FyTA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD35D1F000CA;
	Tue, 17 Nov 2026 10:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794912348;
	bh=RcxAkgS4tT240YnzLZWDSXhixXnU9TzZymxwuQcavIY=;
	h=From:To:Cc:Subject:Date;
	b=XCp5FyTAj58bsG1JUBGQVsHQUYc2gatdfTZLERLxwC7WE4wHmdZpyL4k9aSBceFj5
	 L3IEZ0BpHnXh42K0ZeIUD/vxCjprfg/GO3DHKR83EV63j9hNtA//gVB4G4l2ohTI3e
	 deMls7vJy4BMJLZ9wvSkYVAlOqS8QoF0Ngy9xFtg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.64
Date: Tue, 17 Nov 2026 11:45:16 +0100
Message-ID: <2026111716-overstate-decal-eac4@gregkh>
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

I'm announcing the release of the 6.18.64 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.rst                    |   97 -
 Documentation/admin-guide/kernel-parameters.txt                    |  109 +
 Documentation/filesystems/fsverity.rst                             |    3 
 Documentation/filesystems/overlayfs.rst                            |    3 
 Documentation/filesystems/resctrl.rst                              |   87 
 Documentation/hwmon/coretemp.rst                                   |    3 
 MAINTAINERS                                                        |    2 
 Makefile                                                           |    2 
 arch/arm64/Kconfig                                                 |    1 
 arch/arm64/include/asm/sdei.h                                      |    3 
 arch/arm64/include/asm/suspend.h                                   |    2 
 arch/arm64/kernel/entry-common.c                                   |   40 
 arch/arm64/kernel/machine_kexec_file.c                             |    2 
 arch/arm64/kernel/process.c                                        |   17 
 arch/arm64/kernel/sdei.c                                           |   59 
 arch/arm64/kernel/topology.c                                       |   13 
 arch/arm64/kvm/arch_timer.c                                        |   27 
 arch/arm64/kvm/arm.c                                               |    4 
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                                 |   28 
 arch/arm64/kvm/hyp/vhe/switch.c                                    |   11 
 arch/arm64/kvm/mmu.c                                               |    4 
 arch/arm64/kvm/nested.c                                            |   10 
 arch/arm64/kvm/ptdump.c                                            |   50 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                 |   10 
 arch/arm64/kvm/vgic/vgic.c                                         |   11 
 arch/arm64/mm/mmap.c                                               |    4 
 arch/arm64/mm/proc.S                                               |    8 
 arch/loongarch/include/asm/hw_breakpoint.h                         |    4 
 arch/loongarch/include/asm/loongarch.h                             |    3 
 arch/loongarch/include/asm/processor.h                             |    1 
 arch/loongarch/include/asm/switch_to.h                             |    2 
 arch/loongarch/kernel/hw_breakpoint.c                              |   39 
 arch/loongarch/kernel/numa.c                                       |    8 
 arch/m68k/68000/entry.S                                            |   24 
 arch/m68k/coldfire/entry.S                                         |    3 
 arch/mips/mm/cex-gen.S                                             |   16 
 arch/mips/pci/ops-mace.c                                           |   26 
 arch/mips/pci/pci-ip32.c                                           |    9 
 arch/mips/sgi-ip32/ip32-irq.c                                      |   45 
 arch/openrisc/kernel/or32_ksyms.c                                  |    1 
 arch/powerpc/net/bpf_jit.h                                         |    7 
 arch/powerpc/net/bpf_jit_comp.c                                    |   35 
 arch/powerpc/platforms/pseries/iommu.c                             |   67 
 arch/s390/pci/pci_irq.c                                            |   26 
 arch/x86/boot/startup/sme.c                                        |    2 
 arch/x86/include/asm/vmware.h                                      |   24 
 arch/x86/include/asm/xor_avx.h                                     |    4 
 arch/x86/kernel/acpi/cppc.c                                        |   15 
 arch/x86/kernel/cpu/amd.c                                          |    1 
 arch/x86/kernel/cpu/bugs.c                                         |   12 
 arch/x86/kernel/cpu/resctrl/internal.h                             |    4 
 arch/x86/kernel/cpu/resctrl/monitor.c                              |    4 
 arch/x86/kernel/nmi.c                                              |    8 
 arch/x86/kernel/x86_init.c                                         |    2 
 arch/x86/kvm/mmu/mmu.c                                             |   10 
 arch/x86/kvm/mmu/paging_tmpl.h                                     |   11 
 arch/x86/kvm/svm/nested.c                                          |    1 
 arch/x86/kvm/vmx/nested.c                                          |    1 
 arch/x86/kvm/vmx/tdx.c                                             |   42 
 arch/x86/kvm/x86.c                                                 |   31 
 arch/x86/mm/tlb.c                                                  |   16 
 block/blk-iocost.c                                                 |    3 
 block/blk-mq.c                                                     |   13 
 block/bsg.c                                                        |    5 
 block/ioctl.c                                                      |    4 
 drivers/acpi/apei/ghes.c                                           |    6 
 drivers/acpi/cppc_acpi.c                                           |   58 
 drivers/acpi/riscv/cppc.c                                          |   26 
 drivers/ata/Kconfig                                                |    7 
 drivers/ata/Makefile                                               |    1 
 drivers/ata/libata-eh.c                                            |    6 
 drivers/ata/libata-pmp.c                                           |   16 
 drivers/ata/libata-scsi.c                                          |   25 
 drivers/ata/libata.h                                               |    4 
 drivers/ata/sata_inic162x.c                                        |  902 ----------
 drivers/base/devtmpfs.c                                            |  108 -
 drivers/block/ublk_drv.c                                           |   60 
 drivers/block/virtio_blk.c                                         |    2 
 drivers/bluetooth/btqca.c                                          |    3 
 drivers/char/hw_random/virtio-rng.c                                |    7 
 drivers/char/tpm/tpm2-cmd.c                                        |    3 
 drivers/clk/nuvoton/clk-ma35d1.c                                   |    7 
 drivers/cpufreq/amd-pstate.c                                       |   25 
 drivers/crypto/omap-sham.c                                         |   28 
 drivers/crypto/sa2ul.c                                             |  121 -
 drivers/cxl/core/features.c                                        |    2 
 drivers/cxl/core/mbox.c                                            |    8 
 drivers/cxl/core/port.c                                            |   60 
 drivers/dma/qcom/bam_dma.c                                         |   10 
 drivers/gpio/gpio-pca953x.c                                        |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                           |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                         |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                   |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                             |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                         |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c                        |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c                           |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c                        |    1 
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c                             |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c                              |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c                              |    5 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                             |    2 
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c                               |   13 
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                             |    4 
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c                             |    4 
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c                             |   41 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c             |    3 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c     |    3 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c |    6 
 drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c             |    7 
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c     |   15 
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c            |    6 
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h                      |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c               |   35 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c               |   32 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c               |   38 
 drivers/gpu/drm/bridge/nwl-dsi.c                                   |   17 
 drivers/gpu/drm/display/drm_dp_helper.c                            |    3 
 drivers/gpu/drm/drm_crtc.c                                         |   15 
 drivers/gpu/drm/drm_panic.c                                        |    7 
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c                           |   40 
 drivers/gpu/drm/i915/display/intel_display_device.c                |    5 
 drivers/gpu/drm/i915/display/intel_plane.c                         |   11 
 drivers/gpu/drm/i915/display/intel_psr.c                           |   96 -
 drivers/gpu/drm/i915/display/intel_psr_regs.h                      |    4 
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c                     |    2 
 drivers/gpu/drm/loongson/lsdc_gem.c                                |   12 
 drivers/gpu/drm/loongson/lsdc_plane.c                              |    2 
 drivers/gpu/drm/loongson/lsdc_ttm.c                                |   14 
 drivers/gpu/drm/loongson/lsdc_ttm.h                                |    2 
 drivers/gpu/drm/nouveau/nvkm/core/subdev.c                         |    1 
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c                |   20 
 drivers/gpu/drm/v3d/v3d_gem.c                                      |    5 
 drivers/gpu/drm/v3d/v3d_sched.c                                    |    2 
 drivers/gpu/drm/vc4/vc4_gem.c                                      |   14 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                     |   10 
 drivers/gpu/drm/vc4/vc4_hdmi_phy.c                                 |    5 
 drivers/hwmon/aquacomputer_d5next.c                                |   58 
 drivers/hwmon/asus_wmi_sensors.c                                   |   13 
 drivers/hwmon/chipcap2.c                                           |   53 
 drivers/hwmon/coretemp.c                                           |   27 
 drivers/hwmon/corsair-cpro.c                                       |    3 
 drivers/hwmon/gpio-fan.c                                           |    7 
 drivers/hwmon/hp-wmi-sensors.c                                     |   29 
 drivers/hwmon/lm70.c                                               |    8 
 drivers/hwmon/lm87.c                                               |    7 
 drivers/hwmon/nct6683.c                                            |    4 
 drivers/hwmon/nct6775-platform.c                                   |   24 
 drivers/hwmon/peci/dimmtemp.c                                      |   21 
 drivers/hwmon/pmbus/pmbus_core.c                                   |   51 
 drivers/hwmon/pmbus/q54sj108a2.c                                   |    2 
 drivers/hwmon/sht4x.c                                              |    4 
 drivers/hwmon/tmp102.c                                             |    8 
 drivers/hwmon/tmp108.c                                             |    8 
 drivers/iio/adc/ad4080.c                                           |    3 
 drivers/iio/adc/ad7192.c                                           |    2 
 drivers/iio/dac/mcp4821.c                                          |    7 
 drivers/iio/light/adux1020.c                                       |    4 
 drivers/iio/light/apds9160.c                                       |    7 
 drivers/iio/light/apds9300.c                                       |    4 
 drivers/iio/light/apds9306.c                                       |    3 
 drivers/iio/light/apds9960.c                                       |    4 
 drivers/iio/light/bh1745.c                                         |    3 
 drivers/iio/light/cm3605.c                                         |    4 
 drivers/iio/light/gp2ap002.c                                       |    4 
 drivers/iio/light/isl29028.c                                       |   43 
 drivers/iio/light/ltr390.c                                         |    3 
 drivers/iio/light/ltr501.c                                         |    7 
 drivers/iio/light/opt4060.c                                        |    2 
 drivers/iio/light/rpr0521.c                                        |    5 
 drivers/iio/light/si1145.c                                         |    4 
 drivers/iio/light/st_uvis25_core.c                                 |    5 
 drivers/iio/light/stk3310.c                                        |    5 
 drivers/iio/light/tsl2563.c                                        |    2 
 drivers/iio/light/tsl2772.c                                        |    5 
 drivers/iio/light/veml6030.c                                       |    4 
 drivers/iio/light/vl6180.c                                         |    2 
 drivers/iio/pressure/dps310.c                                      |    6 
 drivers/iommu/amd/init.c                                           |   41 
 drivers/iommu/iommufd/io_pagetable.c                               |    2 
 drivers/iommu/iommufd/iova_bitmap.c                                |   18 
 drivers/iommu/virtio-iommu.c                                       |    6 
 drivers/irqchip/irq-renesas-rzv2h.c                                |    6 
 drivers/media/common/cypress_firmware.c                            |    2 
 drivers/media/i2c/adv748x/adv748x-core.c                           |   13 
 drivers/media/i2c/imx219.c                                         |   88 
 drivers/media/i2c/og01a1b.c                                        |   95 -
 drivers/media/i2c/ov5647.c                                         |    4 
 drivers/media/pci/intel/ipu6/ipu6-fw-isys.c                        |   88 
 drivers/media/pci/intel/ipu6/ipu6-isys-video.c                     |    4 
 drivers/media/pci/intel/ipu6/ipu6-isys.c                           |    6 
 drivers/media/pci/intel/ipu6/ipu6-isys.h                           |    5 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c               |    4 
 drivers/media/platform/microchip/microchip-isc-base.c              |   20 
 drivers/media/platform/microchip/microchip-isc-regs.h              |   16 
 drivers/media/platform/microchip/microchip-isc.h                   |    4 
 drivers/media/platform/microchip/microchip-sama5d2-isc.c           |   20 
 drivers/media/platform/microchip/microchip-sama7g5-isc.c           |   20 
 drivers/media/platform/qcom/iris/iris_core.h                       |    6 
 drivers/media/platform/qcom/iris/iris_probe.c                      |   62 
 drivers/media/platform/qcom/iris/iris_vpu_common.c                 |    2 
 drivers/media/platform/rockchip/rga/rga.c                          |   69 
 drivers/media/platform/rockchip/rga/rga.h                          |    7 
 drivers/media/rc/redrat3.c                                         |   11 
 drivers/media/usb/dvb-usb/dvb-usb-firmware.c                       |    2 
 drivers/media/usb/uvc/uvc_driver.c                                 |   20 
 drivers/mfd/ab8500-core.c                                          |   44 
 drivers/mfd/twl-core.c                                             |   25 
 drivers/misc/fastrpc.c                                             |   81 
 drivers/mtd/nand/raw/Kconfig                                       |    3 
 drivers/mtd/nand/raw/ndfc.c                                        |   41 
 drivers/mtd/spi-nor/macronix.c                                     |    2 
 drivers/net/can/dev/netlink.c                                      |    4 
 drivers/net/can/dev/skb.c                                          |    1 
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c                         |    7 
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c                    |   33 
 drivers/net/ethernet/broadcom/bgmac.c                              |   10 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                          |   53 
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                          |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                  |    5 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                      |   52 
 drivers/net/ethernet/broadcom/tg3.c                                |   42 
 drivers/net/ethernet/jme.c                                         |   37 
 drivers/net/ethernet/jme.h                                         |    1 
 drivers/net/ethernet/mellanox/mlxsw/core.c                         |    4 
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c                   |    4 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c                |    2 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                           |    4 
 drivers/net/hamradio/6pack.c                                       |    6 
 drivers/net/hamradio/bpqether.c                                    |    8 
 drivers/net/hamradio/mkiss.c                                       |   70 
 drivers/net/ppp/pppoe.c                                            |   22 
 drivers/net/veth.c                                                 |    5 
 drivers/net/vxlan/vxlan_core.c                                     |   14 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c        |    7 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c          |    2 
 drivers/net/wireless/mediatek/mt76/mac80211.c                      |   14 
 drivers/net/wireless/mediatek/mt76/mt76.h                          |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c                    |    3 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                   |    7 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                    |    3 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                   |    2 
 drivers/net/wireless/mediatek/mt76/mt792x_core.c                   |   12 
 drivers/net/wireless/realtek/rtw88/mac80211.c                      |    2 
 drivers/net/wireless/realtek/rtw88/reg.h                           |    2 
 drivers/net/wireless/realtek/rtw88/tx.c                            |    9 
 drivers/net/wireless/realtek/rtw88/tx.h                            |    3 
 drivers/net/wireless/realtek/rtw88/usb.c                           |   68 
 drivers/net/wireless/realtek/rtw88/usb.h                           |    5 
 drivers/net/wireless/rsi/rsi_91x_core.c                            |    2 
 drivers/nvme/common/keyring.c                                      |    1 
 drivers/nvme/host/core.c                                           |    3 
 drivers/nvme/host/pci.c                                            |    2 
 drivers/nvme/host/pr.c                                             |    8 
 drivers/nvme/host/tcp.c                                            |  196 +-
 drivers/nvme/target/admin-cmd.c                                    |   16 
 drivers/nvme/target/configfs.c                                     |    4 
 drivers/nvme/target/core.c                                         |    8 
 drivers/nvme/target/nvmet.h                                        |    8 
 drivers/nvme/target/rdma.c                                         |    3 
 drivers/nvme/target/tcp.c                                          |   26 
 drivers/nvmem/rockchip-otp.c                                       |   24 
 drivers/pci/controller/cadence/pcie-cadence-plat.c                 |   33 
 drivers/pci/controller/dwc/pci-imx6.c                              |    2 
 drivers/pci/controller/dwc/pcie-designware.c                       |    2 
 drivers/pci/controller/dwc/pcie-designware.h                       |    1 
 drivers/pci/controller/dwc/pcie-rcar-gen4.c                        |   54 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                      |   69 
 drivers/pci/pcie/aer.c                                             |   23 
 drivers/platform/x86/amd/pmf/core.c                                |    1 
 drivers/platform/x86/asus-wmi.c                                    |   30 
 drivers/platform/x86/intel/int3472/discrete.c                      |   53 
 drivers/platform/x86/lenovo/Kconfig                                |    4 
 drivers/platform/x86/lenovo/Makefile                               |    2 
 drivers/platform/x86/lenovo/wmi-capdata.c                          |  310 +++
 drivers/platform/x86/lenovo/wmi-capdata.h                          |   25 
 drivers/platform/x86/lenovo/wmi-capdata01.c                        |  302 ---
 drivers/platform/x86/lenovo/wmi-capdata01.h                        |   25 
 drivers/platform/x86/lenovo/wmi-other.c                            |   11 
 drivers/power/supply/ltc2941-battery-gauge.c                       |    6 
 drivers/ptp/ptp_sysfs.c                                            |    6 
 drivers/s390/char/vmcp.c                                           |    4 
 drivers/scsi/aic7xxx/aic79xx_core.c                                |    4 
 drivers/scsi/aic7xxx/aic79xx_osm.h                                 |   26 
 drivers/scsi/aic7xxx/aic7xxx_core.c                                |    8 
 drivers/scsi/aic7xxx/aic7xxx_pci.c                                 |   20 
 drivers/scsi/scsi_bsg.c                                            |    6 
 drivers/scsi/scsi_ioctl.c                                          |   11 
 drivers/soc/qcom/pmic_glink_altmode.c                              |    4 
 drivers/spi/atmel-quadspi.c                                        |   34 
 drivers/spi/spi-cadence-xspi.c                                     |  522 ++---
 drivers/target/target_core_device.c                                |   18 
 drivers/target/target_core_fabric_lib.c                            |   10 
 drivers/target/target_core_tpg.c                                   |   10 
 drivers/target/target_core_user.c                                  |    5 
 drivers/tty/serial/sc16is7xx.c                                     |   14 
 drivers/ufs/core/ufs_bsg.c                                         |   13 
 drivers/ufs/core/ufshcd.c                                          |   48 
 drivers/vdpa/solidrun/snet_ctrl.c                                  |    3 
 drivers/vdpa/vdpa_user/iova_domain.c                               |   11 
 drivers/vfio/pci/vfio_pci_rdwr.c                                   |    3 
 drivers/vhost/scsi.c                                               |    7 
 drivers/vhost/vdpa.c                                               |    8 
 drivers/vhost/vhost.c                                              |    3 
 drivers/vhost/vringh.c                                             |   27 
 drivers/vhost/vsock.c                                              |   34 
 drivers/video/fbdev/core/fb_info.c                                 |    1 
 drivers/video/fbdev/core/fbcon_rotate.c                            |    3 
 drivers/video/fbdev/nvidia/nvidia.c                                |   20 
 drivers/video/fbdev/sh_mobile_lcdcfb.c                             |   34 
 drivers/watchdog/hpwdt.c                                           |   24 
 drivers/xen/gntdev-dmabuf.c                                        |    4 
 fs/9p/v9fs.c                                                       |   16 
 fs/9p/vfs_inode.c                                                  |    8 
 fs/backing-file.c                                                  |    5 
 fs/btrfs/sysfs.c                                                   |    1 
 fs/buffer.c                                                        |   29 
 fs/ceph/addr.c                                                     |    6 
 fs/ceph/crypto.c                                                   |    8 
 fs/dcache.c                                                        |    4 
 fs/erofs/zdata.c                                                   |   11 
 fs/exfat/file.c                                                    |   18 
 fs/ext2/file.c                                                     |    3 
 fs/ext2/inode.c                                                    |   13 
 fs/f2fs/checkpoint.c                                               |   13 
 fs/f2fs/data.c                                                     |   25 
 fs/f2fs/f2fs.h                                                     |    8 
 fs/f2fs/file.c                                                     |    2 
 fs/f2fs/gc.c                                                       |    2 
 fs/f2fs/node.c                                                     |   71 
 fs/f2fs/segment.c                                                  |    3 
 fs/f2fs/super.c                                                    |   24 
 fs/fat/inode.c                                                     |    2 
 fs/fs-writeback.c                                                  |   13 
 fs/fuse/virtio_fs.c                                                |   59 
 fs/gfs2/glops.c                                                    |   10 
 fs/inode.c                                                         |   51 
 fs/iomap/buffered-io.c                                             |    3 
 fs/iomap/direct-io.c                                               |   52 
 fs/nfs/callback_xdr.c                                              |    7 
 fs/nfs/localio.c                                                   |   12 
 fs/nfsd/blocklayout.c                                              |  125 -
 fs/nfsd/export.c                                                   |    3 
 fs/nfsd/nfs2acl.c                                                  |   64 
 fs/nfsd/nfs3proc.c                                                 |   58 
 fs/nfsd/nfs3xdr.c                                                  |    2 
 fs/nfsd/nfs4layouts.c                                              |   31 
 fs/nfsd/nfs4proc.c                                                 |   60 
 fs/nfsd/nfs4recover.c                                              |   49 
 fs/nfsd/nfs4state.c                                                |   21 
 fs/nfsd/nfs4xdr.c                                                  |    2 
 fs/nfsd/nfsctl.c                                                   |   56 
 fs/nfsd/nfsproc.c                                                  |    2 
 fs/nfsd/state.h                                                    |    2 
 fs/nfsd/vfs.c                                                      |  108 -
 fs/nfsd/vfs.h                                                      |   21 
 fs/nfsd/xdr3.h                                                     |    2 
 fs/notify/inotify/inotify_fsnotify.c                               |    2 
 fs/ntfs3/xattr.c                                                   |   25 
 fs/ocfs2/alloc.c                                                   |   20 
 fs/ocfs2/cluster/tcp.c                                             |    5 
 fs/ocfs2/dcache.h                                                  |    5 
 fs/ocfs2/dlm/dlmmaster.c                                           |   70 
 fs/ocfs2/dlmglue.c                                                 |   34 
 fs/ocfs2/filecheck.c                                               |    2 
 fs/ocfs2/journal.c                                                 |   15 
 fs/ocfs2/journal.h                                                 |    1 
 fs/ocfs2/super.c                                                   |    3 
 fs/ocfs2/xattr.c                                                   |  120 +
 fs/overlayfs/export.c                                              |    4 
 fs/overlayfs/inode.c                                               |    8 
 fs/overlayfs/namei.c                                               |   13 
 fs/overlayfs/overlayfs.h                                           |    2 
 fs/overlayfs/super.c                                               |   12 
 fs/proc/task_mmu.c                                                 |    2 
 fs/smb/client/cifsglob.h                                           |    3 
 fs/smb/client/cifspdu.h                                            |  253 --
 fs/smb/client/cifsproto.h                                          |    1 
 fs/smb/client/cifssmb.c                                            |   65 
 fs/smb/client/connect.c                                            |   36 
 fs/smb/client/inode.c                                              |    8 
 fs/smb/client/readdir.c                                            |   68 
 fs/smb/client/smb2misc.c                                           |   15 
 fs/smb/client/smb2ops.c                                            |   14 
 fs/smb/client/smb2pdu.c                                            |   57 
 fs/smb/client/smb2pdu.h                                            |   82 
 fs/smb/client/trace.h                                              |    1 
 fs/smb/common/fscc.h                                               |  157 +
 fs/smb/common/smb2pdu.h                                            |  230 ++
 fs/smb/server/mgmt/tree_connect.c                                  |    8 
 fs/smb/server/oplock.c                                             |    8 
 fs/smb/server/smb2ops.c                                            |    6 
 fs/smb/server/smb2pdu.c                                            |  162 -
 fs/smb/server/smb2pdu.h                                            |   69 
 fs/smb/server/smb_common.h                                         |  195 --
 fs/smb/server/smbacl.c                                             |    5 
 fs/smb/server/vfs.c                                                |    6 
 fs/smb/server/vfs.h                                                |    2 
 fs/udf/balloc.c                                                    |   11 
 fs/udf/inode.c                                                     |   42 
 fs/udf/super.c                                                     |   80 
 fs/udf/truncate.c                                                  |    7 
 fs/verity/enable.c                                                 |    8 
 fs/verity/fsverity_private.h                                       |    8 
 fs/verity/measure.c                                                |   10 
 fs/verity/open.c                                                   |    9 
 fs/verity/read_metadata.c                                          |   14 
 fs/verity/signature.c                                              |   55 
 fs/xfs/libxfs/xfs_attr_leaf.c                                      |    9 
 fs/xfs/libxfs/xfs_bmap.c                                           |   14 
 fs/xfs/libxfs/xfs_bmap.h                                           |   10 
 fs/xfs/libxfs/xfs_btree.c                                          |    4 
 fs/xfs/scrub/attr.c                                                |  102 -
 fs/xfs/scrub/attr_repair.c                                         |   16 
 fs/xfs/scrub/dir.c                                                 |  110 +
 fs/xfs/scrub/dir_repair.c                                          |  100 -
 fs/xfs/scrub/quota_repair.c                                        |   33 
 fs/xfs/scrub/xfarray.c                                             |   69 
 fs/xfs/xfs_aops.c                                                  |    2 
 fs/xfs/xfs_discard.c                                               |   26 
 fs/xfs/xfs_export.c                                                |    4 
 fs/xfs/xfs_ioctl32.c                                               |    4 
 fs/xfs/xfs_iomap.c                                                 |    8 
 fs/xfs/xfs_pnfs.c                                                  |   68 
 fs/xfs/xfs_pnfs.h                                                  |   11 
 include/acpi/cppc_acpi.h                                           |    6 
 include/asm-generic/tlb.h                                          |    3 
 include/dt-bindings/clock/nuvoton,ma35d1-clk.h                     |    3 
 include/kvm/arm_arch_timer.h                                       |   15 
 include/linux/assoc_array_priv.h                                   |    2 
 include/linux/backing-dev.h                                        |    5 
 include/linux/bio.h                                                |   15 
 include/linux/buffer_head.h                                        |    3 
 include/linux/can/can-ml.h                                         |    3 
 include/linux/cgroup.h                                             |   65 
 include/linux/damon.h                                              |    6 
 include/linux/exportfs.h                                           |   22 
 include/linux/exportfs_block.h                                     |   89 
 include/linux/fb.h                                                 |    9 
 include/linux/fs.h                                                 |   78 
 include/linux/hugetlb.h                                            |   24 
 include/linux/memcontrol.h                                         |   26 
 include/linux/memfd.h                                              |    9 
 include/linux/migrate.h                                            |    8 
 include/linux/mmu_notifier.h                                       |    3 
 include/linux/nfs4.h                                               |    6 
 include/linux/page_owner.h                                         |    7 
 include/linux/pagemap.h                                            |   11 
 include/linux/panic.h                                              |    3 
 include/linux/rculist_nulls.h                                      |   59 
 include/linux/srcu.h                                               |   36 
 include/linux/sunrpc/clnt.h                                        |    3 
 include/linux/sunrpc/svc.h                                         |    7 
 include/linux/writeback.h                                          |    4 
 include/net/espintcp.h                                             |    5 
 include/net/netns/can.h                                            |    2 
 include/net/netrom.h                                               |   15 
 include/net/rose.h                                                 |    3 
 include/net/sctp/sm.h                                              |    1 
 include/sound/hwdep.h                                              |    1 
 include/trace/events/migrate.h                                     |    8 
 include/uapi/linux/iommufd.h                                       |    6 
 io_uring/cancel.c                                                  |   26 
 io_uring/poll.c                                                    |   62 
 io_uring/rsrc.c                                                    |   21 
 io_uring/sqpoll.c                                                  |   26 
 ipc/namespace.c                                                    |    7 
 ipc/shm.c                                                          |    2 
 kernel/cgroup/cgroup-internal.h                                    |    6 
 kernel/cgroup/cgroup.c                                             |   55 
 kernel/events/core.c                                               |    9 
 kernel/kexec_handover.c                                            |    7 
 kernel/panic.c                                                     |   10 
 kernel/sched/ext.c                                                 |   14 
 kernel/time/posix-stubs.c                                          |    4 
 kernel/time/posix-timers.c                                         |   41 
 kernel/time/tick-sched.c                                           |   14 
 kernel/time/timekeeping.c                                          |    5 
 kernel/trace/trace_events_hist.c                                   |    3 
 lib/assoc_array.c                                                  |  355 ++-
 lib/cmdline.c                                                      |   13 
 lib/crypto/Kconfig                                                 |    6 
 lib/raid6/avx2.c                                                   |    6 
 lib/raid6/avx512.c                                                 |    6 
 lib/raid6/recov_avx2.c                                             |    2 
 lib/raid6/recov_avx512.c                                           |    2 
 lib/tests/cmdline_kunit.c                                          |  101 +
 mm/cma.c                                                           |    4 
 mm/damon/core.c                                                    |   68 
 mm/damon/sysfs-schemes.c                                           |    8 
 mm/damon/tests/core-kunit.h                                        |   16 
 mm/filemap.c                                                       |   55 
 mm/gup.c                                                           |   68 
 mm/huge_memory.c                                                   |   72 
 mm/hugetlb.c                                                       |  133 +
 mm/hugetlb_vmemmap.c                                               |   20 
 mm/internal.h                                                      |    2 
 mm/khugepaged.c                                                    |   29 
 mm/ksm.c                                                           |   10 
 mm/madvise.c                                                       |    9 
 mm/memcontrol.c                                                    |  111 -
 mm/memfd.c                                                         |   33 
 mm/memory-tiers.c                                                  |   29 
 mm/memory.c                                                        |   73 
 mm/mempolicy.c                                                     |   15 
 mm/migrate.c                                                       |   17 
 mm/mm_init.c                                                       |    2 
 mm/mmu_notifier.c                                                  |   24 
 mm/mremap.c                                                        |   22 
 mm/page-writeback.c                                                |    8 
 mm/page_alloc.c                                                    |   71 
 mm/page_counter.c                                                  |   21 
 mm/page_owner.c                                                    |    4 
 mm/page_vma_mapped.c                                               |   22 
 mm/shmem.c                                                         |  109 -
 mm/shmem_quota.c                                                   |   28 
 mm/swapfile.c                                                      |    4 
 mm/userfaultfd.c                                                   |    5 
 mm/vma.c                                                           |   65 
 mm/vmscan.c                                                        |   16 
 net/9p/trans_usbg.c                                                |   89 
 net/9p/trans_virtio.c                                              |    5 
 net/9p/trans_xen.c                                                 |   10 
 net/ax25/af_ax25.c                                                 |  123 +
 net/ax25/ax25_ds_timer.c                                           |    2 
 net/ax25/ax25_in.c                                                 |   56 
 net/ax25/ax25_ip.c                                                 |    9 
 net/ax25/ax25_out.c                                                |   17 
 net/ax25/ax25_std_timer.c                                          |    2 
 net/ax25/sysctl_net_ax25.c                                         |    2 
 net/batman-adv/bat_iv_ogm.c                                        |    5 
 net/batman-adv/distributed-arp-table.c                             |    1 
 net/batman-adv/main.c                                              |   12 
 net/batman-adv/multicast_forw.c                                    |    5 
 net/batman-adv/tp_meter.c                                          |    2 
 net/batman-adv/translation-table.c                                 |  134 +
 net/batman-adv/types.h                                             |    8 
 net/bluetooth/hci_sync.c                                           |   25 
 net/bluetooth/l2cap_core.c                                         |   47 
 net/bluetooth/selftest.c                                           |    1 
 net/bluetooth/smp.c                                                |    1 
 net/can/af_can.c                                                   |   51 
 net/can/bcm.c                                                      |   50 
 net/can/gw.c                                                       |    7 
 net/can/isotp.c                                                    |  230 +-
 net/can/proc.c                                                     |   69 
 net/can/raw.c                                                      |  282 +--
 net/core/filter.c                                                  |   23 
 net/core/net_namespace.c                                           |    4 
 net/core/sock.c                                                    |    6 
 net/ipv4/cipso_ipv4.c                                              |    9 
 net/ipv4/inet_connection_sock.c                                    |    6 
 net/ipv4/inet_hashtables.c                                         |    2 
 net/ipv4/inet_timewait_sock.c                                      |    4 
 net/ipv4/ip_gre.c                                                  |    1 
 net/ipv4/ipmr.c                                                    |   28 
 net/ipv4/syncookies.c                                              |    2 
 net/ipv4/tcp_fastopen.c                                            |    2 
 net/ipv4/xfrm4_output.c                                            |    7 
 net/ipv6/addrconf.c                                                |    3 
 net/ipv6/datagram.c                                                |    4 
 net/ipv6/inet6_hashtables.c                                        |    2 
 net/ipv6/ip6_gre.c                                                 |    1 
 net/ipv6/ip6mr.c                                                   |    5 
 net/ipv6/raw.c                                                     |    3 
 net/l2tp/l2tp_core.c                                               |   13 
 net/mac80211/tdls.c                                                |    3 
 net/mac80211/tx.c                                                  |   57 
 net/mptcp/pm_kernel.c                                              |    1 
 net/mptcp/protocol.c                                               |   31 
 net/mptcp/protocol.h                                               |    4 
 net/mptcp/subflow.c                                                |   17 
 net/mptcp/token.c                                                  |   68 
 net/mptcp/token_test.c                                             |    4 
 net/netrom/af_netrom.c                                             |  109 -
 net/netrom/nr_in.c                                                 |   46 
 net/netrom/nr_out.c                                                |   23 
 net/netrom/nr_route.c                                              |  100 -
 net/rds/recv.c                                                     |    6 
 net/rose/af_rose.c                                                 |  124 -
 net/rose/rose_in.c                                                 |   11 
 net/rose/rose_link.c                                               |   85 
 net/rose/rose_loopback.c                                           |    1 
 net/rose/rose_route.c                                              |   67 
 net/rose/sysctl_net_rose.c                                         |   13 
 net/sched/sch_generic.c                                            |   41 
 net/sched/sch_qfq.c                                                |    3 
 net/sched/sch_taprio.c                                             |    5 
 net/sctp/sm_make_chunk.c                                           |   14 
 net/sctp/socket.c                                                  |   57 
 net/smc/smc_rx.c                                                   |   39 
 net/sunrpc/rpcb_clnt.c                                             |   22 
 net/sunrpc/svc.c                                                   |   42 
 net/wireless/reg.c                                                 |    3 
 net/xfrm/espintcp.c                                                |   43 
 net/xfrm/xfrm_interface_core.c                                     |    8 
 net/xfrm/xfrm_policy.c                                             |   11 
 rust/kernel/bug.rs                                                 |   12 
 rust/kernel/cpufreq.rs                                             |    4 
 sound/core/compress_offload.c                                      |   18 
 sound/core/control.c                                               |   19 
 sound/core/hwdep.c                                                 |   25 
 sound/core/init.c                                                  |   23 
 sound/core/jack.c                                                  |   38 
 sound/core/oss/mixer_oss.c                                         |   13 
 sound/core/oss/pcm_oss.c                                           |   21 
 sound/core/pcm_native.c                                            |   44 
 sound/core/rawmidi.c                                               |   16 
 sound/core/seq/oss/seq_oss.c                                       |   21 
 sound/core/seq/seq_clientmgr.c                                     |   19 
 sound/core/sound.c                                                 |    9 
 sound/core/timer.c                                                 |   26 
 sound/core/timer_compat.c                                          |    1 
 sound/core/ump_convert.c                                           |    2 
 sound/hda/codecs/realtek/alc269.c                                  |  109 -
 sound/hda/codecs/side-codecs/cs35l41_hda.c                         |   22 
 sound/hda/codecs/side-codecs/tas2781_hda.c                         |   27 
 sound/pci/cs46xx/dsp_spos.c                                        |    2 
 sound/pci/cs46xx/dsp_spos_scb_lib.c                                |    3 
 sound/soc/amd/acp-config.c                                         |   43 
 sound/soc/amd/yc/acp6x-mach.c                                      |    7 
 sound/soc/codecs/hdac_hda.c                                        |   25 
 sound/soc/qcom/qdsp6/q6apm-dai.c                                   |   12 
 sound/soc/qcom/qdsp6/q6apm.c                                       |    6 
 sound/soc/qcom/qdsp6/q6prm.c                                       |    3 
 sound/soc/sof/intel/hda-codec.c                                    |   23 
 sound/soc/stm/stm32_i2s.c                                          |   27 
 sound/usb/bcd2000/bcd2000.c                                        |   20 
 sound/usb/caiaq/input.c                                            |    2 
 sound/usb/line6/capture.c                                          |   29 
 sound/usb/midi.c                                                   |   64 
 sound/usb/misc/ua101.c                                             |   29 
 sound/usb/usx2y/us122l.c                                           |   27 
 sound/usb/usx2y/usX2Yhwdep.c                                       |    5 
 sound/usb/usx2y/usb_stream.c                                       |    9 
 sound/usb/usx2y/usbusx2yaudio.c                                    |   43 
 sound/x86/intel_hdmi_audio.c                                       |    9 
 tools/perf/tests/tool_pmu.c                                        |   79 
 tools/perf/util/evsel.c                                            |   30 
 tools/perf/util/hwmon_pmu.c                                        |    2 
 tools/perf/util/python.c                                           |    2 
 tools/perf/util/tool_pmu.c                                         |    2 
 tools/testing/selftests/landlock/audit_test.c                      |    2 
 tools/testing/selftests/landlock/net_test.c                        |    4 
 tools/testing/selftests/landlock/ptrace_test.c                     |    2 
 tools/testing/selftests/net/fib_nexthops.sh                        |   40 
 tools/testing/vma/vma_internal.h                                   |    2 
 virt/kvm/guest_memfd.c                                             |  109 -
 virt/kvm/kvm_main.c                                                |   45 
 virt/kvm/kvm_mm.h                                                  |   18 
 650 files changed, 10763 insertions(+), 6359 deletions(-)

Abdifatah Suruur (2):
      smb: client: validate the data area in SMB2_read()
      smb: client: reject short SESSION_SETUP responses

Abel Vesa (1):
      soc: qcom: pmic_glink: Fix device access from worker during suspend

Abhishek Dubey (1):
      powerpc/bpf: fix buffer overflow in JIT for large BPF programs

Ackerley Tng (2):
      mm: hugetlb: return -ENOSPC on memcg charge failure
      mm: hugetlb: drop refcount before freeing on memcg charge failure

Akshay Jindal (1):
      iommu/amd: Skip non-IVMD entries when parsing IVRS memory definitions

Alex Hung (1):
      drm/amd/display: Avoid closing unowned DDC pins

Alex Kazinsky (2):
      wifi: rsi: Skip TX aggregation setup for non-QoS frames
      ALSA: cs46xx: Handle SCB creation failures before dereferencing

Alexander Sverdlin (1):
      tpm: tpm2_probe: propagate transport errors

Alexey Charkov (1):
      nvmem: rockchip-otp: Serialize reads

Andrea Parri (2):
      iomap: don't lose a failed direct I/O bio's error when zeroing the tail
      iommufd/iova_bitmap: Ensure that iova_bitmap_set() handles the full IOVA

Andrew Luebke (1):
      scsi: aic79xx: Fix NULL pointer dereference in device reset

Andrew Morton (1):
      openrisc: export __mulsi3 for modules

Andrew Stellman (1):
      nvmet-rdma: fix out-of-bounds write in nvmet_rdma_map_sgl_inline()

Andrey Misiurov (1):
      fbdev: core: Initialize modelist in framebuffer_alloc()

André Almeida (1):
      exportfs: Complete kernel-doc for struct export_operations

André Draszik (1):
      drm/drm_crtc: ensure dma_fence_ops remain valid during device unbind

Andy Shevchenko (2):
      iio: adc: ad7192: Revert "properly check spi_get_device_match_data()"
      spi: cadence-xspi: Replace ACPI specifics by agnostic APIs

Antoniu Miclaus (1):
      iio: adc: ad4080: enable address ascension for chip identification

Antti Laakso (1):
      media: ipu6: Rename pointer to firmware context

Armaan Sandhu (1):
      lib/cmdline: fix get_options() count and overflow with large ranges

Arnaldo Carvalho de Melo (2):
      perf evsel: Close the fds opened so far when disabling missing features
      perf python: Free the parse error entries when parsing fails

Arnd Bergmann (1):
      mtd: rawnand: ndfc: add CONFIG_OF dependency

Art O Cathain (1):
      ASoC: amd: acp-config: force SoundWire probe on Dell 14S DS14265

Ashok Raj (1):
      cxl/features: Ensure that count is set before access to ent[] __counted_by()

Au Dang (1):
      irqchip/renesas-rzv2h: Preserve TIEN state in rzv2h_tint_set_type()

Babu Moger (2):
      x86/resctrl: Correct ABMC counter ID field width
      x86,fs/resctrl: Keep mbm_assign_mode in default mode at boot

Baek Kyu, Kim (2):
      hwmon: (corsair-cpro) Cache fan target only after a successful command
      hwmon: (gpio-fan) Update the speed cache before dropping the PM reference

Balakrishnan Sambath (4):
      media: microchip-isc: fix WB offset and gain register field masking
      media: microchip-isc: store the unshifted PFE_CFG0 BPS value
      media: microchip-isc: fix ISC_PFG_CFG0_BPS macro name typo
      media: microchip-isc: fix SBGGR10 Bayer pattern

Baolin Wang (1):
      mm: memory: fix truncation removing mapped folios

Bart Van Assche (1):
      ata: libata: Add an argument to ata_eh_reset()

Bartosz Golaszewski (1):
      dmaengine: qcom: bam_dma: free interrupt before the clock in error path

Bas Nieuwenhuizen (1):
      drm/amdgpu: Check cs flags.

Ben Dooks (1):
      devtmpfs: make 'devtmpfs_context_ops' static

Benjamin Coddington (1):
      NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before allocating

Bernard Pidoux (41):
      mkiss: size the frame buffers for worst-case KISS escaping
      mkiss: don't use a tty write error as a byte count
      bpqether: leave the Ethernet device's queue and counters alone
      bpqether: fix truncated /proc/net/bpqether on partial reads
      rose: arm the neighbour timers with mod_timer()
      netrom: ignore a BPQ transport timeout below the sysctl minimum
      rose: don't give the same LCI to two calls placed at the same time
      ax25: don't create a second connection for a link on an incoming SABM
      ax25: free a closed socket when its device goes down
      mkiss: restart the transmit queue when the interface is opened
      6pack: restart the transmit queue when the interface is opened
      ax25: don't build a frame header from an uninitialised digipeater list
      ax25: don't take a reference on a gone device in ax25_accept()
      ax25: don't copy an uninitialised address to recvmsg()'s caller
      ax25: free the old digipeater path of a listed socket under ax25_list_lock
      ax25: put an incoming connection on the listener's queue once it is set up
      ax25: don't test the socket flags of a connection that has no socket
      ax25: free the copy of an IP packet that ax25_send_frame() turned down
      ax25: don't leave half a message on a connection when fragmenting fails
      ax25: make 16 the smallest maximum_packet_length of a port
      ax25: keep the window below 8 when a socket goes back to modulo 8
      ax25: let a socket connect again after a failed or ended connection
      ax25: don't let connect() find its own socket when calling the same station
      netrom: don't convert the maximum number of tries to jiffies
      netrom: don't leak frames in nr_route_frame()
      netrom: use the more flag of each frame taken from the resequencing queue
      netrom: give a frame back intact when it cannot be delivered
      netrom: don't give the same circuit ID to two sockets
      netrom: return the peer node in the address given by recvmsg()
      netrom: keep the selected route when a route of a node is removed
      netrom: drop a frame received with a TTL of 0
      netrom: check the window size given by the peer
      netrom: don't send part of a message that cannot be fragmented whole
      netrom: disconnect sockets under their lock when a device goes down
      netrom: only update the BPQ extension flag on circuit set-up frames
      rose: hold the listener while a Call Request is queued on it
      rose: hold the socket a received frame is delivered to
      rose: report a timed out call to connect()
      rose: drop the neighbour reference once when a cleared socket is closed
      rose: swap the AX.25 connection of a neighbour under a lock
      rose: give the sysctl timer limits in milliseconds

Bharath SM (1):
      smb: align durable reconnect v2 context to 8 byte boundary

Borislav Petkov (AMD) (1):
      Documentation/kernel-parameters: Move the kernel build options

Bradley Morgan (1):
      panic: restore variable arguments to nmi_panic()

Breno Leitao (3):
      ACPI: APEI: accumulate the queued flag across error sections
      x86/bugs: Select the BHI mitigation based on the attack vector properly
      x86/nmi: Ignore negative NMI handler durations

Bryam Vargas (1):
      net/smc: don't spin in smc_rx_recvmsg() while a pipe holds spliced data

Bui Viet Dung (1):
      Bluetooth: selftest: Pin module for selftest debugfs file operations

Cen Zhang (6):
      ocfs2: keep locking_state within the cluster connection lifetime
      ocfs2/dlm: serialize migration MLE cleanup on failure
      ocfs2: stop recovery before shutting down local allocators
      ocfs2/cluster: unlink socket containers before releasing resources
      ocfs2: wait for filecheck kobject release after a failed add
      ocfs2: cache the mount context for dentry lock callbacks

Cen Zhang (Microsoft Security FORGE Labs) (1):
      ksmbd: fix tree connection use-after-free in smb2_tree_connect()

Chao Yu (5):
      f2fs: fix to avoid folio->mapping dereference in is_{meta, node}_folio()
      f2fs: fix to check continuousness in f2fs_sync_meta_pages() correctly
      f2fs: zone: fix to avoid bio split on sequential zone
      f2fs: fix to use bio_in_atomic() in f2fs_read_end_io()
      f2fs: fix to invalidate curseg if change_curseg() fails

ChenXiaoSong (5):
      smb: move create_durable_req_v2 to common/smb2pdu.h
      smb: move create_durable_handle_reconnect_v2 to common/smb2pdu.h
      smb: move create_durable_rsp_v2 to common/smb2pdu.h
      smb: move list of FileSystemAttributes to common/fscc.h
      smb: move some duplicate struct definitions to common/fscc.h

Cheng Ming Lin (1):
      mtd: spi-nor: macronix: Restore fallback parameters for MX25L12805D

Chengfeng Ye (3):
      xfrm: retry inexact policy lookup after node reinsertion
      net/9p/usbg: clear stale request context after abort
      batman-adv: Close OGM aggregation before transmission

Chi Zhiling (1):
      exfat: advance valid_size to EOF for append writes

Chintan Patel (2):
      fb: Add dev_of_fbinfo() helper for optional sysfs support
      fbdev: sh_mobile_lcdc: Make FB_DEVICE dependency optional

Chris Down (1):
      mm: make swapoff interruptible when unusing mms/shmem

Chris Mason (17):
      backing-file: always end a queued write
      io_uring/cancel: drop sqd->lock while SQPOLL waits
      mm/mempolicy: charge shared policy nodes
      mm/shmem: stop retrying folios that cannot be split
      mm/shmem: preserve data in clean folios when splitting fails
      mm/khugepaged: preserve dirty bits when collapsing PTE-mapped THPs
      mm/gup: fix clearing folios in memfd_pin_folios()
      mm/gup: fix out-of-bounds write for nr_pages == 0 in GUP-fast
      mm/mmu_notifier: set ->mm only after mmgrab()
      mm/memory: reject remote COW faults on PFN mappings
      mm: fix unkillable fault loop on MAP_DROPPABLE memory
      mm/vma: call ->may_split() before a partial merge
      ovl: do not let chattr change the casefold flag
      ovl: look up the index by the decoded origin
      x86/mm: Fix global ASID handed out to two processes
      mm/shmem: honour F_SEAL_EXEC when an ACL is set
      ovl: fail the mount if the casefold flag has changed

Chris Simpson (1):
      ALSA: hda/realtek: Enable bass speakers on Alienware m17 R3

Christian Borntraeger (1):
      s390/vmcp: Initialize full session info to zero

Christian Brauner (2):
      ns: don't add init_ipc_ns and init_net without namespace support
      iomap: don't mark unwritten parts of a folio uptodate

Christian Gmeiner (1):
      drm/etnaviv: Flush the tile status cache through both the PE and BLT

Christian Loehle (3):
      ACPI: CPPC: Validate FFH register fields before hardware access
      ACPI: CPPC: Propagate errors from cross-CPU FFH calls
      ACPI: CPPC: Accept requests to retain immutable autonomous selection

Christoph Hellwig (3):
      exportfs: split out the ops for layout-based block device access
      exportfs,nfsd: rework checking for layout-based block device access support
      xfs: fix recovery of partial attr removals

Christopher Lusk (1):
      m68k: Fix seccomp filtering on ColdFire and 68000

Chuck Lever (8):
      NFSD: Replace nfsd_write()'s "stable" argument with "iocb_flags"
      NFSD: Move version-specific ACCESS maps into per-version code
      NFSD: map fh_verify() status codes for NFS_ACLv2 replies
      NFSD: Count the delegations held by each client
      NFSD: Send a meaningful CB_RECALL_ANY keep count
      NFSD: Move the cld upcall message out of the caller's stack frame
      NFSD: Complete a cld upcall when the daemon closes the pipe
      NFSD: Complete a cld upcall when copying its reply fails

ChunYuZhiQiang (1):
      can: dev: can_fill_info(): don't wake up controller if interface is down

Cong Zhang (1):
      virtio_blk: use synchronous quiesce in virtblk_freeze_priv()

Cunhao Lu (1):
      can: dev: can_put_echo_skb(): free skb on invalid echo index

Daeho Jeong (3):
      f2fs: don't use truncate_inode_pages_final() on live inodes
      f2fs: return -EIO for a lost inode block after cp_error
      f2fs: release a removed xattr node in roll-forward recovery

Daehyeon Ko (2):
      vhost/vsock: size receive SKBs from declared payload
      timekeeping: Require permission to set auxiliary clocks

Daejun Park (8):
      xfs: don't skip free extents in later batches of a whole-AG FITRIM
      xfs: don't skip free extents of the longest length in a whole-AG FITRIM
      nvme: unregister when pr_register() is given a zero new key
      xfs: mark the inode preallocated for pNFS write layouts past EOF
      xfs: add a flag to convert unwritten extents without allocating blocks
      xfs: clamp a pNFS LAYOUTCOMMIT extent before computing its end
      xfs: cap the block count of xfs_iomap_write_direct() at one extent
      xfs: clamp the pNFS layout range to the maximum file size

Dan Williams (1):
      cxl/port: Cleanup handling of the nr_dports 0 -> 1 transition

Daniel Palmer (1):
      m68k: Fix task info flags handling for 68000

Danish Khateeb (2):
      perf/core: Don't send SIGTRAP after exec removed the event
      ALSA: timer: Handle userspace-driven timer ioctls from 32-bit tasks

Dariusz Marcinkiewicz (1):
      drm/amdgpu: check amdgpu_vm_ready() in dma-buf move notify

Darrick J. Wong (7):
      xfs: break out xattr entry checks into separate functions
      xfs: check for buffer overruns when examining local/remote xattr entries
      xfs: refactor directory data block walking loops in scrub
      xfs: improve dirent bounds checking in scrub and repair
      xfs: reinitialize dquot block if non-first dquot can't load
      xfs: forcibly reset quota timers when upgrading to bigtime during repair
      xfarray: don't crash when sorting if array element crosses a folio

Dave Jiang (1):
      cxl/port: Clear cached dport pointers when a dport is removed

David Carlier (2):
      mm/shmem: don't release a swapin-error marker as a swap entry
      media: ipu6: Fix firmware config leak on stream start

David Hildenbrand (Arm) (15):
      mm/shmem: discard whole new large folios on fallocate rollback
      mm/shmem: rescan after nonuniform folio splitting
      mm/shmem: fix truncate hang in large swap entry
      mm/shmem: fix truncate loop after boundary swapin failure
      mm/shmem: fix truncation of files containing only swapin-error markers
      mm/filemap: finish fault cleanup before dropping the fault lock
      mm/gup: recheck the PUD under PTL in follow_pud_mask()
      mm/gup: check for overflow when converting nr_pages to bytes in GUP-fast
      mm/mremap: use pudp_huge_get_and_clear() when moving huge PUDs
      mm/mremap: recheck PUDs under the page table lock
      mm/madvise: fix data loss from MADV_FREE on a KSM page
      mm/ksm: reset the unstable trees of all nodes
      mm/memory-tiers: unregister empty tiers outside memory_tier_lock
      mm/userfaultfd: only allocate anon_vma in CoW mappings
      mm/huge_memory: split huge PUDs when adjusting VMA boundaries

David Lee (1):
      sctp: hold shkey across socket migration

Denis Pauk (1):
      hwmon: (nct6775) Add ASUS X870/W480 to WMI monitoring list

Devin Wittmayer (4):
      wifi: mt76: take rcu_read_lock in the USB/SDIO tx completion path
      drm/panic: Fix kmsg screen hang on a long log line
      wifi: mt76: mt7921: assert sniffer on chanctx change
      wifi: mt76: move the channel survey when the channel changes

Diego Oliva (3):
      smb: client: fix OOB read of the resume name sent in TRANS2_FIND_NEXT2
      smb: client: fix OOB read in the SMB_FIND_FILE_UNIX name scan
      smb: client: reject FIND data areas that run past the received response

Dom Cobley (1):
      drm/vc4: hdmi: power down the BCM2712 PHY when the output is disabled

Donggeun Yoo (1):
      tracing: Add the bucket size to expr_field_str()

Eduard Zateev (1):
      smb: client: hold server info until cifsd exits

Edward Adam Davis (1):
      ocfs2: fix oob in __ocfs2_find_path

Erhan Bilgili (2):
      drm/amdgpu: Fix duplicate dependency fence releases
      drm/amdgpu: Report MES ring wait timeouts.

Eric Biggers (7):
      crypto: sa2ul - Fix HMAC key preparation
      fsverity: Tell LSMs about signature only after verity is enabled
      fsverity: Explicitly require FMODE_READ to retrieve hashes
      xor: add missing vzeroupper to AVX code
      raid6: add missing vzeroupper to AVX-512 code
      raid6: add missing vzeroupper to AVX2 code
      lib/crypto: mips: Disable Octeon SHA code on little-endian kernels

Eric Dumazet (1):
      ipmr: prevent info-leak in pmr_cache_report()

Eric Sandeen (1):
      devtmpfs: restore mount option reconfiguration on get_tree

Esben Haabendal (3):
      drm/bridge: nwl-dsi: Cleanup endpoint mux control selection
      drm/bridge: nwl-dsi: Limit LCDIF specific sync override
      iio: light: ltr501: Power down chip if request irq fails

Ethan Nelson-Moore (1):
      ata: sata_inic162x: remove dangerous broken driver

Evanshenf (3):
      drm/loongson: Fix framebuffer selection in async cursor updates
      drm/loongson: Fix double free on BO initialization failure
      drm/loongson: Handle buffer mapping failures when clearing a BO

Ewan D. Milne (1):
      nvmet: don't return memory contents beyond valid data when reading ANA log page

FUJITA Tomonori (2):
      rust: bug: pass TAINT_WARN to warn_slowpath_fmt() on UML
      rust: bug: update the SAFETY comment for warn_slowpath_fmt() on UML

Fabio Cesari (1):
      iio: light: isl29028: fix runtime PM reference leak on error paths

Fan Wu (1):
      media: rockchip: rga: quiesce IRQ before releasing m2m state

Fang Xieyan (3):
      vringh: bound top-level re-entry into indirect tables
      vringh: reject empty / undersized indirect descriptor tables
      vhost: fix used ring index wrap in vhost_add_used_n_in_order

Federico Musto (1):
      net: atl1c: drop oversized RX frames instead of panicking

Finn Zeruhn (1):
      drm/dp: keep MOT set between messages when no_zero_sized is set

Fourie Zhang (1):
      xfrm4: use a full socket for local errors

Franck Baur (1):
      net: jme: keep RX MAC clock enabled for WoL

Fuad Tabba (3):
      KVM: arm64: timers: Compute an offset-applied CVAL from the current count
      KVM: arm64: Use kvm_s2_fault_vma_info in gmem_abort()
      KVM: arm64: Pin the host vCPU before adjusting its PC under pKVM

Gael Blivet (1):
      ksmbd: look up stream size by exact xattr name

Gaurav Batra (1):
      powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped

Gianluca Balboni (1):
      ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx

Giorgi Kobakhia (1):
      ocfs2: fix array out of bound access in __ocfs2_find_path()

Greg Kroah-Hartman (1):
      Linux 6.18.64

Gregory Price (1):
      mm/mempolicy: use vm_normal_folio_pmd() in queue_folios_pmd()

Guanglei Zhu (1):
      ceph: clamp the inline data length in ceph_fill_inline_data()

Guangshuo Li (4):
      mfd: ab8500: Fix child device leaks on probe failure
      media: i2c: og01a1b: power off sensor on remove
      media: i2c: ov5647: fix power cleanup on remove
      crypto: omap-sham - fix crypto engine cleanup

Guenter Roeck (13):
      hwmon: (aquacomputer_d5next) Check maxcollection when probing AQUAERO devices
      hwmon: (asus_wmi_sensors) Avoid global struct mutation
      hwmon: (hp-wmi-sensors) Avoid global struct mutation
      hwmon: (hp-wmi-sensors) Fix unbounded loops in scale_numeric_sensor()
      hwmon: (lm87) Fix drvdata type confusion in vrm_show() and vrm_store()
      hwmon: (nct6683) Fix incorrect struct cast in show_pwm() and store_pwm()
      hwmon: (peci/dimmtemp) Fix devres leak and UAF on concurrent unbind
      hwmon: (pmbus/q54sj108a2) Add missing NULL pointer check
      hwmon: (pmbus) Check return value from pmbus_thermal_add_sensor()
      hwmon: (pmbus) Release devres allocated memory after devm_thermal_of_zone_register error
      hwmon: (pmbus) Fix return value check from thermal zone registration
      hwmon: (coretemp) Check for NULL platform device in hotplug callbacks
      hwmon: (sht4x) Convert update_interval to jiffies in pending data check

Guixin Liu (1):
      cxl/events: Test CME counter expiry with equality, not bitwise AND

Hamid Nassiby (1):
      Revert "mm/page_owner: fix memory leak in page_owner_stack_fops->release()"

Hans Zhang (1):
      spi: cadence-xspi: Use FIELD_MODIFY()

Hans de Goede (1):
      platform/x86: int3472: Increase handshake GPIO delay to 200 ms

Hasun Park (1):
      ASoC: amd: acp: add DMI override for ACP70 flag

Hengyu Liang (2):
      fs/proc/task_mmu: return -ENOTTY for unknown pagemap ioctls
      l2tp: only return sessions of the given tunnel in l2tp_session_get()

Henry Martin (1):
      rds: fix out-of-bounds conn_path walks via handshake exthdrs

Hongfu Li (2):
      mm/memcg: migrate per-node hugetlb lruvec stat together with hugetlb folio
      mm/memfd: fix hugetlb reservation accounting in error paths

Huacai Chen (1):
      LoongArch: Don't init & online empty nodes

Hugo Sales (1):
      drm/amdgpu: Clamp the ATIF backlight curve to its 99 points

Hugo Villeneuve (3):
      serial: sc16is7xx: declare SPR/TLR/XOFF2 register as volatile
      serial: sc16is7xx: add comments for lock requirements
      serial: sc16is7xx: declare MCR and IER as volatile registers

Hui Su (1):
      perf evsel: Restrict incremental open error unwind

Hung-Jui Lin (1):
      posix-timers: Report zero remaining time for disarmed SIGEV_NONE timers

Hungyu Lin (7):
      posix-timers: Accept NULL clock_getres() output in stubs
      ext2: preserve completed DIO bytes when buffered fallback fails
      mm/page-writeback: avoid 32-bit overflow in dirty threshold shares
      mm/migrate: untag addresses when querying page nodes
      inotify: do not coalesce rename events
      block: Return the soft block size for compat BLKBSZGET
      ext2: preserve IOMAP_F_DIRTY for extending direct writes

HyeongJun An (1):
      ALSA: ump: Fix dropped data bytes at UMP System message conversion

Hyungjung Joo (1):
      net/9p/usbg: clear stale client pointer on close

Hyunwoo Kim (1):
      net: restore refcount ordering for lockless socket access

Ian Bridges (2):
      ksmbd: require DELETE access for delete-on-close opens
      ksmbd: grant a POSIX ACL group entry only to the group's members

Ido Schimmel (2):
      ipmr, ip6mr: validate packets injected into the register vif on xmit
      vxlan: Stop rejecting dynamic FDB entries with a nexthop ID

Ilia Mirkin (1):
      drm/nouveau/devinit/gf100-: try to avoid double-running vbios scripts

Imre Kaloz (4):
      scsi: aic7xxx: Use default settings on the SGI O2 onboard controllers
      MIPS: mm: Fix the cache error vector jump for XKPHYS kernels
      MIPS: sgi-ip32: Mask MACE PCI interrupts in CRIME only
      MIPS: sgi-ip32: Leave MACE PCI control alone in config accesses

Iván Ezequiel Rodriguez (1):
      arm64/gcs: release GCS on failed fork

Jackie Dong (1):
      ASoC: amd: acp: Add DMI quirk for Lenovo Yoga Pro 7 15ASH11

Jaeho Cho (1):
      ALSA: hda/realtek: Enable mute LEDs on HP OmniBook 7 17-dc0xxx

Jamal Hadi Salim (2):
      bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
      net/sched: clamp skb->queue_mapping before indexing the tx queue

James Clark (1):
      net: ethernet: ti: am65-cpsw-nuss: Enable timestamping of unicast PTP packets

Jan Kara (1):
      fs: Ignore inode metadata buffers in inode_lru_isolate()

Janne Grunau (1):
      wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload

Jarkko Sakkinen (1):
      nvme-keyring: Add a missing key_put() call to nvme_tls_key_lookup()

Jason Perlow (1):
      wifi: brcmfmac: map msgbuf RX packet IDs bidirectional

Jasper Smet (1):
      ASoC: amd: acp: Add DMI quirk for ASUS Zenbook S16 UM5606GA

Javier Carrasco (7):
      hwmon: chipcap2: fix command error diagnostics
      hwmon: chipcap2: fix off-by-one in command mode retry loop
      hwmon: chipcap2: fix be16 handling
      hwmon: chipcap2: defer probe when IRQs are unavailable
      hwmon: chipcap2: enable IRQ processing when regulator is already enabled
      hwmon: chipcap2: balance regulator state
      hwmon: chipcap2: do not discard pending alarms on disable

Jeff Layton (5):
      nfsd: don't offer flexfiles layouts when NFSv3 isn't being served
      NFSD: report listener creation failures through extack
      SUNRPC: report local rpcbind calls that get no answer
      NFSD: stop registering with rpcbind after a failure in listener_set
      nfsd: shorten extack string returned with dodgy listener

Jens Axboe (3):
      io_uring/sqpoll: don't attach to a thread that is canceling
      io_uring/poll: don't poll a writer for a read side hangup
      io_uring/poll: don't poll a writer for urgent data

Jesse Zhang (6):
      drm/amdgpu: parse CS IBs at the BO offset their VA mapping starts at
      drm/amdgpu: keep the CS user fence BO in GTT
      drm/amdkfd: use the queue's process info for the WPTR BO eviction fence
      drm/amdgpu/gfx12: disallow GFXOFF while updating the SPM VMID
      drm/amdgpu: drop the dma-buf reference when a KFD import fails
      drm/amdgpu: don't drop the gang dependency fence twice

Jiale Yao (3):
      hwmon: (aquacomputer_d5next) reject short status reports
      iio: adc: ad7192: reject devices without match data
      iio: dac: mcp4821: reject devices without match data

Jiaming Zhang (1):
      gfs2: reject invalid inode sizes

Jiangshan Yi (1):
      ceph: fix longname buffer overflow in ceph_fname_to_usr()

Jianyun Gao (1):
      xfs: fix temporary cursor leak in btree shift corruption paths

Jiayuan Chen (1):
      mm/memcontrol: fix data-race on reading jiffies_64

Jinjie Ruan (1):
      arm64: kexec_file: Fix elf_headers memory leak in retry loop

Jinmeng Zhou (1):
      mm/hugetlb: charge folios to the target mm's memcg

Jinwang Li (1):
      Bluetooth: L2CAP: Ignore connection responses with wrong ident

Jisheng Zhang (1):
      spi: cadence-xspi: group marvell support code together

Jose Maria Casanova Crespo (1):
      drm/v3d: Initialize timedout_batches when running a CSD job

Josef Bacik (14):
      tmpfs: keep the quota soft limits of an unused id
      tmpfs: preserve explicitly disabled quota limits
      mm/mglru: don't use stack pointers when walking PUD and PMD tables
      mm/memfd: make f_pos accesses atomic
      mm/filemap: don't lose a folio lock wakeup to a signal
      blk-mq: end the request if getting a keyslot fails
      mm/khugepaged: always recheck the pmd in try_collapse_pte_mapped_thp()
      mm/khugepaged: fix PMD table lock leak in try_collapse_pte_mapped_thp()
      mm/mmu_gather: fix flushing ranges with 4 GiB or larger
      mm/mmu_notifier: finish non-blocking interval invalidation on error
      mm/mremap: fix moving PUD leaves
      mm: fix unmap_mapping_range() beyond 4 GiB on 32-bit
      mm/hugetlb: unmap the page where the other VMA maps it
      mm/vma: don't leak the commit charge on mmap failure

Joseph Qi (5):
      ocfs2: find the xattr entry again after defragmenting a bucket
      ocfs2: find the xattr entry again after converting a block to a bucket
      ocfs2: do not read the entry array of an empty xattr bucket
      ocfs2: do not index before the entry array when dividing an empty bucket
      ocfs2: do not read the entry array of an empty xattr block

José Miguel Castellanos Valladolid (1):
      ALSA: hda/realtek: Enable mute LEDs on HP OmniBook X Flip 14-fm0xxx

Jouni Högander (5):
      drm/i915/psr: Clear selective fetch area when duplicating plane state
      drm/i915/display: Add enabled pipe planes into state for selective fetch
      drm/i915/psr: Disable linked plane sel fetch as well
      drm/i915/psr: Fix SFF and CFF CTL register bit definitions
      drm/i915/psr: Don't clip plane state destination rectangle

Jun Yang (1):
      sctp: re-point retained control chunks on association migration

Kaixuan Li (2):
      can: isotp: check the frame type, not just the length
      f2fs: bound the SIT/NAT bitmaps by the checkpoint pack

Karl Mehltretter (2):
      spi: atmel-quadspi: balance runtime PM and pclk across system sleep
      fbdev: sh_mobile_lcdcfb: Restore the per-overlay sysfs attributes

Kazuki Hanai (1):
      media: mediatek: jpeg: Avoid context access after job finish

Kenneth Feng (1):
      drm/amd/pm:restate all customized OD features on every table upload for smu 13.0.0/smu 14.0.2

Kiryl Shutsemau (Meta) (3):
      mm: page_alloc: make defrag_mode retries follow the promoted order
      arm64: sdei: Run the event handler on the kernel vectors
      arm64: sdei: Preserve the interrupted context's exception registers

Koichiro Den (1):
      PCI: endpoint: pci-epf-vntb: Manage virtual NTB and PCI bus lifetime

Krystian Kaniewski (1):
      blk-mq: fix out-of-bounds read in blk_mq_free_rqs

Kumari Pallavi (1):
      misc: fastrpc: Rename phys to dma_addr for clarity

Kyle Zeng (5):
      batman-adv: mcast: validate tracker padding before forwarding
      mm/khugepaged: flush deferred unmaps before dropping a failed folio
      net/sched: sch_qfq: prevent aggregate self-replacement
      mptcp: pm: kernel: use RCU to free endpoint listeners
      mm/page_vma_mapped: continue past nonmatching huge PMDs

Kylie C (1):
      drm/amd/display: Don't select zero V_TOTAL_MIN/MAX on seamless boot

Li RongQing (1):
      vfio/pci: Restore 8-byte ioeventfd support

Li Zhe (2):
      mm/hugetlb: fix mremap move length truncation
      mm/hugetlb: fix mremap deadlock when PMD sharing is possible

Linmao Li (1):
      PCI: cadence: Store the core controller in platform drvdata

Linus Torvalds (9):
      assoc_array: don't lose objects when a shortcut is split on a word boundary
      assoc_array: don't lose objects when a root shortcut is split at level 4
      assoc_array: move in-place insertion into a function of its own
      assoc_array: fill the segment cache in one place
      assoc_array: move node splitting into a function of its own
      assoc_array: move shortcut creation into a function of its own
      assoc_array: choose between splitting a node and a shortcut without gotos
      assoc_array: don't chain a new shortcut onto an existing one
      assoc_array: keep gc's cleanup out of the live tree on allocation failure

Liu Changjie (1):
      can: peak_usb: pcan_usb_fd_decode_buf(): accept short uCAN end-of-list records

Liz Fong-Jones (1):
      writeback: keep cleanup_offline_cgwb()'s scan out of syncs

Lorenzo Stoakes (ARM) (2):
      mm/vma: update VMA iterator state on error in new VMA merge
      mm/vma: avoid broken uffd merge on mremap

Lu Yao (1):
      drm/i915/gem: Reset err for each fence entry

Lucas Tanure (2):
      drm/vc4: hdmi: always cancel the scrambling work synchronously
      drm/vc4: hdmi: enable scrambling before the TMDS clock starts

Ma Ke (1):
      ALSA: hda: cs35l41: Fix ACPI device reference leak on probe failure

Marc Zyngier (2):
      KVM: arm64: nv: Move L2->L1 switch on interrupt early
      KVM: arm64: vgic: Stop the target vcpu when disabling LPIs

Marco Scardovi (1):
      platform/x86: asus-wmi: Serialize WMI method evaluations with a mutex

Marco Ziliani (1):
      ata: libata-pmp: disable the SEMB port on Marvell 88SM9705

Marek Vasut (1):
      PCI: rcar-gen4: Limit Max_Read_Request_Size to 256 Bytes

Mario Limonciello (1):
      platform/x86/amd/pmf: Add AMDI0112 ACPI ID

Martin Belanger (1):
      nvme-tcp: skip TLS control records while waiting for the ICResp

Martin Fuzzey (1):
      serial: sc16is7xx: fix data corruption due to unexpected xon/xoff

Masafumi Suzuki (1):
      sctp: account for chunk padding in sctp_init_cause()

Matej Sochan (1):
      ALSA: hda/realtek: Fix silent speakers on Lenovo Legion S7 15IMH05

Mateusz Guzik (4):
      fs: assert on ->i_count in iput_final()
      fs: add missing fences to I_NEW handling
      fs: spell out fenced ->i_state accesses with explicit smp_wmb/smp_rmb
      fs: provide accessors for ->i_state

Matheus Alves de Almeida (1):
      fat: hold truncate_lock in fat_write_failed()

Matthew Schwartz (1):
      drm/amd/display: Keep the nominal vtotal while VRR is inactive

Matthew Wilcox (Oracle) (2):
      filemap: Add folio_next_pos()
      xfs: Use folio_next_pos()

Matthias Goergens (4):
      udf: don't let the extent type hide an exhausted free-space table extent
      udf: check the unallocated space table when it is loaded
      udf: fix preallocation discarding before an empty allocation extent
      udf: don't use eloc after the end of the unallocated space table

Maxi Saparov (1):
      kho: do not reserve scratch memory in the kdump kernel

Maximilian Luz (1):
      hwmon: (nct6775) Add ASUS ROG STRIX X870E-H GAMING WIFI7

Maíra Canal (3):
      drm/vc4: Publish the output fence outside of job_lock
      drm/vc4: Drop the BO reservations outside of job_lock
      drm/v3d: Widen cache_clean_lock over the whole L2TCACTL sequence

Mehmet Fide (4):
      wifi: rtw88: usb: route bmc frames via the high queue only for DTIM delivery
      wifi: rtw88: usb: bound what the driver feeds the after-DTIM queue
      wifi: rtw88: usb: only let the frames a dozing station needs use the after-DTIM queue
      wifi: rtw88: widen the ATIM window while an AP interface is up

Michael Bommarito (1):
      9p/trans_virtio: reject mount tags longer than NAME_MAX at probe

Michael Chan (1):
      bnxt_en: Refactor some basic ring setup and adjustment logic

Michael Grzeschik (6):
      net/9p/usbg: also disable endpoints on p9_usbg_close
      net/9p/usbg: set client to Disconnected on usb9pfs_disable
      net/9p/usbg: always reset completion when disconnecting
      net/9p/usbg: call disable_usb9pfs() from usb9pfs_disable()
      net/9p/usbg: fix out_req buffer leak in disable_usb9pfs
      net/9p/usbg: remove bogus context initialization in alloc_requests

Michael McAllister (1):
      Bluetooth: qca: Fix the WCN3950 NVM baud rate offset

Michal Blaszczyk (1):
      sched_ext: Reset runnable_at when a task leaves its scheduler

Miguel Ojeda (1):
      rust: cpufreq: fix `undocumented_unsafe_blocks` in `PolicyCpu::from_cpu()`

Mike Rapoport (Microsoft) (2):
      mm/cma: accept memory of multi-range CMA areas
      mm/cma: accept memory of CMA areas reserved at a fixed address

Mike Snitzer (1):
      NFS/localio: detect a short read or write before the iterator has moved

Milan Milicevic (2):
      drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts for navi10_ih
      drm/amdgpu: publish IH enabled before PSP programs IH_RB_CNTL

Ming Lei (2):
      ublk: keep a canceled FETCH round canceling until the server is gone
      ublk: mark the io command cancelable before publishing it

Miquel Raynal (4):
      clk: nuvoton: ma35d1: Keep the clock count in the driver
      dt-bindings: clock: ma35d1: Drop CLK_MAX_IDX define
      dt-bindings: clock: ma35d1: Add missing WDT/WWDT parent clocks
      clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks

Misha Nasledov (1):
      drm/amd/display: Drop clock requirements on DCN32 when no displays are active

Mohamed Yassine Jebabli (1):
      ALSA: hda/tas2781: Only accept CRC-less V1 data if all entries are valid

Mohit Sharma (1):
      ASoC: qcom: q6apm: Guard callbacks until probe data is ready

Myeonghun Pak (3):
      ASoC: stm: stm32_i2s: request IRQ after regmap initialization
      mfd: twl-core: Unregister the auxiliary platform device on unbind
      fbdev: nvidia: Release write-combining handle on probe failure

Naman Jain (1):
      x86/init: Initialize wall clock in get_rtc_noop()

Nicholas Bonello (1):
      ALSA: hda/realtek: Fix Legion 7 16ITHG6 speaker amp binding

Nicholas Hobson (1):
      ALSA: usb-audio: keep MIDI input running for Roland TD-11

Nikolaos Karaolidis (2):
      fs: rotate inodes whose page cache could not be dropped
      fs: don't lose inodes that another LRU walker is isolating

Noam D. Eliyahu (1):
      tg3: Invert restart quirk logic to restrict SNP power-down bypass

Oliver Hartkopp (5):
      can: isotp: check the return values of can_rx_register() in isotp_bind()
      can: proc: skip stats calculation after reset in can_stat_update()
      can: replace ARPHRD_CAN type checks with can_get_ml_priv()
      can: protect the receive lists with a per-device lock
      can: raw, isotp: copy socket options outside of lock_sock()

Pan Chuang (1):
      iio: light: Remove redundant dev_err()/dev_err_probe()

Pankaj Raghav (1):
      iomap: use largest_zero_folio() in iomap_dio_zero()

Paulo Alcantara (2):
      smb: client: require stable pages for SMB compression
      smb: client: reclaim credits for decrypted reads with no matching mid

Peng Wang (1):
      tick/nohz: Reevaluate the tick for kicks flushed outside hardirq

Pengpeng Hou (1):
      media: require two-byte Cypress type 04 records

Peter Ujfalusi (3):
      ALSA: x86: hdmi: fix chmap array missing terminator entry
      ASoC: hdac_hda: Allocate the private data at codec driver bind
      ASoC: hdac_hda: Restore the codec device type on unbind

Ping-Ke Shih (1):
      wifi: rtw88: TX report with long timeout for non-PCIE devices

Prike Liang (1):
      drm/amdgpu: finish GPU recovery callbacks before restarting schedulers

Priyank Rathod (1):
      PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing

Qi Zheng (1):
      mm: memcontrol: refactor mod_memcg_state() and mod_memcg_lruvec_state()

Qihang (2):
      xfrm: interface: validate the IP header on xmit
      cipso: fix optlen corruption in cipso_v4_delopt()

Qiliang Yuan (2):
      srcu: Add list_splice_init_srcu()
      nvme: wait for SRCU readers before splicing the namespace list

Qingfang Deng (1):
      pppoe: delete session hash entries by pointer match

Ratnaker Gautam (2):
      smb: client: validate SMB1 EA list bounds before parsing
      smb: client: bound POSIX lock data area by response length

Ray Zhang (1):
      net: count last skb of each sk_backlog pass in __release_sock()

Reid Downing (1):
      xfs: fix wrong compat fields in xfs_ioctl32_bstat_copyin()

Ricardo Neri (1):
      hwmon: (coretemp) Return -ENODATA for invalid temperature readings

Ricardo Ribalda (2):
      media: uvcvideo: Add autosuspend quirk for AVerMedia Live Gamer HD 2
      media: uvcvideo: Force UVC version for Avermedia GC515

Ridham Khurana (1):
      hwmon: (lm70) Fix rounding of negative temperatures

Ridong Chen (2):
      mm/page_counter: avoid integer overflow in effective_protection()
      mm/mglru: fix ineffective memory protection for non-kswapd reclaim

Ritesh Harjani (IBM) (1):
      mm/huge_memory: set the mmu_gather page size in zap_huge_pud()

Robert Marko (2):
      spi: atmel-quadspi: add controller init callback
      spi: atmel-quadspi: use init callback for gclk variants

Roman Demidov (1):
      drm/amd/display: Fix NULL deref in dcn401_update_clocks_update_dtb_dto

Rong Zhang (2):
      platform/x86: Rename lenovo-wmi-capdata01 to lenovo-wmi-capdata
      platform/x86: lenovo-wmi-capdata: Do not stop the AC notifier chain on error

Rosen Penev (6):
      mtd: rawnand: ndfc: use ioread32be/iowrite32be and allow COMPILE_TEST
      mtd: rawnand: ndfc: fix gcc uninitialized var
      mtd: rawnand: ndfc: use devm_platform_ioremap_resource()
      net: bgmac: enable interrupts only after NAPI is ready
      drm/nouveau/nvkm: clear use.enabled when subdev init fails
      nvmem: rockchip-otp: alloc clks with main struct

Rudi Heitbaum (1):
      PCI: imx6: Avoid dereferencing a NULL clock name

Ruide Cao (1):
      mptcp: fix MP_CAPABLE token migration when cloning reqsk

Runyu Xiao (2):
      can: proc: reset pkg_stats atomics individually
      ALSA: usb-audio: Protect Roland control activation

Ruoyu Wang (1):
      media: adv748x: Fix endpoint reference leaks on probe failure

Rupesh Majhi (1):
      iio: pressure: dps310: fix CFG_REG bit definitions

Rámon van Raaij (1):
      ALSA: hda/realtek: Add codec SSID quirk for Lenovo Yoga Pro 9 16IMH9

SJ Park (7):
      mm/damon/core: skip applying scheme if region split for quota fails
      mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
      mm/damon/core: remove unreachable damos charge_{target,addr}_from
      mm/damon/core: filter out damos address filter-split failed region
      mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
      mm/damon/sysfs-schemes: hold damon_sysfs_lock in target_metric_store()
      mm/damon/core: move static variable last_nr_regions to damon_ctx

Sabrina Dubroca (1):
      xfrm: espintcp: reorder operations within espintcp_init_sk

Sahaj Chaudhari (1):
      gpio: pca953x: Preserve wakeup accounting on parent IRQ failure

Sakari Ailus (3):
      media: imx219: The horizontal blanking step is 8
      media: imx219: Account rate_factor in setting upper exposure limit
      media: imx219: Account for rate_factor in control steps

Samarth Narang (1):
      mm/ksm: keep soft-dirty when merging a page

Samiullah Khawaja (1):
      mm/gup: check folio->mapping under folio lock in memfd_pin_folios()

Sang-Heon Jeon (1):
      iio: light: isl29028: remove isl29028_set_pm_runtime_busy() helper

Sasha Levin (2):
      nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for KIOXIA XG10d
      Revert "hugetlb: remove VMEMMAP_SYNCHRONIZE_RCU"

Sean Christopherson (10):
      KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1 && EFER.LME=0
      KVM: Harden and prepare for modifying existing guest_memfd memslots
      KVM: Only bind memslot to guest_memfd instance for CREATE operations
      KVM: x86/mmu: Conditionally resched when retrying gPTE walk on A/D update failure
      KVM: x86: Conditionally resched when restarting REP string emulation
      KVM: nVMX: Process each host MSR entry at most once when unwinding failed VM-Entry
      KVM: x86/mmu: Cap number of parent PTEs per SP at 1000 (the arbitrary rmap limit)
      KVM: x86: Unconditionally reset MMU context when emulating INIT
      KVM: guest_memfd: Split bind() into prepare()+commit() phases
      KVM: guest_memfd: Establish memslot<=>guest_memfd bindings *after* memslot is ready

Sean Young (1):
      media: redrat3: Error path leaves device in transmitting state

Sehat Mahde (1):
      ASoC: amd: acp-config: force SoundWire probe on HP OmniBook X Flip 16

Sergey Bashirov (1):
      NFSD/blocklayout: Extract extent mapping from proc_layoutget

Shakeel Butt (1):
      io_uring/sqpoll: do the return-to-userspace work in the SQPOLL thread

Shang En Sim (2):
      io_uring/cancel: count all requests that a CANCEL_ALL cancels
      io_uring/poll: cancel all matching requests in one pass

Shao Mingyin (2):
      scsi: target: tcmu: Fix divide-by-zero in data_pages_per_blk store
      nvmet: bound the traddr and trsvcid configfs writes

Shivank Garg (1):
      KVM: guest_memfd: take the invalidate lock when unbinding a dying file

Shixiong Ou (1):
      fbdev: nvidia: Convert to managed PCI and ioremap API

Shuai Liu (1):
      io_uring/sqpoll: don't set IO_SQ_THREAD_SHOULD_STOP on thread exit

Shubham Antil (1):
      vhost-scsi: zero misaligned I/O bounce pages

Shuvam Pandey (1):
      lib/tests: extend cmdline KUnit with next_arg() tests

Sinan Turunc (4):
      ALSA: line6: Reject capture buffers smaller than two packets
      ALSA: usx2y: Require a buffer of two URBs
      ALSA: usx2y: Guard the playback copy
      ALSA: ua101: Bound packet copies by the PCM buffer size

Siwei Zhang (2):
      Bluetooth: L2CAP: Reject signalling responses in invalid states
      Bluetooth: L2CAP: Only accept connection responses to outstanding requests

Stanislaw Gruszka (1):
      wifi: mac80211: queue frames while off-channel

Stanley Jhu (3):
      scsi: ufs: bsg: Validate request_len before accessing request
      scsi: ufs: bsg: Reject UIC commands with a non-zero result byte
      scsi: ufs: core: Add a helper for clearing hba->outstanding_reqs

Steve Wahl (1):
      watchdog/hpwdt: Refine hpwdt message for UV platform

Sumit Kumar (1):
      PCI: dwc: Set DMA_BYPASS bit in outbound IATU CTRL2 register

Sung Byeongchan (1):
      virtiofs: validate fixed-output response length

Suravee Suthikulpanit (1):
      iommu/amd: Force device table to maximum size

Sven Eckelmann (10):
      batman-adv: dat: initialize orig_node of unfilled candidate slots
      batman-adv: fix skb leak when hard_iface is being released
      batman-adv: stop originator purge worker before freeing TT
      batman-adv: tpmeter: fix u32 truncation of reported bytes
      batman-adv: tt: only transmit local ROAM flag together with DEL
      batman-adv: tt: clear ROAM flag when re-adding a pending local client
      batman-adv: tt: send ROAM_ADV on each roamed back client
      batman-adv: tt: ignore ROAM flag of received ADD changes
      batman-adv: tt: only update flags for TT events
      batman-adv: tt: don't drop local events queued during TVLV update

Sven Püschel (1):
      media: rockchip: rga: use clk_bulk api

T.J. Mercier (1):
      mm: memcontrol: fix NULL pointer deref and UAF from high_work_func() on dying memcg

Takashi Iwai (1):
      ALSA: hda: cs35l41: Use auto-cleanup for put_device()

Tal Zussman (2):
      vhost-vdpa: fix pinned page leak in vhost_vdpa_pa_map() error path
      block: introduce bio_in_atomic()

Tarang Raval (3):
      media: i2c: imx219: Propagate errors from control range updates
      platform: int3472: discrete: Support multiple HIDs per GPIO map entry
      media: i2c: imx219: Replace exposure magic value with named constant

Tejun Heo (1):
      cgroup: Expose some cgroup helpers

Thomas Gleixner (1):
      posix-timers: Handle the timer_[re]arm() return value

Thomas Huth (1):
      smb: client: Avoid leaking sensitive data to the heap in connect.c

Thorsten Blum (4):
      hwrng: virtio - prevent use-after-free after a failed restore
      x86/boot: Fix off-by-one error in sme_clear_pgd()
      mfd: twl-core: Use i2c_check_functionality as boolean value
      crypto: omap - add omap_sham_unregister_algs helper

Tiezhu Yang (1):
      LoongArch: Fix one-shot limitation for perf hardware breakpoints

Til Kaiser (1):
      mlxsw: Initialize register query payloads

Tobias Schumacher (1):
      s390/pci: Add error cleanup in zpci_directed_irq_init()

Toke Høiland-Jørgensen (1):
      wifi: mac80211: reinstate IEEE80211_TX_CTL_AMPDU flag in ieee80211_tx_prep_agg()

Tom Verdonck (2):
      hwmon: (tmp102) Fix jiffies wraparound in conversion-ready check
      hwmon: (tmp108) Fix jiffies wraparound in conversion-ready check

Vaibhav Nagare (1):
      bnxt_en: don't leave an XDP program installed when the open fails

Valentin Kindschi (2):
      Bluetooth: hci_sync: re-enable legacy advertising on resume
      Bluetooth: hci_sync: pause advertising for the scan address update

Vas Zayarskiy (1):
      hwmon: (aquacomputer_d5next) Avoid truncating scaled sensor readings

Vidya Srinivas (1):
      drm/i915/display: Single scaler per pipe on WCL

Vishnu Reddy (2):
      media: iris: Fix iova allocation from restrict region
      media: iris: Fix power-off ordering to disable power domain after clocks

Vishnu Santhosh (1):
      dmaengine: qcom: bam_dma: Defer IRQ trigger type to device tree

Vladimir Zapolskiy (1):
      media: i2c: og01a1b: Switch from .s_stream to .enable_streams/.disable_streams

Vladyslav Tymoshchuk (1):
      ASoC: qcom: q6apm-dai: wrap the position of a full ring to 0

Wang Yan (1):
      selftests/landlock: Fix snprintf truncation checks in test files

Wei Wang (1):
      arm64: suspend: Save and restore TPIDR2_EL0 across CPU suspend

Wei-Lin Chang (1):
      KVM: arm64: ptdump: Check the page tables aren't freed when accessing

Weibin Liu (1):
      spi: cadence-xspi: reject SDMA transfers larger than the requested length

Weigang He (1):
      wifi: mac80211: reload TDLS header pointer after skb_linearize()

Wentao Liang (3):
      ALSA: caiaq: free the EP4 URB when input setup fails
      xen/gntdev: Fix gntdev_dmabuf ref leak in dmabuf_exp_wait_released()
      power: supply: ltc2941: Fix of_node reference leak in ltc294x_i2c_probe()

Xia Yan (2):
      veth: keep carrier off when resizing channels with a down peer
      ipv6: fix device binding after failed datagram connect

Xiaoyao Li (3):
      KVM: TDX: Stuff exit_reason with UNDEFINED on wait_for_sept_zap return
      KVM: TDX: Set bits 31:16 to 0 and use UNDEFINED when synthesizing exit reason
      KVM: TDX: Don't assume exit_reason[31:16] is all-0 in tdx_to_vmx_exit_reason()

Xuanqiang Luo (1):
      rculist: Add hlist_nulls_replace_rcu() and hlist_nulls_replace_init_rcu()

Yafang Shao (1):
      mm/migrate: snapshot the source nid before the misplaced migration

Yao Yiqi (1):
      fbcon: Retry rotated font allocation after failure

Ye Liu (1):
      mm: use enum migrate_reason instead of int for migration reason parameters

Yehyeong Lee (1):
      9p/xen: validate the response size from the backend

Yi Cong (1):
      wifi: mt76: mt792x: fix negative errno truncation in offload capability

Yifei Gao (2):
      9p/xen: fix refcount leak in p9_xen_response() on wrong tag
      misc: fastrpc: fix double-free in fastrpc_map_attach() error path

Yilin Zhang (1):
      mptcp: do not use Fast Open on MP_JOIN subflows

Yingjie Wang (6):
      scsi: handle out-of-range SG_SET_TIMEOUT values
      scsi: bsg: Report synchronous data copyback failures
      ipv6: reject wrapped temporary address preferred lifetimes
      nvmet: reject keep-alive timeouts that would overflow
      nvmet-tcp: validate the TLS handshake timeout
      nvme-tcp: validate the TLS handshake timeout

Yitang Yang (1):
      ublk: add missing DEL_DEV_ASYNC to unprivileged permission check

Yizhou Zhao (2):
      net/9p/usbg: fix prefix matching in device lookup
      net/9p/usbg: Fix use-after-free in disable_usb9pfs()

Yu Zhang (2):
      scsi: target: Fix demo-mode dynamic ACL dev-entry UAF vs LUN teardown
      ptp: fix use-after-free in extts_fifo_show() reading tsevqs unlocked

YuanZhe Liu (6):
      ALSA: us122l: Add missing NULL check in usb_stream_hwdep_mmap()
      ALSA: us122l: Fix NULL dereference at hwdep open and release
      ALSA: usx2y: Initialize idle URBs before submitting streams
      ALSA: hwdep: Serialize DSP load requests
      ALSA: bcd2000: Fix use-after-free of MIDI URBs on file close
      ALSA: usx2y: Refuse a retried DSP load after a failure

Yuanfu Xie (1):
      9p: don't decrement a server-owned zero nlink

Yuanhe Shu (1):
      scsi: target: Verify the iSCSI ISID is null-terminated

Yuansheng Yang (1):
      io_uring/rsrc: hold uring_lock across index-alloc put_user

Yuejie Shi (1):
      fs/ntfs3: validate the EA value length in ntfs_read_ea()

Yuho Choi (2):
      iommu/virtio: Reset device before deleting virtqueues on probe failure
      vdpa/snet: Don't discard the DPU error in snet_send_ctrl_msg()

Yun Zhou (1):
      net: erspan: set lltx to avoid sch_direct_xmit deadlock

Yunpeng Tian (1):
      udf: validate the device specification EA before using it

Yuto Ohnuki (1):
      virtiofs: add FUSE protocol validation

Zack Rusin (1):
      x86/vmware: Fix i386 high-bandwidth hypercall arguments

Zenghui Yu (Huawei) (1):
      mm/page_alloc: mark pages freed by __free_pages_core() as not tagged

ZhangGuoDong (2):
      smb: move smb_sockaddr_in and smb_sockaddr_in6 to common/smb2pdu.h
      smb: move some duplicate definitions to common/smb2pdu.h

Zhao Gongyi (2):
      arm64: mm: validate /dev/mem mmap ranges without overflow
      ata: libata-scsi: reject data-in commands with a data-out buffer

Zhao Zhang (1):
      9p: fix caches_show() out-of-bounds write

Zhaoyang Huang (1):
      mm: remove '!root_reclaim' checking in should_abort_scan()

Zhe Liu (1):
      blk-iocost: account flush sequence latency only once

Zhiling Zou (2):
      ipmr: drop packets with unknown ingress VIF
      ipmr: only copy pktinfo to cache reports

Zhou Qiuyue (1):
      ipv6: raw: fix use-after-free in rawv6_send_hdrinc()

Zijing Yin (1):
      wifi: cfg80211: fix out-of-bounds read in valid_rule()

bui duc phuc (2):
      ALSA: core: Clean up file_operations definitions
      ASoC: stm: stm32_i2s: Drop redundant error messages

chenglong.ma (1):
      vduse: fix VA/PA confusion in the coherent page fault path

guolingxing (1):
      btrfs: sysfs: restore NOFS context on early return in btrfs_sysfs_add_block_group_type()

renpanpan (1):
      drm/amdgpu: Only enable HDMI audio if display supports it

